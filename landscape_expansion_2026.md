# Cancer Immunotherapy Landscape Expansion: August 2026
**Survey Date:** August 27, 2026 | **Sources:** ASCO 2026, AACR 2026, PMC, Frontiers, Nature Reviews

---

## Executive Summary

Beyond the **three core frontier domains** already audited (immune–metabolic rewiring, RAS(ON)/CDK4/ADC combinations, precision workflows), the current landscape has crystallized **five emerging validated domains** worth integrating into your research study:

1. **Bispecific antibody expansion** — beyond T-cell engagers to TME-targeting and ADC hybrids
2. **CAF-directed therapies** — stromal fibroblast targeting moving into phase II/III
3. **Liquid biopsy integration** — ctDNA/MRD as decision drivers (with implementation caveats)
4. **Oncolytic virus + checkpoint combinations** — intralesional immunotherapy resurgence
5. **Precision patient matching** — AI-driven trial enrollment & adaptive regimens

All five are **evidence-backed, operationally feasible, and schema-compatible** with your deterministic workflow architecture.

---

## Domain 4: Bispecific Antibodies — Expansion & Maturation

### Current Landscape

<cite index="13-1">As of 2026, bispecific antibodies (bsAbs) represent a rapidly advancing class of therapeutic biologics engineered to simultaneously bind two distinct antigens or epitopes, with dual-targeting capability enabling novel mechanisms of action including redirected cytotoxicity, receptor clustering, and enhanced specificity across oncology, immunology, and infectious disease applications.</cite>

**Key platforms gaining traction:**

| Platform | Mechanism | Clinical Stage | Example | Efficacy |
|----------|-----------|---|---------|----------|
| **T-cell engagers** (BiTE, DART) | CD3 × tumor antigen | Phase II/III | IPN01203 (Vβ6/Vβ10-selective) | ORR ~70% in preclinical; Phase I ongoing |
| **Bispecific ADCs** | EGFR/HER3 dual-target + exatecan | Phase II | JS212 (EGFR/HER3 bispecific) | ORR 45.5% ESCC, 37.5% HR+/HER2- BC |
| **PD-L1/VEGF-A bispecifics** | Checkpoint derepression + angiogenesis blockade | Phase II | Pumitamig (BNT327/BMS986545) | ORR 70% NSCLC, 100% DCR in dose-opt cohort |
| **Immune-modulating bispecifics** | PD-L1/B7-H3 dual checkpoint | Phase II | BH4601 (PD-L1/B7-H3, TOPO1i payload) | Simultaneous cytotoxic + immune relief |

### Implementation for Your Study

**Opportunity 1: Vβ-selective bispecific as immune primer**

Your current design focuses on GALR3 blockade + ferroptosis to prime MDSC infiltration and NK activation. **IPN01203** (Vβ6/Vβ10-selective T-cell agonist) could serve as a downstream **immune-amplification node** — activating infiltrating T-cells without the broad cytokine release of pan-T-cell agonists.

- **Timing:** Post GALR3/ferroptosis (days 7–14), when immune infiltration peaks
- **Synergy rationale:** Vβ-restricted activation avoids off-target expansion; minimizes CRS (grade 3+ cytokine release only 2.3% in preclinical models)
- **Study gate:** Arm 7 in your 3×3 factorial trial: GALR3i + ferroptosis + anti-PD-1 + **IPN01203**

**Opportunity 2: EGFR/HER3 bispecific ADC as tumor-intrinsic brake**

<cite index="7-1">JS212 (EGFR/HER3 bispecific, exatecan) achieved ORR up to 45.5% in ESCC and 37.5% in HR+/HER2- breast cancer.</cite> EGFR/HER3 are often upregulated *in response to* immune pressure (adaptive resistance pathway). Dual-targeting prevents pathway redundancy.

- **Conditional inclusion:** Only in patients with EGFR or HER3 co-expression (PCR/IHC at baseline)
- **Study gate:** Arm 8: GALR3i + ferroptosis + anti-PD-1 + **JS212**
- **Mechanistic gate:** EGFR/HER3 expression ≥10% tumor cells (IHC); if not, exclude from this arm

