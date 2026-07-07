-- Schema for Domain: project | Business: Construction | Version: v2_mvm
-- Generated on: 2026-06-27 01:56:04

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_construction_v1`.`project` COMMENT 'Core SSOT for all construction project lifecycle data from NTP through commissioning and handover. Owns project identity, WBS (Work Breakdown Structure), milestones, baseline scope, EVM metrics (CPI, SPI), deliverables, and project performance tracking. Central to EPC (Engineering Procurement Construction) execution and PMO (Project Management Office) governance across DB, DBB, and PPP delivery models.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_construction_v1`.`project`.`construction_project` (
    `construction_project_id` BIGINT COMMENT 'Unique surrogate identifier for a construction project record in the enterprise data platform. Primary key for the construction_project master entity.',
    `account_id` BIGINT COMMENT 'Reference to the client organisation that commissioned this project. Links to the client master entity for contract owner identification.',
    `company_code_id` BIGINT COMMENT 'Foreign key linking to finance.company_code. Business justification: Legal entity assignment: construction projects are executed under a specific legal entity (company code) for financial reporting, tax compliance, and intercompany accounting. This is fundamental for c',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to procurement.vendor. Business justification: Main EPC contractor assignment for each project; required for contract management, reporting, and regulatory compliance.',
    `master_services_agreement_id` BIGINT COMMENT 'Foreign key linking to client.master_services_agreement. Business justification: Projects executed under framework/MSA contracts must reference the governing MSA for call-off value tracking, retention terms, payment terms, and ceiling-value compliance reporting. Construction enter',
    `opportunity_id` BIGINT COMMENT 'Foreign key linking to client.client_opportunity. Business justification: Bid-to-project traceability: every awarded construction project originates from a won opportunity. This link enables pipeline-to-revenue conversion reporting, win-rate analysis, and bid cost recovery ',
    `actual_completion_date` DATE COMMENT 'Date on which the project achieved practical completion and was formally handed over to the client. Triggers the start of the DLP (Defects Liability Period) and final account settlement.',
    `actual_start_date` DATE COMMENT 'Date on which physical construction activities actually commenced on site. Recorded in Oracle Primavera P6 and Procore daily logs. May differ from NTP date due to mobilisation periods.',
    `approved_budget` DECIMAL(18,2) COMMENT 'Total approved project budget including all cost codes, contingency, and approved change orders (CO). Used as the control budget for EVM (Earned Value Management) and cost performance index (CPI) calculations in SAP S/4HANA Project Systems.',
    `bid_number` STRING COMMENT 'Reference number of the original bid or tender submission (RFP/RFQ) from which this project was awarded. Links project execution back to the pre-award opportunity in Salesforce CRM for win/loss analytics.',
    `city` STRING COMMENT 'City or municipality where the project site is located. Used for logistics planning, local regulatory compliance, and geographic analytics.',
    `contract_currency` STRING COMMENT 'ISO 4217 three-letter currency code for the contract value and all financial reporting on this project (e.g., USD, EUR, GBP, AED).. Valid values are `^[A-Z]{3}$`',
    `contract_number` STRING COMMENT 'Formal contract reference number as issued by the client or legal department. Used for contract administration, correspondence tracking in Aconex, and legal reference in all formal project documentation.',
    `contract_value` DECIMAL(18,2) COMMENT 'Original awarded contract value in the project currency as defined in the contract agreement. Baseline financial figure for budget control, EVM (Earned Value Management) calculations, and P&L (Profit and Loss) reporting.',
    `country_code` STRING COMMENT 'ISO 3166-1 alpha-3 country code for the country in which the project is physically located (e.g., USA, GBR, ARE, AUS). Used for regulatory compliance, HSE jurisdiction, and geographic reporting.. Valid values are `^[A-Z]{3}$`',
    `cpi` DECIMAL(18,2) COMMENT 'EVM (Earned Value Management) Cost Performance Index (CPI) calculated as Earned Value divided by Actual Cost. A CPI below 1.0 indicates cost overrun. Updated monthly from SAP S/4HANA Project Systems and Oracle Primavera P6 progress data.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the construction project record was first created in the enterprise data platform. Used for data lineage, audit trail, and record management compliance.',
    `delivery_model` STRING COMMENT 'Contractual and organisational delivery model under which the project is executed. EPC (Engineering Procurement Construction), DB (Design-Build), DBB (Design-Bid-Build), PPP (Public-Private Partnership), BOT (Build-Operate-Transfer), GMP (Guaranteed Maximum Price), JV (Joint Venture). Determines risk allocation, procurement strategy, and governance structure. [ENUM-REF-CANDIDATE: EPC|DB|DBB|PPP|BOT|GMP|JV — 7 candidates stripped; promote to reference product]',
    `dlp_end_date` DATE COMMENT 'Date on which the Defects Liability Period (DLP) expires, after which the contractors obligation to rectify defects at no cost to the client ceases. Calculated from actual completion date plus the contractual DLP duration.',
    `forecast_completion_date` DATE COMMENT 'Current forecast date for project completion based on latest schedule update and progress data from Oracle Primavera P6. Reflects approved EOT (Extension of Time) claims and current schedule performance.',
    `hse_risk_level` STRING COMMENT 'Overall HSE (Health Safety and Environment) risk classification for the project based on project type, location, scope complexity, and hazard profile. Determines the level of HSE oversight, inspection frequency, and SWMS (Safe Work Method Statement) requirements as managed in Intelex.. Valid values are `low|medium|high|critical`',
    `is_joint_venture` BOOLEAN COMMENT 'Indicates whether this project is being executed under a Joint Venture (JV) arrangement with one or more partner organisations. Affects financial consolidation, risk sharing, and governance reporting.',
    `jv_partner_share_pct` DECIMAL(18,2) COMMENT 'The companys ownership or participation percentage in the Joint Venture (JV) arrangement for this project. Used for financial consolidation, P&L (Profit and Loss) attribution, and EBITDA reporting. Null when is_joint_venture is False.',
    `leed_certification_target` STRING COMMENT 'Target LEED (Leadership in Energy and Environmental Design) certification level for the project as specified in the contract or client sustainability requirements. Drives design decisions, material procurement, and commissioning activities.. Valid values are `none|certified|silver|gold|platinum`',
    `liquidated_damages_rate` DECIMAL(18,2) COMMENT 'Contractual daily rate of Liquidated Damages (LD) payable to the client for each day of delay beyond the planned completion date. Critical for financial risk exposure calculation and schedule management prioritisation.',
    `ntp_date` DATE COMMENT 'Official date on which the Notice to Proceed (NTP) was issued by the client, authorising the contractor to commence construction activities. Marks the formal start of the project execution phase and is the baseline for schedule calculations in Oracle Primavera P6.',
    `physical_progress_pct` DECIMAL(18,2) COMMENT 'Overall physical percentage completion of the project as reported in the latest progress update from Oracle Primavera P6 and HCSS HeavyJob. Used for earned value calculations, client progress billing, and PMO dashboard reporting.',
    `planned_completion_date` DATE COMMENT 'Baseline planned completion date for the project as defined in the contract and approved schedule. Used for schedule variance analysis, LD (Liquidated Damages) exposure calculation, and EOT (Extension of Time) claim management.',
    `planned_start_date` DATE COMMENT 'Baseline planned start date for project execution as established in the approved project schedule in Oracle Primavera P6. Used for SPI (Schedule Performance Index) variance analysis.',
    `pmo_classification` STRING COMMENT 'PMO (Project Management Office) tier classification that determines the level of governance, reporting frequency, and executive oversight applied to the project. Tier 1 projects receive the highest level of PMO scrutiny.. Valid values are `tier_1|tier_2|tier_3|strategic|standard`',
    `primavera_project_reference` STRING COMMENT 'Native project identifier in Oracle Primavera P6 scheduling system. Used for cross-system data integration between the enterprise data platform and the scheduling system of record for activity, resource, and baseline data.',
    `procore_project_reference` STRING COMMENT 'Native project identifier in Procore construction management platform. Used for cross-system integration to retrieve daily logs, RFIs (Requests for Information), submittals, change orders, and drawing management data.',
    `project_code` STRING COMMENT 'Externally-known alphanumeric project identifier used across Oracle Primavera P6, SAP S/4HANA Project Systems, and Procore. Serves as the cross-system business key for project identification in all operational and financial systems.. Valid values are `^[A-Z0-9-]{4,20}$`',
    `project_name` STRING COMMENT 'Full descriptive name of the construction project as agreed with the client and used in all formal correspondence, contracts, and reporting.',
    `project_status` STRING COMMENT 'Current lifecycle state of the construction project from prospect through to completion or cancellation. Drives PMO governance workflows and financial reporting eligibility.. Valid values are `prospect|awarded|active|on_hold|completed|cancelled`',
    `project_type` STRING COMMENT 'Classification of the construction project by sector or asset class. Determines applicable standards, certification requirements, and typical duration/value benchmarks used in PMO reporting. [ENUM-REF-CANDIDATE: infrastructure|commercial|residential|energy|industrial|transport|water|healthcare|education|mixed_use — promote to reference product]. Valid values are `infrastructure|commercial|residential|energy|industrial`',
    `region` STRING COMMENT 'Internal geographic region or business unit region where the project is located (e.g., North America, Middle East, Asia Pacific, Europe). Used for PMO regional portfolio reporting and resource allocation.',
    `retention_pct` DECIMAL(18,2) COMMENT 'Contractual retention percentage withheld by the client from each progress payment certificate. Typically released in two tranches: at practical completion and at DLP (Defects Liability Period) expiry. Used in cash flow forecasting.',
    `sap_project_definition` STRING COMMENT 'SAP S/4HANA Project Systems project definition code (PS-DEF) that serves as the root WBS element for all cost postings, purchase orders, and financial transactions related to this project in the ERP system.',
    `site_latitude` DECIMAL(18,2) COMMENT 'Geographic latitude coordinate of the primary project site in decimal degrees (WGS84). Used for GIS (Geographic Information System) mapping, logistics routing, and environmental impact assessments.',
    `site_longitude` DECIMAL(18,2) COMMENT 'Geographic longitude coordinate of the primary project site in decimal degrees (WGS84). Used for GIS (Geographic Information System) mapping, logistics routing, and environmental impact assessments.',
    `spi` DECIMAL(18,2) COMMENT 'EVM (Earned Value Management) Schedule Performance Index (SPI) calculated as Earned Value divided by Planned Value. An SPI below 1.0 indicates schedule delay. Updated monthly from Oracle Primavera P6 progress reporting.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the construction project record in the enterprise data platform. Used for change tracking, data freshness monitoring, and incremental data pipeline processing.',
    `wbs_code` STRING COMMENT 'Top-level WBS (Work Breakdown Structure) code assigned to this project in Oracle Primavera P6 and SAP S/4HANA Project Systems. Serves as the hierarchical cost and schedule control framework root for all project activities.',
    CONSTRAINT pk_construction_project PRIMARY KEY(`construction_project_id`)
) COMMENT 'Core master entity representing a construction project from NTP (Notice to Proceed) through commissioning and handover. Owns project identity, delivery model (EPC, DB, DBB, PPP, BOT), project type (infrastructure, commercial, residential, energy, industrial), contract value, project status, geographic location, client reference, PMO classification, project type classification (typical duration/value ranges, required certifications, sector), and key lifecycle dates. SSOT for all project-level identity, metadata, and classification across the enterprise.';

CREATE OR REPLACE TABLE `vibe_construction_v1`.`project`.`wbs_element` (
    `wbs_element_id` BIGINT COMMENT 'Unique surrogate identifier for the WBS element record in the silver layer lakehouse. Primary key for this entity.',
    `cost_code_id` BIGINT COMMENT 'Foreign key linking to finance.cost_code. Business justification: Required for cost‑coding WBS elements in EVM and budget reports; experts assign a cost code to each WBS element for financial tracking.',
    `master_id` BIGINT COMMENT 'Foreign key linking to material.material_master. Business justification: Needed for WBS Cost Estimation to identify the primary material type for each work package.',
    `parent_wbs_element_id` BIGINT COMMENT 'Self-referencing identifier pointing to the immediate parent WBS node, enabling hierarchical decomposition of project scope. Null for root-level WBS elements.',
    `actual_cost` DECIMAL(18,2) COMMENT 'Total actual costs incurred to date for this WBS element, sourced from SAP S/4HANA job costing and Viewpoint Vista. Used as the ACWP input in EVM calculations.',
    `actual_finish_date` DATE COMMENT 'Date on which work on this WBS element was physically completed, as recorded in Oracle Primavera P6. Null if work is still in progress. Used for schedule performance reporting and DLP (Defects Liability Period) trigger.',
    `actual_quantity` DECIMAL(18,2) COMMENT 'Actual quantity of work completed and installed to date for this WBS element, as recorded in HCSS HeavyJob field production tracking. Compared against planned_quantity for production performance analysis.',
    `actual_start_date` DATE COMMENT 'Date on which work on this WBS element actually commenced on site, as recorded in Oracle Primavera P6 or Procore daily logs. Used to calculate schedule variance and Extension of Time (EOT) claims.',
    `approved_budget_changes` DECIMAL(18,2) COMMENT 'Cumulative value of approved Change Orders (CO) that have modified the original budget for this WBS element. Reconciles original_budget_cost to budgeted_cost.',
    `boq_item_reference` STRING COMMENT 'Reference number or code linking this WBS element to the corresponding Bill of Quantities (BOQ) line item in the contract. Enables traceability between scope decomposition and contract pricing.',
    `budgeted_cost` DECIMAL(18,2) COMMENT 'Total approved budget allocated to this WBS element, representing the Budget at Completion (BAC) for EVM purposes. Expressed in the project currency. Forms the baseline for CPI and SPI calculations.',
    `charge_type` STRING COMMENT 'Classification of costs associated with this WBS element: direct (billable to project scope), indirect (overhead allocation), overhead, contingency (risk reserve), or provisional (BOQ provisional sum). Affects cost reporting and contract billing.. Valid values are `direct|indirect|overhead|contingency|provisional`',
    `cost_account_code` STRING COMMENT 'Cost account or cost code assigned to this WBS element for job costing and financial reporting in SAP S/4HANA and Viewpoint Vista. Maps WBS scope to the chart of accounts for P&L reporting.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this WBS element record was first created in the source system or lakehouse. Used for audit trail and data lineage tracking.',
    `csi_division_code` STRING COMMENT 'CSI MasterFormat division code classifying the type of construction work for this WBS element (e.g., 03 = Concrete, 05 = Metals, 26 = Electrical). Enables industry-standard scope classification and benchmarking.. Valid values are `^[0-9]{2}$`',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary values on this WBS element (e.g., USD, EUR, GBP, AED). Supports multi-currency EPC projects and financial consolidation.. Valid values are `^[A-Z]{3}$`',
    `delivery_model` STRING COMMENT 'Contract delivery model under which this WBS element is executed: EPC (Engineering Procurement Construction), DB (Design-Build), DBB (Design-Bid-Build), PPP (Public-Private Partnership), BOT (Build-Operate-Transfer), or GMP (Guaranteed Maximum Price). Affects cost control and contract administration rules.. Valid values are `EPC|DB|DBB|PPP|BOT|GMP`',
    `earned_value` DECIMAL(18,2) COMMENT 'Budgeted cost of work actually performed to date for this WBS element (BCWP). Calculated as percent_complete multiplied by budgeted_cost. Core EVM metric used to derive CPI and SPI at the WBS level.',
    `evm_enabled` BOOLEAN COMMENT 'Flag indicating whether this WBS element is included in the projects EVM (Earned Value Management) performance measurement baseline. Summary and planning package nodes may be excluded from direct EVM measurement.',
    `forecast_finish_date` DATE COMMENT 'Current forecast completion date for this WBS element based on progress to date and remaining work, as updated in Oracle Primavera P6. Used for schedule recovery planning and LD exposure monitoring.',
    `is_lump_sum` BOOLEAN COMMENT 'Flag indicating whether this WBS element is priced as a lump sum (fixed price) rather than a re-measurable unit-rate item. Affects billing, change order valuation, and BOQ reconciliation.',
    `is_milestone` BOOLEAN COMMENT 'Flag indicating whether this WBS element represents a contractual or project milestone (e.g., NTP, substantial completion, handover). Milestone WBS elements trigger payment certificates and schedule reporting.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to this WBS element record, either in the source system or during lakehouse processing. Supports incremental data loading and change detection.',
    `original_budget_cost` DECIMAL(18,2) COMMENT 'The initial approved budget for this WBS element at project baseline, before any approved change orders or budget transfers. Enables variance analysis between original and current budget.',
    `percent_complete` DECIMAL(18,2) COMMENT 'Current physical percent complete of the WBS element, representing the proportion of scope delivered to date. Used as the primary EVM progress measurement input. Range: 0.00 to 100.00.',
    `percent_complete_method` STRING COMMENT 'Method used to calculate percent complete for EVM purposes: physical (field measurement), units_complete (quantity-based), duration (time-proportional), weighted_milestone, level_of_effort, or fixed_formula (e.g., 0/100, 50/50). Configured in Oracle Primavera P6.. Valid values are `physical|units_complete|duration|weighted_milestone|level_of_effort|fixed_formula`',
    `planned_finish_date` DATE COMMENT 'Baseline planned finish date for this WBS element as established in the approved project schedule. Used for schedule variance analysis, milestone tracking, and Liquidated Damages (LD) exposure assessment.',
    `planned_quantity` DECIMAL(18,2) COMMENT 'Total planned quantity of work for this WBS element as defined in the Bill of Quantities (BOQ) or Material Take-Off (MTO). Used for production tracking and unit-rate cost control in HCSS HeavyJob.',
    `planned_start_date` DATE COMMENT 'Baseline planned start date for this WBS element as established in the approved project schedule in Oracle Primavera P6. Used for schedule variance analysis and CPM scheduling.',
    `planned_value` DECIMAL(18,2) COMMENT 'Budgeted cost of work scheduled to be completed by the data date for this WBS element (BCWS). Derived from the time-phased budget baseline in Primavera P6. Used to compute Schedule Variance (SV) in EVM.',
    `responsible_discipline` STRING COMMENT 'Engineering or construction discipline accountable for executing this WBS element (e.g., Civil, Structural, MEP, Electrical, Mechanical, Instrumentation). Used for resource planning and discipline-level cost reporting.',
    `scope_description` STRING COMMENT 'Detailed narrative description of the work scope, deliverables, and boundaries associated with this WBS element. Aligns with the projects Statement of Work (SOW) and Bill of Quantities (BOQ) scope definitions.',
    `sort_order` STRING COMMENT 'Numeric sequence defining the display order of this WBS element among its siblings within the same parent node. Used for consistent rendering in schedules, reports, and BOQ documents.',
    `source_system_wbs_reference` STRING COMMENT 'Native identifier of this WBS element in the originating operational system (e.g., Primavera P6 WBS Object ID, SAP PS WBS Element internal number). Supports data lineage and reconciliation between the lakehouse and source systems.',
    `unit_of_measure` STRING COMMENT 'Unit of measure for planned and actual quantities on this WBS element (e.g., m3, m2, LF, EA, TON, LS, HR). Aligns with BOQ and MTO unit conventions. [ENUM-REF-CANDIDATE: m3|m2|LF|EA|TON|LS|HR|KG|ML|CY — promote to reference product]',
    `wbs_code` STRING COMMENT 'Structured alphanumeric code representing the WBS node position in the hierarchy (e.g., 1.2.3.4). Used as the externally-known identifier in Primavera P6, SAP PS, and project documentation. Conforms to project WBS coding convention.. Valid values are `^[A-Z0-9]+(.[A-Z0-9]+)*$`',
    `wbs_level` STRING COMMENT 'Integer depth of the WBS node within the project hierarchy (Level 1 = project root, Level 2 = major deliverable, Level 3+ = sub-deliverable or work package). Used for hierarchical filtering, rollup aggregation, and reporting drill-down.',
    `wbs_name` STRING COMMENT 'Human-readable name or title of the WBS element describing the scope deliverable or work package (e.g., Substructure Works, Electrical Installation – Level 3). Used in reports, dashboards, and EVM analysis.',
    `wbs_status` STRING COMMENT 'Current lifecycle status of the WBS element indicating whether work is active, not yet started, on hold, completed, or cancelled. Drives EVM eligibility and cost control reporting.. Valid values are `active|on_hold|completed|cancelled|not_started`',
    `wbs_type` STRING COMMENT 'Classification of the WBS node by its role in the hierarchy: summary (rollup node), work_package (lowest deliverable-level node), control_account (EVM measurement point), or planning_package (future scope not yet detailed). Drives EVM rollup logic and cost control granularity.. Valid values are `summary|work_package|control_account|planning_package`',
    CONSTRAINT pk_wbs_element PRIMARY KEY(`wbs_element_id`)
) COMMENT 'Work Breakdown Structure (WBS) node representing a decomposed scope element within a construction project. Captures WBS code, level, parent-child hierarchy, scope description, responsible discipline, budgeted cost, planned quantity, unit of measure, and WBS type (summary, work package, control account). Supports EVM (Earned Value Management) rollup and cost control at granular scope levels.';

