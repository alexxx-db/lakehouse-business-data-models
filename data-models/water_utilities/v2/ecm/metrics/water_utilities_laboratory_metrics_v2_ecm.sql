-- Metric views for domain: laboratory | Business: Water_Utilities | Version: 2 | Generated on: 2026-07-02 04:05:05

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`laboratory_analyst_grant_allocation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Grant labor cost and effort allocation KPIs"
  source: "`vibe_water_utilities_v1`.`laboratory`.`analyst_grant_allocation`"
  dimensions:
    - name: "grant_id"
      expr: grant_id
      comment: "Identifier of the associated grant"
    - name: "cost_category"
      expr: cost_category
      comment: "Cost category for the allocation"
    - name: "grant_role"
      expr: grant_role
      comment: "Role of the analyst within the grant"
    - name: "allocation_period_start_date"
      expr: allocation_period_start_date
      comment: "Start date of the allocation period"
    - name: "allocation_period_end_date"
      expr: allocation_period_end_date
      comment: "End date of the allocation period"
  measures:
    - name: "total_labor_cost_allocation"
      expr: SUM(CAST(labor_cost_allocation AS DOUBLE))
      comment: "Total labor cost allocated across grants"
    - name: "total_effort_percentage"
      expr: SUM(CAST(effort_percentage AS DOUBLE))
      comment: "Aggregate effort percentage allocated"
    - name: "allocation_record_count"
      expr: COUNT(1)
      comment: "Number of grant allocation records"
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`laboratory_analytical_test`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core test execution KPIs for the laboratory"
  source: "`vibe_water_utilities_v1`.`laboratory`.`analytical_test`"
  dimensions:
    - name: "test_method_id"
      expr: test_method_id
      comment: "Identifier of the test method used"
    - name: "test_status"
      expr: test_status
      comment: "Current status of the test (e.g., Completed, InProgress)"
    - name: "test_priority"
      expr: test_priority
      comment: "Priority classification of the test"
    - name: "test_start_date"
      expr: DATE_TRUNC('day', test_start_timestamp)
      comment: "Date of test start (day granularity)"
  measures:
    - name: "total_test_count"
      expr: COUNT(1)
      comment: "Total number of analytical tests performed"
    - name: "average_turnaround_hours"
      expr: AVG(unix_timestamp(test_completion_timestamp) - unix_timestamp(test_start_timestamp)) / 3600
      comment: "Average turnaround time in hours from test start to completion"
    - name: "average_result_value"
      expr: AVG(CAST(result_value AS DOUBLE))
      comment: "Average numeric result value across tests"
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`laboratory_certified_analyst`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Analyst staffing and competency metrics"
  source: "`vibe_water_utilities_v1`.`laboratory`.`certified_analyst`"
  dimensions:
    - name: "certification_type"
      expr: certification_type
      comment: "Type of certification held by the analyst"
    - name: "certification_status"
      expr: certification_status
      comment: "Current status of the certification (e.g., Active, Expired)"
    - name: "specialty_areas"
      expr: specialty_areas
      comment: "Specialty areas of expertise for the analyst"
  measures:
    - name: "active_analyst_count"
      expr: SUM(CASE WHEN is_active THEN 1 ELSE 0 END)
      comment: "Number of certified analysts currently active"
    - name: "average_continuing_education_hours"
      expr: AVG(CAST(continuing_education_hours AS DOUBLE))
      comment: "Average continuing education hours per analyst"
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`laboratory_lab_instrument`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Instrument cost and utilization overview"
  source: "`vibe_water_utilities_v1`.`laboratory`.`lab_instrument`"
  dimensions:
    - name: "instrument_type"
      expr: instrument_type
      comment: "Type/category of the laboratory instrument"
    - name: "manufacturer"
      expr: manufacturer
      comment: "Instrument manufacturer"
    - name: "lab_location"
      expr: lab_location
      comment: "Physical location of the instrument within the lab"
    - name: "in_service_year"
      expr: YEAR(in_service_date)
      comment: "Year the instrument entered service"
  measures:
    - name: "average_annual_service_cost"
      expr: AVG(CAST(annual_service_cost AS DOUBLE))
      comment: "Average annual service cost per instrument"
    - name: "active_instrument_count"
      expr: SUM(CASE WHEN operational_status = 'Active' THEN 1 ELSE 0 END)
      comment: "Count of instruments currently marked as active"
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`laboratory_qc_batch`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Quality control batch acceptance metrics"
  source: "`vibe_water_utilities_v1`.`laboratory`.`qc_batch`"
  dimensions:
    - name: "batch_type"
      expr: batch_type
      comment: "Classification of the QC batch (e.g., Routine, Special)"
    - name: "lab_instrument_id"
      expr: lab_instrument_id
      comment: "Instrument associated with the QC batch"
    - name: "test_method_id"
      expr: test_method_id
      comment: "Test method used for the QC batch"
  measures:
    - name: "total_batch_count"
      expr: COUNT(1)
      comment: "Total number of QC batches processed"
    - name: "accepted_batch_count"
      expr: SUM(CASE WHEN overall_batch_acceptance_status = 'Accepted' THEN 1 ELSE 0 END)
      comment: "Number of QC batches that met acceptance criteria"
$$;