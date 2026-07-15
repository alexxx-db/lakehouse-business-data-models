-- Metric views for domain: flight | Business: Airlines | Version: 1 | Generated on: 2026-05-07 15:08:57

CREATE OR REPLACE VIEW `airlines_ecm`.`_metrics`.`flight_leg`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core operational KPIs for executed flight legs, covering on-time performance, block hours, fuel efficiency, and flight completion rates. Used by Operations Control, Network Planning, and executive leadership to steer daily and strategic flight operations."
  source: "`airlines_ecm`.`flight`.`flight_leg`"
  dimensions:
    - name: "operating_date"
      expr: operating_date
      comment: "Calendar date the flight leg operated, used for daily/weekly/monthly trend analysis."
    - name: "origin_airport_code"
      expr: origin_airport_code
      comment: "IATA code of the departure airport, enabling route-level and hub performance analysis."
    - name: "destination_airport_code"
      expr: destination_airport_code
      comment: "IATA code of the arrival airport, enabling route-level and hub performance analysis."
    - name: "flight_status"
      expr: flight_status
      comment: "Operational status of the flight leg (e.g. ON_TIME, DELAYED, CANCELLED, DIVERTED), the primary OTP classification dimension."
    - name: "aircraft_registration"
      expr: aircraft_registration
      comment: "Tail number of the operating aircraft, enabling tail-level reliability and utilisation analysis."
    - name: "departure_terminal"
      expr: departure_terminal
      comment: "Departure terminal at the origin airport, used for ground operations analysis."
    - name: "arrival_terminal"
      expr: arrival_terminal
      comment: "Arrival terminal at the destination airport, used for ground operations analysis."
    - name: "is_codeshare"
      expr: is_codeshare
      comment: "Indicates whether the flight leg is operated under a codeshare agreement, enabling partner vs. own-metal performance comparison."
    - name: "delay_code"
      expr: delay_code
      comment: "Primary IATA delay code attributed to the flight leg, used for root-cause delay analysis."
    - name: "cancellation_reason_code"
      expr: cancellation_reason_code
      comment: "Reason code for flight cancellation, used for controllability and regulatory reporting analysis."
    - name: "diversion_airport_code"
      expr: diversion_airport_code
      comment: "ICAO/IATA code of the airport to which the flight was diverted, if applicable."
    - name: "status_source"
      expr: status_source
      comment: "System or data source that provided the flight status update (e.g. ACARS, OCC, GDS)."
  measures:
    - name: "total_flight_legs"
      expr: COUNT(1)
      comment: "Total number of flight legs operated. Baseline volume metric for network capacity and completion rate calculations."
    - name: "total_block_hours"
      expr: SUM(CAST(block_hours AS DOUBLE))
      comment: "Total block hours across all flight legs. Primary measure of aircraft utilisation and a key cost driver for crew, maintenance, and fuel planning."
    - name: "avg_block_hours_per_leg"
      expr: AVG(CAST(block_hours AS DOUBLE))
      comment: "Average block hours per flight leg. Used to benchmark route efficiency and detect schedule padding or compression."
    - name: "total_airborne_hours"
      expr: SUM(CAST(airborne_time_hours AS DOUBLE))
      comment: "Total airborne (wheels-up to wheels-down) hours. Compared against block hours to measure ground time efficiency."
    - name: "avg_airborne_hours_per_leg"
      expr: AVG(CAST(airborne_time_hours AS DOUBLE))
      comment: "Average airborne hours per flight leg. Indicates actual en-route efficiency versus scheduled flight time."
    - name: "total_fuel_uplift_kg"
      expr: SUM(CAST(fuel_uplift_kg AS DOUBLE))
      comment: "Total fuel uplifted across all flight legs in kilograms. Direct input to fuel cost, emissions, and efficiency KPIs."
    - name: "avg_fuel_uplift_kg_per_leg"
      expr: AVG(CAST(fuel_uplift_kg AS DOUBLE))
      comment: "Average fuel uplift per flight leg. Used to benchmark fuel efficiency by route, aircraft type, and season."
    - name: "cancelled_flight_legs"
      expr: COUNT(CASE WHEN flight_status = 'CANCELLED' THEN 1 END)
      comment: "Number of cancelled flight legs. Directly impacts revenue, passenger satisfaction, and DOT/regulatory reporting obligations."
    - name: "diverted_flight_legs"
      expr: COUNT(CASE WHEN flight_status = 'DIVERTED' THEN 1 END)
      comment: "Number of diverted flight legs. Indicator of safety events, weather disruptions, and irregular operations severity."
    - name: "on_time_flight_legs"
      expr: COUNT(CASE WHEN flight_status = 'ON_TIME' THEN 1 END)
      comment: "Number of flight legs that departed or arrived on time per OTP definition. Numerator for on-time performance rate."
    - name: "distinct_routes_operated"
      expr: COUNT(DISTINCT CONCAT(origin_airport_code, '-', destination_airport_code))
      comment: "Number of distinct origin-destination route pairs operated. Measures network breadth and route coverage."
    - name: "distinct_aircraft_operated"
      expr: COUNT(DISTINCT aircraft_registration)
      comment: "Number of distinct aircraft tail numbers that operated at least one flight leg. Measures active fleet utilisation."
