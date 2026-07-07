-- Metric views for domain: sustainability | Business: Construction | Version: 2 | Generated on: 2026-06-28 00:14:33

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`sustainability_biodiversity_assessment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tracks biodiversity net gain, habitat quality, and monitoring status to meet regulatory and ESG biodiversity commitments."
  source: "`vibe_construction_v1`.`sustainability`.`biodiversity_assessment`"
  dimensions:
    - name: "assessment_type"
      expr: assessment_type
      comment: "Type of biodiversity assessment (Baseline, Impact, Mitigation, Post-Construction) for lifecycle analysis."
    - name: "assessment_status"
      expr: assessment_status
      comment: "Current status of the assessment (Draft, Approved, Superseded) for governance tracking."
    - name: "monitoring_status"
      expr: monitoring_status
      comment: "Status of ongoing biodiversity monitoring (Active, Completed, Not Started)."
    - name: "statutory_approval_status"
      expr: statutory_approval_status
      comment: "Regulatory approval status — non-approval blocks construction activity."
    - name: "verification_status"
      expr: verification_status
      comment: "Independent verification status for ESG assurance."
    - name: "mitigation_hierarchy_applied"
      expr: mitigation_hierarchy_applied
      comment: "Whether the mitigation hierarchy (avoid, mitigate, restore, offset) was applied — regulatory best practice indicator."
  measures:
    - name: "total_biodiversity_units_gained"
      expr: SUM(CAST(biodiversity_units_gained AS DOUBLE))
      comment: "Total biodiversity units gained across all assessments — headline biodiversity net gain metric for regulatory compliance."
    - name: "total_biodiversity_units_lost"
      expr: SUM(CAST(biodiversity_units_lost AS DOUBLE))
      comment: "Total biodiversity units lost — quantifies ecological impact of construction activities."
    - name: "net_biodiversity_units_total"
      expr: SUM(CAST(net_biodiversity_units AS DOUBLE))
      comment: "Net biodiversity units (gained minus lost) — primary biodiversity net gain KPI for regulatory reporting."
    - name: "total_habitat_area_ha"
      expr: SUM(CAST(habitat_area_ha AS DOUBLE))
      comment: "Total habitat area assessed in hectares — scale indicator for biodiversity programme."
    - name: "avg_habitat_quality_score"
      expr: AVG(CAST(habitat_quality_score AS DOUBLE))
      comment: "Average habitat quality score across assessments — ecological condition benchmark."
    - name: "avg_biodiversity_units_per_ha"
      expr: AVG(CAST(biodiversity_units_per_ha AS DOUBLE))
      comment: "Average biodiversity units per hectare — intensity metric for habitat quality benchmarking."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`sustainability_carbon_emission`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tracks greenhouse gas emissions by scope, source category, and project to support decarbonisation targets and regulatory reporting."
  source: "`vibe_construction_v1`.`sustainability`.`carbon_emission`"
  dimensions:
    - name: "emission_scope"
      expr: scope
      comment: "GHG Protocol scope classification (Scope 1, 2, or 3) for regulatory and ESG reporting segmentation."
    - name: "source_category"
      expr: source_category
      comment: "High-level category of the emission source (e.g. fuel combustion, electricity, transport) for hotspot analysis."
    - name: "source_type"
      expr: source_type
      comment: "Specific type of emission source enabling granular root-cause analysis."
    - name: "measurement_method"
      expr: measurement_method
      comment: "Method used to quantify emissions (e.g. metered, estimated, calculated) indicating data quality."
    - name: "verification_status"
      expr: verification_status
      comment: "Whether the emission record has been independently verified, critical for ESG assurance."
    - name: "reporting_period_start"
      expr: reporting_period_start
      comment: "Start of the reporting period for time-series trend analysis."
    - name: "reporting_period_end"
      expr: reporting_period_end
      comment: "End of the reporting period for period-over-period comparison."
  measures:
    - name: "total_co2e_tonnes"
      expr: SUM(CAST(co2e_tonnes AS DOUBLE))
      comment: "Total carbon dioxide equivalent emissions in tonnes — primary KPI for decarbonisation tracking and net-zero progress."
    - name: "avg_co2e_per_activity_unit"
      expr: AVG(co2e_tonnes / NULLIF(activity_quantity, 0))
      comment: "Average emission intensity per unit of activity, indicating operational efficiency improvements over time."
    - name: "total_activity_quantity"
      expr: SUM(CAST(activity_quantity AS DOUBLE))
      comment: "Total volume of emission-generating activity (fuel litres, kWh, km etc.) to contextualise emission totals."
    - name: "verified_emission_record_count"
      expr: COUNT(CASE WHEN verification_status = 'Verified' THEN carbon_emission_id END)
      comment: "Number of emission records with independent verification, indicating ESG data assurance coverage."
    - name: "unverified_emission_record_count"
      expr: COUNT(CASE WHEN verification_status != 'Verified' OR verification_status IS NULL THEN carbon_emission_id END)
      comment: "Number of unverified emission records representing assurance risk in regulatory submissions."
    - name: "scope1_co2e_tonnes"
      expr: SUM(CASE WHEN scope = 'Scope 1' THEN co2e_tonnes ELSE 0 END)
      comment: "Total direct (Scope 1) emissions in tCO2e — key metric for operational carbon control."
    - name: "scope2_co2e_tonnes"
      expr: SUM(CASE WHEN scope = 'Scope 2' THEN co2e_tonnes ELSE 0 END)
      comment: "Total indirect energy (Scope 2) emissions in tCO2e — informs renewable energy procurement decisions."
    - name: "scope3_co2e_tonnes"
      expr: SUM(CASE WHEN scope = 'Scope 3' THEN co2e_tonnes ELSE 0 END)
      comment: "Total value-chain (Scope 3) emissions in tCO2e — largest share for construction, drives supply chain engagement."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`sustainability_carbon_offset`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tracks carbon offset procurement, retirement, and quality to manage residual emissions and net-zero claims."
  source: "`vibe_construction_v1`.`sustainability`.`carbon_offset`"
  dimensions:
    - name: "carbon_offset_status"
      expr: carbon_offset_status
      comment: "Lifecycle status of the offset (Purchased, Retired, Cancelled) for portfolio management."
    - name: "credit_type"
      expr: credit_type
      comment: "Type of carbon credit (avoidance, removal, nature-based) for quality and permanence assessment."
    - name: "offset_standard"
      expr: offset_standard
      comment: "Certification standard (e.g. Gold Standard, VCS) indicating offset quality and credibility."
    - name: "vintage_year"
      expr: vintage_year
      comment: "Year the carbon reduction occurred — older vintages may carry reputational risk."
    - name: "project_country_code"
      expr: project_country_code
      comment: "Country of the offset project for geographic diversification and regulatory compliance."
    - name: "compliance_status"
      expr: compliance_status
      comment: "Whether the offset meets applicable compliance scheme requirements."
    - name: "is_retired"
      expr: is_retired
      comment: "Flag indicating whether the offset has been formally retired against an emission claim."
  measures:
    - name: "total_offset_quantity_tco2e"
      expr: SUM(CAST(quantity_tco2e AS DOUBLE))
      comment: "Total carbon offsets purchased in tCO2e — measures residual emission coverage strategy."
    - name: "total_retired_tco2e"
      expr: SUM(CASE WHEN is_retired = TRUE THEN quantity_tco2e ELSE 0 END)
      comment: "Total offsets formally retired against emission claims — the only quantity that can be used in net-zero assertions."
    - name: "total_purchase_cost_usd"
      expr: SUM(CAST(purchase_price_usd AS DOUBLE))
      comment: "Total spend on carbon offsets in USD — financial exposure metric for sustainability budget management."
    - name: "avg_cost_per_tco2e_usd"
      expr: ROUND(SUM(CAST(purchase_price_usd AS DOUBLE)) / NULLIF(SUM(CAST(quantity_tco2e AS DOUBLE)), 0), 2)
      comment: "Average price paid per tonne of CO2e offset — benchmarks procurement efficiency against market rates."
    - name: "retirement_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN is_retired = TRUE THEN quantity_tco2e ELSE 0 END) / NULLIF(SUM(CAST(quantity_tco2e AS DOUBLE)), 0), 2)
      comment: "Percentage of purchased offsets that have been retired — indicates how much of the portfolio is actively deployed in net-zero claims."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`sustainability_carbon_reduction_initiative`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Evaluates the pipeline, cost-effectiveness, and delivery of carbon reduction initiatives to prioritise investment."
  source: "`vibe_construction_v1`.`sustainability`.`carbon_reduction_initiative`"
  dimensions:
    - name: "initiative_type"
      expr: initiative_type
      comment: "Type of initiative (e.g. fuel switching, efficiency, renewables) for portfolio categorisation."
    - name: "carbon_reduction_initiative_status"
      expr: carbon_reduction_initiative_status
      comment: "Current delivery status (Planned, In Progress, Completed, Cancelled) for pipeline management."
    - name: "verification_status"
      expr: verification_status
      comment: "Whether the claimed savings have been independently verified."
    - name: "climate_risk_category"
      expr: climate_risk_category
      comment: "Climate risk category addressed by the initiative for TCFD alignment."
    - name: "reporting_period_start"
      expr: reporting_period_start
      comment: "Start of the reporting period for trend analysis."
    - name: "reporting_period_end"
      expr: reporting_period_end
      comment: "End of the reporting period for period-over-period comparison."
  measures:
    - name: "total_projected_annual_co2e_saving"
      expr: SUM(CAST(projected_annual_co2e_saving AS DOUBLE))
      comment: "Total projected annual carbon savings across all initiatives — headline pipeline value for net-zero roadmap."
    - name: "total_actual_co2e_saving"
      expr: SUM(CAST(actual_co2e_saving AS DOUBLE))
      comment: "Total realised carbon savings — measures delivery against projected pipeline."
    - name: "co2e_delivery_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(actual_co2e_saving AS DOUBLE)) / NULLIF(SUM(CAST(projected_annual_co2e_saving AS DOUBLE)), 0), 2)
      comment: "Percentage of projected carbon savings actually delivered — key performance indicator for initiative effectiveness."
    - name: "total_implementation_cost"
      expr: SUM(CAST(implementation_cost AS DOUBLE))
      comment: "Total capital invested in carbon reduction initiatives — informs cost-of-abatement analysis."
    - name: "avg_payback_period_years"
      expr: AVG(CAST(payback_period_years AS DOUBLE))
      comment: "Average financial payback period across initiatives — guides investment prioritisation decisions."
    - name: "cost_per_tco2e_saved"
      expr: ROUND(SUM(CAST(actual_cost AS DOUBLE)) / NULLIF(SUM(CAST(actual_co2e_saving AS DOUBLE)), 0), 2)
      comment: "Cost per tonne of CO2e actually saved — marginal abatement cost metric used by sustainability executives to rank initiatives."
    - name: "total_funding_amount"
      expr: SUM(CAST(funding_amount AS DOUBLE))
      comment: "Total external or internal funding secured for initiatives — indicates financial resource mobilisation."
    - name: "active_initiative_count"
      expr: COUNT(CASE WHEN carbon_reduction_initiative_status = 'In Progress' THEN carbon_reduction_initiative_id END)
      comment: "Number of initiatives currently in delivery — operational pipeline health indicator."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`sustainability_carbon_target`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Monitors carbon reduction target setting, ambition levels, and SBTi alignment to steer net-zero strategy."
  source: "`vibe_construction_v1`.`sustainability`.`carbon_target`"
  dimensions:
    - name: "target_type"
      expr: target_type
      comment: "Classification of the target (absolute, intensity, net-zero) for strategic portfolio analysis."
    - name: "target_scope"
      expr: target_scope
      comment: "GHG scope coverage of the target (Scope 1+2, all scopes) indicating ambition breadth."
    - name: "lifecycle_status"
      expr: lifecycle_status
      comment: "Current status of the target (Active, Superseded, Achieved) for portfolio management."
    - name: "sbti_validation_status"
      expr: sbti_validation_status
      comment: "Science Based Targets initiative validation status — critical for investor and regulatory credibility."
    - name: "target_year"
      expr: target_year
      comment: "Year by which the target must be achieved, enabling milestone tracking."
    - name: "baseline_year"
      expr: baseline_year
      comment: "Reference year for measuring reduction progress."
    - name: "alignment_paris_pathway"
      expr: alignment_paris_pathway
      comment: "Alignment with Paris Agreement temperature pathway (1.5°C, well-below 2°C) for ESG disclosure."
  measures:
    - name: "total_baseline_emissions_tco2e"
      expr: SUM(CAST(baseline_emissions_tco2e AS DOUBLE))
      comment: "Aggregate baseline emissions across all targets — denominator for reduction progress calculations."
    - name: "total_target_value_tco2e"
      expr: SUM(CAST(target_value_tco2e AS DOUBLE))
      comment: "Aggregate committed target emission level in tCO2e — quantifies the scale of decarbonisation ambition."
    - name: "avg_target_reduction_pct"
      expr: AVG(CAST(target_reduction_pct AS DOUBLE))
      comment: "Average percentage reduction committed across all active targets — headline ambition indicator for board reporting."
    - name: "avg_target_intensity_value"
      expr: AVG(CAST(target_intensity_value AS DOUBLE))
      comment: "Average intensity target value (e.g. tCO2e per £m revenue) for benchmarking against industry peers."
    - name: "active_target_count"
      expr: COUNT(CASE WHEN lifecycle_status = 'Active' THEN carbon_target_id END)
      comment: "Number of currently active carbon targets — indicates governance maturity and commitment breadth."
    - name: "sbti_validated_target_count"
      expr: COUNT(CASE WHEN sbti_validation_status = 'Approved' THEN carbon_target_id END)
      comment: "Number of SBTi-validated targets — key ESG credibility metric for investor and rating agency reporting."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`sustainability_climate_risk_assessment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tracks climate risk exposure, financial impact, and mitigation status to support TCFD disclosure and strategic resilience planning."
  source: "`vibe_construction_v1`.`sustainability`.`climate_risk_assessment`"
  dimensions:
    - name: "assessment_type"
      expr: assessment_type
      comment: "Type of climate risk assessment (Physical, Transition, Liability) for TCFD category analysis."
    - name: "climate_risk_assessment_status"
      expr: climate_risk_assessment_status
      comment: "Current status of the assessment for governance tracking."
    - name: "risk_category"
      expr: risk_category
      comment: "High-level risk category (Physical, Transition, Reputational) for portfolio risk analysis."
    - name: "risk_subcategory"
      expr: risk_subcategory
      comment: "Specific risk subcategory for granular risk management."
    - name: "climate_scenario"
      expr: climate_scenario
      comment: "Climate scenario used (1.5°C, 2°C, 4°C) for scenario-based risk analysis."
    - name: "time_horizon"
      expr: time_horizon
      comment: "Time horizon of the risk (Short, Medium, Long term) for strategic planning."
    - name: "is_strategic_priority"
      expr: is_strategic_priority
      comment: "Flag indicating whether this is a strategic priority risk requiring board-level attention."
  measures:
    - name: "total_financial_impact_estimate"
      expr: SUM(CAST(financial_impact_estimate AS DOUBLE))
      comment: "Total estimated financial impact of climate risks — headline financial exposure metric for TCFD disclosure."
    - name: "avg_financial_impact_estimate"
      expr: AVG(CAST(financial_impact_estimate AS DOUBLE))
      comment: "Average financial impact per climate risk assessment — risk severity benchmark."
    - name: "avg_temperature_increase_estimate"
      expr: AVG(CAST(temperature_increase_estimate AS DOUBLE))
      comment: "Average temperature increase estimate across scenarios — physical risk exposure indicator."
    - name: "avg_sea_level_rise_estimate"
      expr: AVG(CAST(sea_level_rise_estimate AS DOUBLE))
      comment: "Average sea level rise estimate — coastal infrastructure physical risk metric."
    - name: "strategic_priority_risk_count"
      expr: COUNT(CASE WHEN is_strategic_priority = TRUE THEN climate_risk_assessment_id END)
      comment: "Number of strategic priority climate risks — board-level risk register size indicator."
    - name: "regulatory_change_risk_count"
      expr: COUNT(CASE WHEN regulatory_change_indicator = TRUE THEN climate_risk_assessment_id END)
      comment: "Number of risks flagged as driven by regulatory change — transition risk exposure metric for compliance planning."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`sustainability_embodied_carbon_assessment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tracks embodied carbon in construction materials and design to drive whole-life carbon reduction."
  source: "`vibe_construction_v1`.`sustainability`.`embodied_carbon_assessment`"
  dimensions:
    - name: "assessment_status"
      expr: assessment_status
      comment: "Status of the assessment (Draft, Approved, Superseded) for governance tracking."
    - name: "methodology"
      expr: methodology
      comment: "Assessment methodology (EN 15978, RICS WLCA) for comparability and regulatory compliance."
    - name: "riba_stage"
      expr: riba_stage
      comment: "RIBA design stage at which assessment was conducted — earlier stages enable greater carbon reduction."
    - name: "scope"
      expr: scope
      comment: "Assessment scope (A1-A5, A-C, whole life) for boundary consistency."
    - name: "is_verified"
      expr: is_verified
      comment: "Whether the assessment has been independently verified."
    - name: "related_project_phase"
      expr: related_project_phase
      comment: "Project phase for lifecycle carbon trend analysis."
  measures:
    - name: "total_embodied_carbon_tco2e"
      expr: SUM(CAST(total_embodied_carbon_tco2e AS DOUBLE))
      comment: "Total embodied carbon across all assessed projects in tCO2e — primary whole-life carbon KPI."
    - name: "avg_carbon_intensity_kg_per_m3"
      expr: AVG(CAST(carbon_intensity_kg_per_m3 AS DOUBLE))
      comment: "Average embodied carbon intensity per m3 — normalised metric for design benchmarking and target-setting."
    - name: "total_upfront_carbon_tco2e"
      expr: SUM(CAST(upfront_carbon_tco2e AS DOUBLE))
      comment: "Total upfront (A1-A5) embodied carbon — the portion controllable through material and design choices."
    - name: "total_operational_carbon_tco2e"
      expr: SUM(CAST(operational_carbon_tco2e AS DOUBLE))
      comment: "Total operational carbon across assessed projects — informs energy efficiency investment decisions."
    - name: "avg_renewable_material_pct"
      expr: AVG(CAST(renewable_material_percentage AS DOUBLE))
      comment: "Average renewable material content across assessments — circular economy and low-carbon material adoption metric."
    - name: "avg_waste_diversion_rate_pct"
      expr: AVG(CAST(waste_diversion_rate_percent AS DOUBLE))
      comment: "Average waste diversion rate from embodied carbon assessments — construction waste performance indicator."
    - name: "total_offset_quantity_tco2e"
      expr: SUM(CAST(offset_quantity_tco2e AS DOUBLE))
      comment: "Total carbon offsets applied to embodied carbon assessments — residual emission management metric."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`sustainability_energy_consumption`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Monitors energy use by type, project, and period to drive efficiency improvements and renewable energy transition."
  source: "`vibe_construction_v1`.`sustainability`.`energy_consumption`"
  dimensions:
    - name: "energy_type"
      expr: energy_type
      comment: "Type of energy consumed (diesel, grid electricity, natural gas, renewable) for fuel-switching analysis."
    - name: "energy_consumption_status"
      expr: energy_consumption_status
      comment: "Record status (Actual, Estimated, Corrected) indicating data quality for reporting."
    - name: "unit_of_measure"
      expr: unit_of_measure
      comment: "Unit of energy measurement (kWh, MWh, litres) for normalisation."
    - name: "metering_source"
      expr: metering_source
      comment: "Source of the energy reading (smart meter, manual, invoice) for data quality assessment."
    - name: "is_estimated"
      expr: is_estimated
      comment: "Flag indicating estimated vs. metered consumption — estimated data carries higher uncertainty."
    - name: "period_start_date"
      expr: period_start_date
      comment: "Start of the consumption period for time-series trend analysis."
    - name: "period_end_date"
      expr: period_end_date
      comment: "End of the consumption period for period-over-period comparison."
  measures:
    - name: "total_energy_consumption"
      expr: SUM(CAST(consumption_quantity AS DOUBLE))
      comment: "Total energy consumed across all sources — primary energy KPI for efficiency and renewable transition tracking."
    - name: "total_carbon_emission_kg"
      expr: SUM(CAST(carbon_emission_kg AS DOUBLE))
      comment: "Total carbon emissions attributable to energy consumption in kg — links energy use to GHG reporting."
    - name: "avg_energy_intensity"
      expr: AVG(CAST(energy_intensity AS DOUBLE))
      comment: "Average energy intensity (energy per unit of output) — key efficiency metric for benchmarking and target-setting."
    - name: "avg_carbon_emission_factor"
      expr: AVG(CAST(carbon_emission_factor AS DOUBLE))
      comment: "Average carbon emission factor across energy records — indicates grid decarbonisation progress and fuel mix quality."
    - name: "estimated_consumption_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_estimated = TRUE THEN energy_consumption_id END) / NULLIF(COUNT(energy_consumption_id), 0), 2)
      comment: "Percentage of consumption records that are estimated rather than metered — data quality risk indicator for ESG assurance."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`sustainability_env_incident`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tracks environmental incidents by type, severity, and regulatory notification status to manage compliance risk and operational impact."
  source: "`vibe_construction_v1`.`sustainability`.`env_incident`"
  dimensions:
    - name: "incident_type"
      expr: incident_type
      comment: "Type of environmental incident (spill, noise, dust, water pollution) for root-cause and trend analysis."
    - name: "severity_category"
      expr: severity_category
      comment: "Severity classification (Minor, Moderate, Major, Critical) for risk prioritisation."
    - name: "env_incident_status"
      expr: env_incident_status
      comment: "Incident lifecycle status (Open, Under Investigation, Closed) for management tracking."
    - name: "media_affected"
      expr: media_affected
      comment: "Environmental media affected (air, water, soil) for impact assessment."
    - name: "regulatory_notification_required"
      expr: regulatory_notification_required
      comment: "Flag indicating regulatory notification obligation — non-compliance risk indicator."
    - name: "is_near_miss"
      expr: is_near_miss
      comment: "Near-miss flag — leading indicator of environmental risk before actual incidents occur."
    - name: "mitigation_status"
      expr: mitigation_status
      comment: "Status of mitigation actions — indicates response effectiveness."
  measures:
    - name: "total_estimated_impact_amount"
      expr: SUM(CAST(estimated_impact_amount AS DOUBLE))
      comment: "Total estimated financial impact of environmental incidents — liability and remediation cost exposure metric."
    - name: "regulatory_notification_count"
      expr: COUNT(CASE WHEN regulatory_notification_required = TRUE THEN env_incident_id END)
      comment: "Number of incidents requiring regulatory notification — compliance obligation tracking metric."
    - name: "near_miss_count"
      expr: COUNT(CASE WHEN is_near_miss = TRUE THEN env_incident_id END)
      comment: "Number of near-miss environmental events — leading indicator for proactive risk management."
    - name: "open_incident_count"
      expr: COUNT(CASE WHEN env_incident_status = 'Open' THEN env_incident_id END)
      comment: "Number of currently open environmental incidents — operational risk exposure requiring active management."
    - name: "avg_impact_per_incident"
      expr: AVG(CAST(estimated_impact_amount AS DOUBLE))
      comment: "Average financial impact per environmental incident — severity benchmark for risk provisioning."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`sustainability_esg_disclosure_item`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tracks granular ESG disclosure indicators for framework compliance, data quality, and assurance coverage."
  source: "`vibe_construction_v1`.`sustainability`.`esg_disclosure_item`"
  dimensions:
    - name: "framework"
      expr: framework
      comment: "ESG reporting framework (GRI, SASB, TCFD, CSRD) for framework-specific completeness analysis."
    - name: "indicator_code"
      expr: indicator_code
      comment: "Specific framework indicator code for granular compliance tracking."
    - name: "emission_scope"
      expr: emission_scope
      comment: "GHG scope for emission-related disclosures."
    - name: "esg_disclosure_item_status"
      expr: esg_disclosure_item_status
      comment: "Status of the disclosure item (Draft, Approved, Submitted, Restated)."
    - name: "verification_status"
      expr: verification_status
      comment: "External verification status — critical for assurance coverage reporting."
    - name: "data_quality_flag"
      expr: data_quality_flag
      comment: "Data quality indicator for identifying items requiring remediation before submission."
    - name: "reporting_period_start"
      expr: reporting_period_start
      comment: "Start of the disclosure reporting period."
    - name: "is_key_metric"
      expr: is_key_metric
      comment: "Flag indicating whether this is a key headline metric for executive reporting."
  measures:
    - name: "total_reported_value"
      expr: SUM(CAST(reported_value AS DOUBLE))
      comment: "Sum of all reported numeric indicator values — aggregate ESG performance across all disclosures."
    - name: "total_monetary_value"
      expr: SUM(CAST(monetary_value AS DOUBLE))
      comment: "Total monetary value of ESG disclosures — financial materiality of sustainability performance."
    - name: "verified_disclosure_count"
      expr: COUNT(CASE WHEN verification_status = 'Verified' THEN esg_disclosure_item_id END)
      comment: "Number of independently verified disclosure items — assurance coverage metric for regulatory submissions."
    - name: "restated_disclosure_count"
      expr: COUNT(CASE WHEN restated = TRUE THEN esg_disclosure_item_id END)
      comment: "Number of restated disclosures — data quality and governance risk indicator."
    - name: "key_metric_count"
      expr: COUNT(CASE WHEN is_key_metric = TRUE THEN esg_disclosure_item_id END)
      comment: "Number of key headline metrics disclosed — completeness indicator for ESG framework compliance."
    - name: "avg_confidence_interval_range"
      expr: AVG(confidence_interval_high - confidence_interval_low)
      comment: "Average confidence interval width across disclosures — data precision and uncertainty indicator for assurance purposes."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`sustainability_esg_report`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Provides executive-level ESG performance summary metrics for board reporting, investor relations, and regulatory disclosure."
  source: "`vibe_construction_v1`.`sustainability`.`esg_report`"
  dimensions:
    - name: "reporting_framework"
      expr: reporting_framework
      comment: "ESG framework used (GRI, TCFD, CSRD, CDP) for framework-specific performance analysis."
    - name: "publication_status"
      expr: publication_status
      comment: "Publication lifecycle status (Draft, Published, Submitted) for governance tracking."
    - name: "assurance_level"
      expr: assurance_level
      comment: "Level of external assurance (None, Limited, Reasonable) — critical for investor credibility."
    - name: "net_zero_commitment_status"
      expr: net_zero_commitment_status
      comment: "Status of net-zero commitment (Committed, Achieved, Not Committed) for strategic positioning."
    - name: "reporting_period_start"
      expr: reporting_period_start
      comment: "Start of the ESG reporting period for year-over-year trend analysis."
    - name: "reporting_period_end"
      expr: reporting_period_end
      comment: "End of the ESG reporting period."
  measures:
    - name: "total_scope1_emissions_tco2e"
      expr: SUM(CAST(total_emissions_scope1 AS DOUBLE))
      comment: "Aggregate Scope 1 direct emissions across all ESG reports — headline decarbonisation KPI."
    - name: "total_scope2_emissions_tco2e"
      expr: SUM(CAST(total_emissions_scope2 AS DOUBLE))
      comment: "Aggregate Scope 2 indirect energy emissions — informs renewable energy procurement strategy."
    - name: "total_scope3_emissions_tco2e"
      expr: SUM(CAST(total_emissions_scope3 AS DOUBLE))
      comment: "Aggregate Scope 3 value-chain emissions — largest category for construction, drives supply chain engagement."
    - name: "avg_carbon_intensity"
      expr: AVG(CAST(carbon_intensity AS DOUBLE))
      comment: "Average carbon intensity across reporting periods — normalised efficiency metric for peer benchmarking."
    - name: "avg_renewable_energy_pct"
      expr: AVG(CAST(renewable_energy_percentage AS DOUBLE))
      comment: "Average renewable energy percentage — tracks progress toward 100% renewable energy targets."
    - name: "total_energy_consumption_mwh"
      expr: SUM(CAST(energy_consumption_mwh AS DOUBLE))
      comment: "Total energy consumed in MWh across all reporting periods — absolute energy footprint."
    - name: "avg_waste_diverted_pct"
      expr: AVG(CAST(waste_diverted_percentage AS DOUBLE))
      comment: "Average waste diversion rate across ESG reports — circular economy performance indicator."
    - name: "total_waste_diverted_tons"
      expr: SUM(CAST(waste_diverted_tons AS DOUBLE))
      comment: "Total waste diverted from landfill in tonnes — absolute circular economy impact."
    - name: "total_water_usage_m3"
      expr: SUM(CAST(water_usage_cubic_meters AS DOUBLE))
      comment: "Total water consumed in cubic metres across all reporting periods — water stewardship headline metric."
    - name: "avg_emission_reduction_target_pct"
      expr: AVG(CAST(emission_reduction_target_percentage AS DOUBLE))
      comment: "Average committed emission reduction target percentage — indicates portfolio-level decarbonisation ambition."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`sustainability_green_certification`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tracks green building certification achievements, costs, and ratings to demonstrate sustainable construction performance."
  source: "`vibe_construction_v1`.`sustainability`.`green_certification`"
  dimensions:
    - name: "certification_scheme"
      expr: certification_scheme
      comment: "Green building scheme (BREEAM, LEED, WELL, NABERS) for scheme-specific performance analysis."
    - name: "certification_status"
      expr: certification_status
      comment: "Current certification status (Registered, Achieved, Expired, In Progress)."
    - name: "achieved_rating"
      expr: achieved_rating
      comment: "Rating level achieved (Outstanding, Excellent, Good, Pass / Platinum, Gold, Silver) for portfolio quality assessment."
    - name: "target_rating_level"
      expr: target_rating_level
      comment: "Target rating level committed to — gap analysis between target and achieved."
    - name: "certification_body"
      expr: certification_body
      comment: "Certifying organisation for credibility and market recognition analysis."
  measures:
    - name: "total_certification_cost"
      expr: SUM(CAST(certification_cost AS DOUBLE))
      comment: "Total investment in green building certifications — financial commitment to sustainable construction."
    - name: "avg_carbon_reduction_amount"
      expr: AVG(CAST(carbon_reduction_amount AS DOUBLE))
      comment: "Average carbon reduction associated with certified projects — links certification to decarbonisation outcomes."
    - name: "avg_sustainable_material_pct"
      expr: AVG(CAST(sustainable_material_pct AS DOUBLE))
      comment: "Average sustainable material content across certified projects — circular economy performance indicator."
    - name: "avg_waste_diversion_pct"
      expr: AVG(CAST(waste_diversion_pct AS DOUBLE))
      comment: "Average waste diversion rate across certified projects — construction waste performance benchmark."
    - name: "active_certification_count"
      expr: COUNT(CASE WHEN certification_status = 'Achieved' THEN green_certification_id END)
      comment: "Number of active achieved certifications — portfolio-level green building credential count for marketing and ESG reporting."
    - name: "total_carbon_reduction_amount"
      expr: SUM(CAST(carbon_reduction_amount AS DOUBLE))
      comment: "Total carbon reduction across all certified projects — aggregate climate impact of green building programme."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`sustainability_green_credit`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Monitors green building credit achievement and gaps to optimise certification strategy and resource allocation."
  source: "`vibe_construction_v1`.`sustainability`.`green_credit`"
  dimensions:
    - name: "certification_program"
      expr: certification_program
      comment: "Green building programme (BREEAM, LEED, WELL) for programme-specific credit analysis."
    - name: "credit_category"
      expr: credit_category
      comment: "Credit category (Energy, Water, Materials, Transport) for category-level performance analysis."
    - name: "green_credit_status"
      expr: green_credit_status
      comment: "Status of the credit (Targeted, Achieved, Not Achieved, Under Review)."
    - name: "compliance_status"
      expr: compliance_status
      comment: "Whether the credit meets compliance requirements."
    - name: "is_verified"
      expr: is_verified
      comment: "Whether the credit achievement has been independently verified."
    - name: "risk_level"
      expr: risk_level
      comment: "Risk level of achieving the credit (Low, Medium, High) for programme risk management."
  measures:
    - name: "total_points_achieved"
      expr: SUM(CAST(points_achieved AS DOUBLE))
      comment: "Total green building points achieved — headline certification score metric."
    - name: "total_points_targeted"
      expr: SUM(CAST(points_targeted AS DOUBLE))
      comment: "Total points targeted — measures ambition level of the certification strategy."
    - name: "total_points_max"
      expr: SUM(CAST(points_max AS DOUBLE))
      comment: "Total maximum available points — denominator for achievement rate calculation."
    - name: "credit_achievement_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(points_achieved AS DOUBLE)) / NULLIF(SUM(CAST(points_targeted AS DOUBLE)), 0), 2)
      comment: "Percentage of targeted points actually achieved — delivery effectiveness metric for certification programme management."
    - name: "avg_points_achieved_per_credit"
      expr: AVG(CAST(points_achieved AS DOUBLE))
      comment: "Average points achieved per credit — indicates typical credit performance for benchmarking."
    - name: "high_risk_credit_count"
      expr: COUNT(CASE WHEN risk_level = 'High' THEN green_credit_id END)
      comment: "Number of high-risk credits — risk exposure metric requiring management attention to protect certification rating."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`sustainability_social_value_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Quantifies social value delivered through construction activities to support ESG reporting and public sector contract requirements."
  source: "`vibe_construction_v1`.`sustainability`.`social_value_record`"
  dimensions:
    - name: "social_value_record_category"
      expr: social_value_record_category
      comment: "Category of social value (Employment, Skills, Community, Supply Chain) for portfolio analysis."
    - name: "social_value_record_status"
      expr: social_value_record_status
      comment: "Record status for data quality filtering."
    - name: "verification_status"
      expr: verification_status
      comment: "Whether the social value has been independently verified — assurance quality indicator."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of monetised value for multi-currency portfolio analysis."
    - name: "reporting_period_start"
      expr: reporting_period_start
      comment: "Start of the reporting period for trend analysis."
    - name: "reporting_period_end"
      expr: reporting_period_end
      comment: "End of the reporting period."
  measures:
    - name: "total_monetised_value"
      expr: SUM(CAST(monetised_value AS DOUBLE))
      comment: "Total monetised social value delivered — headline social impact metric for ESG reporting and public sector contract compliance."
    - name: "total_quantity_delivered"
      expr: SUM(CAST(quantity_delivered AS DOUBLE))
      comment: "Total physical quantity of social value outcomes delivered (e.g. training hours, jobs created)."
    - name: "avg_monetised_value_per_record"
      expr: AVG(CAST(monetised_value AS DOUBLE))
      comment: "Average monetised value per social value record — efficiency metric for social value programme management."
    - name: "verified_social_value"
      expr: SUM(CASE WHEN verification_status = 'Verified' THEN monetised_value ELSE 0 END)
      comment: "Total verified monetised social value — the only portion that can be claimed in regulatory and contract submissions."
    - name: "verification_coverage_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN verification_status = 'Verified' THEN monetised_value ELSE 0 END) / NULLIF(SUM(CAST(monetised_value AS DOUBLE)), 0), 2)
      comment: "Percentage of total social value that has been independently verified — assurance quality metric for public sector reporting."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`sustainability_supply_chain_carbon`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tracks Scope 3 supply chain carbon emissions by vendor and material category to drive procurement decarbonisation."
  source: "`vibe_construction_v1`.`sustainability`.`supply_chain_carbon`"
  dimensions:
    - name: "material_category"
      expr: material_category
      comment: "Category of material or service procured — identifies highest-carbon supply chain hotspots."
    - name: "geographic_region"
      expr: geographic_region
      comment: "Geographic region of supply — informs transport emission and regional supplier engagement strategy."
    - name: "supply_chain_carbon_status"
      expr: supply_chain_carbon_status
      comment: "Record status for data quality filtering."
    - name: "verification_status"
      expr: verification_status
      comment: "Whether the supply chain carbon data has been verified — data quality indicator for Scope 3 reporting."
    - name: "data_quality_tier"
      expr: data_quality_tier
      comment: "Data quality tier (Primary, Secondary, Spend-based) — higher tiers indicate more accurate Scope 3 data."
    - name: "reporting_period_start"
      expr: reporting_period_start
      comment: "Start of the reporting period for trend analysis."
    - name: "reporting_period_end"
      expr: reporting_period_end
      comment: "End of the reporting period."
  measures:
    - name: "total_scope3_tco2e"
      expr: SUM(CAST(scope3_tco2e AS DOUBLE))
      comment: "Total Scope 3 supply chain emissions in tCO2e — primary metric for supply chain decarbonisation strategy."
    - name: "total_spend_amount"
      expr: SUM(CAST(spend_amount AS DOUBLE))
      comment: "Total procurement spend associated with supply chain carbon records — financial context for carbon intensity analysis."
    - name: "avg_carbon_intensity"
      expr: AVG(CAST(carbon_intensity AS DOUBLE))
      comment: "Average carbon intensity of supply chain (tCO2e per unit spend or activity) — efficiency metric for supplier engagement."
    - name: "scope3_per_spend_unit"
      expr: ROUND(SUM(CAST(scope3_tco2e AS DOUBLE)) / NULLIF(SUM(CAST(spend_amount AS DOUBLE)), 0), 4)
      comment: "Scope 3 emissions per unit of spend — spend-based carbon intensity metric for procurement decarbonisation targeting."
    - name: "total_activity_quantity"
      expr: SUM(CAST(activity_quantity AS DOUBLE))
      comment: "Total activity quantity (tonnes of material, km of transport etc.) providing physical context for emission intensity."
    - name: "verified_record_count"
      expr: COUNT(CASE WHEN verification_status = 'Verified' THEN supply_chain_carbon_id END)
      comment: "Number of verified supply chain carbon records — data quality coverage metric for Scope 3 assurance."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`sustainability_action`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Monitors the delivery and impact of sustainability actions to ensure plan commitments are executed on time."
  source: "`vibe_construction_v1`.`sustainability`.`sustainability_action`"
  dimensions:
    - name: "sustainability_action_category"
      expr: sustainability_action_category
      comment: "Category of sustainability action (Carbon, Waste, Water, Biodiversity, Social) for portfolio analysis."
    - name: "sustainability_action_status"
      expr: sustainability_action_status
      comment: "Delivery status (Planned, In Progress, Completed, Overdue, Cancelled) for pipeline management."
    - name: "priority"
      expr: priority
      comment: "Action priority (Critical, High, Medium, Low) for resource allocation decisions."
    - name: "is_regulatory"
      expr: is_regulatory
      comment: "Flag indicating regulatory obligation — non-delivery carries compliance risk."
    - name: "origin"
      expr: origin
      comment: "Source of the action (Audit, Risk Assessment, Target, Voluntary) for root-cause analysis."
  measures:
    - name: "total_carbon_reduction_tonnes"
      expr: SUM(CAST(carbon_reduction_tonnes AS DOUBLE))
      comment: "Total carbon reduction delivered by completed actions in tCO2e — measures sustainability plan carbon impact."
    - name: "total_cost_saving_amount"
      expr: SUM(CAST(cost_saving_amount AS DOUBLE))
      comment: "Total cost savings generated by sustainability actions — financial business case for sustainability investment."
    - name: "total_waste_diverted_tons"
      expr: SUM(CAST(waste_diverted_tons AS DOUBLE))
      comment: "Total waste diverted from landfill through sustainability actions — circular economy impact metric."
    - name: "total_water_usage_m3"
      expr: SUM(CAST(water_usage_cubic_meters AS DOUBLE))
      comment: "Total water usage associated with sustainability actions — water stewardship impact tracking."
    - name: "total_energy_consumption_mwh"
      expr: SUM(CAST(energy_consumption_mwh AS DOUBLE))
      comment: "Total energy consumption associated with sustainability actions — energy efficiency impact tracking."
    - name: "completed_action_count"
      expr: COUNT(CASE WHEN sustainability_action_status = 'Completed' THEN sustainability_action_id END)
      comment: "Number of completed sustainability actions — delivery rate indicator for plan execution."
    - name: "overdue_action_count"
      expr: COUNT(CASE WHEN sustainability_action_status = 'Overdue' THEN sustainability_action_id END)
      comment: "Number of overdue sustainability actions — risk indicator requiring management escalation."
    - name: "regulatory_action_completion_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_regulatory = TRUE AND sustainability_action_status = 'Completed' THEN sustainability_action_id END) / NULLIF(COUNT(CASE WHEN is_regulatory = TRUE THEN sustainability_action_id END), 0), 2)
      comment: "Completion rate of regulatory sustainability actions — compliance risk metric for legal and regulatory exposure management."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`sustainability_audit`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tracks sustainability audit outcomes, scores, and findings to drive continuous improvement and compliance assurance."
  source: "`vibe_construction_v1`.`sustainability`.`sustainability_audit`"
  dimensions:
    - name: "audit_type"
      expr: audit_type
      comment: "Type of sustainability audit (Internal, External, Regulatory, Certification) for governance analysis."
    - name: "sustainability_audit_status"
      expr: sustainability_audit_status
      comment: "Audit lifecycle status (Planned, In Progress, Completed, Closed) for pipeline management."
    - name: "compliance_rating"
      expr: compliance_rating
      comment: "Overall compliance rating from the audit — headline performance indicator."
    - name: "verification_status"
      expr: verification_status
      comment: "Whether audit findings have been independently verified."
    - name: "net_zero_commitment_status"
      expr: net_zero_commitment_status
      comment: "Net-zero commitment status assessed during audit — strategic alignment indicator."
    - name: "sustainability_goals_aligned"
      expr: sustainability_goals_aligned
      comment: "Whether the audited entity is aligned with sustainability goals — binary strategic alignment flag."
  measures:
    - name: "avg_overall_score"
      expr: AVG(CAST(overall_score AS DOUBLE))
      comment: "Average sustainability audit score — headline performance metric for portfolio-level sustainability maturity."
    - name: "total_carbon_emission_tonnes"
      expr: SUM(CAST(carbon_emission_tonnes AS DOUBLE))
      comment: "Total carbon emissions recorded during audits — cross-validates operational emission reporting."
    - name: "avg_energy_consumption_mwh"
      expr: AVG(CAST(energy_consumption_mwh AS DOUBLE))
      comment: "Average energy consumption per audit — benchmarks energy performance across audited entities."
    - name: "avg_waste_diversion_pct"
      expr: AVG(CAST(waste_diversion_percentage AS DOUBLE))
      comment: "Average waste diversion rate from audit assessments — circular economy performance benchmark."
    - name: "total_water_usage_m3"
      expr: SUM(CAST(water_usage_cubic_meters AS DOUBLE))
      comment: "Total water usage recorded across audits — water stewardship performance indicator."
    - name: "goals_aligned_audit_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN sustainability_goals_aligned = TRUE THEN sustainability_audit_id END) / NULLIF(COUNT(sustainability_audit_id), 0), 2)
      comment: "Percentage of audits where sustainability goals are aligned — strategic alignment rate for board reporting."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`sustainability_sustainable_material`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tracks the approved sustainable material library, embodied carbon, and recycled content to drive low-carbon procurement."
  source: "`vibe_construction_v1`.`sustainability`.`sustainable_material`"
  dimensions:
    - name: "material_category"
      expr: material_category
      comment: "Category of sustainable material (concrete, steel, timber, insulation) for category-level analysis."
    - name: "lifecycle_status"
      expr: lifecycle_status
      comment: "Lifecycle status of the material (Active, Deprecated, Under Review) for approved list management."
    - name: "sustainable_certification"
      expr: sustainable_certification
      comment: "Sustainability certification held (FSC, EPD, Cradle to Cradle) for procurement qualification."
    - name: "compliance_status"
      expr: compliance_status
      comment: "Regulatory compliance status of the material."
    - name: "is_approved"
      expr: is_approved
      comment: "Whether the material is on the approved sustainable materials list."
    - name: "transport_mode"
      expr: transport_mode
      comment: "Mode of transport for delivery — impacts transport carbon footprint."
  measures:
    - name: "avg_embodied_carbon_kg_per_kg"
      expr: AVG(CAST(embodied_carbon_kg_per_kg AS DOUBLE))
      comment: "Average embodied carbon per kg of material — primary low-carbon material selection metric."
    - name: "avg_recycled_content_pct"
      expr: AVG(CAST(recycled_content_percent AS DOUBLE))
      comment: "Average recycled content percentage across approved sustainable materials — circular economy procurement metric."
    - name: "avg_environmental_impact_score"
      expr: AVG(CAST(environmental_impact_score AS DOUBLE))
      comment: "Average environmental impact score — composite sustainability performance metric for material selection."
    - name: "avg_transport_distance_km"
      expr: AVG(CAST(transport_distance_km AS DOUBLE))
      comment: "Average transport distance — proxy for transport carbon and local sourcing performance."
    - name: "total_embodied_carbon_kg"
      expr: SUM(CAST(total_embodied_carbon_kg AS DOUBLE))
      comment: "Total embodied carbon across all sustainable materials in the library — portfolio-level carbon impact."
    - name: "approved_material_count"
      expr: COUNT(CASE WHEN is_approved = TRUE THEN sustainable_material_id END)
      comment: "Number of approved sustainable materials — breadth of low-carbon procurement options available."
    - name: "avg_renewable_energy_content_pct"
      expr: AVG(CAST(renewable_energy_content_percent AS DOUBLE))
      comment: "Average renewable energy content in material production — supply chain decarbonisation indicator."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`sustainability_waste_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tracks construction waste generation, diversion, and disposal costs to drive circular economy performance."
  source: "`vibe_construction_v1`.`sustainability`.`waste_record`"
  dimensions:
    - name: "waste_stream_type"
      expr: waste_stream_type
      comment: "Classification of waste stream (inert, hazardous, recyclable, organic) for diversion strategy."
    - name: "waste_category"
      expr: waste_category
      comment: "Specific waste category for granular hotspot identification and reduction targeting."
    - name: "disposal_route"
      expr: disposal_route
      comment: "How waste was disposed of (landfill, recycled, reused, energy recovery) — key for diversion rate calculation."
    - name: "hazardous_flag"
      expr: hazardous_flag
      comment: "Indicates hazardous waste requiring specialist handling and regulatory reporting."
    - name: "waste_record_status"
      expr: waste_record_status
      comment: "Record lifecycle status for data quality filtering."
    - name: "reporting_period_start"
      expr: reporting_period_start
      comment: "Start of the reporting period for trend analysis."
    - name: "reporting_period_end"
      expr: reporting_period_end
      comment: "End of the reporting period for period-over-period comparison."
  measures:
    - name: "total_waste_quantity"
      expr: SUM(CAST(quantity AS DOUBLE))
      comment: "Total waste generated — primary waste KPI for target-setting and regulatory reporting."
    - name: "total_waste_cost"
      expr: SUM(CAST(cost_amount AS DOUBLE))
      comment: "Total cost of waste disposal — financial impact metric driving waste reduction investment cases."
    - name: "avg_diversion_rate_pct"
      expr: AVG(CAST(diversion_rate_percent AS DOUBLE))
      comment: "Average waste diversion rate across records — headline circular economy performance indicator."
    - name: "hazardous_waste_quantity"
      expr: SUM(CASE WHEN hazardous_flag = TRUE THEN quantity ELSE 0 END)
      comment: "Total hazardous waste generated — regulatory compliance and liability risk metric."
    - name: "landfill_waste_quantity"
      expr: SUM(CASE WHEN disposal_route = 'Landfill' THEN quantity ELSE 0 END)
      comment: "Total waste sent to landfill — key metric for zero-waste-to-landfill target tracking."
    - name: "diverted_waste_quantity"
      expr: SUM(CASE WHEN disposal_route != 'Landfill' AND disposal_route IS NOT NULL THEN quantity ELSE 0 END)
      comment: "Total waste diverted from landfill through recycling, reuse, or energy recovery."
    - name: "waste_cost_per_unit"
      expr: ROUND(SUM(CAST(cost_amount AS DOUBLE)) / NULLIF(SUM(CAST(quantity AS DOUBLE)), 0), 2)
      comment: "Average disposal cost per unit of waste — efficiency metric for waste contractor performance management."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`sustainability_waste_target`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Monitors waste reduction target ambition and delivery progress to steer circular economy strategy."
  source: "`vibe_construction_v1`.`sustainability`.`waste_target`"
  dimensions:
    - name: "target_type"
      expr: target_type
      comment: "Type of waste target (diversion rate, intensity, absolute) for portfolio analysis."
    - name: "waste_target_status"
      expr: waste_target_status
      comment: "Current status of the target (Active, Achieved, Missed, Superseded)."
    - name: "progress_status"
      expr: progress_status
      comment: "In-period progress status (On Track, At Risk, Off Track) for management intervention."
    - name: "region_code"
      expr: region_code
      comment: "Geographic region for regional performance benchmarking."
    - name: "reporting_frequency"
      expr: reporting_frequency
      comment: "How often progress is reported (Monthly, Quarterly, Annual)."
  measures:
    - name: "avg_target_diversion_rate_pct"
      expr: AVG(CAST(target_diversion_rate_pct AS DOUBLE))
      comment: "Average target diversion rate across all active targets — headline ambition indicator."
    - name: "avg_actual_diversion_rate_pct"
      expr: AVG(CAST(actual_diversion_rate_pct AS DOUBLE))
      comment: "Average actual diversion rate achieved — measures delivery against targets."
    - name: "diversion_rate_gap_pct"
      expr: ROUND(AVG(CAST(target_diversion_rate_pct AS DOUBLE)) - AVG(CAST(actual_diversion_rate_pct AS DOUBLE)), 2)
      comment: "Gap between target and actual diversion rate — negative value indicates underperformance requiring intervention."
    - name: "total_target_landfill_diversion_tonnes"
      expr: SUM(CAST(target_landfill_diversion_tonnes AS DOUBLE))
      comment: "Total committed landfill diversion in tonnes across all targets."
    - name: "total_actual_landfill_diversion_tonnes"
      expr: SUM(CAST(actual_landfill_diversion_tonnes AS DOUBLE))
      comment: "Total actual landfill diversion achieved in tonnes — measures delivery against commitment."
    - name: "on_track_target_count"
      expr: COUNT(CASE WHEN progress_status = 'On Track' THEN waste_target_id END)
      comment: "Number of waste targets currently on track — portfolio health indicator for sustainability steering meetings."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`sustainability_water_consumption`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tracks water use by source type and project to manage water stress risk and efficiency targets."
  source: "`vibe_construction_v1`.`sustainability`.`water_consumption`"
  dimensions:
    - name: "water_source_type"
      expr: water_source_type
      comment: "Source of water consumed (mains, groundwater, recycled, rainwater) for water stewardship analysis."
    - name: "water_stress_area_classification"
      expr: water_stress_area_classification
      comment: "Water stress classification of the location — high-stress areas require priority management."
    - name: "compliance_status"
      expr: compliance_status
      comment: "Whether consumption is within permitted limits — regulatory risk indicator."
    - name: "metering_method"
      expr: metering_method
      comment: "Method used to measure consumption (metered, estimated, calculated) for data quality assessment."
    - name: "reporting_period_start"
      expr: reporting_period_start
      comment: "Start of the reporting period for trend analysis."
    - name: "reporting_period_end"
      expr: reporting_period_end
      comment: "End of the reporting period for period-over-period comparison."
  measures:
    - name: "total_consumption_volume_m3"
      expr: SUM(CAST(consumption_volume_m3 AS DOUBLE))
      comment: "Total water consumed in cubic metres — primary water KPI for target-setting and ESG reporting."
    - name: "total_discharge_volume_m3"
      expr: SUM(CAST(discharge_volume_m3 AS DOUBLE))
      comment: "Total water discharged — net consumption = consumption minus discharge, key for water balance reporting."
    - name: "net_water_consumption_m3"
      expr: SUM(consumption_volume_m3 - discharge_volume_m3)
      comment: "Net water consumed (consumption minus discharge) in m3 — true water footprint metric."
    - name: "total_carbon_footprint_kg"
      expr: SUM(CAST(carbon_footprint_kg AS DOUBLE))
      comment: "Carbon footprint attributable to water consumption in kg — links water use to GHG reporting."
    - name: "high_stress_consumption_m3"
      expr: SUM(CASE WHEN water_stress_area_classification = 'High' THEN consumption_volume_m3 ELSE 0 END)
      comment: "Water consumed in high water-stress areas — priority risk metric for TCFD and CDP water disclosure."
$$;
