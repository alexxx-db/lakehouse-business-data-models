-- Metric views for domain: terminal | Business: Shipping_Ports | Version: 2 | Generated on: 2026-07-13 07:51:56

CREATE OR REPLACE VIEW `vibe_shipping_ports_v1`.`_metrics`.`terminal_container_visit`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core terminal throughput and dwell-time KPIs derived from container visit events. Drives decisions on yard capacity, gate throughput, demurrage revenue, and vessel productivity."
  source: "`vibe_shipping_ports_v1`.`terminal`.`container_visit`"
  dimensions:
    - name: "visit_status"
      expr: visit_status
      comment: "Current lifecycle status of the container visit (e.g., IN_YARD, DISCHARGED, DELIVERED) for operational segmentation."
    - name: "cargo_type"
      expr: cargo_type
      comment: "Cargo classification (DRY, REEFER, HAZMAT, OOG) enabling throughput analysis by cargo category."
    - name: "full_empty_indicator"
      expr: full_empty_indicator
      comment: "Distinguishes full (laden) from empty (MTY) container visits, critical for empty pool and depot planning."
    - name: "reefer_flag"
      expr: reefer_flag
      comment: "Identifies reefer containers requiring temperature-controlled storage and power plug allocation."
    - name: "oog_flag"
      expr: oog_flag
      comment: "Flags out-of-gauge containers requiring special stowage and handling resources."
    - name: "arrival_mode"
      expr: arrival_mode
      comment: "Mode by which the container arrived at the terminal (vessel, truck, rail) for modal split analysis."
    - name: "departure_mode"
      expr: departure_mode
      comment: "Mode by which the container departed the terminal for modal split and intermodal performance analysis."
    - name: "pod_code"
      expr: pod_code
      comment: "Port of Discharge code enabling throughput analysis by trade lane destination."
    - name: "pol_code"
      expr: pol_code
      comment: "Port of Loading code enabling throughput analysis by trade lane origin."
    - name: "imdg_class"
      expr: imdg_class
      comment: "IMDG dangerous goods class for hazmat volume tracking and segregation compliance monitoring."
    - name: "gate_in_date"
      expr: DATE_TRUNC('day', gate_in_timestamp)
      comment: "Day-level bucket of gate-in event for daily throughput trending."
    - name: "gate_in_month"
      expr: DATE_TRUNC('month', gate_in_timestamp)
      comment: "Month-level bucket of gate-in event for monthly throughput reporting."
    - name: "demurrage_start_date"
      expr: demurrage_start_date
      comment: "Date demurrage clock started, used to segment containers by demurrage exposure period."
  measures:
    - name: "total_container_visits"
      expr: COUNT(1)
      comment: "Total number of container visit events. Baseline throughput KPI used in all terminal productivity dashboards."
    - name: "total_teu_throughput"
      expr: SUM(CAST(teu_factor AS DOUBLE))
      comment: "Total TEU throughput across all container visits. Primary volume KPI for terminal capacity planning and commercial reporting."
    - name: "avg_dwell_time_hours"
      expr: AVG(CAST(dwell_time_hours AS DOUBLE))
      comment: "Average container dwell time in hours. Elevated dwell indicates yard congestion, demurrage risk, or customs delays — a key operational efficiency KPI."
    - name: "max_dwell_time_hours"
      expr: MAX(dwell_time_hours)
      comment: "Maximum container dwell time in hours. Identifies worst-case yard occupancy outliers driving congestion and demurrage exposure."
    - name: "total_vgm_weight_kg"
      expr: SUM(CAST(vgm_weight_kg AS DOUBLE))
      comment: "Total Verified Gross Mass (VGM) weight in kg across all container visits. Used for vessel stability planning and SOLAS VGM compliance reporting."
    - name: "avg_vgm_weight_kg"
      expr: AVG(CAST(vgm_weight_kg AS DOUBLE))
      comment: "Average VGM weight per container visit. Supports load planning benchmarks and weight distribution analysis."
    - name: "reefer_container_count"
      expr: COUNT(CASE WHEN reefer_flag = TRUE THEN 1 END)
      comment: "Count of reefer container visits requiring temperature-controlled storage. Drives reefer plug capacity planning and cold-chain SLA monitoring."
    - name: "oog_container_count"
      expr: COUNT(CASE WHEN oog_flag = TRUE THEN 1 END)
      comment: "Count of out-of-gauge container visits requiring special handling. Informs crane and yard resource allocation for oversized cargo."
    - name: "hazmat_container_count"
      expr: COUNT(CASE WHEN imdg_class IS NOT NULL AND imdg_class <> '' THEN 1 END)
      comment: "Count of dangerous goods container visits. Drives IMDG segregation compliance monitoring and hazmat yard zone utilization."
    - name: "demurrage_exposed_container_count"
      expr: COUNT(CASE WHEN demurrage_start_date IS NOT NULL THEN 1 END)
      comment: "Count of container visits where demurrage clock has started. Directly linked to demurrage revenue accrual and customer dispute risk."
    - name: "total_tare_weight_kg"
      expr: SUM(CAST(tare_weight_kg AS DOUBLE))
      comment: "Total tare weight of containers in the terminal. Used for gross weight reconciliation and vessel load planning."
    - name: "reefer_teu_throughput"
      expr: SUM(CAST(CASE WHEN reefer_flag = TRUE THEN teu_factor ELSE 0 END AS INT))
      comment: "TEU throughput attributable to reefer containers. Measures cold-chain volume share and informs reefer infrastructure investment decisions."
$$;

