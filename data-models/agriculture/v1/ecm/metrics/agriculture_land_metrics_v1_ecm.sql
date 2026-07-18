-- Metric views for domain: land | Business: Agriculture | Version: 1 | Generated on: 2026-05-01 16:21:15

CREATE OR REPLACE VIEW `agriculture_ecm`.`_metrics`.`land_parcel`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core parcel inventory and financial exposure metrics"
  source: "`agriculture_ecm`.`land`.`parcel`"
  dimensions:
    - name: "state_code"
      expr: state_code
      comment: "State where parcel is located"
    - name: "county"
      expr: county
      comment: "County where parcel is located"
    - name: "ownership_type"
      expr: ownership_type
      comment: "Legal ownership classification"
    - name: "land_use_designation"
      expr: land_use_designation
      comment: "Primary land use designation"
    - name: "acquisition_year"
      expr: DATE_TRUNC('year', acquisition_date)
      comment: "Year parcel was acquired"
  measures:
    - name: "parcel_count"
      expr: COUNT(1)
      comment: "Number of parcels"
    - name: "total_deeded_acres"
      expr: SUM(CAST(total_deeded_acres AS DOUBLE))
      comment: "Total deeded acres across parcels"
    - name: "total_acquisition_cost"
      expr: SUM(CAST(acquisition_cost AS DOUBLE))
      comment: "Total acquisition cost for parcels"
$$;


CREATE OR REPLACE VIEW `agriculture_ecm`.`_metrics`.`land_conservation_practice`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Financial and scale metrics for conservation practices"
  source: "`agriculture_ecm`.`land`.`conservation_practice`"
  dimensions:
    - name: "bmp_category"
      expr: bmp_category
      comment: "Best Management Practice category"
    - name: "practice_status"
      expr: practice_status
      comment: "Current status of the practice"
    - name: "carbon_credit_eligible"
      expr: carbon_credit_eligible
      comment: "Eligibility for carbon credits"
    - name: "state_code"
      expr: state_code
      comment: "State of the practice"
    - name: "county_code"
      expr: county_code
      comment: "County of the practice"
    - name: "certification_year"
      expr: DATE_TRUNC('year', certification_date)
      comment: "Year of certification"
  measures:
    - name: "practice_count"
      expr: COUNT(1)
      comment: "Number of conservation practices"
    - name: "total_practice_cost"
      expr: SUM(CAST(total_practice_cost AS DOUBLE))
      comment: "Aggregate cost of all practices"
    - name: "total_practice_acres"
      expr: SUM(CAST(practice_area_acres AS DOUBLE))
      comment: "Total acres covered by practices"
    - name: "avg_cost_per_acre"
      expr: AVG(total_practice_cost / NULLIF(practice_area_acres, 0))
      comment: "Average cost per acre of practice"
$$;


CREATE OR REPLACE VIEW `agriculture_ecm`.`_metrics`.`land_irrigation_zone`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Irrigation efficiency and coverage metrics"
  source: "`agriculture_ecm`.`land`.`irrigation_zone`"
  dimensions:
    - name: "zone_type"
      expr: zone_type
      comment: "Type of irrigation zone"
    - name: "water_source_type"
      expr: water_source_type
      comment: "Source of water for irrigation"
    - name: "system_type"
      expr: system_type
      comment: "Irrigation system technology"
    - name: "installation_year"
      expr: installation_year
      comment: "Year the irrigation system was installed"
  measures:
    - name: "irrigation_zone_count"
      expr: COUNT(1)
      comment: "Number of irrigation zones"
    - name: "total_irrigated_acres"
      expr: SUM(CAST(irrigated_area_acres AS DOUBLE))
      comment: "Total irrigated acres across zones"
    - name: "avg_application_efficiency_pct"
      expr: AVG(CAST(application_efficiency_pct AS DOUBLE))
      comment: "Average water application efficiency"
$$;


CREATE OR REPLACE VIEW `agriculture_ecm`.`_metrics`.`land_soil_sample`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Soil fertility recommendation metrics"
  source: "`agriculture_ecm`.`land`.`land_soil_sample`"
  dimensions:
    - name: "sample_year"
      expr: DATE_TRUNC('year', sample_date)
      comment: "Year the sample was taken"
    - name: "field_id"
      expr: field_id
      comment: "Identifier of the field sampled"
    - name: "soil_texture_class"
      expr: soil_texture_class
      comment: "Soil texture classification"
    - name: "sample_status"
      expr: sample_status
      comment: "Current status of the sample"
  measures:
    - name: "soil_sample_count"
      expr: COUNT(1)
      comment: "Number of soil samples collected"
    - name: "avg_nitrogen_recommendation_lbs_ac"
      expr: AVG(CAST(nitrogen_recommendation_lbs_ac AS DOUBLE))
      comment: "Average nitrogen recommendation per acre"
    - name: "avg_phosphorus_recommendation_lbs_ac"
      expr: AVG(CAST(phosphorus_recommendation_lbs_ac AS DOUBLE))
      comment: "Average phosphorus recommendation per acre"
    - name: "avg_potassium_recommendation_lbs_ac"
      expr: AVG(CAST(potassium_recommendation_lbs_ac AS DOUBLE))
      comment: "Average potassium recommendation per acre"
$$;


CREATE OR REPLACE VIEW `agriculture_ecm`.`_metrics`.`land_lease`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Revenue and scale metrics for active land leases"
  source: "`agriculture_ecm`.`land`.`lease`"
  filter: lease_status = 'Active'
  dimensions:
    - name: "state_code"
      expr: state_code
      comment: "State of the leased parcel"
    - name: "county_fips_code"
      expr: county_fips_code
      comment: "County FIPS code of the lease"
    - name: "lease_type"
      expr: lease_type
      comment: "Classification of lease agreement"
    - name: "account_id"
      expr: account_id
      comment: "Account identifier of the tenant"
    - name: "lease_start_year"
      expr: DATE_TRUNC('year', start_date)
      comment: "Year lease began"
  measures:
    - name: "active_lease_count"
      expr: COUNT(1)
      comment: "Number of active leases"
    - name: "total_leased_acres"
      expr: SUM(CAST(total_leased_acres AS DOUBLE))
      comment: "Total acres under lease"
    - name: "total_lease_revenue"
      expr: SUM(cash_rent_rate_per_acre * total_leased_acres)
      comment: "Projected lease revenue based on cash rent per acre"
$$;
