-- Metric views for domain: shared | Business: Semiconductors | Version: 2 | Generated on: 2026-06-28 00:14:33

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`shared_fab`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic fab facility performance metrics tracking capacity utilization, operational efficiency, environmental footprint, and facility health for executive steering and resource allocation decisions."
  source: "`vibe_semiconductors_v1`.`shared`.`fab`"
  dimensions:
    - name: "fab_code"
      expr: fab_code
      comment: "Unique fab facility identifier for site-level analysis"
    - name: "fab_type"
      expr: fab_type
      comment: "Fab classification (e.g., logic, memory, foundry) for technology segment analysis"
    - name: "fab_status"
      expr: fab_status
      comment: "Current operational status (active, idle, decommissioned) for capacity planning"
    - name: "operational_status"
      expr: operational_status
      comment: "Detailed operational state for real-time monitoring"
    - name: "technology_node_nm"
      expr: technology_node_nm
      comment: "Process technology node in nanometers for technology roadmap tracking"
    - name: "wafer_size_mm"
      expr: wafer_size_mm
      comment: "Wafer diameter in millimeters for capacity normalization"
    - name: "region"
      expr: region
      comment: "Geographic region for regional performance comparison and supply chain optimization"
    - name: "country_code"
      expr: country_code
      comment: "Country location for regulatory compliance and geopolitical risk analysis"
    - name: "automation_level"
      expr: automation_level
      comment: "Degree of fab automation for productivity benchmarking"
    - name: "cleanroom_class"
      expr: cleanroom_class
      comment: "ISO cleanroom classification for quality capability assessment"
    - name: "environmental_compliance_status"
      expr: environmental_compliance_status
      comment: "Environmental regulatory compliance state for ESG reporting"
    - name: "safety_certification"
      expr: safety_certification
      comment: "Safety certification level for risk management"
    - name: "is_critical_facility"
      expr: is_critical_facility
      comment: "Flag indicating strategic importance for business continuity planning"
    - name: "commissioning_year"
      expr: YEAR(commissioning_date)
      comment: "Year fab was commissioned for vintage analysis"
    - name: "commissioning_quarter"
      expr: DATE_TRUNC('QUARTER', commissioning_date)
      comment: "Quarter fab was commissioned for capacity ramp tracking"
  measures:
    - name: "total_fabs"
      expr: COUNT(DISTINCT fab_id)
      comment: "Total number of unique fab facilities for footprint tracking"
    - name: "total_cleanroom_area_sqm"
      expr: SUM(CAST(cleanroom_area_sqm AS DOUBLE))
      comment: "Total cleanroom square meters for capacity investment valuation"
    - name: "avg_cleanroom_area_sqm"
      expr: AVG(CAST(cleanroom_area_sqm AS DOUBLE))
      comment: "Average cleanroom area per fab for facility size benchmarking"
    - name: "total_facility_area_sqft"
      expr: SUM(CAST(total_area_sqft AS DOUBLE))
      comment: "Total facility footprint in square feet for real estate portfolio management"
    - name: "total_annual_power_consumption_mwh"
      expr: SUM(CAST(annual_power_mwh AS DOUBLE))
      comment: "Total annual power consumption in megawatt-hours for energy cost forecasting and carbon footprint analysis"
    - name: "avg_annual_power_consumption_mwh"
      expr: AVG(CAST(annual_power_mwh AS DOUBLE))
      comment: "Average annual power consumption per fab for energy efficiency benchmarking"
    - name: "total_annual_water_usage_m3"
      expr: SUM(CAST(annual_water_m3 AS DOUBLE))
      comment: "Total annual water consumption in cubic meters for water resource management and ESG reporting"
    - name: "avg_annual_water_usage_m3"
      expr: AVG(CAST(annual_water_m3 AS DOUBLE))
      comment: "Average annual water usage per fab for sustainability benchmarking"
    - name: "total_carbon_footprint_tons"
      expr: SUM(CAST(carbon_footprint_tons AS DOUBLE))
      comment: "Total carbon emissions in metric tons for corporate sustainability goals and regulatory reporting"
    - name: "avg_carbon_footprint_tons"
      expr: AVG(CAST(carbon_footprint_tons AS DOUBLE))
      comment: "Average carbon footprint per fab for environmental performance benchmarking"
    - name: "avg_audit_score"
      expr: AVG(CAST(audit_score AS DOUBLE))
      comment: "Average audit score across fabs for quality and compliance performance tracking"
    - name: "critical_facilities_count"
      expr: SUM(CASE WHEN is_critical_facility = true THEN 1 ELSE 0 END)
      comment: "Count of critical facilities for business continuity risk assessment"
    - name: "critical_facilities_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN is_critical_facility = true THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of fabs designated as critical for strategic risk concentration analysis"
    - name: "energy_intensity_mwh_per_sqm"
      expr: ROUND(SUM(CAST(annual_power_mwh AS DOUBLE)) / NULLIF(SUM(CAST(cleanroom_area_sqm AS DOUBLE)), 0), 4)
      comment: "Energy consumption per cleanroom square meter for energy efficiency KPI and cost optimization"
    - name: "water_intensity_m3_per_sqm"
      expr: ROUND(SUM(CAST(annual_water_m3 AS DOUBLE)) / NULLIF(SUM(CAST(cleanroom_area_sqm AS DOUBLE)), 0), 4)
      comment: "Water consumption per cleanroom square meter for water efficiency KPI and resource planning"
    - name: "carbon_intensity_tons_per_sqm"
      expr: ROUND(SUM(CAST(carbon_footprint_tons AS DOUBLE)) / NULLIF(SUM(CAST(cleanroom_area_sqm AS DOUBLE)), 0), 6)
      comment: "Carbon emissions per cleanroom square meter for carbon efficiency KPI and ESG target tracking"
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`shared_location`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Granular location hierarchy metrics tracking operational sites, capacity distribution, and location performance for supply chain optimization and network design decisions."
  source: "`vibe_semiconductors_v1`.`shared`.`location`"
  dimensions:
    - name: "location_code"
      expr: location_code
      comment: "Unique location identifier for granular site analysis"
    - name: "location_type"
      expr: location_type
      comment: "Location classification (e.g., warehouse, office, lab) for network segmentation"
    - name: "location_status"
      expr: location_status
      comment: "Current location operational status for capacity planning"
    - name: "region"
      expr: region
      comment: "Geographic region for regional network analysis"
    - name: "country_code"
      expr: country_code
      comment: "Country location for international operations tracking"
    - name: "city"
      expr: city
      comment: "City location for local market presence"
    - name: "state_province"
      expr: state_province
      comment: "State or province for regional compliance"
    - name: "timezone"
      expr: timezone
      comment: "Location timezone for global coordination"
    - name: "opening_year"
      expr: YEAR(opening_date)
      comment: "Year location opened for network evolution analysis"
    - name: "opening_quarter"
      expr: DATE_TRUNC('QUARTER', opening_date)
      comment: "Quarter location opened for expansion tracking"
    - name: "has_parent_location"
      expr: CASE WHEN parent_location_id IS NOT NULL THEN 'Yes' ELSE 'No' END
      comment: "Flag indicating hierarchical location structure for network topology analysis"
  measures:
    - name: "total_locations"
      expr: COUNT(DISTINCT location_id)
      comment: "Total number of unique locations for network footprint tracking"
    - name: "total_square_footage"
      expr: SUM(CAST(square_footage AS DOUBLE))
      comment: "Total location square footage for real estate portfolio management"
    - name: "avg_square_footage"
      expr: AVG(CAST(square_footage AS DOUBLE))
      comment: "Average location size for facility planning"
    - name: "total_daily_capacity"
      expr: SUM(CAST(capacity_per_day AS DOUBLE))
      comment: "Total daily throughput capacity for supply chain planning and bottleneck identification"
    - name: "avg_daily_capacity"
      expr: AVG(CAST(capacity_per_day AS DOUBLE))
      comment: "Average daily capacity per location for productivity benchmarking"
    - name: "total_employees"
      expr: SUM(CAST(REGEXP_REPLACE(number_of_employees, '[^0-9]', '') AS BIGINT))
      comment: "Total employee headcount across locations for workforce distribution analysis"
    - name: "avg_employees_per_location"
      expr: AVG(CAST(REGEXP_REPLACE(number_of_employees, '[^0-9]', '') AS BIGINT))
      comment: "Average employees per location for staffing efficiency"
    - name: "hierarchical_locations_count"
      expr: SUM(CASE WHEN parent_location_id IS NOT NULL THEN 1 ELSE 0 END)
      comment: "Count of locations with parent relationships for organizational structure complexity tracking"
    - name: "hierarchical_locations_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN parent_location_id IS NOT NULL THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of locations in hierarchical structure for network design analysis"
    - name: "capacity_density_per_sqft"
      expr: ROUND(SUM(CAST(capacity_per_day AS DOUBLE)) / NULLIF(SUM(CAST(square_footage AS DOUBLE)), 0), 4)
      comment: "Daily capacity per square foot for space utilization efficiency KPI and facility optimization"
    - name: "employee_density_per_sqft"
      expr: ROUND(SUM(CAST(REGEXP_REPLACE(number_of_employees, '[^0-9]', '') AS BIGINT)) / NULLIF(SUM(CAST(square_footage AS DOUBLE)), 0), 6)
      comment: "Employees per square foot for workspace efficiency and real estate ROI"
    - name: "avg_latitude"
      expr: AVG(CAST(latitude AS DOUBLE))
      comment: "Average latitude for geographic distribution analysis"
    - name: "avg_longitude"
      expr: AVG(CAST(longitude AS DOUBLE))
      comment: "Average longitude for geographic distribution analysis"
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`shared_site`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Enterprise site portfolio metrics tracking operational footprint, capacity, power infrastructure, and site health for real estate strategy and operational excellence decisions."
  source: "`vibe_semiconductors_v1`.`shared`.`site`"
  dimensions:
    - name: "site_code"
      expr: site_code
      comment: "Unique site identifier for location-level analysis"
    - name: "site_type"
      expr: site_type
      comment: "Site classification (e.g., fab, office, warehouse, R&D) for portfolio segmentation"
    - name: "site_status"
      expr: site_status
      comment: "Current site operational status for capacity planning"
    - name: "region"
      expr: region
      comment: "Geographic region for regional footprint analysis"
    - name: "country_code"
      expr: country_code
      comment: "Country location for geopolitical risk and regulatory analysis"
    - name: "city"
      expr: city
      comment: "City location for local market presence tracking"
    - name: "state_province"
      expr: state_province
      comment: "State or province for regional compliance and tax analysis"
    - name: "timezone"
      expr: timezone
      comment: "Site timezone for global operations coordination"
    - name: "compliance_status"
      expr: compliance_status
      comment: "Regulatory compliance state for risk management"
    - name: "environmental_certification"
      expr: environmental_certification
      comment: "Environmental certification level for ESG reporting"
    - name: "security_classification"
      expr: security_classification
      comment: "Security clearance level for access control and risk assessment"
    - name: "data_center_flag"
      expr: data_center_flag
      comment: "Flag indicating data center presence for IT infrastructure planning"
    - name: "opening_year"
      expr: YEAR(opening_date)
      comment: "Year site opened for portfolio age analysis"
    - name: "opening_quarter"
      expr: DATE_TRUNC('QUARTER', opening_date)
      comment: "Quarter site opened for expansion timeline tracking"
  measures:
    - name: "total_sites"
      expr: COUNT(DISTINCT site_id)
      comment: "Total number of unique sites for global footprint tracking"
    - name: "total_square_footage"
      expr: SUM(CAST(square_footage AS DOUBLE))
      comment: "Total site square footage for real estate portfolio valuation"
    - name: "avg_square_footage"
      expr: AVG(CAST(square_footage AS DOUBLE))
      comment: "Average site size for facility planning benchmarking"
    - name: "total_power_capacity_kw"
      expr: SUM(CAST(power_capacity_kw AS DOUBLE))
      comment: "Total power capacity in kilowatts for infrastructure investment planning and energy procurement"
    - name: "avg_power_capacity_kw"
      expr: AVG(CAST(power_capacity_kw AS DOUBLE))
      comment: "Average power capacity per site for infrastructure benchmarking"
    - name: "total_employees"
      expr: SUM(CAST(REGEXP_REPLACE(number_of_employees, '[^0-9]', '') AS BIGINT))
      comment: "Total employee headcount across sites for workforce planning (assumes numeric extraction from string field)"
    - name: "avg_employees_per_site"
      expr: AVG(CAST(REGEXP_REPLACE(number_of_employees, '[^0-9]', '') AS BIGINT))
      comment: "Average employees per site for staffing efficiency benchmarking"
    - name: "data_center_sites_count"
      expr: SUM(CASE WHEN data_center_flag = true THEN 1 ELSE 0 END)
      comment: "Count of sites with data center facilities for IT infrastructure portfolio tracking"
    - name: "data_center_sites_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN data_center_flag = true THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of sites with data centers for digital infrastructure strategy"
    - name: "power_density_kw_per_sqft"
      expr: ROUND(SUM(CAST(power_capacity_kw AS DOUBLE)) / NULLIF(SUM(CAST(square_footage AS DOUBLE)), 0), 4)
      comment: "Power capacity per square foot for infrastructure efficiency KPI and facility design optimization"
    - name: "employee_density_per_sqft"
      expr: ROUND(SUM(CAST(REGEXP_REPLACE(number_of_employees, '[^0-9]', '') AS BIGINT)) / NULLIF(SUM(CAST(square_footage AS DOUBLE)), 0), 6)
      comment: "Employees per square foot for space utilization efficiency and real estate optimization"
    - name: "avg_latitude"
      expr: AVG(CAST(latitude AS DOUBLE))
      comment: "Average latitude for geographic center of operations analysis"
    - name: "avg_longitude"
      expr: AVG(CAST(longitude AS DOUBLE))
      comment: "Average longitude for geographic center of operations analysis"
$$;