CREATE OR REPLACE VIEW `vibe_shipping_ports_v1`.`_metrics`.`terminal_berth_allocation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Berth productivity, utilization, and SLA compliance KPIs. Drives decisions on berth scheduling, crane allocation, and vessel turnaround performance."
  source: "`vibe_shipping_ports_v1`.`terminal`.`terminal_berth_allocation`"
  dimensions:
    - name: "allocation_status"
      expr: allocation_status
      comment: "Current status of the berth allocation (CONFIRMED, CANCELLED, IN_PROGRESS, COMPLETED) for pipeline and utilization analysis."
    - name: "cargo_operation_type"
      expr: cargo_operation_type
      comment: "Type of cargo operation (LOAD, DISCHARGE, BOTH) enabling productivity analysis by operation type."
    - name: "crane_allocation_type"
      expr: crane_allocation_type
      comment: "Crane allocation strategy (DEDICATED, SHARED, TANDEM) for crane productivity benchmarking."
    - name: "priority_level"
      expr: priority_level
      comment: "Berth allocation priority (HIGH, NORMAL, LOW) for SLA tier analysis and premium service tracking."
    - name: "imdg_cargo_flag"
      expr: imdg_cargo_flag
      comment: "Indicates whether the vessel call involves IMDG dangerous goods cargo, for hazmat berth utilization tracking."
    - name: "pilotage_required_flag"
      expr: pilotage_required_flag
      comment: "Flags allocations requiring pilotage, enabling marine services demand forecasting."
    - name: "towage_required_flag"
      expr: towage_required_flag
      comment: "Flags allocations requiring towage assistance, for tug fleet demand planning."
    - name: "weather_restriction_flag"
      expr: weather_restriction_flag
      comment: "Indicates weather-restricted berth windows, for operational risk and delay analysis."
    - name: "berth_window_start_month"
      expr: DATE_TRUNC('month', berth_window_start)
      comment: "Month-level bucket of berth window start for monthly berth utilization trending."
    - name: "atb_date"
      expr: DATE_TRUNC('day', atb)
      comment: "Actual Time of Berthing date for daily berth occupancy analysis."
  measures:
    - name: "total_berth_allocations"
      expr: COUNT(1)
      comment: "Total number of berth allocation events. Baseline KPI for berth demand and scheduling workload."
    - name: "avg_berth_window_duration_hours"
      expr: AVG(CAST(berth_window_duration_hours AS DOUBLE))
      comment: "Average planned berth window duration in hours. Benchmarks vessel turnaround planning efficiency."
    - name: "avg_sla_turnaround_time_hours"
      expr: AVG(CAST(sla_turnaround_time_hours AS DOUBLE))
      comment: "Average SLA-committed turnaround time in hours. Tracks contractual service level commitments to shipping lines."
    - name: "avg_berth_productivity_target_mph"
      expr: AVG(CAST(berth_productivity_target_mph AS DOUBLE))
      comment: "Average targeted moves-per-hour (MPH) productivity at berth. Key crane and gang performance benchmark."
    - name: "total_allocated_quay_length_m"
      expr: SUM(CAST(allocated_quay_length_m AS DOUBLE))
      comment: "Total quay length allocated across all berth allocations. Measures quay utilization intensity."
    - name: "avg_vessel_draft_m"
      expr: AVG(CAST(vessel_draft_m AS DOUBLE))
      comment: "Average vessel draft at berth. Monitors channel and berth depth utilization relative to infrastructure limits."
    - name: "avg_vessel_loa_m"
      expr: AVG(CAST(vessel_loa_m AS DOUBLE))
      comment: "Average vessel length overall (LOA) at berth. Informs berth length sufficiency and infrastructure planning."
    - name: "cancelled_allocation_count"
      expr: COUNT(CASE WHEN allocation_status = 'CANCELLED' THEN 1 END)
      comment: "Count of cancelled berth allocations. High cancellation rates signal scheduling inefficiency or commercial instability."
    - name: "total_berth_draft_restriction_m"
      expr: AVG(CAST(berth_draft_restriction_m AS DOUBLE))
      comment: "Average berth draft restriction in meters across allocations. Tracks infrastructure constraint exposure for vessel acceptance decisions."
    - name: "imdg_allocation_count"
      expr: COUNT(CASE WHEN imdg_cargo_flag = TRUE THEN 1 END)
      comment: "Count of berth allocations involving IMDG dangerous goods. Drives hazmat berth zone planning and ISPS compliance monitoring."
$$;

CREATE OR REPLACE VIEW `vibe_shipping_ports_v1`.`_metrics`.`terminal_equipment_dispatch`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Terminal equipment productivity and crane performance KPIs. Drives decisions on crane gang allocation, equipment utilization, and operational efficiency."
  source: "`vibe_shipping_ports_v1`.`terminal`.`equipment_dispatch`"
  dimensions:
    - name: "dispatch_status"
      expr: dispatch_status
      comment: "Current status of the equipment dispatch (COMPLETED, IN_PROGRESS, CANCELLED) for productivity pipeline analysis."
    - name: "equipment_type"
      expr: equipment_type
      comment: "Type of terminal equipment dispatched (STS_CRANE, RTG, REACH_STACKER, etc.) for equipment-class productivity benchmarking."
    - name: "dispatch_source"
      expr: dispatch_source
      comment: "Source system or instruction origin of the dispatch (TOS, MANUAL, BAPLIE) for automation effectiveness analysis."
    - name: "productive_flag"
      expr: productive_flag
      comment: "Distinguishes productive moves (cargo-handling) from non-productive moves (rehandles, repositioning) for efficiency analysis."
    - name: "rehandle_flag"
      expr: rehandle_flag
      comment: "Flags rehandle moves where a container was moved to access another. Rehandle rate is a key yard planning KPI."
    - name: "tandem_lift_flag"
      expr: tandem_lift_flag
      comment: "Flags tandem lift operations (two containers lifted simultaneously) for crane productivity premium analysis."
    - name: "twin_lift_flag"
      expr: twin_lift_flag
      comment: "Flags twin lift operations for crane productivity analysis."
    - name: "hazmat_flag"
      expr: hazmat_flag
      comment: "Flags dispatches involving hazardous materials for IMDG compliance and special handling cost tracking."
    - name: "reefer_flag"
      expr: reefer_flag
      comment: "Flags reefer container dispatches for cold-chain handling volume analysis."
    - name: "dispatch_date"
      expr: DATE_TRUNC('day', dispatch_timestamp)
      comment: "Day-level bucket of dispatch event for daily productivity trending."
    - name: "dispatch_month"
      expr: DATE_TRUNC('month', dispatch_timestamp)
      comment: "Month-level bucket of dispatch event for monthly equipment utilization reporting."
    - name: "imdg_class"
      expr: imdg_class
      comment: "IMDG class of cargo handled in the dispatch for dangerous goods volume tracking."
  measures:
    - name: "total_dispatch_moves"
      expr: COUNT(1)
      comment: "Total number of equipment dispatch moves. Primary terminal productivity volume KPI."
    - name: "avg_moves_per_hour"
      expr: AVG(CAST(moves_per_hour AS DOUBLE))
      comment: "Average crane/equipment moves per hour (MPH). The single most important terminal productivity KPI used in shipping line SLA negotiations."
    - name: "max_moves_per_hour"
      expr: MAX(moves_per_hour)
      comment: "Peak moves-per-hour achieved. Benchmarks best-case equipment performance for capacity planning."
    - name: "rehandle_move_count"
      expr: COUNT(CASE WHEN rehandle_flag = TRUE THEN 1 END)
      comment: "Count of rehandle moves. Rehandles are non-revenue moves that reduce crane productivity — a key yard planning quality metric."
    - name: "productive_move_count"
      expr: COUNT(CASE WHEN productive_flag = TRUE THEN 1 END)
      comment: "Count of productive (revenue-generating) moves. Used to compute productive move ratio and crane efficiency."
    - name: "tandem_lift_move_count"
      expr: COUNT(CASE WHEN tandem_lift_flag = TRUE THEN 1 END)
      comment: "Count of tandem lift moves. Tandem lifts double crane throughput — tracking adoption drives productivity improvement programs."
    - name: "avg_reefer_temperature_celsius"
      expr: AVG(CAST(reefer_temperature_celsius AS DOUBLE))
      comment: "Average reefer temperature recorded during dispatch. Monitors cold-chain integrity during equipment handling operations."
    - name: "hazmat_dispatch_count"
      expr: COUNT(CASE WHEN hazmat_flag = TRUE THEN 1 END)
      comment: "Count of dispatches involving hazardous materials. Drives IMDG compliance reporting and special handling resource planning."
$$;

CREATE OR REPLACE VIEW `vibe_shipping_ports_v1`.`_metrics`.`terminal_gate_transaction`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Gate throughput, processing efficiency, and compliance KPIs. Drives decisions on gate lane capacity, automation investment, and truck appointment system effectiveness."
  source: "`vibe_shipping_ports_v1`.`terminal`.`gate_transaction`"
  dimensions:
    - name: "transaction_type"
      expr: transaction_type
      comment: "Gate transaction type (GATE_IN, GATE_OUT, INTERCHANGE) for directional throughput analysis."
    - name: "transaction_status"
      expr: transaction_status
      comment: "Outcome status of the gate transaction (COMPLETED, REJECTED, ON_HOLD) for exception rate monitoring."
    - name: "damage_flag"
      expr: damage_flag
      comment: "Flags transactions where container damage was detected at gate. Drives EIR quality and liability apportionment analysis."
    - name: "gate_clerk_override_flag"
      expr: gate_clerk_override_flag
      comment: "Flags transactions requiring manual clerk override of automated gate systems. High override rates indicate automation quality issues."
    - name: "seal_verification_status"
      expr: seal_verification_status
      comment: "Seal verification outcome (INTACT, BROKEN, MISSING) for cargo security and customs compliance monitoring."
    - name: "imdg_class"
      expr: imdg_class
      comment: "IMDG class of cargo at gate for dangerous goods gate processing volume analysis."
    - name: "transaction_date"
      expr: DATE_TRUNC('day', transaction_timestamp)
      comment: "Day-level bucket of gate transaction for daily gate throughput trending."
    - name: "transaction_month"
      expr: DATE_TRUNC('month', transaction_timestamp)
      comment: "Month-level bucket of gate transaction for monthly gate capacity planning."
  measures:
    - name: "total_gate_transactions"
      expr: COUNT(1)
      comment: "Total gate transactions processed. Primary gate throughput KPI for capacity planning and staffing decisions."
    - name: "avg_processing_duration_seconds"
      expr: AVG(CAST(processing_duration_seconds AS DOUBLE))
      comment: "Average gate processing time in seconds. Key gate efficiency KPI — elevated processing times indicate bottlenecks requiring automation or staffing intervention."
    - name: "avg_vgm_weight_kg"
      expr: AVG(CAST(verified_gross_mass_kg AS DOUBLE))
      comment: "Average Verified Gross Mass (VGM) at gate in kg. Monitors SOLAS VGM compliance and weight declaration accuracy."
    - name: "avg_weight_bridge_reading_kg"
      expr: AVG(CAST(weight_bridge_reading_kg AS DOUBLE))
      comment: "Average weighbridge reading at gate in kg. Used to validate VGM declarations and detect weight discrepancies."
    - name: "damage_detected_count"
      expr: COUNT(CASE WHEN damage_flag = TRUE THEN 1 END)
      comment: "Count of gate transactions where container damage was detected. Drives EIR dispute management and liability apportionment decisions."
    - name: "clerk_override_count"
      expr: COUNT(CASE WHEN gate_clerk_override_flag = TRUE THEN 1 END)
      comment: "Count of manual clerk overrides at gate. High override rates signal automation failures or exception-heavy cargo types requiring process review."
    - name: "seal_breach_count"
      expr: COUNT(CASE WHEN seal_verification_status IN ('BROKEN', 'MISSING') THEN 1 END)
      comment: "Count of gate transactions with broken or missing seals. Critical cargo security and customs compliance KPI."
    - name: "total_vgm_weight_kg"
      expr: SUM(CAST(verified_gross_mass_kg AS DOUBLE))
      comment: "Total VGM weight processed at gate in kg. Aggregate weight throughput for port infrastructure load planning."
$$;

CREATE OR REPLACE VIEW `vibe_shipping_ports_v1`.`_metrics`.`terminal_reefer_monitoring`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Cold-chain integrity and reefer equipment performance KPIs. Drives decisions on reefer plug capacity, SLA compliance, and cold-chain incident response."
  source: "`vibe_shipping_ports_v1`.`terminal`.`reefer_monitoring`"
  dimensions:
    - name: "monitoring_status"
      expr: monitoring_status
      comment: "Current monitoring status of the reefer unit (ACTIVE, ALARM, OFFLINE) for real-time cold-chain oversight."
    - name: "alarm_flag"
      expr: alarm_flag
      comment: "Flags reefer monitoring records with active alarms. Drives cold-chain SLA breach investigation."
    - name: "alarm_severity"
      expr: alarm_severity
      comment: "Severity level of reefer alarm (CRITICAL, WARNING, INFO) for prioritized intervention decisions."
    - name: "alarm_type"
      expr: alarm_type
      comment: "Type of reefer alarm (TEMPERATURE_DEVIATION, POWER_FAILURE, COMPRESSOR_FAULT) for root cause analysis."
    - name: "cold_chain_compliance_flag"
      expr: cold_chain_compliance_flag
      comment: "Indicates whether the reefer unit maintained cold-chain compliance throughout monitoring. Key SLA and cargo liability KPI."
    - name: "sla_breach_flag"
      expr: sla_breach_flag
      comment: "Flags monitoring records where SLA temperature thresholds were breached. Directly linked to cargo claims and customer compensation."
    - name: "power_status"
      expr: power_status
      comment: "Power supply status of the reefer unit (ON, OFF, FAULT) for infrastructure reliability analysis."
    - name: "cargo_type"
      expr: cargo_type
      comment: "Type of cargo in the reefer container (FROZEN, CHILLED, CONTROLLED_ATMOSPHERE) for cold-chain segment analysis."
    - name: "monitoring_date"
      expr: DATE_TRUNC('day', monitoring_timestamp)
      comment: "Day-level bucket of monitoring event for daily cold-chain compliance trending."
    - name: "monitoring_source"
      expr: monitoring_source
      comment: "Source of monitoring data (AUTOMATED_SENSOR, MANUAL_INSPECTION, TELEMATICS) for data quality and coverage analysis."
  measures:
    - name: "total_monitoring_events"
      expr: COUNT(1)
      comment: "Total reefer monitoring events. Baseline KPI for cold-chain monitoring coverage and frequency."
    - name: "avg_actual_temperature"
      expr: AVG(CAST(actual_temperature AS DOUBLE))
      comment: "Average actual reefer temperature recorded. Core cold-chain integrity KPI — deviations from set-point indicate cargo risk."
    - name: "avg_temperature_deviation"
      expr: AVG(CAST(temperature_deviation AS DOUBLE))
      comment: "Average temperature deviation from set-point. Measures cold-chain precision — high deviation drives cargo claims and SLA penalties."
    - name: "max_temperature_deviation"
      expr: MAX(temperature_deviation)
      comment: "Maximum temperature deviation recorded. Identifies worst-case cold-chain excursions for cargo liability assessment."
    - name: "alarm_event_count"
      expr: COUNT(CASE WHEN alarm_flag = TRUE THEN 1 END)
      comment: "Count of reefer monitoring events with active alarms. Drives cold-chain incident response prioritization."
    - name: "sla_breach_count"
      expr: COUNT(CASE WHEN sla_breach_flag = TRUE THEN 1 END)
      comment: "Count of SLA temperature breaches. Directly linked to cargo claims, customer compensation, and cold-chain SLA performance reporting."
    - name: "avg_humidity_reading"
      expr: AVG(CAST(humidity_reading AS DOUBLE))
      comment: "Average humidity level recorded in reefer containers. Critical for controlled-atmosphere cargo (fresh produce, pharmaceuticals)."
    - name: "avg_compressor_runtime_hours"
      expr: AVG(CAST(compressor_runtime_hours AS DOUBLE))
      comment: "Average compressor runtime hours. Monitors reefer equipment wear and informs preventive maintenance scheduling."
    - name: "avg_power_supply_voltage"
      expr: AVG(CAST(power_supply_voltage AS DOUBLE))
      comment: "Average power supply voltage to reefer units. Voltage anomalies indicate infrastructure issues that risk cold-chain integrity."
    - name: "non_compliant_reefer_count"
      expr: COUNT(CASE WHEN cold_chain_compliance_flag = FALSE THEN 1 END)
      comment: "Count of reefer monitoring records indicating cold-chain non-compliance. Drives cargo claims risk quantification and SLA penalty exposure."
$$;

CREATE OR REPLACE VIEW `vibe_shipping_ports_v1`.`_metrics`.`terminal_gate_appointment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Gate appointment utilization, no-show rates, and truck appointment system effectiveness KPIs. Drives decisions on appointment window sizing, gate capacity, and haulier performance management."
  source: "`vibe_shipping_ports_v1`.`terminal`.`gate_appointment`"
  dimensions:
    - name: "appointment_status"
      expr: appointment_status
      comment: "Status of the gate appointment (BOOKED, COMPLETED, CANCELLED, NO_SHOW) for utilization and no-show analysis."
    - name: "transaction_type"
      expr: transaction_type
      comment: "Type of gate transaction associated with the appointment (GATE_IN, GATE_OUT) for directional demand analysis."
    - name: "no_show_flag"
      expr: no_show_flag
      comment: "Flags appointments where the truck did not arrive. No-show rate is a key appointment system effectiveness KPI."
    - name: "inspection_required"
      expr: inspection_required
      comment: "Flags appointments requiring physical inspection, for inspection resource planning."
    - name: "is_hazardous_cargo"
      expr: is_hazardous_cargo
      comment: "Flags appointments involving hazardous cargo for IMDG gate processing volume analysis."
    - name: "is_overweight"
      expr: is_overweight
      comment: "Flags overweight truck appointments for weighbridge and compliance resource planning."
    - name: "appointment_date"
      expr: appointment_date
      comment: "Scheduled appointment date for daily gate demand planning and slot utilization analysis."
    - name: "appointment_month"
      expr: DATE_TRUNC('month', appointment_window_start)
      comment: "Month-level bucket of appointment window for monthly gate capacity trending."
    - name: "imdg_class"
      expr: imdg_class
      comment: "IMDG class of cargo in the appointment for dangerous goods gate slot demand analysis."
  measures:
    - name: "total_appointments"
      expr: COUNT(1)
      comment: "Total gate appointments booked. Baseline KPI for gate demand forecasting and slot capacity planning."
    - name: "no_show_count"
      expr: COUNT(CASE WHEN no_show_flag = TRUE THEN 1 END)
      comment: "Count of no-show appointments. High no-show rates waste gate capacity and indicate haulier reliability issues requiring commercial intervention."
    - name: "completed_appointment_count"
      expr: COUNT(CASE WHEN appointment_status = 'COMPLETED' THEN 1 END)
      comment: "Count of successfully completed gate appointments. Measures appointment system conversion effectiveness."
    - name: "avg_processing_duration_minutes"
      expr: AVG(CAST(processing_duration_minutes AS DOUBLE))
      comment: "Average gate processing duration in minutes per appointment. Key gate efficiency KPI for staffing and automation investment decisions."
    - name: "avg_vgm_weight_kg"
      expr: AVG(CAST(verified_gross_mass_kg AS DOUBLE))
      comment: "Average Verified Gross Mass declared at appointment. Monitors SOLAS VGM pre-declaration compliance."
    - name: "hazardous_appointment_count"
      expr: COUNT(CASE WHEN is_hazardous_cargo = TRUE THEN 1 END)
      comment: "Count of gate appointments involving hazardous cargo. Drives IMDG gate lane allocation and inspection resource planning."
    - name: "overweight_appointment_count"
      expr: COUNT(CASE WHEN is_overweight = TRUE THEN 1 END)
      comment: "Count of overweight truck appointments. Drives weighbridge capacity planning and road transport compliance enforcement."
    - name: "inspection_required_count"
      expr: COUNT(CASE WHEN inspection_required = TRUE THEN 1 END)
      comment: "Count of appointments requiring physical inspection. Drives inspection bay staffing and customs liaison resource planning."
