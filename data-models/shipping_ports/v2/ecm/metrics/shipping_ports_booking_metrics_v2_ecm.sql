-- Metric views for domain: booking | Business: Shipping_Ports | Version: 2 | Generated on: 2026-07-13 07:51:56

CREATE OR REPLACE VIEW `vibe_shipping_ports_v1`.`_metrics`.`booking_call_booking`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPIs for vessel call bookings — covers booking pipeline volume, TEU throughput commitments, dangerous-goods exposure, and cancellation rates. Used by port operations and commercial teams to manage berth demand, revenue forecasting, and compliance risk."
  source: "`vibe_shipping_ports_v1`.`booking`.`call_booking`"
  dimensions:
    - name: "booking_status"
      expr: booking_status
      comment: "Current lifecycle status of the call booking (e.g. SUBMITTED, CONFIRMED, CANCELLED) — primary filter for pipeline vs. confirmed demand analysis."
    - name: "shipping_line"
      expr: shipping_line_id
      comment: "Shipping line identifier — enables revenue and volume segmentation by carrier customer."
    - name: "isps_security_level"
      expr: isps_security_level
      comment: "ISPS security level declared at booking — used to segment calls by security risk tier for compliance reporting."
    - name: "dangerous_goods_flag"
      expr: dangerous_goods_flag
      comment: "Indicates whether the vessel call includes dangerous goods — critical for berth allocation and IMDG compliance planning."
    - name: "pilotage_required"
      expr: pilotage_required
      comment: "Whether pilotage is required for this call — drives marine services demand forecasting."
    - name: "towage_required"
      expr: towage_required
      comment: "Whether towage is required — drives tug fleet scheduling and ancillary revenue forecasting."
    - name: "customs_clearance_status"
      expr: customs_clearance_status
      comment: "Customs clearance status at booking level — used to identify calls at risk of delay due to customs holds."
    - name: "booking_month"
      expr: DATE_TRUNC('MONTH', booking_submitted_timestamp)
      comment: "Month the booking was submitted — enables trend analysis of booking volumes over time."
    - name: "eta_month"
      expr: DATE_TRUNC('MONTH', eta)
      comment: "Month of estimated time of arrival — used for forward-looking berth demand planning."
  measures:
    - name: "total_call_bookings"
      expr: COUNT(1)
      comment: "Total number of vessel call bookings — baseline volume KPI for port demand pipeline management."
    - name: "confirmed_call_bookings"
      expr: COUNT(CASE WHEN booking_status = 'CONFIRMED' THEN 1 END)
      comment: "Number of confirmed vessel call bookings — measures the confirmed berth demand pipeline for operational planning."
    - name: "cancelled_call_bookings"
      expr: COUNT(CASE WHEN booking_status = 'CANCELLED' THEN 1 END)
      comment: "Number of cancelled vessel call bookings — high cancellation rates signal commercial instability or scheduling conflicts."
    - name: "cancellation_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN booking_status = 'CANCELLED' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of call bookings that were cancelled — a key commercial health indicator; elevated rates trigger investigation into carrier reliability or port competitiveness."
    - name: "total_expected_teu"
      expr: SUM(CAST(expected_teu AS DOUBLE))
      comment: "Total TEU volume committed across all call bookings — primary throughput demand metric used in berth and yard capacity planning."
    - name: "dangerous_goods_call_count"
      expr: COUNT(CASE WHEN dangerous_goods_flag = TRUE THEN 1 END)
      comment: "Number of call bookings with dangerous goods declared — drives IMDG compliance resource allocation and berth segregation planning."
    - name: "dangerous_goods_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN dangerous_goods_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of call bookings involving dangerous goods — used by HSE and compliance teams to assess port-wide DG exposure."
    - name: "pilotage_demand_count"
      expr: COUNT(CASE WHEN pilotage_required = TRUE THEN 1 END)
      comment: "Number of call bookings requiring pilotage — directly drives marine pilot scheduling and capacity planning."
    - name: "towage_demand_count"
      expr: COUNT(CASE WHEN towage_required = TRUE THEN 1 END)
      comment: "Number of call bookings requiring towage — drives tug fleet utilization planning and ancillary revenue forecasting."
    - name: "distinct_shipping_lines"
      expr: COUNT(DISTINCT shipping_line_id)
      comment: "Number of distinct shipping lines with active call bookings — measures carrier diversity and commercial reach of the port."
    - name: "avg_expected_teu_per_booking"
      expr: AVG(CAST(expected_teu AS DOUBLE))
      comment: "Average TEU volume per call booking — indicates vessel size mix and helps benchmark against port capacity thresholds."
$$;


