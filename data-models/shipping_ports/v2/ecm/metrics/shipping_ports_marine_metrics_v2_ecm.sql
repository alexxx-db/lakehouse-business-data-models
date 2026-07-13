-- Metric views for domain: marine | Business: Shipping_Ports | Version: 2 | Generated on: 2026-07-13 07:51:56

CREATE OR REPLACE VIEW `vibe_shipping_ports_v1`.`_metrics`.`marine_pilotage_assignment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Operational and financial KPIs for pilotage assignments — the primary revenue-generating and safety-critical marine service. Covers assignment throughput, service charge revenue, passage performance, tidal-window compliance, and incident exposure. Used by the Harbour Master, Marine Operations VP, and CFO to steer pilotage capacity, pricing, and safety."
  source: "`vibe_shipping_ports_v1`.`marine`.`pilotage_assignment`"
  dimensions:
    - name: "assignment_status"
      expr: assignment_status
      comment: "Current lifecycle status of the pilotage assignment (e.g. COMPLETED, CANCELLED, IN_PROGRESS) — primary operational filter."
    - name: "service_type"
      expr: service_type
      comment: "Type of pilotage service rendered (inbound, outbound, shifting, anchorage) — drives tariff and capacity analysis."
    - name: "billing_status"
      expr: billing_status
      comment: "Revenue collection status (UNBILLED, INVOICED, PAID) — used by Finance to track pilotage revenue pipeline."
    - name: "boarding_method"
      expr: boarding_method
      comment: "Method used to board the pilot (ladder, helicopter, launch) — safety and operational planning dimension."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which the service charge is denominated — required for multi-currency revenue reporting."
    - name: "assignment_month"
      expr: DATE_TRUNC('MONTH', actual_boarding_timestamp)
      comment: "Calendar month of actual pilot boarding — primary time grain for trend and capacity planning."
    - name: "assignment_date"
      expr: CAST(actual_boarding_timestamp AS DATE)
      comment: "Calendar date of actual pilot boarding — daily operational drill-down."
    - name: "tug_required_flag"
      expr: tug_required
      comment: "Whether tug assistance was required for this pilotage — used to correlate tug demand with pilotage volume."
    - name: "incident_reported_flag"
      expr: incident_reported
      comment: "Whether a safety incident was reported during this assignment — safety KPI dimension."
    - name: "isps_compliance_verified_flag"
      expr: isps_compliance_verified
      comment: "Whether ISPS compliance was verified at boarding — regulatory compliance dimension."
  measures:
    - name: "total_pilotage_assignments"
      expr: COUNT(1)
      comment: "Total number of pilotage assignments in the period. Core throughput KPI used by the Harbour Master to assess capacity utilisation and plan pilot rosters."
    - name: "total_pilotage_service_revenue"
      expr: SUM(CAST(service_charge_amount AS DOUBLE))
      comment: "Total pilotage service charge revenue. Primary financial KPI for the marine services P&L; tracked by CFO and Marine VP against budget."
    - name: "avg_pilotage_service_charge"
      expr: AVG(CAST(service_charge_amount AS DOUBLE))
      comment: "Average service charge per pilotage assignment. Used to monitor tariff yield and detect under-charging or tariff erosion."
    - name: "total_passage_distance_nm"
      expr: SUM(CAST(passage_distance_nm AS DOUBLE))
      comment: "Total nautical miles piloted across all assignments. Operational workload metric used for pilot fatigue management and tariff distance-band validation."
    - name: "avg_passage_distance_nm"
      expr: AVG(CAST(passage_distance_nm AS DOUBLE))
      comment: "Average passage distance per assignment. Benchmarks route complexity and informs tidal-window scheduling."
    - name: "avg_min_ukc_recorded_m"
      expr: AVG(CAST(min_ukc_recorded_m AS DOUBLE))
      comment: "Average minimum under-keel clearance recorded during pilotage. Critical safety KPI; values approaching zero trigger immediate Harbour Master review."
    - name: "incident_reported_count"
      expr: SUM(CAST(CASE WHEN incident_reported = TRUE THEN 1 ELSE 0 END AS INT))
      comment: "Number of pilotage assignments where a safety incident was reported. Key safety KPI for the HSE function and P&I club reporting."
    - name: "incident_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(CASE WHEN incident_reported = TRUE THEN 1 ELSE 0 END AS INT)) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of pilotage assignments resulting in a reported incident. Safety performance indicator tracked against IMO and port authority benchmarks."
    - name: "deviation_from_passage_plan_count"
      expr: SUM(CAST(CASE WHEN deviation_from_passage_plan = TRUE THEN 1 ELSE 0 END AS INT))
      comment: "Number of assignments where the pilot deviated from the approved passage plan. Navigational safety KPI; high counts trigger passage-plan review."
    - name: "tidal_window_utilisation_count"
      expr: SUM(CAST(CASE WHEN tidal_window_start IS NOT NULL AND tidal_window_end IS NOT NULL THEN 1 ELSE 0 END AS INT))
      comment: "Number of assignments that operated within a defined tidal window. Measures tidal-dependency exposure and scheduling efficiency."
    - name: "avg_speed_over_ground_knots"
      expr: AVG(CAST(speed_over_ground_avg_knots AS DOUBLE))
      comment: "Average speed over ground across pilotage passages. Used to validate compliance with channel speed limits and assess passage efficiency."
    - name: "distinct_vessels_piloted"
      expr: COUNT(DISTINCT vessel_id)
      comment: "Number of distinct vessels receiving pilotage services. Measures market reach and vessel call diversity for the port."
    - name: "distinct_pilots_active"
      expr: COUNT(DISTINCT pilot_id)
      comment: "Number of distinct pilots who completed at least one assignment. Used for roster utilisation and capacity planning."
    - name: "isps_non_compliance_count"
      expr: SUM(CAST(CASE WHEN isps_compliance_verified = FALSE THEN 1 ELSE 0 END AS INT))
      comment: "Number of assignments where ISPS compliance was not verified. Regulatory risk KPI reported to the Port Facility Security Officer."
    - name: "pi_club_notified_count"
      expr: SUM(CAST(CASE WHEN pi_club_notified = TRUE THEN 1 ELSE 0 END AS INT))
      comment: "Number of assignments triggering P&I club notification. Liability exposure indicator tracked by the port legal and insurance team."
$$;

CREATE OR REPLACE VIEW `vibe_shipping_ports_v1`.`_metrics`.`marine_towage_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Financial and operational KPIs for towage orders — the second-largest marine services revenue stream. Covers towage revenue, tug utilisation, service outcomes, safety observations, and hazmat exposure. Used by Marine Operations VP, CFO, and HSE Manager."
  source: "`vibe_shipping_ports_v1`.`marine`.`towage_order`"
  dimensions:
    - name: "order_status"
      expr: order_status
      comment: "Lifecycle status of the towage order (REQUESTED, CONFIRMED, COMPLETED, ABORTED, CANCELLED)."
    - name: "towage_type"
      expr: towage_type
      comment: "Type of towage service (berthing assist, unberthing assist, escort, harbour tow, ocean tow) — primary tariff and capacity dimension."
    - name: "billing_status"
      expr: billing_status
      comment: "Revenue collection status — used by Finance to track towage revenue pipeline."
    - name: "service_outcome"
      expr: service_outcome
      comment: "Outcome of the towage service (SUCCESSFUL, ABORTED, PARTIAL) — quality and safety dimension."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the towage charge — required for multi-currency revenue reporting."
    - name: "imdg_hazmat_flag"
      expr: imdg_hazmat_flag
      comment: "Whether the vessel carried IMDG hazardous materials — risk and safety planning dimension."
    - name: "safety_observation_flag"
      expr: safety_observation_flag
      comment: "Whether a safety observation was raised during the towage — HSE monitoring dimension."
    - name: "order_month"
      expr: DATE_TRUNC('MONTH', requested_timestamp)
      comment: "Calendar month the towage was requested — primary time grain for trend analysis."
    - name: "order_date"
      expr: CAST(requested_timestamp AS DATE)
      comment: "Date the towage was requested — daily operational drill-down."
  measures:
    - name: "total_towage_orders"
      expr: COUNT(1)
      comment: "Total towage orders in the period. Core throughput KPI for tug fleet capacity planning and revenue forecasting."
    - name: "total_towage_revenue"
      expr: SUM(CAST(towage_charge_amount AS DOUBLE))
      comment: "Total towage charge revenue. Primary financial KPI for the marine services P&L."
    - name: "avg_towage_charge"
      expr: AVG(CAST(towage_charge_amount AS DOUBLE))
      comment: "Average towage charge per order. Used to monitor tariff yield and detect under-charging."
    - name: "aborted_order_count"
      expr: SUM(CAST(CASE WHEN order_status = 'ABORTED' THEN 1 ELSE 0 END AS INT))
      comment: "Number of towage orders that were aborted. Operational quality KPI; high abort rates indicate tug availability or weather issues."
    - name: "abort_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(CASE WHEN order_status = 'ABORTED' THEN 1 ELSE 0 END AS INT)) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of towage orders aborted. Service reliability KPI tracked by Marine Operations VP."
    - name: "avg_min_bollard_pull_required_tonnes"
      expr: AVG(CAST(min_bollard_pull_tonnes AS DOUBLE))
      comment: "Average minimum bollard pull required across towage orders. Informs tug fleet capability planning and procurement decisions."
    - name: "hazmat_towage_count"
      expr: SUM(CAST(CASE WHEN imdg_hazmat_flag = TRUE THEN 1 ELSE 0 END AS INT))
      comment: "Number of towage operations involving IMDG hazardous cargo vessels. Risk exposure KPI for HSE and P&I club reporting."
    - name: "safety_observation_count"
      expr: SUM(CAST(CASE WHEN safety_observation_flag = TRUE THEN 1 ELSE 0 END AS INT))
      comment: "Number of towage operations where a safety observation was raised. HSE leading indicator tracked against zero-harm targets."
    - name: "distinct_vessels_towed"
      expr: COUNT(DISTINCT vessel_id)
      comment: "Number of distinct vessels receiving towage services. Measures market reach and vessel call diversity."
    - name: "avg_current_speed_knots"
      expr: AVG(CAST(current_speed_knots AS DOUBLE))
      comment: "Average current speed at time of towage. Environmental context metric used to correlate difficult conditions with abort rates and safety observations."