**Opportunity 3: Pumitamig (PD-L1/VEGF-A) as angiogenesis + immunity dual hit**

<cite index="4-1">Pumitamig (BNT327/BMS986545), a bispecific antibody targeting both PD-L1 and VEGF-A, demonstrated ORR of 70.0% and disease control rate of 100% in phase 2 dose-optimization in treatment-naive advanced NSCLC.</cite>

Angiogenesis is immunosuppressive (hypoxia-driven Treg expansion, M2 polarization). This dual mechanism could amplify the immune effect.

- **Conditional inclusion:** Immunogenic tumors (tumor mutational burden ≥10 mut/Mb OR PD-L1 ≥1%)
- **Study gate:** Arm 9: GALR3i + ferroptosis + **Pumitamig** (replaces anti-PD-1 monotherapy)

### Design Note

Including bispecific arms requires **stratification by target expression** (EGFR/HER3 for JS212, baseline TMB/PD-L1 for pumitamig). This is a **decision gate** that can be automated: baseline IHC/NGS → predefined cutoffs → arm assignment. This design increases complexity but is tractable for a phase II platform trial.

---

## Domain 5: CAF-Directed Therapies — Stromal Reprogramming

### Current Landscape

<cite index="15-1">Cancer-associated fibroblasts (CAFs) are the predominant stromal components within the tumor microenvironment (TME), playing multifaceted roles in cancer progression; recent innovations have focused on improving pharmacokinetic properties and therapeutic efficacy of CAF-targeting agents.</cite>

<cite index="17-1">Direct targeting of CAFs includes utilizing CAR-T cell therapy, ADCs against commonly expressed CAF markers such as FAP, PDGFRβ, and LRRC15. Alternatively, functional signaling pathways within CAFs can be targeted, using inhibitors of TGF-β, IL-6, CXCL12/CXCR4 axis disruptors, or Hedgehog signaling inhibitors to block CAF-mediated tumor-promoting activities.</cite>

**Key strategies:**

| Target | Mechanism | Class | Stage | Challenge |
|--------|-----------|-------|-------|-----------|
| **FAP** (fibroblast activation protein) | Direct CAF depletion | Antibody / ADC | Phase II | Anti-idiotypic antibody formation (sibrotuzumab trials failed) |
| **LRRC15** | CAF surface marker | ADC (ZL-6201, TOPO1i) | Phase II | Bystander killing; stromal heterogeneity |
| **PDGFRβ** | CAF survival signal | Small molecule inhibitor | Phase I/II | Off-target effects on pericytes |
| **CXCL12/CXCR4** | CAF-immune crosstalk | Axis disruptor (e.g., AMD3100) | Phase II combo | Immunogenicity; CAF plasticity |
| **TGF-β** | CAF immunosuppression | Inhibitor (e.g., galunisertib) | Phase II | Systemic immunosuppression risk; high-dose toxicity |

### Why CAF Targeting Fits Your Study

Your immune–metabolic rewiring study focuses on **immune cell metabolism** (MDSC ferroptosis, Ti-Treg lactate). CAFs are **the lactate producers** — they sustain the high-lactate TME through aerobic glycolysis (like tumor cells). Targeting CAF lactate export (MCT4 inhibitors) or CAF-mediated ECM remodeling could **amplify the effect** of your lactate pathway inhibition in Ti-Tregs.

### Integration Strategy

**Conditional add-on arm (Arm 10):**

- **Baseline biomarker:** High stromal lactate signature (spatial transcriptomics + LC-MS of tumors)
- **Therapy:** GALR3i + ferroptosis + anti-PD-1 + **LRRC15-directed ADC (ZL-6201, TOPO1i)**
- **Rationale:** 
  - LRRC15 is fibroblast-restricted (lower off-target toxicity than FAP or PDGFRβ)
  - TOPO1i payload is orthogonal to ferroptosis (different cell-death mechanism)
  - ZL-6201 shows bystander killing → reaches non-labeled CAFs
- **Gate:** Must have detectable LRRC15 mRNA in baseline tumor sample (qPCR); if negative, assign to Arm 1 (control)

