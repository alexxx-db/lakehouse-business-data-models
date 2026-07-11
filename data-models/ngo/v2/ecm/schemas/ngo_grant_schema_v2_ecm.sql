-- Schema for Domain: grant | Business:  | Version: v2_ecm
-- Generated on: 2026-07-10 18:48:25

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_ngo_v1`.`grant` COMMENT 'Authoritative domain for all grant awards, funding agreements, and donor contracts. Manages grant lifecycle from proposal development and submission through award, amendment, budget tracking, compliance, and closeout. Tracks donor conditions, restricted vs. unrestricted funding, NICRA/ICR rates, and compliance obligations under USAID, BHA, DFID, CERF, and OMB Uniform Guidance 2 CFR 200.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_ngo_v1`.`grant`.`sub_award_disbursement` (
    `sub_award_disbursement_id` BIGINT COMMENT 'Unique system-generated identifier for each sub-award disbursement transaction record in the grant management system.',
    `award_id` BIGINT COMMENT 'Reference to the prime grant award from which this sub-award disbursement is funded. Enables Budget vs. Actual (BvA) tracking at the prime award level.',
    `budget_line_id` BIGINT COMMENT 'Reference to the specific approved budget line item within the sub-award budget against which this disbursement is charged. Enables granular Budget vs. Actual (BvA) variance analysis at the budget line level.',
    `component_id` BIGINT COMMENT 'Reference to the program or project under which this sub-award disbursement is executed. Enables program-level Budget vs. Actual (BvA) tracking and Monitoring, Evaluation, and Learning (MEL) linkage.',
    `partner_org_id` BIGINT COMMENT 'Reference to the sub-recipient organization (Community-Based Organization, Civil Society Organization, or other implementing partner) receiving this disbursement.',
    `subaward_id` BIGINT COMMENT 'Reference to the parent sub-award agreement under which this disbursement is made. Links the disbursement to the specific sub-award instrument and implementing partner.',
    `advance_balance_outstanding` DECIMAL(18,2) COMMENT 'Remaining unliquidated advance balance owed by the implementing partner at the time of this disbursement record. Calculated as cumulative advances disbursed minus cumulative liquidations submitted. Supports 2 CFR 200.305 advance payment monitoring and cash management.',
    `amount` DECIMAL(18,2) COMMENT 'Gross amount disbursed to the implementing partner in the transaction currency. Used as the primary monetary value for Budget vs. Actual (BvA) tracking at the sub-award level.',
    `amount_usd` DECIMAL(18,2) COMMENT 'Disbursement amount converted to US Dollars (USD) using the applied exchange rate. Used for consolidated Budget vs. Actual (BvA) reporting, donor financial reports, and NICRA/Indirect Cost Rate (ICR) calculations across multi-currency sub-awards.',
    `approval_date` DATE COMMENT 'Date on which the authorized approver (grants manager, finance director, or designated authority) formally approved the disbursement request for payment processing.',
    `approved_by` STRING COMMENT 'Name or identifier of the authorized staff member (grants manager, finance director, or country director) who approved this disbursement. Required for audit trail and segregation of duties compliance.',
    `bank_transfer_reference` STRING COMMENT 'Bank-issued or payment-system-issued reference number for the wire transfer, EFT, or mobile money transaction. Used for bank reconciliation, audit trail, and confirmation of funds receipt by the implementing partner.',
    `cost_category` STRING COMMENT 'Budget cost category classification for this disbursement per the approved sub-award budget. Supports Budget vs. Actual (BvA) analysis by cost line and compliance with donor-approved budget categories under OMB Uniform Guidance.. Valid values are `direct_program|indirect_admin|capital_equipment|travel|personnel|other`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this disbursement record was first created in the Grant Management System (GMS) or Unit4 ERP. Provides the audit trail creation marker required under OMB Uniform Guidance record retention requirements.',
    `currency` STRING COMMENT 'ISO 4217 three-letter currency code of the currency in which the disbursement was made to the implementing partner (e.g., USD, EUR, KES, NGN). Supports multi-currency operations in international humanitarian programs.. Valid values are `^[A-Z]{3}$`',
    `sub_award_disbursement_date` DATE COMMENT 'Actual date on which funds were transferred to the implementing partners bank account or mobile money wallet. This is the principal business event date for Budget vs. Actual (BvA) reporting and cash flow tracking.',
    `donor_reporting_category` STRING COMMENT 'Donor-specific budget category or expenditure classification code required for financial reporting to the prime donor (e.g., USAID, BHA, DFID, CERF). Maps the disbursement to the donors chart of accounts or budget template for Financial Report (SF-425) or equivalent submission. [ENUM-REF-CANDIDATE: promote to reference product as values vary by donor]',
    `exchange_rate` DECIMAL(18,2) COMMENT 'Foreign currency exchange rate applied to convert the disbursement amount from the transaction currency to the base reporting currency (typically USD) at the time of disbursement. Essential for consolidated financial reporting and donor reporting under USAID, BHA, and DFID requirements.',
    `fiscal_period` STRING COMMENT 'Fiscal accounting period (month number 1–12 within the fiscal year) in which this disbursement is posted to the General Ledger. Supports period-level Budget vs. Actual (BvA) reporting and cash flow forecasting.',
    `fiscal_year` STRING COMMENT 'Fiscal year in which this disbursement is recorded for financial reporting purposes. Used for annual financial statement preparation, donor reporting, and compliance with FASB ASC 958 and OMB Uniform Guidance reporting periods.',
    `fund_restriction_type` STRING COMMENT 'Indicates whether the disbursed funds are donor-restricted (for a specific purpose or time period), temporarily restricted, or unrestricted. Critical for fund accounting compliance under FASB ASC 958 and donor stewardship reporting.. Valid values are `restricted|unrestricted|temporarily_restricted`',
    `gl_account_code` STRING COMMENT 'Chart of Accounts (CoA) code in the General Ledger (GL) to which this disbursement is posted. Enables fund accounting, restricted vs. unrestricted fund tracking, and financial statement preparation per FASB ASC 958.',
    `indirect_cost_amount` DECIMAL(18,2) COMMENT 'Calculated indirect cost (Facilities and Administration / F&A) amount included in or associated with this disbursement, based on the NICRA rate applied to the direct cost base. Supports compliance with OMB Uniform Guidance 2 CFR 200.414 and donor budget monitoring.',
    `is_emergency_disbursement` BOOLEAN COMMENT 'Indicates whether this disbursement was processed as an emergency or expedited payment outside the standard approval workflow, such as for rapid-onset disaster response under CERF or BHA emergency funding mechanisms.',
    `liquidated_amount` DECIMAL(18,2) COMMENT 'Amount of the advance disbursement that has been accounted for through submission of eligible expenditure documentation by the implementing partner. The difference between disbursement_amount and liquidated_amount represents the outstanding advance balance.',
    `liquidation_date` DATE COMMENT 'Actual date on which the implementing partner submitted the expenditure documentation or financial report fully accounting for the advance disbursement. Null if liquidation is pending or not yet completed.',
    `liquidation_deadline` DATE COMMENT 'Contractual deadline by which the implementing partner must submit expenditure documentation (financial report or liquidation report) to account for advance funds disbursed. Compliance with this date is required under 2 CFR 200.305.',
    `liquidation_status` STRING COMMENT 'Current status of the liquidation (financial accountability reporting) for this advance disbursement. Tracks whether the implementing partner has submitted expenditure documentation to account for advanced funds per 2 CFR 200.305 requirements.. Valid values are `not_required|pending|partial|fully_liquidated|overdue`',
    `method` STRING COMMENT 'Mechanism by which funds are transferred to the implementing partner. Includes wire transfer for international bank transfers, mobile money for field-based digital payments (e.g., M-Pesa), check, cash for remote/emergency contexts, and electronic funds transfer (EFT) for domestic payments.. Valid values are `wire_transfer|mobile_money|check|cash|eft`',
    `net_disbursement_amount` DECIMAL(18,2) COMMENT 'Actual net amount transferred to the implementing partner after deducting any withholding amounts from the gross disbursement amount. This is the amount reflected in the bank transfer instruction.',
    `nicra_rate_applied` DECIMAL(18,2) COMMENT 'Indirect Cost Rate (ICR) percentage applied to this disbursement per the implementing partners Negotiated Indirect Cost Rate Agreement (NICRA) or approved Facilities and Administration (F&A) rate. Used to calculate allowable indirect costs charged to the sub-award.',
    `notes` STRING COMMENT 'Free-text field for grants staff to record contextual notes, special conditions, or explanations related to this disbursement, such as reasons for partial payment, exchange rate justification, or emergency authorization rationale.',
    `payment_terms` STRING COMMENT 'Contractual payment terms governing when and how disbursements are made under the sub-award, such as immediate advance, net-30 reimbursement, milestone-based release, or payment upon liquidation of prior advance.. Valid values are `immediate|net_15|net_30|milestone_based|upon_liquidation`',
    `post_distribution_monitoring_ref` STRING COMMENT 'Reference identifier linking this disbursement to a Post-Distribution Monitoring (PDM) exercise conducted to verify that funds reached intended beneficiaries and were used for approved purposes. Supports accountability and learning under the Core Humanitarian Standard (CHS).',
    `reference_number` STRING COMMENT 'Externally-known unique alphanumeric reference number assigned to this disbursement transaction, used in bank transfer instructions, financial records, and audit trails. Corresponds to the payment reference in SAP S/4HANA Accounts Payable.. Valid values are `^[A-Z0-9-]{5,30}$`',
    `request_date` DATE COMMENT 'Date on which the implementing partner submitted the disbursement request or the grants team initiated the payment request. Marks the start of the disbursement approval workflow.',
    `sub_award_disbursement_status` STRING COMMENT 'Current lifecycle state of the disbursement transaction. Tracks progression from draft request through approval, actual disbursement, and final liquidation or cancellation. Drives workflow routing in the Grant Management System (GMS).. Valid values are `draft|pending_approval|approved|disbursed|liquidated|cancelled`',
    `supporting_document_reference` STRING COMMENT 'Reference identifier or URL to the supporting documentation package for this disbursement, including disbursement request form, bank transfer confirmation, financial report, or liquidation report stored in the document management system.',
    `tranche_number` STRING COMMENT 'Sequential tranche number identifying this disbursement within the overall sub-award payment schedule. Enables tracking of phased funding releases against milestone-based or time-based disbursement plans.',
    `sub_award_disbursement_type` STRING COMMENT 'Classification of the disbursement as an advance payment to the sub-recipient prior to expenditure, a reimbursement for costs already incurred, a direct payment to a third-party vendor on behalf of the sub-recipient, or a letter-of-credit drawdown. Governs compliance with 2 CFR 200.305 advance payment requirements.. Valid values are `advance|reimbursement|direct_payment|letter_of_credit`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to this disbursement record in the source system. Supports data lineage tracking, change detection in the Databricks Silver Layer, and audit compliance under OMB Uniform Guidance.',
    `withholding_amount` DECIMAL(18,2) COMMENT 'Amount withheld from the gross disbursement (e.g., performance-based retention, tax withholding, or compliance hold) before net transfer to the implementing partner. Null or zero if no withholding applies.',
    CONSTRAINT pk_sub_award_disbursement PRIMARY KEY(`sub_award_disbursement_id`)
) COMMENT 'Transactional record for individual fund disbursements made to sub-award implementing partners. Captures disbursement request date, approval date, disbursement amount, currency, exchange rate (for multi-currency operations), disbursement method (wire transfer, mobile money, check), bank transfer reference, advance vs. reimbursement classification, tranche number, liquidation status, liquidation deadline, outstanding advance balance, and supporting documentation reference. Enables BvA (Budget vs. Actual) tracking at the sub-award level and supports 2 CFR 200.305 advance payment requirements.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`grant`.`award` (
    `award_id` BIGINT COMMENT 'Unique identifier for the grant award record. Primary key for the award entity.',
    `constituent_id` BIGINT COMMENT 'Reference to the institutional donor or funding agency that issued this award (USAID, BHA, DFID, CERF, UN agencies, foundations, corporates).',
    `country_office_id` BIGINT COMMENT 'Foreign key linking to field.country_office. Business justification: Awards are managed and implemented by country offices. Core to operational structure, financial management, country-level portfolio analysis, compliance oversight, and donor relationship management at',
    `intervention_id` BIGINT COMMENT 'FK to program.intervention.intervention_id — MUST-HAVE: Cannot link grants to the programs they fund without this join. Essential for BvA reporting, donor reporting, and program-grant traceability.',
    `advance_payment_allowed` BOOLEAN COMMENT 'Indicates whether the donor allows advance payments or if reimbursement-only is required.',
    `agreement_signed_date` DATE COMMENT 'The date on which the award agreement was signed by both the donor and the NGO.',
    `amendment_count` STRING COMMENT 'The total number of amendments or modifications made to the original award agreement.',
    `audit_required` BOOLEAN COMMENT 'Indicates whether the award requires a specific audit (e.g., A-133 single audit, donor-specific audit).',
    `audit_threshold_amount` DECIMAL(18,2) COMMENT 'The expenditure threshold that triggers audit requirements under this award.',
    `authorized_amount` DECIMAL(18,2) COMMENT 'The maximum amount authorized for expenditure under this award, which may differ from the obligated amount due to amendments or modifications.',
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
    `fund_restriction_type` STRING COMMENT 'Classification of the award funds as unrestricted, temporarily restricted, or permanently restricted per ASC 958 accounting standards.. Valid values are `unrestricted|temporarily_restricted|permanently_restricted`',
    `funding_mechanism` STRING COMMENT 'The specific funding instrument or mechanism used by the donor (e.g., bilateral grant, multilateral pooled fund, emergency response fund).',
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
    `primary_country_code` STRING COMMENT 'The three-letter ISO 3166-1 alpha-3 country code for the primary country of implementation.. Valid values are `^[A-Z]{3}$`',
    `regulatory_framework` STRING COMMENT 'The applicable regulatory framework governing this award (e.g., 2 CFR 200, USAID ADS, DFID Smart Rules, UN Financial Regulations).',
    `reporting_frequency` STRING COMMENT 'The frequency at which financial and programmatic reports must be submitted to the donor.. Valid values are `monthly|quarterly|semi_annual|annual|final_only`',
    `sdg_alignment` STRING COMMENT 'The primary UN Sustainable Development Goal(s) that this award contributes to.',
    `special_conditions` STRING COMMENT 'Any special conditions, restrictions, or requirements imposed by the donor on this award.',
    `start_date` DATE COMMENT 'The official start date of the award period of performance as specified in the award agreement.',
    `award_status` STRING COMMENT 'Current lifecycle status of the award: pipeline (anticipated), active (in execution), no-cost extension (extended without additional funds), suspended, or closed.. Valid values are `pipeline|active|no_cost_extension|suspended|closed`',
    `thematic_sector` STRING COMMENT 'The primary thematic sector or focus area of the award (e.g., WASH, health, education, protection, food security).',
    `title` STRING COMMENT 'The official title or name of the grant award as stated in the award agreement.',
    `total_obligated_amount` DECIMAL(18,2) COMMENT 'The total amount of funds obligated by the donor under this award in the award currency.',
    `total_obligated_amount_functional` DECIMAL(18,2) COMMENT 'The total obligated amount converted to the NGOs functional currency using the exchange rate.',
    `award_type` STRING COMMENT 'The classification of the funding mechanism: cooperative agreement, contract, grant, sub-award, consortium lead, or consortium member.. Valid values are `cooperative_agreement|contract|grant|sub_award|consortium_lead|consortium_member`',
    CONSTRAINT pk_award PRIMARY KEY(`award_id`)
) COMMENT 'Master record for each grant award received by the NGO from institutional donors (USAID, BHA, DFID, CERF, UN agencies, foundations, corporates). Captures the full grant lifecycle from award notification through closeout. Stores award number, title, donor reference, award type (cooperative agreement, contract, grant, sub-award, consortium lead, consortium member), total obligated amount in award currency with exchange rate to functional currency, authorized amount, start and end dates, period of performance, award status (pipeline, active, no-cost extension, closed), funding mechanism, geographic scope, thematic sector, applicable regulatory framework (2 CFR 200, USAID ADS, DFID Smart Rules), NICRA/ICR rate reference, restricted vs. unrestricted classification, indirect cost ceiling, and program linkage allocations with funding percentages. SSOT for all grant award identity in the NGO.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`grant`.`proposal` (
    `proposal_id` BIGINT COMMENT 'Unique identifier for the grant proposal or concept note submission. Primary key for the proposal data product.',
    `award_id` BIGINT COMMENT 'Reference to the resulting grant award entity if this proposal was successful. Links the proposal to the executed grant agreement for lifecycle tracking.',
    `component_id` BIGINT COMMENT 'Reference to the program or thematic area this proposal supports. Links to the program master entity for strategic alignment tracking.',
    `constituent_id` BIGINT COMMENT 'Reference to the donor organization or funding body to whom this proposal is submitted. Links to the donor master entity.',
    `country_office_id` BIGINT COMMENT 'Foreign key linking to field.country_office. Business justification: Proposals are prepared and submitted by country offices. Fundamental for tracking BD pipeline by geography, country-level win rates, proposal workload management, and resource allocation for proposal ',
    `intervention_id` BIGINT COMMENT 'Foreign key linking to program.intervention. Business justification: Proposals that win awards result in specific interventions. Essential for business development learning, proposal effectiveness tracking, and win/loss analysis. Tracks which proposal led to which impl',
    `mel_logframe_id` BIGINT COMMENT 'Foreign key linking to mel.mel_logframe. Business justification: Proposals reference donor-mandated logframes during design phase. Proposal writers must align technical approach with donors results framework and indicator requirements specified in RFP logframe tem',
    `solicitation_id` BIGINT COMMENT 'Reference to the donor solicitation or funding opportunity this proposal responds to. Links to the solicitation entity for RFA, RFP, NOFO tracking. Null for unsolicited proposals.',
    `award_notification_date` DATE COMMENT 'Date the organization was officially notified of the award decision by the donor. Null if proposal was not awarded or decision is still pending.',
    `business_development_owner` STRING COMMENT 'Name or identifier of the business development staff member responsible for managing this proposal opportunity and donor relationship.',
    `compliance_review_completed` BOOLEAN COMMENT 'Boolean flag indicating whether compliance and risk review was completed before submission. Ensures adherence to donor regulations and organizational policies.',
    `consortium_lead_organization` STRING COMMENT 'Name of the lead organization if this proposal is part of a consortium or joint application. Null if organization is the prime or applying solo.',
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
    `proposed_duration_months` STRING COMMENT 'Total duration of the proposed project period of performance expressed in months. Calculated from proposed start and end dates.',
    `proposed_end_date` DATE COMMENT 'Proposed end date for the period of performance if the grant is awarded. Marks the conclusion of the planned implementation timeline.',
    `proposed_start_date` DATE COMMENT 'Proposed start date for the period of performance if the grant is awarded. Marks the beginning of the planned implementation timeline.',
    `reference_number` STRING COMMENT 'Externally-known unique reference number or code assigned to this proposal for tracking and communication with the donor. May include organizational prefix and year.',
    `rejection_reason` STRING COMMENT 'Primary reason provided by the donor for proposal rejection, or internal assessment of why the proposal was not successful. Used for lessons learned and win-rate improvement analysis.',
    `requested_amount` DECIMAL(18,2) COMMENT 'Total funding amount requested from the donor in the proposal currency. Represents the gross budget request before any donor adjustments or negotiations.',
    `requested_amount_usd` DECIMAL(18,2) COMMENT 'Total funding amount requested converted to USD using the exchange rate at submission date. Enables cross-proposal comparison and pipeline analysis in a common currency.',
    `requested_currency` STRING COMMENT 'Three-letter ISO 4217 currency code for the requested funding amount (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `proposal_status` STRING COMMENT 'Current lifecycle status of the proposal. Tracks progression from draft through internal review, submission, donor review, shortlisting, and final outcome (awarded, rejected, or withdrawn). [ENUM-REF-CANDIDATE: draft|internal_review|submitted|under_review|shortlisted|awarded|rejected|withdrawn — 8 candidates stripped; promote to reference product]',
    `submission_date` DATE COMMENT 'Date the proposal was officially submitted to the donor or funding body. Represents the principal business event timestamp for this transaction.',
    `target_beneficiary_count` STRING COMMENT 'Estimated number of direct beneficiaries the proposed project aims to reach. Used for cost-per-beneficiary analysis and impact projections.',
    `technical_approach_summary` STRING COMMENT 'High-level summary of the proposed technical approach, methodology, and intervention strategy. Captures key elements of the Theory of Change (ToC) and implementation plan.',
    `title` STRING COMMENT 'Full title of the grant proposal or concept note as submitted to the donor. Describes the proposed intervention or project.',
    `proposal_type` STRING COMMENT 'Classification of the proposal submission format and stage. Indicates whether this is a full application, concept note, expression of interest, unsolicited submission, pre-proposal, or letter of inquiry.. Valid values are `full_application|concept_note|expression_of_interest|unsolicited|pre_proposal|letter_of_inquiry`',
    `win_loss_outcome` STRING COMMENT 'Final outcome of the proposal submission. Indicates whether the proposal was won (awarded), lost (rejected), is still pending donor decision, or was withdrawn by the organization.. Valid values are `won|lost|pending|withdrawn`',
    CONSTRAINT pk_proposal PRIMARY KEY(`proposal_id`)
) COMMENT 'Tracks each grant proposal or concept note submitted to a donor or funding body in response to a solicitation or as an unsolicited submission. Captures proposal title, submission date, donor solicitation reference (RFA, RFP, NOFO number), proposal type (full application, concept note, expression of interest, unsolicited), requested amount and currency, proposed period of performance, lead technical sector, proposal status (draft, internal review, submitted, under review, shortlisted, awarded, rejected, withdrawn), win/loss outcome, cost proposal summary, technical approach summary, and linkage to the resulting award if successful. Supports pipeline management, go/no-go decision tracking, win-rate analysis, and strategic business development. Each proposal references the solicitation it responds to (except unsolicited proposals).';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`grant`.`award_budget` (
    `award_budget_id` BIGINT COMMENT 'Unique identifier for the award budget record. Primary key.',
    `award_id` BIGINT COMMENT 'Reference to the parent grant award for which this budget is defined.',
    `budget_id` BIGINT COMMENT 'Foreign key linking to finance.budget. Business justification: Grant award budgets must integrate with finance budget records for consolidated financial planning, variance analysis, and donor financial reporting. Nonprofits maintain both grant-specific budget str',
    `grant_amendment_id` BIGINT COMMENT 'Foreign key linking to grant.grant_amendment. Business justification: Budget revisions are often triggered by grant amendments. award_budget has is_amendment flag, amendment_date, and amendment_reason, but no FK to the actual amendment record. Adding amendment_id links ',
    `nicra_agreement_id` BIGINT COMMENT 'Foreign key linking to compliance.nicra_agreement. Business justification: Award budget preparation applies indirect cost rates from NICRA agreements. Budget officers must reference the applicable NICRA to calculate indirect costs correctly. Essential for budget development ',
    `approved_by` STRING COMMENT 'Name or identifier of the internal authority (e.g., Finance Director, Executive Director) who approved this budget for submission to the donor.',
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
    `other_direct_costs` DECIMAL(18,2) COMMENT 'Approved budget for other direct costs not classified in standard categories (e.g., communications, rent, utilities, participant support costs).',
    `period` STRING COMMENT 'The budget period this budget covers, typically expressed as Year 1, Year 2, etc., or Period 1, Period 2, etc., or Full Award Period for multi-year consolidated budgets.. Valid values are `^(Year [1-9]|Year [1-9][0-9]|Period [1-9]|Period [1-9][0-9]|Full Award Period)$`',
    `period_end_date` DATE COMMENT 'The end date of the budget period covered by this budget.',
    `period_start_date` DATE COMMENT 'The start date of the budget period covered by this budget.',
    `personnel_costs` DECIMAL(18,2) COMMENT 'Approved budget for salaries and wages of staff directly working on the grant.',
    `prepared_by` STRING COMMENT 'Name or identifier of the staff member who prepared this budget version.',
    `award_budget_status` STRING COMMENT 'Current lifecycle status of the budget. Draft indicates internal preparation; Submitted indicates sent to donor; Under Review indicates donor is reviewing; Approved indicates donor has approved; Amended indicates a revision has been made; Superseded indicates replaced by a newer version; Closed indicates budget period has ended. [ENUM-REF-CANDIDATE: draft|submitted|under_review|approved|amended|superseded|closed — 7 candidates stripped; promote to reference product]',
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
    `budget_line_id` BIGINT COMMENT 'Foreign key linking to finance.budget_line. Business justification: Award budget line items must link to finance budget lines for detailed expenditure tracking, budget-to-actual variance reporting, and grant financial statement preparation. Nonprofits track grant budg',
    `indicator_id` BIGINT COMMENT 'Foreign key linking to mel.indicator. Business justification: Budget lines allocate resources to indicator data collection activities. MEL budget lines (surveys, assessments, evaluations) are directly tied to specific indicators they measure, enabling cost-per-i',
    `intervention_id` BIGINT COMMENT 'Foreign key linking to program.intervention. Business justification: Award budget lines must map to specific program interventions for cost allocation, financial reporting, and budget vs. actual analysis. Essential for donor financial reports requiring intervention-lev',
    `position_id` BIGINT COMMENT 'Foreign key linking to workforce.position. Business justification: NGOs allocate grant budget lines to specific authorized positions for personnel cost tracking, effort certification, and donor reporting on staffing costs. Essential for grant budget execution and com',
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

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`grant`.`grant_amendment` (
    `grant_amendment_id` BIGINT COMMENT 'Unique identifier for the grant amendment record. Primary key for the grant_amendment data product.',
    `award_id` BIGINT COMMENT 'Reference to the parent grant award that this amendment modifies. Links to the original grant agreement.',
    `indicator_target_id` BIGINT COMMENT 'Foreign key linking to mel.indicator_target. Business justification: Amendments adjust indicator targets when period of performance, budget, or scope changes. Target revisions require donor prior approval, and amendment documents must specify which indicator targets ar',
    `mel_logframe_id` BIGINT COMMENT 'Foreign key linking to mel.mel_logframe. Business justification: Amendments revise logframes when scope, geography, or results chain changes. Formal amendments update intervention logic, assumptions, and indicator hierarchies in donor-approved logframe, requiring v',
    `supersedes_amendment_grant_amendment_id` BIGINT COMMENT 'Reference to a previous amendment that this amendment supersedes or replaces. Used to track amendment version history.',
    `approval_date` DATE COMMENT 'Date when the donor or funding agency officially approved the amendment request.',
    `approved_by_name` STRING COMMENT 'Name of the donor agency official or grants officer who approved this amendment.',
    `approved_by_title` STRING COMMENT 'Title or position of the donor agency official who approved this amendment (e.g., Grants Officer, Agreement Officer, Program Officer).',
    `budget_modification_summary` STRING COMMENT 'Summary of budget line item changes resulting from this amendment. Describes reallocations, increases, or decreases across cost categories.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this amendment record was first created in the system. Audit trail field for data lineage.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts in this amendment (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `grant_amendment_description` STRING COMMENT 'Detailed narrative description of the changes introduced by this amendment. Explains the rationale, scope, and impact of the modification.',
    `donor_approval_reference` STRING COMMENT 'External reference number or document identifier provided by the donor agency confirming approval of the amendment (e.g., USAID approval memo number, BHA authorization code).',
    `donor_prior_approval_required` BOOLEAN COMMENT 'Indicates whether this amendment required formal prior approval from the donor agency before implementation, as mandated by OMB Uniform Guidance 2 CFR 200.308.',
    `effective_date` DATE COMMENT 'Date from which the amendment terms become effective. May differ from execution date if the amendment is retroactive or has a future effective date.',
    `execution_date` DATE COMMENT 'Date when the amendment was fully executed and became legally binding. This is the principal business event timestamp for the amendment.',
    `funding_change` DECIMAL(18,2) COMMENT 'Net change in funding resulting from this amendment. Positive values indicate funding increases, negative values indicate decreases. Zero for non-financial amendments.',
    `geographic_change_description` STRING COMMENT 'Description of any changes to the geographic coverage or implementation locations resulting from this amendment (e.g., expansion to new regions, closure of field sites).',
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
    `grant_amendment_status` STRING COMMENT 'Current lifecycle status of the amendment. Tracks the amendment from initial drafting through donor approval and execution. [ENUM-REF-CANDIDATE: draft|submitted|under_review|approved|executed|rejected|withdrawn|superseded — 8 candidates stripped; promote to reference product]',
    `supporting_document_reference` STRING COMMENT 'Reference identifier or file path to supporting documentation for the amendment (e.g., revised budget, updated work plan, donor correspondence).',
    `terms_and_conditions_change` STRING COMMENT 'Description of any modifications to the legal terms, conditions, reporting requirements, or compliance obligations under the grant agreement.',
    `grant_amendment_type` STRING COMMENT 'Classification of the amendment based on the nature of the modification. Indicates whether the amendment extends the period, modifies the budget, changes scope, updates key personnel, expands geographic coverage, or adjusts other terms. [ENUM-REF-CANDIDATE: no_cost_extension|budget_modification|scope_change|key_personnel_change|geographic_expansion|period_of_performance_change|funding_increase|funding_decrease|administrative_correction|terms_and_conditions_change — 10 candidates stripped; promote to reference product]',
    CONSTRAINT pk_grant_amendment PRIMARY KEY(`grant_amendment_id`)
) COMMENT 'Records all formal modifications to a grant award after initial execution. Captures amendment number, amendment type (no-cost extension, budget modification, scope change, key personnel change, geographic expansion, period of performance change), amendment date, donor approval reference, description of changes, revised total obligation, revised end date, and amendment status (pending, approved, executed). Tracks the full amendment history for compliance and audit purposes under OMB Uniform Guidance 2 CFR 200 and USAID ADS.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`grant`.`subaward` (
    `subaward_id` BIGINT COMMENT 'Unique identifier for the subaward record. Primary key.',
    `award_id` BIGINT COMMENT 'Reference to the prime grant award under which this subaward is issued. Links to the parent grant that provides the funding source.',
    `impact_story_id` BIGINT COMMENT 'Foreign key linking to communication.impact_story. Business justification: Subawards generate impact stories showcasing partner contributions and sub-recipient outcomes. Essential for prime donor reporting, partner visibility requirements, and demonstrating effective partner',
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
    `termination_date` DATE COMMENT 'The date when the subaward was terminated, if applicable. Used when the subaward is ended prior to the planned end date.',
    `termination_reason` STRING COMMENT 'Narrative explanation of the reason for subaward termination, if applicable. Documents the circumstances and justification for early termination.',
    `title` STRING COMMENT 'Descriptive title of the subaward that summarizes the scope of work or project purpose.',
    `total_subaward_amount` DECIMAL(18,2) COMMENT 'The total obligated amount of the subaward in the subaward currency. Represents the maximum financial obligation to the implementing partner.',
    `total_subaward_amount_usd` DECIMAL(18,2) COMMENT 'The total subaward amount converted to USD for consolidated reporting and analysis. Conversion uses the exchange rate at the time of subaward execution.',
    `subaward_type` STRING COMMENT 'Classification of the subaward instrument type. Determines the legal and compliance framework applicable to the subaward.. Valid values are `sub-grant|subcontract|fixed-obligation grant|cooperative agreement|cost-reimbursable|other`',
    `uei_number` STRING COMMENT 'The twelve-character alphanumeric Unique Entity Identifier assigned to the implementing partner by SAM.gov. Replaces DUNS for federal reporting.. Valid values are `^[A-Z0-9]{12}$`',
    CONSTRAINT pk_subaward PRIMARY KEY(`subaward_id`)
) COMMENT 'Manages sub-awards issued by the NGO as prime recipient to implementing partners (CBOs, local NGOs, contractors). Captures subaward number, type (sub-grant, subcontract, fixed-obligation grant), implementing partner reference, subaward amount, period of performance, flow-down requirements from prime award, FFATA reporting obligation flag, subaward status (active, suspended, terminated, closed), risk rating, monitoring schedule, and pass-through entity compliance obligations under 2 CFR 200.331. Distinct from the partnership domains MoU/LoA — this is the financial and compliance instrument with legal obligation.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`grant`.`donor_condition` (
    `donor_condition_id` BIGINT COMMENT 'Unique identifier for the donor condition record. Primary key for the donor_condition data product.',
    `award_id` BIGINT COMMENT 'Reference to the grant award to which this donor condition is attached.',
    `constituent_id` BIGINT COMMENT 'Reference to the donor organization that imposed this condition.',
    `evaluation_id` BIGINT COMMENT 'Foreign key linking to mel.evaluation. Business justification: Donor conditions mandate specific evaluations (midterm, endline, impact). Conditions specify evaluation timing, methodology, evaluator qualifications, and deliverable requirements that drive evaluatio',
    `indicator_id` BIGINT COMMENT 'Foreign key linking to mel.indicator. Business justification: Donor special award conditions mandate tracking specific indicators. Conditions specify indicator achievement thresholds, reporting frequencies, and data quality standards that trigger compliance moni',
    `staff_member_id` BIGINT COMMENT 'Reference to the staff member or employee who is accountable for ensuring this donor condition is met.',
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
    `donor_condition_type` STRING COMMENT 'Classification of the donor condition indicating the nature of the compliance obligation. Values: prior_approval_requirement (donor must approve before action), restricted_cost (specific cost category restrictions), reporting_obligation (scheduled or ad-hoc reporting requirement), key_personnel_approval (approval required for key staff changes), branding_marking_requirement (logo, attribution, visibility requirements), audit_requirement (financial or programmatic audit mandate).. Valid values are `prior_approval_requirement|restricted_cost|reporting_obligation|key_personnel_approval|branding_marking_requirement|audit_requirement`',
    `waiver_date` DATE COMMENT 'The date on which the donor formally waived this condition. Null if the condition was not waived.',
    `waiver_justification` STRING COMMENT 'Narrative explanation provided by the donor or documented by the organization for why the condition was waived.',
    `created_by` STRING COMMENT 'Username or identifier of the system user who created this donor condition record.',
    CONSTRAINT pk_donor_condition PRIMARY KEY(`donor_condition_id`)
) COMMENT 'Captures all donor-imposed conditions, special award conditions (SACs), compliance obligations, and key milestone requirements attached to a specific grant award. Each record represents a single condition including condition type (prior approval requirement, restricted cost, reporting obligation, key personnel approval, branding/marking requirement, audit requirement, programmatic milestone, deliverable deadline), condition description, regulatory citation (2 CFR 200 section, USAID ADS chapter, DFID Smart Rule), compliance status (open, met, waived, expired), due date, actual completion date, and responsible staff. Enables proactive compliance management, milestone tracking, and audit readiness.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`grant`.`donor_report` (
    `donor_report_id` BIGINT COMMENT 'Unique identifier for the donor report submission record. Primary key.',
    `award_id` BIGINT COMMENT 'Reference to the grant award for which this report is submitted.',
    `intervention_id` BIGINT COMMENT 'Foreign key linking to program.intervention. Business justification: Donor reports often cover specific interventions and require intervention-level narrative and results reporting. Essential for programmatic donor reports that must reference the intervention(s) being ',
    `staff_member_id` BIGINT COMMENT 'Reference to the staff member or MEL officer responsible for preparing and submitting this donor report.',
    `project_site_id` BIGINT COMMENT 'Foreign key linking to field.project_site. Business justification: Donor narrative reports routinely reference specific implementation sites for activity verification, beneficiary reach validation, and geographic accountability. Essential for site-level performance r',
    `regulatory_filing_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_filing. Business justification: Donor reports often fulfill regulatory filing obligations (IRS 990 schedules, single audit SEFA, IATI publication). Grant managers must track which donor report satisfies which filing requirement. Rea',
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
    `donor_report_status` STRING COMMENT 'Current lifecycle status of the donor report: upcoming (not yet started), draft (in preparation), submitted (sent to donor), under review (donor reviewing), accepted (approved by donor), revision requested (donor requested changes), or final (closed and archived). [ENUM-REF-CANDIDATE: Upcoming|Draft|Submitted|Under Review|Accepted|Revision Requested|Final — 7 candidates stripped; promote to reference product]',
    `submission_date` DATE COMMENT 'The actual date on which the donor report was submitted to the donor.',
    `submission_method` STRING COMMENT 'The channel or system through which the donor report was submitted, such as email, donor web portal, USAID ASIST system, DFID ARIES platform, CERF portal, or manual upload.. Valid values are `Email|Donor Portal|USAID ASIST|DFID ARIES|CERF Portal|Manual Upload`',
    `supporting_document_reference` STRING COMMENT 'Reference identifier or file path to supporting documentation attached to this donor report, such as financial statements, beneficiary lists, field photos, or monitoring data.',
    `donor_report_type` STRING COMMENT 'Classification of the donor report by its purpose and format, such as SF-425 Federal Financial Report, quarterly programmatic report, annual narrative, situation report (SitRep), final closeout report, or IATI transparency disclosure.. Valid values are `SF-425 Federal Financial Report|Quarterly Programmatic|Annual Narrative|SitRep|Final Report|IATI Disclosure`',
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
    `funding_source_status` STRING COMMENT 'Current lifecycle status of the funding source indicating whether it is actively available for grant awards, temporarily suspended, permanently closed, pending activation, or under review.. Valid values are `active|suspended|closed|pending_activation|under_review`',
    `subaward_allowed` BOOLEAN COMMENT 'Boolean flag indicating whether this funding source permits the organization to issue subawards or subgrants to implementing partners and community-based organizations.',
    `subaward_approval_required` BOOLEAN COMMENT 'Boolean flag indicating whether the donor organization must provide prior written approval before the organization can issue subawards using this funding source.',
    `thematic_restriction` STRING COMMENT 'Description of thematic or sectoral restrictions on the use of this funding source (e.g., WASH programs only, education initiatives, health services, emergency response). Empty if no thematic restrictions apply.',
    `total_funding_available` DECIMAL(18,2) COMMENT 'The total amount of funding available from this source across all grant awards, expressed in the funding source currency. May represent a ceiling or allocation limit.',
    `unallowable_cost_categories` STRING COMMENT 'Comma-separated list of cost categories or Chart of Accounts codes that are explicitly unallowable under this funding source (e.g., alcohol, entertainment, lobbying). Used to enforce budget compliance and prevent unallowable cost charges.',
    CONSTRAINT pk_funding_source PRIMARY KEY(`funding_source_id`)
) COMMENT 'Reference master for all funding sources and donor funding mechanisms used across grant awards. Captures funding source name, donor organization reference, funding mechanism type (ODA bilateral, multilateral, foundation grant, corporate philanthropy, CERF pooled fund, government contract), ODA/DAC classification, SDG alignment codes, geographic restrictions, thematic restrictions, currency, and IATI organization identifier. Enables portfolio analysis by funding source and donor compliance segmentation. Lives in the grant domain as the grant-facing classification of how funding flows to awards — distinct from the donor domains relationship and stewardship records which track the institutional relationship, communication history, and cultivation pipeline with the funding organization itself.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`grant`.`prior_approval` (
    `prior_approval_id` BIGINT COMMENT 'Unique identifier for the prior approval request record. Primary key for the prior approval entity.',
    `award_id` BIGINT COMMENT 'Reference to the grant award under which this prior approval request is submitted. Links to the grant entity.',
    `budget_line_id` BIGINT COMMENT 'Reference to the specific budget line item affected by this prior approval request, if applicable. Links to the budget plan or budget line entity.',
    `constituent_id` BIGINT COMMENT 'Reference to the donor organization from whom prior approval is being requested. Links to the donor entity.',
    `grant_amendment_id` BIGINT COMMENT 'Reference to the grant amendment that may result from this prior approval, if applicable. Nullable until amendment is created.',
    `indicator_id` BIGINT COMMENT 'Foreign key linking to mel.indicator. Business justification: Prior approval requests cite indicators affected by proposed changes. When requesting scope modifications, no-cost extensions, or budget reallocations, organizations must document impact on indicator ',
    `intervention_id` BIGINT COMMENT 'Reference to the program affected by this prior approval request. Links to the program entity for programmatic context.',
    `staff_member_id` BIGINT COMMENT 'Reference to the staff member who prepared and submitted the prior approval request. Links to the staff or workforce entity.',
    `project_site_id` BIGINT COMMENT 'Reference to the project site or field location affected by this prior approval, if applicable. Links to the project site entity.',
    `acknowledgment_date` DATE COMMENT 'Date when the donor acknowledged receipt of the prior approval request. Indicates the request has entered the donors review process.',
    `approved_amount` DECIMAL(18,2) COMMENT 'Monetary value approved by the donor for budget-related prior approval requests. May differ from the requested amount if donor approves a partial amount.',
    `approved_amount_currency` STRING COMMENT 'Three-letter ISO 4217 currency code for the approved amount. Ensures accurate financial tracking across multi-currency grants.. Valid values are `^[A-Z]{3}$`',
    `conditions` STRING COMMENT 'Specific conditions, restrictions, or requirements imposed by the donor as part of a conditional approval. Must be satisfied before the approved action can be implemented.',
    `cost_category` STRING COMMENT 'Classification of the cost type affected by this prior approval, such as personnel, travel, equipment, supplies, or indirect costs. Aligns with grant budget structure.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this prior approval record was first created in the system. Provides audit trail for record lifecycle tracking.',
    `decision` STRING COMMENT 'Final decision rendered by the donor on the prior approval request. Approved indicates full approval, conditionally approved requires additional actions, denied rejects the request, not required indicates prior approval was not needed, and pending indicates decision is still outstanding.. Valid values are `approved|conditionally_approved|denied|not_required|pending`',
    `denial_reason` STRING COMMENT 'Explanation provided by the donor for denying the prior approval request. Includes rationale, policy basis, or alternative recommendations.',
    `donor_contact_email` STRING COMMENT 'Email address of the donor representative handling this prior approval request. Used for correspondence and tracking communication.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `donor_contact_name` STRING COMMENT 'Name of the donor representative or grants officer to whom the prior approval request was submitted and who is responsible for reviewing and deciding on the request.',
    `donor_response_document_reference` STRING COMMENT 'Reference identifier or file path to the formal donor response letter or decision document. Provides audit trail for compliance verification.',
    `effective_date` DATE COMMENT 'Date from which the approved change becomes effective. Marks the start of the approved action or modification.',
    `expiration_date` DATE COMMENT 'Date by which the approved action must be completed or the approval expires. Applicable for time-bound approvals such as no-cost extensions.',
    `follow_up_notes` STRING COMMENT 'Free-text notes documenting required follow-up actions, outstanding conditions, or implementation steps resulting from the prior approval decision.',
    `follow_up_required` BOOLEAN COMMENT 'Indicates whether additional follow-up actions are required after the donor decision, such as submitting additional documentation or implementing conditions.',
    `internal_approval_date` DATE COMMENT 'Date when the prior approval request received internal organizational approval before submission to the donor. Ensures internal governance compliance.',
    `is_emergency` BOOLEAN COMMENT 'Indicates whether this prior approval request is being submitted under emergency or urgent circumstances requiring expedited donor review.',
    `is_retroactive` BOOLEAN COMMENT 'Indicates whether this prior approval request is being submitted retroactively after the action has already been taken. Retroactive requests carry higher compliance risk.',
    `justification` STRING COMMENT 'Detailed narrative explanation of why the prior approval is needed, including programmatic rationale, impact on project objectives, and alignment with grant terms and conditions.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this prior approval record was last updated. Tracks the most recent change to any field in the record.',
    `notes` STRING COMMENT 'Free-text field for capturing additional context, internal comments, or supplementary information about the prior approval request and decision process.',
    `regulatory_basis` STRING COMMENT 'Citation of the specific regulatory or contractual provision that requires prior approval for this action. Examples include 2 CFR 200.407, USAID ADS 303, or specific grant award terms.',
    `request_date` DATE COMMENT 'Date when the prior approval request was formally submitted to the donor. Represents the principal business event timestamp for this transaction.',
    `request_reference_number` STRING COMMENT 'Externally-known unique reference number assigned to this prior approval request for tracking and correspondence with the donor.',
    `request_status` STRING COMMENT 'Current lifecycle status of the prior approval request. Tracks progression from draft through submission, review, and final decision by the donor. [ENUM-REF-CANDIDATE: draft|submitted|under_review|approved|conditionally_approved|denied|withdrawn|not_required — 8 candidates stripped; promote to reference product]',
    `requested_amount` DECIMAL(18,2) COMMENT 'Monetary value requested in the prior approval submission for budget-related requests. Provides baseline for comparison with approved amount.',
    `requested_amount_currency` STRING COMMENT 'Three-letter ISO 4217 currency code for the requested amount. Ensures accurate financial tracking across multi-currency grants.. Valid values are `^[A-Z]{3}$`',
    `response_date` DATE COMMENT 'Actual date when the donor provided their formal decision on the prior approval request. Marks the completion of the review process.',
    `response_due_date` DATE COMMENT 'Expected or contractually required date by which the donor should provide a decision on the prior approval request. Used for follow-up and escalation.',
    `review_start_date` DATE COMMENT 'Date when the donor formally began reviewing the prior approval request. Used to track review cycle time and compliance with donor response timelines.',
    `subtype` STRING COMMENT 'More granular classification within the approval type, such as specific budget line item category or personnel role affected. Provides additional context for the request.',
    `supporting_document_reference` STRING COMMENT 'Reference identifier or file path to supporting documentation submitted with the prior approval request, such as revised budgets, justification memos, or technical specifications.',
    `prior_approval_type` STRING COMMENT 'Category of prior approval being requested. Common types include budget reallocation exceeding 10%, equipment purchase, foreign travel, key personnel change, no-cost extension request, change of scope, subaward modification, or indirect cost rate change. [ENUM-REF-CANDIDATE: budget_reallocation|equipment_purchase|foreign_travel|key_personnel_change|no_cost_extension|scope_change|subaward_modification|indirect_cost_rate_change|other — 9 candidates stripped; promote to reference product]',
    CONSTRAINT pk_prior_approval PRIMARY KEY(`prior_approval_id`)
) COMMENT 'Records requests for and decisions on prior approvals required from donors before incurring certain costs or making programmatic changes. Captures approval type (budget reallocation >10%, equipment purchase, foreign travel, key personnel change, no-cost extension request, change of scope), request date, justification, donor response date, approval status (pending, approved, denied, not required), regulatory basis (2 CFR 200.407, USAID ADS 303), and reference to the relevant award and amendment. Ensures compliance with donor prior approval requirements.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`grant`.`grant_closeout` (
    `grant_closeout_id` BIGINT COMMENT 'Unique identifier for the grant closeout record. Primary key. Each award has exactly one closeout record created when the period of performance ends or early termination is initiated.',
    `award_id` BIGINT COMMENT 'Reference to the grant award being closed out. Links this closeout record to the parent grant agreement.',
    `donor_report_id` BIGINT COMMENT 'Foreign key linking to grant.donor_report. Business justification: Grant closeout requires submission of final financial report. Currently tracked as final_financial_report_reference (string). Adding final_financial_report_id FK to donor_report establishes the relati',
    `evaluation_id` BIGINT COMMENT 'Foreign key linking to mel.evaluation. Business justification: Grant closeout packages reference final/endline evaluations as required deliverables. Closeout cannot be completed until final evaluation is submitted, accepted by donor, and findings are incorporated',
    `regulatory_filing_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_filing. Business justification: Grant closeout triggers final regulatory filings (final 990 schedule updates, IATI closeout publication, federal closeout reports). Closeout managers must track which filing completes the regulatory o',
    `staff_member_id` BIGINT COMMENT 'Reference to the staff member responsible for coordinating the closeout process. Ensures accountability for closeout completion.',
    `completion_date` DATE COMMENT 'Date when all closeout activities were completed and the grant was formally closed in the grant management system. Final milestone in grant lifecycle.',
    `compliance_certification_date` DATE COMMENT 'Date when internal compliance certification was completed confirming all closeout requirements met. Internal control checkpoint before donor submission.',
    `compliance_certified_by` STRING COMMENT 'Name and title of the authorized official who certified compliance with all closeout requirements. Provides accountability for certification.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this closeout record was first created in the system. Audit trail for record creation.',
    `donor_acceptance_date` DATE COMMENT 'Date when donor formally accepted the closeout and all final reports. Marks donor approval of grant completion.',
    `donor_closeout_contact_email` STRING COMMENT 'Email address of the donor closeout contact. Used for submission of final reports and closeout correspondence.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `donor_closeout_contact_name` STRING COMMENT 'Name of the donor representative responsible for reviewing and accepting the closeout. Primary point of contact for closeout correspondence.',
    `equipment_disposition_date` DATE COMMENT 'Date when equipment disposition was completed and documented. Required for federal grant closeout per 2 CFR 200.313.',
    `equipment_disposition_status` STRING COMMENT 'Disposition method for equipment purchased with grant funds. Documents compliance with 2 CFR 200.313 equipment disposition requirements.. Valid values are `retained_by_recipient|transferred_to_donor|transferred_to_other_program|sold|disposed`',
    `final_audit_completion_date` DATE COMMENT 'Date when final audit was completed and report issued. Required for grants subject to single audit per 2 CFR 200.501.',
    `final_audit_reference` STRING COMMENT 'Reference number or document identifier for the final audit report. Links to audit findings and resolution documentation.',
    `final_audit_status` STRING COMMENT 'Status of final audit or single audit requirement for the grant. Tracks compliance with 2 CFR 200 Subpart F audit requirements.. Valid values are `not_required|pending|in_progress|completed_no_findings|completed_with_findings|findings_resolved`',
    `final_financial_report_due_date` DATE COMMENT 'Deadline for submission of final financial report (SF-425 or equivalent). Typically 90-120 days after period of performance end per 2 CFR 200.344.',
    `final_financial_report_submission_date` DATE COMMENT 'Actual date when the final financial report (SF-425 or donor-specific form) was submitted to the donor. Must be within 120 days of period end per 2 CFR 200.344.',
    `final_inventory_reference` STRING COMMENT 'Document reference for the final property and equipment inventory report. Tracks disposition of federally-owned assets.',
    `final_inventory_submission_date` DATE COMMENT 'Date when final inventory of federally-owned property and equipment was submitted. Required for federal grants per 2 CFR 200.313 and 200.344.',
    `final_programmatic_report_due_date` DATE COMMENT 'Deadline for submission of final programmatic or technical report. Typically aligned with financial report deadline per donor requirements.',
    `final_programmatic_report_reference` STRING COMMENT 'Document reference or tracking number for the submitted final programmatic report. Links to document management system or grant management system record.',
    `final_programmatic_report_submission_date` DATE COMMENT 'Actual date when the final programmatic or technical report was submitted to the donor. Documents achievement of grant objectives and deliverables.',
    `initiation_date` DATE COMMENT 'Date when the formal closeout process was initiated. Typically triggered by period of performance end date or termination notice.',
    `intellectual_property_disposition` STRING COMMENT 'Disposition of intellectual property rights developed under the grant. Documents ownership and usage rights per grant agreement terms.. Valid values are `retained_by_recipient|transferred_to_donor|joint_ownership|public_domain|licensed`',
    `last_modified_by` STRING COMMENT 'User identifier of the person who last modified this closeout record. Provides accountability for data changes.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this closeout record was last updated. Audit trail for tracking changes throughout the closeout process.',
    `notes` STRING COMMENT 'Free-text notes documenting special circumstances, donor communications, or other relevant information about the closeout process.',
    `outstanding_issues_description` STRING COMMENT 'Detailed description of any outstanding issues preventing closeout completion. Documents barriers and resolution plans.',
    `outstanding_issues_flag` BOOLEAN COMMENT 'Indicates whether any unresolved issues exist that may delay closeout completion. True if issues exist, false if all requirements met.',
    `period_of_performance_end_date` DATE COMMENT 'Final date of the grant award period of performance. Closeout activities must commence after this date per 2 CFR 200.344.',
    `records_destruction_date` DATE COMMENT 'Actual date when grant records were destroyed after retention period expired. Documents compliance with records retention policy.',
    `records_retention_end_date` DATE COMMENT 'Date when grant records may be destroyed. Typically 3 years from final financial report submission per 2 CFR 200.334, or longer if audit findings exist.',
    `reference_number` STRING COMMENT 'Business identifier for the closeout process. Externally-known reference number used in donor correspondence and audit trails.',
    `grant_closeout_status` STRING COMMENT 'Current lifecycle state of the closeout process. Tracks progression from initiation through donor acceptance and final closure. [ENUM-REF-CANDIDATE: initiated|in_progress|final_reports_submitted|donor_review|donor_accepted|closed|on_hold — 7 candidates stripped; promote to reference product]',
    `grant_closeout_type` STRING COMMENT 'Classification of the closeout trigger. Distinguishes between normal period of performance expiration, early termination scenarios, and mutual agreement closures.. Valid values are `normal_expiration|early_termination|mutual_agreement|donor_termination|recipient_termination|no_cost_extension_expiration`',
    `unliquidated_obligations_amount` DECIMAL(18,2) COMMENT 'Total amount of obligations incurred but not yet paid at closeout. Must be reported on final SF-425 and disposition determined with donor.',
    `unliquidated_obligations_disposition` STRING COMMENT 'Disposition method for any remaining unliquidated obligations at closeout. Documents how outstanding commitments will be resolved.. Valid values are `paid_by_recipient|returned_to_donor|offset_against_future_awards|waived_by_donor|under_negotiation`',
    `unobligated_balance_amount` DECIMAL(18,2) COMMENT 'Total amount of grant funds that remain unobligated at closeout. Must be returned to donor or deobligated per 2 CFR 200.344.',
    `unobligated_balance_return_date` DATE COMMENT 'Date when unobligated balance was returned to the donor. Required within closeout period per donor terms.',
    CONSTRAINT pk_grant_closeout PRIMARY KEY(`grant_closeout_id`)
) COMMENT 'Manages the formal grant closeout process as an operational checklist for each award upon expiration or termination. Captures closeout initiation date, closeout type (normal expiration, early termination, mutual agreement), final financial report submission date (SF-425), final programmatic report submission date, final inventory of federally-owned property, final audit status, unliquidated obligations disposition, equipment disposition, intellectual property disposition, records retention period and destruction date, closeout status (initiated, in progress, final reports submitted, donor accepted, closed), and closeout completion date. Ensures compliance with 2 CFR 200.344 closeout requirements including the 120-day submission deadline for final reports and 3-year records retention obligation. Each award has exactly one closeout record created when the period of performance ends or early termination is initiated.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`grant`.`cost_share_commitment` (
    `cost_share_commitment_id` BIGINT COMMENT 'Unique identifier for the cost-share commitment record. Primary key.',
    `award_id` BIGINT COMMENT 'Reference to the grant award that requires this cost-share commitment.',
    `constituent_id` BIGINT COMMENT 'Foreign key linking to donor.constituent. Business justification: Cost share commitments often provided by external donors/foundations as matching funds. Tracks which donor constituent provided the cost share for grant compliance, donor recognition, and stewardship ',
    `inkind_donation_id` BIGINT COMMENT 'Foreign key linking to supply.inkind_donation. Business justification: Cost share commitments are frequently satisfied through in-kind donations. NGOs must track which specific donations fulfill which cost share obligations for donor compliance reporting, audit verificat',
    `intervention_id` BIGINT COMMENT 'Reference to the program or project that benefits from this cost-share commitment.',
    `partner_org_id` BIGINT COMMENT 'Reference to the implementing partner organization providing the cost-share contribution, if applicable.',
    `approval_date` DATE COMMENT 'Date on which the cost-share commitment or verification was formally approved.',
    `approved_by_name` STRING COMMENT 'Name of the individual who approved the cost-share commitment or verification.',
    `approved_by_title` STRING COMMENT 'Job title or role of the individual who approved the cost-share commitment or verification.',
    `audit_finding_reference` STRING COMMENT 'Reference to any audit findings or observations related to this cost-share commitment, if applicable.',
    `committed_amount` DECIMAL(18,2) COMMENT 'Amount formally committed by the NGO or partner to meet the cost-share requirement, expressed in the grant currency.',
    `compliance_status` STRING COMMENT 'Compliance status of the cost-share commitment relative to donor requirements: compliant (requirement met), at_risk (commitment made but verification pending), non_compliant (requirement not met), waived (donor waived requirement), or pending_verification (awaiting documentation review).. Valid values are `compliant|at_risk|non_compliant|waived|pending_verification`',
    `cost_category` STRING COMMENT 'Budget cost category or line item to which this cost-share commitment applies (e.g., personnel, equipment, travel, supplies).',
    `cost_share_source_description` STRING COMMENT 'Detailed description of the source of the cost-share contribution, including the contributing organization, department, or funding stream.',
    `cost_share_type` STRING COMMENT 'Type of cost-share contribution: cash (direct monetary contribution), in-kind (goods or services), third-party (contributions from external partners), or volunteer (volunteer time and services).. Valid values are `cash|in-kind|third-party|volunteer`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this cost-share commitment record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts in this commitment record (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `cost_share_commitment_date` DATE COMMENT 'Date on which the cost-share commitment was formally made by the NGO or partner organization.',
    `donor_approval_reference` STRING COMMENT 'Reference number or identifier for donor approval or acknowledgment of the cost-share commitment and verification.',
    `fiscal_period` STRING COMMENT 'Fiscal period (month or quarter) within the fiscal year in which this cost-share commitment is recognized.',
    `fiscal_year` STRING COMMENT 'Fiscal year in which this cost-share commitment is recognized for accounting and reporting purposes.',
    `gl_account_code` STRING COMMENT 'General ledger account code to which the cost-share contribution is posted for financial tracking and reporting.',
    `in_kind_valuation_method` STRING COMMENT 'Method used to value in-kind contributions (e.g., fair market value, independent appraisal, standard volunteer rate, depreciated asset value). Applicable only when cost_share_type is in-kind.',
    `is_mandatory` BOOLEAN COMMENT 'Indicates whether this cost-share commitment is mandatory per the grant agreement (true) or voluntary (false).',
    `is_restricted_fund` BOOLEAN COMMENT 'Indicates whether the cost-share contribution comes from restricted funds (true) or unrestricted funds (false).',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this cost-share commitment record was last updated or modified.',
    `notes` STRING COMMENT 'Additional notes, comments, or context regarding this cost-share commitment, including any special conditions or donor instructions.',
    `reference_number` STRING COMMENT 'External reference number or code assigned to this cost-share commitment for tracking and reporting purposes.',
    `reporting_period_end_date` DATE COMMENT 'End date of the reporting period during which this cost-share commitment applies.',
    `reporting_period_start_date` DATE COMMENT 'Start date of the reporting period during which this cost-share commitment applies.',
    `required_cost_share_amount` DECIMAL(18,2) COMMENT 'Total cost-share amount required by the donor as a condition of the grant award, expressed in the grant currency.',
    `required_cost_share_percentage` DECIMAL(18,2) COMMENT 'Required cost-share expressed as a percentage of total project costs (e.g., 25.00 for 25% match requirement).',
    `source_organization_name` STRING COMMENT 'Name of the organization providing the cost-share contribution (may be the NGO itself, a partner, or a third-party donor).',
    `cost_share_commitment_status` STRING COMMENT 'Current lifecycle status of the cost-share commitment: planned (identified but not yet committed), committed (formally committed), verified (documentation complete and approved), partially_verified (some verification complete), non_compliant (commitment not met), or waived (donor waived requirement).. Valid values are `planned|committed|verified|partially_verified|non_compliant|waived`',
    `supporting_document_reference` STRING COMMENT 'Reference identifier or file path to supporting documentation for this cost-share commitment (e.g., invoices, time sheets, valuation reports, donor letters).',
    `variance_amount` DECIMAL(18,2) COMMENT 'Difference between the required cost-share amount and the verified amount (positive indicates shortfall, negative indicates excess).',
    `variance_percentage` DECIMAL(18,2) COMMENT 'Variance expressed as a percentage of the required cost-share amount.',
    `verification_date` DATE COMMENT 'Date on which the cost-share contribution was verified and approved.',
    `verification_method` STRING COMMENT 'Method used to verify the cost-share contribution: financial_audit (independent audit), invoice_review (invoice and receipt documentation), time_sheet (volunteer or staff time records), valuation_report (independent valuation for in-kind), donor_certification (donor letter), or third_party_letter (third-party confirmation).. Valid values are `financial_audit|invoice_review|time_sheet|valuation_report|donor_certification|third_party_letter`',
    `verified_amount` DECIMAL(18,2) COMMENT 'Amount of cost-share that has been verified through documentation and approved by the donor or auditor, expressed in the grant currency.',
    `volunteer_hourly_rate` DECIMAL(18,2) COMMENT 'Standard hourly rate used to value volunteer time for cost-share purposes. Applicable only when cost_share_type is volunteer.',
    `volunteer_hours` DECIMAL(18,2) COMMENT 'Total number of volunteer hours contributed as part of this cost-share commitment. Applicable only when cost_share_type is volunteer.',
    CONSTRAINT pk_cost_share_commitment PRIMARY KEY(`cost_share_commitment_id`)
) COMMENT 'Tracks cost-share and matching fund commitments required by donors as a condition of the grant award. Captures cost-share type (cash, in-kind, third-party), required cost-share amount or percentage, committed amount, verified amount, cost-share source description, verification method, reporting period, and compliance status. Ensures the NGO meets its cost-share obligations under 2 CFR 200.306 and donor-specific matching requirements, and supports documentation for audits.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`grant`.`solicitation` (
    `solicitation_id` BIGINT COMMENT 'Unique identifier for the donor solicitation or funding opportunity record. Primary key.',
    `advocacy_campaign_id` BIGINT COMMENT 'Foreign key linking to communication.advocacy_campaign. Business justification: Solicitations often align with advocacy campaigns to build organizational visibility, demonstrate thought leadership, and cultivate partnerships before proposal submission. Essential for strategic pos',
    `country_office_id` BIGINT COMMENT 'Foreign key linking to field.country_office. Business justification: Solicitations are identified, tracked, and pursued by country offices as part of business development pipeline. Essential for BD workload allocation, country-level funding forecasts, and proposal prep',
    `funding_source_id` BIGINT COMMENT 'Foreign key linking to grant.funding_source. Business justification: Solicitations are issued under specific funding sources/mechanisms. Currently solicitation has issuing_donor_name (string) which should be normalized to a FK relationship. Adding funding_source_id all',
    `indicator_id` BIGINT COMMENT 'Foreign key linking to mel.indicator. Business justification: RFPs/RFAs specify mandatory donor indicators applicants must commit to tracking. Business development teams assess organizational capacity to collect data for required indicators during go/no-go decis',
    `constituent_id` BIGINT COMMENT 'Foreign key linking to donor.constituent. Business justification: Solicitations (RFPs, funding opportunities) issued by specific donor organizations. Links to constituent for tracking issuing donor, managing donor relationships, and analyzing funding opportunity sou',
    `anticipated_award_date` DATE COMMENT 'Expected date on which the donor will announce award decisions, as stated in the solicitation or estimated by the organization.',
    `anticipated_start_date` DATE COMMENT 'Expected start date for program implementation if the grant is awarded, as specified in the solicitation.',
    `application_deadline` TIMESTAMP COMMENT 'Date and time by which proposals or applications must be submitted. Critical for proposal pipeline planning and resource allocation.',
    `competitive_intelligence_notes` STRING COMMENT 'Internal notes on competitive landscape, known competitors, incumbent organizations, partnership opportunities, and strategic considerations for this solicitation. Business-confidential information.',
    `consortium_allowed` BOOLEAN COMMENT 'Indicates whether the solicitation permits or encourages consortium or partnership applications.',
    `contact_email` STRING COMMENT 'Email address of the donor point of contact for solicitation inquiries. Organizational contact data classified as confidential.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `contact_person_name` STRING COMMENT 'Name of the donor point of contact for questions about the solicitation.',
    `cost_share_percentage` DECIMAL(18,2) COMMENT 'Required percentage of total project cost that must be contributed by the applicant as cost-share or match, if applicable.',
    `cost_share_required` BOOLEAN COMMENT 'Indicates whether the solicitation requires cost-sharing or matching funds from the applicant organization.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this solicitation record was first created in the system.',
    `dac_sector_code` STRING COMMENT 'OECD Development Assistance Committee (DAC) sector classification code for this solicitation (e.g., 140 - Water Supply & Sanitation, 120 - Health, 111 - Education).',
    `eligibility_criteria` STRING COMMENT 'Summary of organizational eligibility requirements (e.g., 501(c)(3) status, registration in specific countries, minimum years of operational experience, financial capacity thresholds, consortium requirements).',
    `estimated_funding_amount` DECIMAL(18,2) COMMENT 'Total estimated funding available under this solicitation, expressed in the donors currency. May represent a range or ceiling amount.',
    `estimated_number_of_awards` STRING COMMENT 'Expected number of grants or contracts the donor intends to award under this solicitation. Null if not specified.',
    `funding_currency` STRING COMMENT 'Three-letter ISO 4217 currency code for the estimated funding amount (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `geographic_eligibility` STRING COMMENT 'Countries, regions, or geographic areas eligible for funding under this solicitation. Uses ISO 3166-1 alpha-3 country codes where applicable (e.g., SYR, YEM, ETH, Global, Sub-Saharan Africa).',
    `go_no_go_decision_date` DATE COMMENT 'Date on which the internal go/no-go decision was made regarding pursuit of this solicitation.',
    `go_no_go_rationale` STRING COMMENT 'Summary of the strategic rationale for the go or no-go decision, including alignment with organizational mission, capacity, competitive positioning, and resource availability.',
    `identified_by` STRING COMMENT 'Name or identifier of the staff member or business development team member who identified this solicitation opportunity.',
    `identified_date` DATE COMMENT 'Date on which this solicitation was first identified and entered into the organizations opportunity tracking system.',
    `indirect_cost_rate_allowed` BOOLEAN COMMENT 'Indicates whether the donor allows recovery of indirect costs (NICRA/ICR/F&A) in the budget.',
    `indirect_cost_rate_cap` DECIMAL(18,2) COMMENT 'Maximum allowable indirect cost rate as a percentage, if the donor imposes a cap (e.g., 10% de minimis rate under 2 CFR 200.414).',
    `internal_priority_score` STRING COMMENT 'Internal scoring or ranking assigned to this solicitation based on strategic fit, likelihood of success, and resource availability. Scale and methodology defined by organizational business development process.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this solicitation record was last updated or modified.',
    `local_partner_requirement` STRING COMMENT 'Description of any requirements for local or national NGO partnership, localization commitments, or sub-award percentages to local organizations.',
    `notes` STRING COMMENT 'General internal notes, observations, or additional context about this solicitation that do not fit other structured fields.',
    `number` STRING COMMENT 'External reference number assigned by the donor or issuing agency (e.g., RFA-2024-001, NOFO-BHA-2024-12, RFP-DFID-2024-WASH). This is the official identifier used in all donor communications and proposal submissions.',
    `program_duration_months` STRING COMMENT 'Expected duration of the funded program in months, as specified in the solicitation.',
    `publication_date` DATE COMMENT 'Date on which the solicitation was officially published or announced by the donor.',
    `questions_deadline` TIMESTAMP COMMENT 'Deadline by which applicants must submit questions to the donor regarding the solicitation.',
    `sdg_alignment` STRING COMMENT 'Sustainable Development Goals (SDGs) that this solicitation explicitly aligns with or contributes to (e.g., SDG 1, SDG 2, SDG 3, SDG 5, SDG 6). Multiple goals may be listed.',
    `solicitation_status` STRING COMMENT 'Current status of the solicitation in the organizations business development pipeline: Identified (opportunity discovered), Evaluating (under internal review), Go (decision to pursue), No-Go (decision not to pursue), Submitted (proposal submitted), Closed (deadline passed), Awarded (grant awarded to any organization), Cancelled (donor cancelled solicitation). [ENUM-REF-CANDIDATE: Identified|Evaluating|Go|No-Go|Submitted|Closed|Awarded|Cancelled — 8 candidates stripped; promote to reference product]',
    `submission_method` STRING COMMENT 'Required method for submitting the proposal or application (e.g., Online Portal, Email, Grants.gov, Physical Mail, Courier, Hybrid).. Valid values are `Online Portal|Email|Physical Mail|Grants.gov|Courier|Hybrid`',
    `submission_requirements` STRING COMMENT 'Summary of required documents and formats for proposal submission (e.g., technical proposal, budget narrative, organizational capacity statement, past performance references, certifications, page limits).',
    `thematic_focus_area` STRING COMMENT 'Primary programmatic theme or sector focus of the solicitation (e.g., WASH, Health, Education, Food Security, Protection, GBV Prevention, Livelihoods, Emergency Response). May include multiple themes separated by semicolons.',
    `title` STRING COMMENT 'Full official title of the funding opportunity as published by the donor or issuing agency.',
    `solicitation_type` STRING COMMENT 'Classification of the funding opportunity mechanism: Request for Applications (RFA), Request for Proposals (RFP), Notice of Funding Opportunity (NOFO), Invitation to Tender (ITT), Expression of Interest (EOI), Concept Note solicitation, Direct Award notification, or Unsolicited opportunity. [ENUM-REF-CANDIDATE: RFA|RFP|NOFO|ITT|EOI|Concept Note|Direct Award|Unsolicited — 8 candidates stripped; promote to reference product]',
    `url` STRING COMMENT 'Web link to the official solicitation document or announcement on the donors website or grants portal.',
    CONSTRAINT pk_solicitation PRIMARY KEY(`solicitation_id`)
) COMMENT 'Master record for donor solicitations, funding opportunities, and calls for proposals that the NGO tracks and evaluates for pursuit. Captures solicitation number (RFA, RFP, NOFO, ITT), issuing donor/agency, title, thematic focus area, geographic eligibility, estimated funding amount and currency, eligibility criteria, application deadline, submission requirements, solicitation status (identified, evaluating, go, no-go, closed, awarded, cancelled), go/no-go decision date and rationale, competitive intelligence notes, and estimated number of awards. Feeds the proposal pipeline — each proposal references the solicitation it responds to. Supports strategic business development planning, win-rate analysis, and resource allocation for proposal development.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`grant`.`award_site_allocation` (
    `award_site_allocation_id` BIGINT COMMENT 'Unique identifier for this award-site allocation record. Primary key.',
    `award_id` BIGINT COMMENT 'Foreign key linking to the grant award that is allocated to this project site',
    `project_site_id` BIGINT COMMENT 'Foreign key linking to the field project site where this award is being implemented',
    `beneficiary_target_at_site` STRING COMMENT 'The target number of beneficiaries or persons of concern (PoC) that this award aims to reach at this specific project site. Used for site-level performance monitoring and donor reporting.',
    `notes` STRING COMMENT 'Free-text notes capturing site-specific implementation considerations, coordination arrangements, or donor requirements for this award-site combination.',
    `site_activation_date` DATE COMMENT 'The date when this specific award became active at this project site. Governs when site-level expenditures can begin charging to this award.',
    `site_budget_allocation` DECIMAL(18,2) COMMENT 'The amount of the awards total budget allocated to activities at this specific project site, in the awards functional currency. Used for site-level financial tracking and donor reporting.',
    `site_deactivation_date` DATE COMMENT 'The date when this awards activities at this project site were officially closed or transitioned. Null for currently active allocations.',
    `site_role_in_award` STRING COMMENT 'The functional role this project site plays in the awards implementation strategy (e.g., primary implementation site, secondary site, beneficiary registration point, distribution center, monitoring site).',
    `site_status` STRING COMMENT 'Current operational status of this award at this specific site: planned (allocation approved but not yet active), active (currently implementing), suspended (temporarily halted), closed (implementation complete or terminated).',
    CONSTRAINT pk_award_site_allocation PRIMARY KEY(`award_site_allocation_id`)
) COMMENT 'This association product represents the operational allocation of grant award funding and activities to specific field project sites. It captures the site-specific budget allocation, activation timeline, beneficiary targets, and implementation roles that exist only in the context of a specific award operating at a specific site. Each record links one award to one project site with attributes that govern site-level financial management, donor reporting, and field operations coordination.. Existence Justification: In humanitarian NGO operations, grant awards routinely fund multi-site programs where a single award supports activities across multiple field locations (health posts, distribution points, WASH facilities), and individual project sites frequently host co-located programming from multiple concurrent awards from different donors. The business actively manages site-specific budget allocations, activation timelines, beneficiary targets, and implementation roles for each award-site combination to support site-level financial tracking and donor reporting requirements.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`grant`.`asset_allocation` (
    `asset_allocation_id` BIGINT COMMENT 'Unique identifier for this grant-asset allocation record. Primary key.',
    `award_id` BIGINT COMMENT 'Foreign key linking to the grant award that is funding or has funded this IT asset',
    `it_asset_id` BIGINT COMMENT 'Foreign key linking to the IT asset being allocated to the grant award',
    `cost_allocated` DECIMAL(18,2) COMMENT 'The monetary amount of the assets procurement cost allocated to this grant award, calculated as procurement_cost * allocation_percentage. Used for allowable cost verification and budget tracking.',
    `depreciation_allocation` DECIMAL(18,2) COMMENT 'The depreciation expense allocated to this grant award for the asset over the award period of performance. Used for indirect cost recovery and financial reporting to donors.',
    `disposal_date` DATE COMMENT 'The date on which the IT asset was disposed of, decommissioned, or transferred while allocated to this grant award. Relevant for donor reporting on asset disposition and residual value calculations.',
    `donor_approval_date` DATE COMMENT 'The date on which the donor approved this asset allocation, if approval was required.',
    `donor_approval_required` BOOLEAN COMMENT 'Indicates whether this asset allocation requires explicit donor approval based on the awards regulatory framework and asset value thresholds (e.g., equipment over $5,000 under 2 CFR 200).',
    `end_date` DATE COMMENT 'The date on which this cost allocation relationship ended, typically due to award closeout, asset disposal, or reallocation to another award.',
    `justification` STRING COMMENT 'Business justification for allocating this asset to this grant award, used for audit trails and allowable cost documentation.',
    `percentage` DECIMAL(18,2) COMMENT 'The percentage of the assets cost allocated to this specific grant award, used for cost sharing and indirect cost calculations. Sum of all allocations for an asset across awards may equal 100% or less.',
    `purchase_date` DATE COMMENT 'The date on which the IT asset was purchased using funds from this grant award. May differ from the assets procurement_date if the asset was procured before allocation or reallocated from another award.',
    `start_date` DATE COMMENT 'The date on which this cost allocation relationship became effective, typically aligned with the award start date or asset procurement date, whichever is later.',
    `asset_allocation_status` STRING COMMENT 'Current status of this cost allocation: active (currently allocated), closed (allocation ended), pending_approval (awaiting donor approval), reallocated (moved to different award).',
    CONSTRAINT pk_asset_allocation PRIMARY KEY(`asset_allocation_id`)
) COMMENT 'This association product represents the cost allocation relationship between grant awards and IT assets. It captures the financial assignment of IT asset costs to specific grant awards for compliance reporting, allowable cost verification, and indirect cost allocation. Each record links one award to one IT asset with allocation percentages, cost amounts, and lifecycle dates that exist only in the context of this funding relationship.. Existence Justification: In nonprofit grant management, IT assets are frequently cost-shared across multiple grant awards based on usage allocation (e.g., a server supporting 3 programs, a vehicle used by 2 field offices funded by different donors). Conversely, each grant award funds multiple IT assets over its lifecycle (laptops, software licenses, field equipment). The business actively manages these cost allocation relationships for donor compliance reporting, allowable cost verification under regulations like 2 CFR 200, and indirect cost recovery calculations.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`grant`.`award_position_funding` (
    `award_position_funding_id` BIGINT COMMENT 'Unique identifier for this award-position funding allocation record. Primary key.',
    `award_id` BIGINT COMMENT 'Foreign key linking to the grant award that provides funding for this position allocation',
    `position_id` BIGINT COMMENT 'Foreign key linking to the organizational position being funded by this award allocation',
    `allocation_currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for the cost allocation amount. Typically matches the award currency or the NGOs functional currency depending on cost allocation methodology.',
    `cost_allocation_amount` DECIMAL(18,2) COMMENT 'The total budgeted or actual cost amount allocated from this award to fund this position during the funding period. Calculated based on effort percentage, position salary, benefits, and applicable indirect costs. Used for grant budget tracking and financial reporting.',
    `created_date` TIMESTAMP COMMENT 'Timestamp when this funding allocation record was created in the system.',
    `effort_percent` DECIMAL(18,2) COMMENT 'The percentage of the positions effort (time and cost) allocated to this specific grant award. Used for effort certification and cost allocation. Must sum to 100% across all awards funding the same position during overlapping periods.',
    `end_date` DATE COMMENT 'The date on which this award stops funding this position. May be earlier than the award end date if the position transitions to different funding or is eliminated. Nullable for ongoing funding arrangements.',
    `last_modified_date` TIMESTAMP COMMENT 'Timestamp when this funding allocation record was last updated.',
    `notes` STRING COMMENT 'Free-text field for additional context about this funding allocation, such as justification for effort percentage, special donor requirements, or allocation change history.',
    `start_date` DATE COMMENT 'The date from which this award begins funding this position. Must fall within the awards period of performance and the positions availability window.',
    `award_position_funding_status` STRING COMMENT 'Current status of this funding allocation: planned (budgeted but not yet active), active (currently funding the position), suspended (temporarily paused), closed (funding period ended or allocation terminated).',
    CONSTRAINT pk_award_position_funding PRIMARY KEY(`award_position_funding_id`)
) COMMENT 'This association product represents the funding relationship between grant awards and organizational positions. It captures the split-funding allocation where a single position can be funded by multiple grants simultaneously, and a single grant award funds multiple positions. Each record links one award to one position with the funding percentage, cost allocation amount, funding period, and status that exist only in the context of this specific funding arrangement. This is the operational record used for grant compliance reporting, effort certification, cost allocation, and workforce planning.. Existence Justification: In NGO operations, positions are routinely split-funded across multiple grant awards simultaneously (e.g., one position charged 40% to Award A, 35% to Award B, 25% to Award C), and each grant award funds multiple positions across the organization. This is an operational necessity for grant compliance, effort certification, and cost allocation reporting required by donors under 2 CFR 200 and similar frameworks. The relationship is actively managed by grant managers and finance teams who track effort percentages, funding periods, and cost allocations for each award-position combination.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`grant`.`grant_staff_assignment` (
    `grant_staff_assignment_id` BIGINT COMMENT 'Primary key for grant_staff_assignment',
    `award_id` BIGINT COMMENT 'Foreign key linking to the grant award to which the staff member is assigned',
    `staff_member_id` BIGINT COMMENT 'Reference to the staff_member_id of the manager or grants officer who approved this assignment. Used for audit trail and compliance verification.',
    `grant_assigned_staff_member_id` BIGINT COMMENT 'Foreign key linking to the staff member assigned to the grant award',
    `grant_workforce_staff_assignment_id` BIGINT COMMENT 'FK to SSOT owner workforce.workforce_staff_assignment for entity staff_assignment',
    `workforce_staff_assignment_id` BIGINT COMMENT 'Unique surrogate identifier for each staff assignment record. Primary key for the association.',
    `assigned_staff_member_id` BIGINT COMMENT '',
    `approval_date` DATE COMMENT 'The date on which this staff assignment was formally approved by the authorized manager or grants officer. Used for compliance audit trails.',
    `budgeted_fte` DECIMAL(18,2) COMMENT 'The full-time equivalent (FTE) amount budgeted for this staff member on this award in the original grant proposal or budget. Used for variance analysis between budgeted and actual effort.',
    `cost_allocation_method` STRING COMMENT 'The methodology used to allocate the staff members compensation costs to this award (e.g., Direct Charge, Proportional Allocation, Activity-Based). Determines how payroll costs are distributed across funding sources for financial reporting.',
    `effort_percent` DECIMAL(18,2) COMMENT 'The percentage of the staff members total work time allocated to this specific award, expressed as a decimal (e.g., 25.00 for 25%). Used for cost allocation and donor compliance reporting. Must sum to 100% or less across all concurrent assignments for a staff member.',
    `end_date` DATE COMMENT 'The date on which the staff member ceased charging time and effort to this award. Null if the assignment is currently active. Used to close out cost allocation periods.',
    `notes` STRING COMMENT 'Free-text field for additional context about this assignment, such as special conditions, donor requirements, or justification for effort percentage changes.',
    `role` STRING COMMENT 'The functional role or capacity in which the staff member is assigned to this award (e.g., Principal Investigator, Project Manager, Technical Advisor). Used for donor reporting, organizational charts, and role-based access control.',
    `start_date` DATE COMMENT 'The effective date on which the staff member began charging time and effort to this award. Used to determine the period for which costs can be allocated to the award.',
    `grant_staff_assignment_status` STRING COMMENT 'Current lifecycle status of the staff assignment: Active (currently charging), Pending (approved but not yet started), Suspended (temporarily paused), Closed (ended). Used to control cost allocation and reporting.',
    CONSTRAINT pk_grant_staff_assignment PRIMARY KEY(`grant_staff_assignment_id`)
) COMMENT 'This association product represents the assignment of staff members to grant awards. It captures the allocation of workforce effort across multiple funding sources, enabling split-effort tracking, cost allocation, and compliance with donor reporting requirements. Each record links one staff member to one award with the specific role, effort percentage, assignment period, and cost allocation method that exist only in the context of this relationship. This is the operational record that HR and grants management teams actively create, update, and monitor throughout the award lifecycle.. Existence Justification: In NGO operations, staff members routinely work across multiple grant awards simultaneously (split effort), and each grant award employs multiple staff members in various roles. The business actively manages these assignments through formal effort allocation processes, tracking the percentage of each staff members time charged to each award, the role they perform, and the cost allocation method. This is a core operational relationship that HR and grants management teams create, update, and monitor for donor compliance and financial reporting.';

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
ALTER SCHEMA `vibe_ngo_v1`.`grant` SET TAGS ('dbx_division' = 'business');
ALTER SCHEMA `vibe_ngo_v1`.`grant` SET TAGS ('dbx_domain' = 'grant');
ALTER TABLE `vibe_ngo_v1`.`grant`.`sub_award_disbursement` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_ngo_v1`.`grant`.`sub_award_disbursement` SET TAGS ('dbx_subdomain' = 'award_management');
ALTER TABLE `vibe_ngo_v1`.`grant`.`sub_award_disbursement` ALTER COLUMN `sub_award_disbursement_id` SET TAGS ('dbx_business_glossary_term' = 'Sub-Award Disbursement ID');
ALTER TABLE `vibe_ngo_v1`.`grant`.`sub_award_disbursement` ALTER COLUMN `award_id` SET TAGS ('dbx_business_glossary_term' = 'Grant ID');
ALTER TABLE `vibe_ngo_v1`.`grant`.`sub_award_disbursement` ALTER COLUMN `budget_line_id` SET TAGS ('dbx_business_glossary_term' = 'Budget Line ID');
ALTER TABLE `vibe_ngo_v1`.`grant`.`sub_award_disbursement` ALTER COLUMN `component_id` SET TAGS ('dbx_business_glossary_term' = 'Program ID');
ALTER TABLE `vibe_ngo_v1`.`grant`.`sub_award_disbursement` ALTER COLUMN `partner_org_id` SET TAGS ('dbx_business_glossary_term' = 'Implementing Partner ID');
ALTER TABLE `vibe_ngo_v1`.`grant`.`sub_award_disbursement` ALTER COLUMN `subaward_id` SET TAGS ('dbx_business_glossary_term' = 'Sub-Award ID');
ALTER TABLE `vibe_ngo_v1`.`grant`.`sub_award_disbursement` ALTER COLUMN `advance_balance_outstanding` SET TAGS ('dbx_business_glossary_term' = 'Outstanding Advance Balance');
ALTER TABLE `vibe_ngo_v1`.`grant`.`sub_award_disbursement` ALTER COLUMN `advance_balance_outstanding` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`sub_award_disbursement` ALTER COLUMN `advance_balance_outstanding` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`sub_award_disbursement` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Disbursement Amount');
ALTER TABLE `vibe_ngo_v1`.`grant`.`sub_award_disbursement` ALTER COLUMN `amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`sub_award_disbursement` ALTER COLUMN `amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`sub_award_disbursement` ALTER COLUMN `amount_usd` SET TAGS ('dbx_business_glossary_term' = 'Disbursement Amount (USD)');
ALTER TABLE `vibe_ngo_v1`.`grant`.`sub_award_disbursement` ALTER COLUMN `amount_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`sub_award_disbursement` ALTER COLUMN `amount_usd` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`sub_award_disbursement` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Disbursement Approval Date');
ALTER TABLE `vibe_ngo_v1`.`grant`.`sub_award_disbursement` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `vibe_ngo_v1`.`grant`.`sub_award_disbursement` ALTER COLUMN `bank_transfer_reference` SET TAGS ('dbx_business_glossary_term' = 'Bank Transfer Reference');
ALTER TABLE `vibe_ngo_v1`.`grant`.`sub_award_disbursement` ALTER COLUMN `cost_category` SET TAGS ('dbx_business_glossary_term' = 'Cost Category');
ALTER TABLE `vibe_ngo_v1`.`grant`.`sub_award_disbursement` ALTER COLUMN `cost_category` SET TAGS ('dbx_value_regex' = 'direct_program|indirect_admin|capital_equipment|travel|personnel|other');
ALTER TABLE `vibe_ngo_v1`.`grant`.`sub_award_disbursement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_ngo_v1`.`grant`.`sub_award_disbursement` ALTER COLUMN `currency` SET TAGS ('dbx_business_glossary_term' = 'Disbursement Currency');
ALTER TABLE `vibe_ngo_v1`.`grant`.`sub_award_disbursement` ALTER COLUMN `currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_ngo_v1`.`grant`.`sub_award_disbursement` ALTER COLUMN `sub_award_disbursement_date` SET TAGS ('dbx_business_glossary_term' = 'Disbursement Date');
ALTER TABLE `vibe_ngo_v1`.`grant`.`sub_award_disbursement` ALTER COLUMN `donor_reporting_category` SET TAGS ('dbx_business_glossary_term' = 'Donor Reporting Category');
ALTER TABLE `vibe_ngo_v1`.`grant`.`sub_award_disbursement` ALTER COLUMN `exchange_rate` SET TAGS ('dbx_business_glossary_term' = 'Exchange Rate');
ALTER TABLE `vibe_ngo_v1`.`grant`.`sub_award_disbursement` ALTER COLUMN `fiscal_period` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period');
ALTER TABLE `vibe_ngo_v1`.`grant`.`sub_award_disbursement` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `vibe_ngo_v1`.`grant`.`sub_award_disbursement` ALTER COLUMN `fund_restriction_type` SET TAGS ('dbx_business_glossary_term' = 'Fund Restriction Type');
ALTER TABLE `vibe_ngo_v1`.`grant`.`sub_award_disbursement` ALTER COLUMN `fund_restriction_type` SET TAGS ('dbx_value_regex' = 'restricted|unrestricted|temporarily_restricted');
ALTER TABLE `vibe_ngo_v1`.`grant`.`sub_award_disbursement` ALTER COLUMN `gl_account_code` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Code');
ALTER TABLE `vibe_ngo_v1`.`grant`.`sub_award_disbursement` ALTER COLUMN `indirect_cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Indirect Cost Amount');
ALTER TABLE `vibe_ngo_v1`.`grant`.`sub_award_disbursement` ALTER COLUMN `indirect_cost_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`sub_award_disbursement` ALTER COLUMN `indirect_cost_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`sub_award_disbursement` ALTER COLUMN `is_emergency_disbursement` SET TAGS ('dbx_business_glossary_term' = 'Emergency Disbursement Flag');
ALTER TABLE `vibe_ngo_v1`.`grant`.`sub_award_disbursement` ALTER COLUMN `liquidated_amount` SET TAGS ('dbx_business_glossary_term' = 'Liquidated Amount');
ALTER TABLE `vibe_ngo_v1`.`grant`.`sub_award_disbursement` ALTER COLUMN `liquidated_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`sub_award_disbursement` ALTER COLUMN `liquidated_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`sub_award_disbursement` ALTER COLUMN `liquidation_date` SET TAGS ('dbx_business_glossary_term' = 'Liquidation Date');
ALTER TABLE `vibe_ngo_v1`.`grant`.`sub_award_disbursement` ALTER COLUMN `liquidation_deadline` SET TAGS ('dbx_business_glossary_term' = 'Liquidation Deadline');
ALTER TABLE `vibe_ngo_v1`.`grant`.`sub_award_disbursement` ALTER COLUMN `liquidation_status` SET TAGS ('dbx_business_glossary_term' = 'Liquidation Status');
ALTER TABLE `vibe_ngo_v1`.`grant`.`sub_award_disbursement` ALTER COLUMN `liquidation_status` SET TAGS ('dbx_value_regex' = 'not_required|pending|partial|fully_liquidated|overdue');
ALTER TABLE `vibe_ngo_v1`.`grant`.`sub_award_disbursement` ALTER COLUMN `method` SET TAGS ('dbx_business_glossary_term' = 'Disbursement Method');
ALTER TABLE `vibe_ngo_v1`.`grant`.`sub_award_disbursement` ALTER COLUMN `method` SET TAGS ('dbx_value_regex' = 'wire_transfer|mobile_money|check|cash|eft');
ALTER TABLE `vibe_ngo_v1`.`grant`.`sub_award_disbursement` ALTER COLUMN `net_disbursement_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Disbursement Amount');
ALTER TABLE `vibe_ngo_v1`.`grant`.`sub_award_disbursement` ALTER COLUMN `net_disbursement_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`sub_award_disbursement` ALTER COLUMN `net_disbursement_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`sub_award_disbursement` ALTER COLUMN `nicra_rate_applied` SET TAGS ('dbx_business_glossary_term' = 'Negotiated Indirect Cost Rate Agreement (NICRA) Rate Applied');
ALTER TABLE `vibe_ngo_v1`.`grant`.`sub_award_disbursement` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Disbursement Notes');
ALTER TABLE `vibe_ngo_v1`.`grant`.`sub_award_disbursement` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `vibe_ngo_v1`.`grant`.`sub_award_disbursement` ALTER COLUMN `payment_terms` SET TAGS ('dbx_value_regex' = 'immediate|net_15|net_30|milestone_based|upon_liquidation');
ALTER TABLE `vibe_ngo_v1`.`grant`.`sub_award_disbursement` ALTER COLUMN `post_distribution_monitoring_ref` SET TAGS ('dbx_business_glossary_term' = 'Post-Distribution Monitoring (PDM) Reference');
ALTER TABLE `vibe_ngo_v1`.`grant`.`sub_award_disbursement` ALTER COLUMN `reference_number` SET TAGS ('dbx_business_glossary_term' = 'Disbursement Reference Number');
ALTER TABLE `vibe_ngo_v1`.`grant`.`sub_award_disbursement` ALTER COLUMN `reference_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{5,30}$');
ALTER TABLE `vibe_ngo_v1`.`grant`.`sub_award_disbursement` ALTER COLUMN `request_date` SET TAGS ('dbx_business_glossary_term' = 'Disbursement Request Date');
ALTER TABLE `vibe_ngo_v1`.`grant`.`sub_award_disbursement` ALTER COLUMN `sub_award_disbursement_status` SET TAGS ('dbx_business_glossary_term' = 'Disbursement Status');
ALTER TABLE `vibe_ngo_v1`.`grant`.`sub_award_disbursement` ALTER COLUMN `sub_award_disbursement_status` SET TAGS ('dbx_value_regex' = 'draft|pending_approval|approved|disbursed|liquidated|cancelled');
ALTER TABLE `vibe_ngo_v1`.`grant`.`sub_award_disbursement` ALTER COLUMN `supporting_document_reference` SET TAGS ('dbx_business_glossary_term' = 'Supporting Documentation Reference');
ALTER TABLE `vibe_ngo_v1`.`grant`.`sub_award_disbursement` ALTER COLUMN `tranche_number` SET TAGS ('dbx_business_glossary_term' = 'Tranche Number');
ALTER TABLE `vibe_ngo_v1`.`grant`.`sub_award_disbursement` ALTER COLUMN `sub_award_disbursement_type` SET TAGS ('dbx_business_glossary_term' = 'Disbursement Type');
ALTER TABLE `vibe_ngo_v1`.`grant`.`sub_award_disbursement` ALTER COLUMN `sub_award_disbursement_type` SET TAGS ('dbx_value_regex' = 'advance|reimbursement|direct_payment|letter_of_credit');
ALTER TABLE `vibe_ngo_v1`.`grant`.`sub_award_disbursement` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_ngo_v1`.`grant`.`sub_award_disbursement` ALTER COLUMN `withholding_amount` SET TAGS ('dbx_business_glossary_term' = 'Withholding Amount');
ALTER TABLE `vibe_ngo_v1`.`grant`.`sub_award_disbursement` ALTER COLUMN `withholding_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`sub_award_disbursement` ALTER COLUMN `withholding_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award` SET TAGS ('dbx_subdomain' = 'award_management');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award` ALTER COLUMN `award_id` SET TAGS ('dbx_business_glossary_term' = 'Award Identifier');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award` ALTER COLUMN `constituent_id` SET TAGS ('dbx_business_glossary_term' = 'Donor Identifier');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award` ALTER COLUMN `country_office_id` SET TAGS ('dbx_business_glossary_term' = 'Country Office Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award` ALTER COLUMN `intervention_id` SET TAGS ('dbx_business_glossary_term' = 'Intervention Id');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award` ALTER COLUMN `advance_payment_allowed` SET TAGS ('dbx_business_glossary_term' = 'Advance Payment Allowed');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award` ALTER COLUMN `agreement_signed_date` SET TAGS ('dbx_business_glossary_term' = 'Agreement Signed Date');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award` ALTER COLUMN `amendment_count` SET TAGS ('dbx_business_glossary_term' = 'Amendment Count');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award` ALTER COLUMN `audit_required` SET TAGS ('dbx_business_glossary_term' = 'Audit Required');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award` ALTER COLUMN `audit_threshold_amount` SET TAGS ('dbx_business_glossary_term' = 'Audit Threshold Amount');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award` ALTER COLUMN `authorized_amount` SET TAGS ('dbx_business_glossary_term' = 'Authorized Amount');
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
ALTER TABLE `vibe_ngo_v1`.`grant`.`award` ALTER COLUMN `fund_restriction_type` SET TAGS ('dbx_business_glossary_term' = 'Fund Restriction Type');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award` ALTER COLUMN `fund_restriction_type` SET TAGS ('dbx_value_regex' = 'unrestricted|temporarily_restricted|permanently_restricted');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award` ALTER COLUMN `funding_mechanism` SET TAGS ('dbx_business_glossary_term' = 'Funding Mechanism');
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
ALTER TABLE `vibe_ngo_v1`.`grant`.`award` ALTER COLUMN `primary_country_code` SET TAGS ('dbx_business_glossary_term' = 'Primary Country Code');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award` ALTER COLUMN `primary_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award` ALTER COLUMN `regulatory_framework` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Framework');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award` ALTER COLUMN `reporting_frequency` SET TAGS ('dbx_business_glossary_term' = 'Reporting Frequency');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award` ALTER COLUMN `reporting_frequency` SET TAGS ('dbx_value_regex' = 'monthly|quarterly|semi_annual|annual|final_only');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award` ALTER COLUMN `sdg_alignment` SET TAGS ('dbx_business_glossary_term' = 'Sustainable Development Goal (SDG) Alignment');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award` ALTER COLUMN `special_conditions` SET TAGS ('dbx_business_glossary_term' = 'Special Conditions');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Award Start Date');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award` ALTER COLUMN `award_status` SET TAGS ('dbx_business_glossary_term' = 'Award Status');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award` ALTER COLUMN `award_status` SET TAGS ('dbx_value_regex' = 'pipeline|active|no_cost_extension|suspended|closed');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award` ALTER COLUMN `thematic_sector` SET TAGS ('dbx_business_glossary_term' = 'Thematic Sector');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award` ALTER COLUMN `title` SET TAGS ('dbx_business_glossary_term' = 'Award Title');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award` ALTER COLUMN `total_obligated_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Obligated Amount');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award` ALTER COLUMN `total_obligated_amount_functional` SET TAGS ('dbx_business_glossary_term' = 'Total Obligated Amount in Functional Currency');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award` ALTER COLUMN `award_type` SET TAGS ('dbx_business_glossary_term' = 'Award Type');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award` ALTER COLUMN `award_type` SET TAGS ('dbx_value_regex' = 'cooperative_agreement|contract|grant|sub_award|consortium_lead|consortium_member');
ALTER TABLE `vibe_ngo_v1`.`grant`.`proposal` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_ngo_v1`.`grant`.`proposal` SET TAGS ('dbx_subdomain' = 'proposal_pipeline');
ALTER TABLE `vibe_ngo_v1`.`grant`.`proposal` ALTER COLUMN `proposal_id` SET TAGS ('dbx_business_glossary_term' = 'Proposal Identifier (ID)');
ALTER TABLE `vibe_ngo_v1`.`grant`.`proposal` ALTER COLUMN `award_id` SET TAGS ('dbx_business_glossary_term' = 'Awarded Grant Identifier (ID)');
ALTER TABLE `vibe_ngo_v1`.`grant`.`proposal` ALTER COLUMN `component_id` SET TAGS ('dbx_business_glossary_term' = 'Program Identifier (ID)');
ALTER TABLE `vibe_ngo_v1`.`grant`.`proposal` ALTER COLUMN `constituent_id` SET TAGS ('dbx_business_glossary_term' = 'Donor Identifier (ID)');
ALTER TABLE `vibe_ngo_v1`.`grant`.`proposal` ALTER COLUMN `country_office_id` SET TAGS ('dbx_business_glossary_term' = 'Country Office Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`grant`.`proposal` ALTER COLUMN `intervention_id` SET TAGS ('dbx_business_glossary_term' = 'Intervention Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`grant`.`proposal` ALTER COLUMN `mel_logframe_id` SET TAGS ('dbx_business_glossary_term' = 'Mel Logframe Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`grant`.`proposal` ALTER COLUMN `solicitation_id` SET TAGS ('dbx_business_glossary_term' = 'Solicitation Identifier (ID)');
ALTER TABLE `vibe_ngo_v1`.`grant`.`proposal` ALTER COLUMN `award_notification_date` SET TAGS ('dbx_business_glossary_term' = 'Award Notification Date');
ALTER TABLE `vibe_ngo_v1`.`grant`.`proposal` ALTER COLUMN `business_development_owner` SET TAGS ('dbx_business_glossary_term' = 'Business Development Owner');
ALTER TABLE `vibe_ngo_v1`.`grant`.`proposal` ALTER COLUMN `compliance_review_completed` SET TAGS ('dbx_business_glossary_term' = 'Compliance Review Completed Flag');
ALTER TABLE `vibe_ngo_v1`.`grant`.`proposal` ALTER COLUMN `consortium_lead_organization` SET TAGS ('dbx_business_glossary_term' = 'Consortium Lead Organization');
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
ALTER TABLE `vibe_ngo_v1`.`grant`.`proposal` ALTER COLUMN `proposed_duration_months` SET TAGS ('dbx_business_glossary_term' = 'Proposed Duration in Months');
ALTER TABLE `vibe_ngo_v1`.`grant`.`proposal` ALTER COLUMN `proposed_end_date` SET TAGS ('dbx_business_glossary_term' = 'Proposed End Date');
ALTER TABLE `vibe_ngo_v1`.`grant`.`proposal` ALTER COLUMN `proposed_start_date` SET TAGS ('dbx_business_glossary_term' = 'Proposed Start Date');
ALTER TABLE `vibe_ngo_v1`.`grant`.`proposal` ALTER COLUMN `reference_number` SET TAGS ('dbx_business_glossary_term' = 'Proposal Reference Number');
ALTER TABLE `vibe_ngo_v1`.`grant`.`proposal` ALTER COLUMN `rejection_reason` SET TAGS ('dbx_business_glossary_term' = 'Rejection Reason');
ALTER TABLE `vibe_ngo_v1`.`grant`.`proposal` ALTER COLUMN `requested_amount` SET TAGS ('dbx_business_glossary_term' = 'Requested Amount');
ALTER TABLE `vibe_ngo_v1`.`grant`.`proposal` ALTER COLUMN `requested_amount_usd` SET TAGS ('dbx_business_glossary_term' = 'Requested Amount in United States Dollars (USD)');
ALTER TABLE `vibe_ngo_v1`.`grant`.`proposal` ALTER COLUMN `requested_currency` SET TAGS ('dbx_business_glossary_term' = 'Requested Currency');
ALTER TABLE `vibe_ngo_v1`.`grant`.`proposal` ALTER COLUMN `requested_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_ngo_v1`.`grant`.`proposal` ALTER COLUMN `proposal_status` SET TAGS ('dbx_business_glossary_term' = 'Proposal Status');
ALTER TABLE `vibe_ngo_v1`.`grant`.`proposal` ALTER COLUMN `submission_date` SET TAGS ('dbx_business_glossary_term' = 'Submission Date');
ALTER TABLE `vibe_ngo_v1`.`grant`.`proposal` ALTER COLUMN `target_beneficiary_count` SET TAGS ('dbx_business_glossary_term' = 'Target Beneficiary Count');
ALTER TABLE `vibe_ngo_v1`.`grant`.`proposal` ALTER COLUMN `technical_approach_summary` SET TAGS ('dbx_business_glossary_term' = 'Technical Approach Summary');
ALTER TABLE `vibe_ngo_v1`.`grant`.`proposal` ALTER COLUMN `title` SET TAGS ('dbx_business_glossary_term' = 'Proposal Title');
ALTER TABLE `vibe_ngo_v1`.`grant`.`proposal` ALTER COLUMN `proposal_type` SET TAGS ('dbx_business_glossary_term' = 'Proposal Type');
ALTER TABLE `vibe_ngo_v1`.`grant`.`proposal` ALTER COLUMN `proposal_type` SET TAGS ('dbx_value_regex' = 'full_application|concept_note|expression_of_interest|unsolicited|pre_proposal|letter_of_inquiry');
ALTER TABLE `vibe_ngo_v1`.`grant`.`proposal` ALTER COLUMN `win_loss_outcome` SET TAGS ('dbx_business_glossary_term' = 'Win Loss Outcome');
ALTER TABLE `vibe_ngo_v1`.`grant`.`proposal` ALTER COLUMN `win_loss_outcome` SET TAGS ('dbx_value_regex' = 'won|lost|pending|withdrawn');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget` SET TAGS ('dbx_subdomain' = 'award_management');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget` ALTER COLUMN `award_budget_id` SET TAGS ('dbx_business_glossary_term' = 'Award Budget ID');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget` ALTER COLUMN `award_id` SET TAGS ('dbx_business_glossary_term' = 'Grant ID');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget` ALTER COLUMN `budget_id` SET TAGS ('dbx_business_glossary_term' = 'Budget Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget` ALTER COLUMN `grant_amendment_id` SET TAGS ('dbx_business_glossary_term' = 'Amendment Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget` ALTER COLUMN `nicra_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Nicra Agreement Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By (Internal)');
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
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget` ALTER COLUMN `other_direct_costs` SET TAGS ('dbx_business_glossary_term' = 'Other Direct Costs');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget` ALTER COLUMN `period` SET TAGS ('dbx_business_glossary_term' = 'Budget Period');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget` ALTER COLUMN `period` SET TAGS ('dbx_value_regex' = '^(Year [1-9]|Year [1-9][0-9]|Period [1-9]|Period [1-9][0-9]|Full Award Period)$');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget` ALTER COLUMN `period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Budget Period End Date');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget` ALTER COLUMN `period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Budget Period Start Date');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget` ALTER COLUMN `personnel_costs` SET TAGS ('dbx_business_glossary_term' = 'Personnel Costs');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget` ALTER COLUMN `prepared_by` SET TAGS ('dbx_business_glossary_term' = 'Prepared By');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget` ALTER COLUMN `award_budget_status` SET TAGS ('dbx_business_glossary_term' = 'Budget Status');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget` ALTER COLUMN `submission_date` SET TAGS ('dbx_business_glossary_term' = 'Budget Submission Date');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget` ALTER COLUMN `supplies_costs` SET TAGS ('dbx_business_glossary_term' = 'Supplies Costs');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget` ALTER COLUMN `total_approved_budget` SET TAGS ('dbx_business_glossary_term' = 'Total Approved Budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget` ALTER COLUMN `total_direct_costs` SET TAGS ('dbx_business_glossary_term' = 'Total Direct Costs');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget` ALTER COLUMN `total_indirect_costs` SET TAGS ('dbx_business_glossary_term' = 'Total Indirect Costs (Facilities and Administration)');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget` ALTER COLUMN `travel_costs` SET TAGS ('dbx_business_glossary_term' = 'Travel Costs');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Budget Version Number');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget_line` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget_line` SET TAGS ('dbx_subdomain' = 'award_management');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget_line` ALTER COLUMN `award_budget_line_id` SET TAGS ('dbx_business_glossary_term' = 'Award Budget Line ID');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget_line` ALTER COLUMN `award_budget_id` SET TAGS ('dbx_business_glossary_term' = 'Budget Period ID');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget_line` ALTER COLUMN `award_id` SET TAGS ('dbx_business_glossary_term' = 'Award ID');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget_line` ALTER COLUMN `component_id` SET TAGS ('dbx_business_glossary_term' = 'Program ID');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget_line` ALTER COLUMN `budget_line_id` SET TAGS ('dbx_business_glossary_term' = 'Finance Budget Line Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget_line` ALTER COLUMN `indicator_id` SET TAGS ('dbx_business_glossary_term' = 'Indicator Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget_line` ALTER COLUMN `intervention_id` SET TAGS ('dbx_business_glossary_term' = 'Intervention Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget_line` ALTER COLUMN `position_id` SET TAGS ('dbx_business_glossary_term' = 'Position Id (Foreign Key)');
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
ALTER TABLE `vibe_ngo_v1`.`grant`.`grant_amendment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_ngo_v1`.`grant`.`grant_amendment` SET TAGS ('dbx_subdomain' = 'award_management');
ALTER TABLE `vibe_ngo_v1`.`grant`.`grant_amendment` ALTER COLUMN `grant_amendment_id` SET TAGS ('dbx_business_glossary_term' = 'Grant Amendment Identifier (ID)');
ALTER TABLE `vibe_ngo_v1`.`grant`.`grant_amendment` ALTER COLUMN `award_id` SET TAGS ('dbx_business_glossary_term' = 'Grant Identifier (ID)');
ALTER TABLE `vibe_ngo_v1`.`grant`.`grant_amendment` ALTER COLUMN `indicator_target_id` SET TAGS ('dbx_business_glossary_term' = 'Indicator Target Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`grant`.`grant_amendment` ALTER COLUMN `mel_logframe_id` SET TAGS ('dbx_business_glossary_term' = 'Mel Logframe Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`grant`.`grant_amendment` ALTER COLUMN `supersedes_amendment_grant_amendment_id` SET TAGS ('dbx_business_glossary_term' = 'Supersedes Amendment Identifier (ID)');
ALTER TABLE `vibe_ngo_v1`.`grant`.`grant_amendment` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Amendment Approval Date');
ALTER TABLE `vibe_ngo_v1`.`grant`.`grant_amendment` ALTER COLUMN `approved_by_name` SET TAGS ('dbx_business_glossary_term' = 'Approved By Name');
ALTER TABLE `vibe_ngo_v1`.`grant`.`grant_amendment` ALTER COLUMN `approved_by_name` SET TAGS ('dbx_pii_personal' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`grant_amendment` ALTER COLUMN `approved_by_title` SET TAGS ('dbx_business_glossary_term' = 'Approved By Title');
ALTER TABLE `vibe_ngo_v1`.`grant`.`grant_amendment` ALTER COLUMN `budget_modification_summary` SET TAGS ('dbx_business_glossary_term' = 'Budget Modification Summary');
ALTER TABLE `vibe_ngo_v1`.`grant`.`grant_amendment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_ngo_v1`.`grant`.`grant_amendment` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_ngo_v1`.`grant`.`grant_amendment` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_ngo_v1`.`grant`.`grant_amendment` ALTER COLUMN `grant_amendment_description` SET TAGS ('dbx_business_glossary_term' = 'Amendment Description');
ALTER TABLE `vibe_ngo_v1`.`grant`.`grant_amendment` ALTER COLUMN `donor_approval_reference` SET TAGS ('dbx_business_glossary_term' = 'Donor Approval Reference Number');
ALTER TABLE `vibe_ngo_v1`.`grant`.`grant_amendment` ALTER COLUMN `donor_prior_approval_required` SET TAGS ('dbx_business_glossary_term' = 'Donor Prior Approval Required Flag');
ALTER TABLE `vibe_ngo_v1`.`grant`.`grant_amendment` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Amendment Effective Date');
ALTER TABLE `vibe_ngo_v1`.`grant`.`grant_amendment` ALTER COLUMN `execution_date` SET TAGS ('dbx_business_glossary_term' = 'Amendment Execution Date');
ALTER TABLE `vibe_ngo_v1`.`grant`.`grant_amendment` ALTER COLUMN `funding_change` SET TAGS ('dbx_business_glossary_term' = 'Amendment Funding Change Amount');
ALTER TABLE `vibe_ngo_v1`.`grant`.`grant_amendment` ALTER COLUMN `geographic_change_description` SET TAGS ('dbx_business_glossary_term' = 'Geographic Change Description');
ALTER TABLE `vibe_ngo_v1`.`grant`.`grant_amendment` ALTER COLUMN `internal_approval_date` SET TAGS ('dbx_business_glossary_term' = 'Internal Approval Date');
ALTER TABLE `vibe_ngo_v1`.`grant`.`grant_amendment` ALTER COLUMN `internal_approver_name` SET TAGS ('dbx_business_glossary_term' = 'Internal Approver Name');
ALTER TABLE `vibe_ngo_v1`.`grant`.`grant_amendment` ALTER COLUMN `internal_approver_name` SET TAGS ('dbx_pii_personal' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`grant_amendment` ALTER COLUMN `is_no_cost_extension` SET TAGS ('dbx_business_glossary_term' = 'No-Cost Extension Flag');
ALTER TABLE `vibe_ngo_v1`.`grant`.`grant_amendment` ALTER COLUMN `justification` SET TAGS ('dbx_business_glossary_term' = 'Amendment Justification');
ALTER TABLE `vibe_ngo_v1`.`grant`.`grant_amendment` ALTER COLUMN `key_personnel_change_description` SET TAGS ('dbx_business_glossary_term' = 'Key Personnel Change Description');
ALTER TABLE `vibe_ngo_v1`.`grant`.`grant_amendment` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `vibe_ngo_v1`.`grant`.`grant_amendment` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Amendment Notes');
ALTER TABLE `vibe_ngo_v1`.`grant`.`grant_amendment` ALTER COLUMN `number` SET TAGS ('dbx_business_glossary_term' = 'Amendment Number');
ALTER TABLE `vibe_ngo_v1`.`grant`.`grant_amendment` ALTER COLUMN `original_end_date` SET TAGS ('dbx_business_glossary_term' = 'Original Period of Performance (PoP) End Date');
ALTER TABLE `vibe_ngo_v1`.`grant`.`grant_amendment` ALTER COLUMN `original_start_date` SET TAGS ('dbx_business_glossary_term' = 'Original Period of Performance (PoP) Start Date');
ALTER TABLE `vibe_ngo_v1`.`grant`.`grant_amendment` ALTER COLUMN `original_total_obligation` SET TAGS ('dbx_business_glossary_term' = 'Original Total Obligation Amount');
ALTER TABLE `vibe_ngo_v1`.`grant`.`grant_amendment` ALTER COLUMN `period_extension_days` SET TAGS ('dbx_business_glossary_term' = 'Period Extension Days');
ALTER TABLE `vibe_ngo_v1`.`grant`.`grant_amendment` ALTER COLUMN `request_date` SET TAGS ('dbx_business_glossary_term' = 'Amendment Request Date');
ALTER TABLE `vibe_ngo_v1`.`grant`.`grant_amendment` ALTER COLUMN `revised_end_date` SET TAGS ('dbx_business_glossary_term' = 'Revised Period of Performance (PoP) End Date');
ALTER TABLE `vibe_ngo_v1`.`grant`.`grant_amendment` ALTER COLUMN `revised_start_date` SET TAGS ('dbx_business_glossary_term' = 'Revised Period of Performance (PoP) Start Date');
ALTER TABLE `vibe_ngo_v1`.`grant`.`grant_amendment` ALTER COLUMN `revised_total_obligation` SET TAGS ('dbx_business_glossary_term' = 'Revised Total Obligation Amount');
ALTER TABLE `vibe_ngo_v1`.`grant`.`grant_amendment` ALTER COLUMN `scope_change_description` SET TAGS ('dbx_business_glossary_term' = 'Scope Change Description');
ALTER TABLE `vibe_ngo_v1`.`grant`.`grant_amendment` ALTER COLUMN `grant_amendment_status` SET TAGS ('dbx_business_glossary_term' = 'Amendment Status');
ALTER TABLE `vibe_ngo_v1`.`grant`.`grant_amendment` ALTER COLUMN `supporting_document_reference` SET TAGS ('dbx_business_glossary_term' = 'Supporting Document Reference');
ALTER TABLE `vibe_ngo_v1`.`grant`.`grant_amendment` ALTER COLUMN `terms_and_conditions_change` SET TAGS ('dbx_business_glossary_term' = 'Terms and Conditions Change Description');
ALTER TABLE `vibe_ngo_v1`.`grant`.`grant_amendment` ALTER COLUMN `grant_amendment_type` SET TAGS ('dbx_business_glossary_term' = 'Amendment Type');
ALTER TABLE `vibe_ngo_v1`.`grant`.`subaward` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_ngo_v1`.`grant`.`subaward` SET TAGS ('dbx_subdomain' = 'award_management');
ALTER TABLE `vibe_ngo_v1`.`grant`.`subaward` ALTER COLUMN `subaward_id` SET TAGS ('dbx_business_glossary_term' = 'Subaward Identifier (ID)');
ALTER TABLE `vibe_ngo_v1`.`grant`.`subaward` ALTER COLUMN `award_id` SET TAGS ('dbx_business_glossary_term' = 'Grant Identifier (ID)');
ALTER TABLE `vibe_ngo_v1`.`grant`.`subaward` ALTER COLUMN `impact_story_id` SET TAGS ('dbx_business_glossary_term' = 'Impact Story Id (Foreign Key)');
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
ALTER TABLE `vibe_ngo_v1`.`grant`.`subaward` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Termination Date');
ALTER TABLE `vibe_ngo_v1`.`grant`.`subaward` ALTER COLUMN `termination_reason` SET TAGS ('dbx_business_glossary_term' = 'Termination Reason');
ALTER TABLE `vibe_ngo_v1`.`grant`.`subaward` ALTER COLUMN `title` SET TAGS ('dbx_business_glossary_term' = 'Subaward Title');
ALTER TABLE `vibe_ngo_v1`.`grant`.`subaward` ALTER COLUMN `total_subaward_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Subaward Amount');
ALTER TABLE `vibe_ngo_v1`.`grant`.`subaward` ALTER COLUMN `total_subaward_amount_usd` SET TAGS ('dbx_business_glossary_term' = 'Total Subaward Amount United States Dollars (USD)');
ALTER TABLE `vibe_ngo_v1`.`grant`.`subaward` ALTER COLUMN `subaward_type` SET TAGS ('dbx_business_glossary_term' = 'Subaward Type');
ALTER TABLE `vibe_ngo_v1`.`grant`.`subaward` ALTER COLUMN `subaward_type` SET TAGS ('dbx_value_regex' = 'sub-grant|subcontract|fixed-obligation grant|cooperative agreement|cost-reimbursable|other');
ALTER TABLE `vibe_ngo_v1`.`grant`.`subaward` ALTER COLUMN `uei_number` SET TAGS ('dbx_business_glossary_term' = 'Unique Entity Identifier (UEI) Number');
ALTER TABLE `vibe_ngo_v1`.`grant`.`subaward` ALTER COLUMN `uei_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{12}$');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_condition` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_condition` SET TAGS ('dbx_subdomain' = 'compliance_reporting');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_condition` ALTER COLUMN `donor_condition_id` SET TAGS ('dbx_business_glossary_term' = 'Donor Condition ID');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_condition` ALTER COLUMN `award_id` SET TAGS ('dbx_business_glossary_term' = 'Grant ID');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_condition` ALTER COLUMN `constituent_id` SET TAGS ('dbx_business_glossary_term' = 'Donor ID');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_condition` ALTER COLUMN `evaluation_id` SET TAGS ('dbx_business_glossary_term' = 'Evaluation Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_condition` ALTER COLUMN `indicator_id` SET TAGS ('dbx_business_glossary_term' = 'Indicator Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_condition` ALTER COLUMN `staff_member_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Staff ID');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_condition` ALTER COLUMN `staff_member_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_condition` ALTER COLUMN `staff_member_id` SET TAGS ('dbx_pii' = 'true');
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
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_condition` ALTER COLUMN `donor_condition_type` SET TAGS ('dbx_business_glossary_term' = 'Condition Type');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_condition` ALTER COLUMN `donor_condition_type` SET TAGS ('dbx_value_regex' = 'prior_approval_requirement|restricted_cost|reporting_obligation|key_personnel_approval|branding_marking_requirement|audit_requirement');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_condition` ALTER COLUMN `waiver_date` SET TAGS ('dbx_business_glossary_term' = 'Waiver Date');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_condition` ALTER COLUMN `waiver_justification` SET TAGS ('dbx_business_glossary_term' = 'Waiver Justification');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_condition` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_report` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_report` SET TAGS ('dbx_subdomain' = 'compliance_reporting');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_report` ALTER COLUMN `donor_report_id` SET TAGS ('dbx_business_glossary_term' = 'Donor Report ID');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_report` ALTER COLUMN `award_id` SET TAGS ('dbx_business_glossary_term' = 'Grant ID');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_report` ALTER COLUMN `intervention_id` SET TAGS ('dbx_business_glossary_term' = 'Intervention Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_report` ALTER COLUMN `staff_member_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Staff ID');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_report` ALTER COLUMN `staff_member_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_report` ALTER COLUMN `staff_member_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_report` ALTER COLUMN `project_site_id` SET TAGS ('dbx_business_glossary_term' = 'Project Site Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_report` ALTER COLUMN `regulatory_filing_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Filing Id (Foreign Key)');
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
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_report` ALTER COLUMN `donor_report_status` SET TAGS ('dbx_business_glossary_term' = 'Report Status');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_report` ALTER COLUMN `submission_date` SET TAGS ('dbx_business_glossary_term' = 'Report Submission Date');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_report` ALTER COLUMN `submission_method` SET TAGS ('dbx_business_glossary_term' = 'Submission Method');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_report` ALTER COLUMN `submission_method` SET TAGS ('dbx_value_regex' = 'Email|Donor Portal|USAID ASIST|DFID ARIES|CERF Portal|Manual Upload');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_report` ALTER COLUMN `supporting_document_reference` SET TAGS ('dbx_business_glossary_term' = 'Supporting Document Reference');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_report` ALTER COLUMN `donor_report_type` SET TAGS ('dbx_business_glossary_term' = 'Report Type');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_report` ALTER COLUMN `donor_report_type` SET TAGS ('dbx_value_regex' = 'SF-425 Federal Financial Report|Quarterly Programmatic|Annual Narrative|SitRep|Final Report|IATI Disclosure');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_report` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Report Version Number');
ALTER TABLE `vibe_ngo_v1`.`grant`.`funding_source` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `vibe_ngo_v1`.`grant`.`funding_source` SET TAGS ('dbx_subdomain' = 'proposal_pipeline');
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
ALTER TABLE `vibe_ngo_v1`.`grant`.`funding_source` ALTER COLUMN `funding_source_status` SET TAGS ('dbx_business_glossary_term' = 'Funding Source Status');
ALTER TABLE `vibe_ngo_v1`.`grant`.`funding_source` ALTER COLUMN `funding_source_status` SET TAGS ('dbx_value_regex' = 'active|suspended|closed|pending_activation|under_review');
ALTER TABLE `vibe_ngo_v1`.`grant`.`funding_source` ALTER COLUMN `subaward_allowed` SET TAGS ('dbx_business_glossary_term' = 'Subaward Allowed');
ALTER TABLE `vibe_ngo_v1`.`grant`.`funding_source` ALTER COLUMN `subaward_approval_required` SET TAGS ('dbx_business_glossary_term' = 'Subaward Approval Required');
ALTER TABLE `vibe_ngo_v1`.`grant`.`funding_source` ALTER COLUMN `thematic_restriction` SET TAGS ('dbx_business_glossary_term' = 'Thematic Restriction');
ALTER TABLE `vibe_ngo_v1`.`grant`.`funding_source` ALTER COLUMN `total_funding_available` SET TAGS ('dbx_business_glossary_term' = 'Total Funding Available');
ALTER TABLE `vibe_ngo_v1`.`grant`.`funding_source` ALTER COLUMN `unallowable_cost_categories` SET TAGS ('dbx_business_glossary_term' = 'Unallowable Cost Categories');
ALTER TABLE `vibe_ngo_v1`.`grant`.`prior_approval` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_ngo_v1`.`grant`.`prior_approval` SET TAGS ('dbx_subdomain' = 'compliance_reporting');
ALTER TABLE `vibe_ngo_v1`.`grant`.`prior_approval` ALTER COLUMN `prior_approval_id` SET TAGS ('dbx_business_glossary_term' = 'Prior Approval Identifier (ID)');
ALTER TABLE `vibe_ngo_v1`.`grant`.`prior_approval` ALTER COLUMN `award_id` SET TAGS ('dbx_business_glossary_term' = 'Grant Identifier (ID)');
ALTER TABLE `vibe_ngo_v1`.`grant`.`prior_approval` ALTER COLUMN `budget_line_id` SET TAGS ('dbx_business_glossary_term' = 'Budget Line Identifier (ID)');
ALTER TABLE `vibe_ngo_v1`.`grant`.`prior_approval` ALTER COLUMN `constituent_id` SET TAGS ('dbx_business_glossary_term' = 'Donor Identifier (ID)');
ALTER TABLE `vibe_ngo_v1`.`grant`.`prior_approval` ALTER COLUMN `grant_amendment_id` SET TAGS ('dbx_business_glossary_term' = 'Amendment Identifier (ID)');
ALTER TABLE `vibe_ngo_v1`.`grant`.`prior_approval` ALTER COLUMN `indicator_id` SET TAGS ('dbx_business_glossary_term' = 'Indicator Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`grant`.`prior_approval` ALTER COLUMN `intervention_id` SET TAGS ('dbx_business_glossary_term' = 'Program Identifier (ID)');
ALTER TABLE `vibe_ngo_v1`.`grant`.`prior_approval` ALTER COLUMN `staff_member_id` SET TAGS ('dbx_business_glossary_term' = 'Requested By Staff Identifier (ID)');
ALTER TABLE `vibe_ngo_v1`.`grant`.`prior_approval` ALTER COLUMN `staff_member_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`prior_approval` ALTER COLUMN `staff_member_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`prior_approval` ALTER COLUMN `project_site_id` SET TAGS ('dbx_business_glossary_term' = 'Project Site Identifier (ID)');
ALTER TABLE `vibe_ngo_v1`.`grant`.`prior_approval` ALTER COLUMN `acknowledgment_date` SET TAGS ('dbx_business_glossary_term' = 'Acknowledgment Date');
ALTER TABLE `vibe_ngo_v1`.`grant`.`prior_approval` ALTER COLUMN `approved_amount` SET TAGS ('dbx_business_glossary_term' = 'Approved Amount');
ALTER TABLE `vibe_ngo_v1`.`grant`.`prior_approval` ALTER COLUMN `approved_amount_currency` SET TAGS ('dbx_business_glossary_term' = 'Approved Amount Currency');
ALTER TABLE `vibe_ngo_v1`.`grant`.`prior_approval` ALTER COLUMN `approved_amount_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_ngo_v1`.`grant`.`prior_approval` ALTER COLUMN `conditions` SET TAGS ('dbx_business_glossary_term' = 'Approval Conditions');
ALTER TABLE `vibe_ngo_v1`.`grant`.`prior_approval` ALTER COLUMN `cost_category` SET TAGS ('dbx_business_glossary_term' = 'Cost Category');
ALTER TABLE `vibe_ngo_v1`.`grant`.`prior_approval` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_ngo_v1`.`grant`.`prior_approval` ALTER COLUMN `decision` SET TAGS ('dbx_business_glossary_term' = 'Approval Decision');
ALTER TABLE `vibe_ngo_v1`.`grant`.`prior_approval` ALTER COLUMN `decision` SET TAGS ('dbx_value_regex' = 'approved|conditionally_approved|denied|not_required|pending');
ALTER TABLE `vibe_ngo_v1`.`grant`.`prior_approval` ALTER COLUMN `denial_reason` SET TAGS ('dbx_business_glossary_term' = 'Denial Reason');
ALTER TABLE `vibe_ngo_v1`.`grant`.`prior_approval` ALTER COLUMN `donor_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Donor Contact Email Address');
ALTER TABLE `vibe_ngo_v1`.`grant`.`prior_approval` ALTER COLUMN `donor_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_ngo_v1`.`grant`.`prior_approval` ALTER COLUMN `donor_contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`prior_approval` ALTER COLUMN `donor_contact_email` SET TAGS ('dbx_pii_contact' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`prior_approval` ALTER COLUMN `donor_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Donor Contact Name');
ALTER TABLE `vibe_ngo_v1`.`grant`.`prior_approval` ALTER COLUMN `donor_contact_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`prior_approval` ALTER COLUMN `donor_contact_name` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`prior_approval` ALTER COLUMN `donor_response_document_reference` SET TAGS ('dbx_business_glossary_term' = 'Donor Response Document Reference');
ALTER TABLE `vibe_ngo_v1`.`grant`.`prior_approval` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_ngo_v1`.`grant`.`prior_approval` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `vibe_ngo_v1`.`grant`.`prior_approval` ALTER COLUMN `follow_up_notes` SET TAGS ('dbx_business_glossary_term' = 'Follow-Up Notes');
ALTER TABLE `vibe_ngo_v1`.`grant`.`prior_approval` ALTER COLUMN `follow_up_required` SET TAGS ('dbx_business_glossary_term' = 'Follow-Up Required');
ALTER TABLE `vibe_ngo_v1`.`grant`.`prior_approval` ALTER COLUMN `internal_approval_date` SET TAGS ('dbx_business_glossary_term' = 'Internal Approval Date');
ALTER TABLE `vibe_ngo_v1`.`grant`.`prior_approval` ALTER COLUMN `is_emergency` SET TAGS ('dbx_business_glossary_term' = 'Is Emergency Request');
ALTER TABLE `vibe_ngo_v1`.`grant`.`prior_approval` ALTER COLUMN `is_retroactive` SET TAGS ('dbx_business_glossary_term' = 'Is Retroactive Approval');
ALTER TABLE `vibe_ngo_v1`.`grant`.`prior_approval` ALTER COLUMN `justification` SET TAGS ('dbx_business_glossary_term' = 'Request Justification');
ALTER TABLE `vibe_ngo_v1`.`grant`.`prior_approval` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `vibe_ngo_v1`.`grant`.`prior_approval` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Additional Notes');
ALTER TABLE `vibe_ngo_v1`.`grant`.`prior_approval` ALTER COLUMN `regulatory_basis` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Basis');
ALTER TABLE `vibe_ngo_v1`.`grant`.`prior_approval` ALTER COLUMN `request_date` SET TAGS ('dbx_business_glossary_term' = 'Request Submission Date');
ALTER TABLE `vibe_ngo_v1`.`grant`.`prior_approval` ALTER COLUMN `request_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Request Reference Number');
ALTER TABLE `vibe_ngo_v1`.`grant`.`prior_approval` ALTER COLUMN `request_status` SET TAGS ('dbx_business_glossary_term' = 'Request Status');
ALTER TABLE `vibe_ngo_v1`.`grant`.`prior_approval` ALTER COLUMN `requested_amount` SET TAGS ('dbx_business_glossary_term' = 'Requested Amount');
ALTER TABLE `vibe_ngo_v1`.`grant`.`prior_approval` ALTER COLUMN `requested_amount_currency` SET TAGS ('dbx_business_glossary_term' = 'Requested Amount Currency');
ALTER TABLE `vibe_ngo_v1`.`grant`.`prior_approval` ALTER COLUMN `requested_amount_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_ngo_v1`.`grant`.`prior_approval` ALTER COLUMN `response_date` SET TAGS ('dbx_business_glossary_term' = 'Donor Response Date');
ALTER TABLE `vibe_ngo_v1`.`grant`.`prior_approval` ALTER COLUMN `response_due_date` SET TAGS ('dbx_business_glossary_term' = 'Response Due Date');
ALTER TABLE `vibe_ngo_v1`.`grant`.`prior_approval` ALTER COLUMN `review_start_date` SET TAGS ('dbx_business_glossary_term' = 'Review Start Date');
ALTER TABLE `vibe_ngo_v1`.`grant`.`prior_approval` ALTER COLUMN `subtype` SET TAGS ('dbx_business_glossary_term' = 'Prior Approval Subtype');
ALTER TABLE `vibe_ngo_v1`.`grant`.`prior_approval` ALTER COLUMN `supporting_document_reference` SET TAGS ('dbx_business_glossary_term' = 'Supporting Document Reference');
ALTER TABLE `vibe_ngo_v1`.`grant`.`prior_approval` ALTER COLUMN `prior_approval_type` SET TAGS ('dbx_business_glossary_term' = 'Prior Approval Type');
ALTER TABLE `vibe_ngo_v1`.`grant`.`grant_closeout` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_ngo_v1`.`grant`.`grant_closeout` SET TAGS ('dbx_subdomain' = 'compliance_reporting');
ALTER TABLE `vibe_ngo_v1`.`grant`.`grant_closeout` ALTER COLUMN `grant_closeout_id` SET TAGS ('dbx_business_glossary_term' = 'Grant Closeout ID');
ALTER TABLE `vibe_ngo_v1`.`grant`.`grant_closeout` ALTER COLUMN `award_id` SET TAGS ('dbx_business_glossary_term' = 'Grant ID');
ALTER TABLE `vibe_ngo_v1`.`grant`.`grant_closeout` ALTER COLUMN `donor_report_id` SET TAGS ('dbx_business_glossary_term' = 'Final Financial Report Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`grant`.`grant_closeout` ALTER COLUMN `evaluation_id` SET TAGS ('dbx_business_glossary_term' = 'Final Evaluation Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`grant`.`grant_closeout` ALTER COLUMN `regulatory_filing_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Filing Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`grant`.`grant_closeout` ALTER COLUMN `staff_member_id` SET TAGS ('dbx_business_glossary_term' = 'Closeout Coordinator ID');
ALTER TABLE `vibe_ngo_v1`.`grant`.`grant_closeout` ALTER COLUMN `staff_member_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`grant_closeout` ALTER COLUMN `staff_member_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`grant_closeout` ALTER COLUMN `completion_date` SET TAGS ('dbx_business_glossary_term' = 'Closeout Completion Date');
ALTER TABLE `vibe_ngo_v1`.`grant`.`grant_closeout` ALTER COLUMN `compliance_certification_date` SET TAGS ('dbx_business_glossary_term' = 'Compliance Certification Date');
ALTER TABLE `vibe_ngo_v1`.`grant`.`grant_closeout` ALTER COLUMN `compliance_certified_by` SET TAGS ('dbx_business_glossary_term' = 'Compliance Certified By');
ALTER TABLE `vibe_ngo_v1`.`grant`.`grant_closeout` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_ngo_v1`.`grant`.`grant_closeout` ALTER COLUMN `donor_acceptance_date` SET TAGS ('dbx_business_glossary_term' = 'Donor Acceptance Date');
ALTER TABLE `vibe_ngo_v1`.`grant`.`grant_closeout` ALTER COLUMN `donor_closeout_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Donor Closeout Contact Email');
ALTER TABLE `vibe_ngo_v1`.`grant`.`grant_closeout` ALTER COLUMN `donor_closeout_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_ngo_v1`.`grant`.`grant_closeout` ALTER COLUMN `donor_closeout_contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`grant_closeout` ALTER COLUMN `donor_closeout_contact_email` SET TAGS ('dbx_pii_contact' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`grant_closeout` ALTER COLUMN `donor_closeout_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Donor Closeout Contact Name');
ALTER TABLE `vibe_ngo_v1`.`grant`.`grant_closeout` ALTER COLUMN `donor_closeout_contact_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`grant_closeout` ALTER COLUMN `donor_closeout_contact_name` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`grant_closeout` ALTER COLUMN `equipment_disposition_date` SET TAGS ('dbx_business_glossary_term' = 'Equipment Disposition Date');
ALTER TABLE `vibe_ngo_v1`.`grant`.`grant_closeout` ALTER COLUMN `equipment_disposition_status` SET TAGS ('dbx_business_glossary_term' = 'Equipment Disposition Status');
ALTER TABLE `vibe_ngo_v1`.`grant`.`grant_closeout` ALTER COLUMN `equipment_disposition_status` SET TAGS ('dbx_value_regex' = 'retained_by_recipient|transferred_to_donor|transferred_to_other_program|sold|disposed');
ALTER TABLE `vibe_ngo_v1`.`grant`.`grant_closeout` ALTER COLUMN `final_audit_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Final Audit Completion Date');
ALTER TABLE `vibe_ngo_v1`.`grant`.`grant_closeout` ALTER COLUMN `final_audit_reference` SET TAGS ('dbx_business_glossary_term' = 'Final Audit Reference');
ALTER TABLE `vibe_ngo_v1`.`grant`.`grant_closeout` ALTER COLUMN `final_audit_status` SET TAGS ('dbx_business_glossary_term' = 'Final Audit Status');
ALTER TABLE `vibe_ngo_v1`.`grant`.`grant_closeout` ALTER COLUMN `final_audit_status` SET TAGS ('dbx_value_regex' = 'not_required|pending|in_progress|completed_no_findings|completed_with_findings|findings_resolved');
ALTER TABLE `vibe_ngo_v1`.`grant`.`grant_closeout` ALTER COLUMN `final_financial_report_due_date` SET TAGS ('dbx_business_glossary_term' = 'Final Financial Report Due Date');
ALTER TABLE `vibe_ngo_v1`.`grant`.`grant_closeout` ALTER COLUMN `final_financial_report_submission_date` SET TAGS ('dbx_business_glossary_term' = 'Final Financial Report Submission Date');
ALTER TABLE `vibe_ngo_v1`.`grant`.`grant_closeout` ALTER COLUMN `final_inventory_reference` SET TAGS ('dbx_business_glossary_term' = 'Final Inventory Reference');
ALTER TABLE `vibe_ngo_v1`.`grant`.`grant_closeout` ALTER COLUMN `final_inventory_submission_date` SET TAGS ('dbx_business_glossary_term' = 'Final Inventory Submission Date');
ALTER TABLE `vibe_ngo_v1`.`grant`.`grant_closeout` ALTER COLUMN `final_programmatic_report_due_date` SET TAGS ('dbx_business_glossary_term' = 'Final Programmatic Report Due Date');
ALTER TABLE `vibe_ngo_v1`.`grant`.`grant_closeout` ALTER COLUMN `final_programmatic_report_reference` SET TAGS ('dbx_business_glossary_term' = 'Final Programmatic Report Reference');
ALTER TABLE `vibe_ngo_v1`.`grant`.`grant_closeout` ALTER COLUMN `final_programmatic_report_submission_date` SET TAGS ('dbx_business_glossary_term' = 'Final Programmatic Report Submission Date');
ALTER TABLE `vibe_ngo_v1`.`grant`.`grant_closeout` ALTER COLUMN `initiation_date` SET TAGS ('dbx_business_glossary_term' = 'Closeout Initiation Date');
ALTER TABLE `vibe_ngo_v1`.`grant`.`grant_closeout` ALTER COLUMN `intellectual_property_disposition` SET TAGS ('dbx_business_glossary_term' = 'Intellectual Property Disposition');
ALTER TABLE `vibe_ngo_v1`.`grant`.`grant_closeout` ALTER COLUMN `intellectual_property_disposition` SET TAGS ('dbx_value_regex' = 'retained_by_recipient|transferred_to_donor|joint_ownership|public_domain|licensed');
ALTER TABLE `vibe_ngo_v1`.`grant`.`grant_closeout` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified By');
ALTER TABLE `vibe_ngo_v1`.`grant`.`grant_closeout` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `vibe_ngo_v1`.`grant`.`grant_closeout` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Closeout Notes');
ALTER TABLE `vibe_ngo_v1`.`grant`.`grant_closeout` ALTER COLUMN `outstanding_issues_description` SET TAGS ('dbx_business_glossary_term' = 'Outstanding Issues Description');
ALTER TABLE `vibe_ngo_v1`.`grant`.`grant_closeout` ALTER COLUMN `outstanding_issues_flag` SET TAGS ('dbx_business_glossary_term' = 'Outstanding Issues Flag');
ALTER TABLE `vibe_ngo_v1`.`grant`.`grant_closeout` ALTER COLUMN `period_of_performance_end_date` SET TAGS ('dbx_business_glossary_term' = 'Period of Performance (PoP) End Date');
ALTER TABLE `vibe_ngo_v1`.`grant`.`grant_closeout` ALTER COLUMN `records_destruction_date` SET TAGS ('dbx_business_glossary_term' = 'Records Destruction Date');
ALTER TABLE `vibe_ngo_v1`.`grant`.`grant_closeout` ALTER COLUMN `records_retention_end_date` SET TAGS ('dbx_business_glossary_term' = 'Records Retention End Date');
ALTER TABLE `vibe_ngo_v1`.`grant`.`grant_closeout` ALTER COLUMN `reference_number` SET TAGS ('dbx_business_glossary_term' = 'Closeout Reference Number');
ALTER TABLE `vibe_ngo_v1`.`grant`.`grant_closeout` ALTER COLUMN `grant_closeout_status` SET TAGS ('dbx_business_glossary_term' = 'Closeout Status');
ALTER TABLE `vibe_ngo_v1`.`grant`.`grant_closeout` ALTER COLUMN `grant_closeout_type` SET TAGS ('dbx_business_glossary_term' = 'Closeout Type');
ALTER TABLE `vibe_ngo_v1`.`grant`.`grant_closeout` ALTER COLUMN `grant_closeout_type` SET TAGS ('dbx_value_regex' = 'normal_expiration|early_termination|mutual_agreement|donor_termination|recipient_termination|no_cost_extension_expiration');
ALTER TABLE `vibe_ngo_v1`.`grant`.`grant_closeout` ALTER COLUMN `unliquidated_obligations_amount` SET TAGS ('dbx_business_glossary_term' = 'Unliquidated Obligations Amount');
ALTER TABLE `vibe_ngo_v1`.`grant`.`grant_closeout` ALTER COLUMN `unliquidated_obligations_disposition` SET TAGS ('dbx_business_glossary_term' = 'Unliquidated Obligations Disposition');
ALTER TABLE `vibe_ngo_v1`.`grant`.`grant_closeout` ALTER COLUMN `unliquidated_obligations_disposition` SET TAGS ('dbx_value_regex' = 'paid_by_recipient|returned_to_donor|offset_against_future_awards|waived_by_donor|under_negotiation');
ALTER TABLE `vibe_ngo_v1`.`grant`.`grant_closeout` ALTER COLUMN `unobligated_balance_amount` SET TAGS ('dbx_business_glossary_term' = 'Unobligated Balance Amount');
ALTER TABLE `vibe_ngo_v1`.`grant`.`grant_closeout` ALTER COLUMN `unobligated_balance_return_date` SET TAGS ('dbx_business_glossary_term' = 'Unobligated Balance Return Date');
ALTER TABLE `vibe_ngo_v1`.`grant`.`cost_share_commitment` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_ngo_v1`.`grant`.`cost_share_commitment` SET TAGS ('dbx_subdomain' = 'compliance_reporting');
ALTER TABLE `vibe_ngo_v1`.`grant`.`cost_share_commitment` ALTER COLUMN `cost_share_commitment_id` SET TAGS ('dbx_business_glossary_term' = 'Cost-Share Commitment ID');
ALTER TABLE `vibe_ngo_v1`.`grant`.`cost_share_commitment` ALTER COLUMN `award_id` SET TAGS ('dbx_business_glossary_term' = 'Grant ID');
ALTER TABLE `vibe_ngo_v1`.`grant`.`cost_share_commitment` ALTER COLUMN `constituent_id` SET TAGS ('dbx_business_glossary_term' = 'Donor Constituent Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`grant`.`cost_share_commitment` ALTER COLUMN `inkind_donation_id` SET TAGS ('dbx_business_glossary_term' = 'Inkind Donation Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`grant`.`cost_share_commitment` ALTER COLUMN `intervention_id` SET TAGS ('dbx_business_glossary_term' = 'Program ID');
ALTER TABLE `vibe_ngo_v1`.`grant`.`cost_share_commitment` ALTER COLUMN `partner_org_id` SET TAGS ('dbx_business_glossary_term' = 'Implementing Partner ID');
ALTER TABLE `vibe_ngo_v1`.`grant`.`cost_share_commitment` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_ngo_v1`.`grant`.`cost_share_commitment` ALTER COLUMN `approved_by_name` SET TAGS ('dbx_business_glossary_term' = 'Approved By Name');
ALTER TABLE `vibe_ngo_v1`.`grant`.`cost_share_commitment` ALTER COLUMN `approved_by_name` SET TAGS ('dbx_pii_personal' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`cost_share_commitment` ALTER COLUMN `approved_by_title` SET TAGS ('dbx_business_glossary_term' = 'Approved By Title');
ALTER TABLE `vibe_ngo_v1`.`grant`.`cost_share_commitment` ALTER COLUMN `audit_finding_reference` SET TAGS ('dbx_business_glossary_term' = 'Audit Finding Reference');
ALTER TABLE `vibe_ngo_v1`.`grant`.`cost_share_commitment` ALTER COLUMN `committed_amount` SET TAGS ('dbx_business_glossary_term' = 'Committed Amount');
ALTER TABLE `vibe_ngo_v1`.`grant`.`cost_share_commitment` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `vibe_ngo_v1`.`grant`.`cost_share_commitment` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|at_risk|non_compliant|waived|pending_verification');
ALTER TABLE `vibe_ngo_v1`.`grant`.`cost_share_commitment` ALTER COLUMN `cost_category` SET TAGS ('dbx_business_glossary_term' = 'Cost Category');
ALTER TABLE `vibe_ngo_v1`.`grant`.`cost_share_commitment` ALTER COLUMN `cost_share_source_description` SET TAGS ('dbx_business_glossary_term' = 'Cost-Share Source Description');
ALTER TABLE `vibe_ngo_v1`.`grant`.`cost_share_commitment` ALTER COLUMN `cost_share_type` SET TAGS ('dbx_business_glossary_term' = 'Cost-Share Type');
ALTER TABLE `vibe_ngo_v1`.`grant`.`cost_share_commitment` ALTER COLUMN `cost_share_type` SET TAGS ('dbx_value_regex' = 'cash|in-kind|third-party|volunteer');
ALTER TABLE `vibe_ngo_v1`.`grant`.`cost_share_commitment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_ngo_v1`.`grant`.`cost_share_commitment` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_ngo_v1`.`grant`.`cost_share_commitment` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_ngo_v1`.`grant`.`cost_share_commitment` ALTER COLUMN `cost_share_commitment_date` SET TAGS ('dbx_business_glossary_term' = 'Commitment Date');
ALTER TABLE `vibe_ngo_v1`.`grant`.`cost_share_commitment` ALTER COLUMN `donor_approval_reference` SET TAGS ('dbx_business_glossary_term' = 'Donor Approval Reference');
ALTER TABLE `vibe_ngo_v1`.`grant`.`cost_share_commitment` ALTER COLUMN `fiscal_period` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period');
ALTER TABLE `vibe_ngo_v1`.`grant`.`cost_share_commitment` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `vibe_ngo_v1`.`grant`.`cost_share_commitment` ALTER COLUMN `gl_account_code` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Code');
ALTER TABLE `vibe_ngo_v1`.`grant`.`cost_share_commitment` ALTER COLUMN `in_kind_valuation_method` SET TAGS ('dbx_business_glossary_term' = 'In-Kind Valuation Method');
ALTER TABLE `vibe_ngo_v1`.`grant`.`cost_share_commitment` ALTER COLUMN `is_mandatory` SET TAGS ('dbx_business_glossary_term' = 'Is Mandatory');
ALTER TABLE `vibe_ngo_v1`.`grant`.`cost_share_commitment` ALTER COLUMN `is_restricted_fund` SET TAGS ('dbx_business_glossary_term' = 'Is Restricted Fund');
ALTER TABLE `vibe_ngo_v1`.`grant`.`cost_share_commitment` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_ngo_v1`.`grant`.`cost_share_commitment` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Commitment Notes');
ALTER TABLE `vibe_ngo_v1`.`grant`.`cost_share_commitment` ALTER COLUMN `reference_number` SET TAGS ('dbx_business_glossary_term' = 'Commitment Reference Number');
ALTER TABLE `vibe_ngo_v1`.`grant`.`cost_share_commitment` ALTER COLUMN `reporting_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Reporting Period End Date');
ALTER TABLE `vibe_ngo_v1`.`grant`.`cost_share_commitment` ALTER COLUMN `reporting_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Reporting Period Start Date');
ALTER TABLE `vibe_ngo_v1`.`grant`.`cost_share_commitment` ALTER COLUMN `required_cost_share_amount` SET TAGS ('dbx_business_glossary_term' = 'Required Cost-Share Amount');
ALTER TABLE `vibe_ngo_v1`.`grant`.`cost_share_commitment` ALTER COLUMN `required_cost_share_percentage` SET TAGS ('dbx_business_glossary_term' = 'Required Cost-Share Percentage');
ALTER TABLE `vibe_ngo_v1`.`grant`.`cost_share_commitment` ALTER COLUMN `required_cost_share_percentage` SET TAGS ('dbx_pii_demographic' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`cost_share_commitment` ALTER COLUMN `source_organization_name` SET TAGS ('dbx_business_glossary_term' = 'Source Organization Name');
ALTER TABLE `vibe_ngo_v1`.`grant`.`cost_share_commitment` ALTER COLUMN `source_organization_name` SET TAGS ('dbx_pii_personal' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`cost_share_commitment` ALTER COLUMN `cost_share_commitment_status` SET TAGS ('dbx_business_glossary_term' = 'Commitment Status');
ALTER TABLE `vibe_ngo_v1`.`grant`.`cost_share_commitment` ALTER COLUMN `cost_share_commitment_status` SET TAGS ('dbx_value_regex' = 'planned|committed|verified|partially_verified|non_compliant|waived');
ALTER TABLE `vibe_ngo_v1`.`grant`.`cost_share_commitment` ALTER COLUMN `supporting_document_reference` SET TAGS ('dbx_business_glossary_term' = 'Supporting Document Reference');
ALTER TABLE `vibe_ngo_v1`.`grant`.`cost_share_commitment` ALTER COLUMN `variance_amount` SET TAGS ('dbx_business_glossary_term' = 'Variance Amount');
ALTER TABLE `vibe_ngo_v1`.`grant`.`cost_share_commitment` ALTER COLUMN `variance_percentage` SET TAGS ('dbx_business_glossary_term' = 'Variance Percentage');
ALTER TABLE `vibe_ngo_v1`.`grant`.`cost_share_commitment` ALTER COLUMN `variance_percentage` SET TAGS ('dbx_pii_demographic' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`cost_share_commitment` ALTER COLUMN `verification_date` SET TAGS ('dbx_business_glossary_term' = 'Verification Date');
ALTER TABLE `vibe_ngo_v1`.`grant`.`cost_share_commitment` ALTER COLUMN `verification_method` SET TAGS ('dbx_business_glossary_term' = 'Verification Method');
ALTER TABLE `vibe_ngo_v1`.`grant`.`cost_share_commitment` ALTER COLUMN `verification_method` SET TAGS ('dbx_value_regex' = 'financial_audit|invoice_review|time_sheet|valuation_report|donor_certification|third_party_letter');
ALTER TABLE `vibe_ngo_v1`.`grant`.`cost_share_commitment` ALTER COLUMN `verified_amount` SET TAGS ('dbx_business_glossary_term' = 'Verified Amount');
ALTER TABLE `vibe_ngo_v1`.`grant`.`cost_share_commitment` ALTER COLUMN `volunteer_hourly_rate` SET TAGS ('dbx_business_glossary_term' = 'Volunteer Hourly Rate');
ALTER TABLE `vibe_ngo_v1`.`grant`.`cost_share_commitment` ALTER COLUMN `volunteer_hours` SET TAGS ('dbx_business_glossary_term' = 'Volunteer Hours');
ALTER TABLE `vibe_ngo_v1`.`grant`.`solicitation` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_ngo_v1`.`grant`.`solicitation` SET TAGS ('dbx_subdomain' = 'proposal_pipeline');
ALTER TABLE `vibe_ngo_v1`.`grant`.`solicitation` ALTER COLUMN `solicitation_id` SET TAGS ('dbx_business_glossary_term' = 'Solicitation Identifier (ID)');
ALTER TABLE `vibe_ngo_v1`.`grant`.`solicitation` ALTER COLUMN `advocacy_campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Advocacy Campaign Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`grant`.`solicitation` ALTER COLUMN `country_office_id` SET TAGS ('dbx_business_glossary_term' = 'Country Office Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`grant`.`solicitation` ALTER COLUMN `funding_source_id` SET TAGS ('dbx_business_glossary_term' = 'Funding Source Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`grant`.`solicitation` ALTER COLUMN `indicator_id` SET TAGS ('dbx_business_glossary_term' = 'Indicator Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`grant`.`solicitation` ALTER COLUMN `constituent_id` SET TAGS ('dbx_business_glossary_term' = 'Issuing Constituent Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`grant`.`solicitation` ALTER COLUMN `anticipated_award_date` SET TAGS ('dbx_business_glossary_term' = 'Anticipated Award Date');
ALTER TABLE `vibe_ngo_v1`.`grant`.`solicitation` ALTER COLUMN `anticipated_start_date` SET TAGS ('dbx_business_glossary_term' = 'Anticipated Program Start Date');
ALTER TABLE `vibe_ngo_v1`.`grant`.`solicitation` ALTER COLUMN `application_deadline` SET TAGS ('dbx_business_glossary_term' = 'Application Deadline');
ALTER TABLE `vibe_ngo_v1`.`grant`.`solicitation` ALTER COLUMN `competitive_intelligence_notes` SET TAGS ('dbx_business_glossary_term' = 'Competitive Intelligence Notes');
ALTER TABLE `vibe_ngo_v1`.`grant`.`solicitation` ALTER COLUMN `competitive_intelligence_notes` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`solicitation` ALTER COLUMN `consortium_allowed` SET TAGS ('dbx_business_glossary_term' = 'Consortium Allowed');
ALTER TABLE `vibe_ngo_v1`.`grant`.`solicitation` ALTER COLUMN `contact_email` SET TAGS ('dbx_business_glossary_term' = 'Donor Contact Email Address');
ALTER TABLE `vibe_ngo_v1`.`grant`.`solicitation` ALTER COLUMN `contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_ngo_v1`.`grant`.`solicitation` ALTER COLUMN `contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`solicitation` ALTER COLUMN `contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`solicitation` ALTER COLUMN `contact_person_name` SET TAGS ('dbx_business_glossary_term' = 'Donor Contact Person Name');
ALTER TABLE `vibe_ngo_v1`.`grant`.`solicitation` ALTER COLUMN `contact_person_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`solicitation` ALTER COLUMN `contact_person_name` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`solicitation` ALTER COLUMN `cost_share_percentage` SET TAGS ('dbx_business_glossary_term' = 'Cost Share Percentage');
ALTER TABLE `vibe_ngo_v1`.`grant`.`solicitation` ALTER COLUMN `cost_share_percentage` SET TAGS ('dbx_pii_demographic' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`solicitation` ALTER COLUMN `cost_share_required` SET TAGS ('dbx_business_glossary_term' = 'Cost Share Required');
ALTER TABLE `vibe_ngo_v1`.`grant`.`solicitation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_ngo_v1`.`grant`.`solicitation` ALTER COLUMN `dac_sector_code` SET TAGS ('dbx_business_glossary_term' = 'Development Assistance Committee (DAC) Sector Code');
ALTER TABLE `vibe_ngo_v1`.`grant`.`solicitation` ALTER COLUMN `eligibility_criteria` SET TAGS ('dbx_business_glossary_term' = 'Eligibility Criteria');
ALTER TABLE `vibe_ngo_v1`.`grant`.`solicitation` ALTER COLUMN `estimated_funding_amount` SET TAGS ('dbx_business_glossary_term' = 'Estimated Funding Amount');
ALTER TABLE `vibe_ngo_v1`.`grant`.`solicitation` ALTER COLUMN `estimated_number_of_awards` SET TAGS ('dbx_business_glossary_term' = 'Estimated Number of Awards');
ALTER TABLE `vibe_ngo_v1`.`grant`.`solicitation` ALTER COLUMN `funding_currency` SET TAGS ('dbx_business_glossary_term' = 'Funding Currency');
ALTER TABLE `vibe_ngo_v1`.`grant`.`solicitation` ALTER COLUMN `funding_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_ngo_v1`.`grant`.`solicitation` ALTER COLUMN `geographic_eligibility` SET TAGS ('dbx_business_glossary_term' = 'Geographic Eligibility');
ALTER TABLE `vibe_ngo_v1`.`grant`.`solicitation` ALTER COLUMN `go_no_go_decision_date` SET TAGS ('dbx_business_glossary_term' = 'Go/No-Go Decision Date');
ALTER TABLE `vibe_ngo_v1`.`grant`.`solicitation` ALTER COLUMN `go_no_go_rationale` SET TAGS ('dbx_business_glossary_term' = 'Go/No-Go Decision Rationale');
ALTER TABLE `vibe_ngo_v1`.`grant`.`solicitation` ALTER COLUMN `identified_by` SET TAGS ('dbx_business_glossary_term' = 'Identified By');
ALTER TABLE `vibe_ngo_v1`.`grant`.`solicitation` ALTER COLUMN `identified_date` SET TAGS ('dbx_business_glossary_term' = 'Identified Date');
ALTER TABLE `vibe_ngo_v1`.`grant`.`solicitation` ALTER COLUMN `indirect_cost_rate_allowed` SET TAGS ('dbx_business_glossary_term' = 'Indirect Cost Rate Allowed');
ALTER TABLE `vibe_ngo_v1`.`grant`.`solicitation` ALTER COLUMN `indirect_cost_rate_cap` SET TAGS ('dbx_business_glossary_term' = 'Indirect Cost Rate Cap');
ALTER TABLE `vibe_ngo_v1`.`grant`.`solicitation` ALTER COLUMN `internal_priority_score` SET TAGS ('dbx_business_glossary_term' = 'Internal Priority Score');
ALTER TABLE `vibe_ngo_v1`.`grant`.`solicitation` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `vibe_ngo_v1`.`grant`.`solicitation` ALTER COLUMN `local_partner_requirement` SET TAGS ('dbx_business_glossary_term' = 'Local Partner Requirement');
ALTER TABLE `vibe_ngo_v1`.`grant`.`solicitation` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Solicitation Notes');
ALTER TABLE `vibe_ngo_v1`.`grant`.`solicitation` ALTER COLUMN `number` SET TAGS ('dbx_business_glossary_term' = 'Solicitation Number');
ALTER TABLE `vibe_ngo_v1`.`grant`.`solicitation` ALTER COLUMN `program_duration_months` SET TAGS ('dbx_business_glossary_term' = 'Program Duration (Months)');
ALTER TABLE `vibe_ngo_v1`.`grant`.`solicitation` ALTER COLUMN `publication_date` SET TAGS ('dbx_business_glossary_term' = 'Publication Date');
ALTER TABLE `vibe_ngo_v1`.`grant`.`solicitation` ALTER COLUMN `questions_deadline` SET TAGS ('dbx_business_glossary_term' = 'Questions Deadline');
ALTER TABLE `vibe_ngo_v1`.`grant`.`solicitation` ALTER COLUMN `sdg_alignment` SET TAGS ('dbx_business_glossary_term' = 'Sustainable Development Goal (SDG) Alignment');
ALTER TABLE `vibe_ngo_v1`.`grant`.`solicitation` ALTER COLUMN `solicitation_status` SET TAGS ('dbx_business_glossary_term' = 'Solicitation Status');
ALTER TABLE `vibe_ngo_v1`.`grant`.`solicitation` ALTER COLUMN `submission_method` SET TAGS ('dbx_business_glossary_term' = 'Submission Method');
ALTER TABLE `vibe_ngo_v1`.`grant`.`solicitation` ALTER COLUMN `submission_method` SET TAGS ('dbx_value_regex' = 'Online Portal|Email|Physical Mail|Grants.gov|Courier|Hybrid');
ALTER TABLE `vibe_ngo_v1`.`grant`.`solicitation` ALTER COLUMN `submission_requirements` SET TAGS ('dbx_business_glossary_term' = 'Submission Requirements');
ALTER TABLE `vibe_ngo_v1`.`grant`.`solicitation` ALTER COLUMN `thematic_focus_area` SET TAGS ('dbx_business_glossary_term' = 'Thematic Focus Area');
ALTER TABLE `vibe_ngo_v1`.`grant`.`solicitation` ALTER COLUMN `title` SET TAGS ('dbx_business_glossary_term' = 'Solicitation Title');
ALTER TABLE `vibe_ngo_v1`.`grant`.`solicitation` ALTER COLUMN `solicitation_type` SET TAGS ('dbx_business_glossary_term' = 'Solicitation Type');
ALTER TABLE `vibe_ngo_v1`.`grant`.`solicitation` ALTER COLUMN `url` SET TAGS ('dbx_business_glossary_term' = 'Solicitation Uniform Resource Locator (URL)');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_site_allocation` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_site_allocation` SET TAGS ('dbx_subdomain' = 'resource_allocation');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_site_allocation` SET TAGS ('dbx_association_edges' = 'grant.award,field.project_site');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_site_allocation` ALTER COLUMN `award_site_allocation_id` SET TAGS ('dbx_business_glossary_term' = 'Award Site Allocation ID');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_site_allocation` ALTER COLUMN `award_id` SET TAGS ('dbx_business_glossary_term' = 'Award Site Allocation - Award Id');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_site_allocation` ALTER COLUMN `project_site_id` SET TAGS ('dbx_business_glossary_term' = 'Award Site Allocation - Project Site Id');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_site_allocation` ALTER COLUMN `beneficiary_target_at_site` SET TAGS ('dbx_business_glossary_term' = 'Beneficiary Target at Site');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_site_allocation` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Allocation Notes');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_site_allocation` ALTER COLUMN `site_activation_date` SET TAGS ('dbx_business_glossary_term' = 'Site Activation Date');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_site_allocation` ALTER COLUMN `site_budget_allocation` SET TAGS ('dbx_business_glossary_term' = 'Site Budget Allocation');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_site_allocation` ALTER COLUMN `site_deactivation_date` SET TAGS ('dbx_business_glossary_term' = 'Site Deactivation Date');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_site_allocation` ALTER COLUMN `site_role_in_award` SET TAGS ('dbx_business_glossary_term' = 'Site Role in Award');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_site_allocation` ALTER COLUMN `site_status` SET TAGS ('dbx_business_glossary_term' = 'Site Status');
ALTER TABLE `vibe_ngo_v1`.`grant`.`asset_allocation` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `vibe_ngo_v1`.`grant`.`asset_allocation` SET TAGS ('dbx_subdomain' = 'resource_allocation');
ALTER TABLE `vibe_ngo_v1`.`grant`.`asset_allocation` SET TAGS ('dbx_association_edges' = 'grant.award,technology.it_asset');
ALTER TABLE `vibe_ngo_v1`.`grant`.`asset_allocation` ALTER COLUMN `asset_allocation_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Allocation Identifier');
ALTER TABLE `vibe_ngo_v1`.`grant`.`asset_allocation` ALTER COLUMN `award_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Allocation - Award Id');
ALTER TABLE `vibe_ngo_v1`.`grant`.`asset_allocation` ALTER COLUMN `it_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Allocation - It Asset Id');
ALTER TABLE `vibe_ngo_v1`.`grant`.`asset_allocation` ALTER COLUMN `cost_allocated` SET TAGS ('dbx_business_glossary_term' = 'Allocated Cost Amount');
ALTER TABLE `vibe_ngo_v1`.`grant`.`asset_allocation` ALTER COLUMN `depreciation_allocation` SET TAGS ('dbx_business_glossary_term' = 'Allocated Depreciation Amount');
ALTER TABLE `vibe_ngo_v1`.`grant`.`asset_allocation` ALTER COLUMN `disposal_date` SET TAGS ('dbx_business_glossary_term' = 'Asset Disposal Date');
ALTER TABLE `vibe_ngo_v1`.`grant`.`asset_allocation` ALTER COLUMN `donor_approval_date` SET TAGS ('dbx_business_glossary_term' = 'Donor Approval Date');
ALTER TABLE `vibe_ngo_v1`.`grant`.`asset_allocation` ALTER COLUMN `donor_approval_required` SET TAGS ('dbx_business_glossary_term' = 'Donor Approval Required Flag');
ALTER TABLE `vibe_ngo_v1`.`grant`.`asset_allocation` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'Allocation End Date');
ALTER TABLE `vibe_ngo_v1`.`grant`.`asset_allocation` ALTER COLUMN `justification` SET TAGS ('dbx_business_glossary_term' = 'Allocation Justification');
ALTER TABLE `vibe_ngo_v1`.`grant`.`asset_allocation` ALTER COLUMN `percentage` SET TAGS ('dbx_business_glossary_term' = 'Cost Allocation Percentage');
ALTER TABLE `vibe_ngo_v1`.`grant`.`asset_allocation` ALTER COLUMN `percentage` SET TAGS ('dbx_pii_demographic' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`asset_allocation` ALTER COLUMN `purchase_date` SET TAGS ('dbx_business_glossary_term' = 'Asset Purchase Date');
ALTER TABLE `vibe_ngo_v1`.`grant`.`asset_allocation` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Allocation Start Date');
ALTER TABLE `vibe_ngo_v1`.`grant`.`asset_allocation` ALTER COLUMN `asset_allocation_status` SET TAGS ('dbx_business_glossary_term' = 'Allocation Status');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_position_funding` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_position_funding` SET TAGS ('dbx_subdomain' = 'resource_allocation');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_position_funding` SET TAGS ('dbx_association_edges' = 'grant.award,workforce.position');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_position_funding` ALTER COLUMN `award_position_funding_id` SET TAGS ('dbx_business_glossary_term' = 'Award Position Funding ID');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_position_funding` ALTER COLUMN `award_id` SET TAGS ('dbx_business_glossary_term' = 'Award Position Funding - Award Id');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_position_funding` ALTER COLUMN `position_id` SET TAGS ('dbx_business_glossary_term' = 'Award Position Funding - Position Id');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_position_funding` ALTER COLUMN `allocation_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Allocation Currency Code');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_position_funding` ALTER COLUMN `cost_allocation_amount` SET TAGS ('dbx_business_glossary_term' = 'Cost Allocation Amount');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_position_funding` ALTER COLUMN `created_date` SET TAGS ('dbx_business_glossary_term' = 'Created Date');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_position_funding` ALTER COLUMN `effort_percent` SET TAGS ('dbx_business_glossary_term' = 'Effort Percentage');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_position_funding` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'Funding End Date');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_position_funding` ALTER COLUMN `last_modified_date` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Date');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_position_funding` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Allocation Notes');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_position_funding` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Funding Start Date');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_position_funding` ALTER COLUMN `award_position_funding_status` SET TAGS ('dbx_business_glossary_term' = 'Funding Status');
ALTER TABLE `vibe_ngo_v1`.`grant`.`grant_staff_assignment` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `vibe_ngo_v1`.`grant`.`grant_staff_assignment` SET TAGS ('dbx_subdomain' = 'resource_allocation');
ALTER TABLE `vibe_ngo_v1`.`grant`.`grant_staff_assignment` SET TAGS ('dbx_association_edges' = 'grant.award,workforce.staff_member');
ALTER TABLE `vibe_ngo_v1`.`grant`.`grant_staff_assignment` ALTER COLUMN `grant_staff_assignment_id` SET TAGS ('dbx_business_glossary_term' = 'grant_staff_assignment Identifier');
ALTER TABLE `vibe_ngo_v1`.`grant`.`grant_staff_assignment` ALTER COLUMN `award_id` SET TAGS ('dbx_business_glossary_term' = 'Staff Assignment - Award Id');
ALTER TABLE `vibe_ngo_v1`.`grant`.`grant_staff_assignment` ALTER COLUMN `staff_member_id` SET TAGS ('dbx_business_glossary_term' = 'Approving Manager');
ALTER TABLE `vibe_ngo_v1`.`grant`.`grant_staff_assignment` ALTER COLUMN `staff_member_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`grant_staff_assignment` ALTER COLUMN `staff_member_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`grant_staff_assignment` ALTER COLUMN `grant_assigned_staff_member_id` SET TAGS ('dbx_business_glossary_term' = 'Staff Assignment - Staff Member Id');
ALTER TABLE `vibe_ngo_v1`.`grant`.`grant_staff_assignment` ALTER COLUMN `grant_assigned_staff_member_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`grant_staff_assignment` ALTER COLUMN `grant_assigned_staff_member_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`grant_staff_assignment` ALTER COLUMN `workforce_staff_assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Staff Assignment Identifier');
ALTER TABLE `vibe_ngo_v1`.`grant`.`grant_staff_assignment` ALTER COLUMN `assigned_staff_member_id` SET TAGS ('dbx_renamed_from' = 'staff_member_id');
ALTER TABLE `vibe_ngo_v1`.`grant`.`grant_staff_assignment` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Assignment Approval Date');
ALTER TABLE `vibe_ngo_v1`.`grant`.`grant_staff_assignment` ALTER COLUMN `budgeted_fte` SET TAGS ('dbx_business_glossary_term' = 'Budgeted Full-Time Equivalent');
ALTER TABLE `vibe_ngo_v1`.`grant`.`grant_staff_assignment` ALTER COLUMN `cost_allocation_method` SET TAGS ('dbx_business_glossary_term' = 'Cost Allocation Method');
ALTER TABLE `vibe_ngo_v1`.`grant`.`grant_staff_assignment` ALTER COLUMN `effort_percent` SET TAGS ('dbx_business_glossary_term' = 'Effort Percentage');
ALTER TABLE `vibe_ngo_v1`.`grant`.`grant_staff_assignment` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'Assignment End Date');
ALTER TABLE `vibe_ngo_v1`.`grant`.`grant_staff_assignment` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Assignment Notes');
ALTER TABLE `vibe_ngo_v1`.`grant`.`grant_staff_assignment` ALTER COLUMN `role` SET TAGS ('dbx_business_glossary_term' = 'Assignment Role');
ALTER TABLE `vibe_ngo_v1`.`grant`.`grant_staff_assignment` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Assignment Start Date');
ALTER TABLE `vibe_ngo_v1`.`grant`.`grant_staff_assignment` ALTER COLUMN `grant_staff_assignment_status` SET TAGS ('dbx_business_glossary_term' = 'Assignment Status');