$$;

CREATE OR REPLACE VIEW `vibe_shipping_ports_v1`.`_metrics`.`marine_mooring_operation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Operational and safety KPIs for mooring operations — a high-frequency, safety-critical port service. Covers mooring revenue, gang utilisation, incident rates, SWL compliance, and environmental conditions. Used by Marine Operations, HSE, and Finance."
  source: "`vibe_shipping_ports_v1`.`marine`.`mooring_operation`"
  dimensions:
    - name: "operation_status"
      expr: operation_status
      comment: "Lifecycle status of the mooring operation (COMPLETED, IN_PROGRESS, CANCELLED)."
    - name: "operation_type"
      expr: operation_type
      comment: "Type of mooring operation (MAKE_FAST, CAST_OFF, SHIFTING) — drives tariff and gang planning."
    - name: "mooring_location_type"
      expr: mooring_location_type
      comment: "Location type where mooring was performed (berth, buoy, anchorage) — capacity and safety dimension."
    - name: "vessel_movement_type"
      expr: vessel_movement_type
      comment: "Type of vessel movement associated with the mooring (arrival, departure, shift) — operational planning dimension."
    - name: "billable_flag"
      expr: billable
      comment: "Whether the mooring operation is billable — revenue recognition dimension."
    - name: "swl_compliant_flag"
      expr: swl_compliant
      comment: "Whether the operation was conducted within Safe Working Load limits — critical safety compliance dimension."
    - name: "incident_reported_flag"
      expr: incident_reported
      comment: "Whether a safety incident was reported — HSE monitoring dimension."
    - name: "operation_month"
      expr: DATE_TRUNC('MONTH', commencement_timestamp)
      comment: "Calendar month of mooring commencement — primary time grain for trend analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the mooring charge — multi-currency revenue reporting."
  measures:
    - name: "total_mooring_operations"
      expr: COUNT(1)
      comment: "Total mooring operations in the period. Core throughput KPI for gang capacity planning and berth scheduling."
    - name: "total_mooring_revenue"
      expr: SUM(CAST(charge_amount AS DOUBLE))
      comment: "Total mooring charge revenue. Financial KPI for the marine services P&L tracked by CFO and Marine VP."
    - name: "avg_mooring_charge"
      expr: AVG(CAST(charge_amount AS DOUBLE))
      comment: "Average mooring charge per operation. Tariff yield monitoring metric."
    - name: "swl_non_compliance_count"
      expr: SUM(CAST(CASE WHEN swl_compliant = FALSE THEN 1 ELSE 0 END AS INT))
      comment: "Number of mooring operations conducted outside Safe Working Load limits. Critical safety KPI; any non-zero value triggers immediate HSE investigation."
    - name: "swl_compliance_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(CASE WHEN swl_compliant = TRUE THEN 1 ELSE 0 END AS INT)) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of mooring operations conducted within SWL limits. Primary safety compliance KPI for the Harbour Master and HSE Manager."
    - name: "incident_reported_count"
      expr: SUM(CAST(CASE WHEN incident_reported = TRUE THEN 1 ELSE 0 END AS INT))
      comment: "Number of mooring operations with a reported safety incident. HSE KPI tracked against zero-harm targets."
    - name: "incident_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(CASE WHEN incident_reported = TRUE THEN 1 ELSE 0 END AS INT)) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of mooring operations resulting in a reported incident. Safety performance indicator."
    - name: "irregularity_observed_count"
      expr: SUM(CAST(CASE WHEN irregularity_observed = TRUE THEN 1 ELSE 0 END AS INT))
      comment: "Number of mooring operations where an irregularity was observed. Quality and safety leading indicator."
    - name: "towage_assist_utilisation_count"
      expr: SUM(CAST(CASE WHEN towage_assist_used = TRUE THEN 1 ELSE 0 END AS INT))
      comment: "Number of mooring operations requiring tug assistance. Drives tug demand forecasting and berth complexity analysis."
    - name: "avg_wind_speed_knots"
      expr: AVG(CAST(wind_speed_knots AS DOUBLE))
      comment: "Average wind speed during mooring operations. Environmental context metric used to correlate adverse conditions with incidents and SWL breaches."
    - name: "avg_tide_height_m"
      expr: AVG(CAST(tide_height_m AS DOUBLE))
      comment: "Average tide height during mooring operations. Used to assess tidal-window compliance and under-keel clearance risk."
    - name: "distinct_vessels_moored"
      expr: COUNT(DISTINCT vessel_id)
      comment: "Number of distinct vessels moored in the period. Measures port throughput and berth utilisation breadth."
$$;

CREATE OR REPLACE VIEW `vibe_shipping_ports_v1`.`_metrics`.`marine_incident`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Safety, environmental, and liability KPIs for marine incidents. Covers incident frequency, pollution events, damage costs, investigation status, and regulatory notifications (MARPOL, SOLAS, PSC, P&I). Used by HSE Manager, Harbour Master, Legal, and the Board Safety Committee."
  source: "`vibe_shipping_ports_v1`.`marine`.`marine_incident`"
  dimensions:
    - name: "incident_type"
      expr: incident_type
      comment: "Classification of the incident type (collision, grounding, fire, pollution, personal injury, etc.)."
    - name: "incident_category"
      expr: incident_category
      comment: "Severity category of the incident (NEAR_MISS, MINOR, SERIOUS, MAJOR, CATASTROPHIC)."
    - name: "investigation_status"
      expr: investigation_status
      comment: "Current status of the incident investigation (OPEN, IN_PROGRESS, CLOSED) — tracks regulatory closure obligations."
    - name: "marpol_classification"
      expr: marpol_classification
      comment: "MARPOL annex classification of the incident — environmental regulatory reporting dimension."
    - name: "solas_classification"
      expr: solas_classification
      comment: "SOLAS classification of the incident — safety regulatory reporting dimension."
    - name: "pollution_occurred_flag"
      expr: pollution_occurred
      comment: "Whether pollution occurred — primary environmental risk filter."
    - name: "human_factor_involved_flag"
      expr: human_factor_involved
      comment: "Whether a human factor contributed to the incident — root cause analysis dimension."
    - name: "isps_security_implication_flag"
      expr: isps_security_implication
      comment: "Whether the incident has ISPS security implications — security risk dimension."
    - name: "incident_month"
      expr: DATE_TRUNC('MONTH', datetime)
      comment: "Calendar month of the incident — primary time grain for trend and seasonality analysis."
    - name: "corrective_actions_completed_flag"
      expr: corrective_actions_completed
      comment: "Whether corrective actions have been completed — regulatory closure and safety improvement tracking."
  measures:
    - name: "total_incidents"
      expr: COUNT(1)
      comment: "Total marine incidents in the period. Primary safety KPI for the Board Safety Committee and Harbour Master."
    - name: "total_estimated_damage_cost_usd"
      expr: SUM(CAST(estimated_damage_cost_usd AS DOUBLE))
      comment: "Total estimated damage cost across all incidents. Financial risk KPI for the CFO, Legal, and P&I club reserve setting."
    - name: "avg_estimated_damage_cost_usd"
      expr: AVG(CAST(estimated_damage_cost_usd AS DOUBLE))
      comment: "Average estimated damage cost per incident. Used to benchmark incident severity and set P&I reserve levels."
    - name: "pollution_incident_count"
      expr: SUM(CAST(CASE WHEN pollution_occurred = TRUE THEN 1 ELSE 0 END AS INT))
      comment: "Number of incidents involving pollution. Critical environmental KPI reported to MARPOL authorities and the port environmental officer."
    - name: "total_pollution_volume_litres"
      expr: SUM(CAST(pollution_volume_litres AS DOUBLE))
      comment: "Total volume of pollutant discharged across all pollution incidents. Environmental liability KPI for MARPOL reporting and remediation cost estimation."
    - name: "open_investigation_count"
      expr: SUM(CAST(CASE WHEN investigation_status != 'CLOSED' THEN 1 ELSE 0 END AS INT))
      comment: "Number of incidents with open investigations. Regulatory compliance KPI; open investigations beyond statutory deadlines trigger authority escalation."
    - name: "corrective_actions_overdue_count"
      expr: SUM(CASE WHEN corrective_actions_completed = FALSE AND corrective_actions_due_date < CURRENT_DATE() THEN 1 ELSE 0 END)
      comment: "Number of incidents where corrective actions are overdue. Safety governance KPI tracked by HSE Manager and Board Safety Committee."
    - name: "human_factor_incident_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(CASE WHEN human_factor_involved = TRUE THEN 1 ELSE 0 END AS INT)) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of incidents involving a human factor. Used to prioritise crew training and procedural improvement investments."
    - name: "pi_club_notified_count"
      expr: SUM(CAST(CASE WHEN pi_club_notified = TRUE THEN 1 ELSE 0 END AS INT))
      comment: "Number of incidents where the P&I club was notified. Liability exposure indicator for the port legal and insurance team."
    - name: "psc_notified_count"
      expr: SUM(CAST(CASE WHEN psc_notified = TRUE THEN 1 ELSE 0 END AS INT))
      comment: "Number of incidents notified to Port State Control. Regulatory risk KPI; high PSC notification rates can trigger enhanced port inspections."
    - name: "isps_security_implication_count"
      expr: SUM(CAST(CASE WHEN isps_security_implication = TRUE THEN 1 ELSE 0 END AS INT))
      comment: "Number of incidents with ISPS security implications. Security risk KPI reported to the Port Facility Security Officer."
$$;

CREATE OR REPLACE VIEW `vibe_shipping_ports_v1`.`_metrics`.`marine_marpol_operation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Environmental compliance and waste reception KPIs for MARPOL operations. Covers waste volumes received, GHG and NOx/SOx emissions, non-compliance rates, and PSC inspection outcomes. Used by the Environmental Officer, Harbour Master, and Regulatory Affairs team."
  source: "`vibe_shipping_ports_v1`.`marine`.`marpol_operation`"
  dimensions:
    - name: "operation_type"
      expr: operation_type
      comment: "Type of MARPOL operation (oily water reception, garbage reception, sewage, ballast water treatment, etc.)."
    - name: "marpol_annex_code"
      expr: marpol_annex_code
      comment: "MARPOL annex under which the operation is classified (I=oil, II=noxious liquids, IV=sewage, V=garbage, VI=air emissions)."
    - name: "waste_category"
      expr: waste_category
      comment: "Category of waste received — drives facility capacity planning and disposal cost allocation."
    - name: "operation_status"
      expr: operation_status
      comment: "Lifecycle status of the MARPOL operation (COMPLETED, IN_PROGRESS, REJECTED)."
    - name: "non_compliance_flag"
      expr: non_compliance_flag
      comment: "Whether a non-compliance was identified — primary regulatory risk filter."
    - name: "psc_inspection_flag"
      expr: psc_inspection_flag
      comment: "Whether a PSC inspection was conducted — regulatory oversight dimension."
    - name: "facility_type"
      expr: facility_type
      comment: "Type of waste reception facility used — capacity and investment planning dimension."
    - name: "operation_month"
      expr: DATE_TRUNC('MONTH', operation_timestamp)
      comment: "Calendar month of the MARPOL operation — primary time grain for environmental trend reporting."
  measures:
    - name: "total_marpol_operations"
      expr: COUNT(1)
      comment: "Total MARPOL waste reception and environmental operations. Throughput KPI for facility capacity planning and regulatory reporting."
    - name: "total_waste_quantity_received"
      expr: SUM(CAST(quantity AS DOUBLE))
      comment: "Total quantity of waste received across all MARPOL operations (unit varies by waste category). Environmental throughput KPI for facility utilisation reporting."
    - name: "total_ballast_water_volume_m3"
      expr: SUM(CAST(ballast_water_volume_m3 AS DOUBLE))
      comment: "Total ballast water volume treated. Ballast Water Management Convention compliance KPI reported to flag state and port authority."
    - name: "total_ghg_emission_mt_co2e"
      expr: SUM(CAST(ghg_emission_mt_co2e AS DOUBLE))
      comment: "Total GHG emissions (MT CO2e) from MARPOL operations. Environmental KPI for port decarbonisation reporting and IMO DCS compliance."
    - name: "avg_nox_emission_g_kwh"
      expr: AVG(CAST(nox_emission_g_kwh AS DOUBLE))
      comment: "Average NOx emission intensity (g/kWh) across operations. Air quality KPI for MARPOL Annex VI compliance monitoring."
    - name: "avg_sox_emission_ppm"
      expr: AVG(CAST(sox_emission_ppm AS DOUBLE))
      comment: "Average SOx emission concentration (ppm) across operations. MARPOL Annex VI sulphur cap compliance KPI."
    - name: "non_compliance_count"
      expr: SUM(CAST(CASE WHEN non_compliance_flag = TRUE THEN 1 ELSE 0 END AS INT))
      comment: "Number of MARPOL operations with a non-compliance finding. Regulatory risk KPI; triggers PSC notification and potential port state action."
    - name: "non_compliance_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(CASE WHEN non_compliance_flag = TRUE THEN 1 ELSE 0 END AS INT)) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of MARPOL operations resulting in a non-compliance finding. Environmental compliance KPI tracked against zero-tolerance targets."
    - name: "psc_deficiency_count"
      expr: SUM(CAST(CASE WHEN psc_deficiency_noted = TRUE THEN 1 ELSE 0 END AS INT))
      comment: "Number of MARPOL operations where a PSC deficiency was noted. Regulatory risk KPI; deficiencies can lead to vessel detention and port reputation damage."
    - name: "facility_capacity_utilisation_m3"
      expr: SUM(CAST(facility_capacity_m3 AS DOUBLE))
      comment: "Total declared facility capacity across all operations. Used as denominator for capacity utilisation analysis against waste volumes received."
    - name: "distinct_vessels_served"
      expr: COUNT(DISTINCT vessel_id)
      comment: "Number of distinct vessels receiving MARPOL waste reception services. Market coverage and environmental service reach KPI."
