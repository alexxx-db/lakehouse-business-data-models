-- Metric views for domain: intermodal | Business: Shipping_Ports | Version: 2 | Generated on: 2026-07-13 10:21:34

CREATE OR REPLACE VIEW `vibe_shipping_ports_v1`.`_metrics`.`intermodal_drayage_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic drayage operations KPIs tracking container movement efficiency, on-time performance, hazmat handling, and service quality for first/last-mile port logistics"
  source: "`vibe_shipping_ports_v1`.`intermodal`.`drayage_order`"
  dimensions:
    - name: "drayage_status"
      expr: drayage_status
      comment: "Current status of the drayage order (e.g., scheduled, in-transit, completed, cancelled)"
    - name: "drayage_type"
      expr: drayage_type
      comment: "Type of drayage movement (e.g., import, export, street turn, repositioning)"
    - name: "origin_location_type"
      expr: origin_location_type
      comment: "Type of origin location (e.g., port terminal, warehouse, rail yard, customer site)"
    - name: "destination_location_type"
      expr: destination_location_type
      comment: "Type of destination location for delivery"
    - name: "hazmat_indicator"
      expr: hazmat_indicator
      comment: "Whether the drayage order involves hazardous materials requiring special handling"
    - name: "reefer_indicator"
      expr: reefer_indicator
      comment: "Whether the container requires refrigeration"
    - name: "overweight_indicator"
      expr: overweight_indicator
      comment: "Whether the container exceeds standard weight limits"
    - name: "order_priority"
      expr: order_priority
      comment: "Priority level of the drayage order (e.g., standard, expedited, urgent)"
    - name: "proof_of_delivery_received"
      expr: proof_of_delivery_received
      comment: "Whether proof of delivery documentation has been received"
    - name: "scheduled_pickup_month"
      expr: DATE_TRUNC('MONTH', scheduled_pickup_date)
      comment: "Month of scheduled pickup for trend analysis"
    - name: "scheduled_delivery_month"
      expr: DATE_TRUNC('MONTH', scheduled_delivery_date)
      comment: "Month of scheduled delivery for trend analysis"
  measures:
    - name: "total_drayage_orders"
      expr: COUNT(1)
      comment: "Total number of drayage orders - baseline volume metric for capacity planning and demand forecasting"
    - name: "unique_containers_moved"
      expr: COUNT(DISTINCT container_id)
      comment: "Distinct containers handled - measures actual container throughput and asset utilization"
    - name: "on_time_pickup_count"
      expr: COUNT(CASE WHEN actual_pickup_timestamp <= scheduled_pickup_time_window_end THEN 1 END)
      comment: "Number of pickups completed within scheduled time window - measures carrier reliability and schedule adherence"
    - name: "on_time_delivery_count"
      expr: COUNT(CASE WHEN actual_delivery_timestamp <= scheduled_delivery_time_window_end THEN 1 END)
      comment: "Number of deliveries completed within scheduled time window - critical SLA performance indicator"
    - name: "late_pickup_count"
      expr: COUNT(CASE WHEN actual_pickup_timestamp > scheduled_pickup_time_window_end THEN 1 END)
      comment: "Number of late pickups - identifies operational bottlenecks and carrier performance issues"
    - name: "late_delivery_count"
      expr: COUNT(CASE WHEN actual_delivery_timestamp > scheduled_delivery_time_window_end THEN 1 END)
      comment: "Number of late deliveries - tracks customer service failures and potential penalty exposure"
    - name: "hazmat_order_count"
      expr: COUNT(CASE WHEN hazmat_indicator = TRUE THEN 1 END)
      comment: "Number of hazardous material orders - critical for safety compliance, resource allocation, and risk management"
    - name: "reefer_order_count"
      expr: COUNT(CASE WHEN reefer_indicator = TRUE THEN 1 END)
      comment: "Number of refrigerated container orders - tracks specialized equipment demand and cold chain capacity"
    - name: "overweight_order_count"
      expr: COUNT(CASE WHEN overweight_indicator = TRUE THEN 1 END)
      comment: "Number of overweight container orders - identifies need for specialized equipment and permits"
    - name: "cancelled_order_count"
      expr: COUNT(CASE WHEN cancellation_reason IS NOT NULL THEN 1 END)
      comment: "Number of cancelled orders - measures operational disruption and customer commitment reliability"
    - name: "failed_order_count"
      expr: COUNT(CASE WHEN failure_reason IS NOT NULL THEN 1 END)
      comment: "Number of failed drayage attempts - critical quality metric for root cause analysis and process improvement"
    - name: "total_verified_gross_mass_kg"
      expr: SUM(CAST(verified_gross_mass_kg AS DOUBLE))
      comment: "Total verified gross mass in kilograms - measures cargo weight throughput for capacity planning and safety compliance"
    - name: "avg_verified_gross_mass_kg"
      expr: AVG(CAST(verified_gross_mass_kg AS DOUBLE))
      comment: "Average verified gross mass per order - identifies typical load characteristics and equipment requirements"
$$;

CREATE OR REPLACE VIEW `vibe_shipping_ports_v1`.`_metrics`.`intermodal_truck_appointment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Gate appointment system performance KPIs measuring slot utilization, no-show rates, appointment compliance, and terminal access efficiency to optimize truck turn times"
  source: "`vibe_shipping_ports_v1`.`intermodal`.`truck_appointment`"
  dimensions:
    - name: "appointment_status"
      expr: appointment_status
      comment: "Current status of the truck appointment (e.g., scheduled, confirmed, completed, cancelled, no-show)"
    - name: "appointment_type"
      expr: appointment_type
      comment: "Type of appointment (e.g., import pickup, export drop-off, empty return, dual transaction)"
    - name: "booking_channel"
      expr: booking_channel
      comment: "Channel through which appointment was booked (e.g., web portal, EDI, mobile app, phone)"
    - name: "no_show_flag"
      expr: no_show_flag
      comment: "Whether the truck failed to arrive for the scheduled appointment"
    - name: "is_hazardous"
      expr: is_hazardous
      comment: "Whether the appointment involves hazardous cargo"
    - name: "is_reefer"
      expr: is_reefer
      comment: "Whether the appointment involves refrigerated containers"
    - name: "is_oversized"
      expr: is_oversized
      comment: "Whether the cargo is oversized requiring special handling"
    - name: "is_overweight"
      expr: is_overweight
      comment: "Whether the cargo exceeds standard weight limits"
    - name: "transport_mode"
      expr: transport_mode
      comment: "Mode of transport for the appointment"
    - name: "vehicle_type"
      expr: vehicle_type
      comment: "Type of vehicle scheduled for the appointment"
    - name: "requested_slot_month"
      expr: DATE_TRUNC('MONTH', requested_slot_start_time)
      comment: "Month of requested appointment slot for demand pattern analysis"
    - name: "confirmed_slot_month"
      expr: DATE_TRUNC('MONTH', confirmed_slot_start_time)
      comment: "Month of confirmed appointment slot for capacity allocation tracking"
  measures:
    - name: "total_appointments"
      expr: COUNT(1)
      comment: "Total number of truck appointments - baseline metric for gate capacity planning and demand forecasting"
    - name: "completed_appointments"
      expr: COUNT(CASE WHEN appointment_status = 'completed' THEN 1 END)
      comment: "Number of successfully completed appointments - measures actual gate throughput and service delivery"
    - name: "no_show_appointments"
      expr: COUNT(CASE WHEN no_show_flag = TRUE THEN 1 END)
      comment: "Number of no-show appointments - critical metric for slot utilization loss and capacity waste"
    - name: "cancelled_appointments"
      expr: COUNT(CASE WHEN appointment_status = 'cancelled' THEN 1 END)
      comment: "Number of cancelled appointments - measures schedule volatility and planning reliability"
    - name: "hazmat_appointments"
      expr: COUNT(CASE WHEN is_hazardous = TRUE THEN 1 END)
      comment: "Number of hazardous cargo appointments - critical for safety resource allocation and compliance planning"
    - name: "reefer_appointments"
      expr: COUNT(CASE WHEN is_reefer = TRUE THEN 1 END)
      comment: "Number of refrigerated container appointments - tracks cold chain capacity demand"
    - name: "oversized_appointments"
      expr: COUNT(CASE WHEN is_oversized = TRUE THEN 1 END)
      comment: "Number of oversized cargo appointments - identifies need for specialized handling resources"
    - name: "overweight_appointments"
      expr: COUNT(CASE WHEN is_overweight = TRUE THEN 1 END)
      comment: "Number of overweight cargo appointments - tracks heavy lift equipment demand"
    - name: "total_teu_scheduled"
      expr: SUM(CAST(teu_quantity AS DOUBLE))
      comment: "Total TEU scheduled through appointments - measures planned container throughput capacity"
    - name: "avg_teu_per_appointment"
      expr: AVG(CAST(teu_quantity AS DOUBLE))
      comment: "Average TEU per appointment - identifies typical transaction size for resource planning"
    - name: "total_cargo_weight_kg"
      expr: SUM(CAST(cargo_weight_kg AS DOUBLE))
      comment: "Total cargo weight scheduled in kilograms - measures weight throughput for infrastructure stress analysis"
    - name: "avg_cargo_weight_kg"
      expr: AVG(CAST(cargo_weight_kg AS DOUBLE))
      comment: "Average cargo weight per appointment - identifies typical load characteristics"