$$;

CREATE OR REPLACE VIEW `vibe_shipping_ports_v1`.`_metrics`.`terminal_container_damage`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Container damage incidence, repair cost, and liability KPIs. Drives decisions on equipment maintenance, handling procedures, and damage claim management."
  source: "`vibe_shipping_ports_v1`.`terminal`.`container_damage`"
  dimensions:
    - name: "damage_type"
      expr: damage_type
      comment: "Classification of damage type (STRUCTURAL, SURFACE, MECHANICAL) for root cause and prevention analysis."
    - name: "damage_severity"
      expr: damage_severity
      comment: "Severity of container damage (MINOR, MODERATE, SEVERE) for prioritized repair and claims triage."
    - name: "damage_report_status"
      expr: damage_report_status
      comment: "Current status of the damage report (OPEN, UNDER_REVIEW, CLOSED) for claims pipeline management."
    - name: "liability_party"
      expr: liability_party
      comment: "Party held liable for the damage (TERMINAL, SHIPPING_LINE, HAULIER) for cost recovery and insurance analysis."
    - name: "discovery_point"
      expr: discovery_point
      comment: "Point in the terminal process where damage was discovered (GATE_IN, YARD, VESSEL_DISCHARGE) for process quality analysis."
    - name: "safety_incident_flag"
      expr: safety_incident_flag
      comment: "Flags damage events linked to a safety incident for HSE correlation analysis."
    - name: "environmental_incident_flag"
      expr: environmental_incident_flag
      comment: "Flags damage events with environmental impact for MARPOL and environmental compliance reporting."
    - name: "cargo_damage_indicator"
      expr: cargo_damage_indicator
      comment: "Indicates whether cargo inside the container was also damaged, for cargo claims liability quantification."
    - name: "discovery_date"
      expr: DATE_TRUNC('day', discovery_timestamp)
      comment: "Day-level bucket of damage discovery for daily damage incidence trending."
    - name: "imdg_class"
      expr: imdg_class
      comment: "IMDG class of damaged container for dangerous goods damage risk analysis."
  measures:
    - name: "total_damage_reports"
      expr: COUNT(1)
      comment: "Total container damage reports. Baseline KPI for terminal damage incidence rate and quality management."
    - name: "total_actual_repair_cost"
      expr: SUM(CAST(actual_repair_cost AS DOUBLE))
      comment: "Total actual repair cost across all damage events. Direct financial impact KPI for terminal P&L and insurance premium management."
    - name: "avg_actual_repair_cost"
      expr: AVG(CAST(actual_repair_cost AS DOUBLE))
      comment: "Average actual repair cost per damage event. Benchmarks repair cost efficiency and informs repair vs. write-off decisions."
    - name: "total_estimated_repair_cost"
      expr: SUM(CAST(estimated_repair_cost AS DOUBLE))
      comment: "Total estimated repair cost for open damage reports. Drives financial provisioning for outstanding damage claims."
    - name: "cargo_damage_count"
      expr: COUNT(CASE WHEN cargo_damage_indicator = TRUE THEN 1 END)
      comment: "Count of damage events where cargo was also affected. Drives cargo claims liability exposure quantification."
    - name: "safety_linked_damage_count"
      expr: COUNT(CASE WHEN safety_incident_flag = TRUE THEN 1 END)
      comment: "Count of damage events linked to safety incidents. Drives HSE investigation prioritization and equipment safety review."
    - name: "environmental_damage_count"
      expr: COUNT(CASE WHEN environmental_incident_flag = TRUE THEN 1 END)
      comment: "Count of damage events with environmental impact. Critical for MARPOL compliance reporting and environmental liability management."
    - name: "repair_cost_variance"
      expr: SUM(CAST(actual_repair_cost AS DOUBLE) - CAST(estimated_repair_cost AS DOUBLE))
      comment: "Total variance between actual and estimated repair costs. Measures repair cost estimation accuracy and budget control effectiveness."
