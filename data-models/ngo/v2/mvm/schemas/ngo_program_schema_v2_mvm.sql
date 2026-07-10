-- Schema for Domain: program | Business: Ngo | Version: v2_mvm
-- Generated on: 2026-07-10 20:23:33

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_ngo_v1`.`program` COMMENT 'Owns the design, planning, and lifecycle management of all humanitarian and development interventions including WASH, health, nutrition, education, protection, and livelihood programs. Captures Theory of Change (ToC), LogFrame, SDG alignment, sector classifications, RBM (Results-Based Management) frameworks, and program hierarchies from proposal through closeout.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_ngo_v1`.`program`.`intervention` (
    `intervention_id` BIGINT COMMENT 'Unique identifier for the humanitarian or development intervention/program. Primary key for the intervention entity.',
    `country_office_id` BIGINT COMMENT 'Foreign key linking to field.country_office. Business justification: Interventions are executed by country offices. NGO country office reporting, CHS compliance audits, and donor accountability all require direct intervention-to-country-office linkage. Existing links (',
    `funding_source_id` BIGINT COMMENT 'Foreign key linking to grant.funding_source. Business justification: Programs are funded by specific restricted or unrestricted funds. Essential for donor compliance reporting, financial tracking, and ensuring expenditures align with fund restrictions. Nonprofit domain',
    `actual_end_date` DATE COMMENT 'Actual date when intervention activities concluded. May differ from planned end date due to extensions, early termination, or operational adjustments.',
    `actual_start_date` DATE COMMENT 'Actual date when intervention activities commenced in the field. May differ from planned start date due to delays in funding, security clearances, or operational readiness.',
    `budget_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the total budget amount (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `chs_compliant` BOOLEAN COMMENT 'Indicates whether the intervention design and implementation plan adhere to the Core Humanitarian Standard on Quality and Accountability, covering nine commitments from needs assessment through accountability to affected populations.',
    `intervention_code` STRING COMMENT 'Externally-known unique business identifier for the intervention, used in donor reporting, grant proposals, and field operations. Often follows organizational or donor-specific coding conventions.. Valid values are `^[A-Z0-9]{3,20}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this intervention record was first created in the system, representing when the intervention was registered or entered into the program management system.',
    `disability_inclusion_marker_score` STRING COMMENT 'Score indicating the level of disability inclusion in the intervention design and implementation. 0: not disability inclusive; 1: disability visible; 2: disability integrated; 3: disability targeted; 4: disability transformative.. Valid values are `0|1|2|3|4`',
    `do_no_harm_assessment_completed` BOOLEAN COMMENT 'Indicates whether a Do No Harm analysis was conducted to identify and mitigate potential negative impacts of the intervention on conflict dynamics, social cohesion, or vulnerable groups.',
    `environmental_impact_assessment_completed` BOOLEAN COMMENT 'Indicates whether an environmental impact assessment was conducted to evaluate and mitigate potential environmental harm from intervention activities (e.g., water extraction, waste disposal, construction).',
    `gender_marker_score` STRING COMMENT 'IASC Gender Marker score indicating the extent to which the intervention integrates gender equality. 0: no gender integration; 1: contributes to gender equality; 2a: has gender equality as a significant objective; 2b: has gender equality as the principal objective.. Valid values are `0|1|2a|2b`',
    `geographic_scope` STRING COMMENT 'Geographic coverage level of the intervention. National: entire country; Regional: multiple provinces/states; District: specific administrative districts; Community: village or neighborhood level; Multi-country: cross-border or regional program.. Valid values are `national|regional|district|community|multi_country`',
    `intervention_status` STRING COMMENT 'Current lifecycle status of the intervention. Pipeline: concept or proposal stage; Approved: funding secured, not yet started; Active: implementation underway; Suspended: temporarily paused; Completed: activities finished, closeout pending; Closed: fully closed out with final reports submitted.. Valid values are `pipeline|approved|active|suspended|completed|closed`',
    `intervention_type` STRING COMMENT 'Classification of the intervention based on its primary purpose and timeframe. Emergency response interventions address immediate humanitarian crises; development interventions focus on long-term sustainable change; recovery interventions bridge emergency and development; resilience interventions build capacity to withstand future shocks; advocacy interventions influence policy and systems; capacity building interventions strengthen partner organizations.. Valid values are `emergency_response|development|recovery|resilience|advocacy|capacity_building`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this intervention record was last updated, capturing any changes to intervention details, status, or metadata.',
    `logframe_document_url` STRING COMMENT 'URL or file path to the interventions Logical Framework Matrix document, which details the intervention logic, indicators, means of verification, and assumptions.',
    `logic` STRING COMMENT 'Structured description of the interventions logical framework (LogFrame): how activities will produce outputs, how outputs will lead to outcomes, and how outcomes will contribute to impact. Includes key assumptions and risks at each level.',
    `mel_plan_document_url` STRING COMMENT 'URL or file path to the interventions MEL plan, which outlines the monitoring framework, evaluation schedule, data collection methods, and learning agenda.',
    `intervention_name` STRING COMMENT 'Full descriptive name of the intervention as it appears in grant proposals, donor reports, and public communications.',
    `phase` STRING COMMENT 'Current operational phase within the intervention lifecycle. Design: developing ToC, LogFrame, and proposal; Startup: mobilizing resources, recruiting staff, establishing field presence; Implementation: delivering activities and services; Closeout: finalizing activities, conducting evaluations, submitting final reports.. Valid values are `design|startup|implementation|closeout`',
    `planned_end_date` DATE COMMENT 'Originally planned end date for intervention activities as documented in the grant agreement or project proposal.',
    `planned_start_date` DATE COMMENT 'Originally planned start date for intervention activities as documented in the grant agreement or project proposal.',
    `rbm_framework_applied` BOOLEAN COMMENT 'Indicates whether the intervention applies a formal Results-Based Management framework with defined inputs, activities, outputs, outcomes, and impact, along with indicators and targets at each level.',
    `safeguarding_policy_applied` BOOLEAN COMMENT 'Indicates whether the intervention implements organizational safeguarding policies to prevent sexual exploitation, abuse, and harassment (SEAH) and protect vulnerable populations, particularly children and women.',
    `sdg_alignment_type` STRING COMMENT 'Nature of the interventions contribution to the SDG. Direct: intervention activities directly advance the SDG indicator; Indirect: intervention creates conditions that support SDG progress; Enabling: intervention builds capacity or systems that enable others to advance the SDG.. Valid values are `direct|indirect|enabling`',
    `sdg_contribution_narrative` STRING COMMENT 'Qualitative description of how the intervention contributes to the identified SDG goal, target, and indicator. Articulates the causal pathway and expected magnitude of contribution.',
    `sdg_goal_primary` STRING COMMENT 'Primary UN Sustainable Development Goal that this intervention contributes to, expressed as SDG number (e.g., SDG1 for No Poverty, SDG3 for Good Health and Well-being, SDG6 for Clean Water and Sanitation).. Valid values are `^SDG[0-9]{1,2}$`',
    `sdg_indicator_primary` STRING COMMENT 'Specific SDG indicator used to measure the interventions contribution to the primary target (e.g., 6.1.1 for proportion of population using safely managed drinking water services).. Valid values are `^[0-9]{1,2}.[0-9]{1,2}.[0-9]{1,2}$`',
    `sdg_target_primary` STRING COMMENT 'Specific SDG target within the primary goal that this intervention addresses (e.g., 6.1 for universal access to safe drinking water, 3.8 for universal health coverage).. Valid values are `^[0-9]{1,2}.[0-9]{1,2}$`',
    `sector` STRING COMMENT 'Primary humanitarian or development sector of the intervention. WASH (Water Sanitation and Hygiene), health, nutrition, education, protection (including GBV and child protection), shelter/NFI, livelihoods, and food security are the most common sectors aligned with Sphere standards and cluster coordination mechanisms. [ENUM-REF-CANDIDATE: wash|health|nutrition|education|protection|shelter|livelihoods|food_security — 8 candidates stripped; promote to reference product]',
    `short_name` STRING COMMENT 'Abbreviated or acronym version of the intervention name used for internal reference and field operations.',
    `situation_analysis` STRING COMMENT 'Detailed analysis of the humanitarian or development context that justifies the intervention. Includes needs assessment findings, vulnerability analysis, root causes of the problem, and gaps in existing services or coverage.',
    `sphere_standards_applied` BOOLEAN COMMENT 'Indicates whether the intervention applies Sphere Humanitarian Charter and Minimum Standards in Humanitarian Response, including protection principles and technical standards for WASH, food security, shelter, and health.',
    `sub_sector` STRING COMMENT 'Detailed sub-classification within the primary sector. For example, within WASH: water supply, sanitation facilities, hygiene promotion; within health: primary health care, maternal health, mental health and PSS; within protection: GBV prevention and response, child protection, mine action.',
    `sustainability_plan` STRING COMMENT 'Strategy for ensuring that intervention benefits and capacities endure beyond the project period. Includes plans for local ownership, capacity building, resource mobilization, policy advocacy, and transition or exit strategies.',
    `target_beneficiary_count` STRING COMMENT 'Total number of direct beneficiaries the intervention aims to reach, as documented in the project proposal and LogFrame. Represents unique individuals or households, depending on the interventions unit of analysis.',
    `target_beneficiary_unit` STRING COMMENT 'Unit of measurement for target beneficiaries. Individuals: unique persons; Households: family units; Communities: villages or settlements; Institutions: schools, health facilities, or organizations.. Valid values are `individuals|households|communities|institutions`',
    `targeting_strategy` STRING COMMENT 'Methodology and criteria for identifying and selecting beneficiaries. Describes vulnerability criteria, geographic targeting, inclusion/exclusion criteria, and mechanisms to ensure equitable access and prevent exclusion errors.',
    `theory_of_change_narrative` STRING COMMENT 'Comprehensive narrative describing the interventions Theory of Change: the causal pathway from inputs and activities through outputs, outcomes, and impact. Articulates assumptions, preconditions, and the logic connecting intervention activities to intended long-term change.',
    `total_budget_amount` DECIMAL(18,2) COMMENT 'Total approved budget for the intervention across all funding sources, expressed in the organizations reporting currency. Includes direct program costs, indirect costs, and any cost-sharing or in-kind contributions.',
    CONSTRAINT pk_intervention PRIMARY KEY(`intervention_id`)
) COMMENT 'Core master entity representing a humanitarian or development program/intervention (e.g., WASH, health, nutrition, education, protection, livelihoods). Captures the full program lifecycle from design through closeout, including program type (emergency vs. development), phase, status, start/end dates, geographic scope, target population summary, organizational ownership, and SDG alignment mappings (goal, target, indicator, alignment type, contribution narrative). This is the primary anchor entity for the program domain and the SSOT for all program-level identity, metadata, design narrative (situation analysis, intervention logic, targeting strategy, sustainability plan), and strategic framework alignment. All other program domain entities reference this as their parent.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`program`.`program_logframe` (
    `program_logframe_id` BIGINT COMMENT 'Unique identifier for the program logical framework row entry. Primary key for the LogFrame matrix.',
    `award_id` BIGINT COMMENT 'Foreign key linking to grant.award. Business justification: Donor awards mandate specific results frameworks and logframe structures. NGO MEL teams must trace which award version requires a given logframe to satisfy donor reporting obligations and audit requir',
    `country_office_id` BIGINT COMMENT 'Foreign key linking to field.country_office. Business justification: Logframe provides evidence for CHS Commitment 5 (complaints mechanism indicators) and Commitment 6 (coordinated response). Essential for linking M&E framework to CHS compliance verification.',
    `intervention_id` BIGINT COMMENT 'Reference to the parent program intervention to which this LogFrame row belongs.',
    `mel_logframe_id` BIGINT COMMENT 'FK to SSOT owner mel.mel_logframe for entity logframe',
    `program_id` BIGINT COMMENT '',
    `proposal_id` BIGINT COMMENT 'Foreign key linking to grant.proposal. Business justification: Proposals submitted to donors contain the original logframe design. NGO business development and MEL teams must trace approved logframe versions back to the winning proposal for donor compliance, amen',
    `amendment_reason` STRING COMMENT 'Explanation for why this LogFrame row was revised or amended (e.g., donor request, context change, program adaptation, no-cost extension).',
    `approval_date` DATE COMMENT 'The date on which this LogFrame row or version was formally approved for implementation and reporting.',
    `assumptions` STRING COMMENT 'External conditions or factors that must hold true for the result to be achieved but are outside the programs direct control.',
    `baseline_date` DATE COMMENT 'The date on which the baseline value was measured or established.',
    `baseline_value` DECIMAL(18,2) COMMENT 'The initial measured value of the indicator at program start, serving as the reference point for progress measurement.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this LogFrame row record was first created in the system.',
    `dac_sector_code` STRING COMMENT 'The five-digit OECD Development Assistance Committee sector code classifying the type of aid activity (e.g., 14030 for water supply and sanitation).. Valid values are `^[0-9]{5}$`',
    `data_collection_method` STRING COMMENT 'The primary methodology used to collect indicator data (e.g., household survey, Focus Group Discussion (FGD), Key Informant Interview (KII), administrative records, mobile data collection).',
    `data_source` STRING COMMENT 'The specific system, database, or organizational unit that provides the indicator data (e.g., DHIS2, KoboToolbox, field office reports).',
    `disaggregation_dimensions` STRING COMMENT 'The demographic or geographic dimensions by which indicator data should be disaggregated for equity analysis (e.g., sex, age group, disability status, geographic location).',
    `donor_visibility_flag` BOOLEAN COMMENT 'Indicates whether this result is included in external donor reports and dashboards (True) or is for internal use only (False).',
    `effective_end_date` DATE COMMENT 'The date on which this LogFrame row version is superseded by a new version or the program closes. Null for currently active versions.',
    `effective_start_date` DATE COMMENT 'The date from which this LogFrame row version becomes active and applicable for monitoring and reporting.',
    `grant_requirement_flag` BOOLEAN COMMENT 'Indicates whether this LogFrame row is a mandatory reporting requirement specified in the donor grant agreement (True) or an internal monitoring element (False).',
    `hierarchy_level` STRING COMMENT 'The hierarchical tier of this LogFrame row within the results chain: goal (impact), purpose/outcome, output, or activity.. Valid values are `goal|purpose|outcome|output|activity`',
    `indicator_reference_code` STRING COMMENT 'Code or identifier linking this LogFrame row to the corresponding indicator in the Monitoring Evaluation and Learning (MEL) indicator library.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this LogFrame row record was most recently updated.',
    `means_of_verification` STRING COMMENT 'The data sources and methods used to verify achievement of the result (e.g., household surveys, administrative records, Post-Distribution Monitoring (PDM), Key Informant Interviews (KII)).',
    `mitigation_strategy` STRING COMMENT 'The planned actions or contingency measures to reduce the likelihood or impact of risks to achieving this result.',
    `notes` STRING COMMENT 'Additional contextual information, clarifications, or implementation guidance related to this LogFrame row.',
    `program_logframe_status` STRING COMMENT 'Current lifecycle status of this LogFrame row indicating progress and health (draft during proposal, active during implementation, achieved/not_achieved at closeout). [ENUM-REF-CANDIDATE: draft|active|on_track|at_risk|delayed|achieved|not_achieved|archived — 8 candidates stripped; promote to reference product]',
    `reporting_frequency` STRING COMMENT 'The cadence at which progress against this LogFrame row is measured and reported to donors and stakeholders.. Valid values are `monthly|quarterly|semi-annually|annually|on-demand`',
    `responsible_unit` STRING COMMENT 'The organizational unit, department, or team accountable for delivering this result (e.g., WASH team, Health program unit, Field Operations).',
    `result_statement` STRING COMMENT 'Narrative description of the intended result at this hierarchy level (goal, outcome, output, or activity statement).',
    `risk_level` STRING COMMENT 'The assessed level of risk that this result may not be achieved due to internal or external factors.. Valid values are `low|medium|high|critical`',
    `row_sequence_number` STRING COMMENT 'Ordinal position of this row within the LogFrame matrix for display and reporting purposes.',
    `sdg_alignment` STRING COMMENT 'The United Nations Sustainable Development Goal(s) and target(s) to which this result contributes (e.g., SDG 6.1, SDG 3.2).',
    `sector_classification` STRING COMMENT 'The humanitarian or development sector to which this result belongs (e.g., WASH (Water Sanitation and Hygiene), Health, Nutrition, Education, Protection, Livelihoods). [ENUM-REF-CANDIDATE: wash|health|nutrition|education|protection|livelihoods|shelter|food_security|early_recovery — promote to reference product]',
    `target_date` DATE COMMENT 'The date by which the target value is expected to be achieved, typically the program end date or milestone date.',
    `target_value` DECIMAL(18,2) COMMENT 'The intended end-of-program value for the indicator, representing the planned achievement level.',
    `theory_of_change_reference` STRING COMMENT 'Reference identifier linking this LogFrame row to the corresponding pathway or assumption in the programs Theory of Change (ToC) diagram.',
    `unit_of_measure` STRING COMMENT 'The measurement unit for baseline and target values (e.g., number of beneficiaries, percentage, households, liters).',
    `version_number` STRING COMMENT 'Version identifier for the LogFrame matrix to track amendments and revisions across the program lifecycle (e.g., 1.0, 1.1, 2.0).. Valid values are `^[0-9]+.[0-9]+$`',
    CONSTRAINT pk_program_logframe PRIMARY KEY(`program_logframe_id`)
) COMMENT 'Logical Framework (LogFrame) matrix for a program intervention, including the structured hierarchy of goal, purpose/outcome, outputs, and activities at the row level. Each row captures result statement, indicator reference, baseline value, target value, means of verification (MoV), assumptions, responsible unit, and reporting frequency. Supports RBM and is the primary planning artifact used in grant proposals and donor agreements. Linked to the Theory of Change and MEL indicator library. Versioned to track amendments across program lifecycle.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`program`.`logframe_row` (
    `logframe_row_id` BIGINT COMMENT 'Unique identifier for the LogFrame row entry. Primary key for the logframe_row product.',
    `component_id` BIGINT COMMENT 'Foreign key linking to program.component. Business justification: Individual logframe rows (results, outputs, activities) are often attributed to specific program components for results-based management and component-level performance reporting. This enables traceab',
    `indicator_id` BIGINT COMMENT 'Foreign key linking to mel.indicator. Business justification: Each logframe row is associated with a specific indicator for measurement — the core logframe structure in NGO M&E. Every output/outcome row has a defined indicator. Currently logframe_row has no FK t',
    `intervention_id` BIGINT COMMENT 'Reference to the program or project to which this LogFrame row applies. Enables program-level aggregation and reporting.',
    `parent_result_logframe_row_id` BIGINT COMMENT 'Reference to the parent result row in the LogFrame hierarchy. Enables navigation of the results chain (e.g., linking an output to its parent outcome).',
    `program_logframe_id` BIGINT COMMENT 'Reference to the parent LogFrame document to which this row belongs. Links this row to the overall program LogFrame structure.',
    `project_site_id` BIGINT COMMENT 'Foreign key linking to field.project_site. Business justification: Logframe rows (results/indicators) are tracked at specific project sites for geographic disaggregation of results. NGO MEL teams report indicator achievement by site for donor reporting and geographic',
    `reporting_period_id` BIGINT COMMENT 'Foreign key linking to mel.reporting_period. Business justification: Logframe rows have specific reporting periods defining when results are due. Linking logframe_row to reporting_period enables automated reporting calendar management, deadline tracking, and ensures lo',
    `assumptions` STRING COMMENT 'External conditions or factors that must hold true for this result to be achieved but are outside the programs direct control. Critical for risk management and adaptive management.',
    `baseline_date` DATE COMMENT 'The date when the baseline value was measured or established. Critical for understanding the timeframe of change.',
    `baseline_value` DECIMAL(18,2) COMMENT 'The starting value or condition for the indicator before program intervention. Provides the reference point for measuring change. Stored as string to accommodate numeric, text, or mixed values.',
    `beneficiary_target_count` STRING COMMENT 'The number of beneficiaries or persons of concern (PoC) targeted to benefit from this result. Critical for reach and coverage reporting.',
    `budget_allocated` DECIMAL(18,2) COMMENT 'The financial budget allocated to achieve this result. Enables cost-effectiveness analysis and budget versus actual (BvA) tracking.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this LogFrame row entry was first created in the system. Supports audit trail and data lineage.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the budget allocated to this result (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `dac_code` STRING COMMENT 'The OECD DAC sector or purpose code assigned to this result. Enables standardized international development reporting.',
    `data_collection_method` STRING COMMENT 'The primary method used to collect indicator data for this result (e.g., household survey, key informant interview, focus group discussion, administrative data, mobile data collection).',
    `disaggregation_dimensions` STRING COMMENT 'The demographic or geographic dimensions by which indicator data for this result should be disaggregated (e.g., age, gender, disability status, location). Supports equity analysis and targeted interventions.',
    `geographic_scope` STRING COMMENT 'The geographic area or administrative units where this result will be delivered (e.g., district names, province codes, country). Supports geographic analysis and mapping.',
    `implementation_end_date` DATE COMMENT 'The date when implementation activities for this result are scheduled to be completed.',
    `implementation_start_date` DATE COMMENT 'The date when implementation activities for this result are scheduled to begin.',
    `is_active` BOOLEAN COMMENT 'Indicates whether this LogFrame row is currently active and in use. Supports soft deletion and historical record keeping.',
    `logframe_row_status` STRING COMMENT 'Current status of this result in the program lifecycle. Tracks whether the result is on track, at risk, achieved, or cancelled. [ENUM-REF-CANDIDATE: draft|active|on-track|at-risk|delayed|achieved|not-achieved|cancelled — 8 candidates stripped; promote to reference product]',
    `means_of_verification` STRING COMMENT 'The data sources, methods, or tools used to verify achievement of this result. Examples include surveys, administrative records, field reports, or third-party assessments.',
    `modified_by` STRING COMMENT 'The username or identifier of the person who last modified this LogFrame row entry. Supports audit trail and change tracking.',
    `modified_timestamp` TIMESTAMP COMMENT 'The date and time when this LogFrame row entry was last modified in the system. Supports audit trail and change tracking.',
    `notes` STRING COMMENT 'Additional contextual information, clarifications, or comments related to this LogFrame row. Supports documentation and knowledge management.',
    `reporting_frequency` STRING COMMENT 'How often progress against this result is measured and reported. Determines the cadence of MEL (Monitoring Evaluation and Learning) data collection.. Valid values are `monthly|quarterly|semi-annually|annually|ad-hoc`',
    `responsible_person` STRING COMMENT 'The individual staff member or role holder accountable for this result. Enables personal accountability and follow-up.',
    `responsible_unit` STRING COMMENT 'The organizational unit, department, or team accountable for delivering this result. Supports RACI (Responsible Accountable Consulted Informed) assignment.',
    `result_code` STRING COMMENT 'Unique alphanumeric code assigned to this result for tracking and reporting purposes. Often follows a hierarchical numbering scheme (e.g., 1.1.1, 1.1.2).',
    `result_level` STRING COMMENT 'The hierarchical level of this result within the LogFrame structure. Defines whether this row represents a goal, outcome, output, activity, or input in the results chain.. Valid values are `goal|outcome|output|activity|input`',
    `result_statement` STRING COMMENT 'The narrative description of the intended result at this level. Articulates what change or achievement is expected (e.g., Improved access to clean water for 10,000 households).',
    `risks` STRING COMMENT 'Potential threats or challenges that could prevent achievement of this result. Complements assumptions by identifying negative scenarios.',
    `sdg_alignment` STRING COMMENT 'The United Nations Sustainable Development Goal(s) and target(s) to which this result contributes. Enables SDG reporting and impact aggregation.',
    `sector_classification` STRING COMMENT 'The humanitarian or development sector to which this result belongs (e.g., WASH, Health, Nutrition, Education, Protection, Livelihoods). Supports sector-based reporting and coordination.',
    `sequence_number` STRING COMMENT 'Ordinal position of this row within the LogFrame document. Determines the display order and hierarchical structure of results.',
    `target_date` DATE COMMENT 'The date by which the target value is expected to be achieved. Defines the timeframe for result delivery.',
    `target_value` DECIMAL(18,2) COMMENT 'The intended end-of-program value or condition for the indicator. Defines the success threshold for this result. Stored as string to accommodate numeric, text, or mixed values.',
    `created_by` STRING COMMENT 'The username or identifier of the person who created this LogFrame row entry. Supports audit trail and accountability.',
    CONSTRAINT pk_logframe_row PRIMARY KEY(`logframe_row_id`)
) COMMENT 'Individual row within a LogFrame matrix representing a single result level entry (goal, outcome, output, or activity). Captures the result statement, indicator reference, baseline value, target value, means of verification, assumptions, responsible unit, and reporting frequency. Enables granular tracking of each LogFrame element and supports MEL data linkage at the indicator level.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`program`.`component` (
    `component_id` BIGINT COMMENT 'Unique identifier for the program component. Primary key.',
    `agreement_id` BIGINT COMMENT 'Foreign key linking to partnership.partnership_agreement. Business justification: Components are governed by specific partnership agreements (sub-awards). This link supports financial compliance verification — confirming which agreement authorizes each components implementation sc',
    `award_id` BIGINT COMMENT 'Foreign key linking to grant.award. Business justification: Audit findings are often specific to program components (questioned costs by component, compliance deficiencies in specific activities). Essential for tracking corrective actions at component level.',
    `country_office_id` BIGINT COMMENT 'Foreign key linking to field.country_office. Business justification: Components are managed by country offices for budget accountability, staffing, and donor reporting. Country office directors need to see all components under their office for portfolio management and ',
    `intervention_id` BIGINT COMMENT 'Reference to the parent program intervention that this component belongs to. Links component to its overarching program structure.',
    `parent_component_id` BIGINT COMMENT 'Reference to the parent component if this is a sub-component or workstream. Null for top-level components. Supports hierarchical program navigation.',
    `program_id` BIGINT COMMENT '',
    `project_site_id` BIGINT COMMENT 'Foreign key linking to field.project_site. Business justification: Program components are implemented at specific project sites. NGOs track component-to-site linkage for geographic reporting, donor visibility, and operational coordination. Budget and results reportin',
    `amendment_count` STRING COMMENT 'Number of formal amendments or revisions made to the component design, scope, or budget since initial approval. Tracks change management history.',
    `approval_date` DATE COMMENT 'Date when the component design and budget received formal approval to proceed with implementation.',
    `approval_status` STRING COMMENT 'Current approval state of the component design and budget within internal governance processes (draft, pending review, approved, revision required, rejected).. Valid values are `draft|pending_review|approved|revision_required|rejected`',
    `approved_by` STRING COMMENT 'Name or identifier of the individual or committee that approved this component for implementation.',
    `budget_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the budget envelope amount (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `budget_envelope_amount` DECIMAL(18,2) COMMENT 'Total allocated budget for this component in the programs base currency. Represents the financial ceiling for component activities and procurement.',
    `component_code` STRING COMMENT 'Externally-known unique business identifier for the component, used in donor reporting, grant management systems, and field operations documentation.. Valid values are `^[A-Z0-9]{3,20}$`',
    `component_status` STRING COMMENT 'Current lifecycle status of the component (planned, active, on hold, completed, closed, cancelled). Tracks component progression through implementation phases.. Valid values are `planned|active|on_hold|completed|closed|cancelled`',
    `component_type` STRING COMMENT 'Classification of the component within the program structure (component, sub-component, workstream, activity cluster, pilot, scale-up).. Valid values are `component|sub-component|workstream|activity_cluster|pilot|scale_up`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this component record was first created in the system. Supports audit trail and data lineage.',
    `cross_cutting_themes` STRING COMMENT 'Cross-cutting priorities integrated into this component (e.g., gender equality, disability inclusion, environmental sustainability, conflict sensitivity, accountability to affected populations).',
    `dac_sector_code` STRING COMMENT 'Five-digit OECD DAC sector code for standardized sector classification and donor reporting (e.g., 14010 for Water Resources Policy, 12220 for Basic Health Care).. Valid values are `^[0-9]{5}$`',
    `component_description` STRING COMMENT 'Detailed narrative describing the components objectives, scope, target beneficiaries, and expected outcomes. Supports Theory of Change (ToC) articulation.',
    `donor_visibility_flag` BOOLEAN COMMENT 'Indicates whether this component requires explicit donor branding, acknowledgment, or public visibility per grant agreement terms (True) or not (False).',
    `end_date` DATE COMMENT 'Planned or actual end date for component implementation. Marks the completion or closeout of the component lifecycle.',
    `funding_source` STRING COMMENT 'Primary donor, grant, or funding mechanism supporting this component (e.g., USAID BHA, CERF, DFID, private foundation). Enables fund accounting and donor visibility.',
    `geographic_focus` STRING COMMENT 'Primary geographic area(s) where this component is implemented (country, region, district, camp, or community names). Supports spatial analysis and field coordination.',
    `grant_requirement_flag` BOOLEAN COMMENT 'Indicates whether this component is mandated by a specific grant agreement or donor requirement (True) or is discretionary within the program design (False).',
    `hierarchy_level` STRING COMMENT 'Numeric level in the program decomposition hierarchy (1=top-level component, 2=sub-component, 3=workstream, etc.). Enables multi-tier program structuring.',
    `implementation_modality` STRING COMMENT 'Delivery approach for this component (direct implementation by NGO staff, partner-led, consortium, sub-award, community-based organization). Affects partnership and compliance requirements.. Valid values are `direct|partner|consortium|sub_award|community_based`',
    `integration_flag` BOOLEAN COMMENT 'Indicates whether this component is part of an integrated multi-sector program (True) or a standalone single-sector intervention (False). Supports integrated programming analysis.',
    `last_amendment_date` DATE COMMENT 'Date of the most recent formal amendment to the component. Null if no amendments have been made.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this component record was most recently updated. Supports change tracking and audit trail.',
    `mitigation_strategy` STRING COMMENT 'Summary of key risk mitigation measures and contingency plans in place for this component. Supports program risk management and donor assurance.',
    `monitoring_frequency` STRING COMMENT 'Scheduled frequency for Monitoring Evaluation and Learning (MEL) data collection and progress reporting for this component. [ENUM-REF-CANDIDATE: weekly|biweekly|monthly|quarterly|semi_annual|annual|event_based — 7 candidates stripped; promote to reference product]',
    `component_name` STRING COMMENT 'Human-readable name of the program component (e.g., Water Supply Infrastructure, Hygiene Promotion, Community Health Worker Training).',
    `notes` STRING COMMENT 'Free-text field for additional context, implementation notes, lessons learned, or special considerations relevant to this component.',
    `reporting_frequency` STRING COMMENT 'Required frequency for formal progress and financial reporting to donors and stakeholders for this component.. Valid values are `monthly|quarterly|semi_annual|annual|final_only`',
    `responsible_manager` STRING COMMENT 'Name of the program manager or component lead accountable for delivery, monitoring, and reporting of this component.',
    `responsible_team` STRING COMMENT 'Name or identifier of the organizational unit, department, or field team responsible for implementing this component.',
    `risk_level` STRING COMMENT 'Overall risk rating for this component based on security, operational, financial, and reputational risk assessments (low, medium, high, critical).. Valid values are `low|medium|high|critical`',
    `sdg_alignment` STRING COMMENT 'Primary United Nations Sustainable Development Goal(s) that this component contributes to (e.g., SDG 6: Clean Water and Sanitation, SDG 3: Good Health and Well-being). Supports impact reporting.',
    `sector` STRING COMMENT 'Primary humanitarian or development sector for this component (e.g., WASH, Health, Nutrition, Education, Protection, Livelihoods, Shelter). [ENUM-REF-CANDIDATE: wash|health|nutrition|education|protection|livelihoods|shelter|food_security|early_recovery|camp_management — promote to reference product]',
    `start_date` DATE COMMENT 'Planned or actual start date for component implementation activities. Marks the beginning of the component lifecycle.',
    `sub_sector` STRING COMMENT 'Detailed sub-sector classification within the primary sector (e.g., for WASH: water supply, sanitation, hygiene promotion; for Health: primary care, maternal health, immunization).',
    `target_beneficiary_count` STRING COMMENT 'Planned number of direct beneficiaries (individuals or households) that this component aims to reach. Used for Monitoring Evaluation and Learning (MEL) target tracking.',
    `theory_of_change_reference` STRING COMMENT 'Reference to the specific pathway or outcome in the programs Theory of Change framework that this component addresses.',
    CONSTRAINT pk_component PRIMARY KEY(`component_id`)
) COMMENT 'Hierarchical decomposition of a program intervention into components, sub-components, or workstreams (e.g., a WASH program broken into water supply, sanitation, and hygiene promotion components). Captures component name, description, sector, sub-sector, responsible team, geographic focus, budget envelope, start/end dates, and status. Supports multi-sector and integrated programming models. Enables program hierarchy navigation from intervention down to activity level.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`program`.`target_population` (
    `target_population_id` BIGINT COMMENT 'Unique identifier for the target population definition. Primary key for this entity.',
    `component_id` BIGINT COMMENT 'Foreign key linking to program.component. Business justification: Target populations are often defined at the component level in multi-component interventions (e.g., the nutrition component targets children under 5, while the WASH component targets all household mem',
    `country_office_id` BIGINT COMMENT 'Foreign key linking to field.country_office. Business justification: Target population data provides evidence for CHS Commitment 3 (strengthening local capacity) and Commitment 4 (communication with communities). Essential for linking beneficiary targeting to CHS compl',
    `intervention_id` BIGINT COMMENT 'Reference to the parent program or intervention that this target population definition belongs to.',
    `program_id` BIGINT COMMENT '',
    `project_site_id` BIGINT COMMENT 'Foreign key linking to field.project_site. Business justification: Target populations are defined for specific project sites. NGOs track which populations are targeted at which sites for beneficiary registration, distribution planning, and donor reporting on geograph',
    `age_range_max` STRING COMMENT 'Maximum age in years for individuals in the target population. Null if no maximum age restriction applies.',
    `age_range_min` STRING COMMENT 'Minimum age in years for individuals in the target population. Null if no minimum age restriction applies.',
    `approval_date` DATE COMMENT 'Date when this target population definition was formally approved for use in program planning and implementation.',
    `approved_by` STRING COMMENT 'Name or identifier of the person or role who approved this target population definition for program implementation.',
    `baseline_date` DATE COMMENT 'Date when the baseline data or needs assessment for this target population was collected or published.',
    `target_population_code` STRING COMMENT 'Short alphanumeric code or identifier used in reporting and documentation to reference this target population (e.g., TP-001, WASH-IDPs-2024).',
    `country_code` STRING COMMENT 'ISO 3166-1 alpha-3 country code where the target population is located (e.g., NGA for Nigeria, BGD for Bangladesh).. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this target population record was first created in the system.',
    `dac_sector_code` STRING COMMENT 'OECD DAC 5-digit sector code for international aid classification and reporting (e.g., 12220 for Basic Health Care).',
    `data_collection_method` STRING COMMENT 'Primary method or approach used to collect data about the target population (e.g., Household Survey, Key Informant Interview (KII), Focus Group Discussion (FGD), Secondary Data Analysis).',
    `data_source` STRING COMMENT 'Source of the population data or needs assessment used to define this target population (e.g., OCHA Humanitarian Needs Overview 2024, Baseline Survey March 2024, Government Census 2023).',
    `target_population_description` STRING COMMENT 'Detailed narrative description of the target population, including demographic characteristics, vulnerability profile, and rationale for targeting.',
    `displacement_status` STRING COMMENT 'Displacement or residency status of the target population (IDP = Internally Displaced Person, PoC = Person of Concern).. Valid values are `idp|refugee|returnee|host_community|mixed|not_applicable`',
    `do_no_harm_considerations` STRING COMMENT 'Documentation of potential risks and mitigation strategies to ensure the targeting approach does not inadvertently cause harm, stigma, or conflict within communities.',
    `donor_visibility_flag` BOOLEAN COMMENT 'Indicates whether this target population definition is visible to donors and included in external reporting and proposals.',
    `effective_end_date` DATE COMMENT 'Date when this target population definition is no longer active or applicable. Null for ongoing or open-ended target populations.',
    `effective_start_date` DATE COMMENT 'Date when this target population definition becomes active and applicable for program planning and beneficiary selection.',
    `estimated_population_size` STRING COMMENT 'Estimated total number of individuals in the target population based on needs assessment, census data, or other planning sources.',
    `exclusion_criteria` STRING COMMENT 'Criteria that explicitly exclude individuals or households from the target population, ensuring appropriate targeting and avoiding duplication with other programs.',
    `gender_integration_approach` STRING COMMENT 'Description of how gender considerations and gender-based vulnerabilities are integrated into the targeting and selection of this population.',
    `geographic_scope` STRING COMMENT 'Geographic area or administrative boundaries where the target population resides (e.g., Borno State, Nigeria, Coxs Bazar District, Bangladesh, Urban Khartoum).',
    `host_community_population_count` STRING COMMENT 'Estimated number of host community members (non-displaced local population) within the target population. Null if not applicable.',
    `idp_population_count` STRING COMMENT 'Estimated number of Internally Displaced Persons (IDPs) within the target population. Null if not applicable.',
    `inclusion_criteria` STRING COMMENT 'Detailed criteria that define who is eligible to be included in the target population (e.g., Children aged 6-59 months with MUAC < 12.5 cm, Households with female head and 3+ dependents).',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this target population record was most recently updated or modified.',
    `target_population_name` STRING COMMENT 'Human-readable name or label for this target population segment (e.g., Malnourished Children Under 5 in Borno State, IDP Women Heads of Household).',
    `notes` STRING COMMENT 'Additional free-text notes, comments, or contextual information about this target population definition.',
    `planned_reach` STRING COMMENT 'Number of individuals the program plans to reach or serve from this target population, considering resource constraints and program scope.',
    `protection_mainstreaming_flag` BOOLEAN COMMENT 'Indicates whether protection principles and safeguarding measures are integrated into the targeting and service delivery for this population.',
    `refugee_population_count` STRING COMMENT 'Estimated number of refugees within the target population. Null if not applicable.',
    `revision_number` STRING COMMENT 'Sequential version number tracking revisions to this target population definition over time.',
    `revision_reason` STRING COMMENT 'Explanation or justification for the most recent revision to this target population definition (e.g., Updated based on new needs assessment, Expanded geographic scope).',
    `sdg_alignment` STRING COMMENT 'Comma-separated list of SDG goals and targets that this target population intervention contributes to (e.g., SDG 2.2, SDG 3.2).',
    `sector_classification` STRING COMMENT 'Primary humanitarian or development sector that this target population is associated with, aligned with cluster coordination frameworks. [ENUM-REF-CANDIDATE: wash|health|nutrition|education|protection|shelter|livelihoods|food_security|multi_sector — 9 candidates stripped; promote to reference product]',
    `sex_disaggregation` STRING COMMENT 'Sex or gender composition of the target population (e.g., female for women-only programs, all for mixed populations).. Valid values are `all|male|female|other|mixed`',
    `target_population_status` STRING COMMENT 'Current lifecycle status of the target population definition within the program planning and execution workflow.. Valid values are `draft|approved|active|suspended|closed`',
    `targeting_methodology` STRING COMMENT 'Primary approach or method used to identify and select beneficiaries from the target population (e.g., MUAC screening for malnutrition, vulnerability scoring, community-based targeting). [ENUM-REF-CANDIDATE: community_based|vulnerability_scoring|muac_screening|household_economy_approach|geographic|categorical|self_targeting|mixed_methods — 8 candidates stripped; promote to reference product]',
    `vulnerability_category` STRING COMMENT 'Primary vulnerability classification or category that defines this target population (e.g., Severely Malnourished, GBV Survivors, Unaccompanied Minors, Persons with Disabilities).',
    CONSTRAINT pk_target_population PRIMARY KEY(`target_population_id`)
) COMMENT 'Defines the intended beneficiary population for a program intervention or component, capturing targeting criteria, geographic scope, demographic profile (age, sex, vulnerability category), estimated population size, targeting methodology (e.g., MUAC screening, vulnerability scoring, community-based targeting), inclusion/exclusion criteria, and IDP/PoC/host community breakdown. Distinct from individual beneficiary registration (owned by beneficiary domain) — this is the program-level population planning entity.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`program`.`risk_register` (
    `risk_register_id` BIGINT COMMENT 'Unique identifier for the risk register entry. Primary key for the risk register product.',
    `agreement_id` BIGINT COMMENT 'Foreign key linking to partnership.partnership_agreement. Business justification: Risks are often tied to specific partnership agreements (e.g., agreement breach, partner non-compliance). This link supports agreement-level risk tracking and escalation — a named process in NGO partn',
    `amendment_id` BIGINT COMMENT 'Foreign key linking to grant.grant_amendment. Business justification: Grant amendments (scope changes, budget modifications, no-cost extensions) directly trigger risk register updates. NGO risk managers must document which amendment introduced or escalated a risk for do',
    `award_id` BIGINT COMMENT 'Foreign key linking to grant.award. Business justification: When program risks materialize, they become compliance incidents requiring investigation and corrective action. Essential for linking risk management to incident response in nonprofit operations.',
    `component_id` BIGINT COMMENT 'Foreign key linking to program.component. Business justification: Risks in NGO programs are often specific to a particular component or workstream (e.g., supply chain risk for a WASH component, staffing risk for a health component). Adding component_id allows compon',
    `country_office_id` BIGINT COMMENT 'Foreign key linking to field.country_office. Business justification: Risk registers are owned by country offices for escalation, governance, and donor reporting. Country office risk management processes require direct linkage to identify which office owns each risk and',
    `emergency_id` BIGINT COMMENT 'Foreign key linking to field.emergency. Business justification: Emergencies elevate or create new risks in NGO risk registers. Linking risk entries to the triggering emergency enables emergency-specific risk reporting, escalation tracking, and post-emergency lesso',
    `implementation_plan_id` BIGINT COMMENT 'Foreign key linking to program.implementation_plan. Business justification: Risks identified in the risk register are often associated with specific implementation plans — the operational work plans where the risk materializes. This FK enables plan-level risk management and a',
    `intervention_id` BIGINT COMMENT 'Reference to the program intervention to which this risk applies. Links risk to the specific humanitarian or development program.',
    `partner_org_id` BIGINT COMMENT 'Foreign key linking to partnership.partner_org. Business justification: NGO risk registers frequently contain partner-specific risks (financial mismanagement, capacity gaps, compliance failures). Linking risk_register to partner_org enables partner risk profiling, due dil',
    `program_id` BIGINT COMMENT '',
    `project_site_id` BIGINT COMMENT 'Foreign key linking to field.project_site. Business justification: Risks are frequently site-specific (security, access, environmental hazards). NGO risk registers track risks at project site level for site-level mitigation planning, security reporting, and CHS compl',
    `affected_sdg` STRING COMMENT 'Reference to the Sustainable Development Goal(s) that may be impacted if this risk materializes. Supports alignment with global development frameworks and donor reporting.',
    `affected_sector` STRING COMMENT 'Program sector(s) that would be impacted by the risk (e.g., WASH, Health, Nutrition, Education, Protection, Livelihoods). Supports sector-specific risk analysis and reporting.',
    `approval_date` DATE COMMENT 'Date when the risk assessment and mitigation plan were formally approved. Supports governance and audit trail requirements.',
    `closure_date` DATE COMMENT 'Date when the risk was formally closed, either because it was fully mitigated, no longer relevant, or the program ended. Supports risk lifecycle completion tracking.',
    `contingency_plan` STRING COMMENT 'Detailed response plan to be activated if the risk materializes. Includes trigger points, escalation procedures, alternative delivery mechanisms, and resource reallocation strategies.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this risk register record was first created in the system. Supports audit trail and data lineage.',
    `donor_visibility_flag` BOOLEAN COMMENT 'Indicates whether this risk must be reported to donors as part of grant compliance requirements. True if donor reporting is required; false otherwise.',
    `effective_end_date` DATE COMMENT 'Date until which this version of the risk assessment is effective. Null for the current active version. Supports temporal tracking and historical risk analysis.',
    `effective_start_date` DATE COMMENT 'Date from which this version of the risk assessment is effective. Supports temporal tracking and historical risk analysis.',
    `escalation_required_flag` BOOLEAN COMMENT 'Indicates whether the risk requires escalation to senior management or board level due to its severity or potential organizational impact. True if escalation is required; false otherwise.',
    `geographic_scope` STRING COMMENT 'Geographic area(s) affected by the risk (country, region, district, project site). Supports location-based risk mapping and field operations planning.',
    `identification_date` DATE COMMENT 'Date when the risk was first identified and entered into the risk register. Supports risk lifecycle tracking and audit trails.',
    `impact_rating` STRING COMMENT 'Qualitative assessment of the severity of consequences if the risk materializes. Considers impact on beneficiaries, program objectives, organizational reputation, and donor relations.. Valid values are `very low|low|medium|high|very high`',
    `impact_score` STRING COMMENT 'Numeric score representing the severity of impact if the risk occurs, typically on a scale of 1-5 where 1 is very low and 5 is very high. Used for quantitative risk prioritization.',
    `inherent_risk_score` STRING COMMENT 'Calculated risk score before mitigation measures are applied, typically the product of likelihood_score and impact_score. Represents the raw exposure level.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this risk register record was most recently updated. Supports audit trail and change tracking.',
    `last_review_date` DATE COMMENT 'Date when the risk was most recently reviewed and assessed. Supports compliance with donor requirements for periodic risk review (typically quarterly or semi-annually).',
    `likelihood_rating` STRING COMMENT 'Qualitative assessment of the probability that the risk will materialize during the program lifecycle. Typically rated on a five-point scale aligned with organizational risk appetite.. Valid values are `very low|low|medium|high|very high`',
    `likelihood_score` STRING COMMENT 'Numeric score representing the likelihood of risk occurrence, typically on a scale of 1-5 where 1 is very low and 5 is very high. Used for quantitative risk prioritization.',
    `mitigation_strategy` STRING COMMENT 'Detailed description of the measures, controls, and actions planned or implemented to reduce the likelihood or impact of the risk. Includes preventive and detective controls.',
    `next_review_date` DATE COMMENT 'Scheduled date for the next formal review of the risk. Ensures timely reassessment and supports proactive risk management.',
    `notes` STRING COMMENT 'Additional free-text notes, observations, or context related to the risk. Captures supplementary information not covered in structured fields.',
    `residual_risk_score` STRING COMMENT 'Calculated risk score after mitigation measures are applied. Represents the remaining exposure after controls are in place. Used to assess whether risk is within acceptable tolerance.',
    `revision_reason` STRING COMMENT 'Explanation for why the risk assessment was updated or revised. Captures the business rationale for changes in likelihood, impact, or mitigation strategy.',
    `risk_category` STRING COMMENT 'Classification of the risk type. Operational risks relate to program delivery; contextual risks relate to external environment (security, political); institutional risks relate to organizational capacity; fiduciary risks relate to financial management and compliance; programmatic risks relate to program design and effectiveness; reputational risks relate to organizational standing.. Valid values are `operational|contextual|institutional|fiduciary|programmatic|reputational`',
    `risk_code` STRING COMMENT 'Unique business identifier for the risk entry, typically following organizational risk coding standards (e.g., OPR-001, CTX-045). Used for cross-referencing in donor reports and internal risk management systems.. Valid values are `^[A-Z]{2,4}-[0-9]{3,5}$`',
    `risk_description` STRING COMMENT 'Detailed narrative description of the risk, including the nature of the threat, potential triggers, and context. Captures the full scope of the risk scenario.',
    `risk_level` STRING COMMENT 'Overall risk classification based on the combination of likelihood and impact, determining the priority and urgency of response. Critical risks require immediate escalation and board-level attention.. Valid values are `low|moderate|high|critical`',
    `risk_owner` STRING COMMENT 'Name or role of the individual accountable for monitoring the risk and ensuring mitigation measures are implemented. Typically a senior program or operations manager.',
    `risk_owner_email` STRING COMMENT 'Email address of the risk owner for communication and escalation purposes.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `risk_status` STRING COMMENT 'Current lifecycle state of the risk. Open indicates newly identified; monitoring indicates active tracking; mitigated indicates controls are effective; closed indicates risk no longer relevant; materialized indicates risk has occurred.. Valid values are `open|monitoring|mitigated|closed|materialized`',
    `risk_subcategory` STRING COMMENT 'More granular classification within the risk category (e.g., security incident, supply chain disruption, fraud, partner capacity, beneficiary access). Allows for detailed risk taxonomy alignment.',
    `risk_title` STRING COMMENT 'Short, descriptive title of the risk for quick identification and reporting purposes.',
    `version_number` STRING COMMENT 'Sequential version number of the risk register entry. Incremented each time the risk assessment is updated, supporting risk evolution tracking across the program lifecycle.',
    CONSTRAINT pk_risk_register PRIMARY KEY(`risk_register_id`)
) COMMENT 'Risk register entry for a program intervention, capturing risk description, category (operational, contextual, institutional, fiduciary), likelihood rating, impact rating, risk score, mitigation measures, contingency plan, risk owner, review date, and current status. Supports program design quality, donor compliance (many donors require risk registers), and adaptive management. Versioned to track risk evolution across the program lifecycle.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`program`.`implementation_plan` (
    `implementation_plan_id` BIGINT COMMENT 'Unique identifier for the implementation plan record. Primary key.',
    `agreement_id` BIGINT COMMENT 'Foreign key linking to partnership.partnership_agreement. Business justification: Implementation plans are governed by partnership agreements. This link enables compliance verification — ensuring planned activities align with the agreements authorized scope, budget, and conditions',
    `amendment_id` BIGINT COMMENT 'Foreign key linking to grant.grant_amendment. Business justification: Grant amendments (no-cost extensions, scope changes) require revised implementation plans. NGO program managers must link each implementation plan version to the triggering amendment for donor prior-a',
    `award_id` BIGINT COMMENT 'Foreign key linking to grant.donor_requirement. Business justification: Implementation plans fulfill specific donor compliance requirements (detailed work plans, milestone schedules, activity timelines). Essential for tracking donor deliverable compliance in grant managem',
    `budget_plan_id` BIGINT COMMENT 'Foreign key linking to program.budget_plan. Business justification: An implementation plan (operational work plan) is directly linked to a budget plan — the financial envelope that funds the planned activities. This FK enables integrated program management where work ',
    `component_id` BIGINT COMMENT 'Foreign key linking to program.component. Business justification: An implementation plan (work plan) is frequently scoped to a specific program component or workstream, not just the overall intervention. Adding component_id allows precise traceability from work plan',
    `country_office_id` BIGINT COMMENT 'Foreign key linking to field.country_office. Business justification: Implementation plans are owned and executed by a country office. NGO country offices are responsible for plan approval, budget oversight, and donor reporting. A country office director must see all im',
    `emergency_id` BIGINT COMMENT 'Foreign key linking to field.emergency. Business justification: Emergency response implementation plans are triggered by specific emergency declarations. NGOs create emergency-specific implementation plans referencing the emergency for flash appeal reporting, CERF',
    `intervention_id` BIGINT COMMENT 'Reference to the parent program intervention that this implementation plan operationalizes.',
    `partner_org_id` BIGINT COMMENT 'Foreign key linking to partnership.partner_org. Business justification: Implementation plans in NGOs are executed by a specific implementing partner. This link supports field monitoring, partner accountability reporting, and donor compliance — identifying which partner is',
    `program_id` BIGINT COMMENT '',
    `project_site_id` BIGINT COMMENT 'Foreign key linking to field.project_site. Business justification: Implementation plans define WHERE activities are executed. NGO program officers link implementation plans to project sites for site-level operational planning, activity scheduling, and donor accountab',
    `approval_date` DATE COMMENT 'Date on which this implementation plan was formally approved for execution.',
    `assumptions` STRING COMMENT 'Key assumptions underlying the implementation plan, including security conditions, partner capacity, beneficiary access, and external dependencies.',
    `budget_allocated_amount` DECIMAL(18,2) COMMENT 'Total budget amount allocated to this implementation plan for the planning period.',
    `budget_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the budget allocated amount.. Valid values are `^[A-Z]{3}$`',
    `implementation_plan_code` STRING COMMENT 'Externally-known unique business identifier for the implementation plan, used in donor reporting and field communications.. Valid values are `^[A-Z0-9]{6,20}$`',
    `coordination_mechanism` STRING COMMENT 'Description of coordination mechanisms with partners, clusters, local authorities, and other stakeholders for implementation plan execution.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this implementation plan record was first created in the system.',
    `dac_sector_code` STRING COMMENT 'Five-digit OECD DAC sector code classifying the implementation plan for international aid transparency and reporting.. Valid values are `^[0-9]{5}$`',
    `disaggregation_approach` STRING COMMENT 'Description of how beneficiary data will be disaggregated (by gender, age, disability, displacement status, etc.) for equity and accountability.',
    `donor_visibility_flag` BOOLEAN COMMENT 'Indicates whether this implementation plan is visible to donors for transparency and reporting purposes.',
    `geographic_scope` STRING COMMENT 'Geographic coverage of the implementation plan, listing countries, regions, districts, or project sites where activities will be executed.',
    `grant_requirement_flag` BOOLEAN COMMENT 'Indicates whether this implementation plan is a mandatory deliverable under a specific grant agreement.',
    `implementation_plan_status` STRING COMMENT 'Current lifecycle status of the implementation plan indicating approval and execution state. [ENUM-REF-CANDIDATE: draft|submitted|approved|active|on_hold|revised|completed|closed|cancelled — 9 candidates stripped; promote to reference product]',
    `implementation_plan_type` STRING COMMENT 'Classification of the implementation plan by temporal scope and purpose (annual work plan, quarterly plan, emergency response plan, etc.).. Valid values are `annual|quarterly|project_phase|emergency_response|pilot|scale_up`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this implementation plan record was last modified in the system.',
    `last_revision_date` DATE COMMENT 'Date of the most recent revision or amendment to this implementation plan.',
    `logframe_reference` STRING COMMENT 'Reference identifier linking this implementation plan to specific outputs and activities in the program LogFrame.',
    `manager_name` STRING COMMENT 'Full name of the staff member serving as the implementation plan manager or work plan coordinator.',
    `monitoring_approach` STRING COMMENT 'Description of the monitoring and evaluation approach for tracking implementation plan progress, including data collection methods and frequency.',
    `notes` STRING COMMENT 'Additional notes, comments, or contextual information relevant to this implementation plan.',
    `planning_period_end_date` DATE COMMENT 'End date of the planning period covered by this implementation plan, marking the scheduled completion of all activities.',
    `planning_period_start_date` DATE COMMENT 'Start date of the planning period covered by this implementation plan, marking the beginning of scheduled activities.',
    `reporting_frequency` STRING COMMENT 'Frequency at which progress reports on this implementation plan will be generated for internal management and donor reporting. [ENUM-REF-CANDIDATE: weekly|biweekly|monthly|quarterly|semi_annual|annual|ad_hoc — 7 candidates stripped; promote to reference product]',
    `resource_requirements_summary` STRING COMMENT 'Summary of human resources, equipment, supplies, and other resources required to execute this implementation plan.',
    `responsible_unit` STRING COMMENT 'Name of the organizational unit, department, or country office responsible for executing this implementation plan.',
    `revision_reason` STRING COMMENT 'Explanation of why the implementation plan was revised, including changes in context, donor requirements, or operational constraints.',
    `risk_level` STRING COMMENT 'Overall risk level assessment for successful execution of this implementation plan, considering security, access, capacity, and external factors.. Valid values are `low|medium|high|critical`',
    `risk_mitigation_summary` STRING COMMENT 'Summary of key risks identified and mitigation strategies planned to ensure implementation plan success.',
    `sector_classification` STRING COMMENT 'Primary humanitarian or development sector that this implementation plan addresses, aligned with cluster coordination system. [ENUM-REF-CANDIDATE: WASH|health|nutrition|education|protection|livelihoods|shelter|food_security|multi_sector — 9 candidates stripped; promote to reference product]',
    `target_beneficiary_count` STRING COMMENT 'Total number of direct beneficiaries (individuals or households) targeted by this implementation plan.',
    `target_beneficiary_type` STRING COMMENT 'Unit of measurement for target beneficiaries (individuals, households, communities, or institutions).. Valid values are `individuals|households|communities|institutions`',
    `title` STRING COMMENT 'Descriptive title of the implementation plan, summarizing the intervention scope and geographic focus.',
    `toc_reference` STRING COMMENT 'Reference identifier linking this implementation plan to the program Theory of Change pathway and assumptions.',
    `total_planned_activities` STRING COMMENT 'Total number of discrete activities scheduled in this implementation plan.',
    `total_planned_milestones` STRING COMMENT 'Total number of key milestones defined in this implementation plan for progress tracking and donor reporting.',
    `version` STRING COMMENT 'Version number of the implementation plan following semantic versioning (e.g., 1.0, 1.1, 2.0) to track revisions and amendments.. Valid values are `^[0-9]+.[0-9]+$`',
    CONSTRAINT pk_implementation_plan PRIMARY KEY(`implementation_plan_id`)
) COMMENT 'Detailed implementation plan (work plan) for a program intervention or component, serving as the operational roadmap for field teams and the baseline for progress tracking. Captures planned activities at the task level including activity name, description, type, responsible parties, timelines (Gantt-style), resource requirements, geographic phasing, target beneficiary counts, status tracking, and linkage to LogFrame outputs. Includes comprehensive milestone tracking (program launch, mid-term review, final evaluation, closeout, donor reporting deadlines) with milestone type, planned/actual dates, completion status, deliverable description, sign-off authority, and dependency sequencing. Stores plan version, planning period, approval status, and last revision date. This is the SSOT for all program scheduling, activity sequencing, and milestone management — the schedule authority for donor reporting timelines and grant compliance.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`program`.`budget_plan` (
    `budget_plan_id` BIGINT COMMENT 'Unique identifier for the program budget plan record.',
    `agreement_id` BIGINT COMMENT 'Foreign key linking to partnership.partnership_agreement. Business justification: Budget plans for partner-implemented programs must reference the governing partnership agreement for compliance tracking, allowable cost verification, financial reconciliation, and donor audit trails.',
    `amendment_id` BIGINT COMMENT 'Foreign key linking to grant.grant_amendment. Business justification: Budget plan revisions are directly triggered by grant amendments modifying obligated amounts, cost categories, or period of performance. NGO finance teams must trace each budget plan version to its au',
    `award_id` BIGINT COMMENT 'Reference to the grant funding this budget plan, if applicable.',
    `component_id` BIGINT COMMENT 'Foreign key linking to program.component. Business justification: Budget plans in NGO programs are commonly structured at the component level (e.g., WASH component budget, nutrition component budget) within an intervention. Adding component_id enables component-leve',
    `country_office_id` BIGINT COMMENT 'Foreign key linking to field.country_office. Business justification: Budget plans are managed and approved by country offices for financial oversight, audit compliance, and donor reporting. Country office finance teams need direct access to all budget plans under their',
    `fund_id` BIGINT COMMENT 'Foreign key linking to donor.fund. Business justification: Budget plans must allocate expenses to specific donor funds for restriction compliance and fund accounting. Critical for budget-to-fund allocation, grant financial reporting, restricted fund managemen',
    `intervention_id` BIGINT COMMENT 'Reference to the program intervention this budget plan supports.',
    `program_id` BIGINT COMMENT '',
    `project_site_id` BIGINT COMMENT 'Foreign key linking to field.project_site. Business justification: Program budget plans must reference the master finance budget for reconciliation, variance analysis, and donor reporting. Critical for ensuring program budgets align with organizational financial plan',
    `amendment_date` DATE COMMENT 'Date on which this budget plan amendment was executed.',
    `amendment_reason` STRING COMMENT 'Explanation of why this budget plan was amended or revised, if applicable.',
    `approval_date` DATE COMMENT 'Date on which this budget plan was formally approved.',
    `budget_assumptions` STRING COMMENT 'Key assumptions underlying the budget plan, such as exchange rates, inflation rates, beneficiary numbers, or activity volumes.',
    `budget_narrative` STRING COMMENT 'Detailed narrative justification and explanation of the budget plan, including assumptions, methodologies, and cost calculations.',
    `budget_owner` STRING COMMENT 'Name or identifier of the program manager or budget holder responsible for this budget plan.',
    `budget_period_end_date` DATE COMMENT 'End date of the budget period this plan covers.',
    `budget_period_start_date` DATE COMMENT 'Start date of the budget period this plan covers.',
    `budget_status` STRING COMMENT 'Current lifecycle status of the budget plan in the approval and execution workflow. [ENUM-REF-CANDIDATE: draft|submitted|under_review|approved|active|amended|closed|rejected — 8 candidates stripped; promote to reference product]',
    `budget_type` STRING COMMENT 'Classification of the budget plan indicating whether it is the original approved budget, a revision, supplemental funding, or closeout budget.. Valid values are `original|revised|supplemental|no_cost_extension|closeout`',
    `budget_version_number` STRING COMMENT 'Version number of this budget plan, incremented with each revision or amendment.',
    `compliance_notes` STRING COMMENT 'Notes regarding compliance requirements, restrictions, or special conditions attached to this budget plan.',
    `contractual_costs` DECIMAL(18,2) COMMENT 'Total budgeted amount for contractual services, consultants, and sub-awards.',
    `cost_share_amount` DECIMAL(18,2) COMMENT 'Total budgeted amount of cost sharing or matching funds contributed by the organization or other sources.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this budget plan record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts in this budget plan.. Valid values are `^[A-Z]{3}$`',
    `dac_sector_code` STRING COMMENT 'OECD DAC sector classification code for this budget plan, used for international aid transparency and reporting.',
    `donor_budget_code` STRING COMMENT 'Donor-specific budget classification code or identifier required for reporting and compliance.',
    `donor_visibility_flag` BOOLEAN COMMENT 'Indicates whether this budget plan is visible to the donor in reporting portals or dashboards.',
    `equipment_costs` DECIMAL(18,2) COMMENT 'Total budgeted amount for equipment purchases with unit cost exceeding capitalization threshold.',
    `finance_contact` STRING COMMENT 'Name or identifier of the finance team member responsible for financial oversight of this budget plan.',
    `fringe_benefits_costs` DECIMAL(18,2) COMMENT 'Total budgeted amount for fringe benefits associated with personnel costs.',
    `indirect_cost_rate` DECIMAL(18,2) COMMENT 'Approved indirect cost rate percentage applied to the direct cost base, as negotiated in NICRA or per de minimis rate.',
    `indirect_costs` DECIMAL(18,2) COMMENT 'Total budgeted amount for indirect costs (Facilities and Administration), calculated by applying the indirect cost rate to the direct cost base.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this budget plan record was last updated or modified.',
    `budget_plan_name` STRING COMMENT 'Descriptive name or title of the budget plan, typically aligned with program or grant phase.',
    `notes` STRING COMMENT 'Additional free-text notes or comments about this budget plan.',
    `number` STRING COMMENT 'Externally-known unique identifier or code for this budget plan, used in donor reporting and financial communications.',
    `personnel_costs` DECIMAL(18,2) COMMENT 'Total budgeted amount for personnel salaries and wages.',
    `sdg_alignment` STRING COMMENT 'Sustainable Development Goal(s) this budget plan contributes to, typically represented as SDG numbers (e.g., SDG 1, SDG 3).',
    `sector_classification` STRING COMMENT 'Humanitarian or development sector classification for this budget plan. [ENUM-REF-CANDIDATE: wash|health|nutrition|education|protection|livelihoods|shelter|food_security|emergency_response|capacity_building — 10 candidates stripped; promote to reference product]',
    `submitted_date` DATE COMMENT 'Date on which this budget plan was submitted for approval or to the donor.',
    `supplies_costs` DECIMAL(18,2) COMMENT 'Total budgeted amount for supplies and consumable materials.',
    `total_approved_budget_amount` DECIMAL(18,2) COMMENT 'Total approved budget amount for this plan, representing the sum of all cost categories.',
    `total_direct_costs` DECIMAL(18,2) COMMENT 'Sum of all direct cost categories before indirect costs are applied.',
    `travel_costs` DECIMAL(18,2) COMMENT 'Total budgeted amount for travel expenses including international and domestic travel.',
    CONSTRAINT pk_budget_plan PRIMARY KEY(`budget_plan_id`)
) COMMENT 'Program-level budget plan capturing the approved budget envelope for a program intervention, including line-item detail by cost category (personnel, fringe, travel, equipment, supplies, contractual, other direct costs, indirect costs). Stores total approved budget, currency, budget period, budget version, donor-specific budget codes, indirect cost rate (ICR/NICRA), F&A allocation, unit costs, quantities, and budget status. Distinct from the finance domains GL and BvA tracking — this is the program-level planning budget owned by program management.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`program`.`budget_plan_line` (
    `budget_plan_line_id` BIGINT COMMENT 'Unique identifier for the budget plan line item. Primary key for this entity.',
    `agreement_id` BIGINT COMMENT 'Foreign key linking to partnership.partnership_agreement. Business justification: Individual budget line items in partner-executed programs must trace to the partnership agreement for line-item allowability verification, indirect cost rate application, cost-sharing validation, and ',
    `award_id` BIGINT COMMENT 'Reference to the grant or funding award that finances this budget line. Enables donor-specific budget reporting and compliance tracking.',
    `budget_plan_id` BIGINT COMMENT 'Reference to the parent budget plan document that contains this line item. Links to the overall program budget structure.',
    `component_id` BIGINT COMMENT 'Foreign key linking to program.component. Business justification: Individual budget line items are often attributed to specific program components for cost allocation and financial reporting purposes. This enables component-level expenditure tracking and donor repor',
    `fund_id` BIGINT COMMENT 'Foreign key linking to donor.fund. Business justification: Individual budget line items allocated to specific donor funds enable granular restriction tracking and line-item fund accounting. Required for detailed financial reporting, multi-fund budget allocati',
    `intervention_id` BIGINT COMMENT 'Reference to the program or project to which this budget line belongs. Enables program-level budget rollup and tracking.',
    `logframe_row_id` BIGINT COMMENT 'Foreign key linking to program.logframe_row. Business justification: Activity-based budgeting in NGO programs links individual budget line items to specific logframe rows (activities or outputs). This FK enables results-based financial management — tracking how much bu',
    `project_site_id` BIGINT COMMENT 'Foreign key linking to field.project_site. Business justification: Line-level linkage between program and finance budgets enables detailed variance analysis, actual-vs-budget reporting, and financial statement preparation. Essential for grant compliance and donor rep',
    `activity_code` STRING COMMENT 'Program activity or intervention code that this budget line supports. Links budget to program implementation activities.',
    `allowable_cost_flag` BOOLEAN COMMENT 'Indicates whether this cost is allowable under the grant or donor regulations. Used for budget review and compliance validation.',
    `approval_date` DATE COMMENT 'Date when this budget line was formally approved. Critical for compliance and audit documentation.',
    `approval_required_flag` BOOLEAN COMMENT 'Indicates whether this budget line requires explicit donor or management approval before execution. Used for budget control and governance.',
    `budget_period_end_date` DATE COMMENT 'The end date of the budget period for which this line item is planned. Defines the timeframe for budget execution and BvA analysis.',
    `budget_period_start_date` DATE COMMENT 'The start date of the budget period for which this line item is planned. Enables multi-year and phased budget tracking.',
    `budget_plan_line_status` STRING COMMENT 'Current lifecycle status of the budget line item. Tracks approval workflow and execution state. [ENUM-REF-CANDIDATE: draft|submitted|approved|active|revised|closed|cancelled — 7 candidates stripped; promote to reference product]',
    `budget_version_number` STRING COMMENT 'Version number of the budget plan to track revisions and amendments. Incremented with each budget modification.',
    `chart_of_accounts_code` STRING COMMENT 'General Ledger account code from the organizations Chart of Accounts. Links budget planning to financial accounting and enables BvA tracking.',
    `cost_category` STRING COMMENT 'Primary budget classification category following standard nonprofit and federal grant budget structures. Used for donor reporting and financial compliance. [ENUM-REF-CANDIDATE: personnel|fringe_benefits|travel|equipment|supplies|contractual|subawards|other_direct_costs|indirect_costs — 9 candidates stripped; promote to reference product]',
    `cost_sharing_amount` DECIMAL(18,2) COMMENT 'The portion of the total planned amount that represents cost sharing or matching contribution. Used for grant compliance reporting.',
    `cost_sharing_flag` BOOLEAN COMMENT 'Indicates whether this budget line includes cost sharing or matching funds from the organization or other sources. Critical for grant compliance.',
    `cost_sharing_source` STRING COMMENT 'The source of cost sharing funds (e.g., organizational reserves, other grants, in-kind contributions, partner contributions).',
    `cost_subcategory` STRING COMMENT 'Detailed subcategory within the primary cost category for granular budget tracking (e.g., international travel, local travel, office supplies, medical supplies).',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this budget line record was first created in the system. Required for audit trail and data lineage.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the budget line amounts (e.g., USD, EUR, GBP). Enables multi-currency budget management.. Valid values are `^[A-Z]{3}$`',
    `dac_sector_code` STRING COMMENT 'OECD DAC 5-digit sector classification code for international development reporting and sector-based budget analysis.',
    `budget_plan_line_description` STRING COMMENT 'Detailed narrative description of the budget line item explaining the purpose, justification, and planned use of funds.',
    `direct_cost_flag` BOOLEAN COMMENT 'Indicates whether this budget line is a direct cost (true) or an indirect/overhead cost (false). Used for indirect cost rate calculations and compliance.',
    `donor_budget_code` STRING COMMENT 'Donor-specific budget line code or reference number required for grant reporting and financial compliance. Maps to donor financial systems.',
    `fiscal_year` STRING COMMENT 'The fiscal year to which this budget line belongs. Enables fiscal year-based budget reporting and analysis.',
    `indirect_cost_rate` DECIMAL(18,2) COMMENT 'The indirect cost rate applied to this budget line if it is a direct cost base. Expressed as a decimal (e.g., 0.1500 for 15%). Links to NICRA.',
    `last_modified_by` STRING COMMENT 'Identifier of the user or system that last modified this budget line record. Supports change tracking and accountability.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this budget line record was last updated. Critical for audit trail and version control.',
    `notes` STRING COMMENT 'Additional notes, comments, or clarifications about this budget line item for internal reference and donor communication.',
    `number` STRING COMMENT 'Sequential or hierarchical line number within the budget plan for ordering and reference purposes (e.g., 1.1, 1.2, 2.1).',
    `quantity` DECIMAL(18,2) COMMENT 'The number of units planned for this budget line item. Used with unit cost to calculate total planned amount.',
    `revision_reason` STRING COMMENT 'Explanation for any revision or amendment to this budget line. Required for donor reporting and audit trail.',
    `sdg_alignment` STRING COMMENT 'United Nations Sustainable Development Goal number(s) that this budget line contributes to (e.g., SDG 1, SDG 3, SDG 6). Supports impact reporting.',
    `total_planned_amount` DECIMAL(18,2) COMMENT 'The total budgeted amount for this line item, typically calculated as quantity multiplied by unit cost. Primary financial value for budget versus actual (BvA) tracking.',
    `unit_cost` DECIMAL(18,2) COMMENT 'The cost per single unit of measure. Multiplied by quantity to derive the total planned amount for this line.',
    `unit_of_measure` STRING COMMENT 'The unit by which the budget item is measured (e.g., person-months, trips, units, days, hours, items, sessions).',
    `created_by` STRING COMMENT 'Identifier of the user or system that created this budget line record. Supports audit trail and data governance.',
    CONSTRAINT pk_budget_plan_line PRIMARY KEY(`budget_plan_line_id`)
) COMMENT 'Individual budget line item within a program budget, capturing cost category (personnel, fringe, travel, equipment, supplies, contractual, other direct costs, indirect costs), budget line description, unit cost, quantity, unit of measure, total planned amount, donor budget code, and cost-sharing flag. Enables granular budget management, BvA tracking linkage to finance domain, and donor financial reporting by budget category.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`program`.`program` (
    `program_id` BIGINT COMMENT 'Primary key for program',
    `agreement_id` BIGINT COMMENT 'Foreign key linking to partnership.partnership_agreement. Business justification: A program is often governed by a master partnership agreement. program has partner_org_id but no direct agreement link. This supports grant compliance reporting — identifying which agreement authorize',
    `award_id` BIGINT COMMENT 'Foreign key linking to grant.award. Business justification: Program-level financial oversight, closeout tracking, and compliance reporting require linking a program to its funding award. grant_number is a denormalized representation of the award. NGO program m',
    `constituent_id` BIGINT COMMENT 'Identifier of the primary donor or funding organization for this program.',
    `country_office_id` BIGINT COMMENT 'Foreign key linking to field.country_office. Business justification: Programs are owned and governed by a country office — a fundamental NGO operational structure. Country office directors manage program portfolios, approve budgets, and report to donors. Every program ',
    `intervention_id` BIGINT COMMENT 'add column intervention_id (BIGINT) with FK to program.intervention.intervention_id - program is completely isolated (zero inbound, zero outbound FKs) and must link to its child interventions as the top-level program entity',
    `parent_program_id` BIGINT COMMENT 'Identifier of the parent program if this program is part of a larger program hierarchy or portfolio.',
    `partner_org_id` BIGINT COMMENT 'Identifier of the primary implementing partner organization responsible for program execution.',
    `approval_date` DATE COMMENT 'Date when the program proposal was formally approved by internal governance or donor.',
    `budget_amount` DECIMAL(18,2) COMMENT 'Total approved budget for the program across all funding sources in the programs base currency.',
    `budget_currency` STRING COMMENT 'Three-letter ISO 4217 currency code for the program budget.',
    `closeout_date` DATE COMMENT 'Date when all program activities, financial reconciliation, and final reporting were completed.',
    `cluster_code` STRING COMMENT 'Code identifying the humanitarian cluster or sector coordination mechanism the program is aligned with (e.g., WASH, Health, Protection).',
    `program_code` STRING COMMENT 'Externally-known unique alphanumeric code assigned to the program for identification across systems and donor reporting.',
    `compliance_status` STRING COMMENT 'Current compliance standing with donor requirements, regulatory obligations, and internal policies.',
    `country_code` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 code for the primary country of program implementation.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the program record was first created in the system.',
    `program_description` STRING COMMENT 'Comprehensive narrative describing the programs objectives, scope, target population, and expected outcomes.',
    `end_date` DATE COMMENT 'Planned or actual end date when program activities conclude and closeout begins.',
    `geographic_scope` STRING COMMENT 'Spatial scale of program implementation indicating coverage area.',
    `is_emergency` BOOLEAN COMMENT 'Indicates whether the program is classified as an emergency response intervention requiring expedited procedures.',
    `is_multi_year` BOOLEAN COMMENT 'Indicates whether the program spans multiple fiscal years requiring multi-year budgeting and planning.',
    `logframe_reference` STRING COMMENT 'Reference identifier or document link to the programs Logical Framework Matrix defining objectives, indicators, and assumptions.',
    `modified_by` STRING COMMENT 'Username or identifier of the user who last modified the program record.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the program record was last updated in the system.',
    `monitoring_frequency` STRING COMMENT 'Scheduled frequency for program monitoring and evaluation activities.',
    `program_name` STRING COMMENT 'Official name of the humanitarian or development program as registered with donors and governing bodies.',
    `program_status` STRING COMMENT 'Current lifecycle status of the program indicating its operational state.',
    `program_type` STRING COMMENT 'Classification of the program based on its primary intervention approach and duration.',
    `region` STRING COMMENT 'Geographic region or administrative area within the country where the program operates.',
    `reporting_frequency` STRING COMMENT 'Required frequency for submitting progress and financial reports to donors and stakeholders.',
    `risk_rating` STRING COMMENT 'Overall risk assessment level for the program considering contextual, operational, financial, and reputational risks.',
    `sdg_alignment` STRING COMMENT 'Comma-separated list of SDG goal numbers (1-17) and targets that the program contributes to.',
    `sector_code` STRING COMMENT 'Five-digit code identifying the primary humanitarian or development sector (WASH, Health, Nutrition, Education, Protection, Livelihood, Shelter, etc.).',
    `sector_name` STRING COMMENT 'Human-readable name of the primary sector in which the program operates.',
    `start_date` DATE COMMENT 'Official start date when program implementation begins as per the approved proposal or agreement.',
    `subsector` STRING COMMENT 'More granular classification within the primary sector (e.g., Water Supply, Sanitation, Hygiene Promotion under WASH).',
    `target_beneficiaries` STRING COMMENT 'Planned total number of direct beneficiaries the program aims to reach.',
    `target_population` STRING COMMENT 'Description of the intended beneficiary population including demographic characteristics, vulnerability criteria, and geographic scope.',
    `theory_of_change` STRING COMMENT 'Narrative or structured description of the causal pathway linking program inputs, activities, outputs, outcomes, and impact.',
    `created_by` STRING COMMENT 'Username or identifier of the user who created the program record.',
    CONSTRAINT pk_program PRIMARY KEY(`program_id`)
) COMMENT 'Master reference table for program. Referenced by program_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_ngo_v1`.`program`.`program_logframe` ADD CONSTRAINT `fk_program_program_logframe_intervention_id` FOREIGN KEY (`intervention_id`) REFERENCES `vibe_ngo_v1`.`program`.`intervention`(`intervention_id`);
ALTER TABLE `vibe_ngo_v1`.`program`.`program_logframe` ADD CONSTRAINT `fk_program_program_logframe_program_id` FOREIGN KEY (`program_id`) REFERENCES `vibe_ngo_v1`.`program`.`program`(`program_id`);
ALTER TABLE `vibe_ngo_v1`.`program`.`logframe_row` ADD CONSTRAINT `fk_program_logframe_row_component_id` FOREIGN KEY (`component_id`) REFERENCES `vibe_ngo_v1`.`program`.`component`(`component_id`);
ALTER TABLE `vibe_ngo_v1`.`program`.`logframe_row` ADD CONSTRAINT `fk_program_logframe_row_intervention_id` FOREIGN KEY (`intervention_id`) REFERENCES `vibe_ngo_v1`.`program`.`intervention`(`intervention_id`);
ALTER TABLE `vibe_ngo_v1`.`program`.`logframe_row` ADD CONSTRAINT `fk_program_logframe_row_parent_result_logframe_row_id` FOREIGN KEY (`parent_result_logframe_row_id`) REFERENCES `vibe_ngo_v1`.`program`.`logframe_row`(`logframe_row_id`);
ALTER TABLE `vibe_ngo_v1`.`program`.`logframe_row` ADD CONSTRAINT `fk_program_logframe_row_program_logframe_id` FOREIGN KEY (`program_logframe_id`) REFERENCES `vibe_ngo_v1`.`program`.`program_logframe`(`program_logframe_id`);
ALTER TABLE `vibe_ngo_v1`.`program`.`component` ADD CONSTRAINT `fk_program_component_intervention_id` FOREIGN KEY (`intervention_id`) REFERENCES `vibe_ngo_v1`.`program`.`intervention`(`intervention_id`);
ALTER TABLE `vibe_ngo_v1`.`program`.`component` ADD CONSTRAINT `fk_program_component_parent_component_id` FOREIGN KEY (`parent_component_id`) REFERENCES `vibe_ngo_v1`.`program`.`component`(`component_id`);
ALTER TABLE `vibe_ngo_v1`.`program`.`component` ADD CONSTRAINT `fk_program_component_program_id` FOREIGN KEY (`program_id`) REFERENCES `vibe_ngo_v1`.`program`.`program`(`program_id`);
ALTER TABLE `vibe_ngo_v1`.`program`.`target_population` ADD CONSTRAINT `fk_program_target_population_component_id` FOREIGN KEY (`component_id`) REFERENCES `vibe_ngo_v1`.`program`.`component`(`component_id`);
ALTER TABLE `vibe_ngo_v1`.`program`.`target_population` ADD CONSTRAINT `fk_program_target_population_intervention_id` FOREIGN KEY (`intervention_id`) REFERENCES `vibe_ngo_v1`.`program`.`intervention`(`intervention_id`);
ALTER TABLE `vibe_ngo_v1`.`program`.`target_population` ADD CONSTRAINT `fk_program_target_population_program_id` FOREIGN KEY (`program_id`) REFERENCES `vibe_ngo_v1`.`program`.`program`(`program_id`);
ALTER TABLE `vibe_ngo_v1`.`program`.`risk_register` ADD CONSTRAINT `fk_program_risk_register_component_id` FOREIGN KEY (`component_id`) REFERENCES `vibe_ngo_v1`.`program`.`component`(`component_id`);
ALTER TABLE `vibe_ngo_v1`.`program`.`risk_register` ADD CONSTRAINT `fk_program_risk_register_implementation_plan_id` FOREIGN KEY (`implementation_plan_id`) REFERENCES `vibe_ngo_v1`.`program`.`implementation_plan`(`implementation_plan_id`);
ALTER TABLE `vibe_ngo_v1`.`program`.`risk_register` ADD CONSTRAINT `fk_program_risk_register_intervention_id` FOREIGN KEY (`intervention_id`) REFERENCES `vibe_ngo_v1`.`program`.`intervention`(`intervention_id`);
ALTER TABLE `vibe_ngo_v1`.`program`.`risk_register` ADD CONSTRAINT `fk_program_risk_register_program_id` FOREIGN KEY (`program_id`) REFERENCES `vibe_ngo_v1`.`program`.`program`(`program_id`);
ALTER TABLE `vibe_ngo_v1`.`program`.`implementation_plan` ADD CONSTRAINT `fk_program_implementation_plan_budget_plan_id` FOREIGN KEY (`budget_plan_id`) REFERENCES `vibe_ngo_v1`.`program`.`budget_plan`(`budget_plan_id`);
ALTER TABLE `vibe_ngo_v1`.`program`.`implementation_plan` ADD CONSTRAINT `fk_program_implementation_plan_component_id` FOREIGN KEY (`component_id`) REFERENCES `vibe_ngo_v1`.`program`.`component`(`component_id`);
ALTER TABLE `vibe_ngo_v1`.`program`.`implementation_plan` ADD CONSTRAINT `fk_program_implementation_plan_intervention_id` FOREIGN KEY (`intervention_id`) REFERENCES `vibe_ngo_v1`.`program`.`intervention`(`intervention_id`);
ALTER TABLE `vibe_ngo_v1`.`program`.`implementation_plan` ADD CONSTRAINT `fk_program_implementation_plan_program_id` FOREIGN KEY (`program_id`) REFERENCES `vibe_ngo_v1`.`program`.`program`(`program_id`);
ALTER TABLE `vibe_ngo_v1`.`program`.`budget_plan` ADD CONSTRAINT `fk_program_budget_plan_component_id` FOREIGN KEY (`component_id`) REFERENCES `vibe_ngo_v1`.`program`.`component`(`component_id`);
ALTER TABLE `vibe_ngo_v1`.`program`.`budget_plan` ADD CONSTRAINT `fk_program_budget_plan_intervention_id` FOREIGN KEY (`intervention_id`) REFERENCES `vibe_ngo_v1`.`program`.`intervention`(`intervention_id`);
ALTER TABLE `vibe_ngo_v1`.`program`.`budget_plan` ADD CONSTRAINT `fk_program_budget_plan_program_id` FOREIGN KEY (`program_id`) REFERENCES `vibe_ngo_v1`.`program`.`program`(`program_id`);
ALTER TABLE `vibe_ngo_v1`.`program`.`budget_plan_line` ADD CONSTRAINT `fk_program_budget_plan_line_budget_plan_id` FOREIGN KEY (`budget_plan_id`) REFERENCES `vibe_ngo_v1`.`program`.`budget_plan`(`budget_plan_id`);
ALTER TABLE `vibe_ngo_v1`.`program`.`budget_plan_line` ADD CONSTRAINT `fk_program_budget_plan_line_component_id` FOREIGN KEY (`component_id`) REFERENCES `vibe_ngo_v1`.`program`.`component`(`component_id`);
ALTER TABLE `vibe_ngo_v1`.`program`.`budget_plan_line` ADD CONSTRAINT `fk_program_budget_plan_line_intervention_id` FOREIGN KEY (`intervention_id`) REFERENCES `vibe_ngo_v1`.`program`.`intervention`(`intervention_id`);
ALTER TABLE `vibe_ngo_v1`.`program`.`budget_plan_line` ADD CONSTRAINT `fk_program_budget_plan_line_logframe_row_id` FOREIGN KEY (`logframe_row_id`) REFERENCES `vibe_ngo_v1`.`program`.`logframe_row`(`logframe_row_id`);
ALTER TABLE `vibe_ngo_v1`.`program`.`program` ADD CONSTRAINT `fk_program_program_intervention_id` FOREIGN KEY (`intervention_id`) REFERENCES `vibe_ngo_v1`.`program`.`intervention`(`intervention_id`);
ALTER TABLE `vibe_ngo_v1`.`program`.`program` ADD CONSTRAINT `fk_program_program_parent_program_id` FOREIGN KEY (`parent_program_id`) REFERENCES `vibe_ngo_v1`.`program`.`program`(`program_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_ngo_v1`.`program` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `vibe_ngo_v1`.`program` SET TAGS ('dbx_domain' = 'program');
ALTER TABLE `vibe_ngo_v1`.`program`.`intervention` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_ngo_v1`.`program`.`intervention` SET TAGS ('dbx_subdomain' = 'program_design');
ALTER TABLE `vibe_ngo_v1`.`program`.`intervention` ALTER COLUMN `intervention_id` SET TAGS ('dbx_business_glossary_term' = 'Intervention ID');
ALTER TABLE `vibe_ngo_v1`.`program`.`intervention` ALTER COLUMN `country_office_id` SET TAGS ('dbx_business_glossary_term' = 'Country Office Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`program`.`intervention` ALTER COLUMN `funding_source_id` SET TAGS ('dbx_business_glossary_term' = 'Finance Fund Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`program`.`intervention` ALTER COLUMN `actual_end_date` SET TAGS ('dbx_business_glossary_term' = 'Actual End Date');
ALTER TABLE `vibe_ngo_v1`.`program`.`intervention` ALTER COLUMN `actual_start_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Start Date');
ALTER TABLE `vibe_ngo_v1`.`program`.`intervention` ALTER COLUMN `budget_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Budget Currency Code');
ALTER TABLE `vibe_ngo_v1`.`program`.`intervention` ALTER COLUMN `budget_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_ngo_v1`.`program`.`intervention` ALTER COLUMN `chs_compliant` SET TAGS ('dbx_business_glossary_term' = 'Core Humanitarian Standard (CHS) Compliant');
ALTER TABLE `vibe_ngo_v1`.`program`.`intervention` ALTER COLUMN `intervention_code` SET TAGS ('dbx_business_glossary_term' = 'Intervention Code');
ALTER TABLE `vibe_ngo_v1`.`program`.`intervention` ALTER COLUMN `intervention_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{3,20}$');
ALTER TABLE `vibe_ngo_v1`.`program`.`intervention` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_ngo_v1`.`program`.`intervention` ALTER COLUMN `disability_inclusion_marker_score` SET TAGS ('dbx_business_glossary_term' = 'Disability Inclusion Marker Score');
ALTER TABLE `vibe_ngo_v1`.`program`.`intervention` ALTER COLUMN `disability_inclusion_marker_score` SET TAGS ('dbx_value_regex' = '0|1|2|3|4');
ALTER TABLE `vibe_ngo_v1`.`program`.`intervention` ALTER COLUMN `disability_inclusion_marker_score` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`program`.`intervention` ALTER COLUMN `disability_inclusion_marker_score` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_ngo_v1`.`program`.`intervention` ALTER COLUMN `do_no_harm_assessment_completed` SET TAGS ('dbx_business_glossary_term' = 'Do No Harm Assessment Completed');
ALTER TABLE `vibe_ngo_v1`.`program`.`intervention` ALTER COLUMN `environmental_impact_assessment_completed` SET TAGS ('dbx_business_glossary_term' = 'Environmental Impact Assessment Completed');
ALTER TABLE `vibe_ngo_v1`.`program`.`intervention` ALTER COLUMN `gender_marker_score` SET TAGS ('dbx_business_glossary_term' = 'Gender Marker Score');
ALTER TABLE `vibe_ngo_v1`.`program`.`intervention` ALTER COLUMN `gender_marker_score` SET TAGS ('dbx_value_regex' = '0|1|2a|2b');
ALTER TABLE `vibe_ngo_v1`.`program`.`intervention` ALTER COLUMN `gender_marker_score` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`program`.`intervention` ALTER COLUMN `gender_marker_score` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_ngo_v1`.`program`.`intervention` ALTER COLUMN `gender_marker_score` SET TAGS ('dbx_pii_demographic' = 'true');
ALTER TABLE `vibe_ngo_v1`.`program`.`intervention` ALTER COLUMN `geographic_scope` SET TAGS ('dbx_business_glossary_term' = 'Geographic Scope');
ALTER TABLE `vibe_ngo_v1`.`program`.`intervention` ALTER COLUMN `geographic_scope` SET TAGS ('dbx_value_regex' = 'national|regional|district|community|multi_country');
ALTER TABLE `vibe_ngo_v1`.`program`.`intervention` ALTER COLUMN `intervention_status` SET TAGS ('dbx_business_glossary_term' = 'Intervention Status');
ALTER TABLE `vibe_ngo_v1`.`program`.`intervention` ALTER COLUMN `intervention_status` SET TAGS ('dbx_value_regex' = 'pipeline|approved|active|suspended|completed|closed');
ALTER TABLE `vibe_ngo_v1`.`program`.`intervention` ALTER COLUMN `intervention_type` SET TAGS ('dbx_business_glossary_term' = 'Intervention Type');
ALTER TABLE `vibe_ngo_v1`.`program`.`intervention` ALTER COLUMN `intervention_type` SET TAGS ('dbx_value_regex' = 'emergency_response|development|recovery|resilience|advocacy|capacity_building');
ALTER TABLE `vibe_ngo_v1`.`program`.`intervention` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_ngo_v1`.`program`.`intervention` ALTER COLUMN `logframe_document_url` SET TAGS ('dbx_business_glossary_term' = 'Logical Framework (LogFrame) Document URL');
ALTER TABLE `vibe_ngo_v1`.`program`.`intervention` ALTER COLUMN `logic` SET TAGS ('dbx_business_glossary_term' = 'Intervention Logic');
ALTER TABLE `vibe_ngo_v1`.`program`.`intervention` ALTER COLUMN `mel_plan_document_url` SET TAGS ('dbx_business_glossary_term' = 'Monitoring Evaluation and Learning (MEL) Plan Document URL');
ALTER TABLE `vibe_ngo_v1`.`program`.`intervention` ALTER COLUMN `intervention_name` SET TAGS ('dbx_business_glossary_term' = 'Intervention Name');
ALTER TABLE `vibe_ngo_v1`.`program`.`intervention` ALTER COLUMN `intervention_name` SET TAGS ('dbx_pii_personal' = 'true');
ALTER TABLE `vibe_ngo_v1`.`program`.`intervention` ALTER COLUMN `phase` SET TAGS ('dbx_business_glossary_term' = 'Intervention Phase');
ALTER TABLE `vibe_ngo_v1`.`program`.`intervention` ALTER COLUMN `phase` SET TAGS ('dbx_value_regex' = 'design|startup|implementation|closeout');
ALTER TABLE `vibe_ngo_v1`.`program`.`intervention` ALTER COLUMN `planned_end_date` SET TAGS ('dbx_business_glossary_term' = 'Planned End Date');
ALTER TABLE `vibe_ngo_v1`.`program`.`intervention` ALTER COLUMN `planned_start_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Start Date');
ALTER TABLE `vibe_ngo_v1`.`program`.`intervention` ALTER COLUMN `rbm_framework_applied` SET TAGS ('dbx_business_glossary_term' = 'Results-Based Management (RBM) Framework Applied');
ALTER TABLE `vibe_ngo_v1`.`program`.`intervention` ALTER COLUMN `safeguarding_policy_applied` SET TAGS ('dbx_business_glossary_term' = 'Safeguarding Policy Applied');
ALTER TABLE `vibe_ngo_v1`.`program`.`intervention` ALTER COLUMN `sdg_alignment_type` SET TAGS ('dbx_business_glossary_term' = 'Sustainable Development Goal (SDG) Alignment Type');
ALTER TABLE `vibe_ngo_v1`.`program`.`intervention` ALTER COLUMN `sdg_alignment_type` SET TAGS ('dbx_value_regex' = 'direct|indirect|enabling');
ALTER TABLE `vibe_ngo_v1`.`program`.`intervention` ALTER COLUMN `sdg_contribution_narrative` SET TAGS ('dbx_business_glossary_term' = 'Sustainable Development Goal (SDG) Contribution Narrative');
ALTER TABLE `vibe_ngo_v1`.`program`.`intervention` ALTER COLUMN `sdg_goal_primary` SET TAGS ('dbx_business_glossary_term' = 'Sustainable Development Goal (SDG) Primary Goal');
ALTER TABLE `vibe_ngo_v1`.`program`.`intervention` ALTER COLUMN `sdg_goal_primary` SET TAGS ('dbx_value_regex' = '^SDG[0-9]{1,2}$');
ALTER TABLE `vibe_ngo_v1`.`program`.`intervention` ALTER COLUMN `sdg_indicator_primary` SET TAGS ('dbx_business_glossary_term' = 'Sustainable Development Goal (SDG) Primary Indicator');
ALTER TABLE `vibe_ngo_v1`.`program`.`intervention` ALTER COLUMN `sdg_indicator_primary` SET TAGS ('dbx_value_regex' = '^[0-9]{1,2}.[0-9]{1,2}.[0-9]{1,2}$');
ALTER TABLE `vibe_ngo_v1`.`program`.`intervention` ALTER COLUMN `sdg_target_primary` SET TAGS ('dbx_business_glossary_term' = 'Sustainable Development Goal (SDG) Primary Target');
ALTER TABLE `vibe_ngo_v1`.`program`.`intervention` ALTER COLUMN `sdg_target_primary` SET TAGS ('dbx_value_regex' = '^[0-9]{1,2}.[0-9]{1,2}$');
ALTER TABLE `vibe_ngo_v1`.`program`.`intervention` ALTER COLUMN `sector` SET TAGS ('dbx_business_glossary_term' = 'Sector');
ALTER TABLE `vibe_ngo_v1`.`program`.`intervention` ALTER COLUMN `short_name` SET TAGS ('dbx_business_glossary_term' = 'Intervention Short Name');
ALTER TABLE `vibe_ngo_v1`.`program`.`intervention` ALTER COLUMN `short_name` SET TAGS ('dbx_pii_personal' = 'true');
ALTER TABLE `vibe_ngo_v1`.`program`.`intervention` ALTER COLUMN `situation_analysis` SET TAGS ('dbx_business_glossary_term' = 'Situation Analysis');
ALTER TABLE `vibe_ngo_v1`.`program`.`intervention` ALTER COLUMN `sphere_standards_applied` SET TAGS ('dbx_business_glossary_term' = 'Sphere Standards Applied');
ALTER TABLE `vibe_ngo_v1`.`program`.`intervention` ALTER COLUMN `sub_sector` SET TAGS ('dbx_business_glossary_term' = 'Sub-Sector');
ALTER TABLE `vibe_ngo_v1`.`program`.`intervention` ALTER COLUMN `sustainability_plan` SET TAGS ('dbx_business_glossary_term' = 'Sustainability Plan');
ALTER TABLE `vibe_ngo_v1`.`program`.`intervention` ALTER COLUMN `target_beneficiary_count` SET TAGS ('dbx_business_glossary_term' = 'Target Beneficiary Count');
ALTER TABLE `vibe_ngo_v1`.`program`.`intervention` ALTER COLUMN `target_beneficiary_unit` SET TAGS ('dbx_business_glossary_term' = 'Target Beneficiary Unit');
ALTER TABLE `vibe_ngo_v1`.`program`.`intervention` ALTER COLUMN `target_beneficiary_unit` SET TAGS ('dbx_value_regex' = 'individuals|households|communities|institutions');
ALTER TABLE `vibe_ngo_v1`.`program`.`intervention` ALTER COLUMN `targeting_strategy` SET TAGS ('dbx_business_glossary_term' = 'Targeting Strategy');
ALTER TABLE `vibe_ngo_v1`.`program`.`intervention` ALTER COLUMN `theory_of_change_narrative` SET TAGS ('dbx_business_glossary_term' = 'Theory of Change (ToC) Narrative');
ALTER TABLE `vibe_ngo_v1`.`program`.`intervention` ALTER COLUMN `total_budget_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Budget Amount');
ALTER TABLE `vibe_ngo_v1`.`program`.`program_logframe` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_ngo_v1`.`program`.`program_logframe` SET TAGS ('dbx_subdomain' = 'program_design');
ALTER TABLE `vibe_ngo_v1`.`program`.`program_logframe` ALTER COLUMN `program_logframe_id` SET TAGS ('dbx_business_glossary_term' = 'Program Logical Framework (LogFrame) ID');
ALTER TABLE `vibe_ngo_v1`.`program`.`program_logframe` ALTER COLUMN `award_id` SET TAGS ('dbx_business_glossary_term' = 'Award Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`program`.`program_logframe` ALTER COLUMN `country_office_id` SET TAGS ('dbx_business_glossary_term' = 'Chs Self Assessment Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`program`.`program_logframe` ALTER COLUMN `intervention_id` SET TAGS ('dbx_business_glossary_term' = 'Program ID');
ALTER TABLE `vibe_ngo_v1`.`program`.`program_logframe` ALTER COLUMN `proposal_id` SET TAGS ('dbx_business_glossary_term' = 'Proposal Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`program`.`program_logframe` ALTER COLUMN `amendment_reason` SET TAGS ('dbx_business_glossary_term' = 'Amendment Reason');
ALTER TABLE `vibe_ngo_v1`.`program`.`program_logframe` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_ngo_v1`.`program`.`program_logframe` ALTER COLUMN `assumptions` SET TAGS ('dbx_business_glossary_term' = 'Assumptions');
ALTER TABLE `vibe_ngo_v1`.`program`.`program_logframe` ALTER COLUMN `baseline_date` SET TAGS ('dbx_business_glossary_term' = 'Baseline Date');
ALTER TABLE `vibe_ngo_v1`.`program`.`program_logframe` ALTER COLUMN `baseline_value` SET TAGS ('dbx_business_glossary_term' = 'Baseline Value');
ALTER TABLE `vibe_ngo_v1`.`program`.`program_logframe` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_ngo_v1`.`program`.`program_logframe` ALTER COLUMN `dac_sector_code` SET TAGS ('dbx_business_glossary_term' = 'Development Assistance Committee (DAC) Sector Code');
ALTER TABLE `vibe_ngo_v1`.`program`.`program_logframe` ALTER COLUMN `dac_sector_code` SET TAGS ('dbx_value_regex' = '^[0-9]{5}$');
ALTER TABLE `vibe_ngo_v1`.`program`.`program_logframe` ALTER COLUMN `data_collection_method` SET TAGS ('dbx_business_glossary_term' = 'Data Collection Method');
ALTER TABLE `vibe_ngo_v1`.`program`.`program_logframe` ALTER COLUMN `data_source` SET TAGS ('dbx_business_glossary_term' = 'Data Source');
ALTER TABLE `vibe_ngo_v1`.`program`.`program_logframe` ALTER COLUMN `disaggregation_dimensions` SET TAGS ('dbx_business_glossary_term' = 'Disaggregation Dimensions');
ALTER TABLE `vibe_ngo_v1`.`program`.`program_logframe` ALTER COLUMN `donor_visibility_flag` SET TAGS ('dbx_business_glossary_term' = 'Donor Visibility Flag');
ALTER TABLE `vibe_ngo_v1`.`program`.`program_logframe` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_ngo_v1`.`program`.`program_logframe` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_ngo_v1`.`program`.`program_logframe` ALTER COLUMN `grant_requirement_flag` SET TAGS ('dbx_business_glossary_term' = 'Grant Requirement Flag');
ALTER TABLE `vibe_ngo_v1`.`program`.`program_logframe` ALTER COLUMN `hierarchy_level` SET TAGS ('dbx_business_glossary_term' = 'Logical Framework (LogFrame) Hierarchy Level');
ALTER TABLE `vibe_ngo_v1`.`program`.`program_logframe` ALTER COLUMN `hierarchy_level` SET TAGS ('dbx_value_regex' = 'goal|purpose|outcome|output|activity');
ALTER TABLE `vibe_ngo_v1`.`program`.`program_logframe` ALTER COLUMN `indicator_reference_code` SET TAGS ('dbx_business_glossary_term' = 'Indicator Reference Code');
ALTER TABLE `vibe_ngo_v1`.`program`.`program_logframe` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_ngo_v1`.`program`.`program_logframe` ALTER COLUMN `means_of_verification` SET TAGS ('dbx_business_glossary_term' = 'Means of Verification (MoV)');
ALTER TABLE `vibe_ngo_v1`.`program`.`program_logframe` ALTER COLUMN `mitigation_strategy` SET TAGS ('dbx_business_glossary_term' = 'Mitigation Strategy');
ALTER TABLE `vibe_ngo_v1`.`program`.`program_logframe` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_ngo_v1`.`program`.`program_logframe` ALTER COLUMN `program_logframe_status` SET TAGS ('dbx_business_glossary_term' = 'Logical Framework (LogFrame) Row Status');
ALTER TABLE `vibe_ngo_v1`.`program`.`program_logframe` ALTER COLUMN `reporting_frequency` SET TAGS ('dbx_business_glossary_term' = 'Reporting Frequency');
ALTER TABLE `vibe_ngo_v1`.`program`.`program_logframe` ALTER COLUMN `reporting_frequency` SET TAGS ('dbx_value_regex' = 'monthly|quarterly|semi-annually|annually|on-demand');
ALTER TABLE `vibe_ngo_v1`.`program`.`program_logframe` ALTER COLUMN `responsible_unit` SET TAGS ('dbx_business_glossary_term' = 'Responsible Unit');
ALTER TABLE `vibe_ngo_v1`.`program`.`program_logframe` ALTER COLUMN `result_statement` SET TAGS ('dbx_business_glossary_term' = 'Result Statement');
ALTER TABLE `vibe_ngo_v1`.`program`.`program_logframe` ALTER COLUMN `risk_level` SET TAGS ('dbx_business_glossary_term' = 'Risk Level');
ALTER TABLE `vibe_ngo_v1`.`program`.`program_logframe` ALTER COLUMN `risk_level` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `vibe_ngo_v1`.`program`.`program_logframe` ALTER COLUMN `row_sequence_number` SET TAGS ('dbx_business_glossary_term' = 'Row Sequence Number');
ALTER TABLE `vibe_ngo_v1`.`program`.`program_logframe` ALTER COLUMN `sdg_alignment` SET TAGS ('dbx_business_glossary_term' = 'Sustainable Development Goal (SDG) Alignment');
ALTER TABLE `vibe_ngo_v1`.`program`.`program_logframe` ALTER COLUMN `sector_classification` SET TAGS ('dbx_business_glossary_term' = 'Sector Classification');
ALTER TABLE `vibe_ngo_v1`.`program`.`program_logframe` ALTER COLUMN `target_date` SET TAGS ('dbx_business_glossary_term' = 'Target Date');
ALTER TABLE `vibe_ngo_v1`.`program`.`program_logframe` ALTER COLUMN `target_value` SET TAGS ('dbx_business_glossary_term' = 'Target Value');
ALTER TABLE `vibe_ngo_v1`.`program`.`program_logframe` ALTER COLUMN `theory_of_change_reference` SET TAGS ('dbx_business_glossary_term' = 'Theory of Change (ToC) Reference');
ALTER TABLE `vibe_ngo_v1`.`program`.`program_logframe` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `vibe_ngo_v1`.`program`.`program_logframe` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Logical Framework (LogFrame) Version Number');
ALTER TABLE `vibe_ngo_v1`.`program`.`program_logframe` ALTER COLUMN `version_number` SET TAGS ('dbx_value_regex' = '^[0-9]+.[0-9]+$');
ALTER TABLE `vibe_ngo_v1`.`program`.`logframe_row` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_ngo_v1`.`program`.`logframe_row` SET TAGS ('dbx_subdomain' = 'program_design');
ALTER TABLE `vibe_ngo_v1`.`program`.`logframe_row` ALTER COLUMN `logframe_row_id` SET TAGS ('dbx_business_glossary_term' = 'LogFrame Row ID');
ALTER TABLE `vibe_ngo_v1`.`program`.`logframe_row` ALTER COLUMN `component_id` SET TAGS ('dbx_business_glossary_term' = 'Component Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`program`.`logframe_row` ALTER COLUMN `indicator_id` SET TAGS ('dbx_business_glossary_term' = 'Indicator Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`program`.`logframe_row` ALTER COLUMN `intervention_id` SET TAGS ('dbx_business_glossary_term' = 'Program ID');
ALTER TABLE `vibe_ngo_v1`.`program`.`logframe_row` ALTER COLUMN `parent_result_logframe_row_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Result ID');
ALTER TABLE `vibe_ngo_v1`.`program`.`logframe_row` ALTER COLUMN `program_logframe_id` SET TAGS ('dbx_business_glossary_term' = 'Logical Framework (LogFrame) ID');
ALTER TABLE `vibe_ngo_v1`.`program`.`logframe_row` ALTER COLUMN `project_site_id` SET TAGS ('dbx_business_glossary_term' = 'Project Site Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`program`.`logframe_row` ALTER COLUMN `reporting_period_id` SET TAGS ('dbx_business_glossary_term' = 'Reporting Period Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`program`.`logframe_row` ALTER COLUMN `assumptions` SET TAGS ('dbx_business_glossary_term' = 'Assumptions');
ALTER TABLE `vibe_ngo_v1`.`program`.`logframe_row` ALTER COLUMN `baseline_date` SET TAGS ('dbx_business_glossary_term' = 'Baseline Date');
ALTER TABLE `vibe_ngo_v1`.`program`.`logframe_row` ALTER COLUMN `baseline_value` SET TAGS ('dbx_business_glossary_term' = 'Baseline Value');
ALTER TABLE `vibe_ngo_v1`.`program`.`logframe_row` ALTER COLUMN `beneficiary_target_count` SET TAGS ('dbx_business_glossary_term' = 'Beneficiary Target Count');
ALTER TABLE `vibe_ngo_v1`.`program`.`logframe_row` ALTER COLUMN `budget_allocated` SET TAGS ('dbx_business_glossary_term' = 'Budget Allocated');
ALTER TABLE `vibe_ngo_v1`.`program`.`logframe_row` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_ngo_v1`.`program`.`logframe_row` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_ngo_v1`.`program`.`logframe_row` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_ngo_v1`.`program`.`logframe_row` ALTER COLUMN `dac_code` SET TAGS ('dbx_business_glossary_term' = 'Development Assistance Committee (DAC) Code');
ALTER TABLE `vibe_ngo_v1`.`program`.`logframe_row` ALTER COLUMN `data_collection_method` SET TAGS ('dbx_business_glossary_term' = 'Data Collection Method');
ALTER TABLE `vibe_ngo_v1`.`program`.`logframe_row` ALTER COLUMN `disaggregation_dimensions` SET TAGS ('dbx_business_glossary_term' = 'Disaggregation Dimensions');
ALTER TABLE `vibe_ngo_v1`.`program`.`logframe_row` ALTER COLUMN `geographic_scope` SET TAGS ('dbx_business_glossary_term' = 'Geographic Scope');
ALTER TABLE `vibe_ngo_v1`.`program`.`logframe_row` ALTER COLUMN `implementation_end_date` SET TAGS ('dbx_business_glossary_term' = 'Implementation End Date');
ALTER TABLE `vibe_ngo_v1`.`program`.`logframe_row` ALTER COLUMN `implementation_start_date` SET TAGS ('dbx_business_glossary_term' = 'Implementation Start Date');
ALTER TABLE `vibe_ngo_v1`.`program`.`logframe_row` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_ngo_v1`.`program`.`logframe_row` ALTER COLUMN `logframe_row_status` SET TAGS ('dbx_business_glossary_term' = 'LogFrame Row Status');
ALTER TABLE `vibe_ngo_v1`.`program`.`logframe_row` ALTER COLUMN `means_of_verification` SET TAGS ('dbx_business_glossary_term' = 'Means of Verification (MoV)');
ALTER TABLE `vibe_ngo_v1`.`program`.`logframe_row` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Modified By');
ALTER TABLE `vibe_ngo_v1`.`program`.`logframe_row` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_ngo_v1`.`program`.`logframe_row` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_ngo_v1`.`program`.`logframe_row` ALTER COLUMN `reporting_frequency` SET TAGS ('dbx_business_glossary_term' = 'Reporting Frequency');
ALTER TABLE `vibe_ngo_v1`.`program`.`logframe_row` ALTER COLUMN `reporting_frequency` SET TAGS ('dbx_value_regex' = 'monthly|quarterly|semi-annually|annually|ad-hoc');
ALTER TABLE `vibe_ngo_v1`.`program`.`logframe_row` ALTER COLUMN `responsible_person` SET TAGS ('dbx_business_glossary_term' = 'Responsible Person');
ALTER TABLE `vibe_ngo_v1`.`program`.`logframe_row` ALTER COLUMN `responsible_unit` SET TAGS ('dbx_business_glossary_term' = 'Responsible Unit');
ALTER TABLE `vibe_ngo_v1`.`program`.`logframe_row` ALTER COLUMN `result_code` SET TAGS ('dbx_business_glossary_term' = 'Result Code');
ALTER TABLE `vibe_ngo_v1`.`program`.`logframe_row` ALTER COLUMN `result_level` SET TAGS ('dbx_business_glossary_term' = 'Result Level');
ALTER TABLE `vibe_ngo_v1`.`program`.`logframe_row` ALTER COLUMN `result_level` SET TAGS ('dbx_value_regex' = 'goal|outcome|output|activity|input');
ALTER TABLE `vibe_ngo_v1`.`program`.`logframe_row` ALTER COLUMN `result_statement` SET TAGS ('dbx_business_glossary_term' = 'Result Statement');
ALTER TABLE `vibe_ngo_v1`.`program`.`logframe_row` ALTER COLUMN `risks` SET TAGS ('dbx_business_glossary_term' = 'Risks');
ALTER TABLE `vibe_ngo_v1`.`program`.`logframe_row` ALTER COLUMN `sdg_alignment` SET TAGS ('dbx_business_glossary_term' = 'Sustainable Development Goal (SDG) Alignment');
ALTER TABLE `vibe_ngo_v1`.`program`.`logframe_row` ALTER COLUMN `sector_classification` SET TAGS ('dbx_business_glossary_term' = 'Sector Classification');
ALTER TABLE `vibe_ngo_v1`.`program`.`logframe_row` ALTER COLUMN `sequence_number` SET TAGS ('dbx_business_glossary_term' = 'Sequence Number');
ALTER TABLE `vibe_ngo_v1`.`program`.`logframe_row` ALTER COLUMN `target_date` SET TAGS ('dbx_business_glossary_term' = 'Target Date');
ALTER TABLE `vibe_ngo_v1`.`program`.`logframe_row` ALTER COLUMN `target_value` SET TAGS ('dbx_business_glossary_term' = 'Target Value');
ALTER TABLE `vibe_ngo_v1`.`program`.`logframe_row` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `vibe_ngo_v1`.`program`.`component` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_ngo_v1`.`program`.`component` SET TAGS ('dbx_subdomain' = 'program_design');
ALTER TABLE `vibe_ngo_v1`.`program`.`component` ALTER COLUMN `component_id` SET TAGS ('dbx_business_glossary_term' = 'Component ID');
ALTER TABLE `vibe_ngo_v1`.`program`.`component` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Partnership Agreement Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`program`.`component` ALTER COLUMN `award_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Audit Finding Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`program`.`component` ALTER COLUMN `country_office_id` SET TAGS ('dbx_business_glossary_term' = 'Country Office Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`program`.`component` ALTER COLUMN `intervention_id` SET TAGS ('dbx_business_glossary_term' = 'Program ID');
ALTER TABLE `vibe_ngo_v1`.`program`.`component` ALTER COLUMN `parent_component_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Component ID');
ALTER TABLE `vibe_ngo_v1`.`program`.`component` ALTER COLUMN `project_site_id` SET TAGS ('dbx_business_glossary_term' = 'Project Site Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`program`.`component` ALTER COLUMN `amendment_count` SET TAGS ('dbx_business_glossary_term' = 'Amendment Count');
ALTER TABLE `vibe_ngo_v1`.`program`.`component` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_ngo_v1`.`program`.`component` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `vibe_ngo_v1`.`program`.`component` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'draft|pending_review|approved|revision_required|rejected');
ALTER TABLE `vibe_ngo_v1`.`program`.`component` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `vibe_ngo_v1`.`program`.`component` ALTER COLUMN `budget_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Budget Currency Code');
ALTER TABLE `vibe_ngo_v1`.`program`.`component` ALTER COLUMN `budget_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_ngo_v1`.`program`.`component` ALTER COLUMN `budget_envelope_amount` SET TAGS ('dbx_business_glossary_term' = 'Budget Envelope Amount');
ALTER TABLE `vibe_ngo_v1`.`program`.`component` ALTER COLUMN `component_code` SET TAGS ('dbx_business_glossary_term' = 'Component Code');
ALTER TABLE `vibe_ngo_v1`.`program`.`component` ALTER COLUMN `component_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{3,20}$');
ALTER TABLE `vibe_ngo_v1`.`program`.`component` ALTER COLUMN `component_status` SET TAGS ('dbx_business_glossary_term' = 'Component Status');
ALTER TABLE `vibe_ngo_v1`.`program`.`component` ALTER COLUMN `component_status` SET TAGS ('dbx_value_regex' = 'planned|active|on_hold|completed|closed|cancelled');
ALTER TABLE `vibe_ngo_v1`.`program`.`component` ALTER COLUMN `component_type` SET TAGS ('dbx_business_glossary_term' = 'Component Type');
ALTER TABLE `vibe_ngo_v1`.`program`.`component` ALTER COLUMN `component_type` SET TAGS ('dbx_value_regex' = 'component|sub-component|workstream|activity_cluster|pilot|scale_up');
ALTER TABLE `vibe_ngo_v1`.`program`.`component` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_ngo_v1`.`program`.`component` ALTER COLUMN `cross_cutting_themes` SET TAGS ('dbx_business_glossary_term' = 'Cross-Cutting Themes');
ALTER TABLE `vibe_ngo_v1`.`program`.`component` ALTER COLUMN `dac_sector_code` SET TAGS ('dbx_business_glossary_term' = 'Development Assistance Committee (DAC) Sector Code');
ALTER TABLE `vibe_ngo_v1`.`program`.`component` ALTER COLUMN `dac_sector_code` SET TAGS ('dbx_value_regex' = '^[0-9]{5}$');
ALTER TABLE `vibe_ngo_v1`.`program`.`component` ALTER COLUMN `component_description` SET TAGS ('dbx_business_glossary_term' = 'Component Description');
ALTER TABLE `vibe_ngo_v1`.`program`.`component` ALTER COLUMN `donor_visibility_flag` SET TAGS ('dbx_business_glossary_term' = 'Donor Visibility Flag');
ALTER TABLE `vibe_ngo_v1`.`program`.`component` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'Component End Date');
ALTER TABLE `vibe_ngo_v1`.`program`.`component` ALTER COLUMN `funding_source` SET TAGS ('dbx_business_glossary_term' = 'Funding Source');
ALTER TABLE `vibe_ngo_v1`.`program`.`component` ALTER COLUMN `geographic_focus` SET TAGS ('dbx_business_glossary_term' = 'Geographic Focus');
ALTER TABLE `vibe_ngo_v1`.`program`.`component` ALTER COLUMN `grant_requirement_flag` SET TAGS ('dbx_business_glossary_term' = 'Grant Requirement Flag');
ALTER TABLE `vibe_ngo_v1`.`program`.`component` ALTER COLUMN `hierarchy_level` SET TAGS ('dbx_business_glossary_term' = 'Hierarchy Level');
ALTER TABLE `vibe_ngo_v1`.`program`.`component` ALTER COLUMN `implementation_modality` SET TAGS ('dbx_business_glossary_term' = 'Implementation Modality');
ALTER TABLE `vibe_ngo_v1`.`program`.`component` ALTER COLUMN `implementation_modality` SET TAGS ('dbx_value_regex' = 'direct|partner|consortium|sub_award|community_based');
ALTER TABLE `vibe_ngo_v1`.`program`.`component` ALTER COLUMN `integration_flag` SET TAGS ('dbx_business_glossary_term' = 'Integration Flag');
ALTER TABLE `vibe_ngo_v1`.`program`.`component` ALTER COLUMN `last_amendment_date` SET TAGS ('dbx_business_glossary_term' = 'Last Amendment Date');
ALTER TABLE `vibe_ngo_v1`.`program`.`component` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `vibe_ngo_v1`.`program`.`component` ALTER COLUMN `mitigation_strategy` SET TAGS ('dbx_business_glossary_term' = 'Mitigation Strategy');
ALTER TABLE `vibe_ngo_v1`.`program`.`component` ALTER COLUMN `monitoring_frequency` SET TAGS ('dbx_business_glossary_term' = 'Monitoring Frequency');
ALTER TABLE `vibe_ngo_v1`.`program`.`component` ALTER COLUMN `component_name` SET TAGS ('dbx_business_glossary_term' = 'Component Name');
ALTER TABLE `vibe_ngo_v1`.`program`.`component` ALTER COLUMN `component_name` SET TAGS ('dbx_pii_personal' = 'true');
ALTER TABLE `vibe_ngo_v1`.`program`.`component` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Component Notes');
ALTER TABLE `vibe_ngo_v1`.`program`.`component` ALTER COLUMN `reporting_frequency` SET TAGS ('dbx_business_glossary_term' = 'Reporting Frequency');
ALTER TABLE `vibe_ngo_v1`.`program`.`component` ALTER COLUMN `reporting_frequency` SET TAGS ('dbx_value_regex' = 'monthly|quarterly|semi_annual|annual|final_only');
ALTER TABLE `vibe_ngo_v1`.`program`.`component` ALTER COLUMN `responsible_manager` SET TAGS ('dbx_business_glossary_term' = 'Responsible Manager');
ALTER TABLE `vibe_ngo_v1`.`program`.`component` ALTER COLUMN `responsible_manager` SET TAGS ('dbx_pii_demographic' = 'true');
ALTER TABLE `vibe_ngo_v1`.`program`.`component` ALTER COLUMN `responsible_team` SET TAGS ('dbx_business_glossary_term' = 'Responsible Team');
ALTER TABLE `vibe_ngo_v1`.`program`.`component` ALTER COLUMN `risk_level` SET TAGS ('dbx_business_glossary_term' = 'Risk Level');
ALTER TABLE `vibe_ngo_v1`.`program`.`component` ALTER COLUMN `risk_level` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `vibe_ngo_v1`.`program`.`component` ALTER COLUMN `sdg_alignment` SET TAGS ('dbx_business_glossary_term' = 'Sustainable Development Goal (SDG) Alignment');
ALTER TABLE `vibe_ngo_v1`.`program`.`component` ALTER COLUMN `sector` SET TAGS ('dbx_business_glossary_term' = 'Sector');
ALTER TABLE `vibe_ngo_v1`.`program`.`component` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Component Start Date');
ALTER TABLE `vibe_ngo_v1`.`program`.`component` ALTER COLUMN `sub_sector` SET TAGS ('dbx_business_glossary_term' = 'Sub-Sector');
ALTER TABLE `vibe_ngo_v1`.`program`.`component` ALTER COLUMN `target_beneficiary_count` SET TAGS ('dbx_business_glossary_term' = 'Target Beneficiary Count');
ALTER TABLE `vibe_ngo_v1`.`program`.`component` ALTER COLUMN `theory_of_change_reference` SET TAGS ('dbx_business_glossary_term' = 'Theory of Change (ToC) Reference');
ALTER TABLE `vibe_ngo_v1`.`program`.`target_population` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_ngo_v1`.`program`.`target_population` SET TAGS ('dbx_subdomain' = 'program_design');
ALTER TABLE `vibe_ngo_v1`.`program`.`target_population` ALTER COLUMN `target_population_id` SET TAGS ('dbx_business_glossary_term' = 'Target Population Identifier (ID)');
ALTER TABLE `vibe_ngo_v1`.`program`.`target_population` ALTER COLUMN `component_id` SET TAGS ('dbx_business_glossary_term' = 'Component Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`program`.`target_population` ALTER COLUMN `country_office_id` SET TAGS ('dbx_business_glossary_term' = 'Chs Self Assessment Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`program`.`target_population` ALTER COLUMN `intervention_id` SET TAGS ('dbx_business_glossary_term' = 'Program Identifier (ID)');
ALTER TABLE `vibe_ngo_v1`.`program`.`target_population` ALTER COLUMN `project_site_id` SET TAGS ('dbx_business_glossary_term' = 'Project Site Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`program`.`target_population` ALTER COLUMN `age_range_max` SET TAGS ('dbx_business_glossary_term' = 'Maximum Age Range');
ALTER TABLE `vibe_ngo_v1`.`program`.`target_population` ALTER COLUMN `age_range_max` SET TAGS ('dbx_pii_demographic' = 'true');
ALTER TABLE `vibe_ngo_v1`.`program`.`target_population` ALTER COLUMN `age_range_min` SET TAGS ('dbx_business_glossary_term' = 'Minimum Age Range');
ALTER TABLE `vibe_ngo_v1`.`program`.`target_population` ALTER COLUMN `age_range_min` SET TAGS ('dbx_pii_demographic' = 'true');
ALTER TABLE `vibe_ngo_v1`.`program`.`target_population` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_ngo_v1`.`program`.`target_population` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `vibe_ngo_v1`.`program`.`target_population` ALTER COLUMN `baseline_date` SET TAGS ('dbx_business_glossary_term' = 'Baseline Date');
ALTER TABLE `vibe_ngo_v1`.`program`.`target_population` ALTER COLUMN `target_population_code` SET TAGS ('dbx_business_glossary_term' = 'Target Population Code');
ALTER TABLE `vibe_ngo_v1`.`program`.`target_population` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `vibe_ngo_v1`.`program`.`target_population` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_ngo_v1`.`program`.`target_population` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_ngo_v1`.`program`.`target_population` ALTER COLUMN `dac_sector_code` SET TAGS ('dbx_business_glossary_term' = 'Development Assistance Committee (DAC) Sector Code');
ALTER TABLE `vibe_ngo_v1`.`program`.`target_population` ALTER COLUMN `data_collection_method` SET TAGS ('dbx_business_glossary_term' = 'Data Collection Method');
ALTER TABLE `vibe_ngo_v1`.`program`.`target_population` ALTER COLUMN `data_source` SET TAGS ('dbx_business_glossary_term' = 'Data Source');
ALTER TABLE `vibe_ngo_v1`.`program`.`target_population` ALTER COLUMN `target_population_description` SET TAGS ('dbx_business_glossary_term' = 'Target Population Description');
ALTER TABLE `vibe_ngo_v1`.`program`.`target_population` ALTER COLUMN `displacement_status` SET TAGS ('dbx_business_glossary_term' = 'Displacement Status');
ALTER TABLE `vibe_ngo_v1`.`program`.`target_population` ALTER COLUMN `displacement_status` SET TAGS ('dbx_value_regex' = 'idp|refugee|returnee|host_community|mixed|not_applicable');
ALTER TABLE `vibe_ngo_v1`.`program`.`target_population` ALTER COLUMN `do_no_harm_considerations` SET TAGS ('dbx_business_glossary_term' = 'Do No Harm Considerations');
ALTER TABLE `vibe_ngo_v1`.`program`.`target_population` ALTER COLUMN `donor_visibility_flag` SET TAGS ('dbx_business_glossary_term' = 'Donor Visibility Flag');
ALTER TABLE `vibe_ngo_v1`.`program`.`target_population` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_ngo_v1`.`program`.`target_population` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_ngo_v1`.`program`.`target_population` ALTER COLUMN `estimated_population_size` SET TAGS ('dbx_business_glossary_term' = 'Estimated Population Size');
ALTER TABLE `vibe_ngo_v1`.`program`.`target_population` ALTER COLUMN `exclusion_criteria` SET TAGS ('dbx_business_glossary_term' = 'Exclusion Criteria');
ALTER TABLE `vibe_ngo_v1`.`program`.`target_population` ALTER COLUMN `gender_integration_approach` SET TAGS ('dbx_business_glossary_term' = 'Gender Integration Approach');
ALTER TABLE `vibe_ngo_v1`.`program`.`target_population` ALTER COLUMN `gender_integration_approach` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`program`.`target_population` ALTER COLUMN `gender_integration_approach` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_ngo_v1`.`program`.`target_population` ALTER COLUMN `gender_integration_approach` SET TAGS ('dbx_pii_demographic' = 'true');
ALTER TABLE `vibe_ngo_v1`.`program`.`target_population` ALTER COLUMN `geographic_scope` SET TAGS ('dbx_business_glossary_term' = 'Geographic Scope');
ALTER TABLE `vibe_ngo_v1`.`program`.`target_population` ALTER COLUMN `host_community_population_count` SET TAGS ('dbx_business_glossary_term' = 'Host Community Population Count');
ALTER TABLE `vibe_ngo_v1`.`program`.`target_population` ALTER COLUMN `idp_population_count` SET TAGS ('dbx_business_glossary_term' = 'Internally Displaced Person (IDP) Population Count');
ALTER TABLE `vibe_ngo_v1`.`program`.`target_population` ALTER COLUMN `inclusion_criteria` SET TAGS ('dbx_business_glossary_term' = 'Inclusion Criteria');
ALTER TABLE `vibe_ngo_v1`.`program`.`target_population` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_ngo_v1`.`program`.`target_population` ALTER COLUMN `target_population_name` SET TAGS ('dbx_business_glossary_term' = 'Target Population Name');
ALTER TABLE `vibe_ngo_v1`.`program`.`target_population` ALTER COLUMN `target_population_name` SET TAGS ('dbx_pii_personal' = 'true');
ALTER TABLE `vibe_ngo_v1`.`program`.`target_population` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_ngo_v1`.`program`.`target_population` ALTER COLUMN `planned_reach` SET TAGS ('dbx_business_glossary_term' = 'Planned Reach');
ALTER TABLE `vibe_ngo_v1`.`program`.`target_population` ALTER COLUMN `protection_mainstreaming_flag` SET TAGS ('dbx_business_glossary_term' = 'Protection Mainstreaming Flag');
ALTER TABLE `vibe_ngo_v1`.`program`.`target_population` ALTER COLUMN `refugee_population_count` SET TAGS ('dbx_business_glossary_term' = 'Refugee Population Count');
ALTER TABLE `vibe_ngo_v1`.`program`.`target_population` ALTER COLUMN `revision_number` SET TAGS ('dbx_business_glossary_term' = 'Revision Number');
ALTER TABLE `vibe_ngo_v1`.`program`.`target_population` ALTER COLUMN `revision_reason` SET TAGS ('dbx_business_glossary_term' = 'Revision Reason');
ALTER TABLE `vibe_ngo_v1`.`program`.`target_population` ALTER COLUMN `sdg_alignment` SET TAGS ('dbx_business_glossary_term' = 'Sustainable Development Goal (SDG) Alignment');
ALTER TABLE `vibe_ngo_v1`.`program`.`target_population` ALTER COLUMN `sector_classification` SET TAGS ('dbx_business_glossary_term' = 'Sector Classification');
ALTER TABLE `vibe_ngo_v1`.`program`.`target_population` ALTER COLUMN `sex_disaggregation` SET TAGS ('dbx_business_glossary_term' = 'Sex Disaggregation');
ALTER TABLE `vibe_ngo_v1`.`program`.`target_population` ALTER COLUMN `sex_disaggregation` SET TAGS ('dbx_value_regex' = 'all|male|female|other|mixed');
ALTER TABLE `vibe_ngo_v1`.`program`.`target_population` ALTER COLUMN `sex_disaggregation` SET TAGS ('dbx_pii_demographic' = 'true');
ALTER TABLE `vibe_ngo_v1`.`program`.`target_population` ALTER COLUMN `target_population_status` SET TAGS ('dbx_business_glossary_term' = 'Target Population Status');
ALTER TABLE `vibe_ngo_v1`.`program`.`target_population` ALTER COLUMN `target_population_status` SET TAGS ('dbx_value_regex' = 'draft|approved|active|suspended|closed');
ALTER TABLE `vibe_ngo_v1`.`program`.`target_population` ALTER COLUMN `targeting_methodology` SET TAGS ('dbx_business_glossary_term' = 'Targeting Methodology');
ALTER TABLE `vibe_ngo_v1`.`program`.`target_population` ALTER COLUMN `vulnerability_category` SET TAGS ('dbx_business_glossary_term' = 'Vulnerability Category');
ALTER TABLE `vibe_ngo_v1`.`program`.`risk_register` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_ngo_v1`.`program`.`risk_register` SET TAGS ('dbx_subdomain' = 'implementation_planning');
ALTER TABLE `vibe_ngo_v1`.`program`.`risk_register` ALTER COLUMN `risk_register_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Register ID');
ALTER TABLE `vibe_ngo_v1`.`program`.`risk_register` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Partnership Agreement Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`program`.`risk_register` ALTER COLUMN `amendment_id` SET TAGS ('dbx_business_glossary_term' = 'Grant Amendment Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`program`.`risk_register` ALTER COLUMN `award_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Incident Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`program`.`risk_register` ALTER COLUMN `component_id` SET TAGS ('dbx_business_glossary_term' = 'Component Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`program`.`risk_register` ALTER COLUMN `country_office_id` SET TAGS ('dbx_business_glossary_term' = 'Country Office Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`program`.`risk_register` ALTER COLUMN `emergency_id` SET TAGS ('dbx_business_glossary_term' = 'Emergency Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`program`.`risk_register` ALTER COLUMN `implementation_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Implementation Plan Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`program`.`risk_register` ALTER COLUMN `intervention_id` SET TAGS ('dbx_business_glossary_term' = 'Program ID');
ALTER TABLE `vibe_ngo_v1`.`program`.`risk_register` ALTER COLUMN `partner_org_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Org Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`program`.`risk_register` ALTER COLUMN `project_site_id` SET TAGS ('dbx_business_glossary_term' = 'Project Site Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`program`.`risk_register` ALTER COLUMN `affected_sdg` SET TAGS ('dbx_business_glossary_term' = 'Affected Sustainable Development Goal (SDG)');
ALTER TABLE `vibe_ngo_v1`.`program`.`risk_register` ALTER COLUMN `affected_sector` SET TAGS ('dbx_business_glossary_term' = 'Affected Sector');
ALTER TABLE `vibe_ngo_v1`.`program`.`risk_register` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_ngo_v1`.`program`.`risk_register` ALTER COLUMN `closure_date` SET TAGS ('dbx_business_glossary_term' = 'Closure Date');
ALTER TABLE `vibe_ngo_v1`.`program`.`risk_register` ALTER COLUMN `contingency_plan` SET TAGS ('dbx_business_glossary_term' = 'Contingency Plan');
ALTER TABLE `vibe_ngo_v1`.`program`.`risk_register` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_ngo_v1`.`program`.`risk_register` ALTER COLUMN `donor_visibility_flag` SET TAGS ('dbx_business_glossary_term' = 'Donor Visibility Flag');
ALTER TABLE `vibe_ngo_v1`.`program`.`risk_register` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_ngo_v1`.`program`.`risk_register` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_ngo_v1`.`program`.`risk_register` ALTER COLUMN `escalation_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Escalation Required Flag');
ALTER TABLE `vibe_ngo_v1`.`program`.`risk_register` ALTER COLUMN `geographic_scope` SET TAGS ('dbx_business_glossary_term' = 'Geographic Scope');
ALTER TABLE `vibe_ngo_v1`.`program`.`risk_register` ALTER COLUMN `identification_date` SET TAGS ('dbx_business_glossary_term' = 'Identification Date');
ALTER TABLE `vibe_ngo_v1`.`program`.`risk_register` ALTER COLUMN `impact_rating` SET TAGS ('dbx_business_glossary_term' = 'Impact Rating');
ALTER TABLE `vibe_ngo_v1`.`program`.`risk_register` ALTER COLUMN `impact_rating` SET TAGS ('dbx_value_regex' = 'very low|low|medium|high|very high');
ALTER TABLE `vibe_ngo_v1`.`program`.`risk_register` ALTER COLUMN `impact_score` SET TAGS ('dbx_business_glossary_term' = 'Impact Score');
ALTER TABLE `vibe_ngo_v1`.`program`.`risk_register` ALTER COLUMN `inherent_risk_score` SET TAGS ('dbx_business_glossary_term' = 'Inherent Risk Score');
ALTER TABLE `vibe_ngo_v1`.`program`.`risk_register` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_ngo_v1`.`program`.`risk_register` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `vibe_ngo_v1`.`program`.`risk_register` ALTER COLUMN `likelihood_rating` SET TAGS ('dbx_business_glossary_term' = 'Likelihood Rating');
ALTER TABLE `vibe_ngo_v1`.`program`.`risk_register` ALTER COLUMN `likelihood_rating` SET TAGS ('dbx_value_regex' = 'very low|low|medium|high|very high');
ALTER TABLE `vibe_ngo_v1`.`program`.`risk_register` ALTER COLUMN `likelihood_score` SET TAGS ('dbx_business_glossary_term' = 'Likelihood Score');
ALTER TABLE `vibe_ngo_v1`.`program`.`risk_register` ALTER COLUMN `mitigation_strategy` SET TAGS ('dbx_business_glossary_term' = 'Mitigation Strategy');
ALTER TABLE `vibe_ngo_v1`.`program`.`risk_register` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `vibe_ngo_v1`.`program`.`risk_register` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_ngo_v1`.`program`.`risk_register` ALTER COLUMN `residual_risk_score` SET TAGS ('dbx_business_glossary_term' = 'Residual Risk Score');
ALTER TABLE `vibe_ngo_v1`.`program`.`risk_register` ALTER COLUMN `revision_reason` SET TAGS ('dbx_business_glossary_term' = 'Revision Reason');
ALTER TABLE `vibe_ngo_v1`.`program`.`risk_register` ALTER COLUMN `risk_category` SET TAGS ('dbx_business_glossary_term' = 'Risk Category');
ALTER TABLE `vibe_ngo_v1`.`program`.`risk_register` ALTER COLUMN `risk_category` SET TAGS ('dbx_value_regex' = 'operational|contextual|institutional|fiduciary|programmatic|reputational');
ALTER TABLE `vibe_ngo_v1`.`program`.`risk_register` ALTER COLUMN `risk_code` SET TAGS ('dbx_business_glossary_term' = 'Risk Code');
ALTER TABLE `vibe_ngo_v1`.`program`.`risk_register` ALTER COLUMN `risk_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,4}-[0-9]{3,5}$');
ALTER TABLE `vibe_ngo_v1`.`program`.`risk_register` ALTER COLUMN `risk_description` SET TAGS ('dbx_business_glossary_term' = 'Risk Description');
ALTER TABLE `vibe_ngo_v1`.`program`.`risk_register` ALTER COLUMN `risk_level` SET TAGS ('dbx_business_glossary_term' = 'Risk Level');
ALTER TABLE `vibe_ngo_v1`.`program`.`risk_register` ALTER COLUMN `risk_level` SET TAGS ('dbx_value_regex' = 'low|moderate|high|critical');
ALTER TABLE `vibe_ngo_v1`.`program`.`risk_register` ALTER COLUMN `risk_owner` SET TAGS ('dbx_business_glossary_term' = 'Risk Owner');
ALTER TABLE `vibe_ngo_v1`.`program`.`risk_register` ALTER COLUMN `risk_owner_email` SET TAGS ('dbx_business_glossary_term' = 'Risk Owner Email');
ALTER TABLE `vibe_ngo_v1`.`program`.`risk_register` ALTER COLUMN `risk_owner_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_ngo_v1`.`program`.`risk_register` ALTER COLUMN `risk_owner_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`program`.`risk_register` ALTER COLUMN `risk_owner_email` SET TAGS ('dbx_pii_contact' = 'true');
ALTER TABLE `vibe_ngo_v1`.`program`.`risk_register` ALTER COLUMN `risk_status` SET TAGS ('dbx_business_glossary_term' = 'Risk Status');
ALTER TABLE `vibe_ngo_v1`.`program`.`risk_register` ALTER COLUMN `risk_status` SET TAGS ('dbx_value_regex' = 'open|monitoring|mitigated|closed|materialized');
ALTER TABLE `vibe_ngo_v1`.`program`.`risk_register` ALTER COLUMN `risk_subcategory` SET TAGS ('dbx_business_glossary_term' = 'Risk Subcategory');
ALTER TABLE `vibe_ngo_v1`.`program`.`risk_register` ALTER COLUMN `risk_title` SET TAGS ('dbx_business_glossary_term' = 'Risk Title');
ALTER TABLE `vibe_ngo_v1`.`program`.`risk_register` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `vibe_ngo_v1`.`program`.`implementation_plan` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_ngo_v1`.`program`.`implementation_plan` SET TAGS ('dbx_subdomain' = 'implementation_planning');
ALTER TABLE `vibe_ngo_v1`.`program`.`implementation_plan` ALTER COLUMN `implementation_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Implementation Plan ID');
ALTER TABLE `vibe_ngo_v1`.`program`.`implementation_plan` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Partnership Agreement Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`program`.`implementation_plan` ALTER COLUMN `amendment_id` SET TAGS ('dbx_business_glossary_term' = 'Grant Amendment Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`program`.`implementation_plan` ALTER COLUMN `award_id` SET TAGS ('dbx_business_glossary_term' = 'Donor Compliance Req Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`program`.`implementation_plan` ALTER COLUMN `budget_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Budget Plan Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`program`.`implementation_plan` ALTER COLUMN `component_id` SET TAGS ('dbx_business_glossary_term' = 'Component Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`program`.`implementation_plan` ALTER COLUMN `country_office_id` SET TAGS ('dbx_business_glossary_term' = 'Country Office Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`program`.`implementation_plan` ALTER COLUMN `emergency_id` SET TAGS ('dbx_business_glossary_term' = 'Emergency Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`program`.`implementation_plan` ALTER COLUMN `intervention_id` SET TAGS ('dbx_business_glossary_term' = 'Program ID');
ALTER TABLE `vibe_ngo_v1`.`program`.`implementation_plan` ALTER COLUMN `partner_org_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Org Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`program`.`implementation_plan` ALTER COLUMN `project_site_id` SET TAGS ('dbx_business_glossary_term' = 'Project Site Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`program`.`implementation_plan` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_ngo_v1`.`program`.`implementation_plan` ALTER COLUMN `assumptions` SET TAGS ('dbx_business_glossary_term' = 'Implementation Assumptions');
ALTER TABLE `vibe_ngo_v1`.`program`.`implementation_plan` ALTER COLUMN `budget_allocated_amount` SET TAGS ('dbx_business_glossary_term' = 'Budget Allocated Amount');
ALTER TABLE `vibe_ngo_v1`.`program`.`implementation_plan` ALTER COLUMN `budget_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Budget Currency Code');
ALTER TABLE `vibe_ngo_v1`.`program`.`implementation_plan` ALTER COLUMN `budget_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_ngo_v1`.`program`.`implementation_plan` ALTER COLUMN `implementation_plan_code` SET TAGS ('dbx_business_glossary_term' = 'Implementation Plan Code');
ALTER TABLE `vibe_ngo_v1`.`program`.`implementation_plan` ALTER COLUMN `implementation_plan_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,20}$');
ALTER TABLE `vibe_ngo_v1`.`program`.`implementation_plan` ALTER COLUMN `coordination_mechanism` SET TAGS ('dbx_business_glossary_term' = 'Coordination Mechanism');
ALTER TABLE `vibe_ngo_v1`.`program`.`implementation_plan` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_ngo_v1`.`program`.`implementation_plan` ALTER COLUMN `dac_sector_code` SET TAGS ('dbx_business_glossary_term' = 'Development Assistance Committee (DAC) Sector Code');
ALTER TABLE `vibe_ngo_v1`.`program`.`implementation_plan` ALTER COLUMN `dac_sector_code` SET TAGS ('dbx_value_regex' = '^[0-9]{5}$');
ALTER TABLE `vibe_ngo_v1`.`program`.`implementation_plan` ALTER COLUMN `disaggregation_approach` SET TAGS ('dbx_business_glossary_term' = 'Disaggregation Approach');
ALTER TABLE `vibe_ngo_v1`.`program`.`implementation_plan` ALTER COLUMN `donor_visibility_flag` SET TAGS ('dbx_business_glossary_term' = 'Donor Visibility Flag');
ALTER TABLE `vibe_ngo_v1`.`program`.`implementation_plan` ALTER COLUMN `geographic_scope` SET TAGS ('dbx_business_glossary_term' = 'Geographic Scope');
ALTER TABLE `vibe_ngo_v1`.`program`.`implementation_plan` ALTER COLUMN `grant_requirement_flag` SET TAGS ('dbx_business_glossary_term' = 'Grant Requirement Flag');
ALTER TABLE `vibe_ngo_v1`.`program`.`implementation_plan` ALTER COLUMN `implementation_plan_status` SET TAGS ('dbx_business_glossary_term' = 'Implementation Plan Status');
ALTER TABLE `vibe_ngo_v1`.`program`.`implementation_plan` ALTER COLUMN `implementation_plan_type` SET TAGS ('dbx_business_glossary_term' = 'Implementation Plan Type');
ALTER TABLE `vibe_ngo_v1`.`program`.`implementation_plan` ALTER COLUMN `implementation_plan_type` SET TAGS ('dbx_value_regex' = 'annual|quarterly|project_phase|emergency_response|pilot|scale_up');
ALTER TABLE `vibe_ngo_v1`.`program`.`implementation_plan` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `vibe_ngo_v1`.`program`.`implementation_plan` ALTER COLUMN `last_revision_date` SET TAGS ('dbx_business_glossary_term' = 'Last Revision Date');
ALTER TABLE `vibe_ngo_v1`.`program`.`implementation_plan` ALTER COLUMN `logframe_reference` SET TAGS ('dbx_business_glossary_term' = 'Logical Framework (LogFrame) Reference');
ALTER TABLE `vibe_ngo_v1`.`program`.`implementation_plan` ALTER COLUMN `manager_name` SET TAGS ('dbx_business_glossary_term' = 'Implementation Plan Manager Name');
ALTER TABLE `vibe_ngo_v1`.`program`.`implementation_plan` ALTER COLUMN `manager_name` SET TAGS ('dbx_pii_demographic' = 'true');
ALTER TABLE `vibe_ngo_v1`.`program`.`implementation_plan` ALTER COLUMN `monitoring_approach` SET TAGS ('dbx_business_glossary_term' = 'Monitoring Approach');
ALTER TABLE `vibe_ngo_v1`.`program`.`implementation_plan` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Implementation Plan Notes');
ALTER TABLE `vibe_ngo_v1`.`program`.`implementation_plan` ALTER COLUMN `planning_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Planning Period End Date');
ALTER TABLE `vibe_ngo_v1`.`program`.`implementation_plan` ALTER COLUMN `planning_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Planning Period Start Date');
ALTER TABLE `vibe_ngo_v1`.`program`.`implementation_plan` ALTER COLUMN `reporting_frequency` SET TAGS ('dbx_business_glossary_term' = 'Reporting Frequency');
ALTER TABLE `vibe_ngo_v1`.`program`.`implementation_plan` ALTER COLUMN `resource_requirements_summary` SET TAGS ('dbx_business_glossary_term' = 'Resource Requirements Summary');
ALTER TABLE `vibe_ngo_v1`.`program`.`implementation_plan` ALTER COLUMN `responsible_unit` SET TAGS ('dbx_business_glossary_term' = 'Responsible Organizational Unit');
ALTER TABLE `vibe_ngo_v1`.`program`.`implementation_plan` ALTER COLUMN `revision_reason` SET TAGS ('dbx_business_glossary_term' = 'Revision Reason');
ALTER TABLE `vibe_ngo_v1`.`program`.`implementation_plan` ALTER COLUMN `risk_level` SET TAGS ('dbx_business_glossary_term' = 'Implementation Risk Level');
ALTER TABLE `vibe_ngo_v1`.`program`.`implementation_plan` ALTER COLUMN `risk_level` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `vibe_ngo_v1`.`program`.`implementation_plan` ALTER COLUMN `risk_mitigation_summary` SET TAGS ('dbx_business_glossary_term' = 'Risk Mitigation Summary');
ALTER TABLE `vibe_ngo_v1`.`program`.`implementation_plan` ALTER COLUMN `sector_classification` SET TAGS ('dbx_business_glossary_term' = 'Sector Classification');
ALTER TABLE `vibe_ngo_v1`.`program`.`implementation_plan` ALTER COLUMN `target_beneficiary_count` SET TAGS ('dbx_business_glossary_term' = 'Target Beneficiary Count');
ALTER TABLE `vibe_ngo_v1`.`program`.`implementation_plan` ALTER COLUMN `target_beneficiary_type` SET TAGS ('dbx_business_glossary_term' = 'Target Beneficiary Type');
ALTER TABLE `vibe_ngo_v1`.`program`.`implementation_plan` ALTER COLUMN `target_beneficiary_type` SET TAGS ('dbx_value_regex' = 'individuals|households|communities|institutions');
ALTER TABLE `vibe_ngo_v1`.`program`.`implementation_plan` ALTER COLUMN `title` SET TAGS ('dbx_business_glossary_term' = 'Implementation Plan Title');
ALTER TABLE `vibe_ngo_v1`.`program`.`implementation_plan` ALTER COLUMN `toc_reference` SET TAGS ('dbx_business_glossary_term' = 'Theory of Change (ToC) Reference');
ALTER TABLE `vibe_ngo_v1`.`program`.`implementation_plan` ALTER COLUMN `total_planned_activities` SET TAGS ('dbx_business_glossary_term' = 'Total Planned Activities Count');
ALTER TABLE `vibe_ngo_v1`.`program`.`implementation_plan` ALTER COLUMN `total_planned_milestones` SET TAGS ('dbx_business_glossary_term' = 'Total Planned Milestones Count');
ALTER TABLE `vibe_ngo_v1`.`program`.`implementation_plan` ALTER COLUMN `version` SET TAGS ('dbx_business_glossary_term' = 'Plan Version Number');
ALTER TABLE `vibe_ngo_v1`.`program`.`implementation_plan` ALTER COLUMN `version` SET TAGS ('dbx_value_regex' = '^[0-9]+.[0-9]+$');
ALTER TABLE `vibe_ngo_v1`.`program`.`budget_plan` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_ngo_v1`.`program`.`budget_plan` SET TAGS ('dbx_subdomain' = 'implementation_planning');
ALTER TABLE `vibe_ngo_v1`.`program`.`budget_plan` ALTER COLUMN `budget_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Budget Plan ID');
ALTER TABLE `vibe_ngo_v1`.`program`.`budget_plan` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Partnership Agreement Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`program`.`budget_plan` ALTER COLUMN `amendment_id` SET TAGS ('dbx_business_glossary_term' = 'Grant Amendment Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`program`.`budget_plan` ALTER COLUMN `award_id` SET TAGS ('dbx_business_glossary_term' = 'Grant ID');
ALTER TABLE `vibe_ngo_v1`.`program`.`budget_plan` ALTER COLUMN `component_id` SET TAGS ('dbx_business_glossary_term' = 'Component Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`program`.`budget_plan` ALTER COLUMN `country_office_id` SET TAGS ('dbx_business_glossary_term' = 'Country Office Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`program`.`budget_plan` ALTER COLUMN `fund_id` SET TAGS ('dbx_business_glossary_term' = 'Fund Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`program`.`budget_plan` ALTER COLUMN `intervention_id` SET TAGS ('dbx_business_glossary_term' = 'Program ID');
ALTER TABLE `vibe_ngo_v1`.`program`.`budget_plan` ALTER COLUMN `project_site_id` SET TAGS ('dbx_business_glossary_term' = 'Budget Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`program`.`budget_plan` ALTER COLUMN `amendment_date` SET TAGS ('dbx_business_glossary_term' = 'Amendment Date');
ALTER TABLE `vibe_ngo_v1`.`program`.`budget_plan` ALTER COLUMN `amendment_reason` SET TAGS ('dbx_business_glossary_term' = 'Amendment Reason');
ALTER TABLE `vibe_ngo_v1`.`program`.`budget_plan` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_ngo_v1`.`program`.`budget_plan` ALTER COLUMN `budget_assumptions` SET TAGS ('dbx_business_glossary_term' = 'Budget Assumptions');
ALTER TABLE `vibe_ngo_v1`.`program`.`budget_plan` ALTER COLUMN `budget_narrative` SET TAGS ('dbx_business_glossary_term' = 'Budget Narrative');
ALTER TABLE `vibe_ngo_v1`.`program`.`budget_plan` ALTER COLUMN `budget_owner` SET TAGS ('dbx_business_glossary_term' = 'Budget Owner');
ALTER TABLE `vibe_ngo_v1`.`program`.`budget_plan` ALTER COLUMN `budget_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Budget Period End Date');
ALTER TABLE `vibe_ngo_v1`.`program`.`budget_plan` ALTER COLUMN `budget_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Budget Period Start Date');
ALTER TABLE `vibe_ngo_v1`.`program`.`budget_plan` ALTER COLUMN `budget_status` SET TAGS ('dbx_business_glossary_term' = 'Budget Status');
ALTER TABLE `vibe_ngo_v1`.`program`.`budget_plan` ALTER COLUMN `budget_type` SET TAGS ('dbx_business_glossary_term' = 'Budget Type');
ALTER TABLE `vibe_ngo_v1`.`program`.`budget_plan` ALTER COLUMN `budget_type` SET TAGS ('dbx_value_regex' = 'original|revised|supplemental|no_cost_extension|closeout');
ALTER TABLE `vibe_ngo_v1`.`program`.`budget_plan` ALTER COLUMN `budget_version_number` SET TAGS ('dbx_business_glossary_term' = 'Budget Version Number');
ALTER TABLE `vibe_ngo_v1`.`program`.`budget_plan` ALTER COLUMN `compliance_notes` SET TAGS ('dbx_business_glossary_term' = 'Compliance Notes');
ALTER TABLE `vibe_ngo_v1`.`program`.`budget_plan` ALTER COLUMN `contractual_costs` SET TAGS ('dbx_business_glossary_term' = 'Contractual Costs');
ALTER TABLE `vibe_ngo_v1`.`program`.`budget_plan` ALTER COLUMN `cost_share_amount` SET TAGS ('dbx_business_glossary_term' = 'Cost Share Amount');
ALTER TABLE `vibe_ngo_v1`.`program`.`budget_plan` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_ngo_v1`.`program`.`budget_plan` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_ngo_v1`.`program`.`budget_plan` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_ngo_v1`.`program`.`budget_plan` ALTER COLUMN `dac_sector_code` SET TAGS ('dbx_business_glossary_term' = 'Development Assistance Committee (DAC) Sector Code');
ALTER TABLE `vibe_ngo_v1`.`program`.`budget_plan` ALTER COLUMN `donor_budget_code` SET TAGS ('dbx_business_glossary_term' = 'Donor Budget Code');
ALTER TABLE `vibe_ngo_v1`.`program`.`budget_plan` ALTER COLUMN `donor_visibility_flag` SET TAGS ('dbx_business_glossary_term' = 'Donor Visibility Flag');
ALTER TABLE `vibe_ngo_v1`.`program`.`budget_plan` ALTER COLUMN `equipment_costs` SET TAGS ('dbx_business_glossary_term' = 'Equipment Costs');
ALTER TABLE `vibe_ngo_v1`.`program`.`budget_plan` ALTER COLUMN `finance_contact` SET TAGS ('dbx_business_glossary_term' = 'Finance Contact');
ALTER TABLE `vibe_ngo_v1`.`program`.`budget_plan` ALTER COLUMN `fringe_benefits_costs` SET TAGS ('dbx_business_glossary_term' = 'Fringe Benefits Costs');
ALTER TABLE `vibe_ngo_v1`.`program`.`budget_plan` ALTER COLUMN `indirect_cost_rate` SET TAGS ('dbx_business_glossary_term' = 'Indirect Cost Rate (ICR)');
ALTER TABLE `vibe_ngo_v1`.`program`.`budget_plan` ALTER COLUMN `indirect_costs` SET TAGS ('dbx_business_glossary_term' = 'Indirect Costs (F&A)');
ALTER TABLE `vibe_ngo_v1`.`program`.`budget_plan` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_ngo_v1`.`program`.`budget_plan` ALTER COLUMN `budget_plan_name` SET TAGS ('dbx_business_glossary_term' = 'Budget Plan Name');
ALTER TABLE `vibe_ngo_v1`.`program`.`budget_plan` ALTER COLUMN `budget_plan_name` SET TAGS ('dbx_pii_personal' = 'true');
ALTER TABLE `vibe_ngo_v1`.`program`.`budget_plan` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_ngo_v1`.`program`.`budget_plan` ALTER COLUMN `number` SET TAGS ('dbx_business_glossary_term' = 'Budget Plan Number');
ALTER TABLE `vibe_ngo_v1`.`program`.`budget_plan` ALTER COLUMN `personnel_costs` SET TAGS ('dbx_business_glossary_term' = 'Personnel Costs');
ALTER TABLE `vibe_ngo_v1`.`program`.`budget_plan` ALTER COLUMN `sdg_alignment` SET TAGS ('dbx_business_glossary_term' = 'Sustainable Development Goal (SDG) Alignment');
ALTER TABLE `vibe_ngo_v1`.`program`.`budget_plan` ALTER COLUMN `sector_classification` SET TAGS ('dbx_business_glossary_term' = 'Sector Classification');
ALTER TABLE `vibe_ngo_v1`.`program`.`budget_plan` ALTER COLUMN `submitted_date` SET TAGS ('dbx_business_glossary_term' = 'Submitted Date');
ALTER TABLE `vibe_ngo_v1`.`program`.`budget_plan` ALTER COLUMN `supplies_costs` SET TAGS ('dbx_business_glossary_term' = 'Supplies Costs');
ALTER TABLE `vibe_ngo_v1`.`program`.`budget_plan` ALTER COLUMN `total_approved_budget_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Approved Budget Amount');
ALTER TABLE `vibe_ngo_v1`.`program`.`budget_plan` ALTER COLUMN `total_direct_costs` SET TAGS ('dbx_business_glossary_term' = 'Total Direct Costs');
ALTER TABLE `vibe_ngo_v1`.`program`.`budget_plan` ALTER COLUMN `travel_costs` SET TAGS ('dbx_business_glossary_term' = 'Travel Costs');
ALTER TABLE `vibe_ngo_v1`.`program`.`budget_plan_line` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_ngo_v1`.`program`.`budget_plan_line` SET TAGS ('dbx_subdomain' = 'implementation_planning');
ALTER TABLE `vibe_ngo_v1`.`program`.`budget_plan_line` ALTER COLUMN `budget_plan_line_id` SET TAGS ('dbx_business_glossary_term' = 'Budget Plan Line ID');
ALTER TABLE `vibe_ngo_v1`.`program`.`budget_plan_line` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Partnership Agreement Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`program`.`budget_plan_line` ALTER COLUMN `award_id` SET TAGS ('dbx_business_glossary_term' = 'Grant ID');
ALTER TABLE `vibe_ngo_v1`.`program`.`budget_plan_line` ALTER COLUMN `budget_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Budget Plan ID');
ALTER TABLE `vibe_ngo_v1`.`program`.`budget_plan_line` ALTER COLUMN `component_id` SET TAGS ('dbx_business_glossary_term' = 'Component Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`program`.`budget_plan_line` ALTER COLUMN `fund_id` SET TAGS ('dbx_business_glossary_term' = 'Fund Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`program`.`budget_plan_line` ALTER COLUMN `intervention_id` SET TAGS ('dbx_business_glossary_term' = 'Program ID');
ALTER TABLE `vibe_ngo_v1`.`program`.`budget_plan_line` ALTER COLUMN `logframe_row_id` SET TAGS ('dbx_business_glossary_term' = 'Logframe Row Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`program`.`budget_plan_line` ALTER COLUMN `project_site_id` SET TAGS ('dbx_business_glossary_term' = 'Budget Line Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`program`.`budget_plan_line` ALTER COLUMN `activity_code` SET TAGS ('dbx_business_glossary_term' = 'Activity Code');
ALTER TABLE `vibe_ngo_v1`.`program`.`budget_plan_line` ALTER COLUMN `allowable_cost_flag` SET TAGS ('dbx_business_glossary_term' = 'Allowable Cost Flag');
ALTER TABLE `vibe_ngo_v1`.`program`.`budget_plan_line` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_ngo_v1`.`program`.`budget_plan_line` ALTER COLUMN `approval_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Approval Required Flag');
ALTER TABLE `vibe_ngo_v1`.`program`.`budget_plan_line` ALTER COLUMN `budget_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Budget Period End Date');
ALTER TABLE `vibe_ngo_v1`.`program`.`budget_plan_line` ALTER COLUMN `budget_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Budget Period Start Date');
ALTER TABLE `vibe_ngo_v1`.`program`.`budget_plan_line` ALTER COLUMN `budget_plan_line_status` SET TAGS ('dbx_business_glossary_term' = 'Budget Line Status');
ALTER TABLE `vibe_ngo_v1`.`program`.`budget_plan_line` ALTER COLUMN `budget_version_number` SET TAGS ('dbx_business_glossary_term' = 'Budget Version Number');
ALTER TABLE `vibe_ngo_v1`.`program`.`budget_plan_line` ALTER COLUMN `chart_of_accounts_code` SET TAGS ('dbx_business_glossary_term' = 'Chart of Accounts (CoA) Code');
ALTER TABLE `vibe_ngo_v1`.`program`.`budget_plan_line` ALTER COLUMN `cost_category` SET TAGS ('dbx_business_glossary_term' = 'Cost Category');
ALTER TABLE `vibe_ngo_v1`.`program`.`budget_plan_line` ALTER COLUMN `cost_sharing_amount` SET TAGS ('dbx_business_glossary_term' = 'Cost Sharing Amount');
ALTER TABLE `vibe_ngo_v1`.`program`.`budget_plan_line` ALTER COLUMN `cost_sharing_flag` SET TAGS ('dbx_business_glossary_term' = 'Cost Sharing Flag');
ALTER TABLE `vibe_ngo_v1`.`program`.`budget_plan_line` ALTER COLUMN `cost_sharing_source` SET TAGS ('dbx_business_glossary_term' = 'Cost Sharing Source');
ALTER TABLE `vibe_ngo_v1`.`program`.`budget_plan_line` ALTER COLUMN `cost_subcategory` SET TAGS ('dbx_business_glossary_term' = 'Cost Subcategory');
ALTER TABLE `vibe_ngo_v1`.`program`.`budget_plan_line` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_ngo_v1`.`program`.`budget_plan_line` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_ngo_v1`.`program`.`budget_plan_line` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_ngo_v1`.`program`.`budget_plan_line` ALTER COLUMN `dac_sector_code` SET TAGS ('dbx_business_glossary_term' = 'Development Assistance Committee (DAC) Sector Code');
ALTER TABLE `vibe_ngo_v1`.`program`.`budget_plan_line` ALTER COLUMN `budget_plan_line_description` SET TAGS ('dbx_business_glossary_term' = 'Budget Line Description');
ALTER TABLE `vibe_ngo_v1`.`program`.`budget_plan_line` ALTER COLUMN `direct_cost_flag` SET TAGS ('dbx_business_glossary_term' = 'Direct Cost Flag');
ALTER TABLE `vibe_ngo_v1`.`program`.`budget_plan_line` ALTER COLUMN `donor_budget_code` SET TAGS ('dbx_business_glossary_term' = 'Donor Budget Code');
ALTER TABLE `vibe_ngo_v1`.`program`.`budget_plan_line` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year (FY)');
ALTER TABLE `vibe_ngo_v1`.`program`.`budget_plan_line` ALTER COLUMN `indirect_cost_rate` SET TAGS ('dbx_business_glossary_term' = 'Indirect Cost Rate (ICR)');
ALTER TABLE `vibe_ngo_v1`.`program`.`budget_plan_line` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By');
ALTER TABLE `vibe_ngo_v1`.`program`.`budget_plan_line` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_ngo_v1`.`program`.`budget_plan_line` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Budget Line Notes');
ALTER TABLE `vibe_ngo_v1`.`program`.`budget_plan_line` ALTER COLUMN `number` SET TAGS ('dbx_business_glossary_term' = 'Budget Line Number');
ALTER TABLE `vibe_ngo_v1`.`program`.`budget_plan_line` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Quantity');
ALTER TABLE `vibe_ngo_v1`.`program`.`budget_plan_line` ALTER COLUMN `revision_reason` SET TAGS ('dbx_business_glossary_term' = 'Revision Reason');
ALTER TABLE `vibe_ngo_v1`.`program`.`budget_plan_line` ALTER COLUMN `sdg_alignment` SET TAGS ('dbx_business_glossary_term' = 'Sustainable Development Goal (SDG) Alignment');
ALTER TABLE `vibe_ngo_v1`.`program`.`budget_plan_line` ALTER COLUMN `total_planned_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Planned Amount');
ALTER TABLE `vibe_ngo_v1`.`program`.`budget_plan_line` ALTER COLUMN `unit_cost` SET TAGS ('dbx_business_glossary_term' = 'Unit Cost');
ALTER TABLE `vibe_ngo_v1`.`program`.`budget_plan_line` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UoM)');
ALTER TABLE `vibe_ngo_v1`.`program`.`budget_plan_line` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `vibe_ngo_v1`.`program`.`program` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_ngo_v1`.`program`.`program` SET TAGS ('dbx_subdomain' = 'program_design');
ALTER TABLE `vibe_ngo_v1`.`program`.`program` ALTER COLUMN `program_id` SET TAGS ('dbx_business_glossary_term' = 'Program Identifier');
ALTER TABLE `vibe_ngo_v1`.`program`.`program` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Partnership Agreement Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`program`.`program` ALTER COLUMN `award_id` SET TAGS ('dbx_business_glossary_term' = 'Award Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`program`.`program` ALTER COLUMN `constituent_id` SET TAGS ('dbx_business_glossary_term' = 'Donor Id');
ALTER TABLE `vibe_ngo_v1`.`program`.`program` ALTER COLUMN `country_office_id` SET TAGS ('dbx_business_glossary_term' = 'Country Office Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`program`.`program` ALTER COLUMN `parent_program_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Program Id');
ALTER TABLE `vibe_ngo_v1`.`program`.`program` ALTER COLUMN `partner_org_id` SET TAGS ('dbx_business_glossary_term' = 'Implementing Partner Id');
ALTER TABLE `vibe_ngo_v1`.`program`.`program` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_ngo_v1`.`program`.`program` ALTER COLUMN `budget_amount` SET TAGS ('dbx_business_glossary_term' = 'Budget Amount');
ALTER TABLE `vibe_ngo_v1`.`program`.`program` ALTER COLUMN `budget_currency` SET TAGS ('dbx_business_glossary_term' = 'Budget Currency');
ALTER TABLE `vibe_ngo_v1`.`program`.`program` ALTER COLUMN `closeout_date` SET TAGS ('dbx_business_glossary_term' = 'Closeout Date');
ALTER TABLE `vibe_ngo_v1`.`program`.`program` ALTER COLUMN `cluster_code` SET TAGS ('dbx_business_glossary_term' = 'Cluster Code');
ALTER TABLE `vibe_ngo_v1`.`program`.`program` ALTER COLUMN `program_code` SET TAGS ('dbx_business_glossary_term' = 'Program Code');
ALTER TABLE `vibe_ngo_v1`.`program`.`program` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `vibe_ngo_v1`.`program`.`program` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `vibe_ngo_v1`.`program`.`program` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_ngo_v1`.`program`.`program` ALTER COLUMN `program_description` SET TAGS ('dbx_business_glossary_term' = 'Program Description');
ALTER TABLE `vibe_ngo_v1`.`program`.`program` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'End Date');
ALTER TABLE `vibe_ngo_v1`.`program`.`program` ALTER COLUMN `geographic_scope` SET TAGS ('dbx_business_glossary_term' = 'Geographic Scope');
ALTER TABLE `vibe_ngo_v1`.`program`.`program` ALTER COLUMN `is_emergency` SET TAGS ('dbx_business_glossary_term' = 'Is Emergency');
ALTER TABLE `vibe_ngo_v1`.`program`.`program` ALTER COLUMN `is_multi_year` SET TAGS ('dbx_business_glossary_term' = 'Is Multi Year');
ALTER TABLE `vibe_ngo_v1`.`program`.`program` ALTER COLUMN `logframe_reference` SET TAGS ('dbx_business_glossary_term' = 'Logframe Reference');
ALTER TABLE `vibe_ngo_v1`.`program`.`program` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Modified By');
ALTER TABLE `vibe_ngo_v1`.`program`.`program` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_ngo_v1`.`program`.`program` ALTER COLUMN `monitoring_frequency` SET TAGS ('dbx_business_glossary_term' = 'Monitoring Frequency');
ALTER TABLE `vibe_ngo_v1`.`program`.`program` ALTER COLUMN `program_name` SET TAGS ('dbx_business_glossary_term' = 'Program Name');
ALTER TABLE `vibe_ngo_v1`.`program`.`program` ALTER COLUMN `program_name` SET TAGS ('dbx_pii_personal' = 'true');
ALTER TABLE `vibe_ngo_v1`.`program`.`program` ALTER COLUMN `program_status` SET TAGS ('dbx_business_glossary_term' = 'Program Status');
ALTER TABLE `vibe_ngo_v1`.`program`.`program` ALTER COLUMN `program_type` SET TAGS ('dbx_business_glossary_term' = 'Program Type');
ALTER TABLE `vibe_ngo_v1`.`program`.`program` ALTER COLUMN `region` SET TAGS ('dbx_business_glossary_term' = 'Region');
ALTER TABLE `vibe_ngo_v1`.`program`.`program` ALTER COLUMN `reporting_frequency` SET TAGS ('dbx_business_glossary_term' = 'Reporting Frequency');
ALTER TABLE `vibe_ngo_v1`.`program`.`program` ALTER COLUMN `risk_rating` SET TAGS ('dbx_business_glossary_term' = 'Risk Rating');
ALTER TABLE `vibe_ngo_v1`.`program`.`program` ALTER COLUMN `sdg_alignment` SET TAGS ('dbx_business_glossary_term' = 'Sdg Alignment');
ALTER TABLE `vibe_ngo_v1`.`program`.`program` ALTER COLUMN `sector_code` SET TAGS ('dbx_business_glossary_term' = 'Sector Code');
ALTER TABLE `vibe_ngo_v1`.`program`.`program` ALTER COLUMN `sector_name` SET TAGS ('dbx_business_glossary_term' = 'Sector Name');
ALTER TABLE `vibe_ngo_v1`.`program`.`program` ALTER COLUMN `sector_name` SET TAGS ('dbx_pii_personal' = 'true');
ALTER TABLE `vibe_ngo_v1`.`program`.`program` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Start Date');
ALTER TABLE `vibe_ngo_v1`.`program`.`program` ALTER COLUMN `subsector` SET TAGS ('dbx_business_glossary_term' = 'Subsector');
ALTER TABLE `vibe_ngo_v1`.`program`.`program` ALTER COLUMN `target_beneficiaries` SET TAGS ('dbx_business_glossary_term' = 'Target Beneficiaries');
ALTER TABLE `vibe_ngo_v1`.`program`.`program` ALTER COLUMN `target_population` SET TAGS ('dbx_business_glossary_term' = 'Target Population');
ALTER TABLE `vibe_ngo_v1`.`program`.`program` ALTER COLUMN `theory_of_change` SET TAGS ('dbx_business_glossary_term' = 'Theory Of Change');
ALTER TABLE `vibe_ngo_v1`.`program`.`program` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
