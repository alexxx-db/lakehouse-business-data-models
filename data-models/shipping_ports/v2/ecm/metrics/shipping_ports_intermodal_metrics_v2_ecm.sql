-- Metric views for domain: intermodal | Business: Shipping_Ports | Version: 2 | Generated on: 2026-07-13 07:51:56

CREATE OR REPLACE VIEW `vibe_shipping_ports_v1`.`_metrics`.`intermodal_drayage_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Operational KPIs for drayage order execution — measures on-time delivery performance, hazmat exposure, reefer utilization, and cargo weight throughput to steer last-mile trucking efficiency and compliance."
  source: "`vibe_shipping_ports_v1`.`intermodal`.`drayage_order`"
  dimensions:
    - name: "drayage_status"
      expr: drayage_status
      comment: "Current lifecycle status of the drayage order (e.g. pending, in-transit, delivered, cancelled) — primary operational grouping for performance analysis."
    - name: "drayage_type"
      expr: drayage_type
      comment: "Type of drayage movement (e.g. import, export, empty reposition) — used to segment volume and cost by trade direction."
    - name: "origin_location_type"
      expr: origin_location_type
      comment: "Classification of the origin location (port, ICD, warehouse, depot) — identifies the supply-side node for drayage flow analysis."
    - name: "destination_location_type"
      expr: destination_location_type
      comment: "Classification of the destination location — identifies the demand-side node for drayage flow analysis."
    - name: "hazmat_indicator"
      expr: hazmat_indicator
      comment: "Flag indicating whether the drayage order carries hazardous materials — used to segment compliance and safety exposure."
    - name: "reefer_indicator"
      expr: reefer_indicator
      comment: "Flag indicating whether the drayage order involves a refrigerated container — used to track cold-chain utilization."
    - name: "imdg_class"
      expr: imdg_class
      comment: "IMDG dangerous goods class for the cargo — enables DG-specific performance and compliance segmentation."
    - name: "order_priority"
      expr: order_priority
      comment: "Priority level assigned to the drayage order — used to assess SLA adherence by priority tier."
    - name: "overweight_indicator"
      expr: overweight_indicator
      comment: "Flag indicating whether the container is overweight — used to track regulatory compliance and road permit exposure."
    - name: "scheduled_delivery_date"
      expr: DATE_TRUNC('day', scheduled_delivery_date)
      comment: "Scheduled delivery date truncated to day — primary time dimension for delivery performance trending."
    - name: "scheduled_pickup_date"
      expr: DATE_TRUNC('day', scheduled_pickup_date)
      comment: "Scheduled pickup date truncated to day — used to align pickup volume with port gate and berth capacity."
  measures:
    - name: "total_drayage_orders"
      expr: COUNT(1)
      comment: "Total number of drayage orders — baseline volume KPI for capacity planning and haulier workload assessment."
    - name: "proof_of_delivery_rate"
      expr: ROUND(100.0 * SUM(CAST(CASE WHEN proof_of_delivery_received = TRUE THEN 1 ELSE 0 END AS INT)) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of drayage orders with confirmed proof of delivery — critical last-mile quality KPI; low rates indicate documentation or operational failures."
    - name: "on_time_delivery_count"
      expr: SUM(CAST(CASE WHEN actual_delivery_timestamp <= scheduled_delivery_time_window_end THEN 1 ELSE 0 END AS INT))
      comment: "Count of drayage orders delivered within the scheduled time window — numerator for on-time delivery rate calculation."
    - name: "total_deliverable_orders"
      expr: SUM(CAST(CASE WHEN actual_delivery_timestamp IS NOT NULL AND scheduled_delivery_time_window_end IS NOT NULL THEN 1 ELSE 0 END AS INT))
      comment: "Count of drayage orders with both actual and scheduled delivery timestamps — denominator for on-time delivery rate."
    - name: "total_cargo_weight_kg"
      expr: SUM(CAST(verified_gross_mass_kg AS DOUBLE))
      comment: "Total verified gross mass in kilograms across all drayage orders — measures cargo throughput and road load for infrastructure planning."
    - name: "avg_cargo_weight_kg"
      expr: AVG(CAST(verified_gross_mass_kg AS DOUBLE))
      comment: "Average verified gross mass per drayage order — used to assess typical load profile and detect overweight trends."
    - name: "hazmat_order_count"
      expr: SUM(CAST(CASE WHEN hazmat_indicator = TRUE THEN 1 ELSE 0 END AS INT))
      comment: "Number of drayage orders carrying hazardous materials — tracks DG exposure for safety and compliance reporting."
    - name: "reefer_order_count"
      expr: SUM(CAST(CASE WHEN reefer_indicator = TRUE THEN 1 ELSE 0 END AS INT))
      comment: "Number of drayage orders involving refrigerated containers — measures cold-chain demand for reefer asset planning."
    - name: "cancelled_order_count"
      expr: SUM(CAST(CASE WHEN drayage_status = 'CANCELLED' THEN 1 ELSE 0 END AS INT))
      comment: "Number of cancelled drayage orders — high cancellation rates signal booking quality or haulier reliability issues."
    - name: "overweight_order_count"
      expr: SUM(CAST(CASE WHEN overweight_indicator = TRUE THEN 1 ELSE 0 END AS INT))
      comment: "Number of overweight drayage orders — tracks regulatory compliance exposure and road permit requirements."
$$;

CREATE OR REPLACE VIEW `vibe_shipping_ports_v1`.`_metrics`.`intermodal_transport_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPIs for intermodal transport order management — measures volume, cargo weight throughput, TEU utilization, hazmat exposure, and order fulfilment quality across all transport modes."
  source: "`vibe_shipping_ports_v1`.`intermodal`.`transport_order`"
  dimensions:
    - name: "order_status"
      expr: order_status
      comment: "Current lifecycle status of the transport order (e.g. created, in-transit, delivered, cancelled) — primary operational grouping."
    - name: "primary_transport_mode"
      expr: primary_transport_mode
      comment: "Primary mode of transport (road, rail, sea, air) — used to segment volume and cost by modal split."
    - name: "is_hazardous"
      expr: is_hazardous
      comment: "Flag indicating whether the transport order carries hazardous cargo — used for DG compliance segmentation."
    - name: "is_refrigerated"
      expr: is_refrigerated
      comment: "Flag indicating whether the transport order requires refrigeration — used to track cold-chain demand."
    - name: "imdg_class"
      expr: imdg_class
      comment: "IMDG dangerous goods class — enables DG-specific performance and compliance segmentation."
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level of the transport order — used to assess SLA adherence by priority tier."
    - name: "transport_mode_sequence"
      expr: transport_mode_sequence
      comment: "Sequence of transport modes used (e.g. road-rail-sea) — identifies multimodal routing patterns for network optimization."
    - name: "order_date_month"
      expr: DATE_TRUNC('month', order_date)
      comment: "Transport order creation date truncated to month — primary time dimension for volume trending."
    - name: "required_delivery_date_month"
      expr: DATE_TRUNC('month', required_delivery_date)
      comment: "Required delivery date truncated to month — used to align demand forecasting with capacity planning."
  measures:
    - name: "total_transport_orders"
      expr: COUNT(1)
      comment: "Total number of transport orders — baseline volume KPI for intermodal network capacity planning."
    - name: "total_teu_volume"
      expr: SUM(CAST(teu_count AS DOUBLE))
      comment: "Total TEU volume across all transport orders — primary throughput KPI for intermodal capacity and revenue planning."
    - name: "avg_teu_per_order"
      expr: AVG(CAST(teu_count AS DOUBLE))
      comment: "Average TEU count per transport order — measures order size profile for network and equipment planning."
    - name: "total_cargo_weight_kg"
      expr: SUM(CAST(cargo_weight_kg AS DOUBLE))
      comment: "Total cargo weight in kilograms across all transport orders — measures physical throughput for infrastructure load planning."
    - name: "total_cargo_volume_cbm"
      expr: SUM(CAST(cargo_volume_cbm AS DOUBLE))
      comment: "Total cargo volume in cubic metres — measures volumetric throughput for space utilization analysis."
    - name: "hazardous_order_count"
      expr: SUM(CAST(CASE WHEN is_hazardous = TRUE THEN 1 ELSE 0 END AS INT))
      comment: "Number of transport orders carrying hazardous cargo — tracks DG exposure for safety and compliance reporting."
    - name: "refrigerated_order_count"
      expr: SUM(CAST(CASE WHEN is_refrigerated = TRUE THEN 1 ELSE 0 END AS INT))
      comment: "Number of refrigerated transport orders — measures cold-chain demand for reefer asset and infrastructure planning."
    - name: "on_time_delivery_count"
      expr: SUM(CAST(CASE WHEN actual_delivery_date <= estimated_delivery_date THEN 1 ELSE 0 END AS INT))
      comment: "Count of transport orders delivered on or before the estimated delivery date — numerator for on-time delivery rate."
    - name: "deliverable_order_count"
      expr: SUM(CAST(CASE WHEN actual_delivery_date IS NOT NULL AND estimated_delivery_date IS NOT NULL THEN 1 ELSE 0 END AS INT))
      comment: "Count of transport orders with both actual and estimated delivery timestamps — denominator for on-time delivery rate."
    - name: "cancelled_order_count"
      expr: SUM(CAST(CASE WHEN order_status = 'CANCELLED' THEN 1 ELSE 0 END AS INT))
      comment: "Number of cancelled transport orders — high cancellation rates signal booking quality or capacity issues."