$$;

CREATE OR REPLACE VIEW `vibe_shipping_ports_v1`.`_metrics`.`terminal_hazmat_declaration`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Dangerous goods declaration compliance, acceptance, and segregation KPIs. Drives decisions on IMDG compliance, hazmat yard zone planning, and DG acceptance policy."
  source: "`vibe_shipping_ports_v1`.`terminal`.`hazmat_declaration`"
  dimensions:
    - name: "terminal_acceptance_status"
      expr: terminal_acceptance_status
      comment: "Terminal acceptance decision for the hazmat declaration (ACCEPTED, REJECTED, PENDING) for DG compliance pipeline analysis."
    - name: "imdg_class"
      expr: imdg_class
      comment: "IMDG dangerous goods class for volume analysis by hazard category and segregation planning."
    - name: "packing_group"
      expr: packing_group
      comment: "IMDG packing group (I, II, III) indicating hazard severity for risk-weighted DG volume analysis."
    - name: "marine_pollutant_flag"
      expr: marine_pollutant_flag
      comment: "Flags marine pollutant cargo for MARPOL compliance tracking and environmental risk monitoring."
    - name: "inspection_required_flag"
      expr: inspection_required_flag
      comment: "Flags declarations requiring physical inspection for inspection resource planning."
    - name: "limited_quantity_flag"
      expr: limited_quantity_flag
      comment: "Flags limited quantity DG shipments for simplified compliance tracking."
    - name: "excepted_quantity_flag"
      expr: excepted_quantity_flag
      comment: "Flags excepted quantity DG shipments for regulatory exemption tracking."
    - name: "placarding_required_flag"
      expr: placarding_required_flag
      comment: "Flags declarations requiring IMDG placarding for yard and vessel stowage compliance."
    - name: "declaration_month"
      expr: DATE_TRUNC('month', created_timestamp)
      comment: "Month-level bucket of declaration creation for monthly DG volume trending."
  measures:
    - name: "total_hazmat_declarations"
      expr: COUNT(1)
      comment: "Total hazmat declarations processed. Baseline KPI for DG cargo volume and IMDG compliance workload."
    - name: "total_gross_weight_kg"
      expr: SUM(CAST(gross_weight_kg AS DOUBLE))
      comment: "Total gross weight of dangerous goods declared in kg. Drives hazmat yard zone capacity planning and vessel stability calculations."
    - name: "avg_gross_weight_kg"
      expr: AVG(CAST(gross_weight_kg AS DOUBLE))
      comment: "Average gross weight per hazmat declaration. Benchmarks DG shipment size for handling resource planning."
    - name: "total_net_quantity"
      expr: SUM(CAST(net_quantity AS DOUBLE))
      comment: "Total net quantity of dangerous goods declared. Regulatory reporting metric for competent authority notifications."
    - name: "rejected_declaration_count"
      expr: COUNT(CASE WHEN terminal_acceptance_status = 'REJECTED' THEN 1 END)
      comment: "Count of rejected hazmat declarations. High rejection rates indicate shipper DGD quality issues or terminal policy tightening."
    - name: "marine_pollutant_count"
      expr: COUNT(CASE WHEN marine_pollutant_flag = TRUE THEN 1 END)
      comment: "Count of marine pollutant declarations. Critical MARPOL compliance KPI for environmental risk management."
    - name: "avg_segregation_distance_meters"
      expr: AVG(CAST(segregation_distance_meters AS DOUBLE))
      comment: "Average required segregation distance in meters for DG cargo. Monitors IMDG segregation compliance in yard planning."
    - name: "avg_flashpoint_celsius"
      expr: AVG(CAST(flashpoint_celsius AS DOUBLE))
      comment: "Average flashpoint temperature of flammable DG cargo. Drives fire risk assessment and hazmat yard zone temperature management."
    - name: "inspection_required_count"
      expr: COUNT(CASE WHEN inspection_required_flag = TRUE THEN 1 END)
      comment: "Count of hazmat declarations requiring physical inspection. Drives DG inspection team staffing and scheduling."
