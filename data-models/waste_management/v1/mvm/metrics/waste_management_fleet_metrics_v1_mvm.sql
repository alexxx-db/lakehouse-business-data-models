-- Metric views for domain: fleet | Business: Waste Management | Version: 1 | Generated on: 2026-05-07 22:39:52

CREATE OR REPLACE VIEW `waste_management_ecm`.`_metrics`.`fleet_vehicle`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPIs for the active vehicle fleet — acquisition cost, utilization posture, fuel capacity, and compliance readiness. Supports fleet investment, replacement planning, and operational capacity decisions."
  source: "`waste_management_ecm`.`fleet`.`vehicle`"
  dimensions:
    - name: "operational_status"
      expr: operational_status
      comment: "Current operational status of the vehicle (e.g. Active, Out-of-Service, Decommissioned). Primary filter for fleet availability analysis."
    - name: "fuel_type"
      expr: fuel_type
      comment: "Fuel type of the vehicle (e.g. Diesel, CNG, Electric). Used to segment fleet by energy source for sustainability and cost reporting."
    - name: "body_type"
      expr: body_type
      comment: "Body type of the vehicle (e.g. Rear Loader, Side Loader, Roll-Off). Drives route assignment and capacity planning."
    - name: "ownership_type"
      expr: ownership_type
      comment: "Ownership model of the vehicle (e.g. Owned, Leased, Contracted). Informs capital vs. operating expense classification."
    - name: "model_year"
      expr: model_year
      comment: "Model year of the vehicle. Used for fleet age analysis and replacement cycle planning."
    - name: "emissions_certification"
      expr: emissions_certification
      comment: "Emissions certification level (e.g. EPA 2010, CARB). Critical for regulatory compliance and sustainability reporting."
    - name: "acquisition_date_month"
      expr: DATE_TRUNC('MONTH', acquisition_date)
      comment: "Month of vehicle acquisition. Enables cohort analysis of fleet additions over time."
    - name: "cdl_required_flag"
      expr: cdl_required_flag
      comment: "Indicates whether a CDL is required to operate this vehicle. Used for driver qualification matching and compliance checks."
  measures:
    - name: "total_vehicles"
      expr: COUNT(1)
      comment: "Total number of vehicles in the fleet. Baseline measure for fleet size tracking and capacity planning."
    - name: "active_vehicles"
      expr: COUNT(CASE WHEN operational_status = 'Active' THEN 1 END)
      comment: "Number of vehicles currently in active operational status. Directly measures deployable fleet capacity."
    - name: "out_of_service_vehicles"
      expr: COUNT(CASE WHEN operational_status = 'Out-of-Service' THEN 1 END)
      comment: "Number of vehicles currently out of service. High values signal maintenance backlogs or safety issues requiring executive intervention."
    - name: "total_acquisition_cost"
      expr: SUM(CAST(acquisition_cost AS DOUBLE))
      comment: "Total capital invested in the fleet. Core metric for asset management, depreciation scheduling, and capital budget reviews."
    - name: "avg_acquisition_cost"
      expr: AVG(CAST(acquisition_cost AS DOUBLE))
      comment: "Average acquisition cost per vehicle. Benchmarks procurement efficiency and informs replacement cost forecasting."
    - name: "total_fuel_tank_capacity_gallons"
      expr: SUM(CAST(fuel_tank_capacity_gallons AS DOUBLE))
      comment: "Total fuel tank capacity across the fleet in gallons. Supports fuel logistics planning and emergency fuel reserve analysis."
    - name: "total_body_capacity_cubic_yards"
      expr: SUM(CAST(body_capacity_cubic_yards AS DOUBLE))
      comment: "Total waste collection capacity of the fleet in cubic yards. Directly tied to collection throughput and service capacity planning."
    - name: "avg_body_capacity_cubic_yards"
      expr: AVG(CAST(body_capacity_cubic_yards AS DOUBLE))
      comment: "Average body capacity per vehicle in cubic yards. Used to assess fleet configuration alignment with route density requirements."
    - name: "vehicles_with_expired_registration"
      expr: COUNT(CASE WHEN registration_expiration_date < CURRENT_DATE() THEN 1 END)
      comment: "Number of vehicles with expired registrations. A compliance risk metric — any non-zero value requires immediate remediation to avoid regulatory penalties."
    - name: "vehicles_pm_overdue"
      expr: COUNT(CASE WHEN next_pm_due_date < CURRENT_DATE() THEN 1 END)
      comment: "Number of vehicles past their next scheduled preventive maintenance due date. Signals maintenance backlog risk and potential safety/compliance exposure."
    - name: "distinct_fuel_types"
      expr: COUNT(DISTINCT fuel_type)
      comment: "Number of distinct fuel types in the fleet. Measures fleet energy diversity, relevant for sustainability strategy and fueling infrastructure investment."
$$;


