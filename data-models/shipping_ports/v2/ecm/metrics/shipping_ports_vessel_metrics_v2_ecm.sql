-- Metric views for domain: vessel | Business: Shipping_Ports | Version: 2 | Generated on: 2026-07-13 07:51:56

CREATE OR REPLACE VIEW `vibe_shipping_ports_v1`.`_metrics`.`vessel_call`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core vessel call performance metrics tracking port productivity, turnaround efficiency, and cargo throughput per vessel visit. Used by port operations management to steer berth utilisation, vessel scheduling, and cargo handling KPIs."
  source: "`vibe_shipping_ports_v1`.`vessel`.`call`"
  dimensions:
    - name: "call_status"
      expr: call_status
      comment: "Current status of the vessel call (e.g. PLANNED, IN_PORT, DEPARTED) for operational filtering."
    - name: "call_purpose"
      expr: purpose
      comment: "Purpose of the vessel call (cargo, bunkering, crew change, etc.) enabling purpose-based performance segmentation."
    - name: "cargo_type"
      expr: cargo_type
      comment: "Type of cargo being handled during the call (containerised, bulk, RoRo, etc.)."
    - name: "isps_security_level"
      expr: isps_security_level
      comment: "ISPS security level in effect during the call, used for compliance and risk reporting."
    - name: "dangerous_goods_flag"
      expr: dangerous_goods_flag
      comment: "Indicates whether dangerous goods (IMDG) were declared for this call, enabling DG-specific performance analysis."
    - name: "port_state_control_inspection_flag"
      expr: port_state_control_inspection_flag
      comment: "Flags calls that received a Port State Control inspection, used to track PSC exposure."
    - name: "call_month"
      expr: DATE_TRUNC('month', ata)
      comment: "Month of actual vessel arrival, used for trend analysis of call volumes and productivity."
    - name: "call_year"
      expr: DATE_TRUNC('year', ata)
      comment: "Year of actual vessel arrival for annual performance benchmarking."
    - name: "voyage_number"
      expr: voyage_number
      comment: "Voyage number associated with the call, enabling voyage-level aggregation."
    - name: "pod"
      expr: pod
      comment: "Port of Discharge declared for this call, used for trade lane analysis."
    - name: "pol"
      expr: pol
      comment: "Port of Loading declared for this call, used for trade lane analysis."
  measures:
    - name: "total_vessel_calls"
      expr: COUNT(1)
      comment: "Total number of vessel calls. Primary volume KPI for port throughput and berth demand planning."
    - name: "avg_port_stay_hours"
      expr: AVG(CAST(UNIX_TIMESTAMP(atd) - UNIX_TIMESTAMP(ata) AS DOUBLE) / 3600.0)
      comment: "Average port stay duration in hours from actual arrival to actual departure. Core turnaround efficiency KPI — shorter stays indicate higher berth productivity."
    - name: "avg_cargo_ops_duration_hours"
      expr: AVG(CAST(UNIX_TIMESTAMP(cargo_ops_end_timestamp) - UNIX_TIMESTAMP(cargo_ops_start_timestamp) AS DOUBLE) / 3600.0)
      comment: "Average duration of cargo operations in hours. Measures stevedoring and terminal handling efficiency per call."
    - name: "avg_pilot_boarding_to_all_fast_hours"
      expr: AVG(CAST(UNIX_TIMESTAMP(all_fast_timestamp) - UNIX_TIMESTAMP(pilot_boarded_timestamp) AS DOUBLE) / 3600.0)
      comment: "Average time from pilot boarding to vessel all-fast at berth, in hours. Measures marine services efficiency and channel transit performance."
    - name: "avg_berth_waiting_hours"
      expr: AVG(CAST(UNIX_TIMESTAMP(atb) - UNIX_TIMESTAMP(ata) AS DOUBLE) / 3600.0)
      comment: "Average waiting time from actual arrival to actual berthing in hours. High values indicate berth congestion or scheduling inefficiency."
    - name: "psc_inspection_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(CASE WHEN port_state_control_inspection_flag = TRUE THEN 1 ELSE 0 END AS INT)) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of vessel calls that received a Port State Control inspection. Elevated rates signal fleet compliance risk and potential detention exposure."
    - name: "dangerous_goods_call_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(CASE WHEN dangerous_goods_flag = TRUE THEN 1 ELSE 0 END AS INT)) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of calls carrying dangerous goods (IMDG). Used for ISPS/IMDG risk planning and resource allocation for DG handling."
    - name: "baplie_receipt_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(CASE WHEN baplie_received_flag = TRUE THEN 1 ELSE 0 END AS INT)) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of calls for which a BAPLIE stowage plan was received. Low rates indicate EDI/PCS integration gaps with shipping lines."
    - name: "avg_eta_to_ata_variance_hours"
      expr: AVG(CAST(UNIX_TIMESTAMP(ata) - UNIX_TIMESTAMP(eta) AS DOUBLE) / 3600.0)
      comment: "Average deviation between estimated and actual arrival time in hours. Positive values indicate late arrivals; used to assess schedule reliability and berth planning accuracy."
    - name: "avg_etd_to_atd_variance_hours"
      expr: AVG(CAST(UNIX_TIMESTAMP(atd) - UNIX_TIMESTAMP(etd) AS DOUBLE) / 3600.0)
      comment: "Average deviation between estimated and actual departure time in hours. Measures operational punctuality and downstream schedule impact."
$$;