$$;


CREATE OR REPLACE VIEW `airlines_ecm`.`_metrics`.`flight_cancellation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs for flight cancellation events, covering financial impact, passenger disruption, controllability, and regulatory compliance. Used by Operations, Revenue Management, Customer Experience, and Regulatory Affairs teams."
  source: "`airlines_ecm`.`flight`.`cancellation`"
  dimensions:
    - name: "cancellation_type"
      expr: cancellation_type
      comment: "Classification of the cancellation (e.g. WEATHER, MECHANICAL, CREW, ATC), used for root-cause and controllability analysis."
    - name: "reason_code"
      expr: reason_code
      comment: "Standardised reason code for the cancellation, aligned to IATA delay/cancellation coding standards."
    - name: "is_controllable"
      expr: is_controllable
      comment: "Indicates whether the cancellation was within the airline's control, critical for regulatory liability and compensation eligibility."
    - name: "is_dot_reportable"
      expr: is_dot_reportable
      comment: "Flags cancellations that must be reported to the DOT, used for regulatory compliance tracking."
    - name: "compensation_eligibility_status"
      expr: compensation_eligibility_status
      comment: "Passenger compensation eligibility status (e.g. ELIGIBLE, NOT_ELIGIBLE), used for cost forecasting and customer care operations."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which financial impact amounts are denominated."
    - name: "notification_method"
      expr: notification_method
      comment: "Channel used to notify passengers of the cancellation (e.g. SMS, EMAIL, APP), used for customer communication effectiveness analysis."
    - name: "weather_condition_code"
      expr: weather_condition_code
      comment: "Weather condition code associated with the cancellation, used for meteorological disruption analysis."
    - name: "atc_restriction_type"
      expr: atc_restriction_type
      comment: "Type of ATC restriction that contributed to the cancellation, used for airspace management analysis."
    - name: "network_optimization_flag"
      expr: network_optimization_flag
      comment: "Indicates whether the cancellation was a proactive network optimisation decision rather than a reactive disruption response."
    - name: "regulatory_report_submitted_flag"
      expr: regulatory_report_submitted_flag
      comment: "Indicates whether the required regulatory report has been submitted for this cancellation event."
  measures:
    - name: "total_cancellations"
      expr: COUNT(1)
      comment: "Total number of flight cancellation events. Baseline volume metric for disruption management and OTP reporting."
    - name: "controllable_cancellations"
      expr: COUNT(CASE WHEN is_controllable = TRUE THEN 1 END)
      comment: "Number of cancellations within the airline's operational control. Drives compensation liability and internal accountability."
    - name: "dot_reportable_cancellations"
      expr: COUNT(CASE WHEN is_dot_reportable = TRUE THEN 1 END)
      comment: "Number of cancellations requiring DOT regulatory reporting. Critical for compliance monitoring and penalty avoidance."
    - name: "total_estimated_revenue_impact"
      expr: SUM(CAST(estimated_revenue_impact_amount AS DOUBLE))
      comment: "Total estimated revenue impact from all cancellations. Key financial KPI for disruption cost quantification and recovery prioritisation."
    - name: "total_compensation_per_passenger"
      expr: SUM(CAST(compensation_amount_per_passenger AS DOUBLE))
      comment: "Sum of per-passenger compensation amounts across all cancellation events. Used to forecast and control passenger care costs."
    - name: "avg_compensation_per_passenger"
      expr: AVG(CAST(compensation_amount_per_passenger AS DOUBLE))
      comment: "Average compensation amount per passenger per cancellation event. Benchmarks compensation spend against policy thresholds."
    - name: "total_passenger_care_cost"
      expr: SUM(CAST(passenger_care_cost_amount AS DOUBLE))
      comment: "Total passenger care costs (hotels, meals, rebooking) incurred across all cancellations. Direct operational cost KPI."
    - name: "avg_advance_notice_hours"
      expr: AVG(CAST(advance_notice_hours AS DOUBLE))
      comment: "Average hours of advance notice given before cancellation. Longer notice reduces compensation liability and improves passenger experience."
    - name: "regulatory_report_compliance_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN regulatory_report_submitted_flag = TRUE THEN 1 END) / NULLIF(COUNT(CASE WHEN is_dot_reportable = TRUE THEN 1 END), 0), 2)
      comment: "Percentage of DOT-reportable cancellations for which a regulatory report has been submitted. Measures compliance with reporting obligations."
$$;


CREATE OR REPLACE VIEW `airlines_ecm`.`_metrics`.`flight_delay_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Operational KPIs for flight delay events, covering delay cost, controllability, reactionary propagation, and DOT compliance. Used by Operations Control, Regulatory Affairs, and executive leadership for OTP management."
  source: "`airlines_ecm`.`flight`.`delay_record`"
  dimensions:
    - name: "primary_delay_code"
      expr: primary_delay_code
      comment: "Primary IATA delay code for the delay event, used for root-cause analysis and industry benchmarking."
    - name: "delay_category"
      expr: delay_category
      comment: "High-level category of the delay (e.g. WEATHER, TECHNICAL, CREW, ATC, TURNAROUND), used for executive-level disruption reporting."
    - name: "is_controllable_delay"
      expr: is_controllable_delay
      comment: "Indicates whether the delay was within the airline's operational control, driving accountability and compensation liability."
    - name: "is_reactionary_delay"
      expr: is_reactionary_delay
      comment: "Indicates whether the delay was caused by a late-arriving inbound aircraft or crew, used to measure delay propagation across the network."
    - name: "is_reportable_to_dot"
      expr: is_reportable_to_dot
      comment: "Flags delays that must be reported to the DOT (typically 15+ minutes), used for regulatory compliance tracking."
    - name: "delay_status"
      expr: delay_status
      comment: "Current status of the delay record (e.g. OPEN, CLOSED, VERIFIED), used for operational workflow management."
    - name: "responsible_department_code"
      expr: responsible_department_code
      comment: "Department accountable for the delay (e.g. MAINTENANCE, GROUND_OPS, CREW_SCHEDULING), used for internal accountability reporting."
    - name: "data_source_system"
      expr: data_source_system
      comment: "Source system that recorded the delay event, used for data quality and lineage analysis."
    - name: "compensation_issued_flag"
      expr: compensation_issued_flag
      comment: "Indicates whether passenger compensation was issued for this delay, used for cost tracking and policy compliance."
  measures:
    - name: "total_delay_events"
      expr: COUNT(1)
      comment: "Total number of delay events recorded. Baseline volume metric for OTP and disruption management reporting."
    - name: "controllable_delay_events"
      expr: COUNT(CASE WHEN is_controllable_delay = TRUE THEN 1 END)
      comment: "Number of delays within the airline's operational control. Drives internal accountability and compensation liability assessment."
    - name: "reactionary_delay_events"
      expr: COUNT(CASE WHEN is_reactionary_delay = TRUE THEN 1 END)
      comment: "Number of reactionary (knock-on) delay events. Measures delay propagation severity across the network schedule."
    - name: "dot_reportable_delay_events"
      expr: COUNT(CASE WHEN is_reportable_to_dot = TRUE THEN 1 END)
      comment: "Number of delays meeting DOT reporting thresholds. Critical for regulatory compliance and penalty risk management."
    - name: "total_delay_cost_usd"
      expr: SUM(CAST(delay_cost_estimate_usd AS DOUBLE))
      comment: "Total estimated cost of all delay events in USD. Primary financial KPI for disruption cost management and budget forecasting."
    - name: "avg_delay_cost_usd"
      expr: AVG(CAST(delay_cost_estimate_usd AS DOUBLE))
      comment: "Average cost per delay event in USD. Used to benchmark delay cost efficiency and prioritise cost-reduction initiatives."
    - name: "compensation_issued_events"
      expr: COUNT(CASE WHEN compensation_issued_flag = TRUE THEN 1 END)
      comment: "Number of delay events for which passenger compensation was issued. Used to track compensation spend and policy adherence."
    - name: "reactionary_delay_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_reactionary_delay = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of total delay events that are reactionary (knock-on). High rates indicate systemic schedule recovery issues."
    - name: "controllable_delay_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_controllable_delay = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of delay events that are within the airline's control. Key accountability metric for operational leadership."
