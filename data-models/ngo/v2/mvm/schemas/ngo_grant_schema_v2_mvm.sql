-- Schema for Domain: grant | Business: Ngo | Version: v2_mvm
-- Generated on: 2026-07-03 06:20:33

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_ngo_v1`.`grant` COMMENT 'Systems of record: SAP Grants Management, eZHACT (UNICEF HACT cash transfers), donor portals (USAID ASIST, EC PROSPECT). Award lifecycle from solicitation through closeout.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_ngo_v1`.`grant`.`sub_award_disbursement` (
    `sub_award_disbursement_id` BIGINT COMMENT 'Primary key for sub-award disbursement record',
    `amendment_id` DECIMAL(18,2) COMMENT 'Foreign key linking to grant.grant_amendment. Business justification: Sub-award disbursement tranches are often authorized under specific grant amendments — for example, a budget realignment amendment may authorize a new disbursement tranche to a sub-awardee, or a no-co',
    `award_id` BIGINT COMMENT 'FK to the parent award',
    `component_id` BIGINT COMMENT 'FK to the program component',
    `partner_org_id` BIGINT COMMENT 'FK to the implementing partner organization',
    `project_site_id` BIGINT COMMENT 'Foreign key linking to field.project_site. Business justification: Sub-award disbursements fund activities at specific project sites. NGO finance teams require site-level disbursement tracking for geographic donor reporting, earmark compliance, and field-level expend',
    `reporting_period_id` BIGINT COMMENT 'Foreign key linking to mel.reporting_period. Business justification: Disbursements are reconciled against MEL reporting periods for integrated financial and results reporting. The existing fiscal_period is a plain text code; a FK to reporting_period enables period-base',
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
    `constituent_id` BIGINT COMMENT 'FK to the donor constituent',
    `country_office_id` BIGINT COMMENT 'FK to the managing country office',
    `fund_id` BIGINT COMMENT 'Foreign key linking to donor.donor_fund. Business justification: An award is funded through a specific donor fund. Linking award to donor_fund enables fund utilization tracking, restriction compliance monitoring, and fund balance reconciliation — essential for NGO ',
    `funding_source_id` BIGINT COMMENT 'Foreign key linking to grant.funding_source. Business justification: An award is issued under a specific funding source (donor mechanism such as USAID cooperative agreement, EC grant, UNICEF HACT). This FK normalizes the relationship between the award lifecycle and the',
    `intervention_id` BIGINT COMMENT 'FK to the program intervention funded',
    `psea_policy_id` BIGINT COMMENT 'Foreign key linking to safeguarding.psea_policy. Business justification: UN agencies and major bilateral donors require NGOs to reference a specific PSEA policy in award agreements. Linking award to psea_policy enables award-level PSEA compliance tracking, policy version a',
    `partner_org_id` BIGINT COMMENT 'Foreign key linking to partnership.partner_org. Business justification: Grantmaking-out recipient tracking: When is_grantmaking_out=true, the award is made TO a partner org as primary recipient. Role-prefixed recipient_partner_org_id distinguishes this from donor-side l',
    `statutory_registration_id` BIGINT COMMENT 'Foreign key linking to compliance.statutory_registration. Business justification: Award execution requires verifying the NGOs statutory registration authorizes operations in the awards jurisdiction. Compliance teams confirm registration status before award activation. NGO domain ',
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
    `campaign_id` BIGINT COMMENT 'Foreign key linking to donor.campaign. Business justification: Proposals are generated in response to fundraising or solicitation campaigns. Linking proposal to campaign enables campaign ROI analysis — proposals submitted per campaign, win rates, and total awarde',
    `capacity_assessment_id` BIGINT COMMENT 'Foreign key linking to partnership.capacity_assessment. Business justification: Pre-award partner capacity verification: NGO proposals reference partner capacity assessments to demonstrate implementation feasibility to donors. This link supports go/no-go decisions and proposal qu',
    `component_id` BIGINT COMMENT 'FK to program component',
    `constituent_id` BIGINT COMMENT 'Foreign key to donor.constituent',
    `country_office_id` BIGINT COMMENT 'FK to the submitting country office',
    `emergency_id` BIGINT COMMENT 'Foreign key linking to field.emergency. Business justification: Emergency response proposals are directly triggered by declared emergencies. Business development teams track proposal pipelines per emergency for flash appeal response rates and emergency funding mob',
    `fund_id` BIGINT COMMENT 'Foreign key linking to donor.donor_fund. Business justification: Proposals are submitted against specific donor funds (restricted endowments, thematic funds). Linking proposal to donor_fund enables fund utilization pipeline forecasting, tracks which funds have acti',
    `funding_source_id` BIGINT COMMENT 'Foreign key linking to grant.funding_source. Business justification: A proposal is submitted targeting a specific funding source or donor mechanism (e.g., USAID RFA, EC call for proposals). Linking proposal to funding_source enables pre-award compliance checks, indirec',
    `intervention_id` BIGINT COMMENT 'FK to the program intervention',
    `mel_logframe_id` BIGINT COMMENT 'FK to the MEL logframe',
    `partner_org_id` BIGINT COMMENT 'Foreign key linking to partnership.partner_org. Business justification: Business development pipeline tracking: NGO proposals name implementing partners before award. Proposal-to-partner_org link supports pre-award partner pipeline reporting and go/no-go decisions. conso',
    `prospect_id` BIGINT COMMENT 'Foreign key linking to donor.prospect. Business justification: A proposal is the formal output of prospect cultivation. Linking proposal to prospect enables business development pipeline conversion reporting — tracking prospect-to-proposal-to-award conversion rat',
    `risk_assessment_id` BIGINT COMMENT 'Foreign key linking to safeguarding.risk_assessment. Business justification: Technical proposals increasingly require a pre-award safeguarding risk assessment as part of the go/no-go process. Linking proposal to risk_assessment documents the pre-award safeguarding analysis, su',
    `statutory_registration_id` BIGINT COMMENT 'Foreign key linking to compliance.statutory_registration. Business justification: Go/no-go decisions on proposals explicitly reference the NGOs statutory registration status in the proposed operating jurisdiction. Proposal eligibility and donor_eligibility_verified_flag on statuto',
    `award_notification_date` DATE COMMENT 'Date award notification received',
    `business_development_owner` STRING COMMENT 'Name of BD lead',
    `compliance_review_completed` BOOLEAN COMMENT 'Whether compliance review is done',
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
    `amendment_id` DECIMAL(18,2) COMMENT 'FK to amendment if budget revised',
    `award_id` BIGINT COMMENT 'FK to parent award',
    `fund_id` BIGINT COMMENT 'Foreign key linking to donor.donor_fund. Business justification: Award budgets are structured around donor fund restrictions. Linking award_budget to donor_fund enables restriction-compliance budget monitoring, fund balance tracking, and ensures budget lines respec',
    `meal_plan_id` BIGINT COMMENT 'Foreign key linking to mel.meal_plan. Business justification: The MEAL plan budget is a defined component of the award budget. NGO finance staff track MEAL cost allocations within the overall award budget. This link allows direct budget tracking for MEAL activit',
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
    `indicator_id` BIGINT COMMENT 'FK to MEL indicator',
    `intervention_id` BIGINT COMMENT 'FK to intervention',
    `partner_org_id` BIGINT COMMENT 'Foreign key linking to partnership.partner_org. Business justification: Multi-partner award budget allocation: In sub-award arrangements, budget lines are allocated to specific implementing partners. This link supports partner-level expenditure tracking and donor financia',
    `project_site_id` BIGINT COMMENT 'Foreign key linking to field.project_site. Business justification: Budget lines are allocated to specific project sites for geographic financial reporting and donor geographic earmarking compliance. NGO finance teams produce site-level budget vs. actuals reports; a g',
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

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`grant`.`amendment` (
    `amendment_id` DECIMAL(18,2) COMMENT 'Primary key',
    `country_office_id` BIGINT COMMENT 'Foreign key linking to field.country_office. Business justification: Grant amendments are initiated, approved, and submitted by country offices. Country directors authorize amendments; country offices track amendment pipelines. Direct FK enables country-office-level am',
    `supersedes_amendment_grant_amendment_id` DECIMAL(18,2) COMMENT 'FK to superseded amendment',
    `amendment_number` STRING COMMENT 'Sequential amendment number',
    `amendment_status` STRING COMMENT 'Current status',
    `amendment_type` STRING COMMENT 'Type of amendment',
    `approval_date` DATE COMMENT 'Date approved',
    `approved_by_name` STRING COMMENT 'Name of approver',
    `approved_by_title` STRING COMMENT 'Title of approver',
    `budget_modification_summary` DECIMAL(18,2) COMMENT 'Summary of budget modifications',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `currency_code` STRING COMMENT 'Standardized code representing the currency classification or category.',
    `amendment_description` STRING COMMENT 'Description of amendment',
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
    CONSTRAINT pk_amendment PRIMARY KEY(`amendment_id`)
) COMMENT 'Tracks modifications to grant awards including no-cost extensions, budget realignments, scope changes, and key personnel changes. Source systems: SAP, eTools.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`grant`.`subaward` (
    `subaward_id` BIGINT COMMENT 'Primary key',
    `agreement_id` BIGINT COMMENT 'Foreign key linking to partnership.partnership_agreement. Business justification: Subaward-to-agreement linkage: A subaward is the financial instrument executed under a partnership agreement. NGO grants management requires tracking which partnership agreement governs each subaward ',
    `award_id` BIGINT COMMENT 'FK to parent award',
    `country_office_id` BIGINT COMMENT 'Foreign key linking to field.country_office. Business justification: Subawards are administered by specific country offices that manage partner relationships, monitor compliance, and process disbursements. Direct FK enables country-office-level subaward portfolio manag',
    `constituent_id` BIGINT COMMENT 'Foreign key linking to donor.constituent. Business justification: In grantmaking-out operations, the sub-recipient is a constituent in the CRM (grantee type). Linking subaward to constituent enables due diligence tracking, relationship management for grantees, and g',
    `meal_plan_id` BIGINT COMMENT 'Foreign key linking to mel.meal_plan. Business justification: Each subaward to a partner organization is governed by a MEAL plan defining how the partner monitors and reports results. NGO sub-award managers need to identify which MEAL plan applies to each partne',
    `mel_logframe_id` BIGINT COMMENT 'Foreign key linking to mel.mel_logframe. Business justification: Subawards are scoped to specific logframe outputs or outcomes. Partner monitoring staff need to identify which logframe elements each subaward is accountable for, enabling sub-award performance tracki',
    `partner_org_id` BIGINT COMMENT 'FK to partner organization',
    `project_site_id` BIGINT COMMENT 'FK to project site',
    `psea_policy_id` BIGINT COMMENT 'Foreign key linking to safeguarding.psea_policy. Business justification: Subaward agreements require partner organizations to have and comply with a PSEA policy. Linking subaward to psea_policy documents which policy version was verified at subaward execution — a standard ',
    `single_audit_id` BIGINT COMMENT 'Foreign key linking to compliance.single_audit. Business justification: Single audit requirements under 2 CFR 200 are triggered by federal expenditure thresholds on subawards. subaward.single_audit_required_flag exists but has no FK target. Linking subaward to the coverin',
    `statutory_registration_id` BIGINT COMMENT 'Foreign key linking to compliance.statutory_registration. Business justification: Subaward execution requires verifying the partners statutory registration in the operating jurisdiction. NGO compliance teams check partner registration status before executing subawards per 2 CFR 20',
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
    `agreement_id` BIGINT COMMENT 'Foreign key linking to partnership.partnership_agreement. Business justification: Conditions precedent to partnership agreements: Donor conditions are often tied to specific partnership agreements as conditions precedent to disbursement. NGO compliance officers track which conditio',
    `amendment_id` DECIMAL(18,2) COMMENT 'Foreign key linking to grant.grant_amendment. Business justification: Donor conditions are frequently introduced or modified through grant amendments (e.g., a no-cost extension amendment introduces new reporting conditions, a budget realignment amendment adds prior-appr',
    `award_id` BIGINT COMMENT 'FK to award',
    `constituent_id` BIGINT COMMENT 'FK to donor constituent',
    `evaluation_id` BIGINT COMMENT 'FK to evaluation',
    `indicator_id` BIGINT COMMENT 'FK to indicator',
    `indicator_target_id` BIGINT COMMENT 'Foreign key linking to mel.indicator_target. Business justification: Donor conditions are frequently tied to achieving specific indicator targets (e.g., tranche release conditions requiring 80% of a target milestone). donor_condition has indicator_id but not indicator_',
    `obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.obligation. Business justification: Special award conditions (SACs) and donor conditions directly generate compliance obligations. NGO compliance teams map each donor condition to a formal obligation for scheduling and tracking. This li',
    `partner_org_id` BIGINT COMMENT 'Foreign key linking to partnership.partner_org. Business justification: Partner-specific compliance conditions: Donors frequently impose conditions on specific implementing partners (e.g., capacity assessment completion before fund release). This link enables compliance t',
    `psea_policy_id` BIGINT COMMENT 'Foreign key linking to safeguarding.psea_policy. Business justification: Donor conditions frequently require submission or compliance with a specific PSEA policy version. Linking donor_condition to psea_policy enables compliance tracking — confirming which policy version s',
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
    `country_office_id` BIGINT COMMENT 'Foreign key linking to field.country_office. Business justification: Donor reports are submitted by and attributed to country offices for country director sign-off, organizational accountability, and country-level donor relationship management. Existing FK is to projec',
    `donor_requirement_id` BIGINT COMMENT 'Foreign key linking to compliance.donor_requirement. Business justification: Donor reports directly fulfill specific donor requirements (financial reports, narrative reports, indicator reports). Linking donor_report to donor_requirement enables compliance status tracking — con',
    `fund_id` BIGINT COMMENT 'Foreign key linking to donor.donor_fund. Business justification: NGO donor reports must be filed against a specific restricted donor fund for restriction compliance and fund utilization reporting. A domain expert expects donor_report to reference the fund it report',
    `incident_id` BIGINT COMMENT 'Foreign key linking to safeguarding.safeguarding_incident. Business justification: Donor reports must disclose safeguarding incidents occurring during the reporting period per most major donor frameworks. Linking donor_report to safeguarding_incident enables automated incident discl',
    `intervention_id` BIGINT COMMENT 'FK to intervention',
    `mel_logframe_id` BIGINT COMMENT 'Foreign key linking to mel.mel_logframe. Business justification: Donor narrative reports are structured around the award logframe. Report writers reference logframe outputs and outcomes when compiling narrative sections. This direct link allows report generation sy',
    `obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.obligation. Business justification: Donor reports fulfill specific compliance obligations. Linking donor_report to the obligation it satisfies enables compliance tracking — confirming which obligations have been met, identifying overdue',
    `project_site_id` BIGINT COMMENT 'FK to project site',
    `reporting_period_id` BIGINT COMMENT 'Foreign key linking to mel.reporting_period. Business justification: Donor reports are submitted for a specific MEL reporting period. NGO finance and compliance staff reconcile financial expenditure and results data by reporting period. This link enables period-based d',
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
    `constituent_id` BIGINT COMMENT 'Foreign key linking to donor.constituent. Business justification: A funding source represents a donor/funder organization that also exists as a constituent in the CRM. Linking funding_source to constituent enables funder portfolio analysis, CRM-to-grants reconciliat',
    `obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.obligation. Business justification: Funding sources define the compliance framework and trigger specific obligations (audit requirements, IATI publication, single audit thresholds). funding_source.compliance_framework and audit_requirem',
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

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_ngo_v1`.`grant`.`sub_award_disbursement` ADD CONSTRAINT `fk_grant_sub_award_disbursement_amendment_id` FOREIGN KEY (`amendment_id`) REFERENCES `vibe_ngo_v1`.`grant`.`amendment`(`amendment_id`);
ALTER TABLE `vibe_ngo_v1`.`grant`.`sub_award_disbursement` ADD CONSTRAINT `fk_grant_sub_award_disbursement_award_id` FOREIGN KEY (`award_id`) REFERENCES `vibe_ngo_v1`.`grant`.`award`(`award_id`);
ALTER TABLE `vibe_ngo_v1`.`grant`.`sub_award_disbursement` ADD CONSTRAINT `fk_grant_sub_award_disbursement_subaward_id` FOREIGN KEY (`subaward_id`) REFERENCES `vibe_ngo_v1`.`grant`.`subaward`(`subaward_id`);
ALTER TABLE `vibe_ngo_v1`.`grant`.`award` ADD CONSTRAINT `fk_grant_award_funding_source_id` FOREIGN KEY (`funding_source_id`) REFERENCES `vibe_ngo_v1`.`grant`.`funding_source`(`funding_source_id`);
ALTER TABLE `vibe_ngo_v1`.`grant`.`proposal` ADD CONSTRAINT `fk_grant_proposal_award_id` FOREIGN KEY (`award_id`) REFERENCES `vibe_ngo_v1`.`grant`.`award`(`award_id`);
ALTER TABLE `vibe_ngo_v1`.`grant`.`proposal` ADD CONSTRAINT `fk_grant_proposal_funding_source_id` FOREIGN KEY (`funding_source_id`) REFERENCES `vibe_ngo_v1`.`grant`.`funding_source`(`funding_source_id`);
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget` ADD CONSTRAINT `fk_grant_award_budget_amendment_id` FOREIGN KEY (`amendment_id`) REFERENCES `vibe_ngo_v1`.`grant`.`amendment`(`amendment_id`);
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget` ADD CONSTRAINT `fk_grant_award_budget_award_id` FOREIGN KEY (`award_id`) REFERENCES `vibe_ngo_v1`.`grant`.`award`(`award_id`);
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget_line` ADD CONSTRAINT `fk_grant_award_budget_line_award_budget_id` FOREIGN KEY (`award_budget_id`) REFERENCES `vibe_ngo_v1`.`grant`.`award_budget`(`award_budget_id`);
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget_line` ADD CONSTRAINT `fk_grant_award_budget_line_award_id` FOREIGN KEY (`award_id`) REFERENCES `vibe_ngo_v1`.`grant`.`award`(`award_id`);
ALTER TABLE `vibe_ngo_v1`.`grant`.`amendment` ADD CONSTRAINT `fk_grant_amendment_supersedes_amendment_grant_amendment_id` FOREIGN KEY (`supersedes_amendment_grant_amendment_id`) REFERENCES `vibe_ngo_v1`.`grant`.`amendment`(`amendment_id`);
ALTER TABLE `vibe_ngo_v1`.`grant`.`subaward` ADD CONSTRAINT `fk_grant_subaward_award_id` FOREIGN KEY (`award_id`) REFERENCES `vibe_ngo_v1`.`grant`.`award`(`award_id`);
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_condition` ADD CONSTRAINT `fk_grant_donor_condition_amendment_id` FOREIGN KEY (`amendment_id`) REFERENCES `vibe_ngo_v1`.`grant`.`amendment`(`amendment_id`);
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_condition` ADD CONSTRAINT `fk_grant_donor_condition_award_id` FOREIGN KEY (`award_id`) REFERENCES `vibe_ngo_v1`.`grant`.`award`(`award_id`);
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_report` ADD CONSTRAINT `fk_grant_donor_report_award_id` FOREIGN KEY (`award_id`) REFERENCES `vibe_ngo_v1`.`grant`.`award`(`award_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_ngo_v1`.`grant` SET TAGS ('dbx_division' = 'business');
ALTER SCHEMA `vibe_ngo_v1`.`grant` SET TAGS ('dbx_domain' = 'grant');
ALTER TABLE `vibe_ngo_v1`.`grant`.`sub_award_disbursement` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_ngo_v1`.`grant`.`sub_award_disbursement` SET TAGS ('dbx_subdomain' = 'award_management');
ALTER TABLE `vibe_ngo_v1`.`grant`.`sub_award_disbursement` ALTER COLUMN `sub_award_disbursement_id` SET TAGS ('dbx_business_glossary_term' = 'Sub-Award Disbursement ID');
ALTER TABLE `vibe_ngo_v1`.`grant`.`sub_award_disbursement` ALTER COLUMN `amendment_id` SET TAGS ('dbx_business_glossary_term' = 'Grant Amendment Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`grant`.`sub_award_disbursement` ALTER COLUMN `award_id` SET TAGS ('dbx_business_glossary_term' = 'Award ID');
ALTER TABLE `vibe_ngo_v1`.`grant`.`sub_award_disbursement` ALTER COLUMN `component_id` SET TAGS ('dbx_business_glossary_term' = 'Component ID');
ALTER TABLE `vibe_ngo_v1`.`grant`.`sub_award_disbursement` ALTER COLUMN `partner_org_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Org ID');
ALTER TABLE `vibe_ngo_v1`.`grant`.`sub_award_disbursement` ALTER COLUMN `project_site_id` SET TAGS ('dbx_business_glossary_term' = 'Project Site Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`grant`.`sub_award_disbursement` ALTER COLUMN `reporting_period_id` SET TAGS ('dbx_business_glossary_term' = 'Reporting Period Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`grant`.`sub_award_disbursement` ALTER COLUMN `subaward_id` SET TAGS ('dbx_business_glossary_term' = 'Subaward ID');
ALTER TABLE `vibe_ngo_v1`.`grant`.`sub_award_disbursement` ALTER COLUMN `advance_balance_outstanding` SET TAGS ('dbx_business_glossary_term' = 'Advance Balance Outstanding');
ALTER TABLE `vibe_ngo_v1`.`grant`.`sub_award_disbursement` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_ngo_v1`.`grant`.`sub_award_disbursement` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `vibe_ngo_v1`.`grant`.`sub_award_disbursement` ALTER COLUMN `approved_by` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`grant`.`sub_award_disbursement` ALTER COLUMN `bank_transfer_reference` SET TAGS ('dbx_business_glossary_term' = 'Bank Transfer Reference');
ALTER TABLE `vibe_ngo_v1`.`grant`.`sub_award_disbursement` ALTER COLUMN `cost_category` SET TAGS ('dbx_business_glossary_term' = 'Cost Category');
ALTER TABLE `vibe_ngo_v1`.`grant`.`sub_award_disbursement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_ngo_v1`.`grant`.`sub_award_disbursement` ALTER COLUMN `disbursement_amount` SET TAGS ('dbx_business_glossary_term' = 'Disbursement Amount');
ALTER TABLE `vibe_ngo_v1`.`grant`.`sub_award_disbursement` ALTER COLUMN `disbursement_amount_usd` SET TAGS ('dbx_business_glossary_term' = 'Disbursement Amount USD');
ALTER TABLE `vibe_ngo_v1`.`grant`.`sub_award_disbursement` ALTER COLUMN `disbursement_currency` SET TAGS ('dbx_business_glossary_term' = 'Disbursement Currency');
ALTER TABLE `vibe_ngo_v1`.`grant`.`sub_award_disbursement` ALTER COLUMN `disbursement_date` SET TAGS ('dbx_business_glossary_term' = 'Disbursement Date');
ALTER TABLE `vibe_ngo_v1`.`grant`.`sub_award_disbursement` ALTER COLUMN `disbursement_method` SET TAGS ('dbx_business_glossary_term' = 'Disbursement Method');
ALTER TABLE `vibe_ngo_v1`.`grant`.`sub_award_disbursement` ALTER COLUMN `disbursement_notes` SET TAGS ('dbx_business_glossary_term' = 'Disbursement Notes');
ALTER TABLE `vibe_ngo_v1`.`grant`.`sub_award_disbursement` ALTER COLUMN `disbursement_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Disbursement Reference Number');
ALTER TABLE `vibe_ngo_v1`.`grant`.`sub_award_disbursement` ALTER COLUMN `disbursement_status` SET TAGS ('dbx_business_glossary_term' = 'Disbursement Status');
ALTER TABLE `vibe_ngo_v1`.`grant`.`sub_award_disbursement` ALTER COLUMN `disbursement_type` SET TAGS ('dbx_business_glossary_term' = 'Disbursement Type');
ALTER TABLE `vibe_ngo_v1`.`grant`.`sub_award_disbursement` ALTER COLUMN `donor_reporting_category` SET TAGS ('dbx_business_glossary_term' = 'Donor Reporting Category');
ALTER TABLE `vibe_ngo_v1`.`grant`.`sub_award_disbursement` ALTER COLUMN `exchange_rate` SET TAGS ('dbx_business_glossary_term' = 'Exchange Rate');
ALTER TABLE `vibe_ngo_v1`.`grant`.`sub_award_disbursement` ALTER COLUMN `fiscal_period` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period');
ALTER TABLE `vibe_ngo_v1`.`grant`.`sub_award_disbursement` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `vibe_ngo_v1`.`grant`.`sub_award_disbursement` ALTER COLUMN `fund_restriction_type` SET TAGS ('dbx_business_glossary_term' = 'Fund Restriction Type');
ALTER TABLE `vibe_ngo_v1`.`grant`.`sub_award_disbursement` ALTER COLUMN `gl_account_code` SET TAGS ('dbx_business_glossary_term' = 'GL Account Code');
ALTER TABLE `vibe_ngo_v1`.`grant`.`sub_award_disbursement` ALTER COLUMN `indirect_cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Indirect Cost Amount');
ALTER TABLE `vibe_ngo_v1`.`grant`.`sub_award_disbursement` ALTER COLUMN `is_emergency_disbursement` SET TAGS ('dbx_business_glossary_term' = 'Is Emergency Disbursement');
ALTER TABLE `vibe_ngo_v1`.`grant`.`sub_award_disbursement` ALTER COLUMN `liquidated_amount` SET TAGS ('dbx_business_glossary_term' = 'Liquidated Amount');
ALTER TABLE `vibe_ngo_v1`.`grant`.`sub_award_disbursement` ALTER COLUMN `liquidation_date` SET TAGS ('dbx_business_glossary_term' = 'Liquidation Date');
ALTER TABLE `vibe_ngo_v1`.`grant`.`sub_award_disbursement` ALTER COLUMN `liquidation_deadline` SET TAGS ('dbx_business_glossary_term' = 'Liquidation Deadline');
ALTER TABLE `vibe_ngo_v1`.`grant`.`sub_award_disbursement` ALTER COLUMN `liquidation_status` SET TAGS ('dbx_business_glossary_term' = 'Liquidation Status');
ALTER TABLE `vibe_ngo_v1`.`grant`.`sub_award_disbursement` ALTER COLUMN `net_disbursement_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Disbursement Amount');
ALTER TABLE `vibe_ngo_v1`.`grant`.`sub_award_disbursement` ALTER COLUMN `nicra_rate_applied` SET TAGS ('dbx_business_glossary_term' = 'NICRA Rate Applied');
ALTER TABLE `vibe_ngo_v1`.`grant`.`sub_award_disbursement` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `vibe_ngo_v1`.`grant`.`sub_award_disbursement` ALTER COLUMN `post_distribution_monitoring_ref` SET TAGS ('dbx_business_glossary_term' = 'Post Distribution Monitoring Reference');
ALTER TABLE `vibe_ngo_v1`.`grant`.`sub_award_disbursement` ALTER COLUMN `request_date` SET TAGS ('dbx_business_glossary_term' = 'Request Date');
ALTER TABLE `vibe_ngo_v1`.`grant`.`sub_award_disbursement` ALTER COLUMN `supporting_document_reference` SET TAGS ('dbx_business_glossary_term' = 'Supporting Document Reference');
ALTER TABLE `vibe_ngo_v1`.`grant`.`sub_award_disbursement` ALTER COLUMN `tranche_number` SET TAGS ('dbx_business_glossary_term' = 'Tranche Number');
ALTER TABLE `vibe_ngo_v1`.`grant`.`sub_award_disbursement` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_ngo_v1`.`grant`.`sub_award_disbursement` ALTER COLUMN `withholding_amount` SET TAGS ('dbx_business_glossary_term' = 'Withholding Amount');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award` SET TAGS ('dbx_subdomain' = 'award_management');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award` ALTER COLUMN `award_id` SET TAGS ('dbx_business_glossary_term' = 'Award ID');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award` ALTER COLUMN `constituent_id` SET TAGS ('dbx_business_glossary_term' = 'Constituent ID');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award` ALTER COLUMN `constituent_id` SET TAGS ('dbx_pii_type' = 'personal');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award` ALTER COLUMN `country_office_id` SET TAGS ('dbx_business_glossary_term' = 'Country Office ID');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award` ALTER COLUMN `fund_id` SET TAGS ('dbx_business_glossary_term' = 'Donor Fund Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award` ALTER COLUMN `funding_source_id` SET TAGS ('dbx_business_glossary_term' = 'Funding Source Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award` ALTER COLUMN `intervention_id` SET TAGS ('dbx_business_glossary_term' = 'Intervention ID');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award` ALTER COLUMN `psea_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Psea Policy Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award` ALTER COLUMN `partner_org_id` SET TAGS ('dbx_business_glossary_term' = 'Recipient Partner Org Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award` ALTER COLUMN `statutory_registration_id` SET TAGS ('dbx_business_glossary_term' = 'Statutory Registration Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award` ALTER COLUMN `advance_payment_allowed` SET TAGS ('dbx_business_glossary_term' = 'Advance Payment Allowed');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award` ALTER COLUMN `agreement_signed_date` SET TAGS ('dbx_business_glossary_term' = 'Agreement Signed Date');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award` ALTER COLUMN `amendment_count` SET TAGS ('dbx_business_glossary_term' = 'Amendment Count');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award` ALTER COLUMN `audit_required` SET TAGS ('dbx_business_glossary_term' = 'Audit Required');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award` ALTER COLUMN `audit_threshold_amount` SET TAGS ('dbx_business_glossary_term' = 'Audit Threshold Amount');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award` ALTER COLUMN `authorized_amount` SET TAGS ('dbx_business_glossary_term' = 'Authorized Amount');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award` ALTER COLUMN `award_number` SET TAGS ('dbx_business_glossary_term' = 'Award Number');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award` ALTER COLUMN `award_status` SET TAGS ('dbx_business_glossary_term' = 'Award Status');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award` ALTER COLUMN `award_type` SET TAGS ('dbx_business_glossary_term' = 'Award Type');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award` ALTER COLUMN `board_approval_date` SET TAGS ('dbx_business_glossary_term' = 'Board Approval Date');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award` ALTER COLUMN `board_approval_required` SET TAGS ('dbx_business_glossary_term' = 'Board Approval Required');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award` ALTER COLUMN `board_resolution_reference` SET TAGS ('dbx_business_glossary_term' = 'Board Resolution Reference');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award` ALTER COLUMN `branding_marking_requirements` SET TAGS ('dbx_business_glossary_term' = 'Branding Marking Requirements');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award` ALTER COLUMN `closeout_date` SET TAGS ('dbx_business_glossary_term' = 'Closeout Date');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award` ALTER COLUMN `cost_share_amount` SET TAGS ('dbx_business_glossary_term' = 'Cost Share Amount');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award` ALTER COLUMN `cost_share_percentage` SET TAGS ('dbx_business_glossary_term' = 'Cost Share Percentage');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award` ALTER COLUMN `cost_share_required` SET TAGS ('dbx_business_glossary_term' = 'Cost Share Required');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award` ALTER COLUMN `currency` SET TAGS ('dbx_business_glossary_term' = 'Currency');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award` ALTER COLUMN `dac_sector_code` SET TAGS ('dbx_business_glossary_term' = 'DAC Sector Code');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award` ALTER COLUMN `donor_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Donor Reference Number');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'End Date');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award` ALTER COLUMN `exchange_rate_to_functional` SET TAGS ('dbx_business_glossary_term' = 'Exchange Rate to Functional');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award` ALTER COLUMN `functional_currency` SET TAGS ('dbx_business_glossary_term' = 'Functional Currency');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award` ALTER COLUMN `fund_restriction_type` SET TAGS ('dbx_business_glossary_term' = 'Fund Restriction Type');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award` ALTER COLUMN `funding_mechanism` SET TAGS ('dbx_business_glossary_term' = 'Funding Mechanism');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award` ALTER COLUMN `geographic_scope` SET TAGS ('dbx_business_glossary_term' = 'Geographic Scope');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award` ALTER COLUMN `grantmaking_program_area` SET TAGS ('dbx_business_glossary_term' = 'Grantmaking Program Area');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award` ALTER COLUMN `indirect_cost_ceiling` SET TAGS ('dbx_business_glossary_term' = 'Indirect Cost Ceiling');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award` ALTER COLUMN `is_grantmaking_out` SET TAGS ('dbx_business_glossary_term' = 'Is Grantmaking Out');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award` ALTER COLUMN `last_amendment_date` SET TAGS ('dbx_business_glossary_term' = 'Last Amendment Date');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award` ALTER COLUMN `nicra_icr_rate` SET TAGS ('dbx_business_glossary_term' = 'NICRA ICR Rate');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award` ALTER COLUMN `notification_date` SET TAGS ('dbx_business_glossary_term' = 'Notification Date');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award` ALTER COLUMN `original_end_date` SET TAGS ('dbx_business_glossary_term' = 'Original End Date');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award` ALTER COLUMN `period_of_performance_months` SET TAGS ('dbx_business_glossary_term' = 'Period of Performance Months');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award` ALTER COLUMN `primary_country_code` SET TAGS ('dbx_business_glossary_term' = 'Primary Country Code');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award` ALTER COLUMN `regulatory_framework` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Framework');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award` ALTER COLUMN `reporting_frequency` SET TAGS ('dbx_business_glossary_term' = 'Reporting Frequency');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award` ALTER COLUMN `sdg_alignment` SET TAGS ('dbx_business_glossary_term' = 'SDG Alignment');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award` ALTER COLUMN `special_conditions` SET TAGS ('dbx_business_glossary_term' = 'Special Conditions');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Start Date');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award` ALTER COLUMN `thematic_sector` SET TAGS ('dbx_business_glossary_term' = 'Thematic Sector');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award` ALTER COLUMN `title` SET TAGS ('dbx_business_glossary_term' = 'Title');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award` ALTER COLUMN `total_obligated_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Obligated Amount');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award` ALTER COLUMN `total_obligated_amount_functional` SET TAGS ('dbx_business_glossary_term' = 'Total Obligated Amount Functional');
ALTER TABLE `vibe_ngo_v1`.`grant`.`proposal` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_ngo_v1`.`grant`.`proposal` SET TAGS ('dbx_subdomain' = 'award_management');
ALTER TABLE `vibe_ngo_v1`.`grant`.`proposal` ALTER COLUMN `proposal_id` SET TAGS ('dbx_business_glossary_term' = 'Proposal ID');
ALTER TABLE `vibe_ngo_v1`.`grant`.`proposal` ALTER COLUMN `award_id` SET TAGS ('dbx_business_glossary_term' = 'Award ID');
ALTER TABLE `vibe_ngo_v1`.`grant`.`proposal` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`grant`.`proposal` ALTER COLUMN `capacity_assessment_id` SET TAGS ('dbx_business_glossary_term' = 'Capacity Assessment Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`grant`.`proposal` ALTER COLUMN `component_id` SET TAGS ('dbx_business_glossary_term' = 'Component ID');
ALTER TABLE `vibe_ngo_v1`.`grant`.`proposal` ALTER COLUMN `constituent_id` SET TAGS ('dbx_pii_type' = 'personal');
ALTER TABLE `vibe_ngo_v1`.`grant`.`proposal` ALTER COLUMN `country_office_id` SET TAGS ('dbx_business_glossary_term' = 'Country Office ID');
ALTER TABLE `vibe_ngo_v1`.`grant`.`proposal` ALTER COLUMN `emergency_id` SET TAGS ('dbx_business_glossary_term' = 'Emergency Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`grant`.`proposal` ALTER COLUMN `fund_id` SET TAGS ('dbx_business_glossary_term' = 'Donor Fund Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`grant`.`proposal` ALTER COLUMN `funding_source_id` SET TAGS ('dbx_business_glossary_term' = 'Funding Source Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`grant`.`proposal` ALTER COLUMN `intervention_id` SET TAGS ('dbx_business_glossary_term' = 'Intervention ID');
ALTER TABLE `vibe_ngo_v1`.`grant`.`proposal` ALTER COLUMN `mel_logframe_id` SET TAGS ('dbx_business_glossary_term' = 'MEL Logframe ID');
ALTER TABLE `vibe_ngo_v1`.`grant`.`proposal` ALTER COLUMN `partner_org_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Org Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`grant`.`proposal` ALTER COLUMN `prospect_id` SET TAGS ('dbx_business_glossary_term' = 'Prospect Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`grant`.`proposal` ALTER COLUMN `risk_assessment_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Assessment Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`grant`.`proposal` ALTER COLUMN `statutory_registration_id` SET TAGS ('dbx_business_glossary_term' = 'Statutory Registration Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`grant`.`proposal` ALTER COLUMN `award_notification_date` SET TAGS ('dbx_business_glossary_term' = 'Award Notification Date');
ALTER TABLE `vibe_ngo_v1`.`grant`.`proposal` ALTER COLUMN `business_development_owner` SET TAGS ('dbx_business_glossary_term' = 'Business Development Owner');
ALTER TABLE `vibe_ngo_v1`.`grant`.`proposal` ALTER COLUMN `business_development_owner` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`grant`.`proposal` ALTER COLUMN `compliance_review_completed` SET TAGS ('dbx_business_glossary_term' = 'Compliance Review Completed');
ALTER TABLE `vibe_ngo_v1`.`grant`.`proposal` ALTER COLUMN `cost_proposal_summary` SET TAGS ('dbx_business_glossary_term' = 'Cost Proposal Summary');
ALTER TABLE `vibe_ngo_v1`.`grant`.`proposal` ALTER COLUMN `cost_share_amount` SET TAGS ('dbx_business_glossary_term' = 'Cost Share Amount');
ALTER TABLE `vibe_ngo_v1`.`grant`.`proposal` ALTER COLUMN `cost_share_percentage` SET TAGS ('dbx_business_glossary_term' = 'Cost Share Percentage');
ALTER TABLE `vibe_ngo_v1`.`grant`.`proposal` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_ngo_v1`.`grant`.`proposal` ALTER COLUMN `document_reference` SET TAGS ('dbx_business_glossary_term' = 'Document Reference');
ALTER TABLE `vibe_ngo_v1`.`grant`.`proposal` ALTER COLUMN `geographic_focus` SET TAGS ('dbx_business_glossary_term' = 'Geographic Focus');
ALTER TABLE `vibe_ngo_v1`.`grant`.`proposal` ALTER COLUMN `go_no_go_decision` SET TAGS ('dbx_business_glossary_term' = 'Go/No-Go Decision');
ALTER TABLE `vibe_ngo_v1`.`grant`.`proposal` ALTER COLUMN `go_no_go_decision_date` SET TAGS ('dbx_business_glossary_term' = 'Go/No-Go Decision Date');
ALTER TABLE `vibe_ngo_v1`.`grant`.`proposal` ALTER COLUMN `indirect_cost_rate_proposed` SET TAGS ('dbx_business_glossary_term' = 'Indirect Cost Rate Proposed');
ALTER TABLE `vibe_ngo_v1`.`grant`.`proposal` ALTER COLUMN `internal_review_date` SET TAGS ('dbx_business_glossary_term' = 'Internal Review Date');
ALTER TABLE `vibe_ngo_v1`.`grant`.`proposal` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_ngo_v1`.`grant`.`proposal` ALTER COLUMN `lead_proposal_writer` SET TAGS ('dbx_business_glossary_term' = 'Lead Proposal Writer');
ALTER TABLE `vibe_ngo_v1`.`grant`.`proposal` ALTER COLUMN `lead_proposal_writer` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`grant`.`proposal` ALTER COLUMN `lead_technical_sector` SET TAGS ('dbx_business_glossary_term' = 'Lead Technical Sector');
ALTER TABLE `vibe_ngo_v1`.`grant`.`proposal` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_ngo_v1`.`grant`.`proposal` ALTER COLUMN `partnership_model` SET TAGS ('dbx_business_glossary_term' = 'Partnership Model');
ALTER TABLE `vibe_ngo_v1`.`grant`.`proposal` ALTER COLUMN `proposal_status` SET TAGS ('dbx_business_glossary_term' = 'Proposal Status');
ALTER TABLE `vibe_ngo_v1`.`grant`.`proposal` ALTER COLUMN `proposal_type` SET TAGS ('dbx_business_glossary_term' = 'Proposal Type');
ALTER TABLE `vibe_ngo_v1`.`grant`.`proposal` ALTER COLUMN `proposed_duration_months` SET TAGS ('dbx_business_glossary_term' = 'Proposed Duration Months');
ALTER TABLE `vibe_ngo_v1`.`grant`.`proposal` ALTER COLUMN `proposed_end_date` SET TAGS ('dbx_business_glossary_term' = 'Proposed End Date');
ALTER TABLE `vibe_ngo_v1`.`grant`.`proposal` ALTER COLUMN `proposed_start_date` SET TAGS ('dbx_business_glossary_term' = 'Proposed Start Date');
ALTER TABLE `vibe_ngo_v1`.`grant`.`proposal` ALTER COLUMN `reference_number` SET TAGS ('dbx_business_glossary_term' = 'Reference Number');
ALTER TABLE `vibe_ngo_v1`.`grant`.`proposal` ALTER COLUMN `rejection_reason` SET TAGS ('dbx_business_glossary_term' = 'Rejection Reason');
ALTER TABLE `vibe_ngo_v1`.`grant`.`proposal` ALTER COLUMN `requested_amount` SET TAGS ('dbx_business_glossary_term' = 'Requested Amount');
ALTER TABLE `vibe_ngo_v1`.`grant`.`proposal` ALTER COLUMN `requested_amount_usd` SET TAGS ('dbx_business_glossary_term' = 'Requested Amount USD');
ALTER TABLE `vibe_ngo_v1`.`grant`.`proposal` ALTER COLUMN `requested_currency` SET TAGS ('dbx_business_glossary_term' = 'Requested Currency');
ALTER TABLE `vibe_ngo_v1`.`grant`.`proposal` ALTER COLUMN `submission_date` SET TAGS ('dbx_business_glossary_term' = 'Submission Date');
ALTER TABLE `vibe_ngo_v1`.`grant`.`proposal` ALTER COLUMN `target_beneficiary_count` SET TAGS ('dbx_business_glossary_term' = 'Target Beneficiary Count');
ALTER TABLE `vibe_ngo_v1`.`grant`.`proposal` ALTER COLUMN `technical_approach_summary` SET TAGS ('dbx_business_glossary_term' = 'Technical Approach Summary');
ALTER TABLE `vibe_ngo_v1`.`grant`.`proposal` ALTER COLUMN `title` SET TAGS ('dbx_business_glossary_term' = 'Title');
ALTER TABLE `vibe_ngo_v1`.`grant`.`proposal` ALTER COLUMN `win_loss_outcome` SET TAGS ('dbx_business_glossary_term' = 'Win/Loss Outcome');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget` SET TAGS ('dbx_subdomain' = 'award_management');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget` ALTER COLUMN `award_budget_id` SET TAGS ('dbx_business_glossary_term' = 'Award Budget ID');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget` ALTER COLUMN `amendment_id` SET TAGS ('dbx_business_glossary_term' = 'Grant Amendment ID');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget` ALTER COLUMN `award_id` SET TAGS ('dbx_business_glossary_term' = 'Award ID');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget` ALTER COLUMN `fund_id` SET TAGS ('dbx_business_glossary_term' = 'Donor Fund Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget` ALTER COLUMN `meal_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Meal Plan Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget` ALTER COLUMN `approved_by` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget` ALTER COLUMN `award_currency` SET TAGS ('dbx_business_glossary_term' = 'Award Currency');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget` ALTER COLUMN `budget_narrative_reference` SET TAGS ('dbx_business_glossary_term' = 'Budget Narrative Reference');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget` ALTER COLUMN `budget_notes` SET TAGS ('dbx_business_glossary_term' = 'Budget Notes');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget` ALTER COLUMN `budget_period` SET TAGS ('dbx_business_glossary_term' = 'Budget Period');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget` ALTER COLUMN `budget_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Budget Period End Date');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget` ALTER COLUMN `budget_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Budget Period Start Date');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget` ALTER COLUMN `budget_status` SET TAGS ('dbx_business_glossary_term' = 'Budget Status');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget` ALTER COLUMN `budget_submission_date` SET TAGS ('dbx_business_glossary_term' = 'Budget Submission Date');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget` ALTER COLUMN `budget_version_number` SET TAGS ('dbx_business_glossary_term' = 'Budget Version Number');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget` ALTER COLUMN `contractual_costs` SET TAGS ('dbx_business_glossary_term' = 'Contractual Costs');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget` ALTER COLUMN `cost_share_amount` SET TAGS ('dbx_business_glossary_term' = 'Cost Share Amount');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget` ALTER COLUMN `cost_share_required` SET TAGS ('dbx_business_glossary_term' = 'Cost Share Required');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget` ALTER COLUMN `donor_approval_date` SET TAGS ('dbx_business_glossary_term' = 'Donor Approval Date');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget` ALTER COLUMN `donor_approval_reference` SET TAGS ('dbx_business_glossary_term' = 'Donor Approval Reference');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget` ALTER COLUMN `equipment_costs` SET TAGS ('dbx_business_glossary_term' = 'Equipment Costs');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget` ALTER COLUMN `fringe_benefits_costs` SET TAGS ('dbx_business_glossary_term' = 'Fringe Benefits Costs');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget` ALTER COLUMN `fund_restriction_type` SET TAGS ('dbx_business_glossary_term' = 'Fund Restriction Type');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget` ALTER COLUMN `indirect_cost_base` SET TAGS ('dbx_business_glossary_term' = 'Indirect Cost Base');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget` ALTER COLUMN `is_amendment` SET TAGS ('dbx_business_glossary_term' = 'Is Amendment');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget` ALTER COLUMN `nicra_rate_applied` SET TAGS ('dbx_business_glossary_term' = 'NICRA Rate Applied');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget` ALTER COLUMN `personnel_costs` SET TAGS ('dbx_business_glossary_term' = 'Personnel Costs');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget` ALTER COLUMN `prepared_by` SET TAGS ('dbx_business_glossary_term' = 'Prepared By');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget` ALTER COLUMN `prepared_by` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget` ALTER COLUMN `supplies_costs` SET TAGS ('dbx_business_glossary_term' = 'Supplies Costs');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget` ALTER COLUMN `total_approved_budget` SET TAGS ('dbx_business_glossary_term' = 'Total Approved Budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget` ALTER COLUMN `total_direct_costs` SET TAGS ('dbx_business_glossary_term' = 'Total Direct Costs');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget` ALTER COLUMN `total_indirect_costs` SET TAGS ('dbx_business_glossary_term' = 'Total Indirect Costs');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget` ALTER COLUMN `travel_costs` SET TAGS ('dbx_business_glossary_term' = 'Travel Costs');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget_line` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget_line` SET TAGS ('dbx_subdomain' = 'award_management');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget_line` ALTER COLUMN `award_budget_line_id` SET TAGS ('dbx_business_glossary_term' = 'Award Budget Line ID');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget_line` ALTER COLUMN `award_budget_id` SET TAGS ('dbx_business_glossary_term' = 'Award Budget ID');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget_line` ALTER COLUMN `award_id` SET TAGS ('dbx_business_glossary_term' = 'Award ID');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget_line` ALTER COLUMN `component_id` SET TAGS ('dbx_business_glossary_term' = 'Component ID');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget_line` ALTER COLUMN `indicator_id` SET TAGS ('dbx_business_glossary_term' = 'Indicator ID');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget_line` ALTER COLUMN `intervention_id` SET TAGS ('dbx_business_glossary_term' = 'Intervention ID');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget_line` ALTER COLUMN `partner_org_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Org Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget_line` ALTER COLUMN `project_site_id` SET TAGS ('dbx_business_glossary_term' = 'Project Site Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget_line` ALTER COLUMN `allocability_flag` SET TAGS ('dbx_business_glossary_term' = 'Allocability Flag');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget_line` ALTER COLUMN `allowability_flag` SET TAGS ('dbx_business_glossary_term' = 'Allowability Flag');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget_line` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget_line` ALTER COLUMN `approved_amount` SET TAGS ('dbx_business_glossary_term' = 'Approved Amount');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget_line` ALTER COLUMN `approved_amount_usd` SET TAGS ('dbx_business_glossary_term' = 'Approved Amount USD');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget_line` ALTER COLUMN `budget_line_status` SET TAGS ('dbx_business_glossary_term' = 'Budget Line Status');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget_line` ALTER COLUMN `cost_category` SET TAGS ('dbx_business_glossary_term' = 'Cost Category');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget_line` ALTER COLUMN `cost_share_amount` SET TAGS ('dbx_business_glossary_term' = 'Cost Share Amount');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget_line` ALTER COLUMN `cost_share_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Cost Share Required Flag');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget_line` ALTER COLUMN `cost_subcategory` SET TAGS ('dbx_business_glossary_term' = 'Cost Subcategory');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget_line` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget_line` ALTER COLUMN `cumulative_expenditure` SET TAGS ('dbx_business_glossary_term' = 'Cumulative Expenditure');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget_line` ALTER COLUMN `cumulative_expenditure_usd` SET TAGS ('dbx_business_glossary_term' = 'Cumulative Expenditure USD');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget_line` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget_line` ALTER COLUMN `donor_reporting_category` SET TAGS ('dbx_business_glossary_term' = 'Donor Reporting Category');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget_line` ALTER COLUMN `exchange_rate` SET TAGS ('dbx_business_glossary_term' = 'Exchange Rate');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget_line` ALTER COLUMN `fiscal_period` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget_line` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget_line` ALTER COLUMN `fund_restriction_type` SET TAGS ('dbx_business_glossary_term' = 'Fund Restriction Type');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget_line` ALTER COLUMN `gl_account_code` SET TAGS ('dbx_business_glossary_term' = 'GL Account Code');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget_line` ALTER COLUMN `indirect_cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Indirect Cost Amount');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget_line` ALTER COLUMN `line_description` SET TAGS ('dbx_business_glossary_term' = 'Line Description');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget_line` ALTER COLUMN `line_item_code` SET TAGS ('dbx_business_glossary_term' = 'Line Item Code');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget_line` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget_line` ALTER COLUMN `nicra_rate_applied` SET TAGS ('dbx_business_glossary_term' = 'NICRA Rate Applied');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget_line` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget_line` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Quantity');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget_line` ALTER COLUMN `reasonableness_flag` SET TAGS ('dbx_business_glossary_term' = 'Reasonableness Flag');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget_line` ALTER COLUMN `revised_amount` SET TAGS ('dbx_business_glossary_term' = 'Revised Amount');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget_line` ALTER COLUMN `revised_amount_usd` SET TAGS ('dbx_business_glossary_term' = 'Revised Amount USD');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget_line` ALTER COLUMN `revision_date` SET TAGS ('dbx_business_glossary_term' = 'Revision Date');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget_line` ALTER COLUMN `revision_reason` SET TAGS ('dbx_business_glossary_term' = 'Revision Reason');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget_line` ALTER COLUMN `supporting_document_reference` SET TAGS ('dbx_business_glossary_term' = 'Supporting Document Reference');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget_line` ALTER COLUMN `unit_cost` SET TAGS ('dbx_business_glossary_term' = 'Unit Cost');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget_line` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget_line` ALTER COLUMN `variance_amount` SET TAGS ('dbx_business_glossary_term' = 'Variance Amount');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget_line` ALTER COLUMN `variance_percentage` SET TAGS ('dbx_business_glossary_term' = 'Variance Percentage');
ALTER TABLE `vibe_ngo_v1`.`grant`.`amendment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_ngo_v1`.`grant`.`amendment` SET TAGS ('dbx_subdomain' = 'award_management');
ALTER TABLE `vibe_ngo_v1`.`grant`.`amendment` ALTER COLUMN `amendment_id` SET TAGS ('dbx_business_glossary_term' = 'Grant Amendment ID');
ALTER TABLE `vibe_ngo_v1`.`grant`.`amendment` ALTER COLUMN `country_office_id` SET TAGS ('dbx_business_glossary_term' = 'Country Office Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`grant`.`amendment` ALTER COLUMN `supersedes_amendment_grant_amendment_id` SET TAGS ('dbx_business_glossary_term' = 'Supersedes Amendment ID');
ALTER TABLE `vibe_ngo_v1`.`grant`.`amendment` ALTER COLUMN `amendment_number` SET TAGS ('dbx_business_glossary_term' = 'Amendment Number');
ALTER TABLE `vibe_ngo_v1`.`grant`.`amendment` ALTER COLUMN `amendment_status` SET TAGS ('dbx_business_glossary_term' = 'Amendment Status');
ALTER TABLE `vibe_ngo_v1`.`grant`.`amendment` ALTER COLUMN `amendment_type` SET TAGS ('dbx_business_glossary_term' = 'Amendment Type');
ALTER TABLE `vibe_ngo_v1`.`grant`.`amendment` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_ngo_v1`.`grant`.`amendment` ALTER COLUMN `approved_by_name` SET TAGS ('dbx_business_glossary_term' = 'Approved By Name');
ALTER TABLE `vibe_ngo_v1`.`grant`.`amendment` ALTER COLUMN `approved_by_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`grant`.`amendment` ALTER COLUMN `approved_by_name` SET TAGS ('dbx_pii_type' = 'name');
ALTER TABLE `vibe_ngo_v1`.`grant`.`amendment` ALTER COLUMN `approved_by_title` SET TAGS ('dbx_business_glossary_term' = 'Approved By Title');
ALTER TABLE `vibe_ngo_v1`.`grant`.`amendment` ALTER COLUMN `budget_modification_summary` SET TAGS ('dbx_business_glossary_term' = 'Budget Modification Summary');
ALTER TABLE `vibe_ngo_v1`.`grant`.`amendment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_ngo_v1`.`grant`.`amendment` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_ngo_v1`.`grant`.`amendment` ALTER COLUMN `amendment_description` SET TAGS ('dbx_business_glossary_term' = 'Amendment Description');
ALTER TABLE `vibe_ngo_v1`.`grant`.`amendment` ALTER COLUMN `donor_approval_reference` SET TAGS ('dbx_business_glossary_term' = 'Donor Approval Reference');
ALTER TABLE `vibe_ngo_v1`.`grant`.`amendment` ALTER COLUMN `donor_prior_approval_required` SET TAGS ('dbx_business_glossary_term' = 'Donor Prior Approval Required');
ALTER TABLE `vibe_ngo_v1`.`grant`.`amendment` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_ngo_v1`.`grant`.`amendment` ALTER COLUMN `execution_date` SET TAGS ('dbx_business_glossary_term' = 'Execution Date');
ALTER TABLE `vibe_ngo_v1`.`grant`.`amendment` ALTER COLUMN `funding_change` SET TAGS ('dbx_business_glossary_term' = 'Funding Change');
ALTER TABLE `vibe_ngo_v1`.`grant`.`amendment` ALTER COLUMN `geographic_change_description` SET TAGS ('dbx_business_glossary_term' = 'Geographic Change Description');
ALTER TABLE `vibe_ngo_v1`.`grant`.`amendment` ALTER COLUMN `internal_approval_date` SET TAGS ('dbx_business_glossary_term' = 'Internal Approval Date');
ALTER TABLE `vibe_ngo_v1`.`grant`.`amendment` ALTER COLUMN `internal_approver_name` SET TAGS ('dbx_business_glossary_term' = 'Internal Approver Name');
ALTER TABLE `vibe_ngo_v1`.`grant`.`amendment` ALTER COLUMN `internal_approver_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`grant`.`amendment` ALTER COLUMN `internal_approver_name` SET TAGS ('dbx_pii_type' = 'name');
ALTER TABLE `vibe_ngo_v1`.`grant`.`amendment` ALTER COLUMN `is_no_cost_extension` SET TAGS ('dbx_business_glossary_term' = 'Is No Cost Extension');
ALTER TABLE `vibe_ngo_v1`.`grant`.`amendment` ALTER COLUMN `justification` SET TAGS ('dbx_business_glossary_term' = 'Justification');
ALTER TABLE `vibe_ngo_v1`.`grant`.`amendment` ALTER COLUMN `key_personnel_change_description` SET TAGS ('dbx_business_glossary_term' = 'Key Personnel Change Description');
ALTER TABLE `vibe_ngo_v1`.`grant`.`amendment` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_ngo_v1`.`grant`.`amendment` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_ngo_v1`.`grant`.`amendment` ALTER COLUMN `original_end_date` SET TAGS ('dbx_business_glossary_term' = 'Original End Date');
ALTER TABLE `vibe_ngo_v1`.`grant`.`amendment` ALTER COLUMN `original_start_date` SET TAGS ('dbx_business_glossary_term' = 'Original Start Date');
ALTER TABLE `vibe_ngo_v1`.`grant`.`amendment` ALTER COLUMN `original_total_obligation` SET TAGS ('dbx_business_glossary_term' = 'Original Total Obligation');
ALTER TABLE `vibe_ngo_v1`.`grant`.`amendment` ALTER COLUMN `period_extension_days` SET TAGS ('dbx_business_glossary_term' = 'Period Extension Days');
ALTER TABLE `vibe_ngo_v1`.`grant`.`amendment` ALTER COLUMN `request_date` SET TAGS ('dbx_business_glossary_term' = 'Request Date');
ALTER TABLE `vibe_ngo_v1`.`grant`.`amendment` ALTER COLUMN `revised_end_date` SET TAGS ('dbx_business_glossary_term' = 'Revised End Date');
ALTER TABLE `vibe_ngo_v1`.`grant`.`amendment` ALTER COLUMN `revised_start_date` SET TAGS ('dbx_business_glossary_term' = 'Revised Start Date');
ALTER TABLE `vibe_ngo_v1`.`grant`.`amendment` ALTER COLUMN `revised_total_obligation` SET TAGS ('dbx_business_glossary_term' = 'Revised Total Obligation');
ALTER TABLE `vibe_ngo_v1`.`grant`.`amendment` ALTER COLUMN `scope_change_description` SET TAGS ('dbx_business_glossary_term' = 'Scope Change Description');
ALTER TABLE `vibe_ngo_v1`.`grant`.`amendment` ALTER COLUMN `supporting_document_reference` SET TAGS ('dbx_business_glossary_term' = 'Supporting Document Reference');
ALTER TABLE `vibe_ngo_v1`.`grant`.`amendment` ALTER COLUMN `terms_and_conditions_change` SET TAGS ('dbx_business_glossary_term' = 'Terms and Conditions Change');
ALTER TABLE `vibe_ngo_v1`.`grant`.`subaward` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_ngo_v1`.`grant`.`subaward` SET TAGS ('dbx_subdomain' = 'award_management');
ALTER TABLE `vibe_ngo_v1`.`grant`.`subaward` ALTER COLUMN `subaward_id` SET TAGS ('dbx_business_glossary_term' = 'Subaward ID');
ALTER TABLE `vibe_ngo_v1`.`grant`.`subaward` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Partnership Agreement Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`grant`.`subaward` ALTER COLUMN `award_id` SET TAGS ('dbx_business_glossary_term' = 'Award ID');
ALTER TABLE `vibe_ngo_v1`.`grant`.`subaward` ALTER COLUMN `country_office_id` SET TAGS ('dbx_business_glossary_term' = 'Country Office Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`grant`.`subaward` ALTER COLUMN `constituent_id` SET TAGS ('dbx_business_glossary_term' = 'Grantee Constituent Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`grant`.`subaward` ALTER COLUMN `meal_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Meal Plan Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`grant`.`subaward` ALTER COLUMN `mel_logframe_id` SET TAGS ('dbx_business_glossary_term' = 'Mel Logframe Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`grant`.`subaward` ALTER COLUMN `partner_org_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Org ID');
ALTER TABLE `vibe_ngo_v1`.`grant`.`subaward` ALTER COLUMN `project_site_id` SET TAGS ('dbx_business_glossary_term' = 'Project Site ID');
ALTER TABLE `vibe_ngo_v1`.`grant`.`subaward` ALTER COLUMN `psea_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Psea Policy Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`grant`.`subaward` ALTER COLUMN `single_audit_id` SET TAGS ('dbx_business_glossary_term' = 'Single Audit Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`grant`.`subaward` ALTER COLUMN `statutory_registration_id` SET TAGS ('dbx_business_glossary_term' = 'Statutory Registration Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`grant`.`subaward` ALTER COLUMN `amendment_count` SET TAGS ('dbx_business_glossary_term' = 'Amendment Count');
ALTER TABLE `vibe_ngo_v1`.`grant`.`subaward` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_ngo_v1`.`grant`.`subaward` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `vibe_ngo_v1`.`grant`.`subaward` ALTER COLUMN `approved_by` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`grant`.`subaward` ALTER COLUMN `closeout_date` SET TAGS ('dbx_business_glossary_term' = 'Closeout Date');
ALTER TABLE `vibe_ngo_v1`.`grant`.`subaward` ALTER COLUMN `cost_share_amount` SET TAGS ('dbx_business_glossary_term' = 'Cost Share Amount');
ALTER TABLE `vibe_ngo_v1`.`grant`.`subaward` ALTER COLUMN `cost_share_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Cost Share Required Flag');
ALTER TABLE `vibe_ngo_v1`.`grant`.`subaward` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_ngo_v1`.`grant`.`subaward` ALTER COLUMN `currency` SET TAGS ('dbx_business_glossary_term' = 'Currency');
ALTER TABLE `vibe_ngo_v1`.`grant`.`subaward` ALTER COLUMN `subaward_description` SET TAGS ('dbx_business_glossary_term' = 'Subaward Description');
ALTER TABLE `vibe_ngo_v1`.`grant`.`subaward` ALTER COLUMN `disbursed_amount` SET TAGS ('dbx_business_glossary_term' = 'Disbursed Amount');
ALTER TABLE `vibe_ngo_v1`.`grant`.`subaward` ALTER COLUMN `duns_number` SET TAGS ('dbx_business_glossary_term' = 'DUNS Number');
ALTER TABLE `vibe_ngo_v1`.`grant`.`subaward` ALTER COLUMN `execution_date` SET TAGS ('dbx_business_glossary_term' = 'Execution Date');
ALTER TABLE `vibe_ngo_v1`.`grant`.`subaward` ALTER COLUMN `ffata_reporting_required_flag` SET TAGS ('dbx_business_glossary_term' = 'FFATA Reporting Required');
ALTER TABLE `vibe_ngo_v1`.`grant`.`subaward` ALTER COLUMN `flow_down_requirements` SET TAGS ('dbx_business_glossary_term' = 'Flow Down Requirements');
ALTER TABLE `vibe_ngo_v1`.`grant`.`subaward` ALTER COLUMN `fsrs_report_date` SET TAGS ('dbx_business_glossary_term' = 'FSRS Report Date');
ALTER TABLE `vibe_ngo_v1`.`grant`.`subaward` ALTER COLUMN `fund_restriction_type` SET TAGS ('dbx_business_glossary_term' = 'Fund Restriction Type');
ALTER TABLE `vibe_ngo_v1`.`grant`.`subaward` ALTER COLUMN `grant_type_classification` SET TAGS ('dbx_business_glossary_term' = 'Grant Type Classification');
ALTER TABLE `vibe_ngo_v1`.`grant`.`subaward` ALTER COLUMN `indirect_cost_base` SET TAGS ('dbx_business_glossary_term' = 'Indirect Cost Base');
ALTER TABLE `vibe_ngo_v1`.`grant`.`subaward` ALTER COLUMN `indirect_cost_rate` SET TAGS ('dbx_business_glossary_term' = 'Indirect Cost Rate');
ALTER TABLE `vibe_ngo_v1`.`grant`.`subaward` ALTER COLUMN `is_grantmaking_out_flow` SET TAGS ('dbx_business_glossary_term' = 'Is Grantmaking Out Flow');
ALTER TABLE `vibe_ngo_v1`.`grant`.`subaward` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_ngo_v1`.`grant`.`subaward` ALTER COLUMN `monitoring_frequency` SET TAGS ('dbx_business_glossary_term' = 'Monitoring Frequency');
ALTER TABLE `vibe_ngo_v1`.`grant`.`subaward` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_ngo_v1`.`grant`.`subaward` ALTER COLUMN `obligated_amount` SET TAGS ('dbx_business_glossary_term' = 'Obligated Amount');
ALTER TABLE `vibe_ngo_v1`.`grant`.`subaward` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `vibe_ngo_v1`.`grant`.`subaward` ALTER COLUMN `payment_schedule` SET TAGS ('dbx_business_glossary_term' = 'Payment Schedule');
ALTER TABLE `vibe_ngo_v1`.`grant`.`subaward` ALTER COLUMN `period_of_performance_end_date` SET TAGS ('dbx_business_glossary_term' = 'Period of Performance End Date');
ALTER TABLE `vibe_ngo_v1`.`grant`.`subaward` ALTER COLUMN `period_of_performance_start_date` SET TAGS ('dbx_business_glossary_term' = 'Period of Performance Start Date');
ALTER TABLE `vibe_ngo_v1`.`grant`.`subaward` ALTER COLUMN `remaining_balance` SET TAGS ('dbx_business_glossary_term' = 'Remaining Balance');
ALTER TABLE `vibe_ngo_v1`.`grant`.`subaward` ALTER COLUMN `reporting_frequency` SET TAGS ('dbx_business_glossary_term' = 'Reporting Frequency');
ALTER TABLE `vibe_ngo_v1`.`grant`.`subaward` ALTER COLUMN `risk_rating` SET TAGS ('dbx_business_glossary_term' = 'Risk Rating');
ALTER TABLE `vibe_ngo_v1`.`grant`.`subaward` ALTER COLUMN `single_audit_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Single Audit Required');
ALTER TABLE `vibe_ngo_v1`.`grant`.`subaward` ALTER COLUMN `subaward_number` SET TAGS ('dbx_business_glossary_term' = 'Subaward Number');
ALTER TABLE `vibe_ngo_v1`.`grant`.`subaward` ALTER COLUMN `subaward_status` SET TAGS ('dbx_business_glossary_term' = 'Subaward Status');
ALTER TABLE `vibe_ngo_v1`.`grant`.`subaward` ALTER COLUMN `subaward_type` SET TAGS ('dbx_business_glossary_term' = 'Subaward Type');
ALTER TABLE `vibe_ngo_v1`.`grant`.`subaward` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Termination Date');
ALTER TABLE `vibe_ngo_v1`.`grant`.`subaward` ALTER COLUMN `termination_reason` SET TAGS ('dbx_business_glossary_term' = 'Termination Reason');
ALTER TABLE `vibe_ngo_v1`.`grant`.`subaward` ALTER COLUMN `title` SET TAGS ('dbx_business_glossary_term' = 'Title');
ALTER TABLE `vibe_ngo_v1`.`grant`.`subaward` ALTER COLUMN `total_subaward_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Subaward Amount');
ALTER TABLE `vibe_ngo_v1`.`grant`.`subaward` ALTER COLUMN `total_subaward_amount_usd` SET TAGS ('dbx_business_glossary_term' = 'Total Subaward Amount USD');
ALTER TABLE `vibe_ngo_v1`.`grant`.`subaward` ALTER COLUMN `uei_number` SET TAGS ('dbx_business_glossary_term' = 'UEI Number');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_condition` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_condition` SET TAGS ('dbx_subdomain' = 'donor_compliance');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_condition` ALTER COLUMN `donor_condition_id` SET TAGS ('dbx_business_glossary_term' = 'Donor Condition ID');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_condition` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Partnership Agreement Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_condition` ALTER COLUMN `amendment_id` SET TAGS ('dbx_business_glossary_term' = 'Grant Amendment Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_condition` ALTER COLUMN `award_id` SET TAGS ('dbx_business_glossary_term' = 'Award ID');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_condition` ALTER COLUMN `constituent_id` SET TAGS ('dbx_business_glossary_term' = 'Constituent ID');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_condition` ALTER COLUMN `constituent_id` SET TAGS ('dbx_pii_type' = 'personal');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_condition` ALTER COLUMN `evaluation_id` SET TAGS ('dbx_business_glossary_term' = 'Evaluation ID');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_condition` ALTER COLUMN `indicator_id` SET TAGS ('dbx_business_glossary_term' = 'Indicator ID');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_condition` ALTER COLUMN `indicator_target_id` SET TAGS ('dbx_business_glossary_term' = 'Indicator Target Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_condition` ALTER COLUMN `obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Obligation Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_condition` ALTER COLUMN `partner_org_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Org Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_condition` ALTER COLUMN `psea_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Psea Policy Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_condition` ALTER COLUMN `actual_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Completion Date');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_condition` ALTER COLUMN `approval_authority` SET TAGS ('dbx_business_glossary_term' = 'Approval Authority');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_condition` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_condition` ALTER COLUMN `approval_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Approval Reference Number');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_condition` ALTER COLUMN `compliance_notes` SET TAGS ('dbx_business_glossary_term' = 'Compliance Notes');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_condition` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_condition` ALTER COLUMN `condition_category` SET TAGS ('dbx_business_glossary_term' = 'Condition Category');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_condition` ALTER COLUMN `condition_description` SET TAGS ('dbx_business_glossary_term' = 'Condition Description');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_condition` ALTER COLUMN `condition_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Condition Reference Number');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_condition` ALTER COLUMN `condition_title` SET TAGS ('dbx_business_glossary_term' = 'Condition Title');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_condition` ALTER COLUMN `condition_type` SET TAGS ('dbx_business_glossary_term' = 'Condition Type');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_condition` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_condition` ALTER COLUMN `deliverable_description` SET TAGS ('dbx_business_glossary_term' = 'Deliverable Description');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_condition` ALTER COLUMN `donor_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Donor Contact Email');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_condition` ALTER COLUMN `donor_contact_email` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_condition` ALTER COLUMN `donor_contact_email` SET TAGS ('dbx_pii_type' = 'email');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_condition` ALTER COLUMN `donor_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Donor Contact Name');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_condition` ALTER COLUMN `donor_contact_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_condition` ALTER COLUMN `donor_contact_name` SET TAGS ('dbx_pii_type' = 'name');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_condition` ALTER COLUMN `due_date` SET TAGS ('dbx_business_glossary_term' = 'Due Date');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_condition` ALTER COLUMN `escalation_threshold_days` SET TAGS ('dbx_business_glossary_term' = 'Escalation Threshold Days');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_condition` ALTER COLUMN `financial_threshold_amount` SET TAGS ('dbx_business_glossary_term' = 'Financial Threshold Amount');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_condition` ALTER COLUMN `financial_threshold_currency` SET TAGS ('dbx_business_glossary_term' = 'Financial Threshold Currency');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_condition` ALTER COLUMN `is_membership_obligation` SET TAGS ('dbx_business_glossary_term' = 'Is Membership Obligation');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_condition` ALTER COLUMN `is_special_award_condition` SET TAGS ('dbx_business_glossary_term' = 'Is Special Award Condition');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_condition` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_condition` ALTER COLUMN `membership_dues_amount` SET TAGS ('dbx_business_glossary_term' = 'Membership Dues Amount');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_condition` ALTER COLUMN `membership_renewal_date` SET TAGS ('dbx_business_glossary_term' = 'Membership Renewal Date');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_condition` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Modified By');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_condition` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_condition` ALTER COLUMN `monitoring_frequency` SET TAGS ('dbx_business_glossary_term' = 'Monitoring Frequency');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_condition` ALTER COLUMN `next_recurrence_date` SET TAGS ('dbx_business_glossary_term' = 'Next Recurrence Date');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_condition` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_condition` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Priority Level');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_condition` ALTER COLUMN `recurrence_frequency` SET TAGS ('dbx_business_glossary_term' = 'Recurrence Frequency');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_condition` ALTER COLUMN `regulatory_citation` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Citation');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_condition` ALTER COLUMN `responsible_department` SET TAGS ('dbx_business_glossary_term' = 'Responsible Department');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_condition` ALTER COLUMN `risk_rating` SET TAGS ('dbx_business_glossary_term' = 'Risk Rating');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_condition` ALTER COLUMN `sac_justification` SET TAGS ('dbx_business_glossary_term' = 'SAC Justification');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_condition` ALTER COLUMN `supporting_document_reference` SET TAGS ('dbx_business_glossary_term' = 'Supporting Document Reference');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_condition` ALTER COLUMN `waiver_date` SET TAGS ('dbx_business_glossary_term' = 'Waiver Date');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_condition` ALTER COLUMN `waiver_justification` SET TAGS ('dbx_business_glossary_term' = 'Waiver Justification');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_condition` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_report` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_report` SET TAGS ('dbx_subdomain' = 'donor_compliance');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_report` ALTER COLUMN `donor_report_id` SET TAGS ('dbx_business_glossary_term' = 'Donor Report ID');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_report` ALTER COLUMN `award_id` SET TAGS ('dbx_business_glossary_term' = 'Award ID');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_report` ALTER COLUMN `country_office_id` SET TAGS ('dbx_business_glossary_term' = 'Country Office Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_report` ALTER COLUMN `donor_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Donor Requirement Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_report` ALTER COLUMN `fund_id` SET TAGS ('dbx_business_glossary_term' = 'Donor Fund Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_report` ALTER COLUMN `incident_id` SET TAGS ('dbx_business_glossary_term' = 'Safeguarding Incident Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_report` ALTER COLUMN `intervention_id` SET TAGS ('dbx_business_glossary_term' = 'Intervention ID');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_report` ALTER COLUMN `mel_logframe_id` SET TAGS ('dbx_business_glossary_term' = 'Mel Logframe Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_report` ALTER COLUMN `obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Obligation Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_report` ALTER COLUMN `project_site_id` SET TAGS ('dbx_business_glossary_term' = 'Project Site ID');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_report` ALTER COLUMN `reporting_period_id` SET TAGS ('dbx_business_glossary_term' = 'Reporting Period Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_report` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_report` ALTER COLUMN `audit_findings_count` SET TAGS ('dbx_business_glossary_term' = 'Audit Findings Count');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_report` ALTER COLUMN `beneficiaries_reached` SET TAGS ('dbx_business_glossary_term' = 'Beneficiaries Reached');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_report` ALTER COLUMN `budget_variance_amount` SET TAGS ('dbx_business_glossary_term' = 'Budget Variance Amount');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_report` ALTER COLUMN `budget_variance_percentage` SET TAGS ('dbx_business_glossary_term' = 'Budget Variance Percentage');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_report` ALTER COLUMN `compliance_certification_flag` SET TAGS ('dbx_business_glossary_term' = 'Compliance Certification Flag');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_report` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_report` ALTER COLUMN `cumulative_expenditure_to_date` SET TAGS ('dbx_business_glossary_term' = 'Cumulative Expenditure to Date');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_report` ALTER COLUMN `days_overdue` SET TAGS ('dbx_business_glossary_term' = 'Days Overdue');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_report` ALTER COLUMN `donor_acceptance_date` SET TAGS ('dbx_business_glossary_term' = 'Donor Acceptance Date');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_report` ALTER COLUMN `donor_feedback_summary` SET TAGS ('dbx_business_glossary_term' = 'Donor Feedback Summary');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_report` ALTER COLUMN `due_date` SET TAGS ('dbx_business_glossary_term' = 'Due Date');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_report` ALTER COLUMN `exchange_rate_used` SET TAGS ('dbx_business_glossary_term' = 'Exchange Rate Used');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_report` ALTER COLUMN `financial_amount_reported` SET TAGS ('dbx_business_glossary_term' = 'Financial Amount Reported');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_report` ALTER COLUMN `financial_amount_reported_usd` SET TAGS ('dbx_business_glossary_term' = 'Financial Amount Reported USD');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_report` ALTER COLUMN `financial_currency` SET TAGS ('dbx_business_glossary_term' = 'Financial Currency');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_report` ALTER COLUMN `is_final_version` SET TAGS ('dbx_business_glossary_term' = 'Is Final Version');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_report` ALTER COLUMN `is_overdue` SET TAGS ('dbx_business_glossary_term' = 'Is Overdue');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_report` ALTER COLUMN `key_performance_indicators_met` SET TAGS ('dbx_business_glossary_term' = 'KPIs Met');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_report` ALTER COLUMN `key_performance_indicators_total` SET TAGS ('dbx_business_glossary_term' = 'KPIs Total');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_report` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_report` ALTER COLUMN `narrative_summary` SET TAGS ('dbx_business_glossary_term' = 'Narrative Summary');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_report` ALTER COLUMN `report_notes` SET TAGS ('dbx_business_glossary_term' = 'Report Notes');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_report` ALTER COLUMN `report_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Report Reference Number');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_report` ALTER COLUMN `report_status` SET TAGS ('dbx_business_glossary_term' = 'Report Status');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_report` ALTER COLUMN `report_type` SET TAGS ('dbx_business_glossary_term' = 'Report Type');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_report` ALTER COLUMN `reporting_frequency` SET TAGS ('dbx_business_glossary_term' = 'Reporting Frequency');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_report` ALTER COLUMN `reporting_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Reporting Period End Date');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_report` ALTER COLUMN `reporting_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Reporting Period Start Date');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_report` ALTER COLUMN `revision_reason` SET TAGS ('dbx_business_glossary_term' = 'Revision Reason');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_report` ALTER COLUMN `revision_requested_date` SET TAGS ('dbx_business_glossary_term' = 'Revision Requested Date');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_report` ALTER COLUMN `submission_date` SET TAGS ('dbx_business_glossary_term' = 'Submission Date');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_report` ALTER COLUMN `submission_method` SET TAGS ('dbx_business_glossary_term' = 'Submission Method');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_report` ALTER COLUMN `supporting_document_reference` SET TAGS ('dbx_business_glossary_term' = 'Supporting Document Reference');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_report` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `vibe_ngo_v1`.`grant`.`funding_source` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `vibe_ngo_v1`.`grant`.`funding_source` SET TAGS ('dbx_subdomain' = 'donor_compliance');
ALTER TABLE `vibe_ngo_v1`.`grant`.`funding_source` ALTER COLUMN `funding_source_id` SET TAGS ('dbx_business_glossary_term' = 'Funding Source ID');
ALTER TABLE `vibe_ngo_v1`.`grant`.`funding_source` ALTER COLUMN `constituent_id` SET TAGS ('dbx_business_glossary_term' = 'Constituent Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`grant`.`funding_source` ALTER COLUMN `obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Obligation Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`grant`.`funding_source` ALTER COLUMN `partner_org_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Org ID');
ALTER TABLE `vibe_ngo_v1`.`grant`.`funding_source` ALTER COLUMN `advance_payment_allowed` SET TAGS ('dbx_business_glossary_term' = 'Advance Payment Allowed');
ALTER TABLE `vibe_ngo_v1`.`grant`.`funding_source` ALTER COLUMN `allowable_cost_categories` SET TAGS ('dbx_business_glossary_term' = 'Allowable Cost Categories');
ALTER TABLE `vibe_ngo_v1`.`grant`.`funding_source` ALTER COLUMN `audit_requirement` SET TAGS ('dbx_business_glossary_term' = 'Audit Requirement');
ALTER TABLE `vibe_ngo_v1`.`grant`.`funding_source` ALTER COLUMN `budget_flexibility` SET TAGS ('dbx_business_glossary_term' = 'Budget Flexibility');
ALTER TABLE `vibe_ngo_v1`.`grant`.`funding_source` ALTER COLUMN `budget_revision_threshold` SET TAGS ('dbx_business_glossary_term' = 'Budget Revision Threshold');
ALTER TABLE `vibe_ngo_v1`.`grant`.`funding_source` ALTER COLUMN `closeout_period_days` SET TAGS ('dbx_business_glossary_term' = 'Closeout Period Days');
ALTER TABLE `vibe_ngo_v1`.`grant`.`funding_source` ALTER COLUMN `funding_source_code` SET TAGS ('dbx_business_glossary_term' = 'Funding Source Code');
ALTER TABLE `vibe_ngo_v1`.`grant`.`funding_source` ALTER COLUMN `compliance_framework` SET TAGS ('dbx_business_glossary_term' = 'Compliance Framework');
ALTER TABLE `vibe_ngo_v1`.`grant`.`funding_source` ALTER COLUMN `contact_email` SET TAGS ('dbx_business_glossary_term' = 'Contact Email');
ALTER TABLE `vibe_ngo_v1`.`grant`.`funding_source` ALTER COLUMN `contact_email` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`grant`.`funding_source` ALTER COLUMN `contact_email` SET TAGS ('dbx_pii_type' = 'email');
ALTER TABLE `vibe_ngo_v1`.`grant`.`funding_source` ALTER COLUMN `contact_person_name` SET TAGS ('dbx_business_glossary_term' = 'Contact Person Name');
ALTER TABLE `vibe_ngo_v1`.`grant`.`funding_source` ALTER COLUMN `contact_person_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`grant`.`funding_source` ALTER COLUMN `contact_person_name` SET TAGS ('dbx_pii_type' = 'name');
ALTER TABLE `vibe_ngo_v1`.`grant`.`funding_source` ALTER COLUMN `contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Contact Phone');
ALTER TABLE `vibe_ngo_v1`.`grant`.`funding_source` ALTER COLUMN `contact_phone` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`grant`.`funding_source` ALTER COLUMN `contact_phone` SET TAGS ('dbx_pii_type' = 'phone');
ALTER TABLE `vibe_ngo_v1`.`grant`.`funding_source` ALTER COLUMN `cost_share_percentage` SET TAGS ('dbx_business_glossary_term' = 'Cost Share Percentage');
ALTER TABLE `vibe_ngo_v1`.`grant`.`funding_source` ALTER COLUMN `cost_share_required` SET TAGS ('dbx_business_glossary_term' = 'Cost Share Required');
ALTER TABLE `vibe_ngo_v1`.`grant`.`funding_source` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_ngo_v1`.`grant`.`funding_source` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_ngo_v1`.`grant`.`funding_source` ALTER COLUMN `funding_source_description` SET TAGS ('dbx_business_glossary_term' = 'Funding Source Description');
ALTER TABLE `vibe_ngo_v1`.`grant`.`funding_source` ALTER COLUMN `donor_reporting_frequency` SET TAGS ('dbx_business_glossary_term' = 'Donor Reporting Frequency');
ALTER TABLE `vibe_ngo_v1`.`grant`.`funding_source` ALTER COLUMN `endowment_net_appreciation_amount` SET TAGS ('dbx_business_glossary_term' = 'Endowment Net Appreciation Amount');
ALTER TABLE `vibe_ngo_v1`.`grant`.`funding_source` ALTER COLUMN `endowment_principal_amount` SET TAGS ('dbx_business_glossary_term' = 'Endowment Principal Amount');
ALTER TABLE `vibe_ngo_v1`.`grant`.`funding_source` ALTER COLUMN `endowment_spending_policy_rate` SET TAGS ('dbx_business_glossary_term' = 'Endowment Spending Policy Rate');
ALTER TABLE `vibe_ngo_v1`.`grant`.`funding_source` ALTER COLUMN `fund_restriction_type` SET TAGS ('dbx_business_glossary_term' = 'Fund Restriction Type');
ALTER TABLE `vibe_ngo_v1`.`grant`.`funding_source` ALTER COLUMN `funding_end_date` SET TAGS ('dbx_business_glossary_term' = 'Funding End Date');
ALTER TABLE `vibe_ngo_v1`.`grant`.`funding_source` ALTER COLUMN `funding_mechanism_type` SET TAGS ('dbx_business_glossary_term' = 'Funding Mechanism Type');
ALTER TABLE `vibe_ngo_v1`.`grant`.`funding_source` ALTER COLUMN `funding_source_status` SET TAGS ('dbx_business_glossary_term' = 'Funding Source Status');
ALTER TABLE `vibe_ngo_v1`.`grant`.`funding_source` ALTER COLUMN `funding_start_date` SET TAGS ('dbx_business_glossary_term' = 'Funding Start Date');
ALTER TABLE `vibe_ngo_v1`.`grant`.`funding_source` ALTER COLUMN `geographic_restriction` SET TAGS ('dbx_business_glossary_term' = 'Geographic Restriction');
ALTER TABLE `vibe_ngo_v1`.`grant`.`funding_source` ALTER COLUMN `iati_organization_identifier` SET TAGS ('dbx_business_glossary_term' = 'IATI Organization Identifier');
ALTER TABLE `vibe_ngo_v1`.`grant`.`funding_source` ALTER COLUMN `indirect_cost_rate_type` SET TAGS ('dbx_business_glossary_term' = 'Indirect Cost Rate Type');
ALTER TABLE `vibe_ngo_v1`.`grant`.`funding_source` ALTER COLUMN `is_endowment_fund` SET TAGS ('dbx_business_glossary_term' = 'Is Endowment Fund');
ALTER TABLE `vibe_ngo_v1`.`grant`.`funding_source` ALTER COLUMN `is_membership_dues_source` SET TAGS ('dbx_business_glossary_term' = 'Is Membership Dues Source');
ALTER TABLE `vibe_ngo_v1`.`grant`.`funding_source` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_ngo_v1`.`grant`.`funding_source` ALTER COLUMN `funding_source_name` SET TAGS ('dbx_business_glossary_term' = 'Funding Source Name');
ALTER TABLE `vibe_ngo_v1`.`grant`.`funding_source` ALTER COLUMN `funding_source_name` SET TAGS ('dbx_pii_type' = 'name');
ALTER TABLE `vibe_ngo_v1`.`grant`.`funding_source` ALTER COLUMN `nicra_rate` SET TAGS ('dbx_business_glossary_term' = 'NICRA Rate');
ALTER TABLE `vibe_ngo_v1`.`grant`.`funding_source` ALTER COLUMN `oda_dac_classification` SET TAGS ('dbx_business_glossary_term' = 'ODA DAC Classification');
ALTER TABLE `vibe_ngo_v1`.`grant`.`funding_source` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `vibe_ngo_v1`.`grant`.`funding_source` ALTER COLUMN `procurement_standards` SET TAGS ('dbx_business_glossary_term' = 'Procurement Standards');
ALTER TABLE `vibe_ngo_v1`.`grant`.`funding_source` ALTER COLUMN `program_income_treatment` SET TAGS ('dbx_business_glossary_term' = 'Program Income Treatment');
ALTER TABLE `vibe_ngo_v1`.`grant`.`funding_source` ALTER COLUMN `program_income_treatment` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`funding_source` ALTER COLUMN `program_income_treatment` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`funding_source` ALTER COLUMN `record_retention_years` SET TAGS ('dbx_business_glossary_term' = 'Record Retention Years');
ALTER TABLE `vibe_ngo_v1`.`grant`.`funding_source` ALTER COLUMN `sdg_alignment_codes` SET TAGS ('dbx_business_glossary_term' = 'SDG Alignment Codes');
ALTER TABLE `vibe_ngo_v1`.`grant`.`funding_source` ALTER COLUMN `subaward_allowed` SET TAGS ('dbx_business_glossary_term' = 'Subaward Allowed');
ALTER TABLE `vibe_ngo_v1`.`grant`.`funding_source` ALTER COLUMN `subaward_approval_required` SET TAGS ('dbx_business_glossary_term' = 'Subaward Approval Required');
ALTER TABLE `vibe_ngo_v1`.`grant`.`funding_source` ALTER COLUMN `thematic_restriction` SET TAGS ('dbx_business_glossary_term' = 'Thematic Restriction');
ALTER TABLE `vibe_ngo_v1`.`grant`.`funding_source` ALTER COLUMN `total_funding_available` SET TAGS ('dbx_business_glossary_term' = 'Total Funding Available');
ALTER TABLE `vibe_ngo_v1`.`grant`.`funding_source` ALTER COLUMN `unallowable_cost_categories` SET TAGS ('dbx_business_glossary_term' = 'Unallowable Cost Categories');