CREATE OR REPLACE VIEW `vibe_shipping_ports_v1`.`_metrics`.`vessel_voyage`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Voyage-level performance metrics covering cargo capacity utilisation, schedule reliability, and operational status. Used by commercial and operations teams to manage fleet deployment efficiency and service reliability."
  source: "`vibe_shipping_ports_v1`.`vessel`.`voyage`"
  dimensions:
    - name: "voyage_status"
      expr: voyage_status
      comment: "Current status of the voyage (PLANNED, IN_PROGRESS, COMPLETED, OMITTED) for operational filtering."
    - name: "voyage_type"
      expr: voyage_type
      comment: "Type of voyage (laden, ballast, coastal, international) for trade and fleet analysis."
    - name: "service_code"
      expr: service_code
      comment: "Shipping line service code identifying the trade lane rotation, enabling service-level performance analysis."
    - name: "service_name"
      expr: service_name
      comment: "Human-readable service name for the shipping line rotation."
    - name: "is_omitted"
      expr: is_omitted
      comment: "Flags voyages that were omitted (port skipped), used to track service reliability and commercial impact."
    - name: "is_maiden_call"
      expr: is_maiden_call
      comment: "Flags maiden calls for new service launches, used in commercial reporting."
    - name: "customs_clearance_status"
      expr: customs_clearance_status
      comment: "Customs clearance status of the voyage, used for compliance and dwell-time analysis."
    - name: "voyage_month"
      expr: DATE_TRUNC('month', start_date)
      comment: "Month the voyage commenced, used for monthly throughput and utilisation trending."
    - name: "destination_port_code"
      expr: destination_port_code
      comment: "Destination port code for trade lane segmentation."
    - name: "origin_port_code"
      expr: origin_port_code
      comment: "Origin port code for trade lane segmentation."
    - name: "imdg_cargo_onboard_flag"
      expr: imdg_cargo_onboard_flag
      comment: "Indicates IMDG dangerous goods are onboard, used for risk and compliance reporting."
  measures:
    - name: "total_voyages"
      expr: COUNT(1)
      comment: "Total number of voyages. Primary volume KPI for fleet activity and service frequency monitoring."
    - name: "total_laden_teu_onboard"
      expr: SUM(CAST(laden_teu_onboard AS DOUBLE))
      comment: "Total laden TEU onboard across all voyages. Measures revenue-generating cargo volume carried by the fleet."
    - name: "total_empty_teu_onboard"
      expr: SUM(CAST(empty_teu_onboard AS DOUBLE))
      comment: "Total empty (MTY) TEU onboard. High empty ratios indicate trade imbalance and repositioning cost exposure."
    - name: "total_reefer_teu_onboard"
      expr: SUM(CAST(reefer_teu_onboard AS DOUBLE))
      comment: "Total reefer TEU onboard. Reefer cargo commands premium rates; this KPI tracks high-value cargo mix."
    - name: "avg_vessel_utilisation_pct"
      expr: ROUND(100.0 * AVG(laden_teu_onboard / NULLIF(total_teu_capacity, 0)), 2)
      comment: "Average vessel slot utilisation as a percentage of declared TEU capacity. Core commercial efficiency KPI — low utilisation signals revenue leakage."
    - name: "avg_reefer_mix_pct"
      expr: ROUND(100.0 * AVG(reefer_teu_onboard / NULLIF(total_teu_capacity, 0)), 2)
      comment: "Average reefer TEU as a percentage of total capacity. Tracks premium cargo mix and cold-chain service demand."
    - name: "avg_empty_ratio_pct"
      expr: ROUND(100.0 * AVG(empty_teu_onboard / NULLIF(total_teu_capacity, 0)), 2)
      comment: "Average empty TEU ratio as a percentage of total capacity. High ratios indicate trade imbalance and repositioning cost pressure."
    - name: "omission_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(CASE WHEN is_omitted = TRUE THEN 1 ELSE 0 END AS INT)) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of voyages that were omitted. Omissions directly impact service reliability scores and customer satisfaction."
    - name: "baplie_receipt_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(CASE WHEN baplie_received_flag = TRUE THEN 1 ELSE 0 END AS INT)) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of voyages for which a BAPLIE stowage plan was received. Measures EDI readiness and pre-arrival planning quality."
    - name: "coparn_receipt_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(CASE WHEN coparn_received_flag = TRUE THEN 1 ELSE 0 END AS INT)) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of voyages for which a COPARN container pre-announcement was received. Measures shipping line EDI compliance."
    - name: "avg_eta_to_ata_variance_hours"
      expr: AVG(CAST(UNIX_TIMESTAMP(ata) - UNIX_TIMESTAMP(eta) AS DOUBLE) / 3600.0)
      comment: "Average schedule deviation (ETA vs ATA) in hours per voyage. Measures shipping line schedule reliability and its impact on terminal planning."
    - name: "total_teu_capacity"
      expr: SUM(CAST(total_teu_capacity AS DOUBLE))
      comment: "Total declared TEU capacity across all voyages. Used as the denominator for fleet-wide utilisation calculations."
$$;

