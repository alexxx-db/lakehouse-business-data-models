-- Schema for Domain: subcontractor | Business:  | Version: v2_ecm
-- Generated on: 2026-06-27 00:10:00

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_construction_v1`.`subcontractor` COMMENT 'Subcontractor and specialty trade management domain governing relationships with MEP (Mechanical Electrical Plumbing) contractors, civil works subcontractors, and specialty vendors. Owns subcontractor profiles, prequalification records, trade packages, scope-of-work agreements, insurance compliance certificates, performance scorecards, and payment applications. Distinct from procurement which owns the PO/award process.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_construction_v1`.`subcontractor`.`back_charge` (
    `back_charge_id` BIGINT COMMENT 'Primary key for back_charge',
    `construction_project_id` BIGINT COMMENT 'Reference to the construction project where the back-charge event occurred. Links to the project master record.',
    `cost_account_id` BIGINT COMMENT 'Reference to the cost account or cost code to which this back-charge is allocated for job costing and financial tracking.',
    `payment_certificate_id` BIGINT COMMENT 'Reference to the payment certificate or payment application in which the back-charge deduction was applied. Links to the subcontractor payment record. Nullable if not yet deducted.',
    `hr_employee_id` BIGINT COMMENT 'Reference to the user (project manager, site manager, or contracts administrator) who issued the back-charge notice. Links to the user or team member record.',
    `subcontract_id` BIGINT COMMENT 'Reference to the subcontract agreement under which this back-charge is raised. Links to the subcontract master record.',
    `approval_date` DATE COMMENT 'Date on which the back-charge was formally approved for deduction by the authorized approver. Nullable if not yet approved.',
    `approved_amount` DECIMAL(18,2) COMMENT 'Final approved amount of the back-charge after any dispute resolution or negotiation. May differ from the total claimed amount if partially accepted or negotiated down.',
    `back_charge_number` STRING COMMENT 'Externally visible unique business identifier for the back-charge record, typically formatted per company standards (e.g., BC-2024-001234). Used in correspondence and payment deductions.',
    `back_charge_status` STRING COMMENT 'Current lifecycle status of the back-charge record. Tracks progression from draft through issuance, dispute resolution, approval, and final deduction or closure. [ENUM-REF-CANDIDATE: draft|issued|acknowledged|disputed|under_review|approved|rejected|deducted|closed|cancelled — 10 candidates stripped; promote to reference product]',
    `closure_date` DATE COMMENT 'Date on which the back-charge record was closed, indicating that all financial recovery and dispute resolution activities are complete. Nullable if still open.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this back-charge record was first created in the system. Audit trail field for data governance and compliance.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts in this back-charge record (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `deduction_applied_amount` DECIMAL(18,2) COMMENT 'Actual amount deducted from subcontractor payment certification or final account as a result of this back-charge. Reflects the financial recovery achieved.',
    `deduction_date` DATE COMMENT 'Date on which the back-charge amount was deducted from the subcontractors payment. Nullable if deduction has not yet occurred.',
    `dispute_date` DATE COMMENT 'Date on which the subcontractor formally raised a dispute against the back-charge. Nullable if no dispute was raised.',
    `dispute_flag` BOOLEAN COMMENT 'Boolean indicator of whether the subcontractor has formally disputed this back-charge. True indicates an active or resolved dispute; False indicates acceptance or no dispute raised.',
    `dispute_reason` STRING COMMENT 'Subcontractors stated reason for disputing the back-charge. Captures the basis of disagreement (e.g., work was not defective, damage was pre-existing, cost is excessive, liability is disputed).',
    `equipment_cost_amount` DECIMAL(18,2) COMMENT 'Total equipment cost component of the back-charge, representing the cost of equipment usage (owned or rented) deployed to remedy the subcontractor default.',
    `incident_date` DATE COMMENT 'Date on which the event or condition giving rise to the back-charge occurred (e.g., date of damage, date defective work was discovered, date of cleanup failure).',
    `labor_cost_amount` DECIMAL(18,2) COMMENT 'Total labor cost component of the back-charge, representing the cost of general contractor or third-party labor deployed to remedy the subcontractor default or defect.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this back-charge record was last updated. Audit trail field for data governance and change tracking.',
    `material_cost_amount` DECIMAL(18,2) COMMENT 'Total material cost component of the back-charge, representing the cost of materials consumed to remedy the subcontractor default or replace damaged materials.',
    `ncr_reference_number` STRING COMMENT 'Reference number of the associated Non-Conformance Report (NCR) that documented the quality defect or deficiency giving rise to this back-charge. Nullable if no formal NCR was raised.',
    `notes` STRING COMMENT 'Free-text field for additional notes, comments, or internal observations related to the back-charge. Used for audit trail and knowledge capture.',
    `notification_date` DATE COMMENT 'Date on which the back-charge notice was formally issued to the subcontractor. Establishes the start of the response period per contract terms.',
    `overhead_cost_amount` DECIMAL(18,2) COMMENT 'Overhead and indirect cost component of the back-charge, including administrative costs, supervision, and markup applied per contract terms.',
    `reason_code` STRING COMMENT 'Categorical code identifying the primary reason for the back-charge. Common reasons include rework due to defective work, damage caused to other trades, failure to perform cleanup, schedule delays caused by subcontractor, safety violations, or third-party cost recovery. [ENUM-REF-CANDIDATE: rework|defective_work|damage_to_other_trades|cleanup_failure|schedule_impact|safety_violation|third_party_recovery|warranty_claim|material_waste|equipment_damage — 10 candidates stripped; promote to reference product]',
    `reason_description` STRING COMMENT 'Detailed narrative explanation of the circumstances and events that led to the back-charge. Includes specifics of the subcontractor default, defective work details, or damage caused.',
    `resolution_outcome` STRING COMMENT 'Final outcome of the back-charge after any dispute resolution process. Indicates whether the charge was accepted in full, partially accepted, rejected, settled through negotiation, or resolved via arbitration or litigation. [ENUM-REF-CANDIDATE: accepted_full|accepted_partial|rejected|negotiated_settlement|arbitration_awarded|litigation_settled|withdrawn — 7 candidates stripped; promote to reference product]',
    `response_deadline_date` DATE COMMENT 'Date by which the subcontractor must respond to the back-charge notice, either acknowledging the charge or raising a formal dispute. Typically contractually defined (e.g., 14 days from notification).',
    `site_instruction_number` STRING COMMENT 'Reference number of the site instruction issued to the subcontractor directing remedial action or documenting the default. Nullable if no formal site instruction was issued.',
    `supporting_documentation_path` STRING COMMENT 'File path or document management system reference to supporting documentation for the back-charge (photos, inspection reports, cost breakdowns, correspondence). Typically stored in Aconex or BIM 360 document control.',
    `total_claimed_amount` DECIMAL(18,2) COMMENT 'Total amount claimed in the back-charge, representing the sum of all cost components (labor, material, equipment, overhead) that the general contractor seeks to recover from the subcontractor.',
    CONSTRAINT pk_back_charge PRIMARY KEY(`back_charge_id`)
) COMMENT 'Back-charge records raised against subcontractors for costs incurred by the general contractor due to subcontractor default, defective work, damage to other trades, cleanup failures, or failure to perform contractual obligations. Captures back-charge number, subcontract reference, reason code (rework, damage, cleanup, schedule impact, third-party recovery), cost breakdown (labor, material, equipment), amount claimed, notification date, response deadline, dispute status, resolution outcome, and deduction applied in payment certification. Enables cost recovery tracking and feeds final account reconciliation.';