CREATE OR REPLACE VIEW `waste_management_ecm`.`_metrics`.`fleet_fuel_transaction`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Operational and financial KPIs for fleet fuel consumption and cost. Supports fuel budget management, efficiency benchmarking, IFTA compliance, and sustainability reporting."
  source: "`waste_management_ecm`.`fleet`.`fuel_transaction`"
  dimensions:
    - name: "fuel_type"
      expr: fuel_type
      comment: "Type of fuel dispensed (e.g. Diesel, CNG, DEF). Enables cost and consumption analysis by energy source."
    - name: "fuel_grade"
      expr: fuel_grade
      comment: "Grade of fuel dispensed. Used for procurement and quality analysis."
    - name: "station_type"
      expr: station_type
      comment: "Type of fueling station (e.g. Company Yard, Retail, Cardlock). Informs make-vs-buy fueling strategy decisions."
    - name: "ifta_jurisdiction"
      expr: ifta_jurisdiction
      comment: "IFTA jurisdiction where fuel was dispensed. Required for IFTA tax reporting and cross-state fuel tax compliance."
    - name: "transaction_status"
      expr: transaction_status
      comment: "Status of the fuel transaction (e.g. Approved, Declined, Pending). Used to filter valid transactions and detect fraud or exceptions."
    - name: "is_emergency_fuel"
      expr: is_emergency_fuel
      comment: "Indicates whether the transaction was an emergency fuel event. Emergency fueling is typically more expensive and signals operational disruptions."
    - name: "transaction_date_month"
      expr: DATE_TRUNC('MONTH', CAST(transaction_timestamp AS DATE))
      comment: "Month of the fuel transaction. Enables trend analysis of fuel spend and consumption over time."
    - name: "cost_center"
      expr: cost_center
      comment: "Cost center associated with the fuel transaction. Enables financial allocation and departmental cost accountability."
    - name: "vendor_name"
      expr: vendor_name
      comment: "Name of the fuel vendor. Used for vendor spend analysis and contract performance evaluation."
  measures:
    - name: "total_fuel_transactions"
      expr: COUNT(1)
      comment: "Total number of fuel transactions. Baseline volume metric for fueling activity monitoring."
    - name: "total_fuel_cost"
      expr: SUM(CAST(total_cost AS DOUBLE))
      comment: "Total fuel expenditure across all transactions. Primary financial KPI for fleet fuel budget management and cost control."
    - name: "total_pretax_fuel_cost"
      expr: SUM(CAST(pre_tax_amount AS DOUBLE))
      comment: "Total pre-tax fuel cost. Used for net fuel cost analysis and tax reclaim calculations."
    - name: "total_fuel_tax"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total fuel tax paid. Required for IFTA tax reporting and regulatory compliance filings."
    - name: "total_quantity_dispensed_gallons"
      expr: SUM(CAST(quantity_dispensed AS DOUBLE))
      comment: "Total fuel volume dispensed in gallons. Core consumption metric for efficiency benchmarking and sustainability reporting."
    - name: "total_def_quantity_dispensed"
      expr: SUM(CAST(def_quantity_dispensed AS DOUBLE))
      comment: "Total DEF (Diesel Exhaust Fluid) dispensed. Tracks emissions compliance fluid usage for EPA-regulated vehicles."
    - name: "avg_unit_cost_per_gallon"
      expr: AVG(CAST(unit_cost AS DOUBLE))
      comment: "Average cost per gallon of fuel. Benchmarks procurement efficiency and tracks fuel price trends for budget forecasting."
    - name: "avg_fuel_cost_per_transaction"
      expr: AVG(CAST(total_cost AS DOUBLE))
      comment: "Average fuel cost per transaction. Identifies anomalous transactions and supports fraud detection."
    - name: "emergency_fuel_transactions"
      expr: COUNT(CASE WHEN is_emergency_fuel = TRUE THEN 1 END)
      comment: "Number of emergency fuel transactions. High frequency signals operational disruptions or inadequate yard fueling infrastructure."
    - name: "emergency_fuel_cost"
      expr: SUM(CASE WHEN is_emergency_fuel = TRUE THEN CAST(total_cost AS DOUBLE) ELSE 0 END)
      comment: "Total cost of emergency fuel transactions. Emergency fueling carries premium costs — tracking this drives infrastructure investment decisions."
    - name: "distinct_vehicles_fueled"
      expr: COUNT(DISTINCT vehicle_id)
      comment: "Number of distinct vehicles that received fuel. Measures fleet fueling coverage and identifies vehicles not being tracked."
$$;