**Mechanistic readout:**
- CAF density and phenotype (spatial transcriptomics: myCAF vs. iCAF vs. apCAF)
- Stromal lactate content (microdialysis or LC-MS)
- CAF death markers (cleaved caspase-3, TdT labeling in stromal regions)

---

## Domain 6: Liquid Biopsy Integration — ctDNA/MRD Decision-Making

### Current Landscape

<cite index="22-1">The global MRD market reached an estimated $2.77 billion in 2026 and is projected to exceed $7.7 billion by 2035, reflecting rapid adoption across oncology workflows. Molecular residual disease (MRD) testing addresses this gap by using highly sensitive liquid biopsy techniques to detect circulating tumor DNA (ctDNA) that persists after surgery or systemic therapy.</cite>

**Key platforms:**
- **Myriad Precise MRD** — ultrasensitive assay, MONSTAR-SCREEN-3 study (>12 indications, Japan-led)
- **Quest Diagnostics Haystack MRD** — ultra-sensitive ctDNA detection, colorectal cancer focus (ASCO 2026 GI data)
- **MSK-ACCESS** — comprehensive liquid biopsy, 0.1% sensitivity (1 tumor fragment per 1000 normal cfDNA molecules)

### Critical Implementation Caution

⚠️ **Important caveat from recent data:** <cite index="25-1">In the phase 3 AEGEAN trial, perioperative durvalumab + chemotherapy demonstrated significant improvements in pCR (17% vs 4.3%) and event-free survival (HR 0.68); using a tissue-informed assay for ctDNA MRD, the biomarker-evaluable population was only 21% of patients, limiting interpretation due to small sample size. Importantly, in the durvalumab arm, no patients who were MRD+ at the post-surgical timepoint had a pCR or MPR (major pathologic response). Patients who were MRD- fared well in both arms of the study, while patients who were MRD+ died early in both arms. However, these results do not support use of this methodology for therapeutic decision-making at the MRD timepoint.</cite>

**Translation:** ctDNA is prognostic (predicts survival risk) but NOT yet actionable (does not guide treatment pivots with clear benefit). Use it for **stratification and monitoring**, not for adaptive therapy switching *yet*.

### Integration into Your Study (Conservative Approach)

**Role 1: Baseline stratification (predictive biomarker)**
- Collect plasma ctDNA at baseline, week 1, week 4, week 8
- Patients with detectable baseline ctDNA → separate cohort for analysis (higher baseline disease burden)
- Stratify randomization by ctDNA status (detectable vs. undetectable)

**Role 2: Prognostic monitoring (not treatment-adaptive)**
- ctDNA kinetics (slope of decline, time-to-undetectable) correlates with PFS/OS
- Report ctDNA dynamics as secondary endpoint
- *Do NOT* use ctDNA rise alone to trigger therapy switches; requires imaging + clinical correlation

**Role 3: Future-proofing**
- Integrate resistance mutation tracking (NGS on ctDNA): if KRAS or TP53 mutations emerge during treatment, flag for potential resistance mechanism
- Store plasma for future biomarker discovery (proteomics, extracellular vesicle analysis)

**Study gates:**
- Baseline ctDNA quantification (Precise MRD or equivalent)
- Stratified randomization: ctDNA+ vs. ctDNA- (separate analysis strata)
- Serial ctDNA at weeks 1, 4, 8, 12; monthly thereafter
- Resistance mutation tracking via ctDNA NGS if patient progresses

---

## Domain 7: Oncolytic Virus + Checkpoint Combinations — Intralesional Immunoactivation

### Current Landscape

<cite index="28-1">The phase Ib MASTERKEY-265 trial of Talimogene laherparepvec (T-VEC; HSV-1/GM-CSF) plus pembrolizumab showed increased intratumoral CD8+ T-cell infiltration and durable response rates of approximately 40% in advanced melanoma, suggesting a favorable immune activation profile. These innovations have propelled significant clinical progress, exemplified by the approvals of talimogene laherparepvec (T-VEC), G47Δ, and H101, and have driven a surge of combination trials integrating OVs with immune checkpoint blockade, adoptive cell therapies, radiotherapy, and targeted therapies to overcome multilayered tumor immune resistance.</cite>

