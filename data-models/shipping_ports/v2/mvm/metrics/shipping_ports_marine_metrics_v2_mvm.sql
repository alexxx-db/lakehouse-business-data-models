-- Metric views for domain: marine | Business: Shipping_Ports | Version: 2 | Generated on: 2026-07-13 10:21:34

CREATE OR REPLACE VIEW `vibe_shipping_ports_v1`.`_metrics`.`marine_pilotage_assignment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Pilotage service performance and operational efficiency metrics tracking pilot assignments, passage execution, safety compliance, and service delivery quality"
  source: "`vibe_shipping_ports_v1`.`marine`.`pilotage_assignment`"
  dimensions:
    - name: "assignment_status"
      expr: assignment_status
      comment: "Current status of the pilotage assignment (scheduled, in-progress, completed, cancelled)"
    - name: "service_type"
      expr: service_type
      comment: "Type of pilotage service provided (inbound, outbound, shifting, escort)"
    - name: "boarding_method"
      expr: boarding_method
      comment: "Method used for pilot boarding (launch, helicopter, gangway)"
    - name: "pilot_licence_class"
      expr: pilot_licence_class
      comment: "Licence class of the assigned pilot indicating authorized vessel types and routes"
    - name: "billing_status"
      expr: billing_status
      comment: "Billing status of the pilotage service (pending, invoiced, paid)"
    - name: "isps_compliance_verified"
      expr: isps_compliance_verified
      comment: "Whether ISPS security compliance was verified during the assignment"
    - name: "incident_reported"
      expr: incident_reported
      comment: "Whether any incident was reported during the pilotage assignment"
    - name: "deviation_from_passage_plan"
      expr: deviation_from_passage_plan
      comment: "Whether the vessel deviated from the planned passage route"
    - name: "tug_required"
      expr: tug_required
      comment: "Whether tug assistance was required for the pilotage operation"
    - name: "assignment_year"
      expr: YEAR(scheduled_boarding_timestamp)
      comment: "Year of the scheduled pilotage assignment"
    - name: "assignment_month"
      expr: DATE_TRUNC('MONTH', scheduled_boarding_timestamp)
      comment: "Month of the scheduled pilotage assignment"
    - name: "assignment_date"
      expr: DATE(scheduled_boarding_timestamp)
      comment: "Date of the scheduled pilotage assignment"
  measures:
    - name: "total_pilotage_assignments"
      expr: COUNT(1)
      comment: "Total number of pilotage assignments executed"
    - name: "total_service_charge_amount"
      expr: SUM(CAST(service_charge_amount AS DOUBLE))
      comment: "Total pilotage service charges billed across all assignments"
    - name: "avg_service_charge_amount"
      expr: AVG(CAST(service_charge_amount AS DOUBLE))
      comment: "Average pilotage service charge per assignment"
    - name: "total_passage_distance_nm"
      expr: SUM(CAST(passage_distance_nm AS DOUBLE))
      comment: "Total nautical miles piloted across all assignments"
    - name: "avg_passage_distance_nm"
      expr: AVG(CAST(passage_distance_nm AS DOUBLE))
      comment: "Average passage distance per pilotage assignment in nautical miles"
    - name: "avg_speed_over_ground_knots"
      expr: AVG(CAST(speed_over_ground_avg_knots AS DOUBLE))
      comment: "Average speed over ground during pilotage passages in knots"
    - name: "avg_min_ukc_recorded_m"
      expr: AVG(CAST(min_ukc_recorded_m AS DOUBLE))
      comment: "Average minimum under-keel clearance recorded during passages in meters"
    - name: "min_ukc_recorded_m"
      expr: MIN(CAST(min_ukc_recorded_m AS DOUBLE))
      comment: "Minimum under-keel clearance recorded across all passages in meters"
    - name: "avg_visibility_nm"
      expr: AVG(CAST(visibility_nm AS DOUBLE))
      comment: "Average visibility during pilotage operations in nautical miles"
    - name: "avg_wind_speed_knots"
      expr: AVG(CAST(wind_speed_knots AS DOUBLE))
      comment: "Average wind speed during pilotage operations in knots"
    - name: "avg_tide_height_m"
      expr: AVG(CAST(tide_height_m AS DOUBLE))
      comment: "Average tide height during pilotage operations in meters"
    - name: "incident_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(CASE WHEN incident_reported = TRUE THEN 1 ELSE 0 END AS INT)) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of pilotage assignments with reported incidents (safety KPI)"
    - name: "deviation_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(CASE WHEN deviation_from_passage_plan = TRUE THEN 1 ELSE 0 END AS INT)) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of pilotage assignments with passage plan deviations (compliance KPI)"
    - name: "isps_compliance_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(CASE WHEN isps_compliance_verified = TRUE THEN 1 ELSE 0 END AS INT)) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of pilotage assignments with verified ISPS compliance (security KPI)"
    - name: "tug_utilization_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(CASE WHEN tug_required = TRUE THEN 1 ELSE 0 END AS INT)) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of pilotage assignments requiring tug assistance (resource utilization KPI)"
    - name: "distinct_pilots"
      expr: COUNT(DISTINCT pilot_id)
      comment: "Number of unique pilots assigned to pilotage operations"
    - name: "distinct_vessels"
      expr: COUNT(DISTINCT call_id)
      comment: "Number of unique vessel calls serviced by pilotage operations"
$$;


CREATE OR REPLACE VIEW `vibe_shipping_ports_v1`.`_metrics`.`marine_towage_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Towage service performance and revenue metrics tracking tug operations, service delivery, safety, and billing efficiency"
  source: "`vibe_shipping_ports_v1`.`marine`.`towage_order`"
  dimensions:
    - name: "order_status"
      expr: order_status
      comment: "Current status of the towage order (requested, scheduled, in-progress, completed, aborted)"
    - name: "towage_type"
      expr: towage_type
      comment: "Type of towage service (berthing, unberthing, shifting, escort, emergency)"
    - name: "billing_status"
      expr: billing_status
      comment: "Billing status of the towage order (pending, invoiced, paid, disputed)"
    - name: "service_outcome"
      expr: service_outcome
      comment: "Outcome of the towage service (successful, aborted, partial)"
    - name: "imdg_hazmat_flag"
      expr: imdg_hazmat_flag
      comment: "Whether the towed vessel carried IMDG hazardous materials"
    - name: "safety_observation_flag"
      expr: safety_observation_flag
      comment: "Whether any safety observation was recorded during the towage operation"
    - name: "visibility_category"
      expr: visibility_category
      comment: "Visibility conditions during towage operation (good, moderate, poor, restricted)"
    - name: "tug_attachment_bow"
      expr: tug_attachment_bow
      comment: "Whether tug was attached at bow position"
    - name: "tug_attachment_stern"
      expr: tug_attachment_stern
      comment: "Whether tug was attached at stern position"
    - name: "tug_attachment_breast"
      expr: tug_attachment_breast
      comment: "Whether tug was attached at breast position"
    - name: "order_year"
      expr: YEAR(scheduled_commencement)
      comment: "Year of the scheduled towage commencement"
    - name: "order_month"
      expr: DATE_TRUNC('MONTH', scheduled_commencement)
      comment: "Month of the scheduled towage commencement"
    - name: "order_date"
      expr: DATE(scheduled_commencement)
      comment: "Date of the scheduled towage commencement"
  measures:
    - name: "total_towage_orders"
      expr: COUNT(1)
      comment: "Total number of towage orders executed"
    - name: "total_towage_charge_amount"
      expr: SUM(CAST(towage_charge_amount AS DOUBLE))
      comment: "Total towage charges billed across all orders"
    - name: "avg_towage_charge_amount"
      expr: AVG(CAST(towage_charge_amount AS DOUBLE))
      comment: "Average towage charge per order"
    - name: "avg_min_bollard_pull_tonnes"
      expr: AVG(CAST(min_bollard_pull_tonnes AS DOUBLE))
      comment: "Average minimum bollard pull required for towage operations in tonnes"
    - name: "max_min_bollard_pull_tonnes"
      expr: MAX(CAST(min_bollard_pull_tonnes AS DOUBLE))
      comment: "Maximum minimum bollard pull required across all towage operations in tonnes"
    - name: "avg_current_speed_knots"
      expr: AVG(CAST(current_speed_knots AS DOUBLE))
      comment: "Average current speed during towage operations in knots"
    - name: "avg_wind_speed_knots"
      expr: AVG(CAST(wind_speed_knots AS DOUBLE))
      comment: "Average wind speed during towage operations in knots"
    - name: "max_wind_speed_knots"
      expr: MAX(CAST(wind_speed_knots AS DOUBLE))
      comment: "Maximum wind speed recorded during towage operations in knots"
    - name: "safety_observation_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(CASE WHEN safety_observation_flag = TRUE THEN 1 ELSE 0 END AS INT)) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of towage orders with safety observations recorded (safety KPI)"
    - name: "hazmat_towage_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(CASE WHEN imdg_hazmat_flag = TRUE THEN 1 ELSE 0 END AS INT)) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of towage orders involving hazardous materials (risk exposure KPI)"
    - name: "abort_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(CASE WHEN order_status = 'aborted' THEN 1 ELSE 0 END AS INT)) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of towage orders aborted before completion (service reliability KPI)"
    - name: "successful_completion_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(CASE WHEN service_outcome = 'successful' THEN 1 ELSE 0 END AS INT)) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of towage orders completed successfully (service quality KPI)"
    - name: "distinct_tugs_assigned"
      expr: COUNT(DISTINCT tugs_assigned)
      comment: "Number of unique tug assignments across all towage orders"
    - name: "distinct_pilots"
      expr: COUNT(DISTINCT pilot_id)
      comment: "Number of unique pilots involved in towage operations"
