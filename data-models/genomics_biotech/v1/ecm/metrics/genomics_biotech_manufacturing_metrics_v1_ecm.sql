-- Metric views for domain: manufacturing | Business: Genomics Biotech | Version: 1 | Generated on: 2026-05-06 12:58:41

CREATE OR REPLACE VIEW `genomics_biotech_ecm`.`_metrics`.`manufacturing_production_batch`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core production batch performance metrics."
  source: "`genomics_biotech_ecm`.`manufacturing`.`production_batch`"
  dimensions:
    - name: "manufacturing_site_id"
      expr: manufacturing_site_id
      comment: "Identifier of the manufacturing site where the batch was produced."
    - name: "batch_status"
      expr: batch_status
      comment: "Current status of the batch (e.g., Completed, In-Progress)."
    - name: "batch_month"
      expr: DATE_TRUNC('month', created_timestamp)
      comment: "Month of batch creation."
  measures:
    - name: "batch_count"
      expr: COUNT(1)
      comment: "Number of production batches."
    - name: "total_batch_size_actual"
      expr: SUM(CAST(batch_size_actual AS DOUBLE))
      comment: "Total actual batch size across all batches."
    - name: "total_batch_size_planned"
      expr: SUM(CAST(batch_size_planned AS DOUBLE))
      comment: "Total planned batch size across all batches."
    - name: "avg_yield_percentage"
      expr: AVG(CAST(yield_percentage AS DOUBLE))
      comment: "Average yield percentage of batches."
$$;

CREATE OR REPLACE VIEW `genomics_biotech_ecm`.`_metrics`.`manufacturing_campaign`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Campaign-level performance and cost efficiency."
  source: "`genomics_biotech_ecm`.`manufacturing`.`manufacturing_campaign`"
  dimensions:
    - name: "campaign_type"
      expr: campaign_type
      comment: "Type of manufacturing campaign (e.g., pilot, full-scale)."
    - name: "campaign_status"
      expr: manufacturing_campaign_status
      comment: "Current status of the campaign."
  measures:
    - name: "campaign_count"
      expr: COUNT(1)
      comment: "Number of manufacturing campaigns."
    - name: "total_actual_yield"
      expr: SUM(CAST(actual_yield AS DOUBLE))
      comment: "Sum of actual yield across campaigns."
    - name: "total_target_yield"
      expr: SUM(CAST(target_yield AS DOUBLE))
      comment: "Sum of target yield across campaigns."
    - name: "total_cost_actual"
      expr: SUM(CAST(cost_actual AS DOUBLE))
      comment: "Total actual cost incurred by campaigns."
    - name: "total_cost_estimate"
      expr: SUM(CAST(cost_estimate AS DOUBLE))
      comment: "Total estimated cost for campaigns."
$$;

CREATE OR REPLACE VIEW `genomics_biotech_ecm`.`_metrics`.`manufacturing_equipment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Equipment utilization and reliability metrics."
  source: "`genomics_biotech_ecm`.`manufacturing`.`equipment`"
  dimensions:
    - name: "equipment_type"
      expr: equipment_type
      comment: "Category of equipment (e.g., bioreactor, centrifuge)."
    - name: "equipment_status"
      expr: equipment_status
      comment: "Operational status of the equipment."
    - name: "manufacturer"
      expr: manufacturer
      comment: "Equipment manufacturer name."
    - name: "equipment_location"
      expr: location
      comment: "Physical location of the equipment within the site."
  measures:
    - name: "equipment_count"
      expr: COUNT(1)
      comment: "Number of equipment assets."
    - name: "total_usage_hours"
      expr: SUM(CAST(usage_hours_total AS DOUBLE))
      comment: "Cumulative usage hours across all equipment."
    - name: "avg_mtbf_hours"
      expr: AVG(CAST(mtbf_hours AS DOUBLE))
      comment: "Average Mean Time Between Failures (MTBF) in hours."
    - name: "avg_mttr_hours"
      expr: AVG(CAST(mttr_hours AS DOUBLE))
      comment: "Average Mean Time To Repair (MTTR) in hours."
$$;

CREATE OR REPLACE VIEW `genomics_biotech_ecm`.`_metrics`.`manufacturing_work_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Work order efficiency and output quality."
  source: "`genomics_biotech_ecm`.`manufacturing`.`work_order`"
  dimensions:
    - name: "manufacturing_site_id"
      expr: manufacturing_site_id
      comment: "Site where the work order is executed."
    - name: "work_center_id"
      expr: work_center_id
      comment: "Work center responsible for the order."
    - name: "order_type"
      expr: order_type
      comment: "Classification of the work order (e.g., standard, rush)."
    - name: "work_order_month"
      expr: DATE_TRUNC('month', created_timestamp)
      comment: "Month when the work order was created."
  measures:
    - name: "work_order_count"
      expr: COUNT(1)
      comment: "Number of work orders."
    - name: "total_planned_quantity"
      expr: SUM(CAST(planned_quantity AS DOUBLE))
      comment: "Total planned production quantity across work orders."
    - name: "total_actual_quantity"
      expr: SUM(CAST(actual_quantity AS DOUBLE))
      comment: "Total actual production quantity delivered by work orders."
    - name: "total_scrap_quantity"
      expr: SUM(CAST(scrap_quantity AS DOUBLE))
      comment: "Total quantity scrapped during work order execution."
    - name: "avg_yield_percentage"
      expr: AVG(CAST(yield_percentage AS DOUBLE))
      comment: "Average yield percentage across work orders."
$$;

CREATE OR REPLACE VIEW `genomics_biotech_ecm`.`_metrics`.`manufacturing_env_monitoring_result`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Environmental monitoring compliance and trend metrics."
  source: "`genomics_biotech_ecm`.`manufacturing`.`env_monitoring_result`"
  dimensions:
    - name: "manufacturing_site_id"
      expr: manufacturing_site_id
      comment: "Site where monitoring took place."
    - name: "monitoring_type"
      expr: monitoring_type
      comment: "Type of environmental monitoring (e.g., temperature, humidity)."
    - name: "result_status"
      expr: result_status
      comment: "Overall status of the monitoring result."
    - name: "clean_room_classification"
      expr: clean_room_classification
      comment: "Clean room classification for the monitoring location."
    - name: "monitoring_month"
      expr: DATE_TRUNC('month', created_timestamp)
      comment: "Month of the monitoring event."
  measures:
    - name: "env_monitoring_result_count"
      expr: COUNT(1)
      comment: "Number of environmental monitoring records."
    - name: "action_limit_breach_count"
      expr: SUM(CASE WHEN action_limit_breach_flag THEN 1 ELSE 0 END)
      comment: "Count of records where action limit was breached."
    - name: "alert_limit_breach_count"
      expr: SUM(CASE WHEN alert_limit_breach_flag THEN 1 ELSE 0 END)
      comment: "Count of records where alert limit was breached."
    - name: "avg_measured_value"
      expr: AVG(CAST(measured_value AS DOUBLE))
      comment: "Average measured value across monitoring events."
$$;