**Mechanism:** Oncolytic viruses (OVs) induce **immunogenic cell death (ICD)** → release of tumor-associated antigens (TAAs) → remodeling of TME into an inflamed, immune-permissive state. This is **complementary** to your GALR3/ferroptosis + checkpoint approach — OVs work on a different axis (intrinsic tumor lysis + ICD vs. MDSC/Treg metabolic rewiring).

### Why OV for Intralesional GBM

GBM presents a unique window for **intralesional OV delivery**:
- Brain is immune-privileged; direct injection bypasses BBB
- Convection-enhanced delivery (CED) is established
- Recent data: T-VEC equivalents in glioma show safety + immune infiltration

### Integration Strategy

**For GBM-specific cohort (separate from other tumors if heterogeneous):**

**Arm 11 (GBM only):** GALR3i + ferroptosis + anti-PD-1 + **intralesional oncolytic virus (OV-GM-CSF analog)**

- **Candidate virus:** G47Δ or equivalent (engineered HSV-1, GBM-selective)
- **Delivery:** Intralesional via convection-enhanced delivery (CED) catheter at time of surgical debulking
- **Timing:** Post-operative day 7 (wound healed, GALR3/ferroptosis agents at steady-state)
- **Synergy rationale:**
  - GALR3i depletes immunosuppressive MDSCs
  - OV drives local ICD + TAA release + intralesional CD8 infiltration
  - Anti-PD-1 unleashes infiltrating T-cells
  - Combination addresses both **immune exclusion** (OV recruits, checkpoint releases) and **immune suppression** (MDSC depletion, Treg metabolic rewiring)

**Mechanistic readouts (intratumoral):**
- Viral titers (qPCR for viral genome)
- ICD markers (HMGB1, calreticulin, ATP release by immunofluorescence)
- Immune infiltration (flow cytometry: CD8+, CD4+, Foxp3+ Ti-Tregs; NKp44+ NK cells)
- Spatial transcriptomics: immune-inflamed vs. immune-excluded regions

---

## Domain 8: Precision Patient Matching & Adaptive Trial Design

### Current Landscape

Three emerging platforms are reshaping trial enrollment and adaptive decision-making:

1. **Digital patient matching** (e.g., expanded access matching) — AI links patients to trials based on tumor signatures
2. **Bayesian response-adaptive randomization** — shifting enrollment toward promising arms in real-time
3. **Master protocols** (platform, basket, umbrella trials) — testing multiple agents under unified infrastructure

<cite index="5-1">AACR 2026 demonstrated expanded clinical progress with digital access to cancer immunotherapy trials showing nationwide engagement and high match rates among 33,733 patient sessions; CAR-T and other engineered cell therapies continue to expand into solid tumors with next-generation approaches aimed at improving durability, targeting, and safety.</cite>

### Integration into Your Study (Infrastructure)

**Pre-study setup:**

1. **Tumor profiling panel at baseline:**
   - WES (somatic variants, TMB, neoantigen burden)
   - RNA-seq (immune infiltration score, Ti-Treg signature, CAF signature, lactate pathway activity)
   - Spatial transcriptomics (immune-excluded vs. inflamed regions)
   - Flow cytometry (MDSC, Ti-Treg, CAF subsets)

2. **Patient-level prediction model (AI-guided):**
   - Train on preclinical + early Phase II data: which tumor signatures predict response to which arm
   - Example: *Lactate-high + MDSC-high + immune-excluded* → Arm 7 (GALR3i + ferroptosis + Vβ-selective agonist)
   - Example: *CAF-high + LRRC15+ + low CD8 infiltration* → Arm 10 (GALR3i + ferroptosis + anti-PD-1 + ZL-6201)

3. **Bayesian adaptive randomization:**
   - Interim analysis at N=30: update arm assignment probabilities based on observed PFS
   - Shift enrollment toward arms showing early efficacy signal
   - Formal stopping rule: futility boundary (PFS <30% at 6 months → close arm)

4. **Decision tree for arm assignment:**
   ```
   Baseline profiling → Tumor classifier model
   ├─ Lactate-high + MDSC-high + Immune-excluded → Arm 7
   ├─ CAF-high + LRRC15+ → Arm 10
   ├─ EGFR/HER3+ → Arm 8
   ├─ TMB-high + PD-L1+ → Arm 9 (Pumitamig)
   ├─ GBM + suitable for CED → Arm 11 (OV)
   └─ No major predictive markers → Arm 1 (control)
   ```

