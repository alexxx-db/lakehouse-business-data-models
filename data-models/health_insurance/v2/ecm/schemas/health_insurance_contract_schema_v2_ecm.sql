-- Schema for Domain: contract | Business:  | Version: v2_ecm
-- Generated on: 2026-06-27 08:47:29

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_health_insurance_v1`.`contract` COMMENT 'Manages provider contracts, reimbursement agreements, capitation arrangements, fee schedules, value-based care (VBC) contracts, ACO agreements, risk-sharing models, contract terms, amendments, and contract lifecycle. Tracks contract effective dates, rate tables, and payment methodologies (fee-for-service, capitation, bundled payments). SSOT for all contractual and reimbursement terms between the health plan and providers.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`contract`.`party` (
    `party_id` BIGINT COMMENT 'Unique surrogate identifier for each party record in the provider contract domain. Serves as the primary key for all contractual party references across the health plan enterprise.',
    `provider_contract_id` BIGINT COMMENT 'Reference to the provider contract this party is bound by. Links the party record to its governing contractual agreement within the contract domain.',
    `legal_entity_id` BIGINT COMMENT 'add column legal_entity_id (BIGINT) with FK to finance.legal_entity.legal_entity_id - internal contract parties are legal entities',
    `record_id` BIGINT COMMENT 'Foreign key linking to credential.credential_record. Business justification: Party represents a provider entity in a contract; linking to its credential record enables tracking of credential status and compliance per party.',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to vendor.vendor. Business justification: Contract Party Management report requires linking party records to vendor master to identify vendor parties (e.g., TPAs) for compliance and payment processing.',
    `aco_indicator` BOOLEAN COMMENT 'Indicates whether this party is an Accountable Care Organization (ACO) participating in a value-based care (VBC) arrangement. Triggers ACO-specific contract terms, shared savings calculations, and CMS reporting requirements.',
    `capitation_eligible_indicator` BOOLEAN COMMENT 'Indicates whether this party is eligible to receive capitation payments (Per Member Per Month - PMPM) under the contract. Drives capitation payment processing and actuarial PMPM rate application.',
    `contract_party_number` STRING COMMENT 'Externally-known alphanumeric identifier assigned to this party within the contract management system (e.g., Cactus or ProviderSource provider contract number). Used for cross-system reconciliation, EDI transactions, and provider directory publication.',
    `created_timestamp` TIMESTAMP COMMENT 'Standard ECM audit/governance attribute created_timestamp.',
    `credentialing_date` DATE COMMENT 'Date on which the party was most recently credentialed or re-credentialed by the health plan. NCQA requires re-credentialing every 36 months. Used to trigger re-credentialing workflows and network compliance reporting.',
    `credentialing_status` STRING COMMENT 'Current credentialing status of the party as maintained in the Provider Management System (Cactus/ProviderSource). Determines whether the party is eligible to provide services to plan members. Credentialing must be current for claims to be adjudicated as in-network.. Valid values are `credentialed|pending|expired|denied|not_required`',
    `data_quality_score` STRING COMMENT 'Computed data-quality score for ECM scoring.',
    `delegation_indicator` BOOLEAN COMMENT 'Indicates whether this party is a delegated entity authorized to perform functions on behalf of the health plan (e.g., credentialing, utilization management, claims processing). Triggers delegation oversight and audit requirements per NCQA and state DOI standards.',
    `delegation_scope` STRING COMMENT 'Specifies the functional scope of delegation authority granted to this party. Applicable only when delegation_indicator is true. Defines which health plan functions the delegated entity is authorized to perform on behalf of the payer.. Valid values are `credentialing|claims|utilization_management|care_management|all`',
    `doing_business_as_name` STRING COMMENT 'Trade name or DBA name under which the party operates, if different from the legal entity name. Commonly used for group practices and hospital systems that operate under a brand name distinct from their legal registration.',
    `effective_date` DATE COMMENT 'Date on which this partys participation in the contract becomes effective. Drives claims adjudication eligibility windows, network directory publication, and provider credentialing timelines.',
    `effective_end_date` DATE COMMENT 'Effective end of the record validity window.',
    `effective_start_date` DATE COMMENT 'Effective start of the record validity window.',
    `ein` STRING COMMENT 'Employer Identification Number',
    `fhir_last_updated` TIMESTAMP COMMENT 'FHIR meta.lastUpdated for resource versioning',
    `fhir_profile_url` STRING COMMENT 'Canonical FHIR/US Core profile URL this record conforms to',
    `fhir_resource_reference` STRING COMMENT 'Stable FHIR logical resource id for interop exchange',
    `fhir_resource_type` STRING COMMENT 'FHIR resource type this record maps to for interoperability (default: Basic)',
    `fhir_version_code` STRING COMMENT 'FHIR meta.versionId optimistic concurrency token',
    `is_active` BOOLEAN COMMENT 'Logical active flag for soft-delete and current-state filtering.',
    `license_expiration_date` DATE COMMENT 'Date on which the partys primary state professional or business license expires. Triggers credentialing re-verification workflows and may result in contract suspension if not renewed. Critical for NCQA and URAC credentialing compliance.',
    `license_state` STRING COMMENT 'Two-letter USPS state abbreviation where the party holds its primary professional or business license. Used for network adequacy reporting, credentialing, and state-specific regulatory compliance.. Valid values are `^[A-Z]{2}$`',
    `line_of_business` STRING COMMENT 'Health plan line of business under which this party is contracted. Determines applicable regulatory requirements, reimbursement methodologies, and network adequacy standards. [ENUM-REF-CANDIDATE: commercial|medicare_advantage|medicaid|marketplace|cobra|fehb — promote to reference product]. Valid values are `commercial|medicare_advantage|medicaid|marketplace|cobra|fehb`',
    `malpractice_coverage_indicator` BOOLEAN COMMENT 'Indicates whether the party maintains active professional liability (malpractice) insurance coverage as required by the contract. Failure to maintain coverage may trigger contract suspension or termination per NCQA credentialing standards.',
    `malpractice_expiration_date` DATE COMMENT 'Date on which the partys professional liability (malpractice) insurance policy expires. Triggers credentialing re-verification and contract compliance monitoring workflows.',
    `master_entity_reference` STRING COMMENT 'Cross-domain master/golden entity key for SSOT resolution.',
    `network_participation_type` STRING COMMENT 'Indicates whether the party is a participating (PAR) in-network provider, a non-participating (non-PAR) provider, or an out-of-network provider. Drives member cost-sharing calculations, claims adjudication rules, and EOB generation.. Valid values are `par|non_par|out_of_network`',
    `notes` STRING COMMENT 'Free-text field for capturing supplemental information about the party that does not fit structured attributes. May include contract negotiation notes, special arrangement details, or credentialing exceptions. Classified as confidential due to potential inclusion of sensitive business information.',
    `npi` STRING COMMENT 'The 10-digit National Provider Identifier assigned by CMS to uniquely identify the provider party. Type 1 NPI for individual providers; Type 2 NPI for organizational providers. Required for all HIPAA-covered transactions including 837 claims and 270/271 eligibility inquiries.. Valid values are `^[0-9]{10}$`',
    `npi_type` STRING COMMENT 'Indicates whether the NPI is Type 1 (individual/solo practitioner) or Type 2 (organizational entity such as group practice, hospital, or IPA). Determines credentialing requirements and contract structure.. Valid values are `type_1|type_2`',
    `oig_exclusion_indicator` BOOLEAN COMMENT 'Indicates whether the party appears on the OIG List of Excluded Individuals/Entities (LEIE). Excluded parties are prohibited from participating in Medicare, Medicaid, and other federal healthcare programs. Checked monthly per CMS compliance requirements.',
    `party_role` STRING COMMENT 'Functional role of this party within the contract relationship. Identifies whether the party is the health plan (payer), a contracting provider, a delegated entity, an Independent Practice Association (IPA), an Accountable Care Organization (ACO), a hospital system, or a group practice. [ENUM-REF-CANDIDATE: payer|provider|delegated_entity|ipa|aco|hospital_system|group_practice — promote to reference product]',
    `party_status` STRING COMMENT 'Current lifecycle status of the party within the contract. Indicates whether the party is actively bound by the contract, pending execution, suspended, terminated, or inactive. Drives eligibility verification and claims adjudication routing.. Valid values are `active|inactive|pending|terminated|suspended`',
    `party_type` STRING COMMENT 'Classifies the party as an individual (natural person, e.g., solo practitioner with individual NPI) or an organization (legal entity, e.g., group practice, hospital, IPA, ACO). Drives NPI type assignment and credentialing workflow.. Valid values are `individual|organization`',
    `primary_specialty_code` STRING COMMENT 'NUCC Health Care Provider Taxonomy Code representing the partys primary clinical specialty. Used for network adequacy analysis, claims routing, prior authorization rules, and provider directory classification.. Valid values are `^[A-Z0-9]{10}$`',
    `raf_applicable_indicator` BOOLEAN COMMENT 'Indicates whether Risk Adjustment Factor (RAF) scoring applies to this partys contract arrangement. Relevant for Medicare Advantage and ACA marketplace contracts where Hierarchical Condition Category (HCC) risk scores drive capitation payments.',
    `record_created_at` TIMESTAMP COMMENT 'Timestamp the record was created (audit lineage).',
    `record_created_timestamp` TIMESTAMP COMMENT 'Timestamp when this party record was first created in the data platform. Supports audit trail, data lineage, and compliance reporting requirements. Formatted as yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `record_source_system` STRING COMMENT 'System of record / source system that produced this record (SSOT provenance).',
    `record_status` STRING COMMENT 'Standard ECM audit/governance attribute record_status.',
    `record_updated_at` TIMESTAMP COMMENT 'Timestamp the record was last updated (audit lineage).',
    `record_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this party record was most recently modified in the data platform. Supports change data capture, audit trail, and SCD Type 2 processing in the Databricks Silver Layer.',
    `record_version` STRING COMMENT 'Optimistic-concurrency / change version of the record.',
    `recredentialing_due_date` DATE COMMENT 'Date by which the party must complete re-credentialing to maintain active network participation. Calculated as 36 months from the credentialing_date per NCQA standards. Drives automated re-credentialing workflow initiation.',
    `role_code` STRING COMMENT 'Role of the party in the contract',
    `sanction_indicator` BOOLEAN COMMENT 'Indicates whether the party has an active sanction, exclusion, or adverse action recorded by OIG, SAM, or state licensing boards. A true value triggers contract suspension review and claims payment hold per CMS and HIPAA compliance requirements.',
    `secondary_specialty_code` STRING COMMENT 'NUCC Health Care Provider Taxonomy Code representing the partys secondary clinical specialty, if applicable. Supports multi-specialty provider contracting and network adequacy reporting.. Valid values are `^[A-Z0-9]{10}$`',
    `service_area_state` STRING COMMENT 'Two-letter USPS state abbreviation representing the primary state in which this party provides services under the contract. Used for network adequacy reporting, state regulatory compliance, and geographic claims routing.. Valid values are `^[A-Z]{2}$`',
    `service_area_zip_code` STRING COMMENT 'Primary ZIP code of the partys principal service location. Used for network adequacy geo-mapping, member-to-provider distance calculations, and CMS network adequacy submissions.. Valid values are `^[0-9]{5}(-[0-9]{4})?$`',
    `signatory_name` STRING COMMENT 'Full name of the authorized individual who signed or has authority to sign the contract on behalf of this party. Required for contract execution validation and legal enforceability. Typically the CEO, CMO, or designated contracting officer.',
    `signatory_title` STRING COMMENT 'Official title or position of the authorized signatory (e.g., Chief Executive Officer, Medical Director, Contracting Officer). Validates the authority level of the individual executing the contract on behalf of the party.',
    `source_system_code` STRING COMMENT 'Identifies the operational system of record from which this party record originated (e.g., Cactus, ProviderSource, Facets, QNXT). Supports data lineage tracking, reconciliation, and ETL audit in the Databricks Silver Layer.. Valid values are `cactus|provider_source|facets|qnxt|manual`',
    `source_system_party_reference` STRING COMMENT 'The native identifier of this party record in the originating operational system (e.g., Cactus provider ID, ProviderSource contract party key). Enables cross-system reconciliation and traceability from the Silver Layer back to the system of record.',
    `state_license_number` STRING COMMENT 'State-issued professional or business license number for the contracting party. Required for credentialing verification and network participation. For individual providers, this is the state medical license; for organizations, the state business license or certificate of authority.',
    `tax_code` STRING COMMENT 'Tax identification number',
    `termination_date` DATE COMMENT 'Date on which this partys participation in the contract ends. Null for open-ended or currently active parties. Used to determine network participation windows, claims payment eligibility, and member notification requirements.',
    `tin` STRING COMMENT 'Federal Tax Identification Number (EIN or SSN) used for payment processing, 1099 reporting, and IRS compliance. Critical for remittance and premium payment routing. Stored as 9-digit numeric string without hyphens.. Valid values are `^[0-9]{9}$`',
    `type_code` STRING COMMENT 'Type of contract party',
    `updated_timestamp` TIMESTAMP COMMENT 'Standard ECM audit/governance attribute updated_timestamp.',
    `vbc_arrangement_type` STRING COMMENT 'Specifies the payment methodology or value-based care arrangement type applicable to this party under the contract. Drives reimbursement calculation logic, risk-sharing model application, and financial reporting. [ENUM-REF-CANDIDATE: fee_for_service|capitation|bundled_payment|shared_savings|global_risk — promote to reference product]. Valid values are `fee_for_service|capitation|bundled_payment|shared_savings|global_risk`',
    `party_type_code` STRING COMMENT '',
    `party_role_code` STRING COMMENT '',
    `tax_id` STRING COMMENT '',
    CONSTRAINT pk_party PRIMARY KEY(`party_id`)
) COMMENT 'Identifies all parties bound by a provider contract — the health plan entity, the contracting provider (individual NPI or organizational NPI), group practice, IPA, ACO, or hospital system. Tracks party role (payer, provider, delegated entity), NPI, TIN, legal entity name, signatory authority, and party effective dates. Supports multi-party and delegated contracting arrangements.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`contract`.`term` (
    `term_id` BIGINT COMMENT 'Unique surrogate identifier for a contract term record in the provider contract management system (Facets/QNXT or Provider Management System). Serves as the primary key for the term entity.',
    `contract_amendment_id` BIGINT COMMENT 'Reference to the contract amendment that introduced or modified this term, if applicable. Null if the term originates from the base contract rather than an amendment.',
    `provider_contract_id` BIGINT COMMENT 'Reference to the parent provider contract to which this term belongs. Links the term to its governing contract in the Provider Network Management system.',
    `fee_schedule_id` BIGINT COMMENT 'Reference to the fee schedule associated with this term when payment_methodology is fee_for_service. Links to the rate table governing allowed amounts for procedure codes under this term.',
    `audit_rights_period_years` STRING COMMENT 'The number of years the health plan retains the right to audit provider records under this audit rights term. Typically 7 years per HIPAA and CMS requirements. Applicable when term_type is audit_rights.',
    `auto_renew` BOOLEAN COMMENT 'Indicates whether this term automatically renews upon expiration without requiring renegotiation (True). Supports contract lifecycle management and renewal notification workflows.',
    `capitation_rate` DECIMAL(18,2) COMMENT 'The Per Member Per Month (PMPM) capitation rate defined by this term when payment_methodology is capitation. Represents the fixed monthly payment per enrolled member to the provider regardless of services rendered. Classified confidential as proprietary pricing.',
    `compliance_checkpoint_date` DATE COMMENT 'The scheduled date for the next compliance review or audit checkpoint associated with this term. Used by the compliance team to track regulatory obligations, CMS audit readiness, and DOI examination preparation.',
    `cpt_range_end` STRING COMMENT 'The ending CPT or HCPCS procedure code of the range to which this reimbursement rule term applies. Used in conjunction with cpt_range_start to define the applicable procedure code range for adjudication.. Valid values are `^[0-9A-Z]{5}$`',
    `cpt_range_start` STRING COMMENT 'The starting CPT or HCPCS procedure code of the range to which this reimbursement rule term applies. Used in conjunction with cpt_range_end to define the applicable procedure code range for adjudication.. Valid values are `^[0-9A-Z]{5}$`',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this contract term record was first created in the system. Supports audit trail, data lineage, and regulatory record retention requirements.',
    `data_quality_score` STRING COMMENT 'Computed data-quality score for ECM scoring.',
    `dispute_resolution_method` STRING COMMENT 'The contractually agreed method for resolving disputes arising under this term: Arbitration, Mediation, Litigation, or Internal Review. Applicable for hold-harmless, indemnification, and audit rights terms.. Valid values are `arbitration|mediation|litigation|internal_review`',
    `drg_grouper_version` STRING COMMENT 'The DRG grouper version (e.g., MS-DRG v41.0, APR-DRG v39) applicable to this term when payment_methodology is drg_based. Ensures adjudication uses the correct DRG weight tables for inpatient reimbursement.',
    `effective_date` DATE COMMENT 'The date on which this contract term becomes legally binding and operationally enforceable. Used to determine applicability during claims adjudication in Facets/QNXT.',
    `effective_end_date` DATE COMMENT 'Effective end of the record validity window.',
    `effective_start_date` DATE COMMENT 'Effective start of the record validity window.',
    `expiration_date` DATE COMMENT 'The date on which this contract term ceases to be binding. Null for open-ended terms with no defined end date. Used in adjudication date-range checks.',
    `fhir_last_updated` TIMESTAMP COMMENT 'FHIR meta.lastUpdated for resource versioning',
    `fhir_profile_url` STRING COMMENT 'Canonical FHIR/US Core profile URL this record conforms to',
    `fhir_resource_reference` STRING COMMENT 'Stable FHIR logical resource id for interop exchange',
    `fhir_resource_type` STRING COMMENT 'FHIR resource type this record maps to for interoperability (default: Basic)',
    `fhir_version_code` STRING COMMENT 'FHIR meta.versionId optimistic concurrency token',
    `governing_state` STRING COMMENT 'The two-letter US state code whose laws govern this contract term. Determines applicable state DOI regulations, insurance code requirements, and state-specific provider contract mandates.. Valid values are `^[A-Z]{2}$`',
    `hipaa_baa_required` BOOLEAN COMMENT 'Indicates whether this term constitutes or requires a HIPAA Business Associate Agreement (BAA) (True). Triggers compliance tracking and ensures Protected Health Information (PHI) handling obligations are documented per HIPAA 45 CFR Part 164.',
    `icd_version` STRING COMMENT 'Specifies the ICD diagnosis coding version applicable to this term when the term references diagnosis-based reimbursement rules or Hierarchical Condition Category (HCC) risk adjustment provisions.. Valid values are `ICD-10|ICD-11`',
    `incentive_amount` DECIMAL(18,2) COMMENT 'The maximum dollar amount of quality incentive payment available to the provider under this term upon meeting quality_metric_threshold. Applicable for VBC, ACO, and pay-for-performance contract terms. Classified confidential as proprietary financial terms.',
    `is_active` BOOLEAN COMMENT 'Logical active flag for soft-delete and current-state filtering.',
    `is_adjudication_rule` BOOLEAN COMMENT 'Indicates whether this term directly drives claims adjudication logic in Facets/QNXT (True). When True, the terms reimbursement_policy_subtype, cpt_range_start/end, and reduction_percentage are loaded into the adjudication engine.',
    `is_negotiable` BOOLEAN COMMENT 'Indicates whether this contract term is open to negotiation (True) or is standard non-negotiable boilerplate language (False). Supports contract negotiation workflow and template management.',
    `is_standard_boilerplate` BOOLEAN COMMENT 'Indicates whether this term is sourced from the organizations standard contract template library (True) or is a custom-negotiated term specific to this contract (False). Supports template governance and deviation tracking.',
    `lob_applicability` STRING COMMENT 'Specifies which Line of Business (LOB) this contract term applies to. Enables selective application of reimbursement rules and contractual obligations across Commercial, Medicare Advantage, Medicaid, Marketplace (ACA/QHP), or all lines of business.. Valid values are `commercial|medicare_advantage|medicaid|marketplace|all`',
    `mac_pricing_basis` STRING COMMENT 'The drug pricing benchmark used for pharmacy reimbursement terms: Average Wholesale Price (AWP), Wholesale Acquisition Cost (WAC), Maximum Allowable Cost (MAC), National Average Drug Acquisition Cost (NADAC), or a custom contracted rate. Applicable for terms covering pharmacy benefits.. Valid values are `awp|wac|mac|nadac|custom`',
    `master_entity_reference` STRING COMMENT 'Cross-domain master/golden entity key for SSOT resolution.',
    `payment_methodology` STRING COMMENT 'The reimbursement payment methodology defined by this term when term_type is payment_methodology or reimbursement_rule. Drives adjudication logic in Facets/QNXT. Includes Fee-for-Service (FFS), Capitation, Bundled Payment, Case Rate, Per Diem, Diagnosis Related Group (DRG)-based, Reference Based Pricing (RBP), and Value-Based Care (VBC). [ENUM-REF-CANDIDATE: fee_for_service|capitation|bundled_payment|case_rate|per_diem|drg_based|rbp|vbc — 8 candidates stripped; promote to reference product]',
    `pos_code` STRING COMMENT 'The CMS Place of Service (POS) code to which this terms reimbursement differential applies, when reimbursement_policy_subtype is pos_differential. Two-digit code per CMS POS code set (e.g., 11 for Office, 21 for Inpatient Hospital).. Valid values are `^[0-9]{2}$`',
    `quality_metric_threshold` DECIMAL(18,2) COMMENT 'The minimum quality performance threshold (expressed as a percentage or score) that the provider must achieve to qualify for incentive payments or avoid penalties under quality incentive terms. Linked to HEDIS or STAR measures.',
    `record_created_at` TIMESTAMP COMMENT 'Timestamp the record was created (audit lineage).',
    `record_source_system` STRING COMMENT 'System of record / source system that produced this record (SSOT provenance).',
    `record_status` STRING COMMENT 'Standard ECM audit/governance attribute record_status.',
    `record_updated_at` TIMESTAMP COMMENT 'Timestamp the record was last updated (audit lineage).',
    `record_version` STRING COMMENT 'Optimistic-concurrency / change version of the record.',
    `reduction_percentage` DECIMAL(18,2) COMMENT 'The percentage reduction applied to the allowed amount under this reimbursement rule term (e.g., 50.00 for a 50% reduction on secondary procedures under multiple procedure reduction policy). Applicable when reimbursement_policy_subtype is set. Classified confidential as it represents proprietary pricing.',
    `reimbursement_policy_subtype` STRING COMMENT 'Granular sub-classification of the reimbursement rule when term_type is reimbursement_rule. Specifies the specific adjudication policy: Multiple Procedure Reduction, Bilateral Procedure, Assistant Surgeon, Global Surgery, Unbundling Rules, Place-of-Service (POS) Differential, or Modifier Impact. Directly maps to adjudication logic in Facets/QNXT. [ENUM-REF-CANDIDATE: multiple_procedure_reduction|bilateral_procedure|assistant_surgeon|global_surgery|unbundling|pos_differential|modifier_impact — 7 candidates stripped; promote to reference product]',
    `renewal_notice_days` STRING COMMENT 'The number of calendar days prior to expiration_date by which either party must provide notice of intent not to renew this term. Applicable when auto_renew is True.',
    `risk_sharing_model` STRING COMMENT 'Defines the risk-sharing arrangement under Value-Based Care (VBC) or Accountable Care Organization (ACO) contract terms. Specifies whether the provider participates in shared savings only (upside), shared risk (two-sided), or full risk (global capitation).. Valid values are `shared_savings|shared_risk|full_risk|upside_only|downside_only`',
    `source_system_term_ref` STRING COMMENT 'The native identifier of this term record in the originating operational system (e.g., Cactus contract clause ID, QNXT reimbursement rule ID, or ProviderSource term reference). Supports data lineage and reconciliation with source systems.',
    `summary` STRING COMMENT 'Plain-language operational summary of the terms intent and impact, authored by the contracting team. Used for training, audits, and quick reference without reading full legal text.',
    `term_number` STRING COMMENT 'Human-readable external identifier for the term, typically formatted as a section or clause reference (e.g., TERM-2024-0042 or Section 4.2.1). Used in contract documents and correspondence.',
    `term_status` STRING COMMENT 'Current lifecycle state of the contract term. active indicates the term is currently in force; superseded indicates it has been replaced by an amendment; expired indicates the effective period has lapsed.. Valid values are `active|inactive|pending|superseded|expired|draft`',
    `term_type` STRING COMMENT 'Categorical classification of the contract term defining its legal or operational purpose. Drives downstream adjudication logic and compliance tracking. [ENUM-REF-CANDIDATE: reimbursement_rule|payment_methodology|exclusivity|termination_clause|audit_rights|hold_harmless|indemnification|confidentiality|hipaa_baa|quality_incentive — promote to reference product]',
    `termination_cause_type` STRING COMMENT 'Specifies the basis under which termination is permitted by this term: For Cause (material breach, fraud, license revocation), Without Cause (convenience), Mutual Agreement, or Regulatory (required by law or CMS/DOI directive).. Valid values are `for_cause|without_cause|mutual_agreement|regulatory`',
    `termination_notice_days` STRING COMMENT 'The number of calendar days of advance written notice required to terminate the contract under this termination clause term. Applicable when term_type is termination_clause. Typically 30, 60, or 90 days per regulatory requirements.',
    `text` STRING COMMENT 'Full verbatim legal text of the contract term as negotiated and executed. Contains the binding contractual language. Classified confidential as it represents proprietary reimbursement and legal obligations.',
    `title` STRING COMMENT 'Short descriptive title of the contract term as it appears in the contract document (e.g., Multiple Procedure Reduction Policy, Termination for Cause Clause). Supports search and display in contract management UIs.',
    `updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this contract term record was last modified. Supports change tracking, audit trail, and Silver layer incremental processing in the Databricks Lakehouse.',
    `withhold_percentage` DECIMAL(18,2) COMMENT 'The percentage of reimbursement withheld from provider payments pending quality performance or risk settlement under VBC or capitation arrangements. Classified confidential as proprietary financial terms.',
    CONSTRAINT pk_term PRIMARY KEY(`term_id`)
) COMMENT 'Defines the specific terms, conditions, obligations, and reimbursement policies within a provider contract. Captures term type (payment methodology, exclusivity, termination clause, audit rights, hold-harmless, indemnification, confidentiality, HIPAA BAA, reimbursement rule), term text, effective date, expiration date, and whether the term is negotiable or standard boilerplate. For reimbursement rule terms: captures policy sub-type (multiple procedure reduction, bilateral procedure, assistant surgeon, global surgery, unbundling rules, place-of-service differential), applicable CPT/HCPCS ranges, reduction percentage, and LOB applicability. Enables granular tracking of contractual obligations, compliance checkpoints, and reimbursement adjudication rules. Bridges contract terms to claims adjudication logic in Facets/QNXT.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`contract`.`contract_amendment` (
    `contract_amendment_id` BIGINT COMMENT 'Unique system-generated identifier for each provider contract amendment record. Primary key for the amendment entity.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Needed for Amendment Approval audit; ties each amendment to the employee who approved it, satisfying compliance tracking.',
    `provider_contract_id` BIGINT COMMENT 'Reference to the parent provider contract that this amendment modifies. Links the amendment to its originating contract record.',
    `fee_schedule_id` BIGINT COMMENT 'Reference to the fee schedule record activated or superseded by this amendment. Links the amendment to the specific rate table used for claims adjudication under the amended terms.',
    `regulatory_change_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_change. Business justification: Required: Amendments are often triggered by regulatory changes; linking tracks the change that caused the amendment.',
    `superseded_amendment_id` BIGINT COMMENT 'Reference to a prior amendment record that this amendment replaces or supersedes. Enables traversal of the full amendment history chain for a given contract. Null if this is the first amendment or does not supersede a prior amendment.',
    `vbc_arrangement_id` BIGINT COMMENT 'Reference to the associated Accountable Care Organization (ACO) agreement when this amendment relates to an ACO or Value-Based Care (VBC) arrangement. Nullable for non-ACO amendments.',
    `amendment_number` STRING COMMENT 'Externally-known, human-readable sequential identifier for the amendment (e.g., AMD-2024-001234-001). Used in correspondence, audit trails, and regulatory submissions. Unique within the parent contract.. Valid values are `^AMD-[0-9]{4}-[0-9]{6}-[0-9]{3}$`',
    `amendment_type` STRING COMMENT 'Categorical classification of the amendment indicating the nature of the modification. Drives downstream processing workflows and audit categorization. [ENUM-REF-CANDIDATE: rate_change|term_modification|lob_addition|network_tier_change|scope_change|termination|capitation_change|bundled_payment_change|vbc_modification|addendum — promote to reference product]. Valid values are `rate_change|term_modification|lob_addition|network_tier_change|scope_change|termination`',
    `approval_status` STRING COMMENT 'Current lifecycle state of the amendment through the negotiation and approval workflow. Tracks progression from draft through execution or withdrawal.. Valid values are `draft|pending_review|approved|rejected|executed|withdrawn`',
    `approved_date` DATE COMMENT 'The date on which the amendment received final internal approval from all required approvers. Distinct from execution date which reflects provider countersignature.',
    `capitation_rate_pmpm` DECIMAL(18,2) COMMENT 'The Per Member Per Month (PMPM) capitation rate established or modified by this amendment for capitation-based payment arrangements. Applicable when payment_methodology is capitation. Confidential commercial negotiation data.',
    `claims_reprocess_required` BOOLEAN COMMENT 'Indicates whether claims adjudicated under prior contract terms must be reprocessed following execution of this amendment. Triggers downstream claims reprocessing workflows in Facets/QNXT.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when the amendment record was first created in the contract management system. Supports audit trail and data lineage requirements.',
    `data_quality_score` STRING COMMENT 'Computed data-quality score for ECM scoring.',
    `document_reference` STRING COMMENT 'Reference identifier or URL to the executed amendment document stored in the contract management document repository (e.g., SharePoint, Cactus/ProviderSource document store). Enables direct access to the legal document.',
    `effective_date` DATE COMMENT 'The date on which the terms of this amendment become contractually binding and operationally effective. Used for rate table activation, benefit configuration updates, and claims adjudication rule changes.',
    `effective_end_date` DATE COMMENT 'Effective end of the record validity window.',
    `effective_start_date` DATE COMMENT 'Effective start of the record validity window.',
    `execution_date` DATE COMMENT 'The date on which all required parties formally signed and executed the amendment document. May differ from the effective date for retroactive or prospective amendments.',
    `expiration_date` DATE COMMENT 'The date on which the amendment terms cease to be effective. Nullable for permanent amendments with no defined end date. Used to manage time-limited rate changes or temporary term modifications.',
    `fhir_last_updated` TIMESTAMP COMMENT 'FHIR meta.lastUpdated for resource versioning',
    `fhir_profile_url` STRING COMMENT 'Canonical FHIR/US Core profile URL this record conforms to',
    `fhir_resource_reference` STRING COMMENT 'Stable FHIR logical resource id for interop exchange',
    `fhir_resource_type` STRING COMMENT 'FHIR resource type this record maps to for interoperability (default: Basic)',
    `fhir_version_code` STRING COMMENT 'FHIR meta.versionId optimistic concurrency token',
    `formulary_impact_flag` BOOLEAN COMMENT 'Indicates whether this amendment affects pharmacy formulary terms, drug reimbursement rates, or Pharmacy Benefit Management (PBM) arrangements. Triggers updates to the PBM system (RxClaim/Argus).',
    `initiating_party` STRING COMMENT 'Identifies which party initiated the amendment request — the health plan, the provider, a regulatory mandate, or a mutual agreement. Used for negotiation analytics and contract management reporting.. Valid values are `health_plan|provider|regulatory|mutual`',
    `internal_notes` STRING COMMENT 'Free-text field for internal health plan staff notes regarding the amendment, including strategic context, escalation history, or implementation considerations. Confidential internal business information not shared with providers.',
    `is_active` BOOLEAN COMMENT 'Logical active flag for soft-delete and current-state filtering.',
    `lob_code` STRING COMMENT 'Identifies the Line of Business (LOB) affected by this amendment (e.g., Commercial, Medicare Advantage, Medicaid, CHIP, Exchange/QHP). Critical for segregating contractual terms by regulatory program.',
    `master_entity_reference` STRING COMMENT 'Cross-domain master/golden entity key for SSOT resolution.',
    `negotiation_notes` STRING COMMENT 'Free-text narrative capturing key negotiation points, concessions, and outcomes during the amendment negotiation process. Confidential commercial information used for internal reference and future renegotiation strategy.',
    `negotiation_outcome` STRING COMMENT 'The result of the contract negotiation process leading to this amendment. Indicates whether terms were mutually agreed, required counter-proposals, or were resolved through arbitration or mediation. Confidential commercial negotiation data.. Valid values are `agreed|counter_proposed|arbitrated|mediated|withdrawn`',
    `network_tier` STRING COMMENT 'The provider network tier designation established or modified by this amendment (e.g., Tier 1 preferred, Tier 2 standard, Tier 3 specialty). Affects member cost-sharing and provider reimbursement rates.. Valid values are `tier_1|tier_2|tier_3|out_of_network`',
    `payment_methodology` STRING COMMENT 'The reimbursement methodology established or modified by this amendment. Determines how providers are compensated under the amended contract terms. Aligns with Value-Based Care (VBC), Reference Based Pricing (RBP), capitation, or Fee-For-Service (FFS) models. [ENUM-REF-CANDIDATE: fee_for_service|capitation|bundled_payment|per_diem|case_rate|vbc|rbp — 7 candidates stripped; promote to reference product]',
    `plan_signatory_name` STRING COMMENT 'Name of the authorized representative of the health plan who executed the amendment on behalf of the health plan. Required for legal enforceability of the amendment.',
    `prior_auth_impact_flag` BOOLEAN COMMENT 'Indicates whether this amendment modifies Prior Authorization (PA) requirements for services rendered by the provider. Triggers updates to Utilization Management (UM) system configurations in InterQual/MCG.',
    `provider_signatory_name` STRING COMMENT 'Name of the authorized representative of the provider organization who executed the amendment on behalf of the provider. Required for legal enforceability of the amendment.',
    `rate_change_pct` DECIMAL(18,2) COMMENT 'The percentage increase or decrease in reimbursement rates resulting from this amendment. Expressed as a signed decimal (positive for increases, negative for decreases). Applicable when amendment_type is rate_change. Confidential commercial negotiation data.',
    `rate_effective_date` DATE COMMENT 'The specific date on which revised reimbursement rates established by this amendment take effect in the claims adjudication system. May differ from the overall amendment effective date for phased implementations.',
    `reason` STRING COMMENT 'Narrative explanation of the business rationale or triggering event for the amendment (e.g., annual rate renegotiation, regulatory mandate, network expansion, provider request). Supports audit and compliance documentation.',
    `record_created_at` TIMESTAMP COMMENT 'Timestamp the record was created (audit lineage).',
    `record_source_system` STRING COMMENT 'System of record / source system that produced this record (SSOT provenance).',
    `record_status` STRING COMMENT 'Standard ECM audit/governance attribute record_status.',
    `record_updated_at` TIMESTAMP COMMENT 'Timestamp the record was last updated (audit lineage).',
    `record_version` STRING COMMENT 'Optimistic-concurrency / change version of the record.',
    `regulatory_mandate_flag` BOOLEAN COMMENT 'Indicates whether this amendment was required by a regulatory mandate (e.g., CMS rate update, state DOI directive, ACA compliance requirement). Drives prioritization and compliance reporting workflows.',
    `regulatory_reference` STRING COMMENT 'Citation of the specific regulation, CMS bulletin, state DOI directive, or legislative act that mandated or triggered this amendment (e.g., CMS-2024-MA-Rate-Update, ACA Section 1302). Populated when regulatory_mandate_flag is true.',
    `retroactive_flag` BOOLEAN COMMENT 'Indicates whether the amendment has a retroactive effective date that precedes the execution date. Retroactive amendments require claims reprocessing and financial reconciliation activities.',
    `retroactive_start_date` DATE COMMENT 'The earliest date from which retroactive amendment terms apply, when retroactive_flag is true. Defines the claims reprocessing window for financial reconciliation.',
    `risk_share_pct` DECIMAL(18,2) COMMENT 'The percentage of financial risk shared between the health plan and the provider under risk-sharing or Value-Based Care (VBC) arrangements established by this amendment. Confidential commercial negotiation data.',
    `sections_modified` STRING COMMENT 'Comma-delimited list or narrative description of the specific contract sections, exhibits, or schedules modified by this amendment (e.g., Exhibit A - Fee Schedule, Section 4.2 - Term). Supports targeted audit and compliance review.',
    `submitted_date` DATE COMMENT 'The date on which the amendment was formally submitted for internal review and approval. Marks the start of the amendment approval workflow.',
    `title` STRING COMMENT 'Short descriptive title summarizing the purpose of the amendment (e.g., 2024 Annual Rate Increase — Hospital Services). Used in contract management dashboards and correspondence.',
    `updated_timestamp` TIMESTAMP COMMENT 'The timestamp when the amendment record was most recently modified in the contract management system. Supports change tracking, audit trail, and incremental data pipeline processing.',
    `vbc_target_metric` STRING COMMENT 'The primary quality or cost performance metric targeted under a Value-Based Care (VBC) or Accountable Care Organization (ACO) arrangement established by this amendment (e.g., HEDIS measure, readmission rate, cost per episode). Applicable when payment_methodology is vbc.',
    `version_number` STRING COMMENT 'Sequential version counter tracking revisions to the amendment record during the drafting and negotiation process. Supports amendment history and audit trail requirements.',
    CONSTRAINT pk_contract_amendment PRIMARY KEY(`contract_amendment_id`)
) COMMENT 'SSOT contract amendment owner; plan.plan_amendment is the plan-design-specific subtype that FKs to amendment_id.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`contract`.`fee_schedule` (
    `fee_schedule_id` BIGINT COMMENT 'Unique surrogate identifier for the fee schedule record in the contract domain. Primary key for the fee_schedule data product.',
    `health_plan_id` BIGINT COMMENT 'Reference to the specific health plan or benefit plan to which this fee schedule is scoped. Enables plan-level fee schedule assignment in Facets/QNXT Benefits Configuration.',
    `ledger_id` BIGINT COMMENT 'Foreign key linking to finance.ledger. Business justification: Fee schedules generate revenue entries that must be posted to a designated ledger for accurate financial statements.',
    `provider_id` BIGINT COMMENT 'Reference to the provider or provider group for whom this fee schedule defines reimbursement rates. Sourced from the Provider Management System (Cactus/ProviderSource).',
    `provider_network_id` BIGINT COMMENT 'Reference to the provider network (e.g., HMO, PPO, EPO, POS) to which this fee schedule applies. Determines in-network vs. out-of-network reimbursement applicability.',
    `pool_id` BIGINT COMMENT 'Foreign key linking to risk.pool. Business justification: RATE_DEVELOPMENT: Fee schedules are applied within a specific risk pool; linking enables actuarial rate calculations and regulatory filings.',
    `superseded_by_fee_schedule_id` BIGINT COMMENT 'Reference to the fee_schedule_id of the newer fee schedule that replaced this one when schedule_status is superseded. Enables fee schedule version chain navigation and historical rate lookups.',
    `fee_provider_contract_id` BIGINT COMMENT 'FK to contract.provider_contract.provider_contract_id — Fee schedules must resolve to their governing provider contract for rate lookup during claim adjudication and contract compliance auditing.',
    `provider_contract_id` BIGINT COMMENT 'Reference to the provider contract under which this fee schedule is established. Links the fee schedule to its governing contractual agreement.',
    `amendment_number` STRING COMMENT 'Identifier for the contract amendment that introduced or modified this fee schedule version. Null for the original fee schedule. Enables traceability between fee schedule versions and contract amendments.. Valid values are `^[A-Z0-9-]{1,20}$`',
    `anesthesia_applicable` BOOLEAN COMMENT 'Indicates whether this fee schedule includes anesthesia service reimbursement, which uses base units plus time units multiplied by a conversion factor rather than standard CPT-based rates.',
    `anesthesia_conversion_factor` DECIMAL(18,2) COMMENT 'Dollar amount per anesthesia unit (base units + time units) used to calculate anesthesia reimbursement when anesthesia_applicable is True. Negotiated rate specific to this fee schedule.',
    `approval_date` DATE COMMENT 'Date on which the fee schedule was formally approved by the authorized contracting officer or governance body. Required for audit and regulatory compliance.',
    `cms_fee_schedule_year` STRING COMMENT 'The CMS Medicare fee schedule calendar year used as the basis or benchmark for this fee schedule when fee_schedule_source is cms_medicare. Enables tracking of which CMS annual update cycle the rates are derived from.',
    `conversion_factor` DECIMAL(18,2) COMMENT 'Dollar amount multiplied by the total Relative Value Units (RVUs) to calculate the reimbursement amount for RVU-based fee schedules. Applicable when payment_basis is rvu_based. Sourced from CMS RBRVS conversion factor or negotiated contract rate.',
    `coordination_of_benefits_applicable` BOOLEAN COMMENT 'Indicates whether Coordination of Benefits (COB) rules apply to claims adjudicated under this fee schedule. When True, COB logic determines primary vs. secondary payer responsibilities.',
    `cpt_code_range_end` STRING COMMENT 'Ending CPT procedure code in the range of services covered by this fee schedule. Used in conjunction with cpt_code_range_start to define the scope of applicable procedure codes.. Valid values are `^[0-9]{5}$`',
    `cpt_code_range_start` STRING COMMENT 'Starting CPT procedure code in the range of services covered by this fee schedule. Used in conjunction with cpt_code_range_end to define the scope of applicable procedure codes. Null if the fee schedule applies to all CPT codes or uses ICD/DRG-based scoping.. Valid values are `^[0-9]{5}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this fee schedule record was first created in the system. Audit field capturing the initial record creation event in the Databricks Silver Layer.',
    `data_quality_score` STRING COMMENT 'Computed data-quality score for ECM scoring.',
    `fee_schedule_description` STRING COMMENT 'Free-text narrative description of the fee schedule, including its purpose, scope, special provisions, or notes relevant to adjudication staff and contract analysts.',
    `drg_applicable` BOOLEAN COMMENT 'Indicates whether this fee schedule uses Diagnosis Related Group (DRG)-based reimbursement for inpatient facility claims. When True, DRG weights and base rates govern payment rather than individual procedure codes.',
    `drg_base_rate` DECIMAL(18,2) COMMENT 'The negotiated base dollar rate per DRG weight unit used for inpatient facility reimbursement when drg_applicable is True. Multiplied by the DRG relative weight to calculate the total inpatient payment.',
    `effective_date` DATE COMMENT 'Date on which the fee schedule becomes effective and applicable for claim adjudication and reimbursement calculations. Inclusive start date of the fee schedule validity period.',
    `effective_end_date` DATE COMMENT 'Effective end of the record validity window.',
    `effective_start_date` DATE COMMENT 'Effective start of the record validity window.',
    `fhir_last_updated` TIMESTAMP COMMENT 'FHIR meta.lastUpdated for resource versioning',
    `fhir_profile_url` STRING COMMENT 'Canonical FHIR/US Core profile URL this record conforms to',
    `fhir_resource_reference` STRING COMMENT 'Stable FHIR logical resource id for interop exchange',
    `fhir_resource_type` STRING COMMENT 'FHIR resource type this record maps to for interoperability (default: Basic)',
    `fhir_version_code` STRING COMMENT 'FHIR meta.versionId optimistic concurrency token',
    `geographic_modifier_applicable` BOOLEAN COMMENT 'Indicates whether geographic adjustment factors (e.g., CMS Geographic Practice Cost Indices - GPCI) are applied to rates under this fee schedule. True when locality-based adjustments are in effect; False for flat national rates.',
    `global_surgery_applicable` BOOLEAN COMMENT 'Indicates whether global surgery payment rules apply under this fee schedule, bundling pre-operative, intra-operative, and post-operative services into a single reimbursement amount.',
    `is_active` BOOLEAN COMMENT 'Logical active flag for soft-delete and current-state filtering.',
    `lob_code` STRING COMMENT 'Identifies the Line of Business (LOB) to which this fee schedule applies (e.g., commercial, Medicare Advantage, Medicaid, ACA Marketplace, COBRA, FEHB). Determines which member populations and plan types are subject to this fee schedule during adjudication.. Valid values are `commercial|medicare_advantage|medicaid|marketplace|cobra|fehb`',
    `locality_code` STRING COMMENT 'CMS Medicare locality code identifying the geographic pricing area applicable to this fee schedule when geographic_modifier_applicable is True. Used to apply GPCI adjustments to RVU-based rates.. Valid values are `^[0-9]{2}$`',
    `master_entity_reference` STRING COMMENT 'Cross-domain master/golden entity key for SSOT resolution.',
    `medicare_crossover_applicable` BOOLEAN COMMENT 'Indicates whether this fee schedule applies to Medicare crossover claims where Medicare is the primary payer and the health plan is the secondary payer. Relevant for Medicare Advantage and Medigap plans.',
    `modifier_applicable` BOOLEAN COMMENT 'Indicates whether CPT or HCPCS modifiers affect reimbursement rates under this fee schedule (e.g., modifier 26 for professional component, modifier TC for technical component, modifier 50 for bilateral procedures).',
    `outlier_threshold_amt` DECIMAL(18,2) COMMENT 'Dollar threshold above which a claim qualifies as a cost outlier, triggering additional reimbursement beyond the standard DRG or bundled payment. Applicable for institutional fee schedules with outlier payment provisions.',
    `payment_basis` STRING COMMENT 'The methodology used to calculate reimbursement amounts under this fee schedule. Options include: pct_medicare (percentage of Medicare allowable), pct_billed_charges (percentage of provider billed charges), flat_rate (fixed dollar amount per service), rvu_based (Relative Value Unit-based), bundled (bundled payment for episode of care), capitation (per-member per-month), rbp (Reference Based Pricing). [ENUM-REF-CANDIDATE: pct_medicare|pct_billed_charges|flat_rate|rvu_based|bundled|capitation|rbp — promote to reference product]',
    `payment_basis_pct` DECIMAL(18,2) COMMENT 'The percentage rate applied when payment_basis is pct_medicare or pct_billed_charges (e.g., 110.0000 for 110% of Medicare). Null when payment_basis is flat_rate, rvu_based, bundled, or capitation. Stored as a decimal percentage value.',
    `prior_authorization_required` BOOLEAN COMMENT 'Indicates whether Prior Authorization (PA) is required for services reimbursed under this fee schedule. When True, claims must have an approved PA on file before adjudication at the scheduled rates.',
    `record_created_at` TIMESTAMP COMMENT 'Timestamp the record was created (audit lineage).',
    `record_source_system` STRING COMMENT 'System of record / source system that produced this record (SSOT provenance).',
    `record_status` STRING COMMENT 'Standard ECM audit/governance attribute record_status.',
    `record_updated_at` TIMESTAMP COMMENT 'Timestamp the record was last updated (audit lineage).',
    `record_version` STRING COMMENT 'Optimistic-concurrency / change version of the record.',
    `referral_required` BOOLEAN COMMENT 'Indicates whether a primary care physician (PCP) referral is required for services covered under this fee schedule. Applicable primarily for HMO and POS plan types.',
    `schedule_code` STRING COMMENT 'Externally-known alphanumeric code uniquely identifying the fee schedule within the Core Administration Platform (Facets/QNXT). Used in EDI transactions and cross-system references.. Valid values are `^[A-Z0-9_-]{2,30}$`',
    `schedule_name` STRING COMMENT 'Human-readable name identifying the fee schedule (e.g., Commercial PPO Professional 2024, Medicare Advantage Institutional Q1 2024). Used for display and reporting in Facets/QNXT Benefits Configuration.',
    `schedule_status` STRING COMMENT 'Current lifecycle state of the fee schedule. draft indicates under review; active indicates currently in use for adjudication; suspended indicates temporarily inactive; terminated indicates permanently closed; superseded indicates replaced by a newer version.. Valid values are `draft|active|suspended|terminated|superseded`',
    `schedule_type` STRING COMMENT 'Categorizes the fee schedule by the type of services covered: professional (physician/practitioner), institutional (hospital/facility), ancillary (therapy/home health), DME (Durable Medical Equipment), lab (laboratory), or pharmacy. Drives claim adjudication logic in Facets/QNXT.. Valid values are `professional|institutional|ancillary|dme|lab|pharmacy`',
    `service_category` STRING COMMENT 'Broad clinical or administrative category of services covered by this fee schedule (e.g., Evaluation and Management, Surgery, Radiology, Pathology, Inpatient Facility, Outpatient Facility, Home Health, Behavioral Health). Supports fee schedule segmentation and reporting. [ENUM-REF-CANDIDATE: evaluation_management|surgery|radiology|pathology|inpatient_facility|outpatient_facility|home_health|behavioral_health|physical_therapy|dme — promote to reference product]',
    `source` STRING COMMENT 'Identifies the origin or benchmark source of the fee schedule rates: cms_medicare (based on CMS Medicare fee schedule), cms_medicaid (based on state Medicaid fee schedule), negotiated (directly negotiated with provider), custom (health plan proprietary rates), rbp_benchmark (Reference Based Pricing benchmark).. Valid values are `cms_medicare|cms_medicaid|negotiated|custom|rbp_benchmark`',
    `state_code` STRING COMMENT 'Two-letter US state code indicating the geographic scope of this fee schedule. Used for state-specific rate variations and regulatory compliance with State Departments of Insurance (DOI) requirements.. Valid values are `^[A-Z]{2}$`',
    `stop_loss_applicable` BOOLEAN COMMENT 'Indicates whether a stop-loss provision applies to this fee schedule, capping the health plans reimbursement liability per claim or per member. Relevant for risk-sharing and capitation arrangements.',
    `stop_loss_threshold_amt` DECIMAL(18,2) COMMENT 'Dollar amount per claim or per member above which the stop-loss provision activates, limiting the health plans reimbursement exposure. Applicable when stop_loss_applicable is True.',
    `termination_date` DATE COMMENT 'Date on which the fee schedule expires and is no longer applicable for claim adjudication. Null indicates an open-ended fee schedule with no defined end date.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this fee schedule record was last modified. Audit field supporting change tracking, data lineage, and regulatory audit requirements.',
    `version_number` STRING COMMENT 'Version identifier for the fee schedule, enabling tracking of amendments and updates over time (e.g., 1.0, 2.1, 3.0). Incremented when rates or terms are modified. Supports fee schedule history and audit trail.. Valid values are `^[0-9]+.[0-9]+(.[0-9]+)?$`',
    CONSTRAINT pk_fee_schedule PRIMARY KEY(`fee_schedule_id`)
) COMMENT 'Master fee schedule defining reimbursement rates for covered services under a provider contract. Captures fee schedule name, version, effective and termination dates, payment basis (% of Medicare, % of billed charges, flat rate, RVU-based), geographic modifier applicability, LOB scope, and fee schedule type (professional, institutional, ancillary, DME, lab). SSOT for all fee-for-service reimbursement rates. Sourced from Facets/QNXT Benefits Configuration.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`contract`.`fee_schedule_rate` (
    `fee_schedule_rate_id` BIGINT COMMENT 'Unique surrogate identifier for each fee schedule rate line record in the contract domain. Primary key for this entity.',
    `provider_contract_id` BIGINT COMMENT 'Reference to the provider contract under which this fee schedule rate is established. Links the rate line to the governing contractual agreement.',
    `fee_schedule_id` BIGINT COMMENT 'Reference to the parent fee schedule header that this rate line belongs to. Links the rate to its governing fee schedule agreement.',
    `prior_rate_fee_schedule_rate_id` BIGINT COMMENT 'Self-referencing identifier pointing to the previous version of this rate record that was superseded by the current record. Enables full rate history chain traversal for audit and compliance purposes.',
    `allowed_amount` DECIMAL(18,2) COMMENT 'The contracted allowed amount or maximum reimbursable dollar amount for the specified procedure code, modifier, and place of service combination. This is the principal monetary value used by adjudication systems to price claims against contracted rates. Expressed in USD.',
    `awp_percent` DECIMAL(18,2) COMMENT 'When rate_derivation_method is AWP_PCT, this field stores the percentage of the Average Wholesale Price (AWP) used to derive the drug or supply reimbursement rate. For example, 0.8500 represents AWP minus 15%. Commonly used in pharmacy and DME fee schedules.',
    `bilateral_indicator` BOOLEAN COMMENT 'Indicates whether this rate applies to a bilateral procedure (performed on both sides of the body). When true, the allowed amount may be adjusted per CMS bilateral surgery payment rules (150% of the unilateral rate).',
    `bundled_payment_amount` DECIMAL(18,2) COMMENT 'Single episode-of-care payment amount covering all services within a defined clinical episode (e.g., joint replacement, maternity). Applicable when payment_methodology is BUNDLED. Supports Value-Based Care (VBC) and ACO payment models.',
    `capitation_rate_pmpm` DECIMAL(18,2) COMMENT 'Fixed monthly payment per enrolled member paid to a provider under a capitation arrangement, regardless of services rendered. Expressed as a Per Member Per Month (PMPM) dollar amount. Applicable only when payment_methodology is CAPITATION.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this fee schedule rate record was first created in the system. Used for audit trail, data lineage, and compliance reporting. Conforms to ISO 8601 format (yyyy-MM-ddTHH:mm:ss.SSSXXX).',
    `data_quality_score` STRING COMMENT 'Computed data-quality score for ECM scoring.',
    `drg_code` STRING COMMENT 'CMS Diagnosis Related Group code used for inpatient hospital reimbursement. When the payment methodology is DRG-based, this code identifies the patient classification group that determines the base payment rate.. Valid values are `^[0-9]{3}$`',
    `effective_date` DATE COMMENT 'The date on which this fee schedule rate becomes effective and applicable for claims adjudication. Claims with service dates on or after this date and before the termination_date will be priced using this rate.',
    `effective_end_date` DATE COMMENT 'Effective end of the record validity window.',
    `effective_start_date` DATE COMMENT 'Effective start of the record validity window.',
    `fhir_last_updated` TIMESTAMP COMMENT 'FHIR meta.lastUpdated for resource versioning',
    `fhir_profile_url` STRING COMMENT 'Canonical FHIR/US Core profile URL this record conforms to',
    `fhir_resource_reference` STRING COMMENT 'Stable FHIR logical resource id for interop exchange',
    `fhir_resource_type` STRING COMMENT 'FHIR resource type this record maps to for interoperability (default: InsurancePlan.plan.specificCost)',
    `fhir_version_code` STRING COMMENT 'FHIR meta.versionId optimistic concurrency token',
    `geographic_region` STRING COMMENT 'Geographic region or market area to which this rate applies. Rates may vary by state, CMS locality, metropolitan statistical area (MSA), or health plan-defined region. Expressed as a state code, CMS locality code, or internal region identifier.',
    `global_surgery_days` STRING COMMENT 'Number of days in the global surgery period for surgical procedure codes. Defines the pre-operative and post-operative period during which related services are bundled into the surgical payment (0=endoscopic/minor, 10=minor, 90=major surgery).',
    `is_active` BOOLEAN COMMENT 'Logical active flag for soft-delete and current-state filtering.',
    `line_of_business` STRING COMMENT 'The Line of Business (LOB) to which this fee schedule rate applies. Rates are often differentiated by LOB as Medicare, Medicaid, and commercial plans have distinct reimbursement structures and regulatory requirements.. Valid values are `COMMERCIAL|MEDICARE|MEDICAID|MARKETPLACE|CHIP|TRICARE`',
    `mac_amount` DECIMAL(18,2) COMMENT 'The Maximum Allowable Cost (MAC) dollar amount set as the ceiling for reimbursement of a specific drug or service. When rate_derivation_method is MAC, this value represents the maximum the plan will pay regardless of billed charges.',
    `master_entity_reference` STRING COMMENT 'Cross-domain master/golden entity key for SSOT resolution.',
    `max_units_per_day` STRING COMMENT 'Maximum number of units of this procedure code that will be reimbursed per day per member. Used to enforce utilization limits during claims adjudication and prevent overbilling.',
    `max_units_per_year` STRING COMMENT 'Maximum number of units of this procedure code that will be reimbursed per benefit year per member. Enforces annual utilization limits during adjudication for services with frequency restrictions.',
    `medicare_fee_schedule_pct` DECIMAL(18,2) COMMENT 'When rate_derivation_method is MEDICARE_PCT, this field stores the percentage of the applicable Medicare fee schedule rate used to derive the allowed amount. For example, 1.1500 represents 115% of Medicare. Used for rate benchmarking and contract analytics.',
    `ncci_edit_indicator` BOOLEAN COMMENT 'Indicates whether this procedure code is subject to National Correct Coding Initiative (NCCI) bundling edits during claims adjudication. When true, the adjudication system will apply NCCI column 1/column 2 and mutually exclusive code edits.',
    `network_tier` STRING COMMENT 'Identifies the provider network tier to which this rate applies. Rates differ by network participation level: IN_NETWORK (contracted), OUT_OF_NETWORK (non-contracted), or tiered preferred network levels (TIER_1, TIER_2, TIER_3, PREFERRED). Drives member cost-sharing calculations.. Valid values are `IN_NETWORK|OUT_OF_NETWORK|TIER_1|TIER_2|TIER_3|PREFERRED`',
    `payment_methodology` STRING COMMENT 'The reimbursement methodology governing how the provider is paid for this service. FFS=Fee-for-Service (fixed allowed amount per procedure), CAPITATION=fixed PMPM regardless of utilization, BUNDLED=single payment for episode of care, DRG=Diagnosis Related Group inpatient payment, PER_DIEM=daily rate for facility stays, PERCENT_OF_BILLED=percentage of submitted charges, RBP=Reference Based Pricing, CASE_RATE=flat rate per case. [ENUM-REF-CANDIDATE: FFS|CAPITATION|BUNDLED|DRG|PER_DIEM|PERCENT_OF_BILLED|RBP|CASE_RATE — promote to reference product]',
    `per_diem_rate` DECIMAL(18,2) COMMENT 'Daily reimbursement rate paid to a facility provider for each day of an inpatient or residential stay. Applicable when payment_methodology is PER_DIEM. May vary by level of care (e.g., ICU vs. medical/surgical).',
    `place_of_service_code` STRING COMMENT 'CMS two-digit place of service code indicating the setting where the service was rendered (e.g., 11=Office, 21=Inpatient Hospital, 22=Outpatient Hospital, 23=Emergency Room). Rates may vary by place of service.. Valid values are `^[0-9]{2}$`',
    `procedure_code` STRING COMMENT 'The CPT or HCPCS procedure code identifying the specific medical service, procedure, or supply for which this rate applies. Core identifier used in claims adjudication to match services to contracted rates.. Valid values are `^[A-Z0-9]{4,7}$`',
    `procedure_code_type` STRING COMMENT 'Classifies the coding system used for the procedure_code field. Distinguishes between CPT (physician services), HCPCS Level II (supplies/DME), CDT (dental), ICD-10-PCS (inpatient procedures), Revenue Code (facility billing), DRG (diagnosis-related group), APC (ambulatory payment classification), or NDC (drug). [ENUM-REF-CANDIDATE: CPT|HCPCS_II|CDT|ICD_PCS|REVENUE|DRG|APC|NDC — promote to reference product]',
    `procedure_modifier_1` STRING COMMENT 'First CPT or HCPCS modifier code appended to the procedure code to indicate special circumstances affecting the service (e.g., bilateral procedure, assistant surgeon, professional component). Modifiers can alter the allowed reimbursement amount.. Valid values are `^[A-Z0-9]{2}$`',
    `procedure_modifier_2` STRING COMMENT 'Second CPT or HCPCS modifier code when multiple modifiers apply to the same procedure code. Used in conjunction with procedure_modifier_1 for complex billing scenarios.. Valid values are `^[A-Z0-9]{2}$`',
    `product_type` STRING COMMENT 'The health plan product type to which this rate applies. HMO=Health Maintenance Organization, PPO=Preferred Provider Organization, EPO=Exclusive Provider Organization, POS=Point of Service, HDHP=High Deductible Health Plan, INDEMNITY=traditional indemnity plan. Rates may vary by product type.. Valid values are `HMO|PPO|EPO|POS|HDHP|INDEMNITY`',
    `provider_type` STRING COMMENT 'Classification of the provider type to which this rate applies. Distinguishes between physician/professional services, facility (hospital/SNF), ancillary services, Durable Medical Equipment (DME) suppliers, pharmacy, and behavioral health providers.. Valid values are `PHYSICIAN|FACILITY|ANCILLARY|DME|PHARMACY|BEHAVIORAL_HEALTH`',
    `rate_derivation_method` STRING COMMENT 'Describes how the allowed amount was derived or calculated. MEDICARE_PCT=percentage of Medicare fee schedule, AWP_PCT=percentage of Average Wholesale Price, WAC_PCT=percentage of Wholesale Acquisition Cost, MAC=Maximum Allowable Cost, RBP=Reference Based Pricing benchmark, NEGOTIATED=directly negotiated flat rate, COST_PLUS=cost plus margin, BILLED_PCT=percent of billed charges. Critical for audit and rate validation. [ENUM-REF-CANDIDATE: MEDICARE_PCT|AWP_PCT|WAC_PCT|MAC|RBP|NEGOTIATED|COST_PLUS|BILLED_PCT — promote to reference product]',
    `rate_line_number` STRING COMMENT 'Sequential line number identifying the position of this rate record within the parent fee schedule. Used for ordering and referencing individual rate lines.',
    `rate_note` STRING COMMENT 'Free-text notes or comments providing additional context about this fee schedule rate, such as special billing instructions, exceptions, or conditions under which the rate applies. Used by contracting and claims operations staff.',
    `rate_percent_of_billed` DECIMAL(18,2) COMMENT 'Reimbursement rate expressed as a percentage of the providers billed charges, used when the payment methodology is percent-of-billed rather than a fixed allowed amount. For example, 0.8500 represents 85% of billed charges.',
    `rate_source` STRING COMMENT 'Identifies the origin or source of this fee schedule rate. CONTRACT=directly negotiated in provider contract, CMS_PUBLISHED=derived from published CMS fee schedule, CROSSWALK=mapped from another code or schedule, MANUAL=manually entered by contracting staff, SYSTEM_GENERATED=automatically generated by the fee schedule management system.. Valid values are `CONTRACT|CMS_PUBLISHED|CROSSWALK|MANUAL|SYSTEM_GENERATED`',
    `rate_status` STRING COMMENT 'Current lifecycle status of this fee schedule rate record. ACTIVE=currently in effect and used for adjudication, INACTIVE=not currently in use, PENDING=approved but not yet effective, SUPERSEDED=replaced by a newer rate version, TERMINATED=permanently ended.. Valid values are `ACTIVE|INACTIVE|PENDING|SUPERSEDED|TERMINATED`',
    `rate_version` STRING COMMENT 'Incrementing version number tracking amendments and updates to this fee schedule rate line. Version 1 is the original rate; subsequent amendments increment this counter. Supports rate history and audit trail requirements.',
    `rbp_reference_amount` DECIMAL(18,2) COMMENT 'The benchmark dollar amount used as the basis for Reference Based Pricing (RBP) reimbursement. Typically anchored to Medicare rates or a cost-based benchmark. The actual allowed amount is derived as a percentage of this reference amount.',
    `record_created_at` TIMESTAMP COMMENT 'Timestamp the record was created (audit lineage).',
    `record_source_system` STRING COMMENT 'System of record / source system that produced this record (SSOT provenance).',
    `record_status` STRING COMMENT 'Standard ECM audit/governance attribute record_status.',
    `record_updated_at` TIMESTAMP COMMENT 'Timestamp the record was last updated (audit lineage).',
    `record_version` STRING COMMENT 'Optimistic-concurrency / change version of the record.',
    `revenue_code` STRING COMMENT 'Four-digit UB-04 revenue code identifying the type of accommodation, ancillary service, or billing classification for facility claims. Used in conjunction with or as an alternative to procedure codes for hospital and facility fee schedule rates.. Valid values are `^[0-9]{4}$`',
    `service_category` STRING COMMENT 'Broad clinical or administrative category grouping the service type covered by this rate (e.g., Evaluation and Management, Surgery, Radiology, Laboratory, Anesthesia, Durable Medical Equipment, Behavioral Health, Preventive Care). Used for rate analytics and reporting. [ENUM-REF-CANDIDATE: promote to reference product]',
    `specialty_code` STRING COMMENT 'CMS three-digit provider specialty code indicating the clinical specialty for which this rate applies. Rates may be differentiated by provider specialty (e.g., 01=General Practice, 06=Cardiology, 93=Emergency Medicine). Null if rate applies to all specialties.. Valid values are `^[0-9]{3}$`',
    `state_code` STRING COMMENT 'Two-letter US state code identifying the state jurisdiction in which this fee schedule rate is applicable. Used for state-specific rate differentiation and regulatory compliance reporting.. Valid values are `^[A-Z]{2}$`',
    `termination_date` DATE COMMENT 'The date on which this fee schedule rate expires and is no longer applicable for claims adjudication. Null indicates the rate is open-ended with no defined end date. Claims with service dates after this date will not be priced using this rate.',
    `units_of_service` DECIMAL(18,2) COMMENT 'The number of units of service to which the allowed_amount applies. For most procedure codes, this is 1 unit. For time-based codes or quantity-based services, this may represent the standard unit quantity (e.g., 15-minute increments for therapy codes).',
    `updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this fee schedule rate record was last modified. Tracks the most recent update for change management, audit trail, and data synchronization purposes. Conforms to ISO 8601 format (yyyy-MM-ddTHH:mm:ss.SSSXXX).',
    CONSTRAINT pk_fee_schedule_rate PRIMARY KEY(`fee_schedule_rate_id`)
) COMMENT 'Line-level reimbursement rates within a fee schedule. Each record defines the allowed amount or rate for a specific procedure code (CPT/HCPCS), revenue code, DRG, or service category. Captures procedure code, modifier, place of service, allowed amount, MAC/AWP/WAC reference, RBP rate, effective date, and rate derivation method. Enables adjudication systems to price claims against contracted rates.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`contract`.`capitation_arrangement` (
    `capitation_arrangement_id` BIGINT COMMENT 'Unique surrogate identifier for the capitation arrangement record in the Silver Layer lakehouse. Primary key for this entity.',
    `provider_contract_id` BIGINT COMMENT 'Reference to the parent provider contract under which this capitation arrangement is established. Links to the contract master record.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Capitation arrangements are budgeted and tracked via a cost center to manage per‑member‑per‑month payments and related expenses.',
    `health_plan_id` BIGINT COMMENT 'Reference to the health plan or benefit plan product associated with this capitation arrangement. Determines the member population eligible for attribution.',
    `provider_id` BIGINT COMMENT 'Reference to the capitated provider or provider group receiving the Per Member Per Month (PMPM) payment under this arrangement.',
    `pool_id` BIGINT COMMENT 'Foreign key linking to risk.pool. Business justification: CAPITATION_PAYMENT: Each capitation arrangement draws funding from a designated risk pool for compliance and financial reporting.',
    `aco_arrangement_flag` BOOLEAN COMMENT 'Indicates whether this capitation arrangement is part of an Accountable Care Organization (ACO) or integrated delivery network model, which may have additional shared savings or risk-sharing components.',
    `aggregate_stop_loss_threshold` DECIMAL(18,2) COMMENT 'Total dollar amount for the attributed member population above which the health plan assumes financial responsibility for claims costs. Protects the provider from population-level adverse risk. Expressed in USD.',
    `amendment_number` STRING COMMENT 'Identifier of the most recent contract amendment that modified this capitation arrangement. Tracks the amendment history for audit and compliance purposes.',
    `annual_rate_escalator` DECIMAL(18,2) COMMENT 'Contractually agreed annual percentage increase applied to the PMPM rate at each rate renewal period (e.g., 3.50 for 3.5% annual escalation). Used for multi-year capitation arrangements.',
    `approval_date` DATE COMMENT 'Date on which the capitation arrangement was formally approved by the health plans contracting authority. Required for audit trail and regulatory compliance documentation.',
    `approved_by` STRING COMMENT 'Name or employee identifier of the contracting authority who approved this capitation arrangement. Supports audit trail and delegation-of-authority compliance.',
    `arrangement_name` STRING COMMENT 'Human-readable descriptive name for the capitation arrangement (e.g., Primary Care Capitation - HMO Commercial 2024), used in reporting and provider communications.',
    `arrangement_number` STRING COMMENT 'Externally-known business identifier for the capitation arrangement, used in provider communications, payment remittances, and reconciliation processes. Assigned by the Core Administration Platform (Facets/QNXT).. Valid values are `^CAP-[A-Z0-9]{4,20}$`',
    `arrangement_status` STRING COMMENT 'Current lifecycle status of the capitation arrangement. Controls whether PMPM payments are generated and whether members can be attributed to this arrangement.. Valid values are `draft|pending_approval|active|suspended|terminated|expired`',
    `arrangement_type` STRING COMMENT 'Classification of the capitation arrangement by scope of covered services. Global capitation covers all services; primary care capitation covers PCP services only; specialty capitation covers specialist services; institutional covers facility-based care. [ENUM-REF-CANDIDATE: global_capitation|primary_care_capitation|specialty_capitation|institutional_capitation|behavioral_health_capitation|pharmacy_capitation — promote to reference product]. Valid values are `global_capitation|primary_care_capitation|specialty_capitation|institutional_capitation|behavioral_health_capitation|pharmacy_capitation`',
    `attributed_member_count` STRING COMMENT 'Current number of members attributed to this capitation arrangement for the active payment period. Used to calculate total monthly capitation payment disbursement.',
    `attribution_method` STRING COMMENT 'Methodology used to attribute members to this capitation arrangement. PCP assignment uses enrollment data; claims-based uses plurality of visits; voluntary selection allows member choice; geographic assigns by service area.. Valid values are `pcp_assignment|claims_based|voluntary_selection|geographic|hybrid`',
    `auto_renewal_flag` BOOLEAN COMMENT 'Indicates whether this capitation arrangement automatically renews at the end of the contract term unless either party provides notice of termination within the contractually specified notice period.',
    `carve_out_services` STRING COMMENT 'Description of services explicitly excluded from the capitation scope and reimbursed separately (e.g., Mental Health, Substance Abuse, Transplants, Neonatal ICU). Carve-outs are paid fee-for-service or under separate capitation arrangements.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this capitation arrangement record was first created in the data platform. Supports audit trail, data lineage, and regulatory compliance requirements.',
    `data_quality_score` STRING COMMENT 'Computed data-quality score for ECM scoring.',
    `effective_date` DATE COMMENT 'Date on which the capitation arrangement becomes binding and PMPM payments begin. Aligns with the contract effective period.',
    `effective_end_date` DATE COMMENT 'Effective end of the record validity window.',
    `effective_start_date` DATE COMMENT 'Effective start of the record validity window.',
    `fhir_last_updated` TIMESTAMP COMMENT 'FHIR meta.lastUpdated for resource versioning',
    `fhir_profile_url` STRING COMMENT 'Canonical FHIR/US Core profile URL this record conforms to',
    `fhir_resource_reference` STRING COMMENT 'Stable FHIR logical resource id for interop exchange',
    `fhir_resource_type` STRING COMMENT 'FHIR resource type this record maps to for interoperability (default: Basic)',
    `fhir_version_code` STRING COMMENT 'FHIR meta.versionId optimistic concurrency token',
    `geographic_service_area` STRING COMMENT 'Description or code of the geographic service area (county, state, or region) within which this capitation arrangement applies. Members outside this area may not be attributed to this arrangement.',
    `individual_stop_loss_threshold` DECIMAL(18,2) COMMENT 'Dollar amount per member per year above which the health plan assumes financial responsibility for claims costs, protecting the provider from catastrophic individual member costs. Expressed in USD.',
    `is_active` BOOLEAN COMMENT 'Logical active flag for soft-delete and current-state filtering.',
    `lob_code` STRING COMMENT 'Line of Business to which this capitation arrangement applies (e.g., Commercial HMO, Medicare Advantage, Medicaid Managed Care). Determines regulatory requirements and rate-setting methodology.. Valid values are `commercial|medicare_advantage|medicaid|chip|exchange|dual_eligible`',
    `master_entity_reference` STRING COMMENT 'Cross-domain master/golden entity key for SSOT resolution.',
    `network_tier` STRING COMMENT 'Network tier classification of the provider under this capitation arrangement. Tier 1 providers typically receive higher capitation rates in exchange for meeting quality and cost-efficiency benchmarks.. Valid values are `tier_1|tier_2|tier_3|narrow_network|broad_network`',
    `payment_frequency` STRING COMMENT 'Frequency at which capitation payments are disbursed to the provider. Monthly is standard for most capitation arrangements; quarterly or annual may apply for certain specialty or institutional arrangements.. Valid values are `monthly|quarterly|semi_annual|annual`',
    `payment_methodology` STRING COMMENT 'Specific payment calculation methodology applied to this capitation arrangement. Pure capitation pays flat PMPM; withhold arrangements retain a percentage pending performance; risk-adjusted capitation applies RAF multipliers. [ENUM-REF-CANDIDATE: pure_capitation|capitation_with_withhold|capitation_with_bonus|risk_adjusted_capitation|tiered_capitation — promote to reference product]. Valid values are `pure_capitation|capitation_with_withhold|capitation_with_bonus|risk_adjusted_capitation|tiered_capitation`',
    `pmpm_rate` DECIMAL(18,2) COMMENT 'Fixed dollar amount paid to the provider per attributed member per calendar month, regardless of services rendered. The core financial parameter of the capitation arrangement. Expressed in USD.',
    `pmpm_rate_currency` STRING COMMENT 'ISO 4217 three-letter currency code for the PMPM rate (typically USD for domestic health plans). Required for multi-currency reporting and regulatory submissions.. Valid values are `^[A-Z]{3}$`',
    `quality_withhold_release_criteria` STRING COMMENT 'Description of the quality performance benchmarks or HEDIS/STAR measure thresholds that must be met for the provider to receive release of withheld capitation amounts. Defines the performance contract terms.',
    `raf_adjustment_factor` DECIMAL(18,2) COMMENT 'Multiplier applied to the base PMPM rate to account for the relative health risk of the attributed member population. A RAF above 1.0 indicates a sicker-than-average population; below 1.0 indicates healthier-than-average.',
    `rate_effective_date` DATE COMMENT 'Date on which the current PMPM rate became effective. Supports rate history tracking when rates are renegotiated mid-contract without creating a new arrangement record.',
    `rate_expiration_date` DATE COMMENT 'Date on which the current PMPM rate expires and is subject to renegotiation or automatic escalation. Null if the rate is open-ended for the arrangement term.',
    `record_created_at` TIMESTAMP COMMENT 'Timestamp the record was created (audit lineage).',
    `record_source_system` STRING COMMENT 'System of record / source system that produced this record (SSOT provenance).',
    `record_status` STRING COMMENT 'Standard ECM audit/governance attribute record_status.',
    `record_updated_at` TIMESTAMP COMMENT 'Timestamp the record was last updated (audit lineage).',
    `record_version` STRING COMMENT 'Optimistic-concurrency / change version of the record.',
    `risk_adjustment_applicable` BOOLEAN COMMENT 'Indicates whether the PMPM rate is subject to risk adjustment based on the attributed member populations Hierarchical Condition Category (HCC) Risk Adjustment Factor (RAF) scores. Applicable primarily for Medicare Advantage and ACA Exchange arrangements.',
    `risk_pool_participant` BOOLEAN COMMENT 'Indicates whether the provider participates in a shared risk pool under this capitation arrangement. Risk pool participants share in surpluses or deficits relative to the capitation budget.',
    `risk_share_percentage` DECIMAL(18,2) COMMENT 'Percentage of risk pool surplus or deficit allocated to the provider under this capitation arrangement. Expressed as a percentage (0.00–100.00). Applicable only when risk_pool_participant is True.',
    `service_category_scope` STRING COMMENT 'Comma-delimited list or narrative description of the covered service categories included under this capitation arrangement (e.g., Primary Care, Preventive Services, Lab, Radiology). Defines the scope of services the provider is financially responsible for under capitation.',
    `source_system_code` STRING COMMENT 'Code identifying the operational system of record from which this capitation arrangement record was sourced (e.g., FACETS, QNXT for Core Administration Platform; CACTUS or PROVIDER_SOURCE for Provider Management System).. Valid values are `FACETS|QNXT|CACTUS|PROVIDER_SOURCE|MANUAL`',
    `source_system_record_reference` STRING COMMENT 'Native record identifier from the operational source system (Facets, QNXT, or Provider Management System) for this capitation arrangement. Supports data lineage, reconciliation, and back-referencing to the system of record.',
    `stop_loss_type` STRING COMMENT 'Type of stop-loss protection included in the capitation arrangement. Individual stop-loss limits exposure per member; aggregate stop-loss limits total population exposure; both applies both thresholds.. Valid values are `individual|aggregate|both|none`',
    `termination_date` DATE COMMENT 'Date on which the capitation arrangement ends and PMPM payments cease. Null for open-ended arrangements. Distinct from contract termination date when partial termination applies.',
    `termination_notice_days` STRING COMMENT 'Number of calendar days advance notice required by either party to terminate this capitation arrangement without cause. Typically 90–180 days for managed care capitation contracts.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this capitation arrangement record was last modified in the data platform. Used for change data capture, incremental processing, and audit trail maintenance.',
    `vbc_arrangement_flag` BOOLEAN COMMENT 'Indicates whether this capitation arrangement includes Value-Based Care (VBC) performance incentive components such as quality bonuses, shared savings, or outcome-based adjustments beyond the base PMPM.',
    `withhold_percentage` DECIMAL(18,2) COMMENT 'Percentage of the PMPM rate withheld from each payment cycle pending performance or quality metric achievement. Withheld amounts are returned upon meeting contractual benchmarks. Expressed as a percentage (0.00–100.00).',
    CONSTRAINT pk_capitation_arrangement PRIMARY KEY(`capitation_arrangement_id`)
) COMMENT 'Defines capitation payment arrangements where providers receive a fixed PMPM (Per Member Per Month) payment to cover a defined scope of services. Captures capitation rate, covered service categories, risk pool participation, stop-loss thresholds, carve-out services, attributed member population criteria, LOB applicability, and payment frequency. Supports HMO and managed care capitation models.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`contract`.`capitation_payment` (
    `capitation_payment_id` BIGINT COMMENT 'Unique surrogate identifier for each capitation payment disbursement record in the Silver Layer lakehouse. Primary key for this entity.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Ensures each capitation payment is tied to the employee who authorized it, supporting payment audit and regulatory compliance.',
    `capitation_arrangement_id` BIGINT COMMENT 'Reference to the specific capitation arrangement or rate schedule within the contract, identifying the applicable PMPM rate table, risk pool configuration, and attributed population definition.',
    `provider_contract_id` BIGINT COMMENT 'Reference to the capitation contract under which this payment is made. Links to the provider contract master defining the capitation arrangement, PMPM rates, and risk-sharing terms.',
    `health_plan_id` BIGINT COMMENT 'Reference to the health plan or benefit product under which the attributed members are enrolled. Determines the applicable benefit structure and capitation rate tier.',
    `original_payment_capitation_payment_id` BIGINT COMMENT 'Reference to the original capitation payment record that this record adjusts, reverses, or supplements. Populated only when prior_period_adjustment_flag is True. Enables audit trail linking of adjustment chains.',
    `provider_id` BIGINT COMMENT 'Reference to the provider (PCP, specialist group, IPA, or ACO) receiving the capitation payment. Corresponds to the credentialed provider entity in the Provider Management System (Cactus/ProviderSource).',
    `ap_voucher_number` STRING COMMENT 'Accounts Payable (AP) voucher or invoice number assigned in Oracle Financials when the capitation payment is posted as a payable. Links the capitation disbursement to the AP subledger for financial reporting and audit trail.',
    `attributed_member_count` STRING COMMENT 'Total number of members attributed to the provider for the payment period. This is the primary driver of the gross capitation payment calculation (attributed_member_count × pmpm_rate = gross_payment_amount).',
    `capitation_rate_tier` STRING COMMENT 'Rate tier or member category applied to determine the PMPM rate for this payment (e.g., adult, pediatric, senior, ESRD, dual-eligible). Different member demographics may attract different PMPM rates under the same contract.',
    `check_eft_trace_number` STRING COMMENT 'Check number or EFT/ACH trace number assigned by the financial institution for the actual disbursement of this capitation payment. Used for bank reconciliation in Oracle Financials (AP module) and provider payment dispute resolution.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this capitation payment record was first created in the Silver Layer data platform. Supports audit trail, data lineage, and SLA monitoring for payment processing cycles.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for all monetary amounts on this capitation payment record. Typically USD for domestic health insurance operations. Required for multi-currency financial reconciliation and GAAP/SAP reporting.. Valid values are `^[A-Z]{3}$`',
    `data_quality_score` STRING COMMENT 'Computed data-quality score for ECM scoring.',
    `effective_end_date` DATE COMMENT 'Effective end of the record validity window.',
    `effective_start_date` DATE COMMENT 'Effective start of the record validity window.',
    `enrollment_adjustment_amount` DECIMAL(18,2) COMMENT 'Dollar adjustment to the gross payment resulting from retroactive enrollment changes (late enrollments, disenrollments, or eligibility corrections) identified after the initial payment calculation. Can be positive (additional payment) or negative (recoupment).',
    `fhir_last_updated` TIMESTAMP COMMENT 'FHIR meta.lastUpdated for resource versioning',
    `fhir_profile_url` STRING COMMENT 'Canonical FHIR/US Core profile URL this record conforms to',
    `fhir_resource_reference` STRING COMMENT 'Stable FHIR logical resource id for interop exchange',
    `fhir_resource_type` STRING COMMENT 'FHIR resource type this record maps to for interoperability (default: PaymentReconciliation)',
    `fhir_version_code` STRING COMMENT 'FHIR meta.versionId optimistic concurrency token',
    `gl_cost_center` STRING COMMENT 'General Ledger (GL) cost center code in Oracle Financials to which this capitation payment expense is allocated. Supports financial reporting by LOB, product, and organizational unit per GAAP and SAP statutory reporting requirements.',
    `gross_payment_amount` DECIMAL(18,2) COMMENT 'Total gross capitation payment amount before any adjustments, calculated as attributed_member_count multiplied by the pmpm_rate. Represents the base payment obligation for the period prior to retroactive enrollment changes, risk pool withholds, or stop-loss recoveries.',
    `is_active` BOOLEAN COMMENT 'Logical active flag for soft-delete and current-state filtering.',
    `line_of_business` STRING COMMENT 'Line of Business (LOB) under which the capitation payment is made. Determines regulatory requirements, rate-setting methodology, and CMS reporting obligations applicable to the payment.. Valid values are `commercial|medicare_advantage|medicaid|chip|exchange`',
    `master_entity_reference` STRING COMMENT 'Cross-domain master/golden entity key for SSOT resolution.',
    `net_payment_amount` DECIMAL(18,2) COMMENT 'Final net amount disbursed to the provider after all adjustments: gross_payment_amount + enrollment_adjustment_amount - risk_pool_withhold_amount + stop_loss_recovery_amount + other_adjustment_amount. This is the actual amount reflected in the 835 ERA remittance advice.',
    `other_adjustment_amount` DECIMAL(18,2) COMMENT 'Catch-all adjustment amount for miscellaneous contractual adjustments not captured in enrollment, risk pool, or stop-loss categories. Includes quality bonus payments, performance incentive adjustments, or administrative fee offsets per contract terms.',
    `payment_approval_date` DATE COMMENT 'Date on which the capitation payment was formally approved for disbursement by the authorized approver in the billing or finance system. Supports segregation of duties controls and audit trail requirements.',
    `payment_date` DATE COMMENT 'Actual date the capitation payment was disbursed to the provider via EFT, check, or ACH. Used for accounts payable reconciliation and provider remittance reporting.',
    `payment_method` STRING COMMENT 'Mechanism by which the capitation payment was or will be disbursed to the provider. EFT (Electronic Funds Transfer) and ACH (Automated Clearing House) are most common for capitation arrangements.. Valid values are `eft|ach|check|wire`',
    `payment_number` STRING COMMENT 'Externally-visible business identifier for this capitation payment disbursement, used in provider remittance advice (835 ERA), accounts payable records, and provider portal references. Format: CAP-YYYYMM-NNNNNN.',
    `payment_period_end_date` DATE COMMENT 'Last day of the coverage month or period for which this capitation payment is being made. Typically the last day of the calendar month in monthly capitation cycles.',
    `payment_period_start_date` DATE COMMENT 'First day of the coverage month or period for which this capitation payment is being made. Typically the first day of the calendar month in monthly capitation cycles.',
    `payment_run_number` STRING COMMENT 'Identifier of the capitation payment run or batch cycle that generated this payment record. Used to group all payments processed in the same cycle for reconciliation, audit, and reprocessing purposes in the Core Administration Platform (Facets/QNXT).',
    `payment_status` STRING COMMENT 'Current lifecycle state of the capitation payment disbursement. pending = calculated but not yet approved; approved = authorized for payment; paid = disbursed to provider; voided = cancelled before disbursement; reversed = clawed back after disbursement; on_hold = suspended pending investigation or contract dispute.. Valid values are `pending|approved|paid|voided|reversed|on_hold`',
    `payment_type` STRING COMMENT 'Classification of the capitation payment by its business purpose. standard = routine monthly capitation; retroactive = payment for prior periods due to enrollment changes; adjustment = correction to a previously issued payment; stop_loss_recovery = reimbursement under stop-loss provisions; risk_pool_settlement = periodic risk pool distribution or withhold settlement.. Valid values are `standard|retroactive|adjustment|stop_loss_recovery|risk_pool_settlement`',
    `pmpm_rate` DECIMAL(18,2) COMMENT 'Per Member Per Month (PMPM) capitation rate applied for this payment period, as defined in the contract rate schedule. This is the contractually negotiated amount paid per attributed member per month. Classified confidential as it represents proprietary contract pricing.',
    `prior_period_adjustment_flag` BOOLEAN COMMENT 'Indicates whether this capitation payment includes or represents an adjustment to a prior payment period. True when the payment corrects or supplements a previously issued capitation payment due to retroactive enrollment changes or rate corrections.',
    `quality_withhold_amount` DECIMAL(18,2) COMMENT 'Amount withheld from the capitation payment pending achievement of quality performance targets (e.g., HEDIS measures, STAR ratings thresholds). Released or forfeited at the end of the performance measurement period based on provider quality scores.',
    `record_created_at` TIMESTAMP COMMENT 'Timestamp the record was created (audit lineage).',
    `record_source_system` STRING COMMENT 'System of record / source system that produced this record (SSOT provenance).',
    `record_status` STRING COMMENT 'Standard ECM audit/governance attribute record_status.',
    `record_updated_at` TIMESTAMP COMMENT 'Timestamp the record was last updated (audit lineage).',
    `record_version` STRING COMMENT 'Optimistic-concurrency / change version of the record.',
    `remittance_advice_number` STRING COMMENT 'Reference number of the 835 Electronic Remittance Advice (ERA) transaction sent to the provider for this capitation payment. Used to reconcile capitation disbursements with provider accounts receivable and the EDI clearinghouse (Availity/Change Healthcare) transaction log.',
    `risk_adjusted_pmpm_rate` DECIMAL(18,2) COMMENT 'PMPM rate after application of the risk adjustment factor (RAF score) to the base contractual PMPM rate. Reflects the risk-adjusted capitation amount per member per month for Medicare Advantage or risk-adjusted commercial arrangements.',
    `risk_pool_withhold_amount` DECIMAL(18,2) COMMENT 'Amount withheld from the gross capitation payment and placed into a shared risk pool per the contract terms. Risk pool withholds are held and distributed (or forfeited) at the end of the risk settlement period based on actual utilization versus targets.',
    `risk_score` DECIMAL(18,2) COMMENT 'Aggregate Risk Adjustment Factor (RAF) score for the attributed member population used to adjust the capitation rate for this payment period. Derived from Hierarchical Condition Category (HCC) coding and CMS Risk Adjustment Processing System (RAPS/EDPS) submissions.',
    `source_system_payment_reference` STRING COMMENT 'Native identifier of this capitation payment record in the originating operational system (Facets, QNXT, or HealthEdge). Used for cross-system reconciliation and data lineage tracing between the Silver Layer and the system of record.',
    `stop_loss_recovery_amount` DECIMAL(18,2) COMMENT 'Amount recovered from or credited to the provider under stop-loss provisions of the capitation contract. Positive values indicate plan reimbursement to provider for catastrophic cases exceeding the stop-loss threshold; negative values indicate provider liability adjustments.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this capitation payment record was last modified in the Silver Layer data platform. Tracks the most recent update for change data capture (CDC), audit trail, and reconciliation purposes.',
    `vbc_contract_flag` BOOLEAN COMMENT 'Indicates whether this capitation payment is made under a Value-Based Care (VBC) or Accountable Care Organization (ACO) contract arrangement, as opposed to a standard fee-for-service capitation. Drives VBC performance reporting and quality incentive calculations.',
    `void_reason` STRING COMMENT 'Business reason code or description explaining why this capitation payment was voided or reversed. Populated only when payment_status is voided or reversed. Examples: contract_termination, duplicate_payment, enrollment_error, rate_correction.',
    CONSTRAINT pk_capitation_payment PRIMARY KEY(`capitation_payment_id`)
) COMMENT 'Transactional record of each capitation payment disbursed to a provider under a capitation arrangement. Captures payment period (month/year), attributed member count, PMPM rate applied, gross payment amount, adjustments (retroactive enrollment changes, risk pool settlements, stop-loss recoveries), net payment amount, payment date, payment status, and remittance advice reference. Feeds accounts payable, provider remittance reporting (835 ERA), and contract financial summary reconciliation.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`contract`.`vbc_contract` (
    `vbc_contract_id` BIGINT COMMENT 'Unique surrogate identifier for the Value-Based Care (VBC) contract record in the Silver layer lakehouse. Primary key for all VBC contract master records including ACO agreements, shared savings, bundled payment, and risk-sharing arrangements.',
    `provider_contract_id` BIGINT COMMENT 'Foreign key linking to contract.provider_contract. Business justification: VBC contracts are a subtype of provider contracts; linking them centralizes contract metadata and removes redundant columns.',
    `health_plan_id` BIGINT COMMENT 'Foreign key linking to plan.health_plan. Business justification: Required for Value‑Based Contract performance reporting per plan; VBC contracts are negotiated per health plan and need plan_id to generate plan‑specific shared‑savings reports.',
    `pool_id` BIGINT COMMENT 'Foreign key linking to risk.pool. Business justification: VBC_REPORTING: Value‑based contracts calculate shared savings against a risk pool; required for performance and settlement reports.',
    `aco_cms_identifier` STRING COMMENT 'CMS-assigned unique identifier for the ACO participating in the Medicare Shared Savings Program (MSSP) or other CMS Innovation Center models. Required for RAPS/EDPS submissions and CMS regulatory reporting.. Valid values are `^A[0-9]{4}$`',
    `aco_entity_name` STRING COMMENT 'Legal name of the ACO, IPA, or provider organization that is the counterparty to this VBC contract. Used for regulatory reporting to CMS, network directory maintenance, and reconciliation settlement correspondence.',
    `aco_entity_tin` STRING COMMENT 'Federal Tax Identification Number (TIN/EIN) of the ACO or IPA entity party to this contract. Required for CMS regulatory submissions, 1099 reporting, and settlement payment processing.. Valid values are `^[0-9]{9}$`',
    `actual_expenditure` DECIMAL(18,2) COMMENT 'Total actual claims expenditure (in USD) incurred by attributed members or episode participants during the performance period. Compared against the benchmark expenditure target to determine shared savings or shared loss amounts.',
    `amendment_effective_date` DATE COMMENT 'Date on which the most recent contract amendment became effective. Used to determine which contract terms apply to claims and reconciliation calculations for a given service date.',
    `attributed_member_count` STRING COMMENT 'Number of health plan members attributed to this VBC contract/ACO entity for the current performance period. Used as the denominator for PMPM calculations, benchmark setting, and population health reporting.',
    `attribution_methodology` STRING COMMENT 'Method used to assign health plan members to this VBC contract/ACO entity for performance measurement. Prospective: members assigned at start of period based on prior utilization; Retrospective: members assigned at end of period based on actual utilization; Voluntary: member elects assignment.. Valid values are `prospective|retrospective|voluntary`',
    `auto_renewal_flag` BOOLEAN COMMENT 'Indicates whether this VBC contract is configured to automatically renew at the end of the current term without requiring a new execution. True = auto-renews; False = requires affirmative renewal action.',
    `benchmark_expenditure_target` DECIMAL(18,2) COMMENT 'The risk-adjusted, trend-adjusted target expenditure amount (in USD) against which actual expenditures are compared during reconciliation. Calculated using historical claims data, risk scores (HCC/RAF), and applicable trend factors per the contract methodology.',
    `cms_program_track` STRING COMMENT 'Specific CMS Innovation Center program track or model under which this contract operates (e.g., MSSP_BASIC_A, MSSP_BASIC_E, MSSP_ENHANCED, BPCI_A, CJR, PCF). Null for commercial VBC contracts not affiliated with a CMS program. [ENUM-REF-CANDIDATE: MSSP_BASIC_A|MSSP_BASIC_B|MSSP_BASIC_C|MSSP_BASIC_D|MSSP_BASIC_E|MSSP_ENHANCED|BPCI_A|CJR|PCF|DCE — promote to reference product]',
    `contract_amendment_number` STRING COMMENT 'Sequential identifier for the most recent amendment to this VBC contract (e.g., AMD-003). Tracks contract modifications including rate changes, term extensions, quality measure updates, and risk arrangement adjustments. Null for original, unamended contracts.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this VBC contract record was first created in the system. Used for audit trail, data lineage, and regulatory record-keeping. Conforms to ISO 8601 format (yyyy-MM-ddTHH:mm:ss.SSSXXX).',
    `data_quality_score` STRING COMMENT 'Computed data-quality score for ECM scoring.',
    `effective_end_date` DATE COMMENT 'Effective end of the record validity window.',
    `effective_start_date` DATE COMMENT 'Effective start of the record validity window.',
    `episode_target_price` DECIMAL(18,2) COMMENT 'The risk-adjusted target price (in USD) for a single bundled payment episode. Calculated from historical claims data with applicable discounts and trend adjustments. Actual episode expenditures are compared to this target for reconciliation. Null for non-bundled VBC models.',
    `episode_trigger_code` STRING COMMENT 'The CPT procedure code or DRG (Diagnosis Related Group) code that initiates a bundled payment episode. For example, DRG 470 triggers a major joint replacement episode under BPCI-A. Null for non-bundled VBC models.',
    `episode_type` STRING COMMENT 'For bundled payment contracts, the clinical episode category being bundled (e.g., joint_replacement, cardiac_surgery, maternity, hip_fracture, spinal_fusion). Null for non-bundled VBC models. Determines the trigger event, episode window, and target price methodology. [ENUM-REF-CANDIDATE: joint_replacement|cardiac_surgery|maternity|hip_fracture|spinal_fusion|pneumonia|copd|stroke — promote to reference product]',
    `episode_window_days` STRING COMMENT 'Total number of days in the bundled payment episode window, measured from the trigger event (e.g., 90 days post-discharge for BPCI-A). Defines the period during which all included services are attributed to the bundle for reconciliation.',
    `fhir_last_updated` TIMESTAMP COMMENT 'FHIR meta.lastUpdated for resource versioning',
    `fhir_profile_url` STRING COMMENT 'Canonical FHIR/US Core profile URL this record conforms to',
    `fhir_resource_reference` STRING COMMENT 'Stable FHIR logical resource id for interop exchange',
    `fhir_resource_type` STRING COMMENT 'FHIR resource type this record maps to for interoperability (default: Basic)',
    `fhir_version_code` STRING COMMENT 'FHIR meta.versionId optimistic concurrency token',
    `hedis_measure_targets` STRING COMMENT 'Pipe-delimited list of HEDIS or CMS STAR measure identifiers and their contractual target thresholds included as quality gate requirements for this VBC contract (e.g., CBP:75.0|CDC-HbA1c:80.0|W34:85.0). Supports quality performance monitoring and NCQA reporting.',
    `is_active` BOOLEAN COMMENT 'Logical active flag for soft-delete and current-state filtering.',
    `line_of_business` STRING COMMENT 'Line of business under which this VBC contract operates. Determines applicable regulatory framework, benchmark methodology, and quality measure set (e.g., HEDIS for commercial, STAR for Medicare Advantage, MSSP for fee-for-service Medicare). [ENUM-REF-CANDIDATE: commercial|medicare_advantage|medicaid|mssp|bpci_a|exchange|dual_eligible — promote to reference product]. Valid values are `commercial|medicare_advantage|medicaid|mssp|bpci_a|exchange`',
    `master_entity_reference` STRING COMMENT 'Cross-domain master/golden entity key for SSOT resolution.',
    `max_shared_loss_rate` DECIMAL(18,2) COMMENT 'The maximum percentage of benchmark expenditure (expressed as a decimal) that can be assessed as shared loss against the ACO/provider entity. Caps the providers downside financial exposure in two-sided risk arrangements.',
    `max_shared_savings_rate` DECIMAL(18,2) COMMENT 'The maximum percentage of benchmark expenditure (expressed as a decimal) that can be distributed as shared savings to the ACO/provider entity, regardless of actual savings achieved. Caps the health plans financial exposure on the upside.',
    `minimum_loss_rate` DECIMAL(18,2) COMMENT 'The minimum percentage threshold (expressed as a decimal) by which actual expenditures must exceed the benchmark before any shared loss is assessed. Applicable to two-sided risk arrangements. Symmetric counterpart to the Minimum Savings Rate (MSR).',
    `minimum_savings_rate` DECIMAL(18,2) COMMENT 'The minimum percentage threshold (expressed as a decimal, e.g., 0.02 = 2%) by which actual expenditures must fall below the benchmark before any shared savings are distributed. Protects against random variation triggering unearned payments. Required field for MSSP Track 1 and Track 1+ contracts.',
    `performance_period_end` DATE COMMENT 'End date of the current performance measurement period. Marks the close of the measurement window after which actual expenditures are compared to the benchmark target for reconciliation and settlement.',
    `performance_period_start` DATE COMMENT 'Start date of the current performance measurement period for this VBC contract. Defines the window during which attributed member expenditures, quality scores, and utilization are measured against the benchmark.',
    `performance_year` STRING COMMENT 'Calendar or contract year for which performance is being measured and reconciled under this VBC contract. Used to track year-over-year performance trends, benchmark updates, and quality score progression. Typically a 4-digit year (e.g., 2024).',
    `quality_gate_met` BOOLEAN COMMENT 'Indicates whether the ACO/provider entity met the minimum quality performance threshold (quality gate) required to be eligible for shared savings distribution. True = quality gate satisfied; False = quality gate not met, shared savings withheld or reduced.',
    `quality_gate_threshold` DECIMAL(18,2) COMMENT '',
    `quality_score` DECIMAL(18,2) COMMENT 'Composite quality performance score (expressed as a decimal percentage, e.g., 0.85 = 85%) achieved by the ACO/provider entity during the performance period. Derived from HEDIS measures, STAR ratings, or contract-specific quality metrics. May gate or adjust shared savings distribution.',
    `reconciliation_methodology` STRING COMMENT 'Approach used to calculate and settle financial performance under this VBC contract. Prospective: target price set in advance; Retrospective: actual costs compared to historical benchmark after the period; Hybrid: combination of prospective target with retrospective quality adjustment.. Valid values are `prospective|retrospective|hybrid`',
    `reconciliation_status` STRING COMMENT 'Current status of the financial reconciliation process for the performance period. Tracks the lifecycle from initial calculation through dispute resolution to final settlement: pending (not yet started), in_progress (under calculation), completed (finalized), disputed (under appeal), settled (payment processed).. Valid values are `pending|in_progress|completed|disputed|settled`',
    `record_created_at` TIMESTAMP COMMENT 'Timestamp the record was created (audit lineage).',
    `record_source_system` STRING COMMENT 'System of record / source system that produced this record (SSOT provenance).',
    `record_status` STRING COMMENT 'Standard ECM audit/governance attribute record_status.',
    `record_updated_at` TIMESTAMP COMMENT 'Timestamp the record was last updated (audit lineage).',
    `record_version` STRING COMMENT 'Optimistic-concurrency / change version of the record.',
    `risk_arrangement_type` STRING COMMENT 'Specifies the financial risk-sharing structure between the health plan and the provider/ACO entity. Upside_only: provider shares in savings only; two_sided: provider shares in both savings and losses; full_risk: provider assumes full financial risk (global capitation); partial_risk: provider assumes a defined portion of risk.. Valid values are `upside_only|two_sided|full_risk|partial_risk`',
    `risk_corridor_lower` DECIMAL(18,2) COMMENT 'Lower bound of the risk corridor (expressed as a decimal percentage below benchmark) within which no financial settlement occurs. Protects both parties from small random expenditure variations. Equivalent to the Minimum Savings Rate in MSSP terminology.',
    `risk_corridor_upper` DECIMAL(18,2) COMMENT 'Upper bound of the risk corridor (expressed as a decimal percentage above benchmark) beyond which the health plan absorbs excess losses (stop-loss protection). Limits the providers maximum financial exposure in two-sided risk arrangements.',
    `savings_sharing_rate` DECIMAL(18,2) COMMENT 'The percentage (expressed as a decimal, e.g., 0.50 = 50%) of qualifying shared savings that is distributed to the ACO/provider entity. Negotiated contractually and may vary by quality score tier or performance band.',
    `settlement_date` DATE COMMENT 'Date on which the shared savings distribution or shared loss recoupment payment was or is scheduled to be processed. Used for financial accrual, IBNR reserve release, and cash flow reporting.',
    `shared_loss_percentage` DECIMAL(18,2) COMMENT '',
    `shared_savings_amount` DECIMAL(18,2) COMMENT 'Net shared savings (positive) or shared loss (negative) amount in USD calculated after reconciliation. Represents the financial settlement due to or owed by the ACO/provider entity based on performance against the benchmark. Positive = savings distribution; negative = loss recoupment.',
    `shared_savings_percentage` DECIMAL(18,2) COMMENT '',
    `stop_loss_threshold` DECIMAL(18,2) COMMENT 'Maximum dollar amount of shared loss that the ACO/provider entity is obligated to repay in a given performance period. Provides downside protection and is a key negotiated term in two-sided risk VBC contracts.',
    `total_cost_target` DECIMAL(18,2) COMMENT '',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this VBC contract record was most recently modified. Used for change data capture (CDC), incremental ETL processing, and audit trail maintenance. Conforms to ISO 8601 format (yyyy-MM-ddTHH:mm:ss.SSSXXX).',
    `vbc_model_type` STRING COMMENT 'Classification of the VBC payment model governing this contract. Determines the financial risk structure and reconciliation methodology: shared_savings (upside only), shared_risk (two-sided), full_capitation (global budget), bundled_payment (episode-based), pay_for_performance (quality incentive). [ENUM-REF-CANDIDATE: shared_savings|shared_risk|full_capitation|bundled_payment|pay_for_performance|global_budget — promote to reference product if additional models are needed]. Valid values are `shared_savings|shared_risk|full_capitation|bundled_payment|pay_for_performance`',
    CONSTRAINT pk_vbc_contract PRIMARY KEY(`vbc_contract_id`)
) COMMENT 'Master record for Value-Based Care (VBC) contracts, ACO agreements, risk-sharing arrangements, and bundled payment programs. Captures VBC model type (shared savings, shared risk, full capitation, bundled payment, pay-for-performance), ACO/IPA entity details, and reconciliation status. Includes performance period definitions with performance year, benchmark expenditure target, actual expenditure, quality score, shared savings or loss amount, reconciliation status, settlement date, minimum savings rate (MSR), maximum shared savings/loss rate, and quality gate requirements (HEDIS/STAR measure targets). For bundled payment models, captures episode definitions including episode type (joint replacement, cardiac surgery, maternity), trigger event (procedure code, DRG), episode window (days pre/post trigger), target price, included/excluded services, reconciliation methodology, and quality metrics. Supports CMS MSSP, BPCI-A, and commercial ACO/VBC reporting. SSOT for all VBC, risk-sharing, episode-based payment contractual structures, performance period tracking, bundled episode definitions, and year-over-year performance trend analysis.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`contract`.`vbc_performance_period` (
    `vbc_performance_period_id` BIGINT COMMENT 'Unique surrogate identifier for a VBC performance period record within the contract domain. Primary key for this entity.',
    `pool_id` BIGINT COMMENT 'add column risk_pool_id (BIGINT) with FK to risk.pool.pool_id - VBC performance periods settle against risk pools',
    `vbc_contract_id` BIGINT COMMENT 'Reference to the parent VBC contract under which this performance period is defined. Links the performance period to its governing contractual agreement.',
    `aco_identifier` BIGINT COMMENT 'Reference to the Accountable Care Organization (ACO) participating in this performance period. Supports CMS MSSP and commercial ACO reporting.',
    `actual_expenditure` DECIMAL(18,2) COMMENT 'Total actual claims expenditure (in USD) incurred for the attributed population during the performance period. Compared against the benchmark to determine savings or losses.',
    `actual_pmpm` DECIMAL(18,2) COMMENT 'Actual expenditure expressed on a Per Member Per Month (PMPM) basis in USD. Compared against benchmark PMPM to assess cost efficiency of the ACO or provider entity.',
    `appeal_deadline_date` DATE COMMENT 'Contractual or regulatory deadline by which the ACO or provider entity must file a formal appeal of the reconciliation results for this performance period.',
    `attributed_member_count` STRING COMMENT 'Total number of members attributed to the ACO or provider entity for this performance period. Used as the denominator for Per Member Per Month (PMPM) calculations and benchmark setting.',
    `benchmark_expenditure_target` DECIMAL(18,2) COMMENT 'The projected total expenditure benchmark (in USD) established at the start of the performance period, representing the expected cost of care for the attributed population. Basis for shared savings or loss calculations.',
    `benchmark_pmpm` DECIMAL(18,2) COMMENT 'Benchmark expenditure expressed on a Per Member Per Month (PMPM) basis in USD. Normalizes the benchmark for population size and enables cross-period and cross-ACO comparisons.',
    `benchmark_update_method` STRING COMMENT 'Methodology used to update or set the expenditure benchmark for this performance period (e.g., historical trend, regional average, blended, prospective). Affects benchmark accuracy and ACO incentive alignment.. Valid values are `historical|regional|blended|prospective`',
    `cahps_composite_score` DECIMAL(18,2) COMMENT 'Composite CAHPS survey score reflecting member experience with care during this performance period. Contributes to quality gate assessment and CMS Star Ratings.',
    `cms_program_track` STRING COMMENT 'CMS MSSP participation track for this performance period (e.g., BASIC levels A-E or ENHANCED). Determines risk model, savings rates, and quality reporting requirements.. Valid values are `BASIC_A|BASIC_B|BASIC_C|BASIC_D|BASIC_E|ENHANCED`',
    `cms_submission_date` DATE COMMENT 'Date on which performance period data was submitted to CMS for MSSP or other federal VBC program reporting. Required for regulatory compliance tracking.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this performance period record was first created in the system. Supports audit trail and data lineage requirements.',
    `data_quality_score` STRING COMMENT 'Computed data-quality score for ECM scoring.',
    `effective_end_date` DATE COMMENT 'Effective end of the record validity window.',
    `effective_start_date` DATE COMMENT 'Effective start of the record validity window.',
    `end_date` DATE COMMENT 'Last date of the measurement period. Expenditures and quality events occurring on or before this date are included in the performance calculation.',
    `expenditure_variance` DECIMAL(18,2) COMMENT 'Difference between benchmark expenditure target and actual expenditure (in USD). Positive value indicates savings; negative value indicates losses. Drives shared savings or shared loss determination.',
    `fhir_last_updated` TIMESTAMP COMMENT 'FHIR meta.lastUpdated for resource versioning',
    `fhir_profile_url` STRING COMMENT 'Canonical FHIR/US Core profile URL this record conforms to',
    `fhir_resource_reference` STRING COMMENT 'Stable FHIR logical resource id for interop exchange',
    `fhir_resource_type` STRING COMMENT 'FHIR resource type this record maps to for interoperability (default: Basic)',
    `fhir_version_code` STRING COMMENT 'FHIR meta.versionId optimistic concurrency token',
    `hcc_capture_rate` DECIMAL(18,2) COMMENT 'Percentage of expected Hierarchical Condition Category (HCC) diagnoses that were documented and coded during the performance period. Impacts RAF score accuracy and benchmark integrity.',
    `hedis_composite_score` DECIMAL(18,2) COMMENT 'Composite HEDIS measure score for the attributed population during this performance period. Contributes to the overall quality score and CMS quality reporting requirements.',
    `ibnr_reserve_amount` DECIMAL(18,2) COMMENT 'Actuarial reserve (in USD) for claims Incurred But Not Reported (IBNR) as of the performance period end date. Included in actual expenditure calculations to ensure completeness of cost measurement.',
    `is_active` BOOLEAN COMMENT 'Logical active flag for soft-delete and current-state filtering.',
    `lob` STRING COMMENT 'Line of Business (LOB) associated with this performance period (e.g., Medicare, Medicaid, Commercial, Marketplace, D-SNP). Determines applicable regulatory requirements and benchmark methodologies.. Valid values are `medicare|medicaid|commercial|marketplace|dsnp`',
    `master_entity_reference` STRING COMMENT 'Cross-domain master/golden entity key for SSOT resolution.',
    `minimum_loss_rate` DECIMAL(18,2) COMMENT 'The minimum percentage threshold of losses relative to the benchmark that triggers shared loss liability for the ACO under two-sided risk models. Expressed as a decimal (e.g., 0.02 = 2%).',
    `minimum_savings_rate` DECIMAL(18,2) COMMENT 'The minimum percentage threshold of savings relative to the benchmark that must be achieved before the ACO qualifies for shared savings. Expressed as a decimal (e.g., 0.02 = 2%). Required by CMS MSSP program rules.',
    `net_settlement_amount` DECIMAL(18,2) COMMENT 'Final net dollar amount payable to or recoverable from the ACO or provider entity after applying shared savings, shared losses, quality adjustments, and any withholds. Positive = payment to provider; negative = recovery from provider.',
    `notes` STRING COMMENT 'Free-text field for capturing supplemental context, reconciliation commentary, dispute details, or operational notes related to this performance period.',
    `payment_model` STRING COMMENT 'Reimbursement methodology governing this performance period. Determines how savings, losses, and risk are allocated between the health plan and the ACO or provider entity. [ENUM-REF-CANDIDATE: shared_savings|shared_risk|capitation|bundled|global_budget|fee_for_service — promote to reference product if additional models are needed]. Valid values are `shared_savings|shared_risk|capitation|bundled|global_budget|fee_for_service`',
    `performance_period_number` STRING COMMENT 'Externally-known business identifier for this performance period, formatted as PP-YYYY-NNN. Used in CMS submissions, ACO reporting, and contract correspondence.. Valid values are `^PP-[0-9]{4}-[0-9]{3}$`',
    `performance_year` STRING COMMENT 'Calendar or contract year (e.g., 2024) for which performance is measured. Used for year-over-year trend analysis and CMS annual reconciliation cycles.',
    `period_status` STRING COMMENT 'Current lifecycle state of the performance period. Tracks progression from open measurement through reconciliation, settlement, and potential dispute resolution.. Valid values are `open|closed|reconciled|settled|disputed|voided`',
    `period_type` STRING COMMENT 'Classification of the measurement period (e.g., annual, semi-annual, quarterly, interim, final). Determines the reconciliation cadence and reporting obligations.. Valid values are `annual|semi_annual|quarterly|interim|final`',
    `prior_period_adjustment` DECIMAL(18,2) COMMENT 'Dollar amount of adjustments applied to this performance period resulting from corrections or true-ups from a prior performance period. Positive = additional payment; negative = recovery.',
    `quality_gate_met` BOOLEAN COMMENT 'Indicates whether the ACO or provider entity met the minimum quality performance threshold required to qualify for shared savings distribution. True = quality gate satisfied.',
    `quality_score` DECIMAL(18,2) COMMENT 'Composite quality performance score for the ACO or provider entity during this period, expressed as a decimal (e.g., 0.85 = 85%). Derived from HEDIS, CAHPS, and CMS quality measures. May gate or adjust shared savings eligibility.',
    `raf_score` DECIMAL(18,2) COMMENT 'Average Risk Adjustment Factor (RAF) score for the attributed population during this performance period. Reflects the relative health risk of the population and is used to normalize the benchmark expenditure target.',
    `reconciliation_date` DATE COMMENT 'Date on which the financial reconciliation calculation was completed and results were finalized for this performance period.',
    `reconciliation_status` STRING COMMENT 'Current status of the financial reconciliation process for this performance period. Tracks progression from initial calculation through dispute resolution to final settlement.. Valid values are `pending|in_progress|complete|disputed|appealed|final`',
    `record_created_at` TIMESTAMP COMMENT 'Timestamp the record was created (audit lineage).',
    `record_source_system` STRING COMMENT 'System of record / source system that produced this record (SSOT provenance).',
    `record_status` STRING COMMENT 'Standard ECM audit/governance attribute record_status.',
    `record_updated_at` TIMESTAMP COMMENT 'Timestamp the record was last updated (audit lineage).',
    `record_version` STRING COMMENT 'Optimistic-concurrency / change version of the record.',
    `risk_model` STRING COMMENT 'Defines the risk-sharing arrangement for this period. One-sided models allow only shared savings; two-sided models expose the ACO to both savings and losses.. Valid values are `one_sided|two_sided|full_risk|partial_risk`',
    `settlement_date` DATE COMMENT 'Date on which the net settlement payment was made to or recovered from the ACO or provider entity. Null if settlement has not yet occurred.',
    `shared_loss_amount` DECIMAL(18,2) COMMENT 'Calculated dollar amount of shared losses owed by the ACO or provider entity for this performance period (in USD). Positive value only; zero if loss threshold not met or one-sided model.',
    `shared_loss_rate` DECIMAL(18,2) COMMENT 'The contractually agreed percentage of qualifying losses that the ACO or provider entity is liable to repay under two-sided risk arrangements. Expressed as a decimal (e.g., 0.30 = 30%).',
    `shared_savings_amount` DECIMAL(18,2) COMMENT 'Calculated dollar amount of shared savings earned by the ACO or provider entity for this performance period (in USD). Positive value only; zero if savings threshold not met.',
    `shared_savings_rate` DECIMAL(18,2) COMMENT 'The contractually agreed percentage of qualifying savings that is distributed to the ACO or provider entity. Expressed as a decimal (e.g., 0.50 = 50%). Varies by risk track and quality performance.',
    `star_rating` DECIMAL(18,2) COMMENT 'CMS Star Rating assigned to the health plan or ACO for this performance period. Influences quality bonus payments, shared savings eligibility, and member-facing plan comparisons.',
    `start_date` DATE COMMENT 'First date of the measurement period during which provider performance and expenditures are tracked against the benchmark target.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this performance period record was most recently modified. Supports change tracking, audit trail, and incremental data pipeline processing.',
    `withhold_amount` DECIMAL(18,2) COMMENT 'Dollar amount withheld from shared savings distribution pending quality performance validation or regulatory review. Released upon satisfaction of quality gate or other contractual conditions.',
    CONSTRAINT pk_vbc_performance_period PRIMARY KEY(`vbc_performance_period_id`)
) COMMENT 'Defines the measurement and reconciliation periods within a VBC contract. Captures performance year, benchmark expenditure target, actual expenditure, quality score, shared savings or loss amount, reconciliation status, and settlement date. Tracks year-over-year performance trends and supports CMS MSSP and commercial ACO reporting requirements.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`contract`.`bundled_payment_episode` (
    `bundled_payment_episode_id` BIGINT COMMENT 'Unique surrogate identifier for a bundled payment episode definition. Primary key for this data product.',
    `provider_contract_id` BIGINT COMMENT 'Reference to the parent provider contract under which this bundled payment episode is defined. Links the episode to the overarching reimbursement agreement.',
    `anchor_setting` STRING COMMENT 'Care setting in which the anchor/trigger event must occur to initiate the episode. Inpatient episodes are typically DRG-triggered; outpatient episodes are procedure-triggered.. Valid values are `inpatient|outpatient|both`',
    `cms_episode_code` STRING COMMENT 'Official CMS-assigned identifier for this episode type under CMS BPCI-A or other CMS bundled payment programs. Used for CMS submission, reporting, and reconciliation with CMS systems.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this bundled payment episode definition record was first created in the system. Supports audit trail and data lineage requirements.',
    `data_quality_score` STRING COMMENT 'Computed data-quality score for ECM scoring.',
    `drg_code` STRING COMMENT 'Primary Diagnosis Related Group (DRG) code associated with the anchor hospitalization for inpatient-triggered episodes. Used for episode identification and target price stratification.. Valid values are `^[0-9]{3}$`',
    `effective_date` DATE COMMENT 'Date on which this bundled payment episode definition becomes contractually binding and eligible to trigger new episodes.',
    `effective_end_date` DATE COMMENT 'Effective end of the record validity window.',
    `effective_start_date` DATE COMMENT 'Effective start of the record validity window.',
    `episode_code` STRING COMMENT 'Externally-known alphanumeric code uniquely identifying this bundled payment episode definition (e.g., BPCI-JOINT-2024, COMM-CARDIAC-001). Used in EDI transactions and contract references.. Valid values are `^[A-Z0-9_-]{3,30}$`',
    `episode_name` STRING COMMENT 'Human-readable name of the bundled payment episode (e.g., Lower Extremity Joint Replacement, Coronary Artery Bypass Graft, Maternity Global). Used in reporting and member communications.',
    `episode_status` STRING COMMENT 'Current lifecycle status of the bundled payment episode definition. Controls whether new episodes can be triggered and whether reconciliation is active.. Valid values are `draft|active|suspended|terminated|expired`',
    `episode_type` STRING COMMENT 'Clinical category of the bundled payment episode (e.g., joint_replacement, cardiac_surgery, maternity, spine_surgery, hip_fracture, pneumonia, sepsis, oncology). Drives episode grouping logic and target price methodology. [ENUM-REF-CANDIDATE: joint_replacement|cardiac_surgery|maternity|spine_surgery|hip_fracture|pneumonia|sepsis|oncology|copd|chf — promote to reference product]',
    `excluded_services_description` STRING COMMENT 'Narrative description of service categories explicitly excluded from the bundled payment episode (e.g., unrelated readmissions, trauma services, transplants, Part B drugs). Excluded services are reimbursed separately under standard fee-for-service.',
    `fhir_last_updated` TIMESTAMP COMMENT 'FHIR meta.lastUpdated for resource versioning',
    `fhir_profile_url` STRING COMMENT 'Canonical FHIR/US Core profile URL this record conforms to',
    `fhir_resource_reference` STRING COMMENT 'Stable FHIR logical resource id for interop exchange',
    `fhir_resource_type` STRING COMMENT 'FHIR resource type this record maps to for interoperability (default: PaymentReconciliation)',
    `fhir_version_code` STRING COMMENT 'FHIR meta.versionId optimistic concurrency token',
    `gain_sharing_rate` DECIMAL(18,2) COMMENT 'Proportion of savings (actual spend below target price) shared with the participating provider or ACO. Expressed as a decimal (e.g., 0.5000 = 50%). Incentivizes cost-efficient care delivery.',
    `icd_version` STRING COMMENT 'Version of the ICD coding system used for diagnosis-based trigger codes and episode clinical definitions. Ensures correct code interpretation across coding system transitions.. Valid values are `ICD-10|ICD-11`',
    `included_services_description` STRING COMMENT 'Narrative description of service categories included within the bundled payment episode (e.g., acute inpatient stay, SNF, home health, outpatient rehab, physician services, DME). Defines the scope of the bundle.',
    `is_active` BOOLEAN COMMENT 'Logical active flag for soft-delete and current-state filtering.',
    `lob` STRING COMMENT 'Line of Business to which this bundled payment episode applies. Determines applicable regulatory requirements, CMS program rules, and reimbursement frameworks.. Valid values are `commercial|medicare_advantage|medicaid|marketplace|fehb`',
    `loss_sharing_rate` DECIMAL(18,2) COMMENT 'Proportion of losses (actual spend above target price) borne by the participating provider or ACO. Expressed as a decimal (e.g., 0.2000 = 20%). Defines downside risk exposure.',
    `master_entity_reference` STRING COMMENT 'Cross-domain master/golden entity key for SSOT resolution.',
    `minimum_episode_volume` STRING COMMENT 'Minimum number of episodes a provider must trigger within a performance period to be eligible for reconciliation and gain/loss sharing. Prevents statistical noise from low-volume providers.',
    `outlier_exclusion_threshold` DECIMAL(18,2) COMMENT 'Dollar threshold above which an individual episodes actual expenditure is classified as a high-cost outlier and excluded from reconciliation calculations. Protects against distortion from catastrophic cases.',
    `payment_methodology` STRING COMMENT 'Reconciliation payment methodology for the episode. Retrospective: fee-for-service paid then reconciled against target. Prospective: single upfront payment. Hybrid: combination approach.. Valid values are `retrospective|prospective|hybrid`',
    `performance_year` STRING COMMENT 'Calendar or program year in which this episode definition and target price are applicable. Aligns with CMS performance period designations and annual contract renewal cycles.',
    `post_trigger_window_days` STRING COMMENT 'Number of days following the anchor/trigger event included in the episode window for attribution of post-acute and follow-up services (e.g., 90 days post-discharge). Standard CMS BPCI-A windows are 30, 60, or 90 days.',
    `pre_trigger_window_days` STRING COMMENT 'Number of days prior to the anchor/trigger event included in the episode window for attribution of pre-episode services (e.g., pre-operative workup). Typically 0–30 days.',
    `program_type` STRING COMMENT 'Identifies the payment program under which this episode is defined. Distinguishes CMS mandatory/voluntary programs from commercial and Medicaid bundled payment arrangements.. Valid values are `cms_bpci_a|cms_cjr|commercial|medicaid|medicare_advantage`',
    `quality_gate_required` BOOLEAN COMMENT 'Indicates whether the provider must meet minimum quality performance thresholds before any gain sharing payments are released. True = quality gate is a prerequisite for gain sharing.',
    `quality_withhold_rate` DECIMAL(18,2) COMMENT 'Percentage of the target price withheld pending quality performance. Released to the provider upon meeting quality thresholds. Aligns financial incentives with quality outcomes (e.g., 0.0300 = 3% withhold).',
    `raf_adjustment_factor` DECIMAL(18,2) COMMENT 'Multiplicative Risk Adjustment Factor (RAF) applied to the baseline target price to normalize for patient acuity. Values above 1.0 indicate higher-risk patient populations; below 1.0 indicate lower-risk.',
    `readmission_included` BOOLEAN COMMENT 'Indicates whether related inpatient readmissions occurring within the episode window are attributed to and included in the bundled payment. Unrelated readmissions are typically excluded.',
    `reconciliation_frequency` STRING COMMENT 'Frequency at which actual episode expenditures are reconciled against the target price and gain/loss settlements are calculated and paid.. Valid values are `monthly|quarterly|semi_annual|annual`',
    `reconciliation_methodology` STRING COMMENT 'Specific reconciliation approach used to calculate net settlement amounts. Net Payment Reconciliation (NPR) adjusts individual claims; Episode Payment issues a single bundled payment; Virtual Reconciliation compares totals without adjusting individual claims.. Valid values are `net_payment_reconciliation|episode_payment|virtual_reconciliation`',
    `record_created_at` TIMESTAMP COMMENT 'Timestamp the record was created (audit lineage).',
    `record_source_system` STRING COMMENT 'System of record / source system that produced this record (SSOT provenance).',
    `record_status` STRING COMMENT 'Standard ECM audit/governance attribute record_status.',
    `record_updated_at` TIMESTAMP COMMENT 'Timestamp the record was last updated (audit lineage).',
    `record_version` STRING COMMENT 'Optimistic-concurrency / change version of the record.',
    `risk_adjustment_applied` BOOLEAN COMMENT 'Indicates whether the target price is adjusted for patient risk (e.g., HCC-based Risk Adjustment Factor) to account for case mix differences across providers and performance periods.',
    `snf_included` BOOLEAN COMMENT 'Indicates whether Skilled Nursing Facility (SNF) post-acute care services are included within the episode bundle. SNF inclusion significantly impacts target price and provider risk.',
    `stop_gain_threshold` DECIMAL(18,2) COMMENT 'Maximum dollar amount of savings the provider can earn per episode. Caps upside gain sharing to prevent windfall payments from outlier low-cost episodes.',
    `stop_loss_threshold` DECIMAL(18,2) COMMENT 'Maximum dollar amount of losses the provider is required to absorb per episode before the health plan assumes full financial responsibility. Protects providers from catastrophic high-cost episodes.',
    `target_price` DECIMAL(18,2) COMMENT 'The all-inclusive target price for the bundled payment episode in USD. Represents the maximum total reimbursement for all covered services within the episode window. Basis for reconciliation and gain/loss sharing calculations.',
    `target_price_basis` STRING COMMENT 'Methodology used to establish the target price. Historical claims-based uses the providers own prior utilization; regional/national benchmarks use market comparators; negotiated is a contractually agreed fixed amount.. Valid values are `historical_claims|regional_benchmark|national_benchmark|negotiated`',
    `target_price_effective_date` DATE COMMENT 'Date from which the current target price is applicable. Target prices are typically updated annually or per performance period.',
    `target_price_expiration_date` DATE COMMENT 'Date on which the current target price expires and must be renegotiated or updated. Null indicates the target price is open-ended until superseded.',
    `termination_date` DATE COMMENT 'Date on which this bundled payment episode definition is terminated and no longer eligible to trigger new episodes. Null for currently active definitions.',
    `trigger_code` STRING COMMENT 'The specific procedure code (CPT/HCPCS), DRG number, or ICD code that triggers the episode window. For multi-code triggers, stores the primary anchor code; supplemental codes managed in a related reference table.',
    `trigger_code_type` STRING COMMENT 'Classification system for the trigger code. Indicates whether the trigger_code is a Current Procedural Terminology (CPT), Healthcare Common Procedure Coding System (HCPCS), Diagnosis Related Group (DRG), or ICD-10 code.. Valid values are `CPT|HCPCS|DRG|ICD10CM|ICD10PCS`',
    `trigger_event_type` STRING COMMENT 'Type of clinical event that initiates the bundled payment episode window. Determines whether the anchor event is identified by a CPT/HCPCS procedure code, DRG, ICD diagnosis code, or inpatient admission.. Valid values are `procedure_code|drg|diagnosis_code|admission`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this bundled payment episode definition record was most recently modified. Used for change tracking, incremental data loads, and audit compliance.',
    CONSTRAINT pk_bundled_payment_episode PRIMARY KEY(`bundled_payment_episode_id`)
) COMMENT 'Defines bundled payment episodes under episode-of-care payment models. Captures episode type (joint replacement, cardiac surgery, maternity), trigger event (procedure code, DRG), episode window (days pre/post trigger), target price, included services, excluded services, reconciliation methodology, and quality metrics. Supports CMS BPCI-A and commercial bundled payment programs.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`contract`.`reimbursement_policy` (
    `reimbursement_policy_id` BIGINT COMMENT 'Unique surrogate identifier for the reimbursement policy record in the Silver Layer lakehouse. Primary key for this entity.',
    `provider_contract_id` BIGINT COMMENT 'Reference to the provider contract under which this reimbursement policy is established. Links the policy to the contractual agreement governing provider reimbursement terms.',
    `fee_schedule_id` BIGINT COMMENT 'Reference to the fee schedule that serves as the base rate table for this reimbursement policy. The policy reduction or adjustment is applied against the rates defined in the referenced fee schedule.',
    `pool_id` BIGINT COMMENT 'Foreign key linking to risk.pool. Business justification: POLICY_COMPLIANCE: Policies may vary by risk pool; linking supports audit trails and CMS risk‑adjustment audits.',
    `superseded_policy_reimbursement_policy_id` BIGINT COMMENT 'Reference to the prior reimbursement policy record that this policy replaces or supersedes. Enables policy lineage tracking and ensures historical adjudication records can be traced to the correct policy version.',
    `applies_to_facility` BOOLEAN COMMENT 'Indicates whether this reimbursement policy applies to facility (institutional) claims (CMS-1450/UB-04). When True, the policy is enforced on facility claims submitted via 837I transactions.',
    `applies_to_professional` BOOLEAN COMMENT 'Indicates whether this reimbursement policy applies to professional (physician) claims (CMS-1500). When True, the policy is enforced on professional claims submitted via 837P transactions.',
    `cpt_range_end` STRING COMMENT 'Ending CPT or HCPCS procedure code in the range to which this reimbursement policy applies. Used in conjunction with cpt_range_start to define the applicable procedure code range. If equal to cpt_range_start, the policy applies to a single procedure code.. Valid values are `^[0-9]{5}$`',
    `cpt_range_start` STRING COMMENT 'Starting CPT or HCPCS procedure code in the range to which this reimbursement policy applies. Used in conjunction with cpt_range_end to define the applicable procedure code range for adjudication logic in Facets/QNXT.. Valid values are `^[0-9]{5}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this reimbursement policy record was first created in the system. Supports audit trail requirements and policy lifecycle tracking.',
    `data_quality_score` STRING COMMENT 'Computed data-quality score for ECM scoring.',
    `denial_reason_code` STRING COMMENT 'CARC (Claim Adjustment Reason Code) or RARC (Remittance Advice Remark Code) applied to claims denied or reduced under this policy. Populated on the 835 ERA transaction to communicate the adjudication outcome to providers. Aligns with HIPAA-mandated reason codes.',
    `diagnosis_code_required` BOOLEAN COMMENT 'Indicates whether a specific ICD diagnosis code must be present on the claim for this reimbursement policy to apply. When True, the adjudication engine validates the presence of qualifying diagnosis codes before applying the policy.',
    `effective_date` DATE COMMENT 'Date on which the reimbursement policy becomes effective and is applied to claims adjudication. Claims with service dates on or after this date are subject to the policy rules.',
    `effective_end_date` DATE COMMENT 'Effective end of the record validity window.',
    `effective_start_date` DATE COMMENT 'Effective start of the record validity window.',
    `eob_message_code` STRING COMMENT 'Code referencing the EOB message displayed to members when a claim is adjusted or denied under this reimbursement policy. Ensures member-facing communications are clear and compliant with ACA transparency requirements.',
    `facets_policy_code` STRING COMMENT 'System-specific policy code as configured in the Facets or QNXT core administration platform. Used to map this Silver Layer record back to the source adjudication system configuration for reconciliation and troubleshooting.',
    `fhir_last_updated` TIMESTAMP COMMENT 'FHIR meta.lastUpdated for resource versioning',
    `fhir_profile_url` STRING COMMENT 'Canonical FHIR/US Core profile URL this record conforms to',
    `fhir_resource_reference` STRING COMMENT 'Stable FHIR logical resource id for interop exchange',
    `fhir_resource_type` STRING COMMENT 'FHIR resource type this record maps to for interoperability (default: Coverage)',
    `fhir_version_code` STRING COMMENT 'FHIR meta.versionId optimistic concurrency token',
    `global_surgery_period_days` STRING COMMENT 'Number of days in the global surgery package period during which related pre-operative and post-operative services are bundled into the surgical reimbursement. Standard CMS values are 0, 10, or 90 days. Applies only to global surgery policy types.',
    `icd_version` STRING COMMENT 'Version of the ICD diagnosis/procedure code set applicable to this reimbursement policy when diagnosis-based adjudication rules are enforced. Ensures correct code set is applied during claims processing.. Valid values are `ICD-10|ICD-11`',
    `is_active` BOOLEAN COMMENT 'Logical active flag for soft-delete and current-state filtering.',
    `lob` STRING COMMENT 'Line of Business to which this reimbursement policy applies (e.g., Commercial, Medicare Advantage, Medicaid). Determines which claims populations are subject to this policy during adjudication. A policy may be LOB-specific or apply across multiple LOBs.. Valid values are `commercial|medicare_advantage|medicaid|marketplace|fehb|tricare`',
    `master_entity_reference` STRING COMMENT 'Cross-domain master/golden entity key for SSOT resolution.',
    `max_procedures_allowed` STRING COMMENT 'Maximum number of procedures that can be reimbursed under this policy in a single claim or service encounter. Procedures exceeding this limit are denied or reduced per adjudication rules. Null indicates no limit.',
    `modifier_code` STRING COMMENT 'CPT or HCPCS modifier code associated with this reimbursement policy (e.g., 50=Bilateral, 51=Multiple Procedures, 80=Assistant Surgeon, 62=Two Surgeons). Triggers or qualifies the policy application during claims adjudication.. Valid values are `^[A-Z0-9]{2}$`',
    `ncci_edit_type` STRING COMMENT 'Indicates the NCCI edit category applicable to this reimbursement policy. Column 1/Column 2 edits identify procedure code pairs where one code is a component of another. Mutually exclusive edits identify code pairs that cannot be billed together. Used for unbundling policy enforcement.. Valid values are `column_1|column_2|mutually_exclusive|not_applicable`',
    `network_tier` STRING COMMENT 'Provider network tier to which this reimbursement policy applies. Policies may differ between in-network and out-of-network providers, or across tiered network structures (e.g., Tier 1 preferred, Tier 2 standard). Null indicates the policy applies across all network tiers.. Valid values are `in_network|out_of_network|tiered_1|tiered_2|tiered_3`',
    `override_allowed` BOOLEAN COMMENT 'Indicates whether a manual override of this reimbursement policy is permitted during claims adjudication (e.g., by a claims examiner or medical reviewer). When True, authorized users may bypass the policy with documented justification.',
    `override_requires_auth` BOOLEAN COMMENT 'Indicates whether overriding this reimbursement policy requires a prior authorization (PA) or supervisory approval. When True, an authorization reference must be documented before the override is accepted in Facets/QNXT.',
    `payment_methodology` STRING COMMENT 'Reimbursement payment methodology under which this policy operates. Determines the base payment structure to which the policy rules are applied (e.g., fee-for-service rate reduction, bundled payment adjustment).. Valid values are `fee_for_service|capitation|bundled_payment|per_diem|case_rate`',
    `place_of_service_code` STRING COMMENT 'CMS-defined two-digit Place of Service code indicating the setting where services are rendered (e.g., 11=Office, 21=Inpatient Hospital, 22=Outpatient Hospital). Used for place-of-service differential policies to apply site-of-service payment adjustments. Null if the policy applies regardless of setting.',
    `policy_description` STRING COMMENT 'Detailed narrative description of the reimbursement policy, including the business rationale, adjudication logic, and any exceptions or special conditions. Used for provider communications, EOB narratives, and internal training documentation.',
    `policy_name` STRING COMMENT 'Human-readable name or title of the reimbursement policy (e.g., Multiple Procedure Reduction Policy, Bilateral Procedure Policy). Used in provider communications, EOB narratives, and adjudication configuration.',
    `policy_number` STRING COMMENT 'Externally-known alphanumeric identifier for the reimbursement policy as referenced in Facets/QNXT and communicated to providers. Used for cross-system reconciliation and provider inquiries.',
    `policy_source` STRING COMMENT 'Originating authority or source that defines this reimbursement policy. Distinguishes between federally mandated policies (CMS NCCI, MPPR), AMA CPT guidelines, state-mandated rules, and internally plan-defined or contract-specific policies.. Valid values are `cms_ncci|cms_mppr|ama_cpt|plan_defined|state_mandate|contract_specific`',
    `policy_status` STRING COMMENT 'Current lifecycle state of the reimbursement policy. Controls whether the policy is applied during claims adjudication in Facets/QNXT. Active policies are enforced; retired policies are retained for historical adjudication reference.. Valid values are `active|inactive|pending|suspended|retired`',
    `policy_type` STRING COMMENT 'Categorical classification of the reimbursement policy governing how claims are adjudicated. Drives the adjudication logic applied in Facets/QNXT. [ENUM-REF-CANDIDATE: multiple_procedure_reduction|bilateral_procedure|assistant_surgeon|global_surgery|unbundling|place_of_service_differential|anesthesia|assistant_at_surgery|co_surgery|team_surgery|modifier_impact|site_of_service — promote to reference product]. Valid values are `multiple_procedure_reduction|bilateral_procedure|assistant_surgeon|global_surgery|unbundling|place_of_service_differential`',
    `policy_version` STRING COMMENT 'Version identifier for this reimbursement policy, incremented when the policy terms are amended (e.g., 1.0, 2.3). Supports policy lifecycle management and historical adjudication audits by identifying which version was active at a given service date.',
    `primary_procedure_rank` STRING COMMENT 'Ranking order used to determine which procedure is designated as the primary (highest-paid) procedure when multiple procedures are performed. The procedure with rank 1 is reimbursed at 100%; subsequent ranks receive the reduction percentage. Applies to multiple procedure reduction policies.',
    `provider_specialty_code` STRING COMMENT 'CMS or NUCC provider specialty code restricting this reimbursement policy to a specific provider specialty (e.g., 02=General Surgery, 93=Radiation Oncology). Null indicates the policy applies to all specialties. Used for specialty-specific reimbursement rules.',
    `record_created_at` TIMESTAMP COMMENT 'Timestamp the record was created (audit lineage).',
    `record_source_system` STRING COMMENT 'System of record / source system that produced this record (SSOT provenance).',
    `record_status` STRING COMMENT 'Standard ECM audit/governance attribute record_status.',
    `record_updated_at` TIMESTAMP COMMENT 'Timestamp the record was last updated (audit lineage).',
    `record_version` STRING COMMENT 'Optimistic-concurrency / change version of the record.',
    `reduction_pct` DECIMAL(18,2) COMMENT 'Percentage by which the allowed amount is reduced when this policy is triggered during claims adjudication. For example, a value of 50.00 indicates the secondary procedure is reimbursed at 50% of the contracted rate. Applies to policies such as multiple procedure reduction and assistant surgeon.',
    `regulatory_mandate_flag` BOOLEAN COMMENT 'Indicates whether this reimbursement policy is mandated by a federal or state regulatory authority (e.g., CMS NCCI edits, state prompt payment laws). Regulatory mandate policies cannot be waived or overridden without regulatory approval.',
    `regulatory_reference` STRING COMMENT 'Citation to the specific regulatory rule, CMS manual chapter, state statute, or contractual clause that mandates or governs this reimbursement policy (e.g., CMS NCCI Chapter 4, Section 4.2, 42 CFR 422.520). Populated when regulatory_mandate_flag is True.',
    `retroactive_adjustment_allowed` BOOLEAN COMMENT 'Indicates whether this reimbursement policy can be applied retroactively to previously adjudicated claims when the policy is newly activated or amended. When True, claims reprocessing may be triggered for the applicable service date range.',
    `revenue_code_range_end` STRING COMMENT 'Ending UB-04 revenue code in the range to which this reimbursement policy applies for facility claims. Used in conjunction with revenue_code_range_start to define applicable revenue code ranges for institutional claim adjudication.. Valid values are `^[0-9]{4}$`',
    `revenue_code_range_start` STRING COMMENT 'Starting UB-04 revenue code in the range to which this reimbursement policy applies for facility claims. Used in conjunction with revenue_code_range_end to define applicable revenue code ranges for institutional claim adjudication.. Valid values are `^[0-9]{4}$`',
    `termination_date` DATE COMMENT 'Date on which the reimbursement policy expires and is no longer applied to new claims. Null indicates an open-ended policy with no defined end date. Claims with service dates after this date are not subject to this policy.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this reimbursement policy record was last modified. Used for change data capture (CDC) in the Databricks Silver Layer pipeline and for audit trail compliance.',
    CONSTRAINT pk_reimbursement_policy PRIMARY KEY(`reimbursement_policy_id`)
) COMMENT 'Defines payer reimbursement policies that govern how claims are adjudicated against contracted rates. Captures policy type (multiple procedure reduction, bilateral procedure, assistant surgeon, global surgery, unbundling rules, place-of-service differential), applicable CPT/HCPCS ranges, reduction percentage, effective date, and LOB applicability. Bridges contract terms to claims adjudication logic in Facets/QNXT.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`contract`.`service_scope` (
    `service_scope_id` BIGINT COMMENT 'Unique identifier for the service scope record. Primary key.',
    `provider_contract_id` BIGINT COMMENT 'Reference to the parent provider contract under which this service scope is defined.',
    `fee_schedule_id` BIGINT COMMENT 'Reference to the specific fee schedule that governs reimbursement rates for services within this scope.',
    `provider_id` BIGINT COMMENT 'Reference to the provider to whom this service scope applies.',
    `superseded_by_service_scope_id` BIGINT COMMENT 'Reference to the service scope record that supersedes this one, used to maintain historical lineage when scope definitions are updated or replaced.',
    `approval_date` DATE COMMENT 'Date when this service scope definition was formally approved and authorized for use in claims adjudication.',
    `approved_by` STRING COMMENT 'Name or identifier of the individual or role who approved this service scope definition for inclusion in the contract.',
    `carve_out_indicator` BOOLEAN COMMENT 'Boolean flag indicating whether this service scope represents a carve-out arrangement where specific services are managed or reimbursed separately from the main contract (e.g., behavioral health carve-out, pharmacy carve-out).',
    `coordination_of_benefits_applicable` BOOLEAN COMMENT 'Boolean flag indicating whether coordination of benefits rules apply when a member has multiple coverage sources for services within this scope.',
    `cpt_code_range_end` STRING COMMENT 'Ending CPT or HCPCS code in the range of procedure codes covered or excluded by this service scope.',
    `cpt_code_range_start` STRING COMMENT 'Starting CPT or HCPCS code in the range of procedure codes covered or excluded by this service scope.',
    `created_timestamp` TIMESTAMP COMMENT 'Standard ECM audit/governance attribute created_timestamp.',
    `data_quality_score` STRING COMMENT 'Computed data-quality score for ECM scoring.',
    `drg_range_end` STRING COMMENT 'Ending DRG code in the range of inpatient diagnosis-related groups covered or excluded by this service scope.',
    `drg_range_start` STRING COMMENT 'Starting DRG code in the range of inpatient diagnosis-related groups covered or excluded by this service scope.',
    `effective_date` DATE COMMENT 'Date when this service scope becomes active and applicable for claims adjudication and reimbursement.',
    `effective_end_date` DATE COMMENT 'Effective end of the record validity window.',
    `effective_start_date` DATE COMMENT 'Effective start of the record validity window.',
    `exclusion_reason` STRING COMMENT 'Business rationale or regulatory reason for excluding specific services from the contract scope (e.g., experimental treatment, non-covered benefit, carved out to specialty vendor).',
    `fhir_last_updated` TIMESTAMP COMMENT 'FHIR meta.lastUpdated for resource versioning',
    `fhir_profile_url` STRING COMMENT 'Canonical FHIR/US Core profile URL this record conforms to',
    `fhir_resource_reference` STRING COMMENT 'Stable FHIR logical resource id for interop exchange',
    `fhir_resource_type` STRING COMMENT 'FHIR resource type this record maps to for interoperability (default: Basic)',
    `fhir_version_code` STRING COMMENT 'FHIR meta.versionId optimistic concurrency token',
    `global_surgery_applicable` BOOLEAN COMMENT 'Boolean flag indicating whether global surgery payment rules apply to surgical procedures within this scope, bundling pre-operative, intra-operative, and post-operative services.',
    `icd_code_range_end` STRING COMMENT 'Ending ICD-10 diagnosis code in the range of diagnoses for which services are covered or excluded under this scope.',
    `icd_code_range_start` STRING COMMENT 'Starting ICD-10 diagnosis code in the range of diagnoses for which services are covered or excluded under this scope.',
    `inclusion_exclusion_flag` STRING COMMENT 'Indicates whether this scope definition specifies services that are included (covered) or excluded (not covered) under the contract.. Valid values are `inclusion|exclusion`',
    `is_active` BOOLEAN COMMENT 'Logical active flag for soft-delete and current-state filtering.',
    `lob` STRING COMMENT 'Line of business to which this service scope applies. Values include commercial, Medicare Advantage, Medicaid, ACA Exchange, Administrative Services Only (ASO), Third Party Administrator (TPA), and others.. Valid values are `commercial|medicare|medicaid|exchange|aso|tpa`',
    `master_entity_reference` STRING COMMENT 'Cross-domain master/golden entity key for SSOT resolution.',
    `medicare_crossover_applicable` BOOLEAN COMMENT 'Boolean flag indicating whether Medicare crossover claims processing applies for dual-eligible members receiving services within this scope.',
    `modifier_applicable` BOOLEAN COMMENT 'Boolean flag indicating whether CPT or HCPCS modifiers are applicable and affect reimbursement for services within this scope.',
    `network_tier` STRING COMMENT 'Network tier designation indicating the level of provider participation and member cost-sharing applicable to services within this scope.. Valid values are `tier_1|tier_2|tier_3|out_of_network|preferred|standard`',
    `payment_methodology` STRING COMMENT 'Reimbursement method applicable to services within this scope. Values include fee-for-service, capitation, bundled payments, case rate, per diem, value-based care (VBC), and others.. Valid values are `fee_for_service|capitation|bundled|case_rate|per_diem|vbc`',
    `place_of_service_code` STRING COMMENT 'Two-digit CMS place of service code indicating where the covered or excluded services may be rendered (e.g., 11 for office, 21 for inpatient hospital, 22 for outpatient hospital).',
    `prior_authorization_required` BOOLEAN COMMENT 'Boolean flag indicating whether services within this scope require prior authorization before rendering to be eligible for reimbursement.',
    `record_created_at` TIMESTAMP COMMENT 'Timestamp the record was created (audit lineage).',
    `record_created_timestamp` TIMESTAMP COMMENT 'Timestamp when this service scope record was first created in the data warehouse.',
    `record_source_system` STRING COMMENT 'System of record / source system that produced this record (SSOT provenance).',
    `record_status` STRING COMMENT 'Standard ECM audit/governance attribute record_status.',
    `record_updated_at` TIMESTAMP COMMENT 'Timestamp the record was last updated (audit lineage).',
    `record_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this service scope record was last updated in the data warehouse.',
    `record_version` STRING COMMENT 'Optimistic-concurrency / change version of the record.',
    `referral_required` BOOLEAN COMMENT 'Boolean flag indicating whether a referral from a primary care provider or other designated provider is required for services within this scope.',
    `reimbursement_rate_pct` DECIMAL(18,2) COMMENT 'Percentage of a reference fee schedule (e.g., Medicare, billed charges) used to calculate reimbursement for services within this scope. Applicable when payment methodology is percentage-based.',
    `revenue_code_range_end` STRING COMMENT 'Ending revenue code in the range of institutional billing codes covered or excluded by this service scope.',
    `revenue_code_range_start` STRING COMMENT 'Starting revenue code in the range of institutional billing codes covered or excluded by this service scope.',
    `scope_code` STRING COMMENT 'Unique alphanumeric code identifying this service scope within the contract management system.',
    `scope_description` STRING COMMENT 'Detailed narrative description of the services included or excluded under this scope, including any special conditions, limitations, or clarifications.',
    `scope_name` STRING COMMENT 'Business-friendly name or title for this service scope definition.',
    `scope_status` STRING COMMENT 'Current lifecycle status of the service scope definition.. Valid values are `active|inactive|pending|suspended|terminated|draft`',
    `service_category` STRING COMMENT 'High-level classification of the type of healthcare service covered under this scope. Categories include inpatient, outpatient, professional services, ancillary services, behavioral health, Durable Medical Equipment (DME), Skilled Nursing Facility (SNF), home health, hospice, and emergency services.. Valid values are `inpatient|outpatient|professional|ancillary|behavioral_health|dme`',
    `source_system_code` STRING COMMENT 'Code identifying the operational system of record from which this service scope definition originated (e.g., Facets, QNXT, ProviderSource).',
    `specialty_code` STRING COMMENT 'Provider specialty or taxonomy code to which this service scope applies. Used to limit scope to specific provider types (e.g., cardiology, orthopedics).',
    `stop_loss_applicable` BOOLEAN COMMENT 'Boolean flag indicating whether stop-loss provisions apply to high-cost services within this scope, limiting provider or plan financial exposure.',
    `termination_date` DATE COMMENT 'Date when this service scope ceases to be active. Null indicates open-ended scope.',
    `updated_timestamp` TIMESTAMP COMMENT 'Standard ECM audit/governance attribute updated_timestamp.',
    `version_number` STRING COMMENT 'Version number of this service scope definition, incremented with each amendment or update to track changes over time.',
    CONSTRAINT pk_service_scope PRIMARY KEY(`service_scope_id`)
) COMMENT 'Defines the scope of covered services included or excluded under a specific provider contract. Captures service category (inpatient, outpatient, professional, ancillary, behavioral health, DME, SNF), CPT/HCPCS code ranges, revenue code ranges, DRG ranges, inclusion/exclusion flag, carve-out indicator, and applicable LOB. Determines which services are reimbursable under the contract.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`contract`.`delegation_agreement` (
    `delegation_agreement_id` BIGINT COMMENT 'Unique identifier for the delegation agreement record. Primary key.',
    `provider_contract_id` BIGINT COMMENT 'Reference to the parent provider contract under which this delegation agreement is established.',
    `delegated_entity_id` BIGINT COMMENT 'add column delegated_entity_id (BIGINT) with FK to credential.delegated_entity.delegated_entity_id - delegation agreements are with delegated entities',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Legal delegation requires linking delegating signatory to an employee for signature authority verification.',
    `health_plan_id` BIGINT COMMENT 'Reference to the specific health plan product under which delegation is authorized.',
    `party_id` BIGINT COMMENT 'Identifier of the health plan or entity delegating specific functions to another organization.',
    `provider_network_id` BIGINT COMMENT 'Reference to the provider network associated with this delegation agreement.',
    `superseded_by_delegation_agreement_id` BIGINT COMMENT 'Reference to the new delegation agreement that replaces this one when a new version is executed.',
    `agreement_name` STRING COMMENT 'Descriptive name of the delegation agreement for business reference and reporting.',
    `agreement_number` STRING COMMENT 'Externally-known business identifier for the delegation agreement used in contracts and communications.',
    `agreement_status` STRING COMMENT 'Current lifecycle status of the delegation agreement indicating its operational state.. Valid values are `draft|pending_approval|active|suspended|terminated|expired`',
    `agreement_type` STRING COMMENT 'Classification of the delegation arrangement based on scope and functions delegated.. Valid values are `full_delegation|partial_delegation|administrative_services_only|care_management|utilization_management|claims_payment`',
    `approval_date` DATE COMMENT 'Date when the delegation agreement was formally approved by the delegating entitys governance or compliance committee.',
    `audit_frequency` STRING COMMENT 'Frequency at which the delegating entity conducts audits of the delegates performance and compliance with delegation standards.. Valid values are `monthly|quarterly|semi_annual|annual|biennial|as_needed`',
    `auto_renewal_flag` BOOLEAN COMMENT 'Indicates whether the delegation agreement automatically renews at the end of its term unless terminated by either party.',
    `cms_oversight_required` BOOLEAN COMMENT 'Indicates whether this delegation agreement requires Centers for Medicare and Medicaid Services (CMS) oversight and reporting for Medicare or Medicaid programs.',
    `created_timestamp` TIMESTAMP COMMENT 'Standard ECM audit/governance attribute created_timestamp.',
    `data_quality_score` STRING COMMENT 'Computed data-quality score for ECM scoring.',
    `delegate_signatory_name` STRING COMMENT 'Name of the authorized representative who signed the delegation agreement on behalf of the delegate entity.',
    `delegate_signatory_title` STRING COMMENT 'Title or position of the authorized representative who signed on behalf of the delegate entity.',
    `delegated_function_type` STRING COMMENT 'Specific function or set of functions delegated under this agreement. [ENUM-REF-CANDIDATE: credentialing|recredentialing|utilization_management|prior_authorization|claims_adjudication|claims_payment|member_services|care_management|disease_management|case_management|pharmacy_benefits|provider_network_management|quality_improvement|appeals_grievances — promote to reference product]',
    `delegating_signatory_title` STRING COMMENT 'Title or position of the authorized representative who signed on behalf of the delegating entity.',
    `delegation_scope` STRING COMMENT 'Detailed description of the scope of delegated activities, including specific services, populations, and geographic areas covered.',
    `document_reference` STRING COMMENT 'Reference identifier or file path to the executed delegation agreement document stored in the document management system.',
    `effective_date` DATE COMMENT 'Date when the delegation agreement becomes binding and the delegate entity assumes delegated responsibilities.',
    `effective_end_date` DATE COMMENT 'Effective end of the record validity window.',
    `effective_start_date` DATE COMMENT 'Effective start of the record validity window.',
    `execution_date` DATE COMMENT 'Date when the delegation agreement was signed by all parties and became legally binding.',
    `fhir_last_updated` TIMESTAMP COMMENT 'FHIR meta.lastUpdated for resource versioning',
    `fhir_profile_url` STRING COMMENT 'Canonical FHIR/US Core profile URL this record conforms to',
    `fhir_resource_reference` STRING COMMENT 'Stable FHIR logical resource id for interop exchange',
    `fhir_resource_type` STRING COMMENT 'FHIR resource type this record maps to for interoperability (default: Basic)',
    `fhir_version_code` STRING COMMENT 'FHIR meta.versionId optimistic concurrency token',
    `financial_arrangement_type` STRING COMMENT 'Type of financial arrangement governing payment to the delegate entity for delegated functions.. Valid values are `capitation|fee_for_service|shared_savings|bundled_payment|case_rate|per_diem`',
    `internal_notes` STRING COMMENT 'Internal notes and comments regarding the delegation agreement for operational reference and compliance tracking.',
    `is_active` BOOLEAN COMMENT 'Logical active flag for soft-delete and current-state filtering.',
    `last_audit_date` DATE COMMENT 'Date of the most recent delegation audit conducted by the delegating entity.',
    `lob_code` STRING COMMENT 'Line of business to which this delegation agreement applies, indicating the member population covered.. Valid values are `commercial|medicare|medicaid|marketplace|dual_eligible|chip`',
    `master_entity_reference` STRING COMMENT 'Cross-domain master/golden entity key for SSOT resolution.',
    `ncqa_compliance_flag` BOOLEAN COMMENT 'Indicates whether this delegation agreement meets National Committee for Quality Assurance (NCQA) delegation standards required for health plan accreditation.',
    `next_audit_due_date` DATE COMMENT 'Scheduled date for the next delegation audit to ensure ongoing compliance and performance monitoring.',
    `oversight_requirement` STRING COMMENT 'Detailed description of the delegating entitys oversight responsibilities, monitoring activities, and reporting requirements for the delegate.',
    `performance_standard` STRING COMMENT 'Documented performance standards and quality metrics that the delegate entity must meet, including Healthcare Effectiveness Data and Information Set (HEDIS) measures, turnaround times, and accuracy thresholds.',
    `record_created_at` TIMESTAMP COMMENT 'Timestamp the record was created (audit lineage).',
    `record_created_timestamp` TIMESTAMP COMMENT 'Timestamp when this delegation agreement record was first created in the system.',
    `record_source_system` STRING COMMENT 'System of record / source system that produced this record (SSOT provenance).',
    `record_status` STRING COMMENT 'Standard ECM audit/governance attribute record_status.',
    `record_updated_at` TIMESTAMP COMMENT 'Timestamp the record was last updated (audit lineage).',
    `record_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this delegation agreement record was last modified in the system.',
    `record_version` STRING COMMENT 'Optimistic-concurrency / change version of the record.',
    `regulatory_filing_date` DATE COMMENT 'Date when the delegation agreement was filed with the applicable regulatory authority.',
    `regulatory_filing_required` BOOLEAN COMMENT 'Indicates whether this delegation agreement must be filed with state Department of Insurance (DOI) or other regulatory bodies.',
    `risk_share_applicable` BOOLEAN COMMENT 'Indicates whether the delegation agreement includes risk-sharing arrangements between the delegating entity and delegate.',
    `termination_date` DATE COMMENT 'Date when the delegation agreement ends and delegated functions revert to the delegating entity. Nullable for open-ended agreements.',
    `termination_notice_days` STRING COMMENT 'Number of days advance notice required by either party to terminate the delegation agreement.',
    `termination_reason` STRING COMMENT 'Documented reason for termination of the delegation agreement, including performance issues, regulatory non-compliance, or mutual agreement.',
    `updated_timestamp` TIMESTAMP COMMENT 'Standard ECM audit/governance attribute updated_timestamp.',
    `urac_compliance_flag` BOOLEAN COMMENT 'Indicates whether this delegation agreement meets URAC delegation standards for health care accreditation.',
    `version_number` STRING COMMENT 'Version number of the delegation agreement to track amendments and revisions over time.',
    CONSTRAINT pk_delegation_agreement PRIMARY KEY(`delegation_agreement_id`)
) COMMENT 'Manages delegation agreements where the health plan delegates specific functions (credentialing, UM, claims payment, member services) to an IPA, ACO, TPA, or medical group. Captures delegated function type, delegating entity, delegate entity, oversight requirements, audit frequency, performance standards, NCQA/URAC delegation standards compliance, and delegation effective dates. Required for NCQA accreditation and CMS oversight.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`contract`.`incentive_arrangement` (
    `incentive_arrangement_id` BIGINT COMMENT 'Unique identifier for the performance-linked financial arrangement within a provider contract. Primary key.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Links incentive arrangement approvals to the approving employee; required for incentive payout validation and reporting.',
    `provider_contract_id` BIGINT COMMENT 'Reference to the parent provider contract under which this incentive arrangement is established.',
    `provider_id` BIGINT COMMENT 'Reference to the provider or provider group participating in this incentive arrangement.',
    `aco_arrangement_flag` BOOLEAN COMMENT 'Boolean flag indicating whether this incentive arrangement is part of an ACO agreement with shared savings and shared loss provisions.',
    `amendment_number` STRING COMMENT 'Reference to the contract amendment that introduced or modified this incentive arrangement, if applicable.',
    `amount_forfeited` DECIMAL(18,2) COMMENT 'Dollar amount of withheld funds forfeited by the provider due to failure to meet performance criteria. Expressed in USD.',
    `amount_released` DECIMAL(18,2) COMMENT 'Dollar amount of withheld funds released back to the provider upon meeting performance criteria. Expressed in USD.',
    `approval_date` DATE COMMENT 'Date when the incentive arrangement was formally approved by authorized parties within the health plan.',
    `arrangement_name` STRING COMMENT 'Descriptive name of the incentive arrangement for business identification and reporting purposes.',
    `arrangement_number` STRING COMMENT 'Business-assigned unique identifier for the incentive arrangement, used for external reference and reporting.',
    `arrangement_status` STRING COMMENT 'Current lifecycle status of the incentive arrangement indicating whether it is active, pending approval, suspended, terminated, or fully settled.. Valid values are `active|inactive|pending|suspended|terminated|settled`',
    `arrangement_type` STRING COMMENT 'Classification of the incentive arrangement structure. Defines whether the arrangement is a bonus, withhold, shared savings distribution, performance guarantee, or penalty mechanism.. Valid values are `pay_for_performance|quality_withhold|risk_withhold|shared_savings|performance_guarantee|penalty`',
    `created_timestamp` TIMESTAMP COMMENT 'Standard ECM audit/governance attribute created_timestamp.',
    `data_quality_score` STRING COMMENT 'Computed data-quality score for ECM scoring.',
    `earned_status` STRING COMMENT 'Indicates whether the provider has earned the incentive or withhold release based on performance evaluation results.. Valid values are `earned|not_earned|partially_earned|pending_review`',
    `effective_date` DATE COMMENT 'Date when the incentive arrangement becomes active and performance measurement begins.',
    `effective_end_date` DATE COMMENT 'Effective end of the record validity window.',
    `effective_start_date` DATE COMMENT 'Effective start of the record validity window.',
    `fhir_last_updated` TIMESTAMP COMMENT 'FHIR meta.lastUpdated for resource versioning',
    `fhir_profile_url` STRING COMMENT 'Canonical FHIR/US Core profile URL this record conforms to',
    `fhir_resource_reference` STRING COMMENT 'Stable FHIR logical resource id for interop exchange',
    `fhir_resource_type` STRING COMMENT 'FHIR resource type this record maps to for interoperability (default: Basic)',
    `fhir_version_code` STRING COMMENT 'FHIR meta.versionId optimistic concurrency token',
    `is_active` BOOLEAN COMMENT 'Logical active flag for soft-delete and current-state filtering.',
    `lob_code` STRING COMMENT 'Code identifying the line of business (Commercial, Medicare, Medicaid, Exchange) to which this incentive arrangement applies.',
    `master_entity_reference` STRING COMMENT 'Cross-domain master/golden entity key for SSOT resolution.',
    `maximum_incentive_amount` DECIMAL(18,2) COMMENT 'Maximum financial incentive or bonus amount that can be earned by the provider under this arrangement. Expressed in USD.',
    `maximum_penalty_amount` DECIMAL(18,2) COMMENT 'Maximum financial penalty that can be assessed against the provider for non-performance under this arrangement. Expressed in USD.',
    `measurement_methodology` STRING COMMENT 'Detailed description of how the target metric is calculated, including data sources, calculation formulas, exclusions, and measurement period definitions.',
    `measurement_period_end` DATE COMMENT 'End date of the performance measurement period during which provider performance is evaluated against target metrics.',
    `measurement_period_start` DATE COMMENT 'Start date of the performance measurement period during which provider performance is evaluated against target metrics.',
    `payout_schedule` STRING COMMENT 'Frequency at which incentive payments or withhold releases are distributed to the provider.. Valid values are `monthly|quarterly|semi_annual|annual|upon_settlement`',
    `performance_threshold_tier` STRING COMMENT 'Tiered performance level definition (e.g., bronze, silver, gold, platinum) that determines incentive payout or withhold release amounts.',
    `performance_year` STRING COMMENT 'Calendar year or contract year during which performance is measured for this incentive arrangement.',
    `quality_gate_met` BOOLEAN COMMENT 'Boolean flag indicating whether the provider met the minimum quality threshold required for incentive payout or withhold release.',
    `quality_measure_set` STRING COMMENT 'Identifies the quality measure framework used for performance evaluation (HEDIS, STAR, CAHPS, custom measures).',
    `quality_score` DECIMAL(18,2) COMMENT 'Composite quality performance score achieved by the provider during the measurement period, expressed as a percentage or index value.',
    `record_created_at` TIMESTAMP COMMENT 'Timestamp the record was created (audit lineage).',
    `record_created_timestamp` TIMESTAMP COMMENT 'Timestamp when this incentive arrangement record was first created in the system.',
    `record_source_system` STRING COMMENT 'System of record / source system that produced this record (SSOT provenance).',
    `record_status` STRING COMMENT 'Standard ECM audit/governance attribute record_status.',
    `record_updated_at` TIMESTAMP COMMENT 'Timestamp the record was last updated (audit lineage).',
    `record_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this incentive arrangement record was last modified in the system.',
    `record_version` STRING COMMENT 'Optimistic-concurrency / change version of the record.',
    `reporting_frequency` STRING COMMENT 'Frequency at which performance reports are generated and shared with the provider for transparency and tracking purposes.. Valid values are `monthly|quarterly|semi_annual|annual`',
    `settlement_date` DATE COMMENT 'Date when the final financial settlement of the incentive arrangement is completed and all payments or forfeitures are processed.',
    `shared_loss_rate` DECIMAL(18,2) COMMENT 'Percentage of cost overruns that will be shared by the provider under a shared risk arrangement. Expressed as a decimal (e.g., 50.00 for 50%).',
    `shared_savings_rate` DECIMAL(18,2) COMMENT 'Percentage of cost savings that will be shared with the provider under a shared savings arrangement. Expressed as a decimal (e.g., 50.00 for 50%).',
    `sla_commitment` STRING COMMENT 'Specific service level agreement commitments that the provider must meet as part of this incentive arrangement (e.g., appointment availability, response time, member satisfaction).',
    `target_metric` STRING COMMENT 'Specific performance metric or key performance indicator (KPI) that the provider must achieve (e.g., readmission rate, preventive care completion, cost per member per month).',
    `termination_date` DATE COMMENT 'Date when the incentive arrangement ends and performance measurement ceases. Nullable for open-ended arrangements.',
    `total_withheld_amount` DECIMAL(18,2) COMMENT 'Total dollar amount withheld from provider reimbursement during the measurement period. Expressed in USD.',
    `updated_timestamp` TIMESTAMP COMMENT 'Standard ECM audit/governance attribute updated_timestamp.',
    `vbc_program_name` STRING COMMENT 'Name of the value-based care program under which this incentive arrangement is established (e.g., Medicare Shared Savings Program, Commercial Quality Incentive Program).',
    `withhold_percentage` DECIMAL(18,2) COMMENT 'Percentage of provider reimbursement withheld for quality, utilization, or risk-sharing purposes. Expressed as a decimal (e.g., 5.00 for 5%).',
    `withhold_pool_type` STRING COMMENT 'Classification of the withhold pool indicating whether it is for quality performance, utilization management, risk-sharing, or a combined pool.. Valid values are `quality|utilization|risk_sharing|combined`',
    `withhold_release_criteria` STRING COMMENT 'Business rules and conditions that must be met for withheld amounts to be released to the provider (quality gates, utilization targets, shared risk thresholds).',
    CONSTRAINT pk_incentive_arrangement PRIMARY KEY(`incentive_arrangement_id`)
) COMMENT 'Unified record for all performance-linked financial arrangements within provider contracts — including pay-for-performance (P4P) bonuses, quality withholds, risk withholds, shared savings distributions, performance guarantees, SLA commitments, and penalty/incentive structures. Captures arrangement type (bonus, withhold, shared savings, performance guarantee, penalty, SLA), quality measure set (HEDIS, STAR, CAHPS, custom), performance threshold tiers, withhold percentage and release criteria (quality, utilization, shared risk), withhold pool type, target metric and measurement methodology, maximum incentive or penalty amount, total withheld amount, amount released, amount forfeited, measurement period, payout schedule, earned/forfeited status, settlement date, and reporting frequency. Supports VBC quality gate enforcement, HMO/IPA withhold models, pay-for-performance programs, and provider engagement programs. SSOT for all performance-linked financial commitments in provider contracts.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`contract`.`contract_network_participation` (
    `contract_network_participation_id` BIGINT COMMENT 'Unique identifier for the network participation record. Primary key for this entity.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Tracks which employee approved network participation changes; needed for network governance and audit trails.',
    `provider_contract_id` BIGINT COMMENT 'Reference to the provider contract that governs this network participation arrangement.',
    `provider_id` BIGINT COMMENT 'Reference to the healthcare provider participating in this network arrangement.',
    `provider_network_id` BIGINT COMMENT 'Reference to the specific provider network configuration that this participation covers.',
    `record_id` BIGINT COMMENT 'Foreign key linking to credential.credential_record. Business justification: Network participation eligibility is based on a specific credential record; linking allows verification, reporting, and re‑credentialing triggers for network members.',
    `accepting_new_patients_flag` BOOLEAN COMMENT 'Indicator whether the provider is currently accepting new patient enrollments under this network participation arrangement.',
    `aco_participant_flag` BOOLEAN COMMENT 'Boolean indicator whether this provider participates in an ACO arrangement under this network participation for value-based care programs.',
    `amendment_number` STRING COMMENT 'Reference to the contract amendment that established or modified this network participation arrangement.',
    `approval_date` DATE COMMENT 'Date when this network participation arrangement was formally approved by authorized plan personnel.',
    `auto_renewal_flag` BOOLEAN COMMENT 'Boolean indicator whether this network participation automatically renews at the end of the term unless either party provides termination notice.',
    `claims_adjudication_priority` STRING COMMENT 'Numeric priority ranking used by claims processing systems when multiple network participations exist for the same provider, with lower numbers indicating higher priority.',
    `created_timestamp` TIMESTAMP COMMENT 'Standard ECM audit/governance attribute created_timestamp.',
    `credentialing_date` DATE COMMENT 'Date when the provider was most recently credentialed or re-credentialed for participation in this network.',
    `credentialing_status` STRING COMMENT 'Current credentialing verification status of the provider for this network participation, ensuring compliance with quality and safety standards.. Valid values are `credentialed|pending|expired|suspended|revoked`',
    `data_quality_score` STRING COMMENT 'Computed data-quality score for ECM scoring.',
    `directory_publication_flag` BOOLEAN COMMENT 'Boolean indicator whether this network participation should be published in member-facing provider directories and online search tools.',
    `effective_date` DATE COMMENT 'Date when the providers participation in this network configuration becomes active and binding for claims adjudication and directory publication.',
    `effective_end_date` DATE COMMENT 'Effective end of the record validity window.',
    `effective_start_date` DATE COMMENT 'Effective start of the record validity window.',
    `fhir_last_updated` TIMESTAMP COMMENT 'FHIR meta.lastUpdated for resource versioning',
    `fhir_profile_url` STRING COMMENT 'Canonical FHIR/US Core profile URL this record conforms to',
    `fhir_resource_reference` STRING COMMENT 'Stable FHIR logical resource id for interop exchange',
    `fhir_resource_type` STRING COMMENT 'FHIR resource type this record maps to for interoperability (default: Organization)',
    `fhir_version_code` STRING COMMENT 'FHIR meta.versionId optimistic concurrency token',
    `geographic_service_area` STRING COMMENT 'Geographic region or service area where this network participation is valid, typically defined by state, county, or ZIP code ranges.',
    `in_network_flag` BOOLEAN COMMENT 'Boolean indicator whether this provider is considered in-network for claims adjudication and member cost-sharing calculations.',
    `is_active` BOOLEAN COMMENT 'Logical active flag for soft-delete and current-state filtering.',
    `lob` STRING COMMENT 'Product line or market segment that this network participation applies to, determining regulatory requirements and benefit structures.. Valid values are `commercial|medicare_advantage|medicaid|exchange|qhp|dual_eligible`',
    `master_entity_reference` STRING COMMENT 'Cross-domain master/golden entity key for SSOT resolution.',
    `network_tier` STRING COMMENT 'Tiering classification that determines member cost-sharing levels and provider reimbursement rates. Tier 1 typically represents highest value providers with lowest member cost-sharing.. Valid values are `tier_1|tier_2|preferred|standard|narrow|exclusive`',
    `out_of_network_flag` BOOLEAN COMMENT 'Boolean indicator whether this provider arrangement allows out-of-network benefits and reimbursement under specific circumstances.',
    `participation_number` STRING COMMENT 'Business identifier for this network participation arrangement, used for operational reference and tracking.',
    `participation_status` STRING COMMENT 'Current lifecycle status of the network participation arrangement indicating whether the provider is actively participating in the network.. Valid values are `active|pending|suspended|terminated|inactive`',
    `pcp_assignment_eligible_flag` BOOLEAN COMMENT 'Boolean indicator whether this provider can be assigned as a Primary Care Physician for members in HMO or POS plans requiring PCP selection.',
    `prior_authorization_required_flag` BOOLEAN COMMENT 'Indicator whether services from this provider under this network arrangement require prior authorization for coverage and payment.',
    `product_line` STRING COMMENT 'Health plan product type that this network participation covers, defining network access rules and referral requirements.. Valid values are `hmo|ppo|epo|pos|hdhp|indemnity`',
    `quality_tier_designation` STRING COMMENT 'Quality performance tier assigned to this provider based on HEDIS, STAR, or other quality metrics, influencing network tier placement and incentives.. Valid values are `platinum|gold|silver|bronze|standard|not_rated`',
    `record_created_at` TIMESTAMP COMMENT 'Timestamp the record was created (audit lineage).',
    `record_created_timestamp` TIMESTAMP COMMENT 'Timestamp when this network participation record was first created in the data platform, supporting audit trail and data lineage requirements.',
    `record_source_system` STRING COMMENT 'System of record / source system that produced this record (SSOT provenance).',
    `record_status` STRING COMMENT 'Standard ECM audit/governance attribute record_status.',
    `record_updated_at` TIMESTAMP COMMENT 'Timestamp the record was last updated (audit lineage).',
    `record_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this network participation record was most recently modified in the data platform, supporting change tracking and audit requirements.',
    `record_version` STRING COMMENT 'Optimistic-concurrency / change version of the record.',
    `recredentialing_due_date` DATE COMMENT 'Date when the providers credentials must be reverified to maintain active network participation status.',
    `referral_required_flag` BOOLEAN COMMENT 'Indicator whether members must obtain a referral from their PCP to access this provider under the network participation terms.',
    `risk_share_percentage` DECIMAL(18,2) COMMENT 'Percentage of financial risk shared between the health plan and provider under value-based care arrangements for this network participation.',
    `service_area_county` STRING COMMENT 'County name or FIPS code defining the local geographic area covered by this network participation arrangement.',
    `service_area_state` STRING COMMENT 'Two-letter state code identifying the primary state where this network participation applies for regulatory and directory purposes.',
    `service_area_zip_codes` STRING COMMENT 'Comma-separated list or range of ZIP codes where this network participation is valid for member access and claims processing.',
    `source_system_code` STRING COMMENT '',
    `source_system_record_reference` STRING COMMENT 'Unique identifier for this network participation record in the source operational system, used for data lineage and reconciliation.',
    `telehealth_eligible_flag` BOOLEAN COMMENT 'Indicator whether this provider is eligible to deliver covered telehealth or virtual care services under this network participation.',
    `termination_date` DATE COMMENT 'Date when the providers participation in this network ends. Null indicates open-ended participation with no scheduled termination.',
    `termination_notice_days` STRING COMMENT 'Number of days advance notice required for termination of this network participation per contractual terms.',
    `termination_reason` STRING COMMENT 'Business reason or cause for termination of this network participation arrangement, such as contract expiration, quality issues, or provider request.',
    `updated_timestamp` TIMESTAMP COMMENT 'Standard ECM audit/governance attribute updated_timestamp.',
    `vbc_arrangement_type` STRING COMMENT 'Type of value-based care or alternative payment model applied to this network participation, defining financial incentive structure.. Valid values are `fee_for_service|shared_savings|shared_risk|capitation|bundled_payment|none`',
    `version_number` STRING COMMENT '',
    CONSTRAINT pk_contract_network_participation PRIMARY KEY(`contract_network_participation_id`)
) COMMENT 'Association entity linking a provider contract to specific network configurations, defining which provider networks the contract covers. Captures network ID reference, participation tier (tier 1, tier 2, preferred, standard, narrow), in-network effective and termination dates, out-of-network flag, geographic service area, product line applicability (commercial, Medicare Advantage, Medicaid, exchange/QHP), and participation status (active, pending, terminated). Bridges the contract domain to the network domain for directory accuracy and claims adjudication network matching.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`contract`.`financial_summary` (
    `financial_summary_id` BIGINT COMMENT 'System-generated unique identifier for the financial summary record.',
    `capitation_arrangement_id` BIGINT COMMENT '',
    `provider_contract_id` BIGINT COMMENT 'Identifier of the provider contract to which this financial summary belongs.',
    `cost_center_id` BIGINT COMMENT '',
    `ledger_id` BIGINT COMMENT '',
    `parent_financial_summary_id` BIGINT COMMENT 'Self-referencing FK on financial_summary (parent_financial_summary_id)',
    `provider_id` BIGINT COMMENT '',
    `attributed_member_count` STRING COMMENT '',
    `capitation_accrual_balance` DECIMAL(18,2) COMMENT 'Outstanding capitation accruals that have been earned but not yet paid.',
    `claim_count` STRING COMMENT '',
    `contract_number` STRING COMMENT 'External contract reference number assigned by the health plan.',
    `contract_type` STRING COMMENT 'Classification of the contract payment model.. Valid values are `fee_for_service|capitation|bundled|value_based|shared_savings|risk_sharing`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the financial summary record was first created in the lakehouse.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for monetary amounts.. Valid values are `^[A-Z]{3}$`',
    `data_quality_score` STRING COMMENT 'Computed data-quality score for ECM scoring.',
    `effective_date` DATE COMMENT 'Date the contract becomes legally binding.',
    `effective_end_date` DATE COMMENT 'Effective end of the record validity window.',
    `effective_start_date` DATE COMMENT 'Effective start of the record validity window.',
    `fhir_last_updated` TIMESTAMP COMMENT 'FHIR meta.lastUpdated for resource versioning',
    `fhir_profile_url` STRING COMMENT 'Canonical FHIR/US Core profile URL this record conforms to',
    `fhir_resource_reference` STRING COMMENT 'Stable FHIR logical resource id for interop exchange',
    `fhir_resource_type` STRING COMMENT 'FHIR resource type this record maps to for interoperability (default: Basic)',
    `fhir_version_code` STRING COMMENT 'FHIR meta.versionId optimistic concurrency token',
    `financial_summary_status` STRING COMMENT 'Current lifecycle status of the contract.. Valid values are `active|inactive|terminated|pending|draft|suspended`',
    `ibnr_estimate_amount` DECIMAL(18,2) COMMENT 'Estimated incurred‑but‑not‑reported liability for the period.',
    `ibnr_reserve_amount` DECIMAL(18,2) COMMENT '',
    `incentive_earned_amount` DECIMAL(18,2) COMMENT 'Monetary incentive earned by the provider based on performance metrics.',
    `is_active` BOOLEAN COMMENT 'Logical active flag for soft-delete and current-state filtering.',
    `lob_code` STRING COMMENT '',
    `master_entity_reference` STRING COMMENT 'Cross-domain master/golden entity key for SSOT resolution.',
    `medical_loss_ratio` DECIMAL(18,2) COMMENT '',
    `mrl_allocation_amount` DECIMAL(18,2) COMMENT 'Portion of the contract spend allocated to the Medical Loss Ratio calculation.',
    `notes` STRING COMMENT 'Free‑form comments or remarks about the financial summary.',
    `payment_methodology` STRING COMMENT 'Primary payment approach used for the contract.. Valid values are `fee_for_service|capitation|bundled|value_based`',
    `performance_year` STRING COMMENT '',
    `pmpm_cost` DECIMAL(18,2) COMMENT '',
    `quality_score` DECIMAL(18,2) COMMENT 'Composite quality performance score used for incentive calculations.',
    `reconciliation_date` DATE COMMENT 'Date the reconciliation was completed.',
    `reconciliation_status` STRING COMMENT 'Current status of the financial reconciliation process.. Valid values are `reconciled|pending|error|partial|not_applicable`',
    `record_created_at` TIMESTAMP COMMENT 'Timestamp the record was created (audit lineage).',
    `record_created_timestamp` TIMESTAMP COMMENT 'Audit timestamp for when the row was initially loaded into the lakehouse.',
    `record_source_system` STRING COMMENT 'System of record / source system that produced this record (SSOT provenance).',
    `record_status` STRING COMMENT 'Standard ECM audit/governance attribute record_status.',
    `record_updated_at` TIMESTAMP COMMENT 'Timestamp the record was last updated (audit lineage).',
    `record_updated_timestamp` TIMESTAMP COMMENT '',
    `record_version` STRING COMMENT 'Optimistic-concurrency / change version of the record.',
    `reporting_period_end` DATE COMMENT '',
    `reporting_period_start` DATE COMMENT 'add column reporting_period_start, reporting_period_end columns and capitation_arrangement_id (BIGINT) with FK to contract.capitation_arrangement.capitation_arrangement_id - summaries report capitation performance',
    `risk_share_percentage` DECIMAL(18,2) COMMENT 'Percentage of risk shared between the health plan and provider.',
    `source_system_code` STRING COMMENT '',
    `summary_period_end` DATE COMMENT 'Last day of the reporting period covered by this summary.',
    `summary_period_start` DATE COMMENT 'First day of the reporting period covered by this summary.',
    `summary_period_type` STRING COMMENT 'Granularity of the financial aggregation.. Valid values are `month|quarter|year`',
    `summary_status` STRING COMMENT '',
    `termination_date` DATE COMMENT 'Date the contract ends or is scheduled to end; null for open‑ended contracts.',
    `total_allowed_amount` DECIMAL(18,2) COMMENT 'Aggregate allowed charge amount for services under the contract during the period.',
    `total_billed_amount` DECIMAL(18,2) COMMENT '',
    `total_capitation_paid` DECIMAL(18,2) COMMENT '',
    `total_incentive_paid` DECIMAL(18,2) COMMENT '',
    `total_paid_amount` DECIMAL(18,2) COMMENT 'Aggregate amount actually paid to the provider for the period.',
    `total_shared_loss` DECIMAL(18,2) COMMENT '',
    `total_shared_savings` DECIMAL(18,2) COMMENT '',
    `total_withhold_amount` DECIMAL(18,2) COMMENT '',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the financial summary record.',
    `withhold_pool_balance` DECIMAL(18,2) COMMENT 'Amount retained pending quality or performance verification.',
    CONSTRAINT pk_financial_summary PRIMARY KEY(`financial_summary_id`)
) COMMENT 'Contract-level financial summary and accrual tracking record aggregating total contracted spend, paid amounts, outstanding liabilities, capitation accruals, withhold balances, incentive payouts, and reconciliation status for each provider contract by performance period. Captures summary period (month/quarter/year), total allowed amount, total paid amount, capitation accrual balance, withhold pool balance, incentive earned amount, IBNR estimate contribution, and reconciliation status. Supports finance department contract-level P&L reporting, IBNR estimation inputs, total-cost-of-care tracking for VBC contracts, medical loss ratio (MLR) allocation, and regulatory financial reporting. SSOT for contract-level financial position. Links to provider_contract as the parent entity.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`contract`.`obligation` (
    `obligation_id` BIGINT COMMENT '',
    `obligation_type_code` STRING COMMENT '',
    `obligation_status_code` STRING COMMENT '',
    `effective_date` DATE COMMENT '',
    `termination_date` DATE COMMENT '',
    `evidence_reference` STRING COMMENT '',
    CONSTRAINT pk_obligation PRIMARY KEY(`obligation_id`)
) COMMENT 'This association product records the compliance relationship between a provider contract and a regulatory obligation. It captures the compliance status and the effective/termination dates specific to each contract‑obligation pairing.. Existence Justification: Each provider contract must satisfy multiple regulatory obligations (e.g., HIPAA, ACA, state mandates) and each regulatory obligation applies to many provider contracts. The compliance status, effective and termination dates of the obligation for a specific contract are tracked, making the relationship a managed business entity.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`contract`.`party_regulatory_obligation_compliance` (
    `party_regulatory_obligation_compliance_id` BIGINT COMMENT '',
    `party_id` BIGINT COMMENT '',
    `obligation_id` BIGINT COMMENT '',
    `compliance_attestation_id` BIGINT COMMENT '',
    `corrective_action_plan_id` BIGINT COMMENT '',
    `compliance_status_code` STRING COMMENT '',
    `effective_date` DATE COMMENT '',
    `termination_date` DATE COMMENT '',
    `evidence_reference` STRING COMMENT '',
    `last_attested_date` DATE COMMENT '',
    `next_due_date` DATE COMMENT '',
    `evidence_url` STRING COMMENT '',
    `finding_text` STRING COMMENT '',
    CONSTRAINT pk_party_regulatory_obligation_compliance PRIMARY KEY(`party_regulatory_obligation_compliance_id`)
) COMMENT 'Represents the compliance relationship between a contract party and a regulatory obligation. Each record captures the compliance status and the effective/termination dates for that specific party‑obligation pairing.. Existence Justification: Each provider party must satisfy multiple regulatory obligations, and each regulatory obligation applies to many provider parties. The organization tracks compliance status, effective and termination dates for each party‑obligation pair, which is managed as a distinct record.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`contract`.`provider_contract` (
    `provider_contract_id` BIGINT COMMENT 'Primary key for provider_contract',
    `contract_provider_contract_id` BIGINT COMMENT 'SSOT primary key',
    `fee_schedule_id` BIGINT COMMENT 'Fee schedule',
    `health_plan_id` BIGINT COMMENT 'add column health_plan_id (BIGINT) with FK to plan.health_plan.health_plan_id - provider contracts are tied to plans (currently isolated)',
    `provider_id` BIGINT COMMENT 'Contracted provider',
    `provider_provider_id` BIGINT COMMENT '',
    `created_timestamp` TIMESTAMP COMMENT 'Standard ECM audit/governance attribute created_timestamp.',
    `data_quality_score` STRING COMMENT 'Computed data-quality score for ECM scoring.',
    `effective_end_date` DATE COMMENT 'Effective end of the record validity window.',
    `effective_start_date` DATE COMMENT 'Effective start of the record validity window.',
    `fhir_last_updated` TIMESTAMP COMMENT 'FHIR meta.lastUpdated for resource versioning',
    `fhir_profile_url` STRING COMMENT 'Canonical FHIR/US Core profile URL this record conforms to',
    `fhir_resource_reference` STRING COMMENT 'Stable FHIR logical resource id for interop exchange',
    `fhir_resource_type` STRING COMMENT 'FHIR resource type this record maps to for interoperability (default: Practitioner)',
    `fhir_version_code` STRING COMMENT 'FHIR meta.versionId optimistic concurrency token',
    `is_active` BOOLEAN COMMENT 'Logical active flag for soft-delete and current-state filtering.',
    `master_entity_reference` STRING COMMENT 'Cross-domain master/golden entity key for SSOT resolution.',
    `record_created_at` TIMESTAMP COMMENT 'Timestamp the record was created (audit lineage).',
    `record_source_system` STRING COMMENT 'System of record / source system that produced this record (SSOT provenance).',
    `record_status` STRING COMMENT 'Standard ECM audit/governance attribute record_status.',
    `record_updated_at` TIMESTAMP COMMENT 'Timestamp the record was last updated (audit lineage).',
    `record_version` STRING COMMENT 'Optimistic-concurrency / change version of the record.',
    `updated_timestamp` TIMESTAMP COMMENT 'Standard ECM audit/governance attribute updated_timestamp.',
    CONSTRAINT pk_provider_contract PRIMARY KEY(`provider_contract_id`)
) COMMENT 'Provider Contract entity for contract domain [P209 skipped: target-product-missing:contract.contract_provider_contract renamed to contract.provider_contract per VREQ-003]';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`contract`.`contract_dispute` (
    `contract_dispute_id` BIGINT COMMENT 'Unique identifier for the contract dispute record. Primary key.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Maps dispute cases to the employee handling them; required for dispute resolution workflow and performance metrics.',
    `provider_contract_id` BIGINT COMMENT 'Reference to the provider contract under dispute.',
    `provider_id` BIGINT COMMENT 'Reference to the provider who initiated the dispute.',
    `affected_service_period_end` DATE COMMENT 'End date of the service period or contract period affected by the dispute.',
    `affected_service_period_start` DATE COMMENT 'Start date of the service period or contract period affected by the dispute.',
    `arbitration_case_number` STRING COMMENT 'External arbitration case number assigned by the arbitration body if the dispute is escalated to arbitration.',
    `contract_amendment_required` BOOLEAN COMMENT 'Indicates whether the dispute resolution requires a formal contract amendment to be executed (True/False).',
    `contract_clause_reference` STRING COMMENT 'Specific contract section, clause, or amendment number cited by the provider as the basis for the dispute.',
    `created_timestamp` TIMESTAMP COMMENT 'Standard ECM audit/governance attribute created_timestamp.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the disputed amount (e.g., USD).. Valid values are `^[A-Z]{3}$`',
    `data_quality_score` STRING COMMENT 'Computed data-quality score for ECM scoring.',
    `dispute_number` STRING COMMENT 'Externally-known unique business identifier for the dispute, formatted as DSP-NNNNNNNN.. Valid values are `^DSP-[0-9]{8}$`',
    `dispute_status` STRING COMMENT 'Current lifecycle status of the dispute: open (newly filed), under review (being investigated), pending documentation (awaiting additional information), resolved (dispute settled), escalated to arbitration (sent to external arbitration), closed (dispute finalized).. Valid values are `open|under_review|pending_documentation|resolved|escalated_to_arbitration|closed`',
    `dispute_type` STRING COMMENT 'Classification of the dispute by subject matter: rate dispute (reimbursement rate disagreement), scope-of-service dispute (covered services disagreement), payment dispute (claim payment disagreement), termination dispute (contract termination disagreement), credentialing dispute (provider credentialing issue), network status dispute (network tier or participation disagreement).. Valid values are `rate_dispute|scope_of_service_dispute|payment_dispute|termination_dispute|credentialing_dispute|network_status_dispute`',
    `disputed_amount` DECIMAL(18,2) COMMENT 'Total monetary amount in dispute, representing the difference between provider expectation and plan payment or rate.',
    `document_repository_path` STRING COMMENT 'File system or document management system path where dispute-related documents are stored.',
    `effective_end_date` DATE COMMENT 'Effective end of the record validity window.',
    `effective_start_date` DATE COMMENT 'Effective start of the record validity window.',
    `escalation_date` DATE COMMENT 'Date when the dispute was escalated to a higher authority or external arbitration.',
    `escalation_flag` BOOLEAN COMMENT 'Indicates whether the dispute has been escalated to senior management, legal, or external arbitration (True/False).',
    `fhir_last_updated` TIMESTAMP COMMENT 'FHIR meta.lastUpdated for resource versioning',
    `fhir_profile_url` STRING COMMENT 'Canonical FHIR/US Core profile URL this record conforms to',
    `fhir_resource_reference` STRING COMMENT 'Stable FHIR logical resource id for interop exchange',
    `fhir_resource_type` STRING COMMENT 'FHIR resource type this record maps to for interoperability (default: Basic)',
    `fhir_version_code` STRING COMMENT 'FHIR meta.versionId optimistic concurrency token',
    `initiation_date` DATE COMMENT 'Date when the provider formally filed the dispute with the health plan.',
    `is_active` BOOLEAN COMMENT 'Logical active flag for soft-delete and current-state filtering.',
    `legal_counsel_involved` BOOLEAN COMMENT 'Indicates whether legal counsel (internal or external) is involved in the dispute resolution process (True/False).',
    `legal_counsel_name` STRING COMMENT 'Name of the legal counsel or law firm representing the health plan in the dispute.',
    `lob_code` STRING COMMENT 'Line of business associated with the disputed contract: commercial (employer-sponsored), medicare (Medicare Advantage), medicaid (Medicaid managed care), exchange (ACA marketplace), aso (Administrative Services Only), tpa (Third Party Administrator).. Valid values are `commercial|medicare|medicaid|exchange|aso|tpa`',
    `master_entity_reference` STRING COMMENT 'Cross-domain master/golden entity key for SSOT resolution.',
    `payment_adjustment_required` BOOLEAN COMMENT 'Indicates whether a retroactive payment adjustment or reprocessing of claims is required as a result of the dispute resolution (True/False).',
    `priority_level` STRING COMMENT 'Priority classification for dispute resolution based on amount, provider relationship, regulatory risk, or business impact.. Valid values are `low|medium|high|critical`',
    `provider_contact_email` STRING COMMENT 'Email address of the provider representative handling the dispute.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `provider_contact_name` STRING COMMENT 'Name of the provider representative or contact person handling the dispute on behalf of the provider.',
    `provider_contact_phone` STRING COMMENT 'Phone number of the provider representative handling the dispute.',
    `reason` STRING COMMENT 'Detailed narrative explanation provided by the provider describing the basis for the dispute, including specific contract clauses, payment discrepancies, or service scope disagreements.',
    `received_timestamp` TIMESTAMP COMMENT 'Timestamp when the dispute was received and logged by the health plan system.',
    `record_created_at` TIMESTAMP COMMENT 'Timestamp the record was created (audit lineage).',
    `record_created_timestamp` TIMESTAMP COMMENT 'Timestamp when this dispute record was first created in the system.',
    `record_source_system` STRING COMMENT 'System of record / source system that produced this record (SSOT provenance).',
    `record_status` STRING COMMENT 'Standard ECM audit/governance attribute record_status.',
    `record_updated_at` TIMESTAMP COMMENT 'Timestamp the record was last updated (audit lineage).',
    `record_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this dispute record was last modified.',
    `record_version` STRING COMMENT 'Optimistic-concurrency / change version of the record.',
    `regulatory_report_date` DATE COMMENT 'Date when the dispute was reported to the regulatory authority.',
    `regulatory_reporting_required` BOOLEAN COMMENT 'Indicates whether the dispute must be reported to state Department of Insurance (DOI) or other regulatory bodies (True/False).',
    `resolution_amount` DECIMAL(18,2) COMMENT 'Final monetary settlement amount agreed upon or awarded as part of the dispute resolution.',
    `resolution_date` DATE COMMENT 'Date when the dispute was formally resolved or closed.',
    `resolution_notes` STRING COMMENT 'Detailed internal notes documenting the resolution process, rationale, and any agreements or concessions made.',
    `resolution_outcome` STRING COMMENT 'Final outcome of the dispute resolution: provider favor (provider claim upheld), plan favor (plan position upheld), partial settlement (compromise reached), withdrawn (provider withdrew dispute), arbitration pending (awaiting arbitration decision).. Valid values are `provider_favor|plan_favor|partial_settlement|withdrawn|arbitration_pending`',
    `sla_due_date` DATE COMMENT 'Target date by which the dispute must be resolved to meet SLA requirements.',
    `sla_met_flag` BOOLEAN COMMENT 'Indicates whether the dispute was resolved within the SLA timeframe (True/False).',
    `sla_resolution_days` STRING COMMENT 'Number of calendar days within which the dispute must be resolved per contractual or regulatory SLA requirements.',
    `source_system_code` STRING COMMENT 'Code identifying the operational system from which the dispute record originated (e.g., ProviderSource, Cactus, custom dispute management system).',
    `supporting_document_count` STRING COMMENT 'Number of supporting documents (contracts, invoices, correspondence, clinical documentation) submitted as evidence for the dispute.',
    `updated_timestamp` TIMESTAMP COMMENT 'Standard ECM audit/governance attribute updated_timestamp.',
    CONSTRAINT pk_contract_dispute PRIMARY KEY(`contract_dispute_id`)
) COMMENT 'Tracks formal disputes and grievances raised by providers against contract terms, reimbursement rates, or payment decisions. Captures dispute type (rate dispute, scope-of-service dispute, payment dispute, termination dispute), dispute initiation date, disputed amount, dispute status (open, under review, resolved, escalated to arbitration), resolution outcome, and resolution date. Supports provider relations and legal team workflows.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`contract`.`contract_lifecycle_event2` (
    `contract_lifecycle_event2_id` BIGINT COMMENT 'Unique surrogate identifier for each contract lifecycle event record in the silver layer. Primary key for this entity.',
    `contract_amendment_id` BIGINT COMMENT 'Reference to the contract amendment associated with this lifecycle event, if the event was triggered by or resulted in an amendment. Null for non-amendment events.',
    `provider_contract_id` BIGINT COMMENT 'Reference to the parent provider contract for which this lifecycle event was recorded. Links to the contract master record.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Tracks Contract Lifecycle Analyst responsible for each event; essential for event‑level reporting and audit trails.',
    `provider_network_id` BIGINT COMMENT 'Reference to the provider network affected by this lifecycle event, when the event impacts a specific network tier or network configuration (e.g., a provider suspension from a specific network). Null when the event applies to all networks on the contract.',
    `approval_required_flag` BOOLEAN COMMENT 'Indicates whether this lifecycle event required formal approval before being applied to the contract. Drives approval workflow routing and audit trail completeness validation.',
    `approval_status` STRING COMMENT 'Current status of the approval workflow for this lifecycle event. Tracks whether required approvals have been obtained, are pending, or were rejected. Used for governance controls and audit trail.. Valid values are `not_required|pending|approved|rejected|escalated`',
    `approved_timestamp` TIMESTAMP COMMENT 'Date and time at which the required approval for this lifecycle event was granted. Null when approval is not required or not yet obtained. Used for approval turnaround time analytics and SLA monitoring.',
    `approver_name` STRING COMMENT 'Name or employee identifier of the individual who approved this lifecycle event in the approval chain. Null when approval is not required or not yet obtained. Supports governance audit trail.',
    `claims_reprocess_required` BOOLEAN COMMENT 'Indicates whether claims previously adjudicated under the prior contract terms must be reprocessed as a result of this lifecycle event (e.g., retroactive rate change, retroactive termination). Triggers downstream claims reprocessing workflow in Facets or QNXT.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time at which this lifecycle event record was first created in the data platform. Serves as the record audit creation timestamp for data lineage, SLA monitoring, and compliance audit trail purposes.',
    `data_quality_score` STRING COMMENT 'Computed data-quality score for ECM scoring.',
    `dispute_status` STRING COMMENT 'Current status of the dispute associated with this lifecycle event. Tracks the dispute through its resolution lifecycle from initial filing through arbitration or resolution. Null for non-dispute events.. Valid values are `open|under_review|resolved|escalated_to_arbitration|withdrawn`',
    `dispute_type` STRING COMMENT 'For dispute lifecycle events, classifies the nature of the dispute between the health plan and the provider. Drives dispute resolution workflow routing and provider relations case management. Null for non-dispute events.. Valid values are `rate_dispute|scope_of_service|payment_dispute|termination_dispute|credentialing_dispute`',
    `disputed_amount` DECIMAL(18,2) COMMENT 'For payment and rate dispute events, the total dollar amount in dispute between the health plan and the provider. Used for financial exposure tracking, dispute prioritization, and regulatory reporting. Null for non-monetary disputes.',
    `document_reference` STRING COMMENT 'Reference identifier or URL to the supporting document associated with this lifecycle event (e.g., executed contract, signed amendment, termination letter, arbitration award, dispute correspondence). Links to the document management system.',
    `effective_date` DATE COMMENT 'The date on which the outcome of this lifecycle event becomes operationally effective for the contract (e.g., the date a renewal takes effect, the date a suspension begins, the date a rate change applies). May differ from event_timestamp for retroactive or future-dated events.',
    `effective_end_date` DATE COMMENT 'Effective end of the record validity window.',
    `effective_start_date` DATE COMMENT 'Effective start of the record validity window.',
    `event_notes` STRING COMMENT 'Free-text notes capturing additional context, rationale, or details about this lifecycle event that are not captured in structured fields. Used by contracting analysts and provider relations staff for operational context and audit trail enrichment.',
    `event_number` STRING COMMENT 'Human-readable, externally referenceable identifier for this lifecycle event, used in provider relations correspondence, audit reports, and regulatory examination submissions. Format: EVT-YYYY-NNNNNN.. Valid values are `^EVT-[0-9]{4}-[0-9]{6}$`',
    `event_status` STRING COMMENT 'Current processing status of this lifecycle event record, indicating whether the event has been fully processed, is still in progress, or was cancelled or failed during execution.. Valid values are `pending|in_progress|completed|cancelled|failed`',
    `event_timestamp` TIMESTAMP COMMENT 'The precise date and time at which the lifecycle event occurred in the real world (e.g., when the contract was executed, when the termination notice was issued, when the dispute was filed). This is the principal business event time, distinct from the record audit timestamp.',
    `event_type` STRING COMMENT 'Categorizes the nature of the lifecycle event that occurred on the contract. Drives downstream workflow routing, audit trail classification, and renewal pipeline tracking. [ENUM-REF-CANDIDATE: initiation|negotiation|execution|amendment|renewal|auto_renewal|suspension|termination|reinstatement|renegotiation|dispute_filed|dispute_resolved|arbitration|rate_change|expiration — promote to reference product]',
    `event_type_code` STRING COMMENT 'Event type code constrained to contract lifecycle events; keeps distinct from credential/member/vendor lifecycle_event',
    `fhir_last_updated` TIMESTAMP COMMENT 'FHIR meta.lastUpdated for resource versioning',
    `fhir_profile_url` STRING COMMENT 'Canonical FHIR/US Core profile URL this record conforms to',
    `fhir_resource_reference` STRING COMMENT 'Stable FHIR logical resource id for interop exchange',
    `fhir_resource_type` STRING COMMENT 'FHIR resource type this record maps to for interoperability (default: Basic)',
    `fhir_version_code` STRING COMMENT 'FHIR meta.versionId optimistic concurrency token',
    `is_active` BOOLEAN COMMENT 'Logical active flag for soft-delete and current-state filtering.',
    `lob_code` STRING COMMENT 'Line of Business affected by this lifecycle event. Relevant when a contract covers multiple LOBs and the event applies to a specific LOB (e.g., a rate change only for Medicare Advantage). Null when the event applies to all LOBs on the contract.. Valid values are `commercial|medicare_advantage|medicaid|marketplace|dsnp|fehb`',
    `master_entity_reference` STRING COMMENT 'Cross-domain master/golden entity key for SSOT resolution.',
    `new_contract_status` STRING COMMENT 'The contract status immediately after this lifecycle event was applied. Together with prior_contract_status, documents the complete state transition for compliance audit trail and regulatory examination readiness. [ENUM-REF-CANDIDATE: draft|pending_execution|active|suspended|terminated|expired|under_renegotiation|in_dispute — 8 candidates stripped; promote to reference product]',
    `new_effective_date` DATE COMMENT 'For renewal and renegotiation events, the start date of the new contract term resulting from this event. Distinct from effective_date (when the event itself takes effect) — this captures the new contract period start date for renewal pipeline tracking.',
    `new_expiration_date` DATE COMMENT 'For renewal and renegotiation events, the end date of the new contract term established by this event. Used for proactive contract management, renewal pipeline tracking, and expiration alerts.',
    `notice_period_days` STRING COMMENT 'The number of calendar days of advance notice required by the contract or applicable regulation for this type of lifecycle event (e.g., 90 days for termination without cause). Used to validate notice_sent_date compliance and flag potential regulatory violations.',
    `notice_sent_date` DATE COMMENT 'The date on which the contractual or regulatory notice was sent to the provider for this lifecycle event. Used to verify compliance with required notice periods (e.g., 90-day termination notice). Null when notice_sent_flag is false.',
    `notice_sent_flag` BOOLEAN COMMENT 'Indicates whether the required contractual or regulatory notice was sent to the provider for this lifecycle event (e.g., termination notice, suspension notice, renewal notice). Critical for compliance with notice period requirements under state DOI regulations.',
    `prior_contract_status` STRING COMMENT 'The contract status immediately before this lifecycle event was applied. Captured at the time of the event to support full audit trail reconstruction and state-transition compliance reporting. [ENUM-REF-CANDIDATE: draft|pending_execution|active|suspended|terminated|expired|under_renegotiation|in_dispute — 8 candidates stripped; promote to reference product]',
    `provider_relations_case_ref` STRING COMMENT 'Reference number or identifier from the Provider Relations case management system (e.g., Salesforce Health Cloud or Pega) associated with this lifecycle event, particularly for dispute, termination, and escalation events. Enables cross-system traceability.',
    `rate_change_pct` DECIMAL(18,2) COMMENT 'For renewal and renegotiation events, the percentage change in reimbursement rates resulting from this event (positive for increases, negative for decreases). Expressed as a decimal percentage (e.g., 3.5000 = 3.5%). Null for non-rate-impacting events.',
    `record_created_at` TIMESTAMP COMMENT 'Timestamp the record was created (audit lineage).',
    `record_source_system` STRING COMMENT 'System of record / source system that produced this record (SSOT provenance).',
    `record_status` STRING COMMENT 'Standard ECM audit/governance attribute record_status.',
    `record_updated_at` TIMESTAMP COMMENT 'Timestamp the record was last updated (audit lineage).',
    `record_version` STRING COMMENT 'Optimistic-concurrency / change version of the record.',
    `regulatory_mandate_flag` BOOLEAN COMMENT 'Indicates whether this lifecycle event was triggered by or required to comply with a regulatory mandate (e.g., CMS network adequacy requirement, state DOI directive, ACA compliance). Supports regulatory examination readiness and compliance reporting.',
    `regulatory_reference` STRING COMMENT 'Citation or reference to the specific regulation, CMS directive, state DOI order, or compliance requirement that mandated or is associated with this lifecycle event. Populated when regulatory_mandate_flag is true. Supports regulatory examination documentation.',
    `renewal_type` STRING COMMENT 'For renewal lifecycle events, specifies the mechanism by which the contract was renewed: automatic (auto-renewal clause triggered), renegotiated (new terms agreed), evergreen (continuous rolling renewal), or manual (explicit renewal action). Null for non-renewal events.. Valid values are `auto|renegotiated|evergreen|manual`',
    `resolution_date` DATE COMMENT 'The date on which the dispute associated with this lifecycle event was formally resolved, withdrawn, or an arbitration award was issued. Null for open disputes and non-dispute events. Used for dispute aging analysis and regulatory timeliness reporting.',
    `resolution_outcome` STRING COMMENT 'For resolved dispute events, the final outcome of the dispute resolution process. Captures which party prevailed or whether a mutual agreement was reached. Null for open disputes and non-dispute events.. Valid values are `resolved_in_plan_favor|resolved_in_provider_favor|mutual_agreement|arbitration_award|withdrawn|no_action`',
    `retroactive_flag` BOOLEAN COMMENT 'Indicates whether this lifecycle event has a retroactive effective date (i.e., the effective_date is prior to the event_timestamp). Retroactive events may require claims reprocessing and trigger additional compliance review.',
    `source_event_reference` STRING COMMENT 'The native identifier of this lifecycle event in the originating operational system of record (e.g., Facets contract event ID, QNXT transaction ID, Pega case number). Enables cross-system traceability and reconciliation between the lakehouse silver layer and source systems.',
    `triggered_by_type` STRING COMMENT 'Indicates whether this lifecycle event was triggered by a human user action, an automated system process (e.g., auto-renewal scheduler), an external party (e.g., provider-initiated termination), or a regulatory mandate. Supports audit trail and accountability tracking.. Valid values are `user|system|scheduler|external_party|regulatory_mandate`',
    `triggered_by_user` STRING COMMENT 'Username or system account identifier of the user or automated process that initiated this lifecycle event. Supports accountability, audit trail, and compliance examination readiness. Null when triggered_by_type is system or scheduler with no associated user.',
    `updated_timestamp` TIMESTAMP COMMENT 'The date and time at which this lifecycle event record was most recently modified in the data platform. Used for change detection, incremental processing, and audit trail completeness in the Databricks silver layer.',
    CONSTRAINT pk_contract_lifecycle_event2 PRIMARY KEY(`contract_lifecycle_event2_id`)
) COMMENT 'Audit and lifecycle tracking for all significant events in a contracts lifecycle — initiation, negotiation, execution, amendment, renewal, auto-renewal execution, suspension, termination, reinstatement, renegotiation, dispute filing, dispute resolution, and arbitration. Captures event type, event date, triggered-by user or system, prior status, new status, notes, approval chain. For renewal events: renewal type (auto, renegotiated, evergreen), rate change percentage, new effective date, and responsible contracting analyst. For dispute events: dispute type (rate dispute, scope-of-service dispute, payment dispute, termination dispute), disputed amount, dispute status (open, under review, resolved, escalated to arbitration), resolution outcome, resolution date, and provider relations case reference. SSOT for all contract state transitions, dispute management, renewal pipeline tracking, and provider relations workflows. Supports compliance audit trail, proactive contract management, and regulatory examination readiness. [SSOT Master for lifecycle_event concept across domains] [P204 skipped: target-product-missing:contract.contract_lifecycle_event renamed to contract.lifecycle_event per VREQ-006]';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`contract`.`audit` (
    `audit_id` BIGINT COMMENT 'Unique identifier for the contract compliance audit record. Primary key.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Supports Audit Execution report; links audit records to the employee auditor for accountability and regulatory reporting.',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: Required: Contract audits are performed to verify compliance with a specific regulatory obligation.',
    `provider_contract_id` BIGINT COMMENT 'Reference to the provider contract or delegation agreement being audited.',
    `provider_id` BIGINT COMMENT 'Reference to the provider entity subject to the audit.',
    `actual_completion_date` DATE COMMENT 'Actual date when the audit was completed and findings were issued.',
    `actual_start_date` DATE COMMENT 'Actual date when the audit fieldwork or review commenced.',
    `audit_number` STRING COMMENT 'Business-facing unique audit tracking number assigned by the audit management system.',
    `audit_status` STRING COMMENT 'Current lifecycle status of the audit: scheduled, in-progress, completed, findings-issued, CAP-pending (Corrective Action Plan pending), or closed.. Valid values are `scheduled|in-progress|completed|findings-issued|cap-pending|closed`',
    `audit_type` STRING COMMENT 'Classification of the audit engagement: payment accuracy, credentialing compliance, delegation oversight, coding audit, medical record review, or rate validation.. Valid values are `payment-accuracy|credentialing-compliance|delegation-oversight|coding-audit|medical-record-review|rate-validation`',
    `auditor_name` STRING COMMENT '',
    `auditor_type` STRING COMMENT 'Classification of the auditor: internal (health plan staff), external (contracted audit firm), regulatory (CMS or state DOI), or third-party (independent reviewer).. Valid values are `internal|external|regulatory|third-party`',
    `completion_date` DATE COMMENT '',
    `compliance_rating` STRING COMMENT '',
    `corrective_action_due_date` DATE COMMENT '',
    `corrective_action_plan_due_date` DATE COMMENT 'Date by which the provider must submit a Corrective Action Plan addressing audit findings.',
    `corrective_action_plan_received_date` DATE COMMENT 'Date when the provider submitted the Corrective Action Plan.',
    `corrective_action_plan_required` BOOLEAN COMMENT 'Indicates whether a formal Corrective Action Plan is required from the provider based on audit findings.',
    `corrective_action_plan_status` STRING COMMENT 'Current status of the Corrective Action Plan: not-required, pending, submitted, under-review, approved, rejected, implemented, or verified. [ENUM-REF-CANDIDATE: not-required|pending|submitted|under-review|approved|rejected|implemented|verified — 8 candidates stripped; promote to reference product]',
    `corrective_action_required` BOOLEAN COMMENT '',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the audit record was first created in the system.',
    `critical_findings_count` STRING COMMENT '',
    `data_quality_score` STRING COMMENT 'Computed data-quality score for ECM scoring.',
    `effective_end_date` DATE COMMENT 'Effective end of the record validity window.',
    `effective_start_date` DATE COMMENT 'Effective start of the record validity window.',
    `error_count` STRING COMMENT 'Number of errors, discrepancies, or non-compliant items identified in the audit sample.',
    `error_rate_pct` DECIMAL(18,2) COMMENT 'Calculated error rate as a percentage of the sample size, representing the proportion of non-compliant items.',
    `fhir_last_updated` TIMESTAMP COMMENT 'FHIR meta.lastUpdated for resource versioning',
    `fhir_profile_url` STRING COMMENT 'Canonical FHIR/US Core profile URL this record conforms to',
    `fhir_resource_reference` STRING COMMENT 'Stable FHIR logical resource id for interop exchange',
    `fhir_resource_type` STRING COMMENT 'FHIR resource type this record maps to for interoperability (default: Basic)',
    `fhir_version_code` STRING COMMENT 'FHIR meta.versionId optimistic concurrency token',
    `financial_recovery_amount` DECIMAL(18,2) COMMENT '',
    `findings_count` STRING COMMENT '',
    `findings_severity` STRING COMMENT 'Overall severity classification of audit findings: critical, high, medium, low, or none.. Valid values are `critical|high|medium|low|none`',
    `findings_summary` STRING COMMENT 'Executive summary of audit findings, including key compliance gaps, payment discrepancies, or operational deficiencies identified.',
    `frequency` STRING COMMENT 'Planned frequency of audits for this contract or provider: annual, semi-annual, quarterly, ad-hoc, or risk-based.. Valid values are `annual|semi-annual|quarterly|ad-hoc|risk-based`',
    `is_active` BOOLEAN COMMENT 'Logical active flag for soft-delete and current-state filtering.',
    `lob` STRING COMMENT 'Line of business for the contract under audit: commercial, Medicare, Medicaid, marketplace (ACA exchange), or dual-eligible.. Valid values are `commercial|medicare|medicaid|marketplace|dual-eligible`',
    `lob_code` STRING COMMENT '',
    `master_entity_reference` STRING COMMENT 'Cross-domain master/golden entity key for SSOT resolution.',
    `methodology` STRING COMMENT '',
    `net_payment_variance` DECIMAL(18,2) COMMENT 'Net payment variance calculated as overpayment amount minus underpayment amount, representing the net financial impact of audit findings.',
    `next_scheduled_audit_date` DATE COMMENT 'Date when the next audit of this contract or provider is scheduled, supporting ongoing oversight and monitoring.',
    `notes` STRING COMMENT 'Free-text field for additional audit notes, observations, or context not captured in structured fields.',
    `overall_score` DECIMAL(18,2) COMMENT '',
    `overpayment_amount` DECIMAL(18,2) COMMENT 'Total dollar amount of overpayments identified during the audit, representing amounts paid to the provider in excess of contract terms.',
    `performed_date` DATE COMMENT '',
    `period_end` DATE COMMENT '',
    `period_end_date` DATE COMMENT 'End date of the period under audit (e.g., claims incurred through this date).',
    `period_start` DATE COMMENT '',
    `period_start_date` DATE COMMENT 'Start date of the period under audit (e.g., claims incurred from this date).',
    `record_created_at` TIMESTAMP COMMENT 'Timestamp the record was created (audit lineage).',
    `record_created_timestamp` TIMESTAMP COMMENT '',
    `record_source_system` STRING COMMENT 'System of record / source system that produced this record (SSOT provenance).',
    `record_status` STRING COMMENT 'Standard ECM audit/governance attribute record_status.',
    `record_updated_at` TIMESTAMP COMMENT 'Timestamp the record was last updated (audit lineage).',
    `record_updated_timestamp` TIMESTAMP COMMENT '',
    `record_version` STRING COMMENT 'Optimistic-concurrency / change version of the record.',
    `regulatory_mandate_flag` BOOLEAN COMMENT 'Indicates whether the audit was mandated by a regulatory body (CMS, state DOI, NCQA) or conducted voluntarily by the health plan.',
    `regulatory_reference` STRING COMMENT 'Reference to the specific regulatory requirement, CMS program letter, state DOI bulletin, or NCQA standard that mandated or guided the audit.',
    `report_document_reference` STRING COMMENT 'Reference to the formal audit report document stored in the document management system.',
    `report_reference` STRING COMMENT '',
    `sample_size` STRING COMMENT 'Number of claims, records, or transactions included in the audit sample.',
    `scheduled_completion_date` DATE COMMENT 'Planned date for the audit to be completed and findings issued.',
    `scheduled_date` DATE COMMENT '',
    `scheduled_start_date` DATE COMMENT 'Planned date for the audit fieldwork or review to commence.',
    `scope` STRING COMMENT 'Detailed description of the audit scope, including specific contract provisions, service categories, claim types, or operational areas under review.',
    `siu_referral_date` DATE COMMENT 'Date when the audit findings were referred to the Special Investigations Unit.',
    `siu_referral_flag` BOOLEAN COMMENT 'Indicates whether audit findings triggered a referral to the Special Investigations Unit for potential fraud, waste, or abuse investigation.',
    `source_system_code` STRING COMMENT '',
    `summary_notes` STRING COMMENT '',
    `underpayment_amount` DECIMAL(18,2) COMMENT 'Total dollar amount of underpayments identified during the audit, representing amounts owed to the provider under contract terms.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when the audit record was last updated in the system.',
    CONSTRAINT pk_audit PRIMARY KEY(`audit_id`)
) COMMENT 'Records formal contract compliance audits, post-payment reviews, and delegation oversight audits conducted against provider contracts and delegation agreements. Captures audit type (payment accuracy, credentialing compliance, delegation oversight, coding audit, medical record review, rate validation), audit period, audit scope, findings summary, overpayment or underpayment amount identified, corrective action plan (CAP), CAP due date, audit status (scheduled, in-progress, completed, findings-issued, CAP-pending), and next scheduled audit date. Supports NCQA delegation oversight standards, CMS program audit readiness, state DOI examination requirements, and SIU referral triggers.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`contract`.`contract_lifecycle_event` (
    `contract_lifecycle_event_id` BIGINT COMMENT 'Primary key for contract_lifecycle_event',
    `provider_contract_id` BIGINT COMMENT '',
    `event_type_code` STRING COMMENT 'Constrained to contract-specific event types to maintain separation from lifecycle_event patterns in credential, member, and vendor domains while preserving domain independence',
    CONSTRAINT pk_contract_lifecycle_event PRIMARY KEY(`contract_lifecycle_event_id`)
) COMMENT 'Contract lifecycle event with event_type_code constrained to contract events';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`party` ADD CONSTRAINT `fk_contract_party_provider_contract_id` FOREIGN KEY (`provider_contract_id`) REFERENCES `vibe_health_insurance_v1`.`contract`.`provider_contract`(`provider_contract_id`);
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`term` ADD CONSTRAINT `fk_contract_term_contract_amendment_id` FOREIGN KEY (`contract_amendment_id`) REFERENCES `vibe_health_insurance_v1`.`contract`.`contract_amendment`(`contract_amendment_id`);
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`term` ADD CONSTRAINT `fk_contract_term_provider_contract_id` FOREIGN KEY (`provider_contract_id`) REFERENCES `vibe_health_insurance_v1`.`contract`.`provider_contract`(`provider_contract_id`);
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`term` ADD CONSTRAINT `fk_contract_term_fee_schedule_id` FOREIGN KEY (`fee_schedule_id`) REFERENCES `vibe_health_insurance_v1`.`contract`.`fee_schedule`(`fee_schedule_id`);
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_amendment` ADD CONSTRAINT `fk_contract_contract_amendment_provider_contract_id` FOREIGN KEY (`provider_contract_id`) REFERENCES `vibe_health_insurance_v1`.`contract`.`provider_contract`(`provider_contract_id`);
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_amendment` ADD CONSTRAINT `fk_contract_contract_amendment_fee_schedule_id` FOREIGN KEY (`fee_schedule_id`) REFERENCES `vibe_health_insurance_v1`.`contract`.`fee_schedule`(`fee_schedule_id`);
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_amendment` ADD CONSTRAINT `fk_contract_contract_amendment_superseded_amendment_id` FOREIGN KEY (`superseded_amendment_id`) REFERENCES `vibe_health_insurance_v1`.`contract`.`contract_amendment`(`contract_amendment_id`);
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`fee_schedule` ADD CONSTRAINT `fk_contract_fee_schedule_superseded_by_fee_schedule_id` FOREIGN KEY (`superseded_by_fee_schedule_id`) REFERENCES `vibe_health_insurance_v1`.`contract`.`fee_schedule`(`fee_schedule_id`);
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`fee_schedule` ADD CONSTRAINT `fk_contract_fee_schedule_fee_provider_contract_id` FOREIGN KEY (`fee_provider_contract_id`) REFERENCES `vibe_health_insurance_v1`.`contract`.`provider_contract`(`provider_contract_id`);
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`fee_schedule` ADD CONSTRAINT `fk_contract_fee_schedule_provider_contract_id` FOREIGN KEY (`provider_contract_id`) REFERENCES `vibe_health_insurance_v1`.`contract`.`provider_contract`(`provider_contract_id`);
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`fee_schedule_rate` ADD CONSTRAINT `fk_contract_fee_schedule_rate_provider_contract_id` FOREIGN KEY (`provider_contract_id`) REFERENCES `vibe_health_insurance_v1`.`contract`.`provider_contract`(`provider_contract_id`);
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`fee_schedule_rate` ADD CONSTRAINT `fk_contract_fee_schedule_rate_fee_schedule_id` FOREIGN KEY (`fee_schedule_id`) REFERENCES `vibe_health_insurance_v1`.`contract`.`fee_schedule`(`fee_schedule_id`);
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`fee_schedule_rate` ADD CONSTRAINT `fk_contract_fee_schedule_rate_prior_rate_fee_schedule_rate_id` FOREIGN KEY (`prior_rate_fee_schedule_rate_id`) REFERENCES `vibe_health_insurance_v1`.`contract`.`fee_schedule_rate`(`fee_schedule_rate_id`);
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`capitation_arrangement` ADD CONSTRAINT `fk_contract_capitation_arrangement_provider_contract_id` FOREIGN KEY (`provider_contract_id`) REFERENCES `vibe_health_insurance_v1`.`contract`.`provider_contract`(`provider_contract_id`);
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`capitation_payment` ADD CONSTRAINT `fk_contract_capitation_payment_capitation_arrangement_id` FOREIGN KEY (`capitation_arrangement_id`) REFERENCES `vibe_health_insurance_v1`.`contract`.`capitation_arrangement`(`capitation_arrangement_id`);
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`capitation_payment` ADD CONSTRAINT `fk_contract_capitation_payment_provider_contract_id` FOREIGN KEY (`provider_contract_id`) REFERENCES `vibe_health_insurance_v1`.`contract`.`provider_contract`(`provider_contract_id`);
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`capitation_payment` ADD CONSTRAINT `fk_contract_capitation_payment_original_payment_capitation_payment_id` FOREIGN KEY (`original_payment_capitation_payment_id`) REFERENCES `vibe_health_insurance_v1`.`contract`.`capitation_payment`(`capitation_payment_id`);
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`vbc_contract` ADD CONSTRAINT `fk_contract_vbc_contract_provider_contract_id` FOREIGN KEY (`provider_contract_id`) REFERENCES `vibe_health_insurance_v1`.`contract`.`provider_contract`(`provider_contract_id`);
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`vbc_performance_period` ADD CONSTRAINT `fk_contract_vbc_performance_period_vbc_contract_id` FOREIGN KEY (`vbc_contract_id`) REFERENCES `vibe_health_insurance_v1`.`contract`.`vbc_contract`(`vbc_contract_id`);
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`bundled_payment_episode` ADD CONSTRAINT `fk_contract_bundled_payment_episode_provider_contract_id` FOREIGN KEY (`provider_contract_id`) REFERENCES `vibe_health_insurance_v1`.`contract`.`provider_contract`(`provider_contract_id`);
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`reimbursement_policy` ADD CONSTRAINT `fk_contract_reimbursement_policy_provider_contract_id` FOREIGN KEY (`provider_contract_id`) REFERENCES `vibe_health_insurance_v1`.`contract`.`provider_contract`(`provider_contract_id`);
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`reimbursement_policy` ADD CONSTRAINT `fk_contract_reimbursement_policy_fee_schedule_id` FOREIGN KEY (`fee_schedule_id`) REFERENCES `vibe_health_insurance_v1`.`contract`.`fee_schedule`(`fee_schedule_id`);
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`reimbursement_policy` ADD CONSTRAINT `fk_contract_reimbursement_policy_superseded_policy_reimbursement_policy_id` FOREIGN KEY (`superseded_policy_reimbursement_policy_id`) REFERENCES `vibe_health_insurance_v1`.`contract`.`reimbursement_policy`(`reimbursement_policy_id`);
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`service_scope` ADD CONSTRAINT `fk_contract_service_scope_provider_contract_id` FOREIGN KEY (`provider_contract_id`) REFERENCES `vibe_health_insurance_v1`.`contract`.`provider_contract`(`provider_contract_id`);
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`service_scope` ADD CONSTRAINT `fk_contract_service_scope_fee_schedule_id` FOREIGN KEY (`fee_schedule_id`) REFERENCES `vibe_health_insurance_v1`.`contract`.`fee_schedule`(`fee_schedule_id`);
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`service_scope` ADD CONSTRAINT `fk_contract_service_scope_superseded_by_service_scope_id` FOREIGN KEY (`superseded_by_service_scope_id`) REFERENCES `vibe_health_insurance_v1`.`contract`.`service_scope`(`service_scope_id`);
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`delegation_agreement` ADD CONSTRAINT `fk_contract_delegation_agreement_provider_contract_id` FOREIGN KEY (`provider_contract_id`) REFERENCES `vibe_health_insurance_v1`.`contract`.`provider_contract`(`provider_contract_id`);
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`delegation_agreement` ADD CONSTRAINT `fk_contract_delegation_agreement_party_id` FOREIGN KEY (`party_id`) REFERENCES `vibe_health_insurance_v1`.`contract`.`party`(`party_id`);
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`delegation_agreement` ADD CONSTRAINT `fk_contract_delegation_agreement_superseded_by_delegation_agreement_id` FOREIGN KEY (`superseded_by_delegation_agreement_id`) REFERENCES `vibe_health_insurance_v1`.`contract`.`delegation_agreement`(`delegation_agreement_id`);
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`incentive_arrangement` ADD CONSTRAINT `fk_contract_incentive_arrangement_provider_contract_id` FOREIGN KEY (`provider_contract_id`) REFERENCES `vibe_health_insurance_v1`.`contract`.`provider_contract`(`provider_contract_id`);
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_network_participation` ADD CONSTRAINT `fk_contract_contract_network_participation_provider_contract_id` FOREIGN KEY (`provider_contract_id`) REFERENCES `vibe_health_insurance_v1`.`contract`.`provider_contract`(`provider_contract_id`);
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`financial_summary` ADD CONSTRAINT `fk_contract_financial_summary_capitation_arrangement_id` FOREIGN KEY (`capitation_arrangement_id`) REFERENCES `vibe_health_insurance_v1`.`contract`.`capitation_arrangement`(`capitation_arrangement_id`);
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`financial_summary` ADD CONSTRAINT `fk_contract_financial_summary_provider_contract_id` FOREIGN KEY (`provider_contract_id`) REFERENCES `vibe_health_insurance_v1`.`contract`.`provider_contract`(`provider_contract_id`);
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`financial_summary` ADD CONSTRAINT `fk_contract_financial_summary_parent_financial_summary_id` FOREIGN KEY (`parent_financial_summary_id`) REFERENCES `vibe_health_insurance_v1`.`contract`.`financial_summary`(`financial_summary_id`);
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`party_regulatory_obligation_compliance` ADD CONSTRAINT `fk_contract_party_regulatory_obligation_compliance_party_id` FOREIGN KEY (`party_id`) REFERENCES `vibe_health_insurance_v1`.`contract`.`party`(`party_id`);
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`party_regulatory_obligation_compliance` ADD CONSTRAINT `fk_contract_party_regulatory_obligation_compliance_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `vibe_health_insurance_v1`.`contract`.`obligation`(`obligation_id`);
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`provider_contract` ADD CONSTRAINT `fk_contract_provider_contract_contract_provider_contract_id` FOREIGN KEY (`contract_provider_contract_id`) REFERENCES `vibe_health_insurance_v1`.`contract`.`provider_contract`(`provider_contract_id`);
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`provider_contract` ADD CONSTRAINT `fk_contract_provider_contract_fee_schedule_id` FOREIGN KEY (`fee_schedule_id`) REFERENCES `vibe_health_insurance_v1`.`contract`.`fee_schedule`(`fee_schedule_id`);
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_dispute` ADD CONSTRAINT `fk_contract_contract_dispute_provider_contract_id` FOREIGN KEY (`provider_contract_id`) REFERENCES `vibe_health_insurance_v1`.`contract`.`provider_contract`(`provider_contract_id`);
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_lifecycle_event2` ADD CONSTRAINT `fk_contract_contract_lifecycle_event2_contract_amendment_id` FOREIGN KEY (`contract_amendment_id`) REFERENCES `vibe_health_insurance_v1`.`contract`.`contract_amendment`(`contract_amendment_id`);
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_lifecycle_event2` ADD CONSTRAINT `fk_contract_contract_lifecycle_event2_provider_contract_id` FOREIGN KEY (`provider_contract_id`) REFERENCES `vibe_health_insurance_v1`.`contract`.`provider_contract`(`provider_contract_id`);
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`audit` ADD CONSTRAINT `fk_contract_audit_provider_contract_id` FOREIGN KEY (`provider_contract_id`) REFERENCES `vibe_health_insurance_v1`.`contract`.`provider_contract`(`provider_contract_id`);
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_lifecycle_event` ADD CONSTRAINT `fk_contract_contract_lifecycle_event_provider_contract_id` FOREIGN KEY (`provider_contract_id`) REFERENCES `vibe_health_insurance_v1`.`contract`.`provider_contract`(`provider_contract_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_health_insurance_v1`.`contract` SET TAGS ('pii_division' = 'business');
ALTER SCHEMA `vibe_health_insurance_v1`.`contract` SET TAGS ('pii_domain' = 'contract');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`party` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`party` SET TAGS ('pii_subdomain' = 'agreement_parties');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`party` SET TAGS ('pii_fhir_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`party` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`party` SET TAGS ('pii_fhir_resource' = 'Basic');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`party` SET TAGS ('pii_ecm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`party` SET TAGS ('pii_ssot' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`party` SET TAGS ('pii_fhir_interop' = 'ready');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`party` SET TAGS ('pii_authority_source' = 'verbatim_reviewer_comments_working_group_sheet');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`party` ALTER COLUMN `party_id` SET TAGS ('pii_business_glossary_term' = 'Party ID');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`party` ALTER COLUMN `provider_contract_id` SET TAGS ('pii_business_glossary_term' = 'Contract ID');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`party` ALTER COLUMN `record_id` SET TAGS ('pii_business_glossary_term' = 'Credential Record Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`party` ALTER COLUMN `vendor_id` SET TAGS ('pii_business_glossary_term' = 'Vendor Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`party` ALTER COLUMN `aco_indicator` SET TAGS ('pii_business_glossary_term' = 'Accountable Care Organization (ACO) Indicator');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`party` ALTER COLUMN `capitation_eligible_indicator` SET TAGS ('pii_business_glossary_term' = 'Capitation Eligible Indicator');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`party` ALTER COLUMN `contract_party_number` SET TAGS ('pii_business_glossary_term' = 'Contract Party Number');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`party` ALTER COLUMN `contract_party_number` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`party` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`party` ALTER COLUMN `created_timestamp` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`party` ALTER COLUMN `credentialing_date` SET TAGS ('pii_business_glossary_term' = 'Credentialing Date');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`party` ALTER COLUMN `credentialing_status` SET TAGS ('pii_business_glossary_term' = 'Credentialing Status');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`party` ALTER COLUMN `credentialing_status` SET TAGS ('pii_value_regex' = 'credentialed|pending|expired|denied|not_required');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`party` ALTER COLUMN `data_quality_score` SET TAGS ('pii_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`party` ALTER COLUMN `delegation_indicator` SET TAGS ('pii_business_glossary_term' = 'Delegation Indicator');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`party` ALTER COLUMN `delegation_scope` SET TAGS ('pii_business_glossary_term' = 'Delegation Scope');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`party` ALTER COLUMN `delegation_scope` SET TAGS ('pii_value_regex' = 'credentialing|claims|utilization_management|care_management|all');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`party` ALTER COLUMN `doing_business_as_name` SET TAGS ('pii_business_glossary_term' = 'Doing Business As (DBA) Name');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`party` ALTER COLUMN `doing_business_as_name` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`party` ALTER COLUMN `effective_date` SET TAGS ('pii_business_glossary_term' = 'Party Effective Date');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`party` ALTER COLUMN `effective_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`party` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`party` ALTER COLUMN `effective_end_date` SET TAGS ('pii_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`party` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`party` ALTER COLUMN `effective_start_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`party` ALTER COLUMN `ein` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`party` ALTER COLUMN `ein` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`party` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`party` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`party` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`party` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`party` ALTER COLUMN `fhir_resource_reference` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`party` ALTER COLUMN `fhir_resource_reference` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`party` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`party` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`party` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`party` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`party` ALTER COLUMN `is_active` SET TAGS ('pii_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`party` ALTER COLUMN `license_expiration_date` SET TAGS ('pii_business_glossary_term' = 'License Expiration Date');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`party` ALTER COLUMN `license_state` SET TAGS ('pii_business_glossary_term' = 'License State');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`party` ALTER COLUMN `license_state` SET TAGS ('pii_value_regex' = '^[A-Z]{2}$');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`party` ALTER COLUMN `line_of_business` SET TAGS ('pii_business_glossary_term' = 'Line of Business (LOB)');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`party` ALTER COLUMN `line_of_business` SET TAGS ('pii_value_regex' = 'commercial|medicare_advantage|medicaid|marketplace|cobra|fehb');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`party` ALTER COLUMN `malpractice_coverage_indicator` SET TAGS ('pii_business_glossary_term' = 'Malpractice Coverage Indicator');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`party` ALTER COLUMN `malpractice_expiration_date` SET TAGS ('pii_business_glossary_term' = 'Malpractice Insurance Expiration Date');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`party` ALTER COLUMN `master_entity_reference` SET TAGS ('pii_business_glossary_term' = 'Master Entity Id');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`party` ALTER COLUMN `network_participation_type` SET TAGS ('pii_business_glossary_term' = 'Network Participation Type');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`party` ALTER COLUMN `network_participation_type` SET TAGS ('pii_value_regex' = 'par|non_par|out_of_network');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`party` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Party Notes');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`party` ALTER COLUMN `notes` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`party` ALTER COLUMN `npi` SET TAGS ('pii_business_glossary_term' = 'National Provider Identifier (NPI)');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`party` ALTER COLUMN `npi` SET TAGS ('pii_value_regex' = '^[0-9]{10}$');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`party` ALTER COLUMN `npi` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`party` ALTER COLUMN `npi` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`party` ALTER COLUMN `npi` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`party` ALTER COLUMN `npi_type` SET TAGS ('pii_business_glossary_term' = 'National Provider Identifier (NPI) Type');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`party` ALTER COLUMN `npi_type` SET TAGS ('pii_value_regex' = 'type_1|type_2');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`party` ALTER COLUMN `oig_exclusion_indicator` SET TAGS ('pii_business_glossary_term' = 'Office of Inspector General (OIG) Exclusion Indicator');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`party` ALTER COLUMN `party_role` SET TAGS ('pii_business_glossary_term' = 'Party Role');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`party` ALTER COLUMN `party_status` SET TAGS ('pii_business_glossary_term' = 'Party Status');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`party` ALTER COLUMN `party_status` SET TAGS ('pii_value_regex' = 'active|inactive|pending|terminated|suspended');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`party` ALTER COLUMN `party_type` SET TAGS ('pii_business_glossary_term' = 'Party Type');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`party` ALTER COLUMN `party_type` SET TAGS ('pii_value_regex' = 'individual|organization');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`party` ALTER COLUMN `primary_specialty_code` SET TAGS ('pii_business_glossary_term' = 'Primary Specialty Code');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`party` ALTER COLUMN `primary_specialty_code` SET TAGS ('pii_value_regex' = '^[A-Z0-9]{10}$');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`party` ALTER COLUMN `primary_specialty_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`party` ALTER COLUMN `raf_applicable_indicator` SET TAGS ('pii_business_glossary_term' = 'Risk Adjustment Factor (RAF) Applicable Indicator');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`party` ALTER COLUMN `record_created_at` SET TAGS ('pii_business_glossary_term' = 'Record Created At');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`party` ALTER COLUMN `record_created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`party` ALTER COLUMN `record_source_system` SET TAGS ('pii_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`party` ALTER COLUMN `record_status` SET TAGS ('pii_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`party` ALTER COLUMN `record_status` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`party` ALTER COLUMN `record_updated_at` SET TAGS ('pii_business_glossary_term' = 'Record Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`party` ALTER COLUMN `record_updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`party` ALTER COLUMN `record_version` SET TAGS ('pii_business_glossary_term' = 'Record Version');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`party` ALTER COLUMN `recredentialing_due_date` SET TAGS ('pii_business_glossary_term' = 'Re-credentialing Due Date');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`party` ALTER COLUMN `sanction_indicator` SET TAGS ('pii_business_glossary_term' = 'Sanction Indicator');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`party` ALTER COLUMN `secondary_specialty_code` SET TAGS ('pii_business_glossary_term' = 'Secondary Specialty Code');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`party` ALTER COLUMN `secondary_specialty_code` SET TAGS ('pii_value_regex' = '^[A-Z0-9]{10}$');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`party` ALTER COLUMN `secondary_specialty_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`party` ALTER COLUMN `service_area_state` SET TAGS ('pii_business_glossary_term' = 'Service Area State');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`party` ALTER COLUMN `service_area_state` SET TAGS ('pii_value_regex' = '^[A-Z]{2}$');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`party` ALTER COLUMN `service_area_zip_code` SET TAGS ('pii_business_glossary_term' = 'Service Area ZIP Code');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`party` ALTER COLUMN `service_area_zip_code` SET TAGS ('pii_value_regex' = '^[0-9]{5}(-[0-9]{4})?$');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`party` ALTER COLUMN `service_area_zip_code` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`party` ALTER COLUMN `service_area_zip_code` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`party` ALTER COLUMN `service_area_zip_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`party` ALTER COLUMN `signatory_name` SET TAGS ('pii_business_glossary_term' = 'Signatory Name');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`party` ALTER COLUMN `signatory_name` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`party` ALTER COLUMN `signatory_title` SET TAGS ('pii_business_glossary_term' = 'Signatory Title');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`party` ALTER COLUMN `source_system_code` SET TAGS ('pii_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`party` ALTER COLUMN `source_system_code` SET TAGS ('pii_value_regex' = 'cactus|provider_source|facets|qnxt|manual');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`party` ALTER COLUMN `source_system_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`party` ALTER COLUMN `source_system_party_reference` SET TAGS ('pii_business_glossary_term' = 'Source System Party ID');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`party` ALTER COLUMN `state_license_number` SET TAGS ('pii_business_glossary_term' = 'State License Number');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`party` ALTER COLUMN `state_license_number` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`party` ALTER COLUMN `state_license_number` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`party` ALTER COLUMN `tax_code` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`party` ALTER COLUMN `tax_code` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`party` ALTER COLUMN `termination_date` SET TAGS ('pii_business_glossary_term' = 'Party Termination Date');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`party` ALTER COLUMN `termination_date` SET TAGS ('pii_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`party` ALTER COLUMN `tin` SET TAGS ('pii_business_glossary_term' = 'Tax Identification Number (TIN)');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`party` ALTER COLUMN `tin` SET TAGS ('pii_value_regex' = '^[0-9]{9}$');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`party` ALTER COLUMN `tin` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`party` ALTER COLUMN `tin` SET TAGS ('pii_financial' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`party` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`party` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`party` ALTER COLUMN `vbc_arrangement_type` SET TAGS ('pii_business_glossary_term' = 'Value-Based Care (VBC) Arrangement Type');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`party` ALTER COLUMN `vbc_arrangement_type` SET TAGS ('pii_value_regex' = 'fee_for_service|capitation|bundled_payment|shared_savings|global_risk');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`term` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`term` SET TAGS ('pii_subdomain' = 'agreement_parties');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`term` SET TAGS ('pii_fhir_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`term` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`term` SET TAGS ('pii_fhir_resource' = 'Basic');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`term` SET TAGS ('pii_ecm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`term` SET TAGS ('pii_ssot' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`term` SET TAGS ('pii_fhir_interop' = 'ready');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`term` SET TAGS ('pii_authority_source' = 'verbatim_reviewer_comments_working_group_sheet');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`term` ALTER COLUMN `term_id` SET TAGS ('pii_business_glossary_term' = 'Contract Term ID');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`term` ALTER COLUMN `contract_amendment_id` SET TAGS ('pii_business_glossary_term' = 'Contract Amendment ID');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`term` ALTER COLUMN `provider_contract_id` SET TAGS ('pii_business_glossary_term' = 'Contract ID');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`term` ALTER COLUMN `fee_schedule_id` SET TAGS ('pii_business_glossary_term' = 'Fee Schedule ID');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`term` ALTER COLUMN `audit_rights_period_years` SET TAGS ('pii_business_glossary_term' = 'Audit Rights Retention Period (Years)');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`term` ALTER COLUMN `auto_renew` SET TAGS ('pii_business_glossary_term' = 'Auto-Renewal Indicator');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`term` ALTER COLUMN `capitation_rate` SET TAGS ('pii_business_glossary_term' = 'Capitation Rate (Per Member Per Month)');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`term` ALTER COLUMN `capitation_rate` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`term` ALTER COLUMN `compliance_checkpoint_date` SET TAGS ('pii_business_glossary_term' = 'Compliance Checkpoint Date');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`term` ALTER COLUMN `cpt_range_end` SET TAGS ('pii_business_glossary_term' = 'Current Procedural Terminology (CPT) / Healthcare Common Procedure Coding System (HCPCS) Range End');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`term` ALTER COLUMN `cpt_range_end` SET TAGS ('pii_value_regex' = '^[0-9A-Z]{5}$');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`term` ALTER COLUMN `cpt_range_start` SET TAGS ('pii_business_glossary_term' = 'Current Procedural Terminology (CPT) / Healthcare Common Procedure Coding System (HCPCS) Range Start');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`term` ALTER COLUMN `cpt_range_start` SET TAGS ('pii_value_regex' = '^[0-9A-Z]{5}$');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`term` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`term` ALTER COLUMN `created_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`term` ALTER COLUMN `data_quality_score` SET TAGS ('pii_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`term` ALTER COLUMN `dispute_resolution_method` SET TAGS ('pii_business_glossary_term' = 'Dispute Resolution Method');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`term` ALTER COLUMN `dispute_resolution_method` SET TAGS ('pii_value_regex' = 'arbitration|mediation|litigation|internal_review');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`term` ALTER COLUMN `drg_grouper_version` SET TAGS ('pii_business_glossary_term' = 'Diagnosis Related Group (DRG) Grouper Version');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`term` ALTER COLUMN `effective_date` SET TAGS ('pii_business_glossary_term' = 'Term Effective Date');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`term` ALTER COLUMN `effective_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`term` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`term` ALTER COLUMN `effective_end_date` SET TAGS ('pii_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`term` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`term` ALTER COLUMN `effective_start_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`term` ALTER COLUMN `expiration_date` SET TAGS ('pii_business_glossary_term' = 'Term Expiration Date');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`term` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`term` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`term` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`term` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`term` ALTER COLUMN `fhir_resource_reference` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`term` ALTER COLUMN `fhir_resource_reference` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`term` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`term` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`term` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`term` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`term` ALTER COLUMN `governing_state` SET TAGS ('pii_business_glossary_term' = 'Governing State');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`term` ALTER COLUMN `governing_state` SET TAGS ('pii_value_regex' = '^[A-Z]{2}$');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`term` ALTER COLUMN `hipaa_baa_required` SET TAGS ('pii_business_glossary_term' = 'Health Insurance Portability and Accountability Act (HIPAA) Business Associate Agreement (BAA) Required Indicator');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`term` ALTER COLUMN `icd_version` SET TAGS ('pii_business_glossary_term' = 'International Classification of Diseases (ICD) Version');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`term` ALTER COLUMN `icd_version` SET TAGS ('pii_value_regex' = 'ICD-10|ICD-11');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`term` ALTER COLUMN `incentive_amount` SET TAGS ('pii_business_glossary_term' = 'Quality Incentive Amount');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`term` ALTER COLUMN `incentive_amount` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`term` ALTER COLUMN `is_active` SET TAGS ('pii_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`term` ALTER COLUMN `is_adjudication_rule` SET TAGS ('pii_business_glossary_term' = 'Adjudication Rule Indicator');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`term` ALTER COLUMN `is_negotiable` SET TAGS ('pii_business_glossary_term' = 'Term Negotiable Indicator');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`term` ALTER COLUMN `is_standard_boilerplate` SET TAGS ('pii_business_glossary_term' = 'Standard Boilerplate Term Indicator');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`term` ALTER COLUMN `lob_applicability` SET TAGS ('pii_business_glossary_term' = 'Line of Business (LOB) Applicability');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`term` ALTER COLUMN `lob_applicability` SET TAGS ('pii_value_regex' = 'commercial|medicare_advantage|medicaid|marketplace|all');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`term` ALTER COLUMN `mac_pricing_basis` SET TAGS ('pii_business_glossary_term' = 'Maximum Allowable Cost (MAC) Pricing Basis');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`term` ALTER COLUMN `mac_pricing_basis` SET TAGS ('pii_value_regex' = 'awp|wac|mac|nadac|custom');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`term` ALTER COLUMN `master_entity_reference` SET TAGS ('pii_business_glossary_term' = 'Master Entity Id');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`term` ALTER COLUMN `payment_methodology` SET TAGS ('pii_business_glossary_term' = 'Payment Methodology');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`term` ALTER COLUMN `pos_code` SET TAGS ('pii_business_glossary_term' = 'Place of Service (POS) Code');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`term` ALTER COLUMN `pos_code` SET TAGS ('pii_value_regex' = '^[0-9]{2}$');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`term` ALTER COLUMN `pos_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`term` ALTER COLUMN `quality_metric_threshold` SET TAGS ('pii_business_glossary_term' = 'Quality Metric Threshold');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`term` ALTER COLUMN `record_created_at` SET TAGS ('pii_business_glossary_term' = 'Record Created At');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`term` ALTER COLUMN `record_source_system` SET TAGS ('pii_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`term` ALTER COLUMN `record_status` SET TAGS ('pii_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`term` ALTER COLUMN `record_status` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`term` ALTER COLUMN `record_updated_at` SET TAGS ('pii_business_glossary_term' = 'Record Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`term` ALTER COLUMN `record_version` SET TAGS ('pii_business_glossary_term' = 'Record Version');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`term` ALTER COLUMN `reduction_percentage` SET TAGS ('pii_business_glossary_term' = 'Reimbursement Reduction Percentage');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`term` ALTER COLUMN `reduction_percentage` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`term` ALTER COLUMN `reimbursement_policy_subtype` SET TAGS ('pii_business_glossary_term' = 'Reimbursement Policy Sub-Type');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`term` ALTER COLUMN `renewal_notice_days` SET TAGS ('pii_business_glossary_term' = 'Renewal Notice Period (Days)');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`term` ALTER COLUMN `risk_sharing_model` SET TAGS ('pii_business_glossary_term' = 'Risk Sharing Model');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`term` ALTER COLUMN `risk_sharing_model` SET TAGS ('pii_value_regex' = 'shared_savings|shared_risk|full_risk|upside_only|downside_only');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`term` ALTER COLUMN `source_system_term_ref` SET TAGS ('pii_business_glossary_term' = 'Source System Term Reference');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`term` ALTER COLUMN `summary` SET TAGS ('pii_business_glossary_term' = 'Contract Term Summary');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`term` ALTER COLUMN `term_number` SET TAGS ('pii_business_glossary_term' = 'Contract Term Number');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`term` ALTER COLUMN `term_number` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`term` ALTER COLUMN `term_status` SET TAGS ('pii_business_glossary_term' = 'Contract Term Status');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`term` ALTER COLUMN `term_status` SET TAGS ('pii_value_regex' = 'active|inactive|pending|superseded|expired|draft');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`term` ALTER COLUMN `term_type` SET TAGS ('pii_business_glossary_term' = 'Contract Term Type');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`term` ALTER COLUMN `termination_cause_type` SET TAGS ('pii_business_glossary_term' = 'Termination Cause Type');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`term` ALTER COLUMN `termination_cause_type` SET TAGS ('pii_value_regex' = 'for_cause|without_cause|mutual_agreement|regulatory');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`term` ALTER COLUMN `termination_notice_days` SET TAGS ('pii_business_glossary_term' = 'Termination Notice Period (Days)');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`term` ALTER COLUMN `text` SET TAGS ('pii_business_glossary_term' = 'Contract Term Text');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`term` ALTER COLUMN `text` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`term` ALTER COLUMN `title` SET TAGS ('pii_business_glossary_term' = 'Contract Term Title');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`term` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`term` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`term` ALTER COLUMN `withhold_percentage` SET TAGS ('pii_business_glossary_term' = 'Payment Withhold Percentage');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`term` ALTER COLUMN `withhold_percentage` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_amendment` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_amendment` SET TAGS ('pii_subdomain' = 'agreement_parties');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_amendment` SET TAGS ('pii_fhir_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_amendment` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_amendment` SET TAGS ('pii_fhir_resource' = 'Basic');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_amendment` SET TAGS ('pii_ecm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_amendment` SET TAGS ('pii_fhir_interop' = 'ready');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_amendment` SET TAGS ('pii_ssot_source_domain' = 'contract');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_amendment` SET TAGS ('pii_ssot_master' = 'amendment');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_amendment` SET TAGS ('pii_ssot_canonical' = 'contract.amendment');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_amendment` SET TAGS ('pii_ssot_role' = 'canonical');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_amendment` SET TAGS ('pii_authority_source' = 'verbatim_reviewer_comments_working_group_sheet');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_amendment` SET TAGS ('pii_ssot' = 'false');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_amendment` SET TAGS ('pii_deprecated' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_amendment` SET TAGS ('pii_ssot_ref' = 'plan.plan_amendment');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_amendment` SET TAGS ('pii_ssot_concept' = 'plan_amendment');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_amendment` ALTER COLUMN `contract_amendment_id` SET TAGS ('pii_business_glossary_term' = 'Amendment ID');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_amendment` ALTER COLUMN `employee_id` SET TAGS ('pii_business_glossary_term' = 'Approver Employee Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_amendment` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_amendment` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_amendment` ALTER COLUMN `provider_contract_id` SET TAGS ('pii_business_glossary_term' = 'Contract ID');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_amendment` ALTER COLUMN `fee_schedule_id` SET TAGS ('pii_business_glossary_term' = 'Fee Schedule ID');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_amendment` ALTER COLUMN `regulatory_change_id` SET TAGS ('pii_business_glossary_term' = 'Regulatory Change Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_amendment` ALTER COLUMN `superseded_amendment_id` SET TAGS ('pii_business_glossary_term' = 'Superseded Amendment ID');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_amendment` ALTER COLUMN `vbc_arrangement_id` SET TAGS ('pii_business_glossary_term' = 'Accountable Care Organization (ACO) Agreement ID');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_amendment` ALTER COLUMN `amendment_number` SET TAGS ('pii_business_glossary_term' = 'Amendment Number');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_amendment` ALTER COLUMN `amendment_number` SET TAGS ('pii_value_regex' = '^AMD-[0-9]{4}-[0-9]{6}-[0-9]{3}$');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_amendment` ALTER COLUMN `amendment_number` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_amendment` ALTER COLUMN `amendment_type` SET TAGS ('pii_business_glossary_term' = 'Amendment Type');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_amendment` ALTER COLUMN `amendment_type` SET TAGS ('pii_value_regex' = 'rate_change|term_modification|lob_addition|network_tier_change|scope_change|termination');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_amendment` ALTER COLUMN `approval_status` SET TAGS ('pii_business_glossary_term' = 'Approval Status');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_amendment` ALTER COLUMN `approval_status` SET TAGS ('pii_value_regex' = 'draft|pending_review|approved|rejected|executed|withdrawn');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_amendment` ALTER COLUMN `approved_date` SET TAGS ('pii_business_glossary_term' = 'Amendment Approved Date');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_amendment` ALTER COLUMN `capitation_rate_pmpm` SET TAGS ('pii_business_glossary_term' = 'Capitation Rate Per Member Per Month (PMPM)');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_amendment` ALTER COLUMN `capitation_rate_pmpm` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_amendment` ALTER COLUMN `claims_reprocess_required` SET TAGS ('pii_business_glossary_term' = 'Claims Reprocessing Required Flag');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_amendment` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_amendment` ALTER COLUMN `created_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_amendment` ALTER COLUMN `data_quality_score` SET TAGS ('pii_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_amendment` ALTER COLUMN `document_reference` SET TAGS ('pii_business_glossary_term' = 'Amendment Document Reference');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_amendment` ALTER COLUMN `effective_date` SET TAGS ('pii_business_glossary_term' = 'Amendment Effective Date');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_amendment` ALTER COLUMN `effective_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_amendment` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_amendment` ALTER COLUMN `effective_end_date` SET TAGS ('pii_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_amendment` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_amendment` ALTER COLUMN `effective_start_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_amendment` ALTER COLUMN `execution_date` SET TAGS ('pii_business_glossary_term' = 'Amendment Execution Date');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_amendment` ALTER COLUMN `expiration_date` SET TAGS ('pii_business_glossary_term' = 'Amendment Expiration Date');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_amendment` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_amendment` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_amendment` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_amendment` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_amendment` ALTER COLUMN `fhir_resource_reference` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_amendment` ALTER COLUMN `fhir_resource_reference` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_amendment` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_amendment` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_amendment` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_amendment` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_amendment` ALTER COLUMN `formulary_impact_flag` SET TAGS ('pii_business_glossary_term' = 'Formulary Impact Flag');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_amendment` ALTER COLUMN `initiating_party` SET TAGS ('pii_business_glossary_term' = 'Initiating Party');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_amendment` ALTER COLUMN `initiating_party` SET TAGS ('pii_value_regex' = 'health_plan|provider|regulatory|mutual');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_amendment` ALTER COLUMN `internal_notes` SET TAGS ('pii_business_glossary_term' = 'Internal Amendment Notes');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_amendment` ALTER COLUMN `internal_notes` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_amendment` ALTER COLUMN `is_active` SET TAGS ('pii_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_amendment` ALTER COLUMN `lob_code` SET TAGS ('pii_business_glossary_term' = 'Line of Business (LOB) Code');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_amendment` ALTER COLUMN `lob_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_amendment` ALTER COLUMN `master_entity_reference` SET TAGS ('pii_business_glossary_term' = 'Master Entity Id');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_amendment` ALTER COLUMN `negotiation_notes` SET TAGS ('pii_business_glossary_term' = 'Negotiation Notes');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_amendment` ALTER COLUMN `negotiation_notes` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_amendment` ALTER COLUMN `negotiation_outcome` SET TAGS ('pii_business_glossary_term' = 'Negotiation Outcome');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_amendment` ALTER COLUMN `negotiation_outcome` SET TAGS ('pii_value_regex' = 'agreed|counter_proposed|arbitrated|mediated|withdrawn');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_amendment` ALTER COLUMN `negotiation_outcome` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_amendment` ALTER COLUMN `network_tier` SET TAGS ('pii_business_glossary_term' = 'Network Tier');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_amendment` ALTER COLUMN `network_tier` SET TAGS ('pii_value_regex' = 'tier_1|tier_2|tier_3|out_of_network');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_amendment` ALTER COLUMN `payment_methodology` SET TAGS ('pii_business_glossary_term' = 'Payment Methodology');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_amendment` ALTER COLUMN `plan_signatory_name` SET TAGS ('pii_business_glossary_term' = 'Health Plan Signatory Name');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_amendment` ALTER COLUMN `prior_auth_impact_flag` SET TAGS ('pii_business_glossary_term' = 'Prior Authorization (PA) Impact Flag');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_amendment` ALTER COLUMN `provider_signatory_name` SET TAGS ('pii_business_glossary_term' = 'Provider Signatory Name');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_amendment` ALTER COLUMN `rate_change_pct` SET TAGS ('pii_business_glossary_term' = 'Rate Change Percentage');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_amendment` ALTER COLUMN `rate_change_pct` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_amendment` ALTER COLUMN `rate_effective_date` SET TAGS ('pii_business_glossary_term' = 'Rate Effective Date');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_amendment` ALTER COLUMN `reason` SET TAGS ('pii_business_glossary_term' = 'Amendment Reason');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_amendment` ALTER COLUMN `record_created_at` SET TAGS ('pii_business_glossary_term' = 'Record Created At');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_amendment` ALTER COLUMN `record_source_system` SET TAGS ('pii_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_amendment` ALTER COLUMN `record_status` SET TAGS ('pii_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_amendment` ALTER COLUMN `record_status` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_amendment` ALTER COLUMN `record_updated_at` SET TAGS ('pii_business_glossary_term' = 'Record Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_amendment` ALTER COLUMN `record_version` SET TAGS ('pii_business_glossary_term' = 'Record Version');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_amendment` ALTER COLUMN `regulatory_mandate_flag` SET TAGS ('pii_business_glossary_term' = 'Regulatory Mandate Flag');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_amendment` ALTER COLUMN `regulatory_reference` SET TAGS ('pii_business_glossary_term' = 'Regulatory Reference');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_amendment` ALTER COLUMN `retroactive_flag` SET TAGS ('pii_business_glossary_term' = 'Retroactive Amendment Flag');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_amendment` ALTER COLUMN `retroactive_start_date` SET TAGS ('pii_business_glossary_term' = 'Retroactive Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_amendment` ALTER COLUMN `risk_share_pct` SET TAGS ('pii_business_glossary_term' = 'Risk Share Percentage');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_amendment` ALTER COLUMN `risk_share_pct` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_amendment` ALTER COLUMN `sections_modified` SET TAGS ('pii_business_glossary_term' = 'Contract Sections Modified');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_amendment` ALTER COLUMN `submitted_date` SET TAGS ('pii_business_glossary_term' = 'Amendment Submitted Date');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_amendment` ALTER COLUMN `title` SET TAGS ('pii_business_glossary_term' = 'Amendment Title');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_amendment` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_amendment` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_amendment` ALTER COLUMN `vbc_target_metric` SET TAGS ('pii_business_glossary_term' = 'Value-Based Care (VBC) Target Metric');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_amendment` ALTER COLUMN `version_number` SET TAGS ('pii_business_glossary_term' = 'Amendment Version Number');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_amendment` ALTER COLUMN `version_number` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`fee_schedule` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`fee_schedule` SET TAGS ('pii_subdomain' = 'payment_reimbursement');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`fee_schedule` SET TAGS ('pii_fhir_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`fee_schedule` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`fee_schedule` SET TAGS ('pii_fhir_resource' = 'Basic');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`fee_schedule` SET TAGS ('pii_ecm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`fee_schedule` SET TAGS ('pii_ssot' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`fee_schedule` SET TAGS ('pii_fhir_interop' = 'ready');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`fee_schedule` SET TAGS ('pii_authority_source' = 'verbatim_reviewer_comments_working_group_sheet');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`fee_schedule` ALTER COLUMN `fee_schedule_id` SET TAGS ('pii_business_glossary_term' = 'Fee Schedule ID');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`fee_schedule` ALTER COLUMN `health_plan_id` SET TAGS ('pii_business_glossary_term' = 'Plan ID');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`fee_schedule` ALTER COLUMN `health_plan_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`fee_schedule` ALTER COLUMN `health_plan_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`fee_schedule` ALTER COLUMN `ledger_id` SET TAGS ('pii_business_glossary_term' = 'Ledger Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`fee_schedule` ALTER COLUMN `provider_id` SET TAGS ('pii_business_glossary_term' = 'Provider ID');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`fee_schedule` ALTER COLUMN `provider_network_id` SET TAGS ('pii_business_glossary_term' = 'Network ID');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`fee_schedule` ALTER COLUMN `pool_id` SET TAGS ('pii_business_glossary_term' = 'Risk Pool Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`fee_schedule` ALTER COLUMN `superseded_by_fee_schedule_id` SET TAGS ('pii_business_glossary_term' = 'Superseded By Fee Schedule ID');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`fee_schedule` ALTER COLUMN `fee_provider_contract_id` SET TAGS ('pii_business_glossary_term' = 'Provider Contract Id');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`fee_schedule` ALTER COLUMN `provider_contract_id` SET TAGS ('pii_business_glossary_term' = 'Contract ID');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`fee_schedule` ALTER COLUMN `amendment_number` SET TAGS ('pii_business_glossary_term' = 'Amendment Number');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`fee_schedule` ALTER COLUMN `amendment_number` SET TAGS ('pii_value_regex' = '^[A-Z0-9-]{1,20}$');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`fee_schedule` ALTER COLUMN `amendment_number` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`fee_schedule` ALTER COLUMN `anesthesia_applicable` SET TAGS ('pii_business_glossary_term' = 'Anesthesia Applicable Flag');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`fee_schedule` ALTER COLUMN `anesthesia_conversion_factor` SET TAGS ('pii_business_glossary_term' = 'Anesthesia Conversion Factor');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`fee_schedule` ALTER COLUMN `anesthesia_conversion_factor` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`fee_schedule` ALTER COLUMN `approval_date` SET TAGS ('pii_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`fee_schedule` ALTER COLUMN `cms_fee_schedule_year` SET TAGS ('pii_business_glossary_term' = 'CMS Fee Schedule Year');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`fee_schedule` ALTER COLUMN `conversion_factor` SET TAGS ('pii_business_glossary_term' = 'Relative Value Unit (RVU) Conversion Factor');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`fee_schedule` ALTER COLUMN `conversion_factor` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`fee_schedule` ALTER COLUMN `coordination_of_benefits_applicable` SET TAGS ('pii_business_glossary_term' = 'Coordination of Benefits (COB) Applicable Flag');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`fee_schedule` ALTER COLUMN `cpt_code_range_end` SET TAGS ('pii_business_glossary_term' = 'Current Procedural Terminology (CPT) Code Range End');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`fee_schedule` ALTER COLUMN `cpt_code_range_end` SET TAGS ('pii_value_regex' = '^[0-9]{5}$');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`fee_schedule` ALTER COLUMN `cpt_code_range_start` SET TAGS ('pii_business_glossary_term' = 'Current Procedural Terminology (CPT) Code Range Start');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`fee_schedule` ALTER COLUMN `cpt_code_range_start` SET TAGS ('pii_value_regex' = '^[0-9]{5}$');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`fee_schedule` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`fee_schedule` ALTER COLUMN `created_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`fee_schedule` ALTER COLUMN `data_quality_score` SET TAGS ('pii_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`fee_schedule` ALTER COLUMN `fee_schedule_description` SET TAGS ('pii_business_glossary_term' = 'Fee Schedule Description');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`fee_schedule` ALTER COLUMN `drg_applicable` SET TAGS ('pii_business_glossary_term' = 'Diagnosis Related Group (DRG) Applicable Flag');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`fee_schedule` ALTER COLUMN `drg_base_rate` SET TAGS ('pii_business_glossary_term' = 'Diagnosis Related Group (DRG) Base Rate');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`fee_schedule` ALTER COLUMN `drg_base_rate` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`fee_schedule` ALTER COLUMN `effective_date` SET TAGS ('pii_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`fee_schedule` ALTER COLUMN `effective_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`fee_schedule` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`fee_schedule` ALTER COLUMN `effective_end_date` SET TAGS ('pii_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`fee_schedule` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`fee_schedule` ALTER COLUMN `effective_start_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`fee_schedule` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`fee_schedule` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`fee_schedule` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`fee_schedule` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`fee_schedule` ALTER COLUMN `fhir_resource_reference` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`fee_schedule` ALTER COLUMN `fhir_resource_reference` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`fee_schedule` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`fee_schedule` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`fee_schedule` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`fee_schedule` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`fee_schedule` ALTER COLUMN `geographic_modifier_applicable` SET TAGS ('pii_business_glossary_term' = 'Geographic Modifier Applicable Flag');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`fee_schedule` ALTER COLUMN `global_surgery_applicable` SET TAGS ('pii_business_glossary_term' = 'Global Surgery Applicable Flag');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`fee_schedule` ALTER COLUMN `is_active` SET TAGS ('pii_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`fee_schedule` ALTER COLUMN `lob_code` SET TAGS ('pii_business_glossary_term' = 'Line of Business (LOB) Code');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`fee_schedule` ALTER COLUMN `lob_code` SET TAGS ('pii_value_regex' = 'commercial|medicare_advantage|medicaid|marketplace|cobra|fehb');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`fee_schedule` ALTER COLUMN `lob_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`fee_schedule` ALTER COLUMN `locality_code` SET TAGS ('pii_business_glossary_term' = 'CMS Locality Code');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`fee_schedule` ALTER COLUMN `locality_code` SET TAGS ('pii_value_regex' = '^[0-9]{2}$');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`fee_schedule` ALTER COLUMN `locality_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`fee_schedule` ALTER COLUMN `master_entity_reference` SET TAGS ('pii_business_glossary_term' = 'Master Entity Id');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`fee_schedule` ALTER COLUMN `medicare_crossover_applicable` SET TAGS ('pii_business_glossary_term' = 'Medicare Crossover Applicable Flag');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`fee_schedule` ALTER COLUMN `modifier_applicable` SET TAGS ('pii_business_glossary_term' = 'CPT/HCPCS Modifier Applicable Flag');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`fee_schedule` ALTER COLUMN `outlier_threshold_amt` SET TAGS ('pii_business_glossary_term' = 'Outlier Threshold Amount');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`fee_schedule` ALTER COLUMN `outlier_threshold_amt` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`fee_schedule` ALTER COLUMN `payment_basis` SET TAGS ('pii_business_glossary_term' = 'Payment Basis');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`fee_schedule` ALTER COLUMN `payment_basis_pct` SET TAGS ('pii_business_glossary_term' = 'Payment Basis Percentage');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`fee_schedule` ALTER COLUMN `payment_basis_pct` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`fee_schedule` ALTER COLUMN `prior_authorization_required` SET TAGS ('pii_business_glossary_term' = 'Prior Authorization (PA) Required Flag');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`fee_schedule` ALTER COLUMN `record_created_at` SET TAGS ('pii_business_glossary_term' = 'Record Created At');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`fee_schedule` ALTER COLUMN `record_source_system` SET TAGS ('pii_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`fee_schedule` ALTER COLUMN `record_status` SET TAGS ('pii_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`fee_schedule` ALTER COLUMN `record_status` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`fee_schedule` ALTER COLUMN `record_updated_at` SET TAGS ('pii_business_glossary_term' = 'Record Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`fee_schedule` ALTER COLUMN `record_version` SET TAGS ('pii_business_glossary_term' = 'Record Version');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`fee_schedule` ALTER COLUMN `referral_required` SET TAGS ('pii_business_glossary_term' = 'Referral Required Flag');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`fee_schedule` ALTER COLUMN `schedule_code` SET TAGS ('pii_business_glossary_term' = 'Fee Schedule Code');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`fee_schedule` ALTER COLUMN `schedule_code` SET TAGS ('pii_value_regex' = '^[A-Z0-9_-]{2,30}$');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`fee_schedule` ALTER COLUMN `schedule_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`fee_schedule` ALTER COLUMN `schedule_name` SET TAGS ('pii_business_glossary_term' = 'Fee Schedule Name');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`fee_schedule` ALTER COLUMN `schedule_status` SET TAGS ('pii_business_glossary_term' = 'Fee Schedule Status');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`fee_schedule` ALTER COLUMN `schedule_status` SET TAGS ('pii_value_regex' = 'draft|active|suspended|terminated|superseded');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`fee_schedule` ALTER COLUMN `schedule_type` SET TAGS ('pii_business_glossary_term' = 'Fee Schedule Type');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`fee_schedule` ALTER COLUMN `schedule_type` SET TAGS ('pii_value_regex' = 'professional|institutional|ancillary|dme|lab|pharmacy');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`fee_schedule` ALTER COLUMN `service_category` SET TAGS ('pii_business_glossary_term' = 'Service Category');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`fee_schedule` ALTER COLUMN `source` SET TAGS ('pii_business_glossary_term' = 'Fee Schedule Source');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`fee_schedule` ALTER COLUMN `source` SET TAGS ('pii_value_regex' = 'cms_medicare|cms_medicaid|negotiated|custom|rbp_benchmark');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`fee_schedule` ALTER COLUMN `state_code` SET TAGS ('pii_business_glossary_term' = 'State Code');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`fee_schedule` ALTER COLUMN `state_code` SET TAGS ('pii_value_regex' = '^[A-Z]{2}$');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`fee_schedule` ALTER COLUMN `state_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`fee_schedule` ALTER COLUMN `state_code` SET TAGS ('pii_fhir_element' = 'address.state');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`fee_schedule` ALTER COLUMN `stop_loss_applicable` SET TAGS ('pii_business_glossary_term' = 'Stop Loss Applicable Flag');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`fee_schedule` ALTER COLUMN `stop_loss_threshold_amt` SET TAGS ('pii_business_glossary_term' = 'Stop Loss Threshold Amount');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`fee_schedule` ALTER COLUMN `stop_loss_threshold_amt` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`fee_schedule` ALTER COLUMN `termination_date` SET TAGS ('pii_business_glossary_term' = 'Termination Date');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`fee_schedule` ALTER COLUMN `termination_date` SET TAGS ('pii_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`fee_schedule` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`fee_schedule` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`fee_schedule` ALTER COLUMN `version_number` SET TAGS ('pii_business_glossary_term' = 'Fee Schedule Version Number');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`fee_schedule` ALTER COLUMN `version_number` SET TAGS ('pii_value_regex' = '^[0-9]+.[0-9]+(.[0-9]+)?$');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`fee_schedule` ALTER COLUMN `version_number` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`fee_schedule_rate` SET TAGS ('pii_data_type' = 'reference_data');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`fee_schedule_rate` SET TAGS ('pii_subdomain' = 'payment_reimbursement');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`fee_schedule_rate` SET TAGS ('pii_fhir_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`fee_schedule_rate` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`fee_schedule_rate` SET TAGS ('pii_fhir_resource' = 'InsurancePlan.plan.specificCost');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`fee_schedule_rate` SET TAGS ('pii_ecm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`fee_schedule_rate` SET TAGS ('pii_ssot' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`fee_schedule_rate` SET TAGS ('pii_fhir_interop' = 'ready');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`fee_schedule_rate` SET TAGS ('pii_authority_source' = 'verbatim_reviewer_comments_working_group_sheet');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`fee_schedule_rate` ALTER COLUMN `fee_schedule_rate_id` SET TAGS ('pii_business_glossary_term' = 'Fee Schedule Rate ID');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`fee_schedule_rate` ALTER COLUMN `provider_contract_id` SET TAGS ('pii_business_glossary_term' = 'Contract ID');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`fee_schedule_rate` ALTER COLUMN `fee_schedule_id` SET TAGS ('pii_business_glossary_term' = 'Fee Schedule ID');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`fee_schedule_rate` ALTER COLUMN `prior_rate_fee_schedule_rate_id` SET TAGS ('pii_business_glossary_term' = 'Prior Rate ID');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`fee_schedule_rate` ALTER COLUMN `allowed_amount` SET TAGS ('pii_business_glossary_term' = 'Allowed Amount (Contracted Rate)');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`fee_schedule_rate` ALTER COLUMN `allowed_amount` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`fee_schedule_rate` ALTER COLUMN `awp_percent` SET TAGS ('pii_business_glossary_term' = 'Average Wholesale Price (AWP) Percentage');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`fee_schedule_rate` ALTER COLUMN `awp_percent` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`fee_schedule_rate` ALTER COLUMN `bilateral_indicator` SET TAGS ('pii_business_glossary_term' = 'Bilateral Procedure Indicator');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`fee_schedule_rate` ALTER COLUMN `bundled_payment_amount` SET TAGS ('pii_business_glossary_term' = 'Bundled Payment Amount');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`fee_schedule_rate` ALTER COLUMN `bundled_payment_amount` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`fee_schedule_rate` ALTER COLUMN `capitation_rate_pmpm` SET TAGS ('pii_business_glossary_term' = 'Capitation Rate Per Member Per Month (PMPM)');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`fee_schedule_rate` ALTER COLUMN `capitation_rate_pmpm` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`fee_schedule_rate` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`fee_schedule_rate` ALTER COLUMN `created_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`fee_schedule_rate` ALTER COLUMN `data_quality_score` SET TAGS ('pii_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`fee_schedule_rate` ALTER COLUMN `drg_code` SET TAGS ('pii_business_glossary_term' = 'Diagnosis Related Group (DRG) Code');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`fee_schedule_rate` ALTER COLUMN `drg_code` SET TAGS ('pii_value_regex' = '^[0-9]{3}$');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`fee_schedule_rate` ALTER COLUMN `drg_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`fee_schedule_rate` ALTER COLUMN `effective_date` SET TAGS ('pii_business_glossary_term' = 'Rate Effective Date');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`fee_schedule_rate` ALTER COLUMN `effective_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`fee_schedule_rate` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`fee_schedule_rate` ALTER COLUMN `effective_end_date` SET TAGS ('pii_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`fee_schedule_rate` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`fee_schedule_rate` ALTER COLUMN `effective_start_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`fee_schedule_rate` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`fee_schedule_rate` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`fee_schedule_rate` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`fee_schedule_rate` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`fee_schedule_rate` ALTER COLUMN `fhir_resource_reference` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`fee_schedule_rate` ALTER COLUMN `fhir_resource_reference` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`fee_schedule_rate` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`fee_schedule_rate` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`fee_schedule_rate` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`fee_schedule_rate` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`fee_schedule_rate` ALTER COLUMN `geographic_region` SET TAGS ('pii_business_glossary_term' = 'Geographic Region');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`fee_schedule_rate` ALTER COLUMN `global_surgery_days` SET TAGS ('pii_business_glossary_term' = 'Global Surgery Period Days');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`fee_schedule_rate` ALTER COLUMN `is_active` SET TAGS ('pii_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`fee_schedule_rate` ALTER COLUMN `line_of_business` SET TAGS ('pii_business_glossary_term' = 'Line of Business (LOB)');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`fee_schedule_rate` ALTER COLUMN `line_of_business` SET TAGS ('pii_value_regex' = 'COMMERCIAL|MEDICARE|MEDICAID|MARKETPLACE|CHIP|TRICARE');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`fee_schedule_rate` ALTER COLUMN `mac_amount` SET TAGS ('pii_business_glossary_term' = 'Maximum Allowable Cost (MAC) Amount');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`fee_schedule_rate` ALTER COLUMN `mac_amount` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`fee_schedule_rate` ALTER COLUMN `master_entity_reference` SET TAGS ('pii_business_glossary_term' = 'Master Entity Id');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`fee_schedule_rate` ALTER COLUMN `max_units_per_day` SET TAGS ('pii_business_glossary_term' = 'Maximum Units Per Day');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`fee_schedule_rate` ALTER COLUMN `max_units_per_year` SET TAGS ('pii_business_glossary_term' = 'Maximum Units Per Year');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`fee_schedule_rate` ALTER COLUMN `medicare_fee_schedule_pct` SET TAGS ('pii_business_glossary_term' = 'Medicare Fee Schedule Percentage');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`fee_schedule_rate` ALTER COLUMN `medicare_fee_schedule_pct` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`fee_schedule_rate` ALTER COLUMN `ncci_edit_indicator` SET TAGS ('pii_business_glossary_term' = 'National Correct Coding Initiative (NCCI) Edit Indicator');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`fee_schedule_rate` ALTER COLUMN `network_tier` SET TAGS ('pii_business_glossary_term' = 'Network Tier');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`fee_schedule_rate` ALTER COLUMN `network_tier` SET TAGS ('pii_value_regex' = 'IN_NETWORK|OUT_OF_NETWORK|TIER_1|TIER_2|TIER_3|PREFERRED');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`fee_schedule_rate` ALTER COLUMN `payment_methodology` SET TAGS ('pii_business_glossary_term' = 'Payment Methodology');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`fee_schedule_rate` ALTER COLUMN `per_diem_rate` SET TAGS ('pii_business_glossary_term' = 'Per Diem Rate');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`fee_schedule_rate` ALTER COLUMN `per_diem_rate` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`fee_schedule_rate` ALTER COLUMN `place_of_service_code` SET TAGS ('pii_business_glossary_term' = 'Place of Service (POS) Code');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`fee_schedule_rate` ALTER COLUMN `place_of_service_code` SET TAGS ('pii_value_regex' = '^[0-9]{2}$');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`fee_schedule_rate` ALTER COLUMN `place_of_service_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`fee_schedule_rate` ALTER COLUMN `procedure_code` SET TAGS ('pii_business_glossary_term' = 'Current Procedural Terminology / Healthcare Common Procedure Coding System (CPT/HCPCS) Procedure Code');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`fee_schedule_rate` ALTER COLUMN `procedure_code` SET TAGS ('pii_value_regex' = '^[A-Z0-9]{4,7}$');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`fee_schedule_rate` ALTER COLUMN `procedure_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`fee_schedule_rate` ALTER COLUMN `procedure_code_type` SET TAGS ('pii_business_glossary_term' = 'Procedure Code Type');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`fee_schedule_rate` ALTER COLUMN `procedure_modifier_1` SET TAGS ('pii_business_glossary_term' = 'Procedure Modifier 1 (CPT/HCPCS Modifier)');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`fee_schedule_rate` ALTER COLUMN `procedure_modifier_1` SET TAGS ('pii_value_regex' = '^[A-Z0-9]{2}$');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`fee_schedule_rate` ALTER COLUMN `procedure_modifier_2` SET TAGS ('pii_business_glossary_term' = 'Procedure Modifier 2 (CPT/HCPCS Modifier)');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`fee_schedule_rate` ALTER COLUMN `procedure_modifier_2` SET TAGS ('pii_value_regex' = '^[A-Z0-9]{2}$');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`fee_schedule_rate` ALTER COLUMN `product_type` SET TAGS ('pii_business_glossary_term' = 'Product Type (Health Plan Product Type)');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`fee_schedule_rate` ALTER COLUMN `product_type` SET TAGS ('pii_value_regex' = 'HMO|PPO|EPO|POS|HDHP|INDEMNITY');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`fee_schedule_rate` ALTER COLUMN `provider_type` SET TAGS ('pii_business_glossary_term' = 'Provider Type');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`fee_schedule_rate` ALTER COLUMN `provider_type` SET TAGS ('pii_value_regex' = 'PHYSICIAN|FACILITY|ANCILLARY|DME|PHARMACY|BEHAVIORAL_HEALTH');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`fee_schedule_rate` ALTER COLUMN `rate_derivation_method` SET TAGS ('pii_business_glossary_term' = 'Rate Derivation Method');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`fee_schedule_rate` ALTER COLUMN `rate_line_number` SET TAGS ('pii_business_glossary_term' = 'Rate Line Number');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`fee_schedule_rate` ALTER COLUMN `rate_line_number` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`fee_schedule_rate` ALTER COLUMN `rate_note` SET TAGS ('pii_business_glossary_term' = 'Rate Note');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`fee_schedule_rate` ALTER COLUMN `rate_percent_of_billed` SET TAGS ('pii_business_glossary_term' = 'Rate Percent of Billed Charges');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`fee_schedule_rate` ALTER COLUMN `rate_percent_of_billed` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`fee_schedule_rate` ALTER COLUMN `rate_source` SET TAGS ('pii_business_glossary_term' = 'Rate Source');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`fee_schedule_rate` ALTER COLUMN `rate_source` SET TAGS ('pii_value_regex' = 'CONTRACT|CMS_PUBLISHED|CROSSWALK|MANUAL|SYSTEM_GENERATED');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`fee_schedule_rate` ALTER COLUMN `rate_status` SET TAGS ('pii_business_glossary_term' = 'Rate Status');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`fee_schedule_rate` ALTER COLUMN `rate_status` SET TAGS ('pii_value_regex' = 'ACTIVE|INACTIVE|PENDING|SUPERSEDED|TERMINATED');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`fee_schedule_rate` ALTER COLUMN `rate_version` SET TAGS ('pii_business_glossary_term' = 'Rate Version Number');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`fee_schedule_rate` ALTER COLUMN `rbp_reference_amount` SET TAGS ('pii_business_glossary_term' = 'Reference Based Pricing (RBP) Reference Amount');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`fee_schedule_rate` ALTER COLUMN `rbp_reference_amount` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`fee_schedule_rate` ALTER COLUMN `record_created_at` SET TAGS ('pii_business_glossary_term' = 'Record Created At');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`fee_schedule_rate` ALTER COLUMN `record_source_system` SET TAGS ('pii_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`fee_schedule_rate` ALTER COLUMN `record_status` SET TAGS ('pii_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`fee_schedule_rate` ALTER COLUMN `record_status` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`fee_schedule_rate` ALTER COLUMN `record_updated_at` SET TAGS ('pii_business_glossary_term' = 'Record Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`fee_schedule_rate` ALTER COLUMN `record_version` SET TAGS ('pii_business_glossary_term' = 'Record Version');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`fee_schedule_rate` ALTER COLUMN `revenue_code` SET TAGS ('pii_business_glossary_term' = 'Revenue Code (UB-04 Revenue Code)');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`fee_schedule_rate` ALTER COLUMN `revenue_code` SET TAGS ('pii_value_regex' = '^[0-9]{4}$');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`fee_schedule_rate` ALTER COLUMN `revenue_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`fee_schedule_rate` ALTER COLUMN `service_category` SET TAGS ('pii_business_glossary_term' = 'Service Category');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`fee_schedule_rate` ALTER COLUMN `specialty_code` SET TAGS ('pii_business_glossary_term' = 'Provider Specialty Code (CMS Specialty Code)');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`fee_schedule_rate` ALTER COLUMN `specialty_code` SET TAGS ('pii_value_regex' = '^[0-9]{3}$');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`fee_schedule_rate` ALTER COLUMN `specialty_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`fee_schedule_rate` ALTER COLUMN `state_code` SET TAGS ('pii_business_glossary_term' = 'State Code (US State Code)');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`fee_schedule_rate` ALTER COLUMN `state_code` SET TAGS ('pii_value_regex' = '^[A-Z]{2}$');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`fee_schedule_rate` ALTER COLUMN `state_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`fee_schedule_rate` ALTER COLUMN `state_code` SET TAGS ('pii_fhir_element' = 'address.state');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`fee_schedule_rate` ALTER COLUMN `termination_date` SET TAGS ('pii_business_glossary_term' = 'Rate Termination Date');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`fee_schedule_rate` ALTER COLUMN `termination_date` SET TAGS ('pii_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`fee_schedule_rate` ALTER COLUMN `units_of_service` SET TAGS ('pii_business_glossary_term' = 'Units of Service');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`fee_schedule_rate` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`fee_schedule_rate` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`capitation_arrangement` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`capitation_arrangement` SET TAGS ('pii_subdomain' = 'payment_reimbursement');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`capitation_arrangement` SET TAGS ('pii_fhir_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`capitation_arrangement` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`capitation_arrangement` SET TAGS ('pii_fhir_resource' = 'Basic');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`capitation_arrangement` SET TAGS ('pii_ecm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`capitation_arrangement` SET TAGS ('pii_ssot' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`capitation_arrangement` SET TAGS ('pii_fhir_interop' = 'ready');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`capitation_arrangement` SET TAGS ('pii_authority_source' = 'verbatim_reviewer_comments_working_group_sheet');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`capitation_arrangement` ALTER COLUMN `capitation_arrangement_id` SET TAGS ('pii_business_glossary_term' = 'Capitation Arrangement ID');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`capitation_arrangement` ALTER COLUMN `provider_contract_id` SET TAGS ('pii_business_glossary_term' = 'Contract ID');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`capitation_arrangement` ALTER COLUMN `cost_center_id` SET TAGS ('pii_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`capitation_arrangement` ALTER COLUMN `health_plan_id` SET TAGS ('pii_business_glossary_term' = 'Plan ID');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`capitation_arrangement` ALTER COLUMN `health_plan_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`capitation_arrangement` ALTER COLUMN `health_plan_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`capitation_arrangement` ALTER COLUMN `provider_id` SET TAGS ('pii_business_glossary_term' = 'Provider ID');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`capitation_arrangement` ALTER COLUMN `pool_id` SET TAGS ('pii_business_glossary_term' = 'Risk Pool Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`capitation_arrangement` ALTER COLUMN `aco_arrangement_flag` SET TAGS ('pii_business_glossary_term' = 'Accountable Care Organization (ACO) Arrangement Flag');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`capitation_arrangement` ALTER COLUMN `aggregate_stop_loss_threshold` SET TAGS ('pii_business_glossary_term' = 'Aggregate Stop-Loss Threshold');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`capitation_arrangement` ALTER COLUMN `aggregate_stop_loss_threshold` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`capitation_arrangement` ALTER COLUMN `amendment_number` SET TAGS ('pii_business_glossary_term' = 'Amendment Number');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`capitation_arrangement` ALTER COLUMN `amendment_number` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`capitation_arrangement` ALTER COLUMN `annual_rate_escalator` SET TAGS ('pii_business_glossary_term' = 'Annual Rate Escalator Percentage');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`capitation_arrangement` ALTER COLUMN `annual_rate_escalator` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`capitation_arrangement` ALTER COLUMN `approval_date` SET TAGS ('pii_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`capitation_arrangement` ALTER COLUMN `approved_by` SET TAGS ('pii_business_glossary_term' = 'Approved By');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`capitation_arrangement` ALTER COLUMN `arrangement_name` SET TAGS ('pii_business_glossary_term' = 'Capitation Arrangement Name');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`capitation_arrangement` ALTER COLUMN `arrangement_number` SET TAGS ('pii_business_glossary_term' = 'Capitation Arrangement Number');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`capitation_arrangement` ALTER COLUMN `arrangement_number` SET TAGS ('pii_value_regex' = '^CAP-[A-Z0-9]{4,20}$');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`capitation_arrangement` ALTER COLUMN `arrangement_number` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`capitation_arrangement` ALTER COLUMN `arrangement_status` SET TAGS ('pii_business_glossary_term' = 'Capitation Arrangement Status');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`capitation_arrangement` ALTER COLUMN `arrangement_status` SET TAGS ('pii_value_regex' = 'draft|pending_approval|active|suspended|terminated|expired');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`capitation_arrangement` ALTER COLUMN `arrangement_type` SET TAGS ('pii_business_glossary_term' = 'Capitation Arrangement Type');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`capitation_arrangement` ALTER COLUMN `arrangement_type` SET TAGS ('pii_value_regex' = 'global_capitation|primary_care_capitation|specialty_capitation|institutional_capitation|behavioral_health_capitation|pharmacy_capitation');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`capitation_arrangement` ALTER COLUMN `attributed_member_count` SET TAGS ('pii_business_glossary_term' = 'Attributed Member Count');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`capitation_arrangement` ALTER COLUMN `attribution_method` SET TAGS ('pii_business_glossary_term' = 'Attribution Method');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`capitation_arrangement` ALTER COLUMN `attribution_method` SET TAGS ('pii_value_regex' = 'pcp_assignment|claims_based|voluntary_selection|geographic|hybrid');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`capitation_arrangement` ALTER COLUMN `auto_renewal_flag` SET TAGS ('pii_business_glossary_term' = 'Auto-Renewal Flag');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`capitation_arrangement` ALTER COLUMN `carve_out_services` SET TAGS ('pii_business_glossary_term' = 'Carve-Out Services');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`capitation_arrangement` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`capitation_arrangement` ALTER COLUMN `created_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`capitation_arrangement` ALTER COLUMN `data_quality_score` SET TAGS ('pii_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`capitation_arrangement` ALTER COLUMN `effective_date` SET TAGS ('pii_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`capitation_arrangement` ALTER COLUMN `effective_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`capitation_arrangement` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`capitation_arrangement` ALTER COLUMN `effective_end_date` SET TAGS ('pii_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`capitation_arrangement` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`capitation_arrangement` ALTER COLUMN `effective_start_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`capitation_arrangement` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`capitation_arrangement` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`capitation_arrangement` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`capitation_arrangement` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`capitation_arrangement` ALTER COLUMN `fhir_resource_reference` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`capitation_arrangement` ALTER COLUMN `fhir_resource_reference` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`capitation_arrangement` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`capitation_arrangement` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`capitation_arrangement` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`capitation_arrangement` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`capitation_arrangement` ALTER COLUMN `geographic_service_area` SET TAGS ('pii_business_glossary_term' = 'Geographic Service Area');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`capitation_arrangement` ALTER COLUMN `individual_stop_loss_threshold` SET TAGS ('pii_business_glossary_term' = 'Individual Stop-Loss Threshold');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`capitation_arrangement` ALTER COLUMN `individual_stop_loss_threshold` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`capitation_arrangement` ALTER COLUMN `is_active` SET TAGS ('pii_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`capitation_arrangement` ALTER COLUMN `lob_code` SET TAGS ('pii_business_glossary_term' = 'Line of Business (LOB) Code');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`capitation_arrangement` ALTER COLUMN `lob_code` SET TAGS ('pii_value_regex' = 'commercial|medicare_advantage|medicaid|chip|exchange|dual_eligible');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`capitation_arrangement` ALTER COLUMN `lob_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`capitation_arrangement` ALTER COLUMN `master_entity_reference` SET TAGS ('pii_business_glossary_term' = 'Master Entity Id');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`capitation_arrangement` ALTER COLUMN `network_tier` SET TAGS ('pii_business_glossary_term' = 'Network Tier');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`capitation_arrangement` ALTER COLUMN `network_tier` SET TAGS ('pii_value_regex' = 'tier_1|tier_2|tier_3|narrow_network|broad_network');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`capitation_arrangement` ALTER COLUMN `payment_frequency` SET TAGS ('pii_business_glossary_term' = 'Payment Frequency');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`capitation_arrangement` ALTER COLUMN `payment_frequency` SET TAGS ('pii_value_regex' = 'monthly|quarterly|semi_annual|annual');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`capitation_arrangement` ALTER COLUMN `payment_methodology` SET TAGS ('pii_business_glossary_term' = 'Payment Methodology');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`capitation_arrangement` ALTER COLUMN `payment_methodology` SET TAGS ('pii_value_regex' = 'pure_capitation|capitation_with_withhold|capitation_with_bonus|risk_adjusted_capitation|tiered_capitation');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`capitation_arrangement` ALTER COLUMN `pmpm_rate` SET TAGS ('pii_business_glossary_term' = 'Per Member Per Month (PMPM) Rate');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`capitation_arrangement` ALTER COLUMN `pmpm_rate` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`capitation_arrangement` ALTER COLUMN `pmpm_rate_currency` SET TAGS ('pii_business_glossary_term' = 'Per Member Per Month (PMPM) Rate Currency');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`capitation_arrangement` ALTER COLUMN `pmpm_rate_currency` SET TAGS ('pii_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`capitation_arrangement` ALTER COLUMN `quality_withhold_release_criteria` SET TAGS ('pii_business_glossary_term' = 'Quality Withhold Release Criteria');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`capitation_arrangement` ALTER COLUMN `raf_adjustment_factor` SET TAGS ('pii_business_glossary_term' = 'Risk Adjustment Factor (RAF) Adjustment Factor');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`capitation_arrangement` ALTER COLUMN `rate_effective_date` SET TAGS ('pii_business_glossary_term' = 'Rate Effective Date');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`capitation_arrangement` ALTER COLUMN `rate_expiration_date` SET TAGS ('pii_business_glossary_term' = 'Rate Expiration Date');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`capitation_arrangement` ALTER COLUMN `record_created_at` SET TAGS ('pii_business_glossary_term' = 'Record Created At');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`capitation_arrangement` ALTER COLUMN `record_source_system` SET TAGS ('pii_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`capitation_arrangement` ALTER COLUMN `record_status` SET TAGS ('pii_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`capitation_arrangement` ALTER COLUMN `record_status` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`capitation_arrangement` ALTER COLUMN `record_updated_at` SET TAGS ('pii_business_glossary_term' = 'Record Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`capitation_arrangement` ALTER COLUMN `record_version` SET TAGS ('pii_business_glossary_term' = 'Record Version');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`capitation_arrangement` ALTER COLUMN `risk_adjustment_applicable` SET TAGS ('pii_business_glossary_term' = 'Risk Adjustment Applicable Flag');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`capitation_arrangement` ALTER COLUMN `risk_pool_participant` SET TAGS ('pii_business_glossary_term' = 'Risk Pool Participant Flag');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`capitation_arrangement` ALTER COLUMN `risk_share_percentage` SET TAGS ('pii_business_glossary_term' = 'Risk Share Percentage');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`capitation_arrangement` ALTER COLUMN `risk_share_percentage` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`capitation_arrangement` ALTER COLUMN `service_category_scope` SET TAGS ('pii_business_glossary_term' = 'Service Category Scope');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`capitation_arrangement` ALTER COLUMN `source_system_code` SET TAGS ('pii_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`capitation_arrangement` ALTER COLUMN `source_system_code` SET TAGS ('pii_value_regex' = 'FACETS|QNXT|CACTUS|PROVIDER_SOURCE|MANUAL');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`capitation_arrangement` ALTER COLUMN `source_system_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`capitation_arrangement` ALTER COLUMN `source_system_record_reference` SET TAGS ('pii_business_glossary_term' = 'Source System Record ID');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`capitation_arrangement` ALTER COLUMN `stop_loss_type` SET TAGS ('pii_business_glossary_term' = 'Stop-Loss Type');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`capitation_arrangement` ALTER COLUMN `stop_loss_type` SET TAGS ('pii_value_regex' = 'individual|aggregate|both|none');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`capitation_arrangement` ALTER COLUMN `termination_date` SET TAGS ('pii_business_glossary_term' = 'Termination Date');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`capitation_arrangement` ALTER COLUMN `termination_date` SET TAGS ('pii_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`capitation_arrangement` ALTER COLUMN `termination_notice_days` SET TAGS ('pii_business_glossary_term' = 'Termination Notice Days');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`capitation_arrangement` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`capitation_arrangement` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`capitation_arrangement` ALTER COLUMN `vbc_arrangement_flag` SET TAGS ('pii_business_glossary_term' = 'Value-Based Care (VBC) Arrangement Flag');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`capitation_arrangement` ALTER COLUMN `withhold_percentage` SET TAGS ('pii_business_glossary_term' = 'Withhold Percentage');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`capitation_arrangement` ALTER COLUMN `withhold_percentage` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`capitation_payment` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`capitation_payment` SET TAGS ('pii_subdomain' = 'payment_reimbursement');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`capitation_payment` SET TAGS ('pii_fhir_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`capitation_payment` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`capitation_payment` SET TAGS ('pii_fhir_resource' = 'PaymentReconciliation');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`capitation_payment` SET TAGS ('pii_ecm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`capitation_payment` SET TAGS ('pii_ssot' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`capitation_payment` SET TAGS ('pii_fhir_interop' = 'ready');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`capitation_payment` SET TAGS ('pii_authority_source' = 'verbatim_reviewer_comments_working_group_sheet');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`capitation_payment` ALTER COLUMN `capitation_payment_id` SET TAGS ('pii_business_glossary_term' = 'Capitation Payment ID');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`capitation_payment` ALTER COLUMN `employee_id` SET TAGS ('pii_business_glossary_term' = 'Approved By Employee Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`capitation_payment` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`capitation_payment` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`capitation_payment` ALTER COLUMN `capitation_arrangement_id` SET TAGS ('pii_business_glossary_term' = 'Capitation Arrangement ID');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`capitation_payment` ALTER COLUMN `provider_contract_id` SET TAGS ('pii_business_glossary_term' = 'Contract ID');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`capitation_payment` ALTER COLUMN `health_plan_id` SET TAGS ('pii_business_glossary_term' = 'Plan ID');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`capitation_payment` ALTER COLUMN `health_plan_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`capitation_payment` ALTER COLUMN `health_plan_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`capitation_payment` ALTER COLUMN `original_payment_capitation_payment_id` SET TAGS ('pii_business_glossary_term' = 'Original Payment ID');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`capitation_payment` ALTER COLUMN `provider_id` SET TAGS ('pii_business_glossary_term' = 'Provider ID');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`capitation_payment` ALTER COLUMN `ap_voucher_number` SET TAGS ('pii_business_glossary_term' = 'Accounts Payable (AP) Voucher Number');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`capitation_payment` ALTER COLUMN `ap_voucher_number` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`capitation_payment` ALTER COLUMN `attributed_member_count` SET TAGS ('pii_business_glossary_term' = 'Attributed Member Count');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`capitation_payment` ALTER COLUMN `capitation_rate_tier` SET TAGS ('pii_business_glossary_term' = 'Capitation Rate Tier');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`capitation_payment` ALTER COLUMN `check_eft_trace_number` SET TAGS ('pii_business_glossary_term' = 'Check / EFT Trace Number');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`capitation_payment` ALTER COLUMN `check_eft_trace_number` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`capitation_payment` ALTER COLUMN `check_eft_trace_number` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`capitation_payment` ALTER COLUMN `check_eft_trace_number` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`capitation_payment` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`capitation_payment` ALTER COLUMN `created_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`capitation_payment` ALTER COLUMN `currency_code` SET TAGS ('pii_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`capitation_payment` ALTER COLUMN `currency_code` SET TAGS ('pii_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`capitation_payment` ALTER COLUMN `currency_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`capitation_payment` ALTER COLUMN `data_quality_score` SET TAGS ('pii_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`capitation_payment` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`capitation_payment` ALTER COLUMN `effective_end_date` SET TAGS ('pii_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`capitation_payment` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`capitation_payment` ALTER COLUMN `effective_start_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`capitation_payment` ALTER COLUMN `enrollment_adjustment_amount` SET TAGS ('pii_business_glossary_term' = 'Enrollment Adjustment Amount');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`capitation_payment` ALTER COLUMN `enrollment_adjustment_amount` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`capitation_payment` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`capitation_payment` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`capitation_payment` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`capitation_payment` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`capitation_payment` ALTER COLUMN `fhir_resource_reference` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`capitation_payment` ALTER COLUMN `fhir_resource_reference` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`capitation_payment` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`capitation_payment` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`capitation_payment` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`capitation_payment` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`capitation_payment` ALTER COLUMN `gl_cost_center` SET TAGS ('pii_business_glossary_term' = 'General Ledger (GL) Cost Center');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`capitation_payment` ALTER COLUMN `gross_payment_amount` SET TAGS ('pii_business_glossary_term' = 'Gross Capitation Payment Amount');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`capitation_payment` ALTER COLUMN `gross_payment_amount` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`capitation_payment` ALTER COLUMN `is_active` SET TAGS ('pii_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`capitation_payment` ALTER COLUMN `line_of_business` SET TAGS ('pii_business_glossary_term' = 'Line of Business (LOB)');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`capitation_payment` ALTER COLUMN `line_of_business` SET TAGS ('pii_value_regex' = 'commercial|medicare_advantage|medicaid|chip|exchange');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`capitation_payment` ALTER COLUMN `master_entity_reference` SET TAGS ('pii_business_glossary_term' = 'Master Entity Id');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`capitation_payment` ALTER COLUMN `net_payment_amount` SET TAGS ('pii_business_glossary_term' = 'Net Capitation Payment Amount');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`capitation_payment` ALTER COLUMN `net_payment_amount` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`capitation_payment` ALTER COLUMN `other_adjustment_amount` SET TAGS ('pii_business_glossary_term' = 'Other Adjustment Amount');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`capitation_payment` ALTER COLUMN `other_adjustment_amount` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`capitation_payment` ALTER COLUMN `payment_approval_date` SET TAGS ('pii_business_glossary_term' = 'Payment Approval Date');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`capitation_payment` ALTER COLUMN `payment_date` SET TAGS ('pii_business_glossary_term' = 'Payment Date');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`capitation_payment` ALTER COLUMN `payment_method` SET TAGS ('pii_business_glossary_term' = 'Payment Method');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`capitation_payment` ALTER COLUMN `payment_method` SET TAGS ('pii_value_regex' = 'eft|ach|check|wire');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`capitation_payment` ALTER COLUMN `payment_number` SET TAGS ('pii_business_glossary_term' = 'Payment Number');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`capitation_payment` ALTER COLUMN `payment_number` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`capitation_payment` ALTER COLUMN `payment_period_end_date` SET TAGS ('pii_business_glossary_term' = 'Payment Period End Date');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`capitation_payment` ALTER COLUMN `payment_period_start_date` SET TAGS ('pii_business_glossary_term' = 'Payment Period Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`capitation_payment` ALTER COLUMN `payment_run_number` SET TAGS ('pii_business_glossary_term' = 'Payment Run ID');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`capitation_payment` ALTER COLUMN `payment_run_number` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`capitation_payment` ALTER COLUMN `payment_status` SET TAGS ('pii_business_glossary_term' = 'Payment Status');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`capitation_payment` ALTER COLUMN `payment_status` SET TAGS ('pii_value_regex' = 'pending|approved|paid|voided|reversed|on_hold');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`capitation_payment` ALTER COLUMN `payment_type` SET TAGS ('pii_business_glossary_term' = 'Payment Type');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`capitation_payment` ALTER COLUMN `payment_type` SET TAGS ('pii_value_regex' = 'standard|retroactive|adjustment|stop_loss_recovery|risk_pool_settlement');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`capitation_payment` ALTER COLUMN `pmpm_rate` SET TAGS ('pii_business_glossary_term' = 'Per Member Per Month (PMPM) Rate');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`capitation_payment` ALTER COLUMN `pmpm_rate` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`capitation_payment` ALTER COLUMN `prior_period_adjustment_flag` SET TAGS ('pii_business_glossary_term' = 'Prior Period Adjustment Flag');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`capitation_payment` ALTER COLUMN `quality_withhold_amount` SET TAGS ('pii_business_glossary_term' = 'Quality Withhold Amount');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`capitation_payment` ALTER COLUMN `quality_withhold_amount` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`capitation_payment` ALTER COLUMN `record_created_at` SET TAGS ('pii_business_glossary_term' = 'Record Created At');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`capitation_payment` ALTER COLUMN `record_source_system` SET TAGS ('pii_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`capitation_payment` ALTER COLUMN `record_status` SET TAGS ('pii_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`capitation_payment` ALTER COLUMN `record_status` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`capitation_payment` ALTER COLUMN `record_updated_at` SET TAGS ('pii_business_glossary_term' = 'Record Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`capitation_payment` ALTER COLUMN `record_version` SET TAGS ('pii_business_glossary_term' = 'Record Version');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`capitation_payment` ALTER COLUMN `remittance_advice_number` SET TAGS ('pii_business_glossary_term' = 'Remittance Advice Number');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`capitation_payment` ALTER COLUMN `remittance_advice_number` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`capitation_payment` ALTER COLUMN `risk_adjusted_pmpm_rate` SET TAGS ('pii_business_glossary_term' = 'Risk-Adjusted Per Member Per Month (PMPM) Rate');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`capitation_payment` ALTER COLUMN `risk_adjusted_pmpm_rate` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`capitation_payment` ALTER COLUMN `risk_pool_withhold_amount` SET TAGS ('pii_business_glossary_term' = 'Risk Pool Withhold Amount');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`capitation_payment` ALTER COLUMN `risk_pool_withhold_amount` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`capitation_payment` ALTER COLUMN `risk_score` SET TAGS ('pii_business_glossary_term' = 'Risk Adjustment Factor (RAF) Score');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`capitation_payment` ALTER COLUMN `source_system_payment_reference` SET TAGS ('pii_business_glossary_term' = 'Source System Payment ID');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`capitation_payment` ALTER COLUMN `stop_loss_recovery_amount` SET TAGS ('pii_business_glossary_term' = 'Stop-Loss Recovery Amount');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`capitation_payment` ALTER COLUMN `stop_loss_recovery_amount` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`capitation_payment` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`capitation_payment` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`capitation_payment` ALTER COLUMN `vbc_contract_flag` SET TAGS ('pii_business_glossary_term' = 'Value-Based Care (VBC) Contract Flag');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`capitation_payment` ALTER COLUMN `void_reason` SET TAGS ('pii_business_glossary_term' = 'Void / Reversal Reason');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`vbc_contract` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`vbc_contract` SET TAGS ('pii_subdomain' = 'value_performance');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`vbc_contract` SET TAGS ('pii_fhir_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`vbc_contract` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`vbc_contract` SET TAGS ('pii_fhir_resource' = 'Basic');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`vbc_contract` SET TAGS ('pii_ecm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`vbc_contract` SET TAGS ('pii_ssot' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`vbc_contract` SET TAGS ('pii_fhir_interop' = 'ready');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`vbc_contract` SET TAGS ('pii_authority_source' = 'verbatim_reviewer_comments_working_group_sheet');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`vbc_contract` ALTER COLUMN `vbc_contract_id` SET TAGS ('pii_business_glossary_term' = 'Value-Based Care (VBC) Contract ID');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`vbc_contract` ALTER COLUMN `provider_contract_id` SET TAGS ('pii_business_glossary_term' = 'Provider Contract Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`vbc_contract` ALTER COLUMN `health_plan_id` SET TAGS ('pii_business_glossary_term' = 'Plan Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`vbc_contract` ALTER COLUMN `health_plan_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`vbc_contract` ALTER COLUMN `health_plan_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`vbc_contract` ALTER COLUMN `pool_id` SET TAGS ('pii_business_glossary_term' = 'Risk Pool Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`vbc_contract` ALTER COLUMN `aco_cms_identifier` SET TAGS ('pii_business_glossary_term' = 'ACO CMS Identification Number');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`vbc_contract` ALTER COLUMN `aco_cms_identifier` SET TAGS ('pii_value_regex' = '^A[0-9]{4}$');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`vbc_contract` ALTER COLUMN `aco_entity_name` SET TAGS ('pii_business_glossary_term' = 'Accountable Care Organization (ACO) / Independent Practice Association (IPA) Entity Name');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`vbc_contract` ALTER COLUMN `aco_entity_tin` SET TAGS ('pii_business_glossary_term' = 'ACO / IPA Entity Tax Identification Number (TIN)');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`vbc_contract` ALTER COLUMN `aco_entity_tin` SET TAGS ('pii_value_regex' = '^[0-9]{9}$');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`vbc_contract` ALTER COLUMN `aco_entity_tin` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`vbc_contract` ALTER COLUMN `actual_expenditure` SET TAGS ('pii_business_glossary_term' = 'Actual Expenditure');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`vbc_contract` ALTER COLUMN `actual_expenditure` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`vbc_contract` ALTER COLUMN `amendment_effective_date` SET TAGS ('pii_business_glossary_term' = 'Amendment Effective Date');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`vbc_contract` ALTER COLUMN `attributed_member_count` SET TAGS ('pii_business_glossary_term' = 'Attributed Member Count');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`vbc_contract` ALTER COLUMN `attribution_methodology` SET TAGS ('pii_business_glossary_term' = 'Attribution Methodology');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`vbc_contract` ALTER COLUMN `attribution_methodology` SET TAGS ('pii_value_regex' = 'prospective|retrospective|voluntary');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`vbc_contract` ALTER COLUMN `auto_renewal_flag` SET TAGS ('pii_business_glossary_term' = 'Auto-Renewal Flag');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`vbc_contract` ALTER COLUMN `benchmark_expenditure_target` SET TAGS ('pii_business_glossary_term' = 'Benchmark Expenditure Target');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`vbc_contract` ALTER COLUMN `benchmark_expenditure_target` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`vbc_contract` ALTER COLUMN `cms_program_track` SET TAGS ('pii_business_glossary_term' = 'CMS Program Track');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`vbc_contract` ALTER COLUMN `contract_amendment_number` SET TAGS ('pii_business_glossary_term' = 'Contract Amendment Number');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`vbc_contract` ALTER COLUMN `contract_amendment_number` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`vbc_contract` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`vbc_contract` ALTER COLUMN `created_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`vbc_contract` ALTER COLUMN `data_quality_score` SET TAGS ('pii_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`vbc_contract` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`vbc_contract` ALTER COLUMN `effective_end_date` SET TAGS ('pii_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`vbc_contract` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`vbc_contract` ALTER COLUMN `effective_start_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`vbc_contract` ALTER COLUMN `episode_target_price` SET TAGS ('pii_business_glossary_term' = 'Bundled Payment Episode Target Price');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`vbc_contract` ALTER COLUMN `episode_target_price` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`vbc_contract` ALTER COLUMN `episode_trigger_code` SET TAGS ('pii_business_glossary_term' = 'Episode Trigger Procedure / DRG Code');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`vbc_contract` ALTER COLUMN `episode_trigger_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`vbc_contract` ALTER COLUMN `episode_type` SET TAGS ('pii_business_glossary_term' = 'Bundled Payment Episode Type');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`vbc_contract` ALTER COLUMN `episode_window_days` SET TAGS ('pii_business_glossary_term' = 'Episode Window (Days)');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`vbc_contract` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`vbc_contract` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`vbc_contract` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`vbc_contract` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`vbc_contract` ALTER COLUMN `fhir_resource_reference` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`vbc_contract` ALTER COLUMN `fhir_resource_reference` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`vbc_contract` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`vbc_contract` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`vbc_contract` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`vbc_contract` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`vbc_contract` ALTER COLUMN `hedis_measure_targets` SET TAGS ('pii_business_glossary_term' = 'Healthcare Effectiveness Data and Information Set (HEDIS) / STAR Measure Targets');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`vbc_contract` ALTER COLUMN `is_active` SET TAGS ('pii_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`vbc_contract` ALTER COLUMN `line_of_business` SET TAGS ('pii_business_glossary_term' = 'Line of Business (LOB)');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`vbc_contract` ALTER COLUMN `line_of_business` SET TAGS ('pii_value_regex' = 'commercial|medicare_advantage|medicaid|mssp|bpci_a|exchange');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`vbc_contract` ALTER COLUMN `master_entity_reference` SET TAGS ('pii_business_glossary_term' = 'Master Entity Id');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`vbc_contract` ALTER COLUMN `max_shared_loss_rate` SET TAGS ('pii_business_glossary_term' = 'Maximum Shared Loss Rate');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`vbc_contract` ALTER COLUMN `max_shared_savings_rate` SET TAGS ('pii_business_glossary_term' = 'Maximum Shared Savings Rate');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`vbc_contract` ALTER COLUMN `minimum_loss_rate` SET TAGS ('pii_business_glossary_term' = 'Minimum Loss Rate (MLR)');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`vbc_contract` ALTER COLUMN `minimum_savings_rate` SET TAGS ('pii_business_glossary_term' = 'Minimum Savings Rate (MSR)');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`vbc_contract` ALTER COLUMN `performance_period_end` SET TAGS ('pii_business_glossary_term' = 'Performance Period End Date');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`vbc_contract` ALTER COLUMN `performance_period_start` SET TAGS ('pii_business_glossary_term' = 'Performance Period Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`vbc_contract` ALTER COLUMN `performance_year` SET TAGS ('pii_business_glossary_term' = 'Performance Year');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`vbc_contract` ALTER COLUMN `quality_gate_met` SET TAGS ('pii_business_glossary_term' = 'Quality Gate Met Indicator');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`vbc_contract` ALTER COLUMN `quality_score` SET TAGS ('pii_business_glossary_term' = 'Quality Score');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`vbc_contract` ALTER COLUMN `reconciliation_methodology` SET TAGS ('pii_business_glossary_term' = 'Reconciliation Methodology');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`vbc_contract` ALTER COLUMN `reconciliation_methodology` SET TAGS ('pii_value_regex' = 'prospective|retrospective|hybrid');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`vbc_contract` ALTER COLUMN `reconciliation_status` SET TAGS ('pii_business_glossary_term' = 'Reconciliation Status');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`vbc_contract` ALTER COLUMN `reconciliation_status` SET TAGS ('pii_value_regex' = 'pending|in_progress|completed|disputed|settled');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`vbc_contract` ALTER COLUMN `record_created_at` SET TAGS ('pii_business_glossary_term' = 'Record Created At');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`vbc_contract` ALTER COLUMN `record_source_system` SET TAGS ('pii_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`vbc_contract` ALTER COLUMN `record_status` SET TAGS ('pii_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`vbc_contract` ALTER COLUMN `record_status` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`vbc_contract` ALTER COLUMN `record_updated_at` SET TAGS ('pii_business_glossary_term' = 'Record Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`vbc_contract` ALTER COLUMN `record_version` SET TAGS ('pii_business_glossary_term' = 'Record Version');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`vbc_contract` ALTER COLUMN `risk_arrangement_type` SET TAGS ('pii_business_glossary_term' = 'Risk Arrangement Type');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`vbc_contract` ALTER COLUMN `risk_arrangement_type` SET TAGS ('pii_value_regex' = 'upside_only|two_sided|full_risk|partial_risk');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`vbc_contract` ALTER COLUMN `risk_corridor_lower` SET TAGS ('pii_business_glossary_term' = 'Risk Corridor Lower Bound');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`vbc_contract` ALTER COLUMN `risk_corridor_upper` SET TAGS ('pii_business_glossary_term' = 'Risk Corridor Upper Bound');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`vbc_contract` ALTER COLUMN `savings_sharing_rate` SET TAGS ('pii_business_glossary_term' = 'Savings Sharing Rate');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`vbc_contract` ALTER COLUMN `settlement_date` SET TAGS ('pii_business_glossary_term' = 'Settlement Date');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`vbc_contract` ALTER COLUMN `shared_savings_amount` SET TAGS ('pii_business_glossary_term' = 'Shared Savings / Shared Loss Amount');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`vbc_contract` ALTER COLUMN `shared_savings_amount` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`vbc_contract` ALTER COLUMN `stop_loss_threshold` SET TAGS ('pii_business_glossary_term' = 'Stop-Loss Threshold Amount');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`vbc_contract` ALTER COLUMN `stop_loss_threshold` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`vbc_contract` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`vbc_contract` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`vbc_contract` ALTER COLUMN `vbc_model_type` SET TAGS ('pii_business_glossary_term' = 'Value-Based Care (VBC) Model Type');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`vbc_contract` ALTER COLUMN `vbc_model_type` SET TAGS ('pii_value_regex' = 'shared_savings|shared_risk|full_capitation|bundled_payment|pay_for_performance');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`vbc_performance_period` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`vbc_performance_period` SET TAGS ('pii_subdomain' = 'value_performance');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`vbc_performance_period` SET TAGS ('pii_fhir_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`vbc_performance_period` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`vbc_performance_period` SET TAGS ('pii_fhir_resource' = 'Basic');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`vbc_performance_period` SET TAGS ('pii_ecm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`vbc_performance_period` SET TAGS ('pii_ssot' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`vbc_performance_period` SET TAGS ('pii_fhir_interop' = 'ready');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`vbc_performance_period` SET TAGS ('pii_authority_source' = 'verbatim_reviewer_comments_working_group_sheet');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`vbc_performance_period` ALTER COLUMN `vbc_performance_period_id` SET TAGS ('pii_business_glossary_term' = 'Value-Based Care (VBC) Performance Period ID');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`vbc_performance_period` ALTER COLUMN `vbc_contract_id` SET TAGS ('pii_business_glossary_term' = 'Value-Based Care (VBC) Contract ID');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`vbc_performance_period` ALTER COLUMN `aco_identifier` SET TAGS ('pii_business_glossary_term' = 'Accountable Care Organization (ACO) ID');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`vbc_performance_period` ALTER COLUMN `actual_expenditure` SET TAGS ('pii_business_glossary_term' = 'Actual Expenditure');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`vbc_performance_period` ALTER COLUMN `actual_expenditure` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`vbc_performance_period` ALTER COLUMN `actual_pmpm` SET TAGS ('pii_business_glossary_term' = 'Actual Per Member Per Month (PMPM)');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`vbc_performance_period` ALTER COLUMN `actual_pmpm` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`vbc_performance_period` ALTER COLUMN `appeal_deadline_date` SET TAGS ('pii_business_glossary_term' = 'Appeal Deadline Date');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`vbc_performance_period` ALTER COLUMN `attributed_member_count` SET TAGS ('pii_business_glossary_term' = 'Attributed Member Count');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`vbc_performance_period` ALTER COLUMN `benchmark_expenditure_target` SET TAGS ('pii_business_glossary_term' = 'Benchmark Expenditure Target');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`vbc_performance_period` ALTER COLUMN `benchmark_expenditure_target` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`vbc_performance_period` ALTER COLUMN `benchmark_pmpm` SET TAGS ('pii_business_glossary_term' = 'Benchmark Per Member Per Month (PMPM)');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`vbc_performance_period` ALTER COLUMN `benchmark_pmpm` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`vbc_performance_period` ALTER COLUMN `benchmark_update_method` SET TAGS ('pii_business_glossary_term' = 'Benchmark Update Method');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`vbc_performance_period` ALTER COLUMN `benchmark_update_method` SET TAGS ('pii_value_regex' = 'historical|regional|blended|prospective');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`vbc_performance_period` ALTER COLUMN `cahps_composite_score` SET TAGS ('pii_business_glossary_term' = 'Consumer Assessment of Healthcare Providers and Systems (CAHPS) Composite Score');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`vbc_performance_period` ALTER COLUMN `cms_program_track` SET TAGS ('pii_business_glossary_term' = 'Centers for Medicare and Medicaid Services (CMS) Program Track');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`vbc_performance_period` ALTER COLUMN `cms_program_track` SET TAGS ('pii_value_regex' = 'BASIC_A|BASIC_B|BASIC_C|BASIC_D|BASIC_E|ENHANCED');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`vbc_performance_period` ALTER COLUMN `cms_submission_date` SET TAGS ('pii_business_glossary_term' = 'Centers for Medicare and Medicaid Services (CMS) Submission Date');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`vbc_performance_period` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`vbc_performance_period` ALTER COLUMN `created_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`vbc_performance_period` ALTER COLUMN `data_quality_score` SET TAGS ('pii_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`vbc_performance_period` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`vbc_performance_period` ALTER COLUMN `effective_end_date` SET TAGS ('pii_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`vbc_performance_period` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`vbc_performance_period` ALTER COLUMN `effective_start_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`vbc_performance_period` ALTER COLUMN `end_date` SET TAGS ('pii_business_glossary_term' = 'Performance Period End Date');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`vbc_performance_period` ALTER COLUMN `expenditure_variance` SET TAGS ('pii_business_glossary_term' = 'Expenditure Variance');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`vbc_performance_period` ALTER COLUMN `expenditure_variance` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`vbc_performance_period` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`vbc_performance_period` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`vbc_performance_period` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`vbc_performance_period` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`vbc_performance_period` ALTER COLUMN `fhir_resource_reference` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`vbc_performance_period` ALTER COLUMN `fhir_resource_reference` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`vbc_performance_period` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`vbc_performance_period` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`vbc_performance_period` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`vbc_performance_period` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`vbc_performance_period` ALTER COLUMN `hcc_capture_rate` SET TAGS ('pii_business_glossary_term' = 'Hierarchical Condition Category (HCC) Capture Rate');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`vbc_performance_period` ALTER COLUMN `hedis_composite_score` SET TAGS ('pii_business_glossary_term' = 'Healthcare Effectiveness Data and Information Set (HEDIS) Composite Score');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`vbc_performance_period` ALTER COLUMN `ibnr_reserve_amount` SET TAGS ('pii_business_glossary_term' = 'Incurred But Not Reported (IBNR) Reserve Amount');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`vbc_performance_period` ALTER COLUMN `ibnr_reserve_amount` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`vbc_performance_period` ALTER COLUMN `is_active` SET TAGS ('pii_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`vbc_performance_period` ALTER COLUMN `lob` SET TAGS ('pii_business_glossary_term' = 'Line of Business (LOB)');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`vbc_performance_period` ALTER COLUMN `lob` SET TAGS ('pii_value_regex' = 'medicare|medicaid|commercial|marketplace|dsnp');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`vbc_performance_period` ALTER COLUMN `master_entity_reference` SET TAGS ('pii_business_glossary_term' = 'Master Entity Id');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`vbc_performance_period` ALTER COLUMN `minimum_loss_rate` SET TAGS ('pii_business_glossary_term' = 'Minimum Loss Rate (MLR)');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`vbc_performance_period` ALTER COLUMN `minimum_loss_rate` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`vbc_performance_period` ALTER COLUMN `minimum_savings_rate` SET TAGS ('pii_business_glossary_term' = 'Minimum Savings Rate (MSR)');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`vbc_performance_period` ALTER COLUMN `minimum_savings_rate` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`vbc_performance_period` ALTER COLUMN `net_settlement_amount` SET TAGS ('pii_business_glossary_term' = 'Net Settlement Amount');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`vbc_performance_period` ALTER COLUMN `net_settlement_amount` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`vbc_performance_period` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Performance Period Notes');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`vbc_performance_period` ALTER COLUMN `payment_model` SET TAGS ('pii_business_glossary_term' = 'Payment Model');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`vbc_performance_period` ALTER COLUMN `payment_model` SET TAGS ('pii_value_regex' = 'shared_savings|shared_risk|capitation|bundled|global_budget|fee_for_service');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`vbc_performance_period` ALTER COLUMN `performance_period_number` SET TAGS ('pii_business_glossary_term' = 'Performance Period Number');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`vbc_performance_period` ALTER COLUMN `performance_period_number` SET TAGS ('pii_value_regex' = '^PP-[0-9]{4}-[0-9]{3}$');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`vbc_performance_period` ALTER COLUMN `performance_period_number` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`vbc_performance_period` ALTER COLUMN `performance_year` SET TAGS ('pii_business_glossary_term' = 'Performance Year');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`vbc_performance_period` ALTER COLUMN `period_status` SET TAGS ('pii_business_glossary_term' = 'Performance Period Status');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`vbc_performance_period` ALTER COLUMN `period_status` SET TAGS ('pii_value_regex' = 'open|closed|reconciled|settled|disputed|voided');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`vbc_performance_period` ALTER COLUMN `period_type` SET TAGS ('pii_business_glossary_term' = 'Performance Period Type');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`vbc_performance_period` ALTER COLUMN `period_type` SET TAGS ('pii_value_regex' = 'annual|semi_annual|quarterly|interim|final');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`vbc_performance_period` ALTER COLUMN `prior_period_adjustment` SET TAGS ('pii_business_glossary_term' = 'Prior Period Adjustment Amount');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`vbc_performance_period` ALTER COLUMN `prior_period_adjustment` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`vbc_performance_period` ALTER COLUMN `quality_gate_met` SET TAGS ('pii_business_glossary_term' = 'Quality Gate Met Indicator');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`vbc_performance_period` ALTER COLUMN `quality_score` SET TAGS ('pii_business_glossary_term' = 'Quality Score');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`vbc_performance_period` ALTER COLUMN `raf_score` SET TAGS ('pii_business_glossary_term' = 'Risk Adjustment Factor (RAF) Score');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`vbc_performance_period` ALTER COLUMN `reconciliation_date` SET TAGS ('pii_business_glossary_term' = 'Reconciliation Date');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`vbc_performance_period` ALTER COLUMN `reconciliation_status` SET TAGS ('pii_business_glossary_term' = 'Reconciliation Status');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`vbc_performance_period` ALTER COLUMN `reconciliation_status` SET TAGS ('pii_value_regex' = 'pending|in_progress|complete|disputed|appealed|final');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`vbc_performance_period` ALTER COLUMN `record_created_at` SET TAGS ('pii_business_glossary_term' = 'Record Created At');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`vbc_performance_period` ALTER COLUMN `record_source_system` SET TAGS ('pii_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`vbc_performance_period` ALTER COLUMN `record_status` SET TAGS ('pii_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`vbc_performance_period` ALTER COLUMN `record_status` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`vbc_performance_period` ALTER COLUMN `record_updated_at` SET TAGS ('pii_business_glossary_term' = 'Record Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`vbc_performance_period` ALTER COLUMN `record_version` SET TAGS ('pii_business_glossary_term' = 'Record Version');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`vbc_performance_period` ALTER COLUMN `risk_model` SET TAGS ('pii_business_glossary_term' = 'Risk Model');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`vbc_performance_period` ALTER COLUMN `risk_model` SET TAGS ('pii_value_regex' = 'one_sided|two_sided|full_risk|partial_risk');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`vbc_performance_period` ALTER COLUMN `settlement_date` SET TAGS ('pii_business_glossary_term' = 'Settlement Date');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`vbc_performance_period` ALTER COLUMN `shared_loss_amount` SET TAGS ('pii_business_glossary_term' = 'Shared Loss Amount');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`vbc_performance_period` ALTER COLUMN `shared_loss_amount` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`vbc_performance_period` ALTER COLUMN `shared_loss_rate` SET TAGS ('pii_business_glossary_term' = 'Shared Loss Rate');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`vbc_performance_period` ALTER COLUMN `shared_loss_rate` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`vbc_performance_period` ALTER COLUMN `shared_savings_amount` SET TAGS ('pii_business_glossary_term' = 'Shared Savings Amount');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`vbc_performance_period` ALTER COLUMN `shared_savings_amount` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`vbc_performance_period` ALTER COLUMN `shared_savings_rate` SET TAGS ('pii_business_glossary_term' = 'Shared Savings Rate');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`vbc_performance_period` ALTER COLUMN `shared_savings_rate` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`vbc_performance_period` ALTER COLUMN `star_rating` SET TAGS ('pii_business_glossary_term' = 'Star Rating');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`vbc_performance_period` ALTER COLUMN `start_date` SET TAGS ('pii_business_glossary_term' = 'Performance Period Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`vbc_performance_period` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`vbc_performance_period` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`vbc_performance_period` ALTER COLUMN `withhold_amount` SET TAGS ('pii_business_glossary_term' = 'Withhold Amount');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`vbc_performance_period` ALTER COLUMN `withhold_amount` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`bundled_payment_episode` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`bundled_payment_episode` SET TAGS ('pii_subdomain' = 'value_performance');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`bundled_payment_episode` SET TAGS ('pii_fhir_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`bundled_payment_episode` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`bundled_payment_episode` SET TAGS ('pii_fhir_resource' = 'PaymentReconciliation');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`bundled_payment_episode` SET TAGS ('pii_ecm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`bundled_payment_episode` SET TAGS ('pii_ssot' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`bundled_payment_episode` SET TAGS ('pii_fhir_interop' = 'ready');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`bundled_payment_episode` SET TAGS ('pii_authority_source' = 'verbatim_reviewer_comments_working_group_sheet');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`bundled_payment_episode` ALTER COLUMN `bundled_payment_episode_id` SET TAGS ('pii_business_glossary_term' = 'Bundled Payment Episode ID');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`bundled_payment_episode` ALTER COLUMN `provider_contract_id` SET TAGS ('pii_business_glossary_term' = 'Provider Contract ID');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`bundled_payment_episode` ALTER COLUMN `anchor_setting` SET TAGS ('pii_business_glossary_term' = 'Episode Anchor Care Setting');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`bundled_payment_episode` ALTER COLUMN `anchor_setting` SET TAGS ('pii_value_regex' = 'inpatient|outpatient|both');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`bundled_payment_episode` ALTER COLUMN `cms_episode_code` SET TAGS ('pii_business_glossary_term' = 'CMS Episode Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`bundled_payment_episode` ALTER COLUMN `cms_episode_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`bundled_payment_episode` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`bundled_payment_episode` ALTER COLUMN `created_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`bundled_payment_episode` ALTER COLUMN `data_quality_score` SET TAGS ('pii_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`bundled_payment_episode` ALTER COLUMN `drg_code` SET TAGS ('pii_business_glossary_term' = 'Diagnosis Related Group (DRG) Code');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`bundled_payment_episode` ALTER COLUMN `drg_code` SET TAGS ('pii_value_regex' = '^[0-9]{3}$');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`bundled_payment_episode` ALTER COLUMN `drg_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`bundled_payment_episode` ALTER COLUMN `effective_date` SET TAGS ('pii_business_glossary_term' = 'Episode Definition Effective Date');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`bundled_payment_episode` ALTER COLUMN `effective_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`bundled_payment_episode` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`bundled_payment_episode` ALTER COLUMN `effective_end_date` SET TAGS ('pii_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`bundled_payment_episode` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`bundled_payment_episode` ALTER COLUMN `effective_start_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`bundled_payment_episode` ALTER COLUMN `episode_code` SET TAGS ('pii_business_glossary_term' = 'Bundled Payment Episode Code');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`bundled_payment_episode` ALTER COLUMN `episode_code` SET TAGS ('pii_value_regex' = '^[A-Z0-9_-]{3,30}$');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`bundled_payment_episode` ALTER COLUMN `episode_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`bundled_payment_episode` ALTER COLUMN `episode_name` SET TAGS ('pii_business_glossary_term' = 'Bundled Payment Episode Name');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`bundled_payment_episode` ALTER COLUMN `episode_status` SET TAGS ('pii_business_glossary_term' = 'Bundled Payment Episode Status');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`bundled_payment_episode` ALTER COLUMN `episode_status` SET TAGS ('pii_value_regex' = 'draft|active|suspended|terminated|expired');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`bundled_payment_episode` ALTER COLUMN `episode_type` SET TAGS ('pii_business_glossary_term' = 'Bundled Payment Episode Type');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`bundled_payment_episode` ALTER COLUMN `excluded_services_description` SET TAGS ('pii_business_glossary_term' = 'Episode Excluded Services Description');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`bundled_payment_episode` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`bundled_payment_episode` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`bundled_payment_episode` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`bundled_payment_episode` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`bundled_payment_episode` ALTER COLUMN `fhir_resource_reference` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`bundled_payment_episode` ALTER COLUMN `fhir_resource_reference` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`bundled_payment_episode` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`bundled_payment_episode` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`bundled_payment_episode` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`bundled_payment_episode` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`bundled_payment_episode` ALTER COLUMN `gain_sharing_rate` SET TAGS ('pii_business_glossary_term' = 'Episode Gain Sharing Rate');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`bundled_payment_episode` ALTER COLUMN `gain_sharing_rate` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`bundled_payment_episode` ALTER COLUMN `icd_version` SET TAGS ('pii_business_glossary_term' = 'International Classification of Diseases (ICD) Version');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`bundled_payment_episode` ALTER COLUMN `icd_version` SET TAGS ('pii_value_regex' = 'ICD-10|ICD-11');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`bundled_payment_episode` ALTER COLUMN `included_services_description` SET TAGS ('pii_business_glossary_term' = 'Episode Included Services Description');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`bundled_payment_episode` ALTER COLUMN `is_active` SET TAGS ('pii_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`bundled_payment_episode` ALTER COLUMN `lob` SET TAGS ('pii_business_glossary_term' = 'Line of Business (LOB)');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`bundled_payment_episode` ALTER COLUMN `lob` SET TAGS ('pii_value_regex' = 'commercial|medicare_advantage|medicaid|marketplace|fehb');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`bundled_payment_episode` ALTER COLUMN `loss_sharing_rate` SET TAGS ('pii_business_glossary_term' = 'Episode Loss Sharing Rate');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`bundled_payment_episode` ALTER COLUMN `loss_sharing_rate` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`bundled_payment_episode` ALTER COLUMN `master_entity_reference` SET TAGS ('pii_business_glossary_term' = 'Master Entity Id');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`bundled_payment_episode` ALTER COLUMN `minimum_episode_volume` SET TAGS ('pii_business_glossary_term' = 'Minimum Episode Volume Threshold');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`bundled_payment_episode` ALTER COLUMN `outlier_exclusion_threshold` SET TAGS ('pii_business_glossary_term' = 'Episode Outlier Exclusion Threshold');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`bundled_payment_episode` ALTER COLUMN `outlier_exclusion_threshold` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`bundled_payment_episode` ALTER COLUMN `payment_methodology` SET TAGS ('pii_business_glossary_term' = 'Bundled Payment Methodology');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`bundled_payment_episode` ALTER COLUMN `payment_methodology` SET TAGS ('pii_value_regex' = 'retrospective|prospective|hybrid');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`bundled_payment_episode` ALTER COLUMN `performance_year` SET TAGS ('pii_business_glossary_term' = 'Episode Performance Year');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`bundled_payment_episode` ALTER COLUMN `post_trigger_window_days` SET TAGS ('pii_business_glossary_term' = 'Post-Trigger Episode Window (Days)');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`bundled_payment_episode` ALTER COLUMN `pre_trigger_window_days` SET TAGS ('pii_business_glossary_term' = 'Pre-Trigger Episode Window (Days)');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`bundled_payment_episode` ALTER COLUMN `program_type` SET TAGS ('pii_business_glossary_term' = 'Bundled Payment Program Type');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`bundled_payment_episode` ALTER COLUMN `program_type` SET TAGS ('pii_value_regex' = 'cms_bpci_a|cms_cjr|commercial|medicaid|medicare_advantage');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`bundled_payment_episode` ALTER COLUMN `quality_gate_required` SET TAGS ('pii_business_glossary_term' = 'Episode Quality Gate Required Flag');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`bundled_payment_episode` ALTER COLUMN `quality_withhold_rate` SET TAGS ('pii_business_glossary_term' = 'Episode Quality Withhold Rate');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`bundled_payment_episode` ALTER COLUMN `quality_withhold_rate` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`bundled_payment_episode` ALTER COLUMN `raf_adjustment_factor` SET TAGS ('pii_business_glossary_term' = 'Risk Adjustment Factor (RAF) Adjustment');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`bundled_payment_episode` ALTER COLUMN `readmission_included` SET TAGS ('pii_business_glossary_term' = 'Readmission Included in Episode Flag');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`bundled_payment_episode` ALTER COLUMN `reconciliation_frequency` SET TAGS ('pii_business_glossary_term' = 'Episode Reconciliation Frequency');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`bundled_payment_episode` ALTER COLUMN `reconciliation_frequency` SET TAGS ('pii_value_regex' = 'monthly|quarterly|semi_annual|annual');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`bundled_payment_episode` ALTER COLUMN `reconciliation_methodology` SET TAGS ('pii_business_glossary_term' = 'Episode Reconciliation Methodology');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`bundled_payment_episode` ALTER COLUMN `reconciliation_methodology` SET TAGS ('pii_value_regex' = 'net_payment_reconciliation|episode_payment|virtual_reconciliation');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`bundled_payment_episode` ALTER COLUMN `record_created_at` SET TAGS ('pii_business_glossary_term' = 'Record Created At');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`bundled_payment_episode` ALTER COLUMN `record_source_system` SET TAGS ('pii_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`bundled_payment_episode` ALTER COLUMN `record_status` SET TAGS ('pii_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`bundled_payment_episode` ALTER COLUMN `record_status` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`bundled_payment_episode` ALTER COLUMN `record_updated_at` SET TAGS ('pii_business_glossary_term' = 'Record Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`bundled_payment_episode` ALTER COLUMN `record_version` SET TAGS ('pii_business_glossary_term' = 'Record Version');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`bundled_payment_episode` ALTER COLUMN `risk_adjustment_applied` SET TAGS ('pii_business_glossary_term' = 'Episode Risk Adjustment Applied Flag');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`bundled_payment_episode` ALTER COLUMN `snf_included` SET TAGS ('pii_business_glossary_term' = 'Skilled Nursing Facility (SNF) Included Flag');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`bundled_payment_episode` ALTER COLUMN `stop_gain_threshold` SET TAGS ('pii_business_glossary_term' = 'Episode Stop-Gain Threshold');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`bundled_payment_episode` ALTER COLUMN `stop_gain_threshold` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`bundled_payment_episode` ALTER COLUMN `stop_loss_threshold` SET TAGS ('pii_business_glossary_term' = 'Episode Stop-Loss Threshold');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`bundled_payment_episode` ALTER COLUMN `stop_loss_threshold` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`bundled_payment_episode` ALTER COLUMN `target_price` SET TAGS ('pii_business_glossary_term' = 'Episode Target Price');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`bundled_payment_episode` ALTER COLUMN `target_price` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`bundled_payment_episode` ALTER COLUMN `target_price_basis` SET TAGS ('pii_business_glossary_term' = 'Episode Target Price Basis');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`bundled_payment_episode` ALTER COLUMN `target_price_basis` SET TAGS ('pii_value_regex' = 'historical_claims|regional_benchmark|national_benchmark|negotiated');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`bundled_payment_episode` ALTER COLUMN `target_price_effective_date` SET TAGS ('pii_business_glossary_term' = 'Episode Target Price Effective Date');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`bundled_payment_episode` ALTER COLUMN `target_price_expiration_date` SET TAGS ('pii_business_glossary_term' = 'Episode Target Price Expiration Date');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`bundled_payment_episode` ALTER COLUMN `termination_date` SET TAGS ('pii_business_glossary_term' = 'Episode Definition Termination Date');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`bundled_payment_episode` ALTER COLUMN `termination_date` SET TAGS ('pii_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`bundled_payment_episode` ALTER COLUMN `trigger_code` SET TAGS ('pii_business_glossary_term' = 'Episode Trigger Code');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`bundled_payment_episode` ALTER COLUMN `trigger_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`bundled_payment_episode` ALTER COLUMN `trigger_code_type` SET TAGS ('pii_business_glossary_term' = 'Episode Trigger Code Type');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`bundled_payment_episode` ALTER COLUMN `trigger_code_type` SET TAGS ('pii_value_regex' = 'CPT|HCPCS|DRG|ICD10CM|ICD10PCS');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`bundled_payment_episode` ALTER COLUMN `trigger_event_type` SET TAGS ('pii_business_glossary_term' = 'Episode Trigger Event Type');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`bundled_payment_episode` ALTER COLUMN `trigger_event_type` SET TAGS ('pii_value_regex' = 'procedure_code|drg|diagnosis_code|admission');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`bundled_payment_episode` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`bundled_payment_episode` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`reimbursement_policy` SET TAGS ('pii_data_type' = 'reference_data');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`reimbursement_policy` SET TAGS ('pii_subdomain' = 'obligation_compliance');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`reimbursement_policy` SET TAGS ('pii_fhir_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`reimbursement_policy` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`reimbursement_policy` SET TAGS ('pii_fhir_resource' = 'Coverage');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`reimbursement_policy` SET TAGS ('pii_ecm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`reimbursement_policy` SET TAGS ('pii_ssot' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`reimbursement_policy` SET TAGS ('pii_fhir_interop' = 'ready');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`reimbursement_policy` SET TAGS ('pii_authority_source' = 'verbatim_reviewer_comments_working_group_sheet');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`reimbursement_policy` ALTER COLUMN `reimbursement_policy_id` SET TAGS ('pii_business_glossary_term' = 'Reimbursement Policy ID');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`reimbursement_policy` ALTER COLUMN `provider_contract_id` SET TAGS ('pii_business_glossary_term' = 'Contract ID');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`reimbursement_policy` ALTER COLUMN `fee_schedule_id` SET TAGS ('pii_business_glossary_term' = 'Fee Schedule ID');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`reimbursement_policy` ALTER COLUMN `pool_id` SET TAGS ('pii_business_glossary_term' = 'Risk Pool Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`reimbursement_policy` ALTER COLUMN `superseded_policy_reimbursement_policy_id` SET TAGS ('pii_business_glossary_term' = 'Superseded Policy ID');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`reimbursement_policy` ALTER COLUMN `applies_to_facility` SET TAGS ('pii_business_glossary_term' = 'Applies to Facility Flag');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`reimbursement_policy` ALTER COLUMN `applies_to_professional` SET TAGS ('pii_business_glossary_term' = 'Applies to Professional Flag');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`reimbursement_policy` ALTER COLUMN `cpt_range_end` SET TAGS ('pii_business_glossary_term' = 'Current Procedural Terminology (CPT) Range End Code');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`reimbursement_policy` ALTER COLUMN `cpt_range_end` SET TAGS ('pii_value_regex' = '^[0-9]{5}$');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`reimbursement_policy` ALTER COLUMN `cpt_range_start` SET TAGS ('pii_business_glossary_term' = 'Current Procedural Terminology (CPT) Range Start Code');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`reimbursement_policy` ALTER COLUMN `cpt_range_start` SET TAGS ('pii_value_regex' = '^[0-9]{5}$');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`reimbursement_policy` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`reimbursement_policy` ALTER COLUMN `created_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`reimbursement_policy` ALTER COLUMN `data_quality_score` SET TAGS ('pii_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`reimbursement_policy` ALTER COLUMN `denial_reason_code` SET TAGS ('pii_business_glossary_term' = 'Claim Adjustment Reason Code (CARC)');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`reimbursement_policy` ALTER COLUMN `denial_reason_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`reimbursement_policy` ALTER COLUMN `diagnosis_code_required` SET TAGS ('pii_business_glossary_term' = 'Diagnosis Code Required Flag');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`reimbursement_policy` ALTER COLUMN `diagnosis_code_required` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`reimbursement_policy` ALTER COLUMN `diagnosis_code_required` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`reimbursement_policy` ALTER COLUMN `effective_date` SET TAGS ('pii_business_glossary_term' = 'Policy Effective Date');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`reimbursement_policy` ALTER COLUMN `effective_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`reimbursement_policy` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`reimbursement_policy` ALTER COLUMN `effective_end_date` SET TAGS ('pii_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`reimbursement_policy` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`reimbursement_policy` ALTER COLUMN `effective_start_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`reimbursement_policy` ALTER COLUMN `eob_message_code` SET TAGS ('pii_business_glossary_term' = 'Explanation of Benefits (EOB) Message Code');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`reimbursement_policy` ALTER COLUMN `eob_message_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`reimbursement_policy` ALTER COLUMN `facets_policy_code` SET TAGS ('pii_business_glossary_term' = 'Facets/QNXT Policy Code');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`reimbursement_policy` ALTER COLUMN `facets_policy_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`reimbursement_policy` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`reimbursement_policy` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`reimbursement_policy` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`reimbursement_policy` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`reimbursement_policy` ALTER COLUMN `fhir_resource_reference` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`reimbursement_policy` ALTER COLUMN `fhir_resource_reference` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`reimbursement_policy` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`reimbursement_policy` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`reimbursement_policy` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`reimbursement_policy` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`reimbursement_policy` ALTER COLUMN `global_surgery_period_days` SET TAGS ('pii_business_glossary_term' = 'Global Surgery Period (Days)');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`reimbursement_policy` ALTER COLUMN `icd_version` SET TAGS ('pii_business_glossary_term' = 'International Classification of Diseases (ICD) Version');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`reimbursement_policy` ALTER COLUMN `icd_version` SET TAGS ('pii_value_regex' = 'ICD-10|ICD-11');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`reimbursement_policy` ALTER COLUMN `is_active` SET TAGS ('pii_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`reimbursement_policy` ALTER COLUMN `lob` SET TAGS ('pii_business_glossary_term' = 'Line of Business (LOB)');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`reimbursement_policy` ALTER COLUMN `lob` SET TAGS ('pii_value_regex' = 'commercial|medicare_advantage|medicaid|marketplace|fehb|tricare');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`reimbursement_policy` ALTER COLUMN `master_entity_reference` SET TAGS ('pii_business_glossary_term' = 'Master Entity Id');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`reimbursement_policy` ALTER COLUMN `max_procedures_allowed` SET TAGS ('pii_business_glossary_term' = 'Maximum Procedures Allowed');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`reimbursement_policy` ALTER COLUMN `modifier_code` SET TAGS ('pii_business_glossary_term' = 'CPT/HCPCS Modifier Code');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`reimbursement_policy` ALTER COLUMN `modifier_code` SET TAGS ('pii_value_regex' = '^[A-Z0-9]{2}$');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`reimbursement_policy` ALTER COLUMN `modifier_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`reimbursement_policy` ALTER COLUMN `ncci_edit_type` SET TAGS ('pii_business_glossary_term' = 'National Correct Coding Initiative (NCCI) Edit Type');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`reimbursement_policy` ALTER COLUMN `ncci_edit_type` SET TAGS ('pii_value_regex' = 'column_1|column_2|mutually_exclusive|not_applicable');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`reimbursement_policy` ALTER COLUMN `network_tier` SET TAGS ('pii_business_glossary_term' = 'Network Tier');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`reimbursement_policy` ALTER COLUMN `network_tier` SET TAGS ('pii_value_regex' = 'in_network|out_of_network|tiered_1|tiered_2|tiered_3');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`reimbursement_policy` ALTER COLUMN `override_allowed` SET TAGS ('pii_business_glossary_term' = 'Policy Override Allowed Flag');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`reimbursement_policy` ALTER COLUMN `override_requires_auth` SET TAGS ('pii_business_glossary_term' = 'Override Requires Authorization Flag');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`reimbursement_policy` ALTER COLUMN `payment_methodology` SET TAGS ('pii_business_glossary_term' = 'Payment Methodology');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`reimbursement_policy` ALTER COLUMN `payment_methodology` SET TAGS ('pii_value_regex' = 'fee_for_service|capitation|bundled_payment|per_diem|case_rate');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`reimbursement_policy` ALTER COLUMN `place_of_service_code` SET TAGS ('pii_business_glossary_term' = 'Place of Service (POS) Code');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`reimbursement_policy` ALTER COLUMN `place_of_service_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`reimbursement_policy` ALTER COLUMN `policy_description` SET TAGS ('pii_business_glossary_term' = 'Reimbursement Policy Description');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`reimbursement_policy` ALTER COLUMN `policy_name` SET TAGS ('pii_business_glossary_term' = 'Reimbursement Policy Name');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`reimbursement_policy` ALTER COLUMN `policy_number` SET TAGS ('pii_business_glossary_term' = 'Reimbursement Policy Number');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`reimbursement_policy` ALTER COLUMN `policy_number` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`reimbursement_policy` ALTER COLUMN `policy_source` SET TAGS ('pii_business_glossary_term' = 'Reimbursement Policy Source');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`reimbursement_policy` ALTER COLUMN `policy_source` SET TAGS ('pii_value_regex' = 'cms_ncci|cms_mppr|ama_cpt|plan_defined|state_mandate|contract_specific');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`reimbursement_policy` ALTER COLUMN `policy_status` SET TAGS ('pii_business_glossary_term' = 'Reimbursement Policy Status');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`reimbursement_policy` ALTER COLUMN `policy_status` SET TAGS ('pii_value_regex' = 'active|inactive|pending|suspended|retired');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`reimbursement_policy` ALTER COLUMN `policy_type` SET TAGS ('pii_business_glossary_term' = 'Reimbursement Policy Type');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`reimbursement_policy` ALTER COLUMN `policy_type` SET TAGS ('pii_value_regex' = 'multiple_procedure_reduction|bilateral_procedure|assistant_surgeon|global_surgery|unbundling|place_of_service_differential');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`reimbursement_policy` ALTER COLUMN `policy_version` SET TAGS ('pii_business_glossary_term' = 'Reimbursement Policy Version');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`reimbursement_policy` ALTER COLUMN `primary_procedure_rank` SET TAGS ('pii_business_glossary_term' = 'Primary Procedure Rank');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`reimbursement_policy` ALTER COLUMN `provider_specialty_code` SET TAGS ('pii_business_glossary_term' = 'Provider Specialty Code');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`reimbursement_policy` ALTER COLUMN `provider_specialty_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`reimbursement_policy` ALTER COLUMN `record_created_at` SET TAGS ('pii_business_glossary_term' = 'Record Created At');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`reimbursement_policy` ALTER COLUMN `record_source_system` SET TAGS ('pii_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`reimbursement_policy` ALTER COLUMN `record_status` SET TAGS ('pii_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`reimbursement_policy` ALTER COLUMN `record_status` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`reimbursement_policy` ALTER COLUMN `record_updated_at` SET TAGS ('pii_business_glossary_term' = 'Record Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`reimbursement_policy` ALTER COLUMN `record_version` SET TAGS ('pii_business_glossary_term' = 'Record Version');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`reimbursement_policy` ALTER COLUMN `reduction_pct` SET TAGS ('pii_business_glossary_term' = 'Reimbursement Reduction Percentage');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`reimbursement_policy` ALTER COLUMN `regulatory_mandate_flag` SET TAGS ('pii_business_glossary_term' = 'Regulatory Mandate Flag');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`reimbursement_policy` ALTER COLUMN `regulatory_reference` SET TAGS ('pii_business_glossary_term' = 'Regulatory Reference');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`reimbursement_policy` ALTER COLUMN `retroactive_adjustment_allowed` SET TAGS ('pii_business_glossary_term' = 'Retroactive Adjustment Allowed Flag');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`reimbursement_policy` ALTER COLUMN `revenue_code_range_end` SET TAGS ('pii_business_glossary_term' = 'Revenue Code Range End');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`reimbursement_policy` ALTER COLUMN `revenue_code_range_end` SET TAGS ('pii_value_regex' = '^[0-9]{4}$');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`reimbursement_policy` ALTER COLUMN `revenue_code_range_start` SET TAGS ('pii_business_glossary_term' = 'Revenue Code Range Start');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`reimbursement_policy` ALTER COLUMN `revenue_code_range_start` SET TAGS ('pii_value_regex' = '^[0-9]{4}$');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`reimbursement_policy` ALTER COLUMN `termination_date` SET TAGS ('pii_business_glossary_term' = 'Policy Termination Date');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`reimbursement_policy` ALTER COLUMN `termination_date` SET TAGS ('pii_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`reimbursement_policy` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`reimbursement_policy` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`service_scope` SET TAGS ('pii_data_type' = 'reference_data');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`service_scope` SET TAGS ('pii_subdomain' = 'agreement_parties');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`service_scope` SET TAGS ('pii_fhir_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`service_scope` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`service_scope` SET TAGS ('pii_fhir_resource' = 'Basic');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`service_scope` SET TAGS ('pii_ecm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`service_scope` SET TAGS ('pii_ssot' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`service_scope` SET TAGS ('pii_fhir_interop' = 'ready');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`service_scope` SET TAGS ('pii_authority_source' = 'verbatim_reviewer_comments_working_group_sheet');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`service_scope` ALTER COLUMN `service_scope_id` SET TAGS ('pii_business_glossary_term' = 'Service Scope Identifier (ID)');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`service_scope` ALTER COLUMN `provider_contract_id` SET TAGS ('pii_business_glossary_term' = 'Contract Identifier (ID)');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`service_scope` ALTER COLUMN `fee_schedule_id` SET TAGS ('pii_business_glossary_term' = 'Fee Schedule Identifier (ID)');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`service_scope` ALTER COLUMN `provider_id` SET TAGS ('pii_business_glossary_term' = 'Provider Identifier (ID)');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`service_scope` ALTER COLUMN `superseded_by_service_scope_id` SET TAGS ('pii_business_glossary_term' = 'Superseded By Identifier (ID)');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`service_scope` ALTER COLUMN `approval_date` SET TAGS ('pii_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`service_scope` ALTER COLUMN `approved_by` SET TAGS ('pii_business_glossary_term' = 'Approved By');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`service_scope` ALTER COLUMN `carve_out_indicator` SET TAGS ('pii_business_glossary_term' = 'Carve-Out Indicator');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`service_scope` ALTER COLUMN `coordination_of_benefits_applicable` SET TAGS ('pii_business_glossary_term' = 'Coordination of Benefits (COB) Applicable');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`service_scope` ALTER COLUMN `cpt_code_range_end` SET TAGS ('pii_business_glossary_term' = 'Current Procedural Terminology (CPT) Code Range End');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`service_scope` ALTER COLUMN `cpt_code_range_start` SET TAGS ('pii_business_glossary_term' = 'Current Procedural Terminology (CPT) Code Range Start');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`service_scope` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`service_scope` ALTER COLUMN `created_timestamp` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`service_scope` ALTER COLUMN `data_quality_score` SET TAGS ('pii_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`service_scope` ALTER COLUMN `drg_range_end` SET TAGS ('pii_business_glossary_term' = 'Diagnosis Related Group (DRG) Range End');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`service_scope` ALTER COLUMN `drg_range_start` SET TAGS ('pii_business_glossary_term' = 'Diagnosis Related Group (DRG) Range Start');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`service_scope` ALTER COLUMN `effective_date` SET TAGS ('pii_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`service_scope` ALTER COLUMN `effective_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`service_scope` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`service_scope` ALTER COLUMN `effective_end_date` SET TAGS ('pii_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`service_scope` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`service_scope` ALTER COLUMN `effective_start_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`service_scope` ALTER COLUMN `exclusion_reason` SET TAGS ('pii_business_glossary_term' = 'Exclusion Reason');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`service_scope` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`service_scope` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`service_scope` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`service_scope` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`service_scope` ALTER COLUMN `fhir_resource_reference` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`service_scope` ALTER COLUMN `fhir_resource_reference` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`service_scope` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`service_scope` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`service_scope` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`service_scope` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`service_scope` ALTER COLUMN `global_surgery_applicable` SET TAGS ('pii_business_glossary_term' = 'Global Surgery Applicable');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`service_scope` ALTER COLUMN `icd_code_range_end` SET TAGS ('pii_business_glossary_term' = 'International Classification of Diseases (ICD) Code Range End');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`service_scope` ALTER COLUMN `icd_code_range_start` SET TAGS ('pii_business_glossary_term' = 'International Classification of Diseases (ICD) Code Range Start');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`service_scope` ALTER COLUMN `inclusion_exclusion_flag` SET TAGS ('pii_business_glossary_term' = 'Inclusion or Exclusion Flag');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`service_scope` ALTER COLUMN `inclusion_exclusion_flag` SET TAGS ('pii_value_regex' = 'inclusion|exclusion');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`service_scope` ALTER COLUMN `is_active` SET TAGS ('pii_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`service_scope` ALTER COLUMN `lob` SET TAGS ('pii_business_glossary_term' = 'Line of Business (LOB)');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`service_scope` ALTER COLUMN `lob` SET TAGS ('pii_value_regex' = 'commercial|medicare|medicaid|exchange|aso|tpa');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`service_scope` ALTER COLUMN `master_entity_reference` SET TAGS ('pii_business_glossary_term' = 'Master Entity Id');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`service_scope` ALTER COLUMN `medicare_crossover_applicable` SET TAGS ('pii_business_glossary_term' = 'Medicare Crossover Applicable');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`service_scope` ALTER COLUMN `modifier_applicable` SET TAGS ('pii_business_glossary_term' = 'Modifier Applicable');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`service_scope` ALTER COLUMN `network_tier` SET TAGS ('pii_business_glossary_term' = 'Network Tier');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`service_scope` ALTER COLUMN `network_tier` SET TAGS ('pii_value_regex' = 'tier_1|tier_2|tier_3|out_of_network|preferred|standard');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`service_scope` ALTER COLUMN `payment_methodology` SET TAGS ('pii_business_glossary_term' = 'Payment Methodology');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`service_scope` ALTER COLUMN `payment_methodology` SET TAGS ('pii_value_regex' = 'fee_for_service|capitation|bundled|case_rate|per_diem|vbc');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`service_scope` ALTER COLUMN `place_of_service_code` SET TAGS ('pii_business_glossary_term' = 'Place of Service (POS) Code');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`service_scope` ALTER COLUMN `place_of_service_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`service_scope` ALTER COLUMN `prior_authorization_required` SET TAGS ('pii_business_glossary_term' = 'Prior Authorization (PA) Required');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`service_scope` ALTER COLUMN `record_created_at` SET TAGS ('pii_business_glossary_term' = 'Record Created At');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`service_scope` ALTER COLUMN `record_created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`service_scope` ALTER COLUMN `record_source_system` SET TAGS ('pii_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`service_scope` ALTER COLUMN `record_status` SET TAGS ('pii_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`service_scope` ALTER COLUMN `record_status` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`service_scope` ALTER COLUMN `record_updated_at` SET TAGS ('pii_business_glossary_term' = 'Record Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`service_scope` ALTER COLUMN `record_updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`service_scope` ALTER COLUMN `record_version` SET TAGS ('pii_business_glossary_term' = 'Record Version');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`service_scope` ALTER COLUMN `referral_required` SET TAGS ('pii_business_glossary_term' = 'Referral Required');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`service_scope` ALTER COLUMN `reimbursement_rate_pct` SET TAGS ('pii_business_glossary_term' = 'Reimbursement Rate Percentage');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`service_scope` ALTER COLUMN `revenue_code_range_end` SET TAGS ('pii_business_glossary_term' = 'Revenue Code Range End');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`service_scope` ALTER COLUMN `revenue_code_range_start` SET TAGS ('pii_business_glossary_term' = 'Revenue Code Range Start');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`service_scope` ALTER COLUMN `scope_code` SET TAGS ('pii_business_glossary_term' = 'Service Scope Code');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`service_scope` ALTER COLUMN `scope_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`service_scope` ALTER COLUMN `scope_description` SET TAGS ('pii_business_glossary_term' = 'Service Scope Description');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`service_scope` ALTER COLUMN `scope_name` SET TAGS ('pii_business_glossary_term' = 'Service Scope Name');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`service_scope` ALTER COLUMN `scope_status` SET TAGS ('pii_business_glossary_term' = 'Service Scope Status');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`service_scope` ALTER COLUMN `scope_status` SET TAGS ('pii_value_regex' = 'active|inactive|pending|suspended|terminated|draft');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`service_scope` ALTER COLUMN `service_category` SET TAGS ('pii_business_glossary_term' = 'Service Category');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`service_scope` ALTER COLUMN `service_category` SET TAGS ('pii_value_regex' = 'inpatient|outpatient|professional|ancillary|behavioral_health|dme');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`service_scope` ALTER COLUMN `source_system_code` SET TAGS ('pii_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`service_scope` ALTER COLUMN `source_system_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`service_scope` ALTER COLUMN `specialty_code` SET TAGS ('pii_business_glossary_term' = 'Provider Specialty Code');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`service_scope` ALTER COLUMN `specialty_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`service_scope` ALTER COLUMN `stop_loss_applicable` SET TAGS ('pii_business_glossary_term' = 'Stop-Loss Applicable');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`service_scope` ALTER COLUMN `termination_date` SET TAGS ('pii_business_glossary_term' = 'Termination Date');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`service_scope` ALTER COLUMN `termination_date` SET TAGS ('pii_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`service_scope` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`service_scope` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`service_scope` ALTER COLUMN `version_number` SET TAGS ('pii_business_glossary_term' = 'Version Number');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`service_scope` ALTER COLUMN `version_number` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`delegation_agreement` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`delegation_agreement` SET TAGS ('pii_subdomain' = 'agreement_parties');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`delegation_agreement` SET TAGS ('pii_fhir_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`delegation_agreement` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`delegation_agreement` SET TAGS ('pii_fhir_resource' = 'Basic');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`delegation_agreement` SET TAGS ('pii_ecm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`delegation_agreement` SET TAGS ('pii_ssot' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`delegation_agreement` SET TAGS ('pii_fhir_interop' = 'ready');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`delegation_agreement` SET TAGS ('pii_authority_source' = 'verbatim_reviewer_comments_working_group_sheet');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`delegation_agreement` ALTER COLUMN `delegation_agreement_id` SET TAGS ('pii_business_glossary_term' = 'Delegation Agreement Identifier (ID)');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`delegation_agreement` ALTER COLUMN `provider_contract_id` SET TAGS ('pii_business_glossary_term' = 'Contract Identifier (ID)');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`delegation_agreement` ALTER COLUMN `employee_id` SET TAGS ('pii_business_glossary_term' = 'Delegating Signatory Employee Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`delegation_agreement` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`delegation_agreement` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`delegation_agreement` ALTER COLUMN `health_plan_id` SET TAGS ('pii_business_glossary_term' = 'Plan Identifier (ID)');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`delegation_agreement` ALTER COLUMN `health_plan_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`delegation_agreement` ALTER COLUMN `health_plan_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`delegation_agreement` ALTER COLUMN `party_id` SET TAGS ('pii_business_glossary_term' = 'Delegating Entity Identifier (ID)');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`delegation_agreement` ALTER COLUMN `provider_network_id` SET TAGS ('pii_business_glossary_term' = 'Network Identifier (ID)');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`delegation_agreement` ALTER COLUMN `superseded_by_delegation_agreement_id` SET TAGS ('pii_business_glossary_term' = 'Superseded By Delegation Agreement Identifier (ID)');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`delegation_agreement` ALTER COLUMN `agreement_name` SET TAGS ('pii_business_glossary_term' = 'Delegation Agreement Name');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`delegation_agreement` ALTER COLUMN `agreement_number` SET TAGS ('pii_business_glossary_term' = 'Delegation Agreement Number');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`delegation_agreement` ALTER COLUMN `agreement_number` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`delegation_agreement` ALTER COLUMN `agreement_status` SET TAGS ('pii_business_glossary_term' = 'Delegation Agreement Status');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`delegation_agreement` ALTER COLUMN `agreement_status` SET TAGS ('pii_value_regex' = 'draft|pending_approval|active|suspended|terminated|expired');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`delegation_agreement` ALTER COLUMN `agreement_type` SET TAGS ('pii_business_glossary_term' = 'Delegation Agreement Type');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`delegation_agreement` ALTER COLUMN `agreement_type` SET TAGS ('pii_value_regex' = 'full_delegation|partial_delegation|administrative_services_only|care_management|utilization_management|claims_payment');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`delegation_agreement` ALTER COLUMN `approval_date` SET TAGS ('pii_business_glossary_term' = 'Delegation Agreement Approval Date');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`delegation_agreement` ALTER COLUMN `audit_frequency` SET TAGS ('pii_business_glossary_term' = 'Delegation Audit Frequency');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`delegation_agreement` ALTER COLUMN `audit_frequency` SET TAGS ('pii_value_regex' = 'monthly|quarterly|semi_annual|annual|biennial|as_needed');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`delegation_agreement` ALTER COLUMN `auto_renewal_flag` SET TAGS ('pii_business_glossary_term' = 'Auto-Renewal Flag');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`delegation_agreement` ALTER COLUMN `cms_oversight_required` SET TAGS ('pii_business_glossary_term' = 'Centers for Medicare and Medicaid Services (CMS) Oversight Required Flag');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`delegation_agreement` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`delegation_agreement` ALTER COLUMN `created_timestamp` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`delegation_agreement` ALTER COLUMN `data_quality_score` SET TAGS ('pii_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`delegation_agreement` ALTER COLUMN `delegate_signatory_name` SET TAGS ('pii_business_glossary_term' = 'Delegate Entity Signatory Name');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`delegation_agreement` ALTER COLUMN `delegate_signatory_name` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`delegation_agreement` ALTER COLUMN `delegate_signatory_title` SET TAGS ('pii_business_glossary_term' = 'Delegate Entity Signatory Title');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`delegation_agreement` ALTER COLUMN `delegated_function_type` SET TAGS ('pii_business_glossary_term' = 'Delegated Function Type');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`delegation_agreement` ALTER COLUMN `delegating_signatory_title` SET TAGS ('pii_business_glossary_term' = 'Delegating Entity Signatory Title');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`delegation_agreement` ALTER COLUMN `delegation_scope` SET TAGS ('pii_business_glossary_term' = 'Delegation Scope Description');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`delegation_agreement` ALTER COLUMN `document_reference` SET TAGS ('pii_business_glossary_term' = 'Delegation Agreement Document Reference');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`delegation_agreement` ALTER COLUMN `effective_date` SET TAGS ('pii_business_glossary_term' = 'Delegation Agreement Effective Date');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`delegation_agreement` ALTER COLUMN `effective_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`delegation_agreement` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`delegation_agreement` ALTER COLUMN `effective_end_date` SET TAGS ('pii_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`delegation_agreement` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`delegation_agreement` ALTER COLUMN `effective_start_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`delegation_agreement` ALTER COLUMN `execution_date` SET TAGS ('pii_business_glossary_term' = 'Delegation Agreement Execution Date');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`delegation_agreement` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`delegation_agreement` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`delegation_agreement` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`delegation_agreement` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`delegation_agreement` ALTER COLUMN `fhir_resource_reference` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`delegation_agreement` ALTER COLUMN `fhir_resource_reference` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`delegation_agreement` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`delegation_agreement` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`delegation_agreement` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`delegation_agreement` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`delegation_agreement` ALTER COLUMN `financial_arrangement_type` SET TAGS ('pii_business_glossary_term' = 'Financial Arrangement Type');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`delegation_agreement` ALTER COLUMN `financial_arrangement_type` SET TAGS ('pii_value_regex' = 'capitation|fee_for_service|shared_savings|bundled_payment|case_rate|per_diem');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`delegation_agreement` ALTER COLUMN `internal_notes` SET TAGS ('pii_business_glossary_term' = 'Internal Notes');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`delegation_agreement` ALTER COLUMN `internal_notes` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`delegation_agreement` ALTER COLUMN `is_active` SET TAGS ('pii_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`delegation_agreement` ALTER COLUMN `last_audit_date` SET TAGS ('pii_business_glossary_term' = 'Last Delegation Audit Date');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`delegation_agreement` ALTER COLUMN `lob_code` SET TAGS ('pii_business_glossary_term' = 'Line of Business (LOB) Code');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`delegation_agreement` ALTER COLUMN `lob_code` SET TAGS ('pii_value_regex' = 'commercial|medicare|medicaid|marketplace|dual_eligible|chip');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`delegation_agreement` ALTER COLUMN `lob_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`delegation_agreement` ALTER COLUMN `master_entity_reference` SET TAGS ('pii_business_glossary_term' = 'Master Entity Id');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`delegation_agreement` ALTER COLUMN `ncqa_compliance_flag` SET TAGS ('pii_business_glossary_term' = 'National Committee for Quality Assurance (NCQA) Compliance Flag');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`delegation_agreement` ALTER COLUMN `next_audit_due_date` SET TAGS ('pii_business_glossary_term' = 'Next Delegation Audit Due Date');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`delegation_agreement` ALTER COLUMN `oversight_requirement` SET TAGS ('pii_business_glossary_term' = 'Oversight Requirement Description');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`delegation_agreement` ALTER COLUMN `performance_standard` SET TAGS ('pii_business_glossary_term' = 'Delegation Performance Standard');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`delegation_agreement` ALTER COLUMN `record_created_at` SET TAGS ('pii_business_glossary_term' = 'Record Created At');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`delegation_agreement` ALTER COLUMN `record_created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`delegation_agreement` ALTER COLUMN `record_source_system` SET TAGS ('pii_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`delegation_agreement` ALTER COLUMN `record_status` SET TAGS ('pii_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`delegation_agreement` ALTER COLUMN `record_status` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`delegation_agreement` ALTER COLUMN `record_updated_at` SET TAGS ('pii_business_glossary_term' = 'Record Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`delegation_agreement` ALTER COLUMN `record_updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`delegation_agreement` ALTER COLUMN `record_version` SET TAGS ('pii_business_glossary_term' = 'Record Version');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`delegation_agreement` ALTER COLUMN `regulatory_filing_date` SET TAGS ('pii_business_glossary_term' = 'Regulatory Filing Date');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`delegation_agreement` ALTER COLUMN `regulatory_filing_required` SET TAGS ('pii_business_glossary_term' = 'Regulatory Filing Required Flag');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`delegation_agreement` ALTER COLUMN `risk_share_applicable` SET TAGS ('pii_business_glossary_term' = 'Risk Share Applicable Flag');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`delegation_agreement` ALTER COLUMN `termination_date` SET TAGS ('pii_business_glossary_term' = 'Delegation Agreement Termination Date');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`delegation_agreement` ALTER COLUMN `termination_date` SET TAGS ('pii_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`delegation_agreement` ALTER COLUMN `termination_notice_days` SET TAGS ('pii_business_glossary_term' = 'Termination Notice Days');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`delegation_agreement` ALTER COLUMN `termination_reason` SET TAGS ('pii_business_glossary_term' = 'Delegation Agreement Termination Reason');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`delegation_agreement` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`delegation_agreement` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`delegation_agreement` ALTER COLUMN `urac_compliance_flag` SET TAGS ('pii_business_glossary_term' = 'URAC Compliance Flag');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`delegation_agreement` ALTER COLUMN `version_number` SET TAGS ('pii_business_glossary_term' = 'Delegation Agreement Version Number');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`delegation_agreement` ALTER COLUMN `version_number` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`incentive_arrangement` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`incentive_arrangement` SET TAGS ('pii_subdomain' = 'value_performance');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`incentive_arrangement` SET TAGS ('pii_fhir_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`incentive_arrangement` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`incentive_arrangement` SET TAGS ('pii_fhir_resource' = 'Basic');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`incentive_arrangement` SET TAGS ('pii_ecm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`incentive_arrangement` SET TAGS ('pii_ssot' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`incentive_arrangement` SET TAGS ('pii_fhir_interop' = 'ready');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`incentive_arrangement` SET TAGS ('pii_authority_source' = 'verbatim_reviewer_comments_working_group_sheet');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`incentive_arrangement` ALTER COLUMN `incentive_arrangement_id` SET TAGS ('pii_business_glossary_term' = 'Incentive Arrangement Identifier (ID)');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`incentive_arrangement` ALTER COLUMN `employee_id` SET TAGS ('pii_business_glossary_term' = 'Approved By Employee Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`incentive_arrangement` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`incentive_arrangement` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`incentive_arrangement` ALTER COLUMN `provider_contract_id` SET TAGS ('pii_business_glossary_term' = 'Contract Identifier (ID)');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`incentive_arrangement` ALTER COLUMN `provider_id` SET TAGS ('pii_business_glossary_term' = 'Provider Identifier (ID)');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`incentive_arrangement` ALTER COLUMN `aco_arrangement_flag` SET TAGS ('pii_business_glossary_term' = 'Accountable Care Organization (ACO) Arrangement Flag');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`incentive_arrangement` ALTER COLUMN `amendment_number` SET TAGS ('pii_business_glossary_term' = 'Amendment Number');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`incentive_arrangement` ALTER COLUMN `amendment_number` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`incentive_arrangement` ALTER COLUMN `amount_forfeited` SET TAGS ('pii_business_glossary_term' = 'Amount Forfeited');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`incentive_arrangement` ALTER COLUMN `amount_released` SET TAGS ('pii_business_glossary_term' = 'Amount Released');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`incentive_arrangement` ALTER COLUMN `approval_date` SET TAGS ('pii_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`incentive_arrangement` ALTER COLUMN `arrangement_name` SET TAGS ('pii_business_glossary_term' = 'Arrangement Name');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`incentive_arrangement` ALTER COLUMN `arrangement_number` SET TAGS ('pii_business_glossary_term' = 'Arrangement Number');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`incentive_arrangement` ALTER COLUMN `arrangement_number` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`incentive_arrangement` ALTER COLUMN `arrangement_status` SET TAGS ('pii_business_glossary_term' = 'Arrangement Status');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`incentive_arrangement` ALTER COLUMN `arrangement_status` SET TAGS ('pii_value_regex' = 'active|inactive|pending|suspended|terminated|settled');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`incentive_arrangement` ALTER COLUMN `arrangement_type` SET TAGS ('pii_business_glossary_term' = 'Arrangement Type');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`incentive_arrangement` ALTER COLUMN `arrangement_type` SET TAGS ('pii_value_regex' = 'pay_for_performance|quality_withhold|risk_withhold|shared_savings|performance_guarantee|penalty');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`incentive_arrangement` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`incentive_arrangement` ALTER COLUMN `created_timestamp` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`incentive_arrangement` ALTER COLUMN `data_quality_score` SET TAGS ('pii_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`incentive_arrangement` ALTER COLUMN `earned_status` SET TAGS ('pii_business_glossary_term' = 'Earned Status');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`incentive_arrangement` ALTER COLUMN `earned_status` SET TAGS ('pii_value_regex' = 'earned|not_earned|partially_earned|pending_review');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`incentive_arrangement` ALTER COLUMN `effective_date` SET TAGS ('pii_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`incentive_arrangement` ALTER COLUMN `effective_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`incentive_arrangement` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`incentive_arrangement` ALTER COLUMN `effective_end_date` SET TAGS ('pii_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`incentive_arrangement` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`incentive_arrangement` ALTER COLUMN `effective_start_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`incentive_arrangement` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`incentive_arrangement` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`incentive_arrangement` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`incentive_arrangement` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`incentive_arrangement` ALTER COLUMN `fhir_resource_reference` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`incentive_arrangement` ALTER COLUMN `fhir_resource_reference` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`incentive_arrangement` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`incentive_arrangement` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`incentive_arrangement` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`incentive_arrangement` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`incentive_arrangement` ALTER COLUMN `is_active` SET TAGS ('pii_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`incentive_arrangement` ALTER COLUMN `lob_code` SET TAGS ('pii_business_glossary_term' = 'Line of Business (LOB) Code');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`incentive_arrangement` ALTER COLUMN `lob_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`incentive_arrangement` ALTER COLUMN `master_entity_reference` SET TAGS ('pii_business_glossary_term' = 'Master Entity Id');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`incentive_arrangement` ALTER COLUMN `maximum_incentive_amount` SET TAGS ('pii_business_glossary_term' = 'Maximum Incentive Amount');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`incentive_arrangement` ALTER COLUMN `maximum_penalty_amount` SET TAGS ('pii_business_glossary_term' = 'Maximum Penalty Amount');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`incentive_arrangement` ALTER COLUMN `measurement_methodology` SET TAGS ('pii_business_glossary_term' = 'Measurement Methodology');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`incentive_arrangement` ALTER COLUMN `measurement_period_end` SET TAGS ('pii_business_glossary_term' = 'Measurement Period End Date');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`incentive_arrangement` ALTER COLUMN `measurement_period_start` SET TAGS ('pii_business_glossary_term' = 'Measurement Period Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`incentive_arrangement` ALTER COLUMN `payout_schedule` SET TAGS ('pii_business_glossary_term' = 'Payout Schedule');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`incentive_arrangement` ALTER COLUMN `payout_schedule` SET TAGS ('pii_value_regex' = 'monthly|quarterly|semi_annual|annual|upon_settlement');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`incentive_arrangement` ALTER COLUMN `performance_threshold_tier` SET TAGS ('pii_business_glossary_term' = 'Performance Threshold Tier');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`incentive_arrangement` ALTER COLUMN `performance_year` SET TAGS ('pii_business_glossary_term' = 'Performance Year');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`incentive_arrangement` ALTER COLUMN `quality_gate_met` SET TAGS ('pii_business_glossary_term' = 'Quality Gate Met Indicator');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`incentive_arrangement` ALTER COLUMN `quality_measure_set` SET TAGS ('pii_business_glossary_term' = 'Quality Measure Set');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`incentive_arrangement` ALTER COLUMN `quality_score` SET TAGS ('pii_business_glossary_term' = 'Quality Score');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`incentive_arrangement` ALTER COLUMN `record_created_at` SET TAGS ('pii_business_glossary_term' = 'Record Created At');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`incentive_arrangement` ALTER COLUMN `record_created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`incentive_arrangement` ALTER COLUMN `record_source_system` SET TAGS ('pii_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`incentive_arrangement` ALTER COLUMN `record_status` SET TAGS ('pii_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`incentive_arrangement` ALTER COLUMN `record_status` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`incentive_arrangement` ALTER COLUMN `record_updated_at` SET TAGS ('pii_business_glossary_term' = 'Record Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`incentive_arrangement` ALTER COLUMN `record_updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`incentive_arrangement` ALTER COLUMN `record_version` SET TAGS ('pii_business_glossary_term' = 'Record Version');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`incentive_arrangement` ALTER COLUMN `reporting_frequency` SET TAGS ('pii_business_glossary_term' = 'Reporting Frequency');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`incentive_arrangement` ALTER COLUMN `reporting_frequency` SET TAGS ('pii_value_regex' = 'monthly|quarterly|semi_annual|annual');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`incentive_arrangement` ALTER COLUMN `settlement_date` SET TAGS ('pii_business_glossary_term' = 'Settlement Date');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`incentive_arrangement` ALTER COLUMN `shared_loss_rate` SET TAGS ('pii_business_glossary_term' = 'Shared Loss Rate');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`incentive_arrangement` ALTER COLUMN `shared_savings_rate` SET TAGS ('pii_business_glossary_term' = 'Shared Savings Rate');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`incentive_arrangement` ALTER COLUMN `sla_commitment` SET TAGS ('pii_business_glossary_term' = 'Service Level Agreement (SLA) Commitment');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`incentive_arrangement` ALTER COLUMN `target_metric` SET TAGS ('pii_business_glossary_term' = 'Target Metric');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`incentive_arrangement` ALTER COLUMN `termination_date` SET TAGS ('pii_business_glossary_term' = 'Termination Date');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`incentive_arrangement` ALTER COLUMN `termination_date` SET TAGS ('pii_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`incentive_arrangement` ALTER COLUMN `total_withheld_amount` SET TAGS ('pii_business_glossary_term' = 'Total Withheld Amount');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`incentive_arrangement` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`incentive_arrangement` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`incentive_arrangement` ALTER COLUMN `vbc_program_name` SET TAGS ('pii_business_glossary_term' = 'Value-Based Care (VBC) Program Name');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`incentive_arrangement` ALTER COLUMN `withhold_percentage` SET TAGS ('pii_business_glossary_term' = 'Withhold Percentage');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`incentive_arrangement` ALTER COLUMN `withhold_pool_type` SET TAGS ('pii_business_glossary_term' = 'Withhold Pool Type');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`incentive_arrangement` ALTER COLUMN `withhold_pool_type` SET TAGS ('pii_value_regex' = 'quality|utilization|risk_sharing|combined');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`incentive_arrangement` ALTER COLUMN `withhold_release_criteria` SET TAGS ('pii_business_glossary_term' = 'Withhold Release Criteria');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_network_participation` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_network_participation` SET TAGS ('pii_subdomain' = 'agreement_parties');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_network_participation` SET TAGS ('pii_fhir_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_network_participation` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_network_participation` SET TAGS ('pii_fhir_resource' = 'Organization');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_network_participation` SET TAGS ('pii_ecm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_network_participation` SET TAGS ('pii_ssot' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_network_participation` SET TAGS ('pii_fhir_interop' = 'ready');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_network_participation` SET TAGS ('pii_authority_source' = 'verbatim_reviewer_comments_working_group_sheet');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_network_participation` ALTER COLUMN `contract_network_participation_id` SET TAGS ('pii_business_glossary_term' = 'Network Participation Identifier (ID)');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_network_participation` ALTER COLUMN `employee_id` SET TAGS ('pii_business_glossary_term' = 'Approved By Employee Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_network_participation` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_network_participation` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_network_participation` ALTER COLUMN `provider_contract_id` SET TAGS ('pii_business_glossary_term' = 'Contract Identifier (ID)');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_network_participation` ALTER COLUMN `provider_id` SET TAGS ('pii_business_glossary_term' = 'Provider Identifier (ID)');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_network_participation` ALTER COLUMN `provider_network_id` SET TAGS ('pii_business_glossary_term' = 'Network Identifier (ID)');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_network_participation` ALTER COLUMN `record_id` SET TAGS ('pii_business_glossary_term' = 'Credential Record Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_network_participation` ALTER COLUMN `accepting_new_patients_flag` SET TAGS ('pii_business_glossary_term' = 'Accepting New Patients Flag');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_network_participation` ALTER COLUMN `aco_participant_flag` SET TAGS ('pii_business_glossary_term' = 'Accountable Care Organization (ACO) Participant Flag');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_network_participation` ALTER COLUMN `amendment_number` SET TAGS ('pii_business_glossary_term' = 'Contract Amendment Number');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_network_participation` ALTER COLUMN `amendment_number` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_network_participation` ALTER COLUMN `approval_date` SET TAGS ('pii_business_glossary_term' = 'Network Participation Approval Date');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_network_participation` ALTER COLUMN `auto_renewal_flag` SET TAGS ('pii_business_glossary_term' = 'Automatic Renewal Flag');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_network_participation` ALTER COLUMN `claims_adjudication_priority` SET TAGS ('pii_business_glossary_term' = 'Claims Adjudication Priority Rank');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_network_participation` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_network_participation` ALTER COLUMN `created_timestamp` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_network_participation` ALTER COLUMN `credentialing_date` SET TAGS ('pii_business_glossary_term' = 'Provider Credentialing Date');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_network_participation` ALTER COLUMN `credentialing_status` SET TAGS ('pii_business_glossary_term' = 'Provider Credentialing Status');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_network_participation` ALTER COLUMN `credentialing_status` SET TAGS ('pii_value_regex' = 'credentialed|pending|expired|suspended|revoked');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_network_participation` ALTER COLUMN `data_quality_score` SET TAGS ('pii_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_network_participation` ALTER COLUMN `directory_publication_flag` SET TAGS ('pii_business_glossary_term' = 'Provider Directory Publication Flag');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_network_participation` ALTER COLUMN `effective_date` SET TAGS ('pii_business_glossary_term' = 'Network Participation Effective Date');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_network_participation` ALTER COLUMN `effective_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_network_participation` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_network_participation` ALTER COLUMN `effective_end_date` SET TAGS ('pii_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_network_participation` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_network_participation` ALTER COLUMN `effective_start_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_network_participation` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_network_participation` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_network_participation` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_network_participation` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_network_participation` ALTER COLUMN `fhir_resource_reference` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_network_participation` ALTER COLUMN `fhir_resource_reference` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_network_participation` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_network_participation` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_network_participation` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_network_participation` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_network_participation` ALTER COLUMN `geographic_service_area` SET TAGS ('pii_business_glossary_term' = 'Geographic Service Area');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_network_participation` ALTER COLUMN `in_network_flag` SET TAGS ('pii_business_glossary_term' = 'In-Network Indicator Flag');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_network_participation` ALTER COLUMN `is_active` SET TAGS ('pii_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_network_participation` ALTER COLUMN `lob` SET TAGS ('pii_business_glossary_term' = 'Line of Business (LOB)');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_network_participation` ALTER COLUMN `lob` SET TAGS ('pii_value_regex' = 'commercial|medicare_advantage|medicaid|exchange|qhp|dual_eligible');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_network_participation` ALTER COLUMN `master_entity_reference` SET TAGS ('pii_business_glossary_term' = 'Master Entity Id');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_network_participation` ALTER COLUMN `network_tier` SET TAGS ('pii_business_glossary_term' = 'Network Tier Classification');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_network_participation` ALTER COLUMN `network_tier` SET TAGS ('pii_value_regex' = 'tier_1|tier_2|preferred|standard|narrow|exclusive');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_network_participation` ALTER COLUMN `out_of_network_flag` SET TAGS ('pii_business_glossary_term' = 'Out-of-Network Indicator Flag');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_network_participation` ALTER COLUMN `participation_number` SET TAGS ('pii_business_glossary_term' = 'Network Participation Number');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_network_participation` ALTER COLUMN `participation_number` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_network_participation` ALTER COLUMN `participation_status` SET TAGS ('pii_business_glossary_term' = 'Network Participation Status');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_network_participation` ALTER COLUMN `participation_status` SET TAGS ('pii_value_regex' = 'active|pending|suspended|terminated|inactive');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_network_participation` ALTER COLUMN `pcp_assignment_eligible_flag` SET TAGS ('pii_business_glossary_term' = 'Primary Care Physician (PCP) Assignment Eligible Flag');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_network_participation` ALTER COLUMN `prior_authorization_required_flag` SET TAGS ('pii_business_glossary_term' = 'Prior Authorization (PA) Required Flag');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_network_participation` ALTER COLUMN `product_line` SET TAGS ('pii_business_glossary_term' = 'Product Line Type');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_network_participation` ALTER COLUMN `product_line` SET TAGS ('pii_value_regex' = 'hmo|ppo|epo|pos|hdhp|indemnity');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_network_participation` ALTER COLUMN `quality_tier_designation` SET TAGS ('pii_business_glossary_term' = 'Quality Tier Designation');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_network_participation` ALTER COLUMN `quality_tier_designation` SET TAGS ('pii_value_regex' = 'platinum|gold|silver|bronze|standard|not_rated');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_network_participation` ALTER COLUMN `record_created_at` SET TAGS ('pii_business_glossary_term' = 'Record Created At');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_network_participation` ALTER COLUMN `record_created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_network_participation` ALTER COLUMN `record_source_system` SET TAGS ('pii_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_network_participation` ALTER COLUMN `record_status` SET TAGS ('pii_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_network_participation` ALTER COLUMN `record_status` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_network_participation` ALTER COLUMN `record_updated_at` SET TAGS ('pii_business_glossary_term' = 'Record Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_network_participation` ALTER COLUMN `record_updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_network_participation` ALTER COLUMN `record_version` SET TAGS ('pii_business_glossary_term' = 'Record Version');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_network_participation` ALTER COLUMN `recredentialing_due_date` SET TAGS ('pii_business_glossary_term' = 'Provider Recredentialing Due Date');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_network_participation` ALTER COLUMN `referral_required_flag` SET TAGS ('pii_business_glossary_term' = 'Referral Required Flag');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_network_participation` ALTER COLUMN `risk_share_percentage` SET TAGS ('pii_business_glossary_term' = 'Risk Share Percentage');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_network_participation` ALTER COLUMN `service_area_county` SET TAGS ('pii_business_glossary_term' = 'Service Area County Name');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_network_participation` ALTER COLUMN `service_area_state` SET TAGS ('pii_business_glossary_term' = 'Service Area State Code');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_network_participation` ALTER COLUMN `service_area_zip_codes` SET TAGS ('pii_business_glossary_term' = 'Service Area ZIP Codes');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_network_participation` ALTER COLUMN `service_area_zip_codes` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_network_participation` ALTER COLUMN `service_area_zip_codes` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_network_participation` ALTER COLUMN `source_system_code` SET TAGS ('pii_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_network_participation` ALTER COLUMN `source_system_record_reference` SET TAGS ('pii_business_glossary_term' = 'Source System Record Identifier (ID)');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_network_participation` ALTER COLUMN `telehealth_eligible_flag` SET TAGS ('pii_business_glossary_term' = 'Telehealth Services Eligible Flag');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_network_participation` ALTER COLUMN `termination_date` SET TAGS ('pii_business_glossary_term' = 'Network Participation Termination Date');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_network_participation` ALTER COLUMN `termination_date` SET TAGS ('pii_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_network_participation` ALTER COLUMN `termination_notice_days` SET TAGS ('pii_business_glossary_term' = 'Termination Notice Period Days');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_network_participation` ALTER COLUMN `termination_reason` SET TAGS ('pii_business_glossary_term' = 'Network Participation Termination Reason');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_network_participation` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_network_participation` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_network_participation` ALTER COLUMN `vbc_arrangement_type` SET TAGS ('pii_business_glossary_term' = 'Value-Based Care (VBC) Arrangement Type');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_network_participation` ALTER COLUMN `vbc_arrangement_type` SET TAGS ('pii_value_regex' = 'fee_for_service|shared_savings|shared_risk|capitation|bundled_payment|none');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_network_participation` ALTER COLUMN `version_number` SET TAGS ('pii_business_glossary_term' = 'Version Number');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`financial_summary` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`financial_summary` SET TAGS ('pii_subdomain' = 'payment_reimbursement');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`financial_summary` SET TAGS ('pii_fhir_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`financial_summary` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`financial_summary` SET TAGS ('pii_fhir_resource' = 'Basic');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`financial_summary` SET TAGS ('pii_ecm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`financial_summary` SET TAGS ('pii_ssot' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`financial_summary` SET TAGS ('pii_fhir_interop' = 'ready');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`financial_summary` SET TAGS ('pii_authority_source' = 'verbatim_reviewer_comments_working_group_sheet');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`financial_summary` ALTER COLUMN `financial_summary_id` SET TAGS ('pii_business_glossary_term' = 'Financial Summary ID');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`financial_summary` ALTER COLUMN `provider_contract_id` SET TAGS ('pii_business_glossary_term' = 'Provider Contract ID');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`financial_summary` ALTER COLUMN `cost_center_id` SET TAGS ('pii_business_glossary_term' = 'Cost Center Id');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`financial_summary` ALTER COLUMN `ledger_id` SET TAGS ('pii_business_glossary_term' = 'Ledger Id');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`financial_summary` ALTER COLUMN `parent_financial_summary_id` SET TAGS ('pii_business_glossary_term' = 'Parent Financial Summary Id');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`financial_summary` ALTER COLUMN `parent_financial_summary_id` SET TAGS ('pii_self_ref_fk' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`financial_summary` ALTER COLUMN `provider_id` SET TAGS ('pii_business_glossary_term' = 'Provider Id');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`financial_summary` ALTER COLUMN `attributed_member_count` SET TAGS ('pii_business_glossary_term' = 'Attributed Member Count');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`financial_summary` ALTER COLUMN `capitation_accrual_balance` SET TAGS ('pii_business_glossary_term' = 'Capitation Accrual Balance');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`financial_summary` ALTER COLUMN `claim_count` SET TAGS ('pii_business_glossary_term' = 'Claim Count');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`financial_summary` ALTER COLUMN `contract_number` SET TAGS ('pii_business_glossary_term' = 'Contract Number');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`financial_summary` ALTER COLUMN `contract_number` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`financial_summary` ALTER COLUMN `contract_type` SET TAGS ('pii_business_glossary_term' = 'Contract Type');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`financial_summary` ALTER COLUMN `contract_type` SET TAGS ('pii_value_regex' = 'fee_for_service|capitation|bundled|value_based|shared_savings|risk_sharing');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`financial_summary` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`financial_summary` ALTER COLUMN `created_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`financial_summary` ALTER COLUMN `currency_code` SET TAGS ('pii_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`financial_summary` ALTER COLUMN `currency_code` SET TAGS ('pii_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`financial_summary` ALTER COLUMN `currency_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`financial_summary` ALTER COLUMN `data_quality_score` SET TAGS ('pii_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`financial_summary` ALTER COLUMN `effective_date` SET TAGS ('pii_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`financial_summary` ALTER COLUMN `effective_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`financial_summary` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`financial_summary` ALTER COLUMN `effective_end_date` SET TAGS ('pii_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`financial_summary` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`financial_summary` ALTER COLUMN `effective_start_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`financial_summary` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`financial_summary` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`financial_summary` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`financial_summary` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`financial_summary` ALTER COLUMN `fhir_resource_reference` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`financial_summary` ALTER COLUMN `fhir_resource_reference` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`financial_summary` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`financial_summary` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`financial_summary` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`financial_summary` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`financial_summary` ALTER COLUMN `financial_summary_status` SET TAGS ('pii_business_glossary_term' = 'Contract Status');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`financial_summary` ALTER COLUMN `financial_summary_status` SET TAGS ('pii_value_regex' = 'active|inactive|terminated|pending|draft|suspended');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`financial_summary` ALTER COLUMN `ibnr_estimate_amount` SET TAGS ('pii_business_glossary_term' = 'IBNR Estimate Amount');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`financial_summary` ALTER COLUMN `ibnr_reserve_amount` SET TAGS ('pii_business_glossary_term' = 'Ibnr Reserve Amount');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`financial_summary` ALTER COLUMN `incentive_earned_amount` SET TAGS ('pii_business_glossary_term' = 'Incentive Earned Amount');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`financial_summary` ALTER COLUMN `is_active` SET TAGS ('pii_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`financial_summary` ALTER COLUMN `lob_code` SET TAGS ('pii_business_glossary_term' = 'Lob Code');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`financial_summary` ALTER COLUMN `master_entity_reference` SET TAGS ('pii_business_glossary_term' = 'Master Entity Id');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`financial_summary` ALTER COLUMN `medical_loss_ratio` SET TAGS ('pii_business_glossary_term' = 'Medical Loss Ratio');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`financial_summary` ALTER COLUMN `medical_loss_ratio` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`financial_summary` ALTER COLUMN `medical_loss_ratio` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`financial_summary` ALTER COLUMN `mrl_allocation_amount` SET TAGS ('pii_business_glossary_term' = 'Medical Loss Ratio Allocation Amount');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`financial_summary` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`financial_summary` ALTER COLUMN `payment_methodology` SET TAGS ('pii_business_glossary_term' = 'Payment Methodology');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`financial_summary` ALTER COLUMN `payment_methodology` SET TAGS ('pii_value_regex' = 'fee_for_service|capitation|bundled|value_based');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`financial_summary` ALTER COLUMN `performance_year` SET TAGS ('pii_business_glossary_term' = 'Performance Year');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`financial_summary` ALTER COLUMN `pmpm_cost` SET TAGS ('pii_business_glossary_term' = 'Pmpm Cost');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`financial_summary` ALTER COLUMN `quality_score` SET TAGS ('pii_business_glossary_term' = 'Quality Score');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`financial_summary` ALTER COLUMN `reconciliation_date` SET TAGS ('pii_business_glossary_term' = 'Reconciliation Date');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`financial_summary` ALTER COLUMN `reconciliation_status` SET TAGS ('pii_business_glossary_term' = 'Reconciliation Status');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`financial_summary` ALTER COLUMN `reconciliation_status` SET TAGS ('pii_value_regex' = 'reconciled|pending|error|partial|not_applicable');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`financial_summary` ALTER COLUMN `record_created_at` SET TAGS ('pii_business_glossary_term' = 'Record Created At');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`financial_summary` ALTER COLUMN `record_created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Created Timestamp (Audit)');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`financial_summary` ALTER COLUMN `record_source_system` SET TAGS ('pii_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`financial_summary` ALTER COLUMN `record_status` SET TAGS ('pii_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`financial_summary` ALTER COLUMN `record_status` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`financial_summary` ALTER COLUMN `record_updated_at` SET TAGS ('pii_business_glossary_term' = 'Record Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`financial_summary` ALTER COLUMN `record_updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`financial_summary` ALTER COLUMN `record_version` SET TAGS ('pii_business_glossary_term' = 'Record Version');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`financial_summary` ALTER COLUMN `risk_share_percentage` SET TAGS ('pii_business_glossary_term' = 'Risk Share Percentage');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`financial_summary` ALTER COLUMN `source_system_code` SET TAGS ('pii_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`financial_summary` ALTER COLUMN `summary_period_end` SET TAGS ('pii_business_glossary_term' = 'Summary Period End Date');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`financial_summary` ALTER COLUMN `summary_period_start` SET TAGS ('pii_business_glossary_term' = 'Summary Period Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`financial_summary` ALTER COLUMN `summary_period_type` SET TAGS ('pii_business_glossary_term' = 'Summary Period Type');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`financial_summary` ALTER COLUMN `summary_period_type` SET TAGS ('pii_value_regex' = 'month|quarter|year');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`financial_summary` ALTER COLUMN `summary_status` SET TAGS ('pii_business_glossary_term' = 'Summary Status');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`financial_summary` ALTER COLUMN `termination_date` SET TAGS ('pii_business_glossary_term' = 'Termination Date');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`financial_summary` ALTER COLUMN `termination_date` SET TAGS ('pii_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`financial_summary` ALTER COLUMN `total_allowed_amount` SET TAGS ('pii_business_glossary_term' = 'Total Allowed Amount');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`financial_summary` ALTER COLUMN `total_billed_amount` SET TAGS ('pii_business_glossary_term' = 'Total Billed Amount');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`financial_summary` ALTER COLUMN `total_capitation_paid` SET TAGS ('pii_business_glossary_term' = 'Total Capitation Paid');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`financial_summary` ALTER COLUMN `total_incentive_paid` SET TAGS ('pii_business_glossary_term' = 'Total Incentive Paid');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`financial_summary` ALTER COLUMN `total_paid_amount` SET TAGS ('pii_business_glossary_term' = 'Total Paid Amount');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`financial_summary` ALTER COLUMN `total_shared_loss` SET TAGS ('pii_business_glossary_term' = 'Total Shared Loss');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`financial_summary` ALTER COLUMN `total_shared_savings` SET TAGS ('pii_business_glossary_term' = 'Total Shared Savings');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`financial_summary` ALTER COLUMN `total_withhold_amount` SET TAGS ('pii_business_glossary_term' = 'Total Withhold Amount');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`financial_summary` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`financial_summary` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`financial_summary` ALTER COLUMN `withhold_pool_balance` SET TAGS ('pii_business_glossary_term' = 'Withhold Pool Balance');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`obligation` SET TAGS ('pii_data_type' = 'association_data');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`obligation` SET TAGS ('pii_subdomain' = 'obligation_compliance');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`obligation` SET TAGS ('pii_association_edges' = 'contract.provider_contract,compliance.regulatory_obligation');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`obligation` SET TAGS ('pii_fhir_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`obligation` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`obligation` SET TAGS ('pii_fhir_resource' = 'Basic');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`obligation` SET TAGS ('pii_ecm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`obligation` SET TAGS ('pii_ssot' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`obligation` SET TAGS ('pii_fhir_interop' = 'ready');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`obligation` SET TAGS ('pii_authority_source' = 'verbatim_reviewer_comments_working_group_sheet');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`party_regulatory_obligation_compliance` SET TAGS ('pii_data_type' = 'association_data');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`party_regulatory_obligation_compliance` SET TAGS ('pii_subdomain' = 'obligation_compliance');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`party_regulatory_obligation_compliance` SET TAGS ('pii_association_edges' = 'contract.party,compliance.regulatory_obligation');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`party_regulatory_obligation_compliance` SET TAGS ('pii_fhir_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`party_regulatory_obligation_compliance` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`party_regulatory_obligation_compliance` SET TAGS ('pii_fhir_resource' = 'Basic');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`party_regulatory_obligation_compliance` SET TAGS ('pii_ecm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`party_regulatory_obligation_compliance` SET TAGS ('pii_ssot' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`party_regulatory_obligation_compliance` SET TAGS ('pii_fhir_interop' = 'ready');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`party_regulatory_obligation_compliance` SET TAGS ('pii_authority_source' = 'verbatim_reviewer_comments_working_group_sheet');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`provider_contract` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`provider_contract` SET TAGS ('pii_subdomain' = 'agreement_parties');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`provider_contract` SET TAGS ('pii_mvm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`provider_contract` SET TAGS ('pii_fhir_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`provider_contract` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`provider_contract` SET TAGS ('pii_fhir_resource' = 'Practitioner');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`provider_contract` SET TAGS ('pii_ecm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`provider_contract` SET TAGS ('pii_ssot' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`provider_contract` SET TAGS ('pii_fhir_interop' = 'ready');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`provider_contract` SET TAGS ('pii_ssot_source_domain' = 'contract');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`provider_contract` SET TAGS ('pii_authority_source' = 'verbatim_reviewer_comments_working_group_sheet');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`provider_contract` SET TAGS ('pii_table_name' = 'provider_contract');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`provider_contract` SET TAGS ('pii_vreq_skip_P209' = 'skip');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`provider_contract` SET TAGS ('pii_rename_confirmed' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`provider_contract` ALTER COLUMN `provider_contract_id` SET TAGS ('pii_business_glossary_term' = 'Provider Contract Id');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`provider_contract` ALTER COLUMN `provider_contract_id` SET TAGS ('pii_pk' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`provider_contract` ALTER COLUMN `health_plan_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`provider_contract` ALTER COLUMN `health_plan_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`provider_contract` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`provider_contract` ALTER COLUMN `created_timestamp` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`provider_contract` ALTER COLUMN `data_quality_score` SET TAGS ('pii_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`provider_contract` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`provider_contract` ALTER COLUMN `effective_end_date` SET TAGS ('pii_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`provider_contract` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`provider_contract` ALTER COLUMN `effective_start_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`provider_contract` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`provider_contract` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`provider_contract` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`provider_contract` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`provider_contract` ALTER COLUMN `fhir_resource_reference` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`provider_contract` ALTER COLUMN `fhir_resource_reference` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`provider_contract` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`provider_contract` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`provider_contract` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`provider_contract` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`provider_contract` ALTER COLUMN `is_active` SET TAGS ('pii_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`provider_contract` ALTER COLUMN `master_entity_reference` SET TAGS ('pii_business_glossary_term' = 'Master Entity Id');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`provider_contract` ALTER COLUMN `record_created_at` SET TAGS ('pii_business_glossary_term' = 'Record Created At');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`provider_contract` ALTER COLUMN `record_source_system` SET TAGS ('pii_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`provider_contract` ALTER COLUMN `record_status` SET TAGS ('pii_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`provider_contract` ALTER COLUMN `record_status` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`provider_contract` ALTER COLUMN `record_updated_at` SET TAGS ('pii_business_glossary_term' = 'Record Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`provider_contract` ALTER COLUMN `record_version` SET TAGS ('pii_business_glossary_term' = 'Record Version');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`provider_contract` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`provider_contract` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_dispute` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_dispute` SET TAGS ('pii_subdomain' = 'obligation_compliance');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_dispute` SET TAGS ('pii_fhir_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_dispute` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_dispute` SET TAGS ('pii_fhir_resource' = 'Basic');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_dispute` SET TAGS ('pii_ecm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_dispute` SET TAGS ('pii_fhir_interop' = 'ready');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_dispute` SET TAGS ('pii_ssot_source_domain' = 'contract');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_dispute` SET TAGS ('pii_ssot_master' = 'dispute');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_dispute` SET TAGS ('pii_ssot_canonical' = 'contract.contract_dispute');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_dispute` SET TAGS ('pii_ssot_role' = 'canonical');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_dispute` SET TAGS ('pii_authority_source' = 'verbatim_reviewer_comments_working_group_sheet');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_dispute` SET TAGS ('pii_ssot' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_dispute` SET TAGS ('pii_ssot_concept' = 'contract_dispute');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_dispute` ALTER COLUMN `contract_dispute_id` SET TAGS ('pii_business_glossary_term' = 'Contract Dispute Identifier (ID)');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_dispute` ALTER COLUMN `employee_id` SET TAGS ('pii_business_glossary_term' = 'Assigned To Employee Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_dispute` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_dispute` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_dispute` ALTER COLUMN `provider_contract_id` SET TAGS ('pii_business_glossary_term' = 'Contract Identifier (ID)');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_dispute` ALTER COLUMN `provider_id` SET TAGS ('pii_business_glossary_term' = 'Provider Identifier (ID)');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_dispute` ALTER COLUMN `affected_service_period_end` SET TAGS ('pii_business_glossary_term' = 'Affected Service Period End Date');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_dispute` ALTER COLUMN `affected_service_period_start` SET TAGS ('pii_business_glossary_term' = 'Affected Service Period Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_dispute` ALTER COLUMN `arbitration_case_number` SET TAGS ('pii_business_glossary_term' = 'Arbitration Case Number');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_dispute` ALTER COLUMN `arbitration_case_number` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_dispute` ALTER COLUMN `contract_amendment_required` SET TAGS ('pii_business_glossary_term' = 'Contract Amendment Required Flag');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_dispute` ALTER COLUMN `contract_clause_reference` SET TAGS ('pii_business_glossary_term' = 'Contract Clause Reference');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_dispute` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_dispute` ALTER COLUMN `created_timestamp` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_dispute` ALTER COLUMN `currency_code` SET TAGS ('pii_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_dispute` ALTER COLUMN `currency_code` SET TAGS ('pii_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_dispute` ALTER COLUMN `currency_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_dispute` ALTER COLUMN `data_quality_score` SET TAGS ('pii_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_dispute` ALTER COLUMN `dispute_number` SET TAGS ('pii_business_glossary_term' = 'Dispute Number');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_dispute` ALTER COLUMN `dispute_number` SET TAGS ('pii_value_regex' = '^DSP-[0-9]{8}$');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_dispute` ALTER COLUMN `dispute_number` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_dispute` ALTER COLUMN `dispute_status` SET TAGS ('pii_business_glossary_term' = 'Dispute Status');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_dispute` ALTER COLUMN `dispute_status` SET TAGS ('pii_value_regex' = 'open|under_review|pending_documentation|resolved|escalated_to_arbitration|closed');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_dispute` ALTER COLUMN `dispute_type` SET TAGS ('pii_business_glossary_term' = 'Dispute Type');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_dispute` ALTER COLUMN `dispute_type` SET TAGS ('pii_value_regex' = 'rate_dispute|scope_of_service_dispute|payment_dispute|termination_dispute|credentialing_dispute|network_status_dispute');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_dispute` ALTER COLUMN `disputed_amount` SET TAGS ('pii_business_glossary_term' = 'Disputed Amount');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_dispute` ALTER COLUMN `document_repository_path` SET TAGS ('pii_business_glossary_term' = 'Document Repository Path');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_dispute` ALTER COLUMN `document_repository_path` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_dispute` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_dispute` ALTER COLUMN `effective_end_date` SET TAGS ('pii_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_dispute` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_dispute` ALTER COLUMN `effective_start_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_dispute` ALTER COLUMN `escalation_date` SET TAGS ('pii_business_glossary_term' = 'Escalation Date');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_dispute` ALTER COLUMN `escalation_flag` SET TAGS ('pii_business_glossary_term' = 'Escalation Flag');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_dispute` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_dispute` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_dispute` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_dispute` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_dispute` ALTER COLUMN `fhir_resource_reference` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_dispute` ALTER COLUMN `fhir_resource_reference` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_dispute` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_dispute` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_dispute` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_dispute` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_dispute` ALTER COLUMN `initiation_date` SET TAGS ('pii_business_glossary_term' = 'Dispute Initiation Date');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_dispute` ALTER COLUMN `is_active` SET TAGS ('pii_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_dispute` ALTER COLUMN `legal_counsel_involved` SET TAGS ('pii_business_glossary_term' = 'Legal Counsel Involved Flag');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_dispute` ALTER COLUMN `legal_counsel_name` SET TAGS ('pii_business_glossary_term' = 'Legal Counsel Name');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_dispute` ALTER COLUMN `legal_counsel_name` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_dispute` ALTER COLUMN `lob_code` SET TAGS ('pii_business_glossary_term' = 'Line of Business (LOB) Code');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_dispute` ALTER COLUMN `lob_code` SET TAGS ('pii_value_regex' = 'commercial|medicare|medicaid|exchange|aso|tpa');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_dispute` ALTER COLUMN `lob_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_dispute` ALTER COLUMN `master_entity_reference` SET TAGS ('pii_business_glossary_term' = 'Master Entity Id');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_dispute` ALTER COLUMN `payment_adjustment_required` SET TAGS ('pii_business_glossary_term' = 'Payment Adjustment Required Flag');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_dispute` ALTER COLUMN `priority_level` SET TAGS ('pii_business_glossary_term' = 'Priority Level');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_dispute` ALTER COLUMN `priority_level` SET TAGS ('pii_value_regex' = 'low|medium|high|critical');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_dispute` ALTER COLUMN `provider_contact_email` SET TAGS ('pii_business_glossary_term' = 'Provider Contact Email Address');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_dispute` ALTER COLUMN `provider_contact_email` SET TAGS ('pii_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_dispute` ALTER COLUMN `provider_contact_email` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_dispute` ALTER COLUMN `provider_contact_email` SET TAGS ('pii_email' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_dispute` ALTER COLUMN `provider_contact_name` SET TAGS ('pii_business_glossary_term' = 'Provider Contact Name');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_dispute` ALTER COLUMN `provider_contact_name` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_dispute` ALTER COLUMN `provider_contact_phone` SET TAGS ('pii_business_glossary_term' = 'Provider Contact Phone Number');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_dispute` ALTER COLUMN `provider_contact_phone` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_dispute` ALTER COLUMN `provider_contact_phone` SET TAGS ('pii_phone' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_dispute` ALTER COLUMN `reason` SET TAGS ('pii_business_glossary_term' = 'Dispute Reason');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_dispute` ALTER COLUMN `received_timestamp` SET TAGS ('pii_business_glossary_term' = 'Dispute Received Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_dispute` ALTER COLUMN `record_created_at` SET TAGS ('pii_business_glossary_term' = 'Record Created At');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_dispute` ALTER COLUMN `record_created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_dispute` ALTER COLUMN `record_source_system` SET TAGS ('pii_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_dispute` ALTER COLUMN `record_status` SET TAGS ('pii_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_dispute` ALTER COLUMN `record_status` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_dispute` ALTER COLUMN `record_updated_at` SET TAGS ('pii_business_glossary_term' = 'Record Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_dispute` ALTER COLUMN `record_updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_dispute` ALTER COLUMN `record_version` SET TAGS ('pii_business_glossary_term' = 'Record Version');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_dispute` ALTER COLUMN `regulatory_report_date` SET TAGS ('pii_business_glossary_term' = 'Regulatory Report Date');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_dispute` ALTER COLUMN `regulatory_reporting_required` SET TAGS ('pii_business_glossary_term' = 'Regulatory Reporting Required Flag');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_dispute` ALTER COLUMN `resolution_amount` SET TAGS ('pii_business_glossary_term' = 'Resolution Amount');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_dispute` ALTER COLUMN `resolution_date` SET TAGS ('pii_business_glossary_term' = 'Resolution Date');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_dispute` ALTER COLUMN `resolution_notes` SET TAGS ('pii_business_glossary_term' = 'Resolution Notes');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_dispute` ALTER COLUMN `resolution_notes` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_dispute` ALTER COLUMN `resolution_outcome` SET TAGS ('pii_business_glossary_term' = 'Resolution Outcome');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_dispute` ALTER COLUMN `resolution_outcome` SET TAGS ('pii_value_regex' = 'provider_favor|plan_favor|partial_settlement|withdrawn|arbitration_pending');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_dispute` ALTER COLUMN `sla_due_date` SET TAGS ('pii_business_glossary_term' = 'Service Level Agreement (SLA) Due Date');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_dispute` ALTER COLUMN `sla_met_flag` SET TAGS ('pii_business_glossary_term' = 'Service Level Agreement (SLA) Met Flag');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_dispute` ALTER COLUMN `sla_resolution_days` SET TAGS ('pii_business_glossary_term' = 'Service Level Agreement (SLA) Resolution Days');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_dispute` ALTER COLUMN `source_system_code` SET TAGS ('pii_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_dispute` ALTER COLUMN `source_system_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_dispute` ALTER COLUMN `supporting_document_count` SET TAGS ('pii_business_glossary_term' = 'Supporting Document Count');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_dispute` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_dispute` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_lifecycle_event2` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_lifecycle_event2` SET TAGS ('pii_subdomain' = 'lifecycle_tracking');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_lifecycle_event2` SET TAGS ('pii_fhir_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_lifecycle_event2` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_lifecycle_event2` SET TAGS ('pii_fhir_resource' = 'Basic');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_lifecycle_event2` SET TAGS ('pii_ecm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_lifecycle_event2` SET TAGS ('pii_fhir_interop' = 'ready');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_lifecycle_event2` SET TAGS ('pii_ssot_source_domain' = 'contract');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_lifecycle_event2` SET TAGS ('pii_ssot_master' = 'lifecycle_event');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_lifecycle_event2` SET TAGS ('pii_ssot_canonical' = 'contract.contract_lifecycle_event');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_lifecycle_event2` SET TAGS ('pii_ssot_role' = 'canonical');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_lifecycle_event2` SET TAGS ('pii_authority_source' = 'verbatim_reviewer_comments_working_group_sheet');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_lifecycle_event2` SET TAGS ('pii_ssot' = 'false');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_lifecycle_event2` SET TAGS ('pii_deprecated' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_lifecycle_event2` SET TAGS ('pii_ssot_ref' = 'member.member_lifecycle_event');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_lifecycle_event2` SET TAGS ('pii_ssot_concept' = 'member_lifecycle_event');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_lifecycle_event2` SET TAGS ('pii_vreq_skip_P204' = 'skip');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_lifecycle_event2` ALTER COLUMN `contract_lifecycle_event2_id` SET TAGS ('pii_business_glossary_term' = 'Contract Lifecycle Event ID');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_lifecycle_event2` ALTER COLUMN `contract_amendment_id` SET TAGS ('pii_business_glossary_term' = 'Amendment ID');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_lifecycle_event2` ALTER COLUMN `provider_contract_id` SET TAGS ('pii_business_glossary_term' = 'Contract ID');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_lifecycle_event2` ALTER COLUMN `employee_id` SET TAGS ('pii_business_glossary_term' = 'Contracting Analyst Employee Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_lifecycle_event2` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_lifecycle_event2` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_lifecycle_event2` ALTER COLUMN `provider_network_id` SET TAGS ('pii_business_glossary_term' = 'Network ID');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_lifecycle_event2` ALTER COLUMN `approval_required_flag` SET TAGS ('pii_business_glossary_term' = 'Approval Required Flag');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_lifecycle_event2` ALTER COLUMN `approval_status` SET TAGS ('pii_business_glossary_term' = 'Event Approval Status');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_lifecycle_event2` ALTER COLUMN `approval_status` SET TAGS ('pii_value_regex' = 'not_required|pending|approved|rejected|escalated');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_lifecycle_event2` ALTER COLUMN `approved_timestamp` SET TAGS ('pii_business_glossary_term' = 'Event Approval Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_lifecycle_event2` ALTER COLUMN `approver_name` SET TAGS ('pii_business_glossary_term' = 'Event Approver Name');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_lifecycle_event2` ALTER COLUMN `claims_reprocess_required` SET TAGS ('pii_business_glossary_term' = 'Claims Reprocessing Required Flag');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_lifecycle_event2` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_lifecycle_event2` ALTER COLUMN `created_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_lifecycle_event2` ALTER COLUMN `data_quality_score` SET TAGS ('pii_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_lifecycle_event2` ALTER COLUMN `dispute_status` SET TAGS ('pii_business_glossary_term' = 'Contract Dispute Status');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_lifecycle_event2` ALTER COLUMN `dispute_status` SET TAGS ('pii_value_regex' = 'open|under_review|resolved|escalated_to_arbitration|withdrawn');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_lifecycle_event2` ALTER COLUMN `dispute_type` SET TAGS ('pii_business_glossary_term' = 'Contract Dispute Type');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_lifecycle_event2` ALTER COLUMN `dispute_type` SET TAGS ('pii_value_regex' = 'rate_dispute|scope_of_service|payment_dispute|termination_dispute|credentialing_dispute');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_lifecycle_event2` ALTER COLUMN `disputed_amount` SET TAGS ('pii_business_glossary_term' = 'Disputed Amount');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_lifecycle_event2` ALTER COLUMN `disputed_amount` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_lifecycle_event2` ALTER COLUMN `document_reference` SET TAGS ('pii_business_glossary_term' = 'Supporting Document Reference');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_lifecycle_event2` ALTER COLUMN `effective_date` SET TAGS ('pii_business_glossary_term' = 'Contract Event Effective Date');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_lifecycle_event2` ALTER COLUMN `effective_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_lifecycle_event2` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_lifecycle_event2` ALTER COLUMN `effective_end_date` SET TAGS ('pii_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_lifecycle_event2` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_lifecycle_event2` ALTER COLUMN `effective_start_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_lifecycle_event2` ALTER COLUMN `event_notes` SET TAGS ('pii_business_glossary_term' = 'Contract Lifecycle Event Notes');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_lifecycle_event2` ALTER COLUMN `event_number` SET TAGS ('pii_business_glossary_term' = 'Contract Lifecycle Event Number');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_lifecycle_event2` ALTER COLUMN `event_number` SET TAGS ('pii_value_regex' = '^EVT-[0-9]{4}-[0-9]{6}$');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_lifecycle_event2` ALTER COLUMN `event_number` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_lifecycle_event2` ALTER COLUMN `event_status` SET TAGS ('pii_business_glossary_term' = 'Contract Lifecycle Event Status');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_lifecycle_event2` ALTER COLUMN `event_status` SET TAGS ('pii_value_regex' = 'pending|in_progress|completed|cancelled|failed');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_lifecycle_event2` ALTER COLUMN `event_timestamp` SET TAGS ('pii_business_glossary_term' = 'Contract Lifecycle Event Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_lifecycle_event2` ALTER COLUMN `event_type` SET TAGS ('pii_business_glossary_term' = 'Contract Lifecycle Event Type');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_lifecycle_event2` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_lifecycle_event2` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_lifecycle_event2` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_lifecycle_event2` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_lifecycle_event2` ALTER COLUMN `fhir_resource_reference` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_lifecycle_event2` ALTER COLUMN `fhir_resource_reference` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_lifecycle_event2` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_lifecycle_event2` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_lifecycle_event2` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_lifecycle_event2` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_lifecycle_event2` ALTER COLUMN `is_active` SET TAGS ('pii_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_lifecycle_event2` ALTER COLUMN `lob_code` SET TAGS ('pii_business_glossary_term' = 'Line of Business (LOB) Code');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_lifecycle_event2` ALTER COLUMN `lob_code` SET TAGS ('pii_value_regex' = 'commercial|medicare_advantage|medicaid|marketplace|dsnp|fehb');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_lifecycle_event2` ALTER COLUMN `lob_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_lifecycle_event2` ALTER COLUMN `master_entity_reference` SET TAGS ('pii_business_glossary_term' = 'Master Entity Id');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_lifecycle_event2` ALTER COLUMN `new_contract_status` SET TAGS ('pii_business_glossary_term' = 'New Contract Status');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_lifecycle_event2` ALTER COLUMN `new_effective_date` SET TAGS ('pii_business_glossary_term' = 'New Contract Effective Date');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_lifecycle_event2` ALTER COLUMN `new_expiration_date` SET TAGS ('pii_business_glossary_term' = 'New Contract Expiration Date');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_lifecycle_event2` ALTER COLUMN `notice_period_days` SET TAGS ('pii_business_glossary_term' = 'Required Notice Period Days');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_lifecycle_event2` ALTER COLUMN `notice_sent_date` SET TAGS ('pii_business_glossary_term' = 'Notice Sent Date');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_lifecycle_event2` ALTER COLUMN `notice_sent_flag` SET TAGS ('pii_business_glossary_term' = 'Notice Sent Flag');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_lifecycle_event2` ALTER COLUMN `prior_contract_status` SET TAGS ('pii_business_glossary_term' = 'Prior Contract Status');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_lifecycle_event2` ALTER COLUMN `provider_relations_case_ref` SET TAGS ('pii_business_glossary_term' = 'Provider Relations Case Reference');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_lifecycle_event2` ALTER COLUMN `rate_change_pct` SET TAGS ('pii_business_glossary_term' = 'Rate Change Percentage');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_lifecycle_event2` ALTER COLUMN `rate_change_pct` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_lifecycle_event2` ALTER COLUMN `record_created_at` SET TAGS ('pii_business_glossary_term' = 'Record Created At');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_lifecycle_event2` ALTER COLUMN `record_source_system` SET TAGS ('pii_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_lifecycle_event2` ALTER COLUMN `record_status` SET TAGS ('pii_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_lifecycle_event2` ALTER COLUMN `record_status` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_lifecycle_event2` ALTER COLUMN `record_updated_at` SET TAGS ('pii_business_glossary_term' = 'Record Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_lifecycle_event2` ALTER COLUMN `record_version` SET TAGS ('pii_business_glossary_term' = 'Record Version');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_lifecycle_event2` ALTER COLUMN `regulatory_mandate_flag` SET TAGS ('pii_business_glossary_term' = 'Regulatory Mandate Flag');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_lifecycle_event2` ALTER COLUMN `regulatory_reference` SET TAGS ('pii_business_glossary_term' = 'Regulatory Reference');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_lifecycle_event2` ALTER COLUMN `renewal_type` SET TAGS ('pii_business_glossary_term' = 'Contract Renewal Type');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_lifecycle_event2` ALTER COLUMN `renewal_type` SET TAGS ('pii_value_regex' = 'auto|renegotiated|evergreen|manual');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_lifecycle_event2` ALTER COLUMN `resolution_date` SET TAGS ('pii_business_glossary_term' = 'Dispute Resolution Date');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_lifecycle_event2` ALTER COLUMN `resolution_outcome` SET TAGS ('pii_business_glossary_term' = 'Dispute Resolution Outcome');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_lifecycle_event2` ALTER COLUMN `resolution_outcome` SET TAGS ('pii_value_regex' = 'resolved_in_plan_favor|resolved_in_provider_favor|mutual_agreement|arbitration_award|withdrawn|no_action');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_lifecycle_event2` ALTER COLUMN `retroactive_flag` SET TAGS ('pii_business_glossary_term' = 'Retroactive Event Flag');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_lifecycle_event2` ALTER COLUMN `source_event_reference` SET TAGS ('pii_business_glossary_term' = 'Source System Event ID');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_lifecycle_event2` ALTER COLUMN `triggered_by_type` SET TAGS ('pii_business_glossary_term' = 'Event Triggered By Type');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_lifecycle_event2` ALTER COLUMN `triggered_by_type` SET TAGS ('pii_value_regex' = 'user|system|scheduler|external_party|regulatory_mandate');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_lifecycle_event2` ALTER COLUMN `triggered_by_user` SET TAGS ('pii_business_glossary_term' = 'Event Triggered By User');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_lifecycle_event2` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_lifecycle_event2` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`audit` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`audit` SET TAGS ('pii_subdomain' = 'obligation_compliance');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`audit` SET TAGS ('pii_fhir_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`audit` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`audit` SET TAGS ('pii_fhir_resource' = 'Basic');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`audit` SET TAGS ('pii_ecm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`audit` SET TAGS ('pii_ssot' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`audit` SET TAGS ('pii_fhir_interop' = 'ready');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`audit` SET TAGS ('pii_authority_source' = 'verbatim_reviewer_comments_working_group_sheet');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`audit` ALTER COLUMN `audit_id` SET TAGS ('pii_business_glossary_term' = 'Audit Identifier (ID)');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`audit` ALTER COLUMN `employee_id` SET TAGS ('pii_business_glossary_term' = 'Auditor Employee Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`audit` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`audit` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`audit` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('pii_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`audit` ALTER COLUMN `provider_contract_id` SET TAGS ('pii_business_glossary_term' = 'Contract Identifier (ID)');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`audit` ALTER COLUMN `provider_id` SET TAGS ('pii_business_glossary_term' = 'Provider Identifier (ID)');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`audit` ALTER COLUMN `actual_completion_date` SET TAGS ('pii_business_glossary_term' = 'Actual Completion Date');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`audit` ALTER COLUMN `actual_start_date` SET TAGS ('pii_business_glossary_term' = 'Actual Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`audit` ALTER COLUMN `audit_number` SET TAGS ('pii_business_glossary_term' = 'Audit Number');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`audit` ALTER COLUMN `audit_number` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`audit` ALTER COLUMN `audit_status` SET TAGS ('pii_business_glossary_term' = 'Audit Status');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`audit` ALTER COLUMN `audit_status` SET TAGS ('pii_value_regex' = 'scheduled|in-progress|completed|findings-issued|cap-pending|closed');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`audit` ALTER COLUMN `audit_type` SET TAGS ('pii_business_glossary_term' = 'Audit Type');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`audit` ALTER COLUMN `audit_type` SET TAGS ('pii_value_regex' = 'payment-accuracy|credentialing-compliance|delegation-oversight|coding-audit|medical-record-review|rate-validation');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`audit` ALTER COLUMN `auditor_name` SET TAGS ('pii_business_glossary_term' = 'Auditor Name');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`audit` ALTER COLUMN `auditor_type` SET TAGS ('pii_business_glossary_term' = 'Auditor Type');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`audit` ALTER COLUMN `auditor_type` SET TAGS ('pii_value_regex' = 'internal|external|regulatory|third-party');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`audit` ALTER COLUMN `completion_date` SET TAGS ('pii_business_glossary_term' = 'Completion Date');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`audit` ALTER COLUMN `compliance_rating` SET TAGS ('pii_business_glossary_term' = 'Compliance Rating');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`audit` ALTER COLUMN `corrective_action_due_date` SET TAGS ('pii_business_glossary_term' = 'Corrective Action Due Date');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`audit` ALTER COLUMN `corrective_action_plan_due_date` SET TAGS ('pii_business_glossary_term' = 'Corrective Action Plan (CAP) Due Date');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`audit` ALTER COLUMN `corrective_action_plan_received_date` SET TAGS ('pii_business_glossary_term' = 'Corrective Action Plan (CAP) Received Date');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`audit` ALTER COLUMN `corrective_action_plan_required` SET TAGS ('pii_business_glossary_term' = 'Corrective Action Plan (CAP) Required');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`audit` ALTER COLUMN `corrective_action_plan_status` SET TAGS ('pii_business_glossary_term' = 'Corrective Action Plan (CAP) Status');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`audit` ALTER COLUMN `corrective_action_required` SET TAGS ('pii_business_glossary_term' = 'Corrective Action Required');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`audit` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`audit` ALTER COLUMN `created_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`audit` ALTER COLUMN `critical_findings_count` SET TAGS ('pii_business_glossary_term' = 'Critical Findings Count');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`audit` ALTER COLUMN `data_quality_score` SET TAGS ('pii_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`audit` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`audit` ALTER COLUMN `effective_end_date` SET TAGS ('pii_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`audit` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`audit` ALTER COLUMN `effective_start_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`audit` ALTER COLUMN `error_count` SET TAGS ('pii_business_glossary_term' = 'Error Count');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`audit` ALTER COLUMN `error_rate_pct` SET TAGS ('pii_business_glossary_term' = 'Error Rate Percentage (Pct)');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`audit` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`audit` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`audit` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`audit` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`audit` ALTER COLUMN `fhir_resource_reference` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`audit` ALTER COLUMN `fhir_resource_reference` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`audit` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`audit` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`audit` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`audit` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`audit` ALTER COLUMN `financial_recovery_amount` SET TAGS ('pii_business_glossary_term' = 'Financial Recovery Amount');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`audit` ALTER COLUMN `findings_count` SET TAGS ('pii_business_glossary_term' = 'Findings Count');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`audit` ALTER COLUMN `findings_severity` SET TAGS ('pii_business_glossary_term' = 'Findings Severity');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`audit` ALTER COLUMN `findings_severity` SET TAGS ('pii_value_regex' = 'critical|high|medium|low|none');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`audit` ALTER COLUMN `findings_summary` SET TAGS ('pii_business_glossary_term' = 'Findings Summary');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`audit` ALTER COLUMN `frequency` SET TAGS ('pii_business_glossary_term' = 'Audit Frequency');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`audit` ALTER COLUMN `frequency` SET TAGS ('pii_value_regex' = 'annual|semi-annual|quarterly|ad-hoc|risk-based');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`audit` ALTER COLUMN `is_active` SET TAGS ('pii_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`audit` ALTER COLUMN `lob` SET TAGS ('pii_business_glossary_term' = 'Line of Business (LOB)');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`audit` ALTER COLUMN `lob` SET TAGS ('pii_value_regex' = 'commercial|medicare|medicaid|marketplace|dual-eligible');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`audit` ALTER COLUMN `lob_code` SET TAGS ('pii_business_glossary_term' = 'Lob Code');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`audit` ALTER COLUMN `master_entity_reference` SET TAGS ('pii_business_glossary_term' = 'Master Entity Id');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`audit` ALTER COLUMN `methodology` SET TAGS ('pii_business_glossary_term' = 'Audit Methodology');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`audit` ALTER COLUMN `net_payment_variance` SET TAGS ('pii_business_glossary_term' = 'Net Payment Variance');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`audit` ALTER COLUMN `next_scheduled_audit_date` SET TAGS ('pii_business_glossary_term' = 'Next Scheduled Audit Date');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`audit` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Audit Notes');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`audit` ALTER COLUMN `overall_score` SET TAGS ('pii_business_glossary_term' = 'Overall Score');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`audit` ALTER COLUMN `overpayment_amount` SET TAGS ('pii_business_glossary_term' = 'Overpayment Amount');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`audit` ALTER COLUMN `performed_date` SET TAGS ('pii_business_glossary_term' = 'Performed Date');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`audit` ALTER COLUMN `period_end` SET TAGS ('pii_business_glossary_term' = 'Audit Period End');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`audit` ALTER COLUMN `period_end_date` SET TAGS ('pii_business_glossary_term' = 'Audit Period End Date');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`audit` ALTER COLUMN `period_start` SET TAGS ('pii_business_glossary_term' = 'Audit Period Start');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`audit` ALTER COLUMN `period_start_date` SET TAGS ('pii_business_glossary_term' = 'Audit Period Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`audit` ALTER COLUMN `record_created_at` SET TAGS ('pii_business_glossary_term' = 'Record Created At');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`audit` ALTER COLUMN `record_created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`audit` ALTER COLUMN `record_source_system` SET TAGS ('pii_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`audit` ALTER COLUMN `record_status` SET TAGS ('pii_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`audit` ALTER COLUMN `record_status` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`audit` ALTER COLUMN `record_updated_at` SET TAGS ('pii_business_glossary_term' = 'Record Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`audit` ALTER COLUMN `record_updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`audit` ALTER COLUMN `record_version` SET TAGS ('pii_business_glossary_term' = 'Record Version');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`audit` ALTER COLUMN `regulatory_mandate_flag` SET TAGS ('pii_business_glossary_term' = 'Regulatory Mandate Flag');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`audit` ALTER COLUMN `regulatory_reference` SET TAGS ('pii_business_glossary_term' = 'Regulatory Reference');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`audit` ALTER COLUMN `report_document_reference` SET TAGS ('pii_business_glossary_term' = 'Audit Report Document Reference');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`audit` ALTER COLUMN `report_reference` SET TAGS ('pii_business_glossary_term' = 'Report Reference');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`audit` ALTER COLUMN `sample_size` SET TAGS ('pii_business_glossary_term' = 'Sample Size');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`audit` ALTER COLUMN `scheduled_completion_date` SET TAGS ('pii_business_glossary_term' = 'Scheduled Completion Date');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`audit` ALTER COLUMN `scheduled_date` SET TAGS ('pii_business_glossary_term' = 'Scheduled Date');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`audit` ALTER COLUMN `scheduled_start_date` SET TAGS ('pii_business_glossary_term' = 'Scheduled Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`audit` ALTER COLUMN `scope` SET TAGS ('pii_business_glossary_term' = 'Audit Scope');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`audit` ALTER COLUMN `siu_referral_date` SET TAGS ('pii_business_glossary_term' = 'Special Investigations Unit (SIU) Referral Date');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`audit` ALTER COLUMN `siu_referral_flag` SET TAGS ('pii_business_glossary_term' = 'Special Investigations Unit (SIU) Referral Flag');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`audit` ALTER COLUMN `source_system_code` SET TAGS ('pii_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`audit` ALTER COLUMN `summary_notes` SET TAGS ('pii_business_glossary_term' = 'Summary Notes');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`audit` ALTER COLUMN `underpayment_amount` SET TAGS ('pii_business_glossary_term' = 'Underpayment Amount');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`audit` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`audit` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_lifecycle_event` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_lifecycle_event` SET TAGS ('pii_subdomain' = 'lifecycle_tracking');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_lifecycle_event` ALTER COLUMN `contract_lifecycle_event_id` SET TAGS ('pii_business_glossary_term' = 'contract_lifecycle_event Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_lifecycle_event` ALTER COLUMN `event_type_code` SET TAGS ('pii_constraint_scope' = 'contract_events');
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_lifecycle_event` ALTER COLUMN `event_type_code` SET TAGS ('pii_domain_separation' = 'true');
