-- Metric views for domain: cargo | Business: Shipping_Ports | Version: 2 | Generated on: 2026-07-13 10:21:34

CREATE OR REPLACE VIEW `vibe_shipping_ports_v1`.`_metrics`.`cargo_container`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Container utilization, capacity, and operational efficiency metrics for terminal and vessel planning"
  source: "`vibe_shipping_ports_v1`.`cargo`.`container`"
  dimensions:
    - name: "container_status"
      expr: container_status
      comment: "Current operational status of the container (e.g., in-yard, on-vessel, gate-out)"
    - name: "container_type"
      expr: container_type_id
      comment: "Type classification of container (standard, reefer, tank, etc.)"
    - name: "is_hazmat"
      expr: is_hazmat
      comment: "Flag indicating whether container carries hazardous materials requiring special handling"
    - name: "is_reefer"
      expr: is_reefer
      comment: "Flag indicating refrigerated container requiring power and temperature monitoring"
    - name: "is_oversize"
      expr: is_oversize
      comment: "Flag indicating oversized cargo requiring special handling equipment"
    - name: "is_overweight"
      expr: is_overweight
      comment: "Flag indicating container exceeds standard weight limits"
    - name: "condition_grade"
      expr: condition_grade
      comment: "Physical condition assessment grade of the container"
    - name: "gate_in_date"
      expr: DATE(gate_in_timestamp)
      comment: "Date container entered the terminal facility"
    - name: "gate_out_date"
      expr: DATE(gate_out_timestamp)
      comment: "Date container exited the terminal facility"
    - name: "shipping_line"
      expr: shipping_line_id
      comment: "Shipping line owning or operating the container"
    - name: "current_port_location"
      expr: port_location_id
      comment: "Current port location of the container"
    - name: "terminal_zone"
      expr: terminal_zone_id
      comment: "Terminal zone where container is currently stored"
  measures:
    - name: "total_containers"
      expr: COUNT(DISTINCT container_id)
      comment: "Distinct count of containers for capacity and throughput analysis"
    - name: "total_teu_capacity"
      expr: SUM(CAST(size_teu AS DOUBLE))
      comment: "Total twenty-foot equivalent units representing standardized container capacity"
    - name: "avg_teu_per_container"
      expr: AVG(CAST(size_teu AS DOUBLE))
      comment: "Average TEU size per container for capacity planning"
    - name: "total_cubic_capacity_cbm"
      expr: SUM(CAST(cubic_capacity_cbm AS DOUBLE))
      comment: "Total cubic capacity in cubic meters for volume-based planning"
    - name: "total_max_payload_kg"
      expr: SUM(CAST(max_payload_kg AS DOUBLE))
      comment: "Total maximum payload capacity across all containers in kilograms"
    - name: "avg_max_payload_kg"
      expr: AVG(CAST(max_payload_kg AS DOUBLE))
      comment: "Average maximum payload capacity per container for load planning"
    - name: "total_tare_weight_kg"
      expr: SUM(CAST(tare_weight_kg AS DOUBLE))
      comment: "Total tare weight of empty containers for weight calculations"
    - name: "hazmat_container_count"
      expr: COUNT(DISTINCT CASE WHEN is_hazmat = TRUE THEN container_id END)
      comment: "Count of hazardous material containers requiring special handling and segregation"
    - name: "reefer_container_count"
      expr: COUNT(DISTINCT CASE WHEN is_reefer = TRUE THEN container_id END)
      comment: "Count of refrigerated containers requiring power supply and monitoring"
    - name: "oversize_container_count"
      expr: COUNT(DISTINCT CASE WHEN is_oversize = TRUE THEN container_id END)
      comment: "Count of oversized containers requiring special handling equipment"
    - name: "overweight_container_count"
      expr: COUNT(DISTINCT CASE WHEN is_overweight = TRUE THEN container_id END)
      comment: "Count of overweight containers requiring weight compliance verification"
    - name: "hazmat_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN is_hazmat = TRUE THEN container_id END) / NULLIF(COUNT(DISTINCT container_id), 0), 2)
      comment: "Percentage of containers carrying hazardous materials for risk and capacity planning"
    - name: "reefer_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN is_reefer = TRUE THEN container_id END) / NULLIF(COUNT(DISTINCT container_id), 0), 2)
      comment: "Percentage of refrigerated containers for power infrastructure planning"
