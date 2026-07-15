-- Metric views for domain: airport | Business: Airlines | Version: 1 | Generated on: 2026-05-07 15:08:57

CREATE OR REPLACE VIEW `airlines_ecm`.`_metrics`.`airport_baggage_irregularity`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tracks baggage mishandling performance including compensation costs, liability exposure, and DOT-reportable incidents. Used by Ground Operations and Customer Experience leadership to monitor baggage quality, regulatory risk, and financial impact of irregularities."
  source: "`airlines_ecm`.`airport`.`baggage_irregularity`"
  dimensions:
    - name: "irregularity_type_code"
      expr: irregularity_type_code
      comment: "Classification code for the type of baggage irregularity (e.g. delayed, damaged, pilfered). Enables breakdown of mishandling root causes."
    - name: "irregularity_type_description"
      expr: irregularity_type_description
      comment: "Human-readable description of the irregularity type for reporting and dashboards."
    - name: "responsible_carrier_code"
      expr: responsible_carrier_code
      comment: "IATA code of the carrier deemed responsible for the irregularity. Supports interline liability attribution and partner performance reviews."
    - name: "handling_carrier_code"
      expr: handling_carrier_code
      comment: "IATA code of the carrier that physically handled the bag at the point of irregularity. Used to distinguish operational vs. contractual responsibility."
    - name: "station_id"
      expr: station_id
      comment: "Station where the irregularity was reported. Enables geographic hotspot analysis of baggage mishandling."
    - name: "destination_station_code"
      expr: destination_station_code
      comment: "Intended destination station for the bag. Supports route-level mishandling analysis."
    - name: "recovery_status_code"
      expr: recovery_status_code
      comment: "Current recovery status of the irregularity (e.g. located, delivered, unresolved). Tracks resolution pipeline health."
    - name: "dot_reportable_flag"
      expr: dot_reportable_flag
      comment: "Indicates whether the irregularity must be reported to the DOT. Critical for regulatory compliance monitoring."
    - name: "regulatory_reporting_flag"
      expr: regulatory_reporting_flag
      comment: "Indicates whether the irregularity is subject to any regulatory reporting obligation beyond DOT."
    - name: "flight_date"
      expr: DATE_TRUNC('month', flight_date)
      comment: "Month of the flight associated with the irregularity. Enables trend analysis over time."
    - name: "bag_type"
      expr: bag_type
      comment: "Type of bag involved in the irregularity (e.g. checked, oversized). Supports segmentation by bag category."
    - name: "compensation_currency_code"
      expr: compensation_currency_code
      comment: "Currency in which compensation was paid. Required for multi-currency financial reporting."
  measures:
    - name: "total_irregularity_count"
      expr: COUNT(1)
      comment: "Total number of baggage irregularity events. Primary volume KPI for mishandling rate benchmarking against IATA targets."
    - name: "total_compensation_amount"
      expr: SUM(CAST(compensation_amount AS DOUBLE))
      comment: "Total compensation paid to passengers for baggage irregularities. Direct financial cost KPI used by Finance and Operations leadership to quantify mishandling liability."
    - name: "avg_compensation_per_irregularity"
      expr: AVG(CAST(compensation_amount AS DOUBLE))
      comment: "Average compensation paid per baggage irregularity event. Tracks severity trend and informs compensation policy calibration."
    - name: "total_liability_amount"
      expr: SUM(CAST(liability_amount AS DOUBLE))
      comment: "Total declared liability exposure across all irregularities. Used by Finance and Legal to assess maximum financial risk from open mishandling cases."
    - name: "total_interim_expense_amount"
      expr: SUM(CAST(interim_expense_amount AS DOUBLE))
      comment: "Total interim expenses reimbursed to passengers while bags are missing. Operational cost KPI for customer care spend on baggage recovery."
    - name: "dot_reportable_irregularity_count"
      expr: COUNT(CASE WHEN dot_reportable_flag = TRUE THEN 1 END)
      comment: "Number of irregularities that are DOT-reportable. Regulatory compliance KPI — elevated counts trigger mandatory disclosure and potential fines."
    - name: "unresolved_irregularity_count"
      expr: COUNT(CASE WHEN recovery_status_code NOT IN ('DELIVERED', 'CLOSED', 'RESOLVED') THEN 1 END)
      comment: "Number of irregularities not yet resolved. Operational backlog KPI used by Ground Operations to prioritize recovery efforts and manage customer escalations."
    - name: "avg_declared_value_per_irregularity"
      expr: AVG(CAST(declared_value_amount AS DOUBLE))
      comment: "Average declared value of bags involved in irregularities. Informs risk exposure per incident and guides insurance and liability policy decisions."
$$;