$$;

CREATE OR REPLACE VIEW `vibe_shipping_ports_v1`.`_metrics`.`intermodal_truck_visit`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Actual truck gate transaction performance KPIs measuring turnaround time, gate efficiency, security compliance, and operational throughput for terminal access optimization"
  source: "`vibe_shipping_ports_v1`.`intermodal`.`truck_visit`"
  dimensions:
    - name: "visit_type"
      expr: visit_type
      comment: "Type of truck visit (e.g., import pickup, export delivery, empty return, dual transaction)"
    - name: "transaction_status"
      expr: transaction_status
      comment: "Status of the gate transaction (e.g., completed, rejected, in-progress)"
    - name: "damage_report_indicator"
      expr: damage_report_indicator
      comment: "Whether damage was reported during the visit"
    - name: "isps_compliance_check_result"
      expr: isps_compliance_check_result
      comment: "Result of International Ship and Port Facility Security compliance check"
    - name: "seal_verification_status"
      expr: seal_verification_status
      comment: "Status of container seal verification (e.g., verified, broken, missing)"
    - name: "driver_verification_method"
      expr: driver_verification_method
      comment: "Method used to verify driver identity (e.g., biometric, ID card, license scan)"
    - name: "container_condition"
      expr: container_condition
      comment: "Condition of container at gate (e.g., good, damaged, requires inspection)"
    - name: "gate_in_month"
      expr: DATE_TRUNC('MONTH', gate_in_time)
      comment: "Month of gate entry for throughput trend analysis"
  measures:
    - name: "total_truck_visits"
      expr: COUNT(1)
      comment: "Total number of truck visits - baseline metric for actual gate throughput and terminal utilization"
    - name: "completed_visits"
      expr: COUNT(CASE WHEN transaction_status = 'completed' THEN 1 END)
      comment: "Number of successfully completed visits - measures operational efficiency and service delivery"
    - name: "rejected_visits"
      expr: COUNT(CASE WHEN transaction_status = 'rejected' THEN 1 END)
      comment: "Number of rejected visits - critical quality metric identifying documentation, compliance, or operational issues"
    - name: "visits_with_damage"
      expr: COUNT(CASE WHEN damage_report_indicator = TRUE THEN 1 END)
      comment: "Number of visits with damage reports - measures cargo handling quality and potential liability exposure"
    - name: "isps_compliance_failures"
      expr: COUNT(CASE WHEN isps_compliance_check_result = 'failed' THEN 1 END)
      comment: "Number of ISPS compliance check failures - critical security metric for regulatory compliance and risk management"
    - name: "seal_verification_failures"
      expr: COUNT(CASE WHEN seal_verification_status IN ('broken', 'missing', 'tampered') THEN 1 END)
      comment: "Number of seal verification failures - security and cargo integrity metric for customs and supply chain security"
    - name: "avg_ocr_confidence_score"
      expr: AVG(CAST(ocr_confidence_score AS DOUBLE))
      comment: "Average OCR confidence score for automated container number recognition - measures gate automation effectiveness"
    - name: "avg_gate_lane_number"
      expr: AVG(CAST(gate_lane_number AS DOUBLE))
      comment: "Average gate lane number used - identifies lane utilization patterns for capacity balancing"