$$;


CREATE OR REPLACE VIEW `vibe_shipping_ports_v1`.`_metrics`.`marine_tug_assignment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tug operational efficiency and utilization metrics tracking individual tug assignments, fuel consumption, engagement duration, and safety performance"
  source: "`vibe_shipping_ports_v1`.`marine`.`tug_assignment`"
  dimensions:
    - name: "assignment_status"
      expr: assignment_status
      comment: "Current status of the tug assignment (assigned, mobilised, engaged, completed, aborted)"
    - name: "assignment_outcome"
      expr: assignment_outcome
      comment: "Outcome of the tug assignment (successful, aborted, partial)"
    - name: "assigned_position"
      expr: assigned_position
      comment: "Position assigned to the tug (bow, stern, breast, escort)"
    - name: "billable"
      expr: billable
      comment: "Whether the tug assignment is billable to the customer"
    - name: "incident_reported"
      expr: incident_reported
      comment: "Whether any incident was reported during the tug assignment"
    - name: "safety_observation_flag"
      expr: safety_observation_flag
      comment: "Whether any safety observation was recorded during the tug assignment"
    - name: "fuel_type"
      expr: fuel_type
      comment: "Type of fuel consumed by the tug during the assignment"
    - name: "tow_line_type"
      expr: tow_line_type
      comment: "Type of tow line used during the assignment"
    - name: "assignment_year"
      expr: YEAR(scheduled_mobilisation_timestamp)
      comment: "Year of the scheduled tug mobilisation"
    - name: "assignment_month"
      expr: DATE_TRUNC('MONTH', scheduled_mobilisation_timestamp)
      comment: "Month of the scheduled tug mobilisation"
    - name: "assignment_date"
      expr: DATE(scheduled_mobilisation_timestamp)
      comment: "Date of the scheduled tug mobilisation"
  measures:
    - name: "total_tug_assignments"
      expr: COUNT(1)
      comment: "Total number of tug assignments executed"
    - name: "total_fuel_consumed_litres"
      expr: SUM(CAST(fuel_consumed_litres AS DOUBLE))
      comment: "Total fuel consumed across all tug assignments in litres"
    - name: "avg_fuel_consumed_litres"
      expr: AVG(CAST(fuel_consumed_litres AS DOUBLE))
      comment: "Average fuel consumption per tug assignment in litres"
    - name: "avg_bollard_pull_applied_tonnes"
      expr: AVG(CAST(bollard_pull_applied_tonnes AS DOUBLE))
      comment: "Average bollard pull applied during tug assignments in tonnes"
    - name: "max_bollard_pull_applied_tonnes_peak"
      expr: MAX(CAST(max_bollard_pull_applied_tonnes AS DOUBLE))
      comment: "Peak maximum bollard pull applied across all tug assignments in tonnes"
    - name: "avg_tow_line_length_m"
      expr: AVG(CAST(tow_line_length_m AS DOUBLE))
      comment: "Average tow line length used during tug assignments in meters"
    - name: "avg_tide_height_m"
      expr: AVG(CAST(tide_height_m AS DOUBLE))
      comment: "Average tide height during tug assignments in meters"
    - name: "avg_visibility_nm"
      expr: AVG(CAST(visibility_nm AS DOUBLE))
      comment: "Average visibility during tug assignments in nautical miles"
    - name: "avg_wind_speed_knots"
      expr: AVG(CAST(wind_speed_knots AS DOUBLE))
      comment: "Average wind speed during tug assignments in knots"
    - name: "avg_current_speed_knots"
      expr: AVG(CAST(current_speed_knots AS DOUBLE))
      comment: "Average current speed during tug assignments in knots"
    - name: "incident_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(CASE WHEN incident_reported = TRUE THEN 1 ELSE 0 END AS INT)) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of tug assignments with reported incidents (safety KPI)"
    - name: "safety_observation_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(CASE WHEN safety_observation_flag = TRUE THEN 1 ELSE 0 END AS INT)) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of tug assignments with safety observations (safety KPI)"
    - name: "billable_assignment_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(CASE WHEN billable = TRUE THEN 1 ELSE 0 END AS INT)) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of tug assignments that are billable (revenue efficiency KPI)"
    - name: "successful_assignment_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(CASE WHEN assignment_outcome = 'successful' THEN 1 ELSE 0 END AS INT)) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of tug assignments completed successfully (operational quality KPI)"
    - name: "distinct_tugs"
      expr: COUNT(DISTINCT tug_id)
      comment: "Number of unique tugs deployed across all assignments"
    - name: "distinct_vessels_assisted"
      expr: COUNT(DISTINCT call_id)
      comment: "Number of unique vessel calls assisted by tug assignments"
$$;


CREATE OR REPLACE VIEW `vibe_shipping_ports_v1`.`_metrics`.`marine_mooring_operation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Mooring operation performance and safety metrics tracking line handling, bollard usage, operational efficiency, and incident management"
  source: "`vibe_shipping_ports_v1`.`marine`.`mooring_operation`"
  dimensions:
    - name: "operation_status"
      expr: operation_status
      comment: "Current status of the mooring operation (scheduled, in-progress, completed, cancelled)"
    - name: "operation_type"
      expr: operation_type
      comment: "Type of mooring operation (berthing, unberthing, shifting, emergency)"
    - name: "mooring_location_type"
      expr: mooring_location_type
      comment: "Type of mooring location (berth, anchorage, buoy, dolphin)"
    - name: "vessel_movement_type"
      expr: vessel_movement_type
      comment: "Type of vessel movement during mooring (arrival, departure, shifting)"
    - name: "billable"
      expr: billable
      comment: "Whether the mooring operation is billable to the customer"
    - name: "incident_reported"
      expr: incident_reported
      comment: "Whether any incident was reported during the mooring operation"
    - name: "irregularity_observed"
      expr: irregularity_observed
      comment: "Whether any irregularity was observed during the mooring operation"
    - name: "swl_compliant"
      expr: swl_compliant
      comment: "Whether the mooring operation was compliant with safe working load limits"
    - name: "pilot_on_board"
      expr: pilot_on_board
      comment: "Whether a pilot was on board during the mooring operation"
    - name: "towage_assist_used"
      expr: towage_assist_used
      comment: "Whether towage assistance was used during the mooring operation"
    - name: "capstans_used"
      expr: capstans_used
      comment: "Whether capstans were used during the mooring operation"
    - name: "quick_release_hooks_used"
      expr: quick_release_hooks_used
      comment: "Whether quick release hooks were used during the mooring operation"
    - name: "line_material_type"
      expr: line_material_type
      comment: "Type of line material used for mooring (synthetic, wire, combination)"
    - name: "visibility_category"
      expr: visibility_category
      comment: "Visibility conditions during mooring operation (good, moderate, poor, restricted)"
    - name: "operation_year"
      expr: YEAR(commencement_timestamp)
      comment: "Year of the mooring operation commencement"
    - name: "operation_month"
      expr: DATE_TRUNC('MONTH', commencement_timestamp)
      comment: "Month of the mooring operation commencement"
    - name: "operation_date"
      expr: DATE(commencement_timestamp)
      comment: "Date of the mooring operation commencement"
  measures:
    - name: "total_mooring_operations"
      expr: COUNT(1)
      comment: "Total number of mooring operations executed"
    - name: "total_charge_amount"
      expr: SUM(CAST(charge_amount AS DOUBLE))
      comment: "Total mooring charges billed across all operations"
    - name: "avg_charge_amount"
      expr: AVG(CAST(charge_amount AS DOUBLE))
      comment: "Average mooring charge per operation"
    - name: "avg_current_speed_knots"
      expr: AVG(CAST(current_speed_knots AS DOUBLE))
      comment: "Average current speed during mooring operations in knots"
    - name: "avg_wind_speed_knots"
      expr: AVG(CAST(wind_speed_knots AS DOUBLE))
      comment: "Average wind speed during mooring operations in knots"
    - name: "max_wind_speed_knots"
      expr: MAX(CAST(wind_speed_knots AS DOUBLE))
      comment: "Maximum wind speed recorded during mooring operations in knots"
    - name: "avg_tide_height_m"
      expr: AVG(CAST(tide_height_m AS DOUBLE))
      comment: "Average tide height during mooring operations in meters"
    - name: "incident_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(CASE WHEN incident_reported = TRUE THEN 1 ELSE 0 END AS INT)) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of mooring operations with reported incidents (safety KPI)"
    - name: "irregularity_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(CASE WHEN irregularity_observed = TRUE THEN 1 ELSE 0 END AS INT)) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of mooring operations with observed irregularities (quality KPI)"
    - name: "swl_compliance_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(CASE WHEN swl_compliant = TRUE THEN 1 ELSE 0 END AS INT)) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of mooring operations compliant with safe working load limits (safety compliance KPI)"
    - name: "pilot_utilization_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(CASE WHEN pilot_on_board = TRUE THEN 1 ELSE 0 END AS INT)) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of mooring operations with pilot on board (resource utilization KPI)"
    - name: "towage_assist_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(CASE WHEN towage_assist_used = TRUE THEN 1 ELSE 0 END AS INT)) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of mooring operations requiring towage assistance (complexity indicator)"
    - name: "billable_operation_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(CASE WHEN billable = TRUE THEN 1 ELSE 0 END AS INT)) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of mooring operations that are billable (revenue efficiency KPI)"
    - name: "distinct_berths"
      expr: COUNT(DISTINCT berth_id)
      comment: "Number of unique berths used for mooring operations"
    - name: "distinct_vessels"
      expr: COUNT(DISTINCT call_id)
      comment: "Number of unique vessel calls serviced by mooring operations"
