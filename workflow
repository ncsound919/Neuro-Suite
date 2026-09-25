Below is the complete software workflow for the **Overlay365 Neuro State Engine**, detailing the step-by-step lifecycle of an imaging scan and clinical case through the **NTS Canonical Data Contract v0.1** architecture. 

This workflow details how raw data moves from hospital source systems through quality gating, scanner harmonization, spatial-radiation overlay, leakage-controlled model execution, and RANO 2.0 response state materialization.

---

### Software Architecture & Event Flow Map

```text
 ┌────────────────────────────────────────────────────────────────────────────────────────┐
 │ STAGE 1: INGESTION & INTEROPERABILITY PERIMETER                                        │
 │ PACS / VNA / EHR / LIS ──(DICOMweb / FHIR)──► Local Gateway (icobridge) ──► Event Store│
 └───────────────────────────────────────────┬────────────────────────────────────────────┘
                                             │ EVT-0192... (IMAGING_STUDY_INGESTED)
                                             ▼
 ┌────────────────────────────────────────────────────────────────────────────────────────┐
 │ STAGE 2: QUALITY CONTROL GATE & BITEMPORAL SNAPSHOTTING                                │
 │ DataQualityAssessment ──► BTIP Check ──► Quality Bounds / Constraints ──► Snapshot ID  │
 └───────────────────────────────────────────┬────────────────────────────────────────────┘
                                             │ NTS-SNAPSHOT-XXXXXX
                                             ▼
 ┌────────────────────────────────────────────────────────────────────────────────────────┐
 │ STAGE 3: PREPROCESSING, HARMONIZATION, & SEGMENTATION ADAPTER                         │
 │ Isotropic 1mm³ Resample ──► ComBat Harmonization ──► Deep Learning Masks (ET/TC/WT/Edema)│
 └───────────────────────────────────────────┬────────────────────────────────────────────┘
                                             │ Mask Arrays & Standardized Volumes
                                             ▼
 ┌────────────────────────────────────────────────────────────────────────────────────────┐
 │ STAGE 4: LESION GRAPH & SPATIAL-RADIATION OVERLAY                                      │
 │ Lesion Graph Engine ──► Relationship Edges (EVOLVED_FROM) ──► DICOM-RT Dose Overlay    │
 └───────────────────────────────────────────┬────────────────────────────────────────────┘
                                             │ LES- Identity + Radiation Volume Overlaps
                                             ▼
 ┌────────────────────────────────────────────────────────────────────────────────────────┐
 │ STAGE 5: FEATURE EXTRACTION & MULTI-MODAL STATE INTEGRATION                            │
 │ IBSI PyRadiomics ──► Shape Priority (Surface Area/Volume) ──► Molecular & EHR Context  │
 └───────────────────────────────────────────┬────────────────────────────────────────────┘
                                             │ GenomicObservations + Clinical Observations
                                             ▼
 ┌────────────────────────────────────────────────────────────────────────────────────────┐
 │ STAGE 6: TREATMENT-AWARE RESPONSE ENGINE (RANO 2.0)                                    │
 │ Post-RT Baseline ──► 12-Wk Confirmation Window ──► 2D SPPD / 3D SOV ──► Contradictions │
 └───────────────────────────────────────────┬────────────────────────────────────────────┘
                                             │ ResponseAssessment (RAS-0192...)
                                             ▼
 ┌────────────────────────────────────────────────────────────────────────────────────────┐
 │ STAGE 7: STATE MATERIALIZATION & CLINICAL HANDOFF                                      │
 │ NeuroTumorState View ──► 5-State Uncertainty ──► PACS Capture / Tumor Board / Trials   │
 └────────────────────────────────────────────────────────────────────────────────────────┘
```

---

### Step-by-Step Software Workflow Walkthrough