$$;

CREATE OR REPLACE VIEW `vibe_shipping_ports_v1`.`_metrics`.`marine_pilotage_exemption`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Regulatory and risk KPIs for pilotage exemptions. Covers exemption portfolio size, expiry risk, examination pass rates, and vessel size limits. Used by the Harbour Master and Port Authority to manage exemption risk and ensure regulatory compliance."
  source: "`vibe_shipping_ports_v1`.`marine`.`pilotage_exemption`"
  dimensions:
    - name: "pilotage_exemption_status"
      expr: pilotage_exemption_status
      comment: "Current status of the exemption (ACTIVE, SUSPENDED, REVOKED, EXPIRED) — primary regulatory risk filter."
    - name: "exemption_type"
      expr: exemption_type
      comment: "Type of pilotage exemption (master's exemption, regular trader, etc.) — risk classification dimension."
    - name: "issuing_authority"
      expr: issuing_authority
      comment: "Authority that issued the exemption — regulatory governance dimension."
    - name: "examination_result"
      expr: examination_result
      comment: "Result of the pilotage exemption examination (PASS, FAIL, DEFERRED) — competency assessment dimension."
    - name: "expiry_year"
      expr: YEAR(expiry_date)
      comment: "Year the exemption expires — used for renewal pipeline planning."
    - name: "expiry_month"
      expr: DATE_TRUNC('MONTH', expiry_date)
      comment: "Month the exemption expires — used for short-term renewal workload planning."
  measures:
    - name: "total_active_exemptions"
      expr: SUM(CAST(CASE WHEN pilotage_exemption_status = 'ACTIVE' THEN 1 ELSE 0 END AS INT))
      comment: "Number of currently active pilotage exemptions. Portfolio size KPI for the Harbour Master; large portfolios increase navigational risk exposure."
    - name: "exemptions_expiring_within_90_days"
      expr: SUM(CASE WHEN pilotage_exemption_status = 'ACTIVE' AND expiry_date BETWEEN CURRENT_DATE() AND DATE_ADD(CURRENT_DATE(), 90) THEN 1 ELSE 0 END)
      comment: "Number of active exemptions expiring within 90 days. Renewal pipeline KPI for the Port Authority to proactively manage compliance."
    - name: "suspended_or_revoked_count"
      expr: SUM(CASE WHEN pilotage_exemption_status IN ('SUSPENDED', 'REVOKED') THEN 1 ELSE 0 END)
      comment: "Number of exemptions currently suspended or revoked. Regulatory enforcement KPI indicating active compliance actions."
    - name: "avg_examination_score"
      expr: AVG(CAST(examination_score AS DOUBLE))
      comment: "Average examination score across all exemption applications. Competency standard KPI; declining scores may indicate need for examination standard review."
    - name: "avg_max_loa_authorized_m"
      expr: AVG(CAST(max_loa_meters AS DOUBLE))
      comment: "Average maximum LOA authorised under exemptions. Risk exposure metric; higher average LOA means larger vessels navigating without a pilot."
    - name: "avg_max_dwt_authorized_tonnes"
      expr: AVG(CAST(max_dwt_tonnes AS DOUBLE))
      comment: "Average maximum DWT authorised under exemptions. Risk exposure metric for the Harbour Master and port insurance team."
    - name: "total_passages_under_exemption"
      expr: COUNT(1)
      comment: "Total exemption records (proxy for exemption portfolio breadth). Used alongside active count for portfolio trend analysis."