CREATE OR REPLACE VIEW `airlines_ecm`.`_metrics`.`airport_baggage_item`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Measures baggage handling throughput, excess charge revenue, weight metrics, and mishandling rates at the individual bag level. Used by Airport Operations, Revenue Management, and Ground Services to optimize baggage handling efficiency and ancillary revenue."
  source: "`airlines_ecm`.`airport`.`baggage_item`"
  dimensions:
    - name: "bag_type"
      expr: bag_type
      comment: "Type of baggage item (e.g. checked, oversized, fragile). Enables segmentation of handling metrics by bag category."
    - name: "current_status"
      expr: current_status
      comment: "Current tracking status of the bag (e.g. checked-in, loaded, delivered). Supports pipeline health monitoring."
    - name: "final_destination_station_code"
      expr: final_destination_station_code
      comment: "Final destination station for the bag. Enables route-level baggage volume and revenue analysis."
    - name: "security_screening_status"
      expr: security_screening_status
      comment: "Security screening outcome for the bag. Supports compliance and safety reporting."
    - name: "priority_handling_code"
      expr: priority_handling_code
      comment: "Priority handling designation (e.g. rush, fragile, diplomatic). Used to track premium service delivery rates."
    - name: "interline_indicator"
      expr: interline_indicator
      comment: "Indicates whether the bag is travelling on an interline itinerary. Supports interline mishandling attribution and partner billing."
    - name: "mishandling_code"
      expr: mishandling_code
      comment: "Code indicating the type of mishandling event if applicable. Enables root-cause analysis of baggage failures."
    - name: "excess_baggage_charge_currency"
      expr: excess_baggage_charge_currency
      comment: "Currency of the excess baggage charge. Required for multi-currency ancillary revenue reporting."
    - name: "acceptance_timestamp_month"
      expr: DATE_TRUNC('month', acceptance_timestamp)
      comment: "Month of bag acceptance. Enables trend analysis of baggage volumes and revenue over time."
  measures:
    - name: "total_bags_checked"
      expr: COUNT(1)
      comment: "Total number of baggage items processed. Primary throughput KPI for ground handling capacity planning and IATA benchmarking."
    - name: "total_excess_baggage_revenue"
      expr: SUM(CAST(excess_baggage_charge_amount AS DOUBLE))
      comment: "Total ancillary revenue collected from excess baggage charges. Key revenue KPI for Ancillary Revenue and Airport Operations leadership."
    - name: "avg_excess_baggage_charge"
      expr: AVG(CAST(excess_baggage_charge_amount AS DOUBLE))
      comment: "Average excess baggage charge per bag. Informs pricing strategy and yield optimization for baggage ancillary products."
    - name: "total_baggage_weight_kg"
      expr: SUM(CAST(weight_kg AS DOUBLE))
      comment: "Total weight of all baggage items in kilograms. Used by Operations and Flight Planning for load planning and fuel cost attribution."
    - name: "avg_bag_weight_kg"
      expr: AVG(CAST(weight_kg AS DOUBLE))
      comment: "Average weight per baggage item. Supports load planning benchmarks and excess baggage policy calibration."
    - name: "mishandled_bag_count"
      expr: COUNT(CASE WHEN mishandling_code IS NOT NULL AND mishandling_code <> '' THEN 1 END)
      comment: "Number of bags with a recorded mishandling code. Operational quality KPI used to track mishandling rate against IATA Resolution 753 targets."
    - name: "interline_bag_count"
      expr: COUNT(CASE WHEN interline_indicator = TRUE THEN 1 END)
      comment: "Number of interline baggage items. Supports interline partner performance reviews and prorated liability calculations."
    - name: "avg_declared_value_amount"
      expr: AVG(CAST(declared_value_amount AS DOUBLE))
      comment: "Average declared value per bag. Informs liability exposure per bag and guides insurance policy adequacy reviews."
$$;


