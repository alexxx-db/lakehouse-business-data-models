-- Metric views for domain: vessel | Business: Shipping_Ports | Version: 2 | Generated on: 2026-07-13 10:21:34

CREATE OR REPLACE VIEW `vibe_shipping_ports_v1`.`_metrics`.`vessel_call`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core vessel port call performance metrics tracking berth utilization, turnaround time, cargo operations efficiency, and call completion rates for operational steering and capacity planning"
  source: "`vibe_shipping_ports_v1`.`vessel`.`call`"
  dimensions:
    - name: "call_status"
      expr: call_status
      comment: "Current status of the port call (e.g., scheduled, in-progress, completed, cancelled)"
    - name: "call_year"
      expr: YEAR(ata)
      comment: "Year of actual time of arrival for trend analysis"
    - name: "call_month"
      expr: DATE_TRUNC('MONTH', ata)
      comment: "Month of actual time of arrival for seasonal analysis"
    - name: "call_quarter"
      expr: DATE_TRUNC('QUARTER', ata)
      comment: "Quarter of actual time of arrival for quarterly business reviews"
    - name: "cargo_type"
      expr: cargo_type
      comment: "Type of cargo handled during the call (e.g., container, bulk, general)"
    - name: "call_purpose"
      expr: purpose
      comment: "Purpose of the port call (e.g., loading, discharging, bunkering, repair)"
    - name: "customs_clearance_status"
      expr: customs_clearance_status
      comment: "Customs clearance status affecting call efficiency"
    - name: "dangerous_goods_flag"
      expr: dangerous_goods_flag
      comment: "Indicator if dangerous goods are on board requiring special handling"
    - name: "isps_security_level"
      expr: isps_security_level
      comment: "ISPS security level during the call affecting operational procedures"
    - name: "port_state_control_inspection_flag"
      expr: port_state_control_inspection_flag
      comment: "Indicator if PSC inspection occurred during call"
  measures:
    - name: "total_port_calls"
      expr: COUNT(1)
      comment: "Total number of port calls for volume tracking and capacity planning"
    - name: "completed_calls"
      expr: COUNT(CASE WHEN call_status = 'completed' THEN 1 END)
      comment: "Number of completed port calls for throughput measurement"
    - name: "avg_berth_turnaround_hours"
      expr: AVG(CAST((UNIX_TIMESTAMP(atd) - UNIX_TIMESTAMP(atb)) / 3600.0 AS DOUBLE))
      comment: "Average hours from actual time berthed to actual time departed - key efficiency KPI for berth utilization and port productivity"
    - name: "avg_port_stay_hours"
      expr: AVG(CAST((UNIX_TIMESTAMP(atd) - UNIX_TIMESTAMP(ata)) / 3600.0 AS DOUBLE))
      comment: "Average hours from arrival to departure - total port stay duration for capacity planning"
    - name: "avg_cargo_ops_duration_hours"
      expr: AVG(CAST((UNIX_TIMESTAMP(cargo_ops_end_timestamp) - UNIX_TIMESTAMP(cargo_ops_start_timestamp)) / 3600.0 AS DOUBLE))
      comment: "Average cargo operation duration in hours - direct measure of operational efficiency and productivity"
    - name: "avg_waiting_time_hours"
      expr: AVG(CAST((UNIX_TIMESTAMP(atb) - UNIX_TIMESTAMP(ata)) / 3600.0 AS DOUBLE))
      comment: "Average waiting time from arrival to berth - measures port congestion and scheduling efficiency"
    - name: "total_teu_declared"
      expr: SUM(CAST(total_teu_declared AS DOUBLE))
      comment: "Total twenty-foot equivalent units declared across all calls - primary cargo volume metric for container operations"
    - name: "avg_teu_per_call"
      expr: AVG(CAST(total_teu_declared AS DOUBLE))
      comment: "Average TEU per call - vessel size and cargo intensity indicator"
    - name: "calls_with_dangerous_goods"
      expr: COUNT(CASE WHEN dangerous_goods_flag = TRUE THEN 1 END)
      comment: "Number of calls with dangerous goods requiring special handling and risk management"
    - name: "calls_with_psc_inspection"
      expr: COUNT(CASE WHEN port_state_control_inspection_flag = TRUE THEN 1 END)
      comment: "Number of calls with PSC inspections - compliance and quality indicator"
    - name: "distinct_vessels"
      expr: COUNT(DISTINCT vessel_id)
      comment: "Number of unique vessels calling at port - customer diversity metric"
    - name: "distinct_shipping_lines"
      expr: COUNT(DISTINCT shipping_line_id)
      comment: "Number of unique shipping lines served - market reach indicator"