$$;

CREATE OR REPLACE VIEW `vibe_shipping_ports_v1`.`_metrics`.`marine_tug_assignment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tug fleet utilisation and performance KPIs. Covers assignment throughput, bollard pull utilisation, fuel consumption, safety observations, and incident rates. Used by Marine Operations VP and Fleet Manager to optimise tug deployment and maintenance scheduling."
  source: "`vibe_shipping_ports_v1`.`marine`.`tug_assignment`"
  dimensions:
    - name: "assignment_status"
      expr: assignment_status
      comment: "Lifecycle status of the tug assignment (ASSIGNED, MOBILISED, ENGAGED, COMPLETED, ABORTED, CANCELLED)."
    - name: "assignment_outcome"
      expr: assignment_outcome
      comment: "Outcome of the tug assignment (SUCCESSFUL, ABORTED, PARTIAL) — service quality dimension."
    - name: "assigned_position"
      expr: assigned_position
      comment: "Position of the tug relative to the vessel (BOW, STERN, BREAST) — operational planning dimension."
    - name: "billable_flag"
      expr: billable
      comment: "Whether the assignment is billable — revenue recognition dimension."
    - name: "safety_observation_flag"
      expr: safety_observation_flag
      comment: "Whether a safety observation was raised — HSE monitoring dimension."
    - name: "incident_reported_flag"
      expr: incident_reported
      comment: "Whether a safety incident was reported — HSE KPI dimension."
    - name: "fuel_type"
      expr: fuel_type
      comment: "Fuel type used during the assignment (HFO, MGO, LNG, biofuel) — emissions and cost analysis dimension."
    - name: "assignment_month"
      expr: DATE_TRUNC('MONTH', engagement_timestamp)
      comment: "Calendar month of tug engagement — primary time grain for utilisation trend analysis."
  measures:
    - name: "total_tug_assignments"
      expr: COUNT(1)
      comment: "Total tug assignments in the period. Core fleet utilisation KPI for the Fleet Manager and Marine Operations VP."
    - name: "total_fuel_consumed_litres"
      expr: SUM(CAST(fuel_consumed_litres AS DOUBLE))
      comment: "Total fuel consumed across all tug assignments. Cost and emissions KPI; drives bunker procurement planning and carbon footprint reporting."
    - name: "avg_fuel_consumed_per_assignment_litres"
      expr: AVG(CAST(fuel_consumed_litres AS DOUBLE))
      comment: "Average fuel consumed per tug assignment. Efficiency KPI; deteriorating values indicate engine performance issues or inefficient deployment."
    - name: "avg_bollard_pull_applied_tonnes"
      expr: AVG(CAST(bollard_pull_applied_tonnes AS DOUBLE))
      comment: "Average bollard pull applied per assignment. Operational efficiency metric; consistently low values relative to vessel size indicate over-specified tug deployment."
    - name: "max_bollard_pull_applied_tonnes"
      expr: MAX(max_bollard_pull_applied_tonnes)
      comment: "Maximum bollard pull applied in any single assignment. Fleet capability benchmark used in tug procurement and capability gap analysis."
    - name: "safety_observation_count"
      expr: SUM(CAST(CASE WHEN safety_observation_flag = TRUE THEN 1 ELSE 0 END AS INT))
      comment: "Number of tug assignments with a safety observation. HSE leading indicator tracked against zero-harm targets."
    - name: "incident_reported_count"
      expr: SUM(CAST(CASE WHEN incident_reported = TRUE THEN 1 ELSE 0 END AS INT))
      comment: "Number of tug assignments with a reported safety incident. HSE lagging indicator for the Board Safety Committee."
    - name: "abort_count"
      expr: SUM(CAST(CASE WHEN assignment_status = 'ABORTED' THEN 1 ELSE 0 END AS INT))
      comment: "Number of aborted tug assignments. Service reliability KPI; high abort rates indicate tug availability, mechanical, or weather issues."
    - name: "abort_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(CASE WHEN assignment_status = 'ABORTED' THEN 1 ELSE 0 END AS INT)) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of tug assignments aborted. Fleet reliability KPI tracked by the Fleet Manager."
    - name: "distinct_tugs_utilised"
      expr: COUNT(DISTINCT tug_id)
      comment: "Number of distinct tugs utilised in the period. Fleet breadth KPI for maintenance scheduling and availability planning."
    - name: "avg_tow_line_length_m"
      expr: AVG(CAST(tow_line_length_m AS DOUBLE))
      comment: "Average tow line length used. Operational safety metric; unusually long tow lines in confined waters indicate non-standard conditions."
$$;

CREATE OR REPLACE VIEW `vibe_shipping_ports_v1`.`_metrics`.`marine_survey_appointment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Survey throughput, compliance, and quality KPIs. Covers survey volume, SOLAS/MARPOL/ISPS compliance outcomes, PSC inspection triggers, deficiency rates, and cargo quantity surveyed. Used by Marine Operations, Compliance, and Commercial teams."
  source: "`vibe_shipping_ports_v1`.`marine`.`survey_appointment`"
  dimensions:
    - name: "appointment_status"
      expr: appointment_status
      comment: "Lifecycle status of the survey appointment (SCHEDULED, IN_PROGRESS, COMPLETED, CANCELLED)."
    - name: "survey_type"
      expr: survey_type
      comment: "Type of survey (condition, draught, cargo, MARPOL, SOLAS, ISPS, P&I) — primary classification for compliance reporting."
    - name: "survey_outcome"
      expr: survey_outcome
      comment: "Outcome of the survey (SATISFACTORY, DEFICIENCY_NOTED, FAILED, CONDITIONAL) — quality and compliance dimension."
    - name: "survey_location_type"
      expr: survey_location_type
      comment: "Location where the survey was conducted (berth, anchorage, at-sea) — operational planning dimension."
    - name: "solas_compliance_flag"
      expr: solas_compliance_flag
      comment: "Whether SOLAS compliance was confirmed — regulatory compliance dimension."
    - name: "marpol_compliance_flag"
      expr: marpol_compliance_flag
      comment: "Whether MARPOL compliance was confirmed — environmental compliance dimension."
    - name: "isps_compliance_flag"
      expr: isps_compliance_flag
      comment: "Whether ISPS compliance was confirmed — security compliance dimension."
    - name: "psc_inspection_triggered_flag"
      expr: psc_inspection_triggered
      comment: "Whether the survey triggered a PSC inspection — regulatory escalation dimension."
    - name: "appointment_month"
      expr: DATE_TRUNC('MONTH', scheduled_commencement)
      comment: "Calendar month of scheduled survey commencement — primary time grain for trend analysis."
  measures:
    - name: "total_survey_appointments"
      expr: COUNT(1)
      comment: "Total survey appointments in the period. Throughput KPI for surveyor capacity planning and commercial revenue forecasting."
    - name: "total_cargo_quantity_surveyed_mt"
      expr: SUM(CAST(cargo_quantity_mt AS DOUBLE))
      comment: "Total cargo quantity (MT) covered by surveys. Commercial KPI for survey revenue and cargo throughput validation."
    - name: "avg_cargo_quantity_per_survey_mt"
      expr: AVG(CAST(cargo_quantity_mt AS DOUBLE))
      comment: "Average cargo quantity per survey appointment. Used to benchmark survey scope and fee adequacy."
    - name: "deficiency_count"
      expr: SUM(CAST(deficiency_count AS BIGINT))
      comment: "Total number of deficiencies identified across all surveys. Compliance quality KPI for the Port Authority and P&I clubs."
    - name: "psc_inspection_triggered_count"
      expr: SUM(CAST(CASE WHEN psc_inspection_triggered = TRUE THEN 1 ELSE 0 END AS INT))
      comment: "Number of surveys that triggered a PSC inspection. Regulatory risk KPI; high rates indicate systemic vessel quality issues calling at the port."
    - name: "solas_non_compliance_count"
      expr: SUM(CAST(CASE WHEN solas_compliance_flag = FALSE THEN 1 ELSE 0 END AS INT))
      comment: "Number of surveys where SOLAS compliance was not confirmed. Safety regulatory KPI reported to the Harbour Master and flag state."
    - name: "marpol_non_compliance_count"
      expr: SUM(CAST(CASE WHEN marpol_compliance_flag = FALSE THEN 1 ELSE 0 END AS INT))
      comment: "Number of surveys where MARPOL compliance was not confirmed. Environmental regulatory KPI for the Port Environmental Officer."
    - name: "isps_non_compliance_count"
      expr: SUM(CAST(CASE WHEN isps_compliance_flag = FALSE THEN 1 ELSE 0 END AS INT))
      comment: "Number of surveys where ISPS compliance was not confirmed. Security regulatory KPI for the Port Facility Security Officer."
    - name: "pi_club_notified_count"
      expr: SUM(CAST(CASE WHEN pi_club_notified = TRUE THEN 1 ELSE 0 END AS INT))
      comment: "Number of surveys triggering P&I club notification. Liability exposure indicator for the port legal and insurance team."
    - name: "distinct_surveyors_active"
      expr: COUNT(DISTINCT surveyor_id)
      comment: "Number of distinct surveyors conducting appointments. Capacity and vendor diversity KPI for the Marine Operations team."
    - name: "avg_draught_aft_m"
      expr: AVG(CAST(draught_aft_m AS DOUBLE))
      comment: "Average aft draught recorded during surveys. Used to validate vessel draught declarations and under-keel clearance compliance."