CREATE OR REPLACE VIEW `airlines_ecm`.`_metrics`.`airport_baggage_scan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Monitors IATA Resolution 753 baggage tracking compliance, scan exception rates, and sortation quality across all scan points. Used by Ground Operations and Compliance teams to ensure end-to-end bag traceability and regulatory adherence."
  source: "`airlines_ecm`.`airport`.`baggage_scan`"
  dimensions:
    - name: "scan_point_type"
      expr: scan_point_type
      comment: "Type of scan point in the baggage journey (e.g. check-in, loading, transfer, delivery). Enables stage-level compliance analysis."
    - name: "scan_result_status"
      expr: scan_result_status
      comment: "Outcome of the scan event (e.g. success, exception, no-read). Tracks scan quality and equipment performance."
    - name: "origin_airport_code"
      expr: origin_airport_code
      comment: "Origin airport for the bag's flight. Enables station-level compliance benchmarking."
    - name: "destination_airport_code"
      expr: destination_airport_code
      comment: "Destination airport for the bag's flight. Supports route-level tracking compliance analysis."
    - name: "security_screening_status"
      expr: security_screening_status
      comment: "Security screening outcome at the scan point. Supports safety and regulatory compliance reporting."
    - name: "sortation_decision"
      expr: sortation_decision
      comment: "Automated sortation decision made at this scan point. Enables analysis of sortation accuracy and exception rates."
    - name: "transfer_connection_flag"
      expr: transfer_connection_flag
      comment: "Indicates whether the bag is on a transfer connection. Supports minimum connect time compliance and transfer mishandling analysis."
    - name: "iata_753_compliance_flag"
      expr: iata_753_compliance_flag
      comment: "Indicates whether this scan event is compliant with IATA Resolution 753 tracking requirements. Primary regulatory compliance dimension."
    - name: "flight_date_month"
      expr: DATE_TRUNC('month', flight_date)
      comment: "Month of the flight associated with the scan. Enables monthly compliance trend reporting."
    - name: "scan_device_code"
      expr: scan_device_code
      comment: "Identifier of the scanning device. Supports equipment performance and maintenance prioritization."
  measures:
    - name: "total_scan_events"
      expr: COUNT(1)
      comment: "Total number of baggage scan events. Primary throughput KPI for baggage tracking system activity and IATA 753 coverage assessment."
    - name: "iata_753_compliant_scan_count"
      expr: COUNT(CASE WHEN iata_753_compliance_flag = TRUE THEN 1 END)
      comment: "Number of scan events compliant with IATA Resolution 753. Regulatory KPI — airlines must achieve near-100% compliance to avoid IATA sanctions."
    - name: "iata_753_non_compliant_scan_count"
      expr: COUNT(CASE WHEN iata_753_compliance_flag = FALSE THEN 1 END)
      comment: "Number of scan events non-compliant with IATA Resolution 753. Compliance gap KPI used to prioritize remediation at specific stations or scan points."
    - name: "exception_scan_count"
      expr: COUNT(CASE WHEN exception_flag = TRUE THEN 1 END)
      comment: "Number of scan events flagged as exceptions. Operational quality KPI — high exception rates indicate equipment failures or process breakdowns requiring intervention."
    - name: "transfer_connection_scan_count"
      expr: COUNT(CASE WHEN transfer_connection_flag = TRUE THEN 1 END)
      comment: "Number of scan events for transfer-connection bags. Supports minimum connect time compliance monitoring and transfer mishandling risk assessment."
    - name: "total_baggage_weight_scanned_kg"
      expr: SUM(CAST(baggage_weight_kg AS DOUBLE))
      comment: "Total weight of baggage processed through scan points. Supports load planning validation and ground handling capacity analysis."
    - name: "distinct_bags_tracked"
      expr: COUNT(DISTINCT baggage_item_id)
      comment: "Number of unique bags tracked via scan events. Measures end-to-end traceability coverage — a core IATA 753 compliance KPI."
$$;


CREATE OR REPLACE VIEW `airlines_ecm`.`_metrics`.`airport_boarding_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tracks gate boarding performance including upgrade activity, irregular operations, standby clearance, and special passenger handling. Used by Airport Operations and Customer Experience leadership to monitor boarding efficiency, gate agent productivity, and premium service delivery."
  source: "`airlines_ecm`.`airport`.`boarding_event`"
  dimensions:
    - name: "boarding_method"
      expr: boarding_method
      comment: "Method used for boarding (e.g. jet bridge, bus, remote). Enables analysis of boarding efficiency by infrastructure type."
    - name: "boarding_zone"
      expr: boarding_zone
      comment: "Boarding zone assigned to the passenger. Supports zone-based boarding process optimization."
    - name: "passenger_type_code"
      expr: passenger_type_code
      comment: "Type of passenger (e.g. adult, infant, unaccompanied minor). Enables segmentation of boarding metrics by passenger category."
    - name: "operating_carrier_code"
      expr: operating_carrier_code
      comment: "IATA code of the operating carrier. Supports codeshare and interline boarding performance attribution."
    - name: "marketing_carrier_code"
      expr: marketing_carrier_code
      comment: "IATA code of the marketing carrier. Enables commercial partner performance analysis."
    - name: "is_upgrade_passenger"
      expr: is_upgrade_passenger
      comment: "Indicates whether the passenger received an upgrade at the gate. Tracks upgrade clearance rates and premium cabin utilization."
    - name: "is_standby_passenger"
      expr: is_standby_passenger
      comment: "Indicates whether the passenger was on standby. Supports standby clearance rate analysis and capacity management."
    - name: "is_codeshare_passenger"
      expr: is_codeshare_passenger
      comment: "Indicates whether the passenger is travelling on a codeshare booking. Supports interline/codeshare operational performance reviews."
    - name: "irregular_operation_flag"
      expr: irregular_operation_flag
      comment: "Indicates whether the boarding event was affected by an irregular operation (IRROP). Enables IRROP impact quantification on boarding."
    - name: "scan_result_status"
      expr: scan_result_status
      comment: "Result of the boarding pass scan (e.g. accepted, rejected, duplicate). Tracks gate reader accuracy and boarding integrity."
    - name: "scan_timestamp_month"
      expr: DATE_TRUNC('month', scan_timestamp)
      comment: "Month of the boarding scan. Enables monthly trend analysis of boarding volumes and exception rates."
    - name: "security_screening_status"
      expr: security_screening_status
      comment: "Security screening status of the passenger at boarding. Supports security compliance reporting."
  measures:
    - name: "total_boarding_events"
      expr: COUNT(1)
      comment: "Total number of boarding events processed. Primary throughput KPI for gate operations capacity planning and staffing."
    - name: "upgrade_boarding_count"
      expr: COUNT(CASE WHEN is_upgrade_passenger = TRUE THEN 1 END)
      comment: "Number of passengers boarded as upgrades. Revenue and loyalty KPI — tracks gate upgrade clearance volume and premium cabin fill rates."
    - name: "standby_cleared_count"
      expr: COUNT(CASE WHEN is_standby_passenger = TRUE AND scan_result_status = 'ACCEPTED' THEN 1 END)
      comment: "Number of standby passengers successfully cleared for boarding. Capacity utilization KPI — measures effectiveness of last-seat revenue recovery."
    - name: "rejected_boarding_count"
      expr: COUNT(CASE WHEN scan_result_status = 'REJECTED' THEN 1 END)
      comment: "Number of boarding attempts rejected at the gate. Operational quality KPI — high rejection rates indicate check-in errors, document issues, or overbooking impacts."
    - name: "irregular_operation_boarding_count"
      expr: COUNT(CASE WHEN irregular_operation_flag = TRUE THEN 1 END)
      comment: "Number of boarding events affected by irregular operations. IRROP impact KPI used by Operations Control to quantify disruption scope at the gate."
    - name: "codeshare_passenger_boarding_count"
      expr: COUNT(CASE WHEN is_codeshare_passenger = TRUE THEN 1 END)
      comment: "Number of codeshare passengers boarded. Supports interline/codeshare partner SLA compliance and revenue proration analysis."
    - name: "distinct_flights_boarded"
      expr: COUNT(DISTINCT flight_leg_id)
      comment: "Number of distinct flight legs with boarding activity. Supports gate utilization and boarding process coverage analysis."
$$;


