-- Metric views for domain: terminal | Business: Shipping_Ports | Version: 2 | Generated on: 2026-07-13 10:21:34

CREATE OR REPLACE VIEW `vibe_shipping_ports_v1`.`_metrics`.`terminal_berth_allocation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Berth allocation performance and utilization metrics tracking vessel berthing efficiency, turnaround times, and operational compliance"
  source: "`vibe_shipping_ports_v1`.`terminal`.`berth_allocation`"
  dimensions:
    - name: "allocation_status"
      expr: allocation_status
      comment: "Current status of the berth allocation (e.g., confirmed, cancelled, completed)"
    - name: "allocation_reason"
      expr: allocation_reason
      comment: "Business reason for the berth allocation"
    - name: "cargo_operation_type"
      expr: cargo_operation_type
      comment: "Type of cargo operation (e.g., loading, discharge, both)"
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level assigned to the berth allocation"
    - name: "pilotage_required_flag"
      expr: pilotage_required_flag
      comment: "Whether pilotage services are required for this allocation"
    - name: "towage_required_flag"
      expr: towage_required_flag
      comment: "Whether towage services are required for this allocation"
    - name: "imdg_cargo_flag"
      expr: imdg_cargo_flag
      comment: "Whether the allocation involves dangerous goods (IMDG)"
    - name: "weather_restriction_flag"
      expr: weather_restriction_flag
      comment: "Whether weather restrictions apply to this allocation"
    - name: "allocation_year"
      expr: YEAR(berth_window_start)
      comment: "Year of the berth window start"
    - name: "allocation_month"
      expr: DATE_TRUNC('MONTH', berth_window_start)
      comment: "Month of the berth window start"
    - name: "allocation_date"
      expr: DATE(berth_window_start)
      comment: "Date of the berth window start"
  measures:
    - name: "total_berth_allocations"
      expr: COUNT(1)
      comment: "Total number of berth allocations"
    - name: "avg_berth_window_duration_hours"
      expr: AVG(CAST(berth_window_duration_hours AS DOUBLE))
      comment: "Average planned berth window duration in hours - key efficiency metric for berth planning"
    - name: "avg_allocated_quay_length_m"
      expr: AVG(CAST(allocated_quay_length_m AS DOUBLE))
      comment: "Average allocated quay length in meters - measures berth space utilization"
    - name: "avg_vessel_loa_m"
      expr: AVG(CAST(vessel_loa_m AS DOUBLE))
      comment: "Average vessel length overall in meters - indicates vessel size profile"
    - name: "avg_vessel_draft_m"
      expr: AVG(CAST(vessel_draft_m AS DOUBLE))
      comment: "Average vessel draft in meters - critical for berth depth planning"
    - name: "avg_sla_turnaround_time_hours"
      expr: AVG(CAST(sla_turnaround_time_hours AS DOUBLE))
      comment: "Average SLA turnaround time in hours - key service level commitment metric"
    - name: "avg_berth_productivity_target_mph"
      expr: AVG(CAST(berth_productivity_target_mph AS DOUBLE))
      comment: "Average berth productivity target in moves per hour - operational efficiency benchmark"
    - name: "total_allocated_crane_count"
      expr: SUM(CAST(allocated_crane_count AS DOUBLE))
      comment: "Total number of cranes allocated across all berth allocations - resource deployment metric"
    - name: "berth_utilization_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN allocation_status IN ('confirmed', 'completed') THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of berth allocations that are confirmed or completed - measures berth utilization efficiency"
    - name: "cancellation_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN allocation_status = 'cancelled' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of berth allocations that were cancelled - indicates planning accuracy and operational disruption"
    - name: "pilotage_required_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN pilotage_required_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of allocations requiring pilotage services - impacts marine service costs"
    - name: "hazmat_cargo_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN imdg_cargo_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of allocations involving dangerous goods - critical for safety and compliance planning"
$$;

CREATE OR REPLACE VIEW `vibe_shipping_ports_v1`.`_metrics`.`terminal_container_visit`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Container throughput and dwell time metrics tracking container movements, storage efficiency, and terminal productivity"
  source: "`vibe_shipping_ports_v1`.`terminal`.`container_visit`"
  dimensions:
    - name: "visit_status"
      expr: visit_status
      comment: "Current status of the container visit"
    - name: "cargo_type"
      expr: cargo_type
      comment: "Type of cargo in the container"
    - name: "full_empty_indicator"
      expr: full_empty_indicator
      comment: "Whether the container is full or empty"
    - name: "arrival_mode"
      expr: arrival_mode
      comment: "Mode of arrival (e.g., vessel, truck, rail)"
    - name: "departure_mode"
      expr: departure_mode
      comment: "Mode of departure (e.g., vessel, truck, rail)"
    - name: "reefer_flag"
      expr: reefer_flag
      comment: "Whether the container is a refrigerated unit"
    - name: "oog_flag"
      expr: oog_flag
      comment: "Whether the container is out-of-gauge (oversized)"
    - name: "damage_flag"
      expr: damage_flag
      comment: "Whether the container has damage"
    - name: "imdg_class"
      expr: imdg_class
      comment: "IMDG dangerous goods classification"
    - name: "gate_in_year"
      expr: YEAR(gate_in_timestamp)
      comment: "Year of container gate-in"
    - name: "gate_in_month"
      expr: DATE_TRUNC('MONTH', gate_in_timestamp)
      comment: "Month of container gate-in"
    - name: "gate_in_date"
      expr: DATE(gate_in_timestamp)
      comment: "Date of container gate-in"
  measures:
    - name: "total_container_visits"
      expr: COUNT(1)
      comment: "Total number of container visits"
    - name: "total_teu"
      expr: SUM(CAST(teu_factor AS DOUBLE))
      comment: "Total TEU (Twenty-foot Equivalent Units) - primary container throughput metric"
    - name: "avg_dwell_time_hours"
      expr: AVG(CAST(dwell_time_hours AS DOUBLE))
      comment: "Average container dwell time in hours - critical efficiency and cost metric for terminal operations"
    - name: "avg_vgm_weight_kg"
      expr: AVG(CAST(vgm_weight_kg AS DOUBLE))
      comment: "Average verified gross mass in kilograms - indicates cargo weight profile"
    - name: "avg_tare_weight_kg"
      expr: AVG(CAST(tare_weight_kg AS DOUBLE))
      comment: "Average tare weight in kilograms - container weight baseline"
    - name: "avg_reefer_temperature_setpoint_c"
      expr: AVG(CAST(reefer_temperature_setpoint_c AS DOUBLE))
      comment: "Average reefer temperature setpoint in Celsius - for cold chain management"
    - name: "reefer_container_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN reefer_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of containers that are refrigerated - impacts power infrastructure and operational costs"
    - name: "oog_container_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN oog_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of out-of-gauge containers - requires special handling and impacts yard planning"
    - name: "damage_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN damage_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of containers with damage - quality and liability metric"
    - name: "hazmat_container_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN imdg_class IS NOT NULL THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of containers with dangerous goods - critical for safety and compliance"
    - name: "full_container_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN full_empty_indicator = 'Full' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of full containers - indicates cargo vs. repositioning movements"
    - name: "unique_containers"
      expr: COUNT(DISTINCT container_number)
      comment: "Count of unique container numbers - measures container diversity"
$$;

CREATE OR REPLACE VIEW `vibe_shipping_ports_v1`.`_metrics`.`terminal_equipment_dispatch`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Equipment productivity and crane performance metrics tracking handling efficiency, moves per hour, and operational effectiveness"
  source: "`vibe_shipping_ports_v1`.`terminal`.`equipment_dispatch`"
  dimensions:
    - name: "dispatch_status"
      expr: dispatch_status
      comment: "Current status of the equipment dispatch"
    - name: "work_instruction_type"
      expr: work_instruction_type
      comment: "Type of work instruction (e.g., load, discharge, restow)"
    - name: "equipment_type"
      expr: equipment_type
      comment: "Type of equipment dispatched"
    - name: "productive_flag"
      expr: productive_flag
      comment: "Whether the dispatch was productive (vs. idle or non-productive)"
    - name: "rehandle_flag"
      expr: rehandle_flag
      comment: "Whether the move was a rehandle (inefficiency indicator)"
    - name: "reefer_flag"
      expr: reefer_flag
      comment: "Whether the container is refrigerated"
    - name: "hazmat_flag"
      expr: hazmat_flag
      comment: "Whether the container contains dangerous goods"
    - name: "oversized_flag"
      expr: oversized_flag
      comment: "Whether the container is oversized"
    - name: "twin_lift_flag"
      expr: twin_lift_flag
      comment: "Whether twin-lift operation was used"
    - name: "tandem_lift_flag"
      expr: tandem_lift_flag
      comment: "Whether tandem-lift operation was used"
    - name: "dispatch_year"
      expr: YEAR(dispatch_timestamp)
      comment: "Year of equipment dispatch"
    - name: "dispatch_month"
      expr: DATE_TRUNC('MONTH', dispatch_timestamp)
      comment: "Month of equipment dispatch"
    - name: "dispatch_date"
      expr: DATE(dispatch_timestamp)
      comment: "Date of equipment dispatch"
  measures:
    - name: "total_dispatches"
      expr: COUNT(1)
      comment: "Total number of equipment dispatches"
    - name: "avg_moves_per_hour"
      expr: AVG(CAST(moves_per_hour AS DOUBLE))
      comment: "Average moves per hour - primary crane and equipment productivity metric"
    - name: "avg_reefer_temperature_celsius"
      expr: AVG(CAST(reefer_temperature_celsius AS DOUBLE))
      comment: "Average reefer temperature in Celsius for dispatched reefer containers"
    - name: "productive_dispatch_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN productive_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of dispatches that were productive - key operational efficiency metric"
    - name: "rehandle_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN rehandle_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of moves that were rehandles - indicates yard planning efficiency and cost of rework"
    - name: "twin_lift_utilization_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN twin_lift_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of dispatches using twin-lift - measures advanced productivity technique adoption"
    - name: "tandem_lift_utilization_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN tandem_lift_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of dispatches using tandem-lift - measures advanced productivity technique adoption"
    - name: "hazmat_dispatch_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN hazmat_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of dispatches involving dangerous goods - safety and compliance metric"
    - name: "oversized_dispatch_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN oversized_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of dispatches involving oversized cargo - requires special handling"
    - name: "unique_equipment_deployed"
      expr: COUNT(DISTINCT equipment_id)
      comment: "Count of unique equipment units deployed - measures equipment fleet utilization"
$$;

CREATE OR REPLACE VIEW `vibe_shipping_ports_v1`.`_metrics`.`terminal_gate_transaction`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Gate throughput and processing efficiency metrics tracking truck turnaround times, transaction volumes, and gate performance"
  source: "`vibe_shipping_ports_v1`.`terminal`.`gate_transaction`"
  dimensions:
    - name: "transaction_status"
      expr: transaction_status
      comment: "Status of the gate transaction"
    - name: "transaction_type"
      expr: transaction_type
      comment: "Type of gate transaction (e.g., gate-in, gate-out)"
    - name: "damage_flag"
      expr: damage_flag
      comment: "Whether damage was detected during gate transaction"
    - name: "gate_clerk_override_flag"
      expr: gate_clerk_override_flag
      comment: "Whether gate clerk override was required"
    - name: "seal_verification_status"
      expr: seal_verification_status
      comment: "Status of seal verification"
    - name: "imdg_class"
      expr: imdg_class
      comment: "IMDG dangerous goods classification"
    - name: "transaction_year"
      expr: YEAR(transaction_timestamp)
      comment: "Year of gate transaction"
    - name: "transaction_month"
      expr: DATE_TRUNC('MONTH', transaction_timestamp)
      comment: "Month of gate transaction"
    - name: "transaction_date"
      expr: DATE(transaction_timestamp)
      comment: "Date of gate transaction"
    - name: "transaction_hour"
      expr: HOUR(transaction_timestamp)
      comment: "Hour of day for gate transaction - for peak hour analysis"
  measures:
    - name: "total_gate_transactions"
      expr: COUNT(1)
      comment: "Total number of gate transactions"
    - name: "avg_verified_gross_mass_kg"
      expr: AVG(CAST(verified_gross_mass_kg AS DOUBLE))
      comment: "Average verified gross mass in kilograms"
    - name: "avg_weight_bridge_reading_kg"
      expr: AVG(CAST(weight_bridge_reading_kg AS DOUBLE))
      comment: "Average weight bridge reading in kilograms"
    - name: "avg_reefer_temperature_actual_c"
      expr: AVG(CAST(reefer_temperature_actual_c AS DOUBLE))
      comment: "Average actual reefer temperature in Celsius"
    - name: "avg_reefer_temperature_setpoint_c"
      expr: AVG(CAST(reefer_temperature_setpoint_c AS DOUBLE))
      comment: "Average reefer temperature setpoint in Celsius"
    - name: "damage_detection_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN damage_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of transactions where damage was detected - quality and liability metric"
    - name: "gate_override_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN gate_clerk_override_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of transactions requiring clerk override - indicates process exceptions and system accuracy"
    - name: "hazmat_transaction_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN imdg_class IS NOT NULL THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of transactions involving dangerous goods - safety and compliance metric"
    - name: "unique_trucks"
      expr: COUNT(DISTINCT truck_license_plate)
      comment: "Count of unique truck license plates - measures truck diversity and haulier base"
    - name: "unique_drivers"
      expr: COUNT(DISTINCT driver_license_number)
      comment: "Count of unique driver license numbers - measures driver base and training needs"
$$;

CREATE OR REPLACE VIEW `vibe_shipping_ports_v1`.`_metrics`.`terminal_reefer_monitoring`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Cold chain compliance and reefer performance metrics tracking temperature deviations, alarm rates, and refrigeration system health"
  source: "`vibe_shipping_ports_v1`.`terminal`.`reefer_monitoring`"
  dimensions:
    - name: "monitoring_status"
      expr: monitoring_status
      comment: "Status of reefer monitoring"
    - name: "alarm_flag"
      expr: alarm_flag
      comment: "Whether an alarm was triggered"
    - name: "alarm_type"
      expr: alarm_type
      comment: "Type of alarm (e.g., temperature, power, door)"
    - name: "alarm_severity"
      expr: alarm_severity
      comment: "Severity level of the alarm"
    - name: "cold_chain_compliance_flag"
      expr: cold_chain_compliance_flag
      comment: "Whether cold chain compliance was maintained"
    - name: "corrective_action_required"
      expr: corrective_action_required
      comment: "Whether corrective action is required"
    - name: "sla_breach_flag"
      expr: sla_breach_flag
      comment: "Whether SLA was breached"
    - name: "power_status"
      expr: power_status
      comment: "Power status of the reefer unit"
    - name: "compressor_status"
      expr: compressor_status
      comment: "Compressor operational status"
    - name: "door_status"
      expr: door_status
      comment: "Door status (open/closed)"
    - name: "monitoring_year"
      expr: YEAR(monitoring_timestamp)
      comment: "Year of monitoring event"
    - name: "monitoring_month"
      expr: DATE_TRUNC('MONTH', monitoring_timestamp)
      comment: "Month of monitoring event"
    - name: "monitoring_date"
      expr: DATE(monitoring_timestamp)
      comment: "Date of monitoring event"
  measures:
    - name: "total_monitoring_events"
      expr: COUNT(1)
      comment: "Total number of reefer monitoring events"
    - name: "avg_actual_temperature"
      expr: AVG(CAST(actual_temperature AS DOUBLE))
      comment: "Average actual temperature in Celsius"
    - name: "avg_set_temperature"
      expr: AVG(CAST(set_temperature AS DOUBLE))
      comment: "Average set temperature in Celsius"
    - name: "avg_temperature_deviation"
      expr: AVG(CAST(temperature_deviation AS DOUBLE))
      comment: "Average temperature deviation from setpoint - critical cold chain quality metric"
    - name: "avg_humidity_reading"
      expr: AVG(CAST(humidity_reading AS DOUBLE))
      comment: "Average humidity reading percentage"
    - name: "avg_compressor_runtime_hours"
      expr: AVG(CAST(compressor_runtime_hours AS DOUBLE))
      comment: "Average compressor runtime hours - equipment health indicator"
    - name: "avg_power_supply_voltage"
      expr: AVG(CAST(power_supply_voltage AS DOUBLE))
      comment: "Average power supply voltage"
    - name: "avg_ventilation_rate"
      expr: AVG(CAST(ventilation_rate AS DOUBLE))
      comment: "Average ventilation rate"
    - name: "avg_co2_level"
      expr: AVG(CAST(co2_level AS DOUBLE))
      comment: "Average CO2 level - important for controlled atmosphere cargo"
    - name: "avg_o2_level"
      expr: AVG(CAST(o2_level AS DOUBLE))
      comment: "Average O2 level - important for controlled atmosphere cargo"
    - name: "alarm_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN alarm_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of monitoring events with alarms - key operational quality and risk metric"
    - name: "cold_chain_compliance_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN cold_chain_compliance_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of monitoring events maintaining cold chain compliance - critical quality and liability metric"
    - name: "sla_breach_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN sla_breach_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of monitoring events with SLA breaches - service level performance metric"
    - name: "corrective_action_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN corrective_action_required = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of events requiring corrective action - operational intervention metric"
    - name: "unique_reefer_containers"
      expr: COUNT(DISTINCT container_visit_id)
      comment: "Count of unique reefer container visits monitored"
$$;

CREATE OR REPLACE VIEW `vibe_shipping_ports_v1`.`_metrics`.`terminal_yard_slot`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Yard capacity and slot utilization metrics tracking storage efficiency, occupancy rates, and yard planning effectiveness"
  source: "`vibe_shipping_ports_v1`.`terminal`.`yard_slot`"
  dimensions:
    - name: "slot_status"
      expr: slot_status
      comment: "Current status of the yard slot"
    - name: "slot_type"
      expr: slot_type
      comment: "Type of yard slot (e.g., standard, reefer, hazmat)"
    - name: "occupied_flag"
      expr: occupied_flag
      comment: "Whether the slot is currently occupied"
    - name: "active_flag"
      expr: active_flag
      comment: "Whether the slot is active and available for use"
    - name: "reefer_plug_available"
      expr: reefer_plug_available
      comment: "Whether reefer plug is available in this slot"
    - name: "hazmat_approved"
      expr: hazmat_approved
      comment: "Whether the slot is approved for hazardous materials"
    - name: "oog_approved"
      expr: oog_approved
      comment: "Whether the slot is approved for out-of-gauge cargo"
    - name: "customs_inspection_zone"
      expr: customs_inspection_zone
      comment: "Whether the slot is in a customs inspection zone"
    - name: "reservation_status"
      expr: reservation_status
      comment: "Reservation status of the slot"
    - name: "operational_zone"
      expr: operational_zone
      comment: "Operational zone classification"
    - name: "surface_type"
      expr: surface_type
      comment: "Surface type of the slot"
    - name: "equipment_access_type"
      expr: equipment_access_type
      comment: "Type of equipment that can access this slot"
  measures:
    - name: "total_yard_slots"
      expr: COUNT(1)
      comment: "Total number of yard slots"
    - name: "total_teu_capacity"
      expr: SUM(CAST(teu_capacity AS DOUBLE))
      comment: "Total TEU capacity across all yard slots - primary yard capacity metric"
    - name: "avg_teu_capacity_per_slot"
      expr: AVG(CAST(teu_capacity AS DOUBLE))
      comment: "Average TEU capacity per slot"
    - name: "avg_max_weight_capacity_kg"
      expr: AVG(CAST(max_weight_capacity_kg AS DOUBLE))
      comment: "Average maximum weight capacity in kilograms"
    - name: "avg_distance_to_gate_meters"
      expr: AVG(CAST(distance_to_gate_meters AS DOUBLE))
      comment: "Average distance to gate in meters - impacts truck turnaround time"
    - name: "avg_distance_to_quay_meters"
      expr: AVG(CAST(distance_to_quay_meters AS DOUBLE))
      comment: "Average distance to quay in meters - impacts vessel operation efficiency"
    - name: "avg_height_clearance_meters"
      expr: AVG(CAST(height_clearance_meters AS DOUBLE))
      comment: "Average height clearance in meters"
    - name: "avg_swl_rating_tonnes"
      expr: AVG(CAST(swl_rating_tonnes AS DOUBLE))
      comment: "Average safe working load rating in tonnes"
    - name: "slot_occupancy_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN occupied_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of slots currently occupied - key yard utilization and capacity planning metric"
    - name: "active_slot_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN active_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of slots that are active and available - measures operational capacity"
    - name: "reefer_capable_slot_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN reefer_plug_available = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of slots with reefer capability - critical for cold chain capacity planning"
    - name: "hazmat_approved_slot_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN hazmat_approved = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of slots approved for hazardous materials - safety and compliance capacity metric"
    - name: "oog_approved_slot_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN oog_approved = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of slots approved for out-of-gauge cargo - special handling capacity"
$$;

CREATE OR REPLACE VIEW `vibe_shipping_ports_v1`.`_metrics`.`terminal`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Terminal capacity and infrastructure metrics tracking operational capabilities, equipment inventory, and facility characteristics"
  source: "`vibe_shipping_ports_v1`.`terminal`.`terminal`"
  dimensions:
    - name: "operational_status"
      expr: operational_status
      comment: "Current operational status of the terminal"
    - name: "terminal_type"
      expr: terminal_type
      comment: "Type of terminal (e.g., container, bulk, multipurpose)"
    - name: "operator_name"
      expr: operator_name
      comment: "Name of the terminal operator"
    - name: "country_code"
      expr: country_code
      comment: "Country code of the terminal location"
    - name: "city"
      expr: city
      comment: "City where the terminal is located"
    - name: "isps_compliant"
      expr: isps_compliant
      comment: "Whether the terminal is ISPS compliant"
    - name: "iso_28000_certified"
      expr: iso_28000_certified
      comment: "Whether the terminal is ISO 28000 certified"
    - name: "dangerous_goods_certified"
      expr: dangerous_goods_certified
      comment: "Whether the terminal is certified for dangerous goods"
    - name: "customs_bonded_area"
      expr: customs_bonded_area
      comment: "Whether the terminal has customs bonded area"
    - name: "cfs_facility_available"
      expr: cfs_facility_available
      comment: "Whether container freight station facility is available"
    - name: "rfid_enabled"
      expr: rfid_enabled
      comment: "Whether RFID technology is enabled"
    - name: "tos_system"
      expr: tos_system
      comment: "Terminal Operating System in use"
  measures:
    - name: "total_terminals"
      expr: COUNT(1)
      comment: "Total number of terminals"
    - name: "total_storage_capacity_teu"
      expr: SUM(CAST(storage_capacity_teu AS DOUBLE))
      comment: "Total storage capacity in TEU across all terminals - primary capacity metric"
    - name: "avg_storage_capacity_teu"
      expr: AVG(CAST(storage_capacity_teu AS DOUBLE))
      comment: "Average storage capacity in TEU per terminal"
    - name: "total_annual_throughput_capacity_teu"
      expr: SUM(CAST(annual_throughput_capacity_teu AS DOUBLE))
      comment: "Total annual throughput capacity in TEU - key strategic capacity planning metric"
    - name: "avg_annual_throughput_capacity_teu"
      expr: AVG(CAST(annual_throughput_capacity_teu AS DOUBLE))
      comment: "Average annual throughput capacity in TEU per terminal"
    - name: "total_quay_length_m"
      expr: SUM(CAST(total_quay_length_m AS DOUBLE))
      comment: "Total quay length in meters - vessel berthing capacity metric"
    - name: "avg_quay_length_m"
      expr: AVG(CAST(total_quay_length_m AS DOUBLE))
      comment: "Average quay length in meters per terminal"
    - name: "total_area_sqm"
      expr: SUM(CAST(total_area_sqm AS DOUBLE))
      comment: "Total terminal area in square meters"
    - name: "avg_area_sqm"
      expr: AVG(CAST(total_area_sqm AS DOUBLE))
      comment: "Average terminal area in square meters"
    - name: "total_sts_cranes"
      expr: SUM(CAST(number_of_sts_cranes AS DOUBLE))
      comment: "Total number of ship-to-shore cranes - primary vessel handling capacity metric"
    - name: "total_rtg_cranes"
      expr: SUM(CAST(number_of_rtg_cranes AS DOUBLE))
      comment: "Total number of rubber-tyred gantry cranes - yard handling capacity"
    - name: "total_reach_stackers"
      expr: SUM(CAST(number_of_reach_stackers AS DOUBLE))
      comment: "Total number of reach stackers - mobile equipment capacity"
    - name: "total_reefer_plugs"
      expr: SUM(CAST(reefer_plugs_available AS DOUBLE))
      comment: "Total number of reefer plugs available - cold chain capacity metric"
    - name: "total_berths"
      expr: SUM(CAST(number_of_berths AS DOUBLE))
      comment: "Total number of berths - vessel capacity metric"
    - name: "avg_max_vessel_loa_m"
      expr: AVG(CAST(max_vessel_loa_m AS DOUBLE))
      comment: "Average maximum vessel length overall in meters - indicates vessel size capability"
    - name: "avg_max_vessel_draft_m"
      expr: AVG(CAST(max_vessel_draft_m AS DOUBLE))
      comment: "Average maximum vessel draft in meters - indicates depth capability"
    - name: "isps_compliance_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN isps_compliant = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of terminals that are ISPS compliant - security compliance metric"
    - name: "iso_28000_certification_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN iso_28000_certified = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of terminals with ISO 28000 certification - supply chain security metric"
    - name: "dangerous_goods_capability_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN dangerous_goods_certified = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of terminals certified for dangerous goods - hazmat handling capability"
    - name: "rfid_adoption_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN rfid_enabled = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of terminals with RFID technology - automation and tracking capability metric"
$$;