$$;


CREATE OR REPLACE VIEW `vibe_shipping_ports_v1`.`_metrics`.`cargo_shipment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Shipment volume, value, and operational performance metrics for trade and logistics analysis"
  source: "`vibe_shipping_ports_v1`.`cargo`.`shipment`"
  dimensions:
    - name: "shipment_status"
      expr: shipment_status
      comment: "Current operational status of the shipment in the logistics chain"
    - name: "cargo_type"
      expr: cargo_type
      comment: "Type classification of cargo (FCL, LCL, bulk, breakbulk)"
    - name: "is_transshipment"
      expr: is_transshipment
      comment: "Flag indicating shipment is transshipping through this port to another destination"
    - name: "is_dangerous_goods"
      expr: is_dangerous_goods
      comment: "Flag indicating shipment contains dangerous goods requiring special handling"
    - name: "is_reefer"
      expr: is_reefer
      comment: "Flag indicating refrigerated cargo requiring temperature control"
    - name: "is_oversized"
      expr: is_oversized
      comment: "Flag indicating oversized cargo requiring special handling"
    - name: "freight_terms"
      expr: freight_terms
      comment: "Freight payment terms (prepaid, collect, etc.)"
    - name: "incoterm"
      expr: incoterm
      comment: "International commercial terms defining buyer/seller responsibilities"
    - name: "shipping_line"
      expr: shipping_line_id
      comment: "Shipping line handling the shipment"
    - name: "discharge_date"
      expr: discharge_date
      comment: "Date cargo was discharged from vessel"
    - name: "gate_out_date"
      expr: gate_out_date
      comment: "Date cargo exited the terminal"
    - name: "pol_port_location"
      expr: port_location_id
      comment: "Port of loading location"
    - name: "commodity_code"
      expr: commodity_code_id
      comment: "Commodity classification code"
  measures:
    - name: "total_shipments"
      expr: COUNT(DISTINCT shipment_id)
      comment: "Distinct count of shipments for throughput and volume analysis"
    - name: "total_teu"
      expr: SUM(CAST(teu_count AS DOUBLE))
      comment: "Total twenty-foot equivalent units for standardized container volume measurement"
    - name: "total_feu"
      expr: SUM(CAST(feu_count AS DOUBLE))
      comment: "Total forty-foot equivalent units for large container volume measurement"
    - name: "avg_teu_per_shipment"
      expr: AVG(CAST(teu_count AS DOUBLE))
      comment: "Average TEU per shipment for capacity planning and vessel utilization"
    - name: "total_gross_weight_mt"
      expr: SUM(CAST(gross_weight_mt AS DOUBLE))
      comment: "Total gross weight in metric tons for infrastructure and equipment planning"
    - name: "total_net_weight_mt"
      expr: SUM(CAST(net_weight_mt AS DOUBLE))
      comment: "Total net cargo weight in metric tons excluding packaging and container tare"
    - name: "avg_gross_weight_mt"
      expr: AVG(CAST(gross_weight_mt AS DOUBLE))
      comment: "Average gross weight per shipment for load planning"
    - name: "total_volume_cbm"
      expr: SUM(CAST(volume_cbm AS DOUBLE))
      comment: "Total cargo volume in cubic meters for space utilization analysis"
    - name: "total_declared_value_usd"
      expr: SUM(CAST(declared_value_usd AS DOUBLE))
      comment: "Total declared cargo value in USD for trade value and insurance analysis"
    - name: "avg_declared_value_usd"
      expr: AVG(CAST(declared_value_usd AS DOUBLE))
      comment: "Average declared value per shipment for cargo value profiling"
    - name: "transshipment_count"
      expr: COUNT(DISTINCT CASE WHEN is_transshipment = TRUE THEN shipment_id END)
      comment: "Count of transshipment cargo for hub port performance analysis"
    - name: "transshipment_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN is_transshipment = TRUE THEN shipment_id END) / NULLIF(COUNT(DISTINCT shipment_id), 0), 2)
      comment: "Percentage of transshipment cargo indicating hub port role and connectivity"
    - name: "dangerous_goods_count"
      expr: COUNT(DISTINCT CASE WHEN is_dangerous_goods = TRUE THEN shipment_id END)
      comment: "Count of dangerous goods shipments for safety and compliance monitoring"
    - name: "reefer_shipment_count"
      expr: COUNT(DISTINCT CASE WHEN is_reefer = TRUE THEN shipment_id END)
      comment: "Count of refrigerated shipments for cold chain infrastructure planning"
$$;


CREATE OR REPLACE VIEW `vibe_shipping_ports_v1`.`_metrics`.`cargo_demurrage_detention`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Demurrage and detention charge metrics for free-time compliance, revenue recovery, and customer service analysis"
  source: "`vibe_shipping_ports_v1`.`cargo`.`demurrage_detention`"
  dimensions:
    - name: "charge_type"
      expr: charge_type
      comment: "Type of charge (demurrage for port storage, detention for container usage)"
    - name: "charge_status"
      expr: charge_status
      comment: "Current status of the charge (pending, invoiced, paid, waived)"
    - name: "settlement_status"
      expr: settlement_status
      comment: "Settlement status indicating payment resolution"
    - name: "cargo_type"
      expr: cargo_type
      comment: "Type of cargo incurring the charge"
    - name: "dispute_flag"
      expr: dispute_flag
      comment: "Flag indicating customer has disputed the charge"
    - name: "calculation_method"
      expr: calculation_method
      comment: "Method used to calculate the charge (daily, tiered, flat)"
    - name: "shipping_line"
      expr: shipping_line_id
      comment: "Shipping line to whom charges are owed or who owes charges"
    - name: "invoice_date"
      expr: invoice_date
      comment: "Date charge was invoiced"
    - name: "payment_due_date"
      expr: payment_due_date
      comment: "Date payment is due"
    - name: "payment_received_date"
      expr: payment_received_date
      comment: "Date payment was received"
    - name: "dispute_raised_date"
      expr: dispute_raised_date
      comment: "Date dispute was raised by customer"
  measures:
    - name: "total_charge_events"
      expr: COUNT(DISTINCT demurrage_detention_id)
      comment: "Distinct count of demurrage/detention charge events for volume analysis"
    - name: "total_charge_amount"
      expr: SUM(CAST(total_charge_amount AS DOUBLE))
      comment: "Total demurrage and detention charges billed for revenue and cost recovery analysis"
    - name: "total_net_charge_amount"
      expr: SUM(CAST(net_charge_amount AS DOUBLE))
      comment: "Total net charges after waivers and adjustments for actual revenue recognition"
    - name: "total_waiver_amount"
      expr: SUM(CAST(waiver_amount AS DOUBLE))
      comment: "Total amount waived due to disputes, goodwill, or policy exceptions"
    - name: "avg_charge_amount"
      expr: AVG(CAST(total_charge_amount AS DOUBLE))
      comment: "Average charge per event for pricing and customer impact analysis"
    - name: "avg_daily_rate"
      expr: AVG(CAST(daily_rate_amount AS DOUBLE))
      comment: "Average daily rate charged for demurrage or detention"
    - name: "total_days_exceeded"
      expr: SUM(CAST(days_exceeded AS DOUBLE))
      comment: "Total days beyond free time across all charges indicating dwell time issues"
    - name: "avg_days_exceeded"
      expr: AVG(CAST(days_exceeded AS DOUBLE))
      comment: "Average days beyond free time per charge for operational efficiency analysis"
    - name: "avg_free_time_days"
      expr: AVG(CAST(free_time_days AS DOUBLE))
      comment: "Average free time allowed before charges begin"
    - name: "disputed_charge_count"
      expr: COUNT(DISTINCT CASE WHEN dispute_flag = TRUE THEN demurrage_detention_id END)
      comment: "Count of disputed charges for customer service and policy review"
    - name: "dispute_rate_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN dispute_flag = TRUE THEN demurrage_detention_id END) / NULLIF(COUNT(DISTINCT demurrage_detention_id), 0), 2)
      comment: "Percentage of charges disputed indicating customer satisfaction and policy fairness"
    - name: "waiver_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(waiver_amount AS DOUBLE)) / NULLIF(SUM(CAST(total_charge_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of charges waived indicating revenue leakage and policy effectiveness"
$$;


CREATE OR REPLACE VIEW `vibe_shipping_ports_v1`.`_metrics`.`cargo_handling_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Terminal handling productivity, equipment utilization, and operational efficiency metrics for vessel and cargo operations"
  source: "`vibe_shipping_ports_v1`.`cargo`.`handling_order`"
  dimensions:
    - name: "order_status"
      expr: order_status
      comment: "Current status of the handling order (planned, in-progress, completed, cancelled)"
    - name: "operation_type"
      expr: operation_type
      comment: "Type of handling operation (loading, discharge, restow, shifting)"
    - name: "billing_status"
      expr: billing_status
      comment: "Billing status of the handling order"
    - name: "dangerous_goods_flag"
      expr: dangerous_goods_flag
      comment: "Flag indicating handling of dangerous goods requiring special procedures"
    - name: "reefer_cargo_flag"
      expr: reefer_cargo_flag
      comment: "Flag indicating handling of refrigerated cargo"
    - name: "oversized_cargo_flag"
      expr: oversized_cargo_flag
      comment: "Flag indicating handling of oversized cargo"
    - name: "customs_hold_flag"
      expr: customs_hold_flag
      comment: "Flag indicating cargo is under customs hold affecting handling"
    - name: "thc_applicable_flag"
      expr: thc_applicable_flag
      comment: "Flag indicating terminal handling charges are applicable"
    - name: "planned_start_date"
      expr: DATE(planned_start_datetime)
      comment: "Planned start date of handling operation"
    - name: "actual_start_date"
      expr: DATE(actual_start_datetime)
      comment: "Actual start date of handling operation"
    - name: "actual_end_date"
      expr: DATE(actual_end_datetime)
      comment: "Actual end date of handling operation"
    - name: "shipping_line"
      expr: shipping_line_id
      comment: "Shipping line for whom handling is performed"
    - name: "berth"
      expr: berth_id
      comment: "Berth where handling operation is performed"
    - name: "terminal_zone"
      expr: terminal_zone_id
      comment: "Terminal zone involved in handling operation"
  measures:
    - name: "total_handling_orders"
      expr: COUNT(DISTINCT handling_order_id)
      comment: "Distinct count of handling orders for operational volume analysis"
    - name: "total_moves_planned"
      expr: SUM(CAST(total_moves_planned AS DOUBLE))
      comment: "Total planned container moves for capacity and resource planning"
    - name: "total_moves_completed"
      expr: SUM(CAST(total_moves_completed AS DOUBLE))
      comment: "Total completed container moves for productivity measurement"
    - name: "total_teu_planned"
      expr: SUM(CAST(total_teu_planned AS DOUBLE))
      comment: "Total planned TEU for vessel and terminal capacity planning"
    - name: "total_teu_completed"
      expr: SUM(CAST(total_teu_completed AS DOUBLE))
      comment: "Total completed TEU for throughput and productivity analysis"
    - name: "avg_teu_per_order"
      expr: AVG(CAST(total_teu_completed AS DOUBLE))
      comment: "Average TEU per handling order for operational sizing"
    - name: "avg_moves_per_order"
      expr: AVG(CAST(total_moves_completed AS DOUBLE))
      comment: "Average moves per handling order for productivity benchmarking"
    - name: "total_restow_moves"
      expr: SUM(CAST(restow_moves AS DOUBLE))
      comment: "Total restow moves indicating stowage inefficiency and rework"
    - name: "total_shift_moves"
      expr: SUM(CAST(shift_moves AS DOUBLE))
      comment: "Total shift moves for operational complexity analysis"
    - name: "total_hatch_cover_moves"
      expr: SUM(CAST(hatch_cover_moves AS DOUBLE))
      comment: "Total hatch cover moves impacting vessel operation time"
    - name: "avg_gross_crane_productivity_target"
      expr: AVG(CAST(gross_crane_productivity_target AS DOUBLE))
      comment: "Average target gross crane productivity for performance benchmarking"
    - name: "total_vessel_delay_minutes"
      expr: SUM(CAST(vessel_delay_minutes AS DOUBLE))
      comment: "Total vessel-caused delay minutes impacting terminal productivity"
    - name: "total_terminal_delay_minutes"
      expr: SUM(CAST(terminal_delay_minutes AS DOUBLE))
      comment: "Total terminal-caused delay minutes for operational improvement analysis"
    - name: "total_equipment_delay_minutes"
      expr: SUM(CAST(equipment_delay_minutes AS DOUBLE))
      comment: "Total equipment-caused delay minutes for maintenance and fleet planning"
    - name: "total_weather_delay_minutes"
      expr: SUM(CAST(weather_delay_minutes AS DOUBLE))
      comment: "Total weather-caused delay minutes for risk and scheduling analysis"
    - name: "avg_vessel_delay_minutes"
      expr: AVG(CAST(vessel_delay_minutes AS DOUBLE))
      comment: "Average vessel delay per order for customer service analysis"
    - name: "avg_terminal_delay_minutes"
      expr: AVG(CAST(terminal_delay_minutes AS DOUBLE))
      comment: "Average terminal delay per order for operational efficiency improvement"
