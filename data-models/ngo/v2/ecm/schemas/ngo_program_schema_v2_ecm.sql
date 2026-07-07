-- Schema for Domain: program | Business:  | Version: v2_ecm
-- Generated on: 2026-07-03 04:47:17

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_ngo_v1`.`program` COMMENT 'Systems of record: SAP S/4HANA (programme/project accounting), eTools (UNICEF programme monitoring), InSight (programme analytics), Vision/SAP ERP (programme budgets). UN programme hierarchy: CPD, UNSDCF outcomes, Strategic Plan goal areas.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_ngo_v1`.`program`.`intervention` (
    `intervention_id` BIGINT COMMENT 'Unique identifier for the humanitarian or development intervention/program. Primary key for the intervention entity.',
    `obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.obligation. Business justification: Programs must track which compliance obligations apply (donor reporting deadlines, CHS assessments, regulatory filings). Essential for compliance calendar management and risk mitigation in nonprofit o',
    `country_office_id` BIGINT COMMENT 'Foreign key to field.country_office',
    `country_programme_document_id` BIGINT COMMENT 'FK to the Country Programme Document this intervention belongs to.',
    `finance_fund_id` BIGINT COMMENT 'Foreign key linking to finance.finance_fund. Business justification: Programs are funded by specific restricted or unrestricted funds. Essential for donor compliance reporting, financial tracking, and ensuring expenditures align with fund restrictions. Nonprofit domain',
    `psea_policy_id` BIGINT COMMENT 'Foreign key linking to safeguarding.psea_policy. Business justification: Regulatory compliance requirement: interventions must document which PSEA policy version governs their safeguarding obligations. Intervention.safeguarding_policy_applied flag indicates compliance but ',
    `humanitarian_response_plan_id` BIGINT COMMENT 'FK to the Humanitarian Response Plan this intervention contributes to.',
    `org_unit_id` BIGINT COMMENT 'Identifier of the organizational unit (country office, regional office, or headquarters division) responsible for implementing this intervention.',
    `system_platform_id` BIGINT COMMENT 'Foreign key linking to technology.system_platform. Business justification: Programs track primary digital platforms supporting implementation (KoboToolbox for surveys, CommCare for case management, DHIS2 for health data). Essential for M&E operations, data quality audits, an',
    `staff_member_id` BIGINT COMMENT 'Identifier of the staff member serving as the primary program manager or chief of party for this intervention, accountable for overall delivery and results.',
    `strategic_plan_goal_area_id` BIGINT COMMENT 'FK to the Strategic Plan goal area this intervention aligns to.',
    `unsdcf_outcome_id` BIGINT COMMENT 'FK to the UNSDCF outcome this intervention contributes to.',
    `program_id` BIGINT COMMENT 'Foreign key to program.program',
    `actual_end_date` DATE COMMENT 'Actual date when intervention activities concluded. May differ from planned end date due to extensions, early termination, or operational adjustments.',
    `actual_start_date` DATE COMMENT 'Actual date when intervention activities commenced in the field. May differ from planned start date due to delays in funding, security clearances, or operational readiness.',
    `budget_currency_code` DECIMAL(18,2) COMMENT 'Three-letter ISO 4217 currency code for the total budget amount (e.g., USD, EUR, GBP).',
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
    `ip_transfer_modality` STRING COMMENT 'HACT IP transfer modality enum: Direct Cash Transfer / Reimbursement / Direct Payment',
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
    `sdg_contribution_narrative` DECIMAL(18,2) COMMENT 'Qualitative description of how the intervention contributes to the identified SDG goal, target, and indicator. Articulates the causal pathway and expected magnitude of contribution.',
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
) COMMENT 'Programmatic intervention or project delivering outcomes. Source systems: SAP S/4HANA (project accounting), eTools (UNICEF programme monitoring), InSight. Systems-of-record: eTools (Programme Management), InSight (BI/reporting). IATI Activity Standard v2.03 alignment for intervention-level publishing.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`program`.`theory_of_change` (
    `theory_of_change_id` BIGINT COMMENT 'Unique identifier for the Theory of Change record. Primary key.',
    `staff_member_id` BIGINT COMMENT 'Foreign key linking to workforce.staff_member. Business justification: Theory of change approval requires tracking the authorizing staff member for governance, audit trails, and donor compliance reporting. Standard nonprofit program design workflow.',
    `intervention_id` BIGINT COMMENT 'Reference to the program intervention this Theory of Change supports. Links to the program master data.',
    `activity_statement` STRING COMMENT 'Summary of the key actions and interventions the program will undertake to produce outputs. Describes what the program does.',
    `approved_date` DATE COMMENT 'Date on which this Theory of Change version was formally approved for use.',
    `assumptions` STRING COMMENT 'Critical assumptions underlying the causal logic of the Theory of Change. Conditions believed to be true for the intervention logic to hold, but not directly controlled by the program.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this Theory of Change record was first created in the system.',
    `do_no_harm_considerations` STRING COMMENT 'Analysis of potential unintended negative consequences of the intervention and mitigation strategies. Ensures the program does not exacerbate vulnerabilities or create harm.',
    `donor_requirements` STRING COMMENT 'Specific donor-mandated requirements or frameworks that this Theory of Change must satisfy. May include reporting formats, result frameworks, or compliance standards.',
    `enabling_conditions` STRING COMMENT 'External factors and preconditions necessary for the Theory of Change to succeed. Contextual elements that facilitate or hinder the intervention logic.',
    `gender_integration_approach` STRING COMMENT 'Description of how gender considerations and Gender-Based Violence (GBV) prevention are integrated into the Theory of Change. Documents gender-sensitive or gender-transformative elements.',
    `geographic_scope` STRING COMMENT 'Geographic coverage and boundaries of the intervention described in the Theory of Change. May include countries, regions, districts, or specific project sites.',
    `humanitarian_principles_alignment` STRING COMMENT 'Description of how the Theory of Change adheres to core humanitarian principles: humanity, neutrality, impartiality, and independence.',
    `impact_statement` STRING COMMENT 'High-level statement of the ultimate long-term change the program aims to achieve. Represents the apex of the results chain in the Theory of Change.',
    `input_statement` STRING COMMENT 'Description of the resources (financial, human, material) required to implement activities. Foundation of the results chain.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this Theory of Change record was last updated in the system.',
    `logframe_reference` STRING COMMENT 'Reference identifier or link to the associated Logical Framework matrix that operationalizes this Theory of Change with indicators, means of verification, and assumptions.',
    `mel_framework_reference` STRING COMMENT 'Reference to the MEL or MEAL framework that defines how the Theory of Change will be monitored, evaluated, and adapted based on learning.',
    `outcome_statement` STRING COMMENT 'Description of the medium-term changes in behavior, relationships, actions, or conditions that the program seeks to influence. Intermediate results leading to impact.',
    `output_statement` STRING COMMENT 'Description of the direct products, goods, and services delivered by program activities. Tangible deliverables under program control.',
    `revision_reason` STRING COMMENT 'Explanation of why this Theory of Change was revised from a previous version. Documents adaptive management and learning.',
    `risks` STRING COMMENT 'Identified risks and threats that could disrupt the causal pathway or prevent achievement of intended results. Includes contextual, operational, and external risks.',
    `sdg_alignment` STRING COMMENT 'Mapping of the Theory of Change to relevant United Nations Sustainable Development Goals and targets. Documents contribution to global development agenda.',
    `sector_classification` STRING COMMENT 'Primary humanitarian or development sector(s) this Theory of Change addresses (e.g., WASH, Health, Nutrition, Education, Protection, Livelihoods). May reference DAC sector codes or cluster classifications.',
    `stakeholder_engagement_approach` STRING COMMENT 'Description of how stakeholders (beneficiaries, partners, communities, government) were engaged in developing and validating the Theory of Change. Reflects participatory design principles.',
    `target_population` STRING COMMENT 'Description of the primary beneficiary population the Theory of Change aims to serve. May include demographic characteristics, vulnerability profiles, and geographic scope.',
    `timeframe_end_date` DATE COMMENT 'Planned end date for the intervention period covered by this Theory of Change. Marks the target completion of the results chain.',
    `timeframe_start_date` DATE COMMENT 'Planned start date for the intervention period covered by this Theory of Change. Marks the beginning of the results chain timeline.',
    `toc_narrative` STRING COMMENT 'Comprehensive narrative describing the causal logic linking inputs, activities, outputs, outcomes, and long-term impact. Articulates how and why the intervention is expected to achieve its goals.',
    `toc_status` STRING COMMENT 'Current lifecycle status of the Theory of Change document. Tracks progression from draft through approval to active use and eventual archival.. Valid values are `draft|under_review|approved|active|revised|archived`',
    `toc_title` STRING COMMENT 'Descriptive title of the Theory of Change, summarizing the intervention logic and intended impact pathway.',
    `toc_version_number` STRING COMMENT 'Version identifier for this Theory of Change iteration. Supports tracking revisions across program cycles (e.g., 1.0, 1.1, 2.0).. Valid values are `^[0-9]+.[0-9]+$`',
    CONSTRAINT pk_theory_of_change PRIMARY KEY(`theory_of_change_id`)
) COMMENT 'Captures the Theory of Change (ToC) for each program intervention, documenting the causal logic linking inputs, activities, outputs, outcomes, and impact. Stores narrative ToC statements, assumptions, risks, enabling conditions, and linkages to SDGs and humanitarian principles. Supports RBM (Results-Based Management) and donor reporting requirements. One ToC record per program version, with versioning to track revisions across program cycles. Supports CPD outcome logic and Strategic Plan goal area alignment.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`program`.`program_logframe` (
    `program_logframe_id` BIGINT COMMENT 'Unique identifier for the program logical framework row entry. Primary key for the LogFrame matrix.',
    `staff_member_id` BIGINT COMMENT 'Foreign key linking to workforce.staff_member. Business justification: Logframe approval authority must be traceable to specific staff for donor reporting, audit compliance, and results-based management accountability in nonprofit operations.',
    `intervention_id` BIGINT COMMENT 'Reference to the parent program intervention to which this LogFrame row belongs.',
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
) COMMENT 'SSOT for programme design logical frameworks used in programme management, donor reporting, and intervention design. Distinct from mel.mel_logframe which is the MEL-owned logframe for indicator monitoring, evaluation, and learning activities. Aligned to CPD outcomes and UNSDCF results framework. Source systems: eTools, InSight, VISION/SAP.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`program`.`logframe_row` (
    `logframe_row_id` BIGINT COMMENT 'Unique identifier for the LogFrame row entry. Primary key for the logframe_row product.',
    `intervention_id` BIGINT COMMENT 'Reference to the program or project to which this LogFrame row applies. Enables program-level aggregation and reporting.',
    `parent_result_logframe_row_id` BIGINT COMMENT 'Reference to the parent result row in the LogFrame hierarchy. Enables navigation of the results chain (e.g., linking an output to its parent outcome).',
    `program_logframe_id` BIGINT COMMENT 'Reference to the parent LogFrame document to which this row belongs. Links this row to the overall program LogFrame structure.',
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
    `indicator_reference` STRING COMMENT 'Reference code or identifier linking this LogFrame row to one or more performance indicators. Enables MEL (Monitoring Evaluation and Learning) data linkage at the indicator level.',
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
    `donor_fund_id` BIGINT COMMENT 'Foreign key linking to donor.fund. Business justification: Program components (sub-units of interventions) may be funded by specific donor funds. Enables component-level fund accounting, sub-award fund tracking, and financial reporting at component granularit',
    `intervention_id` BIGINT COMMENT 'Reference to the parent program intervention that this component belongs to. Links component to its overarching program structure.',
    `it_project_id` BIGINT COMMENT 'Foreign key linking to technology.it_project. Business justification: Program components may require specific IT projects for system integration or customization (e.g., health component needs DHIS2 integration, education component needs learning management system). Supp',
    `parent_component_id` BIGINT COMMENT 'Reference to the parent component if this is a sub-component or workstream. Null for top-level components. Supports hierarchical program navigation.',
    `amendment_count` STRING COMMENT 'Number of formal amendments or revisions made to the component design, scope, or budget since initial approval. Tracks change management history.',
    `approval_date` DATE COMMENT 'Date when the component design and budget received formal approval to proceed with implementation.',
    `approval_status` STRING COMMENT 'Current approval state of the component design and budget within internal governance processes (draft, pending review, approved, revision required, rejected).. Valid values are `draft|pending_review|approved|revision_required|rejected`',
    `approved_by` STRING COMMENT 'Name or identifier of the individual or committee that approved this component for implementation.',
    `budget_currency_code` DECIMAL(18,2) COMMENT 'Three-letter ISO 4217 currency code for the budget envelope amount (e.g., USD, EUR, GBP).',
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
    `chs_self_assessment_id` BIGINT COMMENT 'Foreign key linking to compliance.chs_self_assessment. Business justification: Target population data provides evidence for CHS Commitment 3 (strengthening local capacity) and Commitment 4 (communication with communities). Essential for linking beneficiary targeting to CHS compl',
    `intervention_id` BIGINT COMMENT 'Reference to the parent program or intervention that this target population definition belongs to.',
    `age_range_max` STRING COMMENT 'Maximum age in years for individuals in the target population. Null if no maximum age restriction applies.',
    `age_range_min` STRING COMMENT 'Minimum age in years for individuals in the target population. Null if no minimum age restriction applies.',
    `approval_date` DATE COMMENT 'Date when this target population definition was formally approved for use in program planning and implementation.',
    `approved_by` STRING COMMENT 'Name or identifier of the person or role who approved this target population definition for program implementation.',
    `baseline_date` DATE COMMENT 'Date when the baseline data or needs assessment for this target population was collected or published.',
    `country_code` STRING COMMENT 'ISO 3166-1 alpha-3 country code where the target population is located (e.g., NGA for Nigeria, BGD for Bangladesh).. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this target population record was first created in the system.',
    `dac_sector_code` STRING COMMENT 'OECD DAC 5-digit sector code for international aid classification and reporting (e.g., 12220 for Basic Health Care).',
    `data_collection_method` STRING COMMENT 'Primary method or approach used to collect data about the target population (e.g., Household Survey, Key Informant Interview (KII), Focus Group Discussion (FGD), Secondary Data Analysis).',
    `data_source` STRING COMMENT 'Source of the population data or needs assessment used to define this target population (e.g., OCHA Humanitarian Needs Overview 2024, Baseline Survey March 2024, Government Census 2023).',
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
    `notes` STRING COMMENT 'Additional free-text notes, comments, or contextual information about this target population definition.',
    `planned_reach` STRING COMMENT 'Number of individuals the program plans to reach or serve from this target population, considering resource constraints and program scope.',
    `population_code` STRING COMMENT 'Short alphanumeric code or identifier used in reporting and documentation to reference this target population (e.g., TP-001, WASH-IDPs-2024).',
    `population_description` STRING COMMENT 'Detailed narrative description of the target population, including demographic characteristics, vulnerability profile, and rationale for targeting.',
    `population_name` STRING COMMENT 'Human-readable name or label for this target population segment (e.g., Malnourished Children Under 5 in Borno State, IDP Women Heads of Household).',
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

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`program`.`program_amendment` (
    `program_amendment_id` BIGINT COMMENT 'Unique identifier for the program amendment record. Primary key.',
    `award_id` BIGINT COMMENT 'Foreign key linking to grant.award. Business justification: Program amendments require donor approval and must reference the specific grant award being amended. Essential for amendment approval workflow, donor coordination, and compliance tracking. Award-level',
    `staff_member_id` BIGINT COMMENT 'Foreign key linking to workforce.staff_member. Business justification: Amendment audit trails require staff linkage for compliance, donor reporting, and internal controls. Standard practice in grant-funded nonprofit program management.',
    `intervention_id` BIGINT COMMENT 'Reference to the parent program intervention being amended.',
    `regulatory_filing_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_filing. Business justification: Program amendments often require regulatory filing (donor material change notifications, grant amendment submissions, board resolution filings). Essential for tracking amendment compliance in nonprofi',
    `amendment_number` STRING COMMENT 'Sequential or coded identifier for this amendment within the program (e.g., AMD-001, Amendment 1).',
    `amendment_status` STRING COMMENT 'Current lifecycle state of the amendment: draft (being prepared), submitted (sent for approval), under review (being evaluated), approved (accepted and effective), rejected (denied), or withdrawn (cancelled by submitter).. Valid values are `draft|submitted|under_review|approved|rejected|withdrawn`',
    `amendment_type` STRING COMMENT 'Classification of the amendment nature: no-cost extension (timeline only), scope change (activities/deliverables), budget reallocation (financial redistribution), geographic expansion (new locations), target population adjustment (beneficiary changes), or LogFrame revision (results framework update).. Valid values are `no_cost_extension|scope_change|budget_reallocation|geographic_expansion|target_population_adjustment|logframe_revision`',
    `approval_date` DATE COMMENT 'Date when the amendment received final approval from all required authorities (internal and donor).',
    `audit_trail_notes` STRING COMMENT 'Additional notes for audit and compliance purposes, including process deviations, special approvals, or historical context.',
    `budget_change_amount` DECIMAL(18,2) COMMENT 'Net financial change resulting from the amendment (positive for increases, negative for decreases, zero for reallocations with no net change).',
    `budget_change_currency` DECIMAL(18,2) COMMENT 'Three-letter ISO 4217 currency code for the budget change amount (e.g., USD, EUR, GBP).',
    `compliance_impact_assessment` STRING COMMENT 'Assessment of how this amendment affects compliance with donor requirements, regulatory obligations, and organizational policies.',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when this amendment record was first created in the system.',
    `donor_approval_reference` STRING COMMENT 'Official reference number or document identifier issued by the donor confirming their approval of the amendment.',
    `donor_approving_authority` STRING COMMENT 'Name or title of the donor representative or agency (e.g., USAID Agreement Officer, DFID Programme Manager) who approved the amendment on behalf of the funding organization.',
    `effective_date` DATE COMMENT 'Date from which the amendment terms become binding and operational, may differ from approval date based on donor or contractual requirements.',
    `geographic_coverage_change` STRING COMMENT 'Description of changes to geographic scope, including new districts, provinces, or countries added or removed from program coverage.',
    `grant_requirement_flag` BOOLEAN COMMENT 'Indicates whether this amendment is required by grant agreement terms or donor mandate. True if donor-required, False if organization-initiated.',
    `internal_approving_authority` STRING COMMENT 'Name or title of the internal organizational authority (e.g., Program Director, Country Director, Chief Executive Officer) who approved the amendment.',
    `justification_narrative` STRING COMMENT 'Detailed business rationale and context explaining why the amendment is necessary, including operational, programmatic, or external factors driving the change.',
    `last_modified_by` STRING COMMENT 'Username or identifier of the staff member who most recently updated this amendment record.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'System timestamp when this amendment record was most recently updated.',
    `logframe_revision_flag` BOOLEAN COMMENT 'Indicates whether this amendment includes changes to the program LogFrame (results framework, indicators, targets, or assumptions). True if LogFrame is revised, False otherwise.',
    `logframe_revision_summary` STRING COMMENT 'Summary of changes made to the LogFrame, including modified indicators, revised targets, new outputs, or updated assumptions.',
    `original_end_date` DATE COMMENT 'The program end date before this amendment was applied, captured for audit trail and before/after comparison.',
    `original_target_beneficiaries` STRING COMMENT 'The planned number of direct beneficiaries before this amendment, captured for before/after comparison.',
    `rejection_reason` STRING COMMENT 'Explanation provided by approving authority if the amendment was rejected, including specific concerns or required modifications.',
    `revised_end_date` DATE COMMENT 'The new program end date after this amendment is applied, null if the amendment does not affect timeline.',
    `revised_target_beneficiaries` STRING COMMENT 'The new planned number of direct beneficiaries after this amendment is applied, null if the amendment does not affect beneficiary targets.',
    `risk_assessment` STRING COMMENT 'Assessment of risks introduced or mitigated by this amendment, including operational, financial, reputational, or compliance risks.',
    `scope_change_description` STRING COMMENT 'Detailed description of changes to program scope, including modifications to activities, deliverables, outputs, or intervention strategies.',
    `sdg_alignment_change` STRING COMMENT 'Description of changes to SDG alignment resulting from this amendment, including new SDG targets added or removed.',
    `sector_classification_change` STRING COMMENT 'Description of changes to sector classifications (e.g., WASH, Health, Nutrition, Education, Protection) resulting from scope modifications.',
    `stakeholder_consultation_summary` STRING COMMENT 'Summary of consultations conducted with beneficiaries, partners, local authorities, and other stakeholders regarding the proposed amendment.',
    `submission_date` DATE COMMENT 'Date when the amendment was formally submitted for approval to internal and/or donor authorities.',
    `supporting_documentation_reference` STRING COMMENT 'Reference to supporting documents (e.g., revised budget, updated LogFrame, donor correspondence) stored in document management system.',
    `target_population_change` STRING COMMENT 'Description of changes to target beneficiary population, including adjustments to demographic criteria, vulnerability profiles, or total beneficiary numbers.',
    `timeline_extension_days` STRING COMMENT 'Number of calendar days by which the program implementation period is extended (positive for extensions, negative for reductions, zero if no timeline change).',
    `withdrawal_reason` STRING COMMENT 'Explanation for why the amendment was withdrawn by the submitting organization before approval decision.',
    CONSTRAINT pk_program_amendment PRIMARY KEY(`program_amendment_id`)
) COMMENT 'SSOT for internally-initiated programme/intervention amendments including scope changes, target population adjustments, and logframe revisions. Distinct from grant.grant_amendment which covers donor/funder-initiated award-level amendments.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`program`.`design_assessment` (
    `design_assessment_id` BIGINT COMMENT 'Unique identifier for the program design assessment record.',
    `obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.obligation. Business justification: Assessments fulfill specific compliance obligations (donor-required needs assessments, CHS evidence requirements, Sphere standards documentation). Essential for tracking assessment compliance in human',
    `intervention_id` BIGINT COMMENT 'Reference to the program this design assessment informs.',
    `admin_level_1` STRING COMMENT 'First-level administrative division (e.g., province, state, region) where the assessment was conducted.',
    `admin_level_2` STRING COMMENT 'Second-level administrative division (e.g., district, county) where the assessment was conducted.',
    `assessment_code` STRING COMMENT 'Externally-known unique code or identifier for this design assessment, used in reports and donor communications.. Valid values are `^[A-Z0-9]{6,20}$`',
    `assessment_status` STRING COMMENT 'Current lifecycle status of the design assessment: planned (scheduled but not started), in_progress (data collection underway), completed (data collected), validated (findings reviewed and approved), archived (historical record).. Valid values are `planned|in_progress|completed|validated|archived`',
    `assessment_team_lead` STRING COMMENT 'Name or identifier of the individual or organization leading the assessment team.',
    `assessment_team_size` STRING COMMENT 'Number of enumerators, surveyors, or field staff involved in conducting the assessment.',
    `assessment_title` STRING COMMENT 'Descriptive title of the design assessment (e.g., Rapid Nutrition Assessment - Northern Province).',
    `assessment_type` STRING COMMENT 'Classification of the assessment approach: rapid (quick situational), comprehensive (in-depth multi-sector), sectoral (single sector focus), baseline (pre-intervention), midline (mid-intervention), or endline (post-intervention).. Valid values are `rapid|comprehensive|sectoral|baseline|midline|endline`',
    `country_code` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country code where the assessment was conducted.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this design assessment record was first created in the system.',
    `dac_sector_code` STRING COMMENT 'Five-digit OECD DAC sector classification code for international aid reporting and alignment.. Valid values are `^[0-9]{5}$`',
    `data_collection_end_date` DATE COMMENT 'Date when field data collection for this assessment was completed.',
    `data_collection_start_date` DATE COMMENT 'Date when field data collection for this assessment began.',
    `data_quality_score` DECIMAL(18,2) COMMENT 'Numeric score (0.00 to 1.00) representing the assessed quality and reliability of the data collected, based on validation checks and consistency reviews.',
    `data_sharing_restrictions` STRING COMMENT 'Description of any restrictions on sharing or publishing the assessment data, due to sensitivity, partner agreements, or ethical considerations.',
    `donor_visibility_flag` BOOLEAN COMMENT 'Indicates whether this assessment is intended for donor reporting and visibility (True) or is for internal use only (False).',
    `ethical_approval_obtained` BOOLEAN COMMENT 'Indicates whether formal ethical approval or informed consent protocols were obtained prior to conducting the assessment (True/False).',
    `gam_prevalence_percent` DECIMAL(18,2) COMMENT 'Percentage of the assessed population exhibiting Global Acute Malnutrition, a key nutrition indicator for program design.',
    `geographic_scope` STRING COMMENT 'Geographic area covered by the assessment (e.g., Northern Province, District X and Y, National).',
    `humanitarian_principles_compliance` STRING COMMENT 'Indicates whether the assessment was conducted in compliance with core humanitarian principles (humanity, neutrality, impartiality, independence): full compliance, partial compliance, or not applicable.. Valid values are `full|partial|not_applicable`',
    `key_findings_summary` STRING COMMENT 'Executive summary of the most critical findings and evidence from the assessment, used to inform program design decisions.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this design assessment record was last updated or modified.',
    `methodology` STRING COMMENT 'Primary data collection methodology employed: FGD (Focus Group Discussion), KII (Key Informant Interview), household survey, MUAC (Mid-Upper Arm Circumference) screening, market assessment, participatory rural appraisal, or mixed methods. [ENUM-REF-CANDIDATE: fgd|kii|household_survey|muac_screening|market_assessment|participatory_rural_appraisal|mixed_methods — 7 candidates stripped; promote to reference product]',
    `notes` STRING COMMENT 'Additional free-text notes, observations, or contextual information about the assessment not captured in other fields.',
    `population_assessed` STRING COMMENT 'Total number of individuals or households included in the assessment sample.',
    `priority_needs_ranking` STRING COMMENT 'Ordered list or narrative of the top priority needs identified by the assessed population, used to inform program design and resource allocation.',
    `protection_risks_identified` STRING COMMENT 'Narrative description of protection risks identified during the assessment, such as GBV (Gender-Based Violence), child protection concerns, or safety threats.',
    `report_url` STRING COMMENT 'Web link or document repository path to the full assessment report or findings document.',
    `sam_prevalence_percent` DECIMAL(18,2) COMMENT 'Percentage of the assessed population exhibiting Severe Acute Malnutrition, indicating urgent intervention needs.',
    `sdg_alignment` STRING COMMENT 'List of SDG goals and targets that this assessments findings align with or inform (e.g., SDG 2.1, SDG 6.1).',
    `sector_focus` STRING COMMENT 'Primary humanitarian or development sector this assessment focuses on: WASH (Water Sanitation and Hygiene), health, nutrition, education, protection, livelihoods, shelter, food security, or multi-sector. [ENUM-REF-CANDIDATE: wash|health|nutrition|education|protection|livelihoods|shelter|food_security|multi_sector — 9 candidates stripped; promote to reference product]',
    `target_population_description` STRING COMMENT 'Narrative description of the population segment assessed (e.g., IDPs in camp settings, rural women of reproductive age, school-age children).',
    `validated_by` STRING COMMENT 'Name or identifier of the individual or unit that validated the assessment findings.',
    `validation_date` DATE COMMENT 'Date when the assessment findings were formally validated and approved by the program team or MEL unit.',
    `wash_coverage_gap_percent` DECIMAL(18,2) COMMENT 'Percentage of the assessed population lacking access to adequate WASH services, indicating program need.',
    CONSTRAINT pk_design_assessment PRIMARY KEY(`design_assessment_id`)
) COMMENT 'Structured needs assessment conducted to inform program design or adaptation, capturing assessment type (rapid, comprehensive, sectoral), methodology (FGD, KII, household survey, MUAC screening), geographic scope, population assessed, key findings by sector, GAM/SAM prevalence (for nutrition), WASH coverage gaps, protection risks, priority needs ranking, data collection dates, and assessment team. Distinct from individual beneficiary assessments (owned by beneficiary domain) — this is the program-level population needs evidence base.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`program`.`risk_register` (
    `risk_register_id` BIGINT COMMENT 'Unique identifier for the risk register entry. Primary key for the risk register product.',
    `staff_member_id` BIGINT COMMENT 'Foreign key linking to workforce.staff_member. Business justification: Risk register approval authority must be linked to staff for governance, escalation workflows, and donor risk management reporting requirements.',
    `compliance_incident_id` BIGINT COMMENT 'Foreign key linking to compliance.incident. Business justification: When program risks materialize, they become compliance incidents requiring investigation and corrective action. Essential for linking risk management to incident response in nonprofit operations.',
    `intervention_id` BIGINT COMMENT 'Reference to the program intervention to which this risk applies. Links risk to the specific humanitarian or development program.',
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
    `staff_member_id` BIGINT COMMENT 'Foreign key linking to workforce.staff_member. Business justification: Implementation plan approval requires staff linkage for accountability, delegation of authority tracking, and compliance with nonprofit internal controls.',
    `donor_requirement_id` BIGINT COMMENT 'Foreign key linking to compliance.donor_requirement. Business justification: Implementation plans fulfill specific donor compliance requirements (detailed work plans, milestone schedules, activity timelines). Essential for tracking donor deliverable compliance in grant managem',
    `intervention_id` BIGINT COMMENT 'Reference to the parent program intervention that this implementation plan operationalizes.',
    `approval_date` DATE COMMENT 'Date on which this implementation plan was formally approved for execution.',
    `assumptions` STRING COMMENT 'Key assumptions underlying the implementation plan, including security conditions, partner capacity, beneficiary access, and external dependencies.',
    `budget_allocated_amount` DECIMAL(18,2) COMMENT 'Total budget amount allocated to this implementation plan for the planning period.',
    `budget_currency_code` DECIMAL(18,2) COMMENT 'Three-letter ISO 4217 currency code for the budget allocated amount.',
    `coordination_mechanism` STRING COMMENT 'Description of coordination mechanisms with partners, clusters, local authorities, and other stakeholders for implementation plan execution.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this implementation plan record was first created in the system.',
    `dac_sector_code` STRING COMMENT 'Five-digit OECD DAC sector code classifying the implementation plan for international aid transparency and reporting.. Valid values are `^[0-9]{5}$`',
    `disaggregation_approach` STRING COMMENT 'Description of how beneficiary data will be disaggregated (by gender, age, disability, displacement status, etc.) for equity and accountability.',
    `donor_visibility_flag` BOOLEAN COMMENT 'Indicates whether this implementation plan is visible to donors for transparency and reporting purposes.',
    `geographic_scope` STRING COMMENT 'Geographic coverage of the implementation plan, listing countries, regions, districts, or project sites where activities will be executed.',
    `grant_requirement_flag` BOOLEAN COMMENT 'Indicates whether this implementation plan is a mandatory deliverable under a specific grant agreement.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this implementation plan record was last modified in the system.',
    `last_revision_date` DATE COMMENT 'Date of the most recent revision or amendment to this implementation plan.',
    `logframe_reference` STRING COMMENT 'Reference identifier linking this implementation plan to specific outputs and activities in the program LogFrame.',
    `monitoring_approach` STRING COMMENT 'Description of the monitoring and evaluation approach for tracking implementation plan progress, including data collection methods and frequency.',
    `notes` STRING COMMENT 'Additional notes, comments, or contextual information relevant to this implementation plan.',
    `plan_code` STRING COMMENT 'Externally-known unique business identifier for the implementation plan, used in donor reporting and field communications.. Valid values are `^[A-Z0-9]{6,20}$`',
    `plan_manager_name` STRING COMMENT 'Full name of the staff member serving as the implementation plan manager or work plan coordinator.',
    `plan_status` STRING COMMENT 'Current lifecycle status of the implementation plan indicating approval and execution state. [ENUM-REF-CANDIDATE: draft|submitted|approved|active|on_hold|revised|completed|closed|cancelled — 9 candidates stripped; promote to reference product]',
    `plan_title` STRING COMMENT 'Descriptive title of the implementation plan, summarizing the intervention scope and geographic focus.',
    `plan_type` STRING COMMENT 'Classification of the implementation plan by temporal scope and purpose (annual work plan, quarterly plan, emergency response plan, etc.).. Valid values are `annual|quarterly|project_phase|emergency_response|pilot|scale_up`',
    `plan_version` STRING COMMENT 'Version number of the implementation plan following semantic versioning (e.g., 1.0, 1.1, 2.0) to track revisions and amendments.. Valid values are `^[0-9]+.[0-9]+$`',
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
    `toc_reference` STRING COMMENT 'Reference identifier linking this implementation plan to the program Theory of Change pathway and assumptions.',
    `total_planned_activities` STRING COMMENT 'Total number of discrete activities scheduled in this implementation plan.',
    `total_planned_milestones` STRING COMMENT 'Total number of key milestones defined in this implementation plan for progress tracking and donor reporting.',
    CONSTRAINT pk_implementation_plan PRIMARY KEY(`implementation_plan_id`)
) COMMENT 'Detailed implementation plan (work plan) for a program intervention or component, serving as the operational roadmap for field teams and the baseline for progress tracking. Captures planned activities at the task level including activity name, description, type, responsible parties, timelines (Gantt-style), resource requirements, geographic phasing, target beneficiary counts, status tracking, and linkage to LogFrame outputs. Includes comprehensive milestone tracking (program launch, mid-term review, final evaluation, closeout, donor reporting deadlines) with milestone type, planned/actual dates, completion status, deliverable description, sign-off authority, and dependency sequencing. Stores plan version, planning period, approval status, and last revision date. This is the SSOT for all program scheduling, activity sequencing, and milestone management — the schedule authority for donor reporting timelines and grant compliance.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`program`.`budget_plan` (
    `budget_plan_id` BIGINT COMMENT 'Unique identifier for the program budget plan record.',
    `staff_member_id` BIGINT COMMENT 'Foreign key linking to workforce.staff_member. Business justification: Budget approval authority must be traceable to specific staff for financial controls, donor compliance, audit trails, and delegation of authority documentation.',
    `award_id` BIGINT COMMENT 'Reference to the grant funding this budget plan, if applicable.',
    `budget_id` BIGINT COMMENT 'Foreign key linking to finance.budget. Business justification: Program budget plans must reference the master finance budget for reconciliation, variance analysis, and donor reporting. Critical for ensuring program budgets align with organizational financial plan',
    `donor_fund_id` BIGINT COMMENT 'Foreign key linking to donor.fund. Business justification: Budget plans must allocate expenses to specific donor funds for restriction compliance and fund accounting. Critical for budget-to-fund allocation, grant financial reporting, restricted fund managemen',
    `intervention_id` BIGINT COMMENT 'Reference to the program intervention this budget plan supports.',
    `it_project_id` BIGINT COMMENT 'Foreign key linking to technology.it_project. Business justification: IT projects often have dedicated budget plans within program budgets (technology procurement, system implementation costs). Required for financial tracking of technology investments and cost allocatio',
    `partnership_agreement_id` BIGINT COMMENT 'Foreign key linking to partnership.partnership_agreement. Business justification: Budget plans for partner-implemented programs must reference the governing partnership agreement for compliance tracking, allowable cost verification, financial reconciliation, and donor audit trails.',
    `regulatory_filing_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_filing. Business justification: Budget plans are submitted as part of regulatory filings (Form 990 Schedule I, single audit schedules, donor financial reports). Direct operational link for nonprofit financial compliance reporting.',
    `system_platform_id` BIGINT COMMENT 'Foreign key linking to technology.system_platform. Business justification: Budget plans created and managed in specific financial systems (SAP, Workday, custom ERP). Required for audit trails, donor compliance reporting, and financial system access control. Standard nonprofi',
    `amendment_date` DATE COMMENT 'Date on which this budget plan amendment was executed.',
    `amendment_reason` STRING COMMENT 'Explanation of why this budget plan was amended or revised, if applicable.',
    `approval_date` DATE COMMENT 'Date on which this budget plan was formally approved.',
    `budget_assumptions` DECIMAL(18,2) COMMENT 'Key assumptions underlying the budget plan, such as exchange rates, inflation rates, beneficiary numbers, or activity volumes.',
    `budget_narrative` DECIMAL(18,2) COMMENT 'Detailed narrative justification and explanation of the budget plan, including assumptions, methodologies, and cost calculations.',
    `budget_owner` DECIMAL(18,2) COMMENT 'Name or identifier of the program manager or budget holder responsible for this budget plan.',
    `budget_period_end_date` DATE COMMENT 'End date of the budget period this plan covers.',
    `budget_period_start_date` DATE COMMENT 'Start date of the budget period this plan covers.',
    `budget_plan_number` DECIMAL(18,2) COMMENT 'Externally-known unique identifier or code for this budget plan, used in donor reporting and financial communications.',
    `budget_status` DECIMAL(18,2) COMMENT 'Current lifecycle status of the budget plan in the approval and execution workflow. [ENUM-REF-CANDIDATE: draft|submitted|under_review|approved|active|amended|closed|rejected — 8 candidates stripped; promote to reference product]',
    `budget_type` DECIMAL(18,2) COMMENT 'Classification of the budget plan indicating whether it is the original approved budget, a revision, supplemental funding, or closeout budget.',
    `budget_version_number` DECIMAL(18,2) COMMENT 'Version number of this budget plan, incremented with each revision or amendment.',
    `compliance_notes` STRING COMMENT 'Notes regarding compliance requirements, restrictions, or special conditions attached to this budget plan.',
    `contractual_costs` DECIMAL(18,2) COMMENT 'Total budgeted amount for contractual services, consultants, and sub-awards.',
    `cost_share_amount` DECIMAL(18,2) COMMENT 'Total budgeted amount of cost sharing or matching funds contributed by the organization or other sources.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this budget plan record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts in this budget plan.. Valid values are `^[A-Z]{3}$`',
    `dac_sector_code` STRING COMMENT 'OECD DAC sector classification code for this budget plan, used for international aid transparency and reporting.',
    `donor_budget_code` DECIMAL(18,2) COMMENT 'Donor-specific budget classification code or identifier required for reporting and compliance.',
    `donor_visibility_flag` BOOLEAN COMMENT 'Indicates whether this budget plan is visible to the donor in reporting portals or dashboards.',
    `equipment_costs` DECIMAL(18,2) COMMENT 'Total budgeted amount for equipment purchases with unit cost exceeding capitalization threshold.',
    `finance_contact` STRING COMMENT 'Name or identifier of the finance team member responsible for financial oversight of this budget plan.',
    `fringe_benefits_costs` DECIMAL(18,2) COMMENT 'Total budgeted amount for fringe benefits associated with personnel costs.',
    `indirect_cost_rate` DECIMAL(18,2) COMMENT 'Approved indirect cost rate percentage applied to the direct cost base, as negotiated in NICRA or per de minimis rate.',
    `indirect_costs` DECIMAL(18,2) COMMENT 'Total budgeted amount for indirect costs (Facilities and Administration), calculated by applying the indirect cost rate to the direct cost base.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this budget plan record was last updated or modified.',
    `budget_plan_name` DECIMAL(18,2) COMMENT 'Descriptive name or title of the budget plan, typically aligned with program or grant phase.',
    `notes` STRING COMMENT 'Additional free-text notes or comments about this budget plan.',
    `other_direct_costs` DECIMAL(18,2) COMMENT 'Total budgeted amount for other direct costs not classified in standard categories, such as communications, rent, or participant support.',
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
    `staff_member_id` BIGINT COMMENT 'Foreign key linking to workforce.staff_member. Business justification: Line-level budget approval tracking enables granular financial controls, threshold-based approval workflows, and audit compliance in nonprofit grant management.',
    `award_id` BIGINT COMMENT 'Reference to the grant or funding award that finances this budget line. Enables donor-specific budget reporting and compliance tracking.',
    `budget_line_id` BIGINT COMMENT 'Foreign key linking to finance.budget_line. Business justification: Line-level linkage between program and finance budgets enables detailed variance analysis, actual-vs-budget reporting, and financial statement preparation. Essential for grant compliance and donor rep',
    `budget_plan_id` BIGINT COMMENT 'Reference to the parent budget plan document that contains this line item. Links to the overall program budget structure.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Budget lines are allocated to cost centers for departmental and program-level cost tracking. Essential for indirect cost allocation, NICRA compliance, and management reporting on program efficiency an',
    `donor_fund_id` BIGINT COMMENT 'Foreign key linking to donor.fund. Business justification: Individual budget line items allocated to specific donor funds enable granular restriction tracking and line-item fund accounting. Required for detailed financial reporting, multi-fund budget allocati',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Program budget lines must map to GL accounts for financial posting, trial balance preparation, and financial statement generation. Required for GAAP compliance and ensuring program expenses are correc',
    `intervention_id` BIGINT COMMENT 'Reference to the program or project to which this budget line belongs. Enables program-level budget rollup and tracking.',
    `partnership_agreement_id` BIGINT COMMENT 'Foreign key linking to partnership.partnership_agreement. Business justification: Individual budget line items in partner-executed programs must trace to the partnership agreement for line-item allowability verification, indirect cost rate application, cost-sharing validation, and ',
    `activity_code` STRING COMMENT 'Program activity or intervention code that this budget line supports. Links budget to program implementation activities.',
    `allowable_cost_flag` BOOLEAN COMMENT 'Indicates whether this cost is allowable under the grant or donor regulations. Used for budget review and compliance validation.',
    `approval_date` DATE COMMENT 'Date when this budget line was formally approved. Critical for compliance and audit documentation.',
    `approval_required_flag` BOOLEAN COMMENT 'Indicates whether this budget line requires explicit donor or management approval before execution. Used for budget control and governance.',
    `budget_period_end_date` DATE COMMENT 'The end date of the budget period for which this line item is planned. Defines the timeframe for budget execution and BvA analysis.',
    `budget_period_start_date` DATE COMMENT 'The start date of the budget period for which this line item is planned. Enables multi-year and phased budget tracking.',
    `budget_plan_line_status` DECIMAL(18,2) COMMENT 'Current lifecycle status of the budget line item. Tracks approval workflow and execution state. [ENUM-REF-CANDIDATE: draft|submitted|approved|active|revised|closed|cancelled — 7 candidates stripped; promote to reference product]',
    `budget_version_number` DECIMAL(18,2) COMMENT 'Version number of the budget plan to track revisions and amendments. Incremented with each budget modification.',
    `chart_of_accounts_code` STRING COMMENT 'General Ledger account code from the organizations Chart of Accounts. Links budget planning to financial accounting and enables BvA tracking.',
    `cost_category` STRING COMMENT 'Primary budget classification category following standard nonprofit and federal grant budget structures. Used for donor reporting and financial compliance. [ENUM-REF-CANDIDATE: personnel|fringe_benefits|travel|equipment|supplies|contractual|subawards|other_direct_costs|indirect_costs — 9 candidates stripped; promote to reference product]',
    `cost_sharing_amount` DECIMAL(18,2) COMMENT 'The portion of the total planned amount that represents cost sharing or matching contribution. Used for grant compliance reporting.',
    `cost_sharing_flag` BOOLEAN COMMENT 'Indicates whether this budget line includes cost sharing or matching funds from the organization or other sources. Critical for grant compliance.',
    `cost_sharing_source` STRING COMMENT 'The source of cost sharing funds (e.g., organizational reserves, other grants, in-kind contributions, partner contributions).',
    `cost_subcategory` STRING COMMENT 'Detailed subcategory within the primary cost category for granular budget tracking (e.g., international travel, local travel, office supplies, medical supplies).',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this budget line record was first created in the system. Required for audit trail and data lineage.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the budget line amounts (e.g., USD, EUR, GBP). Enables multi-currency budget management.. Valid values are `^[A-Z]{3}$`',
    `dac_sector_code` STRING COMMENT 'OECD DAC 5-digit sector classification code for international development reporting and sector-based budget analysis.',
    `direct_cost_flag` BOOLEAN COMMENT 'Indicates whether this budget line is a direct cost (true) or an indirect/overhead cost (false). Used for indirect cost rate calculations and compliance.',
    `donor_budget_code` DECIMAL(18,2) COMMENT 'Donor-specific budget line code or reference number required for grant reporting and financial compliance. Maps to donor financial systems.',
    `fiscal_year` STRING COMMENT 'The fiscal year to which this budget line belongs. Enables fiscal year-based budget reporting and analysis.',
    `indirect_cost_rate` DECIMAL(18,2) COMMENT 'The indirect cost rate applied to this budget line if it is a direct cost base. Expressed as a decimal (e.g., 0.1500 for 15%). Links to NICRA.',
    `last_modified_by` STRING COMMENT 'Identifier of the user or system that last modified this budget line record. Supports change tracking and accountability.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this budget line record was last updated. Critical for audit trail and version control.',
    `line_description` STRING COMMENT 'Detailed narrative description of the budget line item explaining the purpose, justification, and planned use of funds.',
    `line_number` STRING COMMENT 'Sequential or hierarchical line number within the budget plan for ordering and reference purposes (e.g., 1.1, 1.2, 2.1).',
    `notes` STRING COMMENT 'Additional notes, comments, or clarifications about this budget line item for internal reference and donor communication.',
    `quantity` DECIMAL(18,2) COMMENT 'The number of units planned for this budget line item. Used with unit cost to calculate total planned amount.',
    `revision_reason` STRING COMMENT 'Explanation for any revision or amendment to this budget line. Required for donor reporting and audit trail.',
    `sdg_alignment` STRING COMMENT 'United Nations Sustainable Development Goal number(s) that this budget line contributes to (e.g., SDG 1, SDG 3, SDG 6). Supports impact reporting.',
    `total_planned_amount` DECIMAL(18,2) COMMENT 'The total budgeted amount for this line item, typically calculated as quantity multiplied by unit cost. Primary financial value for budget versus actual (BvA) tracking.',
    `unit_cost` DECIMAL(18,2) COMMENT 'The cost per single unit of measure. Multiplied by quantity to derive the total planned amount for this line.',
    `unit_of_measure` STRING COMMENT 'The unit by which the budget item is measured (e.g., person-months, trips, units, days, hours, items, sessions).',
    `created_by` STRING COMMENT 'Identifier of the user or system that created this budget line record. Supports audit trail and data governance.',
    CONSTRAINT pk_budget_plan_line PRIMARY KEY(`budget_plan_line_id`)
) COMMENT 'Individual budget line item within a program budget, capturing cost category (personnel, fringe, travel, equipment, supplies, contractual, other direct costs, indirect costs), budget line description, unit cost, quantity, unit of measure, total planned amount, donor budget code, and cost-sharing flag. Enables granular budget management, BvA tracking linkage to finance domain, and donor financial reporting by budget category.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`program`.`program_closeout` (
    `program_closeout_id` BIGINT COMMENT 'Unique identifier for the program closeout record.',
    `award_id` BIGINT COMMENT 'Foreign key linking to grant.award. Business justification: Program closeouts must reconcile against the specific grant award that funded the intervention. Required for final financial reconciliation, donor signoff, audit completion, and unobligated balance re',
    `staff_member_id` BIGINT COMMENT 'Foreign key linking to workforce.staff_member. Business justification: Program closeout certification must link to authorizing staff for donor final reporting, compliance certification, and organizational accountability in grant closure.',
    `intervention_id` BIGINT COMMENT 'Reference to the program being closed out.',
    `partnership_agreement_id` BIGINT COMMENT 'Foreign key linking to partnership.partnership_agreement. Business justification: Program closeout for partner-executed interventions must reference the partnership agreement for final obligation verification, financial reconciliation, asset disposition per MOU terms, and formal pa',
    `regulatory_filing_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_filing. Business justification: Closeout triggers final regulatory filings (final 990 schedules, donor closeout reports, single audit completion reports, final IATI publication). Critical for nonprofit program lifecycle compliance.',
    `archiving_completion_date` DATE COMMENT 'Date when all program documentation was archived and the archiving process was completed.',
    `archiving_reference` STRING COMMENT 'Reference identifier for the archived program documentation, including location and retention schedule in compliance with record retention requirements.',
    `asset_disposition_plan` STRING COMMENT 'Detailed plan for disposition of program assets including equipment, inventory, and property, specifying transfer, sale, or disposal methods in compliance with donor requirements.',
    `asset_disposition_status` STRING COMMENT 'Current status of asset disposition activities: pending, in progress, completed, donor approval required, or approved.. Valid values are `pending|in_progress|completed|donor_approval_required|approved`',
    `audit_completion_status` STRING COMMENT 'Status of any required closeout audit: not required, pending, in progress, completed, findings issued, or resolved.. Valid values are `not_required|pending|in_progress|completed|findings_issued|resolved`',
    `audit_findings_summary` STRING COMMENT 'Summary of any audit findings, observations, or recommendations issued during the closeout audit process.',
    `budget_utilization_percentage` DECIMAL(18,2) COMMENT 'Percentage of approved budget that was actually expended, calculated as (final expenditure / final budget) * 100.',
    `budget_variance_amount` DECIMAL(18,2) COMMENT 'Difference between final budget and final expenditure (budget minus expenditure), used for Budget versus Actual (BvA) analysis.',
    `closeout_number` STRING COMMENT 'Externally-known unique identifier for this closeout process, used in donor communications and compliance reporting.',
    `closeout_status` STRING COMMENT 'Current lifecycle status of the closeout process: initiated, in progress, pending donor review, donor approved, completed, or archived.. Valid values are `initiated|in_progress|pending_donor_review|donor_approved|completed|archived`',
    `closeout_type` STRING COMMENT 'Classification of the closeout reason: planned completion, early termination, no-cost extension expiry, emergency suspension, donor-initiated closure, or force majeure event.. Valid values are `planned|early_termination|no_cost_extension_expiry|emergency_suspension|donor_initiated|force_majeure`',
    `completion_date` DATE COMMENT 'Date when all closeout activities were completed and the program was formally closed.',
    `compliance_certification_date` DATE COMMENT 'Date when the organization certified compliance with all closeout requirements.',
    `compliance_certification_flag` BOOLEAN COMMENT 'Indicates whether the organization has certified compliance with all donor and regulatory closeout requirements (True = certified, False = not certified).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this closeout record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all financial amounts in this closeout record.. Valid values are `^[A-Z]{3}$`',
    `donor_signoff_conditions` STRING COMMENT 'Any conditions or requirements specified by the donor for final closeout approval, including corrective actions or additional documentation needed.',
    `donor_signoff_date` DATE COMMENT 'Date when the donor provided formal sign-off and approval for program closeout.',
    `donor_signoff_status` STRING COMMENT 'Status of donor formal sign-off on the program closeout: pending, submitted, under review, approved, conditional approval, or rejected.. Valid values are `pending|submitted|under_review|approved|conditional_approval|rejected`',
    `final_beneficiary_count` STRING COMMENT 'Total number of unique beneficiaries served over the entire program lifecycle, as reported in the final program report.',
    `final_beneficiary_count_female` STRING COMMENT 'Total number of female beneficiaries served, supporting gender-disaggregated reporting requirements.',
    `final_beneficiary_count_male` STRING COMMENT 'Total number of male beneficiaries served, supporting gender-disaggregated reporting requirements.',
    `final_beneficiary_count_other` STRING COMMENT 'Total number of beneficiaries with non-binary or other gender identities served.',
    `final_budget_amount` DECIMAL(18,2) COMMENT 'Final approved budget amount including all amendments and no-cost extensions, in the programs functional currency.',
    `final_expenditure_amount` DECIMAL(18,2) COMMENT 'Total actual expenditure amount for the program at closeout, in the programs functional currency.',
    `final_financial_reconciliation_status` STRING COMMENT 'Status of the final financial reconciliation process: pending, in progress, reconciled, discrepancies identified, resolved, or audited.. Valid values are `pending|in_progress|reconciled|discrepancies_identified|resolved|audited`',
    `final_report_approval_date` DATE COMMENT 'Date when the final program report was approved by the donor or governing body.',
    `final_report_submission_date` DATE COMMENT 'Date when the final program report was submitted to the donor or governing body.',
    `initiation_date` DATE COMMENT 'Date when the formal closeout process was initiated by the organization.',
    `knowledge_management_outputs` STRING COMMENT 'List and description of knowledge management outputs produced during closeout, including case studies, best practice documents, training materials, and research publications.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this closeout record was last modified or updated.',
    `lessons_learned_summary` STRING COMMENT 'Comprehensive summary of key lessons learned during program implementation, including successes, challenges, and recommendations for future programs.',
    `notes` STRING COMMENT 'Additional notes, comments, or contextual information related to the closeout process, including special circumstances or deviations from standard procedures.',
    `outstanding_obligations_description` STRING COMMENT 'Detailed description of any outstanding financial or contractual obligations that remain at closeout, including amounts and expected resolution dates.',
    `outstanding_obligations_flag` BOOLEAN COMMENT 'Indicates whether there are any outstanding financial or contractual obligations at closeout (True = outstanding obligations exist, False = all obligations settled).',
    `program_end_date` DATE COMMENT 'Actual end date of program operations, which may differ from the original planned end date.',
    `record_retention_end_date` DATE COMMENT 'Date when the record retention period expires and program documentation may be disposed of, typically 3-7 years after closeout per donor and regulatory requirements.',
    CONSTRAINT pk_program_closeout PRIMARY KEY(`program_closeout_id`)
) COMMENT 'SSOT for programmatic closeout activities including final beneficiary counts, lessons learned, knowledge management, and partner signoff. Distinct from grant.grant_closeout which covers financial/compliance closeout at the award level.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`program`.`partner_linkage` (
    `partner_linkage_id` BIGINT COMMENT 'Unique identifier for the program-partner linkage record. Primary key.',
    `intervention_id` BIGINT COMMENT 'Reference to the humanitarian or development program intervention to which this partner is linked.',
    `constituent_id` BIGINT COMMENT 'Foreign key linking to donor.constituent. Business justification: Partner organizations may also be donors/funders. Tracks dual-role relationships where implementing partners are also funding partners. Essential for relationship management, conflict-of-interest trac',
    `partner_org_id` BIGINT COMMENT 'Reference to the implementing partner organization (local NGO, CBO, INGO, government counterpart) assigned to this program.',
    `partner_psea_assessment_id` BIGINT COMMENT 'Foreign key linking to safeguarding.partner_psea_assessment. Business justification: Partnership approval and risk management decisions require direct reference to partner PSEA assessment results. Partner_linkage tracks operational partnership execution (budget, performance, monitorin',
    `partnership_agreement_id` BIGINT COMMENT 'Foreign key linking to partnership.partnership_agreement. Business justification: Partner linkage records must reference the formal partnership agreement governing the relationship for legal compliance, obligation tracking, performance assessment against MOU terms, and dispute reso',
    `system_platform_id` BIGINT COMMENT 'Foreign key linking to technology.system_platform. Business justification: Partner relationships managed in CRM or partnership management platforms (Salesforce, custom partner portals). Tracks capacity assessments, performance data, and compliance documentation. Essential fo',
    `staff_member_id` BIGINT COMMENT 'FK to workforce.staff_member',
    `sanctions_screening_id` BIGINT COMMENT 'Foreign key linking to compliance.sanctions_screening. Business justification: Partners must be screened against sanctions lists before engagement (OFAC, UN, EU sanctions). Essential for nonprofit due diligence and counter-terrorism financing compliance.',
    `beneficiary_reached_count` STRING COMMENT 'Actual number of beneficiaries reached by this partner to date within this program.',
    `beneficiary_target_count` STRING COMMENT 'Target number of beneficiaries this partner is responsible for reaching within this program.',
    `budget_allocated_amount` DECIMAL(18,2) COMMENT 'Total budget amount allocated to this partner for implementation of their scope of work within the program.',
    `budget_currency_code` DECIMAL(18,2) COMMENT 'Three-letter ISO 4217 currency code for the budget allocated amount (e.g., USD, EUR, GBP).',
    `capacity_assessment_date` DATE COMMENT 'Date when the partner capacity assessment was completed or last reviewed.',
    `capacity_assessment_score` DECIMAL(18,2) COMMENT 'Numerical score or rating from the partner capacity assessment (e.g., 0-100 scale or 1-5 rating). Reflects organizational readiness and capability.',
    `capacity_assessment_status` STRING COMMENT 'Status of the partner capacity assessment process required before program implementation (e.g., not started, in progress, completed, approved, conditional approval, failed).. Valid values are `not_started|in_progress|completed|approved|conditional_approval|failed`',
    `capacity_building_required_flag` BOOLEAN COMMENT 'Indicates whether capacity building or technical assistance is required for this partner to successfully implement the program (True/False).',
    `community_based_organization_flag` BOOLEAN COMMENT 'Indicates whether this partner is a community-based organization (CBO) operating at grassroots level (True/False).',
    `compliance_status` STRING COMMENT 'Current compliance status of the partner with donor requirements, regulatory standards, and organizational policies for this program (e.g., compliant, non-compliant, conditional, under review, not assessed).. Valid values are `compliant|non_compliant|conditional|under_review|not_assessed`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this partner linkage record was first created in the system.',
    `end_date` DATE COMMENT 'Planned or actual date when the partners implementation responsibilities for this program conclude.',
    `geographic_scope` STRING COMMENT 'Description of the geographic area or administrative regions where this partner is responsible for program implementation (e.g., specific districts, provinces, or communities).',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this partner linkage record was last updated or modified.',
    `last_monitoring_visit_date` DATE COMMENT 'Date of the most recent field monitoring visit to the partners implementation sites for this program.',
    `last_report_submission_date` DATE COMMENT 'Date when the partner last submitted a progress or financial report for this program.',
    `local_partner_flag` BOOLEAN COMMENT 'Indicates whether this partner is a local or national organization (as opposed to an international organization) (True/False).',
    `monitoring_visit_count` STRING COMMENT 'Total number of field monitoring visits conducted to this partners implementation sites for this program.',
    `notes` STRING COMMENT 'Free-text field for additional notes, observations, or context about this program-partner linkage.',
    `partnership_role` STRING COMMENT 'The functional role the partner organization plays in this program intervention (e.g., lead implementer, sub-grantee, technical partner, government counterpart, consortium member, capacity building partner).. Valid values are `lead_implementer|sub_grantee|technical_partner|government_counterpart|consortium_member|capacity_building_partner`',
    `partnership_status` STRING COMMENT 'Current lifecycle status of the program-partner linkage (e.g., active, pending, suspended, terminated, completed, under review).. Valid values are `active|pending|suspended|terminated|completed|under_review`',
    `partnership_type` STRING COMMENT 'Classification of the partnership arrangement (e.g., direct implementation, sub-award, technical assistance, coordination, joint implementation, government collaboration).. Valid values are `direct_implementation|sub_award|technical_assistance|coordination|joint_implementation|government_collaboration`',
    `performance_rating` STRING COMMENT 'Overall performance rating of the partner for this program implementation (e.g., outstanding, exceeds expectations, meets expectations, needs improvement, unsatisfactory, not rated).. Valid values are `outstanding|exceeds_expectations|meets_expectations|needs_improvement|unsatisfactory|not_rated`',
    `performance_review_date` DATE COMMENT 'Date of the most recent performance review or evaluation of the partners implementation activities.',
    `reporting_frequency` STRING COMMENT 'Required frequency for the partner to submit progress reports for this program (e.g., weekly, biweekly, monthly, quarterly, semi-annual, annual, ad-hoc). [ENUM-REF-CANDIDATE: weekly|biweekly|monthly|quarterly|semi_annual|annual|ad_hoc — 7 candidates stripped; promote to reference product]',
    `risk_rating` STRING COMMENT 'Overall risk rating assigned to this partnership based on capacity assessment, due diligence, and operational context (e.g., low, medium, high, critical).. Valid values are `low|medium|high|critical`',
    `sector_focus` STRING COMMENT 'Primary humanitarian or development sector(s) this partner is responsible for within the program (e.g., WASH, health, nutrition, education, protection, livelihoods). May be multi-sector.',
    `start_date` DATE COMMENT 'Date when the partner officially began implementation activities for this program.',
    `sub_award_reference` STRING COMMENT 'Reference number or identifier of the sub-award agreement if this partnership involves a financial sub-grant. Links to the legal agreement in the partnership domain.',
    `termination_reason` STRING COMMENT 'Explanation or reason for termination if the partnership was ended prematurely (e.g., non-compliance, performance issues, security concerns, mutual agreement).',
    CONSTRAINT pk_partner_linkage PRIMARY KEY(`partner_linkage_id`)
) COMMENT 'Association entity capturing the relationship between a program intervention and its implementing partners (local NGOs, CBOs, INGOs, government counterparts). Stores partner role (lead implementer, sub-grantee, technical partner, government counterpart), partnership type, geographic scope of partnership, capacity assessment status, sub-award reference, start/end dates, and performance rating. Distinct from the partnership domains MoU/LoA/SoW records which own the legal agreement — this product owns the program-specific partner assignment, role definition, and implementation performance tracking for each intervention.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`program`.`review_event` (
    `review_event_id` BIGINT COMMENT 'Unique identifier for the program review, reporting, or learning event. Primary key.',
    `award_id` BIGINT COMMENT 'Reference to the grant funding this program, if the review event is tied to donor reporting requirements.',
    `intervention_id` BIGINT COMMENT 'Reference to the program or intervention being reviewed or reported on.',
    `partnership_agreement_id` BIGINT COMMENT 'Foreign key linking to partnership.partnership_agreement. Business justification: Program review events for partner-implemented interventions must reference the partnership agreement to assess compliance with MOU obligations, deliverable achievement, reporting requirements, and per',
    `regulatory_filing_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_filing. Business justification: Program reviews (mid-term evaluations, final evaluations, donor progress reports) are submitted as regulatory filings. Essential for tracking donor reporting compliance and evaluation dissemination re',
    `system_platform_id` BIGINT COMMENT 'Foreign key linking to technology.system_platform. Business justification: Program reviews submitted through specific donor portals or M&E platforms (e.g., IATI Registry, donor-specific reporting systems). Critical for compliance, submission tracking, and access management. ',
    `approval_date` DATE COMMENT 'Date the review event or report was formally approved by the designated authority.',
    `approved_by_name` STRING COMMENT 'Name of the individual or role who formally approved this review event or report.',
    `beneficiary_reach_children` BIGINT COMMENT 'Number of children (under 18) reached during the reporting period.',
    `beneficiary_reach_female` BIGINT COMMENT 'Number of female beneficiaries reached during the reporting period.',
    `beneficiary_reach_male` BIGINT COMMENT 'Number of male beneficiaries reached during the reporting period.',
    `beneficiary_reach_total` DECIMAL(18,2) COMMENT 'Total number of beneficiaries reached during the reporting period, as reported in this review event.',
    `challenges_narrative` STRING COMMENT 'Narrative description of challenges, constraints, and obstacles encountered during the reporting period.',
    `chs_compliance_flag` BOOLEAN COMMENT 'Indicates whether this review event assessed or confirmed compliance with the Core Humanitarian Standard.',
    `cluster_submission_flag` BOOLEAN COMMENT 'Indicates whether this report was submitted to a humanitarian cluster coordination mechanism (e.g., WASH cluster, Health cluster).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this review event record was first created in the system.',
    `dissemination_date` DATE COMMENT 'Date the report or learning output was published or disseminated to stakeholders.',
    `document_url` STRING COMMENT 'URL or file path to the full review report or learning document stored in the document management system.',
    `donor_visibility_flag` BOOLEAN COMMENT 'Indicates whether this review event or report is intended for donor visibility and external dissemination.',
    `event_code` STRING COMMENT 'Business identifier or reference code for the review event, often used in donor correspondence and internal tracking systems.. Valid values are `^[A-Z0-9_-]{3,20}$`',
    `event_status` STRING COMMENT 'Current lifecycle status of the review event or report. Tracks progression from draft through submission, approval, and dissemination. [ENUM-REF-CANDIDATE: draft|in_progress|submitted|under_review|approved|published|archived|cancelled — 8 candidates stripped; promote to reference product]',
    `event_type` STRING COMMENT 'Classification of the review or reporting event. Includes formal reviews (mid-term, annual, after-action, donor missions), periodic reports (quarterly, semi-annual, annual, final, SitRep, flash), and structured learning outputs (lessons learned, best practices, innovations, failure analyses). [ENUM-REF-CANDIDATE: mid_term_review|annual_review|after_action_review|donor_review_mission|quarterly_progress_report|semi_annual_report|annual_report|final_report|sitrep|flash_report|lessons_learned|best_practice_documentation|innovation_case_study|failure_analysis — 14 candidates stripped; promote to reference product]',
    `executive_summary` STRING COMMENT 'High-level summary of the review event or report, capturing key messages for senior management and donors.',
    `financial_summary_budget_amount` DECIMAL(18,2) COMMENT 'Total budget allocated for the program or grant during the reporting period.',
    `financial_summary_currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for the financial figures reported in this review event.. Valid values are `^[A-Z]{3}$`',
    `financial_summary_expenditure_amount` DECIMAL(18,2) COMMENT 'Total expenditure incurred during the reporting period, as reported in this review event.',
    `follow_up_actions` STRING COMMENT 'List or narrative of follow-up actions agreed upon in response to the review findings and recommendations.',
    `key_findings` STRING COMMENT 'Summary of the key findings from the review, assessment, or reporting period. Captures evidence-based observations.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this review event record was last updated.',
    `lead_author_name` STRING COMMENT 'Name of the primary author or team lead responsible for preparing the review or report.',
    `lessons_learned_summary` STRING COMMENT 'Summary of lessons learned during the reporting period or review, intended to inform future programming and organizational learning.',
    `management_response` STRING COMMENT 'Formal response from program management to the findings and recommendations, including acceptance, rejection, or modification of recommendations.',
    `notes` STRING COMMENT 'Additional notes, comments, or context related to this review event.',
    `progress_narrative` STRING COMMENT 'Detailed narrative describing progress against planned outputs, outcomes, and activities during the reporting period.',
    `recommendations` STRING COMMENT 'List or narrative of recommendations arising from the review or report, intended to inform future program design and implementation.',
    `reporting_period_end_date` DATE COMMENT 'End date of the period covered by this review or report.',
    `reporting_period_start_date` DATE COMMENT 'Start date of the period covered by this review or report.',
    `review_date` DATE COMMENT 'The date on which the review event or mission took place, or the date the report was finalized. Represents the principal business event timestamp for this record.',
    `review_team_members` STRING COMMENT 'Comma-separated list or narrative description of the review team members or contributors.',
    `scope_description` STRING COMMENT 'Narrative description of the scope of the review or report, including geographic areas, program components, and thematic focus.',
    `sphere_standards_applied_flag` BOOLEAN COMMENT 'Indicates whether Sphere Humanitarian Charter and Minimum Standards were applied or assessed in this review event.',
    `submission_date` DATE COMMENT 'Date the report or review findings were formally submitted to the intended audience (donor, management, cluster).',
    CONSTRAINT pk_review_event PRIMARY KEY(`review_event_id`)
) COMMENT 'Unified record for all formal program review, reporting, and learning events including mid-term reviews, annual reviews, after-action reviews, donor review missions, progress reports (quarterly, semi-annual, annual, final, SitRep, flash report), and structured learning outputs (lessons learned, best practices, innovations, failure analyses). Captures event/report type, reporting period, date range, review team/author, scope, key findings, narrative sections (progress against outputs, challenges, beneficiary reach figures, financial summary), recommendations, management response, follow-up actions, submission date, submission status, approval workflow, and dissemination status. Serves as the SSOT for all program knowledge events, donor/cluster reporting submissions, and internal governance reporting. Distinct from MEL domain evaluations (which own evaluation methodology, TOR, and evaluator management) — this product owns the program management reporting and review lifecycle.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`program`.`program_partnership` (
    `program_partnership_id` BIGINT COMMENT 'Primary key for the partnership association',
    `intervention_id` BIGINT COMMENT 'Foreign key linking to the intervention that this partnership supports',
    `partner_org_id` BIGINT COMMENT 'Foreign key linking to the partner organization participating in this intervention',
    `beneficiary_target_count` STRING COMMENT 'Number of beneficiaries this partner is responsible for reaching within this intervention. Sum of all partner beneficiary targets should equal the interventions total target beneficiary count.',
    `budget_allocated_amount` DECIMAL(18,2) COMMENT 'Total budget amount allocated to this partner for their scope of work in this intervention. Sum of all partner budget allocations should equal or be less than the interventions total budget.',
    `capacity_assessment_status` STRING COMMENT 'Result of the capacity assessment conducted specifically for this partners role in this intervention. May differ from the partners general organizational capacity assessment.',
    `compliance_status` STRING COMMENT 'Current compliance status of this partner for this intervention against contractual obligations, donor regulations, and organizational policies. Tracks whether the partner is meeting reporting, financial, and programmatic requirements.',
    `end_date` DATE COMMENT 'Date when this partner completed or will complete their scope of work for this intervention. May differ from the interventions overall end date if partners have staggered timelines.',
    `geographic_scope` STRING COMMENT 'Specific geographic area (region, district, or community) where this partner is responsible for implementing activities within the broader intervention geography. Allows multiple partners to cover different areas of the same intervention.',
    `ip_transfer_modality` STRING COMMENT 'HACT IP transfer modality: Direct Cash Transfer / Reimbursement / Direct Payment',
    `partnership_role` STRING COMMENT 'The specific role this partner plays in the intervention (e.g., Lead Implementer, Sub-Recipient, Technical Partner, Local CBO, Consortium Member). Defines the partners primary responsibility and authority level.',
    `partnership_status` STRING COMMENT 'Current lifecycle status of this specific partnership arrangement within the intervention. Tracks whether the partner is actively implementing, suspended due to performance issues, or completed their scope of work.',
    `partnership_type` STRING COMMENT 'Classification of the partnership arrangement type (e.g., Direct Implementation, Sub-Award, Technical Assistance, Capacity Building, Coordination). Determines reporting and compliance requirements.',
    `performance_rating` STRING COMMENT 'Performance assessment rating for this partners work on this specific intervention. Based on delivery against milestones, budget utilization, reporting quality, and beneficiary feedback.',
    `reporting_frequency` STRING COMMENT 'Required frequency for this partner to submit progress reports for this intervention. Determined by risk rating, budget size, and donor requirements.',
    `risk_rating` STRING COMMENT 'Risk level assigned to this specific partnership based on partner capacity, geographic context, budget size, and intervention complexity. Determines oversight and monitoring intensity.',
    `sector_focus` STRING COMMENT 'Specific sector or sub-sector within the intervention that this partner is responsible for. Relevant for multi-sectoral interventions where different partners handle different technical areas (e.g., one partner for WASH, another for nutrition).',
    `start_date` DATE COMMENT 'Date when this partner began implementation activities for this intervention. May differ from the interventions overall start date if partners were phased in.',
    `sub_award_reference` STRING COMMENT 'Unique reference number for the sub-award agreement or MoU governing this partnership. Links to legal/contractual documentation.',
    CONSTRAINT pk_program_partnership PRIMARY KEY(`program_partnership_id`)
) COMMENT 'This association product represents the formal partnership agreement between a humanitarian/development intervention and a partner organization. It captures the specific role, responsibilities, budget allocation, performance metrics, and compliance status for each partners involvement in each intervention. Each record links one intervention to one partner organization with attributes that exist only in the context of this specific partnership arrangement.. Existence Justification: In nonprofit humanitarian operations, interventions are routinely implemented through multi-partner consortia where a single intervention engages multiple partner organizations (lead implementer, sub-recipients, local CBOs, technical specialists) each with distinct roles, geographic coverage, and budget allocations. Simultaneously, established partner organizations implement multiple interventions across different sectors and geographies. The partnership arrangement itself is an operational business entity that program managers actively create, monitor, and close out, with specific attributes like role, budget allocation, performance rating, compliance status, and risk assessment that belong to neither the intervention nor the partner organization alone.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`program`.`intervention_compliance` (
    `intervention_compliance_id` BIGINT COMMENT 'Unique identifier for this intervention-specific compliance obligation record. Primary key.',
    `donor_requirement_id` BIGINT COMMENT 'Foreign key linking to the specific donor compliance requirement that applies to this intervention',
    `intervention_id` BIGINT COMMENT 'Foreign key linking to the humanitarian intervention that must fulfill this compliance requirement',
    `staff_member_id` BIGINT COMMENT 'Reference to the staff member assigned primary responsibility for ensuring compliance with this requirement for this specific intervention. May differ from the general staff_member_id in donor_requirement if intervention-specific ownership applies.',
    `actual_effort_hours` DECIMAL(18,2) COMMENT 'The actual number of staff hours expended in fulfilling this compliance requirement for this specific intervention.',
    `approval_date` DATE COMMENT 'The date on which the donor formally approved or accepted the compliance submission for this intervention.',
    `associated_cost_amount` DECIMAL(18,2) COMMENT 'The direct financial cost incurred to fulfill this compliance requirement for this specific intervention (e.g., audit fees, consultant costs, translation services).',
    `cost_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the associated cost amount.',
    `created_date` TIMESTAMP COMMENT 'Timestamp when this intervention-compliance obligation record was created in the system.',
    `deliverable_format` STRING COMMENT 'The required format or medium for the compliance deliverable for this intervention (e.g., PDF report, Excel workbook, online portal submission).',
    `due_date` DATE COMMENT 'The date by which this compliance requirement must be fulfilled for this specific intervention. May differ from the general due_date in donor_requirement if intervention-specific extensions or schedules apply.',
    `last_modified_date` TIMESTAMP COMMENT 'Timestamp when this intervention-compliance obligation record was last updated.',
    `notes` STRING COMMENT 'Additional free-text notes, comments, or context related to this compliance requirement for this specific intervention.',
    `requirement_status` STRING COMMENT 'Current status of compliance with this specific requirement for this specific intervention. Tracks the intervention-specific compliance state, distinct from the general requirement status in donor_requirement.',
    `submission_date` DATE COMMENT 'The actual date on which the compliance deliverable for this intervention was submitted to the donor.',
    `waiver_granted_flag` BOOLEAN COMMENT 'Indicates whether the donor has approved a waiver or exemption for this compliance requirement specifically for this intervention.',
    `waiver_justification` STRING COMMENT 'The rationale or explanation provided for requesting a waiver from this compliance requirement for this specific intervention.',
    CONSTRAINT pk_intervention_compliance PRIMARY KEY(`intervention_compliance_id`)
) COMMENT 'This association product represents the compliance obligation between a humanitarian intervention and a specific donor requirement. It captures the requirement-specific compliance status, deadlines, submission tracking, and responsible staff for each intervention-requirement pair. Each record links one intervention to one donor compliance requirement with attributes that exist only in the context of this specific compliance obligation.. Existence Justification: In nonprofit grant management, a single humanitarian intervention (e.g., a WASH program) must fulfill multiple donor compliance requirements (quarterly narrative reports, financial statements, evaluations, audit submissions) imposed by one or more institutional donors funding that intervention. Conversely, a single donor compliance requirement type (e.g., quarterly narrative report format) applies to multiple interventions funded by that donor. Compliance teams actively manage each intervention-requirement pair with specific deadlines, submission tracking, approval status, responsible staff assignments, and waiver requests.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`program`.`component_indicator` (
    `component_indicator_id` BIGINT COMMENT 'Unique identifier for this component-indicator assignment. Primary key.',
    `component_id` BIGINT COMMENT 'Foreign key linking to the program component being measured',
    `indicator_id` BIGINT COMMENT 'Foreign key linking to the MEL indicator used for measurement',
    `assignment_date` DATE COMMENT 'The date when this indicator was assigned to this component for monitoring. Tracks when the measurement relationship was established.',
    `baseline_value` DECIMAL(18,2) COMMENT 'The baseline value for this indicator measured at the start of this component. Component-level baselines may differ from program-level baselines due to geographic or population differences.',
    `component_indicator_status` STRING COMMENT 'Current status of this component-indicator assignment. Indicates whether this indicator is actively being measured for this component.',
    `data_collection_method` STRING COMMENT 'The specific data collection method used for this indicator within this component (e.g., household survey, facility assessment, DHIS2 extraction, beneficiary registration). May differ from the indicator master method based on component context and available systems.',
    `is_mandatory` BOOLEAN COMMENT 'Indicates whether this indicator is mandatory for this component due to donor requirements, grant agreements, or regulatory compliance.',
    `logframe_reference` STRING COMMENT 'Reference to the specific output, outcome, or result in the components LogFrame that this indicator measures. Links the indicator to the components theory of change.',
    `notes` STRING COMMENT 'Free-text notes about this specific component-indicator assignment, including context, challenges, or special considerations for measurement.',
    `reporting_frequency` STRING COMMENT 'How often this indicator must be reported for this specific component. May differ from the indicator master reporting frequency based on donor requirements or component risk level.',
    `responsible_unit` STRING COMMENT 'The organizational unit, team, or field office responsible for collecting and reporting data for this indicator within this component. Assigns accountability at the component level.',
    `target_value` DECIMAL(18,2) COMMENT 'The target value for this indicator specific to this component. May differ from the program-level or indicator master target because each component contributes differently to overall program goals.',
    CONSTRAINT pk_component_indicator PRIMARY KEY(`component_indicator_id`)
) COMMENT 'This association product represents the assignment of MEL indicators to program components for monitoring and evaluation purposes. It captures component-specific measurement targets, baselines, data collection methods, and reporting responsibilities that exist only in the context of a specific component-indicator pairing. Each record links one program component to one indicator with the specific measurement parameters for that component.. Existence Justification: In nonprofit program management, program components (e.g., WASH water supply, sanitation, hygiene promotion sub-components) are each measured by multiple MEL indicators, and indicators (especially cross-cutting ones like gender equality markers, safeguarding compliance, beneficiary satisfaction) apply across multiple components. MEL teams actively manage the component-indicator matrix in LogFrames, setting component-specific targets, baselines, and data collection methods for each pairing. This is the operational reality of results-based management in the nonprofit sector.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`program`.`component_system_usage` (
    `component_system_usage_id` BIGINT COMMENT 'Unique identifier for this component-system usage relationship. Primary key.',
    `component_id` BIGINT COMMENT 'Foreign key linking to the program component that uses this system platform',
    `system_platform_id` BIGINT COMMENT 'Foreign key linking to the system platform used by this component',
    `activation_date` DATE COMMENT 'Date when this system was activated for use by this component. Tracks the start of the usage relationship. Explicitly identified in detection phase.',
    `component_system_role` STRING COMMENT 'The functional role this system plays for this specific component (e.g., Data Collection for KoboToolbox in a WASH component, Beneficiary Management for Salesforce in a cash transfer component). Explicitly identified in detection phase.',
    `data_classification_level` STRING COMMENT 'The highest data classification level of information that this component stores or processes in this specific system. May vary by component-system combination (e.g., a health component may store PII in DHIS2 while an infrastructure component stores only public data in the same system). Explicitly identified in detection phase.',
    `deactivation_date` DATE COMMENT 'Date when this system was deactivated or stopped being used by this component. Null if still active. Tracks the end of the usage relationship. Explicitly identified in detection phase.',
    `integration_required_flag` BOOLEAN COMMENT 'Indicates whether this component requires data integration or synchronization between this system and other systems in the components technology stack.',
    `notes` STRING COMMENT 'Free-text notes about this component-system usage relationship, including special configurations, access restrictions, or usage patterns.',
    `primary_contact` STRING COMMENT 'Name or identifier of the individual responsible for managing this system usage for this component (e.g., component MEL officer, data focal point).',
    `usage_status` STRING COMMENT 'Current status of this component-system usage relationship (Active, Inactive, Pilot, Sunset, Decommissioned). Tracks the lifecycle of the usage relationship independently from the component or system status.',
    `user_access_count` STRING COMMENT 'Number of users from this component team who have active access to this system platform. Tracks component-specific system access provisioning. Explicitly identified in detection phase.',
    CONSTRAINT pk_component_system_usage PRIMARY KEY(`component_system_usage_id`)
) COMMENT 'This association product represents the operational usage relationship between program components and digital platforms. It captures which systems are actively used to deliver, monitor, or report on specific program components, including the functional role of each system, access permissions, and usage lifecycle dates. Each record links one component to one system platform with attributes that exist only in the context of this operational usage relationship.. Existence Justification: In NGO operations, program components routinely use multiple specialized digital systems simultaneously (e.g., a health component uses DHIS2 for health data, KoboToolbox for field surveys, and Salesforce for beneficiary tracking). Conversely, enterprise systems like Salesforce or DHIS2 serve multiple components across different programs and sectors. The business actively manages these usage relationships, tracking which systems support which components, provisioning access for component teams, and managing activation/deactivation as components evolve.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`program`.`program` (
    `program_id` BIGINT COMMENT 'Primary key for program',
    `constituent_id` BIGINT COMMENT 'Identifier of the primary donor or funding organization for this program.',
    `country_office_id` BIGINT COMMENT 'Foreign key to field.country_office',
    `country_programme_document_id` BIGINT COMMENT 'FK to the Country Programme Document this program belongs to.',
    `humanitarian_response_plan_id` BIGINT COMMENT 'Identifier linking the program to a coordinated Humanitarian Response Plan or Flash Appeal.',
    `intervention_id` BIGINT COMMENT 'Connect program.program by adding column intervention_id (BIGINT) with FK to program.intervention.intervention_id because program is completely isolated. P2: connect_table: program.program** - add column intervention_id (BIGINT) with FK to ',
    `parent_program_id` BIGINT COMMENT 'Identifier of the parent program if this program is part of a larger program hierarchy or portfolio.',
    `partner_org_id` BIGINT COMMENT 'Identifier of the primary implementing partner organization responsible for program execution.',
    `primary_staff_member_id` BIGINT COMMENT 'Identifier of the staff member responsible for overall program management and accountability.',
    `staff_member_id` BIGINT COMMENT 'Foreign key to workforce.staff_member',
    `strategic_plan_goal_area_id` BIGINT COMMENT 'FK to the Strategic Plan goal area this program aligns to.',
    `unsdcf_outcome_id` BIGINT COMMENT 'FK to the UNSDCF outcome this program contributes to.',
    `approval_date` DATE COMMENT 'Date when the program proposal was formally approved by internal governance or donor.',
    `budget_amount` DECIMAL(18,2) COMMENT 'Total approved budget for the program across all funding sources in the programs base currency.',
    `budget_currency` DECIMAL(18,2) COMMENT 'Three-letter ISO 4217 currency code for the program budget.',
    `closeout_date` DATE COMMENT 'Date when all program activities, financial reconciliation, and final reporting were completed.',
    `cluster_code` STRING COMMENT 'Code identifying the humanitarian cluster or sector coordination mechanism the program is aligned with (e.g., WASH, Health, Protection).',
    `program_code` STRING COMMENT 'Externally-known unique alphanumeric code assigned to the program for identification across systems and donor reporting.',
    `compliance_status` STRING COMMENT 'Current compliance standing with donor requirements, regulatory obligations, and internal policies.',
    `country_code` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 code for the primary country of program implementation.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the program record was first created in the system.',
    `program_description` STRING COMMENT 'Comprehensive narrative describing the programs objectives, scope, target population, and expected outcomes.',
    `end_date` DATE COMMENT 'Planned or actual end date when program activities conclude and closeout begins.',
    `geographic_scope` STRING COMMENT 'Spatial scale of program implementation indicating coverage area.',
    `grant_number` STRING COMMENT 'Unique grant or award number assigned by the donor for tracking and reporting purposes.',
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
) COMMENT 'Master reference table for program. Referenced by program_id. Systems-of-record: eTools, InSight, SAP PS (Project System). IATI Organisation Standard alignment. Links to CPD/UNSDCF outcomes.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`program`.`country_programme_document` (
    `country_programme_document_id` BIGINT COMMENT 'Primary key',
    `country_id` BIGINT COMMENT 'FK to field.country',
    `strategic_plan_goal_area_id` BIGINT COMMENT 'FK to strategic plan goal area',
    `approval_date` DATE COMMENT 'Date CPD was approved by Executive Board',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `cycle_end_date` DATE COMMENT 'End date of the programme cycle',
    `cycle_start_date` DATE COMMENT 'Start date of the programme cycle',
    `document_reference_number` STRING COMMENT 'Count or number of document reference items associated with this record.',
    `executive_board_session` STRING COMMENT 'Executive Board session reference',
    `extension_end_date` DATE COMMENT 'Extension end date if CPD extended',
    `mid_term_review_date` DATE COMMENT 'Mid-term review date',
    `other_resources_amount` DECIMAL(18,2) COMMENT 'Other resources budget amount',
    `regular_resources_amount` DECIMAL(18,2) COMMENT 'Regular resources budget amount',
    `country_programme_document_status` STRING COMMENT 'Draft / Approved / Active / Closed',
    `total_budget_amount` DECIMAL(18,2) COMMENT 'Total indicative budget',
    `unsdcf_signed_date` DATE COMMENT 'Date UNSDCF was signed',
    `updated_timestamp` TIMESTAMP COMMENT 'Record last update timestamp',
    CONSTRAINT pk_country_programme_document PRIMARY KEY(`country_programme_document_id`)
) COMMENT 'Country Programme Document (CPD) representing the multi-year agreement between a UN agency and a host government, defining programme outcomes, resource requirements, and results frameworks aligned to the UNSDCF. Source systems: eTools, InSight, VISION.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`program`.`unsdcf_outcome` (
    `unsdcf_outcome_id` BIGINT COMMENT 'Primary key',
    `country_id` BIGINT COMMENT 'FK to field.country',
    `country_programme_document_id` BIGINT COMMENT 'FK to country programme document',
    `strategic_plan_goal_area_id` BIGINT COMMENT 'FK to strategic plan goal area',
    `baseline_year` STRING COMMENT 'Attribute capturing the baseline year information for the unsdcf outcome entity.',
    `contributing_agencies` STRING COMMENT 'Contributing UN agencies',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `national_priority_reference` STRING COMMENT 'Attribute capturing the national priority reference information for the unsdcf outcome entity.',
    `outcome_code` STRING COMMENT 'Outcome sequence code',
    `outcome_statement` STRING COMMENT 'Attribute capturing the outcome statement information for the unsdcf outcome entity.',
    `sdg_goal_number` STRING COMMENT 'SDG goal number (1-17)',
    `sdg_target_code` STRING COMMENT 'SDG target code (e.g., 3.1, 4.a)',
    `unsdcf_outcome_status` STRING COMMENT 'Active / Closed',
    `target_year` STRING COMMENT 'Attribute capturing the target year information for the unsdcf outcome entity.',
    `updated_timestamp` TIMESTAMP COMMENT 'Record last update timestamp',
    CONSTRAINT pk_unsdcf_outcome PRIMARY KEY(`unsdcf_outcome_id`)
) COMMENT 'United Nations Sustainable Development Cooperation Framework (UNSDCF) outcome representing a high-level national development result that the UN Country Team collectively contributes to. Replaces the former UNDAF outcome. Source systems: UN INFO, eTools.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`program`.`strategic_plan_goal_area` (
    `strategic_plan_goal_area_id` BIGINT COMMENT 'Primary key',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `strategic_plan_goal_area_description` STRING COMMENT 'Narrative description of the goal area',
    `goal_area_code` STRING COMMENT 'Short code',
    `goal_area_name` STRING COMMENT 'Goal area name (e.g., Survive and Thrive)',
    `outcome_count` STRING COMMENT 'Number of outcomes under this goal area',
    `sdg_alignment` STRING COMMENT 'Primary SDG goals aligned (e.g., SDG 3, SDG 4)',
    `strategic_plan_period` STRING COMMENT 'Strategic plan period (e.g., 2022-2025)',
    `updated_timestamp` TIMESTAMP COMMENT 'Record last update timestamp',
    CONSTRAINT pk_strategic_plan_goal_area PRIMARY KEY(`strategic_plan_goal_area_id`)
) COMMENT 'Strategic Plan Goal Area representing the top-level thematic priorities of a UN agency strategic plan (e.g., UNICEF Strategic Plan 2022-2025 Goal Areas: Survive and Thrive, Learn, Protection, Safe and Clean Environment, Equitable Chance in Life). Source systems: VISION, InSight.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`program`.`humanitarian_response_plan` (
    `humanitarian_response_plan_id` BIGINT COMMENT 'Primary key',
    `country_id` BIGINT COMMENT 'FK to field.country',
    `emergency_id` BIGINT COMMENT 'FK to field.emergency',
    `approval_date` DATE COMMENT 'Date HRP was published/approved',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `people_in_need` BIGINT COMMENT 'Estimated people in need',
    `people_targeted` BIGINT COMMENT 'People targeted for assistance',
    `plan_title` STRING COMMENT 'Attribute capturing the plan title information for the humanitarian response plan entity.',
    `plan_year` STRING COMMENT 'Year of the HRP',
    `humanitarian_response_plan_status` STRING COMMENT 'Draft / Published / Revised / Closed',
    `total_funded_usd` DECIMAL(18,2) COMMENT 'Total funding received in USD',
    `total_requirements_usd` DECIMAL(18,2) COMMENT 'Total funding requirements in USD',
    `updated_timestamp` TIMESTAMP COMMENT 'Record last update timestamp',
    CONSTRAINT pk_humanitarian_response_plan PRIMARY KEY(`humanitarian_response_plan_id`)
) COMMENT 'Humanitarian Response Plan (HRP) for coordinated emergency response';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_ngo_v1`.`program`.`intervention` ADD CONSTRAINT `fk_program_intervention_country_programme_document_id` FOREIGN KEY (`country_programme_document_id`) REFERENCES `vibe_ngo_v1`.`program`.`country_programme_document`(`country_programme_document_id`);
ALTER TABLE `vibe_ngo_v1`.`program`.`intervention` ADD CONSTRAINT `fk_program_intervention_humanitarian_response_plan_id` FOREIGN KEY (`humanitarian_response_plan_id`) REFERENCES `vibe_ngo_v1`.`program`.`humanitarian_response_plan`(`humanitarian_response_plan_id`);
ALTER TABLE `vibe_ngo_v1`.`program`.`intervention` ADD CONSTRAINT `fk_program_intervention_strategic_plan_goal_area_id` FOREIGN KEY (`strategic_plan_goal_area_id`) REFERENCES `vibe_ngo_v1`.`program`.`strategic_plan_goal_area`(`strategic_plan_goal_area_id`);
ALTER TABLE `vibe_ngo_v1`.`program`.`intervention` ADD CONSTRAINT `fk_program_intervention_unsdcf_outcome_id` FOREIGN KEY (`unsdcf_outcome_id`) REFERENCES `vibe_ngo_v1`.`program`.`unsdcf_outcome`(`unsdcf_outcome_id`);
ALTER TABLE `vibe_ngo_v1`.`program`.`intervention` ADD CONSTRAINT `fk_program_intervention_program_id` FOREIGN KEY (`program_id`) REFERENCES `vibe_ngo_v1`.`program`.`program`(`program_id`);
ALTER TABLE `vibe_ngo_v1`.`program`.`theory_of_change` ADD CONSTRAINT `fk_program_theory_of_change_intervention_id` FOREIGN KEY (`intervention_id`) REFERENCES `vibe_ngo_v1`.`program`.`intervention`(`intervention_id`);
ALTER TABLE `vibe_ngo_v1`.`program`.`program_logframe` ADD CONSTRAINT `fk_program_program_logframe_intervention_id` FOREIGN KEY (`intervention_id`) REFERENCES `vibe_ngo_v1`.`program`.`intervention`(`intervention_id`);
ALTER TABLE `vibe_ngo_v1`.`program`.`logframe_row` ADD CONSTRAINT `fk_program_logframe_row_intervention_id` FOREIGN KEY (`intervention_id`) REFERENCES `vibe_ngo_v1`.`program`.`intervention`(`intervention_id`);
ALTER TABLE `vibe_ngo_v1`.`program`.`logframe_row` ADD CONSTRAINT `fk_program_logframe_row_parent_result_logframe_row_id` FOREIGN KEY (`parent_result_logframe_row_id`) REFERENCES `vibe_ngo_v1`.`program`.`logframe_row`(`logframe_row_id`);
ALTER TABLE `vibe_ngo_v1`.`program`.`logframe_row` ADD CONSTRAINT `fk_program_logframe_row_program_logframe_id` FOREIGN KEY (`program_logframe_id`) REFERENCES `vibe_ngo_v1`.`program`.`program_logframe`(`program_logframe_id`);
ALTER TABLE `vibe_ngo_v1`.`program`.`component` ADD CONSTRAINT `fk_program_component_intervention_id` FOREIGN KEY (`intervention_id`) REFERENCES `vibe_ngo_v1`.`program`.`intervention`(`intervention_id`);
ALTER TABLE `vibe_ngo_v1`.`program`.`component` ADD CONSTRAINT `fk_program_component_parent_component_id` FOREIGN KEY (`parent_component_id`) REFERENCES `vibe_ngo_v1`.`program`.`component`(`component_id`);
ALTER TABLE `vibe_ngo_v1`.`program`.`target_population` ADD CONSTRAINT `fk_program_target_population_intervention_id` FOREIGN KEY (`intervention_id`) REFERENCES `vibe_ngo_v1`.`program`.`intervention`(`intervention_id`);
ALTER TABLE `vibe_ngo_v1`.`program`.`program_amendment` ADD CONSTRAINT `fk_program_program_amendment_intervention_id` FOREIGN KEY (`intervention_id`) REFERENCES `vibe_ngo_v1`.`program`.`intervention`(`intervention_id`);
ALTER TABLE `vibe_ngo_v1`.`program`.`design_assessment` ADD CONSTRAINT `fk_program_design_assessment_intervention_id` FOREIGN KEY (`intervention_id`) REFERENCES `vibe_ngo_v1`.`program`.`intervention`(`intervention_id`);
ALTER TABLE `vibe_ngo_v1`.`program`.`risk_register` ADD CONSTRAINT `fk_program_risk_register_intervention_id` FOREIGN KEY (`intervention_id`) REFERENCES `vibe_ngo_v1`.`program`.`intervention`(`intervention_id`);
ALTER TABLE `vibe_ngo_v1`.`program`.`implementation_plan` ADD CONSTRAINT `fk_program_implementation_plan_intervention_id` FOREIGN KEY (`intervention_id`) REFERENCES `vibe_ngo_v1`.`program`.`intervention`(`intervention_id`);
ALTER TABLE `vibe_ngo_v1`.`program`.`budget_plan` ADD CONSTRAINT `fk_program_budget_plan_intervention_id` FOREIGN KEY (`intervention_id`) REFERENCES `vibe_ngo_v1`.`program`.`intervention`(`intervention_id`);
ALTER TABLE `vibe_ngo_v1`.`program`.`budget_plan_line` ADD CONSTRAINT `fk_program_budget_plan_line_budget_plan_id` FOREIGN KEY (`budget_plan_id`) REFERENCES `vibe_ngo_v1`.`program`.`budget_plan`(`budget_plan_id`);
ALTER TABLE `vibe_ngo_v1`.`program`.`budget_plan_line` ADD CONSTRAINT `fk_program_budget_plan_line_intervention_id` FOREIGN KEY (`intervention_id`) REFERENCES `vibe_ngo_v1`.`program`.`intervention`(`intervention_id`);
ALTER TABLE `vibe_ngo_v1`.`program`.`program_closeout` ADD CONSTRAINT `fk_program_program_closeout_intervention_id` FOREIGN KEY (`intervention_id`) REFERENCES `vibe_ngo_v1`.`program`.`intervention`(`intervention_id`);
ALTER TABLE `vibe_ngo_v1`.`program`.`partner_linkage` ADD CONSTRAINT `fk_program_partner_linkage_intervention_id` FOREIGN KEY (`intervention_id`) REFERENCES `vibe_ngo_v1`.`program`.`intervention`(`intervention_id`);
ALTER TABLE `vibe_ngo_v1`.`program`.`review_event` ADD CONSTRAINT `fk_program_review_event_intervention_id` FOREIGN KEY (`intervention_id`) REFERENCES `vibe_ngo_v1`.`program`.`intervention`(`intervention_id`);
ALTER TABLE `vibe_ngo_v1`.`program`.`program_partnership` ADD CONSTRAINT `fk_program_program_partnership_intervention_id` FOREIGN KEY (`intervention_id`) REFERENCES `vibe_ngo_v1`.`program`.`intervention`(`intervention_id`);
ALTER TABLE `vibe_ngo_v1`.`program`.`intervention_compliance` ADD CONSTRAINT `fk_program_intervention_compliance_intervention_id` FOREIGN KEY (`intervention_id`) REFERENCES `vibe_ngo_v1`.`program`.`intervention`(`intervention_id`);
ALTER TABLE `vibe_ngo_v1`.`program`.`component_indicator` ADD CONSTRAINT `fk_program_component_indicator_component_id` FOREIGN KEY (`component_id`) REFERENCES `vibe_ngo_v1`.`program`.`component`(`component_id`);
ALTER TABLE `vibe_ngo_v1`.`program`.`component_system_usage` ADD CONSTRAINT `fk_program_component_system_usage_component_id` FOREIGN KEY (`component_id`) REFERENCES `vibe_ngo_v1`.`program`.`component`(`component_id`);
ALTER TABLE `vibe_ngo_v1`.`program`.`program` ADD CONSTRAINT `fk_program_program_country_programme_document_id` FOREIGN KEY (`country_programme_document_id`) REFERENCES `vibe_ngo_v1`.`program`.`country_programme_document`(`country_programme_document_id`);
ALTER TABLE `vibe_ngo_v1`.`program`.`program` ADD CONSTRAINT `fk_program_program_humanitarian_response_plan_id` FOREIGN KEY (`humanitarian_response_plan_id`) REFERENCES `vibe_ngo_v1`.`program`.`humanitarian_response_plan`(`humanitarian_response_plan_id`);
ALTER TABLE `vibe_ngo_v1`.`program`.`program` ADD CONSTRAINT `fk_program_program_intervention_id` FOREIGN KEY (`intervention_id`) REFERENCES `vibe_ngo_v1`.`program`.`intervention`(`intervention_id`);
ALTER TABLE `vibe_ngo_v1`.`program`.`program` ADD CONSTRAINT `fk_program_program_parent_program_id` FOREIGN KEY (`parent_program_id`) REFERENCES `vibe_ngo_v1`.`program`.`program`(`program_id`);
ALTER TABLE `vibe_ngo_v1`.`program`.`program` ADD CONSTRAINT `fk_program_program_strategic_plan_goal_area_id` FOREIGN KEY (`strategic_plan_goal_area_id`) REFERENCES `vibe_ngo_v1`.`program`.`strategic_plan_goal_area`(`strategic_plan_goal_area_id`);
ALTER TABLE `vibe_ngo_v1`.`program`.`program` ADD CONSTRAINT `fk_program_program_unsdcf_outcome_id` FOREIGN KEY (`unsdcf_outcome_id`) REFERENCES `vibe_ngo_v1`.`program`.`unsdcf_outcome`(`unsdcf_outcome_id`);
ALTER TABLE `vibe_ngo_v1`.`program`.`country_programme_document` ADD CONSTRAINT `fk_program_country_programme_document_strategic_plan_goal_area_id` FOREIGN KEY (`strategic_plan_goal_area_id`) REFERENCES `vibe_ngo_v1`.`program`.`strategic_plan_goal_area`(`strategic_plan_goal_area_id`);
ALTER TABLE `vibe_ngo_v1`.`program`.`unsdcf_outcome` ADD CONSTRAINT `fk_program_unsdcf_outcome_country_programme_document_id` FOREIGN KEY (`country_programme_document_id`) REFERENCES `vibe_ngo_v1`.`program`.`country_programme_document`(`country_programme_document_id`);
ALTER TABLE `vibe_ngo_v1`.`program`.`unsdcf_outcome` ADD CONSTRAINT `fk_program_unsdcf_outcome_strategic_plan_goal_area_id` FOREIGN KEY (`strategic_plan_goal_area_id`) REFERENCES `vibe_ngo_v1`.`program`.`strategic_plan_goal_area`(`strategic_plan_goal_area_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_ngo_v1`.`program` SET TAGS ('pii_division' = 'operations');
ALTER SCHEMA `vibe_ngo_v1`.`program` SET TAGS ('pii_domain' = 'program');
ALTER TABLE `vibe_ngo_v1`.`program`.`intervention` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_ngo_v1`.`program`.`intervention` SET TAGS ('pii_subdomain' = 'program_design');
ALTER TABLE `vibe_ngo_v1`.`program`.`intervention` SET TAGS ('pii_tier' = 'mvm');
ALTER TABLE `vibe_ngo_v1`.`program`.`intervention` SET TAGS ('pii_domain' = 'program');
ALTER TABLE `vibe_ngo_v1`.`program`.`intervention` SET TAGS ('pii_column_comment_framework' = 'IATI v2.03 + eTools');
ALTER TABLE `vibe_ngo_v1`.`program`.`intervention` ALTER COLUMN `intervention_id` SET TAGS ('pii_business_glossary_term' = 'Intervention ID');
ALTER TABLE `vibe_ngo_v1`.`program`.`intervention` ALTER COLUMN `obligation_id` SET TAGS ('pii_business_glossary_term' = 'Compliance Obligation Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`program`.`intervention` ALTER COLUMN `country_programme_document_id` SET TAGS ('pii_business_glossary_term' = 'CPD');
ALTER TABLE `vibe_ngo_v1`.`program`.`intervention` ALTER COLUMN `finance_fund_id` SET TAGS ('pii_business_glossary_term' = 'Finance Fund Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`program`.`intervention` ALTER COLUMN `psea_policy_id` SET TAGS ('pii_business_glossary_term' = 'Governing Psea Policy Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`program`.`intervention` ALTER COLUMN `humanitarian_response_plan_id` SET TAGS ('pii_business_glossary_term' = 'HRP');
ALTER TABLE `vibe_ngo_v1`.`program`.`intervention` ALTER COLUMN `org_unit_id` SET TAGS ('pii_business_glossary_term' = 'Implementing Organizational Unit (Org Unit) ID');
ALTER TABLE `vibe_ngo_v1`.`program`.`intervention` ALTER COLUMN `system_platform_id` SET TAGS ('pii_business_glossary_term' = 'Primary System Platform Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`program`.`intervention` ALTER COLUMN `staff_member_id` SET TAGS ('pii_business_glossary_term' = 'Program Manager ID');
ALTER TABLE `vibe_ngo_v1`.`program`.`intervention` ALTER COLUMN `staff_member_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`program`.`intervention` ALTER COLUMN `staff_member_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_ngo_v1`.`program`.`intervention` ALTER COLUMN `strategic_plan_goal_area_id` SET TAGS ('pii_business_glossary_term' = 'Goal Area');
ALTER TABLE `vibe_ngo_v1`.`program`.`intervention` ALTER COLUMN `unsdcf_outcome_id` SET TAGS ('pii_business_glossary_term' = 'UNSDCF Outcome');
ALTER TABLE `vibe_ngo_v1`.`program`.`intervention` ALTER COLUMN `actual_end_date` SET TAGS ('pii_business_glossary_term' = 'Actual End Date');
ALTER TABLE `vibe_ngo_v1`.`program`.`intervention` ALTER COLUMN `actual_start_date` SET TAGS ('pii_business_glossary_term' = 'Actual Start Date');
ALTER TABLE `vibe_ngo_v1`.`program`.`intervention` ALTER COLUMN `budget_currency_code` SET TAGS ('pii_business_glossary_term' = 'Budget Currency Code');
ALTER TABLE `vibe_ngo_v1`.`program`.`intervention` ALTER COLUMN `chs_compliant` SET TAGS ('pii_business_glossary_term' = 'Core Humanitarian Standard (CHS) Compliant');
ALTER TABLE `vibe_ngo_v1`.`program`.`intervention` ALTER COLUMN `intervention_code` SET TAGS ('pii_business_glossary_term' = 'Intervention Code');
ALTER TABLE `vibe_ngo_v1`.`program`.`intervention` ALTER COLUMN `intervention_code` SET TAGS ('pii_value_regex' = '^[A-Z0-9]{3,20}$');
ALTER TABLE `vibe_ngo_v1`.`program`.`intervention` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_ngo_v1`.`program`.`intervention` ALTER COLUMN `disability_inclusion_marker_score` SET TAGS ('pii_business_glossary_term' = 'Disability Inclusion Marker Score');
ALTER TABLE `vibe_ngo_v1`.`program`.`intervention` ALTER COLUMN `disability_inclusion_marker_score` SET TAGS ('pii_value_regex' = '0|1|2|3|4');
ALTER TABLE `vibe_ngo_v1`.`program`.`intervention` ALTER COLUMN `disability_inclusion_marker_score` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`program`.`intervention` ALTER COLUMN `disability_inclusion_marker_score` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_ngo_v1`.`program`.`intervention` ALTER COLUMN `do_no_harm_assessment_completed` SET TAGS ('pii_business_glossary_term' = 'Do No Harm Assessment Completed');
ALTER TABLE `vibe_ngo_v1`.`program`.`intervention` ALTER COLUMN `environmental_impact_assessment_completed` SET TAGS ('pii_business_glossary_term' = 'Environmental Impact Assessment Completed');
ALTER TABLE `vibe_ngo_v1`.`program`.`intervention` ALTER COLUMN `gender_marker_score` SET TAGS ('pii_business_glossary_term' = 'Gender Marker Score');
ALTER TABLE `vibe_ngo_v1`.`program`.`intervention` ALTER COLUMN `gender_marker_score` SET TAGS ('pii_value_regex' = '0|1|2a|2b');
ALTER TABLE `vibe_ngo_v1`.`program`.`intervention` ALTER COLUMN `gender_marker_score` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`program`.`intervention` ALTER COLUMN `gender_marker_score` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_ngo_v1`.`program`.`intervention` ALTER COLUMN `gender_marker_score` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`program`.`intervention` ALTER COLUMN `geographic_scope` SET TAGS ('pii_business_glossary_term' = 'Geographic Scope');
ALTER TABLE `vibe_ngo_v1`.`program`.`intervention` ALTER COLUMN `geographic_scope` SET TAGS ('pii_value_regex' = 'national|regional|district|community|multi_country');
ALTER TABLE `vibe_ngo_v1`.`program`.`intervention` ALTER COLUMN `intervention_status` SET TAGS ('pii_business_glossary_term' = 'Intervention Status');
ALTER TABLE `vibe_ngo_v1`.`program`.`intervention` ALTER COLUMN `intervention_status` SET TAGS ('pii_value_regex' = 'pipeline|approved|active|suspended|completed|closed');
ALTER TABLE `vibe_ngo_v1`.`program`.`intervention` ALTER COLUMN `intervention_type` SET TAGS ('pii_business_glossary_term' = 'Intervention Type');
ALTER TABLE `vibe_ngo_v1`.`program`.`intervention` ALTER COLUMN `intervention_type` SET TAGS ('pii_value_regex' = 'emergency_response|development|recovery|resilience|advocacy|capacity_building');
ALTER TABLE `vibe_ngo_v1`.`program`.`intervention` ALTER COLUMN `last_modified_timestamp` SET TAGS ('pii_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_ngo_v1`.`program`.`intervention` ALTER COLUMN `logframe_document_url` SET TAGS ('pii_business_glossary_term' = 'Logical Framework (LogFrame) Document URL');
ALTER TABLE `vibe_ngo_v1`.`program`.`intervention` ALTER COLUMN `logic` SET TAGS ('pii_business_glossary_term' = 'Intervention Logic');
ALTER TABLE `vibe_ngo_v1`.`program`.`intervention` ALTER COLUMN `mel_plan_document_url` SET TAGS ('pii_business_glossary_term' = 'Monitoring Evaluation and Learning (MEL) Plan Document URL');
ALTER TABLE `vibe_ngo_v1`.`program`.`intervention` ALTER COLUMN `intervention_name` SET TAGS ('pii_business_glossary_term' = 'Intervention Name');
ALTER TABLE `vibe_ngo_v1`.`program`.`intervention` ALTER COLUMN `intervention_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`program`.`intervention` ALTER COLUMN `intervention_name` SET TAGS ('pii_type' = 'name');
ALTER TABLE `vibe_ngo_v1`.`program`.`intervention` ALTER COLUMN `phase` SET TAGS ('pii_business_glossary_term' = 'Intervention Phase');
ALTER TABLE `vibe_ngo_v1`.`program`.`intervention` ALTER COLUMN `phase` SET TAGS ('pii_value_regex' = 'design|startup|implementation|closeout');
ALTER TABLE `vibe_ngo_v1`.`program`.`intervention` ALTER COLUMN `planned_end_date` SET TAGS ('pii_business_glossary_term' = 'Planned End Date');
ALTER TABLE `vibe_ngo_v1`.`program`.`intervention` ALTER COLUMN `planned_start_date` SET TAGS ('pii_business_glossary_term' = 'Planned Start Date');
ALTER TABLE `vibe_ngo_v1`.`program`.`intervention` ALTER COLUMN `rbm_framework_applied` SET TAGS ('pii_business_glossary_term' = 'Results-Based Management (RBM) Framework Applied');
ALTER TABLE `vibe_ngo_v1`.`program`.`intervention` ALTER COLUMN `safeguarding_policy_applied` SET TAGS ('pii_business_glossary_term' = 'Safeguarding Policy Applied');
ALTER TABLE `vibe_ngo_v1`.`program`.`intervention` ALTER COLUMN `sdg_alignment_type` SET TAGS ('pii_business_glossary_term' = 'Sustainable Development Goal (SDG) Alignment Type');
ALTER TABLE `vibe_ngo_v1`.`program`.`intervention` ALTER COLUMN `sdg_alignment_type` SET TAGS ('pii_value_regex' = 'direct|indirect|enabling');
ALTER TABLE `vibe_ngo_v1`.`program`.`intervention` ALTER COLUMN `sdg_contribution_narrative` SET TAGS ('pii_business_glossary_term' = 'Sustainable Development Goal (SDG) Contribution Narrative');
ALTER TABLE `vibe_ngo_v1`.`program`.`intervention` ALTER COLUMN `sdg_goal_primary` SET TAGS ('pii_business_glossary_term' = 'Sustainable Development Goal (SDG) Primary Goal');
ALTER TABLE `vibe_ngo_v1`.`program`.`intervention` ALTER COLUMN `sdg_goal_primary` SET TAGS ('pii_value_regex' = '^SDG[0-9]{1,2}$');
ALTER TABLE `vibe_ngo_v1`.`program`.`intervention` ALTER COLUMN `sdg_indicator_primary` SET TAGS ('pii_business_glossary_term' = 'Sustainable Development Goal (SDG) Primary Indicator');
ALTER TABLE `vibe_ngo_v1`.`program`.`intervention` ALTER COLUMN `sdg_indicator_primary` SET TAGS ('pii_value_regex' = '^[0-9]{1,2}.[0-9]{1,2}.[0-9]{1,2}$');
ALTER TABLE `vibe_ngo_v1`.`program`.`intervention` ALTER COLUMN `sdg_target_primary` SET TAGS ('pii_business_glossary_term' = 'Sustainable Development Goal (SDG) Primary Target');
ALTER TABLE `vibe_ngo_v1`.`program`.`intervention` ALTER COLUMN `sdg_target_primary` SET TAGS ('pii_value_regex' = '^[0-9]{1,2}.[0-9]{1,2}$');
ALTER TABLE `vibe_ngo_v1`.`program`.`intervention` ALTER COLUMN `sector` SET TAGS ('pii_business_glossary_term' = 'Sector');
ALTER TABLE `vibe_ngo_v1`.`program`.`intervention` ALTER COLUMN `short_name` SET TAGS ('pii_business_glossary_term' = 'Intervention Short Name');
ALTER TABLE `vibe_ngo_v1`.`program`.`intervention` ALTER COLUMN `short_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`program`.`intervention` ALTER COLUMN `short_name` SET TAGS ('pii_type' = 'name');
ALTER TABLE `vibe_ngo_v1`.`program`.`intervention` ALTER COLUMN `situation_analysis` SET TAGS ('pii_business_glossary_term' = 'Situation Analysis');
ALTER TABLE `vibe_ngo_v1`.`program`.`intervention` ALTER COLUMN `sphere_standards_applied` SET TAGS ('pii_business_glossary_term' = 'Sphere Standards Applied');
ALTER TABLE `vibe_ngo_v1`.`program`.`intervention` ALTER COLUMN `sub_sector` SET TAGS ('pii_business_glossary_term' = 'Sub-Sector');
ALTER TABLE `vibe_ngo_v1`.`program`.`intervention` ALTER COLUMN `sustainability_plan` SET TAGS ('pii_business_glossary_term' = 'Sustainability Plan');
ALTER TABLE `vibe_ngo_v1`.`program`.`intervention` ALTER COLUMN `target_beneficiary_count` SET TAGS ('pii_business_glossary_term' = 'Target Beneficiary Count');
ALTER TABLE `vibe_ngo_v1`.`program`.`intervention` ALTER COLUMN `target_beneficiary_unit` SET TAGS ('pii_business_glossary_term' = 'Target Beneficiary Unit');
ALTER TABLE `vibe_ngo_v1`.`program`.`intervention` ALTER COLUMN `target_beneficiary_unit` SET TAGS ('pii_value_regex' = 'individuals|households|communities|institutions');
ALTER TABLE `vibe_ngo_v1`.`program`.`intervention` ALTER COLUMN `targeting_strategy` SET TAGS ('pii_business_glossary_term' = 'Targeting Strategy');
ALTER TABLE `vibe_ngo_v1`.`program`.`intervention` ALTER COLUMN `theory_of_change_narrative` SET TAGS ('pii_business_glossary_term' = 'Theory of Change (ToC) Narrative');
ALTER TABLE `vibe_ngo_v1`.`program`.`intervention` ALTER COLUMN `total_budget_amount` SET TAGS ('pii_business_glossary_term' = 'Total Budget Amount');
ALTER TABLE `vibe_ngo_v1`.`program`.`theory_of_change` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_ngo_v1`.`program`.`theory_of_change` SET TAGS ('pii_subdomain' = 'program_design');
ALTER TABLE `vibe_ngo_v1`.`program`.`theory_of_change` SET TAGS ('pii_tier' = 'mvm');
ALTER TABLE `vibe_ngo_v1`.`program`.`theory_of_change` SET TAGS ('pii_domain' = 'program');
ALTER TABLE `vibe_ngo_v1`.`program`.`theory_of_change` ALTER COLUMN `theory_of_change_id` SET TAGS ('pii_business_glossary_term' = 'Theory of Change (ToC) ID');
ALTER TABLE `vibe_ngo_v1`.`program`.`theory_of_change` ALTER COLUMN `staff_member_id` SET TAGS ('pii_business_glossary_term' = 'Approved By Staff Member Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`program`.`theory_of_change` ALTER COLUMN `staff_member_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`program`.`theory_of_change` ALTER COLUMN `staff_member_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_ngo_v1`.`program`.`theory_of_change` ALTER COLUMN `intervention_id` SET TAGS ('pii_business_glossary_term' = 'Program ID');
ALTER TABLE `vibe_ngo_v1`.`program`.`theory_of_change` ALTER COLUMN `activity_statement` SET TAGS ('pii_business_glossary_term' = 'Activity Statement');
ALTER TABLE `vibe_ngo_v1`.`program`.`theory_of_change` ALTER COLUMN `approved_date` SET TAGS ('pii_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_ngo_v1`.`program`.`theory_of_change` ALTER COLUMN `assumptions` SET TAGS ('pii_business_glossary_term' = 'Theory of Change (ToC) Assumptions');
ALTER TABLE `vibe_ngo_v1`.`program`.`theory_of_change` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_ngo_v1`.`program`.`theory_of_change` ALTER COLUMN `do_no_harm_considerations` SET TAGS ('pii_business_glossary_term' = 'Do No Harm Considerations');
ALTER TABLE `vibe_ngo_v1`.`program`.`theory_of_change` ALTER COLUMN `donor_requirements` SET TAGS ('pii_business_glossary_term' = 'Donor Requirements');
ALTER TABLE `vibe_ngo_v1`.`program`.`theory_of_change` ALTER COLUMN `enabling_conditions` SET TAGS ('pii_business_glossary_term' = 'Enabling Conditions');
ALTER TABLE `vibe_ngo_v1`.`program`.`theory_of_change` ALTER COLUMN `gender_integration_approach` SET TAGS ('pii_business_glossary_term' = 'Gender Integration Approach');
ALTER TABLE `vibe_ngo_v1`.`program`.`theory_of_change` ALTER COLUMN `gender_integration_approach` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`program`.`theory_of_change` ALTER COLUMN `gender_integration_approach` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_ngo_v1`.`program`.`theory_of_change` ALTER COLUMN `gender_integration_approach` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`program`.`theory_of_change` ALTER COLUMN `geographic_scope` SET TAGS ('pii_business_glossary_term' = 'Geographic Scope');
ALTER TABLE `vibe_ngo_v1`.`program`.`theory_of_change` ALTER COLUMN `humanitarian_principles_alignment` SET TAGS ('pii_business_glossary_term' = 'Humanitarian Principles Alignment');
ALTER TABLE `vibe_ngo_v1`.`program`.`theory_of_change` ALTER COLUMN `impact_statement` SET TAGS ('pii_business_glossary_term' = 'Impact Statement');
ALTER TABLE `vibe_ngo_v1`.`program`.`theory_of_change` ALTER COLUMN `input_statement` SET TAGS ('pii_business_glossary_term' = 'Input Statement');
ALTER TABLE `vibe_ngo_v1`.`program`.`theory_of_change` ALTER COLUMN `last_modified_timestamp` SET TAGS ('pii_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_ngo_v1`.`program`.`theory_of_change` ALTER COLUMN `logframe_reference` SET TAGS ('pii_business_glossary_term' = 'Logical Framework (LogFrame) Reference');
ALTER TABLE `vibe_ngo_v1`.`program`.`theory_of_change` ALTER COLUMN `mel_framework_reference` SET TAGS ('pii_business_glossary_term' = 'Monitoring Evaluation and Learning (MEL) Framework Reference');
ALTER TABLE `vibe_ngo_v1`.`program`.`theory_of_change` ALTER COLUMN `outcome_statement` SET TAGS ('pii_business_glossary_term' = 'Outcome Statement');
ALTER TABLE `vibe_ngo_v1`.`program`.`theory_of_change` ALTER COLUMN `output_statement` SET TAGS ('pii_business_glossary_term' = 'Output Statement');
ALTER TABLE `vibe_ngo_v1`.`program`.`theory_of_change` ALTER COLUMN `revision_reason` SET TAGS ('pii_business_glossary_term' = 'Revision Reason');
ALTER TABLE `vibe_ngo_v1`.`program`.`theory_of_change` ALTER COLUMN `risks` SET TAGS ('pii_business_glossary_term' = 'Theory of Change (ToC) Risks');
ALTER TABLE `vibe_ngo_v1`.`program`.`theory_of_change` ALTER COLUMN `sdg_alignment` SET TAGS ('pii_business_glossary_term' = 'Sustainable Development Goal (SDG) Alignment');
ALTER TABLE `vibe_ngo_v1`.`program`.`theory_of_change` ALTER COLUMN `sector_classification` SET TAGS ('pii_business_glossary_term' = 'Sector Classification');
ALTER TABLE `vibe_ngo_v1`.`program`.`theory_of_change` ALTER COLUMN `stakeholder_engagement_approach` SET TAGS ('pii_business_glossary_term' = 'Stakeholder Engagement Approach');
ALTER TABLE `vibe_ngo_v1`.`program`.`theory_of_change` ALTER COLUMN `target_population` SET TAGS ('pii_business_glossary_term' = 'Target Population');
ALTER TABLE `vibe_ngo_v1`.`program`.`theory_of_change` ALTER COLUMN `timeframe_end_date` SET TAGS ('pii_business_glossary_term' = 'Timeframe End Date');
ALTER TABLE `vibe_ngo_v1`.`program`.`theory_of_change` ALTER COLUMN `timeframe_start_date` SET TAGS ('pii_business_glossary_term' = 'Timeframe Start Date');
ALTER TABLE `vibe_ngo_v1`.`program`.`theory_of_change` ALTER COLUMN `toc_narrative` SET TAGS ('pii_business_glossary_term' = 'Theory of Change (ToC) Narrative Statement');
ALTER TABLE `vibe_ngo_v1`.`program`.`theory_of_change` ALTER COLUMN `toc_status` SET TAGS ('pii_business_glossary_term' = 'Theory of Change (ToC) Status');
ALTER TABLE `vibe_ngo_v1`.`program`.`theory_of_change` ALTER COLUMN `toc_status` SET TAGS ('pii_value_regex' = 'draft|under_review|approved|active|revised|archived');
ALTER TABLE `vibe_ngo_v1`.`program`.`theory_of_change` ALTER COLUMN `toc_title` SET TAGS ('pii_business_glossary_term' = 'Theory of Change (ToC) Title');
ALTER TABLE `vibe_ngo_v1`.`program`.`theory_of_change` ALTER COLUMN `toc_version_number` SET TAGS ('pii_business_glossary_term' = 'Theory of Change (ToC) Version Number');
ALTER TABLE `vibe_ngo_v1`.`program`.`theory_of_change` ALTER COLUMN `toc_version_number` SET TAGS ('pii_value_regex' = '^[0-9]+.[0-9]+$');
ALTER TABLE `vibe_ngo_v1`.`program`.`program_logframe` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_ngo_v1`.`program`.`program_logframe` SET TAGS ('pii_subdomain' = 'results_framework');
ALTER TABLE `vibe_ngo_v1`.`program`.`program_logframe` SET TAGS ('pii_tier' = 'mvm');
ALTER TABLE `vibe_ngo_v1`.`program`.`program_logframe` SET TAGS ('pii_domain' = 'program');
ALTER TABLE `vibe_ngo_v1`.`program`.`program_logframe` SET TAGS ('pii_ssot' = 'true');
ALTER TABLE `vibe_ngo_v1`.`program`.`program_logframe` SET TAGS ('pii_ssot_scope' = 'program_design_logframe');
ALTER TABLE `vibe_ngo_v1`.`program`.`program_logframe` SET TAGS ('pii_ssot_owner' = 'program');
ALTER TABLE `vibe_ngo_v1`.`program`.`program_logframe` SET TAGS ('pii_ssot_boundary' = 'design_logframe');
ALTER TABLE `vibe_ngo_v1`.`program`.`program_logframe` SET TAGS ('pii_disambiguated_from' = 'mel.mel_logframe');
ALTER TABLE `vibe_ngo_v1`.`program`.`program_logframe` ALTER COLUMN `program_logframe_id` SET TAGS ('pii_business_glossary_term' = 'Program Logical Framework (LogFrame) ID');
ALTER TABLE `vibe_ngo_v1`.`program`.`program_logframe` ALTER COLUMN `staff_member_id` SET TAGS ('pii_business_glossary_term' = 'Approved By Staff Member Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`program`.`program_logframe` ALTER COLUMN `staff_member_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`program`.`program_logframe` ALTER COLUMN `staff_member_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_ngo_v1`.`program`.`program_logframe` ALTER COLUMN `intervention_id` SET TAGS ('pii_business_glossary_term' = 'Program ID');
ALTER TABLE `vibe_ngo_v1`.`program`.`program_logframe` ALTER COLUMN `amendment_reason` SET TAGS ('pii_business_glossary_term' = 'Amendment Reason');
ALTER TABLE `vibe_ngo_v1`.`program`.`program_logframe` ALTER COLUMN `approval_date` SET TAGS ('pii_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_ngo_v1`.`program`.`program_logframe` ALTER COLUMN `assumptions` SET TAGS ('pii_business_glossary_term' = 'Assumptions');
ALTER TABLE `vibe_ngo_v1`.`program`.`program_logframe` ALTER COLUMN `baseline_date` SET TAGS ('pii_business_glossary_term' = 'Baseline Date');
ALTER TABLE `vibe_ngo_v1`.`program`.`program_logframe` ALTER COLUMN `baseline_value` SET TAGS ('pii_business_glossary_term' = 'Baseline Value');
ALTER TABLE `vibe_ngo_v1`.`program`.`program_logframe` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_ngo_v1`.`program`.`program_logframe` ALTER COLUMN `dac_sector_code` SET TAGS ('pii_business_glossary_term' = 'Development Assistance Committee (DAC) Sector Code');
ALTER TABLE `vibe_ngo_v1`.`program`.`program_logframe` ALTER COLUMN `dac_sector_code` SET TAGS ('pii_value_regex' = '^[0-9]{5}$');
ALTER TABLE `vibe_ngo_v1`.`program`.`program_logframe` ALTER COLUMN `data_collection_method` SET TAGS ('pii_business_glossary_term' = 'Data Collection Method');
ALTER TABLE `vibe_ngo_v1`.`program`.`program_logframe` ALTER COLUMN `data_source` SET TAGS ('pii_business_glossary_term' = 'Data Source');
ALTER TABLE `vibe_ngo_v1`.`program`.`program_logframe` ALTER COLUMN `disaggregation_dimensions` SET TAGS ('pii_business_glossary_term' = 'Disaggregation Dimensions');
ALTER TABLE `vibe_ngo_v1`.`program`.`program_logframe` ALTER COLUMN `donor_visibility_flag` SET TAGS ('pii_business_glossary_term' = 'Donor Visibility Flag');
ALTER TABLE `vibe_ngo_v1`.`program`.`program_logframe` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_ngo_v1`.`program`.`program_logframe` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_ngo_v1`.`program`.`program_logframe` ALTER COLUMN `grant_requirement_flag` SET TAGS ('pii_business_glossary_term' = 'Grant Requirement Flag');
ALTER TABLE `vibe_ngo_v1`.`program`.`program_logframe` ALTER COLUMN `hierarchy_level` SET TAGS ('pii_business_glossary_term' = 'Logical Framework (LogFrame) Hierarchy Level');
ALTER TABLE `vibe_ngo_v1`.`program`.`program_logframe` ALTER COLUMN `hierarchy_level` SET TAGS ('pii_value_regex' = 'goal|purpose|outcome|output|activity');
ALTER TABLE `vibe_ngo_v1`.`program`.`program_logframe` ALTER COLUMN `indicator_reference_code` SET TAGS ('pii_business_glossary_term' = 'Indicator Reference Code');
ALTER TABLE `vibe_ngo_v1`.`program`.`program_logframe` ALTER COLUMN `last_modified_timestamp` SET TAGS ('pii_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_ngo_v1`.`program`.`program_logframe` ALTER COLUMN `means_of_verification` SET TAGS ('pii_business_glossary_term' = 'Means of Verification (MoV)');
ALTER TABLE `vibe_ngo_v1`.`program`.`program_logframe` ALTER COLUMN `mitigation_strategy` SET TAGS ('pii_business_glossary_term' = 'Mitigation Strategy');
ALTER TABLE `vibe_ngo_v1`.`program`.`program_logframe` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_ngo_v1`.`program`.`program_logframe` ALTER COLUMN `program_logframe_status` SET TAGS ('pii_business_glossary_term' = 'Logical Framework (LogFrame) Row Status');
ALTER TABLE `vibe_ngo_v1`.`program`.`program_logframe` ALTER COLUMN `reporting_frequency` SET TAGS ('pii_business_glossary_term' = 'Reporting Frequency');
ALTER TABLE `vibe_ngo_v1`.`program`.`program_logframe` ALTER COLUMN `reporting_frequency` SET TAGS ('pii_value_regex' = 'monthly|quarterly|semi-annually|annually|on-demand');
ALTER TABLE `vibe_ngo_v1`.`program`.`program_logframe` ALTER COLUMN `responsible_unit` SET TAGS ('pii_business_glossary_term' = 'Responsible Unit');
ALTER TABLE `vibe_ngo_v1`.`program`.`program_logframe` ALTER COLUMN `result_statement` SET TAGS ('pii_business_glossary_term' = 'Result Statement');
ALTER TABLE `vibe_ngo_v1`.`program`.`program_logframe` ALTER COLUMN `risk_level` SET TAGS ('pii_business_glossary_term' = 'Risk Level');
ALTER TABLE `vibe_ngo_v1`.`program`.`program_logframe` ALTER COLUMN `risk_level` SET TAGS ('pii_value_regex' = 'low|medium|high|critical');
ALTER TABLE `vibe_ngo_v1`.`program`.`program_logframe` ALTER COLUMN `row_sequence_number` SET TAGS ('pii_business_glossary_term' = 'Row Sequence Number');
ALTER TABLE `vibe_ngo_v1`.`program`.`program_logframe` ALTER COLUMN `sdg_alignment` SET TAGS ('pii_business_glossary_term' = 'Sustainable Development Goal (SDG) Alignment');
ALTER TABLE `vibe_ngo_v1`.`program`.`program_logframe` ALTER COLUMN `sector_classification` SET TAGS ('pii_business_glossary_term' = 'Sector Classification');
ALTER TABLE `vibe_ngo_v1`.`program`.`program_logframe` ALTER COLUMN `target_date` SET TAGS ('pii_business_glossary_term' = 'Target Date');
ALTER TABLE `vibe_ngo_v1`.`program`.`program_logframe` ALTER COLUMN `target_value` SET TAGS ('pii_business_glossary_term' = 'Target Value');
ALTER TABLE `vibe_ngo_v1`.`program`.`program_logframe` ALTER COLUMN `theory_of_change_reference` SET TAGS ('pii_business_glossary_term' = 'Theory of Change (ToC) Reference');
ALTER TABLE `vibe_ngo_v1`.`program`.`program_logframe` ALTER COLUMN `unit_of_measure` SET TAGS ('pii_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `vibe_ngo_v1`.`program`.`program_logframe` ALTER COLUMN `version_number` SET TAGS ('pii_business_glossary_term' = 'Logical Framework (LogFrame) Version Number');
ALTER TABLE `vibe_ngo_v1`.`program`.`program_logframe` ALTER COLUMN `version_number` SET TAGS ('pii_value_regex' = '^[0-9]+.[0-9]+$');
ALTER TABLE `vibe_ngo_v1`.`program`.`logframe_row` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_ngo_v1`.`program`.`logframe_row` SET TAGS ('pii_subdomain' = 'results_framework');
ALTER TABLE `vibe_ngo_v1`.`program`.`logframe_row` SET TAGS ('pii_tier' = 'mvm');
ALTER TABLE `vibe_ngo_v1`.`program`.`logframe_row` SET TAGS ('pii_domain' = 'program');
ALTER TABLE `vibe_ngo_v1`.`program`.`logframe_row` ALTER COLUMN `logframe_row_id` SET TAGS ('pii_business_glossary_term' = 'LogFrame Row ID');
ALTER TABLE `vibe_ngo_v1`.`program`.`logframe_row` ALTER COLUMN `intervention_id` SET TAGS ('pii_business_glossary_term' = 'Program ID');
ALTER TABLE `vibe_ngo_v1`.`program`.`logframe_row` ALTER COLUMN `parent_result_logframe_row_id` SET TAGS ('pii_business_glossary_term' = 'Parent Result ID');
ALTER TABLE `vibe_ngo_v1`.`program`.`logframe_row` ALTER COLUMN `program_logframe_id` SET TAGS ('pii_business_glossary_term' = 'Logical Framework (LogFrame) ID');
ALTER TABLE `vibe_ngo_v1`.`program`.`logframe_row` ALTER COLUMN `assumptions` SET TAGS ('pii_business_glossary_term' = 'Assumptions');
ALTER TABLE `vibe_ngo_v1`.`program`.`logframe_row` ALTER COLUMN `baseline_date` SET TAGS ('pii_business_glossary_term' = 'Baseline Date');
ALTER TABLE `vibe_ngo_v1`.`program`.`logframe_row` ALTER COLUMN `baseline_value` SET TAGS ('pii_business_glossary_term' = 'Baseline Value');
ALTER TABLE `vibe_ngo_v1`.`program`.`logframe_row` ALTER COLUMN `beneficiary_target_count` SET TAGS ('pii_business_glossary_term' = 'Beneficiary Target Count');
ALTER TABLE `vibe_ngo_v1`.`program`.`logframe_row` ALTER COLUMN `budget_allocated` SET TAGS ('pii_business_glossary_term' = 'Budget Allocated');
ALTER TABLE `vibe_ngo_v1`.`program`.`logframe_row` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_ngo_v1`.`program`.`logframe_row` ALTER COLUMN `currency_code` SET TAGS ('pii_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_ngo_v1`.`program`.`logframe_row` ALTER COLUMN `currency_code` SET TAGS ('pii_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_ngo_v1`.`program`.`logframe_row` ALTER COLUMN `dac_code` SET TAGS ('pii_business_glossary_term' = 'Development Assistance Committee (DAC) Code');
ALTER TABLE `vibe_ngo_v1`.`program`.`logframe_row` ALTER COLUMN `data_collection_method` SET TAGS ('pii_business_glossary_term' = 'Data Collection Method');
ALTER TABLE `vibe_ngo_v1`.`program`.`logframe_row` ALTER COLUMN `disaggregation_dimensions` SET TAGS ('pii_business_glossary_term' = 'Disaggregation Dimensions');
ALTER TABLE `vibe_ngo_v1`.`program`.`logframe_row` ALTER COLUMN `geographic_scope` SET TAGS ('pii_business_glossary_term' = 'Geographic Scope');
ALTER TABLE `vibe_ngo_v1`.`program`.`logframe_row` ALTER COLUMN `implementation_end_date` SET TAGS ('pii_business_glossary_term' = 'Implementation End Date');
ALTER TABLE `vibe_ngo_v1`.`program`.`logframe_row` ALTER COLUMN `implementation_start_date` SET TAGS ('pii_business_glossary_term' = 'Implementation Start Date');
ALTER TABLE `vibe_ngo_v1`.`program`.`logframe_row` ALTER COLUMN `indicator_reference` SET TAGS ('pii_business_glossary_term' = 'Indicator Reference');
ALTER TABLE `vibe_ngo_v1`.`program`.`logframe_row` ALTER COLUMN `is_active` SET TAGS ('pii_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_ngo_v1`.`program`.`logframe_row` ALTER COLUMN `logframe_row_status` SET TAGS ('pii_business_glossary_term' = 'LogFrame Row Status');
ALTER TABLE `vibe_ngo_v1`.`program`.`logframe_row` ALTER COLUMN `means_of_verification` SET TAGS ('pii_business_glossary_term' = 'Means of Verification (MoV)');
ALTER TABLE `vibe_ngo_v1`.`program`.`logframe_row` ALTER COLUMN `modified_by` SET TAGS ('pii_business_glossary_term' = 'Modified By');
ALTER TABLE `vibe_ngo_v1`.`program`.`logframe_row` ALTER COLUMN `modified_timestamp` SET TAGS ('pii_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_ngo_v1`.`program`.`logframe_row` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_ngo_v1`.`program`.`logframe_row` ALTER COLUMN `reporting_frequency` SET TAGS ('pii_business_glossary_term' = 'Reporting Frequency');
ALTER TABLE `vibe_ngo_v1`.`program`.`logframe_row` ALTER COLUMN `reporting_frequency` SET TAGS ('pii_value_regex' = 'monthly|quarterly|semi-annually|annually|ad-hoc');
ALTER TABLE `vibe_ngo_v1`.`program`.`logframe_row` ALTER COLUMN `responsible_person` SET TAGS ('pii_business_glossary_term' = 'Responsible Person');
ALTER TABLE `vibe_ngo_v1`.`program`.`logframe_row` ALTER COLUMN `responsible_person` SET TAGS ('pii_type' = 'personal');
ALTER TABLE `vibe_ngo_v1`.`program`.`logframe_row` ALTER COLUMN `responsible_unit` SET TAGS ('pii_business_glossary_term' = 'Responsible Unit');
ALTER TABLE `vibe_ngo_v1`.`program`.`logframe_row` ALTER COLUMN `result_code` SET TAGS ('pii_business_glossary_term' = 'Result Code');
ALTER TABLE `vibe_ngo_v1`.`program`.`logframe_row` ALTER COLUMN `result_level` SET TAGS ('pii_business_glossary_term' = 'Result Level');
ALTER TABLE `vibe_ngo_v1`.`program`.`logframe_row` ALTER COLUMN `result_level` SET TAGS ('pii_value_regex' = 'goal|outcome|output|activity|input');
ALTER TABLE `vibe_ngo_v1`.`program`.`logframe_row` ALTER COLUMN `result_statement` SET TAGS ('pii_business_glossary_term' = 'Result Statement');
ALTER TABLE `vibe_ngo_v1`.`program`.`logframe_row` ALTER COLUMN `risks` SET TAGS ('pii_business_glossary_term' = 'Risks');
ALTER TABLE `vibe_ngo_v1`.`program`.`logframe_row` ALTER COLUMN `sdg_alignment` SET TAGS ('pii_business_glossary_term' = 'Sustainable Development Goal (SDG) Alignment');
ALTER TABLE `vibe_ngo_v1`.`program`.`logframe_row` ALTER COLUMN `sector_classification` SET TAGS ('pii_business_glossary_term' = 'Sector Classification');
ALTER TABLE `vibe_ngo_v1`.`program`.`logframe_row` ALTER COLUMN `sequence_number` SET TAGS ('pii_business_glossary_term' = 'Sequence Number');
ALTER TABLE `vibe_ngo_v1`.`program`.`logframe_row` ALTER COLUMN `target_date` SET TAGS ('pii_business_glossary_term' = 'Target Date');
ALTER TABLE `vibe_ngo_v1`.`program`.`logframe_row` ALTER COLUMN `target_value` SET TAGS ('pii_business_glossary_term' = 'Target Value');
ALTER TABLE `vibe_ngo_v1`.`program`.`logframe_row` ALTER COLUMN `created_by` SET TAGS ('pii_business_glossary_term' = 'Created By');
ALTER TABLE `vibe_ngo_v1`.`program`.`component` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_ngo_v1`.`program`.`component` SET TAGS ('pii_subdomain' = 'program_design');
ALTER TABLE `vibe_ngo_v1`.`program`.`component` SET TAGS ('pii_tier' = 'mvm');
ALTER TABLE `vibe_ngo_v1`.`program`.`component` SET TAGS ('pii_domain' = 'program');
ALTER TABLE `vibe_ngo_v1`.`program`.`component` ALTER COLUMN `component_id` SET TAGS ('pii_business_glossary_term' = 'Component ID');
ALTER TABLE `vibe_ngo_v1`.`program`.`component` ALTER COLUMN `donor_fund_id` SET TAGS ('pii_business_glossary_term' = 'Fund Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`program`.`component` ALTER COLUMN `intervention_id` SET TAGS ('pii_business_glossary_term' = 'Program ID');
ALTER TABLE `vibe_ngo_v1`.`program`.`component` ALTER COLUMN `it_project_id` SET TAGS ('pii_business_glossary_term' = 'It Project Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`program`.`component` ALTER COLUMN `parent_component_id` SET TAGS ('pii_business_glossary_term' = 'Parent Component ID');
ALTER TABLE `vibe_ngo_v1`.`program`.`component` ALTER COLUMN `amendment_count` SET TAGS ('pii_business_glossary_term' = 'Amendment Count');
ALTER TABLE `vibe_ngo_v1`.`program`.`component` ALTER COLUMN `approval_date` SET TAGS ('pii_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_ngo_v1`.`program`.`component` ALTER COLUMN `approval_status` SET TAGS ('pii_business_glossary_term' = 'Approval Status');
ALTER TABLE `vibe_ngo_v1`.`program`.`component` ALTER COLUMN `approval_status` SET TAGS ('pii_value_regex' = 'draft|pending_review|approved|revision_required|rejected');
ALTER TABLE `vibe_ngo_v1`.`program`.`component` ALTER COLUMN `approved_by` SET TAGS ('pii_business_glossary_term' = 'Approved By');
ALTER TABLE `vibe_ngo_v1`.`program`.`component` ALTER COLUMN `budget_currency_code` SET TAGS ('pii_business_glossary_term' = 'Budget Currency Code');
ALTER TABLE `vibe_ngo_v1`.`program`.`component` ALTER COLUMN `budget_envelope_amount` SET TAGS ('pii_business_glossary_term' = 'Budget Envelope Amount');
ALTER TABLE `vibe_ngo_v1`.`program`.`component` ALTER COLUMN `component_code` SET TAGS ('pii_business_glossary_term' = 'Component Code');
ALTER TABLE `vibe_ngo_v1`.`program`.`component` ALTER COLUMN `component_code` SET TAGS ('pii_value_regex' = '^[A-Z0-9]{3,20}$');
ALTER TABLE `vibe_ngo_v1`.`program`.`component` ALTER COLUMN `component_status` SET TAGS ('pii_business_glossary_term' = 'Component Status');
ALTER TABLE `vibe_ngo_v1`.`program`.`component` ALTER COLUMN `component_status` SET TAGS ('pii_value_regex' = 'planned|active|on_hold|completed|closed|cancelled');
ALTER TABLE `vibe_ngo_v1`.`program`.`component` ALTER COLUMN `component_type` SET TAGS ('pii_business_glossary_term' = 'Component Type');
ALTER TABLE `vibe_ngo_v1`.`program`.`component` ALTER COLUMN `component_type` SET TAGS ('pii_value_regex' = 'component|sub-component|workstream|activity_cluster|pilot|scale_up');
ALTER TABLE `vibe_ngo_v1`.`program`.`component` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_ngo_v1`.`program`.`component` ALTER COLUMN `cross_cutting_themes` SET TAGS ('pii_business_glossary_term' = 'Cross-Cutting Themes');
ALTER TABLE `vibe_ngo_v1`.`program`.`component` ALTER COLUMN `dac_sector_code` SET TAGS ('pii_business_glossary_term' = 'Development Assistance Committee (DAC) Sector Code');
ALTER TABLE `vibe_ngo_v1`.`program`.`component` ALTER COLUMN `dac_sector_code` SET TAGS ('pii_value_regex' = '^[0-9]{5}$');
ALTER TABLE `vibe_ngo_v1`.`program`.`component` ALTER COLUMN `component_description` SET TAGS ('pii_business_glossary_term' = 'Component Description');
ALTER TABLE `vibe_ngo_v1`.`program`.`component` ALTER COLUMN `donor_visibility_flag` SET TAGS ('pii_business_glossary_term' = 'Donor Visibility Flag');
ALTER TABLE `vibe_ngo_v1`.`program`.`component` ALTER COLUMN `end_date` SET TAGS ('pii_business_glossary_term' = 'Component End Date');
ALTER TABLE `vibe_ngo_v1`.`program`.`component` ALTER COLUMN `funding_source` SET TAGS ('pii_business_glossary_term' = 'Funding Source');
ALTER TABLE `vibe_ngo_v1`.`program`.`component` ALTER COLUMN `geographic_focus` SET TAGS ('pii_business_glossary_term' = 'Geographic Focus');
ALTER TABLE `vibe_ngo_v1`.`program`.`component` ALTER COLUMN `grant_requirement_flag` SET TAGS ('pii_business_glossary_term' = 'Grant Requirement Flag');
ALTER TABLE `vibe_ngo_v1`.`program`.`component` ALTER COLUMN `hierarchy_level` SET TAGS ('pii_business_glossary_term' = 'Hierarchy Level');
ALTER TABLE `vibe_ngo_v1`.`program`.`component` ALTER COLUMN `implementation_modality` SET TAGS ('pii_business_glossary_term' = 'Implementation Modality');
ALTER TABLE `vibe_ngo_v1`.`program`.`component` ALTER COLUMN `implementation_modality` SET TAGS ('pii_value_regex' = 'direct|partner|consortium|sub_award|community_based');
ALTER TABLE `vibe_ngo_v1`.`program`.`component` ALTER COLUMN `integration_flag` SET TAGS ('pii_business_glossary_term' = 'Integration Flag');
ALTER TABLE `vibe_ngo_v1`.`program`.`component` ALTER COLUMN `last_amendment_date` SET TAGS ('pii_business_glossary_term' = 'Last Amendment Date');
ALTER TABLE `vibe_ngo_v1`.`program`.`component` ALTER COLUMN `last_modified_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `vibe_ngo_v1`.`program`.`component` ALTER COLUMN `mitigation_strategy` SET TAGS ('pii_business_glossary_term' = 'Mitigation Strategy');
ALTER TABLE `vibe_ngo_v1`.`program`.`component` ALTER COLUMN `monitoring_frequency` SET TAGS ('pii_business_glossary_term' = 'Monitoring Frequency');
ALTER TABLE `vibe_ngo_v1`.`program`.`component` ALTER COLUMN `component_name` SET TAGS ('pii_business_glossary_term' = 'Component Name');
ALTER TABLE `vibe_ngo_v1`.`program`.`component` ALTER COLUMN `component_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`program`.`component` ALTER COLUMN `component_name` SET TAGS ('pii_type' = 'name');
ALTER TABLE `vibe_ngo_v1`.`program`.`component` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Component Notes');
ALTER TABLE `vibe_ngo_v1`.`program`.`component` ALTER COLUMN `reporting_frequency` SET TAGS ('pii_business_glossary_term' = 'Reporting Frequency');
ALTER TABLE `vibe_ngo_v1`.`program`.`component` ALTER COLUMN `reporting_frequency` SET TAGS ('pii_value_regex' = 'monthly|quarterly|semi_annual|annual|final_only');
ALTER TABLE `vibe_ngo_v1`.`program`.`component` ALTER COLUMN `responsible_manager` SET TAGS ('pii_business_glossary_term' = 'Responsible Manager');
ALTER TABLE `vibe_ngo_v1`.`program`.`component` ALTER COLUMN `responsible_team` SET TAGS ('pii_business_glossary_term' = 'Responsible Team');
ALTER TABLE `vibe_ngo_v1`.`program`.`component` ALTER COLUMN `risk_level` SET TAGS ('pii_business_glossary_term' = 'Risk Level');
ALTER TABLE `vibe_ngo_v1`.`program`.`component` ALTER COLUMN `risk_level` SET TAGS ('pii_value_regex' = 'low|medium|high|critical');
ALTER TABLE `vibe_ngo_v1`.`program`.`component` ALTER COLUMN `sdg_alignment` SET TAGS ('pii_business_glossary_term' = 'Sustainable Development Goal (SDG) Alignment');
ALTER TABLE `vibe_ngo_v1`.`program`.`component` ALTER COLUMN `sector` SET TAGS ('pii_business_glossary_term' = 'Sector');
ALTER TABLE `vibe_ngo_v1`.`program`.`component` ALTER COLUMN `start_date` SET TAGS ('pii_business_glossary_term' = 'Component Start Date');
ALTER TABLE `vibe_ngo_v1`.`program`.`component` ALTER COLUMN `sub_sector` SET TAGS ('pii_business_glossary_term' = 'Sub-Sector');
ALTER TABLE `vibe_ngo_v1`.`program`.`component` ALTER COLUMN `target_beneficiary_count` SET TAGS ('pii_business_glossary_term' = 'Target Beneficiary Count');
ALTER TABLE `vibe_ngo_v1`.`program`.`component` ALTER COLUMN `theory_of_change_reference` SET TAGS ('pii_business_glossary_term' = 'Theory of Change (ToC) Reference');
ALTER TABLE `vibe_ngo_v1`.`program`.`target_population` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_ngo_v1`.`program`.`target_population` SET TAGS ('pii_subdomain' = 'program_design');
ALTER TABLE `vibe_ngo_v1`.`program`.`target_population` SET TAGS ('pii_tier' = 'mvm');
ALTER TABLE `vibe_ngo_v1`.`program`.`target_population` SET TAGS ('pii_domain' = 'program');
ALTER TABLE `vibe_ngo_v1`.`program`.`target_population` ALTER COLUMN `target_population_id` SET TAGS ('pii_business_glossary_term' = 'Target Population Identifier (ID)');
ALTER TABLE `vibe_ngo_v1`.`program`.`target_population` ALTER COLUMN `chs_self_assessment_id` SET TAGS ('pii_business_glossary_term' = 'Chs Self Assessment Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`program`.`target_population` ALTER COLUMN `intervention_id` SET TAGS ('pii_business_glossary_term' = 'Program Identifier (ID)');
ALTER TABLE `vibe_ngo_v1`.`program`.`target_population` ALTER COLUMN `age_range_max` SET TAGS ('pii_business_glossary_term' = 'Maximum Age Range');
ALTER TABLE `vibe_ngo_v1`.`program`.`target_population` ALTER COLUMN `age_range_max` SET TAGS ('pii_type' = 'age');
ALTER TABLE `vibe_ngo_v1`.`program`.`target_population` ALTER COLUMN `age_range_min` SET TAGS ('pii_business_glossary_term' = 'Minimum Age Range');
ALTER TABLE `vibe_ngo_v1`.`program`.`target_population` ALTER COLUMN `age_range_min` SET TAGS ('pii_type' = 'age');
ALTER TABLE `vibe_ngo_v1`.`program`.`target_population` ALTER COLUMN `approval_date` SET TAGS ('pii_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_ngo_v1`.`program`.`target_population` ALTER COLUMN `approved_by` SET TAGS ('pii_business_glossary_term' = 'Approved By');
ALTER TABLE `vibe_ngo_v1`.`program`.`target_population` ALTER COLUMN `baseline_date` SET TAGS ('pii_business_glossary_term' = 'Baseline Date');
ALTER TABLE `vibe_ngo_v1`.`program`.`target_population` ALTER COLUMN `country_code` SET TAGS ('pii_business_glossary_term' = 'Country Code');
ALTER TABLE `vibe_ngo_v1`.`program`.`target_population` ALTER COLUMN `country_code` SET TAGS ('pii_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_ngo_v1`.`program`.`target_population` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_ngo_v1`.`program`.`target_population` ALTER COLUMN `dac_sector_code` SET TAGS ('pii_business_glossary_term' = 'Development Assistance Committee (DAC) Sector Code');
ALTER TABLE `vibe_ngo_v1`.`program`.`target_population` ALTER COLUMN `data_collection_method` SET TAGS ('pii_business_glossary_term' = 'Data Collection Method');
ALTER TABLE `vibe_ngo_v1`.`program`.`target_population` ALTER COLUMN `data_source` SET TAGS ('pii_business_glossary_term' = 'Data Source');
ALTER TABLE `vibe_ngo_v1`.`program`.`target_population` ALTER COLUMN `displacement_status` SET TAGS ('pii_business_glossary_term' = 'Displacement Status');
ALTER TABLE `vibe_ngo_v1`.`program`.`target_population` ALTER COLUMN `displacement_status` SET TAGS ('pii_value_regex' = 'idp|refugee|returnee|host_community|mixed|not_applicable');
ALTER TABLE `vibe_ngo_v1`.`program`.`target_population` ALTER COLUMN `do_no_harm_considerations` SET TAGS ('pii_business_glossary_term' = 'Do No Harm Considerations');
ALTER TABLE `vibe_ngo_v1`.`program`.`target_population` ALTER COLUMN `donor_visibility_flag` SET TAGS ('pii_business_glossary_term' = 'Donor Visibility Flag');
ALTER TABLE `vibe_ngo_v1`.`program`.`target_population` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_ngo_v1`.`program`.`target_population` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_ngo_v1`.`program`.`target_population` ALTER COLUMN `estimated_population_size` SET TAGS ('pii_business_glossary_term' = 'Estimated Population Size');
ALTER TABLE `vibe_ngo_v1`.`program`.`target_population` ALTER COLUMN `exclusion_criteria` SET TAGS ('pii_business_glossary_term' = 'Exclusion Criteria');
ALTER TABLE `vibe_ngo_v1`.`program`.`target_population` ALTER COLUMN `gender_integration_approach` SET TAGS ('pii_business_glossary_term' = 'Gender Integration Approach');
ALTER TABLE `vibe_ngo_v1`.`program`.`target_population` ALTER COLUMN `gender_integration_approach` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`program`.`target_population` ALTER COLUMN `gender_integration_approach` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_ngo_v1`.`program`.`target_population` ALTER COLUMN `gender_integration_approach` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`program`.`target_population` ALTER COLUMN `geographic_scope` SET TAGS ('pii_business_glossary_term' = 'Geographic Scope');
ALTER TABLE `vibe_ngo_v1`.`program`.`target_population` ALTER COLUMN `host_community_population_count` SET TAGS ('pii_business_glossary_term' = 'Host Community Population Count');
ALTER TABLE `vibe_ngo_v1`.`program`.`target_population` ALTER COLUMN `idp_population_count` SET TAGS ('pii_business_glossary_term' = 'Internally Displaced Person (IDP) Population Count');
ALTER TABLE `vibe_ngo_v1`.`program`.`target_population` ALTER COLUMN `inclusion_criteria` SET TAGS ('pii_business_glossary_term' = 'Inclusion Criteria');
ALTER TABLE `vibe_ngo_v1`.`program`.`target_population` ALTER COLUMN `last_modified_timestamp` SET TAGS ('pii_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_ngo_v1`.`program`.`target_population` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_ngo_v1`.`program`.`target_population` ALTER COLUMN `planned_reach` SET TAGS ('pii_business_glossary_term' = 'Planned Reach');
ALTER TABLE `vibe_ngo_v1`.`program`.`target_population` ALTER COLUMN `population_code` SET TAGS ('pii_business_glossary_term' = 'Target Population Code');
ALTER TABLE `vibe_ngo_v1`.`program`.`target_population` ALTER COLUMN `population_description` SET TAGS ('pii_business_glossary_term' = 'Target Population Description');
ALTER TABLE `vibe_ngo_v1`.`program`.`target_population` ALTER COLUMN `population_name` SET TAGS ('pii_business_glossary_term' = 'Target Population Name');
ALTER TABLE `vibe_ngo_v1`.`program`.`target_population` ALTER COLUMN `population_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`program`.`target_population` ALTER COLUMN `population_name` SET TAGS ('pii_type' = 'name');
ALTER TABLE `vibe_ngo_v1`.`program`.`target_population` ALTER COLUMN `protection_mainstreaming_flag` SET TAGS ('pii_business_glossary_term' = 'Protection Mainstreaming Flag');
ALTER TABLE `vibe_ngo_v1`.`program`.`target_population` ALTER COLUMN `refugee_population_count` SET TAGS ('pii_business_glossary_term' = 'Refugee Population Count');
ALTER TABLE `vibe_ngo_v1`.`program`.`target_population` ALTER COLUMN `revision_number` SET TAGS ('pii_business_glossary_term' = 'Revision Number');
ALTER TABLE `vibe_ngo_v1`.`program`.`target_population` ALTER COLUMN `revision_reason` SET TAGS ('pii_business_glossary_term' = 'Revision Reason');
ALTER TABLE `vibe_ngo_v1`.`program`.`target_population` ALTER COLUMN `sdg_alignment` SET TAGS ('pii_business_glossary_term' = 'Sustainable Development Goal (SDG) Alignment');
ALTER TABLE `vibe_ngo_v1`.`program`.`target_population` ALTER COLUMN `sector_classification` SET TAGS ('pii_business_glossary_term' = 'Sector Classification');
ALTER TABLE `vibe_ngo_v1`.`program`.`target_population` ALTER COLUMN `sex_disaggregation` SET TAGS ('pii_business_glossary_term' = 'Sex Disaggregation');
ALTER TABLE `vibe_ngo_v1`.`program`.`target_population` ALTER COLUMN `sex_disaggregation` SET TAGS ('pii_value_regex' = 'all|male|female|other|mixed');
ALTER TABLE `vibe_ngo_v1`.`program`.`target_population` ALTER COLUMN `sex_disaggregation` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`program`.`target_population` ALTER COLUMN `sex_disaggregation` SET TAGS ('pii_type' = 'gender');
ALTER TABLE `vibe_ngo_v1`.`program`.`target_population` ALTER COLUMN `target_population_status` SET TAGS ('pii_business_glossary_term' = 'Target Population Status');
ALTER TABLE `vibe_ngo_v1`.`program`.`target_population` ALTER COLUMN `target_population_status` SET TAGS ('pii_value_regex' = 'draft|approved|active|suspended|closed');
ALTER TABLE `vibe_ngo_v1`.`program`.`target_population` ALTER COLUMN `targeting_methodology` SET TAGS ('pii_business_glossary_term' = 'Targeting Methodology');
ALTER TABLE `vibe_ngo_v1`.`program`.`target_population` ALTER COLUMN `vulnerability_category` SET TAGS ('pii_business_glossary_term' = 'Vulnerability Category');
ALTER TABLE `vibe_ngo_v1`.`program`.`program_amendment` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_ngo_v1`.`program`.`program_amendment` SET TAGS ('pii_subdomain' = 'program_design');
ALTER TABLE `vibe_ngo_v1`.`program`.`program_amendment` SET TAGS ('pii_tier' = 'mvm');
ALTER TABLE `vibe_ngo_v1`.`program`.`program_amendment` SET TAGS ('pii_domain' = 'program');
ALTER TABLE `vibe_ngo_v1`.`program`.`program_amendment` SET TAGS ('pii_ssot' = 'true');
ALTER TABLE `vibe_ngo_v1`.`program`.`program_amendment` SET TAGS ('pii_ssot_scope' = 'program_design_amendment');
ALTER TABLE `vibe_ngo_v1`.`program`.`program_amendment` SET TAGS ('pii_ssot_owner' = 'program');
ALTER TABLE `vibe_ngo_v1`.`program`.`program_amendment` SET TAGS ('pii_ssot_boundary' = 'programme_amendment');
ALTER TABLE `vibe_ngo_v1`.`program`.`program_amendment` SET TAGS ('pii_disambiguated_from' = 'grant.grant_amendment');
ALTER TABLE `vibe_ngo_v1`.`program`.`program_amendment` ALTER COLUMN `program_amendment_id` SET TAGS ('pii_business_glossary_term' = 'Program Amendment Identifier (ID)');
ALTER TABLE `vibe_ngo_v1`.`program`.`program_amendment` ALTER COLUMN `award_id` SET TAGS ('pii_business_glossary_term' = 'Award Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`program`.`program_amendment` ALTER COLUMN `staff_member_id` SET TAGS ('pii_business_glossary_term' = 'Created By Staff Member Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`program`.`program_amendment` ALTER COLUMN `staff_member_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`program`.`program_amendment` ALTER COLUMN `staff_member_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_ngo_v1`.`program`.`program_amendment` ALTER COLUMN `intervention_id` SET TAGS ('pii_business_glossary_term' = 'Program Identifier (ID)');
ALTER TABLE `vibe_ngo_v1`.`program`.`program_amendment` ALTER COLUMN `regulatory_filing_id` SET TAGS ('pii_business_glossary_term' = 'Regulatory Filing Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`program`.`program_amendment` ALTER COLUMN `amendment_number` SET TAGS ('pii_business_glossary_term' = 'Amendment Number');
ALTER TABLE `vibe_ngo_v1`.`program`.`program_amendment` ALTER COLUMN `amendment_status` SET TAGS ('pii_business_glossary_term' = 'Amendment Status');
ALTER TABLE `vibe_ngo_v1`.`program`.`program_amendment` ALTER COLUMN `amendment_status` SET TAGS ('pii_value_regex' = 'draft|submitted|under_review|approved|rejected|withdrawn');
ALTER TABLE `vibe_ngo_v1`.`program`.`program_amendment` ALTER COLUMN `amendment_type` SET TAGS ('pii_business_glossary_term' = 'Amendment Type');
ALTER TABLE `vibe_ngo_v1`.`program`.`program_amendment` ALTER COLUMN `amendment_type` SET TAGS ('pii_value_regex' = 'no_cost_extension|scope_change|budget_reallocation|geographic_expansion|target_population_adjustment|logframe_revision');
ALTER TABLE `vibe_ngo_v1`.`program`.`program_amendment` ALTER COLUMN `approval_date` SET TAGS ('pii_business_glossary_term' = 'Amendment Approval Date');
ALTER TABLE `vibe_ngo_v1`.`program`.`program_amendment` ALTER COLUMN `audit_trail_notes` SET TAGS ('pii_business_glossary_term' = 'Audit Trail Notes');
ALTER TABLE `vibe_ngo_v1`.`program`.`program_amendment` ALTER COLUMN `budget_change_amount` SET TAGS ('pii_business_glossary_term' = 'Budget Change Amount');
ALTER TABLE `vibe_ngo_v1`.`program`.`program_amendment` ALTER COLUMN `budget_change_currency` SET TAGS ('pii_business_glossary_term' = 'Budget Change Currency Code');
ALTER TABLE `vibe_ngo_v1`.`program`.`program_amendment` ALTER COLUMN `compliance_impact_assessment` SET TAGS ('pii_business_glossary_term' = 'Compliance Impact Assessment');
ALTER TABLE `vibe_ngo_v1`.`program`.`program_amendment` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Amendment Record Created Timestamp');
ALTER TABLE `vibe_ngo_v1`.`program`.`program_amendment` ALTER COLUMN `donor_approval_reference` SET TAGS ('pii_business_glossary_term' = 'Donor Approval Reference Number');
ALTER TABLE `vibe_ngo_v1`.`program`.`program_amendment` ALTER COLUMN `donor_approving_authority` SET TAGS ('pii_business_glossary_term' = 'Donor Approving Authority');
ALTER TABLE `vibe_ngo_v1`.`program`.`program_amendment` ALTER COLUMN `effective_date` SET TAGS ('pii_business_glossary_term' = 'Amendment Effective Date');
ALTER TABLE `vibe_ngo_v1`.`program`.`program_amendment` ALTER COLUMN `geographic_coverage_change` SET TAGS ('pii_business_glossary_term' = 'Geographic Coverage Change Description');
ALTER TABLE `vibe_ngo_v1`.`program`.`program_amendment` ALTER COLUMN `grant_requirement_flag` SET TAGS ('pii_business_glossary_term' = 'Grant Requirement Flag');
ALTER TABLE `vibe_ngo_v1`.`program`.`program_amendment` ALTER COLUMN `internal_approving_authority` SET TAGS ('pii_business_glossary_term' = 'Internal Approving Authority');
ALTER TABLE `vibe_ngo_v1`.`program`.`program_amendment` ALTER COLUMN `justification_narrative` SET TAGS ('pii_business_glossary_term' = 'Amendment Justification Narrative');
ALTER TABLE `vibe_ngo_v1`.`program`.`program_amendment` ALTER COLUMN `last_modified_by` SET TAGS ('pii_business_glossary_term' = 'Amendment Last Modified By User');
ALTER TABLE `vibe_ngo_v1`.`program`.`program_amendment` ALTER COLUMN `last_modified_timestamp` SET TAGS ('pii_business_glossary_term' = 'Amendment Record Last Modified Timestamp');
ALTER TABLE `vibe_ngo_v1`.`program`.`program_amendment` ALTER COLUMN `logframe_revision_flag` SET TAGS ('pii_business_glossary_term' = 'Logical Framework (LogFrame) Revision Flag');
ALTER TABLE `vibe_ngo_v1`.`program`.`program_amendment` ALTER COLUMN `logframe_revision_summary` SET TAGS ('pii_business_glossary_term' = 'Logical Framework (LogFrame) Revision Summary');
ALTER TABLE `vibe_ngo_v1`.`program`.`program_amendment` ALTER COLUMN `original_end_date` SET TAGS ('pii_business_glossary_term' = 'Original Program End Date');
ALTER TABLE `vibe_ngo_v1`.`program`.`program_amendment` ALTER COLUMN `original_target_beneficiaries` SET TAGS ('pii_business_glossary_term' = 'Original Target Beneficiaries Count');
ALTER TABLE `vibe_ngo_v1`.`program`.`program_amendment` ALTER COLUMN `rejection_reason` SET TAGS ('pii_business_glossary_term' = 'Amendment Rejection Reason');
ALTER TABLE `vibe_ngo_v1`.`program`.`program_amendment` ALTER COLUMN `revised_end_date` SET TAGS ('pii_business_glossary_term' = 'Revised Program End Date');
ALTER TABLE `vibe_ngo_v1`.`program`.`program_amendment` ALTER COLUMN `revised_target_beneficiaries` SET TAGS ('pii_business_glossary_term' = 'Revised Target Beneficiaries Count');
ALTER TABLE `vibe_ngo_v1`.`program`.`program_amendment` ALTER COLUMN `risk_assessment` SET TAGS ('pii_business_glossary_term' = 'Amendment Risk Assessment');
ALTER TABLE `vibe_ngo_v1`.`program`.`program_amendment` ALTER COLUMN `scope_change_description` SET TAGS ('pii_business_glossary_term' = 'Scope Change Description');
ALTER TABLE `vibe_ngo_v1`.`program`.`program_amendment` ALTER COLUMN `sdg_alignment_change` SET TAGS ('pii_business_glossary_term' = 'Sustainable Development Goal (SDG) Alignment Change');
ALTER TABLE `vibe_ngo_v1`.`program`.`program_amendment` ALTER COLUMN `sector_classification_change` SET TAGS ('pii_business_glossary_term' = 'Sector Classification Change Description');
ALTER TABLE `vibe_ngo_v1`.`program`.`program_amendment` ALTER COLUMN `stakeholder_consultation_summary` SET TAGS ('pii_business_glossary_term' = 'Stakeholder Consultation Summary');
ALTER TABLE `vibe_ngo_v1`.`program`.`program_amendment` ALTER COLUMN `submission_date` SET TAGS ('pii_business_glossary_term' = 'Amendment Submission Date');
ALTER TABLE `vibe_ngo_v1`.`program`.`program_amendment` ALTER COLUMN `supporting_documentation_reference` SET TAGS ('pii_business_glossary_term' = 'Supporting Documentation Reference');
ALTER TABLE `vibe_ngo_v1`.`program`.`program_amendment` ALTER COLUMN `target_population_change` SET TAGS ('pii_business_glossary_term' = 'Target Population Change Description');
ALTER TABLE `vibe_ngo_v1`.`program`.`program_amendment` ALTER COLUMN `timeline_extension_days` SET TAGS ('pii_business_glossary_term' = 'Timeline Extension Days');
ALTER TABLE `vibe_ngo_v1`.`program`.`program_amendment` ALTER COLUMN `withdrawal_reason` SET TAGS ('pii_business_glossary_term' = 'Amendment Withdrawal Reason');
ALTER TABLE `vibe_ngo_v1`.`program`.`design_assessment` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_ngo_v1`.`program`.`design_assessment` SET TAGS ('pii_subdomain' = 'program_design');
ALTER TABLE `vibe_ngo_v1`.`program`.`design_assessment` SET TAGS ('pii_tier' = 'mvm');
ALTER TABLE `vibe_ngo_v1`.`program`.`design_assessment` SET TAGS ('pii_domain' = 'program');
ALTER TABLE `vibe_ngo_v1`.`program`.`design_assessment` ALTER COLUMN `design_assessment_id` SET TAGS ('pii_business_glossary_term' = 'Design Assessment ID');
ALTER TABLE `vibe_ngo_v1`.`program`.`design_assessment` ALTER COLUMN `obligation_id` SET TAGS ('pii_business_glossary_term' = 'Compliance Obligation Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`program`.`design_assessment` ALTER COLUMN `intervention_id` SET TAGS ('pii_business_glossary_term' = 'Program ID');
ALTER TABLE `vibe_ngo_v1`.`program`.`design_assessment` ALTER COLUMN `admin_level_1` SET TAGS ('pii_business_glossary_term' = 'Administrative Level 1');
ALTER TABLE `vibe_ngo_v1`.`program`.`design_assessment` ALTER COLUMN `admin_level_2` SET TAGS ('pii_business_glossary_term' = 'Administrative Level 2');
ALTER TABLE `vibe_ngo_v1`.`program`.`design_assessment` ALTER COLUMN `assessment_code` SET TAGS ('pii_business_glossary_term' = 'Assessment Code');
ALTER TABLE `vibe_ngo_v1`.`program`.`design_assessment` ALTER COLUMN `assessment_code` SET TAGS ('pii_value_regex' = '^[A-Z0-9]{6,20}$');
ALTER TABLE `vibe_ngo_v1`.`program`.`design_assessment` ALTER COLUMN `assessment_status` SET TAGS ('pii_business_glossary_term' = 'Assessment Status');
ALTER TABLE `vibe_ngo_v1`.`program`.`design_assessment` ALTER COLUMN `assessment_status` SET TAGS ('pii_value_regex' = 'planned|in_progress|completed|validated|archived');
ALTER TABLE `vibe_ngo_v1`.`program`.`design_assessment` ALTER COLUMN `assessment_team_lead` SET TAGS ('pii_business_glossary_term' = 'Assessment Team Lead');
ALTER TABLE `vibe_ngo_v1`.`program`.`design_assessment` ALTER COLUMN `assessment_team_size` SET TAGS ('pii_business_glossary_term' = 'Assessment Team Size');
ALTER TABLE `vibe_ngo_v1`.`program`.`design_assessment` ALTER COLUMN `assessment_title` SET TAGS ('pii_business_glossary_term' = 'Assessment Title');
ALTER TABLE `vibe_ngo_v1`.`program`.`design_assessment` ALTER COLUMN `assessment_type` SET TAGS ('pii_business_glossary_term' = 'Assessment Type');
ALTER TABLE `vibe_ngo_v1`.`program`.`design_assessment` ALTER COLUMN `assessment_type` SET TAGS ('pii_value_regex' = 'rapid|comprehensive|sectoral|baseline|midline|endline');
ALTER TABLE `vibe_ngo_v1`.`program`.`design_assessment` ALTER COLUMN `country_code` SET TAGS ('pii_business_glossary_term' = 'Country Code');
ALTER TABLE `vibe_ngo_v1`.`program`.`design_assessment` ALTER COLUMN `country_code` SET TAGS ('pii_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_ngo_v1`.`program`.`design_assessment` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_ngo_v1`.`program`.`design_assessment` ALTER COLUMN `dac_sector_code` SET TAGS ('pii_business_glossary_term' = 'Development Assistance Committee (DAC) Sector Code');
ALTER TABLE `vibe_ngo_v1`.`program`.`design_assessment` ALTER COLUMN `dac_sector_code` SET TAGS ('pii_value_regex' = '^[0-9]{5}$');
ALTER TABLE `vibe_ngo_v1`.`program`.`design_assessment` ALTER COLUMN `data_collection_end_date` SET TAGS ('pii_business_glossary_term' = 'Data Collection End Date');
ALTER TABLE `vibe_ngo_v1`.`program`.`design_assessment` ALTER COLUMN `data_collection_start_date` SET TAGS ('pii_business_glossary_term' = 'Data Collection Start Date');
ALTER TABLE `vibe_ngo_v1`.`program`.`design_assessment` ALTER COLUMN `data_quality_score` SET TAGS ('pii_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_ngo_v1`.`program`.`design_assessment` ALTER COLUMN `data_sharing_restrictions` SET TAGS ('pii_business_glossary_term' = 'Data Sharing Restrictions');
ALTER TABLE `vibe_ngo_v1`.`program`.`design_assessment` ALTER COLUMN `donor_visibility_flag` SET TAGS ('pii_business_glossary_term' = 'Donor Visibility Flag');
ALTER TABLE `vibe_ngo_v1`.`program`.`design_assessment` ALTER COLUMN `ethical_approval_obtained` SET TAGS ('pii_business_glossary_term' = 'Ethical Approval Obtained');
ALTER TABLE `vibe_ngo_v1`.`program`.`design_assessment` ALTER COLUMN `gam_prevalence_percent` SET TAGS ('pii_business_glossary_term' = 'Global Acute Malnutrition (GAM) Prevalence Percent');
ALTER TABLE `vibe_ngo_v1`.`program`.`design_assessment` ALTER COLUMN `geographic_scope` SET TAGS ('pii_business_glossary_term' = 'Geographic Scope');
ALTER TABLE `vibe_ngo_v1`.`program`.`design_assessment` ALTER COLUMN `humanitarian_principles_compliance` SET TAGS ('pii_business_glossary_term' = 'Humanitarian Principles Compliance');
ALTER TABLE `vibe_ngo_v1`.`program`.`design_assessment` ALTER COLUMN `humanitarian_principles_compliance` SET TAGS ('pii_value_regex' = 'full|partial|not_applicable');
ALTER TABLE `vibe_ngo_v1`.`program`.`design_assessment` ALTER COLUMN `key_findings_summary` SET TAGS ('pii_business_glossary_term' = 'Key Findings Summary');
ALTER TABLE `vibe_ngo_v1`.`program`.`design_assessment` ALTER COLUMN `last_modified_timestamp` SET TAGS ('pii_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_ngo_v1`.`program`.`design_assessment` ALTER COLUMN `methodology` SET TAGS ('pii_business_glossary_term' = 'Methodology');
ALTER TABLE `vibe_ngo_v1`.`program`.`design_assessment` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_ngo_v1`.`program`.`design_assessment` ALTER COLUMN `population_assessed` SET TAGS ('pii_business_glossary_term' = 'Population Assessed');
ALTER TABLE `vibe_ngo_v1`.`program`.`design_assessment` ALTER COLUMN `priority_needs_ranking` SET TAGS ('pii_business_glossary_term' = 'Priority Needs Ranking');
ALTER TABLE `vibe_ngo_v1`.`program`.`design_assessment` ALTER COLUMN `protection_risks_identified` SET TAGS ('pii_business_glossary_term' = 'Protection Risks Identified');
ALTER TABLE `vibe_ngo_v1`.`program`.`design_assessment` ALTER COLUMN `report_url` SET TAGS ('pii_business_glossary_term' = 'Report Uniform Resource Locator (URL)');
ALTER TABLE `vibe_ngo_v1`.`program`.`design_assessment` ALTER COLUMN `sam_prevalence_percent` SET TAGS ('pii_business_glossary_term' = 'Severe Acute Malnutrition (SAM) Prevalence Percent');
ALTER TABLE `vibe_ngo_v1`.`program`.`design_assessment` ALTER COLUMN `sdg_alignment` SET TAGS ('pii_business_glossary_term' = 'Sustainable Development Goal (SDG) Alignment');
ALTER TABLE `vibe_ngo_v1`.`program`.`design_assessment` ALTER COLUMN `sector_focus` SET TAGS ('pii_business_glossary_term' = 'Sector Focus');
ALTER TABLE `vibe_ngo_v1`.`program`.`design_assessment` ALTER COLUMN `target_population_description` SET TAGS ('pii_business_glossary_term' = 'Target Population Description');
ALTER TABLE `vibe_ngo_v1`.`program`.`design_assessment` ALTER COLUMN `validated_by` SET TAGS ('pii_business_glossary_term' = 'Validated By');
ALTER TABLE `vibe_ngo_v1`.`program`.`design_assessment` ALTER COLUMN `validation_date` SET TAGS ('pii_business_glossary_term' = 'Validation Date');
ALTER TABLE `vibe_ngo_v1`.`program`.`design_assessment` ALTER COLUMN `wash_coverage_gap_percent` SET TAGS ('pii_business_glossary_term' = 'Water Sanitation and Hygiene (WASH) Coverage Gap Percent');
ALTER TABLE `vibe_ngo_v1`.`program`.`risk_register` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_ngo_v1`.`program`.`risk_register` SET TAGS ('pii_subdomain' = 'results_framework');
ALTER TABLE `vibe_ngo_v1`.`program`.`risk_register` SET TAGS ('pii_domain' = 'program');
ALTER TABLE `vibe_ngo_v1`.`program`.`risk_register` SET TAGS ('pii_tier' = 'mvm');
ALTER TABLE `vibe_ngo_v1`.`program`.`risk_register` ALTER COLUMN `risk_register_id` SET TAGS ('pii_business_glossary_term' = 'Risk Register ID');
ALTER TABLE `vibe_ngo_v1`.`program`.`risk_register` ALTER COLUMN `staff_member_id` SET TAGS ('pii_business_glossary_term' = 'Approved By Staff Member Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`program`.`risk_register` ALTER COLUMN `staff_member_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`program`.`risk_register` ALTER COLUMN `staff_member_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_ngo_v1`.`program`.`risk_register` ALTER COLUMN `compliance_incident_id` SET TAGS ('pii_business_glossary_term' = 'Compliance Incident Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`program`.`risk_register` ALTER COLUMN `intervention_id` SET TAGS ('pii_business_glossary_term' = 'Program ID');
ALTER TABLE `vibe_ngo_v1`.`program`.`risk_register` ALTER COLUMN `affected_sdg` SET TAGS ('pii_business_glossary_term' = 'Affected Sustainable Development Goal (SDG)');
ALTER TABLE `vibe_ngo_v1`.`program`.`risk_register` ALTER COLUMN `affected_sector` SET TAGS ('pii_business_glossary_term' = 'Affected Sector');
ALTER TABLE `vibe_ngo_v1`.`program`.`risk_register` ALTER COLUMN `approval_date` SET TAGS ('pii_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_ngo_v1`.`program`.`risk_register` ALTER COLUMN `closure_date` SET TAGS ('pii_business_glossary_term' = 'Closure Date');
ALTER TABLE `vibe_ngo_v1`.`program`.`risk_register` ALTER COLUMN `contingency_plan` SET TAGS ('pii_business_glossary_term' = 'Contingency Plan');
ALTER TABLE `vibe_ngo_v1`.`program`.`risk_register` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_ngo_v1`.`program`.`risk_register` ALTER COLUMN `donor_visibility_flag` SET TAGS ('pii_business_glossary_term' = 'Donor Visibility Flag');
ALTER TABLE `vibe_ngo_v1`.`program`.`risk_register` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_ngo_v1`.`program`.`risk_register` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_ngo_v1`.`program`.`risk_register` ALTER COLUMN `escalation_required_flag` SET TAGS ('pii_business_glossary_term' = 'Escalation Required Flag');
ALTER TABLE `vibe_ngo_v1`.`program`.`risk_register` ALTER COLUMN `geographic_scope` SET TAGS ('pii_business_glossary_term' = 'Geographic Scope');
ALTER TABLE `vibe_ngo_v1`.`program`.`risk_register` ALTER COLUMN `identification_date` SET TAGS ('pii_business_glossary_term' = 'Identification Date');
ALTER TABLE `vibe_ngo_v1`.`program`.`risk_register` ALTER COLUMN `impact_rating` SET TAGS ('pii_business_glossary_term' = 'Impact Rating');
ALTER TABLE `vibe_ngo_v1`.`program`.`risk_register` ALTER COLUMN `impact_rating` SET TAGS ('pii_value_regex' = 'very low|low|medium|high|very high');
ALTER TABLE `vibe_ngo_v1`.`program`.`risk_register` ALTER COLUMN `impact_score` SET TAGS ('pii_business_glossary_term' = 'Impact Score');
ALTER TABLE `vibe_ngo_v1`.`program`.`risk_register` ALTER COLUMN `inherent_risk_score` SET TAGS ('pii_business_glossary_term' = 'Inherent Risk Score');
ALTER TABLE `vibe_ngo_v1`.`program`.`risk_register` ALTER COLUMN `last_modified_timestamp` SET TAGS ('pii_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_ngo_v1`.`program`.`risk_register` ALTER COLUMN `last_review_date` SET TAGS ('pii_business_glossary_term' = 'Last Review Date');
ALTER TABLE `vibe_ngo_v1`.`program`.`risk_register` ALTER COLUMN `likelihood_rating` SET TAGS ('pii_business_glossary_term' = 'Likelihood Rating');
ALTER TABLE `vibe_ngo_v1`.`program`.`risk_register` ALTER COLUMN `likelihood_rating` SET TAGS ('pii_value_regex' = 'very low|low|medium|high|very high');
ALTER TABLE `vibe_ngo_v1`.`program`.`risk_register` ALTER COLUMN `likelihood_score` SET TAGS ('pii_business_glossary_term' = 'Likelihood Score');
ALTER TABLE `vibe_ngo_v1`.`program`.`risk_register` ALTER COLUMN `mitigation_strategy` SET TAGS ('pii_business_glossary_term' = 'Mitigation Strategy');
ALTER TABLE `vibe_ngo_v1`.`program`.`risk_register` ALTER COLUMN `next_review_date` SET TAGS ('pii_business_glossary_term' = 'Next Review Date');
ALTER TABLE `vibe_ngo_v1`.`program`.`risk_register` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_ngo_v1`.`program`.`risk_register` ALTER COLUMN `residual_risk_score` SET TAGS ('pii_business_glossary_term' = 'Residual Risk Score');
ALTER TABLE `vibe_ngo_v1`.`program`.`risk_register` ALTER COLUMN `revision_reason` SET TAGS ('pii_business_glossary_term' = 'Revision Reason');
ALTER TABLE `vibe_ngo_v1`.`program`.`risk_register` ALTER COLUMN `risk_category` SET TAGS ('pii_business_glossary_term' = 'Risk Category');
ALTER TABLE `vibe_ngo_v1`.`program`.`risk_register` ALTER COLUMN `risk_category` SET TAGS ('pii_value_regex' = 'operational|contextual|institutional|fiduciary|programmatic|reputational');
ALTER TABLE `vibe_ngo_v1`.`program`.`risk_register` ALTER COLUMN `risk_code` SET TAGS ('pii_business_glossary_term' = 'Risk Code');
ALTER TABLE `vibe_ngo_v1`.`program`.`risk_register` ALTER COLUMN `risk_code` SET TAGS ('pii_value_regex' = '^[A-Z]{2,4}-[0-9]{3,5}$');
ALTER TABLE `vibe_ngo_v1`.`program`.`risk_register` ALTER COLUMN `risk_description` SET TAGS ('pii_business_glossary_term' = 'Risk Description');
ALTER TABLE `vibe_ngo_v1`.`program`.`risk_register` ALTER COLUMN `risk_level` SET TAGS ('pii_business_glossary_term' = 'Risk Level');
ALTER TABLE `vibe_ngo_v1`.`program`.`risk_register` ALTER COLUMN `risk_level` SET TAGS ('pii_value_regex' = 'low|moderate|high|critical');
ALTER TABLE `vibe_ngo_v1`.`program`.`risk_register` ALTER COLUMN `risk_owner` SET TAGS ('pii_business_glossary_term' = 'Risk Owner');
ALTER TABLE `vibe_ngo_v1`.`program`.`risk_register` ALTER COLUMN `risk_owner_email` SET TAGS ('pii_business_glossary_term' = 'Risk Owner Email');
ALTER TABLE `vibe_ngo_v1`.`program`.`risk_register` ALTER COLUMN `risk_owner_email` SET TAGS ('pii_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_ngo_v1`.`program`.`risk_register` ALTER COLUMN `risk_owner_email` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`program`.`risk_register` ALTER COLUMN `risk_owner_email` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`program`.`risk_register` ALTER COLUMN `risk_owner_email` SET TAGS ('pii_type' = 'email');
ALTER TABLE `vibe_ngo_v1`.`program`.`risk_register` ALTER COLUMN `risk_status` SET TAGS ('pii_business_glossary_term' = 'Risk Status');
ALTER TABLE `vibe_ngo_v1`.`program`.`risk_register` ALTER COLUMN `risk_status` SET TAGS ('pii_value_regex' = 'open|monitoring|mitigated|closed|materialized');
ALTER TABLE `vibe_ngo_v1`.`program`.`risk_register` ALTER COLUMN `risk_subcategory` SET TAGS ('pii_business_glossary_term' = 'Risk Subcategory');
ALTER TABLE `vibe_ngo_v1`.`program`.`risk_register` ALTER COLUMN `risk_title` SET TAGS ('pii_business_glossary_term' = 'Risk Title');
ALTER TABLE `vibe_ngo_v1`.`program`.`risk_register` ALTER COLUMN `version_number` SET TAGS ('pii_business_glossary_term' = 'Version Number');
ALTER TABLE `vibe_ngo_v1`.`program`.`implementation_plan` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_ngo_v1`.`program`.`implementation_plan` SET TAGS ('pii_subdomain' = 'delivery_planning');
ALTER TABLE `vibe_ngo_v1`.`program`.`implementation_plan` SET TAGS ('pii_tier' = 'mvm');
ALTER TABLE `vibe_ngo_v1`.`program`.`implementation_plan` SET TAGS ('pii_domain' = 'program');
ALTER TABLE `vibe_ngo_v1`.`program`.`implementation_plan` ALTER COLUMN `implementation_plan_id` SET TAGS ('pii_business_glossary_term' = 'Implementation Plan ID');
ALTER TABLE `vibe_ngo_v1`.`program`.`implementation_plan` ALTER COLUMN `staff_member_id` SET TAGS ('pii_business_glossary_term' = 'Approved By Staff Member Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`program`.`implementation_plan` ALTER COLUMN `staff_member_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`program`.`implementation_plan` ALTER COLUMN `staff_member_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_ngo_v1`.`program`.`implementation_plan` ALTER COLUMN `donor_requirement_id` SET TAGS ('pii_business_glossary_term' = 'Donor Compliance Req Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`program`.`implementation_plan` ALTER COLUMN `intervention_id` SET TAGS ('pii_business_glossary_term' = 'Program ID');
ALTER TABLE `vibe_ngo_v1`.`program`.`implementation_plan` ALTER COLUMN `approval_date` SET TAGS ('pii_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_ngo_v1`.`program`.`implementation_plan` ALTER COLUMN `assumptions` SET TAGS ('pii_business_glossary_term' = 'Implementation Assumptions');
ALTER TABLE `vibe_ngo_v1`.`program`.`implementation_plan` ALTER COLUMN `budget_allocated_amount` SET TAGS ('pii_business_glossary_term' = 'Budget Allocated Amount');
ALTER TABLE `vibe_ngo_v1`.`program`.`implementation_plan` ALTER COLUMN `budget_currency_code` SET TAGS ('pii_business_glossary_term' = 'Budget Currency Code');
ALTER TABLE `vibe_ngo_v1`.`program`.`implementation_plan` ALTER COLUMN `coordination_mechanism` SET TAGS ('pii_business_glossary_term' = 'Coordination Mechanism');
ALTER TABLE `vibe_ngo_v1`.`program`.`implementation_plan` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_ngo_v1`.`program`.`implementation_plan` ALTER COLUMN `dac_sector_code` SET TAGS ('pii_business_glossary_term' = 'Development Assistance Committee (DAC) Sector Code');
ALTER TABLE `vibe_ngo_v1`.`program`.`implementation_plan` ALTER COLUMN `dac_sector_code` SET TAGS ('pii_value_regex' = '^[0-9]{5}$');
ALTER TABLE `vibe_ngo_v1`.`program`.`implementation_plan` ALTER COLUMN `disaggregation_approach` SET TAGS ('pii_business_glossary_term' = 'Disaggregation Approach');
ALTER TABLE `vibe_ngo_v1`.`program`.`implementation_plan` ALTER COLUMN `donor_visibility_flag` SET TAGS ('pii_business_glossary_term' = 'Donor Visibility Flag');
ALTER TABLE `vibe_ngo_v1`.`program`.`implementation_plan` ALTER COLUMN `geographic_scope` SET TAGS ('pii_business_glossary_term' = 'Geographic Scope');
ALTER TABLE `vibe_ngo_v1`.`program`.`implementation_plan` ALTER COLUMN `grant_requirement_flag` SET TAGS ('pii_business_glossary_term' = 'Grant Requirement Flag');
ALTER TABLE `vibe_ngo_v1`.`program`.`implementation_plan` ALTER COLUMN `last_modified_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `vibe_ngo_v1`.`program`.`implementation_plan` ALTER COLUMN `last_revision_date` SET TAGS ('pii_business_glossary_term' = 'Last Revision Date');
ALTER TABLE `vibe_ngo_v1`.`program`.`implementation_plan` ALTER COLUMN `logframe_reference` SET TAGS ('pii_business_glossary_term' = 'Logical Framework (LogFrame) Reference');
ALTER TABLE `vibe_ngo_v1`.`program`.`implementation_plan` ALTER COLUMN `monitoring_approach` SET TAGS ('pii_business_glossary_term' = 'Monitoring Approach');
ALTER TABLE `vibe_ngo_v1`.`program`.`implementation_plan` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Implementation Plan Notes');
ALTER TABLE `vibe_ngo_v1`.`program`.`implementation_plan` ALTER COLUMN `plan_code` SET TAGS ('pii_business_glossary_term' = 'Implementation Plan Code');
ALTER TABLE `vibe_ngo_v1`.`program`.`implementation_plan` ALTER COLUMN `plan_code` SET TAGS ('pii_value_regex' = '^[A-Z0-9]{6,20}$');
ALTER TABLE `vibe_ngo_v1`.`program`.`implementation_plan` ALTER COLUMN `plan_manager_name` SET TAGS ('pii_business_glossary_term' = 'Implementation Plan Manager Name');
ALTER TABLE `vibe_ngo_v1`.`program`.`implementation_plan` ALTER COLUMN `plan_manager_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`program`.`implementation_plan` ALTER COLUMN `plan_manager_name` SET TAGS ('pii_type' = 'age');
ALTER TABLE `vibe_ngo_v1`.`program`.`implementation_plan` ALTER COLUMN `plan_status` SET TAGS ('pii_business_glossary_term' = 'Implementation Plan Status');
ALTER TABLE `vibe_ngo_v1`.`program`.`implementation_plan` ALTER COLUMN `plan_title` SET TAGS ('pii_business_glossary_term' = 'Implementation Plan Title');
ALTER TABLE `vibe_ngo_v1`.`program`.`implementation_plan` ALTER COLUMN `plan_type` SET TAGS ('pii_business_glossary_term' = 'Implementation Plan Type');
ALTER TABLE `vibe_ngo_v1`.`program`.`implementation_plan` ALTER COLUMN `plan_type` SET TAGS ('pii_value_regex' = 'annual|quarterly|project_phase|emergency_response|pilot|scale_up');
ALTER TABLE `vibe_ngo_v1`.`program`.`implementation_plan` ALTER COLUMN `plan_version` SET TAGS ('pii_business_glossary_term' = 'Plan Version Number');
ALTER TABLE `vibe_ngo_v1`.`program`.`implementation_plan` ALTER COLUMN `plan_version` SET TAGS ('pii_value_regex' = '^[0-9]+.[0-9]+$');
ALTER TABLE `vibe_ngo_v1`.`program`.`implementation_plan` ALTER COLUMN `planning_period_end_date` SET TAGS ('pii_business_glossary_term' = 'Planning Period End Date');
ALTER TABLE `vibe_ngo_v1`.`program`.`implementation_plan` ALTER COLUMN `planning_period_start_date` SET TAGS ('pii_business_glossary_term' = 'Planning Period Start Date');
ALTER TABLE `vibe_ngo_v1`.`program`.`implementation_plan` ALTER COLUMN `reporting_frequency` SET TAGS ('pii_business_glossary_term' = 'Reporting Frequency');
ALTER TABLE `vibe_ngo_v1`.`program`.`implementation_plan` ALTER COLUMN `resource_requirements_summary` SET TAGS ('pii_business_glossary_term' = 'Resource Requirements Summary');
ALTER TABLE `vibe_ngo_v1`.`program`.`implementation_plan` ALTER COLUMN `responsible_unit` SET TAGS ('pii_business_glossary_term' = 'Responsible Organizational Unit');
ALTER TABLE `vibe_ngo_v1`.`program`.`implementation_plan` ALTER COLUMN `revision_reason` SET TAGS ('pii_business_glossary_term' = 'Revision Reason');
ALTER TABLE `vibe_ngo_v1`.`program`.`implementation_plan` ALTER COLUMN `risk_level` SET TAGS ('pii_business_glossary_term' = 'Implementation Risk Level');
ALTER TABLE `vibe_ngo_v1`.`program`.`implementation_plan` ALTER COLUMN `risk_level` SET TAGS ('pii_value_regex' = 'low|medium|high|critical');
ALTER TABLE `vibe_ngo_v1`.`program`.`implementation_plan` ALTER COLUMN `risk_mitigation_summary` SET TAGS ('pii_business_glossary_term' = 'Risk Mitigation Summary');
ALTER TABLE `vibe_ngo_v1`.`program`.`implementation_plan` ALTER COLUMN `sector_classification` SET TAGS ('pii_business_glossary_term' = 'Sector Classification');
ALTER TABLE `vibe_ngo_v1`.`program`.`implementation_plan` ALTER COLUMN `target_beneficiary_count` SET TAGS ('pii_business_glossary_term' = 'Target Beneficiary Count');
ALTER TABLE `vibe_ngo_v1`.`program`.`implementation_plan` ALTER COLUMN `target_beneficiary_type` SET TAGS ('pii_business_glossary_term' = 'Target Beneficiary Type');
ALTER TABLE `vibe_ngo_v1`.`program`.`implementation_plan` ALTER COLUMN `target_beneficiary_type` SET TAGS ('pii_value_regex' = 'individuals|households|communities|institutions');
ALTER TABLE `vibe_ngo_v1`.`program`.`implementation_plan` ALTER COLUMN `toc_reference` SET TAGS ('pii_business_glossary_term' = 'Theory of Change (ToC) Reference');
ALTER TABLE `vibe_ngo_v1`.`program`.`implementation_plan` ALTER COLUMN `total_planned_activities` SET TAGS ('pii_business_glossary_term' = 'Total Planned Activities Count');
ALTER TABLE `vibe_ngo_v1`.`program`.`implementation_plan` ALTER COLUMN `total_planned_milestones` SET TAGS ('pii_business_glossary_term' = 'Total Planned Milestones Count');
ALTER TABLE `vibe_ngo_v1`.`program`.`budget_plan` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_ngo_v1`.`program`.`budget_plan` SET TAGS ('pii_subdomain' = 'delivery_planning');
ALTER TABLE `vibe_ngo_v1`.`program`.`budget_plan` SET TAGS ('pii_tier' = 'mvm');
ALTER TABLE `vibe_ngo_v1`.`program`.`budget_plan` SET TAGS ('pii_domain' = 'program');
ALTER TABLE `vibe_ngo_v1`.`program`.`budget_plan` ALTER COLUMN `budget_plan_id` SET TAGS ('pii_business_glossary_term' = 'Budget Plan ID');
ALTER TABLE `vibe_ngo_v1`.`program`.`budget_plan` ALTER COLUMN `staff_member_id` SET TAGS ('pii_business_glossary_term' = 'Approved By Staff Member Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`program`.`budget_plan` ALTER COLUMN `staff_member_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`program`.`budget_plan` ALTER COLUMN `staff_member_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_ngo_v1`.`program`.`budget_plan` ALTER COLUMN `award_id` SET TAGS ('pii_business_glossary_term' = 'Grant ID');
ALTER TABLE `vibe_ngo_v1`.`program`.`budget_plan` ALTER COLUMN `budget_id` SET TAGS ('pii_business_glossary_term' = 'Budget Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`program`.`budget_plan` ALTER COLUMN `donor_fund_id` SET TAGS ('pii_business_glossary_term' = 'Fund Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`program`.`budget_plan` ALTER COLUMN `intervention_id` SET TAGS ('pii_business_glossary_term' = 'Program ID');
ALTER TABLE `vibe_ngo_v1`.`program`.`budget_plan` ALTER COLUMN `it_project_id` SET TAGS ('pii_business_glossary_term' = 'It Project Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`program`.`budget_plan` ALTER COLUMN `partnership_agreement_id` SET TAGS ('pii_business_glossary_term' = 'Partnership Agreement Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`program`.`budget_plan` ALTER COLUMN `regulatory_filing_id` SET TAGS ('pii_business_glossary_term' = 'Regulatory Filing Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`program`.`budget_plan` ALTER COLUMN `system_platform_id` SET TAGS ('pii_business_glossary_term' = 'System Platform Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`program`.`budget_plan` ALTER COLUMN `amendment_date` SET TAGS ('pii_business_glossary_term' = 'Amendment Date');
ALTER TABLE `vibe_ngo_v1`.`program`.`budget_plan` ALTER COLUMN `amendment_reason` SET TAGS ('pii_business_glossary_term' = 'Amendment Reason');
ALTER TABLE `vibe_ngo_v1`.`program`.`budget_plan` ALTER COLUMN `approval_date` SET TAGS ('pii_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_ngo_v1`.`program`.`budget_plan` ALTER COLUMN `budget_assumptions` SET TAGS ('pii_business_glossary_term' = 'Budget Assumptions');
ALTER TABLE `vibe_ngo_v1`.`program`.`budget_plan` ALTER COLUMN `budget_narrative` SET TAGS ('pii_business_glossary_term' = 'Budget Narrative');
ALTER TABLE `vibe_ngo_v1`.`program`.`budget_plan` ALTER COLUMN `budget_owner` SET TAGS ('pii_business_glossary_term' = 'Budget Owner');
ALTER TABLE `vibe_ngo_v1`.`program`.`budget_plan` ALTER COLUMN `budget_period_end_date` SET TAGS ('pii_business_glossary_term' = 'Budget Period End Date');
ALTER TABLE `vibe_ngo_v1`.`program`.`budget_plan` ALTER COLUMN `budget_period_start_date` SET TAGS ('pii_business_glossary_term' = 'Budget Period Start Date');
ALTER TABLE `vibe_ngo_v1`.`program`.`budget_plan` ALTER COLUMN `budget_plan_number` SET TAGS ('pii_business_glossary_term' = 'Budget Plan Number');
ALTER TABLE `vibe_ngo_v1`.`program`.`budget_plan` ALTER COLUMN `budget_status` SET TAGS ('pii_business_glossary_term' = 'Budget Status');
ALTER TABLE `vibe_ngo_v1`.`program`.`budget_plan` ALTER COLUMN `budget_type` SET TAGS ('pii_business_glossary_term' = 'Budget Type');
ALTER TABLE `vibe_ngo_v1`.`program`.`budget_plan` ALTER COLUMN `budget_version_number` SET TAGS ('pii_business_glossary_term' = 'Budget Version Number');
ALTER TABLE `vibe_ngo_v1`.`program`.`budget_plan` ALTER COLUMN `compliance_notes` SET TAGS ('pii_business_glossary_term' = 'Compliance Notes');
ALTER TABLE `vibe_ngo_v1`.`program`.`budget_plan` ALTER COLUMN `contractual_costs` SET TAGS ('pii_business_glossary_term' = 'Contractual Costs');
ALTER TABLE `vibe_ngo_v1`.`program`.`budget_plan` ALTER COLUMN `cost_share_amount` SET TAGS ('pii_business_glossary_term' = 'Cost Share Amount');
ALTER TABLE `vibe_ngo_v1`.`program`.`budget_plan` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_ngo_v1`.`program`.`budget_plan` ALTER COLUMN `currency_code` SET TAGS ('pii_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_ngo_v1`.`program`.`budget_plan` ALTER COLUMN `currency_code` SET TAGS ('pii_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_ngo_v1`.`program`.`budget_plan` ALTER COLUMN `dac_sector_code` SET TAGS ('pii_business_glossary_term' = 'Development Assistance Committee (DAC) Sector Code');
ALTER TABLE `vibe_ngo_v1`.`program`.`budget_plan` ALTER COLUMN `donor_budget_code` SET TAGS ('pii_business_glossary_term' = 'Donor Budget Code');
ALTER TABLE `vibe_ngo_v1`.`program`.`budget_plan` ALTER COLUMN `donor_visibility_flag` SET TAGS ('pii_business_glossary_term' = 'Donor Visibility Flag');
ALTER TABLE `vibe_ngo_v1`.`program`.`budget_plan` ALTER COLUMN `equipment_costs` SET TAGS ('pii_business_glossary_term' = 'Equipment Costs');
ALTER TABLE `vibe_ngo_v1`.`program`.`budget_plan` ALTER COLUMN `finance_contact` SET TAGS ('pii_business_glossary_term' = 'Finance Contact');
ALTER TABLE `vibe_ngo_v1`.`program`.`budget_plan` ALTER COLUMN `fringe_benefits_costs` SET TAGS ('pii_business_glossary_term' = 'Fringe Benefits Costs');
ALTER TABLE `vibe_ngo_v1`.`program`.`budget_plan` ALTER COLUMN `indirect_cost_rate` SET TAGS ('pii_business_glossary_term' = 'Indirect Cost Rate (ICR)');
ALTER TABLE `vibe_ngo_v1`.`program`.`budget_plan` ALTER COLUMN `indirect_costs` SET TAGS ('pii_business_glossary_term' = 'Indirect Costs (F&A)');
ALTER TABLE `vibe_ngo_v1`.`program`.`budget_plan` ALTER COLUMN `last_modified_timestamp` SET TAGS ('pii_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_ngo_v1`.`program`.`budget_plan` ALTER COLUMN `budget_plan_name` SET TAGS ('pii_business_glossary_term' = 'Budget Plan Name');
ALTER TABLE `vibe_ngo_v1`.`program`.`budget_plan` ALTER COLUMN `budget_plan_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`program`.`budget_plan` ALTER COLUMN `budget_plan_name` SET TAGS ('pii_type' = 'name');
ALTER TABLE `vibe_ngo_v1`.`program`.`budget_plan` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_ngo_v1`.`program`.`budget_plan` ALTER COLUMN `other_direct_costs` SET TAGS ('pii_business_glossary_term' = 'Other Direct Costs (ODC)');
ALTER TABLE `vibe_ngo_v1`.`program`.`budget_plan` ALTER COLUMN `personnel_costs` SET TAGS ('pii_business_glossary_term' = 'Personnel Costs');
ALTER TABLE `vibe_ngo_v1`.`program`.`budget_plan` ALTER COLUMN `sdg_alignment` SET TAGS ('pii_business_glossary_term' = 'Sustainable Development Goal (SDG) Alignment');
ALTER TABLE `vibe_ngo_v1`.`program`.`budget_plan` ALTER COLUMN `sector_classification` SET TAGS ('pii_business_glossary_term' = 'Sector Classification');
ALTER TABLE `vibe_ngo_v1`.`program`.`budget_plan` ALTER COLUMN `submitted_date` SET TAGS ('pii_business_glossary_term' = 'Submitted Date');
ALTER TABLE `vibe_ngo_v1`.`program`.`budget_plan` ALTER COLUMN `supplies_costs` SET TAGS ('pii_business_glossary_term' = 'Supplies Costs');
ALTER TABLE `vibe_ngo_v1`.`program`.`budget_plan` ALTER COLUMN `total_approved_budget_amount` SET TAGS ('pii_business_glossary_term' = 'Total Approved Budget Amount');
ALTER TABLE `vibe_ngo_v1`.`program`.`budget_plan` ALTER COLUMN `total_direct_costs` SET TAGS ('pii_business_glossary_term' = 'Total Direct Costs');
ALTER TABLE `vibe_ngo_v1`.`program`.`budget_plan` ALTER COLUMN `travel_costs` SET TAGS ('pii_business_glossary_term' = 'Travel Costs');
ALTER TABLE `vibe_ngo_v1`.`program`.`budget_plan_line` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_ngo_v1`.`program`.`budget_plan_line` SET TAGS ('pii_subdomain' = 'delivery_planning');
ALTER TABLE `vibe_ngo_v1`.`program`.`budget_plan_line` SET TAGS ('pii_tier' = 'mvm');
ALTER TABLE `vibe_ngo_v1`.`program`.`budget_plan_line` SET TAGS ('pii_domain' = 'program');
ALTER TABLE `vibe_ngo_v1`.`program`.`budget_plan_line` ALTER COLUMN `budget_plan_line_id` SET TAGS ('pii_business_glossary_term' = 'Budget Plan Line ID');
ALTER TABLE `vibe_ngo_v1`.`program`.`budget_plan_line` ALTER COLUMN `staff_member_id` SET TAGS ('pii_business_glossary_term' = 'Approved By Staff Member Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`program`.`budget_plan_line` ALTER COLUMN `staff_member_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`program`.`budget_plan_line` ALTER COLUMN `staff_member_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_ngo_v1`.`program`.`budget_plan_line` ALTER COLUMN `award_id` SET TAGS ('pii_business_glossary_term' = 'Grant ID');
ALTER TABLE `vibe_ngo_v1`.`program`.`budget_plan_line` ALTER COLUMN `budget_line_id` SET TAGS ('pii_business_glossary_term' = 'Budget Line Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`program`.`budget_plan_line` ALTER COLUMN `budget_plan_id` SET TAGS ('pii_business_glossary_term' = 'Budget Plan ID');
ALTER TABLE `vibe_ngo_v1`.`program`.`budget_plan_line` ALTER COLUMN `cost_center_id` SET TAGS ('pii_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`program`.`budget_plan_line` ALTER COLUMN `donor_fund_id` SET TAGS ('pii_business_glossary_term' = 'Fund Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`program`.`budget_plan_line` ALTER COLUMN `gl_account_id` SET TAGS ('pii_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`program`.`budget_plan_line` ALTER COLUMN `intervention_id` SET TAGS ('pii_business_glossary_term' = 'Program ID');
ALTER TABLE `vibe_ngo_v1`.`program`.`budget_plan_line` ALTER COLUMN `partnership_agreement_id` SET TAGS ('pii_business_glossary_term' = 'Partnership Agreement Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`program`.`budget_plan_line` ALTER COLUMN `activity_code` SET TAGS ('pii_business_glossary_term' = 'Activity Code');
ALTER TABLE `vibe_ngo_v1`.`program`.`budget_plan_line` ALTER COLUMN `allowable_cost_flag` SET TAGS ('pii_business_glossary_term' = 'Allowable Cost Flag');
ALTER TABLE `vibe_ngo_v1`.`program`.`budget_plan_line` ALTER COLUMN `approval_date` SET TAGS ('pii_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_ngo_v1`.`program`.`budget_plan_line` ALTER COLUMN `approval_required_flag` SET TAGS ('pii_business_glossary_term' = 'Approval Required Flag');
ALTER TABLE `vibe_ngo_v1`.`program`.`budget_plan_line` ALTER COLUMN `budget_period_end_date` SET TAGS ('pii_business_glossary_term' = 'Budget Period End Date');
ALTER TABLE `vibe_ngo_v1`.`program`.`budget_plan_line` ALTER COLUMN `budget_period_start_date` SET TAGS ('pii_business_glossary_term' = 'Budget Period Start Date');
ALTER TABLE `vibe_ngo_v1`.`program`.`budget_plan_line` ALTER COLUMN `budget_plan_line_status` SET TAGS ('pii_business_glossary_term' = 'Budget Line Status');
ALTER TABLE `vibe_ngo_v1`.`program`.`budget_plan_line` ALTER COLUMN `budget_version_number` SET TAGS ('pii_business_glossary_term' = 'Budget Version Number');
ALTER TABLE `vibe_ngo_v1`.`program`.`budget_plan_line` ALTER COLUMN `chart_of_accounts_code` SET TAGS ('pii_business_glossary_term' = 'Chart of Accounts (CoA) Code');
ALTER TABLE `vibe_ngo_v1`.`program`.`budget_plan_line` ALTER COLUMN `cost_category` SET TAGS ('pii_business_glossary_term' = 'Cost Category');
ALTER TABLE `vibe_ngo_v1`.`program`.`budget_plan_line` ALTER COLUMN `cost_sharing_amount` SET TAGS ('pii_business_glossary_term' = 'Cost Sharing Amount');
ALTER TABLE `vibe_ngo_v1`.`program`.`budget_plan_line` ALTER COLUMN `cost_sharing_flag` SET TAGS ('pii_business_glossary_term' = 'Cost Sharing Flag');
ALTER TABLE `vibe_ngo_v1`.`program`.`budget_plan_line` ALTER COLUMN `cost_sharing_source` SET TAGS ('pii_business_glossary_term' = 'Cost Sharing Source');
ALTER TABLE `vibe_ngo_v1`.`program`.`budget_plan_line` ALTER COLUMN `cost_subcategory` SET TAGS ('pii_business_glossary_term' = 'Cost Subcategory');
ALTER TABLE `vibe_ngo_v1`.`program`.`budget_plan_line` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_ngo_v1`.`program`.`budget_plan_line` ALTER COLUMN `currency_code` SET TAGS ('pii_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_ngo_v1`.`program`.`budget_plan_line` ALTER COLUMN `currency_code` SET TAGS ('pii_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_ngo_v1`.`program`.`budget_plan_line` ALTER COLUMN `dac_sector_code` SET TAGS ('pii_business_glossary_term' = 'Development Assistance Committee (DAC) Sector Code');
ALTER TABLE `vibe_ngo_v1`.`program`.`budget_plan_line` ALTER COLUMN `direct_cost_flag` SET TAGS ('pii_business_glossary_term' = 'Direct Cost Flag');
ALTER TABLE `vibe_ngo_v1`.`program`.`budget_plan_line` ALTER COLUMN `donor_budget_code` SET TAGS ('pii_business_glossary_term' = 'Donor Budget Code');
ALTER TABLE `vibe_ngo_v1`.`program`.`budget_plan_line` ALTER COLUMN `fiscal_year` SET TAGS ('pii_business_glossary_term' = 'Fiscal Year (FY)');
ALTER TABLE `vibe_ngo_v1`.`program`.`budget_plan_line` ALTER COLUMN `indirect_cost_rate` SET TAGS ('pii_business_glossary_term' = 'Indirect Cost Rate (ICR)');
ALTER TABLE `vibe_ngo_v1`.`program`.`budget_plan_line` ALTER COLUMN `last_modified_by` SET TAGS ('pii_business_glossary_term' = 'Last Modified By');
ALTER TABLE `vibe_ngo_v1`.`program`.`budget_plan_line` ALTER COLUMN `last_modified_timestamp` SET TAGS ('pii_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_ngo_v1`.`program`.`budget_plan_line` ALTER COLUMN `line_description` SET TAGS ('pii_business_glossary_term' = 'Budget Line Description');
ALTER TABLE `vibe_ngo_v1`.`program`.`budget_plan_line` ALTER COLUMN `line_number` SET TAGS ('pii_business_glossary_term' = 'Budget Line Number');
ALTER TABLE `vibe_ngo_v1`.`program`.`budget_plan_line` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Budget Line Notes');
ALTER TABLE `vibe_ngo_v1`.`program`.`budget_plan_line` ALTER COLUMN `quantity` SET TAGS ('pii_business_glossary_term' = 'Quantity');
ALTER TABLE `vibe_ngo_v1`.`program`.`budget_plan_line` ALTER COLUMN `revision_reason` SET TAGS ('pii_business_glossary_term' = 'Revision Reason');
ALTER TABLE `vibe_ngo_v1`.`program`.`budget_plan_line` ALTER COLUMN `sdg_alignment` SET TAGS ('pii_business_glossary_term' = 'Sustainable Development Goal (SDG) Alignment');
ALTER TABLE `vibe_ngo_v1`.`program`.`budget_plan_line` ALTER COLUMN `total_planned_amount` SET TAGS ('pii_business_glossary_term' = 'Total Planned Amount');
ALTER TABLE `vibe_ngo_v1`.`program`.`budget_plan_line` ALTER COLUMN `unit_cost` SET TAGS ('pii_business_glossary_term' = 'Unit Cost');
ALTER TABLE `vibe_ngo_v1`.`program`.`budget_plan_line` ALTER COLUMN `unit_of_measure` SET TAGS ('pii_business_glossary_term' = 'Unit of Measure (UoM)');
ALTER TABLE `vibe_ngo_v1`.`program`.`budget_plan_line` ALTER COLUMN `created_by` SET TAGS ('pii_business_glossary_term' = 'Created By');
ALTER TABLE `vibe_ngo_v1`.`program`.`program_closeout` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_ngo_v1`.`program`.`program_closeout` SET TAGS ('pii_subdomain' = 'program_design');
ALTER TABLE `vibe_ngo_v1`.`program`.`program_closeout` SET TAGS ('pii_tier' = 'mvm');
ALTER TABLE `vibe_ngo_v1`.`program`.`program_closeout` SET TAGS ('pii_domain' = 'program');
ALTER TABLE `vibe_ngo_v1`.`program`.`program_closeout` SET TAGS ('pii_ssot' = 'true');
ALTER TABLE `vibe_ngo_v1`.`program`.`program_closeout` SET TAGS ('pii_ssot_scope' = 'program_operational_closeout');
ALTER TABLE `vibe_ngo_v1`.`program`.`program_closeout` SET TAGS ('pii_ssot_owner' = 'program');
ALTER TABLE `vibe_ngo_v1`.`program`.`program_closeout` SET TAGS ('pii_ssot_boundary' = 'programme_closeout');
ALTER TABLE `vibe_ngo_v1`.`program`.`program_closeout` SET TAGS ('pii_disambiguated_from' = 'grant.grant_closeout');
ALTER TABLE `vibe_ngo_v1`.`program`.`program_closeout` ALTER COLUMN `program_closeout_id` SET TAGS ('pii_business_glossary_term' = 'Program Closeout ID');
ALTER TABLE `vibe_ngo_v1`.`program`.`program_closeout` ALTER COLUMN `award_id` SET TAGS ('pii_business_glossary_term' = 'Award Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`program`.`program_closeout` ALTER COLUMN `staff_member_id` SET TAGS ('pii_business_glossary_term' = 'Certified By Staff Member Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`program`.`program_closeout` ALTER COLUMN `staff_member_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`program`.`program_closeout` ALTER COLUMN `staff_member_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_ngo_v1`.`program`.`program_closeout` ALTER COLUMN `intervention_id` SET TAGS ('pii_business_glossary_term' = 'Program ID');
ALTER TABLE `vibe_ngo_v1`.`program`.`program_closeout` ALTER COLUMN `partnership_agreement_id` SET TAGS ('pii_business_glossary_term' = 'Partnership Agreement Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`program`.`program_closeout` ALTER COLUMN `regulatory_filing_id` SET TAGS ('pii_business_glossary_term' = 'Regulatory Filing Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`program`.`program_closeout` ALTER COLUMN `archiving_completion_date` SET TAGS ('pii_business_glossary_term' = 'Archiving Completion Date');
ALTER TABLE `vibe_ngo_v1`.`program`.`program_closeout` ALTER COLUMN `archiving_reference` SET TAGS ('pii_business_glossary_term' = 'Archiving Reference');
ALTER TABLE `vibe_ngo_v1`.`program`.`program_closeout` ALTER COLUMN `asset_disposition_plan` SET TAGS ('pii_business_glossary_term' = 'Asset Disposition Plan');
ALTER TABLE `vibe_ngo_v1`.`program`.`program_closeout` ALTER COLUMN `asset_disposition_status` SET TAGS ('pii_business_glossary_term' = 'Asset Disposition Status');
ALTER TABLE `vibe_ngo_v1`.`program`.`program_closeout` ALTER COLUMN `asset_disposition_status` SET TAGS ('pii_value_regex' = 'pending|in_progress|completed|donor_approval_required|approved');
ALTER TABLE `vibe_ngo_v1`.`program`.`program_closeout` ALTER COLUMN `audit_completion_status` SET TAGS ('pii_business_glossary_term' = 'Audit Completion Status');
ALTER TABLE `vibe_ngo_v1`.`program`.`program_closeout` ALTER COLUMN `audit_completion_status` SET TAGS ('pii_value_regex' = 'not_required|pending|in_progress|completed|findings_issued|resolved');
ALTER TABLE `vibe_ngo_v1`.`program`.`program_closeout` ALTER COLUMN `audit_findings_summary` SET TAGS ('pii_business_glossary_term' = 'Audit Findings Summary');
ALTER TABLE `vibe_ngo_v1`.`program`.`program_closeout` ALTER COLUMN `budget_utilization_percentage` SET TAGS ('pii_business_glossary_term' = 'Budget Utilization Percentage');
ALTER TABLE `vibe_ngo_v1`.`program`.`program_closeout` ALTER COLUMN `budget_variance_amount` SET TAGS ('pii_business_glossary_term' = 'Budget Variance Amount');
ALTER TABLE `vibe_ngo_v1`.`program`.`program_closeout` ALTER COLUMN `closeout_number` SET TAGS ('pii_business_glossary_term' = 'Closeout Number');
ALTER TABLE `vibe_ngo_v1`.`program`.`program_closeout` ALTER COLUMN `closeout_status` SET TAGS ('pii_business_glossary_term' = 'Closeout Status');
ALTER TABLE `vibe_ngo_v1`.`program`.`program_closeout` ALTER COLUMN `closeout_status` SET TAGS ('pii_value_regex' = 'initiated|in_progress|pending_donor_review|donor_approved|completed|archived');
ALTER TABLE `vibe_ngo_v1`.`program`.`program_closeout` ALTER COLUMN `closeout_type` SET TAGS ('pii_business_glossary_term' = 'Closeout Type');
ALTER TABLE `vibe_ngo_v1`.`program`.`program_closeout` ALTER COLUMN `closeout_type` SET TAGS ('pii_value_regex' = 'planned|early_termination|no_cost_extension_expiry|emergency_suspension|donor_initiated|force_majeure');
ALTER TABLE `vibe_ngo_v1`.`program`.`program_closeout` ALTER COLUMN `completion_date` SET TAGS ('pii_business_glossary_term' = 'Closeout Completion Date');
ALTER TABLE `vibe_ngo_v1`.`program`.`program_closeout` ALTER COLUMN `compliance_certification_date` SET TAGS ('pii_business_glossary_term' = 'Compliance Certification Date');
ALTER TABLE `vibe_ngo_v1`.`program`.`program_closeout` ALTER COLUMN `compliance_certification_flag` SET TAGS ('pii_business_glossary_term' = 'Compliance Certification Flag');
ALTER TABLE `vibe_ngo_v1`.`program`.`program_closeout` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_ngo_v1`.`program`.`program_closeout` ALTER COLUMN `currency_code` SET TAGS ('pii_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_ngo_v1`.`program`.`program_closeout` ALTER COLUMN `currency_code` SET TAGS ('pii_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_ngo_v1`.`program`.`program_closeout` ALTER COLUMN `donor_signoff_conditions` SET TAGS ('pii_business_glossary_term' = 'Donor Sign-Off Conditions');
ALTER TABLE `vibe_ngo_v1`.`program`.`program_closeout` ALTER COLUMN `donor_signoff_date` SET TAGS ('pii_business_glossary_term' = 'Donor Sign-Off Date');
ALTER TABLE `vibe_ngo_v1`.`program`.`program_closeout` ALTER COLUMN `donor_signoff_status` SET TAGS ('pii_business_glossary_term' = 'Donor Sign-Off Status');
ALTER TABLE `vibe_ngo_v1`.`program`.`program_closeout` ALTER COLUMN `donor_signoff_status` SET TAGS ('pii_value_regex' = 'pending|submitted|under_review|approved|conditional_approval|rejected');
ALTER TABLE `vibe_ngo_v1`.`program`.`program_closeout` ALTER COLUMN `final_beneficiary_count` SET TAGS ('pii_business_glossary_term' = 'Final Beneficiary Count');
ALTER TABLE `vibe_ngo_v1`.`program`.`program_closeout` ALTER COLUMN `final_beneficiary_count_female` SET TAGS ('pii_business_glossary_term' = 'Final Beneficiary Count Female');
ALTER TABLE `vibe_ngo_v1`.`program`.`program_closeout` ALTER COLUMN `final_beneficiary_count_male` SET TAGS ('pii_business_glossary_term' = 'Final Beneficiary Count Male');
ALTER TABLE `vibe_ngo_v1`.`program`.`program_closeout` ALTER COLUMN `final_beneficiary_count_other` SET TAGS ('pii_business_glossary_term' = 'Final Beneficiary Count Other');
ALTER TABLE `vibe_ngo_v1`.`program`.`program_closeout` ALTER COLUMN `final_budget_amount` SET TAGS ('pii_business_glossary_term' = 'Final Budget Amount');
ALTER TABLE `vibe_ngo_v1`.`program`.`program_closeout` ALTER COLUMN `final_expenditure_amount` SET TAGS ('pii_business_glossary_term' = 'Final Expenditure Amount');
ALTER TABLE `vibe_ngo_v1`.`program`.`program_closeout` ALTER COLUMN `final_financial_reconciliation_status` SET TAGS ('pii_business_glossary_term' = 'Final Financial Reconciliation Status');
ALTER TABLE `vibe_ngo_v1`.`program`.`program_closeout` ALTER COLUMN `final_financial_reconciliation_status` SET TAGS ('pii_value_regex' = 'pending|in_progress|reconciled|discrepancies_identified|resolved|audited');
ALTER TABLE `vibe_ngo_v1`.`program`.`program_closeout` ALTER COLUMN `final_report_approval_date` SET TAGS ('pii_business_glossary_term' = 'Final Report Approval Date');
ALTER TABLE `vibe_ngo_v1`.`program`.`program_closeout` ALTER COLUMN `final_report_submission_date` SET TAGS ('pii_business_glossary_term' = 'Final Report Submission Date');
ALTER TABLE `vibe_ngo_v1`.`program`.`program_closeout` ALTER COLUMN `initiation_date` SET TAGS ('pii_business_glossary_term' = 'Closeout Initiation Date');
ALTER TABLE `vibe_ngo_v1`.`program`.`program_closeout` ALTER COLUMN `knowledge_management_outputs` SET TAGS ('pii_business_glossary_term' = 'Knowledge Management Outputs');
ALTER TABLE `vibe_ngo_v1`.`program`.`program_closeout` ALTER COLUMN `last_modified_timestamp` SET TAGS ('pii_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_ngo_v1`.`program`.`program_closeout` ALTER COLUMN `lessons_learned_summary` SET TAGS ('pii_business_glossary_term' = 'Lessons Learned Summary');
ALTER TABLE `vibe_ngo_v1`.`program`.`program_closeout` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Closeout Notes');
ALTER TABLE `vibe_ngo_v1`.`program`.`program_closeout` ALTER COLUMN `outstanding_obligations_description` SET TAGS ('pii_business_glossary_term' = 'Outstanding Obligations Description');
ALTER TABLE `vibe_ngo_v1`.`program`.`program_closeout` ALTER COLUMN `outstanding_obligations_flag` SET TAGS ('pii_business_glossary_term' = 'Outstanding Obligations Flag');
ALTER TABLE `vibe_ngo_v1`.`program`.`program_closeout` ALTER COLUMN `program_end_date` SET TAGS ('pii_business_glossary_term' = 'Program End Date');
ALTER TABLE `vibe_ngo_v1`.`program`.`program_closeout` ALTER COLUMN `record_retention_end_date` SET TAGS ('pii_business_glossary_term' = 'Record Retention End Date');
ALTER TABLE `vibe_ngo_v1`.`program`.`partner_linkage` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_ngo_v1`.`program`.`partner_linkage` SET TAGS ('pii_subdomain' = 'delivery_planning');
ALTER TABLE `vibe_ngo_v1`.`program`.`partner_linkage` SET TAGS ('pii_tier' = 'mvm');
ALTER TABLE `vibe_ngo_v1`.`program`.`partner_linkage` SET TAGS ('pii_domain' = 'program');
ALTER TABLE `vibe_ngo_v1`.`program`.`partner_linkage` ALTER COLUMN `partner_linkage_id` SET TAGS ('pii_business_glossary_term' = 'Partner Linkage Identifier (ID)');
ALTER TABLE `vibe_ngo_v1`.`program`.`partner_linkage` ALTER COLUMN `intervention_id` SET TAGS ('pii_business_glossary_term' = 'Program Identifier (ID)');
ALTER TABLE `vibe_ngo_v1`.`program`.`partner_linkage` ALTER COLUMN `constituent_id` SET TAGS ('pii_business_glossary_term' = 'Partner Constituent Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`program`.`partner_linkage` ALTER COLUMN `constituent_id` SET TAGS ('pii_type' = 'personal');
ALTER TABLE `vibe_ngo_v1`.`program`.`partner_linkage` ALTER COLUMN `partner_org_id` SET TAGS ('pii_business_glossary_term' = 'Partner Organization Identifier (ID)');
ALTER TABLE `vibe_ngo_v1`.`program`.`partner_linkage` ALTER COLUMN `partner_psea_assessment_id` SET TAGS ('pii_business_glossary_term' = 'Partner Psea Assessment Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`program`.`partner_linkage` ALTER COLUMN `partnership_agreement_id` SET TAGS ('pii_business_glossary_term' = 'Partnership Agreement Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`program`.`partner_linkage` ALTER COLUMN `system_platform_id` SET TAGS ('pii_business_glossary_term' = 'Partnership System Platform Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`program`.`partner_linkage` ALTER COLUMN `staff_member_id` SET TAGS ('pii_business_glossary_term' = 'Responsible Staff Member Id');
ALTER TABLE `vibe_ngo_v1`.`program`.`partner_linkage` ALTER COLUMN `staff_member_id` SET TAGS ('pii_internal' = 'true');
ALTER TABLE `vibe_ngo_v1`.`program`.`partner_linkage` ALTER COLUMN `staff_member_id` SET TAGS ('pii_type' = 'personal');
ALTER TABLE `vibe_ngo_v1`.`program`.`partner_linkage` ALTER COLUMN `sanctions_screening_id` SET TAGS ('pii_business_glossary_term' = 'Sanctions Screening Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`program`.`partner_linkage` ALTER COLUMN `beneficiary_reached_count` SET TAGS ('pii_business_glossary_term' = 'Beneficiary Reached Count');
ALTER TABLE `vibe_ngo_v1`.`program`.`partner_linkage` ALTER COLUMN `beneficiary_target_count` SET TAGS ('pii_business_glossary_term' = 'Beneficiary Target Count');
ALTER TABLE `vibe_ngo_v1`.`program`.`partner_linkage` ALTER COLUMN `budget_allocated_amount` SET TAGS ('pii_business_glossary_term' = 'Budget Allocated Amount');
ALTER TABLE `vibe_ngo_v1`.`program`.`partner_linkage` ALTER COLUMN `budget_currency_code` SET TAGS ('pii_business_glossary_term' = 'Budget Currency Code');
ALTER TABLE `vibe_ngo_v1`.`program`.`partner_linkage` ALTER COLUMN `capacity_assessment_date` SET TAGS ('pii_business_glossary_term' = 'Capacity Assessment Date');
ALTER TABLE `vibe_ngo_v1`.`program`.`partner_linkage` ALTER COLUMN `capacity_assessment_score` SET TAGS ('pii_business_glossary_term' = 'Capacity Assessment Score');
ALTER TABLE `vibe_ngo_v1`.`program`.`partner_linkage` ALTER COLUMN `capacity_assessment_status` SET TAGS ('pii_business_glossary_term' = 'Capacity Assessment Status');
ALTER TABLE `vibe_ngo_v1`.`program`.`partner_linkage` ALTER COLUMN `capacity_assessment_status` SET TAGS ('pii_value_regex' = 'not_started|in_progress|completed|approved|conditional_approval|failed');
ALTER TABLE `vibe_ngo_v1`.`program`.`partner_linkage` ALTER COLUMN `capacity_building_required_flag` SET TAGS ('pii_business_glossary_term' = 'Capacity Building Required Flag');
ALTER TABLE `vibe_ngo_v1`.`program`.`partner_linkage` ALTER COLUMN `community_based_organization_flag` SET TAGS ('pii_business_glossary_term' = 'Community-Based Organization (CBO) Flag');
ALTER TABLE `vibe_ngo_v1`.`program`.`partner_linkage` ALTER COLUMN `compliance_status` SET TAGS ('pii_business_glossary_term' = 'Compliance Status');
ALTER TABLE `vibe_ngo_v1`.`program`.`partner_linkage` ALTER COLUMN `compliance_status` SET TAGS ('pii_value_regex' = 'compliant|non_compliant|conditional|under_review|not_assessed');
ALTER TABLE `vibe_ngo_v1`.`program`.`partner_linkage` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_ngo_v1`.`program`.`partner_linkage` ALTER COLUMN `end_date` SET TAGS ('pii_business_glossary_term' = 'Partnership End Date');
ALTER TABLE `vibe_ngo_v1`.`program`.`partner_linkage` ALTER COLUMN `geographic_scope` SET TAGS ('pii_business_glossary_term' = 'Geographic Scope of Partnership');
ALTER TABLE `vibe_ngo_v1`.`program`.`partner_linkage` ALTER COLUMN `last_modified_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `vibe_ngo_v1`.`program`.`partner_linkage` ALTER COLUMN `last_monitoring_visit_date` SET TAGS ('pii_business_glossary_term' = 'Last Monitoring Visit Date');
ALTER TABLE `vibe_ngo_v1`.`program`.`partner_linkage` ALTER COLUMN `last_report_submission_date` SET TAGS ('pii_business_glossary_term' = 'Last Report Submission Date');
ALTER TABLE `vibe_ngo_v1`.`program`.`partner_linkage` ALTER COLUMN `local_partner_flag` SET TAGS ('pii_business_glossary_term' = 'Local Partner Flag');
ALTER TABLE `vibe_ngo_v1`.`program`.`partner_linkage` ALTER COLUMN `monitoring_visit_count` SET TAGS ('pii_business_glossary_term' = 'Monitoring Visit Count');
ALTER TABLE `vibe_ngo_v1`.`program`.`partner_linkage` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Partnership Notes');
ALTER TABLE `vibe_ngo_v1`.`program`.`partner_linkage` ALTER COLUMN `partnership_role` SET TAGS ('pii_business_glossary_term' = 'Partnership Role');
ALTER TABLE `vibe_ngo_v1`.`program`.`partner_linkage` ALTER COLUMN `partnership_role` SET TAGS ('pii_value_regex' = 'lead_implementer|sub_grantee|technical_partner|government_counterpart|consortium_member|capacity_building_partner');
ALTER TABLE `vibe_ngo_v1`.`program`.`partner_linkage` ALTER COLUMN `partnership_status` SET TAGS ('pii_business_glossary_term' = 'Partnership Status');
ALTER TABLE `vibe_ngo_v1`.`program`.`partner_linkage` ALTER COLUMN `partnership_status` SET TAGS ('pii_value_regex' = 'active|pending|suspended|terminated|completed|under_review');
ALTER TABLE `vibe_ngo_v1`.`program`.`partner_linkage` ALTER COLUMN `partnership_type` SET TAGS ('pii_business_glossary_term' = 'Partnership Type');
ALTER TABLE `vibe_ngo_v1`.`program`.`partner_linkage` ALTER COLUMN `partnership_type` SET TAGS ('pii_value_regex' = 'direct_implementation|sub_award|technical_assistance|coordination|joint_implementation|government_collaboration');
ALTER TABLE `vibe_ngo_v1`.`program`.`partner_linkage` ALTER COLUMN `performance_rating` SET TAGS ('pii_business_glossary_term' = 'Partner Performance Rating');
ALTER TABLE `vibe_ngo_v1`.`program`.`partner_linkage` ALTER COLUMN `performance_rating` SET TAGS ('pii_value_regex' = 'outstanding|exceeds_expectations|meets_expectations|needs_improvement|unsatisfactory|not_rated');
ALTER TABLE `vibe_ngo_v1`.`program`.`partner_linkage` ALTER COLUMN `performance_review_date` SET TAGS ('pii_business_glossary_term' = 'Performance Review Date');
ALTER TABLE `vibe_ngo_v1`.`program`.`partner_linkage` ALTER COLUMN `reporting_frequency` SET TAGS ('pii_business_glossary_term' = 'Reporting Frequency');
ALTER TABLE `vibe_ngo_v1`.`program`.`partner_linkage` ALTER COLUMN `risk_rating` SET TAGS ('pii_business_glossary_term' = 'Partnership Risk Rating');
ALTER TABLE `vibe_ngo_v1`.`program`.`partner_linkage` ALTER COLUMN `risk_rating` SET TAGS ('pii_value_regex' = 'low|medium|high|critical');
ALTER TABLE `vibe_ngo_v1`.`program`.`partner_linkage` ALTER COLUMN `sector_focus` SET TAGS ('pii_business_glossary_term' = 'Sector Focus');
ALTER TABLE `vibe_ngo_v1`.`program`.`partner_linkage` ALTER COLUMN `start_date` SET TAGS ('pii_business_glossary_term' = 'Partnership Start Date');
ALTER TABLE `vibe_ngo_v1`.`program`.`partner_linkage` ALTER COLUMN `sub_award_reference` SET TAGS ('pii_business_glossary_term' = 'Sub-Award Reference Number');
ALTER TABLE `vibe_ngo_v1`.`program`.`partner_linkage` ALTER COLUMN `termination_reason` SET TAGS ('pii_business_glossary_term' = 'Partnership Termination Reason');
ALTER TABLE `vibe_ngo_v1`.`program`.`review_event` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_ngo_v1`.`program`.`review_event` SET TAGS ('pii_subdomain' = 'program_design');
ALTER TABLE `vibe_ngo_v1`.`program`.`review_event` SET TAGS ('pii_tier' = 'mvm');
ALTER TABLE `vibe_ngo_v1`.`program`.`review_event` SET TAGS ('pii_domain' = 'program');
ALTER TABLE `vibe_ngo_v1`.`program`.`review_event` ALTER COLUMN `review_event_id` SET TAGS ('pii_business_glossary_term' = 'Review Event ID');
ALTER TABLE `vibe_ngo_v1`.`program`.`review_event` ALTER COLUMN `award_id` SET TAGS ('pii_business_glossary_term' = 'Grant ID');
ALTER TABLE `vibe_ngo_v1`.`program`.`review_event` ALTER COLUMN `intervention_id` SET TAGS ('pii_business_glossary_term' = 'Program ID');
ALTER TABLE `vibe_ngo_v1`.`program`.`review_event` ALTER COLUMN `partnership_agreement_id` SET TAGS ('pii_business_glossary_term' = 'Partnership Agreement Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`program`.`review_event` ALTER COLUMN `regulatory_filing_id` SET TAGS ('pii_business_glossary_term' = 'Regulatory Filing Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`program`.`review_event` ALTER COLUMN `system_platform_id` SET TAGS ('pii_business_glossary_term' = 'Reporting System Platform Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`program`.`review_event` ALTER COLUMN `approval_date` SET TAGS ('pii_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_ngo_v1`.`program`.`review_event` ALTER COLUMN `approved_by_name` SET TAGS ('pii_business_glossary_term' = 'Approved By Name');
ALTER TABLE `vibe_ngo_v1`.`program`.`review_event` ALTER COLUMN `approved_by_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`program`.`review_event` ALTER COLUMN `approved_by_name` SET TAGS ('pii_type' = 'name');
ALTER TABLE `vibe_ngo_v1`.`program`.`review_event` ALTER COLUMN `beneficiary_reach_children` SET TAGS ('pii_business_glossary_term' = 'Beneficiary Reach Children');
ALTER TABLE `vibe_ngo_v1`.`program`.`review_event` ALTER COLUMN `beneficiary_reach_female` SET TAGS ('pii_business_glossary_term' = 'Beneficiary Reach Female');
ALTER TABLE `vibe_ngo_v1`.`program`.`review_event` ALTER COLUMN `beneficiary_reach_male` SET TAGS ('pii_business_glossary_term' = 'Beneficiary Reach Male');
ALTER TABLE `vibe_ngo_v1`.`program`.`review_event` ALTER COLUMN `beneficiary_reach_total` SET TAGS ('pii_business_glossary_term' = 'Beneficiary Reach Total');
ALTER TABLE `vibe_ngo_v1`.`program`.`review_event` ALTER COLUMN `challenges_narrative` SET TAGS ('pii_business_glossary_term' = 'Challenges Narrative');
ALTER TABLE `vibe_ngo_v1`.`program`.`review_event` ALTER COLUMN `chs_compliance_flag` SET TAGS ('pii_business_glossary_term' = 'Core Humanitarian Standard (CHS) Compliance Flag');
ALTER TABLE `vibe_ngo_v1`.`program`.`review_event` ALTER COLUMN `cluster_submission_flag` SET TAGS ('pii_business_glossary_term' = 'Cluster Submission Flag');
ALTER TABLE `vibe_ngo_v1`.`program`.`review_event` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_ngo_v1`.`program`.`review_event` ALTER COLUMN `dissemination_date` SET TAGS ('pii_business_glossary_term' = 'Dissemination Date');
ALTER TABLE `vibe_ngo_v1`.`program`.`review_event` ALTER COLUMN `document_url` SET TAGS ('pii_business_glossary_term' = 'Document URL');
ALTER TABLE `vibe_ngo_v1`.`program`.`review_event` ALTER COLUMN `donor_visibility_flag` SET TAGS ('pii_business_glossary_term' = 'Donor Visibility Flag');
ALTER TABLE `vibe_ngo_v1`.`program`.`review_event` ALTER COLUMN `event_code` SET TAGS ('pii_business_glossary_term' = 'Review Event Code');
ALTER TABLE `vibe_ngo_v1`.`program`.`review_event` ALTER COLUMN `event_code` SET TAGS ('pii_value_regex' = '^[A-Z0-9_-]{3,20}$');
ALTER TABLE `vibe_ngo_v1`.`program`.`review_event` ALTER COLUMN `event_status` SET TAGS ('pii_business_glossary_term' = 'Review Event Status');
ALTER TABLE `vibe_ngo_v1`.`program`.`review_event` ALTER COLUMN `event_type` SET TAGS ('pii_business_glossary_term' = 'Review Event Type');
ALTER TABLE `vibe_ngo_v1`.`program`.`review_event` ALTER COLUMN `executive_summary` SET TAGS ('pii_business_glossary_term' = 'Executive Summary');
ALTER TABLE `vibe_ngo_v1`.`program`.`review_event` ALTER COLUMN `financial_summary_budget_amount` SET TAGS ('pii_business_glossary_term' = 'Financial Summary Budget Amount');
ALTER TABLE `vibe_ngo_v1`.`program`.`review_event` ALTER COLUMN `financial_summary_currency_code` SET TAGS ('pii_business_glossary_term' = 'Financial Summary Currency Code');
ALTER TABLE `vibe_ngo_v1`.`program`.`review_event` ALTER COLUMN `financial_summary_currency_code` SET TAGS ('pii_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_ngo_v1`.`program`.`review_event` ALTER COLUMN `financial_summary_expenditure_amount` SET TAGS ('pii_business_glossary_term' = 'Financial Summary Expenditure Amount');
ALTER TABLE `vibe_ngo_v1`.`program`.`review_event` ALTER COLUMN `follow_up_actions` SET TAGS ('pii_business_glossary_term' = 'Follow-Up Actions');
ALTER TABLE `vibe_ngo_v1`.`program`.`review_event` ALTER COLUMN `key_findings` SET TAGS ('pii_business_glossary_term' = 'Key Findings');
ALTER TABLE `vibe_ngo_v1`.`program`.`review_event` ALTER COLUMN `last_modified_timestamp` SET TAGS ('pii_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_ngo_v1`.`program`.`review_event` ALTER COLUMN `lead_author_name` SET TAGS ('pii_business_glossary_term' = 'Lead Author Name');
ALTER TABLE `vibe_ngo_v1`.`program`.`review_event` ALTER COLUMN `lead_author_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`program`.`review_event` ALTER COLUMN `lead_author_name` SET TAGS ('pii_type' = 'name');
ALTER TABLE `vibe_ngo_v1`.`program`.`review_event` ALTER COLUMN `lessons_learned_summary` SET TAGS ('pii_business_glossary_term' = 'Lessons Learned Summary');
ALTER TABLE `vibe_ngo_v1`.`program`.`review_event` ALTER COLUMN `management_response` SET TAGS ('pii_business_glossary_term' = 'Management Response');
ALTER TABLE `vibe_ngo_v1`.`program`.`review_event` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_ngo_v1`.`program`.`review_event` ALTER COLUMN `progress_narrative` SET TAGS ('pii_business_glossary_term' = 'Progress Narrative');
ALTER TABLE `vibe_ngo_v1`.`program`.`review_event` ALTER COLUMN `recommendations` SET TAGS ('pii_business_glossary_term' = 'Recommendations');
ALTER TABLE `vibe_ngo_v1`.`program`.`review_event` ALTER COLUMN `reporting_period_end_date` SET TAGS ('pii_business_glossary_term' = 'Reporting Period End Date');
ALTER TABLE `vibe_ngo_v1`.`program`.`review_event` ALTER COLUMN `reporting_period_start_date` SET TAGS ('pii_business_glossary_term' = 'Reporting Period Start Date');
ALTER TABLE `vibe_ngo_v1`.`program`.`review_event` ALTER COLUMN `review_date` SET TAGS ('pii_business_glossary_term' = 'Review Date');
ALTER TABLE `vibe_ngo_v1`.`program`.`review_event` ALTER COLUMN `review_team_members` SET TAGS ('pii_business_glossary_term' = 'Review Team Members');
ALTER TABLE `vibe_ngo_v1`.`program`.`review_event` ALTER COLUMN `scope_description` SET TAGS ('pii_business_glossary_term' = 'Scope Description');
ALTER TABLE `vibe_ngo_v1`.`program`.`review_event` ALTER COLUMN `sphere_standards_applied_flag` SET TAGS ('pii_business_glossary_term' = 'Sphere Standards Applied Flag');
ALTER TABLE `vibe_ngo_v1`.`program`.`review_event` ALTER COLUMN `submission_date` SET TAGS ('pii_business_glossary_term' = 'Submission Date');
ALTER TABLE `vibe_ngo_v1`.`program`.`program_partnership` SET TAGS ('pii_data_type' = 'association_data');
ALTER TABLE `vibe_ngo_v1`.`program`.`program_partnership` SET TAGS ('pii_subdomain' = 'delivery_planning');
ALTER TABLE `vibe_ngo_v1`.`program`.`program_partnership` SET TAGS ('pii_association_edges' = 'program.intervention,partnership.partner_org');
ALTER TABLE `vibe_ngo_v1`.`program`.`program_partnership` SET TAGS ('pii_tier' = 'mvm');
ALTER TABLE `vibe_ngo_v1`.`program`.`program_partnership` SET TAGS ('pii_domain' = 'program');
ALTER TABLE `vibe_ngo_v1`.`program`.`program_partnership` ALTER COLUMN `program_partnership_id` SET TAGS ('pii_business_glossary_term' = 'Partnership - Partnership Id');
ALTER TABLE `vibe_ngo_v1`.`program`.`program_partnership` ALTER COLUMN `intervention_id` SET TAGS ('pii_business_glossary_term' = 'Partnership - Intervention Id');
ALTER TABLE `vibe_ngo_v1`.`program`.`program_partnership` ALTER COLUMN `partner_org_id` SET TAGS ('pii_business_glossary_term' = 'Partnership - Partner Org Id');
ALTER TABLE `vibe_ngo_v1`.`program`.`program_partnership` ALTER COLUMN `beneficiary_target_count` SET TAGS ('pii_business_glossary_term' = 'Beneficiary Target Count');
ALTER TABLE `vibe_ngo_v1`.`program`.`program_partnership` ALTER COLUMN `budget_allocated_amount` SET TAGS ('pii_business_glossary_term' = 'Budget Allocated Amount');
ALTER TABLE `vibe_ngo_v1`.`program`.`program_partnership` ALTER COLUMN `capacity_assessment_status` SET TAGS ('pii_business_glossary_term' = 'Capacity Assessment Status');
ALTER TABLE `vibe_ngo_v1`.`program`.`program_partnership` ALTER COLUMN `compliance_status` SET TAGS ('pii_business_glossary_term' = 'Compliance Status');
ALTER TABLE `vibe_ngo_v1`.`program`.`program_partnership` ALTER COLUMN `end_date` SET TAGS ('pii_business_glossary_term' = 'Partnership End Date');
ALTER TABLE `vibe_ngo_v1`.`program`.`program_partnership` ALTER COLUMN `geographic_scope` SET TAGS ('pii_business_glossary_term' = 'Geographic Scope');
ALTER TABLE `vibe_ngo_v1`.`program`.`program_partnership` ALTER COLUMN `ip_transfer_modality` SET TAGS ('pii_business_glossary_term' = 'IP Transfer Modality');
ALTER TABLE `vibe_ngo_v1`.`program`.`program_partnership` ALTER COLUMN `partnership_role` SET TAGS ('pii_business_glossary_term' = 'Partnership Role');
ALTER TABLE `vibe_ngo_v1`.`program`.`program_partnership` ALTER COLUMN `partnership_status` SET TAGS ('pii_business_glossary_term' = 'Partnership Status');
ALTER TABLE `vibe_ngo_v1`.`program`.`program_partnership` ALTER COLUMN `partnership_type` SET TAGS ('pii_business_glossary_term' = 'Partnership Type');
ALTER TABLE `vibe_ngo_v1`.`program`.`program_partnership` ALTER COLUMN `performance_rating` SET TAGS ('pii_business_glossary_term' = 'Performance Rating');
ALTER TABLE `vibe_ngo_v1`.`program`.`program_partnership` ALTER COLUMN `reporting_frequency` SET TAGS ('pii_business_glossary_term' = 'Reporting Frequency');
ALTER TABLE `vibe_ngo_v1`.`program`.`program_partnership` ALTER COLUMN `risk_rating` SET TAGS ('pii_business_glossary_term' = 'Risk Rating');
ALTER TABLE `vibe_ngo_v1`.`program`.`program_partnership` ALTER COLUMN `sector_focus` SET TAGS ('pii_business_glossary_term' = 'Sector Focus');
ALTER TABLE `vibe_ngo_v1`.`program`.`program_partnership` ALTER COLUMN `start_date` SET TAGS ('pii_business_glossary_term' = 'Partnership Start Date');
ALTER TABLE `vibe_ngo_v1`.`program`.`program_partnership` ALTER COLUMN `sub_award_reference` SET TAGS ('pii_business_glossary_term' = 'Sub-Award Reference');
ALTER TABLE `vibe_ngo_v1`.`program`.`intervention_compliance` SET TAGS ('pii_data_type' = 'association_data');
ALTER TABLE `vibe_ngo_v1`.`program`.`intervention_compliance` SET TAGS ('pii_subdomain' = 'delivery_planning');
ALTER TABLE `vibe_ngo_v1`.`program`.`intervention_compliance` SET TAGS ('pii_association_edges' = 'program.intervention,compliance.donor_requirement');
ALTER TABLE `vibe_ngo_v1`.`program`.`intervention_compliance` SET TAGS ('pii_tier' = 'mvm');
ALTER TABLE `vibe_ngo_v1`.`program`.`intervention_compliance` SET TAGS ('pii_domain' = 'program');
ALTER TABLE `vibe_ngo_v1`.`program`.`intervention_compliance` ALTER COLUMN `intervention_compliance_id` SET TAGS ('pii_business_glossary_term' = 'Intervention Compliance ID');
ALTER TABLE `vibe_ngo_v1`.`program`.`intervention_compliance` ALTER COLUMN `donor_requirement_id` SET TAGS ('pii_business_glossary_term' = 'Intervention Compliance - Donor Compliance Req Id');
ALTER TABLE `vibe_ngo_v1`.`program`.`intervention_compliance` ALTER COLUMN `intervention_id` SET TAGS ('pii_business_glossary_term' = 'Intervention Compliance - Intervention Id');
ALTER TABLE `vibe_ngo_v1`.`program`.`intervention_compliance` ALTER COLUMN `staff_member_id` SET TAGS ('pii_business_glossary_term' = 'Responsible Staff Member');
ALTER TABLE `vibe_ngo_v1`.`program`.`intervention_compliance` ALTER COLUMN `staff_member_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`program`.`intervention_compliance` ALTER COLUMN `staff_member_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_ngo_v1`.`program`.`intervention_compliance` ALTER COLUMN `actual_effort_hours` SET TAGS ('pii_business_glossary_term' = 'Actual Effort Hours');
ALTER TABLE `vibe_ngo_v1`.`program`.`intervention_compliance` ALTER COLUMN `approval_date` SET TAGS ('pii_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_ngo_v1`.`program`.`intervention_compliance` ALTER COLUMN `associated_cost_amount` SET TAGS ('pii_business_glossary_term' = 'Associated Cost Amount');
ALTER TABLE `vibe_ngo_v1`.`program`.`intervention_compliance` ALTER COLUMN `cost_currency_code` SET TAGS ('pii_business_glossary_term' = 'Cost Currency Code');
ALTER TABLE `vibe_ngo_v1`.`program`.`intervention_compliance` ALTER COLUMN `created_date` SET TAGS ('pii_business_glossary_term' = 'Created Date');
ALTER TABLE `vibe_ngo_v1`.`program`.`intervention_compliance` ALTER COLUMN `deliverable_format` SET TAGS ('pii_business_glossary_term' = 'Deliverable Format');
ALTER TABLE `vibe_ngo_v1`.`program`.`intervention_compliance` ALTER COLUMN `due_date` SET TAGS ('pii_business_glossary_term' = 'Due Date');
ALTER TABLE `vibe_ngo_v1`.`program`.`intervention_compliance` ALTER COLUMN `last_modified_date` SET TAGS ('pii_business_glossary_term' = 'Last Modified Date');
ALTER TABLE `vibe_ngo_v1`.`program`.`intervention_compliance` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_ngo_v1`.`program`.`intervention_compliance` ALTER COLUMN `requirement_status` SET TAGS ('pii_business_glossary_term' = 'Requirement Status');
ALTER TABLE `vibe_ngo_v1`.`program`.`intervention_compliance` ALTER COLUMN `submission_date` SET TAGS ('pii_business_glossary_term' = 'Submission Date');
ALTER TABLE `vibe_ngo_v1`.`program`.`intervention_compliance` ALTER COLUMN `waiver_granted_flag` SET TAGS ('pii_business_glossary_term' = 'Waiver Granted Flag');
ALTER TABLE `vibe_ngo_v1`.`program`.`intervention_compliance` ALTER COLUMN `waiver_justification` SET TAGS ('pii_business_glossary_term' = 'Waiver Justification');
ALTER TABLE `vibe_ngo_v1`.`program`.`component_indicator` SET TAGS ('pii_data_type' = 'association_data');
ALTER TABLE `vibe_ngo_v1`.`program`.`component_indicator` SET TAGS ('pii_subdomain' = 'results_framework');
ALTER TABLE `vibe_ngo_v1`.`program`.`component_indicator` SET TAGS ('pii_association_edges' = 'program.component,mel.indicator');
ALTER TABLE `vibe_ngo_v1`.`program`.`component_indicator` SET TAGS ('pii_tier' = 'mvm');
ALTER TABLE `vibe_ngo_v1`.`program`.`component_indicator` SET TAGS ('pii_domain' = 'program');
ALTER TABLE `vibe_ngo_v1`.`program`.`component_indicator` ALTER COLUMN `component_indicator_id` SET TAGS ('pii_business_glossary_term' = 'Component Indicator Assignment ID');
ALTER TABLE `vibe_ngo_v1`.`program`.`component_indicator` ALTER COLUMN `component_id` SET TAGS ('pii_business_glossary_term' = 'Component Indicator - Component Id');
ALTER TABLE `vibe_ngo_v1`.`program`.`component_indicator` ALTER COLUMN `indicator_id` SET TAGS ('pii_business_glossary_term' = 'Component Indicator - Indicator Id');
ALTER TABLE `vibe_ngo_v1`.`program`.`component_indicator` ALTER COLUMN `assignment_date` SET TAGS ('pii_business_glossary_term' = 'Assignment Date');
ALTER TABLE `vibe_ngo_v1`.`program`.`component_indicator` ALTER COLUMN `baseline_value` SET TAGS ('pii_business_glossary_term' = 'Component-Specific Baseline Value');
ALTER TABLE `vibe_ngo_v1`.`program`.`component_indicator` ALTER COLUMN `component_indicator_status` SET TAGS ('pii_business_glossary_term' = 'Assignment Status');
ALTER TABLE `vibe_ngo_v1`.`program`.`component_indicator` ALTER COLUMN `data_collection_method` SET TAGS ('pii_business_glossary_term' = 'Component Data Collection Method');
ALTER TABLE `vibe_ngo_v1`.`program`.`component_indicator` ALTER COLUMN `is_mandatory` SET TAGS ('pii_business_glossary_term' = 'Mandatory Flag');
ALTER TABLE `vibe_ngo_v1`.`program`.`component_indicator` ALTER COLUMN `logframe_reference` SET TAGS ('pii_business_glossary_term' = 'LogFrame Reference');
ALTER TABLE `vibe_ngo_v1`.`program`.`component_indicator` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Assignment Notes');
ALTER TABLE `vibe_ngo_v1`.`program`.`component_indicator` ALTER COLUMN `reporting_frequency` SET TAGS ('pii_business_glossary_term' = 'Component Reporting Frequency');
ALTER TABLE `vibe_ngo_v1`.`program`.`component_indicator` ALTER COLUMN `responsible_unit` SET TAGS ('pii_business_glossary_term' = 'Responsible Unit');
ALTER TABLE `vibe_ngo_v1`.`program`.`component_indicator` ALTER COLUMN `target_value` SET TAGS ('pii_business_glossary_term' = 'Component-Specific Target Value');
ALTER TABLE `vibe_ngo_v1`.`program`.`component_system_usage` SET TAGS ('pii_data_type' = 'association_data');
ALTER TABLE `vibe_ngo_v1`.`program`.`component_system_usage` SET TAGS ('pii_subdomain' = 'delivery_planning');
ALTER TABLE `vibe_ngo_v1`.`program`.`component_system_usage` SET TAGS ('pii_association_edges' = 'program.component,technology.system_platform');
ALTER TABLE `vibe_ngo_v1`.`program`.`component_system_usage` SET TAGS ('pii_tier' = 'mvm');
ALTER TABLE `vibe_ngo_v1`.`program`.`component_system_usage` SET TAGS ('pii_domain' = 'program');
ALTER TABLE `vibe_ngo_v1`.`program`.`component_system_usage` ALTER COLUMN `component_system_usage_id` SET TAGS ('pii_business_glossary_term' = 'Component System Usage ID');
ALTER TABLE `vibe_ngo_v1`.`program`.`component_system_usage` ALTER COLUMN `component_id` SET TAGS ('pii_business_glossary_term' = 'Component System Usage - Component Id');
ALTER TABLE `vibe_ngo_v1`.`program`.`component_system_usage` ALTER COLUMN `system_platform_id` SET TAGS ('pii_business_glossary_term' = 'Component System Usage - System Platform Id');
ALTER TABLE `vibe_ngo_v1`.`program`.`component_system_usage` ALTER COLUMN `activation_date` SET TAGS ('pii_business_glossary_term' = 'Activation Date');
ALTER TABLE `vibe_ngo_v1`.`program`.`component_system_usage` ALTER COLUMN `component_system_role` SET TAGS ('pii_business_glossary_term' = 'Component System Role');
ALTER TABLE `vibe_ngo_v1`.`program`.`component_system_usage` ALTER COLUMN `data_classification_level` SET TAGS ('pii_business_glossary_term' = 'Data Classification Level');
ALTER TABLE `vibe_ngo_v1`.`program`.`component_system_usage` ALTER COLUMN `data_classification_level` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_ngo_v1`.`program`.`component_system_usage` ALTER COLUMN `deactivation_date` SET TAGS ('pii_business_glossary_term' = 'Deactivation Date');
ALTER TABLE `vibe_ngo_v1`.`program`.`component_system_usage` ALTER COLUMN `integration_required_flag` SET TAGS ('pii_business_glossary_term' = 'Integration Required Flag');
ALTER TABLE `vibe_ngo_v1`.`program`.`component_system_usage` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_ngo_v1`.`program`.`component_system_usage` ALTER COLUMN `primary_contact` SET TAGS ('pii_business_glossary_term' = 'Primary Contact');
ALTER TABLE `vibe_ngo_v1`.`program`.`component_system_usage` ALTER COLUMN `usage_status` SET TAGS ('pii_business_glossary_term' = 'Usage Status');
ALTER TABLE `vibe_ngo_v1`.`program`.`component_system_usage` ALTER COLUMN `user_access_count` SET TAGS ('pii_business_glossary_term' = 'User Access Count');
ALTER TABLE `vibe_ngo_v1`.`program`.`program` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_ngo_v1`.`program`.`program` SET TAGS ('pii_subdomain' = 'program_design');
ALTER TABLE `vibe_ngo_v1`.`program`.`program` SET TAGS ('pii_tier' = 'mvm');
ALTER TABLE `vibe_ngo_v1`.`program`.`program` SET TAGS ('pii_domain' = 'program');
ALTER TABLE `vibe_ngo_v1`.`program`.`program` SET TAGS ('pii_column_comment_framework' = 'IATI + IPSAS + eTools');
ALTER TABLE `vibe_ngo_v1`.`program`.`program` ALTER COLUMN `program_id` SET TAGS ('pii_business_glossary_term' = 'Program Identifier');
ALTER TABLE `vibe_ngo_v1`.`program`.`program` ALTER COLUMN `constituent_id` SET TAGS ('pii_business_glossary_term' = 'Donor Id');
ALTER TABLE `vibe_ngo_v1`.`program`.`program` ALTER COLUMN `constituent_id` SET TAGS ('pii_type' = 'personal');
ALTER TABLE `vibe_ngo_v1`.`program`.`program` ALTER COLUMN `country_programme_document_id` SET TAGS ('pii_business_glossary_term' = 'CPD');
ALTER TABLE `vibe_ngo_v1`.`program`.`program` ALTER COLUMN `humanitarian_response_plan_id` SET TAGS ('pii_business_glossary_term' = 'Humanitarian Response Plan Id');
ALTER TABLE `vibe_ngo_v1`.`program`.`program` ALTER COLUMN `parent_program_id` SET TAGS ('pii_business_glossary_term' = 'Parent Program Id');
ALTER TABLE `vibe_ngo_v1`.`program`.`program` ALTER COLUMN `partner_org_id` SET TAGS ('pii_business_glossary_term' = 'Implementing Partner Id');
ALTER TABLE `vibe_ngo_v1`.`program`.`program` ALTER COLUMN `primary_staff_member_id` SET TAGS ('pii_business_glossary_term' = 'Program Manager Id');
ALTER TABLE `vibe_ngo_v1`.`program`.`program` ALTER COLUMN `primary_staff_member_id` SET TAGS ('pii_type' = 'personal');
ALTER TABLE `vibe_ngo_v1`.`program`.`program` ALTER COLUMN `staff_member_id` SET TAGS ('pii_type' = 'personal');
ALTER TABLE `vibe_ngo_v1`.`program`.`program` ALTER COLUMN `strategic_plan_goal_area_id` SET TAGS ('pii_business_glossary_term' = 'Goal Area');
ALTER TABLE `vibe_ngo_v1`.`program`.`program` ALTER COLUMN `unsdcf_outcome_id` SET TAGS ('pii_business_glossary_term' = 'UNSDCF Outcome');
ALTER TABLE `vibe_ngo_v1`.`program`.`program` ALTER COLUMN `approval_date` SET TAGS ('pii_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_ngo_v1`.`program`.`program` ALTER COLUMN `budget_amount` SET TAGS ('pii_business_glossary_term' = 'Budget Amount');
ALTER TABLE `vibe_ngo_v1`.`program`.`program` ALTER COLUMN `budget_currency` SET TAGS ('pii_business_glossary_term' = 'Budget Currency');
ALTER TABLE `vibe_ngo_v1`.`program`.`program` ALTER COLUMN `closeout_date` SET TAGS ('pii_business_glossary_term' = 'Closeout Date');
ALTER TABLE `vibe_ngo_v1`.`program`.`program` ALTER COLUMN `cluster_code` SET TAGS ('pii_business_glossary_term' = 'Cluster Code');
ALTER TABLE `vibe_ngo_v1`.`program`.`program` ALTER COLUMN `program_code` SET TAGS ('pii_business_glossary_term' = 'Program Code');
ALTER TABLE `vibe_ngo_v1`.`program`.`program` ALTER COLUMN `compliance_status` SET TAGS ('pii_business_glossary_term' = 'Compliance Status');
ALTER TABLE `vibe_ngo_v1`.`program`.`program` ALTER COLUMN `country_code` SET TAGS ('pii_business_glossary_term' = 'Country Code');
ALTER TABLE `vibe_ngo_v1`.`program`.`program` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_ngo_v1`.`program`.`program` ALTER COLUMN `program_description` SET TAGS ('pii_business_glossary_term' = 'Program Description');
ALTER TABLE `vibe_ngo_v1`.`program`.`program` ALTER COLUMN `end_date` SET TAGS ('pii_business_glossary_term' = 'End Date');
ALTER TABLE `vibe_ngo_v1`.`program`.`program` ALTER COLUMN `geographic_scope` SET TAGS ('pii_business_glossary_term' = 'Geographic Scope');
ALTER TABLE `vibe_ngo_v1`.`program`.`program` ALTER COLUMN `grant_number` SET TAGS ('pii_business_glossary_term' = 'Grant Number');
ALTER TABLE `vibe_ngo_v1`.`program`.`program` ALTER COLUMN `is_emergency` SET TAGS ('pii_business_glossary_term' = 'Is Emergency');
ALTER TABLE `vibe_ngo_v1`.`program`.`program` ALTER COLUMN `is_multi_year` SET TAGS ('pii_business_glossary_term' = 'Is Multi Year');
ALTER TABLE `vibe_ngo_v1`.`program`.`program` ALTER COLUMN `logframe_reference` SET TAGS ('pii_business_glossary_term' = 'Logframe Reference');
ALTER TABLE `vibe_ngo_v1`.`program`.`program` ALTER COLUMN `modified_by` SET TAGS ('pii_business_glossary_term' = 'Modified By');
ALTER TABLE `vibe_ngo_v1`.`program`.`program` ALTER COLUMN `modified_timestamp` SET TAGS ('pii_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_ngo_v1`.`program`.`program` ALTER COLUMN `monitoring_frequency` SET TAGS ('pii_business_glossary_term' = 'Monitoring Frequency');
ALTER TABLE `vibe_ngo_v1`.`program`.`program` ALTER COLUMN `program_name` SET TAGS ('pii_business_glossary_term' = 'Program Name');
ALTER TABLE `vibe_ngo_v1`.`program`.`program` ALTER COLUMN `program_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`program`.`program` ALTER COLUMN `program_name` SET TAGS ('pii_type' = 'name');
ALTER TABLE `vibe_ngo_v1`.`program`.`program` ALTER COLUMN `program_status` SET TAGS ('pii_business_glossary_term' = 'Program Status');
ALTER TABLE `vibe_ngo_v1`.`program`.`program` ALTER COLUMN `program_type` SET TAGS ('pii_business_glossary_term' = 'Program Type');
ALTER TABLE `vibe_ngo_v1`.`program`.`program` ALTER COLUMN `region` SET TAGS ('pii_business_glossary_term' = 'Region');
ALTER TABLE `vibe_ngo_v1`.`program`.`program` ALTER COLUMN `reporting_frequency` SET TAGS ('pii_business_glossary_term' = 'Reporting Frequency');
ALTER TABLE `vibe_ngo_v1`.`program`.`program` ALTER COLUMN `risk_rating` SET TAGS ('pii_business_glossary_term' = 'Risk Rating');
ALTER TABLE `vibe_ngo_v1`.`program`.`program` ALTER COLUMN `sdg_alignment` SET TAGS ('pii_business_glossary_term' = 'Sdg Alignment');
ALTER TABLE `vibe_ngo_v1`.`program`.`program` ALTER COLUMN `sector_code` SET TAGS ('pii_business_glossary_term' = 'Sector Code');
ALTER TABLE `vibe_ngo_v1`.`program`.`program` ALTER COLUMN `sector_name` SET TAGS ('pii_business_glossary_term' = 'Sector Name');
ALTER TABLE `vibe_ngo_v1`.`program`.`program` ALTER COLUMN `sector_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`program`.`program` ALTER COLUMN `sector_name` SET TAGS ('pii_type' = 'name');
ALTER TABLE `vibe_ngo_v1`.`program`.`program` ALTER COLUMN `start_date` SET TAGS ('pii_business_glossary_term' = 'Start Date');
ALTER TABLE `vibe_ngo_v1`.`program`.`program` ALTER COLUMN `subsector` SET TAGS ('pii_business_glossary_term' = 'Subsector');
ALTER TABLE `vibe_ngo_v1`.`program`.`program` ALTER COLUMN `target_beneficiaries` SET TAGS ('pii_business_glossary_term' = 'Target Beneficiaries');
ALTER TABLE `vibe_ngo_v1`.`program`.`program` ALTER COLUMN `target_population` SET TAGS ('pii_business_glossary_term' = 'Target Population');
ALTER TABLE `vibe_ngo_v1`.`program`.`program` ALTER COLUMN `theory_of_change` SET TAGS ('pii_business_glossary_term' = 'Theory Of Change');
ALTER TABLE `vibe_ngo_v1`.`program`.`program` ALTER COLUMN `created_by` SET TAGS ('pii_business_glossary_term' = 'Created By');
ALTER TABLE `vibe_ngo_v1`.`program`.`country_programme_document` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_ngo_v1`.`program`.`country_programme_document` SET TAGS ('pii_subdomain' = 'program_design');
ALTER TABLE `vibe_ngo_v1`.`program`.`country_programme_document` SET TAGS ('pii_tier' = 'ECM');
ALTER TABLE `vibe_ngo_v1`.`program`.`country_programme_document` SET TAGS ('pii_domain' = 'program');
ALTER TABLE `vibe_ngo_v1`.`program`.`country_programme_document` SET TAGS ('pii_un_hierarchy' = 'true');
ALTER TABLE `vibe_ngo_v1`.`program`.`unsdcf_outcome` SET TAGS ('pii_data_type' = 'reference_data');
ALTER TABLE `vibe_ngo_v1`.`program`.`unsdcf_outcome` SET TAGS ('pii_subdomain' = 'program_design');
ALTER TABLE `vibe_ngo_v1`.`program`.`unsdcf_outcome` SET TAGS ('pii_tier' = 'ECM');
ALTER TABLE `vibe_ngo_v1`.`program`.`unsdcf_outcome` SET TAGS ('pii_domain' = 'program');
ALTER TABLE `vibe_ngo_v1`.`program`.`unsdcf_outcome` SET TAGS ('pii_un_hierarchy' = 'true');
ALTER TABLE `vibe_ngo_v1`.`program`.`strategic_plan_goal_area` SET TAGS ('pii_data_type' = 'reference_data');
ALTER TABLE `vibe_ngo_v1`.`program`.`strategic_plan_goal_area` SET TAGS ('pii_subdomain' = 'program_design');
ALTER TABLE `vibe_ngo_v1`.`program`.`strategic_plan_goal_area` SET TAGS ('pii_tier' = 'ECM');
ALTER TABLE `vibe_ngo_v1`.`program`.`strategic_plan_goal_area` SET TAGS ('pii_domain' = 'program');
ALTER TABLE `vibe_ngo_v1`.`program`.`strategic_plan_goal_area` SET TAGS ('pii_un_hierarchy' = 'true');
ALTER TABLE `vibe_ngo_v1`.`program`.`strategic_plan_goal_area` SET TAGS ('pii_reference_data' = 'true');
ALTER TABLE `vibe_ngo_v1`.`program`.`strategic_plan_goal_area` ALTER COLUMN `goal_area_name` SET TAGS ('pii_type' = 'name');
ALTER TABLE `vibe_ngo_v1`.`program`.`humanitarian_response_plan` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_ngo_v1`.`program`.`humanitarian_response_plan` SET TAGS ('pii_subdomain' = 'program_design');
ALTER TABLE `vibe_ngo_v1`.`program`.`humanitarian_response_plan` SET TAGS ('pii_tier' = 'MVM');
ALTER TABLE `vibe_ngo_v1`.`program`.`humanitarian_response_plan` SET TAGS ('pii_domain' = 'program');
ALTER TABLE `vibe_ngo_v1`.`program`.`humanitarian_response_plan` SET TAGS ('pii_source_system' = 'OCHA FTS');