$$;

CREATE OR REPLACE VIEW `vibe_shipping_ports_v1`.`_metrics`.`marine_weather_tide_window`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Port operational weather and tidal window KPIs. Covers restriction frequency, UKC availability, visibility conditions, and service window status. Used by the Harbour Master, VTS, and Marine Operations to manage port access decisions and vessel scheduling."
  source: "`vibe_shipping_ports_v1`.`marine`.`weather_tide_window`"
  dimensions:
    - name: "service_window_status"
      expr: service_window_status
      comment: "Status of the service window (OPEN, RESTRICTED, CLOSED) — primary port access decision dimension."
    - name: "sea_state_code"
      expr: sea_state_code
      comment: "Beaufort/Douglas sea state code — environmental severity classification."
    - name: "visibility_category"
      expr: visibility_category
      comment: "Visibility category (GOOD, MODERATE, POOR, VERY_POOR) — safety and scheduling dimension."
    - name: "tidal_phase"
      expr: tidal_phase
      comment: "Tidal phase (FLOOD, EBB, HIGH_WATER, LOW_WATER) — tidal window planning dimension."
    - name: "pilotage_restriction_flag"
      expr: pilotage_restriction_flag
      comment: "Whether pilotage is restricted in this window — direct impact on vessel scheduling."
    - name: "towage_restriction_flag"
      expr: towage_restriction_flag
      comment: "Whether towage is restricted in this window — tug deployment planning dimension."
    - name: "mooring_restriction_flag"
      expr: mooring_restriction_flag
      comment: "Whether mooring is restricted in this window — berth scheduling dimension."
    - name: "marpol_environmental_flag"
      expr: marpol_environmental_flag
      comment: "Whether MARPOL environmental conditions are flagged — environmental compliance dimension."
    - name: "observation_month"
      expr: DATE_TRUNC('MONTH', observation_timestamp)
      comment: "Calendar month of the weather observation — primary time grain for seasonal pattern analysis."
    - name: "forecast_source"
      expr: forecast_source
      comment: "Source of the weather forecast (meteorological service, VTS, onboard) — data quality dimension."
  measures:
    - name: "total_observations"
      expr: COUNT(1)
      comment: "Total weather and tidal window observations. Coverage KPI for VTS data completeness and port operational awareness."
    - name: "restricted_window_count"
      expr: SUM(CAST(CASE WHEN service_window_status = 'RESTRICTED' THEN 1 ELSE 0 END AS INT))
      comment: "Number of observations where the service window was restricted. Port accessibility KPI; high counts indicate weather-driven operational disruption."
    - name: "closed_window_count"
      expr: SUM(CAST(CASE WHEN service_window_status = 'CLOSED' THEN 1 ELSE 0 END AS INT))
      comment: "Number of observations where the service window was fully closed. Port downtime KPI directly linked to revenue loss and vessel delay costs."
    - name: "port_closure_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(CASE WHEN service_window_status = 'CLOSED' THEN 1 ELSE 0 END AS INT)) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of observation periods where the port was closed. Port availability KPI used in SLA reporting and insurance risk assessment."
    - name: "avg_ukc_available_m"
      expr: AVG(CAST(ukc_available_m AS DOUBLE))
      comment: "Average under-keel clearance available. Critical safety KPI for the Harbour Master; values approaching minimum thresholds trigger access restrictions."
    - name: "avg_wave_height_m"
      expr: AVG(CAST(wave_height_m AS DOUBLE))
      comment: "Average wave height across observations. Environmental baseline metric for seasonal port access planning and tug specification."
    - name: "avg_wind_speed_knots"
      expr: AVG(CAST(wind_speed_knots AS DOUBLE))
      comment: "Average wind speed across observations. Environmental baseline metric correlated with mooring and towage restriction frequency."
    - name: "avg_visibility_nm"
      expr: AVG(CAST(visibility_nm AS DOUBLE))
      comment: "Average visibility in nautical miles. Safety planning metric; low visibility periods require enhanced VTS monitoring and pilotage protocols."
    - name: "pilotage_restriction_count"
      expr: SUM(CAST(CASE WHEN pilotage_restriction_flag = TRUE THEN 1 ELSE 0 END AS INT))
      comment: "Number of observation periods with pilotage restrictions. Vessel scheduling impact KPI for the Harbour Master and shipping line customers."
    - name: "avg_tide_height_variance_m"
      expr: AVG(CAST(tide_height_variance_m AS DOUBLE))
      comment: "Average variance between predicted and actual tide height. Tidal prediction accuracy KPI; high variance indicates need for updated tidal models."
    - name: "avg_max_vessel_draft_permitted_m"
      expr: AVG(CAST(max_vessel_draft_permitted_m AS DOUBLE))
      comment: "Average maximum vessel draft permitted across all observation windows. Port access capacity metric used in vessel scheduling and berth allocation."
