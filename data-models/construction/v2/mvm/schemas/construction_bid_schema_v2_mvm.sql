-- Schema for Domain: bid | Business: Construction | Version: v2_mvm
-- Generated on: 2026-07-10 14:35:52

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_construction_v1`.`bid` COMMENT 'Pre-award commercial pipeline domain owning RFP/RFQ responses, tender submissions, BOQ pricing, project estimation data, win/loss records, bid bond management, and GMP/lump-sum bid preparation. Integrates with Salesforce CRM for opportunity tracking and pipeline forecasting. Tracks bid-to-award conversion rates across market segments.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_construction_v1`.`bid`.`firm_profile` (
    `firm_profile_id` BIGINT COMMENT 'Primary key for firm_profile',
    `annual_revenue_band` STRING COMMENT 'Banded annual revenue range of the subcontracting firm, used for financial capacity assessment during prequalification. Exact revenue figures are not captured to reduce sensitivity; banding provides sufficient granularity for risk tiering.. Valid values are `under_1m|1m_to_5m|5m_to_25m|25m_to_100m|over_100m`',
    `bonding_capacity_usd` DECIMAL(18,2) COMMENT 'Maximum aggregate bonding capacity in US dollars as certified by the firms surety provider. Determines the maximum contract value the firm can be awarded. Critical for large EPC and GMP contract prequalification.',
    `company_registration_number` STRING COMMENT 'Government-issued company registration or incorporation number assigned by the relevant corporate registry (e.g., state secretary of state, Companies House). Used for legal identity verification and compliance checks.',
    `contractor_license_expiry_date` DATE COMMENT 'Expiry date of the firms primary contractor license. Triggers compliance alert workflow when approaching expiry. Firms with expired licenses cannot be awarded new subcontracts.',
    `contractor_license_number` STRING COMMENT 'Primary state or jurisdiction contractor license number held by the firm. Required for legal compliance on construction projects. Multiple licenses may exist; this captures the primary license for the firms home jurisdiction.',
    `contractor_license_state` STRING COMMENT 'Two-letter state code of the jurisdiction that issued the primary contractor license. Used to validate the firms legal authority to perform work in a given state.. Valid values are `^[A-Z]{2}$`',
    `country_of_incorporation` STRING COMMENT 'ISO 3166-1 alpha-3 three-letter country code representing the jurisdiction in which the subcontracting firm is legally incorporated or registered (e.g., USA, AUS, GBR).. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the subcontracting firm profile record was first created in the system. Supports audit trail, data lineage, and GDPR data retention compliance.',
    `dbe_certified` BOOLEAN COMMENT 'Indicates whether the firm holds a valid Disadvantaged Business Enterprise (DBE) certification under the US DOT program. Required for compliance reporting on federally funded highway, airport, and transit projects.',
    `diversity_certification_expiry_date` DATE COMMENT 'Expiry date of the firms most current MBE/WBE/DBE diversity certification. Triggers renewal notification workflow. Expired certifications cannot be counted toward project diversity spend goals.',
    `emr` DECIMAL(18,2) COMMENT 'Experience Modification Rate (EMR) — a workers compensation insurance metric reflecting the firms historical safety performance relative to industry average. An EMR below 1.0 indicates better-than-average safety record. Used as a key HSE prequalification criterion per OSHA guidelines.',
    `emr_reference_year` STRING COMMENT 'The policy year to which the reported EMR value applies. EMR is recalculated annually; this field identifies the vintage of the current EMR on file.',
    `firm_status` STRING COMMENT 'Current lifecycle status of the subcontracting firm within the enterprises approved subcontractor registry. Drives eligibility for bid invitations, trade package awards, and payment processing.. Valid values are `active|inactive|suspended|blacklisted|pending_review`',
    `geographic_coverage_regions` STRING COMMENT 'Comma-separated list of geographic regions or states where the firm is licensed and operationally capable of performing work (e.g., CA,TX,NV,AZ). Used for trade package sourcing and bid list construction.',
    `headquarters_address` STRING COMMENT 'Full street address of the firms registered headquarters or principal place of business. Used for correspondence, legal notices, and geographic coverage analysis.',
    `headquarters_city` STRING COMMENT 'City of the firms registered headquarters or principal place of business.',
    `headquarters_country` STRING COMMENT 'ISO 3166-1 alpha-3 three-letter country code of the firms registered headquarters country.. Valid values are `^[A-Z]{3}$`',
    `headquarters_postal_code` STRING COMMENT 'Postal or ZIP code of the firms registered headquarters address.',
    `headquarters_state` STRING COMMENT 'Two-letter state or province code of the firms registered headquarters.. Valid values are `^[A-Z]{2}$`',
    `insurance_gl_expiry_date` DATE COMMENT 'Expiry date of the firms General Liability (GL) insurance certificate on file. Firms with expired GL insurance are blocked from site mobilization. Tracked separately from workers compensation and professional indemnity.',
    `insurance_wc_expiry_date` DATE COMMENT 'Expiry date of the firms Workers Compensation (WC) insurance certificate on file. Required for all firms deploying labor on construction sites. Expiry triggers compliance hold on site access.',
    `is_union_shop` BOOLEAN COMMENT 'Indicates whether the subcontracting firm operates as a union shop (True) or open/merit shop (False). Determines eligibility for union-mandated project requirements and prevailing wage projects.',
    `iso_45001_certified` BOOLEAN COMMENT 'Indicates whether the firm holds a current ISO 45001 Occupational Health and Safety Management System certification. Used as an HSE prequalification criterion.',
    `iso_9001_certified` BOOLEAN COMMENT 'Indicates whether the firm holds a current ISO 9001 Quality Management System certification. Used as a quality prequalification criterion for projects requiring certified QA/QC systems.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when the subcontracting firm profile record was most recently modified. Used for change tracking, data freshness monitoring, and Silver layer incremental load processing.',
    `leed_accredited` BOOLEAN COMMENT 'Indicates whether the firm holds LEED (Leadership in Energy and Environmental Design) accreditation or employs LEED-accredited professionals. Relevant for green building projects requiring LEED-certified subcontractors.',
    `legal_entity_name` STRING COMMENT 'Full registered legal name of the subcontracting firm as recorded with the relevant government or corporate registry. Used for contract execution, compliance verification, and financial transactions.',
    `mbe_certified` BOOLEAN COMMENT 'Indicates whether the firm holds a valid Minority Business Enterprise (MBE) certification. Used for diversity spend tracking, DBE/MBE/WBE compliance reporting on federally funded projects, and supplier diversity program management.',
    `naics_code` STRING COMMENT 'Six-digit North American Industry Classification System (NAICS) code identifying the firms primary industry sector. Used for regulatory reporting, diversity spend tracking, and market segmentation analytics.. Valid values are `^[0-9]{6}$`',
    `prequalification_expiry_date` DATE COMMENT 'Date on which the firms current prequalification approval expires. Triggers renewal workflow in the subcontractor management system. Firms with expired prequalification cannot be awarded new trade packages.',
    `prequalification_status` STRING COMMENT 'Current prequalification standing of the subcontracting firm against the enterprises vendor qualification criteria. Only firms with approved status are eligible for trade package award. Managed through the subcontractor prequalification process.. Valid values are `approved|conditional|expired|rejected|pending`',
    `primary_contact_email` STRING COMMENT 'Business email address of the primary contact at the subcontracting firm. Used for RFQ/RFP issuance, bid invitations, and contract correspondence via Procore and Aconex.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `primary_contact_name` STRING COMMENT 'Full name of the primary business contact or account manager at the subcontracting firm. Used for bid invitations, RFQ communications, and contract administration correspondence.',
    `primary_contact_phone` STRING COMMENT 'Business phone number of the primary contact at the subcontracting firm, including country and area code.',
    `primary_trade_classification` STRING COMMENT 'The principal construction trade or specialty discipline the firm is classified under (e.g., MEP - Mechanical Electrical Plumbing, Civil Works, Structural Steel, Concrete, Roofing, Earthworks, Specialty). Determines which trade packages the firm is eligible to bid on. [ENUM-REF-CANDIDATE: mep_mechanical|mep_electrical|mep_plumbing|civil|structural_steel|concrete|earthworks|roofing|glazing|fit_out|specialty — promote to reference product]',
    `sic_code` STRING COMMENT 'Four-digit Standard Industrial Classification (SIC) code for the subcontracting firm. Used for legacy regulatory reporting, insurance underwriting, and cross-referencing with older procurement systems.. Valid values are `^[0-9]{4}$`',
    `single_project_bond_limit_usd` DECIMAL(18,2) COMMENT 'Maximum bonding capacity for a single project in US dollars, as distinct from the aggregate bonding capacity. Used to assess the firms eligibility for individual trade package awards.',
    `state_of_incorporation` STRING COMMENT 'Two-letter state or province code where the firm is incorporated or registered (e.g., CA, TX, NY). Relevant for US-based entities for licensing and lien law compliance.. Valid values are `^[A-Z]{2}$`',
    `tax_identification_number` STRING COMMENT 'Federal or national tax identification number for the firm, such as the Employer Identification Number (EIN) in the US or Australian Business Number (ABN) in Australia. Required for IRS/ATO reporting, subcontractor payment processing, and 1099/W-9 compliance.',
    `trading_name` STRING COMMENT 'Operating or doing business as (DBA) name used by the subcontracting firm in day-to-day commercial activities, which may differ from the registered legal entity name.',
    `trir` DECIMAL(18,2) COMMENT 'Total Recordable Incident Rate (TRIR) — the number of OSHA-recordable incidents per 200,000 man-hours worked. A key HSE performance indicator used in subcontractor prequalification and ongoing performance evaluation.',
    `union_affiliation` STRING COMMENT 'Name or code of the labor union(s) the firm is affiliated with (e.g., IBEW, UA, Laborers International). Relevant for union project requirements, prevailing wage compliance, and collective bargaining agreement adherence.',
    `wbe_certified` BOOLEAN COMMENT 'Indicates whether the firm holds a valid Women-Owned Business Enterprise (WBE) certification. Used for diversity spend tracking and compliance reporting on projects with WBE participation goals.',
    `years_in_business` STRING COMMENT 'Number of years the subcontracting firm has been in continuous operation since its founding or incorporation date. Used as a stability and experience indicator in prequalification scoring.',
    CONSTRAINT pk_firm_profile PRIMARY KEY(`firm_profile_id`)
) COMMENT 'Master profile of each subcontracting firm engaged or seeking engagement on construction projects. Captures legal entity name, ABN/EIN/company registration number, trade classifications (MEP, civil, structural, specialty), business registration details, bonding capacity, union affiliations, geographic coverage areas, minority/women-owned business enterprise (MBE/WBE/DBE) certifications, NAICS/SIC codes, annual revenue band, EMR (Experience Modification Rate), and financial standing indicators. This is the SSOT for subcontractor firm identity, distinct from the procurement domains vendor master which governs purchase order relationships.';

CREATE OR REPLACE TABLE `vibe_construction_v1`.`bid`.`bid_opportunity` (
    `bid_opportunity_id` BIGINT COMMENT 'System-generated unique identifier for the bid opportunity record.',
    `account_id` BIGINT COMMENT 'Unique identifier of the client organization that the opportunity targets.',
    `bid_bond_amount` DECIMAL(18,2) COMMENT 'Financial guarantee amount required to submit the bid.',
    `bid_decision` STRING COMMENT 'Decision on whether to submit a bid for the opportunity.. Valid values are `bid|no_bid`',
    `bid_due_date` DATE COMMENT 'Final date by which the bid must be submitted.',
    `country_code` STRING COMMENT 'ISO 3166‑1 alpha‑3 country code of the project location.. Valid values are `[A-Z]{3}`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the bid opportunity record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for the estimated contract value.. Valid values are `[A-Z]{3}`',
    `discount_amount` DECIMAL(18,2) COMMENT 'Any discount applied to the estimated contract value during bid preparation.',
    `estimated_contract_value` DECIMAL(18,2) COMMENT 'Projected total contract value before any adjustments.',
    `expected_end_date` DATE COMMENT 'Planned completion date of the project if the bid is won.',
    `expected_start_date` DATE COMMENT 'Planned start date of the project if the bid is won.',
    `gmp_type` STRING COMMENT 'Type of pricing model used in the bid (e.g., Guaranteed Maximum Price).. Valid values are `gmp|lump_sum|cost_plus`',
    `is_joint_venture` BOOLEAN COMMENT 'Indicates whether the bid is being submitted as a joint venture.',
    `market_segment` STRING COMMENT 'Business segment or market category the opportunity belongs to.. Valid values are `infrastructure|energy|commercial|residential|industrial`',
    `net_estimated_value` DECIMAL(18,2) COMMENT 'Estimated contract value after discounts and adjustments.',
    `notes` STRING COMMENT 'Free‑form text for any supplemental information about the opportunity.',
    `opportunity_name` STRING COMMENT 'Descriptive name of the bid opportunity, typically reflecting the project or client.',
    `opportunity_number` STRING COMMENT 'External reference number assigned to the opportunity, used in client communications and reporting.',
    `pipeline_forecast_category` STRING COMMENT 'Classification used for forecasting and reporting of the opportunity.. Valid values are `pipeline|forecast|committed|won|lost`',
    `probability_of_win` DECIMAL(18,2) COMMENT 'Estimated likelihood of winning the opportunity expressed as a percentage.',
    `project_type` STRING COMMENT 'Classification of the project type for the opportunity.. Valid values are `highway|airport|bridge|power_plant|residential_development|commercial_building`',
    `source_channel` STRING COMMENT 'Origin channel through which the opportunity was generated.. Valid values are `salesforce|referral|partner|website|event`',
    `stage` STRING COMMENT 'Current lifecycle stage of the opportunity within the sales pipeline.. Valid values are `lead|qualified|proposal|submitted|awarded|lost`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the bid opportunity record.',
    `win_loss_status` STRING COMMENT 'Outcome of the opportunity after the bid process concludes.. Valid values are `won|lost|withdrawn|pending`',
    CONSTRAINT pk_bid_opportunity PRIMARY KEY(`bid_opportunity_id`)
) COMMENT 'Master record for each pre-award commercial opportunity tracked in Salesforce CRM. Captures the full pipeline entry from initial lead through bid submission, representing a potential project the business is pursuing. Stores opportunity name, client reference, market segment, project type, estimated contract value, probability of win, bid/no-bid decision, opportunity stage, source channel, geographic region, and pipeline forecast category. SSOT for commercial opportunity identity in the bid domain.';

