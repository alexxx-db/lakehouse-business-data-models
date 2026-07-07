-- Schema for Domain: appeal | Business: Health_Insurance | Version: v2_mvm
-- Generated on: 2026-06-27 10:42:56

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_health_insurance_v1`.`appeal` COMMENT 'Manages member and provider appeals and grievances including claim denials, coverage disputes, utilization management appeals, external review requests, and state fair hearing processes. Tracks appeal status, resolution timelines, overturn rates, and compliance with state and federal appeal rights (ACA, ERISA). Distinct from compliance (which owns regulatory audit and reporting) and utilization (which owns initial authorization decisions).';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`appeal`.`case` (
    `case_id` BIGINT COMMENT 'Primary key for the appeal case.',
    `account_id` BIGINT COMMENT 'Foreign key linking to billing.account. Business justification: Group/employer billing appeals: employer groups or brokers file appeals on behalf of accounts disputing billing arrangements, payment terms, or account-level premium calculations. Links the appeal cas',
    `adequacy_assessment_id` BIGINT COMMENT 'Foreign key linking to network.adequacy_assessment. Business justification: Regulatory requirement: when a member appeals due to inability to access an in-network provider, the network adequacy assessment is the evidentiary basis. CMS and state regulators require tracking of ',
    `adjudication_id` BIGINT COMMENT 'Foreign key linking to claim.adjudication. Business justification: An appeal case contests a specific adjudication decision. Appeals staff need direct access to the adjudication record (edit codes, auto-adjudication flags, override authority) to assess the basis of t',
    `adverse_determination_id` BIGINT COMMENT 'Foreign key linking to appeal.adverse_determination. Business justification: An appeal case is fundamentally triggered by an adverse determination (denial, reduction, or termination of benefits). Adding adverse_determination_id to case establishes the direct causal link betwee',
    `aptc_subsidy_id` BIGINT COMMENT 'Foreign key linking to billing.aptc_subsidy. Business justification: APTC subsidy appeals: marketplace members appeal subsidy amount determinations, CMS reconciliation adjustments, or subsidy terminations. The case must link to the specific APTC subsidy record for ACA ',
    `benefit_package_id` BIGINT COMMENT 'Foreign key linking to plan.benefit_package. Business justification: Appeal cases are filed against coverage denials under a specific benefit package. Benefit-package-level appeal volume reporting, SLA management by package tier, and regulatory grievance tracking all r',
    `header_id` BIGINT COMMENT 'FK to the related claim header.',
    `line_id` BIGINT COMMENT 'Foreign key linking to claim.line. Business justification: Appeals are frequently filed at the claim line level (e.g., a single denied procedure line). The appeal case management system must track which specific line is contested to apply correct benefit rule',
    `denial_id` BIGINT COMMENT 'Foreign key linking to claim.denial. Business justification: Appeals are filed against specific denials. The appeal case management workflow requires knowing exactly which denial triggered the case — not just which claim header — to apply correct appeal rights,',
    `disenrollment_id` BIGINT COMMENT 'Foreign key linking to member.disenrollment. Business justification: Members have a regulatory right to appeal disenrollment decisions (CMS, state DOI requirements). Disenrollment appeal tracking is a named compliance process. Linking case to the specific disenrollme',
    `eligibility_span_id` BIGINT COMMENT 'Foreign key linking to member.member_eligibility_span. Business justification: Eligibility span disputes (retroactive terminations, gap periods) are a high-volume appeal type. Eligibility span appeal adjudication is a named operational and regulatory process. Linking case dire',
    `facility_id` BIGINT COMMENT 'Foreign key linking to provider.facility. Business justification: Facility-level appeal volume and denial rate reporting is a core network performance operation. Health plans track which facilities generate high appeal rates for contract renegotiation and network ad',
    `grace_period_id` BIGINT COMMENT 'Foreign key linking to billing.grace_period. Business justification: Coverage termination appeals: when a grace period expires and coverage is terminated, members file appeals. The case must reference the grace period record to evaluate reinstatement eligibility and re',
    `health_plan_id` BIGINT COMMENT 'FK to the health plan.',
    `lob_assignment_id` BIGINT COMMENT 'Foreign key linking to member.lob_assignment. Business justification: Members appeal line-of-business classifications (SNP eligibility, dual-eligible status, Medicaid/Medicare assignment). LOB assignment appeal is a named CMS and state regulatory process. Linking case',
    `identity_id` BIGINT COMMENT 'FK to the member identity.',
    `par_agreement_id` BIGINT COMMENT 'Foreign key linking to network.par_agreement. Business justification: Appeals frequently arise from PAR agreement disputes — providers claiming contracted in-network rates were incorrectly denied. Linking case to par_agreement enables contract-specific appeal tracking, ',
    `participation_status_id` BIGINT COMMENT 'Foreign key linking to provider.participation_status. Business justification: Network status appeals require direct lookup of the providers contracted participation status at appeal filing. Adjudicators must validate in-network vs. out-of-network status to resolve the dispute.',
    `pcp_assignment_id` BIGINT COMMENT 'Foreign key linking to member.pcp_assignment. Business justification: Members can appeal PCP assignment decisions (panel closures, forced reassignments). PCP assignment appeal is a real health plan operational process tracked by member services and network operations.',
    `plan_election_id` BIGINT COMMENT 'FK to the enrollment plan election.',
    `policy_id` BIGINT COMMENT 'Foreign key linking to member.policy. Business justification: Appeal adjudication requires direct access to the specific policys coverage terms, deductible, and out-of-pocket limits. Adjudicators and compliance teams run appeal adjudication against policy cove',
    `premium_invoice_id` BIGINT COMMENT 'Foreign key linking to billing.premium_invoice. Business justification: Premium billing appeals process: members file appeals disputing invoice amounts, retroactive adjustments, or subsidy calculations. The appeal case must reference the specific invoice under dispute for',
    `premium_rate_id` BIGINT COMMENT 'Foreign key linking to billing.premium_rate. Business justification: Premium rate appeals: members dispute assigned premium rates (incorrect age band, tobacco surcharge, rating area). The case must reference the specific rate record to evaluate the rate appeal, support',
    `provider_id` BIGINT COMMENT 'FK to the provider.',
    `provider_network_id` BIGINT COMMENT 'FK to the provider network.',
    `qualifying_life_event_id` BIGINT COMMENT 'Foreign key linking to enrollment.qualifying_life_event. Business justification: CMS SEP denial appeals: members appeal QLE/SEP denials as a named regulatory process. qualifying_life_event has appeal_reference and cms_sep_outcome confirming this relationship. Appeal cases must',
    `tier_id` BIGINT COMMENT 'Foreign key linking to network.tier. Business justification: Tier assignment disputes are a named appeal type in tiered network plans — members appeal higher cost-share when they believe a provider should be in a preferred tier. Linking case to tier enables tie',
    `transaction_id` BIGINT COMMENT 'Foreign key linking to enrollment.transaction. Business justification: Enrollment dispute resolution: appeal cases triggered by retroactive enrollment transactions (terminations, adjustments) require direct traceability to the enrollment transaction. Compliance and opera',
    `appeal_assigned_to` STRING COMMENT 'Name or ID of the person assigned to the appeal.',
    `appeal_escalation_flag` BOOLEAN COMMENT 'Indicates if the appeal has been escalated.',
    `appeal_number` STRING COMMENT 'Unique appeal case number.',
    `appeal_priority` STRING COMMENT 'Priority level of the appeal case.',
    `appeal_review_cycle_days` STRING COMMENT 'Number of days in the review cycle.',
    `appeal_status` STRING COMMENT 'Current status of the appeal case.',
    `appeal_type` STRING COMMENT 'Type of appeal (e.g., pre-service, post-service).',
    `clinical_criteria_applied` STRING COMMENT 'Clinical criteria applied in the appeal review.',
    `completeness_determination` STRING COMMENT 'Determination of case completeness.',
    `complexity_score` DECIMAL(18,2) COMMENT '',
    `decision_author_npi` STRING COMMENT 'NPI of the decision author.',
    `decision_rationale` STRING COMMENT 'Rationale for the appeal decision.',
    `decision_timestamp` TIMESTAMP COMMENT 'Timestamp of the appeal decision.',
    `decision_type` STRING COMMENT 'Type of decision rendered.',
    `effective_benefit_change_date` DATE COMMENT 'Date when benefit changes take effect.',
    `expedited_clinical_urgency_basis` STRING COMMENT 'Clinical basis for expedited processing.',
    `expedited_trigger` BOOLEAN COMMENT 'Whether the case triggered expedited processing.',
    `filing_channel` STRING COMMENT 'Channel through which the appeal was filed.',
    `filing_method` STRING COMMENT 'Method used to file the appeal.',
    `filing_party_type` STRING COMMENT 'Type of party filing the appeal.',
    `filing_timestamp` TIMESTAMP COMMENT 'Timestamp when the appeal was filed.',
    `line_of_business` STRING COMMENT 'Line of business for the appeal.',
    `member_notification_date` DATE COMMENT 'Date the member was notified.',
    `original_claim_number` STRING COMMENT 'Original claim number related to the appeal.',
    `overturn_reason` STRING COMMENT 'Reason for overturning the original decision.',
    `priority_level_code` STRING COMMENT '',
    `provider_notification_date` DATE COMMENT 'Date the provider was notified.',
    `record_created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'Record last updated timestamp.',
    `regulatory_tier` STRING COMMENT 'Regulatory tier classification.',
    `sla_breach_flag` BOOLEAN COMMENT '',
    `supporting_documentation_checklist` STRING COMMENT 'Checklist of supporting documentation received.',
    CONSTRAINT pk_case PRIMARY KEY(`case_id`)
) COMMENT 'Represents an appeal case encompassing all related reviews, documents, communications, and decisions.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`appeal`.`adverse_determination` (
    `adverse_determination_id` BIGINT COMMENT 'Primary key for the adverse determination.',
    `aptc_subsidy_id` BIGINT COMMENT 'Foreign key linking to billing.aptc_subsidy. Business justification: APTC subsidy adverse determinations: ACA marketplace adverse determinations include subsidy denial or reduction decisions. Linking adverse_determination to aptc_subsidy supports CMS regulatory reporti',
    `benefit_id` BIGINT COMMENT 'Foreign key linking to plan.benefit. Business justification: Adverse determinations deny coverage of a specific benefit (e.g., inpatient stay, DME). Linking to plan.benefit enables benefit-level denial analytics, clinical criteria validation against benefit des',
    `header_id` BIGINT COMMENT 'FK to the claim header.',
    `line_id` BIGINT COMMENT 'Foreign key linking to claim.line. Business justification: Adverse determinations are issued at the service line level in UM and claims adjudication. Linking to the specific claim line enables precise financial impact calculation, line-level reversal processi',
    `condition_registry_id` BIGINT COMMENT 'Foreign key linking to care.condition_registry. Business justification: Adverse determinations are clinically grounded in specific member conditions. Linking to condition_registry replaces the denormalized diagnosis_code with the full condition record (HCC mapping, severi',
    `drug_master_id` BIGINT COMMENT 'Foreign key linking to pharmacy.drug_master. Business justification: CMS Part D and state regulatory reporting require identifying the specific drug denied in each adverse determination. Drug-level denial analytics, formulary compliance audits, and HEDIS reporting depe',
    `health_plan_id` BIGINT COMMENT 'Foreign key linking to plan.health_plan. Business justification: Adverse determinations are always issued under a specific health plans coverage terms. Plan-level denial reporting, regulatory audits (ACA, ERISA), and MLR calculations require direct attribution of ',
    `identity_id` BIGINT COMMENT 'FK to the member identity.',
    `pa_decision_id` BIGINT COMMENT 'Foreign key linking to utilization.pa_decision. Business justification: Adverse determinations are the formal denial output of PA decisions. Compliance teams and appeals staff must trace each adverse_determination to the specific pa_decision (clinical_rationale, denial_re',
    `pa_request_id` BIGINT COMMENT 'FK to the utilization PA request.',
    `par_agreement_id` BIGINT COMMENT 'Foreign key linking to network.par_agreement. Business justification: Adverse determinations based on network-status denials require validation against the specific PAR agreement in force at the date of service. This supports denial reason substantiation and provider di',
    `participation_status_id` BIGINT COMMENT 'Foreign key linking to provider.participation_status. Business justification: Regulatory denial notices (ACA, state mandates) require documented provider network status at time of service. The existing network_status plain-text field is denormalized from provider.participation_',
    `plan_election_id` BIGINT COMMENT 'Foreign key linking to enrollment.plan_election. Business justification: Benefit adjudication: adverse determinations (coverage denials, benefit limitations) are issued against a specific plan election. Linking enables benefit denial tracking by plan election, required for',
    `care_plan_id` BIGINT COMMENT 'Foreign key linking to care.care_plan. Business justification: Adverse determinations issued against care plan services (e.g., denial of care management interventions) must reference the affected care plan. Clinical reviewers and UM staff require this link to eva',
    `policy_id` BIGINT COMMENT 'Foreign key linking to member.policy. Business justification: Adverse determinations (denials) must reference the exact policy under which coverage was denied. Adverse determination policy coverage validation is a named regulatory process (ERISA, ACA). No exis',
    `procedure_id` BIGINT COMMENT 'Foreign key linking to claim.procedure. Business justification: Adverse determinations are procedure-specific (medical necessity denials reference exact CPT/HCPCS codes). Linking to claim.procedure replaces the denormalized service_code column and enables UM revie',
    `provider_assignment_id` BIGINT COMMENT 'Foreign key linking to network.provider_assignment. Business justification: Adverse determinations for out-of-network denials require validation against the specific provider_assignment record to confirm the providers network participation status at the date of service — a s',
    `provider_id` BIGINT COMMENT 'FK to the provider.',
    `provider_network_id` BIGINT COMMENT 'Foreign key linking to network.provider_network. Business justification: Adverse determinations for out-of-network denials require direct reference to the provider_network to support denial reason reporting, regulatory audits, and network-status-based denial analytics. ne',
    `appeal_deadline_date` DATE COMMENT 'Deadline for filing an appeal.',
    `appeal_eligibility_flag` BOOLEAN COMMENT 'Whether the determination is eligible for appeal.',
    `appeal_filed_date` DATE COMMENT 'Date an appeal was filed.',
    `appeal_outcome` STRING COMMENT 'Outcome of the appeal if filed.',
    `appeal_resolution_date` DATE COMMENT 'Date the appeal was resolved.',
    `appeal_status` STRING COMMENT 'Current appeal status.',
    `basis_of_denial` STRING COMMENT 'Basis for the denial decision.',
    `clinical_criteria_version` STRING COMMENT 'Version of clinical criteria used.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp.',
    `currency_code` STRING COMMENT 'Currency code for monetary amounts.',
    `denial_reason_code` STRING COMMENT 'Code for the denial reason.',
    `denial_reason_description` STRING COMMENT 'Description of the denial reason.',
    `determination_date` TIMESTAMP COMMENT 'Date/time the determination was made.',
    `determination_number` STRING COMMENT 'Unique determination tracking number.',
    `determination_status` STRING COMMENT 'Current status of the determination.',
    `determination_type` STRING COMMENT 'Type of adverse determination.',
    `effective_date` DATE COMMENT 'Effective date of the determination.',
    `monetary_amount_adjusted` DECIMAL(18,2) COMMENT 'Amount adjusted as a result of the determination.',
    `monetary_amount_denied` DECIMAL(18,2) COMMENT 'Amount denied.',
    `notes` STRING COMMENT 'Additional notes.',
    `prior_authorization_required_flag` BOOLEAN COMMENT 'Whether prior authorization was required.',
    `reviewer_name` STRING COMMENT 'Name of the reviewer.',
    `reviewer_npi` STRING COMMENT 'NPI of the reviewer.',
    `service_date` DATE COMMENT 'Date of service.',
    `updated_timestamp` TIMESTAMP COMMENT 'Record last updated timestamp.',
    CONSTRAINT pk_adverse_determination PRIMARY KEY(`adverse_determination_id`)
) COMMENT 'Records adverse benefit determinations that may be subject to appeal, including denials and reductions.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`appeal`.`review` (
    `review_id` BIGINT COMMENT 'Primary key for the review.',
    `adverse_determination_id` BIGINT COMMENT 'Foreign key linking to appeal.adverse_determination. Business justification: An internal review is conducted specifically to evaluate a particular adverse determination. While review already links to case via case_id, a case may involve multiple adverse determinations (e.g., m',
    `case_id` BIGINT COMMENT 'FK to the appeal case.',
    `pa_decision_id` BIGINT COMMENT 'Foreign key linking to utilization.pa_decision. Business justification: Appeal reviewers evaluate the clinical rationale of the original PA decision (criteria_met_flag, denial_reason_category, reviewer_credentials). A direct FK enables clinical review workflows without mu',
    `appeal_case_number` STRING COMMENT 'Appeal case number reference.',
    `appeal_reason_code` STRING COMMENT 'Reason code for the appeal.',
    `appeal_status_at_review` STRING COMMENT 'Status of the appeal at time of review.',
    `appeal_submission_date` DATE COMMENT 'Date the appeal was submitted.',
    `clinical_rationale` STRING COMMENT 'Clinical rationale for the review decision.',
    `compliance_flag` STRING COMMENT 'Compliance status flag.',
    `cpt_codes_reviewed` STRING COMMENT 'CPT codes reviewed during the appeal.',
    `criteria_version` STRING COMMENT 'Version of criteria applied.',
    `drg_code` STRING COMMENT 'DRG code if applicable.',
    `duration_minutes` STRING COMMENT 'Duration of the review in minutes.',
    `icd_codes_reviewed` STRING COMMENT 'ICD codes reviewed.',
    `is_independent_reviewer` BOOLEAN COMMENT 'Whether the reviewer is independent.',
    `location` STRING COMMENT 'Location where review was conducted.',
    `notes` STRING COMMENT 'Review notes.',
    `outcome` STRING COMMENT 'Outcome of the review.',
    `record_audit_created` TIMESTAMP COMMENT 'Audit creation timestamp.',
    `record_audit_updated` TIMESTAMP COMMENT 'Audit update timestamp.',
    `review_number` STRING COMMENT 'Unique review tracking number.',
    `review_status` STRING COMMENT 'Current status of the review.',
    `review_timestamp` TIMESTAMP COMMENT 'Timestamp of the review.',
    `review_type` STRING COMMENT 'Type of review conducted.',
    `reviewer_npi` STRING COMMENT 'NPI of the reviewer.',
    `reviewer_specialty` STRING COMMENT 'Specialty of the reviewer.',
    `reviewer_type` STRING COMMENT 'Type of reviewer.',
    CONSTRAINT pk_review PRIMARY KEY(`review_id`)
) COMMENT 'Records internal reviews conducted as part of the appeal process by clinical or administrative reviewers.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`appeal`.`external_review` (
    `external_review_id` BIGINT COMMENT 'Primary key for the external review.',
    `adverse_determination_id` BIGINT COMMENT 'Foreign key linking to appeal.adverse_determination. Business justification: An external independent review (IRO review) is initiated when internal appeals of a specific adverse determination are exhausted or when expedited external review is warranted. The external_review sho',
    `case_id` BIGINT COMMENT 'FK to the appeal case.',
    `header_id` BIGINT COMMENT 'FK to the claim header.',
    `drug_master_id` BIGINT COMMENT 'Foreign key linking to pharmacy.drug_master. Business justification: IRO external reviews of pharmacy benefit denials (specialty drugs, non-formulary drugs) require identifying the specific drug under review for URAC/NCQA accreditation reporting and state external revi',
    `health_plan_id` BIGINT COMMENT 'Foreign key linking to plan.health_plan. Business justification: External reviews are conducted under specific plan regulatory requirements (state IRO laws, ERISA). State regulatory reporting of external review outcomes requires direct plan attribution. IRO assignm',
    `iro_organization_id` BIGINT COMMENT 'FK to the IRO organization.',
    `subscriber_id` BIGINT COMMENT 'FK to the member subscriber.',
    `provider_id` BIGINT COMMENT 'FK to the provider.',
    `adjustment_amount` DECIMAL(18,2) COMMENT 'Financial adjustment amount.',
    `appeal_reason_code` STRING COMMENT 'Reason code for the appeal.',
    `appeal_reason_description` STRING COMMENT 'Description of the appeal reason.',
    `binding_determination_flag` BOOLEAN COMMENT 'Whether the determination is binding.',
    `claim_amount` DECIMAL(18,2) COMMENT 'Original claim amount.',
    `compliance_action_taken` STRING COMMENT 'Compliance action taken.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp.',
    `currency_code` STRING COMMENT 'Currency code.',
    `deadline_date` DATE COMMENT 'Deadline for the external review.',
    `decision` STRING COMMENT 'Decision of the external review.',
    `decision_date` DATE COMMENT 'Date of the decision.',
    `decision_rationale` STRING COMMENT 'Rationale for the decision.',
    `diagnosis_code` STRING COMMENT 'Related diagnosis code.',
    `external_review_status` STRING COMMENT 'Current status of the external review.',
    `external_review_type` STRING COMMENT 'Type of external review.',
    `iro_accreditation_status` STRING COMMENT 'Accreditation status of the IRO.',
    `is_urgent` BOOLEAN COMMENT 'Whether the review is urgent.',
    `last_status_change_timestamp` TIMESTAMP COMMENT 'Timestamp of last status change.',
    `net_amount` DECIMAL(18,2) COMMENT 'Net financial amount.',
    `notes` STRING COMMENT 'Additional notes.',
    `overdue_flag` BOOLEAN COMMENT 'Whether the review is overdue.',
    `patient_relationship` STRING COMMENT 'Patient relationship to subscriber.',
    `procedure_code` STRING COMMENT 'Related procedure code.',
    `regulatory_reporting_flag` BOOLEAN COMMENT 'Whether regulatory reporting is required.',
    `reporting_status` STRING COMMENT 'Status of regulatory reporting.',
    `reporting_submission_date` DATE COMMENT 'Date of regulatory submission.',
    `request_timestamp` TIMESTAMP COMMENT 'Timestamp of the review request.',
    `review_category` STRING COMMENT 'Category of the review.',
    `review_number` STRING COMMENT 'Unique review tracking number.',
    `review_priority` STRING COMMENT 'Priority of the review.',
    `service_date` DATE COMMENT 'Date of service.',
    `source` STRING COMMENT 'Source of the external review.',
    `state` STRING COMMENT 'State jurisdiction.',
    `transmission_date` DATE COMMENT 'Date of transmission to IRO.',
    `updated_timestamp` TIMESTAMP COMMENT 'Record last updated timestamp.',
    CONSTRAINT pk_external_review PRIMARY KEY(`external_review_id`)
) COMMENT 'Records external independent reviews conducted by IROs when internal appeals are exhausted or expedited.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`appeal`.`timeline` (
    `timeline_id` BIGINT COMMENT 'Primary key for the timeline record.',
    `case_id` BIGINT COMMENT 'FK to the appeal case.',
    `identity_id` BIGINT COMMENT 'FK to the member identity.',
    `acknowledgment_due_date` DATE COMMENT 'Due date for acknowledgment.',
    `actual_acknowledgment_date` DATE COMMENT 'Actual date of acknowledgment.',
    `actual_decision_date` DATE COMMENT 'Actual date of decision.',
    `actual_expedited_date` DATE COMMENT 'Actual expedited processing date.',
    `actual_extension_date` DATE COMMENT 'Actual extension date.',
    `appeal_category` STRING COMMENT 'Category of the appeal.',
    `appeal_filed_timestamp` TIMESTAMP COMMENT 'Timestamp when appeal was filed.',
    `appeal_origin` STRING COMMENT 'Origin of the appeal.',
    `appeal_status` STRING COMMENT 'Current appeal status.',
    `breach_flag` BOOLEAN COMMENT 'Whether an SLA breach occurred.',
    `breach_reason` STRING COMMENT 'Reason for the breach.',
    `clock_start_event` STRING COMMENT 'Event that started the compliance clock.',
    `clock_type` STRING COMMENT 'Type of compliance clock.',
    `compliance_status` STRING COMMENT 'Current compliance status.',
    `corrective_action` STRING COMMENT 'Corrective action taken.',
    `days_overdue` STRING COMMENT 'Number of days overdue.',
    `decision_due_date` DATE COMMENT 'Due date for decision.',
    `expedited_due_date` DATE COMMENT 'Due date for expedited processing.',
    `extension_notification_date` DATE COMMENT 'Date extension notification was sent.',
    `extension_reason` STRING COMMENT 'Reason for the extension.',
    `jurisdiction_state` STRING COMMENT 'State jurisdiction.',
    `last_action_timestamp` TIMESTAMP COMMENT 'Timestamp of last action.',
    `notes` STRING COMMENT 'Additional notes.',
    `priority` STRING COMMENT 'Priority level.',
    `record_audit_created` TIMESTAMP COMMENT 'Audit creation timestamp.',
    `record_audit_updated` TIMESTAMP COMMENT 'Audit update timestamp.',
    `record_version` STRING COMMENT 'Version number of the record.',
    `regulatory_body` STRING COMMENT 'Regulatory body governing the timeline.',
    `root_cause_category` STRING COMMENT 'Root cause category for breaches.',
    `self_report_flag` BOOLEAN COMMENT 'Whether self-reported.',
    `sla_actual_days` STRING COMMENT 'Actual days taken.',
    `sla_breach` BOOLEAN COMMENT 'Whether SLA was breached.',
    `sla_target_days` STRING COMMENT 'Target SLA days.',
    `source_system_record_code` STRING COMMENT 'Source system record code.',
    CONSTRAINT pk_timeline PRIMARY KEY(`timeline_id`)
) COMMENT 'Tracks regulatory timelines and SLA compliance for appeal cases including deadlines and breach events.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`appeal`.`coverage_dispute` (
    `coverage_dispute_id` BIGINT COMMENT 'Primary key for the coverage dispute.',
    `adverse_determination_id` BIGINT COMMENT 'add column adverse_determination_id (BIGINT) with FK to appeal.adverse_determination.adverse_determination_id - coverage disputes follow adverse determinations',
    `aptc_subsidy_id` BIGINT COMMENT 'Foreign key linking to billing.aptc_subsidy. Business justification: APTC coverage disputes: a primary driver of coverage disputes is disagreement over APTC subsidy amounts or eligibility. Linking coverage_dispute to aptc_subsidy supports ACA marketplace regulatory rep',
    `benefit_id` BIGINT COMMENT 'Foreign key linking to plan.benefit. Business justification: coverage_dispute.disputed_benefit_code is a denormalized reference to plan.benefit. Normalizing via FK enables benefit-level dispute analytics, formulary exception tracking, and regulatory reporting o',
    `benefit_package_id` BIGINT COMMENT 'Foreign key linking to plan.benefit_package. Business justification: Coverage disputes arise from specific benefit package terms (COB rules, network designation, OOP maximums). Direct link to benefit_package supports package-level dispute resolution reporting, regulato',
    `case_id` BIGINT COMMENT 'FK to the appeal case.',
    `header_id` BIGINT COMMENT 'FK to the claim header.',
    `cob_id` BIGINT COMMENT 'Foreign key linking to claim.cob. Business justification: Coverage disputes are directly triggered by COB records — a specific COB determination (primary payer order, MSP indicator) is what members and providers dispute. Linking coverage_dispute to the origi',
    `cost_share_rule_id` BIGINT COMMENT 'Foreign key linking to plan.cost_share_rule. Business justification: Coverage disputes frequently arise from specific cost-sharing rule application (deductible aggregation, coinsurance disputes, OOP max calculations). coverage_dispute.cob_rule_applied is a denormalizat',
    `formulary_id` BIGINT COMMENT 'Foreign key linking to pharmacy.formulary. Business justification: Coverage disputes involving formulary placement, non-formulary drug denials, or tier assignment require direct reference to the applicable formulary. CMS Part D coverage determination regulations and ',
    `grace_period_id` BIGINT COMMENT 'Foreign key linking to billing.grace_period. Business justification: Grace period coverage disputes: members dispute coverage terminations resulting from grace period expiration. Linking coverage_dispute to grace_period enables evaluation of reinstatement eligibility a',
    `health_plan_id` BIGINT COMMENT 'FK to the health plan.',
    `invoice_line_id` BIGINT COMMENT 'Foreign key linking to billing.invoice_line. Business justification: Itemized billing disputes: members dispute specific invoice line items (e.g., a specific coverage tier charge, CSR adjustment, or employer contribution line). Linking to invoice_line enables granular ',
    `subscriber_id` BIGINT COMMENT 'FK to the member subscriber.',
    `open_enrollment_period_id` BIGINT COMMENT 'Foreign key linking to enrollment.open_enrollment_period. Business justification: OEP eligibility disputes: members dispute whether they were permitted to enroll or change coverage during a specific open enrollment period. Dispute resolution requires referencing the OEP record to v',
    `pa_decision_id` BIGINT COMMENT 'Foreign key linking to utilization.pa_decision. Business justification: Coverage disputes triggered by PA denials require dispute analysts to access the original pa_decisions clinical rationale, authorization details, and denial reason. No existing path from coverage_dis',
    `par_agreement_id` BIGINT COMMENT 'Foreign key linking to network.par_agreement. Business justification: Coverage disputes about in-network billing rates directly reference the PAR agreement governing reimbursement terms. Resolving whether contracted rates apply requires the specific PAR agreement record',
    `participation_status_id` BIGINT COMMENT 'Foreign key linking to provider.participation_status. Business justification: Coverage disputes are fundamentally about provider network participation status. The existing network_status plain-text field is a denormalized representation of provider.participation_status. Normali',
    `policy_id` BIGINT COMMENT 'Foreign key linking to member.policy. Business justification: Coverage disputes are fundamentally about specific policy terms (benefits, exclusions, COB rules). Coverage dispute resolution requires direct policy reference for adjudicators. coverage_dispute has',
    `premium_invoice_id` BIGINT COMMENT 'Foreign key linking to billing.premium_invoice. Business justification: Billing coverage disputes: coverage disputes frequently arise from premium invoice discrepancies (retroactive adjustments, incorrect billing periods). Linking coverage_dispute to the specific invoice ',
    `premium_rate_id` BIGINT COMMENT 'Foreign key linking to billing.premium_rate. Business justification: Rate-based coverage disputes: members dispute coverage decisions tied to incorrect premium rate assignments (wrong tier, age band, or rating area). Linking to premium_rate supports rate dispute resolu',
    `prior_authorization_id` BIGINT COMMENT 'FK to the pharmacy prior authorization.',
    `provider_id` BIGINT COMMENT 'FK to the provider.',
    `provider_network_id` BIGINT COMMENT 'Foreign key linking to network.provider_network. Business justification: Coverage disputes frequently arise from in-network vs. out-of-network billing disagreements. Direct FK to provider_network enables network-based dispute resolution reporting and regulatory compliance ',
    `qualifying_life_event_id` BIGINT COMMENT 'Foreign key linking to enrollment.qualifying_life_event. Business justification: QLE-based coverage disputes: members dispute coverage changes triggered by a QLE (e.g., disputed marriage/divorce event affecting coverage). Dispute resolution requires referencing the specific QLE re',
    `transaction_id` BIGINT COMMENT 'Foreign key linking to enrollment.transaction. Business justification: Coverage dispute resolution: disputes arise from specific enrollment transactions (retroactive terminations, premium adjustments). Operations teams must link the dispute to the originating enrollment ',
    `appeal_deadline` DATE COMMENT 'Deadline for filing an appeal.',
    `appeal_filed_date` DATE COMMENT 'Date appeal was filed.',
    `appeal_status` STRING COMMENT 'Current appeal status.',
    `cob_order` STRING COMMENT 'Coordination of benefits order.',
    `cob_rule_applied` STRING COMMENT 'COB rule applied.',
    `coordination_amount` DECIMAL(18,2) COMMENT 'Coordination amount.',
    `coverage_dispute_status` STRING COMMENT 'Current status of the coverage dispute.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp.',
    `currency_code` STRING COMMENT 'Currency code.',
    `dispute_description` STRING COMMENT 'Description of the dispute.',
    `dispute_number` STRING COMMENT 'Unique dispute number.',
    `dispute_type` STRING COMMENT 'Type of dispute.',
    `disputing_party_type` STRING COMMENT 'Type of disputing party.',
    `effective_from` DATE COMMENT 'Effective start date.',
    `effective_until` DATE COMMENT 'Effective end date.',
    `formulary_exception_flag` BOOLEAN COMMENT 'Whether a formulary exception is involved.',
    `is_critical` BOOLEAN COMMENT 'Whether the dispute is critical.',
    `notes` STRING COMMENT 'Additional notes.',
    `priority_level` STRING COMMENT 'Priority level.',
    `regulatory_reference` STRING COMMENT 'Regulatory reference.',
    `resolution_date` DATE COMMENT 'Date of resolution.',
    `resolution_outcome` STRING COMMENT 'Outcome of resolution.',
    `subrogation_amount` DECIMAL(18,2) COMMENT 'Subrogation amount.',
    `subrogation_flag` BOOLEAN COMMENT 'Whether subrogation applies.',
    `supporting_document_count` STRING COMMENT 'Number of supporting documents.',
    `updated_timestamp` TIMESTAMP COMMENT 'Record last updated timestamp.',
    CONSTRAINT pk_coverage_dispute PRIMARY KEY(`coverage_dispute_id`)
) COMMENT 'Records disputes related to coverage determinations including COB, network status, and benefit eligibility.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`appeal`.`iro_organization` (
    `iro_organization_id` BIGINT COMMENT 'Primary key for the IRO organization.',
    `accreditation_body` STRING COMMENT 'Accreditation body.',
    `accreditation_expiration_date` DATE COMMENT 'Expiration date of accreditation.',
    `accreditation_review_notes` STRING COMMENT 'Notes from accreditation review.',
    `accreditation_status` STRING COMMENT 'Current accreditation status.',
    `accreditation_status_code` STRING COMMENT '',
    `address_line1` STRING COMMENT 'Address line 1.',
    `address_line2` STRING COMMENT 'Address line 2.',
    `approved_states` STRING COMMENT 'States where the IRO is approved.',
    `assignment_rotation_methodology` STRING COMMENT 'Methodology for assignment rotation.',
    `city` STRING COMMENT 'City.',
    `compliance_requirements` STRING COMMENT 'Compliance requirements.',
    `conflict_of_interest_attestation_date` DATE COMMENT 'Date of conflict of interest attestation.',
    `contract_effective_end_date` DATE COMMENT 'Contract end date.',
    `contract_effective_start_date` DATE COMMENT 'Contract start date.',
    `contracted_specialty_codes` STRING COMMENT '',
    `country` STRING COMMENT 'Country.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp.',
    `email` STRING COMMENT 'Email address.',
    `external_review_scope` STRING COMMENT 'Scope of external reviews.',
    `iro_organization_status` STRING COMMENT 'Current status of the IRO.',
    `is_conflict_of_interest` BOOLEAN COMMENT 'Whether a conflict of interest exists.',
    `is_state_approved` BOOLEAN COMMENT 'Whether state approved.',
    `last_accreditation_review_date` DATE COMMENT 'Date of last accreditation review.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Last updated timestamp.',
    `iro_organization_name` STRING COMMENT 'Name of the IRO organization.',
    `ncqa_certified_flag` BOOLEAN COMMENT '',
    `organization_type` STRING COMMENT 'Type of organization.',
    `phone` STRING COMMENT 'Phone number.',
    `postal_code` STRING COMMENT 'Postal code.',
    `rotation_cycle_months` STRING COMMENT 'Rotation cycle in months.',
    `specialty_capabilities` STRING COMMENT 'Specialty capabilities.',
    `state` STRING COMMENT 'State.',
    `state_approval_status` STRING COMMENT 'State approval status.',
    `stub_populated_flag` BOOLEAN COMMENT 'Indicates that this stub product has been populated with required attributes',
    `urac_certified_flag` BOOLEAN COMMENT '',
    CONSTRAINT pk_iro_organization PRIMARY KEY(`iro_organization_id`)
) COMMENT 'Stores information about Independent Review Organizations (IROs) that conduct external reviews.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`appeal`.`outcome` (
    `outcome_id` BIGINT COMMENT 'Primary key for the outcome.',
    `adjustment_id` BIGINT COMMENT 'add column adjustment_id (BIGINT) with FK to claim.adjustment.adjustment_id - overturn outcomes generate claim adjustments',
    `adverse_determination_id` BIGINT COMMENT 'Foreign key linking to appeal.adverse_determination. Business justification: An outcome records the final resolution of an appeal, which ultimately resolves the original adverse determination. Linking outcome directly to adverse_determination enables overturn rate analysis (wh',
    `case_id` BIGINT COMMENT 'FK to the appeal case.',
    `header_id` BIGINT COMMENT 'FK to the claim header.',
    `health_plan_id` BIGINT COMMENT 'Foreign key linking to plan.health_plan. Business justification: Appeal outcomes drive plan-level financial adjustments, MLR recalculations, and CMS regulatory filings. Direct health_plan attribution on outcome enables plan-level overturn rate reporting and financi',
    `identity_id` BIGINT COMMENT 'FK to the member identity.',
    `pa_decision_id` BIGINT COMMENT 'Foreign key linking to utilization.pa_decision. Business justification: When an appeal outcome overturns a PA denial, the outcome must reference the original pa_decision for financial reconciliation, authorized-amount adjustment, and regulatory overturn-rate reporting. No',
    `plan_election_id` BIGINT COMMENT 'Foreign key linking to enrollment.plan_election. Business justification: Enrollment reinstatement tracking: appeal outcomes overturning adverse determinations trigger plan election reinstatement. Linking outcome directly to plan_election supports reinstatement reporting, p',
    `premium_invoice_id` BIGINT COMMENT 'Foreign key linking to billing.premium_invoice. Business justification: Appeal outcome billing resolution: when a billing appeal is resolved, the outcome must reference the original invoice to trigger refunds, adjustments, or write-offs. Billing operations require this li',
    `prior_outcome_id` BIGINT COMMENT 'Self-referencing FK to parent outcome.',
    `provider_id` BIGINT COMMENT 'FK to the provider.',
    `transaction_id` BIGINT COMMENT 'Foreign key linking to enrollment.transaction. Business justification: Appeal outcome downstream actions: when an appeal outcome results in enrollment reinstatement or coverage restoration, the outcome must reference the enrollment transaction it affects. Required for fi',
    `compliance_flag` BOOLEAN COMMENT 'Compliance flag.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp.',
    `currency_code` STRING COMMENT 'Currency code.',
    `downstream_action` STRING COMMENT 'Downstream action required.',
    `financial_impact_amount` DECIMAL(18,2) COMMENT 'Financial impact amount.',
    `jurisdiction_state` STRING COMMENT 'State jurisdiction.',
    `member_notification_timestamp` TIMESTAMP COMMENT 'Timestamp of member notification.',
    `notes` STRING COMMENT 'Additional notes.',
    `outcome_number` STRING COMMENT 'Unique outcome number.',
    `outcome_status` STRING COMMENT 'Current outcome status.',
    `outcome_timestamp` TIMESTAMP COMMENT 'Timestamp of the outcome.',
    `outcome_type` STRING COMMENT 'Type of outcome.',
    `provider_notification_timestamp` TIMESTAMP COMMENT 'Timestamp of provider notification.',
    `reason_code` STRING COMMENT 'Reason code.',
    `reason_description` STRING COMMENT 'Reason description.',
    `regulatory_body` STRING COMMENT 'Regulatory body.',
    `source_system_record_code` STRING COMMENT 'Source system record code.',
    `updated_timestamp` TIMESTAMP COMMENT 'Record last updated timestamp.',
    CONSTRAINT pk_outcome PRIMARY KEY(`outcome_id`)
) COMMENT 'Records the final outcomes of appeal cases including decisions, financial impacts, and downstream actions.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`case` ADD CONSTRAINT `fk_appeal_case_adverse_determination_id` FOREIGN KEY (`adverse_determination_id`) REFERENCES `vibe_health_insurance_v1`.`appeal`.`adverse_determination`(`adverse_determination_id`);
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`review` ADD CONSTRAINT `fk_appeal_review_adverse_determination_id` FOREIGN KEY (`adverse_determination_id`) REFERENCES `vibe_health_insurance_v1`.`appeal`.`adverse_determination`(`adverse_determination_id`);
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`review` ADD CONSTRAINT `fk_appeal_review_case_id` FOREIGN KEY (`case_id`) REFERENCES `vibe_health_insurance_v1`.`appeal`.`case`(`case_id`);
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`external_review` ADD CONSTRAINT `fk_appeal_external_review_adverse_determination_id` FOREIGN KEY (`adverse_determination_id`) REFERENCES `vibe_health_insurance_v1`.`appeal`.`adverse_determination`(`adverse_determination_id`);
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`external_review` ADD CONSTRAINT `fk_appeal_external_review_case_id` FOREIGN KEY (`case_id`) REFERENCES `vibe_health_insurance_v1`.`appeal`.`case`(`case_id`);
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`external_review` ADD CONSTRAINT `fk_appeal_external_review_iro_organization_id` FOREIGN KEY (`iro_organization_id`) REFERENCES `vibe_health_insurance_v1`.`appeal`.`iro_organization`(`iro_organization_id`);
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`timeline` ADD CONSTRAINT `fk_appeal_timeline_case_id` FOREIGN KEY (`case_id`) REFERENCES `vibe_health_insurance_v1`.`appeal`.`case`(`case_id`);
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`coverage_dispute` ADD CONSTRAINT `fk_appeal_coverage_dispute_adverse_determination_id` FOREIGN KEY (`adverse_determination_id`) REFERENCES `vibe_health_insurance_v1`.`appeal`.`adverse_determination`(`adverse_determination_id`);
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`coverage_dispute` ADD CONSTRAINT `fk_appeal_coverage_dispute_case_id` FOREIGN KEY (`case_id`) REFERENCES `vibe_health_insurance_v1`.`appeal`.`case`(`case_id`);
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`outcome` ADD CONSTRAINT `fk_appeal_outcome_adverse_determination_id` FOREIGN KEY (`adverse_determination_id`) REFERENCES `vibe_health_insurance_v1`.`appeal`.`adverse_determination`(`adverse_determination_id`);
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`outcome` ADD CONSTRAINT `fk_appeal_outcome_case_id` FOREIGN KEY (`case_id`) REFERENCES `vibe_health_insurance_v1`.`appeal`.`case`(`case_id`);
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`outcome` ADD CONSTRAINT `fk_appeal_outcome_prior_outcome_id` FOREIGN KEY (`prior_outcome_id`) REFERENCES `vibe_health_insurance_v1`.`appeal`.`outcome`(`outcome_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_health_insurance_v1`.`appeal` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `vibe_health_insurance_v1`.`appeal` SET TAGS ('dbx_domain' = 'appeal');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`case` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`case` SET TAGS ('dbx_subdomain' = 'appeal_management');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`case` ALTER COLUMN `case_id` SET TAGS ('dbx_business_glossary_term' = 'Case ID');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`case` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Account Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`case` ALTER COLUMN `adequacy_assessment_id` SET TAGS ('dbx_business_glossary_term' = 'Adequacy Assessment Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`case` ALTER COLUMN `adjudication_id` SET TAGS ('dbx_business_glossary_term' = 'Adjudication Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`case` ALTER COLUMN `adverse_determination_id` SET TAGS ('dbx_business_glossary_term' = 'Adverse Determination Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`case` ALTER COLUMN `aptc_subsidy_id` SET TAGS ('dbx_business_glossary_term' = 'Aptc Subsidy Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`case` ALTER COLUMN `benefit_package_id` SET TAGS ('dbx_business_glossary_term' = 'Benefit Package Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`case` ALTER COLUMN `header_id` SET TAGS ('dbx_business_glossary_term' = 'Claim Header ID');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`case` ALTER COLUMN `line_id` SET TAGS ('dbx_business_glossary_term' = 'Claim Line Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`case` ALTER COLUMN `denial_id` SET TAGS ('dbx_business_glossary_term' = 'Denial Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`case` ALTER COLUMN `disenrollment_id` SET TAGS ('dbx_business_glossary_term' = 'Disenrollment Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`case` ALTER COLUMN `eligibility_span_id` SET TAGS ('dbx_business_glossary_term' = 'Member Eligibility Span Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`case` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`case` ALTER COLUMN `grace_period_id` SET TAGS ('dbx_business_glossary_term' = 'Grace Period Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`case` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Health Plan ID');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`case` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`case` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`case` ALTER COLUMN `lob_assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Lob Assignment Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`case` ALTER COLUMN `identity_id` SET TAGS ('dbx_business_glossary_term' = 'Member Identity ID');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`case` ALTER COLUMN `identity_id` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`case` ALTER COLUMN `identity_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`case` ALTER COLUMN `par_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Par Agreement Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`case` ALTER COLUMN `participation_status_id` SET TAGS ('dbx_business_glossary_term' = 'Participation Status Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`case` ALTER COLUMN `pcp_assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Pcp Assignment Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`case` ALTER COLUMN `plan_election_id` SET TAGS ('dbx_business_glossary_term' = 'Plan Election ID');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`case` ALTER COLUMN `policy_id` SET TAGS ('dbx_business_glossary_term' = 'Policy Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`case` ALTER COLUMN `premium_invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Premium Invoice Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`case` ALTER COLUMN `premium_rate_id` SET TAGS ('dbx_business_glossary_term' = 'Premium Rate Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`case` ALTER COLUMN `provider_id` SET TAGS ('dbx_business_glossary_term' = 'Provider ID');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`case` ALTER COLUMN `provider_network_id` SET TAGS ('dbx_business_glossary_term' = 'Provider Network ID');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`case` ALTER COLUMN `qualifying_life_event_id` SET TAGS ('dbx_business_glossary_term' = 'Qualifying Life Event Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`case` ALTER COLUMN `tier_id` SET TAGS ('dbx_business_glossary_term' = 'Tier Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`case` ALTER COLUMN `transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Transaction Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`case` ALTER COLUMN `appeal_assigned_to` SET TAGS ('dbx_business_glossary_term' = 'Appeal Assigned To');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`case` ALTER COLUMN `appeal_escalation_flag` SET TAGS ('dbx_business_glossary_term' = 'Appeal Escalation Flag');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`case` ALTER COLUMN `appeal_number` SET TAGS ('dbx_business_glossary_term' = 'Appeal Number');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`case` ALTER COLUMN `appeal_priority` SET TAGS ('dbx_business_glossary_term' = 'Appeal Priority');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`case` ALTER COLUMN `appeal_review_cycle_days` SET TAGS ('dbx_business_glossary_term' = 'Appeal Review Cycle Days');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`case` ALTER COLUMN `appeal_status` SET TAGS ('dbx_business_glossary_term' = 'Appeal Status');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`case` ALTER COLUMN `appeal_type` SET TAGS ('dbx_business_glossary_term' = 'Appeal Type');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`case` ALTER COLUMN `clinical_criteria_applied` SET TAGS ('dbx_business_glossary_term' = 'Clinical Criteria Applied');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`case` ALTER COLUMN `completeness_determination` SET TAGS ('dbx_business_glossary_term' = 'Completeness Determination');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`case` ALTER COLUMN `decision_author_npi` SET TAGS ('dbx_business_glossary_term' = 'Decision Author NPI');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`case` ALTER COLUMN `decision_author_npi` SET TAGS ('dbx_classification' = 'confidential');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`case` ALTER COLUMN `decision_author_npi` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`case` ALTER COLUMN `decision_author_npi` SET TAGS ('dbx_pii_data' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`case` ALTER COLUMN `decision_author_npi` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`case` ALTER COLUMN `decision_rationale` SET TAGS ('dbx_business_glossary_term' = 'Decision Rationale');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`case` ALTER COLUMN `decision_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Decision Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`case` ALTER COLUMN `decision_type` SET TAGS ('dbx_business_glossary_term' = 'Decision Type');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`case` ALTER COLUMN `effective_benefit_change_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Benefit Change Date');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`case` ALTER COLUMN `expedited_clinical_urgency_basis` SET TAGS ('dbx_business_glossary_term' = 'Expedited Clinical Urgency Basis');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`case` ALTER COLUMN `expedited_trigger` SET TAGS ('dbx_business_glossary_term' = 'Expedited Trigger');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`case` ALTER COLUMN `filing_channel` SET TAGS ('dbx_business_glossary_term' = 'Filing Channel');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`case` ALTER COLUMN `filing_method` SET TAGS ('dbx_business_glossary_term' = 'Filing Method');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`case` ALTER COLUMN `filing_party_type` SET TAGS ('dbx_business_glossary_term' = 'Filing Party Type');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`case` ALTER COLUMN `filing_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Filing Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`case` ALTER COLUMN `line_of_business` SET TAGS ('dbx_business_glossary_term' = 'Line of Business');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`case` ALTER COLUMN `member_notification_date` SET TAGS ('dbx_business_glossary_term' = 'Member Notification Date');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`case` ALTER COLUMN `original_claim_number` SET TAGS ('dbx_business_glossary_term' = 'Original Claim Number');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`case` ALTER COLUMN `overturn_reason` SET TAGS ('dbx_business_glossary_term' = 'Overturn Reason');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`case` ALTER COLUMN `provider_notification_date` SET TAGS ('dbx_business_glossary_term' = 'Provider Notification Date');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`case` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`case` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`case` ALTER COLUMN `regulatory_tier` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Tier');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`case` ALTER COLUMN `supporting_documentation_checklist` SET TAGS ('dbx_business_glossary_term' = 'Supporting Documentation Checklist');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`adverse_determination` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`adverse_determination` SET TAGS ('dbx_subdomain' = 'appeal_management');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`adverse_determination` ALTER COLUMN `adverse_determination_id` SET TAGS ('dbx_business_glossary_term' = 'Adverse Determination ID');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`adverse_determination` ALTER COLUMN `aptc_subsidy_id` SET TAGS ('dbx_business_glossary_term' = 'Aptc Subsidy Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`adverse_determination` ALTER COLUMN `benefit_id` SET TAGS ('dbx_business_glossary_term' = 'Benefit Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`adverse_determination` ALTER COLUMN `header_id` SET TAGS ('dbx_business_glossary_term' = 'Claim Header ID');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`adverse_determination` ALTER COLUMN `line_id` SET TAGS ('dbx_business_glossary_term' = 'Claim Line Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`adverse_determination` ALTER COLUMN `condition_registry_id` SET TAGS ('dbx_business_glossary_term' = 'Condition Registry Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`adverse_determination` ALTER COLUMN `drug_master_id` SET TAGS ('dbx_business_glossary_term' = 'Drug Master Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`adverse_determination` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Health Plan Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`adverse_determination` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`adverse_determination` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`adverse_determination` ALTER COLUMN `identity_id` SET TAGS ('dbx_business_glossary_term' = 'Member Identity ID');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`adverse_determination` ALTER COLUMN `identity_id` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`adverse_determination` ALTER COLUMN `identity_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`adverse_determination` ALTER COLUMN `pa_decision_id` SET TAGS ('dbx_business_glossary_term' = 'Pa Decision Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`adverse_determination` ALTER COLUMN `pa_request_id` SET TAGS ('dbx_business_glossary_term' = 'PA Request ID');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`adverse_determination` ALTER COLUMN `par_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Par Agreement Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`adverse_determination` ALTER COLUMN `participation_status_id` SET TAGS ('dbx_business_glossary_term' = 'Participation Status Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`adverse_determination` ALTER COLUMN `plan_election_id` SET TAGS ('dbx_business_glossary_term' = 'Plan Election Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`adverse_determination` ALTER COLUMN `care_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Care Plan Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`adverse_determination` ALTER COLUMN `policy_id` SET TAGS ('dbx_business_glossary_term' = 'Policy Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`adverse_determination` ALTER COLUMN `procedure_id` SET TAGS ('dbx_business_glossary_term' = 'Procedure Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`adverse_determination` ALTER COLUMN `provider_assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Provider Assignment Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`adverse_determination` ALTER COLUMN `provider_id` SET TAGS ('dbx_business_glossary_term' = 'Provider ID');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`adverse_determination` ALTER COLUMN `provider_network_id` SET TAGS ('dbx_business_glossary_term' = 'Provider Network Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`adverse_determination` ALTER COLUMN `appeal_deadline_date` SET TAGS ('dbx_business_glossary_term' = 'Appeal Deadline Date');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`adverse_determination` ALTER COLUMN `appeal_eligibility_flag` SET TAGS ('dbx_business_glossary_term' = 'Appeal Eligibility Flag');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`adverse_determination` ALTER COLUMN `appeal_filed_date` SET TAGS ('dbx_business_glossary_term' = 'Appeal Filed Date');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`adverse_determination` ALTER COLUMN `appeal_outcome` SET TAGS ('dbx_business_glossary_term' = 'Appeal Outcome');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`adverse_determination` ALTER COLUMN `appeal_resolution_date` SET TAGS ('dbx_business_glossary_term' = 'Appeal Resolution Date');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`adverse_determination` ALTER COLUMN `appeal_status` SET TAGS ('dbx_business_glossary_term' = 'Appeal Status');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`adverse_determination` ALTER COLUMN `basis_of_denial` SET TAGS ('dbx_business_glossary_term' = 'Basis of Denial');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`adverse_determination` ALTER COLUMN `clinical_criteria_version` SET TAGS ('dbx_business_glossary_term' = 'Clinical Criteria Version');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`adverse_determination` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`adverse_determination` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`adverse_determination` ALTER COLUMN `denial_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Denial Reason Code');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`adverse_determination` ALTER COLUMN `denial_reason_description` SET TAGS ('dbx_business_glossary_term' = 'Denial Reason Description');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`adverse_determination` ALTER COLUMN `determination_date` SET TAGS ('dbx_business_glossary_term' = 'Determination Date');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`adverse_determination` ALTER COLUMN `determination_number` SET TAGS ('dbx_business_glossary_term' = 'Determination Number');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`adverse_determination` ALTER COLUMN `determination_status` SET TAGS ('dbx_business_glossary_term' = 'Determination Status');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`adverse_determination` ALTER COLUMN `determination_type` SET TAGS ('dbx_business_glossary_term' = 'Determination Type');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`adverse_determination` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`adverse_determination` ALTER COLUMN `monetary_amount_adjusted` SET TAGS ('dbx_business_glossary_term' = 'Monetary Amount Adjusted');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`adverse_determination` ALTER COLUMN `monetary_amount_denied` SET TAGS ('dbx_business_glossary_term' = 'Monetary Amount Denied');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`adverse_determination` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`adverse_determination` ALTER COLUMN `prior_authorization_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Prior Authorization Required Flag');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`adverse_determination` ALTER COLUMN `reviewer_name` SET TAGS ('dbx_business_glossary_term' = 'Reviewer Name');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`adverse_determination` ALTER COLUMN `reviewer_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`adverse_determination` ALTER COLUMN `reviewer_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`adverse_determination` ALTER COLUMN `reviewer_name` SET TAGS ('dbx_classification' = 'confidential');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`adverse_determination` ALTER COLUMN `reviewer_name` SET TAGS ('dbx_pii_data' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`adverse_determination` ALTER COLUMN `reviewer_npi` SET TAGS ('dbx_business_glossary_term' = 'Reviewer NPI');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`adverse_determination` ALTER COLUMN `reviewer_npi` SET TAGS ('dbx_classification' = 'confidential');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`adverse_determination` ALTER COLUMN `reviewer_npi` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`adverse_determination` ALTER COLUMN `reviewer_npi` SET TAGS ('dbx_pii_data' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`adverse_determination` ALTER COLUMN `reviewer_npi` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`adverse_determination` ALTER COLUMN `service_date` SET TAGS ('dbx_business_glossary_term' = 'Service Date');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`adverse_determination` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`review` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`review` SET TAGS ('dbx_subdomain' = 'external_review');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`review` ALTER COLUMN `review_id` SET TAGS ('dbx_business_glossary_term' = 'Review ID');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`review` ALTER COLUMN `adverse_determination_id` SET TAGS ('dbx_business_glossary_term' = 'Adverse Determination Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`review` ALTER COLUMN `case_id` SET TAGS ('dbx_business_glossary_term' = 'Case ID');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`review` ALTER COLUMN `pa_decision_id` SET TAGS ('dbx_business_glossary_term' = 'Pa Decision Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`review` ALTER COLUMN `appeal_case_number` SET TAGS ('dbx_business_glossary_term' = 'Appeal Case Number');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`review` ALTER COLUMN `appeal_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Appeal Reason Code');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`review` ALTER COLUMN `appeal_status_at_review` SET TAGS ('dbx_business_glossary_term' = 'Appeal Status at Review');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`review` ALTER COLUMN `appeal_submission_date` SET TAGS ('dbx_business_glossary_term' = 'Appeal Submission Date');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`review` ALTER COLUMN `clinical_rationale` SET TAGS ('dbx_business_glossary_term' = 'Clinical Rationale');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`review` ALTER COLUMN `compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Compliance Flag');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`review` ALTER COLUMN `cpt_codes_reviewed` SET TAGS ('dbx_business_glossary_term' = 'CPT Codes Reviewed');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`review` ALTER COLUMN `criteria_version` SET TAGS ('dbx_business_glossary_term' = 'Criteria Version');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`review` ALTER COLUMN `drg_code` SET TAGS ('dbx_business_glossary_term' = 'DRG Code');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`review` ALTER COLUMN `duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Duration Minutes');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`review` ALTER COLUMN `icd_codes_reviewed` SET TAGS ('dbx_business_glossary_term' = 'ICD Codes Reviewed');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`review` ALTER COLUMN `icd_codes_reviewed` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`review` ALTER COLUMN `icd_codes_reviewed` SET TAGS ('dbx_pii_phi_diagnosis' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`review` ALTER COLUMN `is_independent_reviewer` SET TAGS ('dbx_business_glossary_term' = 'Is Independent Reviewer');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`review` ALTER COLUMN `location` SET TAGS ('dbx_business_glossary_term' = 'Location');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`review` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`review` ALTER COLUMN `outcome` SET TAGS ('dbx_business_glossary_term' = 'Outcome');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`review` ALTER COLUMN `record_audit_created` SET TAGS ('dbx_business_glossary_term' = 'Record Audit Created');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`review` ALTER COLUMN `record_audit_updated` SET TAGS ('dbx_business_glossary_term' = 'Record Audit Updated');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`review` ALTER COLUMN `review_number` SET TAGS ('dbx_business_glossary_term' = 'Review Number');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`review` ALTER COLUMN `review_status` SET TAGS ('dbx_business_glossary_term' = 'Review Status');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`review` ALTER COLUMN `review_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Review Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`review` ALTER COLUMN `review_type` SET TAGS ('dbx_business_glossary_term' = 'Review Type');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`review` ALTER COLUMN `reviewer_npi` SET TAGS ('dbx_business_glossary_term' = 'Reviewer NPI');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`review` ALTER COLUMN `reviewer_npi` SET TAGS ('dbx_classification' = 'confidential');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`review` ALTER COLUMN `reviewer_npi` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`review` ALTER COLUMN `reviewer_npi` SET TAGS ('dbx_pii_data' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`review` ALTER COLUMN `reviewer_npi` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`review` ALTER COLUMN `reviewer_specialty` SET TAGS ('dbx_business_glossary_term' = 'Reviewer Specialty');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`review` ALTER COLUMN `reviewer_type` SET TAGS ('dbx_business_glossary_term' = 'Reviewer Type');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`external_review` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`external_review` SET TAGS ('dbx_subdomain' = 'external_review');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`external_review` ALTER COLUMN `external_review_id` SET TAGS ('dbx_business_glossary_term' = 'External Review ID');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`external_review` ALTER COLUMN `adverse_determination_id` SET TAGS ('dbx_business_glossary_term' = 'Adverse Determination Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`external_review` ALTER COLUMN `case_id` SET TAGS ('dbx_business_glossary_term' = 'Case ID');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`external_review` ALTER COLUMN `header_id` SET TAGS ('dbx_business_glossary_term' = 'Claim Header ID');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`external_review` ALTER COLUMN `drug_master_id` SET TAGS ('dbx_business_glossary_term' = 'Drug Master Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`external_review` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Health Plan Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`external_review` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`external_review` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`external_review` ALTER COLUMN `iro_organization_id` SET TAGS ('dbx_business_glossary_term' = 'IRO Organization ID');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`external_review` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_business_glossary_term' = 'Member Subscriber ID');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`external_review` ALTER COLUMN `provider_id` SET TAGS ('dbx_business_glossary_term' = 'Provider ID');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`external_review` ALTER COLUMN `adjustment_amount` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Amount');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`external_review` ALTER COLUMN `appeal_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Appeal Reason Code');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`external_review` ALTER COLUMN `appeal_reason_description` SET TAGS ('dbx_business_glossary_term' = 'Appeal Reason Description');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`external_review` ALTER COLUMN `binding_determination_flag` SET TAGS ('dbx_business_glossary_term' = 'Binding Determination Flag');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`external_review` ALTER COLUMN `claim_amount` SET TAGS ('dbx_business_glossary_term' = 'Claim Amount');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`external_review` ALTER COLUMN `compliance_action_taken` SET TAGS ('dbx_business_glossary_term' = 'Compliance Action Taken');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`external_review` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`external_review` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`external_review` ALTER COLUMN `deadline_date` SET TAGS ('dbx_business_glossary_term' = 'Deadline Date');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`external_review` ALTER COLUMN `decision` SET TAGS ('dbx_business_glossary_term' = 'Decision');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`external_review` ALTER COLUMN `decision_date` SET TAGS ('dbx_business_glossary_term' = 'Decision Date');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`external_review` ALTER COLUMN `decision_rationale` SET TAGS ('dbx_business_glossary_term' = 'Decision Rationale');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`external_review` ALTER COLUMN `diagnosis_code` SET TAGS ('dbx_business_glossary_term' = 'Diagnosis Code');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`external_review` ALTER COLUMN `diagnosis_code` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`external_review` ALTER COLUMN `diagnosis_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`external_review` ALTER COLUMN `diagnosis_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`external_review` ALTER COLUMN `diagnosis_code` SET TAGS ('dbx_pii_phi_diagnosis' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`external_review` ALTER COLUMN `external_review_status` SET TAGS ('dbx_business_glossary_term' = 'External Review Status');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`external_review` ALTER COLUMN `external_review_type` SET TAGS ('dbx_business_glossary_term' = 'External Review Type');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`external_review` ALTER COLUMN `iro_accreditation_status` SET TAGS ('dbx_business_glossary_term' = 'IRO Accreditation Status');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`external_review` ALTER COLUMN `is_urgent` SET TAGS ('dbx_business_glossary_term' = 'Is Urgent');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`external_review` ALTER COLUMN `last_status_change_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Status Change Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`external_review` ALTER COLUMN `net_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Amount');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`external_review` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`external_review` ALTER COLUMN `overdue_flag` SET TAGS ('dbx_business_glossary_term' = 'Overdue Flag');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`external_review` ALTER COLUMN `patient_relationship` SET TAGS ('dbx_business_glossary_term' = 'Patient Relationship');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`external_review` ALTER COLUMN `procedure_code` SET TAGS ('dbx_business_glossary_term' = 'Procedure Code');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`external_review` ALTER COLUMN `regulatory_reporting_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reporting Flag');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`external_review` ALTER COLUMN `reporting_status` SET TAGS ('dbx_business_glossary_term' = 'Reporting Status');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`external_review` ALTER COLUMN `reporting_submission_date` SET TAGS ('dbx_business_glossary_term' = 'Reporting Submission Date');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`external_review` ALTER COLUMN `request_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Request Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`external_review` ALTER COLUMN `review_category` SET TAGS ('dbx_business_glossary_term' = 'Review Category');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`external_review` ALTER COLUMN `review_number` SET TAGS ('dbx_business_glossary_term' = 'Review Number');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`external_review` ALTER COLUMN `review_priority` SET TAGS ('dbx_business_glossary_term' = 'Review Priority');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`external_review` ALTER COLUMN `service_date` SET TAGS ('dbx_business_glossary_term' = 'Service Date');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`external_review` ALTER COLUMN `source` SET TAGS ('dbx_business_glossary_term' = 'External Review Source');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`external_review` ALTER COLUMN `state` SET TAGS ('dbx_business_glossary_term' = 'State');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`external_review` ALTER COLUMN `state` SET TAGS ('dbx_classification' = 'confidential');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`external_review` ALTER COLUMN `state` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`external_review` ALTER COLUMN `state` SET TAGS ('dbx_pii_data' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`external_review` ALTER COLUMN `state` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`external_review` ALTER COLUMN `transmission_date` SET TAGS ('dbx_business_glossary_term' = 'Transmission Date');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`external_review` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`timeline` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`timeline` SET TAGS ('dbx_subdomain' = 'appeal_management');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`timeline` ALTER COLUMN `timeline_id` SET TAGS ('dbx_business_glossary_term' = 'Timeline ID');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`timeline` ALTER COLUMN `case_id` SET TAGS ('dbx_business_glossary_term' = 'Case ID');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`timeline` ALTER COLUMN `identity_id` SET TAGS ('dbx_business_glossary_term' = 'Member Identity ID');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`timeline` ALTER COLUMN `identity_id` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`timeline` ALTER COLUMN `identity_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`timeline` ALTER COLUMN `acknowledgment_due_date` SET TAGS ('dbx_business_glossary_term' = 'Acknowledgment Due Date');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`timeline` ALTER COLUMN `actual_acknowledgment_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Acknowledgment Date');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`timeline` ALTER COLUMN `actual_decision_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Decision Date');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`timeline` ALTER COLUMN `actual_expedited_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Expedited Date');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`timeline` ALTER COLUMN `actual_extension_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Extension Date');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`timeline` ALTER COLUMN `appeal_category` SET TAGS ('dbx_business_glossary_term' = 'Appeal Category');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`timeline` ALTER COLUMN `appeal_filed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Appeal Filed Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`timeline` ALTER COLUMN `appeal_origin` SET TAGS ('dbx_business_glossary_term' = 'Appeal Origin');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`timeline` ALTER COLUMN `appeal_status` SET TAGS ('dbx_business_glossary_term' = 'Appeal Status');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`timeline` ALTER COLUMN `breach_flag` SET TAGS ('dbx_business_glossary_term' = 'Breach Flag');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`timeline` ALTER COLUMN `breach_reason` SET TAGS ('dbx_business_glossary_term' = 'Breach Reason');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`timeline` ALTER COLUMN `clock_start_event` SET TAGS ('dbx_business_glossary_term' = 'Clock Start Event');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`timeline` ALTER COLUMN `clock_type` SET TAGS ('dbx_business_glossary_term' = 'Clock Type');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`timeline` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`timeline` ALTER COLUMN `corrective_action` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`timeline` ALTER COLUMN `days_overdue` SET TAGS ('dbx_business_glossary_term' = 'Days Overdue');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`timeline` ALTER COLUMN `decision_due_date` SET TAGS ('dbx_business_glossary_term' = 'Decision Due Date');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`timeline` ALTER COLUMN `expedited_due_date` SET TAGS ('dbx_business_glossary_term' = 'Expedited Due Date');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`timeline` ALTER COLUMN `extension_notification_date` SET TAGS ('dbx_business_glossary_term' = 'Extension Notification Date');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`timeline` ALTER COLUMN `extension_reason` SET TAGS ('dbx_business_glossary_term' = 'Extension Reason');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`timeline` ALTER COLUMN `jurisdiction_state` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction State');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`timeline` ALTER COLUMN `jurisdiction_state` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`timeline` ALTER COLUMN `jurisdiction_state` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`timeline` ALTER COLUMN `last_action_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Action Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`timeline` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`timeline` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Priority');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`timeline` ALTER COLUMN `record_audit_created` SET TAGS ('dbx_business_glossary_term' = 'Record Audit Created');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`timeline` ALTER COLUMN `record_audit_updated` SET TAGS ('dbx_business_glossary_term' = 'Record Audit Updated');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`timeline` ALTER COLUMN `record_version` SET TAGS ('dbx_business_glossary_term' = 'Record Version');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`timeline` ALTER COLUMN `regulatory_body` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Body');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`timeline` ALTER COLUMN `root_cause_category` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Category');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`timeline` ALTER COLUMN `self_report_flag` SET TAGS ('dbx_business_glossary_term' = 'Self Report Flag');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`timeline` ALTER COLUMN `sla_actual_days` SET TAGS ('dbx_business_glossary_term' = 'SLA Actual Days');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`timeline` ALTER COLUMN `sla_breach` SET TAGS ('dbx_business_glossary_term' = 'SLA Breach');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`timeline` ALTER COLUMN `sla_target_days` SET TAGS ('dbx_business_glossary_term' = 'SLA Target Days');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`timeline` ALTER COLUMN `source_system_record_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Record Code');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`coverage_dispute` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`coverage_dispute` SET TAGS ('dbx_subdomain' = 'appeal_management');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`coverage_dispute` ALTER COLUMN `coverage_dispute_id` SET TAGS ('dbx_business_glossary_term' = 'Coverage Dispute ID');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`coverage_dispute` ALTER COLUMN `aptc_subsidy_id` SET TAGS ('dbx_business_glossary_term' = 'Aptc Subsidy Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`coverage_dispute` ALTER COLUMN `benefit_id` SET TAGS ('dbx_business_glossary_term' = 'Benefit Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`coverage_dispute` ALTER COLUMN `benefit_package_id` SET TAGS ('dbx_business_glossary_term' = 'Benefit Package Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`coverage_dispute` ALTER COLUMN `case_id` SET TAGS ('dbx_business_glossary_term' = 'Case ID');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`coverage_dispute` ALTER COLUMN `header_id` SET TAGS ('dbx_business_glossary_term' = 'Claim Header ID');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`coverage_dispute` ALTER COLUMN `cob_id` SET TAGS ('dbx_business_glossary_term' = 'Cob Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`coverage_dispute` ALTER COLUMN `cost_share_rule_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Share Rule Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`coverage_dispute` ALTER COLUMN `formulary_id` SET TAGS ('dbx_business_glossary_term' = 'Formulary Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`coverage_dispute` ALTER COLUMN `grace_period_id` SET TAGS ('dbx_business_glossary_term' = 'Grace Period Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`coverage_dispute` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Health Plan ID');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`coverage_dispute` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`coverage_dispute` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`coverage_dispute` ALTER COLUMN `invoice_line_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice Line Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`coverage_dispute` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_business_glossary_term' = 'Member Subscriber ID');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`coverage_dispute` ALTER COLUMN `open_enrollment_period_id` SET TAGS ('dbx_business_glossary_term' = 'Open Enrollment Period Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`coverage_dispute` ALTER COLUMN `pa_decision_id` SET TAGS ('dbx_business_glossary_term' = 'Pa Decision Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`coverage_dispute` ALTER COLUMN `par_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Par Agreement Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`coverage_dispute` ALTER COLUMN `participation_status_id` SET TAGS ('dbx_business_glossary_term' = 'Participation Status Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`coverage_dispute` ALTER COLUMN `policy_id` SET TAGS ('dbx_business_glossary_term' = 'Policy Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`coverage_dispute` ALTER COLUMN `premium_invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Premium Invoice Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`coverage_dispute` ALTER COLUMN `premium_rate_id` SET TAGS ('dbx_business_glossary_term' = 'Premium Rate Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`coverage_dispute` ALTER COLUMN `prior_authorization_id` SET TAGS ('dbx_business_glossary_term' = 'Prior Authorization ID');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`coverage_dispute` ALTER COLUMN `provider_id` SET TAGS ('dbx_business_glossary_term' = 'Provider ID');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`coverage_dispute` ALTER COLUMN `provider_network_id` SET TAGS ('dbx_business_glossary_term' = 'Provider Network Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`coverage_dispute` ALTER COLUMN `qualifying_life_event_id` SET TAGS ('dbx_business_glossary_term' = 'Qualifying Life Event Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`coverage_dispute` ALTER COLUMN `transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Transaction Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`coverage_dispute` ALTER COLUMN `appeal_deadline` SET TAGS ('dbx_business_glossary_term' = 'Appeal Deadline');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`coverage_dispute` ALTER COLUMN `appeal_filed_date` SET TAGS ('dbx_business_glossary_term' = 'Appeal Filed Date');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`coverage_dispute` ALTER COLUMN `appeal_status` SET TAGS ('dbx_business_glossary_term' = 'Appeal Status');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`coverage_dispute` ALTER COLUMN `cob_order` SET TAGS ('dbx_business_glossary_term' = 'COB Order');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`coverage_dispute` ALTER COLUMN `cob_rule_applied` SET TAGS ('dbx_business_glossary_term' = 'COB Rule Applied');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`coverage_dispute` ALTER COLUMN `coordination_amount` SET TAGS ('dbx_business_glossary_term' = 'Coordination Amount');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`coverage_dispute` ALTER COLUMN `coverage_dispute_status` SET TAGS ('dbx_business_glossary_term' = 'Coverage Dispute Status');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`coverage_dispute` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`coverage_dispute` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`coverage_dispute` ALTER COLUMN `dispute_description` SET TAGS ('dbx_business_glossary_term' = 'Dispute Description');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`coverage_dispute` ALTER COLUMN `dispute_number` SET TAGS ('dbx_business_glossary_term' = 'Dispute Number');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`coverage_dispute` ALTER COLUMN `dispute_type` SET TAGS ('dbx_business_glossary_term' = 'Dispute Type');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`coverage_dispute` ALTER COLUMN `disputing_party_type` SET TAGS ('dbx_business_glossary_term' = 'Disputing Party Type');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`coverage_dispute` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`coverage_dispute` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`coverage_dispute` ALTER COLUMN `formulary_exception_flag` SET TAGS ('dbx_business_glossary_term' = 'Formulary Exception Flag');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`coverage_dispute` ALTER COLUMN `is_critical` SET TAGS ('dbx_business_glossary_term' = 'Is Critical');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`coverage_dispute` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`coverage_dispute` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Priority Level');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`coverage_dispute` ALTER COLUMN `regulatory_reference` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reference');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`coverage_dispute` ALTER COLUMN `resolution_date` SET TAGS ('dbx_business_glossary_term' = 'Resolution Date');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`coverage_dispute` ALTER COLUMN `resolution_outcome` SET TAGS ('dbx_business_glossary_term' = 'Resolution Outcome');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`coverage_dispute` ALTER COLUMN `subrogation_amount` SET TAGS ('dbx_business_glossary_term' = 'Subrogation Amount');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`coverage_dispute` ALTER COLUMN `subrogation_flag` SET TAGS ('dbx_business_glossary_term' = 'Subrogation Flag');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`coverage_dispute` ALTER COLUMN `supporting_document_count` SET TAGS ('dbx_business_glossary_term' = 'Supporting Document Count');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`coverage_dispute` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`iro_organization` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`iro_organization` SET TAGS ('dbx_subdomain' = 'external_review');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`iro_organization` ALTER COLUMN `iro_organization_id` SET TAGS ('dbx_business_glossary_term' = 'IRO Organization ID');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`iro_organization` ALTER COLUMN `accreditation_body` SET TAGS ('dbx_business_glossary_term' = 'Accreditation Body');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`iro_organization` ALTER COLUMN `accreditation_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Accreditation Expiration Date');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`iro_organization` ALTER COLUMN `accreditation_review_notes` SET TAGS ('dbx_business_glossary_term' = 'Accreditation Review Notes');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`iro_organization` ALTER COLUMN `accreditation_status` SET TAGS ('dbx_business_glossary_term' = 'Accreditation Status');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`iro_organization` ALTER COLUMN `address_line1` SET TAGS ('dbx_business_glossary_term' = 'Address Line 1');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`iro_organization` ALTER COLUMN `address_line1` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`iro_organization` ALTER COLUMN `address_line1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`iro_organization` ALTER COLUMN `address_line1` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`iro_organization` ALTER COLUMN `address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`iro_organization` ALTER COLUMN `address_line1` SET TAGS ('dbx_classification' = 'confidential');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`iro_organization` ALTER COLUMN `address_line1` SET TAGS ('dbx_pii_data' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`iro_organization` ALTER COLUMN `address_line2` SET TAGS ('dbx_business_glossary_term' = 'Address Line 2');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`iro_organization` ALTER COLUMN `address_line2` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`iro_organization` ALTER COLUMN `address_line2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`iro_organization` ALTER COLUMN `address_line2` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`iro_organization` ALTER COLUMN `address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`iro_organization` ALTER COLUMN `address_line2` SET TAGS ('dbx_classification' = 'confidential');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`iro_organization` ALTER COLUMN `address_line2` SET TAGS ('dbx_pii_data' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`iro_organization` ALTER COLUMN `approved_states` SET TAGS ('dbx_business_glossary_term' = 'Approved States');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`iro_organization` ALTER COLUMN `approved_states` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`iro_organization` ALTER COLUMN `approved_states` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`iro_organization` ALTER COLUMN `assignment_rotation_methodology` SET TAGS ('dbx_business_glossary_term' = 'Assignment Rotation Methodology');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`iro_organization` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'City');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`iro_organization` ALTER COLUMN `city` SET TAGS ('dbx_classification' = 'confidential');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`iro_organization` ALTER COLUMN `city` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`iro_organization` ALTER COLUMN `city` SET TAGS ('dbx_pii_data' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`iro_organization` ALTER COLUMN `city` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`iro_organization` ALTER COLUMN `compliance_requirements` SET TAGS ('dbx_business_glossary_term' = 'Compliance Requirements');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`iro_organization` ALTER COLUMN `conflict_of_interest_attestation_date` SET TAGS ('dbx_business_glossary_term' = 'Conflict of Interest Attestation Date');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`iro_organization` ALTER COLUMN `contract_effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Contract Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`iro_organization` ALTER COLUMN `contract_effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Contract Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`iro_organization` ALTER COLUMN `country` SET TAGS ('dbx_business_glossary_term' = 'Country');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`iro_organization` ALTER COLUMN `country` SET TAGS ('dbx_classification' = 'confidential');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`iro_organization` ALTER COLUMN `country` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`iro_organization` ALTER COLUMN `country` SET TAGS ('dbx_pii_data' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`iro_organization` ALTER COLUMN `country` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`iro_organization` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`iro_organization` ALTER COLUMN `email` SET TAGS ('dbx_business_glossary_term' = 'Email');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`iro_organization` ALTER COLUMN `email` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`iro_organization` ALTER COLUMN `email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`iro_organization` ALTER COLUMN `email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`iro_organization` ALTER COLUMN `email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`iro_organization` ALTER COLUMN `email` SET TAGS ('dbx_classification' = 'confidential');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`iro_organization` ALTER COLUMN `email` SET TAGS ('dbx_pii_data' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`iro_organization` ALTER COLUMN `external_review_scope` SET TAGS ('dbx_business_glossary_term' = 'External Review Scope');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`iro_organization` ALTER COLUMN `iro_organization_status` SET TAGS ('dbx_business_glossary_term' = 'IRO Organization Status');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`iro_organization` ALTER COLUMN `is_conflict_of_interest` SET TAGS ('dbx_business_glossary_term' = 'Is Conflict of Interest');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`iro_organization` ALTER COLUMN `is_state_approved` SET TAGS ('dbx_business_glossary_term' = 'Is State Approved');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`iro_organization` ALTER COLUMN `is_state_approved` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`iro_organization` ALTER COLUMN `is_state_approved` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`iro_organization` ALTER COLUMN `last_accreditation_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Accreditation Review Date');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`iro_organization` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`iro_organization` ALTER COLUMN `iro_organization_name` SET TAGS ('dbx_business_glossary_term' = 'IRO Organization Name');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`iro_organization` ALTER COLUMN `iro_organization_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`iro_organization` ALTER COLUMN `iro_organization_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`iro_organization` ALTER COLUMN `iro_organization_name` SET TAGS ('dbx_classification' = 'confidential');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`iro_organization` ALTER COLUMN `iro_organization_name` SET TAGS ('dbx_pii_data' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`iro_organization` ALTER COLUMN `organization_type` SET TAGS ('dbx_business_glossary_term' = 'Organization Type');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`iro_organization` ALTER COLUMN `phone` SET TAGS ('dbx_business_glossary_term' = 'Phone');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`iro_organization` ALTER COLUMN `phone` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`iro_organization` ALTER COLUMN `phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`iro_organization` ALTER COLUMN `phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`iro_organization` ALTER COLUMN `phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`iro_organization` ALTER COLUMN `phone` SET TAGS ('dbx_classification' = 'confidential');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`iro_organization` ALTER COLUMN `phone` SET TAGS ('dbx_pii_data' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`iro_organization` ALTER COLUMN `postal_code` SET TAGS ('dbx_business_glossary_term' = 'Postal Code');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`iro_organization` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`iro_organization` ALTER COLUMN `postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`iro_organization` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_postal_code' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`iro_organization` ALTER COLUMN `postal_code` SET TAGS ('dbx_classification' = 'confidential');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`iro_organization` ALTER COLUMN `postal_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`iro_organization` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_data' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`iro_organization` ALTER COLUMN `rotation_cycle_months` SET TAGS ('dbx_business_glossary_term' = 'Rotation Cycle Months');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`iro_organization` ALTER COLUMN `specialty_capabilities` SET TAGS ('dbx_business_glossary_term' = 'Specialty Capabilities');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`iro_organization` ALTER COLUMN `state` SET TAGS ('dbx_business_glossary_term' = 'State');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`iro_organization` ALTER COLUMN `state` SET TAGS ('dbx_classification' = 'confidential');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`iro_organization` ALTER COLUMN `state` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`iro_organization` ALTER COLUMN `state` SET TAGS ('dbx_pii_data' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`iro_organization` ALTER COLUMN `state` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`iro_organization` ALTER COLUMN `state_approval_status` SET TAGS ('dbx_business_glossary_term' = 'State Approval Status');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`iro_organization` ALTER COLUMN `state_approval_status` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`iro_organization` ALTER COLUMN `state_approval_status` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`outcome` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`outcome` SET TAGS ('dbx_subdomain' = 'external_review');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`outcome` ALTER COLUMN `outcome_id` SET TAGS ('dbx_business_glossary_term' = 'Outcome ID');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`outcome` ALTER COLUMN `adverse_determination_id` SET TAGS ('dbx_business_glossary_term' = 'Adverse Determination Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`outcome` ALTER COLUMN `case_id` SET TAGS ('dbx_business_glossary_term' = 'Case ID');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`outcome` ALTER COLUMN `header_id` SET TAGS ('dbx_business_glossary_term' = 'Claim Header ID');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`outcome` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Health Plan Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`outcome` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`outcome` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`outcome` ALTER COLUMN `identity_id` SET TAGS ('dbx_business_glossary_term' = 'Member Identity ID');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`outcome` ALTER COLUMN `identity_id` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`outcome` ALTER COLUMN `identity_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`outcome` ALTER COLUMN `pa_decision_id` SET TAGS ('dbx_business_glossary_term' = 'Pa Decision Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`outcome` ALTER COLUMN `plan_election_id` SET TAGS ('dbx_business_glossary_term' = 'Plan Election Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`outcome` ALTER COLUMN `premium_invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Premium Invoice Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`outcome` ALTER COLUMN `prior_outcome_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Outcome ID');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`outcome` ALTER COLUMN `provider_id` SET TAGS ('dbx_business_glossary_term' = 'Provider ID');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`outcome` ALTER COLUMN `transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Transaction Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`outcome` ALTER COLUMN `compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Compliance Flag');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`outcome` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`outcome` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`outcome` ALTER COLUMN `downstream_action` SET TAGS ('dbx_business_glossary_term' = 'Downstream Action');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`outcome` ALTER COLUMN `financial_impact_amount` SET TAGS ('dbx_business_glossary_term' = 'Financial Impact Amount');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`outcome` ALTER COLUMN `jurisdiction_state` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction State');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`outcome` ALTER COLUMN `jurisdiction_state` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`outcome` ALTER COLUMN `jurisdiction_state` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`outcome` ALTER COLUMN `member_notification_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Member Notification Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`outcome` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`outcome` ALTER COLUMN `outcome_number` SET TAGS ('dbx_business_glossary_term' = 'Outcome Number');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`outcome` ALTER COLUMN `outcome_status` SET TAGS ('dbx_business_glossary_term' = 'Outcome Status');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`outcome` ALTER COLUMN `outcome_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Outcome Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`outcome` ALTER COLUMN `outcome_type` SET TAGS ('dbx_business_glossary_term' = 'Outcome Type');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`outcome` ALTER COLUMN `provider_notification_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Provider Notification Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`outcome` ALTER COLUMN `reason_code` SET TAGS ('dbx_business_glossary_term' = 'Reason Code');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`outcome` ALTER COLUMN `reason_description` SET TAGS ('dbx_business_glossary_term' = 'Reason Description');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`outcome` ALTER COLUMN `regulatory_body` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Body');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`outcome` ALTER COLUMN `source_system_record_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Record Code');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`outcome` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