$$;

CREATE OR REPLACE VIEW `vibe_shipping_ports_v1`.`_metrics`.`marine_pilot_duty_roster`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Pilot workforce planning and fatigue management KPIs. Covers roster utilisation, fatigue compliance, swap rates, and duty hour accumulation. Used by the Harbour Master and Workforce Planning team to ensure safe pilot staffing levels and MLC/STCW rest-hour compliance."
  source: "`vibe_shipping_ports_v1`.`marine`.`pilot_duty_roster`"
  dimensions:
    - name: "roster_status"
      expr: roster_status
      comment: "Status of the duty roster entry (PUBLISHED, ACTIVE, COMPLETED, CANCELLED, SWAPPED)."
    - name: "availability_status"
      expr: availability_status
      comment: "Pilot availability status (AVAILABLE, ON_DUTY, RESTING, SICK, LEAVE) — capacity planning dimension."
    - name: "duty_priority_level"
      expr: duty_priority_level
      comment: "Priority level of the duty assignment — used to assess high-priority coverage gaps."
    - name: "fatigue_compliance_flag"
      expr: fatigue_compliance_flag
      comment: "Whether the roster entry is compliant with fatigue management rules — critical safety and regulatory dimension."
    - name: "swap_request_flag"
      expr: swap_request_flag
      comment: "Whether a swap was requested for this roster slot — workforce flexibility and planning dimension."
    - name: "night_pilotage_authorised_flag"
      expr: night_pilotage_authorised
      comment: "Whether the assigned pilot is authorised for night pilotage — scheduling constraint dimension."
    - name: "roster_month"
      expr: DATE_TRUNC('MONTH', roster_period_start_timestamp)
      comment: "Calendar month of the roster period — primary time grain for workforce planning."
  measures:
    - name: "total_roster_slots"
      expr: COUNT(1)
      comment: "Total pilot duty roster slots in the period. Workforce coverage KPI for the Harbour Master to validate adequate pilotage staffing."
    - name: "fatigue_non_compliance_count"
      expr: SUM(CAST(CASE WHEN fatigue_compliance_flag = FALSE THEN 1 ELSE 0 END AS INT))
      comment: "Number of roster slots where fatigue compliance rules were breached. Critical safety and MLC/STCW regulatory KPI; any breach requires immediate corrective action."
    - name: "fatigue_compliance_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(CASE WHEN fatigue_compliance_flag = TRUE THEN 1 ELSE 0 END AS INT)) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of roster slots compliant with fatigue management rules. Safety governance KPI tracked by the Harbour Master and MLC compliance officer."
    - name: "swap_request_count"
      expr: SUM(CAST(CASE WHEN swap_request_flag = TRUE THEN 1 ELSE 0 END AS INT))
      comment: "Number of roster swap requests. Workforce flexibility KPI; high swap rates indicate roster planning issues or pilot dissatisfaction."
    - name: "swap_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(CASE WHEN swap_request_flag = TRUE THEN 1 ELSE 0 END AS INT)) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of roster slots requiring a swap. Workforce planning quality KPI."
    - name: "avg_cumulative_duty_hours_week"
      expr: AVG(CAST(cumulative_duty_hours_week AS DOUBLE))
      comment: "Average cumulative duty hours per week across all pilots. MLC/STCW rest-hour compliance KPI; values approaching regulatory limits trigger roster adjustment."
    - name: "avg_cumulative_duty_hours_month"
      expr: AVG(CAST(cumulative_duty_hours_month AS DOUBLE))
      comment: "Average cumulative duty hours per month across all pilots. Monthly fatigue exposure KPI for the Harbour Master and HR."
    - name: "avg_hours_of_rest_prior"
      expr: AVG(CAST(hours_of_rest_prior AS DOUBLE))
      comment: "Average hours of rest prior to duty commencement. STCW rest-hour compliance KPI; values below minimum thresholds are a regulatory breach."
    - name: "avg_fatigue_risk_score"
      expr: AVG(CAST(fatigue_risk_score AS DOUBLE))
      comment: "Average fatigue risk score across all roster slots. Predictive safety KPI used to proactively adjust rosters before fatigue-related incidents occur."
    - name: "distinct_pilots_rostered"
      expr: COUNT(DISTINCT primary_pilot_id)
      comment: "Number of distinct pilots rostered in the period. Workforce breadth KPI for succession planning and licence renewal tracking."
