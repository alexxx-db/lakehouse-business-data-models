-- Metric views for domain: service | Business: Water_Utilities | Version: 2 | Generated on: 2026-07-02 04:05:05

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`service_agreement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Key financial and operational metrics for service agreements"
  source: "`vibe_water_utilities_v1`.`service`.`agreement`"
  dimensions:
    - name: "agreement_status"
      expr: agreement_status
      comment: "Current status of the agreement (e.g., active, terminated)"
    - name: "service_class_id"
      expr: service_class_id
      comment: "Identifier of the service class linked to the agreement"
    - name: "agreement_start_month"
      expr: DATE_TRUNC('month', start_date)
      comment: "Month when the agreement became effective"
  measures:
    - name: "total_agreements"
      expr: COUNT(1)
      comment: "Total number of service agreements"
    - name: "total_deposit_amount"
      expr: SUM(CAST(deposit_amount AS DOUBLE))
      comment: "Sum of all deposit amounts across agreements"
    - name: "avg_deposit_amount"
      expr: AVG(CAST(deposit_amount AS DOUBLE))
      comment: "Average deposit amount per agreement"
    - name: "auto_pay_enabled_count"
      expr: SUM(CASE WHEN auto_pay_enabled THEN 1 ELSE 0 END)
      comment: "Count of agreements where auto‑pay is enabled"
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`service_conservation_program`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Effectiveness and financial impact of water conservation programs"
  source: "`vibe_water_utilities_v1`.`service`.`conservation_program`"
  dimensions:
    - name: "program_type"
      expr: program_type
      comment: "Type of conservation program (e.g., rebate, education)"
    - name: "program_category"
      expr: program_category
      comment: "Business category of the program"
    - name: "territory_id"
      expr: territory_id
      comment: "Geographic territory where the program is active"
    - name: "regulatory_mandate_flag"
      expr: regulatory_mandate_flag
      comment: "Indicates if the program is driven by regulatory mandate"
    - name: "program_start_month"
      expr: DATE_TRUNC('month', program_start_date)
      comment: "Month the program started"
  measures:
    - name: "total_programs"
      expr: COUNT(1)
      comment: "Total number of conservation programs"
    - name: "total_incentive_amount"
      expr: SUM(CAST(incentive_amount AS DOUBLE))
      comment: "Sum of monetary incentives offered"
    - name: "total_actual_water_savings_gallons"
      expr: SUM(CAST(actual_water_savings_gallons AS DOUBLE))
      comment: "Aggregate actual water savings achieved"
    - name: "total_target_water_savings_gallons"
      expr: SUM(CAST(target_water_savings_gallons AS DOUBLE))
      comment: "Aggregate target water savings set for programs"
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`service_offering`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Pricing and eligibility metrics for service offerings"
  source: "`vibe_water_utilities_v1`.`service`.`offering`"
  dimensions:
    - name: "service_type"
      expr: service_type
      comment: "Type of service provided by the offering"
    - name: "rate_structure_type"
      expr: rate_structure_type
      comment: "Structure of the rate (e.g., volumetric, flat)"
    - name: "lifecycle_status"
      expr: lifecycle_status
      comment: "Current lifecycle status of the offering"
    - name: "effective_start_month"
      expr: DATE_TRUNC('month', effective_start_date)
      comment: "Month the offering became effective"
  measures:
    - name: "total_offerings"
      expr: COUNT(1)
      comment: "Total number of service offerings"
    - name: "avg_base_rate_amount"
      expr: AVG(CAST(base_rate_amount AS DOUBLE))
      comment: "Average base rate amount across offerings"
    - name: "total_capacity_charge"
      expr: SUM(CAST(capacity_charge AS DOUBLE))
      comment: "Sum of capacity charges across offerings"
    - name: "conservation_program_eligible_count"
      expr: SUM(CASE WHEN conservation_program_eligible_flag THEN 1 ELSE 0 END)
      comment: "Count of offerings eligible for conservation programs"
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`service_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Operational performance and revenue metrics for service orders"
  source: "`vibe_water_utilities_v1`.`service`.`order`"
  dimensions:
    - name: "order_status"
      expr: order_status
      comment: "Current status of the order"
    - name: "order_type"
      expr: order_type
      comment: "Classification of the order (e.g., new connection, maintenance)"
    - name: "priority"
      expr: priority
      comment: "Priority level assigned to the order"
    - name: "scheduled_date_day"
      expr: DATE_TRUNC('day', scheduled_date)
      comment: "Day on which the order is scheduled"
  measures:
    - name: "total_orders"
      expr: COUNT(1)
      comment: "Total number of service orders"
    - name: "total_service_fee"
      expr: SUM(CAST(service_fee_amount AS DOUBLE))
      comment: "Sum of service fees billed across orders"
    - name: "avg_service_fee"
      expr: AVG(CAST(service_fee_amount AS DOUBLE))
      comment: "Average service fee per order"
    - name: "sla_met_count"
      expr: SUM(CASE WHEN sla_met_flag THEN 1 ELSE 0 END)
      comment: "Count of orders that met SLA requirements"
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`service_point`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Physical and performance characteristics of service points"
  source: "`vibe_water_utilities_v1`.`service`.`point`"
  dimensions:
    - name: "service_type"
      expr: service_type
      comment: "Classification of service (e.g., residential, commercial)"
    - name: "service_point_status"
      expr: service_point_status
      comment: "Current operational status of the point"
    - name: "territory_id"
      expr: territory_id
      comment: "Geographic territory of the service point"
    - name: "installation_year"
      expr: DATE_TRUNC('year', installation_date)
      comment: "Year the service point was installed"
  measures:
    - name: "total_points"
      expr: COUNT(1)
      comment: "Total number of service points"
    - name: "avg_peak_demand_gpm"
      expr: AVG(CAST(peak_demand_gpm AS DOUBLE))
      comment: "Average peak demand per service point (gallons per minute)"
    - name: "total_elevation_feet"
      expr: SUM(CAST(elevation_feet AS DOUBLE))
      comment: "Cumulative elevation of all service points"
    - name: "fire_service_indicator_count"
      expr: SUM(CASE WHEN fire_service_indicator THEN 1 ELSE 0 END)
      comment: "Count of service points flagged for fire service"
$$;