CREATE OR REPLACE VIEW `waste_management_ecm`.`_metrics`.`fleet_accident_report`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Safety and risk KPIs derived from fleet accident reports. Supports safety program management, insurance cost control, DOT/CSA compliance, and driver performance evaluation."
  source: "`waste_management_ecm`.`fleet`.`accident_report`"
  dimensions:
    - name: "incident_type"
      expr: incident_type
      comment: "Type of accident or incident (e.g. Collision, Rollover, Property Damage). Used to categorize safety events for root cause analysis."
    - name: "incident_severity"
      expr: incident_severity
      comment: "Severity classification of the incident (e.g. Minor, Moderate, Severe, Fatal). Drives prioritization of safety investigations and corrective actions."
    - name: "preventable_flag"
      expr: preventable_flag
      comment: "Indicates whether the accident was deemed preventable. Preventable accident rate is a core driver safety KPI."
    - name: "driver_at_fault_flag"
      expr: driver_at_fault_flag
      comment: "Indicates whether the driver was determined to be at fault. Used for driver performance scoring and training program targeting."
    - name: "dot_reportable_flag"
      expr: dot_reportable_flag
      comment: "Indicates whether the accident is reportable to the DOT. DOT-reportable accidents directly impact CSA scores and operating authority."
    - name: "csa_reportable_flag"
      expr: csa_reportable_flag
      comment: "Indicates whether the accident is reportable under FMCSA CSA program. CSA scores affect carrier safety ratings and contract eligibility."
    - name: "investigation_status"
      expr: investigation_status
      comment: "Current status of the accident investigation (e.g. Open, In Progress, Closed). Tracks investigation backlog and closure rates."
    - name: "incident_date_month"
      expr: DATE_TRUNC('MONTH', incident_date)
      comment: "Month of the incident. Enables trend analysis of accident frequency over time."
    - name: "weather_conditions"
      expr: weather_conditions
      comment: "Weather conditions at the time of the incident. Used for environmental risk factor analysis in safety programs."
    - name: "citation_issued_flag"
      expr: citation_issued_flag
      comment: "Indicates whether a citation was issued at the scene. Citations increase regulatory and insurance risk exposure."
  measures:
    - name: "total_accidents"
      expr: COUNT(1)
      comment: "Total number of accident reports. Baseline safety frequency metric used in safety scorecards and insurance negotiations."
    - name: "dot_reportable_accidents"
      expr: COUNT(CASE WHEN dot_reportable_flag = TRUE THEN 1 END)
      comment: "Number of DOT-reportable accidents. Directly impacts CSA scores and FMCSA safety ratings — a critical regulatory compliance KPI."
    - name: "preventable_accidents"
      expr: COUNT(CASE WHEN preventable_flag = TRUE THEN 1 END)
      comment: "Number of accidents classified as preventable. Core driver safety KPI — high preventable rates trigger training interventions and disciplinary reviews."
    - name: "driver_at_fault_accidents"
      expr: COUNT(CASE WHEN driver_at_fault_flag = TRUE THEN 1 END)
      comment: "Number of accidents where the driver was at fault. Used for driver performance evaluation and targeted safety coaching."
    - name: "total_estimated_property_damage"
      expr: SUM(CAST(estimated_property_damage_amount AS DOUBLE))
      comment: "Total estimated property damage from accidents. Directly informs insurance reserve requirements and safety program ROI calculations."
    - name: "avg_estimated_property_damage"
      expr: AVG(CAST(estimated_property_damage_amount AS DOUBLE))
      comment: "Average property damage per accident. Benchmarks accident severity and tracks improvement in damage mitigation over time."
    - name: "accidents_with_citations"
      expr: COUNT(CASE WHEN citation_issued_flag = TRUE THEN 1 END)
      comment: "Number of accidents where a citation was issued. Citations increase regulatory exposure and insurance premiums."
    - name: "post_accident_tests_completed"
      expr: COUNT(CASE WHEN post_accident_test_completed_flag = TRUE THEN 1 END)
      comment: "Number of accidents where post-accident drug/alcohol testing was completed. Compliance with post-accident testing requirements is a DOT mandate."
    - name: "post_accident_tests_required_not_completed"
      expr: COUNT(CASE WHEN post_accident_test_required_flag = TRUE AND post_accident_test_completed_flag = FALSE THEN 1 END)
      comment: "Number of accidents where post-accident testing was required but not completed. Non-compliance is a serious DOT violation with significant penalty exposure."
    - name: "open_investigations"
      expr: COUNT(CASE WHEN investigation_status NOT IN ('Closed', 'Completed') THEN 1 END)
      comment: "Number of accident investigations not yet closed. Tracks investigation backlog and ensures timely closure for insurance and regulatory purposes."
    - name: "distinct_drivers_involved"
      expr: COUNT(DISTINCT driver_id)
      comment: "Number of distinct drivers involved in accidents. Identifies high-risk driver cohorts for targeted safety intervention."
$$;


CREATE OR REPLACE VIEW `waste_management_ecm`.`_metrics`.`fleet_dot_inspection`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Regulatory compliance KPIs for DOT roadside inspections. Supports CSA score management, out-of-service rate reduction, corrective action tracking, and FMCSA safety rating maintenance."
  source: "`waste_management_ecm`.`fleet`.`dot_inspection`"
  dimensions:
    - name: "inspection_result"
      expr: inspection_result
      comment: "Outcome of the DOT inspection (e.g. Pass, Fail, Out-of-Service). Primary dimension for compliance performance analysis."
    - name: "inspection_type"
      expr: inspection_type
      comment: "Type of DOT inspection (e.g. Level I, Level II, Level III). Different inspection levels have different scope and CSA score implications."
    - name: "inspection_category"
      expr: inspection_category
      comment: "Category of the inspection. Used to segment compliance performance by inspection scope."
    - name: "basic_category"
      expr: basic_category
      comment: "FMCSA BASIC category associated with the violation (e.g. HOS, Vehicle Maintenance, Driver Fitness). Maps violations to CSA BASIC scores for regulatory reporting."
    - name: "out_of_service_flag"
      expr: out_of_service_flag
      comment: "Indicates whether the vehicle was placed out of service during the inspection. OOS events directly impact fleet availability and CSA scores."
    - name: "vehicle_oos_flag"
      expr: vehicle_oos_flag
      comment: "Indicates whether the vehicle specifically was placed out of service. Distinguishes vehicle vs. driver OOS events for targeted corrective action."
    - name: "driver_oos_flag"
      expr: driver_oos_flag
      comment: "Indicates whether the driver was placed out of service. Driver OOS events affect HOS and driver qualification compliance scores."
    - name: "corrective_action_status"
      expr: corrective_action_status
      comment: "Status of corrective action for inspection violations (e.g. Open, In Progress, Completed). Tracks remediation backlog."
    - name: "inspection_state"
      expr: inspection_state
      comment: "State where the inspection occurred. Identifies geographic patterns in inspection outcomes and violation rates."
    - name: "inspection_date_month"
      expr: DATE_TRUNC('MONTH', inspection_date)
      comment: "Month of the inspection. Enables trend analysis of inspection outcomes and CSA score trajectory."
    - name: "corrective_action_required_flag"
      expr: corrective_action_required_flag
      comment: "Indicates whether corrective action was required following the inspection. Drives remediation workflow prioritization."
  measures:
    - name: "total_inspections"
      expr: COUNT(1)
      comment: "Total number of DOT inspections. Baseline volume metric for regulatory exposure tracking."
    - name: "out_of_service_events"
      expr: COUNT(CASE WHEN out_of_service_flag = TRUE THEN 1 END)
      comment: "Number of inspections resulting in an out-of-service order. OOS events remove vehicles/drivers from service and directly impact revenue and CSA scores."
    - name: "vehicle_oos_events"
      expr: COUNT(CASE WHEN vehicle_oos_flag = TRUE THEN 1 END)
      comment: "Number of inspections where the vehicle was placed out of service. Signals vehicle maintenance deficiencies requiring immediate corrective action."
    - name: "driver_oos_events"
      expr: COUNT(CASE WHEN driver_oos_flag = TRUE THEN 1 END)
      comment: "Number of inspections where the driver was placed out of service. Signals HOS, qualification, or fitness violations requiring driver management intervention."
    - name: "total_csa_score_impact"
      expr: SUM(CAST(csa_score_impact AS DOUBLE))
      comment: "Total CSA score impact from all inspections. CSA scores determine FMCSA safety ratings and directly affect operating authority and contract eligibility."
    - name: "avg_csa_score_impact_per_inspection"
      expr: AVG(CAST(csa_score_impact AS DOUBLE))
      comment: "Average CSA score impact per inspection. Benchmarks the severity of violations and tracks improvement in compliance posture over time."
    - name: "inspections_with_violations"
      expr: COUNT(CASE WHEN inspection_result = 'Fail' OR out_of_service_flag = TRUE THEN 1 END)
      comment: "Number of inspections with violations or OOS orders. Core compliance KPI for safety program effectiveness measurement."
    - name: "open_corrective_actions"
      expr: COUNT(CASE WHEN corrective_action_required_flag = TRUE AND corrective_action_status NOT IN ('Completed', 'Closed') THEN 1 END)
      comment: "Number of inspections with open corrective actions. Unresolved corrective actions increase regulatory risk and repeat violation probability."
    - name: "distinct_vehicles_inspected"
      expr: COUNT(DISTINCT vehicle_id)
      comment: "Number of distinct vehicles that received DOT inspections. Measures regulatory exposure breadth across the fleet."
    - name: "distinct_drivers_inspected"
      expr: COUNT(DISTINCT driver_id)
      comment: "Number of distinct drivers involved in DOT inspections. Identifies driver cohorts with elevated regulatory exposure."
