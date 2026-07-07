-- Schema for Domain: bid | Business:  | Version: v2_ecm
-- Generated on: 2026-06-27 00:09:55

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_construction_v1`.`bid` COMMENT 'Pre-award commercial pipeline domain owning RFP/RFQ responses, tender submissions, BOQ pricing, project estimation data, win/loss records, bid bond management, and GMP/lump-sum bid preparation. Integrates with Salesforce CRM for opportunity tracking and pipeline forecasting. Tracks bid-to-award conversion rates across market segments.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_construction_v1`.`bid`.`firm_profile` (
    `firm_profile_id` BIGINT COMMENT 'Primary key for firm_profile',
    `account_id` BIGINT COMMENT 'add column account_id (BIGINT) with FK to client.account.account_id - firm profiles represent organizations that should anchor to the account master',
    `subcontractor_prequalification_id` BIGINT COMMENT 'add column subcontractor_prequalification_id (BIGINT) with FK to bid.subcontractor_prequalification.subcontractor_prequalification_id - firm profiles relate to their qualification record',
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
    `vendor_id` BIGINT COMMENT 'add column vendor_id (BIGINT) with FK to procurement.vendor.vendor_id - firm profiles overlap with vendor master and should cross-reference',
    `wbe_certified` BOOLEAN COMMENT 'Indicates whether the firm holds a valid Women-Owned Business Enterprise (WBE) certification. Used for diversity spend tracking and compliance reporting on projects with WBE participation goals.',
    `years_in_business` STRING COMMENT 'Number of years the subcontracting firm has been in continuous operation since its founding or incorporation date. Used as a stability and experience indicator in prequalification scoring.',
    CONSTRAINT pk_firm_profile PRIMARY KEY(`firm_profile_id`)
) COMMENT 'Master profile of each subcontracting firm engaged or seeking engagement on construction projects. Captures legal entity name, ABN/EIN/company registration number, trade classifications (MEP, civil, structural, specialty), business registration details, bonding capacity, union affiliations, geographic coverage areas, minority/women-owned business enterprise (MBE/WBE/DBE) certifications, NAICS/SIC codes, annual revenue band, EMR (Experience Modification Rate), and financial standing indicators. This is the SSOT for subcontractor firm identity, distinct from the procurement domains vendor master which governs purchase order relationships.';

CREATE OR REPLACE TABLE `vibe_construction_v1`.`bid`.`subcontractor_prequalification` (
    `subcontractor_prequalification_id` BIGINT COMMENT 'Unique identifier for the subcontractor prequalification record.',
    `construction_project_id` BIGINT COMMENT 'Foreign key linking to project.construction_project. Business justification: Needed for Project‑Specific Subcontractor Prequalification process, enabling tracking of which subcontractors are qualified for each construction project.',
    `hr_employee_id` BIGINT COMMENT 'Reference to the procurement or project management officer who conducted the prequalification evaluation and made the approval recommendation.',
    `approval_date` DATE COMMENT 'Date when the prequalification was formally approved by the approving authority. Null for rejected or pending applications.',
    `bonding_limit_amount` DECIMAL(18,2) COMMENT 'Maximum bonding capacity available to the subcontractor, indicating the largest contract value they can bond. Critical for determining eligibility for high-value trade packages.',
    `bonding_limit_currency` STRING COMMENT 'Three-letter ISO 4217 currency code for the bonding limit amount.. Valid values are `^[A-Z]{3}$`',
    `certification_requirements_met` BOOLEAN COMMENT 'Indicates whether the subcontractor has provided all required industry certifications (ISO 9001, ISO 14001, ISO 45001, trade-specific licenses) as part of the prequalification.',
    `conditional_approval_requirements` STRING COMMENT 'List of conditions or remedial actions the subcontractor must fulfill to convert conditional approval to full approval (e.g., submit updated insurance certificates, provide additional references).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this prequalification record was first created in the system.',
    `effective_date` DATE COMMENT 'Date from which the prequalification approval becomes valid and the subcontractor is eligible to bid on trade packages.',
    `eligible_project_types` STRING COMMENT 'Comma-separated list of project types or sectors for which this prequalification is valid (e.g., commercial, infrastructure, energy, residential). Used to filter RFQ distribution.',
    `evaluation_date` DATE COMMENT 'Date when the prequalification evaluation was completed by the evaluating officer.',
    `evaluation_notes` STRING COMMENT 'Free-text notes and observations recorded by the evaluating officer during the assessment, including strengths, weaknesses, and areas of concern.',
    `expiry_date` DATE COMMENT 'Date when the prequalification approval expires and requalification is required. Nullable for rejected or conditional statuses.',
    `financial_capacity_score` DECIMAL(18,2) COMMENT 'Evaluation score assessing the subcontractors financial strength, liquidity, and ability to fund project work. Typically scored on a 0-100 scale.',
    `financial_statements_verified` BOOLEAN COMMENT 'Indicates whether the subcontractors financial statements (balance sheet, P&L, cash flow) have been reviewed and verified by the evaluating officer or finance team.',
    `firm_profile_id` BIGINT COMMENT 'Reference to the subcontractor firm being prequalified.',
    `geographic_scope` STRING COMMENT 'Geographic regions or countries where the subcontractor is prequalified to operate, based on licensing, local presence, and regulatory compliance.',
    `insurance_adequacy_score` DECIMAL(18,2) COMMENT 'Evaluation score assessing whether the subcontractors insurance coverage (general liability, workers compensation, professional indemnity) meets project requirements. Typically scored on a 0-100 scale.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this prequalification record was last modified, supporting audit trail and change tracking.',
    `maximum_contract_currency` STRING COMMENT 'Three-letter ISO 4217 currency code for the maximum contract value.. Valid values are `^[A-Z]{3}$`',
    `maximum_contract_value` DECIMAL(18,2) COMMENT 'Maximum trade package contract value the subcontractor is prequalified to bid on, based on financial capacity and bonding limits.',
    `minimum_passing_score` DECIMAL(18,2) COMMENT 'Threshold score required for prequalification approval. Subcontractors scoring below this threshold are rejected or granted conditional approval.',
    `overall_score` DECIMAL(18,2) COMMENT 'Composite weighted score aggregating all evaluation criteria (financial, safety, performance, technical, bonding, insurance). Used to determine approval decision. Typically scored on a 0-100 scale.',
    `past_performance_score` DECIMAL(18,2) COMMENT 'Evaluation score reflecting the subcontractors track record on previous projects, including quality of work, schedule adherence, and client satisfaction. Typically scored on a 0-100 scale.',
    `prequalification_number` STRING COMMENT 'Externally-known unique identifier for this prequalification assessment, used in correspondence and RFQ invitations.',
    `prequalification_status` STRING COMMENT 'Current lifecycle status of the prequalification record, determining whether the subcontractor is eligible to receive RFQs and bid invitations.. Valid values are `approved|conditional|rejected|expired|under_review|pending_documents`',
    `reference_check_completed` BOOLEAN COMMENT 'Indicates whether reference checks with previous clients or general contractors have been completed and verified as part of the evaluation process.',
    `rejection_reason` STRING COMMENT 'Detailed explanation of why the prequalification was rejected, including specific criteria failures or compliance gaps. Null for approved applications.',
    `requalification_trigger` STRING COMMENT 'Business event or condition that requires the subcontractor to undergo requalification before expiry date (e.g., major safety incident, financial distress, change in ownership, significant performance failure).',
    `safety_record_score` DECIMAL(18,2) COMMENT 'Evaluation score based on the subcontractors historical safety performance, including TRIR (Total Recordable Incident Rate), LTI (Lost Time Injury) frequency, and HSE compliance. Typically scored on a 0-100 scale.',
    `submission_date` DATE COMMENT 'Date when the subcontractor submitted their prequalification application package.',
    `technical_capability_score` DECIMAL(18,2) COMMENT 'Evaluation score assessing the subcontractors technical expertise, workforce qualifications, equipment availability, and ability to execute complex trade packages. Typically scored on a 0-100 scale.',
    `trade_category` STRING COMMENT 'Primary trade or specialty category for which the subcontractor is being prequalified (e.g., MEP, civil works, structural steel, concrete, electrical, plumbing, HVAC).',
    CONSTRAINT pk_subcontractor_prequalification PRIMARY KEY(`subcontractor_prequalification_id`)
) COMMENT 'Prequalification assessment records for subcontractor firms seeking approval to bid on trade packages. Tracks submission date, evaluation criteria scores (financial capacity, safety record, past performance, bonding limits, insurance adequacy), prequalification status (approved, conditional, rejected, expired), expiry date, evaluating officer, and requalification triggers. Governs which firms are eligible to receive RFQs and bid invitations.';