$$;

CREATE OR REPLACE VIEW `vibe_shipping_ports_v1`.`_metrics`.`terminal_service_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Terminal service order fulfillment, SLA compliance, and revenue KPIs. Drives decisions on service capacity, SLA performance, and ancillary revenue management."
  source: "`vibe_shipping_ports_v1`.`terminal`.`terminal_service_order`"
  dimensions:
    - name: "service_status"
      expr: service_status
      comment: "Current status of the service order (REQUESTED, IN_PROGRESS, COMPLETED, CANCELLED) for fulfillment pipeline analysis."
    - name: "service_location_type"
      expr: service_location_type
      comment: "Location type where service is performed (YARD, BERTH, GATE, CFS) for resource allocation by zone."
    - name: "priority_level"
      expr: priority_level
      comment: "Service order priority (HIGH, NORMAL, LOW) for SLA tier analysis and premium service tracking."
    - name: "sla_compliance_flag"
      expr: sla_compliance_flag
      comment: "Indicates whether the service order was completed within SLA target. Key service quality KPI."
    - name: "approval_required"
      expr: approval_required
      comment: "Flags service orders requiring management approval for workflow efficiency analysis."
    - name: "quality_check_performed"
      expr: quality_check_performed
      comment: "Flags service orders where a quality check was performed for quality assurance coverage analysis."
    - name: "charge_currency"
      expr: charge_currency
      comment: "Currency of the service charge for multi-currency revenue analysis."
    - name: "requested_month"
      expr: DATE_TRUNC('month', requested_timestamp)
      comment: "Month-level bucket of service request for monthly service demand trending."
  measures:
    - name: "total_service_orders"
      expr: COUNT(1)
      comment: "Total terminal service orders. Baseline KPI for ancillary service demand and operational workload."
    - name: "total_charge_amount"
      expr: SUM(CAST(charge_amount AS DOUBLE))
      comment: "Total revenue from terminal service orders. Ancillary revenue KPI for commercial performance reporting."
    - name: "avg_charge_amount"
      expr: AVG(CAST(charge_amount AS DOUBLE))
      comment: "Average charge per service order. Benchmarks ancillary service pricing and revenue yield per transaction."
    - name: "sla_compliant_count"
      expr: COUNT(CASE WHEN sla_compliance_flag = TRUE THEN 1 END)
      comment: "Count of service orders completed within SLA. Drives SLA performance reporting and service quality management."
    - name: "sla_breached_count"
      expr: COUNT(CASE WHEN sla_compliance_flag = FALSE THEN 1 END)
      comment: "Count of service orders that breached SLA targets. Directly linked to penalty exposure and customer satisfaction risk."
    - name: "avg_sla_target_hours"
      expr: AVG(CAST(sla_target_hours AS DOUBLE))
      comment: "Average SLA target hours across service orders. Benchmarks service commitment levels by order type and priority."
    - name: "cancelled_service_order_count"
      expr: COUNT(CASE WHEN service_status = 'CANCELLED' THEN 1 END)
      comment: "Count of cancelled service orders. High cancellation rates indicate demand forecasting issues or service availability problems."
    - name: "quality_checked_count"
      expr: COUNT(CASE WHEN quality_check_performed = TRUE THEN 1 END)
      comment: "Count of service orders with quality checks performed. Measures quality assurance coverage rate for service delivery."
$$;

CREATE OR REPLACE VIEW `vibe_shipping_ports_v1`.`_metrics`.`terminal_vessel_bay_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Vessel bay plan (BAPLIE) productivity, stowage quality, and cargo composition KPIs. Drives decisions on load planning efficiency, crane sequencing, and vessel stability."
  source: "`vibe_shipping_ports_v1`.`terminal`.`vessel_bay_plan`"
  dimensions:
    - name: "plan_status"
      expr: plan_status
      comment: "Current status of the bay plan (DRAFT, APPROVED, EXECUTED) for load planning pipeline analysis."
    - name: "oog_flag"
      expr: oog_flag
      comment: "Flags bay plan positions with out-of-gauge cargo for special stowage and crane planning."
    - name: "reefer_flag"
      expr: reefer_flag
      comment: "Flags bay plan positions with reefer cargo for reefer slot allocation and power planning."
    - name: "restow_flag"
      expr: restow_flag
      comment: "Flags bay plan positions requiring restow moves. Restow rate is a key stowage planning quality KPI."
    - name: "pre_marshalling_required"
      expr: pre_marshalling_required
      comment: "Flags bay plans requiring pre-marshalling of containers before vessel operations, indicating yard planning complexity."
    - name: "transhipment_flag"
      expr: transhipment_flag
      comment: "Flags transhipment (T/S) cargo in the bay plan. T/S volume is a primary hub port performance KPI."
    - name: "imdg_class"
      expr: imdg_class
      comment: "IMDG class of cargo in the bay plan position for dangerous goods stowage compliance analysis."
    - name: "pod_code"
      expr: pod_code
      comment: "Port of Discharge for bay plan positions enabling trade lane volume analysis."
    - name: "pol_code"
      expr: pol_code
      comment: "Port of Loading for bay plan positions enabling trade lane volume analysis."
    - name: "plan_created_month"
      expr: DATE_TRUNC('month', plan_created_timestamp)
      comment: "Month-level bucket of bay plan creation for monthly load planning volume trending."
  measures:
    - name: "total_bay_plan_positions"
      expr: COUNT(1)
      comment: "Total bay plan position records. Baseline KPI for vessel stowage planning workload and BAPLIE message volume."
    - name: "total_teu_planned"
      expr: SUM(CAST(teu_count AS DOUBLE))
      comment: "Total TEU count planned across all bay plan positions. Primary vessel capacity utilization KPI for load planning."
    - name: "avg_teu_per_plan"
      expr: AVG(CAST(teu_count AS DOUBLE))
      comment: "Average TEU count per bay plan position. Benchmarks stowage density and vessel fill rate."
    - name: "transhipment_teu_count"
      expr: SUM(CAST(CASE WHEN transhipment_flag = TRUE THEN teu_count ELSE 0 END AS INT))
      comment: "Total TEU planned for transhipment cargo. T/S volume is the primary hub port commercial KPI — drives feeder service planning and relay decisions."
    - name: "restow_position_count"
      expr: COUNT(CASE WHEN restow_flag = TRUE THEN 1 END)
      comment: "Count of bay plan positions requiring restow moves. High restow counts indicate stowage planning quality issues increasing vessel operation costs."
    - name: "oog_position_count"
      expr: COUNT(CASE WHEN oog_flag = TRUE THEN 1 END)
      comment: "Count of out-of-gauge cargo positions in bay plans. Drives crane and hatch planning for oversized cargo operations."
    - name: "reefer_position_count"
      expr: COUNT(CASE WHEN reefer_flag = TRUE THEN 1 END)
      comment: "Count of reefer cargo positions in bay plans. Drives reefer slot allocation and vessel power supply planning."
    - name: "pre_marshalling_plan_count"
      expr: COUNT(CASE WHEN pre_marshalling_required = TRUE THEN 1 END)
      comment: "Count of bay plans requiring pre-marshalling. Drives yard pre-marshalling resource planning and crane sequence optimization."
    - name: "avg_oog_overheight_cm"
      expr: AVG(CAST(oog_overheight_cm AS DOUBLE))
      comment: "Average OOG overheight in cm for out-of-gauge cargo. Informs hatch cover and crane boom clearance planning."
