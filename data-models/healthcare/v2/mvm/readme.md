# Healthcare Lakehouse Data Model

**v2_mvm** generated using Vibe Modelling Agent on July 02, 2026 at 08:58 AM

This document outlines a vibed Lakehouse data model for the Healthcare business that can be deployed to Databricks Platform. The model is structured into business-aligned domains and denormalized data products, optimized for analytical workloads.

## Table of Contents

- [Output Folder Structure](#output-folder-structure)
- [Model Metrics](#model-metrics)
- [Business Summary](#business-summary)
- [Business Domains & Subdomains](#business-domains--subdomains)
  - [Clinical](#domain-clinical)
  - [Encounter](#domain-encounter)
  - [Laboratory](#domain-laboratory)
  - [Order](#domain-order)
  - [Pharmacy](#domain-pharmacy)
  - [Radiology](#domain-radiology)
  - [Scheduling](#domain-scheduling)
  - [Billing](#domain-billing)
  - [Claim](#domain-claim)
  - [Insurance](#domain-insurance)
  - [Patient](#domain-patient)
  - [Provider](#domain-provider)
- [Metric Views](#metric-views)

## Output Folder Structure

All artifacts for version **v2_mvm** are organized as follows:

```
v2/mvm/
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
| `schemas/` | `healthcare_<domain>_schema_v2_mvm.sql` (combined per-domain SQL: schemas/databases + tables with inline PKs + FKs + tags) |
| `schemas/` | `healthcare_catalogs_v2_mvm.sql` (catalog-level DDL) |
| `metrics/` | `healthcare_<domain>_metrics_v2_mvm.sql` (one file per domain) |
| `docs/` | `healthcare_model_v2_mvm.xlsx`, `healthcare_model_v2_mvm.csv`, `releasenotes.txt` |
| `diagram/` | `healthcare_dbml_v2_mvm.dbml` |
| `vibes/` | `current_vibes.txt`, `next_vibes.txt` |
| `/` | `model.json` (full model with requirements, metadata, and model data) |
| `ontology/` | `healthcare_rdf_v2_mvm.rdf` |
| `samples/` | One CSV file per data product (e.g., `customer.csv`, `order.csv`) |

## Model Metrics
| Metric | Value |
|---|---|
| Model Scope | MVM (Minimum Viable Model) |
| Total Domains | 12 |
| Total Subdomains | 28 |
| Total Products | 119 |
| Total Attributes | 5573 |
| Primary Keys | 119 |
| Foreign Keys | 813 |
| Avg Attributes/Product | 46.8 |
| Metric Views | 84 |

## Business Summary
| Business | Industry Alignment | Model Scope | Description | References | Version |
|---|---|---|---|---|---|
| Healthcare | Healthcare | MVM (Minimum Viable Model) | healthcare industry enterprise data model. |  | 2 |

## Business Domains & Subdomains

<a id="domain-clinical"></a>

### Domain: Clinical

| Domain | Division | Total Subdomains | Description | Total Products |
|---|---|---|---|---|
| clinical | operations | 3 | Comprehensive clinical documentation and care delivery data. Owns diagnoses (ICD-10), procedures (CPT, HCPCS), clinical notes, problem lists, allergies, immunizations, vital signs, care plans, assessments, nursing documentation, clinical observations (LOINC-coded), SNOMED CT-coded clinical findings, and CDI (Clinical Documentation Improvement) workflows. Core EHR/EMR operational data. | 12 |

**Subdomains:** care_coordination, clinical_documentation, patient_registry


**List of Data Products**

| Subdomain | Product | Data Type | Description | Total Attributes |
|---|---|---|---|---|
| care_coordination | advance_directive | master_data | Patient advance directive and end-of-life care preference documentation including DNR (Do Not Resuscitate) orders, POLST/MOLST (Physician/Medical Orders for Life-Sustaining Treatment), living wills, healthcare power of attorney designations, and code status (Full Code, DNR, DNR/DNI, Comfort Care). Captures directive type, effective date, expiration date, document status (active, revoked, superseded), healthcare proxy name and contact information, verification method, and the provider who documented or verified the directive. Critical for end-of-life care decisions, EMTALA compliance, and patient rights under the Patient Self-Determination Act. Sourced from Epic advance care planning module. | 66 |
| care_coordination | care_plan | master_data | Patient-centered care plans documenting clinical goals, interventions, and expected outcomes across the care continuum. Captures care plan type (inpatient, outpatient, chronic disease, discharge, transitional), status (draft, active, completed, revoked), effective date range, care setting, authoring provider, care team assignment, patient goals with individual lifecycle tracking, clinical problems addressed, and care plan category (SNOMED CT coded). Includes embedded care plan goals as detail records: goal description, SNOMED CT coded goal category, target measure (LOINC coded), target value, target date, achievement status (proposed, accepted, in-progress, achieved, cancelled), priority, and responsible provider. Supports transitions of care, population health management, ACO care coordination, and CMS Conditions of Participation for discharge planning. Sourced from Epic Healthy Planet and Cerner. | 65 |
| care_coordination | care_team | master_data | Clinical care team assignments for patients, documenting which providers are responsible for a patient's care in a given context. Captures care team type (inpatient, outpatient, primary, specialty, multidisciplinary), team status, assignment dates, and individual member detail records: member type (physician, NP, PA, RN, social worker, pharmacist, care coordinator), role code, on-call flag, primary contact flag, participation start/end dates, and active status. Members are modeled as line items within the care team — each with their own assignment lifecycle but always in the context of a parent team. Distinct from workforce scheduling — this is the clinical accountability record. Enables care coordination queries, transitions of care documentation, and care plan team assignment. Sourced from Epic and Cerner care team modules. | 58 |
| care_coordination | care_team_member | master_data | Individual provider membership records within a care team, capturing the specific role, period of responsibility, and participation status of each clinician. Includes member type (physician, NP, PA, RN, social worker, pharmacist, care coordinator), role code, on-call flag, primary contact flag, and assignment dates. Enables care coordination queries and transitions of care documentation. Sourced from Epic and Cerner. | 54 |
| clinical_documentation | diagnosis | transactional_data | SSOT for all patient diagnoses documented in the EHR. Captures ICD-10-CM coded diagnoses, diagnosis type (principal, secondary, admitting, discharge), onset date, resolution date, clinical status (active, resolved, chronic), severity, certainty (confirmed, suspected, rule-out), and the encounter or problem list context. Sourced from Epic ClinDoc and Cerner PowerChart. Supports CDI workflows, DRG assignment, and quality reporting. | 61 |
| clinical_documentation | note | transactional_data | Structured and unstructured clinical documentation authored by providers in the EHR. Includes note type (H&P, progress note, discharge summary, operative note, consult note, nursing note), author, co-signer, note status (draft, signed, amended, addended), service date, encounter context, LOINC document type code, and full note text or structured content reference. Sourced from Epic ClinDoc and Cerner PowerChart. Core to CDI and HIM workflows. | 62 |
| clinical_documentation | observation | transactional_data | SSOT for all structured clinical observations, assessments, scored evaluations, and clinical findings documented by clinicians during patient care. Encompasses LOINC-coded and SNOMED CT-coded observations across all clinical contexts including: nursing assessments (head-to-toe, skin integrity, restraint, fall risk using Morse/Braden scales, pressure injury staging, discharge readiness), functional status assessments (Barthel Index, FIM, ADL/IADL), behavioral health screenings (PHQ-9, CAGE-AID, Columbia Suicide Severity), SDOH screenings, wound assessments, intake/output measurements, neurological assessments (GCS components), physical examination findings, symptom documentation, and clinical impressions. Captures observation code, value (numeric, coded, or text), units, reference range, interpretation flag (normal, abnormal, critical), observation_category (nursing, functional, finding, screening, exam), assessment tool used, body system/site, laterality, severity, presence status (present, absent, unknown), observation date/time, and recording clinician. High-volume structured clinical data sourced from Epic ClinDoc flowsheets, Cerner PowerChart, and structured documentation modules. Supports nursing quality metrics, discharge planning, population health stratification, Joint Commission compliance, and FHIR Observation resource interoperability. | 61 |
| clinical_documentation | procedure_event | transactional_data | Records of clinical procedures performed on patients, coded using CPT, HCPCS, and ICD-10-PCS. Captures procedure date/time, performing provider, facility location, laterality, approach, anesthesia type, duration, status (performed, cancelled, in-progress), and associated encounter. Sourced from Epic OpTime, ClinDoc, and Cerner SurgiNet. Supports revenue cycle charge capture and quality measurement. | 66 |
| patient_registry | allergy | master_data | Patient allergy and adverse reaction records including drug allergies, food allergies, environmental allergens, and contrast media reactions. Captures allergen name, allergen type, reaction description, reaction severity (mild, moderate, severe, life-threatening), onset date, verification status (confirmed, unconfirmed, entered-in-error), and the documenting provider. SNOMED CT and NDF-RT coded. Critical patient safety data sourced from Epic and Cerner allergy modules. | 51 |
| patient_registry | immunization | transactional_data | Patient immunization administration records including vaccine administered, CVX code, NDC code, lot number, expiration date, manufacturer, administration site, route, dose number in series, VIS (Vaccine Information Statement) date, administering provider, and administration date/time. Tracks immunization series completion status. Sourced from Epic and Cerner immunization modules. Supports public health reporting to state immunization registries (IIS). | 57 |
| patient_registry | problem | master_data | Patient problem list entries representing active, chronic, or historical health conditions managed longitudinally across encounters. Captures SNOMED CT and ICD-10 coded problems, onset date, resolution date, problem status (active, inactive, resolved), priority, and the provider who added or last updated the problem. Distinct from encounter-level diagnoses — this is the longitudinal clinical problem list. Sourced from Epic and Cerner problem list modules. | 53 |
| patient_registry | vital_sign | transactional_data | Patient vital sign measurements captured during clinical encounters, nursing assessments, and continuous monitoring. Includes LOINC-coded observation types: blood pressure (systolic/diastolic), heart rate, respiratory rate, temperature, SpO2, height, weight, BMI, pain score, and Glasgow Coma Scale (GCS). Captures measured value, unit of measure, measurement method, body site, patient position, device used, measurement date/time, and recording clinician. Supports early warning score (EWS/MEWS/NEWS) calculations, sepsis screening, and clinical deterioration detection. High-volume time-series clinical data sourced from Epic ClinDoc flowsheets, Cerner PowerChart, and bedside monitoring device integrations. Separated from clinical_observation due to distinct high-frequency time-series ingestion patterns, dedicated device integration pipelines, and specialized analytics (trending, alerting, waveform correlation). Maps to FHIR Observation with vitals profile (US Core Vital Signs). | 51 |

<a id="domain-encounter"></a>

### Domain: Encounter

| Domain | Division | Total Subdomains | Description | Total Products |
|---|---|---|---|---|
| encounter | operations | 2 | Core operational record of every patient-provider interaction. Owns ADT (Admit, Discharge, Transfer) events, visit types (inpatient, outpatient, ED, observation, telehealth), admission source and disposition, attending and consulting providers, LOS (Length of Stay), DRG assignment, discharge status, and care setting transitions. Central hub linking patient, provider, clinical, and billing domains. | 10 |

**Subdomains:** clinical_documentation, patient_encounters


**List of Data Products**

| Subdomain | Product | Data Type | Description | Total Attributes |
|---|---|---|---|---|
| clinical_documentation | discharge_summary | transactional_data | Discharge summary document capturing hospital course, discharge instructions, and follow-up plan. | 50 |
| clinical_documentation | drg_assignment | transactional_data | DRG assignment record capturing grouper results, weights, and reimbursement data for inpatient visits. | 47 |
| clinical_documentation | visit_diagnosis | transactional_data | Diagnosis codes associated with a visit, including POA indicators, DRG relevance, and coding status. | 42 |
| clinical_documentation | visit_insurance | transactional_data | Insurance coverage details associated with a visit, including eligibility, authorization, and financial responsibility. | 46 |
| clinical_documentation | visit_procedure | transactional_data | Procedures performed during a visit, including CPT/ICD-10-PCS codes, RVUs, and surgical details. | 52 |
| patient_encounters | adt_event | transactional_data | Admit-Discharge-Transfer event record capturing patient movement events within and between facilities. | 47 |
| patient_encounters | bed_assignment | transactional_data | Bed assignment record tracking patient bed placements throughout a visit. | 45 |
| patient_encounters | triage_assessment | transactional_data | Emergency department triage assessment capturing vital signs, acuity level, and chief complaint. | 50 |
| patient_encounters | visit | master_data | Core encounter/visit record representing a patient interaction with the health system. | 45 |
| patient_encounters | visit_provider | association_data | Association between a visit and the providers involved in care delivery. | 46 |

<a id="domain-laboratory"></a>

### Domain: Laboratory

| Domain | Division | Total Subdomains | Description | Total Products |
|---|---|---|---|---|
| laboratory | operations | 4 | Laboratory testing and diagnostic services. Owns lab orders, specimen collection and tracking, test results (LOINC-coded), reference ranges, critical value alerts, pathology reports, microbiology cultures, blood bank operations, point-of-care testing, and CLIA-compliant quality control. Integrates with LIS (Laboratory Information System) including Epic Beaker and Cerner PathNet. | 8 |

**Subdomains:** diagnostic_services, order_management, result_reporting, transfusion_medicine


**List of Data Products**

| Subdomain | Product | Data Type | Description | Total Attributes |
|---|---|---|---|---|
| diagnostic_services | microbiology_culture | transactional_data | Transactional record for microbiology culture and sensitivity (C&S) testing. Tracks organism identification (SNOMED CT coded), culture type (aerobic, anaerobic, fungal, AFB, viral), growth result, colony count, isolation date/time, and the associated antimicrobial susceptibility panel. Supports infection control surveillance, antibiotic stewardship programs, and HAI (Healthcare-Associated Infection) reporting including CLABSI and CAUTI tracking. | 45 |
| diagnostic_services | pathology_report | master_data | Master record for surgical pathology and cytology reports generated by pathologists. Includes case number, specimen source, gross description, microscopic description, final diagnosis (ICD-10 coded), synoptic reporting elements (CAP cancer protocols), pathologist of record, sign-out date/time, report status (preliminary, final, amended), and addendum history. Supports oncology care coordination, tumor board workflows, and cancer registry reporting. | 49 |
| order_management | lab_order | transactional_data | Core transactional record of every laboratory test order placed via CPOE (Computerized Physician Order Entry) in Epic Beaker or Cerner PathNet, including orders routed to external reference laboratories (send-outs). Captures the ordering provider, ordering encounter, ordered test (LOINC code from test catalog), order priority (STAT, routine, ASAP, timed), order status lifecycle (ordered, collected, in-process, sent-out, resulted, cancelled), clinical indication, order date/time, source system identifiers. For send-out orders: reference lab name, reference lab accession number, specimen shipping date/time, shipping carrier and tracking, expected turnaround time, result receipt date/time, and result integration status. SSOT for all lab order identity and lifecycle within the laboratory domain, including both internal and send-out orders. | 48 |
| order_management | specimen | master_data | Master record for every biological specimen collected for laboratory testing and the SSOT for specimen identity, accessioning, chain of custody, and full specimen lifecycle. Tracks specimen type (blood, urine, tissue, CSF, swab), collection method, collection date/time, collector identity and role, collection site (body location), container type, volume, accession number (LIS-assigned unique work-unit identifier), accession date/time, accession status (received, processing, resulted, archived), receiving lab location, priority, chain-of-custody status, storage location, specimen condition at receipt, number of aliquots, and disposal/retention status. Consolidates the former accession and specimen collection event concepts — the accession is the specimen's operational identity in Epic Beaker and Cerner PathNet. Supports CLIA-compliant specimen tracking from collection through accessioning, testing, and disposal. | 50 |
| result_reporting | reference_range | reference_data | Reference data defining normal, abnormal, and critical value thresholds for each laboratory test, stratified by patient demographics (age group, sex, pregnancy status, race/ethnicity where clinically validated) and specimen type. Includes lower and upper normal limits, critical low and critical high thresholds, panic value definitions, unit of measure, effective date range, and the authoritative source (CAP, CLIA, manufacturer insert, institutional medical director override). Used by result interpretation logic to assign abnormal flags and trigger critical value alerts in test_result. Supports CLIA-required documentation of reference range sources and periodic review. | 49 |
| result_reporting | test_result | transactional_data | Transactional record of every individual laboratory test result produced for a specimen, including result amendments and critical value notifications. Stores LOINC-coded test identifier, result value (numeric, text, coded), result unit of measure, reference range applied, result status lifecycle (preliminary, final, corrected, cancelled), abnormal flag (normal, low, high, critical low, critical high), result date/time, performing lab section, instrument identifier, verifying technologist. Owns the full amendment/correction history: original value, amended value, amendment reason, amending user, amendment timestamp. When a result exceeds critical thresholds, owns the critical value alert lifecycle: alert generation timestamp, notified provider, notification method (phone, secure message, EHR alert), acknowledgment timestamp, acknowledging clinician, escalation actions, and resolution notes. Consolidates the former critical_value_alert and result_amendment concepts. Supports CLIA critical value compliance, Joint Commission NPSG requirements, HIM audit requirements, and downstream clinical decision-making. | 55 |
| transfusion_medicine | blood_bank_unit | master_data | Master record for each blood product unit managed by the transfusion medicine / blood bank service. Tracks unit number (ISBT 128 coded), product type (packed red cells, platelets, FFP, cryoprecipitate, whole blood, granulocytes), ABO/Rh type, donation date, expiration date, irradiation status, leukoreduction status, CMV status, sickle trait status, unit status lifecycle (available, reserved, crossmatched, issued, transfused, discarded, returned, quarantined), storage location, and temperature monitoring. SSOT for blood product inventory, traceability, and regulatory compliance. Supports AABB standards, FDA blood establishment regulations, and hemovigilance reporting. | 50 |
| transfusion_medicine | test_catalog | reference_data | Reference master of all laboratory tests and test panels offered by the health system, serving as the SSOT for the laboratory test compendium. For individual tests: captures LOINC code, test name, CPT code(s) for billing, specimen requirements, container type, minimum volume, storage and transport conditions, turnaround time targets (routine and STAT), performing lab (internal section or reference lab name), methodology, and orderable flag. For panels and profiles (e.g., BMP, CMP, CBC with differential, lipid panel, hepatic function panel): captures panel LOINC code, panel name, component test relationships, clinical use case, panel-specific ordering rules, and orderable status. Also covers send-out test catalog entries with reference lab routing information. Consolidates the former test_panel product. Used by clinicians, order entry systems (CPOE), clinical decision support, and CDM charge alignment. | 48 |

<a id="domain-order"></a>

### Domain: Order

| Domain | Division | Total Subdomains | Description | Total Products |
|---|---|---|---|---|
| order | operations | 2 | Manages the full lifecycle of clinical orders including CPOE (Computerized Physician Order Entry) for lab, radiology, pharmacy, and referral orders. Tracks order status, priority, routing, and fulfillment. Integrates with Epic Orders, Beaker (LIS), Radiant (RIS), and Willow (pharmacy) as the operational order management backbone. | 8 |

**Subdomains:** fulfillment_routing, order_management


**List of Data Products**

| Subdomain | Product | Data Type | Description | Total Attributes |
|---|---|---|---|---|
| fulfillment_routing | fulfillment | transactional_data | Records of order fulfillment events including completion, partial fulfillment, and exceptions. | 42 |
| fulfillment_routing | routing | transactional_data | Order routing records tracking where and how orders are directed for fulfillment. | 33 |
| fulfillment_routing | set_item | master_data | Individual order items within an order set, with conditional logic and defaults. | 44 |
| order_management | clinical_order | master_data | Core clinical order record capturing all order types placed via CPOE or other entry methods. | 54 |
| order_management | diet_order | Master | Dietary and nutritional orders for inpatient and outpatient settings. | 35 |
| order_management | referral_order | transactional_data | Referral orders tracking patient referrals to specialists or facilities. | 50 |
| order_management | set | master_data | Master reference table for set. Referenced by set_id. | 27 |
| order_management | standing_order | master_data | Pre-authorized standing orders for recurring clinical interventions without individual physician sign-off. | 45 |

<a id="domain-pharmacy"></a>

### Domain: Pharmacy

| Domain | Division | Total Subdomains | Description | Total Products |
|---|---|---|---|---|
| pharmacy | operations | 3 | Owns the medication lifecycle from prescribing through dispensing and administration. Manages formulary, NDC (National Drug Code) drug master, MAR (Medication Administration Record), medication reconciliation, controlled substance tracking (DEA Schedule), adverse drug event monitoring, pharmacy inventory, and prescription fulfillment. Sourced from Epic Willow and Cerner PharmNet. | 8 |

**Subdomains:** medication_fulfillment, product_catalog, regulatory_compliance


**List of Data Products**

| Subdomain | Product | Data Type | Description | Total Attributes |
|---|---|---|---|---|
| medication_fulfillment | dispense_event | transactional_data | Transactional record of each medication dispensing action performed by the pharmacy. Captures prescription reference, dispensed NDC, dispensed quantity, dispensed days supply, lot number, expiration date, dispensing pharmacist NPI, dispensing location, dispense date and time, fill number (original vs. refill), dispense type (inpatient/outpatient/retail/specialty), patient counseling flag, and verification status. Represents the physical fulfillment of a prescription. Sourced from Epic Willow and Cerner PharmNet. | 59 |
| medication_fulfillment | mar_record | transactional_data | Medication Administration Record (MAR) capturing each instance of medication administration to an inpatient or outpatient patient. Records administered drug, dose given, route, administration date and time, administering nurse/clinician NPI, administration site, patient response, waste amount (for controlled substances), witness NPI for controlled substance waste, and administration status (given/held/refused/not-available). Core to inpatient medication safety and regulatory compliance. Sourced from Epic ClinDoc MAR and Cerner PharmNet. | 49 |
| medication_fulfillment | prescription | transactional_data | Core transactional record representing a medication order written by an authorized prescriber for a patient. Captures MRN, prescriber NPI, drug name, NDC, sig (directions), quantity prescribed, days supply, refills authorized, prescribing date, indication (ICD-10), prescription status (active/discontinued/expired/on-hold), e-prescribing transmission status, DEA number for controlled substances, and EPCS (Electronic Prescribing of Controlled Substances) compliance flag. Sourced from Epic Willow and Cerner PharmNet. | 55 |
| product_catalog | drug_master | master_data | Authoritative pharmacy drug master for every medication managed within the organization. Captures NDC (National Drug Code), drug name (generic and brand), drug class, DEA schedule, dosage form, strength, route of administration, unit of measure, therapeutic category, formulary status, controlled substance indicator, hazardous drug flag, tall-man lettering, ISMP high-alert flag, look-alike/sound-alike (LASA) indicators, and regulatory approval metadata. Serves as the pharmacy-owned SSOT for drug attributes consumed by prescribing, dispensing, administration, and inventory workflows. Distinct from reference domain NDC code sets — this product adds pharmacy-operational attributes (formulary status, ISMP flags, hazardous drug classification). Sourced from Epic Willow and Cerner PharmNet drug dictionaries. | 53 |
| product_catalog | formulary | master_data | Defines the approved drug formulary for each health plan, payer, or facility tier. Captures formulary tier (preferred/non-preferred/specialty), prior authorization requirements, step therapy requirements, quantity limits, formulary effective and expiration dates, therapeutic alternatives, payer-specific coverage rules, and specialty drug classification. Supports formulary management, clinical decision support at point of prescribing, and prescription adjudication. Benefit plan financial details (copay/coinsurance schedules, deductible applicability, mail-order benefit rules) are sourced from the billing domain; this product owns drug-level coverage and access rules only. Sourced from Epic Willow and Cerner PharmNet formulary modules. | 46 |
| product_catalog | inventory | master_data | Real-time and periodic snapshot of medication inventory levels and movement history across all pharmacy locations including inpatient, outpatient, and automated dispensing cabinets. Captures drug NDC, location, on-hand quantity, reorder point, par level, lot number, expiration date, unit cost, inventory status (active/quarantined/recalled/expired), shortage indicators, and transaction history (receipts, returns, waste, transfers, cycle count adjustments). Supports medication availability, drug shortage management, supply chain integration, waste reduction, and full inventory audit trail. Sourced from Epic Willow and Cerner PharmNet. | 33 |
| regulatory_compliance | adverse_drug_event | transactional_data | Operational record of adverse drug events (ADEs), adverse drug reactions (ADRs), and medication errors identified during patient care. Captures event date and time, patient reference, causative drug (NDC), event type (allergic reaction/toxicity/medication error/near-miss), severity level, harm category (NCC MERP index), contributing factors, reporter NPI, encounter reference, root cause analysis findings, and corrective actions taken. Supports pharmacovigilance, FDA MedWatch reporting, ISMP medication error reporting, and pharmacy P&T committee safety reviews. Sourced from Epic Willow and Cerner PharmNet. | 50 |
| regulatory_compliance | controlled_substance_log | transactional_data | DEA-compliant audit log for all controlled substance transactions including dispensing, administration, waste, returns, inventory counts, and automated dispensing cabinet (ADC) access events. Captures DEA schedule, drug NDC, transaction type, quantity in/out, running balance, transaction timestamp, responsible pharmacist NPI, witness NPI, patient reference, source system (manual/ADC/Pyxis/Omnicell), cabinet/location identifier, override reason, and discrepancy flags. Supports DEA 222 form compliance, state PDMP reporting, diversion detection, and nursing unit controlled substance accountability. Sourced from Epic Willow, Cerner PharmNet, and Pyxis/Omnicell ADC systems. | 46 |

<a id="domain-radiology"></a>

### Domain: Radiology

| Domain | Division | Total Subdomains | Description | Total Products |
|---|---|---|---|---|
| radiology | operations | 3 | Medical imaging and diagnostic radiology services. Owns imaging orders, modality scheduling (CT, MRI, X-ray, ultrasound, PET), PACS (Picture Archiving and Communication System) integration, radiology reports, DICOM image metadata, contrast administration, radiation dose tracking, radiologist interpretations, and CPT-coded procedures. Integrates with RIS (Radiology Information System) including Epic Radiant and Cerner RadNet. | 8 |

**Subdomains:** clinical_interpretation, image_acquisition, order_management


**List of Data Products**

| Subdomain | Product | Data Type | Description | Total Attributes |
|---|---|---|---|---|
| clinical_interpretation | critical_result | transactional_data | Tracks the communication workflow for critical and significant radiology findings requiring immediate clinical action per Joint Commission NPSG.02.03.01. Records finding description, severity level (critical, significant, incidental), notification method (phone, secure message, EHR alert), notified provider NPI, notification datetime, acknowledgment datetime, acknowledgment method, escalation flag, escalation datetime, and Joint Commission compliance status. Supports EMTALA compliance, TJC accreditation requirements, and patient safety event tracking. Aligns with HL7 FHIR CommunicationRequest resource for critical result notification workflows. | 49 |
| clinical_interpretation | report | transactional_data | Authoritative clinical document containing the radiologist's interpretation of an imaging study, including all addenda and amendments as versioned child records. Captures report accession number, report status (preliminary, final, addendum, amended), findings narrative, impression text, critical finding flag, dictation/transcription/attestation timestamps, signing radiologist NPI, addendum history (sequence, type, text, author, datetime), and HL7 ORU message ID. SSOT for radiologist interpretation, diagnostic conclusions, and report amendment history. Aligns with HL7 FHIR DiagnosticReport resource and IHE RAD-28 (Report Workflow). Integrates with Epic ClinDoc and Cerner PowerChart. | 44 |
| image_acquisition | contrast_admin | transactional_data | Transactional record of contrast agent administration events associated with an imaging study. Captures contrast agent name, NDC (National Drug Code), route of administration (IV, oral, intrathecal), dose administered (mL and mg), injection rate, injection site, pre-medication given flag, pre-medication details, adverse reaction flag, adverse reaction description, eGFR value at time of administration, contrast allergy screening result, administering clinician NPI, and administration datetime. Supports patient safety monitoring, contrast reaction tracking, and pharmacy reconciliation. Aligns with ACR Manual on Contrast Media guidelines and HL7 FHIR MedicationAdministration resource. | 53 |
| image_acquisition | dicom_series | master_data | DICOM series within a radiology study, containing series-level metadata and image attributes. | 44 |
| image_acquisition | modality | master_data | Master reference entity for physical imaging equipment units deployed across enterprise facilities. Captures modality unit identifier, equipment type (CT, MRI, PET-CT, X-ray, ultrasound, fluoroscopy, mammography, nuclear medicine), manufacturer, model, serial number, DICOM AE title, facility location, room assignment, installation date, last calibration date, FDA device registration, ACR accreditation status, and operational status. SSOT for imaging equipment identity within the radiology domain. Supports equipment utilization analytics, maintenance scheduling, and regulatory compliance tracking. | 46 |
| image_acquisition | protocol | reference_data | Defines standardized acquisition protocols for each modality and clinical indication combination. Stores protocol name, modality type, clinical indication, body part, contrast requirement flag, contrast agent type, slice thickness, kVp, mAs, field of view, reconstruction algorithm, scan duration estimate, patient preparation instructions, protocol version, effective date, and approving radiologist. Enables consistent image quality and supports radiation dose optimization programs. Managed within Epic Radiant protocol library. | 54 |
| order_management | appointment | transactional_data | SSOT resolved: defer to scheduling.scheduling_appointment as the single source of truth for this concept. This table is a domain-specific extension/reference. | 92 |
| order_management | imaging_order | transactional_data | Radiology imaging order placed by a provider for diagnostic or therapeutic imaging procedures. | 49 |

<a id="domain-scheduling"></a>

### Domain: Scheduling

| Domain | Division | Total Subdomains | Description | Total Products |
|---|---|---|---|---|
| scheduling | operations | 2 | Appointment and resource scheduling across all care settings. Includes outpatient appointments (Epic Cadence), surgical scheduling (OpTime), procedure scheduling, resource allocation (rooms, equipment, staff), waitlist management, appointment reminders, no-show tracking, and capacity planning. Supports patient access and operational throughput optimization. | 10 |

**Subdomains:** appointment_management, resource_allocation


**List of Data Products**

| Subdomain | Product | Data Type | Description | Total Attributes |
|---|---|---|---|---|
| appointment_management | appointment_type | reference_data | Master catalog of appointment types defining duration, requirements, and billing characteristics. | 40 |
| appointment_management | open_slot | transactional_data | Available appointment slots generated from schedule templates and block time. | 40 |
| appointment_management | provider_availability | transactional_data | Provider availability | 53 |
| appointment_management | schedule_template | master_data | Recurring schedule templates defining provider availability patterns and slot configurations. | 45 |
| appointment_management | telehealth_session | transactional_data | Telehealth sessions | 59 |
| appointment_management | waitlist_entry | transactional_data | Waitlist entries | 57 |
| resource_allocation | or_block | master_data | Operating room block time allocations | 38 |
| resource_allocation | resource_assignment | association_data | Resource assignments | 49 |
| resource_allocation | schedulable_resource | master_data | Schedulable resources | 40 |
| resource_allocation | surgical_case | transactional_data | Surgical case scheduling records including OR time, team, equipment, and case details. | 53 |

<a id="domain-billing"></a>

### Domain: Billing

| Domain | Division | Total Subdomains | Description | Total Products |
|---|---|---|---|---|
| billing | business | 2 | SSOT for all revenue cycle management (RCM) activities. Owns charge capture, CDM (Charge Description Master), professional and facility billing (CMS-1500, UB-04), coding (ICD-10, CPT, DRG), claim generation, payment posting, patient statements, collections, bad debt, contractual adjustments, ERA/EOB processing, and denial management. Integrates with Epic Resolute PB/HB, 3M HIS, and Cerner Revenue Cycle. | 9 |

**Subdomains:** account_settlement, revenue_capture


**List of Data Products**

| Subdomain | Product | Data Type | Description | Total Attributes |
|---|---|---|---|---|
| account_settlement | adjustment | transactional_data | Billing domain product: adjustment | 16 |
| account_settlement | patient_account | master_data | Billing domain product: patient_account | 12 |
| account_settlement | payment | transactional_data | Billing domain product: payment | 12 |
| account_settlement | payment_plan | master_data | Billing domain product: payment_plan | 12 |
| account_settlement | statement | transactional_data | Billing domain product: statement | 10 |
| revenue_capture | cdm_entry | master_data | Charge Description Master entry defining billable items and their standard prices | 44 |
| revenue_capture | charge | transactional_data | Individual billable charge for services, procedures, supplies, or medications | 60 |
| revenue_capture | coding_assignment | transactional_data | Billing domain product: coding_assignment | 20 |
| revenue_capture | invoice | transactional_data | Billing domain product: invoice | 14 |

<a id="domain-claim"></a>

### Domain: Claim

| Domain | Division | Total Subdomains | Description | Total Products |
|---|---|---|---|---|
| claim | business | 3 | Insurance claims processing and payer adjudication. Owns claim submission, claim status tracking, payer adjudication, remittance advice (ERA - Electronic Remittance Advice), EOB (Explanation of Benefits), denial management, appeals, prior authorization, eligibility verification, payer contract management, RAC audit responses, and coordination of benefits across HMO, PPO, POS, Medicare, and Medicaid payers. | 11 |

**Subdomains:** appeal_management, benefit_verification, payment_processing


**List of Data Products**

| Subdomain | Product | Data Type | Description | Total Attributes |
|---|---|---|---|---|
| appeal_management | appeal | transactional_data | Tracks claim appeals filed with payers to overturn denials. | 46 |
| appeal_management | denial | master_data | Tracks denied claims and denial management workflow including appeals. | 53 |
| benefit_verification | cob | transactional_data | Tracks coordination of benefits when patient has multiple insurance coverages. | 38 |
| benefit_verification | eligibility | transactional_data | Tracks real-time eligibility verification requests and responses from payers. | 47 |
| benefit_verification | prior_authorization | master_data | Tracks prior authorization requests and approvals required before service delivery. | 44 |
| payment_processing | claim | master_data | Core claim record representing a request for payment from a payer for healthcare services rendered. | 53 |
| payment_processing | diagnosis_link | transactional_data | Links diagnosis codes to claims for medical necessity and DRG grouping. | 33 |
| payment_processing | line | transactional_data | Individual service line within a claim, representing a single billable service or item. | 51 |
| payment_processing | remittance | transactional_data | Electronic remittance advice (ERA) from payers detailing payment and adjustments. | 45 |
| payment_processing | remittance_line | transactional_data | Individual service line detail within an ERA showing payment and adjustment details. | 53 |
| payment_processing | submission | transactional_data | Tracks claim submission events to payers including EDI transmission details. | 46 |

<a id="domain-insurance"></a>

### Domain: Insurance

| Domain | Division | Total Subdomains | Description | Total Products |
|---|---|---|---|---|
| insurance | business | 3 | Master data management for insurance payers, health plans, benefit structures, provider networks, and coverage policies. SSOT for payer identity, plan configurations, network definitions, and benefit rules that are referenced by billing, claim, patient, and encounter domains. | 14 |

**Subdomains:** member_coverage, plan_administration, reimbursement_terms


**List of Data Products**

| Subdomain | Product | Data Type | Description | Total Attributes |
|---|---|---|---|---|
| member_coverage | dependent | master_data | Dependent covered under a subscriber's insurance policy. | 42 |
| member_coverage | eligibility_span | master_data | Time-bound eligibility period for a member in a health plan with coverage details. | 50 |
| member_coverage | member_enrollment | transactional_data | Patient enrollment in a health plan with coverage dates, PCP assignment, and eligibility status. | 46 |
| member_coverage | subscriber | master_data | Primary insurance subscriber (policyholder) with demographics and coverage details. | 46 |
| plan_administration | benefit | master_data | Specific benefit coverage detail within a health plan (service type, cost-sharing, limits). | 51 |
| plan_administration | coverage_policy | master_data | Medical policy defining coverage criteria, prior auth requirements, and medical necessity for services. | 43 |
| plan_administration | health_plan | master_data | Specific health insurance plan offered by a payer with defined benefits, networks, and cost-sharing. | 56 |
| plan_administration | payer | master_data | Insurance payer organization (commercial, government, self-pay) that adjudicates and pays claims. | 51 |
| plan_administration | plan_network | association_data | Association between a health plan and a provider network with tier and cost-sharing rules. | 38 |
| plan_administration | provider_network | master_data | Network of contracted providers (clinicians, facilities) for a payer or health plan. | 43 |
| reimbursement_terms | fee_schedule | master_data | Fee schedule defining reimbursement rates for services under a payer contract. | 49 |
| reimbursement_terms | fee_schedule_line | master_data | Individual line item in a fee schedule specifying reimbursement for a specific procedure or service. | 50 |
| reimbursement_terms | payer_contract | master_data | Contract between provider organization and payer defining reimbursement terms and obligations. | 53 |
| reimbursement_terms | prior_auth_rule | master_data | Rule defining when prior authorization is required for a service, procedure, or diagnosis. | 48 |

<a id="domain-patient"></a>

### Domain: Patient

| Domain | Division | Total Subdomains | Description | Total Products |
|---|---|---|---|---|
| patient | business | 3 | Master data for all individuals receiving healthcare services. SSOT for patient identity, demographics, MRN (Medical Record Number), MPI (Master Patient Index), insurance coverage, emergency contacts, consent records, SDOH (Social Determinants of Health), patient preferences, and PHI-protected identity information. Referenced by every clinical and financial domain via patient_id FK. | 11 |

**Subdomains:** care_coordination, financial_responsibility, identity_management


**List of Data Products**

| Subdomain | Product | Data Type | Description | Total Attributes |
|---|---|---|---|---|
| care_coordination | emergency_contact | master_data | Patient emergency contact records capturing contact name, relationship type, priority order, phone numbers (home, mobile, work), address, and authorization level (e.g., authorized to receive PHI, healthcare proxy, legal guardian). Supports EMTALA compliance, care coordination, and discharge planning workflows. Sourced from Epic and Cerner registration modules. | 52 |
| care_coordination | pcp_attribution | master_data | Patient attribution to Primary Care Physician (PCP) or care team records capturing attributed provider NPI, attribution method (claims-based, enrollment-based, manual), attribution panel, attribution effective and end dates, ACO/HMO/PPO plan attribution, and attribution confidence score. SSOT for care team assignment used in population health, HEDIS, MIPS, and value-based care reporting. Sourced from population health management and payer attribution feeds. | 56 |
| care_coordination | registration_event | transactional_data | Patient registration lifecycle event records capturing event type (new registration, pre-registration, update, merge, unmerge), registration date and time, registering facility, registration source (ED walk-in, scheduled, transfer, online pre-registration), registration completeness score, identity verification method (photo ID, insurance card, biometric), and registration staff. Provides the audit trail for patient identity creation and maintenance events within the MPI lifecycle. Distinct from encounter-level ADT events — this product tracks identity/registration events, not clinical visit movements. Sourced from EHR ADT and registration modules. | 58 |
| financial_responsibility | eligibility_check | transactional_data | Real-time and batch insurance eligibility verification transaction records capturing verification date and time, payer queried, verification method (270/271 EDI, portal, phone), eligibility status returned, coverage details confirmed, copay/deductible amounts verified, prior authorization requirements, and verification source system. Supports front-end RCM workflows and reduces claim denials. Sourced from Epic Resolute and Cerner Revenue Cycle eligibility modules. | 54 |
| financial_responsibility | guarantor | master_data | Financial guarantor record identifying the individual or entity responsible for patient account balances. Captures guarantor name, relationship to patient, address, phone, employer information, SSN (masked), and account responsibility percentage. Supports RCM billing workflows, patient financial counseling, and self-pay collection processes. Sourced from EHR revenue cycle and patient accounting modules. | 58 |
| financial_responsibility | insurance_coverage | master_data | Patient insurance coverage, eligibility, and verification records. Captures payer name, plan name, plan type (HMO, PPO, POS, Medicare, Medicaid, self-pay), member ID, group number, subscriber relationship, coverage effective and termination dates, coordination of benefits (COB) priority, copay/deductible/out-of-pocket amounts, pre-authorization requirements, and real-time/batch eligibility verification transactions (270/271 EDI, portal, phone) with verification status, confirmed coverage details, verification date/time, payer queried, and verification audit trail. SSOT for patient payer eligibility and verification consumed by billing and claims domains. Supports front-end RCM workflows, claim denial prevention, and prior authorization management. Aligned with X12 270/271 transaction standards and HL7 FHIR Coverage resource. Sourced from EHR revenue cycle and eligibility verification modules. | 49 |
| identity_management | address | master_data | Patient address records supporting multiple address types (home, mailing, temporary, work) with full address components, geocoding coordinates, county/census tract for SDOH analysis, address validation status, effective date ranges, and do-not-mail flags. Supports population health outreach, care gap closure, and SDOH stratification. Sourced from Epic and Cerner registration systems. | 57 |
| identity_management | consent_reference | master_data | Lightweight reference record linking a patient to their consent records in the consent domain SSOT. Captures patient_id and consent_master_id FK for cross-domain joins. | 56 |
| identity_management | demographics | master_data | Core patient demographic profile — legal name, date of birth, gender identity, sex assigned at birth, race, ethnicity, preferred language, marital status, religion, addresses (home, mailing, temporary, work with geocoding and SDOH census tract linkage), phone numbers, email, emergency contacts with authorization levels and healthcare proxy designations, deceased status (date, cause, manner of death, death certificate reference), and PHI-protected identity attributes. SSOT for patient identity attributes downstream of MPI, multi-address management, and emergency contact records. Supports population health outreach, EMTALA-compliant emergency contact access, vital statistics reporting, and population health stratification. Compliant with HIPAA PHI classification, CMS demographic data requirements, and aligned with HL7 FHIR Patient resource demographics elements. Sourced from EHR registration modules, ADT systems, and state vital records. | 59 |
| identity_management | mpi_record | master_data | Enterprise Single Source of Truth (SSOT) for patient identity across multi-facility health systems. The Master Patient Index record serves as the authoritative golden record for patient identity resolution, linking all facility-specific MRNs, demographic data, and identity attributes into a unified enterprise patient identity. Supports EMPI matching algorithms, identity confidence scoring, merge/unmerge workflows, and cross-facility patient linking for integrated delivery networks (IDNs) and health information exchanges (HIEs). | 57 |
| identity_management | portal_account | master_data | Patient portal and digital engagement account record capturing portal platform, account creation date, activation status, last login date, two-factor authentication enrollment, proxy access grants (parent/guardian, adult caregiver, legal guardian, healthcare POA) with proxy identity, access levels (full, limited, view-only), authorization and expiration dates, revocation dates, supporting legal documentation references, messaging opt-in status, appointment self-scheduling enablement, and digital health app linkages. SSOT for patient digital engagement and proxy access management. Supports patient engagement, HIPAA-compliant proxy access, MIPS Promoting Interoperability measures, and digital front door strategy. Aligned with HL7 FHIR RelatedPerson resource for proxy relationships. Sourced from patient portal and proxy management systems. | 56 |

<a id="domain-provider"></a>

### Domain: Provider

| Domain | Division | Total Subdomains | Description | Total Products |
|---|---|---|---|---|
| provider | business | 2 | Authoritative repository for all healthcare professionals and organizational providers. Includes physicians, nurses, allied health professionals, NPI (National Provider Identifier), DEA numbers, credentials, specialties, licensure, hospital privileges, credentialing status, payer enrollment, and provider network affiliations. SSOT for provider identity and authorization. | 10 |

**Subdomains:** individual_practitioners, organizational_entities


**List of Data Products**

| Subdomain | Product | Data Type | Description | Total Attributes |
|---|---|---|---|---|
| individual_practitioners | board_certification | master_data | Board certifications | 11 |
| individual_practitioners | clinician | master_data | Individual healthcare providers (physicians, NPs, PAs, etc.) with clinical credentials | 51 |
| individual_practitioners | credential | master_data | Individual credentials (licenses, certifications, DEA, board certs) with expiration tracking | 44 |
| individual_practitioners | dea_registration | master_data | DEA registration tracking | 11 |
| individual_practitioners | privileging | master_data | Clinical privileges granted to providers at specific facilities | 46 |
| organizational_entities | group | master_data | Provider groups (medical groups, IPAs, ACOs) with group NPI and TIN | 45 |
| organizational_entities | group_membership | transactional_data | Provider membership in groups with FTE allocation and role | 45 |
| organizational_entities | network_affiliation | transactional_data | Provider participation in payer networks with tier and panel status | 46 |
| organizational_entities | org_provider | master_data | Organizational providers (hospitals, clinics, labs, DME suppliers) | 48 |
| organizational_entities | specialty | reference_data | Clinical specialties and subspecialties with credentialing and enrollment rules | 44 |

## Metric Views

Total metric views generated: **84**. Showing top 20.

| # | View Name | Domain | Source Table | Description |
|---|---|---|---|---|
| 1 | clinical_allergy | clinical | allergy | Allergy documentation and medication safety metrics tracking allergy prevalence, severity, reconciliation status, and clinical decision support alert effectiveness. |
| 2 | clinical_care_plan | clinical | care_plan | Care coordination and population health metrics tracking care plan activation, goal achievement, readmission risk, and care gap closure across patient populations and programs. |
| 3 | clinical_diagnosis | clinical | diagnosis | Core diagnostic metrics tracking diagnosis volume, chronic condition burden, quality measure impact, and coding workflow efficiency across care settings and patient populations. |
| 4 | clinical_immunization | clinical | immunization | Immunization coverage, compliance, and public health reporting metrics tracking vaccination rates, series completion, adverse reactions, and registry reporting across patient populations. |
| 5 | clinical_procedure_event | clinical | procedure_event | Surgical and procedural volume, efficiency, revenue, and quality metrics tracking procedure throughput, duration, cancellations, and charge capture across service lines. |
| 6 | clinical_vital_sign | clinical | vital_sign | Vital signs monitoring and early warning metrics tracking vital sign capture frequency, abnormal value rates, early warning score trends, and remote patient monitoring engagement. |
| 7 | encounter_adt_event | encounter | adt_event | Adt Event business metrics |
| 8 | encounter_bed_assignment | encounter | bed_assignment | Bed Assignment business metrics |
| 9 | encounter_discharge_summary | encounter | discharge_summary | Discharge Summary business metrics |
| 10 | encounter_drg_assignment | encounter | drg_assignment | Drg Assignment business metrics |
| 11 | encounter_triage_assessment | encounter | triage_assessment | Triage Assessment business metrics |
| 12 | encounter_visit | encounter | visit | Visit business metrics |
| 13 | encounter_visit_diagnosis | encounter | visit_diagnosis | Visit Diagnosis business metrics |
| 14 | encounter_visit_insurance | encounter | visit_insurance | Visit Insurance business metrics |
| 15 | encounter_visit_procedure | encounter | visit_procedure | Visit Procedure business metrics |
| 16 | encounter_visit_provider | encounter | visit_provider | Visit Provider business metrics |
| 17 | laboratory_blood_bank_unit | laboratory | blood_bank_unit | Blood bank inventory and transfusion metrics tracking unit utilization, wastage, crossmatch efficiency, and blood product management. |
| 18 | laboratory_lab_order | laboratory | lab_order | Core laboratory order metrics tracking order volume, turnaround time, cancellation rates, and operational efficiency across order priorities and statuses. |
| 19 | laboratory_microbiology_culture | laboratory | microbiology_culture | Microbiology culture quality and infection control metrics tracking pathogen detection, MDRO surveillance, HAI monitoring, and antibiotic stewardship. |
| 20 | laboratory_pathology_report | laboratory | pathology_report | Anatomic pathology quality and turnaround metrics tracking cancer diagnosis, critical value notification, amendment rates, and reporting timeliness. |

*... and 64 more metric views. See the `metrics/` folder for full details.*