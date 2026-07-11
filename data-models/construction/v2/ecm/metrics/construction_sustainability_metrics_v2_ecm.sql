-- Metric views for domain: sustainability | Business: Construction | Version: 2 | Generated on: 2026-07-10 12:14:04

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`sustainability_carbon_emission`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Carbon emission KPIs tracking total CO2e output, scope distribution, and verification rates across projects and emission sources. Core ESG reporting metric for net-zero progress."
  source: "`vibe_construction_v1`.`sustainability`.`carbon_emission`"
  dimensions:
    - name: "scope"
      expr: scope
      comment: "GHG Protocol scope classification (Scope 1, 2, 3) for regulatory and ESG reporting segmentation."
    - name: "source_category"
      expr: source_category
      comment: "Category of emission source (e.g., fuel combustion, electricity, transport) for hotspot analysis."
    - name: "source_type"
      expr: source_type
      comment: "Specific type of emission source enabling granular carbon accounting."
    - name: "measurement_method"
      expr: measurement_method
      comment: "Method used to quantify emissions (metered, estimated, calculated) for data quality assessment."
    - name: "verification_status"
      expr: verification_status
      comment: "Third-party verification status of emission records for assurance and regulatory compliance."
    - name: "reporting_period_start"
      expr: DATE_TRUNC('month', reporting_period_start)
      comment: "Reporting period start bucketed to month for trend analysis."
    - name: "reporting_period_end"
      expr: DATE_TRUNC('month', reporting_period_end)
      comment: "Reporting period end bucketed to month for period-over-period comparison."
    - name: "construction_project_id"
      expr: construction_project_id
      comment: "Project identifier enabling project-level carbon footprint analysis."
  measures:
    - name: "total_co2e_tonnes"
      expr: SUM(CAST(co2e_tonnes AS DOUBLE))
      comment: "Total carbon dioxide equivalent emissions in tonnes. Primary KPI for net-zero target tracking and ESG disclosure."
    - name: "avg_co2e_per_activity"
      expr: AVG(CAST(co2e_tonnes AS DOUBLE))
      comment: "Average CO2e per emission event, used to benchmark emission intensity across activities and identify outliers."
    - name: "total_activity_quantity"
      expr: SUM(CAST(activity_quantity AS DOUBLE))
      comment: "Total activity quantity (fuel consumed, distance travelled, etc.) driving emissions, used for intensity ratio calculations."
    - name: "verified_emission_count"
      expr: COUNT(CASE WHEN verification_status = 'Verified' THEN carbon_emission_id END)
      comment: "Count of third-party verified emission records. Drives assurance coverage rate for ESG reporting."
    - name: "total_emission_records"
      expr: COUNT(1)
      comment: "Total number of emission records in the period, used as denominator for verification rate and data completeness KPIs."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`sustainability_carbon_target`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Carbon reduction target KPIs tracking baseline emissions, target values, and reduction ambition. Used by sustainability leadership to monitor SBTi alignment and net-zero commitments."
  source: "`vibe_construction_v1`.`sustainability`.`carbon_target`"
  dimensions:
    - name: "target_type"
      expr: target_type
      comment: "Type of carbon target (absolute, intensity, net-zero) for portfolio-level target classification."
    - name: "target_scope"
      expr: target_scope
      comment: "GHG scope coverage of the target (Scope 1+2, all scopes) for regulatory alignment."
    - name: "sbti_validation_status"
      expr: sbti_validation_status
      comment: "Science Based Targets initiative validation status, critical for investor and regulatory credibility."
    - name: "lifecycle_status"
      expr: lifecycle_status
      comment: "Current lifecycle status of the target (active, superseded, achieved) for portfolio management."
    - name: "target_year"
      expr: target_year
      comment: "Target achievement year for timeline-based progress tracking."
    - name: "baseline_year"
      expr: baseline_year
      comment: "Baseline year against which reduction progress is measured."
    - name: "alignment_paris_pathway"
      expr: alignment_paris_pathway
      comment: "Paris Agreement pathway alignment (1.5°C, well-below 2°C) for climate strategy positioning."
  measures:
    - name: "total_baseline_emissions_tco2e"
      expr: SUM(CAST(baseline_emissions_tco2e AS DOUBLE))
      comment: "Total baseline emissions in tCO2e across all active targets. Establishes the starting point for reduction measurement."
    - name: "total_target_value_tco2e"
      expr: SUM(CAST(target_value_tco2e AS DOUBLE))
      comment: "Total absolute emission target value in tCO2e. Quantifies the organisation's committed emission ceiling."
    - name: "avg_target_reduction_pct"
      expr: AVG(CAST(target_reduction_pct AS DOUBLE))
      comment: "Average percentage reduction committed across all targets. Indicates overall ambition level of the carbon strategy."
    - name: "avg_target_intensity_value"
      expr: AVG(CAST(target_intensity_value AS DOUBLE))
      comment: "Average emission intensity target value, used for intensity-based target benchmarking."
    - name: "active_target_count"
      expr: COUNT(CASE WHEN lifecycle_status = 'Active' THEN carbon_target_id END)
      comment: "Number of currently active carbon targets. Tracks breadth of the organisation's climate commitment portfolio."
    - name: "sbti_validated_target_count"
      expr: COUNT(CASE WHEN sbti_validation_status = 'Validated' THEN carbon_target_id END)
      comment: "Number of SBTi-validated targets. Key credibility indicator for investor ESG assessments."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`sustainability_carbon_reduction_initiative`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Carbon reduction initiative KPIs measuring projected vs actual CO2e savings, cost efficiency, and implementation progress. Enables ROI analysis of decarbonisation investments."
  source: "`vibe_construction_v1`.`sustainability`.`carbon_reduction_initiative`"
  dimensions:
    - name: "initiative_type"
      expr: initiative_type
      comment: "Type of carbon reduction initiative (energy efficiency, renewable energy, process change) for portfolio categorisation."
    - name: "carbon_reduction_initiative_status"
      expr: carbon_reduction_initiative_status
      comment: "Current implementation status (planned, in-progress, completed) for pipeline management."
    - name: "climate_risk_category"
      expr: climate_risk_category
      comment: "Climate risk category addressed by the initiative for risk-response alignment."
    - name: "verification_status"
      expr: verification_status
      comment: "Verification status of reported savings for data quality and assurance tracking."
    - name: "funding_source"
      expr: funding_source
      comment: "Source of funding for the initiative (internal, grant, green finance) for financial planning."
    - name: "start_date"
      expr: DATE_TRUNC('year', start_date)
      comment: "Initiative start year for cohort analysis of decarbonisation programme rollout."
  measures:
    - name: "total_projected_annual_co2e_saving"
      expr: SUM(CAST(projected_annual_co2e_saving AS DOUBLE))
      comment: "Total projected annual CO2e savings across all initiatives. Primary forward-looking KPI for decarbonisation pipeline value."
    - name: "total_actual_co2e_saving"
      expr: SUM(CAST(actual_co2e_saving AS DOUBLE))
      comment: "Total realised CO2e savings from completed initiatives. Measures actual decarbonisation delivered vs projected."
    - name: "total_implementation_cost"
      expr: SUM(CAST(implementation_cost AS DOUBLE))
      comment: "Total capital invested in carbon reduction initiatives. Used for cost-per-tonne-saved efficiency analysis."
    - name: "total_actual_cost"
      expr: SUM(CAST(actual_cost AS DOUBLE))
      comment: "Total actual spend on initiatives, compared against implementation cost budget for cost control."
    - name: "avg_payback_period_years"
      expr: AVG(CAST(payback_period_years AS DOUBLE))
      comment: "Average payback period in years across initiatives. Key investment decision metric for green capital allocation."
    - name: "total_funding_amount"
      expr: SUM(CAST(funding_amount AS DOUBLE))
      comment: "Total funding secured for carbon reduction initiatives, tracking green finance mobilisation."
    - name: "initiative_count"
      expr: COUNT(1)
      comment: "Total number of carbon reduction initiatives in the portfolio."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`sustainability_energy_consumption`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Energy consumption KPIs tracking total energy use, intensity, and carbon conversion across projects and energy types. Core metric for energy efficiency programmes and Scope 2 reporting."
  source: "`vibe_construction_v1`.`sustainability`.`energy_consumption`"
  dimensions:
    - name: "energy_type"
      expr: energy_type
      comment: "Type of energy consumed (electricity, diesel, natural gas, renewable) for energy mix analysis."
    - name: "energy_consumption_status"
      expr: energy_consumption_status
      comment: "Record status (confirmed, estimated, corrected) for data quality filtering."
    - name: "metering_source"
      expr: metering_source
      comment: "Source of metering data (smart meter, manual read, invoice) for data reliability assessment."
    - name: "unit_of_measure"
      expr: unit_of_measure
      comment: "Unit of energy measurement (kWh, MWh, GJ) for normalisation and comparison."
    - name: "is_estimated"
      expr: is_estimated
      comment: "Flag indicating whether consumption was estimated rather than metered, for data quality reporting."
    - name: "period_start_date"
      expr: DATE_TRUNC('month', period_start_date)
      comment: "Consumption period start bucketed to month for trend analysis."
    - name: "construction_project_id"
      expr: construction_project_id
      comment: "Project identifier for project-level energy benchmarking."
  measures:
    - name: "total_consumption_quantity"
      expr: SUM(CAST(consumption_quantity AS DOUBLE))
      comment: "Total energy consumed in the reporting period. Primary KPI for energy reduction target tracking."
    - name: "total_carbon_emission_kg"
      expr: SUM(CAST(carbon_emission_kg AS DOUBLE))
      comment: "Total carbon emissions in kg derived from energy consumption. Links energy use to Scope 1/2 carbon accounting."
    - name: "avg_energy_intensity"
      expr: AVG(CAST(energy_intensity AS DOUBLE))
      comment: "Average energy intensity (energy per unit of output) across records. Tracks efficiency improvement over time."
    - name: "avg_carbon_emission_factor"
      expr: AVG(CAST(carbon_emission_factor AS DOUBLE))
      comment: "Average carbon emission factor applied to energy consumption, used to assess grid decarbonisation impact."
    - name: "estimated_record_count"
      expr: COUNT(CASE WHEN is_estimated = TRUE THEN energy_consumption_id END)
      comment: "Count of estimated (non-metered) consumption records. High values indicate data quality risk in carbon reporting."
    - name: "total_records"
      expr: COUNT(1)
      comment: "Total energy consumption records, used as denominator for estimation rate and coverage metrics."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`sustainability_waste_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Waste management KPIs tracking total waste generated, diversion rates, and disposal costs. Critical for circular economy targets and regulatory compliance reporting."
  source: "`vibe_construction_v1`.`sustainability`.`waste_record`"
  dimensions:
    - name: "waste_stream_type"
      expr: waste_stream_type
      comment: "Type of waste stream (inert, hazardous, recyclable, organic) for waste hierarchy analysis."
    - name: "waste_category"
      expr: waste_category
      comment: "Waste category for detailed material flow reporting and landfill diversion tracking."
    - name: "disposal_route"
      expr: disposal_route
      comment: "Disposal route (recycled, landfill, energy recovery, reuse) for waste hierarchy compliance."
    - name: "hazardous_flag"
      expr: hazardous_flag
      comment: "Hazardous waste indicator for regulatory compliance and duty-of-care tracking."
    - name: "waste_record_status"
      expr: waste_record_status
      comment: "Record status for data quality filtering and audit trail management."
    - name: "construction_project_id"
      expr: construction_project_id
      comment: "Project identifier for project-level waste performance benchmarking."
    - name: "reporting_period_start"
      expr: DATE_TRUNC('month', reporting_period_start)
      comment: "Reporting period start bucketed to month for trend and target tracking."
  measures:
    - name: "total_waste_quantity"
      expr: SUM(CAST(quantity AS DOUBLE))
      comment: "Total waste generated in the period. Primary KPI for waste reduction target tracking and ESG disclosure."
    - name: "total_disposal_cost"
      expr: SUM(CAST(cost_amount AS DOUBLE))
      comment: "Total cost of waste disposal. Drives financial case for waste reduction and circular economy investment."
    - name: "avg_diversion_rate_pct"
      expr: AVG(CAST(diversion_rate_percent AS DOUBLE))
      comment: "Average waste diversion rate (% diverted from landfill). Core KPI for circular economy and zero-waste-to-landfill targets."
    - name: "hazardous_waste_quantity"
      expr: SUM(CASE WHEN hazardous_flag = TRUE THEN quantity ELSE 0 END)
      comment: "Total hazardous waste generated. Regulatory compliance KPI requiring separate tracking and reporting."
    - name: "verified_record_count"
      expr: COUNT(CASE WHEN verified_by IS NOT NULL THEN waste_record_id END)
      comment: "Count of waste records with third-party verification, indicating data assurance coverage."
    - name: "total_waste_records"
      expr: COUNT(1)
      comment: "Total waste records in the period, used as denominator for verification rate and completeness metrics."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`sustainability_water_consumption`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Water consumption KPIs tracking total usage, discharge volumes, and carbon footprint of water operations. Supports water stewardship targets and stress-area risk management."
  source: "`vibe_construction_v1`.`sustainability`.`water_consumption`"
  dimensions:
    - name: "water_source_type"
      expr: water_source_type
      comment: "Source of water (mains, borehole, recycled, rainwater) for water stewardship and sourcing risk analysis."
    - name: "water_stress_area_classification"
      expr: water_stress_area_classification
      comment: "Water stress area classification for sites, enabling risk-weighted water reporting per TCFD requirements."
    - name: "discharge_destination"
      expr: discharge_destination
      comment: "Destination of discharged water (sewer, watercourse, ground) for environmental permit compliance."
    - name: "metering_method"
      expr: metering_method
      comment: "Method of water measurement (meter, estimate, calculation) for data quality assessment."
    - name: "compliance_status"
      expr: compliance_status
      comment: "Compliance status of water consumption record against permit conditions."
    - name: "construction_project_id"
      expr: construction_project_id
      comment: "Project identifier for project-level water intensity benchmarking."
    - name: "reporting_period_start"
      expr: DATE_TRUNC('month', reporting_period_start)
      comment: "Reporting period start bucketed to month for trend analysis."
  measures:
    - name: "total_consumption_volume_m3"
      expr: SUM(CAST(consumption_volume_m3 AS DOUBLE))
      comment: "Total water consumed in cubic metres. Primary KPI for water reduction target tracking and ESG disclosure."
    - name: "total_discharge_volume_m3"
      expr: SUM(CAST(discharge_volume_m3 AS DOUBLE))
      comment: "Total water discharged in cubic metres. Used to calculate net water consumption and permit compliance."
    - name: "total_carbon_footprint_kg"
      expr: SUM(CAST(carbon_footprint_kg AS DOUBLE))
      comment: "Total carbon footprint of water operations in kg CO2e. Links water use to Scope 3 carbon accounting."
    - name: "net_water_consumption_m3"
      expr: SUM((CAST(consumption_volume_m3 AS DOUBLE)) - (CAST(discharge_volume_m3 AS DOUBLE)))
      comment: "Net water consumed (intake minus discharge) in cubic metres. True water depletion metric for water stewardship reporting."
    - name: "high_stress_consumption_m3"
      expr: SUM(CASE WHEN water_stress_area_classification IN ('High', 'Extremely High') THEN consumption_volume_m3 ELSE 0 END)
      comment: "Water consumed in high or extremely high water stress areas. Critical risk metric for TCFD physical risk disclosure."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`sustainability_esg_report`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "ESG report KPIs aggregating disclosed environmental performance metrics across reporting periods. Used by sustainability directors and investor relations for external disclosure quality management."
  source: "`vibe_construction_v1`.`sustainability`.`esg_report`"
  dimensions:
    - name: "reporting_framework"
      expr: reporting_framework
      comment: "ESG reporting framework used (GRI, TCFD, CSRD, CDP) for framework-specific performance analysis."
    - name: "publication_status"
      expr: publication_status
      comment: "Publication status of the ESG report (draft, published, restated) for disclosure pipeline management."
    - name: "assurance_level"
      expr: assurance_level
      comment: "Level of external assurance (limited, reasonable, none) for credibility and investor confidence assessment."
    - name: "net_zero_commitment_status"
      expr: net_zero_commitment_status
      comment: "Net-zero commitment status disclosed in the report for strategic alignment tracking."
    - name: "reporting_period_start"
      expr: DATE_TRUNC('year', reporting_period_start)
      comment: "Reporting period start year for year-on-year ESG performance comparison."
  measures:
    - name: "total_scope1_emissions_tco2e"
      expr: SUM(CAST(total_emissions_scope1 AS DOUBLE))
      comment: "Total Scope 1 (direct) emissions disclosed across reports. Core GHG inventory KPI for regulatory and investor reporting."
    - name: "total_scope2_emissions_tco2e"
      expr: SUM(CAST(total_emissions_scope2 AS DOUBLE))
      comment: "Total Scope 2 (indirect energy) emissions disclosed. Tracks progress on renewable energy procurement."
    - name: "total_scope3_emissions_tco2e"
      expr: SUM(CAST(total_emissions_scope3 AS DOUBLE))
      comment: "Total Scope 3 (value chain) emissions disclosed. Largest emission category for construction, critical for supply chain decarbonisation."
    - name: "avg_renewable_energy_pct"
      expr: AVG(CAST(renewable_energy_percentage AS DOUBLE))
      comment: "Average renewable energy percentage across reporting periods. Tracks progress toward 100% renewable energy targets."
    - name: "avg_waste_diverted_pct"
      expr: AVG(CAST(waste_diverted_percentage AS DOUBLE))
      comment: "Average waste diversion percentage disclosed in ESG reports. Tracks circular economy performance over time."
    - name: "total_energy_consumption_mwh"
      expr: SUM(CAST(energy_consumption_mwh AS DOUBLE))
      comment: "Total energy consumption in MWh disclosed across reports. Baseline for energy intensity and efficiency tracking."
    - name: "avg_carbon_intensity"
      expr: AVG(CAST(carbon_intensity AS DOUBLE))
      comment: "Average carbon intensity (tCO2e per unit of revenue or output) across reports. Key intensity-based performance indicator."
    - name: "avg_water_usage_cubic_meters"
      expr: AVG(CAST(water_usage_cubic_meters AS DOUBLE))
      comment: "Average water usage in cubic metres per reporting period. Tracks water stewardship performance trend."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`sustainability_embodied_carbon_assessment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Embodied carbon assessment KPIs measuring whole-life carbon in construction materials and assets. Supports RIBA stage-gate carbon management and green building certification targets."
  source: "`vibe_construction_v1`.`sustainability`.`embodied_carbon_assessment`"
  dimensions:
    - name: "assessment_status"
      expr: assessment_status
      comment: "Status of the embodied carbon assessment (draft, approved, superseded) for workflow management."
    - name: "riba_stage"
      expr: riba_stage
      comment: "RIBA design stage at which assessment was conducted, enabling stage-gate carbon management."
    - name: "methodology"
      expr: methodology
      comment: "Assessment methodology (EN 15978, RICS WLCA) for comparability and regulatory compliance."
    - name: "scope"
      expr: scope
      comment: "Carbon boundary scope (A1-A5, A-C, whole life) for lifecycle stage analysis."
    - name: "is_verified"
      expr: is_verified
      comment: "Third-party verification flag for assurance quality filtering."
    - name: "related_project_phase"
      expr: related_project_phase
      comment: "Project phase associated with the assessment for phase-level carbon tracking."
    - name: "construction_project_id"
      expr: construction_project_id
      comment: "Project identifier for project-level embodied carbon benchmarking."
  measures:
    - name: "total_embodied_carbon_tco2e"
      expr: SUM(CAST(total_embodied_carbon_tco2e AS DOUBLE))
      comment: "Total embodied carbon in tCO2e across all assessed assets and materials. Primary KPI for whole-life carbon management."
    - name: "total_upfront_carbon_tco2e"
      expr: SUM(CAST(upfront_carbon_tco2e AS DOUBLE))
      comment: "Total upfront (A1-A5) embodied carbon. Represents carbon locked in during construction, the most actionable reduction opportunity."
    - name: "total_end_of_life_carbon_tco2e"
      expr: SUM(CAST(end_of_life_carbon_tco2e AS DOUBLE))
      comment: "Total end-of-life carbon in tCO2e. Informs circular economy design decisions and demolition planning."
    - name: "avg_carbon_intensity_kg_per_m3"
      expr: AVG(CAST(carbon_intensity_kg_per_m3 AS DOUBLE))
      comment: "Average embodied carbon intensity in kg CO2e per m3. Benchmark metric for material specification decisions."
    - name: "avg_renewable_material_pct"
      expr: AVG(CAST(renewable_material_percentage AS DOUBLE))
      comment: "Average renewable material content percentage across assessments. Tracks sustainable material substitution progress."
    - name: "avg_waste_diversion_rate_pct"
      expr: AVG(CAST(waste_diversion_rate_percent AS DOUBLE))
      comment: "Average waste diversion rate from embodied carbon assessments. Links material efficiency to waste reduction targets."
    - name: "verified_assessment_count"
      expr: COUNT(CASE WHEN is_verified = TRUE THEN embodied_carbon_assessment_id END)
      comment: "Count of third-party verified embodied carbon assessments. Indicates assurance coverage for green building certification."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`sustainability_biodiversity_assessment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Biodiversity net gain KPIs tracking habitat quality, biodiversity units, and monitoring compliance. Supports mandatory Biodiversity Net Gain (BNG) reporting and planning condition compliance."
  source: "`vibe_construction_v1`.`sustainability`.`biodiversity_assessment`"
  dimensions:
    - name: "assessment_type"
      expr: assessment_type
      comment: "Type of biodiversity assessment (baseline, post-construction, monitoring) for lifecycle tracking."
    - name: "assessment_status"
      expr: assessment_status
      comment: "Current status of the assessment (in-progress, approved, rejected) for workflow management."
    - name: "statutory_approval_status"
      expr: statutory_approval_status
      comment: "Statutory approval status for planning compliance and regulatory reporting."
    - name: "monitoring_status"
      expr: monitoring_status
      comment: "Status of ongoing biodiversity monitoring programme for condition compliance tracking."
    - name: "metric_framework"
      expr: metric_framework
      comment: "Biodiversity metric framework used (DEFRA BNG Metric, BREEAM) for methodology comparability."
    - name: "construction_project_id"
      expr: construction_project_id
      comment: "Project identifier for project-level biodiversity net gain tracking."
    - name: "assessment_date"
      expr: DATE_TRUNC('year', assessment_date)
      comment: "Assessment year for trend analysis of biodiversity performance."
  measures:
    - name: "total_biodiversity_units_gained"
      expr: SUM(CAST(biodiversity_units_gained AS DOUBLE))
      comment: "Total biodiversity units gained across all assessments. Primary KPI for Biodiversity Net Gain compliance and planning obligations."
    - name: "total_biodiversity_units_lost"
      expr: SUM(CAST(biodiversity_units_lost AS DOUBLE))
      comment: "Total biodiversity units lost due to development. Used to calculate net gain and mitigation hierarchy compliance."
    - name: "total_net_biodiversity_units"
      expr: SUM(CAST(net_biodiversity_units AS DOUBLE))
      comment: "Net biodiversity units (gained minus lost) across all projects. Headline BNG KPI for regulatory and investor reporting."
    - name: "total_habitat_area_ha"
      expr: SUM(CAST(habitat_area_ha AS DOUBLE))
      comment: "Total habitat area assessed in hectares. Quantifies the scale of biodiversity management across the portfolio."
    - name: "avg_habitat_quality_score"
      expr: AVG(CAST(habitat_quality_score AS DOUBLE))
      comment: "Average habitat quality score across assessments. Tracks ecological quality improvement over time."
    - name: "avg_biodiversity_units_per_ha"
      expr: AVG(CAST(biodiversity_units_per_ha AS DOUBLE))
      comment: "Average biodiversity units per hectare, used for habitat quality benchmarking across project types."
    - name: "monitoring_required_count"
      expr: COUNT(CASE WHEN monitoring_plan_required = TRUE THEN biodiversity_assessment_id END)
      comment: "Count of assessments requiring ongoing monitoring plans. Tracks regulatory monitoring obligations."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`sustainability_green_certification`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Green building certification KPIs tracking certification achievement rates, carbon reductions, and sustainable material use. Supports BREEAM/LEED portfolio management and client commitments."
  source: "`vibe_construction_v1`.`sustainability`.`green_certification`"
  dimensions:
    - name: "certification_scheme"
      expr: certification_scheme
      comment: "Green building certification scheme (BREEAM, LEED, WELL, NABERS) for scheme-specific performance analysis."
    - name: "certification_status"
      expr: certification_status
      comment: "Current certification status (registered, assessed, certified, expired) for portfolio pipeline management."
    - name: "achieved_rating"
      expr: achieved_rating
      comment: "Achieved certification rating (Outstanding, Excellent, Very Good, Pass) for quality distribution analysis."
    - name: "target_rating_level"
      expr: target_rating_level
      comment: "Target rating level committed at project outset for gap analysis against achievement."
    - name: "construction_project_id"
      expr: construction_project_id
      comment: "Project identifier for project-level certification tracking."
    - name: "rating_date"
      expr: DATE_TRUNC('year', rating_date)
      comment: "Year of certification rating for annual portfolio performance reporting."
  measures:
    - name: "total_certification_cost"
      expr: SUM(CAST(certification_cost AS DOUBLE))
      comment: "Total investment in green building certifications. Used for cost-benefit analysis of certification programmes."
    - name: "total_carbon_reduction_amount"
      expr: SUM(CAST(carbon_reduction_amount AS DOUBLE))
      comment: "Total carbon reduction achieved through certified green buildings. Links certification to carbon target delivery."
    - name: "avg_sustainable_material_pct"
      expr: AVG(CAST(sustainable_material_pct AS DOUBLE))
      comment: "Average sustainable material percentage across certified projects. Tracks supply chain sustainability performance."
    - name: "avg_waste_diversion_pct"
      expr: AVG(CAST(waste_diversion_pct AS DOUBLE))
      comment: "Average waste diversion percentage across certified projects. Measures circular economy performance in certified buildings."
    - name: "certified_project_count"
      expr: COUNT(CASE WHEN certification_status = 'Certified' THEN green_certification_id END)
      comment: "Number of projects achieving full certification. Headline portfolio KPI for green building commitments."
    - name: "total_certifications"
      expr: COUNT(1)
      comment: "Total certifications in the portfolio, used as denominator for certification success rate."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`sustainability_supply_chain_carbon`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Supply chain (Scope 3) carbon KPIs tracking vendor emissions, carbon intensity, and spend-based emission factors. Critical for Scope 3 Category 1 reporting and supplier engagement programmes."
  source: "`vibe_construction_v1`.`sustainability`.`supply_chain_carbon`"
  dimensions:
    - name: "material_category"
      expr: material_category
      comment: "Material or service category for hotspot analysis of highest-carbon supply chain categories."
    - name: "supply_chain_carbon_status"
      expr: supply_chain_carbon_status
      comment: "Record status for data quality filtering and audit trail management."
    - name: "data_quality_tier"
      expr: data_quality_tier
      comment: "Data quality tier (primary, secondary, spend-based) for assurance and methodology disclosure."
    - name: "measurement_method"
      expr: measurement_method
      comment: "Measurement method (activity-based, spend-based, supplier-specific) for methodology mix analysis."
    - name: "geographic_region"
      expr: geographic_region
      comment: "Geographic region of supply chain activity for regional carbon intensity benchmarking."
    - name: "verification_status"
      expr: verification_status
      comment: "Verification status of supply chain carbon data for assurance coverage reporting."
    - name: "reporting_period_start"
      expr: DATE_TRUNC('year', reporting_period_start)
      comment: "Reporting year for year-on-year Scope 3 trend analysis."
  measures:
    - name: "total_scope3_tco2e"
      expr: SUM(CAST(scope3_tco2e AS DOUBLE))
      comment: "Total Scope 3 supply chain emissions in tCO2e. Primary KPI for value chain decarbonisation and CDP/CSRD reporting."
    - name: "total_spend_amount"
      expr: SUM(CAST(spend_amount AS DOUBLE))
      comment: "Total procurement spend associated with carbon records. Used to calculate spend-based emission intensity."
    - name: "total_activity_quantity"
      expr: SUM(CAST(activity_quantity AS DOUBLE))
      comment: "Total activity quantity (tonnes of material, km of transport) driving supply chain emissions."
    - name: "avg_carbon_intensity"
      expr: AVG(CAST(carbon_intensity AS DOUBLE))
      comment: "Average carbon intensity of supply chain activities. Tracks supplier decarbonisation progress over time."
    - name: "avg_emission_factor"
      expr: AVG(CAST(emission_factor AS DOUBLE))
      comment: "Average emission factor applied to supply chain activities. Monitors quality of emission factor data used."
    - name: "verified_record_count"
      expr: COUNT(CASE WHEN verification_status = 'Verified' THEN supply_chain_carbon_id END)
      comment: "Count of verified supply chain carbon records. Indicates data assurance coverage for Scope 3 reporting."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`sustainability_audit`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Sustainability audit KPIs tracking audit scores, findings, and compliance ratings. Enables management system performance monitoring and ISO 14001/50001 certification maintenance."
  source: "`vibe_construction_v1`.`sustainability`.`sustainability_audit`"
  dimensions:
    - name: "audit_type"
      expr: audit_type
      comment: "Type of sustainability audit (internal, external, certification, surveillance) for audit programme management."
    - name: "sustainability_audit_status"
      expr: sustainability_audit_status
      comment: "Current audit status (planned, in-progress, completed, closed) for audit pipeline management."
    - name: "compliance_rating"
      expr: compliance_rating
      comment: "Overall compliance rating from the audit for performance benchmarking and trend analysis."
    - name: "verification_status"
      expr: verification_status
      comment: "Verification status of audit findings for assurance quality tracking."
    - name: "construction_project_id"
      expr: construction_project_id
      comment: "Project identifier for project-level audit performance analysis."
    - name: "audit_date"
      expr: DATE_TRUNC('year', audit_date)
      comment: "Audit year for annual audit programme performance reporting."
  measures:
    - name: "avg_overall_score"
      expr: AVG(CAST(overall_score AS DOUBLE))
      comment: "Average sustainability audit score across all audits. Primary KPI for management system maturity and continuous improvement."
    - name: "total_carbon_emission_tonnes"
      expr: SUM(CAST(carbon_emission_tonnes AS DOUBLE))
      comment: "Total carbon emissions reported in sustainability audits. Cross-validates against carbon accounting records."
    - name: "total_energy_consumption_mwh"
      expr: SUM(CAST(energy_consumption_mwh AS DOUBLE))
      comment: "Total energy consumption reported in audits in MWh. Used for energy management system performance tracking."
    - name: "avg_waste_diversion_pct"
      expr: AVG(CAST(waste_diversion_percentage AS DOUBLE))
      comment: "Average waste diversion percentage reported in audits. Tracks waste management performance across the audit programme."
    - name: "avg_water_usage_m3"
      expr: AVG(CAST(water_usage_cubic_meters AS DOUBLE))
      comment: "Average water usage in cubic metres per audit. Monitors water stewardship performance across audited sites."
    - name: "total_audits"
      expr: COUNT(1)
      comment: "Total number of sustainability audits conducted. Tracks audit programme coverage and frequency."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`sustainability_env_incident`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Environmental incident KPIs tracking incident frequency, severity, and financial impact. Critical for regulatory compliance, permit condition management, and environmental risk reduction."
  source: "`vibe_construction_v1`.`sustainability`.`env_incident`"
  dimensions:
    - name: "incident_type"
      expr: incident_type
      comment: "Type of environmental incident (spill, emission exceedance, noise, waste) for root cause and prevention analysis."
    - name: "severity_category"
      expr: severity_category
      comment: "Severity classification of the incident for risk prioritisation and regulatory notification decisions."
    - name: "env_incident_status"
      expr: env_incident_status
      comment: "Current status of the incident (open, under investigation, closed) for corrective action tracking."
    - name: "media_affected"
      expr: media_affected
      comment: "Environmental media affected (air, water, soil, noise) for impact pathway analysis."
    - name: "is_near_miss"
      expr: is_near_miss
      comment: "Near-miss flag for leading indicator analysis and proactive risk management."
    - name: "construction_project_id"
      expr: construction_project_id
      comment: "Project identifier for project-level environmental incident rate benchmarking."
    - name: "incident_timestamp"
      expr: DATE_TRUNC('month', incident_timestamp)
      comment: "Incident month for trend analysis and seasonal pattern identification."
  measures:
    - name: "total_incidents"
      expr: COUNT(1)
      comment: "Total environmental incidents recorded. Primary frequency KPI for environmental performance reporting and permit compliance."
    - name: "total_estimated_impact_amount"
      expr: SUM(CAST(estimated_impact_amount AS DOUBLE))
      comment: "Total estimated financial impact of environmental incidents. Quantifies environmental liability and drives investment in prevention."
    - name: "near_miss_count"
      expr: COUNT(CASE WHEN is_near_miss = TRUE THEN env_incident_id END)
      comment: "Count of near-miss environmental incidents. Leading indicator for proactive environmental risk management."
    - name: "regulatory_notification_required_count"
      expr: COUNT(CASE WHEN regulatory_notification_required = TRUE THEN env_incident_id END)
      comment: "Count of incidents requiring regulatory notification. Tracks regulatory exposure and compliance obligations."
    - name: "open_incident_count"
      expr: COUNT(CASE WHEN env_incident_status = 'Open' THEN env_incident_id END)
      comment: "Count of open (unresolved) environmental incidents. Operational KPI for corrective action backlog management."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`sustainability_carbon_offset`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Carbon offset portfolio KPIs tracking offset volumes, costs, and retirement status. Supports net-zero strategy by quantifying residual emission compensation and offset quality management."
  source: "`vibe_construction_v1`.`sustainability`.`carbon_offset`"
  dimensions:
    - name: "carbon_offset_status"
      expr: carbon_offset_status
      comment: "Status of the carbon offset (active, retired, cancelled) for portfolio lifecycle management."
    - name: "credit_type"
      expr: credit_type
      comment: "Type of carbon credit (VCU, Gold Standard, REDD+) for quality and standard analysis."
    - name: "offset_standard"
      expr: offset_standard
      comment: "Certification standard of the offset for credibility and regulatory acceptance assessment."
    - name: "is_retired"
      expr: is_retired
      comment: "Retirement flag indicating whether the offset has been used against emissions for net-zero claims."
    - name: "project_country_code"
      expr: project_country_code
      comment: "Country of the offset project for geographic diversification and co-benefit analysis."
    - name: "vintage_year"
      expr: vintage_year
      comment: "Vintage year of the carbon credit for quality and additionality assessment."
  measures:
    - name: "total_quantity_tco2e"
      expr: SUM(CAST(quantity_tco2e AS DOUBLE))
      comment: "Total carbon offsets purchased in tCO2e. Quantifies the scale of residual emission compensation in the net-zero strategy."
    - name: "total_purchase_price_usd"
      expr: SUM(CAST(purchase_price_usd AS DOUBLE))
      comment: "Total spend on carbon offsets in USD. Tracks cost of residual emission compensation and informs offset vs abatement investment decisions."
    - name: "retired_quantity_tco2e"
      expr: SUM(CASE WHEN is_retired = TRUE THEN quantity_tco2e ELSE 0 END)
      comment: "Total retired carbon offsets in tCO2e. Represents offsets actually applied to net-zero claims, critical for disclosure accuracy."
    - name: "avg_price_per_tco2e"
      expr: AVG(purchase_price_usd / NULLIF(quantity_tco2e, 0))
      comment: "Average price paid per tCO2e of carbon offset. Benchmarks procurement efficiency and market exposure."
    - name: "active_offset_count"
      expr: COUNT(CASE WHEN carbon_offset_status = 'Active' THEN carbon_offset_id END)
      comment: "Count of active (non-retired) carbon offsets in the portfolio. Tracks available offset inventory for future net-zero claims."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`sustainability_social_value_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Social value KPIs tracking monetised social outcomes, delivery volumes, and verification rates. Supports Social Value Act compliance, PPN 06/20 reporting, and ESG social pillar disclosure."
  source: "`vibe_construction_v1`.`sustainability`.`social_value_record`"
  dimensions:
    - name: "social_value_record_category"
      expr: social_value_record_category
      comment: "Category of social value outcome (employment, skills, community, wellbeing) for portfolio analysis."
    - name: "social_value_record_status"
      expr: social_value_record_status
      comment: "Record status for data quality filtering and audit trail management."
    - name: "verification_status"
      expr: verification_status
      comment: "Verification status of social value records for assurance and reporting credibility."
    - name: "construction_project_id"
      expr: construction_project_id
      comment: "Project identifier for project-level social value performance reporting."
    - name: "reporting_period_start"
      expr: DATE_TRUNC('year', reporting_period_start)
      comment: "Reporting year for annual social value performance tracking."
  measures:
    - name: "total_monetised_value"
      expr: SUM(CAST(monetised_value AS DOUBLE))
      comment: "Total monetised social value delivered. Primary KPI for Social Value Act compliance and ESG social pillar reporting."
    - name: "total_quantity_delivered"
      expr: SUM(CAST(quantity_delivered AS DOUBLE))
      comment: "Total quantity of social value outcomes delivered (e.g., apprenticeship weeks, volunteer hours). Tracks output against commitments."
    - name: "avg_monetised_value_per_record"
      expr: AVG(CAST(monetised_value AS DOUBLE))
      comment: "Average monetised value per social value record. Benchmarks value intensity across different social value categories."
    - name: "verified_record_count"
      expr: COUNT(CASE WHEN verification_status = 'Verified' THEN social_value_record_id END)
      comment: "Count of verified social value records. Tracks assurance coverage for client and regulatory reporting."
    - name: "total_records"
      expr: COUNT(1)
      comment: "Total social value records, used as denominator for verification rate and category distribution analysis."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`sustainability_waste_target`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Waste target KPIs tracking target vs actual diversion rates, landfill diversion volumes, and waste intensity. Enables performance gap analysis against zero-waste-to-landfill commitments."
  source: "`vibe_construction_v1`.`sustainability`.`waste_target`"
  dimensions:
    - name: "target_type"
      expr: target_type
      comment: "Type of waste target (diversion rate, intensity, absolute volume) for target portfolio classification."
    - name: "waste_target_status"
      expr: waste_target_status
      comment: "Current status of the waste target (active, achieved, missed, superseded) for performance management."
    - name: "progress_status"
      expr: progress_status
      comment: "Progress status against the target (on-track, at-risk, off-track) for early warning management."
    - name: "construction_project_id"
      expr: construction_project_id
      comment: "Project identifier for project-level waste target tracking."
    - name: "start_date"
      expr: DATE_TRUNC('year', start_date)
      comment: "Target start year for cohort analysis of waste reduction programme performance."
  measures:
    - name: "avg_target_diversion_rate_pct"
      expr: AVG(CAST(target_diversion_rate_pct AS DOUBLE))
      comment: "Average target waste diversion rate across all active targets. Quantifies the ambition level of the waste reduction programme."
    - name: "avg_actual_diversion_rate_pct"
      expr: AVG(CAST(actual_diversion_rate_pct AS DOUBLE))
      comment: "Average actual waste diversion rate achieved. Compared against target to identify performance gaps."
    - name: "total_target_landfill_diversion_tonnes"
      expr: SUM(CAST(target_landfill_diversion_tonnes AS DOUBLE))
      comment: "Total landfill diversion committed across all targets. Quantifies the scale of zero-waste-to-landfill commitments."
    - name: "total_actual_landfill_diversion_tonnes"
      expr: SUM(CAST(actual_landfill_diversion_tonnes AS DOUBLE))
      comment: "Total actual landfill diversion achieved. Measures delivery against zero-waste-to-landfill commitments."
    - name: "avg_actual_waste_intensity_kg_per_sqm"
      expr: AVG(CAST(actual_waste_intensity_kg_per_sqm AS DOUBLE))
      comment: "Average actual waste intensity in kg per sqm. Normalised KPI for benchmarking waste performance across projects of different sizes."
    - name: "on_track_target_count"
      expr: COUNT(CASE WHEN progress_status = 'On-Track' THEN waste_target_id END)
      comment: "Count of waste targets currently on track. Leading indicator for waste programme delivery confidence."
$$;