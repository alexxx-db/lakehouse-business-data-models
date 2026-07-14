-- Metric views for domain: infrastructure | Business: Shipping_Ports | Version: 2 | Generated on: 2026-07-13 07:51:56

CREATE OR REPLACE VIEW `vibe_shipping_ports_v1`.`_metrics`.`infrastructure_berth`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Operational and capacity KPIs for individual berths — supports berth utilisation planning, maintenance scheduling, and infrastructure investment decisions."
  source: "`vibe_shipping_ports_v1`.`infrastructure`.`berth`"
  dimensions:
    - name: "berth_type"
      expr: berth_type
      comment: "Classification of the berth (container, bulk, RoRo, multipurpose) for segmented performance analysis."
    - name: "operational_status"
      expr: operational_status
      comment: "Current operational state of the berth (active, under maintenance, decommissioned) for availability tracking."
    - name: "isps_compliant_flag"
      expr: isps_compliant_flag
      comment: "Whether the berth meets ISPS security compliance requirements — critical for regulatory reporting."
    - name: "shore_power_available_flag"
      expr: shore_power_available_flag
      comment: "Indicates availability of shore power (cold-ironing) at the berth — key sustainability dimension."
    - name: "tidal_constraint_flag"
      expr: tidal_constraint_flag
      comment: "Whether the berth has tidal window restrictions affecting vessel scheduling."
    - name: "commissioning_year"
      expr: DATE_TRUNC('YEAR', commissioning_date)
      comment: "Year the berth was commissioned — used for asset age cohort analysis."
  measures:
    - name: "total_berths"
      expr: COUNT(1)
      comment: "Total number of berths in scope — baseline capacity count for port planning."
    - name: "avg_water_depth_alongside_m"
      expr: AVG(CAST(water_depth_alongside_m AS DOUBLE))
      comment: "Average water depth alongside berths — determines which vessel classes can be accommodated; drives dredging investment decisions."
    - name: "max_water_depth_alongside_m"
      expr: MAX(water_depth_alongside_m)
      comment: "Maximum water depth alongside any berth — indicates the deepest draft vessel the port can handle."
    - name: "avg_berth_length_m"
      expr: AVG(CAST(length_m AS DOUBLE))
      comment: "Average berth length in metres — key capacity metric for vessel size accommodation planning."
    - name: "total_shore_power_capacity_kw"
      expr: SUM(CAST(shore_power_capacity_kw AS DOUBLE))
      comment: "Total installed shore power capacity across all berths in kW — tracks decarbonisation infrastructure investment."
    - name: "avg_shore_power_capacity_kw"
      expr: AVG(CAST(shore_power_capacity_kw AS DOUBLE))
      comment: "Average shore power capacity per berth — benchmarks electrification readiness across the berth portfolio."
    - name: "shore_power_enabled_berth_count"
      expr: COUNT(CASE WHEN shore_power_available_flag = TRUE THEN 1 END)
      comment: "Number of berths with shore power available — measures cold-ironing infrastructure coverage for sustainability targets."
    - name: "isps_compliant_berth_count"
      expr: COUNT(CASE WHEN isps_compliant_flag = TRUE THEN 1 END)
      comment: "Number of berths meeting ISPS compliance — critical for port security certification and regulatory reporting."
    - name: "avg_max_draft_m"
      expr: AVG(CAST(max_draft_m AS DOUBLE))
      comment: "Average maximum permissible draft across berths — determines fleet size compatibility and drives dredging prioritisation."
    - name: "avg_max_dwt_tonnes"
      expr: AVG(CAST(max_dwt_tonnes AS DOUBLE))
      comment: "Average maximum DWT capacity across berths — indicates the port's ability to handle large bulk or container vessels."
    - name: "total_fender_energy_absorption_kj"
      expr: SUM(CAST(fender_energy_absorption_kj AS DOUBLE))
      comment: "Total fender energy absorption capacity across berths in kJ — measures structural readiness for large vessel berthing."
    - name: "berths_due_maintenance_count"
      expr: COUNT(CASE WHEN next_maintenance_date <= CURRENT_DATE() THEN 1 END)
      comment: "Number of berths with overdue or imminent maintenance — drives maintenance scheduling and risk management decisions."
$$;