CREATE OR REPLACE TABLE `vibe_construction_v1`.`project`.`milestone` (
    `milestone_id` BIGINT COMMENT 'Unique surrogate identifier for each project milestone record in the Construction lakehouse Silver layer. Primary key for the project_milestone data product.',
    `construction_project_id` BIGINT COMMENT 'Reference to the parent construction project to which this milestone belongs. Links the milestone to the core project master record.',
    `permit_to_work_id` BIGINT COMMENT 'Foreign key linking to safety.permit_to_work. Business justification: Certain contractual milestones require a valid permit to work before work can commence (hot work, confined space entry, energisation milestones). project_milestone has hse_clearance_required flag but ',
    `phase_id` BIGINT COMMENT 'Foreign key linking to project.phase. Business justification: Milestones are organized within project phases — NTP milestone belongs to pre-construction phase, substantial completion belongs to construction phase. Linking project_milestone to phase enables phase',
    `predecessor_milestone_project_milestone_id` BIGINT COMMENT 'Reference to the immediately preceding milestone in the project schedule logic chain. Supports Critical Path Method (CPM) analysis and schedule dependency tracking within the milestone network.',
    `project_baseline_id` BIGINT COMMENT 'Foreign key linking to project.project_baseline. Business justification: Milestone baseline dates are established as part of the approved project baseline. The baseline_date field on project_milestone is derived from the baseline schedule. Linking project_milestone to proj',
    `wbs_element_id` BIGINT COMMENT 'Reference to the Work Breakdown Structure (WBS) element under which this milestone is classified. Enables milestone tracking at the WBS decomposition level within the project schedule.',
    `acceptance_criteria` STRING COMMENT 'Formal criteria that must be satisfied for the milestone to be considered achieved and accepted by the client or engineer. May reference ITP (Inspection and Test Plan) requirements, regulatory sign-offs, or contractual deliverable submissions.',
    `actual_date` DATE COMMENT 'The date on which the milestone was formally achieved and accepted. Populated only upon milestone completion and sign-off. Used for schedule variance calculation, contract administration, and LD (Liquidated Damages) trigger assessment.',
    `baseline_date` DATE COMMENT 'Approved contract baseline date for the milestone, which may differ from the original planned date if a formal baseline revision or approved EOT (Extension of Time) has been incorporated. Used as the contractual reference for LD (Liquidated Damages) exposure calculation.',
    `milestone_category` STRING COMMENT 'Functional category grouping the milestone within the EPC (Engineering, Procurement, and Construction) project lifecycle phase. Supports schedule performance analysis by phase and PMO reporting. [ENUM-REF-CANDIDATE: design|procurement|construction|commissioning|handover|safety|financial|administrative — promote to reference product]',
    `milestone_code` STRING COMMENT 'Externally-known alphanumeric code uniquely identifying the milestone within the project schedule, as assigned in Oracle Primavera P6 (e.g., MS-NTP001, MS-MC001). Used for cross-system referencing and contract administration.. Valid values are `^MS-[A-Z0-9]{3,20}$`',
    `completion_percentage` DECIMAL(18,2) COMMENT 'Percentage of work completed toward achieving this milestone, expressed as a value between 0.00 and 100.00. Updated during progress reporting cycles. Used for EVM (Earned Value Management) percent-complete calculations and schedule performance tracking.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this milestone record was first created in the system, in ISO 8601 format (yyyy-MM-ddTHH:mm:ss.SSSXXX). Provides audit trail for data governance and lineage tracking in the Databricks lakehouse Silver layer.',
    `delivery_model` STRING COMMENT 'The project delivery model under which this milestone is defined and tracked. Determines the contractual framework and milestone obligation structure. EPC = Engineering Procurement Construction; DB = Design-Build; DBB = Design-Bid-Build; PPP = Public-Private Partnership; BOT = Build-Operate-Transfer; GMP = Guaranteed Maximum Price.. Valid values are `EPC|DB|DBB|PPP|BOT|GMP`',
    `eot_days_approved` STRING COMMENT 'Total number of calendar days of approved Extension of Time (EOT) granted for this milestone under the contract. Reflects cumulative approved EOT claims that have adjusted the baseline date. Zero if no EOT has been granted.',
    `eot_reference` STRING COMMENT 'Reference number of the approved EOT (Extension of Time) claim or contract amendment that adjusted the baseline date for this milestone. Used for contract administration audit trail and dispute resolution.',
    `forecast_date` DATE COMMENT 'Current best estimate of the date on which the milestone will be achieved, updated during schedule reviews and progress reporting cycles. Reflects schedule recovery plans, approved EOT (Extension of Time) claims, and current site conditions.',
    `hse_clearance_required` BOOLEAN COMMENT 'Indicates whether HSE (Health, Safety and Environment) regulatory clearance or permit is a prerequisite for achieving this milestone (e.g., commissioning milestones requiring OSHA or EPA sign-off). True = HSE clearance must be obtained before milestone can be marked complete.',
    `is_contractual` BOOLEAN COMMENT 'Indicates whether this milestone is a contractually obligated key date as defined in the project contract (FIDIC, GMP, or bespoke agreement). True = contractual obligation with potential LD (Liquidated Damages) or payment consequences; False = internal PMO or programme milestone.',
    `is_critical_path` BOOLEAN COMMENT 'Indicates whether this milestone lies on the Critical Path Method (CPM) critical path of the project schedule. True = any delay to this milestone directly delays the project completion date; False = milestone has float and is not on the critical path.',
    `is_ld_trigger` BOOLEAN COMMENT 'Indicates whether missing this milestone triggers Liquidated Damages (LD) as specified in the contract. True = LD clause applies upon delay; False = no LD exposure for this milestone. Critical for contract risk management and financial exposure reporting.',
    `is_payment_trigger` BOOLEAN COMMENT 'Indicates whether achievement of this milestone triggers a contractual payment event or progress payment certificate under the contract payment schedule. True = milestone completion initiates a payment claim or invoice; False = no direct payment linkage.',
    `ld_currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for the Liquidated Damages (LD) daily rate (e.g., USD, EUR, GBP, AED). Ensures correct financial exposure reporting in multi-currency international EPC projects.. Valid values are `^[A-Z]{3}$`',
    `ld_rate_per_day` DECIMAL(18,2) COMMENT 'The contractually agreed daily monetary rate of Liquidated Damages (LD) applicable if this milestone is not achieved by the baseline date. Expressed in the project contract currency. Populated only when is_ld_trigger = True. Sensitive commercial data.',
    `leed_related` BOOLEAN COMMENT 'Indicates whether this milestone is associated with LEED (Leadership in Energy and Environmental Design) certification requirements or green building compliance deliverables. True = milestone contributes to LEED certification pathway.',
    `milestone_status` STRING COMMENT 'Current lifecycle state of the milestone tracking its progress toward completion. not_started = work not yet begun; in_progress = activities underway; completed = milestone achieved; overdue = past planned date without completion; waived = formally waived by contract amendment; deferred = postponed with approved EOT (Extension of Time).. Valid values are `not_started|in_progress|completed|overdue|waived|deferred`',
    `milestone_type` STRING COMMENT 'Classification of the milestone by its origin and obligation level. contractual = bound by contract terms (FIDIC/GMP); internal = PMO governance milestone; regulatory = required by OSHA/EPA/IBC; client = client-driven key date; financial = triggers payment or LD exposure.. Valid values are `contractual|internal|regulatory|client|financial`',
    `milestone_name` STRING COMMENT 'Human-readable name of the milestone describing the key project event or deliverable (e.g., Notice to Proceed (NTP), Mechanical Completion, Substantial Completion, Final Handover). Used in schedule reports and contract documents.',
    `notification_advance_days` STRING COMMENT 'Number of calendar days in advance of the milestone date that formal notification must be issued to the client or engineer, as required by the contract. Applicable when notification_required = True. Supports contract compliance monitoring.',
    `notification_required` BOOLEAN COMMENT 'Indicates whether formal written notification to the client or engineer is contractually required prior to or upon achievement of this milestone. True = notification obligation exists per contract; False = no formal notification required.',
    `payment_amount` DECIMAL(18,2) COMMENT 'Contractual payment amount due upon achievement of this milestone, expressed in the project contract currency. Applicable only when is_payment_trigger = True. Used for cash flow forecasting and contract financial management.',
    `planned_date` DATE COMMENT 'Original baseline date on which the milestone was scheduled to be achieved, as established at project kick-off or NTP (Notice to Proceed). Serves as the schedule baseline reference for variance analysis and SPI (Schedule Performance Index) calculation.',
    `procore_milestone_reference` STRING COMMENT 'The corresponding milestone or schedule item identifier in Procore Construction Management platform. Supports cross-system reconciliation between the scheduling system of record (Primavera P6) and the construction management platform (Procore).',
    `project_milestone_description` STRING COMMENT 'Detailed narrative description of the milestone, including the scope of work, acceptance criteria, and deliverables required to formally achieve the milestone. Sourced from the contract schedule or project execution plan.',
    `remarks` STRING COMMENT 'Free-text field for project team notes, status commentary, risk flags, or contextual information related to the milestone. Used during progress review meetings and PMO reporting to capture qualitative schedule narrative.',
    `responsible_party` STRING COMMENT 'The contracting party primarily responsible for achieving this milestone. Distinguishes between the General Contractor (GC), client, subcontractor, engineer/designer, Joint Venture (JV) partner, or regulatory authority. Critical for contract administration and risk allocation.. Valid values are `contractor|client|subcontractor|engineer|joint_venture|regulator`',
    `schedule_variance_days` STRING COMMENT 'Number of calendar days by which the milestone is ahead of (negative) or behind (positive) the baseline date. Calculated as forecast_date minus baseline_date for open milestones, or actual_date minus baseline_date for completed milestones. Key input for SPI (Schedule Performance Index) reporting.',
    `sign_off_document_ref` STRING COMMENT 'Reference number of the formal sign-off document, completion certificate, or taking-over certificate issued upon milestone achievement (e.g., Aconex document number, Procore submittal reference). Provides audit trail for contract administration and handover documentation.',
    `total_float_days` STRING COMMENT 'Total schedule float in calendar days available for this milestone before it impacts the project completion date, as calculated by the CPM (Critical Path Method) schedule engine in Oracle Primavera P6. Zero or negative float indicates critical or super-critical status.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to this milestone record, in ISO 8601 format (yyyy-MM-ddTHH:mm:ss.SSSXXX). Used for change detection, incremental data loading, and audit trail maintenance in the Databricks lakehouse Silver layer.',
    CONSTRAINT pk_milestone PRIMARY KEY(`milestone_id`)
) COMMENT 'Key contractual and internal milestones within a construction project lifecycle, including NTP, design completion, procurement completion, construction start, mechanical completion, commissioning, and handover. Tracks planned date, forecast date, actual date, milestone type, contractual obligation flag, LD (Liquidated Damages) trigger flag, and milestone owner. Supports schedule performance and contract administration. [SSOT: distinct source of truth for project domain]';

CREATE OR REPLACE TABLE `vibe_construction_v1`.`project`.`project_baseline` (
    `project_baseline_id` BIGINT COMMENT 'Unique surrogate identifier for each approved project baseline record in the Silver Layer lakehouse. Primary key for the baseline data product.',
    `construction_project_id` BIGINT COMMENT 'Reference to the parent construction project for which this baseline record was established. Links the baseline to the project master record.',
    `wbs_element_id` BIGINT COMMENT 'Reference to the Work Breakdown Structure (WBS) element at which this baseline budget and schedule snapshot is captured. Enables cost-account-level baseline tracking per EVM methodology.',
    `approval_date` DATE COMMENT 'Calendar date on which the baseline was formally approved by the designated approving authority. Marks the effective start of the approved baseline for EVM measurement and PMO reporting.',
    `approval_level` STRING COMMENT 'Governance tier at which this baseline was approved, reflecting the authorization hierarchy. Higher-value or re-baseline revisions typically require elevated approval levels per PMO governance policy.. Valid values are `project_manager|project_director|pmo_board|client|executive_committee`',
    `baseline_number` STRING COMMENT 'Externally-known alphanumeric identifier for the baseline record, used in PMO reporting, EVM analysis, and audit documentation. Format: BL-{ProjectCode}-{SequenceNumber}.. Valid values are `^BL-[A-Z0-9]{3,10}-[0-9]{3}$`',
    `baseline_status` STRING COMMENT 'Current lifecycle state of the baseline record within the PMO approval workflow. Draft baselines are under preparation; pending_approval awaits sign-off; approved is the active authorized baseline; superseded indicates a newer revision has replaced it; cancelled denotes a withdrawn baseline.. Valid values are `draft|pending_approval|approved|superseded|cancelled`',
    `baseline_type` STRING COMMENT 'Classification of the baseline record indicating the nature of the snapshot: original (initial approved baseline), revised (minor scope/cost adjustment), re_baseline (full project re-baselining), co_incorporation (Change Order incorporated), re_forecast (updated forecast adopted as new baseline), management_reserve_release (management reserve funds released into budget).. Valid values are `original|revised|re_baseline|co_incorporation|re_forecast|management_reserve_release`',
    `budget_after_revision` DECIMAL(18,2) COMMENT 'Total approved budget amount immediately following this baseline revision. Together with budget_before_revision, provides the complete budget delta audit trail for PMO governance and financial audit requirements.',
    `budget_at_completion` DECIMAL(18,2) COMMENT 'Total approved budget for the project or WBS element as captured in this baseline snapshot, representing the Budget at Completion (BAC) in the EVM framework. This is the total planned cost against which CPI (Cost Performance Index) and cost variance are measured.',
    `budget_before_revision` DECIMAL(18,2) COMMENT 'Total approved budget amount immediately prior to this baseline revision. Enables audit trail tracking of budget evolution and quantification of the budget delta introduced by each revision.',
    `co_value_incorporated` DECIMAL(18,2) COMMENT 'Total monetary value of Change Orders (COs) incorporated into this baseline revision. Quantifies the cumulative scope change impact on the approved budget for audit trail and contract administration purposes.',
    `contingency_amount` DECIMAL(18,2) COMMENT 'Approved contingency reserve budget included within this baseline, allocated to cover identified project risks and uncertainties. Distinct from management reserve which is held outside the project baseline.',
    `contract_value` DECIMAL(18,2) COMMENT 'Total authorized contract value associated with this baseline, as agreed with the client or owner. Used to reconcile the project budget against the contracted revenue and to track budget-to-contract alignment.',
    `cost_account_code` STRING COMMENT 'Cost account or cost code identifier at which this baseline budget is allocated, enabling WBS-level budget breakdown and cost-account-level EVM variance analysis. Aligns with the project cost coding structure in SAP S/4HANA and Viewpoint Vista.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this baseline record was first created in the system, in ISO 8601 format (yyyy-MM-ddTHH:mm:ss.SSSXXX). Supports audit trail and data lineage requirements.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code in which all monetary amounts in this baseline record are denominated (e.g., USD, EUR, GBP). Supports multi-currency project financial reporting for international EPC projects.. Valid values are `^[A-Z]{3}$`',
    `delivery_model` STRING COMMENT 'Construction project delivery model under which this baseline was established. Determines the contractual framework and approval requirements: EPC (Engineering Procurement Construction), DB (Design-Build), DBB (Design-Bid-Build), PPP (Public-Private Partnership), BOT (Build-Operate-Transfer), GMP (Guaranteed Maximum Price).. Valid values are `epc|db|dbb|ppp|bot|gmp`',
    `duration_days` STRING COMMENT 'Approved total duration of the project or WBS element in calendar days as captured in this baseline snapshot. Derived from baseline start and finish dates; stored explicitly for EVM schedule variance analysis and reporting.',
    `effective_end_date` DATE COMMENT 'Date on which this baseline was superseded by a subsequent revision or closed. Null if this is the currently active approved baseline. Supports audit trail and historical EVM analysis.',
    `effective_start_date` DATE COMMENT 'Date from which this approved baseline becomes the active reference for EVM variance analysis and project performance measurement. Typically aligns with approval_date or the NTP (Notice to Proceed) date for original baselines.',
    `eot_days_granted` STRING COMMENT 'Number of calendar days of Extension of Time (EOT) granted and incorporated into this baseline revision. Tracks the cumulative schedule relief authorized through contract administration, impacting the baseline finish date.',
    `finish_date` DATE COMMENT 'Approved planned finish date for the project or WBS element as captured in this baseline snapshot. Used as the schedule reference for SPI (Schedule Performance Index) calculation and milestone tracking.',
    `is_client_approved` BOOLEAN COMMENT 'Boolean flag indicating whether the client or owner has formally approved this baseline revision. Relevant for contract-driven baselines under FIDIC, GMP (Guaranteed Maximum Price), or EPC delivery models where client sign-off is contractually required.',
    `is_current_baseline` BOOLEAN COMMENT 'Boolean flag indicating whether this record represents the currently active approved baseline for the project or WBS element. Only one baseline per project/WBS should have this flag set to True at any point in time.',
    `management_reserve_amount` DECIMAL(18,2) COMMENT 'Management reserve budget held outside the project baseline for unknown unknowns, as authorized by senior management. Tracked separately from contingency reserve per EVM methodology. Populated when baseline_type is management_reserve_release.',
    `notes` STRING COMMENT 'Free-text field for additional PMO or project controls notes, assumptions, constraints, or caveats associated with this baseline record. Supplements the formal revision justification narrative.',
    `planned_value` DECIMAL(18,2) COMMENT 'Planned Value (PV) — the authorized budget assigned to scheduled work in this baseline snapshot, also known as Budgeted Cost of Work Scheduled (BCWS) in EVM methodology. Serves as the EVM performance measurement baseline reference.',
    `primavera_baseline_reference` STRING COMMENT 'Source system identifier for this baseline record as assigned by Oracle Primavera P6. Enables traceability and reconciliation between the lakehouse Silver Layer and the operational scheduling system.',
    `revision_date` DATE COMMENT 'Calendar date on which the baseline revision was formally prepared and submitted for approval. Represents the point-in-time snapshot date for scope, schedule, and cost parameters.',
    `revision_justification` STRING COMMENT 'Narrative explanation of the business reason for this baseline revision, including the drivers of scope, schedule, or cost changes. Required for PMO governance approval and financial audit documentation.',
    `revision_number` STRING COMMENT 'Sequential integer indicating the revision iteration of the baseline for a given project or WBS element. Revision 0 denotes the original approved baseline; subsequent revisions increment by 1.',
    `sap_project_version` STRING COMMENT 'SAP S/4HANA Project Systems version identifier corresponding to this baseline snapshot. Used for reconciliation between the ERP project budget version and the Primavera schedule baseline.',
    `schedule_data_date` DATE COMMENT 'The data date (status date) of the Oracle Primavera P6 schedule from which this baseline snapshot was extracted. Defines the point-in-time reference for all schedule parameters captured in this record.',
    `scope_description` STRING COMMENT 'Narrative description of the approved project scope captured in this baseline snapshot. Documents the authorized scope boundaries, key deliverables, and inclusions/exclusions at the time of baseline approval.',
    `start_date` DATE COMMENT 'Approved planned start date for the project or WBS element as captured in this baseline snapshot. Used as the schedule reference for SPI (Schedule Performance Index) calculation and CPM (Critical Path Method) analysis.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to this baseline record, in ISO 8601 format (yyyy-MM-ddTHH:mm:ss.SSSXXX). Supports change tracking, audit trail, and data lineage requirements.',
    `variance_at_completion` DECIMAL(18,2) COMMENT 'Variance at Completion (VAC) — the difference between the Budget at Completion (BAC) and the Estimate at Completion (EAC) at the time this baseline was established. Provides a forward-looking cost performance indicator for PMO reporting.',
    CONSTRAINT pk_project_baseline PRIMARY KEY(`project_baseline_id`)
) COMMENT 'Approved project baseline and budget revision record maintaining the complete audit trail of authorized scope, schedule, and cost parameters throughout the project lifecycle. Each record captures a point-in-time snapshot: baseline type (original, revised, re-baseline, CO incorporation, re-forecast, management reserve release), revision number, revision date, approval date, approving authority, total baseline cost, baseline duration, baseline start and finish dates, budget amount before and after revision, cost account or WBS-level budget breakdown, and justification narrative. Supports EVM variance analysis (current performance vs approved baseline), change impact tracking, budget evolution audit trail at both project and cost-account level, and PMO governance and financial audit requirements.';

CREATE OR REPLACE TABLE `vibe_construction_v1`.`project`.`evm_period_record` (
    `evm_period_record_id` BIGINT COMMENT 'Unique surrogate identifier for each EVM period record. Primary key for the evm_period_record data product in the Databricks Silver Layer.',
    `construction_project_id` BIGINT COMMENT 'Reference to the parent construction project for which this EVM period record is captured. Links to the project master entity.',
    `cost_account_id` BIGINT COMMENT 'Foreign key linking to project.cost_account. Business justification: EVM is computed at the control account (cost account) level per ANSI/EIA-748 EVMS standards. Linking evm_period_record to cost_account enables control-account-level EVM reporting, which is the standar',
    `phase_id` BIGINT COMMENT 'Foreign key linking to project.phase. Business justification: EVM period records are often reported at phase level (e.g., civil phase, MEP phase). Linking evm_period_record to phase enables phase-level EVM roll-ups and performance reporting, which is standard in',
    `project_baseline_id` BIGINT COMMENT 'Foreign key linking to project.project_baseline. Business justification: EVM metrics (BCWS, BCWP, BAC) are always computed against a specific approved baseline. The evm_period_record.budget_at_completion and bcws values are derived from the baseline. Adding project_baselin',
    `project_budget_id` BIGINT COMMENT 'Foreign key linking to finance.project_budget. Business justification: EVM-to-budget reconciliation: monthly EVM reporting requires BCWS/BCWP/ACWP to be reconciled against the approved project budget. Finance controllers and PMO require this link for cost performance ind',
    `wbs_element_id` BIGINT COMMENT 'Reference to the specific WBS element at which this EVM measurement is recorded. Supports both project-level and WBS-level EVM reporting.',
    `acwp` DECIMAL(18,2) COMMENT 'The cumulative actual cost incurred for work performed as of the data date. Also known as Actual Cost (AC). Sourced from SAP S/4HANA Project Systems actual postings and Viewpoint Vista job costing.',
    `approved_by` STRING COMMENT 'The name or user identifier of the PMO or project controls manager who approved this EVM period record for official reporting. Required for audit trail and progress billing certification.',
    `approved_timestamp` TIMESTAMP COMMENT 'The date and time at which this EVM period record was formally approved by the PMO approver. Establishes the official record for audit and compliance purposes.',
    `baseline_completion_date` DATE COMMENT 'The approved baseline scheduled completion date for this WBS element or project as established at NTP (Notice to Proceed) or last approved baseline revision. Used to calculate schedule variance in time terms.',
    `bcwp` DECIMAL(18,2) COMMENT 'The cumulative budgeted cost of work actually performed (earned) as of the data date. Also known as Earned Value (EV). Computed from physical_percent_complete multiplied by budget_at_completion.',
    `bcws` DECIMAL(18,2) COMMENT 'The cumulative budgeted cost of work that was planned to be completed as of the data date, per the approved baseline schedule. Also known as Planned Value (PV). Core EVM metric sourced from Oracle Primavera P6 baseline.',
    `budget_at_completion` DECIMAL(18,2) COMMENT 'The total approved budget for the WBS element or project scope as of the current baseline. Represents the Performance Measurement Baseline (PMB) total. Used as the denominator for EVM index calculations.',
    `cost_variance` DECIMAL(18,2) COMMENT 'The difference between earned value and actual cost (BCWP minus ACWP). A positive value indicates under-budget performance; negative indicates cost overrun. Core EVM performance indicator for P&L reporting.',
    `cpi` DECIMAL(18,2) COMMENT 'The ratio of earned value to actual cost (BCWP divided by ACWP). A CPI greater than 1.0 indicates cost efficiency; less than 1.0 indicates cost overrun. Key PMO governance metric for project financial health monitoring.',
    `cpi_trend` STRING COMMENT 'Directional trend of the CPI compared to the previous reporting period. Indicates whether cost performance is improving, stable, or deteriorating. Used in PMO dashboard reporting and management escalation.. Valid values are `improving|stable|deteriorating`',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time at which this EVM period record was first created in the system. Supports audit trail and data lineage tracking in the Databricks Silver Layer.',
    `currency_code` STRING COMMENT 'The ISO 4217 three-letter currency code in which all monetary EVM values (BAC, BCWS, BCWP, ACWP, EAC, ETC, VAC, CV, SV) are expressed. Supports multi-currency international EPC projects.. Valid values are `^[A-Z]{3}$`',
    `data_date` DATE COMMENT 'The official status date as of which all progress, cost, and schedule data in this record are measured. Aligns with the Oracle Primavera P6 data date concept used for schedule updates.',
    `eac` DECIMAL(18,2) COMMENT 'The current forecast of total cost to complete the entire scope of work. Represents the best estimate of final project cost including all actuals to date plus estimated cost to complete. Core to P&L reporting and project financial health monitoring.',
    `earned_quantity` DECIMAL(18,2) COMMENT 'The quantity of work physically completed and verified as of the data date, expressed in the unit of measure applicable to the WBS element (e.g., m3 of concrete poured, linear metres of pipe installed). Used in units-complete measurement method.',
    `etc` DECIMAL(18,2) COMMENT 'The current forecast of remaining cost required to complete all outstanding scope of work from the data date to project completion. Calculated as EAC minus ACWP.',
    `forecast_completion_date` DATE COMMENT 'The current projected date on which all scope for this WBS element or project will be physically complete, based on current schedule performance and management assessment. Used for EOT (Extension of Time) analysis and client reporting.',
    `forecast_method` STRING COMMENT 'The methodology used to derive the Estimate at Completion (EAC) for this period record. Governs how the EAC and ETC values were calculated. [ENUM-REF-CANDIDATE: cpi_based|management_override|bottom_up_reestimate|cpi_spi_composite|eac_equals_bac — promote to reference product]. Valid values are `cpi_based|management_override|bottom_up_reestimate|cpi_spi_composite|eac_equals_bac`',
    `installed_quantity` DECIMAL(18,2) COMMENT 'The total quantity of material or work physically installed in the permanent works as of the data date. May differ from earned quantity when rework or rejection adjustments apply.',
    `management_narrative` STRING COMMENT 'Free-text management commentary explaining significant cost or schedule variances, corrective actions, risks, and forecast assumptions for this reporting period. Required for client monthly reporting and PMO governance packs.',
    `measurement_date` DATE COMMENT 'The date on which the physical progress measurement was conducted and verified in the field. May differ from the period end date when field surveys are conducted prior to period close.',
    `measurement_level` STRING COMMENT 'Indicates the hierarchical level at which EVM metrics are measured and reported in this record (e.g., project summary, WBS level, or control account). [ENUM-REF-CANDIDATE: project|wbs_level_1|wbs_level_2|wbs_level_3|activity|control_account — promote to reference product]. Valid values are `project|wbs_level_1|wbs_level_2|wbs_level_3|activity|control_account`',
    `period_acwp` DECIMAL(18,2) COMMENT 'The actual cost incurred for the current reporting period only. Enables period-on-period cost trend analysis and monthly P&L reporting. Sourced from SAP S/4HANA actual cost postings.',
    `period_bcwp` DECIMAL(18,2) COMMENT 'The earned value (BCWP) for the current reporting period only. Enables period-on-period trend analysis and supports monthly progress payment certificate calculations.',
    `period_bcws` DECIMAL(18,2) COMMENT 'The planned value (BCWS) for the current reporting period only, as distinct from the cumulative BCWS. Enables period-on-period trend analysis and monthly progress billing reconciliation.',
    `period_end_date` DATE COMMENT 'The calendar end date of the reporting period covered by this EVM record. Defines the data cut-off for progress measurement and cost capture.',
    `period_start_date` DATE COMMENT 'The calendar start date of the reporting period covered by this EVM record. Used to bound the measurement window for progress and cost data.',
    `physical_percent_complete` DECIMAL(18,2) COMMENT 'The verified physical progress percentage for this WBS element or project as of the data date. Measured by the verifying engineer and used to compute earned value (BCWP/EV). Range: 0.00 to 100.00.',
    `progress_measurement_method` STRING COMMENT 'The approved method used to calculate physical percent complete for this WBS element or activity. Governs how earned value (BCWP/EV) is computed. [ENUM-REF-CANDIDATE: weighted_steps|milestone|units_complete|level_of_effort|percent_complete|50_50_rule — promote to reference product]. Valid values are `weighted_steps|milestone|units_complete|level_of_effort|percent_complete|50_50_rule`',
    `quantity_unit_of_measure` STRING COMMENT 'The unit of measure applicable to earned_quantity and installed_quantity for this WBS element (e.g., m3, LM, EA, TON, m2). Sourced from the BOQ (Bill of Quantities).',
    `record_status` STRING COMMENT 'Lifecycle status of this EVM period record within the PMO approval workflow. Controls which records are used for official reporting and progress billing.. Valid values are `draft|submitted|approved|rejected|superseded`',
    `schedule_variance` DECIMAL(18,2) COMMENT 'The difference between earned value and planned value (BCWP minus BCWS). A positive value indicates ahead-of-schedule performance; negative indicates schedule slippage. Expressed in cost terms per ANSI/EIA-748.',
    `schedule_variance_days` STRING COMMENT 'The difference in calendar days between the forecast completion date and the baseline completion date. A negative value indicates schedule delay; positive indicates early completion. Complements the cost-based SV metric for EOT analysis.',
    `spi` DECIMAL(18,2) COMMENT 'The ratio of earned value to planned value (BCWP divided by BCWS). An SPI greater than 1.0 indicates ahead-of-schedule performance; less than 1.0 indicates schedule slippage. Key PMO governance metric.',
    `spi_trend` STRING COMMENT 'Directional trend of the SPI compared to the previous reporting period. Indicates whether schedule performance is improving, stable, or deteriorating. Used in PMO dashboard reporting and client monthly reporting.. Valid values are `improving|stable|deteriorating`',
    `submitted_timestamp` TIMESTAMP COMMENT 'The date and time at which this EVM period record was submitted for PMO review and approval. Supports workflow SLA tracking and audit trail.',
    `tcpi` DECIMAL(18,2) COMMENT 'The cost performance efficiency required on remaining work to meet the budget at completion (BAC) or estimate at completion (EAC). Calculated as (BAC minus BCWP) divided by (BAC minus ACWP). Indicates future cost efficiency needed.',
    `updated_timestamp` TIMESTAMP COMMENT 'The date and time at which this EVM period record was last modified. Supports change tracking, audit trail, and incremental data pipeline processing in the Databricks Silver Layer.',
    `vac` DECIMAL(18,2) COMMENT 'The projected cost variance at project completion, calculated as BAC minus EAC. A positive value indicates projected under-budget completion; negative indicates projected cost overrun. Critical for P&L forecasting and EBITDA reporting.',
    `verifying_engineer` STRING COMMENT 'The name or identifier of the engineer or quantity surveyor who independently verified and certified the physical percent complete measurement for this period record. Required for progress payment certification.',
    CONSTRAINT pk_evm_period_record PRIMARY KEY(`evm_period_record_id`)
) COMMENT 'Unified Single Source of Truth for periodic earned value management, physical progress measurement, and forward-looking project forecasting at WBS or project level. Captures physical progress (percent complete, earned quantity, installed quantity, measurement method — weighted steps, milestone, units complete, level of effort — verifying engineer, and measurement date), EVM performance metrics (CPI, SPI, BCWS/PV, BCWP/EV, ACWP/AC, CV, SV, TCPI), and management forecasts (EAC, ETC, VAC, forecast completion date, forecast final cost, forecast method — CPI-based, management override, bottom-up re-estimate). Includes reporting period, cost/schedule variances, trend indicators, and management narrative commentary. Core to PMO governance, progress billing, P&L reporting, client monthly reporting, and project financial health monitoring. Sourced from HCSS HeavyJob production tracking, Procore field management, and SAP S/4HANA Project Systems.';

CREATE OR REPLACE TABLE `vibe_construction_v1`.`project`.`progress_measurement` (
    `progress_measurement_id` BIGINT COMMENT 'Unique surrogate identifier for each periodic physical progress measurement record. Primary key for the progress_measurement data product in the project domain Silver layer.',
    `activity_id` BIGINT COMMENT 'Reference to the specific schedule activity within the WBS element being measured. Corresponds to the Primavera P6 activity object used in CPM (Critical Path Method) scheduling.',
    `construction_project_id` BIGINT COMMENT 'Reference to the parent construction project against which this progress measurement is recorded. Links to the project master entity.',
    `cost_account_id` BIGINT COMMENT 'Foreign key linking to project.cost_account. Business justification: Physical progress measurements are directly tied to cost accounts (control accounts) in EVM methodology. Linking progress_measurement to cost_account enables earned value computation at the control ac',
    `evm_period_record_id` BIGINT COMMENT 'Foreign key linking to project.evm_period_record. Business justification: Progress measurements are the raw physical progress inputs that feed into EVM period records. Linking progress_measurement to evm_period_record establishes the traceability chain from field measuremen',
    `phase_id` BIGINT COMMENT 'Foreign key linking to project.phase. Business justification: Progress measurements are organized by project phase in construction (e.g., foundation phase, structural phase). Linking progress_measurement to phase enables phase-level progress roll-ups and support',
    `project_baseline_id` BIGINT COMMENT 'Foreign key linking to project.project_baseline. Business justification: Progress measurements are taken against a specific approved baseline (planned percent complete is derived from the baseline). Adding project_baseline_id to progress_measurement enables variance analys',
    `wbs_element_id` BIGINT COMMENT 'Reference to the specific Work Breakdown Structure (WBS) element or activity node at which this progress measurement is captured. Aligns with Primavera P6 WBS hierarchy.',
    `billing_period_reference` STRING COMMENT 'Reference identifier of the progress billing certificate or payment application period to which this measurement contributes (e.g., IPC-007, PA-2024-03). Links measurement data to the contract administration billing cycle.',
    `budget_at_completion` DECIMAL(18,2) COMMENT 'Total approved budget for this WBS element or activity at the time of measurement. Denominator for earned value calculation and basis for EVM (Earned Value Management) performance indices.',
    `budgeted_quantity` DECIMAL(18,2) COMMENT 'Total planned quantity of work for this WBS element or activity as defined in the approved BOQ (Bill of Quantities) or project baseline. Denominator for units-complete percent complete calculation.',
    `cost_variance` DECIMAL(18,2) COMMENT 'Difference between earned value and actual cost (EV minus AC) for this WBS element as of the measurement date. Negative value indicates cost overrun. Stored as a raw EVM (Earned Value Management) field, not a derived KPI.',
    `cpi` DECIMAL(18,2) COMMENT 'Ratio of earned value to actual cost (EV divided by AC) for this WBS element at the measurement date. CPI (Cost Performance Index) greater than 1.0 indicates cost efficiency; less than 1.0 indicates overrun. Stored at measurement grain for trend analysis.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this progress measurement record was first created in the system, in ISO 8601 format (yyyy-MM-ddTHH:mm:ss.SSSXXX). Provides audit trail for data governance and lineage tracking.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code applicable to earned_value, planned_value, and budget_at_completion monetary fields (e.g., USD, EUR, GBP). Required for multi-currency EPC (Engineering Procurement Construction) projects.. Valid values are `^[A-Z]{3}$`',
    `discipline` STRING COMMENT 'Engineering or construction discipline to which this WBS element or activity belongs (e.g., Civil, Structural, MEP (Mechanical Electrical Plumbing), Piping, Electrical, Instrumentation). Used for discipline-level progress roll-up reporting.',
    `earned_value` DECIMAL(18,2) COMMENT 'Budgeted cost of work performed (BCWP) for this WBS element or activity as of the measurement date, calculated as percent_complete multiplied by the budget at completion. Core EVM (Earned Value Management) metric.',
    `installed_quantity` DECIMAL(18,2) COMMENT 'Cumulative physical quantity of work installed or completed to date as of the measurement date (e.g., cubic metres of concrete poured, linear metres of pipe laid, tonnes of steel erected). Used in units-complete measurement method.',
    `is_billing_eligible` BOOLEAN COMMENT 'Indicates whether this approved progress measurement qualifies for inclusion in a progress billing certificate or payment application (True/False). Controlled by measurement_status and contract billing terms.',
    `is_milestone` BOOLEAN COMMENT 'Indicates whether this progress measurement corresponds to a contractual or project milestone event (True) rather than a continuous activity (False). Milestone measurements trigger specific billing and reporting actions.',
    `measurement_date` DATE COMMENT 'The actual calendar date on which the physical progress measurement was taken in the field. This is the principal real-world event date, distinct from the reporting period end date or record creation timestamp.',
    `measurement_method` STRING COMMENT 'The technique used to quantify physical progress for this WBS element or activity. Weighted steps assigns weight to discrete sub-tasks; milestone marks binary completion; units complete counts installed quantities. [ENUM-REF-CANDIDATE: weighted_steps|milestone|units_complete|percent_complete|level_of_effort|physical_observation — promote to reference product]. Valid values are `weighted_steps|milestone|units_complete|percent_complete|level_of_effort|physical_observation`',
    `measurement_number` STRING COMMENT 'Externally-known business identifier for this measurement record, typically formatted as a sequential reference number (e.g., PM-2024-00123). Used in progress billing certificates and PMO reporting.',
    `measurement_source` STRING COMMENT 'Originating operational system from which this progress measurement was sourced. Supports data lineage traceability across HCSS HeavyJob production tracking, Procore field management, and Oracle Primavera P6.. Valid values are `hcss_heavyjob|procore|primavera_p6|manual|sap_ps`',
    `measurement_status` STRING COMMENT 'Current workflow lifecycle state of the progress measurement record, from initial field capture through engineer verification to client approval. Controls eligibility for progress billing.. Valid values are `draft|submitted|verified|approved|rejected|superseded`',
    `measurement_type` STRING COMMENT 'Classifies whether this measurement record captures physical progress only, financial progress (cost-based), or a combined physical and financial assessment. Determines which EVM fields are populated.. Valid values are `physical|financial|combined`',
    `ncr_reference` STRING COMMENT 'Reference number of any associated NCR (Non-Conformance Report) that may affect the validity or acceptance of this progress measurement. A populated value indicates rework or quality hold may impact claimed progress.',
    `percent_complete` DECIMAL(18,2) COMMENT 'Physical percent complete of the WBS element or activity as measured at the measurement date, expressed as a value between 0.00 and 100.00. This is the primary quantitative progress fact used in EVM (Earned Value Management) calculations.',
    `period_installed_quantity` DECIMAL(18,2) COMMENT 'Physical quantity of work installed or completed during the current reporting period only (incremental, not cumulative). Feeds period progress billing and production rate analysis in HCSS HeavyJob.',
    `planned_percent_complete` DECIMAL(18,2) COMMENT 'Baseline-scheduled percent complete for this WBS element or activity as of the measurement date, derived from the approved project baseline in Primavera P6. Used to compute SPI (Schedule Performance Index) variance.',
    `planned_value` DECIMAL(18,2) COMMENT 'Budgeted cost of work scheduled (BCWS) for this WBS element or activity as of the measurement date, derived from the approved baseline schedule. Core EVM (Earned Value Management) metric used to compute SPI (Schedule Performance Index).',
    `previous_percent_complete` DECIMAL(18,2) COMMENT 'Physical percent complete recorded in the immediately preceding reporting period. Enables period-over-period progress increment calculation and trend analysis without requiring a self-join.',
    `quantity_unit_of_measure` STRING COMMENT 'Unit of measure applicable to installed_quantity, period_installed_quantity, and budgeted_quantity fields (e.g., m3, LM, tonne, EA, m2, LS). Aligns with BOQ (Bill of Quantities) unit conventions.',
    `remarks` STRING COMMENT 'Free-text field for the field engineer or verifier to record observations, constraints, or qualifications affecting this progress measurement (e.g., weather delays, access restrictions, partial completion notes).',
    `reporting_period_code` BIGINT COMMENT 'Reference to the defined reporting period (weekly, monthly, or milestone-based) within which this progress measurement falls. Used for period-over-period EVM (Earned Value Management) analysis.',
    `reporting_period_end_date` DATE COMMENT 'End date of the reporting period to which this progress measurement belongs. Defines the data cut-off for period progress billing and EVM (Earned Value Management) calculations.',
    `reporting_period_start_date` DATE COMMENT 'Start date of the reporting period to which this progress measurement belongs. Used to align measurements with EVM (Earned Value Management) data cut-off cycles.',
    `schedule_variance` DECIMAL(18,2) COMMENT 'Difference between earned value and planned value (EV minus PV) for this WBS element as of the measurement date. Negative value indicates schedule delay. Stored as a raw EVM (Earned Value Management) field, not a derived KPI.',
    `source_record_reference` STRING COMMENT 'Native record identifier from the originating operational system (HCSS HeavyJob cost code entry ID, Procore production entry ID, or Primavera P6 activity ID string). Enables traceability back to the system of record.',
    `spi` DECIMAL(18,2) COMMENT 'Ratio of earned value to planned value (EV divided by PV) for this WBS element at the measurement date. SPI (Schedule Performance Index) greater than 1.0 indicates ahead of schedule; less than 1.0 indicates behind schedule.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to this progress measurement record, in ISO 8601 format (yyyy-MM-ddTHH:mm:ss.SSSXXX). Used for incremental data pipeline processing and audit trail in the Databricks Silver layer.',
    `verification_date` DATE COMMENT 'Date on which the verifying engineer formally approved and signed off this progress measurement record. Distinct from measurement_date (when field observation occurred) and created_timestamp (when record was entered).',
    `verifier_name` STRING COMMENT 'Full name of the engineer or site supervisor who physically verified and signed off this progress measurement. Retained for audit trail and contractual accountability under FIDIC and ISO 9001 requirements.',
    `work_area` STRING COMMENT 'Physical site area, zone, or work front where the measured work is being performed (e.g., Zone A, Block 3, Pier 7). Aligns with site work front definitions used in HCSS HeavyJob and Procore daily logs.',
    CONSTRAINT pk_progress_measurement PRIMARY KEY(`progress_measurement_id`)
) COMMENT 'Periodic physical progress measurement record at WBS element or activity level, capturing percent complete, earned quantity, installed quantity, measurement method (weighted steps, milestone, units complete), measurement date, reporting period, and verifying engineer. Feeds EVM calculations and progress billing. Sourced from HCSS HeavyJob production tracking and Procore field management.';

CREATE OR REPLACE TABLE `vibe_construction_v1`.`project`.`change_order` (
    `change_order_id` BIGINT COMMENT 'Unique surrogate identifier for the change order record in the lakehouse Silver layer. Primary key for the project_change_order data product.',
    `construction_project_id` BIGINT COMMENT 'Reference to the parent project to which this change order belongs. Links the CO to the project master record.',
    `cost_account_id` BIGINT COMMENT 'Foreign key linking to project.cost_account. Business justification: Change orders are posted to specific cost accounts (control accounts) in project cost management systems. The cost_code STRING field on project_change_order is a denormalized reference. Linking to cos',
    `cost_code_id` BIGINT COMMENT 'Foreign key linking to finance.cost_code. Business justification: Change order budget coding: approved change orders must be classified to finance cost codes for budget amendment processing and GL posting. project_change_order.cost_code is a denormalized plain-text ',
    `journal_entry_id` BIGINT COMMENT 'Foreign key linking to finance.journal_entry. Business justification: Change order journal posting: approved change orders trigger budget amendment journal entries in the GL. Finance auditors and project controllers require traceability from change order approval to the',
    `milestone_id` BIGINT COMMENT 'Foreign key linking to project.project_milestone. Business justification: Change orders with EOT (Extension of Time) provisions directly affect specific contractual milestones. The eot_granted_days and is_ld_applicable fields on project_change_order are meaningless without ',
    `phase_id` BIGINT COMMENT 'Foreign key linking to project.phase. Business justification: Change orders are scoped to specific project phases in construction. Linking project_change_order to phase enables phase-level CO impact analysis, supports gate review reporting, and allows phase budg',
    `project_baseline_id` BIGINT COMMENT 'Foreign key linking to project.project_baseline. Business justification: Approved change orders are incorporated into specific baseline revisions. Linking project_change_order to project_baseline establishes which baseline revision incorporated this CO (co_value_incorporat',
    `wbs_element_id` BIGINT COMMENT 'Foreign key linking to project.wbs_element. Business justification: Change orders affect specific WBS elements — this is a fundamental relationship in construction project controls. The existing wbs_code STRING field is a denormalized reference that should be replaced',
    `aconex_mail_ref` STRING COMMENT 'Aconex correspondence or transmittal reference number for the formal change order submission and approval correspondence. Provides document management traceability.',
    `approval_date` DATE COMMENT 'Calendar date on which the change order received final approval from the authorised signatory (client, owner, or engineer). Null if not yet approved.',
    `approval_status` STRING COMMENT 'Current workflow lifecycle state of the change order. Tracks progression from initial draft through client or owner approval. Only approved COs update the project baseline.. Valid values are `draft|submitted|under_review|approved|rejected|voided`',
    `budget_line_item_ref` STRING COMMENT 'Reference to the project budget line item or BOQ (Bill of Quantities) item that this change order modifies. Enables budget impact tracking at line-item level.',
    `change_type` STRING COMMENT 'Classification of the nature of the change. Drives cost and schedule impact analysis and reporting. [ENUM-REF-CANDIDATE: scope_addition|scope_reduction|design_change|unforeseen_condition|client_directive|regulatory_change — promote to reference product]. Valid values are `scope_addition|scope_reduction|design_change|unforeseen_condition|client_directive|regulatory_change`',
    `co_number` STRING COMMENT 'Externally-visible sequential identifier for the change order as issued on the project (e.g., CO-00042). Used in all formal correspondence, contract administration, and client reporting.. Valid values are `^CO-[0-9]{4,6}$`',
    `contingency_drawn_amount` DECIMAL(18,2) COMMENT 'Amount drawn from the project contingency reserve to fund this change order, if applicable. Tracks contingency consumption at the CO level for project financial management.',
    `contract_clause_reference` STRING COMMENT 'Specific contract clause or FIDIC sub-clause under which the change order is raised (e.g., FIDIC Clause 13.1 — Right to Vary). Establishes contractual entitlement.',
    `cost_impact_amount` DECIMAL(18,2) COMMENT 'Net monetary value of the change order representing the increase (positive) or decrease (negative) to the contract sum. Expressed in the contract currency. Core component of the MONETARY_TRIPLET for this transaction.',
    `cost_impact_currency` STRING COMMENT 'ISO 4217 three-letter currency code for the cost impact amount (e.g., USD, EUR, GBP). Required for multi-currency project environments.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp recording when the change order record was first created in the source system (Procore). Supports audit trail and data lineage requirements.',
    `delivery_model` STRING COMMENT 'Contract delivery model under which this change order is administered (e.g., EPC — Engineering Procurement Construction, DB — Design-Build, DBB — Design-Bid-Build, PPP — Public-Private Partnership). Affects entitlement rules.. Valid values are `EPC|DB|DBB|PPP|BOT|GMP`',
    `direct_cost_amount` DECIMAL(18,2) COMMENT 'Direct labour, material, and equipment cost component of the change order before overhead and profit mark-up. Used for cost breakdown analysis and BOQ reconciliation.',
    `drawing_revision` STRING COMMENT 'Drawing revision number or BIM (Building Information Modeling) model version that forms the basis of the change order scope. Ensures design traceability.',
    `effective_date` DATE COMMENT 'Date from which the approved change order takes contractual effect, potentially backdated to the date the change work commenced on site.',
    `eot_granted_days` STRING COMMENT 'Number of calendar days of Extension of Time formally approved and granted by the engineer or owner in response to this change order. May differ from the claimed schedule impact.',
    `is_disputed` BOOLEAN COMMENT 'Indicates whether the change order is subject to a formal dispute or claim between the contractor and the client/owner. True if disputed; False if agreed.',
    `is_ld_applicable` BOOLEAN COMMENT 'Indicates whether Liquidated Damages (LD) provisions are applicable to this change order in the event of delay. Relevant for schedule-impacting COs.',
    `ld_rate_per_day` DECIMAL(18,2) COMMENT 'Daily Liquidated Damages (LD) rate applicable to this change order if the associated milestone or completion date is not met. Expressed in the contract currency.',
    `originator` STRING COMMENT 'Party who initiated or originated the change order request. Determines contractual entitlement and responsibility for cost and schedule impacts.. Valid values are `client|owner|contractor|engineer|subcontractor|regulatory_authority`',
    `overhead_and_profit_amount` DECIMAL(18,2) COMMENT 'Overhead and profit mark-up applied to the direct cost to arrive at the total cost impact. Expressed in the contract currency.',
    `priority` STRING COMMENT 'Business priority assigned to the change order indicating urgency of processing and approval. Critical COs may be on the critical path and require expedited approval.. Valid values are `critical|high|medium|low`',
    `procore_co_reference` STRING COMMENT 'Native change order identifier from the Procore Construction Management system. Used for data lineage, source system traceability, and reconciliation between the lakehouse and Procore.',
    `project_change_order_description` STRING COMMENT 'Detailed narrative describing the scope of work added, reduced, or modified by this change order. Captures the full business justification and technical scope.',
    `reason_code` STRING COMMENT 'Standardised reason code categorising the root cause of the change (e.g., design error, owner-directed, differing site conditions, regulatory). Supports trend analysis and lessons learned. [ENUM-REF-CANDIDATE: design_error|owner_directed|differing_site_conditions|regulatory|scope_gap|value_engineering|force_majeure — promote to reference product]',
    `revision_number` STRING COMMENT 'Revision sequence of the change order document. Increments each time the CO is revised prior to final approval. Revision 0 is the original issue.',
    `sap_co_document_number` STRING COMMENT 'SAP S/4HANA project system document number generated when the approved change order is posted to the financial ledger. Enables reconciliation between project management and ERP.',
    `schedule_impact_days` STRING COMMENT 'Number of calendar days of Extension of Time (EOT) claimed or granted as a result of this change order. Positive value indicates delay; negative indicates acceleration. Zero if no schedule impact.',
    `scope_of_work_summary` STRING COMMENT 'Concise summary of the physical scope of work added, removed, or modified by this change order. Complements the detailed description for executive reporting and CO registers.',
    `submitted_date` DATE COMMENT 'Calendar date on which the change order was formally submitted to the client or owner for review and approval. Triggers contractual response timelines per FIDIC.',
    `title` STRING COMMENT 'Short descriptive title of the change order summarising the nature of the change (e.g., Additional Piling Works — Zone B). Used in registers and dashboards.',
    `updated_timestamp` TIMESTAMP COMMENT 'System timestamp recording the most recent modification to the change order record. Used for incremental data loading, audit trails, and change tracking in the lakehouse.',
    CONSTRAINT pk_change_order PRIMARY KEY(`change_order_id`)
) COMMENT 'Formal change order (CO) record capturing approved scope, schedule, and cost changes to the project baseline. Tracks CO number, description, change type (scope addition, scope reduction, design change, unforeseen condition), cost impact, schedule impact (EOT — Extension of Time), originator, approval status, approval date, and contract reference. SSOT for all approved project changes. Sourced from Procore Change Orders module. [SSOT: distinct source of truth for project domain]';

CREATE OR REPLACE TABLE `vibe_construction_v1`.`project`.`cost_account` (
    `cost_account_id` BIGINT COMMENT 'Unique surrogate identifier for the project cost account (control account) record in the Databricks Silver Layer. Primary key.',
    `construction_project_id` BIGINT COMMENT 'Reference to the parent construction project to which this cost account belongs. Links cost account to the project master record for project-level cost roll-up and reporting.',
    `cost_code_id` BIGINT COMMENT 'Foreign key linking to finance.cost_code. Business justification: Job cost reporting: cost accounts must map to finance cost codes for GL posting and cost category reporting. cost_account.cost_code is a plain-text denormalized reference. A proper FK enables cost acc',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: GL reconciliation: cost accounts post actuals to specific GL accounts. cost_account.gl_account_code is a denormalized plain-text reference. A proper FK enables automated GL-to-cost-account reconciliat',
    `phase_id` BIGINT COMMENT 'Foreign key linking to project.phase. Business justification: Cost accounts are organized by project phase in construction cost management. The existing phase_code STRING field is a denormalized reference that should be replaced with a proper FK to phase. This e',
    `project_baseline_id` BIGINT COMMENT 'Foreign key linking to project.project_baseline. Business justification: Cost accounts (control accounts) are established as part of the project baseline. The original_budget_amount and approved_budget_amount on cost_account are derived from the baseline. Linking cost_acco',
    `wbs_element_id` BIGINT COMMENT 'Reference to the Work Breakdown Structure (WBS) element at which this cost account is positioned. The cost account represents the intersection of a WBS node and a cost code, enabling granular budget control per WBS deliverable.',
    `account_description` STRING COMMENT 'Human-readable description of the cost account scope, such as Structural Concrete — Foundation Works or MEP Subcontract — Electrical Rough-In. Used in cost reports, BOQ reconciliation, and EVM reporting.',
    `account_status` STRING COMMENT 'Current lifecycle status of the cost account. Active accounts accept cost postings; on_hold accounts are temporarily frozen pending review; closed accounts are complete and locked; cancelled accounts are voided; pending_approval accounts await PMO authorization before activation.. Valid values are `active|on_hold|closed|cancelled|pending_approval`',
    `actual_cost_amount` DECIMAL(18,2) COMMENT 'Total actual cost incurred and posted to this cost account to date, including paid invoices, posted labor timesheets, and equipment charges. Equivalent to Actual Cost of Work Performed (ACWP) in EVM. Sourced from SAP S/4HANA FI/CO and Viewpoint Vista job cost ledger.',
    `approved_budget_amount` DECIMAL(18,2) COMMENT 'Current approved budget for this cost account inclusive of all approved Change Orders (COs). Equivalent to Budget at Completion (BAC) in EVM terminology. Updated each time a CO is approved and posted to the cost account. The primary budget control figure used by project cost controllers.',
    `baseline_finish_date` DATE COMMENT 'Planned completion date for the scope of work associated with this cost account as established in the approved project baseline schedule. Used for schedule performance tracking and Earned Value Management (EVM) analysis.',
    `baseline_start_date` DATE COMMENT 'Planned start date for the scope of work associated with this cost account as established in the approved project baseline schedule. Used for Planned Value (PV) calculation and schedule variance analysis in EVM reporting.',
    `budget_unit_rate` DECIMAL(18,2) COMMENT 'Budgeted cost per unit of measure for this cost account (Approved Budget divided by Budgeted Quantity). Used for unit rate benchmarking, bid analysis, and productivity monitoring. Expressed in the cost account currency per unit of measure.',
    `change_order_amount` DECIMAL(18,2) COMMENT 'Cumulative value of all approved Change Orders (COs) posted to this cost account. Represents the delta between the original budget and the current approved budget. Tracked separately to support contract administration and CO impact analysis.',
    `cost_account_code` STRING COMMENT 'Externally-known alphanumeric code uniquely identifying the cost account within the project. Derived from the job cost coding structure in Viewpoint Vista and SAP PS. Used on timesheets, purchase orders, and subcontract invoices for cost allocation.. Valid values are `^[A-Z0-9]{2,20}(-[A-Z0-9]{1,10}){0,4}$`',
    `committed_cost_amount` DECIMAL(18,2) COMMENT 'Total value of contractual commitments against this cost account, including issued Purchase Orders (POs) and subcontract awards not yet invoiced. Represents financial obligations that will become actual costs. Critical for cash flow forecasting and cost-to-complete analysis.',
    `contingency_amount` DECIMAL(18,2) COMMENT 'Contingency budget allocated to this cost account to cover identified risks and uncertainties within the defined scope. Managed separately from the base budget and released by the project manager upon risk materialization. Supports risk-adjusted cost forecasting.',
    `cost_center_code` STRING COMMENT 'SAP Cost Center code associated with this cost account, representing the organizational unit responsible for the costs. Used for overhead allocation, departmental P&L reporting, and internal charge-back processes.. Valid values are `^[A-Z0-9]{4,12}$`',
    `cost_to_complete_amount` DECIMAL(18,2) COMMENT 'Estimated remaining cost required to complete the scope of work for this cost account. Calculated as Forecast Cost at Completion minus Actual Cost to Date. Used by cost controllers to project future cash requirements and update project financial forecasts.',
    `cost_type` STRING COMMENT 'Primary classification of the cost account by resource type: labor (direct workforce), material (permanent and consumable materials), equipment (plant and machinery), subcontract (third-party subcontractor scope), or overhead (indirect project costs). Drives cost segregation in EVM and P&L reporting.. Valid values are `labor|material|equipment|subcontract|overhead`',
    `cost_variance_amount` DECIMAL(18,2) COMMENT 'Variance between the approved budget and the forecast cost at completion for this cost account (Approved Budget minus Forecast Cost at Completion). A negative value indicates a cost overrun; positive indicates an underspend. Key metric for project cost control reporting and PMO governance.',
    `cpi` DECIMAL(18,2) COMMENT 'Earned Value Management (EVM) Cost Performance Index for this cost account, calculated as Earned Value divided by Actual Cost (EV/AC). A CPI below 1.0 indicates cost overrun; above 1.0 indicates cost efficiency. Stored at the cost account level to support drill-down analysis from project-level CPI reporting.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this cost account record was first created in the source system or ingested into the Silver Layer. Supports audit trail, data lineage, and record lifecycle tracking.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for all monetary amounts on this cost account (e.g., USD, EUR, GBP, AUD). Supports multi-currency project reporting for international EPC and JV projects.. Valid values are `^[A-Z]{3}$`',
    `earned_value_amount` DECIMAL(18,2) COMMENT 'Budgeted cost of work performed (BCWP) for this cost account, representing the value of completed work expressed in budget terms. Core EVM metric used to calculate Cost Performance Index (CPI) and Schedule Performance Index (SPI) at the cost account level.',
    `forecast_cost_at_completion` DECIMAL(18,2) COMMENT 'Project cost controllers current best estimate of the total cost to complete this cost account, including actual costs to date plus estimated cost to complete (ETC). Equivalent to Estimate at Completion (EAC) in EVM. Updated periodically during project cost reviews.',
    `forecast_finish_date` DATE COMMENT 'Current forecast completion date for the scope of work associated with this cost account. Updated during project schedule reviews. Used to assess Extension of Time (EOT) impacts and project completion forecasting.',
    `forecast_start_date` DATE COMMENT 'Current forecast start date for the scope of work associated with this cost account, updated during project schedule reviews. Compared against the baseline start date to identify schedule slippage and its cost impact.',
    `is_lump_sum` BOOLEAN COMMENT 'Indicates whether this cost account is priced on a lump sum basis (True) rather than a unit rate or reimbursable basis (False). Lump sum accounts are managed differently in terms of progress measurement and payment certification.',
    `is_subcontract_scope` BOOLEAN COMMENT 'Indicates whether the scope of work for this cost account is executed by a subcontractor (True) or by the General Contractors (GC) own forces (False). Drives subcontract management workflows, retention tracking, and payment certification processes.',
    `original_budget_amount` DECIMAL(18,2) COMMENT 'The baseline budget amount for this cost account as established at project sanction or Notice to Proceed (NTP). Represents the original authorized cost plan before any Change Orders (COs). Immutable once the baseline is locked. Used as the denominator for variance analysis and EVM performance measurement.',
    `percent_complete` DECIMAL(18,2) COMMENT 'Physical percent complete of the scope of work associated with this cost account, as assessed by the project team or quantity surveyor. Expressed as a value between 0.00 and 100.00. Used to calculate Earned Value and assess progress against the baseline schedule.',
    `planned_value_amount` DECIMAL(18,2) COMMENT 'Budgeted cost of work scheduled (BCWS) for this cost account as of the reporting data date. Represents the cumulative planned spend per the project baseline schedule. Used with Earned Value to compute Schedule Variance (SV) and SPI.',
    `quantity_actual` DECIMAL(18,2) COMMENT 'Actual quantity of work completed and posted against this cost account to date. Compared against budgeted quantity to assess production efficiency and unit cost performance. Sourced from HCSS HeavyJob production entries and field daily logs.',
    `quantity_budgeted` DECIMAL(18,2) COMMENT 'Original budgeted quantity of work for this cost account as derived from the Bill of Quantities (BOQ) or Material Take-Off (MTO). Expressed in the unit of measure applicable to the cost type (e.g., m3 for concrete, tonnes for steel, hours for labor). Enables unit rate analysis and productivity benchmarking.',
    `reporting_period_date` DATE COMMENT 'The data date or cut-off date as of which the cost account financial figures (actual cost, earned value, planned value, forecast) are reported. Aligns with the project monthly cost report cycle and EVM data date in Oracle Primavera P6.',
    `retention_percentage` DECIMAL(18,2) COMMENT 'Contractual retention percentage applied to payments against this cost account, expressed as a percentage (e.g., 5.00 for 5%). Retention is withheld from subcontractor and supplier payments until practical completion or Defects Liability Period (DLP) expiry.',
    `spi` DECIMAL(18,2) COMMENT 'Earned Value Management (EVM) Schedule Performance Index for this cost account, calculated as Earned Value divided by Planned Value (EV/PV). An SPI below 1.0 indicates schedule slippage on the associated scope; above 1.0 indicates ahead of schedule. Supports integrated cost-schedule performance analysis.',
    `unit_of_measure` STRING COMMENT 'Unit of measure for the budgeted and actual quantities on this cost account (e.g., HR for hours, M3 for cubic metres, TON for tonnes, LM for linear metres, EA for each, LS for lump sum). Aligns with the BOQ and MTO unit conventions.. Valid values are `^[A-Za-z0-9/_]{1,20}$`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to this cost account record, whether from a source system refresh, cost controller update, or Change Order posting. Used for incremental data loading, change detection, and audit compliance.',
    CONSTRAINT pk_cost_account PRIMARY KEY(`cost_account_id`)
) COMMENT 'Project cost account (control account) representing the intersection of WBS element and cost code for job costing and budget control. Captures cost account code, description, cost type (labor, material, equipment, subcontract, overhead), original budget, approved budget (including COs), committed cost, actual cost to date, forecast cost at completion, and variance. SSOT for project-level cost control. Sourced from SAP S/4HANA Project Systems and Viewpoint Vista Job Costing.';

CREATE OR REPLACE TABLE `vibe_construction_v1`.`project`.`deliverable` (
    `deliverable_id` BIGINT COMMENT 'Unique surrogate identifier for the project deliverable record in the silver layer lakehouse. Primary key for this entity.',
    `activity_id` BIGINT COMMENT 'Reference to the Oracle Primavera P6 schedule activity linked to the production of this deliverable. Enables earned value management (EVM) and schedule performance index (SPI) calculation at the deliverable level.',
    `agreement_id` BIGINT COMMENT 'Reference to the contract under which this deliverable is required. Supports contractual obligation tracking and FIDIC compliance.',
    `change_order_id` BIGINT COMMENT 'Foreign key linking to project.project_change_order. Business justification: Deliverables can be created or modified as a result of approved change orders. The existing change_order_reference STRING field is a denormalized reference that should be replaced with a proper FK to ',
    `construction_project_id` BIGINT COMMENT 'Reference to the parent project to which this deliverable belongs. Links the deliverable to the project lifecycle and Work Breakdown Structure (WBS).',
    `itp_id` BIGINT COMMENT 'Foreign key linking to quality.itp. Business justification: Construction deliverables are governed by ITPs — each deliverable (concrete pour, structural erection, system test) must pass ITP hold/witness points before acceptance. deliverable.itp_reference is a ',
    `master_id` BIGINT COMMENT 'Foreign key linking to material.material_master. Business justification: Ensures Deliverable Material Specification ties deliverable to the exact material master record for compliance.',
    `milestone_id` BIGINT COMMENT 'Foreign key linking to project.project_milestone. Business justification: Deliverables are contractually linked to milestones — submission of a deliverable often triggers a milestone completion (is_payment_trigger on project_milestone). Linking deliverable to project_milest',
    `package_id` BIGINT COMMENT 'Foreign key linking to design.package. Business justification: Contractual deliverables are grouped into submission packages for client review in construction. Design managers track which package contains each deliverable for completeness checking and client acce',
    `phase_id` BIGINT COMMENT 'Foreign key linking to project.phase. Business justification: Deliverables are produced within specific project phases (e.g., engineering deliverables in design phase, commissioning documents in handover phase). Linking deliverable to phase enables phase-level d',
    `project_baseline_id` BIGINT COMMENT 'Foreign key linking to project.project_baseline. Business justification: Deliverables are planned under a specific project baseline with planned_issue_date derived from the baseline schedule. Linking deliverable to project_baseline enables baseline vs. actual delivery date',
    `contact_id` BIGINT COMMENT 'Foreign key linking to client.contact. Business justification: Deliverable responsibility is assigned to a client contact to manage approvals and handover per Deliverable Acceptance process.',
    `wbs_element_id` BIGINT COMMENT 'Reference to the WBS element under which this deliverable is classified. Enables hierarchical project decomposition and earned value tracking.',
    `acceptance_date` DATE COMMENT 'Date on which the deliverable was formally accepted by the client or approving authority. Used for handover milestone tracking and DLP commencement.',
    `acceptance_status` STRING COMMENT 'Client or reviewer acceptance status of the deliverable following formal review. Indicates whether the deliverable has been accepted, accepted with comments, or rejected and requires resubmission.. Valid values are `pending|accepted|accepted_with_comments|rejected|resubmit_required`',
    `actual_issue_date` DATE COMMENT 'Date on which the deliverable was actually issued or transmitted. Populated upon completion and used to calculate schedule variance and support DLP (Defects Liability Period) tracking.',
    `bim_model_reference` STRING COMMENT 'Reference identifier linking this deliverable to the corresponding BIM model or element in Autodesk BIM 360. Supports clash detection, design coordination, and digital handover.',
    `deliverable_category` STRING COMMENT 'High-level category grouping the deliverable within the EPC (Engineering, Procurement, and Construction) project phases. Supports phase-based reporting and PMO governance. [ENUM-REF-CANDIDATE: engineering|procurement|construction|commissioning|handover|safety|quality — 7 candidates stripped; promote to reference product]',
    `deliverable_code` STRING COMMENT 'Unique alphanumeric code identifying the deliverable within the project document control system. Typically assigned by the document management system (e.g., Aconex or Procore) and used for transmittal and correspondence tracking.. Valid values are `^[A-Z0-9-.]{3,30}$`',
    `comments` STRING COMMENT 'Free-text field capturing reviewer comments, rejection reasons, or clarification notes associated with the deliverable review cycle. Supports QA/QC tracking and resubmission guidance.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the deliverable record was first created in the system. Supports audit trail and data lineage requirements.',
    `deliverable_status` STRING COMMENT 'Current lifecycle status of the deliverable within the review and approval workflow. Tracks progression from initiation through approval or rejection in the document control system. [ENUM-REF-CANDIDATE: not_started|in_progress|under_review|approved|rejected|superseded|cancelled — 7 candidates stripped; promote to reference product]',
    `deliverable_type` STRING COMMENT 'Classification of the deliverable by its output category. Distinguishes engineering drawings, specifications, reports, calculations, procedures, commissioning packages, handover documents, and Inspection and Test Plans (ITPs). [ENUM-REF-CANDIDATE: engineering_drawing|specification|report|calculation|procedure|commissioning_package|handover_document|inspection_test_plan|method_statement|data_sheet — promote to reference product]',
    `discipline` STRING COMMENT 'Engineering or construction discipline responsible for producing the deliverable (e.g., Civil, Structural, Mechanical, Electrical, Instrumentation, Piping, Architectural, MEP). Aligns with Autodesk BIM 360 discipline classification. [ENUM-REF-CANDIDATE: civil|structural|mechanical|electrical|instrumentation|piping|architectural|geotechnical|environmental|commissioning|process|HSE — promote to reference product]',
    `document_number` STRING COMMENT 'Formal document control number assigned by the document management system (e.g., Aconex or Procore). Used as the primary reference in transmittals, correspondence, and the document register.',
    `eot_applicable` BOOLEAN COMMENT 'Indicates whether an Extension of Time (EOT) claim has been applied to the planned issue date of this deliverable. Supports contract administration and schedule delay analysis.',
    `forecast_issue_date` DATE COMMENT 'Current forecast date for issuing the deliverable, updated during project progress reviews. Reflects schedule changes and is compared against the planned issue date to identify delays.',
    `is_contractual` BOOLEAN COMMENT 'Indicates whether this deliverable is a contractually mandated output as defined in the contract scope of work or BOQ (Bill of Quantities). Distinguishes contractual obligations from internally generated technical documents.',
    `is_dlp_applicable` BOOLEAN COMMENT 'Indicates whether this deliverable is subject to the Defects Liability Period (DLP) obligations under the contract. Enables DLP tracking and defect notification management.',
    `is_handover_required` BOOLEAN COMMENT 'Indicates whether this deliverable must be included in the project handover package to the client. Supports commissioning and handover completeness tracking.',
    `native_file_format` STRING COMMENT 'File format of the deliverable document (e.g., PDF, DWG, DXF, REVIT, IFC, XLSX). Supports document management, BIM coordination, and digital handover requirements. [ENUM-REF-CANDIDATE: PDF|DWG|DXF|REVIT|IFC|XLSX|DOCX|XML|CSV — 9 candidates stripped; promote to reference product]',
    `ncr_reference` STRING COMMENT 'Reference number of any Non-Conformance Report (NCR) raised against this deliverable. Links quality non-conformances to the affected deliverable for QA/QC tracking and corrective action management.',
    `percent_complete` DECIMAL(18,2) COMMENT 'Current percentage completion of the deliverable production, ranging from 0.00 to 100.00. Used in Earned Value Management (EVM) calculations and progress reporting.',
    `planned_issue_date` DATE COMMENT 'Baseline planned date on which the deliverable is scheduled to be issued to the client or for construction use. Established at project baseline and used for schedule performance tracking (SPI).',
    `priority_level` STRING COMMENT 'Business priority assigned to the deliverable indicating its criticality to the project schedule and construction activities. Critical deliverables are on the Critical Path Method (CPM) schedule.. Valid values are `critical|high|medium|low`',
    `review_due_date` DATE COMMENT 'Contractually or procedurally defined date by which the reviewer must return comments or approval. Supports contract administration and review cycle management.',
    `review_return_date` DATE COMMENT 'Actual date on which the reviewer returned comments or approval decision. Compared against review due date to track reviewer compliance and contract obligations.',
    `revision_number` STRING COMMENT 'Current revision identifier of the deliverable (e.g., A, B, C, 0, 1, 2). Tracks the version history of the document through the review and approval cycle in the document management system.. Valid values are `^[A-Z0-9]{1,5}$`',
    `revision_status_code` STRING COMMENT 'Industry-standard document issue purpose code indicating the intent of the current revision: IFR (Issued for Review), IFC (Issued for Construction), IFI (Issued for Information), IFB (Issued for Bid), AFC (Approved for Construction), AFD (Approved for Design), ASB (As-Built). Critical for construction document control. [ENUM-REF-CANDIDATE: IFR|IFC|IFI|IFB|AFC|AFD|ASB — 7 candidates stripped; promote to reference product]',
    `storage_location_url` STRING COMMENT 'URL or path to the deliverable file stored in the document management system (e.g., Aconex, Autodesk BIM 360, or SharePoint). Provides direct access to the source document.',
    `submission_number` STRING COMMENT 'Sequential count of the number of times this deliverable has been submitted for review. Tracks resubmission cycles and supports quality performance analysis.',
    `title` STRING COMMENT 'Full descriptive title of the deliverable as defined in the contract, scope of work, or engineering register. Used for identification in reports, transmittals, and handover packages.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the deliverable record. Supports change tracking, audit trail, and incremental data loading in the Databricks silver layer.',
    `weight_factor` DECIMAL(18,2) COMMENT 'Relative weighting of this deliverable within the project progress measurement system. Used to calculate weighted progress and Earned Value (EV) contributions at the project or WBS level.',
    CONSTRAINT pk_deliverable PRIMARY KEY(`deliverable_id`)
) COMMENT 'Project deliverable record representing a contractually or technically required output (engineering deliverable, construction deliverable, commissioning package, handover document). Captures deliverable code, title, discipline, deliverable type, responsible party, planned issue date, forecast issue date, actual issue date, revision status, and acceptance status. Supports handover and DLP (Defects Liability Period) tracking.';

CREATE OR REPLACE TABLE `vibe_construction_v1`.`project`.`risk_register` (
    `risk_register_id` BIGINT COMMENT 'Unique surrogate identifier for each risk register entry in the project risk register. Primary key for the risk_register data product.',
    `activity_id` BIGINT COMMENT 'Foreign key linking to schedule.activity. Business justification: Schedule risk analysis requires linking risks to specific critical-path activities. Construction PMs use this for delay risk quantification reports and Monte Carlo schedule risk analysis. risk_registe',
    `construction_project_id` BIGINT COMMENT 'Reference to the parent construction project to which this risk register entry belongs. Links the risk to the project master record for PMO governance and EPC execution tracking.',
    `cost_code_id` BIGINT COMMENT 'Foreign key linking to finance.cost_code. Business justification: Risk contingency budgeting: risk register entries with contingency_cost_amount and cost_impact_amount must be coded to finance cost codes for contingency budget allocation and financial risk reporting',
    `hazard_register_id` BIGINT COMMENT 'Foreign key linking to safety.hazard_register. Business justification: Project risks with HSE implications must be traceable to specific hazards in the site hazard register for integrated risk management and regulatory compliance. risk_register has hse_risk_flag but no F',
    `milestone_id` BIGINT COMMENT 'Foreign key linking to project.project_milestone. Business justification: Risks in construction projects are often associated with specific contractual milestones — a risk that threatens a milestone date (schedule_impact_days on risk_register directly relates to milestone f',
    `phase_id` BIGINT COMMENT 'Foreign key linking to project.phase. Business justification: Risks are phase-specific in construction — risks identified during design phase differ from construction phase risks. Linking risk_register to phase enables phase-level risk exposure reporting, suppor',
    `rfi_id` BIGINT COMMENT 'Foreign key linking to design.rfi. Business justification: RFIs revealing design conflicts or ambiguities are primary risk triggers in construction. Risk managers formally log RFIs as risk evidence in the risk register. RFI-to-risk traceability is required fo',
    `risk_assessment_id` BIGINT COMMENT 'Foreign key linking to safety.risk_assessment. Business justification: Project risks flagged as HSE risks (hse_risk_flag=true) must be formally linked to a safety risk_assessment for integrated risk reporting and regulatory compliance. Risk managers need this link to tra',
    `wbs_element_id` BIGINT COMMENT 'Reference to the specific Work Breakdown Structure (WBS) element at which this risk is identified. Enables risk attribution at sub-project or work-package level for granular PMO reporting.',
    `affected_discipline` STRING COMMENT 'Construction or engineering discipline most affected by this risk (e.g., Civil, Structural, MEP, Geotechnical, Electrical, Procurement). Supports discipline-level risk reporting and resource allocation for mitigation.',
    `closure_date` DATE COMMENT 'Calendar date on which the risk entry was formally closed, either because the risk window has passed, the risk was fully mitigated, or the risk was realized and the contingency plan executed.',
    `contingency_cost_amount` DECIMAL(18,2) COMMENT 'Monetary contingency reserve allocated to this risk entry, expressed in the project currency. Feeds into the project contingency budget managed through SAP S/4HANA Project Systems and PMO cost control.',
    `contingency_plan` STRING COMMENT 'Description of the fallback actions to be executed if the risk event is realized despite mitigation efforts. Defines trigger conditions, response steps, and responsible parties for contingency activation.',
    `contract_clause_reference` STRING COMMENT 'Reference to the specific contract clause (e.g., FIDIC Clause 17.3, GMP provision, LD clause) that governs the allocation or treatment of this risk. Supports contract administration and legal risk management.',
    `cost_impact_amount` DECIMAL(18,2) COMMENT 'Estimated monetary value of the cost impact if the risk event is realized, expressed in the project currency. Used for contingency reserve sizing, Earned Value Management (EVM) risk exposure, and project P&L forecasting.',
    `cost_impact_rating` STRING COMMENT 'Qualitative rating of the potential cost impact if the risk event is realized, using the standard five-point PMO scale. Used in risk matrix scoring and contingency reserve determination.. Valid values are `very_low|low|medium|high|very_high`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this risk register record was first created in the data platform. RECORD_AUDIT_CREATED for this entity. Used for data lineage, audit trail, and silver layer ingestion tracking.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for the cost impact amount (e.g., USD, EUR, GBP). Ensures consistent financial reporting across multi-currency international EPC projects.. Valid values are `^[A-Z]{3}$`',
    `escalation_flag` BOOLEAN COMMENT 'Indicates whether this risk has been escalated to senior management or the PMO for executive attention due to its high risk score, proximity, or strategic significance to the project.',
    `hse_risk_flag` BOOLEAN COMMENT 'Indicates whether this risk has a Health, Safety, and Environment (HSE) dimension requiring notification to the HSE team and potential entry into the Intelex HSE management system for regulatory compliance.',
    `identified_date` DATE COMMENT 'Calendar date on which the risk or opportunity was first identified and entered into the project risk register. BUSINESS_EVENT_TIMESTAMP (date precision) for this entity. Used for risk ageing analysis and PMO reporting.',
    `insurance_coverage_flag` BOOLEAN COMMENT 'Indicates whether this risk is covered by an existing insurance policy (e.g., Contractors All Risk, Professional Indemnity, Public Liability). Supports risk transfer tracking and insurance portfolio management.',
    `last_reviewed_date` DATE COMMENT 'Calendar date on which this risk entry was most recently reviewed and updated by the risk owner or PMO. Used to identify overdue reviews and stale risk entries.',
    `mitigation_response_type` STRING COMMENT 'Standard risk response strategy type applied to this risk: avoid (eliminate the risk), transfer (shift to another party via contract/insurance), mitigate (reduce probability/impact), accept (acknowledge and monitor), exploit (maximise opportunity), or enhance (increase opportunity probability/impact).. Valid values are `avoid|transfer|mitigate|accept|exploit|enhance`',
    `mitigation_strategy` STRING COMMENT 'Detailed description of the planned or implemented actions to reduce the probability or impact of the risk event. Includes engineering controls, contractual protections, procurement strategies, and HSE measures.',
    `probability_rating` STRING COMMENT 'Qualitative probability rating of the risk event occurring, using the standard five-point PMO scale. Complements the quantitative probability score for risk matrix visualisation and executive reporting.. Valid values are `very_low|low|medium|high|very_high`',
    `probability_score` DECIMAL(18,2) COMMENT 'Quantitative probability of the risk event occurring, expressed as a decimal between 0.0000 and 1.0000 (e.g., 0.3500 = 35%). Used in risk scoring calculations and Monte Carlo simulation inputs for contingency management.',
    `quality_impact_rating` STRING COMMENT 'Qualitative rating of the potential quality impact if the risk event is realized. Supports QA/QC risk assessment and Non-Conformance Report (NCR) prevention planning.. Valid values are `very_low|low|medium|high|very_high`',
    `regulatory_risk_flag` BOOLEAN COMMENT 'Indicates whether this risk involves a regulatory or permitting dimension (e.g., EPA environmental permits, OSHA compliance, IBC building code, LEED certification requirements). Triggers regulatory compliance review.',
    `residual_probability_score` DECIMAL(18,2) COMMENT 'Quantitative probability of the risk event occurring after mitigation actions have been applied, expressed as a decimal between 0.0000 and 1.0000. Measures the effectiveness of the risk response strategy.',
    `residual_risk_score` DECIMAL(18,2) COMMENT 'Composite risk score remaining after mitigation actions have been applied. Compared against the pre-mitigation risk score to demonstrate risk reduction effectiveness and support PMO governance reporting.',
    `review_date` DATE COMMENT 'Scheduled date for the next formal review of this risk entry by the risk owner and PMO. Ensures risks are regularly reassessed and not left stale in the register.',
    `risk_category` STRING COMMENT 'Classification of the risk into a standard PMO risk category: technical (design, engineering, construction method), commercial (cost, contract, financial), schedule (programme, critical path), hse (Health Safety and Environment), regulatory (permits, compliance), or force_majeure (natural events, geopolitical). Drives risk reporting by category.. Valid values are `technical|commercial|schedule|hse|regulatory|force_majeure`',
    `risk_code` STRING COMMENT 'Externally-known alphanumeric risk identifier used across project documentation, PMO registers, and Procore/Primavera P6 risk modules. Follows the project risk numbering convention (e.g., RSK-PRJ001-0042). BUSINESS_IDENTIFIER for this entity.. Valid values are `^RSK-[A-Z0-9]{3,10}-[0-9]{4}$`',
    `risk_description` STRING COMMENT 'Detailed narrative describing the risk or opportunity event, its cause, and potential consequence. Captures the full context required for risk assessment and mitigation planning.',
    `risk_proximity` STRING COMMENT 'Indicates the time horizon within which the risk event is expected to occur: immediate (within 30 days), near_term (30–90 days), medium_term (90–180 days), or long_term (beyond 180 days). Supports prioritisation of risk response actions.. Valid values are `immediate|near_term|medium_term|long_term`',
    `risk_score` DECIMAL(18,2) COMMENT 'Composite risk score calculated as the product of probability and impact ratings, typically on a 1–25 scale (5x5 risk matrix). Used to prioritise risks in the PMO risk register and determine escalation thresholds.',
    `risk_status` STRING COMMENT 'Current lifecycle status of the risk register entry: open (active, being monitored), mitigated (response actions applied), closed (no longer applicable), realized (risk event has occurred), or transferred (risk transferred to another party via contract/insurance). LIFECYCLE_STATUS for this entity.. Valid values are `open|mitigated|closed|realized|transferred`',
    `risk_title` STRING COMMENT 'Short, human-readable title summarising the risk or opportunity. Used as the primary display label in PMO dashboards, risk reports, and executive summaries. IDENTITY_LABEL for this entity.',
    `risk_trigger` STRING COMMENT 'Description of the early warning indicators or conditions that signal the risk event is about to occur or has been triggered. Used to activate contingency plans and alert the risk owner.',
    `risk_type` STRING COMMENT 'Indicates whether the register entry represents a threat (negative impact) or an opportunity (positive impact) to the project. Supports balanced risk and opportunity management per PMO governance.. Valid values are `threat|opportunity`',
    `schedule_impact_days` STRING COMMENT 'Estimated number of calendar days of schedule delay if the risk event is realized. Used for Extension of Time (EOT) exposure analysis and Critical Path Method (CPM) schedule risk assessment in Oracle Primavera P6.',
    `schedule_impact_rating` STRING COMMENT 'Qualitative rating of the potential schedule impact if the risk event is realized, using the standard five-point PMO scale. Informs Extension of Time (EOT) exposure analysis and Critical Path Method (CPM) schedule risk assessment.. Valid values are `very_low|low|medium|high|very_high`',
    `source_system_ref` STRING COMMENT 'The native identifier of this risk record in the originating operational system (e.g., Procore risk ID, Primavera P6 risk code). Enables traceability from the silver layer back to the source system for reconciliation and audit.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this risk register record was most recently modified in the data platform. RECORD_AUDIT_UPDATED for this entity. Used for change tracking, audit trail, and incremental data processing in the Databricks silver layer.',
    CONSTRAINT pk_risk_register PRIMARY KEY(`risk_register_id`)
) COMMENT 'Project risk register entry capturing identified risks and opportunities at project or WBS level. Tracks risk ID, description, risk category (technical, commercial, schedule, HSE, regulatory, force majeure), probability, impact (cost, schedule, quality), risk score, mitigation strategy, contingency plan, risk owner, status (open, mitigated, closed, realized), and residual risk assessment. Supports PMO governance and contingency management.';

CREATE OR REPLACE TABLE `vibe_construction_v1`.`project`.`phase` (
    `phase_id` BIGINT COMMENT 'Unique surrogate identifier for a construction project lifecycle phase record in the Silver Layer lakehouse. Primary key for the phase data product.',
    `construction_project_id` BIGINT COMMENT 'Reference to the parent construction project to which this phase belongs. Links the phase to the core project master record.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Phase-level financial reporting: construction project phases are mapped to cost centers for phase P&L reporting and overhead allocation. Finance controllers require phase-to-cost-center mapping for ph',
    `project_baseline_id` BIGINT COMMENT 'Foreign key linking to project.project_baseline. Business justification: Project phases are defined and baselined as part of the approved project baseline. The baseline_duration_days and budgeted_cost on phase are derived from the baseline. Linking phase to project_baselin',
    `wbs_element_id` BIGINT COMMENT 'Foreign key linking to project.wbs_element. Business justification: Project phases correspond to top-level WBS elements in construction project structures (e.g., Phase 1 = WBS Level 1 node). The existing wbs_code STRING field is a denormalized reference that should be',
    `actual_cost` DECIMAL(18,2) COMMENT 'Total actual costs incurred for work performed within this phase to date, representing the Actual Cost of Work Performed (ACWP) in EVM terminology. Sourced from SAP S/4HANA and Viewpoint Vista job costing modules.',
    `actual_finish_date` DATE COMMENT 'The date on which all work within this phase was physically completed and accepted. Populated upon phase gate approval or formal handover documentation sign-off.',
    `actual_start_date` DATE COMMENT 'The date on which work on this phase actually commenced on site or in the engineering office. Populated upon NTP (Notice to Proceed) issuance or first activity progress update in Primavera P6.',
    `baseline_duration_days` STRING COMMENT 'Approved baseline duration of the phase in calendar days, derived from the original project schedule. Used as the denominator for schedule performance measurement and variance reporting.',
    `budgeted_cost` DECIMAL(18,2) COMMENT 'The approved budget allocated to this phase, representing the Budgeted Cost of Work Scheduled (BCWS) or Planned Value (PV) in EVM terminology. Sourced from SAP S/4HANA Project Systems cost planning and used for cost variance analysis.',
    `phase_code` STRING COMMENT 'Externally-known alphanumeric code uniquely identifying the phase within the project (e.g., FEED, PROC, CONST, COMM). Used as the business identifier in Oracle Primavera P6 and SAP PS phase structures.. Valid values are `^[A-Z0-9_-]{2,20}$`',
    `contingency_budget` DECIMAL(18,2) COMMENT 'Contingency reserve allocated to this phase to cover identified and unidentified risks. Managed separately from the base budget in SAP S/4HANA Project Systems and released upon formal risk event occurrence.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this phase record was first created in the system, in ISO 8601 format (yyyy-MM-ddTHH:mm:ss.SSSXXX). Provides audit trail for data governance and lineage tracking in the Databricks Silver Layer.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code applicable to all monetary values within this phase record (e.g., USD, EUR, GBP, AED). Supports multi-currency EPC projects and IFRS financial reporting.. Valid values are `^[A-Z]{3}$`',
    `deliverables_checklist` STRING COMMENT 'Structured list or description of mandatory deliverables required for phase completion (e.g., IFC drawings, BOQ, ITP, commissioning dossier). Stored as a delimited string or JSON-serialized list. Supports phase-gate governance and QA/QC compliance.',
    `deliverables_completion_pct` DECIMAL(18,2) COMMENT 'Percentage of mandatory phase deliverables that have been completed and accepted as of the latest update (0.00–100.00). Supports phase gate readiness assessment and PMO reporting.',
    `delivery_model` STRING COMMENT 'The contractual delivery model under which this phase is executed (e.g., EPC - Engineering Procurement Construction, DB - Design-Build, DBB - Design-Bid-Build, PPP - Public-Private Partnership, BOT - Build-Operate-Transfer, GMP - Guaranteed Maximum Price). Determines phase-gate governance rules and contract administration requirements.. Valid values are `epc|db|dbb|ppp|bot|gmp`',
    `phase_description` STRING COMMENT 'Detailed narrative description of the scope of work, objectives, and key activities encompassed within this project phase. Used in project documentation, client reporting, and PMO governance records.',
    `earned_value` DECIMAL(18,2) COMMENT 'The budgeted value of work actually performed to date (BCWP), calculated as phase budget multiplied by percent complete. Core EVM metric used to derive CPI (Cost Performance Index) and SPI (Schedule Performance Index) at the phase level.',
    `eot_days_granted` STRING COMMENT 'Total number of calendar days of Extension of Time (EOT) formally granted by the client or contract administrator for this phase. Adjusts the contractual completion date and mitigates LD (Liquidated Damages) exposure.',
    `evm_weight_pct` DECIMAL(18,2) COMMENT 'Weighting factor assigned to this phase for EVM (Earned Value Management) rollup to the project level, expressed as a percentage of total project value (0.00–100.00). All phase weights must sum to 100 per project. Drives CPI and SPI calculations.',
    `float_days` STRING COMMENT 'Total float (slack) available for this phase in calendar days, as calculated by CPM (Critical Path Method) analysis in Oracle Primavera P6. Negative float indicates a schedule overrun. Used for schedule risk assessment and EOT (Extension of Time) claims.',
    `forecast_finish_date` DATE COMMENT 'Current best estimate of the phase completion date based on progress to date and remaining work. Updated periodically in Primavera P6 schedule updates and used for EOT (Extension of Time) analysis.',
    `gate_approval_date` DATE COMMENT 'The date on which the phase gate was formally approved by the authorized approver, permitting progression to the next project phase. Recorded in the PMO governance register and Aconex document management system.',
    `gate_approval_status` STRING COMMENT 'Current approval status of the phase gate review. Controls authorization to proceed to the next phase. Managed through PMO governance workflows and documented in Aconex or Procore approval workflows.. Valid values are `pending|approved|rejected|conditionally_approved|waived`',
    `gate_approver_name` STRING COMMENT 'Name or role title of the individual or authority who approved the phase gate (e.g., Project Director, Client Representative, PMO Head). Provides audit trail for governance accountability.',
    `gate_review_criteria` STRING COMMENT 'Textual description of the mandatory completion criteria and deliverables that must be satisfied before the phase gate can be approved and the next phase authorized. Aligned with PMO governance and FIDIC contract requirements.',
    `hse_plan_approved` BOOLEAN COMMENT 'Indicates whether the HSE (Health Safety and Environment) plan for this phase has been formally approved prior to commencement. A prerequisite for phase authorization under OSHA and ISO 45001 compliance requirements.',
    `is_critical_path` BOOLEAN COMMENT 'Indicates whether this phase lies on the project critical path as determined by CPM (Critical Path Method) scheduling analysis in Oracle Primavera P6. Critical path phases have zero float and directly impact the project completion date.',
    `ld_exposure_amount` DECIMAL(18,2) COMMENT 'Calculated financial exposure to Liquidated Damages (LD) for this phase based on contractual LD rate and current schedule delay. Used for financial risk reporting and contract administration. Expressed in the phase currency.',
    `leed_applicable` BOOLEAN COMMENT 'Indicates whether LEED (Leadership in Energy and Environmental Design) sustainability requirements apply to this phase. When true, phase deliverables and activities must comply with USGBC LEED certification criteria.',
    `milestone_count` STRING COMMENT 'Total number of contractual or PMO-defined milestones associated with this phase. Provides a summary indicator of phase complexity and governance checkpoint density for PMO reporting.',
    `phase_name` STRING COMMENT 'Human-readable name of the construction project lifecycle phase (e.g., Front-End Engineering Design, Procurement, Construction, Commissioning). Used in reporting, dashboards, and PMO governance documents.',
    `percent_complete` DECIMAL(18,2) COMMENT 'Current physical percent complete of the phase expressed as a value between 0.00 and 100.00. Sourced from Oracle Primavera P6 activity progress and used as the basis for earned value calculations and progress reporting.',
    `phase_status` STRING COMMENT 'Current lifecycle state of the construction project phase. Drives PMO governance workflows, EVM reporting eligibility, and phase-gate approval triggers. Sourced from Oracle Primavera P6 activity status.. Valid values are `not_started|in_progress|on_hold|completed|cancelled`',
    `phase_type` STRING COMMENT 'Standardized classification of the phase within the EPC/DB/DBB/PPP project lifecycle. Drives phase-gate governance rules, EVM rollup logic, and reporting hierarchies. [ENUM-REF-CANDIDATE: feasibility|pre_construction|feed|detailed_engineering|procurement|construction|pre_commissioning|commissioning|handover|dlp — promote to reference product]',
    `planned_finish_date` DATE COMMENT 'Baseline-scheduled finish date for the phase as established in the approved project schedule. Used for schedule variance analysis, milestone tracking, and contractual deadline compliance.',
    `planned_start_date` DATE COMMENT 'Baseline-scheduled start date for the phase as established in the approved project schedule. Used as the reference point for schedule variance analysis and SPI (Schedule Performance Index) calculation.',
    `quality_plan_approved` BOOLEAN COMMENT 'Indicates whether the Quality Management Plan (including ITP - Inspection and Test Plan) for this phase has been formally approved. Required under ISO 9001 and contract QA/QC requirements before phase work commences.',
    `risk_rating` STRING COMMENT 'Assessed risk rating for this phase based on schedule, cost, and technical risk factors. Drives PMO escalation thresholds, contingency reserve allocation, and executive reporting. Aligned with the project risk register.. Valid values are `low|medium|high|critical`',
    `sap_wbs_element` STRING COMMENT 'The SAP S/4HANA Project Systems WBS element code corresponding to this phase. Enables cost and budget data reconciliation between the lakehouse and SAP PS for financial reporting and EVM analysis.. Valid values are `^[A-Z0-9._-]{1,24}$`',
    `schedule_variance_days` STRING COMMENT 'Difference in calendar days between the planned finish date and the forecast finish date (positive = ahead of schedule, negative = behind schedule). Supports SPI (Schedule Performance Index) analysis and EOT claim substantiation.',
    `sequence_number` STRING COMMENT 'Integer ordering of the phase within the project lifecycle. Determines the execution sequence for scheduling, phase-gate progression, and earned value rollup. Lower numbers execute first.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to this phase record, in ISO 8601 format (yyyy-MM-ddTHH:mm:ss.SSSXXX). Used for incremental data loading, change detection, and audit trail maintenance in the Databricks Silver Layer.',
    CONSTRAINT pk_phase PRIMARY KEY(`phase_id`)
) COMMENT 'Structured phase definition within a construction project lifecycle (feasibility, pre-construction, FEED, detailed engineering, procurement, construction, pre-commissioning, commissioning, handover, DLP). Captures phase code, name, sequence, planned and actual start/finish dates, phase status, phase weight for EVM rollup, gate review criteria, gate approval status, gate approval date, and phase deliverables checklist. Supports lifecycle governance, phase-gate approval workflows, and earned value rollup by phase across EPC, DB, DBB, and PPP delivery models.';

CREATE OR REPLACE TABLE `vibe_construction_v1`.`project`.`forecast` (
    `forecast_id` BIGINT COMMENT 'Unique surrogate identifier for the rolling project cost and schedule forecast record in the Databricks Silver Layer. Primary key for the forecast data product.',
    `change_order_id` BIGINT COMMENT 'Foreign key linking to project.project_change_order. Business justification: Forecast revisions are often triggered by approved change orders — when a CO is approved, a new forecast cycle is initiated. Linking forecast to project_change_order establishes which CO triggered the',
    `construction_project_id` BIGINT COMMENT 'Reference to the parent construction project for which this forecast record is produced. Links to the project master entity.',
    `cost_account_id` BIGINT COMMENT 'Foreign key linking to project.cost_account. Business justification: Forecasts (EAC, ETC) are produced at the cost account (control account) level in construction project controls. Linking forecast to cost_account enables control-account-level forecast tracking, suppor',
    `evm_period_record_id` BIGINT COMMENT 'Foreign key linking to project.evm_period_record. Business justification: Forecasts (EAC, ETC) are derived from EVM period records — the ACWP, BCWP, and CPI from the EVM period record are the inputs to the forecast calculation. Linking forecast to evm_period_record establis',
    `phase_id` BIGINT COMMENT 'Foreign key linking to project.phase. Business justification: Rolling forecasts are produced at the phase level in construction project reporting. Linking forecast to phase enables phase-level EAC/ETC tracking, supports phase completion cost forecasting, and all',
    `project_baseline_id` BIGINT COMMENT 'Reference to the approved project baseline against which this forecast is compared for variance analysis and Earned Value Management (EVM) reporting.',
    `project_budget_id` BIGINT COMMENT 'Foreign key linking to finance.project_budget. Business justification: Forecast-vs-budget variance reporting: project EAC forecasts must be reconciled against the approved financial budget for client reporting and management review. Finance controllers require this direc',
    `wbs_element_id` BIGINT COMMENT 'Reference to the Work Breakdown Structure (WBS) element at which this forecast is captured. May represent the project root WBS or a specific control account level within the WBS hierarchy.',
    `actual_cost_to_date` DECIMAL(18,2) COMMENT 'Total actual cost incurred on the project or WBS element from inception through the reporting period data date. Represents the Actual Cost of Work Performed (ACWP) in EVM terminology. Sourced from SAP S/4HANA cost postings.',
    `approval_date` DATE COMMENT 'The date on which this forecast record was formally approved by the authorized PMO or project controls authority for inclusion in P&L reporting.',
    `bac_cost` DECIMAL(18,2) COMMENT 'The approved Budget at Completion (BAC) for the project or WBS element as of the reporting period, representing the total authorized budget. Used as the denominator for cost variance and variance at completion calculations.',
    `baseline_completion_date` DATE COMMENT 'The approved baseline completion date for the project or WBS element against which the forecast completion date is compared. Captured at forecast time to enable point-in-time variance reporting without requiring a join to the baseline product.',
    `completion_date` DATE COMMENT 'The current forward-looking forecast date for project or WBS element completion as of the reporting period. Distinct from the baseline completion date. Used for schedule variance calculation, EOT claims, and client reporting.',
    `contingency_remaining` DECIMAL(18,2) COMMENT 'The remaining contingency budget available for the project or WBS element as of the reporting period, after accounting for approved contingency drawdowns. Tracked separately from the base EAC to support risk-adjusted forecasting.',
    `cost_trend_indicator` STRING COMMENT 'Management assessment of the directional trend in cost performance compared to the prior reporting period. Improving indicates the EAC has decreased; stable indicates no material change; deteriorating indicates the EAC has increased. Used for executive dashboard traffic-light reporting.. Valid values are `improving|stable|deteriorating`',
    `cost_variance` DECIMAL(18,2) COMMENT 'The Cost Variance (CV) representing the difference between the Budget at Completion (BAC) and the Estimate at Completion (EAC), indicating the projected over- or under-run at project completion. Negative values indicate cost overrun. Key P&L and PMO governance metric.',
    `cost_variance_pct` DECIMAL(18,2) COMMENT 'Cost variance expressed as a percentage of the Budget at Completion (BAC), calculated as (BAC - EAC) / BAC × 100. Enables normalized comparison of cost performance across projects of different sizes.',
    `cpi` DECIMAL(18,2) COMMENT 'The Cost Performance Index (CPI) as of the reporting period, calculated as Earned Value (EV) divided by Actual Cost (AC). A CPI below 1.0 indicates cost overrun; above 1.0 indicates cost efficiency. Core EVM metric for PMO governance and project health dashboards.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this forecast record was first created in the Databricks Silver Layer, in ISO 8601 format (yyyy-MM-ddTHH:mm:ss.SSSXXX). Supports audit trail and data lineage tracking.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for all monetary amounts in this forecast record (e.g., USD, EUR, GBP, AUD). Ensures consistent currency context for multi-currency project portfolios.. Valid values are `^[A-Z]{3}$`',
    `eac_cost` DECIMAL(18,2) COMMENT 'The current forward-looking Estimate at Completion (EAC) representing the total forecasted final cost of the project or WBS element as of the reporting period. Core EVM metric used for P&L reporting and PMO governance. Sourced from SAP S/4HANA Project Systems.',
    `eac_movement` DECIMAL(18,2) COMMENT 'The change in Estimate at Completion (EAC) between the current and prior reporting period (current EAC minus prior period EAC). Positive values indicate cost growth; negative values indicate cost reduction. Key metric for P&L bridge and PMO governance reporting.',
    `earned_value` DECIMAL(18,2) COMMENT 'The Earned Value (EV), also known as Budgeted Cost of Work Performed (BCWP), representing the budgeted value of work physically completed as of the reporting period. Core EVM input for CPI and SPI calculations.',
    `etc_cost` DECIMAL(18,2) COMMENT 'The Estimate to Complete (ETC) representing the forecasted remaining cost required to finish the project or WBS element from the reporting period data date. Calculated as EAC minus actual cost to date. Key input for cash flow forecasting.',
    `exchange_rate` DECIMAL(18,2) COMMENT 'The foreign exchange rate applied to convert project currency amounts to the reporting/functional currency as of the reporting period date. Required for multi-currency EPC projects and consolidated P&L reporting.',
    `final_cost` DECIMAL(18,2) COMMENT 'The management-adjusted forecast of the total final cost at project completion, which may differ from the EAC where management applies judgment overlays, risk provisions, or contingency drawdowns not yet reflected in the bottom-up EAC. Used for P&L reporting.',
    `forecast_number` STRING COMMENT 'Externally-known business identifier for this forecast record, typically formatted as a project code plus reporting period reference (e.g., PRJ-2024-FCT-007). Used in PMO governance reports and P&L submissions.',
    `forecast_status` STRING COMMENT 'Current lifecycle state of the forecast record within the PMO approval workflow. Draft indicates work-in-progress; submitted indicates pending PMO review; approved indicates accepted for P&L reporting; superseded indicates replaced by a newer forecast revision; cancelled indicates withdrawn.. Valid values are `draft|submitted|approved|superseded|cancelled`',
    `forecast_type` STRING COMMENT 'Classification of the forecast by its reporting cadence or trigger. Monthly and quarterly forecasts are produced on a rolling basis; annual forecasts align with budget cycles; ad-hoc forecasts are produced for specific management or client events.. Valid values are `monthly|quarterly|annual|ad_hoc`',
    `is_client_reported` BOOLEAN COMMENT 'Indicates whether this forecast record has been formally reported to the client as part of contractual project reporting obligations. True indicates the forecast has been shared with the client; False indicates it is an internal management forecast only.',
    `management_reserve_remaining` DECIMAL(18,2) COMMENT 'The remaining management reserve held at the project level as of the reporting period. Management reserve is distinct from contingency and is controlled by senior management for unknown-unknown risks. Tracked for PMO governance.',
    `narrative_commentary` STRING COMMENT 'Free-text management commentary explaining the key drivers of cost and schedule variances, significant changes from the prior period forecast, risk events, and corrective actions. Required for PMO governance reporting and client-facing project status reports.',
    `percent_complete` DECIMAL(18,2) COMMENT 'The overall physical percent complete of the project or WBS element as of the reporting period data date, expressed as a value between 0.00 and 100.00. Used for progress reporting, earned value calculation, and revenue recognition under IFRS 15 percentage-of-completion method.',
    `planned_value` DECIMAL(18,2) COMMENT 'The Planned Value (PV), also known as Budgeted Cost of Work Scheduled (BCWS), representing the authorized budget allocated to the work scheduled to be completed as of the reporting period data date. Core EVM input for SPI calculation.',
    `prior_period_eac` DECIMAL(18,2) COMMENT 'The approved Estimate at Completion (EAC) from the immediately preceding reporting period. Stored on the forecast record to enable period-over-period movement analysis without requiring a self-join, supporting PMO trend reporting and P&L bridge analysis.',
    `reporting_currency_code` STRING COMMENT 'ISO 4217 three-letter code for the functional or reporting currency to which project amounts are converted for consolidated P&L and PMO portfolio reporting. Distinct from the project transaction currency.. Valid values are `^[A-Z]{3}$`',
    `reporting_period_date` DATE COMMENT 'The principal business event date representing the reporting period cut-off for which this forecast is produced (typically month-end or quarter-end). Aligns with the SAP S/4HANA Project Systems data date and P&L reporting cycle.',
    `revision_number` STRING COMMENT 'Sequential revision counter for the forecast within a given reporting period. Increments each time the forecast is revised and resubmitted for the same period, enabling version tracking and audit trail.',
    `risk_provision_amount` DECIMAL(18,2) COMMENT 'The quantified risk provision included in the forecast final cost to cover identified project risks that have not yet materialized. Distinct from contingency; represents probabilistic risk exposure recognized in the P&L forecast.',
    `sap_project_version` STRING COMMENT 'The SAP S/4HANA Project Systems project version identifier from which this forecast record was extracted. Enables traceability back to the source system version for audit and reconciliation purposes.',
    `schedule_trend_indicator` STRING COMMENT 'Management assessment of the directional trend in schedule performance compared to the prior reporting period. Improving indicates the forecast completion date has advanced; stable indicates no material change; deteriorating indicates further delay. Used for executive dashboard reporting.. Valid values are `improving|stable|deteriorating`',
    `schedule_variance_days` STRING COMMENT 'The schedule variance expressed in calendar days, representing the difference between the forecast completion date and the baseline completion date. Negative values indicate schedule delay. Used for Extension of Time (EOT) and Liquidated Damages (LD) exposure assessment.',
    `spi` DECIMAL(18,2) COMMENT 'The Schedule Performance Index (SPI) as of the reporting period, calculated as Earned Value (EV) divided by Planned Value (PV). An SPI below 1.0 indicates schedule delay; above 1.0 indicates schedule efficiency. Core EVM metric for PMO governance.',
    `tcpi` DECIMAL(18,2) COMMENT 'The To-Complete Performance Index (TCPI) representing the cost efficiency that must be achieved on remaining work to meet the Budget at Completion (BAC) or Estimate at Completion (EAC) target. Calculated as (BAC - EV) / (BAC - AC). Used by PMO to assess forecast achievability.',
    `updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this forecast record was last modified in the Databricks Silver Layer, in ISO 8601 format (yyyy-MM-ddTHH:mm:ss.SSSXXX). Supports audit trail, change detection, and incremental data pipeline processing.',
    `variance_at_completion` DECIMAL(18,2) COMMENT 'The Variance at Completion (VAC) representing the difference between the Budget at Completion (BAC) and the Estimate at Completion (EAC). Negative values indicate projected cost overrun at project completion. Key metric for P&L exposure reporting.',
    CONSTRAINT pk_forecast PRIMARY KEY(`forecast_id`)
) COMMENT 'Rolling project cost and schedule forecast record capturing EAC (Estimate at Completion), ETC (Estimate to Complete), forecast completion date, forecast final cost, cost variance, schedule variance, and narrative commentary for a given reporting period. Distinct from EVM period records — this is the forward-looking management forecast used for P&L reporting and PMO governance. Sourced from SAP S/4HANA Project Systems.';