$$;

CREATE OR REPLACE VIEW `vibe_shipping_ports_v1`.`_metrics`.`marine_pni_club_notification`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "P&I club liability and claims KPIs. Covers notification volume, estimated and settled liability amounts, reserve adequacy, legal hold exposure, and claim type distribution. Used by the port Legal team, CFO, and Risk Manager to manage marine liability exposure."
  source: "`vibe_shipping_ports_v1`.`marine`.`pni_club_notification`"
  dimensions:
    - name: "notification_status"
      expr: notification_status
      comment: "Current status of the P&I notification (NOTIFIED, ACKNOWLEDGED, UNDER_REVIEW, SETTLED, CLOSED)."
    - name: "claim_type"
      expr: claim_type
      comment: "Type of P&I claim (cargo damage, personal injury, pollution, collision, property damage) — liability classification dimension."
    - name: "pi_club_name"
      expr: pi_club_name
      comment: "Name of the P&I club handling the claim — counterparty dimension for club relationship management."
    - name: "marpol_reportable_flag"
      expr: marpol_reportable_flag
      comment: "Whether the incident is MARPOL reportable — environmental regulatory dimension."
    - name: "solas_reportable_flag"
      expr: solas_reportable_flag
      comment: "Whether the incident is SOLAS reportable — safety regulatory dimension."
    - name: "legal_hold_flag"
      expr: legal_hold_flag
      comment: "Whether a legal hold is in place — litigation risk dimension."
    - name: "surveyor_appointed_flag"
      expr: surveyor_appointed_flag
      comment: "Whether a surveyor has been appointed — claims management process dimension."
    - name: "notification_month"
      expr: DATE_TRUNC('MONTH', notification_datetime)
      comment: "Calendar month of P&I notification — primary time grain for liability trend analysis."
    - name: "liability_currency"
      expr: liability_currency
      comment: "Currency of the liability estimate — multi-currency financial reporting dimension."
  measures:
    - name: "total_notifications"
      expr: COUNT(1)
      comment: "Total P&I club notifications in the period. Claims frequency KPI for the Risk Manager and CFO to assess liability exposure trends."
    - name: "total_estimated_liability"
      expr: SUM(CAST(estimated_liability_amount AS DOUBLE))
      comment: "Total estimated liability across all P&I notifications. Gross liability exposure KPI for the CFO and Board Risk Committee."
    - name: "total_reserve_amount"
      expr: SUM(CAST(reserve_amount AS DOUBLE))
      comment: "Total reserve amount set aside for P&I claims. Financial provisioning KPI for IFRS compliance and cash flow planning."
    - name: "total_settled_amount"
      expr: SUM(CAST(settled_amount AS DOUBLE))
      comment: "Total amount settled across closed P&I claims. Actual liability realisation KPI for reserve adequacy assessment."
    - name: "avg_estimated_liability"
      expr: AVG(CAST(estimated_liability_amount AS DOUBLE))
      comment: "Average estimated liability per P&I notification. Severity benchmark used to set reserve levels and insurance premium negotiations."
    - name: "reserve_to_estimated_liability_ratio"
      expr: ROUND(SUM(CAST(reserve_amount AS DOUBLE)) / NULLIF(SUM(CAST(estimated_liability_amount AS DOUBLE)), 0), 4)
      comment: "Ratio of total reserves to total estimated liability. Reserve adequacy KPI; ratios below 1.0 indicate under-provisioning requiring CFO action."
    - name: "legal_hold_count"
      expr: SUM(CAST(CASE WHEN legal_hold_flag = TRUE THEN 1 ELSE 0 END AS INT))
      comment: "Number of notifications under legal hold. Litigation exposure KPI for the port Legal team."
    - name: "marpol_reportable_count"
      expr: SUM(CAST(CASE WHEN marpol_reportable_flag = TRUE THEN 1 ELSE 0 END AS INT))
      comment: "Number of P&I notifications that are MARPOL reportable. Environmental regulatory liability KPI."
    - name: "open_notification_count"
      expr: SUM(CASE WHEN notification_status NOT IN ('SETTLED', 'CLOSED') THEN 1 ELSE 0 END)
      comment: "Number of P&I notifications not yet settled or closed. Open liability pipeline KPI for the Risk Manager."
    - name: "surveyor_appointment_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(CASE WHEN surveyor_appointed_flag = TRUE THEN 1 ELSE 0 END AS INT)) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of P&I notifications where a surveyor was appointed. Claims management process quality KPI."