$$;

CREATE OR REPLACE VIEW `vibe_shipping_ports_v1`.`_metrics`.`intermodal_rail_visit`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Rail terminal operations KPIs tracking train visit efficiency, container interchange volumes, on-time performance, and rail-port connectivity for intermodal supply chain optimization"
  source: "`vibe_shipping_ports_v1`.`intermodal`.`rail_visit`"
  dimensions:
    - name: "visit_status"
      expr: visit_status
      comment: "Current status of the rail visit (e.g., scheduled, arrived, in-progress, completed, departed)"
    - name: "visit_type"
      expr: visit_type
      comment: "Type of rail visit (e.g., import, export, domestic, mixed)"
    - name: "service_type"
      expr: service_type
      comment: "Type of rail service (e.g., unit train, manifest, intermodal shuttle)"
    - name: "hazmat_indicator"
      expr: hazmat_indicator
      comment: "Whether the rail visit involves hazardous materials"
    - name: "billing_status"
      expr: billing_status
      comment: "Billing status of the rail visit (e.g., pending, invoiced, paid, disputed)"
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level of the rail visit for scheduling and resource allocation"
    - name: "scheduled_arrival_month"
      expr: DATE_TRUNC('MONTH', scheduled_arrival_time)
      comment: "Month of scheduled arrival for capacity planning and trend analysis"
    - name: "actual_arrival_month"
      expr: DATE_TRUNC('MONTH', actual_arrival_time)
      comment: "Month of actual arrival for performance tracking"
  measures:
    - name: "total_rail_visits"
      expr: COUNT(1)
      comment: "Total number of rail visits - baseline metric for rail terminal capacity utilization and demand forecasting"
    - name: "completed_rail_visits"
      expr: COUNT(CASE WHEN visit_status = 'completed' THEN 1 END)
      comment: "Number of completed rail visits - measures operational throughput and service delivery"
    - name: "on_time_arrivals"
      expr: COUNT(CASE WHEN actual_arrival_time <= scheduled_arrival_time THEN 1 END)
      comment: "Number of on-time rail arrivals - critical metric for schedule reliability and terminal planning"
    - name: "late_arrivals"
      expr: COUNT(CASE WHEN actual_arrival_time > scheduled_arrival_time THEN 1 END)
      comment: "Number of late rail arrivals - identifies schedule disruptions and capacity planning challenges"
    - name: "on_time_departures"
      expr: COUNT(CASE WHEN actual_departure_time <= scheduled_departure_time THEN 1 END)
      comment: "Number of on-time rail departures - measures terminal efficiency and downstream network reliability"
    - name: "hazmat_rail_visits"
      expr: COUNT(CASE WHEN hazmat_indicator = TRUE THEN 1 END)
      comment: "Number of rail visits with hazardous materials - critical for safety compliance and resource allocation"
    - name: "total_train_weight_tonnes"
      expr: SUM(CAST(train_weight_tonnes AS DOUBLE))
      comment: "Total train weight in tonnes - measures rail infrastructure load and capacity utilization"
    - name: "avg_train_weight_tonnes"
      expr: AVG(CAST(train_weight_tonnes AS DOUBLE))
      comment: "Average train weight per visit - identifies typical load characteristics for infrastructure planning"
    - name: "total_train_length_meters"
      expr: SUM(CAST(train_length_meters AS DOUBLE))
      comment: "Total train length in meters - measures track capacity requirements"
    - name: "avg_train_length_meters"
      expr: AVG(CAST(train_length_meters AS DOUBLE))
      comment: "Average train length per visit - identifies typical consist size for track allocation planning"