CREATE OR REPLACE VIEW `vibe_shipping_ports_v1`.`_metrics`.`booking_cargo_booking`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Cargo booking KPIs covering TEU/FEU throughput commitments, reefer and dangerous-goods volumes, weight, and booking conversion. Used by commercial, operations, and compliance teams to manage cargo pipeline, revenue, and risk."
  source: "`vibe_shipping_ports_v1`.`booking`.`cargo_booking`"
  dimensions:
    - name: "booking_status"
      expr: booking_status
      comment: "Lifecycle status of the cargo booking (e.g. CONFIRMED, PENDING, CANCELLED) — primary segmentation for pipeline vs. confirmed revenue analysis."
    - name: "cargo_type"
      expr: cargo_type
      comment: "Type of cargo (e.g. FCL, LCL, BULK) — enables volume and revenue segmentation by cargo category."
    - name: "service_type"
      expr: service_type
      comment: "Service type associated with the cargo booking (e.g. IMPORT, EXPORT, TRANSHIPMENT) — critical for T/S hub performance tracking."
    - name: "is_dangerous_goods"
      expr: is_dangerous_goods
      comment: "Whether the cargo booking involves dangerous goods — used for IMDG compliance and DG volume trend analysis."
    - name: "is_temperature_controlled"
      expr: is_temperature_controlled
      comment: "Whether the cargo requires temperature control (reefer) — drives reefer plug capacity planning and premium revenue tracking."
    - name: "is_oversized"
      expr: is_oversized
      comment: "Whether the cargo is out-of-gauge (OOG) — drives special handling resource allocation and stowage planning."
    - name: "payment_terms"
      expr: payment_terms
      comment: "Payment terms for the cargo booking — used in credit risk and cash flow forecasting."
    - name: "booking_month"
      expr: DATE_TRUNC('MONTH', booking_date)
      comment: "Month the cargo booking was placed — enables monthly throughput trend analysis."
    - name: "shipping_line"
      expr: shipping_line_id
      comment: "Shipping line associated with the cargo booking — enables carrier-level volume and revenue segmentation."
  measures:
    - name: "total_cargo_bookings"
      expr: COUNT(1)
      comment: "Total number of cargo bookings — baseline volume KPI for cargo pipeline management."
    - name: "confirmed_cargo_bookings"
      expr: COUNT(CASE WHEN booking_status = 'CONFIRMED' THEN 1 END)
      comment: "Number of confirmed cargo bookings — measures the firm cargo demand pipeline for yard and vessel planning."
    - name: "total_teu_booked"
      expr: SUM(CAST(teu_count AS DOUBLE))
      comment: "Total TEU volume across all cargo bookings — primary throughput KPI for container terminal capacity planning and revenue forecasting."
    - name: "total_feu_booked"
      expr: SUM(CAST(feu_count AS DOUBLE))
      comment: "Total FEU (40-foot equivalent unit) volume booked — complements TEU metric for accurate slot and stowage planning."
    - name: "total_gross_weight_tonnes"
      expr: ROUND(SUM(CAST(gross_weight_kg AS DOUBLE)) / 1000.0, 2)
      comment: "Total gross cargo weight in metric tonnes — used for berth structural load planning and VGM compliance monitoring."
    - name: "avg_gross_weight_kg_per_booking"
      expr: AVG(CAST(gross_weight_kg AS DOUBLE))
      comment: "Average gross weight per cargo booking — benchmarks cargo density and identifies anomalous heavy-lift bookings."
    - name: "total_volume_cbm"
      expr: SUM(CAST(volume_cbm AS DOUBLE))
      comment: "Total cargo volume in cubic metres — used for break-bulk and LCL stowage planning alongside TEU metrics."
    - name: "reefer_booking_count"
      expr: COUNT(CASE WHEN is_temperature_controlled = TRUE THEN 1 END)
      comment: "Number of reefer cargo bookings — drives reefer plug allocation and cold-chain infrastructure planning."
    - name: "reefer_teu_booked"
      expr: SUM(CAST(CASE WHEN is_temperature_controlled = TRUE THEN teu_count ELSE 0 END AS INT))
      comment: "TEU volume from reefer cargo bookings — key metric for reefer yard capacity and premium revenue tracking."
    - name: "dangerous_goods_teu_booked"
      expr: SUM(CAST(CASE WHEN is_dangerous_goods = TRUE THEN teu_count ELSE 0 END AS INT))
      comment: "TEU volume from dangerous goods bookings — used by IMDG compliance and HSE teams to assess DG throughput exposure."
    - name: "oversized_booking_count"
      expr: COUNT(CASE WHEN is_oversized = TRUE THEN 1 END)
      comment: "Number of out-of-gauge (OOG) cargo bookings — drives special handling crane and stowage resource planning."
    - name: "booking_confirmation_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN booking_status = 'CONFIRMED' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of cargo bookings that reach confirmed status — measures commercial conversion efficiency and booking quality."
    - name: "avg_teu_per_booking"
      expr: AVG(CAST(teu_count AS DOUBLE))
      comment: "Average TEU per cargo booking — indicates average shipment size and helps identify large-volume shipper segments."
$$;


