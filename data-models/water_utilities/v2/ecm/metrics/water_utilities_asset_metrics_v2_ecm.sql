-- Metric views for domain: asset | Business: Water_Utilities | Version: 2 | Generated on: 2026-07-02 04:05:05

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`asset_acquisition`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Key acquisition financial metrics for capital budgeting and asset growth tracking"
  source: "`vibe_water_utilities_v1`.`asset`.`acquisition`"
  dimensions:
    - name: "acquisition_type"
      expr: acquisition_type
      comment: "Category of acquisition (e.g., purchase, lease)"
  measures:
    - name: "total_acquisitions"
      expr: COUNT(1)
      comment: "Count of asset acquisition records"
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`asset_acquisition_financials`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Aggregated acquisition cost to monitor CAPEX spend against budget"
  source: "`vibe_water_utilities_v1`.`asset`.`acquisition`"
  dimensions:
    - name: "acquisition_status"
      expr: acquisition_status
      comment: "Current status of the acquisition process"
  measures:
    - name: "total_acquisition_cost"
      expr: SUM(CAST(cost AS DOUBLE))
      comment: "Total capital outlay for acquired assets"
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`asset_depreciation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Financial health of asset portfolio via depreciation tracking"
  source: "`vibe_water_utilities_v1`.`asset`.`depreciation_schedule`"
  dimensions:
    - name: "depreciation_method"
      expr: depreciation_method
      comment: "Method used for depreciation (e.g., straight-line)"
  measures:
    - name: "total_accumulated_depreciation"
      expr: SUM(CAST(accumulated_depreciation AS DOUBLE))
      comment: "Cumulative depreciation recorded for assets"
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`asset_depreciation_yearly`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Yearly depreciation expense to support budgeting and financial reporting"
  source: "`vibe_water_utilities_v1`.`asset`.`depreciation_schedule`"
  dimensions:
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the depreciation schedule"
  measures:
    - name: "total_annual_depreciation"
      expr: SUM(CAST(annual_depreciation_amount AS DOUBLE))
      comment: "Annual depreciation expense for the fiscal year"
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`asset_failure`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Operational reliability metrics for asset failures"
  source: "`vibe_water_utilities_v1`.`asset`.`failure_record`"
  dimensions:
    - name: "failure_cause"
      expr: failure_cause
      comment: "Root cause of the failure"
  measures:
    - name: "total_failures"
      expr: COUNT(1)
      comment: "Number of recorded asset failures"
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`asset_failure_impact`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Impact of failures on service continuity"
  source: "`vibe_water_utilities_v1`.`asset`.`failure_record`"
  dimensions:
    - name: "failure_severity"
      expr: failure_severity
      comment: "Severity level of the failure"
  measures:
    - name: "total_downtime_hours"
      expr: SUM(CAST(downtime_duration_hours AS DOUBLE))
      comment: "Aggregate downtime caused by asset failures"
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`asset_work_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Work order volume and efficiency metrics"
  source: "`vibe_water_utilities_v1`.`asset`.`work_order`"
  dimensions:
    - name: "work_order_type"
      expr: work_order_type
      comment: "Type of work order (e.g., corrective, preventive)"
  measures:
    - name: "total_work_orders"
      expr: COUNT(1)
      comment: "Count of work orders executed"
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`asset_work_order_duration`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Turnaround time metric for maintenance execution"
  source: "`vibe_water_utilities_v1`.`asset`.`work_order`"
  dimensions:
    - name: "work_order_status"
      expr: work_order_status
      comment: "Current status of the work order"
  measures:
    - name: "average_work_order_duration_hours"
      expr: AVG((unix_timestamp(actual_finish_timestamp) - unix_timestamp(actual_start_timestamp)) / 3600.0)
      comment: "Average time to complete a work order in hours"
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`asset_work_order_performance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Labor utilization and cost efficiency for maintenance activities"
  source: "`vibe_water_utilities_v1`.`asset`.`work_order`"
  dimensions:
    - name: "priority"
      expr: priority
      comment: "Priority level assigned to the work order"
  measures:
    - name: "total_labor_hours"
      expr: SUM(CAST(actual_labor_hours AS DOUBLE))
      comment: "Total labor hours spent on work orders"
$$;