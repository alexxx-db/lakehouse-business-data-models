-- Metric views for domain: field | Business: Ngo | Version: 2 | Generated on: 2026-07-10 18:25:58

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`field_distribution_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Operational KPIs for field distribution events — tracks beneficiary reach, expenditure efficiency, and distribution performance to inform resource allocation and program steering decisions."
  source: "`vibe_ngo_v1`.`field`.`distribution_event`"
  dimensions:
    - name: "distribution_status"
      expr: distribution_status
      comment: "Current status of the distribution event (e.g., planned, in-progress, completed) for pipeline and completion analysis."
    - name: "distribution_type"
      expr: distribution_type
      comment: "Type of distribution (e.g., food, NFI, cash) enabling sector-level performance comparison."
    - name: "distribution_modality"
      expr: distribution_modality
      comment: "Delivery modality (e.g., in-kind, cash transfer, voucher) for modality effectiveness analysis."
    - name: "commodity_category"
      expr: commodity_category
      comment: "Category of commodity distributed, enabling commodity-level reach and cost analysis."
    - name: "admin_level_1"
      expr: admin_level_1
      comment: "First administrative level (e.g., region/province) for geographic disaggregation of distribution performance."
    - name: "admin_level_2"
      expr: admin_level_2
      comment: "Second administrative level (e.g., district) for finer geographic disaggregation."
    - name: "scheduled_date_month"
      expr: DATE_TRUNC('MONTH', scheduled_date)
      comment: "Month of scheduled distribution date for trend analysis of distribution pipeline."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of expenditure amounts for multi-currency financial analysis."
    - name: "verification_method"
      expr: verification_method
      comment: "Method used to verify beneficiary receipt, informing accountability and data quality assessments."
    - name: "pdm_scheduled_flag"
      expr: pdm_scheduled_flag
      comment: "Whether a post-distribution monitoring survey is scheduled, indicating accountability compliance."
  measures:
    - name: "total_distribution_events"
      expr: COUNT(1)
      comment: "Total number of distribution events. Baseline volume metric for operational throughput reporting."
    - name: "total_actual_expenditure"
      expr: SUM(CAST(actual_expenditure_amount AS DOUBLE))
      comment: "Total actual expenditure across distribution events. Core financial KPI for budget burn and donor reporting."
    - name: "total_budget_allocated"
      expr: SUM(CAST(budget_allocated_amount AS DOUBLE))
      comment: "Total budget allocated to distribution events. Used alongside actual expenditure to compute utilization."
    - name: "avg_expenditure_per_event"
      expr: AVG(CAST(actual_expenditure_amount AS DOUBLE))
      comment: "Average actual expenditure per distribution event. Benchmarks cost efficiency across event types and geographies."
    - name: "budget_utilization_rate"
      expr: ROUND(100.0 * SUM(CAST(actual_expenditure_amount AS DOUBLE)) / NULLIF(SUM(CAST(budget_allocated_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of allocated budget actually spent. Critical for financial accountability and donor compliance — low utilization signals absorption issues; over-utilization signals budget risk."
    - name: "events_with_incident_reported"
      expr: COUNT(CASE WHEN incident_reported_flag = TRUE THEN 1 END)
      comment: "Number of distribution events where an incident was reported. Safety and risk KPI for field operations oversight."
    - name: "incident_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN incident_reported_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of distribution events with a reported incident. Tracks field safety risk and informs security protocols."
    - name: "events_with_pdm_completed"
      expr: COUNT(CASE WHEN pdm_completion_date IS NOT NULL THEN 1 END)
      comment: "Number of events where post-distribution monitoring was completed. Accountability compliance KPI for donor and cluster reporting."
    - name: "pdm_completion_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN pdm_completion_date IS NOT NULL THEN 1 END) / NULLIF(COUNT(CASE WHEN pdm_scheduled_flag = TRUE THEN 1 END), 0), 2)
      comment: "Percentage of scheduled PDM surveys that were completed. Measures accountability follow-through — low rates trigger donor and cluster escalations."
    - name: "sitrep_inclusion_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN sitrep_included_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of distribution events included in situation reports. Measures reporting compliance for OCHA and donor visibility requirements."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`field_assessment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Quality and performance KPIs for field assessments — tracks data quality, beneficiary satisfaction, and assessment utilization to steer evidence-based programming decisions."
  source: "`vibe_ngo_v1`.`field`.`assessment`"
  dimensions:
    - name: "assessment_type"
      expr: assessment_type
      comment: "Type of assessment (e.g., needs, PDM, baseline, endline) for comparative quality analysis."
    - name: "assessment_status"
      expr: assessment_status
      comment: "Current status of the assessment (e.g., planned, in-progress, completed, validated) for pipeline tracking."
    - name: "methodology"
      expr: methodology
      comment: "Data collection methodology (e.g., KII, FGD, survey) for methodological quality benchmarking."
    - name: "geographic_scope"
      expr: geographic_scope
      comment: "Geographic scope of the assessment for spatial coverage analysis."
    - name: "assessment_date_month"
      expr: DATE_TRUNC('MONTH', assessment_date)
      comment: "Month of assessment date for trend analysis of assessment activity."
    - name: "protection_concerns_noted"
      expr: protection_concerns_noted
      comment: "Whether protection concerns were identified, enabling protection-sensitive programming analysis."
    - name: "donor_visibility_flag"
      expr: donor_visibility_flag
      comment: "Whether the assessment is flagged for donor visibility, relevant for donor reporting compliance."
    - name: "mel_indicator_linked"
      expr: mel_indicator_linked
      comment: "Whether the assessment is linked to an MEL indicator, measuring evidence integration into the results framework."
  measures:
    - name: "total_assessments"
      expr: COUNT(1)
      comment: "Total number of assessments conducted. Baseline volume metric for evidence generation capacity."
    - name: "avg_data_quality_score"
      expr: AVG(CAST(data_quality_score AS DOUBLE))
      comment: "Average data quality score across assessments. Core quality KPI — low scores indicate data reliability risks that undermine evidence-based decisions."
    - name: "avg_beneficiary_satisfaction_score"
      expr: AVG(CAST(beneficiary_satisfaction_score AS DOUBLE))
      comment: "Average beneficiary satisfaction score. Strategic KPI for accountability to affected populations (AAP) and CHS compliance."
    - name: "avg_adequacy_score"
      expr: AVG(CAST(adequacy_score AS DOUBLE))
      comment: "Average adequacy score measuring whether assistance met beneficiary needs. Directly informs program design and targeting decisions."
    - name: "avg_utilization_rate_pct"
      expr: AVG(CAST(utilization_rate_percent AS DOUBLE))
      comment: "Average utilization rate across assessments. Measures how effectively assessment findings are being used in programming."
    - name: "assessments_with_protection_concerns"
      expr: COUNT(CASE WHEN protection_concerns_noted = TRUE THEN 1 END)
      comment: "Number of assessments identifying protection concerns. Risk KPI that triggers protection mainstreaming and referral pathway reviews."
    - name: "protection_concern_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN protection_concerns_noted = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of assessments flagging protection concerns. Tracks protection risk prevalence across geographies and program types."
    - name: "assessments_linked_to_indicators"
      expr: COUNT(CASE WHEN mel_indicator_linked = TRUE THEN 1 END)
      comment: "Number of assessments linked to MEL indicators. Measures integration of field evidence into the results framework."
    - name: "indicator_linkage_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN mel_indicator_linked = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of assessments linked to MEL indicators. Strategic KPI for evidence-based programming — low rates indicate a disconnect between field data and results measurement."
    - name: "validated_assessments"
      expr: COUNT(CASE WHEN validation_date IS NOT NULL THEN 1 END)
      comment: "Number of assessments that have been formally validated. Data governance KPI ensuring only quality-assured evidence informs decisions."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`field_emergency`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPIs for humanitarian emergency response — tracks funding coverage, population reach, and response activation to inform resource mobilization and escalation decisions."
  source: "`vibe_ngo_v1`.`field`.`emergency`"
  dimensions:
    - name: "emergency_type"
      expr: emergency_type
      comment: "Type of emergency (e.g., flood, conflict, disease outbreak) for hazard-specific response analysis."
    - name: "emergency_status"
      expr: emergency_status
      comment: "Current status of the emergency (e.g., active, monitoring, closed) for pipeline and resource allocation."
    - name: "severity_level"
      expr: severity_level
      comment: "Severity classification of the emergency for prioritization and escalation decisions."
    - name: "disaster_category"
      expr: disaster_category
      comment: "Disaster category (e.g., natural, man-made, complex) for cross-category response benchmarking."
    - name: "geographic_scope"
      expr: geographic_scope
      comment: "Geographic scope of the emergency for spatial resource planning."
    - name: "response_modality"
      expr: response_modality
      comment: "Primary response modality (e.g., in-kind, cash, hybrid) for modality effectiveness analysis."
    - name: "onset_date_month"
      expr: DATE_TRUNC('MONTH', onset_date)
      comment: "Month of emergency onset for temporal trend analysis of emergency frequency and response speed."
    - name: "flash_appeal_issued"
      expr: flash_appeal_issued
      comment: "Whether a flash appeal was issued, indicating scale and international coordination requirements."
    - name: "hrp_issued"
      expr: hrp_issued
      comment: "Whether a Humanitarian Response Plan was issued, indicating strategic planning maturity."
    - name: "is_active"
      expr: is_active
      comment: "Whether the emergency is currently active, for filtering active vs. historical response analysis."
  measures:
    - name: "total_emergencies"
      expr: COUNT(1)
      comment: "Total number of emergencies tracked. Baseline volume metric for emergency portfolio management."
    - name: "total_affected_population"
      expr: SUM(CAST(affected_population_count AS DOUBLE))
      comment: "Total affected population across all emergencies. Primary scale metric for resource mobilization and donor appeals."
    - name: "total_targeted_beneficiaries"
      expr: SUM(CAST(targeted_beneficiaries_count AS DOUBLE))
      comment: "Total targeted beneficiaries across emergencies. Measures programmatic ambition and coverage planning."
    - name: "total_displaced_population"
      expr: SUM(CAST(displaced_population_count AS DOUBLE))
      comment: "Total displaced population across emergencies. Critical protection and shelter planning KPI."
    - name: "total_funding_received_usd"
      expr: SUM(CAST(funding_received_usd AS DOUBLE))
      comment: "Total funding received across emergencies in USD. Core financial KPI for resource mobilization tracking."
    - name: "total_funding_requirement_usd"
      expr: SUM(CAST(funding_requirement_usd AS DOUBLE))
      comment: "Total funding requirement across emergencies in USD. Used to compute funding gap and coverage ratio."
    - name: "funding_coverage_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(funding_received_usd AS DOUBLE)) / NULLIF(SUM(CAST(funding_requirement_usd AS DOUBLE)), 0), 2)
      comment: "Percentage of funding requirements covered by received funding. Strategic KPI — low coverage triggers emergency donor appeals and resource reallocation decisions."
    - name: "avg_funding_gap_usd"
      expr: AVG(CAST(funding_requirement_usd AS DOUBLE) - CAST(funding_received_usd AS DOUBLE))
      comment: "Average funding gap per emergency (requirement minus received). Prioritization metric for donor engagement and resource mobilization."
    - name: "rapid_assessment_completion_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN rapid_assessment_completed = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of emergencies where a rapid assessment was completed. Measures response preparedness and evidence-based activation quality."
    - name: "avg_targeted_beneficiaries_per_emergency"
      expr: AVG(CAST(targeted_beneficiaries_count AS DOUBLE))
      comment: "Average number of targeted beneficiaries per emergency. Benchmarks response scale and informs staffing and logistics planning."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`field_security_incident`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Security risk KPIs for field operations — tracks incident frequency, severity, financial impact, and reporting compliance to inform duty-of-care and access strategy decisions."
  source: "`vibe_ngo_v1`.`field`.`security_incident`"
  dimensions:
    - name: "security_incident_type"
      expr: security_incident_type
      comment: "Type of security incident (e.g., armed robbery, harassment, vehicle hijacking) for threat pattern analysis."
    - name: "security_incident_status"
      expr: security_incident_status
      comment: "Current status of the incident (e.g., open, under investigation, closed) for case management tracking."
    - name: "severity"
      expr: severity
      comment: "Severity classification of the incident for risk prioritization and escalation decisions."
    - name: "investigation_status"
      expr: investigation_status
      comment: "Status of the incident investigation for accountability and corrective action tracking."
    - name: "admin_level_1"
      expr: admin_level_1
      comment: "First administrative level where the incident occurred for geographic risk mapping."
    - name: "security_incident_date_month"
      expr: DATE_TRUNC('MONTH', security_incident_date)
      comment: "Month of incident date for temporal trend analysis of security risk patterns."
    - name: "reported_to_inso"
      expr: reported_to_inso
      comment: "Whether the incident was reported to INSO, measuring external reporting compliance."
    - name: "reported_to_undss"
      expr: reported_to_undss
      comment: "Whether the incident was reported to UNDSS, measuring UN coordination compliance."
  measures:
    - name: "total_security_incidents"
      expr: COUNT(1)
      comment: "Total number of security incidents. Baseline volume metric for security risk portfolio management."
    - name: "total_estimated_asset_loss_usd"
      expr: SUM(CAST(estimated_asset_loss_usd AS DOUBLE))
      comment: "Total estimated asset loss from security incidents in USD. Financial risk KPI for insurance, donor reporting, and asset management decisions."
    - name: "avg_asset_loss_per_incident_usd"
      expr: AVG(CAST(estimated_asset_loss_usd AS DOUBLE))
      comment: "Average estimated asset loss per security incident. Benchmarks financial exposure per incident type and geography."
    - name: "inso_reporting_compliance_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN reported_to_inso = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of incidents reported to INSO. Compliance KPI — low rates indicate reporting gaps that undermine sector-wide security intelligence."
    - name: "undss_reporting_compliance_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN reported_to_undss = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of incidents reported to UNDSS. UN coordination compliance KPI for duty-of-care and access negotiation."
    - name: "incidents_under_investigation"
      expr: COUNT(CASE WHEN investigation_status IS NOT NULL AND case_closed_date IS NULL THEN 1 END)
      comment: "Number of incidents currently under investigation. Operational KPI for accountability and corrective action pipeline management."
    - name: "sitrep_inclusion_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN sitrep_included = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of security incidents included in situation reports. Measures transparency and donor/cluster reporting compliance."
    - name: "avg_days_to_case_closure"
      expr: AVG(DATEDIFF(case_closed_date, security_incident_date))
      comment: "Average number of days from incident date to case closure. Efficiency KPI for incident management — long closure times indicate accountability gaps."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`field_mobile_health_outreach`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Health service delivery KPIs for mobile health outreach sessions — tracks beneficiary reach by demographic, service coverage, and referral rates to inform health program scaling decisions."
  source: "`vibe_ngo_v1`.`field`.`mobile_health_outreach`"
  dimensions:
    - name: "session_status"
      expr: session_status
      comment: "Status of the outreach session (e.g., completed, cancelled, planned) for pipeline and completion analysis."
    - name: "session_date_month"
      expr: DATE_TRUNC('MONTH', session_date)
      comment: "Month of session date for temporal trend analysis of health service delivery."
    - name: "admin_level_1"
      expr: admin_level_1
      comment: "First administrative level for geographic disaggregation of health service reach."
    - name: "admin_level_2"
      expr: admin_level_2
      comment: "Second administrative level for finer geographic disaggregation."
    - name: "health_cluster_reported"
      expr: health_cluster_reported
      comment: "Whether the session was reported to the health cluster, measuring coordination compliance."
    - name: "sphere_compliant"
      expr: sphere_compliant
      comment: "Whether the session met Sphere standards, measuring humanitarian quality compliance."
    - name: "service_anc_provided"
      expr: service_anc_provided
      comment: "Whether antenatal care was provided, for maternal health service coverage analysis."
    - name: "service_immunization_provided"
      expr: service_immunization_provided
      comment: "Whether immunization services were provided, for vaccination coverage analysis."
    - name: "service_gbv_referral_provided"
      expr: service_gbv_referral_provided
      comment: "Whether GBV referral services were provided, for protection mainstreaming analysis."
    - name: "data_collection_method"
      expr: data_collection_method
      comment: "Method used to collect session data, informing data quality and reporting reliability."
  measures:
    - name: "total_sessions"
      expr: COUNT(1)
      comment: "Total number of mobile health outreach sessions. Baseline volume metric for health service delivery capacity."
    - name: "sphere_compliance_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN sphere_compliant = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of sessions meeting Sphere humanitarian standards. Quality compliance KPI — low rates trigger program quality reviews and corrective action."
    - name: "health_cluster_reporting_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN health_cluster_reported = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of sessions reported to the health cluster. Coordination compliance KPI for 3W reporting and cluster accountability."
    - name: "sessions_with_gbv_referral"
      expr: COUNT(CASE WHEN service_gbv_referral_provided = TRUE THEN 1 END)
      comment: "Number of sessions providing GBV referral services. Protection mainstreaming KPI for gender-based violence response integration."
    - name: "gbv_referral_coverage_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN service_gbv_referral_provided = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of sessions integrating GBV referral services. Strategic protection mainstreaming KPI — low rates indicate gaps in gender-sensitive service delivery."
    - name: "sessions_with_immunization"
      expr: COUNT(CASE WHEN service_immunization_provided = TRUE THEN 1 END)
      comment: "Number of sessions providing immunization services. Vaccination coverage KPI for health cluster and donor reporting."
    - name: "multi_service_sessions"
      expr: COUNT(CASE WHEN (CASE WHEN service_anc_provided = TRUE THEN 1 ELSE 0 END + CASE WHEN service_immunization_provided = TRUE THEN 1 ELSE 0 END + CASE WHEN service_gbv_referral_provided = TRUE THEN 1 ELSE 0 END + CASE WHEN service_muac_screening_provided = TRUE THEN 1 ELSE 0 END + CASE WHEN service_pss_provided = TRUE THEN 1 ELSE 0 END) >= 3 THEN 1 END)
      comment: "Number of sessions delivering 3 or more service types. Integrated service delivery KPI — higher counts indicate more efficient, comprehensive outreach."
    - name: "avg_session_duration_minutes"
      expr: AVG(TIMESTAMPDIFF(MINUTE, session_start_time, session_end_time))
      comment: "Average session duration in minutes. Operational efficiency KPI for staffing and logistics planning of outreach activities."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`field_pdm_survey`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Post-distribution monitoring KPIs — tracks beneficiary satisfaction, adequacy of assistance, and accountability compliance to inform program quality and donor reporting decisions."
  source: "`vibe_ngo_v1`.`field`.`pdm_survey`"
  dimensions:
    - name: "pdm_survey_status"
      expr: pdm_survey_status
      comment: "Current status of the PDM survey (e.g., planned, in-progress, completed, approved) for pipeline tracking."
    - name: "methodology"
      expr: methodology
      comment: "Survey methodology (e.g., phone, face-to-face, KoBoToolbox) for methodological quality benchmarking."
    - name: "cluster_sector"
      expr: cluster_sector
      comment: "Humanitarian cluster sector for sector-level satisfaction and adequacy benchmarking."
    - name: "chs_compliance_rating"
      expr: chs_compliance_rating
      comment: "Core Humanitarian Standard compliance rating for accountability and quality assurance analysis."
    - name: "pdm_survey_date_month"
      expr: DATE_TRUNC('MONTH', pdm_survey_date)
      comment: "Month of PDM survey date for temporal trend analysis of post-distribution monitoring activity."
    - name: "protection_concerns_noted"
      expr: protection_concerns_noted
      comment: "Whether protection concerns were identified during the PDM, for protection-sensitive programming analysis."
    - name: "corrective_actions_required"
      expr: corrective_actions_required
      comment: "Whether corrective actions were required based on PDM findings, measuring program quality gaps."
    - name: "gender_disaggregation_available"
      expr: gender_disaggregation_available
      comment: "Whether gender-disaggregated data is available, measuring data quality for gender-sensitive analysis."
  measures:
    - name: "total_pdm_surveys"
      expr: COUNT(1)
      comment: "Total number of PDM surveys conducted. Baseline accountability metric for post-distribution monitoring coverage."
    - name: "avg_satisfaction_score"
      expr: AVG(CAST(satisfaction_score AS DOUBLE))
      comment: "Average beneficiary satisfaction score across PDM surveys. Primary AAP KPI — low scores trigger program design reviews and corrective action."
    - name: "avg_adequacy_score"
      expr: AVG(CAST(adequacy_score AS DOUBLE))
      comment: "Average adequacy score measuring whether distributed items met beneficiary needs. Core program quality KPI for donor and cluster reporting."
    - name: "avg_aap_score"
      expr: AVG(CAST(aap_score AS DOUBLE))
      comment: "Average Accountability to Affected Populations score. Strategic CHS compliance KPI — low scores indicate systemic accountability failures."
    - name: "avg_response_rate_pct"
      expr: AVG(CAST(response_rate_percent AS DOUBLE))
      comment: "Average survey response rate across PDM surveys. Data quality KPI — low response rates reduce statistical validity of findings."
    - name: "avg_utilization_rate_pct"
      expr: AVG(CAST(utilization_rate_percent AS DOUBLE))
      comment: "Average utilization rate of distributed items. Measures whether beneficiaries are actually using assistance — low rates indicate targeting or appropriateness issues."
    - name: "surveys_requiring_corrective_action"
      expr: COUNT(CASE WHEN corrective_actions_required = TRUE THEN 1 END)
      comment: "Number of PDM surveys identifying required corrective actions. Quality management KPI for program improvement pipeline."
    - name: "corrective_action_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN corrective_actions_required = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of PDM surveys requiring corrective action. Program quality KPI — high rates indicate systemic delivery issues requiring management intervention."
    - name: "surveys_with_protection_concerns"
      expr: COUNT(CASE WHEN protection_concerns_noted = TRUE THEN 1 END)
      comment: "Number of PDM surveys identifying protection concerns. Risk KPI triggering protection referral pathway and program design reviews."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`field_wash_intervention`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "WASH program KPIs — tracks expenditure efficiency, Sphere compliance, and service delivery quality to inform WASH cluster reporting and program scaling decisions."
  source: "`vibe_ngo_v1`.`field`.`wash_intervention`"
  dimensions:
    - name: "wash_intervention_type"
      expr: wash_intervention_type
      comment: "Type of WASH intervention (e.g., water supply, sanitation, hygiene promotion) for sector-level performance analysis."
    - name: "wash_intervention_status"
      expr: wash_intervention_status
      comment: "Current status of the intervention (e.g., planned, active, completed) for pipeline and completion tracking."
    - name: "start_date_month"
      expr: DATE_TRUNC('MONTH', start_date)
      comment: "Month of intervention start date for temporal trend analysis of WASH program activity."
    - name: "hygiene_promotion_conducted"
      expr: hygiene_promotion_conducted
      comment: "Whether hygiene promotion was conducted alongside the intervention, measuring integrated WASH delivery."
    - name: "gender_considerations"
      expr: gender_considerations
      comment: "Gender considerations applied in the intervention design, for gender-sensitive WASH analysis."
    - name: "disability_inclusion"
      expr: disability_inclusion
      comment: "Disability inclusion measures applied, for inclusive WASH service delivery analysis."
  measures:
    - name: "total_wash_interventions"
      expr: COUNT(1)
      comment: "Total number of WASH interventions. Baseline volume metric for WASH program portfolio management."
    - name: "total_actual_expenditure_usd"
      expr: SUM(CAST(actual_expenditure_usd AS DOUBLE))
      comment: "Total actual expenditure on WASH interventions in USD. Core financial KPI for budget burn and donor reporting."
    - name: "total_budget_allocated_usd"
      expr: SUM(CAST(budget_allocated_usd AS DOUBLE))
      comment: "Total budget allocated to WASH interventions in USD. Used alongside actual expenditure to compute utilization."
    - name: "budget_utilization_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(actual_expenditure_usd AS DOUBLE)) / NULLIF(SUM(CAST(budget_allocated_usd AS DOUBLE)), 0), 2)
      comment: "Percentage of WASH budget actually spent. Financial accountability KPI — low utilization signals absorption issues; over-utilization signals budget risk."
    - name: "avg_sphere_water_quantity_lpd"
      expr: AVG(CAST(sphere_water_quantity_lpd AS DOUBLE))
      comment: "Average water quantity per person per day (litres). Sphere standard compliance KPI — below 15 lpd triggers immediate program quality escalation."
    - name: "hygiene_promotion_coverage_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN hygiene_promotion_conducted = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of WASH interventions including hygiene promotion. Integrated WASH delivery KPI — low rates indicate gaps in behavior change programming."
    - name: "avg_expenditure_per_intervention_usd"
      expr: AVG(CAST(actual_expenditure_usd AS DOUBLE))
      comment: "Average actual expenditure per WASH intervention in USD. Cost efficiency benchmark for WASH program planning and donor negotiations."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`field_cluster_coordination`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Humanitarian cluster coordination KPIs — tracks NGO participation compliance, 3W reporting obligations, and financial commitments to inform cluster leadership and donor accountability decisions."
  source: "`vibe_ngo_v1`.`field`.`cluster_coordination`"
  dimensions:
    - name: "cluster_activation_status"
      expr: cluster_activation_status
      comment: "Current activation status of the cluster (e.g., active, standby, deactivated) for portfolio management."
    - name: "ngo_participation_status"
      expr: ngo_participation_status
      comment: "NGO participation status in the cluster for coordination compliance analysis."
    - name: "three_w_submission_compliance_status"
      expr: three_w_submission_compliance_status
      comment: "3W (Who, What, Where) submission compliance status for OCHA reporting accountability."
    - name: "cluster_name"
      expr: cluster_name
      comment: "Name of the humanitarian cluster for sector-level coordination analysis."
    - name: "meeting_frequency"
      expr: meeting_frequency
      comment: "Frequency of cluster coordination meetings for engagement intensity analysis."
    - name: "cluster_activation_date_month"
      expr: DATE_TRUNC('MONTH', cluster_activation_date)
      comment: "Month of cluster activation for temporal trend analysis of humanitarian response activation."
    - name: "sitrep_contribution_flag"
      expr: sitrep_contribution_flag
      comment: "Whether the NGO contributes to cluster situation reports, measuring information sharing compliance."
    - name: "three_w_reporting_obligation_flag"
      expr: three_w_reporting_obligation_flag
      comment: "Whether the NGO has a 3W reporting obligation, for compliance scope analysis."
  measures:
    - name: "total_cluster_participations"
      expr: COUNT(1)
      comment: "Total number of cluster coordination participations. Baseline metric for coordination portfolio breadth."
    - name: "total_hpc_commitment_amount"
      expr: SUM(CAST(hpc_commitment_amount AS DOUBLE))
      comment: "Total HPC (Humanitarian Programme Cycle) financial commitment amount. Strategic KPI for donor accountability and cluster burden-sharing analysis."
    - name: "avg_hpc_commitment_amount"
      expr: AVG(CAST(hpc_commitment_amount AS DOUBLE))
      comment: "Average HPC commitment amount per cluster participation. Benchmarks financial engagement level across clusters."
    - name: "three_w_compliance_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN three_w_submission_compliance_status = 'compliant' THEN 1 END) / NULLIF(COUNT(CASE WHEN three_w_reporting_obligation_flag = TRUE THEN 1 END), 0), 2)
      comment: "Percentage of obligated 3W submissions that are compliant. OCHA coordination compliance KPI — low rates risk exclusion from cluster coordination mechanisms."
    - name: "sitrep_contribution_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN sitrep_contribution_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of cluster participations with sitrep contributions. Information sharing compliance KPI for cluster coordination accountability."
    - name: "information_sharing_agreement_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN information_sharing_agreement_signed_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of cluster participations with signed information sharing agreements. Data governance compliance KPI for inter-agency coordination."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`field_deployment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Field deployment KPIs — tracks deployment pipeline, cost efficiency, and security compliance to inform workforce planning and operational risk management decisions."
  source: "`vibe_ngo_v1`.`field`.`field_deployment`"
  dimensions:
    - name: "field_deployment_status"
      expr: field_deployment_status
      comment: "Current status of the deployment (e.g., planned, active, completed, cancelled) for pipeline management."
    - name: "field_deployment_type"
      expr: field_deployment_type
      comment: "Type of deployment (e.g., emergency response, program support, assessment) for resource planning analysis."
    - name: "response_type"
      expr: response_type
      comment: "Response type classification for deployment purpose analysis."
    - name: "transportation_mode"
      expr: transportation_mode
      comment: "Mode of transportation used for deployment cost and logistics analysis."
    - name: "security_clearance_level"
      expr: security_clearance_level
      comment: "Security clearance level required for the deployment, for risk and compliance analysis."
    - name: "start_date_month"
      expr: DATE_TRUNC('MONTH', start_date)
      comment: "Month of planned deployment start date for temporal trend analysis of deployment pipeline."
    - name: "medical_clearance_required"
      expr: medical_clearance_required
      comment: "Whether medical clearance is required, for duty-of-care compliance tracking."
    - name: "gis_track_enabled"
      expr: gis_track_enabled
      comment: "Whether GIS tracking is enabled for the deployment, measuring field safety monitoring coverage."
  measures:
    - name: "total_deployments"
      expr: COUNT(1)
      comment: "Total number of field deployments. Baseline volume metric for workforce deployment portfolio management."
    - name: "total_cost_estimate"
      expr: SUM(CAST(cost_estimate AS DOUBLE))
      comment: "Total estimated cost of field deployments. Core financial planning KPI for budget allocation and donor reporting."
    - name: "avg_cost_per_deployment"
      expr: AVG(CAST(cost_estimate AS DOUBLE))
      comment: "Average estimated cost per deployment. Efficiency benchmark for deployment planning and cost optimization decisions."
    - name: "gis_tracking_coverage_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN gis_track_enabled = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of deployments with GIS tracking enabled. Field safety KPI — low rates indicate gaps in real-time staff location monitoring."
    - name: "avg_deployment_duration_days"
      expr: AVG(DATEDIFF(actual_end_date, actual_start_date))
      comment: "Average actual deployment duration in days. Workforce planning KPI for staffing rotation and operational tempo analysis."
    - name: "deployments_with_handover_notes"
      expr: COUNT(CASE WHEN handover_notes IS NOT NULL THEN 1 END)
      comment: "Number of deployments with handover notes completed. Knowledge management KPI — low rates indicate institutional knowledge loss risk."
    - name: "handover_completion_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN handover_notes IS NOT NULL THEN 1 END) / NULLIF(COUNT(CASE WHEN field_deployment_status = 'completed' THEN 1 END), 0), 2)
      comment: "Percentage of completed deployments with handover notes. Operational continuity KPI — low rates trigger knowledge management policy reviews."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`field_access_constraint`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Humanitarian access KPIs — tracks access constraint severity, escalation patterns, and beneficiary impact to inform access negotiation and program continuity decisions."
  source: "`vibe_ngo_v1`.`field`.`access_constraint`"
  dimensions:
    - name: "access_constraint_type"
      expr: access_constraint_type
      comment: "Type of access constraint (e.g., armed actor, administrative, physical) for root cause analysis."
    - name: "access_constraint_status"
      expr: access_constraint_status
      comment: "Current status of the constraint (e.g., active, resolved, escalated) for pipeline management."
    - name: "severity_level"
      expr: severity_level
      comment: "Severity classification of the access constraint for prioritization and escalation decisions."
    - name: "escalation_status"
      expr: escalation_status
      comment: "Escalation status of the constraint for management and donor notification tracking."
    - name: "admin_level_1"
      expr: admin_level_1
      comment: "First administrative level for geographic mapping of access constraints."
    - name: "start_date_month"
      expr: DATE_TRUNC('MONTH', start_date)
      comment: "Month of constraint start date for temporal trend analysis of access deterioration patterns."
    - name: "negotiation_required"
      expr: negotiation_required
      comment: "Whether access negotiation is required, for humanitarian access strategy planning."
    - name: "alternative_route_available"
      expr: alternative_route_available
      comment: "Whether an alternative route is available, measuring operational resilience to access constraints."
    - name: "donor_notification_required"
      expr: donor_notification_required
      comment: "Whether donor notification is required, for compliance and donor relationship management."
  measures:
    - name: "total_access_constraints"
      expr: COUNT(1)
      comment: "Total number of active and historical access constraints. Baseline metric for humanitarian access portfolio management."
    - name: "constraints_requiring_negotiation"
      expr: COUNT(CASE WHEN negotiation_required = TRUE THEN 1 END)
      comment: "Number of constraints requiring active access negotiation. Operational KPI for humanitarian access team workload and prioritization."
    - name: "negotiation_required_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN negotiation_required = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of access constraints requiring negotiation. Access environment KPI — high rates indicate deteriorating humanitarian space requiring senior management attention."
    - name: "constraints_with_alternative_route"
      expr: COUNT(CASE WHEN alternative_route_available = TRUE THEN 1 END)
      comment: "Number of constraints where an alternative route is available. Operational resilience KPI for program continuity planning."
    - name: "alternative_route_availability_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN alternative_route_available = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of access constraints with an available alternative route. Resilience KPI — low rates indicate high program disruption risk."
    - name: "escalated_constraints"
      expr: COUNT(CASE WHEN escalation_date IS NOT NULL THEN 1 END)
      comment: "Number of access constraints that have been escalated. Risk management KPI for senior leadership and donor notification tracking."
    - name: "donor_notification_pending"
      expr: COUNT(CASE WHEN donor_notification_required = TRUE AND donor_notification_date IS NULL THEN 1 END)
      comment: "Number of constraints requiring donor notification where notification has not yet been sent. Compliance risk KPI — outstanding notifications may breach grant agreement terms."
    - name: "avg_constraint_duration_days"
      expr: AVG(DATEDIFF(end_date, start_date))
      comment: "Average duration of access constraints in days. Operational impact KPI — longer durations indicate entrenched access issues requiring strategic intervention."
$$;