$$;


CREATE OR REPLACE VIEW `waste_management_ecm`.`_metrics`.`fleet_driver`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Workforce compliance and safety KPIs for the driver population. Supports CDL compliance management, DOT physical tracking, drug/alcohol program oversight, and driver qualification reviews."
  source: "`waste_management_ecm`.`fleet`.`driver`"
  dimensions:
    - name: "operational_status"
      expr: operational_status
      comment: "Current operational status of the driver (e.g. Active, Inactive, Terminated). Primary filter for active workforce analysis."
    - name: "qualification_status"
      expr: qualification_status
      comment: "Driver qualification status (e.g. Qualified, Disqualified, Pending Review). Directly impacts driver deployment eligibility."
    - name: "cdl_class"
      expr: cdl_class
      comment: "CDL class held by the driver (e.g. Class A, Class B). Determines vehicle types the driver is authorized to operate."
    - name: "primary_route_type"
      expr: primary_route_type
      comment: "Primary route type assigned to the driver (e.g. Residential, Commercial, Roll-Off). Used for workforce planning and route staffing analysis."
    - name: "mvr_status"
      expr: mvr_status
      comment: "Motor Vehicle Record review status. MVR status is a key driver qualification compliance indicator."
    - name: "hazmat_endorsement_flag"
      expr: hazmat_endorsement_flag
      comment: "Indicates whether the driver holds a hazmat CDL endorsement. Required for hazardous waste transport assignments."
    - name: "drug_alcohol_program_enrollment_flag"
      expr: drug_alcohol_program_enrollment_flag
      comment: "Indicates whether the driver is enrolled in the DOT drug and alcohol testing program. Enrollment is a DOT compliance requirement for all CDL drivers."
    - name: "hire_date_year"
      expr: DATE_TRUNC('YEAR', hire_date)
      comment: "Year of driver hire. Enables tenure cohort analysis for safety performance and retention benchmarking."
  measures:
    - name: "total_drivers"
      expr: COUNT(1)
      comment: "Total number of drivers in the system. Baseline workforce size metric for capacity planning and staffing analysis."
    - name: "active_drivers"
      expr: COUNT(CASE WHEN operational_status = 'Active' THEN 1 END)
      comment: "Number of currently active drivers. Measures deployable driver capacity against route demand."
    - name: "qualified_drivers"
      expr: COUNT(CASE WHEN qualification_status = 'Qualified' THEN 1 END)
      comment: "Number of fully qualified drivers. Qualified driver count determines actual operational capacity and compliance posture."
    - name: "drivers_with_expired_cdl"
      expr: COUNT(CASE WHEN cdl_expiration_date < CURRENT_DATE() THEN 1 END)
      comment: "Number of drivers with expired CDLs. Expired CDL drivers cannot legally operate CMVs — any non-zero value is an immediate compliance risk."
    - name: "drivers_with_expired_dot_physical"
      expr: COUNT(CASE WHEN dot_physical_expiration_date < CURRENT_DATE() THEN 1 END)
      comment: "Number of drivers with expired DOT medical certificates. Expired physicals disqualify drivers from CMV operation — a critical DOT compliance metric."
    - name: "drivers_with_hazmat_endorsement"
      expr: COUNT(CASE WHEN hazmat_endorsement_flag = TRUE THEN 1 END)
      comment: "Number of drivers with active hazmat endorsements. Measures capacity to staff hazardous waste collection routes."
    - name: "drivers_not_enrolled_drug_program"
      expr: COUNT(CASE WHEN drug_alcohol_program_enrollment_flag = FALSE OR drug_alcohol_program_enrollment_flag IS NULL THEN 1 END)
      comment: "Number of active CDL drivers not enrolled in the DOT drug and alcohol testing program. Non-enrollment is a serious DOT violation."
    - name: "avg_safety_score"
      expr: AVG(CAST(safety_score AS DOUBLE))
      comment: "Average driver safety score across the fleet. Composite safety metric used to benchmark driver performance and target coaching interventions."
    - name: "total_miles_driven"
      expr: SUM(CAST(total_miles_driven AS DOUBLE))
      comment: "Total miles driven across all drivers. Used for exposure-based safety rate calculations (accidents per million miles) and IFTA reporting."
    - name: "drivers_with_cdl_expiring_90_days"
      expr: COUNT(CASE WHEN cdl_expiration_date BETWEEN CURRENT_DATE() AND DATE_ADD(CURRENT_DATE(), 90) THEN 1 END)
      comment: "Number of drivers whose CDL expires within 90 days. Proactive compliance metric to prevent CDL lapses before they occur."
    - name: "distinct_cdl_classes"
      expr: COUNT(DISTINCT cdl_class)
      comment: "Number of distinct CDL classes held across the driver workforce. Measures workforce versatility for multi-vehicle-class operations."