$$;


CREATE OR REPLACE VIEW `vibe_shipping_ports_v1`.`_metrics`.`cargo_move`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Container move-level productivity, equipment utilization, and operational exception metrics for terminal operations optimization"
  source: "`vibe_shipping_ports_v1`.`cargo`.`move`"
  dimensions:
    - name: "move_type"
      expr: move_type
      comment: "Type of container move (load, discharge, restow, shift, gate-in, gate-out)"
    - name: "move_status"
      expr: move_status
      comment: "Current status of the move (planned, in-progress, completed, cancelled)"
    - name: "kind"
      expr: kind
      comment: "Kind classification of the move"
    - name: "stage"
      expr: stage
      comment: "Stage of the move in the handling workflow"
    - name: "equipment_type"
      expr: equipment_type
      comment: "Type of equipment used for the move (crane, RTG, reach stacker)"
    - name: "is_hazardous"
      expr: is_hazardous
      comment: "Flag indicating move involves hazardous cargo"
    - name: "is_reefer"
      expr: is_reefer
      comment: "Flag indicating move involves refrigerated container"
    - name: "is_oversize"
      expr: is_oversize
      comment: "Flag indicating move involves oversized container"
    - name: "damage_reported"
      expr: damage_reported
      comment: "Flag indicating damage was reported during or after the move"
    - name: "exception_code"
      expr: exception_code
      comment: "Exception code indicating operational issue during move"
    - name: "customs_status"
      expr: customs_status
      comment: "Customs clearance status affecting move execution"
    - name: "origin_location_type"
      expr: origin_location_type
      comment: "Type of origin location (vessel, yard, gate, warehouse)"
    - name: "destination_location_type"
      expr: destination_location_type
      comment: "Type of destination location (vessel, yard, gate, warehouse)"
    - name: "actual_start_date"
      expr: DATE(actual_start_timestamp)
      comment: "Date move was actually started"
    - name: "actual_end_date"
      expr: DATE(actual_end_timestamp)
      comment: "Date move was actually completed"
    - name: "berth"
      expr: berth_id
      comment: "Berth involved in the move"
  measures:
    - name: "total_moves"
      expr: COUNT(DISTINCT move_id)
      comment: "Distinct count of container moves for productivity and throughput analysis"
    - name: "total_teu_moved"
      expr: SUM(CAST(container_size_teu AS DOUBLE))
      comment: "Total TEU moved for standardized productivity measurement"
    - name: "avg_teu_per_move"
      expr: AVG(CAST(container_size_teu AS DOUBLE))
      comment: "Average TEU per move for equipment and operational planning"
    - name: "total_cargo_weight_kg"
      expr: SUM(CAST(cargo_weight_kg AS DOUBLE))
      comment: "Total cargo weight moved for equipment capacity and safety analysis"
    - name: "avg_cargo_weight_kg"
      expr: AVG(CAST(cargo_weight_kg AS DOUBLE))
      comment: "Average cargo weight per move for load planning and equipment selection"
    - name: "total_duration_minutes"
      expr: SUM(CAST(duration_minutes AS DOUBLE))
      comment: "Total move duration in minutes for cycle time and efficiency analysis"
    - name: "avg_duration_minutes"
      expr: AVG(CAST(duration_minutes AS DOUBLE))
      comment: "Average move duration for productivity benchmarking and process improvement"
    - name: "hazardous_move_count"
      expr: COUNT(DISTINCT CASE WHEN is_hazardous = TRUE THEN move_id END)
      comment: "Count of hazardous cargo moves for safety and compliance monitoring"
    - name: "reefer_move_count"
      expr: COUNT(DISTINCT CASE WHEN is_reefer = TRUE THEN move_id END)
      comment: "Count of refrigerated container moves for cold chain infrastructure planning"
    - name: "oversize_move_count"
      expr: COUNT(DISTINCT CASE WHEN is_oversize = TRUE THEN move_id END)
      comment: "Count of oversized container moves requiring special equipment"
    - name: "damage_reported_count"
      expr: COUNT(DISTINCT CASE WHEN damage_reported = TRUE THEN move_id END)
      comment: "Count of moves with reported damage for quality and safety analysis"
    - name: "exception_move_count"
      expr: COUNT(DISTINCT CASE WHEN exception_code IS NOT NULL THEN move_id END)
      comment: "Count of moves with exceptions for operational issue identification"
    - name: "damage_rate_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN damage_reported = TRUE THEN move_id END) / NULLIF(COUNT(DISTINCT move_id), 0), 2)
      comment: "Percentage of moves with damage for quality control and training needs"
    - name: "exception_rate_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN exception_code IS NOT NULL THEN move_id END) / NULLIF(COUNT(DISTINCT move_id), 0), 2)
      comment: "Percentage of moves with exceptions indicating operational efficiency and process quality"