$$;

CREATE OR REPLACE VIEW `vibe_shipping_ports_v1`.`_metrics`.`terminal_yard_slot`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Yard slot utilization, capacity, and availability KPIs. Drives decisions on yard layout optimization, reefer plug investment, and hazmat zone planning."
  source: "`vibe_shipping_ports_v1`.`terminal`.`yard_slot`"
  dimensions:
    - name: "slot_status"
      expr: slot_status
      comment: "Current operational status of the yard slot (AVAILABLE, OCCUPIED, RESERVED, MAINTENANCE) for real-time yard capacity analysis."
    - name: "slot_type"
      expr: slot_type
      comment: "Type of yard slot (STANDARD, REEFER, HAZMAT, OOG) for capacity analysis by cargo category."
    - name: "occupied_flag"
      expr: occupied_flag
      comment: "Indicates whether the slot is currently occupied. Primary yard utilization flag."
    - name: "reefer_plug_available"
      expr: reefer_plug_available
      comment: "Indicates reefer plug availability in the slot for cold-chain capacity planning."
    - name: "hazmat_approved"
      expr: hazmat_approved
      comment: "Indicates whether the slot is approved for hazardous materials storage for IMDG yard zone compliance."
    - name: "oog_approved"
      expr: oog_approved
      comment: "Indicates whether the slot is approved for out-of-gauge cargo for special cargo capacity planning."
    - name: "operational_zone"
      expr: operational_zone
      comment: "Operational zone of the yard slot (IMPORT, EXPORT, TRANSHIPMENT, EMPTY) for zone-level utilization analysis."
    - name: "reservation_status"
      expr: reservation_status
      comment: "Reservation status of the slot (FREE, RESERVED, CONFIRMED) for advance capacity planning."
    - name: "active_flag"
      expr: active_flag
      comment: "Indicates whether the slot is active and available for use, for effective capacity calculation."
  measures:
    - name: "total_yard_slots"
      expr: COUNT(1)
      comment: "Total number of yard slots. Baseline KPI for total yard capacity inventory."
    - name: "occupied_slot_count"
      expr: COUNT(CASE WHEN occupied_flag = TRUE THEN 1 END)
      comment: "Count of currently occupied yard slots. Primary yard utilization KPI for congestion management and capacity planning."
    - name: "available_slot_count"
      expr: COUNT(CASE WHEN occupied_flag = FALSE AND active_flag = TRUE THEN 1 END)
      comment: "Count of available active yard slots. Drives real-time yard capacity management and vessel acceptance decisions."
    - name: "reefer_plug_slot_count"
      expr: COUNT(CASE WHEN reefer_plug_available = TRUE THEN 1 END)
      comment: "Count of yard slots with reefer plug availability. Drives reefer capacity planning and infrastructure investment decisions."
    - name: "hazmat_approved_slot_count"
      expr: COUNT(CASE WHEN hazmat_approved = TRUE THEN 1 END)
      comment: "Count of hazmat-approved yard slots. Drives IMDG yard zone capacity planning and DG acceptance policy."
    - name: "total_teu_capacity"
      expr: SUM(CAST(teu_capacity AS DOUBLE))
      comment: "Total TEU capacity across all yard slots. Measures total yard storage capacity for throughput planning."
    - name: "avg_distance_to_quay_meters"
      expr: AVG(CAST(distance_to_quay_meters AS DOUBLE))
      comment: "Average distance from yard slot to quay in meters. Drives horizontal transport time estimation and crane productivity modeling."
    - name: "avg_max_weight_capacity_kg"
      expr: AVG(CAST(max_weight_capacity_kg AS DOUBLE))
      comment: "Average maximum weight capacity per yard slot in kg. Monitors structural load compliance for heavy cargo placement."
    - name: "avg_swl_rating_tonnes"
      expr: AVG(CAST(swl_rating_tonnes AS DOUBLE))
      comment: "Average Safe Working Load (SWL) rating per yard slot in tonnes. Ensures heavy container placement within structural limits."
$$;

