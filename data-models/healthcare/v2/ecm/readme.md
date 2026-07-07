# Healthcare Lakehouse Data Model

**v2_ecm** generated using Vibe Modelling Agent on July 02, 2026 at 06:07 AM

This document outlines a vibed Lakehouse data model for the Healthcare business that can be deployed to Databricks Platform. The model is structured into business-aligned domains and denormalized data products, optimized for analytical workloads.

## Table of Contents

- [Output Folder Structure](#output-folder-structure)
- [Model Metrics](#model-metrics)
- [Business Summary](#business-summary)
- [Business Domains & Subdomains](#business-domains--subdomains)
  - [Clinical](#domain-clinical)
  - [Consent](#domain-consent)
  - [Encounter](#domain-encounter)
  - [Facility](#domain-facility)
  - [Interoperability](#domain-interoperability)
  - [Laboratory](#domain-laboratory)
  - [Order](#domain-order)
  - [Pharmacy](#domain-pharmacy)
  - [Radiology](#domain-radiology)
  - [Reference](#domain-reference)
  - [Scheduling](#domain-scheduling)
  - [Supply](#domain-supply)
  - [Billing](#domain-billing)
  - [Claim](#domain-claim)
  - [Insurance](#domain-insurance)
  - [Patient](#domain-patient)
  - [Provider](#domain-provider)
  - [Compliance](#domain-compliance)
  - [Finance](#domain-finance)
  - [Quality](#domain-quality)
  - [Research](#domain-research)
  - [Workforce](#domain-workforce)
  - [Behavioral_health](#domain-behavioral_health)
  - [Clinical_ai](#domain-clinical_ai)
  - [Digital_health](#domain-digital_health)
  - [Genomics](#domain-genomics)
  - [Population_health](#domain-population_health)
  - [Post_acute](#domain-post_acute)
- [Metric Views](#metric-views)

## Output Folder Structure

All artifacts for version **v2_ecm** are organized as follows:

```
v2/ecm/
  schemas/          DDL SQL files (one per domain)
  metrics/          Metric view SQL files (one per domain)
  samples/          Sample data CSV files (one per data product)
  docs/             Excel workbook, model CSV, release notes
  diagram/          DBML schema
  vibes/            Current & next vibes context
  ontology/         RDF/Turtle ontology schema
  model.json        Full model with requirements, metadata, and model data
  readme.md         This file
```

| Folder | Contents |
|---|---|
| `schemas/` | `healthcare_<domain>_schema_v2_ecm.sql` (combined per-domain SQL: schemas/databases + tables with inline PKs + FKs + tags) |
| `schemas/` | `healthcare_catalogs_v2_ecm.sql` (catalog-level DDL) |
| `metrics/` | `healthcare_<domain>_metrics_v2_ecm.sql` (one file per domain) |
| `docs/` | `healthcare_model_v2_ecm.xlsx`, `healthcare_model_v2_ecm.csv`, `releasenotes.txt` |
| `diagram/` | `healthcare_dbml_v2_ecm.dbml` |
| `vibes/` | `current_vibes.txt`, `next_vibes.txt` |
| `/` | `model.json` (full model with requirements, metadata, and model data) |
| `ontology/` | `healthcare_rdf_v2_ecm.rdf` |
| `samples/` | One CSV file per data product (e.g., `customer.csv`, `order.csv`) |

## Model Metrics
| Metric | Value |
|---|---|
| Model Scope | ECM (Expanded Coverage Model) |
| Total Domains | 28 |
| Total Subdomains | 96 |
| Total Products | 588 |
| Total Attributes | 26051 |
| Primary Keys | 587 |
| Foreign Keys | 4024 |
| Avg Attributes/Product | 44.3 |
| Metric Views | 326 |

## Business Summary
| Business | Industry Alignment | Model Scope | Description | References | Version |
|---|---|---|---|---|---|
| Healthcare | healthcare | ECM (Expanded Coverage Model) | Healthcare is a vast industry operating hospitals, clinics, outpatient facilities, and integrated care systems, delivering patient care, medical research, diagnostics, and health education across diverse populations and regions. | Centers for Medicare and Medicaid Services (CMS), U.S. Department of Health and Human Services (HHS), Office for Civil Rights (OCR) — HIPAA Enforcement, The Joint Commission (TJC) — Hospital Accreditation, Office of Inspector General (OIG) — Fraud and Abuse, Food and Drug Administration (FDA) — Drugs and Devices, Agency for Healthcare Research and Quality (AHRQ), National Committee for Quality Assurance (NCQA), Health Level Seven International (HL7) — Interoperability Standards, American Medical Association (AMA) — CPT Coding Standards, World Health Organization (WHO) — ICD Classification, Occupational Safety and Health Administration (OSHA) — Workplace Safety, Drug Enforcement Administration (DEA) — Controlled Substances, State Departments of Health — Facility Licensing, ISO 27001 — Information Security Management, SOC 2 — Service Organization Controls, HITRUST CSF — Health Information Trust Alliance Common Security Framework, NIST Cybersecurity Framework, PCI DSS — Payment Card Industry Data Security Standard (for patient payment processing), GAAP and FASB — Financial Reporting Standards | 2 |

## Business Domains & Subdomains

<a id="domain-clinical"></a>

### Domain: Clinical

| Domain | Division | Total Subdomains | Description | Total Products |
|---|---|---|---|---|
| clinical | operations | 4 | Comprehensive clinical documentation and care delivery data. Owns diagnoses (ICD-10), procedures (CPT, HCPCS), clinical notes, problem lists, allergies, immunizations, vital signs, care plans, assessments, nursing documentation, clinical observations (LOINC-coded), SNOMED CT-coded clinical findings, and CDI (Clinical Documentation Improvement) workflows. Core EHR/EMR operational data. | 25 |

**Subdomains:** care_planning, clinical_documentation, infection_surveillance, patient_assessment


**List of Data Products**

| Subdomain | Product | Data Type | Description | Total Attributes |
|---|---|---|---|---|
| care_planning | advance_directive | master_data | Patient advance directive and end-of-life care preference documentation including DNR (Do Not Resuscitate) orders, POLST/MOLST (Physician/Medical Orders for Life-Sustaining Treatment), living wills, healthcare power of attorney designations, and code status (Full Code, DNR, DNR/DNI, Comfort Care). Captures directive type, effective date, expiration date, document status (active, revoked, superseded), healthcare proxy name and contact information, verification method, and the provider who documented or verified the directive. Critical for end-of-life care decisions, EMTALA compliance, and patient rights under the Patient Self-Determination Act. Sourced from Epic advance care planning module. | 73 |
| care_planning | care_plan | master_data | Patient-centered care plans documenting clinical goals, interventions, and expected outcomes across the care continuum. Captures care plan type (inpatient, outpatient, chronic disease, discharge, transitional), status (draft, active, completed, revoked), effective date range, care setting, authoring provider, care team assignment, patient goals with individual lifecycle tracking, clinical problems addressed, and care plan category (SNOMED CT coded). Includes embedded care plan goals as detail records: goal description, SNOMED CT coded goal category, target measure (LOINC coded), target value, target date, achievement status (proposed, accepted, in-progress, achieved, cancelled), priority, and responsible provider. Supports transitions of care, population health management, ACO care coordination, and CMS Conditions of Participation for discharge planning. Sourced from Epic Healthy Planet and Cerner. | 68 |
| care_planning | care_plan_goal | transactional_data | Individual clinical goals within a care plan, each with its own lifecycle, target values, and achievement status. Captures goal description, SNOMED CT coded goal category, target measure (LOINC coded), target value, target date, current status (proposed, accepted, in-progress, achieved, cancelled), priority, and the provider responsible for the goal. Enables granular tracking of patient progress toward clinical objectives. Sourced from Epic Healthy Planet. | 67 |
| care_planning | care_team | master_data | Clinical care team assignments for patients, documenting which providers are responsible for a patient's care in a given context. Captures care team type (inpatient, outpatient, primary, specialty, multidisciplinary), team status, assignment dates, and individual member detail records: member type (physician, NP, PA, RN, social worker, pharmacist, care coordinator), role code, on-call flag, primary contact flag, participation start/end dates, and active status. Members are modeled as line items within the care team — each with their own assignment lifecycle but always in the context of a parent team. Distinct from workforce scheduling — this is the clinical accountability record. Enables care coordination queries, transitions of care documentation, and care plan team assignment. Sourced from Epic and Cerner care team modules. | 64 |
| care_planning | care_team_member | master_data | Individual provider membership records within a care team, capturing the specific role, period of responsibility, and participation status of each clinician. Includes member type (physician, NP, PA, RN, social worker, pharmacist, care coordinator), role code, on-call flag, primary contact flag, and assignment dates. Enables care coordination queries and transitions of care documentation. Sourced from Epic and Cerner. | 60 |
| care_planning | plan_care_coordination | association_data | This association product represents the enrollment and coordination relationship between a patient's care plan and the health insurance plan(s) covering that care. It captures payer-specific care management requirements, authorization status, and program participation for each care plan-health plan combination. Each record links one care plan to one health plan with attributes that exist only in the context of this payer-specific care coordination relationship.. Existence Justification: In healthcare operations, a single care plan frequently requires coordination with multiple health insurance plans when patients have dual coverage (Medicare + Medicaid, primary + secondary insurance, or Medicare Advantage + supplemental). Each health plan imposes distinct care management requirements, authorization processes, quality measures, and program enrollment criteria for the same underlying care plan. Conversely, a health plan's care management program tracks multiple care plans across its member population. Care coordinators actively manage these plan-specific coordination records, updating authorization status, program enrollment, and payer-specific goals as part of operational care delivery workflows. | 52 |
| clinical_documentation | cdi_query | transactional_data | SSOT for all Clinical Documentation Improvement (CDI) activities including encounter-level review worksheets and provider queries. Models the full CDI review lifecycle: encounter review worksheets (review date, CDI specialist, encounter type, working DRG, final DRG, CC/MCC capture status, documentation gaps identified, query opportunity flags, review outcome) and individual queries issued to providers (query type — compliant/leading/multiple choice, query status — open/answered/expired/withdrawn, queried provider, associated diagnosis, expected DRG impact, query outcome). Tracks CDI program performance metrics including query response rates, DRG change rates, and revenue impact. Sourced from 3M Health Information Systems CDI module and Epic CDI workflows. Critical for accurate DRG assignment, reimbursement optimization, and revenue integrity. | 75 |
| clinical_documentation | cdi_worksheet | transactional_data | CDI specialist review worksheets documenting the clinical documentation review process for an encounter. Captures review date, CDI specialist, encounter type, working DRG (before CDI), final DRG (after CDI), CC/MCC capture status, query opportunity flags, documentation gaps identified, and review outcome. Supports CDI program performance tracking and revenue integrity. Sourced from 3M Health Information Systems. | 67 |
| clinical_documentation | clinical_finding | transactional_data | SSOT resolved: defer to radiology.radiology_finding as the single source of truth for this concept. This table is a domain-specific extension/reference. | 95 |
| clinical_documentation | diagnosis | transactional_data | SSOT for all patient diagnoses documented in the EHR. Captures ICD-10-CM coded diagnoses, diagnosis type (principal, secondary, admitting, discharge), onset date, resolution date, clinical status (active, resolved, chronic), severity, certainty (confirmed, suspected, rule-out), and the encounter or problem list context. Sourced from Epic ClinDoc and Cerner PowerChart. Supports CDI workflows, DRG assignment, and quality reporting. | 68 |
| clinical_documentation | note | transactional_data | Structured and unstructured clinical documentation authored by providers in the EHR. Includes note type (H&P, progress note, discharge summary, operative note, consult note, nursing note), author, co-signer, note status (draft, signed, amended, addended), service date, encounter context, LOINC document type code, and full note text or structured content reference. Sourced from Epic ClinDoc and Cerner PowerChart. Core to CDI and HIM workflows. | 65 |
| clinical_documentation | note_template | master_data | Master reference table for note_template. Referenced by template_id. | 68 |
| clinical_documentation | procedure_event | transactional_data | Records of clinical procedures performed on patients, coded using CPT, HCPCS, and ICD-10-PCS. Captures procedure date/time, performing provider, facility location, laterality, approach, anesthesia type, duration, status (performed, cancelled, in-progress), and associated encounter. Sourced from Epic OpTime, ClinDoc, and Cerner SurgiNet. Supports revenue cycle charge capture and quality measurement. | 73 |
| infection_surveillance | hai_event | transactional_data | Healthcare-Associated Infection (HAI) surveillance event records tracking CLABSI, CAUTI, SSI, MRSA, C. difficile, and VAP events per NHSN (National Healthcare Safety Network) definitions. Captures infection type, NHSN definition criteria met, event date, device days, patient days, unit/location, causative organism, antibiotic susceptibility, linked procedure (for SSI), infection preventionist review status, and reporting status. Sourced from Epic infection control modules and dedicated surveillance systems (e.g., Theradoc, ICNet). Required for CMS HAI reporting, VBP penalty calculations, and state mandatory reporting. Domain ownership note: clinical domain owns the HAI event as a clinical occurrence; quality domain owns the aggregate surveillance metrics and benchmarking — global architect should confirm this boundary. | 77 |
| infection_surveillance | outbreak | master_data | Master reference table for outbreak. Referenced by outbreak_id. | 70 |
| infection_surveillance | procedure_equipment_usage | association_data | This association product represents the operational usage event between a clinical procedure and a specific equipment asset. It captures the actual deployment and utilization of biomedical equipment during surgical and interventional procedures. Each record links one procedure_event to one equipment_asset with timestamps, sterilization tracking, implant traceability, and malfunction reporting that exist only in the context of this specific usage instance. Supports OR utilization analytics, biomedical engineering maintenance correlation, FDA device event reporting (MDR), and TJC equipment management compliance.. Existence Justification: In healthcare operations, surgical and interventional procedures routinely deploy multiple equipment assets simultaneously (surgical table, anesthesia machine, robotic system, imaging equipment, infusion pumps, patient monitors), and each capital equipment asset is used across hundreds of procedures over its lifecycle. Clinical staff actively document equipment usage during procedure execution for charge capture, sterilization tracking, implant traceability, and malfunction reporting. This is an operational M:N relationship managed as part of the clinical workflow. | 47 |
| patient_assessment | allergy | master_data | Patient allergy and adverse reaction records including drug allergies, food allergies, environmental allergens, and contrast media reactions. Captures allergen name, allergen type, reaction description, reaction severity (mild, moderate, severe, life-threatening), onset date, verification status (confirmed, unconfirmed, entered-in-error), and the documenting provider. SNOMED CT and NDF-RT coded. Critical patient safety data sourced from Epic and Cerner allergy modules. | 57 |
| patient_assessment | flowsheet_row | master_data | Master reference table for flowsheet_row. Referenced by flowsheet_row_id. | 71 |
| patient_assessment | flowsheet_template | master_data | Master reference table for flowsheet_template. Referenced by flowsheet_template_id. | 71 |
| patient_assessment | functional_status | transactional_data | Patient functional status and disability assessments documenting activities of daily living (ADL), instrumental ADLs, mobility status, cognitive function, and social determinants of health (SDOH) screenings. Captures assessment tool used (Barthel Index, FIM, PHQ-9, CAGE-AID, SDOH screening), assessment date, score, interpretation, and assessing clinician. Supports discharge planning, post-acute care placement, and population health stratification. Sourced from Epic ClinDoc. | 72 |
| patient_assessment | immunization | transactional_data | Patient immunization administration records including vaccine administered, CVX code, NDC code, lot number, expiration date, manufacturer, administration site, route, dose number in series, VIS (Vaccine Information Statement) date, administering provider, and administration date/time. Tracks immunization series completion status. Sourced from Epic and Cerner immunization modules. Supports public health reporting to state immunization registries (IIS). | 58 |
| patient_assessment | nursing_assessment | transactional_data | Structured nursing assessments completed at admission, shift change, and discharge including head-to-toe assessments, skin integrity assessments, fall risk assessments, pressure injury staging, restraint assessments, and discharge readiness evaluations. Captures assessment type, completion date/time, assessing nurse, assessment findings by body system, risk scores, and care recommendations. Sourced from Epic ClinDoc nursing flowsheets. Supports nursing quality metrics and Joint Commission compliance. | 77 |
| patient_assessment | observation | transactional_data | SSOT for all structured clinical observations, assessments, scored evaluations, and clinical findings documented by clinicians during patient care. Encompasses LOINC-coded and SNOMED CT-coded observations across all clinical contexts including: nursing assessments (head-to-toe, skin integrity, restraint, fall risk using Morse/Braden scales, pressure injury staging, discharge readiness), functional status assessments (Barthel Index, FIM, ADL/IADL), behavioral health screenings (PHQ-9, CAGE-AID, Columbia Suicide Severity), SDOH screenings, wound assessments, intake/output measurements, neurological assessments (GCS components), physical examination findings, symptom documentation, and clinical impressions. Captures observation code, value (numeric, coded, or text), units, reference range, interpretation flag (normal, abnormal, critical), observation_category (nursing, functional, finding, screening, exam), assessment tool used, body system/site, laterality, severity, presence status (present, absent, unknown), observation date/time, and recording clinician. High-volume structured clinical data sourced from Epic ClinDoc flowsheets, Cerner PowerChart, and structured documentation modules. Supports nursing quality metrics, discharge planning, population health stratification, Joint Commission compliance, and FHIR Observation resource interoperability. | 64 |
| patient_assessment | problem | master_data | Patient problem list entries representing active, chronic, or historical health conditions managed longitudinally across encounters. Captures SNOMED CT and ICD-10 coded problems, onset date, resolution date, problem status (active, inactive, resolved), priority, and the provider who added or last updated the problem. Distinct from encounter-level diagnoses — this is the longitudinal clinical problem list. Sourced from Epic and Cerner problem list modules. | 60 |
| patient_assessment | vital_sign | transactional_data | Patient vital sign measurements captured during clinical encounters, nursing assessments, and continuous monitoring. Includes LOINC-coded observation types: blood pressure (systolic/diastolic), heart rate, respiratory rate, temperature, SpO2, height, weight, BMI, pain score, and Glasgow Coma Scale (GCS). Captures measured value, unit of measure, measurement method, body site, patient position, device used, measurement date/time, and recording clinician. Supports early warning score (EWS/MEWS/NEWS) calculations, sepsis screening, and clinical deterioration detection. High-volume time-series clinical data sourced from Epic ClinDoc flowsheets, Cerner PowerChart, and bedside monitoring device integrations. Separated from clinical_observation due to distinct high-frequency time-series ingestion patterns, dedicated device integration pipelines, and specialized analytics (trending, alerting, waveform correlation). Maps to FHIR Observation with vitals profile (US Core Vital Signs). | 61 |

<a id="domain-consent"></a>

### Domain: Consent

| Domain | Division | Total Subdomains | Description | Total Products |
|---|---|---|---|---|
| consent | operations | 5 | Enterprise consent management for patient treatment consent, research consent, data sharing authorizations, HIPAA authorizations, HIE opt-in/opt-out, and telehealth consent. SSOT for all consent records across clinical, research, and administrative contexts. | 22 |

**Subdomains:** authorization_capture, compliance_monitoring, consent_governance, patient_rights, sensitive_directives


**List of Data Products**

| Subdomain | Product | Data Type | Description | Total Attributes |
|---|---|---|---|---|
| authorization_capture | hipaa_authorization | master_data | Master record for HIPAA-specific authorizations permitting use or disclosure of PHI for purposes beyond treatment, payment, and operations (TPO). Captures authorization purpose (marketing, research, psychotherapy notes, sale of PHI), specific PHI elements authorized for disclosure, recipient of disclosure, expiration date or expiration event, right to revoke statement, and patient signature. Distinct from general treatment consent — governed specifically by 45 CFR 164.508 and requires stricter documentation standards. | 52 |
| authorization_capture | photography_media_consent | master_data | Master record for patient consent to photography, video recording, audio recording, and use of patient images or likeness for clinical, educational, marketing, or research purposes. Captures media type, intended use (clinical documentation, medical education, publication, marketing, social media), scope of consent (identifiable vs. de-identified), distribution channels authorized, expiration, and right to withdraw. Required by HIPAA for any use of patient images beyond direct treatment and by institutional policies governing patient privacy. | 33 |
| authorization_capture | research_consent | master_data | Master record for informed consent obtained from research subjects prior to enrollment in clinical trials and research studies. Captures IRB-approved consent form version, study arm, consent process details (who obtained consent, where, how long discussion lasted), subject comprehension assessment, legally authorized representative (LAR) details for incapacitated subjects, assent documentation for minors, re-consent events for protocol amendments, and withdrawal of consent. Governed by 45 CFR 46 (Common Rule) and 21 CFR 50 (FDA). Complements research.informed_consent with enterprise consent SSOT linkage. | 52 |
| authorization_capture | telehealth_consent | master_data | Master record for patient consent to receive care via telehealth and virtual care modalities. Captures telehealth platform, modality type (video, audio-only, asynchronous), state-specific consent requirements met, technology risks disclosed, patient right to refuse telehealth and receive in-person care, provider licensure state, and interstate compact applicability. Required by CMS and most state telehealth laws as a condition of telehealth service delivery. | 46 |
| authorization_capture | treatment_consent | master_data | Master record for general and procedure-specific treatment consent obtained from patients or their authorized representatives prior to clinical care. Captures consent type (general treatment, surgical, anesthesia, blood transfusion, chemotherapy, ECT, restraint), procedure or treatment being consented to, risks and benefits documented, alternatives discussed, patient questions addressed, capacity determination, and legal representative details when patient lacks decision-making capacity. Distinct from HIPAA authorization — governs clinical care delivery. | 49 |
| compliance_monitoring | deficiency | transactional_data | Transactional record of identified consent deficiencies — instances where required consent was not obtained, was improperly documented, expired, or is otherwise incomplete at the time of care delivery or audit. Captures deficiency type, discovery method (pre-procedure checklist, HIM audit, accreditation survey, patient complaint), responsible provider or department, deficiency status (open, remediated, waived), remediation action taken, and resolution date. Supports HIM, compliance, and quality improvement workflows for consent management. | 25 |
| compliance_monitoring | disclosure_log | transactional_data | Transactional record of every PHI disclosure made under a patient consent or authorization, providing the accounting of disclosures required by HIPAA. Captures disclosure date, recipient identity and type, purpose of disclosure, PHI elements disclosed, consent or authorization reference, and whether the disclosure was for TPO (exempt from accounting) or non-TPO (subject to accounting). Enables generation of the HIPAA Accounting of Disclosures report provided to patients upon request per 45 CFR 164.528. | 43 |
| compliance_monitoring | expiration_alert | transactional_data | Operational record tracking consent records approaching or past their expiration date that require patient re-consent or renewal action. Captures consent reference, expiration date, alert generation date, alert type (approaching expiration, expired, renewal required), notification channel used (patient portal, staff worklist, EHR alert), responsible staff member, and resolution status. Drives proactive consent renewal workflows to prevent care delays and compliance gaps from expired consents. | 23 |
| compliance_monitoring | npp_acknowledgment | transactional_data | Transactional record of patient acknowledgment of receipt of the organization's HIPAA Notice of Privacy Practices (NPP). Captures acknowledgment date, delivery method (paper, electronic, patient portal), NPP version acknowledged, patient or representative signature, and documentation of good-faith efforts when acknowledgment could not be obtained. Distinct from compliance.notice_of_privacy_practices which tracks the NPP document itself — this tracks the patient-level acknowledgment transaction required by 45 CFR 164.520. | 45 |
| consent_governance | consent_policy | reference_data | Reference master defining the organization's enterprise consent policies, rules, and requirements governing each consent type. Captures policy name, consent category governed, required consent elements, minimum age for independent consent, capacity assessment triggers, re-consent triggers (protocol amendment, significant new risk, time-based expiration), documentation requirements, and applicable regulatory citations. Drives consent workflow configuration and ensures consistent consent practice across all care settings and facilities. | 54 |
| consent_governance | consent_session | master_data | Master reference table for consent_session. Referenced by session_id. | 35 |
| consent_governance | form_template | master_data | Master catalog of all approved consent form templates used across clinical, research, and administrative contexts. Captures form name, form code, consent category (treatment, surgical, research, HIPAA, HIE, telehealth, data sharing), version number, effective date, expiration date, regulatory basis (HIPAA, 45 CFR 46, state law), language, reading level, approval authority, and IRB approval reference where applicable. Serves as the authoritative reference for which form version was presented to a patient at time of consent. | 50 |
| patient_rights | amendment_request | transactional_data | Transactional record of patient requests to amend their consent records or associated PHI documentation. Captures amendment request date, specific consent record targeted, nature of requested amendment, organization's decision (accepted, denied with reason), amendment effective date, and notification to third parties who received the original consent-based disclosure. Supports HIPAA right to amend under 45 CFR 164.526 and maintains the integrity of the consent audit trail. | 37 |
| patient_rights | capacity_assessment | transactional_data | Transactional record of formal clinical assessments of a patient's decision-making capacity to provide informed consent. Captures assessment date, assessing clinician, assessment tool used (MacCAT-T, Aid to Capacity Evaluation), capacity determination (full capacity, diminished capacity, lacks capacity), specific deficits identified, clinical basis for determination, and whether a surrogate decision-maker was engaged. Required when capacity is in question and critical for legal defensibility of consent obtained from vulnerable populations. | 28 |
| patient_rights | delegation | master_data | Master record for authorized representatives, legal surrogates, and healthcare proxies who have legal authority to provide consent on behalf of a patient. Captures delegate type (healthcare proxy, durable power of attorney for healthcare, legal guardian, court-appointed guardian, next-of-kin surrogate per state law), delegation scope, effective period, supporting legal documentation reference, and priority order when multiple delegates exist. Distinct from patient.proxy_access which governs portal access — this governs clinical consent authority. | 46 |
| patient_rights | restriction_request | master_data | Master record for patient requests to restrict uses and disclosures of their PHI beyond HIPAA's standard permissions. Captures restriction type (restrict disclosure to specific payer when patient paid out-of-pocket per HITECH, restrict sharing with family members, restrict specific data types), requested restriction scope, organization's decision to accept or deny the restriction, effective date, and operational instructions for honoring the restriction across clinical systems. Governed by HITECH Act amendment to HIPAA 45 CFR 164.522. | 54 |
| patient_rights | revocation | transactional_data | Transactional record of every consent revocation submitted by a patient or their authorized representative. Captures revocation date and time, revocation method (written, verbal, electronic), reason for revocation (if provided), scope of revocation (full or partial), actions taken in response (notifications sent, data access restricted, disclosures halted), and any disclosures that occurred prior to revocation that cannot be undone. Provides the legal audit trail required by HIPAA and state law for consent withdrawal. | 52 |
| sensitive_directives | behavioral_health_consent | master_data | Specialized master record for consent governing disclosure of behavioral health, mental health, and psychiatric treatment records, which are subject to state-specific heightened confidentiality protections beyond standard HIPAA. Captures state law basis, specific mental health data elements covered (psychotherapy notes, psychiatric hospitalization, medication for mental illness), authorized recipients, purpose, expiration, and patient-imposed restrictions. Manages the complex intersection of HIPAA psychotherapy note protections and state mental health confidentiality statutes. | 27 |
| sensitive_directives | genetic_testing_consent | master_data | Specialized master record for informed consent governing genetic testing, genomic sequencing, and biobanking. Captures test type (diagnostic, predictive, carrier, pharmacogenomic, whole genome sequencing), scope of consent (specific test only, future research use, biobank storage, return of incidental findings), family member implications disclosure, insurance discrimination risk disclosure per GINA, data sharing permissions for research registries, and consent for re-contact as new findings emerge. Governed by GINA, state genetic privacy laws, and ACMG guidelines. | 23 |
| sensitive_directives | hie_directive | master_data | Master record for patient Health Information Exchange (HIE) opt-in and opt-out directives governing participation in regional and statewide HIE networks. Captures HIE network name, directive type (opt-in, opt-out, opt-out with exceptions), effective date, expiration date, scope of data sharing (all records, specific data types, specific providers), patient-specified restrictions, and directive status. Supports compliance with state HIE consent laws and CommonWell/Carequality participation rules. | 46 |
| sensitive_directives | minor_consent | master_data | Master record for consent situations involving minor patients, capturing the complex legal landscape of minor consent rights. Tracks whether the minor is consenting independently (mature minor doctrine, emancipated minor, state-specific minor consent for STI/reproductive health/substance use/mental health), parental/guardian consent details, custodial parent verification, court-ordered consent restrictions, and confidentiality obligations to the minor. Critical for compliance with state minor consent statutes and HIPAA minor exception rules. | 52 |
| sensitive_directives | substance_use_consent | master_data | Specialized master record for consent and authorization governing disclosure of substance use disorder (SUD) treatment records, which carry heightened federal confidentiality protections beyond standard HIPAA. Captures consent elements required by 42 CFR Part 2 including specific program name, patient name, specific information to be disclosed, purpose of disclosure, recipient, expiration, and right to revoke. Tracks re-disclosure prohibition notices and patient-permitted disclosures for treatment, payment, and operations under the 2020 CARES Act amendments. | 24 |

<a id="domain-encounter"></a>

### Domain: Encounter

| Domain | Division | Total Subdomains | Description | Total Products |
|---|---|---|---|---|
| encounter | operations | 3 | Core operational record of every patient-provider interaction. Owns ADT (Admit, Discharge, Transfer) events, visit types (inpatient, outpatient, ED, observation, telehealth), admission source and disposition, attending and consulting providers, LOS (Length of Stay), DRG assignment, discharge status, and care setting transitions. Central hub linking patient, provider, clinical, and billing domains. | 16 |

**Subdomains:** clinical_documentation, encounter_management, financial_coverage


**List of Data Products**

| Subdomain | Product | Data Type | Description | Total Attributes |
|---|---|---|---|---|
| clinical_documentation | discharge_summary | transactional_data | Discharge summary document capturing hospital course, discharge instructions, and follow-up plan. | 57 |
| clinical_documentation | drg_assignment | transactional_data | DRG assignment record capturing grouper results, weights, and reimbursement data for inpatient visits. | 49 |
| clinical_documentation | readmission | transactional_data | Readmission tracking record for HRRP compliance, root cause analysis, and quality improvement. | 45 |
| clinical_documentation | triage_assessment | transactional_data | Emergency department triage assessment capturing vital signs, acuity level, and chief complaint. | 51 |
| clinical_documentation | visit_diagnosis | transactional_data | Diagnosis codes associated with a visit, including POA indicators, DRG relevance, and coding status. | 46 |
| clinical_documentation | visit_procedure | transactional_data | Procedures performed during a visit, including CPT/ICD-10-PCS codes, RVUs, and surgical details. | 58 |
| clinical_documentation | visit_recall_impact | association_data | Tracks the impact of supply/device recalls on specific patient visits, including remediation actions. | 24 |
| encounter_management | adt_event | transactional_data | Admit-Discharge-Transfer event record capturing patient movement events within and between facilities. | 50 |
| encounter_management | bed_assignment | transactional_data | Bed assignment record tracking patient bed placements throughout a visit. | 46 |
| encounter_management | transfer_request | transactional_data | Patient transfer request record capturing EMTALA compliance, clinical indication, and transfer logistics. | 54 |
| encounter_management | visit | master_data | Core encounter/visit record representing a patient interaction with the health system. | 50 |
| encounter_management | visit_provider | association_data | Association between a visit and the providers involved in care delivery. | 50 |
| encounter_management | visit_status_history | transactional_data | Audit trail of visit status changes throughout the encounter lifecycle. | 42 |
| financial_coverage | encounter_authorization |  | SSOT resolved: defer to order.order_authorization as the single source of truth for this concept. This table is a domain-specific extension/reference. | 32 |
| financial_coverage | visit_coverage | association_data | Summary of insurance coverage applicable to a visit for eligibility and financial clearance. | 24 |
| financial_coverage | visit_insurance | transactional_data | Insurance coverage details associated with a visit, including eligibility, authorization, and financial responsibility. | 45 |

<a id="domain-facility"></a>

### Domain: Facility

| Domain | Division | Total Subdomains | Description | Total Products |
|---|---|---|---|---|
| facility | operations | 5 | Healthcare facility and physical infrastructure management. Owns hospitals, clinics, outpatient centers, care sites, bed management, room/unit configuration, OR/ICU/ED space, equipment assets, biomedical engineering, preventive maintenance, environmental services, facility licensing, and accreditation status. Supports multi-site integrated delivery networks. Integrates with SAP PM. | 26 |

**Subdomains:** asset_maintenance, capacity_operations, physical_infrastructure, regulatory_safety, vendor_contracts


**List of Data Products**

| Subdomain | Product | Data Type | Description | Total Attributes |
|---|---|---|---|---|
| asset_maintenance | equipment_asset | master_data | Medical equipment asset with maintenance, calibration, and recall tracking. | 35 |
| asset_maintenance | equipment_authorization | association_data | Provider authorization to use specific equipment. | 17 |
| asset_maintenance | maintenance_order | transactional_data | Maintenance work order for equipment and facility assets. | 29 |
| asset_maintenance | pm_schedule | master_data | Preventive maintenance schedule for equipment and facility assets. | 20 |
| capacity_operations | bed_status_event | transactional_data | Bed status change event log for ADT, housekeeping, and capacity management. | 35 |
| capacity_operations | block_assignment | association_data | OR block time assignment to surgeon or service. | 22 |
| capacity_operations | capacity_snapshot | transactional_data | Point-in-time capacity snapshot (census, occupancy, diversion status). | 23 |
| capacity_operations | environmental_service_request | transactional_data | Housekeeping and environmental services request. | 22 |
| physical_infrastructure | bed | master_data | Individual bed with status, assignment, and capability attributes for ADT and capacity management. | 42 |
| physical_infrastructure | building | master_data | Physical building structure with construction, safety, and property attributes. | 49 |
| physical_infrastructure | care_site | master_data | Healthcare delivery site (hospital, clinic, department) with licensure, accreditation, and operational attributes. | 48 |
| physical_infrastructure | or_suite | master_data | Operating room suite with airflow, equipment, and accreditation attributes. | 41 |
| physical_infrastructure | organization | master_data | Healthcare organization (health system, hospital, clinic, department, unit) with self-referential hierarchy. | 14 |
| physical_infrastructure | room | master_data | Physical room within a unit with bed count, medical gas, and environmental attributes. | 44 |
| physical_infrastructure | service | master_data | Clinical service line offered at a care site. | 18 |
| physical_infrastructure | site_hierarchy | master_data | Facility organizational hierarchy (system > hospital > campus > building > department > unit). | 16 |
| physical_infrastructure | space_allocation | master_data | Space allocation to department or cost center. | 17 |
| physical_infrastructure | unit | master_data | Clinical nursing unit or department with bed capacity, acuity, and staffing attributes. | 46 |
| regulatory_safety | hazardous_material | master_data | Hazardous material inventory (chemical, radioactive, biohazard). | 27 |
| regulatory_safety | inspection | transactional_data | Regulatory inspection (TJC, CMS, State, Fire Marshal, etc.). | 25 |
| regulatory_safety | inspection_finding | transactional_data | Individual finding from a regulatory inspection. | 19 |
| regulatory_safety | license_accreditation | master_data | Facility license or accreditation credential. | 24 |
| regulatory_safety | safety_incident | transactional_data | Facility safety incident (slip/fall, equipment failure, etc.). | 27 |
| vendor_contracts | contract | master_data | Facility vendor contract (service, maintenance, lease, etc.). | 28 |
| vendor_contracts | facility_program_participation | association_data | SSOT resolved: defer to quality.quality_program_participation as the single source of truth for this concept. This table is a domain-specific extension/reference. | 20 |
| vendor_contracts | network_contract | association_data | Payer network contract participation at facility level. | 21 |

<a id="domain-interoperability"></a>

### Domain: Interoperability

| Domain | Division | Total Subdomains | Description | Total Products |
|---|---|---|---|---|
| interoperability | operations | 4 | Manages healthcare data exchange standards (HL7v2, FHIR, CDA), HIE participation, interface engine configurations, message tracking, and data transformation mappings for interoperability with external systems and health information exchanges. | 31 |

**Subdomains:** health_exchange, interface_operations, partner_governance, regulatory_reporting


**List of Data Products**

| Subdomain | Product | Data Type | Description | Total Attributes |
|---|---|---|---|---|
| health_exchange | care_transition_notification | transactional_data | Transactional record of every care transition notification (ADT notification) sent to care team members, PCPs, payers, and ACO partners when a patient is admitted, discharged, or transferred. Captures notification timestamp, event type (admission/discharge/transfer/ED visit), sending facility, receiving party type (PCP/specialist/payer/ACO), delivery channel (Direct/FHIR/HL7v2/API), delivery status, patient reference, encounter reference, and acknowledgment receipt. Supports CMS Interoperability Rule ADT notification requirements and care coordination. | 38 |
| health_exchange | cda_document | master_data | Master record for every CDA (Clinical Document Architecture) document generated, received, or exchanged through the interoperability layer. Captures document type (CCD, C-CDA, QRDA I/III, Referral Note, Discharge Summary), document unique ID (OID), document creation timestamp, author facility, patient reference, CDA version, document status (draft/final/amended/deprecated), exchange direction (inbound/outbound), source system, and storage reference. SSOT for CDA document inventory. | 49 |
| health_exchange | cda_validation_result | transactional_data | Transactional record of CDA document conformance validation results produced by schematron validators and C-CDA validators. Captures validation timestamp, document reference, validator tool used, conformance profile tested (C-CDA 2.1, QRDA I, etc.), total errors, total warnings, total informational findings, overall pass/fail status, and structured finding details. Supports document quality assurance, trading partner onboarding, and regulatory submission readiness. | 44 |
| health_exchange | conformance_test | transactional_data | Transactional record of conformance and interoperability testing activities conducted for interface channels, FHIR endpoints, and trading partner connections. Captures test execution date, test suite used (ONC Certification, Touchstone, Inferno, HL7 Conformance Tester), test scope (message type/FHIR resource/transaction set), pass/fail result, number of test cases executed, number passed, number failed, critical failures, and certification submission reference. Supports ONC Health IT Certification and trading partner go-live readiness. | 40 |
| health_exchange | exchange_standard | reference_data | Registry of healthcare data exchange standards (HL7 v2, FHIR, CDA, X12) with version tracking, certification status, and conformance profiles. | 43 |
| health_exchange | hie_participation | master_data | Master record documenting the healthcare organizations formal participation in Health Information Exchanges (HIEs), including state HIEs, regional HIEs (CommonWell, Carequality, eHealth Exchange), and national networks. Captures HIE name, network type, participation tier (query/contribute/both), onboarding date, data sharing scope, patient consent model (opt-in/opt-out), technical connection type, compliance attestation date, and participation status. SSOT for HIE network membership. | 48 |
| health_exchange | hie_query | transactional_data | Transactional record of every patient record query submitted to or received from an HIE network. Captures query timestamp, query type (patient discovery/document query/document retrieve), initiating facility, responding facility, patient demographics used for matching, match confidence score, number of documents returned, query response time, query status, and clinical purpose code. Supports care coordination analytics, HIE utilization reporting, and patient consent enforcement. | 48 |
| health_exchange | hie_transaction | master_data | Master reference table for hie_transaction. Referenced by hie_transaction_id. | 36 |
| health_exchange | mapping_definition | master_data | Master reference table for mapping_definition. Referenced by mapping_definition_id. | 36 |
| health_exchange | mapping_rule | master_data | Individual transformation rule record within a data mapping definition, representing the atomic unit of field-level or value-level translation logic. Captures rule sequence, source expression, target expression, condition expression, default value, null handling behavior, data type conversion, and test case reference. Enables granular versioning, testing, and governance of transformation logic separate from the parent mapping container. | 41 |
| health_exchange | patient_identity_match | transactional_data | Transactional record of patient identity matching events performed during cross-organizational data exchange, including MPI (Master Patient Index) lookups, EMPI matching, and IHE PIX/PDQ transactions. Captures match request timestamp, source system, match algorithm used, candidate patient identifiers submitted, match score, match result (match/possible match/no match), matched MPI record reference, and manual review flag. Critical for preventing patient data mismatches during HIE queries and care transitions. | 54 |
| health_exchange | terminology_mapping | master_data | Master record for enterprise terminology translation mappings between local codes and standard terminologies (SNOMED CT, LOINC, RxNorm, ICD-10, CPT, CVX). Captures source code system, source code value, source display name, target code system, target code value, target display name, mapping relationship type (equivalent/broader/narrower/related), mapping confidence, effective date, expiration date, and governance approval status. Distinct from data_mapping (field-level) — this is value-level code translation. | 64 |
| interface_operations | direct_address | master_data | Master record for all Direct Secure Messaging addresses managed by or registered with the organization, including provider Direct addresses, facility Direct addresses, and patient Direct addresses. Captures Direct address (FQDN format), address type (provider/facility/patient), associated NPI or facility ID, certificate status, certificate expiration date, HISP (Health Information Service Provider) name, trust bundle membership, and activation status. SSOT for Direct address inventory. | 45 |
| interface_operations | direct_message | transactional_data | Transactional record of every Direct Secure Messaging transaction exchanged via the Direct Protocol (DirectTrust). Captures message ID, sender Direct address, recipient Direct address, message type (referral, care summary, lab result, discharge notification), send timestamp, delivery status (sent/delivered/failed/bounced), message size, encryption status, certificate validation result, and associated clinical document reference. Supports care coordination, referral workflows, and Meaningful Use/Promoting Interoperability attestation. | 46 |
| interface_operations | fhir_endpoint | master_data | Master record for every FHIR API endpoint registered and managed by the organization, including patient-facing SMART on FHIR apps, payer FHIR APIs (CMS Interoperability Rule), provider directory endpoints, and internal FHIR server instances. Captures endpoint URL, FHIR version (R4/STU3), capability statement URL, supported resource types, authentication method (OAuth2/SMART/API key), rate limits, CMS compliance flag (21st Century Cures Act), and operational status. SSOT for FHIR API inventory. | 52 |
| interface_operations | fhir_resource_log | transactional_data | Transactional log of every FHIR resource operation (read, search, create, update, delete, $operation) processed through FHIR API endpoints. Captures FHIR resource type (Patient, Observation, Condition, MedicationRequest, etc.), operation type, request timestamp, response HTTP status, FHIR resource ID, requesting application/client ID, patient context, response time, and conformance validation result. Supports 21st Century Cures Act audit requirements and FHIR API performance monitoring. | 45 |
| interface_operations | interface_channel | master_data | Master record for every configured interface channel (connection) within an interface engine, representing a discrete data flow between a source system and a destination system. Captures channel name, channel type (inbound/outbound/bidirectional), transport protocol (MLLP, HTTP/S, SFTP, SOAP, REST), source system, destination system, message standard, message event type, encoding (ER7/XML/JSON), channel status (active/inactive/testing), and SLA tier. Each channel is the atomic unit of interface management. | 52 |
| interface_operations | interface_downtime | transactional_data | Transactional record of every planned and unplanned interface downtime event affecting interface channels or trading partner connections. Captures downtime start timestamp, downtime end timestamp, downtime type (planned maintenance/unplanned outage/trading partner outage), affected channels, root cause, impact severity, messages queued during downtime, messages replayed after recovery, and incident ticket reference. Supports SLA reporting, root cause analysis, and operational resilience tracking. | 53 |
| interface_operations | interface_engine | master_data | Registry of interface engines (middleware platforms) that route, transform, and monitor healthcare data exchanges. | 49 |
| interface_operations | message_error | transactional_data | Transactional record of every message processing error, rejection, or exception encountered during interface engine processing. Captures error timestamp, error code, error category (parsing/validation/routing/transformation/delivery), error description, affected message control ID, channel reference, error severity, resolution status, assigned resolver, resolution timestamp, and root cause classification. Enables systematic error management, SLA breach tracking, and interface reliability improvement. | 42 |
| interface_operations | message_log | transactional_data | Transactional log of every healthcare message processed through the interface engine infrastructure. Captures message control ID, message type (ADT^A01, ORU^R01, etc.), sending facility, receiving facility, message timestamp, processing status (received/processed/acknowledged/errored/rejected), ACK code, error description, payload size, and processing latency. Serves as the operational audit trail for all HL7v2, FHIR, CDA, and X12 message traffic. Critical for SLA monitoring, error investigation, and compliance. | 53 |
| interface_operations | subscription_notification | transactional_data | Transactional record of every event-driven notification dispatched to a subscriber endpoint via FHIR Subscription or HL7 event notification. Captures notification timestamp, subscription topic reference, triggering event type, triggering resource ID, subscriber endpoint, delivery status (sent/delivered/failed/retrying), HTTP response code, retry count, and payload reference. Enables monitoring of event-driven interoperability workflows and subscriber delivery reliability. | 32 |
| interface_operations | subscription_topic | master_data | Master record for FHIR Subscription topics and HL7v2 event subscriptions configured to push notifications to external systems when specific clinical events occur (e.g., ADT notifications, lab result availability, care gap alerts). Captures topic name, trigger event type, FHIR resource filter criteria, notification channel type (REST-hook/websocket/email/FHIR messaging), subscriber endpoint, payload type (full-resource/id-only/empty), and subscription status. Supports event-driven interoperability and care coordination notifications. | 29 |
| partner_governance | data_sharing_agreement | master_data | Master reference table for data_sharing_agreement. Referenced by data_sharing_agreement_id. | 43 |
| partner_governance | data_use_agreement | master_data | Master reference table for data_use_agreement. Referenced by data_use_agreement_id. | 45 |
| partner_governance | hie_organization | master_data | Master reference table for hie_organization. Referenced by hie_organization_id. | 42 |
| partner_governance | interface_sla | master_data | Master record defining Service Level Agreement (SLA) targets for each interface channel or trading partner connection. Captures SLA name, associated channel or partner, message throughput target (messages/hour), maximum acceptable latency (ms), maximum error rate threshold (%), uptime target (%), alerting thresholds, escalation path, measurement window, and effective date. Enables proactive interface performance management and SLA breach alerting. | 45 |
| partner_governance | onboarding_project | master_data | Master record for every trading partner or interface onboarding project managed by the interoperability team. Captures project name, trading partner reference, interface type being onboarded, project phase (discovery/design/build/testing/go-live/post-live), project manager, target go-live date, actual go-live date, testing milestone dates, certification requirements (ONC, DirectTrust, Carequality), and project status. Enables portfolio management of the organizations interface onboarding pipeline. | 60 |
| partner_governance | trading_partner | master_data | Registry of external organizations that exchange data with the health system, including HIE participants, payers, labs, and referring providers. | 49 |
| regulatory_reporting | promoting_interoperability | transactional_data | Transactional record tracking the organizations performance on CMS Promoting Interoperability (PI) program measures (formerly Meaningful Use), including electronic prescribing rates, health information exchange rates, provider-to-patient exchange rates, public health reporting rates, and clinical data registry reporting rates. Captures reporting period, eligible clinician or hospital reference, measure identifier, numerator count, denominator count, exclusion count, performance rate, and attestation status. Supports CMS PI attestation and value-based program compliance. | 35 |
| regulatory_reporting | public_health_report | transactional_data | Transactional record of every public health reporting submission made to state and federal public health agencies, including electronic lab reporting (ELR), immunization registry submissions (IIS), syndromic surveillance (BioSense), cancer registry reporting, and vital records reporting. Captures report type, reporting agency, submission timestamp, reporting period, message standard used (HL7v2 2.5.1, FHIR), submission status (accepted/rejected/pending), acknowledgment code, and case count. Supports Promoting Interoperability public health measures. | 40 |

<a id="domain-laboratory"></a>

### Domain: Laboratory

| Domain | Division | Total Subdomains | Description | Total Products |
|---|---|---|---|---|
| laboratory | operations | 4 | Laboratory testing and diagnostic services. Owns lab orders, specimen collection and tracking, test results (LOINC-coded), reference ranges, critical value alerts, pathology reports, microbiology cultures, blood bank operations, point-of-care testing, and CLIA-compliant quality control. Integrates with LIS (Laboratory Information System) including Epic Beaker and Cerner PathNet. | 22 |

**Subdomains:** catalog_reference, quality_compliance, revenue_coverage, testing_operations


**List of Data Products**

| Subdomain | Product | Data Type | Description | Total Attributes |
|---|---|---|---|---|
| catalog_reference | organism | master_data | Master reference table for organism. Referenced by organism_id. | 37 |
| catalog_reference | reference_range | reference_data | Reference data defining normal, abnormal, and critical value thresholds for each laboratory test, stratified by patient demographics (age group, sex, pregnancy status, race/ethnicity where clinically validated) and specimen type. Includes lower and upper normal limits, critical low and critical high thresholds, panic value definitions, unit of measure, effective date range, and the authoritative source (CAP, CLIA, manufacturer insert, institutional medical director override). Used by result interpretation logic to assign abnormal flags and trigger critical value alerts in test_result. Supports CLIA-required documentation of reference range sources and periodic review. | 49 |
| catalog_reference | study_test_requirement | association_data | This association product represents the protocol-specific laboratory test requirements for research studies. It captures which laboratory tests are required for each research protocol, including visit scheduling, collection timepoints, coverage determination, and whether tests are standard-of-care or research-only. Each record links one test from the test catalog to one research study with protocol-specific collection and coverage metadata that exists only in the context of this research protocol requirement.. Existence Justification: Research protocols routinely require multiple laboratory tests (CBC, CMP, tumor markers, pharmacokinetic assays, etc.) across different visit timepoints, and each laboratory test can be used across multiple research studies with different protocol-specific requirements. Research coordinators actively manage these study test requirements as operational entities, tracking protocol-mandated collection schedules, coverage determination (sponsor-paid vs. standard-of-care), visit timepoints, and collection frequencies that vary by protocol. | 40 |
| catalog_reference | test_catalog | reference_data | Reference master of all laboratory tests and test panels offered by the health system, serving as the SSOT for the laboratory test compendium. For individual tests: captures LOINC code, test name, CPT code(s) for billing, specimen requirements, container type, minimum volume, storage and transport conditions, turnaround time targets (routine and STAT), performing lab (internal section or reference lab name), methodology, and orderable flag. For panels and profiles (e.g., BMP, CMP, CBC with differential, lipid panel, hepatic function panel): captures panel LOINC code, panel name, component test relationships, clinical use case, panel-specific ordering rules, and orderable status. Also covers send-out test catalog entries with reference lab routing information. Consolidates the former test_panel product. Used by clinicians, order entry systems (CPOE), clinical decision support, and CDM charge alignment. | 54 |
| quality_compliance | clia_certificate | master_data | Master record for each CLIA (Clinical Laboratory Improvement Amendments) certificate held by the organization's laboratory facilities. Captures CLIA certificate number, certificate type (waived, provider-performed microscopy, accreditation), issuing state, effective date, expiration date, accrediting organization (CAP, Joint Commission, COLA), laboratory director name and NPI, certificate status, and associated facility. SSOT for CLIA compliance identity across all lab locations. | 51 |
| quality_compliance | instrument | master_data | Master record for every analytical instrument and analyzer operated within the laboratory, including its full maintenance, calibration, and service lifecycle. Tracks instrument identity: name, manufacturer, model, serial number, asset tag, lab section assignment, location (lab room/bench), CLIA certificate association, installation date, current operational status (active, down, maintenance, decommissioned), LIS interface connectivity. Owns all maintenance events: preventive maintenance schedules (daily, weekly, monthly), corrective maintenance events, calibration verification results, maintenance date/time, performing technician or vendor, tasks completed, parts replaced, downtime duration, and return-to-service authorization. Consolidates the former instrument_maintenance product. SSOT for laboratory instrument inventory, operational readiness, and CLIA/CAP maintenance documentation. | 45 |
| quality_compliance | instrument_policy_compliance | association_data | This association product represents the compliance relationship between laboratory instruments and organizational policies. It captures which policies apply to which instruments and tracks the compliance status, assessment dates, and attestation status for each instrument-policy pairing. Each record links one instrument to one policy with attributes that exist only in the context of this compliance relationship.. Existence Justification: In healthcare laboratory operations, instruments are governed by multiple organizational policies simultaneously (maintenance policy, quality control policy, safety policy, calibration policy, CLIA compliance policy), and each policy applies to multiple instruments across the laboratory. The compliance relationship itself carries operational data including compliance status, assessment dates, review schedules, and attestation status that belong to neither the instrument nor the policy alone but to the specific instrument-policy pairing. | 78 |
| quality_compliance | qc_run | transactional_data | Transactional record of all quality control activities performed to verify laboratory analytical performance, including internal QC runs on instruments, external proficiency testing (PT) events, and reagent/consumable lot management. For internal QC: captures instrument identifier, QC material lot number, QC level (low, normal, high), expected mean and standard deviation, observed result, Westgard rule evaluation outcome (pass/fail), QC run date/time, performing technologist, and corrective action taken if failed. For proficiency testing (PT): captures PT program name (CAP, AAFP, COLA), analyte or test surveyed, PT event date, submitted result value, graded result (acceptable, unacceptable), peer group mean, peer group SD, z-score, corrective action plan if failed, and attestation date. For reagent and consumable lot tracking: captures reagent name, manufacturer, catalog number, lot number, expiration date, receipt date, storage requirements (temperature, light sensitivity), open/unopened status, assigned instrument or test method, QC validation status (passed, failed, pending), quantity on hand, lot-to-lot validation results, and lot-to-result traceability for quality investigations. Consolidates the former proficiency_test and reagent_lot products. Mandatory for CLIA compliance, CAP accreditation, and reagent documentation requirements. | 46 |
| quality_compliance | reagent_lot | master_data | Master record for laboratory reagent and consumable lots used in analytical testing. Tracks reagent name, manufacturer, catalog number, lot number, expiration date, receipt date, storage requirements (temperature, light sensitivity), open/unopened status, assigned instrument or test method, QC validation status (passed, failed, pending), and quantity on hand. Supports CLIA reagent documentation requirements, lot-to-lot validation tracking, lot-to-result traceability for quality investigations, and integration with supply chain for reorder management. Owned by the laboratory domain because reagent lot management is a CLIA-regulated laboratory function distinct from general supply chain inventory. | 44 |
| revenue_coverage | lab_charge | transactional_data | Transactional record capturing laboratory-specific charge events generated upon test completion for revenue cycle processing. Tracks the CPT or HCPCS procedure code, charge amount from the CDM (Charge Description Master), charge date, ordering provider NPI, performing facility, insurance authorization reference, charge status (pending, submitted, voided), and the associated lab order and test result. Serves as the laboratory domain's charge origination record that feeds into the billing domain for RCM processing. Does not duplicate billing domain charge master — owns only the lab-originated charge event with lab-specific context (specimen type, performing section, STAT surcharge). | 44 |
| revenue_coverage | lab_fee_schedule_line | association_data | This association product represents the contracted reimbursement rate between a specific laboratory test and a payer fee schedule. It captures the negotiated payment terms, authorization requirements, and service delivery constraints that exist only in the context of this payer-test combination. Each record links one test from the test catalog to one fee schedule with the contracted rate, effective dates, and billing modifiers specific to that payer-test relationship. This is the operational record used by revenue cycle systems for claim pricing, underpayment detection, and contract compliance validation.. Existence Justification: In healthcare revenue cycle operations, each laboratory test has different contracted reimbursement rates across multiple payer fee schedules (e.g., Test X reimbursed at $50 by Blue Cross, $45 by Aetna, $60 by Medicare Advantage Plan Y). Conversely, each payer fee schedule covers hundreds or thousands of laboratory tests, each with its own negotiated rate, authorization requirements, and billing rules. This is a true operational many-to-many relationship that revenue cycle teams actively manage for claim pricing, underpayment detection, and contract compliance. | 33 |
| revenue_coverage | test_coverage_policy | association_data | This association product represents the coverage determination between laboratory tests and payer coverage policies. It captures the specific coverage rules, authorization requirements, and clinical criteria that apply when a specific lab test is ordered under a specific payer policy. Each record links one test catalog entry to one coverage policy with attributes that define the coverage terms, medical necessity criteria, and authorization workflow for that specific test-policy combination.. Existence Justification: In healthcare operations, each laboratory test can have different coverage determinations across multiple payer policies (e.g., a genetic test may be covered with prior authorization by Blue Cross, excluded by Medicare, and covered without authorization by Aetna). Conversely, each coverage policy applies to hundreds or thousands of different lab tests with varying authorization requirements, frequency limits, and medical necessity criteria. Payers actively manage these test-policy coverage determinations as operational records, updating authorization requirements, adding/removing tests from coverage, and modifying clinical criteria on an ongoing basis. | 43 |
| testing_operations | blood_bank_unit | master_data | Master record for each blood product unit managed by the transfusion medicine / blood bank service. Tracks unit number (ISBT 128 coded), product type (packed red cells, platelets, FFP, cryoprecipitate, whole blood, granulocytes), ABO/Rh type, donation date, expiration date, irradiation status, leukoreduction status, CMV status, sickle trait status, unit status lifecycle (available, reserved, crossmatched, issued, transfused, discarded, returned, quarantined), storage location, and temperature monitoring. SSOT for blood product inventory, traceability, and regulatory compliance. Supports AABB standards, FDA blood establishment regulations, and hemovigilance reporting. | 52 |
| testing_operations | lab_order | transactional_data | Core transactional record of every laboratory test order placed via CPOE (Computerized Physician Order Entry) in Epic Beaker or Cerner PathNet, including orders routed to external reference laboratories (send-outs). Captures the ordering provider, ordering encounter, ordered test (LOINC code from test catalog), order priority (STAT, routine, ASAP, timed), order status lifecycle (ordered, collected, in-process, sent-out, resulted, cancelled), clinical indication, order date/time, source system identifiers. For send-out orders: reference lab name, reference lab accession number, specimen shipping date/time, shipping carrier and tracking, expected turnaround time, result receipt date/time, and result integration status. SSOT for all lab order identity and lifecycle within the laboratory domain, including both internal and send-out orders. | 53 |
| testing_operations | microbiology_culture | transactional_data | Transactional record for microbiology culture and sensitivity (C&S) testing. Tracks organism identification (SNOMED CT coded), culture type (aerobic, anaerobic, fungal, AFB, viral), growth result, colony count, isolation date/time, and the associated antimicrobial susceptibility panel. Supports infection control surveillance, antibiotic stewardship programs, and HAI (Healthcare-Associated Infection) reporting including CLABSI and CAUTI tracking. | 56 |
| testing_operations | molecular_test | transactional_data | Transactional record for molecular diagnostic tests including PCR, NGS (Next Generation Sequencing), FISH, and other nucleic acid amplification tests (NAATs). Captures assay name, target gene or pathogen, methodology (RT-PCR, ddPCR, NGS panel, whole exome sequencing), result interpretation (detected/not detected, variant classification per ACMG guidelines, copy number), variant nomenclature (HGVS), clinical significance (pathogenic, likely pathogenic, VUS, likely benign, benign), turnaround time, laboratory developed test (LDT) or FDA-cleared status, bioinformatics pipeline version, and quality metrics (read depth, coverage). Supports oncology genomics (tumor profiling, companion diagnostics), infectious disease molecular testing, pharmacogenomics workflows, and hereditary genetic testing. Remains independent from test_result because molecular diagnostics have fundamentally different attribute structures (variant nomenclature, gene targets, bioinformatics metadata) and distinct operational workflows (wet lab + bioinformatics pipeline) that justify first-class entity status, consistent with the separation between FHIR DiagnosticReport (molecular) and Observation (standard lab result). | 64 |
| testing_operations | pathology_report | master_data | Master record for surgical pathology and cytology reports generated by pathologists. Includes case number, specimen source, gross description, microscopic description, final diagnosis (ICD-10 coded), synoptic reporting elements (CAP cancer protocols), pathologist of record, sign-out date/time, report status (preliminary, final, amended), and addendum history. Supports oncology care coordination, tumor board workflows, and cancer registry reporting. | 56 |
| testing_operations | point_of_care_test | transactional_data | Transactional record for Point-of-Care Testing (POCT) performed outside the central laboratory — at bedside, in the ED, ICU, or clinic. Captures device identifier, device type (glucometer, iSTAT, CoaguChek, rapid strep, influenza), LOINC-coded test, result value, result unit, operator identifier, operator competency status, patient identifier, test date/time, QC status at time of test, and result transmission status to the EHR. Supports CLIA waived and non-waived POCT compliance. | 54 |
| testing_operations | specimen | master_data | Master record for every biological specimen collected for laboratory testing and the SSOT for specimen identity, accessioning, chain of custody, and full specimen lifecycle. Tracks specimen type (blood, urine, tissue, CSF, swab), collection method, collection date/time, collector identity and role, collection site (body location), container type, volume, accession number (LIS-assigned unique work-unit identifier), accession date/time, accession status (received, processing, resulted, archived), receiving lab location, priority, chain-of-custody status, storage location, specimen condition at receipt, number of aliquots, and disposal/retention status. Consolidates the former accession and specimen collection event concepts — the accession is the specimen's operational identity in Epic Beaker and Cerner PathNet. Supports CLIA-compliant specimen tracking from collection through accessioning, testing, and disposal. | 54 |
| testing_operations | susceptibility_result | transactional_data | Transactional record of individual antimicrobial susceptibility test results within a microbiology culture workup. Captures the antibiotic agent (NDC or SNOMED coded), minimum inhibitory concentration (MIC) value, disk diffusion zone diameter, interpretation (susceptible, intermediate, resistant, susceptible-dose dependent), testing method (Kirby-Bauer, broth microdilution, E-test), and CLSI breakpoint version applied. Supports antibiotic stewardship and infection control programs. | 49 |
| testing_operations | test_result | transactional_data | Transactional record of every individual laboratory test result produced for a specimen, including result amendments and critical value notifications. Stores LOINC-coded test identifier, result value (numeric, text, coded), result unit of measure, reference range applied, result status lifecycle (preliminary, final, corrected, cancelled), abnormal flag (normal, low, high, critical low, critical high), result date/time, performing lab section, instrument identifier, verifying technologist. Owns the full amendment/correction history: original value, amended value, amendment reason, amending user, amendment timestamp. When a result exceeds critical thresholds, owns the critical value alert lifecycle: alert generation timestamp, notified provider, notification method (phone, secure message, EHR alert), acknowledgment timestamp, acknowledging clinician, escalation actions, and resolution notes. Consolidates the former critical_value_alert and result_amendment concepts. Supports CLIA critical value compliance, Joint Commission NPSG requirements, HIM audit requirements, and downstream clinical decision-making. | 65 |
| testing_operations | transfusion_event | transactional_data | Transactional record of the full blood product transfusion lifecycle from crossmatch/compatibility testing through administration and post-transfusion monitoring. Owns crossmatch and compatibility testing: crossmatch type (electronic, immediate spin, full serologic), compatibility result (compatible, incompatible), antibody screen result, unexpected antibody identification, patient blood sample reference, performing technologist, crossmatch date/time. Owns transfusion administration: blood bank unit transfused, transfusion start and end date/time, transfusion site, administering nurse, pre- and post-transfusion vital signs, transfusion reaction indicator and type, reaction severity, and clinical indication. Consolidates the former crossmatch product. Supports hemovigilance reporting, AABB compliance, blood bank audit trails, and patient safety surveillance. | 64 |

<a id="domain-order"></a>

### Domain: Order

| Domain | Division | Total Subdomains | Description | Total Products |
|---|---|---|---|---|
| order | operations | 3 | Manages the full lifecycle of clinical orders including CPOE (Computerized Physician Order Entry) for lab, radiology, pharmacy, and referral orders. Tracks order status, priority, routing, and fulfillment. Integrates with Epic Orders, Beaker (LIS), Radiant (RIS), and Willow (pharmacy) as the operational order management backbone. | 16 |

**Subdomains:** decision_support, fulfillment_routing, order_entry


**List of Data Products**

| Subdomain | Product | Data Type | Description | Total Attributes |
|---|---|---|---|---|
| decision_support | alert_rule | master_data | Clinical decision support alert rule definitions governing when CPOE alerts fire. | 47 |
| decision_support | cpoe_alert | transactional_data | Computerized physician order entry alerts fired during order entry with provider response tracking. | 46 |
| decision_support | order_authorization |  | Prior authorization records for orders requiring payer approval before fulfillment. | 47 |
| decision_support | reconciliation | transactional_data | Medication reconciliation records at care transitions ensuring medication list accuracy. | 40 |
| fulfillment_routing | fulfillment | transactional_data | Records of order fulfillment events including completion, partial fulfillment, and exceptions. | 49 |
| fulfillment_routing | order_status_history |  | Audit trail of all status transitions for clinical orders. | 50 |
| fulfillment_routing | routing | transactional_data | Order routing records tracking where and how orders are directed for fulfillment. | 42 |
| fulfillment_routing | routing_rule | master_data | Rules governing automatic order routing to departments, workstations, and queues. | 45 |
| order_entry | clinical_order | master_data | Core clinical order record capturing all order types placed via CPOE or other entry methods. | 52 |
| order_entry | diet_order | Master | Dietary and nutritional orders for inpatient and outpatient settings. | 40 |
| order_entry | referral_order | transactional_data | Referral orders tracking patient referrals to specialists or facilities. | 53 |
| order_entry | set | master_data | Master reference table for set. Referenced by set_id. | 28 |
| order_entry | set_item | master_data | Individual order items within an order set, with conditional logic and defaults. | 44 |
| order_entry | standing_order | master_data | Pre-authorized standing orders for recurring clinical interventions without individual physician sign-off. | 49 |
| order_entry | therapy_order | Master | Therapy orders for physical, occupational, speech, and other therapeutic services. | 54 |
| order_entry | verbal_order | transactional_data | Verbal and telephone orders requiring authentication within regulatory timeframes. | 44 |

<a id="domain-pharmacy"></a>

### Domain: Pharmacy

| Domain | Division | Total Subdomains | Description | Total Products |
|---|---|---|---|---|
| pharmacy | operations | 5 | Owns the medication lifecycle from prescribing through dispensing and administration. Manages formulary, NDC (National Drug Code) drug master, MAR (Medication Administration Record), medication reconciliation, controlled substance tracking (DEA Schedule), adverse drug event monitoring, pharmacy inventory, and prescription fulfillment. Sourced from Epic Willow and Cerner PharmNet. | 18 |

**Subdomains:** benefit_reimbursement, clinical_services, dispensing_operations, formulary_management, regulatory_compliance


**List of Data Products**

| Subdomain | Product | Data Type | Description | Total Attributes |
|---|---|---|---|---|
| benefit_reimbursement | medication_pa_request | transactional_data | Tracks prior authorization (PA) requests submitted to payers for non-formulary or specialty medications. Captures PA request date, payer name, drug NDC, patient reference, prescriber NPI, clinical indication (ICD-10), supporting documentation, PA status (pending/approved/denied/appealed), approval effective and expiration dates, approved quantity/days supply, denial reason code, and appeal outcome. Supports RCM and specialty pharmacy workflows. | 58 |
| benefit_reimbursement | pharmacy_network_participation | association_data | Retained as separate SSOT given distinct PBM/pharmacy benefit network business domain. | 44 |
| benefit_reimbursement | rx_claim | transactional_data | Pharmacy benefit claim submitted to a PBM (Pharmacy Benefit Manager) or payer for reimbursement of a dispensed medication. Captures NCPDP transaction fields including claim date, BIN/PCN/group number, member ID, prescriber NPI, dispensing pharmacy NPI, drug NDC, quantity dispensed, days supply, DAW (Dispense As Written) code, ingredient cost, dispensing fee, patient copay, plan paid amount, U&C (Usual and Customary) price, claim status (paid/rejected/reversed), NCPDP reject codes, and coordination of benefits (COB) data. Distinct from medical claims in the claim domain — this product owns pharmacy-specific NCPDP D.0 claim transactions. Sourced from Epic Willow and Cerner PharmNet. | 61 |
| clinical_services | adverse_drug_event | transactional_data | Operational record of adverse drug events (ADEs), adverse drug reactions (ADRs), and medication errors identified during patient care. Captures event date and time, patient reference, causative drug (NDC), event type (allergic reaction/toxicity/medication error/near-miss), severity level, harm category (NCC MERP index), contributing factors, reporter NPI, encounter reference, root cause analysis findings, and corrective actions taken. Supports pharmacovigilance, FDA MedWatch reporting, ISMP medication error reporting, and pharmacy P&T committee safety reviews. Sourced from Epic Willow and Cerner PharmNet. | 55 |
| clinical_services | medication_review | association_data | This association product represents the clinical review of a specific prescription during a Medication Therapy Management (MTM) session. It captures the pharmacist's assessment, interventions, and outcomes for each prescription evaluated during the MTM encounter. Each record links one MTM session to one prescription with clinical findings, drug therapy problems, interventions, and prescriber communications that exist only in the context of reviewing that specific prescription during that specific MTM session.. Existence Justification: In healthcare pharmacy operations, MTM sessions routinely involve comprehensive review of multiple prescriptions simultaneously (a patient typically has 5-15 active prescriptions reviewed in one MTM session), and individual prescriptions are reviewed repeatedly over time during different MTM encounters as part of ongoing medication safety monitoring. Pharmacists document specific clinical findings, drug therapy problems, interventions, and outcomes for each prescription within each MTM session, creating relationship data that belongs neither to the MTM session alone nor to the prescription alone. | 67 |
| clinical_services | medication_therapy_mgmt | transactional_data | Records pharmacist clinical services including Medication Therapy Management (MTM), clinical interventions, and patient counseling activities. Captures service type (CMR - Comprehensive Medication Review / TMR - Targeted Medication Review / clinical intervention / adherence counseling), service date, pharmacist NPI, patient reference, medications reviewed, drug therapy problems identified, intervention type (dose optimization/therapeutic substitution/allergy clarification/cost reduction/duplicate therapy resolution), recommendations made, patient action plan, prescriber notification and response, outcome, estimated cost avoidance, and billing CPT code. Supports CMS Part D MTM program compliance, pharmacy value demonstration, and quality reporting. Sourced from Epic Willow and Cerner PharmNet. | 56 |
| clinical_services | study_drug_assignment | association_data | This association product represents the investigational product allocation between drug_master and research_study. It captures the assignment of specific drugs to specific research studies, including arm-specific dosing protocols, blinding status, randomization details, and protocol version tracking. Each record links one drug to one study with attributes that exist only in the context of this research relationship. Supports drug accountability, formulary planning, and protocol compliance workflows managed by research pharmacists.. Existence Justification: Clinical research studies routinely test multiple drugs simultaneously (combination therapy, dose-ranging arms, active comparators vs. investigational agents), and each drug participates in multiple studies across different phases, indications, and institutions. Research pharmacists actively manage study-drug assignments as operational entities with arm-specific dosing protocols, blinding requirements, randomization tracking, and protocol version linkage. The business refers to these as 'study drug assignments' or 'investigational product allocations' and manages them for drug accountability, formulary planning, and regulatory compliance. | 60 |
| dispensing_operations | controlled_substance_log | transactional_data | DEA-compliant audit log for all controlled substance transactions including dispensing, administration, waste, returns, inventory counts, and automated dispensing cabinet (ADC) access events. Captures DEA schedule, drug NDC, transaction type, quantity in/out, running balance, transaction timestamp, responsible pharmacist NPI, witness NPI, patient reference, source system (manual/ADC/Pyxis/Omnicell), cabinet/location identifier, override reason, and discrepancy flags. Supports DEA 222 form compliance, state PDMP reporting, diversion detection, and nursing unit controlled substance accountability. Sourced from Epic Willow, Cerner PharmNet, and Pyxis/Omnicell ADC systems. | 51 |
| dispensing_operations | dispense_event | transactional_data | Transactional record of each medication dispensing action performed by the pharmacy. Captures prescription reference, dispensed NDC, dispensed quantity, dispensed days supply, lot number, expiration date, dispensing pharmacist NPI, dispensing location, dispense date and time, fill number (original vs. refill), dispense type (inpatient/outpatient/retail/specialty), patient counseling flag, and verification status. Represents the physical fulfillment of a prescription. Sourced from Epic Willow and Cerner PharmNet. | 61 |
| dispensing_operations | mar_record | transactional_data | Medication Administration Record (MAR) capturing each instance of medication administration to an inpatient or outpatient patient. Records administered drug, dose given, route, administration date and time, administering nurse/clinician NPI, administration site, patient response, waste amount (for controlled substances), witness NPI for controlled substance waste, and administration status (given/held/refused/not-available). Core to inpatient medication safety and regulatory compliance. Sourced from Epic ClinDoc MAR and Cerner PharmNet. | 52 |
| dispensing_operations | prescription | transactional_data | Core transactional record representing a medication order written by an authorized prescriber for a patient. Captures MRN, prescriber NPI, drug name, NDC, sig (directions), quantity prescribed, days supply, refills authorized, prescribing date, indication (ICD-10), prescription status (active/discontinued/expired/on-hold), e-prescribing transmission status, DEA number for controlled substances, and EPCS (Electronic Prescribing of Controlled Substances) compliance flag. Sourced from Epic Willow and Cerner PharmNet. | 64 |
| formulary_management | compounding_record | master_data | Master and production record for all compounded medication preparations (non-sterile, sterile, and IV admixtures) prepared by the pharmacy. Captures compound name, formula/recipe reference, compounding type (non-sterile/sterile/IV admixture), BUD (Beyond-Use Date), USP chapter compliance (USP 795/797/800), ingredients with NDC and quantities, lot numbers, compounding pharmacist NPI, QA verification pharmacist NPI, preparation date and time, batch size, environmental monitoring results, and for IV admixtures: base solution, additives, final concentration, total volume, infusion rate, and delivery location. Supports USP compliance, 503A/503B compounding regulations, and IV workflow safety. Sourced from Epic Willow and Cerner PharmNet. | 78 |
| formulary_management | drug_master | master_data | Authoritative pharmacy drug master for every medication managed within the organization. Captures NDC (National Drug Code), drug name (generic and brand), drug class, DEA schedule, dosage form, strength, route of administration, unit of measure, therapeutic category, formulary status, controlled substance indicator, hazardous drug flag, tall-man lettering, ISMP high-alert flag, look-alike/sound-alike (LASA) indicators, and regulatory approval metadata. Serves as the pharmacy-owned SSOT for drug attributes consumed by prescribing, dispensing, administration, and inventory workflows. Distinct from reference domain NDC code sets — this product adds pharmacy-operational attributes (formulary status, ISMP flags, hazardous drug classification). Sourced from Epic Willow and Cerner PharmNet drug dictionaries. | 56 |
| formulary_management | formulary | master_data | Defines the approved drug formulary for each health plan, payer, or facility tier. Captures formulary tier (preferred/non-preferred/specialty), prior authorization requirements, step therapy requirements, quantity limits, formulary effective and expiration dates, therapeutic alternatives, payer-specific coverage rules, and specialty drug classification. Supports formulary management, clinical decision support at point of prescribing, and prescription adjudication. Benefit plan financial details (copay/coinsurance schedules, deductible applicability, mail-order benefit rules) are sourced from the billing domain; this product owns drug-level coverage and access rules only. Sourced from Epic Willow and Cerner PharmNet formulary modules. | 50 |
| formulary_management | inventory | master_data | Real-time and periodic snapshot of medication inventory levels and movement history across all pharmacy locations including inpatient, outpatient, and automated dispensing cabinets. Captures drug NDC, location, on-hand quantity, reorder point, par level, lot number, expiration date, unit cost, inventory status (active/quarantined/recalled/expired), shortage indicators, and transaction history (receipts, returns, waste, transfers, cycle count adjustments). Supports medication availability, drug shortage management, supply chain integration, waste reduction, and full inventory audit trail. Sourced from Epic Willow and Cerner PharmNet. | 39 |
| formulary_management | pharmacy_location | master_data | SSOT resolved: defer to provider.provider_location as the single source of truth for this concept. This table is a domain-specific extension/reference. | 108 |
| regulatory_compliance | drug_recall | transactional_data | Operational record of FDA drug recalls and market withdrawals affecting medications in the pharmacy inventory or dispensed to patients. Captures recall classification (Class I/II/III), NDC, lot numbers affected, recall initiation date, FDA recall number, recall reason, quantity on hand at time of recall, quantity already dispensed, patient notification status, return/quarantine actions taken, and recall closure date. Supports patient safety response and regulatory compliance. | 56 |
| regulatory_compliance | rems_compliance | transactional_data | Tracks patient enrollment and compliance with FDA-mandated REMS (Risk Evaluation and Mitigation Strategy) programs and specialty pharmacy program requirements for high-risk and specialty medications. Captures program name and type (REMS/hub services/patient assistance/specialty enrollment), drug NDC, patient reference, prescriber NPI, dispensing pharmacy NPI, required program elements (patient enrollment, prescriber certification, pharmacy certification, lab monitoring, adherence monitoring), compliance status per element, last verification date, hub services enrollment status, patient assistance program eligibility, care coordinator assignment, and FDA reporting status. Supports FDA REMS obligations, specialty pharmacy hub operations, patient support programs, and audit readiness. Sourced from Epic Willow and Cerner PharmNet. | 50 |

<a id="domain-radiology"></a>

### Domain: Radiology

| Domain | Division | Total Subdomains | Description | Total Products |
|---|---|---|---|---|
| radiology | operations | 4 | Medical imaging and diagnostic radiology services. Owns imaging orders, modality scheduling (CT, MRI, X-ray, ultrasound, PET), PACS (Picture Archiving and Communication System) integration, radiology reports, DICOM image metadata, contrast administration, radiation dose tracking, radiologist interpretations, and CPT-coded procedures. Integrates with RIS (Radiology Information System) including Epic Radiant and Cerner RadNet. | 22 |

**Subdomains:** external_distribution, order_management, reporting_interpretation, study_acquisition


**List of Data Products**

| Subdomain | Product | Data Type | Description | Total Attributes |
|---|---|---|---|---|
| external_distribution | distribution_rule | master_data | Master reference table for distribution_rule. Referenced by distribution_rule_id. | 34 |
| external_distribution | network_modality_participation | association_data | This association product represents the contractual participation of imaging modalities in payer-defined provider networks. It captures the business relationship where healthcare facilities contract specific imaging equipment into insurance networks, establishing in-network status, reimbursement rates, and authorization requirements. Each record links one modality to one provider_network with attributes that exist only in the context of this network participation agreement.. Existence Justification: Healthcare facilities contract specific imaging modalities into multiple payer-defined provider networks simultaneously, and each provider network includes multiple modalities across different facilities and equipment types. Payers actively manage these network participation relationships with modality-specific contracted rates, authorization requirements, credentialing verification, and network adequacy tracking. This is an operational business process where network managers create, update, and terminate modality participation agreements as part of network design and provider contracting. | 30 |
| external_distribution | report_distribution | association_data | This association product represents the distribution event between radiology reports and external trading partners. It captures the transmission of a finalized radiology report to an external entity (HIE, referring provider, specialist, payer, patient portal) via interoperability standards. Each record links one report to one trading partner with transmission metadata, delivery status, acknowledgment tracking, and SLA compliance monitoring that exist only in the context of this specific distribution event.. Existence Justification: In healthcare interoperability operations, a single finalized radiology report is routinely distributed to multiple external trading partners (referring providers, specialists, HIEs, patient portals, payers) based on care coordination needs, regulatory requirements, and data sharing agreements. Each trading partner may receive hundreds or thousands of reports over time. The distribution relationship is an operational business process actively managed by interoperability teams, tracking transmission status, acknowledgments, retries, and SLA compliance per partner per report. | 73 |
| external_distribution | transmission | association_data | This association product represents the transmission event between an imaging study and an external trading partner. It captures the operational act of sending DICOM study data to external entities (referring facilities, specialists, teleradiology vendors, HIEs) for care coordination, second opinions, or regulatory reporting. Each record links one imaging study to one trading partner with transmission-specific metadata including delivery status, acknowledgments, retry attempts, and SLA compliance tracking. SSOT for outbound imaging study distribution to external partners.. Existence Justification: In healthcare radiology operations, a single imaging study is routinely transmitted to multiple external trading partners for different clinical purposes: the referring facility receives results, a specialist receives images for consultation, a teleradiology vendor provides after-hours interpretation, and an HIE receives data for regional care coordination. Conversely, each trading partner receives thousands of imaging studies over time from the healthcare organization. The transmission relationship is an operational business process actively managed by radiology IT and PACS administrators, with each transmission tracked for delivery status, acknowledgments, retry attempts, and SLA compliance per the data sharing agreement. | 42 |
| order_management | follow_up | transactional_data | Tracks actionable follow-up recommendations generated from radiology reports, supporting incidental finding management programs. Captures recommendation type (repeat imaging, biopsy, clinical correlation, specialist referral), recommended modality, recommended timeframe, recommendation status (pending, scheduled, completed, declined, lost-to-follow-up), patient notification status, ordering provider notification status, and escalation flag. Supports ACR incidental finding guidelines, CMS quality measures, and population health management workflows. | 54 |
| order_management | imaging_order | transactional_data | Radiology imaging order placed by a provider for diagnostic or therapeutic imaging procedures. | 51 |
| order_management | radiology_appointment | transactional_data | SSOT resolved: defer to scheduling.scheduling_appointment as the single source of truth for this concept. This table is a domain-specific extension/reference. | 101 |
| order_management | radiology_order_status_history | transactional_data | Audit trail of all status transitions for imaging orders throughout the RIS workflow lifecycle. Records each status change event including prior status, new status, status change datetime, status change reason, changed-by user NPI, and source system. Status states include: ordered, scheduled, patient-arrived, exam-started, exam-completed, images-available, preliminary-read, final-read, report-signed, report-delivered, cancelled, and on-hold. Supports workflow analytics, SLA compliance auditing, and RIS process improvement. | 52 |
| order_management | reader_assignment | transactional_data | Association record linking a radiologist (or teleradiology vendor) to an imaging study for interpretation. Captures assignment type (primary reader, second read, peer review, overread, teleradiology), assignment source (worklist auto-assign, manual, teleradiology vendor), vendor details when applicable (vendor name, contract ID, routing reason, vendor accession number), assignment/read start/completion datetimes, turnaround time, subspecialty match, SLA compliance, and assignment status. SSOT for radiologist-to-study assignment including teleradiology routing. Supports worklist management, TAT SLA tracking, teleradiology vendor SLA management, and radiologist productivity reporting. | 50 |
| order_management | teleradiology_case | transactional_data | Manages imaging studies routed to teleradiology vendors or remote radiologists for after-hours, subspecialty, or overflow interpretation. Captures vendor name, vendor contract ID, routing reason (after-hours, subspecialty, overflow), transmission datetime, vendor accession number, expected TAT (turnaround time), actual TAT, preliminary report received datetime, final report received datetime, report reconciliation status, and billing responsibility (professional component ownership). Supports teleradiology vendor SLA management and report reconciliation workflows. | 60 |
| reporting_interpretation | critical_result | transactional_data | Tracks the communication workflow for critical and significant radiology findings requiring immediate clinical action per Joint Commission NPSG.02.03.01. Records finding description, severity level (critical, significant, incidental), notification method (phone, secure message, EHR alert), notified provider NPI, notification datetime, acknowledgment datetime, acknowledgment method, escalation flag, escalation datetime, and Joint Commission compliance status. Supports EMTALA compliance, TJC accreditation requirements, and patient safety event tracking. Aligns with HL7 FHIR CommunicationRequest resource for critical result notification workflows. | 55 |
| reporting_interpretation | radiology_finding |  | Radiology-specific imaging findings with DICOM references, ACR scoring, and follow-up tracking. SSOT consumer extending clinical.clinical_finding with radiology-specific attributes. | 69 |
| reporting_interpretation | radiology_peer_review |  | Tracks radiology-specific peer review using ACR RADPEER scoring methodology, including discrepancy categorization, subspecialty matching, blinded review protocols, and radiology-specific quality metrics for diagnostic accuracy assessment. | 69 |
| reporting_interpretation | report | transactional_data | Authoritative clinical document containing the radiologist's interpretation of an imaging study, including all addenda and amendments as versioned child records. Captures report accession number, report status (preliminary, final, addendum, amended), findings narrative, impression text, critical finding flag, dictation/transcription/attestation timestamps, signing radiologist NPI, addendum history (sequence, type, text, author, datetime), and HL7 ORU message ID. SSOT for radiologist interpretation, diagnostic conclusions, and report amendment history. Aligns with HL7 FHIR DiagnosticReport resource and IHE RAD-28 (Report Workflow). Integrates with Epic ClinDoc and Cerner PowerChart. | 54 |
| reporting_interpretation | report_addendum | transactional_data | Tracks amendments and addenda appended to a finalized radiology report. Records addendum sequence number, addendum type (correction, clarification, clinical update), addendum text, reason for amendment, addendum author NPI, addendum datetime, original report reference, and notification status to ordering provider. Supports HIM (Health Information Management) audit requirements and CDI (Clinical Documentation Improvement) workflows. | 47 |
| study_acquisition | contrast_admin | transactional_data | Transactional record of contrast agent administration events associated with an imaging study. Captures contrast agent name, NDC (National Drug Code), route of administration (IV, oral, intrathecal), dose administered (mL and mg), injection rate, injection site, pre-medication given flag, pre-medication details, adverse reaction flag, adverse reaction description, eGFR value at time of administration, contrast allergy screening result, administering clinician NPI, and administration datetime. Supports patient safety monitoring, contrast reaction tracking, and pharmacy reconciliation. Aligns with ACR Manual on Contrast Media guidelines and HL7 FHIR MedicationAdministration resource. | 59 |
| study_acquisition | dicom_series | master_data | DICOM series within a radiology study, containing series-level metadata and image attributes. | 44 |
| study_acquisition | dose_record | transactional_data | Captures radiation dose metrics for each imaging study involving ionizing radiation (CT, fluoroscopy, nuclear medicine, X-ray). Stores CTDIvol, DLP (Dose Length Product), effective dose estimate (mSv), DAP for fluoroscopy, fluoroscopy time, number of exposures, dose reference level comparison, dose alert flags, RDSR (Radiation Dose Structured Report) UID per IEC 61910 standard, and cumulative patient dose tracking. SSOT for radiation exposure documentation. Supports ACR Dose Index Registry (DIR) reporting, Joint Commission radiation safety requirements, CMS quality programs, and ALARA principle compliance. | 61 |
| study_acquisition | interventional_procedure | transactional_data | Master record for interventional radiology (IR) procedures performed under imaging guidance. Covers vascular, non-vascular, neuro-IR, and oncologic interventions. Captures procedure details, imaging guidance modality, anesthesia type, pre/post diagnoses (ICD-10), complications, specimen collection, fluoroscopy time, radiation dose, and implant tracking (UDI). Supports IR case management, complication tracking, device surveillance, and procedural billing. Integrates with OR scheduling for hybrid suite procedures. Aligns with HL7 FHIR Procedure resource and IHE RAD profiles for interventional reporting. | 82 |
| study_acquisition | modality | master_data | Master reference entity for physical imaging equipment units deployed across enterprise facilities. Captures modality unit identifier, equipment type (CT, MRI, PET-CT, X-ray, ultrasound, fluoroscopy, mammography, nuclear medicine), manufacturer, model, serial number, DICOM AE title, facility location, room assignment, installation date, last calibration date, FDA device registration, ACR accreditation status, and operational status. SSOT for imaging equipment identity within the radiology domain. Supports equipment utilization analytics, maintenance scheduling, and regulatory compliance tracking. | 48 |
| study_acquisition | protocol | reference_data | Defines standardized acquisition protocols for each modality and clinical indication combination. Stores protocol name, modality type, clinical indication, body part, contrast requirement flag, contrast agent type, slice thickness, kVp, mAs, field of view, reconstruction algorithm, scan duration estimate, patient preparation instructions, protocol version, effective date, and approving radiologist. Enables consistent image quality and supports radiation dose optimization programs. Managed within Epic Radiant protocol library. | 55 |
| study_acquisition | radiology_study |  | Canonical radiology study record (ECM superset of MVM radiology.study). Tracks DICOM studies, imaging orders, protocol, dose, and report status across all modalities. | 50 |

<a id="domain-reference"></a>

### Domain: Reference

| Domain | Division | Total Subdomains | Description | Total Products |
|---|---|---|---|---|
| reference | operations | 3 | SSOT for all enterprise reference data and standardized code sets. Owns ICD-10 diagnosis codes, CPT procedure codes, HCPCS codes, DRG (Diagnosis-Related Group) grouper tables, SNOMED CT clinical terms, LOINC observation codes, NDC drug codes, payer master lists, provider taxonomies, geographic codes, and HL7/FHIR value sets. Provides the authoritative terminology consumed by clinical, billing, pharmacy, and quality domains. | 15 |

**Subdomains:** billing_codes, clinical_terminology, registry_directory


**List of Data Products**

| Subdomain | Product | Data Type | Description | Total Attributes |
|---|---|---|---|---|
| billing_codes | condition_code | reference_data | Condition code master for UB-04 and CMS-1500 claim forms with usage notes and payer applicability. | 30 |
| billing_codes | cpt_code | reference_data | Current Procedural Terminology (CPT) code master with RVU values, global periods, NCCI edits, and Medicare payment data. | 37 |
| billing_codes | drg | reference_data | Diagnosis-Related Group (MS-DRG, APR-DRG) master with relative weights, geometric mean LOS, and payment parameters. | 33 |
| billing_codes | hcpcs_code | reference_data | Healthcare Common Procedure Coding System (HCPCS Level II) code master for DME, drugs, supplies, and non-physician services. | 42 |
| billing_codes | major_diagnostic_category | master_data | Major Diagnostic Category (MDC) master for DRG grouping with body system, ICD-10 ranges, and surgical/medical partition. | 33 |
| clinical_terminology | code_set_version | master_data | Code set version master tracking releases, effective dates, and load status for all reference terminologies. | 34 |
| clinical_terminology | crosswalk | reference_data | Code-to-code crosswalk master for terminology mappings (ICD-10 to SNOMED, CPT to HCPCS, etc.) with mapping quality and directionality. | 34 |
| clinical_terminology | fhir_value_set | reference_data | FHIR ValueSet resource master with expansion parameters, binding strength, and canonical URLs for interoperability. | 34 |
| clinical_terminology | icd_code | reference_data | International Classification of Diseases (ICD-9-CM, ICD-10-CM, ICD-10-PCS) code master with billability, CC/MCC flags, and SNOMED CT mappings. | 32 |
| clinical_terminology | loinc_code | reference_data | Logical Observation Identifiers Names and Codes (LOINC) master for laboratory tests, clinical observations, and vital signs. | 34 |
| clinical_terminology | ndc_drug | reference_data | National Drug Code (NDC) master with RxNorm mappings, DEA schedules, formulary status, and package information. | 47 |
| clinical_terminology | snomed_concept | reference_data | SNOMED CT concept master with hierarchies, relationships, and mappings to ICD-10, CPT, LOINC, and RxNorm. | 42 |
| registry_directory | geographic_region | reference_data | Geographic region master with ZIP codes, counties, CBSAs, HRRs, HSAs, and SDOH indicators for population health analytics. | 32 |
| registry_directory | npi_registry | master_data | National Provider Identifier (NPI) registry from NPPES with taxonomy codes, practice locations, and authorized official information. | 58 |
| registry_directory | reference_sdoh_zcode_mapping |  |  | 17 |

<a id="domain-scheduling"></a>

### Domain: Scheduling

| Domain | Division | Total Subdomains | Description | Total Products |
|---|---|---|---|---|
| scheduling | operations | 4 | Appointment and resource scheduling across all care settings. Includes outpatient appointments (Epic Cadence), surgical scheduling (OpTime), procedure scheduling, resource allocation (rooms, equipment, staff), waitlist management, appointment reminders, no-show tracking, and capacity planning. Supports patient access and operational throughput optimization. | 24 |

**Subdomains:** appointment_booking, capacity_management, patient_engagement, surgical_scheduling


**List of Data Products**

| Subdomain | Product | Data Type | Description | Total Attributes |
|---|---|---|---|---|
| appointment_booking | appointment_prior_auth_requirement | association_data | Appointment prior auth requirements | 38 |
| appointment_booking | appointment_status_history | transactional_data | Appointment status history | 44 |
| appointment_booking | appointment_type | reference_data | Master catalog of appointment types defining duration, requirements, and billing characteristics. | 42 |
| appointment_booking | booking_queue | transactional_data | Booking queue | 69 |
| appointment_booking | recall_list | transactional_data | Recall lists | 58 |
| appointment_booking | scheduling_appointment |  | Canonical scheduling appointment record (ECM superset of MVM scheduling.appointment). Tracks all appointment lifecycle events including telehealth, cancellation, and insurance verification. | 59 |
| appointment_booking | telehealth_session | transactional_data | Telehealth sessions | 56 |
| appointment_booking | waitlist_entry | transactional_data | Waitlist entries | 59 |
| capacity_management | capacity_utilization | master_data | Capacity utilization metrics | 50 |
| capacity_management | open_slot | transactional_data | Available appointment slots generated from schedule templates and block time. | 43 |
| capacity_management | provider_availability | transactional_data | Provider availability | 57 |
| capacity_management | resource_assignment | association_data | Resource assignments | 57 |
| capacity_management | schedulable_resource | master_data | Schedulable resources | 43 |
| capacity_management | schedule_template | master_data | Recurring schedule templates defining provider availability patterns and slot configurations. | 48 |
| patient_engagement | appointment_reminder | transactional_data | Appointment reminders | 45 |
| patient_engagement | booking_rule | reference_data | Booking rules | 49 |
| patient_engagement | patient_preference | master_data | Patient scheduling preferences | 42 |
| patient_engagement | reminder_template | master_data | Reminder templates | 57 |
| surgical_scheduling | block_utilization | transactional_data | Block utilization metrics | 43 |
| surgical_scheduling | case_material_usage | association_data | Case material usage | 30 |
| surgical_scheduling | equipment_reservation | transactional_data | Equipment reservations | 57 |
| surgical_scheduling | or_block | master_data | Operating room block time allocations | 44 |
| surgical_scheduling | surgical_case | transactional_data | Surgical case scheduling records including OR time, team, equipment, and case details. | 62 |
| surgical_scheduling | surgical_case_team | association_data | Surgical case team | 66 |

<a id="domain-supply"></a>

### Domain: Supply

| Domain | Division | Total Subdomains | Description | Total Products |
|---|---|---|---|---|
| supply | operations | 2 | Healthcare supply chain and materials management. Owns medical-surgical supplies, implantable device tracking (UDI), prosthetics, procurement, inventory management, requisitions, par-level replenishment, expiration tracking, recall management, vendor management, BOM (Bill of Materials) for surgical procedures, and sterile processing. Integrates with Infor Lawson and SAP MM. | 18 |

**Subdomains:** inventory_management, supply_sourcing


**List of Data Products**

| Subdomain | Product | Data Type | Description | Total Attributes |
|---|---|---|---|---|
| inventory_management | inventory_balance | master_data | Current inventory balances by location and material. | 56 |
| inventory_management | inventory_location | master_data | Physical locations where inventory is stored. | 54 |
| inventory_management | inventory_transaction | transactional_data | All inventory movements and transactions. | 57 |
| inventory_management | location_audit | association_data | Audit records for inventory locations. | 81 |
| inventory_management | material_policy_governance | association_data | Governance and policy compliance for materials. | 71 |
| supply_sourcing | case_cart | transactional_data | Case carts assembled for surgical procedures. | 57 |
| supply_sourcing | goods_receipt | transactional_data | Goods receipt records for materials received from vendors. | 53 |
| supply_sourcing | material_master | master_data | Master data for all materials, supplies, devices, and pharmaceuticals managed in the supply chain. | 68 |
| supply_sourcing | purchase_order | transactional_data | Purchase orders issued to vendors for materials and services. | 57 |
| supply_sourcing | purchase_order_line | transactional_data | Line items on purchase orders. | 56 |
| supply_sourcing | recall_notice | transactional_data | Product recall notices and remediation tracking. | 79 |
| supply_sourcing | requisition | transactional_data | Internal requisitions for materials and supplies. | 55 |
| supply_sourcing | sterile_processing_record | transactional_data | Sterile processing and sterilization records for surgical instruments and devices. | 53 |
| supply_sourcing | surgical_bom | master_data | Bill of materials for surgical procedures. | 51 |
| supply_sourcing | udi_record | master_data | Unique Device Identifier records for implantable and trackable devices. | 51 |
| supply_sourcing | vendor | master_data | Vendor master data for all suppliers of materials, services, and equipment. | 64 |
| supply_sourcing | vendor_contract | master_data | Contracts with vendors for supply and services. | 70 |
| supply_sourcing | vendor_site | master_data | Physical sites and locations for vendors. | 67 |

<a id="domain-billing"></a>

### Domain: Billing

| Domain | Division | Total Subdomains | Description | Total Products |
|---|---|---|---|---|
| billing | business | 4 | SSOT for all revenue cycle management (RCM) activities. Owns charge capture, CDM (Charge Description Master), professional and facility billing (CMS-1500, UB-04), coding (ICD-10, CPT, DRG), claim generation, payment posting, patient statements, collections, bad debt, contractual adjustments, ERA/EOB processing, and denial management. Integrates with Epic Resolute PB/HB, 3M HIS, and Cerner Revenue Cycle. | 21 |

**Subdomains:** account_collections, charge_capture, invoice_billing, payment_reconciliation


**List of Data Products**

| Subdomain | Product | Data Type | Description | Total Attributes |
|---|---|---|---|---|
| account_collections | charity_care_application | transactional_data | Billing domain product: charity_care_application | 9 |
| account_collections | collection_account | transactional_data | Billing domain product: collection_account | 9 |
| account_collections | patient_account | master_data | Billing domain product: patient_account | 9 |
| charge_capture | cdm_entry | master_data | Charge Description Master entry defining billable items and their standard prices | 48 |
| charge_capture | charge | transactional_data | Individual billable charge for services, procedures, supplies, or medications | 66 |
| charge_capture | coding_assignment | transactional_data | Billing domain product: coding_assignment | 9 |
| charge_capture | site_cdm_pricing | association_data | Billing domain product: site_cdm_pricing | 61 |
| invoice_billing | billing_coverage | master_data | Billing domain product: billing_coverage | 11 |
| invoice_billing | billing_network_participation |  | DEPRECATED - consolidate into insurance.network_participation (participant_type='billing'). Retained for backward compatibility. Consolidated into insurance.network_participation (participant_type='billing'). | 13 |
| invoice_billing | invoice | transactional_data | Billing domain product: invoice | 9 |
| invoice_billing | invoice_coverage_billing | association_data | Billing domain product: invoice_coverage_billing | 9 |
| invoice_billing | invoice_line | transactional_data | Billing domain product: invoice_line | 9 |
| invoice_billing | invoice_line_item | association_data | Billing domain product: invoice_line_item | 9 |
| invoice_billing | statement | transactional_data | Billing domain product: statement | 9 |
| invoice_billing | study_service_coverage | association_data | Billing domain product: study_service_coverage | 9 |
| payment_reconciliation | adjustment | transactional_data | Billing domain product: adjustment | 9 |
| payment_reconciliation | payment | transactional_data | Billing domain product: payment | 9 |
| payment_reconciliation | payment_plan | master_data | Billing domain product: payment_plan | 9 |
| payment_reconciliation | rac_audit | transactional_data | Billing domain product: rac_audit | 9 |
| payment_reconciliation | refund | master_data | Billing domain product: refund | 9 |
| payment_reconciliation | write_off | transactional_data | Billing domain product: write_off | 9 |

<a id="domain-claim"></a>

### Domain: Claim

| Domain | Division | Total Subdomains | Description | Total Products |
|---|---|---|---|---|
| claim | business | 3 | Insurance claims processing and payer adjudication. Owns claim submission, claim status tracking, payer adjudication, remittance advice (ERA - Electronic Remittance Advice), EOB (Explanation of Benefits), denial management, appeals, prior authorization, eligibility verification, payer contract management, RAC audit responses, and coordination of benefits across HMO, PPO, POS, Medicare, and Medicaid payers. | 16 |

**Subdomains:** authorization_eligibility, claim_submission, payment_reconciliation


**List of Data Products**

| Subdomain | Product | Data Type | Description | Total Attributes |
|---|---|---|---|---|
| authorization_eligibility | authorization_service | transactional_data | Individual service lines within a prior authorization showing approved units and amounts. | 38 |
| authorization_eligibility | eligibility | transactional_data | Tracks real-time eligibility verification requests and responses from payers. | 48 |
| authorization_eligibility | prior_authorization | master_data | Tracks prior authorization requests and approvals required before service delivery. | 43 |
| claim_submission | attachment | Master | Tracks clinical documentation and attachments submitted with claims. | 55 |
| claim_submission | claim | master_data | Core claim record representing a request for payment from a payer for healthcare services rendered. | 56 |
| claim_submission | diagnosis_link | transactional_data | Links diagnosis codes to claims for medical necessity and DRG grouping. | 34 |
| claim_submission | line | transactional_data | Individual service line within a claim, representing a single billable service or item. | 50 |
| claim_submission | status_history | transactional_data | SSOT resolved: defer to order.order_status_history as the single source of truth for this concept. This table is a domain-specific extension/reference. | 36 |
| claim_submission | study_attribution | association_data | Links claims to research studies for billing attribution and coverage analysis. | 21 |
| claim_submission | submission | transactional_data | Tracks claim submission events to payers including EDI transmission details. | 48 |
| payment_reconciliation | appeal | transactional_data | Tracks claim appeals filed with payers to overturn denials. | 47 |
| payment_reconciliation | audit_sample | association_data | Tracks claims selected for audit review including RAC, ZPIC, and internal audits. | 20 |
| payment_reconciliation | cob | transactional_data | Tracks coordination of benefits when patient has multiple insurance coverages. | 43 |
| payment_reconciliation | denial | master_data | Tracks denied claims and denial management workflow including appeals. | 56 |
| payment_reconciliation | remittance | transactional_data | Electronic remittance advice (ERA) from payers detailing payment and adjustments. | 52 |
| payment_reconciliation | remittance_line | transactional_data | Individual service line detail within an ERA showing payment and adjustment details. | 55 |

<a id="domain-insurance"></a>

### Domain: Insurance

| Domain | Division | Total Subdomains | Description | Total Products |
|---|---|---|---|---|
| insurance | business | 5 | Master data management for insurance payers, health plans, benefit structures, provider networks, and coverage policies. SSOT for payer identity, plan configurations, network definitions, and benefit rules that are referenced by billing, claim, patient, and encounter domains. | 35 |

**Subdomains:** member_enrollment, network_contracting, plan_design, utilization_authorization, value_payment


**List of Data Products**

| Subdomain | Product | Data Type | Description | Total Attributes |
|---|---|---|---|---|
| member_enrollment | accumulator | transactional_data | Running total of deductible, out-of-pocket, and benefit usage for a member in a benefit period. | 28 |
| member_enrollment | broker | master_data | Insurance broker or agent facilitating health plan sales and enrollment. | 24 |
| member_enrollment | dependent | master_data | Dependent covered under a subscriber's insurance policy. | 41 |
| member_enrollment | eligibility_span | master_data | Time-bound eligibility period for a member in a health plan with coverage details. | 49 |
| member_enrollment | employer_group | master_data | Employer group purchasing health insurance for employees. | 49 |
| member_enrollment | member_enrollment | transactional_data | Patient enrollment in a health plan with coverage dates, PCP assignment, and eligibility status. | 47 |
| member_enrollment | premium_billing | transactional_data | Premium billing record for a subscriber or employer group with payment status. | 32 |
| member_enrollment | subscriber | master_data | Primary insurance subscriber (policyholder) with demographics and coverage details. | 46 |
| network_contracting | fee_schedule | master_data | Fee schedule defining reimbursement rates for services under a payer contract. | 48 |
| network_contracting | fee_schedule_line | master_data | Individual line item in a fee schedule specifying reimbursement for a specific procedure or service. | 52 |
| network_contracting | insurance_network_participation |  | Provider (clinician or facility) participation in an insurance network with credentialing and status. Consolidated into insurance.network_participation (participant_type='insurance'). | 51 |
| network_contracting | insurance_network_participation2 |  | Single source of truth for network participation across billing, insurance, and provider domains; use participant_type to distinguish. pharmacy.pharmacy_network_participation retained separately (PBM domain). | 19 |
| network_contracting | insurance_payer_enrollment | association_data | SSOT resolved: defer to provider.provider_payer_enrollment as the single source of truth for this concept. This table is a domain-specific extension/reference. | 62 |
| network_contracting | network_adequacy | transactional_data | Network adequacy assessment measuring provider availability and access standards for a network. | 33 |
| network_contracting | payer_contact | master_data | Contact person at a payer organization for provider relations, claims, or contracting. | 25 |
| network_contracting | payer_contract | master_data | Contract between provider organization and payer defining reimbursement terms and obligations. | 54 |
| network_contracting | plan_network | association_data | Association between a health plan and a provider network with tier and cost-sharing rules. | 38 |
| network_contracting | provider_network | master_data | Network of contracted providers (clinicians, facilities) for a payer or health plan. | 43 |
| plan_design | benefit | master_data | Specific benefit coverage detail within a health plan (service type, cost-sharing, limits). | 53 |
| plan_design | coverage_policy | master_data | Medical policy defining coverage criteria, prior auth requirements, and medical necessity for services. | 50 |
| plan_design | formulary_tier | master_data | Formulary tier assignment for a drug in a health plan's formulary with cost-sharing rules. | 26 |
| plan_design | health_plan | master_data | Specific health insurance plan offered by a payer with defined benefits, networks, and cost-sharing. | 56 |
| plan_design | payer | master_data | Insurance payer organization (commercial, government, self-pay) that adjudicates and pays claims. | 51 |
| utilization_authorization | coordination_of_benefits | master_data | Coordination of benefits determination when a member has multiple insurance coverages. | 31 |
| utilization_authorization | payer_compliance_requirement | association_data | Compliance requirement imposed by a payer (e.g., quality reporting, data submission, audit participation). | 25 |
| utilization_authorization | plan_consent_requirement | association_data | Consent requirement for a health plan (e.g., data sharing, care coordination, telehealth). | 25 |
| utilization_authorization | prior_auth_rule | master_data | Rule defining when prior authorization is required for a service, procedure, or diagnosis. | 51 |
| utilization_authorization | utilization_review | transactional_data | Utilization review decision (concurrent, retrospective, prospective) for medical necessity and appropriateness. | 50 |
| value_payment | accountable_care_organization | master_data | Accountable care organization (ACO) participating in value-based care programs. | 27 |
| value_payment | capitation_contract | master_data | Capitation contract defining per-member-per-month payment to provider for defined services. | 42 |
| value_payment | capitation_payment | transactional_data | Capitation payment made to provider for a defined member panel and time period. | 36 |
| value_payment | member_attribution | transactional_data | Attribution of a member to a primary care provider or accountable care organization for quality and cost accountability. | 27 |
| value_payment | risk_adjustment | transactional_data | Risk adjustment score (HCC, RAF) for a member used in capitation and quality payment calculations. | 24 |
| value_payment | third_party_administrator | master_data | Third-party administrator (TPA) managing claims and benefits for self-funded employer groups. | 21 |
| value_payment | vbc_performance | transactional_data | Value-based care performance metrics for a provider or group under a VBC contract. | 33 |

<a id="domain-patient"></a>

### Domain: Patient

| Domain | Division | Total Subdomains | Description | Total Products |
|---|---|---|---|---|
| patient | business | 5 | Master data for all individuals receiving healthcare services. SSOT for patient identity, demographics, MRN (Medical Record Number), MPI (Master Patient Index), insurance coverage, emergency contacts, consent records, SDOH (Social Determinants of Health), patient preferences, and PHI-protected identity information. Referenced by every clinical and financial domain via patient_id FK. | 35 |

**Subdomains:** coverage_financial, engagement_communication, patient_identity, population_care, social_determinants


**List of Data Products**

| Subdomain | Product | Data Type | Description | Total Attributes |
|---|---|---|---|---|
| coverage_financial | eligibility_check | transactional_data | Real-time and batch insurance eligibility verification transaction records capturing verification date and time, payer queried, verification method (270/271 EDI, portal, phone), eligibility status returned, coverage details confirmed, copay/deductible amounts verified, prior authorization requirements, and verification source system. Supports front-end RCM workflows and reduces claim denials. Sourced from Epic Resolute and Cerner Revenue Cycle eligibility modules. | 51 |
| coverage_financial | financial_assistance | transactional_data | Patient financial assistance and charity care application records capturing application date, assistance program type (charity care, Medicaid presumptive eligibility, sliding fee scale, payment plan, financial hardship), application status, income verification method, federal poverty level percentage, approved assistance amount or discount percentage, approval date, and expiration date. Supports RCM financial counseling, 501(c)(3) community benefit reporting, and uncompensated care tracking. Sourced from EHR revenue cycle and financial counseling modules. | 59 |
| coverage_financial | insurance_coverage | master_data | Patient insurance coverage, eligibility, and verification records. Captures payer name, plan name, plan type (HMO, PPO, POS, Medicare, Medicaid, self-pay), member ID, group number, subscriber relationship, coverage effective and termination dates, coordination of benefits (COB) priority, copay/deductible/out-of-pocket amounts, pre-authorization requirements, and real-time/batch eligibility verification transactions (270/271 EDI, portal, phone) with verification status, confirmed coverage details, verification date/time, payer queried, and verification audit trail. SSOT for patient payer eligibility and verification consumed by billing and claims domains. Supports front-end RCM workflows, claim denial prevention, and prior authorization management. Aligned with X12 270/271 transaction standards and HL7 FHIR Coverage resource. Sourced from EHR revenue cycle and eligibility verification modules. | 50 |
| coverage_financial | patient_coverage |  | SSOT resolved: defer to billing.billing_coverage as the single source of truth for this concept. This table is a domain-specific extension/reference. | 33 |
| engagement_communication | communication_campaign | master_data | Master reference table for communication_campaign. Referenced by campaign_id. | 71 |
| engagement_communication | communication_log | master_data | Patient communication and correspondence history capturing outreach type (appointment reminder, care gap notification, preventive screening outreach, billing statement, post-discharge follow-up, population health campaign), communication channel (phone call, SMS, email, patient portal message, postal mail), communication date, sender, recipient, delivery status, patient response, opt-out preferences, and campaign linkage. Supports patient engagement workflows, care gap closure tracking, CAHPS communication metrics, and population health outreach effectiveness analysis. Aligned with HL7 FHIR Communication resource. Sourced from patient engagement platforms, care management systems, and outreach automation tools. | 71 |
| engagement_communication | consent_reference | master_data | Lightweight reference record linking a patient to their consent records in the consent domain SSOT. Captures patient_id and consent_master_id FK for cross-domain joins. | 56 |
| engagement_communication | message_template | master_data | Master reference table for message_template. Referenced by message_template_id. | 60 |
| engagement_communication | portal_account | master_data | Patient portal and digital engagement account record capturing portal platform, account creation date, activation status, last login date, two-factor authentication enrollment, proxy access grants (parent/guardian, adult caregiver, legal guardian, healthcare POA) with proxy identity, access levels (full, limited, view-only), authorization and expiration dates, revocation dates, supporting legal documentation references, messaging opt-in status, appointment self-scheduling enablement, and digital health app linkages. SSOT for patient digital engagement and proxy access management. Supports patient engagement, HIPAA-compliant proxy access, MIPS Promoting Interoperability measures, and digital front door strategy. Aligned with HL7 FHIR RelatedPerson resource for proxy relationships. Sourced from patient portal and proxy management systems. | 55 |
| engagement_communication | preference | master_data | Patient care and communication preferences capturing preferred language for care, interpreter needs, preferred communication channel (phone, portal, mail, text), preferred pharmacy, PCP preference, care setting preferences, accessibility needs (hearing, vision, mobility), cultural and religious care preferences, and patient portal enrollment status. Supports patient-centered care delivery, CAHPS survey performance, and health equity initiatives. Sourced from EHR registration and patient engagement platforms. | 55 |
| engagement_communication | proxy_access | master_data | Patient proxy and authorized representative access records capturing proxy type (parent/guardian, adult caregiver, legal guardian, healthcare power of attorney), proxy identity, access level granted (full, limited, view-only), authorization date, expiration date, revocation date, and supporting legal documentation reference. Supports HIPAA-compliant proxy access management in patient portals and clinical settings. Sourced from Epic MyChart proxy management. | 53 |
| patient_identity | address | master_data | Patient address records supporting multiple address types (home, mailing, temporary, work) with full address components, geocoding coordinates, county/census tract for SDOH analysis, address validation status, effective date ranges, and do-not-mail flags. Supports population health outreach, care gap closure, and SDOH stratification. Sourced from Epic and Cerner registration systems. | 58 |
| patient_identity | demographics | master_data | Core patient demographic profile — legal name, date of birth, gender identity, sex assigned at birth, race, ethnicity, preferred language, marital status, religion, addresses (home, mailing, temporary, work with geocoding and SDOH census tract linkage), phone numbers, email, emergency contacts with authorization levels and healthcare proxy designations, deceased status (date, cause, manner of death, death certificate reference), and PHI-protected identity attributes. SSOT for patient identity attributes downstream of MPI, multi-address management, and emergency contact records. Supports population health outreach, EMTALA-compliant emergency contact access, vital statistics reporting, and population health stratification. Compliant with HIPAA PHI classification, CMS demographic data requirements, and aligned with HL7 FHIR Patient resource demographics elements. Sourced from EHR registration modules, ADT systems, and state vital records. | 60 |
| patient_identity | emergency_contact | master_data | Patient emergency contact records capturing contact name, relationship type, priority order, phone numbers (home, mobile, work), address, and authorization level (e.g., authorized to receive PHI, healthcare proxy, legal guardian). Supports EMTALA compliance, care coordination, and discharge planning workflows. Sourced from Epic and Cerner registration modules. | 52 |
| patient_identity | flag | master_data | Patient-level clinical and administrative alert flags capturing flag type (VIP, behavioral alert, fall risk, latex allergy, infectious precaution, financial hardship, interpreter needed, AMA history, legal hold, safety risk), flag severity, flag description, onset and expiration dates, flagging provider or staff, and active status. Persistent patient-level flags that travel with the patient across encounters — distinct from encounter-specific clinical alerts. Supports safe care delivery, staff safety, and administrative workflows across all care settings. Sourced from EHR clinical alert and patient safety systems. | 59 |
| patient_identity | guarantor | master_data | Financial guarantor record identifying the individual or entity responsible for patient account balances. Captures guarantor name, relationship to patient, address, phone, employer information, SSN (masked), and account responsibility percentage. Supports RCM billing workflows, patient financial counseling, and self-pay collection processes. Sourced from EHR revenue cycle and patient accounting modules. | 58 |
| patient_identity | identity_merge_history | transactional_data | Patient identity merge and unmerge history records tracking MPI overlay events, duplicate patient record resolution, surviving and non-surviving MRNs, merge rationale, merge algorithm used, merge confidence score, approving HIM analyst, merge date, and reversal history. Critical for MPI integrity, HIPAA compliance, and audit trail requirements. Sourced from Epic MPI management and 3M HIS tools. | 51 |
| patient_identity | mpi_record | master_data | Enterprise Single Source of Truth (SSOT) for patient identity across multi-facility health systems. The Master Patient Index record serves as the authoritative golden record for patient identity resolution, linking all facility-specific MRNs, demographic data, and identity attributes into a unified enterprise patient identity. Supports EMPI matching algorithms, identity confidence scoring, merge/unmerge workflows, and cross-facility patient linking for integrated delivery networks (IDNs) and health information exchanges (HIEs). | 59 |
| patient_identity | mrn_crosswalk | reference_data | Cross-facility and cross-system MRN (Medical Record Number) crosswalk table mapping a patient's enterprise patient_id to facility-specific MRNs, EHR system identifiers (Epic EMPI, Cerner EUID), payer member IDs, and external HIE identifiers. Enables enterprise-wide patient matching and identity resolution across Epic, Cerner, MEDITECH, and HIE platforms. Sourced from MPI and ADT integration layers. | 57 |
| patient_identity | registration_event | transactional_data | Patient registration lifecycle event records capturing event type (new registration, pre-registration, update, merge, unmerge), registration date and time, registering facility, registration source (ED walk-in, scheduled, transfer, online pre-registration), registration completeness score, identity verification method (photo ID, insurance card, biometric), and registration staff. Provides the audit trail for patient identity creation and maintenance events within the MPI lifecycle. Distinct from encounter-level ADT events — this product tracks identity/registration events, not clinical visit movements. Sourced from EHR ADT and registration modules. | 54 |
| population_care | attribution_panel | master_data | Master reference table for attribution_panel. Referenced by attribution_panel_id. | 53 |
| population_care | care_program | master_data | Master reference table for care_program. Referenced by program_id. | 61 |
| population_care | care_program_enrollment | transactional_data | Patient population health segmentation, risk stratification, and care program enrollment records. Captures segment type (chronic disease cohort, high-risk, rising-risk, healthy), risk tier, risk score source (CMS HCC, ACG, proprietary), chronic condition flags (diabetes, CHF, COPD, CKD), care gap count, stratification model version, last stratification date, program name, enrollment and disenrollment dates, program status, assigned care manager, care plan linkage, enrollment source, and program outcomes. SSOT for population health segmentation and care management program participation. Supports ACO performance, PCMH workflows, HEDIS measure targeting, chronic disease management, and value-based care reporting. Sourced from population health management platforms and care management systems. | 39 |
| population_care | pcp_attribution | master_data | Patient attribution to Primary Care Physician (PCP) or care team records capturing attributed provider NPI, attribution method (claims-based, enrollment-based, manual), attribution panel, attribution effective and end dates, ACO/HMO/PPO plan attribution, and attribution confidence score. SSOT for care team assignment used in population health, HEDIS, MIPS, and value-based care reporting. Sourced from population health management and payer attribution feeds. | 58 |
| population_care | population_segment | master_data | Patient population segmentation and risk stratification records capturing segment type (chronic disease cohort, high-risk, rising-risk, healthy), risk tier, risk score source (CMS HCC, ACG, proprietary), attributed care program, chronic condition flags (diabetes, CHF, COPD, CKD), care gap count, last stratification date, and stratification model version. Supports population health management, ACO performance, and HEDIS measure targeting. Sourced from Epic Healthy Planet. | 63 |
| population_care | program_enrollment | association_data | This association product represents the enrollment relationship between patients and quality programs. It captures patient participation in CMS Value-Based Purchasing, MIPS, HEDIS, ACO, and other quality improvement programs. Each record links one patient to one quality program with enrollment dates, risk stratification, eligibility status, and program-specific performance tracking. SSOT for quality program membership, risk tier assignment, and patient-level program participation tracking. Supports CMS quality reporting, risk-adjusted outcome calculation, and program-specific patient cohort identification.. Existence Justification: In healthcare quality operations, patients are simultaneously enrolled in multiple quality programs (e.g., a patient may be enrolled in Hospital VBP, HEDIS, ACO REACH, and internal care management programs at the same time). Each quality program tracks many patients for performance measurement, risk stratification, and outcome reporting. The enrollment relationship is actively managed by quality teams who create enrollment records, assign risk tiers, track eligibility periods, and manage disenrollments based on program-specific criteria. | 73 |
| population_care | quality_measure_evaluation | association_data | This association product represents the evaluation of individual patients against specific quality measures across measurement periods. It captures population health gap management, quality reporting compliance tracking, and patient-level measure performance. Each record links one patient demographics profile to one quality measure with attributes tracking eligibility determination, compliance status, gap identification, and closure activities. This is the operational foundation for HEDIS reporting, CMS eCQM submission, MIPS quality performance, value-based care gap closure workflows, and population health outreach campaigns.. Existence Justification: In healthcare quality management, each patient is evaluated against multiple quality measures (HEDIS, CMS eCQMs, MIPS) across measurement years, and each quality measure is evaluated against thousands of eligible patients. The business actively manages these patient-measure evaluations as operational records, tracking denominator eligibility, numerator compliance, gap identification, outreach attempts, and closure activities. This is the core operational entity for population health gap closure workflows, HEDIS submission, VBP performance improvement, and care management prioritization. | 43 |
| social_determinants | chw_intervention |  | Community health worker intervention log for SDOH needs | 66 |
| social_determinants | community_resource |  | Community resource directory entry for SDOH referrals | 78 |
| social_determinants | sdoh_assessment | transactional_data | Social Determinants of Health (SDOH) assessment records capturing screening tool used (AHC HRSN, PRAPARE, Hunger Vital Sign, WHO WHOQOL), assessment date, domain scores (food insecurity, housing instability, transportation, interpersonal safety, financial strain, social isolation), identified needs, referral disposition, and reassessment schedule. Supports population health management, ACO quality reporting, CMS SDOH initiatives, and community health needs assessments. Aligned with HL7 FHIR SDOH Clinical Care implementation guide and Gravity Project value sets. Sourced from population health and care management platforms. | 65 |
| social_determinants | sdoh_need_closure |  | SDOH need closure tracking per identified social need | 80 |
| social_determinants | sdoh_referral |  | SDOH referral to a community resource with tracking status | 90 |
| social_determinants | sdoh_risk_score |  | SDOH risk stratification / priority score per patient | 44 |
| social_determinants | sdoh_risk_stratification |  | SDOH risk stratification cohort assignment | 86 |
| social_determinants | sdoh_zcode_mapping |  | ICD-10 Z-code to SDOH category crosswalk | 57 |

<a id="domain-provider"></a>

### Domain: Provider

| Domain | Division | Total Subdomains | Description | Total Products |
|---|---|---|---|---|
| provider | business | 4 | Authoritative repository for all healthcare professionals and organizational providers. Includes physicians, nurses, allied health professionals, NPI (National Provider Identifier), DEA numbers, credentials, specialties, licensure, hospital privileges, credentialing status, payer enrollment, and provider network affiliations. SSOT for provider identity and authorization. | 32 |

**Subdomains:** credentialing_compliance, network_enrollment, practice_engagement, provider_registry


**List of Data Products**

| Subdomain | Product | Data Type | Description | Total Attributes |
|---|---|---|---|---|
| credentialing_compliance | board_certification | master_data | Board certifications | 11 |
| credentialing_compliance | cme_activity | transactional_data | CME activities | 10 |
| credentialing_compliance | committee | master_data | SSOT resolved: defer to quality.committee as the single source of truth for this concept. This table is a domain-specific extension/reference. | 11 |
| credentialing_compliance | credential | master_data | Individual credentials (licenses, certifications, DEA, board certs) with expiration tracking | 50 |
| credentialing_compliance | credentialing_application | transactional_data | Initial and reappointment credentialing applications with committee review workflow | 61 |
| credentialing_compliance | credentialing_file | master_data | Credentialing file documents | 10 |
| credentialing_compliance | dea_registration | master_data | DEA registration tracking | 11 |
| credentialing_compliance | education_training | master_data | Education and training history | 11 |
| credentialing_compliance | malpractice_coverage | master_data | Malpractice insurance coverage with limits and tail coverage tracking | 46 |
| credentialing_compliance | npdb_query | transactional_data | National Practitioner Data Bank queries and responses | 49 |
| credentialing_compliance | peer_reference | transactional_data | Peer references | 11 |
| credentialing_compliance | privileging | master_data | Clinical privileges granted to providers at specific facilities | 48 |
| credentialing_compliance | reappointment | transactional_data | Reappointment cycles | 10 |
| credentialing_compliance | sanction | transactional_data | Provider sanctions, exclusions, and adverse actions (OIG, SAM, state boards) | 54 |
| network_enrollment | affiliation | association_data | Provider affiliations | 9 |
| network_enrollment | affiliation_history | transactional_data | Provider affiliation history | 10 |
| network_enrollment | network_affiliation | transactional_data | Provider participation in payer networks with tier and panel status | 48 |
| network_enrollment | provider_network_participation |  | DEPRECATED - consolidate into insurance.network_participation (participant_type='provider'). Retained for backward compatibility. Consolidated into insurance.network_participation (participant_type='provider'). | 16 |
| network_enrollment | provider_payer_enrollment |  | Provider enrollment with payers (Medicare, Medicaid, commercial plans) | 55 |
| network_enrollment | telehealth_authorization | master_data | Telehealth authorizations | 10 |
| practice_engagement | assignment | association_data | Provider assignments | 50 |
| practice_engagement | preference_card | association_data | Surgeon preference cards | 9 |
| practice_engagement | study_team_member | association_data | Research study team members | 10 |
| practice_engagement | survey_participation | association_data | Provider survey participation | 9 |
| provider_registry | clinician | master_data | Individual healthcare providers (physicians, NPs, PAs, etc.) with clinical credentials | 55 |
| provider_registry | group | master_data | Provider groups (medical groups, IPAs, ACOs) with group NPI and TIN | 49 |
| provider_registry | group_membership | transactional_data | Provider membership in groups with FTE allocation and role | 48 |
| provider_registry | location_specialty |  |  | 10 |
| provider_registry | org_provider | master_data | Organizational providers (hospitals, clinics, labs, DME suppliers) | 54 |
| provider_registry | provider_location |  | Provider practice locations | 30 |
| provider_registry | specialty | reference_data | Clinical specialties and subspecialties with credentialing and enrollment rules | 48 |
| provider_registry | taxonomy | reference_data | NUCC taxonomy codes | 9 |

<a id="domain-compliance"></a>

### Domain: Compliance

| Domain | Division | Total Subdomains | Description | Total Products |
|---|---|---|---|---|
| compliance | corporate | 4 | Enterprise regulatory compliance management for HIPAA, CMS Conditions of Participation, state health department regulations, Joint Commission standards, OSHA healthcare worker safety, and all mandatory reporting obligations. Owns compliance program definitions, regulatory requirement tracking, audit management, policy governance, and compliance training records. | 31 |

**Subdomains:** audit_monitoring, regulatory_governance, risk_investigation, workforce_attestation


**List of Data Products**

| Subdomain | Product | Data Type | Description | Total Attributes |
|---|---|---|---|---|
| audit_monitoring | audit | transactional_data | Compliance audits conducted by internal or external auditors to assess adherence to regulations and policies | 56 |
| audit_monitoring | audit_finding | transactional_data | Individual findings identified during compliance audits | 55 |
| audit_monitoring | compliance_regulatory_submission | transactional_data | SSOT resolved: defer to research.research_regulatory_submission as the single source of truth for this concept. This table is a domain-specific extension/reference. | 62 |
| audit_monitoring | corrective_action_plan | transactional_data | Corrective action plans developed to address audit findings and compliance gaps | 50 |
| audit_monitoring | exclusion_screening | transactional_data | Screening of employees and providers against federal and state exclusion lists | 45 |
| audit_monitoring | monitoring_activity | transactional_data | Ongoing compliance monitoring activities and reviews | 51 |
| audit_monitoring | phi_access_log | transactional_data | Audit logs of PHI access for compliance monitoring | 49 |
| regulatory_governance | accreditation_status | master_data | Accreditation status for various programs and services | 50 |
| regulatory_governance | cms_condition_status | master_data | CMS Conditions of Participation compliance status tracking | 53 |
| regulatory_governance | compliance_policy | master_data | Organizational policies that define compliance requirements, procedures, and standards | 48 |
| regulatory_governance | compliance_program | master_data | Organizational compliance programs covering regulatory frameworks, policies, audits, and training requirements | 47 |
| regulatory_governance | obligation | master_data | Specific compliance obligations derived from regulatory requirements, policies, and program mandates | 49 |
| regulatory_governance | policy_payer_applicability | association_data | Payer-specific policy applicability and requirements | 20 |
| regulatory_governance | policy_regulatory_impact | association_data | Mapping of policies to regulatory requirements they satisfy | 17 |
| regulatory_governance | policy_version | transactional_data | Version history and change tracking for compliance policies | 36 |
| regulatory_governance | program_policy_assignment | association_data | Assignment of policies to compliance programs | 19 |
| regulatory_governance | regulatory_change | master_data | Tracking of regulatory changes and their impact on compliance programs | 49 |
| regulatory_governance | regulatory_requirement | master_data | Master list of regulatory requirements applicable to the organization | 46 |
| risk_investigation | conflict_of_interest | transactional_data | Conflict of interest disclosures and management | 40 |
| risk_investigation | hipaa_privacy_incident | transactional_data | HIPAA privacy incidents and breaches requiring investigation and reporting | 52 |
| risk_investigation | hipaa_security_risk | transactional_data | HIPAA security risks identified through risk assessments and security evaluations | 49 |
| risk_investigation | hotline_report | transactional_data | Reports submitted through compliance hotline or reporting mechanisms | 48 |
| risk_investigation | investigation | transactional_data | Compliance investigations of reported incidents and allegations | 46 |
| risk_investigation | osha_exposure_incident | transactional_data | OSHA-reportable exposure incidents and workplace injuries | 52 |
| risk_investigation | stark_arrangement | master_data | Physician financial arrangements subject to Stark Law review | 44 |
| workforce_attestation | attestation | transactional_data | Employee and provider attestations for compliance requirements | 51 |
| workforce_attestation | business_associate_agreement | master_data | HIPAA Business Associate Agreements with third-party vendors | 49 |
| workforce_attestation | notice_of_privacy_practices | transactional_data | Notice of Privacy Practices versions and patient acknowledgments | 47 |
| workforce_attestation | osha_safety_program | master_data | OSHA workplace safety programs and compliance initiatives | 48 |
| workforce_attestation | training | master_data | Compliance training programs and courses required for staff | 53 |
| workforce_attestation | training_completion | transactional_data | Individual employee completion records for compliance training | 44 |

<a id="domain-finance"></a>

### Domain: Finance

| Domain | Division | Total Subdomains | Description | Total Products |
|---|---|---|---|---|
| finance | corporate | 5 | Healthcare financial management including general ledger, cost accounting, budgeting, financial reporting, accounts payable, accounts receivable reconciliation, capital budgeting, and financial planning. Owns chart of accounts, journal entries, cost centers, budget allocations, and financial period management. | 39 |

**Subdomains:** budget_planning, capital_assets, fund_management, general_ledger, payables_receivables


**List of Data Products**

| Subdomain | Product | Data Type | Description | Total Attributes |
|---|---|---|---|---|
| budget_planning | allocation_method | reference_data | Reference master defining the cost allocation methodologies and statistical basis configurations used in the healthcare cost accounting process. Captures method code, method name, method type (step-down, direct, reciprocal, activity-based costing), allocation basis type (square footage, FTE count, revenue, RVU, patient days, procedures), basis data source, weighting factor, effective date range, and applicable cost report schedule (Medicare Cost Report Schedule). Governs how overhead costs are distributed across clinical and administrative departments. | 53 |
| budget_planning | allocation_run | master_data | Master reference table for allocation_run. Referenced by allocation_run_id. | 49 |
| budget_planning | budget | master_data | Budget header defining budget versions, scenarios, and metadata | 43 |
| budget_planning | budget_line | master_data | Budget line detail with account, amount, and allocation attributes | 35 |
| budget_planning | budget_transfer | transactional_data | Transactional record of approved budget transfers and amendments between cost centers, accounts, or periods within an approved budget. Captures transfer date, transfer type (budget amendment, budget transfer, budget revision), source budget line, destination budget line, transfer amount, transfer reason, requestor, approver, approval date, and supporting documentation reference. Maintains a complete audit trail of all budget modifications post-approval. | 43 |
| budget_planning | cost_allocation | transactional_data | Transactional record of overhead and indirect cost allocations distributed from overhead cost centers to direct patient care cost centers using defined allocation methodologies. Captures allocation run ID, fiscal period, allocation method (step-down, direct, reciprocal, activity-based), source cost center, target cost center, allocation basis (square footage, FTEs, revenue, RVUs, patient days), allocation basis quantity, allocated amount, GL account, and allocation run status. Supports Medicare cost report preparation and departmental cost accounting. | 49 |
| budget_planning | financial_forecast | master_data | Master record for rolling financial forecasts and financial planning scenarios prepared by the healthcare finance team. Captures forecast name, forecast type (rolling forecast, annual operating plan, long-range plan, scenario analysis), fiscal year, forecast version, forecast status (draft, submitted, approved, baseline), forecast period coverage (months), total forecasted revenue, total forecasted expense, total forecasted operating income, forecast methodology, assumptions narrative, preparer, approver, and approval date. Supports financial planning and analysis (FP&A) and board-level financial reporting. | 56 |
| budget_planning | forecast_line | master_data | Individual line-item detail within a financial forecast, representing the projected financial amount for a specific GL account, cost center, and fiscal period combination. Captures forecast reference, GL account code, cost center, fund, service line, fiscal period, forecasted amount, forecast category (revenue, salary expense, non-salary expense, capital), volume driver assumption, statistical basis, prior year actual amount, current budget amount, and variance to budget. Enables granular FP&A drill-down and variance analysis between forecast, budget, and actuals. | 55 |
| capital_assets | asset_book | master_data | Master reference table for asset_book. Referenced by asset_book_id. | 49 |
| capital_assets | capital_expenditure | transactional_data | Transactional record of individual capital expenditure events charged against an approved capital project. Captures capital project reference, expenditure date, expenditure type (invoice payment, progress billing, internal labor, capitalized interest), vendor or internal source, invoice or PO reference, expenditure amount, GL account, cost center, fund, capitalization eligibility flag, asset placed-in-service indicator, and associated fixed asset record (once capitalized). Enables CIP tracking and the transition from capital project costs to fixed asset records. | 50 |
| capital_assets | capital_project | master_data | Master record for capital improvement and construction projects tracked within the finance domain for capital budgeting and expenditure control. Captures project number, project name, project type (construction, renovation, equipment acquisition, IT implementation, leasehold improvement), project status (planning, approved, in progress, on hold, completed, cancelled), approved capital budget, total committed costs, total actual costs, project start date, projected completion date, actual completion date, responsible cost center, project manager, funding source (bond, operating cash, grant, lease), and capitalization status. Distinct from facility.capital_project which tracks physical construction details. | 47 |
| capital_assets | depreciation_run | master_data | Master reference table for depreciation_run. Referenced by depreciation_run_id. | 48 |
| capital_assets | depreciation_schedule | transactional_data | Transactional record of periodic depreciation calculations and postings for each fixed asset. Captures asset reference, depreciation period (fiscal period/year), depreciation method applied, beginning net book value, depreciation expense amount, accumulated depreciation balance, ending net book value, GL account debited (depreciation expense), GL account credited (accumulated depreciation), cost center, posting status, and any impairment adjustments. Drives monthly depreciation journal entries and supports capital asset reporting. | 42 |
| capital_assets | fixed_asset | master_data | Master record for every capitalized fixed asset owned or leased by the healthcare organization, including medical equipment, buildings, land, leasehold improvements, IT infrastructure, and vehicles. Captures asset tag number, asset name, asset description, asset category (medical equipment, building, land, furniture, IT equipment, vehicle), acquisition date, placed-in-service date, acquisition cost, salvage value, useful life (years), depreciation method (straight-line, MACRS, units of production), accumulated depreciation, net book value, asset status (active, disposed, transferred, fully depreciated), physical location, responsible cost center, and vendor/manufacturer. | 47 |
| fund_management | donor | master_data | Master reference table for donor. Referenced by donor_id. | 53 |
| fund_management | fund | master_data | Master record for all funds used in healthcare fund accounting, including operating funds, restricted funds, endowment funds, capital funds, and grant funds. Captures fund code, fund name, fund type (unrestricted operating, temporarily restricted, permanently restricted, endowment, capital, grant, agency), restriction description, donor restriction indicator, fund purpose, fund balance, fund status (active, closed, depleted), associated legal entity, fund manager, and applicable regulatory or donor reporting requirements. Essential for not-for-profit healthcare fund accounting compliance. | 47 |
| fund_management | fund_allocation | association_data | This association product represents the allocation relationship between organizational providers and funds in healthcare fund accounting. It captures how restricted and unrestricted funds are allocated across organizational entities (hospitals, clinics, facilities) for compliance tracking, donor restriction management, and regulatory reporting. Each record links one organizational provider to one fund with allocation percentages, effective dates, and compliance status that exist only in the context of this relationship.. Existence Justification: In healthcare fund accounting, organizational providers (hospitals, clinics, facilities) participate in multiple funds simultaneously (operating funds, restricted grants, endowments, capital funds), and each fund is typically allocated across multiple organizational entities within an integrated delivery network or health system. The allocation relationship is actively managed by finance teams with specific percentages, effective dates, compliance tracking, and reporting requirements that belong to neither the provider nor the fund alone. | 32 |
| fund_management | grant | master_data | Master reference table for grant. Referenced by grant_id. | 34 |
| general_ledger | chart_of_accounts | master_data | Chart of accounts master defining all GL account codes and their attributes | 41 |
| general_ledger | cost_center | master_data | Cost center master defining organizational units for cost tracking and allocation | 35 |
| general_ledger | financial_entity | master_data | Master record for each legal entity, subsidiary, and reporting unit within the healthcare organization's corporate structure. Captures entity code, entity name, entity type (hospital, physician group, foundation, ACO, health plan, holding company, joint venture), tax ID (EIN), NPI (if applicable), state of incorporation, fiscal year end, functional currency, consolidation method (full consolidation, equity method, proportional), parent entity, GAAP vs GASB reporting basis, CMS provider number, and entity status. Drives intercompany elimination and consolidated financial reporting. | 56 |
| general_ledger | financial_period_close | transactional_data | Transactional record tracking the month-end, quarter-end, and year-end financial close process for the healthcare organization. Captures close period, close type (monthly, quarterly, annual), close status (open, in progress, soft close, hard close), planned close date, actual close date, close checklist completion percentage, number of open items, number of unposted journals, intercompany reconciliation status, accrual completion status, financial statement preparation status, external audit status (for year-end), and close owner. Drives the period-end close workflow and accountability. | 63 |
| general_ledger | fiscal_period | reference_data | Fiscal period master defining accounting periods and their status | 34 |
| general_ledger | general_ledger | master_data | General ledger configuration and metadata for each accounting ledger instance | 35 |
| general_ledger | intercompany_agreement | master_data | Master reference table for intercompany_agreement. Referenced by intercompany_agreement_id. | 55 |
| general_ledger | intercompany_transaction | transactional_data | Transactional record of financial transactions between legal entities within the healthcare integrated delivery network (IDN), including management fees, shared service charges, intercompany loans, and cost transfers. Captures transaction date, transaction type (management fee, shared service charge, intercompany loan, cost transfer, intercompany sale), originating entity, receiving entity, transaction amount, currency, GL account (originating), GL account (receiving), cost center, elimination indicator, elimination period, and reconciliation status. Supports consolidated financial statement preparation and intercompany elimination. | 62 |
| general_ledger | journal_entry | transactional_data | Journal entry header for manual and automated GL postings | 43 |
| general_ledger | journal_entry_line | transactional_data | Journal entry line detail with account, amount, and dimension attributes | 42 |
| general_ledger | transaction_batch | master_data | Master reference table for transaction_batch. Referenced by batch_id. | 53 |
| payables_receivables | ap_invoice | transactional_data | Core accounts payable invoice record representing a vendor invoice received by the healthcare organization for goods or services. Captures invoice number, vendor ID, vendor name, invoice date, received date, due date, payment terms, invoice type (standard, credit memo, debit memo, prepayment), invoice currency, invoice amount, tax amount, freight amount, invoice status (received, matched, approved, on hold, paid, cancelled), PO match indicator, three-way match status, cost center, GL account, and approval workflow status. SSOT for all vendor payables. | 46 |
| payables_receivables | ap_invoice_line | transactional_data | Individual line-item detail on an accounts payable invoice, representing a single billable item from a vendor. Captures AP invoice reference, line number, item description, quantity, unit of measure, unit price, line amount, GL account code, cost center, fund, project, tax code, PO line reference, goods receipt reference, match status, and distribution status. Enables granular cost allocation and three-way matching (PO-receipt-invoice) for healthcare supply and service procurement. | 42 |
| payables_receivables | ap_payment | transactional_data | Transactional record of every payment disbursed to a vendor through the accounts payable process. Captures payment number, payment date, payment method (check, ACH/EFT, wire transfer, virtual card), vendor ID, vendor bank account, payment amount, currency, exchange rate, payment status (issued, cleared, voided, stopped), void date, void reason, bank account debited, check number (if applicable), remittance advice reference, and associated AP invoices settled. SSOT for all vendor disbursements. | 41 |
| payables_receivables | ar_account | master_data | Accounts receivable account master representing the financial receivable relationship between the healthcare organization and a payer or self-pay patient for non-patient-billing AR (e.g., grants, rental income, intercompany receivables, physician practice management fees). Captures account number, account type (payer, self-pay, intercompany, grant, other), debtor name, debtor type, original balance, current balance, aging bucket, account status (open, closed, written off, in collections), assigned collector, and last activity date. Complements billing.patient_account for non-RCM receivables. | 44 |
| payables_receivables | ar_transaction | transactional_data | Transactional record of every accounts receivable financial event including charges, payments received, adjustments, and write-offs for non-RCM AR accounts. Captures transaction date, transaction type (charge, payment, credit memo, adjustment, write-off), AR account reference, GL account, cost center, amount, currency, reference document number, transaction description, posting period, and posting status. Provides the complete AR subledger transaction history for reconciliation and aging analysis. | 40 |
| payables_receivables | bank_account | master_data | Master record for all bank accounts maintained by the healthcare organization for operating, payroll, investment, and restricted fund purposes. Captures bank account number (masked), bank name, bank routing number, account type (checking, savings, money market, sweep, lockbox), account purpose (operating, payroll, petty cash, restricted, investment), currency, legal entity owner, GL cash account mapping, account status (active, closed, dormant), signatory list, and bank contact information. SSOT for treasury cash management. | 63 |
| payables_receivables | bank_reconciliation | transactional_data | Transactional record of monthly bank reconciliation activities performed for each bank account. Captures reconciliation period, bank account reference, statement date, bank statement ending balance, GL book balance, outstanding checks total, deposits in transit total, bank errors, book errors, reconciled balance, reconciliation status (in progress, reconciled, approved), preparer, reviewer, approval date, and unreconciled variance amount. Ensures integrity between bank statements and the general ledger cash accounts. | 56 |
| payables_receivables | invoice_payment_application | association_data | This association product represents the application of a payment to an invoice in the accounts payable process. It captures the specific allocation of payment funds to settle invoice balances, including partial payments, overpayments, and payment reversals. Each record links one ap_invoice to one ap_payment with attributes that exist only in the context of this payment application event.. Existence Justification: In healthcare accounts payable operations, a single vendor invoice can be paid through multiple payments (partial payments, installment payments, or corrections), and a single payment disbursement can be applied to settle multiple invoices from the same vendor (batch payment allocation). Finance teams actively manage payment applications as a distinct business process, tracking which portion of each payment settles which invoice, including discount calculations, application sequencing, and reversal handling. | 31 |
| payables_receivables | payment_batch | master_data | Master reference table for payment_batch. Referenced by payment_batch_id. | 54 |
| payables_receivables | recurring_schedule | master_data | Master reference table for recurring_schedule. Referenced by recurring_schedule_id. | 55 |

<a id="domain-quality"></a>

### Domain: Quality

| Domain | Division | Total Subdomains | Description | Total Products |
|---|---|---|---|---|
| quality | corporate | 4 | Quality measurement, patient safety, regulatory reporting, and clinical compliance. Owns HEDIS measures, CAHPS surveys, CMS quality programs (VBP - Value-Based Purchasing, MIPS, APM), HAI tracking (CLABSI, CAUTI, SSI), patient safety events, mortality reviews, CDI metrics, TJC survey readiness, CMS Conditions of Participation compliance, and accreditation management. Supports Healthy Planet population health analytics. | 32 |

**Subdomains:** accreditation_improvement, measure_management, patient_experience, safety_review


**List of Data Products**

| Subdomain | Product | Data Type | Description | Total Attributes |
|---|---|---|---|---|
| accreditation_improvement | accreditation_program | master_data | Accreditation program enrollment and status tracking for TJC, DNV, AAAHC, and state licensure. Business justification: Required for Medicare participation, deemed status, and payer credentialing. | 51 |
| accreditation_improvement | accreditation_survey | transactional_data | Accreditation survey events with findings, decisions, and follow-up requirements. Business justification: Tracks survey readiness, deficiency resolution, and accreditation cycle management. | 51 |
| accreditation_improvement | contract_initiative | association_data | Links quality initiatives to payer contracts for VBP and shared savings programs. Business justification: Aligns quality improvement with financial incentives. | 27 |
| accreditation_improvement | corrective_action | master_data | Corrective action tracking for quality findings, audit deficiencies, and improvement opportunities. Business justification: Ensures timely remediation and compliance with accreditation requirements. | 44 |
| accreditation_improvement | improvement_initiative | master_data | Quality improvement projects and initiatives with goals, timelines, and outcome tracking. Business justification: Supports PI program requirements, accreditation standards, and strategic quality goals. | 62 |
| accreditation_improvement | program_study_participation | association_data | Links quality programs to research studies for quality improvement research. Business justification: Supports QI research, learning health system initiatives, and grant compliance. | 20 |
| accreditation_improvement | standard_finding | transactional_data | Individual accreditation survey findings linked to standards and corrective actions. Business justification: Enables finding remediation tracking and standards compliance monitoring. | 50 |
| measure_management | apm_enrollment |  | APM program enrollment per participant per performance year. | 71 |
| measure_management | hedis_measure | master_data | NCQA HEDIS quality measure definitions for managed care performance measurement. Supports Medicare Advantage Star Ratings, Medicaid quality reporting, and commercial health plan accreditation. Business justification: Required for CMS quality reporting, payer contract compliance, and NCQA accreditation. | 53 |
| measure_management | hedis_result | transactional_data | Calculated HEDIS measure results by reporting period, health plan, and care site. Tracks numerator/denominator counts, performance rates, and benchmark comparisons. Business justification: Drives VBP incentive payments, Star Rating calculations, and quality improvement initiatives. | 46 |
| measure_management | initiative_measure_target | association_data | Performance targets for measures within quality improvement initiatives. Business justification: Tracks goal attainment and initiative effectiveness. | 32 |
| measure_management | measure | master_data | Generic quality measure definitions supporting multiple reporting programs (CMS, TJC, state, payer). Includes measure specifications, value sets, and reporting requirements. Business justification: Centralizes measure management across diverse quality programs. | 54 |
| measure_management | measure_attribution |  | Quality measure attribution linking patient to measure/clinician/contract. | 80 |
| measure_management | measure_budget_allocation | association_data | Budget allocation for quality measure improvement activities. Business justification: Tracks quality investment and ROI for improvement initiatives. | 21 |
| measure_management | measure_result | transactional_data | Calculated quality measure results at facility, provider, and payer levels. Supports trending, benchmarking, and regulatory submission. Business justification: Enables performance monitoring, incentive tracking, and public reporting compliance. | 56 |
| measure_management | mips_measure_reporting |  | MIPS clinician-level quality measure reporting per performance year. | 78 |
| measure_management | program_measure_assignment | association_data | Assignment of quality measures to reporting programs with effective dates and targets. Business justification: Manages measure portfolio across multiple quality programs. | 28 |
| measure_management | quality_program |  | SSOT resolved: defer to compliance.compliance_program as the single source of truth for this concept. This table is a domain-specific extension/reference. | 48 |
| measure_management | quality_program_participation |  | Facility and provider participation in quality programs with enrollment dates and status. Business justification: Tracks program eligibility and reporting obligations. | 35 |
| measure_management | raf_score |  | Risk Adjustment Factor (RAF) score per member per year. | 104 |
| measure_management | vbp_program | master_data | Value-based purchasing program definitions including CMS Hospital VBP, MIPS, and commercial payer programs. Tracks domain weights and payment adjustment factors. Business justification: Drives reimbursement optimization and quality strategy alignment. | 51 |
| patient_experience | cahps_response | transactional_data | Individual CAHPS survey responses with composite scores by domain. Links to patient encounters for service recovery and quality improvement. Business justification: Enables patient-level experience analysis, service recovery workflows, and provider feedback. | 48 |
| patient_experience | cahps_survey | master_data | CAHPS patient experience survey administration and aggregate results. Includes HCAHPS for hospitals and CG-CAHPS for clinician groups. Business justification: CMS-mandated for Hospital VBP, Medicare Advantage Star Ratings, and public reporting on Hospital Compare. | 53 |
| patient_experience | care_gap_closure |  | Care gap closure tracking per patient per payer contract per measurement period. | 91 |
| patient_experience | population_health_gap | transactional_data | Patient-level care gaps for population health management and quality measure closure. Business justification: Drives outreach campaigns, care coordination, and VBP performance improvement. | 40 |
| patient_experience | sdoh_screening | transactional_data | Social determinants of health screening results using standardized instruments (AHC-HRSN, PRAPARE). Business justification: Required by CMS for ACO quality, TJC standards, and health equity initiatives. | 61 |
| safety_review | cdi_review | transactional_data | Clinical documentation improvement review tracking for inpatient encounters. Captures query outcomes and DRG/CMI impact. Business justification: Optimizes revenue integrity, supports accurate severity capture, and improves quality measure accuracy. | 44 |
| safety_review | mortality_review | transactional_data | Mortality case review for quality assurance and peer review purposes. Tracks preventability determination and contributing factors. Business justification: Required for CMS mortality measures, TJC standards, and medical staff peer review. | 53 |
| safety_review | patient_safety_event | transactional_data | Patient safety incident reports including near misses, adverse events, and sentinel events. Supports root cause analysis and corrective action tracking. Business justification: Required for TJC accreditation, state mandatory reporting, and PSO participation. | 58 |
| safety_review | quality_committee |  | Quality committee definitions for governance, peer review, and quality oversight. Business justification: Supports medical staff governance, accreditation requirements, and quality program structure. | 40 |
| safety_review | quality_peer_review | transactional_data | SSOT resolved: defer to radiology.radiology_peer_review as the single source of truth for this concept. This table is a domain-specific extension/reference. | 53 |
| safety_review | safety_event_review | transactional_data | Peer review and root cause analysis documentation for patient safety events. Protected under state peer review statutes. Business justification: Supports quality improvement, risk management, and accreditation compliance. | 50 |

<a id="domain-research"></a>

### Domain: Research

| Domain | Division | Total Subdomains | Description | Total Products |
|---|---|---|---|---|
| research | corporate | 5 | Clinical research and medical research operations. Owns clinical trial protocols, IRB (Institutional Review Board) approvals, study enrollment, investigational drug/device tracking, informed consent, adverse event reporting, research billing compliance, research data governance, de-identified data access for population health studies, and translational research. Supports academic medical centers under FDA 21 CFR Part 11. | 32 |

**Subdomains:** data_governance, financial_grants, safety_monitoring, study_management, subject_participation


**List of Data Products**

| Subdomain | Product | Data Type | Description | Total Attributes |
|---|---|---|---|---|
| data_governance | data_access_request | transactional_data | Tracks requests by researchers, analysts, or external collaborators to access de-identified or limited research datasets. Captures requestor name and institution, requested dataset, intended use, IRB approval reference, data use agreement (DUA) status, request submission date, review date, approval/denial decision, access granted date, access expiration date, and data destruction certification requirement. Supports research data governance, HIPAA compliance, and NIH data sharing policy enforcement. | 28 |
| data_governance | data_governance_committee | master_data | Master reference table for data_governance_committee. Referenced by data_governance_committee_id. | 22 |
| data_governance | deidentified_dataset | master_data | Master record for de-identified research datasets, access request management, and data governance. Dataset level: captures dataset name, source systems, de-identification method (Safe Harbor, Expert Determination per HIPAA 45 CFR 164.514(b)), de-identification date, data steward, approved use cases, data sharing agreement reference, IRB waiver reference, data elements, date range, and access tier (internal, limited dataset, fully de-identified). Access request level: tracks requestor name/institution, intended use, IRB approval reference, DUA status, request submission date, review date, approval/denial decision, access dates, expiration, and data destruction certification. Supports research data governance, HIPAA compliance, de-identified data access management, and NIH data sharing policy enforcement. SSOT for research data governance and de-identified data access within the research domain. | 19 |
| data_governance | dua_document | master_data | Master reference table for dua_document. Referenced by dua_document_id. | 26 |
| data_governance | study_partner_agreement | association_data | This association product represents the data sharing and interoperability agreement between a research study and an external trading partner. It captures the operational relationship when a trading partner (sponsor CRO, central lab, imaging core, data coordinating center) participates in a multi-site clinical trial. Each record links one research study to one trading partner with attributes that govern the data exchange, service level agreements, and operational status specific to that study-partner collaboration.. Existence Justification: Multi-site clinical trials operationally engage multiple external trading partners (sponsor CROs, central labs, imaging cores, data coordinating centers) for data exchange, lab services, and study coordination. Each research study has multiple trading partners serving different roles, and each trading partner supports multiple concurrent studies. The business actively manages these study-partner relationships with specific data sharing agreements, SLAs, message volume tracking, and role assignments per study-partner pair. | 26 |
| financial_grants | billing_event | transactional_data | Captures research billing compliance determinations, coverage analysis documents, and individual charge-level events for clinical trial services. Coverage analysis layer: records the formal determination of which protocol services are standard of care (insurance-billable) versus research-specific (sponsor/grant-billable), including protocol version analyzed, analysis date, analyst, payer-specific determinations (Medicare, Medicaid, commercial), CPT/HCPCS codes reviewed, determination rationale, and approval status. Charge event layer: captures service date, CPT/HCPCS code, charge amount, coverage determination (sponsor-billable, Medicare-billable, institutional cost), clinical trial policy number, and CMS NCD reference. Supports research billing compliance under CMS NCD 310.1 and OIG guidance to prevent false claims. SSOT for research billing compliance and coverage analysis within the research domain. | 65 |
| financial_grants | coverage_analysis | master_data | Formal coverage analysis (CA) document record that determines which services in a clinical trial protocol are standard of care (billable to insurance) versus research-specific (billable to sponsor/grant). Captures protocol version analyzed, analysis date, analyst, payer-specific determinations (Medicare, Medicaid, commercial), CPT/HCPCS codes reviewed, determination rationale, approval status, and effective date. Required for research billing compliance programs under CMS NCD 310.1. Distinct from research_billing_event which captures individual charge-level determinations. | 23 |
| financial_grants | grant | master_data | Master reference table for grant. Referenced by grant_id. | 42 |
| financial_grants | grant_expenditure | transactional_data | Transactional record of expenditures charged against a research grant or contract, including personnel costs (salary, fringe), supplies, equipment, subcontract costs, travel, and indirect costs. Captures transaction date, expense category, amount, budget period, cost center, effort percentage, and sponsor-required cost classification. Supports grant financial management, budget-to-actual reporting, and compliance with 2 CFR Part 200 (Uniform Guidance) cost principles. Enables NIH Just-In-Time and progress report financial sections. | 53 |
| financial_grants | grant_personnel | association_data | This association product represents the personnel assignment relationship between employees and research grants. It captures effort allocation, salary distribution, and cost-share commitments required for federal effort reporting (SF-424, PHS 398), NIH/NSF grant administration, and OMB Uniform Guidance compliance. Each record links one employee to one grant with attributes that exist only in the context of this funding relationship, including role on the grant, effort percentage, appointment dates, and financial allocations.. Existence Justification: In healthcare research operations, employees (clinical staff, researchers, analysts) are routinely assigned to multiple concurrent grants with different effort allocations, roles, and salary distributions. Simultaneously, each grant funds multiple personnel including the PI, co-investigators, research coordinators, and support staff. Grant personnel assignments are actively managed operational records that research administrators create, update, and track for federal effort reporting, cost accounting, and compliance purposes. | 26 |
| financial_grants | study_budget | master_data | Captures the negotiated and approved budget for a sponsored clinical trial or research study, including per-visit reimbursement rates, per-procedure rates, startup costs, overhead/indirect costs, screen failure allowances, and payment milestones. Tracks budget version, sponsor-negotiated amounts versus institutional costs, budget approval date, and payment schedule terms. Distinct from grant_expenditure (actuals) — this is the prospective budget and rate card for the study. Supports research finance and sponsor invoicing. | 27 |
| financial_grants | study_sponsor | master_data | Master record for entities sponsoring clinical research studies, including negotiated study budgets and financial terms. Sponsor level: captures sponsor name, type (pharma, biotech, device, government, foundation), NDA/BLA holder status, CRO relationship, contact information, agreement reference, and financial disclosure requirements. Budget level: captures per-visit and per-procedure reimbursement rates, startup costs, overhead/indirect costs, screen failure allowances, payment milestones, budget version, negotiated vs institutional costs, budget approval date, and payment schedule terms. Distinct from grant — sponsors may fund studies without formal grant mechanisms (e.g., industry-sponsored CTAs). Supports research finance, sponsor invoicing, and study budget management. SSOT for sponsor identity and study budget terms within the research domain. | 48 |
| safety_monitoring | adverse_event | transactional_data | Captures all safety events and quality events reported during a clinical trial or research study. Safety events: adverse events (AEs) and serious adverse events (SAEs) with AE term (MedDRA coded), onset/resolution dates, severity grade (CTCAE 1–5), seriousness criteria, causality assessment, action taken, outcome, and expedited reporting flag. Quality events: protocol deviations and violations with deviation description, category (eligibility, dosing, visit window, consent, data collection), severity (minor, major, important protocol deviation), discovery date, root cause, impact on subject safety and data integrity, corrective and preventive action (CAPA), and IRB/sponsor reportability determination. Supports FDA MedWatch, IND safety reporting (21 CFR 312.32), GCP compliance, quality management under ICH E6(R2), and regulatory inspection readiness. SSOT for all study safety events and quality events (including protocol deviations) within the research domain. | 60 |
| safety_monitoring | data_safety_monitoring | transactional_data | Records Data Safety Monitoring Board (DSMB) or Data Monitoring Committee (DMC) activities for a clinical trial, including meeting dates, interim analysis triggers, safety stopping rules, unblinding events, committee recommendations (continue, modify, suspend, terminate), sponsor responses, and implementation actions. Captures the formal oversight record required for Phase II–IV trials and FDA-regulated studies. Supports trial integrity and subject safety oversight. | 50 |
| safety_monitoring | dsmb_committee | master_data | Master reference table for dsmb_committee. Referenced by dsmb_committee_id. | 22 |
| safety_monitoring | monitoring_visit | transactional_data | Records clinical trial monitoring visits conducted by sponsor representatives, CROs, or internal monitors at study sites. Captures visit type (initiation, routine, close-out, for-cause), visit date, monitor name, site visited, findings summary, protocol deviations identified, data discrepancies noted, corrective action plan (CAP) required flag, CAP due date, and visit report completion date. Supports ICH E6(R2) GCP monitoring requirements and sponsor oversight obligations. | 21 |
| safety_monitoring | protocol_deviation | transactional_data | Documents protocol deviations and violations identified during a clinical trial, including the deviation description, deviation date, discovery date, deviation category (eligibility, dosing, visit window, consent, data collection), severity (minor, major, important protocol deviation), root cause, impact on subject safety and data integrity, corrective and preventive action (CAPA), and IRB/sponsor reportability determination. Supports GCP compliance, regulatory inspection readiness, and quality management under ICH E6(R2). | 23 |
| study_management | investigational_product | master_data | Master record for investigational drugs, biologics, or devices used in clinical trials. Captures IND/IDE number, NDC or device identifier, product name (generic and brand), formulation, dosage form, strength, manufacturer, lot number tracking flag, storage requirements, temperature monitoring requirements, expiration date management flag, blinding status (open-label, single-blind, double-blind), and comparator/placebo indicator. Supports FDA 21 CFR Part 312 (drugs) and 21 CFR Part 812 (devices) accountability requirements. | 56 |
| study_management | investigational_product_training | association_data | This association product represents the training certification relationship between investigational products and compliance training programs. It captures product-specific training requirements, competency verification, and certification status for staff handling investigational products in clinical trials. Each record links one investigational product to one training program with attributes tracking certification dates, competency verification, training version compliance, and recertification schedules specific to that product-training combination.. Existence Justification: In clinical trial operations, investigational products require multiple types of training (handling hazardous materials, administering complex dosage forms, storage/temperature monitoring, controlled substance protocols), and each training program applies to multiple investigational products with similar characteristics. The business actively manages product-specific training certifications as operational records, tracking which staff are certified to handle which products, with certification dates, competency verification, and recertification schedules that exist only in the context of each product-training combination. | 68 |
| study_management | ip_dispensation | transactional_data | Transactional record of investigational product (IP) dispensation to an enrolled research subject at a study visit. Captures dispensation date, lot number, quantity dispensed, dose level, kit number, subject compliance (returned units, missed doses), pharmacist or coordinator dispensing, and chain-of-custody signature. Supports IP accountability logs required under FDA 21 CFR Part 312.62 and ICH E6(R2) Section 8.3. Enables drug accountability reconciliation at study close-out. | 53 |
| study_management | irb_submission | transactional_data | IRB submission and approval tracking for research protocols | 45 |
| study_management | protocol_amendment | transactional_data | Tracks all amendments to an approved research protocol, including the amendment number, amendment date, description of changes, reason for amendment, impact assessment (safety, efficacy, enrollment), IRB submission reference, FDA submission reference (IND amendment), sponsor approval date, and implementation date at each site. Maintains the full version history of the study protocol to support regulatory inspections and audit readiness under FDA 21 CFR Part 11. | 45 |
| study_management | research_document | master_data | Master reference table for research_document. Referenced by meeting_minutes_document_id. | 25 |
| study_management | research_regulatory_submission |  | Research-specific regulatory submissions (FDA IND/IDE, IRB). SSOT consumer extending compliance.compliance_regulatory_submission with research-specific attributes. | 27 |
| study_management | research_study |  | SSOT resolved: defer to radiology.radiology_study as the single source of truth for this concept. This table is a domain-specific extension/reference. | 73 |
| study_management | study_arm | master_data | Defines the treatment arms, cohorts, or groups within a clinical trial protocol, including arm name, arm type (experimental, active comparator, placebo, sham, observational), planned enrollment per arm, randomization ratio, dose level or intervention description, and arm status (open, closed, suspended). Supports randomization management, stratified enrollment tracking, and protocol-defined subgroup analyses. A study may have 2–10+ arms; this entity provides the reference structure for subject_enrollment arm assignments. | 26 |
| study_management | study_site | master_data | Research study site activation, enrollment, and performance tracking | 53 |
| subject_participation | biospecimen | master_data | Tracks biological specimens collected from research subjects as part of study protocols, including blood, tissue, urine, saliva, and other biosamples. Captures specimen type, collection date and time, collection site (anatomical), collection method, volume/quantity, processing method, storage location (biobank, freezer, rack, box, position), chain-of-custody, de-identification status, consent for future use, specimen disposition (analyzed, stored, destroyed, shipped), and shipping/transfer records. Supports biobanking operations, translational research specimen management, and specimen lifecycle tracking from collection through final disposition. | 60 |
| subject_participation | consent_template | master_data | Reference master for IRB-approved informed consent form (ICF) templates associated with a study, capturing template version number, IRB approval date, expiration date, language version, consent form type (full ICF, short form, assent form, HIPAA authorization), required elements checklist, and template status (draft, IRB-approved, superseded). Distinct from informed_consent (the subject-level transactional record) — this is the document template/version master. Supports consent version control and ensures subjects are consented on the current IRB-approved version. | 24 |
| subject_participation | informed_consent | transactional_data | Records the informed consent process for each research subject and manages IRB-approved consent form templates/versions. Subject-level consent: captures consent form version, consent date, re-consent date, consent type (initial, re-consent, assent, LAR consent), consenting staff, witness, signature indicator, capacity assessment, and language. Template/version management: captures template version number, IRB approval date, expiration date, language versions, form type (full ICF, short form, assent, HIPAA authorization), required elements checklist, and template status (draft, approved, superseded). Supports FDA 21 CFR Part 50, ICH E6(R2), and ensures subjects are consented on the current IRB-approved version. SSOT for consent documentation, template version control, and consent compliance within the research domain. | 55 |
| subject_participation | study_visit | transactional_data | Represents a scheduled or unscheduled study visit for an enrolled research subject, as defined by the protocol schedule of assessments. Captures visit name, visit number, visit window (planned, early, late), actual visit date, visit type (screening, baseline, treatment, follow-up, end of study, unscheduled), visit status (scheduled, completed, missed, cancelled), visit location, and coordinator assigned. Drives protocol compliance tracking and subject retention management. | 52 |
| subject_participation | subject_enrollment | transactional_data | Operational record of a research subject's enrollment into a specific study, capturing the full enrollment lifecycle. Includes subject study ID (distinct from MRN), screening date, enrollment date, randomization date, randomization arm/cohort assignment, stratification factors, enrollment status (screened, enrolled, active, completed, withdrawn, lost to follow-up), withdrawal reason, and completion date. Links to the patient domain via MRN without duplicating patient master data. Core transactional entity for study enrollment tracking. | 39 |

<a id="domain-workforce"></a>

### Domain: Workforce

| Domain | Division | Total Subdomains | Description | Total Products |
|---|---|---|---|---|
| workforce | corporate | 5 | Healthcare workforce and human capital management. Owns employees, physicians, contract staff, FTE (Full-Time Equivalent) tracking, credentialing, privileging, competency assessments, CME (Continuing Medical Education), shift scheduling, time and attendance, payroll, benefits, talent management, and OSHA compliance. Integrates with Workday HCM and Symplr credentialing. | 24 |

**Subdomains:** benefits_leave, clinical_authorization, talent_development, time_payroll, workforce_administration


**List of Data Products**

| Subdomain | Product | Data Type | Description | Total Attributes |
|---|---|---|---|---|
| benefits_leave | benefit_enrollment | transactional_data | Employee benefit enrollment records capturing elected benefit plans (medical, dental, vision, life insurance, disability, FSA, HSA, 403(b)/401(k) retirement), coverage tier (employee only, employee+spouse, family), enrollment effective date, termination date, and annual election amounts. Tracks open enrollment events and qualifying life event changes. Sourced from Workday HCM Benefits module. | 15 |
| benefits_leave | benefit_plan | master_data | Master reference table for benefit_plan. Referenced by benefit_plan_id. | 16 |
| benefits_leave | leave_request | transactional_data | Employee leave of absence requests and approved leave records, including FMLA (Family and Medical Leave Act), personal leave, military leave (USERRA), workers compensation leave, bereavement, and PTO. Captures leave type, requested start/end dates, approved dates, intermittent leave tracking, FMLA eligibility determination, and return-to-work status. Sourced from Workday HCM Absence Management. | 18 |
| benefits_leave | osha_incident | transactional_data | OSHA-recordable workplace injury, illness, and near-miss incident records for healthcare employees. Captures incident date/time, employee involved, incident type (needlestick, musculoskeletal, exposure, slip/fall), body part affected, injury severity, OSHA recordability determination, days away from work, restricted duty days, root cause analysis, corrective actions, and OSHA 300/300A log entries. Supports OSHA compliance reporting. | 22 |
| clinical_authorization | channel_support_assignment | association_data | This association product represents the operational support assignment between healthcare IT workforce members and interface channels. It captures the tiered support structure (primary, backup, escalation), on-call rotation schedules, and assignment lifecycle for incident management and workforce scheduling. Each record links one employee to one interface channel with role-specific attributes that exist only in the context of this support relationship.. Existence Justification: Healthcare IT operations require multi-tiered support coverage for interface channels (HL7 feeds, FHIR endpoints, Direct messaging). A single interface channel has multiple support staff assigned in different roles (primary, backup, escalation), and a single IT workforce member supports multiple interface channels across different systems. Organizations actively manage these assignments for on-call rotations, incident escalation paths, and workforce scheduling. | 14 |
| clinical_authorization | clinical_privilege | association_data | This association product represents the credentialing relationship between healthcare workforce members and specific CPT procedures they are authorized to perform. It captures the medical staff services office's privilege granting, competency assessment, and ongoing professional practice evaluation. Each record links one employee (clinician) to one CPT code with privilege-specific attributes including grant/expiration dates, competency level, volume requirements, and supervision needs. This is the operational foundation of medical staff credentialing and delineation of privileges.. Existence Justification: Clinical privileges represent the operational credentialing relationship where healthcare providers (physicians, nurses, allied health) are granted authority to perform specific procedures (CPT codes). In real-world medical staff services operations, a single surgeon holds privileges for 20-200 different CPT codes (e.g., appendectomy, cholecystectomy, hernia repair), and each CPT code has 50+ credentialed clinicians across the health system. The medical staff services office actively manages these privileges with grant/expiration dates, competency assessments, volume requirements, and supervision rules. | 18 |
| clinical_authorization | position_procedure_authorization | association_data | This association product represents the authorization relationship between workforce positions and CPT procedure codes. It captures which procedures each position type is credentialed and authorized to perform, including supervision requirements, volume expectations, and training prerequisites. Each record links one position to one CPT code with authorization-specific attributes that exist only in the context of this relationship. Supports competency management, credentialing workflows, and clinical privilege tracking.. Existence Justification: In healthcare workforce management, positions are authorized to perform multiple CPT procedures based on credentials, training, and clinical privileges, and each CPT procedure can be performed by multiple position types with varying authorization levels. The business actively manages position-procedure authorizations as part of credentialing workflows, competency frameworks, and clinical privilege management. This is an operational relationship tracked in medical staff services and HR systems, not an analytical correlation. | 36 |
| clinical_authorization | workforce_provider_network_participation |  |  | 18 |
| talent_development | applicant | master_data | Master reference table for applicant. Referenced by applicant_id. | 21 |
| talent_development | competency_assessment | transactional_data | Records of competency evaluations, occupational health immunizations, and health screenings for clinical and non-clinical staff. Captures assessment type (competency, immunization, health screening), competency domain or vaccine/test type, assessment method (observation, written, simulation, administration), assessor, date, score/result, pass/fail outcome, remediation plan, and next-due date. For immunizations: vaccine type (influenza, hepatitis B, MMR, varicella, Tdap, COVID-19), lot number, administration date, declination reason. For health screenings: TB testing (PPD/IGRA), N95 fit testing, results. SSOT for all occupational health compliance and workforce competency data. Supports TJC and CMS staffing competency and infection control compliance standards. | 15 |
| talent_development | education_program | master_data | Master reference table for education_program. Referenced by education_program_id. | 17 |
| talent_development | employment_competency | master_data | Master record for the full credentialing and privileging lifecycle of healthcare workforce members. Covers professional credentials (medical licenses, DEA registrations, board certifications, nursing licenses, allied health certifications, advanced practice credentials), clinical privileges (facility-specific procedure and clinical activity authorizations granted by Medical Staff), and credentialing/re-credentialing applications. For credentials: issuing authority, license number, issue/expiration dates, renewal status, primary source verification status. For privileges: privilege category, procedure/service type, facility, granting date, privilege status (active, provisional, suspended, revoked), Medical Staff committee approval. For applications: application type (initial, reappointment), submission date, verification steps, committee review dates, approval/denial decision, effective dates. Integrates with Symplr credentialing and Medical Staff Office workflows. SSOT for all workforce credentialing, privileging, and verification data. | 15 |
| talent_development | performance_review | transactional_data | Comprehensive employee performance management, talent development, and conduct records. Captures performance evaluation cycles (annual, mid-year, probationary), overall ratings, goal achievement, competency ratings, manager feedback, self-assessments, development goals, and review completion status. Includes talent profile data: education history, skills inventory, career interests, mobility preferences, mentorship participation, succession plan inclusion, and high-potential designation. Encompasses progressive discipline records: verbal/written warnings, performance improvement plans (PIPs), suspensions, terminations for cause, policy violations, appeal status, and resolution outcomes. Supports merit increases, promotion eligibility, internal mobility, succession management, workforce planning, and HR compliance documentation. SSOT for all employee performance, talent, and disciplinary data. Sourced from Workday HCM Talent Management. | 20 |
| talent_development | recruitment | transactional_data | End-to-end recruitment and onboarding lifecycle from job requisition through productive employee. Captures requisition details, posting channels, applicant pipeline, interview stages, offer details, background check status, pre-employment screening results, and hire decision. Includes complete onboarding process: I-9 verification, orientation attendance, policy acknowledgments, system access provisioning, required training completions (HIPAA, infection control, fire safety), badge issuance, department-specific orientation, onboarding start date, target completion date, and task-level completion status. Tracks time-to-fill, source of hire, cost per hire, recruiter assignment. Links to authorized positions for headcount control. SSOT for all hiring and onboarding data. Sourced from Workday HCM Recruiting. | 71 |
| talent_development | review_template | master_data | Master reference table for review_template. Referenced by review_template_id. | 60 |
| time_payroll | payroll_calendar | master_data | Master reference table for payroll_calendar. Referenced by payroll_calendar_id. | 14 |
| time_payroll | payroll_run | master_data | Master reference table for payroll_run. Referenced by payroll_run_id. | 18 |
| time_payroll | shift_schedule | master_data | Planned work schedules and individual shift assignments for clinical and non-clinical staff across all care settings (inpatient units, ED, ICU, OR, outpatient clinics). Captures schedule period, unit/department, shift type (day, evening, night, on-call), required FTE coverage, and schedule status. Includes individual employee shift assignments: assigned employee, role, scheduled start/end datetime, assignment status (scheduled, confirmed, swapped, cancelled), float/agency designation, and actual vs. scheduled hours for variance analysis and overtime tracking. SSOT for all workforce scheduling data. Supports nurse-to-patient ratio compliance and operational staffing planning. Integrates with Workday HCM scheduling modules. | 66 |
| time_payroll | time_attendance | transactional_data | Time, attendance, and payroll processing records for all employees. Captures clock-in/clock-out events, total hours worked, overtime hours, missed punches, meal break deductions, pay period totals, approval status, and timekeeper corrections. Includes complete payroll processing: gross pay, net pay, base salary/hourly rate, shift differentials, overtime pay, bonuses, deductions (taxes, benefits, garnishments), pay period dates, payroll run status, payment method (direct deposit, check), and GL cost center allocation. Tracks FLSA compliance flags and supports labor cost allocation by cost center and department. SSOT for all workforce time tracking and payroll data. Sourced from Workday HCM Time Tracking and Payroll modules. | 66 |
| workforce_administration | employee | master_data | Core employee master record linking workforce identity to clinical roles, positions, and credentialing status. | 37 |
| workforce_administration | fte_budget | master_data | Authorized FTE (Full-Time Equivalent) budget allocations by department, cost center, and fiscal period. Captures budgeted FTE count by job family and pay type (productive, non-productive, overtime), actual FTE utilization, variance analysis, budget approval status, and labor cost per adjusted patient day. Supports workforce financial planning, labor cost management, productivity benchmarking, and staffing ratio compliance. Integrates with SAP S/4HANA CO and Workday HCM. | 17 |
| workforce_administration | job_profile | reference_data | Job profile template defining competencies, education, licensure, and pay range for a role. | 22 |
| workforce_administration | org_unit | master_data | Organizational unit hierarchy for the healthcare workforce, defining departments, divisions, service lines, and cost centers as managed in Workday HCM. Captures org unit name, org unit type (department, division, service line), parent org unit, effective dates, cost center code, facility association, and management hierarchy. Serves as the workforce-specific organizational structure distinct from the facility domain's physical structure. | 17 |
| workforce_administration | position | master_data | Position master defining authorized roles, budgeted FTE, reporting structure, and job requirements. | 60 |

<a id="domain-behavioral_health"></a>

### Domain: Behavioral_health

| Domain | Division | Total Subdomains | Description | Total Products |
|---|---|---|---|---|
| behavioral_health |  | 2 |  | 6 |

**Subdomains:** clinical_treatment, program_consent


**List of Data Products**

| Subdomain | Product | Data Type | Description | Total Attributes |
|---|---|---|---|---|
| clinical_treatment | crisis_episode |  | Behavioral health crisis encounter | 44 |
| clinical_treatment | mat_treatment |  | Medication-assisted treatment (buprenorphine/methadone/naltrexone) | 45 |
| clinical_treatment | psychiatric_assessment |  | PHQ-9, GAD-7, C-SSRS scoring | 52 |
| clinical_treatment | sud_episode |  | Substance use disorder episode of care | 38 |
| program_consent | otp_enrollment |  | Opioid treatment program enrollment | 39 |
| program_consent | part2_consent |  | 42 CFR Part 2 disclosure consent linking to clinical treatment | 65 |

<a id="domain-clinical_ai"></a>

### Domain: Clinical_ai

| Domain | Division | Total Subdomains | Description | Total Products |
|---|---|---|---|---|
| clinical_ai |  | 2 |  | 8 |

**Subdomains:** governance_compliance, model_inference


**List of Data Products**

| Subdomain | Product | Data Type | Description | Total Attributes |
|---|---|---|---|---|
| governance_compliance | bias_monitoring |  | Model bias monitoring across demographic cohorts | 46 |
| governance_compliance | model_card |  | Clinical AI model card / governance metadata | 47 |
| governance_compliance | samd_regulatory_tracking |  | FDA SaMD regulatory tracking for clinical AI | 39 |
| model_inference | care_gap |  | Patient x measure x gap status care gap tracking | 49 |
| model_inference | clinical_nlp_result |  | Clinical NLP NER extractions from unstructured notes | 50 |
| model_inference | feature_store_entity |  | Patient/encounter-level feature snapshots for ML feature store | 43 |
| model_inference | model_inference_log |  | MLflow model inference lineage log | 50 |
| model_inference | patient_risk_score |  | ML-generated patient risk scores (readmission/sepsis/fall/deterioration) | 69 |

<a id="domain-digital_health"></a>

### Domain: Digital_health

| Domain | Division | Total Subdomains | Description | Total Products |
|---|---|---|---|---|
| digital_health |  | 2 |  | 13 |

**Subdomains:** patient_engagement, remote_monitoring


**List of Data Products**

| Subdomain | Product | Data Type | Description | Total Attributes |
|---|---|---|---|---|
| patient_engagement | portal_engagement_event |  |  | 32 |
| patient_engagement | portal_session | master_data | Master reference table for portal_session. Referenced by session_id. | 29 |
| patient_engagement | prom_instrument |  | Patient-reported outcome measure instrument definition (e.g. PROMIS, PHQ-9). | 12 |
| patient_engagement | prom_question | master_data | Master reference table for prom_question. Referenced by question_id. | 30 |
| patient_engagement | prom_response |  |  | 45 |
| remote_monitoring | alert_threshold |  | RPM alert threshold defining escalation bounds for a monitored reading type. | 16 |
| remote_monitoring | device_alert_threshold |  | Alert thresholds for RPM device readings. | 14 |
| remote_monitoring | device_reading |  | heart rate, glucose, SpO2, weight sensor readings | 40 |
| remote_monitoring | rpm_alert_threshold |  |  | 38 |
| remote_monitoring | rpm_device |  | RPM device registered to a patient for remote monitoring. | 17 |
| remote_monitoring | rpm_device_reading |  |  | 61 |
| remote_monitoring | rpm_enrollment |  | RPM program enrollment and alert thresholds | 29 |
| remote_monitoring | rpm_program_enrollment |  |  | 47 |

<a id="domain-genomics"></a>

### Domain: Genomics

| Domain | Division | Total Subdomains | Description | Total Products |
|---|---|---|---|---|
| genomics |  | 1 |  | 3 |

**Subdomains:** genomics_core


**List of Data Products**

| Subdomain | Product | Data Type | Description | Total Attributes |
|---|---|---|---|---|
| genomics_core | biobank_specimen |  |  | 18 |
| genomics_core | genetic_variant |  |  | 32 |
| genomics_core | pharmacogenomics_result |  |  | 21 |

<a id="domain-population_health"></a>

### Domain: Population_health

| Domain | Division | Total Subdomains | Description | Total Products |
|---|---|---|---|---|
| population_health |  | 1 |  | 3 |

**Subdomains:** population_health


**List of Data Products**

| Subdomain | Product | Data Type | Description | Total Attributes |
|---|---|---|---|---|
| population_health | cohort_definition |  |  | 30 |
| population_health | cohort_membership |  |  | 23 |
| population_health | trial_match_evaluation |  |  | 25 |

<a id="domain-post_acute"></a>

### Domain: Post_acute

| Domain | Division | Total Subdomains | Description | Total Products |
|---|---|---|---|---|
| post_acute |  | 1 |  | 3 |

**Subdomains:** post_acute


**List of Data Products**

| Subdomain | Product | Data Type | Description | Total Attributes |
|---|---|---|---|---|
| post_acute | home_health_episode |  |  | 27 |
| post_acute | hospice_episode |  |  | 25 |
| post_acute | snf_stay |  |  | 24 |

## Metric Views

Total metric views generated: **326**. Showing top 20.

| # | View Name | Domain | Source Table | Description |
|---|---|---|---|---|
| 1 | clinical_allergy | clinical | allergy | Allergy documentation and reconciliation KPIs for medication safety. |
| 2 | clinical_care_plan_goal | clinical | care_plan_goal | Care plan goal achievement KPIs for population health and care management effectiveness. |
| 3 | clinical_care_team_member | clinical | care_team_member | Care team staffing and coverage KPIs for care coordination workforce planning. |
| 4 | clinical_cdi_query | clinical | cdi_query | Clinical documentation improvement query performance and reimbursement-impact KPIs. |
| 5 | clinical_cdi_worksheet | clinical | cdi_worksheet | CDI review worksheet KPIs tracking DRG weight change and documentation capture. |
| 6 | clinical_diagnosis | clinical | diagnosis | Diagnosis coding quality, chronicity, and risk-capture KPIs for CDI and HCC steering. |
| 7 | clinical_finding | clinical | clinical_finding | Clinical/imaging finding KPIs for critical-result follow-up and AI-assisted detection. |
| 8 | clinical_functional_status | clinical | functional_status | Functional status assessment KPIs for rehab potential and post-acute planning. |
| 9 | clinical_hai_event | clinical | hai_event | Healthcare-associated infection surveillance KPIs for infection prevention and value-based purchasing. |
| 10 | clinical_immunization | clinical | immunization | Immunization administration and series-completion KPIs for population health and public health reporting. |
| 11 | clinical_note | clinical | note | Clinical documentation timeliness and completeness KPIs for provider productivity and compliance. |
| 12 | clinical_nursing_assessment | clinical | nursing_assessment | Nursing assessment KPIs for fall/pressure-injury risk and discharge readiness. |
| 13 | clinical_observation | clinical | observation | Clinical observation value and critical-result KPIs for quality and patient safety. |
| 14 | clinical_problem | clinical | problem | Problem list chronicity and risk-adjustment KPIs for population health. |
| 15 | clinical_procedure_event | clinical | procedure_event | Procedure volume, throughput, RVU productivity, and financial KPIs for OR and service-line steering. |
| 16 | clinical_vital_sign | clinical | vital_sign | Vital sign monitoring KPIs including abnormal-rate and remote patient monitoring adoption. |
| 17 | consent_amendment_request | consent | amendment_request | Record-amendment request KPIs measuring acceptance rate, HIPAA amendment share, and review throughput. Steers HIPAA right-to-amend operations. |
| 18 | consent_capacity_assessment | consent | capacity_assessment | Decision-making capacity assessment KPIs measuring surrogate requirement, reassessment recommendations, and determination mix. Steers informed-consent integrity for vulnerable patients. |
| 19 | consent_deficiency | consent | deficiency | Consent documentation deficiency KPIs measuring open backlog, escalations, resolution posture, and overdue items. Steers HIM/compliance remediation operations. |
| 20 | consent_disclosure_log | consent | disclosure_log | PHI disclosure KPIs measuring accounting-of-disclosures obligations, minimum-necessary adherence, TPO vs non-TPO mix, and patient notification. Core HIPAA accountability metrics. |

*... and 306 more metric views. See the `metrics/` folder for full details.*