$$;


CREATE OR REPLACE VIEW `waste_management_ecm`.`_metrics`.`fleet_hos_log`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Hours-of-Service compliance KPIs for CMV drivers. Supports DOT HOS regulatory compliance, ELD mandate adherence, fatigue risk management, and CSA BASIC score management."
  source: "`waste_management_ecm`.`fleet`.`hos_log`"
  dimensions:
    - name: "duty_status"
      expr: duty_status
      comment: "Driver duty status at the time of the log entry (e.g. Driving, On-Duty Not Driving, Off-Duty, Sleeper Berth). Core HOS compliance dimension."
    - name: "hos_violation_flag"
      expr: hos_violation_flag
      comment: "Indicates whether the log entry contains an HOS violation. HOS violations directly impact CSA scores and driver qualification status."
    - name: "break_compliance_flag"
      expr: break_compliance_flag
      comment: "Indicates whether the required 30-minute break was taken in compliance with HOS rules. Break violations are a common DOT citation category."
    - name: "edit_flag"
      expr: edit_flag
      comment: "Indicates whether the log entry was edited after initial submission. High edit rates may signal data integrity issues or ELD manipulation."
    - name: "certification_status"
      expr: certification_status
      comment: "Certification status of the HOS log (e.g. Certified, Uncertified). Uncertified logs are a DOT compliance deficiency."
    - name: "data_source"
      expr: data_source
      comment: "Source of the HOS log data (e.g. ELD, Paper, Exempt). ELD mandate compliance requires electronic logging for most CMV operations."
    - name: "log_date_month"
      expr: DATE_TRUNC('MONTH', log_date)
      comment: "Month of the HOS log entry. Enables trend analysis of HOS compliance rates over time."
    - name: "violation_type_code"
      expr: violation_type_code
      comment: "Code identifying the type of HOS violation. Used to categorize violations for targeted driver coaching and compliance program design."
  measures:
    - name: "total_hos_log_entries"
      expr: COUNT(1)
      comment: "Total number of HOS log entries. Baseline volume metric for ELD data completeness and driver activity monitoring."
    - name: "hos_violation_entries"
      expr: COUNT(CASE WHEN hos_violation_flag = TRUE THEN 1 END)
      comment: "Number of HOS log entries with violations. Core DOT compliance KPI — violations impact CSA scores and driver qualification status."
    - name: "break_non_compliance_entries"
      expr: COUNT(CASE WHEN break_compliance_flag = FALSE THEN 1 END)
      comment: "Number of log entries where the required break was not taken in compliance. Break violations are a frequent DOT citation and fatigue risk indicator."
    - name: "uncertified_log_entries"
      expr: COUNT(CASE WHEN certification_status != 'Certified' THEN 1 END)
      comment: "Number of HOS log entries not yet certified by the driver. Uncertified logs are a DOT compliance deficiency requiring driver action."
    - name: "edited_log_entries"
      expr: COUNT(CASE WHEN edit_flag = TRUE THEN 1 END)
      comment: "Number of HOS log entries that were edited after initial submission. Elevated edit rates may indicate ELD data quality issues or manipulation."
    - name: "avg_cumulative_driving_hours_8day"
      expr: AVG(CAST(cumulative_driving_hours_8day AS DOUBLE))
      comment: "Average cumulative driving hours over the rolling 8-day window. Measures fleet-wide fatigue exposure and proximity to the 60/70-hour HOS limit."
    - name: "avg_cumulative_on_duty_hours_8day"
      expr: AVG(CAST(cumulative_on_duty_hours_8day AS DOUBLE))
      comment: "Average cumulative on-duty hours over the rolling 8-day window. Tracks workforce fatigue levels and HOS limit proximity for proactive intervention."
    - name: "max_cumulative_driving_hours_8day"
      expr: MAX(CAST(cumulative_driving_hours_8day AS DOUBLE))
      comment: "Maximum cumulative driving hours recorded in the 8-day window. Identifies the highest-risk drivers approaching or exceeding HOS limits."
    - name: "distinct_drivers_with_violations"
      expr: COUNT(DISTINCT CASE WHEN hos_violation_flag = TRUE THEN driver_id END)
      comment: "Number of distinct drivers with at least one HOS violation. Measures the breadth of HOS compliance issues across the driver population."
$$;