CREATE OR REPLACE VIEW `vibe_shipping_ports_v1`.`_metrics`.`infrastructure_port`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic port-level capacity, capability, and compliance KPIs — used by port authority executives for investment planning, regulatory reporting, and competitive benchmarking."
  source: "`vibe_shipping_ports_v1`.`infrastructure`.`port`"
  dimensions:
    - name: "port_type"
      expr: port_type
      comment: "Classification of the port (container, bulk, multipurpose, cruise) for segmented analysis."
    - name: "operational_status"
      expr: operational_status
      comment: "Current operational state of the port for availability and capacity planning."
    - name: "country_code"
      expr: country_code
      comment: "Country where the port is located — enables geographic and regulatory segmentation."
    - name: "ownership_type"
      expr: ownership_type
      comment: "Ownership model (public, private, PPP) — relevant for governance and investment analysis."
    - name: "free_trade_zone"
      expr: free_trade_zone
      comment: "Whether the port has a free trade zone — key dimension for trade facilitation and customs analysis."
    - name: "isps_compliant"
      expr: isps_compliant
      comment: "ISPS compliance status — mandatory for international vessel calls and regulatory reporting."
    - name: "region"
      expr: region
      comment: "Geographic region of the port — used for regional performance benchmarking."
  measures:
    - name: "total_ports"
      expr: COUNT(1)
      comment: "Total number of ports in the portfolio — baseline for network capacity planning."
    - name: "total_annual_throughput_teu"
      expr: SUM(CAST(annual_throughput_teu AS DOUBLE))
      comment: "Total annual container throughput in TEU across all ports — primary volume KPI for port network performance."
    - name: "avg_annual_throughput_teu"
      expr: AVG(CAST(annual_throughput_teu AS DOUBLE))
      comment: "Average annual TEU throughput per port — benchmarks individual port performance against the network."
    - name: "total_annual_cargo_tonnage"
      expr: SUM(CAST(annual_cargo_tonnage AS DOUBLE))
      comment: "Total annual cargo tonnage across all ports — measures bulk and general cargo volume alongside TEU."
    - name: "avg_channel_depth_m"
      expr: AVG(CAST(channel_depth_m AS DOUBLE))
      comment: "Average navigational channel depth across ports — determines fleet size accessibility and dredging investment needs."
    - name: "max_vessel_draft_m"
      expr: MAX(max_vessel_draft_m)
      comment: "Maximum vessel draft accommodated across the port network — indicates the deepest draft vessel the network can serve."
    - name: "total_storage_capacity_sqm"
      expr: SUM(CAST(storage_capacity_sqm AS DOUBLE))
      comment: "Total storage area in square metres across all ports — measures cargo storage capacity for throughput planning."
    - name: "total_quay_length_m"
      expr: SUM(CAST(total_quay_length_m AS DOUBLE))
      comment: "Total quay length in metres across all ports — key infrastructure capacity metric for vessel scheduling."
    - name: "total_water_area_sqm"
      expr: SUM(CAST(water_area_sqm AS DOUBLE))
      comment: "Total water area in square metres — measures port basin capacity for simultaneous vessel operations."
    - name: "isps_compliant_port_count"
      expr: COUNT(CASE WHEN isps_compliant = TRUE THEN 1 END)
      comment: "Number of ISPS-compliant ports — critical for international trade eligibility and security certification."
    - name: "free_trade_zone_port_count"
      expr: COUNT(CASE WHEN free_trade_zone = TRUE THEN 1 END)
      comment: "Number of ports with free trade zone status — measures trade facilitation capability across the network."
    - name: "bunkering_capable_port_count"
      expr: COUNT(CASE WHEN bunkering_available = TRUE THEN 1 END)
      comment: "Number of ports offering bunkering services — key commercial capability metric for shipping line attraction."
$$;

CREATE OR REPLACE VIEW `vibe_shipping_ports_v1`.`_metrics`.`infrastructure_dredging_campaign`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Dredging programme performance KPIs — tracks cost efficiency, volume delivery, and environmental compliance for capital maintenance decisions."
  source: "`vibe_shipping_ports_v1`.`infrastructure`.`dredging_campaign`"
  dimensions:
    - name: "campaign_status"
      expr: campaign_status
      comment: "Current status of the dredging campaign (planned, active, completed, suspended) for pipeline tracking."
    - name: "dredging_type"
      expr: dredging_type
      comment: "Type of dredging (capital, maintenance, emergency) — determines budget classification and urgency."
    - name: "disposal_type"
      expr: disposal_type
      comment: "Method of spoil disposal (open sea, confined facility, beneficial reuse) — critical for environmental compliance."
    - name: "sediment_contamination_level"
      expr: sediment_contamination_level
      comment: "Contamination classification of dredged sediment — drives disposal method and regulatory requirements."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of campaign cost reporting — required for multi-currency financial consolidation."
    - name: "start_year"
      expr: DATE_TRUNC('YEAR', start_date)
      comment: "Year the dredging campaign started — used for annual capital expenditure trend analysis."
  measures:
    - name: "total_campaigns"
      expr: COUNT(1)
      comment: "Total number of dredging campaigns — baseline for programme volume tracking."
    - name: "total_campaign_cost"
      expr: SUM(CAST(campaign_cost AS DOUBLE))
      comment: "Total expenditure across all dredging campaigns — primary financial KPI for capital maintenance budget management."
    - name: "avg_campaign_cost"
      expr: AVG(CAST(campaign_cost AS DOUBLE))
      comment: "Average cost per dredging campaign — benchmarks cost efficiency and identifies outliers requiring investigation."
    - name: "total_contracted_volume_m3"
      expr: SUM(CAST(contracted_volume_m3 AS DOUBLE))
      comment: "Total contracted dredging volume in cubic metres — measures programme scope and contractor commitment."
    - name: "total_actual_volume_dredged_m3"
      expr: SUM(CAST(actual_volume_dredged_m3 AS DOUBLE))
      comment: "Total actual volume dredged in cubic metres — measures physical delivery against contracted scope."
    - name: "total_volume_disposed_m3"
      expr: SUM(CAST(cumulative_volume_disposed_m3 AS DOUBLE))
      comment: "Total volume of spoil disposed — tracks environmental disposal compliance against approved limits."
    - name: "avg_design_depth_target_m"
      expr: AVG(CAST(design_depth_target_m AS DOUBLE))
      comment: "Average target dredging depth across campaigns — indicates the depth improvement being delivered to the port."
    - name: "total_environmental_incidents"
      expr: SUM(CAST(environmental_incident_count AS BIGINT))
      comment: "Total environmental incidents across all dredging campaigns — key HSE and regulatory compliance KPI."
    - name: "total_safety_incidents"
      expr: SUM(CAST(safety_incident_count AS BIGINT))
      comment: "Total safety incidents during dredging operations — drives HSE performance review and contractor evaluation."
    - name: "avg_weather_downtime_days"
      expr: AVG(CAST(weather_downtime_days AS DOUBLE))
      comment: "Average weather-related downtime days per campaign — informs scheduling risk and contingency planning."
    - name: "avg_operational_downtime_days"
      expr: AVG(CAST(operational_downtime_days AS DOUBLE))
      comment: "Average operational downtime days per campaign — measures contractor efficiency and equipment reliability."