$$;

CREATE OR REPLACE VIEW `vibe_shipping_ports_v1`.`_metrics`.`vessel_voyage`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Voyage-level operational metrics tracking schedule adherence, cargo capacity utilization, service reliability, and voyage completion performance for strategic service planning"
  source: "`vibe_shipping_ports_v1`.`vessel`.`voyage`"
  dimensions:
    - name: "voyage_status"
      expr: voyage_status
      comment: "Current status of the voyage (e.g., scheduled, in-progress, completed, cancelled)"
    - name: "voyage_type"
      expr: voyage_type
      comment: "Type of voyage (e.g., liner, tramp, feeder)"
    - name: "service_code"
      expr: service_code
      comment: "Service code identifying the shipping service route"
    - name: "service_name"
      expr: service_name
      comment: "Name of the shipping service for route analysis"
    - name: "voyage_year"
      expr: YEAR(start_date)
      comment: "Year of voyage start for trend analysis"
    - name: "voyage_month"
      expr: DATE_TRUNC('MONTH', start_date)
      comment: "Month of voyage start for seasonal patterns"
    - name: "voyage_quarter"
      expr: DATE_TRUNC('QUARTER', start_date)
      comment: "Quarter of voyage start for quarterly reviews"
    - name: "customs_clearance_status"
      expr: customs_clearance_status
      comment: "Customs clearance status affecting voyage efficiency"
    - name: "is_maiden_call"
      expr: is_maiden_call
      comment: "Indicator if this is the vessel's first call to the port"
    - name: "is_omitted"
      expr: is_omitted
      comment: "Indicator if the voyage was omitted from schedule"
    - name: "imdg_cargo_onboard_flag"
      expr: imdg_cargo_onboard_flag
      comment: "Indicator if IMDG dangerous cargo is on board"
    - name: "oog_cargo_onboard_flag"
      expr: oog_cargo_onboard_flag
      comment: "Indicator if out-of-gauge cargo is on board"
  measures:
    - name: "total_voyages"
      expr: COUNT(1)
      comment: "Total number of voyages for service frequency and volume tracking"
    - name: "completed_voyages"
      expr: COUNT(CASE WHEN voyage_status = 'completed' THEN 1 END)
      comment: "Number of completed voyages for service reliability measurement"
    - name: "omitted_voyages"
      expr: COUNT(CASE WHEN is_omitted = TRUE THEN 1 END)
      comment: "Number of omitted voyages - service reliability and schedule adherence indicator"
    - name: "avg_total_teu_capacity"
      expr: AVG(CAST(total_teu_capacity AS DOUBLE))
      comment: "Average total TEU capacity per voyage - vessel deployment and capacity planning metric"
    - name: "total_laden_teu"
      expr: SUM(CAST(laden_teu_onboard AS DOUBLE))
      comment: "Total laden TEU across all voyages - primary revenue cargo volume metric"
    - name: "total_empty_teu"
      expr: SUM(CAST(empty_teu_onboard AS DOUBLE))
      comment: "Total empty TEU repositioned - operational cost and efficiency indicator"
    - name: "total_reefer_teu"
      expr: SUM(CAST(reefer_teu_onboard AS DOUBLE))
      comment: "Total refrigerated TEU - specialized cargo volume requiring premium handling"
    - name: "avg_laden_teu_per_voyage"
      expr: AVG(CAST(laden_teu_onboard AS DOUBLE))
      comment: "Average laden TEU per voyage - cargo intensity and utilization indicator"
    - name: "avg_empty_teu_per_voyage"
      expr: AVG(CAST(empty_teu_onboard AS DOUBLE))
      comment: "Average empty TEU per voyage - repositioning efficiency metric"
    - name: "avg_reefer_teu_per_voyage"
      expr: AVG(CAST(reefer_teu_onboard AS DOUBLE))
      comment: "Average reefer TEU per voyage - specialized cargo handling capacity"
    - name: "voyages_with_imdg_cargo"
      expr: COUNT(CASE WHEN imdg_cargo_onboard_flag = TRUE THEN 1 END)
      comment: "Number of voyages with dangerous goods - risk management and compliance metric"
    - name: "voyages_with_oog_cargo"
      expr: COUNT(CASE WHEN oog_cargo_onboard_flag = TRUE THEN 1 END)
      comment: "Number of voyages with out-of-gauge cargo requiring special handling"
    - name: "maiden_call_voyages"
      expr: COUNT(CASE WHEN is_maiden_call = TRUE THEN 1 END)
      comment: "Number of maiden call voyages - new business development indicator"
    - name: "distinct_vessels_deployed"
      expr: COUNT(DISTINCT vessel_id)
      comment: "Number of unique vessels deployed - fleet diversity and deployment strategy metric"
    - name: "distinct_shipping_lines"
      expr: COUNT(DISTINCT shipping_line_id)
      comment: "Number of unique shipping lines operating - market diversity indicator"
