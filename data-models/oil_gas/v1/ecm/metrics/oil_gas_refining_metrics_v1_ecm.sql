-- Metric views for domain: refining | Business: Oil Gas | Version: 1 | Generated on: 2026-05-04 05:05:28

CREATE OR REPLACE VIEW `oil_gas_ecm`.`_metrics`.`refining_energy_consumption`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Energy and emissions KPIs used by operations and ESG leadership to monitor cost, sustainability and regulatory performance"
  source: "`oil_gas_ecm`.`refining`.`energy_consumption`"
  dimensions:
    - name: "measurement_date"
      expr: measurement_date
      comment: "Date of the energy measurement"
    - name: "asset_facility_id"
      expr: asset_facility_id
      comment: "Facility where energy was consumed"
    - name: "process_unit_id"
      expr: process_unit_id
      comment: "Process unit identifier"
    - name: "energy_source_type"
      expr: energy_source_type
      comment: "Type of energy source (e.g., electricity, fuel gas)"
    - name: "reporting_period"
      expr: reporting_period
      comment: "Business reporting period label"
  measures:
    - name: "total_ghg_emissions_tonnes"
      expr: SUM(CAST(ghg_emissions_co2e_tonnes AS DOUBLE))
      comment: "Total CO2e greenhouse‑gas emissions associated with energy use"
    - name: "avg_energy_intensity_mmbtu_per_bbl"
      expr: AVG(CAST(energy_intensity_mmbtu_per_bbl AS DOUBLE))
      comment: "Average energy intensity (MMBtu per barrel) across records"
    - name: "avg_energy_efficiency_index"
      expr: AVG(CAST(energy_efficiency_index AS DOUBLE))
      comment: "Average energy efficiency index, higher values indicate better efficiency"
$$;


CREATE OR REPLACE VIEW `oil_gas_ecm`.`_metrics`.`refining_unit_run`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core production performance metrics for each unit run, supporting capacity planning and profitability analysis"
  source: "`oil_gas_ecm`.`refining`.`unit_run`"
  dimensions:
    - name: "process_unit_id"
      expr: process_unit_id
      comment: "Identifier of the process unit"
    - name: "petroleum_product_id"
      expr: petroleum_product_id
      comment: "Primary product produced in the run"
    - name: "run_type"
      expr: run_type
      comment: "Classification of the run (e.g., normal, test)"
    - name: "run_status"
      expr: run_status
      comment: "Current status of the run"
    - name: "run_date"
      expr: DATE_TRUNC('day', run_start_timestamp)
      comment: "Calendar day the run started"
  measures:
    - name: "total_feedstock_volume_bbl"
      expr: SUM(CAST(feedstock_volume_bbl AS DOUBLE))
      comment: "Total feedstock volume processed in barrels"
    - name: "total_product_volume_bbl"
      expr: SUM(CAST(total_product_volume_bbl AS DOUBLE))
      comment: "Total product volume produced in barrels"
    - name: "total_output_boe"
      expr: SUM(CAST(total_output_boe AS DOUBLE))
      comment: "Total barrel‑of‑oil‑equivalent output"
$$;


CREATE OR REPLACE VIEW `oil_gas_ecm`.`_metrics`.`refining_blend_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Blending efficiency KPIs used by refinery operations to monitor product quality and yield"
  source: "`oil_gas_ecm`.`refining`.`blend_event`"
  dimensions:
    - name: "refinery_id"
      expr: refinery_id
      comment: "Refinery where the blend occurred"
    - name: "blend_type"
      expr: blend_type
      comment: "Type of blend (e.g., batch, continuous)"
    - name: "blend_status"
      expr: blend_status
      comment: "Current status of the blend"
    - name: "blend_date"
      expr: DATE_TRUNC('day', blend_start_timestamp)
      comment: "Date the blend started"
    - name: "petroleum_product_id"
      expr: petroleum_product_id
      comment: "Target product of the blend"
  measures:
    - name: "total_blend_volume_bbl"
      expr: SUM(CAST(total_blend_volume_bbl AS DOUBLE))
      comment: "Total volume blended in barrels"
    - name: "total_blend_loss_bbl"
      expr: SUM(CAST(blend_loss_bbl AS DOUBLE))
      comment: "Total volume loss during blending in barrels"
$$;


CREATE OR REPLACE VIEW `oil_gas_ecm`.`_metrics`.`refining_refinery`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic asset‑level KPIs for portfolio management and investment decisions"
  source: "`oil_gas_ecm`.`refining`.`refinery`"
  dimensions:
    - name: "refinery_id"
      expr: refinery_id
      comment: "Unique refinery identifier"
    - name: "state_province"
      expr: state_province
      comment: "Geographic state or province"
    - name: "city"
      expr: city
      comment: "City where the refinery is located"
    - name: "operational_status"
      expr: operational_status
      comment: "Current operational status (e.g., operating, idle)"
  measures:
    - name: "total_nameplate_capacity_bopd"
      expr: SUM(CAST(nameplate_capacity_bopd AS DOUBLE))
      comment: "Aggregate nameplate capacity across refineries (barrels per day)"
    - name: "avg_nelson_complexity_index"
      expr: AVG(CAST(nelson_complexity_index AS DOUBLE))
      comment: "Average Nelson Complexity Index, indicating overall refinery complexity"
$$;


CREATE OR REPLACE VIEW `oil_gas_ecm`.`_metrics`.`refining_product_quality_test`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Quality assurance metrics that drive product compliance and customer satisfaction"
  source: "`oil_gas_ecm`.`refining`.`product_quality_test`"
  dimensions:
    - name: "petroleum_product_id"
      expr: petroleum_product_id
      comment: "Product being tested"
    - name: "product_specification_id"
      expr: product_specification_id
      comment: "Specification against which the test is measured"
    - name: "test_method_code"
      expr: test_method_code
      comment: "Method used for the test"
    - name: "test_date"
      expr: DATE_TRUNC('day', test_datetime)
      comment: "Date the test was performed"
    - name: "certification_status"
      expr: certification_status
      comment: "Result status of the certification"
  measures:
    - name: "total_tests"
      expr: COUNT(1)
      comment: "Total number of quality tests performed"
    - name: "passed_tests"
      expr: COUNT(CASE WHEN certification_status = 'PASS' THEN 1 END)
      comment: "Number of tests that passed certification"
    - name: "avg_measured_value"
      expr: AVG(CAST(measured_value AS DOUBLE))
      comment: "Average measured value across all tests"
$$;


CREATE OR REPLACE VIEW `oil_gas_ecm`.`_metrics`.`refining_crude_receipt`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Supply‑side KPIs for procurement and cost control"
  source: "`oil_gas_ecm`.`refining`.`crude_receipt`"
  dimensions:
    - name: "refinery_id"
      expr: refinery_id
      comment: "Receiving refinery"
    - name: "crude_grade_id"
      expr: crude_grade_id
      comment: "Grade of crude received"
    - name: "receipt_day"
      expr: DATE_TRUNC('day', receipt_date)
      comment: "Date of receipt"
    - name: "production_facility_id"
      expr: production_facility_id
      comment: "Originating production facility"
  measures:
    - name: "total_gross_volume_bbl"
      expr: SUM(CAST(gross_volume_bbl AS DOUBLE))
      comment: "Total gross crude volume received in barrels"
    - name: "total_net_volume_bbl"
      expr: SUM(CAST(net_volume_bbl AS DOUBLE))
      comment: "Total net crude volume after losses, in barrels"
    - name: "total_cost_usd"
      expr: SUM(CAST(total_cost_usd AS DOUBLE))
      comment: "Total cost of crude receipts in USD"
$$;