CREATE OR REPLACE VIEW `airlines_ecm`.`_metrics`.`airport_checkin_session`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Measures check-in throughput, channel mix, excess baggage revenue, and service quality across all check-in touchpoints. Used by Airport Operations, Revenue Management, and Digital teams to optimize check-in channel strategy and ancillary revenue capture."
  source: "`airlines_ecm`.`airport`.`checkin_session`"
  dimensions:
    - name: "checkin_channel"
      expr: checkin_channel
      comment: "Channel through which check-in was performed (e.g. web, mobile, kiosk, counter). Primary dimension for channel mix and digital adoption analysis."
    - name: "checkin_status"
      expr: checkin_status
      comment: "Final status of the check-in session (e.g. completed, abandoned, failed). Enables funnel analysis and drop-off identification."
    - name: "excess_baggage_flag"
      expr: excess_baggage_flag
      comment: "Indicates whether excess baggage was charged in this session. Supports excess baggage revenue attribution by channel."
    - name: "advance_checkin_flag"
      expr: advance_checkin_flag
      comment: "Indicates whether check-in was completed in advance (online/mobile). Tracks advance check-in adoption rates."
    - name: "priority_boarding_flag"
      expr: priority_boarding_flag
      comment: "Indicates whether priority boarding was assigned. Tracks premium service delivery rates at check-in."
    - name: "upgrade_processed_flag"
      expr: upgrade_processed_flag
      comment: "Indicates whether an upgrade was processed during check-in. Supports upgrade revenue attribution and loyalty benefit delivery tracking."
    - name: "group_checkin_flag"
      expr: group_checkin_flag
      comment: "Indicates whether this was a group check-in session. Enables group handling performance analysis."
    - name: "travel_document_verified_flag"
      expr: travel_document_verified_flag
      comment: "Indicates whether travel documents were verified during check-in. Supports APIS compliance and security process monitoring."
    - name: "checkin_start_month"
      expr: DATE_TRUNC('month', checkin_start_timestamp)
      comment: "Month of check-in session start. Enables monthly trend analysis of check-in volumes and channel mix."
    - name: "excess_baggage_charge_currency"
      expr: excess_baggage_charge_currency
      comment: "Currency of excess baggage charges collected. Required for multi-currency ancillary revenue reporting."
    - name: "boarding_pass_issuance_method"
      expr: boarding_pass_issuance_method
      comment: "Method by which the boarding pass was issued (e.g. print, mobile, kiosk). Tracks digital boarding pass adoption."
  measures:
    - name: "total_checkin_sessions"
      expr: COUNT(1)
      comment: "Total number of check-in sessions initiated. Primary throughput KPI for check-in capacity planning and staffing optimization."
    - name: "completed_checkin_count"
      expr: COUNT(CASE WHEN checkin_status = 'COMPLETED' THEN 1 END)
      comment: "Number of successfully completed check-in sessions. Conversion KPI — measures check-in funnel effectiveness across all channels."
    - name: "total_excess_baggage_revenue"
      expr: SUM(CAST(excess_baggage_charge_amount AS DOUBLE))
      comment: "Total excess baggage ancillary revenue collected at check-in. Key revenue KPI for Ancillary Revenue and Airport Operations leadership."
    - name: "avg_excess_baggage_charge"
      expr: AVG(CAST(excess_baggage_charge_amount AS DOUBLE))
      comment: "Average excess baggage charge per session. Informs pricing strategy and yield optimization for baggage ancillary products."
    - name: "excess_baggage_session_count"
      expr: COUNT(CASE WHEN excess_baggage_flag = TRUE THEN 1 END)
      comment: "Number of check-in sessions where excess baggage was charged. Supports excess baggage revenue penetration rate analysis."
    - name: "upgrade_processed_count"
      expr: COUNT(CASE WHEN upgrade_processed_flag = TRUE THEN 1 END)
      comment: "Number of check-in sessions where an upgrade was processed. Tracks upgrade revenue capture and loyalty benefit delivery at check-in."
    - name: "advance_checkin_count"
      expr: COUNT(CASE WHEN advance_checkin_flag = TRUE THEN 1 END)
      comment: "Number of advance (pre-airport) check-in sessions. Digital adoption KPI — higher advance check-in rates reduce airport counter costs."
    - name: "distinct_passengers_checked_in"
      expr: COUNT(DISTINCT profile_id)
      comment: "Number of unique passengers who completed check-in. Supports passenger flow planning and check-in resource allocation."
$$;