CREATE OR REPLACE TABLE `vibe_construction_v1`.`subcontractor`.`final_account` (
    `final_account_id` BIGINT COMMENT 'Primary key for final_account',
    `construction_project_id` BIGINT COMMENT 'Reference to the construction project under which this subcontract final account is settled.',
    `hr_employee_id` BIGINT COMMENT 'Foreign key linking to hr.employee. Business justification: Final account preparation is done by an employee; linking supports financial audit and sign‑off records.',
    `subcontract_id` BIGINT COMMENT 'Reference to the parent subcontract for which this final account settlement is being prepared. Links to the subcontract master record.',
    `approval_date` DATE COMMENT 'Date on which the final account was internally approved by the contractor before being presented to the subcontractor for agreement.',
    `approved_by` STRING COMMENT 'Name of the senior manager or project director who approved the final account for signature and settlement.',
    `claims_settled_value` DECIMAL(18,2) COMMENT 'Total value of subcontractor claims (for delays, disruptions, variations, or EOT-related costs) that were agreed and settled as part of the final account.',
    `contractor_signatory_name` STRING COMMENT 'Full name of the authorized representative from the general contractor (GC) who signed the final account settlement.',
    `contractor_signatory_title` STRING COMMENT 'Job title or role of the contractor signatory (e.g., Project Manager, Contracts Manager, Commercial Director).',
    `contractor_signature_date` DATE COMMENT 'Date on which the contractor signatory signed the final account document.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this final account record was first created in the system. Audit trail for record creation.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary values in this final account (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `defects_liability_period_end_date` DATE COMMENT 'The date on which the Defects Liability Period expires. Retention is typically released after this date and any defects are rectified.',
    `dispute_reason` STRING COMMENT 'Description of the reason for dispute if the final account status is disputed. Captures the nature of disagreement (e.g., valuation of variations, back-charge validity, claim rejection).',
    `dispute_resolution_date` DATE COMMENT 'Date on which the dispute was formally resolved and the final account was agreed, if initially disputed.',
    `dispute_resolution_method` STRING COMMENT 'The method being used or planned to resolve the final account dispute, if applicable. Aligns with contract dispute resolution clauses.. Valid values are `negotiation|mediation|arbitration|litigation|adjudication|none`',
    `document_reference` STRING COMMENT 'Reference to the physical or digital final account settlement document stored in the document management system (e.g., Aconex document ID).',
    `final_account_number` STRING COMMENT 'Business identifier for the final account settlement document. Typically follows organizational numbering convention (e.g., FA-2024-001234).',
    `final_account_status` STRING COMMENT 'Current lifecycle status of the final account settlement. Tracks progression from draft through agreement to closure or dispute resolution.. Valid values are `draft|under_review|agreed|disputed|closed|cancelled`',
    `final_agreed_value` DECIMAL(18,2) COMMENT 'The final settled contract value after all adjustments: original value plus approved COs plus claims minus back-charges minus LDs plus retention released. Represents the total financial close-out amount.',
    `final_payment_due_date` DATE COMMENT 'The contractual due date by which the final agreed value must be paid to the subcontractor. Typically defined in payment terms.',
    `final_payment_made_date` DATE COMMENT 'Actual date on which the final payment was made to the subcontractor. Confirms financial closure.',
    `final_payment_reference` STRING COMMENT 'Payment transaction reference or remittance advice number for the final payment. Links to accounts payable records.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this final account record was last updated. Audit trail for record modifications.',
    `liquidated_damages_deducted` DECIMAL(18,2) COMMENT 'Total liquidated damages deducted from the final account for delays or non-performance as per the subcontract terms.',
    `original_contract_value` DECIMAL(18,2) COMMENT 'The initial awarded subcontract value before any change orders, variations, or adjustments. Baseline financial commitment.',
    `performance_bond_release_date` DATE COMMENT 'Date on which the performance bond was formally released to the subcontractor or their surety.',
    `performance_bond_released` BOOLEAN COMMENT 'Indicates whether the subcontractor performance bond or guarantee has been released as part of the final account settlement. True if released, False if still held.',
    `remarks` STRING COMMENT 'Free-text field for additional notes, comments, or special conditions related to the final account settlement. Captures context not covered by structured fields.',
    `retention_released` DECIMAL(18,2) COMMENT 'Total retention amount released to the subcontractor upon satisfactory completion and expiry of the Defects Liability Period (DLP). Typically 5-10% of contract value.',
    `settlement_date` DATE COMMENT 'The date on which the final account was formally agreed and signed by both parties. Marks the financial close-out milestone.',
    `subcontractor_signatory_name` STRING COMMENT 'Full name of the authorized representative from the subcontractor who signed the final account settlement.',
    `subcontractor_signatory_title` STRING COMMENT 'Job title or role of the subcontractor signatory (e.g., Managing Director, Commercial Manager, Project Director).',
    `subcontractor_signature_date` DATE COMMENT 'Date on which the subcontractor signatory signed the final account document.',
    `total_approved_change_orders` DECIMAL(18,2) COMMENT 'Cumulative value of all approved change orders that increased or decreased the subcontract scope and value. Sum of all CO amounts.',
    `total_back_charges` DECIMAL(18,2) COMMENT 'Cumulative value of all back-charges levied against the subcontractor for defects, delays, rework, or other contractual breaches. Reduces final payment.',
    CONSTRAINT pk_final_account PRIMARY KEY(`final_account_id`)
) COMMENT 'Final account settlement records for completed subcontracts, capturing the agreed final contract value after all change orders, back-charges, retention releases, and claims are resolved. Tracks original contract value, total approved change orders, total back-charges, final agreed value, settlement date, signatory details, and final account status (draft, agreed, disputed, closed). Represents the financial close-out milestone for each subcontract.';