CREATE OR REPLACE VIEW `vibe_shipping_ports_v1`.`_metrics`.`vessel_bunker_operation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Bunker operation metrics tracking fuel delivery volumes, costs, quality compliance, and safety performance. Used by marine operations and finance teams to manage bunkering costs, MARPOL sulphur compliance, and operational safety."
  source: "`vibe_shipping_ports_v1`.`vessel`.`bunker_operation`"
  dimensions:
    - name: "fuel_type"
      expr: fuel_type
      comment: "Type of fuel bunkered (VLSFO, HFO, MGO, LNG, etc.) for MARPOL sulphur compliance and cost analysis."
    - name: "fuel_grade"
      expr: fuel_grade
      comment: "Specific fuel grade for quality and specification tracking."
    - name: "operation_status"
      expr: operation_status
      comment: "Current status of the bunker operation (PLANNED, IN_PROGRESS, COMPLETED, CANCELLED)."
    - name: "delivery_method"
      expr: delivery_method
      comment: "Delivery method (barge, pipeline, truck) for logistics and cost benchmarking."
    - name: "delivery_location_type"
      expr: delivery_location_type
      comment: "Location type where bunkering occurred (at berth, at anchorage, offshore)."
    - name: "safety_checklist_completed_flag"
      expr: safety_checklist_completed_flag
      comment: "Indicates whether the pre-bunkering safety checklist was completed. Used for HSE compliance monitoring."
    - name: "fuel_sample_taken_flag"
      expr: fuel_sample_taken_flag
      comment: "Indicates whether a fuel sample was taken for quality verification per MARPOL requirements."
    - name: "bunker_month"
      expr: DATE_TRUNC('month', actual_start_timestamp)
      comment: "Month of bunkering operation for cost and volume trend analysis."
    - name: "isps_security_level"
      expr: isps_security_level
      comment: "ISPS security level during bunkering, used for security compliance reporting."
  measures:
    - name: "total_bunker_operations"
      expr: COUNT(1)
      comment: "Total number of bunker operations. Volume KPI for bunkering activity and vendor workload."
    - name: "total_quantity_ordered_mt"
      expr: SUM(CAST(quantity_ordered_mt AS DOUBLE))
      comment: "Total fuel quantity ordered in metric tonnes. Used for procurement planning and demand forecasting."
    - name: "total_quantity_delivered_mt"
      expr: SUM(CAST(quantity_delivered_mt AS DOUBLE))
      comment: "Total fuel quantity actually delivered in metric tonnes. Compared against ordered quantity to detect shortfalls."
    - name: "total_fuel_cost"
      expr: SUM(CAST(total_fuel_cost AS DOUBLE))
      comment: "Total bunkering cost across all operations. Primary cost KPI for marine fuel expenditure management."
    - name: "avg_unit_price_per_mt"
      expr: AVG(CAST(unit_price_per_mt AS DOUBLE))
      comment: "Average fuel price per metric tonne. Used for vendor benchmarking and market price monitoring."
    - name: "avg_quantity_delivered_mt"
      expr: AVG(CAST(quantity_delivered_mt AS DOUBLE))
      comment: "Average delivery quantity per operation. Used for barge sizing and logistics planning."
    - name: "delivery_shortfall_mt"
      expr: SUM(CAST(quantity_ordered_mt AS DOUBLE) - CAST(quantity_delivered_mt AS DOUBLE))
      comment: "Total shortfall between ordered and delivered fuel in metric tonnes. Persistent shortfalls indicate supplier reliability issues or measurement disputes."
    - name: "avg_sulphur_content_pct"
      expr: AVG(CAST(sulphur_content_percent AS DOUBLE))
      comment: "Average sulphur content percentage of bunkered fuel. Must remain below 0.5% globally and 0.1% in ECAs per MARPOL Annex VI — critical regulatory compliance KPI."
    - name: "safety_checklist_compliance_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(CASE WHEN safety_checklist_completed_flag = TRUE THEN 1 ELSE 0 END AS INT)) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of bunker operations with completed safety checklists. Non-compliance is a direct HSE and ISPS risk indicator."
    - name: "fuel_sample_compliance_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(CASE WHEN fuel_sample_taken_flag = TRUE THEN 1 ELSE 0 END AS INT)) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of bunker operations where a fuel sample was taken per MARPOL requirements. Gaps expose the port to regulatory non-compliance."
    - name: "avg_operation_duration_minutes"
      expr: AVG(CAST(UNIX_TIMESTAMP(actual_end_timestamp) - UNIX_TIMESTAMP(actual_start_timestamp) AS DOUBLE) / 60.0)
      comment: "Average bunkering operation duration in minutes. Used to assess berth time impact and operational efficiency."
    - name: "total_port_service_charge"
      expr: SUM(CAST(port_service_charge AS DOUBLE))
      comment: "Total port service charges levied on bunker operations. Revenue KPI for port bunkering services."
$$;

CREATE OR REPLACE VIEW `vibe_shipping_ports_v1`.`_metrics`.`vessel_psc_inspection`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Port State Control inspection metrics tracking deficiency rates, detention performance, and compliance outcomes. Used by compliance, marine, and executive teams to manage fleet risk profile and avoid port bans."
  source: "`vibe_shipping_ports_v1`.`vessel`.`psc_inspection`"
  dimensions:
    - name: "inspection_outcome"
      expr: inspection_outcome
      comment: "Outcome of the PSC inspection (no deficiencies, deficiencies, detained) for risk segmentation."
    - name: "inspection_type"
      expr: inspection_type
      comment: "Type of PSC inspection (initial, expanded, concentrated inspection campaign) for regime analysis."
    - name: "inspection_regime"
      expr: inspection_regime
      comment: "PSC regime under which the inspection was conducted (Paris MOU, Tokyo MOU, USCG, etc.)."
    - name: "psc_authority_name"
      expr: psc_authority_name
      comment: "Name of the Port State Control authority conducting the inspection."
    - name: "detention_flag"
      expr: detention_flag
      comment: "Indicates whether the vessel was detained. Detentions are the most severe PSC outcome and directly impact fleet operations."
    - name: "ship_risk_profile"
      expr: ship_risk_profile
      comment: "Risk profile assigned to the vessel by the PSC regime (low, standard, high). Drives inspection frequency."
    - name: "follow_up_required_flag"
      expr: follow_up_required_flag
      comment: "Indicates whether a follow-up inspection is required, used for compliance tracking."
    - name: "inspection_month"
      expr: DATE_TRUNC('month', inspection_date)
      comment: "Month of inspection for trend analysis of PSC performance."
    - name: "inspection_year"
      expr: DATE_TRUNC('year', inspection_date)
      comment: "Year of inspection for annual PSC performance benchmarking."
  measures:
    - name: "total_psc_inspections"
      expr: COUNT(1)
      comment: "Total number of PSC inspections. Volume KPI for compliance exposure and inspection frequency monitoring."
    - name: "total_detentions"
      expr: SUM(CAST(CASE WHEN detention_flag = TRUE THEN 1 ELSE 0 END AS INT))
      comment: "Total number of vessel detentions. Detentions are the most severe PSC outcome, causing direct revenue loss and reputational damage."
    - name: "detention_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(CASE WHEN detention_flag = TRUE THEN 1 ELSE 0 END AS INT)) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of PSC inspections resulting in detention. Industry benchmark is below 3%; above 5% triggers concentrated inspection campaigns."
    - name: "avg_detention_duration_hours"
      expr: AVG(CAST(CASE WHEN detention_flag = TRUE THEN detention_duration_hours ELSE NULL END AS INT))
      comment: "Average detention duration in hours for detained vessels. Longer detentions indicate more severe deficiencies and higher revenue loss."
    - name: "avg_deficiencies_per_inspection"
      expr: AVG(CAST(total_deficiencies_found AS DOUBLE))
      comment: "Average number of deficiencies found per PSC inspection. Rising averages signal deteriorating fleet compliance and increased detention risk."
    - name: "total_inspection_cost_usd"
      expr: SUM(CAST(inspection_cost_usd AS DOUBLE))
      comment: "Total cost of PSC inspections in USD. Used for compliance cost management and budget planning."
    - name: "avg_inspection_cost_usd"
      expr: AVG(CAST(inspection_cost_usd AS DOUBLE))
      comment: "Average cost per PSC inspection in USD. Benchmarked against industry norms for cost efficiency."
    - name: "follow_up_inspection_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(CASE WHEN follow_up_required_flag = TRUE THEN 1 ELSE 0 END AS INT)) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of inspections requiring follow-up. High rates indicate systemic compliance gaps requiring corrective investment."
    - name: "distinct_vessels_inspected"
      expr: COUNT(DISTINCT vessel_id)
      comment: "Number of distinct vessels that received PSC inspections. Used to assess fleet-wide compliance exposure breadth."
$$;

CREATE OR REPLACE VIEW `vibe_shipping_ports_v1`.`_metrics`.`vessel_deployment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Stevedoring gang deployment metrics tracking operational productivity, moves per hour, and labour utilisation per vessel call. Used by terminal and operations management to optimise gang allocation and measure stevedoring performance."
  source: "`vibe_shipping_ports_v1`.`vessel`.`deployment`"
  dimensions:
    - name: "operation_type"
      expr: operation_type
      comment: "Type of cargo operation (discharge, load, restow, shifting) for productivity segmentation."
    - name: "cargo_type"
      expr: cargo_type
      comment: "Type of cargo being handled (containers, bulk, breakbulk) for operation-type benchmarking."
    - name: "hatch_number"
      expr: hatch_number
      comment: "Vessel hatch number being worked, used for hatch-level productivity analysis."
    - name: "deployment_month"
      expr: DATE_TRUNC('month', deployment_timestamp)
      comment: "Month of gang deployment for productivity trend analysis."
  measures:
    - name: "total_deployments"
      expr: COUNT(1)
      comment: "Total number of gang deployments. Volume KPI for stevedoring activity and labour demand."
    - name: "total_gross_hours_worked"
      expr: SUM(CAST(gross_hours_worked AS DOUBLE))
      comment: "Total gross hours worked by stevedoring gangs. Primary labour cost driver and productivity denominator."
    - name: "total_stoppage_hours"
      expr: SUM(CAST(stoppage_hours AS DOUBLE))
      comment: "Total stoppage hours (weather, breakdown, waiting) across all deployments. Stoppages directly reduce productivity and increase vessel port stay costs."
    - name: "avg_moves_per_hour"
      expr: AVG(CAST(moves_per_hour AS DOUBLE))
      comment: "Average crane/gang moves per hour. Core stevedoring productivity KPI — benchmarked against terminal targets and industry standards."
    - name: "stoppage_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(stoppage_hours AS DOUBLE)) / NULLIF(SUM(CAST(gross_hours_worked AS DOUBLE)), 0), 2)
      comment: "Percentage of gross hours lost to stoppages. High stoppage rates indicate equipment reliability or weather exposure issues."
    - name: "avg_gang_size"
      expr: AVG(CAST(gang_size_actual AS DOUBLE))
      comment: "Average actual gang size deployed per operation. Used for labour planning and cost-per-move analysis."
    - name: "total_teu_handled"
      expr: SUM(CAST(teu_handled AS DOUBLE))
      comment: "Total TEU handled across all deployments. Throughput KPI linking stevedoring activity to cargo volume."
    - name: "teu_per_gross_hour"
      expr: ROUND(SUM(CAST(teu_handled AS DOUBLE)) / NULLIF(SUM(CAST(gross_hours_worked AS DOUBLE)), 0), 2)
      comment: "TEU handled per gross hour worked. Composite productivity KPI combining throughput and labour efficiency — used for gang performance benchmarking."
