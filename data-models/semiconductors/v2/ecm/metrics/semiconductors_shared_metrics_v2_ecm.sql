-- Metric views for domain: shared | Business: Semiconductors | Version: 2 | Generated on: 2026-07-10 11:52:05

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`shared_fab`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Operational and sustainability KPIs for semiconductor fabrication facilities. Covers environmental footprint, capacity, audit compliance, and facility lifecycle status to support executive steering of fab portfolio decisions."
  source: "`vibe_semiconductors_v1`.`equipment`.`fab`"
  dimensions:
    - name: "fab_type"
      expr: fab_type
      comment: "Type of fabrication facility (e.g. logic, memory, foundry) used to segment KPIs by fab category."
    - name: "fab_status"
      expr: fab_status
      comment: "Operational status of the fab (e.g. active, shutdown, under construction) for lifecycle filtering."
    - name: "technology_node_nm"
      expr: technology_node_nm
      comment: "Technology node name (e.g. 5nm, 7nm) enabling KPI segmentation by process generation."
    - name: "primary_product_family"
      expr: primary_product_family
      comment: "Primary product family manufactured at the fab, used to align fab metrics with product portfolio."
    - name: "environmental_compliance_status"
      expr: environmental_compliance_status
      comment: "Environmental compliance status of the fab, critical for ESG reporting and regulatory risk segmentation."
    - name: "is_critical_facility"
      expr: is_critical_facility
      comment: "Flag indicating whether the fab is classified as a critical facility, used to prioritize investment and risk management."
    - name: "security_clearance_level"
      expr: security_clearance_level
      comment: "Security clearance level of the fab, relevant for defense/government contract compliance segmentation."
    - name: "owner_company"
      expr: owner_company
      comment: "Company owning the fab, enabling multi-entity or JV portfolio analysis."
    - name: "last_audit_date"
      expr: DATE_TRUNC('month', last_audit_date)
      comment: "Month of the last audit, used to track audit recency trends over time."
    - name: "start_date_year"
      expr: YEAR(start_date)
      comment: "Year the fab became operational, enabling cohort analysis of fab vintage vs. performance."
  measures:
    - name: "active_fab_count"
      expr: COUNT(CASE WHEN fab_status = 'active' THEN fab_id END)
      comment: "Number of currently active fabrication facilities. Executives use this to assess operational capacity footprint and make investment decisions about new fab construction or consolidation."
    - name: "total_annual_power_mwh"
      expr: SUM(CAST(annual_power_mwh AS DOUBLE))
      comment: "Total annual power consumption in MWh across all fabs. A primary ESG and cost KPI — rising power consumption triggers energy efficiency programs and impacts operating cost forecasts."
    - name: "avg_annual_power_mwh_per_fab"
      expr: AVG(CAST(annual_power_mwh AS DOUBLE))
      comment: "Average annual power consumption per fab in MWh. Used to benchmark individual fabs against the portfolio average and identify energy outliers for remediation."
    - name: "total_annual_water_m3"
      expr: SUM(CAST(annual_water_m3 AS DOUBLE))
      comment: "Total annual water consumption in cubic meters across all fabs. Critical ESG metric — semiconductor fabs are major water consumers and this KPI drives water stewardship programs and regulatory compliance."
    - name: "avg_annual_water_m3_per_fab"
      expr: AVG(CAST(annual_water_m3 AS DOUBLE))
      comment: "Average annual water consumption per fab in cubic meters. Benchmarks water efficiency across the fab portfolio to identify high-consumption facilities for targeted reduction initiatives."
    - name: "total_carbon_footprint_tons"
      expr: SUM(CAST(carbon_footprint_tons AS DOUBLE))
      comment: "Total carbon footprint in metric tons across all fabs. A board-level ESG KPI directly tied to net-zero commitments, carbon credit obligations, and regulatory disclosure requirements."
    - name: "avg_carbon_footprint_tons_per_fab"
      expr: AVG(CAST(carbon_footprint_tons AS DOUBLE))
      comment: "Average carbon footprint per fab in metric tons. Used to identify high-emission facilities and prioritize decarbonization capital expenditure."
    - name: "avg_audit_score"
      expr: AVG(CAST(audit_score AS DOUBLE))
      comment: "Average audit score across fabs. A governance KPI — declining audit scores signal compliance risk and trigger corrective action programs before regulatory penalties occur."
    - name: "min_audit_score"
      expr: MIN(audit_score)
      comment: "Minimum audit score across the fab portfolio. Identifies the worst-performing facility from a compliance standpoint, enabling targeted remediation before audit failures escalate."
    - name: "total_fab_area_sqft"
      expr: SUM(CAST(total_area_sqft AS DOUBLE))
      comment: "Total physical footprint of all fabs in square feet. Used in capacity planning, real estate portfolio management, and capital allocation decisions for expansion or consolidation."
    - name: "avg_fab_area_sqft"
      expr: AVG(CAST(total_area_sqft AS DOUBLE))
      comment: "Average fab size in square feet. Benchmarks facility scale across the portfolio to inform standardization and modular expansion strategies."
    - name: "critical_facility_count"
      expr: COUNT(CASE WHEN is_critical_facility = TRUE THEN fab_id END)
      comment: "Number of fabs classified as critical facilities. Drives business continuity planning, insurance coverage decisions, and priority maintenance scheduling."
    - name: "non_compliant_fab_count"
      expr: COUNT(CASE WHEN environmental_compliance_status != 'compliant' THEN fab_id END)
      comment: "Number of fabs not in environmental compliance. A risk KPI — non-compliant fabs face regulatory fines, operational shutdowns, and reputational damage; executives use this to prioritize remediation spend."
    - name: "carbon_intensity_per_sqft"
      expr: SUM(CAST(carbon_footprint_tons AS DOUBLE)) / NULLIF(SUM(CAST(total_area_sqft AS DOUBLE)), 0)
      comment: "Carbon footprint per square foot of fab area (tons/sqft). A normalized ESG efficiency metric that enables fair comparison across fabs of different sizes and drives green building investment decisions."
    - name: "power_intensity_per_sqft"
      expr: SUM(CAST(annual_power_mwh AS DOUBLE)) / NULLIF(SUM(CAST(total_area_sqft AS DOUBLE)), 0)
      comment: "Annual power consumption per square foot of fab area (MWh/sqft). Normalizes energy efficiency across fabs of different sizes, enabling identification of energy-inefficient facilities for capital improvement."
    - name: "water_intensity_per_sqft"
      expr: SUM(CAST(annual_water_m3 AS DOUBLE)) / NULLIF(SUM(CAST(total_area_sqft AS DOUBLE)), 0)
      comment: "Annual water consumption per square foot of fab area (m3/sqft). Normalized water efficiency metric used in ESG benchmarking and water stewardship program prioritization."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`shared_location`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Operational and capacity KPIs for the shared location master. Supports real estate portfolio management, workforce distribution analysis, and facility lifecycle governance across all semiconductor operations."
  source: "`vibe_semiconductors_v1`.`shared`.`location`"
  dimensions:
    - name: "location_type"
      expr: location_type
      comment: "Type of location (e.g. fab, office, warehouse, R&D center) enabling KPI segmentation by facility category."
    - name: "location_status"
      expr: location_status
      comment: "Operational status of the location (e.g. active, closed, under construction) for lifecycle filtering."
    - name: "country_code"
      expr: country_code
      comment: "Country where the location resides, enabling geographic segmentation for regional portfolio analysis."
    - name: "region"
      expr: region
      comment: "Geographic region of the location (e.g. APAC, EMEA, Americas) for regional capacity and workforce planning."
    - name: "state_province"
      expr: state_province
      comment: "State or province of the location for sub-regional analysis and regulatory jurisdiction mapping."
    - name: "timezone"
      expr: timezone
      comment: "Timezone of the location, used for operational scheduling and global shift coordination analysis."
    - name: "opening_date_year"
      expr: YEAR(opening_date)
      comment: "Year the location opened, enabling vintage cohort analysis of location performance and lifecycle stage."
    - name: "closing_date_year"
      expr: YEAR(closing_date)
      comment: "Year the location closed, used to analyze facility retirement trends and portfolio rationalization timing."
  measures:
    - name: "active_location_count"
      expr: COUNT(CASE WHEN location_status = 'active' THEN location_id END)
      comment: "Number of currently active locations in the portfolio. Executives use this to assess global operational footprint and make real estate consolidation or expansion decisions."
    - name: "total_square_footage"
      expr: SUM(CAST(square_footage AS DOUBLE))
      comment: "Total square footage across all locations. A primary real estate portfolio KPI used in capacity planning, lease management, and capital allocation for facility expansion or consolidation."
    - name: "avg_square_footage_per_location"
      expr: AVG(CAST(square_footage AS DOUBLE))
      comment: "Average square footage per location. Benchmarks facility scale across the portfolio to identify undersized or oversized locations relative to operational needs."
    - name: "total_daily_capacity"
      expr: SUM(CAST(capacity_per_day AS DOUBLE))
      comment: "Total daily throughput capacity across all locations. A strategic capacity planning KPI — gaps between total capacity and demand drive decisions on facility investment, shift expansion, or outsourcing."
    - name: "avg_daily_capacity_per_location"
      expr: AVG(CAST(capacity_per_day AS DOUBLE))
      comment: "Average daily capacity per location. Used to identify capacity outliers and inform load-balancing decisions across the facility network."
    - name: "location_count_by_country"
      expr: COUNT(DISTINCT country_code)
      comment: "Number of distinct countries with operational locations. Measures geographic diversification of the facility network, relevant for supply chain resilience and geopolitical risk management."
    - name: "capacity_per_sqft"
      expr: SUM(CAST(capacity_per_day AS DOUBLE)) / NULLIF(SUM(CAST(square_footage AS DOUBLE)), 0)
      comment: "Daily capacity per square foot of location area. A space utilization efficiency KPI — low values indicate underutilized real estate, triggering consolidation or sublease decisions."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`shared_site`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic and operational KPIs for the shared site master, which represents the physical location hierarchy for all semiconductor operations. Supports executive decisions on site portfolio, capacity, power infrastructure, and compliance posture."
  source: "`vibe_semiconductors_v1`.`shared`.`site`"
  dimensions:
    - name: "site_type"
      expr: site_type
      comment: "Type of site (e.g. fab, R&D, office, logistics hub) enabling KPI segmentation by operational category."
    - name: "site_status"
      expr: site_status
      comment: "Operational status of the site (e.g. active, closed, planned) for lifecycle and portfolio filtering."
    - name: "country_code"
      expr: country_code
      comment: "Country where the site is located, enabling geographic segmentation for regional portfolio and risk analysis."
    - name: "region"
      expr: region
      comment: "Geographic region of the site (e.g. APAC, EMEA, Americas) for regional capacity and investment planning."
    - name: "compliance_status"
      expr: compliance_status
      comment: "Regulatory compliance status of the site, used to segment sites by compliance risk for executive risk reporting."
    - name: "security_classification"
      expr: security_classification
      comment: "Security classification level of the site, relevant for defense contracts, export control, and access management decisions."
    - name: "environmental_certification"
      expr: environmental_certification
      comment: "Environmental certification held by the site (e.g. ISO 14001, LEED), used in ESG reporting and green facility benchmarking."
    - name: "data_center_flag"
      expr: data_center_flag
      comment: "Indicates whether the site hosts a data center, enabling separate capacity and power analysis for IT infrastructure vs. manufacturing."
    - name: "opening_date_year"
      expr: YEAR(opening_date)
      comment: "Year the site opened, enabling vintage cohort analysis of site performance and lifecycle stage."
    - name: "state_province"
      expr: state_province
      comment: "State or province of the site for sub-regional regulatory jurisdiction and incentive program mapping."
  measures:
    - name: "active_site_count"
      expr: COUNT(CASE WHEN site_status = 'active' THEN site_id END)
      comment: "Number of currently active sites in the portfolio. A foundational executive KPI for assessing global operational footprint and driving site consolidation or greenfield investment decisions."
    - name: "total_power_capacity_kw"
      expr: SUM(CAST(power_capacity_kw AS DOUBLE))
      comment: "Total installed power capacity in kilowatts across all sites. A critical infrastructure KPI — power capacity constrains fab expansion and drives capital investment in grid upgrades and on-site generation."
    - name: "avg_power_capacity_kw_per_site"
      expr: AVG(CAST(power_capacity_kw AS DOUBLE))
      comment: "Average power capacity per site in kilowatts. Benchmarks infrastructure scale across the site portfolio to identify underpowered sites that limit production ramp."
    - name: "total_square_footage"
      expr: SUM(CAST(square_footage AS DOUBLE))
      comment: "Total square footage across all sites. Used in real estate portfolio management, capacity planning, and capital allocation for facility expansion or consolidation."
    - name: "avg_square_footage_per_site"
      expr: AVG(CAST(square_footage AS DOUBLE))
      comment: "Average site size in square feet. Benchmarks facility scale to inform standardization strategies and identify sites with expansion headroom."
    - name: "non_compliant_site_count"
      expr: COUNT(CASE WHEN compliance_status != 'compliant' THEN site_id END)
      comment: "Number of sites not in regulatory compliance. A risk management KPI — non-compliant sites face operational shutdowns, fines, and reputational damage; executives use this to prioritize remediation investment."
    - name: "compliant_site_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN compliance_status = 'compliant' THEN site_id END) / NULLIF(COUNT(site_id), 0), 2)
      comment: "Percentage of sites in regulatory compliance. A board-level governance KPI — declining compliance rates signal systemic regulatory risk and trigger enterprise-wide compliance programs."
    - name: "data_center_site_count"
      expr: COUNT(CASE WHEN data_center_flag = TRUE THEN site_id END)
      comment: "Number of sites hosting data centers. Used in IT infrastructure capacity planning and digital transformation investment decisions."
    - name: "power_density_kw_per_sqft"
      expr: SUM(CAST(power_capacity_kw AS DOUBLE)) / NULLIF(SUM(CAST(square_footage AS DOUBLE)), 0)
      comment: "Power capacity per square foot of site area (kW/sqft). A facility efficiency KPI — high power density indicates advanced manufacturing or data center operations; low density may signal underutilized infrastructure."
    - name: "distinct_country_count"
      expr: COUNT(DISTINCT country_code)
      comment: "Number of distinct countries with active sites. Measures geographic diversification of the site network, directly informing supply chain resilience strategy and geopolitical risk exposure assessments."
    - name: "sites_with_env_certification_count"
      expr: COUNT(CASE WHEN environmental_certification IS NOT NULL AND environmental_certification != '' THEN site_id END)
      comment: "Number of sites holding an environmental certification. An ESG portfolio KPI — executives track this to demonstrate sustainability commitments to investors, customers, and regulators."
    - name: "env_certified_site_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN environmental_certification IS NOT NULL AND environmental_certification != '' THEN site_id END) / NULLIF(COUNT(site_id), 0), 2)
      comment: "Percentage of sites with environmental certification. Tracks progress toward ESG certification targets and is reported in sustainability disclosures and investor ESG scorecards."
$$;