CREATE OR REPLACE VIEW `airlines_ecm`.`_metrics`.`airport_deicing_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tracks de-icing operations including fluid consumption, treatment costs, holdover compliance, and environmental reporting. Used by Safety, Operations, and Finance leadership to manage winter operations costs, safety compliance, and environmental obligations."
  source: "`airlines_ecm`.`airport`.`deicing_event`"
  dimensions:
    - name: "treatment_type"
      expr: treatment_type
      comment: "Type of de-icing treatment applied (e.g. Type I, Type IV anti-icing). Enables cost and fluid consumption analysis by treatment category."
    - name: "treatment_status"
      expr: treatment_status
      comment: "Status of the de-icing treatment (e.g. completed, in-progress, cancelled). Tracks treatment completion rates."
    - name: "treatment_reason_code"
      expr: treatment_reason_code
      comment: "Reason code for the de-icing treatment (e.g. frost, snow, freezing rain). Supports weather-driven cost attribution."
    - name: "deicing_vendor_code"
      expr: deicing_vendor_code
      comment: "Code identifying the de-icing service vendor. Enables vendor performance and cost benchmarking."
    - name: "deicing_location_type"
      expr: deicing_location_type
      comment: "Location type where de-icing was performed (e.g. gate, remote pad, runway). Supports operational efficiency analysis by location."
    - name: "fluid_type_primary"
      expr: fluid_type_primary
      comment: "Primary de-icing fluid type used. Enables fluid cost and environmental impact analysis by fluid category."
    - name: "fluid_type_secondary"
      expr: fluid_type_secondary
      comment: "Secondary anti-icing fluid type used. Supports combined fluid consumption and cost analysis."
    - name: "post_treatment_inspection_result"
      expr: post_treatment_inspection_result
      comment: "Result of the post-treatment safety inspection (e.g. clear, re-treatment required). Safety compliance KPI dimension."
    - name: "environmental_reporting_flag"
      expr: environmental_reporting_flag
      comment: "Indicates whether the event requires environmental reporting. Tracks regulatory environmental compliance obligations."
    - name: "precipitation_type"
      expr: precipitation_type
      comment: "Type of precipitation at time of treatment (e.g. snow, freezing rain, frost). Enables weather-condition-based cost and safety analysis."
    - name: "treatment_start_month"
      expr: DATE_TRUNC('month', treatment_start_timestamp)
      comment: "Month of de-icing treatment. Enables seasonal cost and volume trend analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of de-icing service charges. Required for multi-currency cost reporting."
  measures:
    - name: "total_deicing_events"
      expr: COUNT(1)
      comment: "Total number of de-icing events performed. Primary volume KPI for winter operations planning and vendor capacity management."
    - name: "total_fluid_cost_amount"
      expr: SUM(CAST(fluid_cost_total_amount AS DOUBLE))
      comment: "Total cost of de-icing fluids consumed. Key cost KPI for winter operations budget management and vendor contract negotiations."
    - name: "total_service_charge_amount"
      expr: SUM(CAST(service_charge_amount AS DOUBLE))
      comment: "Total service charges billed by de-icing vendors. Used by Finance to track and control winter operations outsourced service costs."
    - name: "avg_service_charge_per_event"
      expr: AVG(CAST(service_charge_amount AS DOUBLE))
      comment: "Average service charge per de-icing event. Benchmarking KPI for vendor cost efficiency and contract performance reviews."
    - name: "total_primary_fluid_volume_liters"
      expr: SUM(CAST(fluid_volume_primary_liters AS DOUBLE))
      comment: "Total volume of primary de-icing fluid consumed in liters. Supports fluid inventory management and environmental impact reporting."
    - name: "total_secondary_fluid_volume_liters"
      expr: SUM(CAST(fluid_volume_secondary_liters AS DOUBLE))
      comment: "Total volume of secondary anti-icing fluid consumed in liters. Supports fluid inventory management and environmental compliance reporting."
    - name: "avg_outside_air_temperature_celsius"
      expr: AVG(CAST(outside_air_temperature_celsius AS DOUBLE))
      comment: "Average outside air temperature during de-icing events. Contextual safety KPI — correlates treatment intensity and fluid selection with temperature conditions."
    - name: "re_treatment_required_count"
      expr: COUNT(CASE WHEN post_treatment_inspection_result = 'RE-TREATMENT REQUIRED' THEN 1 END)
      comment: "Number of de-icing events requiring re-treatment after inspection. Safety quality KPI — high re-treatment rates indicate process or fluid selection issues requiring immediate investigation."
    - name: "environmental_reportable_event_count"
      expr: COUNT(CASE WHEN environmental_reporting_flag = TRUE THEN 1 END)
      comment: "Number of de-icing events subject to environmental reporting. Regulatory compliance KPI for environmental obligation tracking."
$$;


CREATE OR REPLACE VIEW `airlines_ecm`.`_metrics`.`airport_gate_assignment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Measures gate utilization, conflict rates, turnaround duration, and CDM milestone compliance. Used by Airport Operations and Slot Coordination teams to optimize gate allocation, reduce conflicts, and improve on-time departure performance."
  source: "`airlines_ecm`.`airport`.`gate_assignment`"
  dimensions:
    - name: "assignment_status"
      expr: assignment_status
      comment: "Current status of the gate assignment (e.g. confirmed, tentative, cancelled). Tracks assignment pipeline health."
    - name: "gate_type"
      expr: gate_type
      comment: "Type of gate assigned (e.g. contact, remote, cargo). Enables analysis of gate utilization by infrastructure type."
    - name: "airport_iata_code"
      expr: airport_iata_code
      comment: "IATA code of the airport where the gate is located. Enables station-level gate performance benchmarking."
    - name: "domestic_international_flag"
      expr: domestic_international_flag
      comment: "Indicates whether the assignment is for a domestic or international flight. Supports terminal and gate planning by traffic type."
    - name: "hub_spoke_indicator"
      expr: hub_spoke_indicator
      comment: "Indicates whether the flight is a hub or spoke operation. Enables gate allocation strategy analysis by network role."
    - name: "jet_bridge_available_flag"
      expr: jet_bridge_available_flag
      comment: "Indicates whether a jet bridge was available for the assignment. Tracks premium boarding infrastructure utilization."
    - name: "conflict_flag"
      expr: conflict_flag
      comment: "Indicates whether a gate conflict was detected for this assignment. Primary gate planning quality dimension."
    - name: "cdm_milestone_status"
      expr: cdm_milestone_status
      comment: "Status of CDM (Collaborative Decision Making) milestones for this assignment. Tracks airport CDM process compliance."
    - name: "assignment_source"
      expr: assignment_source
      comment: "Source system or process that generated the gate assignment (e.g. automated, manual override). Supports process quality analysis."
    - name: "assignment_start_month"
      expr: DATE_TRUNC('month', assignment_start_time)
      comment: "Month of gate assignment start. Enables monthly gate utilization trend analysis."
  measures:
    - name: "total_gate_assignments"
      expr: COUNT(1)
      comment: "Total number of gate assignments processed. Primary throughput KPI for gate planning system activity and airport capacity utilization."
    - name: "gate_conflict_count"
      expr: COUNT(CASE WHEN conflict_flag = TRUE THEN 1 END)
      comment: "Number of gate assignments with detected conflicts. Operational quality KPI — conflicts cause delays and require manual intervention, directly impacting OTP."
    - name: "priority_override_count"
      expr: COUNT(CASE WHEN priority_override_flag = TRUE THEN 1 END)
      comment: "Number of gate assignments where a priority override was applied. Tracks manual intervention frequency in automated gate planning systems."
    - name: "slot_coordination_required_count"
      expr: COUNT(CASE WHEN slot_coordination_required_flag = TRUE THEN 1 END)
      comment: "Number of gate assignments requiring slot coordination. Supports slot compliance workload planning and regulatory reporting."
    - name: "distinct_gates_utilized"
      expr: COUNT(DISTINCT gate_id)
      comment: "Number of distinct gates utilized across all assignments. Gate infrastructure utilization breadth KPI for capacity planning."
    - name: "distinct_flights_assigned"
      expr: COUNT(DISTINCT flight_leg_id)
      comment: "Number of distinct flight legs with gate assignments. Measures gate planning coverage across the operation."