$$;

CREATE OR REPLACE VIEW `vibe_shipping_ports_v1`.`_metrics`.`vessel_waste_declaration`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "MARPOL waste declaration metrics tracking waste volumes, compliance rates, violations, and disposal charges. Used by environmental compliance and port operations teams to manage MARPOL Annex obligations and waste reception facility performance."
  source: "`vibe_shipping_ports_v1`.`vessel`.`waste_declaration`"
  dimensions:
    - name: "waste_type_code"
      expr: waste_type_code
      comment: "MARPOL waste type code (oily waste, sewage, garbage, etc.) for annex-specific compliance reporting."
    - name: "marpol_annex"
      expr: marpol_annex
      comment: "MARPOL Annex under which the waste is classified (I, II, IV, V, VI) for regulatory reporting."
    - name: "declaration_status"
      expr: declaration_status
      comment: "Status of the waste declaration (SUBMITTED, ACCEPTED, REJECTED, WAIVED) for compliance tracking."
    - name: "hazardous_waste_flag"
      expr: hazardous_waste_flag
      comment: "Indicates hazardous waste, requiring special handling and elevated compliance scrutiny."
    - name: "violation_detected_flag"
      expr: violation_detected_flag
      comment: "Flags declarations where a MARPOL violation was detected, used for enforcement and penalty tracking."
    - name: "waiver_granted_flag"
      expr: waiver_granted_flag
      comment: "Indicates whether a waiver was granted for waste delivery, used for exemption rate monitoring."
    - name: "disposal_method"
      expr: disposal_method
      comment: "Method of waste disposal (incineration, landfill, recycling) for environmental performance reporting."
    - name: "declaration_month"
      expr: DATE_TRUNC('month', declaration_submission_timestamp)
      comment: "Month of declaration submission for trend analysis of waste volumes and compliance."
    - name: "psc_inspection_flag"
      expr: psc_inspection_flag
      comment: "Indicates whether a PSC inspection was triggered by the waste declaration, used for compliance risk analysis."
  measures:
    - name: "total_waste_declarations"
      expr: COUNT(1)
      comment: "Total number of MARPOL waste declarations. Volume KPI for waste reception facility demand and compliance activity."
    - name: "total_estimated_volume_m3"
      expr: SUM(CAST(estimated_volume_m3 AS DOUBLE))
      comment: "Total estimated waste volume in cubic metres. Used for waste reception facility capacity planning."
    - name: "total_actual_volume_delivered_m3"
      expr: SUM(CAST(actual_volume_delivered_m3 AS DOUBLE))
      comment: "Total actual waste volume delivered in cubic metres. Compared against estimates to detect under-delivery and potential illegal discharge."
    - name: "volume_delivery_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(actual_volume_delivered_m3 AS DOUBLE)) / NULLIF(SUM(CAST(estimated_volume_m3 AS DOUBLE)), 0), 2)
      comment: "Percentage of estimated waste volume actually delivered. Rates significantly below 100% may indicate illegal discharge at sea — a critical MARPOL compliance signal."
    - name: "total_charge_amount"
      expr: SUM(CAST(charge_amount AS DOUBLE))
      comment: "Total waste reception charges levied. Revenue KPI for port waste management services."
    - name: "total_penalty_amount"
      expr: SUM(CAST(penalty_amount AS DOUBLE))
      comment: "Total MARPOL violation penalties levied. Elevated totals signal systemic non-compliance and regulatory risk."
    - name: "violation_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(CASE WHEN violation_detected_flag = TRUE THEN 1 ELSE 0 END AS INT)) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of waste declarations where a MARPOL violation was detected. Core environmental compliance KPI."
    - name: "hazardous_waste_declaration_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(CASE WHEN hazardous_waste_flag = TRUE THEN 1 ELSE 0 END AS INT)) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of declarations involving hazardous waste. Used for special handling resource planning and risk management."
    - name: "waiver_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(CASE WHEN waiver_granted_flag = TRUE THEN 1 ELSE 0 END AS INT)) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of declarations for which a waiver was granted. High waiver rates may indicate insufficient waste reception capacity."