$$;


CREATE OR REPLACE VIEW `airlines_ecm`.`_metrics`.`flight_fuel_uplift`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Fuel procurement and consumption KPIs covering uplift volumes, costs, carbon emissions, and pricing efficiency. Used by Fuel Management, Finance, and Sustainability teams to control one of the airline's largest cost line items."
  source: "`airlines_ecm`.`flight`.`fuel_uplift`"
  dimensions:
    - name: "fuel_type"
      expr: fuel_type
      comment: "Type of fuel uplifted (e.g. JET-A, SAF), used for sustainability and cost analysis by fuel grade."
    - name: "aircraft_registration"
      expr: aircraft_registration
      comment: "Tail number of the aircraft fuelled, enabling tail-level fuel efficiency analysis."
    - name: "fuel_price_currency"
      expr: fuel_price_currency
      comment: "Currency of the fuel price, used for multi-currency cost normalisation."
    - name: "payment_method"
      expr: payment_method
      comment: "Payment method used for fuel procurement (e.g. CREDIT, PREPAID, SPOT), used for procurement strategy analysis."
    - name: "fuel_uplift_status"
      expr: fuel_uplift_status
      comment: "Status of the fuel uplift record (e.g. CONFIRMED, PENDING, DISPUTED), used for invoice reconciliation."
    - name: "into_plane_agent"
      expr: into_plane_agent
      comment: "Into-plane fuelling agent or supplier, used for vendor performance and cost benchmarking."
  measures:
    - name: "total_fuel_quantity_kg"
      expr: SUM(CAST(fuel_quantity_kg AS DOUBLE))
      comment: "Total fuel uplifted in kilograms across all uplift events. Primary volume metric for fuel consumption and cost management."
    - name: "avg_fuel_quantity_kg"
      expr: AVG(CAST(fuel_quantity_kg AS DOUBLE))
      comment: "Average fuel uplift per event in kilograms. Used to benchmark uplift efficiency by route, aircraft type, and station."
    - name: "total_fuel_cost"
      expr: SUM(CAST(total_fuel_cost AS DOUBLE))
      comment: "Total fuel procurement cost across all uplift events. One of the airline's largest operating cost KPIs, directly impacting CASM."
    - name: "avg_fuel_price_per_unit"
      expr: AVG(CAST(fuel_price_per_unit AS DOUBLE))
      comment: "Average fuel price per unit across all uplift events. Used to monitor procurement efficiency and hedge effectiveness."
    - name: "total_carbon_emission_kg"
      expr: SUM(CAST(carbon_emission_kg AS DOUBLE))
      comment: "Total carbon emissions in kilograms from all fuel uplift events. Core sustainability KPI for ESG reporting and carbon offset planning."
    - name: "avg_carbon_emission_kg"
      expr: AVG(CAST(carbon_emission_kg AS DOUBLE))
      comment: "Average carbon emissions per uplift event. Used to benchmark emissions efficiency and track SAF adoption impact."
    - name: "total_fuel_surcharge"
      expr: SUM(CAST(fuel_surcharge_amount AS DOUBLE))
      comment: "Total fuel surcharge amounts paid across all uplift events. Tracked separately to assess surcharge cost burden and recovery via passenger fuel surcharges."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amounts on fuel procurement. Used for tax reclaim, cost allocation, and regulatory compliance."
    - name: "distinct_fuelling_stations"
      expr: COUNT(DISTINCT station_id)
      comment: "Number of distinct stations where fuel was uplifted. Measures geographic procurement footprint and supplier diversification."
    - name: "total_uplift_events"
      expr: COUNT(1)
      comment: "Total number of fuel uplift events. Baseline volume metric for procurement activity and operational tempo."