$$;

CREATE OR REPLACE VIEW `vibe_shipping_ports_v1`.`_metrics`.`intermodal_transport_leg`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Operational and financial KPIs for individual intermodal transport legs — measures cost efficiency, carbon emissions, transit time performance, TEU throughput, and delay patterns across all leg types and transport modes."
  source: "`vibe_shipping_ports_v1`.`intermodal`.`transport_leg`"
  dimensions:
    - name: "transport_mode"
      expr: transport_mode
      comment: "Mode of transport for this leg (road, rail, sea, air) — primary segmentation for modal split analysis and cost benchmarking."
    - name: "leg_status"
      expr: leg_status
      comment: "Current lifecycle status of the transport leg — used to track in-progress vs completed vs delayed legs."
    - name: "hazmat_indicator"
      expr: hazmat_indicator
      comment: "Flag indicating whether this leg carries hazardous materials — used for DG compliance and safety segmentation."
    - name: "reefer_indicator"
      expr: reefer_indicator
      comment: "Flag indicating whether this leg involves a refrigerated container — used to track cold-chain leg performance."
    - name: "imdg_class"
      expr: imdg_class
      comment: "IMDG dangerous goods class for this leg — enables DG-specific performance segmentation."
    - name: "delay_reason_code"
      expr: delay_reason_code
      comment: "Reason code for leg delay — used to identify systemic delay causes for operational improvement."
    - name: "origin_node_type"
      expr: origin_node_type
      comment: "Type of origin node (port, ICD, warehouse, depot) — used to analyse leg flow patterns by node type."
    - name: "destination_node_type"
      expr: destination_node_type
      comment: "Type of destination node — used to analyse leg flow patterns by destination node type."
    - name: "scheduled_departure_month"
      expr: DATE_TRUNC('month', scheduled_departure_timestamp)
      comment: "Scheduled departure timestamp truncated to month — primary time dimension for leg volume and performance trending."
  measures:
    - name: "total_transport_legs"
      expr: COUNT(1)
      comment: "Total number of transport legs — baseline volume KPI for intermodal network activity measurement."
    - name: "total_actual_cost_usd"
      expr: SUM(CAST(actual_cost_usd AS DOUBLE))
      comment: "Total actual cost in USD across all transport legs — primary financial KPI for intermodal cost management and budget variance analysis."
    - name: "total_estimated_cost_usd"
      expr: SUM(CAST(estimated_cost_usd AS DOUBLE))
      comment: "Total estimated cost in USD — used as budget baseline for cost variance analysis against actual spend."
    - name: "avg_actual_cost_usd"
      expr: AVG(CAST(actual_cost_usd AS DOUBLE))
      comment: "Average actual cost per transport leg — used to benchmark cost efficiency across modes, corridors, and operators."
    - name: "total_carbon_emissions_kg_co2"
      expr: SUM(CAST(carbon_emissions_kg_co2 AS DOUBLE))
      comment: "Total carbon emissions in kg CO2 across all transport legs — primary sustainability KPI for decarbonization tracking and modal shift decisions."
    - name: "avg_carbon_emissions_kg_co2"
      expr: AVG(CAST(carbon_emissions_kg_co2 AS DOUBLE))
      comment: "Average carbon emissions per transport leg — used to benchmark emissions intensity by mode and corridor."
    - name: "total_teu_volume"
      expr: SUM(CAST(teu_count AS DOUBLE))
      comment: "Total TEU volume transported across all legs — measures intermodal throughput for capacity and revenue planning."
    - name: "total_distance_km"
      expr: SUM(CAST(distance_km AS DOUBLE))
      comment: "Total distance covered in kilometres across all transport legs — used for cost-per-km benchmarking and network efficiency analysis."
    - name: "avg_transit_time_hours"
      expr: AVG(CAST(transit_time_hours AS DOUBLE))
      comment: "Average transit time in hours per transport leg — key SLA performance indicator for intermodal service quality."
    - name: "total_cargo_weight_kg"
      expr: SUM(CAST(cargo_weight_kg AS DOUBLE))
      comment: "Total cargo weight in kilograms across all transport legs — measures physical throughput for infrastructure load planning."
    - name: "delayed_leg_count"
      expr: SUM(CAST(CASE WHEN actual_arrival_timestamp > scheduled_arrival_timestamp THEN 1 ELSE 0 END AS INT))
      comment: "Number of transport legs that arrived later than scheduled — numerator for delay rate calculation; high values trigger corridor and operator reviews."
    - name: "measurable_leg_count"
      expr: SUM(CAST(CASE WHEN actual_arrival_timestamp IS NOT NULL AND scheduled_arrival_timestamp IS NOT NULL THEN 1 ELSE 0 END AS INT))
      comment: "Number of transport legs with both actual and scheduled arrival timestamps — denominator for on-time performance rate."