$$;

CREATE OR REPLACE VIEW `vibe_shipping_ports_v1`.`_metrics`.`intermodal_transport_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "End-to-end intermodal transport order KPIs measuring multimodal coordination efficiency, on-time delivery performance, hazmat handling, and supply chain execution quality"
  source: "`vibe_shipping_ports_v1`.`intermodal`.`transport_order`"
  dimensions:
    - name: "order_status"
      expr: order_status
      comment: "Current status of the transport order (e.g., booked, in-transit, delivered, cancelled)"
    - name: "primary_transport_mode"
      expr: primary_transport_mode
      comment: "Primary mode of transport (e.g., truck, rail, barge, multimodal)"
    - name: "transport_mode_sequence"
      expr: transport_mode_sequence
      comment: "Sequence of transport modes used in the multimodal journey"
    - name: "is_hazardous"
      expr: is_hazardous
      comment: "Whether the transport order involves hazardous cargo"
    - name: "is_refrigerated"
      expr: is_refrigerated
      comment: "Whether the transport order requires refrigeration"
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level of the transport order (e.g., standard, expedited, urgent)"
    - name: "order_month"
      expr: DATE_TRUNC('MONTH', order_date)
      comment: "Month of order placement for demand trend analysis"
    - name: "required_delivery_month"
      expr: DATE_TRUNC('MONTH', required_delivery_date)
      comment: "Month of required delivery for capacity planning"
  measures:
    - name: "total_transport_orders"
      expr: COUNT(1)
      comment: "Total number of transport orders - baseline metric for intermodal business volume and demand forecasting"
    - name: "delivered_orders"
      expr: COUNT(CASE WHEN order_status = 'delivered' THEN 1 END)
      comment: "Number of delivered orders - measures successful order completion and service delivery"
    - name: "cancelled_orders"
      expr: COUNT(CASE WHEN order_status = 'cancelled' THEN 1 END)
      comment: "Number of cancelled orders - measures customer commitment reliability and operational disruption"
    - name: "on_time_deliveries"
      expr: COUNT(CASE WHEN actual_delivery_date <= estimated_delivery_date THEN 1 END)
      comment: "Number of on-time deliveries - critical SLA performance metric for customer satisfaction"
    - name: "late_deliveries"
      expr: COUNT(CASE WHEN actual_delivery_date > estimated_delivery_date THEN 1 END)
      comment: "Number of late deliveries - identifies service failures and potential penalty exposure"
    - name: "hazardous_orders"
      expr: COUNT(CASE WHEN is_hazardous = TRUE THEN 1 END)
      comment: "Number of hazardous cargo orders - critical for safety compliance, insurance, and risk management"
    - name: "refrigerated_orders"
      expr: COUNT(CASE WHEN is_refrigerated = TRUE THEN 1 END)
      comment: "Number of refrigerated orders - tracks cold chain capacity demand and specialized equipment utilization"
    - name: "total_cargo_weight_kg"
      expr: SUM(CAST(cargo_weight_kg AS DOUBLE))
      comment: "Total cargo weight in kilograms - measures weight throughput for capacity planning and pricing"
    - name: "avg_cargo_weight_kg"
      expr: AVG(CAST(cargo_weight_kg AS DOUBLE))
      comment: "Average cargo weight per order - identifies typical shipment characteristics"
    - name: "total_cargo_volume_cbm"
      expr: SUM(CAST(cargo_volume_cbm AS DOUBLE))
      comment: "Total cargo volume in cubic meters - measures volumetric capacity utilization"
    - name: "avg_cargo_volume_cbm"
      expr: AVG(CAST(cargo_volume_cbm AS DOUBLE))
      comment: "Average cargo volume per order - identifies space utilization patterns"
    - name: "total_teu_count"
      expr: SUM(CAST(teu_count AS DOUBLE))
      comment: "Total TEU count across all transport orders - measures containerized cargo throughput"
    - name: "avg_teu_per_order"
      expr: AVG(CAST(teu_count AS DOUBLE))
      comment: "Average TEU per transport order - identifies typical order size for resource planning"
$$;

CREATE OR REPLACE VIEW `vibe_shipping_ports_v1`.`_metrics`.`intermodal_icd_facility`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Inland Container Depot facility performance KPIs measuring operational capacity, service availability, connectivity, and compliance for hinterland logistics optimization"
  source: "`vibe_shipping_ports_v1`.`intermodal`.`icd_facility`"
  dimensions:
    - name: "operational_status"
      expr: operational_status
      comment: "Current operational status of the ICD facility (e.g., active, inactive, under maintenance)"
    - name: "facility_type"
      expr: facility_type
      comment: "Type of ICD facility (e.g., dry port, CFS, bonded warehouse)"
    - name: "customs_bonded_facility"
      expr: customs_bonded_facility
      comment: "Whether the facility is a customs bonded facility"
    - name: "dangerous_goods_certified"
      expr: dangerous_goods_certified
      comment: "Whether the facility is certified to handle dangerous goods"
    - name: "isps_compliant"
      expr: isps_compliant
      comment: "Whether the facility is ISPS compliant for security"
    - name: "rail_connectivity"
      expr: rail_connectivity
      comment: "Whether the facility has rail connectivity"
    - name: "fcl_service_available"
      expr: fcl_service_available
      comment: "Whether full container load service is available"
    - name: "lcl_service_available"
      expr: lcl_service_available
      comment: "Whether less than container load service is available"
    - name: "twenty_four_seven_operations"
      expr: twenty_four_seven_operations
      comment: "Whether the facility operates 24/7"
    - name: "edi_connectivity_status"
      expr: edi_connectivity_status
      comment: "Status of EDI connectivity for digital integration"
  measures:
    - name: "total_icd_facilities"
      expr: COUNT(1)
      comment: "Total number of ICD facilities - measures network coverage and hinterland connectivity"
    - name: "active_facilities"
      expr: COUNT(CASE WHEN operational_status = 'active' THEN 1 END)
      comment: "Number of active ICD facilities - measures available capacity in the inland network"
    - name: "customs_bonded_facilities"
      expr: COUNT(CASE WHEN customs_bonded_facility = TRUE THEN 1 END)
      comment: "Number of customs bonded facilities - critical for duty deferral and trade facilitation"
    - name: "dangerous_goods_certified_facilities"
      expr: COUNT(CASE WHEN dangerous_goods_certified = TRUE THEN 1 END)
      comment: "Number of facilities certified for dangerous goods - measures hazmat handling capacity"
    - name: "isps_compliant_facilities"
      expr: COUNT(CASE WHEN isps_compliant = TRUE THEN 1 END)
      comment: "Number of ISPS compliant facilities - measures security compliance across the network"
    - name: "rail_connected_facilities"
      expr: COUNT(CASE WHEN rail_connectivity = TRUE THEN 1 END)
      comment: "Number of facilities with rail connectivity - measures multimodal capability and efficiency potential"
    - name: "twenty_four_seven_facilities"
      expr: COUNT(CASE WHEN twenty_four_seven_operations = TRUE THEN 1 END)
      comment: "Number of 24/7 operational facilities - measures extended service availability for time-sensitive cargo"
    - name: "avg_distance_from_port_km"
      expr: AVG(CAST(distance_from_port_km AS DOUBLE))
      comment: "Average distance from port in kilometers - measures hinterland reach and last-mile efficiency"
    - name: "avg_drayage_time_hours"
      expr: AVG(CAST(average_drayage_time_hours AS DOUBLE))
      comment: "Average drayage time in hours - critical metric for supply chain velocity and cost optimization"
$$;

CREATE OR REPLACE VIEW `vibe_shipping_ports_v1`.`_metrics`.`intermodal_haulier`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Haulier carrier performance and network KPIs measuring carrier capacity, service quality, compliance status, and operational readiness for drayage operations management"
  source: "`vibe_shipping_ports_v1`.`intermodal`.`haulier`"
  dimensions:
    - name: "haulier_status"
      expr: haulier_status
      comment: "Current status of the haulier (e.g., active, suspended, terminated, onboarding)"
    - name: "operator_type"
      expr: operator_type
      comment: "Type of haulier operator (e.g., owner-operator, fleet operator, broker)"
    - name: "transport_mode"
      expr: transport_mode
      comment: "Primary transport mode offered by the haulier"
    - name: "onboarding_year"
      expr: YEAR(onboarding_date)
      comment: "Year the haulier was onboarded for network growth analysis"
    - name: "last_service_month"
      expr: DATE_TRUNC('MONTH', last_service_date)
      comment: "Month of last service for activity tracking"
  measures:
    - name: "total_hauliers"
      expr: COUNT(1)
      comment: "Total number of hauliers - measures carrier network size and capacity pool"
    - name: "active_hauliers"
      expr: COUNT(CASE WHEN haulier_status = 'active' THEN 1 END)
      comment: "Number of active hauliers - measures available carrier capacity for operations"
    - name: "suspended_hauliers"
      expr: COUNT(CASE WHEN haulier_status = 'suspended' THEN 1 END)
      comment: "Number of suspended hauliers - identifies compliance or performance issues requiring intervention"
    - name: "terminated_hauliers"
      expr: COUNT(CASE WHEN haulier_status = 'terminated' THEN 1 END)
      comment: "Number of terminated hauliers - measures carrier attrition and network stability"
$$;

CREATE OR REPLACE VIEW `vibe_shipping_ports_v1`.`_metrics`.`intermodal_service`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Intermodal service product KPIs measuring service availability, capacity, transit time performance, and special handling capabilities for network design and customer offering optimization"
  source: "`vibe_shipping_ports_v1`.`intermodal`.`service`"
  dimensions:
    - name: "service_status"
      expr: service_status
      comment: "Current status of the service (e.g., active, suspended, discontinued)"
    - name: "service_type"
      expr: service_type
      comment: "Type of intermodal service (e.g., door-to-door, port-to-door, rail shuttle)"
    - name: "transport_mode"
      expr: transport_mode
      comment: "Primary transport mode for the service"
    - name: "dangerous_goods_allowed"
      expr: dangerous_goods_allowed
      comment: "Whether the service allows dangerous goods"
    - name: "reefer_capable"
      expr: reefer_capable
      comment: "Whether the service can handle refrigerated cargo"
    - name: "oversize_cargo_allowed"
      expr: oversize_cargo_allowed
      comment: "Whether the service allows oversized cargo"
    - name: "customs_clearance_supported"
      expr: customs_clearance_supported
      comment: "Whether the service includes customs clearance support"
    - name: "edi_enabled"
      expr: edi_enabled
      comment: "Whether the service supports EDI integration"
    - name: "frequency"
      expr: frequency
      comment: "Service frequency (e.g., daily, weekly, on-demand)"
  measures:
    - name: "total_services"
      expr: COUNT(1)
      comment: "Total number of intermodal services - measures service portfolio breadth and customer offering"
    - name: "active_services"
      expr: COUNT(CASE WHEN service_status = 'active' THEN 1 END)
      comment: "Number of active services - measures available service capacity and network coverage"
    - name: "dangerous_goods_services"
      expr: COUNT(CASE WHEN dangerous_goods_allowed = TRUE THEN 1 END)
      comment: "Number of services allowing dangerous goods - measures hazmat handling capability"
    - name: "reefer_capable_services"
      expr: COUNT(CASE WHEN reefer_capable = TRUE THEN 1 END)
      comment: "Number of reefer-capable services - measures cold chain service availability"
    - name: "oversize_capable_services"
      expr: COUNT(CASE WHEN oversize_cargo_allowed = TRUE THEN 1 END)
      comment: "Number of services allowing oversized cargo - measures specialized handling capability"
    - name: "customs_clearance_services"
      expr: COUNT(CASE WHEN customs_clearance_supported = TRUE THEN 1 END)
      comment: "Number of services with customs clearance support - measures trade facilitation capability"
    - name: "edi_enabled_services"
      expr: COUNT(CASE WHEN edi_enabled = TRUE THEN 1 END)
      comment: "Number of EDI-enabled services - measures digital integration maturity"
    - name: "avg_transit_time_hours"
      expr: AVG(CAST(transit_time_hours AS DOUBLE))
      comment: "Average transit time in hours - critical metric for service speed and competitiveness"
    - name: "avg_route_distance_km"
      expr: AVG(CAST(route_distance_km AS DOUBLE))
      comment: "Average route distance in kilometers - measures service reach and network coverage"
$$;