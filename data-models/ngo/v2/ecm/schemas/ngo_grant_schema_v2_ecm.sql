-- Schema for Domain: grant | Business:  | Version: v2_ecm
-- Generated on: 2026-07-03 04:47:16

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_ngo_v1`.`grant` COMMENT 'Systems of record: SAP Grants Management, eZHACT (UNICEF HACT cash transfers), donor portals (USAID ASIST, EC PROSPECT). Award lifecycle from solicitation through closeout.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_ngo_v1`.`grant`.`sub_award_disbursement` (
    `sub_award_disbursement_id` BIGINT COMMENT 'Primary key for sub-award disbursement record',
    `award_id` BIGINT COMMENT 'FK to the parent award',
    `budget_line_id` BIGINT COMMENT 'FK to the finance budget line charged',
    `component_id` BIGINT COMMENT 'FK to the program component',
    `partner_org_id` BIGINT COMMENT 'FK to the implementing partner organization',
    `subaward_id` BIGINT COMMENT 'FK to the parent subaward',
    `advance_balance_outstanding` DECIMAL(18,2) COMMENT 'Outstanding advance balance not yet liquidated',
    `approval_date` DATE COMMENT 'Date the disbursement was approved',
    `approved_by` STRING COMMENT 'Name of person who approved the disbursement',
    `bank_transfer_reference` STRING COMMENT 'Bank transfer reference number',
    `cost_category` DECIMAL(18,2) COMMENT 'Category of cost for the disbursement',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `disbursement_amount` DECIMAL(18,2) COMMENT 'Amount disbursed in local currency',
    `disbursement_amount_usd` DECIMAL(18,2) COMMENT 'Amount disbursed in USD equivalent',
    `disbursement_currency` STRING COMMENT 'Currency code of the disbursement',
    `disbursement_date` DATE COMMENT 'Date the disbursement was made',
    `disbursement_method` STRING COMMENT 'Method of disbursement (wire, check, etc.)',
    `disbursement_notes` STRING COMMENT 'Free-text notes on the disbursement',
    `disbursement_reference_number` STRING COMMENT 'Unique reference number for the disbursement',
    `disbursement_status` STRING COMMENT 'Current status of the disbursement',
    `disbursement_type` STRING COMMENT 'Type of disbursement (advance, reimbursement, direct payment)',
    `donor_reporting_category` STRING COMMENT 'Category for donor reporting purposes',
    `exchange_rate` DOUBLE COMMENT 'Exchange rate applied at time of disbursement',
    `fiscal_period` STRING COMMENT 'Fiscal period of the disbursement',
    `fiscal_year` STRING COMMENT 'Fiscal year of the disbursement',
    `fund_restriction_type` STRING COMMENT 'Type of fund restriction (restricted, temporarily restricted, unrestricted)',
    `gl_account_code` STRING COMMENT 'General ledger account code',
    `indirect_cost_amount` DECIMAL(18,2) COMMENT 'Indirect cost amount included in disbursement',
    `is_emergency_disbursement` BOOLEAN COMMENT 'Flag indicating if this is an emergency disbursement',
    `liquidated_amount` DECIMAL(18,2) COMMENT 'Amount that has been liquidated',
    `liquidation_date` DATE COMMENT 'Date of liquidation',
    `liquidation_deadline` DATE COMMENT 'Deadline for liquidation of advance',
    `liquidation_status` STRING COMMENT 'Status of liquidation process',
    `net_disbursement_amount` DECIMAL(18,2) COMMENT 'Net amount after withholdings',
    `nicra_rate_applied` DOUBLE COMMENT 'Negotiated indirect cost rate applied',
    `payment_terms` DECIMAL(18,2) COMMENT 'Payment terms for the disbursement',
    `post_distribution_monitoring_ref` STRING COMMENT 'Reference to post-distribution monitoring',
    `request_date` DATE COMMENT 'Date the disbursement was requested',
    `supporting_document_reference` STRING COMMENT 'Reference to supporting documentation',
    `tranche_number` STRING COMMENT 'Sequential tranche number',
    `updated_timestamp` TIMESTAMP COMMENT 'Record last update timestamp',
    `withholding_amount` DECIMAL(18,2) COMMENT 'Amount withheld from disbursement',
    CONSTRAINT pk_sub_award_disbursement PRIMARY KEY(`sub_award_disbursement_id`)
) COMMENT 'Records individual disbursement transactions to sub-awardees under a grant award, tracking amounts, liquidation status, and compliance with donor conditions. Source systems: SAP, eZHACT, eTools.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`grant`.`award` (
    `award_id` BIGINT COMMENT 'Primary key for award record',
    `award_constituent_id` BIGINT COMMENT 'FK to the donor constituent',
    `constituent_id` BIGINT COMMENT 'Foreign key to donor.constituent',
    `country_office_id` BIGINT COMMENT 'FK to the managing country office',
    `intervention_id` BIGINT COMMENT 'FK to the program intervention funded',
    `advance_payment_allowed` DECIMAL(18,2) COMMENT 'Whether advance payments are permitted',
    `agreement_signed_date` DATE COMMENT 'Date the award agreement was signed',
    `amendment_count` STRING COMMENT 'Number of amendments to the award',
    `audit_required` BOOLEAN COMMENT 'Whether audit is required for this award',
    `audit_threshold_amount` DECIMAL(18,2) COMMENT 'Dollar threshold triggering audit requirement',
    `authorized_amount` DECIMAL(18,2) COMMENT 'Total authorized award amount',
    `award_number` STRING COMMENT 'Unique award identification number',
    `award_status` STRING COMMENT 'Current status of the award',
    `award_type` STRING COMMENT 'Type of award (cooperative agreement, grant, contract)',
    `board_approval_date` DATE COMMENT 'Date of board approval',
    `board_approval_required` BOOLEAN COMMENT 'Whether board approval is required',
    `board_resolution_reference` STRING COMMENT 'Reference to board resolution',
    `branding_marking_requirements` STRING COMMENT 'Donor branding and marking requirements',
    `closeout_date` DATE COMMENT 'Date the award was closed out',
    `cost_share_amount` DECIMAL(18,2) COMMENT 'Required cost share amount',
    `cost_share_percentage` DECIMAL(18,2) COMMENT 'Required cost share percentage',
    `cost_share_required` DECIMAL(18,2) COMMENT 'Whether cost sharing is required',
    `currency` STRING COMMENT 'Award currency code',
    `dac_sector_code` STRING COMMENT 'OECD DAC sector classification code',
    `donor_reference_number` STRING COMMENT 'Donors internal reference number',
    `end_date` DATE COMMENT 'Award end date',
    `exchange_rate_to_functional` DOUBLE COMMENT 'Exchange rate to functional currency',
    `functional_currency` STRING COMMENT 'Functional currency of the organization',
    `fund_restriction_type` STRING COMMENT 'ASC 958 / IPSAS fund restriction classification',
    `funding_mechanism` STRING COMMENT 'Funding mechanism type',
    `geographic_scope` STRING COMMENT 'Geographic scope of the award',
    `grantmaking_program_area` DECIMAL(18,2) COMMENT 'Program area for outbound grants',
    `indirect_cost_ceiling` DECIMAL(18,2) COMMENT 'Maximum indirect cost amount',
    `is_grantmaking_out` BOOLEAN COMMENT 'Flag for outbound grantmaking',
    `last_amendment_date` DATE COMMENT 'Date of most recent amendment',
    `nicra_icr_rate` DOUBLE COMMENT 'Negotiated indirect cost rate',
    `notes` STRING COMMENT 'Free-text notes',
    `notification_date` DATE COMMENT 'Date of award notification',
    `original_end_date` DATE COMMENT 'Original end date before extensions',
    `payment_method` DECIMAL(18,2) COMMENT 'Payment method (advance, reimbursement)',
    `period_of_performance_months` STRING COMMENT 'Duration in months',
    `primary_country_code` STRING COMMENT 'Primary country of implementation',
    `regulatory_framework` STRING COMMENT 'Applicable regulatory framework (2 CFR 200, IPSAS, etc.)',
    `reporting_frequency` STRING COMMENT 'Required reporting frequency',
    `sdg_alignment` STRING COMMENT 'Sustainable Development Goal alignment',
    `special_conditions` STRING COMMENT 'Special award conditions',
    `start_date` DATE COMMENT 'Award start date',
    `thematic_sector` STRING COMMENT 'Thematic sector of the award',
    `title` STRING COMMENT 'Award title',
    `total_obligated_amount` DECIMAL(18,2) COMMENT 'Total obligated amount in award currency',
    `total_obligated_amount_functional` DECIMAL(18,2) COMMENT 'Total obligated in functional currency',
    CONSTRAINT pk_award PRIMARY KEY(`award_id`)
) COMMENT 'Represents a formal grant award from a donor to the organization, including financial terms, compliance requirements, and period of performance. Source systems: SAP Grants Management, eTools, Salesforce Nonprofit Cloud. Systems-of-record: SAP Grants Management (GM), VISION, eZHACT. Framework: 2 CFR 200 / IPSAS 23 / IATI v2.03 budget elements.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`grant`.`proposal` (
    `proposal_id` BIGINT COMMENT 'Primary key for proposal record',
    `award_id` BIGINT COMMENT 'FK to resulting award if won',
    `component_id` BIGINT COMMENT 'FK to program component',
    `constituent_id` BIGINT COMMENT 'Foreign key to donor.constituent',
    `country_office_id` BIGINT COMMENT 'FK to the submitting country office',
    `intervention_id` BIGINT COMMENT 'FK to the program intervention',
    `mel_logframe_id` BIGINT COMMENT 'FK to the MEL logframe',
    `proposal_constituent_id` BIGINT COMMENT 'FK to the target donor',
    `solicitation_id` BIGINT COMMENT 'FK to the solicitation responded to',
    `staff_member_id` BIGINT COMMENT 'Foreign key to workforce.staff_member',
    `award_notification_date` DATE COMMENT 'Date award notification received',
    `business_development_owner` STRING COMMENT 'Name of BD lead',
    `compliance_review_completed` BOOLEAN COMMENT 'Whether compliance review is done',
    `consortium_lead_organization` STRING COMMENT 'Lead organization in consortium',
    `cost_proposal_summary` DECIMAL(18,2) COMMENT 'Summary cost proposal amount',
    `cost_share_amount` DECIMAL(18,2) COMMENT 'Proposed cost share amount',
    `cost_share_percentage` DECIMAL(18,2) COMMENT 'Proposed cost share percentage',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `document_reference` STRING COMMENT 'Reference to proposal document',
    `geographic_focus` STRING COMMENT 'Geographic focus area',
    `go_no_go_decision` STRING COMMENT 'Go/no-go decision outcome',
    `go_no_go_decision_date` DATE COMMENT 'Date of go/no-go decision',
    `indirect_cost_rate_proposed` DECIMAL(18,2) COMMENT 'Proposed indirect cost rate',
    `internal_review_date` DATE COMMENT 'Date of internal review',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Last modification timestamp',
    `lead_proposal_writer` STRING COMMENT 'Name of lead proposal writer',
    `lead_technical_sector` STRING COMMENT 'Primary technical sector',
    `notes` STRING COMMENT 'Free-text notes',
    `partnership_model` STRING COMMENT 'Partnership model description',
    `proposal_status` STRING COMMENT 'Current proposal status',
    `proposal_type` STRING COMMENT 'Type of proposal',
    `proposed_duration_months` DOUBLE COMMENT 'Proposed duration in months',
    `proposed_end_date` DATE COMMENT 'Date and time when the proposed end event occurred for this proposal.',
    `proposed_start_date` DATE COMMENT 'Date and time when the proposed start event occurred for this proposal.',
    `reference_number` STRING COMMENT 'Proposal reference number',
    `rejection_reason` STRING COMMENT 'Reason for rejection if applicable',
    `requested_amount` DECIMAL(18,2) COMMENT 'Amount requested in proposal currency',
    `requested_amount_usd` DECIMAL(18,2) COMMENT 'Amount requested in USD',
    `requested_currency` STRING COMMENT 'Currency of request',
    `submission_date` DATE COMMENT 'Date proposal was submitted',
    `target_beneficiary_count` STRING COMMENT 'Target number of beneficiaries',
    `technical_approach_summary` STRING COMMENT 'Summary of technical approach',
    `title` STRING COMMENT 'Proposal title',
    `win_loss_outcome` STRING COMMENT 'Final win/loss outcome',
    CONSTRAINT pk_proposal PRIMARY KEY(`proposal_id`)
) COMMENT 'Tracks grant proposals from identification through submission and outcome, including go/no-go decisions, budget summaries, and partnership models. Source systems: Salesforce, internal BD trackers.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`grant`.`award_budget` (
    `award_budget_id` DECIMAL(18,2) COMMENT 'Primary key',
    `award_id` BIGINT COMMENT 'FK to parent award',
    `budget_id` BIGINT COMMENT 'FK to finance budget',
    `grant_amendment_id` DECIMAL(18,2) COMMENT 'FK to amendment if budget revised',
    `nicra_agreement_id` BIGINT COMMENT 'FK to NICRA agreement',
    `approved_by` STRING COMMENT 'Name of approver',
    `award_currency` STRING COMMENT 'Currency of the award budget',
    `budget_narrative_reference` DECIMAL(18,2) COMMENT 'Reference to budget narrative document',
    `budget_notes` DECIMAL(18,2) COMMENT 'Free-text budget notes',
    `budget_period` DECIMAL(18,2) COMMENT 'Budget period identifier',
    `budget_period_end_date` DECIMAL(18,2) COMMENT 'End date of budget period',
    `budget_period_start_date` DECIMAL(18,2) COMMENT 'Start date of budget period',
    `budget_status` DECIMAL(18,2) COMMENT 'Current budget status',
    `budget_submission_date` DECIMAL(18,2) COMMENT 'Date budget was submitted',
    `budget_version_number` DECIMAL(18,2) COMMENT 'Version number of the budget',
    `contractual_costs` DECIMAL(18,2) COMMENT 'Total contractual costs',
    `cost_share_amount` DECIMAL(18,2) COMMENT 'Cost share amount in budget',
    `cost_share_required` DECIMAL(18,2) COMMENT 'Whether cost share is required',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `donor_approval_date` DATE COMMENT 'Date donor approved budget',
    `donor_approval_reference` STRING COMMENT 'Donor approval reference number',
    `equipment_costs` DECIMAL(18,2) COMMENT 'Total equipment costs',
    `fringe_benefits_costs` DECIMAL(18,2) COMMENT 'Total fringe benefits costs',
    `fund_restriction_type` STRING COMMENT 'Fund restriction classification',
    `indirect_cost_base` DECIMAL(18,2) COMMENT 'Base for indirect cost calculation',
    `is_amendment` BOOLEAN COMMENT 'Whether this is an amended budget',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Last modification timestamp',
    `nicra_rate_applied` DOUBLE COMMENT 'Attribute capturing the nicra rate applied information for the award budget entity.',
    `other_direct_costs` DECIMAL(18,2) COMMENT 'Attribute capturing the other direct costs information for the award budget entity.',
    `personnel_costs` DECIMAL(18,2) COMMENT 'Total personnel costs',
    `prepared_by` STRING COMMENT 'Name of preparer',
    `supplies_costs` DECIMAL(18,2) COMMENT 'Total supplies costs',
    `total_approved_budget` DECIMAL(18,2) COMMENT 'Total approved budget amount',
    `total_direct_costs` DECIMAL(18,2) COMMENT 'Attribute capturing the total direct costs information for the award budget entity.',
    `total_indirect_costs` DECIMAL(18,2) COMMENT 'Attribute capturing the total indirect costs information for the award budget entity.',
    `travel_costs` DECIMAL(18,2) COMMENT 'Total travel costs',
    CONSTRAINT pk_award_budget PRIMARY KEY(`award_budget_id`)
) COMMENT 'Represents the approved budget for a grant award period, including cost categories, indirect cost calculations, and donor approval status. Source systems: SAP, eTools.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`grant`.`award_budget_line` (
    `award_budget_line_id` DECIMAL(18,2) COMMENT 'Primary key',
    `award_budget_id` DECIMAL(18,2) COMMENT 'FK to parent award budget',
    `award_id` BIGINT COMMENT 'FK to award',
    `component_id` BIGINT COMMENT 'FK to program component',
    `budget_line_id` BIGINT COMMENT 'FK to finance budget line',
    `indicator_id` BIGINT COMMENT 'FK to MEL indicator',
    `intervention_id` BIGINT COMMENT 'FK to intervention',
    `position_id` BIGINT COMMENT 'FK to workforce position',
    `allocability_flag` BOOLEAN COMMENT 'Whether cost is allocable to the award',
    `allowability_flag` BOOLEAN COMMENT 'Whether cost is allowable under award terms',
    `approval_date` DATE COMMENT 'Date line was approved',
    `approved_amount` DECIMAL(18,2) COMMENT 'Approved amount for line',
    `approved_amount_usd` DECIMAL(18,2) COMMENT 'Approved amount in USD',
    `budget_line_status` DECIMAL(18,2) COMMENT 'Status of budget line',
    `cost_category` DECIMAL(18,2) COMMENT 'Cost category classification',
    `cost_share_amount` DECIMAL(18,2) COMMENT 'Cost share for this line',
    `cost_share_required_flag` BOOLEAN COMMENT 'Whether cost share is required for this line',
    `cost_subcategory` DECIMAL(18,2) COMMENT 'Attribute capturing the cost subcategory information for the award budget line entity.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `cumulative_expenditure` DECIMAL(18,2) COMMENT 'Cumulative expenditure to date',
    `cumulative_expenditure_usd` DECIMAL(18,2) COMMENT 'Cumulative expenditure in USD',
    `currency_code` STRING COMMENT 'Standardized code representing the currency classification or category.',
    `donor_reporting_category` STRING COMMENT 'Attribute capturing the donor reporting category information for the award budget line entity.',
    `exchange_rate` DOUBLE COMMENT 'Exchange rate used',
    `fiscal_period` STRING COMMENT 'Attribute capturing the fiscal period information for the award budget line entity.',
    `fiscal_year` STRING COMMENT 'Attribute capturing the fiscal year information for the award budget line entity.',
    `fund_restriction_type` STRING COMMENT 'Classification type categorizing the fund restriction for this record.',
    `gl_account_code` STRING COMMENT 'Standardized code representing the gl account classification or category.',
    `indirect_cost_amount` DECIMAL(18,2) COMMENT 'Numeric value representing the indirect cost quantity or measurement.',
    `line_description` STRING COMMENT 'Description of line item',
    `line_item_code` STRING COMMENT 'Standardized code representing the line item classification or category.',
    `modified_timestamp` TIMESTAMP COMMENT 'Last modification timestamp',
    `nicra_rate_applied` DOUBLE COMMENT 'Attribute capturing the nicra rate applied information for the award budget line entity.',
    `notes` STRING COMMENT 'Free-text notes',
    `quantity` DECIMAL(18,2) COMMENT 'Attribute capturing the quantity information for the award budget line entity.',
    `reasonableness_flag` BOOLEAN COMMENT 'Whether cost is reasonable',
    `revised_amount` DECIMAL(18,2) COMMENT 'Numeric value representing the revised quantity or measurement.',
    `revised_amount_usd` DECIMAL(18,2) COMMENT 'Revised amount in USD',
    `revision_date` DATE COMMENT 'Date of revision',
    `revision_reason` STRING COMMENT 'Reason for revision',
    `supporting_document_reference` STRING COMMENT 'Reference to supporting docs',
    `unit_cost` DECIMAL(18,2) COMMENT 'Attribute capturing the unit cost information for the award budget line entity.',
    `unit_of_measure` STRING COMMENT 'Attribute capturing the unit of measure information for the award budget line entity.',
    `variance_amount` DECIMAL(18,2) COMMENT 'Budget variance amount',
    `variance_percentage` DOUBLE COMMENT 'Budget variance percentage',
    CONSTRAINT pk_award_budget_line PRIMARY KEY(`award_budget_line_id`)
) COMMENT 'Individual line items within an award budget, tracking cost categories, amounts, variances, and compliance flags (allowability, allocability, reasonableness). Source systems: SAP, eTools.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`grant`.`grant_amendment` (
    `grant_amendment_id` DECIMAL(18,2) COMMENT 'Primary key',
    `award_id` BIGINT COMMENT 'FK to parent award',
    `indicator_target_id` BIGINT COMMENT 'FK to indicator target modified',
    `mel_logframe_id` BIGINT COMMENT 'FK to MEL logframe',
    `supersedes_amendment_grant_amendment_id` DECIMAL(18,2) COMMENT 'FK to superseded amendment',
    `amendment_description` STRING COMMENT 'Description of amendment',
    `amendment_number` STRING COMMENT 'Sequential amendment number',
    `amendment_status` STRING COMMENT 'Current status',
    `amendment_type` STRING COMMENT 'Type of amendment',
    `approval_date` DATE COMMENT 'Date approved',
    `approved_by_name` STRING COMMENT 'Name of approver',
    `approved_by_title` STRING COMMENT 'Title of approver',
    `budget_modification_summary` DECIMAL(18,2) COMMENT 'Summary of budget modifications',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `currency_code` STRING COMMENT 'Standardized code representing the currency classification or category.',
    `donor_approval_reference` STRING COMMENT 'Attribute capturing the donor approval reference information for the grant amendment entity.',
    `donor_prior_approval_required` BOOLEAN COMMENT 'Whether donor prior approval was required',
    `effective_date` DATE COMMENT 'Effective date of amendment',
    `execution_date` DATE COMMENT 'Date amendment was executed',
    `funding_change` DECIMAL(18,2) COMMENT 'Change in funding amount',
    `geographic_change_description` STRING COMMENT 'Description of geographic changes',
    `internal_approval_date` DATE COMMENT 'Date of internal approval',
    `internal_approver_name` STRING COMMENT 'Name of internal approver',
    `is_no_cost_extension` BOOLEAN COMMENT 'Whether this is a no-cost extension',
    `justification` STRING COMMENT 'Justification for amendment',
    `key_personnel_change_description` STRING COMMENT 'Description of key personnel changes',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Last modification timestamp',
    `notes` STRING COMMENT 'Free-text notes',
    `original_end_date` DATE COMMENT 'Date and time when the original end event occurred for this grant amendment.',
    `original_start_date` DATE COMMENT 'Date and time when the original start event occurred for this grant amendment.',
    `original_total_obligation` DECIMAL(18,2) COMMENT 'Attribute capturing the original total obligation information for the grant amendment entity.',
    `period_extension_days` STRING COMMENT 'Number of days extended',
    `request_date` DATE COMMENT 'Date amendment was requested',
    `revised_end_date` DATE COMMENT 'Date and time when the revised end event occurred for this grant amendment.',
    `revised_start_date` DATE COMMENT 'Date and time when the revised start event occurred for this grant amendment.',
    `revised_total_obligation` DECIMAL(18,2) COMMENT 'Attribute capturing the revised total obligation information for the grant amendment entity.',
    `scope_change_description` STRING COMMENT 'Description of scope changes',
    `supporting_document_reference` STRING COMMENT 'Reference to supporting documents',
    `terms_and_conditions_change` STRING COMMENT 'Description of T&C changes',
    CONSTRAINT pk_grant_amendment PRIMARY KEY(`grant_amendment_id`)
) COMMENT 'Tracks modifications to grant awards including no-cost extensions, budget realignments, scope changes, and key personnel changes. Source systems: SAP, eTools.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`grant`.`subaward` (
    `subaward_id` BIGINT COMMENT 'Primary key',
    `award_id` BIGINT COMMENT 'FK to parent award',
    `impact_story_id` BIGINT COMMENT 'FK to impact story',
    `intervention_id` BIGINT COMMENT 'FK to intervention',
    `partner_org_id` BIGINT COMMENT 'FK to partner organization',
    `project_site_id` BIGINT COMMENT 'FK to project site',
    `amendment_count` STRING COMMENT 'Number of amendments',
    `approval_date` DATE COMMENT 'Date approved',
    `approved_by` STRING COMMENT 'Name of approver',
    `closeout_date` DATE COMMENT 'Date of closeout',
    `cost_share_amount` DECIMAL(18,2) COMMENT 'Numeric value representing the cost share quantity or measurement.',
    `cost_share_required_flag` BOOLEAN COMMENT 'Whether cost share is required',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `currency` STRING COMMENT 'Subaward currency',
    `subaward_description` STRING COMMENT 'Description of subaward',
    `disbursed_amount` DECIMAL(18,2) COMMENT 'Total disbursed amount',
    `duns_number` STRING COMMENT 'DUNS number of sub-recipient',
    `execution_date` DATE COMMENT 'Date executed',
    `ffata_reporting_required_flag` BOOLEAN COMMENT 'Whether FFATA reporting is required',
    `flow_down_requirements` STRING COMMENT 'Flow-down requirements from prime',
    `fsrs_report_date` DATE COMMENT 'FSRS reporting date',
    `fund_restriction_type` STRING COMMENT 'Classification type categorizing the fund restriction for this record.',
    `grant_type_classification` DECIMAL(18,2) COMMENT 'Classification of grant type',
    `indirect_cost_base` DECIMAL(18,2) COMMENT 'Attribute capturing the indirect cost base information for the subaward entity.',
    `indirect_cost_rate` DECIMAL(18,2) COMMENT 'Attribute capturing the indirect cost rate information for the subaward entity.',
    `is_grantmaking_out_flow` BOOLEAN COMMENT 'Flag for outbound grantmaking flow',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Last modification timestamp',
    `monitoring_frequency` STRING COMMENT 'Attribute capturing the monitoring frequency information for the subaward entity.',
    `notes` STRING COMMENT 'Free-text notes',
    `obligated_amount` DECIMAL(18,2) COMMENT 'Total obligated amount',
    `payment_method` DECIMAL(18,2) COMMENT 'Attribute capturing the payment method information for the subaward entity.',
    `payment_schedule` DECIMAL(18,2) COMMENT 'Attribute capturing the payment schedule information for the subaward entity.',
    `period_of_performance_end_date` DATE COMMENT 'End date of performance period',
    `period_of_performance_start_date` DATE COMMENT 'Start date of performance period',
    `remaining_balance` DECIMAL(18,2) COMMENT 'Attribute capturing the remaining balance information for the subaward entity.',
    `reporting_frequency` STRING COMMENT 'Attribute capturing the reporting frequency information for the subaward entity.',
    `risk_rating` STRING COMMENT 'Risk rating of sub-recipient',
    `single_audit_required_flag` BOOLEAN COMMENT 'Whether single audit is required',
    `subaward_number` STRING COMMENT 'Count or number of subaward items associated with this record.',
    `subaward_status` STRING COMMENT 'Current status',
    `subaward_type` STRING COMMENT 'Type of subaward',
    `termination_date` DATE COMMENT 'Termination date if applicable',
    `termination_reason` STRING COMMENT 'Reason for termination',
    `title` STRING COMMENT 'Subaward title',
    `total_subaward_amount` DECIMAL(18,2) COMMENT 'Numeric value representing the total subaward quantity or measurement.',
    `total_subaward_amount_usd` DECIMAL(18,2) COMMENT 'Total subaward amount in USD',
    `uei_number` STRING COMMENT 'Unique Entity Identifier',
    CONSTRAINT pk_subaward PRIMARY KEY(`subaward_id`)
) COMMENT 'Represents sub-awards issued to implementing partners under a prime award, tracking financial terms, compliance requirements, and performance. Source systems: SAP, eTools, eZHACT.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`grant`.`donor_condition` (
    `donor_condition_id` BIGINT COMMENT 'Primary key',
    `award_id` BIGINT COMMENT 'FK to award',
    `constituent_id` BIGINT COMMENT 'FK to donor constituent',
    `evaluation_id` BIGINT COMMENT 'FK to evaluation',
    `indicator_id` BIGINT COMMENT 'FK to indicator',
    `staff_member_id` BIGINT COMMENT 'FK to responsible staff',
    `actual_completion_date` DATE COMMENT 'Date and time when the actual completion event occurred for this donor condition.',
    `approval_authority` STRING COMMENT 'Attribute capturing the approval authority information for the donor condition entity.',
    `approval_date` DATE COMMENT 'Date and time when the approval event occurred for this donor condition.',
    `approval_reference_number` STRING COMMENT 'Approval reference',
    `compliance_notes` STRING COMMENT 'Attribute capturing the compliance notes information for the donor condition entity.',
    `compliance_status` STRING COMMENT 'Current compliance status',
    `condition_category` STRING COMMENT 'Category of condition',
    `condition_description` STRING COMMENT 'Description of condition',
    `condition_reference_number` STRING COMMENT 'Reference number',
    `condition_title` STRING COMMENT 'Title of condition',
    `condition_type` STRING COMMENT 'Type of condition',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `deliverable_description` STRING COMMENT 'Description of deliverable',
    `donor_contact_email` STRING COMMENT 'Attribute capturing the donor contact email information for the donor condition entity.',
    `donor_contact_name` STRING COMMENT 'Human-readable name or label for the donor contact.',
    `due_date` DATE COMMENT 'Due date for condition',
    `escalation_threshold_days` STRING COMMENT 'Days before escalation',
    `financial_threshold_amount` DECIMAL(18,2) COMMENT 'Financial threshold',
    `financial_threshold_currency` STRING COMMENT 'Currency of threshold',
    `is_membership_obligation` BOOLEAN COMMENT 'Whether this is a membership obligation',
    `is_special_award_condition` BOOLEAN COMMENT 'Whether this is a SAC',
    `last_review_date` DATE COMMENT 'Date and time when the last review event occurred for this donor condition.',
    `membership_dues_amount` DECIMAL(18,2) COMMENT 'Numeric value representing the membership dues quantity or measurement.',
    `membership_renewal_date` DATE COMMENT 'Date and time when the membership renewal event occurred for this donor condition.',
    `modified_by` STRING COMMENT 'Reference to the user or entity that performed the modified action.',
    `modified_timestamp` TIMESTAMP COMMENT 'Last modification timestamp',
    `monitoring_frequency` STRING COMMENT 'Attribute capturing the monitoring frequency information for the donor condition entity.',
    `next_recurrence_date` DATE COMMENT 'Date and time when the next recurrence event occurred for this donor condition.',
    `next_review_date` DATE COMMENT 'Date and time when the next review event occurred for this donor condition.',
    `priority_level` STRING COMMENT 'Attribute capturing the priority level information for the donor condition entity.',
    `recurrence_frequency` STRING COMMENT 'Attribute capturing the recurrence frequency information for the donor condition entity.',
    `regulatory_citation` STRING COMMENT 'Attribute capturing the regulatory citation information for the donor condition entity.',
    `responsible_department` STRING COMMENT 'Attribute capturing the responsible department information for the donor condition entity.',
    `risk_rating` STRING COMMENT 'Attribute capturing the risk rating information for the donor condition entity.',
    `sac_justification` STRING COMMENT 'Attribute capturing the sac justification information for the donor condition entity.',
    `supporting_document_reference` STRING COMMENT 'Attribute capturing the supporting document reference information for the donor condition entity.',
    `waiver_date` DATE COMMENT 'Date and time when the waiver event occurred for this donor condition.',
    `waiver_justification` STRING COMMENT 'Attribute capturing the waiver justification information for the donor condition entity.',
    `created_by` STRING COMMENT 'Reference to the user or entity that performed the created action.',
    CONSTRAINT pk_donor_condition PRIMARY KEY(`donor_condition_id`)
) COMMENT 'Tracks specific conditions imposed by donors on awards, including compliance status, due dates, and monitoring requirements. Source systems: eTools, SAP.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`grant`.`donor_report` (
    `donor_report_id` BIGINT COMMENT 'Primary key',
    `award_id` BIGINT COMMENT 'FK to award',
    `intervention_id` BIGINT COMMENT 'FK to intervention',
    `staff_member_id` BIGINT COMMENT 'FK to responsible staff',
    `project_site_id` BIGINT COMMENT 'FK to project site',
    `regulatory_filing_id` BIGINT COMMENT 'FK to regulatory filing',
    `approval_date` DATE COMMENT 'Date report was approved',
    `audit_findings_count` STRING COMMENT 'Number of audit findings',
    `beneficiaries_reached` STRING COMMENT 'Number of beneficiaries reached',
    `budget_variance_amount` DECIMAL(18,2) COMMENT 'Numeric value representing the budget variance quantity or measurement.',
    `budget_variance_percentage` DECIMAL(18,2) COMMENT 'Attribute capturing the budget variance percentage information for the donor report entity.',
    `compliance_certification_flag` BOOLEAN COMMENT 'Whether compliance is certified',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `cumulative_expenditure_to_date` DATE COMMENT 'Cumulative expenditure',
    `days_overdue` STRING COMMENT 'Number of days overdue',
    `donor_acceptance_date` DATE COMMENT 'Date donor accepted report',
    `donor_feedback_summary` DECIMAL(18,2) COMMENT 'Summary of donor feedback',
    `due_date` DATE COMMENT 'Report due date',
    `exchange_rate_used` DOUBLE COMMENT 'Attribute capturing the exchange rate used information for the donor report entity.',
    `financial_amount_reported` DECIMAL(18,2) COMMENT 'Attribute capturing the financial amount reported information for the donor report entity.',
    `financial_amount_reported_usd` DECIMAL(18,2) COMMENT 'Financial amount in USD',
    `financial_currency` STRING COMMENT 'Currency of financial report',
    `is_final_version` BOOLEAN COMMENT 'Whether this is the final version',
    `is_overdue` BOOLEAN COMMENT 'Whether report is overdue',
    `key_performance_indicators_met` STRING COMMENT 'Number of KPIs met',
    `key_performance_indicators_total` DECIMAL(18,2) COMMENT 'Total number of KPIs',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Last modification timestamp',
    `narrative_summary` STRING COMMENT 'Attribute capturing the narrative summary information for the donor report entity.',
    `report_notes` STRING COMMENT 'Attribute capturing the report notes information for the donor report entity.',
    `report_reference_number` STRING COMMENT 'Count or number of report reference items associated with this record.',
    `report_status` STRING COMMENT 'Current report status',
    `report_type` STRING COMMENT 'Type of report',
    `reporting_frequency` STRING COMMENT 'Attribute capturing the reporting frequency information for the donor report entity.',
    `reporting_period_end_date` DATE COMMENT 'End of reporting period',
    `reporting_period_start_date` DATE COMMENT 'Start of reporting period',
    `revision_reason` STRING COMMENT 'Reason for revision',
    `revision_requested_date` DATE COMMENT 'Date revision was requested',
    `submission_date` DATE COMMENT 'Date report was submitted',
    `submission_method` STRING COMMENT 'Method of submission',
    `supporting_document_reference` STRING COMMENT 'Attribute capturing the supporting document reference information for the donor report entity.',
    `version_number` STRING COMMENT 'Count or number of version items associated with this record.',
    CONSTRAINT pk_donor_report PRIMARY KEY(`donor_report_id`)
) COMMENT 'Tracks donor reporting obligations and submissions including financial and programmatic reports, compliance certifications, and donor feedback. Source systems: eTools, SAP. Systems-of-record: eTools, InSight, donor portals. Framework: IATI v2.03 result reporting / donor-specific templates (ECHO, USAID, DFID).';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`grant`.`funding_source` (
    `funding_source_id` BIGINT COMMENT 'Primary key',
    `partner_org_id` BIGINT COMMENT 'FK to partner organization',
    `advance_payment_allowed` DECIMAL(18,2) COMMENT 'Whether advance payments are allowed',
    `allowable_cost_categories` DECIMAL(18,2) COMMENT 'Attribute capturing the allowable cost categories information for the funding source entity.',
    `audit_requirement` STRING COMMENT 'Audit requirement description',
    `budget_flexibility` DECIMAL(18,2) COMMENT 'Budget flexibility rules',
    `budget_revision_threshold` DECIMAL(18,2) COMMENT 'Threshold for budget revision approval',
    `closeout_period_days` STRING COMMENT 'Days allowed for closeout',
    `funding_source_code` STRING COMMENT 'Standardized code representing the funding source classification or category.',
    `compliance_framework` STRING COMMENT 'Applicable compliance framework',
    `contact_email` STRING COMMENT 'Attribute capturing the contact email information for the funding source entity.',
    `contact_person_name` STRING COMMENT 'Human-readable name or label for the contact person.',
    `contact_phone` STRING COMMENT 'Contact phone number',
    `cost_share_percentage` DECIMAL(18,2) COMMENT 'Required cost share percentage',
    `cost_share_required` DECIMAL(18,2) COMMENT 'Whether cost share is required',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `currency_code` STRING COMMENT 'Standardized code representing the currency classification or category.',
    `funding_source_description` STRING COMMENT 'Detailed textual description providing context about the funding source.',
    `donor_reporting_frequency` STRING COMMENT 'Required reporting frequency',
    `endowment_net_appreciation_amount` DECIMAL(18,2) COMMENT 'Net appreciation amount',
    `endowment_principal_amount` DECIMAL(18,2) COMMENT 'Numeric value representing the endowment principal quantity or measurement.',
    `endowment_spending_policy_rate` DECIMAL(18,2) COMMENT 'Attribute capturing the endowment spending policy rate information for the funding source entity.',
    `fund_restriction_type` STRING COMMENT 'Classification type categorizing the fund restriction for this record.',
    `funding_end_date` DATE COMMENT 'End date of funding availability',
    `funding_mechanism_type` STRING COMMENT 'Type of funding mechanism',
    `funding_source_status` STRING COMMENT 'Current status',
    `funding_start_date` DATE COMMENT 'Start date of funding',
    `geographic_restriction` STRING COMMENT 'Geographic restrictions',
    `iati_organization_identifier` STRING COMMENT 'IATI org identifier',
    `indirect_cost_rate_type` DECIMAL(18,2) COMMENT 'Type of indirect cost rate',
    `is_endowment_fund` BOOLEAN COMMENT 'Whether this is an endowment fund',
    `is_membership_dues_source` BOOLEAN COMMENT 'Whether this is a membership dues source',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Last modification timestamp',
    `funding_source_name` STRING COMMENT 'Name of funding source',
    `nicra_rate` DOUBLE COMMENT 'Attribute capturing the nicra rate information for the funding source entity.',
    `oda_dac_classification` STRING COMMENT 'Attribute capturing the oda dac classification information for the funding source entity.',
    `payment_method` DECIMAL(18,2) COMMENT 'Attribute capturing the payment method information for the funding source entity.',
    `procurement_standards` STRING COMMENT 'Attribute capturing the procurement standards information for the funding source entity.',
    `program_income_treatment` STRING COMMENT 'Attribute capturing the program income treatment information for the funding source entity.',
    `record_retention_years` STRING COMMENT 'Years for record retention',
    `sdg_alignment_codes` STRING COMMENT 'Attribute capturing the sdg alignment codes information for the funding source entity.',
    `subaward_allowed` BOOLEAN COMMENT 'Whether subawards are allowed',
    `subaward_approval_required` BOOLEAN COMMENT 'Whether subaward approval is required',
    `thematic_restriction` STRING COMMENT 'Thematic restrictions',
    `total_funding_available` DECIMAL(18,2) COMMENT 'Attribute capturing the total funding available information for the funding source entity.',
    `unallowable_cost_categories` DECIMAL(18,2) COMMENT 'Attribute capturing the unallowable cost categories information for the funding source entity.',
    CONSTRAINT pk_funding_source PRIMARY KEY(`funding_source_id`)
) COMMENT 'Represents a funding source (donor entity or mechanism) with its compliance requirements, cost policies, and geographic/thematic restrictions. Source systems: SAP, Raisers Edge NXT.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`grant`.`prior_approval` (
    `prior_approval_id` BIGINT COMMENT 'Primary key',
    `award_id` BIGINT COMMENT 'FK to award',
    `budget_line_id` BIGINT COMMENT 'FK to budget line',
    `constituent_id` BIGINT COMMENT 'FK to donor',
    `grant_amendment_id` DECIMAL(18,2) COMMENT 'FK to resulting amendment',
    `indicator_id` BIGINT COMMENT 'FK to indicator',
    `intervention_id` BIGINT COMMENT 'FK to intervention',
    `staff_member_id` BIGINT COMMENT 'FK to responsible staff',
    `project_site_id` BIGINT COMMENT 'FK to project site',
    `acknowledgment_date` DATE COMMENT 'Date acknowledged',
    `approval_conditions` STRING COMMENT 'Conditions of approval',
    `approval_decision` STRING COMMENT 'Decision outcome',
    `approval_subtype` STRING COMMENT 'Subtype of approval',
    `approval_type` STRING COMMENT 'Type of approval',
    `approved_amount` DECIMAL(18,2) COMMENT 'Numeric value representing the approved quantity or measurement.',
    `approved_amount_currency` DECIMAL(18,2) COMMENT 'Currency of approved amount',
    `cost_category` DECIMAL(18,2) COMMENT 'Attribute capturing the cost category information for the prior approval entity.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `denial_reason` STRING COMMENT 'Reason for denial',
    `donor_contact_email` STRING COMMENT 'Attribute capturing the donor contact email information for the prior approval entity.',
    `donor_contact_name` STRING COMMENT 'Human-readable name or label for the donor contact.',
    `donor_response_document_reference` STRING COMMENT 'Reference to donor response',
    `effective_date` DATE COMMENT 'Date and time when the effective event occurred for this prior approval.',
    `expiration_date` DATE COMMENT 'Date and time when the expiration event occurred for this prior approval.',
    `follow_up_notes` STRING COMMENT 'Follow-up notes',
    `follow_up_required` BOOLEAN COMMENT 'Whether follow-up is required',
    `internal_approval_date` DATE COMMENT 'Date and time when the internal approval event occurred for this prior approval.',
    `is_emergency` BOOLEAN COMMENT 'Whether this is an emergency request',
    `is_retroactive` BOOLEAN COMMENT 'Whether this is retroactive',
    `justification` STRING COMMENT 'Attribute capturing the justification information for the prior approval entity.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Last modification timestamp',
    `notes` STRING COMMENT 'Free-text notes',
    `regulatory_basis` STRING COMMENT 'Attribute capturing the regulatory basis information for the prior approval entity.',
    `request_date` DATE COMMENT 'Date of request',
    `request_reference_number` STRING COMMENT 'Count or number of request reference items associated with this record.',
    `request_status` STRING COMMENT 'Current request status',
    `requested_amount` DECIMAL(18,2) COMMENT 'Numeric value representing the requested quantity or measurement.',
    `requested_amount_currency` DECIMAL(18,2) COMMENT 'Currency of requested amount',
    `response_date` DATE COMMENT 'Date of response',
    `response_due_date` DATE COMMENT 'Due date for response',
    `review_start_date` DATE COMMENT 'Date review started',
    `supporting_document_reference` STRING COMMENT 'Attribute capturing the supporting document reference information for the prior approval entity.',
    CONSTRAINT pk_prior_approval PRIMARY KEY(`prior_approval_id`)
) COMMENT 'Tracks prior approval requests to donors for budget changes, key personnel changes, and other actions requiring advance authorization. Source systems: eTools, SAP.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`grant`.`grant_closeout` (
    `grant_closeout_id` DECIMAL(18,2) COMMENT 'Primary key',
    `award_id` BIGINT COMMENT 'FK to award',
    `donor_report_id` BIGINT COMMENT 'FK to final donor report',
    `evaluation_id` BIGINT COMMENT 'FK to final evaluation',
    `regulatory_filing_id` BIGINT COMMENT 'FK to regulatory filing',
    `staff_member_id` BIGINT COMMENT 'FK to responsible staff',
    `closeout_status` STRING COMMENT 'Current closeout status',
    `closeout_type` STRING COMMENT 'Type of closeout',
    `completion_date` DATE COMMENT 'Closeout completion date',
    `compliance_certification_date` DATE COMMENT 'Date compliance was certified',
    `compliance_certified_by` STRING COMMENT 'Name of certifier',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `donor_acceptance_date` DATE COMMENT 'Date donor accepted closeout',
    `donor_closeout_contact_email` STRING COMMENT 'Attribute capturing the donor closeout contact email information for the grant closeout entity.',
    `donor_closeout_contact_name` STRING COMMENT 'Human-readable name or label for the donor closeout contact.',
    `equipment_disposition_date` DATE COMMENT 'Date of equipment disposition',
    `equipment_disposition_status` STRING COMMENT 'Status of equipment disposition',
    `final_audit_completion_date` DATE COMMENT 'Date final audit completed',
    `final_audit_reference` STRING COMMENT 'Reference to final audit',
    `final_audit_status` STRING COMMENT 'Status of final audit',
    `final_financial_report_due_date` DATE COMMENT 'Due date for final financial report',
    `final_financial_report_submission_date` DATE COMMENT 'Submission date of final financial report',
    `final_inventory_reference` STRING COMMENT 'Reference to final inventory',
    `final_inventory_submission_date` DATE COMMENT 'Date final inventory submitted',
    `final_programmatic_report_due_date` DATE COMMENT 'Due date for final programmatic report',
    `final_programmatic_report_reference` STRING COMMENT 'Reference to final programmatic report',
    `final_programmatic_report_submission_date` DATE COMMENT 'Submission date',
    `initiation_date` DATE COMMENT 'Date closeout was initiated',
    `intellectual_property_disposition` STRING COMMENT 'IP disposition',
    `last_modified_by` STRING COMMENT 'Reference to the user or entity that performed the last modified action.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Last modification timestamp',
    `notes` STRING COMMENT 'Free-text notes',
    `outstanding_issues_description` STRING COMMENT 'Description of outstanding issues',
    `outstanding_issues_flag` BOOLEAN COMMENT 'Whether there are outstanding issues',
    `period_of_performance_end_date` DATE COMMENT 'End of performance period',
    `records_destruction_date` DATE COMMENT 'Date records can be destroyed',
    `records_retention_end_date` DATE COMMENT 'End of records retention period',
    `reference_number` STRING COMMENT 'Closeout reference number',
    `unliquidated_obligations_amount` DECIMAL(18,2) COMMENT 'Unliquidated obligations',
    `unliquidated_obligations_disposition` STRING COMMENT 'Disposition of unliquidated obligations',
    `unobligated_balance_amount` DECIMAL(18,2) COMMENT 'Unobligated balance',
    `unobligated_balance_return_date` DATE COMMENT 'Date unobligated balance returned',
    CONSTRAINT pk_grant_closeout PRIMARY KEY(`grant_closeout_id`)
) COMMENT 'Manages the grant closeout process including final reports, audits, equipment disposition, and records retention. Source systems: SAP, eTools.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`grant`.`cost_share_commitment` (
    `cost_share_commitment_id` DECIMAL(18,2) COMMENT 'Primary key',
    `award_id` BIGINT COMMENT 'FK to award',
    `constituent_id` BIGINT COMMENT 'FK to donor',
    `inkind_donation_id` BIGINT COMMENT 'FK to in-kind donation',
    `intervention_id` BIGINT COMMENT 'FK to intervention',
    `partner_org_id` BIGINT COMMENT 'FK to partner org',
    `approval_date` DATE COMMENT 'Date and time when the approval event occurred for this cost share commitment.',
    `approved_by_name` STRING COMMENT 'Name of approver',
    `approved_by_title` STRING COMMENT 'Title of approver',
    `audit_finding_reference` STRING COMMENT 'Reference to audit finding',
    `commitment_date` DATE COMMENT 'Date of commitment',
    `commitment_notes` STRING COMMENT 'Attribute capturing the commitment notes information for the cost share commitment entity.',
    `commitment_reference_number` STRING COMMENT 'Reference number',
    `commitment_status` STRING COMMENT 'Current status',
    `committed_amount` DECIMAL(18,2) COMMENT 'Numeric value representing the committed quantity or measurement.',
    `compliance_status` STRING COMMENT 'Current status indicator for the compliance workflow state.',
    `cost_category` DECIMAL(18,2) COMMENT 'Attribute capturing the cost category information for the cost share commitment entity.',
    `cost_share_source_description` DECIMAL(18,2) COMMENT 'Description of source',
    `cost_share_type` DECIMAL(18,2) COMMENT 'Type of cost share',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `currency_code` STRING COMMENT 'Standardized code representing the currency classification or category.',
    `donor_approval_reference` STRING COMMENT 'Attribute capturing the donor approval reference information for the cost share commitment entity.',
    `fiscal_period` STRING COMMENT 'Attribute capturing the fiscal period information for the cost share commitment entity.',
    `fiscal_year` STRING COMMENT 'Attribute capturing the fiscal year information for the cost share commitment entity.',
    `gl_account_code` STRING COMMENT 'Standardized code representing the gl account classification or category.',
    `in_kind_valuation_method` STRING COMMENT 'Valuation method for in-kind',
    `is_mandatory` BOOLEAN COMMENT 'Whether mandatory',
    `is_restricted_fund` BOOLEAN COMMENT 'Whether restricted',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Last modification timestamp',
    `reporting_period_end_date` DATE COMMENT 'End of reporting period',
    `reporting_period_start_date` DATE COMMENT 'Start of reporting period',
    `required_cost_share_amount` DECIMAL(18,2) COMMENT 'Required amount',
    `required_cost_share_percentage` DECIMAL(18,2) COMMENT 'Required percentage',
    `source_organization_name` STRING COMMENT 'Source organization',
    `supporting_document_reference` STRING COMMENT 'Attribute capturing the supporting document reference information for the cost share commitment entity.',
    `variance_amount` DECIMAL(18,2) COMMENT 'Numeric value representing the variance quantity or measurement.',
    `variance_percentage` DOUBLE COMMENT 'Attribute capturing the variance percentage information for the cost share commitment entity.',
    `verification_date` DATE COMMENT 'Date and time when the verification event occurred for this cost share commitment.',
    `verification_method` STRING COMMENT 'Attribute capturing the verification method information for the cost share commitment entity.',
    `verified_amount` DECIMAL(18,2) COMMENT 'Numeric value representing the verified quantity or measurement.',
    `volunteer_hourly_rate` DOUBLE COMMENT 'Hourly rate for volunteer valuation',
    `volunteer_hours` DECIMAL(18,2) COMMENT 'Volunteer hours contributed',
    CONSTRAINT pk_cost_share_commitment PRIMARY KEY(`cost_share_commitment_id`)
) COMMENT 'Tracks cost share commitments and their verification, including in-kind contributions, volunteer hours, and third-party contributions. Source systems: SAP, eTools.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`grant`.`solicitation` (
    `solicitation_id` BIGINT COMMENT 'Primary key',
    `advocacy_campaign_id` BIGINT COMMENT 'FK to advocacy campaign',
    `country_office_id` BIGINT COMMENT 'FK to country office',
    `funding_source_id` BIGINT COMMENT 'FK to funding source',
    `indicator_id` BIGINT COMMENT 'FK to indicator',
    `constituent_id` BIGINT COMMENT 'FK to issuing donor',
    `anticipated_award_date` DATE COMMENT 'Date and time when the anticipated award event occurred for this solicitation.',
    `anticipated_start_date` DATE COMMENT 'Date and time when the anticipated start event occurred for this solicitation.',
    `application_deadline` TIMESTAMP COMMENT 'Attribute capturing the application deadline information for the solicitation entity.',
    `competitive_intelligence_notes` STRING COMMENT 'Attribute capturing the competitive intelligence notes information for the solicitation entity.',
    `consortium_allowed` BOOLEAN COMMENT 'Whether consortium is allowed',
    `contact_email` STRING COMMENT 'Attribute capturing the contact email information for the solicitation entity.',
    `contact_person_name` STRING COMMENT 'Human-readable name or label for the contact person.',
    `cost_share_percentage` DECIMAL(18,2) COMMENT 'Required cost share percentage',
    `cost_share_required` DECIMAL(18,2) COMMENT 'Whether cost share is required',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `dac_sector_code` STRING COMMENT 'Standardized code representing the dac sector classification or category.',
    `eligibility_criteria` STRING COMMENT 'Attribute capturing the eligibility criteria information for the solicitation entity.',
    `estimated_funding_amount` DECIMAL(18,2) COMMENT 'Numeric value representing the estimated funding quantity or measurement.',
    `estimated_number_of_awards` STRING COMMENT 'Attribute capturing the estimated number of awards information for the solicitation entity.',
    `funding_currency` STRING COMMENT 'Attribute capturing the funding currency information for the solicitation entity.',
    `geographic_eligibility` STRING COMMENT 'Attribute capturing the geographic eligibility information for the solicitation entity.',
    `go_no_go_decision_date` DATE COMMENT 'Go/no-go decision date',
    `go_no_go_rationale` DECIMAL(18,2) COMMENT 'Rationale for go/no-go decision',
    `identified_by` STRING COMMENT 'Who identified the opportunity',
    `identified_date` DATE COMMENT 'Date identified',
    `indirect_cost_rate_allowed` DECIMAL(18,2) COMMENT 'Allowed indirect cost rate',
    `indirect_cost_rate_cap` DECIMAL(18,2) COMMENT 'Cap on indirect cost rate',
    `internal_priority_score` DOUBLE COMMENT 'Attribute capturing the internal priority score information for the solicitation entity.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Last modification timestamp',
    `local_partner_requirement` STRING COMMENT 'Attribute capturing the local partner requirement information for the solicitation entity.',
    `notes` STRING COMMENT 'Free-text notes',
    `program_duration_months` DOUBLE COMMENT 'Program duration in months',
    `publication_date` DATE COMMENT 'Date and time when the publication event occurred for this solicitation.',
    `questions_deadline` TIMESTAMP COMMENT 'Deadline for questions',
    `sdg_alignment` STRING COMMENT 'Attribute capturing the sdg alignment information for the solicitation entity.',
    `solicitation_number` STRING COMMENT 'Count or number of solicitation items associated with this record.',
    `solicitation_status` STRING COMMENT 'Current status',
    `solicitation_type` STRING COMMENT 'Type of solicitation',
    `submission_method` STRING COMMENT 'Attribute capturing the submission method information for the solicitation entity.',
    `submission_requirements` STRING COMMENT 'Attribute capturing the submission requirements information for the solicitation entity.',
    `thematic_focus_area` STRING COMMENT 'Attribute capturing the thematic focus area information for the solicitation entity.',
    `title` STRING COMMENT 'Solicitation title',
    `url` STRING COMMENT 'URL to solicitation',
    CONSTRAINT pk_solicitation PRIMARY KEY(`solicitation_id`)
) COMMENT 'Tracks funding opportunities and solicitations from donors, including eligibility criteria, deadlines, and go/no-go decisions. Source systems: grants.gov, donor portals.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`grant`.`award_site_allocation` (
    `award_site_allocation_id` BIGINT COMMENT 'Primary key',
    `staff_member_id` BIGINT COMMENT 'FK to approving staff member',
    `award_id` BIGINT COMMENT 'FK to award',
    `country_office_id` BIGINT COMMENT 'FK to country office',
    `intervention_id` BIGINT COMMENT 'FK to intervention',
    `project_site_id` BIGINT COMMENT 'FK to project site',
    `actual_expenditure_at_site` TIMESTAMP COMMENT 'Attribute capturing the actual expenditure at site information for the award site allocation entity.',
    `allocated_currency_code` STRING COMMENT 'Currency of allocation',
    `allocation_end_date` DATE COMMENT 'End date of allocation',
    `allocation_notes` STRING COMMENT 'Notes on allocation',
    `allocation_percentage` DECIMAL(18,2) COMMENT 'Percentage allocated to site',
    `allocation_start_date` DATE COMMENT 'Start date of allocation',
    `approval_status` STRING COMMENT 'Current status indicator for the approval workflow state.',
    `beneficiary_actual_at_site` TIMESTAMP COMMENT 'Actual beneficiaries at site',
    `beneficiary_target_at_site` TIMESTAMP COMMENT 'Target beneficiary count',
    `committed_amount_at_site` TIMESTAMP COMMENT 'Attribute capturing the committed amount at site information for the award site allocation entity.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `currency_code` STRING COMMENT 'Standardized code representing the currency classification or category.',
    `expenditure_to_date` DATE COMMENT 'Expenditure to date at site',
    `geographic_focus_area` STRING COMMENT 'Attribute capturing the geographic focus area information for the award site allocation entity.',
    `is_primary_site` BOOLEAN COMMENT 'Whether this is the primary site',
    `last_monitoring_visit_date` DATE COMMENT 'Date of last monitoring visit',
    `reporting_period_end` DATE COMMENT 'End of reporting period',
    `reporting_period_start` DATE COMMENT 'Start of reporting period',
    `sector_code` STRING COMMENT 'Standardized code representing the sector classification or category.',
    `site_activation_date` DATE COMMENT 'Date site was activated',
    `site_budget_allocation` DECIMAL(18,2) COMMENT 'Budget allocated to site',
    `site_contact_email` STRING COMMENT 'Attribute capturing the site contact email information for the award site allocation entity.',
    `site_contact_name` STRING COMMENT 'Human-readable name or label for the site contact.',
    `site_deactivation_date` DATE COMMENT 'Date site was deactivated',
    `site_role_in_award` STRING COMMENT 'Role of site in award',
    `site_status` STRING COMMENT 'Current site status',
    `updated_timestamp` TIMESTAMP COMMENT 'Last update timestamp',
    CONSTRAINT pk_award_site_allocation PRIMARY KEY(`award_site_allocation_id`)
) COMMENT 'Tracks the allocation of award funding and beneficiary targets to specific project sites. Source systems: eTools, SAP.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`grant`.`asset_allocation` (
    `asset_allocation_id` BIGINT COMMENT 'Primary key',
    `award_id` BIGINT COMMENT 'FK to award',
    `it_asset_id` BIGINT COMMENT 'FK to IT asset',
    `allocation_end_date` DATE COMMENT 'End date of allocation',
    `allocation_justification` STRING COMMENT 'Justification for allocation',
    `allocation_percentage` DOUBLE COMMENT 'Percentage allocated',
    `allocation_start_date` DATE COMMENT 'Start date of allocation',
    `allocation_status` STRING COMMENT 'Current status',
    `cost_allocated` DECIMAL(18,2) COMMENT 'Cost allocated to award',
    `depreciation_allocation` DECIMAL(18,2) COMMENT 'Depreciation allocated',
    `disposal_date` DATE COMMENT 'Date of disposal',
    `donor_approval_date` DATE COMMENT 'Date donor approved',
    `donor_approval_required` BOOLEAN COMMENT 'Whether donor approval is required',
    `purchase_date` DATE COMMENT 'Date of purchase',
    CONSTRAINT pk_asset_allocation PRIMARY KEY(`asset_allocation_id`)
) COMMENT 'Tracks allocation of IT and physical assets to specific grant awards for cost allocation and disposition purposes. Source systems: SAP Asset Management.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`grant`.`award_position_funding` (
    `award_position_funding_id` BIGINT COMMENT 'Primary key',
    `award_id` BIGINT COMMENT 'FK to award',
    `position_id` BIGINT COMMENT 'FK to position',
    `allocation_currency_code` STRING COMMENT 'Currency of allocation',
    `cost_allocation_amount` DECIMAL(18,2) COMMENT 'Numeric value representing the cost allocation quantity or measurement.',
    `created_date` DATE COMMENT 'Record creation date',
    `effort_percent` DOUBLE COMMENT 'Percentage of effort on award',
    `end_date` DATE COMMENT 'End date of funding',
    `funding_status` STRING COMMENT 'Current funding status',
    `last_modified_date` DATE COMMENT 'Last modification date',
    `notes` STRING COMMENT 'Free-text notes',
    `start_date` DATE COMMENT 'Start date of funding',
    CONSTRAINT pk_award_position_funding PRIMARY KEY(`award_position_funding_id`)
) COMMENT 'Tracks the funding of workforce positions by specific grant awards, including effort percentages and cost allocations. Source systems: SAP HR, eTools.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`grant`.`grant_staff_assignment` (
    `grant_staff_assignment_id` DECIMAL(18,2) COMMENT 'Primary key',
    `award_id` BIGINT COMMENT 'FK to award',
    `staff_member_id` BIGINT COMMENT 'FK to approving staff',
    `grant_staff_member_id` BIGINT COMMENT 'FK to staff member',
    `workforce_staff_assignment_id` BIGINT COMMENT 'FK to workforce staff assignment',
    `approval_date` DATE COMMENT 'Date approved',
    `assignment_end_date` DATE COMMENT 'End date of assignment',
    `assignment_start_date` DATE COMMENT 'Start date of assignment',
    `assignment_status` STRING COMMENT 'Current status',
    `budgeted_fte` DECIMAL(18,2) COMMENT 'Attribute capturing the budgeted fte information for the grant staff assignment entity.',
    `cost_allocation_method` DECIMAL(18,2) COMMENT 'Attribute capturing the cost allocation method information for the grant staff assignment entity.',
    `effort_percent` DOUBLE COMMENT 'Effort percentage',
    `notes` STRING COMMENT 'Free-text notes',
    `role` STRING COMMENT 'Role on the grant',
    CONSTRAINT pk_grant_staff_assignment PRIMARY KEY(`grant_staff_assignment_id`)
) COMMENT 'Assigns staff members to specific grant awards with defined roles, effort percentages, and time periods. Source systems: SAP HR, eTools.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_ngo_v1`.`grant`.`sub_award_disbursement` ADD CONSTRAINT `fk_grant_sub_award_disbursement_award_id` FOREIGN KEY (`award_id`) REFERENCES `vibe_ngo_v1`.`grant`.`award`(`award_id`);
ALTER TABLE `vibe_ngo_v1`.`grant`.`sub_award_disbursement` ADD CONSTRAINT `fk_grant_sub_award_disbursement_subaward_id` FOREIGN KEY (`subaward_id`) REFERENCES `vibe_ngo_v1`.`grant`.`subaward`(`subaward_id`);
ALTER TABLE `vibe_ngo_v1`.`grant`.`proposal` ADD CONSTRAINT `fk_grant_proposal_award_id` FOREIGN KEY (`award_id`) REFERENCES `vibe_ngo_v1`.`grant`.`award`(`award_id`);
ALTER TABLE `vibe_ngo_v1`.`grant`.`proposal` ADD CONSTRAINT `fk_grant_proposal_solicitation_id` FOREIGN KEY (`solicitation_id`) REFERENCES `vibe_ngo_v1`.`grant`.`solicitation`(`solicitation_id`);
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget` ADD CONSTRAINT `fk_grant_award_budget_award_id` FOREIGN KEY (`award_id`) REFERENCES `vibe_ngo_v1`.`grant`.`award`(`award_id`);
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget` ADD CONSTRAINT `fk_grant_award_budget_grant_amendment_id` FOREIGN KEY (`grant_amendment_id`) REFERENCES `vibe_ngo_v1`.`grant`.`grant_amendment`(`grant_amendment_id`);
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget_line` ADD CONSTRAINT `fk_grant_award_budget_line_award_budget_id` FOREIGN KEY (`award_budget_id`) REFERENCES `vibe_ngo_v1`.`grant`.`award_budget`(`award_budget_id`);
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget_line` ADD CONSTRAINT `fk_grant_award_budget_line_award_id` FOREIGN KEY (`award_id`) REFERENCES `vibe_ngo_v1`.`grant`.`award`(`award_id`);
ALTER TABLE `vibe_ngo_v1`.`grant`.`grant_amendment` ADD CONSTRAINT `fk_grant_grant_amendment_award_id` FOREIGN KEY (`award_id`) REFERENCES `vibe_ngo_v1`.`grant`.`award`(`award_id`);
ALTER TABLE `vibe_ngo_v1`.`grant`.`grant_amendment` ADD CONSTRAINT `fk_grant_grant_amendment_supersedes_amendment_grant_amendment_id` FOREIGN KEY (`supersedes_amendment_grant_amendment_id`) REFERENCES `vibe_ngo_v1`.`grant`.`grant_amendment`(`grant_amendment_id`);
ALTER TABLE `vibe_ngo_v1`.`grant`.`subaward` ADD CONSTRAINT `fk_grant_subaward_award_id` FOREIGN KEY (`award_id`) REFERENCES `vibe_ngo_v1`.`grant`.`award`(`award_id`);
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_condition` ADD CONSTRAINT `fk_grant_donor_condition_award_id` FOREIGN KEY (`award_id`) REFERENCES `vibe_ngo_v1`.`grant`.`award`(`award_id`);
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_report` ADD CONSTRAINT `fk_grant_donor_report_award_id` FOREIGN KEY (`award_id`) REFERENCES `vibe_ngo_v1`.`grant`.`award`(`award_id`);
ALTER TABLE `vibe_ngo_v1`.`grant`.`prior_approval` ADD CONSTRAINT `fk_grant_prior_approval_award_id` FOREIGN KEY (`award_id`) REFERENCES `vibe_ngo_v1`.`grant`.`award`(`award_id`);
ALTER TABLE `vibe_ngo_v1`.`grant`.`prior_approval` ADD CONSTRAINT `fk_grant_prior_approval_grant_amendment_id` FOREIGN KEY (`grant_amendment_id`) REFERENCES `vibe_ngo_v1`.`grant`.`grant_amendment`(`grant_amendment_id`);
ALTER TABLE `vibe_ngo_v1`.`grant`.`grant_closeout` ADD CONSTRAINT `fk_grant_grant_closeout_award_id` FOREIGN KEY (`award_id`) REFERENCES `vibe_ngo_v1`.`grant`.`award`(`award_id`);
ALTER TABLE `vibe_ngo_v1`.`grant`.`grant_closeout` ADD CONSTRAINT `fk_grant_grant_closeout_donor_report_id` FOREIGN KEY (`donor_report_id`) REFERENCES `vibe_ngo_v1`.`grant`.`donor_report`(`donor_report_id`);
ALTER TABLE `vibe_ngo_v1`.`grant`.`cost_share_commitment` ADD CONSTRAINT `fk_grant_cost_share_commitment_award_id` FOREIGN KEY (`award_id`) REFERENCES `vibe_ngo_v1`.`grant`.`award`(`award_id`);
ALTER TABLE `vibe_ngo_v1`.`grant`.`solicitation` ADD CONSTRAINT `fk_grant_solicitation_funding_source_id` FOREIGN KEY (`funding_source_id`) REFERENCES `vibe_ngo_v1`.`grant`.`funding_source`(`funding_source_id`);
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_site_allocation` ADD CONSTRAINT `fk_grant_award_site_allocation_award_id` FOREIGN KEY (`award_id`) REFERENCES `vibe_ngo_v1`.`grant`.`award`(`award_id`);
ALTER TABLE `vibe_ngo_v1`.`grant`.`asset_allocation` ADD CONSTRAINT `fk_grant_asset_allocation_award_id` FOREIGN KEY (`award_id`) REFERENCES `vibe_ngo_v1`.`grant`.`award`(`award_id`);
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_position_funding` ADD CONSTRAINT `fk_grant_award_position_funding_award_id` FOREIGN KEY (`award_id`) REFERENCES `vibe_ngo_v1`.`grant`.`award`(`award_id`);
ALTER TABLE `vibe_ngo_v1`.`grant`.`grant_staff_assignment` ADD CONSTRAINT `fk_grant_grant_staff_assignment_award_id` FOREIGN KEY (`award_id`) REFERENCES `vibe_ngo_v1`.`grant`.`award`(`award_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_ngo_v1`.`grant` SET TAGS ('pii_division' = 'business');
ALTER SCHEMA `vibe_ngo_v1`.`grant` SET TAGS ('pii_domain' = 'grant');
ALTER TABLE `vibe_ngo_v1`.`grant`.`sub_award_disbursement` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_ngo_v1`.`grant`.`sub_award_disbursement` SET TAGS ('pii_subdomain' = 'subaward_management');
ALTER TABLE `vibe_ngo_v1`.`grant`.`sub_award_disbursement` SET TAGS ('pii_domain' = 'grant');
ALTER TABLE `vibe_ngo_v1`.`grant`.`sub_award_disbursement` SET TAGS ('pii_category' = 'financial');
ALTER TABLE `vibe_ngo_v1`.`grant`.`sub_award_disbursement` ALTER COLUMN `sub_award_disbursement_id` SET TAGS ('pii_business_glossary_term' = 'Sub-Award Disbursement ID');
ALTER TABLE `vibe_ngo_v1`.`grant`.`sub_award_disbursement` ALTER COLUMN `award_id` SET TAGS ('pii_business_glossary_term' = 'Award ID');
ALTER TABLE `vibe_ngo_v1`.`grant`.`sub_award_disbursement` ALTER COLUMN `budget_line_id` SET TAGS ('pii_business_glossary_term' = 'Budget Line ID');
ALTER TABLE `vibe_ngo_v1`.`grant`.`sub_award_disbursement` ALTER COLUMN `component_id` SET TAGS ('pii_business_glossary_term' = 'Component ID');
ALTER TABLE `vibe_ngo_v1`.`grant`.`sub_award_disbursement` ALTER COLUMN `partner_org_id` SET TAGS ('pii_business_glossary_term' = 'Partner Org ID');
ALTER TABLE `vibe_ngo_v1`.`grant`.`sub_award_disbursement` ALTER COLUMN `subaward_id` SET TAGS ('pii_business_glossary_term' = 'Subaward ID');
ALTER TABLE `vibe_ngo_v1`.`grant`.`sub_award_disbursement` ALTER COLUMN `advance_balance_outstanding` SET TAGS ('pii_business_glossary_term' = 'Advance Balance Outstanding');
ALTER TABLE `vibe_ngo_v1`.`grant`.`sub_award_disbursement` ALTER COLUMN `approval_date` SET TAGS ('pii_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_ngo_v1`.`grant`.`sub_award_disbursement` ALTER COLUMN `approved_by` SET TAGS ('pii_business_glossary_term' = 'Approved By');
ALTER TABLE `vibe_ngo_v1`.`grant`.`sub_award_disbursement` ALTER COLUMN `approved_by` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`grant`.`sub_award_disbursement` ALTER COLUMN `bank_transfer_reference` SET TAGS ('pii_business_glossary_term' = 'Bank Transfer Reference');
ALTER TABLE `vibe_ngo_v1`.`grant`.`sub_award_disbursement` ALTER COLUMN `cost_category` SET TAGS ('pii_business_glossary_term' = 'Cost Category');
ALTER TABLE `vibe_ngo_v1`.`grant`.`sub_award_disbursement` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_ngo_v1`.`grant`.`sub_award_disbursement` ALTER COLUMN `disbursement_amount` SET TAGS ('pii_business_glossary_term' = 'Disbursement Amount');
ALTER TABLE `vibe_ngo_v1`.`grant`.`sub_award_disbursement` ALTER COLUMN `disbursement_amount_usd` SET TAGS ('pii_business_glossary_term' = 'Disbursement Amount USD');
ALTER TABLE `vibe_ngo_v1`.`grant`.`sub_award_disbursement` ALTER COLUMN `disbursement_currency` SET TAGS ('pii_business_glossary_term' = 'Disbursement Currency');
ALTER TABLE `vibe_ngo_v1`.`grant`.`sub_award_disbursement` ALTER COLUMN `disbursement_date` SET TAGS ('pii_business_glossary_term' = 'Disbursement Date');
ALTER TABLE `vibe_ngo_v1`.`grant`.`sub_award_disbursement` ALTER COLUMN `disbursement_method` SET TAGS ('pii_business_glossary_term' = 'Disbursement Method');
ALTER TABLE `vibe_ngo_v1`.`grant`.`sub_award_disbursement` ALTER COLUMN `disbursement_notes` SET TAGS ('pii_business_glossary_term' = 'Disbursement Notes');
ALTER TABLE `vibe_ngo_v1`.`grant`.`sub_award_disbursement` ALTER COLUMN `disbursement_reference_number` SET TAGS ('pii_business_glossary_term' = 'Disbursement Reference Number');
ALTER TABLE `vibe_ngo_v1`.`grant`.`sub_award_disbursement` ALTER COLUMN `disbursement_status` SET TAGS ('pii_business_glossary_term' = 'Disbursement Status');
ALTER TABLE `vibe_ngo_v1`.`grant`.`sub_award_disbursement` ALTER COLUMN `disbursement_type` SET TAGS ('pii_business_glossary_term' = 'Disbursement Type');
ALTER TABLE `vibe_ngo_v1`.`grant`.`sub_award_disbursement` ALTER COLUMN `donor_reporting_category` SET TAGS ('pii_business_glossary_term' = 'Donor Reporting Category');
ALTER TABLE `vibe_ngo_v1`.`grant`.`sub_award_disbursement` ALTER COLUMN `exchange_rate` SET TAGS ('pii_business_glossary_term' = 'Exchange Rate');
ALTER TABLE `vibe_ngo_v1`.`grant`.`sub_award_disbursement` ALTER COLUMN `fiscal_period` SET TAGS ('pii_business_glossary_term' = 'Fiscal Period');
ALTER TABLE `vibe_ngo_v1`.`grant`.`sub_award_disbursement` ALTER COLUMN `fiscal_year` SET TAGS ('pii_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `vibe_ngo_v1`.`grant`.`sub_award_disbursement` ALTER COLUMN `fund_restriction_type` SET TAGS ('pii_business_glossary_term' = 'Fund Restriction Type');
ALTER TABLE `vibe_ngo_v1`.`grant`.`sub_award_disbursement` ALTER COLUMN `gl_account_code` SET TAGS ('pii_business_glossary_term' = 'GL Account Code');
ALTER TABLE `vibe_ngo_v1`.`grant`.`sub_award_disbursement` ALTER COLUMN `indirect_cost_amount` SET TAGS ('pii_business_glossary_term' = 'Indirect Cost Amount');
ALTER TABLE `vibe_ngo_v1`.`grant`.`sub_award_disbursement` ALTER COLUMN `is_emergency_disbursement` SET TAGS ('pii_business_glossary_term' = 'Is Emergency Disbursement');
ALTER TABLE `vibe_ngo_v1`.`grant`.`sub_award_disbursement` ALTER COLUMN `liquidated_amount` SET TAGS ('pii_business_glossary_term' = 'Liquidated Amount');
ALTER TABLE `vibe_ngo_v1`.`grant`.`sub_award_disbursement` ALTER COLUMN `liquidation_date` SET TAGS ('pii_business_glossary_term' = 'Liquidation Date');
ALTER TABLE `vibe_ngo_v1`.`grant`.`sub_award_disbursement` ALTER COLUMN `liquidation_deadline` SET TAGS ('pii_business_glossary_term' = 'Liquidation Deadline');
ALTER TABLE `vibe_ngo_v1`.`grant`.`sub_award_disbursement` ALTER COLUMN `liquidation_status` SET TAGS ('pii_business_glossary_term' = 'Liquidation Status');
ALTER TABLE `vibe_ngo_v1`.`grant`.`sub_award_disbursement` ALTER COLUMN `net_disbursement_amount` SET TAGS ('pii_business_glossary_term' = 'Net Disbursement Amount');
ALTER TABLE `vibe_ngo_v1`.`grant`.`sub_award_disbursement` ALTER COLUMN `nicra_rate_applied` SET TAGS ('pii_business_glossary_term' = 'NICRA Rate Applied');
ALTER TABLE `vibe_ngo_v1`.`grant`.`sub_award_disbursement` ALTER COLUMN `payment_terms` SET TAGS ('pii_business_glossary_term' = 'Payment Terms');
ALTER TABLE `vibe_ngo_v1`.`grant`.`sub_award_disbursement` ALTER COLUMN `post_distribution_monitoring_ref` SET TAGS ('pii_business_glossary_term' = 'Post Distribution Monitoring Reference');
ALTER TABLE `vibe_ngo_v1`.`grant`.`sub_award_disbursement` ALTER COLUMN `request_date` SET TAGS ('pii_business_glossary_term' = 'Request Date');
ALTER TABLE `vibe_ngo_v1`.`grant`.`sub_award_disbursement` ALTER COLUMN `supporting_document_reference` SET TAGS ('pii_business_glossary_term' = 'Supporting Document Reference');
ALTER TABLE `vibe_ngo_v1`.`grant`.`sub_award_disbursement` ALTER COLUMN `tranche_number` SET TAGS ('pii_business_glossary_term' = 'Tranche Number');
ALTER TABLE `vibe_ngo_v1`.`grant`.`sub_award_disbursement` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_ngo_v1`.`grant`.`sub_award_disbursement` ALTER COLUMN `withholding_amount` SET TAGS ('pii_business_glossary_term' = 'Withholding Amount');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award` SET TAGS ('pii_subdomain' = 'award_pipeline');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award` SET TAGS ('pii_domain' = 'grant');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award` SET TAGS ('pii_category' = 'award');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award` SET TAGS ('pii_column_comment_framework' = '2 CFR 200 + IPSAS 23 + IATI dual-framing');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award` ALTER COLUMN `award_id` SET TAGS ('pii_business_glossary_term' = 'Award ID');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award` ALTER COLUMN `award_constituent_id` SET TAGS ('pii_business_glossary_term' = 'Constituent ID');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award` ALTER COLUMN `award_constituent_id` SET TAGS ('pii_type' = 'personal');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award` ALTER COLUMN `constituent_id` SET TAGS ('pii_type' = 'personal');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award` ALTER COLUMN `country_office_id` SET TAGS ('pii_business_glossary_term' = 'Country Office ID');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award` ALTER COLUMN `intervention_id` SET TAGS ('pii_business_glossary_term' = 'Intervention ID');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award` ALTER COLUMN `advance_payment_allowed` SET TAGS ('pii_business_glossary_term' = 'Advance Payment Allowed');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award` ALTER COLUMN `agreement_signed_date` SET TAGS ('pii_business_glossary_term' = 'Agreement Signed Date');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award` ALTER COLUMN `amendment_count` SET TAGS ('pii_business_glossary_term' = 'Amendment Count');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award` ALTER COLUMN `audit_required` SET TAGS ('pii_business_glossary_term' = 'Audit Required');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award` ALTER COLUMN `audit_threshold_amount` SET TAGS ('pii_business_glossary_term' = 'Audit Threshold Amount');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award` ALTER COLUMN `authorized_amount` SET TAGS ('pii_business_glossary_term' = 'Authorized Amount');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award` ALTER COLUMN `award_number` SET TAGS ('pii_business_glossary_term' = 'Award Number');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award` ALTER COLUMN `award_status` SET TAGS ('pii_business_glossary_term' = 'Award Status');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award` ALTER COLUMN `award_type` SET TAGS ('pii_business_glossary_term' = 'Award Type');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award` ALTER COLUMN `board_approval_date` SET TAGS ('pii_business_glossary_term' = 'Board Approval Date');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award` ALTER COLUMN `board_approval_required` SET TAGS ('pii_business_glossary_term' = 'Board Approval Required');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award` ALTER COLUMN `board_resolution_reference` SET TAGS ('pii_business_glossary_term' = 'Board Resolution Reference');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award` ALTER COLUMN `branding_marking_requirements` SET TAGS ('pii_business_glossary_term' = 'Branding Marking Requirements');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award` ALTER COLUMN `closeout_date` SET TAGS ('pii_business_glossary_term' = 'Closeout Date');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award` ALTER COLUMN `cost_share_amount` SET TAGS ('pii_business_glossary_term' = 'Cost Share Amount');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award` ALTER COLUMN `cost_share_percentage` SET TAGS ('pii_business_glossary_term' = 'Cost Share Percentage');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award` ALTER COLUMN `cost_share_required` SET TAGS ('pii_business_glossary_term' = 'Cost Share Required');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award` ALTER COLUMN `currency` SET TAGS ('pii_business_glossary_term' = 'Currency');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award` ALTER COLUMN `dac_sector_code` SET TAGS ('pii_business_glossary_term' = 'DAC Sector Code');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award` ALTER COLUMN `donor_reference_number` SET TAGS ('pii_business_glossary_term' = 'Donor Reference Number');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award` ALTER COLUMN `end_date` SET TAGS ('pii_business_glossary_term' = 'End Date');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award` ALTER COLUMN `exchange_rate_to_functional` SET TAGS ('pii_business_glossary_term' = 'Exchange Rate to Functional');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award` ALTER COLUMN `functional_currency` SET TAGS ('pii_business_glossary_term' = 'Functional Currency');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award` ALTER COLUMN `fund_restriction_type` SET TAGS ('pii_business_glossary_term' = 'Fund Restriction Type');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award` ALTER COLUMN `funding_mechanism` SET TAGS ('pii_business_glossary_term' = 'Funding Mechanism');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award` ALTER COLUMN `geographic_scope` SET TAGS ('pii_business_glossary_term' = 'Geographic Scope');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award` ALTER COLUMN `grantmaking_program_area` SET TAGS ('pii_business_glossary_term' = 'Grantmaking Program Area');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award` ALTER COLUMN `indirect_cost_ceiling` SET TAGS ('pii_business_glossary_term' = 'Indirect Cost Ceiling');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award` ALTER COLUMN `is_grantmaking_out` SET TAGS ('pii_business_glossary_term' = 'Is Grantmaking Out');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award` ALTER COLUMN `last_amendment_date` SET TAGS ('pii_business_glossary_term' = 'Last Amendment Date');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award` ALTER COLUMN `nicra_icr_rate` SET TAGS ('pii_business_glossary_term' = 'NICRA ICR Rate');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award` ALTER COLUMN `notification_date` SET TAGS ('pii_business_glossary_term' = 'Notification Date');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award` ALTER COLUMN `original_end_date` SET TAGS ('pii_business_glossary_term' = 'Original End Date');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award` ALTER COLUMN `payment_method` SET TAGS ('pii_business_glossary_term' = 'Payment Method');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award` ALTER COLUMN `period_of_performance_months` SET TAGS ('pii_business_glossary_term' = 'Period of Performance Months');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award` ALTER COLUMN `primary_country_code` SET TAGS ('pii_business_glossary_term' = 'Primary Country Code');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award` ALTER COLUMN `regulatory_framework` SET TAGS ('pii_business_glossary_term' = 'Regulatory Framework');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award` ALTER COLUMN `reporting_frequency` SET TAGS ('pii_business_glossary_term' = 'Reporting Frequency');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award` ALTER COLUMN `sdg_alignment` SET TAGS ('pii_business_glossary_term' = 'SDG Alignment');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award` ALTER COLUMN `special_conditions` SET TAGS ('pii_business_glossary_term' = 'Special Conditions');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award` ALTER COLUMN `start_date` SET TAGS ('pii_business_glossary_term' = 'Start Date');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award` ALTER COLUMN `thematic_sector` SET TAGS ('pii_business_glossary_term' = 'Thematic Sector');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award` ALTER COLUMN `title` SET TAGS ('pii_business_glossary_term' = 'Title');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award` ALTER COLUMN `total_obligated_amount` SET TAGS ('pii_business_glossary_term' = 'Total Obligated Amount');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award` ALTER COLUMN `total_obligated_amount_functional` SET TAGS ('pii_business_glossary_term' = 'Total Obligated Amount Functional');
ALTER TABLE `vibe_ngo_v1`.`grant`.`proposal` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_ngo_v1`.`grant`.`proposal` SET TAGS ('pii_subdomain' = 'award_pipeline');
ALTER TABLE `vibe_ngo_v1`.`grant`.`proposal` SET TAGS ('pii_domain' = 'grant');
ALTER TABLE `vibe_ngo_v1`.`grant`.`proposal` SET TAGS ('pii_category' = 'business_development');
ALTER TABLE `vibe_ngo_v1`.`grant`.`proposal` ALTER COLUMN `proposal_id` SET TAGS ('pii_business_glossary_term' = 'Proposal ID');
ALTER TABLE `vibe_ngo_v1`.`grant`.`proposal` ALTER COLUMN `award_id` SET TAGS ('pii_business_glossary_term' = 'Award ID');
ALTER TABLE `vibe_ngo_v1`.`grant`.`proposal` ALTER COLUMN `component_id` SET TAGS ('pii_business_glossary_term' = 'Component ID');
ALTER TABLE `vibe_ngo_v1`.`grant`.`proposal` ALTER COLUMN `constituent_id` SET TAGS ('pii_type' = 'personal');
ALTER TABLE `vibe_ngo_v1`.`grant`.`proposal` ALTER COLUMN `country_office_id` SET TAGS ('pii_business_glossary_term' = 'Country Office ID');
ALTER TABLE `vibe_ngo_v1`.`grant`.`proposal` ALTER COLUMN `intervention_id` SET TAGS ('pii_business_glossary_term' = 'Intervention ID');
ALTER TABLE `vibe_ngo_v1`.`grant`.`proposal` ALTER COLUMN `mel_logframe_id` SET TAGS ('pii_business_glossary_term' = 'MEL Logframe ID');
ALTER TABLE `vibe_ngo_v1`.`grant`.`proposal` ALTER COLUMN `proposal_constituent_id` SET TAGS ('pii_business_glossary_term' = 'Constituent ID');
ALTER TABLE `vibe_ngo_v1`.`grant`.`proposal` ALTER COLUMN `proposal_constituent_id` SET TAGS ('pii_type' = 'personal');
ALTER TABLE `vibe_ngo_v1`.`grant`.`proposal` ALTER COLUMN `solicitation_id` SET TAGS ('pii_business_glossary_term' = 'Solicitation ID');
ALTER TABLE `vibe_ngo_v1`.`grant`.`proposal` ALTER COLUMN `staff_member_id` SET TAGS ('pii_type' = 'personal');
ALTER TABLE `vibe_ngo_v1`.`grant`.`proposal` ALTER COLUMN `award_notification_date` SET TAGS ('pii_business_glossary_term' = 'Award Notification Date');
ALTER TABLE `vibe_ngo_v1`.`grant`.`proposal` ALTER COLUMN `business_development_owner` SET TAGS ('pii_business_glossary_term' = 'Business Development Owner');
ALTER TABLE `vibe_ngo_v1`.`grant`.`proposal` ALTER COLUMN `business_development_owner` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`grant`.`proposal` ALTER COLUMN `compliance_review_completed` SET TAGS ('pii_business_glossary_term' = 'Compliance Review Completed');
ALTER TABLE `vibe_ngo_v1`.`grant`.`proposal` ALTER COLUMN `consortium_lead_organization` SET TAGS ('pii_business_glossary_term' = 'Consortium Lead Organization');
ALTER TABLE `vibe_ngo_v1`.`grant`.`proposal` ALTER COLUMN `cost_proposal_summary` SET TAGS ('pii_business_glossary_term' = 'Cost Proposal Summary');
ALTER TABLE `vibe_ngo_v1`.`grant`.`proposal` ALTER COLUMN `cost_share_amount` SET TAGS ('pii_business_glossary_term' = 'Cost Share Amount');
ALTER TABLE `vibe_ngo_v1`.`grant`.`proposal` ALTER COLUMN `cost_share_percentage` SET TAGS ('pii_business_glossary_term' = 'Cost Share Percentage');
ALTER TABLE `vibe_ngo_v1`.`grant`.`proposal` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_ngo_v1`.`grant`.`proposal` ALTER COLUMN `document_reference` SET TAGS ('pii_business_glossary_term' = 'Document Reference');
ALTER TABLE `vibe_ngo_v1`.`grant`.`proposal` ALTER COLUMN `geographic_focus` SET TAGS ('pii_business_glossary_term' = 'Geographic Focus');
ALTER TABLE `vibe_ngo_v1`.`grant`.`proposal` ALTER COLUMN `go_no_go_decision` SET TAGS ('pii_business_glossary_term' = 'Go/No-Go Decision');
ALTER TABLE `vibe_ngo_v1`.`grant`.`proposal` ALTER COLUMN `go_no_go_decision_date` SET TAGS ('pii_business_glossary_term' = 'Go/No-Go Decision Date');
ALTER TABLE `vibe_ngo_v1`.`grant`.`proposal` ALTER COLUMN `indirect_cost_rate_proposed` SET TAGS ('pii_business_glossary_term' = 'Indirect Cost Rate Proposed');
ALTER TABLE `vibe_ngo_v1`.`grant`.`proposal` ALTER COLUMN `internal_review_date` SET TAGS ('pii_business_glossary_term' = 'Internal Review Date');
ALTER TABLE `vibe_ngo_v1`.`grant`.`proposal` ALTER COLUMN `last_modified_timestamp` SET TAGS ('pii_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_ngo_v1`.`grant`.`proposal` ALTER COLUMN `lead_proposal_writer` SET TAGS ('pii_business_glossary_term' = 'Lead Proposal Writer');
ALTER TABLE `vibe_ngo_v1`.`grant`.`proposal` ALTER COLUMN `lead_proposal_writer` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`grant`.`proposal` ALTER COLUMN `lead_technical_sector` SET TAGS ('pii_business_glossary_term' = 'Lead Technical Sector');
ALTER TABLE `vibe_ngo_v1`.`grant`.`proposal` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_ngo_v1`.`grant`.`proposal` ALTER COLUMN `partnership_model` SET TAGS ('pii_business_glossary_term' = 'Partnership Model');
ALTER TABLE `vibe_ngo_v1`.`grant`.`proposal` ALTER COLUMN `proposal_status` SET TAGS ('pii_business_glossary_term' = 'Proposal Status');
ALTER TABLE `vibe_ngo_v1`.`grant`.`proposal` ALTER COLUMN `proposal_type` SET TAGS ('pii_business_glossary_term' = 'Proposal Type');
ALTER TABLE `vibe_ngo_v1`.`grant`.`proposal` ALTER COLUMN `proposed_duration_months` SET TAGS ('pii_business_glossary_term' = 'Proposed Duration Months');
ALTER TABLE `vibe_ngo_v1`.`grant`.`proposal` ALTER COLUMN `proposed_end_date` SET TAGS ('pii_business_glossary_term' = 'Proposed End Date');
ALTER TABLE `vibe_ngo_v1`.`grant`.`proposal` ALTER COLUMN `proposed_start_date` SET TAGS ('pii_business_glossary_term' = 'Proposed Start Date');
ALTER TABLE `vibe_ngo_v1`.`grant`.`proposal` ALTER COLUMN `reference_number` SET TAGS ('pii_business_glossary_term' = 'Reference Number');
ALTER TABLE `vibe_ngo_v1`.`grant`.`proposal` ALTER COLUMN `rejection_reason` SET TAGS ('pii_business_glossary_term' = 'Rejection Reason');
ALTER TABLE `vibe_ngo_v1`.`grant`.`proposal` ALTER COLUMN `requested_amount` SET TAGS ('pii_business_glossary_term' = 'Requested Amount');
ALTER TABLE `vibe_ngo_v1`.`grant`.`proposal` ALTER COLUMN `requested_amount_usd` SET TAGS ('pii_business_glossary_term' = 'Requested Amount USD');
ALTER TABLE `vibe_ngo_v1`.`grant`.`proposal` ALTER COLUMN `requested_currency` SET TAGS ('pii_business_glossary_term' = 'Requested Currency');
ALTER TABLE `vibe_ngo_v1`.`grant`.`proposal` ALTER COLUMN `submission_date` SET TAGS ('pii_business_glossary_term' = 'Submission Date');
ALTER TABLE `vibe_ngo_v1`.`grant`.`proposal` ALTER COLUMN `target_beneficiary_count` SET TAGS ('pii_business_glossary_term' = 'Target Beneficiary Count');
ALTER TABLE `vibe_ngo_v1`.`grant`.`proposal` ALTER COLUMN `technical_approach_summary` SET TAGS ('pii_business_glossary_term' = 'Technical Approach Summary');
ALTER TABLE `vibe_ngo_v1`.`grant`.`proposal` ALTER COLUMN `title` SET TAGS ('pii_business_glossary_term' = 'Title');
ALTER TABLE `vibe_ngo_v1`.`grant`.`proposal` ALTER COLUMN `win_loss_outcome` SET TAGS ('pii_business_glossary_term' = 'Win/Loss Outcome');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget` SET TAGS ('pii_subdomain' = 'budget_compliance');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget` SET TAGS ('pii_domain' = 'grant');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget` SET TAGS ('pii_category' = 'financial');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget` ALTER COLUMN `award_budget_id` SET TAGS ('pii_business_glossary_term' = 'Award Budget ID');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget` ALTER COLUMN `award_id` SET TAGS ('pii_business_glossary_term' = 'Award ID');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget` ALTER COLUMN `budget_id` SET TAGS ('pii_business_glossary_term' = 'Budget ID');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget` ALTER COLUMN `grant_amendment_id` SET TAGS ('pii_business_glossary_term' = 'Grant Amendment ID');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget` ALTER COLUMN `nicra_agreement_id` SET TAGS ('pii_business_glossary_term' = 'NICRA Agreement ID');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget` ALTER COLUMN `approved_by` SET TAGS ('pii_business_glossary_term' = 'Approved By');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget` ALTER COLUMN `approved_by` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget` ALTER COLUMN `award_currency` SET TAGS ('pii_business_glossary_term' = 'Award Currency');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget` ALTER COLUMN `budget_narrative_reference` SET TAGS ('pii_business_glossary_term' = 'Budget Narrative Reference');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget` ALTER COLUMN `budget_notes` SET TAGS ('pii_business_glossary_term' = 'Budget Notes');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget` ALTER COLUMN `budget_period` SET TAGS ('pii_business_glossary_term' = 'Budget Period');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget` ALTER COLUMN `budget_period_end_date` SET TAGS ('pii_business_glossary_term' = 'Budget Period End Date');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget` ALTER COLUMN `budget_period_start_date` SET TAGS ('pii_business_glossary_term' = 'Budget Period Start Date');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget` ALTER COLUMN `budget_status` SET TAGS ('pii_business_glossary_term' = 'Budget Status');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget` ALTER COLUMN `budget_submission_date` SET TAGS ('pii_business_glossary_term' = 'Budget Submission Date');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget` ALTER COLUMN `budget_version_number` SET TAGS ('pii_business_glossary_term' = 'Budget Version Number');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget` ALTER COLUMN `contractual_costs` SET TAGS ('pii_business_glossary_term' = 'Contractual Costs');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget` ALTER COLUMN `cost_share_amount` SET TAGS ('pii_business_glossary_term' = 'Cost Share Amount');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget` ALTER COLUMN `cost_share_required` SET TAGS ('pii_business_glossary_term' = 'Cost Share Required');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget` ALTER COLUMN `donor_approval_date` SET TAGS ('pii_business_glossary_term' = 'Donor Approval Date');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget` ALTER COLUMN `donor_approval_reference` SET TAGS ('pii_business_glossary_term' = 'Donor Approval Reference');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget` ALTER COLUMN `equipment_costs` SET TAGS ('pii_business_glossary_term' = 'Equipment Costs');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget` ALTER COLUMN `fringe_benefits_costs` SET TAGS ('pii_business_glossary_term' = 'Fringe Benefits Costs');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget` ALTER COLUMN `fund_restriction_type` SET TAGS ('pii_business_glossary_term' = 'Fund Restriction Type');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget` ALTER COLUMN `indirect_cost_base` SET TAGS ('pii_business_glossary_term' = 'Indirect Cost Base');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget` ALTER COLUMN `is_amendment` SET TAGS ('pii_business_glossary_term' = 'Is Amendment');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget` ALTER COLUMN `last_modified_timestamp` SET TAGS ('pii_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget` ALTER COLUMN `nicra_rate_applied` SET TAGS ('pii_business_glossary_term' = 'NICRA Rate Applied');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget` ALTER COLUMN `other_direct_costs` SET TAGS ('pii_business_glossary_term' = 'Other Direct Costs');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget` ALTER COLUMN `personnel_costs` SET TAGS ('pii_business_glossary_term' = 'Personnel Costs');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget` ALTER COLUMN `prepared_by` SET TAGS ('pii_business_glossary_term' = 'Prepared By');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget` ALTER COLUMN `prepared_by` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget` ALTER COLUMN `supplies_costs` SET TAGS ('pii_business_glossary_term' = 'Supplies Costs');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget` ALTER COLUMN `total_approved_budget` SET TAGS ('pii_business_glossary_term' = 'Total Approved Budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget` ALTER COLUMN `total_direct_costs` SET TAGS ('pii_business_glossary_term' = 'Total Direct Costs');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget` ALTER COLUMN `total_indirect_costs` SET TAGS ('pii_business_glossary_term' = 'Total Indirect Costs');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget` ALTER COLUMN `travel_costs` SET TAGS ('pii_business_glossary_term' = 'Travel Costs');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget_line` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget_line` SET TAGS ('pii_subdomain' = 'budget_compliance');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget_line` SET TAGS ('pii_domain' = 'grant');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget_line` SET TAGS ('pii_category' = 'financial');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget_line` ALTER COLUMN `award_budget_line_id` SET TAGS ('pii_business_glossary_term' = 'Award Budget Line ID');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget_line` ALTER COLUMN `award_budget_id` SET TAGS ('pii_business_glossary_term' = 'Award Budget ID');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget_line` ALTER COLUMN `award_id` SET TAGS ('pii_business_glossary_term' = 'Award ID');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget_line` ALTER COLUMN `component_id` SET TAGS ('pii_business_glossary_term' = 'Component ID');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget_line` ALTER COLUMN `budget_line_id` SET TAGS ('pii_business_glossary_term' = 'Finance Budget Line ID');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget_line` ALTER COLUMN `indicator_id` SET TAGS ('pii_business_glossary_term' = 'Indicator ID');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget_line` ALTER COLUMN `intervention_id` SET TAGS ('pii_business_glossary_term' = 'Intervention ID');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget_line` ALTER COLUMN `position_id` SET TAGS ('pii_business_glossary_term' = 'Position ID');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget_line` ALTER COLUMN `allocability_flag` SET TAGS ('pii_business_glossary_term' = 'Allocability Flag');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget_line` ALTER COLUMN `allowability_flag` SET TAGS ('pii_business_glossary_term' = 'Allowability Flag');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget_line` ALTER COLUMN `approval_date` SET TAGS ('pii_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget_line` ALTER COLUMN `approved_amount` SET TAGS ('pii_business_glossary_term' = 'Approved Amount');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget_line` ALTER COLUMN `approved_amount_usd` SET TAGS ('pii_business_glossary_term' = 'Approved Amount USD');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget_line` ALTER COLUMN `budget_line_status` SET TAGS ('pii_business_glossary_term' = 'Budget Line Status');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget_line` ALTER COLUMN `cost_category` SET TAGS ('pii_business_glossary_term' = 'Cost Category');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget_line` ALTER COLUMN `cost_share_amount` SET TAGS ('pii_business_glossary_term' = 'Cost Share Amount');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget_line` ALTER COLUMN `cost_share_required_flag` SET TAGS ('pii_business_glossary_term' = 'Cost Share Required Flag');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget_line` ALTER COLUMN `cost_subcategory` SET TAGS ('pii_business_glossary_term' = 'Cost Subcategory');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget_line` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget_line` ALTER COLUMN `cumulative_expenditure` SET TAGS ('pii_business_glossary_term' = 'Cumulative Expenditure');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget_line` ALTER COLUMN `cumulative_expenditure_usd` SET TAGS ('pii_business_glossary_term' = 'Cumulative Expenditure USD');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget_line` ALTER COLUMN `currency_code` SET TAGS ('pii_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget_line` ALTER COLUMN `donor_reporting_category` SET TAGS ('pii_business_glossary_term' = 'Donor Reporting Category');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget_line` ALTER COLUMN `exchange_rate` SET TAGS ('pii_business_glossary_term' = 'Exchange Rate');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget_line` ALTER COLUMN `fiscal_period` SET TAGS ('pii_business_glossary_term' = 'Fiscal Period');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget_line` ALTER COLUMN `fiscal_year` SET TAGS ('pii_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget_line` ALTER COLUMN `fund_restriction_type` SET TAGS ('pii_business_glossary_term' = 'Fund Restriction Type');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget_line` ALTER COLUMN `gl_account_code` SET TAGS ('pii_business_glossary_term' = 'GL Account Code');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget_line` ALTER COLUMN `indirect_cost_amount` SET TAGS ('pii_business_glossary_term' = 'Indirect Cost Amount');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget_line` ALTER COLUMN `line_description` SET TAGS ('pii_business_glossary_term' = 'Line Description');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget_line` ALTER COLUMN `line_item_code` SET TAGS ('pii_business_glossary_term' = 'Line Item Code');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget_line` ALTER COLUMN `modified_timestamp` SET TAGS ('pii_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget_line` ALTER COLUMN `nicra_rate_applied` SET TAGS ('pii_business_glossary_term' = 'NICRA Rate Applied');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget_line` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget_line` ALTER COLUMN `quantity` SET TAGS ('pii_business_glossary_term' = 'Quantity');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget_line` ALTER COLUMN `reasonableness_flag` SET TAGS ('pii_business_glossary_term' = 'Reasonableness Flag');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget_line` ALTER COLUMN `revised_amount` SET TAGS ('pii_business_glossary_term' = 'Revised Amount');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget_line` ALTER COLUMN `revised_amount_usd` SET TAGS ('pii_business_glossary_term' = 'Revised Amount USD');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget_line` ALTER COLUMN `revision_date` SET TAGS ('pii_business_glossary_term' = 'Revision Date');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget_line` ALTER COLUMN `revision_reason` SET TAGS ('pii_business_glossary_term' = 'Revision Reason');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget_line` ALTER COLUMN `supporting_document_reference` SET TAGS ('pii_business_glossary_term' = 'Supporting Document Reference');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget_line` ALTER COLUMN `unit_cost` SET TAGS ('pii_business_glossary_term' = 'Unit Cost');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget_line` ALTER COLUMN `unit_of_measure` SET TAGS ('pii_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget_line` ALTER COLUMN `variance_amount` SET TAGS ('pii_business_glossary_term' = 'Variance Amount');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget_line` ALTER COLUMN `variance_percentage` SET TAGS ('pii_business_glossary_term' = 'Variance Percentage');
ALTER TABLE `vibe_ngo_v1`.`grant`.`grant_amendment` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_ngo_v1`.`grant`.`grant_amendment` SET TAGS ('pii_subdomain' = 'award_pipeline');
ALTER TABLE `vibe_ngo_v1`.`grant`.`grant_amendment` SET TAGS ('pii_domain' = 'grant');
ALTER TABLE `vibe_ngo_v1`.`grant`.`grant_amendment` SET TAGS ('pii_category' = 'award');
ALTER TABLE `vibe_ngo_v1`.`grant`.`grant_amendment` ALTER COLUMN `grant_amendment_id` SET TAGS ('pii_business_glossary_term' = 'Grant Amendment ID');
ALTER TABLE `vibe_ngo_v1`.`grant`.`grant_amendment` ALTER COLUMN `award_id` SET TAGS ('pii_business_glossary_term' = 'Award ID');
ALTER TABLE `vibe_ngo_v1`.`grant`.`grant_amendment` ALTER COLUMN `indicator_target_id` SET TAGS ('pii_business_glossary_term' = 'Indicator Target ID');
ALTER TABLE `vibe_ngo_v1`.`grant`.`grant_amendment` ALTER COLUMN `mel_logframe_id` SET TAGS ('pii_business_glossary_term' = 'MEL Logframe ID');
ALTER TABLE `vibe_ngo_v1`.`grant`.`grant_amendment` ALTER COLUMN `supersedes_amendment_grant_amendment_id` SET TAGS ('pii_business_glossary_term' = 'Supersedes Amendment ID');
ALTER TABLE `vibe_ngo_v1`.`grant`.`grant_amendment` ALTER COLUMN `amendment_description` SET TAGS ('pii_business_glossary_term' = 'Amendment Description');
ALTER TABLE `vibe_ngo_v1`.`grant`.`grant_amendment` ALTER COLUMN `amendment_number` SET TAGS ('pii_business_glossary_term' = 'Amendment Number');
ALTER TABLE `vibe_ngo_v1`.`grant`.`grant_amendment` ALTER COLUMN `amendment_status` SET TAGS ('pii_business_glossary_term' = 'Amendment Status');
ALTER TABLE `vibe_ngo_v1`.`grant`.`grant_amendment` ALTER COLUMN `amendment_type` SET TAGS ('pii_business_glossary_term' = 'Amendment Type');
ALTER TABLE `vibe_ngo_v1`.`grant`.`grant_amendment` ALTER COLUMN `approval_date` SET TAGS ('pii_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_ngo_v1`.`grant`.`grant_amendment` ALTER COLUMN `approved_by_name` SET TAGS ('pii_business_glossary_term' = 'Approved By Name');
ALTER TABLE `vibe_ngo_v1`.`grant`.`grant_amendment` ALTER COLUMN `approved_by_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`grant`.`grant_amendment` ALTER COLUMN `approved_by_name` SET TAGS ('pii_type' = 'name');
ALTER TABLE `vibe_ngo_v1`.`grant`.`grant_amendment` ALTER COLUMN `approved_by_title` SET TAGS ('pii_business_glossary_term' = 'Approved By Title');
ALTER TABLE `vibe_ngo_v1`.`grant`.`grant_amendment` ALTER COLUMN `budget_modification_summary` SET TAGS ('pii_business_glossary_term' = 'Budget Modification Summary');
ALTER TABLE `vibe_ngo_v1`.`grant`.`grant_amendment` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_ngo_v1`.`grant`.`grant_amendment` ALTER COLUMN `currency_code` SET TAGS ('pii_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_ngo_v1`.`grant`.`grant_amendment` ALTER COLUMN `donor_approval_reference` SET TAGS ('pii_business_glossary_term' = 'Donor Approval Reference');
ALTER TABLE `vibe_ngo_v1`.`grant`.`grant_amendment` ALTER COLUMN `donor_prior_approval_required` SET TAGS ('pii_business_glossary_term' = 'Donor Prior Approval Required');
ALTER TABLE `vibe_ngo_v1`.`grant`.`grant_amendment` ALTER COLUMN `effective_date` SET TAGS ('pii_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_ngo_v1`.`grant`.`grant_amendment` ALTER COLUMN `execution_date` SET TAGS ('pii_business_glossary_term' = 'Execution Date');
ALTER TABLE `vibe_ngo_v1`.`grant`.`grant_amendment` ALTER COLUMN `funding_change` SET TAGS ('pii_business_glossary_term' = 'Funding Change');
ALTER TABLE `vibe_ngo_v1`.`grant`.`grant_amendment` ALTER COLUMN `geographic_change_description` SET TAGS ('pii_business_glossary_term' = 'Geographic Change Description');
ALTER TABLE `vibe_ngo_v1`.`grant`.`grant_amendment` ALTER COLUMN `internal_approval_date` SET TAGS ('pii_business_glossary_term' = 'Internal Approval Date');
ALTER TABLE `vibe_ngo_v1`.`grant`.`grant_amendment` ALTER COLUMN `internal_approver_name` SET TAGS ('pii_business_glossary_term' = 'Internal Approver Name');
ALTER TABLE `vibe_ngo_v1`.`grant`.`grant_amendment` ALTER COLUMN `internal_approver_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`grant`.`grant_amendment` ALTER COLUMN `internal_approver_name` SET TAGS ('pii_type' = 'name');
ALTER TABLE `vibe_ngo_v1`.`grant`.`grant_amendment` ALTER COLUMN `is_no_cost_extension` SET TAGS ('pii_business_glossary_term' = 'Is No Cost Extension');
ALTER TABLE `vibe_ngo_v1`.`grant`.`grant_amendment` ALTER COLUMN `justification` SET TAGS ('pii_business_glossary_term' = 'Justification');
ALTER TABLE `vibe_ngo_v1`.`grant`.`grant_amendment` ALTER COLUMN `key_personnel_change_description` SET TAGS ('pii_business_glossary_term' = 'Key Personnel Change Description');
ALTER TABLE `vibe_ngo_v1`.`grant`.`grant_amendment` ALTER COLUMN `last_modified_timestamp` SET TAGS ('pii_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_ngo_v1`.`grant`.`grant_amendment` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_ngo_v1`.`grant`.`grant_amendment` ALTER COLUMN `original_end_date` SET TAGS ('pii_business_glossary_term' = 'Original End Date');
ALTER TABLE `vibe_ngo_v1`.`grant`.`grant_amendment` ALTER COLUMN `original_start_date` SET TAGS ('pii_business_glossary_term' = 'Original Start Date');
ALTER TABLE `vibe_ngo_v1`.`grant`.`grant_amendment` ALTER COLUMN `original_total_obligation` SET TAGS ('pii_business_glossary_term' = 'Original Total Obligation');
ALTER TABLE `vibe_ngo_v1`.`grant`.`grant_amendment` ALTER COLUMN `period_extension_days` SET TAGS ('pii_business_glossary_term' = 'Period Extension Days');
ALTER TABLE `vibe_ngo_v1`.`grant`.`grant_amendment` ALTER COLUMN `request_date` SET TAGS ('pii_business_glossary_term' = 'Request Date');
ALTER TABLE `vibe_ngo_v1`.`grant`.`grant_amendment` ALTER COLUMN `revised_end_date` SET TAGS ('pii_business_glossary_term' = 'Revised End Date');
ALTER TABLE `vibe_ngo_v1`.`grant`.`grant_amendment` ALTER COLUMN `revised_start_date` SET TAGS ('pii_business_glossary_term' = 'Revised Start Date');
ALTER TABLE `vibe_ngo_v1`.`grant`.`grant_amendment` ALTER COLUMN `revised_total_obligation` SET TAGS ('pii_business_glossary_term' = 'Revised Total Obligation');
ALTER TABLE `vibe_ngo_v1`.`grant`.`grant_amendment` ALTER COLUMN `scope_change_description` SET TAGS ('pii_business_glossary_term' = 'Scope Change Description');
ALTER TABLE `vibe_ngo_v1`.`grant`.`grant_amendment` ALTER COLUMN `supporting_document_reference` SET TAGS ('pii_business_glossary_term' = 'Supporting Document Reference');
ALTER TABLE `vibe_ngo_v1`.`grant`.`grant_amendment` ALTER COLUMN `terms_and_conditions_change` SET TAGS ('pii_business_glossary_term' = 'Terms and Conditions Change');
ALTER TABLE `vibe_ngo_v1`.`grant`.`subaward` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_ngo_v1`.`grant`.`subaward` SET TAGS ('pii_subdomain' = 'subaward_management');
ALTER TABLE `vibe_ngo_v1`.`grant`.`subaward` SET TAGS ('pii_domain' = 'grant');
ALTER TABLE `vibe_ngo_v1`.`grant`.`subaward` SET TAGS ('pii_category' = 'subaward');
ALTER TABLE `vibe_ngo_v1`.`grant`.`subaward` ALTER COLUMN `subaward_id` SET TAGS ('pii_business_glossary_term' = 'Subaward ID');
ALTER TABLE `vibe_ngo_v1`.`grant`.`subaward` ALTER COLUMN `award_id` SET TAGS ('pii_business_glossary_term' = 'Award ID');
ALTER TABLE `vibe_ngo_v1`.`grant`.`subaward` ALTER COLUMN `impact_story_id` SET TAGS ('pii_business_glossary_term' = 'Impact Story ID');
ALTER TABLE `vibe_ngo_v1`.`grant`.`subaward` ALTER COLUMN `intervention_id` SET TAGS ('pii_business_glossary_term' = 'Intervention ID');
ALTER TABLE `vibe_ngo_v1`.`grant`.`subaward` ALTER COLUMN `partner_org_id` SET TAGS ('pii_business_glossary_term' = 'Partner Org ID');
ALTER TABLE `vibe_ngo_v1`.`grant`.`subaward` ALTER COLUMN `project_site_id` SET TAGS ('pii_business_glossary_term' = 'Project Site ID');
ALTER TABLE `vibe_ngo_v1`.`grant`.`subaward` ALTER COLUMN `amendment_count` SET TAGS ('pii_business_glossary_term' = 'Amendment Count');
ALTER TABLE `vibe_ngo_v1`.`grant`.`subaward` ALTER COLUMN `approval_date` SET TAGS ('pii_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_ngo_v1`.`grant`.`subaward` ALTER COLUMN `approved_by` SET TAGS ('pii_business_glossary_term' = 'Approved By');
ALTER TABLE `vibe_ngo_v1`.`grant`.`subaward` ALTER COLUMN `approved_by` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`grant`.`subaward` ALTER COLUMN `closeout_date` SET TAGS ('pii_business_glossary_term' = 'Closeout Date');
ALTER TABLE `vibe_ngo_v1`.`grant`.`subaward` ALTER COLUMN `cost_share_amount` SET TAGS ('pii_business_glossary_term' = 'Cost Share Amount');
ALTER TABLE `vibe_ngo_v1`.`grant`.`subaward` ALTER COLUMN `cost_share_required_flag` SET TAGS ('pii_business_glossary_term' = 'Cost Share Required Flag');
ALTER TABLE `vibe_ngo_v1`.`grant`.`subaward` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_ngo_v1`.`grant`.`subaward` ALTER COLUMN `currency` SET TAGS ('pii_business_glossary_term' = 'Currency');
ALTER TABLE `vibe_ngo_v1`.`grant`.`subaward` ALTER COLUMN `subaward_description` SET TAGS ('pii_business_glossary_term' = 'Subaward Description');
ALTER TABLE `vibe_ngo_v1`.`grant`.`subaward` ALTER COLUMN `disbursed_amount` SET TAGS ('pii_business_glossary_term' = 'Disbursed Amount');
ALTER TABLE `vibe_ngo_v1`.`grant`.`subaward` ALTER COLUMN `duns_number` SET TAGS ('pii_business_glossary_term' = 'DUNS Number');
ALTER TABLE `vibe_ngo_v1`.`grant`.`subaward` ALTER COLUMN `execution_date` SET TAGS ('pii_business_glossary_term' = 'Execution Date');
ALTER TABLE `vibe_ngo_v1`.`grant`.`subaward` ALTER COLUMN `ffata_reporting_required_flag` SET TAGS ('pii_business_glossary_term' = 'FFATA Reporting Required');
ALTER TABLE `vibe_ngo_v1`.`grant`.`subaward` ALTER COLUMN `flow_down_requirements` SET TAGS ('pii_business_glossary_term' = 'Flow Down Requirements');
ALTER TABLE `vibe_ngo_v1`.`grant`.`subaward` ALTER COLUMN `fsrs_report_date` SET TAGS ('pii_business_glossary_term' = 'FSRS Report Date');
ALTER TABLE `vibe_ngo_v1`.`grant`.`subaward` ALTER COLUMN `fund_restriction_type` SET TAGS ('pii_business_glossary_term' = 'Fund Restriction Type');
ALTER TABLE `vibe_ngo_v1`.`grant`.`subaward` ALTER COLUMN `grant_type_classification` SET TAGS ('pii_business_glossary_term' = 'Grant Type Classification');
ALTER TABLE `vibe_ngo_v1`.`grant`.`subaward` ALTER COLUMN `indirect_cost_base` SET TAGS ('pii_business_glossary_term' = 'Indirect Cost Base');
ALTER TABLE `vibe_ngo_v1`.`grant`.`subaward` ALTER COLUMN `indirect_cost_rate` SET TAGS ('pii_business_glossary_term' = 'Indirect Cost Rate');
ALTER TABLE `vibe_ngo_v1`.`grant`.`subaward` ALTER COLUMN `is_grantmaking_out_flow` SET TAGS ('pii_business_glossary_term' = 'Is Grantmaking Out Flow');
ALTER TABLE `vibe_ngo_v1`.`grant`.`subaward` ALTER COLUMN `last_modified_timestamp` SET TAGS ('pii_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_ngo_v1`.`grant`.`subaward` ALTER COLUMN `monitoring_frequency` SET TAGS ('pii_business_glossary_term' = 'Monitoring Frequency');
ALTER TABLE `vibe_ngo_v1`.`grant`.`subaward` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_ngo_v1`.`grant`.`subaward` ALTER COLUMN `obligated_amount` SET TAGS ('pii_business_glossary_term' = 'Obligated Amount');
ALTER TABLE `vibe_ngo_v1`.`grant`.`subaward` ALTER COLUMN `payment_method` SET TAGS ('pii_business_glossary_term' = 'Payment Method');
ALTER TABLE `vibe_ngo_v1`.`grant`.`subaward` ALTER COLUMN `payment_schedule` SET TAGS ('pii_business_glossary_term' = 'Payment Schedule');
ALTER TABLE `vibe_ngo_v1`.`grant`.`subaward` ALTER COLUMN `period_of_performance_end_date` SET TAGS ('pii_business_glossary_term' = 'Period of Performance End Date');
ALTER TABLE `vibe_ngo_v1`.`grant`.`subaward` ALTER COLUMN `period_of_performance_start_date` SET TAGS ('pii_business_glossary_term' = 'Period of Performance Start Date');
ALTER TABLE `vibe_ngo_v1`.`grant`.`subaward` ALTER COLUMN `remaining_balance` SET TAGS ('pii_business_glossary_term' = 'Remaining Balance');
ALTER TABLE `vibe_ngo_v1`.`grant`.`subaward` ALTER COLUMN `reporting_frequency` SET TAGS ('pii_business_glossary_term' = 'Reporting Frequency');
ALTER TABLE `vibe_ngo_v1`.`grant`.`subaward` ALTER COLUMN `risk_rating` SET TAGS ('pii_business_glossary_term' = 'Risk Rating');
ALTER TABLE `vibe_ngo_v1`.`grant`.`subaward` ALTER COLUMN `single_audit_required_flag` SET TAGS ('pii_business_glossary_term' = 'Single Audit Required');
ALTER TABLE `vibe_ngo_v1`.`grant`.`subaward` ALTER COLUMN `subaward_number` SET TAGS ('pii_business_glossary_term' = 'Subaward Number');
ALTER TABLE `vibe_ngo_v1`.`grant`.`subaward` ALTER COLUMN `subaward_status` SET TAGS ('pii_business_glossary_term' = 'Subaward Status');
ALTER TABLE `vibe_ngo_v1`.`grant`.`subaward` ALTER COLUMN `subaward_type` SET TAGS ('pii_business_glossary_term' = 'Subaward Type');
ALTER TABLE `vibe_ngo_v1`.`grant`.`subaward` ALTER COLUMN `termination_date` SET TAGS ('pii_business_glossary_term' = 'Termination Date');
ALTER TABLE `vibe_ngo_v1`.`grant`.`subaward` ALTER COLUMN `termination_reason` SET TAGS ('pii_business_glossary_term' = 'Termination Reason');
ALTER TABLE `vibe_ngo_v1`.`grant`.`subaward` ALTER COLUMN `title` SET TAGS ('pii_business_glossary_term' = 'Title');
ALTER TABLE `vibe_ngo_v1`.`grant`.`subaward` ALTER COLUMN `total_subaward_amount` SET TAGS ('pii_business_glossary_term' = 'Total Subaward Amount');
ALTER TABLE `vibe_ngo_v1`.`grant`.`subaward` ALTER COLUMN `total_subaward_amount_usd` SET TAGS ('pii_business_glossary_term' = 'Total Subaward Amount USD');
ALTER TABLE `vibe_ngo_v1`.`grant`.`subaward` ALTER COLUMN `uei_number` SET TAGS ('pii_business_glossary_term' = 'UEI Number');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_condition` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_condition` SET TAGS ('pii_subdomain' = 'budget_compliance');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_condition` SET TAGS ('pii_domain' = 'grant');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_condition` SET TAGS ('pii_category' = 'compliance');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_condition` ALTER COLUMN `donor_condition_id` SET TAGS ('pii_business_glossary_term' = 'Donor Condition ID');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_condition` ALTER COLUMN `award_id` SET TAGS ('pii_business_glossary_term' = 'Award ID');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_condition` ALTER COLUMN `constituent_id` SET TAGS ('pii_business_glossary_term' = 'Constituent ID');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_condition` ALTER COLUMN `constituent_id` SET TAGS ('pii_type' = 'personal');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_condition` ALTER COLUMN `evaluation_id` SET TAGS ('pii_business_glossary_term' = 'Evaluation ID');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_condition` ALTER COLUMN `indicator_id` SET TAGS ('pii_business_glossary_term' = 'Indicator ID');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_condition` ALTER COLUMN `staff_member_id` SET TAGS ('pii_business_glossary_term' = 'Staff Member ID');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_condition` ALTER COLUMN `staff_member_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_condition` ALTER COLUMN `staff_member_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_condition` ALTER COLUMN `actual_completion_date` SET TAGS ('pii_business_glossary_term' = 'Actual Completion Date');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_condition` ALTER COLUMN `approval_authority` SET TAGS ('pii_business_glossary_term' = 'Approval Authority');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_condition` ALTER COLUMN `approval_date` SET TAGS ('pii_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_condition` ALTER COLUMN `approval_reference_number` SET TAGS ('pii_business_glossary_term' = 'Approval Reference Number');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_condition` ALTER COLUMN `compliance_notes` SET TAGS ('pii_business_glossary_term' = 'Compliance Notes');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_condition` ALTER COLUMN `compliance_status` SET TAGS ('pii_business_glossary_term' = 'Compliance Status');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_condition` ALTER COLUMN `condition_category` SET TAGS ('pii_business_glossary_term' = 'Condition Category');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_condition` ALTER COLUMN `condition_description` SET TAGS ('pii_business_glossary_term' = 'Condition Description');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_condition` ALTER COLUMN `condition_reference_number` SET TAGS ('pii_business_glossary_term' = 'Condition Reference Number');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_condition` ALTER COLUMN `condition_title` SET TAGS ('pii_business_glossary_term' = 'Condition Title');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_condition` ALTER COLUMN `condition_type` SET TAGS ('pii_business_glossary_term' = 'Condition Type');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_condition` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_condition` ALTER COLUMN `deliverable_description` SET TAGS ('pii_business_glossary_term' = 'Deliverable Description');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_condition` ALTER COLUMN `donor_contact_email` SET TAGS ('pii_business_glossary_term' = 'Donor Contact Email');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_condition` ALTER COLUMN `donor_contact_email` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_condition` ALTER COLUMN `donor_contact_email` SET TAGS ('pii_type' = 'email');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_condition` ALTER COLUMN `donor_contact_name` SET TAGS ('pii_business_glossary_term' = 'Donor Contact Name');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_condition` ALTER COLUMN `donor_contact_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_condition` ALTER COLUMN `donor_contact_name` SET TAGS ('pii_type' = 'name');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_condition` ALTER COLUMN `due_date` SET TAGS ('pii_business_glossary_term' = 'Due Date');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_condition` ALTER COLUMN `escalation_threshold_days` SET TAGS ('pii_business_glossary_term' = 'Escalation Threshold Days');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_condition` ALTER COLUMN `financial_threshold_amount` SET TAGS ('pii_business_glossary_term' = 'Financial Threshold Amount');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_condition` ALTER COLUMN `financial_threshold_currency` SET TAGS ('pii_business_glossary_term' = 'Financial Threshold Currency');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_condition` ALTER COLUMN `is_membership_obligation` SET TAGS ('pii_business_glossary_term' = 'Is Membership Obligation');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_condition` ALTER COLUMN `is_special_award_condition` SET TAGS ('pii_business_glossary_term' = 'Is Special Award Condition');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_condition` ALTER COLUMN `last_review_date` SET TAGS ('pii_business_glossary_term' = 'Last Review Date');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_condition` ALTER COLUMN `membership_dues_amount` SET TAGS ('pii_business_glossary_term' = 'Membership Dues Amount');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_condition` ALTER COLUMN `membership_renewal_date` SET TAGS ('pii_business_glossary_term' = 'Membership Renewal Date');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_condition` ALTER COLUMN `modified_by` SET TAGS ('pii_business_glossary_term' = 'Modified By');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_condition` ALTER COLUMN `modified_timestamp` SET TAGS ('pii_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_condition` ALTER COLUMN `monitoring_frequency` SET TAGS ('pii_business_glossary_term' = 'Monitoring Frequency');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_condition` ALTER COLUMN `next_recurrence_date` SET TAGS ('pii_business_glossary_term' = 'Next Recurrence Date');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_condition` ALTER COLUMN `next_review_date` SET TAGS ('pii_business_glossary_term' = 'Next Review Date');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_condition` ALTER COLUMN `priority_level` SET TAGS ('pii_business_glossary_term' = 'Priority Level');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_condition` ALTER COLUMN `recurrence_frequency` SET TAGS ('pii_business_glossary_term' = 'Recurrence Frequency');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_condition` ALTER COLUMN `regulatory_citation` SET TAGS ('pii_business_glossary_term' = 'Regulatory Citation');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_condition` ALTER COLUMN `responsible_department` SET TAGS ('pii_business_glossary_term' = 'Responsible Department');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_condition` ALTER COLUMN `risk_rating` SET TAGS ('pii_business_glossary_term' = 'Risk Rating');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_condition` ALTER COLUMN `sac_justification` SET TAGS ('pii_business_glossary_term' = 'SAC Justification');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_condition` ALTER COLUMN `supporting_document_reference` SET TAGS ('pii_business_glossary_term' = 'Supporting Document Reference');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_condition` ALTER COLUMN `waiver_date` SET TAGS ('pii_business_glossary_term' = 'Waiver Date');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_condition` ALTER COLUMN `waiver_justification` SET TAGS ('pii_business_glossary_term' = 'Waiver Justification');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_condition` ALTER COLUMN `created_by` SET TAGS ('pii_business_glossary_term' = 'Created By');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_report` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_report` SET TAGS ('pii_subdomain' = 'budget_compliance');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_report` SET TAGS ('pii_domain' = 'grant');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_report` SET TAGS ('pii_category' = 'reporting');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_report` SET TAGS ('pii_column_comment_framework' = 'IATI + donor-specific');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_report` ALTER COLUMN `donor_report_id` SET TAGS ('pii_business_glossary_term' = 'Donor Report ID');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_report` ALTER COLUMN `award_id` SET TAGS ('pii_business_glossary_term' = 'Award ID');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_report` ALTER COLUMN `intervention_id` SET TAGS ('pii_business_glossary_term' = 'Intervention ID');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_report` ALTER COLUMN `staff_member_id` SET TAGS ('pii_business_glossary_term' = 'Primary Donor Staff Member ID');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_report` ALTER COLUMN `staff_member_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_report` ALTER COLUMN `staff_member_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_report` ALTER COLUMN `project_site_id` SET TAGS ('pii_business_glossary_term' = 'Project Site ID');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_report` ALTER COLUMN `regulatory_filing_id` SET TAGS ('pii_business_glossary_term' = 'Regulatory Filing ID');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_report` ALTER COLUMN `approval_date` SET TAGS ('pii_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_report` ALTER COLUMN `audit_findings_count` SET TAGS ('pii_business_glossary_term' = 'Audit Findings Count');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_report` ALTER COLUMN `beneficiaries_reached` SET TAGS ('pii_business_glossary_term' = 'Beneficiaries Reached');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_report` ALTER COLUMN `budget_variance_amount` SET TAGS ('pii_business_glossary_term' = 'Budget Variance Amount');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_report` ALTER COLUMN `budget_variance_percentage` SET TAGS ('pii_business_glossary_term' = 'Budget Variance Percentage');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_report` ALTER COLUMN `compliance_certification_flag` SET TAGS ('pii_business_glossary_term' = 'Compliance Certification Flag');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_report` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_report` ALTER COLUMN `cumulative_expenditure_to_date` SET TAGS ('pii_business_glossary_term' = 'Cumulative Expenditure to Date');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_report` ALTER COLUMN `days_overdue` SET TAGS ('pii_business_glossary_term' = 'Days Overdue');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_report` ALTER COLUMN `donor_acceptance_date` SET TAGS ('pii_business_glossary_term' = 'Donor Acceptance Date');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_report` ALTER COLUMN `donor_feedback_summary` SET TAGS ('pii_business_glossary_term' = 'Donor Feedback Summary');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_report` ALTER COLUMN `due_date` SET TAGS ('pii_business_glossary_term' = 'Due Date');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_report` ALTER COLUMN `exchange_rate_used` SET TAGS ('pii_business_glossary_term' = 'Exchange Rate Used');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_report` ALTER COLUMN `financial_amount_reported` SET TAGS ('pii_business_glossary_term' = 'Financial Amount Reported');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_report` ALTER COLUMN `financial_amount_reported_usd` SET TAGS ('pii_business_glossary_term' = 'Financial Amount Reported USD');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_report` ALTER COLUMN `financial_currency` SET TAGS ('pii_business_glossary_term' = 'Financial Currency');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_report` ALTER COLUMN `is_final_version` SET TAGS ('pii_business_glossary_term' = 'Is Final Version');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_report` ALTER COLUMN `is_overdue` SET TAGS ('pii_business_glossary_term' = 'Is Overdue');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_report` ALTER COLUMN `key_performance_indicators_met` SET TAGS ('pii_business_glossary_term' = 'KPIs Met');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_report` ALTER COLUMN `key_performance_indicators_total` SET TAGS ('pii_business_glossary_term' = 'KPIs Total');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_report` ALTER COLUMN `last_modified_timestamp` SET TAGS ('pii_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_report` ALTER COLUMN `narrative_summary` SET TAGS ('pii_business_glossary_term' = 'Narrative Summary');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_report` ALTER COLUMN `report_notes` SET TAGS ('pii_business_glossary_term' = 'Report Notes');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_report` ALTER COLUMN `report_reference_number` SET TAGS ('pii_business_glossary_term' = 'Report Reference Number');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_report` ALTER COLUMN `report_status` SET TAGS ('pii_business_glossary_term' = 'Report Status');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_report` ALTER COLUMN `report_type` SET TAGS ('pii_business_glossary_term' = 'Report Type');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_report` ALTER COLUMN `reporting_frequency` SET TAGS ('pii_business_glossary_term' = 'Reporting Frequency');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_report` ALTER COLUMN `reporting_period_end_date` SET TAGS ('pii_business_glossary_term' = 'Reporting Period End Date');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_report` ALTER COLUMN `reporting_period_start_date` SET TAGS ('pii_business_glossary_term' = 'Reporting Period Start Date');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_report` ALTER COLUMN `revision_reason` SET TAGS ('pii_business_glossary_term' = 'Revision Reason');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_report` ALTER COLUMN `revision_requested_date` SET TAGS ('pii_business_glossary_term' = 'Revision Requested Date');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_report` ALTER COLUMN `submission_date` SET TAGS ('pii_business_glossary_term' = 'Submission Date');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_report` ALTER COLUMN `submission_method` SET TAGS ('pii_business_glossary_term' = 'Submission Method');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_report` ALTER COLUMN `supporting_document_reference` SET TAGS ('pii_business_glossary_term' = 'Supporting Document Reference');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_report` ALTER COLUMN `version_number` SET TAGS ('pii_business_glossary_term' = 'Version Number');
ALTER TABLE `vibe_ngo_v1`.`grant`.`funding_source` SET TAGS ('pii_data_type' = 'reference_data');
ALTER TABLE `vibe_ngo_v1`.`grant`.`funding_source` SET TAGS ('pii_subdomain' = 'award_pipeline');
ALTER TABLE `vibe_ngo_v1`.`grant`.`funding_source` SET TAGS ('pii_domain' = 'grant');
ALTER TABLE `vibe_ngo_v1`.`grant`.`funding_source` SET TAGS ('pii_category' = 'funding');
ALTER TABLE `vibe_ngo_v1`.`grant`.`funding_source` ALTER COLUMN `funding_source_id` SET TAGS ('pii_business_glossary_term' = 'Funding Source ID');
ALTER TABLE `vibe_ngo_v1`.`grant`.`funding_source` ALTER COLUMN `partner_org_id` SET TAGS ('pii_business_glossary_term' = 'Partner Org ID');
ALTER TABLE `vibe_ngo_v1`.`grant`.`funding_source` ALTER COLUMN `advance_payment_allowed` SET TAGS ('pii_business_glossary_term' = 'Advance Payment Allowed');
ALTER TABLE `vibe_ngo_v1`.`grant`.`funding_source` ALTER COLUMN `allowable_cost_categories` SET TAGS ('pii_business_glossary_term' = 'Allowable Cost Categories');
ALTER TABLE `vibe_ngo_v1`.`grant`.`funding_source` ALTER COLUMN `audit_requirement` SET TAGS ('pii_business_glossary_term' = 'Audit Requirement');
ALTER TABLE `vibe_ngo_v1`.`grant`.`funding_source` ALTER COLUMN `budget_flexibility` SET TAGS ('pii_business_glossary_term' = 'Budget Flexibility');
ALTER TABLE `vibe_ngo_v1`.`grant`.`funding_source` ALTER COLUMN `budget_revision_threshold` SET TAGS ('pii_business_glossary_term' = 'Budget Revision Threshold');
ALTER TABLE `vibe_ngo_v1`.`grant`.`funding_source` ALTER COLUMN `closeout_period_days` SET TAGS ('pii_business_glossary_term' = 'Closeout Period Days');
ALTER TABLE `vibe_ngo_v1`.`grant`.`funding_source` ALTER COLUMN `funding_source_code` SET TAGS ('pii_business_glossary_term' = 'Funding Source Code');
ALTER TABLE `vibe_ngo_v1`.`grant`.`funding_source` ALTER COLUMN `compliance_framework` SET TAGS ('pii_business_glossary_term' = 'Compliance Framework');
ALTER TABLE `vibe_ngo_v1`.`grant`.`funding_source` ALTER COLUMN `contact_email` SET TAGS ('pii_business_glossary_term' = 'Contact Email');
ALTER TABLE `vibe_ngo_v1`.`grant`.`funding_source` ALTER COLUMN `contact_email` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`grant`.`funding_source` ALTER COLUMN `contact_email` SET TAGS ('pii_type' = 'email');
ALTER TABLE `vibe_ngo_v1`.`grant`.`funding_source` ALTER COLUMN `contact_person_name` SET TAGS ('pii_business_glossary_term' = 'Contact Person Name');
ALTER TABLE `vibe_ngo_v1`.`grant`.`funding_source` ALTER COLUMN `contact_person_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`grant`.`funding_source` ALTER COLUMN `contact_person_name` SET TAGS ('pii_type' = 'name');
ALTER TABLE `vibe_ngo_v1`.`grant`.`funding_source` ALTER COLUMN `contact_phone` SET TAGS ('pii_business_glossary_term' = 'Contact Phone');
ALTER TABLE `vibe_ngo_v1`.`grant`.`funding_source` ALTER COLUMN `contact_phone` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`grant`.`funding_source` ALTER COLUMN `contact_phone` SET TAGS ('pii_type' = 'phone');
ALTER TABLE `vibe_ngo_v1`.`grant`.`funding_source` ALTER COLUMN `cost_share_percentage` SET TAGS ('pii_business_glossary_term' = 'Cost Share Percentage');
ALTER TABLE `vibe_ngo_v1`.`grant`.`funding_source` ALTER COLUMN `cost_share_required` SET TAGS ('pii_business_glossary_term' = 'Cost Share Required');
ALTER TABLE `vibe_ngo_v1`.`grant`.`funding_source` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_ngo_v1`.`grant`.`funding_source` ALTER COLUMN `currency_code` SET TAGS ('pii_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_ngo_v1`.`grant`.`funding_source` ALTER COLUMN `funding_source_description` SET TAGS ('pii_business_glossary_term' = 'Funding Source Description');
ALTER TABLE `vibe_ngo_v1`.`grant`.`funding_source` ALTER COLUMN `donor_reporting_frequency` SET TAGS ('pii_business_glossary_term' = 'Donor Reporting Frequency');
ALTER TABLE `vibe_ngo_v1`.`grant`.`funding_source` ALTER COLUMN `endowment_net_appreciation_amount` SET TAGS ('pii_business_glossary_term' = 'Endowment Net Appreciation Amount');
ALTER TABLE `vibe_ngo_v1`.`grant`.`funding_source` ALTER COLUMN `endowment_principal_amount` SET TAGS ('pii_business_glossary_term' = 'Endowment Principal Amount');
ALTER TABLE `vibe_ngo_v1`.`grant`.`funding_source` ALTER COLUMN `endowment_spending_policy_rate` SET TAGS ('pii_business_glossary_term' = 'Endowment Spending Policy Rate');
ALTER TABLE `vibe_ngo_v1`.`grant`.`funding_source` ALTER COLUMN `fund_restriction_type` SET TAGS ('pii_business_glossary_term' = 'Fund Restriction Type');
ALTER TABLE `vibe_ngo_v1`.`grant`.`funding_source` ALTER COLUMN `funding_end_date` SET TAGS ('pii_business_glossary_term' = 'Funding End Date');
ALTER TABLE `vibe_ngo_v1`.`grant`.`funding_source` ALTER COLUMN `funding_mechanism_type` SET TAGS ('pii_business_glossary_term' = 'Funding Mechanism Type');
ALTER TABLE `vibe_ngo_v1`.`grant`.`funding_source` ALTER COLUMN `funding_source_status` SET TAGS ('pii_business_glossary_term' = 'Funding Source Status');
ALTER TABLE `vibe_ngo_v1`.`grant`.`funding_source` ALTER COLUMN `funding_start_date` SET TAGS ('pii_business_glossary_term' = 'Funding Start Date');
ALTER TABLE `vibe_ngo_v1`.`grant`.`funding_source` ALTER COLUMN `geographic_restriction` SET TAGS ('pii_business_glossary_term' = 'Geographic Restriction');
ALTER TABLE `vibe_ngo_v1`.`grant`.`funding_source` ALTER COLUMN `iati_organization_identifier` SET TAGS ('pii_business_glossary_term' = 'IATI Organization Identifier');
ALTER TABLE `vibe_ngo_v1`.`grant`.`funding_source` ALTER COLUMN `indirect_cost_rate_type` SET TAGS ('pii_business_glossary_term' = 'Indirect Cost Rate Type');
ALTER TABLE `vibe_ngo_v1`.`grant`.`funding_source` ALTER COLUMN `is_endowment_fund` SET TAGS ('pii_business_glossary_term' = 'Is Endowment Fund');
ALTER TABLE `vibe_ngo_v1`.`grant`.`funding_source` ALTER COLUMN `is_membership_dues_source` SET TAGS ('pii_business_glossary_term' = 'Is Membership Dues Source');
ALTER TABLE `vibe_ngo_v1`.`grant`.`funding_source` ALTER COLUMN `last_modified_timestamp` SET TAGS ('pii_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_ngo_v1`.`grant`.`funding_source` ALTER COLUMN `funding_source_name` SET TAGS ('pii_business_glossary_term' = 'Funding Source Name');
ALTER TABLE `vibe_ngo_v1`.`grant`.`funding_source` ALTER COLUMN `funding_source_name` SET TAGS ('pii_type' = 'name');
ALTER TABLE `vibe_ngo_v1`.`grant`.`funding_source` ALTER COLUMN `nicra_rate` SET TAGS ('pii_business_glossary_term' = 'NICRA Rate');
ALTER TABLE `vibe_ngo_v1`.`grant`.`funding_source` ALTER COLUMN `oda_dac_classification` SET TAGS ('pii_business_glossary_term' = 'ODA DAC Classification');
ALTER TABLE `vibe_ngo_v1`.`grant`.`funding_source` ALTER COLUMN `payment_method` SET TAGS ('pii_business_glossary_term' = 'Payment Method');
ALTER TABLE `vibe_ngo_v1`.`grant`.`funding_source` ALTER COLUMN `procurement_standards` SET TAGS ('pii_business_glossary_term' = 'Procurement Standards');
ALTER TABLE `vibe_ngo_v1`.`grant`.`funding_source` ALTER COLUMN `program_income_treatment` SET TAGS ('pii_business_glossary_term' = 'Program Income Treatment');
ALTER TABLE `vibe_ngo_v1`.`grant`.`funding_source` ALTER COLUMN `program_income_treatment` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`funding_source` ALTER COLUMN `program_income_treatment` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`funding_source` ALTER COLUMN `record_retention_years` SET TAGS ('pii_business_glossary_term' = 'Record Retention Years');
ALTER TABLE `vibe_ngo_v1`.`grant`.`funding_source` ALTER COLUMN `sdg_alignment_codes` SET TAGS ('pii_business_glossary_term' = 'SDG Alignment Codes');
ALTER TABLE `vibe_ngo_v1`.`grant`.`funding_source` ALTER COLUMN `subaward_allowed` SET TAGS ('pii_business_glossary_term' = 'Subaward Allowed');
ALTER TABLE `vibe_ngo_v1`.`grant`.`funding_source` ALTER COLUMN `subaward_approval_required` SET TAGS ('pii_business_glossary_term' = 'Subaward Approval Required');
ALTER TABLE `vibe_ngo_v1`.`grant`.`funding_source` ALTER COLUMN `thematic_restriction` SET TAGS ('pii_business_glossary_term' = 'Thematic Restriction');
ALTER TABLE `vibe_ngo_v1`.`grant`.`funding_source` ALTER COLUMN `total_funding_available` SET TAGS ('pii_business_glossary_term' = 'Total Funding Available');
ALTER TABLE `vibe_ngo_v1`.`grant`.`funding_source` ALTER COLUMN `unallowable_cost_categories` SET TAGS ('pii_business_glossary_term' = 'Unallowable Cost Categories');
ALTER TABLE `vibe_ngo_v1`.`grant`.`prior_approval` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_ngo_v1`.`grant`.`prior_approval` SET TAGS ('pii_subdomain' = 'budget_compliance');
ALTER TABLE `vibe_ngo_v1`.`grant`.`prior_approval` SET TAGS ('pii_domain' = 'grant');
ALTER TABLE `vibe_ngo_v1`.`grant`.`prior_approval` SET TAGS ('pii_category' = 'compliance');
ALTER TABLE `vibe_ngo_v1`.`grant`.`prior_approval` ALTER COLUMN `prior_approval_id` SET TAGS ('pii_business_glossary_term' = 'Prior Approval ID');
ALTER TABLE `vibe_ngo_v1`.`grant`.`prior_approval` ALTER COLUMN `award_id` SET TAGS ('pii_business_glossary_term' = 'Award ID');
ALTER TABLE `vibe_ngo_v1`.`grant`.`prior_approval` ALTER COLUMN `budget_line_id` SET TAGS ('pii_business_glossary_term' = 'Budget Line ID');
ALTER TABLE `vibe_ngo_v1`.`grant`.`prior_approval` ALTER COLUMN `constituent_id` SET TAGS ('pii_business_glossary_term' = 'Constituent ID');
ALTER TABLE `vibe_ngo_v1`.`grant`.`prior_approval` ALTER COLUMN `constituent_id` SET TAGS ('pii_type' = 'personal');
ALTER TABLE `vibe_ngo_v1`.`grant`.`prior_approval` ALTER COLUMN `grant_amendment_id` SET TAGS ('pii_business_glossary_term' = 'Grant Amendment ID');
ALTER TABLE `vibe_ngo_v1`.`grant`.`prior_approval` ALTER COLUMN `indicator_id` SET TAGS ('pii_business_glossary_term' = 'Indicator ID');
ALTER TABLE `vibe_ngo_v1`.`grant`.`prior_approval` ALTER COLUMN `intervention_id` SET TAGS ('pii_business_glossary_term' = 'Intervention ID');
ALTER TABLE `vibe_ngo_v1`.`grant`.`prior_approval` ALTER COLUMN `staff_member_id` SET TAGS ('pii_business_glossary_term' = 'Primary Staff Member ID');
ALTER TABLE `vibe_ngo_v1`.`grant`.`prior_approval` ALTER COLUMN `staff_member_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`prior_approval` ALTER COLUMN `staff_member_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`prior_approval` ALTER COLUMN `project_site_id` SET TAGS ('pii_business_glossary_term' = 'Project Site ID');
ALTER TABLE `vibe_ngo_v1`.`grant`.`prior_approval` ALTER COLUMN `acknowledgment_date` SET TAGS ('pii_business_glossary_term' = 'Acknowledgment Date');
ALTER TABLE `vibe_ngo_v1`.`grant`.`prior_approval` ALTER COLUMN `approval_conditions` SET TAGS ('pii_business_glossary_term' = 'Approval Conditions');
ALTER TABLE `vibe_ngo_v1`.`grant`.`prior_approval` ALTER COLUMN `approval_decision` SET TAGS ('pii_business_glossary_term' = 'Approval Decision');
ALTER TABLE `vibe_ngo_v1`.`grant`.`prior_approval` ALTER COLUMN `approval_subtype` SET TAGS ('pii_business_glossary_term' = 'Approval Subtype');
ALTER TABLE `vibe_ngo_v1`.`grant`.`prior_approval` ALTER COLUMN `approval_type` SET TAGS ('pii_business_glossary_term' = 'Approval Type');
ALTER TABLE `vibe_ngo_v1`.`grant`.`prior_approval` ALTER COLUMN `approved_amount` SET TAGS ('pii_business_glossary_term' = 'Approved Amount');
ALTER TABLE `vibe_ngo_v1`.`grant`.`prior_approval` ALTER COLUMN `approved_amount_currency` SET TAGS ('pii_business_glossary_term' = 'Approved Amount Currency');
ALTER TABLE `vibe_ngo_v1`.`grant`.`prior_approval` ALTER COLUMN `cost_category` SET TAGS ('pii_business_glossary_term' = 'Cost Category');
ALTER TABLE `vibe_ngo_v1`.`grant`.`prior_approval` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_ngo_v1`.`grant`.`prior_approval` ALTER COLUMN `denial_reason` SET TAGS ('pii_business_glossary_term' = 'Denial Reason');
ALTER TABLE `vibe_ngo_v1`.`grant`.`prior_approval` ALTER COLUMN `donor_contact_email` SET TAGS ('pii_business_glossary_term' = 'Donor Contact Email');
ALTER TABLE `vibe_ngo_v1`.`grant`.`prior_approval` ALTER COLUMN `donor_contact_email` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`grant`.`prior_approval` ALTER COLUMN `donor_contact_email` SET TAGS ('pii_type' = 'email');
ALTER TABLE `vibe_ngo_v1`.`grant`.`prior_approval` ALTER COLUMN `donor_contact_name` SET TAGS ('pii_business_glossary_term' = 'Donor Contact Name');
ALTER TABLE `vibe_ngo_v1`.`grant`.`prior_approval` ALTER COLUMN `donor_contact_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`grant`.`prior_approval` ALTER COLUMN `donor_contact_name` SET TAGS ('pii_type' = 'name');
ALTER TABLE `vibe_ngo_v1`.`grant`.`prior_approval` ALTER COLUMN `donor_response_document_reference` SET TAGS ('pii_business_glossary_term' = 'Donor Response Document Reference');
ALTER TABLE `vibe_ngo_v1`.`grant`.`prior_approval` ALTER COLUMN `effective_date` SET TAGS ('pii_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_ngo_v1`.`grant`.`prior_approval` ALTER COLUMN `expiration_date` SET TAGS ('pii_business_glossary_term' = 'Expiration Date');
ALTER TABLE `vibe_ngo_v1`.`grant`.`prior_approval` ALTER COLUMN `follow_up_notes` SET TAGS ('pii_business_glossary_term' = 'Follow Up Notes');
ALTER TABLE `vibe_ngo_v1`.`grant`.`prior_approval` ALTER COLUMN `follow_up_required` SET TAGS ('pii_business_glossary_term' = 'Follow Up Required');
ALTER TABLE `vibe_ngo_v1`.`grant`.`prior_approval` ALTER COLUMN `internal_approval_date` SET TAGS ('pii_business_glossary_term' = 'Internal Approval Date');
ALTER TABLE `vibe_ngo_v1`.`grant`.`prior_approval` ALTER COLUMN `is_emergency` SET TAGS ('pii_business_glossary_term' = 'Is Emergency');
ALTER TABLE `vibe_ngo_v1`.`grant`.`prior_approval` ALTER COLUMN `is_retroactive` SET TAGS ('pii_business_glossary_term' = 'Is Retroactive');
ALTER TABLE `vibe_ngo_v1`.`grant`.`prior_approval` ALTER COLUMN `justification` SET TAGS ('pii_business_glossary_term' = 'Justification');
ALTER TABLE `vibe_ngo_v1`.`grant`.`prior_approval` ALTER COLUMN `last_modified_timestamp` SET TAGS ('pii_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_ngo_v1`.`grant`.`prior_approval` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_ngo_v1`.`grant`.`prior_approval` ALTER COLUMN `regulatory_basis` SET TAGS ('pii_business_glossary_term' = 'Regulatory Basis');
ALTER TABLE `vibe_ngo_v1`.`grant`.`prior_approval` ALTER COLUMN `request_date` SET TAGS ('pii_business_glossary_term' = 'Request Date');
ALTER TABLE `vibe_ngo_v1`.`grant`.`prior_approval` ALTER COLUMN `request_reference_number` SET TAGS ('pii_business_glossary_term' = 'Request Reference Number');
ALTER TABLE `vibe_ngo_v1`.`grant`.`prior_approval` ALTER COLUMN `request_status` SET TAGS ('pii_business_glossary_term' = 'Request Status');
ALTER TABLE `vibe_ngo_v1`.`grant`.`prior_approval` ALTER COLUMN `requested_amount` SET TAGS ('pii_business_glossary_term' = 'Requested Amount');
ALTER TABLE `vibe_ngo_v1`.`grant`.`prior_approval` ALTER COLUMN `requested_amount_currency` SET TAGS ('pii_business_glossary_term' = 'Requested Amount Currency');
ALTER TABLE `vibe_ngo_v1`.`grant`.`prior_approval` ALTER COLUMN `response_date` SET TAGS ('pii_business_glossary_term' = 'Response Date');
ALTER TABLE `vibe_ngo_v1`.`grant`.`prior_approval` ALTER COLUMN `response_due_date` SET TAGS ('pii_business_glossary_term' = 'Response Due Date');
ALTER TABLE `vibe_ngo_v1`.`grant`.`prior_approval` ALTER COLUMN `review_start_date` SET TAGS ('pii_business_glossary_term' = 'Review Start Date');
ALTER TABLE `vibe_ngo_v1`.`grant`.`prior_approval` ALTER COLUMN `supporting_document_reference` SET TAGS ('pii_business_glossary_term' = 'Supporting Document Reference');
ALTER TABLE `vibe_ngo_v1`.`grant`.`grant_closeout` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_ngo_v1`.`grant`.`grant_closeout` SET TAGS ('pii_subdomain' = 'budget_compliance');
ALTER TABLE `vibe_ngo_v1`.`grant`.`grant_closeout` SET TAGS ('pii_domain' = 'grant');
ALTER TABLE `vibe_ngo_v1`.`grant`.`grant_closeout` SET TAGS ('pii_category' = 'closeout');
ALTER TABLE `vibe_ngo_v1`.`grant`.`grant_closeout` ALTER COLUMN `grant_closeout_id` SET TAGS ('pii_business_glossary_term' = 'Grant Closeout ID');
ALTER TABLE `vibe_ngo_v1`.`grant`.`grant_closeout` ALTER COLUMN `award_id` SET TAGS ('pii_business_glossary_term' = 'Award ID');
ALTER TABLE `vibe_ngo_v1`.`grant`.`grant_closeout` ALTER COLUMN `donor_report_id` SET TAGS ('pii_business_glossary_term' = 'Donor Report ID');
ALTER TABLE `vibe_ngo_v1`.`grant`.`grant_closeout` ALTER COLUMN `evaluation_id` SET TAGS ('pii_business_glossary_term' = 'Final Evaluation ID');
ALTER TABLE `vibe_ngo_v1`.`grant`.`grant_closeout` ALTER COLUMN `regulatory_filing_id` SET TAGS ('pii_business_glossary_term' = 'Regulatory Filing ID');
ALTER TABLE `vibe_ngo_v1`.`grant`.`grant_closeout` ALTER COLUMN `staff_member_id` SET TAGS ('pii_business_glossary_term' = 'Staff Member ID');
ALTER TABLE `vibe_ngo_v1`.`grant`.`grant_closeout` ALTER COLUMN `staff_member_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`grant_closeout` ALTER COLUMN `staff_member_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`grant_closeout` ALTER COLUMN `closeout_status` SET TAGS ('pii_business_glossary_term' = 'Closeout Status');
ALTER TABLE `vibe_ngo_v1`.`grant`.`grant_closeout` ALTER COLUMN `closeout_type` SET TAGS ('pii_business_glossary_term' = 'Closeout Type');
ALTER TABLE `vibe_ngo_v1`.`grant`.`grant_closeout` ALTER COLUMN `completion_date` SET TAGS ('pii_business_glossary_term' = 'Completion Date');
ALTER TABLE `vibe_ngo_v1`.`grant`.`grant_closeout` ALTER COLUMN `compliance_certification_date` SET TAGS ('pii_business_glossary_term' = 'Compliance Certification Date');
ALTER TABLE `vibe_ngo_v1`.`grant`.`grant_closeout` ALTER COLUMN `compliance_certified_by` SET TAGS ('pii_business_glossary_term' = 'Compliance Certified By');
ALTER TABLE `vibe_ngo_v1`.`grant`.`grant_closeout` ALTER COLUMN `compliance_certified_by` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`grant`.`grant_closeout` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_ngo_v1`.`grant`.`grant_closeout` ALTER COLUMN `donor_acceptance_date` SET TAGS ('pii_business_glossary_term' = 'Donor Acceptance Date');
ALTER TABLE `vibe_ngo_v1`.`grant`.`grant_closeout` ALTER COLUMN `donor_closeout_contact_email` SET TAGS ('pii_business_glossary_term' = 'Donor Closeout Contact Email');
ALTER TABLE `vibe_ngo_v1`.`grant`.`grant_closeout` ALTER COLUMN `donor_closeout_contact_email` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`grant`.`grant_closeout` ALTER COLUMN `donor_closeout_contact_email` SET TAGS ('pii_type' = 'email');
ALTER TABLE `vibe_ngo_v1`.`grant`.`grant_closeout` ALTER COLUMN `donor_closeout_contact_name` SET TAGS ('pii_business_glossary_term' = 'Donor Closeout Contact Name');
ALTER TABLE `vibe_ngo_v1`.`grant`.`grant_closeout` ALTER COLUMN `donor_closeout_contact_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`grant`.`grant_closeout` ALTER COLUMN `donor_closeout_contact_name` SET TAGS ('pii_type' = 'name');
ALTER TABLE `vibe_ngo_v1`.`grant`.`grant_closeout` ALTER COLUMN `equipment_disposition_date` SET TAGS ('pii_business_glossary_term' = 'Equipment Disposition Date');
ALTER TABLE `vibe_ngo_v1`.`grant`.`grant_closeout` ALTER COLUMN `equipment_disposition_status` SET TAGS ('pii_business_glossary_term' = 'Equipment Disposition Status');
ALTER TABLE `vibe_ngo_v1`.`grant`.`grant_closeout` ALTER COLUMN `final_audit_completion_date` SET TAGS ('pii_business_glossary_term' = 'Final Audit Completion Date');
ALTER TABLE `vibe_ngo_v1`.`grant`.`grant_closeout` ALTER COLUMN `final_audit_reference` SET TAGS ('pii_business_glossary_term' = 'Final Audit Reference');
ALTER TABLE `vibe_ngo_v1`.`grant`.`grant_closeout` ALTER COLUMN `final_audit_status` SET TAGS ('pii_business_glossary_term' = 'Final Audit Status');
ALTER TABLE `vibe_ngo_v1`.`grant`.`grant_closeout` ALTER COLUMN `final_financial_report_due_date` SET TAGS ('pii_business_glossary_term' = 'Final Financial Report Due Date');
ALTER TABLE `vibe_ngo_v1`.`grant`.`grant_closeout` ALTER COLUMN `final_financial_report_submission_date` SET TAGS ('pii_business_glossary_term' = 'Final Financial Report Submission Date');
ALTER TABLE `vibe_ngo_v1`.`grant`.`grant_closeout` ALTER COLUMN `final_inventory_reference` SET TAGS ('pii_business_glossary_term' = 'Final Inventory Reference');
ALTER TABLE `vibe_ngo_v1`.`grant`.`grant_closeout` ALTER COLUMN `final_inventory_submission_date` SET TAGS ('pii_business_glossary_term' = 'Final Inventory Submission Date');
ALTER TABLE `vibe_ngo_v1`.`grant`.`grant_closeout` ALTER COLUMN `final_programmatic_report_due_date` SET TAGS ('pii_business_glossary_term' = 'Final Programmatic Report Due Date');
ALTER TABLE `vibe_ngo_v1`.`grant`.`grant_closeout` ALTER COLUMN `final_programmatic_report_reference` SET TAGS ('pii_business_glossary_term' = 'Final Programmatic Report Reference');
ALTER TABLE `vibe_ngo_v1`.`grant`.`grant_closeout` ALTER COLUMN `final_programmatic_report_submission_date` SET TAGS ('pii_business_glossary_term' = 'Final Programmatic Report Submission Date');
ALTER TABLE `vibe_ngo_v1`.`grant`.`grant_closeout` ALTER COLUMN `initiation_date` SET TAGS ('pii_business_glossary_term' = 'Initiation Date');
ALTER TABLE `vibe_ngo_v1`.`grant`.`grant_closeout` ALTER COLUMN `intellectual_property_disposition` SET TAGS ('pii_business_glossary_term' = 'Intellectual Property Disposition');
ALTER TABLE `vibe_ngo_v1`.`grant`.`grant_closeout` ALTER COLUMN `last_modified_by` SET TAGS ('pii_business_glossary_term' = 'Last Modified By');
ALTER TABLE `vibe_ngo_v1`.`grant`.`grant_closeout` ALTER COLUMN `last_modified_timestamp` SET TAGS ('pii_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_ngo_v1`.`grant`.`grant_closeout` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_ngo_v1`.`grant`.`grant_closeout` ALTER COLUMN `outstanding_issues_description` SET TAGS ('pii_business_glossary_term' = 'Outstanding Issues Description');
ALTER TABLE `vibe_ngo_v1`.`grant`.`grant_closeout` ALTER COLUMN `outstanding_issues_flag` SET TAGS ('pii_business_glossary_term' = 'Outstanding Issues Flag');
ALTER TABLE `vibe_ngo_v1`.`grant`.`grant_closeout` ALTER COLUMN `period_of_performance_end_date` SET TAGS ('pii_business_glossary_term' = 'Period of Performance End Date');
ALTER TABLE `vibe_ngo_v1`.`grant`.`grant_closeout` ALTER COLUMN `records_destruction_date` SET TAGS ('pii_business_glossary_term' = 'Records Destruction Date');
ALTER TABLE `vibe_ngo_v1`.`grant`.`grant_closeout` ALTER COLUMN `records_retention_end_date` SET TAGS ('pii_business_glossary_term' = 'Records Retention End Date');
ALTER TABLE `vibe_ngo_v1`.`grant`.`grant_closeout` ALTER COLUMN `reference_number` SET TAGS ('pii_business_glossary_term' = 'Reference Number');
ALTER TABLE `vibe_ngo_v1`.`grant`.`grant_closeout` ALTER COLUMN `unliquidated_obligations_amount` SET TAGS ('pii_business_glossary_term' = 'Unliquidated Obligations Amount');
ALTER TABLE `vibe_ngo_v1`.`grant`.`grant_closeout` ALTER COLUMN `unliquidated_obligations_disposition` SET TAGS ('pii_business_glossary_term' = 'Unliquidated Obligations Disposition');
ALTER TABLE `vibe_ngo_v1`.`grant`.`grant_closeout` ALTER COLUMN `unobligated_balance_amount` SET TAGS ('pii_business_glossary_term' = 'Unobligated Balance Amount');
ALTER TABLE `vibe_ngo_v1`.`grant`.`grant_closeout` ALTER COLUMN `unobligated_balance_return_date` SET TAGS ('pii_business_glossary_term' = 'Unobligated Balance Return Date');
ALTER TABLE `vibe_ngo_v1`.`grant`.`cost_share_commitment` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_ngo_v1`.`grant`.`cost_share_commitment` SET TAGS ('pii_subdomain' = 'budget_compliance');
ALTER TABLE `vibe_ngo_v1`.`grant`.`cost_share_commitment` SET TAGS ('pii_domain' = 'grant');
ALTER TABLE `vibe_ngo_v1`.`grant`.`cost_share_commitment` SET TAGS ('pii_category' = 'compliance');
ALTER TABLE `vibe_ngo_v1`.`grant`.`cost_share_commitment` ALTER COLUMN `cost_share_commitment_id` SET TAGS ('pii_business_glossary_term' = 'Cost Share Commitment ID');
ALTER TABLE `vibe_ngo_v1`.`grant`.`cost_share_commitment` ALTER COLUMN `award_id` SET TAGS ('pii_business_glossary_term' = 'Award ID');
ALTER TABLE `vibe_ngo_v1`.`grant`.`cost_share_commitment` ALTER COLUMN `constituent_id` SET TAGS ('pii_business_glossary_term' = 'Donor Constituent ID');
ALTER TABLE `vibe_ngo_v1`.`grant`.`cost_share_commitment` ALTER COLUMN `constituent_id` SET TAGS ('pii_type' = 'personal');
ALTER TABLE `vibe_ngo_v1`.`grant`.`cost_share_commitment` ALTER COLUMN `inkind_donation_id` SET TAGS ('pii_business_glossary_term' = 'In-Kind Donation ID');
ALTER TABLE `vibe_ngo_v1`.`grant`.`cost_share_commitment` ALTER COLUMN `intervention_id` SET TAGS ('pii_business_glossary_term' = 'Intervention ID');
ALTER TABLE `vibe_ngo_v1`.`grant`.`cost_share_commitment` ALTER COLUMN `partner_org_id` SET TAGS ('pii_business_glossary_term' = 'Partner Org ID');
ALTER TABLE `vibe_ngo_v1`.`grant`.`cost_share_commitment` ALTER COLUMN `approval_date` SET TAGS ('pii_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_ngo_v1`.`grant`.`cost_share_commitment` ALTER COLUMN `approved_by_name` SET TAGS ('pii_business_glossary_term' = 'Approved By Name');
ALTER TABLE `vibe_ngo_v1`.`grant`.`cost_share_commitment` ALTER COLUMN `approved_by_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`grant`.`cost_share_commitment` ALTER COLUMN `approved_by_name` SET TAGS ('pii_type' = 'name');
ALTER TABLE `vibe_ngo_v1`.`grant`.`cost_share_commitment` ALTER COLUMN `approved_by_title` SET TAGS ('pii_business_glossary_term' = 'Approved By Title');
ALTER TABLE `vibe_ngo_v1`.`grant`.`cost_share_commitment` ALTER COLUMN `audit_finding_reference` SET TAGS ('pii_business_glossary_term' = 'Audit Finding Reference');
ALTER TABLE `vibe_ngo_v1`.`grant`.`cost_share_commitment` ALTER COLUMN `commitment_date` SET TAGS ('pii_business_glossary_term' = 'Commitment Date');
ALTER TABLE `vibe_ngo_v1`.`grant`.`cost_share_commitment` ALTER COLUMN `commitment_notes` SET TAGS ('pii_business_glossary_term' = 'Commitment Notes');
ALTER TABLE `vibe_ngo_v1`.`grant`.`cost_share_commitment` ALTER COLUMN `commitment_reference_number` SET TAGS ('pii_business_glossary_term' = 'Commitment Reference Number');
ALTER TABLE `vibe_ngo_v1`.`grant`.`cost_share_commitment` ALTER COLUMN `commitment_status` SET TAGS ('pii_business_glossary_term' = 'Commitment Status');
ALTER TABLE `vibe_ngo_v1`.`grant`.`cost_share_commitment` ALTER COLUMN `committed_amount` SET TAGS ('pii_business_glossary_term' = 'Committed Amount');
ALTER TABLE `vibe_ngo_v1`.`grant`.`cost_share_commitment` ALTER COLUMN `compliance_status` SET TAGS ('pii_business_glossary_term' = 'Compliance Status');
ALTER TABLE `vibe_ngo_v1`.`grant`.`cost_share_commitment` ALTER COLUMN `cost_category` SET TAGS ('pii_business_glossary_term' = 'Cost Category');
ALTER TABLE `vibe_ngo_v1`.`grant`.`cost_share_commitment` ALTER COLUMN `cost_share_source_description` SET TAGS ('pii_business_glossary_term' = 'Cost Share Source Description');
ALTER TABLE `vibe_ngo_v1`.`grant`.`cost_share_commitment` ALTER COLUMN `cost_share_type` SET TAGS ('pii_business_glossary_term' = 'Cost Share Type');
ALTER TABLE `vibe_ngo_v1`.`grant`.`cost_share_commitment` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_ngo_v1`.`grant`.`cost_share_commitment` ALTER COLUMN `currency_code` SET TAGS ('pii_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_ngo_v1`.`grant`.`cost_share_commitment` ALTER COLUMN `donor_approval_reference` SET TAGS ('pii_business_glossary_term' = 'Donor Approval Reference');
ALTER TABLE `vibe_ngo_v1`.`grant`.`cost_share_commitment` ALTER COLUMN `fiscal_period` SET TAGS ('pii_business_glossary_term' = 'Fiscal Period');
ALTER TABLE `vibe_ngo_v1`.`grant`.`cost_share_commitment` ALTER COLUMN `fiscal_year` SET TAGS ('pii_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `vibe_ngo_v1`.`grant`.`cost_share_commitment` ALTER COLUMN `gl_account_code` SET TAGS ('pii_business_glossary_term' = 'GL Account Code');
ALTER TABLE `vibe_ngo_v1`.`grant`.`cost_share_commitment` ALTER COLUMN `in_kind_valuation_method` SET TAGS ('pii_business_glossary_term' = 'In-Kind Valuation Method');
ALTER TABLE `vibe_ngo_v1`.`grant`.`cost_share_commitment` ALTER COLUMN `is_mandatory` SET TAGS ('pii_business_glossary_term' = 'Is Mandatory');
ALTER TABLE `vibe_ngo_v1`.`grant`.`cost_share_commitment` ALTER COLUMN `is_restricted_fund` SET TAGS ('pii_business_glossary_term' = 'Is Restricted Fund');
ALTER TABLE `vibe_ngo_v1`.`grant`.`cost_share_commitment` ALTER COLUMN `last_modified_timestamp` SET TAGS ('pii_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_ngo_v1`.`grant`.`cost_share_commitment` ALTER COLUMN `reporting_period_end_date` SET TAGS ('pii_business_glossary_term' = 'Reporting Period End Date');
ALTER TABLE `vibe_ngo_v1`.`grant`.`cost_share_commitment` ALTER COLUMN `reporting_period_start_date` SET TAGS ('pii_business_glossary_term' = 'Reporting Period Start Date');
ALTER TABLE `vibe_ngo_v1`.`grant`.`cost_share_commitment` ALTER COLUMN `required_cost_share_amount` SET TAGS ('pii_business_glossary_term' = 'Required Cost Share Amount');
ALTER TABLE `vibe_ngo_v1`.`grant`.`cost_share_commitment` ALTER COLUMN `required_cost_share_percentage` SET TAGS ('pii_business_glossary_term' = 'Required Cost Share Percentage');
ALTER TABLE `vibe_ngo_v1`.`grant`.`cost_share_commitment` ALTER COLUMN `source_organization_name` SET TAGS ('pii_business_glossary_term' = 'Source Organization Name');
ALTER TABLE `vibe_ngo_v1`.`grant`.`cost_share_commitment` ALTER COLUMN `source_organization_name` SET TAGS ('pii_type' = 'name');
ALTER TABLE `vibe_ngo_v1`.`grant`.`cost_share_commitment` ALTER COLUMN `supporting_document_reference` SET TAGS ('pii_business_glossary_term' = 'Supporting Document Reference');
ALTER TABLE `vibe_ngo_v1`.`grant`.`cost_share_commitment` ALTER COLUMN `variance_amount` SET TAGS ('pii_business_glossary_term' = 'Variance Amount');
ALTER TABLE `vibe_ngo_v1`.`grant`.`cost_share_commitment` ALTER COLUMN `variance_percentage` SET TAGS ('pii_business_glossary_term' = 'Variance Percentage');
ALTER TABLE `vibe_ngo_v1`.`grant`.`cost_share_commitment` ALTER COLUMN `verification_date` SET TAGS ('pii_business_glossary_term' = 'Verification Date');
ALTER TABLE `vibe_ngo_v1`.`grant`.`cost_share_commitment` ALTER COLUMN `verification_method` SET TAGS ('pii_business_glossary_term' = 'Verification Method');
ALTER TABLE `vibe_ngo_v1`.`grant`.`cost_share_commitment` ALTER COLUMN `verified_amount` SET TAGS ('pii_business_glossary_term' = 'Verified Amount');
ALTER TABLE `vibe_ngo_v1`.`grant`.`cost_share_commitment` ALTER COLUMN `volunteer_hourly_rate` SET TAGS ('pii_business_glossary_term' = 'Volunteer Hourly Rate');
ALTER TABLE `vibe_ngo_v1`.`grant`.`cost_share_commitment` ALTER COLUMN `volunteer_hours` SET TAGS ('pii_business_glossary_term' = 'Volunteer Hours');
ALTER TABLE `vibe_ngo_v1`.`grant`.`solicitation` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_ngo_v1`.`grant`.`solicitation` SET TAGS ('pii_subdomain' = 'award_pipeline');
ALTER TABLE `vibe_ngo_v1`.`grant`.`solicitation` SET TAGS ('pii_domain' = 'grant');
ALTER TABLE `vibe_ngo_v1`.`grant`.`solicitation` SET TAGS ('pii_category' = 'business_development');
ALTER TABLE `vibe_ngo_v1`.`grant`.`solicitation` ALTER COLUMN `solicitation_id` SET TAGS ('pii_business_glossary_term' = 'Solicitation ID');
ALTER TABLE `vibe_ngo_v1`.`grant`.`solicitation` ALTER COLUMN `advocacy_campaign_id` SET TAGS ('pii_business_glossary_term' = 'Advocacy Campaign ID');
ALTER TABLE `vibe_ngo_v1`.`grant`.`solicitation` ALTER COLUMN `country_office_id` SET TAGS ('pii_business_glossary_term' = 'Country Office ID');
ALTER TABLE `vibe_ngo_v1`.`grant`.`solicitation` ALTER COLUMN `funding_source_id` SET TAGS ('pii_business_glossary_term' = 'Funding Source ID');
ALTER TABLE `vibe_ngo_v1`.`grant`.`solicitation` ALTER COLUMN `indicator_id` SET TAGS ('pii_business_glossary_term' = 'Indicator ID');
ALTER TABLE `vibe_ngo_v1`.`grant`.`solicitation` ALTER COLUMN `constituent_id` SET TAGS ('pii_business_glossary_term' = 'Issuing Constituent ID');
ALTER TABLE `vibe_ngo_v1`.`grant`.`solicitation` ALTER COLUMN `constituent_id` SET TAGS ('pii_type' = 'personal');
ALTER TABLE `vibe_ngo_v1`.`grant`.`solicitation` ALTER COLUMN `anticipated_award_date` SET TAGS ('pii_business_glossary_term' = 'Anticipated Award Date');
ALTER TABLE `vibe_ngo_v1`.`grant`.`solicitation` ALTER COLUMN `anticipated_start_date` SET TAGS ('pii_business_glossary_term' = 'Anticipated Start Date');
ALTER TABLE `vibe_ngo_v1`.`grant`.`solicitation` ALTER COLUMN `application_deadline` SET TAGS ('pii_business_glossary_term' = 'Application Deadline');
ALTER TABLE `vibe_ngo_v1`.`grant`.`solicitation` ALTER COLUMN `competitive_intelligence_notes` SET TAGS ('pii_business_glossary_term' = 'Competitive Intelligence Notes');
ALTER TABLE `vibe_ngo_v1`.`grant`.`solicitation` ALTER COLUMN `consortium_allowed` SET TAGS ('pii_business_glossary_term' = 'Consortium Allowed');
ALTER TABLE `vibe_ngo_v1`.`grant`.`solicitation` ALTER COLUMN `contact_email` SET TAGS ('pii_business_glossary_term' = 'Contact Email');
ALTER TABLE `vibe_ngo_v1`.`grant`.`solicitation` ALTER COLUMN `contact_email` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`grant`.`solicitation` ALTER COLUMN `contact_email` SET TAGS ('pii_type' = 'email');
ALTER TABLE `vibe_ngo_v1`.`grant`.`solicitation` ALTER COLUMN `contact_person_name` SET TAGS ('pii_business_glossary_term' = 'Contact Person Name');
ALTER TABLE `vibe_ngo_v1`.`grant`.`solicitation` ALTER COLUMN `contact_person_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`grant`.`solicitation` ALTER COLUMN `contact_person_name` SET TAGS ('pii_type' = 'name');
ALTER TABLE `vibe_ngo_v1`.`grant`.`solicitation` ALTER COLUMN `cost_share_percentage` SET TAGS ('pii_business_glossary_term' = 'Cost Share Percentage');
ALTER TABLE `vibe_ngo_v1`.`grant`.`solicitation` ALTER COLUMN `cost_share_required` SET TAGS ('pii_business_glossary_term' = 'Cost Share Required');
ALTER TABLE `vibe_ngo_v1`.`grant`.`solicitation` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_ngo_v1`.`grant`.`solicitation` ALTER COLUMN `dac_sector_code` SET TAGS ('pii_business_glossary_term' = 'DAC Sector Code');
ALTER TABLE `vibe_ngo_v1`.`grant`.`solicitation` ALTER COLUMN `eligibility_criteria` SET TAGS ('pii_business_glossary_term' = 'Eligibility Criteria');
ALTER TABLE `vibe_ngo_v1`.`grant`.`solicitation` ALTER COLUMN `estimated_funding_amount` SET TAGS ('pii_business_glossary_term' = 'Estimated Funding Amount');
ALTER TABLE `vibe_ngo_v1`.`grant`.`solicitation` ALTER COLUMN `estimated_number_of_awards` SET TAGS ('pii_business_glossary_term' = 'Estimated Number of Awards');
ALTER TABLE `vibe_ngo_v1`.`grant`.`solicitation` ALTER COLUMN `funding_currency` SET TAGS ('pii_business_glossary_term' = 'Funding Currency');
ALTER TABLE `vibe_ngo_v1`.`grant`.`solicitation` ALTER COLUMN `geographic_eligibility` SET TAGS ('pii_business_glossary_term' = 'Geographic Eligibility');
ALTER TABLE `vibe_ngo_v1`.`grant`.`solicitation` ALTER COLUMN `go_no_go_decision_date` SET TAGS ('pii_business_glossary_term' = 'Go/No-Go Decision Date');
ALTER TABLE `vibe_ngo_v1`.`grant`.`solicitation` ALTER COLUMN `go_no_go_rationale` SET TAGS ('pii_business_glossary_term' = 'Go/No-Go Rationale');
ALTER TABLE `vibe_ngo_v1`.`grant`.`solicitation` ALTER COLUMN `identified_by` SET TAGS ('pii_business_glossary_term' = 'Identified By');
ALTER TABLE `vibe_ngo_v1`.`grant`.`solicitation` ALTER COLUMN `identified_date` SET TAGS ('pii_business_glossary_term' = 'Identified Date');
ALTER TABLE `vibe_ngo_v1`.`grant`.`solicitation` ALTER COLUMN `indirect_cost_rate_allowed` SET TAGS ('pii_business_glossary_term' = 'Indirect Cost Rate Allowed');
ALTER TABLE `vibe_ngo_v1`.`grant`.`solicitation` ALTER COLUMN `indirect_cost_rate_cap` SET TAGS ('pii_business_glossary_term' = 'Indirect Cost Rate Cap');
ALTER TABLE `vibe_ngo_v1`.`grant`.`solicitation` ALTER COLUMN `internal_priority_score` SET TAGS ('pii_business_glossary_term' = 'Internal Priority Score');
ALTER TABLE `vibe_ngo_v1`.`grant`.`solicitation` ALTER COLUMN `last_modified_timestamp` SET TAGS ('pii_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_ngo_v1`.`grant`.`solicitation` ALTER COLUMN `local_partner_requirement` SET TAGS ('pii_business_glossary_term' = 'Local Partner Requirement');
ALTER TABLE `vibe_ngo_v1`.`grant`.`solicitation` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_ngo_v1`.`grant`.`solicitation` ALTER COLUMN `program_duration_months` SET TAGS ('pii_business_glossary_term' = 'Program Duration Months');
ALTER TABLE `vibe_ngo_v1`.`grant`.`solicitation` ALTER COLUMN `publication_date` SET TAGS ('pii_business_glossary_term' = 'Publication Date');
ALTER TABLE `vibe_ngo_v1`.`grant`.`solicitation` ALTER COLUMN `questions_deadline` SET TAGS ('pii_business_glossary_term' = 'Questions Deadline');
ALTER TABLE `vibe_ngo_v1`.`grant`.`solicitation` ALTER COLUMN `sdg_alignment` SET TAGS ('pii_business_glossary_term' = 'SDG Alignment');
ALTER TABLE `vibe_ngo_v1`.`grant`.`solicitation` ALTER COLUMN `solicitation_number` SET TAGS ('pii_business_glossary_term' = 'Solicitation Number');
ALTER TABLE `vibe_ngo_v1`.`grant`.`solicitation` ALTER COLUMN `solicitation_status` SET TAGS ('pii_business_glossary_term' = 'Solicitation Status');
ALTER TABLE `vibe_ngo_v1`.`grant`.`solicitation` ALTER COLUMN `solicitation_type` SET TAGS ('pii_business_glossary_term' = 'Solicitation Type');
ALTER TABLE `vibe_ngo_v1`.`grant`.`solicitation` ALTER COLUMN `submission_method` SET TAGS ('pii_business_glossary_term' = 'Submission Method');
ALTER TABLE `vibe_ngo_v1`.`grant`.`solicitation` ALTER COLUMN `submission_requirements` SET TAGS ('pii_business_glossary_term' = 'Submission Requirements');
ALTER TABLE `vibe_ngo_v1`.`grant`.`solicitation` ALTER COLUMN `thematic_focus_area` SET TAGS ('pii_business_glossary_term' = 'Thematic Focus Area');
ALTER TABLE `vibe_ngo_v1`.`grant`.`solicitation` ALTER COLUMN `title` SET TAGS ('pii_business_glossary_term' = 'Title');
ALTER TABLE `vibe_ngo_v1`.`grant`.`solicitation` ALTER COLUMN `url` SET TAGS ('pii_business_glossary_term' = 'URL');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_site_allocation` SET TAGS ('pii_data_type' = 'association_data');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_site_allocation` SET TAGS ('pii_subdomain' = 'subaward_management');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_site_allocation` SET TAGS ('pii_association_edges' = 'grant.award,field.project_site');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_site_allocation` SET TAGS ('pii_domain' = 'grant');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_site_allocation` SET TAGS ('pii_category' = 'allocation');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_site_allocation` ALTER COLUMN `award_site_allocation_id` SET TAGS ('pii_business_glossary_term' = 'Award Site Allocation ID');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_site_allocation` ALTER COLUMN `staff_member_id` SET TAGS ('pii_business_glossary_term' = 'Approved By Staff Member ID');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_site_allocation` ALTER COLUMN `staff_member_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_site_allocation` ALTER COLUMN `staff_member_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_site_allocation` ALTER COLUMN `award_id` SET TAGS ('pii_business_glossary_term' = 'Award ID');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_site_allocation` ALTER COLUMN `country_office_id` SET TAGS ('pii_business_glossary_term' = 'Country Office ID');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_site_allocation` ALTER COLUMN `intervention_id` SET TAGS ('pii_business_glossary_term' = 'Intervention ID');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_site_allocation` ALTER COLUMN `project_site_id` SET TAGS ('pii_business_glossary_term' = 'Project Site ID');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_site_allocation` ALTER COLUMN `actual_expenditure_at_site` SET TAGS ('pii_business_glossary_term' = 'Actual Expenditure at Site');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_site_allocation` ALTER COLUMN `allocated_currency_code` SET TAGS ('pii_business_glossary_term' = 'Allocated Currency Code');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_site_allocation` ALTER COLUMN `allocation_end_date` SET TAGS ('pii_business_glossary_term' = 'Allocation End Date');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_site_allocation` ALTER COLUMN `allocation_notes` SET TAGS ('pii_business_glossary_term' = 'Allocation Notes');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_site_allocation` ALTER COLUMN `allocation_percentage` SET TAGS ('pii_business_glossary_term' = 'Allocation Percentage');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_site_allocation` ALTER COLUMN `allocation_start_date` SET TAGS ('pii_business_glossary_term' = 'Allocation Start Date');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_site_allocation` ALTER COLUMN `approval_status` SET TAGS ('pii_business_glossary_term' = 'Approval Status');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_site_allocation` ALTER COLUMN `beneficiary_actual_at_site` SET TAGS ('pii_business_glossary_term' = 'Beneficiary Actual at Site');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_site_allocation` ALTER COLUMN `beneficiary_target_at_site` SET TAGS ('pii_business_glossary_term' = 'Beneficiary Target at Site');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_site_allocation` ALTER COLUMN `committed_amount_at_site` SET TAGS ('pii_business_glossary_term' = 'Committed Amount at Site');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_site_allocation` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_site_allocation` ALTER COLUMN `currency_code` SET TAGS ('pii_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_site_allocation` ALTER COLUMN `expenditure_to_date` SET TAGS ('pii_business_glossary_term' = 'Expenditure to Date');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_site_allocation` ALTER COLUMN `geographic_focus_area` SET TAGS ('pii_business_glossary_term' = 'Geographic Focus Area');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_site_allocation` ALTER COLUMN `is_primary_site` SET TAGS ('pii_business_glossary_term' = 'Is Primary Site');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_site_allocation` ALTER COLUMN `last_monitoring_visit_date` SET TAGS ('pii_business_glossary_term' = 'Last Monitoring Visit Date');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_site_allocation` ALTER COLUMN `reporting_period_end` SET TAGS ('pii_business_glossary_term' = 'Reporting Period End');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_site_allocation` ALTER COLUMN `reporting_period_start` SET TAGS ('pii_business_glossary_term' = 'Reporting Period Start');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_site_allocation` ALTER COLUMN `sector_code` SET TAGS ('pii_business_glossary_term' = 'Sector Code');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_site_allocation` ALTER COLUMN `site_activation_date` SET TAGS ('pii_business_glossary_term' = 'Site Activation Date');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_site_allocation` ALTER COLUMN `site_budget_allocation` SET TAGS ('pii_business_glossary_term' = 'Site Budget Allocation');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_site_allocation` ALTER COLUMN `site_contact_email` SET TAGS ('pii_business_glossary_term' = 'Site Contact Email');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_site_allocation` ALTER COLUMN `site_contact_email` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_site_allocation` ALTER COLUMN `site_contact_email` SET TAGS ('pii_type' = 'email');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_site_allocation` ALTER COLUMN `site_contact_name` SET TAGS ('pii_business_glossary_term' = 'Site Contact Name');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_site_allocation` ALTER COLUMN `site_contact_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_site_allocation` ALTER COLUMN `site_contact_name` SET TAGS ('pii_type' = 'name');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_site_allocation` ALTER COLUMN `site_deactivation_date` SET TAGS ('pii_business_glossary_term' = 'Site Deactivation Date');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_site_allocation` ALTER COLUMN `site_role_in_award` SET TAGS ('pii_business_glossary_term' = 'Site Role in Award');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_site_allocation` ALTER COLUMN `site_status` SET TAGS ('pii_business_glossary_term' = 'Site Status');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_site_allocation` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_ngo_v1`.`grant`.`asset_allocation` SET TAGS ('pii_data_type' = 'association_data');
ALTER TABLE `vibe_ngo_v1`.`grant`.`asset_allocation` SET TAGS ('pii_subdomain' = 'subaward_management');
ALTER TABLE `vibe_ngo_v1`.`grant`.`asset_allocation` SET TAGS ('pii_association_edges' = 'grant.award,technology.it_asset');
ALTER TABLE `vibe_ngo_v1`.`grant`.`asset_allocation` SET TAGS ('pii_domain' = 'grant');
ALTER TABLE `vibe_ngo_v1`.`grant`.`asset_allocation` SET TAGS ('pii_category' = 'asset');
ALTER TABLE `vibe_ngo_v1`.`grant`.`asset_allocation` ALTER COLUMN `asset_allocation_id` SET TAGS ('pii_business_glossary_term' = 'Asset Allocation ID');
ALTER TABLE `vibe_ngo_v1`.`grant`.`asset_allocation` ALTER COLUMN `award_id` SET TAGS ('pii_business_glossary_term' = 'Award ID');
ALTER TABLE `vibe_ngo_v1`.`grant`.`asset_allocation` ALTER COLUMN `it_asset_id` SET TAGS ('pii_business_glossary_term' = 'IT Asset ID');
ALTER TABLE `vibe_ngo_v1`.`grant`.`asset_allocation` ALTER COLUMN `allocation_end_date` SET TAGS ('pii_business_glossary_term' = 'Allocation End Date');
ALTER TABLE `vibe_ngo_v1`.`grant`.`asset_allocation` ALTER COLUMN `allocation_justification` SET TAGS ('pii_business_glossary_term' = 'Allocation Justification');
ALTER TABLE `vibe_ngo_v1`.`grant`.`asset_allocation` ALTER COLUMN `allocation_percentage` SET TAGS ('pii_business_glossary_term' = 'Allocation Percentage');
ALTER TABLE `vibe_ngo_v1`.`grant`.`asset_allocation` ALTER COLUMN `allocation_start_date` SET TAGS ('pii_business_glossary_term' = 'Allocation Start Date');
ALTER TABLE `vibe_ngo_v1`.`grant`.`asset_allocation` ALTER COLUMN `allocation_status` SET TAGS ('pii_business_glossary_term' = 'Allocation Status');
ALTER TABLE `vibe_ngo_v1`.`grant`.`asset_allocation` ALTER COLUMN `cost_allocated` SET TAGS ('pii_business_glossary_term' = 'Cost Allocated');
ALTER TABLE `vibe_ngo_v1`.`grant`.`asset_allocation` ALTER COLUMN `depreciation_allocation` SET TAGS ('pii_business_glossary_term' = 'Depreciation Allocation');
ALTER TABLE `vibe_ngo_v1`.`grant`.`asset_allocation` ALTER COLUMN `disposal_date` SET TAGS ('pii_business_glossary_term' = 'Disposal Date');
ALTER TABLE `vibe_ngo_v1`.`grant`.`asset_allocation` ALTER COLUMN `donor_approval_date` SET TAGS ('pii_business_glossary_term' = 'Donor Approval Date');
ALTER TABLE `vibe_ngo_v1`.`grant`.`asset_allocation` ALTER COLUMN `donor_approval_required` SET TAGS ('pii_business_glossary_term' = 'Donor Approval Required');
ALTER TABLE `vibe_ngo_v1`.`grant`.`asset_allocation` ALTER COLUMN `purchase_date` SET TAGS ('pii_business_glossary_term' = 'Purchase Date');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_position_funding` SET TAGS ('pii_data_type' = 'association_data');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_position_funding` SET TAGS ('pii_subdomain' = 'subaward_management');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_position_funding` SET TAGS ('pii_association_edges' = 'grant.award,workforce.position');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_position_funding` SET TAGS ('pii_domain' = 'grant');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_position_funding` SET TAGS ('pii_category' = 'staffing');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_position_funding` ALTER COLUMN `award_position_funding_id` SET TAGS ('pii_business_glossary_term' = 'Award Position Funding ID');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_position_funding` ALTER COLUMN `award_id` SET TAGS ('pii_business_glossary_term' = 'Award ID');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_position_funding` ALTER COLUMN `position_id` SET TAGS ('pii_business_glossary_term' = 'Position ID');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_position_funding` ALTER COLUMN `allocation_currency_code` SET TAGS ('pii_business_glossary_term' = 'Allocation Currency Code');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_position_funding` ALTER COLUMN `cost_allocation_amount` SET TAGS ('pii_business_glossary_term' = 'Cost Allocation Amount');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_position_funding` ALTER COLUMN `created_date` SET TAGS ('pii_business_glossary_term' = 'Created Date');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_position_funding` ALTER COLUMN `effort_percent` SET TAGS ('pii_business_glossary_term' = 'Effort Percent');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_position_funding` ALTER COLUMN `end_date` SET TAGS ('pii_business_glossary_term' = 'End Date');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_position_funding` ALTER COLUMN `funding_status` SET TAGS ('pii_business_glossary_term' = 'Funding Status');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_position_funding` ALTER COLUMN `last_modified_date` SET TAGS ('pii_business_glossary_term' = 'Last Modified Date');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_position_funding` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_position_funding` ALTER COLUMN `start_date` SET TAGS ('pii_business_glossary_term' = 'Start Date');
ALTER TABLE `vibe_ngo_v1`.`grant`.`grant_staff_assignment` SET TAGS ('pii_data_type' = 'association_data');
ALTER TABLE `vibe_ngo_v1`.`grant`.`grant_staff_assignment` SET TAGS ('pii_subdomain' = 'subaward_management');
ALTER TABLE `vibe_ngo_v1`.`grant`.`grant_staff_assignment` SET TAGS ('pii_association_edges' = 'grant.award,workforce.staff_member');
ALTER TABLE `vibe_ngo_v1`.`grant`.`grant_staff_assignment` SET TAGS ('pii_domain' = 'grant');
ALTER TABLE `vibe_ngo_v1`.`grant`.`grant_staff_assignment` SET TAGS ('pii_category' = 'staffing');
ALTER TABLE `vibe_ngo_v1`.`grant`.`grant_staff_assignment` ALTER COLUMN `grant_staff_assignment_id` SET TAGS ('pii_business_glossary_term' = 'Grant Staff Assignment ID');
ALTER TABLE `vibe_ngo_v1`.`grant`.`grant_staff_assignment` ALTER COLUMN `award_id` SET TAGS ('pii_business_glossary_term' = 'Award ID');
ALTER TABLE `vibe_ngo_v1`.`grant`.`grant_staff_assignment` ALTER COLUMN `staff_member_id` SET TAGS ('pii_business_glossary_term' = 'Approved By Staff Member ID');
ALTER TABLE `vibe_ngo_v1`.`grant`.`grant_staff_assignment` ALTER COLUMN `staff_member_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`grant_staff_assignment` ALTER COLUMN `staff_member_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`grant_staff_assignment` ALTER COLUMN `grant_staff_member_id` SET TAGS ('pii_business_glossary_term' = 'Staff Member ID');
ALTER TABLE `vibe_ngo_v1`.`grant`.`grant_staff_assignment` ALTER COLUMN `grant_staff_member_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`grant_staff_assignment` ALTER COLUMN `grant_staff_member_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`grant_staff_assignment` ALTER COLUMN `workforce_staff_assignment_id` SET TAGS ('pii_business_glossary_term' = 'Staff Assignment ID');
ALTER TABLE `vibe_ngo_v1`.`grant`.`grant_staff_assignment` ALTER COLUMN `approval_date` SET TAGS ('pii_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_ngo_v1`.`grant`.`grant_staff_assignment` ALTER COLUMN `assignment_end_date` SET TAGS ('pii_business_glossary_term' = 'Assignment End Date');
ALTER TABLE `vibe_ngo_v1`.`grant`.`grant_staff_assignment` ALTER COLUMN `assignment_start_date` SET TAGS ('pii_business_glossary_term' = 'Assignment Start Date');
ALTER TABLE `vibe_ngo_v1`.`grant`.`grant_staff_assignment` ALTER COLUMN `assignment_status` SET TAGS ('pii_business_glossary_term' = 'Assignment Status');
ALTER TABLE `vibe_ngo_v1`.`grant`.`grant_staff_assignment` ALTER COLUMN `budgeted_fte` SET TAGS ('pii_business_glossary_term' = 'Budgeted FTE');
ALTER TABLE `vibe_ngo_v1`.`grant`.`grant_staff_assignment` ALTER COLUMN `cost_allocation_method` SET TAGS ('pii_business_glossary_term' = 'Cost Allocation Method');
ALTER TABLE `vibe_ngo_v1`.`grant`.`grant_staff_assignment` ALTER COLUMN `effort_percent` SET TAGS ('pii_business_glossary_term' = 'Effort Percent');
ALTER TABLE `vibe_ngo_v1`.`grant`.`grant_staff_assignment` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_ngo_v1`.`grant`.`grant_staff_assignment` ALTER COLUMN `role` SET TAGS ('pii_business_glossary_term' = 'Role');
