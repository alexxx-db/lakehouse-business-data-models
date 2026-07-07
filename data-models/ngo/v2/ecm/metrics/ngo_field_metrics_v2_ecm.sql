-- Metric views for domain: field | Business: Ngo | Version: 2 | Generated on: 2026-07-03 05:04:58

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`field_distribution_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Operational KPIs for field distribution events — covers budget utilisation, expenditure efficiency, and distribution coverage. Primary source of truth for field programme delivery performance tracked in systems such as SCOPE, KOBO Toolbox, and OCHA 3W reporting."
  source: "`vibe_ngo_v1`.`field`.`distribution_event`"
  dimensions:
    - name: "distribution_country"
      expr: admin_level_1
      comment: "Administrative level 1 (e.g. governorate/province) where the distribution event took place — used to slice delivery KPIs by geography."
    - name: "distribution_modality"
      expr: distribution_modality
      comment: "Modality of distribution (e.g. in-kind, cash, voucher) — critical for donor reporting and programme design decisions."
    - name: "distribution_type"
      expr: distribution_type
      comment: "Type of distribution (e.g. emergency, regular, PDM follow-up) — used to segment operational vs emergency delivery."
    - name: "distribution_status"
      expr: distribution_status
      comment: "Current status of the distribution event (e.g. planned, completed, cancelled) — used to filter pipeline vs actuals."
    - name: "cva_transfer_modality"
      expr: cva_transfer_modality
      comment: "Cash and voucher assistance transfer modality (e.g. mobile money, hawala) — required for CVA programme analysis."
    - name: "scheduled_date_month"
      expr: DATE_TRUNC('MONTH', scheduled_date)
      comment: "Month of scheduled distribution — enables trend analysis of distribution pipeline over time."
    - name: "incident_reported"
      expr: incident_reported_flag
      comment: "Whether a security or operational incident was reported during this distribution event — used to flag high-risk events."
    - name: "pdm_scheduled"
      expr: pdm_scheduled_flag
      comment: "Whether a post-distribution monitoring survey was scheduled — used to track accountability to affected populations (AAP) compliance."
  measures:
    - name: "total_distribution_events"
      expr: COUNT(1)
      comment: "Total number of distribution events — baseline volume KPI for field delivery throughput."
    - name: "total_actual_expenditure_usd"
      expr: SUM(CAST(actual_expenditure_amount AS DOUBLE))
      comment: "Total actual expenditure across all distribution events in USD — core financial accountability metric for donor reporting."
    - name: "total_budget_allocated_usd"
      expr: SUM(CAST(budget_allocated_amount AS DOUBLE))
      comment: "Total budget allocated to distribution events — used as denominator for budget utilisation rate."
    - name: "budget_utilisation_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(actual_expenditure_amount AS DOUBLE)) / NULLIF(SUM(CAST(budget_allocated_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of allocated budget actually spent on distributions — key efficiency KPI; low rates signal under-delivery, high rates signal over-run risk."
    - name: "avg_expenditure_per_event_usd"
      expr: ROUND(AVG(CAST(actual_expenditure_amount AS DOUBLE)), 2)
      comment: "Average actual expenditure per distribution event — used to benchmark cost efficiency across sites and modalities."
    - name: "incident_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN incident_reported_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of distribution events with a reported incident — security and operational risk KPI; triggers investigation when elevated."
    - name: "pdm_coverage_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN pdm_scheduled_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of distribution events with a PDM survey scheduled — accountability to affected populations (AAP) compliance indicator required by CHS and most institutional donors."
    - name: "completed_events_count"
      expr: SUM(CASE WHEN distribution_status = 'completed' THEN 1 ELSE 0 END)
      comment: "Count of distribution events with completed status — used to track delivery against plan."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`field_distribution_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Line-level distribution KPIs tracking commodity quantities, values, and quality outcomes per distribution line. Supports supply chain accountability, donor earmark tracking, and IATI transaction reporting. Aligns with SCOPE and KOBO Toolbox data flows."
  source: "`vibe_ngo_v1`.`field`.`field_distribution_line`"
  dimensions:
    - name: "item_category"
      expr: item_category
      comment: "Category of distributed item (e.g. food, NFI, WASH) — primary dimension for sector-level delivery analysis."
    - name: "cluster_sector"
      expr: cluster_sector
      comment: "Humanitarian cluster or sector the distribution line belongs to — required for OCHA 3W and cluster reporting."
    - name: "distribution_method"
      expr: distribution_method
      comment: "Method used for distribution (e.g. direct, partner-led, mobile) — used to assess delivery channel efficiency."
    - name: "distribution_status"
      expr: distribution_status
      comment: "Status of the distribution line (e.g. delivered, pending, rejected) — used to filter actuals vs pipeline."
    - name: "donor_earmark"
      expr: donor_earmark
      comment: "Donor earmark code restricting use of funds/commodities — critical for donor compliance and financial reporting."
    - name: "cva_transfer_modality"
      expr: cva_transfer_modality
      comment: "Cash and voucher assistance transfer modality for this line — used in CVA programme analysis."
    - name: "quality_check_status"
      expr: quality_check_status
      comment: "Quality check outcome for the distribution line — used to monitor commodity quality compliance."
    - name: "delivery_confirmation_month"
      expr: DATE_TRUNC('MONTH', delivery_confirmation_date)
      comment: "Month of delivery confirmation — enables trend analysis of commodity delivery timelines."
    - name: "substitution_flag"
      expr: substitution_flag
      comment: "Whether a commodity substitution occurred — used to track supply chain disruptions and donor compliance risks."
  measures:
    - name: "total_distribution_lines"
      expr: COUNT(1)
      comment: "Total number of distribution lines — baseline volume metric for distribution pipeline depth."
    - name: "total_planned_quantity"
      expr: SUM(CAST(planned_quantity AS DOUBLE))
      comment: "Total planned quantity of commodities across all distribution lines — used as denominator for delivery rate calculations."
    - name: "total_actual_quantity_distributed"
      expr: SUM(CAST(actual_quantity_distributed AS DOUBLE))
      comment: "Total actual quantity of commodities distributed — primary delivery output KPI for supply chain and programme reporting."
    - name: "delivery_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(actual_quantity_distributed AS DOUBLE)) / NULLIF(SUM(CAST(planned_quantity AS DOUBLE)), 0), 2)
      comment: "Percentage of planned commodity quantity actually delivered — core supply chain performance KPI; low rates trigger supply chain investigation."
    - name: "total_distribution_value_usd"
      expr: SUM(CAST(total_value AS DOUBLE))
      comment: "Total monetary value of distributed commodities in USD — key financial accountability metric for donor reporting and IATI publication."
    - name: "avg_unit_value_usd"
      expr: ROUND(AVG(CAST(unit_value AS DOUBLE)), 2)
      comment: "Average unit value of distributed items — used to benchmark commodity cost efficiency across procurement cycles."
    - name: "total_variance_quantity"
      expr: SUM(CAST(variance_quantity AS DOUBLE))
      comment: "Total quantity variance (planned minus actual) across distribution lines — supply chain loss and accountability KPI; large variances trigger audit."
    - name: "substitution_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN substitution_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of distribution lines where a commodity substitution occurred — supply chain resilience and donor compliance risk indicator."
    - name: "quality_pass_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN quality_check_status = 'passed' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of distribution lines passing quality checks — commodity quality assurance KPI; low rates trigger procurement review."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`field_assessment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Field assessment quality and coverage KPIs — tracks assessment throughput, data quality, beneficiary satisfaction, and protection concern rates. Supports MEL, programme design, and donor accountability. Aligns with KOBO Toolbox, ODK, and REACH/ACAPS assessment frameworks."
  source: "`vibe_ngo_v1`.`field`.`assessment`"
  dimensions:
    - name: "assessment_type"
      expr: assessment_type
      comment: "Type of assessment (e.g. needs assessment, PDM, baseline, endline) — primary dimension for assessment portfolio analysis."
    - name: "assessment_status"
      expr: assessment_status
      comment: "Current status of the assessment (e.g. planned, in-progress, completed) — used to track assessment pipeline."
    - name: "geographic_scope"
      expr: geographic_scope
      comment: "Geographic scope of the assessment (e.g. national, sub-national, site-level) — used to segment coverage analysis."
    - name: "methodology"
      expr: methodology
      comment: "Data collection methodology (e.g. KII, FGD, household survey) — used to assess methodological quality distribution."
    - name: "assessment_date_month"
      expr: DATE_TRUNC('MONTH', assessment_date)
      comment: "Month of assessment — enables trend analysis of assessment activity over time."
    - name: "protection_concerns_noted"
      expr: protection_concerns_noted
      comment: "Whether protection concerns were identified during the assessment — used to flag assessments requiring follow-up referral."
    - name: "mel_indicator_linked"
      expr: mel_indicator_linked
      comment: "Whether the assessment is linked to a MEL indicator — used to track evidence base for indicator reporting."
    - name: "donor_visibility_flag"
      expr: donor_visibility_flag
      comment: "Whether the assessment is visible to donors — used to manage donor reporting obligations."
  measures:
    - name: "total_assessments"
      expr: COUNT(1)
      comment: "Total number of assessments conducted — baseline volume KPI for field evidence generation."
    - name: "avg_data_quality_score"
      expr: ROUND(AVG(CAST(data_quality_score AS DOUBLE)), 2)
      comment: "Average data quality score across assessments — key MEL quality indicator; low scores trigger data quality review and retraining."
    - name: "avg_beneficiary_satisfaction_score"
      expr: ROUND(AVG(CAST(beneficiary_satisfaction_score AS DOUBLE)), 2)
      comment: "Average beneficiary satisfaction score — CHS Core Commitment 5 indicator; drives programme adaptation decisions."
    - name: "avg_adequacy_score"
      expr: ROUND(AVG(CAST(adequacy_score AS DOUBLE)), 2)
      comment: "Average adequacy score across assessments — measures whether programme response meets identified needs; low scores trigger programme redesign."
    - name: "protection_concern_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN protection_concerns_noted = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of assessments identifying protection concerns — protection mainstreaming KPI; high rates trigger referral pathway activation and programme adaptation."
    - name: "mel_linkage_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN mel_indicator_linked = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of assessments linked to a MEL indicator — evidence quality KPI; low rates indicate gaps in results framework coverage."
    - name: "completed_assessments_count"
      expr: SUM(CASE WHEN assessment_status = 'completed' THEN 1 ELSE 0 END)
      comment: "Count of completed assessments — used to track delivery against assessment plan and donor commitments."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`field_pdm_survey`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Post-distribution monitoring (PDM) survey KPIs — measures beneficiary satisfaction, utilisation rates, protection concerns, and CHS compliance. PDM is a mandatory accountability mechanism for most institutional donors (USAID, ECHO, FCDO). Aligns with KOBO Toolbox and ODK data collection."
  source: "`vibe_ngo_v1`.`field`.`pdm_survey`"
  dimensions:
    - name: "survey_status"
      expr: survey_status
      comment: "Current status of the PDM survey (e.g. planned, in-progress, completed, approved) — used to filter actuals vs pipeline."
    - name: "cluster_sector"
      expr: cluster_sector
      comment: "Humanitarian cluster or sector the PDM covers — used to segment accountability metrics by sector."
    - name: "chs_compliance_rating"
      expr: chs_compliance_rating
      comment: "Core Humanitarian Standard compliance rating from the PDM — key accountability KPI for CHS self-assessment and donor reporting."
    - name: "sampling_method"
      expr: sampling_method
      comment: "Sampling methodology used (e.g. random, purposive, systematic) — used to assess methodological rigour of PDM findings."
    - name: "survey_date_month"
      expr: DATE_TRUNC('MONTH', survey_date)
      comment: "Month of PDM survey — enables trend analysis of accountability activities over time."
    - name: "protection_concerns_noted"
      expr: protection_concerns_noted
      comment: "Whether protection concerns were identified in the PDM — triggers referral pathway and programme adaptation."
    - name: "corrective_actions_required"
      expr: corrective_actions_required
      comment: "Whether corrective actions were required based on PDM findings — used to track programme quality improvement actions."
    - name: "gender_disaggregation_available"
      expr: gender_disaggregation_available
      comment: "Whether gender-disaggregated data is available in the PDM — used to track gender-sensitive data collection compliance."
  measures:
    - name: "total_pdm_surveys"
      expr: COUNT(1)
      comment: "Total number of PDM surveys conducted — baseline accountability volume KPI."
    - name: "avg_satisfaction_score"
      expr: ROUND(AVG(CAST(satisfaction_score AS DOUBLE)), 2)
      comment: "Average beneficiary satisfaction score from PDM surveys — primary CHS Core Commitment 4 and 5 indicator; drives programme adaptation."
    - name: "avg_adequacy_score"
      expr: ROUND(AVG(CAST(adequacy_score AS DOUBLE)), 2)
      comment: "Average adequacy score from PDM surveys — measures whether distributed items meet beneficiary needs; key donor reporting metric."
    - name: "avg_aap_score"
      expr: ROUND(AVG(CAST(aap_score AS DOUBLE)), 2)
      comment: "Average accountability to affected populations (AAP) score — composite CHS compliance indicator used in donor audits and CHS self-assessments."
    - name: "avg_response_rate_pct"
      expr: ROUND(AVG(CAST(response_rate_percent AS DOUBLE)), 2)
      comment: "Average survey response rate — data quality and representativeness indicator; low rates trigger sampling methodology review."
    - name: "protection_concern_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN protection_concerns_noted = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of PDM surveys identifying protection concerns — protection mainstreaming KPI; high rates trigger referral pathway activation."
    - name: "corrective_action_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN corrective_actions_required = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of PDM surveys requiring corrective actions — programme quality KPI; high rates indicate systemic delivery problems requiring management intervention."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`field_wash_intervention`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "WASH (Water, Sanitation and Hygiene) intervention KPIs — tracks Sphere standard compliance, budget utilisation, and hygiene promotion coverage. Aligns with WASH cluster reporting, OCHA 3W, and DHIS2 WASH indicators. sphere_latrine_coverage_ratio is correctly typed as DECIMAL per VREQ-054."
  source: "`vibe_ngo_v1`.`field`.`wash_intervention`"
  dimensions:
    - name: "intervention_type"
      expr: intervention_type
      comment: "Type of WASH intervention (e.g. water supply, sanitation, hygiene promotion) — primary dimension for WASH portfolio analysis."
    - name: "intervention_status"
      expr: intervention_status
      comment: "Current status of the WASH intervention (e.g. planned, active, completed) — used to filter pipeline vs actuals."
    - name: "hygiene_promotion_conducted"
      expr: hygiene_promotion_conducted
      comment: "Whether hygiene promotion activities were conducted alongside the WASH intervention — Sphere standard compliance indicator."
    - name: "sphere_compliant_flag"
      expr: CASE WHEN sphere_latrine_coverage_ratio >= 0.05 AND sphere_water_quantity_lpd >= 15.0 THEN TRUE ELSE FALSE END
      comment: "Derived flag indicating whether the intervention meets minimum Sphere standards (1 latrine per 20 people = 0.05 ratio; 15 litres per person per day) — key humanitarian quality standard KPI."
    - name: "start_date_month"
      expr: DATE_TRUNC('MONTH', start_date)
      comment: "Month the WASH intervention started — enables trend analysis of WASH programme delivery over time."
    - name: "ocha_wash_cluster_code"
      expr: ocha_wash_cluster_code
      comment: "OCHA WASH cluster code — used for cluster reporting and 3W submissions."
  measures:
    - name: "total_wash_interventions"
      expr: COUNT(1)
      comment: "Total number of WASH interventions — baseline volume KPI for WASH programme delivery."
    - name: "total_actual_expenditure_usd"
      expr: SUM(CAST(actual_expenditure_usd AS DOUBLE))
      comment: "Total actual expenditure on WASH interventions in USD — core financial accountability metric for WASH cluster and donor reporting."
    - name: "total_budget_allocated_usd"
      expr: SUM(CAST(budget_allocated_usd AS DOUBLE))
      comment: "Total budget allocated to WASH interventions — used as denominator for budget utilisation rate."
    - name: "budget_utilisation_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(actual_expenditure_usd AS DOUBLE)) / NULLIF(SUM(CAST(budget_allocated_usd AS DOUBLE)), 0), 2)
      comment: "Percentage of WASH budget actually spent — financial efficiency KPI; low rates signal under-delivery, high rates signal over-run risk."
    - name: "avg_sphere_latrine_coverage_ratio"
      expr: ROUND(AVG(CAST(sphere_latrine_coverage_ratio AS DOUBLE)), 4)
      comment: "Average Sphere latrine coverage ratio (latrines per person) across WASH interventions — Sphere standard compliance KPI; values below 0.05 (1:20) indicate non-compliance requiring immediate action. Correctly typed as DECIMAL per VREQ-054."
    - name: "avg_sphere_water_quantity_lpd"
      expr: ROUND(AVG(CAST(sphere_water_quantity_lpd AS DOUBLE)), 2)
      comment: "Average litres of water provided per person per day — Sphere minimum standard is 15 lpd; values below trigger emergency response escalation."
    - name: "sphere_compliance_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN sphere_latrine_coverage_ratio >= 0.05 AND sphere_water_quantity_lpd >= 15.0 THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of WASH interventions meeting both Sphere minimum standards for water quantity and latrine coverage — primary WASH quality KPI for donor reporting and cluster accountability."
    - name: "hygiene_promotion_coverage_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN hygiene_promotion_conducted = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of WASH interventions that included hygiene promotion — Sphere and WASH cluster standard; low rates indicate incomplete WASH package delivery."
    - name: "total_community_contribution_usd"
      expr: SUM(CAST(community_contribution AS DOUBLE))
      comment: "Total community financial contribution to WASH interventions — sustainability and community ownership indicator; used in cost-share reporting to donors."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`field_mobile_health_outreach`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Mobile health outreach session KPIs — tracks service delivery coverage, session throughput, and referral rates. Aligns with DHIS2 health reporting, health cluster 3W, and WHO/UNICEF health indicator frameworks. Supports health programme performance management."
  source: "`vibe_ngo_v1`.`field`.`mobile_health_outreach`"
  dimensions:
    - name: "session_status"
      expr: session_status
      comment: "Status of the mobile health outreach session (e.g. planned, completed, cancelled) — used to filter actuals vs pipeline."
    - name: "admin_level_1"
      expr: admin_level_1
      comment: "Administrative level 1 (e.g. governorate/province) of the outreach session — geographic dimension for health coverage analysis."
    - name: "session_date_month"
      expr: DATE_TRUNC('MONTH', session_date)
      comment: "Month of the outreach session — enables trend analysis of health service delivery over time."
    - name: "service_anc_provided"
      expr: service_anc_provided
      comment: "Whether antenatal care (ANC) was provided — used to track maternal health service coverage."
    - name: "service_immunization_provided"
      expr: service_immunization_provided
      comment: "Whether immunization services were provided — used to track vaccination coverage rates."
    - name: "service_muac_screening_provided"
      expr: service_muac_screening_provided
      comment: "Whether MUAC (mid-upper arm circumference) malnutrition screening was provided — key nutrition indicator for health cluster reporting."
    - name: "service_gbv_referral_provided"
      expr: service_gbv_referral_provided
      comment: "Whether GBV referral services were provided — protection mainstreaming indicator for health outreach."
    - name: "health_cluster_reported"
      expr: health_cluster_reported
      comment: "Whether the session was reported to the health cluster — used to track 3W reporting compliance."
    - name: "sphere_compliant"
      expr: sphere_compliant
      comment: "Whether the session met Sphere minimum standards — quality compliance dimension for health outreach."
  measures:
    - name: "total_outreach_sessions"
      expr: COUNT(1)
      comment: "Total number of mobile health outreach sessions — baseline volume KPI for health programme delivery."
    - name: "anc_service_coverage_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN service_anc_provided = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of outreach sessions providing ANC services — maternal health coverage KPI; low rates trigger health programme gap analysis."
    - name: "immunization_coverage_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN service_immunization_provided = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of outreach sessions providing immunization — vaccination coverage KPI for health cluster and DHIS2 reporting."
    - name: "muac_screening_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN service_muac_screening_provided = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of outreach sessions conducting MUAC malnutrition screening — nutrition surveillance KPI; low rates indicate gaps in integrated health service delivery."
    - name: "gbv_referral_integration_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN service_gbv_referral_provided = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of outreach sessions integrating GBV referral services — protection mainstreaming KPI; low rates indicate gaps in integrated service delivery."
    - name: "health_cluster_reporting_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN health_cluster_reported = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of outreach sessions reported to the health cluster — 3W reporting compliance KPI; low rates risk exclusion from HRP progress tracking."
    - name: "sphere_compliance_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN sphere_compliant = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of outreach sessions meeting Sphere minimum standards — health quality KPI for donor reporting and cluster accountability."
    - name: "completed_sessions_count"
      expr: SUM(CASE WHEN session_status = 'completed' THEN 1 ELSE 0 END)
      comment: "Count of completed outreach sessions — used to track delivery against health programme plan."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`field_security_incident`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Field security incident KPIs — tracks incident frequency, severity, financial impact, and reporting compliance. Critical for duty of care, INSO/UNDSS reporting obligations, and donor security reporting. Supports security risk management decisions."
  source: "`vibe_ngo_v1`.`field`.`security_incident`"
  dimensions:
    - name: "incident_type"
      expr: incident_type
      comment: "Type of security incident (e.g. armed robbery, carjacking, IED, harassment) — primary dimension for threat pattern analysis."
    - name: "incident_severity"
      expr: incident_severity
      comment: "Severity level of the incident (e.g. low, medium, high, critical) — used to prioritise response and escalation."
    - name: "incident_status"
      expr: incident_status
      comment: "Current status of the incident (e.g. open, under investigation, closed) — used to track incident management pipeline."
    - name: "admin_level_1"
      expr: admin_level_1
      comment: "Administrative level 1 where the incident occurred — geographic dimension for security risk mapping."
    - name: "incident_date_month"
      expr: DATE_TRUNC('MONTH', incident_date)
      comment: "Month of the security incident — enables trend analysis of security environment over time."
    - name: "reported_to_inso"
      expr: reported_to_inso
      comment: "Whether the incident was reported to INSO (International NGO Safety Organisation) — reporting compliance dimension."
    - name: "reported_to_undss"
      expr: reported_to_undss
      comment: "Whether the incident was reported to UNDSS — UN security reporting compliance dimension."
    - name: "investigation_status"
      expr: investigation_status
      comment: "Status of the incident investigation — used to track accountability and corrective action follow-through."
  measures:
    - name: "total_security_incidents"
      expr: COUNT(1)
      comment: "Total number of security incidents — baseline security environment KPI; trend increases trigger security protocol review."
    - name: "total_estimated_asset_loss_usd"
      expr: SUM(CAST(estimated_asset_loss_usd AS DOUBLE))
      comment: "Total estimated financial value of assets lost in security incidents — financial risk KPI for insurance claims and donor reporting."
    - name: "avg_asset_loss_per_incident_usd"
      expr: ROUND(AVG(CAST(estimated_asset_loss_usd AS DOUBLE)), 2)
      comment: "Average asset loss per security incident — used to benchmark incident financial impact and prioritise security investment."
    - name: "inso_reporting_compliance_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN reported_to_inso = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of incidents reported to INSO — security reporting compliance KPI; low rates indicate duty of care gaps and risk of INSO membership suspension."
    - name: "undss_reporting_compliance_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN reported_to_undss = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of incidents reported to UNDSS — UN security reporting compliance KPI required for UN premises access and joint security protocols."
    - name: "high_severity_incident_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN incident_severity IN ('high', 'critical') THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of incidents classified as high or critical severity — security risk escalation KPI; high rates trigger access constraint review and potential programme suspension."
    - name: "open_investigation_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN investigation_status NOT IN ('closed', 'completed') THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of incidents with open or incomplete investigations — accountability and corrective action KPI; high rates indicate investigation backlog requiring management attention."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`field_emergency`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Emergency response KPIs — tracks funding gaps, population reach, response activation, and humanitarian coordination. Aligns with OCHA HRP/Flash Appeal tracking, CERF allocation monitoring, and UN OCHA Financial Tracking Service (FTS). Critical for strategic resource allocation decisions."
  source: "`vibe_ngo_v1`.`field`.`emergency`"
  dimensions:
    - name: "emergency_type"
      expr: emergency_type
      comment: "Type of emergency (e.g. conflict, natural disaster, disease outbreak) — primary dimension for emergency portfolio analysis."
    - name: "emergency_status"
      expr: emergency_status
      comment: "Current status of the emergency (e.g. active, monitoring, closed) — used to filter active vs historical emergencies."
    - name: "severity_level"
      expr: severity_level
      comment: "Severity level of the emergency — used to prioritise resource allocation and escalation decisions."
    - name: "disaster_category"
      expr: disaster_category
      comment: "Disaster category (e.g. sudden onset, slow onset, protracted) — used to segment emergency response portfolio."
    - name: "declaration_date_month"
      expr: DATE_TRUNC('MONTH', declaration_date)
      comment: "Month of emergency declaration — enables trend analysis of emergency activations over time."
    - name: "hrp_issued"
      expr: hrp_issued
      comment: "Whether a Humanitarian Response Plan was issued — indicates scale and coordination level of the emergency response."
    - name: "cerf_allocation_received"
      expr: cerf_allocation_received
      comment: "Whether CERF (Central Emergency Response Fund) allocation was received — indicates access to UN emergency funding."
    - name: "flash_appeal_issued"
      expr: flash_appeal_issued
      comment: "Whether a Flash Appeal was issued — indicates rapid-onset emergency requiring immediate international funding mobilisation."
    - name: "is_active"
      expr: is_active
      comment: "Whether the emergency is currently active — used to filter current operational context."
  measures:
    - name: "total_emergencies"
      expr: COUNT(1)
      comment: "Total number of emergencies — baseline portfolio KPI for emergency response capacity planning."
    - name: "total_funding_received_usd"
      expr: SUM(CAST(funding_received_usd AS DOUBLE))
      comment: "Total funding received across emergencies in USD — primary financial resource mobilisation KPI for executive reporting."
    - name: "total_funding_requirement_usd"
      expr: SUM(CAST(funding_requirement_usd AS DOUBLE))
      comment: "Total funding requirement across emergencies — used as denominator for funding coverage rate calculation."
    - name: "funding_coverage_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(funding_received_usd AS DOUBLE)) / NULLIF(SUM(CAST(funding_requirement_usd AS DOUBLE)), 0), 2)
      comment: "Percentage of emergency funding requirements covered by received funding — critical resource gap KPI; low rates trigger emergency fundraising and donor engagement decisions."
    - name: "total_affected_population"
      expr: SUM(CAST(affected_population_count AS DOUBLE))
      comment: "Total number of people affected across all emergencies — scale of humanitarian need KPI for strategic resource allocation."
    - name: "total_displaced_population"
      expr: SUM(CAST(displaced_population_count AS DOUBLE))
      comment: "Total number of displaced people across all emergencies — displacement crisis scale KPI for protection and shelter programme planning."
    - name: "total_targeted_beneficiaries"
      expr: SUM(CAST(targeted_beneficiaries_count AS DOUBLE))
      comment: "Total number of beneficiaries targeted across all emergencies — programme reach planning KPI."
    - name: "hrp_coverage_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN hrp_issued = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of emergencies with an HRP issued — humanitarian coordination quality KPI; low rates indicate gaps in strategic response planning."
    - name: "cerf_access_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN cerf_allocation_received = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of emergencies receiving CERF allocation — UN emergency funding access KPI; used to assess ability to mobilise rapid funding."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`field_access_constraint`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Humanitarian access constraint KPIs — tracks access impediments, severity distribution, negotiation requirements, and donor notification compliance. Critical for programme continuity risk management and OCHA access monitoring. Aligns with INSO access tracking and HPC access monitoring frameworks."
  source: "`vibe_ngo_v1`.`field`.`access_constraint`"
  dimensions:
    - name: "constraint_type"
      expr: constraint_type
      comment: "Type of access constraint (e.g. armed actor, administrative, physical, weather) — primary dimension for access impediment analysis."
    - name: "constraint_status"
      expr: constraint_status
      comment: "Current status of the access constraint (e.g. active, resolved, escalated) — used to filter current vs historical constraints."
    - name: "severity_level"
      expr: severity_level
      comment: "Severity level of the access constraint — used to prioritise negotiation and mitigation resources."
    - name: "admin_level_1"
      expr: admin_level_1
      comment: "Administrative level 1 where the constraint applies — geographic dimension for access risk mapping."
    - name: "constraint_start_month"
      expr: DATE_TRUNC('MONTH', constraint_start_date)
      comment: "Month the access constraint started — enables trend analysis of access environment deterioration over time."
    - name: "negotiation_required"
      expr: negotiation_required
      comment: "Whether humanitarian access negotiation is required — used to track negotiation workload and prioritise access team resources."
    - name: "donor_notification_required"
      expr: donor_notification_required
      comment: "Whether donor notification is required for this constraint — used to track donor reporting obligations triggered by access constraints."
    - name: "alternative_route_available"
      expr: alternative_route_available
      comment: "Whether an alternative route is available — used to assess programme continuity risk when primary access is blocked."
  measures:
    - name: "total_access_constraints"
      expr: COUNT(1)
      comment: "Total number of active and historical access constraints — baseline access environment KPI; trend increases trigger programme continuity review."
    - name: "active_constraints_count"
      expr: SUM(CASE WHEN constraint_status = 'active' THEN 1 ELSE 0 END)
      comment: "Count of currently active access constraints — real-time operational risk KPI for field management decisions."
    - name: "high_severity_constraint_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN severity_level IN ('high', 'critical') THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of access constraints classified as high or critical severity — access risk escalation KPI; high rates trigger programme suspension review."
    - name: "negotiation_required_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN negotiation_required = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of access constraints requiring humanitarian negotiation — access team workload and capacity planning KPI."
    - name: "donor_notification_compliance_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN donor_notification_required = TRUE AND donor_notification_date IS NOT NULL THEN 1 ELSE 0 END) / NULLIF(SUM(CASE WHEN donor_notification_required = TRUE THEN 1 ELSE 0 END), 0), 2)
      comment: "Percentage of constraints requiring donor notification where notification was actually sent — donor compliance KPI; low rates risk grant non-compliance findings."
    - name: "alternative_route_availability_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN alternative_route_available = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of access constraints where an alternative route is available — programme continuity resilience KPI; low rates indicate high programme disruption risk."
    - name: "sitrep_inclusion_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN sitrep_included = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of access constraints included in situation reports — OCHA and donor reporting transparency KPI."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`field_cluster_coordination`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Humanitarian cluster coordination KPIs — tracks NGO participation compliance, 3W reporting obligations, and HPC financial commitments. Aligns with OCHA cluster coordination framework, HPC commitments, and inter-agency coordination reporting requirements."
  source: "`vibe_ngo_v1`.`field`.`cluster_coordination`"
  dimensions:
    - name: "cluster_name"
      expr: cluster_name
      comment: "Name of the humanitarian cluster (e.g. Food Security, WASH, Health, Protection) — primary dimension for cluster portfolio analysis."
    - name: "cluster_activation_status"
      expr: cluster_activation_status
      comment: "Activation status of the cluster (e.g. active, standby, deactivated) — used to filter active coordination commitments."
    - name: "ngo_participation_status"
      expr: ngo_participation_status
      comment: "NGO participation status in the cluster (e.g. active member, observer, co-lead) — used to track coordination engagement level."
    - name: "three_w_submission_compliance_status"
      expr: three_w_submission_compliance_status
      comment: "Compliance status for 3W (Who does What Where) reporting — OCHA reporting obligation compliance dimension."
    - name: "cluster_activation_month"
      expr: DATE_TRUNC('MONTH', cluster_activation_date)
      comment: "Month of cluster activation — enables trend analysis of coordination engagement over time."
    - name: "information_sharing_agreement_signed"
      expr: information_sharing_agreement_signed_flag
      comment: "Whether an information sharing agreement is signed — inter-agency data governance compliance indicator."
    - name: "three_w_reporting_obligation"
      expr: three_w_reporting_obligation_flag
      comment: "Whether the NGO has a 3W reporting obligation for this cluster — used to identify clusters requiring compliance monitoring."
  measures:
    - name: "total_cluster_memberships"
      expr: COUNT(1)
      comment: "Total number of cluster coordination memberships — baseline coordination portfolio KPI."
    - name: "total_hpc_commitment_amount_usd"
      expr: SUM(CAST(hpc_commitment_amount AS DOUBLE))
      comment: "Total HPC (Humanitarian Programme Cycle) financial commitment amount in USD — strategic resource commitment KPI for inter-agency accountability."
    - name: "avg_hpc_commitment_per_cluster_usd"
      expr: ROUND(AVG(CAST(hpc_commitment_amount AS DOUBLE)), 2)
      comment: "Average HPC commitment per cluster — used to benchmark resource allocation across humanitarian clusters."
    - name: "three_w_compliance_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN three_w_submission_compliance_status = 'compliant' THEN 1 ELSE 0 END) / NULLIF(SUM(CASE WHEN three_w_reporting_obligation_flag = TRUE THEN 1 ELSE 0 END), 0), 2)
      comment: "Percentage of clusters with 3W reporting obligations where submissions are compliant — OCHA reporting compliance KPI; low rates risk exclusion from HRP and cluster coordination."
    - name: "information_sharing_agreement_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN information_sharing_agreement_signed_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of cluster memberships with a signed information sharing agreement — inter-agency data governance compliance KPI."
    - name: "active_cluster_participation_count"
      expr: SUM(CASE WHEN ngo_participation_status = 'active member' THEN 1 ELSE 0 END)
      comment: "Count of clusters where the NGO is an active member — coordination engagement breadth KPI for strategic partnership reporting."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`field_sitrep`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Situation report (SitRep) KPIs — tracks reporting timeliness, funding gap visibility, HRP progress, and donor/OCHA submission compliance. SitReps are the primary operational communication tool for donors, OCHA, and cluster leads. Aligns with OCHA ReliefWeb, donor reporting portals, and HPC monitoring."
  source: "`vibe_ngo_v1`.`field`.`sitrep`"
  dimensions:
    - name: "report_status"
      expr: report_status
      comment: "Current status of the SitRep (e.g. draft, submitted, approved, published) — used to track reporting pipeline."
    - name: "reporting_frequency"
      expr: reporting_frequency
      comment: "Frequency of SitRep reporting (e.g. weekly, bi-weekly, monthly) — used to segment reporting cadence analysis."
    - name: "geographic_scope"
      expr: geographic_scope
      comment: "Geographic scope of the SitRep (e.g. national, regional, site-level) — used to segment reporting coverage."
    - name: "reporting_period_month"
      expr: DATE_TRUNC('MONTH', reporting_period_start_date)
      comment: "Month of the reporting period — enables trend analysis of operational reporting over time."
    - name: "donor_submission_required"
      expr: donor_submission_required
      comment: "Whether the SitRep must be submitted to a donor — used to identify donor-facing reporting obligations."
    - name: "ocha_submission_required"
      expr: ocha_submission_required
      comment: "Whether the SitRep must be submitted to OCHA — used to track UN coordination reporting obligations."
    - name: "cluster_lead_agency"
      expr: cluster_lead_agency
      comment: "Lead agency for the cluster covered by the SitRep — used to segment reporting by coordination body."
  measures:
    - name: "total_sitreps"
      expr: COUNT(1)
      comment: "Total number of SitReps produced — baseline reporting volume KPI."
    - name: "total_funding_gap_usd"
      expr: SUM(CAST(funding_gap_usd AS DOUBLE))
      comment: "Total funding gap reported across all SitReps in USD — critical resource mobilisation KPI; large gaps trigger emergency donor engagement."
    - name: "avg_hrp_progress_pct"
      expr: ROUND(AVG(CAST(hrp_progress_percentage AS DOUBLE)), 2)
      comment: "Average HRP (Humanitarian Response Plan) progress percentage across SitReps — strategic programme delivery KPI for OCHA and donor accountability."
    - name: "donor_submission_compliance_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN donor_submission_required = TRUE AND report_status = 'submitted' THEN 1 ELSE 0 END) / NULLIF(SUM(CASE WHEN donor_submission_required = TRUE THEN 1 ELSE 0 END), 0), 2)
      comment: "Percentage of donor-required SitReps that have been submitted — donor reporting compliance KPI; low rates risk grant non-compliance findings."
    - name: "ocha_submission_compliance_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN ocha_submission_required = TRUE AND report_status = 'submitted' THEN 1 ELSE 0 END) / NULLIF(SUM(CASE WHEN ocha_submission_required = TRUE THEN 1 ELSE 0 END), 0), 2)
      comment: "Percentage of OCHA-required SitReps that have been submitted — UN coordination reporting compliance KPI."
    - name: "published_sitrep_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN report_status = 'published' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of SitReps that have been published — transparency and information sharing KPI for humanitarian accountability."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`field_deployment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Field deployment KPIs — tracks deployment cost efficiency, duration, and safeguarding compliance. Supports workforce planning, duty of care, and programme delivery capacity management. Aligns with HR systems (SAP HCM) and field operations management."
  source: "`vibe_ngo_v1`.`field`.`field_deployment`"
  dimensions:
    - name: "deployment_type"
      expr: deployment_type
      comment: "Type of deployment (e.g. emergency surge, regular programme, assessment) — primary dimension for deployment portfolio analysis."
    - name: "deployment_status"
      expr: deployment_status
      comment: "Current status of the deployment (e.g. planned, active, completed, cancelled) — used to filter active vs historical deployments."
    - name: "response_type"
      expr: response_type
      comment: "Response type (e.g. emergency, development, transition) — used to segment deployment portfolio by programme phase."
    - name: "security_clearance_level"
      expr: security_clearance_level
      comment: "Security clearance level required for the deployment — used to assess deployment risk profile."
    - name: "transportation_mode"
      expr: transportation_mode
      comment: "Mode of transportation used for the deployment — used to analyse logistics cost drivers."
    - name: "start_date_month"
      expr: DATE_TRUNC('MONTH', start_date)
      comment: "Month the deployment started — enables trend analysis of deployment activity over time."
    - name: "medical_clearance_required"
      expr: medical_clearance_required
      comment: "Whether medical clearance was required for the deployment — duty of care compliance dimension."
    - name: "gis_track_enabled"
      expr: gis_track_enabled
      comment: "Whether GIS tracking was enabled for the deployment — security monitoring compliance dimension."
  measures:
    - name: "total_deployments"
      expr: COUNT(1)
      comment: "Total number of field deployments — baseline workforce deployment volume KPI."
    - name: "total_deployment_cost_usd"
      expr: SUM(CAST(cost_estimate AS DOUBLE))
      comment: "Total estimated cost of field deployments in USD — financial resource planning KPI for field operations budget management."
    - name: "avg_deployment_cost_usd"
      expr: ROUND(AVG(CAST(cost_estimate AS DOUBLE)), 2)
      comment: "Average cost per field deployment — efficiency benchmarking KPI; used to identify high-cost deployment patterns and optimise logistics."
    - name: "active_deployments_count"
      expr: SUM(CASE WHEN deployment_status = 'active' THEN 1 ELSE 0 END)
      comment: "Count of currently active field deployments — real-time field capacity KPI for operational planning."
    - name: "gis_tracking_compliance_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN gis_track_enabled = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of deployments with GIS tracking enabled — security monitoring compliance KPI; low rates indicate duty of care gaps."
    - name: "medical_clearance_compliance_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN medical_clearance_required = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of deployments requiring medical clearance — duty of care risk profiling KPI; used to assess health risk exposure of field workforce."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`field_project_site`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Project site metrics tracking operational infrastructure, accessibility, and site readiness for program delivery"
  source: "`vibe_ngo_v1`.`field`.`project_site`"
  dimensions:
    - name: "site_type"
      expr: site_type
      comment: "Type of project site (office, warehouse, health facility, distribution point, camp)"
    - name: "operational_status"
      expr: operational_status
      comment: "Current operational status of site (active, inactive, under construction, decommissioned)"
    - name: "security_level"
      expr: security_level
      comment: "Security risk level at site location (low, medium, high, critical)"
    - name: "accessibility_rating"
      expr: accessibility_rating
      comment: "Accessibility rating for site (easy, moderate, difficult, very difficult)"
    - name: "admin_level_1"
      expr: admin_level_1
      comment: "First-level administrative division of site"
    - name: "admin_level_2"
      expr: admin_level_2
      comment: "Second-level administrative division of site"
    - name: "cluster_affiliation"
      expr: cluster_affiliation
      comment: "Humanitarian cluster affiliation of site"
    - name: "electricity_available"
      expr: electricity_available
      comment: "Whether electricity is available at site"
    - name: "water_source_available"
      expr: water_source_available
      comment: "Whether water source is available at site"
    - name: "internet_connectivity"
      expr: internet_connectivity
      comment: "Type of internet connectivity at site (none, mobile, satellite, fiber)"
    - name: "facility_ownership"
      expr: facility_ownership
      comment: "Ownership type of facility (owned, rented, government-provided, partner)"
    - name: "establishment_year"
      expr: YEAR(establishment_date)
      comment: "Year site was established"
  measures:
    - name: "total_project_sites"
      expr: COUNT(1)
      comment: "Total number of project sites"
    - name: "active_sites"
      expr: SUM(CASE WHEN operational_status = 'active' THEN 1 ELSE 0 END)
      comment: "Number of currently active project sites"
    - name: "site_activation_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN operational_status = 'active' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of sites that are operationally active (infrastructure utilization)"
    - name: "total_site_area"
      expr: SUM(CAST(site_area_sqm AS DOUBLE))
      comment: "Total site area in square meters across all sites"
    - name: "avg_site_area"
      expr: AVG(CAST(site_area_sqm AS DOUBLE))
      comment: "Average site area in square meters"
    - name: "sites_with_electricity"
      expr: SUM(CASE WHEN electricity_available = TRUE THEN 1 ELSE 0 END)
      comment: "Number of sites with electricity available"
    - name: "electricity_coverage_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN electricity_available = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of sites with electricity (infrastructure readiness indicator)"
    - name: "sites_with_water"
      expr: SUM(CASE WHEN water_source_available = TRUE THEN 1 ELSE 0 END)
      comment: "Number of sites with water source available"
    - name: "water_coverage_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN water_source_available = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of sites with water source (infrastructure readiness indicator)"
    - name: "sites_with_internet"
      expr: SUM(CASE WHEN internet_connectivity IS NOT NULL AND internet_connectivity != 'none' THEN 1 ELSE 0 END)
      comment: "Number of sites with internet connectivity"
    - name: "internet_coverage_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN internet_connectivity IS NOT NULL AND internet_connectivity != 'none' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of sites with internet connectivity (digital readiness indicator)"
    - name: "high_security_risk_sites"
      expr: SUM(CASE WHEN security_level IN ('high', 'critical') THEN 1 ELSE 0 END)
      comment: "Number of sites in high or critical security risk areas"
    - name: "high_security_risk_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN security_level IN ('high', 'critical') THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of sites in high-risk security areas (operational risk exposure)"
    - name: "avg_population_catchment"
      expr: AVG(CAST(population_catchment AS BIGINT))
      comment: "Average population catchment area served by sites (coverage reach indicator)"
    - name: "unique_admin_level_1_coverage"
      expr: COUNT(DISTINCT admin_level_1)
      comment: "Number of unique first-level administrative divisions covered (geographic reach)"
    - name: "unique_admin_level_2_coverage"
      expr: COUNT(DISTINCT admin_level_2)
      comment: "Number of unique second-level administrative divisions covered (geographic reach)"
$$;