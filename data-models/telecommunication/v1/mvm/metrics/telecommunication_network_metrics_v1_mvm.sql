-- Metric views for domain: network | Business: Telecommunication | Version: 1 | Generated on: 2026-05-08 08:27:22

CREATE OR REPLACE VIEW `telecommunication_ecm`.`_metrics`.`network_alarm`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Network alarm KPIs tracking incident volume, severity distribution, resolution efficiency, and customer impact across network infrastructure"
  source: "`telecommunication_ecm`.`network`.`alarm`"
  dimensions:
    - name: "alarm_severity"
      expr: severity
      comment: "Severity level of the alarm (critical, major, minor, warning)"
    - name: "alarm_type"
      expr: alarm_type
      comment: "Type classification of the alarm"
    - name: "alarm_status"
      expr: alarm_status
      comment: "Current status of the alarm (open, acknowledged, cleared, closed)"
    - name: "acknowledgement_status"
      expr: acknowledgement_status
      comment: "Whether the alarm has been acknowledged by operations"
    - name: "network_domain"
      expr: network_domain
      comment: "Network domain where the alarm originated (core, access, transport, etc.)"
    - name: "service_impact_level"
      expr: service_impact_level
      comment: "Level of service impact caused by the alarm"
    - name: "escalation_level"
      expr: escalation_level
      comment: "Current escalation level of the alarm"
    - name: "sla_breach_flag"
      expr: sla_breach_flag
      comment: "Whether the alarm resulted in an SLA breach"
    - name: "root_cause_alarm_flag"
      expr: root_cause_alarm_flag
      comment: "Whether this alarm is identified as a root cause"
    - name: "vendor_name"
      expr: vendor_name
      comment: "Vendor of the affected network element"
    - name: "geographic_location"
      expr: geographic_location
      comment: "Geographic location of the alarm"
    - name: "raise_date"
      expr: DATE(raise_timestamp)
      comment: "Date when the alarm was raised"
    - name: "raise_month"
      expr: DATE_TRUNC('MONTH', raise_timestamp)
      comment: "Month when the alarm was raised"
  measures:
    - name: "total_alarms"
      expr: COUNT(1)
      comment: "Total number of network alarms raised"
    - name: "unique_affected_elements"
      expr: COUNT(DISTINCT element_id)
      comment: "Count of distinct network elements that generated alarms"
    - name: "unique_affected_subscribers"
      expr: COUNT(DISTINCT subscriber_id)
      comment: "Count of distinct subscribers impacted by alarms"
    - name: "total_customer_impact"
      expr: SUM(CAST(customer_impact_count AS DOUBLE))
      comment: "Total count of customers impacted across all alarms"
    - name: "avg_resolution_time_minutes"
      expr: AVG(CAST(duration_minutes AS DOUBLE))
      comment: "Average time in minutes from alarm raise to clear"
    - name: "total_alarm_duration_minutes"
      expr: SUM(CAST(duration_minutes AS DOUBLE))
      comment: "Total duration in minutes of all alarms"
    - name: "sla_breach_count"
      expr: SUM(CASE WHEN sla_breach_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of alarms that resulted in SLA breaches"
    - name: "root_cause_alarm_count"
      expr: SUM(CASE WHEN root_cause_alarm_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of alarms identified as root cause incidents"
    - name: "critical_alarm_count"
      expr: SUM(CASE WHEN severity = 'critical' THEN 1 ELSE 0 END)
      comment: "Count of critical severity alarms"
    - name: "unacknowledged_alarm_count"
      expr: SUM(CASE WHEN acknowledgement_status = 'unacknowledged' THEN 1 ELSE 0 END)
      comment: "Count of alarms not yet acknowledged by operations"
$$;


CREATE OR REPLACE VIEW `telecommunication_ecm`.`_metrics`.`network_capacity`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Network capacity utilization and planning KPIs tracking resource consumption, congestion risk, and growth trends across network infrastructure"
  source: "`telecommunication_ecm`.`network`.`capacity`"
  dimensions:
    - name: "resource_type"
      expr: resource_type
      comment: "Type of network resource being measured (bandwidth, ports, spectrum, etc.)"
    - name: "capacity_status"
      expr: capacity_status
      comment: "Current status of capacity (normal, warning, critical, exhausted)"
    - name: "technology_domain"
      expr: technology_domain
      comment: "Technology domain of the capacity measurement (RAN, core, transport, etc.)"
    - name: "network_layer"
      expr: network_layer
      comment: "Network layer where capacity is measured (physical, data link, network, etc.)"
    - name: "geographic_region"
      expr: geographic_region
      comment: "Geographic region of the capacity measurement"
    - name: "vendor_name"
      expr: vendor_name
      comment: "Vendor of the equipment being measured"
    - name: "qos_class"
      expr: qos_class
      comment: "Quality of service class for the capacity measurement"
    - name: "busy_hour_indicator"
      expr: busy_hour_indicator
      comment: "Whether this measurement was taken during busy hour"
    - name: "measurement_month"
      expr: DATE_TRUNC('MONTH', measurement_start_timestamp)
      comment: "Month of the capacity measurement"
  measures:
    - name: "total_capacity_units"
      expr: SUM(CAST(total_capacity AS DOUBLE))
      comment: "Total provisioned capacity across all resources"
    - name: "total_available_capacity_units"
      expr: SUM(CAST(available_capacity AS DOUBLE))
      comment: "Total available (unused) capacity across all resources"
    - name: "total_committed_capacity_units"
      expr: SUM(CAST(committed_capacity AS DOUBLE))
      comment: "Total capacity committed to services and customers"
    - name: "avg_utilization_pct"
      expr: AVG(CAST(average_utilization_percentage AS DOUBLE))
      comment: "Average utilization percentage across measured resources"
    - name: "avg_peak_utilization_pct"
      expr: AVG(CAST(peak_utilization_percentage AS DOUBLE))
      comment: "Average peak utilization percentage during measurement period"
    - name: "resources_above_congestion_threshold"
      expr: SUM(CASE WHEN CAST(average_utilization_percentage AS DOUBLE) >= CAST(congestion_threshold_percentage AS DOUBLE) THEN 1 ELSE 0 END)
      comment: "Count of resources exceeding congestion threshold"
    - name: "resources_above_critical_threshold"
      expr: SUM(CASE WHEN CAST(average_utilization_percentage AS DOUBLE) >= CAST(critical_threshold_percentage AS DOUBLE) THEN 1 ELSE 0 END)
      comment: "Count of resources exceeding critical utilization threshold"
    - name: "avg_growth_rate_pct"
      expr: AVG(CAST(growth_rate_percentage AS DOUBLE))
      comment: "Average capacity growth rate percentage"
    - name: "total_capacity_measurements"
      expr: COUNT(1)
      comment: "Total number of capacity measurements recorded"
$$;


CREATE OR REPLACE VIEW `telecommunication_ecm`.`_metrics`.`network_config_change`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Network configuration change management KPIs tracking change volume, success rates, risk levels, and operational impact"
  source: "`telecommunication_ecm`.`network`.`config_change`"
  dimensions:
    - name: "change_priority"
      expr: change_priority
      comment: "Priority level of the configuration change (emergency, high, medium, low)"
    - name: "risk_level"
      expr: risk_level
      comment: "Risk assessment level of the change (high, medium, low)"
    - name: "validation_result"
      expr: validation_result
      comment: "Result of change validation (success, failure, partial)"
    - name: "compliance_validated"
      expr: compliance_validated
      comment: "Whether the change was validated for compliance"
    - name: "backup_created"
      expr: backup_created
      comment: "Whether a backup was created before the change"
    - name: "noc_notification_sent"
      expr: noc_notification_sent
      comment: "Whether NOC was notified of the change"
    - name: "executed_by_system"
      expr: executed_by_system
      comment: "System that executed the configuration change"
    - name: "change_month"
      expr: DATE_TRUNC('MONTH', scheduled_start_timestamp)
      comment: "Month when the change was scheduled"
  measures:
    - name: "total_config_changes"
      expr: COUNT(1)
      comment: "Total number of configuration changes executed"
    - name: "successful_changes"
      expr: SUM(CASE WHEN validation_result = 'success' THEN 1 ELSE 0 END)
      comment: "Count of successfully validated configuration changes"
    - name: "failed_changes"
      expr: SUM(CASE WHEN validation_result = 'failure' THEN 1 ELSE 0 END)
      comment: "Count of failed configuration changes"
    - name: "high_risk_changes"
      expr: SUM(CASE WHEN risk_level = 'high' THEN 1 ELSE 0 END)
      comment: "Count of high-risk configuration changes"
    - name: "emergency_changes"
      expr: SUM(CASE WHEN change_priority = 'emergency' THEN 1 ELSE 0 END)
      comment: "Count of emergency priority configuration changes"
    - name: "changes_without_backup"
      expr: SUM(CASE WHEN backup_created = FALSE THEN 1 ELSE 0 END)
      comment: "Count of changes executed without creating a backup"
    - name: "total_affected_customers"
      expr: SUM(CAST(affected_customers_count AS DOUBLE))
      comment: "Total count of customers affected by configuration changes"
    - name: "total_downtime_minutes"
      expr: SUM(CAST(downtime_duration_minutes AS DOUBLE))
      comment: "Total downtime in minutes caused by configuration changes"
    - name: "avg_downtime_minutes"
      expr: AVG(CAST(downtime_duration_minutes AS DOUBLE))
      comment: "Average downtime in minutes per configuration change"
$$;


CREATE OR REPLACE VIEW `telecommunication_ecm`.`_metrics`.`network_element`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Network element inventory and lifecycle KPIs tracking asset deployment, operational state, reliability, and maintenance efficiency"
  source: "`telecommunication_ecm`.`network`.`element`"
  dimensions:
    - name: "element_type"
      expr: element_type
      comment: "Type of network element (router, switch, base station, etc.)"
    - name: "lifecycle_state"
      expr: lifecycle_state
      comment: "Current lifecycle state (planned, deployed, active, decommissioned)"
    - name: "operational_state"
      expr: operational_state
      comment: "Current operational state (enabled, disabled, testing, maintenance)"
    - name: "administrative_state"
      expr: administrative_state
      comment: "Administrative state (locked, unlocked, shutting down)"
    - name: "nfv_indicator"
      expr: nfv_indicator
      comment: "Whether the element is virtualized (NFV)"
    - name: "redundancy_mode"
      expr: redundancy_mode
      comment: "Redundancy configuration of the element"
    - name: "activation_year"
      expr: YEAR(activation_date)
      comment: "Year when the element was activated"
    - name: "activation_month"
      expr: DATE_TRUNC('MONTH', activation_date)
      comment: "Month when the element was activated"
  measures:
    - name: "total_network_elements"
      expr: COUNT(1)
      comment: "Total count of network elements in inventory"
    - name: "active_elements"
      expr: SUM(CASE WHEN lifecycle_state = 'active' THEN 1 ELSE 0 END)
      comment: "Count of network elements in active lifecycle state"
    - name: "operational_elements"
      expr: SUM(CASE WHEN operational_state = 'enabled' THEN 1 ELSE 0 END)
      comment: "Count of network elements in enabled operational state"
    - name: "virtualized_elements"
      expr: SUM(CASE WHEN nfv_indicator = TRUE THEN 1 ELSE 0 END)
      comment: "Count of virtualized (NFV) network elements"
    - name: "total_capacity_value"
      expr: SUM(CAST(capacity_value AS DOUBLE))
      comment: "Total capacity value across all network elements"
    - name: "avg_capacity_value"
      expr: AVG(CAST(capacity_value AS DOUBLE))
      comment: "Average capacity value per network element"
    - name: "total_power_consumption_watts"
      expr: SUM(CAST(power_consumption_watts AS DOUBLE))
      comment: "Total power consumption in watts across all elements"
    - name: "avg_mtbf_hours"
      expr: AVG(CAST(mtbf_hours AS DOUBLE))
      comment: "Average mean time between failures in hours"
    - name: "avg_mttr_hours"
      expr: AVG(CAST(mttr_hours AS DOUBLE))
      comment: "Average mean time to repair in hours"
    - name: "elements_warranty_expired"
      expr: SUM(CASE WHEN warranty_expiration_date < CURRENT_DATE THEN 1 ELSE 0 END)
      comment: "Count of network elements with expired warranty"
$$;


CREATE OR REPLACE VIEW `telecommunication_ecm`.`_metrics`.`network_performance_counter`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Network performance monitoring KPIs tracking service quality, SLA compliance, threshold breaches, and customer-impacting degradation"
  source: "`telecommunication_ecm`.`network`.`performance_counter`"
  dimensions:
    - name: "kpi_category"
      expr: kpi_category
      comment: "Category of the KPI (availability, latency, throughput, quality, etc.)"
    - name: "kpi_name"
      expr: kpi_name
      comment: "Name of the specific KPI being measured"
    - name: "counter_name"
      expr: counter_name
      comment: "Name of the performance counter"
    - name: "network_technology"
      expr: network_technology
      comment: "Network technology (4G, 5G, fiber, etc.)"
    - name: "network_layer"
      expr: network_layer
      comment: "Network layer of the measurement"
    - name: "service_type"
      expr: service_type
      comment: "Type of service being measured"
    - name: "geographic_region_code"
      expr: geographic_region_code
      comment: "Geographic region code where measurement was taken"
    - name: "threshold_breach_flag"
      expr: threshold_breach_flag
      comment: "Whether the measurement breached defined thresholds"
    - name: "sla_applicable_flag"
      expr: sla_applicable_flag
      comment: "Whether this measurement is subject to SLA"
    - name: "customer_impact_flag"
      expr: customer_impact_flag
      comment: "Whether the measurement indicates customer impact"
    - name: "breach_severity"
      expr: breach_severity
      comment: "Severity level of threshold breach"
    - name: "collection_status"
      expr: collection_status
      comment: "Status of the data collection (success, failure, partial)"
    - name: "measurement_month"
      expr: DATE_TRUNC('MONTH', measurement_timestamp)
      comment: "Month of the performance measurement"
  measures:
    - name: "total_performance_measurements"
      expr: COUNT(1)
      comment: "Total number of performance counter measurements"
    - name: "avg_kpi_value"
      expr: AVG(CAST(kpi_value AS DOUBLE))
      comment: "Average KPI value across all measurements"
    - name: "avg_counter_value"
      expr: AVG(CAST(counter_value AS DOUBLE))
      comment: "Average counter value across all measurements"
    - name: "total_threshold_breaches"
      expr: SUM(CASE WHEN threshold_breach_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of measurements that breached thresholds"
    - name: "customer_impacting_events"
      expr: SUM(CASE WHEN customer_impact_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of measurements indicating customer impact"
    - name: "sla_applicable_measurements"
      expr: SUM(CASE WHEN sla_applicable_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of measurements subject to SLA"
    - name: "critical_breaches"
      expr: SUM(CASE WHEN breach_severity = 'critical' THEN 1 ELSE 0 END)
      comment: "Count of critical severity threshold breaches"
    - name: "avg_data_quality_score"
      expr: AVG(CAST(data_quality_score AS DOUBLE))
      comment: "Average data quality score of measurements"
    - name: "total_sample_count"
      expr: SUM(CAST(sample_count AS BIGINT))
      comment: "Total number of samples collected across all measurements"
    - name: "failed_collections"
      expr: SUM(CASE WHEN collection_status = 'failure' THEN 1 ELSE 0 END)
      comment: "Count of failed performance data collections"
$$;


CREATE OR REPLACE VIEW `telecommunication_ecm`.`_metrics`.`network_planned_outage`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Planned maintenance and outage KPIs tracking execution efficiency, customer impact, SLA compliance, and change success rates"
  source: "`telecommunication_ecm`.`network`.`planned_outage`"
  dimensions:
    - name: "outage_type"
      expr: outage_type
      comment: "Type of planned outage (maintenance, upgrade, migration, etc.)"
    - name: "outage_status"
      expr: outage_status
      comment: "Current status of the outage (planned, in-progress, completed, cancelled)"
    - name: "outage_outcome"
      expr: outage_outcome
      comment: "Outcome of the outage (successful, failed, partial)"
    - name: "maintenance_window_type"
      expr: maintenance_window_type
      comment: "Type of maintenance window (standard, emergency, extended)"
    - name: "impact_severity"
      expr: impact_severity
      comment: "Severity of customer impact (none, low, medium, high, critical)"
    - name: "risk_assessment_level"
      expr: risk_assessment_level
      comment: "Risk level assessed for the outage"
    - name: "cab_approval_status"
      expr: cab_approval_status
      comment: "Change Advisory Board approval status"
    - name: "sla_exclusion_flag"
      expr: sla_exclusion_flag
      comment: "Whether the outage is excluded from SLA calculations"
    - name: "rollback_executed_flag"
      expr: rollback_executed_flag
      comment: "Whether a rollback was executed during the outage"
    - name: "customer_notification_status"
      expr: customer_notification_status
      comment: "Status of customer notification"
    - name: "post_outage_validation_status"
      expr: post_outage_validation_status
      comment: "Status of post-outage validation"
    - name: "planned_month"
      expr: DATE_TRUNC('MONTH', planned_start_timestamp)
      comment: "Month when the outage was planned to start"
  measures:
    - name: "total_planned_outages"
      expr: COUNT(1)
      comment: "Total number of planned outages"
    - name: "successful_outages"
      expr: SUM(CASE WHEN outage_outcome = 'successful' THEN 1 ELSE 0 END)
      comment: "Count of successfully completed outages"
    - name: "failed_outages"
      expr: SUM(CASE WHEN outage_outcome = 'failed' THEN 1 ELSE 0 END)
      comment: "Count of failed outages"
    - name: "outages_with_rollback"
      expr: SUM(CASE WHEN rollback_executed_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of outages requiring rollback execution"
    - name: "total_affected_customers"
      expr: SUM(CAST(affected_customer_count AS DOUBLE))
      comment: "Total count of customers affected by planned outages"
    - name: "avg_affected_customers"
      expr: AVG(CAST(affected_customer_count AS DOUBLE))
      comment: "Average number of customers affected per outage"
    - name: "total_planned_duration_minutes"
      expr: SUM(CAST(planned_duration_minutes AS DOUBLE))
      comment: "Total planned duration in minutes across all outages"
    - name: "total_actual_duration_minutes"
      expr: SUM(CAST(actual_duration_minutes AS DOUBLE))
      comment: "Total actual duration in minutes across all outages"
    - name: "avg_planned_duration_minutes"
      expr: AVG(CAST(planned_duration_minutes AS DOUBLE))
      comment: "Average planned duration in minutes per outage"
    - name: "avg_actual_duration_minutes"
      expr: AVG(CAST(actual_duration_minutes AS DOUBLE))
      comment: "Average actual duration in minutes per outage"
    - name: "high_impact_outages"
      expr: SUM(CASE WHEN impact_severity IN ('high', 'critical') THEN 1 ELSE 0 END)
      comment: "Count of outages with high or critical customer impact"
$$;


CREATE OR REPLACE VIEW `telecommunication_ecm`.`_metrics`.`network_ran_cell`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Radio Access Network cell KPIs tracking coverage deployment, technology mix, operational state, and capacity configuration"
  source: "`telecommunication_ecm`.`network`.`ran_cell`"
  dimensions:
    - name: "radio_access_technology"
      expr: radio_access_technology
      comment: "Radio access technology (LTE, NR, UMTS, GSM)"
    - name: "technology_generation"
      expr: technology_generation
      comment: "Technology generation (2G, 3G, 4G, 5G)"
    - name: "cell_operational_state"
      expr: cell_operational_state
      comment: "Current operational state of the cell"
    - name: "administrative_state"
      expr: administrative_state
      comment: "Administrative state of the cell"
    - name: "coverage_type"
      expr: coverage_type
      comment: "Type of coverage (macro, micro, pico, indoor, outdoor)"
    - name: "deployment_scenario"
      expr: deployment_scenario
      comment: "Deployment scenario (urban, suburban, rural, highway)"
    - name: "frequency_band"
      expr: frequency_band
      comment: "Frequency band used by the cell"
    - name: "carrier_aggregation_enabled"
      expr: carrier_aggregation_enabled
      comment: "Whether carrier aggregation is enabled"
    - name: "beamforming_enabled"
      expr: beamforming_enabled
      comment: "Whether beamforming is enabled"
    - name: "mimo_configuration"
      expr: mimo_configuration
      comment: "MIMO antenna configuration"
    - name: "load_balancing_enabled"
      expr: load_balancing_enabled
      comment: "Whether load balancing is enabled"
    - name: "energy_saving_mode"
      expr: energy_saving_mode
      comment: "Energy saving mode configuration"
    - name: "vendor_name"
      expr: vendor_name
      comment: "Vendor of the RAN equipment"
    - name: "activation_year"
      expr: YEAR(cell_activation_date)
      comment: "Year when the cell was activated"
    - name: "activation_month"
      expr: DATE_TRUNC('MONTH', cell_activation_date)
      comment: "Month when the cell was activated"
  measures:
    - name: "total_ran_cells"
      expr: COUNT(1)
      comment: "Total number of RAN cells deployed"
    - name: "operational_cells"
      expr: SUM(CASE WHEN cell_operational_state = 'operational' THEN 1 ELSE 0 END)
      comment: "Count of cells in operational state"
    - name: "5g_cells"
      expr: SUM(CASE WHEN technology_generation = '5G' THEN 1 ELSE 0 END)
      comment: "Count of 5G cells"
    - name: "4g_cells"
      expr: SUM(CASE WHEN technology_generation = '4G' THEN 1 ELSE 0 END)
      comment: "Count of 4G/LTE cells"
    - name: "carrier_aggregation_cells"
      expr: SUM(CASE WHEN carrier_aggregation_enabled = TRUE THEN 1 ELSE 0 END)
      comment: "Count of cells with carrier aggregation enabled"
    - name: "beamforming_cells"
      expr: SUM(CASE WHEN beamforming_enabled = TRUE THEN 1 ELSE 0 END)
      comment: "Count of cells with beamforming enabled"
    - name: "avg_antenna_height_meters"
      expr: AVG(CAST(antenna_height_meters AS DOUBLE))
      comment: "Average antenna height in meters"
    - name: "avg_transmit_power_dbm"
      expr: AVG(CAST(transmit_power_dbm AS DOUBLE))
      comment: "Average transmit power in dBm"
    - name: "avg_bandwidth_mhz"
      expr: AVG(CAST(bandwidth_mhz AS DOUBLE))
      comment: "Average bandwidth in MHz"
    - name: "total_cell_capacity_users"
      expr: SUM(CAST(cell_capacity_users AS DOUBLE))
      comment: "Total user capacity across all cells"
    - name: "avg_cell_capacity_users"
      expr: AVG(CAST(cell_capacity_users AS DOUBLE))
      comment: "Average user capacity per cell"
$$;


CREATE OR REPLACE VIEW `telecommunication_ecm`.`_metrics`.`network_slice`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Network slice lifecycle and utilization KPIs tracking 5G slice deployment, tenant isolation, operational state, and resource allocation"
  source: "`telecommunication_ecm`.`network`.`slice`"
  dimensions:
    - name: "slice_type"
      expr: slice_type
      comment: "Type of network slice (eMBB, URLLC, mMTC, custom)"
    - name: "lifecycle_state"
      expr: lifecycle_state
      comment: "Current lifecycle state of the slice"
    - name: "operational_status"
      expr: operational_status
      comment: "Current operational status of the slice"
    - name: "deployment_model"
      expr: deployment_model
      comment: "Deployment model (dedicated, shared, hybrid)"
    - name: "isolation_level"
      expr: isolation_level
      comment: "Level of isolation (physical, logical, none)"
    - name: "charging_model"
      expr: charging_model
      comment: "Charging model for the slice"
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level of the slice"
    - name: "sst_value"
      expr: sst_value
      comment: "Slice/Service Type value (3GPP standard)"
    - name: "orchestrator_system"
      expr: orchestrator_system
      comment: "Orchestration system managing the slice"
    - name: "activation_month"
      expr: DATE_TRUNC('MONTH', activation_timestamp)
      comment: "Month when the slice was activated"
  measures:
    - name: "total_network_slices"
      expr: COUNT(1)
      comment: "Total number of network slices"
    - name: "active_slices"
      expr: SUM(CASE WHEN lifecycle_state = 'active' THEN 1 ELSE 0 END)
      comment: "Count of slices in active lifecycle state"
    - name: "operational_slices"
      expr: SUM(CASE WHEN operational_status = 'operational' THEN 1 ELSE 0 END)
      comment: "Count of slices in operational status"
    - name: "embb_slices"
      expr: SUM(CASE WHEN slice_type = 'eMBB' THEN 1 ELSE 0 END)
      comment: "Count of enhanced Mobile Broadband slices"
    - name: "urllc_slices"
      expr: SUM(CASE WHEN slice_type = 'URLLC' THEN 1 ELSE 0 END)
      comment: "Count of Ultra-Reliable Low-Latency Communication slices"
    - name: "mmtc_slices"
      expr: SUM(CASE WHEN slice_type = 'mMTC' THEN 1 ELSE 0 END)
      comment: "Count of massive Machine-Type Communication slices"
    - name: "total_current_ue_count"
      expr: SUM(CAST(current_ue_count AS DOUBLE))
      comment: "Total current user equipment count across all slices"
    - name: "total_max_ue_count"
      expr: SUM(CAST(max_ue_count AS DOUBLE))
      comment: "Total maximum user equipment capacity across all slices"
    - name: "avg_current_ue_count"
      expr: AVG(CAST(current_ue_count AS DOUBLE))
      comment: "Average current user equipment count per slice"
    - name: "unique_tenants"
      expr: COUNT(DISTINCT tenant_code)
      comment: "Count of distinct tenants using network slices"
$$;


CREATE OR REPLACE VIEW `telecommunication_ecm`.`_metrics`.`network_topology`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Network topology and connectivity KPIs tracking link availability, utilization, performance, and SLA compliance"
  source: "`telecommunication_ecm`.`network`.`topology`"
  dimensions:
    - name: "link_type"
      expr: link_type
      comment: "Type of network link (fiber, microwave, satellite, etc.)"
    - name: "operational_state"
      expr: operational_state
      comment: "Current operational state of the link"
    - name: "administrative_state"
      expr: administrative_state
      comment: "Administrative state of the link"
    - name: "network_layer"
      expr: network_layer
      comment: "Network layer of the link (physical, data link, network)"
    - name: "technology_standard"
      expr: technology_standard
      comment: "Technology standard used by the link"
    - name: "is_protected"
      expr: is_protected
      comment: "Whether the link has protection/redundancy"
    - name: "is_bidirectional"
      expr: is_bidirectional
      comment: "Whether the link is bidirectional"
    - name: "is_virtual"
      expr: is_virtual
      comment: "Whether the link is virtual (overlay)"
    - name: "protection_scheme"
      expr: protection_scheme
      comment: "Protection scheme used (1+1, 1:1, 1:N, etc.)"
    - name: "vendor_name"
      expr: vendor_name
      comment: "Vendor of the link equipment"
    - name: "installation_year"
      expr: YEAR(installation_date)
      comment: "Year when the link was installed"
  measures:
    - name: "total_topology_links"
      expr: COUNT(1)
      comment: "Total number of network topology links"
    - name: "operational_links"
      expr: SUM(CASE WHEN operational_state = 'operational' THEN 1 ELSE 0 END)
      comment: "Count of links in operational state"
    - name: "protected_links"
      expr: SUM(CASE WHEN is_protected = TRUE THEN 1 ELSE 0 END)
      comment: "Count of links with protection/redundancy"
    - name: "virtual_links"
      expr: SUM(CASE WHEN is_virtual = TRUE THEN 1 ELSE 0 END)
      comment: "Count of virtual overlay links"
    - name: "total_link_capacity_mbps"
      expr: SUM(CAST(link_capacity_mbps AS DOUBLE))
      comment: "Total link capacity in Mbps across all links"
    - name: "avg_link_capacity_mbps"
      expr: AVG(CAST(link_capacity_mbps AS DOUBLE))
      comment: "Average link capacity in Mbps per link"
    - name: "avg_utilization_pct"
      expr: AVG(CAST(utilization_percentage AS DOUBLE))
      comment: "Average utilization percentage across all links"
    - name: "avg_link_latency_ms"
      expr: AVG(CAST(link_latency_ms AS DOUBLE))
      comment: "Average link latency in milliseconds"
    - name: "total_link_distance_km"
      expr: SUM(CAST(link_distance_km AS DOUBLE))
      comment: "Total link distance in kilometers"
    - name: "avg_actual_availability_pct"
      expr: AVG(CAST(actual_availability_percentage AS DOUBLE))
      comment: "Average actual availability percentage"
    - name: "avg_sla_target_availability_pct"
      expr: AVG(CAST(sla_target_availability_percentage AS DOUBLE))
      comment: "Average SLA target availability percentage"
    - name: "avg_mtbf_hours"
      expr: AVG(CAST(mtbf_hours AS DOUBLE))
      comment: "Average mean time between failures in hours"
    - name: "avg_mttr_hours"
      expr: AVG(CAST(mttr_hours AS DOUBLE))
      comment: "Average mean time to repair in hours"
$$;


CREATE OR REPLACE VIEW `telecommunication_ecm`.`_metrics`.`network_transmission_link`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Transmission link asset and performance KPIs tracking leased capacity, utilization, cost efficiency, and maintenance compliance"
  source: "`telecommunication_ecm`.`network`.`transmission_link`"
  dimensions:
    - name: "link_type"
      expr: link_type
      comment: "Type of transmission link (fiber, microwave, satellite, leased line)"
    - name: "link_status"
      expr: link_status
      comment: "Current status of the transmission link"
    - name: "owner_organization"
      expr: owner_organization
      comment: "Organization that owns the transmission link"
    - name: "protection_type"
      expr: protection_type
      comment: "Protection type (protected, unprotected, diverse route)"
    - name: "fiber_type"
      expr: fiber_type
      comment: "Type of fiber (single-mode, multi-mode)"
    - name: "right_of_way_type"
      expr: right_of_way_type
      comment: "Right of way type (owned, leased, IRU)"
    - name: "capacity_unit"
      expr: capacity_unit
      comment: "Unit of capacity measurement (Gbps, wavelengths, etc.)"
    - name: "vendor"
      expr: vendor
      comment: "Vendor of the transmission equipment"
    - name: "commissioning_year"
      expr: YEAR(commissioning_date)
      comment: "Year when the link was commissioned"
  measures:
    - name: "total_transmission_links"
      expr: COUNT(1)
      comment: "Total number of transmission links"
    - name: "active_links"
      expr: SUM(CASE WHEN link_status = 'active' THEN 1 ELSE 0 END)
      comment: "Count of active transmission links"
    - name: "protected_links"
      expr: SUM(CASE WHEN protection_type = 'protected' THEN 1 ELSE 0 END)
      comment: "Count of protected transmission links"
    - name: "total_capacity_value"
      expr: SUM(CAST(capacity_value AS DOUBLE))
      comment: "Total capacity value across all transmission links"
    - name: "avg_capacity_value"
      expr: AVG(CAST(capacity_value AS DOUBLE))
      comment: "Average capacity value per transmission link"
    - name: "avg_utilization_pct"
      expr: AVG(CAST(utilization_percent AS DOUBLE))
      comment: "Average utilization percentage across transmission links"
    - name: "total_route_distance_km"
      expr: SUM(CAST(route_distance_km AS DOUBLE))
      comment: "Total route distance in kilometers"
    - name: "avg_route_distance_km"
      expr: AVG(CAST(route_distance_km AS DOUBLE))
      comment: "Average route distance in kilometers per link"
    - name: "avg_latency_ms"
      expr: AVG(CAST(latency_ms AS DOUBLE))
      comment: "Average latency in milliseconds"
    - name: "avg_attenuation_db"
      expr: AVG(CAST(attenuation_db AS DOUBLE))
      comment: "Average attenuation in decibels"
    - name: "total_lease_monthly_cost"
      expr: SUM(CAST(lease_monthly_cost AS DOUBLE))
      comment: "Total monthly lease cost across all leased transmission links"
    - name: "avg_lease_monthly_cost"
      expr: AVG(CAST(lease_monthly_cost AS DOUBLE))
      comment: "Average monthly lease cost per leased transmission link"
    - name: "total_fiber_pair_count"
      expr: SUM(CAST(fiber_pair_count AS DOUBLE))
      comment: "Total count of fiber pairs across all links"
    - name: "total_wavelength_count"
      expr: SUM(CAST(wavelength_count AS DOUBLE))
      comment: "Total count of wavelengths across all links"
$$;
