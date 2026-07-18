-- Metric views for domain: airport | Business: Airlines | Version: 1 | Generated on: 2026-05-07 12:47:29

CREATE OR REPLACE VIEW `airlines_ecm`.`_metrics`.`airport_turnaround`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Aircraft turnaround efficiency and operational performance metrics for ground operations steering"
  source: "`airlines_ecm`.`airport`.`turnaround`"
  dimensions:
    - name: "turnaround_date"
      expr: DATE_TRUNC('day', actual_block_in_time)
      comment: "Date of turnaround operation for daily trend analysis"
    - name: "turnaround_month"
      expr: DATE_TRUNC('month', actual_block_in_time)
      comment: "Month of turnaround for monthly performance tracking"
    - name: "turnaround_status"
      expr: turnaround_status
      comment: "Status of turnaround completion (completed, delayed, in-progress)"
    - name: "turnaround_type"
      expr: turnaround_type
      comment: "Type of turnaround operation (domestic, international, quick-turn)"
    - name: "delay_code"
      expr: delay_code
      comment: "IATA delay code for root cause analysis"
    - name: "cdm_milestone_status"
      expr: cdm_milestone_status
      comment: "Collaborative Decision Making milestone compliance status"
    - name: "all_services_completed"
      expr: all_services_completed_flag
      comment: "Whether all ground services were completed on time"
    - name: "otp_impact"
      expr: otp_impact_flag
      comment: "Whether turnaround impacted on-time performance"
  measures:
    - name: "turnaround_count"
      expr: COUNT(1)
      comment: "Total number of aircraft turnarounds"
    - name: "total_turnaround_time_minutes"
      expr: SUM(CAST(actual_turnaround_time_minutes AS DOUBLE))
      comment: "Total actual turnaround time across all operations"
    - name: "avg_turnaround_time_minutes"
      expr: AVG(CAST(actual_turnaround_time_minutes AS DOUBLE))
      comment: "Average turnaround time per operation - key efficiency KPI"
    - name: "total_delay_minutes"
      expr: SUM(CAST(delay_minutes AS DOUBLE))
      comment: "Total delay minutes attributed to turnaround operations"
    - name: "avg_delay_minutes"
      expr: AVG(CAST(delay_minutes AS DOUBLE))
      comment: "Average delay per turnaround - operational quality indicator"
    - name: "total_fuel_uplift_kg"
      expr: SUM(CAST(fuel_uplift_kg AS DOUBLE))
      comment: "Total fuel loaded during turnarounds - cost and efficiency metric"
    - name: "avg_fuel_uplift_kg"
      expr: AVG(CAST(fuel_uplift_kg AS DOUBLE))
      comment: "Average fuel uplift per turnaround"
    - name: "total_cargo_loaded_kg"
      expr: SUM(CAST(cargo_weight_loaded_kg AS DOUBLE))
      comment: "Total cargo weight loaded - revenue capacity utilization"
    - name: "total_cargo_offloaded_kg"
      expr: SUM(CAST(cargo_weight_offloaded_kg AS DOUBLE))
      comment: "Total cargo weight offloaded"
    - name: "total_passengers_boarded"
      expr: SUM(CAST(passenger_count_boarded AS DOUBLE))
      comment: "Total passengers boarded during turnarounds"
    - name: "total_passengers_deplaned"
      expr: SUM(CAST(passenger_count_deplaned AS DOUBLE))
      comment: "Total passengers deplaned during turnarounds"
    - name: "total_baggage_loaded"
      expr: SUM(CAST(baggage_pieces_loaded AS DOUBLE))
      comment: "Total baggage pieces loaded"
    - name: "total_baggage_offloaded"
      expr: SUM(CAST(baggage_pieces_offloaded AS DOUBLE))
      comment: "Total baggage pieces offloaded"
    - name: "on_time_turnaround_count"
      expr: SUM(CASE WHEN otp_impact_flag = FALSE THEN 1 ELSE 0 END)
      comment: "Count of turnarounds that did not impact on-time performance"
    - name: "delayed_turnaround_count"
      expr: SUM(CASE WHEN otp_impact_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of turnarounds that caused delays"
    - name: "completed_services_count"
      expr: SUM(CASE WHEN all_services_completed_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of turnarounds where all services completed successfully"
$$;


CREATE OR REPLACE VIEW `airlines_ecm`.`_metrics`.`airport_baggage_irregularity`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Baggage mishandling performance and customer service quality metrics for operational steering"
  source: "`airlines_ecm`.`airport`.`baggage_irregularity`"
  dimensions:
    - name: "report_date"
      expr: DATE_TRUNC('day', report_timestamp)
      comment: "Date irregularity was reported"
    - name: "report_month"
      expr: DATE_TRUNC('month', report_timestamp)
      comment: "Month of irregularity for trend analysis"
    - name: "irregularity_type"
      expr: irregularity_type_code
      comment: "Type of baggage irregularity (delayed, damaged, lost, pilfered)"
    - name: "recovery_status"
      expr: recovery_status_code
      comment: "Current recovery status of irregular baggage"
    - name: "handling_carrier"
      expr: handling_carrier_code
      comment: "Carrier responsible for baggage handling"
    - name: "responsible_carrier"
      expr: responsible_carrier_code
      comment: "Carrier liable for irregularity"
    - name: "destination_station"
      expr: destination_station_code
      comment: "Destination airport code"
    - name: "dot_reportable"
      expr: dot_reportable_flag
      comment: "Whether irregularity is reportable to DOT"
    - name: "regulatory_reporting_required"
      expr: regulatory_reporting_flag
      comment: "Whether regulatory reporting is required"
  measures:
    - name: "irregularity_count"
      expr: COUNT(1)
      comment: "Total number of baggage irregularities - primary quality KPI"
    - name: "total_compensation_amount"
      expr: SUM(CAST(compensation_amount AS DOUBLE))
      comment: "Total compensation paid to passengers - direct cost impact"
    - name: "avg_compensation_amount"
      expr: AVG(CAST(compensation_amount AS DOUBLE))
      comment: "Average compensation per irregularity"
    - name: "total_liability_amount"
      expr: SUM(CAST(liability_amount AS DOUBLE))
      comment: "Total liability exposure from irregularities"
    - name: "total_interim_expense"
      expr: SUM(CAST(interim_expense_amount AS DOUBLE))
      comment: "Total interim expenses incurred during recovery"
    - name: "total_declared_value"
      expr: SUM(CAST(declared_value_amount AS DOUBLE))
      comment: "Total declared value of irregular baggage"
    - name: "delayed_bag_count"
      expr: SUM(CASE WHEN irregularity_type_code = 'DL' THEN 1 ELSE 0 END)
      comment: "Count of delayed bags"
    - name: "damaged_bag_count"
      expr: SUM(CASE WHEN irregularity_type_code = 'DM' THEN 1 ELSE 0 END)
      comment: "Count of damaged bags"
    - name: "lost_bag_count"
      expr: SUM(CASE WHEN irregularity_type_code IN ('LS', 'LT') THEN 1 ELSE 0 END)
      comment: "Count of lost bags"
    - name: "located_bag_count"
      expr: SUM(CASE WHEN located_timestamp IS NOT NULL THEN 1 ELSE 0 END)
      comment: "Count of bags successfully located"
    - name: "delivered_bag_count"
      expr: SUM(CASE WHEN delivered_timestamp IS NOT NULL THEN 1 ELSE 0 END)
      comment: "Count of bags successfully delivered to passenger"
    - name: "closed_case_count"
      expr: SUM(CASE WHEN closure_timestamp IS NOT NULL THEN 1 ELSE 0 END)
      comment: "Count of closed irregularity cases"
    - name: "dot_reportable_count"
      expr: SUM(CASE WHEN dot_reportable_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of DOT-reportable irregularities - regulatory compliance metric"
    - name: "unique_passengers_affected"
      expr: COUNT(DISTINCT profile_id)
      comment: "Number of unique passengers impacted by irregularities"
$$;


CREATE OR REPLACE VIEW `airlines_ecm`.`_metrics`.`airport_deicing_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Deicing operations cost, efficiency, and safety metrics for winter operations management"
  source: "`airlines_ecm`.`airport`.`deicing_event`"
  dimensions:
    - name: "treatment_date"
      expr: DATE_TRUNC('day', treatment_start_timestamp)
      comment: "Date of deicing treatment"
    - name: "treatment_month"
      expr: DATE_TRUNC('month', treatment_start_timestamp)
      comment: "Month of deicing for seasonal analysis"
    - name: "treatment_type"
      expr: treatment_type
      comment: "Type of deicing treatment applied"
    - name: "treatment_status"
      expr: treatment_status
      comment: "Status of deicing treatment"
    - name: "treatment_reason"
      expr: treatment_reason_code
      comment: "Reason code for deicing treatment"
    - name: "deicing_location_type"
      expr: deicing_location_type
      comment: "Location where deicing was performed (gate, pad, remote)"
    - name: "fluid_type_primary"
      expr: fluid_type_primary
      comment: "Primary deicing fluid type used"
    - name: "precipitation_type"
      expr: precipitation_type
      comment: "Type of precipitation requiring deicing"
    - name: "environmental_reporting_required"
      expr: environmental_reporting_flag
      comment: "Whether environmental reporting is required"
  measures:
    - name: "deicing_event_count"
      expr: COUNT(1)
      comment: "Total number of deicing events - operational volume indicator"
    - name: "total_fluid_cost"
      expr: SUM(CAST(fluid_cost_total_amount AS DOUBLE))
      comment: "Total cost of deicing fluid - primary cost driver for winter ops"
    - name: "avg_fluid_cost_per_event"
      expr: AVG(CAST(fluid_cost_total_amount AS DOUBLE))
      comment: "Average fluid cost per deicing event"
    - name: "total_service_charge"
      expr: SUM(CAST(service_charge_amount AS DOUBLE))
      comment: "Total service charges for deicing operations"
    - name: "total_primary_fluid_volume_liters"
      expr: SUM(CAST(fluid_volume_primary_liters AS DOUBLE))
      comment: "Total volume of primary deicing fluid used"
    - name: "avg_primary_fluid_volume_liters"
      expr: AVG(CAST(fluid_volume_primary_liters AS DOUBLE))
      comment: "Average primary fluid volume per event"
    - name: "total_secondary_fluid_volume_liters"
      expr: SUM(CAST(fluid_volume_secondary_liters AS DOUBLE))
      comment: "Total volume of secondary (anti-ice) fluid used"
    - name: "avg_treatment_duration_minutes"
      expr: AVG(CAST(treatment_duration_minutes AS DOUBLE))
      comment: "Average treatment duration - efficiency metric"
    - name: "total_treatment_duration_minutes"
      expr: SUM(CAST(treatment_duration_minutes AS DOUBLE))
      comment: "Total treatment time across all events"
    - name: "avg_outside_air_temp_celsius"
      expr: AVG(CAST(outside_air_temperature_celsius AS DOUBLE))
      comment: "Average outside air temperature during deicing"
    - name: "avg_primary_fluid_concentration_pct"
      expr: AVG(CAST(fluid_concentration_primary_percent AS DOUBLE))
      comment: "Average concentration of primary fluid"
    - name: "unique_aircraft_deiced"
      expr: COUNT(DISTINCT aircraft_id)
      comment: "Number of unique aircraft requiring deicing"
    - name: "unique_flights_deiced"
      expr: COUNT(DISTINCT flight_leg_id)
      comment: "Number of unique flights requiring deicing"
    - name: "environmental_reporting_count"
      expr: SUM(CASE WHEN environmental_reporting_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of events requiring environmental reporting"
$$;


CREATE OR REPLACE VIEW `airlines_ecm`.`_metrics`.`airport_gate_assignment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Gate utilization, assignment efficiency, and conflict management metrics for airport capacity optimization"
  source: "`airlines_ecm`.`airport`.`gate_assignment`"
  dimensions:
    - name: "assignment_date"
      expr: DATE_TRUNC('day', assignment_timestamp)
      comment: "Date of gate assignment"
    - name: "assignment_month"
      expr: DATE_TRUNC('month', assignment_timestamp)
      comment: "Month of assignment for capacity planning"
    - name: "assignment_status"
      expr: assignment_status
      comment: "Status of gate assignment (confirmed, tentative, cancelled)"
    - name: "assignment_source"
      expr: assignment_source
      comment: "Source system or process that created assignment"
    - name: "gate_type"
      expr: gate_type
      comment: "Type of gate assigned"
    - name: "aircraft_size_category"
      expr: aircraft_size_category
      comment: "Size category of aircraft for capacity analysis"
    - name: "domestic_international"
      expr: domestic_international_flag
      comment: "Domestic or international flight indicator"
    - name: "hub_spoke_indicator"
      expr: hub_spoke_indicator
      comment: "Hub or spoke operation indicator"
    - name: "conflict_flag"
      expr: conflict_flag
      comment: "Whether assignment had conflicts"
    - name: "priority_override"
      expr: priority_override_flag
      comment: "Whether priority override was applied"
    - name: "cdm_milestone_status"
      expr: cdm_milestone_status
      comment: "CDM milestone compliance status"
  measures:
    - name: "assignment_count"
      expr: COUNT(1)
      comment: "Total number of gate assignments"
    - name: "avg_turnaround_duration_minutes"
      expr: AVG(CAST(turnaround_duration_minutes AS DOUBLE))
      comment: "Average turnaround duration at gate - utilization efficiency KPI"
    - name: "total_turnaround_duration_minutes"
      expr: SUM(CAST(turnaround_duration_minutes AS DOUBLE))
      comment: "Total gate occupancy time"
    - name: "conflict_count"
      expr: SUM(CASE WHEN conflict_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of assignments with conflicts - operational quality metric"
    - name: "priority_override_count"
      expr: SUM(CASE WHEN priority_override_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of priority overrides - exception management metric"
    - name: "jetbridge_available_count"
      expr: SUM(CASE WHEN jet_bridge_available_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of assignments with jetbridge availability"
    - name: "ground_power_available_count"
      expr: SUM(CASE WHEN ground_power_available_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of assignments with ground power"
    - name: "preconditioned_air_available_count"
      expr: SUM(CASE WHEN preconditioned_air_available_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of assignments with preconditioned air"
    - name: "slot_coordination_required_count"
      expr: SUM(CASE WHEN slot_coordination_required_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of assignments requiring slot coordination"
    - name: "unique_gates_used"
      expr: COUNT(DISTINCT gate_id)
      comment: "Number of unique gates utilized"
    - name: "unique_aircraft_assigned"
      expr: COUNT(DISTINCT aircraft_id)
      comment: "Number of unique aircraft assigned to gates"
    - name: "unique_flights_assigned"
      expr: COUNT(DISTINCT flight_leg_id)
      comment: "Number of unique flights assigned"
$$;


CREATE OR REPLACE VIEW `airlines_ecm`.`_metrics`.`airport_handling_performance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Ground handler SLA compliance, quality, and cost performance metrics for vendor management"
  source: "`airlines_ecm`.`airport`.`handling_performance`"
  dimensions:
    - name: "measurement_date"
      expr: DATE_TRUNC('day', measurement_period_start)
      comment: "Date of performance measurement"
    - name: "measurement_month"
      expr: DATE_TRUNC('month', measurement_period_start)
      comment: "Month of performance measurement"
    - name: "turnaround_completion_status"
      expr: turnaround_completion_status
      comment: "Status of turnaround completion"
    - name: "sla_breach"
      expr: sla_breach_flag
      comment: "Whether SLA was breached"
    - name: "sla_breach_category"
      expr: sla_breach_category
      comment: "Category of SLA breach"
    - name: "penalty_triggered"
      expr: penalty_trigger_flag
      comment: "Whether penalty was triggered"
    - name: "safety_incident"
      expr: safety_incident_flag
      comment: "Whether safety incident occurred"
    - name: "safety_incident_severity"
      expr: safety_incident_severity
      comment: "Severity of safety incident"
    - name: "on_time_departure_contribution"
      expr: on_time_departure_contribution_flag
      comment: "Whether handler contributed to on-time departure"
    - name: "cdm_milestone_compliance"
      expr: cdm_milestone_compliance_flag
      comment: "CDM milestone compliance indicator"
  measures:
    - name: "performance_record_count"
      expr: COUNT(1)
      comment: "Total number of performance records"
    - name: "avg_performance_score"
      expr: AVG(CAST(performance_score AS DOUBLE))
      comment: "Average handler performance score - primary vendor quality KPI"
    - name: "avg_baggage_delivery_time_minutes"
      expr: AVG(CAST(baggage_delivery_time_minutes AS DOUBLE))
      comment: "Average baggage delivery time - customer service metric"
    - name: "avg_baggage_delivery_target_minutes"
      expr: AVG(CAST(baggage_delivery_target_minutes AS DOUBLE))
      comment: "Average baggage delivery target time"
    - name: "total_damage_incidents"
      expr: SUM(CAST(damage_incident_count AS DOUBLE))
      comment: "Total damage incidents - safety and quality metric"
    - name: "avg_damage_rate_per_turnaround"
      expr: AVG(CAST(damage_rate_per_turnaround AS DOUBLE))
      comment: "Average damage rate per turnaround"
    - name: "total_mishandled_baggage"
      expr: SUM(CAST(mishandled_baggage_count AS DOUBLE))
      comment: "Total mishandled baggage count"
    - name: "total_no_show_bags"
      expr: SUM(CAST(no_show_bag_count AS DOUBLE))
      comment: "Total no-show bag count"
    - name: "total_delay_minutes_attributed"
      expr: SUM(CAST(delay_minutes_attributed AS DOUBLE))
      comment: "Total delay minutes attributed to handler"
    - name: "total_penalty_amount"
      expr: SUM(CAST(penalty_amount AS DOUBLE))
      comment: "Total penalty amount assessed - financial impact metric"
    - name: "avg_penalty_amount"
      expr: AVG(CAST(penalty_amount AS DOUBLE))
      comment: "Average penalty per breach"
    - name: "sla_breach_count"
      expr: SUM(CASE WHEN sla_breach_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of SLA breaches - contract compliance metric"
    - name: "penalty_triggered_count"
      expr: SUM(CASE WHEN penalty_trigger_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of penalties triggered"
    - name: "safety_incident_count"
      expr: SUM(CASE WHEN safety_incident_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of safety incidents - critical safety KPI"
    - name: "on_time_contribution_count"
      expr: SUM(CASE WHEN on_time_departure_contribution_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of on-time departure contributions"
    - name: "cdm_compliant_count"
      expr: SUM(CASE WHEN cdm_milestone_compliance_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of CDM-compliant operations"
    - name: "unique_handlers_measured"
      expr: COUNT(DISTINCT ground_handler_id)
      comment: "Number of unique handlers measured"
    - name: "unique_flights_measured"
      expr: COUNT(DISTINCT flight_leg_id)
      comment: "Number of unique flights measured"
$$;


CREATE OR REPLACE VIEW `airlines_ecm`.`_metrics`.`airport_slot_utilization`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Airport slot compliance, utilization efficiency, and regulatory reporting metrics for capacity management"
  source: "`airlines_ecm`.`airport`.`slot_utilization`"
  dimensions:
    - name: "operated_date"
      expr: operated_date
      comment: "Date slot was operated"
    - name: "operated_month"
      expr: DATE_TRUNC('month', operated_date)
      comment: "Month of slot operation"
    - name: "compliance_status"
      expr: compliance_status
      comment: "Slot compliance status"
    - name: "non_compliance_reason"
      expr: non_compliance_reason_code
      comment: "Reason code for non-compliance"
    - name: "season_code"
      expr: season_code
      comment: "IATA season code"
    - name: "slot_coordinator"
      expr: slot_coordinator_code
      comment: "Slot coordinator authority code"
    - name: "slot_series_indicator"
      expr: slot_series_indicator
      comment: "Whether slot is part of a series"
    - name: "historic_rights_protected"
      expr: historic_rights_protected_flag
      comment: "Whether historic rights were protected"
    - name: "regulatory_reporting_required"
      expr: regulatory_reporting_flag
      comment: "Whether regulatory reporting is required"
  measures:
    - name: "slot_utilization_count"
      expr: COUNT(1)
      comment: "Total number of slot utilization records"
    - name: "avg_arrival_variance_minutes"
      expr: AVG(CAST(arrival_variance_minutes AS DOUBLE))
      comment: "Average arrival time variance from slot - compliance metric"
    - name: "avg_departure_variance_minutes"
      expr: AVG(CAST(departure_variance_minutes AS DOUBLE))
      comment: "Average departure time variance from slot - compliance metric"
    - name: "compliant_slot_count"
      expr: SUM(CASE WHEN compliance_status = 'COMPLIANT' THEN 1 ELSE 0 END)
      comment: "Count of compliant slot operations"
    - name: "non_compliant_slot_count"
      expr: SUM(CASE WHEN compliance_status = 'NON_COMPLIANT' THEN 1 ELSE 0 END)
      comment: "Count of non-compliant slot operations - regulatory risk metric"
    - name: "historic_rights_protected_count"
      expr: SUM(CASE WHEN historic_rights_protected_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of slots with historic rights protection"
    - name: "regulatory_reporting_count"
      expr: SUM(CASE WHEN regulatory_reporting_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of slots requiring regulatory reporting"
    - name: "unique_slots_utilized"
      expr: COUNT(DISTINCT slot_id)
      comment: "Number of unique slots utilized"
    - name: "unique_flights_operated"
      expr: COUNT(DISTINCT flight_leg_id)
      comment: "Number of unique flights operated"
    - name: "unique_stations"
      expr: COUNT(DISTINCT station_id)
      comment: "Number of unique stations with slot operations"
$$;


CREATE OR REPLACE VIEW `airlines_ecm`.`_metrics`.`airport_boarding_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Passenger boarding efficiency, rejection analysis, and operational quality metrics for departure performance"
  source: "`airlines_ecm`.`airport`.`boarding_event`"
  dimensions:
    - name: "scan_date"
      expr: DATE_TRUNC('day', scan_timestamp)
      comment: "Date of boarding scan"
    - name: "scan_month"
      expr: DATE_TRUNC('month', scan_timestamp)
      comment: "Month of boarding for trend analysis"
    - name: "boarding_method"
      expr: boarding_method
      comment: "Method of boarding (zone, group, open)"
    - name: "boarding_zone"
      expr: boarding_zone
      comment: "Boarding zone assigned"
    - name: "cabin_class"
      expr: cabin_class
      comment: "Cabin class of passenger"
    - name: "passenger_type"
      expr: passenger_type_code
      comment: "Type of passenger (adult, child, infant)"
    - name: "scan_result_status"
      expr: scan_result_status
      comment: "Result of boarding pass scan"
    - name: "rejection_reason"
      expr: rejection_reason_code
      comment: "Reason code for boarding rejection"
    - name: "irregular_operation"
      expr: irregular_operation_flag
      comment: "Whether boarding was during irregular operations"
    - name: "is_standby_passenger"
      expr: is_standby_passenger
      comment: "Whether passenger was standby"
    - name: "is_upgrade_passenger"
      expr: is_upgrade_passenger
      comment: "Whether passenger was upgraded"
    - name: "security_screening_status"
      expr: security_screening_status
      comment: "Security screening status"
  measures:
    - name: "boarding_event_count"
      expr: COUNT(1)
      comment: "Total number of boarding events"
    - name: "successful_boarding_count"
      expr: SUM(CASE WHEN scan_result_status = 'ACCEPTED' THEN 1 ELSE 0 END)
      comment: "Count of successful boardings"
    - name: "rejected_boarding_count"
      expr: SUM(CASE WHEN scan_result_status = 'REJECTED' THEN 1 ELSE 0 END)
      comment: "Count of rejected boardings - operational quality metric"
    - name: "total_carry_on_bags"
      expr: SUM(CAST(carry_on_baggage_count AS DOUBLE))
      comment: "Total carry-on baggage count"
    - name: "avg_carry_on_bags_per_passenger"
      expr: AVG(CAST(carry_on_baggage_count AS DOUBLE))
      comment: "Average carry-on bags per passenger"
    - name: "total_checked_bags"
      expr: SUM(CAST(checked_baggage_count AS DOUBLE))
      comment: "Total checked baggage count"
    - name: "standby_passenger_count"
      expr: SUM(CASE WHEN is_standby_passenger = TRUE THEN 1 ELSE 0 END)
      comment: "Count of standby passengers boarded"
    - name: "upgrade_passenger_count"
      expr: SUM(CASE WHEN is_upgrade_passenger = TRUE THEN 1 ELSE 0 END)
      comment: "Count of upgraded passengers"
    - name: "irregular_operation_count"
      expr: SUM(CASE WHEN irregular_operation_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of boardings during irregular operations"
    - name: "codeshare_passenger_count"
      expr: SUM(CASE WHEN is_codeshare_passenger = TRUE THEN 1 ELSE 0 END)
      comment: "Count of codeshare passengers"
    - name: "interline_passenger_count"
      expr: SUM(CASE WHEN is_interline_passenger = TRUE THEN 1 ELSE 0 END)
      comment: "Count of interline passengers"
    - name: "unique_passengers_boarded"
      expr: COUNT(DISTINCT profile_id)
      comment: "Number of unique passengers boarded"
    - name: "unique_flights_boarded"
      expr: COUNT(DISTINCT flight_leg_id)
      comment: "Number of unique flights with boarding activity"
    - name: "unique_gates_used"
      expr: COUNT(DISTINCT gate_assignment_id)
      comment: "Number of unique gates used for boarding"
$$;