#### Stage 1: Ingestion & Interoperability Perimeter
1. **Data Ingestion**: When a new multi-parametric MRI (T1, T1ce, T2, FLAIR, DWI/ADC, Perfusion) or PET scan is completed, the hospital PACS/VNA automatically routes the DICOM series to an on-premise local integration gateway (such as `icobridge`).
2. **De-Identification & Boundary Mapping**: Incoming DICOM files are pseudonymized according to HIPAA/GDPR standards, keeping only essential demographics (birth year, sex). Source records are mapped across DICOMweb (PS3.18 2026d) and HL7 FHIR Genomics IG boundaries without overwriting native hospital source IDs.
3. **Event Emission**: The gateway issues an immutable, append-only event envelope (`EVT-UUIDv7`) with bitemporal timestamps (`effective_at` for scan time, `recorded_at` for ingestion time):
   ```json
   {
     "event_id": "EVT-01928f3a-7b2c-71a3-89ab-1234567890ab",
     "event_type": "IMAGING_STUDY_INGESTED",
     "entity_id": "IMG-01928f3a-...",
     "episode_id": "TEP-01928f3a-...",
     "effective_at": "2026-09-25T09:15:00Z",
     "recorded_at": "2026-09-25T09:17:22Z"
   }
   ```

---

#### Stage 2: Quality Control Gate & Bitemporal Snapshotting
1. **Automated Quality Audit**: A `DataQualityAssessment` engine evaluates:
   * **Completeness**: Validates sequence presence against the **Brain Tumor Imaging Protocol (BTIP)** (slice thickness \\(\le 1.5\text{ mm}\\) for T1ce, \\(\le 4\text{ mm}\\) for FLAIR).
   * **Acquisition Quality**: Checks ADC ranges in white matter (\\(0.4\text{--}1.0\,\mu\text{m}^2/\text{ms}\\)) and CSF (\\(2.5\text{--}4.0\,\mu\text{m}^2/\text{ms}\\)) to flag corrupted diffusion data.
   * **Comparability & Artifacts**: Evaluates motion, metal susceptibility, and field strength compatibility.
2. **Bounding Downstream Inference**: If quality is suboptimal (e.g., severe motion artifact on DCE perfusion), the quality object attaches a `LIMITS / CONDITIONS` constraint to the study. This prevents perfusion models from executing while preserving the raw scan record.
3. **State Snapshotting**: Creates an immutable snapshot identifier (`NTS-SNAPSHOT-000042`) locking the exact event graph state, ensuring that future model runs or clinical reviews remain 100% reproducible.

---

#### Stage 3: Preprocessing, Harmonization, & Segmentation Adapter
1. **Standardized Spatial Alignment**:
   * Brain Extraction Tooling removes non-brain tissue (scalp, skull, fat).
   * Multi-sequence registration to SRI24/MNI atlas space.
   * Resampling to isotropic \\(1\times 1\times 1\text{ mm}^3\\) voxel resolution.
2. **Scanner Harmonization (ComBat)**: Applies `neuroCombat` to harmonize voxel intensities and feature scales across heterogeneous 1.5T, 3T, and 7T scanners. Location and scale parameters are derived strictly from reference training cohorts to prevent data leakage.
3. **Segmentation Adapter**: The platform passes normalized volumes to an open segmentation adapter layer (supporting **nnU-Net**, **Raidionics**, **icobrain**, or **Neosoma**). This generates multi-compartment volumetric masks:
   * **ET**: Enhancing Tumor core.
   * **TC**: Tumor Core (enhancing + non-enhancing solid core).
   * **WT**: Whole Tumor (enhancing + core + peritumoral T2/FLAIR edema).

---

#### Stage 4: Lesion Graph & Spatial-Radiation Overlay
1. **Persistent Lesion Identity**: Rather than treating segmentations as isolated voxel blobs, the **Lesion Graph Engine** maps foci to persistent `Lesion` primitives (`LES-UUIDv7`).
2. **Graph Relationship Engine**: Computes directed edges between prior and current scans:
   * `EVOLVED_FROM`: Direct volumetric continuation.
   * `MERGED_WITH` / `SPLIT_FROM`: Complex morphological transitions.
   * `POSSIBLE_CONTINUATION_OF`: Probabilistic matching when spatial drift or surgical cavity collapse occurs.