CREATE OR REPLACE TABLE `vibe_construction_v1`.`bid`.`tender` (
    `tender_id` BIGINT COMMENT 'Unique system-generated identifier for the tender record.',
    `account_id` BIGINT COMMENT 'Identifier of the client/owner for whom the tender is prepared.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Needed for Tender Cost Tracking: associates tender expenses with a finance cost center for accurate cost reporting and compliance with internal budgeting policies.',
    `drawing_id` BIGINT COMMENT 'Foreign key linking to design.drawing. Business justification: Tenders are issued against a defined drawing set. Recording which drawing (or drawing register) was included in the tender package is essential for scope definition, addenda management, and post-award',
    `plan_id` BIGINT COMMENT 'Foreign key linking to quality.plan. Business justification: Tender package requires a Quality Management Plan per client contract; linking ensures plan is attached to each tender.',
    `rfp_issuance_id` BIGINT COMMENT 'Foreign key linking to client.rfp_issuance. Business justification: A tender is the contractors formal response to a client RFP issuance. Construction procurement requires direct traceability from tender to the specific RFP document for compliance, evaluation scoring',
    `staffing_plan_id` BIGINT COMMENT 'Foreign key linking to workforce.staffing_plan. Business justification: Tenders require a staffing plan as part of the technical submission package for prequalification. Linking tender to the staffing plan enables evaluators to validate workforce capacity against tender r',
    `technical_specification_id` BIGINT COMMENT 'Foreign key linking to design.technical_specification. Business justification: Tenders are issued with a defined technical specification package. Procurement teams must record which specification version was included in the tender to manage scope disputes, addenda, and post-awar',
    `award_decision_date` DATE COMMENT 'Date on which the client communicated the award decision.',
    `award_status` STRING COMMENT 'Final outcome status of the tender.. Valid values are `awarded|not_awarded|pending`',
    `bid_bond_amount` DECIMAL(18,2) COMMENT 'Monetary value of the required bid bond.',
    `bid_bond_expiry` DATE COMMENT 'Expiration date of the bid bond.',
    `bid_bond_required` BOOLEAN COMMENT 'Indicates whether a bid bond must be provided with the tender.',
    `bid_bond_type` STRING COMMENT 'Form of the bid bond provided.. Valid values are `bank|insurance|cash`',
    `bid_type` STRING COMMENT 'Indicates whether the tender is for a new contract, renewal, or extension.. Valid values are `new|renewal|extension`',
    `compliance_requirements_met` BOOLEAN COMMENT 'Indicates whether the tender satisfies all mandatory compliance criteria.',
    `confidentiality_flag` BOOLEAN COMMENT 'Indicates whether the tender information is marked as confidential.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the tender record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for monetary amounts. [ENUM-REF-CANDIDATE: many currencies — promote to reference product]',
    `documents_attached` STRING COMMENT 'Number of supporting documents linked to the tender.',
    `estimated_duration_months` STRING COMMENT 'Projected duration of the project in months.',
    `estimated_value` DECIMAL(18,2) COMMENT 'Projected monetary value of the contract if the tender is won.',
    `evaluation_method` STRING COMMENT 'Methodology used by the client to evaluate the tender.. Valid values are `technical|financial|combined`',
    `evaluation_score` DECIMAL(18,2) COMMENT 'Numerical score resulting from the client’s evaluation process.',
    `is_joint_venture` BOOLEAN COMMENT 'Indicates whether the tender is submitted as a joint venture.',
    `joint_venture_partner` STRING COMMENT 'Name of the partner organization in a joint‑venture tender.',
    `notes` STRING COMMENT 'Free‑form comments or remarks related to the tender.',
    `prequalification_status` STRING COMMENT 'Result of the pre‑qualification review for the tendering entity.. Valid values are `qualified|unqualified|pending`',
    `procurement_method` STRING COMMENT 'Method used to procure the project (open, selective, limited).',
    `project_end_date` DATE COMMENT 'Planned completion date of the construction project.',
    `project_location` STRING COMMENT 'Physical location or address of the construction project.',
    `project_start_date` DATE COMMENT 'Planned start date of the construction project.',
    `project_title` STRING COMMENT 'Descriptive title of the construction project associated with the tender.',
    `region_code` STRING COMMENT 'Three‑letter ISO region code for the project location. [ENUM-REF-CANDIDATE: many regions — promote to reference product]',
    `regulatory_approval_required` BOOLEAN COMMENT 'Flag indicating if external regulatory approval is needed for the tender.',
    `regulatory_approval_status` STRING COMMENT 'Current status of any required regulatory approval.. Valid values are `pending|approved|rejected`',
    `risk_rating` STRING COMMENT 'Risk assessment rating assigned to the tender.. Valid values are `low|medium|high|critical`',
    `submission_date` DATE COMMENT 'Actual date the tender was submitted to the client.',
    `submission_deadline` DATE COMMENT 'Last calendar date by which the tender must be submitted.',
    `submission_status` STRING COMMENT 'Current lifecycle status of the tender submission.. Valid values are `draft|submitted|withdrawn|awarded|rejected`',
    `tender_number` STRING COMMENT 'External reference number assigned to the tender by the organization.',
    `tender_type` STRING COMMENT 'Classification of the tender contract model.. Valid values are `lump_sum|gmp|unit_rate|epc|design_build|dbb`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the tender record.',
    `validity_end` DATE COMMENT 'Date when the tender expires if not awarded.',
    `validity_start` DATE COMMENT 'Date when the tender becomes officially valid for consideration.',
    CONSTRAINT pk_tender PRIMARY KEY(`tender_id`)
) COMMENT 'Master record representing a formal tender submission package prepared in response to an RFP or RFQ. Captures tender reference number, project title, client/owner identity, tender type (lump-sum, GMP, unit-rate, EPC), submission deadline, tender validity period, submission status, bid bond requirement flag, prequalification status, and the lead estimator assigned. Links to the parent opportunity and the resulting contract upon award. SSOT for tender identity and submission lifecycle.';

CREATE OR REPLACE TABLE `vibe_construction_v1`.`bid`.`estimate` (
    `estimate_id` BIGINT COMMENT 'Unique system-generated identifier for the cost estimate record.',
    `account_id` BIGINT COMMENT 'Identifier of the client or owner for whom the estimate is prepared.',
    `cost_code_id` BIGINT COMMENT 'Foreign key linking to finance.cost_code. Business justification: Construction estimating requires each estimate to be classified against the company cost code structure for budget-to-estimate comparison reports and post-award cost tracking. Estimators must align pr',
    `drawing_id` BIGINT COMMENT 'Foreign key linking to design.drawing. Business justification: Estimates are prepared from issued-for-tender drawing sets. The drawing package defines the scope being priced. Estimators must trace each estimate back to the specific drawing revision used, which is',
    `labor_cost_code_id` BIGINT COMMENT 'Foreign key linking to workforce.labor_cost_code. Business justification: Estimates are structured using labor cost codes to categorize labor expenditure by trade and skill level. Linking estimate to labor_cost_code ensures estimate categories align with the projects labor',
    `technical_specification_id` BIGINT COMMENT 'Foreign key linking to design.technical_specification. Business justification: Estimates reference technical specifications to price material requirements, testing obligations, and workmanship standards. The spec section drives unit rates and compliance allowances. Every estimat',
    `approved_timestamp` TIMESTAMP COMMENT 'Date‑time when the estimate was formally approved for submission.',
    `base_pricing_date` DATE COMMENT 'Date on which the unit rates and cost data were sourced for the estimate.',
    `estimate_category` STRING COMMENT 'Business category indicating the nature of the work the estimate covers.. Valid values are `new_work|renovation|maintenance|expansion|demolition`',
    `contingency_percentage` DECIMAL(18,2) COMMENT 'Percentage added to cover unknowns and risks in the estimate.',
    `cost_breakdown_version` STRING COMMENT 'Version identifier for the detailed cost breakdown structure used in the estimate.',
    `created_timestamp` TIMESTAMP COMMENT 'Date‑time when the estimate record was first entered into the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 code of the currency used for the estimate.',
    `document_reference` STRING COMMENT 'Identifier or path to the electronic document containing the full estimate details.',
    `escalation_allowance` DECIMAL(18,2) COMMENT 'Allowance expressed as a percentage to account for price escalation over time.',
    `estimate_number` STRING COMMENT 'External reference number assigned to the estimate, used in bid documentation and communications.',
    `estimate_status` STRING COMMENT 'Current lifecycle status of the estimate within the bid process.. Valid values are `draft|submitted|approved|rejected|withdrawn`',
    `estimate_type` STRING COMMENT 'Classification of the estimate based on its level of detail and development stage.. Valid values are `conceptual|schematic|detailed|definitive|preliminary`',
    `estimating_method` STRING COMMENT 'Methodology used to develop the cost estimate.. Valid values are `parametric|unit_rate|first_principles|analogous`',
    `expiration_date` DATE COMMENT 'Date after which the estimate is no longer valid for bid submission.',
    `is_gmp` BOOLEAN COMMENT 'Indicates whether the estimate is prepared as a GMP (True) or not (False).',
    `is_locked` BOOLEAN COMMENT 'True when the estimate is locked from further edits after approval.',
    `is_lump_sum` BOOLEAN COMMENT 'True if the estimate is a lump‑sum price; otherwise False.',
    `estimate_name` STRING COMMENT 'Human‑readable name or title of the estimate for easy identification.',
    `notes` STRING COMMENT 'Free‑form comments or remarks added by the estimator.',
    `overhead_percentage` DECIMAL(18,2) COMMENT 'Overhead cost expressed as a percentage of direct costs.',
    `profit_margin_percentage` DECIMAL(18,2) COMMENT 'Desired profit margin expressed as a percentage of total cost.',
    `revision_date` DATE COMMENT 'Date when the current revision of the estimate was created.',
    `revision_number` STRING COMMENT 'Sequential number indicating the version of the estimate.',
    `risk_factor` DECIMAL(18,2) COMMENT 'Numeric factor representing the overall risk level applied to the estimate.',
    `schedule_impact_days` STRING COMMENT 'Estimated impact on project schedule expressed in days if the estimate is accepted.',
    `total_estimated_cost` DECIMAL(18,2) COMMENT 'Aggregated cost of the estimate before taxes, including all cost components.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date‑time of the most recent modification to the estimate record.',
    CONSTRAINT pk_estimate PRIMARY KEY(`estimate_id`)
) COMMENT 'Master record for a project cost estimate prepared during the bid phase. Captures estimate number, estimate type (conceptual, schematic, detailed, definitive), base date of pricing, total estimated cost, contingency percentage, escalation allowance, overhead and profit margin, currency, estimate status, and the estimating method used (parametric, unit-rate, first-principles). Supports multiple estimate revisions per tender. SSOT for pre-award cost estimation data.';

CREATE OR REPLACE TABLE `vibe_construction_v1`.`bid`.`boq` (
    `boq_id` BIGINT COMMENT 'System‑generated unique identifier for each BOQ master record.',
    `drawing_id` BIGINT COMMENT 'Foreign key linking to design.drawing. Business justification: Required for Quantity Takeoff: BOQ lines are derived from construction drawings; linking each BOQ to its source drawing enables traceability.',
    `labor_rate_id` BIGINT COMMENT 'Foreign key linking to workforce.labor_rate. Business justification: BOQ documents include labour cost totals priced against a specific labor rate schedule. Linking BOQ to the applicable labor rate supports re-pricing when rates change and ensures certified payroll com',
    `technical_specification_id` BIGINT COMMENT 'Foreign key linking to design.technical_specification. Business justification: BOQ preparation requires pricing against specification sections (CSI divisions, material grades, workmanship standards). Estimators reference the governing technical spec to ensure compliance-based un',
    `approval_date` DATE COMMENT 'Calendar date on which the BOQ was signed off by the project controls authority.',
    `approved_by` STRING COMMENT 'Identifier of the individual who granted final approval to the BOQ.',
    `boq_status` STRING COMMENT 'Indicates whether the BOQ is still being edited, has been issued to bidders, approved, revised, or archived.. Valid values are `draft|issued|approved|revised|archived`',
    `boq_type` STRING COMMENT 'Classifies the BOQ as measured (based on take‑off), provisional (estimated), or approximate (high‑level).. Valid values are `measured|provisional|approximate`',
    `contains_confidential_pricing` BOOLEAN COMMENT 'True if the BOQ includes pricing that must be treated as confidential per contract and regulatory policy.',
    `created_timestamp` TIMESTAMP COMMENT 'Exact date‑time the BOQ master record entered the data lake.',
    `currency` STRING COMMENT 'Three‑letter currency identifier (e.g., USD, EUR) used for the total_value field.. Valid values are `^[A-Z]{3}$`',
    `boq_description` STRING COMMENT 'Narrative field for additional context, special instructions, or remarks from the estimator.',
    `exchange_rate` DECIMAL(18,2) COMMENT 'Rate used to convert the BOQ total_value to the companys reporting currency.',
    `exchange_rate_date` DATE COMMENT 'Effective date for the exchange_rate value.',
    `expiry_date` DATE COMMENT 'Optional end‑date after which the BOQ cannot be used for pricing; null if open‑ended.',
    `issue_date` DATE COMMENT 'Date the BOQ was released to bidders as part of the tender package.',
    `preparation_date` DATE COMMENT 'Calendar date on which the BOQ document was initially compiled.',
    `reference` STRING COMMENT 'Human‑readable code used to identify the BOQ within the tender package.',
    `revision_number` STRING COMMENT 'Incremental integer indicating the version of the BOQ; higher numbers represent later revisions.',
    `total_quantity` DECIMAL(18,2) COMMENT 'Aggregate of the quantity field from all BOQ line items, expressed in the unit defined by the specification standard.',
    `total_value` DECIMAL(18,2) COMMENT 'Aggregate price of all line items in the BOQ, expressed in the selected currency.',
    `updated_by` STRING COMMENT 'Login or employee identifier of the last person to modify the BOQ.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date‑time of the latest modification to any BOQ field.',
    `version_label` STRING COMMENT 'Human‑readable version identifier shown on the BOQ cover page.',
    `created_by` STRING COMMENT 'Login or employee identifier of the estimator who initially created the BOQ.',
    CONSTRAINT pk_boq PRIMARY KEY(`boq_id`)
) COMMENT 'Bill of Quantities master record defining the structured pricing document attached to a tender. Captures BOQ reference, revision number, BOQ type (measured, provisional, approximate), total BOQ value, currency, preparation date, and the specification standard applied (NRM, POMI, CESMM). Each BOQ is linked to a tender and decomposed into BOQ line items. SSOT for BOQ document identity and header-level pricing data.';

CREATE OR REPLACE TABLE `vibe_construction_v1`.`bid`.`boq_line` (
    `boq_line_id` BIGINT COMMENT 'Unique identifier for the BOQ line item.',
    `cost_code_id` BIGINT COMMENT 'Foreign key linking to finance.cost_code. Business justification: BOQ line items in construction quantity surveying are classified by cost code to enable cost-type analysis, budget comparison, and post-award cost tracking. Quantity surveyors and estimators expect ev',
    `drawing_id` BIGINT COMMENT 'Foreign key linking to design.drawing. Business justification: BOQ line quantities are taken off from specific drawings. Tracing each BOQ line to its source drawing is required for variation claims, audit trails, and re-measurement contracts. Quantity surveyors a',
    `labor_rate_id` BIGINT COMMENT 'Foreign key linking to workforce.labor_rate. Business justification: Each BOQ line carries a labour_cost value priced using a specific labor rate. Linking at line level enables audit trails for certified payroll compliance, supports re-pricing workflows, and allows est',
    `skill_trade_id` BIGINT COMMENT 'Foreign key linking to workforce.skill_trade. Business justification: BOQ lines are categorized by work_section and cost_category corresponding to specific trades. Linking to skill_trade enables pre-construction labor resource planning — project managers determine which',
    `technical_specification_id` BIGINT COMMENT 'Foreign key linking to design.technical_specification. Business justification: BOQ line items are organized by specification section (work_section currently stored as text). A proper FK to technical_specification enforces referential integrity and enables spec-based cost reporti',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to procurement.vendor. Business justification: BOQ lines may specify sustainable materials; linking each line to the sustainable_material record enables tracking of green procurement.',
    `actual_completion_date` DATE COMMENT 'Date when the work was actually completed.',
    `bid_boq_line_description` STRING COMMENT 'Detailed textual description of the work item.',
    `bid_boq_line_status` STRING COMMENT 'Current lifecycle status of the BOQ line.. Valid values are `draft|submitted|approved|rejected|cancelled`',
    `change_order_flag` BOOLEAN COMMENT 'Indicates if the line originated from a change order.',
    `change_order_number` STRING COMMENT 'Reference number of the associated change order, if any.',
    `cost_category` STRING COMMENT 'Classification of cost type for budgeting and reporting.. Valid values are `direct|indirect|overhead|contingency`',
    `cost_center_code` STRING COMMENT 'Internal cost center associated with the line for accounting.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the line record was created.',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 currency code for monetary values.. Valid values are `USD|EUR|GBP|JPY|CAD|AUD`',
    `estimated_completion_date` DATE COMMENT 'Planned date for completing the work represented by the line.',
    `is_critical_path` BOOLEAN COMMENT 'Marks the line as part of the project critical path.',
    `is_gmp_applicable` BOOLEAN COMMENT 'Indicates if the line is included in a Guaranteed Maximum Price bid.',
    `is_lump_sum` BOOLEAN COMMENT 'Indicates if the line is part of a lump‑sum bid component.',
    `is_taxable` BOOLEAN COMMENT 'Indicates whether the line item is subject to tax.',
    `item_code` STRING COMMENT 'Standardized code for the work item as defined in the companys catalog.',
    `labour_cost` DECIMAL(18,2) COMMENT 'Cost component attributable to labour for the line item.',
    `line_sequence` STRING COMMENT 'Sequential order of the line within the BOQ.',
    `material_cost` DECIMAL(18,2) COMMENT 'Cost component attributable to materials.',
    `notes` STRING COMMENT 'Free‑text field for additional remarks or clarifications.',
    `overhead_amount` DECIMAL(18,2) COMMENT 'Allocated overhead amount for the line item.',
    `plant_cost` DECIMAL(18,2) COMMENT 'Cost component attributable to plant/equipment usage.',
    `profit_margin_percent` DECIMAL(18,2) COMMENT 'Target profit margin percentage applied to the line.',
    `quantity` DECIMAL(18,2) COMMENT 'Quantity of the item required as per take‑off.',
    `revision_number` STRING COMMENT 'Version number of the line item after changes.',
    `risk_level` STRING COMMENT 'Risk classification for the line item.. Valid values are `low|medium|high`',
    `subcontract_cost` DECIMAL(18,2) COMMENT 'Cost component attributable to subcontracted work.',
    `tax_amount` DECIMAL(18,2) COMMENT 'Calculated tax amount for the line item.',
    `tax_rate` DECIMAL(18,2) COMMENT 'Applicable tax rate percentage for taxable items.',
    `total_amount` DECIMAL(18,2) COMMENT 'Calculated total cost for the line (quantity × unit_rate).',
    `unit_of_measure` STRING COMMENT 'Measurement unit for the quantity (e.g., meter, kilogram, piece). [ENUM-REF-CANDIDATE: unit|kg|m|m2|m3|l|pcs|hr — 8 candidates stripped; promote to reference product]',
    `unit_rate` DECIMAL(18,2) COMMENT 'Price per unit of measure for the item.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time of the most recent update to the line record.',
    `wbs_code` STRING COMMENT 'Code linking the line to the project WBS hierarchy.',
    CONSTRAINT pk_boq_line PRIMARY KEY(`boq_line_id`)
) COMMENT 'Individual line item within a Bill of Quantities, representing a discrete work item priced during bid preparation. Captures item code, WBS reference, work section, item description, unit of measure, quantity, unit rate, total amount, labour component, plant component, material component, subcontract component, and overhead allocation. Supports MTO-driven quantity take-off and rate build-up analysis. Essential for bid-to-actual cost variance tracking post-award.';