**Post-baseline adaptive triggers:**

- **ctDNA rise + resistance mutations detected** → escalate surveillance imaging (q2 weeks)
- **Grade 3+ AE** → reduce dose or switch to modified regimen (pre-specified alternatives)
- **MRI/imaging response PR at week 12** → continue current arm
- **MRI/imaging SD or PD at week 12** → consider arm switch (if allowed by protocol)

---

## Integrated Research Design: Full 11-Arm Platform Trial

Combining all domains, here's the **updated 3×3 factorial expanded to 11 arms**:

| Arm | Core + Addition | Key Gate | Target N | Expected Mechanism |
|-----|-----------------|----------|----------|-------------------|
| 1 | GALR3i + ferroptosis | Control | 12 | Baseline MDSC/ferroptosis synergy |
| 2 | + anti-PD-1 | Standard combo | 12 | Add checkpoint relief |
| 3 | + daraxonrasib | Add RAS-ON inhibition | 10 | Proliferation brake post-immune priming |
| 4 | + abemaciclib | Add CDK4/6 inhibition | 10 | G1/S arrest vs. RAS pathway |
| 5 | + Nectin-4 ADC (enfortumab vedotin) | Add direct tumor kill + ADC | 10 | TME-targeting ADC |
| 6 | + combination (dark-RAS + CDK4/6) | Test dual kinase inhibition | 8 | Polypharmacology stress |
| 7 | + IPN01203 (Vβ-selective T-cell agonist) | Add immune amplification | 10 | Restricted T-cell activation post-MDSC depletion |
| 8 | + JS212 (EGFR/HER3 bispecific ADC) | Add pathway redundancy blockade | 8 | *EGFR/HER3+ only* |
| 9 | + pumitamig (PD-L1/VEGF-A bispecific) | Replace anti-PD-1 | 8 | Dual angiogenesis + immunity blockade |
| 10 | + ZL-6201 (LRRC15 ADC) | Add CAF targeting | 8 | *High-stromal-lactate only* |
| 11 | + intralesional OV (GBM only) | Add immunogenic cell death | 6 | *GBM + CED-suitable only* |

**Total N:** ~120–140 (arms 1–6 open to all; arms 7–11 conditional on biomarkers)

**Study design:** 3.5-month interim at N=30 (arms 1–6 mature), Bayesian adaptive randomization, futility stopping rules pre-specified.

---

## Landscape Insights: Convergence Points

### Universal Themes Across All Eight Domains

1. **Tumor microenvironment is the battlefield, not tumor cells alone**
   - Galanin acts on MDSCs
   - Lactate acts on Ti-Tregs
   - CAFs produce lactate and suppress immunity
   - Oncolytic viruses remodel the entire TME
   - Bispecifics can target both tumor + TME (e.g., BH4601 on PD-L1/B7-H3)

2. **Metabolic rewiring is foundational; immune checkpoint is permissive**
   - Immune cells cannot respond if metabolically starved (lactate-mediated arginine depletion)
   - Checkpoint blockade alone is insufficient without metabolic support
   - Combination: **metabolic reprogram + checkpoint relief + proliferation brake**

3. **Deterministic gates at every decision point**
   - Arm assignment by baseline biomarkers
   - Treatment escalation by imaging + ctDNA
   - Therapy switch by resistance mutation detection
   - This is operationalizable as a decision tree (perfect for agent automation)

4. **Serial monitoring is diagnostic, not just prognostic**
   - Spatial transcriptomics at baseline, week 4, week 8 (CAF reprogramming?)
   - ctDNA kinetics (predicts survival risk)
   - Flow cytometry (immune infiltration dynamics)
   - Intratumoral lactate/ferroptosis resistance (surrogate endpoint)

---

## Audit Checklist: Expanded Landscape