CREATE OR REPLACE VIEW `vibe_shipping_ports_v1`.`_metrics`.`terminal_roro_activity`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "RoRo (Roll-on/Roll-off) terminal activity, cargo throughput, and damage KPIs. Drives decisions on ramp capacity, lashing resource planning, and RoRo cargo quality management."
  source: "`vibe_shipping_ports_v1`.`terminal`.`roro_activity`"
  dimensions:
    - name: "activity_type"
      expr: activity_type
      comment: "Type of RoRo activity (ROLL_ON, ROLL_OFF, LASHING, UNLASHING) for operational volume analysis by activity category."
    - name: "activity_status"
      expr: activity_status
      comment: "Current status of the RoRo activity (COMPLETED, IN_PROGRESS, CANCELLED) for throughput pipeline analysis."
    - name: "vehicle_type"
      expr: vehicle_type
      comment: "Type of RoRo vehicle (CAR, TRUCK, HEAVY_MACHINERY, TRAILER) for cargo mix and handling resource analysis."
    - name: "damage_detected_flag"
      expr: damage_detected_flag
      comment: "Flags RoRo activities where vehicle/cargo damage was detected for quality and liability analysis."
    - name: "dangerous_goods_flag"
      expr: dangerous_goods_flag
      comment: "Flags RoRo activities involving dangerous goods for IMDG compliance and special handling tracking."
    - name: "customs_status"
      expr: customs_status
      comment: "Customs clearance status of the RoRo cargo for trade compliance monitoring."
    - name: "activity_month"
      expr: DATE_TRUNC('month', activity_start_timestamp)
      comment: "Month-level bucket of RoRo activity start for monthly throughput trending."
    - name: "imdg_class"
      expr: imdg_class
      comment: "IMDG class of dangerous goods in RoRo activity for hazmat volume analysis."
  measures:
    - name: "total_roro_activities"
      expr: COUNT(1)
      comment: "Total RoRo activity events. Baseline KPI for RoRo terminal throughput volume."
    - name: "total_weight_tonnes"
      expr: SUM(CAST(weight_tonnes AS DOUBLE))
      comment: "Total weight of RoRo cargo handled in tonnes. Primary RoRo throughput KPI for berth and ramp capacity planning."
    - name: "avg_weight_tonnes"
      expr: AVG(CAST(weight_tonnes AS DOUBLE))
      comment: "Average weight per RoRo unit in tonnes. Benchmarks cargo density for ramp load limit compliance."
    - name: "damage_detected_count"
      expr: COUNT(CASE WHEN damage_detected_flag = TRUE THEN 1 END)
      comment: "Count of RoRo activities with detected damage. Drives vehicle damage claims management and handling procedure review."
    - name: "dangerous_goods_activity_count"
      expr: COUNT(CASE WHEN dangerous_goods_flag = TRUE THEN 1 END)
      comment: "Count of RoRo activities involving dangerous goods. Drives IMDG compliance monitoring for RoRo vessel operations."
    - name: "avg_length_meters"
      expr: AVG(CAST(length_meters AS DOUBLE))
      comment: "Average length of RoRo units in meters. Informs deck space planning and lane allocation on RoRo vessels."
    - name: "avg_height_meters"
      expr: AVG(CAST(height_meters AS DOUBLE))
      comment: "Average height of RoRo units in meters. Monitors deck clearance compliance for high-and-heavy cargo."
    - name: "total_lashing_point_count"
      expr: SUM(CAST(lashing_point_count AS DOUBLE))
      comment: "Total lashing points used across RoRo activities. Drives lashing equipment inventory planning and cargo securing compliance."
$$;

CREATE OR REPLACE VIEW `vibe_shipping_ports_v1`.`_metrics`.`terminal_cfs_activity`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Container Freight Station (CFS) activity throughput, cargo handling, and revenue KPIs. Drives decisions on CFS capacity, staffing, and LCL cargo service performance."
  source: "`vibe_shipping_ports_v1`.`terminal`.`cfs_activity`"
  dimensions:
    - name: "activity_type"
      expr: activity_type
      comment: "Type of CFS activity (STUFFING, STRIPPING, CONSOLIDATION, DECONSOLIDATION) for operational volume analysis."
    - name: "activity_status"
      expr: activity_status
      comment: "Current status of the CFS activity (COMPLETED, IN_PROGRESS, PENDING) for throughput pipeline analysis."
    - name: "temperature_controlled_flag"
      expr: temperature_controlled_flag
      comment: "Flags temperature-controlled CFS activities for cold-chain capacity planning."
    - name: "dangerous_goods_flag"
      expr: dangerous_goods_flag
      comment: "Flags CFS activities involving dangerous goods for IMDG compliance and special handling tracking."
    - name: "damage_reported_flag"
      expr: damage_reported_flag
      comment: "Flags CFS activities where cargo damage was reported for quality and claims management."
    - name: "seal_intact_flag"
      expr: seal_intact_flag
      comment: "Indicates whether container seal was intact at CFS for cargo security and customs compliance monitoring."
    - name: "imdg_class"
      expr: imdg_class
      comment: "IMDG class of dangerous goods in CFS activity for hazmat handling volume analysis."
    - name: "activity_month"
      expr: DATE_TRUNC('month', actual_start_time)
      comment: "Month-level bucket of CFS activity start for monthly throughput trending."
  measures:
    - name: "total_cfs_activities"
      expr: COUNT(1)
      comment: "Total CFS activity events. Baseline KPI for CFS throughput volume and staffing demand."
    - name: "total_cargo_weight_kg"
      expr: SUM(CAST(cargo_weight_kg AS DOUBLE))
      comment: "Total cargo weight handled at CFS in kg. Primary CFS throughput KPI for capacity and equipment planning."
    - name: "total_cargo_volume_cbm"
      expr: SUM(CAST(cargo_volume_cbm AS DOUBLE))
      comment: "Total cargo volume handled at CFS in cubic meters. Drives CFS warehouse space utilization and capacity planning."
    - name: "total_handling_charge_amount"
      expr: SUM(CAST(handling_charge_amount AS DOUBLE))
      comment: "Total CFS handling charge revenue. Ancillary revenue KPI for CFS commercial performance reporting."
    - name: "avg_handling_charge_amount"
      expr: AVG(CAST(handling_charge_amount AS DOUBLE))
      comment: "Average handling charge per CFS activity. Benchmarks CFS revenue yield per transaction."
    - name: "damage_reported_count"
      expr: COUNT(CASE WHEN damage_reported_flag = TRUE THEN 1 END)
      comment: "Count of CFS activities with reported cargo damage. Drives CFS quality management and cargo claims liability analysis."
    - name: "dangerous_goods_activity_count"
      expr: COUNT(CASE WHEN dangerous_goods_flag = TRUE THEN 1 END)
      comment: "Count of CFS activities involving dangerous goods. Drives IMDG compliance monitoring for CFS operations."
    - name: "avg_target_temperature_celsius"
      expr: AVG(CAST(target_temperature_celsius AS DOUBLE))
      comment: "Average target temperature for temperature-controlled CFS activities. Monitors cold-chain specification compliance in CFS operations."
$$;