$$;

CREATE OR REPLACE VIEW `vibe_shipping_ports_v1`.`_metrics`.`infrastructure_depth_survey`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Hydrographic survey KPIs — tracks channel and berth depth conditions, shoaling risk, and dredging trigger thresholds to maintain navigational safety."
  source: "`vibe_shipping_ports_v1`.`infrastructure`.`depth_survey`"
  dimensions:
    - name: "survey_area_type"
      expr: survey_area_type
      comment: "Type of area surveyed (channel, berth, anchorage) — segments depth performance by infrastructure type."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the survey report — tracks regulatory sign-off on navigational safety data."
    - name: "dredging_required_flag"
      expr: dredging_required_flag
      comment: "Whether the survey triggered a dredging requirement — key operational decision flag."
    - name: "shoaling_detected_flag"
      expr: shoaling_detected_flag
      comment: "Whether shoaling was detected — primary risk indicator for navigational safety management."
    - name: "dredging_priority"
      expr: dredging_priority
      comment: "Priority classification for dredging action — drives maintenance scheduling and budget allocation."
    - name: "survey_year"
      expr: DATE_TRUNC('YEAR', survey_date)
      comment: "Year of the depth survey — used for trend analysis of depth degradation over time."
  measures:
    - name: "total_surveys"
      expr: COUNT(1)
      comment: "Total number of depth surveys conducted — baseline for survey programme coverage tracking."
    - name: "avg_mean_depth_m"
      expr: AVG(CAST(mean_depth_m AS DOUBLE))
      comment: "Average mean depth recorded across surveys — primary navigational safety KPI for channel and berth management."
    - name: "avg_minimum_depth_recorded_m"
      expr: AVG(CAST(minimum_depth_recorded_m AS DOUBLE))
      comment: "Average minimum depth recorded — identifies the shallowest points constraining vessel draft and triggering dredging."
    - name: "avg_depth_variance_m"
      expr: AVG(CAST(depth_variance_m AS DOUBLE))
      comment: "Average variance between design depth and surveyed depth — measures depth degradation and dredging effectiveness."
    - name: "total_shoaling_volume_cbm"
      expr: SUM(CAST(shoaling_volume_cbm AS DOUBLE))
      comment: "Total shoaling volume in cubic metres across all surveys — quantifies the dredging backlog and maintenance liability."
    - name: "total_survey_cost"
      expr: SUM(CAST(survey_cost_amount AS DOUBLE))
      comment: "Total expenditure on depth surveys — tracks hydrographic programme cost for budget management."
    - name: "avg_survey_cost"
      expr: AVG(CAST(survey_cost_amount AS DOUBLE))
      comment: "Average cost per depth survey — benchmarks survey procurement efficiency."
    - name: "surveys_requiring_dredging_count"
      expr: COUNT(CASE WHEN dredging_required_flag = TRUE THEN 1 END)
      comment: "Number of surveys that triggered a dredging requirement — measures the rate of depth degradation across the port."
    - name: "total_survey_coverage_area_sqm"
      expr: SUM(CAST(survey_coverage_area_sqm AS DOUBLE))
      comment: "Total area covered by depth surveys in square metres — measures hydrographic programme completeness."
$$;

CREATE OR REPLACE VIEW `vibe_shipping_ports_v1`.`_metrics`.`infrastructure_structural_inspection`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Structural integrity and maintenance KPIs for port infrastructure — tracks defect rates, repair costs, and compliance to drive asset lifecycle decisions."
  source: "`vibe_shipping_ports_v1`.`infrastructure`.`structural_inspection`"
  dimensions:
    - name: "inspection_type"
      expr: inspection_type
      comment: "Type of structural inspection (routine, special, post-incident) — segments inspection activity by trigger."
    - name: "asset_type"
      expr: asset_type
      comment: "Type of asset inspected (berth, quay wall, navigational aid) — enables asset-class performance comparison."
    - name: "overall_condition_rating"
      expr: overall_condition_rating
      comment: "Overall structural condition rating assigned by the inspector — primary asset health KPI dimension."
    - name: "remediation_priority"
      expr: remediation_priority
      comment: "Priority assigned to remediation work — drives maintenance scheduling and budget allocation."
    - name: "safety_risk_level"
      expr: safety_risk_level
      comment: "Safety risk classification from the inspection — critical for operational risk management decisions."
    - name: "inspection_status"
      expr: inspection_status
      comment: "Current status of the inspection (open, completed, overdue) — tracks programme execution."
    - name: "inspection_year"
      expr: DATE_TRUNC('YEAR', inspection_date)
      comment: "Year of inspection — used for annual defect trend and cost trend analysis."
  measures:
    - name: "total_inspections"
      expr: COUNT(1)
      comment: "Total number of structural inspections conducted — baseline for inspection programme coverage."
    - name: "total_estimated_repair_cost"
      expr: SUM(CAST(estimated_repair_cost AS DOUBLE))
      comment: "Total estimated repair cost across all inspections — quantifies the infrastructure maintenance liability for capital planning."
    - name: "avg_estimated_repair_cost"
      expr: AVG(CAST(estimated_repair_cost AS DOUBLE))
      comment: "Average estimated repair cost per inspection — benchmarks maintenance cost intensity across asset types."
    - name: "total_critical_defects"
      expr: SUM(CAST(critical_defects_count AS BIGINT))
      comment: "Total critical defects identified across all inspections — primary safety and asset integrity KPI requiring immediate executive attention."
    - name: "total_major_defects"
      expr: SUM(CAST(major_defects_count AS BIGINT))
      comment: "Total major defects identified — measures the volume of significant structural issues requiring planned remediation."
    - name: "total_minor_defects"
      expr: SUM(CAST(minor_defects_count AS BIGINT))
      comment: "Total minor defects identified — tracks the overall defect backlog for maintenance prioritisation."
    - name: "avg_inspection_duration_hours"
      expr: AVG(CAST(inspection_duration_hours AS DOUBLE))
      comment: "Average inspection duration in hours — measures inspection thoroughness and resource efficiency."
    - name: "regulatory_compliant_inspection_count"
      expr: COUNT(CASE WHEN regulatory_compliance_flag = TRUE THEN 1 END)
      comment: "Number of inspections meeting regulatory compliance requirements — tracks statutory inspection programme adherence."
    - name: "inspections_with_critical_defects_count"
      expr: COUNT(CASE WHEN CAST(critical_defects_count AS BIGINT) > 0 THEN 1 END)
      comment: "Number of inspections that found at least one critical defect — measures the prevalence of high-risk structural issues."