$$;

CREATE OR REPLACE VIEW `vibe_shipping_ports_v1`.`_metrics`.`vessel_movement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Vessel movement and marine operations metrics tracking pilotage efficiency, towage utilization, movement delays, and navigational safety for marine services optimization"
  source: "`vibe_shipping_ports_v1`.`vessel`.`movement`"
  dimensions:
    - name: "movement_type"
      expr: movement_type
      comment: "Type of vessel movement (e.g., arrival, departure, shifting, warping)"
    - name: "movement_status"
      expr: movement_status
      comment: "Current status of the movement (e.g., scheduled, in-progress, completed, delayed)"
    - name: "movement_year"
      expr: YEAR(movement_timestamp)
      comment: "Year of movement for trend analysis"
    - name: "movement_month"
      expr: DATE_TRUNC('MONTH', movement_timestamp)
      comment: "Month of movement for seasonal patterns"
    - name: "movement_quarter"
      expr: DATE_TRUNC('QUARTER', movement_timestamp)
      comment: "Quarter of movement for quarterly reviews"
    - name: "pilot_on_board_flag"
      expr: pilot_on_board_flag
      comment: "Indicator if pilot was on board during movement"
    - name: "tug_assistance_flag"
      expr: tug_assistance_flag
      comment: "Indicator if tug assistance was provided"
    - name: "dangerous_cargo_flag"
      expr: dangerous_cargo_flag
      comment: "Indicator if dangerous cargo was on board during movement"
    - name: "weather_condition"
      expr: weather_condition
      comment: "Weather conditions during movement affecting safety and efficiency"
    - name: "isps_security_level"
      expr: isps_security_level
      comment: "ISPS security level during movement"
    - name: "delay_reason_code"
      expr: delay_reason_code
      comment: "Code indicating reason for movement delay"
  measures:
    - name: "total_movements"
      expr: COUNT(1)
      comment: "Total number of vessel movements for marine traffic volume tracking"
    - name: "movements_with_pilot"
      expr: COUNT(CASE WHEN pilot_on_board_flag = TRUE THEN 1 END)
      comment: "Number of movements requiring pilotage - pilotage service demand metric"
    - name: "movements_with_tugs"
      expr: COUNT(CASE WHEN tug_assistance_flag = TRUE THEN 1 END)
      comment: "Number of movements requiring tug assistance - towage service demand metric"
    - name: "movements_with_dangerous_cargo"
      expr: COUNT(CASE WHEN dangerous_cargo_flag = TRUE THEN 1 END)
      comment: "Number of movements with dangerous cargo - risk management and safety metric"
    - name: "delayed_movements"
      expr: COUNT(CASE WHEN delay_minutes IS NOT NULL AND CAST(delay_minutes AS DOUBLE) > 0 THEN 1 END)
      comment: "Number of delayed movements - operational efficiency and scheduling performance indicator"
    - name: "avg_movement_duration_minutes"
      expr: AVG(CAST(duration_minutes AS DOUBLE))
      comment: "Average movement duration in minutes - marine operations efficiency metric"
    - name: "avg_delay_minutes"
      expr: AVG(CAST(delay_minutes AS DOUBLE))
      comment: "Average delay duration in minutes - schedule adherence and congestion indicator"
    - name: "avg_number_of_tugs"
      expr: AVG(CAST(number_of_tugs AS DOUBLE))
      comment: "Average number of tugs per movement - towage resource utilization metric"
    - name: "avg_draft_forward_meters"
      expr: AVG(CAST(draft_forward_meters AS DOUBLE))
      comment: "Average forward draft in meters - vessel loading and channel depth planning metric"
    - name: "avg_draft_aft_meters"
      expr: AVG(CAST(draft_aft_meters AS DOUBLE))
      comment: "Average aft draft in meters - vessel loading and berth depth planning metric"
    - name: "avg_speed_over_ground_knots"
      expr: AVG(CAST(speed_over_ground_knots AS DOUBLE))
      comment: "Average speed over ground in knots - movement efficiency and safety metric"
    - name: "avg_wind_speed_knots"
      expr: AVG(CAST(wind_speed_knots AS DOUBLE))
      comment: "Average wind speed during movements - weather impact on operations metric"
    - name: "avg_current_speed_knots"
      expr: AVG(CAST(current_speed_knots AS DOUBLE))
      comment: "Average current speed during movements - navigational conditions metric"
    - name: "avg_visibility_meters"
      expr: AVG(CAST(visibility_meters AS DOUBLE))
      comment: "Average visibility during movements - safety and operational conditions metric"
    - name: "avg_tide_height_meters"
      expr: AVG(CAST(tide_height_meters AS DOUBLE))
      comment: "Average tide height during movements - tidal window planning metric"
    - name: "distinct_vessels_moved"
      expr: COUNT(DISTINCT vessel_id)
      comment: "Number of unique vessels with movements - traffic diversity metric"
    - name: "distinct_pilots_assigned"
      expr: COUNT(DISTINCT pilot_id)
      comment: "Number of unique pilots assigned - pilot resource utilization metric"
$$;

CREATE OR REPLACE VIEW `vibe_shipping_ports_v1`.`_metrics`.`vessel_psc_inspection`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Port State Control inspection metrics tracking compliance performance, detention rates, deficiency trends, and vessel risk profiles for regulatory compliance and quality management"
  source: "`vibe_shipping_ports_v1`.`vessel`.`psc_inspection`"
  dimensions:
    - name: "inspection_outcome"
      expr: inspection_outcome
      comment: "Outcome of PSC inspection (e.g., clear, deficiencies found, detained)"
    - name: "inspection_type"
      expr: inspection_type
      comment: "Type of PSC inspection (e.g., initial, more detailed, expanded)"
    - name: "inspection_regime"
      expr: inspection_regime
      comment: "PSC regime conducting inspection (e.g., Paris MOU, Tokyo MOU, USCG)"
    - name: "inspection_year"
      expr: YEAR(inspection_date)
      comment: "Year of inspection for trend analysis"
    - name: "inspection_month"
      expr: DATE_TRUNC('MONTH', inspection_date)
      comment: "Month of inspection for seasonal patterns"
    - name: "inspection_quarter"
      expr: DATE_TRUNC('QUARTER', inspection_date)
      comment: "Quarter of inspection for quarterly compliance reviews"
    - name: "detention_flag"
      expr: detention_flag
      comment: "Indicator if vessel was detained following inspection"
    - name: "ship_risk_profile"
      expr: ship_risk_profile
      comment: "Risk profile of vessel (e.g., high risk, standard risk, low risk)"
    - name: "psc_authority_code"
      expr: psc_authority_code
      comment: "Code of PSC authority conducting inspection"
    - name: "follow_up_required_flag"
      expr: follow_up_required_flag
      comment: "Indicator if follow-up action is required"
    - name: "flag_state_notified_flag"
      expr: flag_state_notified_flag
      comment: "Indicator if flag state was notified of inspection results"
  measures:
    - name: "total_inspections"
      expr: COUNT(1)
      comment: "Total number of PSC inspections conducted - inspection volume and port compliance activity metric"
    - name: "inspections_with_detention"
      expr: COUNT(CASE WHEN detention_flag = TRUE THEN 1 END)
      comment: "Number of inspections resulting in detention - critical compliance and quality failure metric"
    - name: "inspections_with_deficiencies"
      expr: COUNT(CASE WHEN CAST(total_deficiencies_found AS DOUBLE) > 0 THEN 1 END)
      comment: "Number of inspections with deficiencies found - compliance performance indicator"
    - name: "inspections_clear"
      expr: COUNT(CASE WHEN inspection_outcome = 'clear' THEN 1 END)
      comment: "Number of inspections with clear outcome - vessel quality and compliance success metric"
    - name: "total_deficiencies_found"
      expr: SUM(CAST(total_deficiencies_found AS DOUBLE))
      comment: "Total number of deficiencies found across all inspections - aggregate compliance gap metric"
    - name: "avg_deficiencies_per_inspection"
      expr: AVG(CAST(total_deficiencies_found AS DOUBLE))
      comment: "Average deficiencies per inspection - vessel quality and compliance intensity metric"
    - name: "avg_detention_duration_hours"
      expr: AVG(CAST(detention_duration_hours AS DOUBLE))
      comment: "Average detention duration in hours - operational impact and compliance severity metric"
    - name: "total_detention_hours"
      expr: SUM(CAST(detention_duration_hours AS DOUBLE))
      comment: "Total detention hours across all inspections - aggregate operational disruption metric"
    - name: "avg_inspection_cost_usd"
      expr: AVG(CAST(inspection_cost_usd AS DOUBLE))
      comment: "Average inspection cost in USD - compliance cost metric"
    - name: "total_inspection_cost_usd"
      expr: SUM(CAST(inspection_cost_usd AS DOUBLE))
      comment: "Total inspection costs in USD - aggregate compliance expenditure metric"
    - name: "inspections_requiring_follow_up"
      expr: COUNT(CASE WHEN follow_up_required_flag = TRUE THEN 1 END)
      comment: "Number of inspections requiring follow-up action - ongoing compliance workload metric"
    - name: "high_risk_vessel_inspections"
      expr: COUNT(CASE WHEN ship_risk_profile = 'high risk' THEN 1 END)
      comment: "Number of inspections on high-risk vessels - targeted inspection effectiveness metric"
    - name: "distinct_vessels_inspected"
      expr: COUNT(DISTINCT vessel_id)
      comment: "Number of unique vessels inspected - inspection coverage metric"
    - name: "distinct_psc_authorities"
      expr: COUNT(DISTINCT psc_authority_code)
      comment: "Number of unique PSC authorities conducting inspections - regulatory diversity metric"
$$;

CREATE OR REPLACE VIEW `vibe_shipping_ports_v1`.`_metrics`.`vessel_vessel`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Vessel master data metrics tracking fleet characteristics, vessel risk profiles, compliance status, and operational readiness for fleet management and customer service quality"
  source: "`vibe_shipping_ports_v1`.`vessel`.`vessel`"
  dimensions:
    - name: "operational_status"
      expr: operational_status
      comment: "Current operational status of vessel (e.g., active, laid-up, scrapped)"
    - name: "vessel_type"
      expr: vessel_type_id
      comment: "Type of vessel (container, bulk carrier, tanker, etc.) - use ID for grouping"
    - name: "flag_state"
      expr: flag_state_id
      comment: "Flag state of vessel registration - use ID for grouping"
    - name: "classification_society_code"
      expr: classification_society_code
      comment: "Classification society code for quality and standards grouping"
    - name: "isps_security_level"
      expr: isps_security_level
      comment: "Current ISPS security level of vessel"
    - name: "last_psc_detention_flag"
      expr: last_psc_detention_flag
      comment: "Indicator if vessel was detained at last PSC inspection"
    - name: "ownership_current_flag"
      expr: ownership_current_flag
      comment: "Indicator if ownership record is current"
    - name: "pni_club_code"
      expr: pni_club_code
      comment: "P&I club code for insurance grouping"
    - name: "owner_country_domicile_code"
      expr: owner_country_domicile_code
      comment: "Country code of vessel owner domicile"
    - name: "year_built"
      expr: year_built
      comment: "Year vessel was built for age analysis"
  measures:
    - name: "total_vessels"
      expr: COUNT(1)
      comment: "Total number of vessels in registry - fleet size and market coverage metric"
    - name: "active_vessels"
      expr: COUNT(CASE WHEN operational_status = 'active' THEN 1 END)
      comment: "Number of active vessels - operational fleet capacity metric"
    - name: "vessels_with_recent_detention"
      expr: COUNT(CASE WHEN last_psc_detention_flag = TRUE THEN 1 END)
      comment: "Number of vessels with recent PSC detention - fleet quality and risk indicator"
    - name: "avg_vessel_age_years"
      expr: AVG(CAST(YEAR(CURRENT_DATE()) - CAST(year_built AS INT) AS DOUBLE))
      comment: "Average vessel age in years - fleet modernization and investment planning metric"
    - name: "avg_teu_capacity"
      expr: AVG(CAST(teu_capacity AS DOUBLE))
      comment: "Average TEU capacity per vessel - fleet capacity and vessel size metric"
    - name: "total_teu_capacity"
      expr: SUM(CAST(teu_capacity AS DOUBLE))
      comment: "Total TEU capacity across fleet - aggregate capacity planning metric"
    - name: "avg_dwt_tonnes"
      expr: AVG(CAST(dwt_tonnes AS DOUBLE))
      comment: "Average deadweight tonnage - vessel cargo capacity metric"
    - name: "total_dwt_tonnes"
      expr: SUM(CAST(dwt_tonnes AS DOUBLE))
      comment: "Total deadweight tonnage across fleet - aggregate cargo capacity metric"
    - name: "avg_grt_tonnes"
      expr: AVG(CAST(grt_tonnes AS DOUBLE))
      comment: "Average gross registered tonnage - vessel size metric"
    - name: "avg_loa_meters"
      expr: AVG(CAST(loa_meters AS DOUBLE))
      comment: "Average length overall in meters - berth planning and infrastructure compatibility metric"
    - name: "avg_beam_meters"
      expr: AVG(CAST(beam_meters AS DOUBLE))
      comment: "Average beam in meters - berth width and lock compatibility metric"
    - name: "avg_draft_meters"
      expr: AVG(CAST(draft_meters AS DOUBLE))
      comment: "Average draft in meters - channel depth and berth depth planning metric"
    - name: "avg_last_psc_deficiency_count"
      expr: AVG(CAST(last_psc_deficiency_count AS DOUBLE))
      comment: "Average deficiencies at last PSC inspection - fleet quality and compliance metric"
    - name: "avg_risk_profile_score"
      expr: AVG(CAST(risk_profile_score AS DOUBLE))
      comment: "Average vessel risk profile score - fleet risk management and targeting metric"
    - name: "distinct_flag_states"
      expr: COUNT(DISTINCT flag_state_id)
      comment: "Number of unique flag states - fleet diversity and regulatory exposure metric"
    - name: "distinct_vessel_types"
      expr: COUNT(DISTINCT vessel_type_id)
      comment: "Number of unique vessel types - service diversity metric"
    - name: "distinct_owners"
      expr: COUNT(DISTINCT registered_owner_imo_company_number)
      comment: "Number of unique vessel owners - customer base diversity metric"
    - name: "distinct_classification_societies"
      expr: COUNT(DISTINCT classification_society_code)
      comment: "Number of unique classification societies - quality standards diversity metric"
$$;

CREATE OR REPLACE VIEW `vibe_shipping_ports_v1`.`_metrics`.`vessel_port_call_financial`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Port call financial and operational performance metrics tracking revenue, cargo throughput, call efficiency, and PSC compliance for financial planning and operational excellence"
  source: "`vibe_shipping_ports_v1`.`vessel`.`call`"
  dimensions:
    - name: "call_status"
      expr: call_status
      comment: "Status of port call (scheduled, in-progress, completed, cancelled)"
  measures:
    - name: "total_port_calls"
      expr: COUNT(1)
      comment: "Total number of port calls for volume and activity tracking"
    - name: "completed_calls"
      expr: COUNT(CASE WHEN call_status = 'completed' THEN 1 END)
      comment: "Number of completed port calls for throughput measurement"
    - name: "distinct_vessels"
      expr: COUNT(DISTINCT vessel_id)
      comment: "Number of unique vessels - customer diversity and market reach metric"
    - name: "distinct_participants"
      expr: COUNT(DISTINCT participant_account_id)
      comment: "Number of unique participant accounts - customer base diversity metric"
$$;