$$;


CREATE OR REPLACE VIEW `airlines_ecm`.`_metrics`.`airport_ground_handler`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Evaluates ground handler performance, SLA compliance, ISAGO certification status, and financial risk exposure. Used by Airport Operations, Procurement, and Safety leadership to manage handler contracts, performance tiers, and regulatory compliance."
  source: "`airlines_ecm`.`airport`.`ground_handler`"
  dimensions:
    - name: "handler_type"
      expr: handler_type
      comment: "Type of ground handler (e.g. full-service, specialist, self-handling). Enables segmentation of performance metrics by handler category."
    - name: "performance_tier"
      expr: performance_tier
      comment: "Performance tier assigned to the handler (e.g. gold, silver, bronze). Primary dimension for tiered performance management and contract renewal decisions."
    - name: "operational_status"
      expr: operational_status
      comment: "Current operational status of the handler (e.g. active, suspended, terminated). Tracks handler availability and contract health."
    - name: "isago_certified_flag"
      expr: isago_certified_flag
      comment: "Indicates whether the handler holds current ISAGO safety certification. Safety compliance dimension — non-certified handlers represent elevated operational risk."
    - name: "penalty_triggered_flag"
      expr: penalty_triggered_flag
      comment: "Indicates whether a contractual penalty has been triggered for this handler. Financial risk and contract management dimension."
    - name: "baggage_handling_flag"
      expr: baggage_handling_flag
      comment: "Indicates whether the handler provides baggage handling services. Enables service-type-specific performance analysis."
    - name: "ramp_handling_flag"
      expr: ramp_handling_flag
      comment: "Indicates whether the handler provides ramp handling services. Supports ramp safety and turnaround performance attribution."
    - name: "passenger_handling_flag"
      expr: passenger_handling_flag
      comment: "Indicates whether the handler provides passenger handling services. Enables passenger experience performance attribution."
    - name: "insurance_currency_code"
      expr: insurance_currency_code
      comment: "Currency of the handler's insurance coverage. Required for multi-currency financial risk reporting."
  measures:
    - name: "total_ground_handlers"
      expr: COUNT(1)
      comment: "Total number of ground handlers in the network. Portfolio size KPI for procurement and vendor management oversight."
    - name: "avg_performance_score"
      expr: AVG(CAST(performance_score AS DOUBLE))
      comment: "Average performance score across all ground handlers. Primary handler quality KPI used in quarterly business reviews and contract renewal decisions."
    - name: "avg_on_time_departure_contribution_pct"
      expr: AVG(CAST(on_time_departure_contribution_pct AS DOUBLE))
      comment: "Average on-time departure contribution percentage across handlers. Directly links ground handler performance to OTP — a key executive KPI."
    - name: "avg_baggage_mishandling_rate_per_1000"
      expr: AVG(CAST(baggage_mishandling_rate_per_1000 AS DOUBLE))
      comment: "Average baggage mishandling rate per 1,000 bags across handlers. IATA benchmarking KPI — used to identify underperforming handlers and drive contractual remediation."
    - name: "avg_baggage_delivery_time_minutes"
      expr: AVG(CAST(average_baggage_delivery_time_minutes AS DOUBLE))
      comment: "Average baggage delivery time in minutes across handlers. Customer experience KPI — directly impacts passenger satisfaction scores and loyalty."
    - name: "total_insurance_coverage_amount"
      expr: SUM(CAST(insurance_coverage_amount AS DOUBLE))
      comment: "Total insurance coverage amount across all handlers. Financial risk KPI — ensures adequate coverage for potential liability claims from handler incidents."
    - name: "penalty_triggered_handler_count"
      expr: COUNT(CASE WHEN penalty_triggered_flag = TRUE THEN 1 END)
      comment: "Number of handlers with active contractual penalties triggered. Contract management KPI — elevated counts signal systemic performance issues requiring executive intervention."
    - name: "isago_non_certified_handler_count"
      expr: COUNT(CASE WHEN isago_certified_flag = FALSE THEN 1 END)
      comment: "Number of handlers without current ISAGO safety certification. Safety compliance KPI — non-certified handlers must be remediated or replaced to maintain safety standards."
$$;


