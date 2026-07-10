-- Metric views for domain: restaurant | Business: Restaurants | Version: 2 | Generated on: 2026-07-10 18:21:26

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`restaurant_unit_performance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core financial and operational KPIs for restaurant units by period. Drives QBR, P&L review, and same-store-sales steering decisions."
  source: "`vibe_restaurants_v1`.`restaurant`.`unit_performance`"
  dimensions:
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year for period grouping and year-over-year comparisons."
    - name: "fiscal_quarter"
      expr: fiscal_quarter
      comment: "Fiscal quarter for quarterly business review segmentation."
    - name: "fiscal_month"
      expr: fiscal_month
      comment: "Fiscal month for monthly P&L and trend analysis."
    - name: "fiscal_week"
      expr: fiscal_week
      comment: "Fiscal week for weekly operational performance tracking."
    - name: "currency_code"
      expr: currency_code
      comment: "Reporting currency for multi-currency unit comparisons."
    - name: "performance_status"
      expr: performance_status
      comment: "Status of the performance record (e.g. final, preliminary) for data quality filtering."
  measures:
    - name: "total_gross_revenue"
      expr: SUM(CAST(gross_revenue_amount AS DOUBLE))
      comment: "Total gross revenue across all units and periods. Primary top-line KPI for executive revenue steering."
    - name: "total_net_revenue"
      expr: SUM(CAST(net_revenue_amount AS DOUBLE))
      comment: "Total net revenue after discounts and adjustments. Used for margin and profitability analysis."
    - name: "total_cogs"
      expr: SUM(CAST(cogs_amount AS DOUBLE))
      comment: "Total cost of goods sold. Drives food cost management and procurement decisions."
    - name: "avg_cogs_percent"
      expr: AVG(CAST(cogs_percent AS DOUBLE))
      comment: "Average COGS as a percentage of revenue. Benchmark against target to identify food cost outliers."
    - name: "total_labor_cost"
      expr: SUM(CAST(labor_cost_amount AS DOUBLE))
      comment: "Total labor cost across units. Key input for workforce scheduling and cost control decisions."
    - name: "avg_labor_percent"
      expr: AVG(CAST(labor_percent AS DOUBLE))
      comment: "Average labor cost as a percentage of revenue. Triggers staffing model reviews when above threshold."
    - name: "total_ebitda"
      expr: SUM(CAST(ebitda_amount AS DOUBLE))
      comment: "Total EBITDA across units. Core profitability KPI for investor and board reporting."
    - name: "total_operating_income"
      expr: SUM(CAST(operating_income_amount AS DOUBLE))
      comment: "Total operating income. Measures operational efficiency net of all operating expenses."
    - name: "total_net_income"
      expr: SUM(CAST(net_income_amount AS DOUBLE))
      comment: "Total net income. Bottom-line profitability metric for financial reporting."
    - name: "total_comp_sales"
      expr: SUM(CAST(comp_sales_amount AS DOUBLE))
      comment: "Total comparable (same-store) sales. Critical KPI for organic growth measurement excluding new unit openings."
    - name: "avg_comp_sales_variance"
      expr: AVG(CAST(comp_sales_variance_amount AS DOUBLE))
      comment: "Average comp sales variance vs prior period. Signals whether units are growing or declining on a like-for-like basis."
    - name: "avg_sss_growth_percent"
      expr: AVG(CAST(sss_growth_percent AS DOUBLE))
      comment: "Average same-store sales growth percentage. Primary organic growth KPI for franchise and company-owned unit performance."
    - name: "total_marketing_expense"
      expr: SUM(CAST(marketing_expense_amount AS DOUBLE))
      comment: "Total marketing spend across units. Used to evaluate marketing ROI and LMF fund utilization."
    - name: "total_waste"
      expr: SUM(CAST(waste_amount AS DOUBLE))
      comment: "Total food waste cost. Drives inventory management and portion control improvement initiatives."
    - name: "avg_waste_percent"
      expr: AVG(CAST(waste_percent AS DOUBLE))
      comment: "Average waste as a percentage of revenue. Benchmarks food waste efficiency across units."
    - name: "total_rent_expense"
      expr: SUM(CAST(rent_expense_amount AS DOUBLE))
      comment: "Total occupancy/rent expense. Key input for real estate portfolio and lease renegotiation decisions."
    - name: "total_operating_expenses"
      expr: SUM(CAST(total_operating_expenses_amount AS DOUBLE))
      comment: "Total operating expenses. Used to compute operating leverage and cost structure analysis."
    - name: "avg_acv"
      expr: AVG(CAST(acv_amount AS DOUBLE))
      comment: "Average check value per unit-period. Tracks pricing and upsell effectiveness over time."
    - name: "avg_auc"
      expr: AVG(CAST(auc_amount AS DOUBLE))
      comment: "Average unit contribution. Measures per-unit economic contribution for portfolio prioritization."
    - name: "unit_performance_record_count"
      expr: COUNT(1)
      comment: "Count of unit-period performance records. Used as denominator for average calculations and data completeness checks."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`restaurant_ops_visit`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Operational visit quality and compliance KPIs. Drives brand standard enforcement, corrective action tracking, and field operations management."
  source: "`vibe_restaurants_v1`.`restaurant`.`ops_visit`"
  dimensions:
    - name: "visit_type"
      expr: visit_type
      comment: "Type of operational visit (e.g. scheduled audit, surprise inspection, follow-up)."
    - name: "visit_category"
      expr: visit_category
      comment: "Category of visit for segmenting compliance vs. coaching vs. certification visits."
    - name: "visit_status"
      expr: visit_status
      comment: "Current status of the visit (e.g. completed, pending, cancelled)."
    - name: "brand_standard_compliance_status"
      expr: brand_standard_compliance_status
      comment: "Overall brand standard compliance outcome of the visit."
    - name: "daypart_observed"
      expr: daypart_observed
      comment: "Daypart during which the visit was conducted (breakfast, lunch, dinner, late night)."
    - name: "visit_priority_level"
      expr: visit_priority_level
      comment: "Priority level assigned to the visit for triage and scheduling decisions."
    - name: "visit_date"
      expr: visit_date
      comment: "Date of the operational visit for trend and calendar analysis."
    - name: "corrective_action_required_flag"
      expr: corrective_action_required_flag
      comment: "Indicates whether a corrective action was required as a result of the visit."
    - name: "follow_up_visit_required_flag"
      expr: follow_up_visit_required_flag
      comment: "Indicates whether a follow-up visit was scheduled, signaling unresolved compliance issues."
  measures:
    - name: "total_visits"
      expr: COUNT(1)
      comment: "Total number of operational visits conducted. Baseline volume metric for field operations coverage."
    - name: "avg_overall_visit_score"
      expr: AVG(CAST(overall_visit_score AS DOUBLE))
      comment: "Average overall visit score across all units. Primary quality KPI for brand standard compliance steering."
    - name: "avg_food_quality_score"
      expr: AVG(CAST(food_quality_score AS DOUBLE))
      comment: "Average food quality score from operational visits. Drives menu execution and kitchen training decisions."
    - name: "avg_cleanliness_score"
      expr: AVG(CAST(cleanliness_score AS DOUBLE))
      comment: "Average cleanliness score. Tracks hygiene compliance and triggers deep-clean or remediation programs."
    - name: "avg_service_score"
      expr: AVG(CAST(service_score AS DOUBLE))
      comment: "Average service score from visits. Informs guest experience and crew training investment decisions."
    - name: "avg_safety_score"
      expr: AVG(CAST(safety_score AS DOUBLE))
      comment: "Average safety score. Critical for regulatory compliance and risk management reporting."
    - name: "avg_speed_score"
      expr: AVG(CAST(speed_score AS DOUBLE))
      comment: "Average speed-of-service score from visits. Directly linked to throughput and guest satisfaction outcomes."
    - name: "avg_checklist_completion_pct"
      expr: AVG(CAST(checklist_completion_percentage AS DOUBLE))
      comment: "Average checklist completion percentage. Measures thoroughness of operational audits."
    - name: "visits_requiring_corrective_action"
      expr: SUM(CASE WHEN corrective_action_required_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of visits that required corrective action. Tracks compliance failure rate across the portfolio."
    - name: "visits_requiring_follow_up"
      expr: SUM(CASE WHEN follow_up_visit_required_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of visits requiring a follow-up, indicating unresolved issues that need re-inspection."
    - name: "corrective_action_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN corrective_action_required_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of visits resulting in corrective action. Key compliance health indicator for brand standards enforcement."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`restaurant_ops_visit_finding`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Granular finding-level KPIs from operational visits. Enables root-cause analysis, repeat violation tracking, and regulatory risk management."
  source: "`vibe_restaurants_v1`.`restaurant`.`ops_visit_finding`"
  dimensions:
    - name: "finding_category"
      expr: finding_category
      comment: "Category of the finding (e.g. food safety, cleanliness, service) for issue classification."
    - name: "finding_subcategory"
      expr: finding_subcategory
      comment: "Subcategory for granular root-cause analysis of operational findings."
    - name: "severity_level"
      expr: severity_level
      comment: "Severity of the finding (critical, major, minor). Drives escalation and remediation prioritization."
    - name: "ops_visit_finding_status"
      expr: ops_visit_finding_status
      comment: "Current resolution status of the finding (open, closed, waived)."
    - name: "regulatory_violation_flag"
      expr: regulatory_violation_flag
      comment: "Indicates whether the finding constitutes a regulatory violation, triggering compliance reporting."
    - name: "repeat_finding_flag"
      expr: repeat_finding_flag
      comment: "Flags repeat findings to identify chronic non-compliance patterns."
    - name: "escalation_level"
      expr: escalation_level
      comment: "Escalation level assigned to the finding for management visibility."
    - name: "brand_standard_code"
      expr: brand_standard_code
      comment: "Brand standard code violated, enabling standard-level compliance analysis."
  measures:
    - name: "total_findings"
      expr: COUNT(1)
      comment: "Total number of operational findings. Baseline volume for compliance issue tracking."
    - name: "total_financial_impact"
      expr: SUM(CAST(financial_impact_usd AS DOUBLE))
      comment: "Total estimated financial impact of findings. Quantifies the cost of non-compliance for business case prioritization."
    - name: "avg_financial_impact_per_finding"
      expr: AVG(CAST(financial_impact_usd AS DOUBLE))
      comment: "Average financial impact per finding. Helps prioritize remediation investment by severity and category."
    - name: "regulatory_violation_count"
      expr: SUM(CASE WHEN regulatory_violation_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of findings that are regulatory violations. Critical risk metric for legal and compliance reporting."
    - name: "repeat_finding_count"
      expr: SUM(CASE WHEN repeat_finding_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of repeat findings. Identifies chronic non-compliance requiring systemic intervention."
    - name: "repeat_finding_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN repeat_finding_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of findings that are repeats. High rates signal training or process failures requiring escalation."
    - name: "corrective_action_completion_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN corrective_action_completed_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of findings with completed corrective actions. Measures remediation effectiveness and follow-through."
    - name: "escalation_required_count"
      expr: SUM(CASE WHEN escalation_required_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of findings requiring escalation. Tracks severity of compliance issues reaching management attention."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`restaurant_sos_measurement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Speed-of-service (SOS) KPIs measuring throughput efficiency and guest wait time performance. Core operational metric for QSR and fast-casual brands."
  source: "`vibe_restaurants_v1`.`restaurant`.`sos_measurement`"
  dimensions:
    - name: "service_channel"
      expr: service_channel
      comment: "Service channel (drive-thru, dine-in, delivery, kiosk) for channel-specific SOS benchmarking."
    - name: "measurement_source"
      expr: measurement_source
      comment: "Source of the SOS measurement (timer system, manual, POS) for data quality segmentation."
    - name: "target_met_flag"
      expr: target_met_flag
      comment: "Indicates whether the SOS target was met for this transaction."
    - name: "peak_period_flag"
      expr: peak_period_flag
      comment: "Flags peak period measurements for peak vs. off-peak SOS comparison."
    - name: "equipment_issue_flag"
      expr: equipment_issue_flag
      comment: "Flags measurements impacted by equipment issues to isolate operational vs. equipment-driven SOS failures."
    - name: "service_recovery_flag"
      expr: service_recovery_flag
      comment: "Indicates a service recovery event occurred, linking SOS failures to guest satisfaction interventions."
    - name: "measurement_date"
      expr: DATE_TRUNC('day', measurement_timestamp)
      comment: "Date of the SOS measurement for daily trend analysis."
    - name: "measurement_month"
      expr: DATE_TRUNC('month', measurement_timestamp)
      comment: "Month of the SOS measurement for monthly performance reporting."
  measures:
    - name: "total_measurements"
      expr: COUNT(1)
      comment: "Total SOS measurement records. Baseline volume for statistical significance of SOS averages."
    - name: "avg_order_complexity_score"
      expr: AVG(CAST(order_complexity_score AS DOUBLE))
      comment: "Average order complexity score. Controls for order mix when comparing SOS across units and channels."
    - name: "avg_measurement_quality_score"
      expr: AVG(CAST(measurement_quality_score AS DOUBLE))
      comment: "Average measurement quality score. Ensures SOS data reliability before operational decisions are made."
    - name: "sos_target_met_count"
      expr: SUM(CASE WHEN target_met_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of measurements where SOS target was met. Numerator for SOS compliance rate."
    - name: "sos_target_compliance_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN target_met_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of transactions meeting SOS target. Primary speed-of-service KPI for operational steering and brand standard compliance."
    - name: "peak_period_measurement_count"
      expr: SUM(CASE WHEN peak_period_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of measurements during peak periods. Used to weight SOS compliance analysis by traffic volume."
    - name: "equipment_issue_impact_count"
      expr: SUM(CASE WHEN equipment_issue_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of SOS measurements impacted by equipment issues. Quantifies equipment-driven service degradation for maintenance prioritization."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`restaurant_table_turn_log`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Table turn efficiency and revenue-per-cover KPIs for dine-in operations. Drives seating capacity utilization and service speed decisions."
  source: "`vibe_restaurants_v1`.`restaurant`.`table_turn_log`"
  dimensions:
    - name: "daypart"
      expr: daypart
      comment: "Daypart (breakfast, lunch, dinner, late night) for time-of-day table turn analysis."
    - name: "day_of_week"
      expr: day_of_week
      comment: "Day of week for weekly pattern analysis of table turn performance."
    - name: "turn_status"
      expr: turn_status
      comment: "Status of the table turn (completed, abandoned, in-progress) for data quality filtering."
    - name: "is_peak_period"
      expr: is_peak_period
      comment: "Flags peak period turns for peak vs. off-peak throughput comparison."
    - name: "reservation_flag"
      expr: reservation_flag
      comment: "Indicates whether the party had a reservation, enabling reservation vs. walk-in turn time comparison."
    - name: "special_occasion_flag"
      expr: special_occasion_flag
      comment: "Flags special occasion parties that may have longer dwell times, controlling for outliers."
    - name: "server_station"
      expr: server_station
      comment: "Server station assignment for station-level performance analysis."
    - name: "turn_date"
      expr: turn_date
      comment: "Date of the table turn for daily and weekly trend analysis."
  measures:
    - name: "total_table_turns"
      expr: COUNT(1)
      comment: "Total table turns completed. Baseline throughput volume metric for dine-in capacity utilization."
    - name: "avg_total_turn_time_minutes"
      expr: AVG(CAST(total_turn_time_minutes AS DOUBLE))
      comment: "Average total table turn time in minutes. Primary dine-in throughput KPI — lower values indicate higher seating efficiency."
    - name: "avg_seating_to_order_minutes"
      expr: AVG(CAST(seating_to_order_minutes AS DOUBLE))
      comment: "Average time from seating to order placement. Measures server responsiveness and menu decision speed."
    - name: "avg_order_to_delivery_minutes"
      expr: AVG(CAST(order_to_delivery_minutes AS DOUBLE))
      comment: "Average time from order to food delivery. Measures kitchen execution speed for dine-in service."
    - name: "avg_delivery_to_check_minutes"
      expr: AVG(CAST(delivery_to_check_minutes AS DOUBLE))
      comment: "Average time from food delivery to check presentation. Identifies post-meal service delays."
    - name: "avg_check_to_cleared_minutes"
      expr: AVG(CAST(check_to_cleared_minutes AS DOUBLE))
      comment: "Average time from check presentation to table cleared. Measures payment and turnover efficiency."
    - name: "avg_wait_time_minutes"
      expr: AVG(CAST(wait_time_minutes AS DOUBLE))
      comment: "Average guest wait time before seating. Directly impacts guest satisfaction and walk-away rate."
    - name: "avg_revenue_per_cover"
      expr: AVG(CAST(revenue_per_cover AS DOUBLE))
      comment: "Average revenue per cover (guest). Key yield metric combining check average and party size efficiency."
    - name: "total_check_amount"
      expr: SUM(CAST(check_total_amount AS DOUBLE))
      comment: "Total check amount across all table turns. Revenue contribution from dine-in channel."
    - name: "avg_sos_variance_minutes"
      expr: AVG(CAST(sos_variance_minutes AS DOUBLE))
      comment: "Average variance between actual turn time and SOS target. Negative values indicate target achievement; positive values signal underperformance."
    - name: "turns_within_sos_target"
      expr: SUM(CASE WHEN sos_variance_minutes <= 0 THEN 1 ELSE 0 END)
      comment: "Count of table turns completed within or under the SOS target. Numerator for dine-in SOS compliance rate."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`restaurant_unit`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Restaurant unit portfolio KPIs covering unit count, financial performance benchmarks, and operational characteristics. Drives portfolio strategy and investment decisions."
  source: "`vibe_restaurants_v1`.`restaurant`.`unit`"
  dimensions:
    - name: "operational_status"
      expr: operational_status
      comment: "Current operational status of the unit (open, closed, under renovation) for active portfolio analysis."
    - name: "ownership_model"
      expr: ownership_model
      comment: "Ownership model (company-owned, franchised, joint venture) for performance comparison by ownership type."
    - name: "concept_type"
      expr: concept_type
      comment: "Restaurant concept type (QSR, fast casual, casual dining) for format-level benchmarking."
    - name: "country_code"
      expr: country_code
      comment: "Country of the unit for geographic portfolio analysis and international performance comparison."
    - name: "state_province"
      expr: state_province
      comment: "State or province for regional performance analysis."
    - name: "city"
      expr: city
      comment: "City for local market performance analysis."
    - name: "has_online_ordering"
      expr: has_online_ordering
      comment: "Indicates whether the unit has online ordering enabled, for digital channel adoption analysis."
    - name: "has_third_party_delivery"
      expr: has_third_party_delivery
      comment: "Indicates whether the unit participates in third-party delivery, for delivery channel revenue analysis."
    - name: "haccp_certified"
      expr: haccp_certified
      comment: "HACCP certification status for food safety compliance portfolio view."
    - name: "opening_date"
      expr: opening_date
      comment: "Unit opening date for cohort analysis and new restaurant opening (NRO) tracking."
  measures:
    - name: "total_units"
      expr: COUNT(1)
      comment: "Total number of restaurant units. Core portfolio size metric for franchise and company reporting."
    - name: "active_units"
      expr: SUM(CASE WHEN operational_status = 'open' THEN 1 ELSE 0 END)
      comment: "Count of currently open and operating units. Tracks active portfolio size for revenue forecasting."
    - name: "avg_unit_volume_usd"
      expr: AVG(CAST(average_unit_volume_usd AS DOUBLE))
      comment: "Average unit volume (AUV) in USD. Primary unit-level revenue productivity KPI for portfolio benchmarking."
    - name: "total_auv"
      expr: SUM(CAST(average_unit_volume_usd AS DOUBLE))
      comment: "Total AUV across all units. Aggregate revenue productivity for portfolio-level financial planning."
    - name: "avg_same_store_sales_pct"
      expr: AVG(CAST(same_store_sales_pct AS DOUBLE))
      comment: "Average same-store sales percentage across units. Organic growth indicator for investor and board reporting."
    - name: "avg_table_turn_rate"
      expr: AVG(CAST(table_turn_rate AS DOUBLE))
      comment: "Average table turn rate across dine-in units. Measures seating capacity utilization efficiency."
    - name: "online_ordering_unit_count"
      expr: SUM(CASE WHEN has_online_ordering = TRUE THEN 1 ELSE 0 END)
      comment: "Count of units with online ordering enabled. Tracks digital channel adoption across the portfolio."
    - name: "third_party_delivery_unit_count"
      expr: SUM(CASE WHEN has_third_party_delivery = TRUE THEN 1 ELSE 0 END)
      comment: "Count of units participating in third-party delivery. Measures delivery channel penetration for revenue diversification strategy."
    - name: "haccp_certified_unit_count"
      expr: SUM(CASE WHEN haccp_certified = TRUE THEN 1 ELSE 0 END)
      comment: "Count of HACCP-certified units. Food safety compliance portfolio metric for regulatory and brand standard reporting."
    - name: "haccp_certification_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN haccp_certified = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of units with HACCP certification. Tracks food safety compliance across the portfolio."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`restaurant_renovation_project`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Capital expenditure and renovation project KPIs. Drives remodel ROI analysis, capex budget management, and brand standard upgrade tracking."
  source: "`vibe_restaurants_v1`.`restaurant`.`renovation_project`"
  dimensions:
    - name: "project_status"
      expr: project_status
      comment: "Current status of the renovation project (planned, in-progress, completed, cancelled)."
    - name: "project_type"
      expr: project_type
      comment: "Type of renovation (full remodel, refresh, equipment upgrade) for capex categorization."
    - name: "project_priority"
      expr: project_priority
      comment: "Priority level of the project for capital allocation and scheduling decisions."
    - name: "financing_method"
      expr: financing_method
      comment: "Financing method (company-funded, franchisee-funded, loan) for capital structure analysis."
    - name: "inspection_status"
      expr: inspection_status
      comment: "Final inspection status for regulatory compliance tracking of completed renovations."
    - name: "ada_compliance_flag"
      expr: ada_compliance_flag
      comment: "Indicates ADA compliance was addressed in the renovation, for accessibility compliance reporting."
    - name: "energy_efficiency_upgrade_flag"
      expr: energy_efficiency_upgrade_flag
      comment: "Flags projects that included energy efficiency upgrades for sustainability reporting."
    - name: "planned_start_date"
      expr: planned_start_date
      comment: "Planned start date for project pipeline and capital deployment scheduling."
  measures:
    - name: "total_projects"
      expr: COUNT(1)
      comment: "Total number of renovation projects. Baseline volume for capex pipeline management."
    - name: "total_estimated_capex"
      expr: SUM(CAST(estimated_capex_usd AS DOUBLE))
      comment: "Total estimated capital expenditure across all renovation projects. Core capex budget planning metric."
    - name: "total_actual_capex"
      expr: SUM(CAST(actual_capex_usd AS DOUBLE))
      comment: "Total actual capital expenditure incurred. Compared against estimates to measure budget discipline."
    - name: "total_budget_variance"
      expr: SUM(CAST(budget_variance_usd AS DOUBLE))
      comment: "Total capex budget variance (actual minus estimated). Negative values indicate under-budget performance."
    - name: "avg_budget_variance"
      expr: AVG(CAST(budget_variance_usd AS DOUBLE))
      comment: "Average capex budget variance per project. Measures project management cost control effectiveness."
    - name: "avg_expected_auv_lift_pct"
      expr: AVG(CAST(expected_auv_lift_percent AS DOUBLE))
      comment: "Average expected AUV lift from renovation. Used to build the business case for remodel investment."
    - name: "avg_actual_auv_lift_pct"
      expr: AVG(CAST(actual_auv_lift_percent AS DOUBLE))
      comment: "Average actual AUV lift achieved post-renovation. Validates remodel ROI assumptions and informs future investment decisions."
    - name: "projects_with_ada_compliance"
      expr: SUM(CASE WHEN ada_compliance_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of renovation projects that addressed ADA compliance. Tracks accessibility upgrade progress across the portfolio."
    - name: "energy_efficiency_project_count"
      expr: SUM(CASE WHEN energy_efficiency_upgrade_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of projects including energy efficiency upgrades. Supports sustainability and utility cost reduction reporting."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`restaurant_throughput_benchmark`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Throughput benchmark KPIs defining target capacity and service speed standards by unit, format, and daypart. Drives operational planning and staffing model decisions."
  source: "`vibe_restaurants_v1`.`restaurant`.`throughput_benchmark`"
  dimensions:
    - name: "throughput_benchmark_status"
      expr: throughput_benchmark_status
      comment: "Status of the benchmark (active, superseded, draft) for filtering to current operational standards."
    - name: "benchmark_type"
      expr: benchmark_type
      comment: "Type of benchmark (peak, off-peak, average) for context-appropriate target comparison."
    - name: "benchmark_source"
      expr: benchmark_source
      comment: "Source of the benchmark (corporate, regional, unit-specific) for governance and override tracking."
    - name: "service_channel"
      expr: service_channel
      comment: "Service channel the benchmark applies to (drive-thru, dine-in, delivery) for channel-specific capacity planning."
    - name: "restaurant_format"
      expr: restaurant_format
      comment: "Restaurant format (QSR, fast casual, full service) for format-appropriate benchmark comparison."
    - name: "effective_start_date"
      expr: effective_start_date
      comment: "Effective start date of the benchmark for temporal validity filtering."
  measures:
    - name: "total_benchmarks"
      expr: COUNT(1)
      comment: "Total number of throughput benchmarks defined. Tracks benchmark coverage across units and channels."
    - name: "avg_target_throughput_covers_per_hour"
      expr: AVG(CAST(target_throughput_covers_per_hour AS DOUBLE))
      comment: "Average target throughput in covers per hour. Primary capacity planning KPI for dine-in format staffing and layout decisions."
    - name: "avg_target_throughput_transactions_per_hour"
      expr: AVG(CAST(target_throughput_transactions_per_hour AS DOUBLE))
      comment: "Average target transaction throughput per hour. Drives POS, kitchen, and staffing capacity planning."
    - name: "avg_sos_compliance_threshold_pct"
      expr: AVG(CAST(sos_compliance_threshold_pct AS DOUBLE))
      comment: "Average SOS compliance threshold percentage across benchmarks. Sets the performance bar for speed-of-service compliance reporting."
    - name: "avg_target_acv"
      expr: AVG(CAST(target_acv AS DOUBLE))
      comment: "Average target average check value. Used to set revenue-per-transaction expectations for unit performance evaluation."
    - name: "avg_target_adt"
      expr: AVG(CAST(target_adt AS DOUBLE))
      comment: "Average target average daily transactions. Core volume target for unit-level revenue forecasting."
    - name: "avg_target_atc"
      expr: AVG(CAST(target_atc AS DOUBLE))
      comment: "Average target average transaction count. Supports throughput planning and labor scheduling models."
    - name: "avg_labor_fte_requirement"
      expr: AVG(CAST(labor_fte_requirement AS DOUBLE))
      comment: "Average labor FTE requirement per benchmark. Directly informs workforce scheduling and labor cost budgeting."
    - name: "avg_peak_hour_multiplier"
      expr: AVG(CAST(peak_hour_multiplier AS DOUBLE))
      comment: "Average peak hour throughput multiplier. Used to scale staffing and capacity plans for peak demand periods."
    - name: "avg_off_peak_multiplier"
      expr: AVG(CAST(off_peak_multiplier AS DOUBLE))
      comment: "Average off-peak throughput multiplier. Enables right-sizing of labor and resources during low-demand periods."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`restaurant_store_campaign_assignment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Local marketing fund (LMF) and campaign execution KPIs at the store level. Drives marketing ROI, compliance, and fund utilization decisions."
  source: "`vibe_restaurants_v1`.`restaurant`.`store_campaign_assignment`"
  dimensions:
    - name: "store_campaign_assignment_status"
      expr: store_campaign_assignment_status
      comment: "Status of the campaign assignment (active, completed, cancelled) for pipeline and execution tracking."
    - name: "channel"
      expr: channel
      comment: "Marketing channel (digital, print, radio, OOH) for channel-level ROI analysis."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the campaign assignment for governance and compliance tracking."
    - name: "compliance_flag"
      expr: compliance_flag
      comment: "Indicates whether the store executed the campaign in compliance with brand standards."
    - name: "market_dma"
      expr: market_dma
      comment: "Designated market area (DMA) for geographic marketing performance analysis."
    - name: "initiative_code"
      expr: initiative_code
      comment: "Marketing initiative code for campaign family and program-level aggregation."
    - name: "start_date"
      expr: start_date
      comment: "Campaign start date for temporal performance analysis."
    - name: "target_audience"
      expr: target_audience
      comment: "Target audience segment for audience-level marketing effectiveness analysis."
  measures:
    - name: "total_campaign_assignments"
      expr: COUNT(1)
      comment: "Total store-campaign assignments. Baseline volume for marketing execution coverage analysis."
    - name: "total_planned_spend"
      expr: SUM(CAST(planned_spend AS DOUBLE))
      comment: "Total planned marketing spend across all store-campaign assignments. Core marketing budget planning metric."
    - name: "total_actual_spend"
      expr: SUM(CAST(actual_spend AS DOUBLE))
      comment: "Total actual marketing spend incurred. Compared against planned spend for budget discipline tracking."
    - name: "total_lmf_fund_amount"
      expr: SUM(CAST(lmf_fund_amount AS DOUBLE))
      comment: "Total local marketing fund (LMF) allocated. Tracks fund deployment across the franchise system."
    - name: "total_lmf_fund_used"
      expr: SUM(CAST(lmf_fund_used AS DOUBLE))
      comment: "Total LMF funds actually utilized. Measures fund utilization efficiency and identifies under-spending franchisees."
    - name: "total_lmf_remaining"
      expr: SUM(CAST(lmf_remaining_amount AS DOUBLE))
      comment: "Total remaining LMF balance. Identifies unspent marketing funds that may need reallocation."
    - name: "avg_expected_comp_sales_lift_pct"
      expr: AVG(CAST(expected_comp_sales_lift_percent AS DOUBLE))
      comment: "Average expected comp sales lift from campaigns. Used to set marketing ROI expectations and justify spend."
    - name: "avg_actual_comp_sales_lift_pct"
      expr: AVG(CAST(actual_comp_sales_lift_percent AS DOUBLE))
      comment: "Average actual comp sales lift achieved. Validates marketing ROI and informs future campaign investment decisions."
    - name: "avg_expected_adt_lift_pct"
      expr: AVG(CAST(expected_adt_lift_percent AS DOUBLE))
      comment: "Average expected average daily transaction lift from campaigns. Measures traffic-driving effectiveness of marketing."
    - name: "avg_actual_adt_lift_pct"
      expr: AVG(CAST(actual_adt_lift_percent AS DOUBLE))
      comment: "Average actual ADT lift achieved. Compares traffic outcomes to expectations for campaign effectiveness scoring."
    - name: "compliant_assignment_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN compliance_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of campaign assignments executed in compliance with brand standards. Tracks marketing execution quality across the franchise system."
    - name: "lmf_utilization_rate"
      expr: ROUND(100.0 * SUM(CAST(lmf_fund_used AS DOUBLE)) / NULLIF(SUM(CAST(lmf_fund_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of allocated LMF funds actually utilized. Low utilization signals franchisee under-investment in local marketing."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`restaurant_equipment_asset`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Equipment asset lifecycle and maintenance KPIs. Drives preventive maintenance scheduling, asset replacement decisions, and compliance certification tracking."
  source: "`vibe_restaurants_v1`.`restaurant`.`equipment_asset`"
  dimensions:
    - name: "equipment_category"
      expr: equipment_category
      comment: "Equipment category (cooking, refrigeration, POS, HVAC) for category-level asset management."
    - name: "equipment_type"
      expr: equipment_type
      comment: "Specific equipment type for granular asset tracking and maintenance planning."
    - name: "operational_status"
      expr: operational_status
      comment: "Current operational status of the asset (active, out-of-service, decommissioned)."
    - name: "ownership_type"
      expr: ownership_type
      comment: "Asset ownership type (owned, leased, rented) for financial treatment and lifecycle planning."
    - name: "asset_condition_rating"
      expr: asset_condition_rating
      comment: "Current condition rating of the asset for replacement prioritization."
    - name: "temperature_critical_flag"
      expr: temperature_critical_flag
      comment: "Flags temperature-critical equipment (refrigeration, freezers) for food safety compliance monitoring."
    - name: "depreciation_method"
      expr: depreciation_method
      comment: "Depreciation method applied to the asset for financial reporting consistency."
  measures:
    - name: "total_assets"
      expr: COUNT(1)
      comment: "Total number of equipment assets. Baseline portfolio size for asset management planning."
    - name: "total_acquisition_cost"
      expr: SUM(CAST(acquisition_cost_usd AS DOUBLE))
      comment: "Total acquisition cost of all equipment assets. Core capex tracking metric for asset portfolio valuation."
    - name: "total_replacement_cost"
      expr: SUM(CAST(replacement_cost_usd AS DOUBLE))
      comment: "Total current replacement cost of the asset portfolio. Drives capital reserve planning for equipment refresh cycles."
    - name: "avg_acquisition_cost"
      expr: AVG(CAST(acquisition_cost_usd AS DOUBLE))
      comment: "Average acquisition cost per asset. Benchmarks procurement efficiency and informs future equipment budgeting."
    - name: "avg_replacement_cost"
      expr: AVG(CAST(replacement_cost_usd AS DOUBLE))
      comment: "Average replacement cost per asset. Used to estimate future capex requirements for equipment lifecycle management."
    - name: "temperature_critical_asset_count"
      expr: SUM(CASE WHEN temperature_critical_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of temperature-critical assets. Prioritizes food safety monitoring and maintenance scheduling for high-risk equipment."
    - name: "avg_temperature_max_f"
      expr: AVG(CAST(temperature_max_f AS DOUBLE))
      comment: "Average maximum operating temperature across temperature-critical assets. Monitors food safety compliance thresholds."
    - name: "avg_temperature_min_f"
      expr: AVG(CAST(temperature_min_f AS DOUBLE))
      comment: "Average minimum operating temperature across temperature-critical assets. Ensures cold chain compliance for food safety."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`restaurant_unit_status_history`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Unit lifecycle and status change KPIs. Tracks new restaurant openings (NRO), closures, renovations, and revenue impact of status transitions."
  source: "`vibe_restaurants_v1`.`restaurant`.`unit_status_history`"
  dimensions:
    - name: "unit_status_history_status"
      expr: unit_status_history_status
      comment: "Current status of the unit status history record for data quality filtering."
    - name: "closure_type"
      expr: closure_type
      comment: "Type of closure (temporary, permanent, renovation) for portfolio health analysis."
    - name: "reason_code"
      expr: reason_code
      comment: "Reason code for the status change, enabling root-cause analysis of closures and transitions."
    - name: "previous_status"
      expr: previous_status
      comment: "Previous unit status before the transition, for status flow and transition pattern analysis."
    - name: "nro_flag"
      expr: nro_flag
      comment: "Flags new restaurant opening events for NRO count and pipeline tracking."
    - name: "is_sss_eligible"
      expr: is_sss_eligible
      comment: "Indicates whether the unit is eligible for same-store sales calculation during this period."
    - name: "approval_required"
      expr: approval_required
      comment: "Indicates whether the status change required approval, for governance compliance tracking."
    - name: "effective_date"
      expr: effective_date
      comment: "Effective date of the status change for temporal trend analysis of portfolio transitions."
  measures:
    - name: "total_status_changes"
      expr: COUNT(1)
      comment: "Total number of unit status change events. Baseline volume for portfolio lifecycle activity tracking."
    - name: "nro_count"
      expr: SUM(CASE WHEN nro_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of new restaurant opening events. Primary NRO pipeline metric for growth strategy reporting."
    - name: "total_estimated_revenue_impact"
      expr: SUM(CAST(estimated_revenue_impact AS DOUBLE))
      comment: "Total estimated revenue impact of unit status changes. Quantifies financial exposure from closures and transitions."
    - name: "avg_estimated_revenue_impact"
      expr: AVG(CAST(estimated_revenue_impact AS DOUBLE))
      comment: "Average estimated revenue impact per status change event. Benchmarks the financial significance of unit transitions."
    - name: "sss_eligible_unit_count"
      expr: SUM(CASE WHEN is_sss_eligible = TRUE THEN 1 ELSE 0 END)
      comment: "Count of unit-period records eligible for same-store sales calculation. Defines the SSS comp base for organic growth reporting."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`restaurant_area_management`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Area management KPIs covering geographic territory performance targets and franchise portfolio composition. Drives area director accountability and territory planning."
  source: "`vibe_restaurants_v1`.`restaurant`.`area_management`"
  dimensions:
    - name: "area_status"
      expr: area_status
      comment: "Current status of the area management record (active, inactive) for filtering to live territories."
    - name: "area_type"
      expr: area_type
      comment: "Type of area (region, district, territory) for hierarchical performance analysis."
    - name: "hierarchy_level"
      expr: hierarchy_level
      comment: "Hierarchy level of the area for organizational structure analysis."
    - name: "geographic_region"
      expr: geographic_region
      comment: "Geographic region for regional performance comparison and resource allocation."
    - name: "country_code"
      expr: country_code
      comment: "Country code for international portfolio segmentation."
    - name: "division"
      expr: division
      comment: "Business division for divisional performance reporting."
    - name: "franchise_agreement_flag"
      expr: franchise_agreement_flag
      comment: "Indicates whether the area operates under a franchise agreement for ownership model analysis."
    - name: "brand"
      expr: brand
      comment: "Brand associated with the area for multi-brand portfolio analysis."
  measures:
    - name: "total_areas"
      expr: COUNT(1)
      comment: "Total number of area management records. Baseline for organizational structure and territory coverage analysis."
    - name: "avg_auv_target"
      expr: AVG(CAST(auv_target AS DOUBLE))
      comment: "Average AUV target set for areas. Benchmarks revenue expectations across territories for performance management."
    - name: "avg_cogs_percent_target"
      expr: AVG(CAST(cogs_percent_target AS DOUBLE))
      comment: "Average COGS percentage target across areas. Sets food cost expectations for area-level P&L management."
    - name: "avg_labor_percent_target"
      expr: AVG(CAST(labor_percent_target AS DOUBLE))
      comment: "Average labor percentage target across areas. Drives workforce planning and scheduling efficiency targets."
    - name: "avg_csat_target_score"
      expr: AVG(CAST(csat_target_score AS DOUBLE))
      comment: "Average customer satisfaction target score across areas. Sets guest experience expectations for area directors."
    - name: "avg_nps_target_score"
      expr: AVG(CAST(nps_target_score AS DOUBLE))
      comment: "Average NPS target score across areas. Tracks guest loyalty expectations at the territory level."
    - name: "avg_sss_target_percent"
      expr: AVG(CAST(sss_target_percent AS DOUBLE))
      comment: "Average same-store sales growth target across areas. Sets organic growth expectations for area performance reviews."
    - name: "avg_royalty_rate_percent"
      expr: AVG(CAST(royalty_rate_percent AS DOUBLE))
      comment: "Average royalty rate across franchise areas. Tracks franchise system revenue contribution rates."
    - name: "avg_marketing_fund_contribution_pct"
      expr: AVG(CAST(marketing_fund_contribution_percent AS DOUBLE))
      comment: "Average marketing fund contribution percentage across areas. Monitors LMF funding levels for marketing investment planning."
$$;