CREATE OR REPLACE TABLE `vibe_construction_v1`.`subcontractor`.`performance_scorecard` (
    `performance_scorecard_id` BIGINT COMMENT 'Primary key for performance_scorecard.',
    `agreement_id` BIGINT COMMENT 'Foreign key linking to contract.agreement. Business justification: Performance Scorecard evaluates subcontractor against a specific contract agreement, needing agreement_id to associate scores with that contract.',
    `construction_project_id` BIGINT COMMENT 'Reference to the construction project for which this subcontractor performance is being evaluated.',
    `hr_employee_id` BIGINT COMMENT 'Foreign key linking to hr.employee. Business justification: Scorecard evaluations are conducted by a specific employee; linking enables traceability and performance analytics.',
    `firm_profile_id` BIGINT COMMENT 'Reference to the subcontractor being evaluated in this performance scorecard.',
    `esg_report_id` BIGINT COMMENT 'Foreign key linking to sustainability.esg_report. Business justification: Scorecards evaluate subcontractor performance against ESG metrics; storing the ESG report used for assessment enables traceability.',
    `vendor_id` BIGINT COMMENT '',
    `approval_date` DATE COMMENT 'Date on which the performance scorecard was formally approved by authorized management.',
    `approval_status` STRING COMMENT 'Current approval workflow status of the performance scorecard document.. Valid values are `draft|submitted|approved|rejected`',
    `approved_by` STRING COMMENT 'Name of the senior manager or PMO director who approved the final performance scorecard.',
    `bid_eligibility_status` STRING COMMENT 'Current bid eligibility status resulting from this performance evaluation: eligible for all future bids, restricted to certain project types, or ineligible for future bidding.. Valid values are `eligible|restricted|ineligible`',
    `change_order_disputes` STRING COMMENT 'Number of disputed or contested change orders raised by or against the subcontractor during the evaluation period.',
    `commercial_conduct_score` DECIMAL(18,2) COMMENT 'Numeric score (0-100) representing the subcontractors commercial conduct including responsiveness to instructions, cooperation, documentation quality, and change order management.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this performance scorecard record was first created in the system.',
    `evaluation_date` DATE COMMENT 'The date on which the performance scorecard assessment was completed and recorded.',
    `evaluation_period` STRING COMMENT '',
    `evaluation_period_end_date` DATE COMMENT 'The end date of the performance evaluation period for this scorecard.',
    `evaluation_period_start_date` DATE COMMENT 'The start date of the performance evaluation period for this scorecard.',
    `evaluator_comments` STRING COMMENT 'Free-text comments and observations from the evaluator providing additional context, specific incidents, or qualitative assessment details.',
    `evaluator_role` STRING COMMENT 'The role or title of the person who conducted the evaluation (e.g., Project Manager, Construction Manager, PMO Director).',
    `follow_up_due_date` DATE COMMENT 'Target date by which follow-up actions or corrective measures must be completed and reviewed.',
    `follow_up_required` BOOLEAN COMMENT 'Boolean flag indicating whether follow-up actions, meetings, or corrective action plans are required based on this performance evaluation.',
    `hse_compliance_violations` STRING COMMENT 'Number of HSE compliance violations or safety infractions recorded during the evaluation period.',
    `hse_lti_count` STRING COMMENT 'Total number of Lost Time Injuries recorded for the subcontractors workforce during the evaluation period.',
    `hse_score` DECIMAL(18,2) COMMENT 'Numeric score (0-100) representing the subcontractors overall HSE compliance and safety performance during the evaluation period.',
    `hse_trir` DECIMAL(18,2) COMMENT 'Total Recordable Incident Rate calculated as (Number of OSHA recordable incidents × 200,000) / Total hours worked. Industry standard HSE metric.',
    `improvement_areas` STRING COMMENT 'Detailed description of specific areas where the subcontractor needs to improve performance, including corrective actions required.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this performance scorecard record was last updated or modified.',
    `overall_rating` STRING COMMENT 'Overall categorical performance rating summarizing the subcontractors performance across all evaluation dimensions.. Valid values are `outstanding|exceeds_expectations|meets_expectations|needs_improvement|unsatisfactory`',
    `overall_score` DECIMAL(18,2) COMMENT 'Weighted overall performance score (0-100) calculated from individual category scores (schedule, quality, HSE, productivity, commercial conduct).',
    `prequalification_impact` STRING COMMENT 'Impact of this performance scorecard on the subcontractors prequalification status for future projects: automatic renewal, conditional renewal, requires detailed review, or disqualification.. Valid values are `renew|conditional_renewal|review_required|disqualify`',
    `productivity_rate` DECIMAL(18,2) COMMENT 'Productivity rate measured as units completed per labor hour or per day during the evaluation period.',
    `productivity_score` DECIMAL(18,2) COMMENT 'Numeric score (0-100) representing the subcontractors productivity and efficiency in completing assigned work during the evaluation period.',
    `productivity_units_completed` DECIMAL(18,2) COMMENT 'Total quantity of work units completed by the subcontractor during the evaluation period (e.g., cubic meters of concrete, linear meters of pipe, square meters of formwork).',
    `quality_ncr_count` STRING COMMENT 'Total number of Non-Conformance Reports issued against the subcontractor during the evaluation period.',
    `quality_ncr_rate` DECIMAL(18,2) COMMENT 'Rate of Non-Conformance Reports per unit of work completed (e.g., NCRs per 1000 work hours or per million dollars of work).',
    `quality_score` DECIMAL(18,2) COMMENT 'Numeric score (0-100) representing the subcontractors overall quality conformance and workmanship during the evaluation period.',
    `recommended_action` STRING COMMENT 'Recommended action based on the performance evaluation outcome: continue engagement, monitor closely, require improvement plan, place on watch-list, disqualify from future bids, or suspend from current work.. Valid values are `continue|monitor|improve|watch_list|disqualify|suspend`',
    `rfi_response_timeliness_score` DECIMAL(18,2) COMMENT 'Score (0-100) measuring the subcontractors timeliness in responding to RFIs and providing requested information.',
    `safety_score` DECIMAL(18,2) COMMENT '',
    `schedule_adherence_spi` DECIMAL(18,2) COMMENT 'Schedule Performance Index measuring the subcontractors adherence to planned schedule. SPI = Earned Value / Planned Value. Values >1.0 indicate ahead of schedule, <1.0 indicate behind schedule.',
    `schedule_score` DECIMAL(18,2) COMMENT 'Numeric score (0-100) representing the subcontractors overall schedule performance during the evaluation period.',
    `scorecard_status` STRING COMMENT '',
    `strengths` STRING COMMENT 'Description of the subcontractors key strengths and positive performance aspects observed during the evaluation period.',
    `subcontractor_acknowledgement_date` DATE COMMENT 'Date on which the subcontractor acknowledged receipt and review of the performance scorecard.',
    `subcontractor_response` STRING COMMENT 'Subcontractors formal response or comments regarding the performance evaluation, including any disputes or corrective action commitments.',
    `updated_timestamp` TIMESTAMP COMMENT '',
    CONSTRAINT pk_performance_scorecard PRIMARY KEY(`performance_scorecard_id`)
) COMMENT 'Required product subcontractor.performance_scorecard ensured by structure enforcement.';

CREATE OR REPLACE TABLE `vibe_construction_v1`.`subcontractor`.`sub_time_extension` (
    `sub_time_extension_id` BIGINT COMMENT 'Primary key for eot_claim',
    `construction_project_id` BIGINT COMMENT 'Reference to the construction project affected by this EOT claim.',
    `prime_eot_claim_id` BIGINT COMMENT 'SSOT reference to canonical contract.contract_eot_claim (single source of truth).',
    `schedule_impact_claim_id` BIGINT COMMENT 'SSOT reference to canonical schedule.schedule_eot_claim (single source of truth).',
    `subcontract_id` BIGINT COMMENT 'Reference to the parent subcontract agreement under which this EOT claim is submitted.',
    `hr_employee_id` BIGINT COMMENT 'Foreign key linking to hr.employee. Business justification: EOT claim submission is logged by the employee who files it; required for claim processing workflow.',
    `assessed_by` STRING COMMENT 'Name and role of the project team member or consultant who conducted the technical assessment of the EOT claim.',
    `baseline_schedule_reference` STRING COMMENT 'Reference identifier for the approved baseline schedule used as the basis for delay analysis and EOT assessment.',
    `claim_reference_number` STRING COMMENT 'Externally-known unique reference number assigned to this EOT claim for tracking and correspondence purposes.. Valid values are `^EOT-[A-Z0-9]{6,20}$`',
    `claim_status` STRING COMMENT 'Current lifecycle status of the EOT claim in the review and determination workflow. [ENUM-REF-CANDIDATE: draft|submitted|under_review|assessed|approved|rejected|withdrawn — 7 candidates stripped; promote to reference product]',
    `claim_submission_method` STRING COMMENT 'Method or channel through which the subcontractor submitted the EOT claim to the main contractor.. Valid values are `electronic_portal|email|registered_mail|hand_delivery|courier`',
    `concurrent_delay_flag` BOOLEAN COMMENT 'Indicates whether the delay event occurred concurrently with other delays for which the subcontractor is responsible, affecting EOT entitlement.',
    `contemporaneous_records_reference` STRING COMMENT 'Reference identifiers or document numbers for contemporaneous project records (daily logs, progress reports, site instructions, correspondence) supporting the EOT claim.',
    `cost_claim_associated_flag` BOOLEAN COMMENT 'Indicates whether the subcontractor has submitted or intends to submit a separate cost claim for prolongation costs associated with this delay event.',
    `critical_path_impact_flag` BOOLEAN COMMENT 'Indicates whether the delay event impacted activities on the project critical path, a key determinant of EOT entitlement.',
    `days_assessed` STRING COMMENT 'Number of calendar days of schedule extension determined by the project management team or contract administrator during the assessment process.',
    `days_claimed` STRING COMMENT 'Number of calendar days of schedule extension requested by the subcontractor in the EOT claim submission.',
    `days_granted` STRING COMMENT 'Number of calendar days of schedule extension formally approved and granted to the subcontractor, adjusting the contractual completion date.',
    `delay_cause_category` STRING COMMENT 'Classification of the root cause of the delay event determining entitlement and risk allocation under the subcontract terms.. Valid values are `employer_risk|force_majeure|concurrent_delay|adverse_weather|design_change|variation_order`',
    `delay_end_date` DATE COMMENT 'Date when the delay event ceased or was resolved, allowing work to resume on the affected activities.',
    `delay_event_description` STRING COMMENT 'Detailed narrative description of the delay event or circumstances that form the basis of the EOT claim, including impact on critical path activities.',
    `delay_start_date` DATE COMMENT 'Date when the delay event commenced and began impacting the subcontractors ability to meet contractual completion dates.',
    `determination_authority` STRING COMMENT 'Name and role of the individual or entity authorized to make the determination decision on the EOT claim (e.g., Project Manager, Contract Administrator, Engineer).',
    `determination_date` DATE COMMENT 'Date when the contract administrator or project management office issued the formal determination decision on the EOT claim.',
    `determination_rationale` STRING COMMENT 'Detailed explanation and justification for the determination decision, including reasons for any variance between days claimed and days granted.',
    `dispute_status` STRING COMMENT 'Current status of any dispute arising from disagreement over the EOT claim determination.. Valid values are `no_dispute|under_negotiation|mediation|arbitration|litigation|resolved`',
    `ld_exposure_impact` STRING COMMENT 'Assessment of how the granted EOT affects the subcontractors exposure to liquidated damages for late completion.. Valid values are `eliminates_ld_exposure|reduces_ld_exposure|no_impact_on_ld|increases_ld_exposure`',
    `notice_compliance_flag` BOOLEAN COMMENT 'Indicates whether the subcontractor complied with contractual notice requirements and timelines, which may affect claim entitlement.',
    `notice_date` DATE COMMENT 'Date when the subcontractor provided initial notice of the delay event to the main contractor, as required by contract notice provisions.',
    `original_completion_date` DATE COMMENT 'Contractual completion date for the subcontract scope of work prior to any EOT adjustments.',
    `record_created_timestamp` TIMESTAMP COMMENT 'Timestamp when this EOT claim record was first created in the system.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this EOT claim record was last modified in the system.',
    `revised_completion_date` DATE COMMENT 'Adjusted contractual completion date after granting the EOT, calculated by adding granted days to the original or previously revised completion date.',
    `schedule_analysis_method` STRING COMMENT 'Methodology used to analyze the delay impact and quantify the time extension, following industry-standard delay analysis protocols.. Valid values are `time_impact_analysis|windows_analysis|as_planned_vs_as_built|collapsed_as_built|contemporaneous_period_analysis`',
    `submission_date` DATE COMMENT 'Date when the subcontractor formally submitted the EOT claim to the main contractor or project management office.',
    `supporting_documentation_count` STRING COMMENT 'Number of supporting documents (schedules, correspondence, photos, reports) attached to the EOT claim submission.',
    CONSTRAINT pk_sub_time_extension PRIMARY KEY(`sub_time_extension_id`)
) COMMENT 'Extension of Time (EOT) claims submitted by subcontractors seeking schedule relief from contractual completion dates due to excusable delay events. Captures claim reference, subcontract reference, delay event description, cause category (employer risk, force majeure, concurrent delay, weather, design change), days claimed, days assessed, days granted, contemporaneous records references, determination date, determination authority, and impact on liquidated damages exposure. Links to schedule domain for programme impact analysis. [SSOT: distinct source of truth for subcontractor domain]';