CREATE OR REPLACE TABLE `vibe_construction_v1`.`bid`.`estimate_line` (
    `estimate_line_id` BIGINT COMMENT 'Unique identifier for the estimate line item.',
    `asset_category_id` BIGINT COMMENT 'Foreign key linking to equipment.asset_category. Business justification: Equipment cost estimating uses asset category benchmark rates (benchmark_utilization_rate, useful_life_years, depreciation_method, capitalization_threshold) to price plant lines in bids. Estimators cl',
    `asset_id` BIGINT COMMENT 'Identifier of plant/equipment associated with the line.',
    `construction_project_id` BIGINT COMMENT 'Identifier of the project to which the estimate belongs.',
    `cost_code_id` BIGINT COMMENT 'Foreign key linking to finance.cost_code. Business justification: Each estimate line item must reference a cost code for cost-type classification, budget alignment, and post-award job cost variance analysis. The plain denormalized `cost_code` text column on estimate',
    `drawing_id` BIGINT COMMENT 'Foreign key linking to design.drawing. Business justification: Individual estimate lines (concrete pour, steel erection, etc.) are derived from quantity take-offs on specific drawings. Linking each line to its source drawing enables scope traceability and support',
    `firm_profile_id` BIGINT COMMENT 'Identifier of the subcontractor providing the service or material.',
    `labor_cost_code_id` BIGINT COMMENT 'Foreign key linking to workforce.labor_cost_code. Business justification: Each estimate line carries a cost_code plain attribute representing a labor cost code. Linking to labor_cost_code enforces referential integrity, ensures active valid codes are used, and supports cert',
    `labor_rate_id` BIGINT COMMENT 'Foreign key linking to workforce.labor_rate. Business justification: Each estimate line may apply a specific labor rate; linking to workforce.labor_rate enables precise labor cost per line in bid estimates.',
    `resource_id` BIGINT COMMENT 'Identifier of the resource (item, equipment, labour) associated with this line.',
    `skill_trade_id` BIGINT COMMENT 'Foreign key linking to workforce.skill_trade. Business justification: Estimate lines carry labor_grade and cost_category attributes tied to specific trade classifications. Linking to skill_trade validates correct prevailing wage rates and union jurisdiction per line — c',
    `technical_specification_id` BIGINT COMMENT 'Foreign key linking to design.technical_specification. Business justification: Estimate lines reference specification sections to determine material grade, testing requirements, and workmanship standards that drive unit cost. The cost_category and source_of_rate fields on estima',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to procurement.vendor. Business justification: REQUIRED: Estimating uses master material data for unit pricing, compliance and spec reference, essential for accurate bid cost calculations.',
    `approval_date` TIMESTAMP COMMENT 'Timestamp when the line was approved.',
    `approved_by` STRING COMMENT 'User identifier of the person who approved the line.',
    `baseline_cost` DECIMAL(18,2) COMMENT 'Original cost captured at baseline creation.',
    `change_order_number` STRING COMMENT 'Reference to a change order that modified this line.',
    `cost_category` STRING COMMENT 'Category of cost represented by the line (e.g., labour, material).. Valid values are `labour|material|plant|subcontract|indirect`',
    `cost_center_code` STRING COMMENT 'Internal cost centre responsible for the line expense.',
    `cost_variance` DECIMAL(18,2) COMMENT 'Difference between revised and baseline cost.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the estimate line was created.',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 currency code for monetary values.',
    `estimate_line_status` STRING COMMENT 'Current lifecycle status of the estimate line.. Valid values are `draft|submitted|approved|rejected|archived`',
    `estimate_version` STRING COMMENT 'Version identifier of the estimate containing this line.',
    `is_deleted` BOOLEAN COMMENT 'Indicates whether the line has been soft‑deleted.',
    `labor_rate_type` STRING COMMENT 'Basis for labour cost calculation.. Valid values are `hourly|daily|weekly`',
    `line_sequence` STRING COMMENT 'Sequential order of the line within the estimate.',
    `location_code` STRING COMMENT 'Code representing the site or geographic location for the line.',
    `material_type` STRING COMMENT 'Classification of material used for the line.. Valid values are `raw|prefab|recycled|other`',
    `notes` STRING COMMENT 'Free‑form comments or remarks about the line.',
    `productivity_factor` DECIMAL(18,2) COMMENT 'Multiplier applied to account for expected productivity (e.g., 1.05).',
    `quantity` DECIMAL(18,2) COMMENT 'Amount of the resource required.',
    `resource_description` STRING COMMENT 'Human‑readable description of the resource.',
    `retention_status` STRING COMMENT 'Retention state of the line for contractual hold‑backs.. Valid values are `retained|released|pending`',
    `revised_cost` DECIMAL(18,2) COMMENT 'Cost after revisions or updates.',
    `risk_factor` DECIMAL(18,2) COMMENT 'Multiplier reflecting risk or contingency applied to the line.',
    `source_of_rate` DECIMAL(18,2) COMMENT 'Origin of the unit cost used for this line.',
    `tax_amount` DECIMAL(18,2) COMMENT 'Monetary tax amount calculated for the line.',
    `tax_rate` DECIMAL(18,2) COMMENT 'Applicable tax rate percentage for the line.',
    `total_cost` DECIMAL(18,2) COMMENT 'Calculated total cost (quantity × unit cost) before adjustments.',
    `unit_cost` DECIMAL(18,2) COMMENT 'Cost per unit of the resource in the selected currency.',
    `unit_of_measure` STRING COMMENT 'Unit used for the quantity (e.g., meters, kilograms).. Valid values are `m|kg|m2|m3|hour|unit`',
    `updated_by` STRING COMMENT 'User identifier who last modified the line.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time of the most recent modification to the line.',
    `variance_reason` STRING COMMENT 'Explanation for the cost variance.',
    `waste_factor` DECIMAL(18,2) COMMENT 'Multiplier to include anticipated material waste.',
    `wbs_element` STRING COMMENT 'WBS code that groups this line within the project hierarchy.',
    `created_by` STRING COMMENT 'User identifier who created the line.',
    CONSTRAINT pk_estimate_line PRIMARY KEY(`estimate_line_id`)
) COMMENT 'Detailed cost line item within a project estimate, capturing the granular cost build-up for a specific work package or activity. Stores cost code, WBS element, cost category (labour, material, plant, subcontract, indirect), resource description, quantity, unit, unit cost, total cost, productivity factor, waste factor, and source of rate (historical, vendor quote, published index). Enables detailed cost-to-complete analysis and estimate benchmarking.';

CREATE OR REPLACE TABLE `vibe_construction_v1`.`bid`.`submission` (
    `submission_id` BIGINT COMMENT 'Unique identifier for the bid submission event.',
    `account_id` BIGINT COMMENT 'Identifier of the client/owner of the tender.',
    `drawing_id` BIGINT COMMENT 'Foreign key linking to design.drawing. Business justification: Bidder submissions are priced against a specific drawing set. Linking submission to the drawing package confirms the scope basis for commercial evaluation and is required for post-award scope dispute ',
    `firm_profile_id` BIGINT COMMENT 'Foreign key linking to bid.firm_profile. Business justification: Required for the Bid Submission Tracking report, which records which firm submitted each bid; essential for award decision and compliance audit.',
    `staffing_plan_id` BIGINT COMMENT 'Foreign key linking to workforce.staffing_plan. Business justification: Bid submissions include a staffing plan as a technical deliverable demonstrating workforce capability to the client. Linking submission to the staffing plan it references supports bid evaluation scori',
    `technical_specification_id` BIGINT COMMENT 'Foreign key linking to design.technical_specification. Business justification: Submissions confirm technical compliance against a specific specification version. Commercial evaluation scores technical compliance; the technical_score field on submission is meaningless without kno',
    `acknowledgement_reference` STRING COMMENT 'Reference number received from the client confirming receipt.',
    `bid_bond_amount` DECIMAL(18,2) COMMENT 'Monetary amount of the bid bond required for this submission.',
    `bid_bond_expiry` DATE COMMENT 'Expiration date of the bid bond.',
    `bid_bond_type` STRING COMMENT 'Type of bid bond provided.. Valid values are `performance|payment|security|none`',
    `bid_price` DECIMAL(18,2) COMMENT 'Total monetary amount offered in the bid at submission.',
    `bid_price_adjustment` DECIMAL(18,2) COMMENT 'Any adjustment (e.g., discount, fee) applied to the base bid price.',
    `bid_type` STRING COMMENT 'Contractual pricing structure of the bid.. Valid values are `lump_sum|gmp|unit_price|cost_plus`',
    `commercial_score` DECIMAL(18,2) COMMENT 'Score assigned to the commercial portion of the bid.',
    `compliance_requirements_met` BOOLEAN COMMENT 'True if all mandatory compliance items were satisfied.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the bid submission record was created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for the bid price.',
    `deadline` DATE COMMENT 'Official deadline date for the tender submission.',
    `documents_attached_count` STRING COMMENT 'Number of supporting documents attached to the submission.',
    `estimated_duration_months` STRING COMMENT 'Projected duration of the project in months as estimated in the bid.',
    `evaluation_method` STRING COMMENT 'Method used to evaluate the bid (e.g., two‑envelope).. Valid values are `two_envelope|single_envelope`',
    `is_joint_venture` BOOLEAN COMMENT 'True if the bid is submitted as a joint venture.',
    `late_submission_flag` BOOLEAN COMMENT 'True if the submission was received after the deadline.',
    `method` STRING COMMENT 'Method used to deliver the bid submission.. Valid values are `electronic|hard_copy|email`',
    `notes` STRING COMMENT 'Free‑form notes entered by the submitter at time of submission.',
    `number_of_copies` STRING COMMENT 'Count of physical copies submitted, if applicable.',
    `project_location` STRING COMMENT 'Free‑form description of the project site location.',
    `reference_number` STRING COMMENT 'External reference number assigned to the bid submission.',
    `region_code` STRING COMMENT 'Three‑letter code representing the geographic region of the project.',
    `risk_rating` STRING COMMENT 'Risk rating assigned to the bid based on evaluation criteria.. Valid values are `low|medium|high`',
    `submission_status` STRING COMMENT 'Current lifecycle status of the bid submission.. Valid values are `draft|submitted|acknowledged|rejected|awarded|cancelled`',
    `submission_timestamp` TIMESTAMP COMMENT 'Date and time when the bid was formally submitted.',
    `technical_score` DECIMAL(18,2) COMMENT 'Score assigned to the technical portion of the bid (if two‑envelope).',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the bid submission record.',
    CONSTRAINT pk_submission PRIMARY KEY(`submission_id`)
) COMMENT 'Transactional record capturing the formal act of submitting a tender to a client or owner. Records submission timestamp, submission method (electronic portal, hard copy, email), submitted by (person), submission reference number, number of copies submitted, bid price at submission, technical score (if two-envelope), commercial score, submission acknowledgement reference, and late submission flag. Represents the definitive bid submission event for audit and compliance purposes.';

CREATE OR REPLACE TABLE `vibe_construction_v1`.`bid`.`bond` (
    `bond_id` BIGINT COMMENT 'Unique identifier for the bid bond record.',
    `construction_project_id` BIGINT COMMENT 'Reference to the construction project associated with the bid.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Maps bid bond liability to a GL account for proper accounting entry, essential for financial statements and bond guarantee reporting.',
    `tender_id` BIGINT COMMENT 'Reference to the tender to which this bid bond is attached.',
    `amount` DECIMAL(18,2) COMMENT 'Monetary value of the bid bond.',
    `approved_by` STRING COMMENT 'Name or identifier of the person who approved the bid bond.',
    `approved_timestamp` TIMESTAMP COMMENT 'Timestamp when the bid bond was formally approved by the authorized authority.',
    `beneficiary` STRING COMMENT 'Client or project owner that is the beneficiary of the bid bond.',
    `bond_number` STRING COMMENT 'External reference number assigned to the bid bond by the issuing entity.',
    `bond_status` STRING COMMENT 'Current lifecycle status of the bid bond.. Valid values are `issued|submitted|returned|forfeited|extended`',
    `bond_type` STRING COMMENT 'Classification of the bond instrument (e.g., bank guarantee, surety bond, insurance bond).. Valid values are `bank_guarantee|surety_bond|insurance_bond`',
    `compliance_requirements_met` BOOLEAN COMMENT 'True if the bond satisfies all regulatory and client‑specific compliance requirements.',
    `confidentiality_flag` BOOLEAN COMMENT 'Indicates whether the bond details are marked as confidential for internal handling.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the bid bond record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 code of the currency in which the bond amount is expressed.',
    `documents_attached` BOOLEAN COMMENT 'Indicates whether supporting bond documents have been attached to the record.',
    `expiry_date` DATE COMMENT 'Date the bid bond expires or must be returned.',
    `expiry_place` STRING COMMENT 'Geographic location where the bond is to be returned or expires.',
    `extension_count` STRING COMMENT 'Total count of times the bond expiry has been extended.',
    `guarantee_extension_allowed` BOOLEAN COMMENT 'Indicates whether the bond terms permit extensions.',
    `guarantee_extension_reason` STRING COMMENT 'Reason provided for the most recent bond extension.',
    `issue_date` DATE COMMENT 'Date the bid bond was formally issued.',
    `issue_place` STRING COMMENT 'Geographic location (city/country) where the bond was issued.',
    `issuer_type` STRING COMMENT 'Category of the issuing entity: bank, surety, or insurance.. Valid values are `bank|surety|insurance`',
    `issuing_entity` STRING COMMENT 'Name of the bank, surety, or insurance company that issued the bid bond.',
    `last_extension_date` DATE COMMENT 'Date of the most recent expiry extension.',
    `last_updated_by` STRING COMMENT 'User identifier who performed the most recent update to the record.',
    `notes` STRING COMMENT 'Free‑form comments or remarks about the bid bond.',
    `percentage` DECIMAL(18,2) COMMENT 'Bond amount expressed as a percentage of the total tender value.',
    `risk_rating` STRING COMMENT 'Risk assessment rating assigned to the bond based on financial and contractual factors.. Valid values are `low|medium|high`',
    `status_date` DATE COMMENT 'Date on which the current status became effective.',
    `total_extension_days` STRING COMMENT 'Cumulative number of days added to the original expiry date through extensions.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the bid bond record.',
    CONSTRAINT pk_bond PRIMARY KEY(`bond_id`)
) COMMENT 'Master record for a bid bond (tender guarantee) instrument required as part of a tender submission. Captures bond reference number, issuing bank or surety, bond amount, bond currency, bond percentage of tender value, issue date, expiry date, bond type (bank guarantee, surety bond, insurance bond), beneficiary (client), bond status (issued, submitted, returned, forfeited, extended), and extension history. Tracks bond lifecycle from issuance through return or forfeiture.';