$$;


CREATE OR REPLACE VIEW `airlines_ecm`.`_metrics`.`flight_irop_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Irregular Operations (IROP) event KPIs covering financial impact, passenger disruption, flight cancellations/delays/diversions, and recovery effectiveness. Used by Operations Control, Customer Experience, and executive leadership to manage and minimise disruption impact."
  source: "`airlines_ecm`.`flight`.`irop_event`"
  dimensions:
    - name: "event_type"
      expr: event_type
      comment: "Type of IROP event (e.g. WEATHER, ATC, TECHNICAL, SECURITY), used for root-cause and category-level disruption analysis."
    - name: "event_status"
      expr: event_status
      comment: "Current status of the IROP event (e.g. ACTIVE, RESOLVED, MONITORING), used for real-time operations management."
    - name: "severity_level"
      expr: severity_level
      comment: "Severity classification of the IROP event (e.g. LOW, MEDIUM, HIGH, CRITICAL), used for escalation and resource prioritisation."
    - name: "responsible_department"
      expr: responsible_department
      comment: "Department accountable for managing the IROP event, used for internal accountability and response time analysis."
    - name: "recovery_plan_status"
      expr: recovery_plan_status
      comment: "Status of the recovery plan for the IROP event (e.g. DRAFT, APPROVED, EXECUTING, COMPLETE), used for recovery effectiveness tracking."
    - name: "passenger_compensation_triggered_flag"
      expr: passenger_compensation_triggered_flag
      comment: "Indicates whether passenger compensation was triggered by this IROP event, used for cost liability tracking."
    - name: "regulatory_notification_required_flag"
      expr: regulatory_notification_required_flag
      comment: "Indicates whether regulatory notification is required for this IROP event, used for compliance monitoring."
    - name: "event_code"
      expr: event_code
      comment: "Standardised event code for the IROP, used for industry benchmarking and internal categorisation."
  measures:
    - name: "total_irop_events"
      expr: COUNT(1)
      comment: "Total number of IROP events. Baseline disruption volume metric for operational resilience reporting."
    - name: "total_estimated_financial_impact"
      expr: SUM(CAST(estimated_financial_impact_amount AS DOUBLE))
      comment: "Total estimated financial impact of all IROP events. Primary cost KPI for disruption management and insurance/risk reporting."
    - name: "avg_estimated_financial_impact"
      expr: AVG(CAST(estimated_financial_impact_amount AS DOUBLE))
      comment: "Average financial impact per IROP event. Used to benchmark disruption cost severity and prioritise mitigation investments."
    - name: "compensation_triggered_events"
      expr: COUNT(CASE WHEN passenger_compensation_triggered_flag = TRUE THEN 1 END)
      comment: "Number of IROP events that triggered passenger compensation. Drives compensation cost forecasting and policy review."
    - name: "regulatory_notification_required_events"
      expr: COUNT(CASE WHEN regulatory_notification_required_flag = TRUE THEN 1 END)
      comment: "Number of IROP events requiring regulatory notification. Critical for compliance risk management."
    - name: "compensation_trigger_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN passenger_compensation_triggered_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of IROP events that triggered passenger compensation. Measures disruption severity and compensation cost exposure rate."
    - name: "distinct_affected_routes"
      expr: COUNT(DISTINCT route_id)
      comment: "Number of distinct routes affected by IROP events. Measures network-wide disruption breadth for recovery planning."
$$;


CREATE OR REPLACE VIEW `airlines_ecm`.`_metrics`.`flight_dispatch_release`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Dispatch release KPIs covering fuel planning accuracy, weight management, ETOPS authorisation, and hazmat compliance. Used by Dispatch, Safety, and Operations leadership to ensure regulatory compliance and operational safety."
  source: "`airlines_ecm`.`flight`.`dispatch_release`"
  dimensions:
    - name: "release_status"
      expr: release_status
      comment: "Status of the dispatch release (e.g. ISSUED, SUPERSEDED, CANCELLED), used for release lifecycle and compliance tracking."
    - name: "aircraft_type"
      expr: aircraft_type
      comment: "Aircraft type for which the dispatch release was issued, used for fleet-level fuel and weight analysis."
    - name: "departure_airport_icao"
      expr: departure_airport_icao
      comment: "ICAO code of the departure airport, used for station-level dispatch performance analysis."
    - name: "destination_airport_icao"
      expr: destination_airport_icao
      comment: "ICAO code of the destination airport, used for route-level fuel planning analysis."
    - name: "etops_authorization_flag"
      expr: etops_authorization_flag
      comment: "Indicates whether the flight was authorised for ETOPS operations, used for long-haul regulatory compliance tracking."
    - name: "hazmat_onboard_flag"
      expr: hazmat_onboard_flag
      comment: "Indicates whether hazardous materials were declared onboard, used for safety and regulatory compliance monitoring."
    - name: "regulatory_authority"
      expr: regulatory_authority
      comment: "Regulatory authority under which the dispatch release was issued (e.g. FAA, EASA), used for multi-authority compliance analysis."
  measures:
    - name: "total_dispatch_releases"
      expr: COUNT(1)
      comment: "Total number of dispatch releases issued. Baseline volume metric for dispatch operations activity."
    - name: "etops_authorised_releases"
      expr: COUNT(CASE WHEN etops_authorization_flag = TRUE THEN 1 END)
      comment: "Number of dispatch releases with ETOPS authorisation. Measures long-haul regulatory compliance and ETOPS operational tempo."
    - name: "hazmat_onboard_releases"
      expr: COUNT(CASE WHEN hazmat_onboard_flag = TRUE THEN 1 END)
      comment: "Number of dispatch releases with hazardous materials declared. Used for safety compliance monitoring and incident risk assessment."
    - name: "total_planned_fuel_uplift_kg"
      expr: SUM(CAST(planned_fuel_uplift_kg AS DOUBLE))
      comment: "Total planned fuel uplift across all dispatch releases in kilograms. Used to compare planned vs. actual fuel consumption for efficiency analysis."
    - name: "avg_planned_fuel_uplift_kg"
      expr: AVG(CAST(planned_fuel_uplift_kg AS DOUBLE))
      comment: "Average planned fuel uplift per dispatch release. Benchmarks fuel planning accuracy by route and aircraft type."
    - name: "total_trip_fuel_kg"
      expr: SUM(CAST(trip_fuel_kg AS DOUBLE))
      comment: "Total trip fuel planned across all dispatch releases. Core fuel efficiency KPI for route and fleet planning."
    - name: "total_contingency_fuel_kg"
      expr: SUM(CAST(contingency_fuel_kg AS DOUBLE))
      comment: "Total contingency fuel planned across all dispatch releases. Measures conservatism in fuel planning and its cost impact."
    - name: "avg_takeoff_weight_kg"
      expr: AVG(CAST(takeoff_weight_kg AS DOUBLE))
      comment: "Average planned takeoff weight per dispatch release. Used to monitor payload efficiency and structural compliance margins."
    - name: "etops_authorisation_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN etops_authorization_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of dispatch releases with ETOPS authorisation. Measures the proportion of long-haul extended operations in the network."
$$;


CREATE OR REPLACE VIEW `airlines_ecm`.`_metrics`.`flight_diversion`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Flight diversion KPIs covering financial impact, passenger care, crew duty time, and regulatory compliance. Used by Operations Control, Customer Experience, Finance, and Safety teams to manage and minimise diversion costs and passenger disruption."
  source: "`airlines_ecm`.`flight`.`diversion`"
  dimensions:
    - name: "reason_code"
      expr: reason_code
      comment: "Standardised reason code for the diversion (e.g. WEATHER, MEDICAL, TECHNICAL), used for root-cause analysis."
    - name: "diversion_status"
      expr: diversion_status
      comment: "Current status of the diversion event (e.g. ACTIVE, RESOLVED, CONTINUATION_DEPARTED), used for real-time operations tracking."
    - name: "airport_icao_code"
      expr: airport_icao_code
      comment: "ICAO code of the diversion airport, used for station-level diversion frequency and cost analysis."
    - name: "planned_destination_airport_code"
      expr: planned_destination_airport_code
      comment: "Originally planned destination airport code, used to identify which routes are most prone to diversions."
    - name: "compensation_eligibility_flag"
      expr: compensation_eligibility_flag
      comment: "Indicates whether passengers are eligible for compensation due to the diversion, used for cost liability tracking."
    - name: "crew_duty_time_impact_flag"
      expr: crew_duty_time_impact_flag
      comment: "Indicates whether the diversion caused crew duty time limit issues, used for crew legality and recovery planning."
    - name: "hotel_accommodation_provided_flag"
      expr: hotel_accommodation_provided_flag
      comment: "Indicates whether hotel accommodation was provided to passengers, used for passenger care cost tracking."
    - name: "cost_impact_currency_code"
      expr: cost_impact_currency_code
      comment: "Currency in which the cost impact is denominated, used for multi-currency financial consolidation."
    - name: "regulatory_report_required_flag"
      expr: regulatory_report_required_flag
      comment: "Indicates whether a regulatory report is required for this diversion, used for compliance monitoring."
  measures:
    - name: "total_diversions"
      expr: COUNT(1)
      comment: "Total number of flight diversions. Baseline safety and disruption metric for operational resilience reporting."
    - name: "total_estimated_cost_impact"
      expr: SUM(CAST(estimated_cost_impact_amount AS DOUBLE))
      comment: "Total estimated financial cost of all diversions. Primary cost KPI for diversion management and insurance/risk reporting."
    - name: "avg_estimated_cost_impact"
      expr: AVG(CAST(estimated_cost_impact_amount AS DOUBLE))
      comment: "Average cost impact per diversion event. Used to benchmark diversion cost severity by reason, route, and aircraft type."
    - name: "total_fuel_uplift_at_diversion_kg"
      expr: SUM(CAST(fuel_uplift_at_diversion_kg AS DOUBLE))
      comment: "Total unplanned fuel uplifted at diversion airports. Measures the direct fuel cost increment from diversion events."
    - name: "compensation_eligible_diversions"
      expr: COUNT(CASE WHEN compensation_eligibility_flag = TRUE THEN 1 END)
      comment: "Number of diversions where passengers are eligible for compensation. Drives compensation cost forecasting and customer care resource planning."
    - name: "crew_duty_time_impacted_diversions"
      expr: COUNT(CASE WHEN crew_duty_time_impact_flag = TRUE THEN 1 END)
      comment: "Number of diversions that caused crew duty time limit issues. Measures cascading operational impact on crew scheduling and recovery."
    - name: "hotel_accommodation_diversions"
      expr: COUNT(CASE WHEN hotel_accommodation_provided_flag = TRUE THEN 1 END)
      comment: "Number of diversions where hotel accommodation was provided to passengers. Used to track passenger care cost and service quality."
    - name: "regulatory_report_required_diversions"
      expr: COUNT(CASE WHEN regulatory_report_required_flag = TRUE THEN 1 END)
      comment: "Number of diversions requiring regulatory reporting. Critical for compliance risk management and penalty avoidance."
    - name: "compensation_eligibility_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN compensation_eligibility_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of diversions where passengers are eligible for compensation. Measures compensation cost exposure rate from diversion events."
$$;


CREATE OR REPLACE VIEW `airlines_ecm`.`_metrics`.`flight_weight_balance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Weight and balance KPIs covering payload efficiency, structural compliance margins, and load distribution. Used by Dispatch, Load Control, and Safety teams to ensure every flight operates within certified weight and CG limits."
  source: "`airlines_ecm`.`flight`.`weight_balance`"
  dimensions:
    - name: "aircraft_type_code"
      expr: aircraft_type_code
      comment: "Aircraft type code for the weight and balance record, used for fleet-level payload and structural analysis."
    - name: "aircraft_registration"
      expr: aircraft_registration
      comment: "Tail number of the aircraft, enabling tail-level weight and balance compliance tracking."
    - name: "loadsheet_status"
      expr: loadsheet_status
      comment: "Status of the loadsheet (e.g. PRELIMINARY, FINAL, AMENDED), used for load control workflow compliance."
    - name: "load_distribution_compliant"
      expr: load_distribution_compliant
      comment: "Indicates whether the load distribution met all structural and CG compliance requirements, used for safety monitoring."
    - name: "special_load_indicator"
      expr: special_load_indicator
      comment: "Indicates whether special load handling was required (e.g. live animals, dangerous goods), used for safety and compliance tracking."
  measures:
    - name: "total_weight_balance_records"
      expr: COUNT(1)
      comment: "Total number of weight and balance records. Baseline volume metric for load control operations activity."
    - name: "load_distribution_compliance_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN load_distribution_compliant = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of flights where load distribution was fully compliant. Critical safety KPI — non-compliance is a regulatory and airworthiness risk."
    - name: "avg_total_payload_kg"
      expr: AVG(CAST(total_payload_kg AS DOUBLE))
      comment: "Average total payload (passengers + cargo + baggage + mail) per flight. Used to benchmark payload efficiency and revenue yield per flight."
    - name: "total_payload_kg"
      expr: SUM(CAST(total_payload_kg AS DOUBLE))
      comment: "Total payload carried across all flights. Measures overall cargo and passenger load volume for revenue and capacity planning."
    - name: "avg_takeoff_weight_kg"
      expr: AVG(CAST(takeoff_weight_kg AS DOUBLE))
      comment: "Average actual takeoff weight per flight. Used to monitor structural margin utilisation and fuel burn efficiency."
    - name: "avg_landing_weight_kg"
      expr: AVG(CAST(landing_weight_kg AS DOUBLE))
      comment: "Average actual landing weight per flight. Used to verify fuel burn and structural compliance at destination."
    - name: "total_cargo_weight_kg"
      expr: SUM(CAST(cargo_weight_kg AS DOUBLE))
      comment: "Total cargo weight carried across all flights. Key revenue metric for cargo operations and belly-hold yield management."
    - name: "total_baggage_weight_kg"
      expr: SUM(CAST(baggage_weight_kg AS DOUBLE))
      comment: "Total baggage weight across all flights. Used for payload planning, fuel burn modelling, and excess baggage revenue analysis."
    - name: "avg_cg_takeoff_percent_mac"
      expr: AVG(CAST(cg_takeoff_percent_mac AS DOUBLE))
      comment: "Average centre of gravity at takeoff as a percentage of mean aerodynamic chord. Safety KPI for structural and aerodynamic compliance monitoring."
    - name: "special_load_flights"
      expr: COUNT(CASE WHEN special_load_indicator = TRUE THEN 1 END)
      comment: "Number of flights with special load handling requirements. Used for safety compliance tracking and ground handling resource planning."
