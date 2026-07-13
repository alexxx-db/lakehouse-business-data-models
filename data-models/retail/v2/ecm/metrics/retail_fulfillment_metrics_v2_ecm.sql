-- Metric views for domain: fulfillment | Business: Retail | Version: 2 | Generated on: 2026-07-12 14:06:09

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`fulfillment_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPIs for fulfillment order execution: throughput, SLA adherence, shipping cost efficiency, and fulfillment method mix. Used by operations and supply chain leadership to steer fulfillment capacity, carrier spend, and promised delivery performance."
  source: "`vibe_retail_v1`.`fulfillment`.`fulfillment_order`"
  dimensions:
    - name: "fulfillment_method"
      expr: fulfillment_method
      comment: "Fulfillment method (e.g. ship-to-home, BOPIS, curbside) used to segment order volume and cost by channel."
    - name: "fulfillment_status"
      expr: fulfillment_status
      comment: "Current lifecycle status of the fulfillment order, enabling drill-down into in-flight vs completed vs cancelled orders."
    - name: "priority_level"
      expr: priority_level
      comment: "Priority tier assigned to the fulfillment order, used to analyze SLA compliance by urgency segment."
    - name: "fulfillment_date_month"
      expr: DATE_TRUNC('MONTH', fulfillment_created_timestamp)
      comment: "Calendar month the fulfillment order was created, enabling trend analysis of order volume and cost over time."
    - name: "promised_delivery_date"
      expr: promised_delivery_date
      comment: "Date the order was promised for delivery, used to measure on-time performance against customer commitment."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which shipping costs are denominated, enabling multi-currency cost analysis."
  measures:
    - name: "total_fulfillment_orders"
      expr: COUNT(1)
      comment: "Total number of fulfillment orders created. Baseline throughput KPI used to assess operational volume and capacity utilization."
    - name: "total_shipping_cost"
      expr: SUM(CAST(shipping_cost_amount AS DOUBLE))
      comment: "Total shipping cost incurred across all fulfillment orders. Core cost KPI for carrier spend management and P&L impact analysis."
    - name: "avg_shipping_cost_per_order"
      expr: AVG(CAST(shipping_cost_amount AS DOUBLE))
      comment: "Average shipping cost per fulfillment order. Used to benchmark carrier efficiency and identify cost outliers by method or carrier."
    - name: "total_weight_shipped_kg"
      expr: SUM(CAST(total_weight_kg AS DOUBLE))
      comment: "Total weight of goods shipped across all fulfillment orders. Used for carrier rate negotiation and dimensional weight analysis."
    - name: "avg_weight_per_order_kg"
      expr: AVG(CAST(total_weight_kg AS DOUBLE))
      comment: "Average shipment weight per fulfillment order. Informs packaging optimization and carrier tier selection."
    - name: "total_volume_shipped_m3"
      expr: SUM(CAST(total_volume_cubic_meters AS DOUBLE))
      comment: "Total cubic volume shipped. Used for truck load planning, DC capacity management, and dimensional weight billing reconciliation."
    - name: "avg_actual_fulfillment_hours"
      expr: AVG(CAST(actual_fulfillment_hours AS DOUBLE))
      comment: "Average actual hours from order assignment to completion. Core operational efficiency KPI measuring fulfillment speed against SLA targets."
    - name: "fulfilled_orders"
      expr: COUNT(CASE WHEN fulfillment_status = 'COMPLETED' THEN 1 END)
      comment: "Count of fulfillment orders that reached completed status. Used to compute fulfillment completion rate and throughput."
    - name: "cancelled_orders"
      expr: COUNT(CASE WHEN fulfillment_status = 'CANCELLED' THEN 1 END)
      comment: "Count of cancelled fulfillment orders. Elevated cancellation rates signal inventory, capacity, or carrier availability issues requiring leadership intervention."
    - name: "gift_orders"
      expr: COUNT(CASE WHEN is_gift = TRUE THEN 1 END)
      comment: "Count of fulfillment orders flagged as gifts. Used for seasonal capacity planning and gift packaging resource allocation."
    - name: "distinct_fulfillment_nodes"
      expr: COUNT(DISTINCT fulfillment_node_id)
      comment: "Number of distinct fulfillment nodes processing orders. Measures geographic distribution of fulfillment activity and node utilization breadth."
    - name: "distinct_carriers_used"
      expr: COUNT(DISTINCT carrier_id)
      comment: "Number of distinct carriers engaged for fulfillment. Used to assess carrier diversification and single-carrier dependency risk."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`fulfillment_shipment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Shipment-level KPIs covering carrier cost, delivery performance, weight and volume throughput, and on-time delivery rates. Used by logistics leadership to manage carrier contracts, monitor delivery quality, and optimize last-mile costs."
  source: "`vibe_retail_v1`.`fulfillment`.`shipment`"
  dimensions:
    - name: "shipment_status"
      expr: shipment_status
      comment: "Current status of the shipment (e.g. in-transit, delivered, exception), enabling drill-down into delivery pipeline health."
    - name: "fulfillment_type"
      expr: fulfillment_type
      comment: "Fulfillment type (e.g. ship-to-home, ship-from-store) used to segment shipment cost and performance by channel."
    - name: "ship_from_location_type"
      expr: ship_from_location_type
      comment: "Type of origin location (DC, store, vendor) for the shipment. Used to analyze cost and speed differences by origin type."
    - name: "ship_date_month"
      expr: DATE_TRUNC('MONTH', ship_date)
      comment: "Calendar month the shipment was dispatched, enabling monthly trend analysis of shipment volume and cost."
    - name: "ship_to_country_code"
      expr: ship_to_country_code
      comment: "Destination country for the shipment. Used to segment international vs domestic shipping costs and transit performance."
    - name: "hazmat_flag"
      expr: hazmat_flag
      comment: "Indicates whether the shipment contains hazardous materials. Used to isolate hazmat surcharge impact on total shipping cost."
  measures:
    - name: "total_shipments"
      expr: COUNT(1)
      comment: "Total number of shipments dispatched. Baseline volume KPI for logistics throughput and carrier capacity planning."
    - name: "total_carrier_charge"
      expr: SUM(CAST(carrier_charge_amount AS DOUBLE))
      comment: "Total carrier charges billed across all shipments. Primary cost KPI for carrier contract management and freight budget tracking."
    - name: "avg_carrier_charge_per_shipment"
      expr: AVG(CAST(carrier_charge_amount AS DOUBLE))
      comment: "Average carrier charge per shipment. Used to benchmark carrier cost efficiency and detect rate anomalies."
    - name: "total_shipping_cost"
      expr: SUM(CAST(shipping_cost_amount AS DOUBLE))
      comment: "Total internal shipping cost across all shipments. Used alongside carrier charges to compute net freight margin and cost-to-serve."
    - name: "avg_shipping_cost_per_shipment"
      expr: AVG(CAST(shipping_cost_amount AS DOUBLE))
      comment: "Average internal shipping cost per shipment. Informs cost-per-unit benchmarking and carrier rate negotiation."
    - name: "total_weight_shipped_kg"
      expr: SUM(CAST(total_weight_kg AS DOUBLE))
      comment: "Total weight shipped across all shipments. Used for carrier rate tier analysis and freight cost per kg calculations."
    - name: "total_volume_shipped_m3"
      expr: SUM(CAST(total_volume_cubic_meters AS DOUBLE))
      comment: "Total cubic volume shipped. Critical for truck utilization, DC throughput planning, and dimensional weight billing."
    - name: "delivered_shipments"
      expr: COUNT(CASE WHEN shipment_status = 'DELIVERED' THEN 1 END)
      comment: "Count of shipments successfully delivered. Used to compute on-time delivery rate and carrier performance scorecards."
    - name: "exception_shipments"
      expr: COUNT(CASE WHEN shipment_status = 'EXCEPTION' THEN 1 END)
      comment: "Count of shipments in exception status. Elevated exception rates trigger carrier performance reviews and customer service escalations."
    - name: "declared_value_total"
      expr: SUM(CAST(declared_value_amount AS DOUBLE))
      comment: "Total declared value of goods shipped. Used for insurance coverage adequacy assessment and high-value shipment risk management."
    - name: "distinct_carriers_used"
      expr: COUNT(DISTINCT carrier_id)
      comment: "Number of distinct carriers used for shipments. Measures carrier diversification and concentration risk."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`fulfillment_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Line-level fulfillment KPIs measuring pick accuracy, substitution rates, fill rates, and unit economics. Used by warehouse operations and merchandising leadership to manage inventory accuracy, substitution policies, and fulfillment cost per unit."
  source: "`vibe_retail_v1`.`fulfillment`.`fulfillment_line`"
  dimensions:
    - name: "line_status"
      expr: line_status
      comment: "Current status of the fulfillment line (e.g. picked, packed, shipped, cancelled), enabling pipeline stage analysis."
    - name: "fulfillment_source_type"
      expr: fulfillment_source_type
      comment: "Source type for the fulfillment line (e.g. DC, store, drop-ship). Used to segment fill rates and costs by fulfillment origin."
    - name: "substitution_flag"
      expr: substitution_flag
      comment: "Indicates whether the line was fulfilled with a substitute item. Used to measure substitution rate and its impact on customer satisfaction."
    - name: "unit_of_measure"
      expr: unit_of_measure
      comment: "Unit of measure for the line item quantity. Used to normalize volume metrics across different product types."
    - name: "created_month"
      expr: DATE_TRUNC('MONTH', created_timestamp)
      comment: "Calendar month the fulfillment line was created, enabling trend analysis of line volume and fill rates over time."
  measures:
    - name: "total_fulfillment_lines"
      expr: COUNT(1)
      comment: "Total number of fulfillment lines processed. Baseline throughput KPI for warehouse operations capacity planning."
    - name: "total_quantity_ordered"
      expr: SUM(CAST(quantity_ordered AS DOUBLE))
      comment: "Total units ordered across all fulfillment lines. Denominator for fill rate and order completeness calculations."
    - name: "total_quantity_picked"
      expr: SUM(CAST(quantity_picked AS DOUBLE))
      comment: "Total units successfully picked. Used to compute pick fill rate and measure warehouse picking throughput."
    - name: "total_quantity_packed"
      expr: SUM(CAST(quantity_packed AS DOUBLE))
      comment: "Total units packed and ready for shipment. Used to measure pack throughput and identify pick-to-pack bottlenecks."
    - name: "total_quantity_shipped"
      expr: SUM(CAST(quantity_shipped AS DOUBLE))
      comment: "Total units shipped to customers. Core fulfillment output metric tied directly to revenue recognition and customer satisfaction."
    - name: "total_quantity_cancelled"
      expr: SUM(CAST(quantity_cancelled AS DOUBLE))
      comment: "Total units cancelled at the line level. Elevated cancellations indicate inventory availability or supplier reliability issues."
    - name: "total_quantity_allocated"
      expr: SUM(CAST(quantity_allocated AS DOUBLE))
      comment: "Total units allocated to fulfillment lines. Used to measure inventory reservation efficiency and allocation accuracy."
    - name: "total_extended_cost"
      expr: SUM(CAST(extended_cost AS DOUBLE))
      comment: "Total extended cost of goods fulfilled. Used for cost-of-goods-sold attribution and fulfillment cost-per-unit analysis."
    - name: "avg_unit_cost"
      expr: AVG(CAST(unit_cost AS DOUBLE))
      comment: "Average unit cost across fulfilled lines. Used to benchmark product cost trends and identify cost anomalies by SKU or source."
    - name: "substituted_lines"
      expr: COUNT(CASE WHEN substitution_flag = TRUE THEN 1 END)
      comment: "Count of fulfillment lines fulfilled with a substitute item. Used to compute substitution rate and assess inventory availability health."
    - name: "total_weight_shipped_kg"
      expr: SUM(CAST(weight AS DOUBLE))
      comment: "Total weight of goods shipped at line level. Used for carrier rate reconciliation and dimensional weight billing validation."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`fulfillment_pick_task`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Warehouse picking performance KPIs measuring throughput, accuracy, substitution rates, and labor efficiency. Used by DC and store operations managers to optimize pick productivity, reduce substitutions, and meet SLA commitments."
  source: "`vibe_retail_v1`.`fulfillment`.`pick_task`"
  dimensions:
    - name: "pick_task_status"
      expr: pick_task_status
      comment: "Current status of the pick task (e.g. assigned, in-progress, completed, exception). Used to monitor picking pipeline health."
    - name: "fulfillment_channel"
      expr: fulfillment_channel
      comment: "Fulfillment channel (e.g. BOPIS, ship-to-home, curbside) for the pick task. Used to segment pick productivity by channel."
    - name: "task_method"
      expr: task_method
      comment: "Picking method used (e.g. batch, zone, single-order). Used to compare productivity across picking strategies."
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level assigned to the pick task. Used to analyze whether high-priority orders are being picked faster."
    - name: "substitution_occurred"
      expr: substitution_occurred
      comment: "Indicates whether a substitution was made during picking. Used to measure substitution rate and its drivers."
    - name: "created_month"
      expr: DATE_TRUNC('MONTH', created_timestamp)
      comment: "Calendar month the pick task was created, enabling trend analysis of picking volume and efficiency over time."
  measures:
    - name: "total_pick_tasks"
      expr: COUNT(1)
      comment: "Total number of pick tasks created. Baseline picking throughput KPI for warehouse labor planning and capacity management."
    - name: "completed_pick_tasks"
      expr: COUNT(CASE WHEN pick_task_status = 'COMPLETED' THEN 1 END)
      comment: "Count of pick tasks successfully completed. Used to compute pick task completion rate and measure labor productivity."
    - name: "exception_pick_tasks"
      expr: COUNT(CASE WHEN pick_task_status = 'EXCEPTION' THEN 1 END)
      comment: "Count of pick tasks that encountered exceptions. High exception rates indicate inventory location accuracy or system issues requiring intervention."
    - name: "total_quantity_requested"
      expr: SUM(CAST(quantity_requested AS DOUBLE))
      comment: "Total units requested across all pick tasks. Denominator for pick fill rate calculations."
    - name: "total_quantity_picked"
      expr: SUM(CAST(quantity_picked AS DOUBLE))
      comment: "Total units successfully picked. Numerator for pick fill rate; directly measures warehouse inventory availability."
    - name: "substituted_pick_tasks"
      expr: COUNT(CASE WHEN substitution_occurred = TRUE THEN 1 END)
      comment: "Count of pick tasks where a substitution was made. Used to compute substitution rate and assess out-of-stock impact on customer experience."
    - name: "distinct_fulfillment_nodes_picking"
      expr: COUNT(DISTINCT fulfillment_node_id)
      comment: "Number of distinct fulfillment nodes with active picking. Used to assess geographic distribution of picking activity."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`fulfillment_pack_task`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Packing operation KPIs measuring throughput, quality check rates, package weight, and labor efficiency. Used by warehouse operations leadership to optimize packing station utilization, reduce exceptions, and control packaging costs."
  source: "`vibe_retail_v1`.`fulfillment`.`pack_task`"
  dimensions:
    - name: "task_status"
      expr: task_status
      comment: "Current status of the pack task (e.g. assigned, in-progress, completed). Used to monitor packing pipeline throughput."
    - name: "fulfillment_type"
      expr: fulfillment_type
      comment: "Fulfillment type for the pack task (e.g. ship-to-home, BOPIS). Used to segment packing cost and throughput by channel."
    - name: "package_type"
      expr: package_type
      comment: "Type of package used (e.g. box, poly bag, envelope). Used to analyze packaging material costs and dimensional weight impact."
    - name: "quality_check_status"
      expr: quality_check_status
      comment: "Outcome of the quality check performed during packing. Used to measure quality gate effectiveness and defect rates."
    - name: "task_priority"
      expr: task_priority
      comment: "Priority level of the pack task. Used to ensure high-priority orders are processed within SLA windows."
    - name: "created_month"
      expr: DATE_TRUNC('MONTH', created_timestamp)
      comment: "Calendar month the pack task was created, enabling trend analysis of packing volume and efficiency."
  measures:
    - name: "total_pack_tasks"
      expr: COUNT(1)
      comment: "Total number of pack tasks processed. Baseline packing throughput KPI for station capacity planning and labor scheduling."
    - name: "completed_pack_tasks"
      expr: COUNT(CASE WHEN task_status = 'COMPLETED' THEN 1 END)
      comment: "Count of pack tasks successfully completed. Used to compute packing completion rate and measure station productivity."
    - name: "quality_checked_tasks"
      expr: COUNT(CASE WHEN quality_check_status = 'PASSED' THEN 1 END)
      comment: "Count of pack tasks that passed quality checks. Used to measure quality gate pass rate and identify packing accuracy trends."
    - name: "total_package_weight_kg"
      expr: SUM(CAST(package_weight_kg AS DOUBLE))
      comment: "Total weight of all packed packages. Used for carrier rate reconciliation and dimensional weight billing validation."
    - name: "avg_package_weight_kg"
      expr: AVG(CAST(package_weight_kg AS DOUBLE))
      comment: "Average package weight. Used to benchmark packaging efficiency and identify opportunities to reduce carrier weight-based surcharges."
    - name: "total_insurance_value"
      expr: SUM(CAST(insurance_value_amount AS DOUBLE))
      comment: "Total declared insurance value across packed shipments. Used for insurance cost management and high-value shipment risk assessment."
    - name: "gift_wrapped_tasks"
      expr: COUNT(CASE WHEN gift_wrap_flag = TRUE THEN 1 END)
      comment: "Count of pack tasks with gift wrapping applied. Used for seasonal gift service capacity planning and gift wrap material procurement."
    - name: "hazmat_pack_tasks"
      expr: COUNT(CASE WHEN hazmat_flag = TRUE THEN 1 END)
      comment: "Count of pack tasks involving hazardous materials. Used to ensure hazmat handling compliance and specialized packaging resource allocation."
    - name: "distinct_packing_stations"
      expr: COUNT(DISTINCT packing_station_code)
      comment: "Number of distinct packing stations utilized. Used to measure station utilization breadth and identify bottleneck stations."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`fulfillment_delivery_route`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Last-mile delivery route efficiency KPIs measuring distance, stop completion rates, weight throughput, and route utilization. Used by logistics and operations leadership to optimize route planning, reduce delivery cost per stop, and improve on-time delivery."
  source: "`vibe_retail_v1`.`fulfillment`.`delivery_route`"
  dimensions:
    - name: "route_status"
      expr: route_status
      comment: "Current status of the delivery route (e.g. planned, in-progress, completed, cancelled). Used to monitor active route health."
    - name: "route_type"
      expr: route_type
      comment: "Type of delivery route (e.g. residential, commercial, mixed). Used to segment cost and efficiency by route category."
    - name: "vehicle_type"
      expr: vehicle_type
      comment: "Type of vehicle used for the route. Used to analyze cost and capacity efficiency by vehicle class."
    - name: "route_date_month"
      expr: DATE_TRUNC('MONTH', route_date)
      comment: "Calendar month of the delivery route, enabling trend analysis of route volume and efficiency over time."
    - name: "temperature_controlled_flag"
      expr: temperature_controlled_flag
      comment: "Indicates whether the route required temperature-controlled transport. Used to segment cold-chain delivery costs and compliance."
    - name: "hazmat_flag"
      expr: hazmat_flag
      comment: "Indicates whether the route carried hazardous materials. Used to isolate hazmat route costs and compliance requirements."
  measures:
    - name: "total_routes"
      expr: COUNT(1)
      comment: "Total number of delivery routes executed. Baseline throughput KPI for last-mile logistics capacity planning."
    - name: "total_actual_distance_km"
      expr: SUM(CAST(actual_distance_km AS DOUBLE))
      comment: "Total actual distance driven across all routes. Core cost driver for fuel, vehicle maintenance, and carrier rate negotiations."
    - name: "avg_actual_distance_km"
      expr: AVG(CAST(actual_distance_km AS DOUBLE))
      comment: "Average actual distance per route. Used to benchmark route optimization effectiveness and identify inefficient routes."
    - name: "total_planned_distance_km"
      expr: SUM(CAST(total_distance_km AS DOUBLE))
      comment: "Total planned route distance. Used alongside actual distance to measure route planning accuracy and optimization quality."
    - name: "total_weight_delivered_kg"
      expr: SUM(CAST(total_weight_kg AS DOUBLE))
      comment: "Total weight delivered across all routes. Used to compute cost per kg delivered and assess vehicle load efficiency."
    - name: "total_volume_delivered_m3"
      expr: SUM(CAST(total_volume_m3 AS DOUBLE))
      comment: "Total cubic volume delivered across all routes. Used for vehicle utilization analysis and load planning optimization."
    - name: "completed_routes"
      expr: COUNT(CASE WHEN route_status = 'COMPLETED' THEN 1 END)
      comment: "Count of routes successfully completed. Used to compute route completion rate and measure last-mile reliability."
    - name: "cancelled_routes"
      expr: COUNT(CASE WHEN route_status = 'CANCELLED' THEN 1 END)
      comment: "Count of cancelled delivery routes. Elevated cancellations signal vehicle availability, driver, or weather-related disruptions."
    - name: "distinct_carriers_on_routes"
      expr: COUNT(DISTINCT carrier_id)
      comment: "Number of distinct carriers executing delivery routes. Used to assess carrier mix and dependency concentration in last-mile operations."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`fulfillment_delivery_stop`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Delivery stop-level KPIs measuring proof-of-delivery capture rates, stop outcomes, and service time performance. Used by last-mile operations and customer experience leadership to monitor delivery success rates and identify failure patterns."
  source: "`vibe_retail_v1`.`fulfillment`.`delivery_stop`"
  dimensions:
    - name: "stop_status"
      expr: stop_status
      comment: "Current status of the delivery stop (e.g. delivered, attempted, failed). Used to segment delivery success and failure rates."
    - name: "delivery_outcome"
      expr: delivery_outcome
      comment: "Outcome of the delivery attempt (e.g. delivered to recipient, left at door, returned to depot). Used to analyze delivery success patterns."
    - name: "stop_type"
      expr: stop_type
      comment: "Type of delivery stop (e.g. residential, commercial, locker). Used to segment service time and success rates by location type."
    - name: "delivery_location_type"
      expr: delivery_location_type
      comment: "Physical location type for the delivery (e.g. front door, mailroom, locker). Used to analyze delivery method effectiveness."
    - name: "pod_capture_method"
      expr: pod_capture_method
      comment: "Method used to capture proof of delivery (e.g. signature, photo, PIN). Used to assess POD compliance and dispute resolution readiness."
    - name: "stop_date_month"
      expr: DATE_TRUNC('MONTH', created_timestamp)
      comment: "Calendar month of the delivery stop, enabling trend analysis of delivery volume and success rates over time."
  measures:
    - name: "total_delivery_stops"
      expr: COUNT(1)
      comment: "Total number of delivery stops attempted. Baseline last-mile volume KPI for route density and driver productivity analysis."
    - name: "successful_deliveries"
      expr: COUNT(CASE WHEN delivery_outcome = 'DELIVERED' THEN 1 END)
      comment: "Count of stops resulting in successful delivery. Used to compute first-attempt delivery success rate, a key customer satisfaction driver."
    - name: "failed_delivery_stops"
      expr: COUNT(CASE WHEN stop_status = 'FAILED' THEN 1 END)
      comment: "Count of failed delivery stops. Failed deliveries drive redelivery costs and customer dissatisfaction; requires carrier and route intervention."
    - name: "pod_captured_stops"
      expr: COUNT(CASE WHEN pod_verification_status = 'VERIFIED' THEN 1 END)
      comment: "Count of stops with verified proof of delivery. POD capture rate is critical for dispute resolution and carrier liability management."
    - name: "distinct_routes_served"
      expr: COUNT(DISTINCT delivery_route_id)
      comment: "Number of distinct delivery routes with stops. Used to measure route density and identify under-utilized routes."
    - name: "distinct_carriers_delivering"
      expr: COUNT(DISTINCT carrier_id)
      comment: "Number of distinct carriers executing delivery stops. Used to assess carrier mix in last-mile operations."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`fulfillment_bopis_appointment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Buy-online-pickup-in-store (BOPIS) appointment KPIs measuring SLA compliance, wait times, and pickup readiness. Used by store operations and omnichannel leadership to optimize curbside and in-store pickup experiences and meet customer pickup commitments."
  source: "`vibe_retail_v1`.`fulfillment`.`bopis_appointment`"
  dimensions:
    - name: "appointment_status"
      expr: appointment_status
      comment: "Current status of the BOPIS appointment (e.g. scheduled, ready, completed, cancelled). Used to monitor pickup pipeline health."
    - name: "appointment_type"
      expr: appointment_type
      comment: "Type of pickup appointment (e.g. curbside, in-store, locker). Used to segment SLA performance and resource requirements by pickup method."
    - name: "check_in_method"
      expr: check_in_method
      comment: "Method used by the customer to check in for pickup (e.g. app, SMS, in-store). Used to analyze digital check-in adoption rates."
    - name: "sla_met_flag"
      expr: sla_met_flag
      comment: "Indicates whether the BOPIS appointment met its SLA target. Used to compute SLA compliance rate across locations and appointment types."
    - name: "scheduled_date_month"
      expr: DATE_TRUNC('MONTH', scheduled_date)
      comment: "Calendar month of the scheduled pickup, enabling trend analysis of BOPIS volume and SLA performance over time."
    - name: "cancellation_reason"
      expr: cancellation_reason
      comment: "Reason for appointment cancellation. Used to identify systemic issues driving BOPIS cancellations and inform process improvements."
  measures:
    - name: "total_bopis_appointments"
      expr: COUNT(1)
      comment: "Total number of BOPIS appointments scheduled. Baseline omnichannel pickup volume KPI for store staffing and capacity planning."
    - name: "sla_compliant_appointments"
      expr: COUNT(CASE WHEN sla_met_flag = TRUE THEN 1 END)
      comment: "Count of BOPIS appointments that met the SLA target ready time. Used to compute BOPIS SLA compliance rate, a key customer experience KPI."
    - name: "cancelled_appointments"
      expr: COUNT(CASE WHEN appointment_status = 'CANCELLED' THEN 1 END)
      comment: "Count of cancelled BOPIS appointments. High cancellation rates indicate inventory availability or customer experience issues."
    - name: "ready_notification_sent_count"
      expr: COUNT(CASE WHEN ready_notification_sent_flag = TRUE THEN 1 END)
      comment: "Count of appointments where the ready notification was sent to the customer. Used to measure notification process compliance and identify gaps."
    - name: "distinct_pickup_locations"
      expr: COUNT(DISTINCT location_id)
      comment: "Number of distinct store locations processing BOPIS appointments. Used to assess BOPIS geographic coverage and location-level performance."
    - name: "distinct_fulfillment_orders"
      expr: COUNT(DISTINCT fulfillment_order_id)
      comment: "Number of distinct fulfillment orders associated with BOPIS appointments. Used to measure BOPIS order attachment rate."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`fulfillment_exception`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Fulfillment exception KPIs measuring exception volume, financial impact, SLA breach rates, and resolution efficiency. Used by operations and customer service leadership to identify systemic failure patterns, prioritize corrective actions, and reduce exception-driven costs."
  source: "`vibe_retail_v1`.`fulfillment`.`exception`"
  dimensions:
    - name: "exception_type"
      expr: exception_type
      comment: "Category of fulfillment exception (e.g. damaged, lost, delayed, mis-pick). Used to identify the most impactful exception types for root cause analysis."
    - name: "exception_status"
      expr: exception_status
      comment: "Current resolution status of the exception (e.g. open, in-progress, resolved). Used to monitor exception backlog and resolution velocity."
    - name: "root_cause_category"
      expr: root_cause_category
      comment: "Root cause category of the exception. Used to drive systemic process improvements and reduce recurring exception types."
    - name: "escalation_level"
      expr: escalation_level
      comment: "Escalation level of the exception. Used to monitor escalation rates and ensure high-priority exceptions receive timely resolution."
    - name: "sla_breach_flag"
      expr: sla_breach_flag
      comment: "Indicates whether the exception breached its SLA resolution target. Used to compute SLA breach rate and identify systemic resolution delays."
    - name: "exception_month"
      expr: DATE_TRUNC('MONTH', exception_timestamp)
      comment: "Calendar month the exception was detected, enabling trend analysis of exception volume and financial impact over time."
  measures:
    - name: "total_exceptions"
      expr: COUNT(1)
      comment: "Total number of fulfillment exceptions recorded. Baseline quality KPI; rising exception counts signal systemic operational or carrier issues."
    - name: "total_financial_impact"
      expr: SUM(CAST(financial_impact_amount AS DOUBLE))
      comment: "Total financial impact of fulfillment exceptions. Core cost KPI for exception management; directly informs carrier penalty negotiations and process investment decisions."
    - name: "avg_financial_impact_per_exception"
      expr: AVG(CAST(financial_impact_amount AS DOUBLE))
      comment: "Average financial impact per exception. Used to prioritize exception types by cost severity and allocate resolution resources accordingly."
    - name: "sla_breached_exceptions"
      expr: COUNT(CASE WHEN sla_breach_flag = TRUE THEN 1 END)
      comment: "Count of exceptions that breached their SLA resolution target. High SLA breach rates trigger operational reviews and corrective action plans."
    - name: "customer_notified_exceptions"
      expr: COUNT(CASE WHEN customer_notified_flag = TRUE THEN 1 END)
      comment: "Count of exceptions where the customer was proactively notified. Used to measure customer communication compliance and its impact on satisfaction scores."
    - name: "total_quantity_affected"
      expr: SUM(CAST(quantity_affected AS DOUBLE))
      comment: "Total units affected by fulfillment exceptions. Used to quantify the inventory and revenue impact of exception events."
    - name: "resolved_exceptions"
      expr: COUNT(CASE WHEN exception_status = 'RESOLVED' THEN 1 END)
      comment: "Count of exceptions that have been resolved. Used to compute exception resolution rate and measure operational recovery effectiveness."
    - name: "distinct_carriers_with_exceptions"
      expr: COUNT(DISTINCT carrier_id)
      comment: "Number of distinct carriers associated with exceptions. Used to identify carrier-specific quality issues for contract performance reviews."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`fulfillment_proof_of_delivery`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Proof-of-delivery KPIs measuring delivery success rates, signature capture compliance, temperature compliance, and dispute rates. Used by logistics and customer service leadership to manage delivery quality, reduce disputes, and ensure regulatory compliance for age-restricted and temperature-sensitive goods."
  source: "`vibe_retail_v1`.`fulfillment`.`proof_of_delivery`"
  dimensions:
    - name: "delivery_status"
      expr: delivery_status
      comment: "Final delivery status recorded on the POD (e.g. delivered, attempted, returned). Used to segment delivery success and failure rates."
    - name: "pod_capture_method"
      expr: pod_capture_method
      comment: "Method used to capture proof of delivery (e.g. signature, photo, PIN). Used to analyze POD method effectiveness and compliance."
    - name: "delivery_location_type"
      expr: delivery_location_type
      comment: "Type of delivery location (e.g. front door, reception, locker). Used to segment delivery outcomes by location type."
    - name: "temperature_compliant_flag"
      expr: temperature_compliant_flag
      comment: "Indicates whether temperature requirements were met at delivery. Critical for cold-chain compliance and food safety regulatory reporting."
    - name: "dispute_filed_flag"
      expr: dispute_filed_flag
      comment: "Indicates whether a delivery dispute was filed. Used to compute dispute rate and identify carriers or routes with elevated dispute patterns."
    - name: "delivery_month"
      expr: DATE_TRUNC('MONTH', delivery_date)
      comment: "Calendar month of delivery, enabling trend analysis of delivery quality and compliance metrics over time."
  measures:
    - name: "total_deliveries"
      expr: COUNT(1)
      comment: "Total number of proof-of-delivery records. Baseline delivery volume KPI for last-mile performance tracking."
    - name: "successful_deliveries"
      expr: COUNT(CASE WHEN delivery_status = 'DELIVERED' THEN 1 END)
      comment: "Count of deliveries with confirmed successful delivery status. Used to compute first-attempt delivery success rate."
    - name: "signature_captured_deliveries"
      expr: COUNT(CASE WHEN signature_captured_flag = TRUE THEN 1 END)
      comment: "Count of deliveries with a captured signature. Used to measure signature compliance rate for high-value and regulated shipments."
    - name: "temperature_compliant_deliveries"
      expr: COUNT(CASE WHEN temperature_compliant_flag = TRUE THEN 1 END)
      comment: "Count of deliveries meeting temperature compliance requirements. Critical cold-chain KPI for food safety and pharmaceutical regulatory compliance."
    - name: "disputed_deliveries"
      expr: COUNT(CASE WHEN dispute_filed_flag = TRUE THEN 1 END)
      comment: "Count of deliveries with a filed dispute. Elevated dispute rates signal delivery quality issues and drive carrier penalty and reimbursement processes."
    - name: "age_verified_deliveries"
      expr: COUNT(CASE WHEN age_verification_completed_flag = TRUE THEN 1 END)
      comment: "Count of deliveries where age verification was completed. Used to measure compliance with age-restricted product delivery regulations."
    - name: "sla_met_deliveries"
      expr: COUNT(CASE WHEN sla_met_flag = TRUE THEN 1 END)
      comment: "Count of deliveries that met the promised delivery SLA. Used to compute on-time delivery rate, a primary customer satisfaction and carrier performance KPI."
    - name: "avg_gps_accuracy_meters"
      expr: AVG(CAST(gps_accuracy_meters AS DOUBLE))
      comment: "Average GPS accuracy at time of delivery capture. Used to assess POD location data quality for dispute resolution and route optimization."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`fulfillment_carrier`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Carrier master KPIs measuring rate competitiveness, service capability coverage, and contract terms. Used by logistics procurement and operations leadership to evaluate carrier portfolio, negotiate contracts, and manage carrier diversification strategy."
  source: "`vibe_retail_v1`.`fulfillment`.`carrier`"
  dimensions:
    - name: "carrier_status"
      expr: carrier_status
      comment: "Operational status of the carrier (e.g. active, suspended, inactive). Used to monitor active carrier portfolio health."
    - name: "carrier_type"
      expr: carrier_type
      comment: "Type of carrier (e.g. parcel, LTL, FTL, last-mile). Used to segment rate and performance analysis by carrier category."
    - name: "hazmat_certified_flag"
      expr: hazmat_certified_flag
      comment: "Indicates whether the carrier is certified for hazardous materials transport. Used to assess hazmat carrier availability."
    - name: "service_level_same_day"
      expr: service_level_same_day
      comment: "Indicates whether the carrier offers same-day delivery. Used to assess same-day fulfillment capability coverage."
    - name: "service_level_overnight"
      expr: service_level_overnight
      comment: "Indicates whether the carrier offers overnight delivery. Used to assess premium delivery service availability."
  measures:
    - name: "total_active_carriers"
      expr: COUNT(CASE WHEN carrier_status = 'ACTIVE' THEN 1 END)
      comment: "Count of active carriers in the network. Used to assess carrier portfolio breadth and identify single-carrier dependency risks."
    - name: "avg_base_rate_per_lb"
      expr: AVG(CAST(base_rate_per_lb AS DOUBLE))
      comment: "Average base shipping rate per pound across carriers. Used to benchmark carrier cost competitiveness and inform rate negotiation strategy."
    - name: "avg_fuel_surcharge_percentage"
      expr: AVG(CAST(fuel_surcharge_percentage AS DOUBLE))
      comment: "Average fuel surcharge percentage across carriers. Used to monitor fuel cost exposure and negotiate fuel surcharge caps in carrier contracts."
    - name: "avg_negotiated_discount_percentage"
      expr: AVG(CAST(negotiated_discount_percentage AS DOUBLE))
      comment: "Average negotiated discount percentage across carrier contracts. Used to measure procurement effectiveness and benchmark discount levels."
    - name: "avg_max_weight_lbs"
      expr: AVG(CAST(max_weight_lbs AS DOUBLE))
      comment: "Average maximum weight capacity per carrier. Used to assess carrier suitability for heavy shipment categories."
    - name: "edi_capable_carriers"
      expr: COUNT(CASE WHEN edi_capable_flag = TRUE THEN 1 END)
      comment: "Count of carriers with EDI integration capability. Used to measure carrier digital integration coverage and identify manual process risks."
    - name: "same_day_capable_carriers"
      expr: COUNT(CASE WHEN service_level_same_day = TRUE THEN 1 END)
      comment: "Count of carriers offering same-day delivery service. Used to assess same-day fulfillment network coverage and capacity."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`fulfillment_drop_ship_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Drop-ship order KPIs measuring vendor fulfillment compliance, on-time ship rates, and exception rates. Used by merchandising and supply chain leadership to manage vendor drop-ship performance, enforce SLAs, and reduce customer-facing delivery failures."
  source: "`vibe_retail_v1`.`fulfillment`.`drop_ship_order`"
  dimensions:
    - name: "drop_ship_status"
      expr: drop_ship_status
      comment: "Current status of the drop-ship order (e.g. sent, acknowledged, shipped, delivered, cancelled). Used to monitor vendor fulfillment pipeline."
    - name: "exception_code"
      expr: exception_code
      comment: "Exception code associated with the drop-ship order. Used to categorize vendor fulfillment failures and drive corrective actions."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the drop-ship order. Used for multi-currency vendor cost analysis."
    - name: "vendor_sla_compliance_flag"
      expr: vendor_sla_compliance_flag
      comment: "Indicates whether the vendor met the drop-ship SLA. Used to compute vendor SLA compliance rate for contract performance management."
    - name: "created_month"
      expr: DATE_TRUNC('MONTH', created_timestamp)
      comment: "Calendar month the drop-ship order was created, enabling trend analysis of drop-ship volume and vendor performance over time."
  measures:
    - name: "total_drop_ship_orders"
      expr: COUNT(1)
      comment: "Total number of drop-ship orders placed. Baseline volume KPI for vendor drop-ship program scale and dependency assessment."
    - name: "vendor_sla_compliant_orders"
      expr: COUNT(CASE WHEN vendor_sla_compliance_flag = TRUE THEN 1 END)
      comment: "Count of drop-ship orders where the vendor met the SLA. Used to compute vendor SLA compliance rate, a key supplier performance KPI."
    - name: "cancelled_drop_ship_orders"
      expr: COUNT(CASE WHEN drop_ship_status = 'CANCELLED' THEN 1 END)
      comment: "Count of cancelled drop-ship orders. High cancellation rates indicate vendor inventory or fulfillment capability issues."
    - name: "exception_drop_ship_orders"
      expr: COUNT(CASE WHEN exception_code IS NOT NULL THEN 1 END)
      comment: "Count of drop-ship orders with an exception code. Used to compute vendor exception rate and identify underperforming vendors."
    - name: "distinct_vendors"
      expr: COUNT(DISTINCT vendor_id)
      comment: "Number of distinct vendors fulfilling drop-ship orders. Used to assess vendor portfolio breadth and concentration risk."
    - name: "distinct_carrier_services_used"
      expr: COUNT(DISTINCT carrier_service_id)
      comment: "Number of distinct carrier services used for drop-ship fulfillment. Used to assess carrier service diversity in the drop-ship channel."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`fulfillment_node`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Fulfillment node capability and capacity KPIs measuring node network coverage, service capability mix, and operational readiness. Used by supply chain and network planning leadership to optimize node activation, assess omnichannel capability coverage, and plan capacity investments."
  source: "`vibe_retail_v1`.`fulfillment`.`fulfillment_node`"
  dimensions:
    - name: "node_status"
      expr: node_status
      comment: "Operational status of the fulfillment node (e.g. active, inactive, planned). Used to monitor active node network health."
    - name: "node_type"
      expr: node_type
      comment: "Type of fulfillment node (e.g. DC, store, micro-fulfillment center). Used to segment capability and cost analysis by node category."
    - name: "automation_level"
      expr: automation_level
      comment: "Level of automation at the node (e.g. manual, semi-automated, fully automated). Used to correlate automation investment with throughput and cost efficiency."
    - name: "country_code"
      expr: country_code
      comment: "Country where the fulfillment node is located. Used for geographic network coverage analysis."
    - name: "same_day_delivery_enabled"
      expr: same_day_delivery_enabled
      comment: "Indicates whether the node supports same-day delivery. Used to assess same-day fulfillment network coverage."
    - name: "bopis_enabled"
      expr: bopis_enabled
      comment: "Indicates whether the node supports BOPIS. Used to measure omnichannel pickup capability coverage across the network."
  measures:
    - name: "total_active_nodes"
      expr: COUNT(CASE WHEN node_status = 'ACTIVE' THEN 1 END)
      comment: "Count of active fulfillment nodes in the network. Core network capacity KPI used to assess fulfillment coverage and plan node expansion."
    - name: "bopis_enabled_nodes"
      expr: COUNT(CASE WHEN bopis_enabled = TRUE THEN 1 END)
      comment: "Count of nodes with BOPIS capability enabled. Used to measure omnichannel pickup network coverage and identify gaps."
    - name: "same_day_enabled_nodes"
      expr: COUNT(CASE WHEN same_day_delivery_enabled = TRUE THEN 1 END)
      comment: "Count of nodes capable of same-day delivery. Used to assess same-day fulfillment geographic coverage and capacity."
    - name: "ship_from_store_enabled_nodes"
      expr: COUNT(CASE WHEN ship_from_store_enabled = TRUE THEN 1 END)
      comment: "Count of nodes enabled for ship-from-store fulfillment. Used to measure distributed inventory utilization capability across the store network."
    - name: "refrigerated_storage_nodes"
      expr: COUNT(CASE WHEN refrigerated_storage_enabled = TRUE THEN 1 END)
      comment: "Count of nodes with refrigerated storage capability. Used to assess cold-chain fulfillment network coverage for perishable goods."
    - name: "avg_delivery_zone_radius_miles"
      expr: AVG(CAST(delivery_zone_coverage_radius_miles AS DOUBLE))
      comment: "Average delivery zone coverage radius across nodes. Used to assess geographic reach of the fulfillment network and identify coverage gaps."
$$;