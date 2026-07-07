-- Metric views for domain: field | Business: Ngo | Version: 2 | Generated on: 2026-07-03 06:15:30

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`field_distribution_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Operational KPIs for humanitarian distribution events — tracks budget utilisation, beneficiary reach, and delivery efficiency to steer field programme decisions."
  source: "`vibe_ngo_v1`.`field`.`distribution_event`"
  dimensions:
    - name: "distribution_status"
      expr: distribution_status
      comment: "Current lifecycle status of the distribution event (e.g. Planned, In Progress, Completed, Cancelled) — primary filter for operational dashboards."
    - name: "distribution_type"
      expr: distribution_type
      comment: "Type of distribution (e.g. In-Kind, Cash, Voucher) — used to segment reach and spend by modality."
    - name: "distribution_modality"
      expr: distribution_modality
      comment: "Delivery modality (e.g. Direct, Partner-Led, Mobile) — key dimension for operational efficiency analysis."
    - name: "commodity_category"
      expr: commodity_category
      comment: "Category of commodity distributed (e.g. Food, NFI, WASH) — enables sector-level performance tracking."
    - name: "cva_transfer_modality"
      expr: cva_transfer_modality
      comment: "Cash and Voucher Assistance transfer modality — distinguishes cash, mobile money, voucher, etc."
    - name: "admin_level_1"
      expr: admin_level_1
      comment: "First administrative level (e.g. region/province) where the distribution took place — geographic drill-down dimension."
    - name: "admin_level_2"
      expr: admin_level_2
      comment: "Second administrative level (e.g. district) — finer geographic segmentation for field planning."
    - name: "scheduled_date_month"
      expr: DATE_TRUNC('MONTH', scheduled_date)
      comment: "Month of the scheduled distribution date — enables time-series trend analysis of distribution planning."
    - name: "incident_reported_flag"
      expr: incident_reported_flag
      comment: "Boolean flag indicating whether a field incident was reported during this distribution — used to filter risk-flagged events."
    - name: "pdm_scheduled_flag"
      expr: pdm_scheduled_flag
      comment: "Boolean flag indicating whether a Post-Distribution Monitoring exercise was scheduled — accountability dimension."
  measures:
    - name: "total_distribution_events"
      expr: COUNT(1)
      comment: "Total number of distribution events — baseline volume KPI for operational throughput tracking."
    - name: "total_budget_allocated_usd"
      expr: SUM(CAST(budget_allocated_amount AS DOUBLE))
      comment: "Total budget allocated across all distribution events in USD — primary financial planning KPI."
    - name: "total_actual_expenditure_usd"
      expr: SUM(CAST(actual_expenditure_amount AS DOUBLE))
      comment: "Total actual expenditure across distribution events in USD — compared against budget to assess financial execution."
    - name: "avg_budget_utilisation_rate"
      expr: ROUND(100.0 * SUM(CAST(actual_expenditure_amount AS DOUBLE)) / NULLIF(SUM(CAST(budget_allocated_amount AS DOUBLE)), 0), 2)
      comment: "Average budget utilisation rate (%) — ratio of actual spend to allocated budget; a key financial accountability KPI for donors and leadership."
    - name: "total_events_with_incidents"
      expr: COUNT(CASE WHEN incident_reported_flag = TRUE THEN 1 END)
      comment: "Count of distribution events where a field incident was reported — operational risk KPI used to trigger safety reviews."
    - name: "incident_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN incident_reported_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of distribution events with a reported incident — safety and risk management KPI for field leadership."
    - name: "total_events_with_pdm_scheduled"
      expr: COUNT(CASE WHEN pdm_scheduled_flag = TRUE THEN 1 END)
      comment: "Count of distribution events with Post-Distribution Monitoring scheduled — accountability and quality assurance KPI."
    - name: "pdm_scheduling_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN pdm_scheduled_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of distribution events with PDM scheduled — measures accountability coverage; low rates signal monitoring gaps."
    - name: "avg_actual_expenditure_per_event_usd"
      expr: ROUND(AVG(CAST(actual_expenditure_amount AS DOUBLE)), 2)
      comment: "Average actual expenditure per distribution event in USD — cost-efficiency benchmark for comparing events across regions and modalities."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`field_distribution_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Item-level distribution KPIs — tracks quantities distributed, delivery value, variance, and quality to inform supply chain and programme decisions."
  source: "`vibe_ngo_v1`.`field`.`distribution_line`"
  dimensions:
    - name: "distribution_status"
      expr: distribution_status
      comment: "Delivery status of the distribution line item (e.g. Delivered, Pending, Rejected) — primary operational filter."
    - name: "item_category"
      expr: item_category
      comment: "Category of the distributed item (e.g. Food, NFI, Medicine) — sector-level supply analysis dimension."
    - name: "cluster_sector"
      expr: cluster_sector
      comment: "Humanitarian cluster or sector the line item belongs to — aligns distribution data with cluster coordination reporting."
    - name: "cva_transfer_modality"
      expr: cva_transfer_modality
      comment: "Cash and Voucher Assistance modality for this line — distinguishes in-kind from cash-based interventions."
    - name: "unit_of_measure"
      expr: unit_of_measure
      comment: "Unit of measure for the distributed commodity (e.g. kg, litre, unit) — required for quantity comparisons across commodities."
    - name: "quality_check_status"
      expr: quality_check_status
      comment: "Quality control status of the line item (e.g. Passed, Failed, Pending) — quality assurance dimension."
    - name: "substitution_flag"
      expr: substitution_flag
      comment: "Boolean flag indicating whether a commodity substitution occurred — supply chain risk and pipeline integrity dimension."
    - name: "donor_earmark"
      expr: donor_earmark
      comment: "Donor earmarking designation for this line item — critical for donor compliance and restricted-fund reporting."
    - name: "delivery_confirmation_date_month"
      expr: DATE_TRUNC('MONTH', delivery_confirmation_date)
      comment: "Month of delivery confirmation — enables time-series analysis of distribution throughput."
  measures:
    - name: "total_distribution_lines"
      expr: COUNT(1)
      comment: "Total number of distribution line items — baseline volume KPI for supply chain throughput."
    - name: "total_quantity_planned"
      expr: SUM(CAST(planned_quantity AS DOUBLE))
      comment: "Total planned quantity across all distribution lines — supply planning baseline."
    - name: "total_quantity_distributed"
      expr: SUM(CAST(actual_quantity_distributed AS DOUBLE))
      comment: "Total actual quantity distributed — primary delivery output KPI."
    - name: "delivery_fulfilment_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(actual_quantity_distributed AS DOUBLE)) / NULLIF(SUM(CAST(planned_quantity AS DOUBLE)), 0), 2)
      comment: "Percentage of planned quantity actually distributed — key supply chain performance KPI; low rates indicate pipeline or logistics failures."
    - name: "total_distribution_value_usd"
      expr: SUM(CAST(total_value AS DOUBLE))
      comment: "Total monetary value of all distributed items in USD — financial accountability KPI for donor reporting."
    - name: "avg_unit_value_usd"
      expr: ROUND(AVG(CAST(unit_value AS DOUBLE)), 2)
      comment: "Average unit value of distributed items in USD — cost benchmarking KPI for procurement and supply chain efficiency."
    - name: "total_variance_quantity"
      expr: SUM(CAST(variance_quantity AS DOUBLE))
      comment: "Total quantity variance (planned minus actual) across all lines — supply chain loss and discrepancy KPI; large values trigger investigation."
    - name: "total_lines_with_substitution"
      expr: COUNT(CASE WHEN substitution_flag = TRUE THEN 1 END)
      comment: "Count of distribution lines where a commodity substitution occurred — pipeline integrity and supply reliability KPI."
    - name: "substitution_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN substitution_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of distribution lines with commodity substitutions — measures supply chain reliability; high rates signal procurement or pipeline issues."
    - name: "total_lines_quality_failed"
      expr: COUNT(CASE WHEN quality_check_status = 'Failed' THEN 1 END)
      comment: "Count of distribution lines that failed quality checks — quality assurance KPI; drives corrective action in supply chain."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`field_assessment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Field assessment quality and coverage KPIs — measures data quality, beneficiary satisfaction, and assessment utilisation to guide MEL and programme decisions."
  source: "`vibe_ngo_v1`.`field`.`assessment`"
  dimensions:
    - name: "assessment_type"
      expr: assessment_type
      comment: "Type of assessment conducted (e.g. Needs Assessment, PDM, Baseline, Endline) — primary segmentation for MEL analysis."
    - name: "assessment_status"
      expr: assessment_status
      comment: "Current status of the assessment (e.g. Planned, In Progress, Completed, Validated) — lifecycle tracking dimension."
    - name: "geographic_scope"
      expr: geographic_scope
      comment: "Geographic scope of the assessment (e.g. National, Regional, District) — spatial coverage dimension."
    - name: "methodology"
      expr: methodology
      comment: "Data collection methodology used (e.g. Survey, FGD, KII, Observation) — methodological quality dimension."
    - name: "data_collection_tool"
      expr: data_collection_tool
      comment: "Tool used for data collection (e.g. KoBoToolbox, ODK, Paper) — digital transformation and data quality dimension."
    - name: "mel_indicator_linked"
      expr: mel_indicator_linked
      comment: "Boolean flag indicating whether the assessment is linked to a MEL indicator — measures alignment with results framework."
    - name: "protection_concerns_noted"
      expr: protection_concerns_noted
      comment: "Boolean flag indicating whether protection concerns were identified — safeguarding and risk dimension."
    - name: "donor_visibility_flag"
      expr: donor_visibility_flag
      comment: "Boolean flag indicating whether the assessment is visible to donors — donor accountability dimension."
    - name: "assessment_date_month"
      expr: DATE_TRUNC('MONTH', assessment_date)
      comment: "Month of the assessment date — enables time-series trend analysis of assessment activity."
  measures:
    - name: "total_assessments"
      expr: COUNT(1)
      comment: "Total number of assessments conducted — baseline volume KPI for MEL coverage tracking."
    - name: "avg_data_quality_score"
      expr: ROUND(AVG(CAST(data_quality_score AS DOUBLE)), 2)
      comment: "Average data quality score across assessments — primary MEL data integrity KPI; low scores trigger data quality improvement actions."
    - name: "avg_beneficiary_satisfaction_score"
      expr: ROUND(AVG(CAST(beneficiary_satisfaction_score AS DOUBLE)), 2)
      comment: "Average beneficiary satisfaction score — accountability to affected populations KPI; directly informs programme quality decisions."
    - name: "avg_adequacy_score"
      expr: ROUND(AVG(CAST(adequacy_score AS DOUBLE)), 2)
      comment: "Average adequacy score across assessments — measures whether programme responses meet identified needs; key programme effectiveness KPI."
    - name: "avg_utilisation_rate_pct"
      expr: ROUND(AVG(CAST(utilization_rate_percent AS DOUBLE)), 2)
      comment: "Average utilisation rate (%) across assessments — measures how effectively assessment findings are being used; low rates indicate evidence-to-action gaps."
    - name: "assessments_with_protection_concerns"
      expr: COUNT(CASE WHEN protection_concerns_noted = TRUE THEN 1 END)
      comment: "Count of assessments where protection concerns were identified — safeguarding KPI; triggers protection mainstreaming reviews."
    - name: "protection_concern_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN protection_concerns_noted = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of assessments with protection concerns noted — risk and safeguarding KPI for programme leadership."
    - name: "mel_indicator_linkage_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN mel_indicator_linked = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of assessments linked to a MEL indicator — measures results framework alignment; low rates indicate MEL system gaps."
    - name: "validated_assessments_count"
      expr: COUNT(CASE WHEN assessment_status = 'Validated' THEN 1 END)
      comment: "Count of assessments that have been validated — data governance and quality assurance KPI."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`field_assessment_response`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Household-level assessment response KPIs — tracks vulnerability profiles, food security, protection concerns, and referral needs to inform targeting and programme design."
  source: "`vibe_ngo_v1`.`field`.`assessment_response`"
  dimensions:
    - name: "response_status"
      expr: response_status
      comment: "Status of the assessment response record (e.g. Submitted, Validated, Rejected) — data quality lifecycle dimension."
    - name: "displacement_status"
      expr: displacement_status
      comment: "Displacement status of the respondent household (e.g. IDP, Refugee, Host Community) — primary vulnerability segmentation dimension."
    - name: "primary_need_category"
      expr: primary_need_category
      comment: "Primary humanitarian need category identified (e.g. Food, Shelter, WASH, Protection) — drives sector targeting decisions."
    - name: "shelter_type"
      expr: shelter_type
      comment: "Type of shelter the household occupies — vulnerability and shelter sector analysis dimension."
    - name: "livelihood_status"
      expr: livelihood_status
      comment: "Livelihood status of the household — economic vulnerability dimension for cash and livelihoods programming."
    - name: "data_collection_method"
      expr: data_collection_method
      comment: "Method used to collect the response (e.g. Face-to-Face, Phone, Remote) — data quality and reach dimension."
    - name: "protection_concern_flag"
      expr: protection_concern_flag
      comment: "Boolean flag indicating a protection concern was identified for this household — safeguarding filter dimension."
    - name: "referral_required_flag"
      expr: referral_required_flag
      comment: "Boolean flag indicating a referral to another service was required — case management and service linkage dimension."
    - name: "disability_present_flag"
      expr: disability_present_flag
      comment: "Boolean flag indicating disability presence in the household — inclusion and equity targeting dimension."
    - name: "submission_timestamp_month"
      expr: DATE_TRUNC('MONTH', submission_timestamp)
      comment: "Month of response submission — time-series analysis of data collection activity."
  measures:
    - name: "total_responses"
      expr: COUNT(1)
      comment: "Total number of assessment responses collected — baseline data collection volume KPI."
    - name: "total_unique_households"
      expr: COUNT(DISTINCT household_id)
      comment: "Count of distinct households assessed — primary reach KPI for household-level programme coverage."
    - name: "avg_food_security_score"
      expr: ROUND(AVG(CAST(food_security_score AS DOUBLE)), 2)
      comment: "Average food security score across respondent households — primary food security KPI; drives food assistance targeting decisions."
    - name: "avg_monthly_income_usd"
      expr: ROUND(AVG(CAST(monthly_income_usd AS DOUBLE)), 2)
      comment: "Average monthly household income in USD — economic vulnerability KPI for cash transfer value-setting and livelihoods programming."
    - name: "households_with_protection_concerns"
      expr: COUNT(CASE WHEN protection_concern_flag = TRUE THEN 1 END)
      comment: "Count of households with identified protection concerns — safeguarding caseload KPI; drives protection referral planning."
    - name: "protection_concern_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN protection_concern_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of assessed households with protection concerns — risk prevalence KPI for protection mainstreaming and resource allocation."
    - name: "referral_required_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN referral_required_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of households requiring referral to another service — case management demand KPI; informs service linkage capacity planning."
    - name: "households_with_disability"
      expr: COUNT(CASE WHEN disability_present_flag = TRUE THEN 1 END)
      comment: "Count of households with at least one person with a disability — inclusion KPI for equity-focused programme targeting."
    - name: "disability_inclusion_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN disability_present_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of assessed households with disability present — inclusion and equity KPI for programme design and donor reporting."
    - name: "consent_data_sharing_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN consent_data_sharing = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of respondents who consented to data sharing — data governance and ethical compliance KPI."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`field_emergency`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Emergency response KPIs — tracks funding coverage, population reach, and response activation to steer humanitarian resource allocation and strategic decisions."
  source: "`vibe_ngo_v1`.`field`.`emergency`"
  dimensions:
    - name: "emergency_type"
      expr: emergency_type
      comment: "Type of emergency (e.g. Conflict, Natural Disaster, Disease Outbreak) — primary segmentation for response strategy analysis."
    - name: "emergency_status"
      expr: emergency_status
      comment: "Current status of the emergency (e.g. Active, Monitoring, Closed) — lifecycle filter for operational dashboards."
    - name: "severity_level"
      expr: severity_level
      comment: "Severity classification of the emergency — risk prioritisation dimension for resource allocation decisions."
    - name: "disaster_category"
      expr: disaster_category
      comment: "Disaster category (e.g. Flood, Drought, Conflict, Epidemic) — sector and response modality analysis dimension."
    - name: "geographic_scope"
      expr: geographic_scope
      comment: "Geographic scope of the emergency (e.g. National, Sub-National, Cross-Border) — spatial planning dimension."
    - name: "response_modality"
      expr: response_modality
      comment: "Primary response modality (e.g. In-Kind, Cash, Hybrid) — programme design and efficiency analysis dimension."
    - name: "is_active"
      expr: is_active
      comment: "Boolean flag indicating whether the emergency is currently active — primary operational filter."
    - name: "flash_appeal_issued"
      expr: flash_appeal_issued
      comment: "Boolean flag indicating whether a Flash Appeal was issued — funding mobilisation dimension."
    - name: "rapid_assessment_completed"
      expr: rapid_assessment_completed
      comment: "Boolean flag indicating whether a rapid needs assessment was completed — response readiness dimension."
    - name: "declaration_date_month"
      expr: DATE_TRUNC('MONTH', declaration_date)
      comment: "Month of emergency declaration — time-series analysis of emergency onset patterns."
  measures:
    - name: "total_emergencies"
      expr: COUNT(1)
      comment: "Total number of emergencies — baseline volume KPI for humanitarian caseload tracking."
    - name: "total_affected_population"
      expr: SUM(CAST(affected_population_count AS DOUBLE))
      comment: "Total number of people affected across all emergencies — primary humanitarian scale KPI for resource mobilisation decisions."
    - name: "total_displaced_population"
      expr: SUM(CAST(displaced_population_count AS DOUBLE))
      comment: "Total number of displaced persons across all emergencies — displacement caseload KPI for shelter, WASH, and protection programming."
    - name: "total_targeted_beneficiaries"
      expr: SUM(CAST(targeted_beneficiaries_count AS DOUBLE))
      comment: "Total number of beneficiaries targeted for response — programme reach planning KPI."
    - name: "total_funding_received_usd"
      expr: SUM(CAST(funding_received_usd AS DOUBLE))
      comment: "Total funding received across all emergencies in USD — financial resource mobilisation KPI."
    - name: "total_funding_requirement_usd"
      expr: SUM(CAST(funding_requirement_usd AS DOUBLE))
      comment: "Total funding requirement across all emergencies in USD — funding gap analysis baseline."
    - name: "funding_coverage_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(funding_received_usd AS DOUBLE)) / NULLIF(SUM(CAST(funding_requirement_usd AS DOUBLE)), 0), 2)
      comment: "Percentage of funding requirement covered by received funding — critical humanitarian financing KPI; low rates trigger emergency fundraising actions."
    - name: "avg_funding_gap_per_emergency_usd"
      expr: ROUND(AVG(CAST(funding_requirement_usd AS DOUBLE) - CAST(funding_received_usd AS DOUBLE)), 2)
      comment: "Average funding gap per emergency in USD — resource mobilisation prioritisation KPI for leadership and donor engagement."
    - name: "rapid_assessment_completion_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN rapid_assessment_completed = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of emergencies with a completed rapid assessment — response readiness and evidence-based decision-making KPI."
    - name: "active_emergencies_count"
      expr: COUNT(CASE WHEN is_active = TRUE THEN 1 END)
      comment: "Count of currently active emergencies — real-time operational caseload KPI for field leadership."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`field_security_incident`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Security incident KPIs — tracks incident frequency, severity, financial impact, and reporting compliance to steer duty-of-care and risk management decisions."
  source: "`vibe_ngo_v1`.`field`.`security_incident`"
  dimensions:
    - name: "incident_type"
      expr: incident_type
      comment: "Type of security incident (e.g. Armed Robbery, Carjacking, Threat, Harassment) — primary risk categorisation dimension."
    - name: "incident_severity"
      expr: incident_severity
      comment: "Severity classification of the incident (e.g. Low, Medium, High, Critical) — risk prioritisation dimension for duty-of-care decisions."
    - name: "incident_status"
      expr: incident_status
      comment: "Current status of the incident (e.g. Open, Under Investigation, Closed) — case management lifecycle dimension."
    - name: "investigation_status"
      expr: investigation_status
      comment: "Status of the investigation into the incident — accountability and follow-through dimension."
    - name: "admin_level_1"
      expr: admin_level_1
      comment: "First administrative level where the incident occurred — geographic risk mapping dimension."
    - name: "reported_to_inso"
      expr: reported_to_inso
      comment: "Boolean flag indicating whether the incident was reported to INSO — external reporting compliance dimension."
    - name: "reported_to_undss"
      expr: reported_to_undss
      comment: "Boolean flag indicating whether the incident was reported to UNDSS — UN security coordination compliance dimension."
    - name: "incident_date_month"
      expr: DATE_TRUNC('MONTH', incident_date)
      comment: "Month of the incident date — time-series trend analysis of security incident patterns."
  measures:
    - name: "total_security_incidents"
      expr: COUNT(1)
      comment: "Total number of security incidents — baseline security caseload KPI for risk management dashboards."
    - name: "total_estimated_asset_loss_usd"
      expr: SUM(CAST(estimated_asset_loss_usd AS DOUBLE))
      comment: "Total estimated asset loss from security incidents in USD — financial impact KPI for insurance, risk provisioning, and donor reporting."
    - name: "avg_asset_loss_per_incident_usd"
      expr: ROUND(AVG(CAST(estimated_asset_loss_usd AS DOUBLE)), 2)
      comment: "Average estimated asset loss per security incident in USD — cost-of-insecurity benchmark for risk management decisions."
    - name: "critical_high_severity_incidents"
      expr: COUNT(CASE WHEN incident_severity IN ('Critical', 'High') THEN 1 END)
      comment: "Count of critical or high severity incidents — primary duty-of-care KPI; triggers immediate security protocol reviews."
    - name: "critical_high_severity_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN incident_severity IN ('Critical', 'High') THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of incidents classified as critical or high severity — security risk trend KPI for leadership and board reporting."
    - name: "inso_reporting_compliance_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN reported_to_inso = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of incidents reported to INSO — external security reporting compliance KPI; low rates indicate accountability gaps."
    - name: "undss_reporting_compliance_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN reported_to_undss = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of incidents reported to UNDSS — UN security coordination compliance KPI."
    - name: "open_investigations_count"
      expr: COUNT(CASE WHEN investigation_status NOT IN ('Closed', 'Completed') THEN 1 END)
      comment: "Count of incidents with open or pending investigations — accountability backlog KPI; high counts signal investigation capacity issues."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`field_sitrep`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Situation report KPIs — tracks reporting timeliness, HRP progress, funding gaps, and submission compliance to steer donor accountability and operational coordination."
  source: "`vibe_ngo_v1`.`field`.`sitrep`"
  dimensions:
    - name: "report_status"
      expr: report_status
      comment: "Current status of the sitrep (e.g. Draft, Submitted, Published) — reporting lifecycle dimension."
    - name: "reporting_frequency"
      expr: reporting_frequency
      comment: "Frequency of the sitrep (e.g. Weekly, Bi-Weekly, Monthly) — reporting cadence dimension."
    - name: "geographic_scope"
      expr: geographic_scope
      comment: "Geographic scope covered by the sitrep — spatial coverage dimension for coordination analysis."
    - name: "donor_submission_required"
      expr: donor_submission_required
      comment: "Boolean flag indicating whether donor submission is required — donor accountability compliance dimension."
    - name: "ocha_submission_required"
      expr: ocha_submission_required
      comment: "Boolean flag indicating whether OCHA submission is required — UN coordination compliance dimension."
    - name: "publication_date_month"
      expr: DATE_TRUNC('MONTH', publication_date)
      comment: "Month of sitrep publication — time-series analysis of reporting activity and cadence."
    - name: "admin_level_1_name"
      expr: admin_level_1_name
      comment: "First administrative level name covered by the sitrep — geographic drill-down dimension."
  measures:
    - name: "total_sitreps"
      expr: COUNT(1)
      comment: "Total number of situation reports produced — baseline reporting volume KPI for coordination accountability."
    - name: "avg_hrp_progress_pct"
      expr: ROUND(AVG(CAST(hrp_progress_percentage AS DOUBLE)), 2)
      comment: "Average Humanitarian Response Plan progress percentage across sitreps — primary strategic KPI for HRP accountability and donor reporting."
    - name: "total_funding_gap_usd"
      expr: SUM(CAST(funding_gap_usd AS DOUBLE))
      comment: "Total funding gap reported across all sitreps in USD — financial mobilisation KPI; drives emergency fundraising and donor engagement."
    - name: "avg_funding_gap_per_sitrep_usd"
      expr: ROUND(AVG(CAST(funding_gap_usd AS DOUBLE)), 2)
      comment: "Average funding gap per sitrep in USD — per-period financial shortfall KPI for resource planning."
    - name: "donor_submission_compliance_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN donor_submission_required = TRUE AND report_status = 'Submitted' THEN 1 END) / NULLIF(COUNT(CASE WHEN donor_submission_required = TRUE THEN 1 END), 0), 2)
      comment: "Percentage of donor-required sitreps that have been submitted — donor accountability compliance KPI; low rates risk donor relationship damage."
    - name: "ocha_submission_compliance_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN ocha_submission_required = TRUE AND report_status = 'Submitted' THEN 1 END) / NULLIF(COUNT(CASE WHEN ocha_submission_required = TRUE THEN 1 END), 0), 2)
      comment: "Percentage of OCHA-required sitreps that have been submitted — UN coordination compliance KPI."
    - name: "published_sitreps_count"
      expr: COUNT(CASE WHEN report_status = 'Published' THEN 1 END)
      comment: "Count of published sitreps — external communication and transparency KPI."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`field_team`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Field team operational KPIs — tracks budget deployment, team performance, and operational readiness to steer human resource and field management decisions."
  source: "`vibe_ngo_v1`.`field`.`team`"
  dimensions:
    - name: "team_type"
      expr: team_type
      comment: "Type of field team (e.g. Assessment, Distribution, Medical, Protection) — primary segmentation for team performance analysis."
    - name: "operational_status"
      expr: operational_status
      comment: "Current operational status of the team (e.g. Active, Standby, Demobilised) — readiness and capacity dimension."
    - name: "cluster_affiliation"
      expr: cluster_affiliation
      comment: "Humanitarian cluster the team is affiliated with — sector coordination dimension."
    - name: "performance_rating"
      expr: performance_rating
      comment: "Performance rating of the team (e.g. Excellent, Good, Satisfactory, Poor) — quality and accountability dimension."
    - name: "safety_clearance_level"
      expr: safety_clearance_level
      comment: "Security clearance level required for team deployment — risk management and access dimension."
    - name: "gps_tracking_enabled"
      expr: gps_tracking_enabled
      comment: "Boolean flag indicating whether GPS tracking is enabled for the team — duty-of-care and accountability dimension."
    - name: "mobile_data_collection_platform"
      expr: mobile_data_collection_platform
      comment: "Mobile data collection platform used by the team (e.g. KoBoToolbox, ODK) — digital readiness dimension."
    - name: "deployment_start_date_month"
      expr: DATE_TRUNC('MONTH', deployment_start_date)
      comment: "Month of team deployment start — time-series analysis of field capacity deployment."
  measures:
    - name: "total_teams"
      expr: COUNT(1)
      comment: "Total number of field teams — baseline capacity KPI for field operations management."
    - name: "total_monthly_operational_budget_usd"
      expr: SUM(CAST(monthly_operational_budget AS DOUBLE))
      comment: "Total monthly operational budget across all teams in USD — field operations financial planning KPI."
    - name: "avg_monthly_operational_budget_per_team_usd"
      expr: ROUND(AVG(CAST(monthly_operational_budget AS DOUBLE)), 2)
      comment: "Average monthly operational budget per team in USD — cost-per-team efficiency benchmark for resource allocation decisions."
    - name: "active_teams_count"
      expr: COUNT(CASE WHEN operational_status = 'Active' THEN 1 END)
      comment: "Count of currently active field teams — real-time field capacity KPI for operational planning."
    - name: "gps_tracking_coverage_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN gps_tracking_enabled = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of teams with GPS tracking enabled — duty-of-care and staff safety compliance KPI."
    - name: "high_performing_teams_count"
      expr: COUNT(CASE WHEN performance_rating IN ('Excellent', 'Good') THEN 1 END)
      comment: "Count of teams rated Excellent or Good — talent and performance management KPI for HR and field leadership."
    - name: "high_performance_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN performance_rating IN ('Excellent', 'Good') THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of teams with high performance ratings — organisational effectiveness KPI; low rates trigger capacity building investments."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`field_project_site`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Project site infrastructure and operational KPIs — tracks site coverage, accessibility, and digital readiness to inform field infrastructure investment decisions."
  source: "`vibe_ngo_v1`.`field`.`project_site`"
  dimensions:
    - name: "site_type"
      expr: site_type
      comment: "Type of project site (e.g. Health Facility, Distribution Point, School, Office) — primary segmentation for infrastructure analysis."
    - name: "operational_status"
      expr: operational_status
      comment: "Current operational status of the site (e.g. Active, Closed, Suspended) — site lifecycle dimension."
    - name: "security_level"
      expr: security_level
      comment: "Security risk level at the site — access and duty-of-care dimension for field planning."
    - name: "accessibility_rating"
      expr: accessibility_rating
      comment: "Accessibility rating of the site (e.g. Accessible, Difficult, Inaccessible) — humanitarian access dimension."
    - name: "admin_level_1"
      expr: admin_level_1
      comment: "First administrative level of the site — geographic coverage dimension."
    - name: "admin_level_2"
      expr: admin_level_2
      comment: "Second administrative level of the site — finer geographic drill-down dimension."
    - name: "kobo_collection_enabled"
      expr: kobo_collection_enabled
      comment: "Boolean flag indicating whether KoBoToolbox data collection is enabled at the site — digital readiness dimension."
    - name: "electricity_available"
      expr: electricity_available
      comment: "Boolean flag indicating electricity availability at the site — infrastructure quality dimension."
    - name: "water_source_available"
      expr: water_source_available
      comment: "Boolean flag indicating water source availability at the site — WASH infrastructure dimension."
    - name: "establishment_date_year"
      expr: DATE_TRUNC('YEAR', establishment_date)
      comment: "Year of site establishment — portfolio age and investment timeline dimension."
  measures:
    - name: "total_project_sites"
      expr: COUNT(1)
      comment: "Total number of project sites — baseline field footprint KPI."
    - name: "active_sites_count"
      expr: COUNT(CASE WHEN operational_status = 'Active' THEN 1 END)
      comment: "Count of currently active project sites — operational field coverage KPI for programme management."
    - name: "active_site_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN operational_status = 'Active' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of project sites that are currently active — field portfolio utilisation KPI."
    - name: "total_site_area_sqm"
      expr: SUM(CAST(site_area_sqm AS DOUBLE))
      comment: "Total physical area of all project sites in square metres — infrastructure footprint KPI for asset management."
    - name: "avg_site_area_sqm"
      expr: ROUND(AVG(CAST(site_area_sqm AS DOUBLE)), 2)
      comment: "Average site area in square metres — infrastructure sizing benchmark for site planning decisions."
    - name: "kobo_enabled_sites_count"
      expr: COUNT(CASE WHEN kobo_collection_enabled = TRUE THEN 1 END)
      comment: "Count of sites with KoBoToolbox data collection enabled — digital data collection coverage KPI."
    - name: "digital_readiness_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN kobo_collection_enabled = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of sites with digital data collection enabled — digital transformation KPI; low rates indicate data quality and reporting risks."
    - name: "sites_with_electricity_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN electricity_available = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of sites with electricity available — infrastructure quality KPI for operational planning and investment prioritisation."
$$;