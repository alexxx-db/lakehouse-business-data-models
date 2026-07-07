-- Metric views for domain: metering | Business: Water_Utilities | Version: 2 | Generated on: 2026-07-02 04:05:05

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`metering_consumption_profile`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Key consumption KPIs per customer and service attributes"
  source: "`vibe_water_utilities_v1`.`metering`.`consumption_profile`"
  dimensions:
    - name: "billing_period_start_date"
      expr: billing_period_start_date
      comment: "Start date of the billing period"
    - name: "customer_class"
      expr: customer_class
      comment: "Customer classification (e.g., residential, commercial)"
    - name: "service_type"
      expr: service_type
      comment: "Type of water service provided"
    - name: "meter_technology"
      expr: meter_technology
      comment: "Technology of the meter (e.g., AMI, mechanical)"
    - name: "consumption_tier"
      expr: consumption_tier
      comment: "Consumption tier used for billing"
  measures:
    - name: "total_consumption_gallons"
      expr: SUM(CAST(total_consumption_gallons AS DOUBLE))
      comment: "Total water consumption in gallons for the period"
    - name: "average_daily_usage_gpd"
      expr: AVG(CAST(average_daily_usage_gpd AS DOUBLE))
      comment: "Average daily usage in gallons per day across records"
    - name: "high_usage_alert_count"
      expr: SUM(CASE WHEN high_usage_alert_flag THEN 1 ELSE 0 END)
      comment: "Count of records flagged as high usage alerts"
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`metering_high_usage_alert`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic alerts indicating abnormal water usage"
  source: "`vibe_water_utilities_v1`.`metering`.`high_usage_alert`"
  dimensions:
    - name: "alert_severity"
      expr: alert_severity
      comment: "Severity level of the alert"
    - name: "alert_status"
      expr: alert_status
      comment: "Current status of the alert"
    - name: "detection_period_start_timestamp"
      expr: detection_period_start_timestamp
      comment: "Start of the detection period for the alert"
    - name: "customer_account_id"
      expr: customer_account_id
      comment: "Customer account linked to the alert"
  measures:
    - name: "alert_count"
      expr: COUNT(1)
      comment: "Total number of high‑usage alerts generated"
    - name: "avg_estimated_revenue_impact_amount"
      expr: AVG(CAST(estimated_revenue_impact_amount AS DOUBLE))
      comment: "Average estimated revenue impact per alert"
    - name: "avg_estimated_water_loss_gallons"
      expr: AVG(CAST(estimated_water_loss_gallons AS DOUBLE))
      comment: "Average estimated water loss in gallons per alert"
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`metering_interval_consumption`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Interval‑level consumption and flow performance metrics"
  source: "`vibe_water_utilities_v1`.`metering`.`interval_consumption`"
  dimensions:
    - name: "interval_start_timestamp"
      expr: interval_start_timestamp
      comment: "Start timestamp of the consumption interval"
    - name: "dma_id"
      expr: dma_id
      comment: "Distribution Management Area identifier"
    - name: "alarm_code"
      expr: alarm_code
      comment: "Alarm code generated for the interval"
  measures:
    - name: "total_consumption_volume_gallons"
      expr: SUM(CAST(consumption_volume_gallons AS DOUBLE))
      comment: "Total volume consumed in gallons for the interval"
    - name: "average_flow_rate_gpm"
      expr: AVG(CAST(flow_rate_gpm AS DOUBLE))
      comment: "Average flow rate in gallons per minute"
    - name: "high_usage_interval_count"
      expr: SUM(CASE WHEN high_usage_flag THEN 1 ELSE 0 END)
      comment: "Number of intervals flagged as high usage"
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`metering_leak_detection_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Leak detection KPIs for operational risk management"
  source: "`vibe_water_utilities_v1`.`metering`.`leak_detection_event`"
  dimensions:
    - name: "detection_timestamp"
      expr: detection_timestamp
      comment: "Timestamp when the leak was detected"
    - name: "alert_severity"
      expr: alert_severity
      comment: "Severity of the leak alert"
    - name: "dma_id"
      expr: dma_id
      comment: "Distribution Management Area where leak was detected"
    - name: "customer_account_id"
      expr: customer_account_id
      comment: "Customer account linked to the leak event"
  measures:
    - name: "leak_event_count"
      expr: COUNT(1)
      comment: "Total number of leak detection events recorded"
    - name: "avg_estimated_leak_volume_gallons_per_day"
      expr: AVG(CAST(estimated_leak_volume_gallons_per_day AS DOUBLE))
      comment: "Average estimated leak volume per day"
    - name: "avg_confidence_score"
      expr: AVG(CAST(confidence_score AS DOUBLE))
      comment: "Average confidence score of leak detection"
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`metering_meter_field_inspection`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Operational quality metrics from meter field inspections"
  source: "`vibe_water_utilities_v1`.`metering`.`meter_field_inspection`"
  dimensions:
    - name: "inspection_date"
      expr: inspection_date
      comment: "Date of the field inspection"
    - name: "service_address_id"
      expr: service_address_id
      comment: "Service address associated with the inspected meter"
    - name: "leak_detected_flag"
      expr: leak_detected_flag
      comment: "Whether a leak was detected during inspection"
  measures:
    - name: "inspection_count"
      expr: COUNT(1)
      comment: "Total number of field inspections performed"
    - name: "avg_gps_accuracy_meters"
      expr: AVG(CAST(gps_accuracy_meters AS DOUBLE))
      comment: "Average GPS accuracy of inspection locations in meters"
    - name: "seal_intact_count"
      expr: SUM(CASE WHEN seal_intact_flag THEN 1 ELSE 0 END)
      comment: "Count of inspections where the meter seal was intact"
$$;