$$;


CREATE OR REPLACE VIEW `vibe_shipping_ports_v1`.`_metrics`.`cargo_manifest`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Vessel manifest volume, value, and compliance metrics for customs, port authority, and trade analysis"
  source: "`vibe_shipping_ports_v1`.`cargo`.`manifest`"
  dimensions:
    - name: "manifest_status"
      expr: manifest_status
      comment: "Current status of the manifest (draft, submitted, accepted, closed)"
    - name: "manifest_type"
      expr: manifest_type
      comment: "Type of manifest (import, export, transshipment)"
    - name: "customs_submission_status"
      expr: customs_submission_status
      comment: "Status of customs submission for regulatory compliance"
    - name: "dangerous_goods_flag"
      expr: dangerous_goods_flag
      comment: "Flag indicating manifest contains dangerous goods"
    - name: "reefer_cargo_flag"
      expr: reefer_cargo_flag
      comment: "Flag indicating manifest contains refrigerated cargo"
    - name: "oversized_cargo_flag"
      expr: oversized_cargo_flag
      comment: "Flag indicating manifest contains oversized cargo"
    - name: "high_value_cargo_flag"
      expr: high_value_cargo_flag
      comment: "Flag indicating manifest contains high-value cargo requiring special security"
    - name: "customs_inspection_required_flag"
      expr: customs_inspection_required_flag
      comment: "Flag indicating customs inspection is required"
    - name: "quarantine_required_flag"
      expr: quarantine_required_flag
      comment: "Flag indicating quarantine inspection is required"
    - name: "is_active"
      expr: is_active
      comment: "Flag indicating manifest is currently active"
    - name: "submission_date"
      expr: DATE(submission_timestamp)
      comment: "Date manifest was submitted to authorities"
    - name: "closure_date"
      expr: DATE(closure_timestamp)
      comment: "Date manifest was closed"
    - name: "shipping_line"
      expr: shipping_line_id
      comment: "Shipping line submitting the manifest"
    - name: "port_location"
      expr: port_location_id
      comment: "Port location for the manifest"
    - name: "berth"
      expr: berth_id
      comment: "Berth where vessel is berthed for manifest operations"
  measures:
    - name: "total_manifests"
      expr: COUNT(DISTINCT manifest_id)
      comment: "Distinct count of manifests for vessel call and compliance volume analysis"
    - name: "total_container_count"
      expr: SUM(CAST(total_container_count AS DOUBLE))
      comment: "Total containers across all manifests for capacity and throughput planning"
    - name: "total_teu_count"
      expr: SUM(CAST(total_teu_count AS DOUBLE))
      comment: "Total TEU across all manifests for standardized volume measurement"
    - name: "avg_teu_per_manifest"
      expr: AVG(CAST(total_teu_count AS DOUBLE))
      comment: "Average TEU per manifest for vessel size and operational planning"
    - name: "total_weight_mt"
      expr: SUM(CAST(total_weight_mt AS DOUBLE))
      comment: "Total cargo weight in metric tons for infrastructure and equipment planning"
    - name: "total_volume_cbm"
      expr: SUM(CAST(total_volume_cbm AS DOUBLE))
      comment: "Total cargo volume in cubic meters for space utilization analysis"
    - name: "total_declared_value_usd"
      expr: SUM(CAST(total_declared_value_usd AS DOUBLE))
      comment: "Total declared cargo value in USD for trade value and economic impact analysis"
    - name: "avg_declared_value_usd"
      expr: AVG(CAST(total_declared_value_usd AS DOUBLE))
      comment: "Average declared value per manifest for cargo value profiling"
    - name: "total_bol_count"
      expr: SUM(CAST(total_bol_count AS DOUBLE))
      comment: "Total bills of lading across all manifests for documentation volume"
    - name: "total_fcl_containers"
      expr: SUM(CAST(fcl_container_count AS DOUBLE))
      comment: "Total full container load containers for containerized cargo analysis"
    - name: "total_lcl_containers"
      expr: SUM(CAST(lcl_container_count AS DOUBLE))
      comment: "Total less-than-container-load containers for consolidation analysis"
    - name: "total_empty_containers"
      expr: SUM(CAST(empty_container_count AS DOUBLE))
      comment: "Total empty containers for repositioning and fleet management"
    - name: "total_transhipment_containers"
      expr: SUM(CAST(transhipment_container_count AS DOUBLE))
      comment: "Total transshipment containers for hub port connectivity analysis"
    - name: "dangerous_goods_manifest_count"
      expr: COUNT(DISTINCT CASE WHEN dangerous_goods_flag = TRUE THEN manifest_id END)
      comment: "Count of manifests with dangerous goods for safety and compliance monitoring"
    - name: "customs_inspection_required_count"
      expr: COUNT(DISTINCT CASE WHEN customs_inspection_required_flag = TRUE THEN manifest_id END)
      comment: "Count of manifests requiring customs inspection for resource planning"