CREATE OR REPLACE VIEW `waste_management_ecm`.`_metrics`.`fleet_telematics_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Real-time and historical fleet telematics KPIs covering safety behavior, fuel efficiency, engine health, and idle time. Supports driver coaching, fuel cost reduction, predictive maintenance, and sustainability reporting."
  source: "`waste_management_ecm`.`fleet`.`telematics_event`"
  dimensions:
    - name: "event_type"
      expr: event_type
      comment: "Type of telematics event (e.g. Speeding, Harsh Braking, Idle, Geofence). Primary dimension for safety behavior and operational event analysis."
    - name: "speeding_flag"
      expr: speeding_flag
      comment: "Indicates whether the vehicle was speeding at the time of the event. Speeding is a leading indicator of accident risk and insurance cost."
    - name: "harsh_braking_flag"
      expr: harsh_braking_flag
      comment: "Indicates whether a harsh braking event occurred. Harsh braking increases accident risk, vehicle wear, and fuel consumption."
    - name: "harsh_acceleration_flag"
      expr: harsh_acceleration_flag
      comment: "Indicates whether a harsh acceleration event occurred. Harsh acceleration increases fuel consumption and drivetrain wear."
    - name: "idle_duration_flag"
      expr: idle_duration_flag
      comment: "Indicates whether the vehicle was idling at the time of the event. Excessive idling wastes fuel and increases emissions."
    - name: "ignition_status"
      expr: ignition_status
      comment: "Ignition status of the vehicle (e.g. On, Off). Used to calculate active vs. idle time and validate route activity."
    - name: "event_date_month"
      expr: DATE_TRUNC('MONTH', CAST(event_timestamp AS DATE))
      comment: "Month of the telematics event. Enables trend analysis of safety behavior and fuel efficiency over time."
    - name: "pto_status"
      expr: pto_status
      comment: "Power Take-Off status (e.g. Engaged, Disengaged). PTO engagement tracks compactor and lift operation time for productivity analysis."
  measures:
    - name: "total_telematics_events"
      expr: COUNT(1)
      comment: "Total number of telematics events recorded. Baseline volume metric for telematics data coverage and device health monitoring."
    - name: "speeding_events"
      expr: COUNT(CASE WHEN speeding_flag = TRUE THEN 1 END)
      comment: "Number of speeding events. Speeding is a primary driver safety risk metric and insurance liability indicator."
    - name: "harsh_braking_events"
      expr: COUNT(CASE WHEN harsh_braking_flag = TRUE THEN 1 END)
      comment: "Number of harsh braking events. Harsh braking correlates with accident risk and accelerated brake wear — a key driver coaching metric."
    - name: "harsh_acceleration_events"
      expr: COUNT(CASE WHEN harsh_acceleration_flag = TRUE THEN 1 END)
      comment: "Number of harsh acceleration events. Harsh acceleration increases fuel consumption and drivetrain wear costs."
    - name: "total_idle_time_minutes"
      expr: SUM(CAST(idle_time_minutes AS DOUBLE))
      comment: "Total idle time in minutes across all telematics events. Excessive idling is a direct fuel cost and emissions driver — reducing idle time is a key sustainability lever."
    - name: "avg_idle_time_minutes_per_event"
      expr: AVG(CAST(idle_time_minutes AS DOUBLE))
      comment: "Average idle time per telematics event. Benchmarks idling behavior across vehicles and drivers for targeted coaching."
    - name: "total_fuel_consumption_gallons"
      expr: SUM(CAST(fuel_consumption_gallons AS DOUBLE))
      comment: "Total fuel consumed as reported by telematics. Cross-validates fuel card transaction data and supports real-time fuel efficiency monitoring."
    - name: "avg_fuel_level_percent"
      expr: AVG(CAST(fuel_level_percent AS DOUBLE))
      comment: "Average fuel level percentage across telematics events. Monitors fleet-wide fuel availability and supports fueling schedule optimization."
    - name: "avg_engine_load_percent"
      expr: AVG(CAST(engine_load_percent AS DOUBLE))
      comment: "Average engine load percentage. High sustained engine load indicates vehicle stress and is a predictive maintenance signal."
    - name: "avg_vehicle_speed_mph"
      expr: AVG(CAST(vehicle_speed_mph AS DOUBLE))
      comment: "Average vehicle speed in mph. Used for route efficiency analysis and speed compliance monitoring."
    - name: "total_odometer_miles"
      expr: SUM(CAST(odometer_miles AS DOUBLE))
      comment: "Total odometer miles recorded via telematics. Used for mileage-based maintenance scheduling and IFTA mileage reporting."
    - name: "distinct_vehicles_tracked"
      expr: COUNT(DISTINCT vehicle_id)
      comment: "Number of distinct vehicles generating telematics data. Measures telematics device coverage across the fleet — gaps indicate untracked vehicles."
$$;


CREATE OR REPLACE VIEW `waste_management_ecm`.`_metrics`.`fleet_maintenance_schedule`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Preventive and corrective maintenance KPIs for the fleet. Supports maintenance program effectiveness, cost control, regulatory compliance (FMCSA), and vehicle uptime optimization."
  source: "`waste_management_ecm`.`fleet`.`maintenance_schedule`"
  dimensions:
    - name: "schedule_status"
      expr: schedule_status
      comment: "Current status of the maintenance schedule (e.g. Scheduled, Completed, Overdue, Cancelled). Primary dimension for maintenance backlog and compliance analysis."
    - name: "trigger_type"
      expr: trigger_type
      comment: "What triggers the maintenance event (e.g. Calendar, Mileage, Engine Hours). Used to analyze maintenance program design and scheduling effectiveness."
    - name: "priority"
      expr: priority
      comment: "Priority level of the maintenance schedule (e.g. Critical, High, Normal, Low). Drives maintenance resource allocation and scheduling decisions."
    - name: "dot_inspection_flag"
      expr: dot_inspection_flag
      comment: "Indicates whether the maintenance event includes a DOT inspection. DOT inspection completion is a regulatory compliance requirement."
    - name: "fmcsa_required_flag"
      expr: fmcsa_required_flag
      comment: "Indicates whether the maintenance is required by FMCSA regulations. FMCSA-required maintenance non-compliance carries significant penalty risk."
    - name: "emissions_inspection_flag"
      expr: emissions_inspection_flag
      comment: "Indicates whether the maintenance event includes an emissions inspection. Emissions compliance is a regulatory requirement in many jurisdictions."
    - name: "out_of_service_flag"
      expr: out_of_service_flag
      comment: "Indicates whether the vehicle is out of service pending this maintenance. OOS vehicles reduce fleet availability and revenue capacity."
    - name: "defects_found_flag"
      expr: defects_found_flag
      comment: "Indicates whether defects were found during the maintenance event. Defect discovery rates measure inspection thoroughness and vehicle condition."
    - name: "scheduled_date_month"
      expr: DATE_TRUNC('MONTH', scheduled_date)
      comment: "Month the maintenance was scheduled. Enables workload forecasting and maintenance resource planning."
  measures:
    - name: "total_maintenance_schedules"
      expr: COUNT(1)
      comment: "Total number of maintenance schedule records. Baseline volume metric for maintenance program activity."
    - name: "overdue_maintenance_schedules"
      expr: COUNT(CASE WHEN next_due_date < CURRENT_DATE() AND schedule_status NOT IN ('Completed', 'Cancelled') THEN 1 END)
      comment: "Number of maintenance schedules past their due date and not yet completed. Overdue maintenance increases breakdown risk, safety exposure, and regulatory non-compliance."
    - name: "vehicles_out_of_service_for_maintenance"
      expr: COUNT(CASE WHEN out_of_service_flag = TRUE THEN 1 END)
      comment: "Number of maintenance schedules where the vehicle is currently out of service. Directly measures fleet availability impact from maintenance activities."
    - name: "total_estimated_labor_cost"
      expr: SUM(CAST(estimated_labor_cost AS DOUBLE))
      comment: "Total estimated labor cost for scheduled maintenance. Core input for maintenance budget planning and cost control."
    - name: "total_estimated_parts_cost"
      expr: SUM(CAST(estimated_parts_cost AS DOUBLE))
      comment: "Total estimated parts cost for scheduled maintenance. Supports parts inventory planning and procurement budget management."
    - name: "total_actual_duration_hours"
      expr: SUM(CAST(actual_duration_hours AS DOUBLE))
      comment: "Total actual labor hours spent on completed maintenance. Used for shop capacity planning and labor efficiency benchmarking."
    - name: "avg_actual_duration_hours"
      expr: AVG(CAST(actual_duration_hours AS DOUBLE))
      comment: "Average actual duration per maintenance event in hours. Benchmarks maintenance efficiency and identifies events exceeding estimated duration."
    - name: "avg_estimated_duration_hours"
      expr: AVG(CAST(estimated_duration_hours AS DOUBLE))
      comment: "Average estimated duration per maintenance event. Used for shop scheduling and technician workload planning."
    - name: "maintenance_events_with_defects"
      expr: COUNT(CASE WHEN defects_found_flag = TRUE THEN 1 END)
      comment: "Number of maintenance events where defects were found. High defect discovery rates may indicate fleet condition deterioration or inspection quality improvement."
    - name: "fmcsa_required_overdue"
      expr: COUNT(CASE WHEN fmcsa_required_flag = TRUE AND next_due_date < CURRENT_DATE() AND schedule_status NOT IN ('Completed', 'Cancelled') THEN 1 END)
      comment: "Number of FMCSA-required maintenance events that are overdue. FMCSA non-compliance carries direct penalty and operating authority risk — a critical regulatory KPI."
    - name: "distinct_vehicles_in_maintenance"
      expr: COUNT(DISTINCT vehicle_id)
      comment: "Number of distinct vehicles with active maintenance schedules. Measures maintenance program coverage across the fleet."
$$;


CREATE OR REPLACE VIEW `waste_management_ecm`.`_metrics`.`fleet_vehicle_assignment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Operational efficiency and compliance KPIs for vehicle-driver assignments. Supports shift utilization, pre/post-trip inspection compliance, HOS adherence, and safety incident tracking at the assignment level."
  source: "`waste_management_ecm`.`fleet`.`vehicle_assignment`"
  dimensions:
    - name: "assignment_status"
      expr: assignment_status
      comment: "Current status of the vehicle assignment (e.g. Active, Completed, Cancelled). Primary dimension for assignment lifecycle analysis."
    - name: "assignment_type"
      expr: assignment_type
      comment: "Type of vehicle assignment (e.g. Regular Route, Emergency, Training). Used to segment operational activity by assignment purpose."
    - name: "pre_trip_inspection_completed"
      expr: pre_trip_inspection_completed
      comment: "Indicates whether the pre-trip inspection was completed before the assignment. Pre-trip inspection completion is a DOT regulatory requirement."
    - name: "post_trip_inspection_completed"
      expr: post_trip_inspection_completed
      comment: "Indicates whether the post-trip inspection was completed after the assignment. Post-trip inspection completion is required for DVIR compliance."
    - name: "hos_compliant"
      expr: hos_compliant
      comment: "Indicates whether the assignment was completed in HOS compliance. Non-compliant assignments represent DOT violations and driver safety risks."
    - name: "safety_incident_occurred"
      expr: safety_incident_occurred
      comment: "Indicates whether a safety incident occurred during the assignment. Used to correlate assignment characteristics with safety outcomes."
    - name: "defects_reported"
      expr: defects_reported
      comment: "Indicates whether vehicle defects were reported during the assignment. Defect reporting compliance is a DVIR regulatory requirement."
    - name: "assignment_date_month"
      expr: DATE_TRUNC('MONTH', assignment_date)
      comment: "Month of the vehicle assignment. Enables trend analysis of fleet utilization and compliance rates over time."
    - name: "cdl_verified"
      expr: cdl_verified
      comment: "Indicates whether the driver CDL was verified before the assignment. CDL verification is a compliance requirement for CMV operations."
  measures:
    - name: "total_assignments"
      expr: COUNT(1)
      comment: "Total number of vehicle assignments. Baseline metric for fleet utilization and operational activity volume."
    - name: "assignments_missing_pre_trip_inspection"
      expr: COUNT(CASE WHEN pre_trip_inspection_completed = FALSE OR pre_trip_inspection_completed IS NULL THEN 1 END)
      comment: "Number of assignments where the pre-trip inspection was not completed. Pre-trip inspection non-compliance is a DOT violation and safety risk."
    - name: "assignments_missing_post_trip_inspection"
      expr: COUNT(CASE WHEN post_trip_inspection_completed = FALSE OR post_trip_inspection_completed IS NULL THEN 1 END)
      comment: "Number of assignments where the post-trip inspection was not completed. Post-trip DVIR completion is a federal regulatory requirement."
    - name: "hos_non_compliant_assignments"
      expr: COUNT(CASE WHEN hos_compliant = FALSE THEN 1 END)
      comment: "Number of assignments completed out of HOS compliance. HOS violations at the assignment level directly impact CSA scores and driver qualification."
    - name: "assignments_with_safety_incidents"
      expr: COUNT(CASE WHEN safety_incident_occurred = TRUE THEN 1 END)
      comment: "Number of assignments where a safety incident occurred. Tracks safety incident frequency at the operational assignment level."
    - name: "total_odometer_miles_driven"
      expr: SUM(CAST(odometer_end AS DOUBLE) - CAST(odometer_start AS DOUBLE))
      comment: "Total miles driven across all assignments (odometer end minus start). Measures fleet utilization in miles and supports IFTA mileage reporting."
    - name: "total_engine_hours_used"
      expr: SUM(CAST(engine_hours_end AS DOUBLE) - CAST(engine_hours_start AS DOUBLE))
      comment: "Total engine hours consumed across all assignments. Used for engine-hour-based maintenance scheduling and fleet utilization analysis."
    - name: "avg_fuel_level_change_percent"
      expr: AVG(CAST(fuel_level_end_percent AS DOUBLE) - CAST(fuel_level_start_percent AS DOUBLE))
      comment: "Average fuel level change per assignment (end minus start, typically negative). Measures per-assignment fuel consumption patterns for efficiency benchmarking."
    - name: "assignments_with_defects_reported"
      expr: COUNT(CASE WHEN defects_reported = TRUE THEN 1 END)
      comment: "Number of assignments where vehicle defects were reported. Defect reporting rate measures driver compliance with DVIR requirements and fleet condition awareness."
    - name: "distinct_vehicles_assigned"
      expr: COUNT(DISTINCT vehicle_id)
      comment: "Number of distinct vehicles that received assignments. Measures active fleet utilization breadth."
    - name: "distinct_drivers_assigned"
      expr: COUNT(DISTINCT driver_id)
      comment: "Number of distinct drivers who received vehicle assignments. Measures active driver workforce utilization."
