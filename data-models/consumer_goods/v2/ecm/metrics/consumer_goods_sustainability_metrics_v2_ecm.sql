-- Metric views for domain: sustainability | Business: Consumer Goods | Version: 2 | Generated on: 2026-06-28 00:14:33

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`sustainability_biodiversity_impact`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Biodiversity impact KPIs tracking land use, net biodiversity scores, and TNFD risk classifications. Used by sustainability teams to manage nature-related risks and meet TNFD and SBTN disclosure requirements."
  source: "`vibe_consumer_goods_v1`.`sustainability`.`biodiversity_impact`"
  dimensions:
    - name: "biodiversity_impact_category"
      expr: biodiversity_impact_category
      comment: "Category of biodiversity impact (habitat loss, species impact, water quality) for nature risk segmentation."
    - name: "impact_type"
      expr: impact_type
      comment: "Type of biodiversity impact (direct, indirect, cumulative) for TNFD impact materiality assessment."
    - name: "impact_severity"
      expr: impact_severity
      comment: "Severity of the biodiversity impact for risk prioritization and mitigation planning."
    - name: "ecosystem_type"
      expr: ecosystem_type
      comment: "Type of ecosystem affected (forest, wetland, grassland, marine) for ecosystem-specific conservation targeting."
    - name: "tnfd_risk_classification"
      expr: tnfd_risk_classification
      comment: "TNFD risk classification for nature-related financial disclosure alignment."
    - name: "tnfd_disclosure_flag"
      expr: tnfd_disclosure_flag
      comment: "Flag for TNFD-reportable impacts. Tracks nature disclosure obligations."
    - name: "biodiversity_impact_status"
      expr: biodiversity_impact_status
      comment: "Status of the biodiversity impact record for data quality and reporting completeness."
    - name: "net_positive_impact_flag"
      expr: net_positive_impact_flag
      comment: "Flag indicating net positive biodiversity outcome. Tracks nature-positive strategy progress."
  measures:
    - name: "avg_net_biodiversity_impact_score"
      expr: AVG(CAST(net_biodiversity_impact_score AS DOUBLE))
      comment: "Average net biodiversity impact score. Primary TNFD and SBTN KPI for nature-positive strategy tracking."
    - name: "total_land_use_area_ha"
      expr: SUM(CAST(land_use_area_ha AS DOUBLE))
      comment: "Total land use area in hectares. Tracks physical footprint and land dependency for TNFD disclosure."
    - name: "total_protected_area_proximity_km"
      expr: AVG(CAST(protected_area_proximity_km AS DOUBLE))
      comment: "Average proximity to protected areas in km. Tracks nature-related location risk for TNFD physical risk assessment."
    - name: "net_positive_impact_count"
      expr: COUNT(DISTINCT CASE WHEN net_positive_impact_flag = TRUE THEN biodiversity_impact_id END)
      comment: "Number of impacts assessed as net positive. Tracks nature-positive strategy attainment."
    - name: "tnfd_reportable_impact_count"
      expr: COUNT(DISTINCT CASE WHEN tnfd_disclosure_flag = TRUE THEN biodiversity_impact_id END)
      comment: "Number of TNFD-reportable biodiversity impacts. Tracks nature disclosure obligations and reporting completeness."
    - name: "total_impact_count"
      expr: COUNT(DISTINCT biodiversity_impact_id)
      comment: "Total biodiversity impact assessments. Tracks coverage of nature risk assessment program."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`sustainability_carbon_emission`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core GHG emissions KPIs tracking total CO2e output by scope, source, and facility. Used by sustainability officers and CFOs to monitor decarbonization progress, set science-based targets, and report under GHG Protocol and CDP frameworks."
  source: "`vibe_consumer_goods_v1`.`sustainability`.`carbon_emission`"
  dimensions:
    - name: "emission_scope"
      expr: emission_scope
      comment: "GHG Protocol scope classification (Scope 1, 2, or 3) for regulatory and voluntary reporting segmentation."
    - name: "emission_source_category"
      expr: emission_source_category
      comment: "Category of emission source (e.g. combustion, electricity, logistics) enabling hotspot identification."
    - name: "activity_type"
      expr: activity_type
      comment: "Type of business activity generating the emission, used to prioritize reduction initiatives."
    - name: "carbon_emission_status"
      expr: carbon_emission_status
      comment: "Lifecycle status of the emission record (draft, verified, submitted) for data quality filtering."
    - name: "verification_status"
      expr: verification_status
      comment: "Third-party verification status enabling separation of assured vs. unassured emissions data."
    - name: "reporting_year"
      expr: reporting_year
      comment: "Fiscal or calendar year of the emission record for year-over-year trend analysis."
    - name: "ghg_protocol_compliant"
      expr: ghg_protocol_compliant
      comment: "Flag indicating whether the record follows GHG Protocol methodology, used to filter for compliant reporting."
    - name: "emission_factor_source"
      expr: emission_factor_source
      comment: "Source of the emission factor (e.g. IPCC, EPA, supplier-specific) for methodology transparency."
    - name: "emission_timestamp_month"
      expr: DATE_TRUNC('MONTH', emission_timestamp)
      comment: "Month bucket of the emission event for trend and seasonality analysis."
  measures:
    - name: "total_co2e_tonnes"
      expr: SUM(CAST(co2e_quantity_tonnes AS DOUBLE))
      comment: "Total CO2-equivalent emissions in tonnes. Primary KPI for decarbonization target tracking and regulatory disclosure."
    - name: "total_ch4_tonnes"
      expr: SUM(CAST(ch4_tonnes AS DOUBLE))
      comment: "Total methane emissions in tonnes. Methane has 25x GWP vs CO2 and is a critical reduction lever for consumer goods supply chains."
    - name: "total_n2o_tonnes"
      expr: SUM(CAST(n2o_tonnes AS DOUBLE))
      comment: "Total nitrous oxide emissions in tonnes. N2O has 298x GWP and is relevant for agricultural and packaging supply chains."
    - name: "total_offset_quantity_tonnes"
      expr: SUM(CAST(offset_quantity_tonnes AS DOUBLE))
      comment: "Total CO2e tonnes offset through purchased carbon credits. Used to calculate net emissions position."
    - name: "net_co2e_tonnes"
      expr: SUM((CAST(co2e_quantity_tonnes AS DOUBLE)) - (CAST(offset_quantity_tonnes AS DOUBLE)))
      comment: "Net CO2e after subtracting purchased offsets. The primary metric for net-zero progress reporting."
    - name: "avg_emission_factor"
      expr: AVG(CAST(emission_factor AS DOUBLE))
      comment: "Average emission factor across records. Tracks improvement in emission intensity methodology over time."
    - name: "total_energy_consumption_mwh"
      expr: SUM(CAST(energy_consumption_mwh AS DOUBLE))
      comment: "Total energy consumed in MWh associated with emission records. Supports energy-to-emissions intensity analysis."
    - name: "verified_emission_record_count"
      expr: COUNT(DISTINCT carbon_emission_id)
      comment: "Count of distinct emission records. Used to assess reporting coverage and completeness across facilities and activities."
    - name: "avg_carbon_intensity_factor"
      expr: AVG(CAST(carbon_intensity_factor AS DOUBLE))
      comment: "Average carbon intensity factor across emission records. Tracks efficiency of emission reduction per unit of activity."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`sustainability_carbon_offset`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Carbon offset portfolio KPIs tracking purchased, retired, and active offset credits. Used by sustainability and finance teams to manage net-zero commitments, offset spend, and registry compliance."
  source: "`vibe_consumer_goods_v1`.`sustainability`.`carbon_offset`"
  dimensions:
    - name: "offset_type"
      expr: offset_type
      comment: "Type of carbon offset project (e.g. reforestation, renewable energy, methane capture) for portfolio diversification analysis."
    - name: "project_type"
      expr: project_type
      comment: "Underlying project category driving the offset, used to assess co-benefits and alignment with nature-based solutions."
    - name: "carbon_offset_status"
      expr: carbon_offset_status
      comment: "Current status of the offset record (active, retired, expired) for portfolio management."
    - name: "registry"
      expr: registry
      comment: "Carbon registry where the offset is registered (e.g. Gold Standard, Verra VCS) for credibility and compliance filtering."
    - name: "project_country"
      expr: project_country
      comment: "Country of the offset project for geographic diversification and country-risk assessment."
    - name: "vintage_year"
      expr: vintage_year
      comment: "Year the carbon reduction occurred. Vintage year affects offset quality and market pricing."
    - name: "verification_standard"
      expr: verification_standard
      comment: "Standard used to verify the offset (e.g. ISO 14064, VCS) for assurance quality segmentation."
    - name: "reporting_year"
      expr: reporting_year
      comment: "Reporting year for the offset purchase or retirement, used for annual disclosure alignment."
  measures:
    - name: "total_offset_tonnes_co2e"
      expr: SUM(CAST(offset_tonnes_co2e AS DOUBLE))
      comment: "Total CO2e tonnes represented by purchased offsets. Core metric for net-zero gap analysis."
    - name: "total_credit_quantity_purchased"
      expr: SUM(CAST(credit_quantity_purchased AS DOUBLE))
      comment: "Total offset credits purchased. Tracks procurement volume against annual offset strategy targets."
    - name: "total_credit_quantity_retired"
      expr: SUM(CAST(credit_quantity_retired AS DOUBLE))
      comment: "Total offset credits retired (permanently cancelled). Retired credits are the only ones that count toward net-zero claims."
    - name: "total_offset_cost"
      expr: SUM(CAST(total_cost AS DOUBLE))
      comment: "Total spend on carbon offsets. Critical for sustainability budget management and cost-per-tonne benchmarking."
    - name: "avg_cost_per_tonne"
      expr: AVG(CAST(cost_per_tonne AS DOUBLE))
      comment: "Average cost per tonne of CO2e offset. Benchmarks procurement efficiency against market rates."
    - name: "avg_price_per_tonne"
      expr: AVG(CAST(price_per_tonne AS DOUBLE))
      comment: "Average market price per tonne across the offset portfolio. Tracks portfolio valuation and market exposure."
    - name: "retirement_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(credit_quantity_retired AS DOUBLE)) / NULLIF(SUM(CAST(credit_quantity_purchased AS DOUBLE)), 0), 2)
      comment: "Percentage of purchased credits that have been retired. High retirement rate indicates active use of offsets toward net-zero claims rather than speculative holding."
    - name: "active_offset_project_count"
      expr: COUNT(DISTINCT carbon_offset_id)
      comment: "Number of distinct offset projects in the portfolio. Tracks diversification and coverage of the offset strategy."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`sustainability_circular_initiative`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Circular economy initiative KPIs tracking material diversion, waste reduction, investment, and consumer participation. Used by sustainability and innovation teams to manage circular economy program ROI and target attainment."
  source: "`vibe_consumer_goods_v1`.`sustainability`.`circular_initiative`"
  dimensions:
    - name: "initiative_type"
      expr: initiative_type
      comment: "Type of circular initiative (recycling, reuse, refill, repair) for program portfolio management."
    - name: "circularity_strategy"
      expr: circularity_strategy
      comment: "Circular economy strategy applied (reduce, reuse, recycle, recover) for Ellen MacArthur Framework alignment."
    - name: "circular_initiative_status"
      expr: circular_initiative_status
      comment: "Current status of the initiative for pipeline and resource management."
    - name: "progress_status"
      expr: progress_status
      comment: "Progress status (on-track, behind, completed) for executive steering."
    - name: "lifecycle_stage"
      expr: lifecycle_stage
      comment: "Lifecycle stage targeted by the initiative (design, production, use, end-of-life) for value chain coverage."
    - name: "geographic_scope"
      expr: geographic_scope
      comment: "Geographic scope of the initiative for regional program management."
    - name: "is_public_reportable"
      expr: is_public_reportable
      comment: "Flag for publicly reportable initiatives. Tracks transparency and external communication pipeline."
  measures:
    - name: "total_material_diverted_tonnes"
      expr: SUM(CAST(material_diverted_tonnes AS DOUBLE))
      comment: "Total material diverted from waste streams through circular initiatives. Primary circular economy impact KPI."
    - name: "total_material_recovered_tonnes"
      expr: SUM(CAST(material_recovered_tonnes AS DOUBLE))
      comment: "Total material recovered and re-entered into the value chain. Tracks circular material flow performance."
    - name: "total_waste_reduction_tonnes"
      expr: SUM(CAST(waste_reduction_tonnes AS DOUBLE))
      comment: "Total waste reduction achieved through circular initiatives. Tracks absolute waste reduction contribution."
    - name: "total_investment_amount"
      expr: SUM(CAST(investment_amount AS DOUBLE))
      comment: "Total investment in circular economy initiatives. Tracks financial commitment to circular transformation."
    - name: "avg_consumer_participation_rate_pct"
      expr: AVG(CAST(consumer_participation_rate_pct AS DOUBLE))
      comment: "Average consumer participation rate in circular programs. Tracks consumer engagement and program adoption."
    - name: "total_carbon_footprint_avoided_tonnes"
      expr: SUM(CAST(carbon_footprint_avoided_tonnes AS DOUBLE))
      comment: "Total CO2e avoided through circular initiatives. Links circular economy to climate targets."
    - name: "total_energy_savings_mwh"
      expr: SUM(CAST(energy_savings_mwh AS DOUBLE))
      comment: "Total energy savings from circular initiatives in MWh. Tracks co-benefits of circular economy for energy targets."
    - name: "active_initiative_count"
      expr: COUNT(DISTINCT circular_initiative_id)
      comment: "Total number of circular economy initiatives. Tracks program breadth and portfolio coverage."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`sustainability_commitment_progress`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Granular ESG commitment progress KPIs tracking measured values, variance to target, and trajectory status over reporting periods. Used by sustainability managers to identify at-risk commitments and course-correct."
  source: "`vibe_consumer_goods_v1`.`sustainability`.`commitment_progress`"
  dimensions:
    - name: "commitment_progress_status"
      expr: commitment_progress_status
      comment: "Status of the progress record (on-track, behind, achieved) for operational triage."
    - name: "trajectory_status"
      expr: trajectory_status
      comment: "Forward-looking trajectory assessment (improving, stable, deteriorating) for proactive intervention."
    - name: "on_track_flag"
      expr: on_track_flag
      comment: "Boolean flag indicating whether the commitment is on track. Used for executive red/amber/green dashboards."
    - name: "period_type"
      expr: period_type
      comment: "Reporting period type (annual, quarterly, monthly) for cadence-appropriate analysis."
    - name: "reporting_year"
      expr: reporting_year
      comment: "Reporting year for year-over-year progress comparison."
    - name: "milestone_name"
      expr: milestone_name
      comment: "Named milestone within the commitment lifecycle for milestone-level tracking."
    - name: "verification_status"
      expr: verification_status
      comment: "Verification status of the progress record for data assurance filtering."
    - name: "reporting_period_start_date"
      expr: reporting_period_start_date
      comment: "Start date of the reporting period. Enables time-series analysis of progress cadence."
  measures:
    - name: "avg_percentage_of_target"
      expr: AVG(CAST(percentage_of_target AS DOUBLE))
      comment: "Average percentage of target achieved across progress records. Primary KPI for ESG commitment health monitoring."
    - name: "total_measured_value"
      expr: SUM(CAST(measured_value AS DOUBLE))
      comment: "Sum of measured values across progress records. Aggregated actual performance against ESG targets."
    - name: "total_target_value"
      expr: SUM(CAST(target_value AS DOUBLE))
      comment: "Sum of target values across progress records. Denominator for aggregate attainment rate calculation."
    - name: "total_variance"
      expr: SUM(CAST(variance AS DOUBLE))
      comment: "Total variance between actual and target values. Negative variance signals underperformance requiring executive attention."
    - name: "avg_progress_pct"
      expr: AVG(CAST(progress_pct AS DOUBLE))
      comment: "Average progress percentage across all commitment progress records. Used in steering committee dashboards."
    - name: "on_track_commitment_count"
      expr: COUNT(DISTINCT CASE WHEN on_track_flag = TRUE THEN commitment_progress_id END)
      comment: "Count of progress records flagged as on-track. Used to compute on-track rate for board ESG scorecards."
    - name: "total_progress_record_count"
      expr: COUNT(DISTINCT commitment_progress_id)
      comment: "Total number of progress records. Denominator for on-track rate and coverage completeness assessment."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`sustainability_deforestation_assessment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Deforestation risk assessment KPIs tracking EUDR compliance, forest cover change, and risk scores across commodity supply chains. Used by procurement and sustainability teams to manage deforestation-free sourcing obligations under EUDR and TNFD."
  source: "`vibe_consumer_goods_v1`.`sustainability`.`deforestation_assessment`"
  dimensions:
    - name: "assessment_status"
      expr: assessment_status
      comment: "Status of the deforestation assessment (pending, completed, escalated) for pipeline management."
    - name: "eudr_compliance_status"
      expr: eudr_compliance_status
      comment: "EU Deforestation Regulation compliance status. Critical regulatory KPI with market access implications."
    - name: "risk_level"
      expr: risk_level
      comment: "Deforestation risk level (low, medium, high) for supplier prioritization and due diligence."
    - name: "commodity_type"
      expr: commodity_type
      comment: "Commodity type assessed (palm oil, soy, beef, timber, cocoa, coffee, rubber) for EUDR-regulated commodity tracking."
    - name: "deforestation_free_flag"
      expr: deforestation_free_flag
      comment: "Flag indicating deforestation-free status. Core EUDR and responsible sourcing compliance indicator."
    - name: "eudr_compliant_flag"
      expr: eudr_compliant_flag
      comment: "EUDR compliance flag for regulatory reporting and market access management."
    - name: "origin_country"
      expr: origin_country
      comment: "Country of origin for the assessed commodity. Used for country-level deforestation risk mapping."
  measures:
    - name: "total_assessment_count"
      expr: COUNT(DISTINCT deforestation_assessment_id)
      comment: "Total deforestation assessments conducted. Tracks supply chain due diligence coverage under EUDR."
    - name: "eudr_compliant_count"
      expr: COUNT(DISTINCT CASE WHEN eudr_compliant_flag = TRUE THEN deforestation_assessment_id END)
      comment: "Number of assessments confirming EUDR compliance. Tracks regulatory compliance posture for EU market access."
    - name: "eudr_compliance_rate_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN eudr_compliant_flag = TRUE THEN deforestation_assessment_id END) / NULLIF(COUNT(DISTINCT deforestation_assessment_id), 0), 2)
      comment: "Percentage of assessed supply chains that are EUDR compliant. Headline regulatory compliance KPI for EU market access."
    - name: "avg_risk_score"
      expr: AVG(CAST(risk_score AS DOUBLE))
      comment: "Average deforestation risk score across assessments. Used to prioritize supplier engagement and due diligence resources."
    - name: "avg_forest_cover_change_pct"
      expr: AVG(CAST(forest_cover_change_percent AS DOUBLE))
      comment: "Average forest cover change percentage across assessed areas. Tracks deforestation trend in supply sheds."
    - name: "total_forest_area_ha"
      expr: SUM(CAST(forest_area_ha AS DOUBLE))
      comment: "Total forest area covered by assessments in hectares. Tracks scope of deforestation due diligence program."
    - name: "high_risk_assessment_count"
      expr: COUNT(DISTINCT CASE WHEN risk_level = 'High' THEN deforestation_assessment_id END)
      comment: "Number of high-risk deforestation assessments. Drives supplier escalation and sourcing diversification decisions."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`sustainability_energy_certificate`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Renewable energy certificate (REC/REGO/GO) portfolio KPIs tracking certified MWh, procurement costs, and retirement status. Used by sustainability and energy procurement teams to manage RE100 compliance and renewable energy claims."
  source: "`vibe_consumer_goods_v1`.`sustainability`.`energy_certificate`"
  dimensions:
    - name: "certificate_type"
      expr: certificate_type
      comment: "Type of energy certificate (REC, REGO, GO, I-REC) for market and regulatory segmentation."
    - name: "energy_source"
      expr: energy_source
      comment: "Renewable energy source (solar, wind, hydro, biomass) for technology portfolio management."
    - name: "energy_certificate_status"
      expr: energy_certificate_status
      comment: "Current status of the certificate (active, retired, expired) for portfolio management."
    - name: "vintage_year"
      expr: vintage_year
      comment: "Year of energy generation. Vintage year affects certificate quality and additionality claims."
    - name: "issuing_body"
      expr: issuing_body
      comment: "Body that issued the certificate for credibility and market recognition assessment."
    - name: "reporting_year"
      expr: reporting_year
      comment: "Reporting year for annual renewable energy disclosure."
    - name: "iso_14001_compliance_flag"
      expr: iso_14001_compliance_flag
      comment: "ISO 14001 compliance flag for environmental management system alignment."
  measures:
    - name: "total_mwh_certified"
      expr: SUM(CAST(mwh_certified AS DOUBLE))
      comment: "Total MWh of renewable energy certified. Primary RE100 and renewable energy target tracking KPI."
    - name: "total_cost_amount"
      expr: SUM(CAST(cost_amount AS DOUBLE))
      comment: "Total cost of renewable energy certificates. Tracks financial investment in renewable energy procurement."
    - name: "avg_renewable_energy_pct"
      expr: AVG(CAST(renewable_energy_percentage AS DOUBLE))
      comment: "Average renewable energy percentage across certificate records. Tracks RE100 portfolio composition."
    - name: "active_certificate_count"
      expr: COUNT(DISTINCT CASE WHEN energy_certificate_status = 'Active' THEN energy_certificate_id END)
      comment: "Number of active renewable energy certificates. Tracks current renewable energy coverage."
    - name: "total_certificate_count"
      expr: COUNT(DISTINCT energy_certificate_id)
      comment: "Total renewable energy certificates in the portfolio. Tracks procurement program breadth."
    - name: "avg_price_per_mwh"
      expr: AVG(CAST(price_amount AS DOUBLE))
      comment: "Average price per MWh of certified renewable energy. Benchmarks procurement efficiency against market rates."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`sustainability_energy_consumption`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Energy efficiency and renewable energy KPIs tracking total consumption, renewable mix, and intensity ratios. Used by operations and sustainability teams to manage energy costs, meet RE100 targets, and report under GRI 302."
  source: "`vibe_consumer_goods_v1`.`sustainability`.`energy_consumption`"
  dimensions:
    - name: "energy_type"
      expr: energy_type
      comment: "Type of energy consumed (electricity, natural gas, steam, diesel) for source-specific reduction targeting."
    - name: "energy_source"
      expr: energy_source
      comment: "Specific energy source for renewable vs. non-renewable segmentation."
    - name: "energy_consumption_status"
      expr: energy_consumption_status
      comment: "Record status for data quality filtering in regulatory submissions."
    - name: "scope"
      expr: scope
      comment: "GHG Protocol scope associated with the energy consumption for integrated emissions reporting."
    - name: "iso_50001_compliance_flag"
      expr: iso_50001_compliance_flag
      comment: "ISO 50001 energy management compliance flag for certification tracking."
    - name: "reporting_year"
      expr: reporting_year
      comment: "Reporting year for annual energy disclosure and year-over-year trend analysis."
    - name: "is_estimated"
      expr: is_estimated
      comment: "Flag indicating estimated vs. metered data. Used to assess data quality and prioritize metering investments."
  measures:
    - name: "total_energy_quantity_kwh"
      expr: SUM(CAST(energy_quantity AS DOUBLE))
      comment: "Total energy consumed in kWh. Primary absolute energy KPI for GRI 302 and CDP Climate reporting."
    - name: "total_renewable_kwh"
      expr: SUM(CAST(renewable_kwh AS DOUBLE))
      comment: "Total renewable energy consumed in kWh. Tracks RE100 and renewable energy target progress."
    - name: "total_co2e_tonnes"
      expr: SUM(CAST(co2e_tonnes AS DOUBLE))
      comment: "Total CO2e emissions associated with energy consumption. Links energy use to Scope 2 emissions reporting."
    - name: "avg_renewable_energy_pct"
      expr: AVG(CAST(renewable_energy_percentage AS DOUBLE))
      comment: "Average renewable energy percentage across consumption records. Tracks RE100 and clean energy transition progress."
    - name: "avg_energy_intensity_ratio"
      expr: AVG(CAST(energy_intensity_ratio AS DOUBLE))
      comment: "Average energy intensity ratio (energy per unit of output). Normalizes energy use for efficiency benchmarking."
    - name: "renewable_energy_share_pct"
      expr: ROUND(100.0 * SUM(CAST(renewable_kwh AS DOUBLE)) / NULLIF(SUM(CAST(energy_quantity AS DOUBLE)), 0), 2)
      comment: "Percentage of total energy from renewable sources. Headline RE100 and clean energy transition KPI."
    - name: "total_energy_cost"
      expr: SUM(CAST(cost_amount AS DOUBLE))
      comment: "Total energy cost. Tracks financial exposure to energy price volatility and ROI of efficiency investments."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`sustainability_environmental_incident`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Environmental incident KPIs tracking frequency, severity, cost, and remediation status of environmental events. Used by EHS, legal, and sustainability teams to manage regulatory risk, fines, and remediation obligations."
  source: "`vibe_consumer_goods_v1`.`sustainability`.`environmental_incident`"
  dimensions:
    - name: "incident_type"
      expr: incident_type
      comment: "Type of environmental incident (spill, emission exceedance, permit violation) for risk categorization."
    - name: "severity_level"
      expr: severity_level
      comment: "Severity classification of the incident (minor, moderate, major, critical) for escalation and resource prioritization."
    - name: "environmental_incident_status"
      expr: environmental_incident_status
      comment: "Current status of the incident (open, under investigation, remediated, closed) for case management."
    - name: "remediation_status"
      expr: remediation_status
      comment: "Status of remediation activities for tracking environmental restoration obligations."
    - name: "regulatory_reportable_flag"
      expr: regulatory_reportable_flag
      comment: "Flag indicating regulatory reporting obligation. Tracks legal compliance exposure."
    - name: "root_cause_category"
      expr: root_cause_category
      comment: "Root cause category for systemic issue identification and prevention program targeting."
    - name: "incident_subtype"
      expr: incident_subtype
      comment: "Sub-classification of incident type for granular EHS program management."
  measures:
    - name: "total_incident_count"
      expr: COUNT(DISTINCT environmental_incident_id)
      comment: "Total number of environmental incidents. Primary EHS KPI for regulatory compliance and safety culture assessment."
    - name: "total_estimated_cost"
      expr: SUM(CAST(estimated_cost AS DOUBLE))
      comment: "Total estimated cost of environmental incidents including remediation and fines. Tracks financial exposure from environmental risk."
    - name: "total_fine_amount"
      expr: SUM(CAST(fine_amount AS DOUBLE))
      comment: "Total regulatory fines incurred from environmental incidents. Direct financial consequence of non-compliance."
    - name: "total_quantity_released"
      expr: SUM(CAST(quantity_released AS DOUBLE))
      comment: "Total quantity of substance released in environmental incidents. Tracks environmental impact magnitude."
    - name: "regulatory_reportable_incident_count"
      expr: COUNT(DISTINCT CASE WHEN regulatory_reportable_flag = TRUE THEN environmental_incident_id END)
      comment: "Number of incidents requiring regulatory reporting. Tracks legal compliance obligations and reputational risk."
    - name: "open_incident_count"
      expr: COUNT(DISTINCT CASE WHEN environmental_incident_status NOT IN ('Closed', 'Resolved') THEN environmental_incident_id END)
      comment: "Number of open environmental incidents. Tracks outstanding remediation obligations and ongoing risk exposure."
    - name: "avg_incident_cost"
      expr: AVG(CAST(estimated_cost AS DOUBLE))
      comment: "Average cost per environmental incident. Benchmarks incident severity and informs risk provisioning."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`sustainability_environmental_permit`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Monitors environmental permit compliance, expiry risk, and emission/discharge limits to prevent regulatory violations and manage environmental license to operate."
  source: "`vibe_consumer_goods_v1`.`sustainability`.`environmental_permit`"
  dimensions:
    - name: "permit_type"
      expr: permit_type
      comment: "Type of environmental permit (e.g., air emission, water discharge, waste) for compliance domain tracking."
    - name: "compliance_status"
      expr: compliance_status
      comment: "Current compliance status of the permit — primary KPI for regulatory risk management."
    - name: "environmental_permit_status"
      expr: environmental_permit_status
      comment: "Lifecycle status of the permit (e.g., active, expired, under renewal) for portfolio management."
    - name: "renewal_status"
      expr: renewal_status
      comment: "Status of permit renewal process — proactive risk metric to prevent operational disruption."
    - name: "issuing_authority"
      expr: issuing_authority
      comment: "Regulatory authority issuing the permit for jurisdiction-specific compliance tracking."
    - name: "regulatory_framework"
      expr: regulatory_framework
      comment: "Regulatory framework governing the permit for compliance program alignment."
    - name: "inspection_status"
      expr: inspection_status
      comment: "Status of most recent regulatory inspection — indicates regulatory relationship health."
  measures:
    - name: "total_permits"
      expr: COUNT(1)
      comment: "Total number of environmental permits — baseline for compliance portfolio management."
    - name: "non_compliant_permit_count"
      expr: COUNT(CASE WHEN compliance_status NOT IN ('compliant', 'in compliance') THEN environmental_permit_id END)
      comment: "Number of permits with non-compliant status — critical risk metric for regulatory and operational management."
    - name: "avg_emission_limit"
      expr: AVG(CAST(emission_limit AS DOUBLE))
      comment: "Average permitted emission limit across permits — benchmarks regulatory headroom for operational planning."
    - name: "avg_discharge_limit"
      expr: AVG(CAST(discharge_limit AS DOUBLE))
      comment: "Average permitted discharge limit — measures regulatory constraints on water management operations."
    - name: "compliance_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN compliance_status IN ('compliant', 'in compliance') THEN environmental_permit_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of permits in compliance — headline regulatory compliance KPI for executive and board reporting."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`sustainability_esg_audit`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "ESG audit performance KPIs tracking audit scores, findings, and corrective action status across suppliers and facilities. Used by procurement, sustainability, and compliance teams to manage supply chain ESG risk."
  source: "`vibe_consumer_goods_v1`.`sustainability`.`esg_audit`"
  dimensions:
    - name: "audit_type"
      expr: audit_type
      comment: "Type of ESG audit (environmental, social, governance, combined) for pillar-specific risk management."
    - name: "audit_status"
      expr: audit_status
      comment: "Current audit status (planned, in-progress, completed, overdue) for audit program management."
    - name: "audit_standard"
      expr: audit_standard
      comment: "Audit standard applied (ISO 14001, SA8000, SMETA) for methodology and comparability."
    - name: "compliance_status"
      expr: compliance_status
      comment: "Overall compliance outcome of the audit for supplier risk tiering."
    - name: "corrective_action_status"
      expr: corrective_action_status
      comment: "Status of corrective action plans arising from audit findings. Tracks remediation progress."
    - name: "esg_audit_status"
      expr: esg_audit_status
      comment: "Lifecycle status of the ESG audit record for pipeline management."
    - name: "reporting_year"
      expr: reporting_year
      comment: "Reporting year for annual audit program coverage analysis."
    - name: "audit_method"
      expr: audit_method
      comment: "Audit method (on-site, remote, documentary) for resource planning and risk calibration."
  measures:
    - name: "avg_audit_score"
      expr: AVG(CAST(audit_score AS DOUBLE))
      comment: "Average ESG audit score across all audits. Primary KPI for supply chain ESG performance benchmarking."
    - name: "total_audit_count"
      expr: COUNT(DISTINCT esg_audit_id)
      comment: "Total number of ESG audits conducted. Tracks audit program coverage and cadence."
    - name: "avg_audit_duration_hours"
      expr: AVG(CAST(audit_duration_hours AS DOUBLE))
      comment: "Average audit duration in hours. Used for resource planning and audit efficiency benchmarking."
    - name: "total_audit_cost"
      expr: SUM(CAST(amount AS DOUBLE))
      comment: "Total cost associated with ESG audits. Tracks sustainability assurance investment."
    - name: "high_risk_audit_count"
      expr: COUNT(DISTINCT CASE WHEN risk_severity IN ('High', 'Critical') THEN esg_audit_id END)
      comment: "Number of audits with high or critical risk severity findings. Triggers supplier escalation and remediation programs."
    - name: "carbon_emission_flagged_audit_count"
      expr: COUNT(DISTINCT CASE WHEN carbon_emission_flag = TRUE THEN esg_audit_id END)
      comment: "Number of audits flagging carbon emission issues. Identifies suppliers requiring decarbonization support."
    - name: "waste_management_flagged_audit_count"
      expr: COUNT(DISTINCT CASE WHEN waste_management_flag = TRUE THEN esg_audit_id END)
      comment: "Number of audits flagging waste management issues. Drives supplier waste reduction programs."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`sustainability_esg_commitment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "ESG commitment tracking KPIs measuring target-setting, progress, and disclosure status across environmental, social, and governance pillars. Used by the Chief Sustainability Officer and board to govern science-based targets and public commitments."
  source: "`vibe_consumer_goods_v1`.`sustainability`.`esg_commitment`"
  dimensions:
    - name: "commitment_type"
      expr: commitment_type
      comment: "Type of ESG commitment (e.g. net-zero, water neutrality, social equity) for pillar-level portfolio management."
    - name: "pillar"
      expr: pillar
      comment: "ESG pillar (Environmental, Social, Governance) for board-level balanced scorecard reporting."
    - name: "esg_commitment_status"
      expr: esg_commitment_status
      comment: "Current status of the commitment (on-track, at-risk, achieved, missed) for executive escalation."
    - name: "is_science_based_target"
      expr: is_science_based_target
      comment: "Flag indicating SBTi-aligned commitments, which carry higher credibility with investors and regulators."
    - name: "reporting_framework"
      expr: reporting_framework
      comment: "Framework under which the commitment is reported (GRI, TCFD, CDP, SASB) for disclosure alignment."
    - name: "target_year"
      expr: target_year
      comment: "Year by which the commitment target must be achieved. Used for timeline risk assessment."
    - name: "scope"
      expr: scope
      comment: "Organizational scope of the commitment (global, regional, business unit) for boundary clarity."
    - name: "public_disclosure_flag"
      expr: public_disclosure_flag
      comment: "Whether the commitment is publicly disclosed. Tracks transparency and reputational risk exposure."
  measures:
    - name: "total_commitment_count"
      expr: COUNT(DISTINCT esg_commitment_id)
      comment: "Total number of active ESG commitments. Tracks breadth of the sustainability agenda."
    - name: "avg_progress_pct"
      expr: AVG(CAST(progress_pct AS DOUBLE))
      comment: "Average progress percentage across all commitments. Top-level indicator of ESG program health for board reporting."
    - name: "total_target_value"
      expr: SUM(CAST(target_value AS DOUBLE))
      comment: "Sum of quantitative target values across commitments. Provides aggregate ambition level for investor communications."
    - name: "total_current_value"
      expr: SUM(CAST(current_value AS DOUBLE))
      comment: "Sum of current achieved values across commitments. Compared against target_value to compute aggregate gap."
    - name: "science_based_target_count"
      expr: COUNT(DISTINCT CASE WHEN is_science_based_target = TRUE THEN esg_commitment_id END)
      comment: "Number of SBTi-aligned commitments. Investors and ESG raters specifically track SBT adoption as a quality signal."
    - name: "publicly_disclosed_commitment_count"
      expr: COUNT(DISTINCT CASE WHEN public_disclosure_flag = TRUE THEN esg_commitment_id END)
      comment: "Number of commitments publicly disclosed. Tracks transparency posture and reputational risk management."
    - name: "avg_baseline_value"
      expr: AVG(CAST(baseline_value AS DOUBLE))
      comment: "Average baseline value at commitment inception. Used to contextualize progress relative to starting point."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`sustainability_esg_disclosure`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "ESG disclosure KPIs tracking reported emissions, energy, water, and waste metrics across disclosure frameworks. Used by investor relations, legal, and sustainability teams to manage external reporting quality and completeness."
  source: "`vibe_consumer_goods_v1`.`sustainability`.`esg_disclosure`"
  dimensions:
    - name: "disclosure_framework"
      expr: disclosure_framework
      comment: "Reporting framework (GRI, CDP, TCFD, SASB, CSRD) for framework-specific disclosure management."
    - name: "disclosure_status"
      expr: disclosure_status
      comment: "Status of the disclosure (draft, submitted, published) for disclosure pipeline management."
    - name: "esg_disclosure_status"
      expr: esg_disclosure_status
      comment: "Lifecycle status of the ESG disclosure record for governance and approval tracking."
    - name: "assurance_level"
      expr: assurance_level
      comment: "Level of external assurance (limited, reasonable, none) for disclosure credibility assessment."
    - name: "reporting_year"
      expr: reporting_year
      comment: "Reporting year for annual disclosure comparison and trend analysis."
    - name: "fsc_certified"
      expr: fsc_certified
      comment: "FSC certification status reported in the disclosure for responsible sourcing transparency."
    - name: "rspo_certified"
      expr: rspo_certified
      comment: "RSPO certification status reported in the disclosure for palm oil responsible sourcing."
  measures:
    - name: "total_scope1_emissions"
      expr: SUM(CAST(carbon_emissions_scope1 AS DOUBLE))
      comment: "Total Scope 1 direct GHG emissions reported in disclosures. Primary regulatory and investor reporting metric."
    - name: "total_scope2_emissions"
      expr: SUM(CAST(carbon_emissions_scope2 AS DOUBLE))
      comment: "Total Scope 2 indirect GHG emissions from purchased energy. Tracks renewable energy transition impact."
    - name: "total_scope3_emissions"
      expr: SUM(CAST(carbon_emissions_scope3 AS DOUBLE))
      comment: "Total Scope 3 value chain GHG emissions. Largest emissions category for consumer goods companies."
    - name: "total_carbon_emissions_disclosed"
      expr: SUM(CAST(total_carbon_emissions AS DOUBLE))
      comment: "Total carbon emissions across all scopes as disclosed. Headline climate disclosure metric."
    - name: "avg_renewable_energy_pct_disclosed"
      expr: AVG(CAST(renewable_energy_percentage AS DOUBLE))
      comment: "Average renewable energy percentage as reported in disclosures. Tracks RE100 progress in external reporting."
    - name: "avg_packaging_recyclability_rate"
      expr: AVG(CAST(packaging_recyclability_rate AS DOUBLE))
      comment: "Average packaging recyclability rate as disclosed. Tracks packaging sustainability claims in external reporting."
    - name: "total_energy_consumption_disclosed"
      expr: SUM(CAST(energy_consumption AS DOUBLE))
      comment: "Total energy consumption as reported in ESG disclosures. Tracks GRI 302 reporting completeness."
    - name: "total_disclosure_count"
      expr: COUNT(DISTINCT esg_disclosure_id)
      comment: "Total ESG disclosures produced. Tracks reporting program coverage across frameworks and periods."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`sustainability_materiality_assessment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "ESG materiality assessment KPIs tracking topic scores, stakeholder importance, and business impact ratings. Used by sustainability and investor relations teams to prioritize ESG topics, align with double materiality requirements, and govern disclosure scope."
  source: "`vibe_consumer_goods_v1`.`sustainability`.`materiality_assessment`"
  dimensions:
    - name: "assessment_type"
      expr: assessment_type
      comment: "Type of materiality assessment (single, double, impact) for CSRD and GRI alignment."
    - name: "materiality_assessment_status"
      expr: materiality_assessment_status
      comment: "Status of the assessment for governance and approval tracking."
    - name: "topic_category"
      expr: topic_category
      comment: "ESG topic category (climate, water, labor, governance) for pillar-level materiality analysis."
    - name: "is_material_flag"
      expr: is_material_flag
      comment: "Flag indicating whether the topic is assessed as material. Core output of the materiality process."
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level of the material topic for resource allocation and disclosure prioritization."
    - name: "risk_category"
      expr: risk_category
      comment: "Risk category associated with the material topic for integrated risk management."
    - name: "assessment_year"
      expr: assessment_year
      comment: "Year of the materiality assessment for trend analysis and reassessment cadence tracking."
  measures:
    - name: "avg_materiality_score"
      expr: AVG(CAST(materiality_score AS DOUBLE))
      comment: "Average materiality score across assessed topics. Tracks overall ESG materiality landscape for disclosure prioritization."
    - name: "avg_business_impact_score"
      expr: AVG(CAST(business_impact_score AS DOUBLE))
      comment: "Average business impact score. Tracks financial materiality of ESG topics for CSRD double materiality compliance."
    - name: "avg_stakeholder_importance_score"
      expr: AVG(CAST(stakeholder_importance_score AS DOUBLE))
      comment: "Average stakeholder importance score. Tracks impact materiality from stakeholder perspective for GRI and CSRD."
    - name: "material_topic_count"
      expr: COUNT(DISTINCT CASE WHEN is_material_flag = TRUE THEN materiality_assessment_id END)
      comment: "Number of topics assessed as material. Tracks scope of ESG disclosure obligations."
    - name: "total_topic_count"
      expr: COUNT(DISTINCT materiality_assessment_id)
      comment: "Total topics assessed. Tracks comprehensiveness of the materiality assessment process."
    - name: "materiality_rate_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN is_material_flag = TRUE THEN materiality_assessment_id END) / NULLIF(COUNT(DISTINCT materiality_assessment_id), 0), 2)
      comment: "Percentage of assessed topics deemed material. Tracks ESG disclosure scope and materiality threshold calibration."
    - name: "avg_data_quality_score"
      expr: AVG(CAST(data_quality_score AS DOUBLE))
      comment: "Average data quality score across materiality assessments. Tracks reliability of the materiality process inputs."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`sustainability_packaging_profile`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Packaging sustainability KPIs tracking recyclability, recycled content, PCR usage, and carbon footprint across the SKU portfolio. Used by product development and sustainability teams to meet EPR obligations and packaging reduction targets."
  source: "`vibe_consumer_goods_v1`.`sustainability`.`packaging_profile`"
  dimensions:
    - name: "packaging_material_type"
      expr: packaging_material_type
      comment: "Primary packaging material type (plastic, glass, paper, aluminum) for material-specific sustainability targeting."
    - name: "packaging_profile_status"
      expr: packaging_profile_status
      comment: "Status of the packaging profile record for active portfolio filtering."
    - name: "recyclable_flag"
      expr: recyclable_flag
      comment: "Whether the packaging is recyclable. Core metric for EPR compliance and consumer communication."
    - name: "compostable_flag"
      expr: compostable_flag
      comment: "Whether the packaging is compostable. Tracks bio-based and circular packaging adoption."
    - name: "reusable_flag"
      expr: reusable_flag
      comment: "Whether the packaging is reusable. Tracks highest-value circular economy packaging formats."
    - name: "epr_compliance_flag"
      expr: epr_compliance_flag
      comment: "Extended Producer Responsibility compliance status. Regulatory compliance KPI with direct financial penalty risk."
    - name: "fsc_certified"
      expr: fsc_certified
      comment: "FSC certification status for paper/fiber packaging. Tracks responsible sourcing compliance."
    - name: "reporting_year"
      expr: reporting_year
      comment: "Reporting year for annual packaging sustainability disclosure."
  measures:
    - name: "avg_recycled_content_pct"
      expr: AVG(CAST(recycled_content_pct AS DOUBLE))
      comment: "Average recycled content percentage across packaging profiles. Tracks progress toward recycled content targets (e.g. 30% PCR by 2025)."
    - name: "avg_pcr_content_pct"
      expr: AVG(CAST(pcr_content_pct AS DOUBLE))
      comment: "Average post-consumer recycled (PCR) content percentage. PCR is the highest-value recycled content type for circular economy claims."
    - name: "avg_carbon_footprint_kg_co2e"
      expr: AVG(CAST(carbon_footprint_kg_co2e AS DOUBLE))
      comment: "Average packaging carbon footprint in kg CO2e per SKU. Tracks packaging contribution to product-level LCA."
    - name: "avg_sustainability_score"
      expr: AVG(CAST(sustainability_score AS DOUBLE))
      comment: "Average composite sustainability score across packaging profiles. Used for portfolio-level packaging sustainability benchmarking."
    - name: "recyclable_sku_count"
      expr: COUNT(DISTINCT CASE WHEN recyclable_flag = TRUE THEN packaging_profile_id END)
      comment: "Number of SKUs with recyclable packaging. Tracks progress toward 100% recyclable packaging commitments."
    - name: "epr_compliant_sku_count"
      expr: COUNT(DISTINCT CASE WHEN epr_compliance_flag = TRUE THEN packaging_profile_id END)
      comment: "Number of SKUs with EPR-compliant packaging. Tracks regulatory compliance exposure and fee liability."
    - name: "recyclability_rate_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN recyclable_flag = TRUE THEN packaging_profile_id END) / NULLIF(COUNT(DISTINCT packaging_profile_id), 0), 2)
      comment: "Percentage of packaging profiles that are recyclable. Headline packaging sustainability KPI for investor and consumer reporting."
    - name: "avg_plastic_weight_grams"
      expr: AVG(CAST(plastic_weight_grams AS DOUBLE))
      comment: "Average plastic weight per packaging profile. Tracks plastic reduction progress and lightweighting initiatives."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`sustainability_product_lca`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Product lifecycle assessment KPIs tracking carbon footprint, water footprint, and energy footprint per SKU. Used by product development and sustainability teams to identify hotspots, prioritize reformulation, and support eco-label claims."
  source: "`vibe_consumer_goods_v1`.`sustainability`.`product_lca`"
  dimensions:
    - name: "lca_methodology"
      expr: lca_methodology
      comment: "LCA methodology applied (cradle-to-gate, cradle-to-grave, cradle-to-cradle) for boundary comparability."
    - name: "product_lca_status"
      expr: product_lca_status
      comment: "Status of the LCA study (draft, peer-reviewed, published) for data quality filtering."
    - name: "iso_14040_compliance_flag"
      expr: iso_14040_compliance_flag
      comment: "ISO 14040/14044 compliance flag. Required for credible third-party verified LCA claims."
    - name: "third_party_verified"
      expr: third_party_verified
      comment: "Whether the LCA has been independently verified. Verified LCAs carry higher credibility for eco-labels and investor disclosure."
    - name: "lca_study_type"
      expr: lca_study_type
      comment: "Type of LCA study (comparative, attributional, consequential) for methodology segmentation."
    - name: "product_category"
      expr: product_category
      comment: "Product category for portfolio-level LCA benchmarking and hotspot identification."
    - name: "verification_status"
      expr: verification_status
      comment: "Verification status of the LCA for assurance quality filtering."
  measures:
    - name: "avg_carbon_footprint_kg_co2e"
      expr: AVG(CAST(carbon_footprint_kg_co2e AS DOUBLE))
      comment: "Average product carbon footprint in kg CO2e per functional unit. Primary KPI for product-level decarbonization targeting."
    - name: "avg_water_footprint_liters"
      expr: AVG(CAST(water_footprint_liters AS DOUBLE))
      comment: "Average product water footprint in liters per functional unit. Tracks water stewardship at product level."
    - name: "avg_energy_footprint_mj"
      expr: AVG(CAST(energy_footprint_mj AS DOUBLE))
      comment: "Average product energy footprint in MJ per functional unit. Identifies energy-intensive products for reformulation."
    - name: "total_carbon_footprint_kg"
      expr: SUM(CAST(total_carbon_footprint_kg AS DOUBLE))
      comment: "Total carbon footprint across all LCA-assessed products. Portfolio-level climate impact metric."
    - name: "verified_lca_count"
      expr: COUNT(DISTINCT CASE WHEN third_party_verified = TRUE THEN product_lca_id END)
      comment: "Number of third-party verified LCAs. Tracks credibility of eco-label and sustainability claims portfolio."
    - name: "total_lca_count"
      expr: COUNT(DISTINCT product_lca_id)
      comment: "Total number of LCA studies. Tracks coverage of the product portfolio with lifecycle assessments."
    - name: "lca_verification_rate_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN third_party_verified = TRUE THEN product_lca_id END) / NULLIF(COUNT(DISTINCT product_lca_id), 0), 2)
      comment: "Percentage of LCAs that are third-party verified. Tracks credibility and assurance quality of the LCA portfolio."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`sustainability_social_impact_program`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Social impact program KPIs tracking beneficiary reach, investment, and outcome metrics. Used by sustainability and corporate affairs teams to manage social license to operate, UN SDG alignment, and ESG social pillar performance."
  source: "`vibe_consumer_goods_v1`.`sustainability`.`social_impact_program`"
  dimensions:
    - name: "social_impact_program_type"
      expr: social_impact_program_type
      comment: "Type of social impact program (community development, education, health, livelihoods) for SDG alignment."
    - name: "focus_area"
      expr: focus_area
      comment: "Focus area of the program for thematic portfolio management and SDG mapping."
    - name: "social_impact_program_status"
      expr: social_impact_program_status
      comment: "Current program status for pipeline and resource management."
    - name: "geographic_focus"
      expr: geographic_focus
      comment: "Geographic focus of the program for regional social investment tracking."
    - name: "un_sdg_alignment"
      expr: un_sdg_alignment
      comment: "UN Sustainable Development Goal alignment for ESG reporting and investor communication."
    - name: "is_public"
      expr: is_public
      comment: "Whether the program is publicly disclosed. Tracks transparency and reputational value."
    - name: "reporting_year"
      expr: reporting_year
      comment: "Reporting year for annual social impact disclosure."
  measures:
    - name: "total_beneficiaries_reached"
      expr: SUM(CAST(beneficiaries_reached AS DOUBLE))
      comment: "Total beneficiaries reached across social impact programs. Primary social impact KPI for ESG reporting and investor communications."
    - name: "total_investment_amount"
      expr: SUM(CAST(investment_amount AS DOUBLE))
      comment: "Total investment in social impact programs. Tracks financial commitment to social license and community development."
    - name: "total_spend_amount"
      expr: SUM(CAST(spend_amount AS DOUBLE))
      comment: "Total actual spend on social impact programs. Tracks execution against social investment commitments."
    - name: "avg_outcome_metric_value"
      expr: AVG(CAST(outcome_metric_value AS DOUBLE))
      comment: "Average outcome metric value across programs. Tracks social impact effectiveness and program ROI."
    - name: "active_program_count"
      expr: COUNT(DISTINCT social_impact_program_id)
      comment: "Total number of social impact programs. Tracks breadth of social investment portfolio."
    - name: "cost_per_beneficiary"
      expr: ROUND(SUM(CAST(spend_amount AS DOUBLE)) / NULLIF(SUM(CAST(beneficiaries_reached AS DOUBLE)), 0), 2)
      comment: "Average cost per beneficiary reached. Tracks social investment efficiency and program cost-effectiveness."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`sustainability_sourcing_certification`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Responsible sourcing certification KPIs tracking certified volume, certification coverage, and compliance status across commodities and suppliers. Used by procurement and sustainability teams to manage deforestation-free and ethical sourcing commitments."
  source: "`vibe_consumer_goods_v1`.`sustainability`.`sourcing_certification`"
  dimensions:
    - name: "certification_type"
      expr: certification_type
      comment: "Type of sourcing certification (FSC, RSPO, Rainforest Alliance, Fairtrade) for standard-specific compliance tracking."
    - name: "certification_status"
      expr: certification_status
      comment: "Current certification status (active, expired, suspended) for compliance risk management."
    - name: "commodity"
      expr: commodity
      comment: "Commodity covered by the certification (palm oil, soy, timber, cocoa) for commodity-specific sourcing risk."
    - name: "sourcing_certification_status"
      expr: sourcing_certification_status
      comment: "Overall status of the sourcing certification record for portfolio management."
    - name: "chain_of_custody_model"
      expr: chain_of_custody_model
      comment: "Chain of custody model (mass balance, segregated, book-and-claim) for traceability quality assessment."
    - name: "renewal_required"
      expr: renewal_required
      comment: "Flag indicating upcoming renewal requirement. Tracks certification maintenance obligations."
    - name: "geographic_region"
      expr: geographic_region
      comment: "Geographic region of the certified sourcing for regional risk and coverage analysis."
  measures:
    - name: "total_annual_certified_volume"
      expr: SUM(CAST(annual_certified_volume AS DOUBLE))
      comment: "Total certified volume sourced annually. Primary KPI for responsible sourcing commitment attainment."
    - name: "active_certification_count"
      expr: COUNT(DISTINCT CASE WHEN certification_status = 'Active' THEN sourcing_certification_id END)
      comment: "Number of active sourcing certifications. Tracks certification portfolio coverage and compliance posture."
    - name: "total_certification_count"
      expr: COUNT(DISTINCT sourcing_certification_id)
      comment: "Total sourcing certifications in the portfolio. Tracks breadth of responsible sourcing program."
    - name: "certification_active_rate_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN certification_status = 'Active' THEN sourcing_certification_id END) / NULLIF(COUNT(DISTINCT sourcing_certification_id), 0), 2)
      comment: "Percentage of certifications that are currently active. Tracks compliance maintenance effectiveness."
    - name: "avg_certified_volume"
      expr: AVG(CAST(annual_certified_volume AS DOUBLE))
      comment: "Average certified volume per certification record. Benchmarks sourcing scale per certification."
    - name: "renewal_due_count"
      expr: COUNT(DISTINCT CASE WHEN renewal_required = TRUE THEN sourcing_certification_id END)
      comment: "Number of certifications requiring renewal. Tracks compliance maintenance workload and risk of lapse."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`sustainability_supplier_esg_eval`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Supplier ESG evaluation KPIs tracking environmental, social, and governance scores across the supply base. Used by procurement and sustainability teams to tier suppliers, manage ESG risk, and drive responsible sourcing."
  source: "`vibe_consumer_goods_v1`.`sustainability`.`supplier_esg_eval`"
  dimensions:
    - name: "assessment_type"
      expr: assessment_type
      comment: "Type of ESG assessment (self-assessment, third-party, desk review) for methodology segmentation."
    - name: "risk_level"
      expr: risk_level
      comment: "Overall supplier ESG risk level (low, medium, high, critical) for procurement risk tiering."
    - name: "overall_score_category"
      expr: overall_score_category
      comment: "Categorical rating of the overall ESG score for executive supplier scorecards."
    - name: "supplier_esg_eval_status"
      expr: supplier_esg_eval_status
      comment: "Status of the evaluation record for pipeline and coverage management."
    - name: "evaluation_framework"
      expr: evaluation_framework
      comment: "Framework used for evaluation (EcoVadis, CDP, proprietary) for methodology comparability."
    - name: "corrective_action_required"
      expr: corrective_action_required
      comment: "Flag indicating whether corrective action is required. Drives supplier development program prioritization."
    - name: "iso_14001_compliance"
      expr: iso_14001_compliance
      comment: "ISO 14001 environmental management certification status for supplier qualification."
    - name: "scope_3_included"
      expr: scope_3_included
      comment: "Flag indicating whether Scope 3 emissions are included in the evaluation. Tracks supply chain emissions coverage."
  measures:
    - name: "avg_overall_score"
      expr: AVG(CAST(overall_score AS DOUBLE))
      comment: "Average overall ESG score across evaluated suppliers. Primary KPI for supply chain ESG performance management."
    - name: "avg_environmental_score"
      expr: AVG(CAST(environmental_score AS DOUBLE))
      comment: "Average environmental pillar score. Tracks supplier environmental performance for procurement decisions."
    - name: "avg_social_score"
      expr: AVG(CAST(social_score AS DOUBLE))
      comment: "Average social pillar score. Tracks labor practices and human rights performance across the supply base."
    - name: "avg_governance_score"
      expr: AVG(CAST(governance_score AS DOUBLE))
      comment: "Average governance pillar score. Tracks anti-corruption, transparency, and ethics performance."
    - name: "avg_carbon_emission_score"
      expr: AVG(CAST(carbon_emission_score AS DOUBLE))
      comment: "Average carbon emission score across supplier evaluations. Tracks Scope 3 supply chain decarbonization progress."
    - name: "high_risk_supplier_count"
      expr: COUNT(DISTINCT CASE WHEN risk_level IN ('High', 'Critical') THEN supplier_esg_eval_id END)
      comment: "Number of suppliers rated high or critical ESG risk. Drives procurement escalation and supplier development investment."
    - name: "corrective_action_required_count"
      expr: COUNT(DISTINCT CASE WHEN corrective_action_required = TRUE THEN supplier_esg_eval_id END)
      comment: "Number of supplier evaluations requiring corrective action. Tracks remediation pipeline and supplier improvement obligations."
    - name: "total_evaluation_count"
      expr: COUNT(DISTINCT supplier_esg_eval_id)
      comment: "Total supplier ESG evaluations conducted. Tracks supply base coverage and assessment program completeness."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`sustainability_supply_chain_activity`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Supply chain sustainability activity KPIs tracking carbon footprint, energy consumption, water use, and waste generation across supply chain nodes. Used by sustainability and supply chain teams to manage Scope 3 emissions and supply chain ESG performance."
  source: "`vibe_consumer_goods_v1`.`sustainability`.`supply_chain_activity`"
  dimensions:
    - name: "activity_type"
      expr: activity_type
      comment: "Type of supply chain activity (manufacturing, transport, warehousing) for Scope 3 category mapping."
    - name: "activity_category"
      expr: activity_category
      comment: "Category of supply chain activity for GHG Protocol Scope 3 category alignment."
    - name: "supply_chain_activity_status"
      expr: supply_chain_activity_status
      comment: "Status of the activity record for data quality filtering."
    - name: "emission_relevant_flag"
      expr: emission_relevant_flag
      comment: "Flag indicating emission-relevant activities for Scope 3 inventory completeness tracking."
    - name: "reporting_period"
      expr: reporting_period
      comment: "Reporting period for time-series supply chain sustainability analysis."
    - name: "reporting_frequency"
      expr: reporting_frequency
      comment: "Frequency of activity reporting for data coverage and cadence management."
  measures:
    - name: "total_carbon_footprint_kg"
      expr: SUM(CAST(carbon_footprint_kg AS DOUBLE))
      comment: "Total carbon footprint in kg across supply chain activities. Primary Scope 3 emissions tracking KPI."
    - name: "total_energy_consumption_kwh"
      expr: SUM(CAST(energy_consumption_kwh AS DOUBLE))
      comment: "Total energy consumed across supply chain activities in kWh. Tracks supply chain energy intensity."
    - name: "total_water_usage_liters"
      expr: SUM(CAST(water_usage_liters AS DOUBLE))
      comment: "Total water used across supply chain activities. Tracks supply chain water footprint."
    - name: "total_waste_generated_kg"
      expr: SUM(CAST(waste_generated_kg AS DOUBLE))
      comment: "Total waste generated across supply chain activities in kg. Tracks supply chain waste performance."
    - name: "avg_recycling_rate_pct"
      expr: AVG(CAST(recycling_rate_pct AS DOUBLE))
      comment: "Average recycling rate across supply chain activities. Tracks circular economy performance in the supply chain."
    - name: "total_actual_amount"
      expr: SUM(CAST(actual_amount AS DOUBLE))
      comment: "Total actual sustainability metric amount across supply chain activities. Used for target vs. actual gap analysis."
    - name: "total_target_amount"
      expr: SUM(CAST(target_amount AS DOUBLE))
      comment: "Total target sustainability metric amount across supply chain activities. Denominator for supply chain target attainment."
    - name: "target_attainment_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(actual_amount AS DOUBLE)) / NULLIF(SUM(CAST(target_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of supply chain sustainability targets achieved. Tracks supply chain ESG program effectiveness."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`sustainability_waste_generation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Waste generation and diversion KPIs tracking total waste output, landfill diversion rates, and hazardous waste volumes. Used by operations and sustainability teams to drive zero-waste-to-landfill programs and regulatory compliance."
  source: "`vibe_consumer_goods_v1`.`sustainability`.`waste_generation`"
  dimensions:
    - name: "waste_type"
      expr: waste_type
      comment: "Type of waste generated (e.g. plastic, organic, hazardous) for material-specific reduction targeting."
    - name: "waste_stream_type"
      expr: waste_stream_type
      comment: "Waste stream classification (solid, liquid, hazardous) for regulatory reporting segmentation."
    - name: "disposal_method"
      expr: disposal_method
      comment: "Method of waste disposal (landfill, incineration, recycling, composting) for circular economy tracking."
    - name: "hazardous_flag"
      expr: hazardous_flag
      comment: "Indicates hazardous waste requiring special handling and regulatory reporting."
    - name: "zero_waste_to_landfill_flag"
      expr: zero_waste_to_landfill_flag
      comment: "Flag for facilities achieving zero-waste-to-landfill status. Key milestone in sustainability programs."
    - name: "waste_generation_status"
      expr: waste_generation_status
      comment: "Record status for data quality filtering in regulatory submissions."
    - name: "reporting_year"
      expr: reporting_year
      comment: "Reporting year for annual waste disclosure and year-over-year trend analysis."
    - name: "waste_category"
      expr: waste_category
      comment: "High-level waste category for portfolio-level waste management reporting."
  measures:
    - name: "total_waste_quantity_tonnes"
      expr: SUM(CAST(quantity_tonnes AS DOUBLE))
      comment: "Total waste generated in tonnes. Primary KPI for absolute waste reduction targets."
    - name: "total_recycled_tonnes"
      expr: SUM(CAST(recycled_tonnes AS DOUBLE))
      comment: "Total waste recycled in tonnes. Tracks circular economy performance and material recovery."
    - name: "total_landfill_tonnes"
      expr: SUM(CAST(landfill_tonnes AS DOUBLE))
      comment: "Total waste sent to landfill. Reduction of this metric is the core goal of zero-waste-to-landfill programs."
    - name: "total_incinerated_tonnes"
      expr: SUM(CAST(incinerated_tonnes AS DOUBLE))
      comment: "Total waste incinerated. Tracks energy-from-waste and non-landfill disposal volumes."
    - name: "avg_diversion_rate_pct"
      expr: AVG(CAST(diversion_rate_pct AS DOUBLE))
      comment: "Average waste diversion rate (% diverted from landfill). Core operational KPI for zero-waste programs."
    - name: "avg_recycled_pct"
      expr: AVG(CAST(recycled_pct AS DOUBLE))
      comment: "Average recycling rate across waste generation records. Tracks circular economy maturity."
    - name: "hazardous_waste_tonnes"
      expr: SUM(CASE WHEN hazardous_flag = TRUE THEN quantity_tonnes ELSE 0 END)
      comment: "Total hazardous waste generated. Regulatory compliance KPI with direct legal and reputational risk implications."
    - name: "landfill_diversion_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(recycled_tonnes AS DOUBLE)) / NULLIF(SUM(CAST(quantity_tonnes AS DOUBLE)), 0), 2)
      comment: "Percentage of total waste diverted from landfill via recycling. Headline metric for zero-waste-to-landfill program reporting."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`sustainability_water_consumption`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Water stewardship KPIs tracking withdrawal, consumption, discharge, and recycling volumes. Used by operations and sustainability teams to manage water risk, meet CDP Water targets, and comply with environmental permits."
  source: "`vibe_consumer_goods_v1`.`sustainability`.`water_consumption`"
  dimensions:
    - name: "water_source_type"
      expr: water_source_type
      comment: "Source of water withdrawal (municipal, groundwater, surface water) for water risk and dependency analysis."
    - name: "water_source"
      expr: water_source
      comment: "Specific water source identifier for granular stewardship tracking."
    - name: "water_stress_area_flag"
      expr: water_stress_area_flag
      comment: "Flag for operations in water-stressed areas. Critical for CDP Water and TCFD physical risk disclosure."
    - name: "water_consumption_status"
      expr: water_consumption_status
      comment: "Record status for data quality and completeness filtering."
    - name: "discharge_destination"
      expr: discharge_destination
      comment: "Destination of discharged water (river, municipal treatment, ocean) for environmental impact assessment."
    - name: "reporting_year"
      expr: reporting_year
      comment: "Reporting year for annual water disclosure and trend analysis."
    - name: "measurement_method"
      expr: measurement_method
      comment: "Method used to measure water consumption (metered, estimated, calculated) for data quality segmentation."
  measures:
    - name: "total_withdrawal_cubic_meters"
      expr: SUM(CAST(withdrawal_cubic_meters AS DOUBLE))
      comment: "Total water withdrawn in cubic meters. Primary absolute water use KPI for CDP Water and GRI 303 reporting."
    - name: "total_consumption_cubic_meters"
      expr: SUM(CAST(consumption_cubic_meters AS DOUBLE))
      comment: "Total water consumed (withdrawn minus discharged) in cubic meters. Net water impact metric."
    - name: "total_discharge_cubic_meters"
      expr: SUM(CAST(discharge_cubic_meters AS DOUBLE))
      comment: "Total water discharged back to the environment. Used to calculate net consumption and assess discharge permit compliance."
    - name: "total_recycled_cubic_meters"
      expr: SUM(CAST(recycled_cubic_meters AS DOUBLE))
      comment: "Total water recycled or reused. Tracks circular water use efficiency and reduces freshwater dependency."
    - name: "avg_water_recycling_rate_pct"
      expr: AVG(CAST(water_recycling_rate_pct AS DOUBLE))
      comment: "Average water recycling rate across facilities. Tracks progress toward water circularity targets."
    - name: "avg_water_intensity_per_unit"
      expr: AVG(CAST(water_intensity_per_unit AS DOUBLE))
      comment: "Average water intensity per production unit. Normalizes water use against output for efficiency benchmarking."
    - name: "water_recycling_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(recycled_cubic_meters AS DOUBLE)) / NULLIF(SUM(CAST(withdrawal_cubic_meters AS DOUBLE)), 0), 2)
      comment: "Percentage of withdrawn water that is recycled. Headline water circularity KPI for sustainability reporting."
    - name: "stressed_area_consumption_cubic_meters"
      expr: SUM(CASE WHEN water_stress_area_flag = TRUE THEN consumption_cubic_meters ELSE 0 END)
      comment: "Water consumed in water-stressed areas. High-priority risk metric for TCFD physical risk and investor ESG scoring."
$$;
