-- Schema for Domain: mel | Business: Ngo | Version: v2_mvm
-- Generated on: 2026-07-10 20:23:32

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_ngo_v1`.`mel` COMMENT 'Owns all Monitoring, Evaluation, and Learning (MEL) and MEAL framework data. Manages indicator libraries, LogFrame targets vs. actuals, KPI tracking, PDM (Post-Distribution Monitoring) results, FGD and KII records, DHIS2 aggregate reporting, outcome measurement, impact assessments, and Results-Based Management (RBM) evidence. Supports DAC evaluation criteria and donor performance reporting.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_ngo_v1`.`mel`.`indicator` (
    `indicator_id` BIGINT COMMENT 'Unique identifier for the MEL (Monitoring Evaluation and Learning) indicator. Primary key.',
    `agreement_id` BIGINT COMMENT 'Foreign key linking to partnership.partnership_agreement. Business justification: Indicators are agreement-specific reporting obligations. Business need: agreement compliance monitoring, donor reporting, performance-based payment triggers.',
    `award_id` BIGINT COMMENT 'Foreign key reference to the grant or award that mandates or funds the tracking of this indicator. Null if the indicator is used across multiple grants or is organization-wide.',
    `component_id` BIGINT COMMENT 'Foreign key linking to program.component. Business justification: Indicators are defined at component level in multi-component programs for component-specific performance tracking and donor compliance reporting. Component-level indicator management is standard NGO M',
    `consortium_id` BIGINT COMMENT 'Foreign key linking to partnership.consortium. Business justification: Consortium-level indicators are defined for joint donor reporting across all member organizations. NGO MEL teams track indicators at the consortium level distinct from individual partner indicators. i',
    `intervention_id` BIGINT COMMENT 'Foreign key reference to the program that owns or primarily uses this indicator. An indicator may be used across multiple programs but typically has a primary owning program.',
    `partner_org_id` BIGINT COMMENT 'Foreign key linking to partnership.partner_org. Business justification: Indicators frequently track partner-specific performance metrics in sub-award agreements. Business need: partner accountability reporting, disaggregated results by implementing partner, performance-ba',
    `program_id` BIGINT COMMENT 'Foreign key linking to program.program. Business justification: Program-level indicator dashboards and donor reporting require knowing which program an indicator belongs to. Currently indicator only links to intervention; program-level M&E reporting aggregates ind',
    `baseline_date` DATE COMMENT 'The date when the baseline value was measured or established.',
    `baseline_value` DECIMAL(18,2) COMMENT 'The initial measured value of the indicator at the start of the program or project, used as the reference point for measuring change and progress.',
    `calculation_method` STRING COMMENT 'Formula or methodology used to calculate the indicator value. For ratio indicators, includes numerator and denominator definitions. For count indicators, specifies aggregation rules.',
    `indicator_category` STRING COMMENT 'Measurement category of the indicator: quantitative (numeric), qualitative (descriptive), or composite (combination of multiple measures).. Valid values are `quantitative|qualitative|composite`',
    `indicator_code` STRING COMMENT 'Unique business identifier code for the indicator used across programs and grants. Often follows organizational or donor-specific coding conventions.. Valid values are `^[A-Z0-9]{3,20}$`',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this indicator record was first created in the system.',
    `dac_criteria_alignment` STRING COMMENT 'The OECD DAC (Development Assistance Committee) evaluation criteria that this indicator addresses: relevance, coherence, effectiveness, efficiency, impact, or sustainability. Multiple criteria may be comma-separated.',
    `data_collection_frequency` STRING COMMENT 'How often data for this indicator is collected and reported (e.g., monthly, quarterly, annually, one-time baseline/endline). [ENUM-REF-CANDIDATE: daily|weekly|monthly|quarterly|semi-annually|annually|one-time|event-based — 8 candidates stripped; promote to reference product]',
    `data_collection_method` STRING COMMENT 'The methodology used to collect data for this indicator (e.g., household survey, key informant interview, direct observation, facility records, mobile data collection). [ENUM-REF-CANDIDATE: survey|interview|observation|administrative-records|focus-group|sensor|mobile-app|registry — 8 candidates stripped; promote to reference product]',
    `data_source` STRING COMMENT 'The primary source(s) from which data for this indicator is collected (e.g., DHIS2, KoboToolbox surveys, PDM (Post-Distribution Monitoring), FGD (Focus Group Discussion), KII (Key Informant Interview), administrative records, CommCare).',
    `definition` STRING COMMENT 'Detailed technical definition of what the indicator measures, including scope, boundaries, and any specific criteria or conditions that must be met.',
    `denominator_description` STRING COMMENT 'Definition of the denominator for percentage or ratio indicators. Describes the total population or base being measured. Null for count-based indicators.',
    `dhis2_indicator_code` STRING COMMENT 'The unique identifier for this indicator in the DHIS2 (District Health Information System 2) platform, used for integration and data synchronization.',
    `direction_of_change` STRING COMMENT 'The desired direction of change for this indicator to represent positive program impact (increase for positive indicators like vaccination coverage, decrease for negative indicators like malnutrition rates).. Valid values are `increase|decrease|maintain|not-applicable`',
    `disaggregation_dimensions` STRING COMMENT 'Comma-separated list of dimensions by which this indicator should be disaggregated for analysis (e.g., age, gender, location, disability status, IDP/refugee status). Critical for equity and inclusion analysis.',
    `effective_end_date` DATE COMMENT 'The date after which this indicator definition is no longer active. Null for currently active indicators.',
    `effective_start_date` DATE COMMENT 'The date from which this indicator definition became active and applicable for data collection and reporting.',
    `indicator_status` STRING COMMENT 'Current lifecycle status of the indicator in the MEL (Monitoring Evaluation and Learning) system.. Valid values are `active|inactive|draft|archived|under-review`',
    `indicator_type` STRING COMMENT 'Classification of the indicator within the Results-Based Management (RBM) results chain: input (resources), process (activities), output (deliverables), outcome (short-term change), or impact (long-term change).. Valid values are `output|outcome|impact|process|input`',
    `is_custom` BOOLEAN COMMENT 'Flag indicating whether this is a custom indicator developed specifically for this organization or program (true) or a standard indicator from an external framework (false).',
    `is_mandatory` BOOLEAN COMMENT 'Flag indicating whether this indicator is mandatory for reporting to donors or governing bodies (true) or optional/supplementary (false).',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this indicator record was last updated or modified.',
    `logframe_level` STRING COMMENT 'The level in the LogFrame (Logical Framework) hierarchy where this indicator is positioned: goal (impact), purpose (outcome), output (deliverable), or activity (process).. Valid values are `goal|purpose|output|activity`',
    `indicator_name` STRING COMMENT 'Full descriptive name of the indicator as it appears in LogFrames (Logical Frameworks), donor reports, and MEL (Monitoring Evaluation and Learning) dashboards.',
    `notes` STRING COMMENT 'Additional notes, guidance, or context for data collectors and analysts regarding this indicator, including any special considerations, limitations, or interpretation guidance.',
    `numerator_description` STRING COMMENT 'Definition of the numerator for percentage or ratio indicators. Describes what is being counted in the top of the fraction. Null for count-based indicators.',
    `reporting_frequency` STRING COMMENT 'How often this indicator must be reported to donors, management, or external stakeholders. May differ from collection frequency.. Valid values are `monthly|quarterly|semi-annually|annually|ad-hoc`',
    `responsible_role` STRING COMMENT 'The organizational role or position responsible for collecting, validating, and reporting data for this indicator (e.g., MEL Officer, Program Manager, Field Coordinator).',
    `sdg_alignment` STRING COMMENT 'The specific SDG (Sustainable Development Goal) goal and target numbers that this indicator contributes to (e.g., SDG 2.1, SDG 3.2). Multiple goals may be comma-separated.',
    `sector` STRING COMMENT 'The humanitarian or development sector this indicator belongs to (e.g., WASH (Water Sanitation and Hygiene), Health, Nutrition, Education, Protection, Shelter, Food Security, Livelihoods).',
    `target_date` DATE COMMENT 'The date by which the target value is expected to be achieved.',
    `target_value` DECIMAL(18,2) COMMENT 'The planned or target value that the program aims to achieve for this indicator by the end of the reporting period or project lifecycle.',
    `theme` STRING COMMENT 'Cross-cutting theme or focus area this indicator addresses (e.g., Gender Equality, Child Protection, Climate Adaptation, Disability Inclusion, GBV (Gender-Based Violence) Prevention).',
    `unit_of_measure` STRING COMMENT 'The unit in which the indicator is measured (e.g., number of people, percentage, households, liters, kilograms, days, sessions).',
    `verification_method` STRING COMMENT 'The method used to verify the accuracy and reliability of the indicator data (e.g., spot checks, third-party evaluation, beneficiary feedback, document review, field monitoring visits).',
    `version_number` STRING COMMENT 'Version identifier for this indicator definition, used to track changes to calculation methods, definitions, or disaggregation requirements over time.. Valid values are `^[0-9]+.[0-9]+$`',
    CONSTRAINT pk_indicator PRIMARY KEY(`indicator_id`)
) COMMENT 'Master library of all MEL indicators used across programs and grants. Each record defines one measurable indicator with its definition, calculation method, numerator/denominator (for percentage indicators), unit of measure, data collection frequency, disaggregation dimensions, baseline value, and alignment to SDG goals, DAC criteria, and LogFrame output/outcome levels. Serves as the single source of truth for indicator metadata referenced by targets, results, DHIS2 reporting, and donor performance frameworks.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`mel`.`mel_logframe` (
    `mel_logframe_id` BIGINT COMMENT 'Unique identifier for the logical framework record. Primary key for the MEL LogFrame entity.',
    `agreement_id` BIGINT COMMENT 'Foreign key linking to partnership.partnership_agreement. Business justification: Logframes are core agreement annexes defining results frameworks. Business need: agreement results tracking, donor reporting compliance, partnership performance monitoring.',
    `component_id` BIGINT COMMENT 'Foreign key linking to program.component. Business justification: In multi-component programs, separate MEL logframes are maintained per component with distinct donor-funded results chains. Component-level logframe management is standard for large NGO programs. No e',
    `consortium_id` BIGINT COMMENT 'Foreign key linking to partnership.consortium. Business justification: Consortium programs use a shared logframe across all member organizations for joint donor reporting. NGO MEL teams develop and maintain a consortium-level logframe that all members report against. mel',
    `award_id` BIGINT COMMENT 'Reference to the grant or award that this logical framework supports. Links the LogFrame to the funding source and donor requirements.',
    `indicator_id` BIGINT COMMENT 'Foreign key linking to mel.indicator. Business justification: In NGO MEL practice, each LogFrame row (at output, outcome, or impact level) is linked to a specific indicator from the master indicator library. mel_logframe currently has an objectively_verifiable_i',
    `intervention_id` BIGINT COMMENT 'Reference to the program or project that this logical framework defines. Links the LogFrame to operational program delivery.',
    `parent_logframe_mel_logframe_id` BIGINT COMMENT 'Self-referencing foreign key to the parent LogFrame entry in the hierarchy. Enables nested results chains where outputs roll up to outcomes, outcomes to goals.',
    `partner_org_id` BIGINT COMMENT 'Foreign key linking to partnership.partner_org. Business justification: Logframes track partner-implemented results in sub-award/consortium contexts. Business need: partner performance reporting against logframe indicators, disaggregated results tracking by implementing p',
    `program_id` BIGINT COMMENT 'Foreign key linking to program.program. Business justification: MEL logframes are created for programs — MEL teams manage program-level logframes for consolidated reporting. Currently mel_logframe only links to intervention; program-level logframe management and r',
    `actual_date` DATE COMMENT 'Date of the most recent actual measurement. Used to track reporting currency and identify data staleness.',
    `actual_value` DECIMAL(18,2) COMMENT 'Most recent measured or reported value for the indicator. Updated through Monitoring Evaluation and Learning (MEL) data collection activities such as Post-Distribution Monitoring (PDM), Focus Group Discussions (FGD), or District Health Information System 2 (DHIS2) reporting.',
    `approved_by` STRING COMMENT 'Name or identifier of the person or committee that approved this LogFrame. Critical for governance and donor compliance.',
    `approved_date` DATE COMMENT 'Date when this LogFrame was formally approved. Establishes the baseline for performance tracking and donor reporting.',
    `assumptions` STRING COMMENT 'External conditions or factors that must hold true for the intervention logic to succeed. Critical for risk management and Theory of Change (ToC) validation.',
    `baseline_date` DATE COMMENT 'Date when the baseline measurement was taken. Critical for establishing the temporal reference point for all subsequent measurements.',
    `baseline_value` DECIMAL(18,2) COMMENT 'Measured value of the indicator at the start of the program or intervention. Provides the starting point for measuring change and impact.',
    `mel_logframe_code` STRING COMMENT 'Business identifier or reference code for the logical framework, often aligned with donor proposal numbering or internal program codes.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this LogFrame record was first created in the system. Audit trail for data governance.',
    `dac_evaluation_criterion` STRING COMMENT 'Development Assistance Committee (DAC) evaluation criterion that this LogFrame element addresses. Used to align program design with international evaluation standards.. Valid values are `Relevance|Coherence|Effectiveness|Efficiency|Impact|Sustainability`',
    `data_collection_method` STRING COMMENT 'Primary method used to collect data for this indicator. Examples include household surveys, Key Informant Interviews (KII), Focus Group Discussions (FGD), Post-Distribution Monitoring (PDM), or District Health Information System 2 (DHIS2) aggregate reporting.',
    `disaggregation_dimensions` STRING COMMENT 'Dimensions by which the indicator should be disaggregated for equity and inclusion analysis. Common dimensions include gender, age group, disability status, geographic location, and vulnerability category.',
    `donor_template_type` STRING COMMENT 'Identifies the donor-specific logical framework template or format used. Different donors require different LogFrame structures and terminology. [ENUM-REF-CANDIDATE: DFID|FCDO|USAID|EU|ECHO|UN|World Bank|Generic|Other — 9 candidates stripped; promote to reference product]',
    `effective_end_date` DATE COMMENT 'Date when this LogFrame version was superseded or the program ended. Null for currently active LogFrames.',
    `effective_start_date` DATE COMMENT 'Date when this LogFrame version became effective. Used to track LogFrame amendments and revisions over the program lifecycle.',
    `hierarchy_sequence` STRING COMMENT 'Numeric ordering within the results chain hierarchy. Used to maintain the logical sequence of goals, outcomes, outputs, and activities.',
    `intervention_statement` STRING COMMENT 'Narrative description of the intervention logic at this level of the results chain. Describes what the program intends to achieve or deliver.',
    `is_custom_indicator` BOOLEAN COMMENT 'Flag indicating whether this is a custom indicator defined by the implementing organization rather than a standard donor or sector indicator.',
    `is_mandatory_donor_indicator` BOOLEAN COMMENT 'Flag indicating whether this indicator is a mandatory reporting requirement from the donor. Mandatory indicators cannot be modified without prior approval.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this LogFrame record was last updated. Audit trail for tracking changes and amendments.',
    `last_review_date` DATE COMMENT 'Date of the most recent review or evaluation of this LogFrame element. Used to track adaptive management cycles and mid-term reviews.',
    `means_of_verification` STRING COMMENT 'Data source or method by which the indicator will be measured and verified. Examples include surveys, administrative records, Post-Distribution Monitoring (PDM), or District Health Information System 2 (DHIS2) reports.',
    `mel_logframe_status` STRING COMMENT 'Current status of this LogFrame element in its lifecycle. Tracks whether targets are being met and whether the intervention logic remains valid. [ENUM-REF-CANDIDATE: Draft|Active|On Track|At Risk|Behind Schedule|Achieved|Closed|Cancelled — 8 candidates stripped; promote to reference product]',
    `mel_logframe_name` STRING COMMENT 'Descriptive name or title of the logical framework, typically reflecting the program or intervention name.',
    `next_review_date` DATE COMMENT 'Scheduled date for the next review or evaluation of this LogFrame element. Drives Monitoring Evaluation and Learning (MEL) planning and resource allocation.',
    `notes` STRING COMMENT 'Free-text field for additional context, lessons learned, or adaptive management decisions related to this LogFrame element.',
    `reporting_frequency` STRING COMMENT 'Frequency at which this indicator must be measured and reported to donors. Drives Monitoring Evaluation and Learning (MEL) data collection schedules.. Valid values are `Monthly|Quarterly|Semi-Annual|Annual|Ad-Hoc|Milestone-Based`',
    `responsible_party` STRING COMMENT 'Organization or team responsible for delivering this results chain element. May be the International Non-Governmental Organization (INGO), a Community-Based Organization (CBO), or a consortium partner.',
    `results_chain_level` STRING COMMENT 'Hierarchical level within the results chain that this LogFrame row represents. Defines whether this is a goal, outcome, output, or activity level entry. [ENUM-REF-CANDIDATE: Goal|Impact|Purpose|Outcome|Output|Activity|Input — 7 candidates stripped; promote to reference product]',
    `risks` STRING COMMENT 'Identified risks or threats that could prevent achievement of this results chain level. Used for risk mitigation planning and adaptive management.',
    `sdg_alignment` STRING COMMENT 'Sustainable Development Goal (SDG) and target that this LogFrame element contributes to. Enables SDG reporting and impact mapping.',
    `target_date` DATE COMMENT 'Date by which the target value is expected to be achieved. Aligns with program end date or milestone dates.',
    `target_value` DECIMAL(18,2) COMMENT 'Planned or target value for the indicator at the end of the program period. Used for performance tracking and variance analysis.',
    `theory_of_change_component` STRING COMMENT 'Identifies which component of the Theory of Change (ToC) this LogFrame row represents. Links the LogFrame to the broader causal pathway and intervention logic.',
    `unit_of_measure` STRING COMMENT 'Unit in which the indicator is measured. Examples include count, percentage, ratio, households, beneficiaries, or Mid-Upper Arm Circumference (MUAC) measurements.',
    `version` STRING COMMENT 'Version identifier for the logical framework. LogFrames are often revised during program amendments or mid-term reviews.',
    CONSTRAINT pk_mel_logframe PRIMARY KEY(`mel_logframe_id`)
) COMMENT 'Logical Framework (LogFrame) master records defining the results chain hierarchy for each program or grant. Each logframe captures the full intervention logic: goal (impact), purpose (outcome), outputs, activities, assumptions, risks, and objectively verifiable indicators (OVIs) at each level. Includes Theory of Change (ToC) components as embedded rows within the hierarchy. Aligns with DAC evaluation criteria, RBM standards, and donor-specific logframe templates (DFID/FCDO, USAID, EU, ECHO). Links to indicator targets for performance tracking and supports results framework reporting.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`mel`.`indicator_target` (
    `indicator_target_id` BIGINT COMMENT 'Unique identifier for the indicator target record. Primary key.',
    `agreement_id` BIGINT COMMENT 'Foreign key linking to partnership.partnership_agreement. Business justification: Targets set in partnership agreements as performance benchmarks. Business need: agreement milestone tracking, performance-based disbursement triggers, compliance verification.',
    `award_id` BIGINT COMMENT 'Reference to the grant or award funding this indicator target.',
    `component_id` BIGINT COMMENT 'Foreign key linking to program.component. Business justification: Indicator targets are set at component level in multi-component programs for component-specific performance tracking and donor reporting. Component-level target-setting is standard NGO M&E practice. N',
    `indicator_id` BIGINT COMMENT 'Reference to the indicator definition in the MEL indicator library for which this target is set.',
    `intervention_id` BIGINT COMMENT 'Reference to the program or project under which this indicator target is tracked.',
    `logframe_row_id` BIGINT COMMENT 'Foreign key linking to program.logframe_row. Business justification: Indicator targets are set against specific logframe rows (output/outcome level) — standard NGO logframe management. Targets are defined per logframe row per reporting period, enabling logframe-based t',
    `mel_logframe_id` BIGINT COMMENT 'Foreign key linking to mel.mel_logframe. Business justification: indicator_target already links to program.program_logframe (cross-domain) but has no FK to mel.mel_logframe. In MEL practice, planned targets are set within a specific LogFrame — the MEL logframe defi',
    `partner_org_id` BIGINT COMMENT 'Foreign key linking to partnership.partner_org. Business justification: Targets are set at partner level in sub-award agreements as performance benchmarks. Business need: partner-specific target setting, milestone tracking, performance-based disbursement triggers.',
    `project_site_id` BIGINT COMMENT 'Foreign key linking to field.project_site. Business justification: NGOs set indicator targets at the project site level for site-specific performance monitoring and accountability. Site-level target vs. result comparison is a standard MEL reporting requirement. No ex',
    `reporting_period_id` BIGINT COMMENT 'Reference to the specific reporting period (quarterly, annual, etc.) for which this target applies.',
    `approval_date` DATE COMMENT 'The date when this indicator target was formally approved by the responsible authority or donor.',
    `assumptions` STRING COMMENT 'Key assumptions underlying the achievement of this target, including external factors and preconditions.',
    `baseline_date` DATE COMMENT 'The date when the baseline value was measured or established.',
    `baseline_value` DECIMAL(18,2) COMMENT 'The baseline measurement value at the start of the program or reporting period, used as the starting point for target setting.',
    `indicator_target_code` STRING COMMENT 'Business identifier or code for this indicator target, often used in donor reports and LogFrame documentation.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this indicator target record was first created in the system.',
    `dac_sector_code` STRING COMMENT 'The OECD DAC sector classification code for this target, used for international aid transparency and reporting.',
    `data_collection_method` STRING COMMENT 'The primary method used to collect data for this target (e.g., household survey, FGD, KII, PDM, administrative records, DHIS2 aggregate).',
    `indicator_target_description` STRING COMMENT 'Detailed narrative description of what this target represents, including context and rationale.',
    `disaggregation_age_group` STRING COMMENT 'Age group category for this target (e.g., 0-5, 6-17, 18-59, 60+). Supports age-sensitive programming and reporting.',
    `disaggregation_disability_status` STRING COMMENT 'Disability status disaggregation for this target, supporting inclusive programming and Washington Group standards.. Valid values are `with_disability|without_disability|not_specified`',
    `disaggregation_displacement_status` STRING COMMENT 'Displacement or migration status disaggregation (e.g., IDP, refugee, returnee, host community, Person of Concern).',
    `disaggregation_sex` STRING COMMENT 'Sex-based disaggregation category for this target (male, female, other, not specified). Used for gender-sensitive monitoring.. Valid values are `male|female|other|not_specified`',
    `donor_reporting_requirement` STRING COMMENT 'Specific donor reporting requirement or framework that this target must satisfy (e.g., USAID F indicator, DFID logframe output 2.1).',
    `indicator_target_date` DATE COMMENT 'The date by which the target value is expected to be achieved.',
    `indicator_target_status` STRING COMMENT 'Current lifecycle status of the indicator target: draft (being defined), approved (validated by stakeholders), active (currently being tracked), on_track (progressing as planned), at_risk (may not be achieved), off_track (unlikely to be achieved), achieved (target met), not_achieved (target not met), revised (target has been modified), cancelled (target no longer applicable). [ENUM-REF-CANDIDATE: draft|approved|active|on_track|at_risk|off_track|achieved|not_achieved|revised|cancelled — 10 candidates stripped; promote to reference product]',
    `indicator_target_type` STRING COMMENT 'Classification of the target based on the results chain level: output (direct deliverables), outcome (intermediate results), impact (long-term change), process (operational efficiency), or input (resources).. Valid values are `output|outcome|impact|process|input`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this indicator target record was last updated or modified.',
    `measurement_frequency` STRING COMMENT 'How often this indicator target is measured and reported (daily, weekly, monthly, quarterly, semi-annually, annually, one-time, continuous). [ENUM-REF-CANDIDATE: daily|weekly|monthly|quarterly|semi_annually|annually|one_time|continuous — 8 candidates stripped; promote to reference product]',
    `mitigation_strategy` STRING COMMENT 'Planned strategies or actions to mitigate identified risks and ensure target achievement.',
    `indicator_target_name` STRING COMMENT 'Human-readable name or label for this indicator target.',
    `notes` STRING COMMENT 'Additional notes, comments, or contextual information about this indicator target.',
    `revision_date` DATE COMMENT 'The date when the target was last revised or amended.',
    `revision_reason` STRING COMMENT 'Explanation for any revision to the original target value or date, including contextual changes or donor amendments.',
    `risks` STRING COMMENT 'Identified risks that may prevent the achievement of this target, including contextual, operational, and external risks.',
    `sdg_alignment` STRING COMMENT 'The SDG goal and target number(s) that this indicator target contributes to (e.g., SDG 1.1, SDG 3.2).',
    `unit_of_measure` STRING COMMENT 'The unit in which the target and baseline values are measured (e.g., number of beneficiaries, percentage, households, liters).',
    `value` DECIMAL(18,2) COMMENT 'The planned or target value to be achieved for this indicator within the specified period and geographic scope.',
    `verification_source` STRING COMMENT 'The source or means of verification for this target (e.g., program records, beneficiary surveys, third-party evaluation, DHIS2 reports).',
    CONSTRAINT pk_indicator_target PRIMARY KEY(`indicator_target_id`)
) COMMENT 'Planned targets for each indicator within a specific logframe, grant reporting period, and geographic scope. Stores baseline, target value, target date, disaggregation breakdowns (sex, age, location), and the responsible program unit. Supports BvA-style target vs. actual tracking and donor performance reporting.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`mel`.`indicator_result` (
    `indicator_result_id` BIGINT COMMENT 'Unique identifier for the indicator result record. Primary key for the indicator result entity.',
    `assessment_id` BIGINT COMMENT 'Foreign key linking to field.assessment. Business justification: Indicator results are produced from field assessments. MEL data quality verification and audit trails require tracing each indicator result to the specific assessment that generated the data. No exist',
    `award_id` BIGINT COMMENT 'Reference to the grant award funding this indicator. Enables donor-specific performance reporting and compliance.',
    `commodity_id` BIGINT COMMENT 'Foreign key linking to supply.commodity. Business justification: Distribution-focused indicators (e.g., hygiene kits distributed) require linking results to specific commodities to verify what was actually distributed. Standard MEL practice in humanitarian progra',
    `component_id` BIGINT COMMENT 'Foreign key linking to program.component. Business justification: NGOs track indicator results by component for component-level performance reporting to donors and budget-vs-results analysis. Component-level M&E reporting is standard in multi-component grants. No ex',
    `distribution_event_id` BIGINT COMMENT 'Foreign key linking to field.distribution_event. Business justification: Distribution-related indicator results (beneficiaries reached, commodities distributed) are generated from distribution events. Donor reporting requires tracing indicator results to specific distribut',
    `distribution_order_id` BIGINT COMMENT 'Foreign key linking to supply.distribution_order. Business justification: Distribution orders are the field-level execution documents authorizing commodity delivery to beneficiaries. Linking indicator_result to distribution_order enables field accountability reporting — MEL',
    `distribution_plan_id` BIGINT COMMENT 'Foreign key linking to supply.distribution_plan. Business justification: Indicator results in supply-heavy NGO programs are generated by distribution activities. Linking indicator_result to the distribution_plan that produced it enables donor performance reports, variance ',
    `donor_report_id` BIGINT COMMENT 'Reference to the specific donor report in which this indicator result was included. Enables traceability from report to source data.',
    `field_team_id` BIGINT COMMENT 'Foreign key linking to field.field_team. Business justification: Indicator results are collected by specific field teams. MEL data quality management requires knowing which field team collected each result, enabling team-level data quality audits and accountability',
    `indicator_id` BIGINT COMMENT 'Reference to the indicator definition from the indicator library. Links this result to the specific KPI or outcome measure being tracked.',
    `indicator_target_id` BIGINT COMMENT 'Foreign key linking to mel.indicator_target. Business justification: Indicator results measure actual achievement against specific planned targets. Each indicator_result should reference the indicator_target it is measuring against. This creates proper traceability fro',
    `intervention_id` BIGINT COMMENT 'Reference to the program under which this indicator result was achieved. Enables program-level performance aggregation.',
    `logframe_row_id` BIGINT COMMENT 'Foreign key linking to program.logframe_row. Business justification: Indicator results are reported against specific logframe rows (output/outcome/impact level) — the core NGO logframe performance reporting mechanism. Linking indicator_result to logframe_row enables lo',
    `partner_org_id` BIGINT COMMENT 'Reference to the implementing partner organization that collected or contributed this indicator result. Used for partner performance tracking.',
    `partner_report_submission_id` BIGINT COMMENT 'Foreign key linking to partnership.partner_report_submission. Business justification: Partner reports contain indicator results as core content. Business need: report completeness verification, results validation, donor reporting compilation.',
    `project_site_id` BIGINT COMMENT 'Reference to the geographic project site where this result was achieved. Enables location-based performance analysis.',
    `reporting_period_id` BIGINT COMMENT 'Foreign key linking to mel.reporting_period. Business justification: indicator_result currently stores reporting_period_start_date and reporting_period_end_date as raw DATE columns rather than referencing the master reporting_period table. This is a normalization gap —',
    `stock_movement_id` BIGINT COMMENT 'Foreign key linking to supply.stock_movement. Business justification: Individual stock movements (commodity distributions to beneficiaries) directly generate indicator results (e.g., beneficiaries reached, metric tons distributed). This FK enables MEL officers to tr',
    `baseline_value` DECIMAL(18,2) COMMENT 'Baseline measurement recorded at program start. Enables calculation of change over time and impact assessment.',
    `beneficiary_count` STRING COMMENT 'Number of unique beneficiaries reached or served in achieving this indicator result. Critical for reach and coverage analysis.',
    `collection_date` DATE COMMENT 'Date when the indicator data was physically collected in the field or extracted from source systems. Distinct from reporting period dates.',
    `contributing_factors` STRING COMMENT 'Description of key factors that contributed to achievement or non-achievement of the indicator target. Supports learning and adaptive management.',
    `corrective_actions` STRING COMMENT 'Documented corrective actions planned or taken in response to under-performance. Part of adaptive management and continuous improvement.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this indicator result record was first created in the system. Part of audit trail.',
    `cumulative_result` DECIMAL(18,2) COMMENT 'Cumulative total of indicator results from program start through current reporting period. Used for life-of-project performance tracking.',
    `data_collection_method` STRING COMMENT 'Method used to collect the indicator data. Includes surveys, Focus Group Discussions (FGD), Key Informant Interviews (KII), Post-Distribution Monitoring (PDM), and administrative records. [ENUM-REF-CANDIDATE: survey|fgd|kii|observation|administrative_records|pdm|mobile_data_collection|remote_sensing — 8 candidates stripped; promote to reference product]',
    `data_quality_notes` STRING COMMENT 'Free-text notes documenting data quality issues, limitations, or contextual factors affecting the reliability of this indicator result.',
    `data_quality_score` DECIMAL(18,2) COMMENT 'Composite data quality score (0.00 to 1.00) assessing completeness, accuracy, timeliness, and consistency of the indicator result per MEAL standards.',
    `data_source` STRING COMMENT 'Specific source system or document from which the indicator data was extracted. Examples include DHIS2, KoboToolbox, beneficiary registration system, or partner reports.',
    `disaggregation_age_group` STRING COMMENT 'Age group disaggregation of the indicator result. Enables age-sensitive analysis and compliance with Sustainable Development Goal (SDG) reporting.. Valid values are `0-5|6-17|18-59|60+|not_applicable`',
    `disaggregation_disability` STRING COMMENT 'Disability status disaggregation per Washington Group Short Set. Required for inclusive programming and disability-focused donor reporting.. Valid values are `with_disability|without_disability|unknown|not_applicable`',
    `disaggregation_displacement_status` STRING COMMENT 'Displacement status disaggregation. Distinguishes Internally Displaced Persons (IDP), refugees, returnees, and host community members per UNHCR standards.. Valid values are `idp|refugee|returnee|host_community|not_applicable`',
    `disaggregation_sex` STRING COMMENT 'Sex disaggregation of the indicator result. Required by most donors for gender-sensitive programming and reporting.. Valid values are `male|female|other|unknown|not_applicable`',
    `evidence_file_path` STRING COMMENT 'File path or document reference to supporting evidence for this indicator result. Includes photos, survey data files, or verification reports.',
    `geographic_level` STRING COMMENT 'Administrative level at which this indicator result was measured. Enables hierarchical geographic aggregation and sub-national analysis.. Valid values are `national|regional|district|community|facility`',
    `household_count` STRING COMMENT 'Number of unique households reached in achieving this indicator result. Used when household is the unit of analysis.',
    `indicator_level` STRING COMMENT 'Level of the indicator in the results chain per Theory of Change (ToC). Distinguishes between immediate outputs, medium-term outcomes, and long-term impact.. Valid values are `output|outcome|impact|process`',
    `indicator_result_status` STRING COMMENT 'Current workflow status of the indicator result record. Tracks approval and review lifecycle.. Valid values are `draft|submitted|approved|rejected|archived`',
    `is_milestone` BOOLEAN COMMENT 'Indicates whether this indicator result represents a contractual milestone or critical deliverable per grant agreement terms.',
    `last_modified_by` STRING COMMENT 'User identifier of the person who last modified this indicator result record. Supports accountability and audit trail.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this indicator result record was last updated. Tracks data currency and change history.',
    `narrative_description` STRING COMMENT 'Qualitative narrative describing the context, achievements, challenges, and lessons learned related to this indicator result. Used in donor reports.',
    `reported_to_donor` BOOLEAN COMMENT 'Indicates whether this indicator result has been included in formal donor reporting. Tracks reporting compliance and audit trail.',
    `target_value` DECIMAL(18,2) COMMENT 'Planned target value for the indicator during this reporting period. Used for variance analysis and performance assessment.',
    `unit_of_measure` STRING COMMENT 'Unit in which the indicator result is measured. Critical for correct interpretation and aggregation of performance data. [ENUM-REF-CANDIDATE: number|percentage|ratio|count|households|individuals|facilities|days|hours|liters|kilograms|metric_tons — 12 candidates stripped; promote to reference product]',
    `value` DECIMAL(18,2) COMMENT 'Actual achieved value recorded for the indicator during the reporting period. The primary quantitative outcome measurement.',
    `variance_from_target` DECIMAL(18,2) COMMENT 'Calculated difference between actual result and target value. Positive values indicate over-achievement, negative values indicate under-achievement.',
    `variance_percentage` DECIMAL(18,2) COMMENT 'Percentage variance from target, calculated as (actual - target) / target * 100. Key metric for donor performance reporting.',
    `verification_date` DATE COMMENT 'Date when the indicator result was verified by MEL staff or external evaluators. Critical for audit trail and data quality documentation.',
    `verification_status` STRING COMMENT 'Current verification state of the indicator result. Tracks data quality assurance workflow per Core Humanitarian Standard (CHS) requirements.. Valid values are `unverified|verified|rejected|pending_review`',
    `verified_by` STRING COMMENT 'Name or identifier of the MEL officer or evaluator who verified this indicator result. Supports accountability and quality assurance.',
    CONSTRAINT pk_indicator_result PRIMARY KEY(`indicator_result_id`)
) COMMENT 'Actual achieved values recorded against indicator targets for a given reporting period, program, and geographic unit. Captures reported value, disaggregation breakdowns (sex, age, disability, location), data source, collection method, verification status, variance from target, and outcome-level change measurements (KAB changes, condition improvements). Covers all indicator levels from output through outcome and impact. Core transactional record for MEL performance tracking, donor reporting, and ToC validation.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`mel`.`meal_plan` (
    `meal_plan_id` BIGINT COMMENT 'Unique identifier for the MEAL plan document. Primary key for the MEAL plan entity.',
    `agreement_id` BIGINT COMMENT 'Foreign key linking to partnership.partnership_agreement. Business justification: MEAL plans are agreement-specific deliverables and annexes. Business need: agreement compliance tracking, donor reporting obligation fulfillment, partnership performance framework definition.',
    `award_id` BIGINT COMMENT 'Reference to the grant or award that funds this MEAL plan. Links the MEAL plan to the funding source and donor reporting requirements.',
    `budget_plan_id` BIGINT COMMENT 'Foreign key linking to program.budget_plan. Business justification: MEL budget reconciliation requires linking meal_plan.budget_allocated to source program.budget_plan for variance analysis, donor reporting, and financial compliance. Real business process: quarterly M',
    `capacity_assessment_id` BIGINT COMMENT 'Foreign key linking to partnership.capacity_assessment. Business justification: MEAL plans are calibrated to partner capacity assessment scores — low-scoring partners require enhanced monitoring provisions in the MEAL plan. NGO MEL teams reference the specific capacity assessment',
    `component_id` BIGINT COMMENT 'Foreign key linking to program.component. Business justification: MEAL plans are scoped to specific program components in multi-component grants where each component has distinct M&E requirements. Component-level MEAL planning is standard NGO practice for donor comp',
    `consortium_id` BIGINT COMMENT 'Foreign key linking to partnership.consortium. Business justification: Consortium programs require a shared MEAL plan covering all member activities. NGO MEL coordinators develop consortium-level MEAL frameworks that govern joint monitoring, shared indicators, and pooled',
    `country_office_id` BIGINT COMMENT 'Foreign key linking to field.country_office. Business justification: MEAL plans are developed and owned at the country office level. Country-level MEAL planning, budget allocation, and donor reporting require knowing which country office owns each MEAL plan. Default PK',
    `implementation_plan_id` BIGINT COMMENT 'Foreign key linking to program.implementation_plan. Business justification: MEAL plans are developed alongside implementation plans — the MEAL plan defines how the implementation plan will be monitored. Linking them enables integrated program management and ensures M&E resour',
    `intervention_id` BIGINT COMMENT 'Reference to the program or project that this MEAL plan governs. Links the MEAL plan to the operational program it monitors.',
    `mel_logframe_id` BIGINT COMMENT 'Foreign key linking to mel.mel_logframe. Business justification: MEAL plans implement specific logframes. Currently meal_plan has logframe_reference (STRING) which should be replaced with a proper FK to mel_logframe. This establishes the authoritative link between ',
    `program_id` BIGINT COMMENT 'Foreign key linking to program.program. Business justification: MEAL plans are created at program level covering all interventions and components. Program-level MEAL planning is standard for multi-year NGO programs. Currently meal_plan links to intervention but no',
    `project_site_id` BIGINT COMMENT 'Foreign key linking to field.project_site. Business justification: MEL plans define data collection, monitoring, and evaluation activities requiring budget allocation (surveys, tools, staff time, external evaluators). Annual budgeting process allocates funds for MEL ',
    `accountability_mechanisms` STRING COMMENT 'Description of accountability mechanisms embedded in the MEAL plan, including beneficiary feedback channels, complaint response mechanisms, and Core Humanitarian Standard (CHS) commitments.',
    `approval_date` DATE COMMENT 'Date when the MEAL plan was formally approved by program management and/or the donor. Marks the transition from draft to active status.',
    `baseline_completion_date` DATE COMMENT 'Date when the baseline assessment was completed. Baseline data provides the starting point for measuring program outcomes and impact.',
    `beneficiary_feedback_channels` STRING COMMENT 'Description of channels through which beneficiaries can provide feedback, complaints, and suggestions, including hotlines, suggestion boxes, community meetings, and digital platforms.',
    `budget_allocated` DECIMAL(18,2) COMMENT 'Total budget allocated for implementing this MEAL plan, including costs for data collection, evaluation, staff time, tools, and analysis.',
    `chs_commitment_alignment` STRING COMMENT 'Description of how this MEAL plan aligns with and monitors the nine Core Humanitarian Standard commitments to communities and people affected by crisis.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this MEAL plan record was first created in the system. Used for audit trail and data lineage.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the budget allocated amount (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `dac_criteria_coverage` STRING COMMENT 'Description of which DAC evaluation criteria (relevance, coherence, effectiveness, efficiency, impact, sustainability) are addressed in this MEAL plan and how they will be assessed.',
    `data_collection_methods` STRING COMMENT 'Enumeration and description of data collection methods to be used, including surveys, Key Informant Interviews (KII), Focus Group Discussions (FGD), Post-Distribution Monitoring (PDM), and direct observation.',
    `data_collection_tools` STRING COMMENT 'List of digital and paper-based tools and platforms to be used for data collection, such as KoboToolbox, CommCare, ODK, DHIS2, mobile data collection apps, and paper forms.',
    `data_disaggregation_plan` STRING COMMENT 'Description of how data will be disaggregated for analysis, including by age, gender, disability status, geographic location, and other relevant demographic and vulnerability factors.',
    `data_management_protocols` STRING COMMENT 'Description of data management protocols, including data storage, security, privacy, access controls, backup procedures, and compliance with data protection regulations.',
    `data_quality_protocols` STRING COMMENT 'Description of data quality assurance and quality control protocols, including validation rules, data cleaning procedures, inter-rater reliability checks, and data verification processes.',
    `donor_reporting_requirements` STRING COMMENT 'Description of specific donor reporting requirements that this MEAL plan must satisfy, including report formats, indicators, frequency, and submission deadlines.',
    `effective_end_date` DATE COMMENT 'Date when this MEAL plan ends and monitoring activities conclude. Typically aligns with program end date or grant closeout date.',
    `effective_start_date` DATE COMMENT 'Date when this MEAL plan becomes effective and monitoring activities begin. Typically aligns with program start date or grant award date.',
    `endline_planned_date` DATE COMMENT 'Planned date for the endline evaluation. Endline evaluations measure final outcomes and impact at the conclusion of the program cycle.',
    `ethical_considerations` STRING COMMENT 'Description of ethical considerations and safeguards in data collection and evaluation, including informed consent procedures, do-no-harm principles, and protection of vulnerable populations.',
    `evaluation_strategy` STRING COMMENT 'Description of the evaluation strategy, including planned evaluations (baseline, midline, endline), evaluation questions, methodologies, and timing aligned with DAC criteria.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this MEAL plan record was last modified in the system. Used for audit trail and change tracking.',
    `learning_agenda` STRING COMMENT 'Description of the learning agenda, including key learning questions, knowledge management activities, and how learning will be captured and disseminated to inform adaptive management.',
    `meal_plan_status` STRING COMMENT 'Current lifecycle status of the MEAL plan. Indicates whether the plan is in development, approved for use, actively being implemented, or closed. [ENUM-REF-CANDIDATE: draft|under_review|approved|active|suspended|closed|archived — 7 candidates stripped; promote to reference product]',
    `mel_team_members` STRING COMMENT 'Comma-separated list or description of MEL team members and their roles in implementing the MEAL plan, including data collectors, analysts, and coordinators.',
    `midline_planned_date` DATE COMMENT 'Planned date for the midline evaluation. Midline evaluations assess progress toward outcomes at the midpoint of the program cycle.',
    `monitoring_strategy` STRING COMMENT 'Comprehensive description of the monitoring strategy, including frequency, methods, data sources, and responsible parties for ongoing program monitoring.',
    `rbm_framework_alignment` STRING COMMENT 'Description of how this MEAL plan aligns with the organizations Results-Based Management framework and donor RBM requirements.',
    `reporting_calendar` STRING COMMENT 'Description of the reporting calendar, including frequency and timing of internal reports, donor reports, Situation Reports (SitRep), and other MEL deliverables.',
    `revision_history` STRING COMMENT 'Summary of major revisions and amendments to the MEAL plan over its lifecycle, including dates and reasons for changes.',
    `risk_mitigation_plan` STRING COMMENT 'Description of risks to MEL implementation (e.g., access constraints, security incidents, data quality issues) and mitigation strategies.',
    `sdg_alignment` STRING COMMENT 'Description of which Sustainable Development Goals and targets this MEAL plan monitors and how program indicators align with SDG indicators.',
    `title` STRING COMMENT 'The official title or name of the MEAL plan document. Used for identification and reference in donor reports and internal documentation.',
    `toc_narrative` STRING COMMENT 'Narrative description of the Theory of Change that underpins this MEAL plan. Explains the causal pathway from inputs to impact and the assumptions being tested.',
    `version` STRING COMMENT 'Version number or identifier for this iteration of the MEAL plan. Tracks revisions and updates to the plan over the program lifecycle.',
    CONSTRAINT pk_meal_plan PRIMARY KEY(`meal_plan_id`)
) COMMENT 'MEAL (Monitoring, Evaluation, Accountability, and Learning) plan document for a program or grant cycle. Defines the overall monitoring strategy, indicator matrix, data collection schedule and methods, responsible MEL staff, tools to be used (KoboToolbox, CommCare, ODK, DHIS2), learning agenda linkage, accountability mechanisms (CHS commitments, feedback channels), reporting calendar, and data management protocols. Serves as the governing MEL framework document that all other MEL products operationalize.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`mel`.`evaluation` (
    `evaluation_id` BIGINT COMMENT 'Unique identifier for the evaluation record. Primary key.',
    `agreement_id` BIGINT COMMENT 'Foreign key linking to partnership.partnership_agreement. Business justification: Evaluations triggered by agreement milestones or donor requirements. Business need: agreement performance assessment, renewal decision support, donor reporting compliance.',
    `award_id` BIGINT COMMENT 'Reference to the grant funding this evaluation, if applicable.',
    `capacity_assessment_id` BIGINT COMMENT 'Foreign key linking to partnership.capacity_assessment. Business justification: Evaluations frequently reference the partner capacity assessment as baseline evidence for organizational effectiveness findings. NGO evaluation teams explicitly cite capacity assessment scores in eval',
    `component_id` BIGINT COMMENT 'Foreign key linking to program.component. Business justification: Evaluations are frequently scoped to a specific program component (e.g., mid-term evaluation of the livelihoods component). Component-level evaluations are standard in multi-component NGO programs for',
    `consortium_id` BIGINT COMMENT 'Foreign key linking to partnership.consortium. Business justification: Consortium-level evaluations are standard in multi-partner humanitarian programs. NGO evaluation teams commission joint evaluations covering all consortium members and must link the evaluation record ',
    `country_office_id` BIGINT COMMENT 'Foreign key linking to field.country_office. Business justification: Evaluations are commissioned and managed by country offices. Country office performance management, donor accountability, and organizational learning require linking evaluations to the commissioning c',
    `distribution_plan_id` BIGINT COMMENT 'Foreign key linking to supply.distribution_plan. Business justification: Evaluations in supply-heavy NGO programs formally assess specific distribution plans (efficiency, effectiveness, coverage). A direct FK allows evaluators to scope the evaluation to a named distributio',
    `implementation_plan_id` BIGINT COMMENT 'Foreign key linking to program.implementation_plan. Business justification: Evaluations assess whether specific implementation plans were executed as designed. Mid-term and end-line evaluations reference the implementation plan to assess activity delivery against planned mile',
    `intervention_id` BIGINT COMMENT 'Reference to the program being evaluated.',
    `meal_plan_id` BIGINT COMMENT 'Foreign key linking to mel.meal_plan. Business justification: Evaluations (baseline, midterm, endline) are planned and executed as part of MEAL plans. This FK links the evaluation to the MEAL plan under which it was conducted, enabling tracking of MEAL plan eval',
    `mel_logframe_id` BIGINT COMMENT 'Foreign key linking to mel.mel_logframe. Business justification: Evaluations assess program performance against the logframes results chain. This FK links the evaluation to the specific logframe being assessed, enabling analysis of achievement against planned resu',
    `partner_org_id` BIGINT COMMENT 'Foreign key linking to partnership.partner_org. Business justification: Evaluations routinely assess partner performance, capacity, and implementation quality. Business need: partner performance evaluation, due diligence validation, partnership renewal decisions, capacity',
    `partner_report_submission_id` BIGINT COMMENT 'Foreign key linking to partnership.partner_report_submission. Business justification: Evaluation reports are a type of partner report submission. Business need: evaluation deliverable tracking, donor reporting, agreement compliance verification.',
    `program_id` BIGINT COMMENT 'Foreign key linking to program.program. Business justification: Program-level end-line and mid-term evaluations are a core NGO accountability mechanism spanning multiple interventions. Evaluations must link to the program they assess for program performance manage',
    `project_site_id` BIGINT COMMENT 'Foreign key linking to field.project_site. Business justification: Evaluations are budgeted activities with dedicated allocations. Finance tracks evaluation costs (consultants, travel, data collection) against approved evaluation budget. Procurement requisitions for ',
    `reporting_period_id` BIGINT COMMENT 'Foreign key linking to mel.reporting_period. Business justification: evaluation has planned_start_date, planned_end_date, actual_start_date, and actual_end_date as evaluation-specific date fields, but no FK to the master reporting_period table. Evaluations (baseline, m',
    `partner_performance_review_id` BIGINT COMMENT 'Foreign key linking to partnership.partner_performance_review. Business justification: Evaluations are frequently commissioned in direct response to poor partner performance review outcomes. NGO program quality teams document which performance review triggered a specific evaluation for ',
    `actual_cost` DECIMAL(18,2) COMMENT 'Actual total cost incurred for conducting the evaluation.',
    `actual_end_date` DATE COMMENT 'Actual date when the evaluation was completed and final report delivered.',
    `actual_start_date` DATE COMMENT 'Actual date when the evaluation fieldwork or data collection commenced.',
    `beneficiary_sample_size` STRING COMMENT 'Number of beneficiaries or respondents included in the evaluation sample for primary data collection.',
    `budget_amount` DECIMAL(18,2) COMMENT 'Total budget allocated for conducting the evaluation, including consultant fees, travel, data collection, and report production costs.',
    `evaluation_code` STRING COMMENT 'Externally-known unique code or reference number for the evaluation, used in donor reports and internal tracking.. Valid values are `^[A-Z0-9]{6,20}$`',
    `coherence_rating` STRING COMMENT 'Rating of the programs coherence (compatibility with other interventions, internal consistency) per DAC criteria (2019 revision).. Valid values are `highly_satisfactory|satisfactory|moderately_satisfactory|moderately_unsatisfactory|unsatisfactory|highly_unsatisfactory`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the evaluation record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for budget and cost amounts (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `dac_criteria_assessed` STRING COMMENT 'Comma-separated list of DAC evaluation criteria assessed: relevance, coherence, effectiveness, efficiency, impact, sustainability. May include all or a subset depending on evaluation design.',
    `data_collection_methods` STRING COMMENT 'Comma-separated list of data collection methods used: household surveys, FGD (Focus Group Discussion), KII (Key Informant Interview), PDM (Post-Distribution Monitoring), direct observation, secondary data review, etc.',
    `dissemination_date` DATE COMMENT 'Date when the evaluation findings were formally disseminated to stakeholders, donors, and internal teams.',
    `effectiveness_rating` STRING COMMENT 'Rating of the programs effectiveness (extent to which objectives were achieved) per DAC criteria.. Valid values are `highly_satisfactory|satisfactory|moderately_satisfactory|moderately_unsatisfactory|unsatisfactory|highly_unsatisfactory`',
    `efficiency_rating` STRING COMMENT 'Rating of the programs efficiency (value for money, resource utilization) per DAC criteria.. Valid values are `highly_satisfactory|satisfactory|moderately_satisfactory|moderately_unsatisfactory|unsatisfactory|highly_unsatisfactory`',
    `ethics_approval_obtained` BOOLEAN COMMENT 'Indicates whether ethics approval or institutional review board clearance was obtained for the evaluation, particularly for studies involving vulnerable populations (true/false).',
    `evaluation_status` STRING COMMENT 'Current lifecycle status of the evaluation: planned (scheduled but not started), inception (terms of reference development), fieldwork (data collection in progress), analysis (data analysis phase), draft_report (draft under review), final_report (completed), disseminated (findings shared with stakeholders), or cancelled. [ENUM-REF-CANDIDATE: planned|inception|fieldwork|analysis|draft_report|final_report|disseminated|cancelled — 8 candidates stripped; promote to reference product]',
    `evaluation_type` STRING COMMENT 'Type of evaluation conducted: baseline (pre-intervention), midterm (mid-cycle), endline (post-intervention), impact (long-term outcomes), formative (process improvement), summative (final judgment), or real-time (during crisis). [ENUM-REF-CANDIDATE: baseline|midterm|endline|impact|formative|summative|real-time — 7 candidates stripped; promote to reference product]',
    `evaluator_type` STRING COMMENT 'Type of evaluator conducting the assessment: internal (staff-led), external (independent consultant or firm), joint (internal and external collaboration), or participatory (beneficiary-led).. Valid values are `internal|external|joint|participatory`',
    `findings_summary` STRING COMMENT 'Executive summary of key evaluation findings, including strengths, weaknesses, and evidence against DAC criteria.',
    `geographic_coverage` STRING COMMENT 'Geographic areas covered by the evaluation, including countries, regions, districts, or project sites. Comma-separated list or descriptive text.',
    `impact_rating` STRING COMMENT 'Rating of the programs impact (long-term changes and contribution to higher-level goals) per DAC criteria.. Valid values are `highly_satisfactory|satisfactory|moderately_satisfactory|moderately_unsatisfactory|unsatisfactory|highly_unsatisfactory`',
    `lead_evaluator_name` STRING COMMENT 'Name of the lead evaluator or evaluation firm responsible for conducting the evaluation.',
    `lessons_learned` STRING COMMENT 'Key lessons learned from the evaluation that can inform future program design, implementation, and organizational learning.',
    `management_response_date` DATE COMMENT 'Date when the management response to evaluation recommendations was formally completed and approved.',
    `management_response_status` STRING COMMENT 'Status of the management response to evaluation recommendations: pending (not yet started), in_progress (being drafted), completed (response finalized and action plan developed), or not_required.. Valid values are `pending|in_progress|completed|not_required`',
    `methodology` STRING COMMENT 'Description of the evaluation methodology, including data collection methods (surveys, FGD, KII, PDM, secondary data review), sampling approach, analytical techniques, and any limitations.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the evaluation record was last modified.',
    `overall_rating` STRING COMMENT 'Overall performance rating assigned by the evaluation, typically on a six-point scale aligned with donor standards (e.g., USAID, DFID).. Valid values are `highly_satisfactory|satisfactory|moderately_satisfactory|moderately_unsatisfactory|unsatisfactory|highly_unsatisfactory`',
    `planned_end_date` DATE COMMENT 'Planned date when the evaluation is scheduled to be completed and final report delivered.',
    `planned_start_date` DATE COMMENT 'Planned date when the evaluation fieldwork or data collection is scheduled to begin.',
    `purpose` STRING COMMENT 'Primary purpose of the evaluation: accountability (donor reporting), learning (organizational improvement), decision_making (strategic planning), or compliance (regulatory requirement).. Valid values are `accountability|learning|decision_making|compliance`',
    `quality_assurance_conducted` BOOLEAN COMMENT 'Indicates whether independent quality assurance review of the evaluation was conducted (true/false).',
    `recommendations_summary` STRING COMMENT 'Summary of actionable recommendations arising from the evaluation, including strategic, operational, and programmatic improvements.',
    `relevance_rating` STRING COMMENT 'Rating of the programs relevance (alignment with beneficiary needs, country priorities, and organizational strategy) per DAC criteria.. Valid values are `highly_satisfactory|satisfactory|moderately_satisfactory|moderately_unsatisfactory|unsatisfactory|highly_unsatisfactory`',
    `report_url` STRING COMMENT 'URL or file path to the final evaluation report document, stored in document management system or public repository.',
    `scope` STRING COMMENT 'Detailed description of the evaluation scope, including geographic coverage, beneficiary segments, program components, and time period covered.',
    `sustainability_rating` STRING COMMENT 'Rating of the programs sustainability (likelihood that benefits will continue after program closure) per DAC criteria.. Valid values are `highly_satisfactory|satisfactory|moderately_satisfactory|moderately_unsatisfactory|unsatisfactory|highly_unsatisfactory`',
    `team_size` STRING COMMENT 'Number of evaluators or team members involved in conducting the evaluation.',
    `title` STRING COMMENT 'Full descriptive title of the evaluation.',
    CONSTRAINT pk_evaluation PRIMARY KEY(`evaluation_id`)
) COMMENT 'Formal evaluation records including baseline, midterm, endline, and impact evaluations. Captures evaluation type (formative, summative, real-time), DAC criteria assessed (relevance, coherence, effectiveness, efficiency, impact, sustainability), methodology, evaluator (internal/external), scope, findings summary, and recommendations. Supports organizational learning and donor accountability.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`mel`.`evaluation_finding` (
    `evaluation_finding_id` BIGINT COMMENT 'Unique identifier for the evaluation finding record. Primary key.',
    `award_id` BIGINT COMMENT 'Reference to the grant or award that this finding pertains to, if applicable.',
    `capacity_assessment_id` BIGINT COMMENT 'Foreign key linking to partnership.capacity_building_plan. Business justification: Evaluation findings trigger capacity building activities. Business need: corrective action planning, capacity gap closure, finding remediation tracking.',
    `component_id` BIGINT COMMENT 'Foreign key linking to program.component. Business justification: Evaluation findings are attributed to specific program components for component-level learning and management response tracking. Component managers need findings relevant to their component for correc',
    `evaluation_id` BIGINT COMMENT 'Reference to the parent evaluation from which this finding was extracted.',
    `intervention_id` BIGINT COMMENT 'Reference to the program or project that this finding pertains to.',
    `logframe_row_id` BIGINT COMMENT 'Foreign key linking to program.logframe_row. Business justification: Evaluation findings are mapped to specific logframe rows to assess achievement against planned results. Standard NGO evaluation practice — findings reference the logframe row they assess, enabling log',
    `partner_org_id` BIGINT COMMENT 'Foreign key linking to partnership.partner_org. Business justification: Findings identify partner-specific issues requiring corrective action. Business need: partner accountability tracking, corrective action planning, performance review evidence, risk management escalati',
    `partner_performance_review_id` BIGINT COMMENT 'Foreign key linking to partnership.partner_performance_review. Business justification: Evaluation findings inform performance review ratings and corrective actions. Business need: performance review evidence, improvement plan development, rating justification.',
    `project_site_id` BIGINT COMMENT 'Foreign key linking to field.project_site. Business justification: Evaluation findings are often site-specific, identifying performance issues or good practices at particular project sites. Site-level corrective action tracking and management responses require linkin',
    `action_plan` STRING COMMENT 'Detailed plan outlining the steps, resources, and timeline for implementing the recommendation.',
    `actual_completion_date` DATE COMMENT 'Actual date when the recommendation was fully implemented or the issue was resolved.',
    `beneficiary_category` STRING COMMENT 'Category or segment of beneficiaries affected by or relevant to this finding (e.g., IDP, refugee, host community, women, children).',
    `closure_notes` STRING COMMENT 'Final notes or comments documenting the closure or resolution of this finding or recommendation.',
    `confidentiality_level` STRING COMMENT 'Data classification level for this finding: public, internal, confidential, or restricted.. Valid values are `public|internal|confidential|restricted`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this evaluation finding record was first created in the system.',
    `cross_cutting_theme` STRING COMMENT 'Cross-cutting themes addressed by this finding (e.g., gender equality, disability inclusion, environmental sustainability, accountability).',
    `dac_criterion` STRING COMMENT 'The DAC evaluation criterion this finding relates to: relevance, coherence, effectiveness, efficiency, impact, or sustainability.. Valid values are `relevance|coherence|effectiveness|efficiency|impact|sustainability`',
    `data_collection_method` STRING COMMENT 'Primary method(s) used to collect evidence for this finding (e.g., Focus Group Discussion, Key Informant Interview, survey, document review, observation).',
    `donor_visibility_flag` BOOLEAN COMMENT 'Indicates whether this finding should be included in donor-facing reports and communications (True/False).',
    `evaluation_finding_date` DATE COMMENT 'Date when the finding was formally documented or recorded in the evaluation report.',
    `evaluation_finding_type` STRING COMMENT 'Classification of the evaluation output: finding (observation), conclusion (interpretation), recommendation (action), lesson learned, or good practice.. Valid values are `finding|conclusion|recommendation|lesson_learned|good_practice`',
    `evaluator_name` STRING COMMENT 'Name of the lead evaluator or evaluation team member who documented this finding.',
    `evidence_base` STRING COMMENT 'Summary of the data sources and evidence that support this finding (e.g., FGD results, KII transcripts, PDM data, program records).',
    `geographic_scope` STRING COMMENT 'Geographic area or location(s) to which this finding applies (country, region, field office, project site).',
    `implementation_progress_percentage` DECIMAL(18,2) COMMENT 'Percentage completion of the recommendation implementation (0.00 to 100.00).',
    `implementation_status` STRING COMMENT 'Current status of the recommendation or corrective action: not started, in progress, partially implemented, fully implemented, closed, or rejected.. Valid values are `not_started|in_progress|partially_implemented|fully_implemented|closed|rejected`',
    `last_review_date` DATE COMMENT 'Date when the implementation status of this finding was last reviewed or updated.',
    `management_response` STRING COMMENT 'Official response from management regarding acceptance, rejection, or modification of the recommendation.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this evaluation finding record was last modified or updated.',
    `next_review_date` DATE COMMENT 'Scheduled date for the next review or follow-up on this finding or recommendation.',
    `number` STRING COMMENT 'Sequential or hierarchical identifier for the finding within the evaluation report (e.g., F1, F2.1, Finding-03).',
    `priority_level` STRING COMMENT 'Urgency and importance assigned to the finding or recommendation: critical, high, medium, or low.. Valid values are `critical|high|medium|low`',
    `rating` STRING COMMENT 'Qualitative rating assigned to the finding where applicable, using standard evaluation rating scales.. Valid values are `highly_satisfactory|satisfactory|moderately_satisfactory|moderately_unsatisfactory|unsatisfactory|highly_unsatisfactory`',
    `responsible_unit` STRING COMMENT 'The organizational unit, department, or team responsible for addressing or implementing the recommendation.',
    `risk_implication` STRING COMMENT 'Description of risks or potential negative consequences if the finding or recommendation is not addressed.',
    `sdg_alignment` STRING COMMENT 'Sustainable Development Goal(s) that this finding relates to or impacts (e.g., SDG 1, SDG 3, SDG 5).',
    `sector` STRING COMMENT 'Humanitarian or development sector this finding relates to (e.g., WASH, health, education, protection, food security).',
    `statement` STRING COMMENT 'The full text of the finding, conclusion, or recommendation as documented in the evaluation report.',
    `target_completion_date` DATE COMMENT 'Planned or agreed date by which the recommendation should be implemented or the issue addressed.',
    CONSTRAINT pk_evaluation_finding PRIMARY KEY(`evaluation_finding_id`)
) COMMENT 'Individual findings, conclusions, and recommendations extracted from formal evaluations. Each record captures the finding statement, DAC criterion it relates to, evidence base, rating (if applicable), responsible unit for follow-up, and implementation status of the recommendation. Enables systematic learning and accountability tracking.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`mel`.`reporting_period` (
    `reporting_period_id` BIGINT COMMENT 'Primary key for reporting_period',
    `agreement_id` BIGINT COMMENT 'Foreign key linking to partnership.partnership_agreement. Business justification: Reporting periods are defined per partnership agreements donor-mandated reporting calendar. NGO grants managers align specific reporting periods to individual agreements for compliance tracking. repo',
    `component_id` BIGINT COMMENT 'Reference to the program or project for which this reporting period is defined. Links the period to specific humanitarian or development interventions.',
    `consortium_id` BIGINT COMMENT 'Foreign key linking to partnership.consortium. Business justification: Consortium programs operate on shared reporting calendars defined at the consortium level. NGO program coordinators manage consortium-wide reporting periods for joint submissions to lead donors. repor',
    `mel_logframe_id` BIGINT COMMENT 'Reference to the specific version of the Logical Framework (LogFrame) that is active during this reporting period. Ensures indicator targets and actuals are measured against the correct framework version.',
    `parent_reporting_period_id` BIGINT COMMENT 'Reference to a parent reporting period for hierarchical period structures (e.g., monthly periods rolling up to quarterly periods, quarterly to annual). Null for top-level periods.',
    `primary_prior_reporting_period_id` BIGINT COMMENT 'Self-referencing FK on reporting_period (prior_reporting_period_id)',
    `program_id` BIGINT COMMENT 'Foreign key linking to program.program. Business justification: Reporting periods are defined per program aligned to donor reporting calendars. Program-level reporting period management is essential for consolidated donor reporting. Currently reporting_period link',
    `baseline_period_flag` BOOLEAN COMMENT 'Indicates whether this reporting period represents a baseline measurement period for program indicators (True) or not (False). Baseline periods establish the starting point for impact measurement.',
    `calendar_year` STRING COMMENT 'The calendar year in which the reporting period falls, used for temporal analysis and trend reporting.',
    `closed_date` DATE COMMENT 'The date on which the reporting period was officially closed and locked for further data entry. Null if the period is still open or in draft status.',
    `reporting_period_code` STRING COMMENT 'Business identifier code for the reporting period, used in external communications and donor reports (e.g., Q1-2024, FY2024, JAN2024).',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this reporting period record was first created in the system. Used for audit trail and data lineage tracking.',
    `dac_criteria_focus` STRING COMMENT 'The primary DAC evaluation criteria focus for this period (e.g., Relevance, Effectiveness, Efficiency, Impact, Sustainability, Coherence). Multiple criteria may be listed as comma-separated values.',
    `data_collection_deadline` DATE COMMENT 'The deadline date by which all data collection activities for this reporting period must be completed. Used for MEL workflow management.',
    `data_quality_audit_flag` BOOLEAN COMMENT 'Indicates whether a data quality audit or verification exercise is scheduled for this reporting period (True) or not (False). Ensures data integrity and reliability.',
    `reporting_period_description` STRING COMMENT 'Detailed description of the reporting period, including any special characteristics, contextual information, or notes about data collection activities during this period.',
    `dhis2_period_code` STRING COMMENT 'The period identifier used in DHIS2 system for aggregate health data reporting. Enables integration with DHIS2 for health program monitoring.',
    `donor_reporting_cycle` STRING COMMENT 'The specific donor reporting cycle or phase that this period supports (e.g., Year 1 Q2, Mid-term Review, Final Report). Used to align with donor contractual obligations.',
    `duration_days` STRING COMMENT 'The total number of calendar days covered by this reporting period, calculated from start_date to end_date inclusive.',
    `end_date` DATE COMMENT 'The last date of the reporting period when data collection and monitoring activities conclude.',
    `endline_period_flag` BOOLEAN COMMENT 'Indicates whether this reporting period represents an endline measurement period for program indicators (True) or not (False). Endline periods capture final outcomes and impact.',
    `evaluation_type` STRING COMMENT 'The type of evaluation activity conducted during this reporting period, aligned with DAC evaluation criteria (formative, process, outcome, impact, ex-post, real-time). Null if no formal evaluation is scheduled.',
    `fgd_scheduled_flag` BOOLEAN COMMENT 'Indicates whether Focus Group Discussions (FGDs) are scheduled to be conducted during this reporting period (True) or not (False). Used for qualitative data collection planning.',
    `fiscal_year` STRING COMMENT 'The fiscal year to which this reporting period belongs (e.g., FY2024, FY2023-24). Used for budget alignment and annual donor reporting.',
    `is_active` BOOLEAN COMMENT 'Indicates whether this reporting period record is currently active and available for use (True) or has been soft-deleted/deactivated (False). Used for logical deletion without physical removal.',
    `kii_scheduled_flag` BOOLEAN COMMENT 'Indicates whether Key Informant Interviews (KIIs) are scheduled to be conducted during this reporting period (True) or not (False). Used for qualitative data collection planning.',
    `midline_period_flag` BOOLEAN COMMENT 'Indicates whether this reporting period represents a midline measurement period for program indicators (True) or not (False). Midline periods assess progress at the program midpoint.',
    `modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this reporting period record was last modified. Used for audit trail and change tracking.',
    `month_number` STRING COMMENT 'The month number (1-12) within the year, applicable for monthly reporting periods. Null for non-monthly periods.',
    `reporting_period_name` STRING COMMENT 'Human-readable name or label for the reporting period (e.g., First Quarter 2024, January 2024, Fiscal Year 2024).',
    `notes` STRING COMMENT 'Free-text field for additional notes, comments, or contextual information about the reporting period, including any anomalies, challenges, or special circumstances affecting data collection.',
    `pdm_cycle_flag` BOOLEAN COMMENT 'Indicates whether this reporting period includes a Post-Distribution Monitoring (PDM) cycle for assessing the effectiveness and impact of distributed aid (True) or not (False).',
    `quarter_number` STRING COMMENT 'The quarter number (1-4) within the fiscal or calendar year, applicable for quarterly reporting periods. Null for non-quarterly periods.',
    `report_submission_deadline` DATE COMMENT 'The deadline date by which the final report for this period must be submitted to donors or stakeholders. Critical for compliance with donor agreements.',
    `reporting_frequency` STRING COMMENT 'The frequency at which data is expected to be reported during this period, aligned with donor requirements and MEL framework schedules.',
    `reporting_period_status` STRING COMMENT 'Current lifecycle status of the reporting period (draft: not yet started, active: currently open for data collection, closed: finalized and locked, archived: historical record).',
    `reporting_period_type` STRING COMMENT 'Classification of the reporting period by its duration or frequency (daily, weekly, monthly, quarterly, semi-annual, annual, or custom).',
    `start_date` DATE COMMENT 'The first date of the reporting period when data collection and monitoring activities begin.',
    `week_number` STRING COMMENT 'The ISO week number (1-53) within the year, applicable for weekly reporting periods. Null for non-weekly periods.',
    CONSTRAINT pk_reporting_period PRIMARY KEY(`reporting_period_id`)
) COMMENT 'Master reference table for reporting_period. Referenced by reporting_period_id.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`mel`.`plan_indicator` (
    `plan_indicator_id` BIGINT COMMENT 'Primary key for the plan_indicator association',
    `indicator_id` BIGINT COMMENT 'Foreign key linking this assignment to the master indicator definition in the indicator library.',
    `meal_plan_id` BIGINT COMMENT 'Foreign key linking this indicator assignment to the governing MEAL plan document.',
    `data_collection_responsibility` STRING COMMENT 'The MEL staff role, team, or partner organisation responsible for collecting data for this indicator under this MEAL plan. Captures accountability at the plan-indicator level.',
    `inclusion_date` DATE COMMENT 'The date on which this indicator was formally added to the MEAL plans indicator matrix. Supports audit trail and plan version management.',
    `indicator_count` STRING COMMENT 'Total number of Key Performance Indicators (KPI) and monitoring indicators defined in the indicator matrix for this MEAL plan. [Moved from meal_plan: This integer count is a derived/denormalised field that exists because the structured M:N association was missing. Once plan_indicator is in place, the count of active indicators per plan is a simple aggregate query on plan_indicator. Retaining indicator_count creates a data integrity risk (count drifting out of sync with actual assignments).]',
    `is_active` BOOLEAN COMMENT 'Flag indicating whether this indicator assignment is currently active within the MEAL plan. Allows indicators to be deactivated mid-cycle without deleting the historical record.',
    `measurement_frequency_in_plan` STRING COMMENT 'How often this indicator is measured and reported within this specific MEAL plan. May differ from the indicator masters default data_collection_frequency when plan-specific reporting requirements apply.',
    `target_value_in_plan` DECIMAL(18,2) COMMENT 'The numeric target value set for this indicator within this specific MEAL plan. Distinct from the indicators baseline_value — this is the performance target the program commits to achieving under this plan.',
    CONSTRAINT pk_plan_indicator PRIMARY KEY(`plan_indicator_id`)
) COMMENT 'This association product represents the formal assignment of an indicator to a MEAL plan — the indicator matrix entry that governs how a specific indicator is monitored within a specific plan. Each record links one meal_plan to one indicator and captures the plan-specific target value, measurement frequency, data collection responsibility, and inclusion date. These attributes exist only in the context of this assignment: the same indicator may have different targets and frequencies across different MEAL plans.. Existence Justification: In NGO MEL practice, a MEAL plan formally assigns a specific set of indicators to monitor — this is the indicator matrix referenced in the meal_plan description. A single MEAL plan governs many indicators, and a single indicator (from the master library) can be included in multiple MEAL plans across different programs or grant cycles. The assignment of an indicator to a MEAL plan is a deliberate, managed business act with its own attributes: the target value set for that plan, the measurement frequency within that plan, who is responsible for data collection, and the date the indicator was included.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_ngo_v1`.`mel`.`mel_logframe` ADD CONSTRAINT `fk_mel_mel_logframe_indicator_id` FOREIGN KEY (`indicator_id`) REFERENCES `vibe_ngo_v1`.`mel`.`indicator`(`indicator_id`);
ALTER TABLE `vibe_ngo_v1`.`mel`.`mel_logframe` ADD CONSTRAINT `fk_mel_mel_logframe_parent_logframe_mel_logframe_id` FOREIGN KEY (`parent_logframe_mel_logframe_id`) REFERENCES `vibe_ngo_v1`.`mel`.`mel_logframe`(`mel_logframe_id`);
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator_target` ADD CONSTRAINT `fk_mel_indicator_target_indicator_id` FOREIGN KEY (`indicator_id`) REFERENCES `vibe_ngo_v1`.`mel`.`indicator`(`indicator_id`);
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator_target` ADD CONSTRAINT `fk_mel_indicator_target_mel_logframe_id` FOREIGN KEY (`mel_logframe_id`) REFERENCES `vibe_ngo_v1`.`mel`.`mel_logframe`(`mel_logframe_id`);
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator_target` ADD CONSTRAINT `fk_mel_indicator_target_reporting_period_id` FOREIGN KEY (`reporting_period_id`) REFERENCES `vibe_ngo_v1`.`mel`.`reporting_period`(`reporting_period_id`);
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator_result` ADD CONSTRAINT `fk_mel_indicator_result_indicator_id` FOREIGN KEY (`indicator_id`) REFERENCES `vibe_ngo_v1`.`mel`.`indicator`(`indicator_id`);
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator_result` ADD CONSTRAINT `fk_mel_indicator_result_indicator_target_id` FOREIGN KEY (`indicator_target_id`) REFERENCES `vibe_ngo_v1`.`mel`.`indicator_target`(`indicator_target_id`);
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator_result` ADD CONSTRAINT `fk_mel_indicator_result_reporting_period_id` FOREIGN KEY (`reporting_period_id`) REFERENCES `vibe_ngo_v1`.`mel`.`reporting_period`(`reporting_period_id`);
ALTER TABLE `vibe_ngo_v1`.`mel`.`meal_plan` ADD CONSTRAINT `fk_mel_meal_plan_mel_logframe_id` FOREIGN KEY (`mel_logframe_id`) REFERENCES `vibe_ngo_v1`.`mel`.`mel_logframe`(`mel_logframe_id`);
ALTER TABLE `vibe_ngo_v1`.`mel`.`evaluation` ADD CONSTRAINT `fk_mel_evaluation_meal_plan_id` FOREIGN KEY (`meal_plan_id`) REFERENCES `vibe_ngo_v1`.`mel`.`meal_plan`(`meal_plan_id`);
ALTER TABLE `vibe_ngo_v1`.`mel`.`evaluation` ADD CONSTRAINT `fk_mel_evaluation_mel_logframe_id` FOREIGN KEY (`mel_logframe_id`) REFERENCES `vibe_ngo_v1`.`mel`.`mel_logframe`(`mel_logframe_id`);
ALTER TABLE `vibe_ngo_v1`.`mel`.`evaluation` ADD CONSTRAINT `fk_mel_evaluation_reporting_period_id` FOREIGN KEY (`reporting_period_id`) REFERENCES `vibe_ngo_v1`.`mel`.`reporting_period`(`reporting_period_id`);
ALTER TABLE `vibe_ngo_v1`.`mel`.`evaluation_finding` ADD CONSTRAINT `fk_mel_evaluation_finding_evaluation_id` FOREIGN KEY (`evaluation_id`) REFERENCES `vibe_ngo_v1`.`mel`.`evaluation`(`evaluation_id`);
ALTER TABLE `vibe_ngo_v1`.`mel`.`reporting_period` ADD CONSTRAINT `fk_mel_reporting_period_mel_logframe_id` FOREIGN KEY (`mel_logframe_id`) REFERENCES `vibe_ngo_v1`.`mel`.`mel_logframe`(`mel_logframe_id`);
ALTER TABLE `vibe_ngo_v1`.`mel`.`reporting_period` ADD CONSTRAINT `fk_mel_reporting_period_parent_reporting_period_id` FOREIGN KEY (`parent_reporting_period_id`) REFERENCES `vibe_ngo_v1`.`mel`.`reporting_period`(`reporting_period_id`);
ALTER TABLE `vibe_ngo_v1`.`mel`.`reporting_period` ADD CONSTRAINT `fk_mel_reporting_period_primary_prior_reporting_period_id` FOREIGN KEY (`primary_prior_reporting_period_id`) REFERENCES `vibe_ngo_v1`.`mel`.`reporting_period`(`reporting_period_id`);
ALTER TABLE `vibe_ngo_v1`.`mel`.`plan_indicator` ADD CONSTRAINT `fk_mel_plan_indicator_indicator_id` FOREIGN KEY (`indicator_id`) REFERENCES `vibe_ngo_v1`.`mel`.`indicator`(`indicator_id`);
ALTER TABLE `vibe_ngo_v1`.`mel`.`plan_indicator` ADD CONSTRAINT `fk_mel_plan_indicator_meal_plan_id` FOREIGN KEY (`meal_plan_id`) REFERENCES `vibe_ngo_v1`.`mel`.`meal_plan`(`meal_plan_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_ngo_v1`.`mel` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `vibe_ngo_v1`.`mel` SET TAGS ('dbx_domain' = 'mel');
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator` SET TAGS ('dbx_subdomain' = 'indicator_management');
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator` ALTER COLUMN `indicator_id` SET TAGS ('dbx_business_glossary_term' = 'Indicator ID');
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Partnership Agreement Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator` ALTER COLUMN `award_id` SET TAGS ('dbx_business_glossary_term' = 'Grant ID');
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator` ALTER COLUMN `component_id` SET TAGS ('dbx_business_glossary_term' = 'Component Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator` ALTER COLUMN `consortium_id` SET TAGS ('dbx_business_glossary_term' = 'Consortium Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator` ALTER COLUMN `intervention_id` SET TAGS ('dbx_business_glossary_term' = 'Program ID');
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator` ALTER COLUMN `partner_org_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Org Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator` ALTER COLUMN `program_id` SET TAGS ('dbx_business_glossary_term' = 'Program Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator` ALTER COLUMN `baseline_date` SET TAGS ('dbx_business_glossary_term' = 'Baseline Date');
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator` ALTER COLUMN `baseline_value` SET TAGS ('dbx_business_glossary_term' = 'Baseline Value');
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator` ALTER COLUMN `calculation_method` SET TAGS ('dbx_business_glossary_term' = 'Calculation Method');
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator` ALTER COLUMN `indicator_category` SET TAGS ('dbx_business_glossary_term' = 'Indicator Category');
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator` ALTER COLUMN `indicator_category` SET TAGS ('dbx_value_regex' = 'quantitative|qualitative|composite');
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator` ALTER COLUMN `indicator_code` SET TAGS ('dbx_business_glossary_term' = 'Indicator Code');
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator` ALTER COLUMN `indicator_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{3,20}$');
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator` ALTER COLUMN `dac_criteria_alignment` SET TAGS ('dbx_business_glossary_term' = 'Development Assistance Committee (DAC) Criteria Alignment');
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator` ALTER COLUMN `data_collection_frequency` SET TAGS ('dbx_business_glossary_term' = 'Data Collection Frequency');
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator` ALTER COLUMN `data_collection_method` SET TAGS ('dbx_business_glossary_term' = 'Data Collection Method');
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator` ALTER COLUMN `data_source` SET TAGS ('dbx_business_glossary_term' = 'Data Source');
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator` ALTER COLUMN `definition` SET TAGS ('dbx_business_glossary_term' = 'Indicator Definition');
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator` ALTER COLUMN `denominator_description` SET TAGS ('dbx_business_glossary_term' = 'Denominator Description');
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator` ALTER COLUMN `dhis2_indicator_code` SET TAGS ('dbx_business_glossary_term' = 'DHIS2 Indicator ID');
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator` ALTER COLUMN `direction_of_change` SET TAGS ('dbx_business_glossary_term' = 'Direction of Change');
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator` ALTER COLUMN `direction_of_change` SET TAGS ('dbx_value_regex' = 'increase|decrease|maintain|not-applicable');
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator` ALTER COLUMN `disaggregation_dimensions` SET TAGS ('dbx_business_glossary_term' = 'Disaggregation Dimensions');
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator` ALTER COLUMN `indicator_status` SET TAGS ('dbx_business_glossary_term' = 'Indicator Status');
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator` ALTER COLUMN `indicator_status` SET TAGS ('dbx_value_regex' = 'active|inactive|draft|archived|under-review');
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator` ALTER COLUMN `indicator_type` SET TAGS ('dbx_business_glossary_term' = 'Indicator Type');
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator` ALTER COLUMN `indicator_type` SET TAGS ('dbx_value_regex' = 'output|outcome|impact|process|input');
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator` ALTER COLUMN `is_custom` SET TAGS ('dbx_business_glossary_term' = 'Is Custom Indicator');
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator` ALTER COLUMN `is_mandatory` SET TAGS ('dbx_business_glossary_term' = 'Is Mandatory Indicator');
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator` ALTER COLUMN `logframe_level` SET TAGS ('dbx_business_glossary_term' = 'Logical Framework (LogFrame) Level');
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator` ALTER COLUMN `logframe_level` SET TAGS ('dbx_value_regex' = 'goal|purpose|output|activity');
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator` ALTER COLUMN `indicator_name` SET TAGS ('dbx_business_glossary_term' = 'Indicator Name');
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator` ALTER COLUMN `indicator_name` SET TAGS ('dbx_pii_personal' = 'true');
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Indicator Notes');
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator` ALTER COLUMN `numerator_description` SET TAGS ('dbx_business_glossary_term' = 'Numerator Description');
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator` ALTER COLUMN `reporting_frequency` SET TAGS ('dbx_business_glossary_term' = 'Reporting Frequency');
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator` ALTER COLUMN `reporting_frequency` SET TAGS ('dbx_value_regex' = 'monthly|quarterly|semi-annually|annually|ad-hoc');
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator` ALTER COLUMN `responsible_role` SET TAGS ('dbx_business_glossary_term' = 'Responsible Role');
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator` ALTER COLUMN `sdg_alignment` SET TAGS ('dbx_business_glossary_term' = 'Sustainable Development Goal (SDG) Alignment');
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator` ALTER COLUMN `sector` SET TAGS ('dbx_business_glossary_term' = 'Sector');
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator` ALTER COLUMN `target_date` SET TAGS ('dbx_business_glossary_term' = 'Target Date');
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator` ALTER COLUMN `target_value` SET TAGS ('dbx_business_glossary_term' = 'Target Value');
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator` ALTER COLUMN `theme` SET TAGS ('dbx_business_glossary_term' = 'Theme');
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator` ALTER COLUMN `verification_method` SET TAGS ('dbx_business_glossary_term' = 'Verification Method');
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator` ALTER COLUMN `version_number` SET TAGS ('dbx_value_regex' = '^[0-9]+.[0-9]+$');
ALTER TABLE `vibe_ngo_v1`.`mel`.`mel_logframe` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_ngo_v1`.`mel`.`mel_logframe` SET TAGS ('dbx_subdomain' = 'program_planning');
ALTER TABLE `vibe_ngo_v1`.`mel`.`mel_logframe` ALTER COLUMN `mel_logframe_id` SET TAGS ('dbx_business_glossary_term' = 'Monitoring Evaluation and Learning (MEL) Logical Framework (LogFrame) ID');
ALTER TABLE `vibe_ngo_v1`.`mel`.`mel_logframe` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Partnership Agreement Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`mel`.`mel_logframe` ALTER COLUMN `component_id` SET TAGS ('dbx_business_glossary_term' = 'Component Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`mel`.`mel_logframe` ALTER COLUMN `consortium_id` SET TAGS ('dbx_business_glossary_term' = 'Consortium Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`mel`.`mel_logframe` ALTER COLUMN `award_id` SET TAGS ('dbx_business_glossary_term' = 'Grant Award ID');
ALTER TABLE `vibe_ngo_v1`.`mel`.`mel_logframe` ALTER COLUMN `indicator_id` SET TAGS ('dbx_business_glossary_term' = 'Indicator Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`mel`.`mel_logframe` ALTER COLUMN `intervention_id` SET TAGS ('dbx_business_glossary_term' = 'Program ID');
ALTER TABLE `vibe_ngo_v1`.`mel`.`mel_logframe` ALTER COLUMN `parent_logframe_mel_logframe_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Logical Framework (LogFrame) ID');
ALTER TABLE `vibe_ngo_v1`.`mel`.`mel_logframe` ALTER COLUMN `partner_org_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Org Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`mel`.`mel_logframe` ALTER COLUMN `program_id` SET TAGS ('dbx_business_glossary_term' = 'Program Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`mel`.`mel_logframe` ALTER COLUMN `actual_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Date');
ALTER TABLE `vibe_ngo_v1`.`mel`.`mel_logframe` ALTER COLUMN `actual_value` SET TAGS ('dbx_business_glossary_term' = 'Actual Value');
ALTER TABLE `vibe_ngo_v1`.`mel`.`mel_logframe` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `vibe_ngo_v1`.`mel`.`mel_logframe` ALTER COLUMN `approved_date` SET TAGS ('dbx_business_glossary_term' = 'Approved Date');
ALTER TABLE `vibe_ngo_v1`.`mel`.`mel_logframe` ALTER COLUMN `assumptions` SET TAGS ('dbx_business_glossary_term' = 'Assumptions');
ALTER TABLE `vibe_ngo_v1`.`mel`.`mel_logframe` ALTER COLUMN `baseline_date` SET TAGS ('dbx_business_glossary_term' = 'Baseline Date');
ALTER TABLE `vibe_ngo_v1`.`mel`.`mel_logframe` ALTER COLUMN `baseline_value` SET TAGS ('dbx_business_glossary_term' = 'Baseline Value');
ALTER TABLE `vibe_ngo_v1`.`mel`.`mel_logframe` ALTER COLUMN `mel_logframe_code` SET TAGS ('dbx_business_glossary_term' = 'Logical Framework (LogFrame) Code');
ALTER TABLE `vibe_ngo_v1`.`mel`.`mel_logframe` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_ngo_v1`.`mel`.`mel_logframe` ALTER COLUMN `dac_evaluation_criterion` SET TAGS ('dbx_business_glossary_term' = 'Development Assistance Committee (DAC) Evaluation Criterion');
ALTER TABLE `vibe_ngo_v1`.`mel`.`mel_logframe` ALTER COLUMN `dac_evaluation_criterion` SET TAGS ('dbx_value_regex' = 'Relevance|Coherence|Effectiveness|Efficiency|Impact|Sustainability');
ALTER TABLE `vibe_ngo_v1`.`mel`.`mel_logframe` ALTER COLUMN `data_collection_method` SET TAGS ('dbx_business_glossary_term' = 'Data Collection Method');
ALTER TABLE `vibe_ngo_v1`.`mel`.`mel_logframe` ALTER COLUMN `disaggregation_dimensions` SET TAGS ('dbx_business_glossary_term' = 'Disaggregation Dimensions');
ALTER TABLE `vibe_ngo_v1`.`mel`.`mel_logframe` ALTER COLUMN `donor_template_type` SET TAGS ('dbx_business_glossary_term' = 'Donor Template Type');
ALTER TABLE `vibe_ngo_v1`.`mel`.`mel_logframe` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_ngo_v1`.`mel`.`mel_logframe` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_ngo_v1`.`mel`.`mel_logframe` ALTER COLUMN `hierarchy_sequence` SET TAGS ('dbx_business_glossary_term' = 'Hierarchy Sequence Number');
ALTER TABLE `vibe_ngo_v1`.`mel`.`mel_logframe` ALTER COLUMN `intervention_statement` SET TAGS ('dbx_business_glossary_term' = 'Intervention Statement');
ALTER TABLE `vibe_ngo_v1`.`mel`.`mel_logframe` ALTER COLUMN `is_custom_indicator` SET TAGS ('dbx_business_glossary_term' = 'Is Custom Indicator Flag');
ALTER TABLE `vibe_ngo_v1`.`mel`.`mel_logframe` ALTER COLUMN `is_mandatory_donor_indicator` SET TAGS ('dbx_business_glossary_term' = 'Is Mandatory Donor Indicator Flag');
ALTER TABLE `vibe_ngo_v1`.`mel`.`mel_logframe` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_ngo_v1`.`mel`.`mel_logframe` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `vibe_ngo_v1`.`mel`.`mel_logframe` ALTER COLUMN `means_of_verification` SET TAGS ('dbx_business_glossary_term' = 'Means of Verification (MoV)');
ALTER TABLE `vibe_ngo_v1`.`mel`.`mel_logframe` ALTER COLUMN `mel_logframe_status` SET TAGS ('dbx_business_glossary_term' = 'Logical Framework (LogFrame) Status');
ALTER TABLE `vibe_ngo_v1`.`mel`.`mel_logframe` ALTER COLUMN `mel_logframe_name` SET TAGS ('dbx_business_glossary_term' = 'Logical Framework (LogFrame) Name');
ALTER TABLE `vibe_ngo_v1`.`mel`.`mel_logframe` ALTER COLUMN `mel_logframe_name` SET TAGS ('dbx_pii_personal' = 'true');
ALTER TABLE `vibe_ngo_v1`.`mel`.`mel_logframe` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `vibe_ngo_v1`.`mel`.`mel_logframe` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_ngo_v1`.`mel`.`mel_logframe` ALTER COLUMN `reporting_frequency` SET TAGS ('dbx_business_glossary_term' = 'Reporting Frequency');
ALTER TABLE `vibe_ngo_v1`.`mel`.`mel_logframe` ALTER COLUMN `reporting_frequency` SET TAGS ('dbx_value_regex' = 'Monthly|Quarterly|Semi-Annual|Annual|Ad-Hoc|Milestone-Based');
ALTER TABLE `vibe_ngo_v1`.`mel`.`mel_logframe` ALTER COLUMN `responsible_party` SET TAGS ('dbx_business_glossary_term' = 'Responsible Party');
ALTER TABLE `vibe_ngo_v1`.`mel`.`mel_logframe` ALTER COLUMN `results_chain_level` SET TAGS ('dbx_business_glossary_term' = 'Results Chain Level');
ALTER TABLE `vibe_ngo_v1`.`mel`.`mel_logframe` ALTER COLUMN `risks` SET TAGS ('dbx_business_glossary_term' = 'Risks');
ALTER TABLE `vibe_ngo_v1`.`mel`.`mel_logframe` ALTER COLUMN `sdg_alignment` SET TAGS ('dbx_business_glossary_term' = 'Sustainable Development Goal (SDG) Alignment');
ALTER TABLE `vibe_ngo_v1`.`mel`.`mel_logframe` ALTER COLUMN `target_date` SET TAGS ('dbx_business_glossary_term' = 'Target Date');
ALTER TABLE `vibe_ngo_v1`.`mel`.`mel_logframe` ALTER COLUMN `target_value` SET TAGS ('dbx_business_glossary_term' = 'Target Value');
ALTER TABLE `vibe_ngo_v1`.`mel`.`mel_logframe` ALTER COLUMN `theory_of_change_component` SET TAGS ('dbx_business_glossary_term' = 'Theory of Change (ToC) Component');
ALTER TABLE `vibe_ngo_v1`.`mel`.`mel_logframe` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `vibe_ngo_v1`.`mel`.`mel_logframe` ALTER COLUMN `version` SET TAGS ('dbx_business_glossary_term' = 'Logical Framework (LogFrame) Version');
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator_target` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator_target` SET TAGS ('dbx_subdomain' = 'indicator_management');
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator_target` ALTER COLUMN `indicator_target_id` SET TAGS ('dbx_business_glossary_term' = 'Indicator Target ID');
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator_target` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Partnership Agreement Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator_target` ALTER COLUMN `award_id` SET TAGS ('dbx_business_glossary_term' = 'Grant ID');
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator_target` ALTER COLUMN `component_id` SET TAGS ('dbx_business_glossary_term' = 'Component Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator_target` ALTER COLUMN `indicator_id` SET TAGS ('dbx_business_glossary_term' = 'Indicator ID');
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator_target` ALTER COLUMN `intervention_id` SET TAGS ('dbx_business_glossary_term' = 'Program ID');
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator_target` ALTER COLUMN `logframe_row_id` SET TAGS ('dbx_business_glossary_term' = 'Logframe Row Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator_target` ALTER COLUMN `mel_logframe_id` SET TAGS ('dbx_business_glossary_term' = 'Mel Logframe Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator_target` ALTER COLUMN `partner_org_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Org Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator_target` ALTER COLUMN `project_site_id` SET TAGS ('dbx_business_glossary_term' = 'Project Site Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator_target` ALTER COLUMN `reporting_period_id` SET TAGS ('dbx_business_glossary_term' = 'Reporting Period ID');
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator_target` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator_target` ALTER COLUMN `assumptions` SET TAGS ('dbx_business_glossary_term' = 'Assumptions');
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator_target` ALTER COLUMN `baseline_date` SET TAGS ('dbx_business_glossary_term' = 'Baseline Date');
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator_target` ALTER COLUMN `baseline_value` SET TAGS ('dbx_business_glossary_term' = 'Baseline Value');
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator_target` ALTER COLUMN `indicator_target_code` SET TAGS ('dbx_business_glossary_term' = 'Target Code');
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator_target` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator_target` ALTER COLUMN `dac_sector_code` SET TAGS ('dbx_business_glossary_term' = 'Development Assistance Committee (DAC) Sector Code');
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator_target` ALTER COLUMN `data_collection_method` SET TAGS ('dbx_business_glossary_term' = 'Data Collection Method');
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator_target` ALTER COLUMN `indicator_target_description` SET TAGS ('dbx_business_glossary_term' = 'Target Description');
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator_target` ALTER COLUMN `disaggregation_age_group` SET TAGS ('dbx_business_glossary_term' = 'Disaggregation by Age Group');
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator_target` ALTER COLUMN `disaggregation_age_group` SET TAGS ('dbx_pii_demographic' = 'true');
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator_target` ALTER COLUMN `disaggregation_disability_status` SET TAGS ('dbx_business_glossary_term' = 'Disaggregation by Disability Status');
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator_target` ALTER COLUMN `disaggregation_disability_status` SET TAGS ('dbx_value_regex' = 'with_disability|without_disability|not_specified');
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator_target` ALTER COLUMN `disaggregation_disability_status` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator_target` ALTER COLUMN `disaggregation_disability_status` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator_target` ALTER COLUMN `disaggregation_displacement_status` SET TAGS ('dbx_business_glossary_term' = 'Disaggregation by Displacement Status');
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator_target` ALTER COLUMN `disaggregation_sex` SET TAGS ('dbx_business_glossary_term' = 'Disaggregation by Sex');
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator_target` ALTER COLUMN `disaggregation_sex` SET TAGS ('dbx_value_regex' = 'male|female|other|not_specified');
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator_target` ALTER COLUMN `disaggregation_sex` SET TAGS ('dbx_pii_demographic' = 'true');
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator_target` ALTER COLUMN `donor_reporting_requirement` SET TAGS ('dbx_business_glossary_term' = 'Donor Reporting Requirement');
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator_target` ALTER COLUMN `indicator_target_date` SET TAGS ('dbx_business_glossary_term' = 'Target Date');
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator_target` ALTER COLUMN `indicator_target_status` SET TAGS ('dbx_business_glossary_term' = 'Target Status');
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator_target` ALTER COLUMN `indicator_target_type` SET TAGS ('dbx_business_glossary_term' = 'Target Type');
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator_target` ALTER COLUMN `indicator_target_type` SET TAGS ('dbx_value_regex' = 'output|outcome|impact|process|input');
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator_target` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator_target` ALTER COLUMN `measurement_frequency` SET TAGS ('dbx_business_glossary_term' = 'Measurement Frequency');
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator_target` ALTER COLUMN `mitigation_strategy` SET TAGS ('dbx_business_glossary_term' = 'Mitigation Strategy');
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator_target` ALTER COLUMN `indicator_target_name` SET TAGS ('dbx_business_glossary_term' = 'Target Name');
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator_target` ALTER COLUMN `indicator_target_name` SET TAGS ('dbx_pii_personal' = 'true');
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator_target` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator_target` ALTER COLUMN `revision_date` SET TAGS ('dbx_business_glossary_term' = 'Revision Date');
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator_target` ALTER COLUMN `revision_reason` SET TAGS ('dbx_business_glossary_term' = 'Revision Reason');
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator_target` ALTER COLUMN `risks` SET TAGS ('dbx_business_glossary_term' = 'Risks');
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator_target` ALTER COLUMN `sdg_alignment` SET TAGS ('dbx_business_glossary_term' = 'Sustainable Development Goal (SDG) Alignment');
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator_target` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator_target` ALTER COLUMN `value` SET TAGS ('dbx_business_glossary_term' = 'Target Value');
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator_target` ALTER COLUMN `verification_source` SET TAGS ('dbx_business_glossary_term' = 'Verification Source');
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator_result` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator_result` SET TAGS ('dbx_subdomain' = 'indicator_management');
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator_result` ALTER COLUMN `indicator_result_id` SET TAGS ('dbx_business_glossary_term' = 'Indicator Result ID');
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator_result` ALTER COLUMN `assessment_id` SET TAGS ('dbx_business_glossary_term' = 'Assessment Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator_result` ALTER COLUMN `award_id` SET TAGS ('dbx_business_glossary_term' = 'Award ID');
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator_result` ALTER COLUMN `commodity_id` SET TAGS ('dbx_business_glossary_term' = 'Commodity Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator_result` ALTER COLUMN `component_id` SET TAGS ('dbx_business_glossary_term' = 'Component Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator_result` ALTER COLUMN `distribution_event_id` SET TAGS ('dbx_business_glossary_term' = 'Distribution Event Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator_result` ALTER COLUMN `distribution_order_id` SET TAGS ('dbx_business_glossary_term' = 'Distribution Order Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator_result` ALTER COLUMN `distribution_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Distribution Plan Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator_result` ALTER COLUMN `donor_report_id` SET TAGS ('dbx_business_glossary_term' = 'Donor Report ID');
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator_result` ALTER COLUMN `field_team_id` SET TAGS ('dbx_business_glossary_term' = 'Field Team Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator_result` ALTER COLUMN `indicator_id` SET TAGS ('dbx_business_glossary_term' = 'Indicator ID');
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator_result` ALTER COLUMN `indicator_target_id` SET TAGS ('dbx_business_glossary_term' = 'Indicator Target Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator_result` ALTER COLUMN `intervention_id` SET TAGS ('dbx_business_glossary_term' = 'Program ID');
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator_result` ALTER COLUMN `logframe_row_id` SET TAGS ('dbx_business_glossary_term' = 'Logframe Row Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator_result` ALTER COLUMN `partner_org_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Organization ID');
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator_result` ALTER COLUMN `partner_report_submission_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Report Submission Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator_result` ALTER COLUMN `project_site_id` SET TAGS ('dbx_business_glossary_term' = 'Project Site ID');
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator_result` ALTER COLUMN `reporting_period_id` SET TAGS ('dbx_business_glossary_term' = 'Reporting Period Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator_result` ALTER COLUMN `stock_movement_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Movement Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator_result` ALTER COLUMN `baseline_value` SET TAGS ('dbx_business_glossary_term' = 'Baseline Value');
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator_result` ALTER COLUMN `beneficiary_count` SET TAGS ('dbx_business_glossary_term' = 'Beneficiary Count');
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator_result` ALTER COLUMN `collection_date` SET TAGS ('dbx_business_glossary_term' = 'Collection Date');
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator_result` ALTER COLUMN `contributing_factors` SET TAGS ('dbx_business_glossary_term' = 'Contributing Factors');
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator_result` ALTER COLUMN `corrective_actions` SET TAGS ('dbx_business_glossary_term' = 'Corrective Actions');
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator_result` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator_result` ALTER COLUMN `cumulative_result` SET TAGS ('dbx_business_glossary_term' = 'Cumulative Result');
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator_result` ALTER COLUMN `data_collection_method` SET TAGS ('dbx_business_glossary_term' = 'Data Collection Method');
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator_result` ALTER COLUMN `data_quality_notes` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Notes');
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator_result` ALTER COLUMN `data_quality_score` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator_result` ALTER COLUMN `data_source` SET TAGS ('dbx_business_glossary_term' = 'Data Source');
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator_result` ALTER COLUMN `disaggregation_age_group` SET TAGS ('dbx_business_glossary_term' = 'Disaggregation by Age Group');
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator_result` ALTER COLUMN `disaggregation_age_group` SET TAGS ('dbx_value_regex' = '0-5|6-17|18-59|60+|not_applicable');
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator_result` ALTER COLUMN `disaggregation_age_group` SET TAGS ('dbx_pii_demographic' = 'true');
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator_result` ALTER COLUMN `disaggregation_disability` SET TAGS ('dbx_business_glossary_term' = 'Disaggregation by Disability Status');
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator_result` ALTER COLUMN `disaggregation_disability` SET TAGS ('dbx_value_regex' = 'with_disability|without_disability|unknown|not_applicable');
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator_result` ALTER COLUMN `disaggregation_disability` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator_result` ALTER COLUMN `disaggregation_disability` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator_result` ALTER COLUMN `disaggregation_displacement_status` SET TAGS ('dbx_business_glossary_term' = 'Disaggregation by Displacement Status');
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator_result` ALTER COLUMN `disaggregation_displacement_status` SET TAGS ('dbx_value_regex' = 'idp|refugee|returnee|host_community|not_applicable');
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator_result` ALTER COLUMN `disaggregation_sex` SET TAGS ('dbx_business_glossary_term' = 'Disaggregation by Sex');
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator_result` ALTER COLUMN `disaggregation_sex` SET TAGS ('dbx_value_regex' = 'male|female|other|unknown|not_applicable');
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator_result` ALTER COLUMN `disaggregation_sex` SET TAGS ('dbx_pii_demographic' = 'true');
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator_result` ALTER COLUMN `evidence_file_path` SET TAGS ('dbx_business_glossary_term' = 'Evidence File Path');
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator_result` ALTER COLUMN `geographic_level` SET TAGS ('dbx_business_glossary_term' = 'Geographic Level');
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator_result` ALTER COLUMN `geographic_level` SET TAGS ('dbx_value_regex' = 'national|regional|district|community|facility');
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator_result` ALTER COLUMN `household_count` SET TAGS ('dbx_business_glossary_term' = 'Household Count');
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator_result` ALTER COLUMN `indicator_level` SET TAGS ('dbx_business_glossary_term' = 'Indicator Level');
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator_result` ALTER COLUMN `indicator_level` SET TAGS ('dbx_value_regex' = 'output|outcome|impact|process');
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator_result` ALTER COLUMN `indicator_result_status` SET TAGS ('dbx_business_glossary_term' = 'Result Status');
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator_result` ALTER COLUMN `indicator_result_status` SET TAGS ('dbx_value_regex' = 'draft|submitted|approved|rejected|archived');
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator_result` ALTER COLUMN `is_milestone` SET TAGS ('dbx_business_glossary_term' = 'Is Milestone Flag');
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator_result` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By');
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator_result` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator_result` ALTER COLUMN `narrative_description` SET TAGS ('dbx_business_glossary_term' = 'Narrative Description');
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator_result` ALTER COLUMN `reported_to_donor` SET TAGS ('dbx_business_glossary_term' = 'Reported to Donor Flag');
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator_result` ALTER COLUMN `target_value` SET TAGS ('dbx_business_glossary_term' = 'Target Value');
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator_result` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator_result` ALTER COLUMN `value` SET TAGS ('dbx_business_glossary_term' = 'Result Value');
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator_result` ALTER COLUMN `variance_from_target` SET TAGS ('dbx_business_glossary_term' = 'Variance from Target');
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator_result` ALTER COLUMN `variance_percentage` SET TAGS ('dbx_business_glossary_term' = 'Variance Percentage');
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator_result` ALTER COLUMN `variance_percentage` SET TAGS ('dbx_pii_demographic' = 'true');
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator_result` ALTER COLUMN `verification_date` SET TAGS ('dbx_business_glossary_term' = 'Verification Date');
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator_result` ALTER COLUMN `verification_status` SET TAGS ('dbx_business_glossary_term' = 'Verification Status');
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator_result` ALTER COLUMN `verification_status` SET TAGS ('dbx_value_regex' = 'unverified|verified|rejected|pending_review');
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator_result` ALTER COLUMN `verified_by` SET TAGS ('dbx_business_glossary_term' = 'Verified By');
ALTER TABLE `vibe_ngo_v1`.`mel`.`meal_plan` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_ngo_v1`.`mel`.`meal_plan` SET TAGS ('dbx_subdomain' = 'program_planning');
ALTER TABLE `vibe_ngo_v1`.`mel`.`meal_plan` ALTER COLUMN `meal_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Monitoring Evaluation Accountability and Learning (MEAL) Plan Identifier');
ALTER TABLE `vibe_ngo_v1`.`mel`.`meal_plan` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Partnership Agreement Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`mel`.`meal_plan` ALTER COLUMN `award_id` SET TAGS ('dbx_business_glossary_term' = 'Grant Identifier');
ALTER TABLE `vibe_ngo_v1`.`mel`.`meal_plan` ALTER COLUMN `budget_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Budget Plan Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`mel`.`meal_plan` ALTER COLUMN `capacity_assessment_id` SET TAGS ('dbx_business_glossary_term' = 'Capacity Assessment Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`mel`.`meal_plan` ALTER COLUMN `component_id` SET TAGS ('dbx_business_glossary_term' = 'Component Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`mel`.`meal_plan` ALTER COLUMN `consortium_id` SET TAGS ('dbx_business_glossary_term' = 'Consortium Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`mel`.`meal_plan` ALTER COLUMN `country_office_id` SET TAGS ('dbx_business_glossary_term' = 'Country Office Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`mel`.`meal_plan` ALTER COLUMN `implementation_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Implementation Plan Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`mel`.`meal_plan` ALTER COLUMN `intervention_id` SET TAGS ('dbx_business_glossary_term' = 'Program Identifier');
ALTER TABLE `vibe_ngo_v1`.`mel`.`meal_plan` ALTER COLUMN `mel_logframe_id` SET TAGS ('dbx_business_glossary_term' = 'Mel Logframe Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`mel`.`meal_plan` ALTER COLUMN `program_id` SET TAGS ('dbx_business_glossary_term' = 'Program Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`mel`.`meal_plan` ALTER COLUMN `project_site_id` SET TAGS ('dbx_business_glossary_term' = 'Budget Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`mel`.`meal_plan` ALTER COLUMN `accountability_mechanisms` SET TAGS ('dbx_business_glossary_term' = 'Accountability Mechanisms Description');
ALTER TABLE `vibe_ngo_v1`.`mel`.`meal_plan` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'MEAL Plan Approval Date');
ALTER TABLE `vibe_ngo_v1`.`mel`.`meal_plan` ALTER COLUMN `baseline_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Baseline Assessment Completion Date');
ALTER TABLE `vibe_ngo_v1`.`mel`.`meal_plan` ALTER COLUMN `beneficiary_feedback_channels` SET TAGS ('dbx_business_glossary_term' = 'Beneficiary Feedback Channels Description');
ALTER TABLE `vibe_ngo_v1`.`mel`.`meal_plan` ALTER COLUMN `budget_allocated` SET TAGS ('dbx_business_glossary_term' = 'MEAL Plan Budget Allocated Amount');
ALTER TABLE `vibe_ngo_v1`.`mel`.`meal_plan` ALTER COLUMN `budget_allocated` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`mel`.`meal_plan` ALTER COLUMN `chs_commitment_alignment` SET TAGS ('dbx_business_glossary_term' = 'Core Humanitarian Standard (CHS) Commitment Alignment');
ALTER TABLE `vibe_ngo_v1`.`mel`.`meal_plan` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_ngo_v1`.`mel`.`meal_plan` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `vibe_ngo_v1`.`mel`.`meal_plan` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_ngo_v1`.`mel`.`meal_plan` ALTER COLUMN `dac_criteria_coverage` SET TAGS ('dbx_business_glossary_term' = 'Development Assistance Committee (DAC) Criteria Coverage');
ALTER TABLE `vibe_ngo_v1`.`mel`.`meal_plan` ALTER COLUMN `dac_criteria_coverage` SET TAGS ('dbx_pii_demographic' = 'true');
ALTER TABLE `vibe_ngo_v1`.`mel`.`meal_plan` ALTER COLUMN `data_collection_methods` SET TAGS ('dbx_business_glossary_term' = 'Data Collection Methods');
ALTER TABLE `vibe_ngo_v1`.`mel`.`meal_plan` ALTER COLUMN `data_collection_tools` SET TAGS ('dbx_business_glossary_term' = 'Data Collection Tools and Platforms');
ALTER TABLE `vibe_ngo_v1`.`mel`.`meal_plan` ALTER COLUMN `data_disaggregation_plan` SET TAGS ('dbx_business_glossary_term' = 'Data Disaggregation Plan');
ALTER TABLE `vibe_ngo_v1`.`mel`.`meal_plan` ALTER COLUMN `data_management_protocols` SET TAGS ('dbx_business_glossary_term' = 'Data Management Protocols');
ALTER TABLE `vibe_ngo_v1`.`mel`.`meal_plan` ALTER COLUMN `data_management_protocols` SET TAGS ('dbx_pii_demographic' = 'true');
ALTER TABLE `vibe_ngo_v1`.`mel`.`meal_plan` ALTER COLUMN `data_quality_protocols` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Assurance Protocols');
ALTER TABLE `vibe_ngo_v1`.`mel`.`meal_plan` ALTER COLUMN `donor_reporting_requirements` SET TAGS ('dbx_business_glossary_term' = 'Donor Reporting Requirements Description');
ALTER TABLE `vibe_ngo_v1`.`mel`.`meal_plan` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'MEAL Plan Effective End Date');
ALTER TABLE `vibe_ngo_v1`.`mel`.`meal_plan` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'MEAL Plan Effective Start Date');
ALTER TABLE `vibe_ngo_v1`.`mel`.`meal_plan` ALTER COLUMN `endline_planned_date` SET TAGS ('dbx_business_glossary_term' = 'Endline Evaluation Planned Date');
ALTER TABLE `vibe_ngo_v1`.`mel`.`meal_plan` ALTER COLUMN `ethical_considerations` SET TAGS ('dbx_business_glossary_term' = 'Ethical Considerations and Safeguards');
ALTER TABLE `vibe_ngo_v1`.`mel`.`meal_plan` ALTER COLUMN `evaluation_strategy` SET TAGS ('dbx_business_glossary_term' = 'Evaluation Strategy Description');
ALTER TABLE `vibe_ngo_v1`.`mel`.`meal_plan` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `vibe_ngo_v1`.`mel`.`meal_plan` ALTER COLUMN `learning_agenda` SET TAGS ('dbx_business_glossary_term' = 'Learning Agenda Description');
ALTER TABLE `vibe_ngo_v1`.`mel`.`meal_plan` ALTER COLUMN `learning_agenda` SET TAGS ('dbx_pii_demographic' = 'true');
ALTER TABLE `vibe_ngo_v1`.`mel`.`meal_plan` ALTER COLUMN `meal_plan_status` SET TAGS ('dbx_business_glossary_term' = 'MEAL Plan Status');
ALTER TABLE `vibe_ngo_v1`.`mel`.`meal_plan` ALTER COLUMN `mel_team_members` SET TAGS ('dbx_business_glossary_term' = 'MEL Team Members List');
ALTER TABLE `vibe_ngo_v1`.`mel`.`meal_plan` ALTER COLUMN `midline_planned_date` SET TAGS ('dbx_business_glossary_term' = 'Midline Evaluation Planned Date');
ALTER TABLE `vibe_ngo_v1`.`mel`.`meal_plan` ALTER COLUMN `monitoring_strategy` SET TAGS ('dbx_business_glossary_term' = 'Monitoring Strategy Description');
ALTER TABLE `vibe_ngo_v1`.`mel`.`meal_plan` ALTER COLUMN `rbm_framework_alignment` SET TAGS ('dbx_business_glossary_term' = 'Results-Based Management (RBM) Framework Alignment');
ALTER TABLE `vibe_ngo_v1`.`mel`.`meal_plan` ALTER COLUMN `reporting_calendar` SET TAGS ('dbx_business_glossary_term' = 'Reporting Calendar Description');
ALTER TABLE `vibe_ngo_v1`.`mel`.`meal_plan` ALTER COLUMN `revision_history` SET TAGS ('dbx_business_glossary_term' = 'MEAL Plan Revision History');
ALTER TABLE `vibe_ngo_v1`.`mel`.`meal_plan` ALTER COLUMN `risk_mitigation_plan` SET TAGS ('dbx_business_glossary_term' = 'MEL Risk Mitigation Plan');
ALTER TABLE `vibe_ngo_v1`.`mel`.`meal_plan` ALTER COLUMN `sdg_alignment` SET TAGS ('dbx_business_glossary_term' = 'Sustainable Development Goal (SDG) Alignment');
ALTER TABLE `vibe_ngo_v1`.`mel`.`meal_plan` ALTER COLUMN `title` SET TAGS ('dbx_business_glossary_term' = 'MEAL Plan Title');
ALTER TABLE `vibe_ngo_v1`.`mel`.`meal_plan` ALTER COLUMN `toc_narrative` SET TAGS ('dbx_business_glossary_term' = 'Theory of Change (ToC) Narrative');
ALTER TABLE `vibe_ngo_v1`.`mel`.`meal_plan` ALTER COLUMN `version` SET TAGS ('dbx_business_glossary_term' = 'MEAL Plan Version Number');
ALTER TABLE `vibe_ngo_v1`.`mel`.`evaluation` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_ngo_v1`.`mel`.`evaluation` SET TAGS ('dbx_subdomain' = 'evaluation_findings');
ALTER TABLE `vibe_ngo_v1`.`mel`.`evaluation` ALTER COLUMN `evaluation_id` SET TAGS ('dbx_business_glossary_term' = 'Evaluation ID');
ALTER TABLE `vibe_ngo_v1`.`mel`.`evaluation` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Partnership Agreement Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`mel`.`evaluation` ALTER COLUMN `award_id` SET TAGS ('dbx_business_glossary_term' = 'Grant ID');
ALTER TABLE `vibe_ngo_v1`.`mel`.`evaluation` ALTER COLUMN `capacity_assessment_id` SET TAGS ('dbx_business_glossary_term' = 'Capacity Assessment Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`mel`.`evaluation` ALTER COLUMN `component_id` SET TAGS ('dbx_business_glossary_term' = 'Component Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`mel`.`evaluation` ALTER COLUMN `consortium_id` SET TAGS ('dbx_business_glossary_term' = 'Consortium Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`mel`.`evaluation` ALTER COLUMN `country_office_id` SET TAGS ('dbx_business_glossary_term' = 'Country Office Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`mel`.`evaluation` ALTER COLUMN `distribution_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Distribution Plan Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`mel`.`evaluation` ALTER COLUMN `implementation_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Implementation Plan Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`mel`.`evaluation` ALTER COLUMN `intervention_id` SET TAGS ('dbx_business_glossary_term' = 'Program ID');
ALTER TABLE `vibe_ngo_v1`.`mel`.`evaluation` ALTER COLUMN `meal_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Meal Plan Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`mel`.`evaluation` ALTER COLUMN `mel_logframe_id` SET TAGS ('dbx_business_glossary_term' = 'Mel Logframe Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`mel`.`evaluation` ALTER COLUMN `partner_org_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Org Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`mel`.`evaluation` ALTER COLUMN `partner_report_submission_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Report Submission Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`mel`.`evaluation` ALTER COLUMN `program_id` SET TAGS ('dbx_business_glossary_term' = 'Program Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`mel`.`evaluation` ALTER COLUMN `project_site_id` SET TAGS ('dbx_business_glossary_term' = 'Budget Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`mel`.`evaluation` ALTER COLUMN `reporting_period_id` SET TAGS ('dbx_business_glossary_term' = 'Reporting Period Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`mel`.`evaluation` ALTER COLUMN `partner_performance_review_id` SET TAGS ('dbx_business_glossary_term' = 'Triggering Partner Performance Review Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`mel`.`evaluation` ALTER COLUMN `actual_cost` SET TAGS ('dbx_business_glossary_term' = 'Actual Cost');
ALTER TABLE `vibe_ngo_v1`.`mel`.`evaluation` ALTER COLUMN `actual_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`mel`.`evaluation` ALTER COLUMN `actual_end_date` SET TAGS ('dbx_business_glossary_term' = 'Actual End Date');
ALTER TABLE `vibe_ngo_v1`.`mel`.`evaluation` ALTER COLUMN `actual_start_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Start Date');
ALTER TABLE `vibe_ngo_v1`.`mel`.`evaluation` ALTER COLUMN `beneficiary_sample_size` SET TAGS ('dbx_business_glossary_term' = 'Beneficiary Sample Size');
ALTER TABLE `vibe_ngo_v1`.`mel`.`evaluation` ALTER COLUMN `budget_amount` SET TAGS ('dbx_business_glossary_term' = 'Evaluation Budget Amount');
ALTER TABLE `vibe_ngo_v1`.`mel`.`evaluation` ALTER COLUMN `budget_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`mel`.`evaluation` ALTER COLUMN `evaluation_code` SET TAGS ('dbx_business_glossary_term' = 'Evaluation Code');
ALTER TABLE `vibe_ngo_v1`.`mel`.`evaluation` ALTER COLUMN `evaluation_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,20}$');
ALTER TABLE `vibe_ngo_v1`.`mel`.`evaluation` ALTER COLUMN `coherence_rating` SET TAGS ('dbx_business_glossary_term' = 'Coherence Rating');
ALTER TABLE `vibe_ngo_v1`.`mel`.`evaluation` ALTER COLUMN `coherence_rating` SET TAGS ('dbx_value_regex' = 'highly_satisfactory|satisfactory|moderately_satisfactory|moderately_unsatisfactory|unsatisfactory|highly_unsatisfactory');
ALTER TABLE `vibe_ngo_v1`.`mel`.`evaluation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_ngo_v1`.`mel`.`evaluation` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_ngo_v1`.`mel`.`evaluation` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_ngo_v1`.`mel`.`evaluation` ALTER COLUMN `dac_criteria_assessed` SET TAGS ('dbx_business_glossary_term' = 'Development Assistance Committee (DAC) Criteria Assessed');
ALTER TABLE `vibe_ngo_v1`.`mel`.`evaluation` ALTER COLUMN `data_collection_methods` SET TAGS ('dbx_business_glossary_term' = 'Data Collection Methods');
ALTER TABLE `vibe_ngo_v1`.`mel`.`evaluation` ALTER COLUMN `dissemination_date` SET TAGS ('dbx_business_glossary_term' = 'Dissemination Date');
ALTER TABLE `vibe_ngo_v1`.`mel`.`evaluation` ALTER COLUMN `effectiveness_rating` SET TAGS ('dbx_business_glossary_term' = 'Effectiveness Rating');
ALTER TABLE `vibe_ngo_v1`.`mel`.`evaluation` ALTER COLUMN `effectiveness_rating` SET TAGS ('dbx_value_regex' = 'highly_satisfactory|satisfactory|moderately_satisfactory|moderately_unsatisfactory|unsatisfactory|highly_unsatisfactory');
ALTER TABLE `vibe_ngo_v1`.`mel`.`evaluation` ALTER COLUMN `efficiency_rating` SET TAGS ('dbx_business_glossary_term' = 'Efficiency Rating');
ALTER TABLE `vibe_ngo_v1`.`mel`.`evaluation` ALTER COLUMN `efficiency_rating` SET TAGS ('dbx_value_regex' = 'highly_satisfactory|satisfactory|moderately_satisfactory|moderately_unsatisfactory|unsatisfactory|highly_unsatisfactory');
ALTER TABLE `vibe_ngo_v1`.`mel`.`evaluation` ALTER COLUMN `ethics_approval_obtained` SET TAGS ('dbx_business_glossary_term' = 'Ethics Approval Obtained');
ALTER TABLE `vibe_ngo_v1`.`mel`.`evaluation` ALTER COLUMN `evaluation_status` SET TAGS ('dbx_business_glossary_term' = 'Evaluation Status');
ALTER TABLE `vibe_ngo_v1`.`mel`.`evaluation` ALTER COLUMN `evaluation_type` SET TAGS ('dbx_business_glossary_term' = 'Evaluation Type');
ALTER TABLE `vibe_ngo_v1`.`mel`.`evaluation` ALTER COLUMN `evaluator_type` SET TAGS ('dbx_business_glossary_term' = 'Evaluator Type');
ALTER TABLE `vibe_ngo_v1`.`mel`.`evaluation` ALTER COLUMN `evaluator_type` SET TAGS ('dbx_value_regex' = 'internal|external|joint|participatory');
ALTER TABLE `vibe_ngo_v1`.`mel`.`evaluation` ALTER COLUMN `findings_summary` SET TAGS ('dbx_business_glossary_term' = 'Findings Summary');
ALTER TABLE `vibe_ngo_v1`.`mel`.`evaluation` ALTER COLUMN `geographic_coverage` SET TAGS ('dbx_business_glossary_term' = 'Geographic Coverage');
ALTER TABLE `vibe_ngo_v1`.`mel`.`evaluation` ALTER COLUMN `geographic_coverage` SET TAGS ('dbx_pii_demographic' = 'true');
ALTER TABLE `vibe_ngo_v1`.`mel`.`evaluation` ALTER COLUMN `impact_rating` SET TAGS ('dbx_business_glossary_term' = 'Impact Rating');
ALTER TABLE `vibe_ngo_v1`.`mel`.`evaluation` ALTER COLUMN `impact_rating` SET TAGS ('dbx_value_regex' = 'highly_satisfactory|satisfactory|moderately_satisfactory|moderately_unsatisfactory|unsatisfactory|highly_unsatisfactory');
ALTER TABLE `vibe_ngo_v1`.`mel`.`evaluation` ALTER COLUMN `lead_evaluator_name` SET TAGS ('dbx_business_glossary_term' = 'Lead Evaluator Name');
ALTER TABLE `vibe_ngo_v1`.`mel`.`evaluation` ALTER COLUMN `lead_evaluator_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`mel`.`evaluation` ALTER COLUMN `lead_evaluator_name` SET TAGS ('dbx_pii_personal' = 'true');
ALTER TABLE `vibe_ngo_v1`.`mel`.`evaluation` ALTER COLUMN `lessons_learned` SET TAGS ('dbx_business_glossary_term' = 'Lessons Learned');
ALTER TABLE `vibe_ngo_v1`.`mel`.`evaluation` ALTER COLUMN `management_response_date` SET TAGS ('dbx_business_glossary_term' = 'Management Response Date');
ALTER TABLE `vibe_ngo_v1`.`mel`.`evaluation` ALTER COLUMN `management_response_date` SET TAGS ('dbx_pii_demographic' = 'true');
ALTER TABLE `vibe_ngo_v1`.`mel`.`evaluation` ALTER COLUMN `management_response_status` SET TAGS ('dbx_business_glossary_term' = 'Management Response Status');
ALTER TABLE `vibe_ngo_v1`.`mel`.`evaluation` ALTER COLUMN `management_response_status` SET TAGS ('dbx_value_regex' = 'pending|in_progress|completed|not_required');
ALTER TABLE `vibe_ngo_v1`.`mel`.`evaluation` ALTER COLUMN `management_response_status` SET TAGS ('dbx_pii_demographic' = 'true');
ALTER TABLE `vibe_ngo_v1`.`mel`.`evaluation` ALTER COLUMN `methodology` SET TAGS ('dbx_business_glossary_term' = 'Evaluation Methodology');
ALTER TABLE `vibe_ngo_v1`.`mel`.`evaluation` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_ngo_v1`.`mel`.`evaluation` ALTER COLUMN `overall_rating` SET TAGS ('dbx_business_glossary_term' = 'Overall Rating');
ALTER TABLE `vibe_ngo_v1`.`mel`.`evaluation` ALTER COLUMN `overall_rating` SET TAGS ('dbx_value_regex' = 'highly_satisfactory|satisfactory|moderately_satisfactory|moderately_unsatisfactory|unsatisfactory|highly_unsatisfactory');
ALTER TABLE `vibe_ngo_v1`.`mel`.`evaluation` ALTER COLUMN `planned_end_date` SET TAGS ('dbx_business_glossary_term' = 'Planned End Date');
ALTER TABLE `vibe_ngo_v1`.`mel`.`evaluation` ALTER COLUMN `planned_start_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Start Date');
ALTER TABLE `vibe_ngo_v1`.`mel`.`evaluation` ALTER COLUMN `purpose` SET TAGS ('dbx_business_glossary_term' = 'Evaluation Purpose');
ALTER TABLE `vibe_ngo_v1`.`mel`.`evaluation` ALTER COLUMN `purpose` SET TAGS ('dbx_value_regex' = 'accountability|learning|decision_making|compliance');
ALTER TABLE `vibe_ngo_v1`.`mel`.`evaluation` ALTER COLUMN `quality_assurance_conducted` SET TAGS ('dbx_business_glossary_term' = 'Quality Assurance Conducted');
ALTER TABLE `vibe_ngo_v1`.`mel`.`evaluation` ALTER COLUMN `recommendations_summary` SET TAGS ('dbx_business_glossary_term' = 'Recommendations Summary');
ALTER TABLE `vibe_ngo_v1`.`mel`.`evaluation` ALTER COLUMN `relevance_rating` SET TAGS ('dbx_business_glossary_term' = 'Relevance Rating');
ALTER TABLE `vibe_ngo_v1`.`mel`.`evaluation` ALTER COLUMN `relevance_rating` SET TAGS ('dbx_value_regex' = 'highly_satisfactory|satisfactory|moderately_satisfactory|moderately_unsatisfactory|unsatisfactory|highly_unsatisfactory');
ALTER TABLE `vibe_ngo_v1`.`mel`.`evaluation` ALTER COLUMN `report_url` SET TAGS ('dbx_business_glossary_term' = 'Evaluation Report URL');
ALTER TABLE `vibe_ngo_v1`.`mel`.`evaluation` ALTER COLUMN `scope` SET TAGS ('dbx_business_glossary_term' = 'Evaluation Scope');
ALTER TABLE `vibe_ngo_v1`.`mel`.`evaluation` ALTER COLUMN `sustainability_rating` SET TAGS ('dbx_business_glossary_term' = 'Sustainability Rating');
ALTER TABLE `vibe_ngo_v1`.`mel`.`evaluation` ALTER COLUMN `sustainability_rating` SET TAGS ('dbx_value_regex' = 'highly_satisfactory|satisfactory|moderately_satisfactory|moderately_unsatisfactory|unsatisfactory|highly_unsatisfactory');
ALTER TABLE `vibe_ngo_v1`.`mel`.`evaluation` ALTER COLUMN `team_size` SET TAGS ('dbx_business_glossary_term' = 'Evaluation Team Size');
ALTER TABLE `vibe_ngo_v1`.`mel`.`evaluation` ALTER COLUMN `title` SET TAGS ('dbx_business_glossary_term' = 'Evaluation Title');
ALTER TABLE `vibe_ngo_v1`.`mel`.`evaluation_finding` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_ngo_v1`.`mel`.`evaluation_finding` SET TAGS ('dbx_subdomain' = 'evaluation_findings');
ALTER TABLE `vibe_ngo_v1`.`mel`.`evaluation_finding` ALTER COLUMN `evaluation_finding_id` SET TAGS ('dbx_business_glossary_term' = 'Evaluation Finding Identifier (ID)');
ALTER TABLE `vibe_ngo_v1`.`mel`.`evaluation_finding` ALTER COLUMN `award_id` SET TAGS ('dbx_business_glossary_term' = 'Affected Grant Identifier (ID)');
ALTER TABLE `vibe_ngo_v1`.`mel`.`evaluation_finding` ALTER COLUMN `capacity_assessment_id` SET TAGS ('dbx_business_glossary_term' = 'Capacity Building Plan Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`mel`.`evaluation_finding` ALTER COLUMN `component_id` SET TAGS ('dbx_business_glossary_term' = 'Component Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`mel`.`evaluation_finding` ALTER COLUMN `evaluation_id` SET TAGS ('dbx_business_glossary_term' = 'Evaluation Identifier (ID)');
ALTER TABLE `vibe_ngo_v1`.`mel`.`evaluation_finding` ALTER COLUMN `intervention_id` SET TAGS ('dbx_business_glossary_term' = 'Affected Program Identifier (ID)');
ALTER TABLE `vibe_ngo_v1`.`mel`.`evaluation_finding` ALTER COLUMN `logframe_row_id` SET TAGS ('dbx_business_glossary_term' = 'Logframe Row Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`mel`.`evaluation_finding` ALTER COLUMN `partner_org_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Org Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`mel`.`evaluation_finding` ALTER COLUMN `partner_performance_review_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Performance Review Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`mel`.`evaluation_finding` ALTER COLUMN `project_site_id` SET TAGS ('dbx_business_glossary_term' = 'Project Site Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`mel`.`evaluation_finding` ALTER COLUMN `action_plan` SET TAGS ('dbx_business_glossary_term' = 'Action Plan');
ALTER TABLE `vibe_ngo_v1`.`mel`.`evaluation_finding` ALTER COLUMN `actual_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Completion Date');
ALTER TABLE `vibe_ngo_v1`.`mel`.`evaluation_finding` ALTER COLUMN `beneficiary_category` SET TAGS ('dbx_business_glossary_term' = 'Beneficiary Category');
ALTER TABLE `vibe_ngo_v1`.`mel`.`evaluation_finding` ALTER COLUMN `closure_notes` SET TAGS ('dbx_business_glossary_term' = 'Closure Notes');
ALTER TABLE `vibe_ngo_v1`.`mel`.`evaluation_finding` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_business_glossary_term' = 'Confidentiality Level');
ALTER TABLE `vibe_ngo_v1`.`mel`.`evaluation_finding` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_value_regex' = 'public|internal|confidential|restricted');
ALTER TABLE `vibe_ngo_v1`.`mel`.`evaluation_finding` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_ngo_v1`.`mel`.`evaluation_finding` ALTER COLUMN `cross_cutting_theme` SET TAGS ('dbx_business_glossary_term' = 'Cross-Cutting Theme');
ALTER TABLE `vibe_ngo_v1`.`mel`.`evaluation_finding` ALTER COLUMN `dac_criterion` SET TAGS ('dbx_business_glossary_term' = 'Development Assistance Committee (DAC) Criterion');
ALTER TABLE `vibe_ngo_v1`.`mel`.`evaluation_finding` ALTER COLUMN `dac_criterion` SET TAGS ('dbx_value_regex' = 'relevance|coherence|effectiveness|efficiency|impact|sustainability');
ALTER TABLE `vibe_ngo_v1`.`mel`.`evaluation_finding` ALTER COLUMN `data_collection_method` SET TAGS ('dbx_business_glossary_term' = 'Data Collection Method');
ALTER TABLE `vibe_ngo_v1`.`mel`.`evaluation_finding` ALTER COLUMN `donor_visibility_flag` SET TAGS ('dbx_business_glossary_term' = 'Donor Visibility Flag');
ALTER TABLE `vibe_ngo_v1`.`mel`.`evaluation_finding` ALTER COLUMN `evaluation_finding_date` SET TAGS ('dbx_business_glossary_term' = 'Finding Date');
ALTER TABLE `vibe_ngo_v1`.`mel`.`evaluation_finding` ALTER COLUMN `evaluation_finding_type` SET TAGS ('dbx_business_glossary_term' = 'Finding Type');
ALTER TABLE `vibe_ngo_v1`.`mel`.`evaluation_finding` ALTER COLUMN `evaluation_finding_type` SET TAGS ('dbx_value_regex' = 'finding|conclusion|recommendation|lesson_learned|good_practice');
ALTER TABLE `vibe_ngo_v1`.`mel`.`evaluation_finding` ALTER COLUMN `evaluator_name` SET TAGS ('dbx_business_glossary_term' = 'Evaluator Name');
ALTER TABLE `vibe_ngo_v1`.`mel`.`evaluation_finding` ALTER COLUMN `evaluator_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`mel`.`evaluation_finding` ALTER COLUMN `evaluator_name` SET TAGS ('dbx_pii_personal' = 'true');
ALTER TABLE `vibe_ngo_v1`.`mel`.`evaluation_finding` ALTER COLUMN `evidence_base` SET TAGS ('dbx_business_glossary_term' = 'Evidence Base');
ALTER TABLE `vibe_ngo_v1`.`mel`.`evaluation_finding` ALTER COLUMN `geographic_scope` SET TAGS ('dbx_business_glossary_term' = 'Geographic Scope');
ALTER TABLE `vibe_ngo_v1`.`mel`.`evaluation_finding` ALTER COLUMN `implementation_progress_percentage` SET TAGS ('dbx_business_glossary_term' = 'Implementation Progress Percentage');
ALTER TABLE `vibe_ngo_v1`.`mel`.`evaluation_finding` ALTER COLUMN `implementation_progress_percentage` SET TAGS ('dbx_pii_demographic' = 'true');
ALTER TABLE `vibe_ngo_v1`.`mel`.`evaluation_finding` ALTER COLUMN `implementation_status` SET TAGS ('dbx_business_glossary_term' = 'Implementation Status');
ALTER TABLE `vibe_ngo_v1`.`mel`.`evaluation_finding` ALTER COLUMN `implementation_status` SET TAGS ('dbx_value_regex' = 'not_started|in_progress|partially_implemented|fully_implemented|closed|rejected');
ALTER TABLE `vibe_ngo_v1`.`mel`.`evaluation_finding` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `vibe_ngo_v1`.`mel`.`evaluation_finding` ALTER COLUMN `management_response` SET TAGS ('dbx_business_glossary_term' = 'Management Response');
ALTER TABLE `vibe_ngo_v1`.`mel`.`evaluation_finding` ALTER COLUMN `management_response` SET TAGS ('dbx_pii_demographic' = 'true');
ALTER TABLE `vibe_ngo_v1`.`mel`.`evaluation_finding` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_ngo_v1`.`mel`.`evaluation_finding` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `vibe_ngo_v1`.`mel`.`evaluation_finding` ALTER COLUMN `number` SET TAGS ('dbx_business_glossary_term' = 'Finding Number');
ALTER TABLE `vibe_ngo_v1`.`mel`.`evaluation_finding` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Priority Level');
ALTER TABLE `vibe_ngo_v1`.`mel`.`evaluation_finding` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `vibe_ngo_v1`.`mel`.`evaluation_finding` ALTER COLUMN `rating` SET TAGS ('dbx_business_glossary_term' = 'Finding Rating');
ALTER TABLE `vibe_ngo_v1`.`mel`.`evaluation_finding` ALTER COLUMN `rating` SET TAGS ('dbx_value_regex' = 'highly_satisfactory|satisfactory|moderately_satisfactory|moderately_unsatisfactory|unsatisfactory|highly_unsatisfactory');
ALTER TABLE `vibe_ngo_v1`.`mel`.`evaluation_finding` ALTER COLUMN `responsible_unit` SET TAGS ('dbx_business_glossary_term' = 'Responsible Unit');
ALTER TABLE `vibe_ngo_v1`.`mel`.`evaluation_finding` ALTER COLUMN `risk_implication` SET TAGS ('dbx_business_glossary_term' = 'Risk Implication');
ALTER TABLE `vibe_ngo_v1`.`mel`.`evaluation_finding` ALTER COLUMN `sdg_alignment` SET TAGS ('dbx_business_glossary_term' = 'Sustainable Development Goal (SDG) Alignment');
ALTER TABLE `vibe_ngo_v1`.`mel`.`evaluation_finding` ALTER COLUMN `sector` SET TAGS ('dbx_business_glossary_term' = 'Sector');
ALTER TABLE `vibe_ngo_v1`.`mel`.`evaluation_finding` ALTER COLUMN `statement` SET TAGS ('dbx_business_glossary_term' = 'Finding Statement');
ALTER TABLE `vibe_ngo_v1`.`mel`.`evaluation_finding` ALTER COLUMN `target_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Target Completion Date');
ALTER TABLE `vibe_ngo_v1`.`mel`.`reporting_period` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_ngo_v1`.`mel`.`reporting_period` SET TAGS ('dbx_subdomain' = 'program_planning');
ALTER TABLE `vibe_ngo_v1`.`mel`.`reporting_period` ALTER COLUMN `reporting_period_id` SET TAGS ('dbx_business_glossary_term' = 'Reporting Period Identifier');
ALTER TABLE `vibe_ngo_v1`.`mel`.`reporting_period` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Partnership Agreement Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`mel`.`reporting_period` ALTER COLUMN `component_id` SET TAGS ('dbx_business_glossary_term' = 'Component Id');
ALTER TABLE `vibe_ngo_v1`.`mel`.`reporting_period` ALTER COLUMN `consortium_id` SET TAGS ('dbx_business_glossary_term' = 'Consortium Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`mel`.`reporting_period` ALTER COLUMN `mel_logframe_id` SET TAGS ('dbx_business_glossary_term' = 'Mel Logframe Id');
ALTER TABLE `vibe_ngo_v1`.`mel`.`reporting_period` ALTER COLUMN `parent_reporting_period_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Period Id');
ALTER TABLE `vibe_ngo_v1`.`mel`.`reporting_period` ALTER COLUMN `primary_prior_reporting_period_id` SET TAGS ('dbx_business_glossary_term' = 'Prior Reporting Period Id');
ALTER TABLE `vibe_ngo_v1`.`mel`.`reporting_period` ALTER COLUMN `primary_prior_reporting_period_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_ngo_v1`.`mel`.`reporting_period` ALTER COLUMN `program_id` SET TAGS ('dbx_business_glossary_term' = 'Program Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`mel`.`reporting_period` ALTER COLUMN `baseline_period_flag` SET TAGS ('dbx_business_glossary_term' = 'Baseline Period Flag');
ALTER TABLE `vibe_ngo_v1`.`mel`.`reporting_period` ALTER COLUMN `calendar_year` SET TAGS ('dbx_business_glossary_term' = 'Calendar Year');
ALTER TABLE `vibe_ngo_v1`.`mel`.`reporting_period` ALTER COLUMN `closed_date` SET TAGS ('dbx_business_glossary_term' = 'Closed Date');
ALTER TABLE `vibe_ngo_v1`.`mel`.`reporting_period` ALTER COLUMN `reporting_period_code` SET TAGS ('dbx_business_glossary_term' = 'Period Code');
ALTER TABLE `vibe_ngo_v1`.`mel`.`reporting_period` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_ngo_v1`.`mel`.`reporting_period` ALTER COLUMN `dac_criteria_focus` SET TAGS ('dbx_business_glossary_term' = 'Dac Criteria Focus');
ALTER TABLE `vibe_ngo_v1`.`mel`.`reporting_period` ALTER COLUMN `data_collection_deadline` SET TAGS ('dbx_business_glossary_term' = 'Data Collection Deadline');
ALTER TABLE `vibe_ngo_v1`.`mel`.`reporting_period` ALTER COLUMN `data_quality_audit_flag` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Audit Flag');
ALTER TABLE `vibe_ngo_v1`.`mel`.`reporting_period` ALTER COLUMN `reporting_period_description` SET TAGS ('dbx_business_glossary_term' = 'Period Description');
ALTER TABLE `vibe_ngo_v1`.`mel`.`reporting_period` ALTER COLUMN `dhis2_period_code` SET TAGS ('dbx_business_glossary_term' = 'Dhis2 Period Code');
ALTER TABLE `vibe_ngo_v1`.`mel`.`reporting_period` ALTER COLUMN `donor_reporting_cycle` SET TAGS ('dbx_business_glossary_term' = 'Donor Reporting Cycle');
ALTER TABLE `vibe_ngo_v1`.`mel`.`reporting_period` ALTER COLUMN `duration_days` SET TAGS ('dbx_business_glossary_term' = 'Duration Days');
ALTER TABLE `vibe_ngo_v1`.`mel`.`reporting_period` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'End Date');
ALTER TABLE `vibe_ngo_v1`.`mel`.`reporting_period` ALTER COLUMN `endline_period_flag` SET TAGS ('dbx_business_glossary_term' = 'Endline Period Flag');
ALTER TABLE `vibe_ngo_v1`.`mel`.`reporting_period` ALTER COLUMN `evaluation_type` SET TAGS ('dbx_business_glossary_term' = 'Evaluation Type');
ALTER TABLE `vibe_ngo_v1`.`mel`.`reporting_period` ALTER COLUMN `fgd_scheduled_flag` SET TAGS ('dbx_business_glossary_term' = 'Fgd Scheduled Flag');
ALTER TABLE `vibe_ngo_v1`.`mel`.`reporting_period` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `vibe_ngo_v1`.`mel`.`reporting_period` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_ngo_v1`.`mel`.`reporting_period` ALTER COLUMN `kii_scheduled_flag` SET TAGS ('dbx_business_glossary_term' = 'Kii Scheduled Flag');
ALTER TABLE `vibe_ngo_v1`.`mel`.`reporting_period` ALTER COLUMN `midline_period_flag` SET TAGS ('dbx_business_glossary_term' = 'Midline Period Flag');
ALTER TABLE `vibe_ngo_v1`.`mel`.`reporting_period` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_ngo_v1`.`mel`.`reporting_period` ALTER COLUMN `month_number` SET TAGS ('dbx_business_glossary_term' = 'Month Number');
ALTER TABLE `vibe_ngo_v1`.`mel`.`reporting_period` ALTER COLUMN `reporting_period_name` SET TAGS ('dbx_business_glossary_term' = 'Period Name');
ALTER TABLE `vibe_ngo_v1`.`mel`.`reporting_period` ALTER COLUMN `reporting_period_name` SET TAGS ('dbx_pii_personal' = 'true');
ALTER TABLE `vibe_ngo_v1`.`mel`.`reporting_period` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_ngo_v1`.`mel`.`reporting_period` ALTER COLUMN `pdm_cycle_flag` SET TAGS ('dbx_business_glossary_term' = 'Pdm Cycle Flag');
ALTER TABLE `vibe_ngo_v1`.`mel`.`reporting_period` ALTER COLUMN `quarter_number` SET TAGS ('dbx_business_glossary_term' = 'Quarter Number');
ALTER TABLE `vibe_ngo_v1`.`mel`.`reporting_period` ALTER COLUMN `report_submission_deadline` SET TAGS ('dbx_business_glossary_term' = 'Report Submission Deadline');
ALTER TABLE `vibe_ngo_v1`.`mel`.`reporting_period` ALTER COLUMN `reporting_frequency` SET TAGS ('dbx_business_glossary_term' = 'Reporting Frequency');
ALTER TABLE `vibe_ngo_v1`.`mel`.`reporting_period` ALTER COLUMN `reporting_period_status` SET TAGS ('dbx_business_glossary_term' = 'Period Status');
ALTER TABLE `vibe_ngo_v1`.`mel`.`reporting_period` ALTER COLUMN `reporting_period_type` SET TAGS ('dbx_business_glossary_term' = 'Period Type');
ALTER TABLE `vibe_ngo_v1`.`mel`.`reporting_period` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Start Date');
ALTER TABLE `vibe_ngo_v1`.`mel`.`reporting_period` ALTER COLUMN `week_number` SET TAGS ('dbx_business_glossary_term' = 'Week Number');
ALTER TABLE `vibe_ngo_v1`.`mel`.`plan_indicator` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `vibe_ngo_v1`.`mel`.`plan_indicator` SET TAGS ('dbx_subdomain' = 'indicator_management');
ALTER TABLE `vibe_ngo_v1`.`mel`.`plan_indicator` SET TAGS ('dbx_association_edges' = 'mel.meal_plan,mel.indicator');
ALTER TABLE `vibe_ngo_v1`.`mel`.`plan_indicator` ALTER COLUMN `plan_indicator_id` SET TAGS ('dbx_business_glossary_term' = 'Plan Indicator - Plan Indicator Id');
ALTER TABLE `vibe_ngo_v1`.`mel`.`plan_indicator` ALTER COLUMN `indicator_id` SET TAGS ('dbx_business_glossary_term' = 'Plan Indicator - Indicator Id');
ALTER TABLE `vibe_ngo_v1`.`mel`.`plan_indicator` ALTER COLUMN `meal_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Plan Indicator - Meal Plan Id');
ALTER TABLE `vibe_ngo_v1`.`mel`.`plan_indicator` ALTER COLUMN `data_collection_responsibility` SET TAGS ('dbx_business_glossary_term' = 'Data Collection Responsibility');
ALTER TABLE `vibe_ngo_v1`.`mel`.`plan_indicator` ALTER COLUMN `inclusion_date` SET TAGS ('dbx_business_glossary_term' = 'Indicator Inclusion Date');
ALTER TABLE `vibe_ngo_v1`.`mel`.`plan_indicator` ALTER COLUMN `indicator_count` SET TAGS ('dbx_business_glossary_term' = 'Total Indicator Count');
ALTER TABLE `vibe_ngo_v1`.`mel`.`plan_indicator` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Active in Plan');
ALTER TABLE `vibe_ngo_v1`.`mel`.`plan_indicator` ALTER COLUMN `measurement_frequency_in_plan` SET TAGS ('dbx_business_glossary_term' = 'Measurement Frequency in Plan');
ALTER TABLE `vibe_ngo_v1`.`mel`.`plan_indicator` ALTER COLUMN `target_value_in_plan` SET TAGS ('dbx_business_glossary_term' = 'Plan-Specific Target Value');