$$;

CREATE OR REPLACE VIEW `vibe_shipping_ports_v1`.`_metrics`.`infrastructure_project`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Capital infrastructure project performance KPIs — tracks budget adherence, delivery timelines, and project portfolio health for executive investment oversight."
  source: "`vibe_shipping_ports_v1`.`infrastructure`.`project`"
  dimensions:
    - name: "project_type"
      expr: project_type
      comment: "Type of infrastructure project (berth construction, dredging, reclamation, upgrade) — segments the capital portfolio."
    - name: "project_status"
      expr: project_status
      comment: "Current project status (planned, in-progress, completed, on-hold) — tracks portfolio execution health."
    - name: "project_category"
      expr: project_category
      comment: "Business category of the project (capacity expansion, maintenance, compliance, sustainability) — aligns spend to strategic objectives."
    - name: "phase"
      expr: phase
      comment: "Current project phase (design, procurement, construction, commissioning) — tracks delivery pipeline stage."
    - name: "priority"
      expr: priority
      comment: "Project priority classification — used for resource allocation and portfolio sequencing decisions."
    - name: "risk_rating"
      expr: risk_rating
      comment: "Overall risk rating of the project — drives executive attention and contingency planning."
    - name: "planned_start_year"
      expr: DATE_TRUNC('YEAR', planned_start_date)
      comment: "Planned start year — used for capital expenditure phasing and annual budget planning."
  measures:
    - name: "total_projects"
      expr: COUNT(1)
      comment: "Total number of infrastructure projects in the portfolio — baseline for programme scale assessment."
    - name: "total_approved_capex_budget"
      expr: SUM(CAST(approved_capex_budget AS DOUBLE))
      comment: "Total approved capital expenditure budget across all projects — primary financial KPI for infrastructure investment planning."
    - name: "total_actual_expenditure_to_date"
      expr: SUM(CAST(actual_expenditure_to_date AS DOUBLE))
      comment: "Total actual capital expenditure incurred to date — measures budget consumption and cash flow against plan."
    - name: "avg_approved_capex_budget"
      expr: AVG(CAST(approved_capex_budget AS DOUBLE))
      comment: "Average approved budget per project — benchmarks project scale and identifies outliers in the portfolio."
    - name: "total_budget_variance"
      expr: SUM(CAST(approved_capex_budget AS DOUBLE) - CAST(actual_expenditure_to_date AS DOUBLE))
      comment: "Total remaining budget across all projects (approved minus actual) — measures overall portfolio budget headroom."
    - name: "avg_berth_length_increase_m"
      expr: AVG(CAST(berth_length_increase_m AS DOUBLE))
      comment: "Average berth length increase delivered by projects — quantifies the physical capacity uplift from the capital programme."
    - name: "projects_overdue_count"
      expr: COUNT(CASE WHEN planned_completion_date < CURRENT_DATE() AND project_status NOT IN ('completed', 'closed') THEN 1 END)
      comment: "Number of projects past their planned completion date — key delivery performance KPI requiring executive intervention."
    - name: "projects_requiring_eia_count"
      expr: COUNT(CASE WHEN environmental_impact_assessment_required = TRUE THEN 1 END)
      comment: "Number of projects requiring environmental impact assessment — tracks regulatory compliance obligations in the capital programme."
    - name: "avg_design_vessel_loa_m"
      expr: AVG(CAST(design_vessel_loa_m AS DOUBLE))
      comment: "Average design vessel LOA for infrastructure projects — indicates the vessel size class the port is investing to accommodate."
$$;

