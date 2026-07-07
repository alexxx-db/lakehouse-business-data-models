-- Metric views for domain: restaurant | Business: Restaurants | Version: 2 | Generated on: 2026-07-02 03:10:25

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`restaurant_unit_performance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core financial and operational KPIs per restaurant unit per performance period. Drives QBR dashboards, P&L reviews, and unit-level investment decisions."
  source: "`vibe_restaurants_v1`.`restaurant`.`unit_performance`"
  dimensions:
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year for period-over-period trending and annual planning."
    - name: "fiscal_quarter"
      expr: fiscal_quarter
      comment: "Fiscal quarter for quarterly business review segmentation."
    - name: "fiscal_month"
      expr: fiscal_month
      comment: "Fiscal month for monthly P&L reporting."
    - name: "fiscal_week"
      expr: fiscal_week
      comment: "Fiscal week for weekly operational cadence reviews."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which financial figures are reported."
    - name: "performance_status"
      expr: performance_status
      comment: "Status of the performance record (e.g., final, preliminary) for data quality filtering."
  measures:
    - name: "total_gross_revenue"
      expr: SUM(CAST(gross_revenue_amount AS DOUBLE))
      comment: "Total gross revenue across all units and periods. Primary top-line KPI for executive revenue tracking."
    - name: "total_net_revenue"
      expr: SUM(CAST(net_revenue_amount AS DOUBLE))
      comment: "Total net revenue after discounts and adjustments. Used for margin and profitability analysis."
    - name: "total_cogs"
      expr: SUM(CAST(cogs_amount AS DOUBLE))
      comment: "Total cost of goods sold. Drives food cost management and supplier negotiation decisions."
    - name: "avg_cogs_percent"
      expr: AVG(CAST(cogs_percent AS DOUBLE))
      comment: "Average COGS as a percentage of revenue. Benchmark against target to identify units with food cost issues."
    - name: "total_labor_cost"
      expr: SUM(CAST(labor_cost_amount AS DOUBLE))
      comment: "Total labor cost. Key input for workforce scheduling and labor efficiency decisions."
    - name: "avg_labor_percent"
      expr: AVG(CAST(labor_percent AS DOUBLE))
      comment: "Average labor cost as a percentage of revenue. Triggers staffing reviews when above target thresholds."
    - name: "total_operating_income"
      expr: SUM(CAST(operating_income_amount AS DOUBLE))
      comment: "Total operating income. Core profitability KPI used in board-level financial reporting."
    - name: "total_ebitda"
      expr: SUM(CAST(ebitda_amount AS DOUBLE))
      comment: "Total EBITDA across units. Used for franchise valuation, investment decisions, and lender covenants."
    - name: "total_net_income"
      expr: SUM(CAST(net_income_amount AS DOUBLE))
      comment: "Total net income. Bottom-line profitability metric for ownership and investor reporting."
    - name: "avg_sss_growth_percent"
      expr: AVG(CAST(sss_growth_percent AS DOUBLE))
      comment: "Average same-store sales growth percentage. Critical comp-sales KPI for brand health and investor confidence."
    - name: "total_comp_sales"
      expr: SUM(CAST(comp_sales_amount AS DOUBLE))
      comment: "Total comparable store sales. Used to assess organic growth excluding new unit openings."
    - name: "avg_comp_sales_variance"
      expr: AVG(CAST(comp_sales_variance_amount AS DOUBLE))
      comment: "Average variance of comp sales vs. prior period. Identifies units underperforming vs. system average."
    - name: "total_acv"
      expr: SUM(CAST(acv_amount AS DOUBLE))
      comment: "Total average check value across units. Drives menu pricing and upsell strategy decisions."
    - name: "avg_acv"
      expr: AVG(CAST(acv_amount AS DOUBLE))
      comment: "Average check value per unit-period record. Benchmarks pricing effectiveness across the portfolio."
    - name: "total_waste"
      expr: SUM(CAST(waste_amount AS DOUBLE))
      comment: "Total food waste cost. Drives waste reduction programs and inventory management improvements."
    - name: "avg_waste_percent"
      expr: AVG(CAST(waste_percent AS DOUBLE))
      comment: "Average waste as a percentage of revenue. Triggers operational intervention when above acceptable thresholds."
    - name: "total_rent_expense"
      expr: SUM(CAST(rent_expense_amount AS DOUBLE))
      comment: "Total rent expense. Used in occupancy cost analysis and lease renegotiation decisions."
    - name: "total_marketing_expense"
      expr: SUM(CAST(marketing_expense_amount AS DOUBLE))
      comment: "Total marketing spend at unit level. Informs local store marketing ROI and fund allocation decisions."
    - name: "total_rm_expense"
      expr: SUM(CAST(rm_expense_amount AS DOUBLE))
      comment: "Total repair and maintenance expense. Tracks facility upkeep costs and triggers capital planning reviews."
    - name: "total_utility_expense"
      expr: SUM(CAST(utility_expense_amount AS DOUBLE))
      comment: "Total utility expense. Monitors energy costs and supports sustainability and efficiency initiatives."
    - name: "total_operating_expenses"
      expr: SUM(CAST(total_operating_expenses_amount AS DOUBLE))
      comment: "Total operating expenses. Comprehensive cost base for unit-level P&L and four-wall economics analysis."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`restaurant_unit`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Portfolio-level restaurant unit metrics covering financial benchmarks, operational characteristics, and unit health. Used for network planning, brand management, and investment prioritization."
  source: "`vibe_restaurants_v1`.`restaurant`.`unit`"
  dimensions:
    - name: "ownership_model"
      expr: ownership_model
      comment: "Ownership model (company-owned vs. franchise) for portfolio segmentation and comparative analysis."
    - name: "concept_type"
      expr: concept_type
      comment: "Restaurant concept type (QSR, fast casual, casual dining) for format-level benchmarking."
    - name: "country_code"
      expr: country_code
      comment: "Country for geographic performance analysis and international expansion planning."
    - name: "state_province"
      expr: state_province
      comment: "State or province for regional performance segmentation."
    - name: "city"
      expr: city
      comment: "City for local market analysis and trade area performance."
    - name: "operational_status"
      expr: CAST(operational_status AS STRING)
      comment: "Current operational status of the unit for active/inactive portfolio filtering."
    - name: "has_drive_thru"
      expr: CAST(has_online_ordering AS STRING)
      comment: "Whether the unit has online ordering enabled, for digital channel segmentation."
    - name: "has_third_party_delivery"
      expr: CAST(has_third_party_delivery AS STRING)
      comment: "Whether the unit supports third-party delivery for off-premise revenue analysis."
    - name: "opening_date"
      expr: DATE_TRUNC('YEAR', opening_date)
      comment: "Year the unit opened, for cohort analysis of new vs. mature units."
  measures:
    - name: "total_units"
      expr: COUNT(DISTINCT unit_id)
      comment: "Total number of restaurant units in the portfolio. Core network size KPI for growth tracking."
    - name: "avg_annual_unit_volume"
      expr: AVG(CAST(average_unit_volume_usd AS DOUBLE))
      comment: "Average annual unit volume (AUV) in USD. Primary brand health and unit economics benchmark used in franchise sales and investor reporting."
    - name: "total_portfolio_auv"
      expr: SUM(CAST(average_unit_volume_usd AS DOUBLE))
      comment: "Total system-wide AUV. Represents the aggregate revenue potential of the entire restaurant network."
    - name: "avg_health_inspection_score"
      expr: AVG(CAST(health_inspection_score AS DOUBLE))
      comment: "Average health inspection score across units. Tracks food safety compliance and regulatory risk at portfolio level."
    - name: "avg_same_store_sales_pct"
      expr: AVG(CAST(same_store_sales_pct AS DOUBLE))
      comment: "Average same-store sales percentage across the portfolio. Key comp-sales metric for brand momentum and investor confidence."
    - name: "avg_table_turn_rate"
      expr: AVG(CAST(table_turn_rate AS DOUBLE))
      comment: "Average table turn rate across units. Drives seating capacity utilization and revenue-per-seat optimization decisions."
    - name: "haccp_certified_unit_count"
      expr: COUNT(CASE WHEN haccp_certified = TRUE THEN unit_id END)
      comment: "Number of units with HACCP certification. Tracks food safety compliance across the network."
    - name: "online_ordering_unit_count"
      expr: COUNT(CASE WHEN has_online_ordering = TRUE THEN unit_id END)
      comment: "Number of units with online ordering enabled. Measures digital channel penetration across the portfolio."
    - name: "third_party_delivery_unit_count"
      expr: COUNT(CASE WHEN has_third_party_delivery = TRUE THEN unit_id END)
      comment: "Number of units with third-party delivery. Tracks off-premise revenue channel coverage."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`restaurant_sos_measurement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Speed-of-service (SOS) performance metrics tracking actual vs. target service times. Drives operational efficiency, staffing, and guest satisfaction decisions."
  source: "`vibe_restaurants_v1`.`restaurant`.`sos_measurement`"
  dimensions:
    - name: "service_channel"
      expr: service_channel
      comment: "Service channel (drive-thru, dine-in, delivery) for channel-specific SOS benchmarking."
    - name: "measurement_source"
      expr: measurement_source
      comment: "Source of the SOS measurement (timer, POS, manual) for data quality segmentation."
    - name: "peak_period_flag"
      expr: CAST(peak_period_flag AS STRING)
      comment: "Whether the measurement occurred during a peak period. Enables peak vs. off-peak SOS comparison."
    - name: "target_met_flag"
      expr: CAST(target_met_flag AS STRING)
      comment: "Whether the SOS target was met. Used for compliance rate trending and operational alerts."
    - name: "equipment_issue_flag"
      expr: CAST(equipment_issue_flag AS STRING)
      comment: "Whether an equipment issue contributed to SOS miss. Drives maintenance prioritization decisions."
    - name: "measurement_date"
      expr: DATE_TRUNC('DAY', measurement_timestamp)
      comment: "Date of the SOS measurement for daily trend analysis."
    - name: "measurement_week"
      expr: DATE_TRUNC('WEEK', measurement_timestamp)
      comment: "Week of the SOS measurement for weekly operational review cadence."
  measures:
    - name: "avg_ticket_time_seconds"
      expr: AVG(CAST(measurement_quality_score AS DOUBLE))
      comment: "Average measurement quality score across SOS events. Tracks reliability of SOS data collection."
    - name: "avg_nps_score"
      expr: AVG(CAST(nps_score AS DOUBLE))
      comment: "Average NPS score associated with SOS measurements. Links service speed to guest satisfaction outcomes."
    - name: "avg_order_complexity_score"
      expr: AVG(CAST(order_complexity_score AS DOUBLE))
      comment: "Average order complexity score. Used to normalize SOS performance against order difficulty."
    - name: "sos_target_met_count"
      expr: COUNT(CASE WHEN target_met_flag = TRUE THEN sos_measurement_id END)
      comment: "Number of SOS measurements where the target was met. Numerator for SOS compliance rate calculation."
    - name: "total_sos_measurements"
      expr: COUNT(1)
      comment: "Total SOS measurement events. Denominator for SOS compliance rate and volume tracking."
    - name: "service_recovery_event_count"
      expr: COUNT(CASE WHEN service_recovery_flag = TRUE THEN sos_measurement_id END)
      comment: "Number of SOS events requiring service recovery. Tracks guest experience failures linked to speed issues."
    - name: "equipment_issue_event_count"
      expr: COUNT(CASE WHEN equipment_issue_flag = TRUE THEN sos_measurement_id END)
      comment: "Number of SOS events impacted by equipment issues. Drives preventive maintenance prioritization."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`restaurant_ops_visit`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Operational visit audit metrics tracking brand standard compliance, food quality, safety, and service scores. Used by field operations and brand teams to manage unit quality."
  source: "`vibe_restaurants_v1`.`restaurant`.`ops_visit`"
  dimensions:
    - name: "visit_type"
      expr: visit_type
      comment: "Type of ops visit (announced, unannounced, follow-up) for compliance analysis segmentation."
    - name: "visit_category"
      expr: visit_category
      comment: "Category of the visit (food safety, brand standards, operations) for targeted performance tracking."
    - name: "brand_standard_compliance_status"
      expr: brand_standard_compliance_status
      comment: "Overall brand standard compliance status from the visit. Key quality gate for franchise management."
    - name: "corrective_action_required_flag"
      expr: CAST(corrective_action_required_flag AS STRING)
      comment: "Whether corrective action was required. Drives follow-up visit scheduling and franchisee accountability."
    - name: "follow_up_visit_required_flag"
      expr: CAST(follow_up_visit_required_flag AS STRING)
      comment: "Whether a follow-up visit was required. Tracks escalation rate from initial visits."
    - name: "visit_date_month"
      expr: DATE_TRUNC('MONTH', visit_date)
      comment: "Month of the ops visit for monthly compliance trend analysis."
    - name: "visit_priority_level"
      expr: visit_priority_level
      comment: "Priority level of the visit for risk-based visit scheduling analysis."
    - name: "daypart_observed"
      expr: daypart_observed
      comment: "Daypart during which the visit was conducted for time-of-day compliance analysis."
  measures:
    - name: "avg_overall_visit_score"
      expr: AVG(CAST(overall_visit_score AS DOUBLE))
      comment: "Average overall ops visit score. Primary brand quality KPI used in franchise performance scorecards and QBRs."
    - name: "avg_food_quality_score"
      expr: AVG(CAST(food_quality_score AS DOUBLE))
      comment: "Average food quality score from ops visits. Drives menu execution and kitchen training decisions."
    - name: "avg_safety_score"
      expr: AVG(CAST(safety_score AS DOUBLE))
      comment: "Average safety score from ops visits. Tracks food safety and workplace safety compliance trends."
    - name: "avg_service_score"
      expr: AVG(CAST(service_score AS DOUBLE))
      comment: "Average service score from ops visits. Measures guest-facing service quality across the portfolio."
    - name: "avg_speed_score"
      expr: AVG(CAST(speed_score AS DOUBLE))
      comment: "Average speed score from ops visits. Links operational throughput to brand standard compliance."
    - name: "avg_cleanliness_score"
      expr: AVG(CAST(cleanliness_score AS DOUBLE))
      comment: "Average cleanliness score from ops visits. Tracks sanitation standards and guest environment quality."
    - name: "avg_checklist_completion_pct"
      expr: AVG(CAST(checklist_completion_percentage AS DOUBLE))
      comment: "Average checklist completion percentage. Measures thoroughness of ops visit execution."
    - name: "total_visits"
      expr: COUNT(1)
      comment: "Total number of ops visits conducted. Tracks visit cadence and field operations activity."
    - name: "corrective_action_required_count"
      expr: COUNT(CASE WHEN corrective_action_required_flag = TRUE THEN ops_visit_id END)
      comment: "Number of visits requiring corrective action. Tracks non-compliance rate across the portfolio."
    - name: "avg_visit_duration_minutes"
      expr: AVG(CAST(visit_duration_minutes AS DOUBLE))
      comment: "Average duration of ops visits in minutes. Informs field team capacity planning and visit quality standards."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`restaurant_ops_visit_finding`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Granular ops visit finding metrics tracking compliance violations, corrective actions, and repeat findings. Drives brand standard enforcement and root-cause analysis."
  source: "`vibe_restaurants_v1`.`restaurant`.`ops_visit_finding`"
  dimensions:
    - name: "finding_category"
      expr: finding_category
      comment: "Category of the finding (food safety, cleanliness, service) for systemic issue identification."
    - name: "finding_subcategory"
      expr: finding_subcategory
      comment: "Subcategory for granular root-cause analysis of recurring compliance issues."
    - name: "severity_level"
      expr: severity_level
      comment: "Severity of the finding (critical, major, minor) for risk prioritization and escalation decisions."
    - name: "regulatory_violation_flag"
      expr: CAST(regulatory_violation_flag AS STRING)
      comment: "Whether the finding constitutes a regulatory violation. Tracks legal and compliance risk exposure."
    - name: "repeat_finding_flag"
      expr: CAST(repeat_finding_flag AS STRING)
      comment: "Whether this is a repeat finding. Identifies chronic non-compliance requiring escalated intervention."
    - name: "corrective_action_completed_flag"
      expr: CAST(corrective_action_completed_flag AS STRING)
      comment: "Whether corrective action has been completed. Tracks remediation velocity and accountability."
    - name: "ops_visit_finding_status"
      expr: ops_visit_finding_status
      comment: "Current status of the finding for open-item tracking and resolution management."
    - name: "finding_month"
      expr: DATE_TRUNC('MONTH', finding_timestamp)
      comment: "Month of the finding for trend analysis of compliance issues over time."
  measures:
    - name: "total_findings"
      expr: COUNT(1)
      comment: "Total number of ops visit findings. Tracks overall compliance issue volume across the portfolio."
    - name: "critical_findings_count"
      expr: COUNT(CASE WHEN severity_level = 'critical' THEN ops_visit_finding_id END)
      comment: "Number of critical severity findings. Primary risk indicator for brand standard and regulatory compliance."
    - name: "repeat_findings_count"
      expr: COUNT(CASE WHEN repeat_finding_flag = TRUE THEN ops_visit_finding_id END)
      comment: "Number of repeat findings. Identifies systemic non-compliance requiring structural intervention."
    - name: "regulatory_violation_count"
      expr: COUNT(CASE WHEN regulatory_violation_flag = TRUE THEN ops_visit_finding_id END)
      comment: "Number of regulatory violations found. Tracks legal risk exposure and health department compliance."
    - name: "total_financial_impact"
      expr: SUM(CAST(financial_impact_usd AS DOUBLE))
      comment: "Total estimated financial impact of findings in USD. Quantifies the business cost of non-compliance."
    - name: "avg_financial_impact"
      expr: AVG(CAST(financial_impact_usd AS DOUBLE))
      comment: "Average financial impact per finding. Used to prioritize remediation investment by finding type."
    - name: "corrective_action_completion_count"
      expr: COUNT(CASE WHEN corrective_action_completed_flag = TRUE THEN ops_visit_finding_id END)
      comment: "Number of findings with completed corrective actions. Tracks remediation effectiveness and accountability."
    - name: "open_findings_count"
      expr: COUNT(CASE WHEN corrective_action_completed_flag = FALSE THEN ops_visit_finding_id END)
      comment: "Number of findings with open corrective actions. Drives follow-up visit scheduling and escalation decisions."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`restaurant_table_turn_log`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Table turn efficiency metrics tracking seating throughput, revenue per cover, and service timing. Drives dining room capacity optimization and server performance management."
  source: "`vibe_restaurants_v1`.`restaurant`.`table_turn_log`"
  dimensions:
    - name: "daypart"
      expr: daypart
      comment: "Daypart (breakfast, lunch, dinner) for time-of-day table turn analysis."
    - name: "day_of_week"
      expr: day_of_week
      comment: "Day of week for weekly pattern analysis of table turn performance."
    - name: "is_peak_period"
      expr: CAST(is_peak_period AS STRING)
      comment: "Whether the turn occurred during a peak period for peak vs. off-peak throughput comparison."
    - name: "reservation_flag"
      expr: CAST(reservation_flag AS STRING)
      comment: "Whether the party had a reservation. Analyzes impact of reservations on table turn efficiency."
    - name: "turn_status"
      expr: turn_status
      comment: "Status of the table turn for data completeness and operational exception filtering."
    - name: "turn_date"
      expr: DATE_TRUNC('WEEK', turn_date)
      comment: "Week of the table turn for weekly throughput trend analysis."
  measures:
    - name: "avg_total_turn_time_minutes"
      expr: AVG(CAST(total_turn_time_minutes AS DOUBLE))
      comment: "Average total table turn time in minutes. Primary throughput KPI for dining room capacity management."
    - name: "avg_wait_time_minutes"
      expr: AVG(CAST(wait_time_minutes AS DOUBLE))
      comment: "Average guest wait time before seating. Drives host staffing and reservation system decisions."
    - name: "avg_seating_to_order_minutes"
      expr: AVG(CAST(seating_to_order_minutes AS DOUBLE))
      comment: "Average time from seating to order placement. Measures server responsiveness and menu complexity impact."
    - name: "avg_order_to_delivery_minutes"
      expr: AVG(CAST(order_to_delivery_minutes AS DOUBLE))
      comment: "Average time from order to food delivery. Tracks kitchen throughput and service speed."
    - name: "avg_check_to_cleared_minutes"
      expr: AVG(CAST(check_to_cleared_minutes AS DOUBLE))
      comment: "Average time from check presentation to table clearance. Identifies bottlenecks in payment and turnover."
    - name: "avg_revenue_per_cover"
      expr: AVG(CAST(revenue_per_cover AS DOUBLE))
      comment: "Average revenue per cover. Key dining room productivity metric linking throughput to revenue generation."
    - name: "total_check_amount"
      expr: SUM(CAST(check_total_amount AS DOUBLE))
      comment: "Total check amount across all table turns. Measures dining room revenue contribution."
    - name: "avg_sos_variance_minutes"
      expr: AVG(CAST(sos_variance_minutes AS DOUBLE))
      comment: "Average variance from SOS target in minutes. Tracks service speed compliance against brand standards."
    - name: "total_table_turns"
      expr: COUNT(1)
      comment: "Total number of table turns. Measures dining room utilization and throughput volume."
    - name: "avg_delivery_to_check_minutes"
      expr: AVG(CAST(delivery_to_check_minutes AS DOUBLE))
      comment: "Average time from food delivery to check presentation. Identifies server efficiency in closing out tables."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`restaurant_renovation_project`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Capital renovation project metrics tracking budget performance, AUV lift, and project execution. Drives capital allocation, ROI assessment, and remodel program management."
  source: "`vibe_restaurants_v1`.`restaurant`.`renovation_project`"
  dimensions:
    - name: "project_status"
      expr: project_status
      comment: "Current status of the renovation project for pipeline and completion tracking."
    - name: "project_type"
      expr: project_type
      comment: "Type of renovation (full remodel, refresh, equipment upgrade) for program-level analysis."
    - name: "project_priority"
      expr: project_priority
      comment: "Priority level of the project for capital allocation and scheduling decisions."
    - name: "financing_method"
      expr: financing_method
      comment: "How the renovation is financed (company, franchisee, loan) for capital structure analysis."
    - name: "ada_compliance_flag"
      expr: CAST(ada_compliance_flag AS STRING)
      comment: "Whether the project includes ADA compliance upgrades. Tracks regulatory compliance investment."
    - name: "planned_start_year"
      expr: DATE_TRUNC('YEAR', planned_start_date)
      comment: "Planned start year for capital expenditure forecasting and pipeline planning."
    - name: "inspection_status"
      expr: inspection_status
      comment: "Final inspection status for project completion quality tracking."
  measures:
    - name: "total_estimated_capex"
      expr: SUM(CAST(estimated_capex_usd AS DOUBLE))
      comment: "Total estimated capital expenditure for renovation projects. Core input for capital budget planning."
    - name: "total_actual_capex"
      expr: SUM(CAST(actual_capex_usd AS DOUBLE))
      comment: "Total actual capital expenditure incurred. Tracks spend against budget for financial control."
    - name: "total_budget_variance"
      expr: SUM(CAST(budget_variance_usd AS DOUBLE))
      comment: "Total budget variance (actual vs. estimated capex). Identifies cost overrun patterns by project type."
    - name: "avg_expected_auv_lift_pct"
      expr: AVG(CAST(expected_auv_lift_percent AS DOUBLE))
      comment: "Average expected AUV lift percentage from renovations. Used to justify capital investment decisions."
    - name: "avg_actual_auv_lift_pct"
      expr: AVG(CAST(actual_auv_lift_percent AS DOUBLE))
      comment: "Average actual AUV lift achieved post-renovation. Validates ROI assumptions and informs future remodel programs."
    - name: "avg_closure_duration_days"
      expr: AVG(CAST(closure_duration_days AS DOUBLE))
      comment: "Average unit closure duration during renovation. Quantifies revenue disruption from remodel programs."
    - name: "total_projects"
      expr: COUNT(1)
      comment: "Total number of renovation projects. Tracks remodel program pipeline volume and execution cadence."
    - name: "completed_projects_count"
      expr: COUNT(CASE WHEN project_status = 'completed' THEN renovation_project_id END)
      comment: "Number of completed renovation projects. Tracks remodel program execution rate against plan."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`restaurant_throughput_benchmark`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Throughput benchmark metrics defining target capacity and service speed standards by unit and daypart. Used to set operational targets and evaluate unit performance against design capacity."
  source: "`vibe_restaurants_v1`.`restaurant`.`throughput_benchmark`"
  dimensions:
    - name: "benchmark_type"
      expr: benchmark_type
      comment: "Type of throughput benchmark (design capacity, operational target, peak) for context-appropriate comparison."
    - name: "service_channel"
      expr: service_channel
      comment: "Service channel (drive-thru, dine-in, delivery) for channel-specific capacity benchmarking."
    - name: "restaurant_format"
      expr: restaurant_format
      comment: "Restaurant format for format-level throughput standard comparison."
    - name: "throughput_benchmark_status"
      expr: throughput_benchmark_status
      comment: "Status of the benchmark record for active vs. archived standard filtering."
    - name: "effective_start_year"
      expr: DATE_TRUNC('YEAR', effective_start_date)
      comment: "Year the benchmark became effective for tracking standard evolution over time."
  measures:
    - name: "avg_target_throughput_covers_per_hour"
      expr: AVG(CAST(target_throughput_covers_per_hour AS DOUBLE))
      comment: "Average target throughput in covers per hour. Defines dining room capacity standard for unit design and staffing."
    - name: "avg_target_throughput_transactions_per_hour"
      expr: AVG(CAST(target_throughput_transactions_per_hour AS DOUBLE))
      comment: "Average target transaction throughput per hour. Sets operational speed standard for POS and kitchen capacity planning."
    - name: "avg_target_adt"
      expr: AVG(CAST(target_adt AS DOUBLE))
      comment: "Average target average daily transactions. Drives staffing model and revenue forecasting."
    - name: "avg_target_atc"
      expr: AVG(CAST(target_atc AS DOUBLE))
      comment: "Average target average transaction count. Used to set daily volume expectations for unit operations."
    - name: "avg_target_acv"
      expr: AVG(CAST(target_acv AS DOUBLE))
      comment: "Average target average check value. Sets revenue-per-transaction benchmark for menu pricing strategy."
    - name: "avg_sos_compliance_threshold_pct"
      expr: AVG(CAST(sos_compliance_threshold_pct AS DOUBLE))
      comment: "Average SOS compliance threshold percentage. Defines the minimum acceptable SOS target-met rate for unit operations."
    - name: "avg_labor_fte_requirement"
      expr: AVG(CAST(labor_fte_requirement AS DOUBLE))
      comment: "Average labor FTE requirement per benchmark. Drives staffing model design and labor cost planning."
    - name: "avg_peak_hour_multiplier"
      expr: AVG(CAST(peak_hour_multiplier AS DOUBLE))
      comment: "Average peak hour throughput multiplier. Used to scale staffing and capacity for peak demand periods."
    - name: "total_benchmarks"
      expr: COUNT(1)
      comment: "Total number of throughput benchmark records. Tracks coverage of operational standards across units and channels."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`restaurant_store_campaign_assignment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Local store marketing campaign performance metrics tracking spend, sales lift, and ROI by unit. Drives marketing fund allocation and campaign effectiveness decisions."
  source: "`vibe_restaurants_v1`.`restaurant`.`store_campaign_assignment`"
  dimensions:
    - name: "assignment_status"
      expr: assignment_status
      comment: "Status of the campaign assignment (active, completed, cancelled) for pipeline and performance filtering."
    - name: "channel"
      expr: channel
      comment: "Marketing channel (digital, print, radio, OOH) for channel-level ROI analysis."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the campaign assignment for governance and compliance tracking."
    - name: "compliance_flag"
      expr: CAST(compliance_flag AS STRING)
      comment: "Whether the campaign execution was compliant with brand standards."
    - name: "market_dma"
      expr: market_dma
      comment: "Designated market area for regional marketing performance analysis."
    - name: "effective_start_month"
      expr: DATE_TRUNC('MONTH', effective_start_date)
      comment: "Month the campaign assignment became effective for temporal performance trending."
    - name: "initiative_name"
      expr: initiative_name
      comment: "Name of the marketing initiative for program-level performance aggregation."
  measures:
    - name: "total_planned_spend"
      expr: SUM(CAST(planned_spend AS DOUBLE))
      comment: "Total planned marketing spend across campaign assignments. Core input for marketing budget management."
    - name: "total_actual_spend"
      expr: SUM(CAST(actual_spend AS DOUBLE))
      comment: "Total actual marketing spend incurred. Tracks budget utilization and spend efficiency."
    - name: "total_lmf_fund_amount"
      expr: SUM(CAST(lmf_fund_amount AS DOUBLE))
      comment: "Total local marketing fund amount allocated. Tracks LMF deployment across the portfolio."
    - name: "total_lmf_fund_used"
      expr: SUM(CAST(lmf_fund_used AS DOUBLE))
      comment: "Total local marketing fund actually used. Measures LMF utilization rate for fund management."
    - name: "total_lmf_remaining"
      expr: SUM(CAST(lmf_remaining_amount AS DOUBLE))
      comment: "Total remaining local marketing fund balance. Identifies undeployed marketing resources."
    - name: "avg_expected_comp_sales_lift_pct"
      expr: AVG(CAST(expected_comp_sales_lift_percent AS DOUBLE))
      comment: "Average expected comp sales lift from campaigns. Used to set campaign ROI expectations and justify spend."
    - name: "avg_actual_comp_sales_lift_pct"
      expr: AVG(CAST(actual_comp_sales_lift_percent AS DOUBLE))
      comment: "Average actual comp sales lift achieved. Validates campaign effectiveness and informs future investment decisions."
    - name: "avg_expected_adt_lift_pct"
      expr: AVG(CAST(expected_adt_lift_percent AS DOUBLE))
      comment: "Average expected average daily transaction lift. Sets traffic-driving expectations for campaign planning."
    - name: "avg_actual_adt_lift_pct"
      expr: AVG(CAST(actual_adt_lift_percent AS DOUBLE))
      comment: "Average actual ADT lift achieved. Measures campaign effectiveness in driving guest traffic."
    - name: "total_campaign_assignments"
      expr: COUNT(1)
      comment: "Total number of store campaign assignments. Tracks marketing program reach across the unit portfolio."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`restaurant_equipment_asset`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Equipment asset lifecycle and condition metrics tracking maintenance compliance, replacement costs, and operational status. Drives capital planning and preventive maintenance decisions."
  source: "`vibe_restaurants_v1`.`restaurant`.`equipment_asset`"
  dimensions:
    - name: "equipment_category"
      expr: equipment_category
      comment: "Category of equipment (cooking, refrigeration, POS) for asset class-level analysis."
    - name: "equipment_type"
      expr: equipment_type
      comment: "Specific equipment type for granular maintenance and replacement planning."
    - name: "ownership_type"
      expr: ownership_type
      comment: "Whether equipment is owned, leased, or financed. Drives capital vs. operating expense classification."
    - name: "asset_condition_rating"
      expr: asset_condition_rating
      comment: "Current condition rating of the asset for replacement prioritization."
    - name: "temperature_critical_flag"
      expr: CAST(temperature_critical_flag AS STRING)
      comment: "Whether the asset is temperature-critical (e.g., refrigeration). Prioritizes food safety maintenance."
    - name: "manufacturer_name"
      expr: manufacturer_name
      comment: "Equipment manufacturer for vendor performance and warranty management analysis."
    - name: "installation_year"
      expr: DATE_TRUNC('YEAR', installation_date)
      comment: "Year of installation for asset age cohort analysis and replacement cycle planning."
  measures:
    - name: "total_acquisition_cost"
      expr: SUM(CAST(acquisition_cost_usd AS DOUBLE))
      comment: "Total acquisition cost of equipment assets. Core input for capital asset management and depreciation planning."
    - name: "total_replacement_cost"
      expr: SUM(CAST(replacement_cost_usd AS DOUBLE))
      comment: "Total replacement cost of the asset portfolio. Drives capital reserve planning and insurance coverage decisions."
    - name: "avg_replacement_cost"
      expr: AVG(CAST(replacement_cost_usd AS DOUBLE))
      comment: "Average replacement cost per asset. Used to estimate capital requirements for equipment refresh programs."
    - name: "avg_temperature_max_f"
      expr: AVG(CAST(temperature_max_f AS DOUBLE))
      comment: "Average maximum operating temperature across temperature-critical assets. Monitors food safety compliance thresholds."
    - name: "avg_temperature_min_f"
      expr: AVG(CAST(temperature_min_f AS DOUBLE))
      comment: "Average minimum operating temperature across temperature-critical assets. Tracks cold chain compliance."
    - name: "total_assets"
      expr: COUNT(1)
      comment: "Total number of equipment assets. Tracks portfolio size for maintenance scheduling and capital planning."
    - name: "temperature_critical_asset_count"
      expr: COUNT(CASE WHEN temperature_critical_flag = TRUE THEN equipment_asset_id END)
      comment: "Number of temperature-critical assets. Prioritizes food safety monitoring and maintenance resources."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`restaurant_ops_visit_quality`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Quality and compliance KPIs from operational visits"
  source: "`vibe_restaurants_v1`.`restaurant`.`ops_visit`"
  dimensions:
    - name: "visit_date"
      expr: visit_date
      comment: "Date of the operational visit"
    - name: "visit_type"
      expr: visit_type
      comment: "Type of visit (e.g., routine, audit)"
    - name: "visit_category"
      expr: visit_category
      comment: "Category of the visit"
    - name: "brand_standard_compliance_status"
      expr: brand_standard_compliance_status
      comment: "Compliance status with brand standards"
  measures:
    - name: "total_visits"
      expr: COUNT(1)
      comment: "Number of operational visits"
    - name: "average_overall_score"
      expr: AVG(CAST(overall_visit_score AS DOUBLE))
      comment: "Average overall visit score"
    - name: "average_food_quality_score"
      expr: AVG(CAST(food_quality_score AS DOUBLE))
      comment: "Average food quality score"
    - name: "average_service_score"
      expr: AVG(CAST(service_score AS DOUBLE))
      comment: "Average service score"
    - name: "average_safety_score"
      expr: AVG(CAST(safety_score AS DOUBLE))
      comment: "Average safety compliance score"
    - name: "average_cleanliness_score"
      expr: AVG(CAST(cleanliness_score AS DOUBLE))
      comment: "Average cleanliness score"
    - name: "corrective_actions_required"
      expr: SUM(CASE WHEN corrective_action_required_flag THEN 1 ELSE 0 END)
      comment: "Count of visits where corrective action was required"
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`restaurant_table_turn`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Operational efficiency KPIs for table turnover"
  source: "`vibe_restaurants_v1`.`restaurant`.`table_turn_log`"
  dimensions:
    - name: "day_of_week"
      expr: day_of_week
      comment: "Day of week of the turn"
    - name: "daypart"
      expr: daypart
      comment: "Meal period (e.g., breakfast, lunch, dinner)"
    - name: "turn_date"
      expr: turn_date
      comment: "Date of the table turn"
    - name: "table_section"
      expr: table_section
      comment: "Section of the restaurant where the table is located"
  measures:
    - name: "total_turns"
      expr: COUNT(1)
      comment: "Count of table turn events"
    - name: "average_total_turn_time_minutes"
      expr: AVG(CAST(total_turn_time_minutes AS DOUBLE))
      comment: "Average total time per table turn in minutes"
    - name: "average_wait_time_minutes"
      expr: AVG(CAST(wait_time_minutes AS DOUBLE))
      comment: "Average guest wait time before being seated"
    - name: "average_seating_to_order_minutes"
      expr: AVG(CAST(seating_to_order_minutes AS DOUBLE))
      comment: "Average time from seating to order placement"
    - name: "average_order_to_delivery_minutes"
      expr: AVG(CAST(order_to_delivery_minutes AS DOUBLE))
      comment: "Average time from order placement to delivery"
    - name: "sum_revenue_per_cover"
      expr: SUM(CAST(revenue_per_cover AS DOUBLE))
      comment: "Total revenue per cover (guest)"
$$;