$$;

CREATE OR REPLACE VIEW `vibe_shipping_ports_v1`.`_metrics`.`vessel_anchorage`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Anchorage utilisation and waiting time metrics tracking vessel queue management, anchorage duration, and port congestion signals. Used by port operations and VTS to manage anchorage capacity and reduce vessel waiting costs."
  source: "`vibe_shipping_ports_v1`.`vessel`.`anchorage`"
  dimensions:
    - name: "assignment_status"
      expr: assignment_status
      comment: "Status of the anchorage assignment (ASSIGNED, WAITING, DEPARTED) for queue management."
    - name: "assignment_priority"
      expr: assignment_priority
      comment: "Priority level of the anchorage assignment, used for queue management and priority vessel handling."
    - name: "reason_code"
      expr: reason_code
      comment: "Reason for anchorage (awaiting berth, customs, weather, bunkering) for congestion root-cause analysis."
    - name: "security_level"
      expr: security_level
      comment: "ISPS security level at anchorage, used for security compliance reporting."
    - name: "quarantine_flag"
      expr: quarantine_flag
      comment: "Indicates vessel is under quarantine at anchorage, used for port health management."
    - name: "pilot_required_flag"
      expr: pilot_required_flag
      comment: "Indicates whether a pilot is required for the anchorage-to-berth transit."
    - name: "tug_assistance_required_flag"
      expr: tug_assistance_required_flag
      comment: "Indicates whether tug assistance is required, used for marine services resource planning."
    - name: "anchorage_month"
      expr: DATE_TRUNC('month', scheduled_anchor_drop_time)
      comment: "Month of anchorage for congestion trend analysis."
    - name: "weather_condition"
      expr: weather_condition
      comment: "Weather condition during anchorage, used for weather-related delay analysis."
  measures:
    - name: "total_anchorage_events"
      expr: COUNT(1)
      comment: "Total number of anchorage events. Volume KPI for anchorage demand and port congestion monitoring."
    - name: "avg_anchorage_duration_hours"
      expr: AVG(CAST(duration_hours AS DOUBLE))
      comment: "Average anchorage duration in hours. Core port congestion KPI — rising averages indicate berth availability constraints."
    - name: "total_anchorage_charge_amount"
      expr: SUM(CAST(charge_amount AS DOUBLE))
      comment: "Total anchorage charges levied. Revenue KPI for anchorage services and cost recovery."
    - name: "avg_anchorage_charge_amount"
      expr: AVG(CAST(charge_amount AS DOUBLE))
      comment: "Average anchorage charge per event. Used for tariff benchmarking and revenue per vessel analysis."
    - name: "quarantine_anchorage_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(CASE WHEN quarantine_flag = TRUE THEN 1 ELSE 0 END AS INT)) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of anchorage events involving quarantine. Elevated rates signal port health risk and potential operational disruption."
    - name: "avg_water_depth_meters"
      expr: AVG(CAST(water_depth_meters AS DOUBLE))
      comment: "Average water depth at anchorage positions. Used for anchorage suitability assessment and vessel draft management."
    - name: "avg_wind_speed_knots"
      expr: AVG(CAST(wind_speed_knots AS DOUBLE))
      comment: "Average wind speed during anchorage events. Used for weather risk analysis and anchorage safety assessment."
    - name: "tug_assistance_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(CASE WHEN tug_assistance_required_flag = TRUE THEN 1 ELSE 0 END AS INT)) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of anchorage events requiring tug assistance. Used for tug fleet capacity planning and marine services revenue forecasting."