CREATE OR REPLACE TABLE `vibe_construction_v1`.`subcontractor`.`sub_change_order` (
    `sub_change_order_id` BIGINT COMMENT 'Unique identifier for the subcontractor change order record. Primary key.',
    `construction_project_id` BIGINT COMMENT 'Reference to the construction project under which this subcontractor change order is issued.',
    `commercial_change_order_id` BIGINT COMMENT 'Reference to the head contract change order that triggered or is linked to this subcontractor change order, where applicable.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Allocates change order costs to the responsible cost center for accurate cost‑center reporting.',
    `cost_code_id` BIGINT COMMENT 'Foreign key linking to finance.cost_code. Business justification: Links change orders to cost codes to capture cost accounting impacts of contract modifications.',
    `hr_employee_id` BIGINT COMMENT 'Foreign key linking to hr.employee. Business justification: Change Order Initiation is recorded by the employee who raises it; required for audit trail and approval workflow.',
    `project_change_order_id` BIGINT COMMENT 'SSOT reference to canonical project.project_change_order (single source of truth).',
    `subcontract_id` BIGINT COMMENT 'Reference to the parent subcontract agreement that this change order modifies.',
    `wbs_element_id` BIGINT COMMENT 'Reference to the WBS element under which this change order scope is organized and tracked.',
    `approval_date` DATE COMMENT 'The date on which the change order was formally approved by the approving authority, in yyyy-MM-dd format. Null if not yet approved.',
    `approval_status` STRING COMMENT 'Current lifecycle status of the change order in the approval workflow: draft, submitted, under review, approved, rejected, or withdrawn.. Valid values are `draft|submitted|under_review|approved|rejected|withdrawn`',
    `approving_authority` STRING COMMENT 'Name or title of the individual or role who approved the change order (e.g., Project Manager, Contracts Manager, Client Representative).',
    `change_amount` DECIMAL(18,2) COMMENT 'The net financial impact of this change order on the subcontract value. Positive for additions, negative for reductions, in the contract currency.',
    `change_type` STRING COMMENT 'Classification of the change order by its primary impact: scope addition, scope reduction, acceleration, schedule extension (EOT), rate adjustment, or other.. Valid values are `scope_addition|scope_reduction|acceleration|schedule_extension|rate_adjustment|other`',
    `co_description` STRING COMMENT 'Detailed narrative describing the scope, rationale, and impact of the change order on the subcontract.',
    `co_number` STRING COMMENT 'The externally-known business identifier for this subcontractor change order, typically formatted per project numbering conventions.',
    `co_title` STRING COMMENT 'Short descriptive title summarizing the nature of the change order.',
    `contingency_allocation` DECIMAL(18,2) COMMENT 'Amount of project contingency budget allocated to cover this change order, in the contract currency. Null if not funded from contingency.',
    `cost_code` STRING COMMENT 'Project cost code or cost account to which the change order financial impact is allocated for job costing and financial tracking.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this change order record was first created in the system, in yyyy-MM-ddTHH:mm:ss.SSSXXX format.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary values in this change order.. Valid values are `^[A-Z]{3}$`',
    `document_reference` STRING COMMENT 'Reference number or identifier of the formal change order document, drawing, or specification that supports this change order.',
    `execution_completion_date` DATE COMMENT 'The date on which work on the change order scope was completed on site, in yyyy-MM-dd format. Null if not yet completed.',
    `execution_start_date` DATE COMMENT 'The date on which work on the change order scope commenced on site, in yyyy-MM-dd format. Null if not yet started.',
    `execution_status` STRING COMMENT 'Current status of the physical execution of the change order work: not started, in progress, completed, or on hold.. Valid values are `not_started|in_progress|completed|on_hold`',
    `is_back_charge` BOOLEAN COMMENT 'Boolean flag indicating whether this change order represents a back charge to the subcontractor for defective work, delays, or other contractual breaches. True if back charge, False otherwise.',
    `is_time_and_material` BOOLEAN COMMENT 'Boolean flag indicating whether this change order is priced on a time-and-material basis rather than lump sum. True if T&M, False otherwise.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this change order record was last updated in the system, in yyyy-MM-ddTHH:mm:ss.SSSXXX format.',
    `notes` STRING COMMENT 'Free-text field for additional comments, clarifications, or internal notes related to the change order.',
    `original_completion_date` DATE COMMENT 'The subcontract completion date before this change order is applied, in yyyy-MM-dd format.',
    `original_contract_value` DECIMAL(18,2) COMMENT 'The baseline subcontract value before this change order is applied, in the contract currency.',
    `reason_code` STRING COMMENT 'Standardized code indicating the root cause or reason for issuing the change order: design change, unforeseen site condition, client request, regulatory requirement, error or omission, force majeure, or other.. Valid values are `design_change|site_condition|client_request|regulatory_requirement|error_omission|force_majeure`',
    `reason_description` STRING COMMENT 'Detailed explanation of the circumstances and justification for the change order.',
    `rejection_reason` STRING COMMENT 'Explanation provided when the change order is rejected, detailing the grounds for rejection. Null if not rejected.',
    `revised_completion_date` DATE COMMENT 'The updated subcontract completion date after applying this change order, in yyyy-MM-dd format.',
    `revised_contract_value` DECIMAL(18,2) COMMENT 'The updated subcontract value after applying this change order, calculated as original contract value plus change amount, in the contract currency.',
    `schedule_impact_days` STRING COMMENT 'Number of calendar days by which the subcontract completion date is extended (positive) or accelerated (negative) as a result of this change order. Zero if no schedule impact.',
    `submission_date` DATE COMMENT 'The date on which the change order was formally submitted for review and approval, in yyyy-MM-dd format.',
    `trade_package` STRING COMMENT 'The trade or specialty package to which this change order applies (e.g., MEP, civil works, structural steel, concrete, finishes).',
    CONSTRAINT pk_sub_change_order PRIMARY KEY(`sub_change_order_id`)
) COMMENT 'Change order records issued to subcontractors modifying the original subcontract scope, value, or schedule. Captures CO number, change type (scope addition, scope reduction, acceleration, EOT), reason code, original contract value, change amount, revised contract value, submission date, approval status, approving authority, and linkage to the head contract CO where applicable. Tracks the full change order lifecycle from initiation through execution. [SSOT: distinct source of truth for subcontractor domain]';