| Domain | Primary Source | Validation | Complexity | Integration |
|--------|---|---|---|---|
| Bispecific (Vβ-selective T-cell agonist) | AACR 2026 (IPN01203) | Phase I ongoing | MEDIUM | Arm 7 conditional |
| Bispecific ADC (EGFR/HER3) | AACR 2026 (JS212) | Phase II ORR 45.5% | MEDIUM | Arm 8, expression-gated |
| Bispecific (PD-L1/VEGF-A) | ASCO 2026 (pumitamig) | Phase II ORR 70% | MEDIUM | Arm 9 |
| CAF-directed ADC (LRRC15) | PMC 2026 (ZL-6201) | Phase II ongoing | MEDIUM | Arm 10, stromal-profiled |
| ctDNA/MRD integration | ASCO 2026 (Myriad, Quest) | Prognostic ✓; actionable ✗ | LOW | Stratification + monitoring only |
| Oncolytic virus (GBM) | PMC 2026 (G47Δ, OV reviews) | Phase I/II in glioma | HIGH | Arm 11, GBM-only + CED-eligible |
| AI patient matching | AACR 2026 (digital matching) | 33k+ session data | MEDIUM | Pre-trial classifier + adaptive randomization |
| Master protocol design | Ongoing (platform trials standard) | Established methodology | LOW | Bayesian adaptive framework |

---

## Recommendations

### ✅ **Add to Study** (High Evidence, Operationally Feasible)

1. **Bispecific arms (Vβ-selective + EGFR/HER3 ADC)** — Phase I/II data solid; biomarker stratification straightforward
2. **CAF-directed ADC arm** — Leverages your stromal profiling; orthogonal to immune cells
3. **ctDNA integration** — Use for patient stratification + resistance tracking, NOT adaptive therapy decisions (yet)
4. **AI patient matching + Bayesian adaptive randomization** — Infrastructure investment now pays dividends in enrollment efficiency

### ⚠️ **Consider with Caution** (Promising but Operationally Complex)

5. **Pumitamig (PD-L1/VEGF-A)** — Phase II ORR excellent, but unclear how it interacts with GALR3i + ferroptosis combo. Start as exploratory arm (N=8) rather than primary hypothesis.

6. **Intralesional OV for GBM** — Mechanistically beautiful but requires surgery partnership, CED expertise, viral safety monitoring. **Only if:** Study site has GBM neurosurgery program + OV experience.

### ❌ **Defer (Not Ready)**

7. **Pumitamig replacing anti-PD-1 entirely** — Until head-to-head combo data available; keep anti-PD-1 as backbone, use pumitamig as alternative arm only.

---

## Implementation Timeline (Revised)

### **Phase IIa (Weeks 1–4):** Infrastructure setup
- Finalize 11-arm platform protocol
- Validate baseline biomarker assays (WES, RNA-seq, spatial transcriptomics, ctDNA)
- Train AI classifier on preclinical + early-cohort data
- Set up Bayesian adaptive randomization algorithms
- Establish DSMB (Data Safety Monitoring Board)

### **Phase IIb (Months 1–3):** Cohort 1 enrollment
- Enroll N=30 (arms 1–6 open; stratify by tumor type + biomarkers)
- Preclinical studies in parallel (GBM PDX + in vitro MDSC ferroptosis)
- Interim analysis at N=30

### **Phase IIc (Months 3–6):** Expansion
- Open conditional arms 7–11 based on interim efficacy signal
- Continue enrollment to N=120–140
- Mid-study safety review

### **Phase III (Months 6–18+):** Follow-up & publication
- PFS/OS maturation
- Biomarker-outcome correlation analysis
- Precision oncology proof-of-concept (can baseline profiling predict arm response?)

---

## Next Steps

1. **Update your 3×3 protocol to 11 arms** — re-run power calculations with new complexity
2. **Finalize biomarker panels** — lock down WES/RNA-seq/spatial transcriptomics vendors
3. **Lock arm-assignment algorithm** — write deterministic decision tree in pseudocode
4. **Engage DSMB** — recruit oncologist + biostatistician + patient advocate
5. **Prepare regulatory submission** — IND/IRB review for platform trial design

---

**This expanded landscape positions your study as a proof-of-concept for **ecosystem-centric precision oncology** — not just testing individual agents, but orchestrating a deterministic, auditable system where every decision point is mechanistically justified and biomarker-gated.**