$$;

CREATE OR REPLACE VIEW `vibe_shipping_ports_v1`.`_metrics`.`vessel_certificate`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Vessel certificate compliance metrics tracking expiry status, deficiency rates, and detention outcomes. Used by fleet compliance and marine teams to manage statutory certificate validity and avoid PSC detentions."
  source: "`vibe_shipping_ports_v1`.`vessel`.`certificate`"
  dimensions:
    - name: "certificate_type"
      expr: certificate_type
      comment: "Type of statutory certificate (SOLAS Safety Construction, MARPOL IOPP, ISM DOC, ISPS ISSC, etc.) for compliance category analysis."
    - name: "certificate_status"
      expr: certificate_status
      comment: "Current status of the certificate (VALID, EXPIRED, SUSPENDED, REVOKED) for compliance monitoring."
    - name: "issuing_authority"
      expr: issuing_authority
      comment: "Authority that issued the certificate (flag state, classification society, RO) for quality and recognition analysis."
    - name: "detention_flag"
      expr: detention_flag
      comment: "Indicates whether the certificate deficiency led to vessel detention."
    - name: "follow_up_action_required"
      expr: follow_up_action_required
      comment: "Indicates whether follow-up corrective action is required for this certificate."
    - name: "inspection_outcome"
      expr: inspection_outcome
      comment: "Outcome of the certificate inspection (passed, deficiency noted, detained)."
    - name: "record_type"
      expr: record_type
      comment: "Record type (certificate, endorsement, survey) for classification."
    - name: "certificate_expiry_month"
      expr: DATE_TRUNC('month', expiry_date)
      comment: "Month of certificate expiry for proactive renewal planning and compliance risk forecasting."
  measures:
    - name: "total_certificates"
      expr: COUNT(1)
      comment: "Total number of vessel certificates tracked. Volume KPI for compliance portfolio management."
    - name: "expired_certificate_count"
      expr: SUM(CAST(CASE WHEN certificate_status = 'EXPIRED' THEN 1 ELSE 0 END AS INT))
      comment: "Number of expired certificates. Any expired statutory certificate is a direct PSC detention risk and trading prohibition."
    - name: "expiry_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(CASE WHEN certificate_status = 'EXPIRED' THEN 1 ELSE 0 END AS INT)) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of certificates that are expired. Zero tolerance target — any non-zero value requires immediate management action."
    - name: "detention_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(CASE WHEN detention_flag = TRUE THEN 1 ELSE 0 END AS INT)) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of certificate records associated with a vessel detention. Measures the severity of certificate non-compliance."
    - name: "follow_up_action_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(CASE WHEN follow_up_action_required = TRUE THEN 1 ELSE 0 END AS INT)) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of certificates requiring follow-up corrective action. Used to prioritise compliance remediation workload."
    - name: "distinct_vessels_with_deficiencies"
      expr: COUNT(DISTINCT CASE WHEN detention_flag = TRUE OR follow_up_action_required = TRUE THEN vessel_id ELSE NULL END)
      comment: "Number of distinct vessels with certificate deficiencies or detentions. Breadth KPI for fleet-wide compliance risk exposure."
    - name: "avg_days_to_expiry"
      expr: AVG(DATEDIFF(expiry_date, CURRENT_DATE()))
      comment: "Average days remaining until certificate expiry across the active fleet. Negative values indicate already-expired certificates requiring urgent action."