CREATE OR REPLACE VIEW `vibe_shipping_ports_v1`.`_metrics`.`terminal_equipment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Terminal equipment fleet health, utilization, and maintenance KPIs. Drives decisions on equipment investment, maintenance scheduling, and operational readiness."
  source: "`vibe_shipping_ports_v1`.`terminal`.`terminal_equipment`"
  dimensions:
    - name: "operational_status"
      expr: operational_status
      comment: "Current operational status of the equipment (OPERATIONAL, UNDER_MAINTENANCE, OUT_OF_SERVICE) for fleet availability analysis."
    - name: "equipment_number"
      expr: equipment_number
      comment: "Equipment identifier for individual asset performance tracking."
    - name: "fuel_power_type"
      expr: fuel_power_type
      comment: "Fuel or power type (DIESEL, ELECTRIC, HYBRID, LNG) for fleet decarbonization and emissions analysis."
    - name: "automation_level"
      expr: automation_level
      comment: "Automation level of the equipment (MANUAL, SEMI_AUTOMATED, FULLY_AUTOMATED) for automation investment analysis."
    - name: "ownership_type"
      expr: ownership_type
      comment: "Equipment ownership type (OWNED, LEASED, RENTED) for asset financing and cost structure analysis."
    - name: "imdg_certified"
      expr: imdg_certified
      comment: "Indicates whether the equipment is certified for IMDG dangerous goods handling for hazmat capacity planning."
    - name: "gps_tracking_enabled"
      expr: gps_tracking_enabled
      comment: "Indicates GPS tracking capability for fleet visibility and telematics coverage analysis."
    - name: "reefer_monitoring_capable"
      expr: reefer_monitoring_capable
      comment: "Indicates whether the equipment can handle reefer monitoring for cold-chain fleet capacity planning."
    - name: "emission_standard"
      expr: emission_standard
      comment: "Emission standard compliance level (EURO_VI, TIER_4, etc.) for environmental compliance fleet analysis."
  measures:
    - name: "total_equipment_units"
      expr: COUNT(1)
      comment: "Total terminal equipment units in the fleet. Baseline KPI for fleet size and capacity inventory."
    - name: "operational_equipment_count"
      expr: COUNT(CASE WHEN operational_status = 'OPERATIONAL' THEN 1 END)
      comment: "Count of currently operational equipment units. Drives real-time fleet availability and crane gang planning."
    - name: "avg_operating_hours_total"
      expr: AVG(CAST(operating_hours_total AS DOUBLE))
      comment: "Average total operating hours per equipment unit. Measures fleet age and utilization intensity for replacement planning."
    - name: "avg_operating_hours_since_last_service"
      expr: AVG(CAST(operating_hours_since_last_service AS DOUBLE))
      comment: "Average operating hours since last service. Identifies equipment approaching maintenance thresholds for proactive scheduling."
    - name: "total_replacement_value"
      expr: SUM(CAST(replacement_value AS DOUBLE))
      comment: "Total replacement value of the terminal equipment fleet. Drives insurance coverage adequacy and capital expenditure planning."
    - name: "avg_replacement_value"
      expr: AVG(CAST(replacement_value AS DOUBLE))
      comment: "Average replacement value per equipment unit. Benchmarks asset value for depreciation and insurance decisions."
    - name: "avg_maximum_lift_height_metres"
      expr: AVG(CAST(maximum_lift_height_metres AS DOUBLE))
      comment: "Average maximum lift height across the equipment fleet in metres. Informs stack height planning and yard capacity optimization."
    - name: "avg_swl_tonnes"
      expr: AVG(CAST(swl_tonnes AS DOUBLE))
      comment: "Average Safe Working Load (SWL) across the equipment fleet in tonnes. Monitors fleet capability for heavy-lift cargo acceptance."
    - name: "imdg_certified_count"
      expr: COUNT(CASE WHEN imdg_certified = TRUE THEN 1 END)
      comment: "Count of IMDG-certified equipment units. Drives dangerous goods handling capacity planning and IMDG compliance assurance."
$$;

CREATE OR REPLACE VIEW `vibe_shipping_ports_v1`.`_metrics`.`terminal_berth_discount_application`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Berth discount application and revenue impact KPIs. Drives decisions on discount policy effectiveness, revenue leakage management, and commercial negotiation outcomes."
  source: "`vibe_shipping_ports_v1`.`terminal`.`berth_discount_application`"
  dimensions:
    - name: "application_status"
      expr: application_status
      comment: "Status of the discount application (APPROVED, REJECTED, PENDING) for discount pipeline and approval rate analysis."
    - name: "application_reason"
      expr: application_reason
      comment: "Business reason for the discount application for discount justification and policy compliance analysis."
    - name: "threshold_met_flag"
      expr: threshold_met_flag
      comment: "Indicates whether the volume commitment threshold was met to qualify for the discount."
    - name: "discount_amount_currency_code"
      expr: discount_amount_currency_code
      comment: "Currency of the discount amount for multi-currency revenue impact analysis."
    - name: "approval_date"
      expr: DATE_TRUNC('day', approval_timestamp)
      comment: "Day-level bucket of discount approval for daily revenue impact trending."
    - name: "effective_from_month"
      expr: DATE_TRUNC('month', effective_from_timestamp)
      comment: "Month-level bucket of discount effective date for monthly discount exposure analysis."
  measures:
    - name: "total_discount_applications"
      expr: COUNT(1)
      comment: "Total berth discount applications. Baseline KPI for discount program utilization and commercial activity."
    - name: "total_applied_discount_value"
      expr: SUM(CAST(applied_discount_value AS DOUBLE))
      comment: "Total value of applied berth discounts. Measures revenue concession impact for commercial performance and pricing policy review."
    - name: "avg_applied_discount_value"
      expr: AVG(CAST(applied_discount_value AS DOUBLE))
      comment: "Average discount value per application. Benchmarks discount generosity and informs pricing policy calibration."
    - name: "approved_discount_count"
      expr: COUNT(CASE WHEN application_status = 'APPROVED' THEN 1 END)
      comment: "Count of approved discount applications. Measures discount approval rate for commercial policy compliance monitoring."
    - name: "threshold_met_count"
      expr: COUNT(CASE WHEN threshold_met_flag = TRUE THEN 1 END)
      comment: "Count of discount applications where volume commitment threshold was met. Measures commercial commitment fulfillment rate."
$$;

CREATE OR REPLACE VIEW `vibe_shipping_ports_v1`.`_metrics`.`terminal_container_tariff_exception_application`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Container tariff exception and waiver KPIs. Drives decisions on tariff exception policy, revenue leakage control, and commercial exception governance."
  source: "`vibe_shipping_ports_v1`.`terminal`.`container_tariff_exception_application`"
  dimensions:
    - name: "application_status"
      expr: application_status
      comment: "Status of the tariff exception application (APPROVED, REJECTED, PENDING) for exception pipeline and approval rate analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the exception amounts for multi-currency revenue impact analysis."
    - name: "effective_date"
      expr: effective_date
      comment: "Date the tariff exception becomes effective for temporal revenue impact analysis."
    - name: "application_month"
      expr: DATE_TRUNC('month', application_timestamp)
      comment: "Month-level bucket of exception application for monthly revenue leakage trending."
  measures:
    - name: "total_exception_applications"
      expr: COUNT(1)
      comment: "Total tariff exception applications. Baseline KPI for exception program utilization and commercial governance workload."
    - name: "total_revenue_impact_amount"
      expr: SUM(CAST(revenue_impact_amount AS DOUBLE))
      comment: "Total revenue impact of tariff exceptions. Measures revenue leakage from exception grants for commercial policy review."
    - name: "total_waiver_amount"
      expr: SUM(CAST(waiver_amount AS DOUBLE))
      comment: "Total waiver amount granted across tariff exceptions. Quantifies revenue foregone through waivers for financial control."
    - name: "avg_discount_percentage"
      expr: AVG(CAST(discount_percentage AS DOUBLE))
      comment: "Average discount percentage granted in tariff exceptions. Benchmarks exception generosity and informs tariff policy calibration."
    - name: "avg_exception_rate_amount"
      expr: AVG(CAST(exception_rate_amount AS DOUBLE))
      comment: "Average exception rate amount applied. Measures the effective tariff rate after exceptions for revenue yield analysis."
    - name: "approved_exception_count"
      expr: COUNT(CASE WHEN application_status = 'APPROVED' THEN 1 END)
      comment: "Count of approved tariff exceptions. Measures exception approval rate for commercial governance compliance."
$$;