CREATE OR REPLACE VIEW `vibe_shipping_ports_v1`.`_metrics`.`booking_berth_reservation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Berth reservation KPIs covering utilization, turnaround performance, dangerous-goods exposure, and tidal/weather constraints. Used by port planners and marine operations to optimize berth allocation and measure operational efficiency."
  source: "`vibe_shipping_ports_v1`.`booking`.`booking_berth_reservation`"
  dimensions:
    - name: "reservation_status"
      expr: reservation_status
      comment: "Current status of the berth reservation (e.g. CONFIRMED, CANCELLED, COMPLETED) — primary filter for active vs. historical berth demand."
    - name: "berth_side"
      expr: berth_side
      comment: "Side of berth (port/starboard) — used in berth allocation optimization and mooring planning."
    - name: "service_type"
      expr: service_type
      comment: "Type of service associated with the berth reservation (e.g. CONTAINER, BULK, RO-RO) — enables berth utilization analysis by vessel/cargo type."
    - name: "dangerous_goods_flag"
      expr: dangerous_goods_flag
      comment: "Whether the reservation involves dangerous goods — used for IMDG berth segregation compliance analysis."
    - name: "pilotage_required"
      expr: pilotage_required
      comment: "Whether pilotage is required — drives marine pilot demand forecasting per berth."
    - name: "towage_required"
      expr: towage_required
      comment: "Whether towage is required — drives tug fleet scheduling per berth."
    - name: "tidal_window_required"
      expr: tidal_window_required
      comment: "Whether a tidal window is required for the vessel — identifies tide-constrained berth reservations affecting scheduling flexibility."
    - name: "weather_restriction_flag"
      expr: weather_restriction_flag
      comment: "Whether weather restrictions apply — used to quantify weather-sensitive berth demand and plan contingency windows."
    - name: "isps_security_level"
      expr: isps_security_level
      comment: "ISPS security level for the berth reservation — used in security resource planning and compliance reporting."
    - name: "reservation_month"
      expr: DATE_TRUNC('MONTH', reservation_created_timestamp)
      comment: "Month the reservation was created — enables trend analysis of berth demand over time."
    - name: "etb_month"
      expr: DATE_TRUNC('MONTH', etb)
      comment: "Month of estimated time of berthing — used for forward-looking berth capacity planning."
  measures:
    - name: "total_berth_reservations"
      expr: COUNT(1)
      comment: "Total number of berth reservations — baseline volume KPI for berth demand pipeline management."
    - name: "confirmed_berth_reservations"
      expr: COUNT(CASE WHEN reservation_status = 'CONFIRMED' THEN 1 END)
      comment: "Number of confirmed berth reservations — measures firm berth demand for operational scheduling."
    - name: "cancelled_berth_reservations"
      expr: COUNT(CASE WHEN reservation_status = 'CANCELLED' THEN 1 END)
      comment: "Number of cancelled berth reservations — high cancellation rates indicate scheduling instability or carrier reliability issues."
    - name: "berth_cancellation_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN reservation_status = 'CANCELLED' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of berth reservations cancelled — key operational efficiency indicator; elevated rates trigger berth planning review."
    - name: "total_berth_utilization_hours"
      expr: SUM(CAST(berth_utilization_hours AS DOUBLE))
      comment: "Total berth utilization hours across all reservations — primary berth productivity KPI used in capacity planning and revenue optimization."
    - name: "avg_berth_utilization_hours"
      expr: AVG(CAST(berth_utilization_hours AS DOUBLE))
      comment: "Average berth utilization hours per reservation — benchmarks vessel turnaround time and identifies outlier long-stay vessels."
    - name: "avg_vessel_loa_meters"
      expr: AVG(CAST(loa_meters AS DOUBLE))
      comment: "Average vessel length overall (LOA) in metres across berth reservations — used to assess berth length adequacy and plan infrastructure upgrades."
    - name: "avg_vessel_draft_meters"
      expr: AVG(CAST(draft_meters AS DOUBLE))
      comment: "Average vessel draft in metres — used to assess channel and berth depth adequacy for the incoming vessel mix."
    - name: "avg_vessel_dwt_tonnes"
      expr: AVG(CAST(dwt_tonnes AS DOUBLE))
      comment: "Average deadweight tonnage of vessels at berth — indicates cargo capacity mix and informs port dues revenue forecasting."
    - name: "dangerous_goods_reservation_count"
      expr: COUNT(CASE WHEN dangerous_goods_flag = TRUE THEN 1 END)
      comment: "Number of berth reservations involving dangerous goods — drives IMDG berth segregation planning and HSE resource allocation."
    - name: "tidal_constrained_reservation_count"
      expr: COUNT(CASE WHEN tidal_window_required = TRUE THEN 1 END)
      comment: "Number of berth reservations requiring a tidal window — quantifies tide-constrained scheduling complexity for port planners."
    - name: "weather_restricted_reservation_count"
      expr: COUNT(CASE WHEN weather_restriction_flag = TRUE THEN 1 END)
      comment: "Number of berth reservations with weather restrictions — used to assess weather-related scheduling risk and contingency planning needs."
    - name: "distinct_berths_reserved"
      expr: COUNT(DISTINCT berth_id)
      comment: "Number of distinct berths with active reservations — measures berth utilization breadth across the port estate."
$$;


CREATE OR REPLACE VIEW `vibe_shipping_ports_v1`.`_metrics`.`booking_voyage_nomination`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Voyage nomination KPIs covering TEU volume commitments (import/export/transhipment/restow), nomination acceptance rates, and reefer/hazmat cargo mix. Used by commercial and operations teams to validate vessel deployment plans and manage T/S hub throughput."
  source: "`vibe_shipping_ports_v1`.`booking`.`voyage_nomination`"
  dimensions:
    - name: "nomination_status"
      expr: nomination_status
      comment: "Current status of the voyage nomination (e.g. RECEIVED, ACCEPTED, REJECTED) — primary filter for pipeline vs. confirmed vessel deployments."
    - name: "nomination_source"
      expr: nomination_source
      comment: "Source channel of the nomination (e.g. EDI, MANUAL, PCS) — used to measure digital channel adoption and EDI automation rates."
    - name: "shipping_line"
      expr: shipping_line_id
      comment: "Shipping line that submitted the nomination — enables carrier-level volume and performance segmentation."
    - name: "pilotage_required"
      expr: pilotage_required
      comment: "Whether pilotage is required for the nominated voyage — drives marine pilot demand forecasting."
    - name: "towage_required"
      expr: towage_required
      comment: "Whether towage is required for the nominated voyage — drives tug fleet scheduling."
    - name: "nomination_month"
      expr: DATE_TRUNC('MONTH', nomination_received_timestamp)
      comment: "Month the nomination was received — enables trend analysis of nomination volumes and lead times."
    - name: "nominated_eta_month"
      expr: DATE_TRUNC('MONTH', nominated_eta)
      comment: "Month of nominated ETA — used for forward-looking berth and yard capacity planning."
  measures:
    - name: "total_voyage_nominations"
      expr: COUNT(1)
      comment: "Total number of voyage nominations received — baseline volume KPI for vessel deployment pipeline management."
    - name: "accepted_nominations"
      expr: COUNT(CASE WHEN nomination_status = 'ACCEPTED' THEN 1 END)
      comment: "Number of accepted voyage nominations — measures confirmed vessel deployment pipeline."
    - name: "rejected_nominations"
      expr: COUNT(CASE WHEN nomination_status = 'REJECTED' THEN 1 END)
      comment: "Number of rejected voyage nominations — high rejection rates signal capacity constraints or compliance issues requiring management attention."
    - name: "nomination_acceptance_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN nomination_status = 'ACCEPTED' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of voyage nominations accepted — key commercial KPI; declining acceptance rates indicate capacity saturation or carrier relationship issues."
    - name: "total_import_teu_nominated"
      expr: SUM(CAST(import_teu AS DOUBLE))
      comment: "Total import TEU volume across all voyage nominations — primary import throughput demand metric for yard and gate planning."
    - name: "total_export_teu_nominated"
      expr: SUM(CAST(export_teu AS DOUBLE))
      comment: "Total export TEU volume across all voyage nominations — primary export throughput demand metric for vessel loading planning."
    - name: "total_transhipment_teu_nominated"
      expr: SUM(CAST(transhipment_teu AS DOUBLE))
      comment: "Total transhipment (T/S) TEU volume nominated — critical KPI for hub ports (Jebel Ali, Salalah, Singapore) where T/S is 50%+ of volume; drives feeder/relay scheduling."
    - name: "total_restow_teu_nominated"
      expr: SUM(CAST(restow_teu AS DOUBLE))
      comment: "Total restow TEU volume nominated — measures on-board restow demand which drives crane productivity and vessel turnaround time."
    - name: "transhipment_share_pct"
      expr: ROUND(100.0 * SUM(CAST(transhipment_teu AS DOUBLE)) / NULLIF(SUM(CAST(import_teu AS DOUBLE)) + SUM(CAST(export_teu AS DOUBLE)) + SUM(CAST(transhipment_teu AS DOUBLE)), 0), 2)
      comment: "Transhipment TEU as a percentage of total nominated TEU — strategic KPI for hub port positioning; declining T/S share signals competitive threat from rival hubs."
    - name: "avg_import_teu_per_nomination"
      expr: AVG(CAST(import_teu AS DOUBLE))
      comment: "Average import TEU per voyage nomination — benchmarks vessel utilization on import legs and identifies under-loaded calls."
    - name: "avg_export_teu_per_nomination"
      expr: AVG(CAST(export_teu AS DOUBLE))
      comment: "Average export TEU per voyage nomination — benchmarks vessel utilization on export legs."
    - name: "distinct_shipping_lines_nominating"
      expr: COUNT(DISTINCT shipping_line_id)
      comment: "Number of distinct shipping lines submitting voyage nominations — measures carrier diversity and commercial reach of the port."
$$;


CREATE OR REPLACE VIEW `vibe_shipping_ports_v1`.`_metrics`.`booking_slot_reservation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Slot reservation KPIs covering TEU slot utilization, VGM compliance, reefer demand, transhipment slot mix, and reservation conversion rates. Used by terminal planners and commercial teams to optimize vessel slot allocation and stowage planning."
  source: "`vibe_shipping_ports_v1`.`booking`.`slot_reservation`"
  dimensions:
    - name: "reservation_status"
      expr: reservation_status
      comment: "Current status of the slot reservation (e.g. CONFIRMED, CANCELLED, EXPIRED) — primary filter for active slot demand analysis."
    - name: "slot_type"
      expr: slot_type
      comment: "Type of slot reserved (e.g. IMPORT, EXPORT, TRANSHIPMENT, EMPTY) — enables slot mix analysis critical for stowage planning."
    - name: "reefer_required"
      expr: reefer_required
      comment: "Whether the slot requires a reefer plug — drives reefer bay allocation and cold-chain capacity planning."
    - name: "transshipment_indicator"
      expr: transshipment_indicator
      comment: "Whether the slot is for a transhipment container — key dimension for T/S hub throughput analysis."
    - name: "restow_indicator"
      expr: restow_indicator
      comment: "Whether the slot involves a restow move — used to quantify restow demand and its impact on vessel turnaround time."
    - name: "oversize_indicator"
      expr: oversize_indicator
      comment: "Whether the slot is for an out-of-gauge (OOG) container — drives special stowage and crane planning."
    - name: "weight_class"
      expr: weight_class
      comment: "Weight class of the container in the slot — used for stowage stability planning and VGM compliance monitoring."
    - name: "vgm_method"
      expr: vgm_method
      comment: "VGM verification method used (Method 1: weighing; Method 2: calculation) — SOLAS VGM compliance dimension for regulatory reporting."
    - name: "port_of_loading"
      expr: port_of_loading
      comment: "Port of loading for the slot — enables origin-based volume analysis and service route performance tracking."
    - name: "port_of_discharge"
      expr: port_of_discharge
      comment: "Port of discharge for the slot — enables destination-based volume analysis and trade lane performance tracking."
    - name: "reservation_month"
      expr: DATE_TRUNC('MONTH', reserved_at)
      comment: "Month the slot was reserved — enables trend analysis of slot booking lead times and demand patterns."
    - name: "slot_rate_currency"
      expr: slot_rate_currency
      comment: "Currency of the slot rate — used for multi-currency revenue analysis and FX exposure reporting."
  measures:
    - name: "total_slot_reservations"
      expr: COUNT(1)
      comment: "Total number of slot reservations — baseline volume KPI for vessel slot demand management."
    - name: "confirmed_slot_reservations"
      expr: COUNT(CASE WHEN reservation_status = 'CONFIRMED' THEN 1 END)
      comment: "Number of confirmed slot reservations — measures firm slot demand for vessel stowage planning (BAPLIE generation)."
    - name: "cancelled_slot_reservations"
      expr: COUNT(CASE WHEN reservation_status = 'CANCELLED' THEN 1 END)
      comment: "Number of cancelled slot reservations — high cancellation rates indicate no-show risk and revenue leakage."
    - name: "slot_confirmation_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN reservation_status = 'CONFIRMED' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of slot reservations confirmed — measures slot booking conversion efficiency; low rates indicate demand uncertainty or overbooking issues."
    - name: "total_teu_slots_reserved"
      expr: SUM(CAST(teu_count AS DOUBLE))
      comment: "Total TEU volume across all slot reservations — primary slot utilization KPI for vessel capacity management."
    - name: "total_slot_revenue"
      expr: SUM(CAST(slot_rate_amount AS DOUBLE))
      comment: "Total slot revenue across all reservations — key commercial KPI for slot sales performance and revenue forecasting."
    - name: "avg_slot_rate_per_teu"
      expr: ROUND(SUM(CAST(slot_rate_amount AS DOUBLE)) / NULLIF(SUM(CAST(teu_count AS DOUBLE)), 0), 2)
      comment: "Average slot rate per TEU — measures slot yield and pricing effectiveness; declining yield triggers commercial review."
    - name: "transhipment_slot_count"
      expr: COUNT(CASE WHEN transshipment_indicator = TRUE THEN 1 END)
      comment: "Number of transhipment slot reservations — critical volume KPI for hub port T/S operations."
    - name: "transhipment_teu_reserved"
      expr: SUM(CAST(CASE WHEN transshipment_indicator = TRUE THEN teu_count ELSE 0 END AS INT))
      comment: "TEU volume from transhipment slot reservations — strategic KPI for hub port T/S throughput tracking."
    - name: "reefer_slot_count"
      expr: COUNT(CASE WHEN reefer_required = TRUE THEN 1 END)
      comment: "Number of reefer slot reservations — drives reefer plug and cold-chain infrastructure capacity planning."
    - name: "reefer_teu_reserved"
      expr: SUM(CAST(CASE WHEN reefer_required = TRUE THEN teu_count ELSE 0 END AS INT))
      comment: "TEU volume from reefer slot reservations — used to assess reefer bay utilization and premium revenue contribution."
    - name: "vgm_verified_slot_count"
      expr: COUNT(CASE WHEN vgm_verified_at IS NOT NULL THEN 1 END)
      comment: "Number of slot reservations with VGM verified — SOLAS compliance KPI; unverified VGM slots cannot be loaded and represent revenue-at-risk."
    - name: "vgm_compliance_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN vgm_verified_at IS NOT NULL THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of slot reservations with VGM verified — SOLAS regulatory compliance KPI; below 100% indicates loading risk and potential port state control issues."
    - name: "avg_verified_gross_mass_kg"
      expr: AVG(CAST(verified_gross_mass_kg AS DOUBLE))
      comment: "Average verified gross mass per slot reservation — used for vessel stability planning and structural load assessment."
    - name: "restow_slot_count"
      expr: COUNT(CASE WHEN restow_indicator = TRUE THEN 1 END)
      comment: "Number of slot reservations flagged for restow — quantifies restow demand which directly impacts crane productivity and vessel turnaround time."
