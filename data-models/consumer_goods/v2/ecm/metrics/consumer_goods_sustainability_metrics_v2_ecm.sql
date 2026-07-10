-- Metric views for domain: sustainability | Business: Consumer_Goods | Version: 2 | Generated on: 2026-07-10 13:28:51

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`sustainability_carbon_emission`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core GHG emissions KPIs tracking total CO2e output by scope, source category, and facility. Used by sustainability leadership to monitor decarbonization progress, set science-based targets, and report under GHG Protocol, CDP, and TCFD frameworks."
  source: "`vibe_consumer_goods_v1`.`sustainability`.`carbon_emission`"
  dimensions:
    - name: "scope"
      expr: scope
      comment: "GHG Protocol scope classification (Scope 1, 2, or 3) — primary grouping for regulatory and voluntary reporting."
    - name: "emission_source_category"
      expr: emission_source_category
      comment: "Category of emission source (e.g., stationary combustion, purchased electricity, logistics) for hotspot identification."
    - name: "activity_type"
      expr: activity_type
      comment: "Type of business activity generating the emission — used to attribute emissions to operational processes."
    - name: "reporting_year"
      expr: reporting_year
      comment: "Fiscal or calendar year of the emission record — essential for year-over-year trend analysis."
    - name: "reporting_period"
      expr: reporting_period
      comment: "Sub-annual reporting period (e.g., Q1 2024) for intra-year tracking against reduction targets."
    - name: "verification_status"
      expr: verification_status
      comment: "Third-party verification status of the emission record — distinguishes assured data from unverified estimates."
    - name: "external_reporting_standard"
      expr: external_reporting_standard
      comment: "Reporting standard applied (GHG Protocol, ISO 14064, etc.) — required for multi-framework disclosure."
    - name: "record_status"
      expr: record_status
      comment: "Operational status of the emission record — filter to active/approved records for reporting."
    - name: "emission_timestamp_month"
      expr: DATE_TRUNC('MONTH', emission_timestamp)
      comment: "Month of emission event — enables monthly trend analysis and seasonal pattern detection."
    - name: "geographic_location"
      expr: geographic_location
      comment: "Geographic location of the emission source — supports regional emissions breakdown and regulatory jurisdiction mapping."
  measures:
    - name: "total_co2e_tonnes"
      expr: SUM(CAST(co2e_quantity_tonnes AS DOUBLE))
      comment: "Total CO2-equivalent emissions in metric tonnes. Primary KPI for decarbonization target tracking and regulatory disclosure (CDP, TCFD, GHG Protocol)."
    - name: "total_offset_tonnes"
      expr: SUM(CAST(offset_quantity_tonnes AS DOUBLE))
      comment: "Total carbon offsets applied in metric tonnes. Used to calculate net emissions position and validate offset strategy effectiveness."
    - name: "net_co2e_tonnes"
      expr: SUM(CAST(co2e_quantity_tonnes AS DOUBLE) - CAST(offset_quantity_tonnes AS DOUBLE))
      comment: "Net CO2e after subtracting applied offsets. Represents the organization's residual carbon liability — key metric for net-zero progress reporting."
    - name: "total_energy_consumption_mwh"
      expr: SUM(CAST(energy_consumption_mwh AS DOUBLE))
      comment: "Total energy consumed in MWh associated with emission records. Supports energy intensity and efficiency KPIs."
    - name: "avg_carbon_intensity_factor"
      expr: AVG(CAST(carbon_intensity_factor AS DOUBLE))
      comment: "Average carbon intensity factor across emission records. Tracks improvement in emission efficiency per unit of activity over time."
    - name: "avg_emission_factor"
      expr: AVG(CAST(emission_factor AS DOUBLE))
      comment: "Average emission factor used in calculations. Monitors data quality and methodology consistency across reporting periods."
    - name: "emission_record_count"
      expr: COUNT(1)
      comment: "Total number of emission records. Used to assess data completeness and coverage across facilities and activities."
    - name: "verified_emission_record_count"
      expr: COUNT(CASE WHEN verification_status = 'Verified' THEN 1 END)
      comment: "Count of third-party verified emission records. Measures data assurance coverage — critical for external disclosure credibility."
    - name: "total_water_consumption_m3"
      expr: SUM(CAST(water_consumption_m3 AS DOUBLE))
      comment: "Total water consumption in cubic metres associated with emission-generating activities. Supports integrated environmental footprint reporting."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`sustainability_carbon_offset`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Carbon offset portfolio KPIs tracking credit purchases, retirements, and cost efficiency. Used by sustainability finance and ESG teams to manage offset strategy, validate net-zero claims, and optimize offset procurement costs."
  source: "`vibe_consumer_goods_v1`.`sustainability`.`carbon_offset`"
  dimensions:
    - name: "project_type"
      expr: project_type
      comment: "Type of offset project (e.g., reforestation, renewable energy, methane capture) — used to assess portfolio diversification and quality."
    - name: "registry"
      expr: registry
      comment: "Carbon registry where credits are registered (e.g., Verra VCS, Gold Standard) — key quality indicator for offset credibility."
    - name: "carbon_offset_status"
      expr: carbon_offset_status
      comment: "Current status of the offset record (active, retired, pending) — filter for portfolio position analysis."
    - name: "vintage_year"
      expr: vintage_year
      comment: "Year the carbon reduction occurred — vintage quality affects market value and regulatory acceptance."
    - name: "reporting_year"
      expr: reporting_year
      comment: "Reporting year for the offset — aligns offset retirements with emission reporting periods."
    - name: "country_code"
      expr: country_code
      comment: "Country where the offset project is located — supports geographic diversification analysis."
    - name: "alignment_type"
      expr: alignment_type
      comment: "Alignment with voluntary or compliance frameworks (e.g., Paris Agreement, CORSIA) — determines regulatory applicability."
    - name: "verification_method"
      expr: verification_method
      comment: "Method used to verify the offset (e.g., third-party audit, satellite monitoring) — quality assurance dimension."
  measures:
    - name: "total_credits_purchased"
      expr: SUM(CAST(credit_quantity_purchased AS DOUBLE))
      comment: "Total carbon credits purchased in tonnes CO2e. Measures the scale of offset procurement activity."
    - name: "total_credits_retired"
      expr: SUM(CAST(credit_quantity_retired AS DOUBLE))
      comment: "Total carbon credits retired (permanently cancelled) in tonnes CO2e. Represents actual offset claims made against emissions."
    - name: "total_offset_cost"
      expr: SUM(CAST(total_cost AS DOUBLE))
      comment: "Total financial investment in carbon offsets. Key input for sustainability budget management and cost-per-tonne analysis."
    - name: "avg_cost_per_tonne"
      expr: AVG(CAST(cost_per_tonne AS DOUBLE))
      comment: "Average cost per tonne of CO2e offset. Benchmarks procurement efficiency and tracks market price trends."
    - name: "retirement_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(credit_quantity_retired AS DOUBLE)) / NULLIF(SUM(CAST(credit_quantity_purchased AS DOUBLE)), 0), 2)
      comment: "Percentage of purchased credits that have been retired. Measures offset utilization efficiency — low rates indicate unused inventory or delayed retirement."
    - name: "offset_project_count"
      expr: COUNT(DISTINCT project_name)
      comment: "Number of distinct offset projects in the portfolio. Measures diversification of the offset strategy."
    - name: "compliant_offset_count"
      expr: COUNT(CASE WHEN compliance_flag = TRUE THEN 1 END)
      comment: "Count of offset records flagged as compliant with applicable regulations. Tracks regulatory compliance of the offset portfolio."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`sustainability_energy_consumption`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Energy consumption KPIs tracking total usage, renewable mix, and intensity ratios by facility and energy type. Used by operations and sustainability teams to manage energy costs, track renewable energy targets, and report under RE100 and CDP Energy frameworks."
  source: "`vibe_consumer_goods_v1`.`sustainability`.`energy_consumption`"
  dimensions:
    - name: "energy_type"
      expr: energy_type
      comment: "Type of energy consumed (electricity, natural gas, steam, etc.) — primary dimension for energy mix analysis."
    - name: "scope"
      expr: scope
      comment: "GHG Protocol scope associated with the energy consumption — links energy data to emissions reporting."
    - name: "reporting_year"
      expr: reporting_year
      comment: "Reporting year — enables year-over-year energy performance tracking."
    - name: "reporting_quarter"
      expr: reporting_quarter
      comment: "Reporting quarter — supports intra-year energy management and budget variance analysis."
    - name: "energy_consumption_status"
      expr: energy_consumption_status
      comment: "Status of the energy consumption record — filter to approved/active records for reporting."
    - name: "data_quality_status"
      expr: data_quality_status
      comment: "Data quality flag for the consumption record — used to exclude low-quality estimates from KPI calculations."
    - name: "measurement_source"
      expr: measurement_source
      comment: "Source of the energy measurement (smart meter, invoice, estimate) — quality and reliability indicator."
    - name: "period_start_date"
      expr: DATE_TRUNC('MONTH', period_start_date)
      comment: "Month of the consumption period start — enables monthly trend analysis."
  measures:
    - name: "total_energy_quantity"
      expr: SUM(CAST(energy_quantity AS DOUBLE))
      comment: "Total energy consumed across all types and facilities. Primary KPI for absolute energy reduction targets."
    - name: "avg_renewable_energy_pct"
      expr: AVG(CAST(renewable_energy_percentage AS DOUBLE))
      comment: "Average renewable energy percentage across consumption records. Tracks progress toward RE100 and internal renewable energy targets."
    - name: "avg_energy_intensity_ratio"
      expr: AVG(CAST(energy_intensity_ratio AS DOUBLE))
      comment: "Average energy intensity ratio (energy per unit of output). Measures operational energy efficiency improvement over time."
    - name: "total_carbon_emission_factor_weighted"
      expr: SUM(CAST(carbon_emission_factor AS DOUBLE))
      comment: "Sum of carbon emission factors across consumption records. Proxy for the carbon impact of the energy mix — lower values indicate cleaner energy procurement."
    - name: "iso_50001_compliant_record_count"
      expr: COUNT(CASE WHEN iso_50001_compliance_flag = TRUE THEN 1 END)
      comment: "Count of energy consumption records meeting ISO 50001 energy management standard. Measures compliance coverage across facilities."
    - name: "energy_consumption_record_count"
      expr: COUNT(1)
      comment: "Total number of energy consumption records. Used to assess data completeness and facility coverage."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`sustainability_waste_generation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Waste generation and diversion KPIs tracking total waste output, diversion rates, and zero-waste-to-landfill performance. Used by operations and sustainability teams to manage waste reduction programs, track circular economy targets, and meet regulatory reporting requirements."
  source: "`vibe_consumer_goods_v1`.`sustainability`.`waste_generation`"
  dimensions:
    - name: "waste_stream_type"
      expr: waste_stream_type
      comment: "Classification of waste stream (hazardous, non-hazardous, recyclable, organic) — primary dimension for waste management strategy."
    - name: "disposal_method"
      expr: disposal_method
      comment: "Method of waste disposal (landfill, incineration, recycling, composting) — key dimension for circular economy reporting."
    - name: "waste_category_code"
      expr: waste_category_code
      comment: "Regulatory waste category code — required for EPA and environmental compliance reporting."
    - name: "waste_generation_status"
      expr: waste_generation_status
      comment: "Status of the waste generation record — filter to confirmed/approved records for reporting."
    - name: "waste_date_month"
      expr: DATE_TRUNC('MONTH', waste_date)
      comment: "Month of waste generation — enables monthly trend analysis and seasonal pattern detection."
    - name: "epa_reportable_flag"
      expr: epa_reportable_flag
      comment: "Indicates whether the waste record is subject to EPA reporting requirements — critical for regulatory compliance tracking."
    - name: "zero_waste_to_landfill_flag"
      expr: zero_waste_to_landfill_flag
      comment: "Indicates whether the waste was diverted from landfill — tracks progress toward zero-waste-to-landfill certification."
  measures:
    - name: "total_waste_quantity"
      expr: SUM(CAST(waste_quantity AS DOUBLE))
      comment: "Total waste generated in reported units. Primary KPI for absolute waste reduction targets and circular economy programs."
    - name: "avg_diversion_rate_pct"
      expr: AVG(CAST(diversion_rate_percent AS DOUBLE))
      comment: "Average waste diversion rate (percentage diverted from landfill). Tracks progress toward zero-waste-to-landfill goals — a key sustainability KPI."
    - name: "zero_waste_record_count"
      expr: COUNT(CASE WHEN zero_waste_to_landfill_flag = TRUE THEN 1 END)
      comment: "Count of waste records where material was fully diverted from landfill. Measures operational achievement of zero-waste-to-landfill targets."
    - name: "epa_reportable_waste_count"
      expr: COUNT(CASE WHEN epa_reportable_flag = TRUE THEN 1 END)
      comment: "Count of EPA-reportable waste records. Tracks regulatory reporting obligations and compliance exposure."
    - name: "regulatory_compliant_record_count"
      expr: COUNT(CASE WHEN regulatory_compliance_flag = TRUE THEN 1 END)
      comment: "Count of waste records meeting regulatory compliance requirements. Measures compliance rate across waste management operations."
    - name: "waste_record_count"
      expr: COUNT(1)
      comment: "Total number of waste generation records. Used to assess data completeness and facility coverage."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`sustainability_water_consumption`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Water consumption and stewardship KPIs tracking withdrawal, discharge, recycling rates, and water-stress exposure. Used by operations and sustainability teams to manage water risk, track water reduction targets, and report under CDP Water and GRI 303 frameworks."
  source: "`vibe_consumer_goods_v1`.`sustainability`.`water_consumption`"
  dimensions:
    - name: "water_source_type"
      expr: water_source_type
      comment: "Source of water withdrawal (municipal, groundwater, surface water, rainwater) — critical for water risk and stewardship reporting."
    - name: "water_stress_area_flag"
      expr: water_stress_area_flag
      comment: "Indicates whether the facility is in a water-stressed area — highest-priority dimension for water risk management."
    - name: "water_consumption_status"
      expr: water_consumption_status
      comment: "Status of the water consumption record — filter to approved records for reporting."
    - name: "water_quality_indicator"
      expr: water_quality_indicator
      comment: "Quality classification of water consumed or discharged — supports water quality stewardship reporting."
    - name: "discharge_destination"
      expr: discharge_destination
      comment: "Destination of discharged water (municipal sewer, surface water, groundwater) — required for environmental permit compliance."
    - name: "measurement_period_start_month"
      expr: DATE_TRUNC('MONTH', measurement_period_start)
      comment: "Month of measurement period start — enables monthly water consumption trend analysis."
    - name: "measurement_method"
      expr: measurement_method
      comment: "Method used to measure water consumption (meter, estimate, calculation) — data quality indicator."
  measures:
    - name: "total_consumption_volume_m3"
      expr: SUM(CAST(consumption_volume_m3 AS DOUBLE))
      comment: "Total water consumed in cubic metres. Primary KPI for absolute water reduction targets and CDP Water disclosure."
    - name: "total_withdrawal_volume_m3"
      expr: SUM(CAST(withdrawal_volume_m3 AS DOUBLE))
      comment: "Total water withdrawn from all sources in cubic metres. Measures gross water intake before recycling — key for water stewardship reporting."
    - name: "total_discharge_volume_m3"
      expr: SUM(CAST(discharge_volume_m3 AS DOUBLE))
      comment: "Total water discharged in cubic metres. Combined with withdrawal, enables net water consumption calculation."
    - name: "avg_water_recycling_rate_pct"
      expr: AVG(CAST(water_recycling_rate_pct AS DOUBLE))
      comment: "Average water recycling rate across facilities. Tracks circular water use efficiency — key metric for water stewardship programs."
    - name: "water_stressed_area_consumption_m3"
      expr: SUM(CASE WHEN water_stress_area_flag = TRUE THEN consumption_volume_m3 ELSE 0 END)
      comment: "Total water consumed in water-stressed areas. Highest-priority water risk KPI — used to prioritize reduction investments in high-risk locations."
    - name: "avg_carbon_footprint_kg_co2e"
      expr: AVG(CAST(carbon_footprint_kg_co2e AS DOUBLE))
      comment: "Average carbon footprint associated with water consumption in kg CO2e. Links water and carbon footprints for integrated environmental reporting."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`sustainability_esg_commitment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "ESG commitment portfolio KPIs tracking target setting, progress, and disclosure status. Used by the Chief Sustainability Officer and board to monitor the organization's ESG commitment pipeline, target ambition levels, and governance of sustainability pledges."
  source: "`vibe_consumer_goods_v1`.`sustainability`.`esg_commitment`"
  dimensions:
    - name: "commitment_type"
      expr: commitment_type
      comment: "Type of ESG commitment (climate, water, biodiversity, social, governance) — primary dimension for portfolio analysis."
    - name: "commitment_scope"
      expr: commitment_scope
      comment: "Organizational scope of the commitment (global, regional, business unit) — used to assess coverage and accountability."
    - name: "esg_commitment_status"
      expr: esg_commitment_status
      comment: "Current status of the commitment (active, achieved, at-risk, expired) — primary filter for portfolio health monitoring."
    - name: "reporting_framework"
      expr: reporting_framework
      comment: "External framework the commitment aligns to (SBTi, CDP, GRI, TCFD) — required for multi-framework disclosure management."
    - name: "disclosure_status"
      expr: disclosure_status
      comment: "Public disclosure status of the commitment — tracks transparency and external reporting obligations."
    - name: "target_year"
      expr: target_year
      comment: "Year by which the commitment target must be achieved — enables time-horizon analysis of the commitment portfolio."
    - name: "baseline_year"
      expr: baseline_year
      comment: "Baseline year for the commitment — used to calculate absolute reduction from baseline."
    - name: "verification_method"
      expr: verification_method
      comment: "Method used to verify commitment progress (third-party audit, self-reported) — data quality and credibility indicator."
  measures:
    - name: "active_commitment_count"
      expr: COUNT(CASE WHEN esg_commitment_status = 'Active' THEN 1 END)
      comment: "Number of currently active ESG commitments. Measures the breadth of the organization's sustainability agenda."
    - name: "total_commitment_count"
      expr: COUNT(1)
      comment: "Total number of ESG commitments across all statuses. Baseline for portfolio coverage and governance reporting."
    - name: "avg_target_value"
      expr: AVG(CAST(target_value AS DOUBLE))
      comment: "Average target value across commitments. Provides a normalized view of ambition levels across the commitment portfolio."
    - name: "avg_baseline_value"
      expr: AVG(CAST(baseline_value AS DOUBLE))
      comment: "Average baseline value across commitments. Used alongside target value to assess the scale of required change."
    - name: "disclosed_commitment_count"
      expr: COUNT(CASE WHEN disclosure_status = 'Disclosed' THEN 1 END)
      comment: "Count of publicly disclosed commitments. Measures transparency and external accountability of the ESG program."
    - name: "commitment_disclosure_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN disclosure_status = 'Disclosed' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of ESG commitments that are publicly disclosed. Key governance KPI — low rates indicate transparency gaps."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`sustainability_commitment_progress`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "ESG commitment progress tracking KPIs measuring actual vs. target performance and trajectory status. Used by sustainability managers and executives to identify at-risk commitments, celebrate achievements, and reallocate resources to lagging programs."
  source: "`vibe_consumer_goods_v1`.`sustainability`.`commitment_progress`"
  dimensions:
    - name: "period_type"
      expr: period_type
      comment: "Type of reporting period (annual, quarterly, monthly) — used to align progress data with governance cadences."
    - name: "trajectory_status"
      expr: trajectory_status
      comment: "Assessment of whether the commitment is on-track, ahead, or behind target trajectory — primary executive alert dimension."
    - name: "record_status"
      expr: record_status
      comment: "Status of the progress record (approved, draft, under review) — filter to approved records for reporting."
    - name: "verification_status"
      expr: verification_status
      comment: "Third-party verification status of the progress measurement — distinguishes assured data from self-reported estimates."
    - name: "reporting_boundary"
      expr: reporting_boundary
      comment: "Organizational boundary for the progress measurement (operational control, equity share, etc.) — required for GHG Protocol compliance."
    - name: "period_end_date_month"
      expr: DATE_TRUNC('MONTH', period_end_date)
      comment: "Month of the progress measurement period end — enables time-series tracking of commitment trajectories."
    - name: "unit_of_measure"
      expr: unit_of_measure
      comment: "Unit of measurement for the progress values — required for cross-commitment comparability."
  measures:
    - name: "avg_percentage_of_target"
      expr: AVG(CAST(percentage_of_target AS DOUBLE))
      comment: "Average percentage of target achieved across all commitments. Primary KPI for portfolio-level ESG target attainment — used in board and investor reporting."
    - name: "total_actual_value"
      expr: SUM(CAST(actual_value AS DOUBLE))
      comment: "Sum of actual performance values across all commitment progress records. Aggregated baseline for target gap analysis."
    - name: "total_target_value"
      expr: SUM(CAST(target_value AS DOUBLE))
      comment: "Sum of target values across all commitment progress records. Used with actual value to compute aggregate target gap."
    - name: "on_track_commitment_count"
      expr: COUNT(CASE WHEN trajectory_status = 'On Track' THEN 1 END)
      comment: "Count of commitments currently on track to meet their targets. Key health indicator for the ESG program portfolio."
    - name: "at_risk_commitment_count"
      expr: COUNT(CASE WHEN trajectory_status = 'At Risk' THEN 1 END)
      comment: "Count of commitments at risk of missing their targets. Triggers executive intervention and resource reallocation decisions."
    - name: "verified_progress_record_count"
      expr: COUNT(CASE WHEN verification_status = 'Verified' THEN 1 END)
      comment: "Count of progress records with third-party verification. Measures data assurance coverage — critical for external disclosure credibility."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`sustainability_supplier_esg_eval`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Supplier ESG evaluation KPIs tracking environmental, social, and governance scores across the supply base. Used by procurement and sustainability teams to manage supplier risk, prioritize engagement, and meet Scope 3 supply chain disclosure requirements."
  source: "`vibe_consumer_goods_v1`.`sustainability`.`supplier_esg_eval`"
  dimensions:
    - name: "assessment_type"
      expr: assessment_type
      comment: "Type of ESG assessment conducted (desk review, on-site audit, self-assessment) — determines rigor and reliability of scores."
    - name: "supplier_risk_level"
      expr: supplier_risk_level
      comment: "Overall ESG risk classification of the supplier (high, medium, low) — primary dimension for supply chain risk management."
    - name: "overall_score_category"
      expr: overall_score_category
      comment: "Categorical rating of the overall ESG score (e.g., Leader, Adequate, Laggard) — used for supplier segmentation and engagement prioritization."
    - name: "supplier_esg_eval_status"
      expr: supplier_esg_eval_status
      comment: "Status of the evaluation record (completed, in-progress, overdue) — filter to completed evaluations for scoring analysis."
    - name: "iso_14001_compliance"
      expr: iso_14001_compliance
      comment: "Whether the supplier holds ISO 14001 environmental management certification — key quality indicator for environmental performance."
    - name: "corrective_action_required"
      expr: corrective_action_required
      comment: "Indicates whether a corrective action plan is required — triggers supplier development and monitoring activities."
    - name: "assessment_date_year"
      expr: DATE_TRUNC('YEAR', assessment_date)
      comment: "Year of the ESG assessment — enables year-over-year supplier performance trend analysis."
    - name: "scope_3_included"
      expr: scope_3_included
      comment: "Indicates whether Scope 3 emissions were included in the assessment — measures depth of supply chain emissions coverage."
  measures:
    - name: "avg_overall_esg_score"
      expr: AVG(CAST(overall_score AS DOUBLE))
      comment: "Average overall ESG score across evaluated suppliers. Primary KPI for supply chain sustainability performance — used in Scope 3 and supplier sustainability reports."
    - name: "avg_environmental_score"
      expr: AVG(CAST(environmental_score AS DOUBLE))
      comment: "Average environmental pillar score. Tracks environmental performance of the supply base — key input for Scope 3 emissions management."
    - name: "avg_social_score"
      expr: AVG(CAST(social_score AS DOUBLE))
      comment: "Average social pillar score. Monitors labor practices and human rights performance across the supply chain."
    - name: "avg_governance_score"
      expr: AVG(CAST(governance_score AS DOUBLE))
      comment: "Average governance pillar score. Tracks anti-corruption, transparency, and ethics performance of suppliers."
    - name: "high_risk_supplier_count"
      expr: COUNT(CASE WHEN supplier_risk_level = 'High' THEN 1 END)
      comment: "Count of suppliers classified as high ESG risk. Drives prioritization of supplier engagement and audit resources."
    - name: "corrective_action_required_count"
      expr: COUNT(CASE WHEN corrective_action_required = TRUE THEN 1 END)
      comment: "Count of supplier evaluations requiring corrective action. Measures the scale of supply chain remediation needed."
    - name: "iso_14001_certified_supplier_count"
      expr: COUNT(CASE WHEN iso_14001_compliance = TRUE THEN 1 END)
      comment: "Count of suppliers with ISO 14001 environmental management certification. Tracks environmental management maturity across the supply base."
    - name: "avg_carbon_emission_score"
      expr: AVG(CAST(carbon_emission_score AS DOUBLE))
      comment: "Average carbon emission score across supplier evaluations. Tracks supply chain decarbonization performance — key for Scope 3 Category 1 reporting."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`sustainability_esg_audit`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "ESG audit KPIs tracking audit outcomes, findings severity, and corrective action status. Used by compliance, sustainability, and internal audit teams to manage ESG assurance programs, track certification impacts, and ensure regulatory compliance."
  source: "`vibe_consumer_goods_v1`.`sustainability`.`esg_audit`"
  dimensions:
    - name: "audit_type"
      expr: audit_type
      comment: "Type of ESG audit (internal, external, certification, regulatory) — primary dimension for audit program management."
    - name: "audit_status"
      expr: audit_status
      comment: "Current status of the audit (planned, in-progress, completed, overdue) — operational management dimension."
    - name: "overall_result"
      expr: overall_result
      comment: "Overall audit outcome (pass, conditional pass, fail) — primary KPI dimension for compliance performance."
    - name: "compliance_status"
      expr: compliance_status
      comment: "Compliance determination from the audit — used to track regulatory and certification compliance rates."
    - name: "corrective_action_status"
      expr: corrective_action_status
      comment: "Status of corrective actions arising from audit findings — tracks remediation progress."
    - name: "audit_certification_status"
      expr: audit_certification_status
      comment: "Certification outcome of the audit — tracks certification attainment and renewal status."
    - name: "reporting_year"
      expr: reporting_year
      comment: "Reporting year of the audit — enables year-over-year audit performance trend analysis."
    - name: "risk_severity"
      expr: risk_severity
      comment: "Risk severity classification of audit findings (critical, major, minor) — prioritizes remediation actions."
  measures:
    - name: "total_audit_count"
      expr: COUNT(1)
      comment: "Total number of ESG audits conducted. Measures the scale and coverage of the ESG assurance program."
    - name: "avg_audit_duration_hours"
      expr: AVG(CAST(audit_duration_hours AS DOUBLE))
      comment: "Average audit duration in hours. Tracks audit efficiency and resource utilization across the assurance program."
    - name: "compliant_audit_count"
      expr: COUNT(CASE WHEN compliance_status = 'Compliant' THEN 1 END)
      comment: "Count of audits resulting in a compliant determination. Primary KPI for ESG compliance performance."
    - name: "audit_compliance_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN compliance_status = 'Compliant' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of audits resulting in compliance. Key governance KPI — declining rates trigger program-level interventions."
    - name: "open_corrective_action_count"
      expr: COUNT(CASE WHEN corrective_action_status NOT IN ('Closed', 'Completed') THEN 1 END)
      comment: "Count of audits with open corrective actions. Measures remediation backlog — high counts indicate systemic compliance gaps."
    - name: "certification_impact_count"
      expr: COUNT(CASE WHEN certification_impact_flag = TRUE THEN 1 END)
      comment: "Count of audits with findings that impact certification status. Tracks certification risk exposure across the facility portfolio."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`sustainability_circular_initiative`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Circular economy initiative KPIs tracking material recovery, waste reduction, carbon avoidance, and investment returns. Used by sustainability and operations teams to evaluate circular program effectiveness, prioritize investments, and report on packaging and material circularity targets."
  source: "`vibe_consumer_goods_v1`.`sustainability`.`circular_initiative`"
  dimensions:
    - name: "program_type"
      expr: program_type
      comment: "Type of circular economy program (recycling, reuse, refurbishment, composting) — primary dimension for initiative portfolio analysis."
    - name: "circular_initiative_status"
      expr: circular_initiative_status
      comment: "Current status of the initiative (active, completed, planned, cancelled) — filter for active program performance."
    - name: "lifecycle_stage"
      expr: lifecycle_stage
      comment: "Product lifecycle stage targeted by the initiative (design, production, use, end-of-life) — aligns initiatives to circular economy framework."
    - name: "geographic_scope"
      expr: geographic_scope
      comment: "Geographic scope of the initiative (global, regional, country, facility) — used for regional performance benchmarking."
    - name: "reporting_framework"
      expr: reporting_framework
      comment: "External reporting framework the initiative contributes to (Ellen MacArthur Foundation, GRI 306, etc.)."
    - name: "progress_status"
      expr: progress_status
      comment: "Progress status of the initiative (on-track, behind, ahead, completed) — executive alert dimension."
    - name: "launch_date_year"
      expr: DATE_TRUNC('YEAR', launch_date)
      comment: "Year the initiative was launched — enables cohort analysis of initiative performance by vintage."
  measures:
    - name: "total_material_recovered_tonnes"
      expr: SUM(CAST(material_recovered_tonnes AS DOUBLE))
      comment: "Total material recovered through circular initiatives in metric tonnes. Primary KPI for circular economy material recovery targets."
    - name: "total_material_diverted_tonnes"
      expr: SUM(CAST(material_diverted_tonnes AS DOUBLE))
      comment: "Total material diverted from waste streams in metric tonnes. Measures the scale of waste prevention achieved."
    - name: "total_waste_reduction_tonnes"
      expr: SUM(CAST(waste_reduction_tonnes AS DOUBLE))
      comment: "Total waste reduction achieved in metric tonnes. Direct measure of circular economy program impact on waste generation."
    - name: "total_carbon_footprint_avoided_tonnes"
      expr: SUM(CAST(carbon_footprint_avoided_tonnes AS DOUBLE))
      comment: "Total CO2e avoided through circular initiatives in metric tonnes. Links circular economy programs to decarbonization targets."
    - name: "total_investment_amount_usd"
      expr: SUM(CAST(investment_amount_usd AS DOUBLE))
      comment: "Total financial investment in circular initiatives in USD. Used for ROI analysis and budget allocation decisions."
    - name: "avg_consumer_participation_rate_pct"
      expr: AVG(CAST(consumer_participation_rate_pct AS DOUBLE))
      comment: "Average consumer participation rate across circular initiatives. Measures consumer engagement effectiveness — low rates indicate need for program redesign."
    - name: "total_energy_savings_mwh"
      expr: SUM(CAST(energy_savings_mwh AS DOUBLE))
      comment: "Total energy savings achieved through circular initiatives in MWh. Quantifies the energy co-benefit of circular economy programs."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`sustainability_packaging_profile`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Packaging sustainability KPIs tracking recyclability, recycled content, carbon footprint, and regulatory compliance by SKU. Used by product development, sustainability, and regulatory teams to manage packaging sustainability targets, EU Packaging Regulation compliance, and consumer transparency commitments."
  source: "`vibe_consumer_goods_v1`.`sustainability`.`packaging_profile`"
  dimensions:
    - name: "component_type"
      expr: component_type
      comment: "Type of packaging component (primary, secondary, tertiary) — used to analyze sustainability performance by packaging layer."
    - name: "material_primary"
      expr: material_primary
      comment: "Primary material of the packaging (plastic, paper, glass, aluminum) — key dimension for material-specific sustainability targets."
    - name: "recyclability_rating"
      expr: recyclability_rating
      comment: "Recyclability rating of the packaging (e.g., widely recyclable, check locally, not recyclable) — primary consumer-facing sustainability KPI."
    - name: "packaging_profile_status"
      expr: packaging_profile_status
      comment: "Status of the packaging profile record (active, archived, under review) — filter to active profiles for current portfolio analysis."
    - name: "eu_packaging_waste_compliance_status"
      expr: eu_packaging_waste_compliance_status
      comment: "EU Packaging and Packaging Waste Regulation compliance status — critical for European market access."
    - name: "end_of_life_disposal_method"
      expr: end_of_life_disposal_method
      comment: "Intended end-of-life disposal method (recycle, compost, landfill, incinerate) — used for circular economy reporting."
    - name: "fsc_certified"
      expr: fsc_certified
      comment: "Indicates FSC certification for paper/wood-based packaging — tracks responsible sourcing compliance."
    - name: "reusable"
      expr: reusable
      comment: "Indicates whether the packaging is designed for reuse — tracks progress toward reusable packaging targets."
  measures:
    - name: "avg_recycled_content_pct"
      expr: AVG(CAST(recycled_content_percent AS DOUBLE))
      comment: "Average recycled content percentage across packaging profiles. Tracks progress toward recycled content targets (e.g., 30% PCR by 2025)."
    - name: "avg_pcr_content_pct"
      expr: AVG(CAST(material_composition_pcr_percent AS DOUBLE))
      comment: "Average post-consumer recycled (PCR) content percentage. Specifically tracks PCR targets which are often separately regulated and reported."
    - name: "avg_carbon_footprint_kg_co2e"
      expr: AVG(CAST(carbon_footprint_kg_co2e AS DOUBLE))
      comment: "Average carbon footprint per packaging unit in kg CO2e. Tracks packaging decarbonization progress and informs eco-design decisions."
    - name: "avg_sustainability_score"
      expr: AVG(CAST(sustainability_score AS DOUBLE))
      comment: "Average overall sustainability score across packaging profiles. Composite KPI for packaging portfolio sustainability performance."
    - name: "avg_lightweighting_reduction_pct"
      expr: AVG(CAST(lightweighting_reduction_percent AS DOUBLE))
      comment: "Average material reduction achieved through lightweighting. Measures packaging material efficiency improvement — reduces both cost and environmental impact."
    - name: "eu_compliant_packaging_count"
      expr: COUNT(CASE WHEN eu_packaging_waste_compliance_status = 'Compliant' THEN 1 END)
      comment: "Count of packaging profiles compliant with EU Packaging Waste Regulation. Tracks regulatory compliance for European market access."
    - name: "total_packaging_weight_grams"
      expr: SUM(CAST(packaging_weight_grams AS DOUBLE))
      comment: "Total packaging weight in grams across the portfolio. Baseline for absolute packaging material reduction targets."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`sustainability_deforestation_assessment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Deforestation risk assessment KPIs tracking forest cover change, certification coverage, and EUDR compliance across the supply base. Used by procurement and sustainability teams to manage deforestation-free sourcing commitments and comply with the EU Deforestation Regulation (EUDR)."
  source: "`vibe_consumer_goods_v1`.`sustainability`.`deforestation_assessment`"
  dimensions:
    - name: "commodity_type"
      expr: commodity_type
      comment: "Type of forest-risk commodity (palm oil, soy, beef, timber, cocoa, coffee, rubber) — primary dimension for deforestation risk management."
    - name: "eudr_compliance_status"
      expr: eudr_compliance_status
      comment: "EU Deforestation Regulation compliance status — critical regulatory dimension for European market access."
    - name: "assessment_status"
      expr: assessment_status
      comment: "Status of the deforestation assessment (completed, in-progress, overdue) — operational management dimension."
    - name: "certification_type"
      expr: certification_type
      comment: "Type of sustainability certification held (RSPO, FSC, RTRS, etc.) — measures supply chain certification coverage."
    - name: "traceability_level"
      expr: traceability_level
      comment: "Level of supply chain traceability achieved (farm-level, mill-level, country-level) — key indicator for deforestation-free claims."
    - name: "sourcing_region"
      expr: sourcing_region
      comment: "Geographic region of commodity sourcing — used to map deforestation risk to high-risk geographies."
    - name: "remediation_action_required"
      expr: remediation_action_required
      comment: "Indicates whether remediation action is required — triggers supplier engagement and sourcing decisions."
  measures:
    - name: "avg_risk_score"
      expr: AVG(CAST(risk_score AS DOUBLE))
      comment: "Average deforestation risk score across assessments. Primary KPI for supply chain deforestation risk exposure — used to prioritize supplier engagement."
    - name: "avg_forest_cover_change_pct"
      expr: AVG(CAST(forest_cover_change_percent AS DOUBLE))
      comment: "Average forest cover change percentage across assessed sourcing areas. Measures actual deforestation impact in the supply chain."
    - name: "avg_certification_coverage_pct"
      expr: AVG(CAST(certification_coverage_percent AS DOUBLE))
      comment: "Average certification coverage percentage across assessments. Tracks progress toward 100% certified sustainable sourcing targets."
    - name: "eudr_compliant_assessment_count"
      expr: COUNT(CASE WHEN eudr_compliance_status = 'Compliant' THEN 1 END)
      comment: "Count of assessments meeting EUDR compliance requirements. Tracks regulatory compliance for EU market access — non-compliance risks market exclusion."
    - name: "remediation_required_count"
      expr: COUNT(CASE WHEN remediation_action_required = TRUE THEN 1 END)
      comment: "Count of assessments requiring remediation action. Measures the scale of supply chain deforestation remediation needed."
    - name: "total_forest_area_ha"
      expr: SUM(CAST(forest_area_ha AS DOUBLE))
      comment: "Total forest area covered by assessments in hectares. Measures the geographic scope of deforestation risk management."
    - name: "avg_carbon_emission_estimate_tonnes"
      expr: AVG(CAST(carbon_emission_estimate_tonnes AS DOUBLE))
      comment: "Average estimated carbon emissions from deforestation in assessed areas. Links deforestation risk to Scope 3 land-use change emissions."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`sustainability_biodiversity_impact`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Biodiversity impact assessment KPIs tracking net biodiversity scores, land use, and TNFD disclosure readiness. Used by sustainability and regulatory teams to manage nature-related risks, meet TNFD disclosure requirements, and track biodiversity net gain commitments."
  source: "`vibe_consumer_goods_v1`.`sustainability`.`biodiversity_impact`"
  dimensions:
    - name: "biodiversity_impact_category"
      expr: biodiversity_impact_category
      comment: "Category of biodiversity impact (habitat loss, species impact, water quality, soil degradation) — primary dimension for nature risk analysis."
    - name: "assessment_status"
      expr: assessment_status
      comment: "Status of the biodiversity assessment (approved, in-review, draft) — filter to approved assessments for reporting."
    - name: "land_use_type"
      expr: land_use_type
      comment: "Type of land use associated with the impact (agricultural, industrial, urban, protected) — key dimension for TNFD reporting."
    - name: "tnfd_risk_classification"
      expr: tnfd_risk_classification
      comment: "TNFD nature-related risk classification — primary dimension for TNFD disclosure and investor reporting."
    - name: "tnfd_disclosure_flag"
      expr: tnfd_disclosure_flag
      comment: "Indicates whether the assessment is included in TNFD disclosure — tracks TNFD reporting coverage."
    - name: "regulatory_reporting_flag"
      expr: regulatory_reporting_flag
      comment: "Indicates whether the assessment triggers regulatory reporting obligations — compliance management dimension."
    - name: "assessment_date_year"
      expr: DATE_TRUNC('YEAR', assessment_date)
      comment: "Year of the biodiversity assessment — enables year-over-year nature impact trend analysis."
  measures:
    - name: "avg_net_biodiversity_impact_score"
      expr: AVG(CAST(net_biodiversity_impact_score AS DOUBLE))
      comment: "Average net biodiversity impact score across assessments. Primary KPI for biodiversity net gain/loss tracking — used in TNFD and nature-related disclosures."
    - name: "total_land_use_area_ha"
      expr: SUM(CAST(land_use_area_ha AS DOUBLE))
      comment: "Total land area under biodiversity impact assessment in hectares. Measures the geographic footprint of nature-related risk exposure."
    - name: "avg_proximity_to_protected_area_km"
      expr: AVG(CAST(proximity_to_protected_area_km AS DOUBLE))
      comment: "Average proximity to protected areas in km. Lower values indicate higher sensitivity — used to prioritize mitigation investments."
    - name: "tnfd_disclosed_assessment_count"
      expr: COUNT(CASE WHEN tnfd_disclosure_flag = TRUE THEN 1 END)
      comment: "Count of assessments included in TNFD disclosure. Tracks TNFD reporting coverage — critical for investor and regulatory transparency."
    - name: "regulatory_reportable_count"
      expr: COUNT(CASE WHEN regulatory_reporting_flag = TRUE THEN 1 END)
      comment: "Count of biodiversity assessments triggering regulatory reporting. Measures regulatory compliance obligations from nature-related activities."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`sustainability_esg_disclosure`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "ESG disclosure KPIs aggregating reported environmental metrics across disclosure frameworks. Used by investor relations, sustainability, and legal teams to manage external ESG reporting quality, track disclosure completeness, and benchmark against framework requirements (GRI, TCFD, CSRD, CDP)."
  source: "`vibe_consumer_goods_v1`.`sustainability`.`esg_disclosure`"
  dimensions:
    - name: "framework"
      expr: framework
      comment: "ESG reporting framework used for the disclosure (GRI, TCFD, CSRD, CDP, SASB) — primary dimension for multi-framework reporting management."
    - name: "esg_disclosure_status"
      expr: esg_disclosure_status
      comment: "Status of the disclosure (submitted, approved, draft, under review) — filter to submitted/approved disclosures for reporting."
    - name: "assurance_level"
      expr: assurance_level
      comment: "Level of external assurance obtained (limited, reasonable, none) — quality indicator for disclosure credibility."
    - name: "reporting_year"
      expr: reporting_year
      comment: "Reporting year of the disclosure — primary time dimension for year-over-year ESG performance comparison."
    - name: "reporting_quarter"
      expr: reporting_quarter
      comment: "Reporting quarter — supports intra-year disclosure tracking."
    - name: "fsc_certified"
      expr: fsc_certified
      comment: "FSC certification status reported in the disclosure — tracks responsible sourcing claims."
    - name: "rspo_certified"
      expr: rspo_certified
      comment: "RSPO certification status reported in the disclosure — tracks sustainable palm oil sourcing claims."
  measures:
    - name: "total_scope1_emissions"
      expr: SUM(CAST(carbon_emissions_scope1 AS DOUBLE))
      comment: "Total Scope 1 (direct) carbon emissions reported in disclosures. Primary regulatory and investor KPI for direct emissions accountability."
    - name: "total_scope2_emissions"
      expr: SUM(CAST(carbon_emissions_scope2 AS DOUBLE))
      comment: "Total Scope 2 (indirect energy) carbon emissions reported. Tracks purchased energy emissions — key for renewable energy transition reporting."
    - name: "total_scope3_emissions"
      expr: SUM(CAST(carbon_emissions_scope3 AS DOUBLE))
      comment: "Total Scope 3 (value chain) carbon emissions reported. Largest emissions category for most consumer goods companies — critical for supply chain decarbonization."
    - name: "total_carbon_emissions_all_scopes"
      expr: SUM(CAST(total_carbon_emissions AS DOUBLE))
      comment: "Total carbon emissions across all scopes as reported in disclosures. Headline KPI for absolute emissions reduction tracking."
    - name: "avg_renewable_energy_pct"
      expr: AVG(CAST(renewable_energy_percentage AS DOUBLE))
      comment: "Average renewable energy percentage reported across disclosures. Tracks RE100 and renewable energy target progress."
    - name: "avg_packaging_recyclability_rate"
      expr: AVG(CAST(packaging_recyclability_rate AS DOUBLE))
      comment: "Average packaging recyclability rate reported. Tracks packaging sustainability commitments — key consumer goods industry KPI."
    - name: "total_waste_generated"
      expr: SUM(CAST(waste_generated AS DOUBLE))
      comment: "Total waste generated as reported in ESG disclosures. Tracks absolute waste reduction targets across reporting periods."
    - name: "total_water_consumption_disclosed"
      expr: SUM(CAST(water_consumption AS DOUBLE))
      comment: "Total water consumption as reported in ESG disclosures. Tracks water stewardship commitments and CDP Water disclosure requirements."
$$;