CREATE OR REPLACE TABLE `vibe_construction_v1`.`bid`.`trade_package` (
    `trade_package_id` BIGINT COMMENT 'Unique identifier for the trade package. Primary key.',
    `construction_project_id` BIGINT COMMENT 'Reference to the parent construction project to which this trade package belongs.',
    `hr_employee_id` BIGINT COMMENT 'Reference to the project team member responsible for managing this trade package.',
    `firm_profile_id` BIGINT COMMENT 'Reference to the subcontractor to whom this trade package was awarded.',
    `green_certification_id` BIGINT COMMENT 'Foreign key linking to sustainability.green_certification. Business justification: Trade packages often mandate a specific green building certification; linking allows verification that the subcontractor’s work meets the required certification.',
    `project_budget_id` BIGINT COMMENT 'Foreign key linking to finance.project_budget. Business justification: Associates each trade package with its budget line, supporting budget control and earned value analysis.',
    `wbs_element_id` BIGINT COMMENT 'Reference to the WBS element that this trade package is associated with for cost and schedule control.',
    `actual_completion_date` DATE COMMENT 'Actual date when the subcontractor completed all work under this trade package.',
    `actual_start_date` DATE COMMENT 'Actual date when the subcontractor commenced work on this trade package.',
    `award_date` DATE COMMENT 'Date when the trade package was formally awarded to the selected subcontractor.',
    `awarded_value` DECIMAL(18,2) COMMENT 'Final contract value at which the trade package was awarded to the subcontractor.',
    `bid_closing_date` DATE COMMENT 'Deadline date by which subcontractors must submit their bids for this trade package.',
    `bid_out_date` DATE COMMENT 'Date when the trade package was issued to subcontractors for competitive bidding.',
    `bonding_required` BOOLEAN COMMENT 'Indicates whether performance and payment bonds are required from the subcontractor for this trade package.',
    `budget_allowance` DECIMAL(18,2) COMMENT 'Budget allocation reserved for this trade package in the project cost plan.',
    `contract_type` STRING COMMENT 'Type of contract pricing mechanism for this trade package (Lump Sum, Unit Price, Cost Plus, Guaranteed Maximum Price, Time and Materials).. Valid values are `lump_sum|unit_price|cost_plus|gmp|time_and_materials`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this trade package record was first created in the system.',
    `csi_masterformat_code` STRING COMMENT 'CSI MasterFormat classification code for the scope of work (e.g., 03 30 00 for Cast-in-Place Concrete).. Valid values are `^[0-9]{2}s[0-9]{2}s[0-9]{2}(.[0-9]{2})?$`',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary values in this trade package (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `duration_days` STRING COMMENT 'Planned duration in calendar days for the execution of this trade package.',
    `estimated_value` DECIMAL(18,2) COMMENT 'Pre-bid estimated value of the trade package based on quantity take-offs and market rates.',
    `insurance_requirements` STRING COMMENT 'Summary of insurance coverage requirements that the awarded subcontractor must maintain (e.g., general liability, professional indemnity, workers compensation).',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this trade package record was last updated.',
    `liquidated_damages_rate` DECIMAL(18,2) COMMENT 'Daily rate of liquidated damages applicable if the subcontractor fails to complete the trade package by the planned completion date.',
    `notes` STRING COMMENT 'Additional notes, comments, or special instructions related to this trade package.',
    `number_of_bidders_invited` STRING COMMENT 'Count of subcontractors invited to submit bids for this trade package.',
    `number_of_bids_received` STRING COMMENT 'Count of valid bids received from subcontractors by the bid closing date.',
    `package_name` STRING COMMENT 'Descriptive name of the trade package (e.g., Structural Steel Erection, HVAC Installation, Electrical Fit-Out).',
    `package_priority` STRING COMMENT 'Priority level of this trade package relative to other packages in the project (Critical, High, Medium, Low).. Valid values are `critical|high|medium|low`',
    `package_reference_number` STRING COMMENT 'Externally-known unique reference number for the trade package used in bidding and contract documents.. Valid values are `^[A-Z0-9-]{6,20}$`',
    `package_status` STRING COMMENT 'Current lifecycle status of the trade package in the bidding and award process.. Valid values are `draft|bid_out|evaluation|awarded|closed|cancelled`',
    `payment_terms_days` STRING COMMENT 'Number of days within which payment is due to the subcontractor after invoice approval.',
    `planned_completion_date` DATE COMMENT 'Scheduled date for the subcontractor to complete all work under this trade package.',
    `planned_start_date` DATE COMMENT 'Scheduled date for the subcontractor to commence work on this trade package.',
    `prequalification_required` BOOLEAN COMMENT 'Indicates whether subcontractors must be prequalified before being invited to bid on this trade package.',
    `procurement_method` STRING COMMENT 'Method used to procure this trade package (Open Tender, Selective Tender, Negotiated, Single Source, Framework Agreement).. Valid values are `open_tender|selective_tender|negotiated|single_source|framework`',
    `retention_percentage` DECIMAL(18,2) COMMENT 'Percentage of each payment withheld as retention until satisfactory completion of the trade package.',
    `risk_level` STRING COMMENT 'Overall risk assessment level for this trade package based on complexity, value, and schedule criticality.. Valid values are `high|medium|low`',
    `scope_narrative` STRING COMMENT 'Detailed textual description of the scope of work included in this trade package, including deliverables, exclusions, and boundaries.',
    `trade_discipline_code` STRING COMMENT 'Code representing the trade discipline (e.g., MEP, CIVIL, STRUCT, ARCH, ELEC, HVAC, PLUMB).. Valid values are `^[A-Z]{2,6}$`',
    `uniformat_code` STRING COMMENT 'UniFormat II classification code for elemental cost planning (e.g., B2010 for Exterior Walls).. Valid values are `^[A-Z][0-9]{2}[0-9]{2}$`',
    `warranty_period_months` STRING COMMENT 'Duration in months of the defects liability period (DLP) or warranty period after completion.',
    CONSTRAINT pk_trade_package PRIMARY KEY(`trade_package_id`)
) COMMENT 'Defines a discrete scope-of-work package to be competitively bid and awarded to a subcontractor — e.g., structural steel erection, HVAC installation, electrical fit-out, piling works, or facade cladding. Captures trade discipline code, CSI MasterFormat/UniFormat classification, package reference number, associated WBS elements, scope narrative, estimated value, budget allowance, bid-out date, bid closing date, number of bidders invited, award date, and package status (draft, bid-out, evaluation, awarded, closed). The SSOT for trade package definitions that drive the subcontractor bidding and award process.';

CREATE OR REPLACE TABLE `vibe_construction_v1`.`bid`.`bid_contract_agreement` (
    `bid_contract_agreement_id` BIGINT COMMENT 'Primary key for contract_agreement',
    `construction_project_id` BIGINT COMMENT 'Reference to the parent construction project under which this subcontract is executed.',
    `hr_employee_id` BIGINT COMMENT 'Foreign key linking to hr.employee. Business justification: Contract Management process assigns an internal employee as contract manager; linking enables manager accountability and reporting.',
    `firm_profile_id` BIGINT COMMENT 'Reference to the subcontractor party executing the work under this agreement.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Maps each subcontractor contract to a GL account for expense recognition and financial reporting of contract costs.',
    `sustainability_plan_id` BIGINT COMMENT 'Foreign key linking to sustainability.sustainability_plan. Business justification: Contracts include sustainability obligations; linking to the sustainability plan records the plan the subcontractor must follow for the project.',
    `actual_completion_date` DATE COMMENT 'Actual date on which the subcontractor achieved substantial completion and received acceptance from the general contractor.',
    `advance_payment_percentage` DECIMAL(18,2) COMMENT 'Percentage of the contract value paid as an advance payment to the subcontractor upon contract signing or NTP, subject to advance payment guarantee.',
    `contract_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code in which the subcontract value and payments are denominated (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `contract_expiry_date` DATE COMMENT 'Date on which the subcontract agreement expires or is scheduled for final closeout, including all warranty and retention obligations.',
    `contract_name` STRING COMMENT 'Descriptive name or title of the subcontract agreement, typically referencing the trade package or scope.',
    `contract_number` STRING COMMENT 'Externally-known unique business identifier for the subcontract agreement, used in correspondence and documentation.',
    `contract_signed_date` DATE COMMENT 'Date on which the subcontract agreement was formally executed and signed by both the general contractor and the subcontractor.',
    `contract_status` STRING COMMENT 'Current lifecycle status of the subcontract agreement: draft (under negotiation), pending_approval (awaiting internal sign-off), awarded (signed but not started), active (work in progress), suspended (temporarily halted), completed (work finished), terminated (cancelled), closed (final settlement complete). [ENUM-REF-CANDIDATE: draft|pending_approval|awarded|active|suspended|completed|terminated|closed — 8 candidates stripped; promote to reference product]',
    `contract_type` STRING COMMENT 'Type of subcontract pricing structure: lump-sum (fixed price), unit-rate (measured work), cost-plus (reimbursable), GMP (Guaranteed Maximum Price), time-and-materials, or design-build.. Valid values are `lump_sum|unit_rate|cost_plus|gmp|time_and_materials|design_build`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this subcontract agreement record was first created in the system.',
    `current_contract_value` DECIMAL(18,2) COMMENT 'Current total contract value including all approved change orders, variations, and adjustments to date.',
    `dispute_resolution_method` STRING COMMENT 'Primary method for resolving disputes under this subcontract: negotiation, mediation, arbitration, litigation, or DAB (Dispute Adjudication Board) as per FIDIC.. Valid values are `negotiation|mediation|arbitration|litigation|dab`',
    `dlp_duration_days` STRING COMMENT 'Duration in days of the Defects Liability Period (also known as warranty period) during which the subcontractor is responsible for rectifying defects, typically 12-24 months.',
    `dlp_end_date` DATE COMMENT 'Calculated or actual end date of the Defects Liability Period, after which final retention is released and warranty obligations conclude.',
    `executed_contract_value` DECIMAL(18,2) COMMENT 'Original signed contract value in the contract currency, representing the baseline commitment before any change orders or variations.',
    `fidic_conditions_reference` STRING COMMENT 'Reference to the FIDIC contract conditions edition and color book (e.g., Red Book 1999, Yellow Book 2017) governing the contractual framework and dispute resolution.',
    `governing_law_jurisdiction` STRING COMMENT 'Legal jurisdiction and governing law under which the subcontract is interpreted and enforced (e.g., State of New York, England and Wales, UAE Civil Code).',
    `insurance_required_flag` BOOLEAN COMMENT 'Boolean indicator whether the subcontractor is contractually required to maintain specific insurance coverage (e.g., general liability, professional indemnity, workers compensation).',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this subcontract agreement record was last updated or modified.',
    `ld_cap_percentage` DECIMAL(18,2) COMMENT 'Maximum total liquidated damages expressed as a percentage of the contract value (typically 10-20%), beyond which no further LDs are applied.',
    `ld_rate_per_day` DECIMAL(18,2) COMMENT 'Daily liquidated damages amount deductible from the subcontractor for each day of delay beyond the planned completion date, as stipulated in the contract.',
    `ntp_date` DATE COMMENT 'Date on which the general contractor issued the Notice to Proceed, authorizing the subcontractor to commence work on site.',
    `payment_application_frequency` STRING COMMENT 'Frequency at which the subcontractor submits payment applications for work completed: monthly (calendar month), bi-weekly (every two weeks), milestone-based (upon achieving defined milestones), or completion-based (upon final completion).. Valid values are `monthly|bi_weekly|milestone_based|completion_based`',
    `payment_terms_days` STRING COMMENT 'Number of days from invoice submission or payment application approval to payment due date (e.g., Net 30, Net 45).',
    `performance_bond_percentage` DECIMAL(18,2) COMMENT 'Percentage of the contract value that the performance bond must cover (typically 5-10%).',
    `performance_bond_required_flag` BOOLEAN COMMENT 'Boolean indicator whether the subcontractor is required to provide a performance bond or bank guarantee to secure contract performance.',
    `planned_completion_date` DATE COMMENT 'Contractually agreed date by which the subcontractor must achieve substantial completion of the scope of work.',
    `planned_start_date` DATE COMMENT 'Contractually agreed date for the subcontractor to begin work on site, typically aligned with or following the NTP date.',
    `remarks` STRING COMMENT 'Free-text field for additional notes, special conditions, or clarifications related to the subcontract agreement.',
    `retention_percentage` DECIMAL(18,2) COMMENT 'Percentage of each payment withheld by the general contractor as retention (typically 5-10%) to ensure performance and defect rectification, released after DLP completion.',
    `scope_of_work_description` STRING COMMENT 'Detailed textual description of the work scope, deliverables, and responsibilities assigned to the subcontractor under this agreement.',
    `subcontractor_representative_name` STRING COMMENT 'Name of the subcontractor representative or project manager designated as the primary point of contact for this agreement.',
    `termination_date` DATE COMMENT 'Actual date on which the subcontract was terminated by either party, applicable only if contract_status is terminated.',
    `termination_reason` STRING COMMENT 'Textual explanation of the reason for contract termination (e.g., default by subcontractor, convenience termination by contractor, force majeure).',
    `trade_package_code` STRING COMMENT 'Code identifying the trade package or scope-of-work category (e.g., MEP, civil works, structural steel, concrete, finishes).',
    CONSTRAINT pk_bid_contract_agreement PRIMARY KEY(`bid_contract_agreement_id`)
) COMMENT 'Subcontract agreement record governing the legal and commercial relationship between the general contractor and a subcontractor for a specific trade package. Captures contract number, contract type (lump-sum, unit-rate, cost-plus, GMP), executed contract value, retention percentage, payment terms, NTP date, planned completion date, DLP duration, LD (liquidated damages) rate, FIDIC conditions reference, and contract status. Distinct from the contract domain which owns head contracts with clients.';

CREATE OR REPLACE TABLE `vibe_construction_v1`.`bid`.`bid_payment_application` (
    `bid_payment_application_id` BIGINT COMMENT 'Unique identifier for the payment application record. Primary key for the payment application entity.',
    `construction_project_id` BIGINT COMMENT 'Reference to the construction project for which this payment application is submitted.',
    `bid_contract_agreement_id` BIGINT COMMENT 'Reference to the subcontract agreement governing this payment application.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Needed to allocate each subcontractor payment to the appropriate cost center for cost reporting and internal chargeback.',
    `hr_employee_id` BIGINT COMMENT 'Reference to the engineer, architect, or project manager who certified this payment application.',
    `firm_profile_id` BIGINT COMMENT 'Reference to the subcontractor submitting this payment application.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Required for posting subcontractor payment applications to the general ledger; the finance team needs the GL account to record the expense per contract.',
    `project_budget_id` BIGINT COMMENT 'Foreign key linking to finance.project_budget. Business justification: Links payment applications to the specific project budget line they consume, enabling budget variance tracking.',
    `amount_certified_current` DECIMAL(18,2) COMMENT 'Amount certified and approved by the certifying engineer or project manager for payment in this application, which may differ from the amount claimed if adjustments are made.',
    `amount_claimed_current` DECIMAL(18,2) COMMENT 'Gross amount claimed by the subcontractor for work performed during this billing period before retention and back-charges.',
    `amount_previously_certified` DECIMAL(18,2) COMMENT 'Cumulative amount certified and approved in all previous payment applications prior to this one.',
    `application_number` STRING COMMENT 'Sequential business identifier for the payment application (e.g., Pay App #5). Externally-known reference number used in correspondence and approvals.',
    `application_status` STRING COMMENT 'Current lifecycle status of the payment application in the approval and payment workflow. [ENUM-REF-CANDIDATE: submitted|under_review|certified|approved|paid|disputed|rejected|withdrawn — 8 candidates stripped; promote to reference product]',
    `back_charges_applied` DECIMAL(18,2) COMMENT 'Total back-charges deducted from this payment application for costs incurred by the general contractor to correct deficiencies, delays, or damages caused by the subcontractor.',
    `billing_period_end_date` DATE COMMENT 'End date of the billing period covered by this payment application.',
    `billing_period_start_date` DATE COMMENT 'Start date of the billing period covered by this payment application.',
    `certification_date` DATE COMMENT 'Date when the payment application was certified and approved by the certifying engineer, architect, or project manager.',
    `contract_value_original` DECIMAL(18,2) COMMENT 'Original total value of the subcontract agreement before any change orders or modifications.',
    `contract_value_revised` DECIMAL(18,2) COMMENT 'Current total value of the subcontract including all approved change orders (CO) and modifications to date.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this payment application record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts in this payment application (e.g., USD, GBP, EUR, AUD).. Valid values are `^[A-Z]{3}$`',
    `dispute_flag` BOOLEAN COMMENT 'Indicates whether this payment application is currently under dispute between the subcontractor and general contractor or owner.',
    `dispute_reason` STRING COMMENT 'Description of the reason for dispute if the payment application is contested (e.g., quality issues, scope disagreement, quantity discrepancy).',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this payment application record was last updated or modified.',
    `lien_waiver_received` BOOLEAN COMMENT 'Indicates whether a conditional or unconditional lien waiver has been received from the subcontractor for this payment application.',
    `liquidated_damages_deducted` DECIMAL(18,2) COMMENT 'Liquidated damages amount deducted from this payment for failure to meet contractual milestones or completion dates.',
    `materials_stored_to_date` DECIMAL(18,2) COMMENT 'Cumulative value of materials delivered to site and properly stored but not yet incorporated into the work, eligible for payment per contract terms.',
    `net_amount_due` DECIMAL(18,2) COMMENT 'Final net amount payable to the subcontractor after all retention, back-charges, liquidated damages, and other deductions are applied.',
    `notes` STRING COMMENT 'Free-text notes or comments regarding this payment application, including clarifications, special conditions, or reviewer observations.',
    `other_deductions` DECIMAL(18,2) COMMENT 'Other miscellaneous deductions applied to this payment application (e.g., insurance adjustments, warranty holdbacks, disputed amounts).',
    `payment_date` DATE COMMENT 'Actual date when payment was issued to the subcontractor.',
    `payment_due_date` DATE COMMENT 'Contractual date by which payment must be made to the subcontractor after certification, typically 30 days from certification per standard payment terms.',
    `payment_reference_number` STRING COMMENT 'Financial system reference number or check number for the payment transaction (e.g., EFT reference, check number).',
    `payment_type` STRING COMMENT 'Classification of the payment application indicating the nature of the claim (progress payment for work completed, retention release at milestone, final payment at project closeout, mobilization advance, or stored materials payment).. Valid values are `progress|retention_release|final|mobilization|material_on_site`',
    `percent_complete_certified` DECIMAL(18,2) COMMENT 'Overall percentage of contract work completion certified by the project engineer or quantity surveyor, which may differ from the claimed percentage after field verification.',
    `percent_complete_claimed` DECIMAL(18,2) COMMENT 'Overall percentage of contract work completion claimed by the subcontractor in this payment application, calculated from Schedule of Values (SOV) line items.',
    `retention_percentage` DECIMAL(18,2) COMMENT 'Percentage of each payment withheld as retention per contract terms (e.g., 10% standard retention rate).',
    `retention_release_milestone` STRING COMMENT 'The contractual milestone triggering retention release (practical completion, DLP expiry, final completion, or partial release per contract terms).. Valid values are `practical_completion|dlp_expiry|final_completion|partial_release|none`',
    `retention_released_current` DECIMAL(18,2) COMMENT 'Amount of previously withheld retention released to the subcontractor in this payment application, typically upon reaching practical completion or DLP (Defects Liability Period) expiry milestone.',
    `retention_withheld_current` DECIMAL(18,2) COMMENT 'Amount of retention withheld from the current billing period payment based on the retention percentage.',
    `retention_withheld_total` DECIMAL(18,2) COMMENT 'Cumulative retention amount withheld from all payment applications to date.',
    `submission_date` DATE COMMENT 'Date when the subcontractor submitted the payment application to the general contractor or project owner. Principal business event timestamp for this transaction.',
    `submission_timestamp` TIMESTAMP COMMENT 'Precise timestamp when the payment application was submitted into the system.',
    `supporting_documents_submitted` BOOLEAN COMMENT 'Indicates whether all required supporting documentation (lien waivers, certified payroll, insurance certificates, progress photos) has been submitted with this payment application.',
    `total_earned_to_date` DECIMAL(18,2) COMMENT 'Total amount earned by the subcontractor through this billing period (work completed plus materials stored).',
    `work_completed_to_date` DECIMAL(18,2) COMMENT 'Cumulative value of all work completed from contract start through the end of this billing period, based on Schedule of Values (SOV) breakdown.',
    CONSTRAINT pk_bid_payment_application PRIMARY KEY(`bid_payment_application_id`)
) COMMENT 'Progress payment application (pay app) submitted by a subcontractor for work completed during a billing period, encompassing the full payment lifecycle from submission through certification to payment. Captures application number, billing period, payment type (progress, retention release, final), schedule of values breakdown by WBS/BOQ line, percent complete claimed, amount claimed, previously certified amount, certified amount, retention withheld, retention released, back-charges applied, net amount due, submission date, certification date, certifying engineer, payment due date, release milestone (practical completion, DLP expiry), and application status (submitted, under review, certified, paid, disputed). This is the SSOT for all subcontractor payment events including progress claims, interim certificates, retention releases, and final payments.';

CREATE OR REPLACE TABLE `vibe_construction_v1`.`bid`.`subcontractor_bond` (
    `subcontractor_bond_id` BIGINT COMMENT 'Primary key for subcontractor_bond',
    `construction_project_id` BIGINT COMMENT 'Reference to the construction project for which this bond is issued.',
    `hr_employee_id` BIGINT COMMENT 'Foreign key linking to hr.employee. Business justification: Bond records are created by a responsible employee; linking provides accountability and audit trail.',
    `firm_profile_id` BIGINT COMMENT 'Reference to the subcontractor providing this bond.',
    `subcontract_id` BIGINT COMMENT 'Reference to the subcontract or trade package that this bond secures.',
    `alert_threshold_days` STRING COMMENT 'Number of days before expiry at which an alert should be triggered for bond renewal or replacement (e.g., 30, 60, 90 days).',
    `bond_amount` DECIMAL(18,2) COMMENT 'Face value or penal sum of the bond in the contract currency. Represents the maximum liability of the surety.',
    `bond_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the bond amount (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `bond_form` STRING COMMENT 'Standard bond form or template used: AIA A311 (performance and payment bond), AIA A312 (performance and payment bond - current), FIDIC (international standard), custom (project-specific), or statutory (government-mandated form).. Valid values are `aia_a311|aia_a312|fidic|custom|statutory`',
    `bond_number` STRING COMMENT 'Unique bond certificate number issued by the surety company.',
    `bond_percentage` DECIMAL(18,2) COMMENT 'Bond amount expressed as a percentage of the subcontract value (e.g., 10.00 for 10% performance bond).',
    `bond_premium_amount` DECIMAL(18,2) COMMENT 'Cost paid by the subcontractor to the surety company for issuing the bond.',
    `bond_premium_rate` DECIMAL(18,2) COMMENT 'Premium rate expressed as a percentage of the bond amount (e.g., 0.0150 for 1.5% premium rate).',
    `bond_status` STRING COMMENT 'Current lifecycle status of the bond: active (in force), expired (past expiry date), called (claim made against bond), released (obligation discharged), cancelled (bond voided), or pending (awaiting activation).. Valid values are `active|expired|called|released|cancelled|pending`',
    `bond_type` STRING COMMENT 'Type of surety bond: performance bond (guarantees work completion), payment bond (guarantees payment to suppliers/workers), bid bond (guarantees bid acceptance), maintenance bond (guarantees defect-free period), supply bond (guarantees material delivery), or subdivision bond (guarantees infrastructure completion).. Valid values are `performance|payment|bid|maintenance|supply|subdivision`',
    `claim_amount` DECIMAL(18,2) COMMENT 'Amount claimed against the bond. Null if no claim has been filed.',
    `claim_filed_date` DATE COMMENT 'Date on which a claim was filed against the bond by the obligee. Null if no claim has been filed.',
    `claim_paid_amount` DECIMAL(18,2) COMMENT 'Amount paid by the surety to settle the claim. Null if no payment made or no claim filed.',
    `claim_resolution_date` DATE COMMENT 'Date on which the bond claim was resolved (paid, settled, or denied). Null if claim is unresolved or no claim filed.',
    `compliance_verified_by` STRING COMMENT 'Name or identifier of the person or system that last verified bond compliance.',
    `compliance_verified_date` DATE COMMENT 'Date on which the bond was last verified for compliance with contract requirements (amount, surety rating, expiry).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this bond record was first created in the system.',
    `document_reference` STRING COMMENT 'Reference identifier or file path to the scanned bond certificate or digital bond document stored in the document management system.',
    `effective_date` DATE COMMENT 'Date on which the bond becomes active and enforceable.',
    `expiry_date` DATE COMMENT 'Date on which the bond expires or is scheduled to be released. May be extended if the subcontract is extended.',
    `modified_by` STRING COMMENT 'User or system identifier that last modified this bond record.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this bond record was last modified.',
    `notes` STRING COMMENT 'Free-text notes or comments regarding the bond, including special conditions, amendments, or historical context.',
    `obligee_name` STRING COMMENT 'Name of the party protected by the bond, typically the general contractor (GC) or project owner.',
    `principal_name` STRING COMMENT 'Name of the principal party (subcontractor) whose performance is guaranteed by the bond.',
    `release_date` DATE COMMENT 'Date on which the bond was formally released by the obligee, discharging the suretys obligation.',
    `release_reason` STRING COMMENT 'Reason for bond release: subcontract completion, defects liability period expiry, mutual agreement, or other contractual milestone.',
    `renewal_date` DATE COMMENT 'Date on which the bond was last renewed or extended. Null if never renewed.',
    `renewal_required_flag` BOOLEAN COMMENT 'Indicates whether the bond requires renewal or extension (True) or is a one-time issuance (False).',
    `surety_company_am_best_rating` STRING COMMENT 'AM Best financial strength rating of the surety company (e.g., A++, A+, A, A-, B++). Indicates the suretys ability to meet its obligations.',
    `surety_company_name` STRING COMMENT 'Legal name of the surety company or insurance carrier issuing the bond.',
    `surety_license_number` STRING COMMENT 'State or jurisdiction license number of the surety company authorizing it to issue bonds.',
    CONSTRAINT pk_subcontractor_bond PRIMARY KEY(`subcontractor_bond_id`)
) COMMENT 'Surety bond records provided by subcontractors as financial security instruments, including performance bonds, payment bonds, and bid bonds. Captures bond type, surety company, bond number, bond amount, effective date, expiry date, bond status (active, called, released, expired), and the subcontract or trade package it secures. Tracks bonding compliance and triggers alerts for expiring or insufficient bonds.';

CREATE OR REPLACE TABLE `vibe_construction_v1`.`bid`.`tender` (
    `tender_id` BIGINT COMMENT 'Unique system-generated identifier for the tender record.',
    `account_id` BIGINT COMMENT 'Identifier of the client/owner for whom the tender is prepared.',
    `client_opportunity_id` BIGINT COMMENT 'Foreign key linking to client.client_opportunity. Business justification: Needed for Tender-to-Opportunity mapping used in pipeline forecasting and compliance reporting of client‑driven tenders.',
    `construction_project_id` BIGINT COMMENT 'Foreign key linking to project.construction_project. Business justification: Tender management – each tender is issued for a specific construction project, needed for schedule and cost integration.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Needed for Tender Cost Tracking: associates tender expenses with a finance cost center for accurate cost reporting and compliance with internal budgeting policies.',
    `hr_employee_id` BIGINT COMMENT 'Identifier of the lead estimator responsible for the tender package.',
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
    `construction_project_id` BIGINT COMMENT 'Identifier of the project to which this estimate belongs.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Ensures estimate preparation costs are charged to the appropriate finance cost center, supporting cost control and variance analysis between estimated and actual costs.',
    `engineering_submittal_id` BIGINT COMMENT 'Foreign key linking to design.design_submittal. Business justification: Estimators rely on design submittals to verify scope and specifications; the estimate must reference the submittal it is based on.',
    `embodied_carbon_assessment_id` BIGINT COMMENT 'Foreign key linking to sustainability.embodied_carbon_assessment. Business justification: Cost estimating processes incorporate embodied carbon assessments to evaluate carbon impact, necessitating a direct FK from estimate to the assessment.',
    `hr_employee_id` BIGINT COMMENT 'Identifier of the estimator or team responsible for the estimate.',
    `env_impact_assessment_id` BIGINT COMMENT 'Foreign key linking to compliance.env_impact_assessment. Business justification: Cost estimate incorporates mitigation measures identified in the environmental impact assessment.',
    `labor_rate_id` BIGINT COMMENT 'Foreign key linking to workforce.labor_rate. Business justification: Required for estimate cost calculations that use labor rates defined in workforce.labor_rate; estimators reference these rates to price labor components.',
    `submission_id` BIGINT COMMENT 'Identifier of the bid package or tender associated with the estimate.',
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
    `bim_model_id` BIGINT COMMENT 'Foreign key linking to design.bim_model. Business justification: Required for Quantity Takeoff: BOQ creation uses BIM model geometry to derive quantities; the BOQ must reference the BIM model used.',
    `construction_project_id` BIGINT COMMENT 'Foreign‑key hint referencing the overarching construction project for which the BOQ is prepared.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Links BOQ preparation to a finance cost center, enabling detailed cost center reporting for bill of quantities and supporting budget approvals.',
    `drawing_id` BIGINT COMMENT 'Foreign key linking to design.drawing. Business justification: Required for Quantity Takeoff: BOQ lines are derived from construction drawings; linking each BOQ to its source drawing enables traceability.',
    `hr_employee_id` BIGINT COMMENT 'Foreign key linking to hr.employee. Business justification: Needed for BOQ audit trail; the employee who prepares the Bill of Quantities must be recorded for compliance and accountability.',
    `tender_id` BIGINT COMMENT 'Foreign‑key hint linking the BOQ to the tender (project bid) it supports.',
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
    `specification_standard` STRING COMMENT 'Industry standard governing the format and measurement rules of the BOQ (e.g., NRM, POMI, CESMM).. Valid values are `NRM|POMI|CESMM`',
    `total_quantity` DECIMAL(18,2) COMMENT 'Aggregate of the quantity field from all BOQ line items, expressed in the unit defined by the specification standard.',
    `total_value` DECIMAL(18,2) COMMENT 'Aggregate price of all line items in the BOQ, expressed in the selected currency.',
    `updated_by` STRING COMMENT 'Login or employee identifier of the last person to modify the BOQ.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date‑time of the latest modification to any BOQ field.',
    `version_label` STRING COMMENT 'Human‑readable version identifier shown on the BOQ cover page.',
    `created_by` STRING COMMENT 'Login or employee identifier of the estimator who initially created the BOQ.',
    CONSTRAINT pk_boq PRIMARY KEY(`boq_id`)
) COMMENT 'Bill of Quantities master record defining the structured pricing document attached to a tender. Captures BOQ reference, revision number, BOQ type (measured, provisional, approximate), total BOQ value, currency, preparation date, and the specification standard applied (NRM, POMI, CESMM). Each BOQ is linked to a tender and decomposed into BOQ line items. SSOT for BOQ document identity and header-level pricing data.';

CREATE OR REPLACE TABLE `vibe_construction_v1`.`bid`.`estimate_line` (
    `estimate_line_id` BIGINT COMMENT 'Unique identifier for the estimate line item.',
    `asset_id` BIGINT COMMENT 'Identifier of plant/equipment associated with the line.',
    `construction_project_id` BIGINT COMMENT 'Identifier of the project to which the estimate belongs.',
    `estimate_id` BIGINT COMMENT 'Identifier of the parent estimate (transaction header) to which this line belongs.',
    `firm_profile_id` BIGINT COMMENT 'Identifier of the subcontractor providing the service or material.',
    `labor_rate_id` BIGINT COMMENT 'Foreign key linking to workforce.labor_rate. Business justification: Each estimate line may apply a specific labor rate; linking to workforce.labor_rate enables precise labor cost per line in bid estimates.',
    `master_id` BIGINT COMMENT 'Foreign key linking to material.material_master. Business justification: REQUIRED: Estimating uses master material data for unit pricing, compliance and spec reference, essential for accurate bid cost calculations.',
    `resource_id` BIGINT COMMENT 'Identifier of the resource (item, equipment, labour) associated with this line.',
    `approval_date` TIMESTAMP COMMENT 'Timestamp when the line was approved.',
    `approved_by` STRING COMMENT 'User identifier of the person who approved the line.',
    `baseline_cost` DECIMAL(18,2) COMMENT 'Original cost captured at baseline creation.',
    `change_order_number` STRING COMMENT 'Reference to a change order that modified this line.',
    `cost_category` STRING COMMENT 'Category of cost represented by the line (e.g., labour, material).. Valid values are `labour|material|plant|subcontract|indirect`',
    `cost_center_code` STRING COMMENT 'Internal cost centre responsible for the line expense.',
    `cost_code` STRING COMMENT 'Accounting cost code used for financial tracking of this line.',
    `cost_variance` DECIMAL(18,2) COMMENT 'Difference between revised and baseline cost.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the estimate line was created.',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 currency code for monetary values.',
    `estimate_line_status` STRING COMMENT 'Current lifecycle status of the estimate line.. Valid values are `draft|submitted|approved|rejected|archived`',
    `estimate_version` STRING COMMENT 'Version identifier of the estimate containing this line.',
    `is_deleted` BOOLEAN COMMENT 'Indicates whether the line has been soft‑deleted.',
    `labor_grade` STRING COMMENT 'Skill grade or classification of labour resources.',
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
    `regulatory_permit_id` BIGINT COMMENT 'Foreign key linking to compliance.permit. Business justification: Bid Submission Compliance Checklist requires attaching the required permit; ensures bid proceeds only when permit is secured.',
    `construction_project_id` BIGINT COMMENT 'Identifier of the project associated with the tender.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Assigns a cost center to bid submission expenses, required for post‑submission cost tracking and audit of bid‑related spend.',
    `hr_employee_id` BIGINT COMMENT 'Identifier of the person who performed the submission.',
    `firm_profile_id` BIGINT COMMENT 'Foreign key linking to bid.firm_profile. Business justification: Required for the Bid Submission Tracking report, which records which subcontractor submitted each bid; essential for award decision and compliance audit.',
    `jv_partner_id` BIGINT COMMENT 'Foreign key linking to bid.jv_partner. Business justification: Bid submission can be part of a joint venture; replace string with FK to jv_partner.',
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

CREATE OR REPLACE TABLE `vibe_construction_v1`.`bid`.`clarification` (
    `clarification_id` BIGINT COMMENT 'System-generated unique identifier for each bid clarification record.',
    `hr_employee_id` BIGINT COMMENT 'Foreign key linking to hr.employee. Business justification: Tracks which internal employee originated a clarification request, essential for the Clarification Log and responsibility reporting.',
    `party_id` BIGINT COMMENT 'Identifier of the party that originated the communication.',
    `document_register_id` BIGINT COMMENT 'Reference to the document (e.g., drawing, specification) associated with the clarification.',
    `rfi_id` BIGINT COMMENT 'Foreign key linking to design.rfi. Business justification: Bid clarifications often arise from RFIs; linking a clarification to its originating RFI tracks the source of the question.',
    `acknowledgement_status` STRING COMMENT 'Indicates whether the recipient has formally acknowledged receipt.. Valid values are `acknowledged|not_acknowledged`',
    `addendum_number` STRING COMMENT 'Identifier of the addendum referenced, if the communication is an addendum or amendment.',
    `attachment_flag` BOOLEAN COMMENT 'True if supporting files are attached to the clarification.',
    `bid_revision_triggered` BOOLEAN COMMENT 'Indicates whether the clarification caused a formal bid revision.',
    `clarification_number` STRING COMMENT 'External reference number assigned to the clarification by the tendering authority.',
    `clarification_status` STRING COMMENT 'Current lifecycle status of the clarification.. Valid values are `open|answered|closed|incorporated`',
    `communication_type` STRING COMMENT 'Category of the communication exchanged during the tender period.. Valid values are `RFI_issued|RFI_received|addendum|amendment|clarification`',
    `content` STRING COMMENT 'Full text of the original communication request or notice.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the clarification record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 currency code for the impact amount.',
    `direction` STRING COMMENT 'Indicates whether the communication originated from the client or the contractor.. Valid values are `client_to_contractor|contractor_to_client`',
    `event_timestamp` TIMESTAMP COMMENT 'Date and time when the communication was originally issued.',
    `impact_amount` DECIMAL(18,2) COMMENT 'Estimated monetary impact of the clarification on the bid.',
    `impact_description` STRING COMMENT 'Narrative description of how the clarification affects bid parameters.',
    `impact_flag_boq` BOOLEAN COMMENT 'True if the clarification affects the Bill of Quantities.',
    `impact_flag_price` BOOLEAN COMMENT 'True if the clarification alters the bid price.',
    `impact_flag_schedule` BOOLEAN COMMENT 'True if the clarification changes the project schedule.',
    `impact_flag_scope` BOOLEAN COMMENT 'True if the clarification modifies the project scope.',
    `impact_flag_specifications` BOOLEAN COMMENT 'True if the clarification changes technical specifications or drawings.',
    `is_critical` BOOLEAN COMMENT 'Marks the clarification as critical to bid success.',
    `issuing_authority` STRING COMMENT 'Entity that issued the communication (e.g., client, architect, engineer).',
    `notes` STRING COMMENT 'Free‑form notes or comments added by users.',
    `response_content` STRING COMMENT 'Full text of the response provided to the communication.',
    `response_deadline` DATE COMMENT 'Date by which the recipient must respond to the communication.',
    `response_status` STRING COMMENT 'Current status of the response process.. Valid values are `pending|provided|overdue`',
    `response_timestamp` TIMESTAMP COMMENT 'Date and time when the response was received or recorded.',
    `revised_submission_deadline` DATE COMMENT 'New deadline for bid submission if the clarification triggers a deadline change.',
    `revision_number` STRING COMMENT 'Sequential revision count for the clarification record.',
    `subject` STRING COMMENT 'Brief summary of the communication subject.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the clarification record.',
    CONSTRAINT pk_clarification PRIMARY KEY(`clarification_id`)
) COMMENT 'Record of all formal tender-period communications and document modifications including RFIs (Requests for Information), clarifications, client-issued addenda, and amendments that modify the RFP/RFQ documents. Captures communication reference, type (RFI_issued, RFI_received, addendum, amendment, clarification), direction, addendum number (where applicable), issuing authority, subject, content, response, impact flags (bid price, schedule, scope, BOQ, specifications, drawings), revised submission deadline (if applicable), acknowledgement status, bid revision triggered, and status (open, answered, closed, incorporated). SSOT for all tender-period correspondence, addenda tracking, and document amendment audit trail ensuring tender compliance.';

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
    `carbon_target_id` BIGINT COMMENT 'Foreign key linking to sustainability.carbon_target. Business justification: After award, the project commits to a carbon reduction target; linking win/loss record to carbon_target captures this commitment.',
    `construction_project_id` BIGINT COMMENT 'Identifier of the project for which the tender was issued.',
    `jv_partner_id` BIGINT COMMENT 'Foreign key linking to bid.jv_partner. Business justification: Win/loss record may reference the JV partner involved in the bid; replace string with FK to jv_partner.',
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

CREATE OR REPLACE TABLE `vibe_construction_v1`.`bid`.`vendor_quote` (
    `vendor_quote_id` BIGINT COMMENT 'Primary key for vendor_quote',
    `sustainable_material_id` BIGINT COMMENT 'Foreign key linking to sustainability.sustainable_material. Business justification: Vendor quotes for sustainable materials must reference the material record to verify sustainability credentials.',
    `vendor_id` BIGINT COMMENT 'Unique identifier of the vendor providing the quote.',
    `compliance_requirements_met` STRING COMMENT 'Indicates whether the quote satisfies required regulatory or project compliance criteria.. Valid values are `yes|no|partial`',
    `confidentiality_flag` BOOLEAN COMMENT 'Indicates whether the quote contains confidential or proprietary information.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the quote record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 code of the currency used for the quoted amount.',
    `delivery_lead_time_days` STRING COMMENT 'Number of calendar days required by the vendor to deliver the quoted items.',
    `delivery_terms` STRING COMMENT 'Standard Incoterms defining delivery responsibilities and costs.. Valid values are `EXW|FCA|FOB|CIF|DDP|DAP`',
    `documents_attached` STRING COMMENT 'Comma‑separated list of document identifiers linked to the quote.',
    `evaluation_score` DECIMAL(18,2) COMMENT 'Numeric score assigned during bid evaluation for this quote.',
    `notes` STRING COMMENT 'Free‑form comments or observations about the quote.',
    `qualifications_and_deviations` STRING COMMENT 'Vendor qualifications, assumptions, or deviations from the specification.',
    `quantity` DECIMAL(18,2) COMMENT 'Quantity of items, units, or work measured in the quote.',
    `quote_received_timestamp` TIMESTAMP COMMENT 'Timestamp when the quote was received from the vendor.',
    `quote_reference` STRING COMMENT 'External reference number assigned to the vendor quote by the vendor or system.',
    `quote_validity_date` DATE COMMENT 'Date until which the quoted prices and terms remain valid.',
    `quoted_amount` DECIMAL(18,2) COMMENT 'Total monetary amount quoted by the vendor before taxes or fees.',
    `regulatory_approval_required` BOOLEAN COMMENT 'Flag indicating if regulatory approval is needed for the quoted work or material.',
    `regulatory_approval_status` STRING COMMENT 'Current status of any required regulatory approval.. Valid values are `pending|approved|rejected`',
    `scope_exclusions` STRING COMMENT 'Items, services, or materials explicitly excluded from the quote.',
    `scope_inclusions` STRING COMMENT 'Items, services, or materials explicitly included in the quote.',
    `scope_of_work` STRING COMMENT 'Detailed description of the work or material scope covered by the quote.',
    `specification_reference` STRING COMMENT 'Reference to the technical specification or drawing that the quote addresses.',
    `total_quoted_value` DECIMAL(18,2) COMMENT 'Calculated total (quantity × unit price) before any discounts or taxes.',
    `trade_or_material_description` STRING COMMENT 'Brief description of the trade, service, or material being quoted.',
    `unit_of_measure` STRING COMMENT 'Unit of measure for the quoted quantity (e.g., m3, ton, pcs).',
    `unit_price` DECIMAL(18,2) COMMENT 'Price per unit of the quoted quantity.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the quote record.',
    `vendor_quote_status` STRING COMMENT 'Current lifecycle status of the quote.. Valid values are `received|evaluated|accepted|rejected|expired`',
    `vendor_type` STRING COMMENT 'Classification of the vendor providing the quote.. Valid values are `subcontractor|material_supplier|specialist_trade|plant_hire`',
    CONSTRAINT pk_vendor_quote PRIMARY KEY(`vendor_quote_id`)
) COMMENT 'Record of an external vendor quotation (subcontractor, material supplier, or specialist trade) received during bid preparation for incorporation into the project estimate. Captures quote reference, vendor name, vendor type (subcontractor, material_supplier, specialist_trade, plant_hire), trade or material description, specification reference, scope of work or material list, quoted amount, currency, quote validity date, quantity and unit of measure, unit price, total quoted value, scope inclusions, scope exclusions, qualifications and deviations, delivery lead time, delivery terms (Incoterms where applicable), and quote status (received, evaluated, accepted, rejected, expired). Supports cost build-up within the main tender estimate, vendor comparison analysis, and procurement handover upon award. SSOT for all external vendor pricing obtained during the bid phase.';

CREATE OR REPLACE TABLE `vibe_construction_v1`.`bid`.`jv_partner` (
    `jv_partner_id` BIGINT COMMENT 'Unique surrogate key for the JV partner record.',
    `account_id` BIGINT COMMENT 'Foreign key to client.account.account_id',
    `address_line1` STRING COMMENT 'First line of the partners mailing address.',
    `address_line2` STRING COMMENT 'Second line of the partners mailing address.',
    `city` STRING COMMENT 'City of the partners address.',
    `country_code` STRING COMMENT 'ISO 3166-1 alpha-3 country code of the partners headquarters.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the JV partner record was created.',
    `currency_code` STRING COMMENT 'ISO 4217 currency code for financial capacity amount.',
    `equity_share_percent` DECIMAL(18,2) COMMENT 'Percentage of equity ownership contributed by the partner.',
    `financial_capacity_amount` DECIMAL(18,2) COMMENT 'Monetary amount representing the partners financial capacity contribution.',
    `jv_agreement_reference` STRING COMMENT 'Reference identifier for the JV agreement document.',
    `mutator_note` STRING COMMENT 'Added by mutator',
    `jv_partner_name` STRING COMMENT 'Legal name of the partner organization participating in the joint venture.',
    `notes` STRING COMMENT 'Free-text field for any additional information about the partner.',
    `partner_status` STRING COMMENT 'Current status of the partner in the JV process.. Valid values are `active|withdrawn|suspended`',
    `partner_type` STRING COMMENT 'Classification of the partners role in the JV (lead, junior, specialist).. Valid values are `lead|junior|specialist`',
    `past_project_references` STRING COMMENT 'List or description of past projects the partner has provided as references.',
    `prequalification_status` STRING COMMENT 'Status of the partners prequalification for the project.. Valid values are `qualified|unqualified|pending`',
    `primary_contact_email` STRING COMMENT 'Email address of the primary contact person.. Valid values are `^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+.[A-Za-z]{2,}$`',
    `primary_contact_name` STRING COMMENT 'Name of the primary individual contact for the JV partner.',
    `primary_contact_phone` STRING COMMENT 'Telephone number of the primary contact.',
    `role_in_jv` STRING COMMENT 'Specific role the partner plays within the joint venture.. Valid values are `lead|junior|specialist`',
    `scope_of_work` STRING COMMENT 'Description of the work scope the partner is responsible for in the bid.',
    `state_province` STRING COMMENT 'State or province of the partners address.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the JV partner record.',
    CONSTRAINT pk_jv_partner PRIMARY KEY(`jv_partner_id`)
) COMMENT 'Master record for a Joint Venture (JV) or consortium partner engaged for a specific bid. Captures partner company name, partner role (lead partner, junior partner, specialist partner), equity share percentage, scope of work contribution, prequalification status, financial capacity contribution, country of origin, past project references provided, JV agreement reference, and partner status (active, withdrawn). Tracks JV formation and partner contributions specific to the bid phase.';

CREATE OR REPLACE TABLE `vibe_construction_v1`.`bid`.`approval` (
    `approval_id` BIGINT COMMENT 'Unique system-generated identifier for the bid approval record.',
    `assessment_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_assessment. Business justification: Bid approval decisions incorporate results of a compliance assessment report to ensure regulatory fit.',
    `pursuit_id` BIGINT COMMENT 'Foreign key linking to bid.bid_opportunity. Business justification: Bid approval should be linked to the originating bid opportunity for traceability.',
    `hr_employee_id` BIGINT COMMENT 'System identifier of the individual or role that made the approval decision.',
    `approval_number` STRING COMMENT 'Human‑readable reference number assigned to the approval event per internal governance policy.',
    `approval_status` STRING COMMENT 'Current lifecycle state of the approval record.. Valid values are `pending|approved|rejected|deferred|conditional_approved`',
    `approved_bid_price` DECIMAL(18,2) COMMENT 'Final approved monetary amount for the bid.',
    `approved_margin_pct` DECIMAL(18,2) COMMENT 'Approved profit margin expressed as a percentage of the bid price.',
    `bonding_capacity_score` DECIMAL(18,2) COMMENT 'Score reflecting the companys ability to provide required bid bonds.',
    `client_relationship_score` DECIMAL(18,2) COMMENT 'Score reflecting the strength of the relationship with the client.',
    `conditions_imposed` STRING COMMENT 'Any contractual or operational conditions attached to the approval.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the bid approval record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 code of the currency used for the approved bid price.',
    `deadline` DATE COMMENT 'Date by which the approved bid must be submitted.',
    `decision_authority_name` STRING COMMENT 'Full name of the person or entity authorizing the decision.',
    `decision_authority_role` STRING COMMENT 'Organizational role or title of the decision authority.',
    `decision_outcome` STRING COMMENT 'Result of the approval process (e.g., bid, no_bid, conditional_bid, approved, approved_with_conditions, rejected, deferred). [ENUM-REF-CANDIDATE: bid|no_bid|conditional_bid|approved|approved_with_conditions|rejected|deferred — promote to reference product]',
    `decision_rationale` STRING COMMENT 'Free‑text explanation of the reasoning behind the decision.',
    `decision_stage` STRING COMMENT 'Governance stage at which the decision was taken.. Valid values are `bid_no_bid|estimate_review|commercial_review|risk_review|executive_signoff`',
    `decision_timestamp` TIMESTAMP COMMENT 'Exact date‑time when the approval decision was recorded.',
    `delegation_of_authority_level` STRING COMMENT 'Authorized delegation tier that permitted the decision.. Valid values are `level_1|level_2|level_3|level_4`',
    `is_conditional` BOOLEAN COMMENT 'Indicates whether the approval is subject to conditions.',
    `margin_potential_score` DECIMAL(18,2) COMMENT 'Projected profitability score based on estimated margins.',
    `pursuit_investment_justification` STRING COMMENT 'Business case narrative justifying the investment of resources into the bid pursuit.',
    `resource_availability_score` DECIMAL(18,2) COMMENT 'Score indicating the availability of required resources for the project.',
    `risk_profile_score` DECIMAL(18,2) COMMENT 'Score assessing the risk exposure of the bid.',
    `risk_rating` STRING COMMENT 'Overall risk classification assigned to the bid pursuit.. Valid values are `low|medium|high|critical`',
    `strategic_fit_score` DECIMAL(18,2) COMMENT 'Score measuring alignment of the bid with corporate strategy.',
    `total_governance_score` DECIMAL(18,2) COMMENT 'Aggregated score from all governance criteria used to evaluate the bid.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the bid approval record.',
    `valid_until` DATE COMMENT 'Expiration date of the approval if not acted upon.',
    CONSTRAINT pk_approval PRIMARY KEY(`approval_id`)
) COMMENT 'Transactional record of a formal bid governance decision event within the internal authorization workflow, capturing the complete pursuit lifecycle from initial bid/no-bid decision through estimating review, commercial review, risk review, and executive sign-off. Stores approval stage (bid_no_bid, estimate_review, commercial_review, risk_review, executive_signoff), decision date, decision outcome (bid, no-bid, conditional_bid, approved, approved_with_conditions, rejected, deferred), decision authority (approver name and role), scoring against governance criteria (client relationship, risk profile, resource availability, margin potential, strategic fit, bonding capacity), total governance score, risk rating, approved bid price, approved margin percentage, conditions imposed, decision rationale narrative, delegation of authority level, and pursuit investment justification. SSOT for all bid governance decisions including pursuit authorization, resource allocation, and complete audit trail from opportunity pursuit through final submission authority.';

CREATE OR REPLACE TABLE `vibe_construction_v1`.`bid`.`response` (
    `response_id` BIGINT COMMENT 'Primary key for response',
    `firm_profile_id` BIGINT COMMENT 'Identifier of the subcontractor submitting the bid response.',
    `revised_response_id` BIGINT COMMENT 'Self-referencing FK on response (revised_response_id)',
    `trade_package_id` BIGINT COMMENT 'Identifier of the trade package (RFQ) to which this bid response relates.',
    `adjustment_amount` DECIMAL(18,2) COMMENT 'Any adjustments to the gross bid amount (e.g., taxes, fees, discounts).',
    `award_currency` STRING COMMENT 'Currency of the awarded contract value.. Valid values are `USD|EUR|GBP|JPY|CAD|AUD`',
    `award_date` DATE COMMENT 'Date on which the bid was formally awarded to the subcontractor.',
    `award_value` DECIMAL(18,2) COMMENT 'Monetary value of the contract awarded based on the winning bid.',
    `bid_amount` DECIMAL(18,2) COMMENT 'Total monetary amount requested by the subcontractor in the bid (gross).',
    `bid_reference` STRING COMMENT 'External reference code assigned to the bid response, used for tracking and communication.',
    `bid_type` STRING COMMENT 'Method used to price the bid: lump‑sum, line‑item breakdown, or unit‑price schedule.. Valid values are `lump_sum|line_item|unit_price`',
    `bond_amount` DECIMAL(18,2) COMMENT 'Monetary amount of the required performance bond.',
    `bond_required` BOOLEAN COMMENT 'Indicates whether a performance bond is required for this bid.',
    `clarification_status` STRING COMMENT 'Current status of any clarifications requested for the bid.. Valid values are `none|requested|provided|pending`',
    `commercial_ranking` STRING COMMENT 'Numeric ranking of the bid based on commercial criteria such as price and payment terms.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the bid response record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 code of the currency used for the bid amount.. Valid values are `USD|EUR|GBP|JPY|CAD|AUD`',
    `insurance_coverage_amount` DECIMAL(18,2) COMMENT 'Minimum insurance coverage amount required for the bid.',
    `insurance_required` BOOLEAN COMMENT 'Indicates whether insurance coverage is required for the subcontractor.',
    `net_amount` DECIMAL(18,2) COMMENT 'Net monetary amount after adjustments, representing the amount the subcontractor expects to be paid.',
    `notes` STRING COMMENT 'Free‑form text field for additional comments or special conditions attached to the bid.',
    `outcome` STRING COMMENT 'Final result of the bid evaluation process.. Valid values are `shortlisted|awarded|unsuccessful|withdrawn|pending`',
    `payment_terms_days` STRING COMMENT 'Number of days after invoice receipt that payment is due.',
    `response_status` STRING COMMENT 'Current lifecycle status of the bid response. [ENUM-REF-CANDIDATE: submitted|clarified|evaluated|shortlisted|awarded|unsuccessful|withdrawn|cancelled — 8 candidates stripped; promote to reference product]',
    `retention_percentage` DECIMAL(18,2) COMMENT 'Percentage of the contract value retained until final acceptance.',
    `submission_timestamp` TIMESTAMP COMMENT 'Date and time when the bid response was submitted by the subcontractor.',
    `technical_compliance_score` DECIMAL(18,2) COMMENT 'Score (0‑100) reflecting how well the bid meets technical specifications and requirements.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the bid response record.',
    `validity_end_date` DATE COMMENT 'Last date on which the bid amount is valid; after this date the bid expires.',
    `validity_start_date` DATE COMMENT 'First date on which the bid amount is considered valid.',
    CONSTRAINT pk_response PRIMARY KEY(`response_id`)
) COMMENT 'Bid/quotation submissions received from subcontractors in response to trade package RFQs. Captures bid reference, responding subcontractor, trade package, bid amount, bid breakdown (by BOQ line or lump-sum), bid validity period, submission date, clarification status, technical compliance score, commercial ranking, and bid outcome (shortlisted, awarded, unsuccessful, withdrawn). Enables competitive analysis and audit trail of the subcontractor selection process from RFQ to award.';

CREATE OR REPLACE TABLE `vibe_construction_v1`.`bid`.`bid_lien_waiver` (
    `bid_lien_waiver_id` BIGINT COMMENT 'System-generated unique identifier for the lien waiver record.',
    `firm_profile_id` BIGINT COMMENT 'Identifier of the subcontractor that issued the lien waiver.',
    `bid_payment_application_id` BIGINT COMMENT 'Identifier of the payment application to which this lien waiver is linked.',
    `superseded_lien_waiver_id` BIGINT COMMENT 'Self-referencing FK on lien_waiver (superseded_lien_waiver_id)',
    `compliance_met` BOOLEAN COMMENT 'Indicates whether the waiver satisfies all statutory and contractual compliance requirements.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the lien waiver record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 currency code for the waiver amount.',
    `document_url` STRING COMMENT 'Link to the stored electronic copy of the lien waiver document.',
    `execution_date` DATE COMMENT 'Date the lien waiver was signed and became effective.',
    `filing_date` DATE COMMENT 'Date the lien waiver was filed with the jurisdictional authority.',
    `filing_reference` STRING COMMENT 'Reference number or identifier for the filing of the lien waiver with the appropriate authority.',
    `jurisdiction_state` STRING COMMENT 'U.S. state or jurisdiction where the lien waiver is legally effective.',
    `notarization_date` DATE COMMENT 'Date the notarization of the lien waiver was completed.',
    `notarization_status` STRING COMMENT 'Indicates whether the waiver has been notarized.. Valid values are `notarized|pending|not_notarized`',
    `remarks` STRING COMMENT 'Free‑form comments or additional information about the lien waiver.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the lien waiver record.',
    `waiver_amount` DECIMAL(18,2) COMMENT 'Monetary amount covered by the lien waiver.',
    `waiver_number` STRING COMMENT 'External reference number assigned to the lien waiver by the contractor or project system.',
    `waiver_status` STRING COMMENT 'Current lifecycle status of the lien waiver.. Valid values are `pending|executed|rejected|void`',
    `waiver_type` STRING COMMENT 'Specifies whether the waiver is conditional, unconditional, progress, or final.. Valid values are `conditional|unconditional|progress|final`',
    CONSTRAINT pk_bid_lien_waiver PRIMARY KEY(`bid_lien_waiver_id`)
) COMMENT 'Lien waiver and statutory declaration records obtained from subcontractors as a condition of progress and final payments. Captures waiver type (conditional, unconditional, progress, final), subcontract reference, payment application reference, waiver amount, execution date, notarization status, and filing reference. Required in most US jurisdictions and analogous instruments (statutory declarations) in other markets to protect the GC from mechanics lien exposure.';

CREATE OR REPLACE TABLE `vibe_construction_v1`.`bid`.`bid_team_assignment` (
    `bid_team_assignment_id` BIGINT COMMENT 'Primary key for the BidTeamAssignment association',
    `pursuit_id` BIGINT COMMENT 'Foreign key linking to the bid opportunity',
    `construction_project_id` BIGINT COMMENT 'add column construction_project_id (BIGINT) with FK to project.construction_project.construction_project_id - team assignments are project-scoped',
    `hr_employee_id` BIGINT COMMENT 'Foreign key linking to the employee',
    `firm_profile_id` BIGINT COMMENT 'add column firm_profile_id (BIGINT) with FK to bid.firm_profile.firm_profile_id - bid team assignments must reference the bidding firm',
    `actual_hours` DECIMAL(18,2) COMMENT '',
    `allocation_pct` DECIMAL(18,2) COMMENT '',
    `allocation_percent` DECIMAL(18,2) COMMENT '',
    `allocation_percentage` DECIMAL(18,2) COMMENT 'Percentage of the employees time allocated to the bid opportunity',
    `assigned_by` STRING COMMENT '',
    `assigned_date` DATE COMMENT '',
    `assignment_end` DATE COMMENT '',
    `assignment_role` STRING COMMENT '',
    `assignment_start` DATE COMMENT '',
    `assignment_status` STRING COMMENT '',
    `created_timestamp` TIMESTAMP COMMENT '',
    `currency_code` STRING COMMENT '',
    `end_date` DATE COMMENT 'Date when the employees assignment to the bid opportunity ends',
    `hourly_rate` DECIMAL(18,2) COMMENT '',
    `is_lead` BOOLEAN COMMENT '',
    `lead_flag` BOOLEAN COMMENT '',
    `notes` STRING COMMENT '',
    `planned_hours` DECIMAL(18,2) COMMENT '',
    `remarks` STRING COMMENT '',
    `responsibility_area` STRING COMMENT '',
    `responsibility_description` STRING COMMENT '',
    `role` STRING COMMENT 'The role of the employee in the bid team (e.g., Bid Manager, Cost Estimator)',
    `start_date` DATE COMMENT 'Date when the employees assignment to the bid opportunity begins',
    `updated_timestamp` TIMESTAMP COMMENT '',
    CONSTRAINT pk_bid_team_assignment PRIMARY KEY(`bid_team_assignment_id`)
) COMMENT 'Represents the assignment of employees to bid opportunities, capturing each employees role, allocation percentage, and the start and end dates of the assignment. Each record links one bid opportunity to one employee.. Existence Justification: Bid opportunities are staffed by multiple employees, each with a defined role, allocation percentage, and assignment dates. Employees can be assigned to many bid opportunities over time. The assignment itself is a managed business entity that captures these details.';

CREATE OR REPLACE TABLE `vibe_construction_v1`.`bid`.`pursuit` (
    `pursuit_id` BIGINT COMMENT 'System-generated unique identifier for the bid opportunity record.',
    `account_id` BIGINT COMMENT 'Unique identifier of the client organization that the opportunity targets.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Required for Cost Allocation Report: tracks which finance cost center funds bid preparation expenses, essential for budgeting and profitability analysis of each bid opportunity.',
    `jv_partner_id` BIGINT COMMENT 'Foreign key linking to bid.jv_partner. Business justification: Bid opportunity may involve a joint venture partner; replace string with FK to jv_partner for referential integrity.',
    `bid_bond_amount` DECIMAL(18,2) COMMENT 'Financial guarantee amount required to submit the bid.',
    `bid_decision` STRING COMMENT 'Decision on whether to submit a bid for the opportunity.. Valid values are `bid|no_bid`',
    `bid_due_date` DATE COMMENT 'Final date by which the bid must be submitted.',
    `client_opportunity_id` BIGINT COMMENT 'Reference to single source of truth client.client_opportunity (SSOT duplicate resolution).',
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
    CONSTRAINT pk_pursuit PRIMARY KEY(`pursuit_id`)
) COMMENT 'Master record for each pre-award commercial opportunity tracked in Salesforce CRM. Captures the full pipeline entry from initial lead through bid submission, representing a potential project the business is pursuing. Stores opportunity name, client reference, market segment, project type, estimated contract value, probability of win, bid/no-bid decision, opportunity stage, source channel, geographic region, and pipeline forecast category. SSOT for commercial opportunity identity in the bid domain.';

CREATE OR REPLACE TABLE `vibe_construction_v1`.`bid`.`bid_pricing_line` (
    `bid_pricing_line_id` BIGINT COMMENT 'Unique identifier for the BOQ line item.',
    `boq_id` BIGINT COMMENT 'Identifier of the parent BOQ header.',
    `material_boq_line_id` BIGINT COMMENT 'SSOT reference to canonical material.material_boq_line (single source of truth).',
    `sustainable_material_id` BIGINT COMMENT 'Foreign key linking to sustainability.sustainable_material. Business justification: BOQ lines may specify sustainable materials; linking each line to the sustainable_material record enables tracking of green procurement.',
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
    `work_section` STRING COMMENT 'Higher-level grouping of work items (e.g., civil, structural, MEP).',
    CONSTRAINT pk_bid_pricing_line PRIMARY KEY(`bid_pricing_line_id`)
) COMMENT 'Individual line item within a Bill of Quantities, representing a discrete work item priced during bid preparation. Captures item code, WBS reference, work section, item description, unit of measure, quantity, unit rate, total amount, labour component, plant component, material component, subcontract component, and overhead allocation. Supports MTO-driven quantity take-off and rate build-up analysis. Essential for bid-to-actual cost variance tracking post-award.';

CREATE OR REPLACE TABLE `vibe_construction_v1`.`bid`.`pursuit_risk` (
    `pursuit_risk_id` BIGINT COMMENT 'System-generated unique identifier for the bid risk record.',
    `climate_risk_assessment_id` BIGINT COMMENT 'Foreign key linking to sustainability.climate_risk_assessment. Business justification: Bid risk registers include climate risk assessments; the FK ties each risk entry to its detailed climate risk assessment.',
    `construction_project_id` BIGINT COMMENT 'Foreign key linking to project.construction_project. Business justification: Risk register – risks identified in a bid are tracked against the associated construction project for integrated risk management.',
    `hr_employee_id` BIGINT COMMENT 'FK to hr.employee',
    `permit_condition_id` BIGINT COMMENT 'Foreign key linking to compliance.permit_condition. Business justification: Risk register links each risk to a specific permit condition that may trigger compliance penalties.',
    `primary_bid_employee_id` BIGINT COMMENT 'Identifier of the person or organisation responsible for managing the risk.',
    `pursuit_bid_employee_id` BIGINT COMMENT 'FK to hr.employee',
    `submission_id` BIGINT COMMENT 'Identifier of the bid to which this risk is attached.',
    `tender_id` BIGINT COMMENT 'Identifier of the tender associated with the risk.',
    `assessment_method` STRING COMMENT 'Methodology used to evaluate the risk.. Valid values are `qualitative|quantitative|mixed`',
    `attached_documents` STRING COMMENT 'Comma‑separated list of document identifiers linked to the risk.',
    `bid_risk_status` STRING COMMENT 'Current lifecycle state of the risk.. Valid values are `identified|mitigated|closed|monitoring`',
    `closed_date` DATE COMMENT 'Date the risk was formally closed.',
    `contingency_amount` DECIMAL(18,2) COMMENT 'Financial reserve allocated to cover the risk in the bid price.',
    `contingency_percentage` DECIMAL(18,2) COMMENT 'Contingency expressed as a percentage of the estimated cost impact.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the risk record was created in the system.',
    `exposure_currency` STRING COMMENT 'Three‑letter ISO 4217 currency code for monetary impact fields.',
    `identified_date` DATE COMMENT 'Date the risk was first recorded.',
    `impact_cost` DECIMAL(18,2) COMMENT 'Estimated monetary impact if the risk materialises, expressed in the project currency.',
    `impact_quality` STRING COMMENT 'Qualitative effect of the risk on project quality standards.. Valid values are `low|medium|high`',
    `impact_schedule_days` STRING COMMENT 'Estimated schedule delay in days caused by the risk.',
    `is_key_risk` BOOLEAN COMMENT 'Flag indicating whether the risk is considered a key risk for the bid.',
    `mitigation_end_date` DATE COMMENT 'Planned or actual completion date for mitigation.',
    `mitigation_start_date` DATE COMMENT 'Planned start date for mitigation activities.',
    `mitigation_strategy` STRING COMMENT 'Planned actions to reduce probability or impact of the risk.',
    `notes` STRING COMMENT 'Free‑form notes or comments added by risk owners.',
    `origin` STRING COMMENT 'Origin of the risk, indicating whether it arises from internal processes or external factors.. Valid values are `internal|external`',
    `priority` STRING COMMENT 'Prioritisation level used for reporting and escalation.. Valid values are `low|medium|high|critical`',
    `probability_rating` STRING COMMENT 'Likelihood of the risk occurring, expressed as a qualitative rating.. Valid values are `low|medium|high`',
    `residual_impact_cost` DECIMAL(18,2) COMMENT 'Estimated monetary impact remaining after mitigation.',
    `residual_probability` STRING COMMENT 'Likelihood of the risk after mitigation actions are applied.. Valid values are `low|medium|high`',
    `residual_risk_score` DECIMAL(18,2) COMMENT 'Risk score after mitigation, used for ongoing monitoring.',
    `review_frequency` STRING COMMENT 'How often the risk is reviewed and re‑assessed.. Valid values are `weekly|monthly|quarterly|ad_hoc`',
    `risk_category` STRING COMMENT 'Primary classification of the risk affecting the bid phase.. Valid values are `commercial|technical|geotechnical|regulatory|supply_chain|force_majeure`',
    `risk_code` STRING COMMENT 'External reference code used by project teams to identify the risk in reports and documents.',
    `risk_description` STRING COMMENT 'Detailed narrative describing the nature, cause and potential consequences of the risk.',
    `schedule_risk_id` BIGINT COMMENT 'SSOT reference to canonical schedule.schedule_risk (single source of truth).',
    `score` DECIMAL(18,2) COMMENT 'Composite score derived from probability and impact, used for prioritisation.',
    `title` STRING COMMENT 'Brief human‑readable title that summarises the risk.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the risk record.',
    CONSTRAINT pk_pursuit_risk PRIMARY KEY(`pursuit_risk_id`)
) COMMENT 'Risk register entry specific to the bid phase, capturing identified risks and opportunities that influence bid pricing strategy and contingency allocation. Stores risk ID, risk category (commercial, technical, geotechnical, regulatory, supply chain, force majeure), risk description, probability rating, impact rating (cost, schedule, quality), risk score, mitigation strategy, contingency amount allocated, risk owner, and residual risk rating. Feeds bid pricing decisions and GMP contingency calculations. [SSOT: distinct source of truth for bid domain]';

CREATE OR REPLACE TABLE `vibe_construction_v1`.`bid`.`bidder_prequalification` (
    `bidder_prequalification_id` BIGINT COMMENT 'Unique surrogate key for each prequalification record.',
    `account_id` BIGINT COMMENT 'Identifier of the client for which the prequalification is held.',
    `construction_project_id` BIGINT COMMENT 'Identifier of the project or framework linked to the prequalification.',
    `hr_employee_id` BIGINT COMMENT 'Identifier of the employee who performed the last review.',
    `jv_partner_id` BIGINT COMMENT 'Foreign key linking to bid.jv_partner. Business justification: Prequalification can be for a joint venture; replace string with FK to jv_partner.',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: Prequalification process validates that the contractor meets required regulatory obligations for the project.',
    `bid_bond_amount` DECIMAL(18,2) COMMENT 'Monetary amount of the required bid bond.',
    `bid_bond_currency` STRING COMMENT 'ISO 4217 currency code for the bid bond amount.',
    `bid_bond_expiry_date` DATE COMMENT 'Date the bid bond must be released or returned.',
    `bid_bond_required` BOOLEAN COMMENT 'Indicates whether a bid bond must be posted for this prequalification.',
    `bid_prequalification_status` STRING COMMENT 'Current lifecycle status of the prequalification.. Valid values are `submitted|approved|conditionally_approved|rejected|expired`',
    `client_prequalification_id` BIGINT COMMENT 'SSOT reference to canonical client.client_prequalification (single source of truth).',
    `confidentiality_flag` STRING COMMENT 'Classification of the prequalification record for data handling.. Valid values are `public|internal|confidential|restricted`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the prequalification record was first created in the system.',
    `documents_attached` BOOLEAN COMMENT 'Indicates whether supporting documents have been uploaded.',
    `effective_from` DATE COMMENT 'Date the prequalification becomes effective for tender participation.',
    `effective_until` DATE COMMENT 'Date the prequalification ceases to be effective (nullable for open‑ended).',
    `evaluation_score` DECIMAL(18,2) COMMENT 'Numeric score (0‑100) from the client’s evaluation of the prequalification.',
    `expiry_date` DATE COMMENT 'Date the prequalification expires if not renewed.',
    `financial_capacity_currency` STRING COMMENT 'ISO 4217 currency code for the financial capacity threshold.',
    `financial_capacity_threshold` DECIMAL(18,2) COMMENT 'Minimum financial capacity (in currency) required to be eligible.',
    `hsse_performance_score` DECIMAL(18,2) COMMENT 'Score (0‑100) summarising health, safety, security and environmental performance.',
    `is_joint_venture` BOOLEAN COMMENT 'True if the prequalification is submitted as part of a joint‑venture partnership.',
    `last_review_date` DATE COMMENT 'Date the prequalification was last reviewed for renewal or amendment.',
    `notes` STRING COMMENT 'Free‑form comments or observations about the prequalification.',
    `prequalification_category` STRING COMMENT 'Classification of the prequalification based on scope and partnership type.. Valid values are `general|specialized|joint_venture|subcontractor`',
    `procurement_category` STRING COMMENT 'High‑level category of goods or services the prequalification covers.. Valid values are `materials|services|equipment|consultancy|subcontractor|other`',
    `reference` STRING COMMENT 'Business identifier assigned to the prequalification (e.g., PQ-2023-001).',
    `regulatory_approval_required` BOOLEAN COMMENT 'True if external regulatory approval is needed for the prequalification.',
    `regulatory_approval_status` STRING COMMENT 'Current status of any required regulatory approval.. Valid values are `pending|approved|rejected`',
    `risk_rating` STRING COMMENT 'Overall risk rating assigned to the prequalification.. Valid values are `low|medium|high`',
    `submission_date` DATE COMMENT 'Date the prequalification was submitted to the client.',
    `technical_capacity_score` DECIMAL(18,2) COMMENT 'Score (0‑100) reflecting technical capability to deliver the work.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the prequalification record.',
    `version_number` STRING COMMENT 'Incremental version of the prequalification record for change tracking.',
    CONSTRAINT pk_bidder_prequalification PRIMARY KEY(`bidder_prequalification_id`)
) COMMENT 'Master record tracking the prequalification (PQ) status of the business for a specific client, project, or procurement category. Captures PQ reference, client name, project or framework name, PQ submission date, PQ expiry date, PQ status (submitted, approved, conditionally approved, rejected, expired), financial capacity threshold, technical capacity score, HSSE performance score, and prequalification category. Ensures the business maintains current PQ standing to participate in tenders. [SSOT: distinct source of truth for bid domain]';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_construction_v1`.`bid`.`firm_profile` ADD CONSTRAINT `fk_bid_firm_profile_subcontractor_prequalification_id` FOREIGN KEY (`subcontractor_prequalification_id`) REFERENCES `vibe_construction_v1`.`bid`.`subcontractor_prequalification`(`subcontractor_prequalification_id`);
ALTER TABLE `vibe_construction_v1`.`bid`.`trade_package` ADD CONSTRAINT `fk_bid_trade_package_firm_profile_id` FOREIGN KEY (`firm_profile_id`) REFERENCES `vibe_construction_v1`.`bid`.`firm_profile`(`firm_profile_id`);
ALTER TABLE `vibe_construction_v1`.`bid`.`bid_contract_agreement` ADD CONSTRAINT `fk_bid_bid_contract_agreement_firm_profile_id` FOREIGN KEY (`firm_profile_id`) REFERENCES `vibe_construction_v1`.`bid`.`firm_profile`(`firm_profile_id`);
ALTER TABLE `vibe_construction_v1`.`bid`.`bid_payment_application` ADD CONSTRAINT `fk_bid_bid_payment_application_bid_contract_agreement_id` FOREIGN KEY (`bid_contract_agreement_id`) REFERENCES `vibe_construction_v1`.`bid`.`bid_contract_agreement`(`bid_contract_agreement_id`);
ALTER TABLE `vibe_construction_v1`.`bid`.`bid_payment_application` ADD CONSTRAINT `fk_bid_bid_payment_application_firm_profile_id` FOREIGN KEY (`firm_profile_id`) REFERENCES `vibe_construction_v1`.`bid`.`firm_profile`(`firm_profile_id`);
ALTER TABLE `vibe_construction_v1`.`bid`.`subcontractor_bond` ADD CONSTRAINT `fk_bid_subcontractor_bond_firm_profile_id` FOREIGN KEY (`firm_profile_id`) REFERENCES `vibe_construction_v1`.`bid`.`firm_profile`(`firm_profile_id`);
ALTER TABLE `vibe_construction_v1`.`bid`.`estimate` ADD CONSTRAINT `fk_bid_estimate_submission_id` FOREIGN KEY (`submission_id`) REFERENCES `vibe_construction_v1`.`bid`.`submission`(`submission_id`);
ALTER TABLE `vibe_construction_v1`.`bid`.`boq` ADD CONSTRAINT `fk_bid_boq_tender_id` FOREIGN KEY (`tender_id`) REFERENCES `vibe_construction_v1`.`bid`.`tender`(`tender_id`);
ALTER TABLE `vibe_construction_v1`.`bid`.`estimate_line` ADD CONSTRAINT `fk_bid_estimate_line_estimate_id` FOREIGN KEY (`estimate_id`) REFERENCES `vibe_construction_v1`.`bid`.`estimate`(`estimate_id`);
ALTER TABLE `vibe_construction_v1`.`bid`.`estimate_line` ADD CONSTRAINT `fk_bid_estimate_line_firm_profile_id` FOREIGN KEY (`firm_profile_id`) REFERENCES `vibe_construction_v1`.`bid`.`firm_profile`(`firm_profile_id`);
ALTER TABLE `vibe_construction_v1`.`bid`.`submission` ADD CONSTRAINT `fk_bid_submission_firm_profile_id` FOREIGN KEY (`firm_profile_id`) REFERENCES `vibe_construction_v1`.`bid`.`firm_profile`(`firm_profile_id`);
ALTER TABLE `vibe_construction_v1`.`bid`.`submission` ADD CONSTRAINT `fk_bid_submission_jv_partner_id` FOREIGN KEY (`jv_partner_id`) REFERENCES `vibe_construction_v1`.`bid`.`jv_partner`(`jv_partner_id`);
ALTER TABLE `vibe_construction_v1`.`bid`.`bond` ADD CONSTRAINT `fk_bid_bond_tender_id` FOREIGN KEY (`tender_id`) REFERENCES `vibe_construction_v1`.`bid`.`tender`(`tender_id`);
ALTER TABLE `vibe_construction_v1`.`bid`.`win_loss_record` ADD CONSTRAINT `fk_bid_win_loss_record_jv_partner_id` FOREIGN KEY (`jv_partner_id`) REFERENCES `vibe_construction_v1`.`bid`.`jv_partner`(`jv_partner_id`);
ALTER TABLE `vibe_construction_v1`.`bid`.`win_loss_record` ADD CONSTRAINT `fk_bid_win_loss_record_submission_id` FOREIGN KEY (`submission_id`) REFERENCES `vibe_construction_v1`.`bid`.`submission`(`submission_id`);
ALTER TABLE `vibe_construction_v1`.`bid`.`win_loss_record` ADD CONSTRAINT `fk_bid_win_loss_record_tender_id` FOREIGN KEY (`tender_id`) REFERENCES `vibe_construction_v1`.`bid`.`tender`(`tender_id`);
ALTER TABLE `vibe_construction_v1`.`bid`.`approval` ADD CONSTRAINT `fk_bid_approval_pursuit_id` FOREIGN KEY (`pursuit_id`) REFERENCES `vibe_construction_v1`.`bid`.`pursuit`(`pursuit_id`);
ALTER TABLE `vibe_construction_v1`.`bid`.`response` ADD CONSTRAINT `fk_bid_response_firm_profile_id` FOREIGN KEY (`firm_profile_id`) REFERENCES `vibe_construction_v1`.`bid`.`firm_profile`(`firm_profile_id`);
ALTER TABLE `vibe_construction_v1`.`bid`.`response` ADD CONSTRAINT `fk_bid_response_revised_response_id` FOREIGN KEY (`revised_response_id`) REFERENCES `vibe_construction_v1`.`bid`.`response`(`response_id`);
ALTER TABLE `vibe_construction_v1`.`bid`.`response` ADD CONSTRAINT `fk_bid_response_trade_package_id` FOREIGN KEY (`trade_package_id`) REFERENCES `vibe_construction_v1`.`bid`.`trade_package`(`trade_package_id`);
ALTER TABLE `vibe_construction_v1`.`bid`.`bid_lien_waiver` ADD CONSTRAINT `fk_bid_bid_lien_waiver_firm_profile_id` FOREIGN KEY (`firm_profile_id`) REFERENCES `vibe_construction_v1`.`bid`.`firm_profile`(`firm_profile_id`);
ALTER TABLE `vibe_construction_v1`.`bid`.`bid_lien_waiver` ADD CONSTRAINT `fk_bid_bid_lien_waiver_bid_payment_application_id` FOREIGN KEY (`bid_payment_application_id`) REFERENCES `vibe_construction_v1`.`bid`.`bid_payment_application`(`bid_payment_application_id`);
ALTER TABLE `vibe_construction_v1`.`bid`.`bid_lien_waiver` ADD CONSTRAINT `fk_bid_bid_lien_waiver_superseded_lien_waiver_id` FOREIGN KEY (`superseded_lien_waiver_id`) REFERENCES `vibe_construction_v1`.`bid`.`bid_lien_waiver`(`bid_lien_waiver_id`);
ALTER TABLE `vibe_construction_v1`.`bid`.`bid_team_assignment` ADD CONSTRAINT `fk_bid_bid_team_assignment_pursuit_id` FOREIGN KEY (`pursuit_id`) REFERENCES `vibe_construction_v1`.`bid`.`pursuit`(`pursuit_id`);
ALTER TABLE `vibe_construction_v1`.`bid`.`bid_team_assignment` ADD CONSTRAINT `fk_bid_bid_team_assignment_firm_profile_id` FOREIGN KEY (`firm_profile_id`) REFERENCES `vibe_construction_v1`.`bid`.`firm_profile`(`firm_profile_id`);
ALTER TABLE `vibe_construction_v1`.`bid`.`pursuit` ADD CONSTRAINT `fk_bid_pursuit_jv_partner_id` FOREIGN KEY (`jv_partner_id`) REFERENCES `vibe_construction_v1`.`bid`.`jv_partner`(`jv_partner_id`);
ALTER TABLE `vibe_construction_v1`.`bid`.`bid_pricing_line` ADD CONSTRAINT `fk_bid_bid_pricing_line_boq_id` FOREIGN KEY (`boq_id`) REFERENCES `vibe_construction_v1`.`bid`.`boq`(`boq_id`);
ALTER TABLE `vibe_construction_v1`.`bid`.`pursuit_risk` ADD CONSTRAINT `fk_bid_pursuit_risk_submission_id` FOREIGN KEY (`submission_id`) REFERENCES `vibe_construction_v1`.`bid`.`submission`(`submission_id`);
ALTER TABLE `vibe_construction_v1`.`bid`.`pursuit_risk` ADD CONSTRAINT `fk_bid_pursuit_risk_tender_id` FOREIGN KEY (`tender_id`) REFERENCES `vibe_construction_v1`.`bid`.`tender`(`tender_id`);
ALTER TABLE `vibe_construction_v1`.`bid`.`bidder_prequalification` ADD CONSTRAINT `fk_bid_bidder_prequalification_jv_partner_id` FOREIGN KEY (`jv_partner_id`) REFERENCES `vibe_construction_v1`.`bid`.`jv_partner`(`jv_partner_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_construction_v1`.`bid` SET TAGS ('pii_division' = 'business');
ALTER SCHEMA `vibe_construction_v1`.`bid` SET TAGS ('pii_domain' = 'bid');
ALTER TABLE `vibe_construction_v1`.`bid`.`firm_profile` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_construction_v1`.`bid`.`firm_profile` SET TAGS ('pii_subdomain' = 'partner_qualification');
ALTER TABLE `vibe_construction_v1`.`bid`.`firm_profile` SET TAGS ('pii_required_structure' = 'v2');
ALTER TABLE `vibe_construction_v1`.`bid`.`firm_profile` SET TAGS ('pii_ecm_structure' = 'preserved_v2');
ALTER TABLE `vibe_construction_v1`.`bid`.`firm_profile` SET TAGS ('pii_structure_required' = 'true');
ALTER TABLE `vibe_construction_v1`.`bid`.`firm_profile` ALTER COLUMN `firm_profile_id` SET TAGS ('pii_business_glossary_term' = 'Firm Profile Identifier');
ALTER TABLE `vibe_construction_v1`.`bid`.`firm_profile` ALTER COLUMN `annual_revenue_band` SET TAGS ('pii_business_glossary_term' = 'Annual Revenue Band');
ALTER TABLE `vibe_construction_v1`.`bid`.`firm_profile` ALTER COLUMN `annual_revenue_band` SET TAGS ('pii_value_regex' = 'under_1m|1m_to_5m|5m_to_25m|25m_to_100m|over_100m');
ALTER TABLE `vibe_construction_v1`.`bid`.`firm_profile` ALTER COLUMN `annual_revenue_band` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`bid`.`firm_profile` ALTER COLUMN `bonding_capacity_usd` SET TAGS ('pii_business_glossary_term' = 'Bonding Capacity (USD)');
ALTER TABLE `vibe_construction_v1`.`bid`.`firm_profile` ALTER COLUMN `bonding_capacity_usd` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`bid`.`firm_profile` ALTER COLUMN `company_registration_number` SET TAGS ('pii_business_glossary_term' = 'Company Registration Number');
ALTER TABLE `vibe_construction_v1`.`bid`.`firm_profile` ALTER COLUMN `company_registration_number` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`bid`.`firm_profile` ALTER COLUMN `contractor_license_expiry_date` SET TAGS ('pii_business_glossary_term' = 'Contractor License Expiry Date');
ALTER TABLE `vibe_construction_v1`.`bid`.`firm_profile` ALTER COLUMN `contractor_license_number` SET TAGS ('pii_business_glossary_term' = 'Contractor License Number');
ALTER TABLE `vibe_construction_v1`.`bid`.`firm_profile` ALTER COLUMN `contractor_license_number` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`bid`.`firm_profile` ALTER COLUMN `contractor_license_state` SET TAGS ('pii_business_glossary_term' = 'Contractor License State');
ALTER TABLE `vibe_construction_v1`.`bid`.`firm_profile` ALTER COLUMN `contractor_license_state` SET TAGS ('pii_value_regex' = '^[A-Z]{2}$');
ALTER TABLE `vibe_construction_v1`.`bid`.`firm_profile` ALTER COLUMN `country_of_incorporation` SET TAGS ('pii_business_glossary_term' = 'Country of Incorporation');
ALTER TABLE `vibe_construction_v1`.`bid`.`firm_profile` ALTER COLUMN `country_of_incorporation` SET TAGS ('pii_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_construction_v1`.`bid`.`firm_profile` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_construction_v1`.`bid`.`firm_profile` ALTER COLUMN `dbe_certified` SET TAGS ('pii_business_glossary_term' = 'Disadvantaged Business Enterprise (DBE) Certified');
ALTER TABLE `vibe_construction_v1`.`bid`.`firm_profile` ALTER COLUMN `diversity_certification_expiry_date` SET TAGS ('pii_business_glossary_term' = 'Diversity Certification Expiry Date');
ALTER TABLE `vibe_construction_v1`.`bid`.`firm_profile` ALTER COLUMN `emr` SET TAGS ('pii_business_glossary_term' = 'Experience Modification Rate (EMR)');
ALTER TABLE `vibe_construction_v1`.`bid`.`firm_profile` ALTER COLUMN `emr` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`bid`.`firm_profile` ALTER COLUMN `emr_reference_year` SET TAGS ('pii_business_glossary_term' = 'Experience Modification Rate (EMR) Reference Year');
ALTER TABLE `vibe_construction_v1`.`bid`.`firm_profile` ALTER COLUMN `firm_status` SET TAGS ('pii_business_glossary_term' = 'Firm Status');
ALTER TABLE `vibe_construction_v1`.`bid`.`firm_profile` ALTER COLUMN `firm_status` SET TAGS ('pii_value_regex' = 'active|inactive|suspended|blacklisted|pending_review');
ALTER TABLE `vibe_construction_v1`.`bid`.`firm_profile` ALTER COLUMN `geographic_coverage_regions` SET TAGS ('pii_business_glossary_term' = 'Geographic Coverage Regions');
ALTER TABLE `vibe_construction_v1`.`bid`.`firm_profile` ALTER COLUMN `headquarters_address` SET TAGS ('pii_business_glossary_term' = 'Headquarters Address');
ALTER TABLE `vibe_construction_v1`.`bid`.`firm_profile` ALTER COLUMN `headquarters_address` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`bid`.`firm_profile` ALTER COLUMN `headquarters_address` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_construction_v1`.`bid`.`firm_profile` ALTER COLUMN `headquarters_city` SET TAGS ('pii_business_glossary_term' = 'Headquarters City');
ALTER TABLE `vibe_construction_v1`.`bid`.`firm_profile` ALTER COLUMN `headquarters_city` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`bid`.`firm_profile` ALTER COLUMN `headquarters_city` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_construction_v1`.`bid`.`firm_profile` ALTER COLUMN `headquarters_country` SET TAGS ('pii_business_glossary_term' = 'Headquarters Country');
ALTER TABLE `vibe_construction_v1`.`bid`.`firm_profile` ALTER COLUMN `headquarters_country` SET TAGS ('pii_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_construction_v1`.`bid`.`firm_profile` ALTER COLUMN `headquarters_postal_code` SET TAGS ('pii_business_glossary_term' = 'Headquarters Postal Code');
ALTER TABLE `vibe_construction_v1`.`bid`.`firm_profile` ALTER COLUMN `headquarters_postal_code` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`bid`.`firm_profile` ALTER COLUMN `headquarters_postal_code` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_construction_v1`.`bid`.`firm_profile` ALTER COLUMN `headquarters_state` SET TAGS ('pii_business_glossary_term' = 'Headquarters State');
ALTER TABLE `vibe_construction_v1`.`bid`.`firm_profile` ALTER COLUMN `headquarters_state` SET TAGS ('pii_value_regex' = '^[A-Z]{2}$');
ALTER TABLE `vibe_construction_v1`.`bid`.`firm_profile` ALTER COLUMN `headquarters_state` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`bid`.`firm_profile` ALTER COLUMN `headquarters_state` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_construction_v1`.`bid`.`firm_profile` ALTER COLUMN `insurance_gl_expiry_date` SET TAGS ('pii_business_glossary_term' = 'General Liability (GL) Insurance Expiry Date');
ALTER TABLE `vibe_construction_v1`.`bid`.`firm_profile` ALTER COLUMN `insurance_wc_expiry_date` SET TAGS ('pii_business_glossary_term' = 'Workers Compensation (WC) Insurance Expiry Date');
ALTER TABLE `vibe_construction_v1`.`bid`.`firm_profile` ALTER COLUMN `is_union_shop` SET TAGS ('pii_business_glossary_term' = 'Union Shop Indicator');
ALTER TABLE `vibe_construction_v1`.`bid`.`firm_profile` ALTER COLUMN `iso_45001_certified` SET TAGS ('pii_business_glossary_term' = 'ISO 45001 Occupational Health and Safety Certified');
ALTER TABLE `vibe_construction_v1`.`bid`.`firm_profile` ALTER COLUMN `iso_9001_certified` SET TAGS ('pii_business_glossary_term' = 'ISO 9001 Quality Management System Certified');
ALTER TABLE `vibe_construction_v1`.`bid`.`firm_profile` ALTER COLUMN `last_updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `vibe_construction_v1`.`bid`.`firm_profile` ALTER COLUMN `leed_accredited` SET TAGS ('pii_business_glossary_term' = 'Leadership in Energy and Environmental Design (LEED) Accredited');
ALTER TABLE `vibe_construction_v1`.`bid`.`firm_profile` ALTER COLUMN `legal_entity_name` SET TAGS ('pii_business_glossary_term' = 'Legal Entity Name');
ALTER TABLE `vibe_construction_v1`.`bid`.`firm_profile` ALTER COLUMN `legal_entity_name` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`bid`.`firm_profile` ALTER COLUMN `mbe_certified` SET TAGS ('pii_business_glossary_term' = 'Minority Business Enterprise (MBE) Certified');
ALTER TABLE `vibe_construction_v1`.`bid`.`firm_profile` ALTER COLUMN `naics_code` SET TAGS ('pii_business_glossary_term' = 'North American Industry Classification System (NAICS) Code');
ALTER TABLE `vibe_construction_v1`.`bid`.`firm_profile` ALTER COLUMN `naics_code` SET TAGS ('pii_value_regex' = '^[0-9]{6}$');
ALTER TABLE `vibe_construction_v1`.`bid`.`firm_profile` ALTER COLUMN `prequalification_expiry_date` SET TAGS ('pii_business_glossary_term' = 'Prequalification Expiry Date');
ALTER TABLE `vibe_construction_v1`.`bid`.`firm_profile` ALTER COLUMN `prequalification_status` SET TAGS ('pii_business_glossary_term' = 'Prequalification Status');
ALTER TABLE `vibe_construction_v1`.`bid`.`firm_profile` ALTER COLUMN `prequalification_status` SET TAGS ('pii_value_regex' = 'approved|conditional|expired|rejected|pending');
ALTER TABLE `vibe_construction_v1`.`bid`.`firm_profile` ALTER COLUMN `primary_contact_email` SET TAGS ('pii_business_glossary_term' = 'Primary Contact Email Address');
ALTER TABLE `vibe_construction_v1`.`bid`.`firm_profile` ALTER COLUMN `primary_contact_email` SET TAGS ('pii_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_construction_v1`.`bid`.`firm_profile` ALTER COLUMN `primary_contact_email` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_construction_v1`.`bid`.`firm_profile` ALTER COLUMN `primary_contact_email` SET TAGS ('pii_email' = 'true');
ALTER TABLE `vibe_construction_v1`.`bid`.`firm_profile` ALTER COLUMN `primary_contact_name` SET TAGS ('pii_business_glossary_term' = 'Primary Contact Name');
ALTER TABLE `vibe_construction_v1`.`bid`.`firm_profile` ALTER COLUMN `primary_contact_name` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_construction_v1`.`bid`.`firm_profile` ALTER COLUMN `primary_contact_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_construction_v1`.`bid`.`firm_profile` ALTER COLUMN `primary_contact_phone` SET TAGS ('pii_business_glossary_term' = 'Primary Contact Phone Number');
ALTER TABLE `vibe_construction_v1`.`bid`.`firm_profile` ALTER COLUMN `primary_contact_phone` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_construction_v1`.`bid`.`firm_profile` ALTER COLUMN `primary_contact_phone` SET TAGS ('pii_phone' = 'true');
ALTER TABLE `vibe_construction_v1`.`bid`.`firm_profile` ALTER COLUMN `primary_trade_classification` SET TAGS ('pii_business_glossary_term' = 'Primary Trade Classification');
ALTER TABLE `vibe_construction_v1`.`bid`.`firm_profile` ALTER COLUMN `sic_code` SET TAGS ('pii_business_glossary_term' = 'Standard Industrial Classification (SIC) Code');
ALTER TABLE `vibe_construction_v1`.`bid`.`firm_profile` ALTER COLUMN `sic_code` SET TAGS ('pii_value_regex' = '^[0-9]{4}$');
ALTER TABLE `vibe_construction_v1`.`bid`.`firm_profile` ALTER COLUMN `single_project_bond_limit_usd` SET TAGS ('pii_business_glossary_term' = 'Single Project Bond Limit (USD)');
ALTER TABLE `vibe_construction_v1`.`bid`.`firm_profile` ALTER COLUMN `single_project_bond_limit_usd` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`bid`.`firm_profile` ALTER COLUMN `state_of_incorporation` SET TAGS ('pii_business_glossary_term' = 'State of Incorporation');
ALTER TABLE `vibe_construction_v1`.`bid`.`firm_profile` ALTER COLUMN `state_of_incorporation` SET TAGS ('pii_value_regex' = '^[A-Z]{2}$');
ALTER TABLE `vibe_construction_v1`.`bid`.`firm_profile` ALTER COLUMN `tax_identification_number` SET TAGS ('pii_business_glossary_term' = 'Tax Identification Number (EIN/ABN/TIN)');
ALTER TABLE `vibe_construction_v1`.`bid`.`firm_profile` ALTER COLUMN `tax_identification_number` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`bid`.`firm_profile` ALTER COLUMN `tax_identification_number` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_construction_v1`.`bid`.`firm_profile` ALTER COLUMN `trading_name` SET TAGS ('pii_business_glossary_term' = 'Trading Name (DBA)');
ALTER TABLE `vibe_construction_v1`.`bid`.`firm_profile` ALTER COLUMN `trir` SET TAGS ('pii_business_glossary_term' = 'Total Recordable Incident Rate (TRIR)');
ALTER TABLE `vibe_construction_v1`.`bid`.`firm_profile` ALTER COLUMN `trir` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`bid`.`firm_profile` ALTER COLUMN `union_affiliation` SET TAGS ('pii_business_glossary_term' = 'Union Affiliation');
ALTER TABLE `vibe_construction_v1`.`bid`.`firm_profile` ALTER COLUMN `wbe_certified` SET TAGS ('pii_business_glossary_term' = 'Women-Owned Business Enterprise (WBE) Certified');
ALTER TABLE `vibe_construction_v1`.`bid`.`firm_profile` ALTER COLUMN `years_in_business` SET TAGS ('pii_business_glossary_term' = 'Years in Business');
ALTER TABLE `vibe_construction_v1`.`bid`.`subcontractor_prequalification` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_construction_v1`.`bid`.`subcontractor_prequalification` SET TAGS ('pii_subdomain' = 'partner_qualification');
ALTER TABLE `vibe_construction_v1`.`bid`.`subcontractor_prequalification` SET TAGS ('pii_required_structure' = 'v2');
ALTER TABLE `vibe_construction_v1`.`bid`.`subcontractor_prequalification` SET TAGS ('pii_ecm_structure' = 'preserved_v2');
ALTER TABLE `vibe_construction_v1`.`bid`.`subcontractor_prequalification` SET TAGS ('pii_structure_required' = 'true');
ALTER TABLE `vibe_construction_v1`.`bid`.`subcontractor_prequalification` ALTER COLUMN `subcontractor_prequalification_id` SET TAGS ('pii_business_glossary_term' = 'Subcontractor Prequalification ID');
ALTER TABLE `vibe_construction_v1`.`bid`.`subcontractor_prequalification` ALTER COLUMN `construction_project_id` SET TAGS ('pii_business_glossary_term' = 'Project Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`bid`.`subcontractor_prequalification` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_business_glossary_term' = 'Evaluating Officer ID');
ALTER TABLE `vibe_construction_v1`.`bid`.`subcontractor_prequalification` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`bid`.`subcontractor_prequalification` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_construction_v1`.`bid`.`subcontractor_prequalification` ALTER COLUMN `approval_date` SET TAGS ('pii_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_construction_v1`.`bid`.`subcontractor_prequalification` ALTER COLUMN `bonding_limit_amount` SET TAGS ('pii_business_glossary_term' = 'Bonding Limit Amount');
ALTER TABLE `vibe_construction_v1`.`bid`.`subcontractor_prequalification` ALTER COLUMN `bonding_limit_amount` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`bid`.`subcontractor_prequalification` ALTER COLUMN `bonding_limit_currency` SET TAGS ('pii_business_glossary_term' = 'Bonding Limit Currency');
ALTER TABLE `vibe_construction_v1`.`bid`.`subcontractor_prequalification` ALTER COLUMN `bonding_limit_currency` SET TAGS ('pii_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_construction_v1`.`bid`.`subcontractor_prequalification` ALTER COLUMN `certification_requirements_met` SET TAGS ('pii_business_glossary_term' = 'Certification Requirements Met');
ALTER TABLE `vibe_construction_v1`.`bid`.`subcontractor_prequalification` ALTER COLUMN `conditional_approval_requirements` SET TAGS ('pii_business_glossary_term' = 'Conditional Approval Requirements');
ALTER TABLE `vibe_construction_v1`.`bid`.`subcontractor_prequalification` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_construction_v1`.`bid`.`subcontractor_prequalification` ALTER COLUMN `effective_date` SET TAGS ('pii_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_construction_v1`.`bid`.`subcontractor_prequalification` ALTER COLUMN `eligible_project_types` SET TAGS ('pii_business_glossary_term' = 'Eligible Project Types');
ALTER TABLE `vibe_construction_v1`.`bid`.`subcontractor_prequalification` ALTER COLUMN `evaluation_date` SET TAGS ('pii_business_glossary_term' = 'Evaluation Date');
ALTER TABLE `vibe_construction_v1`.`bid`.`subcontractor_prequalification` ALTER COLUMN `evaluation_notes` SET TAGS ('pii_business_glossary_term' = 'Evaluation Notes');
ALTER TABLE `vibe_construction_v1`.`bid`.`subcontractor_prequalification` ALTER COLUMN `expiry_date` SET TAGS ('pii_business_glossary_term' = 'Expiry Date');
ALTER TABLE `vibe_construction_v1`.`bid`.`subcontractor_prequalification` ALTER COLUMN `financial_capacity_score` SET TAGS ('pii_business_glossary_term' = 'Financial Capacity Score');
ALTER TABLE `vibe_construction_v1`.`bid`.`subcontractor_prequalification` ALTER COLUMN `financial_statements_verified` SET TAGS ('pii_business_glossary_term' = 'Financial Statements Verified');
ALTER TABLE `vibe_construction_v1`.`bid`.`subcontractor_prequalification` ALTER COLUMN `firm_profile_id` SET TAGS ('pii_business_glossary_term' = 'Subcontractor ID');
ALTER TABLE `vibe_construction_v1`.`bid`.`subcontractor_prequalification` ALTER COLUMN `geographic_scope` SET TAGS ('pii_business_glossary_term' = 'Geographic Scope');
ALTER TABLE `vibe_construction_v1`.`bid`.`subcontractor_prequalification` ALTER COLUMN `insurance_adequacy_score` SET TAGS ('pii_business_glossary_term' = 'Insurance Adequacy Score');
ALTER TABLE `vibe_construction_v1`.`bid`.`subcontractor_prequalification` ALTER COLUMN `last_updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `vibe_construction_v1`.`bid`.`subcontractor_prequalification` ALTER COLUMN `maximum_contract_currency` SET TAGS ('pii_business_glossary_term' = 'Maximum Contract Currency');
ALTER TABLE `vibe_construction_v1`.`bid`.`subcontractor_prequalification` ALTER COLUMN `maximum_contract_currency` SET TAGS ('pii_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_construction_v1`.`bid`.`subcontractor_prequalification` ALTER COLUMN `maximum_contract_value` SET TAGS ('pii_business_glossary_term' = 'Maximum Contract Value');
ALTER TABLE `vibe_construction_v1`.`bid`.`subcontractor_prequalification` ALTER COLUMN `maximum_contract_value` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`bid`.`subcontractor_prequalification` ALTER COLUMN `minimum_passing_score` SET TAGS ('pii_business_glossary_term' = 'Minimum Passing Score');
ALTER TABLE `vibe_construction_v1`.`bid`.`subcontractor_prequalification` ALTER COLUMN `overall_score` SET TAGS ('pii_business_glossary_term' = 'Overall Prequalification Score');
ALTER TABLE `vibe_construction_v1`.`bid`.`subcontractor_prequalification` ALTER COLUMN `past_performance_score` SET TAGS ('pii_business_glossary_term' = 'Past Performance Score');
ALTER TABLE `vibe_construction_v1`.`bid`.`subcontractor_prequalification` ALTER COLUMN `prequalification_number` SET TAGS ('pii_business_glossary_term' = 'Prequalification Number');
ALTER TABLE `vibe_construction_v1`.`bid`.`subcontractor_prequalification` ALTER COLUMN `prequalification_status` SET TAGS ('pii_business_glossary_term' = 'Prequalification Status');
ALTER TABLE `vibe_construction_v1`.`bid`.`subcontractor_prequalification` ALTER COLUMN `prequalification_status` SET TAGS ('pii_value_regex' = 'approved|conditional|rejected|expired|under_review|pending_documents');
ALTER TABLE `vibe_construction_v1`.`bid`.`subcontractor_prequalification` ALTER COLUMN `reference_check_completed` SET TAGS ('pii_business_glossary_term' = 'Reference Check Completed');
ALTER TABLE `vibe_construction_v1`.`bid`.`subcontractor_prequalification` ALTER COLUMN `rejection_reason` SET TAGS ('pii_business_glossary_term' = 'Rejection Reason');
ALTER TABLE `vibe_construction_v1`.`bid`.`subcontractor_prequalification` ALTER COLUMN `requalification_trigger` SET TAGS ('pii_business_glossary_term' = 'Requalification Trigger');
ALTER TABLE `vibe_construction_v1`.`bid`.`subcontractor_prequalification` ALTER COLUMN `safety_record_score` SET TAGS ('pii_business_glossary_term' = 'Safety Record Score');
ALTER TABLE `vibe_construction_v1`.`bid`.`subcontractor_prequalification` ALTER COLUMN `submission_date` SET TAGS ('pii_business_glossary_term' = 'Submission Date');
ALTER TABLE `vibe_construction_v1`.`bid`.`subcontractor_prequalification` ALTER COLUMN `technical_capability_score` SET TAGS ('pii_business_glossary_term' = 'Technical Capability Score');
ALTER TABLE `vibe_construction_v1`.`bid`.`subcontractor_prequalification` ALTER COLUMN `trade_category` SET TAGS ('pii_business_glossary_term' = 'Trade Category');
ALTER TABLE `vibe_construction_v1`.`bid`.`trade_package` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_construction_v1`.`bid`.`trade_package` SET TAGS ('pii_subdomain' = 'tender_preparation');
ALTER TABLE `vibe_construction_v1`.`bid`.`trade_package` SET TAGS ('pii_required_structure' = 'v2');
ALTER TABLE `vibe_construction_v1`.`bid`.`trade_package` SET TAGS ('pii_ecm_structure' = 'preserved_v2');
ALTER TABLE `vibe_construction_v1`.`bid`.`trade_package` SET TAGS ('pii_structure_required' = 'true');
ALTER TABLE `vibe_construction_v1`.`bid`.`trade_package` ALTER COLUMN `trade_package_id` SET TAGS ('pii_business_glossary_term' = 'Trade Package ID');
ALTER TABLE `vibe_construction_v1`.`bid`.`trade_package` ALTER COLUMN `construction_project_id` SET TAGS ('pii_business_glossary_term' = 'Construction Project ID');
ALTER TABLE `vibe_construction_v1`.`bid`.`trade_package` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_business_glossary_term' = 'Responsible Project Manager ID');
ALTER TABLE `vibe_construction_v1`.`bid`.`trade_package` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`bid`.`trade_package` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_construction_v1`.`bid`.`trade_package` ALTER COLUMN `firm_profile_id` SET TAGS ('pii_business_glossary_term' = 'Awarded Subcontractor ID');
ALTER TABLE `vibe_construction_v1`.`bid`.`trade_package` ALTER COLUMN `green_certification_id` SET TAGS ('pii_business_glossary_term' = 'Green Certification Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`bid`.`trade_package` ALTER COLUMN `project_budget_id` SET TAGS ('pii_business_glossary_term' = 'Project Budget Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`bid`.`trade_package` ALTER COLUMN `wbs_element_id` SET TAGS ('pii_business_glossary_term' = 'Work Breakdown Structure (WBS) Element ID');
ALTER TABLE `vibe_construction_v1`.`bid`.`trade_package` ALTER COLUMN `actual_completion_date` SET TAGS ('pii_business_glossary_term' = 'Actual Completion Date');
ALTER TABLE `vibe_construction_v1`.`bid`.`trade_package` ALTER COLUMN `actual_start_date` SET TAGS ('pii_business_glossary_term' = 'Actual Start Date');
ALTER TABLE `vibe_construction_v1`.`bid`.`trade_package` ALTER COLUMN `award_date` SET TAGS ('pii_business_glossary_term' = 'Award Date');
ALTER TABLE `vibe_construction_v1`.`bid`.`trade_package` ALTER COLUMN `awarded_value` SET TAGS ('pii_business_glossary_term' = 'Awarded Value');
ALTER TABLE `vibe_construction_v1`.`bid`.`trade_package` ALTER COLUMN `bid_closing_date` SET TAGS ('pii_business_glossary_term' = 'Bid Closing Date');
ALTER TABLE `vibe_construction_v1`.`bid`.`trade_package` ALTER COLUMN `bid_out_date` SET TAGS ('pii_business_glossary_term' = 'Bid Out Date');
ALTER TABLE `vibe_construction_v1`.`bid`.`trade_package` ALTER COLUMN `bonding_required` SET TAGS ('pii_business_glossary_term' = 'Bonding Required Flag');
ALTER TABLE `vibe_construction_v1`.`bid`.`trade_package` ALTER COLUMN `budget_allowance` SET TAGS ('pii_business_glossary_term' = 'Budget Allowance');
ALTER TABLE `vibe_construction_v1`.`bid`.`trade_package` ALTER COLUMN `contract_type` SET TAGS ('pii_business_glossary_term' = 'Contract Type');
ALTER TABLE `vibe_construction_v1`.`bid`.`trade_package` ALTER COLUMN `contract_type` SET TAGS ('pii_value_regex' = 'lump_sum|unit_price|cost_plus|gmp|time_and_materials');
ALTER TABLE `vibe_construction_v1`.`bid`.`trade_package` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_construction_v1`.`bid`.`trade_package` ALTER COLUMN `csi_masterformat_code` SET TAGS ('pii_business_glossary_term' = 'Construction Specifications Institute (CSI) MasterFormat Code');
ALTER TABLE `vibe_construction_v1`.`bid`.`trade_package` ALTER COLUMN `csi_masterformat_code` SET TAGS ('pii_value_regex' = '^[0-9]{2}s[0-9]{2}s[0-9]{2}(.[0-9]{2})?$');
ALTER TABLE `vibe_construction_v1`.`bid`.`trade_package` ALTER COLUMN `currency_code` SET TAGS ('pii_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_construction_v1`.`bid`.`trade_package` ALTER COLUMN `currency_code` SET TAGS ('pii_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_construction_v1`.`bid`.`trade_package` ALTER COLUMN `duration_days` SET TAGS ('pii_business_glossary_term' = 'Duration in Days');
ALTER TABLE `vibe_construction_v1`.`bid`.`trade_package` ALTER COLUMN `estimated_value` SET TAGS ('pii_business_glossary_term' = 'Estimated Package Value');
ALTER TABLE `vibe_construction_v1`.`bid`.`trade_package` ALTER COLUMN `insurance_requirements` SET TAGS ('pii_business_glossary_term' = 'Insurance Requirements');
ALTER TABLE `vibe_construction_v1`.`bid`.`trade_package` ALTER COLUMN `last_modified_timestamp` SET TAGS ('pii_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_construction_v1`.`bid`.`trade_package` ALTER COLUMN `liquidated_damages_rate` SET TAGS ('pii_business_glossary_term' = 'Liquidated Damages (LD) Rate');
ALTER TABLE `vibe_construction_v1`.`bid`.`trade_package` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_construction_v1`.`bid`.`trade_package` ALTER COLUMN `number_of_bidders_invited` SET TAGS ('pii_business_glossary_term' = 'Number of Bidders Invited');
ALTER TABLE `vibe_construction_v1`.`bid`.`trade_package` ALTER COLUMN `number_of_bids_received` SET TAGS ('pii_business_glossary_term' = 'Number of Bids Received');
ALTER TABLE `vibe_construction_v1`.`bid`.`trade_package` ALTER COLUMN `package_name` SET TAGS ('pii_business_glossary_term' = 'Trade Package Name');
ALTER TABLE `vibe_construction_v1`.`bid`.`trade_package` ALTER COLUMN `package_priority` SET TAGS ('pii_business_glossary_term' = 'Package Priority');
ALTER TABLE `vibe_construction_v1`.`bid`.`trade_package` ALTER COLUMN `package_priority` SET TAGS ('pii_value_regex' = 'critical|high|medium|low');
ALTER TABLE `vibe_construction_v1`.`bid`.`trade_package` ALTER COLUMN `package_reference_number` SET TAGS ('pii_business_glossary_term' = 'Package Reference Number');
ALTER TABLE `vibe_construction_v1`.`bid`.`trade_package` ALTER COLUMN `package_reference_number` SET TAGS ('pii_value_regex' = '^[A-Z0-9-]{6,20}$');
ALTER TABLE `vibe_construction_v1`.`bid`.`trade_package` ALTER COLUMN `package_status` SET TAGS ('pii_business_glossary_term' = 'Package Status');
ALTER TABLE `vibe_construction_v1`.`bid`.`trade_package` ALTER COLUMN `package_status` SET TAGS ('pii_value_regex' = 'draft|bid_out|evaluation|awarded|closed|cancelled');
ALTER TABLE `vibe_construction_v1`.`bid`.`trade_package` ALTER COLUMN `payment_terms_days` SET TAGS ('pii_business_glossary_term' = 'Payment Terms in Days');
ALTER TABLE `vibe_construction_v1`.`bid`.`trade_package` ALTER COLUMN `planned_completion_date` SET TAGS ('pii_business_glossary_term' = 'Planned Completion Date');
ALTER TABLE `vibe_construction_v1`.`bid`.`trade_package` ALTER COLUMN `planned_start_date` SET TAGS ('pii_business_glossary_term' = 'Planned Start Date');
ALTER TABLE `vibe_construction_v1`.`bid`.`trade_package` ALTER COLUMN `prequalification_required` SET TAGS ('pii_business_glossary_term' = 'Prequalification Required Flag');
ALTER TABLE `vibe_construction_v1`.`bid`.`trade_package` ALTER COLUMN `procurement_method` SET TAGS ('pii_business_glossary_term' = 'Procurement Method');
ALTER TABLE `vibe_construction_v1`.`bid`.`trade_package` ALTER COLUMN `procurement_method` SET TAGS ('pii_value_regex' = 'open_tender|selective_tender|negotiated|single_source|framework');
ALTER TABLE `vibe_construction_v1`.`bid`.`trade_package` ALTER COLUMN `retention_percentage` SET TAGS ('pii_business_glossary_term' = 'Retention Percentage');
ALTER TABLE `vibe_construction_v1`.`bid`.`trade_package` ALTER COLUMN `risk_level` SET TAGS ('pii_business_glossary_term' = 'Risk Level');
ALTER TABLE `vibe_construction_v1`.`bid`.`trade_package` ALTER COLUMN `risk_level` SET TAGS ('pii_value_regex' = 'high|medium|low');
ALTER TABLE `vibe_construction_v1`.`bid`.`trade_package` ALTER COLUMN `scope_narrative` SET TAGS ('pii_business_glossary_term' = 'Scope of Work Narrative');
ALTER TABLE `vibe_construction_v1`.`bid`.`trade_package` ALTER COLUMN `trade_discipline_code` SET TAGS ('pii_business_glossary_term' = 'Trade Discipline Code');
ALTER TABLE `vibe_construction_v1`.`bid`.`trade_package` ALTER COLUMN `trade_discipline_code` SET TAGS ('pii_value_regex' = '^[A-Z]{2,6}$');
ALTER TABLE `vibe_construction_v1`.`bid`.`trade_package` ALTER COLUMN `uniformat_code` SET TAGS ('pii_business_glossary_term' = 'UniFormat Code');
ALTER TABLE `vibe_construction_v1`.`bid`.`trade_package` ALTER COLUMN `uniformat_code` SET TAGS ('pii_value_regex' = '^[A-Z][0-9]{2}[0-9]{2}$');
ALTER TABLE `vibe_construction_v1`.`bid`.`trade_package` ALTER COLUMN `warranty_period_months` SET TAGS ('pii_business_glossary_term' = 'Warranty Period in Months');
ALTER TABLE `vibe_construction_v1`.`bid`.`bid_contract_agreement` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_construction_v1`.`bid`.`bid_contract_agreement` SET TAGS ('pii_subdomain' = 'tender_preparation');
ALTER TABLE `vibe_construction_v1`.`bid`.`bid_contract_agreement` SET TAGS ('pii_required_structure' = 'v2');
ALTER TABLE `vibe_construction_v1`.`bid`.`bid_contract_agreement` SET TAGS ('pii_ecm_structure' = 'preserved_v2');
ALTER TABLE `vibe_construction_v1`.`bid`.`bid_contract_agreement` SET TAGS ('pii_ecm_reviewed' = 'true');
ALTER TABLE `vibe_construction_v1`.`bid`.`bid_contract_agreement` SET TAGS ('pii_source' = 'vibe-batch');
ALTER TABLE `vibe_construction_v1`.`bid`.`bid_contract_agreement` SET TAGS ('pii_structure_required' = 'true');
ALTER TABLE `vibe_construction_v1`.`bid`.`bid_contract_agreement` ALTER COLUMN `bid_contract_agreement_id` SET TAGS ('pii_business_glossary_term' = 'Contract Agreement Identifier');
ALTER TABLE `vibe_construction_v1`.`bid`.`bid_contract_agreement` ALTER COLUMN `construction_project_id` SET TAGS ('pii_business_glossary_term' = 'Construction Project ID');
ALTER TABLE `vibe_construction_v1`.`bid`.`bid_contract_agreement` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_business_glossary_term' = 'Contract Manager Employee Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`bid`.`bid_contract_agreement` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`bid`.`bid_contract_agreement` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_construction_v1`.`bid`.`bid_contract_agreement` ALTER COLUMN `firm_profile_id` SET TAGS ('pii_business_glossary_term' = 'Subcontractor ID');
ALTER TABLE `vibe_construction_v1`.`bid`.`bid_contract_agreement` ALTER COLUMN `gl_account_id` SET TAGS ('pii_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`bid`.`bid_contract_agreement` ALTER COLUMN `sustainability_plan_id` SET TAGS ('pii_business_glossary_term' = 'Sustainability Plan Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`bid`.`bid_contract_agreement` ALTER COLUMN `actual_completion_date` SET TAGS ('pii_business_glossary_term' = 'Actual Completion Date');
ALTER TABLE `vibe_construction_v1`.`bid`.`bid_contract_agreement` ALTER COLUMN `advance_payment_percentage` SET TAGS ('pii_business_glossary_term' = 'Advance Payment Percentage');
ALTER TABLE `vibe_construction_v1`.`bid`.`bid_contract_agreement` ALTER COLUMN `contract_currency_code` SET TAGS ('pii_business_glossary_term' = 'Contract Currency Code');
ALTER TABLE `vibe_construction_v1`.`bid`.`bid_contract_agreement` ALTER COLUMN `contract_currency_code` SET TAGS ('pii_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_construction_v1`.`bid`.`bid_contract_agreement` ALTER COLUMN `contract_expiry_date` SET TAGS ('pii_business_glossary_term' = 'Contract Expiry Date');
ALTER TABLE `vibe_construction_v1`.`bid`.`bid_contract_agreement` ALTER COLUMN `contract_name` SET TAGS ('pii_business_glossary_term' = 'Subcontract Name');
ALTER TABLE `vibe_construction_v1`.`bid`.`bid_contract_agreement` ALTER COLUMN `contract_number` SET TAGS ('pii_business_glossary_term' = 'Subcontract Number');
ALTER TABLE `vibe_construction_v1`.`bid`.`bid_contract_agreement` ALTER COLUMN `contract_signed_date` SET TAGS ('pii_business_glossary_term' = 'Contract Signed Date');
ALTER TABLE `vibe_construction_v1`.`bid`.`bid_contract_agreement` ALTER COLUMN `contract_status` SET TAGS ('pii_business_glossary_term' = 'Contract Status');
ALTER TABLE `vibe_construction_v1`.`bid`.`bid_contract_agreement` ALTER COLUMN `contract_type` SET TAGS ('pii_business_glossary_term' = 'Contract Type');
ALTER TABLE `vibe_construction_v1`.`bid`.`bid_contract_agreement` ALTER COLUMN `contract_type` SET TAGS ('pii_value_regex' = 'lump_sum|unit_rate|cost_plus|gmp|time_and_materials|design_build');
ALTER TABLE `vibe_construction_v1`.`bid`.`bid_contract_agreement` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_construction_v1`.`bid`.`bid_contract_agreement` ALTER COLUMN `current_contract_value` SET TAGS ('pii_business_glossary_term' = 'Current Contract Value');
ALTER TABLE `vibe_construction_v1`.`bid`.`bid_contract_agreement` ALTER COLUMN `dispute_resolution_method` SET TAGS ('pii_business_glossary_term' = 'Dispute Resolution Method');
ALTER TABLE `vibe_construction_v1`.`bid`.`bid_contract_agreement` ALTER COLUMN `dispute_resolution_method` SET TAGS ('pii_value_regex' = 'negotiation|mediation|arbitration|litigation|dab');
ALTER TABLE `vibe_construction_v1`.`bid`.`bid_contract_agreement` ALTER COLUMN `dlp_duration_days` SET TAGS ('pii_business_glossary_term' = 'Defects Liability Period (DLP) Duration (Days)');
ALTER TABLE `vibe_construction_v1`.`bid`.`bid_contract_agreement` ALTER COLUMN `dlp_end_date` SET TAGS ('pii_business_glossary_term' = 'Defects Liability Period (DLP) End Date');
ALTER TABLE `vibe_construction_v1`.`bid`.`bid_contract_agreement` ALTER COLUMN `executed_contract_value` SET TAGS ('pii_business_glossary_term' = 'Executed Contract Value');
ALTER TABLE `vibe_construction_v1`.`bid`.`bid_contract_agreement` ALTER COLUMN `fidic_conditions_reference` SET TAGS ('pii_business_glossary_term' = 'FIDIC (International Federation of Consulting Engineers) Conditions Reference');
ALTER TABLE `vibe_construction_v1`.`bid`.`bid_contract_agreement` ALTER COLUMN `governing_law_jurisdiction` SET TAGS ('pii_business_glossary_term' = 'Governing Law Jurisdiction');
ALTER TABLE `vibe_construction_v1`.`bid`.`bid_contract_agreement` ALTER COLUMN `insurance_required_flag` SET TAGS ('pii_business_glossary_term' = 'Insurance Required Flag');
ALTER TABLE `vibe_construction_v1`.`bid`.`bid_contract_agreement` ALTER COLUMN `last_modified_timestamp` SET TAGS ('pii_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_construction_v1`.`bid`.`bid_contract_agreement` ALTER COLUMN `ld_cap_percentage` SET TAGS ('pii_business_glossary_term' = 'Liquidated Damages (LD) Cap Percentage');
ALTER TABLE `vibe_construction_v1`.`bid`.`bid_contract_agreement` ALTER COLUMN `ld_cap_percentage` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`bid`.`bid_contract_agreement` ALTER COLUMN `ld_rate_per_day` SET TAGS ('pii_business_glossary_term' = 'Liquidated Damages (LD) Rate per Day');
ALTER TABLE `vibe_construction_v1`.`bid`.`bid_contract_agreement` ALTER COLUMN `ld_rate_per_day` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`bid`.`bid_contract_agreement` ALTER COLUMN `ntp_date` SET TAGS ('pii_business_glossary_term' = 'Notice to Proceed (NTP) Date');
ALTER TABLE `vibe_construction_v1`.`bid`.`bid_contract_agreement` ALTER COLUMN `payment_application_frequency` SET TAGS ('pii_business_glossary_term' = 'Payment Application Frequency');
ALTER TABLE `vibe_construction_v1`.`bid`.`bid_contract_agreement` ALTER COLUMN `payment_application_frequency` SET TAGS ('pii_value_regex' = 'monthly|bi_weekly|milestone_based|completion_based');
ALTER TABLE `vibe_construction_v1`.`bid`.`bid_contract_agreement` ALTER COLUMN `payment_terms_days` SET TAGS ('pii_business_glossary_term' = 'Payment Terms (Days)');
ALTER TABLE `vibe_construction_v1`.`bid`.`bid_contract_agreement` ALTER COLUMN `performance_bond_percentage` SET TAGS ('pii_business_glossary_term' = 'Performance Bond Percentage');
ALTER TABLE `vibe_construction_v1`.`bid`.`bid_contract_agreement` ALTER COLUMN `performance_bond_required_flag` SET TAGS ('pii_business_glossary_term' = 'Performance Bond Required Flag');
ALTER TABLE `vibe_construction_v1`.`bid`.`bid_contract_agreement` ALTER COLUMN `planned_completion_date` SET TAGS ('pii_business_glossary_term' = 'Planned Completion Date');
ALTER TABLE `vibe_construction_v1`.`bid`.`bid_contract_agreement` ALTER COLUMN `planned_start_date` SET TAGS ('pii_business_glossary_term' = 'Planned Start Date');
ALTER TABLE `vibe_construction_v1`.`bid`.`bid_contract_agreement` ALTER COLUMN `remarks` SET TAGS ('pii_business_glossary_term' = 'Remarks');
ALTER TABLE `vibe_construction_v1`.`bid`.`bid_contract_agreement` ALTER COLUMN `retention_percentage` SET TAGS ('pii_business_glossary_term' = 'Retention Percentage');
ALTER TABLE `vibe_construction_v1`.`bid`.`bid_contract_agreement` ALTER COLUMN `scope_of_work_description` SET TAGS ('pii_business_glossary_term' = 'Scope of Work (SOW) Description');
ALTER TABLE `vibe_construction_v1`.`bid`.`bid_contract_agreement` ALTER COLUMN `subcontractor_representative_name` SET TAGS ('pii_business_glossary_term' = 'Subcontractor Representative Name');
ALTER TABLE `vibe_construction_v1`.`bid`.`bid_contract_agreement` ALTER COLUMN `termination_date` SET TAGS ('pii_business_glossary_term' = 'Termination Date');
ALTER TABLE `vibe_construction_v1`.`bid`.`bid_contract_agreement` ALTER COLUMN `termination_reason` SET TAGS ('pii_business_glossary_term' = 'Termination Reason');
ALTER TABLE `vibe_construction_v1`.`bid`.`bid_contract_agreement` ALTER COLUMN `trade_package_code` SET TAGS ('pii_business_glossary_term' = 'Trade Package Code');
ALTER TABLE `vibe_construction_v1`.`bid`.`bid_payment_application` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_construction_v1`.`bid`.`bid_payment_application` SET TAGS ('pii_subdomain' = 'payment_processing');
ALTER TABLE `vibe_construction_v1`.`bid`.`bid_payment_application` SET TAGS ('pii_required_structure' = 'v2');
ALTER TABLE `vibe_construction_v1`.`bid`.`bid_payment_application` SET TAGS ('pii_ecm_structure' = 'preserved_v2');
ALTER TABLE `vibe_construction_v1`.`bid`.`bid_payment_application` SET TAGS ('pii_structure_required' = 'true');
ALTER TABLE `vibe_construction_v1`.`bid`.`bid_payment_application` ALTER COLUMN `bid_payment_application_id` SET TAGS ('pii_business_glossary_term' = 'Payment Application ID');
ALTER TABLE `vibe_construction_v1`.`bid`.`bid_payment_application` ALTER COLUMN `construction_project_id` SET TAGS ('pii_business_glossary_term' = 'Construction Project ID');
ALTER TABLE `vibe_construction_v1`.`bid`.`bid_payment_application` ALTER COLUMN `bid_contract_agreement_id` SET TAGS ('pii_business_glossary_term' = 'Contract ID');
ALTER TABLE `vibe_construction_v1`.`bid`.`bid_payment_application` ALTER COLUMN `cost_center_id` SET TAGS ('pii_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`bid`.`bid_payment_application` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_business_glossary_term' = 'Certifying Engineer ID');
ALTER TABLE `vibe_construction_v1`.`bid`.`bid_payment_application` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`bid`.`bid_payment_application` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_construction_v1`.`bid`.`bid_payment_application` ALTER COLUMN `firm_profile_id` SET TAGS ('pii_business_glossary_term' = 'Subcontractor ID');
ALTER TABLE `vibe_construction_v1`.`bid`.`bid_payment_application` ALTER COLUMN `gl_account_id` SET TAGS ('pii_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`bid`.`bid_payment_application` ALTER COLUMN `project_budget_id` SET TAGS ('pii_business_glossary_term' = 'Project Budget Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`bid`.`bid_payment_application` ALTER COLUMN `amount_certified_current` SET TAGS ('pii_business_glossary_term' = 'Amount Certified Current Period');
ALTER TABLE `vibe_construction_v1`.`bid`.`bid_payment_application` ALTER COLUMN `amount_claimed_current` SET TAGS ('pii_business_glossary_term' = 'Amount Claimed Current Period');
ALTER TABLE `vibe_construction_v1`.`bid`.`bid_payment_application` ALTER COLUMN `amount_previously_certified` SET TAGS ('pii_business_glossary_term' = 'Amount Previously Certified');
ALTER TABLE `vibe_construction_v1`.`bid`.`bid_payment_application` ALTER COLUMN `application_number` SET TAGS ('pii_business_glossary_term' = 'Application Number');
ALTER TABLE `vibe_construction_v1`.`bid`.`bid_payment_application` ALTER COLUMN `application_status` SET TAGS ('pii_business_glossary_term' = 'Application Status');
ALTER TABLE `vibe_construction_v1`.`bid`.`bid_payment_application` ALTER COLUMN `back_charges_applied` SET TAGS ('pii_business_glossary_term' = 'Back-Charges Applied');
ALTER TABLE `vibe_construction_v1`.`bid`.`bid_payment_application` ALTER COLUMN `billing_period_end_date` SET TAGS ('pii_business_glossary_term' = 'Billing Period End Date');
ALTER TABLE `vibe_construction_v1`.`bid`.`bid_payment_application` ALTER COLUMN `billing_period_start_date` SET TAGS ('pii_business_glossary_term' = 'Billing Period Start Date');
ALTER TABLE `vibe_construction_v1`.`bid`.`bid_payment_application` ALTER COLUMN `certification_date` SET TAGS ('pii_business_glossary_term' = 'Certification Date');
ALTER TABLE `vibe_construction_v1`.`bid`.`bid_payment_application` ALTER COLUMN `contract_value_original` SET TAGS ('pii_business_glossary_term' = 'Original Contract Value');
ALTER TABLE `vibe_construction_v1`.`bid`.`bid_payment_application` ALTER COLUMN `contract_value_revised` SET TAGS ('pii_business_glossary_term' = 'Revised Contract Value');
ALTER TABLE `vibe_construction_v1`.`bid`.`bid_payment_application` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_construction_v1`.`bid`.`bid_payment_application` ALTER COLUMN `currency_code` SET TAGS ('pii_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_construction_v1`.`bid`.`bid_payment_application` ALTER COLUMN `currency_code` SET TAGS ('pii_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_construction_v1`.`bid`.`bid_payment_application` ALTER COLUMN `dispute_flag` SET TAGS ('pii_business_glossary_term' = 'Dispute Flag');
ALTER TABLE `vibe_construction_v1`.`bid`.`bid_payment_application` ALTER COLUMN `dispute_reason` SET TAGS ('pii_business_glossary_term' = 'Dispute Reason');
ALTER TABLE `vibe_construction_v1`.`bid`.`bid_payment_application` ALTER COLUMN `last_modified_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `vibe_construction_v1`.`bid`.`bid_payment_application` ALTER COLUMN `lien_waiver_received` SET TAGS ('pii_business_glossary_term' = 'Lien Waiver Received');
ALTER TABLE `vibe_construction_v1`.`bid`.`bid_payment_application` ALTER COLUMN `liquidated_damages_deducted` SET TAGS ('pii_business_glossary_term' = 'Liquidated Damages (LD) Deducted');
ALTER TABLE `vibe_construction_v1`.`bid`.`bid_payment_application` ALTER COLUMN `materials_stored_to_date` SET TAGS ('pii_business_glossary_term' = 'Materials Stored to Date');
ALTER TABLE `vibe_construction_v1`.`bid`.`bid_payment_application` ALTER COLUMN `net_amount_due` SET TAGS ('pii_business_glossary_term' = 'Net Amount Due');
ALTER TABLE `vibe_construction_v1`.`bid`.`bid_payment_application` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Application Notes');
ALTER TABLE `vibe_construction_v1`.`bid`.`bid_payment_application` ALTER COLUMN `other_deductions` SET TAGS ('pii_business_glossary_term' = 'Other Deductions');
ALTER TABLE `vibe_construction_v1`.`bid`.`bid_payment_application` ALTER COLUMN `payment_date` SET TAGS ('pii_business_glossary_term' = 'Payment Date');
ALTER TABLE `vibe_construction_v1`.`bid`.`bid_payment_application` ALTER COLUMN `payment_due_date` SET TAGS ('pii_business_glossary_term' = 'Payment Due Date');
ALTER TABLE `vibe_construction_v1`.`bid`.`bid_payment_application` ALTER COLUMN `payment_reference_number` SET TAGS ('pii_business_glossary_term' = 'Payment Reference Number');
ALTER TABLE `vibe_construction_v1`.`bid`.`bid_payment_application` ALTER COLUMN `payment_type` SET TAGS ('pii_business_glossary_term' = 'Payment Type');
ALTER TABLE `vibe_construction_v1`.`bid`.`bid_payment_application` ALTER COLUMN `payment_type` SET TAGS ('pii_value_regex' = 'progress|retention_release|final|mobilization|material_on_site');
ALTER TABLE `vibe_construction_v1`.`bid`.`bid_payment_application` ALTER COLUMN `percent_complete_certified` SET TAGS ('pii_business_glossary_term' = 'Percent Complete Certified');
ALTER TABLE `vibe_construction_v1`.`bid`.`bid_payment_application` ALTER COLUMN `percent_complete_claimed` SET TAGS ('pii_business_glossary_term' = 'Percent Complete Claimed');
ALTER TABLE `vibe_construction_v1`.`bid`.`bid_payment_application` ALTER COLUMN `retention_percentage` SET TAGS ('pii_business_glossary_term' = 'Retention Percentage');
ALTER TABLE `vibe_construction_v1`.`bid`.`bid_payment_application` ALTER COLUMN `retention_release_milestone` SET TAGS ('pii_business_glossary_term' = 'Retention Release Milestone');
ALTER TABLE `vibe_construction_v1`.`bid`.`bid_payment_application` ALTER COLUMN `retention_release_milestone` SET TAGS ('pii_value_regex' = 'practical_completion|dlp_expiry|final_completion|partial_release|none');
ALTER TABLE `vibe_construction_v1`.`bid`.`bid_payment_application` ALTER COLUMN `retention_released_current` SET TAGS ('pii_business_glossary_term' = 'Retention Released Current Period');
ALTER TABLE `vibe_construction_v1`.`bid`.`bid_payment_application` ALTER COLUMN `retention_withheld_current` SET TAGS ('pii_business_glossary_term' = 'Retention Withheld Current Period');
ALTER TABLE `vibe_construction_v1`.`bid`.`bid_payment_application` ALTER COLUMN `retention_withheld_total` SET TAGS ('pii_business_glossary_term' = 'Total Retention Withheld to Date');
ALTER TABLE `vibe_construction_v1`.`bid`.`bid_payment_application` ALTER COLUMN `submission_date` SET TAGS ('pii_business_glossary_term' = 'Submission Date');
ALTER TABLE `vibe_construction_v1`.`bid`.`bid_payment_application` ALTER COLUMN `submission_timestamp` SET TAGS ('pii_business_glossary_term' = 'Submission Timestamp');
ALTER TABLE `vibe_construction_v1`.`bid`.`bid_payment_application` ALTER COLUMN `supporting_documents_submitted` SET TAGS ('pii_business_glossary_term' = 'Supporting Documents Submitted');
ALTER TABLE `vibe_construction_v1`.`bid`.`bid_payment_application` ALTER COLUMN `total_earned_to_date` SET TAGS ('pii_business_glossary_term' = 'Total Earned to Date');
ALTER TABLE `vibe_construction_v1`.`bid`.`bid_payment_application` ALTER COLUMN `work_completed_to_date` SET TAGS ('pii_business_glossary_term' = 'Work Completed to Date');
ALTER TABLE `vibe_construction_v1`.`bid`.`subcontractor_bond` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_construction_v1`.`bid`.`subcontractor_bond` SET TAGS ('pii_subdomain' = 'tender_preparation');
ALTER TABLE `vibe_construction_v1`.`bid`.`subcontractor_bond` SET TAGS ('pii_required_structure' = 'v2');
ALTER TABLE `vibe_construction_v1`.`bid`.`subcontractor_bond` SET TAGS ('pii_ecm_structure' = 'preserved_v2');
ALTER TABLE `vibe_construction_v1`.`bid`.`subcontractor_bond` SET TAGS ('pii_structure_required' = 'true');
ALTER TABLE `vibe_construction_v1`.`bid`.`subcontractor_bond` ALTER COLUMN `subcontractor_bond_id` SET TAGS ('pii_business_glossary_term' = 'Subcontractor Bond Identifier');
ALTER TABLE `vibe_construction_v1`.`bid`.`subcontractor_bond` ALTER COLUMN `construction_project_id` SET TAGS ('pii_business_glossary_term' = 'Project ID');
ALTER TABLE `vibe_construction_v1`.`bid`.`subcontractor_bond` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_business_glossary_term' = 'Created By Employee Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`bid`.`subcontractor_bond` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`bid`.`subcontractor_bond` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_construction_v1`.`bid`.`subcontractor_bond` ALTER COLUMN `firm_profile_id` SET TAGS ('pii_business_glossary_term' = 'Subcontractor ID');
ALTER TABLE `vibe_construction_v1`.`bid`.`subcontractor_bond` ALTER COLUMN `subcontract_id` SET TAGS ('pii_business_glossary_term' = 'Subcontract ID');
ALTER TABLE `vibe_construction_v1`.`bid`.`subcontractor_bond` ALTER COLUMN `alert_threshold_days` SET TAGS ('pii_business_glossary_term' = 'Alert Threshold Days');
ALTER TABLE `vibe_construction_v1`.`bid`.`subcontractor_bond` ALTER COLUMN `bond_amount` SET TAGS ('pii_business_glossary_term' = 'Bond Amount');
ALTER TABLE `vibe_construction_v1`.`bid`.`subcontractor_bond` ALTER COLUMN `bond_currency_code` SET TAGS ('pii_business_glossary_term' = 'Bond Currency Code');
ALTER TABLE `vibe_construction_v1`.`bid`.`subcontractor_bond` ALTER COLUMN `bond_currency_code` SET TAGS ('pii_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_construction_v1`.`bid`.`subcontractor_bond` ALTER COLUMN `bond_form` SET TAGS ('pii_business_glossary_term' = 'Bond Form');
ALTER TABLE `vibe_construction_v1`.`bid`.`subcontractor_bond` ALTER COLUMN `bond_form` SET TAGS ('pii_value_regex' = 'aia_a311|aia_a312|fidic|custom|statutory');
ALTER TABLE `vibe_construction_v1`.`bid`.`subcontractor_bond` ALTER COLUMN `bond_number` SET TAGS ('pii_business_glossary_term' = 'Bond Number');
ALTER TABLE `vibe_construction_v1`.`bid`.`subcontractor_bond` ALTER COLUMN `bond_percentage` SET TAGS ('pii_business_glossary_term' = 'Bond Percentage');
ALTER TABLE `vibe_construction_v1`.`bid`.`subcontractor_bond` ALTER COLUMN `bond_premium_amount` SET TAGS ('pii_business_glossary_term' = 'Bond Premium Amount');
ALTER TABLE `vibe_construction_v1`.`bid`.`subcontractor_bond` ALTER COLUMN `bond_premium_amount` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`bid`.`subcontractor_bond` ALTER COLUMN `bond_premium_rate` SET TAGS ('pii_business_glossary_term' = 'Bond Premium Rate');
ALTER TABLE `vibe_construction_v1`.`bid`.`subcontractor_bond` ALTER COLUMN `bond_premium_rate` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`bid`.`subcontractor_bond` ALTER COLUMN `bond_status` SET TAGS ('pii_business_glossary_term' = 'Bond Status');
ALTER TABLE `vibe_construction_v1`.`bid`.`subcontractor_bond` ALTER COLUMN `bond_status` SET TAGS ('pii_value_regex' = 'active|expired|called|released|cancelled|pending');
ALTER TABLE `vibe_construction_v1`.`bid`.`subcontractor_bond` ALTER COLUMN `bond_type` SET TAGS ('pii_business_glossary_term' = 'Bond Type');
ALTER TABLE `vibe_construction_v1`.`bid`.`subcontractor_bond` ALTER COLUMN `bond_type` SET TAGS ('pii_value_regex' = 'performance|payment|bid|maintenance|supply|subdivision');
ALTER TABLE `vibe_construction_v1`.`bid`.`subcontractor_bond` ALTER COLUMN `claim_amount` SET TAGS ('pii_business_glossary_term' = 'Claim Amount');
ALTER TABLE `vibe_construction_v1`.`bid`.`subcontractor_bond` ALTER COLUMN `claim_amount` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`bid`.`subcontractor_bond` ALTER COLUMN `claim_filed_date` SET TAGS ('pii_business_glossary_term' = 'Claim Filed Date');
ALTER TABLE `vibe_construction_v1`.`bid`.`subcontractor_bond` ALTER COLUMN `claim_paid_amount` SET TAGS ('pii_business_glossary_term' = 'Claim Paid Amount');
ALTER TABLE `vibe_construction_v1`.`bid`.`subcontractor_bond` ALTER COLUMN `claim_paid_amount` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`bid`.`subcontractor_bond` ALTER COLUMN `claim_resolution_date` SET TAGS ('pii_business_glossary_term' = 'Claim Resolution Date');
ALTER TABLE `vibe_construction_v1`.`bid`.`subcontractor_bond` ALTER COLUMN `compliance_verified_by` SET TAGS ('pii_business_glossary_term' = 'Compliance Verified By');
ALTER TABLE `vibe_construction_v1`.`bid`.`subcontractor_bond` ALTER COLUMN `compliance_verified_date` SET TAGS ('pii_business_glossary_term' = 'Compliance Verified Date');
ALTER TABLE `vibe_construction_v1`.`bid`.`subcontractor_bond` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_construction_v1`.`bid`.`subcontractor_bond` ALTER COLUMN `document_reference` SET TAGS ('pii_business_glossary_term' = 'Document Reference');
ALTER TABLE `vibe_construction_v1`.`bid`.`subcontractor_bond` ALTER COLUMN `effective_date` SET TAGS ('pii_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_construction_v1`.`bid`.`subcontractor_bond` ALTER COLUMN `expiry_date` SET TAGS ('pii_business_glossary_term' = 'Expiry Date');
ALTER TABLE `vibe_construction_v1`.`bid`.`subcontractor_bond` ALTER COLUMN `modified_by` SET TAGS ('pii_business_glossary_term' = 'Modified By');
ALTER TABLE `vibe_construction_v1`.`bid`.`subcontractor_bond` ALTER COLUMN `modified_timestamp` SET TAGS ('pii_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_construction_v1`.`bid`.`subcontractor_bond` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_construction_v1`.`bid`.`subcontractor_bond` ALTER COLUMN `obligee_name` SET TAGS ('pii_business_glossary_term' = 'Obligee Name');
ALTER TABLE `vibe_construction_v1`.`bid`.`subcontractor_bond` ALTER COLUMN `principal_name` SET TAGS ('pii_business_glossary_term' = 'Principal Name');
ALTER TABLE `vibe_construction_v1`.`bid`.`subcontractor_bond` ALTER COLUMN `release_date` SET TAGS ('pii_business_glossary_term' = 'Release Date');
ALTER TABLE `vibe_construction_v1`.`bid`.`subcontractor_bond` ALTER COLUMN `release_reason` SET TAGS ('pii_business_glossary_term' = 'Release Reason');
ALTER TABLE `vibe_construction_v1`.`bid`.`subcontractor_bond` ALTER COLUMN `renewal_date` SET TAGS ('pii_business_glossary_term' = 'Renewal Date');
ALTER TABLE `vibe_construction_v1`.`bid`.`subcontractor_bond` ALTER COLUMN `renewal_required_flag` SET TAGS ('pii_business_glossary_term' = 'Renewal Required Flag');
ALTER TABLE `vibe_construction_v1`.`bid`.`subcontractor_bond` ALTER COLUMN `surety_company_am_best_rating` SET TAGS ('pii_business_glossary_term' = 'Surety Company AM Best Rating');
ALTER TABLE `vibe_construction_v1`.`bid`.`subcontractor_bond` ALTER COLUMN `surety_company_name` SET TAGS ('pii_business_glossary_term' = 'Surety Company Name');
ALTER TABLE `vibe_construction_v1`.`bid`.`subcontractor_bond` ALTER COLUMN `surety_license_number` SET TAGS ('pii_business_glossary_term' = 'Surety License Number');
ALTER TABLE `vibe_construction_v1`.`bid`.`tender` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_construction_v1`.`bid`.`tender` SET TAGS ('pii_subdomain' = 'tender_preparation');
ALTER TABLE `vibe_construction_v1`.`bid`.`tender` SET TAGS ('pii_required_structure' = 'v2');
ALTER TABLE `vibe_construction_v1`.`bid`.`tender` SET TAGS ('pii_ecm_structure' = 'preserved_v2');
ALTER TABLE `vibe_construction_v1`.`bid`.`tender` SET TAGS ('pii_structure_required' = 'true');
ALTER TABLE `vibe_construction_v1`.`bid`.`tender` ALTER COLUMN `tender_id` SET TAGS ('pii_business_glossary_term' = 'Tender ID');
ALTER TABLE `vibe_construction_v1`.`bid`.`tender` ALTER COLUMN `account_id` SET TAGS ('pii_business_glossary_term' = 'Client ID');
ALTER TABLE `vibe_construction_v1`.`bid`.`tender` ALTER COLUMN `client_opportunity_id` SET TAGS ('pii_business_glossary_term' = 'Client Opportunity Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`bid`.`tender` ALTER COLUMN `construction_project_id` SET TAGS ('pii_business_glossary_term' = 'Project Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`bid`.`tender` ALTER COLUMN `cost_center_id` SET TAGS ('pii_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`bid`.`tender` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_business_glossary_term' = 'Lead Estimator ID');
ALTER TABLE `vibe_construction_v1`.`bid`.`tender` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`bid`.`tender` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_construction_v1`.`bid`.`tender` ALTER COLUMN `award_decision_date` SET TAGS ('pii_business_glossary_term' = 'Award Decision Date');
ALTER TABLE `vibe_construction_v1`.`bid`.`tender` ALTER COLUMN `award_status` SET TAGS ('pii_business_glossary_term' = 'Award Status');
ALTER TABLE `vibe_construction_v1`.`bid`.`tender` ALTER COLUMN `award_status` SET TAGS ('pii_value_regex' = 'awarded|not_awarded|pending');
ALTER TABLE `vibe_construction_v1`.`bid`.`tender` ALTER COLUMN `bid_bond_amount` SET TAGS ('pii_business_glossary_term' = 'Bid Bond Amount');
ALTER TABLE `vibe_construction_v1`.`bid`.`tender` ALTER COLUMN `bid_bond_expiry` SET TAGS ('pii_business_glossary_term' = 'Bid Bond Expiry Date');
ALTER TABLE `vibe_construction_v1`.`bid`.`tender` ALTER COLUMN `bid_bond_required` SET TAGS ('pii_business_glossary_term' = 'Bid Bond Required');
ALTER TABLE `vibe_construction_v1`.`bid`.`tender` ALTER COLUMN `bid_bond_type` SET TAGS ('pii_business_glossary_term' = 'Bid Bond Type');
ALTER TABLE `vibe_construction_v1`.`bid`.`tender` ALTER COLUMN `bid_bond_type` SET TAGS ('pii_value_regex' = 'bank|insurance|cash');
ALTER TABLE `vibe_construction_v1`.`bid`.`tender` ALTER COLUMN `bid_type` SET TAGS ('pii_business_glossary_term' = 'Bid Type');
ALTER TABLE `vibe_construction_v1`.`bid`.`tender` ALTER COLUMN `bid_type` SET TAGS ('pii_value_regex' = 'new|renewal|extension');
ALTER TABLE `vibe_construction_v1`.`bid`.`tender` ALTER COLUMN `compliance_requirements_met` SET TAGS ('pii_business_glossary_term' = 'Compliance Requirements Met');
ALTER TABLE `vibe_construction_v1`.`bid`.`tender` ALTER COLUMN `confidentiality_flag` SET TAGS ('pii_business_glossary_term' = 'Confidentiality Flag');
ALTER TABLE `vibe_construction_v1`.`bid`.`tender` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_construction_v1`.`bid`.`tender` ALTER COLUMN `currency_code` SET TAGS ('pii_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `vibe_construction_v1`.`bid`.`tender` ALTER COLUMN `documents_attached` SET TAGS ('pii_business_glossary_term' = 'Documents Attached Count');
ALTER TABLE `vibe_construction_v1`.`bid`.`tender` ALTER COLUMN `estimated_duration_months` SET TAGS ('pii_business_glossary_term' = 'Estimated Duration (Months)');
ALTER TABLE `vibe_construction_v1`.`bid`.`tender` ALTER COLUMN `estimated_value` SET TAGS ('pii_business_glossary_term' = 'Estimated Tender Value');
ALTER TABLE `vibe_construction_v1`.`bid`.`tender` ALTER COLUMN `evaluation_method` SET TAGS ('pii_business_glossary_term' = 'Evaluation Method');
ALTER TABLE `vibe_construction_v1`.`bid`.`tender` ALTER COLUMN `evaluation_method` SET TAGS ('pii_value_regex' = 'technical|financial|combined');
ALTER TABLE `vibe_construction_v1`.`bid`.`tender` ALTER COLUMN `evaluation_score` SET TAGS ('pii_business_glossary_term' = 'Evaluation Score');
ALTER TABLE `vibe_construction_v1`.`bid`.`tender` ALTER COLUMN `is_joint_venture` SET TAGS ('pii_business_glossary_term' = 'Joint Venture Flag');
ALTER TABLE `vibe_construction_v1`.`bid`.`tender` ALTER COLUMN `joint_venture_partner` SET TAGS ('pii_business_glossary_term' = 'Joint Venture Partner');
ALTER TABLE `vibe_construction_v1`.`bid`.`tender` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Tender Notes');
ALTER TABLE `vibe_construction_v1`.`bid`.`tender` ALTER COLUMN `prequalification_status` SET TAGS ('pii_business_glossary_term' = 'Prequalification Status');
ALTER TABLE `vibe_construction_v1`.`bid`.`tender` ALTER COLUMN `prequalification_status` SET TAGS ('pii_value_regex' = 'qualified|unqualified|pending');
ALTER TABLE `vibe_construction_v1`.`bid`.`tender` ALTER COLUMN `procurement_method` SET TAGS ('pii_business_glossary_term' = 'Procurement Method');
ALTER TABLE `vibe_construction_v1`.`bid`.`tender` ALTER COLUMN `project_end_date` SET TAGS ('pii_business_glossary_term' = 'Project End Date');
ALTER TABLE `vibe_construction_v1`.`bid`.`tender` ALTER COLUMN `project_location` SET TAGS ('pii_business_glossary_term' = 'Project Location');
ALTER TABLE `vibe_construction_v1`.`bid`.`tender` ALTER COLUMN `project_start_date` SET TAGS ('pii_business_glossary_term' = 'Project Start Date');
ALTER TABLE `vibe_construction_v1`.`bid`.`tender` ALTER COLUMN `project_title` SET TAGS ('pii_business_glossary_term' = 'Project Title (PROJ_TITLE)');
ALTER TABLE `vibe_construction_v1`.`bid`.`tender` ALTER COLUMN `region_code` SET TAGS ('pii_business_glossary_term' = 'Region Code (ISO 3166‑1 Alpha‑3)');
ALTER TABLE `vibe_construction_v1`.`bid`.`tender` ALTER COLUMN `regulatory_approval_required` SET TAGS ('pii_business_glossary_term' = 'Regulatory Approval Required');
ALTER TABLE `vibe_construction_v1`.`bid`.`tender` ALTER COLUMN `regulatory_approval_status` SET TAGS ('pii_business_glossary_term' = 'Regulatory Approval Status');
ALTER TABLE `vibe_construction_v1`.`bid`.`tender` ALTER COLUMN `regulatory_approval_status` SET TAGS ('pii_value_regex' = 'pending|approved|rejected');
ALTER TABLE `vibe_construction_v1`.`bid`.`tender` ALTER COLUMN `risk_rating` SET TAGS ('pii_business_glossary_term' = 'Risk Rating');
ALTER TABLE `vibe_construction_v1`.`bid`.`tender` ALTER COLUMN `risk_rating` SET TAGS ('pii_value_regex' = 'low|medium|high|critical');
ALTER TABLE `vibe_construction_v1`.`bid`.`tender` ALTER COLUMN `submission_date` SET TAGS ('pii_business_glossary_term' = 'Submission Date');
ALTER TABLE `vibe_construction_v1`.`bid`.`tender` ALTER COLUMN `submission_deadline` SET TAGS ('pii_business_glossary_term' = 'Submission Deadline');
ALTER TABLE `vibe_construction_v1`.`bid`.`tender` ALTER COLUMN `submission_status` SET TAGS ('pii_business_glossary_term' = 'Submission Status');
ALTER TABLE `vibe_construction_v1`.`bid`.`tender` ALTER COLUMN `submission_status` SET TAGS ('pii_value_regex' = 'draft|submitted|withdrawn|awarded|rejected');
ALTER TABLE `vibe_construction_v1`.`bid`.`tender` ALTER COLUMN `tender_number` SET TAGS ('pii_business_glossary_term' = 'Tender Number (TENDER_NO)');
ALTER TABLE `vibe_construction_v1`.`bid`.`tender` ALTER COLUMN `tender_type` SET TAGS ('pii_business_glossary_term' = 'Tender Type (TENDER_TYPE)');
ALTER TABLE `vibe_construction_v1`.`bid`.`tender` ALTER COLUMN `tender_type` SET TAGS ('pii_value_regex' = 'lump_sum|gmp|unit_rate|epc|design_build|dbb');
ALTER TABLE `vibe_construction_v1`.`bid`.`tender` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_construction_v1`.`bid`.`tender` ALTER COLUMN `validity_end` SET TAGS ('pii_business_glossary_term' = 'Tender Validity End Date');
ALTER TABLE `vibe_construction_v1`.`bid`.`tender` ALTER COLUMN `validity_start` SET TAGS ('pii_business_glossary_term' = 'Tender Validity Start Date');
ALTER TABLE `vibe_construction_v1`.`bid`.`estimate` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_construction_v1`.`bid`.`estimate` SET TAGS ('pii_subdomain' = 'cost_estimating');
ALTER TABLE `vibe_construction_v1`.`bid`.`estimate` SET TAGS ('pii_required_structure' = 'v2');
ALTER TABLE `vibe_construction_v1`.`bid`.`estimate` SET TAGS ('pii_ecm_structure' = 'preserved_v2');
ALTER TABLE `vibe_construction_v1`.`bid`.`estimate` SET TAGS ('pii_structure_required' = 'true');
ALTER TABLE `vibe_construction_v1`.`bid`.`estimate` ALTER COLUMN `estimate_id` SET TAGS ('pii_business_glossary_term' = 'Estimate ID');
ALTER TABLE `vibe_construction_v1`.`bid`.`estimate` ALTER COLUMN `account_id` SET TAGS ('pii_business_glossary_term' = 'Client ID');
ALTER TABLE `vibe_construction_v1`.`bid`.`estimate` ALTER COLUMN `construction_project_id` SET TAGS ('pii_business_glossary_term' = 'Project ID');
ALTER TABLE `vibe_construction_v1`.`bid`.`estimate` ALTER COLUMN `cost_center_id` SET TAGS ('pii_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`bid`.`estimate` ALTER COLUMN `engineering_submittal_id` SET TAGS ('pii_business_glossary_term' = 'Design Submittal Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`bid`.`estimate` ALTER COLUMN `embodied_carbon_assessment_id` SET TAGS ('pii_business_glossary_term' = 'Embodied Carbon Assessment Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`bid`.`estimate` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_business_glossary_term' = 'Estimate Owner ID');
ALTER TABLE `vibe_construction_v1`.`bid`.`estimate` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`bid`.`estimate` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_construction_v1`.`bid`.`estimate` ALTER COLUMN `env_impact_assessment_id` SET TAGS ('pii_business_glossary_term' = 'Environmental Assessment Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`bid`.`estimate` ALTER COLUMN `labor_rate_id` SET TAGS ('pii_business_glossary_term' = 'Labor Rate Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`bid`.`estimate` ALTER COLUMN `submission_id` SET TAGS ('pii_business_glossary_term' = 'Bid ID');
ALTER TABLE `vibe_construction_v1`.`bid`.`estimate` ALTER COLUMN `approved_timestamp` SET TAGS ('pii_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `vibe_construction_v1`.`bid`.`estimate` ALTER COLUMN `base_pricing_date` SET TAGS ('pii_business_glossary_term' = 'Base Pricing Date');
ALTER TABLE `vibe_construction_v1`.`bid`.`estimate` ALTER COLUMN `estimate_category` SET TAGS ('pii_business_glossary_term' = 'Estimate Category');
ALTER TABLE `vibe_construction_v1`.`bid`.`estimate` ALTER COLUMN `estimate_category` SET TAGS ('pii_value_regex' = 'new_work|renovation|maintenance|expansion|demolition');
ALTER TABLE `vibe_construction_v1`.`bid`.`estimate` ALTER COLUMN `contingency_percentage` SET TAGS ('pii_business_glossary_term' = 'Contingency Percentage');
ALTER TABLE `vibe_construction_v1`.`bid`.`estimate` ALTER COLUMN `cost_breakdown_version` SET TAGS ('pii_business_glossary_term' = 'Cost Breakdown Version');
ALTER TABLE `vibe_construction_v1`.`bid`.`estimate` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_construction_v1`.`bid`.`estimate` ALTER COLUMN `currency_code` SET TAGS ('pii_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_construction_v1`.`bid`.`estimate` ALTER COLUMN `document_reference` SET TAGS ('pii_business_glossary_term' = 'Document Reference');
ALTER TABLE `vibe_construction_v1`.`bid`.`estimate` ALTER COLUMN `escalation_allowance` SET TAGS ('pii_business_glossary_term' = 'Escalation Allowance');
ALTER TABLE `vibe_construction_v1`.`bid`.`estimate` ALTER COLUMN `estimate_number` SET TAGS ('pii_business_glossary_term' = 'Estimate Number');
ALTER TABLE `vibe_construction_v1`.`bid`.`estimate` ALTER COLUMN `estimate_status` SET TAGS ('pii_business_glossary_term' = 'Estimate Status');
ALTER TABLE `vibe_construction_v1`.`bid`.`estimate` ALTER COLUMN `estimate_status` SET TAGS ('pii_value_regex' = 'draft|submitted|approved|rejected|withdrawn');
ALTER TABLE `vibe_construction_v1`.`bid`.`estimate` ALTER COLUMN `estimate_type` SET TAGS ('pii_business_glossary_term' = 'Estimate Type');
ALTER TABLE `vibe_construction_v1`.`bid`.`estimate` ALTER COLUMN `estimate_type` SET TAGS ('pii_value_regex' = 'conceptual|schematic|detailed|definitive|preliminary');
ALTER TABLE `vibe_construction_v1`.`bid`.`estimate` ALTER COLUMN `estimating_method` SET TAGS ('pii_business_glossary_term' = 'Estimating Method');
ALTER TABLE `vibe_construction_v1`.`bid`.`estimate` ALTER COLUMN `estimating_method` SET TAGS ('pii_value_regex' = 'parametric|unit_rate|first_principles|analogous');
ALTER TABLE `vibe_construction_v1`.`bid`.`estimate` ALTER COLUMN `expiration_date` SET TAGS ('pii_business_glossary_term' = 'Expiration Date');
ALTER TABLE `vibe_construction_v1`.`bid`.`estimate` ALTER COLUMN `is_gmp` SET TAGS ('pii_business_glossary_term' = 'Guaranteed Maximum Price Flag');
ALTER TABLE `vibe_construction_v1`.`bid`.`estimate` ALTER COLUMN `is_locked` SET TAGS ('pii_business_glossary_term' = 'Estimate Locked Flag');
ALTER TABLE `vibe_construction_v1`.`bid`.`estimate` ALTER COLUMN `is_lump_sum` SET TAGS ('pii_business_glossary_term' = 'Lump‑Sum Estimate Flag');
ALTER TABLE `vibe_construction_v1`.`bid`.`estimate` ALTER COLUMN `estimate_name` SET TAGS ('pii_business_glossary_term' = 'Estimate Name');
ALTER TABLE `vibe_construction_v1`.`bid`.`estimate` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Estimate Notes');
ALTER TABLE `vibe_construction_v1`.`bid`.`estimate` ALTER COLUMN `overhead_percentage` SET TAGS ('pii_business_glossary_term' = 'Overhead Percentage');
ALTER TABLE `vibe_construction_v1`.`bid`.`estimate` ALTER COLUMN `profit_margin_percentage` SET TAGS ('pii_business_glossary_term' = 'Profit Margin Percentage');
ALTER TABLE `vibe_construction_v1`.`bid`.`estimate` ALTER COLUMN `revision_date` SET TAGS ('pii_business_glossary_term' = 'Revision Date');
ALTER TABLE `vibe_construction_v1`.`bid`.`estimate` ALTER COLUMN `revision_number` SET TAGS ('pii_business_glossary_term' = 'Revision Number');
ALTER TABLE `vibe_construction_v1`.`bid`.`estimate` ALTER COLUMN `risk_factor` SET TAGS ('pii_business_glossary_term' = 'Risk Factor');
ALTER TABLE `vibe_construction_v1`.`bid`.`estimate` ALTER COLUMN `schedule_impact_days` SET TAGS ('pii_business_glossary_term' = 'Schedule Impact (Days)');
ALTER TABLE `vibe_construction_v1`.`bid`.`estimate` ALTER COLUMN `total_estimated_cost` SET TAGS ('pii_business_glossary_term' = 'Total Estimated Cost');
ALTER TABLE `vibe_construction_v1`.`bid`.`estimate` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_construction_v1`.`bid`.`boq` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_construction_v1`.`bid`.`boq` SET TAGS ('pii_subdomain' = 'tender_preparation');
ALTER TABLE `vibe_construction_v1`.`bid`.`boq` SET TAGS ('pii_required_structure' = 'v2');
ALTER TABLE `vibe_construction_v1`.`bid`.`boq` SET TAGS ('pii_ecm_structure' = 'preserved_v2');
ALTER TABLE `vibe_construction_v1`.`bid`.`boq` SET TAGS ('pii_structure_required' = 'true');
ALTER TABLE `vibe_construction_v1`.`bid`.`boq` ALTER COLUMN `boq_id` SET TAGS ('pii_business_glossary_term' = 'Bill of Quantities ID');
ALTER TABLE `vibe_construction_v1`.`bid`.`boq` ALTER COLUMN `bim_model_id` SET TAGS ('pii_business_glossary_term' = 'Bim Model Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`bid`.`boq` ALTER COLUMN `construction_project_id` SET TAGS ('pii_business_glossary_term' = 'Project ID');
ALTER TABLE `vibe_construction_v1`.`bid`.`boq` ALTER COLUMN `cost_center_id` SET TAGS ('pii_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`bid`.`boq` ALTER COLUMN `drawing_id` SET TAGS ('pii_business_glossary_term' = 'Drawing Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`bid`.`boq` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_business_glossary_term' = 'Prepared By Employee Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`bid`.`boq` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`bid`.`boq` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_construction_v1`.`bid`.`boq` ALTER COLUMN `tender_id` SET TAGS ('pii_business_glossary_term' = 'Tender ID');
ALTER TABLE `vibe_construction_v1`.`bid`.`boq` ALTER COLUMN `approval_date` SET TAGS ('pii_business_glossary_term' = 'BOQ Approval Date');
ALTER TABLE `vibe_construction_v1`.`bid`.`boq` ALTER COLUMN `approved_by` SET TAGS ('pii_business_glossary_term' = 'Approved By');
ALTER TABLE `vibe_construction_v1`.`bid`.`boq` ALTER COLUMN `boq_status` SET TAGS ('pii_business_glossary_term' = 'BOQ Status');
ALTER TABLE `vibe_construction_v1`.`bid`.`boq` ALTER COLUMN `boq_status` SET TAGS ('pii_value_regex' = 'draft|issued|approved|revised|archived');
ALTER TABLE `vibe_construction_v1`.`bid`.`boq` ALTER COLUMN `boq_type` SET TAGS ('pii_business_glossary_term' = 'BOQ Type');
ALTER TABLE `vibe_construction_v1`.`bid`.`boq` ALTER COLUMN `boq_type` SET TAGS ('pii_value_regex' = 'measured|provisional|approximate');
ALTER TABLE `vibe_construction_v1`.`bid`.`boq` ALTER COLUMN `contains_confidential_pricing` SET TAGS ('pii_business_glossary_term' = 'Confidential Pricing Flag');
ALTER TABLE `vibe_construction_v1`.`bid`.`boq` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_construction_v1`.`bid`.`boq` ALTER COLUMN `currency` SET TAGS ('pii_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_construction_v1`.`bid`.`boq` ALTER COLUMN `currency` SET TAGS ('pii_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_construction_v1`.`bid`.`boq` ALTER COLUMN `boq_description` SET TAGS ('pii_business_glossary_term' = 'BOQ Description');
ALTER TABLE `vibe_construction_v1`.`bid`.`boq` ALTER COLUMN `exchange_rate` SET TAGS ('pii_business_glossary_term' = 'Currency Exchange Rate');
ALTER TABLE `vibe_construction_v1`.`bid`.`boq` ALTER COLUMN `exchange_rate_date` SET TAGS ('pii_business_glossary_term' = 'Exchange Rate Date');
ALTER TABLE `vibe_construction_v1`.`bid`.`boq` ALTER COLUMN `expiry_date` SET TAGS ('pii_business_glossary_term' = 'BOQ Expiry Date');
ALTER TABLE `vibe_construction_v1`.`bid`.`boq` ALTER COLUMN `issue_date` SET TAGS ('pii_business_glossary_term' = 'BOQ Issue Date');
ALTER TABLE `vibe_construction_v1`.`bid`.`boq` ALTER COLUMN `preparation_date` SET TAGS ('pii_business_glossary_term' = 'BOQ Preparation Date');
ALTER TABLE `vibe_construction_v1`.`bid`.`boq` ALTER COLUMN `reference` SET TAGS ('pii_business_glossary_term' = 'BOQ Reference Number');
ALTER TABLE `vibe_construction_v1`.`bid`.`boq` ALTER COLUMN `revision_number` SET TAGS ('pii_business_glossary_term' = 'BOQ Revision Number');
ALTER TABLE `vibe_construction_v1`.`bid`.`boq` ALTER COLUMN `specification_standard` SET TAGS ('pii_business_glossary_term' = 'Specification Standard');
ALTER TABLE `vibe_construction_v1`.`bid`.`boq` ALTER COLUMN `specification_standard` SET TAGS ('pii_value_regex' = 'NRM|POMI|CESMM');
ALTER TABLE `vibe_construction_v1`.`bid`.`boq` ALTER COLUMN `total_quantity` SET TAGS ('pii_business_glossary_term' = 'Total BOQ Quantity');
ALTER TABLE `vibe_construction_v1`.`bid`.`boq` ALTER COLUMN `total_value` SET TAGS ('pii_business_glossary_term' = 'Total BOQ Value');
ALTER TABLE `vibe_construction_v1`.`bid`.`boq` ALTER COLUMN `total_value` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`bid`.`boq` ALTER COLUMN `total_value` SET TAGS ('pii_financial' = 'true');
ALTER TABLE `vibe_construction_v1`.`bid`.`boq` ALTER COLUMN `updated_by` SET TAGS ('pii_business_glossary_term' = 'Updated By');
ALTER TABLE `vibe_construction_v1`.`bid`.`boq` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_construction_v1`.`bid`.`boq` ALTER COLUMN `version_label` SET TAGS ('pii_business_glossary_term' = 'BOQ Version Label');
ALTER TABLE `vibe_construction_v1`.`bid`.`boq` ALTER COLUMN `created_by` SET TAGS ('pii_business_glossary_term' = 'Created By');
ALTER TABLE `vibe_construction_v1`.`bid`.`estimate_line` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_construction_v1`.`bid`.`estimate_line` SET TAGS ('pii_subdomain' = 'cost_estimating');
ALTER TABLE `vibe_construction_v1`.`bid`.`estimate_line` SET TAGS ('pii_required_structure' = 'v2');
ALTER TABLE `vibe_construction_v1`.`bid`.`estimate_line` SET TAGS ('pii_ecm_structure' = 'preserved_v2');
ALTER TABLE `vibe_construction_v1`.`bid`.`estimate_line` SET TAGS ('pii_structure_required' = 'true');
ALTER TABLE `vibe_construction_v1`.`bid`.`estimate_line` ALTER COLUMN `estimate_line_id` SET TAGS ('pii_business_glossary_term' = 'Estimate Line Identifier');
ALTER TABLE `vibe_construction_v1`.`bid`.`estimate_line` ALTER COLUMN `asset_id` SET TAGS ('pii_business_glossary_term' = 'Equipment Identifier');
ALTER TABLE `vibe_construction_v1`.`bid`.`estimate_line` ALTER COLUMN `construction_project_id` SET TAGS ('pii_business_glossary_term' = 'Project Identifier');
ALTER TABLE `vibe_construction_v1`.`bid`.`estimate_line` ALTER COLUMN `estimate_id` SET TAGS ('pii_business_glossary_term' = 'Estimate Identifier');
ALTER TABLE `vibe_construction_v1`.`bid`.`estimate_line` ALTER COLUMN `firm_profile_id` SET TAGS ('pii_business_glossary_term' = 'Subcontractor Identifier');
ALTER TABLE `vibe_construction_v1`.`bid`.`estimate_line` ALTER COLUMN `labor_rate_id` SET TAGS ('pii_business_glossary_term' = 'Labor Rate Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`bid`.`estimate_line` ALTER COLUMN `master_id` SET TAGS ('pii_business_glossary_term' = 'Material Material Master Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`bid`.`estimate_line` ALTER COLUMN `resource_id` SET TAGS ('pii_business_glossary_term' = 'Resource Identifier');
ALTER TABLE `vibe_construction_v1`.`bid`.`estimate_line` ALTER COLUMN `approval_date` SET TAGS ('pii_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_construction_v1`.`bid`.`estimate_line` ALTER COLUMN `approved_by` SET TAGS ('pii_business_glossary_term' = 'Approved By');
ALTER TABLE `vibe_construction_v1`.`bid`.`estimate_line` ALTER COLUMN `baseline_cost` SET TAGS ('pii_business_glossary_term' = 'Baseline Cost');
ALTER TABLE `vibe_construction_v1`.`bid`.`estimate_line` ALTER COLUMN `change_order_number` SET TAGS ('pii_business_glossary_term' = 'Change Order Number');
ALTER TABLE `vibe_construction_v1`.`bid`.`estimate_line` ALTER COLUMN `cost_category` SET TAGS ('pii_business_glossary_term' = 'Cost Category');
ALTER TABLE `vibe_construction_v1`.`bid`.`estimate_line` ALTER COLUMN `cost_category` SET TAGS ('pii_value_regex' = 'labour|material|plant|subcontract|indirect');
ALTER TABLE `vibe_construction_v1`.`bid`.`estimate_line` ALTER COLUMN `cost_center_code` SET TAGS ('pii_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `vibe_construction_v1`.`bid`.`estimate_line` ALTER COLUMN `cost_code` SET TAGS ('pii_business_glossary_term' = 'Cost Code');
ALTER TABLE `vibe_construction_v1`.`bid`.`estimate_line` ALTER COLUMN `cost_variance` SET TAGS ('pii_business_glossary_term' = 'Cost Variance');
ALTER TABLE `vibe_construction_v1`.`bid`.`estimate_line` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Creation Timestamp');
ALTER TABLE `vibe_construction_v1`.`bid`.`estimate_line` ALTER COLUMN `currency_code` SET TAGS ('pii_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_construction_v1`.`bid`.`estimate_line` ALTER COLUMN `estimate_line_status` SET TAGS ('pii_business_glossary_term' = 'Line Status');
ALTER TABLE `vibe_construction_v1`.`bid`.`estimate_line` ALTER COLUMN `estimate_line_status` SET TAGS ('pii_value_regex' = 'draft|submitted|approved|rejected|archived');
ALTER TABLE `vibe_construction_v1`.`bid`.`estimate_line` ALTER COLUMN `estimate_version` SET TAGS ('pii_business_glossary_term' = 'Estimate Version');
ALTER TABLE `vibe_construction_v1`.`bid`.`estimate_line` ALTER COLUMN `is_deleted` SET TAGS ('pii_business_glossary_term' = 'Is Deleted Flag');
ALTER TABLE `vibe_construction_v1`.`bid`.`estimate_line` ALTER COLUMN `labor_grade` SET TAGS ('pii_business_glossary_term' = 'Labor Grade');
ALTER TABLE `vibe_construction_v1`.`bid`.`estimate_line` ALTER COLUMN `labor_rate_type` SET TAGS ('pii_business_glossary_term' = 'Labor Rate Type');
ALTER TABLE `vibe_construction_v1`.`bid`.`estimate_line` ALTER COLUMN `labor_rate_type` SET TAGS ('pii_value_regex' = 'hourly|daily|weekly');
ALTER TABLE `vibe_construction_v1`.`bid`.`estimate_line` ALTER COLUMN `line_sequence` SET TAGS ('pii_business_glossary_term' = 'Line Sequence Number');
ALTER TABLE `vibe_construction_v1`.`bid`.`estimate_line` ALTER COLUMN `location_code` SET TAGS ('pii_business_glossary_term' = 'Location Code');
ALTER TABLE `vibe_construction_v1`.`bid`.`estimate_line` ALTER COLUMN `material_type` SET TAGS ('pii_business_glossary_term' = 'Material Type');
ALTER TABLE `vibe_construction_v1`.`bid`.`estimate_line` ALTER COLUMN `material_type` SET TAGS ('pii_value_regex' = 'raw|prefab|recycled|other');
ALTER TABLE `vibe_construction_v1`.`bid`.`estimate_line` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Line Notes');
ALTER TABLE `vibe_construction_v1`.`bid`.`estimate_line` ALTER COLUMN `productivity_factor` SET TAGS ('pii_business_glossary_term' = 'Productivity Factor');
ALTER TABLE `vibe_construction_v1`.`bid`.`estimate_line` ALTER COLUMN `quantity` SET TAGS ('pii_business_glossary_term' = 'Quantity');
ALTER TABLE `vibe_construction_v1`.`bid`.`estimate_line` ALTER COLUMN `resource_description` SET TAGS ('pii_business_glossary_term' = 'Resource Description');
ALTER TABLE `vibe_construction_v1`.`bid`.`estimate_line` ALTER COLUMN `retention_status` SET TAGS ('pii_business_glossary_term' = 'Retention Status');
ALTER TABLE `vibe_construction_v1`.`bid`.`estimate_line` ALTER COLUMN `retention_status` SET TAGS ('pii_value_regex' = 'retained|released|pending');
ALTER TABLE `vibe_construction_v1`.`bid`.`estimate_line` ALTER COLUMN `revised_cost` SET TAGS ('pii_business_glossary_term' = 'Revised Cost');
ALTER TABLE `vibe_construction_v1`.`bid`.`estimate_line` ALTER COLUMN `risk_factor` SET TAGS ('pii_business_glossary_term' = 'Risk Factor');
ALTER TABLE `vibe_construction_v1`.`bid`.`estimate_line` ALTER COLUMN `source_of_rate` SET TAGS ('pii_business_glossary_term' = 'Source of Rate');
ALTER TABLE `vibe_construction_v1`.`bid`.`estimate_line` ALTER COLUMN `tax_amount` SET TAGS ('pii_business_glossary_term' = 'Tax Amount');
ALTER TABLE `vibe_construction_v1`.`bid`.`estimate_line` ALTER COLUMN `tax_rate` SET TAGS ('pii_business_glossary_term' = 'Tax Rate');
ALTER TABLE `vibe_construction_v1`.`bid`.`estimate_line` ALTER COLUMN `total_cost` SET TAGS ('pii_business_glossary_term' = 'Total Cost');
ALTER TABLE `vibe_construction_v1`.`bid`.`estimate_line` ALTER COLUMN `unit_cost` SET TAGS ('pii_business_glossary_term' = 'Unit Cost');
ALTER TABLE `vibe_construction_v1`.`bid`.`estimate_line` ALTER COLUMN `unit_of_measure` SET TAGS ('pii_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `vibe_construction_v1`.`bid`.`estimate_line` ALTER COLUMN `unit_of_measure` SET TAGS ('pii_value_regex' = 'm|kg|m2|m3|hour|unit');
ALTER TABLE `vibe_construction_v1`.`bid`.`estimate_line` ALTER COLUMN `updated_by` SET TAGS ('pii_business_glossary_term' = 'Updated By');
ALTER TABLE `vibe_construction_v1`.`bid`.`estimate_line` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `vibe_construction_v1`.`bid`.`estimate_line` ALTER COLUMN `variance_reason` SET TAGS ('pii_business_glossary_term' = 'Variance Reason');
ALTER TABLE `vibe_construction_v1`.`bid`.`estimate_line` ALTER COLUMN `waste_factor` SET TAGS ('pii_business_glossary_term' = 'Waste Factor');
ALTER TABLE `vibe_construction_v1`.`bid`.`estimate_line` ALTER COLUMN `wbs_element` SET TAGS ('pii_business_glossary_term' = 'Work Breakdown Structure Element');
ALTER TABLE `vibe_construction_v1`.`bid`.`estimate_line` ALTER COLUMN `created_by` SET TAGS ('pii_business_glossary_term' = 'Created By');
ALTER TABLE `vibe_construction_v1`.`bid`.`submission` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_construction_v1`.`bid`.`submission` SET TAGS ('pii_subdomain' = 'pursuit_management');
ALTER TABLE `vibe_construction_v1`.`bid`.`submission` SET TAGS ('pii_required_structure' = 'v2');
ALTER TABLE `vibe_construction_v1`.`bid`.`submission` SET TAGS ('pii_ecm_structure' = 'preserved_v2');
ALTER TABLE `vibe_construction_v1`.`bid`.`submission` SET TAGS ('pii_structure_required' = 'true');
ALTER TABLE `vibe_construction_v1`.`bid`.`submission` ALTER COLUMN `submission_id` SET TAGS ('pii_business_glossary_term' = 'Bid Submission ID (BSID)');
ALTER TABLE `vibe_construction_v1`.`bid`.`submission` ALTER COLUMN `account_id` SET TAGS ('pii_business_glossary_term' = 'Client Identifier (CID)');
ALTER TABLE `vibe_construction_v1`.`bid`.`submission` ALTER COLUMN `regulatory_permit_id` SET TAGS ('pii_business_glossary_term' = 'Permit Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`bid`.`submission` ALTER COLUMN `construction_project_id` SET TAGS ('pii_business_glossary_term' = 'Project Identifier (PID)');
ALTER TABLE `vibe_construction_v1`.`bid`.`submission` ALTER COLUMN `cost_center_id` SET TAGS ('pii_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`bid`.`submission` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_business_glossary_term' = 'Submitting Person Identifier (SPI)');
ALTER TABLE `vibe_construction_v1`.`bid`.`submission` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`bid`.`submission` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_construction_v1`.`bid`.`submission` ALTER COLUMN `firm_profile_id` SET TAGS ('pii_business_glossary_term' = 'Sub Firm Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`bid`.`submission` ALTER COLUMN `jv_partner_id` SET TAGS ('pii_business_glossary_term' = 'Jv Partner Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`bid`.`submission` ALTER COLUMN `acknowledgement_reference` SET TAGS ('pii_business_glossary_term' = 'Acknowledgement Reference Number (ARN)');
ALTER TABLE `vibe_construction_v1`.`bid`.`submission` ALTER COLUMN `bid_bond_amount` SET TAGS ('pii_business_glossary_term' = 'Bid Bond Amount (BBA)');
ALTER TABLE `vibe_construction_v1`.`bid`.`submission` ALTER COLUMN `bid_bond_expiry` SET TAGS ('pii_business_glossary_term' = 'Bid Bond Expiry Date (BBE)');
ALTER TABLE `vibe_construction_v1`.`bid`.`submission` ALTER COLUMN `bid_bond_type` SET TAGS ('pii_business_glossary_term' = 'Bid Bond Type (BBT)');
ALTER TABLE `vibe_construction_v1`.`bid`.`submission` ALTER COLUMN `bid_bond_type` SET TAGS ('pii_value_regex' = 'performance|payment|security|none');
ALTER TABLE `vibe_construction_v1`.`bid`.`submission` ALTER COLUMN `bid_price` SET TAGS ('pii_business_glossary_term' = 'Bid Price (BP)');
ALTER TABLE `vibe_construction_v1`.`bid`.`submission` ALTER COLUMN `bid_price_adjustment` SET TAGS ('pii_business_glossary_term' = 'Bid Price Adjustment (BPA)');
ALTER TABLE `vibe_construction_v1`.`bid`.`submission` ALTER COLUMN `bid_type` SET TAGS ('pii_business_glossary_term' = 'Bid Type (BT)');
ALTER TABLE `vibe_construction_v1`.`bid`.`submission` ALTER COLUMN `bid_type` SET TAGS ('pii_value_regex' = 'lump_sum|gmp|unit_price|cost_plus');
ALTER TABLE `vibe_construction_v1`.`bid`.`submission` ALTER COLUMN `commercial_score` SET TAGS ('pii_business_glossary_term' = 'Commercial Evaluation Score (CES)');
ALTER TABLE `vibe_construction_v1`.`bid`.`submission` ALTER COLUMN `compliance_requirements_met` SET TAGS ('pii_business_glossary_term' = 'Compliance Requirements Met Indicator (CRMI)');
ALTER TABLE `vibe_construction_v1`.`bid`.`submission` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Creation Timestamp (RCT)');
ALTER TABLE `vibe_construction_v1`.`bid`.`submission` ALTER COLUMN `currency_code` SET TAGS ('pii_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `vibe_construction_v1`.`bid`.`submission` ALTER COLUMN `deadline` SET TAGS ('pii_business_glossary_term' = 'Submission Deadline Date (SDD)');
ALTER TABLE `vibe_construction_v1`.`bid`.`submission` ALTER COLUMN `documents_attached_count` SET TAGS ('pii_business_glossary_term' = 'Attached Documents Count (ADC)');
ALTER TABLE `vibe_construction_v1`.`bid`.`submission` ALTER COLUMN `estimated_duration_months` SET TAGS ('pii_business_glossary_term' = 'Estimated Duration (Months) (EDM)');
ALTER TABLE `vibe_construction_v1`.`bid`.`submission` ALTER COLUMN `evaluation_method` SET TAGS ('pii_business_glossary_term' = 'Evaluation Method (EM)');
ALTER TABLE `vibe_construction_v1`.`bid`.`submission` ALTER COLUMN `evaluation_method` SET TAGS ('pii_value_regex' = 'two_envelope|single_envelope');
ALTER TABLE `vibe_construction_v1`.`bid`.`submission` ALTER COLUMN `is_joint_venture` SET TAGS ('pii_business_glossary_term' = 'Joint Venture Indicator (JVI)');
ALTER TABLE `vibe_construction_v1`.`bid`.`submission` ALTER COLUMN `late_submission_flag` SET TAGS ('pii_business_glossary_term' = 'Late Submission Indicator (LSI)');
ALTER TABLE `vibe_construction_v1`.`bid`.`submission` ALTER COLUMN `method` SET TAGS ('pii_business_glossary_term' = 'Submission Method (SM)');
ALTER TABLE `vibe_construction_v1`.`bid`.`submission` ALTER COLUMN `method` SET TAGS ('pii_value_regex' = 'electronic|hard_copy|email');
ALTER TABLE `vibe_construction_v1`.`bid`.`submission` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Submission Notes (SN)');
ALTER TABLE `vibe_construction_v1`.`bid`.`submission` ALTER COLUMN `number_of_copies` SET TAGS ('pii_business_glossary_term' = 'Number of Copies Submitted (NCS)');
ALTER TABLE `vibe_construction_v1`.`bid`.`submission` ALTER COLUMN `project_location` SET TAGS ('pii_business_glossary_term' = 'Project Location Description (PLD)');
ALTER TABLE `vibe_construction_v1`.`bid`.`submission` ALTER COLUMN `reference_number` SET TAGS ('pii_business_glossary_term' = 'Submission Reference Number (SRN)');
ALTER TABLE `vibe_construction_v1`.`bid`.`submission` ALTER COLUMN `region_code` SET TAGS ('pii_business_glossary_term' = 'Region Code (RC)');
ALTER TABLE `vibe_construction_v1`.`bid`.`submission` ALTER COLUMN `risk_rating` SET TAGS ('pii_business_glossary_term' = 'Risk Rating (RR)');
ALTER TABLE `vibe_construction_v1`.`bid`.`submission` ALTER COLUMN `risk_rating` SET TAGS ('pii_value_regex' = 'low|medium|high');
ALTER TABLE `vibe_construction_v1`.`bid`.`submission` ALTER COLUMN `submission_status` SET TAGS ('pii_business_glossary_term' = 'Bid Submission Status (BSS)');
ALTER TABLE `vibe_construction_v1`.`bid`.`submission` ALTER COLUMN `submission_status` SET TAGS ('pii_value_regex' = 'draft|submitted|acknowledged|rejected|awarded|cancelled');
ALTER TABLE `vibe_construction_v1`.`bid`.`submission` ALTER COLUMN `submission_timestamp` SET TAGS ('pii_business_glossary_term' = 'Bid Submission Timestamp (BST)');
ALTER TABLE `vibe_construction_v1`.`bid`.`submission` ALTER COLUMN `technical_score` SET TAGS ('pii_business_glossary_term' = 'Technical Evaluation Score (TES)');
ALTER TABLE `vibe_construction_v1`.`bid`.`submission` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Update Timestamp (RUT)');
ALTER TABLE `vibe_construction_v1`.`bid`.`clarification` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_construction_v1`.`bid`.`clarification` SET TAGS ('pii_subdomain' = 'pursuit_management');
ALTER TABLE `vibe_construction_v1`.`bid`.`clarification` SET TAGS ('pii_required_structure' = 'v2');
ALTER TABLE `vibe_construction_v1`.`bid`.`clarification` SET TAGS ('pii_ecm_structure' = 'preserved_v2');
ALTER TABLE `vibe_construction_v1`.`bid`.`clarification` SET TAGS ('pii_structure_required' = 'true');
ALTER TABLE `vibe_construction_v1`.`bid`.`clarification` ALTER COLUMN `clarification_id` SET TAGS ('pii_business_glossary_term' = 'Bid Clarification Identifier');
ALTER TABLE `vibe_construction_v1`.`bid`.`clarification` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_business_glossary_term' = 'Originating Employee Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`bid`.`clarification` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`bid`.`clarification` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_construction_v1`.`bid`.`clarification` ALTER COLUMN `party_id` SET TAGS ('pii_business_glossary_term' = 'Originating Party Identifier (ORIG_PARTY_ID)');
ALTER TABLE `vibe_construction_v1`.`bid`.`clarification` ALTER COLUMN `document_register_id` SET TAGS ('pii_business_glossary_term' = 'Related Document Identifier (DOC_ID)');
ALTER TABLE `vibe_construction_v1`.`bid`.`clarification` ALTER COLUMN `rfi_id` SET TAGS ('pii_business_glossary_term' = 'Rfi Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`bid`.`clarification` ALTER COLUMN `acknowledgement_status` SET TAGS ('pii_business_glossary_term' = 'Acknowledgement Status (ACK_STATUS)');
ALTER TABLE `vibe_construction_v1`.`bid`.`clarification` ALTER COLUMN `acknowledgement_status` SET TAGS ('pii_value_regex' = 'acknowledged|not_acknowledged');
ALTER TABLE `vibe_construction_v1`.`bid`.`clarification` ALTER COLUMN `addendum_number` SET TAGS ('pii_business_glossary_term' = 'Addendum Number (ADDENDUM_NO)');
ALTER TABLE `vibe_construction_v1`.`bid`.`clarification` ALTER COLUMN `attachment_flag` SET TAGS ('pii_business_glossary_term' = 'Attachment Flag (HAS_ATTACH)');
ALTER TABLE `vibe_construction_v1`.`bid`.`clarification` ALTER COLUMN `bid_revision_triggered` SET TAGS ('pii_business_glossary_term' = 'Bid Revision Triggered (REV_TRIGGER)');
ALTER TABLE `vibe_construction_v1`.`bid`.`clarification` ALTER COLUMN `clarification_number` SET TAGS ('pii_business_glossary_term' = 'Clarification Number (CLARIF_NO)');
ALTER TABLE `vibe_construction_v1`.`bid`.`clarification` ALTER COLUMN `clarification_status` SET TAGS ('pii_business_glossary_term' = 'Clarification Status (STATUS)');
ALTER TABLE `vibe_construction_v1`.`bid`.`clarification` ALTER COLUMN `clarification_status` SET TAGS ('pii_value_regex' = 'open|answered|closed|incorporated');
ALTER TABLE `vibe_construction_v1`.`bid`.`clarification` ALTER COLUMN `communication_type` SET TAGS ('pii_business_glossary_term' = 'Communication Type (COMM_TYPE)');
ALTER TABLE `vibe_construction_v1`.`bid`.`clarification` ALTER COLUMN `communication_type` SET TAGS ('pii_value_regex' = 'RFI_issued|RFI_received|addendum|amendment|clarification');
ALTER TABLE `vibe_construction_v1`.`bid`.`clarification` ALTER COLUMN `content` SET TAGS ('pii_business_glossary_term' = 'Communication Content (CONTENT)');
ALTER TABLE `vibe_construction_v1`.`bid`.`clarification` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Creation Timestamp (CREATED_TS)');
ALTER TABLE `vibe_construction_v1`.`bid`.`clarification` ALTER COLUMN `currency_code` SET TAGS ('pii_business_glossary_term' = 'Currency Code (CURR)');
ALTER TABLE `vibe_construction_v1`.`bid`.`clarification` ALTER COLUMN `direction` SET TAGS ('pii_business_glossary_term' = 'Communication Direction (DIR)');
ALTER TABLE `vibe_construction_v1`.`bid`.`clarification` ALTER COLUMN `direction` SET TAGS ('pii_value_regex' = 'client_to_contractor|contractor_to_client');
ALTER TABLE `vibe_construction_v1`.`bid`.`clarification` ALTER COLUMN `event_timestamp` SET TAGS ('pii_business_glossary_term' = 'Communication Issued Timestamp (ISSUED_TS)');
ALTER TABLE `vibe_construction_v1`.`bid`.`clarification` ALTER COLUMN `impact_amount` SET TAGS ('pii_business_glossary_term' = 'Impact Monetary Amount (IMP_AMT)');
ALTER TABLE `vibe_construction_v1`.`bid`.`clarification` ALTER COLUMN `impact_description` SET TAGS ('pii_business_glossary_term' = 'Impact Description (IMP_DESC)');
ALTER TABLE `vibe_construction_v1`.`bid`.`clarification` ALTER COLUMN `impact_flag_boq` SET TAGS ('pii_business_glossary_term' = 'BOQ Impact Flag (IMP_BOQ)');
ALTER TABLE `vibe_construction_v1`.`bid`.`clarification` ALTER COLUMN `impact_flag_price` SET TAGS ('pii_business_glossary_term' = 'Price Impact Flag (IMP_PRICE)');
ALTER TABLE `vibe_construction_v1`.`bid`.`clarification` ALTER COLUMN `impact_flag_schedule` SET TAGS ('pii_business_glossary_term' = 'Schedule Impact Flag (IMP_SCHED)');
ALTER TABLE `vibe_construction_v1`.`bid`.`clarification` ALTER COLUMN `impact_flag_scope` SET TAGS ('pii_business_glossary_term' = 'Scope Impact Flag (IMP_SCOPE)');
ALTER TABLE `vibe_construction_v1`.`bid`.`clarification` ALTER COLUMN `impact_flag_specifications` SET TAGS ('pii_business_glossary_term' = 'Specification Impact Flag (IMP_SPEC)');
ALTER TABLE `vibe_construction_v1`.`bid`.`clarification` ALTER COLUMN `is_critical` SET TAGS ('pii_business_glossary_term' = 'Critical Clarification Indicator (CRIT)');
ALTER TABLE `vibe_construction_v1`.`bid`.`clarification` ALTER COLUMN `issuing_authority` SET TAGS ('pii_business_glossary_term' = 'Issuing Authority (ISS_AUTH)');
ALTER TABLE `vibe_construction_v1`.`bid`.`clarification` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Additional Notes (NOTES)');
ALTER TABLE `vibe_construction_v1`.`bid`.`clarification` ALTER COLUMN `response_content` SET TAGS ('pii_business_glossary_term' = 'Response Content (RESP_CONTENT)');
ALTER TABLE `vibe_construction_v1`.`bid`.`clarification` ALTER COLUMN `response_deadline` SET TAGS ('pii_business_glossary_term' = 'Response Deadline (RESP_DEADLINE)');
ALTER TABLE `vibe_construction_v1`.`bid`.`clarification` ALTER COLUMN `response_status` SET TAGS ('pii_business_glossary_term' = 'Response Status (RESP_STATUS)');
ALTER TABLE `vibe_construction_v1`.`bid`.`clarification` ALTER COLUMN `response_status` SET TAGS ('pii_value_regex' = 'pending|provided|overdue');
ALTER TABLE `vibe_construction_v1`.`bid`.`clarification` ALTER COLUMN `response_timestamp` SET TAGS ('pii_business_glossary_term' = 'Response Timestamp (RESP_TS)');
ALTER TABLE `vibe_construction_v1`.`bid`.`clarification` ALTER COLUMN `revised_submission_deadline` SET TAGS ('pii_business_glossary_term' = 'Revised Submission Deadline (REV_DEADLINE)');
ALTER TABLE `vibe_construction_v1`.`bid`.`clarification` ALTER COLUMN `revision_number` SET TAGS ('pii_business_glossary_term' = 'Clarification Revision Number (REV_NO)');
ALTER TABLE `vibe_construction_v1`.`bid`.`clarification` ALTER COLUMN `subject` SET TAGS ('pii_business_glossary_term' = 'Subject Line (SUBJ)');
ALTER TABLE `vibe_construction_v1`.`bid`.`clarification` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Update Timestamp (UPDATED_TS)');
ALTER TABLE `vibe_construction_v1`.`bid`.`bond` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_construction_v1`.`bid`.`bond` SET TAGS ('pii_subdomain' = 'tender_preparation');
ALTER TABLE `vibe_construction_v1`.`bid`.`bond` SET TAGS ('pii_required_structure' = 'v2');
ALTER TABLE `vibe_construction_v1`.`bid`.`bond` SET TAGS ('pii_ecm_structure' = 'preserved_v2');
ALTER TABLE `vibe_construction_v1`.`bid`.`bond` SET TAGS ('pii_ecm_reviewed' = 'true');
ALTER TABLE `vibe_construction_v1`.`bid`.`bond` SET TAGS ('pii_source' = 'vibe-batch');
ALTER TABLE `vibe_construction_v1`.`bid`.`bond` SET TAGS ('pii_structure_required' = 'true');
ALTER TABLE `vibe_construction_v1`.`bid`.`bond` ALTER COLUMN `bond_id` SET TAGS ('pii_business_glossary_term' = 'Bid Bond ID (BB_ID)');
ALTER TABLE `vibe_construction_v1`.`bid`.`bond` ALTER COLUMN `construction_project_id` SET TAGS ('pii_business_glossary_term' = 'Project Identifier (PROJECT_ID)');
ALTER TABLE `vibe_construction_v1`.`bid`.`bond` ALTER COLUMN `gl_account_id` SET TAGS ('pii_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`bid`.`bond` ALTER COLUMN `tender_id` SET TAGS ('pii_business_glossary_term' = 'Tender Identifier (TENDER_ID)');
ALTER TABLE `vibe_construction_v1`.`bid`.`bond` ALTER COLUMN `amount` SET TAGS ('pii_business_glossary_term' = 'Bid Bond Amount (BBA)');
ALTER TABLE `vibe_construction_v1`.`bid`.`bond` ALTER COLUMN `approved_by` SET TAGS ('pii_business_glossary_term' = 'Approved By (APPROVED_BY)');
ALTER TABLE `vibe_construction_v1`.`bid`.`bond` ALTER COLUMN `approved_timestamp` SET TAGS ('pii_business_glossary_term' = 'Approval Timestamp (APPROVED_TS)');
ALTER TABLE `vibe_construction_v1`.`bid`.`bond` ALTER COLUMN `beneficiary` SET TAGS ('pii_business_glossary_term' = 'Beneficiary (Client)');
ALTER TABLE `vibe_construction_v1`.`bid`.`bond` ALTER COLUMN `bond_number` SET TAGS ('pii_business_glossary_term' = 'Bid Bond Number (BBN)');
ALTER TABLE `vibe_construction_v1`.`bid`.`bond` ALTER COLUMN `bond_status` SET TAGS ('pii_business_glossary_term' = 'Bid Bond Status (BB_STATUS)');
ALTER TABLE `vibe_construction_v1`.`bid`.`bond` ALTER COLUMN `bond_status` SET TAGS ('pii_value_regex' = 'issued|submitted|returned|forfeited|extended');
ALTER TABLE `vibe_construction_v1`.`bid`.`bond` ALTER COLUMN `bond_type` SET TAGS ('pii_business_glossary_term' = 'Bid Bond Type (BB_TYPE)');
ALTER TABLE `vibe_construction_v1`.`bid`.`bond` ALTER COLUMN `bond_type` SET TAGS ('pii_value_regex' = 'bank_guarantee|surety_bond|insurance_bond');
ALTER TABLE `vibe_construction_v1`.`bid`.`bond` ALTER COLUMN `compliance_requirements_met` SET TAGS ('pii_business_glossary_term' = 'Compliance Requirements Met Flag (COMPLIANCE_MET)');
ALTER TABLE `vibe_construction_v1`.`bid`.`bond` ALTER COLUMN `confidentiality_flag` SET TAGS ('pii_business_glossary_term' = 'Confidentiality Flag (CONFIDENTIAL_FLAG)');
ALTER TABLE `vibe_construction_v1`.`bid`.`bond` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Creation Timestamp (CREATED_TS)');
ALTER TABLE `vibe_construction_v1`.`bid`.`bond` ALTER COLUMN `currency_code` SET TAGS ('pii_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `vibe_construction_v1`.`bid`.`bond` ALTER COLUMN `documents_attached` SET TAGS ('pii_business_glossary_term' = 'Documents Attached Flag (DOCS_ATTACHED)');
ALTER TABLE `vibe_construction_v1`.`bid`.`bond` ALTER COLUMN `expiry_date` SET TAGS ('pii_business_glossary_term' = 'Bond Expiry Date (EXPIRY_DATE)');
ALTER TABLE `vibe_construction_v1`.`bid`.`bond` ALTER COLUMN `expiry_place` SET TAGS ('pii_business_glossary_term' = 'Bond Expiry Location (EXPIRY_PLACE)');
ALTER TABLE `vibe_construction_v1`.`bid`.`bond` ALTER COLUMN `extension_count` SET TAGS ('pii_business_glossary_term' = 'Number of Extensions (EXT_COUNT)');
ALTER TABLE `vibe_construction_v1`.`bid`.`bond` ALTER COLUMN `guarantee_extension_allowed` SET TAGS ('pii_business_glossary_term' = 'Extension Allowed Flag (EXTENSION_ALLOWED)');
ALTER TABLE `vibe_construction_v1`.`bid`.`bond` ALTER COLUMN `guarantee_extension_reason` SET TAGS ('pii_business_glossary_term' = 'Extension Reason (EXTENSION_REASON)');
ALTER TABLE `vibe_construction_v1`.`bid`.`bond` ALTER COLUMN `issue_date` SET TAGS ('pii_business_glossary_term' = 'Bond Issue Date (ISSUE_DATE)');
ALTER TABLE `vibe_construction_v1`.`bid`.`bond` ALTER COLUMN `issue_place` SET TAGS ('pii_business_glossary_term' = 'Bond Issue Location (ISSUE_PLACE)');
ALTER TABLE `vibe_construction_v1`.`bid`.`bond` ALTER COLUMN `issuer_type` SET TAGS ('pii_business_glossary_term' = 'Issuer Type (ISSUER_TYPE)');
ALTER TABLE `vibe_construction_v1`.`bid`.`bond` ALTER COLUMN `issuer_type` SET TAGS ('pii_value_regex' = 'bank|surety|insurance');
ALTER TABLE `vibe_construction_v1`.`bid`.`bond` ALTER COLUMN `issuing_entity` SET TAGS ('pii_business_glossary_term' = 'Issuing Bank or Surety (Issuer)');
ALTER TABLE `vibe_construction_v1`.`bid`.`bond` ALTER COLUMN `last_extension_date` SET TAGS ('pii_business_glossary_term' = 'Last Extension Date (LAST_EXT_DATE)');
ALTER TABLE `vibe_construction_v1`.`bid`.`bond` ALTER COLUMN `last_updated_by` SET TAGS ('pii_business_glossary_term' = 'Last Updated By (LAST_UPDATED_BY)');
ALTER TABLE `vibe_construction_v1`.`bid`.`bond` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Additional Notes (NOTES)');
ALTER TABLE `vibe_construction_v1`.`bid`.`bond` ALTER COLUMN `percentage` SET TAGS ('pii_business_glossary_term' = 'Bid Bond Percentage of Tender Value (BBP)');
ALTER TABLE `vibe_construction_v1`.`bid`.`bond` ALTER COLUMN `risk_rating` SET TAGS ('pii_business_glossary_term' = 'Risk Rating (RISK_RATING)');
ALTER TABLE `vibe_construction_v1`.`bid`.`bond` ALTER COLUMN `risk_rating` SET TAGS ('pii_value_regex' = 'low|medium|high');
ALTER TABLE `vibe_construction_v1`.`bid`.`bond` ALTER COLUMN `status_date` SET TAGS ('pii_business_glossary_term' = 'Status Effective Date (STATUS_DATE)');
ALTER TABLE `vibe_construction_v1`.`bid`.`bond` ALTER COLUMN `total_extension_days` SET TAGS ('pii_business_glossary_term' = 'Total Extension Days (TOTAL_EXT_DAYS)');
ALTER TABLE `vibe_construction_v1`.`bid`.`bond` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Update Timestamp (UPDATED_TS)');
ALTER TABLE `vibe_construction_v1`.`bid`.`win_loss_record` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_construction_v1`.`bid`.`win_loss_record` SET TAGS ('pii_subdomain' = 'pursuit_management');
ALTER TABLE `vibe_construction_v1`.`bid`.`win_loss_record` SET TAGS ('pii_required_structure' = 'v2');
ALTER TABLE `vibe_construction_v1`.`bid`.`win_loss_record` SET TAGS ('pii_ecm_structure' = 'preserved_v2');
ALTER TABLE `vibe_construction_v1`.`bid`.`win_loss_record` SET TAGS ('pii_structure_required' = 'true');
ALTER TABLE `vibe_construction_v1`.`bid`.`win_loss_record` ALTER COLUMN `win_loss_record_id` SET TAGS ('pii_business_glossary_term' = 'Win/Loss Record ID');
ALTER TABLE `vibe_construction_v1`.`bid`.`win_loss_record` ALTER COLUMN `carbon_target_id` SET TAGS ('pii_business_glossary_term' = 'Carbon Target Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`bid`.`win_loss_record` ALTER COLUMN `construction_project_id` SET TAGS ('pii_business_glossary_term' = 'Project ID');
ALTER TABLE `vibe_construction_v1`.`bid`.`win_loss_record` ALTER COLUMN `jv_partner_id` SET TAGS ('pii_business_glossary_term' = 'Jv Partner Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`bid`.`win_loss_record` ALTER COLUMN `submission_id` SET TAGS ('pii_business_glossary_term' = 'Bid ID');
ALTER TABLE `vibe_construction_v1`.`bid`.`win_loss_record` ALTER COLUMN `tender_id` SET TAGS ('pii_business_glossary_term' = 'Tender ID');
ALTER TABLE `vibe_construction_v1`.`bid`.`win_loss_record` ALTER COLUMN `vendor_id` SET TAGS ('pii_business_glossary_term' = 'Winning Bidder ID');
ALTER TABLE `vibe_construction_v1`.`bid`.`win_loss_record` ALTER COLUMN `awarded_contract_value` SET TAGS ('pii_business_glossary_term' = 'Awarded Contract Value');
ALTER TABLE `vibe_construction_v1`.`bid`.`win_loss_record` ALTER COLUMN `bid_bond_amount` SET TAGS ('pii_business_glossary_term' = 'Bid Bond Amount');
ALTER TABLE `vibe_construction_v1`.`bid`.`win_loss_record` ALTER COLUMN `bid_bond_type` SET TAGS ('pii_business_glossary_term' = 'Bid Bond Type');
ALTER TABLE `vibe_construction_v1`.`bid`.`win_loss_record` ALTER COLUMN `bid_bond_type` SET TAGS ('pii_value_regex' = 'cash|bank_guarantee|insurance|other');
ALTER TABLE `vibe_construction_v1`.`bid`.`win_loss_record` ALTER COLUMN `bid_type` SET TAGS ('pii_business_glossary_term' = 'Bid Type');
ALTER TABLE `vibe_construction_v1`.`bid`.`win_loss_record` ALTER COLUMN `bid_type` SET TAGS ('pii_value_regex' = 'gmp|lump_sum|cost_plus|unit_price|other');
ALTER TABLE `vibe_construction_v1`.`bid`.`win_loss_record` ALTER COLUMN `competitor_count` SET TAGS ('pii_business_glossary_term' = 'Number of Competitors');
ALTER TABLE `vibe_construction_v1`.`bid`.`win_loss_record` ALTER COLUMN `contract_end_date` SET TAGS ('pii_business_glossary_term' = 'Contract End Date');
ALTER TABLE `vibe_construction_v1`.`bid`.`win_loss_record` ALTER COLUMN `contract_start_date` SET TAGS ('pii_business_glossary_term' = 'Contract Start Date');
ALTER TABLE `vibe_construction_v1`.`bid`.`win_loss_record` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_construction_v1`.`bid`.`win_loss_record` ALTER COLUMN `currency_code` SET TAGS ('pii_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `vibe_construction_v1`.`bid`.`win_loss_record` ALTER COLUMN `currency_code` SET TAGS ('pii_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_construction_v1`.`bid`.`win_loss_record` ALTER COLUMN `decision_timestamp` SET TAGS ('pii_business_glossary_term' = 'Decision Timestamp');
ALTER TABLE `vibe_construction_v1`.`bid`.`win_loss_record` ALTER COLUMN `evaluation_method` SET TAGS ('pii_business_glossary_term' = 'Evaluation Method');
ALTER TABLE `vibe_construction_v1`.`bid`.`win_loss_record` ALTER COLUMN `evaluation_method` SET TAGS ('pii_value_regex' = 'technical|combined|price_only|other');
ALTER TABLE `vibe_construction_v1`.`bid`.`win_loss_record` ALTER COLUMN `evaluation_score_commercial` SET TAGS ('pii_business_glossary_term' = 'Commercial Evaluation Score');
ALTER TABLE `vibe_construction_v1`.`bid`.`win_loss_record` ALTER COLUMN `evaluation_score_hsse` SET TAGS ('pii_business_glossary_term' = 'HSSE Evaluation Score');
ALTER TABLE `vibe_construction_v1`.`bid`.`win_loss_record` ALTER COLUMN `evaluation_score_technical` SET TAGS ('pii_business_glossary_term' = 'Technical Evaluation Score');
ALTER TABLE `vibe_construction_v1`.`bid`.`win_loss_record` ALTER COLUMN `is_award_confirmed` SET TAGS ('pii_business_glossary_term' = 'Award Confirmation Flag');
ALTER TABLE `vibe_construction_v1`.`bid`.`win_loss_record` ALTER COLUMN `is_joint_venture` SET TAGS ('pii_business_glossary_term' = 'Joint Venture Indicator');
ALTER TABLE `vibe_construction_v1`.`bid`.`win_loss_record` ALTER COLUMN `lessons_learned_reference` SET TAGS ('pii_business_glossary_term' = 'Lessons Learned Reference');
ALTER TABLE `vibe_construction_v1`.`bid`.`win_loss_record` ALTER COLUMN `loss_reason_category` SET TAGS ('pii_business_glossary_term' = 'Loss Reason Category');
ALTER TABLE `vibe_construction_v1`.`bid`.`win_loss_record` ALTER COLUMN `loss_reason_narrative` SET TAGS ('pii_business_glossary_term' = 'Loss Reason Narrative');
ALTER TABLE `vibe_construction_v1`.`bid`.`win_loss_record` ALTER COLUMN `outcome_status` SET TAGS ('pii_business_glossary_term' = 'Outcome Status');
ALTER TABLE `vibe_construction_v1`.`bid`.`win_loss_record` ALTER COLUMN `outcome_status` SET TAGS ('pii_value_regex' = 'won|lost|withdrawn|cancelled');
ALTER TABLE `vibe_construction_v1`.`bid`.`win_loss_record` ALTER COLUMN `price_gap_to_winner` SET TAGS ('pii_business_glossary_term' = 'Price Gap to Winning Bid');
ALTER TABLE `vibe_construction_v1`.`bid`.`win_loss_record` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_construction_v1`.`bid`.`win_loss_record` ALTER COLUMN `win_loss_number` SET TAGS ('pii_business_glossary_term' = 'Win/Loss Record Number');
ALTER TABLE `vibe_construction_v1`.`bid`.`win_loss_record` ALTER COLUMN `winning_bid_price` SET TAGS ('pii_business_glossary_term' = 'Winning Bid Price');
ALTER TABLE `vibe_construction_v1`.`bid`.`vendor_quote` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_construction_v1`.`bid`.`vendor_quote` SET TAGS ('pii_subdomain' = 'cost_estimating');
ALTER TABLE `vibe_construction_v1`.`bid`.`vendor_quote` SET TAGS ('pii_required_structure' = 'v2');
ALTER TABLE `vibe_construction_v1`.`bid`.`vendor_quote` SET TAGS ('pii_ecm_structure' = 'preserved_v2');
ALTER TABLE `vibe_construction_v1`.`bid`.`vendor_quote` SET TAGS ('pii_structure_required' = 'true');
ALTER TABLE `vibe_construction_v1`.`bid`.`vendor_quote` ALTER COLUMN `vendor_quote_id` SET TAGS ('pii_business_glossary_term' = 'Vendor Quote Identifier');
ALTER TABLE `vibe_construction_v1`.`bid`.`vendor_quote` ALTER COLUMN `sustainable_material_id` SET TAGS ('pii_business_glossary_term' = 'Sustainable Material Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`bid`.`vendor_quote` ALTER COLUMN `vendor_id` SET TAGS ('pii_business_glossary_term' = 'Vendor ID');
ALTER TABLE `vibe_construction_v1`.`bid`.`vendor_quote` ALTER COLUMN `compliance_requirements_met` SET TAGS ('pii_business_glossary_term' = 'Compliance Requirements Met');
ALTER TABLE `vibe_construction_v1`.`bid`.`vendor_quote` ALTER COLUMN `compliance_requirements_met` SET TAGS ('pii_value_regex' = 'yes|no|partial');
ALTER TABLE `vibe_construction_v1`.`bid`.`vendor_quote` ALTER COLUMN `confidentiality_flag` SET TAGS ('pii_business_glossary_term' = 'Confidentiality Flag');
ALTER TABLE `vibe_construction_v1`.`bid`.`vendor_quote` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_construction_v1`.`bid`.`vendor_quote` ALTER COLUMN `currency_code` SET TAGS ('pii_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `vibe_construction_v1`.`bid`.`vendor_quote` ALTER COLUMN `delivery_lead_time_days` SET TAGS ('pii_business_glossary_term' = 'Delivery Lead Time (Days)');
ALTER TABLE `vibe_construction_v1`.`bid`.`vendor_quote` ALTER COLUMN `delivery_terms` SET TAGS ('pii_business_glossary_term' = 'Delivery Terms (Incoterms)');
ALTER TABLE `vibe_construction_v1`.`bid`.`vendor_quote` ALTER COLUMN `delivery_terms` SET TAGS ('pii_value_regex' = 'EXW|FCA|FOB|CIF|DDP|DAP');
ALTER TABLE `vibe_construction_v1`.`bid`.`vendor_quote` ALTER COLUMN `documents_attached` SET TAGS ('pii_business_glossary_term' = 'Attached Documents');
ALTER TABLE `vibe_construction_v1`.`bid`.`vendor_quote` ALTER COLUMN `evaluation_score` SET TAGS ('pii_business_glossary_term' = 'Evaluation Score');
ALTER TABLE `vibe_construction_v1`.`bid`.`vendor_quote` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_construction_v1`.`bid`.`vendor_quote` ALTER COLUMN `qualifications_and_deviations` SET TAGS ('pii_business_glossary_term' = 'Qualifications and Deviations');
ALTER TABLE `vibe_construction_v1`.`bid`.`vendor_quote` ALTER COLUMN `quantity` SET TAGS ('pii_business_glossary_term' = 'Quoted Quantity');
ALTER TABLE `vibe_construction_v1`.`bid`.`vendor_quote` ALTER COLUMN `quote_received_timestamp` SET TAGS ('pii_business_glossary_term' = 'Quote Received Timestamp');
ALTER TABLE `vibe_construction_v1`.`bid`.`vendor_quote` ALTER COLUMN `quote_reference` SET TAGS ('pii_business_glossary_term' = 'Quote Reference Number (QRN)');
ALTER TABLE `vibe_construction_v1`.`bid`.`vendor_quote` ALTER COLUMN `quote_validity_date` SET TAGS ('pii_business_glossary_term' = 'Quote Validity Date');
ALTER TABLE `vibe_construction_v1`.`bid`.`vendor_quote` ALTER COLUMN `quoted_amount` SET TAGS ('pii_business_glossary_term' = 'Quoted Amount (QA)');
ALTER TABLE `vibe_construction_v1`.`bid`.`vendor_quote` ALTER COLUMN `regulatory_approval_required` SET TAGS ('pii_business_glossary_term' = 'Regulatory Approval Required');
ALTER TABLE `vibe_construction_v1`.`bid`.`vendor_quote` ALTER COLUMN `regulatory_approval_status` SET TAGS ('pii_business_glossary_term' = 'Regulatory Approval Status');
ALTER TABLE `vibe_construction_v1`.`bid`.`vendor_quote` ALTER COLUMN `regulatory_approval_status` SET TAGS ('pii_value_regex' = 'pending|approved|rejected');
ALTER TABLE `vibe_construction_v1`.`bid`.`vendor_quote` ALTER COLUMN `scope_exclusions` SET TAGS ('pii_business_glossary_term' = 'Scope Exclusions');
ALTER TABLE `vibe_construction_v1`.`bid`.`vendor_quote` ALTER COLUMN `scope_inclusions` SET TAGS ('pii_business_glossary_term' = 'Scope Inclusions');
ALTER TABLE `vibe_construction_v1`.`bid`.`vendor_quote` ALTER COLUMN `scope_of_work` SET TAGS ('pii_business_glossary_term' = 'Scope of Work (SOW)');
ALTER TABLE `vibe_construction_v1`.`bid`.`vendor_quote` ALTER COLUMN `specification_reference` SET TAGS ('pii_business_glossary_term' = 'Specification Reference');
ALTER TABLE `vibe_construction_v1`.`bid`.`vendor_quote` ALTER COLUMN `total_quoted_value` SET TAGS ('pii_business_glossary_term' = 'Total Quoted Value (TQV)');
ALTER TABLE `vibe_construction_v1`.`bid`.`vendor_quote` ALTER COLUMN `trade_or_material_description` SET TAGS ('pii_business_glossary_term' = 'Trade or Material Description');
ALTER TABLE `vibe_construction_v1`.`bid`.`vendor_quote` ALTER COLUMN `unit_of_measure` SET TAGS ('pii_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `vibe_construction_v1`.`bid`.`vendor_quote` ALTER COLUMN `unit_price` SET TAGS ('pii_business_glossary_term' = 'Unit Price (UP)');
ALTER TABLE `vibe_construction_v1`.`bid`.`vendor_quote` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_construction_v1`.`bid`.`vendor_quote` ALTER COLUMN `vendor_quote_status` SET TAGS ('pii_business_glossary_term' = 'Quote Status (QS)');
ALTER TABLE `vibe_construction_v1`.`bid`.`vendor_quote` ALTER COLUMN `vendor_quote_status` SET TAGS ('pii_value_regex' = 'received|evaluated|accepted|rejected|expired');
ALTER TABLE `vibe_construction_v1`.`bid`.`vendor_quote` ALTER COLUMN `vendor_type` SET TAGS ('pii_business_glossary_term' = 'Vendor Type (VT)');
ALTER TABLE `vibe_construction_v1`.`bid`.`vendor_quote` ALTER COLUMN `vendor_type` SET TAGS ('pii_value_regex' = 'subcontractor|material_supplier|specialist_trade|plant_hire');
ALTER TABLE `vibe_construction_v1`.`bid`.`jv_partner` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_construction_v1`.`bid`.`jv_partner` SET TAGS ('pii_subdomain' = 'partner_qualification');
ALTER TABLE `vibe_construction_v1`.`bid`.`jv_partner` SET TAGS ('pii_required_structure' = 'v2');
ALTER TABLE `vibe_construction_v1`.`bid`.`jv_partner` SET TAGS ('pii_ecm_structure' = 'preserved_v2');
ALTER TABLE `vibe_construction_v1`.`bid`.`jv_partner` SET TAGS ('pii_structure_required' = 'true');
ALTER TABLE `vibe_construction_v1`.`bid`.`jv_partner` ALTER COLUMN `jv_partner_id` SET TAGS ('pii_business_glossary_term' = 'Joint Venture Partner Identifier (JV Partner ID)');
ALTER TABLE `vibe_construction_v1`.`bid`.`jv_partner` ALTER COLUMN `account_id` SET TAGS ('pii_business_glossary_term' = 'Account Id');
ALTER TABLE `vibe_construction_v1`.`bid`.`jv_partner` ALTER COLUMN `address_line1` SET TAGS ('pii_business_glossary_term' = 'Partner Address Line 1 (Address Line 1)');
ALTER TABLE `vibe_construction_v1`.`bid`.`jv_partner` ALTER COLUMN `address_line1` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`bid`.`jv_partner` ALTER COLUMN `address_line1` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_construction_v1`.`bid`.`jv_partner` ALTER COLUMN `address_line2` SET TAGS ('pii_business_glossary_term' = 'Partner Address Line 2 (Address Line 2)');
ALTER TABLE `vibe_construction_v1`.`bid`.`jv_partner` ALTER COLUMN `address_line2` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`bid`.`jv_partner` ALTER COLUMN `address_line2` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_construction_v1`.`bid`.`jv_partner` ALTER COLUMN `city` SET TAGS ('pii_business_glossary_term' = 'Partner City (City)');
ALTER TABLE `vibe_construction_v1`.`bid`.`jv_partner` ALTER COLUMN `city` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`bid`.`jv_partner` ALTER COLUMN `city` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_construction_v1`.`bid`.`jv_partner` ALTER COLUMN `country_code` SET TAGS ('pii_business_glossary_term' = 'Partner Country Code (Country Code)');
ALTER TABLE `vibe_construction_v1`.`bid`.`jv_partner` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Creation Timestamp (Created Timestamp)');
ALTER TABLE `vibe_construction_v1`.`bid`.`jv_partner` ALTER COLUMN `currency_code` SET TAGS ('pii_business_glossary_term' = 'Currency Code (Currency)');
ALTER TABLE `vibe_construction_v1`.`bid`.`jv_partner` ALTER COLUMN `equity_share_percent` SET TAGS ('pii_business_glossary_term' = 'Equity Share Percentage (Equity Share %)');
ALTER TABLE `vibe_construction_v1`.`bid`.`jv_partner` ALTER COLUMN `financial_capacity_amount` SET TAGS ('pii_business_glossary_term' = 'Financial Capacity Amount (Financial Capacity)');
ALTER TABLE `vibe_construction_v1`.`bid`.`jv_partner` ALTER COLUMN `jv_agreement_reference` SET TAGS ('pii_business_glossary_term' = 'Joint Venture Agreement Reference (JV Agreement Ref)');
ALTER TABLE `vibe_construction_v1`.`bid`.`jv_partner` ALTER COLUMN `mutator_note` SET TAGS ('pii_business_glossary_term' = 'Mutator Note');
ALTER TABLE `vibe_construction_v1`.`bid`.`jv_partner` ALTER COLUMN `jv_partner_name` SET TAGS ('pii_business_glossary_term' = 'Joint Venture Partner Name (JV Partner Name)');
ALTER TABLE `vibe_construction_v1`.`bid`.`jv_partner` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Additional Notes (Notes)');
ALTER TABLE `vibe_construction_v1`.`bid`.`jv_partner` ALTER COLUMN `partner_status` SET TAGS ('pii_business_glossary_term' = 'Partner Status (Partner Status)');
ALTER TABLE `vibe_construction_v1`.`bid`.`jv_partner` ALTER COLUMN `partner_status` SET TAGS ('pii_value_regex' = 'active|withdrawn|suspended');
ALTER TABLE `vibe_construction_v1`.`bid`.`jv_partner` ALTER COLUMN `partner_type` SET TAGS ('pii_business_glossary_term' = 'Joint Venture Partner Type (Partner Type)');
ALTER TABLE `vibe_construction_v1`.`bid`.`jv_partner` ALTER COLUMN `partner_type` SET TAGS ('pii_value_regex' = 'lead|junior|specialist');
ALTER TABLE `vibe_construction_v1`.`bid`.`jv_partner` ALTER COLUMN `past_project_references` SET TAGS ('pii_business_glossary_term' = 'Past Project References (Project References)');
ALTER TABLE `vibe_construction_v1`.`bid`.`jv_partner` ALTER COLUMN `prequalification_status` SET TAGS ('pii_business_glossary_term' = 'Prequalification Status (Prequalification Status)');
ALTER TABLE `vibe_construction_v1`.`bid`.`jv_partner` ALTER COLUMN `prequalification_status` SET TAGS ('pii_value_regex' = 'qualified|unqualified|pending');
ALTER TABLE `vibe_construction_v1`.`bid`.`jv_partner` ALTER COLUMN `primary_contact_email` SET TAGS ('pii_business_glossary_term' = 'Primary Contact Email Address (Primary Contact Email)');
ALTER TABLE `vibe_construction_v1`.`bid`.`jv_partner` ALTER COLUMN `primary_contact_email` SET TAGS ('pii_value_regex' = '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+.[A-Za-z]{2,}$');
ALTER TABLE `vibe_construction_v1`.`bid`.`jv_partner` ALTER COLUMN `primary_contact_email` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`bid`.`jv_partner` ALTER COLUMN `primary_contact_email` SET TAGS ('pii_email' = 'true');
ALTER TABLE `vibe_construction_v1`.`bid`.`jv_partner` ALTER COLUMN `primary_contact_name` SET TAGS ('pii_business_glossary_term' = 'Primary Contact Person Name (Primary Contact Name)');
ALTER TABLE `vibe_construction_v1`.`bid`.`jv_partner` ALTER COLUMN `primary_contact_name` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_construction_v1`.`bid`.`jv_partner` ALTER COLUMN `primary_contact_name` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_construction_v1`.`bid`.`jv_partner` ALTER COLUMN `primary_contact_phone` SET TAGS ('pii_business_glossary_term' = 'Primary Contact Phone Number (Primary Contact Phone)');
ALTER TABLE `vibe_construction_v1`.`bid`.`jv_partner` ALTER COLUMN `primary_contact_phone` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`bid`.`jv_partner` ALTER COLUMN `primary_contact_phone` SET TAGS ('pii_phone' = 'true');
ALTER TABLE `vibe_construction_v1`.`bid`.`jv_partner` ALTER COLUMN `role_in_jv` SET TAGS ('pii_business_glossary_term' = 'Role in Joint Venture (JV Role)');
ALTER TABLE `vibe_construction_v1`.`bid`.`jv_partner` ALTER COLUMN `role_in_jv` SET TAGS ('pii_value_regex' = 'lead|junior|specialist');
ALTER TABLE `vibe_construction_v1`.`bid`.`jv_partner` ALTER COLUMN `scope_of_work` SET TAGS ('pii_business_glossary_term' = 'Scope of Work Contribution (Scope of Work)');
ALTER TABLE `vibe_construction_v1`.`bid`.`jv_partner` ALTER COLUMN `state_province` SET TAGS ('pii_business_glossary_term' = 'Partner State or Province (State/Province)');
ALTER TABLE `vibe_construction_v1`.`bid`.`jv_partner` ALTER COLUMN `state_province` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`bid`.`jv_partner` ALTER COLUMN `state_province` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_construction_v1`.`bid`.`jv_partner` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Last Updated Timestamp (Updated Timestamp)');
ALTER TABLE `vibe_construction_v1`.`bid`.`approval` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_construction_v1`.`bid`.`approval` SET TAGS ('pii_subdomain' = 'pursuit_management');
ALTER TABLE `vibe_construction_v1`.`bid`.`approval` SET TAGS ('pii_required_structure' = 'v2');
ALTER TABLE `vibe_construction_v1`.`bid`.`approval` SET TAGS ('pii_ecm_structure' = 'preserved_v2');
ALTER TABLE `vibe_construction_v1`.`bid`.`approval` SET TAGS ('pii_ecm_reviewed' = 'true');
ALTER TABLE `vibe_construction_v1`.`bid`.`approval` SET TAGS ('pii_source' = 'vibe-batch');
ALTER TABLE `vibe_construction_v1`.`bid`.`approval` SET TAGS ('pii_structure_required' = 'true');
ALTER TABLE `vibe_construction_v1`.`bid`.`approval` ALTER COLUMN `approval_id` SET TAGS ('pii_business_glossary_term' = 'Bid Approval Identifier (BA_ID)');
ALTER TABLE `vibe_construction_v1`.`bid`.`approval` ALTER COLUMN `assessment_id` SET TAGS ('pii_business_glossary_term' = 'Compliance Assessment Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`bid`.`approval` ALTER COLUMN `pursuit_id` SET TAGS ('pii_business_glossary_term' = 'Bid Opportunity Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`bid`.`approval` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_business_glossary_term' = 'Approver Identifier (APPROVER_ID)');
ALTER TABLE `vibe_construction_v1`.`bid`.`approval` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`bid`.`approval` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_construction_v1`.`bid`.`approval` ALTER COLUMN `approval_number` SET TAGS ('pii_business_glossary_term' = 'Bid Approval Number (BAN)');
ALTER TABLE `vibe_construction_v1`.`bid`.`approval` ALTER COLUMN `approval_status` SET TAGS ('pii_business_glossary_term' = 'Approval Status (APP_STATUS)');
ALTER TABLE `vibe_construction_v1`.`bid`.`approval` ALTER COLUMN `approval_status` SET TAGS ('pii_value_regex' = 'pending|approved|rejected|deferred|conditional_approved');
ALTER TABLE `vibe_construction_v1`.`bid`.`approval` ALTER COLUMN `approved_bid_price` SET TAGS ('pii_business_glossary_term' = 'Approved Bid Price (APP_BID_PRICE)');
ALTER TABLE `vibe_construction_v1`.`bid`.`approval` ALTER COLUMN `approved_margin_pct` SET TAGS ('pii_business_glossary_term' = 'Approved Margin Percentage (APP_MARGIN_PCT)');
ALTER TABLE `vibe_construction_v1`.`bid`.`approval` ALTER COLUMN `bonding_capacity_score` SET TAGS ('pii_business_glossary_term' = 'Bonding Capacity Score (BC_SCORE)');
ALTER TABLE `vibe_construction_v1`.`bid`.`approval` ALTER COLUMN `client_relationship_score` SET TAGS ('pii_business_glossary_term' = 'Client Relationship Score (CR_SCORE)');
ALTER TABLE `vibe_construction_v1`.`bid`.`approval` ALTER COLUMN `conditions_imposed` SET TAGS ('pii_business_glossary_term' = 'Conditions Imposed (CONDITIONS)');
ALTER TABLE `vibe_construction_v1`.`bid`.`approval` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Creation Timestamp (CREATED_TS)');
ALTER TABLE `vibe_construction_v1`.`bid`.`approval` ALTER COLUMN `currency_code` SET TAGS ('pii_business_glossary_term' = 'Currency Code (ISO_CURRENCY_CODE)');
ALTER TABLE `vibe_construction_v1`.`bid`.`approval` ALTER COLUMN `deadline` SET TAGS ('pii_business_glossary_term' = 'Approval Deadline Date (APP_DEADLINE)');
ALTER TABLE `vibe_construction_v1`.`bid`.`approval` ALTER COLUMN `decision_authority_name` SET TAGS ('pii_business_glossary_term' = 'Decision Authority Name (DEC_AUTH_NAME)');
ALTER TABLE `vibe_construction_v1`.`bid`.`approval` ALTER COLUMN `decision_authority_name` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_construction_v1`.`bid`.`approval` ALTER COLUMN `decision_authority_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_construction_v1`.`bid`.`approval` ALTER COLUMN `decision_authority_role` SET TAGS ('pii_business_glossary_term' = 'Decision Authority Role (DEC_AUTH_ROLE)');
ALTER TABLE `vibe_construction_v1`.`bid`.`approval` ALTER COLUMN `decision_outcome` SET TAGS ('pii_business_glossary_term' = 'Decision Outcome (DEC_OUTCOME)');
ALTER TABLE `vibe_construction_v1`.`bid`.`approval` ALTER COLUMN `decision_rationale` SET TAGS ('pii_business_glossary_term' = 'Decision Rationale Narrative (DEC_RATIONALE)');
ALTER TABLE `vibe_construction_v1`.`bid`.`approval` ALTER COLUMN `decision_stage` SET TAGS ('pii_business_glossary_term' = 'Decision Stage (DEC_STAGE)');
ALTER TABLE `vibe_construction_v1`.`bid`.`approval` ALTER COLUMN `decision_stage` SET TAGS ('pii_value_regex' = 'bid_no_bid|estimate_review|commercial_review|risk_review|executive_signoff');
ALTER TABLE `vibe_construction_v1`.`bid`.`approval` ALTER COLUMN `decision_timestamp` SET TAGS ('pii_business_glossary_term' = 'Decision Timestamp (DECISION_TS)');
ALTER TABLE `vibe_construction_v1`.`bid`.`approval` ALTER COLUMN `delegation_of_authority_level` SET TAGS ('pii_business_glossary_term' = 'Delegation of Authority Level (DOA_LEVEL)');
ALTER TABLE `vibe_construction_v1`.`bid`.`approval` ALTER COLUMN `delegation_of_authority_level` SET TAGS ('pii_value_regex' = 'level_1|level_2|level_3|level_4');
ALTER TABLE `vibe_construction_v1`.`bid`.`approval` ALTER COLUMN `is_conditional` SET TAGS ('pii_business_glossary_term' = 'Is Conditional Approval (IS_CONDITIONAL)');
ALTER TABLE `vibe_construction_v1`.`bid`.`approval` ALTER COLUMN `margin_potential_score` SET TAGS ('pii_business_glossary_term' = 'Margin Potential Score (MP_SCORE)');
ALTER TABLE `vibe_construction_v1`.`bid`.`approval` ALTER COLUMN `pursuit_investment_justification` SET TAGS ('pii_business_glossary_term' = 'Pursuit Investment Justification (INVEST_JUST)');
ALTER TABLE `vibe_construction_v1`.`bid`.`approval` ALTER COLUMN `resource_availability_score` SET TAGS ('pii_business_glossary_term' = 'Resource Availability Score (RA_SCORE)');
ALTER TABLE `vibe_construction_v1`.`bid`.`approval` ALTER COLUMN `risk_profile_score` SET TAGS ('pii_business_glossary_term' = 'Risk Profile Score (RP_SCORE)');
ALTER TABLE `vibe_construction_v1`.`bid`.`approval` ALTER COLUMN `risk_rating` SET TAGS ('pii_business_glossary_term' = 'Risk Rating (RISK_RATING)');
ALTER TABLE `vibe_construction_v1`.`bid`.`approval` ALTER COLUMN `risk_rating` SET TAGS ('pii_value_regex' = 'low|medium|high|critical');
ALTER TABLE `vibe_construction_v1`.`bid`.`approval` ALTER COLUMN `strategic_fit_score` SET TAGS ('pii_business_glossary_term' = 'Strategic Fit Score (SF_SCORE)');
ALTER TABLE `vibe_construction_v1`.`bid`.`approval` ALTER COLUMN `total_governance_score` SET TAGS ('pii_business_glossary_term' = 'Total Governance Score (GOV_SCORE_TOTAL)');
ALTER TABLE `vibe_construction_v1`.`bid`.`approval` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Update Timestamp (UPDATED_TS)');
ALTER TABLE `vibe_construction_v1`.`bid`.`approval` ALTER COLUMN `valid_until` SET TAGS ('pii_business_glossary_term' = 'Approval Valid Until Date (APP_VALID_UNTIL)');
ALTER TABLE `vibe_construction_v1`.`bid`.`response` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_construction_v1`.`bid`.`response` SET TAGS ('pii_subdomain' = 'cost_estimating');
ALTER TABLE `vibe_construction_v1`.`bid`.`response` SET TAGS ('pii_required_structure' = 'v2');
ALTER TABLE `vibe_construction_v1`.`bid`.`response` SET TAGS ('pii_ecm_structure' = 'preserved_v2');
ALTER TABLE `vibe_construction_v1`.`bid`.`response` SET TAGS ('pii_ecm_reviewed' = 'true');
ALTER TABLE `vibe_construction_v1`.`bid`.`response` SET TAGS ('pii_source' = 'vibe-batch');
ALTER TABLE `vibe_construction_v1`.`bid`.`response` SET TAGS ('pii_structure_required' = 'true');
ALTER TABLE `vibe_construction_v1`.`bid`.`response` ALTER COLUMN `response_id` SET TAGS ('pii_business_glossary_term' = 'Response Identifier');
ALTER TABLE `vibe_construction_v1`.`bid`.`response` ALTER COLUMN `firm_profile_id` SET TAGS ('pii_business_glossary_term' = 'Subcontractor ID');
ALTER TABLE `vibe_construction_v1`.`bid`.`response` ALTER COLUMN `revised_response_id` SET TAGS ('pii_business_glossary_term' = 'Revised Response Id');
ALTER TABLE `vibe_construction_v1`.`bid`.`response` ALTER COLUMN `revised_response_id` SET TAGS ('pii_self_ref_fk' = 'true');
ALTER TABLE `vibe_construction_v1`.`bid`.`response` ALTER COLUMN `trade_package_id` SET TAGS ('pii_business_glossary_term' = 'Trade Package ID');
ALTER TABLE `vibe_construction_v1`.`bid`.`response` ALTER COLUMN `adjustment_amount` SET TAGS ('pii_business_glossary_term' = 'Bid Adjustment Amount');
ALTER TABLE `vibe_construction_v1`.`bid`.`response` ALTER COLUMN `award_currency` SET TAGS ('pii_business_glossary_term' = 'Award Currency Code');
ALTER TABLE `vibe_construction_v1`.`bid`.`response` ALTER COLUMN `award_currency` SET TAGS ('pii_value_regex' = 'USD|EUR|GBP|JPY|CAD|AUD');
ALTER TABLE `vibe_construction_v1`.`bid`.`response` ALTER COLUMN `award_date` SET TAGS ('pii_business_glossary_term' = 'Award Date');
ALTER TABLE `vibe_construction_v1`.`bid`.`response` ALTER COLUMN `award_value` SET TAGS ('pii_business_glossary_term' = 'Awarded Contract Value');
ALTER TABLE `vibe_construction_v1`.`bid`.`response` ALTER COLUMN `bid_amount` SET TAGS ('pii_business_glossary_term' = 'Bid Gross Amount');
ALTER TABLE `vibe_construction_v1`.`bid`.`response` ALTER COLUMN `bid_reference` SET TAGS ('pii_business_glossary_term' = 'Bid Reference Code');
ALTER TABLE `vibe_construction_v1`.`bid`.`response` ALTER COLUMN `bid_type` SET TAGS ('pii_business_glossary_term' = 'Bid Type');
ALTER TABLE `vibe_construction_v1`.`bid`.`response` ALTER COLUMN `bid_type` SET TAGS ('pii_value_regex' = 'lump_sum|line_item|unit_price');
ALTER TABLE `vibe_construction_v1`.`bid`.`response` ALTER COLUMN `bond_amount` SET TAGS ('pii_business_glossary_term' = 'Performance Bond Amount');
ALTER TABLE `vibe_construction_v1`.`bid`.`response` ALTER COLUMN `bond_required` SET TAGS ('pii_business_glossary_term' = 'Performance Bond Required Flag');
ALTER TABLE `vibe_construction_v1`.`bid`.`response` ALTER COLUMN `clarification_status` SET TAGS ('pii_business_glossary_term' = 'Clarification Status');
ALTER TABLE `vibe_construction_v1`.`bid`.`response` ALTER COLUMN `clarification_status` SET TAGS ('pii_value_regex' = 'none|requested|provided|pending');
ALTER TABLE `vibe_construction_v1`.`bid`.`response` ALTER COLUMN `commercial_ranking` SET TAGS ('pii_business_glossary_term' = 'Commercial Ranking');
ALTER TABLE `vibe_construction_v1`.`bid`.`response` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_construction_v1`.`bid`.`response` ALTER COLUMN `currency_code` SET TAGS ('pii_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_construction_v1`.`bid`.`response` ALTER COLUMN `currency_code` SET TAGS ('pii_value_regex' = 'USD|EUR|GBP|JPY|CAD|AUD');
ALTER TABLE `vibe_construction_v1`.`bid`.`response` ALTER COLUMN `insurance_coverage_amount` SET TAGS ('pii_business_glossary_term' = 'Required Insurance Coverage Amount');
ALTER TABLE `vibe_construction_v1`.`bid`.`response` ALTER COLUMN `insurance_required` SET TAGS ('pii_business_glossary_term' = 'Insurance Required Flag');
ALTER TABLE `vibe_construction_v1`.`bid`.`response` ALTER COLUMN `net_amount` SET TAGS ('pii_business_glossary_term' = 'Bid Net Amount');
ALTER TABLE `vibe_construction_v1`.`bid`.`response` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Bid Response Notes');
ALTER TABLE `vibe_construction_v1`.`bid`.`response` ALTER COLUMN `outcome` SET TAGS ('pii_business_glossary_term' = 'Bid Outcome');
ALTER TABLE `vibe_construction_v1`.`bid`.`response` ALTER COLUMN `outcome` SET TAGS ('pii_value_regex' = 'shortlisted|awarded|unsuccessful|withdrawn|pending');
ALTER TABLE `vibe_construction_v1`.`bid`.`response` ALTER COLUMN `payment_terms_days` SET TAGS ('pii_business_glossary_term' = 'Payment Terms (Days)');
ALTER TABLE `vibe_construction_v1`.`bid`.`response` ALTER COLUMN `response_status` SET TAGS ('pii_business_glossary_term' = 'Bid Status');
ALTER TABLE `vibe_construction_v1`.`bid`.`response` ALTER COLUMN `retention_percentage` SET TAGS ('pii_business_glossary_term' = 'Retention Percentage');
ALTER TABLE `vibe_construction_v1`.`bid`.`response` ALTER COLUMN `submission_timestamp` SET TAGS ('pii_business_glossary_term' = 'Bid Submission Timestamp');
ALTER TABLE `vibe_construction_v1`.`bid`.`response` ALTER COLUMN `technical_compliance_score` SET TAGS ('pii_business_glossary_term' = 'Technical Compliance Score');
ALTER TABLE `vibe_construction_v1`.`bid`.`response` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_construction_v1`.`bid`.`response` ALTER COLUMN `validity_end_date` SET TAGS ('pii_business_glossary_term' = 'Bid Validity End Date');
ALTER TABLE `vibe_construction_v1`.`bid`.`response` ALTER COLUMN `validity_start_date` SET TAGS ('pii_business_glossary_term' = 'Bid Validity Start Date');
ALTER TABLE `vibe_construction_v1`.`bid`.`bid_lien_waiver` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_construction_v1`.`bid`.`bid_lien_waiver` SET TAGS ('pii_subdomain' = 'payment_processing');
ALTER TABLE `vibe_construction_v1`.`bid`.`bid_lien_waiver` SET TAGS ('pii_required_structure' = 'v2');
ALTER TABLE `vibe_construction_v1`.`bid`.`bid_lien_waiver` SET TAGS ('pii_ecm_structure' = 'preserved_v2');
ALTER TABLE `vibe_construction_v1`.`bid`.`bid_lien_waiver` SET TAGS ('pii_structure_required' = 'true');
ALTER TABLE `vibe_construction_v1`.`bid`.`bid_lien_waiver` ALTER COLUMN `bid_lien_waiver_id` SET TAGS ('pii_business_glossary_term' = 'Lien Waiver ID');
ALTER TABLE `vibe_construction_v1`.`bid`.`bid_lien_waiver` ALTER COLUMN `firm_profile_id` SET TAGS ('pii_business_glossary_term' = 'Subcontractor ID');
ALTER TABLE `vibe_construction_v1`.`bid`.`bid_lien_waiver` ALTER COLUMN `bid_payment_application_id` SET TAGS ('pii_business_glossary_term' = 'Payment Application ID');
ALTER TABLE `vibe_construction_v1`.`bid`.`bid_lien_waiver` ALTER COLUMN `superseded_lien_waiver_id` SET TAGS ('pii_business_glossary_term' = 'Superseded Lien Waiver Id');
ALTER TABLE `vibe_construction_v1`.`bid`.`bid_lien_waiver` ALTER COLUMN `superseded_lien_waiver_id` SET TAGS ('pii_self_ref_fk' = 'true');
ALTER TABLE `vibe_construction_v1`.`bid`.`bid_lien_waiver` ALTER COLUMN `compliance_met` SET TAGS ('pii_business_glossary_term' = 'Compliance Met Flag');
ALTER TABLE `vibe_construction_v1`.`bid`.`bid_lien_waiver` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_construction_v1`.`bid`.`bid_lien_waiver` ALTER COLUMN `currency_code` SET TAGS ('pii_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_construction_v1`.`bid`.`bid_lien_waiver` ALTER COLUMN `document_url` SET TAGS ('pii_business_glossary_term' = 'Lien Waiver Document URL');
ALTER TABLE `vibe_construction_v1`.`bid`.`bid_lien_waiver` ALTER COLUMN `execution_date` SET TAGS ('pii_business_glossary_term' = 'Waiver Execution Date');
ALTER TABLE `vibe_construction_v1`.`bid`.`bid_lien_waiver` ALTER COLUMN `filing_date` SET TAGS ('pii_business_glossary_term' = 'Filing Date');
ALTER TABLE `vibe_construction_v1`.`bid`.`bid_lien_waiver` ALTER COLUMN `filing_reference` SET TAGS ('pii_business_glossary_term' = 'Filing Reference');
ALTER TABLE `vibe_construction_v1`.`bid`.`bid_lien_waiver` ALTER COLUMN `jurisdiction_state` SET TAGS ('pii_business_glossary_term' = 'Jurisdiction State');
ALTER TABLE `vibe_construction_v1`.`bid`.`bid_lien_waiver` ALTER COLUMN `notarization_date` SET TAGS ('pii_business_glossary_term' = 'Notarization Date');
ALTER TABLE `vibe_construction_v1`.`bid`.`bid_lien_waiver` ALTER COLUMN `notarization_status` SET TAGS ('pii_business_glossary_term' = 'Notarization Status');
ALTER TABLE `vibe_construction_v1`.`bid`.`bid_lien_waiver` ALTER COLUMN `notarization_status` SET TAGS ('pii_value_regex' = 'notarized|pending|not_notarized');
ALTER TABLE `vibe_construction_v1`.`bid`.`bid_lien_waiver` ALTER COLUMN `remarks` SET TAGS ('pii_business_glossary_term' = 'Remarks');
ALTER TABLE `vibe_construction_v1`.`bid`.`bid_lien_waiver` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_construction_v1`.`bid`.`bid_lien_waiver` ALTER COLUMN `waiver_amount` SET TAGS ('pii_business_glossary_term' = 'Lien Waiver Amount');
ALTER TABLE `vibe_construction_v1`.`bid`.`bid_lien_waiver` ALTER COLUMN `waiver_number` SET TAGS ('pii_business_glossary_term' = 'Lien Waiver Number');
ALTER TABLE `vibe_construction_v1`.`bid`.`bid_lien_waiver` ALTER COLUMN `waiver_status` SET TAGS ('pii_business_glossary_term' = 'Lien Waiver Status');
ALTER TABLE `vibe_construction_v1`.`bid`.`bid_lien_waiver` ALTER COLUMN `waiver_status` SET TAGS ('pii_value_regex' = 'pending|executed|rejected|void');
ALTER TABLE `vibe_construction_v1`.`bid`.`bid_lien_waiver` ALTER COLUMN `waiver_type` SET TAGS ('pii_business_glossary_term' = 'Lien Waiver Type');
ALTER TABLE `vibe_construction_v1`.`bid`.`bid_lien_waiver` ALTER COLUMN `waiver_type` SET TAGS ('pii_value_regex' = 'conditional|unconditional|progress|final');
ALTER TABLE `vibe_construction_v1`.`bid`.`bid_team_assignment` SET TAGS ('pii_data_type' = 'association_data');
ALTER TABLE `vibe_construction_v1`.`bid`.`bid_team_assignment` SET TAGS ('pii_subdomain' = 'pursuit_management');
ALTER TABLE `vibe_construction_v1`.`bid`.`bid_team_assignment` SET TAGS ('pii_association_edges' = 'bid.bid_opportunity,hr.employee');
ALTER TABLE `vibe_construction_v1`.`bid`.`bid_team_assignment` SET TAGS ('pii_required_structure' = 'v2');
ALTER TABLE `vibe_construction_v1`.`bid`.`bid_team_assignment` SET TAGS ('pii_ecm_structure' = 'preserved_v2');
ALTER TABLE `vibe_construction_v1`.`bid`.`bid_team_assignment` SET TAGS ('pii_structure_required' = 'true');
ALTER TABLE `vibe_construction_v1`.`bid`.`bid_team_assignment` ALTER COLUMN `bid_team_assignment_id` SET TAGS ('pii_business_glossary_term' = 'Bidteamassignment - Bid Team Assignment Id');
ALTER TABLE `vibe_construction_v1`.`bid`.`bid_team_assignment` ALTER COLUMN `pursuit_id` SET TAGS ('pii_business_glossary_term' = 'Bidteamassignment - Bid Opportunity Id');
ALTER TABLE `vibe_construction_v1`.`bid`.`bid_team_assignment` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_business_glossary_term' = 'Bidteamassignment - Employee Id');
ALTER TABLE `vibe_construction_v1`.`bid`.`bid_team_assignment` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`bid`.`bid_team_assignment` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_construction_v1`.`bid`.`bid_team_assignment` ALTER COLUMN `actual_hours` SET TAGS ('pii_business_glossary_term' = 'Actual Hours');
ALTER TABLE `vibe_construction_v1`.`bid`.`bid_team_assignment` ALTER COLUMN `allocation_pct` SET TAGS ('pii_business_glossary_term' = 'Allocation Pct');
ALTER TABLE `vibe_construction_v1`.`bid`.`bid_team_assignment` ALTER COLUMN `allocation_percent` SET TAGS ('pii_business_glossary_term' = 'Allocation Percent');
ALTER TABLE `vibe_construction_v1`.`bid`.`bid_team_assignment` ALTER COLUMN `allocation_percentage` SET TAGS ('pii_business_glossary_term' = 'Allocation Percentage');
ALTER TABLE `vibe_construction_v1`.`bid`.`bid_team_assignment` ALTER COLUMN `assigned_by` SET TAGS ('pii_business_glossary_term' = 'Assigned By');
ALTER TABLE `vibe_construction_v1`.`bid`.`bid_team_assignment` ALTER COLUMN `assigned_date` SET TAGS ('pii_business_glossary_term' = 'Assigned Date');
ALTER TABLE `vibe_construction_v1`.`bid`.`bid_team_assignment` ALTER COLUMN `assignment_end` SET TAGS ('pii_business_glossary_term' = 'Assignment End');
ALTER TABLE `vibe_construction_v1`.`bid`.`bid_team_assignment` ALTER COLUMN `assignment_role` SET TAGS ('pii_business_glossary_term' = 'Assignment Role');
ALTER TABLE `vibe_construction_v1`.`bid`.`bid_team_assignment` ALTER COLUMN `assignment_start` SET TAGS ('pii_business_glossary_term' = 'Assignment Start');
ALTER TABLE `vibe_construction_v1`.`bid`.`bid_team_assignment` ALTER COLUMN `assignment_status` SET TAGS ('pii_business_glossary_term' = 'Assignment Status');
ALTER TABLE `vibe_construction_v1`.`bid`.`bid_team_assignment` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_construction_v1`.`bid`.`bid_team_assignment` ALTER COLUMN `currency_code` SET TAGS ('pii_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_construction_v1`.`bid`.`bid_team_assignment` ALTER COLUMN `end_date` SET TAGS ('pii_business_glossary_term' = 'Assignment End Date');
ALTER TABLE `vibe_construction_v1`.`bid`.`bid_team_assignment` ALTER COLUMN `hourly_rate` SET TAGS ('pii_business_glossary_term' = 'Hourly Rate');
ALTER TABLE `vibe_construction_v1`.`bid`.`bid_team_assignment` ALTER COLUMN `is_lead` SET TAGS ('pii_business_glossary_term' = 'Is Lead');
ALTER TABLE `vibe_construction_v1`.`bid`.`bid_team_assignment` ALTER COLUMN `lead_flag` SET TAGS ('pii_business_glossary_term' = 'Lead Flag');
ALTER TABLE `vibe_construction_v1`.`bid`.`bid_team_assignment` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_construction_v1`.`bid`.`bid_team_assignment` ALTER COLUMN `planned_hours` SET TAGS ('pii_business_glossary_term' = 'Planned Hours');
ALTER TABLE `vibe_construction_v1`.`bid`.`bid_team_assignment` ALTER COLUMN `remarks` SET TAGS ('pii_business_glossary_term' = 'Remarks');
ALTER TABLE `vibe_construction_v1`.`bid`.`bid_team_assignment` ALTER COLUMN `responsibility_area` SET TAGS ('pii_business_glossary_term' = 'Responsibility Area');
ALTER TABLE `vibe_construction_v1`.`bid`.`bid_team_assignment` ALTER COLUMN `responsibility_description` SET TAGS ('pii_business_glossary_term' = 'Responsibility Description');
ALTER TABLE `vibe_construction_v1`.`bid`.`bid_team_assignment` ALTER COLUMN `role` SET TAGS ('pii_business_glossary_term' = 'Team Role');
ALTER TABLE `vibe_construction_v1`.`bid`.`bid_team_assignment` ALTER COLUMN `start_date` SET TAGS ('pii_business_glossary_term' = 'Assignment Start Date');
ALTER TABLE `vibe_construction_v1`.`bid`.`bid_team_assignment` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_construction_v1`.`bid`.`pursuit` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_construction_v1`.`bid`.`pursuit` SET TAGS ('pii_subdomain' = 'pursuit_management');
ALTER TABLE `vibe_construction_v1`.`bid`.`pursuit` SET TAGS ('pii_required_structure' = 'v2');
ALTER TABLE `vibe_construction_v1`.`bid`.`pursuit` SET TAGS ('pii_ecm_structure' = 'preserved_v2');
ALTER TABLE `vibe_construction_v1`.`bid`.`pursuit` SET TAGS ('pii_ssot' = 'true');
ALTER TABLE `vibe_construction_v1`.`bid`.`pursuit` SET TAGS ('pii_ssot_role' = 'master');
ALTER TABLE `vibe_construction_v1`.`bid`.`pursuit` SET TAGS ('pii_ssot_resolved_against' = 'client.client_opportunity');
ALTER TABLE `vibe_construction_v1`.`bid`.`pursuit` SET TAGS ('pii_ssot_counterpart' = 'client.client_opportunity');
ALTER TABLE `vibe_construction_v1`.`bid`.`pursuit` SET TAGS ('pii_structure_required' = 'true');
ALTER TABLE `vibe_construction_v1`.`bid`.`pursuit` SET TAGS ('pii_ssot_master' = 'true');
ALTER TABLE `vibe_construction_v1`.`bid`.`pursuit` ALTER COLUMN `pursuit_id` SET TAGS ('pii_business_glossary_term' = 'Bid Opportunity Identifier (BID_OPP_ID)');
ALTER TABLE `vibe_construction_v1`.`bid`.`pursuit` ALTER COLUMN `account_id` SET TAGS ('pii_business_glossary_term' = 'Client Identifier (CLIENT_ID)');
ALTER TABLE `vibe_construction_v1`.`bid`.`pursuit` ALTER COLUMN `cost_center_id` SET TAGS ('pii_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`bid`.`pursuit` ALTER COLUMN `jv_partner_id` SET TAGS ('pii_business_glossary_term' = 'Jv Partner Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`bid`.`pursuit` ALTER COLUMN `bid_bond_amount` SET TAGS ('pii_business_glossary_term' = 'Bid Bond Amount (BID_BOND_AMT)');
ALTER TABLE `vibe_construction_v1`.`bid`.`pursuit` ALTER COLUMN `bid_decision` SET TAGS ('pii_business_glossary_term' = 'Bid Decision (BID_DECISION)');
ALTER TABLE `vibe_construction_v1`.`bid`.`pursuit` ALTER COLUMN `bid_decision` SET TAGS ('pii_value_regex' = 'bid|no_bid');
ALTER TABLE `vibe_construction_v1`.`bid`.`pursuit` ALTER COLUMN `bid_due_date` SET TAGS ('pii_business_glossary_term' = 'Bid Due Date (BID_DUE_DATE)');
ALTER TABLE `vibe_construction_v1`.`bid`.`pursuit` ALTER COLUMN `client_opportunity_id` SET TAGS ('pii_business_glossary_term' = 'Client Opportunity Id');
ALTER TABLE `vibe_construction_v1`.`bid`.`pursuit` ALTER COLUMN `client_opportunity_id` SET TAGS ('pii_ssot_ref' = 'true');
ALTER TABLE `vibe_construction_v1`.`bid`.`pursuit` ALTER COLUMN `country_code` SET TAGS ('pii_business_glossary_term' = 'Country Code (COUNTRY_CODE)');
ALTER TABLE `vibe_construction_v1`.`bid`.`pursuit` ALTER COLUMN `country_code` SET TAGS ('pii_value_regex' = '[A-Z]{3}');
ALTER TABLE `vibe_construction_v1`.`bid`.`pursuit` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Creation Timestamp (CREATED_TS)');
ALTER TABLE `vibe_construction_v1`.`bid`.`pursuit` ALTER COLUMN `created_timestamp` SET TAGS ('pii_ssot_source' = 'client.client_opportunity');
ALTER TABLE `vibe_construction_v1`.`bid`.`pursuit` ALTER COLUMN `currency_code` SET TAGS ('pii_business_glossary_term' = 'Currency Code (CURR_CODE)');
ALTER TABLE `vibe_construction_v1`.`bid`.`pursuit` ALTER COLUMN `currency_code` SET TAGS ('pii_value_regex' = '[A-Z]{3}');
ALTER TABLE `vibe_construction_v1`.`bid`.`pursuit` ALTER COLUMN `currency_code` SET TAGS ('pii_ssot_source' = 'client.client_opportunity');
ALTER TABLE `vibe_construction_v1`.`bid`.`pursuit` ALTER COLUMN `discount_amount` SET TAGS ('pii_business_glossary_term' = 'Discount Amount (DISCOUNT_AMT)');
ALTER TABLE `vibe_construction_v1`.`bid`.`pursuit` ALTER COLUMN `estimated_contract_value` SET TAGS ('pii_business_glossary_term' = 'Estimated Contract Value (EST_CONTRACT_VAL)');
ALTER TABLE `vibe_construction_v1`.`bid`.`pursuit` ALTER COLUMN `estimated_contract_value` SET TAGS ('pii_ssot_source' = 'client.client_opportunity');
ALTER TABLE `vibe_construction_v1`.`bid`.`pursuit` ALTER COLUMN `expected_end_date` SET TAGS ('pii_business_glossary_term' = 'Expected End Date (EXP_END_DATE)');
ALTER TABLE `vibe_construction_v1`.`bid`.`pursuit` ALTER COLUMN `expected_start_date` SET TAGS ('pii_business_glossary_term' = 'Expected Start Date (EXP_START_DATE)');
ALTER TABLE `vibe_construction_v1`.`bid`.`pursuit` ALTER COLUMN `gmp_type` SET TAGS ('pii_business_glossary_term' = 'GMP Type (GMP_TYPE)');
ALTER TABLE `vibe_construction_v1`.`bid`.`pursuit` ALTER COLUMN `gmp_type` SET TAGS ('pii_value_regex' = 'gmp|lump_sum|cost_plus');
ALTER TABLE `vibe_construction_v1`.`bid`.`pursuit` ALTER COLUMN `is_joint_venture` SET TAGS ('pii_business_glossary_term' = 'Joint Venture Flag (IS_JV)');
ALTER TABLE `vibe_construction_v1`.`bid`.`pursuit` ALTER COLUMN `market_segment` SET TAGS ('pii_business_glossary_term' = 'Market Segment (MARKET_SEG)');
ALTER TABLE `vibe_construction_v1`.`bid`.`pursuit` ALTER COLUMN `market_segment` SET TAGS ('pii_value_regex' = 'infrastructure|energy|commercial|residential|industrial');
ALTER TABLE `vibe_construction_v1`.`bid`.`pursuit` ALTER COLUMN `net_estimated_value` SET TAGS ('pii_business_glossary_term' = 'Net Estimated Value (NET_EST_VAL)');
ALTER TABLE `vibe_construction_v1`.`bid`.`pursuit` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Additional Notes (NOTES)');
ALTER TABLE `vibe_construction_v1`.`bid`.`pursuit` ALTER COLUMN `opportunity_name` SET TAGS ('pii_business_glossary_term' = 'Opportunity Name (OPP_NAME)');
ALTER TABLE `vibe_construction_v1`.`bid`.`pursuit` ALTER COLUMN `opportunity_name` SET TAGS ('pii_ssot_source' = 'client.client_opportunity');
ALTER TABLE `vibe_construction_v1`.`bid`.`pursuit` ALTER COLUMN `opportunity_number` SET TAGS ('pii_business_glossary_term' = 'Opportunity Number (OPP_NO)');
ALTER TABLE `vibe_construction_v1`.`bid`.`pursuit` ALTER COLUMN `opportunity_number` SET TAGS ('pii_ssot_source' = 'client.client_opportunity');
ALTER TABLE `vibe_construction_v1`.`bid`.`pursuit` ALTER COLUMN `pipeline_forecast_category` SET TAGS ('pii_business_glossary_term' = 'Pipeline Forecast Category (PIPELINE_CAT)');
ALTER TABLE `vibe_construction_v1`.`bid`.`pursuit` ALTER COLUMN `pipeline_forecast_category` SET TAGS ('pii_value_regex' = 'pipeline|forecast|committed|won|lost');
ALTER TABLE `vibe_construction_v1`.`bid`.`pursuit` ALTER COLUMN `probability_of_win` SET TAGS ('pii_business_glossary_term' = 'Probability of Win (PROB_WIN)');
ALTER TABLE `vibe_construction_v1`.`bid`.`pursuit` ALTER COLUMN `project_type` SET TAGS ('pii_business_glossary_term' = 'Project Type (PROJECT_TYPE)');
ALTER TABLE `vibe_construction_v1`.`bid`.`pursuit` ALTER COLUMN `project_type` SET TAGS ('pii_value_regex' = 'highway|airport|bridge|power_plant|residential_development|commercial_building');
ALTER TABLE `vibe_construction_v1`.`bid`.`pursuit` ALTER COLUMN `project_type` SET TAGS ('pii_ssot_source' = 'client.client_opportunity');
ALTER TABLE `vibe_construction_v1`.`bid`.`pursuit` ALTER COLUMN `source_channel` SET TAGS ('pii_business_glossary_term' = 'Source Channel (SOURCE_CHAN)');
ALTER TABLE `vibe_construction_v1`.`bid`.`pursuit` ALTER COLUMN `source_channel` SET TAGS ('pii_value_regex' = 'salesforce|referral|partner|website|event');
ALTER TABLE `vibe_construction_v1`.`bid`.`pursuit` ALTER COLUMN `stage` SET TAGS ('pii_business_glossary_term' = 'Opportunity Stage (OPP_STAGE)');
ALTER TABLE `vibe_construction_v1`.`bid`.`pursuit` ALTER COLUMN `stage` SET TAGS ('pii_value_regex' = 'lead|qualified|proposal|submitted|awarded|lost');
ALTER TABLE `vibe_construction_v1`.`bid`.`pursuit` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Update Timestamp (UPDATED_TS)');
ALTER TABLE `vibe_construction_v1`.`bid`.`pursuit` ALTER COLUMN `win_loss_status` SET TAGS ('pii_business_glossary_term' = 'Win/Loss Status (WIN_LOSS_STATUS)');
ALTER TABLE `vibe_construction_v1`.`bid`.`pursuit` ALTER COLUMN `win_loss_status` SET TAGS ('pii_value_regex' = 'won|lost|withdrawn|pending');
ALTER TABLE `vibe_construction_v1`.`bid`.`bid_pricing_line` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_construction_v1`.`bid`.`bid_pricing_line` SET TAGS ('pii_subdomain' = 'tender_preparation');
ALTER TABLE `vibe_construction_v1`.`bid`.`bid_pricing_line` SET TAGS ('pii_required_structure' = 'v2');
ALTER TABLE `vibe_construction_v1`.`bid`.`bid_pricing_line` SET TAGS ('pii_ecm_structure' = 'preserved_v2');
ALTER TABLE `vibe_construction_v1`.`bid`.`bid_pricing_line` SET TAGS ('pii_ssot_role' = 'reference');
ALTER TABLE `vibe_construction_v1`.`bid`.`bid_pricing_line` SET TAGS ('pii_ssot_master' = 'material.material_boq_line');
ALTER TABLE `vibe_construction_v1`.`bid`.`bid_pricing_line` SET TAGS ('pii_ssot_resolved_against' = 'material.material_boq_line');
ALTER TABLE `vibe_construction_v1`.`bid`.`bid_pricing_line` SET TAGS ('pii_ssot_counterpart' = 'material.material_boq_line');
ALTER TABLE `vibe_construction_v1`.`bid`.`bid_pricing_line` SET TAGS ('pii_structure_required' = 'true');
ALTER TABLE `vibe_construction_v1`.`bid`.`bid_pricing_line` ALTER COLUMN `bid_pricing_line_id` SET TAGS ('pii_business_glossary_term' = 'BOQ Line ID');
ALTER TABLE `vibe_construction_v1`.`bid`.`bid_pricing_line` ALTER COLUMN `boq_id` SET TAGS ('pii_business_glossary_term' = 'Bill of Quantities ID');
ALTER TABLE `vibe_construction_v1`.`bid`.`bid_pricing_line` ALTER COLUMN `material_boq_line_id` SET TAGS ('pii_business_glossary_term' = 'Material Boq Line Id');
ALTER TABLE `vibe_construction_v1`.`bid`.`bid_pricing_line` ALTER COLUMN `material_boq_line_id` SET TAGS ('pii_ssot_reference' = 'true');
ALTER TABLE `vibe_construction_v1`.`bid`.`bid_pricing_line` ALTER COLUMN `sustainable_material_id` SET TAGS ('pii_business_glossary_term' = 'Sustainable Material Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`bid`.`bid_pricing_line` ALTER COLUMN `actual_completion_date` SET TAGS ('pii_business_glossary_term' = 'Actual Completion Date');
ALTER TABLE `vibe_construction_v1`.`bid`.`bid_pricing_line` ALTER COLUMN `bid_boq_line_description` SET TAGS ('pii_business_glossary_term' = 'Item Description');
ALTER TABLE `vibe_construction_v1`.`bid`.`bid_pricing_line` ALTER COLUMN `bid_boq_line_status` SET TAGS ('pii_business_glossary_term' = 'Line Status');
ALTER TABLE `vibe_construction_v1`.`bid`.`bid_pricing_line` ALTER COLUMN `bid_boq_line_status` SET TAGS ('pii_value_regex' = 'draft|submitted|approved|rejected|cancelled');
ALTER TABLE `vibe_construction_v1`.`bid`.`bid_pricing_line` ALTER COLUMN `change_order_flag` SET TAGS ('pii_business_glossary_term' = 'Change Order Flag');
ALTER TABLE `vibe_construction_v1`.`bid`.`bid_pricing_line` ALTER COLUMN `change_order_number` SET TAGS ('pii_business_glossary_term' = 'Change Order Number');
ALTER TABLE `vibe_construction_v1`.`bid`.`bid_pricing_line` ALTER COLUMN `change_order_number` SET TAGS ('pii_ssot_source' = 'material.material_boq_line');
ALTER TABLE `vibe_construction_v1`.`bid`.`bid_pricing_line` ALTER COLUMN `cost_category` SET TAGS ('pii_business_glossary_term' = 'Cost Category');
ALTER TABLE `vibe_construction_v1`.`bid`.`bid_pricing_line` ALTER COLUMN `cost_category` SET TAGS ('pii_value_regex' = 'direct|indirect|overhead|contingency');
ALTER TABLE `vibe_construction_v1`.`bid`.`bid_pricing_line` ALTER COLUMN `cost_center_code` SET TAGS ('pii_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `vibe_construction_v1`.`bid`.`bid_pricing_line` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_construction_v1`.`bid`.`bid_pricing_line` ALTER COLUMN `currency_code` SET TAGS ('pii_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_construction_v1`.`bid`.`bid_pricing_line` ALTER COLUMN `currency_code` SET TAGS ('pii_value_regex' = 'USD|EUR|GBP|JPY|CAD|AUD');
ALTER TABLE `vibe_construction_v1`.`bid`.`bid_pricing_line` ALTER COLUMN `estimated_completion_date` SET TAGS ('pii_business_glossary_term' = 'Estimated Completion Date');
ALTER TABLE `vibe_construction_v1`.`bid`.`bid_pricing_line` ALTER COLUMN `is_critical_path` SET TAGS ('pii_business_glossary_term' = 'Critical Path Flag');
ALTER TABLE `vibe_construction_v1`.`bid`.`bid_pricing_line` ALTER COLUMN `is_gmp_applicable` SET TAGS ('pii_business_glossary_term' = 'GMP Applicable');
ALTER TABLE `vibe_construction_v1`.`bid`.`bid_pricing_line` ALTER COLUMN `is_lump_sum` SET TAGS ('pii_business_glossary_term' = 'Lump Sum Applicable');
ALTER TABLE `vibe_construction_v1`.`bid`.`bid_pricing_line` ALTER COLUMN `is_taxable` SET TAGS ('pii_business_glossary_term' = 'Is Taxable');
ALTER TABLE `vibe_construction_v1`.`bid`.`bid_pricing_line` ALTER COLUMN `item_code` SET TAGS ('pii_business_glossary_term' = 'Item Code');
ALTER TABLE `vibe_construction_v1`.`bid`.`bid_pricing_line` ALTER COLUMN `labour_cost` SET TAGS ('pii_business_glossary_term' = 'Labour Cost');
ALTER TABLE `vibe_construction_v1`.`bid`.`bid_pricing_line` ALTER COLUMN `line_sequence` SET TAGS ('pii_business_glossary_term' = 'Line Sequence Number');
ALTER TABLE `vibe_construction_v1`.`bid`.`bid_pricing_line` ALTER COLUMN `line_sequence` SET TAGS ('pii_ssot_source' = 'material.material_boq_line');
ALTER TABLE `vibe_construction_v1`.`bid`.`bid_pricing_line` ALTER COLUMN `material_cost` SET TAGS ('pii_business_glossary_term' = 'Material Cost');
ALTER TABLE `vibe_construction_v1`.`bid`.`bid_pricing_line` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_construction_v1`.`bid`.`bid_pricing_line` ALTER COLUMN `overhead_amount` SET TAGS ('pii_business_glossary_term' = 'Overhead Allocation');
ALTER TABLE `vibe_construction_v1`.`bid`.`bid_pricing_line` ALTER COLUMN `plant_cost` SET TAGS ('pii_business_glossary_term' = 'Plant Cost');
ALTER TABLE `vibe_construction_v1`.`bid`.`bid_pricing_line` ALTER COLUMN `profit_margin_percent` SET TAGS ('pii_business_glossary_term' = 'Profit Margin (%)');
ALTER TABLE `vibe_construction_v1`.`bid`.`bid_pricing_line` ALTER COLUMN `quantity` SET TAGS ('pii_business_glossary_term' = 'Quantity');
ALTER TABLE `vibe_construction_v1`.`bid`.`bid_pricing_line` ALTER COLUMN `quantity` SET TAGS ('pii_ssot_source' = 'material.material_boq_line');
ALTER TABLE `vibe_construction_v1`.`bid`.`bid_pricing_line` ALTER COLUMN `revision_number` SET TAGS ('pii_business_glossary_term' = 'Revision Number');
ALTER TABLE `vibe_construction_v1`.`bid`.`bid_pricing_line` ALTER COLUMN `revision_number` SET TAGS ('pii_ssot_source' = 'material.material_boq_line');
ALTER TABLE `vibe_construction_v1`.`bid`.`bid_pricing_line` ALTER COLUMN `risk_level` SET TAGS ('pii_business_glossary_term' = 'Risk Level');
ALTER TABLE `vibe_construction_v1`.`bid`.`bid_pricing_line` ALTER COLUMN `risk_level` SET TAGS ('pii_value_regex' = 'low|medium|high');
ALTER TABLE `vibe_construction_v1`.`bid`.`bid_pricing_line` ALTER COLUMN `subcontract_cost` SET TAGS ('pii_business_glossary_term' = 'Subcontract Cost');
ALTER TABLE `vibe_construction_v1`.`bid`.`bid_pricing_line` ALTER COLUMN `tax_amount` SET TAGS ('pii_business_glossary_term' = 'Tax Amount');
ALTER TABLE `vibe_construction_v1`.`bid`.`bid_pricing_line` ALTER COLUMN `tax_rate` SET TAGS ('pii_business_glossary_term' = 'Tax Rate (%)');
ALTER TABLE `vibe_construction_v1`.`bid`.`bid_pricing_line` ALTER COLUMN `total_amount` SET TAGS ('pii_business_glossary_term' = 'Total Amount');
ALTER TABLE `vibe_construction_v1`.`bid`.`bid_pricing_line` ALTER COLUMN `unit_of_measure` SET TAGS ('pii_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `vibe_construction_v1`.`bid`.`bid_pricing_line` ALTER COLUMN `unit_of_measure` SET TAGS ('pii_ssot_source' = 'material.material_boq_line');
ALTER TABLE `vibe_construction_v1`.`bid`.`bid_pricing_line` ALTER COLUMN `unit_rate` SET TAGS ('pii_business_glossary_term' = 'Unit Rate (Currency per UOM)');
ALTER TABLE `vibe_construction_v1`.`bid`.`bid_pricing_line` ALTER COLUMN `unit_rate` SET TAGS ('pii_ssot_source' = 'material.material_boq_line');
ALTER TABLE `vibe_construction_v1`.`bid`.`bid_pricing_line` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_construction_v1`.`bid`.`bid_pricing_line` ALTER COLUMN `wbs_code` SET TAGS ('pii_business_glossary_term' = 'Work Breakdown Structure (WBS) Code');
ALTER TABLE `vibe_construction_v1`.`bid`.`bid_pricing_line` ALTER COLUMN `wbs_code` SET TAGS ('pii_ssot_source' = 'material.material_boq_line');
ALTER TABLE `vibe_construction_v1`.`bid`.`bid_pricing_line` ALTER COLUMN `work_section` SET TAGS ('pii_business_glossary_term' = 'Work Section');
ALTER TABLE `vibe_construction_v1`.`bid`.`pursuit_risk` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_construction_v1`.`bid`.`pursuit_risk` SET TAGS ('pii_subdomain' = 'pursuit_management');
ALTER TABLE `vibe_construction_v1`.`bid`.`pursuit_risk` SET TAGS ('pii_required_structure' = 'v2');
ALTER TABLE `vibe_construction_v1`.`bid`.`pursuit_risk` SET TAGS ('pii_ecm_structure' = 'preserved_v2');
ALTER TABLE `vibe_construction_v1`.`bid`.`pursuit_risk` SET TAGS ('pii_ssot_role' = 'reference');
ALTER TABLE `vibe_construction_v1`.`bid`.`pursuit_risk` SET TAGS ('pii_ssot_master' = 'schedule.schedule_risk');
ALTER TABLE `vibe_construction_v1`.`bid`.`pursuit_risk` SET TAGS ('pii_ssot_resolved_against' = 'schedule.schedule_risk');
ALTER TABLE `vibe_construction_v1`.`bid`.`pursuit_risk` SET TAGS ('pii_ssot' = 'bid.bid_risk');
ALTER TABLE `vibe_construction_v1`.`bid`.`pursuit_risk` SET TAGS ('pii_ssot_distinct' = 'true');
ALTER TABLE `vibe_construction_v1`.`bid`.`pursuit_risk` SET TAGS ('pii_ssot_scope' = 'bid');
ALTER TABLE `vibe_construction_v1`.`bid`.`pursuit_risk` SET TAGS ('pii_ssot_counterpart' = 'schedule.schedule_risk');
ALTER TABLE `vibe_construction_v1`.`bid`.`pursuit_risk` SET TAGS ('pii_structure_required' = 'true');
ALTER TABLE `vibe_construction_v1`.`bid`.`pursuit_risk` ALTER COLUMN `pursuit_risk_id` SET TAGS ('pii_business_glossary_term' = 'Bid Risk ID');
ALTER TABLE `vibe_construction_v1`.`bid`.`pursuit_risk` ALTER COLUMN `climate_risk_assessment_id` SET TAGS ('pii_business_glossary_term' = 'Climate Risk Assessment Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`bid`.`pursuit_risk` ALTER COLUMN `construction_project_id` SET TAGS ('pii_business_glossary_term' = 'Project Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`bid`.`pursuit_risk` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_business_glossary_term' = 'Owner Employee Id');
ALTER TABLE `vibe_construction_v1`.`bid`.`pursuit_risk` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_internal' = 'true');
ALTER TABLE `vibe_construction_v1`.`bid`.`pursuit_risk` ALTER COLUMN `permit_condition_id` SET TAGS ('pii_business_glossary_term' = 'Permit Condition Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`bid`.`pursuit_risk` ALTER COLUMN `primary_bid_employee_id` SET TAGS ('pii_business_glossary_term' = 'Risk Owner ID');
ALTER TABLE `vibe_construction_v1`.`bid`.`pursuit_risk` ALTER COLUMN `primary_bid_employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`bid`.`pursuit_risk` ALTER COLUMN `primary_bid_employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_construction_v1`.`bid`.`pursuit_risk` ALTER COLUMN `pursuit_bid_employee_id` SET TAGS ('pii_business_glossary_term' = 'Bid Employee Id');
ALTER TABLE `vibe_construction_v1`.`bid`.`pursuit_risk` ALTER COLUMN `pursuit_bid_employee_id` SET TAGS ('pii_internal' = 'true');
ALTER TABLE `vibe_construction_v1`.`bid`.`pursuit_risk` ALTER COLUMN `submission_id` SET TAGS ('pii_business_glossary_term' = 'Related Bid ID');
ALTER TABLE `vibe_construction_v1`.`bid`.`pursuit_risk` ALTER COLUMN `tender_id` SET TAGS ('pii_business_glossary_term' = 'Related Tender ID');
ALTER TABLE `vibe_construction_v1`.`bid`.`pursuit_risk` ALTER COLUMN `assessment_method` SET TAGS ('pii_business_glossary_term' = 'Risk Assessment Method');
ALTER TABLE `vibe_construction_v1`.`bid`.`pursuit_risk` ALTER COLUMN `assessment_method` SET TAGS ('pii_value_regex' = 'qualitative|quantitative|mixed');
ALTER TABLE `vibe_construction_v1`.`bid`.`pursuit_risk` ALTER COLUMN `attached_documents` SET TAGS ('pii_business_glossary_term' = 'Attached Documents');
ALTER TABLE `vibe_construction_v1`.`bid`.`pursuit_risk` ALTER COLUMN `bid_risk_status` SET TAGS ('pii_business_glossary_term' = 'Risk Status');
ALTER TABLE `vibe_construction_v1`.`bid`.`pursuit_risk` ALTER COLUMN `bid_risk_status` SET TAGS ('pii_value_regex' = 'identified|mitigated|closed|monitoring');
ALTER TABLE `vibe_construction_v1`.`bid`.`pursuit_risk` ALTER COLUMN `closed_date` SET TAGS ('pii_business_glossary_term' = 'Closed Date');
ALTER TABLE `vibe_construction_v1`.`bid`.`pursuit_risk` ALTER COLUMN `contingency_amount` SET TAGS ('pii_business_glossary_term' = 'Contingency Amount (USD)');
ALTER TABLE `vibe_construction_v1`.`bid`.`pursuit_risk` ALTER COLUMN `contingency_percentage` SET TAGS ('pii_business_glossary_term' = 'Contingency Percentage');
ALTER TABLE `vibe_construction_v1`.`bid`.`pursuit_risk` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_construction_v1`.`bid`.`pursuit_risk` ALTER COLUMN `created_timestamp` SET TAGS ('pii_ssot_source' = 'schedule.schedule_risk');
ALTER TABLE `vibe_construction_v1`.`bid`.`pursuit_risk` ALTER COLUMN `exposure_currency` SET TAGS ('pii_business_glossary_term' = 'Risk Exposure Currency');
ALTER TABLE `vibe_construction_v1`.`bid`.`pursuit_risk` ALTER COLUMN `identified_date` SET TAGS ('pii_business_glossary_term' = 'Identified Date');
ALTER TABLE `vibe_construction_v1`.`bid`.`pursuit_risk` ALTER COLUMN `impact_cost` SET TAGS ('pii_business_glossary_term' = 'Impact Cost (USD)');
ALTER TABLE `vibe_construction_v1`.`bid`.`pursuit_risk` ALTER COLUMN `impact_quality` SET TAGS ('pii_business_glossary_term' = 'Impact on Quality');
ALTER TABLE `vibe_construction_v1`.`bid`.`pursuit_risk` ALTER COLUMN `impact_quality` SET TAGS ('pii_value_regex' = 'low|medium|high');
ALTER TABLE `vibe_construction_v1`.`bid`.`pursuit_risk` ALTER COLUMN `impact_schedule_days` SET TAGS ('pii_business_glossary_term' = 'Impact Schedule (Days)');
ALTER TABLE `vibe_construction_v1`.`bid`.`pursuit_risk` ALTER COLUMN `is_key_risk` SET TAGS ('pii_business_glossary_term' = 'Key Risk Indicator');
ALTER TABLE `vibe_construction_v1`.`bid`.`pursuit_risk` ALTER COLUMN `mitigation_end_date` SET TAGS ('pii_business_glossary_term' = 'Mitigation End Date');
ALTER TABLE `vibe_construction_v1`.`bid`.`pursuit_risk` ALTER COLUMN `mitigation_start_date` SET TAGS ('pii_business_glossary_term' = 'Mitigation Start Date');
ALTER TABLE `vibe_construction_v1`.`bid`.`pursuit_risk` ALTER COLUMN `mitigation_strategy` SET TAGS ('pii_business_glossary_term' = 'Mitigation Strategy');
ALTER TABLE `vibe_construction_v1`.`bid`.`pursuit_risk` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Risk Notes');
ALTER TABLE `vibe_construction_v1`.`bid`.`pursuit_risk` ALTER COLUMN `origin` SET TAGS ('pii_business_glossary_term' = 'Risk Origin');
ALTER TABLE `vibe_construction_v1`.`bid`.`pursuit_risk` ALTER COLUMN `origin` SET TAGS ('pii_value_regex' = 'internal|external');
ALTER TABLE `vibe_construction_v1`.`bid`.`pursuit_risk` ALTER COLUMN `priority` SET TAGS ('pii_business_glossary_term' = 'Risk Priority');
ALTER TABLE `vibe_construction_v1`.`bid`.`pursuit_risk` ALTER COLUMN `priority` SET TAGS ('pii_value_regex' = 'low|medium|high|critical');
ALTER TABLE `vibe_construction_v1`.`bid`.`pursuit_risk` ALTER COLUMN `priority` SET TAGS ('pii_ssot_source' = 'schedule.schedule_risk');
ALTER TABLE `vibe_construction_v1`.`bid`.`pursuit_risk` ALTER COLUMN `probability_rating` SET TAGS ('pii_business_glossary_term' = 'Probability Rating');
ALTER TABLE `vibe_construction_v1`.`bid`.`pursuit_risk` ALTER COLUMN `probability_rating` SET TAGS ('pii_value_regex' = 'low|medium|high');
ALTER TABLE `vibe_construction_v1`.`bid`.`pursuit_risk` ALTER COLUMN `probability_rating` SET TAGS ('pii_ssot_source' = 'schedule.schedule_risk');
ALTER TABLE `vibe_construction_v1`.`bid`.`pursuit_risk` ALTER COLUMN `residual_impact_cost` SET TAGS ('pii_business_glossary_term' = 'Residual Impact Cost (USD)');
ALTER TABLE `vibe_construction_v1`.`bid`.`pursuit_risk` ALTER COLUMN `residual_probability` SET TAGS ('pii_business_glossary_term' = 'Residual Probability');
ALTER TABLE `vibe_construction_v1`.`bid`.`pursuit_risk` ALTER COLUMN `residual_probability` SET TAGS ('pii_value_regex' = 'low|medium|high');
ALTER TABLE `vibe_construction_v1`.`bid`.`pursuit_risk` ALTER COLUMN `residual_risk_score` SET TAGS ('pii_business_glossary_term' = 'Residual Risk Score');
ALTER TABLE `vibe_construction_v1`.`bid`.`pursuit_risk` ALTER COLUMN `review_frequency` SET TAGS ('pii_business_glossary_term' = 'Risk Review Frequency');
ALTER TABLE `vibe_construction_v1`.`bid`.`pursuit_risk` ALTER COLUMN `review_frequency` SET TAGS ('pii_value_regex' = 'weekly|monthly|quarterly|ad_hoc');
ALTER TABLE `vibe_construction_v1`.`bid`.`pursuit_risk` ALTER COLUMN `risk_category` SET TAGS ('pii_business_glossary_term' = 'Risk Category');
ALTER TABLE `vibe_construction_v1`.`bid`.`pursuit_risk` ALTER COLUMN `risk_category` SET TAGS ('pii_value_regex' = 'commercial|technical|geotechnical|regulatory|supply_chain|force_majeure');
ALTER TABLE `vibe_construction_v1`.`bid`.`pursuit_risk` ALTER COLUMN `risk_category` SET TAGS ('pii_ssot_source' = 'schedule.schedule_risk');
ALTER TABLE `vibe_construction_v1`.`bid`.`pursuit_risk` ALTER COLUMN `risk_code` SET TAGS ('pii_business_glossary_term' = 'Risk Code');
ALTER TABLE `vibe_construction_v1`.`bid`.`pursuit_risk` ALTER COLUMN `risk_description` SET TAGS ('pii_business_glossary_term' = 'Risk Description');
ALTER TABLE `vibe_construction_v1`.`bid`.`pursuit_risk` ALTER COLUMN `risk_description` SET TAGS ('pii_ssot_source' = 'schedule.schedule_risk');
ALTER TABLE `vibe_construction_v1`.`bid`.`pursuit_risk` ALTER COLUMN `schedule_risk_id` SET TAGS ('pii_business_glossary_term' = 'Schedule Risk Id');
ALTER TABLE `vibe_construction_v1`.`bid`.`pursuit_risk` ALTER COLUMN `schedule_risk_id` SET TAGS ('pii_ssot_reference' = 'true');
ALTER TABLE `vibe_construction_v1`.`bid`.`pursuit_risk` ALTER COLUMN `score` SET TAGS ('pii_business_glossary_term' = 'Risk Score');
ALTER TABLE `vibe_construction_v1`.`bid`.`pursuit_risk` ALTER COLUMN `score` SET TAGS ('pii_ssot_source' = 'schedule.schedule_risk');
ALTER TABLE `vibe_construction_v1`.`bid`.`pursuit_risk` ALTER COLUMN `title` SET TAGS ('pii_business_glossary_term' = 'Risk Title');
ALTER TABLE `vibe_construction_v1`.`bid`.`pursuit_risk` ALTER COLUMN `title` SET TAGS ('pii_ssot_source' = 'schedule.schedule_risk');
ALTER TABLE `vibe_construction_v1`.`bid`.`pursuit_risk` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_construction_v1`.`bid`.`pursuit_risk` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_ssot_source' = 'schedule.schedule_risk');
ALTER TABLE `vibe_construction_v1`.`bid`.`bidder_prequalification` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_construction_v1`.`bid`.`bidder_prequalification` SET TAGS ('pii_subdomain' = 'partner_qualification');
ALTER TABLE `vibe_construction_v1`.`bid`.`bidder_prequalification` SET TAGS ('pii_required_structure' = 'v2');
ALTER TABLE `vibe_construction_v1`.`bid`.`bidder_prequalification` SET TAGS ('pii_ecm_structure' = 'preserved_v2');
ALTER TABLE `vibe_construction_v1`.`bid`.`bidder_prequalification` SET TAGS ('pii_ssot_role' = 'reference');
ALTER TABLE `vibe_construction_v1`.`bid`.`bidder_prequalification` SET TAGS ('pii_ssot_master' = 'client.client_prequalification');
ALTER TABLE `vibe_construction_v1`.`bid`.`bidder_prequalification` SET TAGS ('pii_ssot_resolved_against' = 'client.client_prequalification');
ALTER TABLE `vibe_construction_v1`.`bid`.`bidder_prequalification` SET TAGS ('pii_ssot' = 'bid.bid_prequalification');
ALTER TABLE `vibe_construction_v1`.`bid`.`bidder_prequalification` SET TAGS ('pii_ssot_distinct' = 'true');
ALTER TABLE `vibe_construction_v1`.`bid`.`bidder_prequalification` SET TAGS ('pii_ssot_scope' = 'bid');
ALTER TABLE `vibe_construction_v1`.`bid`.`bidder_prequalification` SET TAGS ('pii_ssot_counterpart' = 'client.client_prequalification');
ALTER TABLE `vibe_construction_v1`.`bid`.`bidder_prequalification` SET TAGS ('pii_structure_required' = 'true');
ALTER TABLE `vibe_construction_v1`.`bid`.`bidder_prequalification` ALTER COLUMN `bidder_prequalification_id` SET TAGS ('pii_business_glossary_term' = 'Prequalification Record ID');
ALTER TABLE `vibe_construction_v1`.`bid`.`bidder_prequalification` ALTER COLUMN `account_id` SET TAGS ('pii_business_glossary_term' = 'Client ID');
ALTER TABLE `vibe_construction_v1`.`bid`.`bidder_prequalification` ALTER COLUMN `construction_project_id` SET TAGS ('pii_business_glossary_term' = 'Project ID');
ALTER TABLE `vibe_construction_v1`.`bid`.`bidder_prequalification` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_business_glossary_term' = 'Reviewer ID');
ALTER TABLE `vibe_construction_v1`.`bid`.`bidder_prequalification` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`bid`.`bidder_prequalification` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_construction_v1`.`bid`.`bidder_prequalification` ALTER COLUMN `jv_partner_id` SET TAGS ('pii_business_glossary_term' = 'Jv Partner Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`bid`.`bidder_prequalification` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('pii_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`bid`.`bidder_prequalification` ALTER COLUMN `bid_bond_amount` SET TAGS ('pii_business_glossary_term' = 'Bid Bond Amount');
ALTER TABLE `vibe_construction_v1`.`bid`.`bidder_prequalification` ALTER COLUMN `bid_bond_currency` SET TAGS ('pii_business_glossary_term' = 'Bid Bond Currency');
ALTER TABLE `vibe_construction_v1`.`bid`.`bidder_prequalification` ALTER COLUMN `bid_bond_expiry_date` SET TAGS ('pii_business_glossary_term' = 'Bid Bond Expiry Date');
ALTER TABLE `vibe_construction_v1`.`bid`.`bidder_prequalification` ALTER COLUMN `bid_bond_required` SET TAGS ('pii_business_glossary_term' = 'Bid Bond Required');
ALTER TABLE `vibe_construction_v1`.`bid`.`bidder_prequalification` ALTER COLUMN `bid_prequalification_status` SET TAGS ('pii_business_glossary_term' = 'Prequalification Status');
ALTER TABLE `vibe_construction_v1`.`bid`.`bidder_prequalification` ALTER COLUMN `bid_prequalification_status` SET TAGS ('pii_value_regex' = 'submitted|approved|conditionally_approved|rejected|expired');
ALTER TABLE `vibe_construction_v1`.`bid`.`bidder_prequalification` ALTER COLUMN `client_prequalification_id` SET TAGS ('pii_business_glossary_term' = 'Client Prequalification Id');
ALTER TABLE `vibe_construction_v1`.`bid`.`bidder_prequalification` ALTER COLUMN `client_prequalification_id` SET TAGS ('pii_ssot_reference' = 'true');
ALTER TABLE `vibe_construction_v1`.`bid`.`bidder_prequalification` ALTER COLUMN `confidentiality_flag` SET TAGS ('pii_business_glossary_term' = 'Confidentiality Flag');
ALTER TABLE `vibe_construction_v1`.`bid`.`bidder_prequalification` ALTER COLUMN `confidentiality_flag` SET TAGS ('pii_value_regex' = 'public|internal|confidential|restricted');
ALTER TABLE `vibe_construction_v1`.`bid`.`bidder_prequalification` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_construction_v1`.`bid`.`bidder_prequalification` ALTER COLUMN `created_timestamp` SET TAGS ('pii_ssot_source' = 'client.client_prequalification');
ALTER TABLE `vibe_construction_v1`.`bid`.`bidder_prequalification` ALTER COLUMN `documents_attached` SET TAGS ('pii_business_glossary_term' = 'Documents Attached Flag');
ALTER TABLE `vibe_construction_v1`.`bid`.`bidder_prequalification` ALTER COLUMN `effective_from` SET TAGS ('pii_business_glossary_term' = 'Effective From Date');
ALTER TABLE `vibe_construction_v1`.`bid`.`bidder_prequalification` ALTER COLUMN `effective_until` SET TAGS ('pii_business_glossary_term' = 'Effective Until Date');
ALTER TABLE `vibe_construction_v1`.`bid`.`bidder_prequalification` ALTER COLUMN `evaluation_score` SET TAGS ('pii_business_glossary_term' = 'Evaluation Score');
ALTER TABLE `vibe_construction_v1`.`bid`.`bidder_prequalification` ALTER COLUMN `expiry_date` SET TAGS ('pii_business_glossary_term' = 'Expiry Date');
ALTER TABLE `vibe_construction_v1`.`bid`.`bidder_prequalification` ALTER COLUMN `expiry_date` SET TAGS ('pii_ssot_source' = 'client.client_prequalification');
ALTER TABLE `vibe_construction_v1`.`bid`.`bidder_prequalification` ALTER COLUMN `financial_capacity_currency` SET TAGS ('pii_business_glossary_term' = 'Financial Capacity Currency');
ALTER TABLE `vibe_construction_v1`.`bid`.`bidder_prequalification` ALTER COLUMN `financial_capacity_threshold` SET TAGS ('pii_business_glossary_term' = 'Financial Capacity Threshold');
ALTER TABLE `vibe_construction_v1`.`bid`.`bidder_prequalification` ALTER COLUMN `hsse_performance_score` SET TAGS ('pii_business_glossary_term' = 'HSSE Performance Score');
ALTER TABLE `vibe_construction_v1`.`bid`.`bidder_prequalification` ALTER COLUMN `is_joint_venture` SET TAGS ('pii_business_glossary_term' = 'Is Joint Venture');
ALTER TABLE `vibe_construction_v1`.`bid`.`bidder_prequalification` ALTER COLUMN `last_review_date` SET TAGS ('pii_business_glossary_term' = 'Last Review Date');
ALTER TABLE `vibe_construction_v1`.`bid`.`bidder_prequalification` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Prequalification Notes');
ALTER TABLE `vibe_construction_v1`.`bid`.`bidder_prequalification` ALTER COLUMN `notes` SET TAGS ('pii_ssot_source' = 'client.client_prequalification');
ALTER TABLE `vibe_construction_v1`.`bid`.`bidder_prequalification` ALTER COLUMN `prequalification_category` SET TAGS ('pii_business_glossary_term' = 'Prequalification Category');
ALTER TABLE `vibe_construction_v1`.`bid`.`bidder_prequalification` ALTER COLUMN `prequalification_category` SET TAGS ('pii_value_regex' = 'general|specialized|joint_venture|subcontractor');
ALTER TABLE `vibe_construction_v1`.`bid`.`bidder_prequalification` ALTER COLUMN `procurement_category` SET TAGS ('pii_business_glossary_term' = 'Procurement Category');
ALTER TABLE `vibe_construction_v1`.`bid`.`bidder_prequalification` ALTER COLUMN `procurement_category` SET TAGS ('pii_value_regex' = 'materials|services|equipment|consultancy|subcontractor|other');
ALTER TABLE `vibe_construction_v1`.`bid`.`bidder_prequalification` ALTER COLUMN `procurement_category` SET TAGS ('pii_ssot_source' = 'client.client_prequalification');
ALTER TABLE `vibe_construction_v1`.`bid`.`bidder_prequalification` ALTER COLUMN `reference` SET TAGS ('pii_business_glossary_term' = 'Prequalification Reference');
ALTER TABLE `vibe_construction_v1`.`bid`.`bidder_prequalification` ALTER COLUMN `regulatory_approval_required` SET TAGS ('pii_business_glossary_term' = 'Regulatory Approval Required');
ALTER TABLE `vibe_construction_v1`.`bid`.`bidder_prequalification` ALTER COLUMN `regulatory_approval_status` SET TAGS ('pii_business_glossary_term' = 'Regulatory Approval Status');
ALTER TABLE `vibe_construction_v1`.`bid`.`bidder_prequalification` ALTER COLUMN `regulatory_approval_status` SET TAGS ('pii_value_regex' = 'pending|approved|rejected');
ALTER TABLE `vibe_construction_v1`.`bid`.`bidder_prequalification` ALTER COLUMN `risk_rating` SET TAGS ('pii_business_glossary_term' = 'Risk Rating');
ALTER TABLE `vibe_construction_v1`.`bid`.`bidder_prequalification` ALTER COLUMN `risk_rating` SET TAGS ('pii_value_regex' = 'low|medium|high');
ALTER TABLE `vibe_construction_v1`.`bid`.`bidder_prequalification` ALTER COLUMN `submission_date` SET TAGS ('pii_business_glossary_term' = 'Submission Date');
ALTER TABLE `vibe_construction_v1`.`bid`.`bidder_prequalification` ALTER COLUMN `submission_date` SET TAGS ('pii_ssot_source' = 'client.client_prequalification');
ALTER TABLE `vibe_construction_v1`.`bid`.`bidder_prequalification` ALTER COLUMN `technical_capacity_score` SET TAGS ('pii_business_glossary_term' = 'Technical Capacity Score');
ALTER TABLE `vibe_construction_v1`.`bid`.`bidder_prequalification` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_construction_v1`.`bid`.`bidder_prequalification` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_ssot_source' = 'client.client_prequalification');
ALTER TABLE `vibe_construction_v1`.`bid`.`bidder_prequalification` ALTER COLUMN `version_number` SET TAGS ('pii_business_glossary_term' = 'Version Number');
