-- Metric views for domain: field | Business: Ngo | Version: 2 | Generated on: 2026-07-10 20:18:10

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`field_distribution_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Operational KPIs for field distribution events — tracks budget utilisation, beneficiary reach, and delivery performance across humanitarian distribution activities."
  source: "`vibe_ngo_v1`.`field`.`distribution_event`"
  dimensions:
    - name: "distribution_status"
      expr: distribution_status
      comment: "Current lifecycle status of the distribution event (e.g. Planned, In Progress, Completed, Cancelled) — primary operational filter."
    - name: "distribution_type"
      expr: distribution_type
      comment: "Type of distribution (e.g. Food, NFI, Cash) — used to segment reach and spend by programme type."
    - name: "distribution_modality"
      expr: distribution_modality
      comment: "Delivery modality (e.g. In-Kind, Cash Transfer, Voucher) — critical for programme design decisions."
    - name: "commodity_category"
      expr: commodity_category
      comment: "Category of commodity distributed — enables sector-level performance analysis."
    - name: "admin_level_1"
      expr: admin_level_1
      comment: "First administrative level (e.g. province/state) — geographic dimension for regional performance tracking."
    - name: "admin_level_2"
      expr: admin_level_2
      comment: "Second administrative level (e.g. district) — finer geographic breakdown for field operations."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which expenditure amounts are recorded — required for multi-currency financial analysis."
    - name: "scheduled_month"
      expr: DATE_TRUNC('MONTH', scheduled_date)
      comment: "Month of scheduled distribution — enables trend analysis of planned delivery cadence."
    - name: "incident_reported_flag"
      expr: incident_reported_flag
      comment: "Boolean flag indicating whether a security or operational incident was reported during this event — risk segmentation dimension."
    - name: "pdm_scheduled_flag"
      expr: pdm_scheduled_flag
      comment: "Boolean flag indicating whether a Post-Distribution Monitoring exercise was scheduled — accountability and quality dimension."
    - name: "verification_method"
      expr: verification_method
      comment: "Method used to verify beneficiary identity during distribution — data quality and accountability dimension."
  measures:
    - name: "total_distribution_events"
      expr: COUNT(1)
      comment: "Total number of distribution events — baseline volume KPI for operational throughput reporting."
    - name: "total_actual_expenditure_usd"
      expr: SUM(CAST(actual_expenditure_amount AS DOUBLE))
      comment: "Total actual expenditure across all distribution events — primary financial spend KPI for budget accountability."
    - name: "total_budget_allocated_usd"
      expr: SUM(CAST(budget_allocated_amount AS DOUBLE))
      comment: "Total budget allocated to distribution events — used with actual expenditure to compute utilisation rate."
    - name: "avg_expenditure_per_event_usd"
      expr: AVG(CAST(actual_expenditure_amount AS DOUBLE))
      comment: "Average actual expenditure per distribution event — efficiency benchmark for cost-per-delivery analysis."
    - name: "total_events_with_incidents"
      expr: COUNT(CASE WHEN incident_reported_flag = TRUE THEN 1 END)
      comment: "Number of distribution events where an incident was reported — operational risk KPI; high values trigger security review."
    - name: "total_events_with_pdm_scheduled"
      expr: COUNT(CASE WHEN pdm_scheduled_flag = TRUE THEN 1 END)
      comment: "Number of events with Post-Distribution Monitoring scheduled — accountability coverage KPI; low values indicate monitoring gaps."
    - name: "total_events_sitrep_included"
      expr: COUNT(CASE WHEN sitrep_included_flag = TRUE THEN 1 END)
      comment: "Number of distribution events included in situation reports — donor visibility and reporting compliance KPI."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`field_distribution_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Item-level distribution KPIs — tracks quantities planned vs. distributed, unit values, and variance to assess supply delivery accuracy and commodity pipeline performance."
  source: "`vibe_ngo_v1`.`field`.`distribution_line`"
  dimensions:
    - name: "distribution_status"
      expr: distribution_status
      comment: "Lifecycle status of the distribution line item (e.g. Pending, Distributed, Cancelled) — primary operational filter."
    - name: "distribution_method"
      expr: distribution_method
      comment: "Method used to distribute the commodity — enables modality-level performance analysis."
    - name: "item_category"
      expr: item_category
      comment: "Category of the distributed item (e.g. Food, WASH, Shelter) — sector-level commodity analysis."
    - name: "cluster_sector"
      expr: cluster_sector
      comment: "Humanitarian cluster or sector the line item belongs to — enables cluster-level accountability reporting."
    - name: "unit_of_measure"
      expr: unit_of_measure
      comment: "Unit of measure for quantities (e.g. kg, litres, pieces) — required for meaningful quantity aggregation."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the line item value — multi-currency financial dimension."
    - name: "quality_check_status"
      expr: quality_check_status
      comment: "Result of quality check on the distributed commodity — supply quality dimension for accountability."
    - name: "sdg_alignment"
      expr: sdg_alignment
      comment: "SDG goal alignment of the distribution line — strategic reporting dimension for donor and board reporting."
    - name: "pipeline_source"
      expr: pipeline_source
      comment: "Source pipeline from which the commodity was drawn — supply chain traceability dimension."
    - name: "created_month"
      expr: DATE_TRUNC('MONTH', created_timestamp)
      comment: "Month the distribution line was created — time dimension for trend analysis of distribution activity."
  measures:
    - name: "total_planned_quantity"
      expr: SUM(CAST(planned_quantity AS DOUBLE))
      comment: "Total planned quantity across all distribution lines — baseline supply planning KPI."
    - name: "total_actual_quantity_distributed"
      expr: SUM(CAST(actual_quantity_distributed AS DOUBLE))
      comment: "Total quantity actually distributed — primary delivery output KPI; compared against planned to assess pipeline fulfilment."
    - name: "total_variance_quantity"
      expr: SUM(CAST(variance_quantity AS DOUBLE))
      comment: "Total variance between planned and actual quantities — supply gap KPI; large negative values indicate under-delivery requiring investigation."
    - name: "total_distribution_value_usd"
      expr: SUM(CAST(total_value AS DOUBLE))
      comment: "Total monetary value of all distributed items — financial output KPI for donor reporting and programme accountability."
    - name: "avg_unit_value"
      expr: AVG(CAST(unit_value AS DOUBLE))
      comment: "Average unit value of distributed commodities — cost efficiency benchmark; significant changes signal procurement or market price shifts."
    - name: "total_distribution_lines"
      expr: COUNT(1)
      comment: "Total number of distribution line items — volume throughput baseline for operational reporting."
    - name: "total_lines_with_quality_issues"
      expr: COUNT(CASE WHEN quality_check_status NOT IN ('Passed', 'Approved') AND quality_check_status IS NOT NULL THEN 1 END)
      comment: "Number of distribution lines that did not pass quality checks — supply quality risk KPI; high values trigger procurement or logistics review."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`field_emergency`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPIs for humanitarian emergencies — tracks funding gaps, population reach, response activation, and severity to support executive decision-making on resource mobilisation."
  source: "`vibe_ngo_v1`.`field`.`emergency`"
  dimensions:
    - name: "emergency_status"
      expr: emergency_status
      comment: "Current status of the emergency (e.g. Active, Closed, Escalated) — primary lifecycle filter for operational dashboards."
    - name: "emergency_type"
      expr: emergency_type
      comment: "Type of emergency (e.g. Flood, Conflict, Drought) — enables sector and hazard-type performance analysis."
    - name: "disaster_category"
      expr: disaster_category
      comment: "Disaster category classification — aligns with OCHA and donor reporting taxonomies."
    - name: "severity_level"
      expr: severity_level
      comment: "Severity classification of the emergency — critical dimension for prioritisation and resource allocation decisions."
    - name: "geographic_scope"
      expr: geographic_scope
      comment: "Geographic scope of the emergency (e.g. National, Sub-national, Regional) — scale dimension for response planning."
    - name: "response_modality"
      expr: response_modality
      comment: "Primary response modality (e.g. In-Kind, Cash, Mixed) — programme design dimension."
    - name: "declaration_year"
      expr: DATE_TRUNC('YEAR', declaration_date)
      comment: "Year the emergency was declared — time dimension for annual trend analysis of emergency frequency."
    - name: "flash_appeal_issued"
      expr: flash_appeal_issued
      comment: "Boolean flag indicating whether a Flash Appeal was issued — donor mobilisation and funding mechanism dimension."
    - name: "hrp_issued"
      expr: hrp_issued
      comment: "Boolean flag indicating whether a Humanitarian Response Plan was issued — strategic planning compliance dimension."
    - name: "rapid_assessment_completed"
      expr: rapid_assessment_completed
      comment: "Boolean flag indicating whether a rapid needs assessment was completed — response readiness dimension."
  measures:
    - name: "total_active_emergencies"
      expr: COUNT(CASE WHEN is_active = TRUE THEN 1 END)
      comment: "Number of currently active emergencies — primary operational risk KPI for executive situational awareness."
    - name: "total_affected_population"
      expr: SUM(CAST(affected_population_count AS DOUBLE))
      comment: "Total number of people affected across all emergencies — humanitarian scale KPI for resource mobilisation decisions."
    - name: "total_targeted_beneficiaries"
      expr: SUM(CAST(targeted_beneficiaries_count AS DOUBLE))
      comment: "Total number of beneficiaries targeted for response — programme reach KPI; compared against affected population to assess coverage gap."
    - name: "total_displaced_population"
      expr: SUM(CAST(displaced_population_count AS DOUBLE))
      comment: "Total displaced population across emergencies — protection and shelter planning KPI."
    - name: "total_funding_received_usd"
      expr: SUM(CAST(funding_received_usd AS DOUBLE))
      comment: "Total funding received across all emergencies — financial mobilisation KPI for donor reporting and gap analysis."
    - name: "total_funding_requirement_usd"
      expr: SUM(CAST(funding_requirement_usd AS DOUBLE))
      comment: "Total funding required across all emergencies — used with funding received to compute funding gap; critical for resource mobilisation."
    - name: "avg_funding_received_per_emergency_usd"
      expr: AVG(CAST(funding_received_usd AS DOUBLE))
      comment: "Average funding received per emergency — benchmarks resource mobilisation efficiency across emergency types and geographies."
    - name: "total_emergencies_with_hrp"
      expr: COUNT(CASE WHEN hrp_issued = TRUE THEN 1 END)
      comment: "Number of emergencies with a Humanitarian Response Plan issued — strategic planning compliance KPI."
    - name: "total_emergencies_with_rapid_assessment"
      expr: COUNT(CASE WHEN rapid_assessment_completed = TRUE THEN 1 END)
      comment: "Number of emergencies where a rapid assessment was completed — response readiness KPI; low values indicate assessment gaps."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`field_assessment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Quality and coverage KPIs for field assessments — tracks data quality, beneficiary satisfaction, adequacy, and utilisation rates to inform programme design and MEL decisions."
  source: "`vibe_ngo_v1`.`field`.`assessment`"
  dimensions:
    - name: "assessment_status"
      expr: assessment_status
      comment: "Current status of the assessment (e.g. Draft, Completed, Validated) — lifecycle filter for quality reporting."
    - name: "assessment_type"
      expr: assessment_type
      comment: "Type of assessment (e.g. Needs Assessment, PDM, Baseline, Endline) — primary segmentation for MEL and programme design."
    - name: "methodology"
      expr: methodology
      comment: "Data collection methodology used (e.g. KII, FGD, Survey) — quality and comparability dimension."
    - name: "data_collection_tool"
      expr: data_collection_tool
      comment: "Tool used for data collection (e.g. KoBoToolbox, ODK) — digital data quality dimension."
    - name: "geographic_scope"
      expr: geographic_scope
      comment: "Geographic scope of the assessment — scale dimension for coverage analysis."
    - name: "assessment_month"
      expr: DATE_TRUNC('MONTH', assessment_date)
      comment: "Month the assessment was conducted — time dimension for trend analysis of assessment cadence."
    - name: "mel_indicator_linked"
      expr: mel_indicator_linked
      comment: "Boolean flag indicating whether the assessment is linked to a MEL indicator — strategic alignment dimension."
    - name: "protection_concerns_noted"
      expr: protection_concerns_noted
      comment: "Boolean flag indicating whether protection concerns were identified — risk and safeguarding dimension."
    - name: "donor_visibility_flag"
      expr: donor_visibility_flag
      comment: "Boolean flag indicating whether the assessment is visible to donors — accountability and transparency dimension."
    - name: "cluster_coordination_body"
      expr: cluster_coordination_body
      comment: "Cluster or coordination body the assessment is associated with — inter-agency coordination dimension."
  measures:
    - name: "total_assessments"
      expr: COUNT(1)
      comment: "Total number of assessments conducted — baseline volume KPI for MEL coverage reporting."
    - name: "avg_data_quality_score"
      expr: AVG(CAST(data_quality_score AS DOUBLE))
      comment: "Average data quality score across assessments — primary data integrity KPI; low scores trigger data collection process review."
    - name: "avg_beneficiary_satisfaction_score"
      expr: AVG(CAST(beneficiary_satisfaction_score AS DOUBLE))
      comment: "Average beneficiary satisfaction score — accountability to affected populations KPI; directly informs programme quality decisions."
    - name: "avg_adequacy_score"
      expr: AVG(CAST(adequacy_score AS DOUBLE))
      comment: "Average adequacy score of assessed interventions — programme effectiveness KPI; low scores indicate need for programme redesign."
    - name: "avg_utilisation_rate_percent"
      expr: AVG(CAST(utilization_rate_percent AS DOUBLE))
      comment: "Average utilisation rate of assessed services or resources — efficiency KPI; low utilisation signals access barriers or targeting issues."
    - name: "total_assessments_with_protection_concerns"
      expr: COUNT(CASE WHEN protection_concerns_noted = TRUE THEN 1 END)
      comment: "Number of assessments where protection concerns were identified — safeguarding risk KPI; high values require immediate programme response."
    - name: "total_validated_assessments"
      expr: COUNT(CASE WHEN assessment_status = 'Validated' THEN 1 END)
      comment: "Number of assessments that have been formally validated — data governance and quality assurance KPI."
    - name: "total_assessments_linked_to_mel"
      expr: COUNT(CASE WHEN mel_indicator_linked = TRUE THEN 1 END)
      comment: "Number of assessments linked to MEL indicators — strategic alignment KPI; low values indicate MEL framework gaps."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`field_assessment_response`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Household and individual-level assessment response KPIs — tracks vulnerability, food security, protection concerns, and referral needs to inform targeting and programme design."
  source: "`vibe_ngo_v1`.`field`.`assessment_response`"
  dimensions:
    - name: "assessment_response_status"
      expr: assessment_response_status
      comment: "Status of the assessment response record (e.g. Submitted, Validated, Rejected) — data quality lifecycle filter."
    - name: "displacement_status"
      expr: displacement_status
      comment: "Displacement status of the respondent household (e.g. IDP, Refugee, Host Community) — primary targeting and vulnerability dimension."
    - name: "primary_need_category"
      expr: primary_need_category
      comment: "Primary humanitarian need category identified (e.g. Food, Shelter, WASH) — programme design and resource allocation dimension."
    - name: "shelter_type"
      expr: shelter_type
      comment: "Type of shelter the household occupies — vulnerability and shelter programme targeting dimension."
    - name: "shelter_condition"
      expr: shelter_condition
      comment: "Condition of the household shelter — severity dimension for shelter programme prioritisation."
    - name: "livelihood_status"
      expr: livelihood_status
      comment: "Livelihood status of the household — economic vulnerability dimension for cash and livelihoods programming."
    - name: "data_collection_method"
      expr: data_collection_method
      comment: "Method used to collect the response (e.g. Face-to-face, Phone, Digital) — data quality and reach dimension."
    - name: "interview_language"
      expr: interview_language
      comment: "Language in which the interview was conducted — inclusion and language access dimension."
    - name: "submission_month"
      expr: DATE_TRUNC('MONTH', submission_timestamp)
      comment: "Month the response was submitted — time dimension for trend analysis of data collection activity."
    - name: "protection_concern_flag"
      expr: protection_concern_flag
      comment: "Boolean flag indicating whether a protection concern was identified for this respondent — safeguarding risk dimension."
    - name: "referral_required_flag"
      expr: referral_required_flag
      comment: "Boolean flag indicating whether a referral to another service was required — case management and service linkage dimension."
    - name: "disability_present_flag"
      expr: disability_present_flag
      comment: "Boolean flag indicating disability presence in the household — inclusion and equity targeting dimension."
  measures:
    - name: "total_assessment_responses"
      expr: COUNT(1)
      comment: "Total number of assessment responses collected — baseline data coverage KPI for MEL and programme reporting."
    - name: "total_unique_households_assessed"
      expr: COUNT(DISTINCT household_id)
      comment: "Number of distinct households covered by assessment responses — reach KPI for household-level programme targeting."
    - name: "avg_food_security_score"
      expr: AVG(CAST(food_security_score AS DOUBLE))
      comment: "Average food security score across respondents — primary food security KPI; low scores trigger emergency food response decisions."
    - name: "avg_monthly_income_usd"
      expr: AVG(CAST(monthly_income_usd AS DOUBLE))
      comment: "Average monthly household income in USD — economic vulnerability KPI for cash transfer targeting and livelihoods programming."
    - name: "total_responses_with_protection_concerns"
      expr: COUNT(CASE WHEN protection_concern_flag = TRUE THEN 1 END)
      comment: "Number of responses where protection concerns were identified — safeguarding caseload KPI; drives referral and case management resourcing."
    - name: "total_responses_requiring_referral"
      expr: COUNT(CASE WHEN referral_required_flag = TRUE THEN 1 END)
      comment: "Number of respondents requiring referral to another service — service linkage demand KPI; informs case management capacity planning."
    - name: "total_responses_with_disability"
      expr: COUNT(CASE WHEN disability_present_flag = TRUE THEN 1 END)
      comment: "Number of responses where disability was present in the household — inclusion KPI; low proportions relative to population estimates indicate targeting gaps."
    - name: "total_responses_with_consent_follow_up"
      expr: COUNT(CASE WHEN consent_follow_up = TRUE THEN 1 END)
      comment: "Number of respondents who consented to follow-up contact — longitudinal tracking eligibility KPI for MEL and PDM planning."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`field_security_incident`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Security risk and incident KPIs — tracks incident frequency, severity, financial losses, staff casualties, and reporting compliance to support duty-of-care and operational risk management decisions."
  source: "`vibe_ngo_v1`.`field`.`security_incident`"
  dimensions:
    - name: "security_incident_type"
      expr: security_incident_type
      comment: "Type of security incident (e.g. Armed Robbery, Carjacking, Threat) — primary risk categorisation dimension."
    - name: "security_incident_status"
      expr: security_incident_status
      comment: "Current status of the incident (e.g. Open, Under Investigation, Closed) — case management lifecycle dimension."
    - name: "severity"
      expr: severity
      comment: "Severity classification of the incident — risk prioritisation dimension for executive escalation decisions."
    - name: "investigation_status"
      expr: investigation_status
      comment: "Status of the incident investigation — accountability and corrective action tracking dimension."
    - name: "admin_level_1"
      expr: admin_level_1
      comment: "First administrative level where the incident occurred — geographic risk mapping dimension."
    - name: "admin_level_2"
      expr: admin_level_2
      comment: "Second administrative level where the incident occurred — finer geographic risk analysis."
    - name: "incident_month"
      expr: DATE_TRUNC('MONTH', security_incident_date)
      comment: "Month the security incident occurred — time dimension for trend analysis of security risk patterns."
    - name: "reported_to_inso"
      expr: reported_to_inso
      comment: "Boolean flag indicating whether the incident was reported to INSO — external reporting compliance dimension."
    - name: "reported_to_undss"
      expr: reported_to_undss
      comment: "Boolean flag indicating whether the incident was reported to UNDSS — UN security coordination compliance dimension."
    - name: "sitrep_included"
      expr: sitrep_included
      comment: "Boolean flag indicating whether the incident was included in a situation report — donor and stakeholder transparency dimension."
  measures:
    - name: "total_security_incidents"
      expr: COUNT(1)
      comment: "Total number of security incidents recorded — primary operational risk volume KPI for duty-of-care reporting."
    - name: "total_estimated_asset_loss_usd"
      expr: SUM(CAST(estimated_asset_loss_usd AS DOUBLE))
      comment: "Total estimated financial loss from asset damage or theft across incidents — financial risk KPI for insurance and risk management decisions."
    - name: "avg_estimated_asset_loss_usd"
      expr: AVG(CAST(estimated_asset_loss_usd AS DOUBLE))
      comment: "Average estimated asset loss per incident — cost-per-incident benchmark for risk mitigation investment decisions."
    - name: "total_open_incidents"
      expr: COUNT(CASE WHEN security_incident_status = 'Open' THEN 1 END)
      comment: "Number of currently open security incidents — active risk caseload KPI; high values indicate investigation capacity constraints."
    - name: "total_incidents_reported_to_inso"
      expr: COUNT(CASE WHEN reported_to_inso = TRUE THEN 1 END)
      comment: "Number of incidents reported to INSO — external reporting compliance KPI; low rates relative to total incidents indicate reporting gaps."
    - name: "total_incidents_reported_to_undss"
      expr: COUNT(CASE WHEN reported_to_undss = TRUE THEN 1 END)
      comment: "Number of incidents reported to UNDSS — UN security coordination compliance KPI."
    - name: "total_incidents_in_sitrep"
      expr: COUNT(CASE WHEN sitrep_included = TRUE THEN 1 END)
      comment: "Number of incidents included in situation reports — stakeholder transparency and donor reporting compliance KPI."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`field_deployment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Field deployment operational KPIs — tracks deployment costs, duration, status, and coverage to support workforce planning and operational efficiency decisions."
  source: "`vibe_ngo_v1`.`field`.`field_deployment`"
  dimensions:
    - name: "field_deployment_status"
      expr: field_deployment_status
      comment: "Current status of the field deployment (e.g. Planned, Active, Completed, Cancelled) — primary lifecycle filter."
    - name: "field_deployment_type"
      expr: field_deployment_type
      comment: "Type of field deployment (e.g. Emergency Response, Monitoring, Assessment) — programme activity dimension."
    - name: "response_type"
      expr: response_type
      comment: "Response type classification — aligns deployments to emergency or development programming."
    - name: "transportation_mode"
      expr: transportation_mode
      comment: "Mode of transportation used for the deployment — logistics cost and access dimension."
    - name: "security_clearance_level"
      expr: security_clearance_level
      comment: "Security clearance level required for the deployment — risk and access constraint dimension."
    - name: "cluster_affiliation"
      expr: cluster_affiliation
      comment: "Humanitarian cluster the deployment is affiliated with — inter-agency coordination dimension."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the cost estimate — multi-currency financial dimension."
    - name: "deployment_start_month"
      expr: DATE_TRUNC('MONTH', start_date)
      comment: "Month the deployment was scheduled to start — time dimension for workforce planning trend analysis."
    - name: "gis_track_enabled"
      expr: gis_track_enabled
      comment: "Boolean flag indicating whether GIS tracking was enabled for the deployment — digital field management dimension."
    - name: "medical_clearance_required"
      expr: medical_clearance_required
      comment: "Boolean flag indicating whether medical clearance was required — duty-of-care compliance dimension."
  measures:
    - name: "total_field_deployments"
      expr: COUNT(1)
      comment: "Total number of field deployments — baseline operational throughput KPI for workforce planning."
    - name: "total_cost_estimate"
      expr: SUM(CAST(cost_estimate AS DOUBLE))
      comment: "Total estimated cost of all field deployments — financial planning KPI for operational budget management."
    - name: "avg_cost_per_deployment"
      expr: AVG(CAST(cost_estimate AS DOUBLE))
      comment: "Average estimated cost per field deployment — efficiency benchmark for deployment cost optimisation decisions."
    - name: "total_active_deployments"
      expr: COUNT(CASE WHEN field_deployment_status = 'Active' THEN 1 END)
      comment: "Number of currently active field deployments — real-time operational capacity KPI for field management."
    - name: "total_deployments_with_gis_tracking"
      expr: COUNT(CASE WHEN gis_track_enabled = TRUE THEN 1 END)
      comment: "Number of deployments with GIS tracking enabled — digital field management adoption KPI; low values indicate monitoring gaps."
    - name: "total_deployments_requiring_medical_clearance"
      expr: COUNT(CASE WHEN medical_clearance_required = TRUE THEN 1 END)
      comment: "Number of deployments requiring medical clearance — duty-of-care compliance volume KPI for HR and safety management."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`field_project_site`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Project site infrastructure and operational KPIs — tracks site coverage, accessibility, utility availability, and operational status to support field infrastructure investment decisions."
  source: "`vibe_ngo_v1`.`field`.`project_site`"
  dimensions:
    - name: "operational_status"
      expr: operational_status
      comment: "Current operational status of the project site (e.g. Active, Closed, Suspended) — primary lifecycle filter."
    - name: "project_site_type"
      expr: project_site_type
      comment: "Type of project site (e.g. Health Post, Distribution Point, Office) — infrastructure category dimension."
    - name: "admin_level_1"
      expr: admin_level_1
      comment: "First administrative level of the site — geographic dimension for regional coverage analysis."
    - name: "admin_level_2"
      expr: admin_level_2
      comment: "Second administrative level of the site — finer geographic breakdown for field planning."
    - name: "cluster_affiliation"
      expr: cluster_affiliation
      comment: "Humanitarian cluster the site is affiliated with — inter-agency coordination dimension."
    - name: "accessibility_rating"
      expr: accessibility_rating
      comment: "Accessibility rating of the site — access constraint dimension for logistics and field planning."
    - name: "security_level"
      expr: security_level
      comment: "Security level classification of the site — risk dimension for staff safety and operational continuity decisions."
    - name: "facility_ownership"
      expr: facility_ownership
      comment: "Ownership type of the facility (e.g. Owned, Rented, Government) — asset management and cost dimension."
    - name: "electricity_available"
      expr: electricity_available
      comment: "Boolean flag indicating whether electricity is available at the site — infrastructure quality dimension."
    - name: "water_source_available"
      expr: water_source_available
      comment: "Boolean flag indicating whether a water source is available at the site — WASH infrastructure dimension."
    - name: "kobo_collection_enabled"
      expr: kobo_collection_enabled
      comment: "Boolean flag indicating whether KoBoToolbox data collection is enabled at the site — digital data management dimension."
    - name: "establishment_year"
      expr: DATE_TRUNC('YEAR', establishment_date)
      comment: "Year the project site was established — time dimension for infrastructure portfolio age analysis."
  measures:
    - name: "total_project_sites"
      expr: COUNT(1)
      comment: "Total number of project sites — baseline infrastructure portfolio KPI for field coverage reporting."
    - name: "total_active_project_sites"
      expr: COUNT(CASE WHEN operational_status = 'Active' THEN 1 END)
      comment: "Number of currently active project sites — operational coverage KPI; drives field infrastructure investment decisions."
    - name: "total_area_sqm"
      expr: SUM(CAST(area_sqm AS DOUBLE))
      comment: "Total physical area of all project sites in square metres — infrastructure scale KPI for asset management."
    - name: "avg_area_sqm"
      expr: AVG(CAST(area_sqm AS DOUBLE))
      comment: "Average site area in square metres — infrastructure sizing benchmark for facility planning decisions."
    - name: "total_sites_with_electricity"
      expr: COUNT(CASE WHEN electricity_available = TRUE THEN 1 END)
      comment: "Number of sites with electricity available — infrastructure quality KPI; low values indicate energy access gaps affecting service delivery."
    - name: "total_sites_with_water"
      expr: COUNT(CASE WHEN water_source_available = TRUE THEN 1 END)
      comment: "Number of sites with water source available — WASH infrastructure KPI; critical for health and hygiene programme delivery."
    - name: "total_sites_with_kobo_enabled"
      expr: COUNT(CASE WHEN kobo_collection_enabled = TRUE THEN 1 END)
      comment: "Number of sites with KoBoToolbox data collection enabled — digital data management coverage KPI for MEL quality assurance."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`field_country_office`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Country office operational KPIs — tracks office registration compliance, MOU status, security levels, and emergency response capacity to support country programme governance decisions."
  source: "`vibe_ngo_v1`.`field`.`country_office`"
  dimensions:
    - name: "operational_status"
      expr: operational_status
      comment: "Current operational status of the country office (e.g. Active, Closed, Suspended) — primary lifecycle filter."
    - name: "country_office_type"
      expr: country_office_type
      comment: "Type of country office (e.g. Country Office, Sub-Office, Field Office) — organisational hierarchy dimension."
    - name: "registration_status"
      expr: registration_status
      comment: "Legal registration status of the office — compliance and legal risk dimension."
    - name: "security_level"
      expr: security_level
      comment: "Security level classification of the office location — duty-of-care and operational risk dimension."
    - name: "currency_code"
      expr: currency_code
      comment: "Operating currency of the country office — financial management dimension."
    - name: "is_emergency_response"
      expr: is_emergency_response
      comment: "Boolean flag indicating whether the office is operating in emergency response mode — programme type dimension."
    - name: "mou_with_government"
      expr: mou_with_government
      comment: "Boolean flag indicating whether an MOU with the host government is in place — legal and partnership compliance dimension."
    - name: "establishment_year"
      expr: DATE_TRUNC('YEAR', establishment_date)
      comment: "Year the country office was established — time dimension for portfolio age and maturity analysis."
  measures:
    - name: "total_country_offices"
      expr: COUNT(1)
      comment: "Total number of country offices — baseline organisational footprint KPI for geographic coverage reporting."
    - name: "total_active_country_offices"
      expr: COUNT(CASE WHEN operational_status = 'Active' THEN 1 END)
      comment: "Number of currently active country offices — operational presence KPI for strategic geographic coverage decisions."
    - name: "total_emergency_response_offices"
      expr: COUNT(CASE WHEN is_emergency_response = TRUE THEN 1 END)
      comment: "Number of offices operating in emergency response mode — humanitarian surge capacity KPI for resource mobilisation."
    - name: "total_offices_with_mou"
      expr: COUNT(CASE WHEN mou_with_government = TRUE THEN 1 END)
      comment: "Number of offices with a government MOU in place — legal compliance and host government partnership KPI."
    - name: "total_offices_with_active_registration"
      expr: COUNT(CASE WHEN registration_status = 'Active' THEN 1 END)
      comment: "Number of offices with active legal registration — regulatory compliance KPI; non-compliant offices face operational suspension risk."
$$;