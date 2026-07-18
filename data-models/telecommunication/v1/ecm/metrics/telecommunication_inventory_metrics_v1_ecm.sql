-- Metric views for domain: inventory | Business: Telecommunication | Version: 1 | Generated on: 2026-05-08 05:01:11

CREATE OR REPLACE VIEW `telecommunication_ecm`.`_metrics`.`inventory_asset_lifecycle_cost`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Cost and financial impact of asset lifecycle events"
  source: "`telecommunication_ecm`.`inventory`.`asset_lifecycle_event`"
  dimensions:
    - name: "event_type"
      expr: event_type
      comment: "Type of lifecycle event (e.g., installation, decommission)"
    - name: "asset_category"
      expr: asset_category
      comment: "Category of the asset involved"
    - name: "event_month"
      expr: DATE_TRUNC('month', event_timestamp)
      comment: "Month of the event"
  measures:
    - name: "total_cost_impact"
      expr: SUM(CAST(cost_impact AS DOUBLE))
      comment: "Total cost impact of all asset lifecycle events"
    - name: "average_cost_impact"
      expr: AVG(CAST(cost_impact AS DOUBLE))
      comment: "Average cost impact per asset lifecycle event"
    - name: "high_cost_event_count"
      expr: SUM(CASE WHEN cost_impact > 10000 THEN 1 ELSE 0 END)
      comment: "Count of events where cost impact exceeds $10,000"
$$;

CREATE OR REPLACE VIEW `telecommunication_ecm`.`_metrics`.`inventory_circuit_utilization`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Financial and capacity utilization of network circuits"
  source: "`telecommunication_ecm`.`inventory`.`circuit`"
  dimensions:
    - name: "circuit_type"
      expr: circuit_type
      comment: "Type of circuit (e.g., fiber, microwave)"
    - name: "provider_name"
      expr: provider_name
      comment: "Network provider delivering the circuit"
    - name: "circuit_status"
      expr: circuit_status
      comment: "Current status of the circuit"
    - name: "activation_month"
      expr: DATE_TRUNC('month', activation_timestamp)
      comment: "Month when the circuit was activated"
  measures:
    - name: "total_monthly_cost"
      expr: SUM(CAST(monthly_cost AS DOUBLE))
      comment: "Sum of monthly recurring cost for circuits"
    - name: "average_bandwidth_mbps"
      expr: AVG(CAST(bandwidth_mbps AS DOUBLE))
      comment: "Average bandwidth provisioned per circuit"
    - name: "active_circuit_count"
      expr: SUM(CASE WHEN deactivation_timestamp IS NULL THEN 1 ELSE 0 END)
      comment: "Number of currently active circuits"
$$;

CREATE OR REPLACE VIEW `telecommunication_ecm`.`_metrics`.`inventory_fiber_cable_attenuation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Physical performance characteristics of fiber cables"
  source: "`telecommunication_ecm`.`inventory`.`fiber_cable`"
  dimensions:
    - name: "cable_type"
      expr: cable_type
      comment: "Physical type of the fiber cable"
    - name: "deployment_method"
      expr: deployment_method
      comment: "Method used to deploy the cable (e.g., aerial, underground)"
  measures:
    - name: "average_attenuation_db_per_km"
      expr: AVG(CAST(attenuation_db_per_km AS DOUBLE))
      comment: "Mean signal attenuation per kilometer across fiber cables"
    - name: "average_conduit_fill_ratio_percent"
      expr: AVG(CAST(conduit_fill_ratio_percent AS DOUBLE))
      comment: "Average conduit fill ratio percentage"
    - name: "cable_count"
      expr: COUNT(1)
      comment: "Total number of fiber cable records"
$$;

CREATE OR REPLACE VIEW `telecommunication_ecm`.`_metrics`.`inventory_network_equipment_maintenance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Maintenance readiness and repair efficiency of network equipment"
  source: "`telecommunication_ecm`.`inventory`.`network_equipment`"
  dimensions:
    - name: "equipment_type"
      expr: equipment_type
      comment: "Category of network equipment (router, switch, etc.)"
    - name: "operational_status"
      expr: operational_status
      comment: "Current operational status"
    - name: "site_id"
      expr: location_site_id
      comment: "Site where the equipment is installed"
  measures:
    - name: "upcoming_maintenance_count"
      expr: SUM(CASE WHEN next_maintenance_due_date <= CURRENT_DATE() THEN 1 ELSE 0 END)
      comment: "Count of equipment with maintenance due this week or earlier"
    - name: "average_mttr_hours"
      expr: AVG(CAST(mttr_hours AS DOUBLE))
      comment: "Mean time to repair across equipment"
$$;

CREATE OR REPLACE VIEW `telecommunication_ecm`.`_metrics`.`inventory_spare_part_inventory`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Inventory levels and consumption of spare parts"
  source: "`telecommunication_ecm`.`inventory`.`spare_part`"
  dimensions:
    - name: "part_category"
      expr: part_category
      comment: "High‑level category of the spare part"
    - name: "vendor_part_number"
      expr: vendor_part_number
      comment: "Vendor supplied part number"
    - name: "location_site_id"
      expr: pop_facility_id
      comment: "Facility where the part is stored"
  measures:
    - name: "total_current_stock_quantity"
      expr: SUM(CAST(current_stock_quantity AS DOUBLE))
      comment: "Total quantity of spare parts currently in stock"
    - name: "total_reserved_quantity"
      expr: SUM(CAST(reserved_quantity AS DOUBLE))
      comment: "Quantity of spare parts reserved for future use"
    - name: "total_annual_consumption_quantity"
      expr: SUM(CAST(annual_consumption_quantity AS DOUBLE))
      comment: "Projected annual consumption of spare parts"
$$;

CREATE OR REPLACE VIEW `telecommunication_ecm`.`_metrics`.`inventory_ip_address_pool_utilization`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Utilization of IP address pools"
  source: "`telecommunication_ecm`.`inventory`.`ip_address_pool`"
  dimensions:
    - name: "ip_version"
      expr: ip_version
      comment: "IP version (IPv4 or IPv6)"
    - name: "network_zone"
      expr: network_zone
      comment: "Network zone the pool belongs to"
    - name: "pool_status"
      expr: pool_status
      comment: "Current status of the pool (active, retired)"
  measures:
    - name: "total_assigned_count"
      expr: SUM(CAST(assigned_count AS DOUBLE))
      comment: "Total number of IP addresses assigned from the pool"
    - name: "total_capacity"
      expr: SUM(CAST(total_capacity AS DOUBLE))
      comment: "Total capacity of the IP address pool"
$$;
