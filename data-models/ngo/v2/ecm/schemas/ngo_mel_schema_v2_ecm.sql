-- Schema for Domain: mel | Business:  | Version: v2_ecm
-- Generated on: 2026-07-03 04:47:16

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_ngo_v1`.`mel` COMMENT 'Systems of record: DHIS2 (aggregate health/nutrition reporting), Kobo Toolbox (data collection), InSight (analytics & dashboards), ActivityInfo (indicator tracking), DevResults, CountrySTAT. MEL covers indicators, evaluations, data quality, and learning agendas.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_ngo_v1`.`mel`.`indicator` (
    `indicator_id` BIGINT COMMENT 'Unique identifier for the MEL (Monitoring Evaluation and Learning) indicator. Primary key.',
    `award_id` BIGINT COMMENT 'Foreign key reference to the grant or award that mandates or funds the tracking of this indicator. Null if the indicator is used across multiple grants or is organization-wide.',
    `obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.obligation. Business justification: MEL indicators are often defined to satisfy specific donor reporting obligations (e.g., USAID F indicators, ECHO visibility requirements). Linking indicator definitions to the compliance obligations t',
    `country_programme_document_id` BIGINT COMMENT 'FK to the Country Programme Document this indicator supports.',
    `donor_safeguarding_requirement_id` BIGINT COMMENT 'Foreign key linking to safeguarding.donor_safeguarding_requirement. Business justification: Donors mandate specific safeguarding indicators (% staff trained, incident response time, beneficiary awareness metrics). MEL indicators must track compliance with donor safeguarding requirements for ',
    `intervention_id` BIGINT COMMENT 'Foreign key reference to the program that owns or primarily uses this indicator. An indicator may be used across multiple programs but typically has a primary owning program.',
    `partner_org_id` BIGINT COMMENT 'Foreign key linking to partnership.partner_org. Business justification: Indicators frequently track partner-specific performance metrics in sub-award agreements. Business need: partner accountability reporting, disaggregated results by implementing partner, performance-ba',
    `partnership_agreement_id` BIGINT COMMENT 'Foreign key linking to partnership.partnership_agreement. Business justification: Indicators are agreement-specific reporting obligations. Business need: agreement compliance monitoring, donor reporting, performance-based payment triggers.',
    `strategic_plan_goal_area_id` BIGINT COMMENT 'FK to the Strategic Plan goal area this indicator aligns to.',
    `system_platform_id` BIGINT COMMENT 'Foreign key linking to technology.system_platform. Business justification: Indicators are configured in specific platforms (DHIS2, CommCare, KoboToolbox). Essential for data source tracking, API integration mapping, system retirement planning, and troubleshooting data qualit',
    `unsdcf_outcome_id` BIGINT COMMENT 'Explicit SDG indicator alignment.',
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
    `sdg_alignment_type` STRING COMMENT 'Explicit SDG indicator alignment.',
    `sdg_goal_code` STRING COMMENT 'Explicit SDG indicator alignment.',
    `sdg_indicator_code` STRING COMMENT 'Explicit SDG indicator alignment.',
    `sdg_target_code` STRING COMMENT 'Explicit SDG indicator alignment.',
    `sector` STRING COMMENT 'The humanitarian or development sector this indicator belongs to (e.g., WASH (Water Sanitation and Hygiene), Health, Nutrition, Education, Protection, Shelter, Food Security, Livelihoods).',
    `target_date` DATE COMMENT 'The date by which the target value is expected to be achieved.',
    `target_value` DECIMAL(18,2) COMMENT 'The planned or target value that the program aims to achieve for this indicator by the end of the reporting period or project lifecycle.',
    `theme` STRING COMMENT 'Cross-cutting theme or focus area this indicator addresses (e.g., Gender Equality, Child Protection, Climate Adaptation, Disability Inclusion, GBV (Gender-Based Violence) Prevention).',
    `unit_of_measure` STRING COMMENT 'The unit in which the indicator is measured (e.g., number of people, percentage, households, liters, kilograms, days, sessions).',
    `verification_method` STRING COMMENT 'The method used to verify the accuracy and reliability of the indicator data (e.g., spot checks, third-party evaluation, beneficiary feedback, document review, field monitoring visits).',
    `version_number` STRING COMMENT 'Version identifier for this indicator definition, used to track changes to calculation methods, definitions, or disaggregation requirements over time.. Valid values are `^[0-9]+.[0-9]+$`',
    CONSTRAINT pk_indicator PRIMARY KEY(`indicator_id`)
) COMMENT 'Defines a measurable indicator used to track program outcomes, outputs, and impact. Sourced from DHIS2, Kobo Toolbox, or manual entry. Supports SDG alignment, UNSDCF outcome linkage, and strategic plan goal area mapping. Systems-of-record: DHIS2, RAM (Results Assessment Module), InSight. Framework: IATI Result Standard v2.03 / OECD-DAC criteria.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`mel`.`mel_logframe` (
    `mel_logframe_id` BIGINT COMMENT 'Unique identifier for the logical framework record. Primary key for the MEL LogFrame entity.',
    `award_id` BIGINT COMMENT 'Reference to the grant or award that this logical framework supports. Links the LogFrame to the funding source and donor requirements.',
    `intervention_id` BIGINT COMMENT 'Reference to the program or project that this logical framework defines. Links the LogFrame to operational program delivery.',
    `parent_logframe_mel_logframe_id` BIGINT COMMENT 'Self-referencing foreign key to the parent LogFrame entry in the hierarchy. Enables nested results chains where outputs roll up to outcomes, outcomes to goals.',
    `partner_org_id` BIGINT COMMENT 'Foreign key linking to partnership.partner_org. Business justification: Logframes track partner-implemented results in sub-award/consortium contexts. Business need: partner performance reporting against logframe indicators, disaggregated results tracking by implementing p',
    `partnership_agreement_id` BIGINT COMMENT 'Foreign key linking to partnership.partnership_agreement. Business justification: Logframes are core agreement annexes defining results frameworks. Business need: agreement results tracking, donor reporting compliance, partnership performance monitoring.',
    `staff_member_id` BIGINT COMMENT 'Foreign key linking to workforce.staff_member. Business justification: Logframes track responsible_party as text but MEL accountability frameworks and donor reporting (USAID, FCDO) require linking to actual staff member for performance management and results framework ow',
    `actual_date` DATE COMMENT 'Date of the most recent actual measurement. Used to track reporting currency and identify data staleness.',
    `actual_value` DECIMAL(18,2) COMMENT 'Most recent measured or reported value for the indicator. Updated through Monitoring Evaluation and Learning (MEL) data collection activities such as Post-Distribution Monitoring (PDM), Focus Group Discussions (FGD), or District Health Information System 2 (DHIS2) reporting.',
    `approved_by` STRING COMMENT 'Name or identifier of the person or committee that approved this LogFrame. Critical for governance and donor compliance.',
    `approved_date` DATE COMMENT 'Date when this LogFrame was formally approved. Establishes the baseline for performance tracking and donor reporting.',
    `assumptions` STRING COMMENT 'External conditions or factors that must hold true for the intervention logic to succeed. Critical for risk management and Theory of Change (ToC) validation.',
    `baseline_date` DATE COMMENT 'Date when the baseline measurement was taken. Critical for establishing the temporal reference point for all subsequent measurements.',
    `baseline_value` DECIMAL(18,2) COMMENT 'Measured value of the indicator at the start of the program or intervention. Provides the starting point for measuring change and impact.',
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
    `logframe_code` STRING COMMENT 'Business identifier or reference code for the logical framework, often aligned with donor proposal numbering or internal program codes.',
    `logframe_name` STRING COMMENT 'Descriptive name or title of the logical framework, typically reflecting the program or intervention name.',
    `means_of_verification` STRING COMMENT 'Data source or method by which the indicator will be measured and verified. Examples include surveys, administrative records, Post-Distribution Monitoring (PDM), or District Health Information System 2 (DHIS2) reports.',
    `mel_logframe_status` STRING COMMENT 'Current status of this LogFrame element in its lifecycle. Tracks whether targets are being met and whether the intervention logic remains valid. [ENUM-REF-CANDIDATE: Draft|Active|On Track|At Risk|Behind Schedule|Achieved|Closed|Cancelled — 8 candidates stripped; promote to reference product]',
    `next_review_date` DATE COMMENT 'Scheduled date for the next review or evaluation of this LogFrame element. Drives Monitoring Evaluation and Learning (MEL) planning and resource allocation.',
    `notes` STRING COMMENT 'Free-text field for additional context, lessons learned, or adaptive management decisions related to this LogFrame element.',
    `objectively_verifiable_indicator` STRING COMMENT 'The measurable indicator that will be used to verify achievement of this results chain level. Links to the indicator library for tracking.',
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
) COMMENT 'Logical framework (logframe) linking interventions to results chains (goal, purpose, outputs, activities) with objectively verifiable indicators, means of verification, and assumptions. Aligned to DAC evaluation criteria.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`mel`.`indicator_target` (
    `indicator_target_id` BIGINT COMMENT 'Unique identifier for the indicator target record. Primary key.',
    `award_id` BIGINT COMMENT 'Reference to the grant or award funding this indicator target.',
    `donor_requirement_id` BIGINT COMMENT 'Foreign key linking to compliance.donor_requirement. Business justification: Specific indicator targets are often set to satisfy explicit donor compliance requirements (e.g., contractual deliverables, earmark requirements, congressional directives). This link enables tracking ',
    `geographic_scope_id` BIGINT COMMENT 'Reference to the geographic area (country, region, district, community) where this target applies.',
    `indicator_id` BIGINT COMMENT 'Reference to the indicator definition in the MEL indicator library for which this target is set.',
    `intervention_id` BIGINT COMMENT 'Reference to the program or project under which this indicator target is tracked.',
    `org_unit_id` BIGINT COMMENT 'Reference to the organizational unit, team, or country office responsible for achieving this target.',
    `partner_org_id` BIGINT COMMENT 'Foreign key linking to partnership.partner_org. Business justification: Targets are set at partner level in sub-award agreements as performance benchmarks. Business need: partner-specific target setting, milestone tracking, performance-based disbursement triggers.',
    `partnership_agreement_id` BIGINT COMMENT 'Foreign key linking to partnership.partnership_agreement. Business justification: Targets set in partnership agreements as performance benchmarks. Business need: agreement milestone tracking, performance-based disbursement triggers, compliance verification.',
    `staff_member_id` BIGINT COMMENT 'Reference to the staff member or MEL officer accountable for tracking and reporting on this target.',
    `program_logframe_id` BIGINT COMMENT 'Reference to the LogFrame within which this indicator target is defined.',
    `reporting_period_id` BIGINT COMMENT 'Reference to the specific reporting period (quarterly, annual, etc.) for which this target applies.',
    `approval_date` DATE COMMENT 'The date when this indicator target was formally approved by the responsible authority or donor.',
    `assumptions` STRING COMMENT 'Key assumptions underlying the achievement of this target, including external factors and preconditions.',
    `baseline_date` DATE COMMENT 'The date when the baseline value was measured or established.',
    `baseline_value` DECIMAL(18,2) COMMENT 'The baseline measurement value at the start of the program or reporting period, used as the starting point for target setting.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this indicator target record was first created in the system.',
    `dac_sector_code` STRING COMMENT 'The OECD DAC sector classification code for this target, used for international aid transparency and reporting.',
    `data_collection_method` STRING COMMENT 'The primary method used to collect data for this target (e.g., household survey, FGD, KII, PDM, administrative records, DHIS2 aggregate).',
    `disaggregation_age_group` STRING COMMENT 'Age group category for this target (e.g., 0-5, 6-17, 18-59, 60+). Supports age-sensitive programming and reporting.',
    `disaggregation_disability_status` STRING COMMENT 'Disability status disaggregation for this target, supporting inclusive programming and Washington Group standards.. Valid values are `with_disability|without_disability|not_specified`',
    `disaggregation_displacement_status` STRING COMMENT 'Displacement or migration status disaggregation (e.g., IDP, refugee, returnee, host community, Person of Concern).',
    `disaggregation_sex` STRING COMMENT 'Sex-based disaggregation category for this target (male, female, other, not specified). Used for gender-sensitive monitoring.. Valid values are `male|female|other|not_specified`',
    `donor_reporting_requirement` STRING COMMENT 'Specific donor reporting requirement or framework that this target must satisfy (e.g., USAID F indicator, DFID logframe output 2.1).',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this indicator target record was last updated or modified.',
    `measurement_frequency` STRING COMMENT 'How often this indicator target is measured and reported (daily, weekly, monthly, quarterly, semi-annually, annually, one-time, continuous). [ENUM-REF-CANDIDATE: daily|weekly|monthly|quarterly|semi_annually|annually|one_time|continuous — 8 candidates stripped; promote to reference product]',
    `mitigation_strategy` STRING COMMENT 'Planned strategies or actions to mitigate identified risks and ensure target achievement.',
    `notes` STRING COMMENT 'Additional notes, comments, or contextual information about this indicator target.',
    `revision_date` DATE COMMENT 'The date when the target was last revised or amended.',
    `revision_reason` STRING COMMENT 'Explanation for any revision to the original target value or date, including contextual changes or donor amendments.',
    `risks` STRING COMMENT 'Identified risks that may prevent the achievement of this target, including contextual, operational, and external risks.',
    `sdg_alignment` STRING COMMENT 'The SDG goal and target number(s) that this indicator target contributes to (e.g., SDG 1.1, SDG 3.2).',
    `target_code` STRING COMMENT 'Business identifier or code for this indicator target, often used in donor reports and LogFrame documentation.',
    `target_date` DATE COMMENT 'The date by which the target value is expected to be achieved.',
    `target_description` STRING COMMENT 'Detailed narrative description of what this target represents, including context and rationale.',
    `target_name` STRING COMMENT 'Human-readable name or label for this indicator target.',
    `target_status` STRING COMMENT 'Current lifecycle status of the indicator target: draft (being defined), approved (validated by stakeholders), active (currently being tracked), on_track (progressing as planned), at_risk (may not be achieved), off_track (unlikely to be achieved), achieved (target met), not_achieved (target not met), revised (target has been modified), cancelled (target no longer applicable). [ENUM-REF-CANDIDATE: draft|approved|active|on_track|at_risk|off_track|achieved|not_achieved|revised|cancelled — 10 candidates stripped; promote to reference product]',
    `target_type` STRING COMMENT 'Classification of the target based on the results chain level: output (direct deliverables), outcome (intermediate results), impact (long-term change), process (operational efficiency), or input (resources).. Valid values are `output|outcome|impact|process|input`',
    `target_value` DECIMAL(18,2) COMMENT 'The planned or target value to be achieved for this indicator within the specified period and geographic scope.',
    `unit_of_measure` STRING COMMENT 'The unit in which the target and baseline values are measured (e.g., number of beneficiaries, percentage, households, liters).',
    `verification_source` STRING COMMENT 'The source or means of verification for this target (e.g., program records, beneficiary surveys, third-party evaluation, DHIS2 reports).',
    CONSTRAINT pk_indicator_target PRIMARY KEY(`indicator_target_id`)
) COMMENT 'Planned target values for indicators over specific reporting periods, with disaggregation dimensions (sex, age, disability, displacement status) and geographic scope.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`mel`.`indicator_result` (
    `indicator_result_id` BIGINT COMMENT 'Unique identifier for the indicator result record. Primary key for the indicator result entity.',
    `audit_finding_id` BIGINT COMMENT 'Foreign key linking to compliance.audit_finding. Business justification: Auditors frequently cite specific indicator results as evidence when documenting findings about data quality, questioned costs, or compliance violations. This link enables traceability from audit find',
    `award_id` BIGINT COMMENT 'Reference to the grant award funding this indicator. Enables donor-specific performance reporting and compliance.',
    `staff_member_id` BIGINT COMMENT 'Foreign key linking to workforce.staff_member. Business justification: Data quality assessments and MEAL audits require traceability to the staff member who collected indicator data. Currently tracked as collection_team text; FK enables accountability audits and capacity',
    `commodity_id` BIGINT COMMENT 'Foreign key linking to supply.commodity. Business justification: Distribution-focused indicators (e.g., hygiene kits distributed) require linking results to specific commodities to verify what was actually distributed. Standard MEL practice in humanitarian progra',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Results are collected at cost center level (field offices, program units). Cost center managers review indicator results alongside expenditure to assess program cost-effectiveness. Financial reports a',
    `donor_report_id` BIGINT COMMENT 'Reference to the specific donor report in which this indicator result was included. Enables traceability from report to source data.',
    `field_monitoring_visit_id` BIGINT COMMENT 'Foreign key linking to partnership.field_monitoring_visit. Business justification: Field visits verify indicator results reported by partners. Business need: data verification, spot-check validation, on-site result confirmation.',
    `indicator_id` BIGINT COMMENT 'Reference to the indicator definition from the indicator library. Links this result to the specific KPI or outcome measure being tracked.',
    `indicator_target_id` BIGINT COMMENT 'Foreign key linking to mel.indicator_target. Business justification: Indicator results measure actual achievement against specific planned targets. Each indicator_result should reference the indicator_target it is measuring against. This creates proper traceability fro',
    `intervention_id` BIGINT COMMENT 'Reference to the program under which this indicator result was achieved. Enables program-level performance aggregation.',
    `partner_org_id` BIGINT COMMENT 'Reference to the implementing partner organization that collected or contributed this indicator result. Used for partner performance tracking.',
    `partner_performance_review_id` BIGINT COMMENT 'Foreign key linking to partnership.partner_performance_review. Business justification: Indicator results are core evidence for partner performance assessment. Business need: performance rating calculation, milestone achievement verification, target vs actual analysis.',
    `partner_report_submission_id` BIGINT COMMENT 'Foreign key linking to partnership.partner_report_submission. Business justification: Partner reports contain indicator results as core content. Business need: report completeness verification, results validation, donor reporting compilation.',
    `project_site_id` BIGINT COMMENT 'Reference to the geographic project site where this result was achieved. Enables location-based performance analysis.',
    `user_account_id` BIGINT COMMENT 'Foreign key linking to technology.user_account. Business justification: Results are entered by specific users. Critical for data quality audits, identifying training needs, accountability tracking, and investigating data discrepancies. Standard practice in donor-funded ME',
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
    `is_milestone` BOOLEAN COMMENT 'Indicates whether this indicator result represents a contractual milestone or critical deliverable per grant agreement terms.',
    `last_modified_by` STRING COMMENT 'User identifier of the person who last modified this indicator result record. Supports accountability and audit trail.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this indicator result record was last updated. Tracks data currency and change history.',
    `narrative_description` STRING COMMENT 'Qualitative narrative describing the context, achievements, challenges, and lessons learned related to this indicator result. Used in donor reports.',
    `reported_to_donor` BOOLEAN COMMENT 'Indicates whether this indicator result has been included in formal donor reporting. Tracks reporting compliance and audit trail.',
    `reporting_period_end_date` DATE COMMENT 'End date of the reporting period for which this indicator result is recorded. Defines the measurement window for performance tracking.',
    `reporting_period_start_date` DATE COMMENT 'Start date of the reporting period for which this indicator result is recorded. Aligns with donor reporting cycles and MEL frameworks.',
    `result_status` STRING COMMENT 'Current workflow status of the indicator result record. Tracks approval and review lifecycle.. Valid values are `draft|submitted|approved|rejected|archived`',
    `result_value` DECIMAL(18,2) COMMENT 'Actual achieved value recorded for the indicator during the reporting period. The primary quantitative outcome measurement.',
    `target_value` DECIMAL(18,2) COMMENT 'Planned target value for the indicator during this reporting period. Used for variance analysis and performance assessment.',
    `unit_of_measure` STRING COMMENT 'Unit in which the indicator result is measured. Critical for correct interpretation and aggregation of performance data. [ENUM-REF-CANDIDATE: number|percentage|ratio|count|households|individuals|facilities|days|hours|liters|kilograms|metric_tons — 12 candidates stripped; promote to reference product]',
    `variance_from_target` DECIMAL(18,2) COMMENT 'Calculated difference between actual result and target value. Positive values indicate over-achievement, negative values indicate under-achievement.',
    `variance_percentage` DECIMAL(18,2) COMMENT 'Percentage variance from target, calculated as (actual - target) / target * 100. Key metric for donor performance reporting.',
    `verification_date` DATE COMMENT 'Date when the indicator result was verified by MEL staff or external evaluators. Critical for audit trail and data quality documentation.',
    `verification_status` STRING COMMENT 'Current verification state of the indicator result. Tracks data quality assurance workflow per Core Humanitarian Standard (CHS) requirements.. Valid values are `unverified|verified|rejected|pending_review`',
    `verified_by` STRING COMMENT 'Name or identifier of the MEL officer or evaluator who verified this indicator result. Supports accountability and quality assurance.',
    CONSTRAINT pk_indicator_result PRIMARY KEY(`indicator_result_id`)
) COMMENT 'Actual measured result values for indicators collected during reporting periods, including data quality scores, variance analysis, and verification status.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`mel`.`meal_plan` (
    `meal_plan_id` BIGINT COMMENT 'Unique identifier for the MEAL plan document. Primary key for the MEAL plan entity.',
    `award_id` BIGINT COMMENT 'Reference to the grant or award that funds this MEAL plan. Links the MEAL plan to the funding source and donor reporting requirements.',
    `budget_id` BIGINT COMMENT 'Foreign key linking to finance.budget. Business justification: MEL plans define data collection, monitoring, and evaluation activities requiring budget allocation (surveys, tools, staff time, external evaluators). Annual budgeting process allocates funds for MEL ',
    `budget_plan_id` BIGINT COMMENT 'Foreign key linking to program.budget_plan. Business justification: MEL budget reconciliation requires linking meal_plan.budget_allocated to source program.budget_plan for variance analysis, donor reporting, and financial compliance. Real business process: quarterly M',
    `obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.obligation. Business justification: MEAL plans document how the organization will meet specific donor MEL reporting obligations (e.g., USAID Performance Management Plan requirements, ECHO visibility obligations, DFID results measurement',
    `intervention_id` BIGINT COMMENT 'Reference to the program or project that this MEAL plan governs. Links the MEAL plan to the operational program it monitors.',
    `mel_logframe_id` BIGINT COMMENT 'Foreign key linking to mel.mel_logframe. Business justification: MEAL plans implement specific logframes. Currently meal_plan has logframe_reference (STRING) which should be replaced with a proper FK to mel_logframe. This establishes the authoritative link between ',
    `partnership_agreement_id` BIGINT COMMENT 'Foreign key linking to partnership.partnership_agreement. Business justification: MEAL plans are agreement-specific deliverables and annexes. Business need: agreement compliance tracking, donor reporting obligation fulfillment, partnership performance framework definition.',
    `staff_member_id` BIGINT COMMENT 'Reference to the MEL staff member who is the lead or primary responsible party for implementing this MEAL plan.',
    `risk_assessment_id` BIGINT COMMENT 'Foreign key linking to safeguarding.risk_assessment. Business justification: MEAL plans must incorporate safeguarding risk assessments to ensure monitoring/evaluation activities dont create risks with vulnerable populations. Real business process: MEAL plan approval requires ',
    `system_platform_id` BIGINT COMMENT 'Foreign key linking to technology.system_platform. Business justification: MEL plans are designed and tracked in specific platforms (Salesforce, custom MEL systems). Required for system ownership tracking, data lineage documentation, integration planning, and platform retire',
    `accountability_mechanisms` STRING COMMENT 'Description of accountability mechanisms embedded in the MEAL plan, including beneficiary feedback channels, complaint response mechanisms, and Core Humanitarian Standard (CHS) commitments.',
    `approval_date` DATE COMMENT 'Date when the MEAL plan was formally approved by program management and/or the donor. Marks the transition from draft to active status.',
    `baseline_completion_date` DATE COMMENT 'Date when the baseline assessment was completed. Baseline data provides the starting point for measuring program outcomes and impact.',
    `beneficiary_feedback_channels` DECIMAL(18,2) COMMENT 'Description of channels through which beneficiaries can provide feedback, complaints, and suggestions, including hotlines, suggestion boxes, community meetings, and digital platforms.',
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
    `indicator_count` STRING COMMENT 'Total number of Key Performance Indicators (KPI) and monitoring indicators defined in the indicator matrix for this MEAL plan.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this MEAL plan record was last modified in the system. Used for audit trail and change tracking.',
    `learning_agenda` STRING COMMENT 'Description of the learning agenda, including key learning questions, knowledge management activities, and how learning will be captured and disseminated to inform adaptive management.',
    `mel_team_members` STRING COMMENT 'Comma-separated list or description of MEL team members and their roles in implementing the MEAL plan, including data collectors, analysts, and coordinators.',
    `midline_planned_date` DATE COMMENT 'Planned date for the midline evaluation. Midline evaluations assess progress toward outcomes at the midpoint of the program cycle.',
    `monitoring_strategy` STRING COMMENT 'Comprehensive description of the monitoring strategy, including frequency, methods, data sources, and responsible parties for ongoing program monitoring.',
    `plan_status` STRING COMMENT 'Current lifecycle status of the MEAL plan. Indicates whether the plan is in development, approved for use, actively being implemented, or closed. [ENUM-REF-CANDIDATE: draft|under_review|approved|active|suspended|closed|archived — 7 candidates stripped; promote to reference product]',
    `plan_title` STRING COMMENT 'The official title or name of the MEAL plan document. Used for identification and reference in donor reports and internal documentation.',
    `plan_version` STRING COMMENT 'Version number or identifier for this iteration of the MEAL plan. Tracks revisions and updates to the plan over the program lifecycle.',
    `rbm_framework_alignment` STRING COMMENT 'Description of how this MEAL plan aligns with the organizations Results-Based Management framework and donor RBM requirements.',
    `reporting_calendar` STRING COMMENT 'Description of the reporting calendar, including frequency and timing of internal reports, donor reports, Situation Reports (SitRep), and other MEL deliverables.',
    `revision_history` STRING COMMENT 'Summary of major revisions and amendments to the MEAL plan over its lifecycle, including dates and reasons for changes.',
    `risk_mitigation_plan` STRING COMMENT 'Description of risks to MEL implementation (e.g., access constraints, security incidents, data quality issues) and mitigation strategies.',
    `sdg_alignment` STRING COMMENT 'Description of which Sustainable Development Goals and targets this MEAL plan monitors and how program indicators align with SDG indicators.',
    `toc_narrative` STRING COMMENT 'Narrative description of the Theory of Change that underpins this MEAL plan. Explains the causal pathway from inputs to impact and the assumptions being tested.',
    CONSTRAINT pk_meal_plan PRIMARY KEY(`meal_plan_id`)
) COMMENT 'Monitoring, Evaluation, Accountability, and Learning (MEAL) plan defining data collection methods, reporting calendars, accountability mechanisms, and learning agendas for an intervention.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`mel`.`evaluation` (
    `evaluation_id` BIGINT COMMENT 'Unique identifier for the evaluation record. Primary key.',
    `award_id` BIGINT COMMENT 'Reference to the grant funding this evaluation, if applicable.',
    `budget_id` BIGINT COMMENT 'Foreign key linking to finance.budget. Business justification: Evaluations are budgeted activities with dedicated allocations. Finance tracks evaluation costs (consultants, travel, data collection) against approved evaluation budget. Procurement requisitions for ',
    `staff_member_id` BIGINT COMMENT 'Foreign key linking to workforce.staff_member. Business justification: Evaluation management requires tracking internal staff who commissioned and oversee evaluations (distinct from external lead_evaluator_name). Essential for budget accountability, management response t',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Evaluations are conducted by or for specific cost centers (country offices, program units). Cost center budget holders approve evaluation scope and funding. Evaluation costs are allocated to the cost ',
    `intervention_id` BIGINT COMMENT 'Reference to the program being evaluated.',
    `meal_plan_id` BIGINT COMMENT 'Foreign key linking to mel.meal_plan. Business justification: Evaluations (baseline, midterm, endline) are planned and executed as part of MEAL plans. This FK links the evaluation to the MEAL plan under which it was conducted, enabling tracking of MEAL plan eval',
    `mel_logframe_id` BIGINT COMMENT 'Foreign key linking to mel.mel_logframe. Business justification: Evaluations assess program performance against the logframes results chain. This FK links the evaluation to the specific logframe being assessed, enabling analysis of achievement against planned resu',
    `partner_org_id` BIGINT COMMENT 'Foreign key linking to partnership.partner_org. Business justification: Evaluations routinely assess partner performance, capacity, and implementation quality. Business need: partner performance evaluation, due diligence validation, partnership renewal decisions, capacity',
    `partner_report_submission_id` BIGINT COMMENT 'Foreign key linking to partnership.partner_report_submission. Business justification: Evaluation reports are a type of partner report submission. Business need: evaluation deliverable tracking, donor reporting, agreement compliance verification.',
    `partnership_agreement_id` BIGINT COMMENT 'Foreign key linking to partnership.partnership_agreement. Business justification: Evaluations triggered by agreement milestones or donor requirements. Business need: agreement performance assessment, renewal decision support, donor reporting compliance.',
    `risk_assessment_id` BIGINT COMMENT 'Foreign key linking to safeguarding.risk_assessment. Business justification: Evaluations (especially external with beneficiary contact) require safeguarding risk assessments before fieldwork to protect participants and evaluators from harm. Real business process: evaluation TO',
    `single_audit_id` BIGINT COMMENT 'Foreign key linking to compliance.single_audit. Business justification: Single audits (OMB Uniform Guidance requirement for US federal awards >$750K) often trigger or reference program evaluations as part of compliance testing. Evaluations provide evidence for audit asser',
    `system_platform_id` BIGINT COMMENT 'Foreign key linking to technology.system_platform. Business justification: Evaluations are managed in specific platforms (evaluation management systems, SharePoint, document repositories). Required for document retrieval, access provisioning for external evaluators, and mana',
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
) COMMENT 'Formal evaluation of a program or intervention assessing DAC criteria (relevance, coherence, effectiveness, efficiency, impact, sustainability). Sourced from eTools or evaluation management systems.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`mel`.`evaluation_finding` (
    `evaluation_finding_id` BIGINT COMMENT 'Unique identifier for the evaluation finding record. Primary key.',
    `staff_member_id` BIGINT COMMENT 'Foreign key linking to workforce.staff_member. Business justification: Management response tracking and corrective action monitoring require linking findings to accountable staff member. Currently text field responsible_person_name; FK enables performance tracking, workl',
    `advocacy_campaign_id` BIGINT COMMENT 'Foreign key linking to communication.advocacy_campaign. Business justification: Evidence-based findings inform advocacy campaign design and messaging. Evaluation findings on systemic issues, policy gaps, or unmet needs drive advocacy priorities and campaign content - operational ',
    `award_id` BIGINT COMMENT 'Reference to the grant or award that this finding pertains to, if applicable.',
    `capacity_building_plan_id` BIGINT COMMENT 'Foreign key linking to partnership.capacity_building_plan. Business justification: Evaluation findings trigger capacity building activities. Business need: corrective action planning, capacity gap closure, finding remediation tracking.',
    `evaluation_id` BIGINT COMMENT 'Reference to the parent evaluation from which this finding was extracted.',
    `intervention_id` BIGINT COMMENT 'Reference to the program or project that this finding pertains to.',
    `partner_org_id` BIGINT COMMENT 'Foreign key linking to partnership.partner_org. Business justification: Findings identify partner-specific issues requiring corrective action. Business need: partner accountability tracking, corrective action planning, performance review evidence, risk management escalati',
    `partner_performance_review_id` BIGINT COMMENT 'Foreign key linking to partnership.partner_performance_review. Business justification: Evaluation findings inform performance review ratings and corrective actions. Business need: performance review evidence, improvement plan development, rating justification.',
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
    `evaluator_name` STRING COMMENT 'Name of the lead evaluator or evaluation team member who documented this finding.',
    `evidence_base` STRING COMMENT 'Summary of the data sources and evidence that support this finding (e.g., FGD results, KII transcripts, PDM data, program records).',
    `finding_date` DATE COMMENT 'Date when the finding was formally documented or recorded in the evaluation report.',
    `finding_number` STRING COMMENT 'Sequential or hierarchical identifier for the finding within the evaluation report (e.g., F1, F2.1, Finding-03).',
    `finding_statement` STRING COMMENT 'The full text of the finding, conclusion, or recommendation as documented in the evaluation report.',
    `finding_type` STRING COMMENT 'Classification of the evaluation output: finding (observation), conclusion (interpretation), recommendation (action), lesson learned, or good practice.. Valid values are `finding|conclusion|recommendation|lesson_learned|good_practice`',
    `geographic_scope` STRING COMMENT 'Geographic area or location(s) to which this finding applies (country, region, field office, project site).',
    `implementation_progress_percentage` DECIMAL(18,2) COMMENT 'Percentage completion of the recommendation implementation (0.00 to 100.00).',
    `implementation_status` STRING COMMENT 'Current status of the recommendation or corrective action: not started, in progress, partially implemented, fully implemented, closed, or rejected.. Valid values are `not_started|in_progress|partially_implemented|fully_implemented|closed|rejected`',
    `last_review_date` DATE COMMENT 'Date when the implementation status of this finding was last reviewed or updated.',
    `management_response` STRING COMMENT 'Official response from management regarding acceptance, rejection, or modification of the recommendation.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this evaluation finding record was last modified or updated.',
    `next_review_date` DATE COMMENT 'Scheduled date for the next review or follow-up on this finding or recommendation.',
    `priority_level` STRING COMMENT 'Urgency and importance assigned to the finding or recommendation: critical, high, medium, or low.. Valid values are `critical|high|medium|low`',
    `rating` STRING COMMENT 'Qualitative rating assigned to the finding where applicable, using standard evaluation rating scales.. Valid values are `highly_satisfactory|satisfactory|moderately_satisfactory|moderately_unsatisfactory|unsatisfactory|highly_unsatisfactory`',
    `responsible_unit` STRING COMMENT 'The organizational unit, department, or team responsible for addressing or implementing the recommendation.',
    `risk_implication` STRING COMMENT 'Description of risks or potential negative consequences if the finding or recommendation is not addressed.',
    `sdg_alignment` STRING COMMENT 'Sustainable Development Goal(s) that this finding relates to or impacts (e.g., SDG 1, SDG 3, SDG 5).',
    `sector` STRING COMMENT 'Humanitarian or development sector this finding relates to (e.g., WASH, health, education, protection, food security).',
    `target_completion_date` DATE COMMENT 'Planned or agreed date by which the recommendation should be implemented or the issue addressed.',
    CONSTRAINT pk_evaluation_finding PRIMARY KEY(`evaluation_finding_id`)
) COMMENT 'Individual finding from an evaluation with associated recommendations, management response, and implementation tracking.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`mel`.`qualitative_record` (
    `qualitative_record_id` BIGINT COMMENT 'Primary key for qualitative_record',
    `data_collection_tool_id` BIGINT COMMENT 'Foreign key linking to mel.data_collection_tool. Business justification: Qualitative records (FGDs, KIIs) reference data_collection_tool as a STRING field containing the tool name/identifier. This should be normalized to a FK for proper tool tracking, version control, and ',
    `volunteer_id` BIGINT COMMENT 'Foreign key linking to volunteer.volunteer. Business justification: Volunteers frequently conduct KIIs, FGDs, community consultations as trained data collectors. MEL quality assurance requires tracking collector identity for verification, bias assessment, and data qua',
    `field_monitoring_visit_id` BIGINT COMMENT 'Foreign key linking to partnership.field_monitoring_visit. Business justification: KIIs during field visits generate qualitative records. Business need: visit documentation, finding evidence capture, beneficiary feedback collection during monitoring.',
    `intervention_id` BIGINT COMMENT 'Identifier of the program under which this qualitative data collection was conducted.',
    `evaluation_id` BIGINT COMMENT 'Identifier of the evaluation or assessment that this qualitative data collection is part of.',
    `indicator_id` BIGINT COMMENT 'Identifier of the MEL indicator or KPI that this qualitative data collection is intended to inform or triangulate.',
    `meal_plan_id` BIGINT COMMENT 'Foreign key linking to mel.meal_plan. Business justification: Qualitative data collection events (FGDs, KIIs) are conducted as part of MEAL plan implementation. This FK links the qualitative record to the MEAL plan under which it was collected, enabling tracking',
    `partner_org_id` BIGINT COMMENT 'Foreign key linking to partnership.partner_org. Business justification: KIIs/FGDs conducted with partner staff or at partner sites. Business need: partner implementation quality assessment, beneficiary feedback on partner services, safeguarding incident documentation.',
    `staff_member_id` BIGINT COMMENT 'Identifier of the staff member who facilitated the FGD or conducted the KII.',
    `project_site_id` BIGINT COMMENT 'Identifier of the project site or field location where the qualitative data collection took place.',
    `registrant_id` BIGINT COMMENT 'Foreign key linking to beneficiary.registrant. Business justification: Key informant interviews and focus group discussions with beneficiaries require linking participant identity for informed consent tracking, follow-up verification, and data triangulation with quantita',
    `safeguarding_incident_id` BIGINT COMMENT 'Foreign key linking to safeguarding.safeguarding_incident. Business justification: During qualitative data collection (KIIs, FGDs), participants may disclose safeguarding concerns requiring incident reporting. Real business process: MEL staff must link qualitative records to inciden',
    `system_platform_id` BIGINT COMMENT 'Foreign key linking to technology.system_platform. Business justification: Qualitative data is captured in specific platforms (NVivo, Atlas.ti, custom databases). Required for data retrieval, system access provisioning for researchers, and integration planning with quantitat',
    `tertiary_qualitative_translator_staff_staff_member_id` BIGINT COMMENT 'Identifier of the staff member or volunteer who provided translation services during the session.',
    `admin_level_1` STRING COMMENT 'First-level administrative division (e.g., state, province, region) where the collection took place.',
    `admin_level_2` STRING COMMENT 'Second-level administrative division (e.g., district, county) where the collection took place.',
    `collection_date` DATE COMMENT 'Date when the qualitative data collection event took place.',
    `collection_end_time` TIMESTAMP COMMENT 'Timestamp when the qualitative data collection session ended.',
    `collection_method_type` STRING COMMENT 'Type of qualitative data collection method used. FGD = Focus Group Discussion, KII = Key Informant Interview, MSC = Most Significant Change.. Valid values are `FGD|KII|Case Study|MSC Story|Observation|Participatory Assessment`',
    `collection_start_time` TIMESTAMP COMMENT 'Timestamp when the qualitative data collection session began.',
    `community_name` STRING COMMENT 'Name of the community, village, or settlement where the qualitative data collection was conducted.',
    `consent_form_version` STRING COMMENT 'Version identifier of the informed consent form used for this qualitative data collection event.',
    `country_code` STRING COMMENT 'ISO 3166-1 alpha-3 country code where the qualitative data collection occurred.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this qualitative data collection record was first created in the system.',
    `data_quality_rating` STRING COMMENT 'Assessment of the quality of the qualitative data collected, based on completeness, clarity, and reliability.. Valid values are `Excellent|Good|Fair|Poor`',
    `findings_summary` STRING COMMENT 'Summary of the main findings, conclusions, or insights from the qualitative data collection event.',
    `informant_organization` STRING COMMENT 'Organization or institution the key informant represents (for KIIs), e.g., Ministry of Health, local CBO, partner NGO.',
    `informant_role` STRING COMMENT 'Role or position of the key informant (for KIIs), e.g., community leader, health worker, teacher, local government official.',
    `informed_consent_obtained` BOOLEAN COMMENT 'Indicates whether informed consent was obtained from all participants prior to the qualitative data collection.',
    `key_themes_emerging` STRING COMMENT 'Summary of key themes, patterns, or insights that emerged from the qualitative data collection session.',
    `language_used` STRING COMMENT 'Primary language used during the qualitative data collection session.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this qualitative data collection record was last modified.',
    `participant_age_group_distribution` STRING COMMENT 'Distribution of participants by age group (e.g., 0-5: 2, 6-17: 5, 18-59: 8, 60+: 3). Free-text summary of age disaggregation.',
    `participant_count` STRING COMMENT 'Total number of participants in the qualitative data collection event (for FGDs) or 1 for KIIs.',
    `participant_female_count` STRING COMMENT 'Number of female participants in the qualitative data collection event.',
    `participant_male_count` STRING COMMENT 'Number of male participants in the qualitative data collection event.',
    `participant_other_gender_count` STRING COMMENT 'Number of participants identifying as other gender in the qualitative data collection event.',
    `primary_theme` STRING COMMENT 'Primary theme or topic area explored in the qualitative data collection (e.g., access to services, community perceptions, program satisfaction).',
    `qualitative_record_status` STRING COMMENT 'Current lifecycle status of the qualitative data collection record.. Valid values are `Draft|Completed|Reviewed|Approved|Archived`',
    `recommendations` STRING COMMENT 'Recommendations for program improvement or action based on the qualitative findings.',
    `recording_consent_obtained` BOOLEAN COMMENT 'Indicates whether explicit consent was obtained from participants to record the session (audio or video).',
    `recording_method` STRING COMMENT 'Method used to record the qualitative data collection session (e.g., audio recording, written notes, digital form).. Valid values are `Audio Recording|Video Recording|Written Notes|Digital Form`',
    `review_date` DATE COMMENT 'Date when the qualitative data collection record was reviewed and validated.',
    `topic_guide_used` STRING COMMENT 'Name or identifier of the topic guide, interview protocol, or discussion guide used for the qualitative data collection.',
    `translation_required` BOOLEAN COMMENT 'Indicates whether translation or interpretation services were required during the qualitative data collection.',
    `verbatim_quotes` STRING COMMENT 'Selected verbatim quotes from participants or key informants that illustrate key findings or themes. Confidential to protect participant identity.',
    CONSTRAINT pk_qualitative_record PRIMARY KEY(`qualitative_record_id`)
) COMMENT 'Qualitative data record from focus group discussions (FGD), key informant interviews (KII), or other qualitative methods. Includes participant demographics, themes, and verbatim quotes.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`mel`.`dhis2_aggregate_report` (
    `dhis2_aggregate_report_id` BIGINT COMMENT 'Unique identifier for the DHIS2 aggregate report record. Primary key for this entity.',
    `award_id` BIGINT COMMENT 'Foreign key reference to the grant or award that requires this reporting.',
    `intervention_id` BIGINT COMMENT 'Foreign key reference to the program or project that this aggregate report supports.',
    `org_unit_id` BIGINT COMMENT 'The DHIS2 organisation unit identifier representing the reporting entity (facility, district, region, country).',
    `partner_org_id` BIGINT COMMENT 'Foreign key linking to partnership.partner_org. Business justification: DHIS2 reports from partner-operated health facilities. Business need: partner health data reporting oversight, data quality monitoring, partner performance tracking in health sector programs.',
    `reporting_period_id` BIGINT COMMENT 'The DHIS2 period identifier representing the time dimension for this report (e.g., 202401 for January 2024, 2024Q1 for Q1 2024).',
    `user_account_id` BIGINT COMMENT 'The DHIS2 user identifier of the person who submitted or created this aggregate report.',
    `approval_date` DATE COMMENT 'The date when this aggregate report was approved by the designated authority in DHIS2.',
    `approval_status` STRING COMMENT 'The approval state of the report within the DHIS2 approval workflow, indicating whether the data has been validated and accepted.. Valid values are `not_submitted|pending|approved|rejected`',
    `approved_by` STRING COMMENT 'The name or identifier of the user or authority who approved this aggregate report in DHIS2.',
    `comments` STRING COMMENT 'Free-text comments or notes provided by the reporting user regarding this aggregate report, including explanations for anomalies or data quality issues.',
    `completeness_percentage` DECIMAL(18,2) COMMENT 'Percentage of required data elements that have been populated in this aggregate report (0-100).',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this aggregate report record was first created in the system.',
    `data_quality_flag` BOOLEAN COMMENT 'Categorical flag indicating the overall data quality assessment for this report.',
    `data_quality_score` DECIMAL(18,2) COMMENT 'Calculated data quality score for this report based on completeness, consistency, and validation rules (0-100 scale).',
    `data_set_name` STRING COMMENT 'Human-readable name of the DHIS2 data set (e.g., Monthly Health Facility Report, WASH Quarterly Indicators).',
    `dhis2_data_set_code` STRING COMMENT 'The DHIS2 data set identifier that defines the collection of indicators and data elements included in this report.',
    `indicator_count` STRING COMMENT 'Total number of indicators or data elements included in this aggregate report.',
    `integration_status` STRING COMMENT 'Status of the integration of this report from the field DHIS2 instance into the enterprise data lakehouse.. Valid values are `pending|integrated|failed|reconciled`',
    `integration_timestamp` TIMESTAMP COMMENT 'The timestamp when this aggregate report was successfully integrated into the enterprise lakehouse.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this aggregate report record was last updated or modified.',
    `report_identifier` STRING COMMENT 'The externally-known unique identifier or reference number for this aggregate report as assigned by DHIS2 or the reporting system.',
    `report_status` STRING COMMENT 'Current lifecycle status of the aggregate report in the DHIS2 workflow.. Valid values are `draft|submitted|approved|rejected|pending_review|completed`',
    `reporting_period_end_date` DATE COMMENT 'The end date of the reporting period covered by this aggregate report.',
    `reporting_period_start_date` DATE COMMENT 'The start date of the reporting period covered by this aggregate report.',
    `reporting_period_type` STRING COMMENT 'The frequency or granularity of the reporting period (daily, weekly, monthly, quarterly, annual).. Valid values are `daily|weekly|monthly|quarterly|annual`',
    `reporting_user_name` STRING COMMENT 'The name of the user who submitted this aggregate report.',
    `submission_date` DATE COMMENT 'The date when this aggregate report was submitted to DHIS2 by the reporting organisation unit.',
    `submission_timestamp` TIMESTAMP COMMENT 'The precise timestamp when this aggregate report was submitted to DHIS2, including time zone information.',
    `validation_rule_violations` STRING COMMENT 'Count of DHIS2 validation rule violations detected in this aggregate report.',
    CONSTRAINT pk_dhis2_aggregate_report PRIMARY KEY(`dhis2_aggregate_report_id`)
) COMMENT 'Aggregate data report synchronized from DHIS2 health information system, containing data set submissions, completeness metrics, and validation rule results. Systems-of-record: DHIS2 (primary), Kobo Toolbox (data collection). Framework: WHO Health Data Standards / IATI v2.03.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`mel`.`learning_agenda` (
    `learning_agenda_id` BIGINT COMMENT 'Unique identifier for the learning agenda record. Primary key for the learning agenda entity.',
    `award_id` BIGINT COMMENT 'Reference to the grant or funding award associated with this learning agenda, if applicable. Links to grant master data.',
    `capacity_building_plan_id` BIGINT COMMENT 'Foreign key linking to partnership.capacity_building_plan. Business justification: Learning questions drive capacity building interventions. Business need: evidence-based capacity building, learning-to-action linkage, capacity building effectiveness measurement.',
    `intervention_id` BIGINT COMMENT 'Reference to the program or strategic period to which this learning agenda applies. Links to the program master data.',
    `evaluation_id` BIGINT COMMENT 'Reference to a formal evaluation, impact assessment, or research study that will address this learning question. Links to evaluation master data.',
    `indicator_id` BIGINT COMMENT 'Reference to the Key Performance Indicator (KPI) or Logical Framework (LogFrame) indicator that this learning question is designed to inform or validate. Links to indicator library.',
    `mel_logframe_id` BIGINT COMMENT 'Foreign key linking to mel.mel_logframe. Business justification: Learning questions are often tied to specific components of the logframe/theory of change. This FK establishes which logframe component the learning question addresses. The STRING field linked_toc_com',
    `partner_org_id` BIGINT COMMENT 'Foreign key linking to partnership.partner_org. Business justification: Learning questions focus on partner capacity, localization effectiveness, partnership models. Business need: partnership effectiveness research, capacity building evidence generation, localization str',
    `plan_id` BIGINT COMMENT 'Foreign key linking to communication.communication_plan. Business justification: Learning questions shape external communication strategies. Learning agenda findings and knowledge products require dissemination plans targeting practitioners, donors, and policy audiences - operatio',
    `staff_member_id` BIGINT COMMENT 'Reference to the staff member or organizational role accountable for ensuring this learning question is addressed within the defined timeline. Links to workforce or staff master data.',
    `actual_completion_date` DATE COMMENT 'Actual date when evidence generation and analysis for this learning question was completed. Used for performance tracking and lessons learned.',
    `actual_start_date` DATE COMMENT 'Actual date when evidence generation activities for this learning question commenced. Used for tracking progress against planned timeline.',
    `budget_allocated` DECIMAL(18,2) COMMENT 'Financial resources allocated to evidence generation activities for this learning question. Expressed in the organizations base currency. Supports Budget versus Actual (BvA) tracking.',
    `budget_spent` DECIMAL(18,2) COMMENT 'Actual financial expenditure incurred for evidence generation activities related to this learning question. Used for Budget versus Actual (BvA) analysis and financial stewardship.',
    `collaboration_partners` STRING COMMENT 'Names or identifiers of external partners, Civil Society Organizations (CSO), Community-Based Organizations (CBO), or research institutions collaborating on evidence generation for this learning question.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this learning agenda record was first created in the system. Supports audit trail and data lineage.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for budget and expenditure amounts. Ensures consistent financial reporting across multi-currency operations.. Valid values are `^[A-Z]{3}$`',
    `data_quality_assurance_plan` STRING COMMENT 'Description of quality assurance measures, validation protocols, and data quality checks planned for evidence generation. Ensures reliability and credibility of findings.',
    `data_source` STRING COMMENT 'Description of the primary data source or system from which evidence will be collected. May reference District Health Information System 2 (DHIS2), KoboToolbox, beneficiary surveys, or other operational systems.',
    `dissemination_plan` STRING COMMENT 'Description of how findings and lessons learned will be shared with stakeholders, including donors, partners, and internal teams. Supports knowledge management and organizational learning.',
    `donor_reporting_requirement` BOOLEAN COMMENT 'Indicates whether this learning question is explicitly required by a donor or funding agreement. True if mandated by donor conditions, false otherwise.',
    `ethics_approval_date` DATE COMMENT 'Date when ethics approval or institutional review board clearance was granted for evidence generation activities. Null if not required or not yet obtained.',
    `ethics_approval_required` BOOLEAN COMMENT 'Indicates whether formal ethics review or institutional review board approval is required for the evidence generation activities associated with this learning question. True if ethics approval needed, false otherwise.',
    `evidence_generation_method` STRING COMMENT 'Primary methodology or data collection approach planned to answer this learning question. Includes Focus Group Discussion (FGD), Key Informant Interview (KII), Post-Distribution Monitoring (PDM), and other Monitoring Evaluation and Learning (MEL) methods. [ENUM-REF-CANDIDATE: quantitative_survey|qualitative_interview|focus_group_discussion|key_informant_interview|post_distribution_monitoring|case_study|mixed_methods|secondary_data_analysis|participatory_assessment — 9 candidates stripped; promote to reference product]',
    `findings_summary` STRING COMMENT 'High-level summary of key findings, insights, or answers generated in response to this learning question. Populated upon completion of evidence generation and analysis.',
    `geographic_scope` STRING COMMENT 'Geographic area or operational context where evidence generation activities will take place. May reference country offices, project sites, or regions aligned with Office for the Coordination of Humanitarian Affairs (OCHA) classifications.',
    `last_modified_by` STRING COMMENT 'Username or identifier of the staff member who last updated this learning agenda record. Supports change tracking and accountability.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this learning agenda record was last modified. Supports audit trail and version control.',
    `learning_agenda_status` STRING COMMENT 'Current lifecycle status of this learning agenda item. Tracks progression from planning through evidence generation to completion. Supports Monitoring Evaluation Accountability and Learning (MEAL) accountability. [ENUM-REF-CANDIDATE: draft|approved|in_progress|data_collection|analysis|completed|on_hold|cancelled — 8 candidates stripped; promote to reference product]',
    `learning_question_identifier` STRING COMMENT 'Externally-known unique code or number assigned to this learning question for tracking and reporting purposes. Format: LQ- followed by alphanumeric code.. Valid values are `^LQ-[A-Z0-9]{6,12}$`',
    `learning_question_text` STRING COMMENT 'The full text of the priority learning question or knowledge gap that this agenda item seeks to address. Defines the core inquiry driving evidence generation.',
    `learning_question_type` STRING COMMENT 'Classification of the learning question based on the Development Assistance Committee (DAC) evaluation criteria or Results-Based Management (RBM) framework. Indicates the dimension of program performance being examined.. Valid values are `process|outcome|impact|efficiency|relevance|sustainability`',
    `planned_completion_date` DATE COMMENT 'Target date by which evidence generation and analysis for this learning question should be completed. Critical for adaptive management and donor reporting cycles.',
    `planned_start_date` DATE COMMENT 'Planned date when evidence generation activities for this learning question will begin. Aligns with program cycle or strategic period timeline.',
    `priority_level` STRING COMMENT 'Relative priority or urgency assigned to this learning question within the overall learning agenda. Informs resource allocation and sequencing decisions.. Valid values are `critical|high|medium|low`',
    `rationale` STRING COMMENT 'Detailed explanation of why this learning question is a priority, including the evidence gap, strategic importance, and expected contribution to adaptive management or organizational learning.',
    `recommendations` STRING COMMENT 'Actionable recommendations or programmatic adjustments proposed based on the evidence generated. Supports adaptive management and continuous improvement.',
    `responsible_team` STRING COMMENT 'Name or identifier of the organizational unit, department, or team responsible for generating evidence and answering this learning question. May reference Monitoring Evaluation and Learning (MEL) team, program team, or research unit.',
    `sdg_alignment` STRING COMMENT 'Reference to the United Nations Sustainable Development Goal(s) (SDG) that this learning question contributes to or informs. Supports global development reporting.',
    `target_population` STRING COMMENT 'Description of the population, stakeholder group, or unit of analysis from which evidence will be collected. May include beneficiaries, Persons of Concern (PoC), Internally Displaced Persons (IDP), community members, or program staff.',
    `created_by` STRING COMMENT 'Username or identifier of the staff member who created this learning agenda record. Supports audit trail and accountability.',
    CONSTRAINT pk_learning_agenda PRIMARY KEY(`learning_agenda_id`)
) COMMENT 'Structured learning questions and evidence generation plans that guide adaptive management and knowledge production across programs.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`mel`.`data_collection_tool` (
    `data_collection_tool_id` BIGINT COMMENT 'Unique identifier for the data collection tool. Primary key.',
    `assessment_id` BIGINT COMMENT 'Foreign key linking to field.assessment. Business justification: Data collection tools are deployed in specific assessments. Essential for tool version control, data quality audits, and linking assessment responses to the correct tool version. Assessment has unlink',
    `role_id` BIGINT COMMENT 'Foreign key linking to volunteer.volunteer_role. Business justification: Data collection tools specify which volunteer roles are authorized to administer them (e.g., community health workers for health surveys, enumerators for household surveys). Required for training plan',
    `award_id` BIGINT COMMENT 'Identifier of the grant funding the use of this data collection tool.',
    `budget_line_id` BIGINT COMMENT 'Foreign key linking to finance.budget_line. Business justification: Tool development, software licensing (KoBoToolbox, ODK, SurveyCTO), and deployment costs are budgeted line items. Procurement requisitions for data collection tools and services reference specific bud',
    `capacity_assessment_id` BIGINT COMMENT 'Foreign key linking to partnership.capacity_assessment. Business justification: Capacity assessment tools are a type of data collection tool. Business need: assessment standardization, tool version control, methodology documentation.',
    `intervention_id` BIGINT COMMENT 'Identifier of the program to which this data collection tool is linked.',
    `meal_plan_id` BIGINT COMMENT 'Foreign key linking to mel.meal_plan. Business justification: Data collection tools (KoboToolbox forms, CommCare modules) are designed and deployed as part of MEAL plans. This FK links the tool to the MEAL plan it serves, enabling tracking of MEAL plan data coll',
    `partner_org_id` BIGINT COMMENT 'Foreign key linking to partnership.partner_org. Business justification: Tools deployed by/for partners in sub-award contexts. Business need: partner data collection coordination, tool standardization across partners, data quality protocol enforcement.',
    `staff_member_id` BIGINT COMMENT 'Identifier of the staff member who approved the data collection tool.',
    `program_logframe_id` BIGINT COMMENT 'Identifier of the LogFrame (Logical Framework) to which this tool is aligned.',
    `risk_assessment_id` BIGINT COMMENT 'Foreign key linking to safeguarding.risk_assessment. Business justification: Data collection tools (surveys, FGDs, KIIs) involving beneficiaries require safeguarding risk assessments to identify risks (power dynamics, retraumatization, child safeguarding) and embed mitigation.',
    `system_platform_id` BIGINT COMMENT 'Foreign key linking to technology.system_platform. Business justification: Tools are deployed on specific platforms (KoboToolbox, CommCare, ODK). Essential for platform licensing management, integration configuration, deployment planning, and troubleshooting data collection ',
    `additional_languages` STRING COMMENT 'Comma-separated list of ISO 639 language codes for additional languages supported by the tool.',
    `approval_date` DATE COMMENT 'Date on which the data collection tool was approved for deployment.',
    `approval_status` STRING COMMENT 'Current approval status of the data collection tool by MEL or program management.. Valid values are `pending|approved|rejected|revision_required`',
    `consent_mechanism` STRING COMMENT 'Method by which informed consent is obtained from respondents using this tool.. Valid values are `verbal|written|digital_signature|none`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this data collection tool record was first created in the system.',
    `data_collection_method` STRING COMMENT 'Primary methodology employed by this tool. FGD (Focus Group Discussion), PDM (Post-Distribution Monitoring). [ENUM-REF-CANDIDATE: survey|interview|fgd|observation|pdm|assessment|other — 7 candidates stripped; promote to reference product]',
    `data_protection_compliance` STRING COMMENT 'Data protection and privacy framework to which this tool adheres. GDPR (General Data Protection Regulation), DPA (Data Protection Act), CHS (Core Humanitarian Standard).. Valid values are `gdpr|local_dpa|chs|none|other`',
    `data_quality_validation_rules` STRING COMMENT 'Description or reference to validation rules embedded in the tool to ensure data quality at point of collection.',
    `deployment_end_date` DATE COMMENT 'Date on which the data collection tool was retired or deactivated from field use.',
    `deployment_start_date` DATE COMMENT 'Date on which the data collection tool was first deployed or made active in the field.',
    `estimated_completion_time_minutes` STRING COMMENT 'Expected time in minutes required to complete the data collection tool.',
    `ethical_review_status` STRING COMMENT 'Status of ethical review or institutional review board (IRB) approval for the data collection tool.. Valid values are `not_required|pending|approved|exempt`',
    `external_tool_url` STRING COMMENT 'URL or hyperlink to the external platform where the tool is hosted or accessed.',
    `geographic_scope` STRING COMMENT 'Geographic deployment scope of the tool, such as country, region, or project site identifiers.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this data collection tool record was last updated or modified.',
    `linked_indicator_ids` STRING COMMENT 'Comma-separated list of indicator IDs that this tool is designed to measure or collect data for.',
    `notes` STRING COMMENT 'Additional free-text notes or comments about the data collection tool.',
    `primary_language` STRING COMMENT 'ISO 639 language code for the primary language of the data collection tool.. Valid values are `^[a-z]{2,3}$`',
    `question_count` STRING COMMENT 'Total number of questions or data fields in the collection tool.',
    `respondent_type` STRING COMMENT 'Classification of the target respondent or data subject for this collection tool. [ENUM-REF-CANDIDATE: beneficiary|household|community_leader|key_informant|staff|partner|other — 7 candidates stripped; promote to reference product]',
    `revision_reason` STRING COMMENT 'Explanation or justification for the most recent revision or version update of the tool.',
    `tool_code` STRING COMMENT 'Unique business identifier code for the data collection tool, used for external reference and integration.. Valid values are `^[A-Z0-9]{6,20}$`',
    `tool_documentation_url` STRING COMMENT 'URL or reference to documentation, user guides, or training materials for the data collection tool.',
    `tool_name` STRING COMMENT 'Human-readable name of the data collection tool or instrument.',
    `tool_status` STRING COMMENT 'Current lifecycle status of the data collection tool.. Valid values are `draft|under_review|approved|active|retired|archived`',
    `tool_type` STRING COMMENT 'Classification of the data collection tool by format and platform.. Valid values are `kobo_form|odk_form|commcare_module|dhis2_form|paper_survey|interview_guide`',
    `version_number` STRING COMMENT 'Version identifier of the data collection tool following semantic versioning convention.. Valid values are `^[0-9]+.[0-9]+(.[0-9]+)?$`',
    CONSTRAINT pk_data_collection_tool PRIMARY KEY(`data_collection_tool_id`)
) COMMENT 'Definition of a data collection instrument (survey, form, checklist) deployed via Kobo Toolbox, ODK, or other platforms. Includes versioning, language support, and ethical review status.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`mel`.`mel_needs_assessment` (
    `mel_needs_assessment_id` BIGINT COMMENT 'Unique identifier for the needs assessment record. Primary key.',
    `advocacy_campaign_id` BIGINT COMMENT 'Foreign key linking to communication.advocacy_campaign. Business justification: Needs assessment data drives advocacy campaign targeting and messaging. GAM rates, unmet needs, and vulnerability data inform advocacy priorities and campaign design - direct operational link between ',
    `award_id` BIGINT COMMENT 'Reference to the grant or funding source that financed this needs assessment.',
    `country_office_id` BIGINT COMMENT 'Reference to the country office or field office responsible for conducting the needs assessment.',
    `crisis_communication_id` BIGINT COMMENT 'Foreign key linking to communication.crisis_communication. Business justification: Emergency needs assessments trigger crisis communications activation. Rapid assessments showing acute needs or deteriorating conditions initiate donor alerts, media engagement, and emergency appeals -',
    `intervention_id` BIGINT COMMENT 'Reference to the program or project that commissioned or will use this needs assessment to inform design and resource allocation.',
    `partner_org_id` BIGINT COMMENT 'Foreign key linking to partnership.partner_org. Business justification: Assessments conducted by or with partners. Business need: partner capacity assessment, joint needs analysis, partnership scope definition, sub-award design.',
    `staff_member_id` BIGINT COMMENT 'Reference to the staff member who led the needs assessment field team and is responsible for data quality.',
    `admin_level_1` STRING COMMENT 'First-level administrative division (e.g., state, province, region) where the assessment was conducted.',
    `admin_level_2` STRING COMMENT 'Second-level administrative division (e.g., district, county) where the assessment was conducted.',
    `assessment_code` STRING COMMENT 'Externally-known unique business identifier for the needs assessment, used in donor reports and field communications.. Valid values are `^[A-Z0-9]{6,20}$`',
    `assessment_end_date` DATE COMMENT 'Date when field data collection for the needs assessment was completed.',
    `assessment_name` STRING COMMENT 'Human-readable name or title of the needs assessment.',
    `assessment_start_date` DATE COMMENT 'Date when field data collection for the needs assessment began.',
    `assessment_status` STRING COMMENT 'Current lifecycle status of the needs assessment. Planned indicates scheduled but not started; in_progress indicates field data collection underway; completed indicates data collection finished; validated indicates findings reviewed and approved; cancelled indicates assessment was terminated.. Valid values are `planned|in_progress|completed|validated|cancelled`',
    `assessment_type` STRING COMMENT 'Classification of the needs assessment methodology and scope. Rapid assessments are quick field surveys; comprehensive assessments are in-depth multi-sector analyses; sectoral assessments focus on one domain (WASH, health, nutrition); baseline and endline assessments measure program impact at start and end.. Valid values are `rapid|comprehensive|sectoral|multi_sectoral|baseline|endline`',
    `country_code` STRING COMMENT 'ISO 3166-1 alpha-3 country code for the primary country where the needs assessment was conducted.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the needs assessment record was first created in the system.',
    `dac_sector_code` STRING COMMENT 'OECD Development Assistance Committee 5-digit sector code classifying the primary sector focus of the needs assessment (e.g., 12240 for Basic Nutrition, 14030 for Basic Water Supply).. Valid values are `^[0-9]{5}$`',
    `data_collection_method` STRING COMMENT 'Primary method(s) used to collect needs assessment data (e.g., household surveys, Key Informant Interviews (KII), Focus Group Discussions (FGD), direct observation, secondary data review). [ENUM-REF-CANDIDATE: household_survey|kii|fgd|direct_observation|secondary_data|mobile_data_collection|remote_sensing — promote to reference product]',
    `data_collection_tool` STRING COMMENT 'Name or identifier of the digital or paper tool used for data collection (e.g., KoboToolbox form ID, ODK survey name, paper questionnaire version).',
    `education_needs_priority` STRING COMMENT 'Priority ranking of education and learning needs identified in the assessment.. Valid values are `critical|high|medium|low|not_assessed`',
    `external_report_url` STRING COMMENT 'URL link to the published needs assessment report or dataset on external platforms (e.g., Humanitarian Data Exchange, ReliefWeb, organizational website).',
    `gam_rate_percentage` DECIMAL(18,2) COMMENT 'Percentage of children under 5 years with Global Acute Malnutrition (weight-for-height Z-score < -2 or Mid-Upper Arm Circumference (MUAC) < 125mm or bilateral pitting edema) identified in the assessment. GAM rates above 15% indicate a critical nutrition emergency.',
    `geographic_scope` STRING COMMENT 'Textual description of the geographic area covered by the needs assessment (e.g., district names, province, refugee camp, urban settlement).',
    `health_needs_priority` STRING COMMENT 'Priority ranking of health service and medical needs identified in the assessment.. Valid values are `critical|high|medium|low|not_assessed`',
    `households_assessed` STRING COMMENT 'Total number of households surveyed or included in the needs assessment sample.',
    `key_findings_summary` STRING COMMENT 'Executive summary of the most critical findings and needs identified in the assessment, used for donor reporting and program design.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the needs assessment record was last updated in the system.',
    `muac_screening_count` STRING COMMENT 'Number of children screened using Mid-Upper Arm Circumference (MUAC) measurement during the needs assessment.',
    `notes` STRING COMMENT 'Additional contextual notes, caveats, or operational constraints relevant to the needs assessment (e.g., access limitations, security incidents during data collection, data quality issues).',
    `nutrition_needs_priority` STRING COMMENT 'Priority ranking of nutrition and food security needs identified in the assessment.. Valid values are `critical|high|medium|low|not_assessed`',
    `population_assessed` STRING COMMENT 'Total number of individuals in the target population covered by the needs assessment.',
    `protection_needs_priority` STRING COMMENT 'Priority ranking of protection needs including Gender-Based Violence (GBV), child protection, and psychosocial support identified in the assessment.. Valid values are `critical|high|medium|low|not_assessed`',
    `recommendations` STRING COMMENT 'Programmatic recommendations and proposed interventions based on the needs assessment findings.',
    `sam_rate_percentage` DECIMAL(18,2) COMMENT 'Percentage of children under 5 years with Severe Acute Malnutrition (weight-for-height Z-score < -3 or MUAC < 115mm or bilateral pitting edema) identified in the assessment. SAM rates above 2% indicate a critical nutrition emergency.',
    `sample_size` STRING COMMENT 'Number of respondents or data points collected during the needs assessment.',
    `sampling_method` STRING COMMENT 'Statistical sampling methodology used to select respondents for the needs assessment.. Valid values are `random|stratified|cluster|purposive|convenience|census`',
    `sdg_alignment` STRING COMMENT 'Comma-separated list of United Nations Sustainable Development Goal (SDG) numbers that this needs assessment informs (e.g., SDG 1 No Poverty, SDG 2 Zero Hunger, SDG 6 Clean Water and Sanitation).',
    `shelter_needs_priority` STRING COMMENT 'Priority ranking of shelter and housing needs identified in the assessment.. Valid values are `critical|high|medium|low|not_assessed`',
    `validation_date` DATE COMMENT 'Date when the needs assessment findings were validated and approved for use in program design and donor reporting.',
    `validation_status` STRING COMMENT 'Status of the needs assessment data validation and quality assurance review process.. Valid values are `pending|validated|rejected|under_review`',
    `wash_needs_priority` STRING COMMENT 'Priority ranking of Water, Sanitation, and Hygiene needs identified in the assessment. Critical indicates immediate life-threatening gaps; high indicates urgent but not immediately life-threatening; medium and low indicate longer-term development needs.. Valid values are `critical|high|medium|low|not_assessed`',
    CONSTRAINT pk_mel_needs_assessment PRIMARY KEY(`mel_needs_assessment_id`)
) COMMENT 'Multi-sector needs assessment measuring humanitarian needs across WASH, health, nutrition, education, shelter, and protection sectors. Distinct from beneficiary-level needs assessment.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`mel`.`data_quality_assessment` (
    `data_quality_assessment_id` BIGINT COMMENT 'Unique identifier for the data quality assessment record. Primary key for the data quality assessment entity.',
    `audit_finding_id` BIGINT COMMENT 'Foreign key linking to compliance.audit_finding. Business justification: Data quality assessments are frequently conducted in direct response to audit findings that question the accuracy, completeness, or timeliness of reported MEL data. This link enables tracking which DQ',
    `award_id` BIGINT COMMENT 'Reference to the grant or award associated with this data quality assessment.',
    `capacity_assessment_id` BIGINT COMMENT 'Foreign key linking to partnership.capacity_assessment. Business justification: DQAs inform partner capacity scores, especially MEL capacity domain. Business need: capacity assessment validation, MEL score calibration, risk rating evidence.',
    `data_collection_tool_id` BIGINT COMMENT 'Foreign key linking to mel.data_collection_tool. Business justification: Data Quality Assessments audit the quality of data collected through specific tools (KoboToolbox, ODK, CommCare, DHIS2 forms). The data_source_audited field is currently a STRING, but should be normal',
    `volunteer_id` BIGINT COMMENT 'Foreign key linking to volunteer.volunteer. Business justification: DQA audits data collected by volunteers, must track collector identity for accountability, corrective action targeting, and retraining decisions. Essential for volunteer data quality management and do',
    `field_monitoring_visit_id` BIGINT COMMENT 'Foreign key linking to partnership.field_monitoring_visit. Business justification: DQAs conducted during field monitoring visits. Business need: on-site data verification, partner oversight, spot-check DQA execution.',
    `followup_data_quality_assessment_id` BIGINT COMMENT 'Self-referencing FK on data_quality_assessment (followup_data_quality_assessment_id)',
    `goods_receipt_id` BIGINT COMMENT 'Foreign key linking to supply.goods_receipt. Business justification: DQA audits verify distribution data accuracy by tracing to source documents including goods receipts. When auditing did we distribute what we reported?, assessors link DQA records to specific receip',
    `indicator_id` BIGINT COMMENT 'Reference to the specific MEL indicator that was reviewed or audited during this data quality assessment.',
    `intervention_id` BIGINT COMMENT 'Reference to the program under which this data quality assessment was conducted.',
    `meal_plan_id` BIGINT COMMENT 'Foreign key linking to mel.meal_plan. Business justification: Data Quality Assessments (DQAs) are conducted as part of MEAL plan implementation to verify data quality protocols. This FK links the DQA to the MEAL plan under which it was conducted, enabling tracki',
    `partner_org_id` BIGINT COMMENT 'Foreign key linking to partnership.partner_org. Business justification: DQAs audit partner-reported data. Business need: partner data quality oversight, fiduciary risk management, partner performance scoring, enhanced monitoring triggers.',
    `partner_performance_review_id` BIGINT COMMENT 'Foreign key linking to partnership.partner_performance_review. Business justification: DQA results feed into partner performance ratings. Business need: performance review evidence base, reporting compliance scoring, data quality rating component.',
    `partner_report_submission_id` BIGINT COMMENT 'Foreign key linking to partnership.partner_report_submission. Business justification: DQAs validate data in partner reports. Business need: report acceptance decision, data quality scoring, verification evidence for donor reporting.',
    `staff_member_id` BIGINT COMMENT 'Reference to the staff member who conducted or led the data quality assessment.',
    `project_site_id` BIGINT COMMENT 'Reference to the specific project site or field location where the data quality assessment was conducted.',
    `reviewer_staff_staff_member_id` BIGINT COMMENT 'Reference to the staff member who reviewed or approved the data quality assessment findings.',
    `single_audit_id` BIGINT COMMENT 'Foreign key linking to compliance.single_audit. Business justification: DQAs are often required as part of single audit preparation (to verify data before auditor testing) or follow-up (to address audit findings). This link enables tracking DQA activities within the singl',
    `accuracy_score_percentage` DECIMAL(18,2) COMMENT 'The percentage score representing the accuracy of the data assessed, calculated as the proportion of verified records that matched source documentation.',
    `assessment_code` STRING COMMENT 'Business identifier or reference code for the data quality assessment, used for external tracking and reporting.',
    `assessment_date` DATE COMMENT 'The date on which the data quality assessment was conducted or completed. Principal business event timestamp for the assessment.',
    `assessment_end_date` DATE COMMENT 'The date when the data quality assessment activities concluded.',
    `assessment_start_date` DATE COMMENT 'The date when the data quality assessment activities began.',
    `assessment_status` STRING COMMENT 'Current lifecycle status of the data quality assessment (e.g., planned, in progress, completed, reviewed, approved, cancelled).. Valid values are `planned|in_progress|completed|reviewed|approved|cancelled`',
    `assessment_type` STRING COMMENT 'Type or category of data quality assessment conducted (e.g., routine DQA, RDQA, spot-check, comprehensive audit, verification, triangulation). [ENUM-REF-CANDIDATE: routine_dqa|rdqa|spot_check|comprehensive_audit|verification|triangulation|baseline_dqa — 7 candidates stripped; promote to reference product]',
    `assessor_name` STRING COMMENT 'The full name of the staff member or consultant who conducted the data quality assessment.',
    `assessor_organization` STRING COMMENT 'The name of the organization or unit to which the assessor belongs (e.g., internal MEL team, external auditor, donor verification team).',
    `completeness_score_percentage` DECIMAL(18,2) COMMENT 'The percentage score representing the completeness of the data assessed, calculated as the proportion of required fields that were populated.',
    `consistency_score_percentage` DECIMAL(18,2) COMMENT 'The percentage score representing the consistency of the data assessed, calculated as the proportion of records that were internally consistent and aligned across systems.',
    `corrective_action_completion_date` DATE COMMENT 'The actual date when corrective actions were completed.',
    `corrective_action_due_date` DATE COMMENT 'The target date by which corrective actions should be completed.',
    `corrective_action_status` STRING COMMENT 'Current status of the implementation of corrective actions (e.g., not started, in progress, completed, verified, overdue).. Valid values are `not_started|in_progress|completed|verified|overdue`',
    `corrective_actions` STRING COMMENT 'Detailed description of the corrective actions recommended or taken to address the data quality issues identified during the assessment.',
    `country_code` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country code representing the country where the data quality assessment was conducted.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this data quality assessment record was first created in the system.',
    `dac_criteria_assessed` STRING COMMENT 'The DAC evaluation criteria that were assessed during the data quality review (e.g., relevance, effectiveness, efficiency, impact, sustainability, coherence).',
    `data_source_type` STRING COMMENT 'The type or category of the data source audited (e.g., DHIS2, KoboToolbox, CommCare, field register, paper form, Excel, ERP, CRM). [ENUM-REF-CANDIDATE: dhis2|kobo|commcare|field_register|paper_form|excel|erp|crm|other — 9 candidates stripped; promote to reference product]',
    `discrepancy_count` STRING COMMENT 'The total number of discrepancies or errors identified during the data quality assessment.',
    `discrepancy_findings` STRING COMMENT 'Detailed narrative description of the discrepancies, errors, or data quality issues identified during the assessment.',
    `donor_reporting_requirement` STRING COMMENT 'Indicates whether this data quality assessment was conducted to meet a specific donor reporting or verification requirement (e.g., USAID DQA, Global Fund LFA, DFID verification, BHA audit).. Valid values are `usaid_dqa|global_fund_lfa|dfid_verification|bha_audit|other|none`',
    `geographic_scope` STRING COMMENT 'Description of the geographic scope or coverage area of the data quality assessment (e.g., national, regional, district, project site).',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this data quality assessment record was last updated or modified in the system.',
    `notes` STRING COMMENT 'Additional notes, comments, or contextual information related to the data quality assessment.',
    `overall_dqa_score_percentage` DECIMAL(18,2) COMMENT 'The overall composite data quality score, typically calculated as a weighted average of accuracy, completeness, timeliness, and consistency scores.',
    `priority_level` STRING COMMENT 'The priority level assigned to the data quality issues identified, indicating the urgency of corrective actions (e.g., critical, high, medium, low).. Valid values are `critical|high|medium|low`',
    `records_verified` STRING COMMENT 'The total number of records that were successfully verified during the assessment.',
    `report_url` STRING COMMENT 'The URL or file path to the full data quality assessment report document.',
    `review_date` DATE COMMENT 'The date when the data quality assessment findings were reviewed or approved.',
    `root_cause_analysis` STRING COMMENT 'Analysis of the underlying root causes of the data quality issues identified, including systemic, process, or capacity-related factors.',
    `sample_size` STRING COMMENT 'The number of records, cases, or data points sampled and reviewed during the data quality assessment.',
    `timeliness_score_percentage` DECIMAL(18,2) COMMENT 'The percentage score representing the timeliness of the data assessed, calculated as the proportion of records submitted or updated within required timeframes.',
    `verification_method` STRING COMMENT 'The method used to verify data quality during the assessment (e.g., spot-check, recount, triangulation, source document review, system audit, beneficiary interview, observation). [ENUM-REF-CANDIDATE: spot_check|recount|triangulation|source_document_review|system_audit|beneficiary_interview|observation — 7 candidates stripped; promote to reference product]',
    CONSTRAINT pk_data_quality_assessment PRIMARY KEY(`data_quality_assessment_id`)
) COMMENT 'Systematic assessment of data quality dimensions (accuracy, completeness, consistency, timeliness) for indicator data, with corrective action tracking.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`mel`.`reporting_period` (
    `reporting_period_id` BIGINT COMMENT 'Primary key for reporting_period',
    `mel_logframe_id` BIGINT COMMENT 'Reference to the specific version of the Logical Framework (LogFrame) that is active during this reporting period. Ensures indicator targets and actuals are measured against the correct framework version.',
    `parent_reporting_period_id` BIGINT COMMENT 'Reference to a parent reporting period for hierarchical period structures (e.g., monthly periods rolling up to quarterly periods, quarterly to annual). Null for top-level periods.',
    `primary_prior_reporting_period_id` BIGINT COMMENT 'Self-referencing FK on reporting_period (prior_reporting_period_id)',
    `user_account_id` BIGINT COMMENT 'Reference to the user who created this reporting period record. Used for accountability and audit purposes.',
    `reporting_modified_by_user_user_account_id` BIGINT COMMENT 'Reference to the user who last modified this reporting period record. Used for accountability and audit purposes.',
    `reporting_user_account_id` BIGINT COMMENT 'Reference to the user who officially closed and locked this reporting period. Null if the period has not been closed.',
    `baseline_period_flag` BOOLEAN COMMENT 'Indicates whether this reporting period represents a baseline measurement period for program indicators (True) or not (False). Baseline periods establish the starting point for impact measurement.',
    `calendar_year` STRING COMMENT 'The calendar year in which the reporting period falls, used for temporal analysis and trend reporting.',
    `closed_date` DATE COMMENT 'The date on which the reporting period was officially closed and locked for further data entry. Null if the period is still open or in draft status.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this reporting period record was first created in the system. Used for audit trail and data lineage tracking.',
    `dac_criteria_focus` STRING COMMENT 'The primary DAC evaluation criteria focus for this period (e.g., Relevance, Effectiveness, Efficiency, Impact, Sustainability, Coherence). Multiple criteria may be listed as comma-separated values.',
    `data_collection_deadline` DATE COMMENT 'The deadline date by which all data collection activities for this reporting period must be completed. Used for MEL workflow management.',
    `data_quality_audit_flag` BOOLEAN COMMENT 'Indicates whether a data quality audit or verification exercise is scheduled for this reporting period (True) or not (False). Ensures data integrity and reliability.',
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
    `notes` STRING COMMENT 'Free-text field for additional notes, comments, or contextual information about the reporting period, including any anomalies, challenges, or special circumstances affecting data collection.',
    `pdm_cycle_flag` BOOLEAN COMMENT 'Indicates whether this reporting period includes a Post-Distribution Monitoring (PDM) cycle for assessing the effectiveness and impact of distributed aid (True) or not (False).',
    `period_code` STRING COMMENT 'Business identifier code for the reporting period, used in external communications and donor reports (e.g., Q1-2024, FY2024, JAN2024).',
    `period_description` STRING COMMENT 'Detailed description of the reporting period, including any special characteristics, contextual information, or notes about data collection activities during this period.',
    `period_name` STRING COMMENT 'Human-readable name or label for the reporting period (e.g., First Quarter 2024, January 2024, Fiscal Year 2024).',
    `period_status` STRING COMMENT 'Current lifecycle status of the reporting period (draft: not yet started, active: currently open for data collection, closed: finalized and locked, archived: historical record).',
    `period_type` STRING COMMENT 'Classification of the reporting period by its duration or frequency (daily, weekly, monthly, quarterly, semi-annual, annual, or custom).',
    `quarter_number` STRING COMMENT 'The quarter number (1-4) within the fiscal or calendar year, applicable for quarterly reporting periods. Null for non-quarterly periods.',
    `report_submission_deadline` DATE COMMENT 'The deadline date by which the final report for this period must be submitted to donors or stakeholders. Critical for compliance with donor agreements.',
    `reporting_frequency` STRING COMMENT 'The frequency at which data is expected to be reported during this period, aligned with donor requirements and MEL framework schedules.',
    `start_date` DATE COMMENT 'The first date of the reporting period when data collection and monitoring activities begin.',
    `week_number` STRING COMMENT 'The ISO week number (1-53) within the year, applicable for weekly reporting periods. Null for non-weekly periods.',
    CONSTRAINT pk_reporting_period PRIMARY KEY(`reporting_period_id`)
) COMMENT 'Time period definition for MEL reporting cycles (monthly, quarterly, annual) with DHIS2 period codes and donor reporting alignment.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`mel`.`geographic_scope` (
    `geographic_scope_id` BIGINT COMMENT 'Primary key for geographic_scope',
    `org_unit_id` BIGINT COMMENT 'External identifier for this geographic scope in the DHIS2 health information system, used for health indicator reporting.',
    `parent_geographic_scope_id` BIGINT COMMENT 'Self-referencing FK on geographic_scope (parent_geographic_scope_id)',
    `parent_scope_id` BIGINT COMMENT 'Reference to the parent geographic scope in the hierarchy (e.g., a district scope references its parent provincial scope).',
    `administrative_level` STRING COMMENT 'Numeric administrative hierarchy level (0=global, 1=regional, 2=national, 3=subnational, 4=provincial, 5=district, 6=municipal, 7=community).',
    `area_square_km` DECIMAL(18,2) COMMENT 'Total land area of the geographic scope in square kilometers.',
    `boundary_definition` STRING COMMENT 'Textual description or reference to the official boundary definition for this geographic scope.',
    `community_name` STRING COMMENT 'Name of the local community, village, or neighborhood where program activities are implemented.',
    `conflict_affected_flag` BOOLEAN COMMENT 'Indicates whether this geographic scope is classified as conflict-affected or fragile (True/False).',
    `country_code` STRING COMMENT 'Three-letter ISO country code for the primary country of this geographic scope (e.g., USA, GBR, KEN).',
    `country_name` STRING COMMENT 'Full name of the country associated with this geographic scope.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this geographic scope record was first created in the system.',
    `data_source` STRING COMMENT 'Source system or authority from which this geographic scope definition was obtained (e.g., National Mapping Agency, OCHA COD-AB).',
    `disaster_prone_flag` BOOLEAN COMMENT 'Indicates whether this geographic scope is classified as disaster-prone (True/False).',
    `district_name` STRING COMMENT 'Name of the district or county within the region.',
    `effective_end_date` DATE COMMENT 'Date on which this geographic scope definition ceased to be effective (null for currently active scopes).',
    `effective_start_date` DATE COMMENT 'Date from which this geographic scope definition became effective for program operations and MEL reporting.',
    `hard_to_reach_flag` BOOLEAN COMMENT 'Indicates whether this geographic scope is classified as hard-to-reach due to infrastructure, security, or access constraints (True/False).',
    `last_verified_date` DATE COMMENT 'Date when the geographic scope definition was last verified or validated against authoritative sources.',
    `latitude` DECIMAL(18,2) COMMENT 'Geographic latitude coordinate of the scope centroid in decimal degrees (WGS84).',
    `longitude` DECIMAL(18,2) COMMENT 'Geographic longitude coordinate of the scope centroid in decimal degrees (WGS84).',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this geographic scope record was last modified.',
    `municipality_name` STRING COMMENT 'Name of the municipality, city, or town within the district.',
    `population_estimate` BIGINT COMMENT 'Estimated total population within this geographic scope, used for per-capita indicator calculations.',
    `population_source` STRING COMMENT 'Source of the population estimate (e.g., National Census 2020, UN Population Division 2023).',
    `population_year` STRING COMMENT 'Year of the population estimate.',
    `region_name` STRING COMMENT 'Name of the region, province, or state within the country (e.g., Eastern Province, California).',
    `scope_code` STRING COMMENT 'Unique business identifier code for the geographic scope (e.g., NATL, REG_EAST, DIST_001). Used for external references and reporting.',
    `scope_description` STRING COMMENT 'Detailed textual description of the geographic scope, including any special characteristics, boundary notes, or operational context.',
    `scope_name` STRING COMMENT 'Full descriptive name of the geographic scope (e.g., National, Eastern Region, District 1).',
    `scope_status` STRING COMMENT 'Current operational status of the geographic scope in the MEL framework.',
    `scope_type` STRING COMMENT 'Classification of the geographic scope level (e.g., global, regional, national, subnational, provincial, district, municipal, community, project_site).',
    `urban_rural_classification` STRING COMMENT 'Classification of the geographic scope as urban, rural, peri-urban, or mixed.',
    `vulnerability_index` DECIMAL(18,2) COMMENT 'Composite vulnerability index score for this geographic scope (0-100 scale), used for targeting and resource allocation.',
    CONSTRAINT pk_geographic_scope PRIMARY KEY(`geographic_scope_id`)
) COMMENT 'Geographic boundary and administrative area definitions used for MEL disaggregation, including population estimates, vulnerability indices, and conflict/disaster flags.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`mel`.`sdg_indicator_alignment` (
    `sdg_indicator_alignment_id` BIGINT COMMENT 'Primary key',
    `indicator_id` BIGINT COMMENT 'FK to mel.indicator',
    `alignment_type` STRING COMMENT 'Direct / Proxy / Contributing',
    `created_at` TIMESTAMP COMMENT 'Record creation timestamp',
    `notes` STRING COMMENT 'Alignment justification notes',
    `sdg_goal_number` STRING COMMENT 'SDG goal number (1-17)',
    `sdg_indicator_code` STRING COMMENT 'SDG indicator code (e.g., 3.1.1)',
    `sdg_indicator_description` STRING COMMENT 'Full text of the SDG indicator',
    `sdg_target_code` STRING COMMENT 'SDG target code (e.g., 3.1, 4.a)',
    `updated_at` TIMESTAMP COMMENT 'Record last update timestamp',
    CONSTRAINT pk_sdg_indicator_alignment PRIMARY KEY(`sdg_indicator_alignment_id`)
) COMMENT 'Explicit alignment between programme/MEL indicators and the UN Sustainable Development Goals (SDG) indicator framework, enabling reporting on SDG contributions. Maps internal indicators to SDG goals, targets, and indicators. Source systems: UN INFO, DHIS2, InSight.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_ngo_v1`.`mel`.`mel_logframe` ADD CONSTRAINT `fk_mel_mel_logframe_parent_logframe_mel_logframe_id` FOREIGN KEY (`parent_logframe_mel_logframe_id`) REFERENCES `vibe_ngo_v1`.`mel`.`mel_logframe`(`mel_logframe_id`);
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator_target` ADD CONSTRAINT `fk_mel_indicator_target_geographic_scope_id` FOREIGN KEY (`geographic_scope_id`) REFERENCES `vibe_ngo_v1`.`mel`.`geographic_scope`(`geographic_scope_id`);
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator_target` ADD CONSTRAINT `fk_mel_indicator_target_indicator_id` FOREIGN KEY (`indicator_id`) REFERENCES `vibe_ngo_v1`.`mel`.`indicator`(`indicator_id`);
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator_target` ADD CONSTRAINT `fk_mel_indicator_target_reporting_period_id` FOREIGN KEY (`reporting_period_id`) REFERENCES `vibe_ngo_v1`.`mel`.`reporting_period`(`reporting_period_id`);
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator_result` ADD CONSTRAINT `fk_mel_indicator_result_indicator_id` FOREIGN KEY (`indicator_id`) REFERENCES `vibe_ngo_v1`.`mel`.`indicator`(`indicator_id`);
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator_result` ADD CONSTRAINT `fk_mel_indicator_result_indicator_target_id` FOREIGN KEY (`indicator_target_id`) REFERENCES `vibe_ngo_v1`.`mel`.`indicator_target`(`indicator_target_id`);
ALTER TABLE `vibe_ngo_v1`.`mel`.`meal_plan` ADD CONSTRAINT `fk_mel_meal_plan_mel_logframe_id` FOREIGN KEY (`mel_logframe_id`) REFERENCES `vibe_ngo_v1`.`mel`.`mel_logframe`(`mel_logframe_id`);
ALTER TABLE `vibe_ngo_v1`.`mel`.`evaluation` ADD CONSTRAINT `fk_mel_evaluation_meal_plan_id` FOREIGN KEY (`meal_plan_id`) REFERENCES `vibe_ngo_v1`.`mel`.`meal_plan`(`meal_plan_id`);
ALTER TABLE `vibe_ngo_v1`.`mel`.`evaluation` ADD CONSTRAINT `fk_mel_evaluation_mel_logframe_id` FOREIGN KEY (`mel_logframe_id`) REFERENCES `vibe_ngo_v1`.`mel`.`mel_logframe`(`mel_logframe_id`);
ALTER TABLE `vibe_ngo_v1`.`mel`.`evaluation_finding` ADD CONSTRAINT `fk_mel_evaluation_finding_evaluation_id` FOREIGN KEY (`evaluation_id`) REFERENCES `vibe_ngo_v1`.`mel`.`evaluation`(`evaluation_id`);
ALTER TABLE `vibe_ngo_v1`.`mel`.`qualitative_record` ADD CONSTRAINT `fk_mel_qualitative_record_data_collection_tool_id` FOREIGN KEY (`data_collection_tool_id`) REFERENCES `vibe_ngo_v1`.`mel`.`data_collection_tool`(`data_collection_tool_id`);
ALTER TABLE `vibe_ngo_v1`.`mel`.`qualitative_record` ADD CONSTRAINT `fk_mel_qualitative_record_evaluation_id` FOREIGN KEY (`evaluation_id`) REFERENCES `vibe_ngo_v1`.`mel`.`evaluation`(`evaluation_id`);
ALTER TABLE `vibe_ngo_v1`.`mel`.`qualitative_record` ADD CONSTRAINT `fk_mel_qualitative_record_indicator_id` FOREIGN KEY (`indicator_id`) REFERENCES `vibe_ngo_v1`.`mel`.`indicator`(`indicator_id`);
ALTER TABLE `vibe_ngo_v1`.`mel`.`qualitative_record` ADD CONSTRAINT `fk_mel_qualitative_record_meal_plan_id` FOREIGN KEY (`meal_plan_id`) REFERENCES `vibe_ngo_v1`.`mel`.`meal_plan`(`meal_plan_id`);
ALTER TABLE `vibe_ngo_v1`.`mel`.`dhis2_aggregate_report` ADD CONSTRAINT `fk_mel_dhis2_aggregate_report_reporting_period_id` FOREIGN KEY (`reporting_period_id`) REFERENCES `vibe_ngo_v1`.`mel`.`reporting_period`(`reporting_period_id`);
ALTER TABLE `vibe_ngo_v1`.`mel`.`learning_agenda` ADD CONSTRAINT `fk_mel_learning_agenda_evaluation_id` FOREIGN KEY (`evaluation_id`) REFERENCES `vibe_ngo_v1`.`mel`.`evaluation`(`evaluation_id`);
ALTER TABLE `vibe_ngo_v1`.`mel`.`learning_agenda` ADD CONSTRAINT `fk_mel_learning_agenda_indicator_id` FOREIGN KEY (`indicator_id`) REFERENCES `vibe_ngo_v1`.`mel`.`indicator`(`indicator_id`);
ALTER TABLE `vibe_ngo_v1`.`mel`.`learning_agenda` ADD CONSTRAINT `fk_mel_learning_agenda_mel_logframe_id` FOREIGN KEY (`mel_logframe_id`) REFERENCES `vibe_ngo_v1`.`mel`.`mel_logframe`(`mel_logframe_id`);
ALTER TABLE `vibe_ngo_v1`.`mel`.`data_collection_tool` ADD CONSTRAINT `fk_mel_data_collection_tool_meal_plan_id` FOREIGN KEY (`meal_plan_id`) REFERENCES `vibe_ngo_v1`.`mel`.`meal_plan`(`meal_plan_id`);
ALTER TABLE `vibe_ngo_v1`.`mel`.`data_quality_assessment` ADD CONSTRAINT `fk_mel_data_quality_assessment_data_collection_tool_id` FOREIGN KEY (`data_collection_tool_id`) REFERENCES `vibe_ngo_v1`.`mel`.`data_collection_tool`(`data_collection_tool_id`);
ALTER TABLE `vibe_ngo_v1`.`mel`.`data_quality_assessment` ADD CONSTRAINT `fk_mel_data_quality_assessment_followup_data_quality_assessment_id` FOREIGN KEY (`followup_data_quality_assessment_id`) REFERENCES `vibe_ngo_v1`.`mel`.`data_quality_assessment`(`data_quality_assessment_id`);
ALTER TABLE `vibe_ngo_v1`.`mel`.`data_quality_assessment` ADD CONSTRAINT `fk_mel_data_quality_assessment_indicator_id` FOREIGN KEY (`indicator_id`) REFERENCES `vibe_ngo_v1`.`mel`.`indicator`(`indicator_id`);
ALTER TABLE `vibe_ngo_v1`.`mel`.`data_quality_assessment` ADD CONSTRAINT `fk_mel_data_quality_assessment_meal_plan_id` FOREIGN KEY (`meal_plan_id`) REFERENCES `vibe_ngo_v1`.`mel`.`meal_plan`(`meal_plan_id`);
ALTER TABLE `vibe_ngo_v1`.`mel`.`reporting_period` ADD CONSTRAINT `fk_mel_reporting_period_mel_logframe_id` FOREIGN KEY (`mel_logframe_id`) REFERENCES `vibe_ngo_v1`.`mel`.`mel_logframe`(`mel_logframe_id`);
ALTER TABLE `vibe_ngo_v1`.`mel`.`reporting_period` ADD CONSTRAINT `fk_mel_reporting_period_parent_reporting_period_id` FOREIGN KEY (`parent_reporting_period_id`) REFERENCES `vibe_ngo_v1`.`mel`.`reporting_period`(`reporting_period_id`);
ALTER TABLE `vibe_ngo_v1`.`mel`.`reporting_period` ADD CONSTRAINT `fk_mel_reporting_period_primary_prior_reporting_period_id` FOREIGN KEY (`primary_prior_reporting_period_id`) REFERENCES `vibe_ngo_v1`.`mel`.`reporting_period`(`reporting_period_id`);
ALTER TABLE `vibe_ngo_v1`.`mel`.`geographic_scope` ADD CONSTRAINT `fk_mel_geographic_scope_parent_geographic_scope_id` FOREIGN KEY (`parent_geographic_scope_id`) REFERENCES `vibe_ngo_v1`.`mel`.`geographic_scope`(`geographic_scope_id`);
ALTER TABLE `vibe_ngo_v1`.`mel`.`geographic_scope` ADD CONSTRAINT `fk_mel_geographic_scope_parent_scope_id` FOREIGN KEY (`parent_scope_id`) REFERENCES `vibe_ngo_v1`.`mel`.`geographic_scope`(`geographic_scope_id`);
ALTER TABLE `vibe_ngo_v1`.`mel`.`sdg_indicator_alignment` ADD CONSTRAINT `fk_mel_sdg_indicator_alignment_indicator_id` FOREIGN KEY (`indicator_id`) REFERENCES `vibe_ngo_v1`.`mel`.`indicator`(`indicator_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_ngo_v1`.`mel` SET TAGS ('pii_division' = 'operations');
ALTER SCHEMA `vibe_ngo_v1`.`mel` SET TAGS ('pii_domain' = 'mel');
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator` SET TAGS ('pii_subdomain' = 'indicator_management');
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator` SET TAGS ('pii_tier' = 'mvm');
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator` SET TAGS ('pii_column_comment_framework' = 'IATI Result Standard + OECD-DAC');
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator` ALTER COLUMN `indicator_id` SET TAGS ('pii_business_glossary_term' = 'Indicator ID');
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator` ALTER COLUMN `award_id` SET TAGS ('pii_business_glossary_term' = 'Grant ID');
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator` ALTER COLUMN `obligation_id` SET TAGS ('pii_business_glossary_term' = 'Compliance Obligation Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator` ALTER COLUMN `country_programme_document_id` SET TAGS ('pii_business_glossary_term' = 'CPD');
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator` ALTER COLUMN `donor_safeguarding_requirement_id` SET TAGS ('pii_business_glossary_term' = 'Donor Safeguarding Requirement Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator` ALTER COLUMN `intervention_id` SET TAGS ('pii_business_glossary_term' = 'Program ID');
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator` ALTER COLUMN `partner_org_id` SET TAGS ('pii_business_glossary_term' = 'Partner Org Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator` ALTER COLUMN `partnership_agreement_id` SET TAGS ('pii_business_glossary_term' = 'Partnership Agreement Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator` ALTER COLUMN `strategic_plan_goal_area_id` SET TAGS ('pii_business_glossary_term' = 'Goal Area');
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator` ALTER COLUMN `system_platform_id` SET TAGS ('pii_business_glossary_term' = 'System Platform Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator` ALTER COLUMN `baseline_date` SET TAGS ('pii_business_glossary_term' = 'Baseline Date');
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator` ALTER COLUMN `baseline_value` SET TAGS ('pii_business_glossary_term' = 'Baseline Value');
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator` ALTER COLUMN `calculation_method` SET TAGS ('pii_business_glossary_term' = 'Calculation Method');
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator` ALTER COLUMN `indicator_category` SET TAGS ('pii_business_glossary_term' = 'Indicator Category');
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator` ALTER COLUMN `indicator_category` SET TAGS ('pii_value_regex' = 'quantitative|qualitative|composite');
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator` ALTER COLUMN `indicator_code` SET TAGS ('pii_business_glossary_term' = 'Indicator Code');
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator` ALTER COLUMN `indicator_code` SET TAGS ('pii_value_regex' = '^[A-Z0-9]{3,20}$');
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator` ALTER COLUMN `dac_criteria_alignment` SET TAGS ('pii_business_glossary_term' = 'Development Assistance Committee (DAC) Criteria Alignment');
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator` ALTER COLUMN `data_collection_frequency` SET TAGS ('pii_business_glossary_term' = 'Data Collection Frequency');
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator` ALTER COLUMN `data_collection_method` SET TAGS ('pii_business_glossary_term' = 'Data Collection Method');
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator` ALTER COLUMN `data_source` SET TAGS ('pii_business_glossary_term' = 'Data Source');
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator` ALTER COLUMN `definition` SET TAGS ('pii_business_glossary_term' = 'Indicator Definition');
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator` ALTER COLUMN `denominator_description` SET TAGS ('pii_business_glossary_term' = 'Denominator Description');
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator` ALTER COLUMN `dhis2_indicator_code` SET TAGS ('pii_business_glossary_term' = 'DHIS2 Indicator ID');
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator` ALTER COLUMN `direction_of_change` SET TAGS ('pii_business_glossary_term' = 'Direction of Change');
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator` ALTER COLUMN `direction_of_change` SET TAGS ('pii_value_regex' = 'increase|decrease|maintain|not-applicable');
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator` ALTER COLUMN `disaggregation_dimensions` SET TAGS ('pii_business_glossary_term' = 'Disaggregation Dimensions');
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator` ALTER COLUMN `indicator_status` SET TAGS ('pii_business_glossary_term' = 'Indicator Status');
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator` ALTER COLUMN `indicator_status` SET TAGS ('pii_value_regex' = 'active|inactive|draft|archived|under-review');
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator` ALTER COLUMN `indicator_type` SET TAGS ('pii_business_glossary_term' = 'Indicator Type');
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator` ALTER COLUMN `indicator_type` SET TAGS ('pii_value_regex' = 'output|outcome|impact|process|input');
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator` ALTER COLUMN `is_custom` SET TAGS ('pii_business_glossary_term' = 'Is Custom Indicator');
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator` ALTER COLUMN `is_mandatory` SET TAGS ('pii_business_glossary_term' = 'Is Mandatory Indicator');
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator` ALTER COLUMN `last_modified_timestamp` SET TAGS ('pii_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator` ALTER COLUMN `logframe_level` SET TAGS ('pii_business_glossary_term' = 'Logical Framework (LogFrame) Level');
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator` ALTER COLUMN `logframe_level` SET TAGS ('pii_value_regex' = 'goal|purpose|output|activity');
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator` ALTER COLUMN `indicator_name` SET TAGS ('pii_business_glossary_term' = 'Indicator Name');
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator` ALTER COLUMN `indicator_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator` ALTER COLUMN `indicator_name` SET TAGS ('pii_type' = 'name');
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Indicator Notes');
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator` ALTER COLUMN `numerator_description` SET TAGS ('pii_business_glossary_term' = 'Numerator Description');
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator` ALTER COLUMN `reporting_frequency` SET TAGS ('pii_business_glossary_term' = 'Reporting Frequency');
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator` ALTER COLUMN `reporting_frequency` SET TAGS ('pii_value_regex' = 'monthly|quarterly|semi-annually|annually|ad-hoc');
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator` ALTER COLUMN `responsible_role` SET TAGS ('pii_business_glossary_term' = 'Responsible Role');
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator` ALTER COLUMN `sdg_alignment` SET TAGS ('pii_business_glossary_term' = 'Sustainable Development Goal (SDG) Alignment');
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator` ALTER COLUMN `sector` SET TAGS ('pii_business_glossary_term' = 'Sector');
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator` ALTER COLUMN `target_date` SET TAGS ('pii_business_glossary_term' = 'Target Date');
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator` ALTER COLUMN `target_value` SET TAGS ('pii_business_glossary_term' = 'Target Value');
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator` ALTER COLUMN `theme` SET TAGS ('pii_business_glossary_term' = 'Theme');
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator` ALTER COLUMN `unit_of_measure` SET TAGS ('pii_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator` ALTER COLUMN `verification_method` SET TAGS ('pii_business_glossary_term' = 'Verification Method');
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator` ALTER COLUMN `version_number` SET TAGS ('pii_business_glossary_term' = 'Version Number');
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator` ALTER COLUMN `version_number` SET TAGS ('pii_value_regex' = '^[0-9]+.[0-9]+$');
ALTER TABLE `vibe_ngo_v1`.`mel`.`mel_logframe` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_ngo_v1`.`mel`.`mel_logframe` SET TAGS ('pii_subdomain' = 'results_framework');
ALTER TABLE `vibe_ngo_v1`.`mel`.`mel_logframe` SET TAGS ('pii_tier' = 'mvm');
ALTER TABLE `vibe_ngo_v1`.`mel`.`mel_logframe` SET TAGS ('pii_ssot' = 'true');
ALTER TABLE `vibe_ngo_v1`.`mel`.`mel_logframe` SET TAGS ('pii_ssot_scope' = 'mel_results_framework');
ALTER TABLE `vibe_ngo_v1`.`mel`.`mel_logframe` SET TAGS ('pii_ssot_owner' = 'mel');
ALTER TABLE `vibe_ngo_v1`.`mel`.`mel_logframe` SET TAGS ('pii_ssot_boundary' = 'mel_logframe');
ALTER TABLE `vibe_ngo_v1`.`mel`.`mel_logframe` SET TAGS ('pii_disambiguated_from' = 'program.program_logframe');
ALTER TABLE `vibe_ngo_v1`.`mel`.`mel_logframe` ALTER COLUMN `mel_logframe_id` SET TAGS ('pii_business_glossary_term' = 'Monitoring Evaluation and Learning (MEL) Logical Framework (LogFrame) ID');
ALTER TABLE `vibe_ngo_v1`.`mel`.`mel_logframe` ALTER COLUMN `award_id` SET TAGS ('pii_business_glossary_term' = 'Grant Award ID');
ALTER TABLE `vibe_ngo_v1`.`mel`.`mel_logframe` ALTER COLUMN `intervention_id` SET TAGS ('pii_business_glossary_term' = 'Program ID');
ALTER TABLE `vibe_ngo_v1`.`mel`.`mel_logframe` ALTER COLUMN `parent_logframe_mel_logframe_id` SET TAGS ('pii_business_glossary_term' = 'Parent Logical Framework (LogFrame) ID');
ALTER TABLE `vibe_ngo_v1`.`mel`.`mel_logframe` ALTER COLUMN `partner_org_id` SET TAGS ('pii_business_glossary_term' = 'Partner Org Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`mel`.`mel_logframe` ALTER COLUMN `partnership_agreement_id` SET TAGS ('pii_business_glossary_term' = 'Partnership Agreement Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`mel`.`mel_logframe` ALTER COLUMN `staff_member_id` SET TAGS ('pii_business_glossary_term' = 'Responsible Staff Member Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`mel`.`mel_logframe` ALTER COLUMN `staff_member_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`mel`.`mel_logframe` ALTER COLUMN `staff_member_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_ngo_v1`.`mel`.`mel_logframe` ALTER COLUMN `actual_date` SET TAGS ('pii_business_glossary_term' = 'Actual Date');
ALTER TABLE `vibe_ngo_v1`.`mel`.`mel_logframe` ALTER COLUMN `actual_value` SET TAGS ('pii_business_glossary_term' = 'Actual Value');
ALTER TABLE `vibe_ngo_v1`.`mel`.`mel_logframe` ALTER COLUMN `approved_by` SET TAGS ('pii_business_glossary_term' = 'Approved By');
ALTER TABLE `vibe_ngo_v1`.`mel`.`mel_logframe` ALTER COLUMN `approved_date` SET TAGS ('pii_business_glossary_term' = 'Approved Date');
ALTER TABLE `vibe_ngo_v1`.`mel`.`mel_logframe` ALTER COLUMN `assumptions` SET TAGS ('pii_business_glossary_term' = 'Assumptions');
ALTER TABLE `vibe_ngo_v1`.`mel`.`mel_logframe` ALTER COLUMN `baseline_date` SET TAGS ('pii_business_glossary_term' = 'Baseline Date');
ALTER TABLE `vibe_ngo_v1`.`mel`.`mel_logframe` ALTER COLUMN `baseline_value` SET TAGS ('pii_business_glossary_term' = 'Baseline Value');
ALTER TABLE `vibe_ngo_v1`.`mel`.`mel_logframe` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_ngo_v1`.`mel`.`mel_logframe` ALTER COLUMN `dac_evaluation_criterion` SET TAGS ('pii_business_glossary_term' = 'Development Assistance Committee (DAC) Evaluation Criterion');
ALTER TABLE `vibe_ngo_v1`.`mel`.`mel_logframe` ALTER COLUMN `dac_evaluation_criterion` SET TAGS ('pii_value_regex' = 'Relevance|Coherence|Effectiveness|Efficiency|Impact|Sustainability');
ALTER TABLE `vibe_ngo_v1`.`mel`.`mel_logframe` ALTER COLUMN `data_collection_method` SET TAGS ('pii_business_glossary_term' = 'Data Collection Method');
ALTER TABLE `vibe_ngo_v1`.`mel`.`mel_logframe` ALTER COLUMN `disaggregation_dimensions` SET TAGS ('pii_business_glossary_term' = 'Disaggregation Dimensions');
ALTER TABLE `vibe_ngo_v1`.`mel`.`mel_logframe` ALTER COLUMN `donor_template_type` SET TAGS ('pii_business_glossary_term' = 'Donor Template Type');
ALTER TABLE `vibe_ngo_v1`.`mel`.`mel_logframe` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_ngo_v1`.`mel`.`mel_logframe` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_ngo_v1`.`mel`.`mel_logframe` ALTER COLUMN `hierarchy_sequence` SET TAGS ('pii_business_glossary_term' = 'Hierarchy Sequence Number');
ALTER TABLE `vibe_ngo_v1`.`mel`.`mel_logframe` ALTER COLUMN `intervention_statement` SET TAGS ('pii_business_glossary_term' = 'Intervention Statement');
ALTER TABLE `vibe_ngo_v1`.`mel`.`mel_logframe` ALTER COLUMN `is_custom_indicator` SET TAGS ('pii_business_glossary_term' = 'Is Custom Indicator Flag');
ALTER TABLE `vibe_ngo_v1`.`mel`.`mel_logframe` ALTER COLUMN `is_mandatory_donor_indicator` SET TAGS ('pii_business_glossary_term' = 'Is Mandatory Donor Indicator Flag');
ALTER TABLE `vibe_ngo_v1`.`mel`.`mel_logframe` ALTER COLUMN `last_modified_timestamp` SET TAGS ('pii_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_ngo_v1`.`mel`.`mel_logframe` ALTER COLUMN `last_review_date` SET TAGS ('pii_business_glossary_term' = 'Last Review Date');
ALTER TABLE `vibe_ngo_v1`.`mel`.`mel_logframe` ALTER COLUMN `logframe_code` SET TAGS ('pii_business_glossary_term' = 'Logical Framework (LogFrame) Code');
ALTER TABLE `vibe_ngo_v1`.`mel`.`mel_logframe` ALTER COLUMN `logframe_name` SET TAGS ('pii_business_glossary_term' = 'Logical Framework (LogFrame) Name');
ALTER TABLE `vibe_ngo_v1`.`mel`.`mel_logframe` ALTER COLUMN `logframe_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`mel`.`mel_logframe` ALTER COLUMN `logframe_name` SET TAGS ('pii_type' = 'name');
ALTER TABLE `vibe_ngo_v1`.`mel`.`mel_logframe` ALTER COLUMN `means_of_verification` SET TAGS ('pii_business_glossary_term' = 'Means of Verification (MoV)');
ALTER TABLE `vibe_ngo_v1`.`mel`.`mel_logframe` ALTER COLUMN `mel_logframe_status` SET TAGS ('pii_business_glossary_term' = 'Logical Framework (LogFrame) Status');
ALTER TABLE `vibe_ngo_v1`.`mel`.`mel_logframe` ALTER COLUMN `next_review_date` SET TAGS ('pii_business_glossary_term' = 'Next Review Date');
ALTER TABLE `vibe_ngo_v1`.`mel`.`mel_logframe` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_ngo_v1`.`mel`.`mel_logframe` ALTER COLUMN `objectively_verifiable_indicator` SET TAGS ('pii_business_glossary_term' = 'Objectively Verifiable Indicator (OVI)');
ALTER TABLE `vibe_ngo_v1`.`mel`.`mel_logframe` ALTER COLUMN `reporting_frequency` SET TAGS ('pii_business_glossary_term' = 'Reporting Frequency');
ALTER TABLE `vibe_ngo_v1`.`mel`.`mel_logframe` ALTER COLUMN `reporting_frequency` SET TAGS ('pii_value_regex' = 'Monthly|Quarterly|Semi-Annual|Annual|Ad-Hoc|Milestone-Based');
ALTER TABLE `vibe_ngo_v1`.`mel`.`mel_logframe` ALTER COLUMN `responsible_party` SET TAGS ('pii_business_glossary_term' = 'Responsible Party');
ALTER TABLE `vibe_ngo_v1`.`mel`.`mel_logframe` ALTER COLUMN `results_chain_level` SET TAGS ('pii_business_glossary_term' = 'Results Chain Level');
ALTER TABLE `vibe_ngo_v1`.`mel`.`mel_logframe` ALTER COLUMN `risks` SET TAGS ('pii_business_glossary_term' = 'Risks');
ALTER TABLE `vibe_ngo_v1`.`mel`.`mel_logframe` ALTER COLUMN `sdg_alignment` SET TAGS ('pii_business_glossary_term' = 'Sustainable Development Goal (SDG) Alignment');
ALTER TABLE `vibe_ngo_v1`.`mel`.`mel_logframe` ALTER COLUMN `target_date` SET TAGS ('pii_business_glossary_term' = 'Target Date');
ALTER TABLE `vibe_ngo_v1`.`mel`.`mel_logframe` ALTER COLUMN `target_value` SET TAGS ('pii_business_glossary_term' = 'Target Value');
ALTER TABLE `vibe_ngo_v1`.`mel`.`mel_logframe` ALTER COLUMN `theory_of_change_component` SET TAGS ('pii_business_glossary_term' = 'Theory of Change (ToC) Component');
ALTER TABLE `vibe_ngo_v1`.`mel`.`mel_logframe` ALTER COLUMN `unit_of_measure` SET TAGS ('pii_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `vibe_ngo_v1`.`mel`.`mel_logframe` ALTER COLUMN `version` SET TAGS ('pii_business_glossary_term' = 'Logical Framework (LogFrame) Version');
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator_target` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator_target` SET TAGS ('pii_subdomain' = 'indicator_management');
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator_target` SET TAGS ('pii_tier' = 'mvm');
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator_target` ALTER COLUMN `indicator_target_id` SET TAGS ('pii_business_glossary_term' = 'Indicator Target ID');
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator_target` ALTER COLUMN `award_id` SET TAGS ('pii_business_glossary_term' = 'Grant ID');
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator_target` ALTER COLUMN `donor_requirement_id` SET TAGS ('pii_business_glossary_term' = 'Donor Compliance Req Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator_target` ALTER COLUMN `geographic_scope_id` SET TAGS ('pii_business_glossary_term' = 'Geographic Scope ID');
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator_target` ALTER COLUMN `indicator_id` SET TAGS ('pii_business_glossary_term' = 'Indicator ID');
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator_target` ALTER COLUMN `intervention_id` SET TAGS ('pii_business_glossary_term' = 'Program ID');
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator_target` ALTER COLUMN `org_unit_id` SET TAGS ('pii_business_glossary_term' = 'Responsible Unit ID');
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator_target` ALTER COLUMN `partner_org_id` SET TAGS ('pii_business_glossary_term' = 'Partner Org Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator_target` ALTER COLUMN `partnership_agreement_id` SET TAGS ('pii_business_glossary_term' = 'Partnership Agreement Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator_target` ALTER COLUMN `staff_member_id` SET TAGS ('pii_business_glossary_term' = 'Responsible Staff ID');
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator_target` ALTER COLUMN `staff_member_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator_target` ALTER COLUMN `staff_member_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator_target` ALTER COLUMN `program_logframe_id` SET TAGS ('pii_business_glossary_term' = 'Logical Framework (LogFrame) ID');
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator_target` ALTER COLUMN `reporting_period_id` SET TAGS ('pii_business_glossary_term' = 'Reporting Period ID');
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator_target` ALTER COLUMN `approval_date` SET TAGS ('pii_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator_target` ALTER COLUMN `assumptions` SET TAGS ('pii_business_glossary_term' = 'Assumptions');
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator_target` ALTER COLUMN `baseline_date` SET TAGS ('pii_business_glossary_term' = 'Baseline Date');
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator_target` ALTER COLUMN `baseline_value` SET TAGS ('pii_business_glossary_term' = 'Baseline Value');
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator_target` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator_target` ALTER COLUMN `dac_sector_code` SET TAGS ('pii_business_glossary_term' = 'Development Assistance Committee (DAC) Sector Code');
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator_target` ALTER COLUMN `data_collection_method` SET TAGS ('pii_business_glossary_term' = 'Data Collection Method');
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator_target` ALTER COLUMN `disaggregation_age_group` SET TAGS ('pii_business_glossary_term' = 'Disaggregation by Age Group');
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator_target` ALTER COLUMN `disaggregation_age_group` SET TAGS ('pii_type' = 'age');
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator_target` ALTER COLUMN `disaggregation_disability_status` SET TAGS ('pii_business_glossary_term' = 'Disaggregation by Disability Status');
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator_target` ALTER COLUMN `disaggregation_disability_status` SET TAGS ('pii_value_regex' = 'with_disability|without_disability|not_specified');
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator_target` ALTER COLUMN `disaggregation_disability_status` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator_target` ALTER COLUMN `disaggregation_disability_status` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator_target` ALTER COLUMN `disaggregation_displacement_status` SET TAGS ('pii_business_glossary_term' = 'Disaggregation by Displacement Status');
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator_target` ALTER COLUMN `disaggregation_sex` SET TAGS ('pii_business_glossary_term' = 'Disaggregation by Sex');
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator_target` ALTER COLUMN `disaggregation_sex` SET TAGS ('pii_value_regex' = 'male|female|other|not_specified');
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator_target` ALTER COLUMN `disaggregation_sex` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator_target` ALTER COLUMN `disaggregation_sex` SET TAGS ('pii_type' = 'gender');
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator_target` ALTER COLUMN `donor_reporting_requirement` SET TAGS ('pii_business_glossary_term' = 'Donor Reporting Requirement');
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator_target` ALTER COLUMN `last_modified_timestamp` SET TAGS ('pii_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator_target` ALTER COLUMN `measurement_frequency` SET TAGS ('pii_business_glossary_term' = 'Measurement Frequency');
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator_target` ALTER COLUMN `mitigation_strategy` SET TAGS ('pii_business_glossary_term' = 'Mitigation Strategy');
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator_target` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator_target` ALTER COLUMN `revision_date` SET TAGS ('pii_business_glossary_term' = 'Revision Date');
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator_target` ALTER COLUMN `revision_reason` SET TAGS ('pii_business_glossary_term' = 'Revision Reason');
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator_target` ALTER COLUMN `risks` SET TAGS ('pii_business_glossary_term' = 'Risks');
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator_target` ALTER COLUMN `sdg_alignment` SET TAGS ('pii_business_glossary_term' = 'Sustainable Development Goal (SDG) Alignment');
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator_target` ALTER COLUMN `target_code` SET TAGS ('pii_business_glossary_term' = 'Target Code');
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator_target` ALTER COLUMN `target_date` SET TAGS ('pii_business_glossary_term' = 'Target Date');
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator_target` ALTER COLUMN `target_description` SET TAGS ('pii_business_glossary_term' = 'Target Description');
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator_target` ALTER COLUMN `target_name` SET TAGS ('pii_business_glossary_term' = 'Target Name');
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator_target` ALTER COLUMN `target_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator_target` ALTER COLUMN `target_name` SET TAGS ('pii_type' = 'name');
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator_target` ALTER COLUMN `target_status` SET TAGS ('pii_business_glossary_term' = 'Target Status');
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator_target` ALTER COLUMN `target_type` SET TAGS ('pii_business_glossary_term' = 'Target Type');
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator_target` ALTER COLUMN `target_type` SET TAGS ('pii_value_regex' = 'output|outcome|impact|process|input');
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator_target` ALTER COLUMN `target_value` SET TAGS ('pii_business_glossary_term' = 'Target Value');
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator_target` ALTER COLUMN `unit_of_measure` SET TAGS ('pii_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator_target` ALTER COLUMN `verification_source` SET TAGS ('pii_business_glossary_term' = 'Verification Source');
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator_result` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator_result` SET TAGS ('pii_subdomain' = 'indicator_management');
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator_result` SET TAGS ('pii_tier' = 'mvm');
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator_result` ALTER COLUMN `indicator_result_id` SET TAGS ('pii_business_glossary_term' = 'Indicator Result ID');
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator_result` ALTER COLUMN `audit_finding_id` SET TAGS ('pii_business_glossary_term' = 'Audit Finding Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator_result` ALTER COLUMN `award_id` SET TAGS ('pii_business_glossary_term' = 'Award ID');
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator_result` ALTER COLUMN `staff_member_id` SET TAGS ('pii_business_glossary_term' = 'Collected By Staff Member Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator_result` ALTER COLUMN `staff_member_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator_result` ALTER COLUMN `staff_member_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator_result` ALTER COLUMN `commodity_id` SET TAGS ('pii_business_glossary_term' = 'Commodity Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator_result` ALTER COLUMN `cost_center_id` SET TAGS ('pii_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator_result` ALTER COLUMN `donor_report_id` SET TAGS ('pii_business_glossary_term' = 'Donor Report ID');
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator_result` ALTER COLUMN `field_monitoring_visit_id` SET TAGS ('pii_business_glossary_term' = 'Field Monitoring Visit Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator_result` ALTER COLUMN `indicator_id` SET TAGS ('pii_business_glossary_term' = 'Indicator ID');
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator_result` ALTER COLUMN `indicator_target_id` SET TAGS ('pii_business_glossary_term' = 'Indicator Target Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator_result` ALTER COLUMN `intervention_id` SET TAGS ('pii_business_glossary_term' = 'Program ID');
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator_result` ALTER COLUMN `partner_org_id` SET TAGS ('pii_business_glossary_term' = 'Partner Organization ID');
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator_result` ALTER COLUMN `partner_performance_review_id` SET TAGS ('pii_business_glossary_term' = 'Partner Performance Review Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator_result` ALTER COLUMN `partner_report_submission_id` SET TAGS ('pii_business_glossary_term' = 'Partner Report Submission Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator_result` ALTER COLUMN `project_site_id` SET TAGS ('pii_business_glossary_term' = 'Project Site ID');
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator_result` ALTER COLUMN `user_account_id` SET TAGS ('pii_business_glossary_term' = 'User Account Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator_result` ALTER COLUMN `baseline_value` SET TAGS ('pii_business_glossary_term' = 'Baseline Value');
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator_result` ALTER COLUMN `beneficiary_count` SET TAGS ('pii_business_glossary_term' = 'Beneficiary Count');
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator_result` ALTER COLUMN `collection_date` SET TAGS ('pii_business_glossary_term' = 'Collection Date');
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator_result` ALTER COLUMN `contributing_factors` SET TAGS ('pii_business_glossary_term' = 'Contributing Factors');
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator_result` ALTER COLUMN `corrective_actions` SET TAGS ('pii_business_glossary_term' = 'Corrective Actions');
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator_result` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator_result` ALTER COLUMN `cumulative_result` SET TAGS ('pii_business_glossary_term' = 'Cumulative Result');
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator_result` ALTER COLUMN `data_collection_method` SET TAGS ('pii_business_glossary_term' = 'Data Collection Method');
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator_result` ALTER COLUMN `data_quality_notes` SET TAGS ('pii_business_glossary_term' = 'Data Quality Notes');
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator_result` ALTER COLUMN `data_quality_score` SET TAGS ('pii_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator_result` ALTER COLUMN `data_source` SET TAGS ('pii_business_glossary_term' = 'Data Source');
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator_result` ALTER COLUMN `disaggregation_age_group` SET TAGS ('pii_business_glossary_term' = 'Disaggregation by Age Group');
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator_result` ALTER COLUMN `disaggregation_age_group` SET TAGS ('pii_value_regex' = '0-5|6-17|18-59|60+|not_applicable');
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator_result` ALTER COLUMN `disaggregation_age_group` SET TAGS ('pii_type' = 'age');
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator_result` ALTER COLUMN `disaggregation_disability` SET TAGS ('pii_business_glossary_term' = 'Disaggregation by Disability Status');
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator_result` ALTER COLUMN `disaggregation_disability` SET TAGS ('pii_value_regex' = 'with_disability|without_disability|unknown|not_applicable');
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator_result` ALTER COLUMN `disaggregation_disability` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator_result` ALTER COLUMN `disaggregation_disability` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator_result` ALTER COLUMN `disaggregation_displacement_status` SET TAGS ('pii_business_glossary_term' = 'Disaggregation by Displacement Status');
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator_result` ALTER COLUMN `disaggregation_displacement_status` SET TAGS ('pii_value_regex' = 'idp|refugee|returnee|host_community|not_applicable');
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator_result` ALTER COLUMN `disaggregation_sex` SET TAGS ('pii_business_glossary_term' = 'Disaggregation by Sex');
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator_result` ALTER COLUMN `disaggregation_sex` SET TAGS ('pii_value_regex' = 'male|female|other|unknown|not_applicable');
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator_result` ALTER COLUMN `disaggregation_sex` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator_result` ALTER COLUMN `disaggregation_sex` SET TAGS ('pii_type' = 'gender');
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator_result` ALTER COLUMN `evidence_file_path` SET TAGS ('pii_business_glossary_term' = 'Evidence File Path');
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator_result` ALTER COLUMN `geographic_level` SET TAGS ('pii_business_glossary_term' = 'Geographic Level');
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator_result` ALTER COLUMN `geographic_level` SET TAGS ('pii_value_regex' = 'national|regional|district|community|facility');
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator_result` ALTER COLUMN `household_count` SET TAGS ('pii_business_glossary_term' = 'Household Count');
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator_result` ALTER COLUMN `indicator_level` SET TAGS ('pii_business_glossary_term' = 'Indicator Level');
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator_result` ALTER COLUMN `indicator_level` SET TAGS ('pii_value_regex' = 'output|outcome|impact|process');
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator_result` ALTER COLUMN `is_milestone` SET TAGS ('pii_business_glossary_term' = 'Is Milestone Flag');
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator_result` ALTER COLUMN `last_modified_by` SET TAGS ('pii_business_glossary_term' = 'Last Modified By');
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator_result` ALTER COLUMN `last_modified_timestamp` SET TAGS ('pii_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator_result` ALTER COLUMN `narrative_description` SET TAGS ('pii_business_glossary_term' = 'Narrative Description');
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator_result` ALTER COLUMN `reported_to_donor` SET TAGS ('pii_business_glossary_term' = 'Reported to Donor Flag');
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator_result` ALTER COLUMN `reporting_period_end_date` SET TAGS ('pii_business_glossary_term' = 'Reporting Period End Date');
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator_result` ALTER COLUMN `reporting_period_start_date` SET TAGS ('pii_business_glossary_term' = 'Reporting Period Start Date');
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator_result` ALTER COLUMN `result_status` SET TAGS ('pii_business_glossary_term' = 'Result Status');
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator_result` ALTER COLUMN `result_status` SET TAGS ('pii_value_regex' = 'draft|submitted|approved|rejected|archived');
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator_result` ALTER COLUMN `result_value` SET TAGS ('pii_business_glossary_term' = 'Result Value');
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator_result` ALTER COLUMN `target_value` SET TAGS ('pii_business_glossary_term' = 'Target Value');
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator_result` ALTER COLUMN `unit_of_measure` SET TAGS ('pii_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator_result` ALTER COLUMN `variance_from_target` SET TAGS ('pii_business_glossary_term' = 'Variance from Target');
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator_result` ALTER COLUMN `variance_percentage` SET TAGS ('pii_business_glossary_term' = 'Variance Percentage');
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator_result` ALTER COLUMN `verification_date` SET TAGS ('pii_business_glossary_term' = 'Verification Date');
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator_result` ALTER COLUMN `verification_status` SET TAGS ('pii_business_glossary_term' = 'Verification Status');
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator_result` ALTER COLUMN `verification_status` SET TAGS ('pii_value_regex' = 'unverified|verified|rejected|pending_review');
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator_result` ALTER COLUMN `verified_by` SET TAGS ('pii_business_glossary_term' = 'Verified By');
ALTER TABLE `vibe_ngo_v1`.`mel`.`meal_plan` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_ngo_v1`.`mel`.`meal_plan` SET TAGS ('pii_subdomain' = 'results_framework');
ALTER TABLE `vibe_ngo_v1`.`mel`.`meal_plan` SET TAGS ('pii_tier' = 'mvm');
ALTER TABLE `vibe_ngo_v1`.`mel`.`meal_plan` ALTER COLUMN `meal_plan_id` SET TAGS ('pii_business_glossary_term' = 'Monitoring Evaluation Accountability and Learning (MEAL) Plan Identifier');
ALTER TABLE `vibe_ngo_v1`.`mel`.`meal_plan` ALTER COLUMN `award_id` SET TAGS ('pii_business_glossary_term' = 'Grant Identifier');
ALTER TABLE `vibe_ngo_v1`.`mel`.`meal_plan` ALTER COLUMN `budget_id` SET TAGS ('pii_business_glossary_term' = 'Budget Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`mel`.`meal_plan` ALTER COLUMN `budget_plan_id` SET TAGS ('pii_business_glossary_term' = 'Budget Plan Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`mel`.`meal_plan` ALTER COLUMN `obligation_id` SET TAGS ('pii_business_glossary_term' = 'Compliance Obligation Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`mel`.`meal_plan` ALTER COLUMN `intervention_id` SET TAGS ('pii_business_glossary_term' = 'Program Identifier');
ALTER TABLE `vibe_ngo_v1`.`mel`.`meal_plan` ALTER COLUMN `mel_logframe_id` SET TAGS ('pii_business_glossary_term' = 'Mel Logframe Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`mel`.`meal_plan` ALTER COLUMN `partnership_agreement_id` SET TAGS ('pii_business_glossary_term' = 'Partnership Agreement Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`mel`.`meal_plan` ALTER COLUMN `staff_member_id` SET TAGS ('pii_business_glossary_term' = 'Monitoring Evaluation and Learning (MEL) Staff Lead Identifier');
ALTER TABLE `vibe_ngo_v1`.`mel`.`meal_plan` ALTER COLUMN `staff_member_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`mel`.`meal_plan` ALTER COLUMN `staff_member_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_ngo_v1`.`mel`.`meal_plan` ALTER COLUMN `risk_assessment_id` SET TAGS ('pii_business_glossary_term' = 'Safeguarding Risk Assessment Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`mel`.`meal_plan` ALTER COLUMN `system_platform_id` SET TAGS ('pii_business_glossary_term' = 'System Platform Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`mel`.`meal_plan` ALTER COLUMN `accountability_mechanisms` SET TAGS ('pii_business_glossary_term' = 'Accountability Mechanisms Description');
ALTER TABLE `vibe_ngo_v1`.`mel`.`meal_plan` ALTER COLUMN `approval_date` SET TAGS ('pii_business_glossary_term' = 'MEAL Plan Approval Date');
ALTER TABLE `vibe_ngo_v1`.`mel`.`meal_plan` ALTER COLUMN `baseline_completion_date` SET TAGS ('pii_business_glossary_term' = 'Baseline Assessment Completion Date');
ALTER TABLE `vibe_ngo_v1`.`mel`.`meal_plan` ALTER COLUMN `beneficiary_feedback_channels` SET TAGS ('pii_business_glossary_term' = 'Beneficiary Feedback Channels Description');
ALTER TABLE `vibe_ngo_v1`.`mel`.`meal_plan` ALTER COLUMN `budget_allocated` SET TAGS ('pii_business_glossary_term' = 'MEAL Plan Budget Allocated Amount');
ALTER TABLE `vibe_ngo_v1`.`mel`.`meal_plan` ALTER COLUMN `budget_allocated` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`mel`.`meal_plan` ALTER COLUMN `chs_commitment_alignment` SET TAGS ('pii_business_glossary_term' = 'Core Humanitarian Standard (CHS) Commitment Alignment');
ALTER TABLE `vibe_ngo_v1`.`mel`.`meal_plan` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_ngo_v1`.`mel`.`meal_plan` ALTER COLUMN `currency_code` SET TAGS ('pii_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `vibe_ngo_v1`.`mel`.`meal_plan` ALTER COLUMN `currency_code` SET TAGS ('pii_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_ngo_v1`.`mel`.`meal_plan` ALTER COLUMN `dac_criteria_coverage` SET TAGS ('pii_business_glossary_term' = 'Development Assistance Committee (DAC) Criteria Coverage');
ALTER TABLE `vibe_ngo_v1`.`mel`.`meal_plan` ALTER COLUMN `data_collection_methods` SET TAGS ('pii_business_glossary_term' = 'Data Collection Methods');
ALTER TABLE `vibe_ngo_v1`.`mel`.`meal_plan` ALTER COLUMN `data_collection_tools` SET TAGS ('pii_business_glossary_term' = 'Data Collection Tools and Platforms');
ALTER TABLE `vibe_ngo_v1`.`mel`.`meal_plan` ALTER COLUMN `data_disaggregation_plan` SET TAGS ('pii_business_glossary_term' = 'Data Disaggregation Plan');
ALTER TABLE `vibe_ngo_v1`.`mel`.`meal_plan` ALTER COLUMN `data_management_protocols` SET TAGS ('pii_business_glossary_term' = 'Data Management Protocols');
ALTER TABLE `vibe_ngo_v1`.`mel`.`meal_plan` ALTER COLUMN `data_quality_protocols` SET TAGS ('pii_business_glossary_term' = 'Data Quality Assurance Protocols');
ALTER TABLE `vibe_ngo_v1`.`mel`.`meal_plan` ALTER COLUMN `donor_reporting_requirements` SET TAGS ('pii_business_glossary_term' = 'Donor Reporting Requirements Description');
ALTER TABLE `vibe_ngo_v1`.`mel`.`meal_plan` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'MEAL Plan Effective End Date');
ALTER TABLE `vibe_ngo_v1`.`mel`.`meal_plan` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'MEAL Plan Effective Start Date');
ALTER TABLE `vibe_ngo_v1`.`mel`.`meal_plan` ALTER COLUMN `endline_planned_date` SET TAGS ('pii_business_glossary_term' = 'Endline Evaluation Planned Date');
ALTER TABLE `vibe_ngo_v1`.`mel`.`meal_plan` ALTER COLUMN `ethical_considerations` SET TAGS ('pii_business_glossary_term' = 'Ethical Considerations and Safeguards');
ALTER TABLE `vibe_ngo_v1`.`mel`.`meal_plan` ALTER COLUMN `evaluation_strategy` SET TAGS ('pii_business_glossary_term' = 'Evaluation Strategy Description');
ALTER TABLE `vibe_ngo_v1`.`mel`.`meal_plan` ALTER COLUMN `indicator_count` SET TAGS ('pii_business_glossary_term' = 'Total Indicator Count');
ALTER TABLE `vibe_ngo_v1`.`mel`.`meal_plan` ALTER COLUMN `last_modified_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `vibe_ngo_v1`.`mel`.`meal_plan` ALTER COLUMN `learning_agenda` SET TAGS ('pii_business_glossary_term' = 'Learning Agenda Description');
ALTER TABLE `vibe_ngo_v1`.`mel`.`meal_plan` ALTER COLUMN `mel_team_members` SET TAGS ('pii_business_glossary_term' = 'MEL Team Members List');
ALTER TABLE `vibe_ngo_v1`.`mel`.`meal_plan` ALTER COLUMN `midline_planned_date` SET TAGS ('pii_business_glossary_term' = 'Midline Evaluation Planned Date');
ALTER TABLE `vibe_ngo_v1`.`mel`.`meal_plan` ALTER COLUMN `monitoring_strategy` SET TAGS ('pii_business_glossary_term' = 'Monitoring Strategy Description');
ALTER TABLE `vibe_ngo_v1`.`mel`.`meal_plan` ALTER COLUMN `plan_status` SET TAGS ('pii_business_glossary_term' = 'MEAL Plan Status');
ALTER TABLE `vibe_ngo_v1`.`mel`.`meal_plan` ALTER COLUMN `plan_title` SET TAGS ('pii_business_glossary_term' = 'MEAL Plan Title');
ALTER TABLE `vibe_ngo_v1`.`mel`.`meal_plan` ALTER COLUMN `plan_version` SET TAGS ('pii_business_glossary_term' = 'MEAL Plan Version Number');
ALTER TABLE `vibe_ngo_v1`.`mel`.`meal_plan` ALTER COLUMN `rbm_framework_alignment` SET TAGS ('pii_business_glossary_term' = 'Results-Based Management (RBM) Framework Alignment');
ALTER TABLE `vibe_ngo_v1`.`mel`.`meal_plan` ALTER COLUMN `reporting_calendar` SET TAGS ('pii_business_glossary_term' = 'Reporting Calendar Description');
ALTER TABLE `vibe_ngo_v1`.`mel`.`meal_plan` ALTER COLUMN `revision_history` SET TAGS ('pii_business_glossary_term' = 'MEAL Plan Revision History');
ALTER TABLE `vibe_ngo_v1`.`mel`.`meal_plan` ALTER COLUMN `risk_mitigation_plan` SET TAGS ('pii_business_glossary_term' = 'MEL Risk Mitigation Plan');
ALTER TABLE `vibe_ngo_v1`.`mel`.`meal_plan` ALTER COLUMN `sdg_alignment` SET TAGS ('pii_business_glossary_term' = 'Sustainable Development Goal (SDG) Alignment');
ALTER TABLE `vibe_ngo_v1`.`mel`.`meal_plan` ALTER COLUMN `toc_narrative` SET TAGS ('pii_business_glossary_term' = 'Theory of Change (ToC) Narrative');
ALTER TABLE `vibe_ngo_v1`.`mel`.`evaluation` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_ngo_v1`.`mel`.`evaluation` SET TAGS ('pii_subdomain' = 'evaluation_learning');
ALTER TABLE `vibe_ngo_v1`.`mel`.`evaluation` SET TAGS ('pii_tier' = 'mvm');
ALTER TABLE `vibe_ngo_v1`.`mel`.`evaluation` ALTER COLUMN `evaluation_id` SET TAGS ('pii_business_glossary_term' = 'Evaluation ID');
ALTER TABLE `vibe_ngo_v1`.`mel`.`evaluation` ALTER COLUMN `award_id` SET TAGS ('pii_business_glossary_term' = 'Grant ID');
ALTER TABLE `vibe_ngo_v1`.`mel`.`evaluation` ALTER COLUMN `budget_id` SET TAGS ('pii_business_glossary_term' = 'Budget Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`mel`.`evaluation` ALTER COLUMN `staff_member_id` SET TAGS ('pii_business_glossary_term' = 'Commissioned By Staff Member Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`mel`.`evaluation` ALTER COLUMN `staff_member_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`mel`.`evaluation` ALTER COLUMN `staff_member_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_ngo_v1`.`mel`.`evaluation` ALTER COLUMN `cost_center_id` SET TAGS ('pii_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`mel`.`evaluation` ALTER COLUMN `intervention_id` SET TAGS ('pii_business_glossary_term' = 'Program ID');
ALTER TABLE `vibe_ngo_v1`.`mel`.`evaluation` ALTER COLUMN `meal_plan_id` SET TAGS ('pii_business_glossary_term' = 'Meal Plan Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`mel`.`evaluation` ALTER COLUMN `mel_logframe_id` SET TAGS ('pii_business_glossary_term' = 'Mel Logframe Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`mel`.`evaluation` ALTER COLUMN `partner_org_id` SET TAGS ('pii_business_glossary_term' = 'Partner Org Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`mel`.`evaluation` ALTER COLUMN `partner_report_submission_id` SET TAGS ('pii_business_glossary_term' = 'Partner Report Submission Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`mel`.`evaluation` ALTER COLUMN `partnership_agreement_id` SET TAGS ('pii_business_glossary_term' = 'Partnership Agreement Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`mel`.`evaluation` ALTER COLUMN `risk_assessment_id` SET TAGS ('pii_business_glossary_term' = 'Safeguarding Risk Assessment Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`mel`.`evaluation` ALTER COLUMN `single_audit_id` SET TAGS ('pii_business_glossary_term' = 'Single Audit Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`mel`.`evaluation` ALTER COLUMN `system_platform_id` SET TAGS ('pii_business_glossary_term' = 'System Platform Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`mel`.`evaluation` ALTER COLUMN `actual_cost` SET TAGS ('pii_business_glossary_term' = 'Actual Cost');
ALTER TABLE `vibe_ngo_v1`.`mel`.`evaluation` ALTER COLUMN `actual_cost` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`mel`.`evaluation` ALTER COLUMN `actual_end_date` SET TAGS ('pii_business_glossary_term' = 'Actual End Date');
ALTER TABLE `vibe_ngo_v1`.`mel`.`evaluation` ALTER COLUMN `actual_start_date` SET TAGS ('pii_business_glossary_term' = 'Actual Start Date');
ALTER TABLE `vibe_ngo_v1`.`mel`.`evaluation` ALTER COLUMN `beneficiary_sample_size` SET TAGS ('pii_business_glossary_term' = 'Beneficiary Sample Size');
ALTER TABLE `vibe_ngo_v1`.`mel`.`evaluation` ALTER COLUMN `budget_amount` SET TAGS ('pii_business_glossary_term' = 'Evaluation Budget Amount');
ALTER TABLE `vibe_ngo_v1`.`mel`.`evaluation` ALTER COLUMN `budget_amount` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`mel`.`evaluation` ALTER COLUMN `evaluation_code` SET TAGS ('pii_business_glossary_term' = 'Evaluation Code');
ALTER TABLE `vibe_ngo_v1`.`mel`.`evaluation` ALTER COLUMN `evaluation_code` SET TAGS ('pii_value_regex' = '^[A-Z0-9]{6,20}$');
ALTER TABLE `vibe_ngo_v1`.`mel`.`evaluation` ALTER COLUMN `coherence_rating` SET TAGS ('pii_business_glossary_term' = 'Coherence Rating');
ALTER TABLE `vibe_ngo_v1`.`mel`.`evaluation` ALTER COLUMN `coherence_rating` SET TAGS ('pii_value_regex' = 'highly_satisfactory|satisfactory|moderately_satisfactory|moderately_unsatisfactory|unsatisfactory|highly_unsatisfactory');
ALTER TABLE `vibe_ngo_v1`.`mel`.`evaluation` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_ngo_v1`.`mel`.`evaluation` ALTER COLUMN `currency_code` SET TAGS ('pii_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_ngo_v1`.`mel`.`evaluation` ALTER COLUMN `currency_code` SET TAGS ('pii_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_ngo_v1`.`mel`.`evaluation` ALTER COLUMN `dac_criteria_assessed` SET TAGS ('pii_business_glossary_term' = 'Development Assistance Committee (DAC) Criteria Assessed');
ALTER TABLE `vibe_ngo_v1`.`mel`.`evaluation` ALTER COLUMN `data_collection_methods` SET TAGS ('pii_business_glossary_term' = 'Data Collection Methods');
ALTER TABLE `vibe_ngo_v1`.`mel`.`evaluation` ALTER COLUMN `dissemination_date` SET TAGS ('pii_business_glossary_term' = 'Dissemination Date');
ALTER TABLE `vibe_ngo_v1`.`mel`.`evaluation` ALTER COLUMN `effectiveness_rating` SET TAGS ('pii_business_glossary_term' = 'Effectiveness Rating');
ALTER TABLE `vibe_ngo_v1`.`mel`.`evaluation` ALTER COLUMN `effectiveness_rating` SET TAGS ('pii_value_regex' = 'highly_satisfactory|satisfactory|moderately_satisfactory|moderately_unsatisfactory|unsatisfactory|highly_unsatisfactory');
ALTER TABLE `vibe_ngo_v1`.`mel`.`evaluation` ALTER COLUMN `efficiency_rating` SET TAGS ('pii_business_glossary_term' = 'Efficiency Rating');
ALTER TABLE `vibe_ngo_v1`.`mel`.`evaluation` ALTER COLUMN `efficiency_rating` SET TAGS ('pii_value_regex' = 'highly_satisfactory|satisfactory|moderately_satisfactory|moderately_unsatisfactory|unsatisfactory|highly_unsatisfactory');
ALTER TABLE `vibe_ngo_v1`.`mel`.`evaluation` ALTER COLUMN `ethics_approval_obtained` SET TAGS ('pii_business_glossary_term' = 'Ethics Approval Obtained');
ALTER TABLE `vibe_ngo_v1`.`mel`.`evaluation` ALTER COLUMN `evaluation_status` SET TAGS ('pii_business_glossary_term' = 'Evaluation Status');
ALTER TABLE `vibe_ngo_v1`.`mel`.`evaluation` ALTER COLUMN `evaluation_type` SET TAGS ('pii_business_glossary_term' = 'Evaluation Type');
ALTER TABLE `vibe_ngo_v1`.`mel`.`evaluation` ALTER COLUMN `evaluator_type` SET TAGS ('pii_business_glossary_term' = 'Evaluator Type');
ALTER TABLE `vibe_ngo_v1`.`mel`.`evaluation` ALTER COLUMN `evaluator_type` SET TAGS ('pii_value_regex' = 'internal|external|joint|participatory');
ALTER TABLE `vibe_ngo_v1`.`mel`.`evaluation` ALTER COLUMN `findings_summary` SET TAGS ('pii_business_glossary_term' = 'Findings Summary');
ALTER TABLE `vibe_ngo_v1`.`mel`.`evaluation` ALTER COLUMN `geographic_coverage` SET TAGS ('pii_business_glossary_term' = 'Geographic Coverage');
ALTER TABLE `vibe_ngo_v1`.`mel`.`evaluation` ALTER COLUMN `impact_rating` SET TAGS ('pii_business_glossary_term' = 'Impact Rating');
ALTER TABLE `vibe_ngo_v1`.`mel`.`evaluation` ALTER COLUMN `impact_rating` SET TAGS ('pii_value_regex' = 'highly_satisfactory|satisfactory|moderately_satisfactory|moderately_unsatisfactory|unsatisfactory|highly_unsatisfactory');
ALTER TABLE `vibe_ngo_v1`.`mel`.`evaluation` ALTER COLUMN `lead_evaluator_name` SET TAGS ('pii_business_glossary_term' = 'Lead Evaluator Name');
ALTER TABLE `vibe_ngo_v1`.`mel`.`evaluation` ALTER COLUMN `lead_evaluator_name` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`mel`.`evaluation` ALTER COLUMN `lead_evaluator_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`mel`.`evaluation` ALTER COLUMN `lead_evaluator_name` SET TAGS ('pii_type' = 'name');
ALTER TABLE `vibe_ngo_v1`.`mel`.`evaluation` ALTER COLUMN `lessons_learned` SET TAGS ('pii_business_glossary_term' = 'Lessons Learned');
ALTER TABLE `vibe_ngo_v1`.`mel`.`evaluation` ALTER COLUMN `management_response_date` SET TAGS ('pii_business_glossary_term' = 'Management Response Date');
ALTER TABLE `vibe_ngo_v1`.`mel`.`evaluation` ALTER COLUMN `management_response_status` SET TAGS ('pii_business_glossary_term' = 'Management Response Status');
ALTER TABLE `vibe_ngo_v1`.`mel`.`evaluation` ALTER COLUMN `management_response_status` SET TAGS ('pii_value_regex' = 'pending|in_progress|completed|not_required');
ALTER TABLE `vibe_ngo_v1`.`mel`.`evaluation` ALTER COLUMN `methodology` SET TAGS ('pii_business_glossary_term' = 'Evaluation Methodology');
ALTER TABLE `vibe_ngo_v1`.`mel`.`evaluation` ALTER COLUMN `modified_timestamp` SET TAGS ('pii_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_ngo_v1`.`mel`.`evaluation` ALTER COLUMN `overall_rating` SET TAGS ('pii_business_glossary_term' = 'Overall Rating');
ALTER TABLE `vibe_ngo_v1`.`mel`.`evaluation` ALTER COLUMN `overall_rating` SET TAGS ('pii_value_regex' = 'highly_satisfactory|satisfactory|moderately_satisfactory|moderately_unsatisfactory|unsatisfactory|highly_unsatisfactory');
ALTER TABLE `vibe_ngo_v1`.`mel`.`evaluation` ALTER COLUMN `planned_end_date` SET TAGS ('pii_business_glossary_term' = 'Planned End Date');
ALTER TABLE `vibe_ngo_v1`.`mel`.`evaluation` ALTER COLUMN `planned_start_date` SET TAGS ('pii_business_glossary_term' = 'Planned Start Date');
ALTER TABLE `vibe_ngo_v1`.`mel`.`evaluation` ALTER COLUMN `purpose` SET TAGS ('pii_business_glossary_term' = 'Evaluation Purpose');
ALTER TABLE `vibe_ngo_v1`.`mel`.`evaluation` ALTER COLUMN `purpose` SET TAGS ('pii_value_regex' = 'accountability|learning|decision_making|compliance');
ALTER TABLE `vibe_ngo_v1`.`mel`.`evaluation` ALTER COLUMN `quality_assurance_conducted` SET TAGS ('pii_business_glossary_term' = 'Quality Assurance Conducted');
ALTER TABLE `vibe_ngo_v1`.`mel`.`evaluation` ALTER COLUMN `recommendations_summary` SET TAGS ('pii_business_glossary_term' = 'Recommendations Summary');
ALTER TABLE `vibe_ngo_v1`.`mel`.`evaluation` ALTER COLUMN `relevance_rating` SET TAGS ('pii_business_glossary_term' = 'Relevance Rating');
ALTER TABLE `vibe_ngo_v1`.`mel`.`evaluation` ALTER COLUMN `relevance_rating` SET TAGS ('pii_value_regex' = 'highly_satisfactory|satisfactory|moderately_satisfactory|moderately_unsatisfactory|unsatisfactory|highly_unsatisfactory');
ALTER TABLE `vibe_ngo_v1`.`mel`.`evaluation` ALTER COLUMN `report_url` SET TAGS ('pii_business_glossary_term' = 'Evaluation Report URL');
ALTER TABLE `vibe_ngo_v1`.`mel`.`evaluation` ALTER COLUMN `scope` SET TAGS ('pii_business_glossary_term' = 'Evaluation Scope');
ALTER TABLE `vibe_ngo_v1`.`mel`.`evaluation` ALTER COLUMN `sustainability_rating` SET TAGS ('pii_business_glossary_term' = 'Sustainability Rating');
ALTER TABLE `vibe_ngo_v1`.`mel`.`evaluation` ALTER COLUMN `sustainability_rating` SET TAGS ('pii_value_regex' = 'highly_satisfactory|satisfactory|moderately_satisfactory|moderately_unsatisfactory|unsatisfactory|highly_unsatisfactory');
ALTER TABLE `vibe_ngo_v1`.`mel`.`evaluation` ALTER COLUMN `team_size` SET TAGS ('pii_business_glossary_term' = 'Evaluation Team Size');
ALTER TABLE `vibe_ngo_v1`.`mel`.`evaluation` ALTER COLUMN `title` SET TAGS ('pii_business_glossary_term' = 'Evaluation Title');
ALTER TABLE `vibe_ngo_v1`.`mel`.`evaluation_finding` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_ngo_v1`.`mel`.`evaluation_finding` SET TAGS ('pii_subdomain' = 'evaluation_learning');
ALTER TABLE `vibe_ngo_v1`.`mel`.`evaluation_finding` SET TAGS ('pii_tier' = 'mvm');
ALTER TABLE `vibe_ngo_v1`.`mel`.`evaluation_finding` ALTER COLUMN `evaluation_finding_id` SET TAGS ('pii_business_glossary_term' = 'Evaluation Finding Identifier (ID)');
ALTER TABLE `vibe_ngo_v1`.`mel`.`evaluation_finding` ALTER COLUMN `staff_member_id` SET TAGS ('pii_business_glossary_term' = 'Action Owner Staff Member Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`mel`.`evaluation_finding` ALTER COLUMN `staff_member_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`mel`.`evaluation_finding` ALTER COLUMN `staff_member_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_ngo_v1`.`mel`.`evaluation_finding` ALTER COLUMN `advocacy_campaign_id` SET TAGS ('pii_business_glossary_term' = 'Advocacy Campaign Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`mel`.`evaluation_finding` ALTER COLUMN `award_id` SET TAGS ('pii_business_glossary_term' = 'Affected Grant Identifier (ID)');
ALTER TABLE `vibe_ngo_v1`.`mel`.`evaluation_finding` ALTER COLUMN `capacity_building_plan_id` SET TAGS ('pii_business_glossary_term' = 'Capacity Building Plan Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`mel`.`evaluation_finding` ALTER COLUMN `evaluation_id` SET TAGS ('pii_business_glossary_term' = 'Evaluation Identifier (ID)');
ALTER TABLE `vibe_ngo_v1`.`mel`.`evaluation_finding` ALTER COLUMN `intervention_id` SET TAGS ('pii_business_glossary_term' = 'Affected Program Identifier (ID)');
ALTER TABLE `vibe_ngo_v1`.`mel`.`evaluation_finding` ALTER COLUMN `partner_org_id` SET TAGS ('pii_business_glossary_term' = 'Partner Org Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`mel`.`evaluation_finding` ALTER COLUMN `partner_performance_review_id` SET TAGS ('pii_business_glossary_term' = 'Partner Performance Review Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`mel`.`evaluation_finding` ALTER COLUMN `action_plan` SET TAGS ('pii_business_glossary_term' = 'Action Plan');
ALTER TABLE `vibe_ngo_v1`.`mel`.`evaluation_finding` ALTER COLUMN `actual_completion_date` SET TAGS ('pii_business_glossary_term' = 'Actual Completion Date');
ALTER TABLE `vibe_ngo_v1`.`mel`.`evaluation_finding` ALTER COLUMN `beneficiary_category` SET TAGS ('pii_business_glossary_term' = 'Beneficiary Category');
ALTER TABLE `vibe_ngo_v1`.`mel`.`evaluation_finding` ALTER COLUMN `closure_notes` SET TAGS ('pii_business_glossary_term' = 'Closure Notes');
ALTER TABLE `vibe_ngo_v1`.`mel`.`evaluation_finding` ALTER COLUMN `confidentiality_level` SET TAGS ('pii_business_glossary_term' = 'Confidentiality Level');
ALTER TABLE `vibe_ngo_v1`.`mel`.`evaluation_finding` ALTER COLUMN `confidentiality_level` SET TAGS ('pii_value_regex' = 'public|internal|confidential|restricted');
ALTER TABLE `vibe_ngo_v1`.`mel`.`evaluation_finding` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_ngo_v1`.`mel`.`evaluation_finding` ALTER COLUMN `cross_cutting_theme` SET TAGS ('pii_business_glossary_term' = 'Cross-Cutting Theme');
ALTER TABLE `vibe_ngo_v1`.`mel`.`evaluation_finding` ALTER COLUMN `dac_criterion` SET TAGS ('pii_business_glossary_term' = 'Development Assistance Committee (DAC) Criterion');
ALTER TABLE `vibe_ngo_v1`.`mel`.`evaluation_finding` ALTER COLUMN `dac_criterion` SET TAGS ('pii_value_regex' = 'relevance|coherence|effectiveness|efficiency|impact|sustainability');
ALTER TABLE `vibe_ngo_v1`.`mel`.`evaluation_finding` ALTER COLUMN `data_collection_method` SET TAGS ('pii_business_glossary_term' = 'Data Collection Method');
ALTER TABLE `vibe_ngo_v1`.`mel`.`evaluation_finding` ALTER COLUMN `donor_visibility_flag` SET TAGS ('pii_business_glossary_term' = 'Donor Visibility Flag');
ALTER TABLE `vibe_ngo_v1`.`mel`.`evaluation_finding` ALTER COLUMN `evaluator_name` SET TAGS ('pii_business_glossary_term' = 'Evaluator Name');
ALTER TABLE `vibe_ngo_v1`.`mel`.`evaluation_finding` ALTER COLUMN `evaluator_name` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`mel`.`evaluation_finding` ALTER COLUMN `evaluator_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`mel`.`evaluation_finding` ALTER COLUMN `evaluator_name` SET TAGS ('pii_type' = 'name');
ALTER TABLE `vibe_ngo_v1`.`mel`.`evaluation_finding` ALTER COLUMN `evidence_base` SET TAGS ('pii_business_glossary_term' = 'Evidence Base');
ALTER TABLE `vibe_ngo_v1`.`mel`.`evaluation_finding` ALTER COLUMN `finding_date` SET TAGS ('pii_business_glossary_term' = 'Finding Date');
ALTER TABLE `vibe_ngo_v1`.`mel`.`evaluation_finding` ALTER COLUMN `finding_number` SET TAGS ('pii_business_glossary_term' = 'Finding Number');
ALTER TABLE `vibe_ngo_v1`.`mel`.`evaluation_finding` ALTER COLUMN `finding_statement` SET TAGS ('pii_business_glossary_term' = 'Finding Statement');
ALTER TABLE `vibe_ngo_v1`.`mel`.`evaluation_finding` ALTER COLUMN `finding_type` SET TAGS ('pii_business_glossary_term' = 'Finding Type');
ALTER TABLE `vibe_ngo_v1`.`mel`.`evaluation_finding` ALTER COLUMN `finding_type` SET TAGS ('pii_value_regex' = 'finding|conclusion|recommendation|lesson_learned|good_practice');
ALTER TABLE `vibe_ngo_v1`.`mel`.`evaluation_finding` ALTER COLUMN `geographic_scope` SET TAGS ('pii_business_glossary_term' = 'Geographic Scope');
ALTER TABLE `vibe_ngo_v1`.`mel`.`evaluation_finding` ALTER COLUMN `implementation_progress_percentage` SET TAGS ('pii_business_glossary_term' = 'Implementation Progress Percentage');
ALTER TABLE `vibe_ngo_v1`.`mel`.`evaluation_finding` ALTER COLUMN `implementation_status` SET TAGS ('pii_business_glossary_term' = 'Implementation Status');
ALTER TABLE `vibe_ngo_v1`.`mel`.`evaluation_finding` ALTER COLUMN `implementation_status` SET TAGS ('pii_value_regex' = 'not_started|in_progress|partially_implemented|fully_implemented|closed|rejected');
ALTER TABLE `vibe_ngo_v1`.`mel`.`evaluation_finding` ALTER COLUMN `last_review_date` SET TAGS ('pii_business_glossary_term' = 'Last Review Date');
ALTER TABLE `vibe_ngo_v1`.`mel`.`evaluation_finding` ALTER COLUMN `management_response` SET TAGS ('pii_business_glossary_term' = 'Management Response');
ALTER TABLE `vibe_ngo_v1`.`mel`.`evaluation_finding` ALTER COLUMN `modified_timestamp` SET TAGS ('pii_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_ngo_v1`.`mel`.`evaluation_finding` ALTER COLUMN `next_review_date` SET TAGS ('pii_business_glossary_term' = 'Next Review Date');
ALTER TABLE `vibe_ngo_v1`.`mel`.`evaluation_finding` ALTER COLUMN `priority_level` SET TAGS ('pii_business_glossary_term' = 'Priority Level');
ALTER TABLE `vibe_ngo_v1`.`mel`.`evaluation_finding` ALTER COLUMN `priority_level` SET TAGS ('pii_value_regex' = 'critical|high|medium|low');
ALTER TABLE `vibe_ngo_v1`.`mel`.`evaluation_finding` ALTER COLUMN `rating` SET TAGS ('pii_business_glossary_term' = 'Finding Rating');
ALTER TABLE `vibe_ngo_v1`.`mel`.`evaluation_finding` ALTER COLUMN `rating` SET TAGS ('pii_value_regex' = 'highly_satisfactory|satisfactory|moderately_satisfactory|moderately_unsatisfactory|unsatisfactory|highly_unsatisfactory');
ALTER TABLE `vibe_ngo_v1`.`mel`.`evaluation_finding` ALTER COLUMN `responsible_unit` SET TAGS ('pii_business_glossary_term' = 'Responsible Unit');
ALTER TABLE `vibe_ngo_v1`.`mel`.`evaluation_finding` ALTER COLUMN `risk_implication` SET TAGS ('pii_business_glossary_term' = 'Risk Implication');
ALTER TABLE `vibe_ngo_v1`.`mel`.`evaluation_finding` ALTER COLUMN `sdg_alignment` SET TAGS ('pii_business_glossary_term' = 'Sustainable Development Goal (SDG) Alignment');
ALTER TABLE `vibe_ngo_v1`.`mel`.`evaluation_finding` ALTER COLUMN `sector` SET TAGS ('pii_business_glossary_term' = 'Sector');
ALTER TABLE `vibe_ngo_v1`.`mel`.`evaluation_finding` ALTER COLUMN `target_completion_date` SET TAGS ('pii_business_glossary_term' = 'Target Completion Date');
ALTER TABLE `vibe_ngo_v1`.`mel`.`qualitative_record` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_ngo_v1`.`mel`.`qualitative_record` SET TAGS ('pii_subdomain' = 'data_collection');
ALTER TABLE `vibe_ngo_v1`.`mel`.`qualitative_record` SET TAGS ('pii_tier' = 'mvm');
ALTER TABLE `vibe_ngo_v1`.`mel`.`qualitative_record` ALTER COLUMN `qualitative_record_id` SET TAGS ('pii_business_glossary_term' = 'Qualitative Record Identifier');
ALTER TABLE `vibe_ngo_v1`.`mel`.`qualitative_record` ALTER COLUMN `data_collection_tool_id` SET TAGS ('pii_business_glossary_term' = 'Data Collection Tool Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`mel`.`qualitative_record` ALTER COLUMN `volunteer_id` SET TAGS ('pii_business_glossary_term' = 'Data Collector Volunteer Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`mel`.`qualitative_record` ALTER COLUMN `volunteer_id` SET TAGS ('pii_type' = 'personal');
ALTER TABLE `vibe_ngo_v1`.`mel`.`qualitative_record` ALTER COLUMN `field_monitoring_visit_id` SET TAGS ('pii_business_glossary_term' = 'Field Monitoring Visit Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`mel`.`qualitative_record` ALTER COLUMN `intervention_id` SET TAGS ('pii_business_glossary_term' = 'Program ID');
ALTER TABLE `vibe_ngo_v1`.`mel`.`qualitative_record` ALTER COLUMN `evaluation_id` SET TAGS ('pii_business_glossary_term' = 'Linked Evaluation ID');
ALTER TABLE `vibe_ngo_v1`.`mel`.`qualitative_record` ALTER COLUMN `indicator_id` SET TAGS ('pii_business_glossary_term' = 'Linked Indicator ID');
ALTER TABLE `vibe_ngo_v1`.`mel`.`qualitative_record` ALTER COLUMN `meal_plan_id` SET TAGS ('pii_business_glossary_term' = 'Meal Plan Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`mel`.`qualitative_record` ALTER COLUMN `partner_org_id` SET TAGS ('pii_business_glossary_term' = 'Partner Org Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`mel`.`qualitative_record` ALTER COLUMN `staff_member_id` SET TAGS ('pii_business_glossary_term' = 'Facilitator Staff ID');
ALTER TABLE `vibe_ngo_v1`.`mel`.`qualitative_record` ALTER COLUMN `staff_member_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`mel`.`qualitative_record` ALTER COLUMN `staff_member_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_ngo_v1`.`mel`.`qualitative_record` ALTER COLUMN `project_site_id` SET TAGS ('pii_business_glossary_term' = 'Project Site ID');
ALTER TABLE `vibe_ngo_v1`.`mel`.`qualitative_record` ALTER COLUMN `registrant_id` SET TAGS ('pii_business_glossary_term' = 'Registrant Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`mel`.`qualitative_record` ALTER COLUMN `registrant_id` SET TAGS ('pii_type' = 'personal');
ALTER TABLE `vibe_ngo_v1`.`mel`.`qualitative_record` ALTER COLUMN `safeguarding_incident_id` SET TAGS ('pii_business_glossary_term' = 'Safeguarding Incident Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`mel`.`qualitative_record` ALTER COLUMN `system_platform_id` SET TAGS ('pii_business_glossary_term' = 'System Platform Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`mel`.`qualitative_record` ALTER COLUMN `tertiary_qualitative_translator_staff_staff_member_id` SET TAGS ('pii_business_glossary_term' = 'Translator Staff ID');
ALTER TABLE `vibe_ngo_v1`.`mel`.`qualitative_record` ALTER COLUMN `tertiary_qualitative_translator_staff_staff_member_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`mel`.`qualitative_record` ALTER COLUMN `tertiary_qualitative_translator_staff_staff_member_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_ngo_v1`.`mel`.`qualitative_record` ALTER COLUMN `admin_level_1` SET TAGS ('pii_business_glossary_term' = 'Administrative Level 1');
ALTER TABLE `vibe_ngo_v1`.`mel`.`qualitative_record` ALTER COLUMN `admin_level_2` SET TAGS ('pii_business_glossary_term' = 'Administrative Level 2');
ALTER TABLE `vibe_ngo_v1`.`mel`.`qualitative_record` ALTER COLUMN `collection_date` SET TAGS ('pii_business_glossary_term' = 'Collection Date');
ALTER TABLE `vibe_ngo_v1`.`mel`.`qualitative_record` ALTER COLUMN `collection_end_time` SET TAGS ('pii_business_glossary_term' = 'Collection End Time');
ALTER TABLE `vibe_ngo_v1`.`mel`.`qualitative_record` ALTER COLUMN `collection_method_type` SET TAGS ('pii_business_glossary_term' = 'Collection Method Type');
ALTER TABLE `vibe_ngo_v1`.`mel`.`qualitative_record` ALTER COLUMN `collection_method_type` SET TAGS ('pii_value_regex' = 'FGD|KII|Case Study|MSC Story|Observation|Participatory Assessment');
ALTER TABLE `vibe_ngo_v1`.`mel`.`qualitative_record` ALTER COLUMN `collection_start_time` SET TAGS ('pii_business_glossary_term' = 'Collection Start Time');
ALTER TABLE `vibe_ngo_v1`.`mel`.`qualitative_record` ALTER COLUMN `community_name` SET TAGS ('pii_business_glossary_term' = 'Community Name');
ALTER TABLE `vibe_ngo_v1`.`mel`.`qualitative_record` ALTER COLUMN `community_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`mel`.`qualitative_record` ALTER COLUMN `community_name` SET TAGS ('pii_type' = 'name');
ALTER TABLE `vibe_ngo_v1`.`mel`.`qualitative_record` ALTER COLUMN `consent_form_version` SET TAGS ('pii_business_glossary_term' = 'Consent Form Version');
ALTER TABLE `vibe_ngo_v1`.`mel`.`qualitative_record` ALTER COLUMN `country_code` SET TAGS ('pii_business_glossary_term' = 'Country Code');
ALTER TABLE `vibe_ngo_v1`.`mel`.`qualitative_record` ALTER COLUMN `country_code` SET TAGS ('pii_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_ngo_v1`.`mel`.`qualitative_record` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_ngo_v1`.`mel`.`qualitative_record` ALTER COLUMN `data_quality_rating` SET TAGS ('pii_business_glossary_term' = 'Data Quality Rating');
ALTER TABLE `vibe_ngo_v1`.`mel`.`qualitative_record` ALTER COLUMN `data_quality_rating` SET TAGS ('pii_value_regex' = 'Excellent|Good|Fair|Poor');
ALTER TABLE `vibe_ngo_v1`.`mel`.`qualitative_record` ALTER COLUMN `findings_summary` SET TAGS ('pii_business_glossary_term' = 'Findings Summary');
ALTER TABLE `vibe_ngo_v1`.`mel`.`qualitative_record` ALTER COLUMN `informant_organization` SET TAGS ('pii_business_glossary_term' = 'Informant Organization');
ALTER TABLE `vibe_ngo_v1`.`mel`.`qualitative_record` ALTER COLUMN `informant_role` SET TAGS ('pii_business_glossary_term' = 'Informant Role');
ALTER TABLE `vibe_ngo_v1`.`mel`.`qualitative_record` ALTER COLUMN `informed_consent_obtained` SET TAGS ('pii_business_glossary_term' = 'Informed Consent Obtained');
ALTER TABLE `vibe_ngo_v1`.`mel`.`qualitative_record` ALTER COLUMN `key_themes_emerging` SET TAGS ('pii_business_glossary_term' = 'Key Themes Emerging');
ALTER TABLE `vibe_ngo_v1`.`mel`.`qualitative_record` ALTER COLUMN `language_used` SET TAGS ('pii_business_glossary_term' = 'Language Used');
ALTER TABLE `vibe_ngo_v1`.`mel`.`qualitative_record` ALTER COLUMN `last_modified_timestamp` SET TAGS ('pii_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_ngo_v1`.`mel`.`qualitative_record` ALTER COLUMN `participant_age_group_distribution` SET TAGS ('pii_business_glossary_term' = 'Participant Age Group Distribution');
ALTER TABLE `vibe_ngo_v1`.`mel`.`qualitative_record` ALTER COLUMN `participant_age_group_distribution` SET TAGS ('pii_type' = 'age');
ALTER TABLE `vibe_ngo_v1`.`mel`.`qualitative_record` ALTER COLUMN `participant_count` SET TAGS ('pii_business_glossary_term' = 'Participant Count');
ALTER TABLE `vibe_ngo_v1`.`mel`.`qualitative_record` ALTER COLUMN `participant_female_count` SET TAGS ('pii_business_glossary_term' = 'Participant Female Count');
ALTER TABLE `vibe_ngo_v1`.`mel`.`qualitative_record` ALTER COLUMN `participant_male_count` SET TAGS ('pii_business_glossary_term' = 'Participant Male Count');
ALTER TABLE `vibe_ngo_v1`.`mel`.`qualitative_record` ALTER COLUMN `participant_other_gender_count` SET TAGS ('pii_business_glossary_term' = 'Participant Other Gender Count');
ALTER TABLE `vibe_ngo_v1`.`mel`.`qualitative_record` ALTER COLUMN `participant_other_gender_count` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`mel`.`qualitative_record` ALTER COLUMN `participant_other_gender_count` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_ngo_v1`.`mel`.`qualitative_record` ALTER COLUMN `participant_other_gender_count` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`mel`.`qualitative_record` ALTER COLUMN `primary_theme` SET TAGS ('pii_business_glossary_term' = 'Primary Theme');
ALTER TABLE `vibe_ngo_v1`.`mel`.`qualitative_record` ALTER COLUMN `qualitative_record_status` SET TAGS ('pii_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_ngo_v1`.`mel`.`qualitative_record` ALTER COLUMN `qualitative_record_status` SET TAGS ('pii_value_regex' = 'Draft|Completed|Reviewed|Approved|Archived');
ALTER TABLE `vibe_ngo_v1`.`mel`.`qualitative_record` ALTER COLUMN `recommendations` SET TAGS ('pii_business_glossary_term' = 'Recommendations');
ALTER TABLE `vibe_ngo_v1`.`mel`.`qualitative_record` ALTER COLUMN `recording_consent_obtained` SET TAGS ('pii_business_glossary_term' = 'Recording Consent Obtained');
ALTER TABLE `vibe_ngo_v1`.`mel`.`qualitative_record` ALTER COLUMN `recording_method` SET TAGS ('pii_business_glossary_term' = 'Recording Method');
ALTER TABLE `vibe_ngo_v1`.`mel`.`qualitative_record` ALTER COLUMN `recording_method` SET TAGS ('pii_value_regex' = 'Audio Recording|Video Recording|Written Notes|Digital Form');
ALTER TABLE `vibe_ngo_v1`.`mel`.`qualitative_record` ALTER COLUMN `review_date` SET TAGS ('pii_business_glossary_term' = 'Review Date');
ALTER TABLE `vibe_ngo_v1`.`mel`.`qualitative_record` ALTER COLUMN `topic_guide_used` SET TAGS ('pii_business_glossary_term' = 'Topic Guide Used');
ALTER TABLE `vibe_ngo_v1`.`mel`.`qualitative_record` ALTER COLUMN `translation_required` SET TAGS ('pii_business_glossary_term' = 'Translation Required');
ALTER TABLE `vibe_ngo_v1`.`mel`.`qualitative_record` ALTER COLUMN `verbatim_quotes` SET TAGS ('pii_business_glossary_term' = 'Verbatim Quotes');
ALTER TABLE `vibe_ngo_v1`.`mel`.`qualitative_record` ALTER COLUMN `verbatim_quotes` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`mel`.`dhis2_aggregate_report` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_ngo_v1`.`mel`.`dhis2_aggregate_report` SET TAGS ('pii_subdomain' = 'data_collection');
ALTER TABLE `vibe_ngo_v1`.`mel`.`dhis2_aggregate_report` SET TAGS ('pii_tier' = 'mvm');
ALTER TABLE `vibe_ngo_v1`.`mel`.`dhis2_aggregate_report` SET TAGS ('pii_column_comment_framework' = 'WHO + IATI + DHIS2');
ALTER TABLE `vibe_ngo_v1`.`mel`.`dhis2_aggregate_report` ALTER COLUMN `dhis2_aggregate_report_id` SET TAGS ('pii_business_glossary_term' = 'DHIS2 Aggregate Report ID');
ALTER TABLE `vibe_ngo_v1`.`mel`.`dhis2_aggregate_report` ALTER COLUMN `award_id` SET TAGS ('pii_business_glossary_term' = 'Grant ID');
ALTER TABLE `vibe_ngo_v1`.`mel`.`dhis2_aggregate_report` ALTER COLUMN `intervention_id` SET TAGS ('pii_business_glossary_term' = 'Program ID');
ALTER TABLE `vibe_ngo_v1`.`mel`.`dhis2_aggregate_report` ALTER COLUMN `org_unit_id` SET TAGS ('pii_business_glossary_term' = 'Organisation Unit ID');
ALTER TABLE `vibe_ngo_v1`.`mel`.`dhis2_aggregate_report` ALTER COLUMN `partner_org_id` SET TAGS ('pii_business_glossary_term' = 'Partner Org Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`mel`.`dhis2_aggregate_report` ALTER COLUMN `reporting_period_id` SET TAGS ('pii_business_glossary_term' = 'Reporting Period ID');
ALTER TABLE `vibe_ngo_v1`.`mel`.`dhis2_aggregate_report` ALTER COLUMN `user_account_id` SET TAGS ('pii_business_glossary_term' = 'Reporting User ID');
ALTER TABLE `vibe_ngo_v1`.`mel`.`dhis2_aggregate_report` ALTER COLUMN `approval_date` SET TAGS ('pii_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_ngo_v1`.`mel`.`dhis2_aggregate_report` ALTER COLUMN `approval_status` SET TAGS ('pii_business_glossary_term' = 'Approval Status');
ALTER TABLE `vibe_ngo_v1`.`mel`.`dhis2_aggregate_report` ALTER COLUMN `approval_status` SET TAGS ('pii_value_regex' = 'not_submitted|pending|approved|rejected');
ALTER TABLE `vibe_ngo_v1`.`mel`.`dhis2_aggregate_report` ALTER COLUMN `approved_by` SET TAGS ('pii_business_glossary_term' = 'Approved By');
ALTER TABLE `vibe_ngo_v1`.`mel`.`dhis2_aggregate_report` ALTER COLUMN `comments` SET TAGS ('pii_business_glossary_term' = 'Comments');
ALTER TABLE `vibe_ngo_v1`.`mel`.`dhis2_aggregate_report` ALTER COLUMN `completeness_percentage` SET TAGS ('pii_business_glossary_term' = 'Completeness Percentage');
ALTER TABLE `vibe_ngo_v1`.`mel`.`dhis2_aggregate_report` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_ngo_v1`.`mel`.`dhis2_aggregate_report` ALTER COLUMN `data_quality_flag` SET TAGS ('pii_business_glossary_term' = 'Data Quality Flag');
ALTER TABLE `vibe_ngo_v1`.`mel`.`dhis2_aggregate_report` ALTER COLUMN `data_quality_score` SET TAGS ('pii_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_ngo_v1`.`mel`.`dhis2_aggregate_report` ALTER COLUMN `data_set_name` SET TAGS ('pii_business_glossary_term' = 'Data Set Name');
ALTER TABLE `vibe_ngo_v1`.`mel`.`dhis2_aggregate_report` ALTER COLUMN `data_set_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`mel`.`dhis2_aggregate_report` ALTER COLUMN `data_set_name` SET TAGS ('pii_type' = 'name');
ALTER TABLE `vibe_ngo_v1`.`mel`.`dhis2_aggregate_report` ALTER COLUMN `dhis2_data_set_code` SET TAGS ('pii_business_glossary_term' = 'Data Set ID');
ALTER TABLE `vibe_ngo_v1`.`mel`.`dhis2_aggregate_report` ALTER COLUMN `indicator_count` SET TAGS ('pii_business_glossary_term' = 'Indicator Count');
ALTER TABLE `vibe_ngo_v1`.`mel`.`dhis2_aggregate_report` ALTER COLUMN `integration_status` SET TAGS ('pii_business_glossary_term' = 'Integration Status');
ALTER TABLE `vibe_ngo_v1`.`mel`.`dhis2_aggregate_report` ALTER COLUMN `integration_status` SET TAGS ('pii_value_regex' = 'pending|integrated|failed|reconciled');
ALTER TABLE `vibe_ngo_v1`.`mel`.`dhis2_aggregate_report` ALTER COLUMN `integration_timestamp` SET TAGS ('pii_business_glossary_term' = 'Integration Timestamp');
ALTER TABLE `vibe_ngo_v1`.`mel`.`dhis2_aggregate_report` ALTER COLUMN `last_modified_timestamp` SET TAGS ('pii_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_ngo_v1`.`mel`.`dhis2_aggregate_report` ALTER COLUMN `report_identifier` SET TAGS ('pii_business_glossary_term' = 'Report Identifier');
ALTER TABLE `vibe_ngo_v1`.`mel`.`dhis2_aggregate_report` ALTER COLUMN `report_status` SET TAGS ('pii_business_glossary_term' = 'Report Status');
ALTER TABLE `vibe_ngo_v1`.`mel`.`dhis2_aggregate_report` ALTER COLUMN `report_status` SET TAGS ('pii_value_regex' = 'draft|submitted|approved|rejected|pending_review|completed');
ALTER TABLE `vibe_ngo_v1`.`mel`.`dhis2_aggregate_report` ALTER COLUMN `reporting_period_end_date` SET TAGS ('pii_business_glossary_term' = 'Reporting Period End Date');
ALTER TABLE `vibe_ngo_v1`.`mel`.`dhis2_aggregate_report` ALTER COLUMN `reporting_period_start_date` SET TAGS ('pii_business_glossary_term' = 'Reporting Period Start Date');
ALTER TABLE `vibe_ngo_v1`.`mel`.`dhis2_aggregate_report` ALTER COLUMN `reporting_period_type` SET TAGS ('pii_business_glossary_term' = 'Reporting Period Type');
ALTER TABLE `vibe_ngo_v1`.`mel`.`dhis2_aggregate_report` ALTER COLUMN `reporting_period_type` SET TAGS ('pii_value_regex' = 'daily|weekly|monthly|quarterly|annual');
ALTER TABLE `vibe_ngo_v1`.`mel`.`dhis2_aggregate_report` ALTER COLUMN `reporting_user_name` SET TAGS ('pii_business_glossary_term' = 'Reporting User Name');
ALTER TABLE `vibe_ngo_v1`.`mel`.`dhis2_aggregate_report` ALTER COLUMN `reporting_user_name` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`mel`.`dhis2_aggregate_report` ALTER COLUMN `reporting_user_name` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_ngo_v1`.`mel`.`dhis2_aggregate_report` ALTER COLUMN `reporting_user_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`mel`.`dhis2_aggregate_report` ALTER COLUMN `submission_date` SET TAGS ('pii_business_glossary_term' = 'Submission Date');
ALTER TABLE `vibe_ngo_v1`.`mel`.`dhis2_aggregate_report` ALTER COLUMN `submission_timestamp` SET TAGS ('pii_business_glossary_term' = 'Submission Timestamp');
ALTER TABLE `vibe_ngo_v1`.`mel`.`dhis2_aggregate_report` ALTER COLUMN `validation_rule_violations` SET TAGS ('pii_business_glossary_term' = 'Validation Rule Violations');
ALTER TABLE `vibe_ngo_v1`.`mel`.`learning_agenda` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_ngo_v1`.`mel`.`learning_agenda` SET TAGS ('pii_subdomain' = 'evaluation_learning');
ALTER TABLE `vibe_ngo_v1`.`mel`.`learning_agenda` SET TAGS ('pii_tier' = 'mvm');
ALTER TABLE `vibe_ngo_v1`.`mel`.`learning_agenda` ALTER COLUMN `learning_agenda_id` SET TAGS ('pii_business_glossary_term' = 'Learning Agenda ID');
ALTER TABLE `vibe_ngo_v1`.`mel`.`learning_agenda` ALTER COLUMN `award_id` SET TAGS ('pii_business_glossary_term' = 'Grant ID');
ALTER TABLE `vibe_ngo_v1`.`mel`.`learning_agenda` ALTER COLUMN `capacity_building_plan_id` SET TAGS ('pii_business_glossary_term' = 'Capacity Building Plan Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`mel`.`learning_agenda` ALTER COLUMN `intervention_id` SET TAGS ('pii_business_glossary_term' = 'Program ID');
ALTER TABLE `vibe_ngo_v1`.`mel`.`learning_agenda` ALTER COLUMN `evaluation_id` SET TAGS ('pii_business_glossary_term' = 'Linked Evaluation ID');
ALTER TABLE `vibe_ngo_v1`.`mel`.`learning_agenda` ALTER COLUMN `indicator_id` SET TAGS ('pii_business_glossary_term' = 'Linked Indicator ID');
ALTER TABLE `vibe_ngo_v1`.`mel`.`learning_agenda` ALTER COLUMN `mel_logframe_id` SET TAGS ('pii_business_glossary_term' = 'Mel Logframe Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`mel`.`learning_agenda` ALTER COLUMN `partner_org_id` SET TAGS ('pii_business_glossary_term' = 'Partner Org Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`mel`.`learning_agenda` ALTER COLUMN `plan_id` SET TAGS ('pii_business_glossary_term' = 'Communication Plan Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`mel`.`learning_agenda` ALTER COLUMN `staff_member_id` SET TAGS ('pii_business_glossary_term' = 'Accountable Staff ID');
ALTER TABLE `vibe_ngo_v1`.`mel`.`learning_agenda` ALTER COLUMN `staff_member_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`mel`.`learning_agenda` ALTER COLUMN `staff_member_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_ngo_v1`.`mel`.`learning_agenda` ALTER COLUMN `actual_completion_date` SET TAGS ('pii_business_glossary_term' = 'Actual Completion Date');
ALTER TABLE `vibe_ngo_v1`.`mel`.`learning_agenda` ALTER COLUMN `actual_start_date` SET TAGS ('pii_business_glossary_term' = 'Actual Start Date');
ALTER TABLE `vibe_ngo_v1`.`mel`.`learning_agenda` ALTER COLUMN `budget_allocated` SET TAGS ('pii_business_glossary_term' = 'Budget Allocated');
ALTER TABLE `vibe_ngo_v1`.`mel`.`learning_agenda` ALTER COLUMN `budget_allocated` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`mel`.`learning_agenda` ALTER COLUMN `budget_spent` SET TAGS ('pii_business_glossary_term' = 'Budget Spent');
ALTER TABLE `vibe_ngo_v1`.`mel`.`learning_agenda` ALTER COLUMN `budget_spent` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`mel`.`learning_agenda` ALTER COLUMN `collaboration_partners` SET TAGS ('pii_business_glossary_term' = 'Collaboration Partners');
ALTER TABLE `vibe_ngo_v1`.`mel`.`learning_agenda` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_ngo_v1`.`mel`.`learning_agenda` ALTER COLUMN `currency_code` SET TAGS ('pii_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_ngo_v1`.`mel`.`learning_agenda` ALTER COLUMN `currency_code` SET TAGS ('pii_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_ngo_v1`.`mel`.`learning_agenda` ALTER COLUMN `data_quality_assurance_plan` SET TAGS ('pii_business_glossary_term' = 'Data Quality Assurance Plan');
ALTER TABLE `vibe_ngo_v1`.`mel`.`learning_agenda` ALTER COLUMN `data_source` SET TAGS ('pii_business_glossary_term' = 'Data Source');
ALTER TABLE `vibe_ngo_v1`.`mel`.`learning_agenda` ALTER COLUMN `dissemination_plan` SET TAGS ('pii_business_glossary_term' = 'Dissemination Plan');
ALTER TABLE `vibe_ngo_v1`.`mel`.`learning_agenda` ALTER COLUMN `donor_reporting_requirement` SET TAGS ('pii_business_glossary_term' = 'Donor Reporting Requirement');
ALTER TABLE `vibe_ngo_v1`.`mel`.`learning_agenda` ALTER COLUMN `ethics_approval_date` SET TAGS ('pii_business_glossary_term' = 'Ethics Approval Date');
ALTER TABLE `vibe_ngo_v1`.`mel`.`learning_agenda` ALTER COLUMN `ethics_approval_required` SET TAGS ('pii_business_glossary_term' = 'Ethics Approval Required');
ALTER TABLE `vibe_ngo_v1`.`mel`.`learning_agenda` ALTER COLUMN `evidence_generation_method` SET TAGS ('pii_business_glossary_term' = 'Evidence Generation Method');
ALTER TABLE `vibe_ngo_v1`.`mel`.`learning_agenda` ALTER COLUMN `findings_summary` SET TAGS ('pii_business_glossary_term' = 'Findings Summary');
ALTER TABLE `vibe_ngo_v1`.`mel`.`learning_agenda` ALTER COLUMN `geographic_scope` SET TAGS ('pii_business_glossary_term' = 'Geographic Scope');
ALTER TABLE `vibe_ngo_v1`.`mel`.`learning_agenda` ALTER COLUMN `last_modified_by` SET TAGS ('pii_business_glossary_term' = 'Last Modified By');
ALTER TABLE `vibe_ngo_v1`.`mel`.`learning_agenda` ALTER COLUMN `last_modified_timestamp` SET TAGS ('pii_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_ngo_v1`.`mel`.`learning_agenda` ALTER COLUMN `learning_agenda_status` SET TAGS ('pii_business_glossary_term' = 'Learning Agenda Status');
ALTER TABLE `vibe_ngo_v1`.`mel`.`learning_agenda` ALTER COLUMN `learning_question_identifier` SET TAGS ('pii_business_glossary_term' = 'Learning Question Identifier');
ALTER TABLE `vibe_ngo_v1`.`mel`.`learning_agenda` ALTER COLUMN `learning_question_identifier` SET TAGS ('pii_value_regex' = '^LQ-[A-Z0-9]{6,12}$');
ALTER TABLE `vibe_ngo_v1`.`mel`.`learning_agenda` ALTER COLUMN `learning_question_text` SET TAGS ('pii_business_glossary_term' = 'Learning Question Text');
ALTER TABLE `vibe_ngo_v1`.`mel`.`learning_agenda` ALTER COLUMN `learning_question_type` SET TAGS ('pii_business_glossary_term' = 'Learning Question Type');
ALTER TABLE `vibe_ngo_v1`.`mel`.`learning_agenda` ALTER COLUMN `learning_question_type` SET TAGS ('pii_value_regex' = 'process|outcome|impact|efficiency|relevance|sustainability');
ALTER TABLE `vibe_ngo_v1`.`mel`.`learning_agenda` ALTER COLUMN `planned_completion_date` SET TAGS ('pii_business_glossary_term' = 'Planned Completion Date');
ALTER TABLE `vibe_ngo_v1`.`mel`.`learning_agenda` ALTER COLUMN `planned_start_date` SET TAGS ('pii_business_glossary_term' = 'Planned Start Date');
ALTER TABLE `vibe_ngo_v1`.`mel`.`learning_agenda` ALTER COLUMN `priority_level` SET TAGS ('pii_business_glossary_term' = 'Priority Level');
ALTER TABLE `vibe_ngo_v1`.`mel`.`learning_agenda` ALTER COLUMN `priority_level` SET TAGS ('pii_value_regex' = 'critical|high|medium|low');
ALTER TABLE `vibe_ngo_v1`.`mel`.`learning_agenda` ALTER COLUMN `rationale` SET TAGS ('pii_business_glossary_term' = 'Learning Question Rationale');
ALTER TABLE `vibe_ngo_v1`.`mel`.`learning_agenda` ALTER COLUMN `recommendations` SET TAGS ('pii_business_glossary_term' = 'Recommendations');
ALTER TABLE `vibe_ngo_v1`.`mel`.`learning_agenda` ALTER COLUMN `responsible_team` SET TAGS ('pii_business_glossary_term' = 'Responsible Team');
ALTER TABLE `vibe_ngo_v1`.`mel`.`learning_agenda` ALTER COLUMN `sdg_alignment` SET TAGS ('pii_business_glossary_term' = 'Sustainable Development Goal (SDG) Alignment');
ALTER TABLE `vibe_ngo_v1`.`mel`.`learning_agenda` ALTER COLUMN `target_population` SET TAGS ('pii_business_glossary_term' = 'Target Population');
ALTER TABLE `vibe_ngo_v1`.`mel`.`learning_agenda` ALTER COLUMN `created_by` SET TAGS ('pii_business_glossary_term' = 'Created By');
ALTER TABLE `vibe_ngo_v1`.`mel`.`data_collection_tool` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_ngo_v1`.`mel`.`data_collection_tool` SET TAGS ('pii_subdomain' = 'data_collection');
ALTER TABLE `vibe_ngo_v1`.`mel`.`data_collection_tool` SET TAGS ('pii_tier' = 'mvm');
ALTER TABLE `vibe_ngo_v1`.`mel`.`data_collection_tool` ALTER COLUMN `data_collection_tool_id` SET TAGS ('pii_business_glossary_term' = 'Data Collection Tool ID');
ALTER TABLE `vibe_ngo_v1`.`mel`.`data_collection_tool` ALTER COLUMN `assessment_id` SET TAGS ('pii_business_glossary_term' = 'Assessment Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`mel`.`data_collection_tool` ALTER COLUMN `role_id` SET TAGS ('pii_business_glossary_term' = 'Authorized Volunteer Role Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`mel`.`data_collection_tool` ALTER COLUMN `award_id` SET TAGS ('pii_business_glossary_term' = 'Grant ID');
ALTER TABLE `vibe_ngo_v1`.`mel`.`data_collection_tool` ALTER COLUMN `budget_line_id` SET TAGS ('pii_business_glossary_term' = 'Budget Line Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`mel`.`data_collection_tool` ALTER COLUMN `capacity_assessment_id` SET TAGS ('pii_business_glossary_term' = 'Capacity Assessment Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`mel`.`data_collection_tool` ALTER COLUMN `intervention_id` SET TAGS ('pii_business_glossary_term' = 'Program ID');
ALTER TABLE `vibe_ngo_v1`.`mel`.`data_collection_tool` ALTER COLUMN `meal_plan_id` SET TAGS ('pii_business_glossary_term' = 'Meal Plan Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`mel`.`data_collection_tool` ALTER COLUMN `partner_org_id` SET TAGS ('pii_business_glossary_term' = 'Partner Org Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`mel`.`data_collection_tool` ALTER COLUMN `staff_member_id` SET TAGS ('pii_business_glossary_term' = 'Approved By ID');
ALTER TABLE `vibe_ngo_v1`.`mel`.`data_collection_tool` ALTER COLUMN `staff_member_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`mel`.`data_collection_tool` ALTER COLUMN `staff_member_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_ngo_v1`.`mel`.`data_collection_tool` ALTER COLUMN `program_logframe_id` SET TAGS ('pii_business_glossary_term' = 'Logical Framework (LogFrame) ID');
ALTER TABLE `vibe_ngo_v1`.`mel`.`data_collection_tool` ALTER COLUMN `risk_assessment_id` SET TAGS ('pii_business_glossary_term' = 'Safeguarding Risk Assessment Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`mel`.`data_collection_tool` ALTER COLUMN `system_platform_id` SET TAGS ('pii_business_glossary_term' = 'System Platform Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`mel`.`data_collection_tool` ALTER COLUMN `additional_languages` SET TAGS ('pii_business_glossary_term' = 'Additional Languages');
ALTER TABLE `vibe_ngo_v1`.`mel`.`data_collection_tool` ALTER COLUMN `approval_date` SET TAGS ('pii_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_ngo_v1`.`mel`.`data_collection_tool` ALTER COLUMN `approval_status` SET TAGS ('pii_business_glossary_term' = 'Approval Status');
ALTER TABLE `vibe_ngo_v1`.`mel`.`data_collection_tool` ALTER COLUMN `approval_status` SET TAGS ('pii_value_regex' = 'pending|approved|rejected|revision_required');
ALTER TABLE `vibe_ngo_v1`.`mel`.`data_collection_tool` ALTER COLUMN `consent_mechanism` SET TAGS ('pii_business_glossary_term' = 'Consent Mechanism');
ALTER TABLE `vibe_ngo_v1`.`mel`.`data_collection_tool` ALTER COLUMN `consent_mechanism` SET TAGS ('pii_value_regex' = 'verbal|written|digital_signature|none');
ALTER TABLE `vibe_ngo_v1`.`mel`.`data_collection_tool` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_ngo_v1`.`mel`.`data_collection_tool` ALTER COLUMN `data_collection_method` SET TAGS ('pii_business_glossary_term' = 'Data Collection Method');
ALTER TABLE `vibe_ngo_v1`.`mel`.`data_collection_tool` ALTER COLUMN `data_protection_compliance` SET TAGS ('pii_business_glossary_term' = 'Data Protection Compliance');
ALTER TABLE `vibe_ngo_v1`.`mel`.`data_collection_tool` ALTER COLUMN `data_protection_compliance` SET TAGS ('pii_value_regex' = 'gdpr|local_dpa|chs|none|other');
ALTER TABLE `vibe_ngo_v1`.`mel`.`data_collection_tool` ALTER COLUMN `data_quality_validation_rules` SET TAGS ('pii_business_glossary_term' = 'Data Quality Validation Rules');
ALTER TABLE `vibe_ngo_v1`.`mel`.`data_collection_tool` ALTER COLUMN `deployment_end_date` SET TAGS ('pii_business_glossary_term' = 'Deployment End Date');
ALTER TABLE `vibe_ngo_v1`.`mel`.`data_collection_tool` ALTER COLUMN `deployment_start_date` SET TAGS ('pii_business_glossary_term' = 'Deployment Start Date');
ALTER TABLE `vibe_ngo_v1`.`mel`.`data_collection_tool` ALTER COLUMN `estimated_completion_time_minutes` SET TAGS ('pii_business_glossary_term' = 'Estimated Completion Time (Minutes)');
ALTER TABLE `vibe_ngo_v1`.`mel`.`data_collection_tool` ALTER COLUMN `ethical_review_status` SET TAGS ('pii_business_glossary_term' = 'Ethical Review Status');
ALTER TABLE `vibe_ngo_v1`.`mel`.`data_collection_tool` ALTER COLUMN `ethical_review_status` SET TAGS ('pii_value_regex' = 'not_required|pending|approved|exempt');
ALTER TABLE `vibe_ngo_v1`.`mel`.`data_collection_tool` ALTER COLUMN `external_tool_url` SET TAGS ('pii_business_glossary_term' = 'External Tool URL');
ALTER TABLE `vibe_ngo_v1`.`mel`.`data_collection_tool` ALTER COLUMN `geographic_scope` SET TAGS ('pii_business_glossary_term' = 'Geographic Scope');
ALTER TABLE `vibe_ngo_v1`.`mel`.`data_collection_tool` ALTER COLUMN `last_modified_timestamp` SET TAGS ('pii_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_ngo_v1`.`mel`.`data_collection_tool` ALTER COLUMN `linked_indicator_ids` SET TAGS ('pii_business_glossary_term' = 'Linked Indicator IDs');
ALTER TABLE `vibe_ngo_v1`.`mel`.`data_collection_tool` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_ngo_v1`.`mel`.`data_collection_tool` ALTER COLUMN `primary_language` SET TAGS ('pii_business_glossary_term' = 'Primary Language');
ALTER TABLE `vibe_ngo_v1`.`mel`.`data_collection_tool` ALTER COLUMN `primary_language` SET TAGS ('pii_value_regex' = '^[a-z]{2,3}$');
ALTER TABLE `vibe_ngo_v1`.`mel`.`data_collection_tool` ALTER COLUMN `question_count` SET TAGS ('pii_business_glossary_term' = 'Question Count');
ALTER TABLE `vibe_ngo_v1`.`mel`.`data_collection_tool` ALTER COLUMN `respondent_type` SET TAGS ('pii_business_glossary_term' = 'Respondent Type');
ALTER TABLE `vibe_ngo_v1`.`mel`.`data_collection_tool` ALTER COLUMN `revision_reason` SET TAGS ('pii_business_glossary_term' = 'Revision Reason');
ALTER TABLE `vibe_ngo_v1`.`mel`.`data_collection_tool` ALTER COLUMN `tool_code` SET TAGS ('pii_business_glossary_term' = 'Tool Code');
ALTER TABLE `vibe_ngo_v1`.`mel`.`data_collection_tool` ALTER COLUMN `tool_code` SET TAGS ('pii_value_regex' = '^[A-Z0-9]{6,20}$');
ALTER TABLE `vibe_ngo_v1`.`mel`.`data_collection_tool` ALTER COLUMN `tool_documentation_url` SET TAGS ('pii_business_glossary_term' = 'Tool Documentation URL');
ALTER TABLE `vibe_ngo_v1`.`mel`.`data_collection_tool` ALTER COLUMN `tool_name` SET TAGS ('pii_business_glossary_term' = 'Tool Name');
ALTER TABLE `vibe_ngo_v1`.`mel`.`data_collection_tool` ALTER COLUMN `tool_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`mel`.`data_collection_tool` ALTER COLUMN `tool_name` SET TAGS ('pii_type' = 'name');
ALTER TABLE `vibe_ngo_v1`.`mel`.`data_collection_tool` ALTER COLUMN `tool_status` SET TAGS ('pii_business_glossary_term' = 'Tool Status');
ALTER TABLE `vibe_ngo_v1`.`mel`.`data_collection_tool` ALTER COLUMN `tool_status` SET TAGS ('pii_value_regex' = 'draft|under_review|approved|active|retired|archived');
ALTER TABLE `vibe_ngo_v1`.`mel`.`data_collection_tool` ALTER COLUMN `tool_type` SET TAGS ('pii_business_glossary_term' = 'Tool Type');
ALTER TABLE `vibe_ngo_v1`.`mel`.`data_collection_tool` ALTER COLUMN `tool_type` SET TAGS ('pii_value_regex' = 'kobo_form|odk_form|commcare_module|dhis2_form|paper_survey|interview_guide');
ALTER TABLE `vibe_ngo_v1`.`mel`.`data_collection_tool` ALTER COLUMN `version_number` SET TAGS ('pii_business_glossary_term' = 'Version Number');
ALTER TABLE `vibe_ngo_v1`.`mel`.`data_collection_tool` ALTER COLUMN `version_number` SET TAGS ('pii_value_regex' = '^[0-9]+.[0-9]+(.[0-9]+)?$');
ALTER TABLE `vibe_ngo_v1`.`mel`.`mel_needs_assessment` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_ngo_v1`.`mel`.`mel_needs_assessment` SET TAGS ('pii_subdomain' = 'data_collection');
ALTER TABLE `vibe_ngo_v1`.`mel`.`mel_needs_assessment` SET TAGS ('pii_tier' = 'mvm');
ALTER TABLE `vibe_ngo_v1`.`mel`.`mel_needs_assessment` SET TAGS ('pii_ssot' = 'true');
ALTER TABLE `vibe_ngo_v1`.`mel`.`mel_needs_assessment` SET TAGS ('pii_ssot_scope' = 'mel_population_needs_assessment');
ALTER TABLE `vibe_ngo_v1`.`mel`.`mel_needs_assessment` SET TAGS ('pii_ssot_owner' = 'mel');
ALTER TABLE `vibe_ngo_v1`.`mel`.`mel_needs_assessment` SET TAGS ('pii_ssot_boundary' = 'programme_needs');
ALTER TABLE `vibe_ngo_v1`.`mel`.`mel_needs_assessment` SET TAGS ('pii_disambiguated_from' = 'beneficiary.beneficiary_needs_assessment');
ALTER TABLE `vibe_ngo_v1`.`mel`.`mel_needs_assessment` ALTER COLUMN `mel_needs_assessment_id` SET TAGS ('pii_business_glossary_term' = 'Monitoring Evaluation and Learning (MEL) Needs Assessment ID');
ALTER TABLE `vibe_ngo_v1`.`mel`.`mel_needs_assessment` ALTER COLUMN `advocacy_campaign_id` SET TAGS ('pii_business_glossary_term' = 'Advocacy Campaign Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`mel`.`mel_needs_assessment` ALTER COLUMN `award_id` SET TAGS ('pii_business_glossary_term' = 'Grant ID');
ALTER TABLE `vibe_ngo_v1`.`mel`.`mel_needs_assessment` ALTER COLUMN `country_office_id` SET TAGS ('pii_business_glossary_term' = 'Country Office ID');
ALTER TABLE `vibe_ngo_v1`.`mel`.`mel_needs_assessment` ALTER COLUMN `crisis_communication_id` SET TAGS ('pii_business_glossary_term' = 'Crisis Communication Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`mel`.`mel_needs_assessment` ALTER COLUMN `intervention_id` SET TAGS ('pii_business_glossary_term' = 'Program ID');
ALTER TABLE `vibe_ngo_v1`.`mel`.`mel_needs_assessment` ALTER COLUMN `partner_org_id` SET TAGS ('pii_business_glossary_term' = 'Partner Org Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`mel`.`mel_needs_assessment` ALTER COLUMN `staff_member_id` SET TAGS ('pii_business_glossary_term' = 'Lead Assessor ID');
ALTER TABLE `vibe_ngo_v1`.`mel`.`mel_needs_assessment` ALTER COLUMN `staff_member_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`mel`.`mel_needs_assessment` ALTER COLUMN `staff_member_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_ngo_v1`.`mel`.`mel_needs_assessment` ALTER COLUMN `admin_level_1` SET TAGS ('pii_business_glossary_term' = 'Administrative Level 1');
ALTER TABLE `vibe_ngo_v1`.`mel`.`mel_needs_assessment` ALTER COLUMN `admin_level_2` SET TAGS ('pii_business_glossary_term' = 'Administrative Level 2');
ALTER TABLE `vibe_ngo_v1`.`mel`.`mel_needs_assessment` ALTER COLUMN `assessment_code` SET TAGS ('pii_business_glossary_term' = 'Assessment Code');
ALTER TABLE `vibe_ngo_v1`.`mel`.`mel_needs_assessment` ALTER COLUMN `assessment_code` SET TAGS ('pii_value_regex' = '^[A-Z0-9]{6,20}$');
ALTER TABLE `vibe_ngo_v1`.`mel`.`mel_needs_assessment` ALTER COLUMN `assessment_end_date` SET TAGS ('pii_business_glossary_term' = 'Assessment End Date');
ALTER TABLE `vibe_ngo_v1`.`mel`.`mel_needs_assessment` ALTER COLUMN `assessment_name` SET TAGS ('pii_business_glossary_term' = 'Assessment Name');
ALTER TABLE `vibe_ngo_v1`.`mel`.`mel_needs_assessment` ALTER COLUMN `assessment_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`mel`.`mel_needs_assessment` ALTER COLUMN `assessment_name` SET TAGS ('pii_type' = 'name');
ALTER TABLE `vibe_ngo_v1`.`mel`.`mel_needs_assessment` ALTER COLUMN `assessment_start_date` SET TAGS ('pii_business_glossary_term' = 'Assessment Start Date');
ALTER TABLE `vibe_ngo_v1`.`mel`.`mel_needs_assessment` ALTER COLUMN `assessment_status` SET TAGS ('pii_business_glossary_term' = 'Assessment Status');
ALTER TABLE `vibe_ngo_v1`.`mel`.`mel_needs_assessment` ALTER COLUMN `assessment_status` SET TAGS ('pii_value_regex' = 'planned|in_progress|completed|validated|cancelled');
ALTER TABLE `vibe_ngo_v1`.`mel`.`mel_needs_assessment` ALTER COLUMN `assessment_type` SET TAGS ('pii_business_glossary_term' = 'Assessment Type');
ALTER TABLE `vibe_ngo_v1`.`mel`.`mel_needs_assessment` ALTER COLUMN `assessment_type` SET TAGS ('pii_value_regex' = 'rapid|comprehensive|sectoral|multi_sectoral|baseline|endline');
ALTER TABLE `vibe_ngo_v1`.`mel`.`mel_needs_assessment` ALTER COLUMN `country_code` SET TAGS ('pii_business_glossary_term' = 'Country Code');
ALTER TABLE `vibe_ngo_v1`.`mel`.`mel_needs_assessment` ALTER COLUMN `country_code` SET TAGS ('pii_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_ngo_v1`.`mel`.`mel_needs_assessment` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_ngo_v1`.`mel`.`mel_needs_assessment` ALTER COLUMN `dac_sector_code` SET TAGS ('pii_business_glossary_term' = 'Development Assistance Committee (DAC) Sector Code');
ALTER TABLE `vibe_ngo_v1`.`mel`.`mel_needs_assessment` ALTER COLUMN `dac_sector_code` SET TAGS ('pii_value_regex' = '^[0-9]{5}$');
ALTER TABLE `vibe_ngo_v1`.`mel`.`mel_needs_assessment` ALTER COLUMN `data_collection_method` SET TAGS ('pii_business_glossary_term' = 'Data Collection Method');
ALTER TABLE `vibe_ngo_v1`.`mel`.`mel_needs_assessment` ALTER COLUMN `data_collection_tool` SET TAGS ('pii_business_glossary_term' = 'Data Collection Tool');
ALTER TABLE `vibe_ngo_v1`.`mel`.`mel_needs_assessment` ALTER COLUMN `education_needs_priority` SET TAGS ('pii_business_glossary_term' = 'Education Needs Priority');
ALTER TABLE `vibe_ngo_v1`.`mel`.`mel_needs_assessment` ALTER COLUMN `education_needs_priority` SET TAGS ('pii_value_regex' = 'critical|high|medium|low|not_assessed');
ALTER TABLE `vibe_ngo_v1`.`mel`.`mel_needs_assessment` ALTER COLUMN `external_report_url` SET TAGS ('pii_business_glossary_term' = 'External Report Uniform Resource Locator (URL)');
ALTER TABLE `vibe_ngo_v1`.`mel`.`mel_needs_assessment` ALTER COLUMN `gam_rate_percentage` SET TAGS ('pii_business_glossary_term' = 'Global Acute Malnutrition (GAM) Rate Percentage');
ALTER TABLE `vibe_ngo_v1`.`mel`.`mel_needs_assessment` ALTER COLUMN `geographic_scope` SET TAGS ('pii_business_glossary_term' = 'Geographic Scope');
ALTER TABLE `vibe_ngo_v1`.`mel`.`mel_needs_assessment` ALTER COLUMN `health_needs_priority` SET TAGS ('pii_business_glossary_term' = 'Health Needs Priority');
ALTER TABLE `vibe_ngo_v1`.`mel`.`mel_needs_assessment` ALTER COLUMN `health_needs_priority` SET TAGS ('pii_value_regex' = 'critical|high|medium|low|not_assessed');
ALTER TABLE `vibe_ngo_v1`.`mel`.`mel_needs_assessment` ALTER COLUMN `health_needs_priority` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`mel`.`mel_needs_assessment` ALTER COLUMN `health_needs_priority` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_ngo_v1`.`mel`.`mel_needs_assessment` ALTER COLUMN `households_assessed` SET TAGS ('pii_business_glossary_term' = 'Households Assessed');
ALTER TABLE `vibe_ngo_v1`.`mel`.`mel_needs_assessment` ALTER COLUMN `key_findings_summary` SET TAGS ('pii_business_glossary_term' = 'Key Findings Summary');
ALTER TABLE `vibe_ngo_v1`.`mel`.`mel_needs_assessment` ALTER COLUMN `last_modified_timestamp` SET TAGS ('pii_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_ngo_v1`.`mel`.`mel_needs_assessment` ALTER COLUMN `muac_screening_count` SET TAGS ('pii_business_glossary_term' = 'Mid-Upper Arm Circumference (MUAC) Screening Count');
ALTER TABLE `vibe_ngo_v1`.`mel`.`mel_needs_assessment` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_ngo_v1`.`mel`.`mel_needs_assessment` ALTER COLUMN `nutrition_needs_priority` SET TAGS ('pii_business_glossary_term' = 'Nutrition Needs Priority');
ALTER TABLE `vibe_ngo_v1`.`mel`.`mel_needs_assessment` ALTER COLUMN `nutrition_needs_priority` SET TAGS ('pii_value_regex' = 'critical|high|medium|low|not_assessed');
ALTER TABLE `vibe_ngo_v1`.`mel`.`mel_needs_assessment` ALTER COLUMN `population_assessed` SET TAGS ('pii_business_glossary_term' = 'Population Assessed');
ALTER TABLE `vibe_ngo_v1`.`mel`.`mel_needs_assessment` ALTER COLUMN `protection_needs_priority` SET TAGS ('pii_business_glossary_term' = 'Protection Needs Priority');
ALTER TABLE `vibe_ngo_v1`.`mel`.`mel_needs_assessment` ALTER COLUMN `protection_needs_priority` SET TAGS ('pii_value_regex' = 'critical|high|medium|low|not_assessed');
ALTER TABLE `vibe_ngo_v1`.`mel`.`mel_needs_assessment` ALTER COLUMN `recommendations` SET TAGS ('pii_business_glossary_term' = 'Recommendations');
ALTER TABLE `vibe_ngo_v1`.`mel`.`mel_needs_assessment` ALTER COLUMN `sam_rate_percentage` SET TAGS ('pii_business_glossary_term' = 'Severe Acute Malnutrition (SAM) Rate Percentage');
ALTER TABLE `vibe_ngo_v1`.`mel`.`mel_needs_assessment` ALTER COLUMN `sample_size` SET TAGS ('pii_business_glossary_term' = 'Sample Size');
ALTER TABLE `vibe_ngo_v1`.`mel`.`mel_needs_assessment` ALTER COLUMN `sampling_method` SET TAGS ('pii_business_glossary_term' = 'Sampling Method');
ALTER TABLE `vibe_ngo_v1`.`mel`.`mel_needs_assessment` ALTER COLUMN `sampling_method` SET TAGS ('pii_value_regex' = 'random|stratified|cluster|purposive|convenience|census');
ALTER TABLE `vibe_ngo_v1`.`mel`.`mel_needs_assessment` ALTER COLUMN `sdg_alignment` SET TAGS ('pii_business_glossary_term' = 'Sustainable Development Goal (SDG) Alignment');
ALTER TABLE `vibe_ngo_v1`.`mel`.`mel_needs_assessment` ALTER COLUMN `shelter_needs_priority` SET TAGS ('pii_business_glossary_term' = 'Shelter Needs Priority');
ALTER TABLE `vibe_ngo_v1`.`mel`.`mel_needs_assessment` ALTER COLUMN `shelter_needs_priority` SET TAGS ('pii_value_regex' = 'critical|high|medium|low|not_assessed');
ALTER TABLE `vibe_ngo_v1`.`mel`.`mel_needs_assessment` ALTER COLUMN `validation_date` SET TAGS ('pii_business_glossary_term' = 'Validation Date');
ALTER TABLE `vibe_ngo_v1`.`mel`.`mel_needs_assessment` ALTER COLUMN `validation_status` SET TAGS ('pii_business_glossary_term' = 'Validation Status');
ALTER TABLE `vibe_ngo_v1`.`mel`.`mel_needs_assessment` ALTER COLUMN `validation_status` SET TAGS ('pii_value_regex' = 'pending|validated|rejected|under_review');
ALTER TABLE `vibe_ngo_v1`.`mel`.`mel_needs_assessment` ALTER COLUMN `wash_needs_priority` SET TAGS ('pii_business_glossary_term' = 'Water Sanitation and Hygiene (WASH) Needs Priority');
ALTER TABLE `vibe_ngo_v1`.`mel`.`mel_needs_assessment` ALTER COLUMN `wash_needs_priority` SET TAGS ('pii_value_regex' = 'critical|high|medium|low|not_assessed');
ALTER TABLE `vibe_ngo_v1`.`mel`.`data_quality_assessment` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_ngo_v1`.`mel`.`data_quality_assessment` SET TAGS ('pii_subdomain' = 'data_collection');
ALTER TABLE `vibe_ngo_v1`.`mel`.`data_quality_assessment` SET TAGS ('pii_tier' = 'mvm');
ALTER TABLE `vibe_ngo_v1`.`mel`.`data_quality_assessment` ALTER COLUMN `data_quality_assessment_id` SET TAGS ('pii_business_glossary_term' = 'Data Quality Assessment (DQA) Identifier');
ALTER TABLE `vibe_ngo_v1`.`mel`.`data_quality_assessment` ALTER COLUMN `audit_finding_id` SET TAGS ('pii_business_glossary_term' = 'Audit Finding Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`mel`.`data_quality_assessment` ALTER COLUMN `award_id` SET TAGS ('pii_business_glossary_term' = 'Grant Identifier');
ALTER TABLE `vibe_ngo_v1`.`mel`.`data_quality_assessment` ALTER COLUMN `capacity_assessment_id` SET TAGS ('pii_business_glossary_term' = 'Capacity Assessment Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`mel`.`data_quality_assessment` ALTER COLUMN `data_collection_tool_id` SET TAGS ('pii_business_glossary_term' = 'Data Collection Tool Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`mel`.`data_quality_assessment` ALTER COLUMN `volunteer_id` SET TAGS ('pii_business_glossary_term' = 'Data Collector Volunteer Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`mel`.`data_quality_assessment` ALTER COLUMN `volunteer_id` SET TAGS ('pii_type' = 'personal');
ALTER TABLE `vibe_ngo_v1`.`mel`.`data_quality_assessment` ALTER COLUMN `field_monitoring_visit_id` SET TAGS ('pii_business_glossary_term' = 'Field Monitoring Visit Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`mel`.`data_quality_assessment` ALTER COLUMN `followup_data_quality_assessment_id` SET TAGS ('pii_business_glossary_term' = 'Followup Data Quality Assessment Id');
ALTER TABLE `vibe_ngo_v1`.`mel`.`data_quality_assessment` ALTER COLUMN `followup_data_quality_assessment_id` SET TAGS ('pii_self_ref_fk' = 'true');
ALTER TABLE `vibe_ngo_v1`.`mel`.`data_quality_assessment` ALTER COLUMN `goods_receipt_id` SET TAGS ('pii_business_glossary_term' = 'Goods Receipt Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`mel`.`data_quality_assessment` ALTER COLUMN `indicator_id` SET TAGS ('pii_business_glossary_term' = 'Indicator Identifier');
ALTER TABLE `vibe_ngo_v1`.`mel`.`data_quality_assessment` ALTER COLUMN `intervention_id` SET TAGS ('pii_business_glossary_term' = 'Program Identifier');
ALTER TABLE `vibe_ngo_v1`.`mel`.`data_quality_assessment` ALTER COLUMN `meal_plan_id` SET TAGS ('pii_business_glossary_term' = 'Meal Plan Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`mel`.`data_quality_assessment` ALTER COLUMN `partner_org_id` SET TAGS ('pii_business_glossary_term' = 'Partner Org Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`mel`.`data_quality_assessment` ALTER COLUMN `partner_performance_review_id` SET TAGS ('pii_business_glossary_term' = 'Partner Performance Review Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`mel`.`data_quality_assessment` ALTER COLUMN `partner_report_submission_id` SET TAGS ('pii_business_glossary_term' = 'Partner Report Submission Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`mel`.`data_quality_assessment` ALTER COLUMN `staff_member_id` SET TAGS ('pii_business_glossary_term' = 'Assessor Staff Identifier');
ALTER TABLE `vibe_ngo_v1`.`mel`.`data_quality_assessment` ALTER COLUMN `staff_member_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`mel`.`data_quality_assessment` ALTER COLUMN `staff_member_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_ngo_v1`.`mel`.`data_quality_assessment` ALTER COLUMN `project_site_id` SET TAGS ('pii_business_glossary_term' = 'Project Site Identifier');
ALTER TABLE `vibe_ngo_v1`.`mel`.`data_quality_assessment` ALTER COLUMN `reviewer_staff_staff_member_id` SET TAGS ('pii_business_glossary_term' = 'Reviewer Staff Identifier');
ALTER TABLE `vibe_ngo_v1`.`mel`.`data_quality_assessment` ALTER COLUMN `reviewer_staff_staff_member_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`mel`.`data_quality_assessment` ALTER COLUMN `reviewer_staff_staff_member_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_ngo_v1`.`mel`.`data_quality_assessment` ALTER COLUMN `single_audit_id` SET TAGS ('pii_business_glossary_term' = 'Single Audit Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`mel`.`data_quality_assessment` ALTER COLUMN `accuracy_score_percentage` SET TAGS ('pii_business_glossary_term' = 'Accuracy Score Percentage');
ALTER TABLE `vibe_ngo_v1`.`mel`.`data_quality_assessment` ALTER COLUMN `assessment_code` SET TAGS ('pii_business_glossary_term' = 'Assessment Code');
ALTER TABLE `vibe_ngo_v1`.`mel`.`data_quality_assessment` ALTER COLUMN `assessment_date` SET TAGS ('pii_business_glossary_term' = 'Assessment Date');
ALTER TABLE `vibe_ngo_v1`.`mel`.`data_quality_assessment` ALTER COLUMN `assessment_end_date` SET TAGS ('pii_business_glossary_term' = 'Assessment End Date');
ALTER TABLE `vibe_ngo_v1`.`mel`.`data_quality_assessment` ALTER COLUMN `assessment_start_date` SET TAGS ('pii_business_glossary_term' = 'Assessment Start Date');
ALTER TABLE `vibe_ngo_v1`.`mel`.`data_quality_assessment` ALTER COLUMN `assessment_status` SET TAGS ('pii_business_glossary_term' = 'Assessment Status');
ALTER TABLE `vibe_ngo_v1`.`mel`.`data_quality_assessment` ALTER COLUMN `assessment_status` SET TAGS ('pii_value_regex' = 'planned|in_progress|completed|reviewed|approved|cancelled');
ALTER TABLE `vibe_ngo_v1`.`mel`.`data_quality_assessment` ALTER COLUMN `assessment_type` SET TAGS ('pii_business_glossary_term' = 'Assessment Type');
ALTER TABLE `vibe_ngo_v1`.`mel`.`data_quality_assessment` ALTER COLUMN `assessor_name` SET TAGS ('pii_business_glossary_term' = 'Assessor Name');
ALTER TABLE `vibe_ngo_v1`.`mel`.`data_quality_assessment` ALTER COLUMN `assessor_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`mel`.`data_quality_assessment` ALTER COLUMN `assessor_name` SET TAGS ('pii_type' = 'name');
ALTER TABLE `vibe_ngo_v1`.`mel`.`data_quality_assessment` ALTER COLUMN `assessor_organization` SET TAGS ('pii_business_glossary_term' = 'Assessor Organization');
ALTER TABLE `vibe_ngo_v1`.`mel`.`data_quality_assessment` ALTER COLUMN `completeness_score_percentage` SET TAGS ('pii_business_glossary_term' = 'Completeness Score Percentage');
ALTER TABLE `vibe_ngo_v1`.`mel`.`data_quality_assessment` ALTER COLUMN `consistency_score_percentage` SET TAGS ('pii_business_glossary_term' = 'Consistency Score Percentage');
ALTER TABLE `vibe_ngo_v1`.`mel`.`data_quality_assessment` ALTER COLUMN `corrective_action_completion_date` SET TAGS ('pii_business_glossary_term' = 'Corrective Action Completion Date');
ALTER TABLE `vibe_ngo_v1`.`mel`.`data_quality_assessment` ALTER COLUMN `corrective_action_due_date` SET TAGS ('pii_business_glossary_term' = 'Corrective Action Due Date');
ALTER TABLE `vibe_ngo_v1`.`mel`.`data_quality_assessment` ALTER COLUMN `corrective_action_status` SET TAGS ('pii_business_glossary_term' = 'Corrective Action Status');
ALTER TABLE `vibe_ngo_v1`.`mel`.`data_quality_assessment` ALTER COLUMN `corrective_action_status` SET TAGS ('pii_value_regex' = 'not_started|in_progress|completed|verified|overdue');
ALTER TABLE `vibe_ngo_v1`.`mel`.`data_quality_assessment` ALTER COLUMN `corrective_actions` SET TAGS ('pii_business_glossary_term' = 'Corrective Actions');
ALTER TABLE `vibe_ngo_v1`.`mel`.`data_quality_assessment` ALTER COLUMN `country_code` SET TAGS ('pii_business_glossary_term' = 'Country Code');
ALTER TABLE `vibe_ngo_v1`.`mel`.`data_quality_assessment` ALTER COLUMN `country_code` SET TAGS ('pii_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_ngo_v1`.`mel`.`data_quality_assessment` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_ngo_v1`.`mel`.`data_quality_assessment` ALTER COLUMN `dac_criteria_assessed` SET TAGS ('pii_business_glossary_term' = 'Development Assistance Committee (DAC) Criteria Assessed');
ALTER TABLE `vibe_ngo_v1`.`mel`.`data_quality_assessment` ALTER COLUMN `data_source_type` SET TAGS ('pii_business_glossary_term' = 'Data Source Type');
ALTER TABLE `vibe_ngo_v1`.`mel`.`data_quality_assessment` ALTER COLUMN `discrepancy_count` SET TAGS ('pii_business_glossary_term' = 'Discrepancy Count');
ALTER TABLE `vibe_ngo_v1`.`mel`.`data_quality_assessment` ALTER COLUMN `discrepancy_findings` SET TAGS ('pii_business_glossary_term' = 'Discrepancy Findings');
ALTER TABLE `vibe_ngo_v1`.`mel`.`data_quality_assessment` ALTER COLUMN `donor_reporting_requirement` SET TAGS ('pii_business_glossary_term' = 'Donor Reporting Requirement');
ALTER TABLE `vibe_ngo_v1`.`mel`.`data_quality_assessment` ALTER COLUMN `donor_reporting_requirement` SET TAGS ('pii_value_regex' = 'usaid_dqa|global_fund_lfa|dfid_verification|bha_audit|other|none');
ALTER TABLE `vibe_ngo_v1`.`mel`.`data_quality_assessment` ALTER COLUMN `geographic_scope` SET TAGS ('pii_business_glossary_term' = 'Geographic Scope');
ALTER TABLE `vibe_ngo_v1`.`mel`.`data_quality_assessment` ALTER COLUMN `last_modified_timestamp` SET TAGS ('pii_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_ngo_v1`.`mel`.`data_quality_assessment` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_ngo_v1`.`mel`.`data_quality_assessment` ALTER COLUMN `overall_dqa_score_percentage` SET TAGS ('pii_business_glossary_term' = 'Overall Data Quality Assessment (DQA) Score Percentage');
ALTER TABLE `vibe_ngo_v1`.`mel`.`data_quality_assessment` ALTER COLUMN `priority_level` SET TAGS ('pii_business_glossary_term' = 'Priority Level');
ALTER TABLE `vibe_ngo_v1`.`mel`.`data_quality_assessment` ALTER COLUMN `priority_level` SET TAGS ('pii_value_regex' = 'critical|high|medium|low');
ALTER TABLE `vibe_ngo_v1`.`mel`.`data_quality_assessment` ALTER COLUMN `records_verified` SET TAGS ('pii_business_glossary_term' = 'Records Verified');
ALTER TABLE `vibe_ngo_v1`.`mel`.`data_quality_assessment` ALTER COLUMN `report_url` SET TAGS ('pii_business_glossary_term' = 'Report Uniform Resource Locator (URL)');
ALTER TABLE `vibe_ngo_v1`.`mel`.`data_quality_assessment` ALTER COLUMN `review_date` SET TAGS ('pii_business_glossary_term' = 'Review Date');
ALTER TABLE `vibe_ngo_v1`.`mel`.`data_quality_assessment` ALTER COLUMN `root_cause_analysis` SET TAGS ('pii_business_glossary_term' = 'Root Cause Analysis');
ALTER TABLE `vibe_ngo_v1`.`mel`.`data_quality_assessment` ALTER COLUMN `sample_size` SET TAGS ('pii_business_glossary_term' = 'Sample Size');
ALTER TABLE `vibe_ngo_v1`.`mel`.`data_quality_assessment` ALTER COLUMN `timeliness_score_percentage` SET TAGS ('pii_business_glossary_term' = 'Timeliness Score Percentage');
ALTER TABLE `vibe_ngo_v1`.`mel`.`data_quality_assessment` ALTER COLUMN `verification_method` SET TAGS ('pii_business_glossary_term' = 'Verification Method');
ALTER TABLE `vibe_ngo_v1`.`mel`.`reporting_period` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_ngo_v1`.`mel`.`reporting_period` SET TAGS ('pii_subdomain' = 'results_framework');
ALTER TABLE `vibe_ngo_v1`.`mel`.`reporting_period` SET TAGS ('pii_tier' = 'mvm');
ALTER TABLE `vibe_ngo_v1`.`mel`.`reporting_period` ALTER COLUMN `reporting_period_id` SET TAGS ('pii_business_glossary_term' = 'Reporting Period Identifier');
ALTER TABLE `vibe_ngo_v1`.`mel`.`reporting_period` ALTER COLUMN `mel_logframe_id` SET TAGS ('pii_business_glossary_term' = 'Mel Logframe Id');
ALTER TABLE `vibe_ngo_v1`.`mel`.`reporting_period` ALTER COLUMN `parent_reporting_period_id` SET TAGS ('pii_business_glossary_term' = 'Parent Period Id');
ALTER TABLE `vibe_ngo_v1`.`mel`.`reporting_period` ALTER COLUMN `primary_prior_reporting_period_id` SET TAGS ('pii_business_glossary_term' = 'Prior Reporting Period Id');
ALTER TABLE `vibe_ngo_v1`.`mel`.`reporting_period` ALTER COLUMN `primary_prior_reporting_period_id` SET TAGS ('pii_self_ref_fk' = 'true');
ALTER TABLE `vibe_ngo_v1`.`mel`.`reporting_period` ALTER COLUMN `user_account_id` SET TAGS ('pii_business_glossary_term' = 'Created By User User Account Id');
ALTER TABLE `vibe_ngo_v1`.`mel`.`reporting_period` ALTER COLUMN `reporting_modified_by_user_user_account_id` SET TAGS ('pii_business_glossary_term' = 'Modified By User User Account Id');
ALTER TABLE `vibe_ngo_v1`.`mel`.`reporting_period` ALTER COLUMN `reporting_user_account_id` SET TAGS ('pii_business_glossary_term' = 'User Account Id');
ALTER TABLE `vibe_ngo_v1`.`mel`.`reporting_period` ALTER COLUMN `baseline_period_flag` SET TAGS ('pii_business_glossary_term' = 'Baseline Period Flag');
ALTER TABLE `vibe_ngo_v1`.`mel`.`reporting_period` ALTER COLUMN `calendar_year` SET TAGS ('pii_business_glossary_term' = 'Calendar Year');
ALTER TABLE `vibe_ngo_v1`.`mel`.`reporting_period` ALTER COLUMN `closed_date` SET TAGS ('pii_business_glossary_term' = 'Closed Date');
ALTER TABLE `vibe_ngo_v1`.`mel`.`reporting_period` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_ngo_v1`.`mel`.`reporting_period` ALTER COLUMN `dac_criteria_focus` SET TAGS ('pii_business_glossary_term' = 'Dac Criteria Focus');
ALTER TABLE `vibe_ngo_v1`.`mel`.`reporting_period` ALTER COLUMN `data_collection_deadline` SET TAGS ('pii_business_glossary_term' = 'Data Collection Deadline');
ALTER TABLE `vibe_ngo_v1`.`mel`.`reporting_period` ALTER COLUMN `data_quality_audit_flag` SET TAGS ('pii_business_glossary_term' = 'Data Quality Audit Flag');
ALTER TABLE `vibe_ngo_v1`.`mel`.`reporting_period` ALTER COLUMN `dhis2_period_code` SET TAGS ('pii_business_glossary_term' = 'Dhis2 Period Code');
ALTER TABLE `vibe_ngo_v1`.`mel`.`reporting_period` ALTER COLUMN `donor_reporting_cycle` SET TAGS ('pii_business_glossary_term' = 'Donor Reporting Cycle');
ALTER TABLE `vibe_ngo_v1`.`mel`.`reporting_period` ALTER COLUMN `duration_days` SET TAGS ('pii_business_glossary_term' = 'Duration Days');
ALTER TABLE `vibe_ngo_v1`.`mel`.`reporting_period` ALTER COLUMN `end_date` SET TAGS ('pii_business_glossary_term' = 'End Date');
ALTER TABLE `vibe_ngo_v1`.`mel`.`reporting_period` ALTER COLUMN `endline_period_flag` SET TAGS ('pii_business_glossary_term' = 'Endline Period Flag');
ALTER TABLE `vibe_ngo_v1`.`mel`.`reporting_period` ALTER COLUMN `evaluation_type` SET TAGS ('pii_business_glossary_term' = 'Evaluation Type');
ALTER TABLE `vibe_ngo_v1`.`mel`.`reporting_period` ALTER COLUMN `fgd_scheduled_flag` SET TAGS ('pii_business_glossary_term' = 'Fgd Scheduled Flag');
ALTER TABLE `vibe_ngo_v1`.`mel`.`reporting_period` ALTER COLUMN `fiscal_year` SET TAGS ('pii_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `vibe_ngo_v1`.`mel`.`reporting_period` ALTER COLUMN `is_active` SET TAGS ('pii_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_ngo_v1`.`mel`.`reporting_period` ALTER COLUMN `kii_scheduled_flag` SET TAGS ('pii_business_glossary_term' = 'Kii Scheduled Flag');
ALTER TABLE `vibe_ngo_v1`.`mel`.`reporting_period` ALTER COLUMN `midline_period_flag` SET TAGS ('pii_business_glossary_term' = 'Midline Period Flag');
ALTER TABLE `vibe_ngo_v1`.`mel`.`reporting_period` ALTER COLUMN `modified_timestamp` SET TAGS ('pii_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_ngo_v1`.`mel`.`reporting_period` ALTER COLUMN `month_number` SET TAGS ('pii_business_glossary_term' = 'Month Number');
ALTER TABLE `vibe_ngo_v1`.`mel`.`reporting_period` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_ngo_v1`.`mel`.`reporting_period` ALTER COLUMN `pdm_cycle_flag` SET TAGS ('pii_business_glossary_term' = 'Pdm Cycle Flag');
ALTER TABLE `vibe_ngo_v1`.`mel`.`reporting_period` ALTER COLUMN `period_code` SET TAGS ('pii_business_glossary_term' = 'Period Code');
ALTER TABLE `vibe_ngo_v1`.`mel`.`reporting_period` ALTER COLUMN `period_description` SET TAGS ('pii_business_glossary_term' = 'Period Description');
ALTER TABLE `vibe_ngo_v1`.`mel`.`reporting_period` ALTER COLUMN `period_name` SET TAGS ('pii_business_glossary_term' = 'Period Name');
ALTER TABLE `vibe_ngo_v1`.`mel`.`reporting_period` ALTER COLUMN `period_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`mel`.`reporting_period` ALTER COLUMN `period_name` SET TAGS ('pii_type' = 'name');
ALTER TABLE `vibe_ngo_v1`.`mel`.`reporting_period` ALTER COLUMN `period_status` SET TAGS ('pii_business_glossary_term' = 'Period Status');
ALTER TABLE `vibe_ngo_v1`.`mel`.`reporting_period` ALTER COLUMN `period_type` SET TAGS ('pii_business_glossary_term' = 'Period Type');
ALTER TABLE `vibe_ngo_v1`.`mel`.`reporting_period` ALTER COLUMN `quarter_number` SET TAGS ('pii_business_glossary_term' = 'Quarter Number');
ALTER TABLE `vibe_ngo_v1`.`mel`.`reporting_period` ALTER COLUMN `report_submission_deadline` SET TAGS ('pii_business_glossary_term' = 'Report Submission Deadline');
ALTER TABLE `vibe_ngo_v1`.`mel`.`reporting_period` ALTER COLUMN `reporting_frequency` SET TAGS ('pii_business_glossary_term' = 'Reporting Frequency');
ALTER TABLE `vibe_ngo_v1`.`mel`.`reporting_period` ALTER COLUMN `start_date` SET TAGS ('pii_business_glossary_term' = 'Start Date');
ALTER TABLE `vibe_ngo_v1`.`mel`.`reporting_period` ALTER COLUMN `week_number` SET TAGS ('pii_business_glossary_term' = 'Week Number');
ALTER TABLE `vibe_ngo_v1`.`mel`.`geographic_scope` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_ngo_v1`.`mel`.`geographic_scope` SET TAGS ('pii_subdomain' = 'results_framework');
ALTER TABLE `vibe_ngo_v1`.`mel`.`geographic_scope` SET TAGS ('pii_tier' = 'mvm');
ALTER TABLE `vibe_ngo_v1`.`mel`.`geographic_scope` ALTER COLUMN `geographic_scope_id` SET TAGS ('pii_business_glossary_term' = 'Geographic Scope Identifier');
ALTER TABLE `vibe_ngo_v1`.`mel`.`geographic_scope` ALTER COLUMN `org_unit_id` SET TAGS ('pii_business_glossary_term' = 'Dhis2 Org Unit Id');
ALTER TABLE `vibe_ngo_v1`.`mel`.`geographic_scope` ALTER COLUMN `parent_geographic_scope_id` SET TAGS ('pii_business_glossary_term' = 'Parent Geographic Scope Id');
ALTER TABLE `vibe_ngo_v1`.`mel`.`geographic_scope` ALTER COLUMN `parent_geographic_scope_id` SET TAGS ('pii_self_ref_fk' = 'true');
ALTER TABLE `vibe_ngo_v1`.`mel`.`geographic_scope` ALTER COLUMN `parent_scope_id` SET TAGS ('pii_business_glossary_term' = 'Parent Scope Id');
ALTER TABLE `vibe_ngo_v1`.`mel`.`geographic_scope` ALTER COLUMN `administrative_level` SET TAGS ('pii_business_glossary_term' = 'Administrative Level');
ALTER TABLE `vibe_ngo_v1`.`mel`.`geographic_scope` ALTER COLUMN `area_square_km` SET TAGS ('pii_business_glossary_term' = 'Area Square Km');
ALTER TABLE `vibe_ngo_v1`.`mel`.`geographic_scope` ALTER COLUMN `boundary_definition` SET TAGS ('pii_business_glossary_term' = 'Boundary Definition');
ALTER TABLE `vibe_ngo_v1`.`mel`.`geographic_scope` ALTER COLUMN `community_name` SET TAGS ('pii_business_glossary_term' = 'Community Name');
ALTER TABLE `vibe_ngo_v1`.`mel`.`geographic_scope` ALTER COLUMN `community_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`mel`.`geographic_scope` ALTER COLUMN `community_name` SET TAGS ('pii_type' = 'name');
ALTER TABLE `vibe_ngo_v1`.`mel`.`geographic_scope` ALTER COLUMN `conflict_affected_flag` SET TAGS ('pii_business_glossary_term' = 'Conflict Affected Flag');
ALTER TABLE `vibe_ngo_v1`.`mel`.`geographic_scope` ALTER COLUMN `country_code` SET TAGS ('pii_business_glossary_term' = 'Country Code');
ALTER TABLE `vibe_ngo_v1`.`mel`.`geographic_scope` ALTER COLUMN `country_name` SET TAGS ('pii_business_glossary_term' = 'Country Name');
ALTER TABLE `vibe_ngo_v1`.`mel`.`geographic_scope` ALTER COLUMN `country_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`mel`.`geographic_scope` ALTER COLUMN `country_name` SET TAGS ('pii_type' = 'name');
ALTER TABLE `vibe_ngo_v1`.`mel`.`geographic_scope` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_ngo_v1`.`mel`.`geographic_scope` ALTER COLUMN `data_source` SET TAGS ('pii_business_glossary_term' = 'Data Source');
ALTER TABLE `vibe_ngo_v1`.`mel`.`geographic_scope` ALTER COLUMN `disaster_prone_flag` SET TAGS ('pii_business_glossary_term' = 'Disaster Prone Flag');
ALTER TABLE `vibe_ngo_v1`.`mel`.`geographic_scope` ALTER COLUMN `district_name` SET TAGS ('pii_business_glossary_term' = 'District Name');
ALTER TABLE `vibe_ngo_v1`.`mel`.`geographic_scope` ALTER COLUMN `district_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`mel`.`geographic_scope` ALTER COLUMN `district_name` SET TAGS ('pii_type' = 'name');
ALTER TABLE `vibe_ngo_v1`.`mel`.`geographic_scope` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_ngo_v1`.`mel`.`geographic_scope` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_ngo_v1`.`mel`.`geographic_scope` ALTER COLUMN `hard_to_reach_flag` SET TAGS ('pii_business_glossary_term' = 'Hard To Reach Flag');
ALTER TABLE `vibe_ngo_v1`.`mel`.`geographic_scope` ALTER COLUMN `last_verified_date` SET TAGS ('pii_business_glossary_term' = 'Last Verified Date');
ALTER TABLE `vibe_ngo_v1`.`mel`.`geographic_scope` ALTER COLUMN `latitude` SET TAGS ('pii_business_glossary_term' = 'Latitude');
ALTER TABLE `vibe_ngo_v1`.`mel`.`geographic_scope` ALTER COLUMN `latitude` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`mel`.`geographic_scope` ALTER COLUMN `latitude` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_ngo_v1`.`mel`.`geographic_scope` ALTER COLUMN `longitude` SET TAGS ('pii_business_glossary_term' = 'Longitude');
ALTER TABLE `vibe_ngo_v1`.`mel`.`geographic_scope` ALTER COLUMN `longitude` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`mel`.`geographic_scope` ALTER COLUMN `longitude` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_ngo_v1`.`mel`.`geographic_scope` ALTER COLUMN `modified_timestamp` SET TAGS ('pii_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_ngo_v1`.`mel`.`geographic_scope` ALTER COLUMN `municipality_name` SET TAGS ('pii_business_glossary_term' = 'Municipality Name');
ALTER TABLE `vibe_ngo_v1`.`mel`.`geographic_scope` ALTER COLUMN `municipality_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`mel`.`geographic_scope` ALTER COLUMN `municipality_name` SET TAGS ('pii_type' = 'name');
ALTER TABLE `vibe_ngo_v1`.`mel`.`geographic_scope` ALTER COLUMN `population_estimate` SET TAGS ('pii_business_glossary_term' = 'Population Estimate');
ALTER TABLE `vibe_ngo_v1`.`mel`.`geographic_scope` ALTER COLUMN `population_source` SET TAGS ('pii_business_glossary_term' = 'Population Source');
ALTER TABLE `vibe_ngo_v1`.`mel`.`geographic_scope` ALTER COLUMN `population_year` SET TAGS ('pii_business_glossary_term' = 'Population Year');
ALTER TABLE `vibe_ngo_v1`.`mel`.`geographic_scope` ALTER COLUMN `region_name` SET TAGS ('pii_business_glossary_term' = 'Region Name');
ALTER TABLE `vibe_ngo_v1`.`mel`.`geographic_scope` ALTER COLUMN `region_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`mel`.`geographic_scope` ALTER COLUMN `region_name` SET TAGS ('pii_type' = 'name');
ALTER TABLE `vibe_ngo_v1`.`mel`.`geographic_scope` ALTER COLUMN `scope_code` SET TAGS ('pii_business_glossary_term' = 'Scope Code');
ALTER TABLE `vibe_ngo_v1`.`mel`.`geographic_scope` ALTER COLUMN `scope_description` SET TAGS ('pii_business_glossary_term' = 'Scope Description');
ALTER TABLE `vibe_ngo_v1`.`mel`.`geographic_scope` ALTER COLUMN `scope_name` SET TAGS ('pii_business_glossary_term' = 'Scope Name');
ALTER TABLE `vibe_ngo_v1`.`mel`.`geographic_scope` ALTER COLUMN `scope_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`mel`.`geographic_scope` ALTER COLUMN `scope_name` SET TAGS ('pii_type' = 'name');
ALTER TABLE `vibe_ngo_v1`.`mel`.`geographic_scope` ALTER COLUMN `scope_status` SET TAGS ('pii_business_glossary_term' = 'Scope Status');
ALTER TABLE `vibe_ngo_v1`.`mel`.`geographic_scope` ALTER COLUMN `scope_type` SET TAGS ('pii_business_glossary_term' = 'Scope Type');
ALTER TABLE `vibe_ngo_v1`.`mel`.`geographic_scope` ALTER COLUMN `urban_rural_classification` SET TAGS ('pii_business_glossary_term' = 'Urban Rural Classification');
ALTER TABLE `vibe_ngo_v1`.`mel`.`geographic_scope` ALTER COLUMN `vulnerability_index` SET TAGS ('pii_business_glossary_term' = 'Vulnerability Index');
ALTER TABLE `vibe_ngo_v1`.`mel`.`sdg_indicator_alignment` SET TAGS ('pii_data_type' = 'association_data');
ALTER TABLE `vibe_ngo_v1`.`mel`.`sdg_indicator_alignment` SET TAGS ('pii_subdomain' = 'indicator_management');
ALTER TABLE `vibe_ngo_v1`.`mel`.`sdg_indicator_alignment` SET TAGS ('pii_tier' = 'ECM');
ALTER TABLE `vibe_ngo_v1`.`mel`.`sdg_indicator_alignment` SET TAGS ('pii_domain' = 'mel');
ALTER TABLE `vibe_ngo_v1`.`mel`.`sdg_indicator_alignment` SET TAGS ('pii_un_hierarchy' = 'true');
ALTER TABLE `vibe_ngo_v1`.`mel`.`sdg_indicator_alignment` SET TAGS ('pii_sdg' = 'true');