$$;

CREATE OR REPLACE VIEW `vibe_shipping_ports_v1`.`_metrics`.`vessel_movement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Vessel movement and VTS traffic metrics tracking port traffic density, pilot utilisation, tug demand, and movement delays. Used by VTS, marine operations, and port planning teams to manage traffic flow and marine services capacity."
  source: "`vibe_shipping_ports_v1`.`vessel`.`movement`"
  dimensions:
    - name: "movement_type"
      expr: movement_type
      comment: "Type of vessel movement (arrival, departure, shifting, anchorage transit) for traffic pattern analysis."
    - name: "movement_status"
      expr: movement_status
      comment: "Current status of the movement (PLANNED, IN_PROGRESS, COMPLETED, DELAYED) for operational monitoring."
    - name: "pilot_on_board_flag"
      expr: pilot_on_board_flag
      comment: "Indicates whether a pilot was on board during the movement, used for pilotage compliance and utilisation analysis."
    - name: "tug_assistance_flag"
      expr: tug_assistance_flag
      comment: "Indicates whether tug assistance was used, for tug fleet utilisation and revenue analysis."
    - name: "dangerous_cargo_flag"
      expr: dangerous_cargo_flag
      comment: "Indicates dangerous cargo onboard during movement, used for ISPS/IMDG risk management."
    - name: "isps_security_level"
      expr: isps_security_level
      comment: "ISPS security level during the movement for security compliance reporting."
    - name: "delay_reason_code"
      expr: delay_reason_code
      comment: "Reason code for movement delay (weather, traffic, equipment, pilot availability) for root-cause analysis."
    - name: "movement_month"
      expr: DATE_TRUNC('month', movement_timestamp)
      comment: "Month of vessel movement for traffic volume trend analysis."
    - name: "weather_condition"
      expr: weather_condition
      comment: "Weather condition during movement for weather-related delay and safety analysis."
  measures:
    - name: "total_movements"
      expr: COUNT(1)
      comment: "Total number of vessel movements. Primary port traffic volume KPI used for VTS capacity planning and marine services demand forecasting."
    - name: "total_delayed_movements"
      expr: SUM(CASE WHEN CAST(delay_minutes AS DOUBLE) > 0 THEN 1 ELSE 0 END)
      comment: "Total number of movements with recorded delays. Used to identify operational bottlenecks in port traffic management."
    - name: "avg_delay_minutes"
      expr: AVG(CAST(delay_minutes AS DOUBLE))
      comment: "Average movement delay in minutes. Rising averages indicate VTS congestion, pilot shortages, or weather disruption."
    - name: "delay_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN CAST(delay_minutes AS DOUBLE) > 0 THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of vessel movements experiencing delays. Core port reliability KPI used in shipping line service level assessments."
    - name: "pilotage_utilisation_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(CASE WHEN pilot_on_board_flag = TRUE THEN 1 ELSE 0 END AS INT)) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of movements with a pilot on board. Used for pilotage compliance monitoring and pilot resource planning."
    - name: "tug_utilisation_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(CASE WHEN tug_assistance_flag = TRUE THEN 1 ELSE 0 END AS INT)) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of movements requiring tug assistance. Used for tug fleet sizing and marine services revenue forecasting."
    - name: "avg_speed_over_ground_knots"
      expr: AVG(CAST(speed_over_ground_knots AS DOUBLE))
      comment: "Average vessel speed over ground during movements. Used for channel transit time analysis and VTS traffic management."
    - name: "dangerous_cargo_movement_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(CASE WHEN dangerous_cargo_flag = TRUE THEN 1 ELSE 0 END AS INT)) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of movements involving dangerous cargo. Used for ISPS risk planning and DG movement scheduling."
$$;

CREATE OR REPLACE VIEW `vibe_shipping_ports_v1`.`_metrics`.`vessel_draft_survey`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Draft survey metrics tracking cargo weight accuracy, survey quality, and trim/list conditions. Used by marine operations and cargo teams to validate cargo weights, ensure vessel stability compliance, and support VGM/SOLAS weight verification."
  source: "`vibe_shipping_ports_v1`.`vessel`.`draft_survey`"
  dimensions:
    - name: "survey_type"
      expr: survey_type
      comment: "Type of draft survey (initial, final, on/off hire) for survey purpose segmentation."
    - name: "survey_purpose"
      expr: survey_purpose
      comment: "Business purpose of the survey (cargo weight verification, on-hire, off-hire, dispute) for commercial analysis."
    - name: "survey_status"
      expr: survey_status
      comment: "Status of the draft survey (COMPLETED, PENDING, DISPUTED) for workflow tracking."
    - name: "cargo_type"
      expr: cargo_type
      comment: "Type of cargo surveyed for commodity-specific weight accuracy analysis."
    - name: "certificate_issued_flag"
      expr: certificate_issued_flag
      comment: "Indicates whether a survey certificate was issued, used for documentation compliance."
    - name: "survey_accuracy_rating"
      expr: survey_accuracy_rating
      comment: "Accuracy rating assigned to the survey, used for surveyor quality management."
    - name: "survey_month"
      expr: DATE_TRUNC('month', survey_datetime)
      comment: "Month of draft survey for volume and accuracy trend analysis."
    - name: "weather_condition"
      expr: weather_condition
      comment: "Weather condition during survey, used to assess environmental impact on survey accuracy."
  measures:
    - name: "total_draft_surveys"
      expr: COUNT(1)
      comment: "Total number of draft surveys conducted. Volume KPI for marine survey activity."
    - name: "total_calculated_cargo_weight_mt"
      expr: SUM(CAST(calculated_cargo_weight_mt AS DOUBLE))
      comment: "Total calculated cargo weight in metric tonnes across all surveys. Used for cargo revenue reconciliation and port throughput reporting."
    - name: "avg_calculated_cargo_weight_mt"
      expr: AVG(CAST(calculated_cargo_weight_mt AS DOUBLE))
      comment: "Average calculated cargo weight per survey in metric tonnes. Used for vessel loading pattern analysis."
    - name: "avg_trim_meters"
      expr: AVG(CAST(trim_meters AS DOUBLE))
      comment: "Average vessel trim in metres at time of survey. Excessive trim affects vessel stability and cargo operations safety."
    - name: "avg_list_degrees"
      expr: AVG(CAST(list_degrees AS DOUBLE))
      comment: "Average vessel list in degrees at time of survey. Excessive list is a SOLAS stability safety concern requiring immediate action."
    - name: "avg_mean_draft_meters"
      expr: AVG(CAST(mean_draft_meters AS DOUBLE))
      comment: "Average mean draft in metres. Used for channel depth clearance planning and berth suitability assessment."
    - name: "avg_water_density_kg_per_m3"
      expr: AVG(CAST(water_density_kg_per_m3 AS DOUBLE))
      comment: "Average water density at survey location. Density variations affect displacement calculations and cargo weight accuracy."
    - name: "certificate_issuance_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(CASE WHEN certificate_issued_flag = TRUE THEN 1 ELSE 0 END AS INT)) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of draft surveys resulting in a certificate being issued. Low rates may indicate survey quality or dispute issues."
$$;

CREATE OR REPLACE VIEW `vibe_shipping_ports_v1`.`_metrics`.`vessel_service_route`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Shipping line service route performance metrics tracking cargo volume commitments, service reliability, and trade lane mix. Used by commercial and planning teams to manage shipping line relationships and terminal capacity allocation."
  source: "`vibe_shipping_ports_v1`.`vessel`.`service_route`"
  dimensions:
    - name: "service_status"
      expr: service_status
      comment: "Current status of the service route (ACTIVE, SUSPENDED, DISCONTINUED) for portfolio management."
    - name: "service_type"
      expr: service_type
      comment: "Type of service (mainline, feeder, regional) for trade lane segmentation."
    - name: "service_frequency"
      expr: service_frequency
      comment: "Frequency of service calls (weekly, bi-weekly, monthly) for capacity planning."
    - name: "alliance_name"
      expr: alliance_name
      comment: "Shipping alliance name (2M, THE Alliance, Ocean Alliance) for alliance-level volume analysis."
    - name: "service_code"
      expr: service_code
      comment: "Unique service code for the shipping line rotation, used for service-level performance tracking."
    - name: "terminal_operator"
      expr: terminal_operator
      comment: "Terminal operator handling the service, used for operator-level performance benchmarking."
    - name: "service_commencement_month"
      expr: DATE_TRUNC('month', service_commencement_date)
      comment: "Month the service commenced for new service launch tracking."
  measures:
    - name: "total_service_routes"
      expr: COUNT(1)
      comment: "Total number of active service routes. Portfolio KPI for shipping line relationship breadth."
    - name: "total_expected_container_volume_teu"
      expr: SUM(CAST(expected_container_volume_teu AS DOUBLE))
      comment: "Total expected container volume in TEU across all service routes. Primary commercial volume commitment KPI for terminal capacity planning."
    - name: "avg_service_reliability_pct"
      expr: AVG(CAST(service_reliability_percentage AS DOUBLE))
      comment: "Average service reliability percentage across routes. Core shipping line performance KPI — low reliability impacts terminal planning and customer satisfaction."
    - name: "avg_transshipment_volume_pct"
      expr: AVG(CAST(transshipment_volume_percentage AS DOUBLE))
      comment: "Average transshipment volume percentage per service route. Critical for hub port strategy — T/S volumes drive berth utilisation and revenue at hub terminals like Jebel Ali and Salalah."
    - name: "avg_reefer_percentage"
      expr: AVG(CAST(reefer_percentage AS DOUBLE))
      comment: "Average reefer cargo percentage per service route. Used for reefer plug capacity planning and premium revenue forecasting."
    - name: "avg_dangerous_cargo_percentage"
      expr: AVG(CAST(dangerous_cargo_percentage AS DOUBLE))
      comment: "Average dangerous goods percentage per service route. Used for IMDG segregation planning and DG handling resource allocation."
    - name: "avg_port_stay_duration_hours"
      expr: AVG(CAST(port_stay_duration_hours AS DOUBLE))
      comment: "Average planned port stay duration in hours per service rotation. Used for berth window planning and vessel scheduling."
    - name: "avg_vessel_capacity_teu"
      expr: AVG(CAST(average_vessel_capacity_teu AS DOUBLE))
      comment: "Average vessel capacity in TEU across service routes. Used for berth infrastructure sizing and crane reach planning."
    - name: "avg_export_volume_pct"
      expr: AVG(CAST(export_volume_percentage AS DOUBLE))
      comment: "Average export volume percentage per service. Used for trade balance analysis and export cargo planning."
    - name: "avg_import_volume_pct"
      expr: AVG(CAST(import_volume_percentage AS DOUBLE))
      comment: "Average import volume percentage per service. Used for trade balance analysis and import cargo planning."
$$;