CREATE OR REPLACE VIEW `vibe_shipping_ports_v1`.`_metrics`.`infrastructure_project_service_cost`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Project service cost KPIs — tracks budget vs actual cost performance at the service line level for capital project financial control."
  source: "`vibe_shipping_ports_v1`.`infrastructure`.`project_service_cost`"
  dimensions:
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the service cost record — tracks financial authorisation compliance."
    - name: "cost_status"
      expr: cost_status
      comment: "Current status of the cost item (committed, invoiced, paid) — tracks procure-to-pay pipeline."
    - name: "unit_of_measure"
      expr: unit_of_measure
      comment: "Unit of measure for the service quantity — enables unit cost benchmarking across service types."
    - name: "service_start_year"
      expr: DATE_TRUNC('YEAR', service_start_date)
      comment: "Year the service commenced — used for annual capital expenditure phasing analysis."
    - name: "gl_posting_year"
      expr: DATE_TRUNC('YEAR', gl_posting_date)
      comment: "Year of GL posting — aligns project costs to financial reporting periods."
  measures:
    - name: "total_actual_cost"
      expr: SUM(CAST(actual_cost AS DOUBLE))
      comment: "Total actual cost incurred across all project service lines — primary financial control KPI for capital project management."
    - name: "total_budgeted_amount"
      expr: SUM(CAST(budgeted_amount AS DOUBLE))
      comment: "Total budgeted amount across all project service lines — baseline for budget vs actual variance analysis."
    - name: "total_variance_amount"
      expr: SUM(CAST(variance_amount AS DOUBLE))
      comment: "Total cost variance (budget minus actual) across all service lines — measures overall project cost control performance."
    - name: "avg_actual_cost_per_service"
      expr: AVG(CAST(actual_cost AS DOUBLE))
      comment: "Average actual cost per service line — benchmarks unit service cost for procurement efficiency analysis."
    - name: "total_quantity"
      expr: SUM(CAST(quantity AS DOUBLE))
      comment: "Total quantity of services delivered — measures physical delivery volume for productivity analysis."
    - name: "over_budget_service_count"
      expr: COUNT(CASE WHEN actual_cost > budgeted_amount THEN 1 END)
      comment: "Number of service lines where actual cost exceeded budget — identifies cost overrun frequency for project control improvement."
$$;

CREATE OR REPLACE VIEW `vibe_shipping_ports_v1`.`_metrics`.`infrastructure_permit`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Regulatory permit portfolio KPIs — tracks permit compliance, expiry risk, and non-compliance history to manage regulatory obligations and avoid operational disruptions."
  source: "`vibe_shipping_ports_v1`.`infrastructure`.`permit`"
  dimensions:
    - name: "permit_type"
      expr: permit_type
      comment: "Type of permit (environmental, construction, operational, MARPOL) — segments the regulatory compliance portfolio."
    - name: "permit_status"
      expr: permit_status
      comment: "Current permit status (active, expired, suspended, revoked) — primary compliance health dimension."
    - name: "issuing_authority"
      expr: issuing_authority
      comment: "Regulatory authority that issued the permit — tracks compliance obligations by regulator."
    - name: "regulatory_framework"
      expr: regulatory_framework
      comment: "Regulatory framework governing the permit (MARPOL, SOLAS, local planning) — aligns permits to compliance domains."
    - name: "environmental_sensitivity_flag"
      expr: environmental_sensitivity_flag
      comment: "Whether the permit relates to an environmentally sensitive area — prioritises compliance monitoring."
    - name: "expiry_year"
      expr: DATE_TRUNC('YEAR', expiry_date)
      comment: "Year the permit expires — used for renewal pipeline planning and risk management."
  measures:
    - name: "total_permits"
      expr: COUNT(1)
      comment: "Total number of permits in the portfolio — baseline for regulatory compliance programme scope."
    - name: "active_permit_count"
      expr: COUNT(CASE WHEN permit_status = 'active' THEN 1 END)
      comment: "Number of currently active permits — measures the live regulatory compliance footprint."
    - name: "expired_permit_count"
      expr: COUNT(CASE WHEN permit_status = 'expired' THEN 1 END)
      comment: "Number of expired permits — critical compliance risk KPI; expired permits can halt operations."
    - name: "permits_expiring_within_90_days"
      expr: COUNT(CASE WHEN expiry_date BETWEEN CURRENT_DATE() AND DATE_ADD(CURRENT_DATE(), 90) THEN 1 END)
      comment: "Number of permits expiring within 90 days — forward-looking renewal risk indicator for compliance management."
    - name: "total_non_compliance_count"
      expr: SUM(CAST(non_compliance_count AS BIGINT))
      comment: "Total number of non-compliance events across all permits — primary regulatory risk KPI for executive oversight."
    - name: "total_financial_security_amount"
      expr: SUM(CAST(financial_security_amount AS DOUBLE))
      comment: "Total financial security (bonds/guarantees) held against permits — measures regulatory financial exposure."
    - name: "permits_with_non_compliance_count"
      expr: COUNT(CASE WHEN CAST(non_compliance_count AS BIGINT) > 0 THEN 1 END)
      comment: "Number of permits with at least one non-compliance event — measures the breadth of compliance issues across the portfolio."
$$;