CREATE OR REPLACE VIEW `airlines_ecm`.`_metrics`.`airport_slot_utilization`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Monitors airport slot compliance, utilization rates, and historic rights protection. Used by Network Planning, Slot Coordination, and Regulatory Affairs to manage slot portfolios, avoid forfeiture, and maintain historic precedence at coordinated airports."
  source: "`airlines_ecm`.`airport`.`slot_utilization`"
  dimensions:
    - name: "compliance_status"
      expr: compliance_status
      comment: "Slot compliance status for the operated flight (e.g. compliant, non-compliant, waived). Primary regulatory dimension for slot portfolio health monitoring."
    - name: "non_compliance_reason_code"
      expr: non_compliance_reason_code
      comment: "Reason code for slot non-compliance. Enables root-cause analysis of compliance failures to drive corrective action."
    - name: "historic_rights_protected_flag"
      expr: historic_rights_protected_flag
      comment: "Indicates whether historic slot rights are protected for this utilization record. Critical for slot portfolio strategy — loss of historic rights has long-term network implications."
    - name: "regulatory_reporting_flag"
      expr: regulatory_reporting_flag
      comment: "Indicates whether this slot utilization record requires regulatory reporting. Tracks compliance reporting obligations."
    - name: "slot_series_indicator"
      expr: slot_series_indicator
      comment: "Indicates whether the slot is part of a series. Supports series-level compliance rate analysis."
    - name: "slot_coordinator_code"
      expr: slot_coordinator_code
      comment: "Code of the slot coordinator body (e.g. ACL, FAA). Enables analysis by regulatory jurisdiction."
    - name: "operated_date_month"
      expr: DATE_TRUNC('month', operated_date)
      comment: "Month of slot operation. Enables monthly compliance trend analysis and season-over-season benchmarking."
  measures:
    - name: "total_slot_utilization_records"
      expr: COUNT(1)
      comment: "Total number of slot utilization records. Primary volume KPI for slot portfolio activity and compliance reporting coverage."
    - name: "compliant_slot_count"
      expr: COUNT(CASE WHEN compliance_status = 'COMPLIANT' THEN 1 END)
      comment: "Number of slots operated in compliance with coordination requirements. Core regulatory KPI — airlines must maintain 80%+ utilization rate to retain slots under IATA rules."
    - name: "non_compliant_slot_count"
      expr: COUNT(CASE WHEN compliance_status = 'NON-COMPLIANT' THEN 1 END)
      comment: "Number of slots operated out of compliance. Regulatory risk KPI — non-compliant slots risk forfeiture and loss of historic rights, with significant network and revenue implications."
    - name: "historic_rights_protected_count"
      expr: COUNT(CASE WHEN historic_rights_protected_flag = TRUE THEN 1 END)
      comment: "Number of slot utilization records where historic rights are protected. Strategic portfolio KPI — historic slots at congested airports are among the most valuable airline assets."
    - name: "distinct_slots_operated"
      expr: COUNT(DISTINCT slot_id)
      comment: "Number of distinct slots operated. Measures active slot portfolio utilization breadth."
    - name: "distinct_stations_with_slot_activity"
      expr: COUNT(DISTINCT station_id)
      comment: "Number of distinct coordinated airports with slot utilization activity. Supports slot portfolio geographic coverage analysis."
$$;


CREATE OR REPLACE VIEW `airlines_ecm`.`_metrics`.`airport_turnaround`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tracks aircraft turnaround performance including actual vs. target times, fuel uplift, cargo throughput, and OTP impact. Used by Operations Control, Ground Operations, and Fleet Management leadership to optimize turnaround efficiency and on-time departure performance."
  source: "`airlines_ecm`.`airport`.`turnaround`"
  dimensions:
    - name: "turnaround_status"
      expr: turnaround_status
      comment: "Current status of the turnaround (e.g. in-progress, completed, delayed). Tracks turnaround pipeline health."
    - name: "turnaround_type"
      expr: turnaround_type
      comment: "Type of turnaround (e.g. quick turn, overnight, transit). Enables performance analysis by turnaround category."
    - name: "delay_code"
      expr: delay_code
      comment: "IATA delay code associated with the turnaround. Enables root-cause analysis of turnaround-driven delays for OTP improvement."
    - name: "otp_impact_flag"
      expr: otp_impact_flag
      comment: "Indicates whether the turnaround caused an OTP impact. Primary dimension for linking ground operations to on-time performance."
    - name: "all_services_completed_flag"
      expr: all_services_completed_flag
      comment: "Indicates whether all required turnaround services were completed. Service completion quality dimension."
    - name: "cdm_milestone_status"
      expr: cdm_milestone_status
      comment: "CDM milestone completion status for the turnaround. Tracks collaborative decision-making process adherence."
    - name: "station_id"
      expr: station_id
      comment: "Station where the turnaround occurred. Enables station-level turnaround performance benchmarking."
    - name: "scheduled_block_out_month"
      expr: DATE_TRUNC('month', scheduled_block_out_time)
      comment: "Month of scheduled block-out. Enables monthly turnaround performance trend analysis."
  measures:
    - name: "total_turnarounds"
      expr: COUNT(1)
      comment: "Total number of aircraft turnarounds. Primary throughput KPI for ground operations capacity planning."
    - name: "otp_impacted_turnaround_count"
      expr: COUNT(CASE WHEN otp_impact_flag = TRUE THEN 1 END)
      comment: "Number of turnarounds that caused an OTP impact. Critical operational KPI — directly quantifies ground operations contribution to on-time departure failures."
    - name: "all_services_completed_count"
      expr: COUNT(CASE WHEN all_services_completed_flag = TRUE THEN 1 END)
      comment: "Number of turnarounds where all services were completed. Service quality KPI — incomplete services risk safety issues and delays on subsequent legs."
    - name: "total_fuel_uplift_kg"
      expr: SUM(CAST(fuel_uplift_kg AS DOUBLE))
      comment: "Total fuel uplifted across all turnarounds in kilograms. Key cost and operational KPI for fuel management, tankering strategy, and carbon reporting."
    - name: "avg_fuel_uplift_kg"
      expr: AVG(CAST(fuel_uplift_kg AS DOUBLE))
      comment: "Average fuel uplift per turnaround in kilograms. Supports fuel efficiency benchmarking and tankering policy optimization."
    - name: "total_cargo_weight_loaded_kg"
      expr: SUM(CAST(cargo_weight_loaded_kg AS DOUBLE))
      comment: "Total cargo weight loaded across all turnarounds. Revenue and capacity KPI for cargo operations and belly revenue management."
    - name: "total_cargo_weight_offloaded_kg"
      expr: SUM(CAST(cargo_weight_offloaded_kg AS DOUBLE))
      comment: "Total cargo weight offloaded across all turnarounds. Supports cargo throughput analysis and ground handling capacity planning."
    - name: "distinct_aircraft_turned"
      expr: COUNT(DISTINCT aircraft_id)
      comment: "Number of distinct aircraft processed through turnarounds. Fleet utilization breadth KPI for maintenance and ground operations planning."