$$;


CREATE OR REPLACE VIEW `waste_management_ecm`.`_metrics`.`fleet_pre_post_trip_inspection`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "DVIR (Driver Vehicle Inspection Report) compliance and defect KPIs. Supports DOT pre/post-trip inspection compliance, defect severity tracking, and vehicle condition monitoring."
  source: "`waste_management_ecm`.`fleet`.`pre_post_trip_inspection`"
  dimensions:
    - name: "inspection_type"
      expr: inspection_type
      comment: "Type of inspection (e.g. Pre-Trip, Post-Trip). Distinguishes pre-departure from post-return inspections for compliance analysis."
    - name: "defect_reported_flag"
      expr: defect_reported_flag
      comment: "Indicates whether a defect was reported during the inspection. Defect reporting rate measures driver diligence and vehicle condition."
    - name: "defect_severity"
      expr: defect_severity
      comment: "Severity of the reported defect (e.g. Minor, Major, Critical). Drives prioritization of maintenance work orders and OOS decisions."
    - name: "out_of_service_flag"
      expr: out_of_service_flag
      comment: "Indicates whether the vehicle was placed out of service based on inspection findings. OOS events directly impact fleet availability."
    - name: "inspection_date_month"
      expr: DATE_TRUNC('MONTH', inspection_date)
      comment: "Month of the inspection. Enables trend analysis of defect rates and inspection compliance over time."
    - name: "brakes_status"
      expr: brakes_status
      comment: "Status of the brakes system during inspection (e.g. Pass, Fail, Defective). Brake defects are a leading cause of vehicle OOS orders and accidents."
    - name: "tires_status"
      expr: tires_status
      comment: "Status of tires during inspection. Tire defects are a frequent OOS violation category and safety risk."
    - name: "lights_status"
      expr: lights_status
      comment: "Status of vehicle lights during inspection. Lighting defects are a common DOT citation category."
  measures:
    - name: "total_inspections"
      expr: COUNT(1)
      comment: "Total number of pre/post-trip inspections completed. Baseline compliance volume metric for DVIR program monitoring."
    - name: "inspections_with_defects"
      expr: COUNT(CASE WHEN defect_reported_flag = TRUE THEN 1 END)
      comment: "Number of inspections where defects were reported. Defect discovery rate measures fleet condition and inspection thoroughness."
    - name: "vehicles_placed_out_of_service"
      expr: COUNT(CASE WHEN out_of_service_flag = TRUE THEN 1 END)
      comment: "Number of inspections resulting in a vehicle OOS order. OOS events remove vehicles from service and directly impact collection capacity."
    - name: "avg_odometer_reading"
      expr: AVG(CAST(odometer_reading AS DOUBLE))
      comment: "Average odometer reading at time of inspection. Used to track fleet mileage accumulation and correlate mileage with defect rates."
    - name: "distinct_vehicles_inspected"
      expr: COUNT(DISTINCT vehicle_id)
      comment: "Number of distinct vehicles that received pre/post-trip inspections. Measures DVIR program coverage across the active fleet."
    - name: "distinct_drivers_conducting_inspections"
      expr: COUNT(DISTINCT driver_id)
      comment: "Number of distinct drivers conducting inspections. Measures driver participation in the DVIR compliance program."
$$;
