-- Schema for Domain: grant | Business: Ngo | Version: v2_mvm
-- Generated on: 2026-07-10 20:23:31

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_ngo_v1`.`grant` COMMENT 'Authoritative domain for all grant awards, funding agreements, and donor contracts. Manages grant lifecycle from proposal development and submission through award, amendment, budget tracking, compliance, and closeout. Tracks donor conditions, restricted vs. unrestricted funding, NICRA/ICR rates, and compliance obligations under USAID, BHA, DFID, CERF, and OMB Uniform Guidance 2 CFR 200.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_ngo_v1`.`grant`.`award` (
    `award_id` BIGINT COMMENT 'Unique identifier for the grant award record. Primary key for the award entity.',
    `constituent_id` BIGINT COMMENT 'Reference to the institutional donor or funding agency that issued this award (USAID, BHA, DFID, CERF, UN agencies, foundations, corporates).',
    `country_id` BIGINT COMMENT 'Foreign key linking to field.country. Business justification: DAC sector coding, geographic compliance reporting, and IATI submission all require linking an award directly to a country record. primary_country_code is a denormalized country reference replaced by ',
    `country_office_id` BIGINT COMMENT 'Foreign key linking to field.country_office. Business justification: Awards are managed and implemented by country offices. Core to operational structure, financial management, country-level portfolio analysis, compliance oversight, and donor relationship management at',
    `funding_source_id` BIGINT COMMENT 'Foreign key linking to grant.funding_source. Business justification: The funding_source product is the authoritative reference master for all funding sources and donor funding mechanisms (USAID, BHA, DFID, CERF, etc.). An award is fundamentally tied to a specific fundi',
    `intervention_id` BIGINT COMMENT 'FK to program.intervention.intervention_id — MUST-HAVE: Cannot link grants to the programs they fund without this join. Essential for BvA reporting, donor reporting, and program-grant traceability.',
    `advance_payment_allowed` BOOLEAN COMMENT 'Indicates whether the donor allows advance payments or if reimbursement-only is required.',
    `agreement_signed_date` DATE COMMENT 'The date on which the award agreement was signed by both the donor and the NGO.',
    `amendment_count` STRING COMMENT 'The total number of amendments or modifications made to the original award agreement.',
    `audit_required` BOOLEAN COMMENT 'Indicates whether the award requires a specific audit (e.g., A-133 single audit, donor-specific audit).',
    `audit_threshold_amount` DECIMAL(18,2) COMMENT 'The expenditure threshold that triggers audit requirements under this award.',
    `authorized_amount` DECIMAL(18,2) COMMENT 'The maximum amount authorized for expenditure under this award, which may differ from the obligated amount due to amendments or modifications.',
    `award_status` STRING COMMENT 'Current lifecycle status of the award: pipeline (anticipated), active (in execution), no-cost extension (extended without additional funds), suspended, or closed.. Valid values are `pipeline|active|no_cost_extension|suspended|closed`',
    `award_type` STRING COMMENT 'The classification of the funding mechanism: cooperative agreement, contract, grant, sub-award, consortium lead, or consortium member.. Valid values are `cooperative_agreement|contract|grant|sub_award|consortium_lead|consortium_member`',
    `branding_marking_requirements` STRING COMMENT 'Donor-specific requirements for branding, marking, and visibility of donor support in program materials and communications.',
    `closeout_date` DATE COMMENT 'The date on which the award was officially closed out after all financial and programmatic reporting requirements were completed.',
    `cost_share_amount` DECIMAL(18,2) COMMENT 'The total amount of cost-sharing required from the NGO in the award currency.',
    `cost_share_percentage` DECIMAL(18,2) COMMENT 'The percentage of total project costs that must be contributed by the NGO as cost-sharing, expressed as a decimal.',
    `cost_share_required` BOOLEAN COMMENT 'Indicates whether the award requires the NGO to provide cost-sharing or matching funds.',
    `currency` STRING COMMENT 'The three-letter ISO 4217 currency code in which the award amount is denominated.. Valid values are `^[A-Z]{3}$`',
    `dac_sector_code` STRING COMMENT 'The OECD DAC 5-digit sector code classifying the purpose of the award.',
    `donor_reference_number` STRING COMMENT 'The donors internal reference or tracking number for this award, distinct from the award number.',
    `end_date` DATE COMMENT 'The official end date of the award period of performance, including any approved extensions.',
    `exchange_rate_to_functional` DECIMAL(18,2) COMMENT 'The exchange rate used to convert the award currency to the NGOs functional currency for accounting purposes.',
    `functional_currency` STRING COMMENT 'The three-letter ISO 4217 currency code of the NGOs functional currency for financial reporting.. Valid values are `^[A-Z]{3}$`',
    `geographic_scope` STRING COMMENT 'The geographic area or countries covered by this award (e.g., single country, regional, global).',
    `indirect_cost_ceiling` DECIMAL(18,2) COMMENT 'The maximum indirect cost rate allowed by the donor for this award, expressed as a decimal.',
    `last_amendment_date` DATE COMMENT 'The date of the most recent amendment or modification to the award agreement.',
    `nicra_icr_rate` DECIMAL(18,2) COMMENT 'The negotiated indirect cost rate applicable to this award, expressed as a decimal (e.g., 0.1500 for 15%).',
    `notes` STRING COMMENT 'Free-text field for additional notes, comments, or context about the award.',
    `notification_date` DATE COMMENT 'The date on which the NGO received official notification of the award from the donor.',
    `number` STRING COMMENT 'The externally-known unique award number assigned by the donor or funding agency. This is the official reference number used in all donor communications and reporting.',
    `original_end_date` DATE COMMENT 'The original end date specified in the initial award agreement, before any no-cost extensions or amendments.',
    `payment_method` STRING COMMENT 'The payment method specified in the award: advance, reimbursement, milestone-based, or hybrid.. Valid values are `advance|reimbursement|milestone|hybrid`',
    `period_of_performance_months` STRING COMMENT 'The total duration of the award period of performance expressed in months.',
    `regulatory_framework` STRING COMMENT 'The applicable regulatory framework governing this award (e.g., 2 CFR 200, USAID ADS, DFID Smart Rules, UN Financial Regulations).',
    `reporting_frequency` STRING COMMENT 'The frequency at which financial and programmatic reports must be submitted to the donor.. Valid values are `monthly|quarterly|semi_annual|annual|final_only`',
    `sdg_alignment` STRING COMMENT 'The primary UN Sustainable Development Goal(s) that this award contributes to.',
    `special_conditions` STRING COMMENT 'Any special conditions, restrictions, or requirements imposed by the donor on this award.',
    `start_date` DATE COMMENT 'The official start date of the award period of performance as specified in the award agreement.',
    `thematic_sector` STRING COMMENT 'The primary thematic sector or focus area of the award (e.g., WASH, health, education, protection, food security).',
    `title` STRING COMMENT 'The official title or name of the grant award as stated in the award agreement.',
    `total_obligated_amount` DECIMAL(18,2) COMMENT 'The total amount of funds obligated by the donor under this award in the award currency.',
    `total_obligated_amount_functional` DECIMAL(18,2) COMMENT 'The total obligated amount converted to the NGOs functional currency using the exchange rate.',
    CONSTRAINT pk_award PRIMARY KEY(`award_id`)
) COMMENT 'Master record for each grant award received by the NGO from institutional donors (USAID, BHA, DFID, CERF, UN agencies, foundations, corporates). Captures the full grant lifecycle from award notification through closeout. Stores award number, title, donor reference, award type (cooperative agreement, contract, grant, sub-award, consortium lead, consortium member), total obligated amount in award currency with exchange rate to functional currency, authorized amount, start and end dates, period of performance, award status (pipeline, active, no-cost extension, closed), funding mechanism, geographic scope, thematic sector, applicable regulatory framework (2 CFR 200, USAID ADS, DFID Smart Rules), NICRA/ICR rate reference, restricted vs. unrestricted classification, indirect cost ceiling, and program linkage allocations with funding percentages. SSOT for all grant award identity in the NGO.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`grant`.`proposal` (
    `proposal_id` BIGINT COMMENT 'Unique identifier for the grant proposal or concept note submission. Primary key for the proposal data product.',
    `award_id` BIGINT COMMENT 'Reference to the resulting grant award entity if this proposal was successful. Links the proposal to the executed grant agreement for lifecycle tracking.',
    `component_id` BIGINT COMMENT 'Reference to the program or thematic area this proposal supports. Links to the program master entity for strategic alignment tracking.',
    `constituent_id` BIGINT COMMENT 'Reference to the donor organization or funding body to whom this proposal is submitted. Links to the donor master entity.',
    `country_id` BIGINT COMMENT 'Foreign key linking to field.country. Business justification: Business development pipeline reporting and go/no-go decisions are tracked by country. Proposal win/loss analysis by country is a standard NGO BD reporting requirement. geographic_focus is descriptive',
    `country_office_id` BIGINT COMMENT 'Foreign key linking to field.country_office. Business justification: Proposals are prepared and submitted by country offices. Fundamental for tracking BD pipeline by geography, country-level win rates, proposal workload management, and resource allocation for proposal ',
    `emergency_id` BIGINT COMMENT 'Foreign key linking to field.emergency. Business justification: Emergency response proposals are a distinct NGO proposal type triggered by a declared emergency. Linking proposals to the emergency record enables flash appeal tracking, emergency funding pipeline ana',
    `fund_id` BIGINT COMMENT 'Foreign key linking to donor.donor_fund. Business justification: Proposals target specific donor funds (e.g., a foundations restricted fund). Business development teams must align proposals with fund restrictions and reporting requirements. NGO BD staff would expe',
    `funding_source_id` BIGINT COMMENT 'Foreign key linking to grant.funding_source. Business justification: A grant proposal is submitted in response to a specific funding mechanism or solicitation from a funding source (e.g., a USAID Notice of Funding Opportunity, BHA RFA). The funding_source product captu',
    `intervention_id` BIGINT COMMENT 'Foreign key linking to program.intervention. Business justification: Proposals that win awards result in specific interventions. Essential for business development learning, proposal effectiveness tracking, and win/loss analysis. Tracks which proposal led to which impl',
    `partner_org_id` BIGINT COMMENT 'Foreign key linking to partnership.partner_org. Business justification: NGO proposals are developed with a designated lead implementing partner, especially for consortium bids. Business development teams track proposal pipeline by partner. consortium_lead_organization is ',
    `mel_logframe_id` BIGINT COMMENT 'Foreign key linking to mel.mel_logframe. Business justification: Proposals reference donor-mandated logframes during design phase. Proposal writers must align technical approach with donors results framework and indicator requirements specified in RFP logframe tem',
    `award_notification_date` DATE COMMENT 'Date the organization was officially notified of the award decision by the donor. Null if proposal was not awarded or decision is still pending.',
    `business_development_owner` STRING COMMENT 'Name or identifier of the business development staff member responsible for managing this proposal opportunity and donor relationship.',
    `compliance_review_completed` BOOLEAN COMMENT 'Boolean flag indicating whether compliance and risk review was completed before submission. Ensures adherence to donor regulations and organizational policies.',
    `cost_proposal_summary` STRING COMMENT 'Summary of the cost proposal structure, including major budget categories, cost-sharing arrangements, and indirect cost rate applied. Provides financial overview without detailed line items.',
    `cost_share_amount` DECIMAL(18,2) COMMENT 'Total cost-sharing or matching contribution committed by the organization or partners, expressed in the proposal currency. Represents non-donor funding sources.',
    `cost_share_percentage` DECIMAL(18,2) COMMENT 'Cost-sharing contribution as a percentage of the total project budget. Calculated as cost share amount divided by total project cost.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this proposal record was first created in the system. Audit trail for record creation.',
    `document_reference` STRING COMMENT 'File path, document management system reference, or URL to the submitted proposal document package. Enables retrieval of the full proposal for audit and reference.',
    `geographic_focus` STRING COMMENT 'Primary country or region where the proposed intervention will be implemented. May include multiple countries for regional proposals.',
    `go_no_go_decision` STRING COMMENT 'Internal decision on whether to pursue this funding opportunity. Tracks strategic alignment, capacity assessment, and risk evaluation outcomes.. Valid values are `go|no_go|pending`',
    `go_no_go_decision_date` DATE COMMENT 'Date the internal go/no-go decision was made regarding pursuit of this funding opportunity.',
    `indirect_cost_rate_proposed` DECIMAL(18,2) COMMENT 'Indirect cost rate (ICR) or facilities and administration (F&A) rate proposed in the budget, expressed as a percentage. May reference the organizations NICRA (Negotiated Indirect Cost Rate Agreement).',
    `internal_review_date` DATE COMMENT 'Date the proposal completed internal review and was approved for submission by organizational leadership or review committee.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this proposal record was last updated. Audit trail for record modification tracking.',
    `lead_proposal_writer` STRING COMMENT 'Name or identifier of the staff member who served as the lead technical writer for this proposal. Used for workload tracking and expertise mapping.',
    `lead_technical_sector` STRING COMMENT 'Primary technical sector or thematic area for the proposed intervention (e.g., WASH, Health, Education, Protection, Livelihoods, GBV, Nutrition). Aligns with DAC sector codes and organizational program taxonomy.',
    `notes` STRING COMMENT 'Free-text field for additional notes, comments, or context about the proposal submission, donor feedback, or internal lessons learned.',
    `partnership_model` STRING COMMENT 'Organizational role and partnership structure for this proposal. Indicates whether the organization is applying as prime recipient, sub-awardee, consortium member, joint venture partner, or solo applicant.. Valid values are `prime|sub_award|consortium|joint_venture|solo`',
    `proposal_status` STRING COMMENT 'Current lifecycle status of the proposal. Tracks progression from draft through internal review, submission, donor review, shortlisting, and final outcome (awarded, rejected, or withdrawn). [ENUM-REF-CANDIDATE: draft|internal_review|submitted|under_review|shortlisted|awarded|rejected|withdrawn — 8 candidates stripped; promote to reference product]',
    `proposal_type` STRING COMMENT 'Classification of the proposal submission format and stage. Indicates whether this is a full application, concept note, expression of interest, unsolicited submission, pre-proposal, or letter of inquiry.. Valid values are `full_application|concept_note|expression_of_interest|unsolicited|pre_proposal|letter_of_inquiry`',
    `proposed_duration_months` STRING COMMENT 'Total duration of the proposed project period of performance expressed in months. Calculated from proposed start and end dates.',
    `proposed_end_date` DATE COMMENT 'Proposed end date for the period of performance if the grant is awarded. Marks the conclusion of the planned implementation timeline.',
    `proposed_start_date` DATE COMMENT 'Proposed start date for the period of performance if the grant is awarded. Marks the beginning of the planned implementation timeline.',
    `reference_number` STRING COMMENT 'Externally-known unique reference number or code assigned to this proposal for tracking and communication with the donor. May include organizational prefix and year.',
    `rejection_reason` STRING COMMENT 'Primary reason provided by the donor for proposal rejection, or internal assessment of why the proposal was not successful. Used for lessons learned and win-rate improvement analysis.',
    `requested_amount` DECIMAL(18,2) COMMENT 'Total funding amount requested from the donor in the proposal currency. Represents the gross budget request before any donor adjustments or negotiations.',
    `requested_amount_usd` DECIMAL(18,2) COMMENT 'Total funding amount requested converted to USD using the exchange rate at submission date. Enables cross-proposal comparison and pipeline analysis in a common currency.',
    `requested_currency` STRING COMMENT 'Three-letter ISO 4217 currency code for the requested funding amount (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `submission_date` DATE COMMENT 'Date the proposal was officially submitted to the donor or funding body. Represents the principal business event timestamp for this transaction.',
    `target_beneficiary_count` STRING COMMENT 'Estimated number of direct beneficiaries the proposed project aims to reach. Used for cost-per-beneficiary analysis and impact projections.',
    `technical_approach_summary` STRING COMMENT 'High-level summary of the proposed technical approach, methodology, and intervention strategy. Captures key elements of the Theory of Change (ToC) and implementation plan.',
    `title` STRING COMMENT 'Full title of the grant proposal or concept note as submitted to the donor. Describes the proposed intervention or project.',
    `win_loss_outcome` STRING COMMENT 'Final outcome of the proposal submission. Indicates whether the proposal was won (awarded), lost (rejected), is still pending donor decision, or was withdrawn by the organization.. Valid values are `won|lost|pending|withdrawn`',
    CONSTRAINT pk_proposal PRIMARY KEY(`proposal_id`)
) COMMENT 'Tracks each grant proposal or concept note submitted to a donor or funding body in response to a solicitation or as an unsolicited submission. Captures proposal title, submission date, donor solicitation reference (RFA, RFP, NOFO number), proposal type (full application, concept note, expression of interest, unsolicited), requested amount and currency, proposed period of performance, lead technical sector, proposal status (draft, internal review, submitted, under review, shortlisted, awarded, rejected, withdrawn), win/loss outcome, cost proposal summary, technical approach summary, and linkage to the resulting award if successful. Supports pipeline management, go/no-go decision tracking, win-rate analysis, and strategic business development. Each proposal references the solicitation it responds to (except unsolicited proposals).';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`grant`.`award_budget` (
    `award_budget_id` BIGINT COMMENT 'Unique identifier for the award budget record. Primary key.',
    `amendment_id` BIGINT COMMENT 'Foreign key linking to grant.grant_amendment. Business justification: Budget revisions are often triggered by grant amendments. award_budget has is_amendment flag, amendment_date, and amendment_reason, but no FK to the actual amendment record. Adding amendment_id links ',
    `award_id` BIGINT COMMENT 'Reference to the parent grant award for which this budget is defined.',
    `approved_by` STRING COMMENT 'Name or identifier of the internal authority (e.g., Finance Director, Executive Director) who approved this budget for submission to the donor.',
    `award_budget_status` STRING COMMENT 'Current lifecycle status of the budget. Draft indicates internal preparation; Submitted indicates sent to donor; Under Review indicates donor is reviewing; Approved indicates donor has approved; Amended indicates a revision has been made; Superseded indicates replaced by a newer version; Closed indicates budget period has ended. [ENUM-REF-CANDIDATE: draft|submitted|under_review|approved|amended|superseded|closed — 7 candidates stripped; promote to reference product]',
    `award_currency` STRING COMMENT 'Three-letter ISO 4217 currency code in which the budget is denominated (e.g., USD, EUR, GBP). This is the donor-facing currency.. Valid values are `^[A-Z]{3}$`',
    `contractual_costs` DECIMAL(18,2) COMMENT 'Approved budget for sub-awards to implementing partners and consultant fees.',
    `cost_share_amount` DECIMAL(18,2) COMMENT 'The total cost share (matching funds) amount committed by the organization for this budget period, if cost sharing is required.',
    `cost_share_required` BOOLEAN COMMENT 'Indicates whether the donor requires cost sharing (matching funds) for this budget period.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this budget record was first created in the system.',
    `donor_approval_date` DATE COMMENT 'The date the donor officially approved this budget version.',
    `donor_approval_reference` STRING COMMENT 'Reference number or document identifier for the donors formal approval of this budget (e.g., award letter number, amendment approval letter).',
    `equipment_costs` DECIMAL(18,2) COMMENT 'Approved budget for equipment purchases (typically items with acquisition cost of $5,000 or more and useful life of more than one year, per donor definition).',
    `fringe_benefits_costs` DECIMAL(18,2) COMMENT 'Approved budget for fringe benefits associated with personnel costs (health insurance, retirement, payroll taxes, etc.).',
    `fund_restriction_type` STRING COMMENT 'Classification of the funds according to donor restrictions. Unrestricted funds have no donor-imposed restrictions; Temporarily Restricted funds have purpose or time restrictions; Permanently Restricted funds must be maintained in perpetuity.. Valid values are `unrestricted|temporarily_restricted|permanently_restricted`',
    `indirect_cost_base` STRING COMMENT 'The cost base to which the NICRA rate is applied. Common bases include Modified Total Direct Costs (MTDC), Total Direct Costs, or Salaries and Wages.. Valid values are `modified_total_direct_costs|total_direct_costs|salaries_and_wages|other`',
    `is_amendment` BOOLEAN COMMENT 'Flag indicating whether this budget version is an amendment to a previously approved budget (True) or the original budget (False).',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this budget record was last updated in the system.',
    `narrative_reference` STRING COMMENT 'Reference identifier or document location for the detailed budget narrative that explains and justifies each budget line item. Typically a document management system reference.',
    `nicra_rate_applied` DECIMAL(18,2) COMMENT 'The indirect cost rate (expressed as a percentage) applied to calculate F&A costs. This is the rate from the organizations NICRA with the cognizant federal agency.',
    `notes` STRING COMMENT 'Free-text field for additional notes, clarifications, or special conditions related to this budget version.',
    `period` STRING COMMENT 'The budget period this budget covers, typically expressed as Year 1, Year 2, etc., or Period 1, Period 2, etc., or Full Award Period for multi-year consolidated budgets.. Valid values are `^(Year [1-9]|Year [1-9][0-9]|Period [1-9]|Period [1-9][0-9]|Full Award Period)$`',
    `period_end_date` DATE COMMENT 'The end date of the budget period covered by this budget.',
    `period_start_date` DATE COMMENT 'The start date of the budget period covered by this budget.',
    `personnel_costs` DECIMAL(18,2) COMMENT 'Approved budget for salaries and wages of staff directly working on the grant.',
    `prepared_by` STRING COMMENT 'Name or identifier of the staff member who prepared this budget version.',
    `submission_date` DATE COMMENT 'The date this budget version was submitted to the donor for review and approval.',
    `supplies_costs` DECIMAL(18,2) COMMENT 'Approved budget for supplies and consumables used in grant activities (items below equipment threshold).',
    `total_approved_budget` DECIMAL(18,2) COMMENT 'The total approved budget amount for this budget period in the award currency. Sum of all direct and indirect costs.',
    `total_direct_costs` DECIMAL(18,2) COMMENT 'Sum of all direct cost categories (personnel, fringe, travel, equipment, supplies, contractual, other direct costs) approved for this budget period.',
    `total_indirect_costs` DECIMAL(18,2) COMMENT 'Total indirect costs (Facilities and Administration / F&A) approved for this budget period. Calculated by applying the NICRA rate to the approved direct cost base.',
    `travel_costs` DECIMAL(18,2) COMMENT 'Approved budget for domestic and international travel expenses directly related to grant activities.',
    `version_number` STRING COMMENT 'Sequential version number of the budget. Increments with each amendment or revision. Version 1 is the original approved budget.',
    CONSTRAINT pk_award_budget PRIMARY KEY(`award_budget_id`)
) COMMENT 'Defines the approved budget structure for a grant award as negotiated with the donor. Stores budget version number, budget period (Year 1, Year 2, etc.), total approved budget in award currency, direct cost ceiling, indirect cost (F&A) ceiling, NICRA rate applied, cost category breakdown (personnel, fringe, travel, equipment, supplies, contractual, other direct costs, indirect), donor-approved budget narrative reference, and budget amendment history flag. Enables BvA (Budget vs. Actual) tracking and donor financial reporting. Distinct from the finance domains general ledger — this is the donor-facing approved budget in the awards denomination currency, not the internal GL in functional currency.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`grant`.`award_budget_line` (
    `award_budget_line_id` BIGINT COMMENT 'Unique identifier for the award budget line item. Primary key for this entity.',
    `award_budget_id` BIGINT COMMENT 'Reference to the budget period (fiscal year or project phase) to which this line item applies.',
    `award_id` BIGINT COMMENT 'Reference to the parent grant award under which this budget line is authorized.',
    `component_id` BIGINT COMMENT 'Reference to the program or project that this budget line supports, enabling program-level budget tracking and reporting.',
    `fund_id` BIGINT COMMENT 'Foreign key linking to donor.donor_fund. Business justification: Budget lines must be allocated against specific restricted donor funds for NGO fund accounting and restriction compliance. Finance teams track which donor fund each budget line draws from to produce f',
    `indicator_id` BIGINT COMMENT 'Foreign key linking to mel.indicator. Business justification: Budget lines allocate resources to indicator data collection activities. MEL budget lines (surveys, assessments, evaluations) are directly tied to specific indicators they measure, enabling cost-per-i',
    `intervention_id` BIGINT COMMENT 'Foreign key linking to program.intervention. Business justification: Award budget lines must map to specific program interventions for cost allocation, financial reporting, and budget vs. actual analysis. Essential for donor financial reports requiring intervention-lev',
    `project_site_id` BIGINT COMMENT 'Foreign key linking to field.project_site. Business justification: Award budget line items must link to finance budget lines for detailed expenditure tracking, budget-to-actual variance reporting, and grant financial statement preparation. Nonprofits track grant budg',
    `allocability_flag` BOOLEAN COMMENT 'Indicates whether costs charged to this budget line are allocable to the grant award in accordance with relative benefits received, per OMB Uniform Guidance 2 CFR 200.405.',
    `allowability_flag` BOOLEAN COMMENT 'Indicates whether this budget line item is allowable under applicable donor regulations (OMB Uniform Guidance 2 CFR 200 Subpart E, USAID ADS). True if allowable; False if unallowable or requires special approval.',
    `approval_date` DATE COMMENT 'Date on which this budget line was approved by the donor or authorized signatory as part of the award agreement or amendment.',
    `approved_amount` DECIMAL(18,2) COMMENT 'Original approved budget amount for this line item as authorized in the initial grant award agreement.',
    `approved_amount_usd` DECIMAL(18,2) COMMENT 'Approved budget amount converted to United States Dollars for standardized reporting and analysis.',
    `budget_line_status` STRING COMMENT 'Current lifecycle status of the budget line item within the award budget structure.. Valid values are `active|suspended|closed|amended`',
    `cost_category` STRING COMMENT 'Primary classification of the budget line according to standard cost categories defined by OMB Uniform Guidance 2 CFR 200 Subpart E and donor regulations. [ENUM-REF-CANDIDATE: personnel|fringe_benefits|travel|equipment|supplies|contractual|other_direct_costs|indirect_costs|subaward — 9 candidates stripped; promote to reference product]',
    `cost_share_amount` DECIMAL(18,2) COMMENT 'Amount of cost sharing or matching contribution committed for this budget line. Null if no cost share is required.',
    `cost_share_required_flag` BOOLEAN COMMENT 'Indicates whether this budget line requires cost sharing or matching funds from the organization or other non-federal sources, per donor agreement terms.',
    `cost_subcategory` STRING COMMENT 'Secondary classification providing granular detail within the cost category (e.g., international travel, local travel, office supplies, medical supplies).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this budget line record was first created in the system.',
    `cumulative_expenditure` DECIMAL(18,2) COMMENT 'Total actual expenditure incurred against this budget line from award inception through the current reporting period.',
    `cumulative_expenditure_usd` DECIMAL(18,2) COMMENT 'Cumulative expenditure converted to United States Dollars for standardized variance analysis and donor reporting.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the budget line amounts (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `award_budget_line_description` STRING COMMENT 'Detailed narrative description of the budget line item, explaining the purpose, scope, and justification for the budgeted expenditure.',
    `donor_reporting_category` STRING COMMENT 'Donor-specific classification or reporting code required for financial reports submitted to the funding agency (e.g., BHA, USAID, DFID, CERF).',
    `exchange_rate` DECIMAL(18,2) COMMENT 'Exchange rate applied to convert local currency amounts to USD for donor reporting, if applicable. Null for USD-denominated budgets.',
    `fiscal_period` STRING COMMENT 'Fiscal period (month, quarter, or custom period) within the fiscal year to which this budget line applies.',
    `fiscal_year` STRING COMMENT 'Fiscal year to which this budget line applies, aligned with the organizations or donors fiscal calendar.',
    `fund_restriction_type` STRING COMMENT 'Classification of donor-imposed restrictions on the use of funds for this budget line, per FASB ASC 958 (Not-for-Profit Entities).. Valid values are `unrestricted|temporarily_restricted|permanently_restricted`',
    `gl_account_code` STRING COMMENT 'General ledger account code in the organizations chart of accounts (CoA) to which expenditures for this budget line are posted.',
    `indirect_cost_amount` DECIMAL(18,2) COMMENT 'Calculated indirect cost (facilities and administration) amount allocated to this budget line based on the applied NICRA rate.',
    `item_code` STRING COMMENT 'Unique alphanumeric code identifying this budget line within the award budget structure, often aligned with donor or organizational chart of accounts.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this budget line record was last modified in the system.',
    `nicra_rate_applied` DECIMAL(18,2) COMMENT 'Indirect cost rate (ICR) applied to this budget line, as specified in the organizations NICRA or the de minimis rate under 2 CFR 200.414. Expressed as a decimal (e.g., 0.10 for 10%).',
    `notes` STRING COMMENT 'Additional notes, comments, or clarifications related to this budget line item for internal tracking and audit purposes.',
    `quantity` DECIMAL(18,2) COMMENT 'Planned quantity of the unit of measure for this budget line (e.g., 12 person-months, 500 units). Null for non-quantifiable line items.',
    `reasonableness_flag` BOOLEAN COMMENT 'Indicates whether the budgeted amount is reasonable and does not exceed what a prudent person would incur under similar circumstances, per OMB Uniform Guidance 2 CFR 200.404.',
    `revised_amount` DECIMAL(18,2) COMMENT 'Current authorized budget amount for this line item after any approved amendments, budget reallocations, or modifications. Null if no revisions have occurred.',
    `revised_amount_usd` DECIMAL(18,2) COMMENT 'Revised budget amount converted to United States Dollars. Null if no revisions have occurred.',
    `revision_date` DATE COMMENT 'Date of the most recent budget revision or amendment affecting this line item. Null if no revisions have occurred.',
    `revision_reason` STRING COMMENT 'Narrative explanation for the most recent budget revision, including justification and donor approval reference.',
    `supporting_document_reference` STRING COMMENT 'Reference identifier or file path to supporting documentation for this budget line (e.g., quotes, justifications, donor correspondence).',
    `unit_cost` DECIMAL(18,2) COMMENT 'Cost per unit of measure for this budget line. Null for non-quantifiable line items.',
    `unit_of_measure` STRING COMMENT 'Unit of measure for quantifiable budget line items (e.g., person-months, units, trips, days), if applicable.',
    `variance_amount` DECIMAL(18,2) COMMENT 'Difference between the current authorized budget (revised or approved) and cumulative expenditure. Positive indicates under-spend; negative indicates over-spend.',
    `variance_percentage` DECIMAL(18,2) COMMENT 'Variance expressed as a percentage of the current authorized budget, used for burn-rate monitoring and budget-versus-actual (BvA) analysis.',
    CONSTRAINT pk_award_budget_line PRIMARY KEY(`award_budget_line_id`)
) COMMENT 'Granular line-item breakdown of an approved award budget. Each record represents a single budget line within a cost category and budget period, capturing line item code, cost category (personnel, fringe, travel, equipment, supplies, contractual, ODC, indirect), budget line description, approved amount, revised amount (post-amendment), cumulative expenditure to date, variance, and allowability flag under applicable donor regulations (2 CFR 200 Subpart E, USAID ADS). Enables detailed BvA analysis, burn-rate monitoring, and donor financial report preparation at the line-item level.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`grant`.`amendment` (
    `amendment_id` BIGINT COMMENT 'Unique identifier for the grant amendment record. Primary key for the grant_amendment data product.',
    `agreement_id` BIGINT COMMENT 'Foreign key linking to partnership.partnership_agreement. Business justification: Prime award amendments trigger corresponding partnership agreement amendments for flow-down compliance. Grant managers must track which partnership agreements are affected by each amendment to ensure ',
    `award_id` BIGINT COMMENT 'Reference to the parent grant award that this amendment modifies. Links to the original grant agreement.',
    `country_office_id` BIGINT COMMENT 'Foreign key linking to field.country_office. Business justification: Grant amendments involving geographic scope changes, key personnel changes, or budget modifications must be approved and tracked by the responsible country office. Country office amendment registers a',
    `indicator_target_id` BIGINT COMMENT 'Foreign key linking to mel.indicator_target. Business justification: Amendments adjust indicator targets when period of performance, budget, or scope changes. Target revisions require donor prior approval, and amendment documents must specify which indicator targets ar',
    `mel_logframe_id` BIGINT COMMENT 'Foreign key linking to mel.mel_logframe. Business justification: Amendments revise logframes when scope, geography, or results chain changes. Formal amendments update intervention logic, assumptions, and indicator hierarchies in donor-approved logframe, requiring v',
    `supersedes_amendment_grant_amendment_id` BIGINT COMMENT 'Reference to a previous amendment that this amendment supersedes or replaces. Used to track amendment version history.',
    `approval_date` DATE COMMENT 'Date when the donor or funding agency officially approved the amendment request.',
    `approved_by_name` STRING COMMENT 'Name of the donor agency official or grants officer who approved this amendment.',
    `approved_by_title` STRING COMMENT 'Title or position of the donor agency official who approved this amendment (e.g., Grants Officer, Agreement Officer, Program Officer).',
    `budget_modification_summary` STRING COMMENT 'Summary of budget line item changes resulting from this amendment. Describes reallocations, increases, or decreases across cost categories.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this amendment record was first created in the system. Audit trail field for data lineage.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts in this amendment (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `donor_approval_reference` STRING COMMENT 'External reference number or document identifier provided by the donor agency confirming approval of the amendment (e.g., USAID approval memo number, BHA authorization code).',
    `donor_prior_approval_required` BOOLEAN COMMENT 'Indicates whether this amendment required formal prior approval from the donor agency before implementation, as mandated by OMB Uniform Guidance 2 CFR 200.308.',
    `effective_date` DATE COMMENT 'Date from which the amendment terms become effective. May differ from execution date if the amendment is retroactive or has a future effective date.',
    `execution_date` DATE COMMENT 'Date when the amendment was fully executed and became legally binding. This is the principal business event timestamp for the amendment.',
    `funding_change` DECIMAL(18,2) COMMENT 'Net change in funding resulting from this amendment. Positive values indicate funding increases, negative values indicate decreases. Zero for non-financial amendments.',
    `geographic_change_description` STRING COMMENT 'Description of any changes to the geographic coverage or implementation locations resulting from this amendment (e.g., expansion to new regions, closure of field sites).',
    `grant_amendment_description` STRING COMMENT 'Detailed narrative description of the changes introduced by this amendment. Explains the rationale, scope, and impact of the modification.',
    `grant_amendment_status` STRING COMMENT 'Current lifecycle status of the amendment. Tracks the amendment from initial drafting through donor approval and execution. [ENUM-REF-CANDIDATE: draft|submitted|under_review|approved|executed|rejected|withdrawn|superseded — 8 candidates stripped; promote to reference product]',
    `grant_amendment_type` STRING COMMENT 'Classification of the amendment based on the nature of the modification. Indicates whether the amendment extends the period, modifies the budget, changes scope, updates key personnel, expands geographic coverage, or adjusts other terms. [ENUM-REF-CANDIDATE: no_cost_extension|budget_modification|scope_change|key_personnel_change|geographic_expansion|period_of_performance_change|funding_increase|funding_decrease|administrative_correction|terms_and_conditions_change — 10 candidates stripped; promote to reference product]',
    `internal_approval_date` DATE COMMENT 'Date when the amendment request was approved internally by the nonprofit organization before submission to the donor.',
    `internal_approver_name` STRING COMMENT 'Name of the internal organizational authority who approved the amendment request (e.g., Executive Director, Chief Grants Officer).',
    `is_no_cost_extension` BOOLEAN COMMENT 'Indicates whether this amendment is a no-cost extension, extending the period of performance without additional funding.',
    `justification` STRING COMMENT 'Business and programmatic justification for requesting the amendment. Explains why the modification is necessary and how it aligns with program objectives.',
    `key_personnel_change_description` STRING COMMENT 'Description of any changes to key personnel roles, including additions, removals, or role modifications. Key personnel typically include Principal Investigator, Project Director, and other critical leadership positions.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this amendment record was last updated in the system. Audit trail field for data lineage.',
    `notes` STRING COMMENT 'Additional notes, comments, or contextual information related to the amendment. Used for internal tracking and audit purposes.',
    `number` STRING COMMENT 'Sequential or hierarchical identifier for this amendment within the grant lifecycle (e.g., Amendment 001, A-1, Mod 3). Serves as the business identifier for the amendment.',
    `original_end_date` DATE COMMENT 'Original end date of the grant period of performance before this amendment.',
    `original_start_date` DATE COMMENT 'Original start date of the grant period of performance before this amendment.',
    `original_total_obligation` DECIMAL(18,2) COMMENT 'Total obligated funding amount before this amendment. Provides baseline for calculating the impact of funding changes.',
    `period_extension_days` STRING COMMENT 'Number of calendar days by which the period of performance is extended by this amendment. Calculated as the difference between revised and original end dates.',
    `request_date` DATE COMMENT 'Date when the amendment request was formally submitted to the donor or funding agency for review and approval.',
    `revised_end_date` DATE COMMENT 'Revised end date of the grant period of performance after this amendment. Commonly modified in no-cost extension amendments.',
    `revised_start_date` DATE COMMENT 'Revised start date of the grant period of performance after this amendment. Typically unchanged unless the amendment is retroactive.',
    `revised_total_obligation` DECIMAL(18,2) COMMENT 'Total obligated funding amount after applying this amendment. Equals original total obligation plus amendment funding change.',
    `scope_change_description` STRING COMMENT 'Detailed description of any changes to the programmatic scope, objectives, deliverables, or activities resulting from this amendment.',
    `supporting_document_reference` STRING COMMENT 'Reference identifier or file path to supporting documentation for the amendment (e.g., revised budget, updated work plan, donor correspondence).',
    `terms_and_conditions_change` STRING COMMENT 'Description of any modifications to the legal terms, conditions, reporting requirements, or compliance obligations under the grant agreement.',
    CONSTRAINT pk_amendment PRIMARY KEY(`amendment_id`)
) COMMENT 'Records all formal modifications to a grant award after initial execution. Captures amendment number, amendment type (no-cost extension, budget modification, scope change, key personnel change, geographic expansion, period of performance change), amendment date, donor approval reference, description of changes, revised total obligation, revised end date, and amendment status (pending, approved, executed). Tracks the full amendment history for compliance and audit purposes under OMB Uniform Guidance 2 CFR 200 and USAID ADS.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`grant`.`subaward` (
    `subaward_id` BIGINT COMMENT 'Unique identifier for the subaward record. Primary key.',
    `agreement_id` BIGINT COMMENT 'Foreign key linking to partnership.partnership_agreement. Business justification: Subawards operationalize partnership agreements. Compliance teams must trace subaward flow-down requirements, audit obligations, and closeout back to the governing partnership agreement. This is a sta',
    `award_id` BIGINT COMMENT 'Reference to the prime grant award under which this subaward is issued. Links to the parent grant that provides the funding source.',
    `capacity_assessment_id` BIGINT COMMENT 'Foreign key linking to partnership.capacity_assessment. Business justification: USAID, EU, and UN frameworks require subaward approval to be backed by a current capacity assessment. The subaward risk_rating and monitoring_frequency are directly determined by the capacity assessme',
    `due_diligence_record_id` BIGINT COMMENT 'Foreign key linking to partnership.due_diligence_record. Business justification: Donor compliance frameworks (USAID 2 CFR 200, EU PRAG) require subawards to be backed by a completed due diligence clearance. Compliance officers and auditors must link each subaward to its authorizin',
    `intervention_id` BIGINT COMMENT 'Reference to the program under which this subaward is executed. Links the subaward to the programmatic context and objectives.',
    `partner_org_id` BIGINT COMMENT 'Reference to the implementing partner organization (CBO, local NGO, contractor) receiving the subaward. The subrecipient entity.',
    `project_site_id` BIGINT COMMENT 'Foreign key linking to field.project_site. Business justification: Subawards to local partners are frequently tied to specific geographic sites where the partner implements activities. Critical for consortium management, site-level budget tracking, and partner perfor',
    `amendment_count` STRING COMMENT 'The total number of amendments or modifications issued to this subaward. Tracks the change history of the subaward.',
    `approval_date` DATE COMMENT 'The date when the subaward was approved by the authorized approving authority within the NGO.',
    `approved_by` STRING COMMENT 'Name or identifier of the individual who approved the subaward on behalf of the NGO.',
    `closeout_date` DATE COMMENT 'The date when the subaward was officially closed out after all deliverables, reports, and financial reconciliations were completed.',
    `cost_share_amount` DECIMAL(18,2) COMMENT 'The required cost share or matching contribution amount from the implementing partner, if applicable.',
    `cost_share_required_flag` BOOLEAN COMMENT 'Indicates whether the implementing partner is required to provide cost share or matching funds as a condition of the subaward.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this subaward record was first created in the system. Audit trail for record creation.',
    `currency` STRING COMMENT 'Three-letter ISO 4217 currency code for the subaward amount. Defines the currency in which the subaward is denominated.. Valid values are `^[A-Z]{3}$`',
    `subaward_description` STRING COMMENT 'Detailed narrative description of the subaward scope, objectives, deliverables, and expected outcomes.',
    `disbursed_amount` DECIMAL(18,2) COMMENT 'The cumulative amount disbursed to the implementing partner to date. Tracks actual cash transferred against the obligated amount.',
    `duns_number` STRING COMMENT 'The nine-digit DUNS number of the implementing partner organization. Required for FFATA reporting and federal subawards.. Valid values are `^[0-9]{9}$`',
    `execution_date` DATE COMMENT 'The date when the subaward agreement was signed and executed by both parties. Represents the legal effective date of the subaward.',
    `ffata_reporting_required_flag` BOOLEAN COMMENT 'Indicates whether this subaward is subject to FFATA reporting requirements (typically subawards of $30,000 or more from federal sources).',
    `flow_down_requirements` STRING COMMENT 'Narrative description of the prime award terms and conditions that must be flowed down to the subrecipient, including compliance obligations, reporting requirements, and audit provisions.',
    `fsrs_report_date` DATE COMMENT 'The date when the subaward was reported to the FFATA Subaward Reporting System (FSRS), if applicable.',
    `fund_restriction_type` STRING COMMENT 'Classification of the funding restriction level per ASC 958 nonprofit accounting standards. Indicates donor-imposed restrictions on the use of funds.. Valid values are `unrestricted|temporarily restricted|permanently restricted`',
    `indirect_cost_base` STRING COMMENT 'The cost base to which the indirect cost rate is applied (e.g., Modified Total Direct Costs, Total Direct Costs, Salaries and Wages).. Valid values are `modified total direct costs|total direct costs|salaries and wages|other`',
    `indirect_cost_rate` DECIMAL(18,2) COMMENT 'The approved indirect cost rate (ICR) or Negotiated Indirect Cost Rate Agreement (NICRA) rate applicable to the implementing partner for this subaward, expressed as a percentage.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this subaward record was last modified in the system. Audit trail for record updates.',
    `monitoring_frequency` STRING COMMENT 'The required frequency of monitoring activities for this subaward, based on risk rating and donor requirements.. Valid values are `quarterly|semi-annually|annually|as-needed|continuous`',
    `notes` STRING COMMENT 'Additional notes, comments, or special instructions related to the subaward. Free-text field for capturing contextual information.',
    `number` STRING COMMENT 'The externally-known unique business identifier for this subaward. Used in all legal documents, reporting, and correspondence.',
    `obligated_amount` DECIMAL(18,2) COMMENT 'The current total obligated amount under the subaward, including any amendments. May differ from the original total subaward amount due to modifications.',
    `payment_method` STRING COMMENT 'The method by which payments are made to the implementing partner under this subaward.. Valid values are `wire transfer|check|electronic funds transfer|advance|reimbursement|other`',
    `payment_schedule` STRING COMMENT 'The schedule or basis on which payments are made to the implementing partner (e.g., advance, reimbursement, milestone-based).. Valid values are `advance|reimbursement|milestone-based|quarterly|monthly|other`',
    `period_of_performance_end_date` DATE COMMENT 'The date when the subaward period of performance ends. Defines the end of the implementing partners authorized work period.',
    `period_of_performance_start_date` DATE COMMENT 'The date when the subaward period of performance begins. Defines the start of the implementing partners authorized work period.',
    `remaining_balance` DECIMAL(18,2) COMMENT 'The remaining unspent balance of the subaward. Calculated as obligated amount minus disbursed amount.',
    `reporting_frequency` STRING COMMENT 'The required frequency of programmatic and financial reports from the implementing partner.. Valid values are `monthly|quarterly|semi-annually|annually|as-needed`',
    `risk_rating` STRING COMMENT 'The assessed risk level of the implementing partner for this subaward. Determines the level of monitoring and oversight required.. Valid values are `low|medium|high|critical`',
    `single_audit_required_flag` BOOLEAN COMMENT 'Indicates whether the implementing partner is required to undergo a Single Audit per 2 CFR 200 Subpart F based on federal expenditure thresholds.',
    `subaward_status` STRING COMMENT 'Current lifecycle status of the subaward. Tracks the subaward from initial draft through active performance to closeout.. Valid values are `draft|pending approval|active|suspended|terminated|closed`',
    `subaward_type` STRING COMMENT 'Classification of the subaward instrument type. Determines the legal and compliance framework applicable to the subaward.. Valid values are `sub-grant|subcontract|fixed-obligation grant|cooperative agreement|cost-reimbursable|other`',
    `termination_date` DATE COMMENT 'The date when the subaward was terminated, if applicable. Used when the subaward is ended prior to the planned end date.',
    `termination_reason` STRING COMMENT 'Narrative explanation of the reason for subaward termination, if applicable. Documents the circumstances and justification for early termination.',
    `title` STRING COMMENT 'Descriptive title of the subaward that summarizes the scope of work or project purpose.',
    `total_subaward_amount` DECIMAL(18,2) COMMENT 'The total obligated amount of the subaward in the subaward currency. Represents the maximum financial obligation to the implementing partner.',
    `total_subaward_amount_usd` DECIMAL(18,2) COMMENT 'The total subaward amount converted to USD for consolidated reporting and analysis. Conversion uses the exchange rate at the time of subaward execution.',
    `uei_number` STRING COMMENT 'The twelve-character alphanumeric Unique Entity Identifier assigned to the implementing partner by SAM.gov. Replaces DUNS for federal reporting.. Valid values are `^[A-Z0-9]{12}$`',
    CONSTRAINT pk_subaward PRIMARY KEY(`subaward_id`)
) COMMENT 'Manages sub-awards issued by the NGO as prime recipient to implementing partners (CBOs, local NGOs, contractors). Captures subaward number, type (sub-grant, subcontract, fixed-obligation grant), implementing partner reference, subaward amount, period of performance, flow-down requirements from prime award, FFATA reporting obligation flag, subaward status (active, suspended, terminated, closed), risk rating, monitoring schedule, and pass-through entity compliance obligations under 2 CFR 200.331. Distinct from the partnership domains MoU/LoA — this is the financial and compliance instrument with legal obligation.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`grant`.`donor_condition` (
    `donor_condition_id` BIGINT COMMENT 'Unique identifier for the donor condition record. Primary key for the donor_condition data product.',
    `agreement_id` BIGINT COMMENT 'Foreign key linking to partnership.partnership_agreement. Business justification: Donor special award conditions flow down to partnership agreements. NGO compliance teams must track which partnership agreements are subject to specific donor conditions to ensure flow-down requiremen',
    `award_id` BIGINT COMMENT 'Reference to the grant award to which this donor condition is attached.',
    `constituent_id` BIGINT COMMENT 'Reference to the donor organization that imposed this condition.',
    `country_office_id` BIGINT COMMENT 'Foreign key linking to field.country_office. Business justification: Country office compliance dashboards track all special award conditions (SACs) and donor conditions by office for escalation management. responsible_department is a text field; a direct FK enables cou',
    `evaluation_id` BIGINT COMMENT 'Foreign key linking to mel.evaluation. Business justification: Donor conditions mandate specific evaluations (midterm, endline, impact). Conditions specify evaluation timing, methodology, evaluator qualifications, and deliverable requirements that drive evaluatio',
    `indicator_id` BIGINT COMMENT 'Foreign key linking to mel.indicator. Business justification: Donor special award conditions mandate tracking specific indicators. Conditions specify indicator achievement thresholds, reporting frequencies, and data quality standards that trigger compliance moni',
    `indicator_target_id` BIGINT COMMENT 'Foreign key linking to mel.indicator_target. Business justification: Donor conditions in results-based agreements specify that a particular indicator target must be achieved as a compliance requirement. Linking donor_condition to indicator_target enables compliance mon',
    `mel_logframe_id` BIGINT COMMENT 'Foreign key linking to mel.mel_logframe. Business justification: Donor special award conditions frequently require logframe revisions or reference specific logframe elements. Compliance officers must track which logframe a condition applies to. No existing FK cover',
    `actual_completion_date` DATE COMMENT 'The date on which the donor condition was actually met or the required action was completed. Null if the condition is not yet met.',
    `approval_authority` STRING COMMENT 'The entity or role that has the authority to approve or waive this condition (e.g., Donor Grants Officer, Chief Financial Officer, USAID Agreement Officer).',
    `approval_date` DATE COMMENT 'The date on which the required approval was granted by the approval authority. Null if approval is not yet obtained or not applicable.',
    `approval_reference_number` STRING COMMENT 'Reference number or identifier for the formal approval document or communication (e.g., approval letter number, email reference).',
    `donor_condition_category` STRING COMMENT 'Broader categorization of the condition by functional area. Values: financial (budget, cost, financial reporting), programmatic (deliverables, milestones, beneficiary targets), administrative (staffing, procurement, subcontracting), compliance (regulatory, legal, policy adherence), safeguarding (protection, GBV prevention, child safeguarding), environmental (environmental impact, WASH standards).. Valid values are `financial|programmatic|administrative|compliance|safeguarding|environmental`',
    `compliance_notes` STRING COMMENT 'Free-text field for internal notes, observations, or action items related to the management and fulfillment of this donor condition.',
    `compliance_status` STRING COMMENT 'Current lifecycle status of the donor condition. Values: open (condition active, not yet addressed), in_progress (work underway to meet condition), met (condition fully satisfied), waived (donor formally waived the condition), expired (condition no longer applicable due to grant closure or time lapse), overdue (condition past due date and not met).. Valid values are `open|in_progress|met|waived|expired|overdue`',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this donor condition record was first created in the system.',
    `deliverable_description` STRING COMMENT 'Detailed description of the specific deliverable, report, approval, or action required to satisfy this condition.',
    `donor_condition_description` STRING COMMENT 'Detailed narrative description of the donor condition, including specific requirements, deliverables, thresholds, and any contextual information provided by the donor.',
    `donor_condition_type` STRING COMMENT 'Classification of the donor condition indicating the nature of the compliance obligation. Values: prior_approval_requirement (donor must approve before action), restricted_cost (specific cost category restrictions), reporting_obligation (scheduled or ad-hoc reporting requirement), key_personnel_approval (approval required for key staff changes), branding_marking_requirement (logo, attribution, visibility requirements), audit_requirement (financial or programmatic audit mandate).. Valid values are `prior_approval_requirement|restricted_cost|reporting_obligation|key_personnel_approval|branding_marking_requirement|audit_requirement`',
    `donor_contact_email` STRING COMMENT 'Email address of the donor representative responsible for this condition.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `donor_contact_name` STRING COMMENT 'Name of the donor representative or grants officer who is the point of contact for questions or clarifications regarding this condition.',
    `due_date` DATE COMMENT 'The date by which the donor condition must be satisfied or the required action must be completed. Null if the condition has no specific deadline.',
    `escalation_threshold_days` STRING COMMENT 'Number of days before the due date when this condition should be escalated to senior management or flagged for urgent attention.',
    `financial_threshold_amount` DECIMAL(18,2) COMMENT 'Monetary threshold associated with this condition (e.g., prior approval required for subawards exceeding $100,000). Null if the condition does not have a financial threshold.',
    `financial_threshold_currency` STRING COMMENT 'Three-letter ISO 4217 currency code for the financial threshold amount (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `is_special_award_condition` BOOLEAN COMMENT 'Boolean flag indicating whether this condition is a Special Award Condition (SAC) imposed by the donor due to identified risks or past performance issues. True if this is a SAC, False otherwise.',
    `last_review_date` DATE COMMENT 'The date on which this donor condition was last reviewed by the responsible staff or compliance team.',
    `modified_by` STRING COMMENT 'Username or identifier of the system user who last modified this donor condition record.',
    `modified_timestamp` TIMESTAMP COMMENT 'The date and time when this donor condition record was last updated or modified.',
    `monitoring_frequency` STRING COMMENT 'How frequently the organization monitors progress toward meeting this condition. Values: daily, weekly, monthly, quarterly, as_needed.. Valid values are `daily|weekly|monthly|quarterly|as_needed`',
    `next_recurrence_date` DATE COMMENT 'For recurring conditions, the date of the next scheduled occurrence or deadline. Null for one-time conditions.',
    `next_review_date` DATE COMMENT 'The scheduled date for the next review of this donor condition.',
    `priority_level` STRING COMMENT 'Business priority assigned to this condition based on risk, donor emphasis, or organizational impact. Values: critical (non-compliance could result in grant suspension or termination), high (significant risk or donor focus), medium (standard condition), low (minor or administrative condition).. Valid values are `critical|high|medium|low`',
    `recurrence_frequency` STRING COMMENT 'Indicates whether this condition is a one-time requirement or recurs on a regular schedule. Values: one_time (single occurrence), monthly, quarterly, semi_annually, annually, as_needed (triggered by specific events).. Valid values are `one_time|monthly|quarterly|semi_annually|annually|as_needed`',
    `reference_number` STRING COMMENT 'Externally-known unique identifier or code assigned to this donor condition by the donor or grant management system (e.g., SAC-2024-001, COND-BHA-45).',
    `regulatory_citation` STRING COMMENT 'Reference to the specific regulatory or policy section that mandates or governs this condition (e.g., 2 CFR 200.308, USAID ADS 303.3.10, DFID Smart Rule 4.2.3).',
    `responsible_department` STRING COMMENT 'The organizational department or functional unit responsible for managing and fulfilling this donor condition (e.g., Finance, Programs, Compliance, MEL).',
    `risk_rating` STRING COMMENT 'Assessment of the risk to the organization if this condition is not met. Values: low (minimal impact), medium (moderate impact on grant or reputation), high (significant financial or programmatic risk), critical (could result in grant termination or legal action).. Valid values are `low|medium|high|critical`',
    `sac_justification` STRING COMMENT 'Narrative explanation provided by the donor for why this Special Award Condition was imposed, including any identified risks or deficiencies.',
    `supporting_document_reference` STRING COMMENT 'Reference identifier or file path to supporting documentation related to this condition (e.g., approval letters, waiver memos, compliance evidence, submitted reports).',
    `title` STRING COMMENT 'Short, human-readable title or summary of the donor condition (e.g., Quarterly Financial Report Submission, Prior Approval for Subawards Over $100K).',
    `waiver_date` DATE COMMENT 'The date on which the donor formally waived this condition. Null if the condition was not waived.',
    `waiver_justification` STRING COMMENT 'Narrative explanation provided by the donor or documented by the organization for why the condition was waived.',
    `created_by` STRING COMMENT 'Username or identifier of the system user who created this donor condition record.',
    CONSTRAINT pk_donor_condition PRIMARY KEY(`donor_condition_id`)
) COMMENT 'Captures all donor-imposed conditions, special award conditions (SACs), compliance obligations, and key milestone requirements attached to a specific grant award. Each record represents a single condition including condition type (prior approval requirement, restricted cost, reporting obligation, key personnel approval, branding/marking requirement, audit requirement, programmatic milestone, deliverable deadline), condition description, regulatory citation (2 CFR 200 section, USAID ADS chapter, DFID Smart Rule), compliance status (open, met, waived, expired), due date, actual completion date, and responsible staff. Enables proactive compliance management, milestone tracking, and audit readiness.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`grant`.`donor_report` (
    `donor_report_id` BIGINT COMMENT 'Unique identifier for the donor report submission record. Primary key.',
    `award_id` BIGINT COMMENT 'Reference to the grant award for which this report is submitted.',
    `constituent_id` BIGINT COMMENT 'Foreign key linking to donor.constituent. Business justification: Donor reports are submitted to a specific donor/constituent. NGO grants teams must track which constituent received each report for stewardship compliance, relationship management, and audit trails. A',
    `fund_id` BIGINT COMMENT 'Foreign key linking to donor.donor_fund. Business justification: Restricted donor funds require fund-level reporting back to the donor. NGO finance teams produce donor reports at the fund level to demonstrate compliance with fund restrictions. This is a core fund a',
    `intervention_id` BIGINT COMMENT 'Foreign key linking to program.intervention. Business justification: Donor reports often cover specific interventions and require intervention-level narrative and results reporting. Essential for programmatic donor reports that must reference the intervention(s) being ',
    `meal_plan_id` BIGINT COMMENT 'Foreign key linking to mel.meal_plan. Business justification: Donor reports are prepared in accordance with the governing MEAL plan, which defines reporting requirements, indicator coverage, and data collection protocols. Grants and MEL teams reference the MEAL ',
    `project_site_id` BIGINT COMMENT 'Foreign key linking to field.project_site. Business justification: Donor narrative reports routinely reference specific implementation sites for activity verification, beneficiary reach validation, and geographic accountability. Essential for site-level performance r',
    `reporting_period_id` BIGINT COMMENT 'Foreign key linking to mel.reporting_period. Business justification: Donor reports are submitted against specific MEL reporting periods. Compliance officers and MEL staff must align donor report submissions to the reporting calendar. This link enables period-based repo',
    `approval_date` DATE COMMENT 'The date on which the donor report was internally approved for submission to the donor.',
    `audit_findings_count` STRING COMMENT 'Number of audit findings or compliance issues identified by internal or external auditors related to this reporting period, if applicable.',
    `beneficiaries_reached` STRING COMMENT 'Total number of unique beneficiaries or persons of concern (PoC) reached or served during the reporting period, as reported to the donor.',
    `budget_variance_amount` DECIMAL(18,2) COMMENT 'The difference between the budgeted amount and the actual expenditure for the reporting period, calculated as actual minus budget (positive indicates overspend, negative indicates underspend).',
    `budget_variance_percentage` DECIMAL(18,2) COMMENT 'The budget variance expressed as a percentage of the budgeted amount, calculated as (actual - budget) / budget * 100.',
    `compliance_certification_flag` BOOLEAN COMMENT 'Boolean flag indicating whether the responsible staff member has certified that this report complies with all donor requirements, grant terms, and applicable regulations (True = certified, False = not certified).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this donor report record was first created in the system.',
    `cumulative_expenditure_to_date` DECIMAL(18,2) COMMENT 'Total cumulative expenditure reported to the donor from the grant start date through the end of this reporting period.',
    `days_overdue` STRING COMMENT 'Number of calendar days by which the report submission was late, calculated as submission date minus due date. Null or zero if submitted on time.',
    `donor_acceptance_date` DATE COMMENT 'The date on which the donor formally accepted or approved this report submission, marking it as satisfactory and compliant.',
    `donor_feedback_summary` STRING COMMENT 'Summary of feedback, comments, or recommendations provided by the donor in response to this report submission.',
    `donor_report_status` STRING COMMENT 'Current lifecycle status of the donor report: upcoming (not yet started), draft (in preparation), submitted (sent to donor), under review (donor reviewing), accepted (approved by donor), revision requested (donor requested changes), or final (closed and archived). [ENUM-REF-CANDIDATE: Upcoming|Draft|Submitted|Under Review|Accepted|Revision Requested|Final — 7 candidates stripped; promote to reference product]',
    `donor_report_type` STRING COMMENT 'Classification of the donor report by its purpose and format, such as SF-425 Federal Financial Report, quarterly programmatic report, annual narrative, situation report (SitRep), final closeout report, or IATI transparency disclosure.. Valid values are `SF-425 Federal Financial Report|Quarterly Programmatic|Annual Narrative|SitRep|Final Report|IATI Disclosure`',
    `due_date` DATE COMMENT 'The deadline by which this donor report must be submitted to the donor, as specified in the grant agreement or donor compliance schedule.',
    `exchange_rate_used` DECIMAL(18,2) COMMENT 'The foreign exchange rate applied to convert the reported financial amount from the grant currency to USD, if applicable.',
    `financial_amount_reported` DECIMAL(18,2) COMMENT 'Total financial expenditure or disbursement amount reported to the donor for the reporting period, in the grant currency.',
    `financial_amount_reported_usd` DECIMAL(18,2) COMMENT 'Total financial expenditure or disbursement amount reported to the donor, converted to United States Dollars (USD) for standardized reporting and analysis.',
    `financial_currency` STRING COMMENT 'Three-letter ISO 4217 currency code for the financial amounts reported in this donor report (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `is_final_version` BOOLEAN COMMENT 'Boolean flag indicating whether this version of the donor report is the final, accepted version (True) or an interim/draft version (False).',
    `is_overdue` BOOLEAN COMMENT 'Boolean flag indicating whether this donor report was submitted after its due date (True = overdue, False = submitted on time or not yet due).',
    `key_performance_indicators_met` STRING COMMENT 'Number of Key Performance Indicators (KPIs) or LogFrame indicators that met or exceeded their targets during the reporting period.',
    `key_performance_indicators_total` STRING COMMENT 'Total number of Key Performance Indicators (KPIs) or LogFrame indicators being tracked and reported for this grant during the reporting period.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this donor report record was last updated or modified in the system.',
    `narrative_summary` STRING COMMENT 'Textual summary of programmatic activities, achievements, challenges, and lessons learned during the reporting period, as required by the donor.',
    `notes` STRING COMMENT 'Free-text field for internal notes, special circumstances, or additional context related to this donor report submission.',
    `reference_number` STRING COMMENT 'Externally-known unique identifier or tracking number for this donor report submission, often assigned by the donor or grant management system.',
    `reporting_frequency` STRING COMMENT 'Scheduled frequency at which this type of report must be submitted to the donor, such as monthly, quarterly, semi-annual, annual, ad hoc, or final (one-time closeout).. Valid values are `Monthly|Quarterly|Semi-Annual|Annual|Ad Hoc|Final`',
    `reporting_period_end_date` DATE COMMENT 'The last day of the period covered by this donor report (e.g., end of the quarter or fiscal year).',
    `reporting_period_start_date` DATE COMMENT 'The first day of the period covered by this donor report (e.g., start of the quarter or fiscal year).',
    `revision_reason` STRING COMMENT 'Narrative explanation provided by the donor for why revisions were requested, including specific feedback or areas requiring correction.',
    `revision_requested_date` DATE COMMENT 'The date on which the donor requested revisions or additional information for this report, if applicable.',
    `submission_date` DATE COMMENT 'The actual date on which the donor report was submitted to the donor.',
    `submission_method` STRING COMMENT 'The channel or system through which the donor report was submitted, such as email, donor web portal, USAID ASIST system, DFID ARIES platform, CERF portal, or manual upload.. Valid values are `Email|Donor Portal|USAID ASIST|DFID ARIES|CERF Portal|Manual Upload`',
    `supporting_document_reference` STRING COMMENT 'Reference identifier or file path to supporting documentation attached to this donor report, such as financial statements, beneficiary lists, field photos, or monitoring data.',
    `version_number` STRING COMMENT 'Sequential version number of this donor report submission, incremented each time a revised version is submitted (e.g., 1 for initial submission, 2 for first revision).',
    CONSTRAINT pk_donor_report PRIMARY KEY(`donor_report_id`)
) COMMENT 'SSOT for all donor reporting obligations and submitted reports for each grant award. Defines the complete reporting schedule including report type (SF-425 Federal Financial Report, quarterly programmatic, annual narrative, SitRep, final report, IATI disclosure), reporting frequency (monthly, quarterly, semi-annual, annual, ad hoc), due dates, and responsible staff. Tracks each report submission through its lifecycle: upcoming → draft → submitted → accepted/revision requested → final. Captures submission method (email, donor portal, USAID ASIST, DFID ARIES), financial figures reported, narrative summary reference, version number, and reporting period covered. Supports compliance tracking, donor relationship management, and audit accountability under CHS and HAP standards.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`grant`.`funding_source` (
    `funding_source_id` BIGINT COMMENT 'Unique identifier for the funding source record. Primary key.',
    `partner_org_id` BIGINT COMMENT 'Reference to the donor organization that provides this funding source. Links to the institutional donor entity in the donor domain.',
    `advance_payment_allowed` BOOLEAN COMMENT 'Boolean flag indicating whether this funding source permits advance payments or cash advances to be disbursed before costs are incurred. Affects cash flow management and liquidity planning.',
    `allowable_cost_categories` STRING COMMENT 'Comma-separated list of cost categories or Chart of Accounts codes that are allowable under this funding source (e.g., personnel, travel, equipment, supplies). Used to enforce budget compliance and prevent unallowable cost charges.',
    `audit_requirement` STRING COMMENT 'The type of audit required by the donor for grants funded by this source. Single audit refers to OMB Uniform Guidance 2 CFR 200 Subpart F audits; program-specific audit refers to audits of individual programs; financial audit refers to organization-wide financial statement audits; no audit required indicates the donor does not mandate an audit.. Valid values are `single_audit|program_specific_audit|financial_audit|no_audit_required`',
    `budget_flexibility` STRING COMMENT 'Classification of the degree of budget flexibility allowed by the donor for grants funded by this source. Fixed budgets require donor approval for any changes; flexible within categories allows reallocation within cost categories; flexible with approval allows reallocation with prior donor consent; fully flexible allows unrestricted reallocation.. Valid values are `fixed|flexible_within_categories|flexible_with_approval|fully_flexible`',
    `budget_revision_threshold` DECIMAL(18,2) COMMENT 'The percentage threshold (expressed as a decimal, e.g., 0.1000 for 10%) above which budget revisions or reallocations require prior donor approval. Null if no threshold applies.',
    `closeout_period_days` STRING COMMENT 'The number of calendar days after the grant end date within which all closeout activities (final reports, financial reconciliation, asset disposition) must be completed for grants funded by this source.',
    `funding_source_code` STRING COMMENT 'The unique alphanumeric code or identifier assigned to this funding source by the donor organization or internal grant management system for tracking and reporting purposes.',
    `compliance_framework` STRING COMMENT 'Comma-separated list of regulatory and compliance frameworks that govern the use of this funding source (e.g., OMB Uniform Guidance 2 CFR 200, USAID Standard Provisions, DFID Terms and Conditions, CERF Grant Agreement). Used to segment compliance obligations by funding source.',
    `contact_email` STRING COMMENT 'The email address of the primary contact person at the donor organization for this funding source. Used for grant administration communication.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `contact_person_name` STRING COMMENT 'The name of the primary contact person at the donor organization responsible for this funding source. Used for relationship management and grant administration inquiries.',
    `contact_phone` STRING COMMENT 'The phone number of the primary contact person at the donor organization for this funding source. Used for urgent grant administration inquiries.',
    `cost_share_percentage` DECIMAL(18,2) COMMENT 'The percentage of total project costs that must be provided as cost-sharing or matching funds (expressed as a decimal, e.g., 0.2500 for 25%). Null if no cost-sharing is required.',
    `cost_share_required` BOOLEAN COMMENT 'Boolean flag indicating whether this funding source requires the organization to provide cost-sharing or matching funds as a condition of the grant award.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this funding source record was first created in the grant management system. Used for audit trail and data lineage tracking.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code representing the currency in which this funding source disburses funds (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `funding_source_description` STRING COMMENT 'Detailed narrative description of the funding source, including its purpose, strategic priorities, target beneficiary populations, and any special conditions or donor intent. Used for internal reference and proposal development.',
    `donor_reporting_frequency` STRING COMMENT 'The frequency at which the donor organization requires narrative and financial reports for grants funded by this source. Drives reporting calendar and compliance tracking.. Valid values are `monthly|quarterly|semi_annually|annually|upon_request|milestone_based`',
    `fund_restriction_type` STRING COMMENT 'Classification of the funding source according to donor-imposed restrictions per ASC 958 (Not-for-Profit Entities). Unrestricted funds have no donor-imposed restrictions; temporarily restricted funds have time or purpose restrictions that may expire; permanently restricted funds have perpetual restrictions (e.g., endowments).. Valid values are `unrestricted|temporarily_restricted|permanently_restricted`',
    `funding_end_date` DATE COMMENT 'The date on which this funding source expires or is no longer available for new grant awards. Represents the end of the funding period. Nullable for open-ended funding sources.',
    `funding_mechanism_type` STRING COMMENT 'Classification of the funding mechanism through which resources are provided. Distinguishes between Official Development Assistance (ODA) bilateral and multilateral channels, foundation grants, corporate philanthropy, Central Emergency Response Fund (CERF) pooled funds, government contracts, private donations, and endowment income. [ENUM-REF-CANDIDATE: oda_bilateral|oda_multilateral|foundation_grant|corporate_philanthropy|cerf_pooled_fund|government_contract|private_donation|endowment_income — 8 candidates stripped; promote to reference product]',
    `funding_source_status` STRING COMMENT 'Current lifecycle status of the funding source indicating whether it is actively available for grant awards, temporarily suspended, permanently closed, pending activation, or under review.. Valid values are `active|suspended|closed|pending_activation|under_review`',
    `funding_start_date` DATE COMMENT 'The date from which this funding source becomes available for grant awards and disbursements. Represents the beginning of the funding period.',
    `geographic_restriction` STRING COMMENT 'Comma-separated list of ISO 3166-1 alpha-3 country codes or regional designations indicating geographic areas where this funding source may be used. Empty if no geographic restrictions apply.',
    `iati_organization_identifier` STRING COMMENT 'The globally unique IATI organization identifier for the donor organization providing this funding source. Enables cross-organizational aid transparency reporting and data exchange.',
    `indirect_cost_rate_type` STRING COMMENT 'The type of indirect cost rate mechanism applicable to this funding source. NICRA refers to a formally negotiated rate; de minimis refers to the 10% rate allowed under 2 CFR 200.414(f); cost reimbursement, fixed rate, and negotiated rate represent other donor-specific mechanisms.. Valid values are `nicra|de_minimis|cost_reimbursement|fixed_rate|negotiated_rate`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this funding source record was last updated in the grant management system. Used for audit trail and change tracking.',
    `funding_source_name` STRING COMMENT 'The official name of the funding source or funding mechanism as recognized by the donor organization and used in grant agreements.',
    `nicra_rate` DECIMAL(18,2) COMMENT 'The negotiated indirect cost rate (expressed as a decimal, e.g., 0.1500 for 15%) applicable to this funding source for recovering facilities and administration costs. Used for US federal grants under OMB Uniform Guidance 2 CFR 200.',
    `oda_dac_classification` STRING COMMENT 'The OECD Development Assistance Committee classification code for this funding source if it qualifies as Official Development Assistance. Used for international aid transparency and reporting to DAC member countries.',
    `payment_method` STRING COMMENT 'The standard payment method used by the donor organization to disburse funds from this funding source (e.g., wire transfer, ACH, check, letter of credit, direct deposit, pooled fund transfer).. Valid values are `wire_transfer|ach|check|letter_of_credit|direct_deposit|pooled_fund_transfer`',
    `procurement_standards` STRING COMMENT 'Description of the procurement and contracting standards that must be followed when using this funding source (e.g., OMB Uniform Guidance 2 CFR 200.318-200.326, USAID Mandatory Standard Provisions, DFID Procurement Guidelines). Ensures compliance with donor procurement rules.',
    `program_income_treatment` STRING COMMENT 'The method by which program income earned under grants funded by this source must be treated per OMB Uniform Guidance 2 CFR 200.307. Addition means income is added to the grant; deduction means income reduces the donor share; cost-sharing means income is used to meet cost-share requirements; no program income indicates the funding source does not generate program income.. Valid values are `addition|deduction|cost_sharing|no_program_income`',
    `record_retention_years` STRING COMMENT 'The number of years that financial and programmatic records for grants funded by this source must be retained after grant closeout, as required by the donor or applicable regulations (e.g., OMB Uniform Guidance requires 3 years).',
    `sdg_alignment_codes` STRING COMMENT 'Comma-separated list of United Nations Sustainable Development Goal codes (e.g., SDG 1, SDG 3, SDG 5) that this funding source is aligned with or restricted to support. Enables portfolio analysis by SDG impact area.',
    `subaward_allowed` BOOLEAN COMMENT 'Boolean flag indicating whether this funding source permits the organization to issue subawards or subgrants to implementing partners and community-based organizations.',
    `subaward_approval_required` BOOLEAN COMMENT 'Boolean flag indicating whether the donor organization must provide prior written approval before the organization can issue subawards using this funding source.',
    `thematic_restriction` STRING COMMENT 'Description of thematic or sectoral restrictions on the use of this funding source (e.g., WASH programs only, education initiatives, health services, emergency response). Empty if no thematic restrictions apply.',
    `total_funding_available` DECIMAL(18,2) COMMENT 'The total amount of funding available from this source across all grant awards, expressed in the funding source currency. May represent a ceiling or allocation limit.',
    `unallowable_cost_categories` STRING COMMENT 'Comma-separated list of cost categories or Chart of Accounts codes that are explicitly unallowable under this funding source (e.g., alcohol, entertainment, lobbying). Used to enforce budget compliance and prevent unallowable cost charges.',
    CONSTRAINT pk_funding_source PRIMARY KEY(`funding_source_id`)
) COMMENT 'Reference master for all funding sources and donor funding mechanisms used across grant awards. Captures funding source name, donor organization reference, funding mechanism type (ODA bilateral, multilateral, foundation grant, corporate philanthropy, CERF pooled fund, government contract), ODA/DAC classification, SDG alignment codes, geographic restrictions, thematic restrictions, currency, and IATI organization identifier. Enables portfolio analysis by funding source and donor compliance segmentation. Lives in the grant domain as the grant-facing classification of how funding flows to awards — distinct from the donor domains relationship and stewardship records which track the institutional relationship, communication history, and cultivation pipeline with the funding organization itself.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_ngo_v1`.`grant`.`award` ADD CONSTRAINT `fk_grant_award_funding_source_id` FOREIGN KEY (`funding_source_id`) REFERENCES `vibe_ngo_v1`.`grant`.`funding_source`(`funding_source_id`);
ALTER TABLE `vibe_ngo_v1`.`grant`.`proposal` ADD CONSTRAINT `fk_grant_proposal_award_id` FOREIGN KEY (`award_id`) REFERENCES `vibe_ngo_v1`.`grant`.`award`(`award_id`);
ALTER TABLE `vibe_ngo_v1`.`grant`.`proposal` ADD CONSTRAINT `fk_grant_proposal_funding_source_id` FOREIGN KEY (`funding_source_id`) REFERENCES `vibe_ngo_v1`.`grant`.`funding_source`(`funding_source_id`);
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget` ADD CONSTRAINT `fk_grant_award_budget_amendment_id` FOREIGN KEY (`amendment_id`) REFERENCES `vibe_ngo_v1`.`grant`.`amendment`(`amendment_id`);
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget` ADD CONSTRAINT `fk_grant_award_budget_award_id` FOREIGN KEY (`award_id`) REFERENCES `vibe_ngo_v1`.`grant`.`award`(`award_id`);
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget_line` ADD CONSTRAINT `fk_grant_award_budget_line_award_budget_id` FOREIGN KEY (`award_budget_id`) REFERENCES `vibe_ngo_v1`.`grant`.`award_budget`(`award_budget_id`);
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget_line` ADD CONSTRAINT `fk_grant_award_budget_line_award_id` FOREIGN KEY (`award_id`) REFERENCES `vibe_ngo_v1`.`grant`.`award`(`award_id`);
ALTER TABLE `vibe_ngo_v1`.`grant`.`amendment` ADD CONSTRAINT `fk_grant_amendment_award_id` FOREIGN KEY (`award_id`) REFERENCES `vibe_ngo_v1`.`grant`.`award`(`award_id`);
ALTER TABLE `vibe_ngo_v1`.`grant`.`amendment` ADD CONSTRAINT `fk_grant_amendment_supersedes_amendment_grant_amendment_id` FOREIGN KEY (`supersedes_amendment_grant_amendment_id`) REFERENCES `vibe_ngo_v1`.`grant`.`amendment`(`amendment_id`);
ALTER TABLE `vibe_ngo_v1`.`grant`.`subaward` ADD CONSTRAINT `fk_grant_subaward_award_id` FOREIGN KEY (`award_id`) REFERENCES `vibe_ngo_v1`.`grant`.`award`(`award_id`);
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_condition` ADD CONSTRAINT `fk_grant_donor_condition_award_id` FOREIGN KEY (`award_id`) REFERENCES `vibe_ngo_v1`.`grant`.`award`(`award_id`);
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_report` ADD CONSTRAINT `fk_grant_donor_report_award_id` FOREIGN KEY (`award_id`) REFERENCES `vibe_ngo_v1`.`grant`.`award`(`award_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_ngo_v1`.`grant` SET TAGS ('dbx_division' = 'business');
ALTER SCHEMA `vibe_ngo_v1`.`grant` SET TAGS ('dbx_domain' = 'grant');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award` SET TAGS ('dbx_subdomain' = 'award_management');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award` ALTER COLUMN `award_id` SET TAGS ('dbx_business_glossary_term' = 'Award Identifier');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award` ALTER COLUMN `constituent_id` SET TAGS ('dbx_business_glossary_term' = 'Donor Identifier');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award` ALTER COLUMN `country_id` SET TAGS ('dbx_business_glossary_term' = 'Country Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award` ALTER COLUMN `country_office_id` SET TAGS ('dbx_business_glossary_term' = 'Country Office Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award` ALTER COLUMN `funding_source_id` SET TAGS ('dbx_business_glossary_term' = 'Funding Source Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award` ALTER COLUMN `intervention_id` SET TAGS ('dbx_business_glossary_term' = 'Intervention Id');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award` ALTER COLUMN `advance_payment_allowed` SET TAGS ('dbx_business_glossary_term' = 'Advance Payment Allowed');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award` ALTER COLUMN `agreement_signed_date` SET TAGS ('dbx_business_glossary_term' = 'Agreement Signed Date');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award` ALTER COLUMN `amendment_count` SET TAGS ('dbx_business_glossary_term' = 'Amendment Count');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award` ALTER COLUMN `audit_required` SET TAGS ('dbx_business_glossary_term' = 'Audit Required');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award` ALTER COLUMN `audit_threshold_amount` SET TAGS ('dbx_business_glossary_term' = 'Audit Threshold Amount');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award` ALTER COLUMN `authorized_amount` SET TAGS ('dbx_business_glossary_term' = 'Authorized Amount');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award` ALTER COLUMN `award_status` SET TAGS ('dbx_business_glossary_term' = 'Award Status');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award` ALTER COLUMN `award_status` SET TAGS ('dbx_value_regex' = 'pipeline|active|no_cost_extension|suspended|closed');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award` ALTER COLUMN `award_type` SET TAGS ('dbx_business_glossary_term' = 'Award Type');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award` ALTER COLUMN `award_type` SET TAGS ('dbx_value_regex' = 'cooperative_agreement|contract|grant|sub_award|consortium_lead|consortium_member');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award` ALTER COLUMN `branding_marking_requirements` SET TAGS ('dbx_business_glossary_term' = 'Branding and Marking Requirements');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award` ALTER COLUMN `closeout_date` SET TAGS ('dbx_business_glossary_term' = 'Award Closeout Date');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award` ALTER COLUMN `cost_share_amount` SET TAGS ('dbx_business_glossary_term' = 'Cost Share Amount');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award` ALTER COLUMN `cost_share_percentage` SET TAGS ('dbx_business_glossary_term' = 'Cost Share Percentage');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award` ALTER COLUMN `cost_share_percentage` SET TAGS ('dbx_pii_demographic' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award` ALTER COLUMN `cost_share_required` SET TAGS ('dbx_business_glossary_term' = 'Cost Share Required');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award` ALTER COLUMN `currency` SET TAGS ('dbx_business_glossary_term' = 'Award Currency');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award` ALTER COLUMN `currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award` ALTER COLUMN `dac_sector_code` SET TAGS ('dbx_business_glossary_term' = 'Development Assistance Committee (DAC) Sector Code');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award` ALTER COLUMN `donor_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Donor Reference Number');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'Award End Date');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award` ALTER COLUMN `exchange_rate_to_functional` SET TAGS ('dbx_business_glossary_term' = 'Exchange Rate to Functional Currency');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award` ALTER COLUMN `functional_currency` SET TAGS ('dbx_business_glossary_term' = 'Functional Currency');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award` ALTER COLUMN `functional_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award` ALTER COLUMN `geographic_scope` SET TAGS ('dbx_business_glossary_term' = 'Geographic Scope');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award` ALTER COLUMN `indirect_cost_ceiling` SET TAGS ('dbx_business_glossary_term' = 'Indirect Cost Ceiling');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award` ALTER COLUMN `last_amendment_date` SET TAGS ('dbx_business_glossary_term' = 'Last Amendment Date');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award` ALTER COLUMN `nicra_icr_rate` SET TAGS ('dbx_business_glossary_term' = 'Negotiated Indirect Cost Rate Agreement (NICRA) / Indirect Cost Rate (ICR)');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Award Notes');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award` ALTER COLUMN `notification_date` SET TAGS ('dbx_business_glossary_term' = 'Award Notification Date');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award` ALTER COLUMN `number` SET TAGS ('dbx_business_glossary_term' = 'Award Number');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award` ALTER COLUMN `original_end_date` SET TAGS ('dbx_business_glossary_term' = 'Original Award End Date');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award` ALTER COLUMN `payment_method` SET TAGS ('dbx_value_regex' = 'advance|reimbursement|milestone|hybrid');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award` ALTER COLUMN `period_of_performance_months` SET TAGS ('dbx_business_glossary_term' = 'Period of Performance in Months');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award` ALTER COLUMN `regulatory_framework` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Framework');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award` ALTER COLUMN `reporting_frequency` SET TAGS ('dbx_business_glossary_term' = 'Reporting Frequency');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award` ALTER COLUMN `reporting_frequency` SET TAGS ('dbx_value_regex' = 'monthly|quarterly|semi_annual|annual|final_only');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award` ALTER COLUMN `sdg_alignment` SET TAGS ('dbx_business_glossary_term' = 'Sustainable Development Goal (SDG) Alignment');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award` ALTER COLUMN `special_conditions` SET TAGS ('dbx_business_glossary_term' = 'Special Conditions');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Award Start Date');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award` ALTER COLUMN `thematic_sector` SET TAGS ('dbx_business_glossary_term' = 'Thematic Sector');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award` ALTER COLUMN `title` SET TAGS ('dbx_business_glossary_term' = 'Award Title');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award` ALTER COLUMN `total_obligated_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Obligated Amount');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award` ALTER COLUMN `total_obligated_amount_functional` SET TAGS ('dbx_business_glossary_term' = 'Total Obligated Amount in Functional Currency');
ALTER TABLE `vibe_ngo_v1`.`grant`.`proposal` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_ngo_v1`.`grant`.`proposal` SET TAGS ('dbx_subdomain' = 'award_management');
ALTER TABLE `vibe_ngo_v1`.`grant`.`proposal` ALTER COLUMN `proposal_id` SET TAGS ('dbx_business_glossary_term' = 'Proposal Identifier (ID)');
ALTER TABLE `vibe_ngo_v1`.`grant`.`proposal` ALTER COLUMN `award_id` SET TAGS ('dbx_business_glossary_term' = 'Awarded Grant Identifier (ID)');
ALTER TABLE `vibe_ngo_v1`.`grant`.`proposal` ALTER COLUMN `component_id` SET TAGS ('dbx_business_glossary_term' = 'Program Identifier (ID)');
ALTER TABLE `vibe_ngo_v1`.`grant`.`proposal` ALTER COLUMN `constituent_id` SET TAGS ('dbx_business_glossary_term' = 'Donor Identifier (ID)');
ALTER TABLE `vibe_ngo_v1`.`grant`.`proposal` ALTER COLUMN `country_id` SET TAGS ('dbx_business_glossary_term' = 'Country Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`grant`.`proposal` ALTER COLUMN `country_office_id` SET TAGS ('dbx_business_glossary_term' = 'Country Office Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`grant`.`proposal` ALTER COLUMN `emergency_id` SET TAGS ('dbx_business_glossary_term' = 'Emergency Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`grant`.`proposal` ALTER COLUMN `fund_id` SET TAGS ('dbx_business_glossary_term' = 'Donor Fund Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`grant`.`proposal` ALTER COLUMN `funding_source_id` SET TAGS ('dbx_business_glossary_term' = 'Funding Source Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`grant`.`proposal` ALTER COLUMN `intervention_id` SET TAGS ('dbx_business_glossary_term' = 'Intervention Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`grant`.`proposal` ALTER COLUMN `partner_org_id` SET TAGS ('dbx_business_glossary_term' = 'Lead Partner Org Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`grant`.`proposal` ALTER COLUMN `mel_logframe_id` SET TAGS ('dbx_business_glossary_term' = 'Mel Logframe Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`grant`.`proposal` ALTER COLUMN `award_notification_date` SET TAGS ('dbx_business_glossary_term' = 'Award Notification Date');
ALTER TABLE `vibe_ngo_v1`.`grant`.`proposal` ALTER COLUMN `business_development_owner` SET TAGS ('dbx_business_glossary_term' = 'Business Development Owner');
ALTER TABLE `vibe_ngo_v1`.`grant`.`proposal` ALTER COLUMN `compliance_review_completed` SET TAGS ('dbx_business_glossary_term' = 'Compliance Review Completed Flag');
ALTER TABLE `vibe_ngo_v1`.`grant`.`proposal` ALTER COLUMN `cost_proposal_summary` SET TAGS ('dbx_business_glossary_term' = 'Cost Proposal Summary');
ALTER TABLE `vibe_ngo_v1`.`grant`.`proposal` ALTER COLUMN `cost_share_amount` SET TAGS ('dbx_business_glossary_term' = 'Cost Share Amount');
ALTER TABLE `vibe_ngo_v1`.`grant`.`proposal` ALTER COLUMN `cost_share_percentage` SET TAGS ('dbx_business_glossary_term' = 'Cost Share Percentage');
ALTER TABLE `vibe_ngo_v1`.`grant`.`proposal` ALTER COLUMN `cost_share_percentage` SET TAGS ('dbx_pii_demographic' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`proposal` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_ngo_v1`.`grant`.`proposal` ALTER COLUMN `document_reference` SET TAGS ('dbx_business_glossary_term' = 'Proposal Document Reference');
ALTER TABLE `vibe_ngo_v1`.`grant`.`proposal` ALTER COLUMN `geographic_focus` SET TAGS ('dbx_business_glossary_term' = 'Geographic Focus');
ALTER TABLE `vibe_ngo_v1`.`grant`.`proposal` ALTER COLUMN `go_no_go_decision` SET TAGS ('dbx_business_glossary_term' = 'Go No-Go Decision');
ALTER TABLE `vibe_ngo_v1`.`grant`.`proposal` ALTER COLUMN `go_no_go_decision` SET TAGS ('dbx_value_regex' = 'go|no_go|pending');
ALTER TABLE `vibe_ngo_v1`.`grant`.`proposal` ALTER COLUMN `go_no_go_decision_date` SET TAGS ('dbx_business_glossary_term' = 'Go No-Go Decision Date');
ALTER TABLE `vibe_ngo_v1`.`grant`.`proposal` ALTER COLUMN `indirect_cost_rate_proposed` SET TAGS ('dbx_business_glossary_term' = 'Indirect Cost Rate (ICR) Proposed');
ALTER TABLE `vibe_ngo_v1`.`grant`.`proposal` ALTER COLUMN `internal_review_date` SET TAGS ('dbx_business_glossary_term' = 'Internal Review Date');
ALTER TABLE `vibe_ngo_v1`.`grant`.`proposal` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_ngo_v1`.`grant`.`proposal` ALTER COLUMN `lead_proposal_writer` SET TAGS ('dbx_business_glossary_term' = 'Lead Proposal Writer');
ALTER TABLE `vibe_ngo_v1`.`grant`.`proposal` ALTER COLUMN `lead_technical_sector` SET TAGS ('dbx_business_glossary_term' = 'Lead Technical Sector');
ALTER TABLE `vibe_ngo_v1`.`grant`.`proposal` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Proposal Notes');
ALTER TABLE `vibe_ngo_v1`.`grant`.`proposal` ALTER COLUMN `partnership_model` SET TAGS ('dbx_business_glossary_term' = 'Partnership Model');
ALTER TABLE `vibe_ngo_v1`.`grant`.`proposal` ALTER COLUMN `partnership_model` SET TAGS ('dbx_value_regex' = 'prime|sub_award|consortium|joint_venture|solo');
ALTER TABLE `vibe_ngo_v1`.`grant`.`proposal` ALTER COLUMN `proposal_status` SET TAGS ('dbx_business_glossary_term' = 'Proposal Status');
ALTER TABLE `vibe_ngo_v1`.`grant`.`proposal` ALTER COLUMN `proposal_type` SET TAGS ('dbx_business_glossary_term' = 'Proposal Type');
ALTER TABLE `vibe_ngo_v1`.`grant`.`proposal` ALTER COLUMN `proposal_type` SET TAGS ('dbx_value_regex' = 'full_application|concept_note|expression_of_interest|unsolicited|pre_proposal|letter_of_inquiry');
ALTER TABLE `vibe_ngo_v1`.`grant`.`proposal` ALTER COLUMN `proposed_duration_months` SET TAGS ('dbx_business_glossary_term' = 'Proposed Duration in Months');
ALTER TABLE `vibe_ngo_v1`.`grant`.`proposal` ALTER COLUMN `proposed_end_date` SET TAGS ('dbx_business_glossary_term' = 'Proposed End Date');
ALTER TABLE `vibe_ngo_v1`.`grant`.`proposal` ALTER COLUMN `proposed_start_date` SET TAGS ('dbx_business_glossary_term' = 'Proposed Start Date');
ALTER TABLE `vibe_ngo_v1`.`grant`.`proposal` ALTER COLUMN `reference_number` SET TAGS ('dbx_business_glossary_term' = 'Proposal Reference Number');
ALTER TABLE `vibe_ngo_v1`.`grant`.`proposal` ALTER COLUMN `rejection_reason` SET TAGS ('dbx_business_glossary_term' = 'Rejection Reason');
ALTER TABLE `vibe_ngo_v1`.`grant`.`proposal` ALTER COLUMN `requested_amount` SET TAGS ('dbx_business_glossary_term' = 'Requested Amount');
ALTER TABLE `vibe_ngo_v1`.`grant`.`proposal` ALTER COLUMN `requested_amount_usd` SET TAGS ('dbx_business_glossary_term' = 'Requested Amount in United States Dollars (USD)');
ALTER TABLE `vibe_ngo_v1`.`grant`.`proposal` ALTER COLUMN `requested_currency` SET TAGS ('dbx_business_glossary_term' = 'Requested Currency');
ALTER TABLE `vibe_ngo_v1`.`grant`.`proposal` ALTER COLUMN `requested_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_ngo_v1`.`grant`.`proposal` ALTER COLUMN `submission_date` SET TAGS ('dbx_business_glossary_term' = 'Submission Date');
ALTER TABLE `vibe_ngo_v1`.`grant`.`proposal` ALTER COLUMN `target_beneficiary_count` SET TAGS ('dbx_business_glossary_term' = 'Target Beneficiary Count');
ALTER TABLE `vibe_ngo_v1`.`grant`.`proposal` ALTER COLUMN `technical_approach_summary` SET TAGS ('dbx_business_glossary_term' = 'Technical Approach Summary');
ALTER TABLE `vibe_ngo_v1`.`grant`.`proposal` ALTER COLUMN `title` SET TAGS ('dbx_business_glossary_term' = 'Proposal Title');
ALTER TABLE `vibe_ngo_v1`.`grant`.`proposal` ALTER COLUMN `win_loss_outcome` SET TAGS ('dbx_business_glossary_term' = 'Win Loss Outcome');
ALTER TABLE `vibe_ngo_v1`.`grant`.`proposal` ALTER COLUMN `win_loss_outcome` SET TAGS ('dbx_value_regex' = 'won|lost|pending|withdrawn');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget` SET TAGS ('dbx_subdomain' = 'budget_compliance');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget` ALTER COLUMN `award_budget_id` SET TAGS ('dbx_business_glossary_term' = 'Award Budget ID');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget` ALTER COLUMN `amendment_id` SET TAGS ('dbx_business_glossary_term' = 'Amendment Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget` ALTER COLUMN `award_id` SET TAGS ('dbx_business_glossary_term' = 'Grant ID');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By (Internal)');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget` ALTER COLUMN `award_budget_status` SET TAGS ('dbx_business_glossary_term' = 'Budget Status');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget` ALTER COLUMN `award_currency` SET TAGS ('dbx_business_glossary_term' = 'Award Currency');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget` ALTER COLUMN `award_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget` ALTER COLUMN `contractual_costs` SET TAGS ('dbx_business_glossary_term' = 'Contractual Costs (Sub-Awards and Consultants)');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget` ALTER COLUMN `cost_share_amount` SET TAGS ('dbx_business_glossary_term' = 'Cost Share Amount');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget` ALTER COLUMN `cost_share_required` SET TAGS ('dbx_business_glossary_term' = 'Cost Share Required');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget` ALTER COLUMN `donor_approval_date` SET TAGS ('dbx_business_glossary_term' = 'Donor Approval Date');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget` ALTER COLUMN `donor_approval_reference` SET TAGS ('dbx_business_glossary_term' = 'Donor Approval Reference');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget` ALTER COLUMN `equipment_costs` SET TAGS ('dbx_business_glossary_term' = 'Equipment Costs');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget` ALTER COLUMN `fringe_benefits_costs` SET TAGS ('dbx_business_glossary_term' = 'Fringe Benefits Costs');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget` ALTER COLUMN `fund_restriction_type` SET TAGS ('dbx_business_glossary_term' = 'Fund Restriction Type');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget` ALTER COLUMN `fund_restriction_type` SET TAGS ('dbx_value_regex' = 'unrestricted|temporarily_restricted|permanently_restricted');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget` ALTER COLUMN `indirect_cost_base` SET TAGS ('dbx_business_glossary_term' = 'Indirect Cost Base');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget` ALTER COLUMN `indirect_cost_base` SET TAGS ('dbx_value_regex' = 'modified_total_direct_costs|total_direct_costs|salaries_and_wages|other');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget` ALTER COLUMN `is_amendment` SET TAGS ('dbx_business_glossary_term' = 'Is Amendment');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget` ALTER COLUMN `narrative_reference` SET TAGS ('dbx_business_glossary_term' = 'Budget Narrative Reference');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget` ALTER COLUMN `nicra_rate_applied` SET TAGS ('dbx_business_glossary_term' = 'Negotiated Indirect Cost Rate Agreement (NICRA) Rate Applied');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Budget Notes');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget` ALTER COLUMN `period` SET TAGS ('dbx_business_glossary_term' = 'Budget Period');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget` ALTER COLUMN `period` SET TAGS ('dbx_value_regex' = '^(Year [1-9]|Year [1-9][0-9]|Period [1-9]|Period [1-9][0-9]|Full Award Period)$');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget` ALTER COLUMN `period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Budget Period End Date');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget` ALTER COLUMN `period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Budget Period Start Date');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget` ALTER COLUMN `personnel_costs` SET TAGS ('dbx_business_glossary_term' = 'Personnel Costs');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget` ALTER COLUMN `prepared_by` SET TAGS ('dbx_business_glossary_term' = 'Prepared By');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget` ALTER COLUMN `submission_date` SET TAGS ('dbx_business_glossary_term' = 'Budget Submission Date');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget` ALTER COLUMN `supplies_costs` SET TAGS ('dbx_business_glossary_term' = 'Supplies Costs');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget` ALTER COLUMN `total_approved_budget` SET TAGS ('dbx_business_glossary_term' = 'Total Approved Budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget` ALTER COLUMN `total_direct_costs` SET TAGS ('dbx_business_glossary_term' = 'Total Direct Costs');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget` ALTER COLUMN `total_indirect_costs` SET TAGS ('dbx_business_glossary_term' = 'Total Indirect Costs (Facilities and Administration)');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget` ALTER COLUMN `travel_costs` SET TAGS ('dbx_business_glossary_term' = 'Travel Costs');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Budget Version Number');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget_line` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget_line` SET TAGS ('dbx_subdomain' = 'budget_compliance');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget_line` ALTER COLUMN `award_budget_line_id` SET TAGS ('dbx_business_glossary_term' = 'Award Budget Line ID');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget_line` ALTER COLUMN `award_budget_id` SET TAGS ('dbx_business_glossary_term' = 'Budget Period ID');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget_line` ALTER COLUMN `award_id` SET TAGS ('dbx_business_glossary_term' = 'Award ID');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget_line` ALTER COLUMN `component_id` SET TAGS ('dbx_business_glossary_term' = 'Program ID');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget_line` ALTER COLUMN `fund_id` SET TAGS ('dbx_business_glossary_term' = 'Donor Fund Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget_line` ALTER COLUMN `indicator_id` SET TAGS ('dbx_business_glossary_term' = 'Indicator Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget_line` ALTER COLUMN `intervention_id` SET TAGS ('dbx_business_glossary_term' = 'Intervention Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget_line` ALTER COLUMN `project_site_id` SET TAGS ('dbx_business_glossary_term' = 'Finance Budget Line Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget_line` ALTER COLUMN `allocability_flag` SET TAGS ('dbx_business_glossary_term' = 'Allocability Flag');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget_line` ALTER COLUMN `allowability_flag` SET TAGS ('dbx_business_glossary_term' = 'Allowability Flag');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget_line` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Budget Line Approval Date');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget_line` ALTER COLUMN `approved_amount` SET TAGS ('dbx_business_glossary_term' = 'Approved Budget Amount');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget_line` ALTER COLUMN `approved_amount_usd` SET TAGS ('dbx_business_glossary_term' = 'Approved Budget Amount (USD)');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget_line` ALTER COLUMN `budget_line_status` SET TAGS ('dbx_business_glossary_term' = 'Budget Line Status');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget_line` ALTER COLUMN `budget_line_status` SET TAGS ('dbx_value_regex' = 'active|suspended|closed|amended');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget_line` ALTER COLUMN `cost_category` SET TAGS ('dbx_business_glossary_term' = 'Cost Category');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget_line` ALTER COLUMN `cost_share_amount` SET TAGS ('dbx_business_glossary_term' = 'Cost Share Amount');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget_line` ALTER COLUMN `cost_share_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Cost Share Required Flag');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget_line` ALTER COLUMN `cost_subcategory` SET TAGS ('dbx_business_glossary_term' = 'Cost Subcategory');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget_line` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget_line` ALTER COLUMN `cumulative_expenditure` SET TAGS ('dbx_business_glossary_term' = 'Cumulative Expenditure to Date');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget_line` ALTER COLUMN `cumulative_expenditure_usd` SET TAGS ('dbx_business_glossary_term' = 'Cumulative Expenditure to Date (USD)');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget_line` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget_line` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget_line` ALTER COLUMN `award_budget_line_description` SET TAGS ('dbx_business_glossary_term' = 'Budget Line Description');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget_line` ALTER COLUMN `donor_reporting_category` SET TAGS ('dbx_business_glossary_term' = 'Donor Reporting Category');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget_line` ALTER COLUMN `exchange_rate` SET TAGS ('dbx_business_glossary_term' = 'Exchange Rate');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget_line` ALTER COLUMN `fiscal_period` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget_line` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget_line` ALTER COLUMN `fund_restriction_type` SET TAGS ('dbx_business_glossary_term' = 'Fund Restriction Type');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget_line` ALTER COLUMN `fund_restriction_type` SET TAGS ('dbx_value_regex' = 'unrestricted|temporarily_restricted|permanently_restricted');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget_line` ALTER COLUMN `gl_account_code` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Code');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget_line` ALTER COLUMN `indirect_cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Indirect Cost Amount');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget_line` ALTER COLUMN `item_code` SET TAGS ('dbx_business_glossary_term' = 'Budget Line Item Code');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget_line` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget_line` ALTER COLUMN `nicra_rate_applied` SET TAGS ('dbx_business_glossary_term' = 'Negotiated Indirect Cost Rate Agreement (NICRA) Rate Applied');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget_line` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Budget Line Notes');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget_line` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Quantity');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget_line` ALTER COLUMN `reasonableness_flag` SET TAGS ('dbx_business_glossary_term' = 'Reasonableness Flag');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget_line` ALTER COLUMN `revised_amount` SET TAGS ('dbx_business_glossary_term' = 'Revised Budget Amount');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget_line` ALTER COLUMN `revised_amount_usd` SET TAGS ('dbx_business_glossary_term' = 'Revised Budget Amount (USD)');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget_line` ALTER COLUMN `revision_date` SET TAGS ('dbx_business_glossary_term' = 'Budget Line Revision Date');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget_line` ALTER COLUMN `revision_reason` SET TAGS ('dbx_business_glossary_term' = 'Budget Revision Reason');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget_line` ALTER COLUMN `supporting_document_reference` SET TAGS ('dbx_business_glossary_term' = 'Supporting Document Reference');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget_line` ALTER COLUMN `unit_cost` SET TAGS ('dbx_business_glossary_term' = 'Unit Cost');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget_line` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget_line` ALTER COLUMN `variance_amount` SET TAGS ('dbx_business_glossary_term' = 'Budget Variance Amount');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget_line` ALTER COLUMN `variance_percentage` SET TAGS ('dbx_business_glossary_term' = 'Budget Variance Percentage');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget_line` ALTER COLUMN `variance_percentage` SET TAGS ('dbx_pii_demographic' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`amendment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_ngo_v1`.`grant`.`amendment` SET TAGS ('dbx_subdomain' = 'award_management');
ALTER TABLE `vibe_ngo_v1`.`grant`.`amendment` ALTER COLUMN `amendment_id` SET TAGS ('dbx_business_glossary_term' = 'Grant Amendment Identifier (ID)');
ALTER TABLE `vibe_ngo_v1`.`grant`.`amendment` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Partnership Agreement Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`grant`.`amendment` ALTER COLUMN `award_id` SET TAGS ('dbx_business_glossary_term' = 'Grant Identifier (ID)');
ALTER TABLE `vibe_ngo_v1`.`grant`.`amendment` ALTER COLUMN `country_office_id` SET TAGS ('dbx_business_glossary_term' = 'Country Office Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`grant`.`amendment` ALTER COLUMN `indicator_target_id` SET TAGS ('dbx_business_glossary_term' = 'Indicator Target Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`grant`.`amendment` ALTER COLUMN `mel_logframe_id` SET TAGS ('dbx_business_glossary_term' = 'Mel Logframe Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`grant`.`amendment` ALTER COLUMN `supersedes_amendment_grant_amendment_id` SET TAGS ('dbx_business_glossary_term' = 'Supersedes Amendment Identifier (ID)');
ALTER TABLE `vibe_ngo_v1`.`grant`.`amendment` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Amendment Approval Date');
ALTER TABLE `vibe_ngo_v1`.`grant`.`amendment` ALTER COLUMN `approved_by_name` SET TAGS ('dbx_business_glossary_term' = 'Approved By Name');
ALTER TABLE `vibe_ngo_v1`.`grant`.`amendment` ALTER COLUMN `approved_by_name` SET TAGS ('dbx_pii_personal' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`amendment` ALTER COLUMN `approved_by_title` SET TAGS ('dbx_business_glossary_term' = 'Approved By Title');
ALTER TABLE `vibe_ngo_v1`.`grant`.`amendment` ALTER COLUMN `budget_modification_summary` SET TAGS ('dbx_business_glossary_term' = 'Budget Modification Summary');
ALTER TABLE `vibe_ngo_v1`.`grant`.`amendment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_ngo_v1`.`grant`.`amendment` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_ngo_v1`.`grant`.`amendment` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_ngo_v1`.`grant`.`amendment` ALTER COLUMN `donor_approval_reference` SET TAGS ('dbx_business_glossary_term' = 'Donor Approval Reference Number');
ALTER TABLE `vibe_ngo_v1`.`grant`.`amendment` ALTER COLUMN `donor_prior_approval_required` SET TAGS ('dbx_business_glossary_term' = 'Donor Prior Approval Required Flag');
ALTER TABLE `vibe_ngo_v1`.`grant`.`amendment` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Amendment Effective Date');
ALTER TABLE `vibe_ngo_v1`.`grant`.`amendment` ALTER COLUMN `execution_date` SET TAGS ('dbx_business_glossary_term' = 'Amendment Execution Date');
ALTER TABLE `vibe_ngo_v1`.`grant`.`amendment` ALTER COLUMN `funding_change` SET TAGS ('dbx_business_glossary_term' = 'Amendment Funding Change Amount');
ALTER TABLE `vibe_ngo_v1`.`grant`.`amendment` ALTER COLUMN `geographic_change_description` SET TAGS ('dbx_business_glossary_term' = 'Geographic Change Description');
ALTER TABLE `vibe_ngo_v1`.`grant`.`amendment` ALTER COLUMN `grant_amendment_description` SET TAGS ('dbx_business_glossary_term' = 'Amendment Description');
ALTER TABLE `vibe_ngo_v1`.`grant`.`amendment` ALTER COLUMN `grant_amendment_status` SET TAGS ('dbx_business_glossary_term' = 'Amendment Status');
ALTER TABLE `vibe_ngo_v1`.`grant`.`amendment` ALTER COLUMN `grant_amendment_type` SET TAGS ('dbx_business_glossary_term' = 'Amendment Type');
ALTER TABLE `vibe_ngo_v1`.`grant`.`amendment` ALTER COLUMN `internal_approval_date` SET TAGS ('dbx_business_glossary_term' = 'Internal Approval Date');
ALTER TABLE `vibe_ngo_v1`.`grant`.`amendment` ALTER COLUMN `internal_approver_name` SET TAGS ('dbx_business_glossary_term' = 'Internal Approver Name');
ALTER TABLE `vibe_ngo_v1`.`grant`.`amendment` ALTER COLUMN `internal_approver_name` SET TAGS ('dbx_pii_personal' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`amendment` ALTER COLUMN `is_no_cost_extension` SET TAGS ('dbx_business_glossary_term' = 'No-Cost Extension Flag');
ALTER TABLE `vibe_ngo_v1`.`grant`.`amendment` ALTER COLUMN `justification` SET TAGS ('dbx_business_glossary_term' = 'Amendment Justification');
ALTER TABLE `vibe_ngo_v1`.`grant`.`amendment` ALTER COLUMN `key_personnel_change_description` SET TAGS ('dbx_business_glossary_term' = 'Key Personnel Change Description');
ALTER TABLE `vibe_ngo_v1`.`grant`.`amendment` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `vibe_ngo_v1`.`grant`.`amendment` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Amendment Notes');
ALTER TABLE `vibe_ngo_v1`.`grant`.`amendment` ALTER COLUMN `number` SET TAGS ('dbx_business_glossary_term' = 'Amendment Number');
ALTER TABLE `vibe_ngo_v1`.`grant`.`amendment` ALTER COLUMN `original_end_date` SET TAGS ('dbx_business_glossary_term' = 'Original Period of Performance (PoP) End Date');
ALTER TABLE `vibe_ngo_v1`.`grant`.`amendment` ALTER COLUMN `original_start_date` SET TAGS ('dbx_business_glossary_term' = 'Original Period of Performance (PoP) Start Date');
ALTER TABLE `vibe_ngo_v1`.`grant`.`amendment` ALTER COLUMN `original_total_obligation` SET TAGS ('dbx_business_glossary_term' = 'Original Total Obligation Amount');
ALTER TABLE `vibe_ngo_v1`.`grant`.`amendment` ALTER COLUMN `period_extension_days` SET TAGS ('dbx_business_glossary_term' = 'Period Extension Days');
ALTER TABLE `vibe_ngo_v1`.`grant`.`amendment` ALTER COLUMN `request_date` SET TAGS ('dbx_business_glossary_term' = 'Amendment Request Date');
ALTER TABLE `vibe_ngo_v1`.`grant`.`amendment` ALTER COLUMN `revised_end_date` SET TAGS ('dbx_business_glossary_term' = 'Revised Period of Performance (PoP) End Date');
ALTER TABLE `vibe_ngo_v1`.`grant`.`amendment` ALTER COLUMN `revised_start_date` SET TAGS ('dbx_business_glossary_term' = 'Revised Period of Performance (PoP) Start Date');
ALTER TABLE `vibe_ngo_v1`.`grant`.`amendment` ALTER COLUMN `revised_total_obligation` SET TAGS ('dbx_business_glossary_term' = 'Revised Total Obligation Amount');
ALTER TABLE `vibe_ngo_v1`.`grant`.`amendment` ALTER COLUMN `scope_change_description` SET TAGS ('dbx_business_glossary_term' = 'Scope Change Description');
ALTER TABLE `vibe_ngo_v1`.`grant`.`amendment` ALTER COLUMN `supporting_document_reference` SET TAGS ('dbx_business_glossary_term' = 'Supporting Document Reference');
ALTER TABLE `vibe_ngo_v1`.`grant`.`amendment` ALTER COLUMN `terms_and_conditions_change` SET TAGS ('dbx_business_glossary_term' = 'Terms and Conditions Change Description');
ALTER TABLE `vibe_ngo_v1`.`grant`.`subaward` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_ngo_v1`.`grant`.`subaward` SET TAGS ('dbx_subdomain' = 'award_management');
ALTER TABLE `vibe_ngo_v1`.`grant`.`subaward` ALTER COLUMN `subaward_id` SET TAGS ('dbx_business_glossary_term' = 'Subaward Identifier (ID)');
ALTER TABLE `vibe_ngo_v1`.`grant`.`subaward` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Partnership Agreement Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`grant`.`subaward` ALTER COLUMN `award_id` SET TAGS ('dbx_business_glossary_term' = 'Grant Identifier (ID)');
ALTER TABLE `vibe_ngo_v1`.`grant`.`subaward` ALTER COLUMN `capacity_assessment_id` SET TAGS ('dbx_business_glossary_term' = 'Capacity Assessment Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`grant`.`subaward` ALTER COLUMN `due_diligence_record_id` SET TAGS ('dbx_business_glossary_term' = 'Due Diligence Record Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`grant`.`subaward` ALTER COLUMN `intervention_id` SET TAGS ('dbx_business_glossary_term' = 'Program Identifier (ID)');
ALTER TABLE `vibe_ngo_v1`.`grant`.`subaward` ALTER COLUMN `partner_org_id` SET TAGS ('dbx_business_glossary_term' = 'Implementing Partner Identifier (ID)');
ALTER TABLE `vibe_ngo_v1`.`grant`.`subaward` ALTER COLUMN `project_site_id` SET TAGS ('dbx_business_glossary_term' = 'Project Site Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`grant`.`subaward` ALTER COLUMN `amendment_count` SET TAGS ('dbx_business_glossary_term' = 'Amendment Count');
ALTER TABLE `vibe_ngo_v1`.`grant`.`subaward` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_ngo_v1`.`grant`.`subaward` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `vibe_ngo_v1`.`grant`.`subaward` ALTER COLUMN `closeout_date` SET TAGS ('dbx_business_glossary_term' = 'Closeout Date');
ALTER TABLE `vibe_ngo_v1`.`grant`.`subaward` ALTER COLUMN `cost_share_amount` SET TAGS ('dbx_business_glossary_term' = 'Cost Share Amount');
ALTER TABLE `vibe_ngo_v1`.`grant`.`subaward` ALTER COLUMN `cost_share_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Cost Share Required Flag');
ALTER TABLE `vibe_ngo_v1`.`grant`.`subaward` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_ngo_v1`.`grant`.`subaward` ALTER COLUMN `currency` SET TAGS ('dbx_business_glossary_term' = 'Subaward Currency');
ALTER TABLE `vibe_ngo_v1`.`grant`.`subaward` ALTER COLUMN `currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_ngo_v1`.`grant`.`subaward` ALTER COLUMN `subaward_description` SET TAGS ('dbx_business_glossary_term' = 'Subaward Description');
ALTER TABLE `vibe_ngo_v1`.`grant`.`subaward` ALTER COLUMN `disbursed_amount` SET TAGS ('dbx_business_glossary_term' = 'Disbursed Amount');
ALTER TABLE `vibe_ngo_v1`.`grant`.`subaward` ALTER COLUMN `duns_number` SET TAGS ('dbx_business_glossary_term' = 'Data Universal Numbering System (DUNS) Number');
ALTER TABLE `vibe_ngo_v1`.`grant`.`subaward` ALTER COLUMN `duns_number` SET TAGS ('dbx_value_regex' = '^[0-9]{9}$');
ALTER TABLE `vibe_ngo_v1`.`grant`.`subaward` ALTER COLUMN `execution_date` SET TAGS ('dbx_business_glossary_term' = 'Execution Date');
ALTER TABLE `vibe_ngo_v1`.`grant`.`subaward` ALTER COLUMN `ffata_reporting_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Federal Funding Accountability and Transparency Act (FFATA) Reporting Required Flag');
ALTER TABLE `vibe_ngo_v1`.`grant`.`subaward` ALTER COLUMN `flow_down_requirements` SET TAGS ('dbx_business_glossary_term' = 'Flow-Down Requirements');
ALTER TABLE `vibe_ngo_v1`.`grant`.`subaward` ALTER COLUMN `fsrs_report_date` SET TAGS ('dbx_business_glossary_term' = 'FFATA Subaward Reporting System (FSRS) Report Date');
ALTER TABLE `vibe_ngo_v1`.`grant`.`subaward` ALTER COLUMN `fund_restriction_type` SET TAGS ('dbx_business_glossary_term' = 'Fund Restriction Type');
ALTER TABLE `vibe_ngo_v1`.`grant`.`subaward` ALTER COLUMN `fund_restriction_type` SET TAGS ('dbx_value_regex' = 'unrestricted|temporarily restricted|permanently restricted');
ALTER TABLE `vibe_ngo_v1`.`grant`.`subaward` ALTER COLUMN `indirect_cost_base` SET TAGS ('dbx_business_glossary_term' = 'Indirect Cost Base');
ALTER TABLE `vibe_ngo_v1`.`grant`.`subaward` ALTER COLUMN `indirect_cost_base` SET TAGS ('dbx_value_regex' = 'modified total direct costs|total direct costs|salaries and wages|other');
ALTER TABLE `vibe_ngo_v1`.`grant`.`subaward` ALTER COLUMN `indirect_cost_rate` SET TAGS ('dbx_business_glossary_term' = 'Indirect Cost Rate');
ALTER TABLE `vibe_ngo_v1`.`grant`.`subaward` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_ngo_v1`.`grant`.`subaward` ALTER COLUMN `monitoring_frequency` SET TAGS ('dbx_business_glossary_term' = 'Monitoring Frequency');
ALTER TABLE `vibe_ngo_v1`.`grant`.`subaward` ALTER COLUMN `monitoring_frequency` SET TAGS ('dbx_value_regex' = 'quarterly|semi-annually|annually|as-needed|continuous');
ALTER TABLE `vibe_ngo_v1`.`grant`.`subaward` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_ngo_v1`.`grant`.`subaward` ALTER COLUMN `number` SET TAGS ('dbx_business_glossary_term' = 'Subaward Number');
ALTER TABLE `vibe_ngo_v1`.`grant`.`subaward` ALTER COLUMN `obligated_amount` SET TAGS ('dbx_business_glossary_term' = 'Obligated Amount');
ALTER TABLE `vibe_ngo_v1`.`grant`.`subaward` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `vibe_ngo_v1`.`grant`.`subaward` ALTER COLUMN `payment_method` SET TAGS ('dbx_value_regex' = 'wire transfer|check|electronic funds transfer|advance|reimbursement|other');
ALTER TABLE `vibe_ngo_v1`.`grant`.`subaward` ALTER COLUMN `payment_schedule` SET TAGS ('dbx_business_glossary_term' = 'Payment Schedule');
ALTER TABLE `vibe_ngo_v1`.`grant`.`subaward` ALTER COLUMN `payment_schedule` SET TAGS ('dbx_value_regex' = 'advance|reimbursement|milestone-based|quarterly|monthly|other');
ALTER TABLE `vibe_ngo_v1`.`grant`.`subaward` ALTER COLUMN `period_of_performance_end_date` SET TAGS ('dbx_business_glossary_term' = 'Period of Performance (PoP) End Date');
ALTER TABLE `vibe_ngo_v1`.`grant`.`subaward` ALTER COLUMN `period_of_performance_start_date` SET TAGS ('dbx_business_glossary_term' = 'Period of Performance (PoP) Start Date');
ALTER TABLE `vibe_ngo_v1`.`grant`.`subaward` ALTER COLUMN `remaining_balance` SET TAGS ('dbx_business_glossary_term' = 'Remaining Balance');
ALTER TABLE `vibe_ngo_v1`.`grant`.`subaward` ALTER COLUMN `reporting_frequency` SET TAGS ('dbx_business_glossary_term' = 'Reporting Frequency');
ALTER TABLE `vibe_ngo_v1`.`grant`.`subaward` ALTER COLUMN `reporting_frequency` SET TAGS ('dbx_value_regex' = 'monthly|quarterly|semi-annually|annually|as-needed');
ALTER TABLE `vibe_ngo_v1`.`grant`.`subaward` ALTER COLUMN `risk_rating` SET TAGS ('dbx_business_glossary_term' = 'Risk Rating');
ALTER TABLE `vibe_ngo_v1`.`grant`.`subaward` ALTER COLUMN `risk_rating` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `vibe_ngo_v1`.`grant`.`subaward` ALTER COLUMN `single_audit_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Single Audit Required Flag');
ALTER TABLE `vibe_ngo_v1`.`grant`.`subaward` ALTER COLUMN `subaward_status` SET TAGS ('dbx_business_glossary_term' = 'Subaward Status');
ALTER TABLE `vibe_ngo_v1`.`grant`.`subaward` ALTER COLUMN `subaward_status` SET TAGS ('dbx_value_regex' = 'draft|pending approval|active|suspended|terminated|closed');
ALTER TABLE `vibe_ngo_v1`.`grant`.`subaward` ALTER COLUMN `subaward_type` SET TAGS ('dbx_business_glossary_term' = 'Subaward Type');
ALTER TABLE `vibe_ngo_v1`.`grant`.`subaward` ALTER COLUMN `subaward_type` SET TAGS ('dbx_value_regex' = 'sub-grant|subcontract|fixed-obligation grant|cooperative agreement|cost-reimbursable|other');
ALTER TABLE `vibe_ngo_v1`.`grant`.`subaward` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Termination Date');
ALTER TABLE `vibe_ngo_v1`.`grant`.`subaward` ALTER COLUMN `termination_reason` SET TAGS ('dbx_business_glossary_term' = 'Termination Reason');
ALTER TABLE `vibe_ngo_v1`.`grant`.`subaward` ALTER COLUMN `title` SET TAGS ('dbx_business_glossary_term' = 'Subaward Title');
ALTER TABLE `vibe_ngo_v1`.`grant`.`subaward` ALTER COLUMN `total_subaward_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Subaward Amount');
ALTER TABLE `vibe_ngo_v1`.`grant`.`subaward` ALTER COLUMN `total_subaward_amount_usd` SET TAGS ('dbx_business_glossary_term' = 'Total Subaward Amount United States Dollars (USD)');
ALTER TABLE `vibe_ngo_v1`.`grant`.`subaward` ALTER COLUMN `uei_number` SET TAGS ('dbx_business_glossary_term' = 'Unique Entity Identifier (UEI) Number');
ALTER TABLE `vibe_ngo_v1`.`grant`.`subaward` ALTER COLUMN `uei_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{12}$');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_condition` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_condition` SET TAGS ('dbx_subdomain' = 'budget_compliance');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_condition` ALTER COLUMN `donor_condition_id` SET TAGS ('dbx_business_glossary_term' = 'Donor Condition ID');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_condition` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Partnership Agreement Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_condition` ALTER COLUMN `award_id` SET TAGS ('dbx_business_glossary_term' = 'Grant ID');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_condition` ALTER COLUMN `constituent_id` SET TAGS ('dbx_business_glossary_term' = 'Donor ID');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_condition` ALTER COLUMN `country_office_id` SET TAGS ('dbx_business_glossary_term' = 'Country Office Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_condition` ALTER COLUMN `evaluation_id` SET TAGS ('dbx_business_glossary_term' = 'Evaluation Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_condition` ALTER COLUMN `indicator_id` SET TAGS ('dbx_business_glossary_term' = 'Indicator Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_condition` ALTER COLUMN `indicator_target_id` SET TAGS ('dbx_business_glossary_term' = 'Indicator Target Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_condition` ALTER COLUMN `mel_logframe_id` SET TAGS ('dbx_business_glossary_term' = 'Mel Logframe Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_condition` ALTER COLUMN `actual_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Completion Date');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_condition` ALTER COLUMN `approval_authority` SET TAGS ('dbx_business_glossary_term' = 'Approval Authority');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_condition` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_condition` ALTER COLUMN `approval_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Approval Reference Number');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_condition` ALTER COLUMN `donor_condition_category` SET TAGS ('dbx_business_glossary_term' = 'Condition Category');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_condition` ALTER COLUMN `donor_condition_category` SET TAGS ('dbx_value_regex' = 'financial|programmatic|administrative|compliance|safeguarding|environmental');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_condition` ALTER COLUMN `compliance_notes` SET TAGS ('dbx_business_glossary_term' = 'Compliance Notes');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_condition` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_condition` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'open|in_progress|met|waived|expired|overdue');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_condition` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_condition` ALTER COLUMN `deliverable_description` SET TAGS ('dbx_business_glossary_term' = 'Deliverable Description');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_condition` ALTER COLUMN `donor_condition_description` SET TAGS ('dbx_business_glossary_term' = 'Condition Description');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_condition` ALTER COLUMN `donor_condition_type` SET TAGS ('dbx_business_glossary_term' = 'Condition Type');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_condition` ALTER COLUMN `donor_condition_type` SET TAGS ('dbx_value_regex' = 'prior_approval_requirement|restricted_cost|reporting_obligation|key_personnel_approval|branding_marking_requirement|audit_requirement');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_condition` ALTER COLUMN `donor_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Donor Contact Email');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_condition` ALTER COLUMN `donor_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_condition` ALTER COLUMN `donor_contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_condition` ALTER COLUMN `donor_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_condition` ALTER COLUMN `donor_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Donor Contact Name');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_condition` ALTER COLUMN `donor_contact_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_condition` ALTER COLUMN `donor_contact_name` SET TAGS ('dbx_pii_personal' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_condition` ALTER COLUMN `due_date` SET TAGS ('dbx_business_glossary_term' = 'Due Date');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_condition` ALTER COLUMN `escalation_threshold_days` SET TAGS ('dbx_business_glossary_term' = 'Escalation Threshold Days');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_condition` ALTER COLUMN `financial_threshold_amount` SET TAGS ('dbx_business_glossary_term' = 'Financial Threshold Amount');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_condition` ALTER COLUMN `financial_threshold_currency` SET TAGS ('dbx_business_glossary_term' = 'Financial Threshold Currency');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_condition` ALTER COLUMN `financial_threshold_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_condition` ALTER COLUMN `is_special_award_condition` SET TAGS ('dbx_business_glossary_term' = 'Is Special Award Condition (SAC)');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_condition` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_condition` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Modified By');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_condition` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_condition` ALTER COLUMN `monitoring_frequency` SET TAGS ('dbx_business_glossary_term' = 'Monitoring Frequency');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_condition` ALTER COLUMN `monitoring_frequency` SET TAGS ('dbx_value_regex' = 'daily|weekly|monthly|quarterly|as_needed');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_condition` ALTER COLUMN `next_recurrence_date` SET TAGS ('dbx_business_glossary_term' = 'Next Recurrence Date');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_condition` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_condition` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Priority Level');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_condition` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_condition` ALTER COLUMN `recurrence_frequency` SET TAGS ('dbx_business_glossary_term' = 'Recurrence Frequency');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_condition` ALTER COLUMN `recurrence_frequency` SET TAGS ('dbx_value_regex' = 'one_time|monthly|quarterly|semi_annually|annually|as_needed');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_condition` ALTER COLUMN `reference_number` SET TAGS ('dbx_business_glossary_term' = 'Condition Reference Number');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_condition` ALTER COLUMN `regulatory_citation` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Citation');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_condition` ALTER COLUMN `responsible_department` SET TAGS ('dbx_business_glossary_term' = 'Responsible Department');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_condition` ALTER COLUMN `risk_rating` SET TAGS ('dbx_business_glossary_term' = 'Risk Rating');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_condition` ALTER COLUMN `risk_rating` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_condition` ALTER COLUMN `sac_justification` SET TAGS ('dbx_business_glossary_term' = 'Special Award Condition (SAC) Justification');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_condition` ALTER COLUMN `sac_justification` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_condition` ALTER COLUMN `supporting_document_reference` SET TAGS ('dbx_business_glossary_term' = 'Supporting Document Reference');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_condition` ALTER COLUMN `title` SET TAGS ('dbx_business_glossary_term' = 'Condition Title');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_condition` ALTER COLUMN `waiver_date` SET TAGS ('dbx_business_glossary_term' = 'Waiver Date');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_condition` ALTER COLUMN `waiver_justification` SET TAGS ('dbx_business_glossary_term' = 'Waiver Justification');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_condition` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_report` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_report` SET TAGS ('dbx_subdomain' = 'budget_compliance');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_report` ALTER COLUMN `donor_report_id` SET TAGS ('dbx_business_glossary_term' = 'Donor Report ID');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_report` ALTER COLUMN `award_id` SET TAGS ('dbx_business_glossary_term' = 'Grant ID');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_report` ALTER COLUMN `constituent_id` SET TAGS ('dbx_business_glossary_term' = 'Constituent Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_report` ALTER COLUMN `fund_id` SET TAGS ('dbx_business_glossary_term' = 'Donor Fund Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_report` ALTER COLUMN `intervention_id` SET TAGS ('dbx_business_glossary_term' = 'Intervention Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_report` ALTER COLUMN `meal_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Meal Plan Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_report` ALTER COLUMN `project_site_id` SET TAGS ('dbx_business_glossary_term' = 'Project Site Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_report` ALTER COLUMN `reporting_period_id` SET TAGS ('dbx_business_glossary_term' = 'Reporting Period Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_report` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Report Approval Date');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_report` ALTER COLUMN `audit_findings_count` SET TAGS ('dbx_business_glossary_term' = 'Audit Findings Count');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_report` ALTER COLUMN `beneficiaries_reached` SET TAGS ('dbx_business_glossary_term' = 'Beneficiaries Reached');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_report` ALTER COLUMN `budget_variance_amount` SET TAGS ('dbx_business_glossary_term' = 'Budget Variance Amount');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_report` ALTER COLUMN `budget_variance_percentage` SET TAGS ('dbx_business_glossary_term' = 'Budget Variance Percentage');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_report` ALTER COLUMN `budget_variance_percentage` SET TAGS ('dbx_pii_demographic' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_report` ALTER COLUMN `compliance_certification_flag` SET TAGS ('dbx_business_glossary_term' = 'Compliance Certification Flag');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_report` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_report` ALTER COLUMN `cumulative_expenditure_to_date` SET TAGS ('dbx_business_glossary_term' = 'Cumulative Expenditure To Date');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_report` ALTER COLUMN `days_overdue` SET TAGS ('dbx_business_glossary_term' = 'Days Overdue');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_report` ALTER COLUMN `donor_acceptance_date` SET TAGS ('dbx_business_glossary_term' = 'Donor Acceptance Date');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_report` ALTER COLUMN `donor_feedback_summary` SET TAGS ('dbx_business_glossary_term' = 'Donor Feedback Summary');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_report` ALTER COLUMN `donor_report_status` SET TAGS ('dbx_business_glossary_term' = 'Report Status');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_report` ALTER COLUMN `donor_report_type` SET TAGS ('dbx_business_glossary_term' = 'Report Type');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_report` ALTER COLUMN `donor_report_type` SET TAGS ('dbx_value_regex' = 'SF-425 Federal Financial Report|Quarterly Programmatic|Annual Narrative|SitRep|Final Report|IATI Disclosure');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_report` ALTER COLUMN `due_date` SET TAGS ('dbx_business_glossary_term' = 'Report Due Date');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_report` ALTER COLUMN `exchange_rate_used` SET TAGS ('dbx_business_glossary_term' = 'Exchange Rate Used');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_report` ALTER COLUMN `financial_amount_reported` SET TAGS ('dbx_business_glossary_term' = 'Financial Amount Reported');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_report` ALTER COLUMN `financial_amount_reported_usd` SET TAGS ('dbx_business_glossary_term' = 'Financial Amount Reported in United States Dollars (USD)');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_report` ALTER COLUMN `financial_currency` SET TAGS ('dbx_business_glossary_term' = 'Financial Currency Code');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_report` ALTER COLUMN `financial_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_report` ALTER COLUMN `is_final_version` SET TAGS ('dbx_business_glossary_term' = 'Is Final Version Flag');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_report` ALTER COLUMN `is_overdue` SET TAGS ('dbx_business_glossary_term' = 'Is Overdue Flag');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_report` ALTER COLUMN `key_performance_indicators_met` SET TAGS ('dbx_business_glossary_term' = 'Key Performance Indicators (KPI) Met');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_report` ALTER COLUMN `key_performance_indicators_total` SET TAGS ('dbx_business_glossary_term' = 'Total Key Performance Indicators (KPI)');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_report` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_report` ALTER COLUMN `narrative_summary` SET TAGS ('dbx_business_glossary_term' = 'Narrative Summary');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_report` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Report Notes');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_report` ALTER COLUMN `reference_number` SET TAGS ('dbx_business_glossary_term' = 'Report Reference Number');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_report` ALTER COLUMN `reporting_frequency` SET TAGS ('dbx_business_glossary_term' = 'Reporting Frequency');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_report` ALTER COLUMN `reporting_frequency` SET TAGS ('dbx_value_regex' = 'Monthly|Quarterly|Semi-Annual|Annual|Ad Hoc|Final');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_report` ALTER COLUMN `reporting_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Reporting Period End Date');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_report` ALTER COLUMN `reporting_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Reporting Period Start Date');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_report` ALTER COLUMN `revision_reason` SET TAGS ('dbx_business_glossary_term' = 'Revision Reason');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_report` ALTER COLUMN `revision_requested_date` SET TAGS ('dbx_business_glossary_term' = 'Revision Requested Date');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_report` ALTER COLUMN `submission_date` SET TAGS ('dbx_business_glossary_term' = 'Report Submission Date');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_report` ALTER COLUMN `submission_method` SET TAGS ('dbx_business_glossary_term' = 'Submission Method');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_report` ALTER COLUMN `submission_method` SET TAGS ('dbx_value_regex' = 'Email|Donor Portal|USAID ASIST|DFID ARIES|CERF Portal|Manual Upload');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_report` ALTER COLUMN `supporting_document_reference` SET TAGS ('dbx_business_glossary_term' = 'Supporting Document Reference');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_report` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Report Version Number');
ALTER TABLE `vibe_ngo_v1`.`grant`.`funding_source` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `vibe_ngo_v1`.`grant`.`funding_source` SET TAGS ('dbx_subdomain' = 'budget_compliance');
ALTER TABLE `vibe_ngo_v1`.`grant`.`funding_source` ALTER COLUMN `funding_source_id` SET TAGS ('dbx_business_glossary_term' = 'Funding Source ID');
ALTER TABLE `vibe_ngo_v1`.`grant`.`funding_source` ALTER COLUMN `partner_org_id` SET TAGS ('dbx_business_glossary_term' = 'Donor Organization ID');
ALTER TABLE `vibe_ngo_v1`.`grant`.`funding_source` ALTER COLUMN `advance_payment_allowed` SET TAGS ('dbx_business_glossary_term' = 'Advance Payment Allowed');
ALTER TABLE `vibe_ngo_v1`.`grant`.`funding_source` ALTER COLUMN `allowable_cost_categories` SET TAGS ('dbx_business_glossary_term' = 'Allowable Cost Categories');
ALTER TABLE `vibe_ngo_v1`.`grant`.`funding_source` ALTER COLUMN `audit_requirement` SET TAGS ('dbx_business_glossary_term' = 'Audit Requirement');
ALTER TABLE `vibe_ngo_v1`.`grant`.`funding_source` ALTER COLUMN `audit_requirement` SET TAGS ('dbx_value_regex' = 'single_audit|program_specific_audit|financial_audit|no_audit_required');
ALTER TABLE `vibe_ngo_v1`.`grant`.`funding_source` ALTER COLUMN `budget_flexibility` SET TAGS ('dbx_business_glossary_term' = 'Budget Flexibility');
ALTER TABLE `vibe_ngo_v1`.`grant`.`funding_source` ALTER COLUMN `budget_flexibility` SET TAGS ('dbx_value_regex' = 'fixed|flexible_within_categories|flexible_with_approval|fully_flexible');
ALTER TABLE `vibe_ngo_v1`.`grant`.`funding_source` ALTER COLUMN `budget_revision_threshold` SET TAGS ('dbx_business_glossary_term' = 'Budget Revision Threshold');
ALTER TABLE `vibe_ngo_v1`.`grant`.`funding_source` ALTER COLUMN `closeout_period_days` SET TAGS ('dbx_business_glossary_term' = 'Closeout Period Days');
ALTER TABLE `vibe_ngo_v1`.`grant`.`funding_source` ALTER COLUMN `funding_source_code` SET TAGS ('dbx_business_glossary_term' = 'Funding Source Code');
ALTER TABLE `vibe_ngo_v1`.`grant`.`funding_source` ALTER COLUMN `compliance_framework` SET TAGS ('dbx_business_glossary_term' = 'Compliance Framework');
ALTER TABLE `vibe_ngo_v1`.`grant`.`funding_source` ALTER COLUMN `contact_email` SET TAGS ('dbx_business_glossary_term' = 'Contact Email Address');
ALTER TABLE `vibe_ngo_v1`.`grant`.`funding_source` ALTER COLUMN `contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_ngo_v1`.`grant`.`funding_source` ALTER COLUMN `contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`funding_source` ALTER COLUMN `contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`funding_source` ALTER COLUMN `contact_person_name` SET TAGS ('dbx_business_glossary_term' = 'Contact Person Name');
ALTER TABLE `vibe_ngo_v1`.`grant`.`funding_source` ALTER COLUMN `contact_person_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`funding_source` ALTER COLUMN `contact_person_name` SET TAGS ('dbx_pii_personal' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`funding_source` ALTER COLUMN `contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Contact Phone Number');
ALTER TABLE `vibe_ngo_v1`.`grant`.`funding_source` ALTER COLUMN `contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`funding_source` ALTER COLUMN `contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`funding_source` ALTER COLUMN `cost_share_percentage` SET TAGS ('dbx_business_glossary_term' = 'Cost Share Percentage');
ALTER TABLE `vibe_ngo_v1`.`grant`.`funding_source` ALTER COLUMN `cost_share_percentage` SET TAGS ('dbx_pii_demographic' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`funding_source` ALTER COLUMN `cost_share_required` SET TAGS ('dbx_business_glossary_term' = 'Cost Share Required');
ALTER TABLE `vibe_ngo_v1`.`grant`.`funding_source` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_ngo_v1`.`grant`.`funding_source` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_ngo_v1`.`grant`.`funding_source` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_ngo_v1`.`grant`.`funding_source` ALTER COLUMN `funding_source_description` SET TAGS ('dbx_business_glossary_term' = 'Funding Source Description');
ALTER TABLE `vibe_ngo_v1`.`grant`.`funding_source` ALTER COLUMN `donor_reporting_frequency` SET TAGS ('dbx_business_glossary_term' = 'Donor Reporting Frequency');
ALTER TABLE `vibe_ngo_v1`.`grant`.`funding_source` ALTER COLUMN `donor_reporting_frequency` SET TAGS ('dbx_value_regex' = 'monthly|quarterly|semi_annually|annually|upon_request|milestone_based');
ALTER TABLE `vibe_ngo_v1`.`grant`.`funding_source` ALTER COLUMN `fund_restriction_type` SET TAGS ('dbx_business_glossary_term' = 'Fund Restriction Type');
ALTER TABLE `vibe_ngo_v1`.`grant`.`funding_source` ALTER COLUMN `fund_restriction_type` SET TAGS ('dbx_value_regex' = 'unrestricted|temporarily_restricted|permanently_restricted');
ALTER TABLE `vibe_ngo_v1`.`grant`.`funding_source` ALTER COLUMN `funding_end_date` SET TAGS ('dbx_business_glossary_term' = 'Funding End Date');
ALTER TABLE `vibe_ngo_v1`.`grant`.`funding_source` ALTER COLUMN `funding_mechanism_type` SET TAGS ('dbx_business_glossary_term' = 'Funding Mechanism Type');
ALTER TABLE `vibe_ngo_v1`.`grant`.`funding_source` ALTER COLUMN `funding_source_status` SET TAGS ('dbx_business_glossary_term' = 'Funding Source Status');
ALTER TABLE `vibe_ngo_v1`.`grant`.`funding_source` ALTER COLUMN `funding_source_status` SET TAGS ('dbx_value_regex' = 'active|suspended|closed|pending_activation|under_review');
ALTER TABLE `vibe_ngo_v1`.`grant`.`funding_source` ALTER COLUMN `funding_start_date` SET TAGS ('dbx_business_glossary_term' = 'Funding Start Date');
ALTER TABLE `vibe_ngo_v1`.`grant`.`funding_source` ALTER COLUMN `geographic_restriction` SET TAGS ('dbx_business_glossary_term' = 'Geographic Restriction');
ALTER TABLE `vibe_ngo_v1`.`grant`.`funding_source` ALTER COLUMN `iati_organization_identifier` SET TAGS ('dbx_business_glossary_term' = 'International Aid Transparency Initiative (IATI) Organization Identifier');
ALTER TABLE `vibe_ngo_v1`.`grant`.`funding_source` ALTER COLUMN `indirect_cost_rate_type` SET TAGS ('dbx_business_glossary_term' = 'Indirect Cost Rate (ICR) Type');
ALTER TABLE `vibe_ngo_v1`.`grant`.`funding_source` ALTER COLUMN `indirect_cost_rate_type` SET TAGS ('dbx_value_regex' = 'nicra|de_minimis|cost_reimbursement|fixed_rate|negotiated_rate');
ALTER TABLE `vibe_ngo_v1`.`grant`.`funding_source` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_ngo_v1`.`grant`.`funding_source` ALTER COLUMN `funding_source_name` SET TAGS ('dbx_business_glossary_term' = 'Funding Source Name');
ALTER TABLE `vibe_ngo_v1`.`grant`.`funding_source` ALTER COLUMN `funding_source_name` SET TAGS ('dbx_pii_personal' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`funding_source` ALTER COLUMN `nicra_rate` SET TAGS ('dbx_business_glossary_term' = 'Negotiated Indirect Cost Rate Agreement (NICRA) Rate');
ALTER TABLE `vibe_ngo_v1`.`grant`.`funding_source` ALTER COLUMN `oda_dac_classification` SET TAGS ('dbx_business_glossary_term' = 'Official Development Assistance (ODA) Development Assistance Committee (DAC) Classification');
ALTER TABLE `vibe_ngo_v1`.`grant`.`funding_source` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `vibe_ngo_v1`.`grant`.`funding_source` ALTER COLUMN `payment_method` SET TAGS ('dbx_value_regex' = 'wire_transfer|ach|check|letter_of_credit|direct_deposit|pooled_fund_transfer');
ALTER TABLE `vibe_ngo_v1`.`grant`.`funding_source` ALTER COLUMN `procurement_standards` SET TAGS ('dbx_business_glossary_term' = 'Procurement Standards');
ALTER TABLE `vibe_ngo_v1`.`grant`.`funding_source` ALTER COLUMN `program_income_treatment` SET TAGS ('dbx_business_glossary_term' = 'Program Income Treatment');
ALTER TABLE `vibe_ngo_v1`.`grant`.`funding_source` ALTER COLUMN `program_income_treatment` SET TAGS ('dbx_value_regex' = 'addition|deduction|cost_sharing|no_program_income');
ALTER TABLE `vibe_ngo_v1`.`grant`.`funding_source` ALTER COLUMN `program_income_treatment` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`funding_source` ALTER COLUMN `program_income_treatment` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`funding_source` ALTER COLUMN `program_income_treatment` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`funding_source` ALTER COLUMN `record_retention_years` SET TAGS ('dbx_business_glossary_term' = 'Record Retention Years');
ALTER TABLE `vibe_ngo_v1`.`grant`.`funding_source` ALTER COLUMN `sdg_alignment_codes` SET TAGS ('dbx_business_glossary_term' = 'Sustainable Development Goal (SDG) Alignment Codes');
ALTER TABLE `vibe_ngo_v1`.`grant`.`funding_source` ALTER COLUMN `subaward_allowed` SET TAGS ('dbx_business_glossary_term' = 'Subaward Allowed');
ALTER TABLE `vibe_ngo_v1`.`grant`.`funding_source` ALTER COLUMN `subaward_approval_required` SET TAGS ('dbx_business_glossary_term' = 'Subaward Approval Required');
ALTER TABLE `vibe_ngo_v1`.`grant`.`funding_source` ALTER COLUMN `thematic_restriction` SET TAGS ('dbx_business_glossary_term' = 'Thematic Restriction');
ALTER TABLE `vibe_ngo_v1`.`grant`.`funding_source` ALTER COLUMN `total_funding_available` SET TAGS ('dbx_business_glossary_term' = 'Total Funding Available');
ALTER TABLE `vibe_ngo_v1`.`grant`.`funding_source` ALTER COLUMN `unallowable_cost_categories` SET TAGS ('dbx_business_glossary_term' = 'Unallowable Cost Categories');