-- ========= TAGS =========
ALTER SCHEMA `vibe_construction_v1`.`subcontractor` SET TAGS ('pii_division' = 'business');
ALTER SCHEMA `vibe_construction_v1`.`subcontractor` SET TAGS ('pii_domain' = 'subcontractor');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`back_charge` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`back_charge` SET TAGS ('pii_subdomain' = 'financial_settlement');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`back_charge` SET TAGS ('pii_required_structure' = 'v2');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`back_charge` SET TAGS ('pii_ecm_structure' = 'preserved_v2');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`back_charge` SET TAGS ('pii_structure_required' = 'true');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`back_charge` ALTER COLUMN `back_charge_id` SET TAGS ('pii_business_glossary_term' = 'Back Charge Identifier');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`back_charge` ALTER COLUMN `construction_project_id` SET TAGS ('pii_business_glossary_term' = 'Construction Project Identifier (ID)');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`back_charge` ALTER COLUMN `cost_account_id` SET TAGS ('pii_business_glossary_term' = 'Cost Account Identifier (ID)');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`back_charge` ALTER COLUMN `payment_certificate_id` SET TAGS ('pii_business_glossary_term' = 'Payment Certificate Identifier (ID)');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`back_charge` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_business_glossary_term' = 'Issued By User Identifier (ID)');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`back_charge` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`back_charge` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`back_charge` ALTER COLUMN `subcontract_id` SET TAGS ('pii_business_glossary_term' = 'Subcontract Identifier (ID)');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`back_charge` ALTER COLUMN `approval_date` SET TAGS ('pii_business_glossary_term' = 'Back-Charge Approval Date');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`back_charge` ALTER COLUMN `approved_amount` SET TAGS ('pii_business_glossary_term' = 'Back-Charge Approved Amount');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`back_charge` ALTER COLUMN `back_charge_number` SET TAGS ('pii_business_glossary_term' = 'Back-Charge Number');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`back_charge` ALTER COLUMN `back_charge_status` SET TAGS ('pii_business_glossary_term' = 'Back-Charge Status');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`back_charge` ALTER COLUMN `closure_date` SET TAGS ('pii_business_glossary_term' = 'Back-Charge Closure Date');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`back_charge` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`back_charge` ALTER COLUMN `currency_code` SET TAGS ('pii_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`back_charge` ALTER COLUMN `currency_code` SET TAGS ('pii_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`back_charge` ALTER COLUMN `deduction_applied_amount` SET TAGS ('pii_business_glossary_term' = 'Back-Charge Deduction Applied Amount');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`back_charge` ALTER COLUMN `deduction_date` SET TAGS ('pii_business_glossary_term' = 'Back-Charge Deduction Date');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`back_charge` ALTER COLUMN `dispute_date` SET TAGS ('pii_business_glossary_term' = 'Back-Charge Dispute Date');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`back_charge` ALTER COLUMN `dispute_flag` SET TAGS ('pii_business_glossary_term' = 'Back-Charge Dispute Flag');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`back_charge` ALTER COLUMN `dispute_reason` SET TAGS ('pii_business_glossary_term' = 'Back-Charge Dispute Reason');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`back_charge` ALTER COLUMN `equipment_cost_amount` SET TAGS ('pii_business_glossary_term' = 'Back-Charge Equipment Cost Amount');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`back_charge` ALTER COLUMN `incident_date` SET TAGS ('pii_business_glossary_term' = 'Back-Charge Incident Date');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`back_charge` ALTER COLUMN `labor_cost_amount` SET TAGS ('pii_business_glossary_term' = 'Back-Charge Labor Cost Amount');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`back_charge` ALTER COLUMN `last_modified_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`back_charge` ALTER COLUMN `material_cost_amount` SET TAGS ('pii_business_glossary_term' = 'Back-Charge Material Cost Amount');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`back_charge` ALTER COLUMN `ncr_reference_number` SET TAGS ('pii_business_glossary_term' = 'Non-Conformance Report (NCR) Reference Number');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`back_charge` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Back-Charge Notes');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`back_charge` ALTER COLUMN `notification_date` SET TAGS ('pii_business_glossary_term' = 'Back-Charge Notification Date');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`back_charge` ALTER COLUMN `overhead_cost_amount` SET TAGS ('pii_business_glossary_term' = 'Back-Charge Overhead Cost Amount');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`back_charge` ALTER COLUMN `reason_code` SET TAGS ('pii_business_glossary_term' = 'Back-Charge Reason Code');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`back_charge` ALTER COLUMN `reason_description` SET TAGS ('pii_business_glossary_term' = 'Back-Charge Reason Description');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`back_charge` ALTER COLUMN `resolution_outcome` SET TAGS ('pii_business_glossary_term' = 'Back-Charge Resolution Outcome');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`back_charge` ALTER COLUMN `response_deadline_date` SET TAGS ('pii_business_glossary_term' = 'Back-Charge Response Deadline Date');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`back_charge` ALTER COLUMN `site_instruction_number` SET TAGS ('pii_business_glossary_term' = 'Site Instruction Number');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`back_charge` ALTER COLUMN `supporting_documentation_path` SET TAGS ('pii_business_glossary_term' = 'Supporting Documentation Path');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`back_charge` ALTER COLUMN `total_claimed_amount` SET TAGS ('pii_business_glossary_term' = 'Total Back-Charge Claimed Amount');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`final_account` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`final_account` SET TAGS ('pii_subdomain' = 'financial_settlement');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`final_account` SET TAGS ('pii_required_structure' = 'v2');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`final_account` SET TAGS ('pii_ecm_structure' = 'preserved_v2');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`final_account` SET TAGS ('pii_structure_required' = 'true');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`final_account` ALTER COLUMN `final_account_id` SET TAGS ('pii_business_glossary_term' = 'Final Account Identifier');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`final_account` ALTER COLUMN `construction_project_id` SET TAGS ('pii_business_glossary_term' = 'Construction Project ID');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`final_account` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_business_glossary_term' = 'Prepared By Employee Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`final_account` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`final_account` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`final_account` ALTER COLUMN `subcontract_id` SET TAGS ('pii_business_glossary_term' = 'Subcontract ID');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`final_account` ALTER COLUMN `approval_date` SET TAGS ('pii_business_glossary_term' = 'Final Account Approval Date');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`final_account` ALTER COLUMN `approved_by` SET TAGS ('pii_business_glossary_term' = 'Final Account Approved By');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`final_account` ALTER COLUMN `claims_settled_value` SET TAGS ('pii_business_glossary_term' = 'Claims Settled Value');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`final_account` ALTER COLUMN `contractor_signatory_name` SET TAGS ('pii_business_glossary_term' = 'Contractor Signatory Name');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`final_account` ALTER COLUMN `contractor_signatory_title` SET TAGS ('pii_business_glossary_term' = 'Contractor Signatory Title');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`final_account` ALTER COLUMN `contractor_signature_date` SET TAGS ('pii_business_glossary_term' = 'Contractor Signature Date');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`final_account` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`final_account` ALTER COLUMN `currency_code` SET TAGS ('pii_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`final_account` ALTER COLUMN `currency_code` SET TAGS ('pii_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`final_account` ALTER COLUMN `defects_liability_period_end_date` SET TAGS ('pii_business_glossary_term' = 'Defects Liability Period (DLP) End Date');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`final_account` ALTER COLUMN `dispute_reason` SET TAGS ('pii_business_glossary_term' = 'Dispute Reason');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`final_account` ALTER COLUMN `dispute_resolution_date` SET TAGS ('pii_business_glossary_term' = 'Dispute Resolution Date');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`final_account` ALTER COLUMN `dispute_resolution_method` SET TAGS ('pii_business_glossary_term' = 'Dispute Resolution Method');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`final_account` ALTER COLUMN `dispute_resolution_method` SET TAGS ('pii_value_regex' = 'negotiation|mediation|arbitration|litigation|adjudication|none');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`final_account` ALTER COLUMN `document_reference` SET TAGS ('pii_business_glossary_term' = 'Final Account Document Reference');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`final_account` ALTER COLUMN `final_account_number` SET TAGS ('pii_business_glossary_term' = 'Final Account Number');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`final_account` ALTER COLUMN `final_account_number` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`final_account` ALTER COLUMN `final_account_number` SET TAGS ('pii_financial' = 'true');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`final_account` ALTER COLUMN `final_account_status` SET TAGS ('pii_business_glossary_term' = 'Final Account Status');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`final_account` ALTER COLUMN `final_account_status` SET TAGS ('pii_value_regex' = 'draft|under_review|agreed|disputed|closed|cancelled');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`final_account` ALTER COLUMN `final_agreed_value` SET TAGS ('pii_business_glossary_term' = 'Final Agreed Value');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`final_account` ALTER COLUMN `final_payment_due_date` SET TAGS ('pii_business_glossary_term' = 'Final Payment Due Date');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`final_account` ALTER COLUMN `final_payment_made_date` SET TAGS ('pii_business_glossary_term' = 'Final Payment Made Date');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`final_account` ALTER COLUMN `final_payment_reference` SET TAGS ('pii_business_glossary_term' = 'Final Payment Reference');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`final_account` ALTER COLUMN `last_modified_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`final_account` ALTER COLUMN `liquidated_damages_deducted` SET TAGS ('pii_business_glossary_term' = 'Liquidated Damages (LD) Deducted');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`final_account` ALTER COLUMN `original_contract_value` SET TAGS ('pii_business_glossary_term' = 'Original Contract Value');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`final_account` ALTER COLUMN `performance_bond_release_date` SET TAGS ('pii_business_glossary_term' = 'Performance Bond Release Date');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`final_account` ALTER COLUMN `performance_bond_released` SET TAGS ('pii_business_glossary_term' = 'Performance Bond Released');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`final_account` ALTER COLUMN `remarks` SET TAGS ('pii_business_glossary_term' = 'Final Account Remarks');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`final_account` ALTER COLUMN `retention_released` SET TAGS ('pii_business_glossary_term' = 'Retention Released');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`final_account` ALTER COLUMN `settlement_date` SET TAGS ('pii_business_glossary_term' = 'Settlement Date');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`final_account` ALTER COLUMN `subcontractor_signatory_name` SET TAGS ('pii_business_glossary_term' = 'Subcontractor Signatory Name');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`final_account` ALTER COLUMN `subcontractor_signatory_title` SET TAGS ('pii_business_glossary_term' = 'Subcontractor Signatory Title');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`final_account` ALTER COLUMN `subcontractor_signature_date` SET TAGS ('pii_business_glossary_term' = 'Subcontractor Signature Date');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`final_account` ALTER COLUMN `total_approved_change_orders` SET TAGS ('pii_business_glossary_term' = 'Total Approved Change Orders (CO)');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`final_account` ALTER COLUMN `total_back_charges` SET TAGS ('pii_business_glossary_term' = 'Total Back-Charges');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`performance_scorecard` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`performance_scorecard` SET TAGS ('pii_subdomain' = 'performance_administration');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`performance_scorecard` ALTER COLUMN `performance_scorecard_id` SET TAGS ('pii_business_glossary_term' = 'Performance Scorecard Id');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`performance_scorecard` ALTER COLUMN `agreement_id` SET TAGS ('pii_business_glossary_term' = 'Agreement Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`performance_scorecard` ALTER COLUMN `construction_project_id` SET TAGS ('pii_business_glossary_term' = 'Construction Project ID');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`performance_scorecard` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_business_glossary_term' = 'Evaluator Employee Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`performance_scorecard` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`performance_scorecard` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`performance_scorecard` ALTER COLUMN `firm_profile_id` SET TAGS ('pii_business_glossary_term' = 'Subcontractor ID');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`performance_scorecard` ALTER COLUMN `esg_report_id` SET TAGS ('pii_business_glossary_term' = 'Performance Esg Report Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`performance_scorecard` ALTER COLUMN `vendor_id` SET TAGS ('pii_business_glossary_term' = 'Vendor Id');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`performance_scorecard` ALTER COLUMN `approval_date` SET TAGS ('pii_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`performance_scorecard` ALTER COLUMN `approval_status` SET TAGS ('pii_business_glossary_term' = 'Approval Status');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`performance_scorecard` ALTER COLUMN `approval_status` SET TAGS ('pii_value_regex' = 'draft|submitted|approved|rejected');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`performance_scorecard` ALTER COLUMN `approved_by` SET TAGS ('pii_business_glossary_term' = 'Approved By');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`performance_scorecard` ALTER COLUMN `bid_eligibility_status` SET TAGS ('pii_business_glossary_term' = 'Bid Eligibility Status');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`performance_scorecard` ALTER COLUMN `bid_eligibility_status` SET TAGS ('pii_value_regex' = 'eligible|restricted|ineligible');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`performance_scorecard` ALTER COLUMN `change_order_disputes` SET TAGS ('pii_business_glossary_term' = 'Change Order (CO) Disputes');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`performance_scorecard` ALTER COLUMN `commercial_conduct_score` SET TAGS ('pii_business_glossary_term' = 'Commercial Conduct Score');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`performance_scorecard` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`performance_scorecard` ALTER COLUMN `evaluation_date` SET TAGS ('pii_business_glossary_term' = 'Evaluation Date');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`performance_scorecard` ALTER COLUMN `evaluation_period` SET TAGS ('pii_business_glossary_term' = 'Evaluation Period');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`performance_scorecard` ALTER COLUMN `evaluation_period_end_date` SET TAGS ('pii_business_glossary_term' = 'Evaluation Period End Date');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`performance_scorecard` ALTER COLUMN `evaluation_period_start_date` SET TAGS ('pii_business_glossary_term' = 'Evaluation Period Start Date');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`performance_scorecard` ALTER COLUMN `evaluator_comments` SET TAGS ('pii_business_glossary_term' = 'Evaluator Comments');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`performance_scorecard` ALTER COLUMN `evaluator_role` SET TAGS ('pii_business_glossary_term' = 'Evaluator Role');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`performance_scorecard` ALTER COLUMN `follow_up_due_date` SET TAGS ('pii_business_glossary_term' = 'Follow-Up Due Date');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`performance_scorecard` ALTER COLUMN `follow_up_required` SET TAGS ('pii_business_glossary_term' = 'Follow-Up Required Flag');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`performance_scorecard` ALTER COLUMN `hse_compliance_violations` SET TAGS ('pii_business_glossary_term' = 'Health Safety and Environment (HSE) Compliance Violations');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`performance_scorecard` ALTER COLUMN `hse_lti_count` SET TAGS ('pii_business_glossary_term' = 'Lost Time Injury (LTI) Count');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`performance_scorecard` ALTER COLUMN `hse_score` SET TAGS ('pii_business_glossary_term' = 'Health Safety and Environment (HSE) Performance Score');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`performance_scorecard` ALTER COLUMN `hse_trir` SET TAGS ('pii_business_glossary_term' = 'Total Recordable Incident Rate (TRIR)');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`performance_scorecard` ALTER COLUMN `improvement_areas` SET TAGS ('pii_business_glossary_term' = 'Improvement Areas');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`performance_scorecard` ALTER COLUMN `last_modified_timestamp` SET TAGS ('pii_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`performance_scorecard` ALTER COLUMN `overall_rating` SET TAGS ('pii_business_glossary_term' = 'Overall Performance Rating');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`performance_scorecard` ALTER COLUMN `overall_rating` SET TAGS ('pii_value_regex' = 'outstanding|exceeds_expectations|meets_expectations|needs_improvement|unsatisfactory');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`performance_scorecard` ALTER COLUMN `overall_score` SET TAGS ('pii_business_glossary_term' = 'Overall Performance Score');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`performance_scorecard` ALTER COLUMN `prequalification_impact` SET TAGS ('pii_business_glossary_term' = 'Prequalification Impact');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`performance_scorecard` ALTER COLUMN `prequalification_impact` SET TAGS ('pii_value_regex' = 'renew|conditional_renewal|review_required|disqualify');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`performance_scorecard` ALTER COLUMN `productivity_rate` SET TAGS ('pii_business_glossary_term' = 'Productivity Rate');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`performance_scorecard` ALTER COLUMN `productivity_score` SET TAGS ('pii_business_glossary_term' = 'Productivity Performance Score');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`performance_scorecard` ALTER COLUMN `productivity_units_completed` SET TAGS ('pii_business_glossary_term' = 'Productivity Units Completed');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`performance_scorecard` ALTER COLUMN `quality_ncr_count` SET TAGS ('pii_business_glossary_term' = 'Non-Conformance Report (NCR) Count');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`performance_scorecard` ALTER COLUMN `quality_ncr_rate` SET TAGS ('pii_business_glossary_term' = 'Non-Conformance Report (NCR) Rate');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`performance_scorecard` ALTER COLUMN `quality_score` SET TAGS ('pii_business_glossary_term' = 'Quality Performance Score');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`performance_scorecard` ALTER COLUMN `recommended_action` SET TAGS ('pii_business_glossary_term' = 'Recommended Action');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`performance_scorecard` ALTER COLUMN `recommended_action` SET TAGS ('pii_value_regex' = 'continue|monitor|improve|watch_list|disqualify|suspend');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`performance_scorecard` ALTER COLUMN `rfi_response_timeliness_score` SET TAGS ('pii_business_glossary_term' = 'Request for Information (RFI) Response Timeliness Score');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`performance_scorecard` ALTER COLUMN `safety_score` SET TAGS ('pii_business_glossary_term' = 'Safety Score');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`performance_scorecard` ALTER COLUMN `schedule_adherence_spi` SET TAGS ('pii_business_glossary_term' = 'Schedule Performance Index (SPI)');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`performance_scorecard` ALTER COLUMN `schedule_score` SET TAGS ('pii_business_glossary_term' = 'Schedule Performance Score');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`performance_scorecard` ALTER COLUMN `scorecard_status` SET TAGS ('pii_business_glossary_term' = 'Scorecard Status');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`performance_scorecard` ALTER COLUMN `strengths` SET TAGS ('pii_business_glossary_term' = 'Performance Strengths');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`performance_scorecard` ALTER COLUMN `subcontractor_acknowledgement_date` SET TAGS ('pii_business_glossary_term' = 'Subcontractor Acknowledgement Date');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`performance_scorecard` ALTER COLUMN `subcontractor_response` SET TAGS ('pii_business_glossary_term' = 'Subcontractor Response');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`performance_scorecard` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`sub_time_extension` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`sub_time_extension` SET TAGS ('pii_subdomain' = 'performance_administration');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`sub_time_extension` SET TAGS ('pii_required_structure' = 'v2');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`sub_time_extension` SET TAGS ('pii_ecm_structure' = 'preserved_v2');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`sub_time_extension` SET TAGS ('pii_ssot_role' = 'reference');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`sub_time_extension` SET TAGS ('pii_ssot_master' = 'contract.contract_eot_claim');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`sub_time_extension` SET TAGS ('pii_ssot' = 'subcontractor.subcontractor_eot_claim');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`sub_time_extension` SET TAGS ('pii_ssot_distinct' = 'true');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`sub_time_extension` SET TAGS ('pii_ssot_scope' = 'subcontractor');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`sub_time_extension` SET TAGS ('pii_ssot_counterpart' = 'contract.contract_eot_claim');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`sub_time_extension` SET TAGS ('pii_ssot_resolved' = 'true');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`sub_time_extension` SET TAGS ('pii_structure_required' = 'true');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`sub_time_extension` ALTER COLUMN `sub_time_extension_id` SET TAGS ('pii_business_glossary_term' = 'Eot Claim Identifier');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`sub_time_extension` ALTER COLUMN `construction_project_id` SET TAGS ('pii_business_glossary_term' = 'Construction Project ID');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`sub_time_extension` ALTER COLUMN `prime_eot_claim_id` SET TAGS ('pii_business_glossary_term' = 'Contract Eot Claim Id');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`sub_time_extension` ALTER COLUMN `prime_eot_claim_id` SET TAGS ('pii_ssot_reference' = 'true');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`sub_time_extension` ALTER COLUMN `prime_eot_claim_id` SET TAGS ('pii_ssot' = 'contract.contract_eot_claim');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`sub_time_extension` ALTER COLUMN `schedule_impact_claim_id` SET TAGS ('pii_business_glossary_term' = 'Schedule Eot Claim Id');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`sub_time_extension` ALTER COLUMN `schedule_impact_claim_id` SET TAGS ('pii_ssot_reference' = 'true');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`sub_time_extension` ALTER COLUMN `schedule_impact_claim_id` SET TAGS ('pii_ssot_link' = 'true');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`sub_time_extension` ALTER COLUMN `subcontract_id` SET TAGS ('pii_business_glossary_term' = 'Subcontract ID');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`sub_time_extension` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_business_glossary_term' = 'Submitted By Employee Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`sub_time_extension` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`sub_time_extension` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`sub_time_extension` ALTER COLUMN `assessed_by` SET TAGS ('pii_business_glossary_term' = 'Assessed By');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`sub_time_extension` ALTER COLUMN `baseline_schedule_reference` SET TAGS ('pii_business_glossary_term' = 'Baseline Schedule Reference');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`sub_time_extension` ALTER COLUMN `claim_reference_number` SET TAGS ('pii_business_glossary_term' = 'Extension of Time (EOT) Claim Reference Number');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`sub_time_extension` ALTER COLUMN `claim_reference_number` SET TAGS ('pii_value_regex' = '^EOT-[A-Z0-9]{6,20}$');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`sub_time_extension` ALTER COLUMN `claim_status` SET TAGS ('pii_business_glossary_term' = 'Extension of Time (EOT) Claim Status');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`sub_time_extension` ALTER COLUMN `claim_submission_method` SET TAGS ('pii_business_glossary_term' = 'Claim Submission Method');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`sub_time_extension` ALTER COLUMN `claim_submission_method` SET TAGS ('pii_value_regex' = 'electronic_portal|email|registered_mail|hand_delivery|courier');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`sub_time_extension` ALTER COLUMN `concurrent_delay_flag` SET TAGS ('pii_business_glossary_term' = 'Concurrent Delay Flag');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`sub_time_extension` ALTER COLUMN `contemporaneous_records_reference` SET TAGS ('pii_business_glossary_term' = 'Contemporaneous Records Reference');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`sub_time_extension` ALTER COLUMN `cost_claim_associated_flag` SET TAGS ('pii_business_glossary_term' = 'Cost Claim Associated Flag');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`sub_time_extension` ALTER COLUMN `critical_path_impact_flag` SET TAGS ('pii_business_glossary_term' = 'Critical Path Impact Flag');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`sub_time_extension` ALTER COLUMN `days_assessed` SET TAGS ('pii_business_glossary_term' = 'Days Assessed');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`sub_time_extension` ALTER COLUMN `days_claimed` SET TAGS ('pii_business_glossary_term' = 'Days Claimed');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`sub_time_extension` ALTER COLUMN `days_granted` SET TAGS ('pii_business_glossary_term' = 'Days Granted');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`sub_time_extension` ALTER COLUMN `delay_cause_category` SET TAGS ('pii_business_glossary_term' = 'Delay Cause Category');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`sub_time_extension` ALTER COLUMN `delay_cause_category` SET TAGS ('pii_value_regex' = 'employer_risk|force_majeure|concurrent_delay|adverse_weather|design_change|variation_order');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`sub_time_extension` ALTER COLUMN `delay_end_date` SET TAGS ('pii_business_glossary_term' = 'Delay End Date');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`sub_time_extension` ALTER COLUMN `delay_event_description` SET TAGS ('pii_business_glossary_term' = 'Delay Event Description');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`sub_time_extension` ALTER COLUMN `delay_start_date` SET TAGS ('pii_business_glossary_term' = 'Delay Start Date');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`sub_time_extension` ALTER COLUMN `determination_authority` SET TAGS ('pii_business_glossary_term' = 'Determination Authority');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`sub_time_extension` ALTER COLUMN `determination_date` SET TAGS ('pii_business_glossary_term' = 'Determination Date');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`sub_time_extension` ALTER COLUMN `determination_rationale` SET TAGS ('pii_business_glossary_term' = 'Determination Rationale');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`sub_time_extension` ALTER COLUMN `dispute_status` SET TAGS ('pii_business_glossary_term' = 'Dispute Status');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`sub_time_extension` ALTER COLUMN `dispute_status` SET TAGS ('pii_value_regex' = 'no_dispute|under_negotiation|mediation|arbitration|litigation|resolved');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`sub_time_extension` ALTER COLUMN `ld_exposure_impact` SET TAGS ('pii_business_glossary_term' = 'Liquidated Damages (LD) Exposure Impact');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`sub_time_extension` ALTER COLUMN `ld_exposure_impact` SET TAGS ('pii_value_regex' = 'eliminates_ld_exposure|reduces_ld_exposure|no_impact_on_ld|increases_ld_exposure');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`sub_time_extension` ALTER COLUMN `notice_compliance_flag` SET TAGS ('pii_business_glossary_term' = 'Notice Compliance Flag');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`sub_time_extension` ALTER COLUMN `notice_date` SET TAGS ('pii_business_glossary_term' = 'Notice Date');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`sub_time_extension` ALTER COLUMN `original_completion_date` SET TAGS ('pii_business_glossary_term' = 'Original Completion Date');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`sub_time_extension` ALTER COLUMN `record_created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`sub_time_extension` ALTER COLUMN `record_updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`sub_time_extension` ALTER COLUMN `revised_completion_date` SET TAGS ('pii_business_glossary_term' = 'Revised Completion Date');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`sub_time_extension` ALTER COLUMN `schedule_analysis_method` SET TAGS ('pii_business_glossary_term' = 'Schedule Analysis Method');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`sub_time_extension` ALTER COLUMN `schedule_analysis_method` SET TAGS ('pii_value_regex' = 'time_impact_analysis|windows_analysis|as_planned_vs_as_built|collapsed_as_built|contemporaneous_period_analysis');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`sub_time_extension` ALTER COLUMN `submission_date` SET TAGS ('pii_business_glossary_term' = 'Claim Submission Date');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`sub_time_extension` ALTER COLUMN `supporting_documentation_count` SET TAGS ('pii_business_glossary_term' = 'Supporting Documentation Count');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`sub_change_order` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`sub_change_order` SET TAGS ('pii_subdomain' = 'performance_administration');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`sub_change_order` SET TAGS ('pii_required_structure' = 'v2');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`sub_change_order` SET TAGS ('pii_ecm_structure' = 'preserved_v2');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`sub_change_order` SET TAGS ('pii_ssot_role' = 'reference');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`sub_change_order` SET TAGS ('pii_ssot_master' = 'contract.contract_change_order');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`sub_change_order` SET TAGS ('pii_ssot' = 'subcontractor.subcontractor_change_order');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`sub_change_order` SET TAGS ('pii_ssot_distinct' = 'true');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`sub_change_order` SET TAGS ('pii_ssot_scope' = 'subcontractor');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`sub_change_order` SET TAGS ('pii_ssot_counterpart' = 'contract.contract_change_order');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`sub_change_order` SET TAGS ('pii_ssot_resolved' = 'true');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`sub_change_order` SET TAGS ('pii_structure_required' = 'true');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`sub_change_order` ALTER COLUMN `sub_change_order_id` SET TAGS ('pii_business_glossary_term' = 'Subcontractor Change Order (CO) ID');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`sub_change_order` ALTER COLUMN `construction_project_id` SET TAGS ('pii_business_glossary_term' = 'Construction Project ID');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`sub_change_order` ALTER COLUMN `commercial_change_order_id` SET TAGS ('pii_business_glossary_term' = 'Head Contract Change Order (CO) ID');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`sub_change_order` ALTER COLUMN `commercial_change_order_id` SET TAGS ('pii_ssot_reference' = 'true');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`sub_change_order` ALTER COLUMN `commercial_change_order_id` SET TAGS ('pii_ssot' = 'contract.contract_change_order');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`sub_change_order` ALTER COLUMN `cost_center_id` SET TAGS ('pii_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`sub_change_order` ALTER COLUMN `cost_code_id` SET TAGS ('pii_business_glossary_term' = 'Finance Cost Code Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`sub_change_order` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_business_glossary_term' = 'Initiated By Employee Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`sub_change_order` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`sub_change_order` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`sub_change_order` ALTER COLUMN `project_change_order_id` SET TAGS ('pii_business_glossary_term' = 'Project Change Order Id');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`sub_change_order` ALTER COLUMN `project_change_order_id` SET TAGS ('pii_ssot_reference' = 'true');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`sub_change_order` ALTER COLUMN `project_change_order_id` SET TAGS ('pii_ssot_link' = 'true');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`sub_change_order` ALTER COLUMN `subcontract_id` SET TAGS ('pii_business_glossary_term' = 'Subcontract ID');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`sub_change_order` ALTER COLUMN `wbs_element_id` SET TAGS ('pii_business_glossary_term' = 'Work Breakdown Structure (WBS) Element ID');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`sub_change_order` ALTER COLUMN `approval_date` SET TAGS ('pii_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`sub_change_order` ALTER COLUMN `approval_status` SET TAGS ('pii_business_glossary_term' = 'Approval Status');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`sub_change_order` ALTER COLUMN `approval_status` SET TAGS ('pii_value_regex' = 'draft|submitted|under_review|approved|rejected|withdrawn');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`sub_change_order` ALTER COLUMN `approving_authority` SET TAGS ('pii_business_glossary_term' = 'Approving Authority');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`sub_change_order` ALTER COLUMN `change_amount` SET TAGS ('pii_business_glossary_term' = 'Change Amount');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`sub_change_order` ALTER COLUMN `change_type` SET TAGS ('pii_business_glossary_term' = 'Change Type');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`sub_change_order` ALTER COLUMN `change_type` SET TAGS ('pii_value_regex' = 'scope_addition|scope_reduction|acceleration|schedule_extension|rate_adjustment|other');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`sub_change_order` ALTER COLUMN `co_description` SET TAGS ('pii_business_glossary_term' = 'Change Order (CO) Description');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`sub_change_order` ALTER COLUMN `co_number` SET TAGS ('pii_business_glossary_term' = 'Change Order (CO) Number');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`sub_change_order` ALTER COLUMN `co_title` SET TAGS ('pii_business_glossary_term' = 'Change Order (CO) Title');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`sub_change_order` ALTER COLUMN `contingency_allocation` SET TAGS ('pii_business_glossary_term' = 'Contingency Allocation');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`sub_change_order` ALTER COLUMN `cost_code` SET TAGS ('pii_business_glossary_term' = 'Cost Code');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`sub_change_order` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`sub_change_order` ALTER COLUMN `currency_code` SET TAGS ('pii_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`sub_change_order` ALTER COLUMN `currency_code` SET TAGS ('pii_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`sub_change_order` ALTER COLUMN `document_reference` SET TAGS ('pii_business_glossary_term' = 'Document Reference');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`sub_change_order` ALTER COLUMN `execution_completion_date` SET TAGS ('pii_business_glossary_term' = 'Execution Completion Date');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`sub_change_order` ALTER COLUMN `execution_start_date` SET TAGS ('pii_business_glossary_term' = 'Execution Start Date');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`sub_change_order` ALTER COLUMN `execution_status` SET TAGS ('pii_business_glossary_term' = 'Execution Status');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`sub_change_order` ALTER COLUMN `execution_status` SET TAGS ('pii_value_regex' = 'not_started|in_progress|completed|on_hold');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`sub_change_order` ALTER COLUMN `is_back_charge` SET TAGS ('pii_business_glossary_term' = 'Is Back Charge');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`sub_change_order` ALTER COLUMN `is_time_and_material` SET TAGS ('pii_business_glossary_term' = 'Is Time and Material (T&M)');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`sub_change_order` ALTER COLUMN `last_modified_timestamp` SET TAGS ('pii_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`sub_change_order` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`sub_change_order` ALTER COLUMN `original_completion_date` SET TAGS ('pii_business_glossary_term' = 'Original Completion Date');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`sub_change_order` ALTER COLUMN `original_contract_value` SET TAGS ('pii_business_glossary_term' = 'Original Contract Value');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`sub_change_order` ALTER COLUMN `reason_code` SET TAGS ('pii_business_glossary_term' = 'Reason Code');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`sub_change_order` ALTER COLUMN `reason_code` SET TAGS ('pii_value_regex' = 'design_change|site_condition|client_request|regulatory_requirement|error_omission|force_majeure');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`sub_change_order` ALTER COLUMN `reason_description` SET TAGS ('pii_business_glossary_term' = 'Reason Description');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`sub_change_order` ALTER COLUMN `rejection_reason` SET TAGS ('pii_business_glossary_term' = 'Rejection Reason');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`sub_change_order` ALTER COLUMN `revised_completion_date` SET TAGS ('pii_business_glossary_term' = 'Revised Completion Date');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`sub_change_order` ALTER COLUMN `revised_contract_value` SET TAGS ('pii_business_glossary_term' = 'Revised Contract Value');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`sub_change_order` ALTER COLUMN `schedule_impact_days` SET TAGS ('pii_business_glossary_term' = 'Schedule Impact Days');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`sub_change_order` ALTER COLUMN `submission_date` SET TAGS ('pii_business_glossary_term' = 'Submission Date');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`sub_change_order` ALTER COLUMN `trade_package` SET TAGS ('pii_business_glossary_term' = 'Trade Package');