$$;


CREATE OR REPLACE VIEW `vibe_shipping_ports_v1`.`_metrics`.`booking_service_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Service order KPIs covering cost performance, SLA compliance, hazardous cargo handling, and service delivery efficiency. Used by operations managers and finance teams to monitor ancillary service revenue, cost control, and SLA adherence."
  source: "`vibe_shipping_ports_v1`.`booking`.`booking_service_order`"
  dimensions:
    - name: "service_status"
      expr: service_status
      comment: "Current status of the service order (e.g. REQUESTED, CONFIRMED, COMPLETED, CANCELLED) — primary filter for active vs. completed service demand."
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level of the service order — used to segment SLA performance by urgency tier."
    - name: "hazardous_cargo_flag"
      expr: hazardous_cargo_flag
      comment: "Whether the service order involves hazardous cargo — drives IMDG-compliant resource allocation and safety planning."
    - name: "isps_security_level"
      expr: isps_security_level
      comment: "ISPS security level for the service order — used in security resource planning and compliance reporting."
    - name: "sla_compliance_flag"
      expr: sla_compliance_flag
      comment: "Whether the service order met its SLA — primary SLA performance dimension for service quality monitoring."
    - name: "environmental_compliance_flag"
      expr: environmental_compliance_flag
      comment: "Whether the service order met environmental compliance requirements — used for MARPOL and sustainability reporting."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the service order cost — used for multi-currency cost analysis and FX exposure reporting."
    - name: "service_order_month"
      expr: DATE_TRUNC('MONTH', created_timestamp)
      comment: "Month the service order was created — enables trend analysis of service demand and cost over time."
  measures:
    - name: "total_service_orders"
      expr: COUNT(1)
      comment: "Total number of service orders — baseline volume KPI for ancillary service demand management."
    - name: "completed_service_orders"
      expr: COUNT(CASE WHEN service_status = 'COMPLETED' THEN 1 END)
      comment: "Number of completed service orders — measures service delivery throughput and operational capacity utilization."
    - name: "total_actual_cost"
      expr: SUM(CAST(actual_cost_amount AS DOUBLE))
      comment: "Total actual cost of service orders — primary cost KPI for ancillary services P&L management."
    - name: "total_estimated_cost"
      expr: SUM(CAST(estimated_cost_amount AS DOUBLE))
      comment: "Total estimated cost of service orders — used as budget baseline for cost variance analysis."
    - name: "cost_variance"
      expr: ROUND(SUM(CAST(actual_cost_amount AS DOUBLE)) - SUM(CAST(estimated_cost_amount AS DOUBLE)), 2)
      comment: "Total cost variance (actual minus estimated) across service orders — positive variance indicates cost overruns requiring management intervention."
    - name: "cost_variance_pct"
      expr: ROUND(100.0 * (SUM(CAST(actual_cost_amount AS DOUBLE)) - SUM(CAST(estimated_cost_amount AS DOUBLE))) / NULLIF(SUM(CAST(estimated_cost_amount AS DOUBLE)), 0), 2)
      comment: "Percentage cost variance for service orders — measures budget accuracy and cost control effectiveness; large positive values trigger cost review."
    - name: "sla_compliant_order_count"
      expr: COUNT(CASE WHEN sla_compliance_flag = TRUE THEN 1 END)
      comment: "Number of service orders meeting SLA — measures service quality delivery against contractual commitments."
    - name: "sla_compliance_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN sla_compliance_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of service orders meeting SLA — key service quality KPI; declining rates trigger SLA review and potential contract penalty exposure."
    - name: "hazardous_service_order_count"
      expr: COUNT(CASE WHEN hazardous_cargo_flag = TRUE THEN 1 END)
      comment: "Number of service orders involving hazardous cargo — drives IMDG-compliant resource planning and HSE risk assessment."
    - name: "avg_actual_cost_per_order"
      expr: AVG(CAST(actual_cost_amount AS DOUBLE))
      comment: "Average actual cost per service order — benchmarks service cost efficiency and identifies high-cost service categories."
    - name: "total_service_quantity"
      expr: SUM(CAST(service_quantity AS DOUBLE))
      comment: "Total service quantity delivered across all orders — measures operational throughput volume for ancillary services."
$$;


CREATE OR REPLACE VIEW `vibe_shipping_ports_v1`.`_metrics`.`booking_pre_arrival`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Pre-arrival notification KPIs covering submission compliance, health/customs clearance rates, dangerous goods declarations, and service demand (bunker, fresh water, waste disposal). Used by port authority, customs, and marine operations teams to manage pre-arrival compliance and service readiness."
  source: "`vibe_shipping_ports_v1`.`booking`.`pre_arrival`"
  dimensions:
    - name: "submission_status"
      expr: submission_status
      comment: "Status of the pre-arrival notification submission (e.g. SUBMITTED, ACKNOWLEDGED, REJECTED) — primary filter for compliance pipeline analysis."
    - name: "health_declaration_status"
      expr: health_declaration_status
      comment: "Status of the vessel health declaration — used for port health authority compliance monitoring and quarantine risk assessment."
    - name: "port_health_clearance_status"
      expr: port_health_clearance_status
      comment: "Port health clearance status — identifies vessels at risk of quarantine hold which impacts berth scheduling."
    - name: "isps_security_level"
      expr: isps_security_level
      comment: "ISPS security level declared in pre-arrival — used for security resource planning and MARSEC compliance."
    - name: "dangerous_goods_onboard"
      expr: dangerous_goods_onboard
      comment: "Whether dangerous goods are declared onboard — drives IMDG berth segregation and emergency response planning."
    - name: "pilotage_required"
      expr: pilotage_required
      comment: "Whether pilotage is required — drives marine pilot demand forecasting from pre-arrival data."
    - name: "towage_required"
      expr: towage_required
      comment: "Whether towage is required — drives tug fleet scheduling from pre-arrival data."
    - name: "bunker_fuel_required"
      expr: bunker_fuel_required
      comment: "Whether bunker fuel is requested — drives bunker barge scheduling and fuel inventory planning."
    - name: "waste_disposal_required"
      expr: waste_disposal_required
      comment: "Whether waste disposal is requested — drives MARPOL waste reception facility scheduling."
    - name: "submission_month"
      expr: DATE_TRUNC('MONTH', submission_timestamp)
      comment: "Month of pre-arrival submission — enables trend analysis of pre-arrival compliance and lead times."
    - name: "eta_month"
      expr: DATE_TRUNC('MONTH', eta)
      comment: "Month of estimated time of arrival — used for forward-looking port readiness planning."
  measures:
    - name: "total_pre_arrivals"
      expr: COUNT(1)
      comment: "Total number of pre-arrival notifications submitted — baseline volume KPI for port arrival pipeline management."
    - name: "acknowledged_pre_arrivals"
      expr: COUNT(CASE WHEN submission_status = 'ACKNOWLEDGED' THEN 1 END)
      comment: "Number of pre-arrival notifications acknowledged by the port — measures pre-arrival processing throughput."
    - name: "rejected_pre_arrivals"
      expr: COUNT(CASE WHEN submission_status = 'REJECTED' THEN 1 END)
      comment: "Number of rejected pre-arrival notifications — high rejection rates indicate data quality issues or compliance failures requiring process improvement."
    - name: "pre_arrival_rejection_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN submission_status = 'REJECTED' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of pre-arrival notifications rejected — compliance quality KPI; elevated rates trigger agent training and process review."
    - name: "total_teu_declared"
      expr: SUM(CAST(total_teu AS DOUBLE))
      comment: "Total TEU declared in pre-arrival notifications — used to validate cargo manifest accuracy against actual vessel arrival."
    - name: "total_cargo_weight_tonnes"
      expr: SUM(CAST(total_cargo_weight_tonnes AS DOUBLE))
      comment: "Total cargo weight in tonnes declared in pre-arrivals — used for berth structural load planning and port dues calculation."
    - name: "dangerous_goods_declaration_count"
      expr: COUNT(CASE WHEN dangerous_goods_onboard = TRUE THEN 1 END)
      comment: "Number of pre-arrivals with dangerous goods declared — drives IMDG emergency response planning and berth segregation."
    - name: "dangerous_goods_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN dangerous_goods_onboard = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of pre-arrivals with dangerous goods declared — port-wide DG exposure KPI for HSE and compliance management."
    - name: "bunker_demand_count"
      expr: COUNT(CASE WHEN bunker_fuel_required = TRUE THEN 1 END)
      comment: "Number of pre-arrivals requesting bunker fuel — drives bunker barge scheduling and fuel inventory management."
    - name: "waste_disposal_demand_count"
      expr: COUNT(CASE WHEN waste_disposal_required = TRUE THEN 1 END)
      comment: "Number of pre-arrivals requesting waste disposal — drives MARPOL waste reception facility capacity planning."
    - name: "health_clearance_pending_count"
      expr: COUNT(CASE WHEN port_health_clearance_status NOT IN ('CLEARED', 'APPROVED') THEN 1 END)
      comment: "Number of pre-arrivals with pending port health clearance — identifies vessels at risk of quarantine delay impacting berth scheduling."
    - name: "avg_teu_per_pre_arrival"
      expr: AVG(CAST(total_teu AS DOUBLE))
      comment: "Average TEU per pre-arrival notification — benchmarks vessel size mix and validates against booking commitments."
$$;


CREATE OR REPLACE VIEW `vibe_shipping_ports_v1`.`_metrics`.`booking_amendment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Booking amendment KPIs covering amendment volumes, SLA breach rates, dispute rates, cancellation fee exposure, and EDI automation. Used by commercial and operations teams to monitor booking change management quality, financial exposure, and process efficiency."
  source: "`vibe_shipping_ports_v1`.`booking`.`amendment`"
  dimensions:
    - name: "amendment_status"
      expr: amendment_status
      comment: "Current status of the amendment (e.g. PENDING, APPROVED, REJECTED) — primary filter for amendment pipeline analysis."
    - name: "amendment_type"
      expr: amendment_type
      comment: "Type of amendment (e.g. ETA_CHANGE, CARGO_CHANGE, CANCELLATION) — enables root cause analysis of booking instability."
    - name: "booking_entity_type"
      expr: booking_entity_type
      comment: "Type of booking entity being amended (e.g. CALL_BOOKING, CARGO_BOOKING) — used to segment amendment volumes by booking type."
    - name: "sla_breach_flag"
      expr: sla_breach_flag
      comment: "Whether the amendment processing breached SLA — primary SLA compliance dimension for amendment handling performance."
    - name: "dispute_flag"
      expr: dispute_flag
      comment: "Whether the amendment is under dispute — used to identify commercially sensitive amendments requiring escalation."
    - name: "cancellation_fee_applicable"
      expr: cancellation_fee_applicable
      comment: "Whether a cancellation fee applies to the amendment — used to track cancellation fee revenue exposure."
    - name: "demurrage_impact_flag"
      expr: demurrage_impact_flag
      comment: "Whether the amendment has a demurrage impact — used to quantify demurrage risk from booking changes."
    - name: "reason_code"
      expr: reason_code
      comment: "Reason code for the amendment — enables root cause analysis of booking change drivers."
    - name: "amendment_month"
      expr: DATE_TRUNC('MONTH', request_timestamp)
      comment: "Month the amendment was requested — enables trend analysis of amendment volumes and seasonality."
  measures:
    - name: "total_amendments"
      expr: COUNT(1)
      comment: "Total number of booking amendments — baseline volume KPI for booking change management; high volumes indicate booking instability."
    - name: "approved_amendments"
      expr: COUNT(CASE WHEN amendment_status = 'APPROVED' THEN 1 END)
      comment: "Number of approved amendments — measures amendment processing throughput."
    - name: "rejected_amendments"
      expr: COUNT(CASE WHEN amendment_status = 'REJECTED' THEN 1 END)
      comment: "Number of rejected amendments — high rejection rates indicate poor booking quality or commercial disputes."
    - name: "amendment_approval_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN amendment_status = 'APPROVED' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of amendments approved — measures amendment processing efficiency and commercial flexibility."
    - name: "sla_breach_count"
      expr: COUNT(CASE WHEN sla_breach_flag = TRUE THEN 1 END)
      comment: "Number of amendments that breached SLA — measures amendment processing quality; breaches may trigger contractual penalties."
    - name: "sla_breach_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN sla_breach_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of amendments breaching SLA — key service quality KPI; elevated rates trigger process improvement and staffing review."
    - name: "disputed_amendment_count"
      expr: COUNT(CASE WHEN dispute_flag = TRUE THEN 1 END)
      comment: "Number of disputed amendments — measures commercial dispute exposure; high counts indicate contract or pricing issues."
    - name: "total_cancellation_fee_amount"
      expr: SUM(CAST(cancellation_fee_amount AS DOUBLE))
      comment: "Total cancellation fee revenue from amendments — measures ancillary revenue from booking cancellations and changes."
    - name: "avg_cancellation_fee_amount"
      expr: AVG(CAST(CASE WHEN cancellation_fee_applicable = TRUE THEN cancellation_fee_amount END AS INT))
      comment: "Average cancellation fee per applicable amendment — benchmarks fee levels against tariff schedules and identifies anomalous waivers."
    - name: "demurrage_impacted_amendment_count"
      expr: COUNT(CASE WHEN demurrage_impact_flag = TRUE THEN 1 END)
      comment: "Number of amendments with demurrage impact — quantifies demurrage risk exposure from booking changes; drives proactive customer communication."
    - name: "distinct_participants_amending"
      expr: COUNT(DISTINCT port_community_participant_id)
      comment: "Number of distinct port community participants submitting amendments — measures breadth of booking instability across the customer base."