$$;


CREATE OR REPLACE VIEW `airlines_ecm`.`_metrics`.`flight_scheduled_flight`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Schedule planning KPIs covering network coverage, route distance, block time, and schedule health. Used by Network Planning, Scheduling, and Revenue Management to design and optimise the published flight schedule."
  source: "`airlines_ecm`.`flight`.`scheduled_flight`"
  dimensions:
    - name: "departure_airport_code"
      expr: departure_airport_code
      comment: "IATA code of the scheduled departure airport, used for origin-level network analysis."
    - name: "arrival_airport_code"
      expr: arrival_airport_code
      comment: "IATA code of the scheduled arrival airport, used for destination-level network analysis."
    - name: "schedule_status"
      expr: schedule_status
      comment: "Status of the scheduled flight (e.g. ACTIVE, SUSPENDED, CANCELLED), used for schedule health monitoring."
    - name: "service_type"
      expr: service_type
      comment: "Type of service (e.g. PASSENGER, CARGO, CHARTER), used for fleet and revenue segmentation."
    - name: "route_network_type"
      expr: route_network_type
      comment: "Network type classification (e.g. HUB_SPOKE, POINT_TO_POINT, REGIONAL), used for network strategy analysis."
    - name: "operating_carrier_code"
      expr: operating_carrier_code
      comment: "IATA code of the operating carrier, used for own-metal vs. wet-lease vs. codeshare analysis."
    - name: "codeshare_indicator"
      expr: codeshare_indicator
      comment: "Indicates whether the scheduled flight is a codeshare, used for partner revenue and capacity analysis."
    - name: "wet_lease_indicator"
      expr: wet_lease_indicator
      comment: "Indicates whether the flight is operated under a wet lease arrangement, used for fleet cost and capacity analysis."
    - name: "etops_approval_indicator"
      expr: etops_approval_indicator
      comment: "Indicates whether the scheduled flight has ETOPS approval, used for long-haul route planning compliance."
    - name: "regulatory_approval_status"
      expr: regulatory_approval_status
      comment: "Regulatory approval status of the scheduled flight (e.g. APPROVED, PENDING, RESTRICTED), used for slot and route compliance monitoring."
    - name: "day_of_week_pattern"
      expr: day_of_week_pattern
      comment: "Days of week on which the flight operates (e.g. 1234567), used for frequency and demand pattern analysis."
  measures:
    - name: "total_scheduled_flights"
      expr: COUNT(1)
      comment: "Total number of scheduled flight records. Baseline measure of published schedule size and network capacity."
    - name: "active_scheduled_flights"
      expr: COUNT(CASE WHEN schedule_status = 'ACTIVE' THEN 1 END)
      comment: "Number of currently active scheduled flights. Measures live network capacity available for sale and operations."
    - name: "total_flight_distance_km"
      expr: SUM(CAST(flight_distance_km AS DOUBLE))
      comment: "Total scheduled route distance in kilometres across all flights. Measures network geographic reach and ASK (Available Seat Kilometres) denominator."
    - name: "avg_flight_distance_km"
      expr: AVG(CAST(flight_distance_km AS DOUBLE))
      comment: "Average scheduled route distance in kilometres. Used to characterise network stage length and benchmark against industry peers."
    - name: "distinct_routes_scheduled"
      expr: COUNT(DISTINCT CONCAT(departure_airport_code, '-', arrival_airport_code))
      comment: "Number of distinct origin-destination route pairs in the published schedule. Measures network breadth and route coverage."
    - name: "etops_approved_flights"
      expr: COUNT(CASE WHEN etops_approval_indicator = TRUE THEN 1 END)
      comment: "Number of scheduled flights with ETOPS approval. Measures long-haul network capability and regulatory compliance scope."
    - name: "codeshare_flights"
      expr: COUNT(CASE WHEN codeshare_indicator = TRUE THEN 1 END)
      comment: "Number of codeshare scheduled flights. Measures partner network contribution to total schedule capacity."
    - name: "wet_lease_flights"
      expr: COUNT(CASE WHEN wet_lease_indicator = TRUE THEN 1 END)
      comment: "Number of wet-leased scheduled flights. Measures capacity sourced externally, with implications for cost and brand risk."