$$;


CREATE OR REPLACE VIEW `airlines_ecm`.`_metrics`.`airport_turnaround_task`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Measures turnaround task execution quality, SLA compliance, cost efficiency, and safety incident rates at the individual task level. Used by Ground Operations, Safety, and Finance leadership to manage task-level performance, vendor accountability, and operational risk."
  source: "`airlines_ecm`.`airport`.`turnaround_task`"
  dimensions:
    - name: "task_type_code"
      expr: task_type_code
      comment: "Code identifying the type of turnaround task (e.g. fueling, catering, cleaning, loading). Primary dimension for task-level performance analysis."
    - name: "task_status"
      expr: task_status
      comment: "Current status of the task (e.g. completed, delayed, cancelled). Tracks task execution pipeline health."
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level assigned to the task. Enables analysis of high-priority task completion rates and delay impacts."
    - name: "sla_compliance_flag"
      expr: sla_compliance_flag
      comment: "Indicates whether the task was completed within SLA targets. Primary vendor accountability dimension."
    - name: "safety_incident_flag"
      expr: safety_incident_flag
      comment: "Indicates whether a safety incident occurred during this task. Critical safety KPI dimension — any safety incident requires immediate investigation."
    - name: "gse_defect_noted_flag"
      expr: gse_defect_noted_flag
      comment: "Indicates whether a ground support equipment defect was noted during the task. Tracks GSE reliability and maintenance needs."
    - name: "quality_check_performed_flag"
      expr: quality_check_performed_flag
      comment: "Indicates whether a quality check was performed for this task. Tracks quality assurance process adherence."
    - name: "quality_check_result"
      expr: quality_check_result
      comment: "Result of the quality check (e.g. pass, fail, conditional). Enables quality failure rate analysis by task type."
    - name: "delay_reason_code"
      expr: delay_reason_code
      comment: "Reason code for task delay. Enables root-cause analysis of task-level delays contributing to turnaround overruns."
    - name: "cost_currency_code"
      expr: cost_currency_code
      comment: "Currency of task cost. Required for multi-currency cost reporting."
    - name: "actual_start_month"
      expr: DATE_TRUNC('month', actual_start_time)
      comment: "Month of task actual start. Enables monthly task performance trend analysis."
  measures:
    - name: "total_turnaround_tasks"
      expr: COUNT(1)
      comment: "Total number of turnaround tasks executed. Primary throughput KPI for ground operations task management and staffing."
    - name: "sla_compliant_task_count"
      expr: COUNT(CASE WHEN sla_compliance_flag = TRUE THEN 1 END)
      comment: "Number of tasks completed within SLA targets. Vendor accountability KPI — SLA compliance rates drive contract performance reviews and penalty triggers."
    - name: "sla_breached_task_count"
      expr: COUNT(CASE WHEN sla_compliance_flag = FALSE THEN 1 END)
      comment: "Number of tasks that breached SLA targets. Operational risk KPI — SLA breaches on critical path tasks directly cause turnaround delays and OTP failures."
    - name: "safety_incident_task_count"
      expr: COUNT(CASE WHEN safety_incident_flag = TRUE THEN 1 END)
      comment: "Number of tasks with associated safety incidents. Critical safety KPI — any non-zero value triggers mandatory safety investigation and executive notification."
    - name: "gse_defect_task_count"
      expr: COUNT(CASE WHEN gse_defect_noted_flag = TRUE THEN 1 END)
      comment: "Number of tasks where a GSE defect was noted. Equipment reliability KPI — high GSE defect rates indicate maintenance backlog and risk of turnaround delays."
    - name: "total_task_cost_amount"
      expr: SUM(CAST(cost_amount AS DOUBLE))
      comment: "Total cost of all turnaround tasks. Key cost KPI for ground operations budget management and vendor cost control."
    - name: "avg_task_cost_amount"
      expr: AVG(CAST(cost_amount AS DOUBLE))
      comment: "Average cost per turnaround task. Benchmarking KPI for task-level cost efficiency and vendor pricing negotiations."
    - name: "total_gse_fuel_consumed_liters"
      expr: SUM(CAST(gse_fuel_consumed_liters AS DOUBLE))
      comment: "Total fuel consumed by ground support equipment across all tasks. Environmental and cost KPI for GSE fleet electrification business case and carbon reporting."
    - name: "quality_check_failure_count"
      expr: COUNT(CASE WHEN quality_check_performed_flag = TRUE AND quality_check_result = 'FAIL' THEN 1 END)
      comment: "Number of tasks that failed quality checks. Service quality KPI — quality failures on safety-critical tasks (e.g. fueling, loading) require immediate process intervention."
$$;