$$;

CREATE OR REPLACE VIEW `vibe_shipping_ports_v1`.`_metrics`.`marine_launch_dispatch`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Launch service operational and safety KPIs. Covers dispatch throughput, fuel consumption, service charges, incident rates, and ISPS/MARPOL compliance. Used by Marine Operations to manage launch fleet efficiency and safety."
  source: "`vibe_shipping_ports_v1`.`marine`.`launch_dispatch`"
  dimensions:
    - name: "dispatch_status"
      expr: dispatch_status
      comment: "Lifecycle status of the launch dispatch (DISPATCHED, COMPLETED, CANCELLED, ABORTED)."
    - name: "dispatch_purpose"
      expr: dispatch_purpose
      comment: "Purpose of the launch dispatch (pilot transfer, crew change, survey, stores delivery) — service type dimension."
    - name: "dispatch_priority"
      expr: dispatch_priority
      comment: "Priority level of the dispatch (ROUTINE, URGENT, EMERGENCY) — operational planning dimension."
    - name: "night_operation_flag"
      expr: night_operation
      comment: "Whether the dispatch was a night operation — safety risk and cost dimension."
    - name: "incident_reported_flag"
      expr: incident_reported
      comment: "Whether a safety incident was reported — HSE monitoring dimension."
    - name: "isps_clearance_verified_flag"
      expr: isps_clearance_verified
      comment: "Whether ISPS clearance was verified — security compliance dimension."
    - name: "marpol_compliance_checked_flag"
      expr: marpol_compliance_checked
      comment: "Whether MARPOL compliance was checked — environmental compliance dimension."
    - name: "dispatch_month"
      expr: DATE_TRUNC('MONTH', actual_departure_time)
      comment: "Calendar month of launch departure — primary time grain for trend analysis."
  measures:
    - name: "total_dispatches"
      expr: COUNT(1)
      comment: "Total launch dispatches in the period. Fleet utilisation KPI for launch capacity planning and scheduling."
    - name: "total_service_charge_revenue"
      expr: SUM(CAST(service_charge_amount AS DOUBLE))
      comment: "Total launch service charge revenue. Financial KPI for the marine services P&L."
    - name: "avg_service_charge"
      expr: AVG(CAST(service_charge_amount AS DOUBLE))
      comment: "Average service charge per launch dispatch. Tariff yield monitoring metric."
    - name: "total_fuel_consumed_litres"
      expr: SUM(CAST(fuel_consumed_litres AS DOUBLE))
      comment: "Total fuel consumed by launch fleet. Cost and emissions KPI for fleet efficiency and carbon footprint reporting."
    - name: "avg_fuel_per_dispatch_litres"
      expr: AVG(CAST(fuel_consumed_litres AS DOUBLE))
      comment: "Average fuel consumed per dispatch. Efficiency KPI; deteriorating values indicate engine issues or inefficient routing."
    - name: "incident_reported_count"
      expr: SUM(CAST(CASE WHEN incident_reported = TRUE THEN 1 ELSE 0 END AS INT))
      comment: "Number of launch dispatches with a reported safety incident. HSE KPI for the Marine Operations safety programme."
    - name: "isps_non_compliance_count"
      expr: SUM(CAST(CASE WHEN isps_clearance_verified = FALSE THEN 1 ELSE 0 END AS INT))
      comment: "Number of dispatches where ISPS clearance was not verified. Security compliance KPI reported to the Port Facility Security Officer."
    - name: "night_operation_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(CASE WHEN night_operation = TRUE THEN 1 ELSE 0 END AS INT)) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of dispatches conducted at night. Safety risk exposure KPI; high night operation rates require enhanced crew training and equipment."
    - name: "avg_visibility_nm"
      expr: AVG(CAST(visibility_nm AS DOUBLE))
      comment: "Average visibility during launch dispatches. Environmental safety context metric correlated with incident rates."
    - name: "avg_wind_speed_knots"
      expr: AVG(CAST(wind_speed_knots AS DOUBLE))
      comment: "Average wind speed during launch dispatches. Environmental safety context metric for adverse condition analysis."
$$;