CREATE OR REPLACE TABLE `vibe_construction_v1`.`bid`.`win_loss_record` (
    `win_loss_record_id` BIGINT COMMENT 'System-generated unique identifier for the win/loss record.',
    `account_id` BIGINT COMMENT 'Foreign key linking to client.account. Business justification: Win/loss record may reference the JV partner involved in the bid; replace string with FK to jv_partner.',
    `asset_id` BIGINT COMMENT 'Foreign key linking to equipment.asset. Business justification: After award, the project commits to a carbon reduction target; linking win/loss record to carbon_target captures this commitment.',
    `client_opportunity_id` BIGINT COMMENT 'Foreign key linking to client.client_opportunity. Business justification: CRM win/loss reporting requires tracing bid outcomes directly to client opportunities. Construction BD teams track win rates per client opportunity for pipeline accuracy, lessons-learned, and relation',
    `construction_project_id` BIGINT COMMENT 'Identifier of the project for which the tender was issued.',
    `contact_id` BIGINT COMMENT 'Foreign key linking to client.contact. Business justification: Construction BD teams record which client contact made the award decision for relationship intelligence and future bid strategy. Win/loss analysis by decision-maker contact is a named CRM process. Rol',
    `submission_id` BIGINT COMMENT 'Identifier of the bid associated with this win/loss outcome.',
    `tender_id` BIGINT COMMENT 'Identifier of the tender (RFP/RFQ) that generated the bid.',
    `vendor_id` BIGINT COMMENT 'Identifier of the competitor that won the tender when this record represents a loss.',
    `awarded_contract_value` DECIMAL(18,2) COMMENT 'Total monetary value of the contract awarded to the winning bidder.',
    `bid_bond_amount` DECIMAL(18,2) COMMENT 'Monetary amount of the bid bond required for the tender.',
    `bid_bond_type` STRING COMMENT 'Form of security provided as a bid bond.. Valid values are `cash|bank_guarantee|insurance|other`',
    `bid_type` STRING COMMENT 'Classification of the bid pricing strategy.. Valid values are `gmp|lump_sum|cost_plus|unit_price|other`',
    `competitor_count` STRING COMMENT 'Count of distinct bidders that participated in the tender.',
    `contract_end_date` DATE COMMENT 'Scheduled completion date of the awarded contract.',
    `contract_start_date` DATE COMMENT 'Scheduled start date of the awarded contract.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the win/loss record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for the awarded contract value.. Valid values are `^[A-Z]{3}$`',
    `decision_timestamp` TIMESTAMP COMMENT 'Date‑time when the final decision for the tender was recorded.',
    `evaluation_method` STRING COMMENT 'Method used to evaluate bids (e.g., technical, combined, price‑only).. Valid values are `technical|combined|price_only|other`',
    `evaluation_score_commercial` DECIMAL(18,2) COMMENT 'Score assigned to the bid for commercial criteria (0‑100 scale).',
    `evaluation_score_hsse` DECIMAL(18,2) COMMENT 'Score for Health, Safety, Security, and Environment criteria (0‑100 scale).',
    `evaluation_score_technical` DECIMAL(18,2) COMMENT 'Score assigned to the bid for technical criteria (0‑100 scale).',
    `is_award_confirmed` BOOLEAN COMMENT 'True when the award has been formally confirmed by the client.',
    `is_joint_venture` BOOLEAN COMMENT 'True if the bid was submitted as a joint venture.',
    `lessons_learned_reference` STRING COMMENT 'Link or identifier to the document containing lessons learned from this bid.',
    `loss_reason_category` STRING COMMENT 'High‑level classification of why the bid was not successful.',
    `loss_reason_narrative` STRING COMMENT 'Detailed free‑text explanation of the loss reason.',
    `outcome_status` STRING COMMENT 'Current outcome of the tender competition (won, lost, withdrawn, or cancelled).. Valid values are `won|lost|withdrawn|cancelled`',
    `price_gap_to_winner` DECIMAL(18,2) COMMENT 'Difference between this bids price and the winning bid price.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the win/loss record.',
    `win_loss_number` STRING COMMENT 'Human‑readable reference number for the win/loss record, used in reporting and communications.',
    `winning_bid_price` DECIMAL(18,2) COMMENT 'Monetary amount of the winning bid, if disclosed by the client.',
    CONSTRAINT pk_win_loss_record PRIMARY KEY(`win_loss_record_id`)
) COMMENT 'Transactional record capturing the outcome of a tender competition, recording whether the bid was won, lost, withdrawn, or cancelled. Stores outcome status, award date, awarded contract value, competitor count, winning bidder (if lost), winning bid price (if disclosed), price gap to winner, evaluation criteria scores (technical, commercial, HSSE), loss reason category, loss reason narrative, and lessons-learned reference. Feeds bid-to-award conversion rate analytics and competitive intelligence.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_construction_v1`.`bid`.`estimate_line` ADD CONSTRAINT `fk_bid_estimate_line_firm_profile_id` FOREIGN KEY (`firm_profile_id`) REFERENCES `vibe_construction_v1`.`bid`.`firm_profile`(`firm_profile_id`);
ALTER TABLE `vibe_construction_v1`.`bid`.`submission` ADD CONSTRAINT `fk_bid_submission_firm_profile_id` FOREIGN KEY (`firm_profile_id`) REFERENCES `vibe_construction_v1`.`bid`.`firm_profile`(`firm_profile_id`);
ALTER TABLE `vibe_construction_v1`.`bid`.`bond` ADD CONSTRAINT `fk_bid_bond_tender_id` FOREIGN KEY (`tender_id`) REFERENCES `vibe_construction_v1`.`bid`.`tender`(`tender_id`);
ALTER TABLE `vibe_construction_v1`.`bid`.`win_loss_record` ADD CONSTRAINT `fk_bid_win_loss_record_submission_id` FOREIGN KEY (`submission_id`) REFERENCES `vibe_construction_v1`.`bid`.`submission`(`submission_id`);
ALTER TABLE `vibe_construction_v1`.`bid`.`win_loss_record` ADD CONSTRAINT `fk_bid_win_loss_record_tender_id` FOREIGN KEY (`tender_id`) REFERENCES `vibe_construction_v1`.`bid`.`tender`(`tender_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_construction_v1`.`bid` SET TAGS ('dbx_division' = 'business');
ALTER SCHEMA `vibe_construction_v1`.`bid` SET TAGS ('dbx_domain' = 'bid');
ALTER TABLE `vibe_construction_v1`.`bid`.`firm_profile` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_construction_v1`.`bid`.`firm_profile` SET TAGS ('dbx_subdomain' = 'proposal_development');
ALTER TABLE `vibe_construction_v1`.`bid`.`firm_profile` ALTER COLUMN `firm_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Firm Profile Identifier');
ALTER TABLE `vibe_construction_v1`.`bid`.`firm_profile` ALTER COLUMN `annual_revenue_band` SET TAGS ('dbx_business_glossary_term' = 'Annual Revenue Band');
ALTER TABLE `vibe_construction_v1`.`bid`.`firm_profile` ALTER COLUMN `annual_revenue_band` SET TAGS ('dbx_value_regex' = 'under_1m|1m_to_5m|5m_to_25m|25m_to_100m|over_100m');
ALTER TABLE `vibe_construction_v1`.`bid`.`firm_profile` ALTER COLUMN `annual_revenue_band` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`bid`.`firm_profile` ALTER COLUMN `bonding_capacity_usd` SET TAGS ('dbx_business_glossary_term' = 'Bonding Capacity (USD)');
ALTER TABLE `vibe_construction_v1`.`bid`.`firm_profile` ALTER COLUMN `bonding_capacity_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`bid`.`firm_profile` ALTER COLUMN `bonding_capacity_usd` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_construction_v1`.`bid`.`firm_profile` ALTER COLUMN `company_registration_number` SET TAGS ('dbx_business_glossary_term' = 'Company Registration Number');
ALTER TABLE `vibe_construction_v1`.`bid`.`firm_profile` ALTER COLUMN `company_registration_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`bid`.`firm_profile` ALTER COLUMN `contractor_license_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Contractor License Expiry Date');
ALTER TABLE `vibe_construction_v1`.`bid`.`firm_profile` ALTER COLUMN `contractor_license_expiry_date` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_construction_v1`.`bid`.`firm_profile` ALTER COLUMN `contractor_license_number` SET TAGS ('dbx_business_glossary_term' = 'Contractor License Number');
ALTER TABLE `vibe_construction_v1`.`bid`.`firm_profile` ALTER COLUMN `contractor_license_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`bid`.`firm_profile` ALTER COLUMN `contractor_license_number` SET TAGS ('dbx_pii_national_id' = 'true');
ALTER TABLE `vibe_construction_v1`.`bid`.`firm_profile` ALTER COLUMN `contractor_license_state` SET TAGS ('dbx_business_glossary_term' = 'Contractor License State');
ALTER TABLE `vibe_construction_v1`.`bid`.`firm_profile` ALTER COLUMN `contractor_license_state` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}$');
ALTER TABLE `vibe_construction_v1`.`bid`.`firm_profile` ALTER COLUMN `contractor_license_state` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_construction_v1`.`bid`.`firm_profile` ALTER COLUMN `country_of_incorporation` SET TAGS ('dbx_business_glossary_term' = 'Country of Incorporation');
ALTER TABLE `vibe_construction_v1`.`bid`.`firm_profile` ALTER COLUMN `country_of_incorporation` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_construction_v1`.`bid`.`firm_profile` ALTER COLUMN `country_of_incorporation` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_construction_v1`.`bid`.`firm_profile` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_construction_v1`.`bid`.`firm_profile` ALTER COLUMN `dbe_certified` SET TAGS ('dbx_business_glossary_term' = 'Disadvantaged Business Enterprise (DBE) Certified');
ALTER TABLE `vibe_construction_v1`.`bid`.`firm_profile` ALTER COLUMN `diversity_certification_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Diversity Certification Expiry Date');
ALTER TABLE `vibe_construction_v1`.`bid`.`firm_profile` ALTER COLUMN `diversity_certification_expiry_date` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_construction_v1`.`bid`.`firm_profile` ALTER COLUMN `emr` SET TAGS ('dbx_business_glossary_term' = 'Experience Modification Rate (EMR)');
ALTER TABLE `vibe_construction_v1`.`bid`.`firm_profile` ALTER COLUMN `emr` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`bid`.`firm_profile` ALTER COLUMN `emr_reference_year` SET TAGS ('dbx_business_glossary_term' = 'Experience Modification Rate (EMR) Reference Year');
ALTER TABLE `vibe_construction_v1`.`bid`.`firm_profile` ALTER COLUMN `firm_status` SET TAGS ('dbx_business_glossary_term' = 'Firm Status');
ALTER TABLE `vibe_construction_v1`.`bid`.`firm_profile` ALTER COLUMN `firm_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|blacklisted|pending_review');
ALTER TABLE `vibe_construction_v1`.`bid`.`firm_profile` ALTER COLUMN `geographic_coverage_regions` SET TAGS ('dbx_business_glossary_term' = 'Geographic Coverage Regions');
ALTER TABLE `vibe_construction_v1`.`bid`.`firm_profile` ALTER COLUMN `geographic_coverage_regions` SET TAGS ('dbx_pii_location' = 'true');
ALTER TABLE `vibe_construction_v1`.`bid`.`firm_profile` ALTER COLUMN `headquarters_address` SET TAGS ('dbx_business_glossary_term' = 'Headquarters Address');
ALTER TABLE `vibe_construction_v1`.`bid`.`firm_profile` ALTER COLUMN `headquarters_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`bid`.`firm_profile` ALTER COLUMN `headquarters_address` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_construction_v1`.`bid`.`firm_profile` ALTER COLUMN `headquarters_city` SET TAGS ('dbx_business_glossary_term' = 'Headquarters City');
ALTER TABLE `vibe_construction_v1`.`bid`.`firm_profile` ALTER COLUMN `headquarters_city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`bid`.`firm_profile` ALTER COLUMN `headquarters_city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_construction_v1`.`bid`.`firm_profile` ALTER COLUMN `headquarters_country` SET TAGS ('dbx_business_glossary_term' = 'Headquarters Country');
ALTER TABLE `vibe_construction_v1`.`bid`.`firm_profile` ALTER COLUMN `headquarters_country` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_construction_v1`.`bid`.`firm_profile` ALTER COLUMN `headquarters_country` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_construction_v1`.`bid`.`firm_profile` ALTER COLUMN `headquarters_postal_code` SET TAGS ('dbx_business_glossary_term' = 'Headquarters Postal Code');
ALTER TABLE `vibe_construction_v1`.`bid`.`firm_profile` ALTER COLUMN `headquarters_postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`bid`.`firm_profile` ALTER COLUMN `headquarters_postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_construction_v1`.`bid`.`firm_profile` ALTER COLUMN `headquarters_state` SET TAGS ('dbx_business_glossary_term' = 'Headquarters State');
ALTER TABLE `vibe_construction_v1`.`bid`.`firm_profile` ALTER COLUMN `headquarters_state` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}$');
ALTER TABLE `vibe_construction_v1`.`bid`.`firm_profile` ALTER COLUMN `headquarters_state` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`bid`.`firm_profile` ALTER COLUMN `headquarters_state` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_construction_v1`.`bid`.`firm_profile` ALTER COLUMN `insurance_gl_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'General Liability (GL) Insurance Expiry Date');
ALTER TABLE `vibe_construction_v1`.`bid`.`firm_profile` ALTER COLUMN `insurance_gl_expiry_date` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_construction_v1`.`bid`.`firm_profile` ALTER COLUMN `insurance_wc_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Workers Compensation (WC) Insurance Expiry Date');
ALTER TABLE `vibe_construction_v1`.`bid`.`firm_profile` ALTER COLUMN `insurance_wc_expiry_date` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_construction_v1`.`bid`.`firm_profile` ALTER COLUMN `is_union_shop` SET TAGS ('dbx_business_glossary_term' = 'Union Shop Indicator');
ALTER TABLE `vibe_construction_v1`.`bid`.`firm_profile` ALTER COLUMN `iso_45001_certified` SET TAGS ('dbx_business_glossary_term' = 'ISO 45001 Occupational Health and Safety Certified');
ALTER TABLE `vibe_construction_v1`.`bid`.`firm_profile` ALTER COLUMN `iso_9001_certified` SET TAGS ('dbx_business_glossary_term' = 'ISO 9001 Quality Management System Certified');
ALTER TABLE `vibe_construction_v1`.`bid`.`firm_profile` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `vibe_construction_v1`.`bid`.`firm_profile` ALTER COLUMN `leed_accredited` SET TAGS ('dbx_business_glossary_term' = 'Leadership in Energy and Environmental Design (LEED) Accredited');
ALTER TABLE `vibe_construction_v1`.`bid`.`firm_profile` ALTER COLUMN `legal_entity_name` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Name');
ALTER TABLE `vibe_construction_v1`.`bid`.`firm_profile` ALTER COLUMN `legal_entity_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`bid`.`firm_profile` ALTER COLUMN `legal_entity_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_construction_v1`.`bid`.`firm_profile` ALTER COLUMN `mbe_certified` SET TAGS ('dbx_business_glossary_term' = 'Minority Business Enterprise (MBE) Certified');
ALTER TABLE `vibe_construction_v1`.`bid`.`firm_profile` ALTER COLUMN `naics_code` SET TAGS ('dbx_business_glossary_term' = 'North American Industry Classification System (NAICS) Code');
ALTER TABLE `vibe_construction_v1`.`bid`.`firm_profile` ALTER COLUMN `naics_code` SET TAGS ('dbx_value_regex' = '^[0-9]{6}$');
ALTER TABLE `vibe_construction_v1`.`bid`.`firm_profile` ALTER COLUMN `prequalification_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Prequalification Expiry Date');
ALTER TABLE `vibe_construction_v1`.`bid`.`firm_profile` ALTER COLUMN `prequalification_expiry_date` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_construction_v1`.`bid`.`firm_profile` ALTER COLUMN `prequalification_status` SET TAGS ('dbx_business_glossary_term' = 'Prequalification Status');
ALTER TABLE `vibe_construction_v1`.`bid`.`firm_profile` ALTER COLUMN `prequalification_status` SET TAGS ('dbx_value_regex' = 'approved|conditional|expired|rejected|pending');
ALTER TABLE `vibe_construction_v1`.`bid`.`firm_profile` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Email Address');
ALTER TABLE `vibe_construction_v1`.`bid`.`firm_profile` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_construction_v1`.`bid`.`firm_profile` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_construction_v1`.`bid`.`firm_profile` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_construction_v1`.`bid`.`firm_profile` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Name');
ALTER TABLE `vibe_construction_v1`.`bid`.`firm_profile` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_construction_v1`.`bid`.`firm_profile` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_construction_v1`.`bid`.`firm_profile` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Phone Number');
ALTER TABLE `vibe_construction_v1`.`bid`.`firm_profile` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_construction_v1`.`bid`.`firm_profile` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_construction_v1`.`bid`.`firm_profile` ALTER COLUMN `primary_trade_classification` SET TAGS ('dbx_business_glossary_term' = 'Primary Trade Classification');
ALTER TABLE `vibe_construction_v1`.`bid`.`firm_profile` ALTER COLUMN `sic_code` SET TAGS ('dbx_business_glossary_term' = 'Standard Industrial Classification (SIC) Code');
ALTER TABLE `vibe_construction_v1`.`bid`.`firm_profile` ALTER COLUMN `sic_code` SET TAGS ('dbx_value_regex' = '^[0-9]{4}$');
ALTER TABLE `vibe_construction_v1`.`bid`.`firm_profile` ALTER COLUMN `single_project_bond_limit_usd` SET TAGS ('dbx_business_glossary_term' = 'Single Project Bond Limit (USD)');
ALTER TABLE `vibe_construction_v1`.`bid`.`firm_profile` ALTER COLUMN `single_project_bond_limit_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`bid`.`firm_profile` ALTER COLUMN `state_of_incorporation` SET TAGS ('dbx_business_glossary_term' = 'State of Incorporation');
ALTER TABLE `vibe_construction_v1`.`bid`.`firm_profile` ALTER COLUMN `state_of_incorporation` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}$');
ALTER TABLE `vibe_construction_v1`.`bid`.`firm_profile` ALTER COLUMN `state_of_incorporation` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_construction_v1`.`bid`.`firm_profile` ALTER COLUMN `tax_identification_number` SET TAGS ('dbx_business_glossary_term' = 'Tax Identification Number (EIN/ABN/TIN)');
ALTER TABLE `vibe_construction_v1`.`bid`.`firm_profile` ALTER COLUMN `tax_identification_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`bid`.`firm_profile` ALTER COLUMN `tax_identification_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_construction_v1`.`bid`.`firm_profile` ALTER COLUMN `trading_name` SET TAGS ('dbx_business_glossary_term' = 'Trading Name (DBA)');
ALTER TABLE `vibe_construction_v1`.`bid`.`firm_profile` ALTER COLUMN `trading_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`bid`.`firm_profile` ALTER COLUMN `trading_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_construction_v1`.`bid`.`firm_profile` ALTER COLUMN `trir` SET TAGS ('dbx_business_glossary_term' = 'Total Recordable Incident Rate (TRIR)');
ALTER TABLE `vibe_construction_v1`.`bid`.`firm_profile` ALTER COLUMN `trir` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`bid`.`firm_profile` ALTER COLUMN `union_affiliation` SET TAGS ('dbx_business_glossary_term' = 'Union Affiliation');
ALTER TABLE `vibe_construction_v1`.`bid`.`firm_profile` ALTER COLUMN `wbe_certified` SET TAGS ('dbx_business_glossary_term' = 'Women-Owned Business Enterprise (WBE) Certified');
ALTER TABLE `vibe_construction_v1`.`bid`.`firm_profile` ALTER COLUMN `years_in_business` SET TAGS ('dbx_business_glossary_term' = 'Years in Business');
ALTER TABLE `vibe_construction_v1`.`bid`.`bid_opportunity` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_construction_v1`.`bid`.`bid_opportunity` SET TAGS ('dbx_subdomain' = 'opportunity_tracking');
ALTER TABLE `vibe_construction_v1`.`bid`.`bid_opportunity` ALTER COLUMN `bid_opportunity_id` SET TAGS ('dbx_business_glossary_term' = 'Bid Opportunity Identifier (BID_OPP_ID)');
ALTER TABLE `vibe_construction_v1`.`bid`.`bid_opportunity` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Client Identifier (CLIENT_ID)');
ALTER TABLE `vibe_construction_v1`.`bid`.`bid_opportunity` ALTER COLUMN `bid_bond_amount` SET TAGS ('dbx_business_glossary_term' = 'Bid Bond Amount (BID_BOND_AMT)');
ALTER TABLE `vibe_construction_v1`.`bid`.`bid_opportunity` ALTER COLUMN `bid_decision` SET TAGS ('dbx_business_glossary_term' = 'Bid Decision (BID_DECISION)');
ALTER TABLE `vibe_construction_v1`.`bid`.`bid_opportunity` ALTER COLUMN `bid_decision` SET TAGS ('dbx_value_regex' = 'bid|no_bid');
ALTER TABLE `vibe_construction_v1`.`bid`.`bid_opportunity` ALTER COLUMN `bid_due_date` SET TAGS ('dbx_business_glossary_term' = 'Bid Due Date (BID_DUE_DATE)');
ALTER TABLE `vibe_construction_v1`.`bid`.`bid_opportunity` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code (COUNTRY_CODE)');
ALTER TABLE `vibe_construction_v1`.`bid`.`bid_opportunity` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '[A-Z]{3}');
ALTER TABLE `vibe_construction_v1`.`bid`.`bid_opportunity` ALTER COLUMN `country_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_construction_v1`.`bid`.`bid_opportunity` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (CREATED_TS)');
ALTER TABLE `vibe_construction_v1`.`bid`.`bid_opportunity` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (CURR_CODE)');
ALTER TABLE `vibe_construction_v1`.`bid`.`bid_opportunity` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '[A-Z]{3}');
ALTER TABLE `vibe_construction_v1`.`bid`.`bid_opportunity` ALTER COLUMN `discount_amount` SET TAGS ('dbx_business_glossary_term' = 'Discount Amount (DISCOUNT_AMT)');
ALTER TABLE `vibe_construction_v1`.`bid`.`bid_opportunity` ALTER COLUMN `estimated_contract_value` SET TAGS ('dbx_business_glossary_term' = 'Estimated Contract Value (EST_CONTRACT_VAL)');
ALTER TABLE `vibe_construction_v1`.`bid`.`bid_opportunity` ALTER COLUMN `expected_end_date` SET TAGS ('dbx_business_glossary_term' = 'Expected End Date (EXP_END_DATE)');
ALTER TABLE `vibe_construction_v1`.`bid`.`bid_opportunity` ALTER COLUMN `expected_start_date` SET TAGS ('dbx_business_glossary_term' = 'Expected Start Date (EXP_START_DATE)');
ALTER TABLE `vibe_construction_v1`.`bid`.`bid_opportunity` ALTER COLUMN `gmp_type` SET TAGS ('dbx_business_glossary_term' = 'GMP Type (GMP_TYPE)');
ALTER TABLE `vibe_construction_v1`.`bid`.`bid_opportunity` ALTER COLUMN `gmp_type` SET TAGS ('dbx_value_regex' = 'gmp|lump_sum|cost_plus');
ALTER TABLE `vibe_construction_v1`.`bid`.`bid_opportunity` ALTER COLUMN `is_joint_venture` SET TAGS ('dbx_business_glossary_term' = 'Joint Venture Flag (IS_JV)');
ALTER TABLE `vibe_construction_v1`.`bid`.`bid_opportunity` ALTER COLUMN `market_segment` SET TAGS ('dbx_business_glossary_term' = 'Market Segment (MARKET_SEG)');
ALTER TABLE `vibe_construction_v1`.`bid`.`bid_opportunity` ALTER COLUMN `market_segment` SET TAGS ('dbx_value_regex' = 'infrastructure|energy|commercial|residential|industrial');
ALTER TABLE `vibe_construction_v1`.`bid`.`bid_opportunity` ALTER COLUMN `net_estimated_value` SET TAGS ('dbx_business_glossary_term' = 'Net Estimated Value (NET_EST_VAL)');
ALTER TABLE `vibe_construction_v1`.`bid`.`bid_opportunity` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Additional Notes (NOTES)');
ALTER TABLE `vibe_construction_v1`.`bid`.`bid_opportunity` ALTER COLUMN `opportunity_name` SET TAGS ('dbx_business_glossary_term' = 'Opportunity Name (OPP_NAME)');
ALTER TABLE `vibe_construction_v1`.`bid`.`bid_opportunity` ALTER COLUMN `opportunity_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`bid`.`bid_opportunity` ALTER COLUMN `opportunity_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_construction_v1`.`bid`.`bid_opportunity` ALTER COLUMN `opportunity_number` SET TAGS ('dbx_business_glossary_term' = 'Opportunity Number (OPP_NO)');
ALTER TABLE `vibe_construction_v1`.`bid`.`bid_opportunity` ALTER COLUMN `pipeline_forecast_category` SET TAGS ('dbx_business_glossary_term' = 'Pipeline Forecast Category (PIPELINE_CAT)');
ALTER TABLE `vibe_construction_v1`.`bid`.`bid_opportunity` ALTER COLUMN `pipeline_forecast_category` SET TAGS ('dbx_value_regex' = 'pipeline|forecast|committed|won|lost');
ALTER TABLE `vibe_construction_v1`.`bid`.`bid_opportunity` ALTER COLUMN `probability_of_win` SET TAGS ('dbx_business_glossary_term' = 'Probability of Win (PROB_WIN)');
ALTER TABLE `vibe_construction_v1`.`bid`.`bid_opportunity` ALTER COLUMN `project_type` SET TAGS ('dbx_business_glossary_term' = 'Project Type (PROJECT_TYPE)');
ALTER TABLE `vibe_construction_v1`.`bid`.`bid_opportunity` ALTER COLUMN `project_type` SET TAGS ('dbx_value_regex' = 'highway|airport|bridge|power_plant|residential_development|commercial_building');
ALTER TABLE `vibe_construction_v1`.`bid`.`bid_opportunity` ALTER COLUMN `source_channel` SET TAGS ('dbx_business_glossary_term' = 'Source Channel (SOURCE_CHAN)');
ALTER TABLE `vibe_construction_v1`.`bid`.`bid_opportunity` ALTER COLUMN `source_channel` SET TAGS ('dbx_value_regex' = 'salesforce|referral|partner|website|event');
ALTER TABLE `vibe_construction_v1`.`bid`.`bid_opportunity` ALTER COLUMN `stage` SET TAGS ('dbx_business_glossary_term' = 'Opportunity Stage (OPP_STAGE)');
ALTER TABLE `vibe_construction_v1`.`bid`.`bid_opportunity` ALTER COLUMN `stage` SET TAGS ('dbx_value_regex' = 'lead|qualified|proposal|submitted|awarded|lost');
ALTER TABLE `vibe_construction_v1`.`bid`.`bid_opportunity` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp (UPDATED_TS)');
ALTER TABLE `vibe_construction_v1`.`bid`.`bid_opportunity` ALTER COLUMN `win_loss_status` SET TAGS ('dbx_business_glossary_term' = 'Win/Loss Status (WIN_LOSS_STATUS)');
ALTER TABLE `vibe_construction_v1`.`bid`.`bid_opportunity` ALTER COLUMN `win_loss_status` SET TAGS ('dbx_value_regex' = 'won|lost|withdrawn|pending');
ALTER TABLE `vibe_construction_v1`.`bid`.`tender` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_construction_v1`.`bid`.`tender` SET TAGS ('dbx_subdomain' = 'proposal_development');
ALTER TABLE `vibe_construction_v1`.`bid`.`tender` ALTER COLUMN `tender_id` SET TAGS ('dbx_business_glossary_term' = 'Tender ID');
ALTER TABLE `vibe_construction_v1`.`bid`.`tender` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Client ID');
ALTER TABLE `vibe_construction_v1`.`bid`.`tender` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`bid`.`tender` ALTER COLUMN `drawing_id` SET TAGS ('dbx_business_glossary_term' = 'Drawing Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`bid`.`tender` ALTER COLUMN `plan_id` SET TAGS ('dbx_business_glossary_term' = 'Quality Plan Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`bid`.`tender` ALTER COLUMN `rfp_issuance_id` SET TAGS ('dbx_business_glossary_term' = 'Rfp Issuance Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`bid`.`tender` ALTER COLUMN `staffing_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Staffing Plan Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`bid`.`tender` ALTER COLUMN `technical_specification_id` SET TAGS ('dbx_business_glossary_term' = 'Technical Specification Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`bid`.`tender` ALTER COLUMN `award_decision_date` SET TAGS ('dbx_business_glossary_term' = 'Award Decision Date');
ALTER TABLE `vibe_construction_v1`.`bid`.`tender` ALTER COLUMN `award_status` SET TAGS ('dbx_business_glossary_term' = 'Award Status');
ALTER TABLE `vibe_construction_v1`.`bid`.`tender` ALTER COLUMN `award_status` SET TAGS ('dbx_value_regex' = 'awarded|not_awarded|pending');
ALTER TABLE `vibe_construction_v1`.`bid`.`tender` ALTER COLUMN `bid_bond_amount` SET TAGS ('dbx_business_glossary_term' = 'Bid Bond Amount');
ALTER TABLE `vibe_construction_v1`.`bid`.`tender` ALTER COLUMN `bid_bond_expiry` SET TAGS ('dbx_business_glossary_term' = 'Bid Bond Expiry Date');
ALTER TABLE `vibe_construction_v1`.`bid`.`tender` ALTER COLUMN `bid_bond_expiry` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_construction_v1`.`bid`.`tender` ALTER COLUMN `bid_bond_required` SET TAGS ('dbx_business_glossary_term' = 'Bid Bond Required');
ALTER TABLE `vibe_construction_v1`.`bid`.`tender` ALTER COLUMN `bid_bond_type` SET TAGS ('dbx_business_glossary_term' = 'Bid Bond Type');
ALTER TABLE `vibe_construction_v1`.`bid`.`tender` ALTER COLUMN `bid_bond_type` SET TAGS ('dbx_value_regex' = 'bank|insurance|cash');
ALTER TABLE `vibe_construction_v1`.`bid`.`tender` ALTER COLUMN `bid_type` SET TAGS ('dbx_business_glossary_term' = 'Bid Type');
ALTER TABLE `vibe_construction_v1`.`bid`.`tender` ALTER COLUMN `bid_type` SET TAGS ('dbx_value_regex' = 'new|renewal|extension');
ALTER TABLE `vibe_construction_v1`.`bid`.`tender` ALTER COLUMN `compliance_requirements_met` SET TAGS ('dbx_business_glossary_term' = 'Compliance Requirements Met');
ALTER TABLE `vibe_construction_v1`.`bid`.`tender` ALTER COLUMN `confidentiality_flag` SET TAGS ('dbx_business_glossary_term' = 'Confidentiality Flag');
ALTER TABLE `vibe_construction_v1`.`bid`.`tender` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_construction_v1`.`bid`.`tender` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `vibe_construction_v1`.`bid`.`tender` ALTER COLUMN `documents_attached` SET TAGS ('dbx_business_glossary_term' = 'Documents Attached Count');
ALTER TABLE `vibe_construction_v1`.`bid`.`tender` ALTER COLUMN `estimated_duration_months` SET TAGS ('dbx_business_glossary_term' = 'Estimated Duration (Months)');
ALTER TABLE `vibe_construction_v1`.`bid`.`tender` ALTER COLUMN `estimated_value` SET TAGS ('dbx_business_glossary_term' = 'Estimated Tender Value');
ALTER TABLE `vibe_construction_v1`.`bid`.`tender` ALTER COLUMN `evaluation_method` SET TAGS ('dbx_business_glossary_term' = 'Evaluation Method');
ALTER TABLE `vibe_construction_v1`.`bid`.`tender` ALTER COLUMN `evaluation_method` SET TAGS ('dbx_value_regex' = 'technical|financial|combined');
ALTER TABLE `vibe_construction_v1`.`bid`.`tender` ALTER COLUMN `evaluation_score` SET TAGS ('dbx_business_glossary_term' = 'Evaluation Score');
ALTER TABLE `vibe_construction_v1`.`bid`.`tender` ALTER COLUMN `is_joint_venture` SET TAGS ('dbx_business_glossary_term' = 'Joint Venture Flag');
ALTER TABLE `vibe_construction_v1`.`bid`.`tender` ALTER COLUMN `joint_venture_partner` SET TAGS ('dbx_business_glossary_term' = 'Joint Venture Partner');
ALTER TABLE `vibe_construction_v1`.`bid`.`tender` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Tender Notes');
ALTER TABLE `vibe_construction_v1`.`bid`.`tender` ALTER COLUMN `prequalification_status` SET TAGS ('dbx_business_glossary_term' = 'Prequalification Status');
ALTER TABLE `vibe_construction_v1`.`bid`.`tender` ALTER COLUMN `prequalification_status` SET TAGS ('dbx_value_regex' = 'qualified|unqualified|pending');
ALTER TABLE `vibe_construction_v1`.`bid`.`tender` ALTER COLUMN `procurement_method` SET TAGS ('dbx_business_glossary_term' = 'Procurement Method');
ALTER TABLE `vibe_construction_v1`.`bid`.`tender` ALTER COLUMN `project_end_date` SET TAGS ('dbx_business_glossary_term' = 'Project End Date');
ALTER TABLE `vibe_construction_v1`.`bid`.`tender` ALTER COLUMN `project_location` SET TAGS ('dbx_business_glossary_term' = 'Project Location');
ALTER TABLE `vibe_construction_v1`.`bid`.`tender` ALTER COLUMN `project_start_date` SET TAGS ('dbx_business_glossary_term' = 'Project Start Date');
ALTER TABLE `vibe_construction_v1`.`bid`.`tender` ALTER COLUMN `project_title` SET TAGS ('dbx_business_glossary_term' = 'Project Title (PROJ_TITLE)');
ALTER TABLE `vibe_construction_v1`.`bid`.`tender` ALTER COLUMN `project_title` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_construction_v1`.`bid`.`tender` ALTER COLUMN `region_code` SET TAGS ('dbx_business_glossary_term' = 'Region Code (ISO 3166‑1 Alpha‑3)');
ALTER TABLE `vibe_construction_v1`.`bid`.`tender` ALTER COLUMN `region_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_construction_v1`.`bid`.`tender` ALTER COLUMN `regulatory_approval_required` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Approval Required');
ALTER TABLE `vibe_construction_v1`.`bid`.`tender` ALTER COLUMN `regulatory_approval_status` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Approval Status');
ALTER TABLE `vibe_construction_v1`.`bid`.`tender` ALTER COLUMN `regulatory_approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected');
ALTER TABLE `vibe_construction_v1`.`bid`.`tender` ALTER COLUMN `risk_rating` SET TAGS ('dbx_business_glossary_term' = 'Risk Rating');
ALTER TABLE `vibe_construction_v1`.`bid`.`tender` ALTER COLUMN `risk_rating` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `vibe_construction_v1`.`bid`.`tender` ALTER COLUMN `submission_date` SET TAGS ('dbx_business_glossary_term' = 'Submission Date');
ALTER TABLE `vibe_construction_v1`.`bid`.`tender` ALTER COLUMN `submission_deadline` SET TAGS ('dbx_business_glossary_term' = 'Submission Deadline');
ALTER TABLE `vibe_construction_v1`.`bid`.`tender` ALTER COLUMN `submission_status` SET TAGS ('dbx_business_glossary_term' = 'Submission Status');
ALTER TABLE `vibe_construction_v1`.`bid`.`tender` ALTER COLUMN `submission_status` SET TAGS ('dbx_value_regex' = 'draft|submitted|withdrawn|awarded|rejected');
ALTER TABLE `vibe_construction_v1`.`bid`.`tender` ALTER COLUMN `tender_number` SET TAGS ('dbx_business_glossary_term' = 'Tender Number (TENDER_NO)');
ALTER TABLE `vibe_construction_v1`.`bid`.`tender` ALTER COLUMN `tender_type` SET TAGS ('dbx_business_glossary_term' = 'Tender Type (TENDER_TYPE)');
ALTER TABLE `vibe_construction_v1`.`bid`.`tender` ALTER COLUMN `tender_type` SET TAGS ('dbx_value_regex' = 'lump_sum|gmp|unit_rate|epc|design_build|dbb');
ALTER TABLE `vibe_construction_v1`.`bid`.`tender` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_construction_v1`.`bid`.`tender` ALTER COLUMN `validity_end` SET TAGS ('dbx_business_glossary_term' = 'Tender Validity End Date');
ALTER TABLE `vibe_construction_v1`.`bid`.`tender` ALTER COLUMN `validity_start` SET TAGS ('dbx_business_glossary_term' = 'Tender Validity Start Date');
ALTER TABLE `vibe_construction_v1`.`bid`.`estimate` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_construction_v1`.`bid`.`estimate` SET TAGS ('dbx_subdomain' = 'proposal_development');
ALTER TABLE `vibe_construction_v1`.`bid`.`estimate` ALTER COLUMN `estimate_id` SET TAGS ('dbx_business_glossary_term' = 'Estimate ID');
ALTER TABLE `vibe_construction_v1`.`bid`.`estimate` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Client ID');
ALTER TABLE `vibe_construction_v1`.`bid`.`estimate` ALTER COLUMN `cost_code_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Code Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`bid`.`estimate` ALTER COLUMN `drawing_id` SET TAGS ('dbx_business_glossary_term' = 'Drawing Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`bid`.`estimate` ALTER COLUMN `labor_cost_code_id` SET TAGS ('dbx_business_glossary_term' = 'Labor Cost Code Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`bid`.`estimate` ALTER COLUMN `technical_specification_id` SET TAGS ('dbx_business_glossary_term' = 'Technical Specification Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`bid`.`estimate` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `vibe_construction_v1`.`bid`.`estimate` ALTER COLUMN `base_pricing_date` SET TAGS ('dbx_business_glossary_term' = 'Base Pricing Date');
ALTER TABLE `vibe_construction_v1`.`bid`.`estimate` ALTER COLUMN `estimate_category` SET TAGS ('dbx_business_glossary_term' = 'Estimate Category');
ALTER TABLE `vibe_construction_v1`.`bid`.`estimate` ALTER COLUMN `estimate_category` SET TAGS ('dbx_value_regex' = 'new_work|renovation|maintenance|expansion|demolition');
ALTER TABLE `vibe_construction_v1`.`bid`.`estimate` ALTER COLUMN `contingency_percentage` SET TAGS ('dbx_business_glossary_term' = 'Contingency Percentage');
ALTER TABLE `vibe_construction_v1`.`bid`.`estimate` ALTER COLUMN `cost_breakdown_version` SET TAGS ('dbx_business_glossary_term' = 'Cost Breakdown Version');
ALTER TABLE `vibe_construction_v1`.`bid`.`estimate` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_construction_v1`.`bid`.`estimate` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_construction_v1`.`bid`.`estimate` ALTER COLUMN `document_reference` SET TAGS ('dbx_business_glossary_term' = 'Document Reference');
ALTER TABLE `vibe_construction_v1`.`bid`.`estimate` ALTER COLUMN `escalation_allowance` SET TAGS ('dbx_business_glossary_term' = 'Escalation Allowance');
ALTER TABLE `vibe_construction_v1`.`bid`.`estimate` ALTER COLUMN `estimate_number` SET TAGS ('dbx_business_glossary_term' = 'Estimate Number');
ALTER TABLE `vibe_construction_v1`.`bid`.`estimate` ALTER COLUMN `estimate_status` SET TAGS ('dbx_business_glossary_term' = 'Estimate Status');
ALTER TABLE `vibe_construction_v1`.`bid`.`estimate` ALTER COLUMN `estimate_status` SET TAGS ('dbx_value_regex' = 'draft|submitted|approved|rejected|withdrawn');
ALTER TABLE `vibe_construction_v1`.`bid`.`estimate` ALTER COLUMN `estimate_type` SET TAGS ('dbx_business_glossary_term' = 'Estimate Type');
ALTER TABLE `vibe_construction_v1`.`bid`.`estimate` ALTER COLUMN `estimate_type` SET TAGS ('dbx_value_regex' = 'conceptual|schematic|detailed|definitive|preliminary');
ALTER TABLE `vibe_construction_v1`.`bid`.`estimate` ALTER COLUMN `estimating_method` SET TAGS ('dbx_business_glossary_term' = 'Estimating Method');
ALTER TABLE `vibe_construction_v1`.`bid`.`estimate` ALTER COLUMN `estimating_method` SET TAGS ('dbx_value_regex' = 'parametric|unit_rate|first_principles|analogous');
ALTER TABLE `vibe_construction_v1`.`bid`.`estimate` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `vibe_construction_v1`.`bid`.`estimate` ALTER COLUMN `is_gmp` SET TAGS ('dbx_business_glossary_term' = 'Guaranteed Maximum Price Flag');
ALTER TABLE `vibe_construction_v1`.`bid`.`estimate` ALTER COLUMN `is_locked` SET TAGS ('dbx_business_glossary_term' = 'Estimate Locked Flag');
ALTER TABLE `vibe_construction_v1`.`bid`.`estimate` ALTER COLUMN `is_lump_sum` SET TAGS ('dbx_business_glossary_term' = 'Lump‑Sum Estimate Flag');
ALTER TABLE `vibe_construction_v1`.`bid`.`estimate` ALTER COLUMN `estimate_name` SET TAGS ('dbx_business_glossary_term' = 'Estimate Name');
ALTER TABLE `vibe_construction_v1`.`bid`.`estimate` ALTER COLUMN `estimate_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`bid`.`estimate` ALTER COLUMN `estimate_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_construction_v1`.`bid`.`estimate` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Estimate Notes');
ALTER TABLE `vibe_construction_v1`.`bid`.`estimate` ALTER COLUMN `overhead_percentage` SET TAGS ('dbx_business_glossary_term' = 'Overhead Percentage');
ALTER TABLE `vibe_construction_v1`.`bid`.`estimate` ALTER COLUMN `profit_margin_percentage` SET TAGS ('dbx_business_glossary_term' = 'Profit Margin Percentage');
ALTER TABLE `vibe_construction_v1`.`bid`.`estimate` ALTER COLUMN `revision_date` SET TAGS ('dbx_business_glossary_term' = 'Revision Date');
ALTER TABLE `vibe_construction_v1`.`bid`.`estimate` ALTER COLUMN `revision_number` SET TAGS ('dbx_business_glossary_term' = 'Revision Number');
ALTER TABLE `vibe_construction_v1`.`bid`.`estimate` ALTER COLUMN `risk_factor` SET TAGS ('dbx_business_glossary_term' = 'Risk Factor');
ALTER TABLE `vibe_construction_v1`.`bid`.`estimate` ALTER COLUMN `schedule_impact_days` SET TAGS ('dbx_business_glossary_term' = 'Schedule Impact (Days)');
ALTER TABLE `vibe_construction_v1`.`bid`.`estimate` ALTER COLUMN `total_estimated_cost` SET TAGS ('dbx_business_glossary_term' = 'Total Estimated Cost');
ALTER TABLE `vibe_construction_v1`.`bid`.`estimate` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_construction_v1`.`bid`.`boq` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_construction_v1`.`bid`.`boq` SET TAGS ('dbx_subdomain' = 'proposal_development');
ALTER TABLE `vibe_construction_v1`.`bid`.`boq` ALTER COLUMN `boq_id` SET TAGS ('dbx_business_glossary_term' = 'Bill of Quantities ID');
ALTER TABLE `vibe_construction_v1`.`bid`.`boq` ALTER COLUMN `drawing_id` SET TAGS ('dbx_business_glossary_term' = 'Drawing Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`bid`.`boq` ALTER COLUMN `labor_rate_id` SET TAGS ('dbx_business_glossary_term' = 'Labor Rate Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`bid`.`boq` ALTER COLUMN `technical_specification_id` SET TAGS ('dbx_business_glossary_term' = 'Technical Specification Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`bid`.`boq` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'BOQ Approval Date');
ALTER TABLE `vibe_construction_v1`.`bid`.`boq` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `vibe_construction_v1`.`bid`.`boq` ALTER COLUMN `approved_by` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_construction_v1`.`bid`.`boq` ALTER COLUMN `boq_status` SET TAGS ('dbx_business_glossary_term' = 'BOQ Status');
ALTER TABLE `vibe_construction_v1`.`bid`.`boq` ALTER COLUMN `boq_status` SET TAGS ('dbx_value_regex' = 'draft|issued|approved|revised|archived');
ALTER TABLE `vibe_construction_v1`.`bid`.`boq` ALTER COLUMN `boq_type` SET TAGS ('dbx_business_glossary_term' = 'BOQ Type');
ALTER TABLE `vibe_construction_v1`.`bid`.`boq` ALTER COLUMN `boq_type` SET TAGS ('dbx_value_regex' = 'measured|provisional|approximate');
ALTER TABLE `vibe_construction_v1`.`bid`.`boq` ALTER COLUMN `contains_confidential_pricing` SET TAGS ('dbx_business_glossary_term' = 'Confidential Pricing Flag');
ALTER TABLE `vibe_construction_v1`.`bid`.`boq` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_construction_v1`.`bid`.`boq` ALTER COLUMN `currency` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_construction_v1`.`bid`.`boq` ALTER COLUMN `currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_construction_v1`.`bid`.`boq` ALTER COLUMN `boq_description` SET TAGS ('dbx_business_glossary_term' = 'BOQ Description');
ALTER TABLE `vibe_construction_v1`.`bid`.`boq` ALTER COLUMN `exchange_rate` SET TAGS ('dbx_business_glossary_term' = 'Currency Exchange Rate');
ALTER TABLE `vibe_construction_v1`.`bid`.`boq` ALTER COLUMN `exchange_rate_date` SET TAGS ('dbx_business_glossary_term' = 'Exchange Rate Date');
ALTER TABLE `vibe_construction_v1`.`bid`.`boq` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'BOQ Expiry Date');
ALTER TABLE `vibe_construction_v1`.`bid`.`boq` ALTER COLUMN `expiry_date` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_construction_v1`.`bid`.`boq` ALTER COLUMN `issue_date` SET TAGS ('dbx_business_glossary_term' = 'BOQ Issue Date');
ALTER TABLE `vibe_construction_v1`.`bid`.`boq` ALTER COLUMN `preparation_date` SET TAGS ('dbx_business_glossary_term' = 'BOQ Preparation Date');
ALTER TABLE `vibe_construction_v1`.`bid`.`boq` ALTER COLUMN `reference` SET TAGS ('dbx_business_glossary_term' = 'BOQ Reference Number');
ALTER TABLE `vibe_construction_v1`.`bid`.`boq` ALTER COLUMN `revision_number` SET TAGS ('dbx_business_glossary_term' = 'BOQ Revision Number');
ALTER TABLE `vibe_construction_v1`.`bid`.`boq` ALTER COLUMN `total_quantity` SET TAGS ('dbx_business_glossary_term' = 'Total BOQ Quantity');
ALTER TABLE `vibe_construction_v1`.`bid`.`boq` ALTER COLUMN `total_value` SET TAGS ('dbx_business_glossary_term' = 'Total BOQ Value');
ALTER TABLE `vibe_construction_v1`.`bid`.`boq` ALTER COLUMN `total_value` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`bid`.`boq` ALTER COLUMN `total_value` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_construction_v1`.`bid`.`boq` ALTER COLUMN `updated_by` SET TAGS ('dbx_business_glossary_term' = 'Updated By');
ALTER TABLE `vibe_construction_v1`.`bid`.`boq` ALTER COLUMN `updated_by` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_construction_v1`.`bid`.`boq` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_construction_v1`.`bid`.`boq` ALTER COLUMN `version_label` SET TAGS ('dbx_business_glossary_term' = 'BOQ Version Label');
ALTER TABLE `vibe_construction_v1`.`bid`.`boq` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `vibe_construction_v1`.`bid`.`boq` ALTER COLUMN `created_by` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_construction_v1`.`bid`.`boq_line` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_construction_v1`.`bid`.`boq_line` SET TAGS ('dbx_subdomain' = 'proposal_development');
ALTER TABLE `vibe_construction_v1`.`bid`.`boq_line` ALTER COLUMN `boq_line_id` SET TAGS ('dbx_business_glossary_term' = 'BOQ Line ID');
ALTER TABLE `vibe_construction_v1`.`bid`.`boq_line` ALTER COLUMN `cost_code_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Code Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`bid`.`boq_line` ALTER COLUMN `drawing_id` SET TAGS ('dbx_business_glossary_term' = 'Drawing Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`bid`.`boq_line` ALTER COLUMN `labor_rate_id` SET TAGS ('dbx_business_glossary_term' = 'Labor Rate Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`bid`.`boq_line` ALTER COLUMN `skill_trade_id` SET TAGS ('dbx_business_glossary_term' = 'Skill Trade Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`bid`.`boq_line` ALTER COLUMN `technical_specification_id` SET TAGS ('dbx_business_glossary_term' = 'Technical Specification Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`bid`.`boq_line` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Sustainable Material Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`bid`.`boq_line` ALTER COLUMN `actual_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Completion Date');
ALTER TABLE `vibe_construction_v1`.`bid`.`boq_line` ALTER COLUMN `bid_boq_line_description` SET TAGS ('dbx_business_glossary_term' = 'Item Description');
ALTER TABLE `vibe_construction_v1`.`bid`.`boq_line` ALTER COLUMN `bid_boq_line_status` SET TAGS ('dbx_business_glossary_term' = 'Line Status');
ALTER TABLE `vibe_construction_v1`.`bid`.`boq_line` ALTER COLUMN `bid_boq_line_status` SET TAGS ('dbx_value_regex' = 'draft|submitted|approved|rejected|cancelled');
ALTER TABLE `vibe_construction_v1`.`bid`.`boq_line` ALTER COLUMN `change_order_flag` SET TAGS ('dbx_business_glossary_term' = 'Change Order Flag');
ALTER TABLE `vibe_construction_v1`.`bid`.`boq_line` ALTER COLUMN `change_order_number` SET TAGS ('dbx_business_glossary_term' = 'Change Order Number');
ALTER TABLE `vibe_construction_v1`.`bid`.`boq_line` ALTER COLUMN `cost_category` SET TAGS ('dbx_business_glossary_term' = 'Cost Category');
ALTER TABLE `vibe_construction_v1`.`bid`.`boq_line` ALTER COLUMN `cost_category` SET TAGS ('dbx_value_regex' = 'direct|indirect|overhead|contingency');
ALTER TABLE `vibe_construction_v1`.`bid`.`boq_line` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `vibe_construction_v1`.`bid`.`boq_line` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_construction_v1`.`bid`.`boq_line` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_construction_v1`.`bid`.`boq_line` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = 'USD|EUR|GBP|JPY|CAD|AUD');
ALTER TABLE `vibe_construction_v1`.`bid`.`boq_line` ALTER COLUMN `estimated_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Estimated Completion Date');
ALTER TABLE `vibe_construction_v1`.`bid`.`boq_line` ALTER COLUMN `is_critical_path` SET TAGS ('dbx_business_glossary_term' = 'Critical Path Flag');
ALTER TABLE `vibe_construction_v1`.`bid`.`boq_line` ALTER COLUMN `is_gmp_applicable` SET TAGS ('dbx_business_glossary_term' = 'GMP Applicable');
ALTER TABLE `vibe_construction_v1`.`bid`.`boq_line` ALTER COLUMN `is_lump_sum` SET TAGS ('dbx_business_glossary_term' = 'Lump Sum Applicable');
ALTER TABLE `vibe_construction_v1`.`bid`.`boq_line` ALTER COLUMN `is_taxable` SET TAGS ('dbx_business_glossary_term' = 'Is Taxable');
ALTER TABLE `vibe_construction_v1`.`bid`.`boq_line` ALTER COLUMN `item_code` SET TAGS ('dbx_business_glossary_term' = 'Item Code');
ALTER TABLE `vibe_construction_v1`.`bid`.`boq_line` ALTER COLUMN `labour_cost` SET TAGS ('dbx_business_glossary_term' = 'Labour Cost');
ALTER TABLE `vibe_construction_v1`.`bid`.`boq_line` ALTER COLUMN `line_sequence` SET TAGS ('dbx_business_glossary_term' = 'Line Sequence Number');
ALTER TABLE `vibe_construction_v1`.`bid`.`boq_line` ALTER COLUMN `material_cost` SET TAGS ('dbx_business_glossary_term' = 'Material Cost');
ALTER TABLE `vibe_construction_v1`.`bid`.`boq_line` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_construction_v1`.`bid`.`boq_line` ALTER COLUMN `overhead_amount` SET TAGS ('dbx_business_glossary_term' = 'Overhead Allocation');
ALTER TABLE `vibe_construction_v1`.`bid`.`boq_line` ALTER COLUMN `plant_cost` SET TAGS ('dbx_business_glossary_term' = 'Plant Cost');
ALTER TABLE `vibe_construction_v1`.`bid`.`boq_line` ALTER COLUMN `profit_margin_percent` SET TAGS ('dbx_business_glossary_term' = 'Profit Margin (%)');
ALTER TABLE `vibe_construction_v1`.`bid`.`boq_line` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Quantity');
ALTER TABLE `vibe_construction_v1`.`bid`.`boq_line` ALTER COLUMN `revision_number` SET TAGS ('dbx_business_glossary_term' = 'Revision Number');
ALTER TABLE `vibe_construction_v1`.`bid`.`boq_line` ALTER COLUMN `risk_level` SET TAGS ('dbx_business_glossary_term' = 'Risk Level');
ALTER TABLE `vibe_construction_v1`.`bid`.`boq_line` ALTER COLUMN `risk_level` SET TAGS ('dbx_value_regex' = 'low|medium|high');
ALTER TABLE `vibe_construction_v1`.`bid`.`boq_line` ALTER COLUMN `subcontract_cost` SET TAGS ('dbx_business_glossary_term' = 'Subcontract Cost');
ALTER TABLE `vibe_construction_v1`.`bid`.`boq_line` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `vibe_construction_v1`.`bid`.`boq_line` ALTER COLUMN `tax_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_construction_v1`.`bid`.`boq_line` ALTER COLUMN `tax_rate` SET TAGS ('dbx_business_glossary_term' = 'Tax Rate (%)');
ALTER TABLE `vibe_construction_v1`.`bid`.`boq_line` ALTER COLUMN `total_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Amount');
ALTER TABLE `vibe_construction_v1`.`bid`.`boq_line` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `vibe_construction_v1`.`bid`.`boq_line` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_construction_v1`.`bid`.`boq_line` ALTER COLUMN `unit_rate` SET TAGS ('dbx_business_glossary_term' = 'Unit Rate (Currency per UOM)');
ALTER TABLE `vibe_construction_v1`.`bid`.`boq_line` ALTER COLUMN `unit_rate` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_construction_v1`.`bid`.`boq_line` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_construction_v1`.`bid`.`boq_line` ALTER COLUMN `wbs_code` SET TAGS ('dbx_business_glossary_term' = 'Work Breakdown Structure (WBS) Code');
ALTER TABLE `vibe_construction_v1`.`bid`.`estimate_line` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_construction_v1`.`bid`.`estimate_line` SET TAGS ('dbx_subdomain' = 'proposal_development');
ALTER TABLE `vibe_construction_v1`.`bid`.`estimate_line` ALTER COLUMN `estimate_line_id` SET TAGS ('dbx_business_glossary_term' = 'Estimate Line Identifier');
ALTER TABLE `vibe_construction_v1`.`bid`.`estimate_line` ALTER COLUMN `asset_category_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Category Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`bid`.`estimate_line` ALTER COLUMN `asset_id` SET TAGS ('dbx_business_glossary_term' = 'Equipment Identifier');
ALTER TABLE `vibe_construction_v1`.`bid`.`estimate_line` ALTER COLUMN `construction_project_id` SET TAGS ('dbx_business_glossary_term' = 'Project Identifier');
ALTER TABLE `vibe_construction_v1`.`bid`.`estimate_line` ALTER COLUMN `cost_code_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Code Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`bid`.`estimate_line` ALTER COLUMN `drawing_id` SET TAGS ('dbx_business_glossary_term' = 'Drawing Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`bid`.`estimate_line` ALTER COLUMN `firm_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Subcontractor Identifier');
ALTER TABLE `vibe_construction_v1`.`bid`.`estimate_line` ALTER COLUMN `labor_cost_code_id` SET TAGS ('dbx_business_glossary_term' = 'Labor Cost Code Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`bid`.`estimate_line` ALTER COLUMN `labor_rate_id` SET TAGS ('dbx_business_glossary_term' = 'Labor Rate Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`bid`.`estimate_line` ALTER COLUMN `resource_id` SET TAGS ('dbx_business_glossary_term' = 'Resource Identifier');
ALTER TABLE `vibe_construction_v1`.`bid`.`estimate_line` ALTER COLUMN `skill_trade_id` SET TAGS ('dbx_business_glossary_term' = 'Skill Trade Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`bid`.`estimate_line` ALTER COLUMN `technical_specification_id` SET TAGS ('dbx_business_glossary_term' = 'Technical Specification Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`bid`.`estimate_line` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Material Material Master Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`bid`.`estimate_line` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_construction_v1`.`bid`.`estimate_line` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `vibe_construction_v1`.`bid`.`estimate_line` ALTER COLUMN `approved_by` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_construction_v1`.`bid`.`estimate_line` ALTER COLUMN `baseline_cost` SET TAGS ('dbx_business_glossary_term' = 'Baseline Cost');
ALTER TABLE `vibe_construction_v1`.`bid`.`estimate_line` ALTER COLUMN `change_order_number` SET TAGS ('dbx_business_glossary_term' = 'Change Order Number');
ALTER TABLE `vibe_construction_v1`.`bid`.`estimate_line` ALTER COLUMN `cost_category` SET TAGS ('dbx_business_glossary_term' = 'Cost Category');
ALTER TABLE `vibe_construction_v1`.`bid`.`estimate_line` ALTER COLUMN `cost_category` SET TAGS ('dbx_value_regex' = 'labour|material|plant|subcontract|indirect');
ALTER TABLE `vibe_construction_v1`.`bid`.`estimate_line` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `vibe_construction_v1`.`bid`.`estimate_line` ALTER COLUMN `cost_variance` SET TAGS ('dbx_business_glossary_term' = 'Cost Variance');
ALTER TABLE `vibe_construction_v1`.`bid`.`estimate_line` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Creation Timestamp');
ALTER TABLE `vibe_construction_v1`.`bid`.`estimate_line` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_construction_v1`.`bid`.`estimate_line` ALTER COLUMN `estimate_line_status` SET TAGS ('dbx_business_glossary_term' = 'Line Status');
ALTER TABLE `vibe_construction_v1`.`bid`.`estimate_line` ALTER COLUMN `estimate_line_status` SET TAGS ('dbx_value_regex' = 'draft|submitted|approved|rejected|archived');
ALTER TABLE `vibe_construction_v1`.`bid`.`estimate_line` ALTER COLUMN `estimate_version` SET TAGS ('dbx_business_glossary_term' = 'Estimate Version');
ALTER TABLE `vibe_construction_v1`.`bid`.`estimate_line` ALTER COLUMN `is_deleted` SET TAGS ('dbx_business_glossary_term' = 'Is Deleted Flag');
ALTER TABLE `vibe_construction_v1`.`bid`.`estimate_line` ALTER COLUMN `labor_rate_type` SET TAGS ('dbx_business_glossary_term' = 'Labor Rate Type');
ALTER TABLE `vibe_construction_v1`.`bid`.`estimate_line` ALTER COLUMN `labor_rate_type` SET TAGS ('dbx_value_regex' = 'hourly|daily|weekly');
ALTER TABLE `vibe_construction_v1`.`bid`.`estimate_line` ALTER COLUMN `line_sequence` SET TAGS ('dbx_business_glossary_term' = 'Line Sequence Number');
ALTER TABLE `vibe_construction_v1`.`bid`.`estimate_line` ALTER COLUMN `location_code` SET TAGS ('dbx_business_glossary_term' = 'Location Code');
ALTER TABLE `vibe_construction_v1`.`bid`.`estimate_line` ALTER COLUMN `material_type` SET TAGS ('dbx_business_glossary_term' = 'Material Type');
ALTER TABLE `vibe_construction_v1`.`bid`.`estimate_line` ALTER COLUMN `material_type` SET TAGS ('dbx_value_regex' = 'raw|prefab|recycled|other');
ALTER TABLE `vibe_construction_v1`.`bid`.`estimate_line` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Line Notes');
ALTER TABLE `vibe_construction_v1`.`bid`.`estimate_line` ALTER COLUMN `productivity_factor` SET TAGS ('dbx_business_glossary_term' = 'Productivity Factor');
ALTER TABLE `vibe_construction_v1`.`bid`.`estimate_line` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Quantity');
ALTER TABLE `vibe_construction_v1`.`bid`.`estimate_line` ALTER COLUMN `resource_description` SET TAGS ('dbx_business_glossary_term' = 'Resource Description');
ALTER TABLE `vibe_construction_v1`.`bid`.`estimate_line` ALTER COLUMN `retention_status` SET TAGS ('dbx_business_glossary_term' = 'Retention Status');
ALTER TABLE `vibe_construction_v1`.`bid`.`estimate_line` ALTER COLUMN `retention_status` SET TAGS ('dbx_value_regex' = 'retained|released|pending');
ALTER TABLE `vibe_construction_v1`.`bid`.`estimate_line` ALTER COLUMN `revised_cost` SET TAGS ('dbx_business_glossary_term' = 'Revised Cost');
ALTER TABLE `vibe_construction_v1`.`bid`.`estimate_line` ALTER COLUMN `risk_factor` SET TAGS ('dbx_business_glossary_term' = 'Risk Factor');
ALTER TABLE `vibe_construction_v1`.`bid`.`estimate_line` ALTER COLUMN `source_of_rate` SET TAGS ('dbx_business_glossary_term' = 'Source of Rate');
ALTER TABLE `vibe_construction_v1`.`bid`.`estimate_line` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `vibe_construction_v1`.`bid`.`estimate_line` ALTER COLUMN `tax_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_construction_v1`.`bid`.`estimate_line` ALTER COLUMN `tax_rate` SET TAGS ('dbx_business_glossary_term' = 'Tax Rate');
ALTER TABLE `vibe_construction_v1`.`bid`.`estimate_line` ALTER COLUMN `total_cost` SET TAGS ('dbx_business_glossary_term' = 'Total Cost');
ALTER TABLE `vibe_construction_v1`.`bid`.`estimate_line` ALTER COLUMN `unit_cost` SET TAGS ('dbx_business_glossary_term' = 'Unit Cost');
ALTER TABLE `vibe_construction_v1`.`bid`.`estimate_line` ALTER COLUMN `unit_cost` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_construction_v1`.`bid`.`estimate_line` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `vibe_construction_v1`.`bid`.`estimate_line` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_value_regex' = 'm|kg|m2|m3|hour|unit');
ALTER TABLE `vibe_construction_v1`.`bid`.`estimate_line` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_construction_v1`.`bid`.`estimate_line` ALTER COLUMN `updated_by` SET TAGS ('dbx_business_glossary_term' = 'Updated By');
ALTER TABLE `vibe_construction_v1`.`bid`.`estimate_line` ALTER COLUMN `updated_by` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_construction_v1`.`bid`.`estimate_line` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `vibe_construction_v1`.`bid`.`estimate_line` ALTER COLUMN `variance_reason` SET TAGS ('dbx_business_glossary_term' = 'Variance Reason');
ALTER TABLE `vibe_construction_v1`.`bid`.`estimate_line` ALTER COLUMN `waste_factor` SET TAGS ('dbx_business_glossary_term' = 'Waste Factor');
ALTER TABLE `vibe_construction_v1`.`bid`.`estimate_line` ALTER COLUMN `wbs_element` SET TAGS ('dbx_business_glossary_term' = 'Work Breakdown Structure Element');
ALTER TABLE `vibe_construction_v1`.`bid`.`estimate_line` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `vibe_construction_v1`.`bid`.`estimate_line` ALTER COLUMN `created_by` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_construction_v1`.`bid`.`submission` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_construction_v1`.`bid`.`submission` SET TAGS ('dbx_subdomain' = 'proposal_development');
ALTER TABLE `vibe_construction_v1`.`bid`.`submission` ALTER COLUMN `submission_id` SET TAGS ('dbx_business_glossary_term' = 'Bid Submission ID (BSID)');
ALTER TABLE `vibe_construction_v1`.`bid`.`submission` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Client Identifier (CID)');
ALTER TABLE `vibe_construction_v1`.`bid`.`submission` ALTER COLUMN `drawing_id` SET TAGS ('dbx_business_glossary_term' = 'Drawing Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`bid`.`submission` ALTER COLUMN `firm_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Sub Firm Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`bid`.`submission` ALTER COLUMN `staffing_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Staffing Plan Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`bid`.`submission` ALTER COLUMN `technical_specification_id` SET TAGS ('dbx_business_glossary_term' = 'Technical Specification Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`bid`.`submission` ALTER COLUMN `acknowledgement_reference` SET TAGS ('dbx_business_glossary_term' = 'Acknowledgement Reference Number (ARN)');
ALTER TABLE `vibe_construction_v1`.`bid`.`submission` ALTER COLUMN `bid_bond_amount` SET TAGS ('dbx_business_glossary_term' = 'Bid Bond Amount (BBA)');
ALTER TABLE `vibe_construction_v1`.`bid`.`submission` ALTER COLUMN `bid_bond_expiry` SET TAGS ('dbx_business_glossary_term' = 'Bid Bond Expiry Date (BBE)');
ALTER TABLE `vibe_construction_v1`.`bid`.`submission` ALTER COLUMN `bid_bond_expiry` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_construction_v1`.`bid`.`submission` ALTER COLUMN `bid_bond_type` SET TAGS ('dbx_business_glossary_term' = 'Bid Bond Type (BBT)');
ALTER TABLE `vibe_construction_v1`.`bid`.`submission` ALTER COLUMN `bid_bond_type` SET TAGS ('dbx_value_regex' = 'performance|payment|security|none');
ALTER TABLE `vibe_construction_v1`.`bid`.`submission` ALTER COLUMN `bid_price` SET TAGS ('dbx_business_glossary_term' = 'Bid Price (BP)');
ALTER TABLE `vibe_construction_v1`.`bid`.`submission` ALTER COLUMN `bid_price_adjustment` SET TAGS ('dbx_business_glossary_term' = 'Bid Price Adjustment (BPA)');
ALTER TABLE `vibe_construction_v1`.`bid`.`submission` ALTER COLUMN `bid_type` SET TAGS ('dbx_business_glossary_term' = 'Bid Type (BT)');
ALTER TABLE `vibe_construction_v1`.`bid`.`submission` ALTER COLUMN `bid_type` SET TAGS ('dbx_value_regex' = 'lump_sum|gmp|unit_price|cost_plus');
ALTER TABLE `vibe_construction_v1`.`bid`.`submission` ALTER COLUMN `commercial_score` SET TAGS ('dbx_business_glossary_term' = 'Commercial Evaluation Score (CES)');
ALTER TABLE `vibe_construction_v1`.`bid`.`submission` ALTER COLUMN `compliance_requirements_met` SET TAGS ('dbx_business_glossary_term' = 'Compliance Requirements Met Indicator (CRMI)');
ALTER TABLE `vibe_construction_v1`.`bid`.`submission` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (RCT)');
ALTER TABLE `vibe_construction_v1`.`bid`.`submission` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `vibe_construction_v1`.`bid`.`submission` ALTER COLUMN `deadline` SET TAGS ('dbx_business_glossary_term' = 'Submission Deadline Date (SDD)');
ALTER TABLE `vibe_construction_v1`.`bid`.`submission` ALTER COLUMN `documents_attached_count` SET TAGS ('dbx_business_glossary_term' = 'Attached Documents Count (ADC)');
ALTER TABLE `vibe_construction_v1`.`bid`.`submission` ALTER COLUMN `estimated_duration_months` SET TAGS ('dbx_business_glossary_term' = 'Estimated Duration (Months) (EDM)');
ALTER TABLE `vibe_construction_v1`.`bid`.`submission` ALTER COLUMN `evaluation_method` SET TAGS ('dbx_business_glossary_term' = 'Evaluation Method (EM)');
ALTER TABLE `vibe_construction_v1`.`bid`.`submission` ALTER COLUMN `evaluation_method` SET TAGS ('dbx_value_regex' = 'two_envelope|single_envelope');
ALTER TABLE `vibe_construction_v1`.`bid`.`submission` ALTER COLUMN `is_joint_venture` SET TAGS ('dbx_business_glossary_term' = 'Joint Venture Indicator (JVI)');
ALTER TABLE `vibe_construction_v1`.`bid`.`submission` ALTER COLUMN `late_submission_flag` SET TAGS ('dbx_business_glossary_term' = 'Late Submission Indicator (LSI)');
ALTER TABLE `vibe_construction_v1`.`bid`.`submission` ALTER COLUMN `method` SET TAGS ('dbx_business_glossary_term' = 'Submission Method (SM)');
ALTER TABLE `vibe_construction_v1`.`bid`.`submission` ALTER COLUMN `method` SET TAGS ('dbx_value_regex' = 'electronic|hard_copy|email');
ALTER TABLE `vibe_construction_v1`.`bid`.`submission` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Submission Notes (SN)');
ALTER TABLE `vibe_construction_v1`.`bid`.`submission` ALTER COLUMN `number_of_copies` SET TAGS ('dbx_business_glossary_term' = 'Number of Copies Submitted (NCS)');
ALTER TABLE `vibe_construction_v1`.`bid`.`submission` ALTER COLUMN `project_location` SET TAGS ('dbx_business_glossary_term' = 'Project Location Description (PLD)');
ALTER TABLE `vibe_construction_v1`.`bid`.`submission` ALTER COLUMN `reference_number` SET TAGS ('dbx_business_glossary_term' = 'Submission Reference Number (SRN)');
ALTER TABLE `vibe_construction_v1`.`bid`.`submission` ALTER COLUMN `region_code` SET TAGS ('dbx_business_glossary_term' = 'Region Code (RC)');
ALTER TABLE `vibe_construction_v1`.`bid`.`submission` ALTER COLUMN `region_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_construction_v1`.`bid`.`submission` ALTER COLUMN `risk_rating` SET TAGS ('dbx_business_glossary_term' = 'Risk Rating (RR)');
ALTER TABLE `vibe_construction_v1`.`bid`.`submission` ALTER COLUMN `risk_rating` SET TAGS ('dbx_value_regex' = 'low|medium|high');
ALTER TABLE `vibe_construction_v1`.`bid`.`submission` ALTER COLUMN `submission_status` SET TAGS ('dbx_business_glossary_term' = 'Bid Submission Status (BSS)');
ALTER TABLE `vibe_construction_v1`.`bid`.`submission` ALTER COLUMN `submission_status` SET TAGS ('dbx_value_regex' = 'draft|submitted|acknowledged|rejected|awarded|cancelled');
ALTER TABLE `vibe_construction_v1`.`bid`.`submission` ALTER COLUMN `submission_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Bid Submission Timestamp (BST)');
ALTER TABLE `vibe_construction_v1`.`bid`.`submission` ALTER COLUMN `technical_score` SET TAGS ('dbx_business_glossary_term' = 'Technical Evaluation Score (TES)');
ALTER TABLE `vibe_construction_v1`.`bid`.`submission` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp (RUT)');
ALTER TABLE `vibe_construction_v1`.`bid`.`bond` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_construction_v1`.`bid`.`bond` SET TAGS ('dbx_subdomain' = 'proposal_development');
ALTER TABLE `vibe_construction_v1`.`bid`.`bond` ALTER COLUMN `bond_id` SET TAGS ('dbx_business_glossary_term' = 'Bid Bond ID (BB_ID)');
ALTER TABLE `vibe_construction_v1`.`bid`.`bond` ALTER COLUMN `construction_project_id` SET TAGS ('dbx_business_glossary_term' = 'Project Identifier (PROJECT_ID)');
ALTER TABLE `vibe_construction_v1`.`bid`.`bond` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`bid`.`bond` ALTER COLUMN `tender_id` SET TAGS ('dbx_business_glossary_term' = 'Tender Identifier (TENDER_ID)');
ALTER TABLE `vibe_construction_v1`.`bid`.`bond` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Bid Bond Amount (BBA)');
ALTER TABLE `vibe_construction_v1`.`bid`.`bond` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By (APPROVED_BY)');
ALTER TABLE `vibe_construction_v1`.`bid`.`bond` ALTER COLUMN `approved_by` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_construction_v1`.`bid`.`bond` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp (APPROVED_TS)');
ALTER TABLE `vibe_construction_v1`.`bid`.`bond` ALTER COLUMN `beneficiary` SET TAGS ('dbx_business_glossary_term' = 'Beneficiary (Client)');
ALTER TABLE `vibe_construction_v1`.`bid`.`bond` ALTER COLUMN `bond_number` SET TAGS ('dbx_business_glossary_term' = 'Bid Bond Number (BBN)');
ALTER TABLE `vibe_construction_v1`.`bid`.`bond` ALTER COLUMN `bond_status` SET TAGS ('dbx_business_glossary_term' = 'Bid Bond Status (BB_STATUS)');
ALTER TABLE `vibe_construction_v1`.`bid`.`bond` ALTER COLUMN `bond_status` SET TAGS ('dbx_value_regex' = 'issued|submitted|returned|forfeited|extended');
ALTER TABLE `vibe_construction_v1`.`bid`.`bond` ALTER COLUMN `bond_type` SET TAGS ('dbx_business_glossary_term' = 'Bid Bond Type (BB_TYPE)');
ALTER TABLE `vibe_construction_v1`.`bid`.`bond` ALTER COLUMN `bond_type` SET TAGS ('dbx_value_regex' = 'bank_guarantee|surety_bond|insurance_bond');
ALTER TABLE `vibe_construction_v1`.`bid`.`bond` ALTER COLUMN `compliance_requirements_met` SET TAGS ('dbx_business_glossary_term' = 'Compliance Requirements Met Flag (COMPLIANCE_MET)');
ALTER TABLE `vibe_construction_v1`.`bid`.`bond` ALTER COLUMN `confidentiality_flag` SET TAGS ('dbx_business_glossary_term' = 'Confidentiality Flag (CONFIDENTIAL_FLAG)');
ALTER TABLE `vibe_construction_v1`.`bid`.`bond` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (CREATED_TS)');
ALTER TABLE `vibe_construction_v1`.`bid`.`bond` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `vibe_construction_v1`.`bid`.`bond` ALTER COLUMN `documents_attached` SET TAGS ('dbx_business_glossary_term' = 'Documents Attached Flag (DOCS_ATTACHED)');
ALTER TABLE `vibe_construction_v1`.`bid`.`bond` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Bond Expiry Date (EXPIRY_DATE)');
ALTER TABLE `vibe_construction_v1`.`bid`.`bond` ALTER COLUMN `expiry_date` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_construction_v1`.`bid`.`bond` ALTER COLUMN `expiry_place` SET TAGS ('dbx_business_glossary_term' = 'Bond Expiry Location (EXPIRY_PLACE)');
ALTER TABLE `vibe_construction_v1`.`bid`.`bond` ALTER COLUMN `expiry_place` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_construction_v1`.`bid`.`bond` ALTER COLUMN `extension_count` SET TAGS ('dbx_business_glossary_term' = 'Number of Extensions (EXT_COUNT)');
ALTER TABLE `vibe_construction_v1`.`bid`.`bond` ALTER COLUMN `guarantee_extension_allowed` SET TAGS ('dbx_business_glossary_term' = 'Extension Allowed Flag (EXTENSION_ALLOWED)');
ALTER TABLE `vibe_construction_v1`.`bid`.`bond` ALTER COLUMN `guarantee_extension_reason` SET TAGS ('dbx_business_glossary_term' = 'Extension Reason (EXTENSION_REASON)');
ALTER TABLE `vibe_construction_v1`.`bid`.`bond` ALTER COLUMN `issue_date` SET TAGS ('dbx_business_glossary_term' = 'Bond Issue Date (ISSUE_DATE)');
ALTER TABLE `vibe_construction_v1`.`bid`.`bond` ALTER COLUMN `issue_place` SET TAGS ('dbx_business_glossary_term' = 'Bond Issue Location (ISSUE_PLACE)');
ALTER TABLE `vibe_construction_v1`.`bid`.`bond` ALTER COLUMN `issuer_type` SET TAGS ('dbx_business_glossary_term' = 'Issuer Type (ISSUER_TYPE)');
ALTER TABLE `vibe_construction_v1`.`bid`.`bond` ALTER COLUMN `issuer_type` SET TAGS ('dbx_value_regex' = 'bank|surety|insurance');
ALTER TABLE `vibe_construction_v1`.`bid`.`bond` ALTER COLUMN `issuing_entity` SET TAGS ('dbx_business_glossary_term' = 'Issuing Bank or Surety (Issuer)');
ALTER TABLE `vibe_construction_v1`.`bid`.`bond` ALTER COLUMN `last_extension_date` SET TAGS ('dbx_business_glossary_term' = 'Last Extension Date (LAST_EXT_DATE)');
ALTER TABLE `vibe_construction_v1`.`bid`.`bond` ALTER COLUMN `last_updated_by` SET TAGS ('dbx_business_glossary_term' = 'Last Updated By (LAST_UPDATED_BY)');
ALTER TABLE `vibe_construction_v1`.`bid`.`bond` ALTER COLUMN `last_updated_by` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_construction_v1`.`bid`.`bond` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Additional Notes (NOTES)');
ALTER TABLE `vibe_construction_v1`.`bid`.`bond` ALTER COLUMN `percentage` SET TAGS ('dbx_business_glossary_term' = 'Bid Bond Percentage of Tender Value (BBP)');
ALTER TABLE `vibe_construction_v1`.`bid`.`bond` ALTER COLUMN `risk_rating` SET TAGS ('dbx_business_glossary_term' = 'Risk Rating (RISK_RATING)');
ALTER TABLE `vibe_construction_v1`.`bid`.`bond` ALTER COLUMN `risk_rating` SET TAGS ('dbx_value_regex' = 'low|medium|high');
ALTER TABLE `vibe_construction_v1`.`bid`.`bond` ALTER COLUMN `status_date` SET TAGS ('dbx_business_glossary_term' = 'Status Effective Date (STATUS_DATE)');
ALTER TABLE `vibe_construction_v1`.`bid`.`bond` ALTER COLUMN `total_extension_days` SET TAGS ('dbx_business_glossary_term' = 'Total Extension Days (TOTAL_EXT_DAYS)');
ALTER TABLE `vibe_construction_v1`.`bid`.`bond` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp (UPDATED_TS)');
ALTER TABLE `vibe_construction_v1`.`bid`.`win_loss_record` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_construction_v1`.`bid`.`win_loss_record` SET TAGS ('dbx_subdomain' = 'opportunity_tracking');
ALTER TABLE `vibe_construction_v1`.`bid`.`win_loss_record` ALTER COLUMN `win_loss_record_id` SET TAGS ('dbx_business_glossary_term' = 'Win/Loss Record ID');
ALTER TABLE `vibe_construction_v1`.`bid`.`win_loss_record` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Jv Partner Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`bid`.`win_loss_record` ALTER COLUMN `asset_id` SET TAGS ('dbx_business_glossary_term' = 'Carbon Target Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`bid`.`win_loss_record` ALTER COLUMN `client_opportunity_id` SET TAGS ('dbx_business_glossary_term' = 'Client Opportunity Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`bid`.`win_loss_record` ALTER COLUMN `construction_project_id` SET TAGS ('dbx_business_glossary_term' = 'Project ID');
ALTER TABLE `vibe_construction_v1`.`bid`.`win_loss_record` ALTER COLUMN `contact_id` SET TAGS ('dbx_business_glossary_term' = 'Decision Contact Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`bid`.`win_loss_record` ALTER COLUMN `submission_id` SET TAGS ('dbx_business_glossary_term' = 'Bid ID');
ALTER TABLE `vibe_construction_v1`.`bid`.`win_loss_record` ALTER COLUMN `tender_id` SET TAGS ('dbx_business_glossary_term' = 'Tender ID');
ALTER TABLE `vibe_construction_v1`.`bid`.`win_loss_record` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Winning Bidder ID');
ALTER TABLE `vibe_construction_v1`.`bid`.`win_loss_record` ALTER COLUMN `awarded_contract_value` SET TAGS ('dbx_business_glossary_term' = 'Awarded Contract Value');
ALTER TABLE `vibe_construction_v1`.`bid`.`win_loss_record` ALTER COLUMN `bid_bond_amount` SET TAGS ('dbx_business_glossary_term' = 'Bid Bond Amount');
ALTER TABLE `vibe_construction_v1`.`bid`.`win_loss_record` ALTER COLUMN `bid_bond_type` SET TAGS ('dbx_business_glossary_term' = 'Bid Bond Type');
ALTER TABLE `vibe_construction_v1`.`bid`.`win_loss_record` ALTER COLUMN `bid_bond_type` SET TAGS ('dbx_value_regex' = 'cash|bank_guarantee|insurance|other');
ALTER TABLE `vibe_construction_v1`.`bid`.`win_loss_record` ALTER COLUMN `bid_type` SET TAGS ('dbx_business_glossary_term' = 'Bid Type');
ALTER TABLE `vibe_construction_v1`.`bid`.`win_loss_record` ALTER COLUMN `bid_type` SET TAGS ('dbx_value_regex' = 'gmp|lump_sum|cost_plus|unit_price|other');
ALTER TABLE `vibe_construction_v1`.`bid`.`win_loss_record` ALTER COLUMN `competitor_count` SET TAGS ('dbx_business_glossary_term' = 'Number of Competitors');
ALTER TABLE `vibe_construction_v1`.`bid`.`win_loss_record` ALTER COLUMN `contract_end_date` SET TAGS ('dbx_business_glossary_term' = 'Contract End Date');
ALTER TABLE `vibe_construction_v1`.`bid`.`win_loss_record` ALTER COLUMN `contract_start_date` SET TAGS ('dbx_business_glossary_term' = 'Contract Start Date');
ALTER TABLE `vibe_construction_v1`.`bid`.`win_loss_record` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_construction_v1`.`bid`.`win_loss_record` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `vibe_construction_v1`.`bid`.`win_loss_record` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_construction_v1`.`bid`.`win_loss_record` ALTER COLUMN `decision_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Decision Timestamp');
ALTER TABLE `vibe_construction_v1`.`bid`.`win_loss_record` ALTER COLUMN `evaluation_method` SET TAGS ('dbx_business_glossary_term' = 'Evaluation Method');
ALTER TABLE `vibe_construction_v1`.`bid`.`win_loss_record` ALTER COLUMN `evaluation_method` SET TAGS ('dbx_value_regex' = 'technical|combined|price_only|other');
ALTER TABLE `vibe_construction_v1`.`bid`.`win_loss_record` ALTER COLUMN `evaluation_score_commercial` SET TAGS ('dbx_business_glossary_term' = 'Commercial Evaluation Score');
ALTER TABLE `vibe_construction_v1`.`bid`.`win_loss_record` ALTER COLUMN `evaluation_score_hsse` SET TAGS ('dbx_business_glossary_term' = 'HSSE Evaluation Score');
ALTER TABLE `vibe_construction_v1`.`bid`.`win_loss_record` ALTER COLUMN `evaluation_score_technical` SET TAGS ('dbx_business_glossary_term' = 'Technical Evaluation Score');
ALTER TABLE `vibe_construction_v1`.`bid`.`win_loss_record` ALTER COLUMN `is_award_confirmed` SET TAGS ('dbx_business_glossary_term' = 'Award Confirmation Flag');
ALTER TABLE `vibe_construction_v1`.`bid`.`win_loss_record` ALTER COLUMN `is_joint_venture` SET TAGS ('dbx_business_glossary_term' = 'Joint Venture Indicator');
ALTER TABLE `vibe_construction_v1`.`bid`.`win_loss_record` ALTER COLUMN `lessons_learned_reference` SET TAGS ('dbx_business_glossary_term' = 'Lessons Learned Reference');
ALTER TABLE `vibe_construction_v1`.`bid`.`win_loss_record` ALTER COLUMN `loss_reason_category` SET TAGS ('dbx_business_glossary_term' = 'Loss Reason Category');
ALTER TABLE `vibe_construction_v1`.`bid`.`win_loss_record` ALTER COLUMN `loss_reason_narrative` SET TAGS ('dbx_business_glossary_term' = 'Loss Reason Narrative');
ALTER TABLE `vibe_construction_v1`.`bid`.`win_loss_record` ALTER COLUMN `outcome_status` SET TAGS ('dbx_business_glossary_term' = 'Outcome Status');
ALTER TABLE `vibe_construction_v1`.`bid`.`win_loss_record` ALTER COLUMN `outcome_status` SET TAGS ('dbx_value_regex' = 'won|lost|withdrawn|cancelled');
ALTER TABLE `vibe_construction_v1`.`bid`.`win_loss_record` ALTER COLUMN `price_gap_to_winner` SET TAGS ('dbx_business_glossary_term' = 'Price Gap to Winning Bid');
ALTER TABLE `vibe_construction_v1`.`bid`.`win_loss_record` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_construction_v1`.`bid`.`win_loss_record` ALTER COLUMN `win_loss_number` SET TAGS ('dbx_business_glossary_term' = 'Win/Loss Record Number');
ALTER TABLE `vibe_construction_v1`.`bid`.`win_loss_record` ALTER COLUMN `winning_bid_price` SET TAGS ('dbx_business_glossary_term' = 'Winning Bid Price');