$$;


CREATE OR REPLACE VIEW `vibe_shipping_ports_v1`.`_metrics`.`marine_service_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Marine service order management and fulfillment metrics tracking order lifecycle, service delivery, resource coordination, and revenue performance"
  source: "`vibe_shipping_ports_v1`.`marine`.`service_order`"
  dimensions:
    - name: "order_status"
      expr: order_status
      comment: "Current status of the service order (requested, confirmed, in-progress, completed, cancelled)"
    - name: "order_type"
      expr: order_type
      comment: "Type of marine service order (pilotage, towage, mooring, combined)"
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level of the service order (routine, urgent, emergency)"
    - name: "pilotage_required"
      expr: pilotage_required
      comment: "Whether pilotage service is required for this order"
    - name: "towage_required"
      expr: towage_required
      comment: "Whether towage service is required for this order"
    - name: "mooring_required"
      expr: mooring_required
      comment: "Whether mooring service is required for this order"
    - name: "launch_service_required"
      expr: launch_service_required
      comment: "Whether launch service is required for this order"
    - name: "surveyor_required"
      expr: surveyor_required
      comment: "Whether surveyor service is required for this order"
    - name: "pilotage_type"
      expr: pilotage_type
      comment: "Type of pilotage service required (inbound, outbound, shifting)"
    - name: "pilot_boarding_location"
      expr: pilot_boarding_location
      comment: "Location where pilot will board the vessel"
    - name: "order_year"
      expr: YEAR(created_timestamp)
      comment: "Year the service order was created"
    - name: "order_month"
      expr: DATE_TRUNC('MONTH', created_timestamp)
      comment: "Month the service order was created"
    - name: "order_date"
      expr: DATE(created_timestamp)
      comment: "Date the service order was created"
  measures:
    - name: "total_service_orders"
      expr: COUNT(1)
      comment: "Total number of marine service orders created"
    - name: "total_estimated_charge"
      expr: SUM(CAST(estimated_total_charge AS DOUBLE))
      comment: "Total estimated charges across all service orders"
    - name: "avg_estimated_charge"
      expr: AVG(CAST(estimated_total_charge AS DOUBLE))
      comment: "Average estimated charge per service order"
    - name: "pilotage_required_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(CASE WHEN pilotage_required = TRUE THEN 1 ELSE 0 END AS INT)) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of service orders requiring pilotage (service mix KPI)"
    - name: "towage_required_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(CASE WHEN towage_required = TRUE THEN 1 ELSE 0 END AS INT)) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of service orders requiring towage (service mix KPI)"
    - name: "mooring_required_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(CASE WHEN mooring_required = TRUE THEN 1 ELSE 0 END AS INT)) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of service orders requiring mooring (service mix KPI)"
    - name: "launch_service_required_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(CASE WHEN launch_service_required = TRUE THEN 1 ELSE 0 END AS INT)) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of service orders requiring launch service (service mix KPI)"
    - name: "surveyor_required_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(CASE WHEN surveyor_required = TRUE THEN 1 ELSE 0 END AS INT)) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of service orders requiring surveyor (service mix KPI)"
    - name: "cancellation_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(CASE WHEN order_status = 'cancelled' THEN 1 ELSE 0 END AS INT)) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of service orders cancelled (service reliability KPI)"
    - name: "completion_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(CASE WHEN order_status = 'completed' THEN 1 ELSE 0 END AS INT)) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of service orders completed (fulfillment KPI)"
    - name: "distinct_vessels"
      expr: COUNT(DISTINCT call_id)
      comment: "Number of unique vessel calls serviced by marine service orders"
    - name: "distinct_berths"
      expr: COUNT(DISTINCT berth_id)
      comment: "Number of unique berths involved in service orders"
    - name: "distinct_customers"
      expr: COUNT(DISTINCT participant_account_id)
      comment: "Number of unique customer accounts placing service orders"
$$;


CREATE OR REPLACE VIEW `vibe_shipping_ports_v1`.`_metrics`.`marine_pilot`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Pilot workforce management and compliance metrics tracking pilot qualifications, certifications, competency, and regulatory compliance status"
  source: "`vibe_shipping_ports_v1`.`marine`.`pilot`"
  dimensions:
    - name: "duty_status"
      expr: duty_status
      comment: "Current duty status of the pilot (active, on-leave, suspended, retired)"
    - name: "licence_status"
      expr: licence_status
      comment: "Status of the pilot licence (valid, expired, suspended, revoked)"
    - name: "competency_class"
      expr: competency_class
      comment: "Competency class of the pilot indicating authorized vessel types and routes"
    - name: "employment_type"
      expr: employment_type
      comment: "Type of employment (permanent, contract, casual)"
    - name: "deep_sea_pilot_endorsement"
      expr: deep_sea_pilot_endorsement
      comment: "Whether the pilot holds a deep sea pilot endorsement"
    - name: "night_pilotage_authorised"
      expr: night_pilotage_authorised
      comment: "Whether the pilot is authorized for night pilotage operations"
    - name: "radar_arpa_endorsement"
      expr: radar_arpa_endorsement
      comment: "Whether the pilot holds radar ARPA endorsement"
    - name: "vhf_radio_operator_cert"
      expr: vhf_radio_operator_cert
      comment: "Whether the pilot holds VHF radio operator certification"
    - name: "medical_cert_status"
      expr: medical_cert_status
      comment: "Status of the pilot medical certificate (valid, expired, pending)"
    - name: "isps_clearance_level"
      expr: isps_clearance_level
      comment: "ISPS security clearance level of the pilot"
    - name: "english_proficiency_level"
      expr: english_proficiency_level
      comment: "English language proficiency level of the pilot"
  measures:
    - name: "total_pilots"
      expr: COUNT(1)
      comment: "Total number of pilots in the workforce"
    - name: "avg_max_dwt_mt"
      expr: AVG(CAST(max_dwt_mt AS DOUBLE))
      comment: "Average maximum deadweight tonnage authorized across all pilots"
    - name: "avg_max_grt"
      expr: AVG(CAST(max_grt AS DOUBLE))
      comment: "Average maximum gross registered tonnage authorized across all pilots"
    - name: "avg_max_loa_m"
      expr: AVG(CAST(max_loa_m AS DOUBLE))
      comment: "Average maximum length overall authorized across all pilots in meters"
    - name: "active_pilot_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(CASE WHEN duty_status = 'active' THEN 1 ELSE 0 END AS INT)) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of pilots in active duty status (workforce availability KPI)"
    - name: "valid_licence_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(CASE WHEN licence_status = 'valid' THEN 1 ELSE 0 END AS INT)) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of pilots with valid licences (compliance KPI)"
    - name: "deep_sea_endorsement_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(CASE WHEN deep_sea_pilot_endorsement = TRUE THEN 1 ELSE 0 END AS INT)) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of pilots with deep sea endorsement (capability KPI)"
    - name: "night_pilotage_authorised_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(CASE WHEN night_pilotage_authorised = TRUE THEN 1 ELSE 0 END AS INT)) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of pilots authorized for night pilotage (operational flexibility KPI)"
    - name: "radar_arpa_endorsement_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(CASE WHEN radar_arpa_endorsement = TRUE THEN 1 ELSE 0 END AS INT)) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of pilots with radar ARPA endorsement (technical capability KPI)"
    - name: "vhf_radio_cert_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(CASE WHEN vhf_radio_operator_cert = TRUE THEN 1 ELSE 0 END AS INT)) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of pilots with VHF radio operator certification (communication capability KPI)"
    - name: "valid_medical_cert_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(CASE WHEN medical_cert_status = 'valid' THEN 1 ELSE 0 END AS INT)) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of pilots with valid medical certificates (health compliance KPI)"
    - name: "distinct_ports"
      expr: COUNT(DISTINCT port_id)
      comment: "Number of unique ports where pilots are assigned"
    - name: "distinct_nationalities"
      expr: COUNT(DISTINCT country_id)
      comment: "Number of unique nationalities represented in the pilot workforce"
$$;


CREATE OR REPLACE VIEW `vibe_shipping_ports_v1`.`_metrics`.`marine_tug`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tug fleet management and capability metrics tracking tug specifications, operational status, certifications, and maintenance compliance"
  source: "`vibe_shipping_ports_v1`.`marine`.`tug`"
  dimensions:
    - name: "operational_status"
      expr: operational_status
      comment: "Current operational status of the tug (active, maintenance, laid-up, decommissioned)"
    - name: "tug_type"
      expr: tug_type
      comment: "Type of tug (harbour, ocean-going, escort, AHTS, salvage)"
    - name: "ownership_type"
      expr: ownership_type
      comment: "Type of ownership (owned, chartered, leased)"
    - name: "ahts_capable"
      expr: ahts_capable
      comment: "Whether the tug is capable of anchor handling towing supply operations"
    - name: "escort_certified"
      expr: escort_certified
      comment: "Whether the tug is certified for escort operations"
    - name: "fifi_class"
      expr: fifi_class
      comment: "Fire-fighting class of the tug (FiFi 1, FiFi 2, FiFi 3, none)"
    - name: "ice_class"
      expr: ice_class
      comment: "Ice class rating of the tug"
    - name: "fuel_type"
      expr: fuel_type
      comment: "Type of fuel used by the tug (diesel, LNG, hybrid)"
    - name: "classification_society"
      expr: classification_society
      comment: "Classification society certifying the tug"
  measures:
    - name: "total_tugs"
      expr: COUNT(1)
      comment: "Total number of tugs in the fleet"
    - name: "avg_bollard_pull_tonnes"
      expr: AVG(CAST(bollard_pull_tonnes AS DOUBLE))
      comment: "Average bollard pull capacity across the tug fleet in tonnes"
    - name: "total_bollard_pull_tonnes"
      expr: SUM(CAST(bollard_pull_tonnes AS DOUBLE))
      comment: "Total bollard pull capacity of the entire tug fleet in tonnes"
    - name: "max_bollard_pull_tonnes"
      expr: MAX(CAST(bollard_pull_tonnes AS DOUBLE))
      comment: "Maximum bollard pull capacity in the fleet in tonnes"
    - name: "avg_engine_power_kw"
      expr: AVG(CAST(engine_power_kw AS DOUBLE))
      comment: "Average engine power across the tug fleet in kilowatts"
    - name: "total_engine_power_kw"
      expr: SUM(CAST(engine_power_kw AS DOUBLE))
      comment: "Total engine power of the entire tug fleet in kilowatts"
    - name: "avg_max_speed_knots"
      expr: AVG(CAST(max_speed_knots AS DOUBLE))
      comment: "Average maximum speed across the tug fleet in knots"
    - name: "avg_loa_m"
      expr: AVG(CAST(loa_m AS DOUBLE))
      comment: "Average length overall of tugs in the fleet in meters"
    - name: "avg_beam_m"
      expr: AVG(CAST(beam_m AS DOUBLE))
      comment: "Average beam of tugs in the fleet in meters"
    - name: "avg_gross_tonnage"
      expr: AVG(CAST(gross_tonnage AS DOUBLE))
      comment: "Average gross tonnage of tugs in the fleet"
    - name: "active_tug_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(CASE WHEN operational_status = 'active' THEN 1 ELSE 0 END AS INT)) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of tugs in active operational status (fleet availability KPI)"
    - name: "ahts_capable_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(CASE WHEN ahts_capable = TRUE THEN 1 ELSE 0 END AS INT)) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of tugs capable of AHTS operations (fleet capability KPI)"
    - name: "escort_certified_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(CASE WHEN escort_certified = TRUE THEN 1 ELSE 0 END AS INT)) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of tugs certified for escort operations (fleet capability KPI)"
    - name: "distinct_ports"
      expr: COUNT(DISTINCT port_id)
      comment: "Number of unique ports where tugs are based"
    - name: "distinct_operators"
      expr: COUNT(DISTINCT operating_company)
      comment: "Number of unique operating companies managing tugs in the fleet"
$$;