$$;


CREATE OR REPLACE VIEW `vibe_shipping_ports_v1`.`_metrics`.`booking_truck_gate_booking`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Truck gate booking KPIs covering appointment utilization, no-show rates, hazardous cargo volumes, and gate throughput efficiency. Used by terminal operations and security teams to optimize gate capacity, reduce congestion, and ensure IMDG/customs compliance."
  source: "`vibe_shipping_ports_v1`.`booking`.`truck_gate_booking`"
  dimensions:
    - name: "appointment_status"
      expr: appointment_status
      comment: "Current status of the truck gate appointment (e.g. BOOKED, CHECKED_IN, COMPLETED, NO_SHOW) — primary filter for gate utilization analysis."
    - name: "appointment_type"
      expr: appointment_type
      comment: "Type of gate appointment (e.g. IMPORT_PICKUP, EXPORT_DROP, EMPTY_RETURN) — enables gate transaction mix analysis."
    - name: "is_hazardous_cargo"
      expr: is_hazardous_cargo
      comment: "Whether the truck appointment involves hazardous cargo — drives IMDG gate lane allocation and security screening planning."
    - name: "is_refrigerated"
      expr: is_refrigerated
      comment: "Whether the appointment involves a refrigerated container — drives reefer inspection resource planning at the gate."
    - name: "is_oversize"
      expr: is_oversize
      comment: "Whether the appointment involves an oversize container — drives special gate lane and escort planning."
    - name: "no_show_flag"
      expr: no_show_flag
      comment: "Whether the truck appointment was a no-show — key gate efficiency dimension; high no-show rates waste gate capacity and disrupt yard planning."
    - name: "container_condition"
      expr: container_condition
      comment: "Condition of the container at gate (e.g. GOOD, DAMAGED) — used for EIR/damage claim tracking and depot repair planning."
    - name: "appointment_date"
      expr: DATE_TRUNC('DAY', appointment_date)
      comment: "Date of the truck gate appointment — enables daily gate throughput trend analysis and capacity planning."
    - name: "appointment_month"
      expr: DATE_TRUNC('MONTH', appointment_date)
      comment: "Month of the truck gate appointment — enables monthly gate throughput trend analysis."
  measures:
    - name: "total_gate_appointments"
      expr: COUNT(1)
      comment: "Total number of truck gate appointments — baseline volume KPI for gate capacity planning and throughput management."
    - name: "completed_gate_appointments"
      expr: COUNT(CASE WHEN appointment_status = 'COMPLETED' THEN 1 END)
      comment: "Number of completed gate appointments — measures actual gate throughput delivered."
    - name: "no_show_count"
      expr: COUNT(CASE WHEN no_show_flag = TRUE THEN 1 END)
      comment: "Number of truck gate no-shows — measures wasted gate capacity; high no-show rates trigger appointment policy review."
    - name: "no_show_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN no_show_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of gate appointments that were no-shows — key gate efficiency KPI; elevated rates indicate need for appointment deposit or penalty policy."
    - name: "hazardous_cargo_appointment_count"
      expr: COUNT(CASE WHEN is_hazardous_cargo = TRUE THEN 1 END)
      comment: "Number of gate appointments involving hazardous cargo — drives IMDG-compliant gate lane allocation and security screening resource planning."
    - name: "hazardous_cargo_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_hazardous_cargo = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of gate appointments involving hazardous cargo — port-wide DG gate exposure KPI for HSE and compliance management."
    - name: "total_cargo_weight_kg"
      expr: SUM(CAST(cargo_weight_kg AS DOUBLE))
      comment: "Total cargo weight in kg across gate appointments — used for gate weighbridge compliance and VGM validation."
    - name: "avg_cargo_weight_kg"
      expr: AVG(CAST(cargo_weight_kg AS DOUBLE))
      comment: "Average cargo weight per gate appointment — benchmarks load profiles and identifies overweight vehicle risk."
    - name: "reefer_appointment_count"
      expr: COUNT(CASE WHEN is_refrigerated = TRUE THEN 1 END)
      comment: "Number of gate appointments for refrigerated containers — drives reefer inspection staffing and cold-chain gate lane planning."
    - name: "distinct_trucking_companies"
      expr: COUNT(DISTINCT port_community_participant_id)
      comment: "Number of distinct trucking companies using the gate — measures haulier diversity and identifies concentration risk in gate throughput."