$$;

CREATE OR REPLACE VIEW `vibe_shipping_ports_v1`.`_metrics`.`intermodal_truck_appointment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Gate and truck appointment KPIs — measures appointment utilisation, no-show rates, hazmat exposure, reefer demand, and cargo weight throughput to optimise gate capacity and reduce congestion."
  source: "`vibe_shipping_ports_v1`.`intermodal`.`truck_appointment`"
  dimensions:
    - name: "appointment_status"
      expr: appointment_status
      comment: "Current status of the truck appointment (confirmed, cancelled, no-show, completed) — primary operational grouping for gate performance analysis."
    - name: "appointment_type"
      expr: appointment_type
      comment: "Type of truck appointment (import pickup, export drop, empty return, etc.) — used to segment gate volume by trade direction."
    - name: "booking_channel"
      expr: booking_channel
      comment: "Channel through which the appointment was booked (web portal, EDI, phone) — used to drive digital adoption and reduce manual bookings."
    - name: "transport_mode"
      expr: transport_mode
      comment: "Mode of transport associated with the appointment — used to segment gate activity by transport type."
    - name: "is_hazardous"
      expr: is_hazardous
      comment: "Flag indicating whether the appointment involves hazardous cargo — used for DG compliance and gate lane planning."
    - name: "is_reefer"
      expr: is_reefer
      comment: "Flag indicating whether the appointment involves a refrigerated container — used to plan reefer plug availability at gate."
    - name: "is_overweight"
      expr: is_overweight
      comment: "Flag indicating whether the appointment involves an overweight container — used to track weighbridge and permit compliance."
    - name: "vehicle_type"
      expr: vehicle_type
      comment: "Type of vehicle presenting for the appointment — used to plan gate lane capacity by vehicle class."
    - name: "confirmed_slot_date"
      expr: DATE_TRUNC('day', confirmed_slot_start_time)
      comment: "Confirmed slot date truncated to day — primary time dimension for gate volume and utilisation trending."
  measures:
    - name: "total_appointments"
      expr: COUNT(1)
      comment: "Total number of truck appointments — baseline gate volume KPI for capacity planning and congestion management."
    - name: "no_show_count"
      expr: SUM(CAST(CASE WHEN no_show_flag = TRUE THEN 1 ELSE 0 END AS INT))
      comment: "Number of truck appointments where the vehicle did not present — high no-show rates waste gate slot capacity and indicate booking quality issues."
    - name: "no_show_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(CASE WHEN no_show_flag = TRUE THEN 1 ELSE 0 END AS INT)) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of truck appointments resulting in a no-show — key gate efficiency KPI; high rates trigger slot deposit or penalty policy reviews."
    - name: "total_teu_quantity"
      expr: SUM(CAST(teu_quantity AS DOUBLE))
      comment: "Total TEU quantity across all truck appointments — measures gate throughput in TEU terms for capacity and revenue planning."
    - name: "avg_teu_per_appointment"
      expr: AVG(CAST(teu_quantity AS DOUBLE))
      comment: "Average TEU quantity per truck appointment — used to assess typical gate transaction size for lane planning."
    - name: "total_cargo_weight_kg"
      expr: SUM(CAST(cargo_weight_kg AS DOUBLE))
      comment: "Total cargo weight in kilograms across all truck appointments — measures physical gate throughput for infrastructure load planning."
    - name: "hazmat_appointment_count"
      expr: SUM(CAST(CASE WHEN is_hazardous = TRUE THEN 1 ELSE 0 END AS INT))
      comment: "Number of truck appointments involving hazardous cargo — tracks DG gate exposure for safety and compliance reporting."
    - name: "reefer_appointment_count"
      expr: SUM(CAST(CASE WHEN is_reefer = TRUE THEN 1 ELSE 0 END AS INT))
      comment: "Number of truck appointments involving refrigerated containers — measures cold-chain gate demand for reefer plug planning."
    - name: "cancelled_appointment_count"
      expr: SUM(CAST(CASE WHEN appointment_status = 'CANCELLED' THEN 1 ELSE 0 END AS INT))
      comment: "Number of cancelled truck appointments — high cancellation rates indicate booking quality or operational disruption issues."
$$;

CREATE OR REPLACE VIEW `vibe_shipping_ports_v1`.`_metrics`.`intermodal_truck_visit`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Gate throughput and turnaround KPIs for truck visits — measures actual gate processing performance, damage incidence, ISPS compliance outcomes, and OCR accuracy to drive gate efficiency and security compliance."
  source: "`vibe_shipping_ports_v1`.`intermodal`.`truck_visit`"
  dimensions:
    - name: "transaction_status"
      expr: transaction_status
      comment: "Status of the truck visit transaction (completed, rejected, pending) — primary operational grouping for gate performance analysis."
    - name: "visit_type"
      expr: visit_type
      comment: "Type of truck visit (import, export, empty, transshipment) — used to segment gate volume by trade direction."
    - name: "container_condition"
      expr: container_condition
      comment: "Condition of the container at gate (good, damaged, suspect) — used to track damage incidence and EIR quality."
    - name: "isps_compliance_check_result"
      expr: isps_compliance_check_result
      comment: "Result of the ISPS compliance check at gate (pass, fail, refer) — used to monitor security compliance outcomes."
    - name: "seal_verification_status"
      expr: seal_verification_status
      comment: "Status of seal verification at gate (verified, broken, missing) — used to track cargo integrity and security incidents."
    - name: "driver_verification_method"
      expr: driver_verification_method
      comment: "Method used to verify the driver identity (biometric, card, manual) — used to assess security process quality."
    - name: "damage_report_indicator"
      expr: damage_report_indicator
      comment: "Flag indicating whether a damage report was raised during the truck visit — used to track damage incidence rates."
    - name: "gate_in_date"
      expr: DATE_TRUNC('day', gate_in_time)
      comment: "Gate-in timestamp truncated to day — primary time dimension for gate volume and throughput trending."
  measures:
    - name: "total_truck_visits"
      expr: COUNT(1)
      comment: "Total number of truck visits — baseline gate throughput KPI for capacity planning and congestion management."
    - name: "damage_report_count"
      expr: SUM(CAST(CASE WHEN damage_report_indicator = TRUE THEN 1 ELSE 0 END AS INT))
      comment: "Number of truck visits where a damage report was raised — tracks container damage incidence at gate for liability and quality management."
    - name: "damage_report_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(CASE WHEN damage_report_indicator = TRUE THEN 1 ELSE 0 END AS INT)) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of truck visits resulting in a damage report — key cargo quality KPI; high rates trigger EIR process and haulier performance reviews."
    - name: "isps_fail_count"
      expr: SUM(CAST(CASE WHEN isps_compliance_check_result = 'FAIL' THEN 1 ELSE 0 END AS INT))
      comment: "Number of truck visits failing the ISPS compliance check — critical security KPI; failures trigger immediate security escalation."
    - name: "isps_fail_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(CASE WHEN isps_compliance_check_result = 'FAIL' THEN 1 ELSE 0 END AS INT)) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of truck visits failing ISPS compliance checks — used to assess port security posture and identify systemic access control gaps."
    - name: "avg_ocr_confidence_score"
      expr: AVG(CAST(ocr_confidence_score AS DOUBLE))
      comment: "Average OCR confidence score for container number recognition at gate — low scores indicate camera or lighting issues requiring infrastructure investment."
    - name: "rejected_visit_count"
      expr: SUM(CAST(CASE WHEN transaction_status = 'REJECTED' THEN 1 ELSE 0 END AS INT))
      comment: "Number of truck visits rejected at gate — high rejection rates indicate documentation, compliance, or booking quality issues."
    - name: "seal_breach_count"
      expr: SUM(CASE WHEN seal_verification_status IN ('BROKEN', 'MISSING') THEN 1 ELSE 0 END)
      comment: "Number of truck visits with broken or missing seals — critical cargo integrity and security KPI requiring immediate investigation."
$$;

CREATE OR REPLACE VIEW `vibe_shipping_ports_v1`.`_metrics`.`intermodal_rail_visit`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Rail terminal KPIs — measures train utilisation, TEU throughput, on-time performance, and reefer/hazmat exposure to optimise rail intermodal operations and operator performance management."
  source: "`vibe_shipping_ports_v1`.`intermodal`.`rail_visit`"
  dimensions:
    - name: "visit_status"
      expr: visit_status
      comment: "Current status of the rail visit (scheduled, arrived, departed, completed) — primary operational grouping for rail performance analysis."
    - name: "visit_type"
      expr: visit_type
      comment: "Type of rail visit (import, export, transit, empty) — used to segment rail volume by trade direction."
    - name: "service_type"
      expr: service_type
      comment: "Type of rail service (block train, shuttle, mixed) — used to benchmark performance by service category."
    - name: "billing_status"
      expr: billing_status
      comment: "Billing status of the rail visit — used to track revenue recognition and unbilled visit exposure."
    - name: "hazmat_indicator"
      expr: hazmat_indicator
      comment: "Flag indicating whether the rail visit carries hazardous materials — used for DG compliance and safety segmentation."
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level of the rail visit — used to assess SLA adherence by priority tier."
    - name: "scheduled_arrival_month"
      expr: DATE_TRUNC('month', scheduled_arrival_time)
      comment: "Scheduled arrival time truncated to month — primary time dimension for rail volume and performance trending."
  measures:
    - name: "total_rail_visits"
      expr: COUNT(1)
      comment: "Total number of rail visits — baseline rail throughput KPI for capacity planning and operator performance management."
    - name: "total_teu_loaded"
      expr: SUM(CAST(teu_loaded AS DOUBLE))
      comment: "Total TEU loaded onto trains across all rail visits — primary outbound throughput KPI for rail intermodal capacity planning."
    - name: "total_teu_discharged"
      expr: SUM(CAST(teu_discharged AS DOUBLE))
      comment: "Total TEU discharged from trains across all rail visits — primary inbound throughput KPI for rail intermodal capacity planning."
    - name: "avg_train_weight_tonnes"
      expr: AVG(CAST(train_weight_tonnes AS DOUBLE))
      comment: "Average train weight in tonnes per rail visit — used to assess load utilisation and infrastructure stress."
    - name: "avg_train_length_meters"
      expr: AVG(CAST(train_length_meters AS DOUBLE))
      comment: "Average train length in metres per rail visit — used to assess track utilisation and terminal capacity planning."
    - name: "on_time_arrival_count"
      expr: SUM(CAST(CASE WHEN actual_arrival_time <= scheduled_arrival_time THEN 1 ELSE 0 END AS INT))
      comment: "Number of rail visits arriving on or before scheduled time — numerator for rail on-time arrival rate."
    - name: "measurable_arrival_count"
      expr: SUM(CAST(CASE WHEN actual_arrival_time IS NOT NULL AND scheduled_arrival_time IS NOT NULL THEN 1 ELSE 0 END AS INT))
      comment: "Number of rail visits with both actual and scheduled arrival times — denominator for on-time arrival rate."
    - name: "hazmat_rail_visit_count"
      expr: SUM(CAST(CASE WHEN hazmat_indicator = TRUE THEN 1 ELSE 0 END AS INT))
      comment: "Number of rail visits carrying hazardous materials — tracks DG rail exposure for safety and compliance reporting."
$$;

CREATE OR REPLACE VIEW `vibe_shipping_ports_v1`.`_metrics`.`intermodal_slot_booking`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Intermodal slot booking KPIs — measures booking volume, TEU utilisation, no-show rates, cancellation patterns, and cargo weight to optimise slot allocation and revenue management."
  source: "`vibe_shipping_ports_v1`.`intermodal`.`slot_booking`"
  dimensions:
    - name: "booking_status"
      expr: booking_status
      comment: "Current status of the slot booking (confirmed, cancelled, no-show, completed) — primary operational grouping for booking performance analysis."
    - name: "booking_type"
      expr: booking_type
      comment: "Type of slot booking (import, export, transshipment, empty) — used to segment booking volume by trade direction."
    - name: "booking_channel"
      expr: booking_channel
      comment: "Channel through which the booking was made (web, EDI, phone) — used to drive digital adoption and reduce manual bookings."
    - name: "cargo_type"
      expr: cargo_type
      comment: "Type of cargo being booked (dry, reefer, hazmat, oversized) — used to segment slot demand by cargo category."
    - name: "hazmat_indicator"
      expr: hazmat_indicator
      comment: "Flag indicating whether the booking involves hazardous cargo — used for DG compliance and slot planning."
    - name: "reefer_indicator"
      expr: reefer_indicator
      comment: "Flag indicating whether the booking involves a refrigerated container — used to plan reefer slot availability."
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level of the slot booking — used to assess SLA adherence and premium slot utilisation."
    - name: "booking_date_month"
      expr: DATE_TRUNC('month', booking_date)
      comment: "Booking date truncated to month — primary time dimension for booking volume and demand trending."
    - name: "confirmed_slot_date"
      expr: DATE_TRUNC('day', confirmed_slot_date)
      comment: "Confirmed slot date truncated to day — used to analyse slot utilisation patterns by day."
  measures:
    - name: "total_slot_bookings"
      expr: COUNT(1)
      comment: "Total number of slot bookings — baseline volume KPI for intermodal slot demand and capacity planning."
    - name: "total_teu_booked"
      expr: SUM(CAST(teu_quantity AS DOUBLE))
      comment: "Total TEU quantity booked across all slot bookings — primary throughput KPI for intermodal slot revenue and capacity management."
    - name: "avg_teu_per_booking"
      expr: AVG(CAST(teu_quantity AS DOUBLE))
      comment: "Average TEU quantity per slot booking — used to assess typical booking size for slot allocation optimisation."
    - name: "total_cargo_weight_tonnes"
      expr: SUM(CAST(weight_tonnes AS DOUBLE))
      comment: "Total cargo weight in tonnes across all slot bookings — measures physical demand for infrastructure load planning."
    - name: "total_cargo_volume_cbm"
      expr: SUM(CAST(volume_cbm AS DOUBLE))
      comment: "Total cargo volume in cubic metres across all slot bookings — measures volumetric demand for space utilisation analysis."
    - name: "no_show_booking_count"
      expr: SUM(CAST(CASE WHEN no_show_indicator = TRUE THEN 1 ELSE 0 END AS INT))
      comment: "Number of slot bookings resulting in a no-show — high no-show rates waste slot capacity and indicate booking quality issues."
    - name: "no_show_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(CASE WHEN no_show_indicator = TRUE THEN 1 ELSE 0 END AS INT)) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of slot bookings resulting in a no-show — key slot utilisation KPI; high rates trigger deposit or penalty policy reviews."
    - name: "cancelled_booking_count"
      expr: SUM(CAST(CASE WHEN booking_status = 'CANCELLED' THEN 1 ELSE 0 END AS INT))
      comment: "Number of cancelled slot bookings — high cancellation rates signal demand volatility or service reliability issues."
$$;

CREATE OR REPLACE VIEW `vibe_shipping_ports_v1`.`_metrics`.`intermodal_service`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Intermodal service portfolio KPIs — measures service capacity, SLA performance targets, route distance, and transit time benchmarks to support network design and service quality management decisions."
  source: "`vibe_shipping_ports_v1`.`intermodal`.`intermodal_service`"
  dimensions:
    - name: "service_status"
      expr: service_status
      comment: "Current operational status of the intermodal service (active, suspended, discontinued) — primary grouping for service portfolio management."
    - name: "service_type"
      expr: service_type
      comment: "Type of intermodal service (rail shuttle, road feeder, barge, etc.) — used to segment performance by service category."
    - name: "transport_mode"
      expr: transport_mode
      comment: "Primary transport mode of the service — used for modal split analysis and network planning."
    - name: "dangerous_goods_allowed"
      expr: dangerous_goods_allowed
      comment: "Flag indicating whether the service accepts dangerous goods — used to segment DG-capable service capacity."
    - name: "reefer_capable"
      expr: reefer_capable
      comment: "Flag indicating whether the service supports refrigerated containers — used to plan cold-chain service availability."
    - name: "customs_clearance_supported"
      expr: customs_clearance_supported
      comment: "Flag indicating whether the service includes customs clearance support — used to assess value-added service coverage."
    - name: "effective_from_date_month"
      expr: DATE_TRUNC('month', effective_from_date)
      comment: "Service effective start date truncated to month — used to track service portfolio growth over time."
  measures:
    - name: "total_active_services"
      expr: SUM(CAST(CASE WHEN service_status = 'ACTIVE' THEN 1 ELSE 0 END AS INT))
      comment: "Number of currently active intermodal services — measures the breadth of the intermodal service portfolio for network coverage assessment."
    - name: "avg_transit_time_hours"
      expr: AVG(CAST(transit_time_hours AS DOUBLE))
      comment: "Average transit time in hours across all intermodal services — key SLA benchmark for service quality and customer promise management."
    - name: "avg_route_distance_km"
      expr: AVG(CAST(route_distance_km AS DOUBLE))
      comment: "Average route distance in kilometres across all intermodal services — used to benchmark network reach and cost-per-km efficiency."
    - name: "avg_sla_on_time_performance_target"
      expr: AVG(CAST(sla_on_time_performance_target AS DOUBLE))
      comment: "Average contracted SLA on-time performance target across all services — used to assess the ambition level of service commitments and benchmark against actuals."
    - name: "reefer_capable_service_count"
      expr: SUM(CAST(CASE WHEN reefer_capable = TRUE THEN 1 ELSE 0 END AS INT))
      comment: "Number of intermodal services capable of handling refrigerated containers — measures cold-chain network coverage for customer and commercial planning."
    - name: "dg_capable_service_count"
      expr: SUM(CAST(CASE WHEN dangerous_goods_allowed = TRUE THEN 1 ELSE 0 END AS INT))
      comment: "Number of intermodal services accepting dangerous goods — measures DG network coverage for compliance and commercial planning."
$$;

CREATE OR REPLACE VIEW `vibe_shipping_ports_v1`.`_metrics`.`intermodal_haulier`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Haulier portfolio and performance KPIs — measures active haulier base, credit exposure, fleet composition, and performance tier distribution to support vendor management and risk decisions."
  source: "`vibe_shipping_ports_v1`.`intermodal`.`haulier`"
  dimensions:
    - name: "haulier_status"
      expr: haulier_status
      comment: "Current operational status of the haulier (active, suspended, terminated) — primary grouping for vendor portfolio management."
    - name: "operator_type"
      expr: operator_type
      comment: "Type of haulier operator (owner-operator, fleet operator, freight forwarder) — used to segment vendor base by business model."
    - name: "performance_tier"
      expr: performance_tier
      comment: "Performance tier assigned to the haulier (gold, silver, bronze) — used to segment vendor base by quality and reliability."
    - name: "transport_mode"
      expr: transport_mode
      comment: "Primary transport mode operated by the haulier — used to segment vendor base by modal capability."
    - name: "office_country_code"
      expr: office_country_code
      comment: "Country code of the haulier office — used to segment vendor base by geography for regional performance analysis."
    - name: "onboarding_date_month"
      expr: DATE_TRUNC('month', onboarding_date)
      comment: "Haulier onboarding date truncated to month — used to track vendor base growth and onboarding pipeline."
  measures:
    - name: "total_hauliers"
      expr: COUNT(1)
      comment: "Total number of hauliers in the registry — baseline vendor base KPI for supply chain resilience and capacity planning."
    - name: "active_haulier_count"
      expr: SUM(CAST(CASE WHEN haulier_status = 'ACTIVE' THEN 1 ELSE 0 END AS INT))
      comment: "Number of currently active hauliers — measures available trucking capacity for operational planning and risk assessment."
    - name: "total_credit_limit_usd"
      expr: SUM(CAST(credit_limit AS DOUBLE))
      comment: "Total credit limit extended to all hauliers — measures aggregate financial exposure to the haulier base for credit risk management."
    - name: "avg_credit_limit_usd"
      expr: AVG(CAST(credit_limit AS DOUBLE))
      comment: "Average credit limit per haulier — used to benchmark credit exposure by performance tier and operator type."
    - name: "terminated_haulier_count"
      expr: SUM(CAST(CASE WHEN haulier_status = 'TERMINATED' THEN 1 ELSE 0 END AS INT))
      comment: "Number of terminated hauliers — high termination rates signal vendor quality issues or market disruption requiring procurement intervention."
$$;

CREATE OR REPLACE VIEW `vibe_shipping_ports_v1`.`_metrics`.`intermodal_icd_facility`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Inland Container Depot (ICD) facility KPIs — measures facility capacity, SLA performance, drayage efficiency, and operational coverage to support network planning and facility investment decisions."
  source: "`vibe_shipping_ports_v1`.`intermodal`.`icd_facility`"
  dimensions:
    - name: "operational_status"
      expr: operational_status
      comment: "Current operational status of the ICD facility (active, inactive, under maintenance) — primary grouping for facility portfolio management."
    - name: "facility_type"
      expr: facility_type
      comment: "Type of ICD facility (on-dock, off-dock, bonded, open) — used to segment facility base by operational model."
    - name: "customs_bonded_facility"
      expr: customs_bonded_facility
      comment: "Flag indicating whether the facility is customs bonded — used to segment bonded vs non-bonded capacity for trade compliance planning."
    - name: "dangerous_goods_certified"
      expr: dangerous_goods_certified
      comment: "Flag indicating whether the facility is certified for dangerous goods — used to assess DG handling network coverage."
    - name: "rail_connectivity"
      expr: rail_connectivity
      comment: "Flag indicating whether the facility has rail connectivity — used to identify multimodal hub facilities for network planning."
    - name: "isps_compliant"
      expr: isps_compliant
      comment: "Flag indicating whether the facility is ISPS compliant — used to track security compliance across the ICD network."
    - name: "country_code"
      expr: country_code
      comment: "Country code of the ICD facility — used to segment facility base by geography for regional network analysis."
  measures:
    - name: "total_icd_facilities"
      expr: COUNT(1)
      comment: "Total number of ICD facilities in the network — baseline facility portfolio KPI for network coverage assessment."
    - name: "active_facility_count"
      expr: SUM(CAST(CASE WHEN operational_status = 'ACTIVE' THEN 1 ELSE 0 END AS INT))
      comment: "Number of currently active ICD facilities — measures available inland depot capacity for operational planning."
    - name: "avg_sla_turnaround_time_hours"
      expr: AVG(CAST(sla_turnaround_time_hours AS DOUBLE))
      comment: "Average SLA turnaround time in hours across all ICD facilities — key service quality benchmark for customer promise and facility performance management."
    - name: "avg_drayage_time_hours"
      expr: AVG(CAST(average_drayage_time_hours AS DOUBLE))
      comment: "Average drayage time in hours from ICD to port — measures last-mile efficiency and identifies facilities with poor connectivity."
    - name: "avg_distance_from_port_km"
      expr: AVG(CAST(distance_from_port_km AS DOUBLE))
      comment: "Average distance from port in kilometres across all ICD facilities — used to assess network proximity and drayage cost exposure."
    - name: "rail_connected_facility_count"
      expr: SUM(CAST(CASE WHEN rail_connectivity = TRUE THEN 1 ELSE 0 END AS INT))
      comment: "Number of ICD facilities with rail connectivity — measures multimodal hub coverage for modal shift and decarbonisation planning."
    - name: "dg_certified_facility_count"
      expr: SUM(CAST(CASE WHEN dangerous_goods_certified = TRUE THEN 1 ELSE 0 END AS INT))
      comment: "Number of ICD facilities certified for dangerous goods handling — measures DG network coverage for compliance and commercial planning."
    - name: "isps_compliant_facility_count"
      expr: SUM(CAST(CASE WHEN isps_compliant = TRUE THEN 1 ELSE 0 END AS INT))
      comment: "Number of ISPS-compliant ICD facilities — tracks security compliance across the inland depot network."
$$;

CREATE OR REPLACE VIEW `vibe_shipping_ports_v1`.`_metrics`.`intermodal_rail_wagon_load`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Rail wagon load KPIs — measures TEU throughput, cargo weight, hazmat exposure, reefer utilisation, and load quality to optimise rail terminal operations and wagon utilisation."
  source: "`vibe_shipping_ports_v1`.`intermodal`.`intermodal_rail_wagon_load`"
  dimensions:
    - name: "load_status"
      expr: load_status
      comment: "Current status of the rail wagon load (planned, loaded, secured, discharged) — primary operational grouping for load performance analysis."
    - name: "customs_status"
      expr: customs_status
      comment: "Customs status of the cargo on the wagon (cleared, held, pending) — used to track customs compliance and dwell time exposure."
    - name: "is_hazardous"
      expr: is_hazardous
      comment: "Flag indicating whether the wagon load contains hazardous materials — used for DG compliance and safety segmentation."
    - name: "is_reefer"
      expr: is_reefer
      comment: "Flag indicating whether the wagon load contains refrigerated containers — used to track cold-chain rail utilisation."
    - name: "is_overweight"
      expr: is_overweight
      comment: "Flag indicating whether the wagon load is overweight — used to track regulatory compliance and infrastructure stress."
    - name: "is_oversized"
      expr: is_oversized
      comment: "Flag indicating whether the wagon load is oversized — used to track special handling requirements and clearance compliance."
    - name: "imdg_class"
      expr: imdg_class
      comment: "IMDG dangerous goods class for the wagon load — enables DG-specific performance and compliance segmentation."
    - name: "planned_load_month"
      expr: DATE_TRUNC('month', planned_load_timestamp)
      comment: "Planned load timestamp truncated to month — primary time dimension for rail wagon load volume trending."
  measures:
    - name: "total_wagon_loads"
      expr: COUNT(1)
      comment: "Total number of rail wagon loads — baseline rail throughput KPI for wagon utilisation and terminal capacity planning."
    - name: "total_teu_count"
      expr: SUM(CAST(teu_count AS DOUBLE))
      comment: "Total TEU count across all rail wagon loads — primary throughput KPI for rail intermodal capacity and revenue planning."
    - name: "total_gross_weight_kg"
      expr: SUM(CAST(gross_weight_kg AS DOUBLE))
      comment: "Total gross weight in kilograms across all rail wagon loads — measures physical throughput for track and infrastructure load planning."
    - name: "total_net_cargo_weight_kg"
      expr: SUM(CAST(net_cargo_weight_kg AS DOUBLE))
      comment: "Total net cargo weight in kilograms — measures actual cargo throughput excluding tare weight for revenue and capacity analysis."
    - name: "avg_gross_weight_kg"
      expr: AVG(CAST(gross_weight_kg AS DOUBLE))
      comment: "Average gross weight per rail wagon load — used to assess typical load profile and detect overweight trends."
    - name: "hazmat_load_count"
      expr: SUM(CAST(CASE WHEN is_hazardous = TRUE THEN 1 ELSE 0 END AS INT))
      comment: "Number of rail wagon loads containing hazardous materials — tracks DG rail exposure for safety and compliance reporting."
    - name: "reefer_load_count"
      expr: SUM(CAST(CASE WHEN is_reefer = TRUE THEN 1 ELSE 0 END AS INT))
      comment: "Number of rail wagon loads containing refrigerated containers — measures cold-chain rail demand for reefer asset planning."
    - name: "on_time_load_count"
      expr: SUM(CAST(CASE WHEN actual_load_timestamp <= planned_load_timestamp THEN 1 ELSE 0 END AS INT))
      comment: "Number of wagon loads completed on or before the planned load time — numerator for rail loading on-time performance rate."
    - name: "measurable_load_count"
      expr: SUM(CAST(CASE WHEN actual_load_timestamp IS NOT NULL AND planned_load_timestamp IS NOT NULL THEN 1 ELSE 0 END AS INT))
      comment: "Number of wagon loads with both actual and planned load timestamps — denominator for on-time loading rate."
$$;

CREATE OR REPLACE VIEW `vibe_shipping_ports_v1`.`_metrics`.`intermodal_service_subscription`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Intermodal service subscription KPIs — measures contracted TEU volume commitments, rate performance, volume utilisation, and subscription health to support commercial and revenue management decisions."
  source: "`vibe_shipping_ports_v1`.`intermodal`.`service_subscription`"
  dimensions:
    - name: "subscription_status"
      expr: subscription_status
      comment: "Current status of the service subscription (active, expired, cancelled, suspended) — primary grouping for subscription portfolio management."
    - name: "service_tier"
      expr: service_tier
      comment: "Service tier of the subscription (premium, standard, economy) — used to segment revenue and volume by commercial tier."
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level of the subscription — used to assess premium slot allocation and SLA adherence by priority."
    - name: "auto_renewal_enabled"
      expr: auto_renewal_enabled
      comment: "Flag indicating whether the subscription auto-renews — used to forecast recurring revenue and identify churn risk."
    - name: "subscription_start_month"
      expr: DATE_TRUNC('month', subscription_start_date)
      comment: "Subscription start date truncated to month — used to track subscription cohort growth and revenue pipeline."
    - name: "subscription_end_month"
      expr: DATE_TRUNC('month', subscription_end_date)
      comment: "Subscription end date truncated to month — used to forecast subscription expiry and renewal pipeline."
  measures:
    - name: "total_subscriptions"
      expr: COUNT(1)
      comment: "Total number of service subscriptions — baseline commercial portfolio KPI for intermodal revenue management."
    - name: "active_subscription_count"
      expr: SUM(CAST(CASE WHEN subscription_status = 'ACTIVE' THEN 1 ELSE 0 END AS INT))
      comment: "Number of currently active service subscriptions — measures live commercial commitments for revenue forecasting."
    - name: "avg_negotiated_rate_per_teu"
      expr: AVG(CAST(negotiated_rate_per_teu AS DOUBLE))
      comment: "Average negotiated rate per TEU across all subscriptions — key commercial KPI for yield management and rate benchmarking."
    - name: "avg_volume_commitment_pct"
      expr: AVG(CAST(volume_commitment_pct AS DOUBLE))
      comment: "Average volume commitment percentage across all subscriptions — measures how much of contracted capacity customers are committing to use."
    - name: "auto_renewal_subscription_count"
      expr: SUM(CAST(CASE WHEN auto_renewal_enabled = TRUE THEN 1 ELSE 0 END AS INT))
      comment: "Number of subscriptions with auto-renewal enabled — measures recurring revenue base stability and churn risk exposure."
$$;