$$;


CREATE OR REPLACE VIEW `vibe_shipping_ports_v1`.`_metrics`.`cargo_bill_of_lading`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Bill of lading volume, weight, value, and compliance metrics for trade documentation and freight analysis"
  source: "`vibe_shipping_ports_v1`.`cargo`.`bill_of_lading`"
  dimensions:
    - name: "bol_status"
      expr: bol_status
      comment: "Current status of the bill of lading (issued, surrendered, released)"
    - name: "bol_type"
      expr: bol_type
      comment: "Type of bill of lading (original, seaway, express, telex release)"
    - name: "release_status"
      expr: release_status
      comment: "Release status of the bill of lading for cargo delivery"
    - name: "release_type"
      expr: release_type
      comment: "Type of release (original, telex, express, seaway)"
    - name: "freight_terms"
      expr: freight_terms
      comment: "Freight payment terms (prepaid, collect, etc.)"
    - name: "is_dangerous_goods"
      expr: is_dangerous_goods
      comment: "Flag indicating bill of lading covers dangerous goods"
    - name: "issue_date"
      expr: issue_date
      comment: "Date bill of lading was issued"
    - name: "last_amendment_date"
      expr: last_amendment_date
      comment: "Date of last amendment to the bill of lading"
    - name: "shipping_line"
      expr: shipping_line_id
      comment: "Shipping line issuing the bill of lading"
    - name: "pol_port_location"
      expr: port_location_id
      comment: "Port of loading location"
    - name: "commodity_code"
      expr: commodity_code_id
      comment: "Commodity classification code"
  measures:
    - name: "total_bills_of_lading"
      expr: COUNT(DISTINCT bill_of_lading_id)
      comment: "Distinct count of bills of lading for trade documentation volume analysis"
    - name: "total_freight_amount"
      expr: SUM(CAST(freight_amount AS DOUBLE))
      comment: "Total freight charges for revenue and cost analysis"
    - name: "avg_freight_amount"
      expr: AVG(CAST(freight_amount AS DOUBLE))
      comment: "Average freight charge per bill of lading for pricing analysis"
    - name: "total_gross_weight_kg"
      expr: SUM(CAST(gross_weight_kg AS DOUBLE))
      comment: "Total gross weight in kilograms for cargo volume and infrastructure planning"
    - name: "total_net_weight_kg"
      expr: SUM(CAST(net_weight_kg AS DOUBLE))
      comment: "Total net cargo weight in kilograms excluding packaging"
    - name: "avg_gross_weight_kg"
      expr: AVG(CAST(gross_weight_kg AS DOUBLE))
      comment: "Average gross weight per bill of lading for shipment profiling"
    - name: "total_volume_cbm"
      expr: SUM(CAST(volume_cbm AS DOUBLE))
      comment: "Total cargo volume in cubic meters for space utilization analysis"
    - name: "avg_volume_cbm"
      expr: AVG(CAST(volume_cbm AS DOUBLE))
      comment: "Average volume per bill of lading for cargo density analysis"
    - name: "total_container_count"
      expr: SUM(CAST(container_count AS DOUBLE))
      comment: "Total containers across all bills of lading for containerization analysis"
    - name: "avg_container_count"
      expr: AVG(CAST(container_count AS DOUBLE))
      comment: "Average containers per bill of lading for shipment size profiling"
    - name: "total_package_count"
      expr: SUM(CAST(package_count AS DOUBLE))
      comment: "Total packages across all bills of lading for handling complexity"
    - name: "total_amendment_count"
      expr: SUM(CAST(amendment_count AS DOUBLE))
      comment: "Total amendments across all bills of lading for documentation quality analysis"
    - name: "avg_amendment_count"
      expr: AVG(CAST(amendment_count AS DOUBLE))
      comment: "Average amendments per bill of lading indicating documentation accuracy"
    - name: "dangerous_goods_bol_count"
      expr: COUNT(DISTINCT CASE WHEN is_dangerous_goods = TRUE THEN bill_of_lading_id END)
      comment: "Count of bills of lading covering dangerous goods for compliance monitoring"
    - name: "dangerous_goods_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN is_dangerous_goods = TRUE THEN bill_of_lading_id END) / NULLIF(COUNT(DISTINCT bill_of_lading_id), 0), 2)
      comment: "Percentage of bills of lading covering dangerous goods for risk profiling"
$$;