3. **Radiation Dose Overlay**: Coregisters spatial tumor masks with treatment planning DICOM-RT dose grids (e.g., from RayStation or Brainlab Elements). It classifies each lesion spatially:
   * `WITHIN_DOSE_REGION`: Enhancement located inside the high-dose (\\(>60\text{ Gy}\\)) radiation field.
   * Field boundary vs. out-of-field enhancement.

---

#### Stage 5: Feature Extraction & Multi-Modal State Integration
1. **IBSI-Compliant Extraction**: Operates **PyRadiomics** over the segmented sub-regions to extract shape, first-order, and GLCM/GLRLM texture descriptors.
2. **Leakage-Controlled Feature Filtering**: Applies fold-specific variance filtering (\\(<0.01\\)) and correlation filtering (\\(|r| > 0.95\\)) inside outer training splits. Prioritizes highly reproducible shape features (**whole-tumor surface area** and **mesh volume**), which maintain 87% selection stability under nested cross-validation, while filtering uninformative texture descriptors.
3. **Ingestion of Biology & EHR Data**:
   * **Molecular Passport**: Computable `GenomicObservation` objects (HL7 FHIR mapped): IDH1/2 mutation status, MGMT promoter methylation, EGFR amplification, CDKN2A/B deletion.
   * **Clinical Context**: Ingests steroid dosage (dexamethasone tapering), Karnofsky Performance Status (KPS), NANO score, and time elapsed since radiotherapy completion.

---

#### Stage 6: Treatment-Aware Response Engine (RANO 2.0)
1. **RANO 2.0 Rule Module Execution**:
   * **Baseline Setting**: For newly diagnosed glioblastoma, sets the post-radiotherapy MRI (21–35 days post-RT) as the reference baseline, ignoring early post-surgical enhancement artifacts.
   * **Confirmation Window Logic**: If prospective enlargement occurs within 12 weeks of completing RT, designates the state as *preliminary Progressive Disease* and enforces a mandatory confirmation scan 4–8 weeks later before declaring true progression.
   * **IDH-Stratified Non-Enhancing Rules**: Excludes non-enhancing T2/FLAIR hyperintensity from target metrics in IDH-wildtype GBM (attributing it to vasogenic edema), but retains T2/FLAIR metrics for IDH-mutant lower-grade gliomas.
2. **Metric Calculations**: Computes bi-dimensional **2D SPPD** (Sum of Products of Perpendicular Diameters) and 3D **SOV** (Sum of Volumes) against baseline, prior scan, nadir, and *nadir after pseudoprogression*.
3. **Structured Contradiction Detection**: Triggers a `Contradiction` object if multimodal signals clash (e.g., `clinical_vs_imaging` contradiction when contrast volume increases by 24% while steroid dose drops by 50% and KPS remains stable).

---

#### Stage 7: State Materialization, Abstention, & Handoff
1. **State Materialization**: Compiles all verified assertions into the canonical **NeuroTumorState** view (`/v1/tumor-episodes/{id}/state`).
2. **Explicit 5-State Uncertainty**: Categorizes uncertainty into five non-interchangeable states (`DATA_UNKNOWN`, `DATA_CONFLICT`, `DATA_LOW_QUALITY`, `MODEL_UNCERTAIN`, `CLINICALLY_INDETERMINATE`), enabling model abstention when evidence is conflicting rather than forcing a black-box classification.
3. **Clinical Handoff & Secondary Capture**:
   * **PACS Return**: Exports DICOM Secondary Capture heatmaps, DICOM Structured Reports (SR), and encapsulated PDFs back to PACS/EHR via `icobridge`.
   * **Tumor Board Engine**: Generates automated case summaries with longitudinal trajectory charts, lesion evolution maps, and competing evidence ledgers.
   * **Trial Intelligence Engine**: Evaluates patient eligibility against clinical trial ontologies using deterministic rules over the materialized state.

---

💡 **Suggested Next Step**: Would you like to inspect the complete Python implementation for a specific stage—such as the **RANO 2.0 confirmation scan logic engine** or the **DICOM-RT spatial dose overlay module**?