CREATE OR REPLACE TABLE `vibe_construction_v1`.`project`.`project_site` (
    `project_site_id` BIGINT COMMENT 'Primary key for site',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Site cost center mapping: construction sites are managed as cost centers for site overhead tracking, insurance cost allocation, and site-level financial reporting. project_site.cost_center_code is a d',
    `warehouse_id` BIGINT COMMENT 'Foreign key linking to material.warehouse. Business justification: Project sites have dedicated on-site warehouses or laydown areas. Site managers need to know which warehouse serves a project site for material delivery scheduling, storage planning, and site logistic',
    `actual_completion_date` DATE COMMENT 'Date when construction was actually completed.',
    `actual_spend` DECIMAL(18,2) COMMENT 'Cumulative actual expenditure incurred at the site.',
    `address_line1` STRING COMMENT 'Primary street address of the site.',
    `address_line2` STRING COMMENT 'Secondary address information (suite, building, etc.).',
    `area_sq_m` DOUBLE COMMENT 'Total land area of the site in square meters.',
    `budget_amount` DECIMAL(18,2) COMMENT 'Approved budget for the site in the project currency.',
    `city` STRING COMMENT 'City where the site is located.',
    `country` STRING COMMENT 'ISO 3166‑1 alpha‑3 country code where the site resides.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the site record was first created.',
    `currency_code` STRING COMMENT 'ISO 4217 currency code for monetary values.',
    `elevation_m` DOUBLE COMMENT 'Site elevation above sea level in meters.',
    `environmental_zone` STRING COMMENT 'Environmental compliance zone applicable to the site.',
    `ground_condition` STRING COMMENT 'Observed condition of the ground (e.g., rocky, soft, contaminated).',
    `insurance_expiry_date` DATE COMMENT 'Date when the site insurance coverage expires.',
    `insurance_policy_number` STRING COMMENT 'Policy number of the insurance covering the site.',
    `last_inspection_date` DATE COMMENT 'Date of the most recent health, safety, or regulatory inspection.',
    `latitude` DOUBLE COMMENT 'Geographic latitude of the site in decimal degrees.',
    `longitude` DOUBLE COMMENT 'Geographic longitude of the site in decimal degrees.',
    `manager_email` STRING COMMENT 'Email address of the site manager for official communications.',
    `manager_name` STRING COMMENT 'Full legal name of the person responsible for site operations.',
    `manager_phone` STRING COMMENT 'Primary telephone number for the site manager.',
    `number_of_floors` STRING COMMENT 'Count of building floors present on the site.',
    `permits` STRING COMMENT 'Comma‑separated list of permits and licenses held for the site.',
    `planned_completion_date` DATE COMMENT 'Target date for finishing construction work.',
    `postal_code` STRING COMMENT 'Postal/ZIP code for the site address.',
    `power_capacity_mw` DOUBLE COMMENT 'Maximum electrical power capacity available on site in megawatts.',
    `risk_rating` STRING COMMENT 'Overall risk rating assigned to the site.',
    `security_level` STRING COMMENT 'Security classification of the site based on risk and access controls.',
    `site_description` STRING COMMENT 'Free‑form textual description of the site.',
    `site_status` STRING COMMENT 'Current lifecycle state of the site.',
    `site_type` STRING COMMENT 'Category of the site based on its primary function.',
    `soil_type` STRING COMMENT 'Classification of soil present at the site.',
    `start_date` DATE COMMENT 'Date when construction activities are scheduled to begin.',
    `state` STRING COMMENT 'State or province of the site location.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the site record.',
    `utility_connection_status` STRING COMMENT 'Current status of utility (electric, water, gas) connections.',
    `water_supply_type` STRING COMMENT 'Primary source of water for the site.',
    CONSTRAINT pk_project_site PRIMARY KEY(`project_site_id`)
) COMMENT 'Master reference table for site. Referenced by site_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_construction_v1`.`project`.`wbs_element` ADD CONSTRAINT `fk_project_wbs_element_parent_wbs_element_id` FOREIGN KEY (`parent_wbs_element_id`) REFERENCES `vibe_construction_v1`.`project`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `vibe_construction_v1`.`project`.`milestone` ADD CONSTRAINT `fk_project_milestone_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `vibe_construction_v1`.`project`.`milestone` ADD CONSTRAINT `fk_project_milestone_phase_id` FOREIGN KEY (`phase_id`) REFERENCES `vibe_construction_v1`.`project`.`phase`(`phase_id`);
ALTER TABLE `vibe_construction_v1`.`project`.`milestone` ADD CONSTRAINT `fk_project_milestone_predecessor_milestone_project_milestone_id` FOREIGN KEY (`predecessor_milestone_project_milestone_id`) REFERENCES `vibe_construction_v1`.`project`.`milestone`(`milestone_id`);
ALTER TABLE `vibe_construction_v1`.`project`.`milestone` ADD CONSTRAINT `fk_project_milestone_project_baseline_id` FOREIGN KEY (`project_baseline_id`) REFERENCES `vibe_construction_v1`.`project`.`project_baseline`(`project_baseline_id`);
ALTER TABLE `vibe_construction_v1`.`project`.`milestone` ADD CONSTRAINT `fk_project_milestone_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `vibe_construction_v1`.`project`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `vibe_construction_v1`.`project`.`project_baseline` ADD CONSTRAINT `fk_project_project_baseline_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `vibe_construction_v1`.`project`.`project_baseline` ADD CONSTRAINT `fk_project_project_baseline_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `vibe_construction_v1`.`project`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `vibe_construction_v1`.`project`.`evm_period_record` ADD CONSTRAINT `fk_project_evm_period_record_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `vibe_construction_v1`.`project`.`evm_period_record` ADD CONSTRAINT `fk_project_evm_period_record_cost_account_id` FOREIGN KEY (`cost_account_id`) REFERENCES `vibe_construction_v1`.`project`.`cost_account`(`cost_account_id`);
ALTER TABLE `vibe_construction_v1`.`project`.`evm_period_record` ADD CONSTRAINT `fk_project_evm_period_record_phase_id` FOREIGN KEY (`phase_id`) REFERENCES `vibe_construction_v1`.`project`.`phase`(`phase_id`);
ALTER TABLE `vibe_construction_v1`.`project`.`evm_period_record` ADD CONSTRAINT `fk_project_evm_period_record_project_baseline_id` FOREIGN KEY (`project_baseline_id`) REFERENCES `vibe_construction_v1`.`project`.`project_baseline`(`project_baseline_id`);
ALTER TABLE `vibe_construction_v1`.`project`.`evm_period_record` ADD CONSTRAINT `fk_project_evm_period_record_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `vibe_construction_v1`.`project`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `vibe_construction_v1`.`project`.`progress_measurement` ADD CONSTRAINT `fk_project_progress_measurement_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `vibe_construction_v1`.`project`.`progress_measurement` ADD CONSTRAINT `fk_project_progress_measurement_cost_account_id` FOREIGN KEY (`cost_account_id`) REFERENCES `vibe_construction_v1`.`project`.`cost_account`(`cost_account_id`);
ALTER TABLE `vibe_construction_v1`.`project`.`progress_measurement` ADD CONSTRAINT `fk_project_progress_measurement_evm_period_record_id` FOREIGN KEY (`evm_period_record_id`) REFERENCES `vibe_construction_v1`.`project`.`evm_period_record`(`evm_period_record_id`);
ALTER TABLE `vibe_construction_v1`.`project`.`progress_measurement` ADD CONSTRAINT `fk_project_progress_measurement_phase_id` FOREIGN KEY (`phase_id`) REFERENCES `vibe_construction_v1`.`project`.`phase`(`phase_id`);
ALTER TABLE `vibe_construction_v1`.`project`.`progress_measurement` ADD CONSTRAINT `fk_project_progress_measurement_project_baseline_id` FOREIGN KEY (`project_baseline_id`) REFERENCES `vibe_construction_v1`.`project`.`project_baseline`(`project_baseline_id`);
ALTER TABLE `vibe_construction_v1`.`project`.`progress_measurement` ADD CONSTRAINT `fk_project_progress_measurement_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `vibe_construction_v1`.`project`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `vibe_construction_v1`.`project`.`change_order` ADD CONSTRAINT `fk_project_change_order_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `vibe_construction_v1`.`project`.`change_order` ADD CONSTRAINT `fk_project_change_order_cost_account_id` FOREIGN KEY (`cost_account_id`) REFERENCES `vibe_construction_v1`.`project`.`cost_account`(`cost_account_id`);
ALTER TABLE `vibe_construction_v1`.`project`.`change_order` ADD CONSTRAINT `fk_project_change_order_milestone_id` FOREIGN KEY (`milestone_id`) REFERENCES `vibe_construction_v1`.`project`.`milestone`(`milestone_id`);
ALTER TABLE `vibe_construction_v1`.`project`.`change_order` ADD CONSTRAINT `fk_project_change_order_phase_id` FOREIGN KEY (`phase_id`) REFERENCES `vibe_construction_v1`.`project`.`phase`(`phase_id`);
ALTER TABLE `vibe_construction_v1`.`project`.`change_order` ADD CONSTRAINT `fk_project_change_order_project_baseline_id` FOREIGN KEY (`project_baseline_id`) REFERENCES `vibe_construction_v1`.`project`.`project_baseline`(`project_baseline_id`);
ALTER TABLE `vibe_construction_v1`.`project`.`change_order` ADD CONSTRAINT `fk_project_change_order_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `vibe_construction_v1`.`project`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `vibe_construction_v1`.`project`.`cost_account` ADD CONSTRAINT `fk_project_cost_account_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `vibe_construction_v1`.`project`.`cost_account` ADD CONSTRAINT `fk_project_cost_account_phase_id` FOREIGN KEY (`phase_id`) REFERENCES `vibe_construction_v1`.`project`.`phase`(`phase_id`);
ALTER TABLE `vibe_construction_v1`.`project`.`cost_account` ADD CONSTRAINT `fk_project_cost_account_project_baseline_id` FOREIGN KEY (`project_baseline_id`) REFERENCES `vibe_construction_v1`.`project`.`project_baseline`(`project_baseline_id`);
ALTER TABLE `vibe_construction_v1`.`project`.`cost_account` ADD CONSTRAINT `fk_project_cost_account_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `vibe_construction_v1`.`project`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `vibe_construction_v1`.`project`.`deliverable` ADD CONSTRAINT `fk_project_deliverable_change_order_id` FOREIGN KEY (`change_order_id`) REFERENCES `vibe_construction_v1`.`project`.`change_order`(`change_order_id`);
ALTER TABLE `vibe_construction_v1`.`project`.`deliverable` ADD CONSTRAINT `fk_project_deliverable_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `vibe_construction_v1`.`project`.`deliverable` ADD CONSTRAINT `fk_project_deliverable_milestone_id` FOREIGN KEY (`milestone_id`) REFERENCES `vibe_construction_v1`.`project`.`milestone`(`milestone_id`);
ALTER TABLE `vibe_construction_v1`.`project`.`deliverable` ADD CONSTRAINT `fk_project_deliverable_phase_id` FOREIGN KEY (`phase_id`) REFERENCES `vibe_construction_v1`.`project`.`phase`(`phase_id`);
ALTER TABLE `vibe_construction_v1`.`project`.`deliverable` ADD CONSTRAINT `fk_project_deliverable_project_baseline_id` FOREIGN KEY (`project_baseline_id`) REFERENCES `vibe_construction_v1`.`project`.`project_baseline`(`project_baseline_id`);
ALTER TABLE `vibe_construction_v1`.`project`.`deliverable` ADD CONSTRAINT `fk_project_deliverable_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `vibe_construction_v1`.`project`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `vibe_construction_v1`.`project`.`risk_register` ADD CONSTRAINT `fk_project_risk_register_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `vibe_construction_v1`.`project`.`risk_register` ADD CONSTRAINT `fk_project_risk_register_milestone_id` FOREIGN KEY (`milestone_id`) REFERENCES `vibe_construction_v1`.`project`.`milestone`(`milestone_id`);
ALTER TABLE `vibe_construction_v1`.`project`.`risk_register` ADD CONSTRAINT `fk_project_risk_register_phase_id` FOREIGN KEY (`phase_id`) REFERENCES `vibe_construction_v1`.`project`.`phase`(`phase_id`);
ALTER TABLE `vibe_construction_v1`.`project`.`risk_register` ADD CONSTRAINT `fk_project_risk_register_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `vibe_construction_v1`.`project`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `vibe_construction_v1`.`project`.`phase` ADD CONSTRAINT `fk_project_phase_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `vibe_construction_v1`.`project`.`phase` ADD CONSTRAINT `fk_project_phase_project_baseline_id` FOREIGN KEY (`project_baseline_id`) REFERENCES `vibe_construction_v1`.`project`.`project_baseline`(`project_baseline_id`);
ALTER TABLE `vibe_construction_v1`.`project`.`phase` ADD CONSTRAINT `fk_project_phase_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `vibe_construction_v1`.`project`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `vibe_construction_v1`.`project`.`forecast` ADD CONSTRAINT `fk_project_forecast_change_order_id` FOREIGN KEY (`change_order_id`) REFERENCES `vibe_construction_v1`.`project`.`change_order`(`change_order_id`);
ALTER TABLE `vibe_construction_v1`.`project`.`forecast` ADD CONSTRAINT `fk_project_forecast_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `vibe_construction_v1`.`project`.`forecast` ADD CONSTRAINT `fk_project_forecast_cost_account_id` FOREIGN KEY (`cost_account_id`) REFERENCES `vibe_construction_v1`.`project`.`cost_account`(`cost_account_id`);
ALTER TABLE `vibe_construction_v1`.`project`.`forecast` ADD CONSTRAINT `fk_project_forecast_evm_period_record_id` FOREIGN KEY (`evm_period_record_id`) REFERENCES `vibe_construction_v1`.`project`.`evm_period_record`(`evm_period_record_id`);
ALTER TABLE `vibe_construction_v1`.`project`.`forecast` ADD CONSTRAINT `fk_project_forecast_phase_id` FOREIGN KEY (`phase_id`) REFERENCES `vibe_construction_v1`.`project`.`phase`(`phase_id`);
ALTER TABLE `vibe_construction_v1`.`project`.`forecast` ADD CONSTRAINT `fk_project_forecast_project_baseline_id` FOREIGN KEY (`project_baseline_id`) REFERENCES `vibe_construction_v1`.`project`.`project_baseline`(`project_baseline_id`);
ALTER TABLE `vibe_construction_v1`.`project`.`forecast` ADD CONSTRAINT `fk_project_forecast_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `vibe_construction_v1`.`project`.`wbs_element`(`wbs_element_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_construction_v1`.`project` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `vibe_construction_v1`.`project` SET TAGS ('dbx_domain' = 'project');
ALTER TABLE `vibe_construction_v1`.`project`.`construction_project` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_construction_v1`.`project`.`construction_project` SET TAGS ('dbx_subdomain' = 'project_setup');
ALTER TABLE `vibe_construction_v1`.`project`.`construction_project` ALTER COLUMN `construction_project_id` SET TAGS ('dbx_business_glossary_term' = 'Construction Project ID');
ALTER TABLE `vibe_construction_v1`.`project`.`construction_project` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Client ID');
ALTER TABLE `vibe_construction_v1`.`project`.`construction_project` ALTER COLUMN `company_code_id` SET TAGS ('dbx_business_glossary_term' = 'Company Code Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`project`.`construction_project` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Main Contractor Vendor Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`project`.`construction_project` ALTER COLUMN `master_services_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Master Services Agreement Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`project`.`construction_project` ALTER COLUMN `opportunity_id` SET TAGS ('dbx_business_glossary_term' = 'Client Opportunity Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`project`.`construction_project` ALTER COLUMN `actual_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Completion Date');
ALTER TABLE `vibe_construction_v1`.`project`.`construction_project` ALTER COLUMN `actual_start_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Start Date');
ALTER TABLE `vibe_construction_v1`.`project`.`construction_project` ALTER COLUMN `approved_budget` SET TAGS ('dbx_business_glossary_term' = 'Approved Budget');
ALTER TABLE `vibe_construction_v1`.`project`.`construction_project` ALTER COLUMN `approved_budget` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`project`.`construction_project` ALTER COLUMN `bid_number` SET TAGS ('dbx_business_glossary_term' = 'Bid Number');
ALTER TABLE `vibe_construction_v1`.`project`.`construction_project` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'Project City');
ALTER TABLE `vibe_construction_v1`.`project`.`construction_project` ALTER COLUMN `contract_currency` SET TAGS ('dbx_business_glossary_term' = 'Contract Currency');
ALTER TABLE `vibe_construction_v1`.`project`.`construction_project` ALTER COLUMN `contract_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_construction_v1`.`project`.`construction_project` ALTER COLUMN `contract_number` SET TAGS ('dbx_business_glossary_term' = 'Contract Number');
ALTER TABLE `vibe_construction_v1`.`project`.`construction_project` ALTER COLUMN `contract_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`project`.`construction_project` ALTER COLUMN `contract_value` SET TAGS ('dbx_business_glossary_term' = 'Contract Value');
ALTER TABLE `vibe_construction_v1`.`project`.`construction_project` ALTER COLUMN `contract_value` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`project`.`construction_project` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `vibe_construction_v1`.`project`.`construction_project` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_construction_v1`.`project`.`construction_project` ALTER COLUMN `cpi` SET TAGS ('dbx_business_glossary_term' = 'Cost Performance Index (CPI)');
ALTER TABLE `vibe_construction_v1`.`project`.`construction_project` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_construction_v1`.`project`.`construction_project` ALTER COLUMN `delivery_model` SET TAGS ('dbx_business_glossary_term' = 'Delivery Model');
ALTER TABLE `vibe_construction_v1`.`project`.`construction_project` ALTER COLUMN `dlp_end_date` SET TAGS ('dbx_business_glossary_term' = 'Defects Liability Period (DLP) End Date');
ALTER TABLE `vibe_construction_v1`.`project`.`construction_project` ALTER COLUMN `forecast_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Forecast Completion Date');
ALTER TABLE `vibe_construction_v1`.`project`.`construction_project` ALTER COLUMN `hse_risk_level` SET TAGS ('dbx_business_glossary_term' = 'HSE (Health Safety and Environment) Risk Level');
ALTER TABLE `vibe_construction_v1`.`project`.`construction_project` ALTER COLUMN `hse_risk_level` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `vibe_construction_v1`.`project`.`construction_project` ALTER COLUMN `is_joint_venture` SET TAGS ('dbx_business_glossary_term' = 'Joint Venture (JV) Indicator');
ALTER TABLE `vibe_construction_v1`.`project`.`construction_project` ALTER COLUMN `jv_partner_share_pct` SET TAGS ('dbx_business_glossary_term' = 'Joint Venture (JV) Partner Share Percentage');
ALTER TABLE `vibe_construction_v1`.`project`.`construction_project` ALTER COLUMN `jv_partner_share_pct` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`project`.`construction_project` ALTER COLUMN `leed_certification_target` SET TAGS ('dbx_business_glossary_term' = 'LEED (Leadership in Energy and Environmental Design) Certification Target');
ALTER TABLE `vibe_construction_v1`.`project`.`construction_project` ALTER COLUMN `leed_certification_target` SET TAGS ('dbx_value_regex' = 'none|certified|silver|gold|platinum');
ALTER TABLE `vibe_construction_v1`.`project`.`construction_project` ALTER COLUMN `liquidated_damages_rate` SET TAGS ('dbx_business_glossary_term' = 'Liquidated Damages (LD) Rate');
ALTER TABLE `vibe_construction_v1`.`project`.`construction_project` ALTER COLUMN `liquidated_damages_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`project`.`construction_project` ALTER COLUMN `ntp_date` SET TAGS ('dbx_business_glossary_term' = 'Notice to Proceed (NTP) Date');
ALTER TABLE `vibe_construction_v1`.`project`.`construction_project` ALTER COLUMN `physical_progress_pct` SET TAGS ('dbx_business_glossary_term' = 'Physical Progress Percentage');
ALTER TABLE `vibe_construction_v1`.`project`.`construction_project` ALTER COLUMN `planned_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Completion Date');
ALTER TABLE `vibe_construction_v1`.`project`.`construction_project` ALTER COLUMN `planned_start_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Start Date');
ALTER TABLE `vibe_construction_v1`.`project`.`construction_project` ALTER COLUMN `pmo_classification` SET TAGS ('dbx_business_glossary_term' = 'PMO (Project Management Office) Classification');
ALTER TABLE `vibe_construction_v1`.`project`.`construction_project` ALTER COLUMN `pmo_classification` SET TAGS ('dbx_value_regex' = 'tier_1|tier_2|tier_3|strategic|standard');
ALTER TABLE `vibe_construction_v1`.`project`.`construction_project` ALTER COLUMN `primavera_project_reference` SET TAGS ('dbx_business_glossary_term' = 'Oracle Primavera P6 Project ID');
ALTER TABLE `vibe_construction_v1`.`project`.`construction_project` ALTER COLUMN `procore_project_reference` SET TAGS ('dbx_business_glossary_term' = 'Procore Project ID');
ALTER TABLE `vibe_construction_v1`.`project`.`construction_project` ALTER COLUMN `project_code` SET TAGS ('dbx_business_glossary_term' = 'Project Code');
ALTER TABLE `vibe_construction_v1`.`project`.`construction_project` ALTER COLUMN `project_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{4,20}$');
ALTER TABLE `vibe_construction_v1`.`project`.`construction_project` ALTER COLUMN `project_name` SET TAGS ('dbx_business_glossary_term' = 'Project Name');
ALTER TABLE `vibe_construction_v1`.`project`.`construction_project` ALTER COLUMN `project_status` SET TAGS ('dbx_business_glossary_term' = 'Project Status');
ALTER TABLE `vibe_construction_v1`.`project`.`construction_project` ALTER COLUMN `project_status` SET TAGS ('dbx_value_regex' = 'prospect|awarded|active|on_hold|completed|cancelled');
ALTER TABLE `vibe_construction_v1`.`project`.`construction_project` ALTER COLUMN `project_type` SET TAGS ('dbx_business_glossary_term' = 'Project Type');
ALTER TABLE `vibe_construction_v1`.`project`.`construction_project` ALTER COLUMN `project_type` SET TAGS ('dbx_value_regex' = 'infrastructure|commercial|residential|energy|industrial');
ALTER TABLE `vibe_construction_v1`.`project`.`construction_project` ALTER COLUMN `region` SET TAGS ('dbx_business_glossary_term' = 'Project Region');
ALTER TABLE `vibe_construction_v1`.`project`.`construction_project` ALTER COLUMN `retention_pct` SET TAGS ('dbx_business_glossary_term' = 'Retention Percentage');
ALTER TABLE `vibe_construction_v1`.`project`.`construction_project` ALTER COLUMN `retention_pct` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`project`.`construction_project` ALTER COLUMN `sap_project_definition` SET TAGS ('dbx_business_glossary_term' = 'SAP Project Definition Code');
ALTER TABLE `vibe_construction_v1`.`project`.`construction_project` ALTER COLUMN `site_latitude` SET TAGS ('dbx_business_glossary_term' = 'Site Latitude');
ALTER TABLE `vibe_construction_v1`.`project`.`construction_project` ALTER COLUMN `site_latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_construction_v1`.`project`.`construction_project` ALTER COLUMN `site_latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_construction_v1`.`project`.`construction_project` ALTER COLUMN `site_longitude` SET TAGS ('dbx_business_glossary_term' = 'Site Longitude');
ALTER TABLE `vibe_construction_v1`.`project`.`construction_project` ALTER COLUMN `site_longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_construction_v1`.`project`.`construction_project` ALTER COLUMN `site_longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_construction_v1`.`project`.`construction_project` ALTER COLUMN `spi` SET TAGS ('dbx_business_glossary_term' = 'Schedule Performance Index (SPI)');
ALTER TABLE `vibe_construction_v1`.`project`.`construction_project` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_construction_v1`.`project`.`construction_project` ALTER COLUMN `wbs_code` SET TAGS ('dbx_business_glossary_term' = 'Work Breakdown Structure (WBS) Code');
ALTER TABLE `vibe_construction_v1`.`project`.`wbs_element` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_construction_v1`.`project`.`wbs_element` SET TAGS ('dbx_subdomain' = 'project_setup');
ALTER TABLE `vibe_construction_v1`.`project`.`wbs_element` ALTER COLUMN `wbs_element_id` SET TAGS ('dbx_business_glossary_term' = 'Work Breakdown Structure (WBS) Element ID');
ALTER TABLE `vibe_construction_v1`.`project`.`wbs_element` ALTER COLUMN `cost_code_id` SET TAGS ('dbx_business_glossary_term' = 'Finance Cost Code Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`project`.`wbs_element` ALTER COLUMN `master_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Material Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`project`.`wbs_element` ALTER COLUMN `parent_wbs_element_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Work Breakdown Structure (WBS) Element ID');
ALTER TABLE `vibe_construction_v1`.`project`.`wbs_element` ALTER COLUMN `actual_cost` SET TAGS ('dbx_business_glossary_term' = 'Actual Cost of Work Performed (ACWP)');
ALTER TABLE `vibe_construction_v1`.`project`.`wbs_element` ALTER COLUMN `actual_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`project`.`wbs_element` ALTER COLUMN `actual_finish_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Finish Date');
ALTER TABLE `vibe_construction_v1`.`project`.`wbs_element` ALTER COLUMN `actual_quantity` SET TAGS ('dbx_business_glossary_term' = 'Actual Quantity Installed');
ALTER TABLE `vibe_construction_v1`.`project`.`wbs_element` ALTER COLUMN `actual_start_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Start Date');
ALTER TABLE `vibe_construction_v1`.`project`.`wbs_element` ALTER COLUMN `approved_budget_changes` SET TAGS ('dbx_business_glossary_term' = 'Approved Budget Changes (Change Order Value)');
ALTER TABLE `vibe_construction_v1`.`project`.`wbs_element` ALTER COLUMN `approved_budget_changes` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`project`.`wbs_element` ALTER COLUMN `boq_item_reference` SET TAGS ('dbx_business_glossary_term' = 'Bill of Quantities (BOQ) Item Reference');
ALTER TABLE `vibe_construction_v1`.`project`.`wbs_element` ALTER COLUMN `budgeted_cost` SET TAGS ('dbx_business_glossary_term' = 'Budgeted Cost of Work (BCW)');
ALTER TABLE `vibe_construction_v1`.`project`.`wbs_element` ALTER COLUMN `budgeted_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`project`.`wbs_element` ALTER COLUMN `charge_type` SET TAGS ('dbx_business_glossary_term' = 'Charge Type');
ALTER TABLE `vibe_construction_v1`.`project`.`wbs_element` ALTER COLUMN `charge_type` SET TAGS ('dbx_value_regex' = 'direct|indirect|overhead|contingency|provisional');
ALTER TABLE `vibe_construction_v1`.`project`.`wbs_element` ALTER COLUMN `cost_account_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Account Code');
ALTER TABLE `vibe_construction_v1`.`project`.`wbs_element` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_construction_v1`.`project`.`wbs_element` ALTER COLUMN `csi_division_code` SET TAGS ('dbx_business_glossary_term' = 'Construction Specifications Institute (CSI) Division Code');
ALTER TABLE `vibe_construction_v1`.`project`.`wbs_element` ALTER COLUMN `csi_division_code` SET TAGS ('dbx_value_regex' = '^[0-9]{2}$');
ALTER TABLE `vibe_construction_v1`.`project`.`wbs_element` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `vibe_construction_v1`.`project`.`wbs_element` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_construction_v1`.`project`.`wbs_element` ALTER COLUMN `delivery_model` SET TAGS ('dbx_business_glossary_term' = 'Project Delivery Model');
ALTER TABLE `vibe_construction_v1`.`project`.`wbs_element` ALTER COLUMN `delivery_model` SET TAGS ('dbx_value_regex' = 'EPC|DB|DBB|PPP|BOT|GMP');
ALTER TABLE `vibe_construction_v1`.`project`.`wbs_element` ALTER COLUMN `earned_value` SET TAGS ('dbx_business_glossary_term' = 'Earned Value (EV) – Budgeted Cost of Work Performed (BCWP)');
ALTER TABLE `vibe_construction_v1`.`project`.`wbs_element` ALTER COLUMN `earned_value` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`project`.`wbs_element` ALTER COLUMN `evm_enabled` SET TAGS ('dbx_business_glossary_term' = 'Earned Value Management (EVM) Enabled Indicator');
ALTER TABLE `vibe_construction_v1`.`project`.`wbs_element` ALTER COLUMN `forecast_finish_date` SET TAGS ('dbx_business_glossary_term' = 'Forecast Finish Date');
ALTER TABLE `vibe_construction_v1`.`project`.`wbs_element` ALTER COLUMN `is_lump_sum` SET TAGS ('dbx_business_glossary_term' = 'Is Lump Sum Indicator');
ALTER TABLE `vibe_construction_v1`.`project`.`wbs_element` ALTER COLUMN `is_milestone` SET TAGS ('dbx_business_glossary_term' = 'Is Milestone Indicator');
ALTER TABLE `vibe_construction_v1`.`project`.`wbs_element` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `vibe_construction_v1`.`project`.`wbs_element` ALTER COLUMN `original_budget_cost` SET TAGS ('dbx_business_glossary_term' = 'Original Budget Cost');
ALTER TABLE `vibe_construction_v1`.`project`.`wbs_element` ALTER COLUMN `original_budget_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`project`.`wbs_element` ALTER COLUMN `percent_complete` SET TAGS ('dbx_business_glossary_term' = 'Percent Complete');
ALTER TABLE `vibe_construction_v1`.`project`.`wbs_element` ALTER COLUMN `percent_complete_method` SET TAGS ('dbx_business_glossary_term' = 'Percent Complete Measurement Method');
ALTER TABLE `vibe_construction_v1`.`project`.`wbs_element` ALTER COLUMN `percent_complete_method` SET TAGS ('dbx_value_regex' = 'physical|units_complete|duration|weighted_milestone|level_of_effort|fixed_formula');
ALTER TABLE `vibe_construction_v1`.`project`.`wbs_element` ALTER COLUMN `planned_finish_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Finish Date');
ALTER TABLE `vibe_construction_v1`.`project`.`wbs_element` ALTER COLUMN `planned_quantity` SET TAGS ('dbx_business_glossary_term' = 'Planned Quantity');
ALTER TABLE `vibe_construction_v1`.`project`.`wbs_element` ALTER COLUMN `planned_start_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Start Date');
ALTER TABLE `vibe_construction_v1`.`project`.`wbs_element` ALTER COLUMN `planned_value` SET TAGS ('dbx_business_glossary_term' = 'Planned Value (PV) – Budgeted Cost of Work Scheduled (BCWS)');
ALTER TABLE `vibe_construction_v1`.`project`.`wbs_element` ALTER COLUMN `planned_value` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`project`.`wbs_element` ALTER COLUMN `responsible_discipline` SET TAGS ('dbx_business_glossary_term' = 'Responsible Engineering Discipline');
ALTER TABLE `vibe_construction_v1`.`project`.`wbs_element` ALTER COLUMN `scope_description` SET TAGS ('dbx_business_glossary_term' = 'Scope Description');
ALTER TABLE `vibe_construction_v1`.`project`.`wbs_element` ALTER COLUMN `sort_order` SET TAGS ('dbx_business_glossary_term' = 'WBS Sort Order');
ALTER TABLE `vibe_construction_v1`.`project`.`wbs_element` ALTER COLUMN `source_system_wbs_reference` SET TAGS ('dbx_business_glossary_term' = 'Source System WBS Element Identifier');
ALTER TABLE `vibe_construction_v1`.`project`.`wbs_element` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `vibe_construction_v1`.`project`.`wbs_element` ALTER COLUMN `wbs_code` SET TAGS ('dbx_business_glossary_term' = 'Work Breakdown Structure (WBS) Code');
ALTER TABLE `vibe_construction_v1`.`project`.`wbs_element` ALTER COLUMN `wbs_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]+(.[A-Z0-9]+)*$');
ALTER TABLE `vibe_construction_v1`.`project`.`wbs_element` ALTER COLUMN `wbs_level` SET TAGS ('dbx_business_glossary_term' = 'Work Breakdown Structure (WBS) Hierarchy Level');
ALTER TABLE `vibe_construction_v1`.`project`.`wbs_element` ALTER COLUMN `wbs_name` SET TAGS ('dbx_business_glossary_term' = 'Work Breakdown Structure (WBS) Element Name');
ALTER TABLE `vibe_construction_v1`.`project`.`wbs_element` ALTER COLUMN `wbs_status` SET TAGS ('dbx_business_glossary_term' = 'Work Breakdown Structure (WBS) Element Status');
ALTER TABLE `vibe_construction_v1`.`project`.`wbs_element` ALTER COLUMN `wbs_status` SET TAGS ('dbx_value_regex' = 'active|on_hold|completed|cancelled|not_started');
ALTER TABLE `vibe_construction_v1`.`project`.`wbs_element` ALTER COLUMN `wbs_type` SET TAGS ('dbx_business_glossary_term' = 'Work Breakdown Structure (WBS) Element Type');
ALTER TABLE `vibe_construction_v1`.`project`.`wbs_element` ALTER COLUMN `wbs_type` SET TAGS ('dbx_value_regex' = 'summary|work_package|control_account|planning_package');
ALTER TABLE `vibe_construction_v1`.`project`.`milestone` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_construction_v1`.`project`.`milestone` SET TAGS ('dbx_subdomain' = 'project_setup');
ALTER TABLE `vibe_construction_v1`.`project`.`milestone` ALTER COLUMN `milestone_id` SET TAGS ('dbx_business_glossary_term' = 'Project Milestone ID');
ALTER TABLE `vibe_construction_v1`.`project`.`milestone` ALTER COLUMN `construction_project_id` SET TAGS ('dbx_business_glossary_term' = 'Project ID');
ALTER TABLE `vibe_construction_v1`.`project`.`milestone` ALTER COLUMN `permit_to_work_id` SET TAGS ('dbx_business_glossary_term' = 'Permit To Work Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`project`.`milestone` ALTER COLUMN `phase_id` SET TAGS ('dbx_business_glossary_term' = 'Phase Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`project`.`milestone` ALTER COLUMN `predecessor_milestone_project_milestone_id` SET TAGS ('dbx_business_glossary_term' = 'Predecessor Milestone ID');
ALTER TABLE `vibe_construction_v1`.`project`.`milestone` ALTER COLUMN `project_baseline_id` SET TAGS ('dbx_business_glossary_term' = 'Project Baseline Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`project`.`milestone` ALTER COLUMN `wbs_element_id` SET TAGS ('dbx_business_glossary_term' = 'Work Breakdown Structure (WBS) ID');
ALTER TABLE `vibe_construction_v1`.`project`.`milestone` ALTER COLUMN `acceptance_criteria` SET TAGS ('dbx_business_glossary_term' = 'Milestone Acceptance Criteria');
ALTER TABLE `vibe_construction_v1`.`project`.`milestone` ALTER COLUMN `actual_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Milestone Achievement Date');
ALTER TABLE `vibe_construction_v1`.`project`.`milestone` ALTER COLUMN `actual_date` SET TAGS ('dbx_ssot_source' = 'schedule.schedule_milestone');
ALTER TABLE `vibe_construction_v1`.`project`.`milestone` ALTER COLUMN `baseline_date` SET TAGS ('dbx_business_glossary_term' = 'Baseline Milestone Date');
ALTER TABLE `vibe_construction_v1`.`project`.`milestone` ALTER COLUMN `baseline_date` SET TAGS ('dbx_ssot_source' = 'schedule.schedule_milestone');
ALTER TABLE `vibe_construction_v1`.`project`.`milestone` ALTER COLUMN `milestone_category` SET TAGS ('dbx_business_glossary_term' = 'Milestone Category');
ALTER TABLE `vibe_construction_v1`.`project`.`milestone` ALTER COLUMN `milestone_code` SET TAGS ('dbx_business_glossary_term' = 'Milestone Code');
ALTER TABLE `vibe_construction_v1`.`project`.`milestone` ALTER COLUMN `milestone_code` SET TAGS ('dbx_value_regex' = '^MS-[A-Z0-9]{3,20}$');
ALTER TABLE `vibe_construction_v1`.`project`.`milestone` ALTER COLUMN `completion_percentage` SET TAGS ('dbx_business_glossary_term' = 'Milestone Completion Percentage');
ALTER TABLE `vibe_construction_v1`.`project`.`milestone` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_construction_v1`.`project`.`milestone` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_ssot_source' = 'schedule.schedule_milestone');
ALTER TABLE `vibe_construction_v1`.`project`.`milestone` ALTER COLUMN `delivery_model` SET TAGS ('dbx_business_glossary_term' = 'Project Delivery Model');
ALTER TABLE `vibe_construction_v1`.`project`.`milestone` ALTER COLUMN `delivery_model` SET TAGS ('dbx_value_regex' = 'EPC|DB|DBB|PPP|BOT|GMP');
ALTER TABLE `vibe_construction_v1`.`project`.`milestone` ALTER COLUMN `eot_days_approved` SET TAGS ('dbx_business_glossary_term' = 'Extension of Time (EOT) Approved Days');
ALTER TABLE `vibe_construction_v1`.`project`.`milestone` ALTER COLUMN `eot_reference` SET TAGS ('dbx_business_glossary_term' = 'Extension of Time (EOT) Reference Number');
ALTER TABLE `vibe_construction_v1`.`project`.`milestone` ALTER COLUMN `forecast_date` SET TAGS ('dbx_business_glossary_term' = 'Forecast Milestone Date');
ALTER TABLE `vibe_construction_v1`.`project`.`milestone` ALTER COLUMN `forecast_date` SET TAGS ('dbx_ssot_source' = 'schedule.schedule_milestone');
ALTER TABLE `vibe_construction_v1`.`project`.`milestone` ALTER COLUMN `hse_clearance_required` SET TAGS ('dbx_business_glossary_term' = 'Health Safety Environment (HSE) Clearance Required Flag');
ALTER TABLE `vibe_construction_v1`.`project`.`milestone` ALTER COLUMN `is_contractual` SET TAGS ('dbx_business_glossary_term' = 'Contractual Milestone Flag');
ALTER TABLE `vibe_construction_v1`.`project`.`milestone` ALTER COLUMN `is_critical_path` SET TAGS ('dbx_business_glossary_term' = 'Critical Path Milestone Flag');
ALTER TABLE `vibe_construction_v1`.`project`.`milestone` ALTER COLUMN `is_ld_trigger` SET TAGS ('dbx_business_glossary_term' = 'Liquidated Damages (LD) Trigger Flag');
ALTER TABLE `vibe_construction_v1`.`project`.`milestone` ALTER COLUMN `is_payment_trigger` SET TAGS ('dbx_business_glossary_term' = 'Payment Milestone Trigger Flag');
ALTER TABLE `vibe_construction_v1`.`project`.`milestone` ALTER COLUMN `ld_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Liquidated Damages (LD) Currency Code');
ALTER TABLE `vibe_construction_v1`.`project`.`milestone` ALTER COLUMN `ld_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_construction_v1`.`project`.`milestone` ALTER COLUMN `ld_rate_per_day` SET TAGS ('dbx_business_glossary_term' = 'Liquidated Damages (LD) Daily Rate');
ALTER TABLE `vibe_construction_v1`.`project`.`milestone` ALTER COLUMN `ld_rate_per_day` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`project`.`milestone` ALTER COLUMN `ld_rate_per_day` SET TAGS ('dbx_ssot_source' = 'schedule.schedule_milestone');
ALTER TABLE `vibe_construction_v1`.`project`.`milestone` ALTER COLUMN `leed_related` SET TAGS ('dbx_business_glossary_term' = 'LEED Certification Related Flag');
ALTER TABLE `vibe_construction_v1`.`project`.`milestone` ALTER COLUMN `milestone_status` SET TAGS ('dbx_business_glossary_term' = 'Milestone Status');
ALTER TABLE `vibe_construction_v1`.`project`.`milestone` ALTER COLUMN `milestone_status` SET TAGS ('dbx_value_regex' = 'not_started|in_progress|completed|overdue|waived|deferred');
ALTER TABLE `vibe_construction_v1`.`project`.`milestone` ALTER COLUMN `milestone_type` SET TAGS ('dbx_business_glossary_term' = 'Milestone Type');
ALTER TABLE `vibe_construction_v1`.`project`.`milestone` ALTER COLUMN `milestone_type` SET TAGS ('dbx_value_regex' = 'contractual|internal|regulatory|client|financial');
ALTER TABLE `vibe_construction_v1`.`project`.`milestone` ALTER COLUMN `milestone_name` SET TAGS ('dbx_business_glossary_term' = 'Milestone Name');
ALTER TABLE `vibe_construction_v1`.`project`.`milestone` ALTER COLUMN `notification_advance_days` SET TAGS ('dbx_business_glossary_term' = 'Notification Advance Notice Days');
ALTER TABLE `vibe_construction_v1`.`project`.`milestone` ALTER COLUMN `notification_required` SET TAGS ('dbx_business_glossary_term' = 'Client Notification Required Flag');
ALTER TABLE `vibe_construction_v1`.`project`.`milestone` ALTER COLUMN `payment_amount` SET TAGS ('dbx_business_glossary_term' = 'Milestone Payment Amount');
ALTER TABLE `vibe_construction_v1`.`project`.`milestone` ALTER COLUMN `payment_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`project`.`milestone` ALTER COLUMN `planned_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Milestone Date');
ALTER TABLE `vibe_construction_v1`.`project`.`milestone` ALTER COLUMN `planned_date` SET TAGS ('dbx_ssot_source' = 'schedule.schedule_milestone');
ALTER TABLE `vibe_construction_v1`.`project`.`milestone` ALTER COLUMN `procore_milestone_reference` SET TAGS ('dbx_business_glossary_term' = 'Procore Milestone ID');
ALTER TABLE `vibe_construction_v1`.`project`.`milestone` ALTER COLUMN `project_milestone_description` SET TAGS ('dbx_business_glossary_term' = 'Milestone Description');
ALTER TABLE `vibe_construction_v1`.`project`.`milestone` ALTER COLUMN `remarks` SET TAGS ('dbx_business_glossary_term' = 'Milestone Remarks');
ALTER TABLE `vibe_construction_v1`.`project`.`milestone` ALTER COLUMN `responsible_party` SET TAGS ('dbx_business_glossary_term' = 'Responsible Party');
ALTER TABLE `vibe_construction_v1`.`project`.`milestone` ALTER COLUMN `responsible_party` SET TAGS ('dbx_value_regex' = 'contractor|client|subcontractor|engineer|joint_venture|regulator');
ALTER TABLE `vibe_construction_v1`.`project`.`milestone` ALTER COLUMN `schedule_variance_days` SET TAGS ('dbx_business_glossary_term' = 'Schedule Variance (Days)');
ALTER TABLE `vibe_construction_v1`.`project`.`milestone` ALTER COLUMN `sign_off_document_ref` SET TAGS ('dbx_business_glossary_term' = 'Milestone Sign-Off Document Reference');
ALTER TABLE `vibe_construction_v1`.`project`.`milestone` ALTER COLUMN `total_float_days` SET TAGS ('dbx_business_glossary_term' = 'Total Float (Days)');
ALTER TABLE `vibe_construction_v1`.`project`.`milestone` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `vibe_construction_v1`.`project`.`milestone` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_ssot_source' = 'schedule.schedule_milestone');
ALTER TABLE `vibe_construction_v1`.`project`.`project_baseline` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_construction_v1`.`project`.`project_baseline` SET TAGS ('dbx_subdomain' = 'cost_control');
ALTER TABLE `vibe_construction_v1`.`project`.`project_baseline` ALTER COLUMN `project_baseline_id` SET TAGS ('dbx_business_glossary_term' = 'Baseline ID');
ALTER TABLE `vibe_construction_v1`.`project`.`project_baseline` ALTER COLUMN `construction_project_id` SET TAGS ('dbx_business_glossary_term' = 'Project ID');
ALTER TABLE `vibe_construction_v1`.`project`.`project_baseline` ALTER COLUMN `wbs_element_id` SET TAGS ('dbx_business_glossary_term' = 'Work Breakdown Structure (WBS) ID');
ALTER TABLE `vibe_construction_v1`.`project`.`project_baseline` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Baseline Approval Date');
ALTER TABLE `vibe_construction_v1`.`project`.`project_baseline` ALTER COLUMN `approval_level` SET TAGS ('dbx_business_glossary_term' = 'Baseline Approval Level');
ALTER TABLE `vibe_construction_v1`.`project`.`project_baseline` ALTER COLUMN `approval_level` SET TAGS ('dbx_value_regex' = 'project_manager|project_director|pmo_board|client|executive_committee');
ALTER TABLE `vibe_construction_v1`.`project`.`project_baseline` ALTER COLUMN `baseline_number` SET TAGS ('dbx_business_glossary_term' = 'Baseline Number');
ALTER TABLE `vibe_construction_v1`.`project`.`project_baseline` ALTER COLUMN `baseline_number` SET TAGS ('dbx_value_regex' = '^BL-[A-Z0-9]{3,10}-[0-9]{3}$');
ALTER TABLE `vibe_construction_v1`.`project`.`project_baseline` ALTER COLUMN `baseline_status` SET TAGS ('dbx_business_glossary_term' = 'Baseline Status');
ALTER TABLE `vibe_construction_v1`.`project`.`project_baseline` ALTER COLUMN `baseline_status` SET TAGS ('dbx_value_regex' = 'draft|pending_approval|approved|superseded|cancelled');
ALTER TABLE `vibe_construction_v1`.`project`.`project_baseline` ALTER COLUMN `baseline_type` SET TAGS ('dbx_business_glossary_term' = 'Baseline Type');
ALTER TABLE `vibe_construction_v1`.`project`.`project_baseline` ALTER COLUMN `baseline_type` SET TAGS ('dbx_value_regex' = 'original|revised|re_baseline|co_incorporation|re_forecast|management_reserve_release');
ALTER TABLE `vibe_construction_v1`.`project`.`project_baseline` ALTER COLUMN `budget_after_revision` SET TAGS ('dbx_business_glossary_term' = 'Budget After Revision');
ALTER TABLE `vibe_construction_v1`.`project`.`project_baseline` ALTER COLUMN `budget_after_revision` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`project`.`project_baseline` ALTER COLUMN `budget_at_completion` SET TAGS ('dbx_business_glossary_term' = 'Budget at Completion (BAC)');
ALTER TABLE `vibe_construction_v1`.`project`.`project_baseline` ALTER COLUMN `budget_at_completion` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`project`.`project_baseline` ALTER COLUMN `budget_before_revision` SET TAGS ('dbx_business_glossary_term' = 'Budget Before Revision');
ALTER TABLE `vibe_construction_v1`.`project`.`project_baseline` ALTER COLUMN `budget_before_revision` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`project`.`project_baseline` ALTER COLUMN `co_value_incorporated` SET TAGS ('dbx_business_glossary_term' = 'Change Order (CO) Value Incorporated');
ALTER TABLE `vibe_construction_v1`.`project`.`project_baseline` ALTER COLUMN `co_value_incorporated` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`project`.`project_baseline` ALTER COLUMN `contingency_amount` SET TAGS ('dbx_business_glossary_term' = 'Contingency Reserve Amount');
ALTER TABLE `vibe_construction_v1`.`project`.`project_baseline` ALTER COLUMN `contingency_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`project`.`project_baseline` ALTER COLUMN `contract_value` SET TAGS ('dbx_business_glossary_term' = 'Contract Value');
ALTER TABLE `vibe_construction_v1`.`project`.`project_baseline` ALTER COLUMN `contract_value` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`project`.`project_baseline` ALTER COLUMN `cost_account_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Account Code');
ALTER TABLE `vibe_construction_v1`.`project`.`project_baseline` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_construction_v1`.`project`.`project_baseline` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_construction_v1`.`project`.`project_baseline` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_construction_v1`.`project`.`project_baseline` ALTER COLUMN `delivery_model` SET TAGS ('dbx_business_glossary_term' = 'Project Delivery Model');
ALTER TABLE `vibe_construction_v1`.`project`.`project_baseline` ALTER COLUMN `delivery_model` SET TAGS ('dbx_value_regex' = 'epc|db|dbb|ppp|bot|gmp');
ALTER TABLE `vibe_construction_v1`.`project`.`project_baseline` ALTER COLUMN `duration_days` SET TAGS ('dbx_business_glossary_term' = 'Baseline Duration (Days)');
ALTER TABLE `vibe_construction_v1`.`project`.`project_baseline` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Baseline Effective End Date');
ALTER TABLE `vibe_construction_v1`.`project`.`project_baseline` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Baseline Effective Start Date');
ALTER TABLE `vibe_construction_v1`.`project`.`project_baseline` ALTER COLUMN `eot_days_granted` SET TAGS ('dbx_business_glossary_term' = 'Extension of Time (EOT) Days Granted');
ALTER TABLE `vibe_construction_v1`.`project`.`project_baseline` ALTER COLUMN `finish_date` SET TAGS ('dbx_business_glossary_term' = 'Baseline Schedule Finish Date');
ALTER TABLE `vibe_construction_v1`.`project`.`project_baseline` ALTER COLUMN `is_client_approved` SET TAGS ('dbx_business_glossary_term' = 'Is Client Approved Flag');
ALTER TABLE `vibe_construction_v1`.`project`.`project_baseline` ALTER COLUMN `is_current_baseline` SET TAGS ('dbx_business_glossary_term' = 'Is Current Baseline Flag');
ALTER TABLE `vibe_construction_v1`.`project`.`project_baseline` ALTER COLUMN `management_reserve_amount` SET TAGS ('dbx_business_glossary_term' = 'Management Reserve Amount');
ALTER TABLE `vibe_construction_v1`.`project`.`project_baseline` ALTER COLUMN `management_reserve_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`project`.`project_baseline` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Baseline Notes');
ALTER TABLE `vibe_construction_v1`.`project`.`project_baseline` ALTER COLUMN `planned_value` SET TAGS ('dbx_business_glossary_term' = 'Planned Value (PV)');
ALTER TABLE `vibe_construction_v1`.`project`.`project_baseline` ALTER COLUMN `planned_value` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`project`.`project_baseline` ALTER COLUMN `primavera_baseline_reference` SET TAGS ('dbx_business_glossary_term' = 'Oracle Primavera P6 Baseline ID');
ALTER TABLE `vibe_construction_v1`.`project`.`project_baseline` ALTER COLUMN `revision_date` SET TAGS ('dbx_business_glossary_term' = 'Baseline Revision Date');
ALTER TABLE `vibe_construction_v1`.`project`.`project_baseline` ALTER COLUMN `revision_justification` SET TAGS ('dbx_business_glossary_term' = 'Baseline Revision Justification');
ALTER TABLE `vibe_construction_v1`.`project`.`project_baseline` ALTER COLUMN `revision_number` SET TAGS ('dbx_business_glossary_term' = 'Baseline Revision Number');
ALTER TABLE `vibe_construction_v1`.`project`.`project_baseline` ALTER COLUMN `sap_project_version` SET TAGS ('dbx_business_glossary_term' = 'SAP Project Version');
ALTER TABLE `vibe_construction_v1`.`project`.`project_baseline` ALTER COLUMN `schedule_data_date` SET TAGS ('dbx_business_glossary_term' = 'Schedule Data Date');
ALTER TABLE `vibe_construction_v1`.`project`.`project_baseline` ALTER COLUMN `scope_description` SET TAGS ('dbx_business_glossary_term' = 'Baseline Scope Description');
ALTER TABLE `vibe_construction_v1`.`project`.`project_baseline` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Baseline Schedule Start Date');
ALTER TABLE `vibe_construction_v1`.`project`.`project_baseline` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_construction_v1`.`project`.`project_baseline` ALTER COLUMN `variance_at_completion` SET TAGS ('dbx_business_glossary_term' = 'Variance at Completion (VAC)');
ALTER TABLE `vibe_construction_v1`.`project`.`project_baseline` ALTER COLUMN `variance_at_completion` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`project`.`evm_period_record` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_construction_v1`.`project`.`evm_period_record` SET TAGS ('dbx_subdomain' = 'performance_tracking');
ALTER TABLE `vibe_construction_v1`.`project`.`evm_period_record` ALTER COLUMN `evm_period_record_id` SET TAGS ('dbx_business_glossary_term' = 'Earned Value Management (EVM) Period Record ID');
ALTER TABLE `vibe_construction_v1`.`project`.`evm_period_record` ALTER COLUMN `construction_project_id` SET TAGS ('dbx_business_glossary_term' = 'Project ID');
ALTER TABLE `vibe_construction_v1`.`project`.`evm_period_record` ALTER COLUMN `cost_account_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Account Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`project`.`evm_period_record` ALTER COLUMN `phase_id` SET TAGS ('dbx_business_glossary_term' = 'Phase Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`project`.`evm_period_record` ALTER COLUMN `project_baseline_id` SET TAGS ('dbx_business_glossary_term' = 'Project Baseline Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`project`.`evm_period_record` ALTER COLUMN `project_budget_id` SET TAGS ('dbx_business_glossary_term' = 'Project Budget Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`project`.`evm_period_record` ALTER COLUMN `wbs_element_id` SET TAGS ('dbx_business_glossary_term' = 'Work Breakdown Structure (WBS) Element ID');
ALTER TABLE `vibe_construction_v1`.`project`.`evm_period_record` ALTER COLUMN `acwp` SET TAGS ('dbx_business_glossary_term' = 'Actual Cost of Work Performed (ACWP) / Actual Cost (AC)');
ALTER TABLE `vibe_construction_v1`.`project`.`evm_period_record` ALTER COLUMN `acwp` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`project`.`evm_period_record` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By (PMO Approver)');
ALTER TABLE `vibe_construction_v1`.`project`.`evm_period_record` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `vibe_construction_v1`.`project`.`evm_period_record` ALTER COLUMN `baseline_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Baseline Completion Date');
ALTER TABLE `vibe_construction_v1`.`project`.`evm_period_record` ALTER COLUMN `bcwp` SET TAGS ('dbx_business_glossary_term' = 'Budgeted Cost of Work Performed (BCWP) / Earned Value (EV)');
ALTER TABLE `vibe_construction_v1`.`project`.`evm_period_record` ALTER COLUMN `bcwp` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`project`.`evm_period_record` ALTER COLUMN `bcws` SET TAGS ('dbx_business_glossary_term' = 'Budgeted Cost of Work Scheduled (BCWS) / Planned Value (PV)');
ALTER TABLE `vibe_construction_v1`.`project`.`evm_period_record` ALTER COLUMN `bcws` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`project`.`evm_period_record` ALTER COLUMN `budget_at_completion` SET TAGS ('dbx_business_glossary_term' = 'Budget at Completion (BAC)');
ALTER TABLE `vibe_construction_v1`.`project`.`evm_period_record` ALTER COLUMN `budget_at_completion` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`project`.`evm_period_record` ALTER COLUMN `cost_variance` SET TAGS ('dbx_business_glossary_term' = 'Cost Variance (CV)');
ALTER TABLE `vibe_construction_v1`.`project`.`evm_period_record` ALTER COLUMN `cost_variance` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`project`.`evm_period_record` ALTER COLUMN `cpi` SET TAGS ('dbx_business_glossary_term' = 'Cost Performance Index (CPI)');
ALTER TABLE `vibe_construction_v1`.`project`.`evm_period_record` ALTER COLUMN `cpi_trend` SET TAGS ('dbx_business_glossary_term' = 'Cost Performance Index (CPI) Trend Indicator');
ALTER TABLE `vibe_construction_v1`.`project`.`evm_period_record` ALTER COLUMN `cpi_trend` SET TAGS ('dbx_value_regex' = 'improving|stable|deteriorating');
ALTER TABLE `vibe_construction_v1`.`project`.`evm_period_record` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_construction_v1`.`project`.`evm_period_record` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `vibe_construction_v1`.`project`.`evm_period_record` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_construction_v1`.`project`.`evm_period_record` ALTER COLUMN `data_date` SET TAGS ('dbx_business_glossary_term' = 'Data Date (Status Date)');
ALTER TABLE `vibe_construction_v1`.`project`.`evm_period_record` ALTER COLUMN `eac` SET TAGS ('dbx_business_glossary_term' = 'Estimate at Completion (EAC)');
ALTER TABLE `vibe_construction_v1`.`project`.`evm_period_record` ALTER COLUMN `eac` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`project`.`evm_period_record` ALTER COLUMN `earned_quantity` SET TAGS ('dbx_business_glossary_term' = 'Earned Quantity');
ALTER TABLE `vibe_construction_v1`.`project`.`evm_period_record` ALTER COLUMN `etc` SET TAGS ('dbx_business_glossary_term' = 'Estimate to Complete (ETC)');
ALTER TABLE `vibe_construction_v1`.`project`.`evm_period_record` ALTER COLUMN `etc` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`project`.`evm_period_record` ALTER COLUMN `forecast_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Forecast Completion Date');
ALTER TABLE `vibe_construction_v1`.`project`.`evm_period_record` ALTER COLUMN `forecast_method` SET TAGS ('dbx_business_glossary_term' = 'EAC Forecast Method');
ALTER TABLE `vibe_construction_v1`.`project`.`evm_period_record` ALTER COLUMN `forecast_method` SET TAGS ('dbx_value_regex' = 'cpi_based|management_override|bottom_up_reestimate|cpi_spi_composite|eac_equals_bac');
ALTER TABLE `vibe_construction_v1`.`project`.`evm_period_record` ALTER COLUMN `installed_quantity` SET TAGS ('dbx_business_glossary_term' = 'Installed Quantity');
ALTER TABLE `vibe_construction_v1`.`project`.`evm_period_record` ALTER COLUMN `management_narrative` SET TAGS ('dbx_business_glossary_term' = 'Management Narrative Commentary');
ALTER TABLE `vibe_construction_v1`.`project`.`evm_period_record` ALTER COLUMN `measurement_date` SET TAGS ('dbx_business_glossary_term' = 'Physical Progress Measurement Date');
ALTER TABLE `vibe_construction_v1`.`project`.`evm_period_record` ALTER COLUMN `measurement_level` SET TAGS ('dbx_business_glossary_term' = 'EVM Measurement Level');
ALTER TABLE `vibe_construction_v1`.`project`.`evm_period_record` ALTER COLUMN `measurement_level` SET TAGS ('dbx_value_regex' = 'project|wbs_level_1|wbs_level_2|wbs_level_3|activity|control_account');
ALTER TABLE `vibe_construction_v1`.`project`.`evm_period_record` ALTER COLUMN `period_acwp` SET TAGS ('dbx_business_glossary_term' = 'Period Actual Cost of Work Performed (ACWP) — Current Period');
ALTER TABLE `vibe_construction_v1`.`project`.`evm_period_record` ALTER COLUMN `period_acwp` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`project`.`evm_period_record` ALTER COLUMN `period_bcwp` SET TAGS ('dbx_business_glossary_term' = 'Period Budgeted Cost of Work Performed (BCWP) — Current Period');
ALTER TABLE `vibe_construction_v1`.`project`.`evm_period_record` ALTER COLUMN `period_bcwp` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`project`.`evm_period_record` ALTER COLUMN `period_bcws` SET TAGS ('dbx_business_glossary_term' = 'Period Budgeted Cost of Work Scheduled (BCWS) — Current Period');
ALTER TABLE `vibe_construction_v1`.`project`.`evm_period_record` ALTER COLUMN `period_bcws` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`project`.`evm_period_record` ALTER COLUMN `period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Reporting Period End Date');
ALTER TABLE `vibe_construction_v1`.`project`.`evm_period_record` ALTER COLUMN `period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Reporting Period Start Date');
ALTER TABLE `vibe_construction_v1`.`project`.`evm_period_record` ALTER COLUMN `physical_percent_complete` SET TAGS ('dbx_business_glossary_term' = 'Physical Percent Complete');
ALTER TABLE `vibe_construction_v1`.`project`.`evm_period_record` ALTER COLUMN `progress_measurement_method` SET TAGS ('dbx_business_glossary_term' = 'Physical Progress Measurement Method');
ALTER TABLE `vibe_construction_v1`.`project`.`evm_period_record` ALTER COLUMN `progress_measurement_method` SET TAGS ('dbx_value_regex' = 'weighted_steps|milestone|units_complete|level_of_effort|percent_complete|50_50_rule');
ALTER TABLE `vibe_construction_v1`.`project`.`evm_period_record` ALTER COLUMN `quantity_unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Quantity Unit of Measure');
ALTER TABLE `vibe_construction_v1`.`project`.`evm_period_record` ALTER COLUMN `record_status` SET TAGS ('dbx_business_glossary_term' = 'EVM Period Record Status');
ALTER TABLE `vibe_construction_v1`.`project`.`evm_period_record` ALTER COLUMN `record_status` SET TAGS ('dbx_value_regex' = 'draft|submitted|approved|rejected|superseded');
ALTER TABLE `vibe_construction_v1`.`project`.`evm_period_record` ALTER COLUMN `schedule_variance` SET TAGS ('dbx_business_glossary_term' = 'Schedule Variance (SV)');
ALTER TABLE `vibe_construction_v1`.`project`.`evm_period_record` ALTER COLUMN `schedule_variance` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`project`.`evm_period_record` ALTER COLUMN `schedule_variance_days` SET TAGS ('dbx_business_glossary_term' = 'Schedule Variance (Days)');
ALTER TABLE `vibe_construction_v1`.`project`.`evm_period_record` ALTER COLUMN `spi` SET TAGS ('dbx_business_glossary_term' = 'Schedule Performance Index (SPI)');
ALTER TABLE `vibe_construction_v1`.`project`.`evm_period_record` ALTER COLUMN `spi_trend` SET TAGS ('dbx_business_glossary_term' = 'Schedule Performance Index (SPI) Trend Indicator');
ALTER TABLE `vibe_construction_v1`.`project`.`evm_period_record` ALTER COLUMN `spi_trend` SET TAGS ('dbx_value_regex' = 'improving|stable|deteriorating');
ALTER TABLE `vibe_construction_v1`.`project`.`evm_period_record` ALTER COLUMN `submitted_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Submission Timestamp');
ALTER TABLE `vibe_construction_v1`.`project`.`evm_period_record` ALTER COLUMN `tcpi` SET TAGS ('dbx_business_glossary_term' = 'To-Complete Performance Index (TCPI)');
ALTER TABLE `vibe_construction_v1`.`project`.`evm_period_record` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `vibe_construction_v1`.`project`.`evm_period_record` ALTER COLUMN `vac` SET TAGS ('dbx_business_glossary_term' = 'Variance at Completion (VAC)');
ALTER TABLE `vibe_construction_v1`.`project`.`evm_period_record` ALTER COLUMN `vac` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`project`.`evm_period_record` ALTER COLUMN `verifying_engineer` SET TAGS ('dbx_business_glossary_term' = 'Verifying Engineer Name');
ALTER TABLE `vibe_construction_v1`.`project`.`progress_measurement` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_construction_v1`.`project`.`progress_measurement` SET TAGS ('dbx_subdomain' = 'performance_tracking');
ALTER TABLE `vibe_construction_v1`.`project`.`progress_measurement` ALTER COLUMN `progress_measurement_id` SET TAGS ('dbx_business_glossary_term' = 'Progress Measurement ID');
ALTER TABLE `vibe_construction_v1`.`project`.`progress_measurement` ALTER COLUMN `activity_id` SET TAGS ('dbx_business_glossary_term' = 'Activity ID');
ALTER TABLE `vibe_construction_v1`.`project`.`progress_measurement` ALTER COLUMN `construction_project_id` SET TAGS ('dbx_business_glossary_term' = 'Project ID');
ALTER TABLE `vibe_construction_v1`.`project`.`progress_measurement` ALTER COLUMN `cost_account_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Account Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`project`.`progress_measurement` ALTER COLUMN `evm_period_record_id` SET TAGS ('dbx_business_glossary_term' = 'Evm Period Record Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`project`.`progress_measurement` ALTER COLUMN `phase_id` SET TAGS ('dbx_business_glossary_term' = 'Phase Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`project`.`progress_measurement` ALTER COLUMN `project_baseline_id` SET TAGS ('dbx_business_glossary_term' = 'Project Baseline Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`project`.`progress_measurement` ALTER COLUMN `wbs_element_id` SET TAGS ('dbx_business_glossary_term' = 'Work Breakdown Structure (WBS) Element ID');
ALTER TABLE `vibe_construction_v1`.`project`.`progress_measurement` ALTER COLUMN `billing_period_reference` SET TAGS ('dbx_business_glossary_term' = 'Billing Period Reference');
ALTER TABLE `vibe_construction_v1`.`project`.`progress_measurement` ALTER COLUMN `budget_at_completion` SET TAGS ('dbx_business_glossary_term' = 'Budget at Completion (BAC)');
ALTER TABLE `vibe_construction_v1`.`project`.`progress_measurement` ALTER COLUMN `budgeted_quantity` SET TAGS ('dbx_business_glossary_term' = 'Budgeted Quantity');
ALTER TABLE `vibe_construction_v1`.`project`.`progress_measurement` ALTER COLUMN `cost_variance` SET TAGS ('dbx_business_glossary_term' = 'Cost Variance (CV)');
ALTER TABLE `vibe_construction_v1`.`project`.`progress_measurement` ALTER COLUMN `cpi` SET TAGS ('dbx_business_glossary_term' = 'Cost Performance Index (CPI)');
ALTER TABLE `vibe_construction_v1`.`project`.`progress_measurement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_construction_v1`.`project`.`progress_measurement` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_construction_v1`.`project`.`progress_measurement` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_construction_v1`.`project`.`progress_measurement` ALTER COLUMN `discipline` SET TAGS ('dbx_business_glossary_term' = 'Engineering Discipline');
ALTER TABLE `vibe_construction_v1`.`project`.`progress_measurement` ALTER COLUMN `earned_value` SET TAGS ('dbx_business_glossary_term' = 'Earned Value (EV)');
ALTER TABLE `vibe_construction_v1`.`project`.`progress_measurement` ALTER COLUMN `installed_quantity` SET TAGS ('dbx_business_glossary_term' = 'Installed Quantity');
ALTER TABLE `vibe_construction_v1`.`project`.`progress_measurement` ALTER COLUMN `is_billing_eligible` SET TAGS ('dbx_business_glossary_term' = 'Is Billing Eligible Flag');
ALTER TABLE `vibe_construction_v1`.`project`.`progress_measurement` ALTER COLUMN `is_milestone` SET TAGS ('dbx_business_glossary_term' = 'Is Milestone Flag');
ALTER TABLE `vibe_construction_v1`.`project`.`progress_measurement` ALTER COLUMN `measurement_date` SET TAGS ('dbx_business_glossary_term' = 'Measurement Date');
ALTER TABLE `vibe_construction_v1`.`project`.`progress_measurement` ALTER COLUMN `measurement_method` SET TAGS ('dbx_business_glossary_term' = 'Progress Measurement Method');
ALTER TABLE `vibe_construction_v1`.`project`.`progress_measurement` ALTER COLUMN `measurement_method` SET TAGS ('dbx_value_regex' = 'weighted_steps|milestone|units_complete|percent_complete|level_of_effort|physical_observation');
ALTER TABLE `vibe_construction_v1`.`project`.`progress_measurement` ALTER COLUMN `measurement_number` SET TAGS ('dbx_business_glossary_term' = 'Progress Measurement Number');
ALTER TABLE `vibe_construction_v1`.`project`.`progress_measurement` ALTER COLUMN `measurement_source` SET TAGS ('dbx_business_glossary_term' = 'Progress Measurement Source System');
ALTER TABLE `vibe_construction_v1`.`project`.`progress_measurement` ALTER COLUMN `measurement_source` SET TAGS ('dbx_value_regex' = 'hcss_heavyjob|procore|primavera_p6|manual|sap_ps');
ALTER TABLE `vibe_construction_v1`.`project`.`progress_measurement` ALTER COLUMN `measurement_status` SET TAGS ('dbx_business_glossary_term' = 'Progress Measurement Status');
ALTER TABLE `vibe_construction_v1`.`project`.`progress_measurement` ALTER COLUMN `measurement_status` SET TAGS ('dbx_value_regex' = 'draft|submitted|verified|approved|rejected|superseded');
ALTER TABLE `vibe_construction_v1`.`project`.`progress_measurement` ALTER COLUMN `measurement_type` SET TAGS ('dbx_business_glossary_term' = 'Progress Measurement Type');
ALTER TABLE `vibe_construction_v1`.`project`.`progress_measurement` ALTER COLUMN `measurement_type` SET TAGS ('dbx_value_regex' = 'physical|financial|combined');
ALTER TABLE `vibe_construction_v1`.`project`.`progress_measurement` ALTER COLUMN `ncr_reference` SET TAGS ('dbx_business_glossary_term' = 'Non-Conformance Report (NCR) Reference');
ALTER TABLE `vibe_construction_v1`.`project`.`progress_measurement` ALTER COLUMN `percent_complete` SET TAGS ('dbx_business_glossary_term' = 'Percent Complete');
ALTER TABLE `vibe_construction_v1`.`project`.`progress_measurement` ALTER COLUMN `period_installed_quantity` SET TAGS ('dbx_business_glossary_term' = 'Period Installed Quantity');
ALTER TABLE `vibe_construction_v1`.`project`.`progress_measurement` ALTER COLUMN `planned_percent_complete` SET TAGS ('dbx_business_glossary_term' = 'Planned Percent Complete');
ALTER TABLE `vibe_construction_v1`.`project`.`progress_measurement` ALTER COLUMN `planned_value` SET TAGS ('dbx_business_glossary_term' = 'Planned Value (PV)');
ALTER TABLE `vibe_construction_v1`.`project`.`progress_measurement` ALTER COLUMN `previous_percent_complete` SET TAGS ('dbx_business_glossary_term' = 'Previous Period Percent Complete');
ALTER TABLE `vibe_construction_v1`.`project`.`progress_measurement` ALTER COLUMN `quantity_unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Quantity Unit of Measure');
ALTER TABLE `vibe_construction_v1`.`project`.`progress_measurement` ALTER COLUMN `remarks` SET TAGS ('dbx_business_glossary_term' = 'Measurement Remarks');
ALTER TABLE `vibe_construction_v1`.`project`.`progress_measurement` ALTER COLUMN `reporting_period_code` SET TAGS ('dbx_business_glossary_term' = 'Reporting Period ID');
ALTER TABLE `vibe_construction_v1`.`project`.`progress_measurement` ALTER COLUMN `reporting_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Reporting Period End Date');
ALTER TABLE `vibe_construction_v1`.`project`.`progress_measurement` ALTER COLUMN `reporting_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Reporting Period Start Date');
ALTER TABLE `vibe_construction_v1`.`project`.`progress_measurement` ALTER COLUMN `schedule_variance` SET TAGS ('dbx_business_glossary_term' = 'Schedule Variance (SV)');
ALTER TABLE `vibe_construction_v1`.`project`.`progress_measurement` ALTER COLUMN `source_record_reference` SET TAGS ('dbx_business_glossary_term' = 'Source System Record ID');
ALTER TABLE `vibe_construction_v1`.`project`.`progress_measurement` ALTER COLUMN `spi` SET TAGS ('dbx_business_glossary_term' = 'Schedule Performance Index (SPI)');
ALTER TABLE `vibe_construction_v1`.`project`.`progress_measurement` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `vibe_construction_v1`.`project`.`progress_measurement` ALTER COLUMN `verification_date` SET TAGS ('dbx_business_glossary_term' = 'Verification Date');
ALTER TABLE `vibe_construction_v1`.`project`.`progress_measurement` ALTER COLUMN `verifier_name` SET TAGS ('dbx_business_glossary_term' = 'Verifying Engineer Name');
ALTER TABLE `vibe_construction_v1`.`project`.`progress_measurement` ALTER COLUMN `verifier_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`project`.`progress_measurement` ALTER COLUMN `work_area` SET TAGS ('dbx_business_glossary_term' = 'Work Area / Zone');
ALTER TABLE `vibe_construction_v1`.`project`.`change_order` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_construction_v1`.`project`.`change_order` SET TAGS ('dbx_subdomain' = 'cost_control');
ALTER TABLE `vibe_construction_v1`.`project`.`change_order` ALTER COLUMN `change_order_id` SET TAGS ('dbx_business_glossary_term' = 'Project Change Order (CO) ID');
ALTER TABLE `vibe_construction_v1`.`project`.`change_order` ALTER COLUMN `construction_project_id` SET TAGS ('dbx_business_glossary_term' = 'Project ID');
ALTER TABLE `vibe_construction_v1`.`project`.`change_order` ALTER COLUMN `cost_account_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Account Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`project`.`change_order` ALTER COLUMN `cost_code_id` SET TAGS ('dbx_business_glossary_term' = 'Finance Cost Code Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`project`.`change_order` ALTER COLUMN `journal_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Journal Entry Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`project`.`change_order` ALTER COLUMN `milestone_id` SET TAGS ('dbx_business_glossary_term' = 'Project Milestone Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`project`.`change_order` ALTER COLUMN `phase_id` SET TAGS ('dbx_business_glossary_term' = 'Phase Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`project`.`change_order` ALTER COLUMN `project_baseline_id` SET TAGS ('dbx_business_glossary_term' = 'Project Baseline Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`project`.`change_order` ALTER COLUMN `wbs_element_id` SET TAGS ('dbx_business_glossary_term' = 'Wbs Element Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`project`.`change_order` ALTER COLUMN `aconex_mail_ref` SET TAGS ('dbx_business_glossary_term' = 'Aconex Mail Reference');
ALTER TABLE `vibe_construction_v1`.`project`.`change_order` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Change Order Approval Date');
ALTER TABLE `vibe_construction_v1`.`project`.`change_order` ALTER COLUMN `approval_date` SET TAGS ('dbx_ssot_source' = 'subcontractor.subcontractor_change_order');
ALTER TABLE `vibe_construction_v1`.`project`.`change_order` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Change Order Approval Status');
ALTER TABLE `vibe_construction_v1`.`project`.`change_order` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'draft|submitted|under_review|approved|rejected|voided');
ALTER TABLE `vibe_construction_v1`.`project`.`change_order` ALTER COLUMN `approval_status` SET TAGS ('dbx_ssot_source' = 'subcontractor.subcontractor_change_order');
ALTER TABLE `vibe_construction_v1`.`project`.`change_order` ALTER COLUMN `budget_line_item_ref` SET TAGS ('dbx_business_glossary_term' = 'Budget Line Item Reference');
ALTER TABLE `vibe_construction_v1`.`project`.`change_order` ALTER COLUMN `change_type` SET TAGS ('dbx_business_glossary_term' = 'Change Order Type');
ALTER TABLE `vibe_construction_v1`.`project`.`change_order` ALTER COLUMN `change_type` SET TAGS ('dbx_value_regex' = 'scope_addition|scope_reduction|design_change|unforeseen_condition|client_directive|regulatory_change');
ALTER TABLE `vibe_construction_v1`.`project`.`change_order` ALTER COLUMN `change_type` SET TAGS ('dbx_ssot_source' = 'subcontractor.subcontractor_change_order');
ALTER TABLE `vibe_construction_v1`.`project`.`change_order` ALTER COLUMN `co_number` SET TAGS ('dbx_business_glossary_term' = 'Change Order (CO) Number');
ALTER TABLE `vibe_construction_v1`.`project`.`change_order` ALTER COLUMN `co_number` SET TAGS ('dbx_value_regex' = '^CO-[0-9]{4,6}$');
ALTER TABLE `vibe_construction_v1`.`project`.`change_order` ALTER COLUMN `co_number` SET TAGS ('dbx_ssot_source' = 'subcontractor.subcontractor_change_order');
ALTER TABLE `vibe_construction_v1`.`project`.`change_order` ALTER COLUMN `contingency_drawn_amount` SET TAGS ('dbx_business_glossary_term' = 'Contingency Drawn Amount');
ALTER TABLE `vibe_construction_v1`.`project`.`change_order` ALTER COLUMN `contingency_drawn_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`project`.`change_order` ALTER COLUMN `contract_clause_reference` SET TAGS ('dbx_business_glossary_term' = 'Contract Clause Reference');
ALTER TABLE `vibe_construction_v1`.`project`.`change_order` ALTER COLUMN `cost_impact_amount` SET TAGS ('dbx_business_glossary_term' = 'Change Order Cost Impact Amount');
ALTER TABLE `vibe_construction_v1`.`project`.`change_order` ALTER COLUMN `cost_impact_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`project`.`change_order` ALTER COLUMN `cost_impact_currency` SET TAGS ('dbx_business_glossary_term' = 'Change Order Cost Impact Currency');
ALTER TABLE `vibe_construction_v1`.`project`.`change_order` ALTER COLUMN `cost_impact_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_construction_v1`.`project`.`change_order` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Change Order Created Timestamp');
ALTER TABLE `vibe_construction_v1`.`project`.`change_order` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_ssot_source' = 'subcontractor.subcontractor_change_order');
ALTER TABLE `vibe_construction_v1`.`project`.`change_order` ALTER COLUMN `delivery_model` SET TAGS ('dbx_business_glossary_term' = 'Project Delivery Model');
ALTER TABLE `vibe_construction_v1`.`project`.`change_order` ALTER COLUMN `delivery_model` SET TAGS ('dbx_value_regex' = 'EPC|DB|DBB|PPP|BOT|GMP');
ALTER TABLE `vibe_construction_v1`.`project`.`change_order` ALTER COLUMN `direct_cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Change Order Direct Cost Amount');
ALTER TABLE `vibe_construction_v1`.`project`.`change_order` ALTER COLUMN `direct_cost_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`project`.`change_order` ALTER COLUMN `drawing_revision` SET TAGS ('dbx_business_glossary_term' = 'Associated Drawing Revision');
ALTER TABLE `vibe_construction_v1`.`project`.`change_order` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Change Order Effective Date');
ALTER TABLE `vibe_construction_v1`.`project`.`change_order` ALTER COLUMN `eot_granted_days` SET TAGS ('dbx_business_glossary_term' = 'Extension of Time (EOT) Granted Days');
ALTER TABLE `vibe_construction_v1`.`project`.`change_order` ALTER COLUMN `is_disputed` SET TAGS ('dbx_business_glossary_term' = 'Change Order Disputed Flag');
ALTER TABLE `vibe_construction_v1`.`project`.`change_order` ALTER COLUMN `is_ld_applicable` SET TAGS ('dbx_business_glossary_term' = 'Liquidated Damages (LD) Applicable Flag');
ALTER TABLE `vibe_construction_v1`.`project`.`change_order` ALTER COLUMN `ld_rate_per_day` SET TAGS ('dbx_business_glossary_term' = 'Liquidated Damages (LD) Rate Per Day');
ALTER TABLE `vibe_construction_v1`.`project`.`change_order` ALTER COLUMN `ld_rate_per_day` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`project`.`change_order` ALTER COLUMN `originator` SET TAGS ('dbx_business_glossary_term' = 'Change Order Originator');
ALTER TABLE `vibe_construction_v1`.`project`.`change_order` ALTER COLUMN `originator` SET TAGS ('dbx_value_regex' = 'client|owner|contractor|engineer|subcontractor|regulatory_authority');
ALTER TABLE `vibe_construction_v1`.`project`.`change_order` ALTER COLUMN `overhead_and_profit_amount` SET TAGS ('dbx_business_glossary_term' = 'Change Order Overhead and Profit (OH&P) Amount');
ALTER TABLE `vibe_construction_v1`.`project`.`change_order` ALTER COLUMN `overhead_and_profit_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`project`.`change_order` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Change Order Priority');
ALTER TABLE `vibe_construction_v1`.`project`.`change_order` ALTER COLUMN `priority` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `vibe_construction_v1`.`project`.`change_order` ALTER COLUMN `procore_co_reference` SET TAGS ('dbx_business_glossary_term' = 'Procore Change Order System ID');
ALTER TABLE `vibe_construction_v1`.`project`.`change_order` ALTER COLUMN `project_change_order_description` SET TAGS ('dbx_business_glossary_term' = 'Change Order Description');
ALTER TABLE `vibe_construction_v1`.`project`.`change_order` ALTER COLUMN `reason_code` SET TAGS ('dbx_business_glossary_term' = 'Change Order Reason Code');
ALTER TABLE `vibe_construction_v1`.`project`.`change_order` ALTER COLUMN `reason_code` SET TAGS ('dbx_ssot_source' = 'subcontractor.subcontractor_change_order');
ALTER TABLE `vibe_construction_v1`.`project`.`change_order` ALTER COLUMN `revision_number` SET TAGS ('dbx_business_glossary_term' = 'Change Order Revision Number');
ALTER TABLE `vibe_construction_v1`.`project`.`change_order` ALTER COLUMN `sap_co_document_number` SET TAGS ('dbx_business_glossary_term' = 'SAP Change Order Document Number');
ALTER TABLE `vibe_construction_v1`.`project`.`change_order` ALTER COLUMN `schedule_impact_days` SET TAGS ('dbx_business_glossary_term' = 'Change Order Schedule Impact (Days)');
ALTER TABLE `vibe_construction_v1`.`project`.`change_order` ALTER COLUMN `schedule_impact_days` SET TAGS ('dbx_ssot_source' = 'subcontractor.subcontractor_change_order');
ALTER TABLE `vibe_construction_v1`.`project`.`change_order` ALTER COLUMN `scope_of_work_summary` SET TAGS ('dbx_business_glossary_term' = 'Change Order Scope of Work Summary');
ALTER TABLE `vibe_construction_v1`.`project`.`change_order` ALTER COLUMN `submitted_date` SET TAGS ('dbx_business_glossary_term' = 'Change Order Submitted Date');
ALTER TABLE `vibe_construction_v1`.`project`.`change_order` ALTER COLUMN `title` SET TAGS ('dbx_business_glossary_term' = 'Change Order Title');
ALTER TABLE `vibe_construction_v1`.`project`.`change_order` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Change Order Last Updated Timestamp');
ALTER TABLE `vibe_construction_v1`.`project`.`cost_account` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_construction_v1`.`project`.`cost_account` SET TAGS ('dbx_subdomain' = 'cost_control');
ALTER TABLE `vibe_construction_v1`.`project`.`cost_account` ALTER COLUMN `cost_account_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Account ID');
ALTER TABLE `vibe_construction_v1`.`project`.`cost_account` ALTER COLUMN `construction_project_id` SET TAGS ('dbx_business_glossary_term' = 'Project ID');
ALTER TABLE `vibe_construction_v1`.`project`.`cost_account` ALTER COLUMN `cost_code_id` SET TAGS ('dbx_business_glossary_term' = 'Finance Cost Code Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`project`.`cost_account` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`project`.`cost_account` ALTER COLUMN `phase_id` SET TAGS ('dbx_business_glossary_term' = 'Phase Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`project`.`cost_account` ALTER COLUMN `project_baseline_id` SET TAGS ('dbx_business_glossary_term' = 'Project Baseline Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`project`.`cost_account` ALTER COLUMN `wbs_element_id` SET TAGS ('dbx_business_glossary_term' = 'Work Breakdown Structure (WBS) Element ID');
ALTER TABLE `vibe_construction_v1`.`project`.`cost_account` ALTER COLUMN `account_description` SET TAGS ('dbx_business_glossary_term' = 'Cost Account Description');
ALTER TABLE `vibe_construction_v1`.`project`.`cost_account` ALTER COLUMN `account_status` SET TAGS ('dbx_business_glossary_term' = 'Cost Account Status');
ALTER TABLE `vibe_construction_v1`.`project`.`cost_account` ALTER COLUMN `account_status` SET TAGS ('dbx_value_regex' = 'active|on_hold|closed|cancelled|pending_approval');
ALTER TABLE `vibe_construction_v1`.`project`.`cost_account` ALTER COLUMN `actual_cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Actual Cost (AC) Amount');
ALTER TABLE `vibe_construction_v1`.`project`.`cost_account` ALTER COLUMN `actual_cost_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`project`.`cost_account` ALTER COLUMN `approved_budget_amount` SET TAGS ('dbx_business_glossary_term' = 'Approved Budget Amount (Budget at Completion)');
ALTER TABLE `vibe_construction_v1`.`project`.`cost_account` ALTER COLUMN `approved_budget_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`project`.`cost_account` ALTER COLUMN `baseline_finish_date` SET TAGS ('dbx_business_glossary_term' = 'Baseline Finish Date');
ALTER TABLE `vibe_construction_v1`.`project`.`cost_account` ALTER COLUMN `baseline_start_date` SET TAGS ('dbx_business_glossary_term' = 'Baseline Start Date');
ALTER TABLE `vibe_construction_v1`.`project`.`cost_account` ALTER COLUMN `budget_unit_rate` SET TAGS ('dbx_business_glossary_term' = 'Budget Unit Rate');
ALTER TABLE `vibe_construction_v1`.`project`.`cost_account` ALTER COLUMN `budget_unit_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`project`.`cost_account` ALTER COLUMN `change_order_amount` SET TAGS ('dbx_business_glossary_term' = 'Change Order (CO) Amount');
ALTER TABLE `vibe_construction_v1`.`project`.`cost_account` ALTER COLUMN `change_order_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`project`.`cost_account` ALTER COLUMN `cost_account_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Account Code');
ALTER TABLE `vibe_construction_v1`.`project`.`cost_account` ALTER COLUMN `cost_account_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,20}(-[A-Z0-9]{1,10}){0,4}$');
ALTER TABLE `vibe_construction_v1`.`project`.`cost_account` ALTER COLUMN `committed_cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Committed Cost Amount');
ALTER TABLE `vibe_construction_v1`.`project`.`cost_account` ALTER COLUMN `committed_cost_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`project`.`cost_account` ALTER COLUMN `contingency_amount` SET TAGS ('dbx_business_glossary_term' = 'Contingency Amount');
ALTER TABLE `vibe_construction_v1`.`project`.`cost_account` ALTER COLUMN `contingency_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`project`.`cost_account` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `vibe_construction_v1`.`project`.`cost_account` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,12}$');
ALTER TABLE `vibe_construction_v1`.`project`.`cost_account` ALTER COLUMN `cost_to_complete_amount` SET TAGS ('dbx_business_glossary_term' = 'Estimate to Complete (ETC) Amount');
ALTER TABLE `vibe_construction_v1`.`project`.`cost_account` ALTER COLUMN `cost_to_complete_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`project`.`cost_account` ALTER COLUMN `cost_type` SET TAGS ('dbx_business_glossary_term' = 'Cost Type');
ALTER TABLE `vibe_construction_v1`.`project`.`cost_account` ALTER COLUMN `cost_type` SET TAGS ('dbx_value_regex' = 'labor|material|equipment|subcontract|overhead');
ALTER TABLE `vibe_construction_v1`.`project`.`cost_account` ALTER COLUMN `cost_variance_amount` SET TAGS ('dbx_business_glossary_term' = 'Cost Variance (CV) Amount');
ALTER TABLE `vibe_construction_v1`.`project`.`cost_account` ALTER COLUMN `cost_variance_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`project`.`cost_account` ALTER COLUMN `cpi` SET TAGS ('dbx_business_glossary_term' = 'Cost Performance Index (CPI)');
ALTER TABLE `vibe_construction_v1`.`project`.`cost_account` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_construction_v1`.`project`.`cost_account` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_construction_v1`.`project`.`cost_account` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_construction_v1`.`project`.`cost_account` ALTER COLUMN `earned_value_amount` SET TAGS ('dbx_business_glossary_term' = 'Earned Value (EV) Amount');
ALTER TABLE `vibe_construction_v1`.`project`.`cost_account` ALTER COLUMN `earned_value_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`project`.`cost_account` ALTER COLUMN `forecast_cost_at_completion` SET TAGS ('dbx_business_glossary_term' = 'Forecast Cost at Completion (FAC)');
ALTER TABLE `vibe_construction_v1`.`project`.`cost_account` ALTER COLUMN `forecast_cost_at_completion` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`project`.`cost_account` ALTER COLUMN `forecast_finish_date` SET TAGS ('dbx_business_glossary_term' = 'Forecast Finish Date');
ALTER TABLE `vibe_construction_v1`.`project`.`cost_account` ALTER COLUMN `forecast_start_date` SET TAGS ('dbx_business_glossary_term' = 'Forecast Start Date');
ALTER TABLE `vibe_construction_v1`.`project`.`cost_account` ALTER COLUMN `is_lump_sum` SET TAGS ('dbx_business_glossary_term' = 'Lump Sum Indicator');
ALTER TABLE `vibe_construction_v1`.`project`.`cost_account` ALTER COLUMN `is_subcontract_scope` SET TAGS ('dbx_business_glossary_term' = 'Subcontract Scope Indicator');
ALTER TABLE `vibe_construction_v1`.`project`.`cost_account` ALTER COLUMN `original_budget_amount` SET TAGS ('dbx_business_glossary_term' = 'Original Budget Amount');
ALTER TABLE `vibe_construction_v1`.`project`.`cost_account` ALTER COLUMN `original_budget_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`project`.`cost_account` ALTER COLUMN `percent_complete` SET TAGS ('dbx_business_glossary_term' = 'Percent Complete');
ALTER TABLE `vibe_construction_v1`.`project`.`cost_account` ALTER COLUMN `planned_value_amount` SET TAGS ('dbx_business_glossary_term' = 'Planned Value (PV) Amount');
ALTER TABLE `vibe_construction_v1`.`project`.`cost_account` ALTER COLUMN `planned_value_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`project`.`cost_account` ALTER COLUMN `quantity_actual` SET TAGS ('dbx_business_glossary_term' = 'Actual Quantity');
ALTER TABLE `vibe_construction_v1`.`project`.`cost_account` ALTER COLUMN `quantity_budgeted` SET TAGS ('dbx_business_glossary_term' = 'Budgeted Quantity');
ALTER TABLE `vibe_construction_v1`.`project`.`cost_account` ALTER COLUMN `reporting_period_date` SET TAGS ('dbx_business_glossary_term' = 'Reporting Period Date');
ALTER TABLE `vibe_construction_v1`.`project`.`cost_account` ALTER COLUMN `retention_percentage` SET TAGS ('dbx_business_glossary_term' = 'Retention Percentage');
ALTER TABLE `vibe_construction_v1`.`project`.`cost_account` ALTER COLUMN `retention_percentage` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`project`.`cost_account` ALTER COLUMN `spi` SET TAGS ('dbx_business_glossary_term' = 'Schedule Performance Index (SPI)');
ALTER TABLE `vibe_construction_v1`.`project`.`cost_account` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `vibe_construction_v1`.`project`.`cost_account` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_value_regex' = '^[A-Za-z0-9/_]{1,20}$');
ALTER TABLE `vibe_construction_v1`.`project`.`cost_account` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `vibe_construction_v1`.`project`.`deliverable` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_construction_v1`.`project`.`deliverable` SET TAGS ('dbx_subdomain' = 'project_setup');
ALTER TABLE `vibe_construction_v1`.`project`.`deliverable` ALTER COLUMN `deliverable_id` SET TAGS ('dbx_business_glossary_term' = 'Deliverable ID');
ALTER TABLE `vibe_construction_v1`.`project`.`deliverable` ALTER COLUMN `activity_id` SET TAGS ('dbx_business_glossary_term' = 'Schedule Activity ID');
ALTER TABLE `vibe_construction_v1`.`project`.`deliverable` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Contract ID');
ALTER TABLE `vibe_construction_v1`.`project`.`deliverable` ALTER COLUMN `change_order_id` SET TAGS ('dbx_business_glossary_term' = 'Project Change Order Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`project`.`deliverable` ALTER COLUMN `construction_project_id` SET TAGS ('dbx_business_glossary_term' = 'Project ID');
ALTER TABLE `vibe_construction_v1`.`project`.`deliverable` ALTER COLUMN `itp_id` SET TAGS ('dbx_business_glossary_term' = 'Itp Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`project`.`deliverable` ALTER COLUMN `master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Material Master Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`project`.`deliverable` ALTER COLUMN `milestone_id` SET TAGS ('dbx_business_glossary_term' = 'Project Milestone Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`project`.`deliverable` ALTER COLUMN `package_id` SET TAGS ('dbx_business_glossary_term' = 'Package Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`project`.`deliverable` ALTER COLUMN `phase_id` SET TAGS ('dbx_business_glossary_term' = 'Phase Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`project`.`deliverable` ALTER COLUMN `project_baseline_id` SET TAGS ('dbx_business_glossary_term' = 'Project Baseline Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`project`.`deliverable` ALTER COLUMN `contact_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Contact Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`project`.`deliverable` ALTER COLUMN `wbs_element_id` SET TAGS ('dbx_business_glossary_term' = 'Work Breakdown Structure (WBS) Element ID');
ALTER TABLE `vibe_construction_v1`.`project`.`deliverable` ALTER COLUMN `acceptance_date` SET TAGS ('dbx_business_glossary_term' = 'Acceptance Date');
ALTER TABLE `vibe_construction_v1`.`project`.`deliverable` ALTER COLUMN `acceptance_status` SET TAGS ('dbx_business_glossary_term' = 'Acceptance Status');
ALTER TABLE `vibe_construction_v1`.`project`.`deliverable` ALTER COLUMN `acceptance_status` SET TAGS ('dbx_value_regex' = 'pending|accepted|accepted_with_comments|rejected|resubmit_required');
ALTER TABLE `vibe_construction_v1`.`project`.`deliverable` ALTER COLUMN `actual_issue_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Issue Date');
ALTER TABLE `vibe_construction_v1`.`project`.`deliverable` ALTER COLUMN `bim_model_reference` SET TAGS ('dbx_business_glossary_term' = 'Building Information Modeling (BIM) Model Reference');
ALTER TABLE `vibe_construction_v1`.`project`.`deliverable` ALTER COLUMN `deliverable_category` SET TAGS ('dbx_business_glossary_term' = 'Deliverable Category');
ALTER TABLE `vibe_construction_v1`.`project`.`deliverable` ALTER COLUMN `deliverable_code` SET TAGS ('dbx_business_glossary_term' = 'Deliverable Code');
ALTER TABLE `vibe_construction_v1`.`project`.`deliverable` ALTER COLUMN `deliverable_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-.]{3,30}$');
ALTER TABLE `vibe_construction_v1`.`project`.`deliverable` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Review Comments');
ALTER TABLE `vibe_construction_v1`.`project`.`deliverable` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_construction_v1`.`project`.`deliverable` ALTER COLUMN `deliverable_status` SET TAGS ('dbx_business_glossary_term' = 'Deliverable Status');
ALTER TABLE `vibe_construction_v1`.`project`.`deliverable` ALTER COLUMN `deliverable_type` SET TAGS ('dbx_business_glossary_term' = 'Deliverable Type');
ALTER TABLE `vibe_construction_v1`.`project`.`deliverable` ALTER COLUMN `discipline` SET TAGS ('dbx_business_glossary_term' = 'Engineering Discipline');
ALTER TABLE `vibe_construction_v1`.`project`.`deliverable` ALTER COLUMN `document_number` SET TAGS ('dbx_business_glossary_term' = 'Document Number');
ALTER TABLE `vibe_construction_v1`.`project`.`deliverable` ALTER COLUMN `eot_applicable` SET TAGS ('dbx_business_glossary_term' = 'Extension of Time (EOT) Applicable Flag');
ALTER TABLE `vibe_construction_v1`.`project`.`deliverable` ALTER COLUMN `forecast_issue_date` SET TAGS ('dbx_business_glossary_term' = 'Forecast Issue Date');
ALTER TABLE `vibe_construction_v1`.`project`.`deliverable` ALTER COLUMN `is_contractual` SET TAGS ('dbx_business_glossary_term' = 'Is Contractual Deliverable Flag');
ALTER TABLE `vibe_construction_v1`.`project`.`deliverable` ALTER COLUMN `is_dlp_applicable` SET TAGS ('dbx_business_glossary_term' = 'Is Defects Liability Period (DLP) Applicable Flag');
ALTER TABLE `vibe_construction_v1`.`project`.`deliverable` ALTER COLUMN `is_handover_required` SET TAGS ('dbx_business_glossary_term' = 'Is Handover Required Flag');
ALTER TABLE `vibe_construction_v1`.`project`.`deliverable` ALTER COLUMN `native_file_format` SET TAGS ('dbx_business_glossary_term' = 'Native File Format');
ALTER TABLE `vibe_construction_v1`.`project`.`deliverable` ALTER COLUMN `ncr_reference` SET TAGS ('dbx_business_glossary_term' = 'Non-Conformance Report (NCR) Reference');
ALTER TABLE `vibe_construction_v1`.`project`.`deliverable` ALTER COLUMN `percent_complete` SET TAGS ('dbx_business_glossary_term' = 'Percent Complete');
ALTER TABLE `vibe_construction_v1`.`project`.`deliverable` ALTER COLUMN `planned_issue_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Issue Date');
ALTER TABLE `vibe_construction_v1`.`project`.`deliverable` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Priority Level');
ALTER TABLE `vibe_construction_v1`.`project`.`deliverable` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `vibe_construction_v1`.`project`.`deliverable` ALTER COLUMN `review_due_date` SET TAGS ('dbx_business_glossary_term' = 'Review Due Date');
ALTER TABLE `vibe_construction_v1`.`project`.`deliverable` ALTER COLUMN `review_return_date` SET TAGS ('dbx_business_glossary_term' = 'Review Return Date');
ALTER TABLE `vibe_construction_v1`.`project`.`deliverable` ALTER COLUMN `revision_number` SET TAGS ('dbx_business_glossary_term' = 'Revision Number');
ALTER TABLE `vibe_construction_v1`.`project`.`deliverable` ALTER COLUMN `revision_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{1,5}$');
ALTER TABLE `vibe_construction_v1`.`project`.`deliverable` ALTER COLUMN `revision_status_code` SET TAGS ('dbx_business_glossary_term' = 'Revision Status Code');
ALTER TABLE `vibe_construction_v1`.`project`.`deliverable` ALTER COLUMN `storage_location_url` SET TAGS ('dbx_business_glossary_term' = 'Storage Location URL');
ALTER TABLE `vibe_construction_v1`.`project`.`deliverable` ALTER COLUMN `submission_number` SET TAGS ('dbx_business_glossary_term' = 'Submission Number');
ALTER TABLE `vibe_construction_v1`.`project`.`deliverable` ALTER COLUMN `title` SET TAGS ('dbx_business_glossary_term' = 'Deliverable Title');
ALTER TABLE `vibe_construction_v1`.`project`.`deliverable` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_construction_v1`.`project`.`deliverable` ALTER COLUMN `weight_factor` SET TAGS ('dbx_business_glossary_term' = 'Weight Factor');
ALTER TABLE `vibe_construction_v1`.`project`.`risk_register` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_construction_v1`.`project`.`risk_register` SET TAGS ('dbx_subdomain' = 'performance_tracking');
ALTER TABLE `vibe_construction_v1`.`project`.`risk_register` ALTER COLUMN `risk_register_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Register ID');
ALTER TABLE `vibe_construction_v1`.`project`.`risk_register` ALTER COLUMN `activity_id` SET TAGS ('dbx_business_glossary_term' = 'Activity Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`project`.`risk_register` ALTER COLUMN `construction_project_id` SET TAGS ('dbx_business_glossary_term' = 'Project ID');
ALTER TABLE `vibe_construction_v1`.`project`.`risk_register` ALTER COLUMN `cost_code_id` SET TAGS ('dbx_business_glossary_term' = 'Finance Cost Code Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`project`.`risk_register` ALTER COLUMN `hazard_register_id` SET TAGS ('dbx_business_glossary_term' = 'Hazard Register Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`project`.`risk_register` ALTER COLUMN `milestone_id` SET TAGS ('dbx_business_glossary_term' = 'Project Milestone Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`project`.`risk_register` ALTER COLUMN `phase_id` SET TAGS ('dbx_business_glossary_term' = 'Phase Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`project`.`risk_register` ALTER COLUMN `rfi_id` SET TAGS ('dbx_business_glossary_term' = 'Rfi Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`project`.`risk_register` ALTER COLUMN `risk_assessment_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Assessment Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`project`.`risk_register` ALTER COLUMN `wbs_element_id` SET TAGS ('dbx_business_glossary_term' = 'Work Breakdown Structure (WBS) Element ID');
ALTER TABLE `vibe_construction_v1`.`project`.`risk_register` ALTER COLUMN `affected_discipline` SET TAGS ('dbx_business_glossary_term' = 'Affected Discipline');
ALTER TABLE `vibe_construction_v1`.`project`.`risk_register` ALTER COLUMN `closure_date` SET TAGS ('dbx_business_glossary_term' = 'Risk Closure Date');
ALTER TABLE `vibe_construction_v1`.`project`.`risk_register` ALTER COLUMN `contingency_cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Contingency Cost Amount');
ALTER TABLE `vibe_construction_v1`.`project`.`risk_register` ALTER COLUMN `contingency_cost_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`project`.`risk_register` ALTER COLUMN `contingency_plan` SET TAGS ('dbx_business_glossary_term' = 'Risk Contingency Plan');
ALTER TABLE `vibe_construction_v1`.`project`.`risk_register` ALTER COLUMN `contract_clause_reference` SET TAGS ('dbx_business_glossary_term' = 'Contract Clause Reference');
ALTER TABLE `vibe_construction_v1`.`project`.`risk_register` ALTER COLUMN `cost_impact_amount` SET TAGS ('dbx_business_glossary_term' = 'Cost Impact Amount');
ALTER TABLE `vibe_construction_v1`.`project`.`risk_register` ALTER COLUMN `cost_impact_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`project`.`risk_register` ALTER COLUMN `cost_impact_rating` SET TAGS ('dbx_business_glossary_term' = 'Cost Impact Rating');
ALTER TABLE `vibe_construction_v1`.`project`.`risk_register` ALTER COLUMN `cost_impact_rating` SET TAGS ('dbx_value_regex' = 'very_low|low|medium|high|very_high');
ALTER TABLE `vibe_construction_v1`.`project`.`risk_register` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_construction_v1`.`project`.`risk_register` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_construction_v1`.`project`.`risk_register` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_construction_v1`.`project`.`risk_register` ALTER COLUMN `escalation_flag` SET TAGS ('dbx_business_glossary_term' = 'Risk Escalation Flag');
ALTER TABLE `vibe_construction_v1`.`project`.`risk_register` ALTER COLUMN `hse_risk_flag` SET TAGS ('dbx_business_glossary_term' = 'Health Safety and Environment (HSE) Risk Flag');
ALTER TABLE `vibe_construction_v1`.`project`.`risk_register` ALTER COLUMN `identified_date` SET TAGS ('dbx_business_glossary_term' = 'Risk Identified Date');
ALTER TABLE `vibe_construction_v1`.`project`.`risk_register` ALTER COLUMN `insurance_coverage_flag` SET TAGS ('dbx_business_glossary_term' = 'Insurance Coverage Flag');
ALTER TABLE `vibe_construction_v1`.`project`.`risk_register` ALTER COLUMN `last_reviewed_date` SET TAGS ('dbx_business_glossary_term' = 'Risk Last Reviewed Date');
ALTER TABLE `vibe_construction_v1`.`project`.`risk_register` ALTER COLUMN `mitigation_response_type` SET TAGS ('dbx_business_glossary_term' = 'Risk Mitigation Response Type');
ALTER TABLE `vibe_construction_v1`.`project`.`risk_register` ALTER COLUMN `mitigation_response_type` SET TAGS ('dbx_value_regex' = 'avoid|transfer|mitigate|accept|exploit|enhance');
ALTER TABLE `vibe_construction_v1`.`project`.`risk_register` ALTER COLUMN `mitigation_strategy` SET TAGS ('dbx_business_glossary_term' = 'Risk Mitigation Strategy');
ALTER TABLE `vibe_construction_v1`.`project`.`risk_register` ALTER COLUMN `probability_rating` SET TAGS ('dbx_business_glossary_term' = 'Risk Probability Rating');
ALTER TABLE `vibe_construction_v1`.`project`.`risk_register` ALTER COLUMN `probability_rating` SET TAGS ('dbx_value_regex' = 'very_low|low|medium|high|very_high');
ALTER TABLE `vibe_construction_v1`.`project`.`risk_register` ALTER COLUMN `probability_score` SET TAGS ('dbx_business_glossary_term' = 'Risk Probability Score');
ALTER TABLE `vibe_construction_v1`.`project`.`risk_register` ALTER COLUMN `quality_impact_rating` SET TAGS ('dbx_business_glossary_term' = 'Quality Impact Rating');
ALTER TABLE `vibe_construction_v1`.`project`.`risk_register` ALTER COLUMN `quality_impact_rating` SET TAGS ('dbx_value_regex' = 'very_low|low|medium|high|very_high');
ALTER TABLE `vibe_construction_v1`.`project`.`risk_register` ALTER COLUMN `regulatory_risk_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Risk Flag');
ALTER TABLE `vibe_construction_v1`.`project`.`risk_register` ALTER COLUMN `residual_probability_score` SET TAGS ('dbx_business_glossary_term' = 'Residual Risk Probability Score');
ALTER TABLE `vibe_construction_v1`.`project`.`risk_register` ALTER COLUMN `residual_risk_score` SET TAGS ('dbx_business_glossary_term' = 'Residual Risk Score');
ALTER TABLE `vibe_construction_v1`.`project`.`risk_register` ALTER COLUMN `review_date` SET TAGS ('dbx_business_glossary_term' = 'Risk Review Date');
ALTER TABLE `vibe_construction_v1`.`project`.`risk_register` ALTER COLUMN `risk_category` SET TAGS ('dbx_business_glossary_term' = 'Risk Category');
ALTER TABLE `vibe_construction_v1`.`project`.`risk_register` ALTER COLUMN `risk_category` SET TAGS ('dbx_value_regex' = 'technical|commercial|schedule|hse|regulatory|force_majeure');
ALTER TABLE `vibe_construction_v1`.`project`.`risk_register` ALTER COLUMN `risk_code` SET TAGS ('dbx_business_glossary_term' = 'Risk Identifier');
ALTER TABLE `vibe_construction_v1`.`project`.`risk_register` ALTER COLUMN `risk_code` SET TAGS ('dbx_value_regex' = '^RSK-[A-Z0-9]{3,10}-[0-9]{4}$');
ALTER TABLE `vibe_construction_v1`.`project`.`risk_register` ALTER COLUMN `risk_description` SET TAGS ('dbx_business_glossary_term' = 'Risk Description');
ALTER TABLE `vibe_construction_v1`.`project`.`risk_register` ALTER COLUMN `risk_proximity` SET TAGS ('dbx_business_glossary_term' = 'Risk Proximity');
ALTER TABLE `vibe_construction_v1`.`project`.`risk_register` ALTER COLUMN `risk_proximity` SET TAGS ('dbx_value_regex' = 'immediate|near_term|medium_term|long_term');
ALTER TABLE `vibe_construction_v1`.`project`.`risk_register` ALTER COLUMN `risk_score` SET TAGS ('dbx_business_glossary_term' = 'Risk Score');
ALTER TABLE `vibe_construction_v1`.`project`.`risk_register` ALTER COLUMN `risk_status` SET TAGS ('dbx_business_glossary_term' = 'Risk Status');
ALTER TABLE `vibe_construction_v1`.`project`.`risk_register` ALTER COLUMN `risk_status` SET TAGS ('dbx_value_regex' = 'open|mitigated|closed|realized|transferred');
ALTER TABLE `vibe_construction_v1`.`project`.`risk_register` ALTER COLUMN `risk_title` SET TAGS ('dbx_business_glossary_term' = 'Risk Title');
ALTER TABLE `vibe_construction_v1`.`project`.`risk_register` ALTER COLUMN `risk_trigger` SET TAGS ('dbx_business_glossary_term' = 'Risk Trigger');
ALTER TABLE `vibe_construction_v1`.`project`.`risk_register` ALTER COLUMN `risk_type` SET TAGS ('dbx_business_glossary_term' = 'Risk Type');
ALTER TABLE `vibe_construction_v1`.`project`.`risk_register` ALTER COLUMN `risk_type` SET TAGS ('dbx_value_regex' = 'threat|opportunity');
ALTER TABLE `vibe_construction_v1`.`project`.`risk_register` ALTER COLUMN `schedule_impact_days` SET TAGS ('dbx_business_glossary_term' = 'Schedule Impact Days');
ALTER TABLE `vibe_construction_v1`.`project`.`risk_register` ALTER COLUMN `schedule_impact_rating` SET TAGS ('dbx_business_glossary_term' = 'Schedule Impact Rating');
ALTER TABLE `vibe_construction_v1`.`project`.`risk_register` ALTER COLUMN `schedule_impact_rating` SET TAGS ('dbx_value_regex' = 'very_low|low|medium|high|very_high');
ALTER TABLE `vibe_construction_v1`.`project`.`risk_register` ALTER COLUMN `source_system_ref` SET TAGS ('dbx_business_glossary_term' = 'Source System Reference');
ALTER TABLE `vibe_construction_v1`.`project`.`risk_register` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_construction_v1`.`project`.`phase` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_construction_v1`.`project`.`phase` SET TAGS ('dbx_subdomain' = 'project_setup');
ALTER TABLE `vibe_construction_v1`.`project`.`phase` ALTER COLUMN `phase_id` SET TAGS ('dbx_business_glossary_term' = 'Phase ID');
ALTER TABLE `vibe_construction_v1`.`project`.`phase` ALTER COLUMN `construction_project_id` SET TAGS ('dbx_business_glossary_term' = 'Project ID');
ALTER TABLE `vibe_construction_v1`.`project`.`phase` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`project`.`phase` ALTER COLUMN `project_baseline_id` SET TAGS ('dbx_business_glossary_term' = 'Project Baseline Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`project`.`phase` ALTER COLUMN `wbs_element_id` SET TAGS ('dbx_business_glossary_term' = 'Wbs Element Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`project`.`phase` ALTER COLUMN `actual_cost` SET TAGS ('dbx_business_glossary_term' = 'Actual Cost of Work Performed (ACWP)');
ALTER TABLE `vibe_construction_v1`.`project`.`phase` ALTER COLUMN `actual_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`project`.`phase` ALTER COLUMN `actual_finish_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Finish Date');
ALTER TABLE `vibe_construction_v1`.`project`.`phase` ALTER COLUMN `actual_start_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Start Date');
ALTER TABLE `vibe_construction_v1`.`project`.`phase` ALTER COLUMN `baseline_duration_days` SET TAGS ('dbx_business_glossary_term' = 'Baseline Duration (Days)');
ALTER TABLE `vibe_construction_v1`.`project`.`phase` ALTER COLUMN `budgeted_cost` SET TAGS ('dbx_business_glossary_term' = 'Budgeted Cost of Work Scheduled (BCWS)');
ALTER TABLE `vibe_construction_v1`.`project`.`phase` ALTER COLUMN `budgeted_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`project`.`phase` ALTER COLUMN `phase_code` SET TAGS ('dbx_business_glossary_term' = 'Phase Code');
ALTER TABLE `vibe_construction_v1`.`project`.`phase` ALTER COLUMN `phase_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{2,20}$');
ALTER TABLE `vibe_construction_v1`.`project`.`phase` ALTER COLUMN `contingency_budget` SET TAGS ('dbx_business_glossary_term' = 'Phase Contingency Budget');
ALTER TABLE `vibe_construction_v1`.`project`.`phase` ALTER COLUMN `contingency_budget` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`project`.`phase` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_construction_v1`.`project`.`phase` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_construction_v1`.`project`.`phase` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_construction_v1`.`project`.`phase` ALTER COLUMN `deliverables_checklist` SET TAGS ('dbx_business_glossary_term' = 'Phase Deliverables Checklist');
ALTER TABLE `vibe_construction_v1`.`project`.`phase` ALTER COLUMN `deliverables_completion_pct` SET TAGS ('dbx_business_glossary_term' = 'Deliverables Completion Percentage');
ALTER TABLE `vibe_construction_v1`.`project`.`phase` ALTER COLUMN `delivery_model` SET TAGS ('dbx_business_glossary_term' = 'Project Delivery Model');
ALTER TABLE `vibe_construction_v1`.`project`.`phase` ALTER COLUMN `delivery_model` SET TAGS ('dbx_value_regex' = 'epc|db|dbb|ppp|bot|gmp');
ALTER TABLE `vibe_construction_v1`.`project`.`phase` ALTER COLUMN `phase_description` SET TAGS ('dbx_business_glossary_term' = 'Phase Description');
ALTER TABLE `vibe_construction_v1`.`project`.`phase` ALTER COLUMN `earned_value` SET TAGS ('dbx_business_glossary_term' = 'Earned Value (EV) / Budgeted Cost of Work Performed (BCWP)');
ALTER TABLE `vibe_construction_v1`.`project`.`phase` ALTER COLUMN `earned_value` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`project`.`phase` ALTER COLUMN `eot_days_granted` SET TAGS ('dbx_business_glossary_term' = 'EOT (Extension of Time) Days Granted');
ALTER TABLE `vibe_construction_v1`.`project`.`phase` ALTER COLUMN `evm_weight_pct` SET TAGS ('dbx_business_glossary_term' = 'EVM (Earned Value Management) Weight Percentage');
ALTER TABLE `vibe_construction_v1`.`project`.`phase` ALTER COLUMN `float_days` SET TAGS ('dbx_business_glossary_term' = 'Total Float (Days)');
ALTER TABLE `vibe_construction_v1`.`project`.`phase` ALTER COLUMN `forecast_finish_date` SET TAGS ('dbx_business_glossary_term' = 'Forecast Finish Date');
ALTER TABLE `vibe_construction_v1`.`project`.`phase` ALTER COLUMN `gate_approval_date` SET TAGS ('dbx_business_glossary_term' = 'Phase Gate Approval Date');
ALTER TABLE `vibe_construction_v1`.`project`.`phase` ALTER COLUMN `gate_approval_status` SET TAGS ('dbx_business_glossary_term' = 'Phase Gate Approval Status');
ALTER TABLE `vibe_construction_v1`.`project`.`phase` ALTER COLUMN `gate_approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected|conditionally_approved|waived');
ALTER TABLE `vibe_construction_v1`.`project`.`phase` ALTER COLUMN `gate_approver_name` SET TAGS ('dbx_business_glossary_term' = 'Phase Gate Approver Name');
ALTER TABLE `vibe_construction_v1`.`project`.`phase` ALTER COLUMN `gate_review_criteria` SET TAGS ('dbx_business_glossary_term' = 'Phase Gate Review Criteria');
ALTER TABLE `vibe_construction_v1`.`project`.`phase` ALTER COLUMN `hse_plan_approved` SET TAGS ('dbx_business_glossary_term' = 'HSE (Health Safety and Environment) Plan Approved');
ALTER TABLE `vibe_construction_v1`.`project`.`phase` ALTER COLUMN `is_critical_path` SET TAGS ('dbx_business_glossary_term' = 'Is Critical Path Phase');
ALTER TABLE `vibe_construction_v1`.`project`.`phase` ALTER COLUMN `ld_exposure_amount` SET TAGS ('dbx_business_glossary_term' = 'LD (Liquidated Damages) Exposure Amount');
ALTER TABLE `vibe_construction_v1`.`project`.`phase` ALTER COLUMN `ld_exposure_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`project`.`phase` ALTER COLUMN `leed_applicable` SET TAGS ('dbx_business_glossary_term' = 'LEED (Leadership in Energy and Environmental Design) Applicable');
ALTER TABLE `vibe_construction_v1`.`project`.`phase` ALTER COLUMN `milestone_count` SET TAGS ('dbx_business_glossary_term' = 'Milestone Count');
ALTER TABLE `vibe_construction_v1`.`project`.`phase` ALTER COLUMN `phase_name` SET TAGS ('dbx_business_glossary_term' = 'Phase Name');
ALTER TABLE `vibe_construction_v1`.`project`.`phase` ALTER COLUMN `percent_complete` SET TAGS ('dbx_business_glossary_term' = 'Percent Complete');
ALTER TABLE `vibe_construction_v1`.`project`.`phase` ALTER COLUMN `phase_status` SET TAGS ('dbx_business_glossary_term' = 'Phase Status');
ALTER TABLE `vibe_construction_v1`.`project`.`phase` ALTER COLUMN `phase_status` SET TAGS ('dbx_value_regex' = 'not_started|in_progress|on_hold|completed|cancelled');
ALTER TABLE `vibe_construction_v1`.`project`.`phase` ALTER COLUMN `phase_type` SET TAGS ('dbx_business_glossary_term' = 'Phase Type');
ALTER TABLE `vibe_construction_v1`.`project`.`phase` ALTER COLUMN `planned_finish_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Finish Date');
ALTER TABLE `vibe_construction_v1`.`project`.`phase` ALTER COLUMN `planned_start_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Start Date');
ALTER TABLE `vibe_construction_v1`.`project`.`phase` ALTER COLUMN `quality_plan_approved` SET TAGS ('dbx_business_glossary_term' = 'Quality Plan Approved');
ALTER TABLE `vibe_construction_v1`.`project`.`phase` ALTER COLUMN `risk_rating` SET TAGS ('dbx_business_glossary_term' = 'Phase Risk Rating');
ALTER TABLE `vibe_construction_v1`.`project`.`phase` ALTER COLUMN `risk_rating` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `vibe_construction_v1`.`project`.`phase` ALTER COLUMN `sap_wbs_element` SET TAGS ('dbx_business_glossary_term' = 'SAP WBS (Work Breakdown Structure) Element');
ALTER TABLE `vibe_construction_v1`.`project`.`phase` ALTER COLUMN `sap_wbs_element` SET TAGS ('dbx_value_regex' = '^[A-Z0-9._-]{1,24}$');
ALTER TABLE `vibe_construction_v1`.`project`.`phase` ALTER COLUMN `schedule_variance_days` SET TAGS ('dbx_business_glossary_term' = 'Schedule Variance (Days)');
ALTER TABLE `vibe_construction_v1`.`project`.`phase` ALTER COLUMN `sequence_number` SET TAGS ('dbx_business_glossary_term' = 'Phase Sequence Number');
ALTER TABLE `vibe_construction_v1`.`project`.`phase` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_construction_v1`.`project`.`forecast` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_construction_v1`.`project`.`forecast` SET TAGS ('dbx_subdomain' = 'cost_control');
ALTER TABLE `vibe_construction_v1`.`project`.`forecast` ALTER COLUMN `forecast_id` SET TAGS ('dbx_business_glossary_term' = 'Forecast ID');
ALTER TABLE `vibe_construction_v1`.`project`.`forecast` ALTER COLUMN `change_order_id` SET TAGS ('dbx_business_glossary_term' = 'Project Change Order Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`project`.`forecast` ALTER COLUMN `construction_project_id` SET TAGS ('dbx_business_glossary_term' = 'Project ID');
ALTER TABLE `vibe_construction_v1`.`project`.`forecast` ALTER COLUMN `cost_account_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Account Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`project`.`forecast` ALTER COLUMN `evm_period_record_id` SET TAGS ('dbx_business_glossary_term' = 'Evm Period Record Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`project`.`forecast` ALTER COLUMN `phase_id` SET TAGS ('dbx_business_glossary_term' = 'Phase Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`project`.`forecast` ALTER COLUMN `project_baseline_id` SET TAGS ('dbx_business_glossary_term' = 'Baseline ID');
ALTER TABLE `vibe_construction_v1`.`project`.`forecast` ALTER COLUMN `project_budget_id` SET TAGS ('dbx_business_glossary_term' = 'Project Budget Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`project`.`forecast` ALTER COLUMN `wbs_element_id` SET TAGS ('dbx_business_glossary_term' = 'Work Breakdown Structure (WBS) Element ID');
ALTER TABLE `vibe_construction_v1`.`project`.`forecast` ALTER COLUMN `actual_cost_to_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Cost to Date');
ALTER TABLE `vibe_construction_v1`.`project`.`forecast` ALTER COLUMN `actual_cost_to_date` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`project`.`forecast` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Forecast Approval Date');
ALTER TABLE `vibe_construction_v1`.`project`.`forecast` ALTER COLUMN `bac_cost` SET TAGS ('dbx_business_glossary_term' = 'Budget at Completion (BAC) Cost');
ALTER TABLE `vibe_construction_v1`.`project`.`forecast` ALTER COLUMN `bac_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`project`.`forecast` ALTER COLUMN `baseline_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Baseline Completion Date');
ALTER TABLE `vibe_construction_v1`.`project`.`forecast` ALTER COLUMN `completion_date` SET TAGS ('dbx_business_glossary_term' = 'Forecast Completion Date');
ALTER TABLE `vibe_construction_v1`.`project`.`forecast` ALTER COLUMN `contingency_remaining` SET TAGS ('dbx_business_glossary_term' = 'Contingency Remaining');
ALTER TABLE `vibe_construction_v1`.`project`.`forecast` ALTER COLUMN `contingency_remaining` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`project`.`forecast` ALTER COLUMN `cost_trend_indicator` SET TAGS ('dbx_business_glossary_term' = 'Cost Trend Indicator');
ALTER TABLE `vibe_construction_v1`.`project`.`forecast` ALTER COLUMN `cost_trend_indicator` SET TAGS ('dbx_value_regex' = 'improving|stable|deteriorating');
ALTER TABLE `vibe_construction_v1`.`project`.`forecast` ALTER COLUMN `cost_variance` SET TAGS ('dbx_business_glossary_term' = 'Cost Variance (CV)');
ALTER TABLE `vibe_construction_v1`.`project`.`forecast` ALTER COLUMN `cost_variance` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`project`.`forecast` ALTER COLUMN `cost_variance_pct` SET TAGS ('dbx_business_glossary_term' = 'Cost Variance Percentage');
ALTER TABLE `vibe_construction_v1`.`project`.`forecast` ALTER COLUMN `cost_variance_pct` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`project`.`forecast` ALTER COLUMN `cpi` SET TAGS ('dbx_business_glossary_term' = 'Cost Performance Index (CPI)');
ALTER TABLE `vibe_construction_v1`.`project`.`forecast` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_construction_v1`.`project`.`forecast` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_construction_v1`.`project`.`forecast` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_construction_v1`.`project`.`forecast` ALTER COLUMN `eac_cost` SET TAGS ('dbx_business_glossary_term' = 'Estimate at Completion (EAC) Cost');
ALTER TABLE `vibe_construction_v1`.`project`.`forecast` ALTER COLUMN `eac_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`project`.`forecast` ALTER COLUMN `eac_movement` SET TAGS ('dbx_business_glossary_term' = 'Estimate at Completion (EAC) Movement');
ALTER TABLE `vibe_construction_v1`.`project`.`forecast` ALTER COLUMN `eac_movement` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`project`.`forecast` ALTER COLUMN `earned_value` SET TAGS ('dbx_business_glossary_term' = 'Earned Value (EV)');
ALTER TABLE `vibe_construction_v1`.`project`.`forecast` ALTER COLUMN `earned_value` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`project`.`forecast` ALTER COLUMN `etc_cost` SET TAGS ('dbx_business_glossary_term' = 'Estimate to Complete (ETC) Cost');
ALTER TABLE `vibe_construction_v1`.`project`.`forecast` ALTER COLUMN `etc_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`project`.`forecast` ALTER COLUMN `exchange_rate` SET TAGS ('dbx_business_glossary_term' = 'Exchange Rate');
ALTER TABLE `vibe_construction_v1`.`project`.`forecast` ALTER COLUMN `final_cost` SET TAGS ('dbx_business_glossary_term' = 'Forecast Final Cost');
ALTER TABLE `vibe_construction_v1`.`project`.`forecast` ALTER COLUMN `final_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`project`.`forecast` ALTER COLUMN `forecast_number` SET TAGS ('dbx_business_glossary_term' = 'Forecast Number');
ALTER TABLE `vibe_construction_v1`.`project`.`forecast` ALTER COLUMN `forecast_status` SET TAGS ('dbx_business_glossary_term' = 'Forecast Status');
ALTER TABLE `vibe_construction_v1`.`project`.`forecast` ALTER COLUMN `forecast_status` SET TAGS ('dbx_value_regex' = 'draft|submitted|approved|superseded|cancelled');
ALTER TABLE `vibe_construction_v1`.`project`.`forecast` ALTER COLUMN `forecast_type` SET TAGS ('dbx_business_glossary_term' = 'Forecast Type');
ALTER TABLE `vibe_construction_v1`.`project`.`forecast` ALTER COLUMN `forecast_type` SET TAGS ('dbx_value_regex' = 'monthly|quarterly|annual|ad_hoc');
ALTER TABLE `vibe_construction_v1`.`project`.`forecast` ALTER COLUMN `is_client_reported` SET TAGS ('dbx_business_glossary_term' = 'Is Client Reported Flag');
ALTER TABLE `vibe_construction_v1`.`project`.`forecast` ALTER COLUMN `management_reserve_remaining` SET TAGS ('dbx_business_glossary_term' = 'Management Reserve Remaining');
ALTER TABLE `vibe_construction_v1`.`project`.`forecast` ALTER COLUMN `management_reserve_remaining` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`project`.`forecast` ALTER COLUMN `narrative_commentary` SET TAGS ('dbx_business_glossary_term' = 'Forecast Narrative Commentary');
ALTER TABLE `vibe_construction_v1`.`project`.`forecast` ALTER COLUMN `percent_complete` SET TAGS ('dbx_business_glossary_term' = 'Percent Complete');
ALTER TABLE `vibe_construction_v1`.`project`.`forecast` ALTER COLUMN `planned_value` SET TAGS ('dbx_business_glossary_term' = 'Planned Value (PV)');
ALTER TABLE `vibe_construction_v1`.`project`.`forecast` ALTER COLUMN `planned_value` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`project`.`forecast` ALTER COLUMN `prior_period_eac` SET TAGS ('dbx_business_glossary_term' = 'Prior Period Estimate at Completion (EAC)');
ALTER TABLE `vibe_construction_v1`.`project`.`forecast` ALTER COLUMN `prior_period_eac` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`project`.`forecast` ALTER COLUMN `reporting_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Reporting Currency Code');
ALTER TABLE `vibe_construction_v1`.`project`.`forecast` ALTER COLUMN `reporting_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_construction_v1`.`project`.`forecast` ALTER COLUMN `reporting_period_date` SET TAGS ('dbx_business_glossary_term' = 'Reporting Period Date');
ALTER TABLE `vibe_construction_v1`.`project`.`forecast` ALTER COLUMN `revision_number` SET TAGS ('dbx_business_glossary_term' = 'Forecast Revision Number');
ALTER TABLE `vibe_construction_v1`.`project`.`forecast` ALTER COLUMN `risk_provision_amount` SET TAGS ('dbx_business_glossary_term' = 'Risk Provision Amount');
ALTER TABLE `vibe_construction_v1`.`project`.`forecast` ALTER COLUMN `risk_provision_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`project`.`forecast` ALTER COLUMN `sap_project_version` SET TAGS ('dbx_business_glossary_term' = 'SAP Project Version');
ALTER TABLE `vibe_construction_v1`.`project`.`forecast` ALTER COLUMN `schedule_trend_indicator` SET TAGS ('dbx_business_glossary_term' = 'Schedule Trend Indicator');
ALTER TABLE `vibe_construction_v1`.`project`.`forecast` ALTER COLUMN `schedule_trend_indicator` SET TAGS ('dbx_value_regex' = 'improving|stable|deteriorating');
ALTER TABLE `vibe_construction_v1`.`project`.`forecast` ALTER COLUMN `schedule_variance_days` SET TAGS ('dbx_business_glossary_term' = 'Schedule Variance (SV) Days');
ALTER TABLE `vibe_construction_v1`.`project`.`forecast` ALTER COLUMN `spi` SET TAGS ('dbx_business_glossary_term' = 'Schedule Performance Index (SPI)');
ALTER TABLE `vibe_construction_v1`.`project`.`forecast` ALTER COLUMN `tcpi` SET TAGS ('dbx_business_glossary_term' = 'To-Complete Performance Index (TCPI)');
ALTER TABLE `vibe_construction_v1`.`project`.`forecast` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_construction_v1`.`project`.`forecast` ALTER COLUMN `variance_at_completion` SET TAGS ('dbx_business_glossary_term' = 'Variance at Completion (VAC)');
ALTER TABLE `vibe_construction_v1`.`project`.`forecast` ALTER COLUMN `variance_at_completion` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`project`.`project_site` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_construction_v1`.`project`.`project_site` SET TAGS ('dbx_subdomain' = 'project_setup');
ALTER TABLE `vibe_construction_v1`.`project`.`project_site` ALTER COLUMN `project_site_id` SET TAGS ('dbx_business_glossary_term' = 'Site Identifier');
ALTER TABLE `vibe_construction_v1`.`project`.`project_site` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`project`.`project_site` ALTER COLUMN `warehouse_id` SET TAGS ('dbx_business_glossary_term' = 'Warehouse Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`project`.`project_site` ALTER COLUMN `actual_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Completion Date');
ALTER TABLE `vibe_construction_v1`.`project`.`project_site` ALTER COLUMN `actual_spend` SET TAGS ('dbx_business_glossary_term' = 'Actual Spend');
ALTER TABLE `vibe_construction_v1`.`project`.`project_site` ALTER COLUMN `address_line1` SET TAGS ('dbx_business_glossary_term' = 'Address Line1');
ALTER TABLE `vibe_construction_v1`.`project`.`project_site` ALTER COLUMN `address_line1` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_construction_v1`.`project`.`project_site` ALTER COLUMN `address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_construction_v1`.`project`.`project_site` ALTER COLUMN `address_line2` SET TAGS ('dbx_business_glossary_term' = 'Address Line2');
ALTER TABLE `vibe_construction_v1`.`project`.`project_site` ALTER COLUMN `address_line2` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_construction_v1`.`project`.`project_site` ALTER COLUMN `address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_construction_v1`.`project`.`project_site` ALTER COLUMN `area_sq_m` SET TAGS ('dbx_business_glossary_term' = 'Area Sq M');
ALTER TABLE `vibe_construction_v1`.`project`.`project_site` ALTER COLUMN `budget_amount` SET TAGS ('dbx_business_glossary_term' = 'Budget Amount');
ALTER TABLE `vibe_construction_v1`.`project`.`project_site` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'City');
ALTER TABLE `vibe_construction_v1`.`project`.`project_site` ALTER COLUMN `country` SET TAGS ('dbx_business_glossary_term' = 'Country');
ALTER TABLE `vibe_construction_v1`.`project`.`project_site` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_construction_v1`.`project`.`project_site` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_construction_v1`.`project`.`project_site` ALTER COLUMN `elevation_m` SET TAGS ('dbx_business_glossary_term' = 'Elevation M');
ALTER TABLE `vibe_construction_v1`.`project`.`project_site` ALTER COLUMN `environmental_zone` SET TAGS ('dbx_business_glossary_term' = 'Environmental Zone');
ALTER TABLE `vibe_construction_v1`.`project`.`project_site` ALTER COLUMN `ground_condition` SET TAGS ('dbx_business_glossary_term' = 'Ground Condition');
ALTER TABLE `vibe_construction_v1`.`project`.`project_site` ALTER COLUMN `insurance_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Insurance Expiry Date');
ALTER TABLE `vibe_construction_v1`.`project`.`project_site` ALTER COLUMN `insurance_policy_number` SET TAGS ('dbx_business_glossary_term' = 'Insurance Policy Number');
ALTER TABLE `vibe_construction_v1`.`project`.`project_site` ALTER COLUMN `insurance_policy_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_construction_v1`.`project`.`project_site` ALTER COLUMN `insurance_policy_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_construction_v1`.`project`.`project_site` ALTER COLUMN `last_inspection_date` SET TAGS ('dbx_business_glossary_term' = 'Last Inspection Date');
ALTER TABLE `vibe_construction_v1`.`project`.`project_site` ALTER COLUMN `latitude` SET TAGS ('dbx_business_glossary_term' = 'Latitude');
ALTER TABLE `vibe_construction_v1`.`project`.`project_site` ALTER COLUMN `latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_construction_v1`.`project`.`project_site` ALTER COLUMN `latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_construction_v1`.`project`.`project_site` ALTER COLUMN `longitude` SET TAGS ('dbx_business_glossary_term' = 'Longitude');
ALTER TABLE `vibe_construction_v1`.`project`.`project_site` ALTER COLUMN `longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_construction_v1`.`project`.`project_site` ALTER COLUMN `longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_construction_v1`.`project`.`project_site` ALTER COLUMN `manager_email` SET TAGS ('dbx_business_glossary_term' = 'Site Manager Email');
ALTER TABLE `vibe_construction_v1`.`project`.`project_site` ALTER COLUMN `manager_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_construction_v1`.`project`.`project_site` ALTER COLUMN `manager_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_construction_v1`.`project`.`project_site` ALTER COLUMN `manager_name` SET TAGS ('dbx_business_glossary_term' = 'Site Manager Name');
ALTER TABLE `vibe_construction_v1`.`project`.`project_site` ALTER COLUMN `manager_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_construction_v1`.`project`.`project_site` ALTER COLUMN `manager_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_construction_v1`.`project`.`project_site` ALTER COLUMN `manager_phone` SET TAGS ('dbx_business_glossary_term' = 'Site Manager Phone');
ALTER TABLE `vibe_construction_v1`.`project`.`project_site` ALTER COLUMN `manager_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_construction_v1`.`project`.`project_site` ALTER COLUMN `manager_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_construction_v1`.`project`.`project_site` ALTER COLUMN `number_of_floors` SET TAGS ('dbx_business_glossary_term' = 'Number Of Floors');
ALTER TABLE `vibe_construction_v1`.`project`.`project_site` ALTER COLUMN `permits` SET TAGS ('dbx_business_glossary_term' = 'Permits');
ALTER TABLE `vibe_construction_v1`.`project`.`project_site` ALTER COLUMN `planned_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Completion Date');
ALTER TABLE `vibe_construction_v1`.`project`.`project_site` ALTER COLUMN `postal_code` SET TAGS ('dbx_business_glossary_term' = 'Postal Code');
ALTER TABLE `vibe_construction_v1`.`project`.`project_site` ALTER COLUMN `postal_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_construction_v1`.`project`.`project_site` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_construction_v1`.`project`.`project_site` ALTER COLUMN `power_capacity_mw` SET TAGS ('dbx_business_glossary_term' = 'Power Capacity Mw');
ALTER TABLE `vibe_construction_v1`.`project`.`project_site` ALTER COLUMN `risk_rating` SET TAGS ('dbx_business_glossary_term' = 'Risk Rating');
ALTER TABLE `vibe_construction_v1`.`project`.`project_site` ALTER COLUMN `security_level` SET TAGS ('dbx_business_glossary_term' = 'Security Level');
ALTER TABLE `vibe_construction_v1`.`project`.`project_site` ALTER COLUMN `site_description` SET TAGS ('dbx_business_glossary_term' = 'Description');
ALTER TABLE `vibe_construction_v1`.`project`.`project_site` ALTER COLUMN `site_status` SET TAGS ('dbx_business_glossary_term' = 'Status');
ALTER TABLE `vibe_construction_v1`.`project`.`project_site` ALTER COLUMN `site_type` SET TAGS ('dbx_business_glossary_term' = 'Site Type');
ALTER TABLE `vibe_construction_v1`.`project`.`project_site` ALTER COLUMN `soil_type` SET TAGS ('dbx_business_glossary_term' = 'Soil Type');
ALTER TABLE `vibe_construction_v1`.`project`.`project_site` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Start Date');
ALTER TABLE `vibe_construction_v1`.`project`.`project_site` ALTER COLUMN `state` SET TAGS ('dbx_business_glossary_term' = 'State');
ALTER TABLE `vibe_construction_v1`.`project`.`project_site` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_construction_v1`.`project`.`project_site` ALTER COLUMN `utility_connection_status` SET TAGS ('dbx_business_glossary_term' = 'Utility Connection Status');
ALTER TABLE `vibe_construction_v1`.`project`.`project_site` ALTER COLUMN `water_supply_type` SET TAGS ('dbx_business_glossary_term' = 'Water Supply Type');