$$;


CREATE OR REPLACE VIEW `airlines_ecm`.`_metrics`.`flight_booking_segment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Passenger booking segment KPIs covering boarding performance, upgrade activity, special service requests, and standby management. Used by Airport Operations, Revenue Management, and Customer Experience teams."
  source: "`airlines_ecm`.`flight`.`booking_segment`"
  dimensions:
    - name: "segment_status"
      expr: segment_status
      comment: "Status of the booking segment (e.g. CONFIRMED, BOARDED, NO_SHOW, CANCELLED), used for passenger flow and no-show analysis."
    - name: "upgrade_status"
      expr: upgrade_status
      comment: "Upgrade status of the passenger (e.g. UPGRADED, NOT_UPGRADED, WAITLISTED), used for upgrade revenue and loyalty benefit analysis."
    - name: "baggage_allowance"
      expr: baggage_allowance
      comment: "Baggage allowance tier assigned to the passenger, used for ancillary revenue and ground handling analysis."
    - name: "standby_priority"
      expr: standby_priority
      comment: "Standby priority level assigned to the passenger, used for standby management and gate operations analysis."
  measures:
    - name: "total_booking_segments"
      expr: COUNT(1)
      comment: "Total number of booking segments. Baseline passenger volume metric for capacity and load factor analysis."
    - name: "boarded_segments"
      expr: COUNT(CASE WHEN segment_status = 'BOARDED' THEN 1 END)
      comment: "Number of passengers who successfully boarded. Used to calculate actual load and compare against booked capacity."
    - name: "no_show_segments"
      expr: COUNT(CASE WHEN segment_status = 'NO_SHOW' THEN 1 END)
      comment: "Number of passenger no-shows. Drives overbooking model calibration and revenue management policy decisions."
    - name: "upgraded_segments"
      expr: COUNT(CASE WHEN upgrade_status = 'UPGRADED' THEN 1 END)
      comment: "Number of passengers who received an upgrade. Measures upgrade programme utilisation and premium cabin yield management effectiveness."
    - name: "special_service_request_segments"
      expr: COUNT(CASE WHEN special_service_requests IS NOT NULL AND special_service_requests != '' THEN 1 END)
      comment: "Number of booking segments with special service requests (e.g. wheelchair, dietary, unaccompanied minor). Used for ground handling resource planning and service quality monitoring."
    - name: "no_show_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN segment_status = 'NO_SHOW' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of booking segments that resulted in a no-show. Key input to overbooking models and revenue management strategy."
    - name: "upgrade_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN upgrade_status = 'UPGRADED' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of booking segments where the passenger was upgraded. Measures premium cabin utilisation and loyalty programme effectiveness."
    - name: "distinct_passengers"
      expr: COUNT(DISTINCT profile_id)
      comment: "Number of distinct passengers across all booking segments. Used for unique traveller volume analysis and loyalty programme reach."
$$;