$$;


CREATE OR REPLACE VIEW `vibe_shipping_ports_v1`.`_metrics`.`booking_resource_allocation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Resource allocation KPIs covering cost performance, utilization efficiency, SLA compliance, and hazmat-certified resource deployment. Used by operations managers and finance teams to optimize port resource deployment, control costs, and ensure SLA adherence."
  source: "`vibe_shipping_ports_v1`.`booking`.`resource_allocation`"
  dimensions:
    - name: "allocation_status"
      expr: allocation_status
      comment: "Current status of the resource allocation (e.g. ALLOCATED, CONFIRMED, COMPLETED, CANCELLED) — primary filter for active vs. completed resource demand."
    - name: "resource_type"
      expr: resource_type
      comment: "Type of resource allocated (e.g. CRANE, GANG, EQUIPMENT, PILOT) — enables resource category performance analysis."
    - name: "allocation_source"
      expr: allocation_source
      comment: "Source of the allocation (e.g. MANUAL, AUTOMATED, EDI) — used to measure automation adoption in resource planning."
    - name: "hazmat_certified_flag"
      expr: hazmat_certified_flag
      comment: "Whether the allocated resource is hazmat certified — used to ensure IMDG-compliant resource deployment for DG cargo."
    - name: "sla_compliance_flag"
      expr: sla_compliance_flag
      comment: "Whether the resource allocation met its SLA — primary SLA performance dimension for resource deployment quality."
    - name: "swl_compliance_flag"
      expr: swl_compliance_flag
      comment: "Whether the allocation met Safe Working Load (SWL) compliance requirements — critical safety KPI for lifting equipment operations."
    - name: "weather_restriction_flag"
      expr: weather_restriction_flag
      comment: "Whether weather restrictions applied to the allocation — used to quantify weather-related resource disruption."
    - name: "isps_security_level"
      expr: isps_security_level
      comment: "ISPS security level for the resource allocation — used in security resource planning and compliance reporting."
    - name: "allocation_month"
      expr: DATE_TRUNC('MONTH', created_timestamp)
      comment: "Month the resource allocation was created — enables trend analysis of resource demand and cost over time."
  measures:
    - name: "total_resource_allocations"
      expr: COUNT(1)
      comment: "Total number of resource allocations — baseline volume KPI for port resource demand management."
    - name: "total_actual_cost"
      expr: SUM(CAST(actual_cost_amount AS DOUBLE))
      comment: "Total actual cost of resource allocations — primary cost KPI for port operations P&L management."
    - name: "total_estimated_cost"
      expr: SUM(CAST(estimated_cost_amount AS DOUBLE))
      comment: "Total estimated cost of resource allocations — budget baseline for cost variance analysis."
    - name: "cost_variance"
      expr: ROUND(SUM(CAST(actual_cost_amount AS DOUBLE)) - SUM(CAST(estimated_cost_amount AS DOUBLE)), 2)
      comment: "Total cost variance (actual minus estimated) — positive variance indicates cost overruns requiring management intervention."
    - name: "cost_variance_pct"
      expr: ROUND(100.0 * (SUM(CAST(actual_cost_amount AS DOUBLE)) - SUM(CAST(estimated_cost_amount AS DOUBLE))) / NULLIF(SUM(CAST(estimated_cost_amount AS DOUBLE)), 0), 2)
      comment: "Percentage cost variance for resource allocations — measures budget accuracy; large positive values trigger cost control review."
    - name: "total_actual_duration_hours"
      expr: SUM(CAST(actual_duration_hours AS DOUBLE))
      comment: "Total actual resource utilization hours — measures operational throughput and resource productivity."
    - name: "avg_actual_duration_hours"
      expr: AVG(CAST(actual_duration_hours AS DOUBLE))
      comment: "Average actual duration per resource allocation — benchmarks resource utilization efficiency and identifies outlier long-duration deployments."
    - name: "duration_variance_hours"
      expr: ROUND(SUM(CAST(actual_duration_hours AS DOUBLE)) - SUM(CAST(estimated_duration_hours AS DOUBLE)), 2)
      comment: "Total duration variance (actual minus estimated hours) — measures scheduling accuracy; positive variance indicates resource over-deployment."
    - name: "sla_compliant_allocation_count"
      expr: COUNT(CASE WHEN sla_compliance_flag = TRUE THEN 1 END)
      comment: "Number of resource allocations meeting SLA — measures resource deployment quality against contractual commitments."
    - name: "sla_compliance_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN sla_compliance_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of resource allocations meeting SLA — key operational quality KPI; declining rates trigger resource planning and staffing review."
    - name: "hazmat_certified_allocation_count"
      expr: COUNT(CASE WHEN hazmat_certified_flag = TRUE THEN 1 END)
      comment: "Number of resource allocations using hazmat-certified resources — measures IMDG-compliant resource deployment for dangerous goods operations."
    - name: "swl_non_compliant_count"
      expr: COUNT(CASE WHEN swl_compliance_flag = FALSE THEN 1 END)
      comment: "Number of resource allocations with SWL non-compliance — critical safety KPI; any non-zero value triggers immediate HSE investigation."
$$;


CREATE OR REPLACE VIEW `vibe_shipping_ports_v1`.`_metrics`.`booking_confirmation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Booking confirmation KPIs covering confirmation rates, financial exposure, dangerous goods approvals, and SLA commitments. Used by commercial and operations teams to monitor booking confirmation quality, revenue commitments, and compliance approvals."
  source: "`vibe_shipping_ports_v1`.`booking`.`confirmation`"
  dimensions:
    - name: "confirmation_status"
      expr: confirmation_status
      comment: "Current status of the booking confirmation (e.g. ISSUED, ACKNOWLEDGED, CANCELLED) — primary filter for active confirmation pipeline."
    - name: "confirmation_type"
      expr: confirmation_type
      comment: "Type of confirmation (e.g. BERTH, CARGO, SERVICE) — enables segmentation of confirmation volumes by booking category."
    - name: "isps_security_level"
      expr: isps_security_level
      comment: "ISPS security level in the confirmation — used for security compliance reporting."
    - name: "dangerous_goods_approved_flag"
      expr: dangerous_goods_approved_flag
      comment: "Whether dangerous goods have been approved in the confirmation — IMDG compliance dimension for DG cargo approvals."
    - name: "pilotage_confirmed_flag"
      expr: pilotage_confirmed_flag
      comment: "Whether pilotage has been confirmed — measures marine services confirmation completeness."
    - name: "towage_confirmed_flag"
      expr: towage_confirmed_flag
      comment: "Whether towage has been confirmed — measures tug service confirmation completeness."
    - name: "mooring_services_confirmed_flag"
      expr: mooring_services_confirmed_flag
      comment: "Whether mooring services have been confirmed — measures mooring gang confirmation completeness."
    - name: "terms_accepted_flag"
      expr: terms_accepted_flag
      comment: "Whether terms and conditions have been accepted — measures T&C acceptance compliance rate."
    - name: "confirmation_month"
      expr: DATE_TRUNC('MONTH', issued_timestamp)
      comment: "Month the confirmation was issued — enables trend analysis of confirmation volumes and revenue commitments."
    - name: "charges_currency_code"
      expr: charges_currency_code
      comment: "Currency of the estimated charges — used for multi-currency revenue analysis and FX exposure reporting."
  measures:
    - name: "total_confirmations"
      expr: COUNT(1)
      comment: "Total number of booking confirmations issued — baseline volume KPI for confirmed booking pipeline management."
    - name: "active_confirmations"
      expr: COUNT(CASE WHEN confirmation_status NOT IN ('CANCELLED') THEN 1 END)
      comment: "Number of active (non-cancelled) confirmations — measures the live confirmed booking portfolio."
    - name: "cancelled_confirmations"
      expr: COUNT(CASE WHEN confirmation_status = 'CANCELLED' THEN 1 END)
      comment: "Number of cancelled confirmations — measures revenue-at-risk from booking cancellations."
    - name: "total_estimated_charges"
      expr: SUM(CAST(estimated_total_charges_amount AS DOUBLE))
      comment: "Total estimated charges across all confirmations — primary revenue pipeline KPI for port commercial management."
    - name: "avg_estimated_charges_per_confirmation"
      expr: AVG(CAST(estimated_total_charges_amount AS DOUBLE))
      comment: "Average estimated charges per confirmation — benchmarks revenue per vessel call and identifies high-value vs. low-value bookings."
    - name: "dangerous_goods_approved_count"
      expr: COUNT(CASE WHEN dangerous_goods_approved_flag = TRUE THEN 1 END)
      comment: "Number of confirmations with dangerous goods approved — measures IMDG DG approval throughput for compliance reporting."
    - name: "terms_acceptance_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN terms_accepted_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of confirmations with T&C accepted — measures contractual compliance; below 100% indicates legal exposure."
    - name: "pilotage_confirmation_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN pilotage_confirmed_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of confirmations with pilotage confirmed — measures marine services booking completeness."
    - name: "distinct_shipping_lines_confirmed"
      expr: COUNT(DISTINCT shipping_line_id)
      comment: "Number of distinct shipping lines with confirmed bookings — measures active carrier portfolio breadth."
$$;