CREATE OR REPLACE VIEW `vibe_shipping_ports_v1`.`_metrics`.`infrastructure_berth_reservation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Berth reservation and utilisation KPIs — tracks berth occupancy, schedule adherence, and cancellation rates to optimise berth allocation and vessel turnaround."
  source: "`vibe_shipping_ports_v1`.`infrastructure`.`infrastructure_berth_reservation`"
  dimensions:
    - name: "reservation_status"
      expr: reservation_status
      comment: "Status of the berth reservation (confirmed, cancelled, completed) — tracks reservation pipeline health."
    - name: "berth_side"
      expr: berth_side
      comment: "Side of berth assigned (port, starboard) — operational dimension for berth planning."
    - name: "tidal_window_required"
      expr: tidal_window_required
      comment: "Whether the reservation requires a tidal window — identifies scheduling constraints affecting berth utilisation."
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level of the reservation — used to analyse how priority affects berth allocation outcomes."
    - name: "reservation_created_year"
      expr: DATE_TRUNC('YEAR', reservation_created_timestamp)
      comment: "Year the reservation was created — used for annual berth demand trend analysis."
  measures:
    - name: "total_reservations"
      expr: COUNT(1)
      comment: "Total number of berth reservations — baseline for berth demand volume tracking."
    - name: "cancelled_reservation_count"
      expr: COUNT(CASE WHEN reservation_status = 'cancelled' THEN 1 END)
      comment: "Number of cancelled berth reservations — measures demand volatility and its impact on berth planning efficiency."
    - name: "tidal_constrained_reservation_count"
      expr: COUNT(CASE WHEN tidal_window_required = TRUE THEN 1 END)
      comment: "Number of reservations requiring tidal windows — quantifies the scheduling constraint imposed by tidal conditions."
$$;

CREATE OR REPLACE VIEW `vibe_shipping_ports_v1`.`_metrics`.`infrastructure_anchorage_booking`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Anchorage utilisation and waiting time KPIs — tracks vessel anchorage demand, dwell times, and allocation efficiency to reduce pre-berth waiting costs."
  source: "`vibe_shipping_ports_v1`.`infrastructure`.`infrastructure_anchorage_booking`"
  dimensions:
    - name: "anchorage_booking_status"
      expr: anchorage_booking_status
      comment: "Status of the anchorage booking (allocated, completed, cancelled) — tracks anchorage demand pipeline."
    - name: "anchorage_reason_code"
      expr: anchorage_reason_code
      comment: "Reason for anchorage (awaiting berth, customs, weather, bunkering) — identifies root causes of pre-berth waiting."
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level of the anchorage booking — used to analyse priority-based allocation fairness."
    - name: "booking_year"
      expr: DATE_TRUNC('YEAR', created_timestamp)
      comment: "Year the anchorage booking was created — used for annual anchorage demand trend analysis."
  measures:
    - name: "total_anchorage_bookings"
      expr: COUNT(1)
      comment: "Total number of anchorage bookings — baseline for anchorage demand volume tracking."
    - name: "total_anchorage_duration_hours"
      expr: SUM(CAST(anchorage_duration_hours AS DOUBLE))
      comment: "Total anchorage dwell time in hours — measures the aggregate pre-berth waiting burden on shipping lines."
    - name: "avg_anchorage_duration_hours"
      expr: AVG(CAST(anchorage_duration_hours AS DOUBLE))
      comment: "Average anchorage dwell time per booking — primary vessel waiting time KPI; high values indicate berth congestion."
    - name: "max_anchorage_duration_hours"
      expr: MAX(anchorage_duration_hours)
      comment: "Maximum anchorage dwell time recorded — identifies extreme waiting events requiring operational investigation."
$$;

CREATE OR REPLACE VIEW `vibe_shipping_ports_v1`.`_metrics`.`infrastructure_utility_network`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Port utility infrastructure KPIs — tracks capacity, condition, and sustainability performance of power, water, and shore power networks to support decarbonisation and operational resilience."
  source: "`vibe_shipping_ports_v1`.`infrastructure`.`utility_network`"
  dimensions:
    - name: "network_type"
      expr: network_type
      comment: "Type of utility network (electrical, water, shore power, gas, telecoms) — segments infrastructure by utility class."
    - name: "network_status"
      expr: network_status
      comment: "Current operational status of the utility network — tracks availability for operational planning."
    - name: "criticality_rating"
      expr: criticality_rating
      comment: "Criticality classification of the network — prioritises maintenance and investment for high-impact assets."
    - name: "condition_rating"
      expr: condition_rating
      comment: "Physical condition rating of the network — drives asset replacement and refurbishment decisions."
    - name: "scada_integration_flag"
      expr: scada_integration_flag
      comment: "Whether the network is integrated with SCADA monitoring — measures smart infrastructure maturity."
    - name: "smart_metering_enabled"
      expr: smart_metering_enabled
      comment: "Whether smart metering is enabled — tracks digital infrastructure readiness for energy management."
    - name: "environmental_compliance_flag"
      expr: environmental_compliance_flag
      comment: "Whether the network meets environmental compliance requirements — critical for regulatory reporting."
  measures:
    - name: "total_utility_networks"
      expr: COUNT(1)
      comment: "Total number of utility networks in the port — baseline for infrastructure portfolio scope."
    - name: "total_design_capacity"
      expr: SUM(CAST(design_capacity AS DOUBLE))
      comment: "Total design capacity across all utility networks — measures the installed infrastructure capacity for operational planning."
    - name: "total_shore_power_kva_capacity"
      expr: SUM(CAST(shore_power_kva_capacity AS DOUBLE))
      comment: "Total shore power capacity in kVA across all utility networks — primary decarbonisation infrastructure KPI."
    - name: "total_ghg_emissions_reduction_tonnes_co2"
      expr: SUM(CAST(ghg_emissions_reduction_tonnes_co2_annual AS DOUBLE))
      comment: "Total annual GHG emissions reduction in tonnes CO2 from utility network improvements — measures decarbonisation impact."
    - name: "total_annual_opex_budget"
      expr: SUM(CAST(annual_opex_budget AS DOUBLE))
      comment: "Total annual operating expenditure budget for utility networks — tracks infrastructure running cost for financial planning."
    - name: "total_replacement_value"
      expr: SUM(CAST(replacement_value AS DOUBLE))
      comment: "Total replacement value of utility network assets — measures the financial exposure of the utility infrastructure portfolio."
    - name: "total_network_length_m"
      expr: SUM(CAST(total_network_length_m AS DOUBLE))
      comment: "Total length of utility networks in metres — measures the physical scale of port utility infrastructure."
    - name: "avg_operating_voltage_kv"
      expr: AVG(CAST(operating_voltage_kv AS DOUBLE))
      comment: "Average operating voltage across electrical networks — benchmarks power infrastructure capability."
    - name: "networks_with_expired_safety_certification"
      expr: COUNT(CASE WHEN safety_certification_expiry_date < CURRENT_DATE() THEN 1 END)
      comment: "Number of utility networks with expired safety certifications — critical compliance risk KPI for operational safety."
$$;

CREATE OR REPLACE VIEW `vibe_shipping_ports_v1`.`_metrics`.`infrastructure_warehouse`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Warehouse capacity and compliance KPIs — tracks storage utilisation, dangerous goods certification, and lease status to optimise cargo storage operations."
  source: "`vibe_shipping_ports_v1`.`infrastructure`.`warehouse`"
  dimensions:
    - name: "warehouse_type"
      expr: warehouse_type
      comment: "Type of warehouse (CFS, bonded, cold store, hazmat, general) — segments storage capacity by cargo type."
    - name: "operational_status"
      expr: operational_status
      comment: "Current operational status of the warehouse — tracks availability for cargo storage planning."
    - name: "ownership_type"
      expr: ownership_type
      comment: "Ownership model (owned, leased, PPP) — relevant for financial and asset management analysis."
    - name: "bonded_status"
      expr: bonded_status
      comment: "Whether the warehouse is customs-bonded — key dimension for FTZ and customs-controlled cargo analysis."
    - name: "temperature_control_capability"
      expr: temperature_control_capability
      comment: "Temperature control classification (ambient, chilled, frozen) — segments reefer and cold chain storage capacity."
    - name: "country_code"
      expr: country_code
      comment: "Country where the warehouse is located — enables geographic segmentation of storage capacity."
  measures:
    - name: "total_warehouses"
      expr: COUNT(1)
      comment: "Total number of warehouses in the portfolio — baseline for storage infrastructure scope."
    - name: "total_floor_area_sqm"
      expr: SUM(CAST(total_floor_area_sqm AS DOUBLE))
      comment: "Total gross floor area across all warehouses in square metres — primary storage capacity KPI for cargo planning."
    - name: "total_usable_storage_area_sqm"
      expr: SUM(CAST(usable_storage_area_sqm AS DOUBLE))
      comment: "Total usable storage area in square metres — measures effective storage capacity after operational exclusions."
    - name: "avg_floor_load_capacity_kn_per_sqm"
      expr: AVG(CAST(floor_load_capacity_kn_per_sqm AS DOUBLE))
      comment: "Average floor load capacity in kN/sqm — determines suitability for heavy cargo and stacking operations."
    - name: "total_insurance_coverage_amount"
      expr: SUM(CAST(insurance_coverage_amount AS DOUBLE))
      comment: "Total insurance coverage across all warehouses — measures financial risk protection for stored cargo."
    - name: "bonded_warehouse_count"
      expr: COUNT(CASE WHEN bonded_status = TRUE THEN 1 END)
      comment: "Number of customs-bonded warehouses — measures FTZ and customs-controlled storage capacity."
    - name: "avg_max_forklift_capacity_tonnes"
      expr: AVG(CAST(max_forklift_capacity_tonnes AS DOUBLE))
      comment: "Average maximum forklift capacity in tonnes — benchmarks material handling capability across the warehouse portfolio."
    - name: "warehouses_with_reefer_plugs_count"
      expr: COUNT(CASE WHEN CAST(reefer_plug_count AS BIGINT) > 0 THEN 1 END)
      comment: "Number of warehouses with reefer plug connections — measures cold chain storage infrastructure coverage."
$$;

CREATE OR REPLACE VIEW `vibe_shipping_ports_v1`.`_metrics`.`infrastructure_navigational_aid`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Navigational aid availability and maintenance KPIs — tracks operational status, inspection compliance, and criticality to maintain maritime safety standards."
  source: "`vibe_shipping_ports_v1`.`infrastructure`.`navigational_aid`"
  dimensions:
    - name: "aid_type"
      expr: aid_type
      comment: "Type of navigational aid (buoy, lighthouse, beacon, RACON, AtoN) — segments the aid portfolio by technology."
    - name: "operational_status"
      expr: operational_status
      comment: "Current operational status of the navigational aid — primary safety availability dimension."
    - name: "criticality_level"
      expr: criticality_level
      comment: "Criticality classification of the aid — prioritises maintenance response for high-impact aids."
    - name: "iala_classification"
      expr: iala_classification
      comment: "IALA classification of the navigational aid — aligns to international maritime marking standards."
    - name: "power_source_type"
      expr: power_source_type
      comment: "Power source type (solar, battery, mains) — relevant for maintenance planning and sustainability analysis."
  measures:
    - name: "total_navigational_aids"
      expr: COUNT(1)
      comment: "Total number of navigational aids in the port — baseline for maritime safety infrastructure inventory."
    - name: "operational_aid_count"
      expr: COUNT(CASE WHEN operational_status = 'operational' THEN 1 END)
      comment: "Number of navigational aids currently operational — primary maritime safety availability KPI."
    - name: "avg_availability_target_percent"
      expr: AVG(CAST(availability_target_percent AS DOUBLE))
      comment: "Average availability target percentage across navigational aids — benchmarks the contracted safety performance standard."
    - name: "aids_overdue_inspection_count"
      expr: COUNT(CASE WHEN next_inspection_due_date < CURRENT_DATE() THEN 1 END)
      comment: "Number of navigational aids with overdue inspections — critical safety compliance KPI requiring immediate action."
    - name: "avg_nominal_range_nm"
      expr: AVG(CAST(nominal_range_nm AS DOUBLE))
      comment: "Average nominal range in nautical miles across all aids — measures the navigational coverage provided by the aid network."
    - name: "critical_aids_not_operational_count"
      expr: COUNT(CASE WHEN criticality_level = 'critical' AND operational_status != 'operational' THEN 1 END)
      comment: "Number of critical navigational aids that are not operational — highest-priority maritime safety risk KPI."
$$;

CREATE OR REPLACE VIEW `vibe_shipping_ports_v1`.`_metrics`.`infrastructure_closure`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Infrastructure closure impact KPIs — tracks revenue impact, severity, and duration of port infrastructure closures to manage operational risk and business continuity."
  source: "`vibe_shipping_ports_v1`.`infrastructure`.`closure`"
  dimensions:
    - name: "infrastructure_type"
      expr: infrastructure_type
      comment: "Type of infrastructure closed (berth, channel, gate, anchorage) — segments closure impact by asset class."
    - name: "closure_status"
      expr: closure_status
      comment: "Current status of the closure (planned, active, resolved) — tracks the live operational impact."
    - name: "severity_level"
      expr: severity_level
      comment: "Severity classification of the closure — prioritises management response and escalation."
    - name: "reason"
      expr: reason
      comment: "Primary reason for the closure (maintenance, emergency, weather, regulatory) — identifies root cause patterns."
    - name: "safety_incident_flag"
      expr: safety_incident_flag
      comment: "Whether the closure was triggered by a safety incident — critical for HSE reporting and root cause analysis."
    - name: "planned_start_year"
      expr: DATE_TRUNC('YEAR', planned_start_datetime)
      comment: "Year the closure was planned to start — used for annual closure trend and impact analysis."
  measures:
    - name: "total_closures"
      expr: COUNT(1)
      comment: "Total number of infrastructure closures — baseline for operational disruption frequency tracking."
    - name: "total_estimated_revenue_impact_usd"
      expr: SUM(CAST(estimated_revenue_impact_usd AS DOUBLE))
      comment: "Total estimated revenue impact of infrastructure closures in USD — primary financial risk KPI for business continuity management."
    - name: "avg_estimated_revenue_impact_usd"
      expr: AVG(CAST(estimated_revenue_impact_usd AS DOUBLE))
      comment: "Average revenue impact per closure — benchmarks the financial cost of infrastructure disruptions."
    - name: "avg_capacity_reduction_percentage"
      expr: AVG(CAST(capacity_reduction_percentage AS DOUBLE))
      comment: "Average capacity reduction during closures — measures the operational impact severity on port throughput."
    - name: "safety_triggered_closure_count"
      expr: COUNT(CASE WHEN safety_incident_flag = TRUE THEN 1 END)
      comment: "Number of closures triggered by safety incidents — measures the operational cost of safety events."
    - name: "total_affected_vessel_calls"
      expr: SUM(CAST(affected_vessel_calls_count AS BIGINT))
      comment: "Total number of vessel calls affected by infrastructure closures — measures the commercial impact on shipping line customers."
    - name: "avg_extension_count"
      expr: AVG(CAST(extension_count AS DOUBLE))
      comment: "Average number of closure extensions per event — measures planning accuracy and the tendency for closures to overrun."
$$;

CREATE OR REPLACE VIEW `vibe_shipping_ports_v1`.`_metrics`.`infrastructure_berth_allocation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Berth allocation agreement KPIs — tracks throughput commitments, revenue share, and allocation exclusivity to optimise long-term berth licensing decisions."
  source: "`vibe_shipping_ports_v1`.`infrastructure`.`infrastructure_berth_allocation`"
  dimensions:
    - name: "allocation_status"
      expr: allocation_status
      comment: "Current status of the berth allocation (active, expired, pending) — tracks the live allocation portfolio."
    - name: "allocation_type"
      expr: allocation_type
      comment: "Type of berth allocation (dedicated, shared, time-slot) — segments allocation by commercial model."
    - name: "exclusive_use_flag"
      expr: exclusive_use_flag
      comment: "Whether the allocation grants exclusive berth use — key commercial dimension for revenue and capacity planning."
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level of the allocation — used to analyse how priority affects berth assignment outcomes."
    - name: "allocation_start_year"
      expr: DATE_TRUNC('YEAR', allocation_start_date)
      comment: "Year the allocation commenced — used for annual berth commitment trend analysis."
  measures:
    - name: "total_allocations"
      expr: COUNT(1)
      comment: "Total number of berth allocations — baseline for berth commitment portfolio scope."
    - name: "total_throughput_commitment_teu"
      expr: SUM(CAST(throughput_commitment_teu AS DOUBLE))
      comment: "Total TEU throughput committed under berth allocation agreements — primary commercial KPI for berth revenue planning."
    - name: "avg_throughput_commitment_teu"
      expr: AVG(CAST(throughput_commitment_teu AS DOUBLE))
      comment: "Average TEU throughput commitment per allocation — benchmarks the commercial scale of individual berth agreements."
    - name: "avg_revenue_share_percentage"
      expr: AVG(CAST(revenue_share_percentage AS DOUBLE))
      comment: "Average revenue share percentage across berth allocations — measures the port's revenue participation in terminal operations."
    - name: "exclusive_allocation_count"
      expr: COUNT(CASE WHEN exclusive_use_flag = TRUE THEN 1 END)
      comment: "Number of exclusive berth allocations — measures the proportion of berth capacity committed to single operators."
$$;