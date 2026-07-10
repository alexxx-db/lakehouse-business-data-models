-- Metric views for domain: franchise | Business: Restaurants | Version: 2 | Generated on: 2026-07-10 18:21:26

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`franchise_agreement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Franchise agreement lifecycle metrics covering royalty economics, fee structures, renewal terms, and compliance posture. Used by franchise development and legal teams to monitor portfolio health and contractual obligations."
  source: "`vibe_restaurants_v1`.`franchise`.`agreement`"
  dimensions:
    - name: "agreement_status"
      expr: agreement_status
      comment: "Current lifecycle status of the franchise agreement (e.g. Active, Terminated, Pending Renewal)."
    - name: "agreement_type"
      expr: agreement_type
      comment: "Classification of the agreement (e.g. Single-Unit, Multi-Unit, Area Development)."
    - name: "compliance_status"
      expr: compliance_status
      comment: "Compliance posture of the agreement at the time of reporting."
    - name: "ftc_compliance_attestation"
      expr: ftc_compliance_attestation_flag
      comment: "Whether the franchisee has attested FTC compliance for this agreement."
    - name: "transfer_rights"
      expr: transfer_rights_flag
      comment: "Whether the agreement grants transfer rights to the franchisee."
    - name: "effective_start_year"
      expr: DATE_TRUNC('YEAR', effective_start_date)
      comment: "Year the agreement became effective, used for cohort and vintage analysis."
    - name: "effective_end_year"
      expr: DATE_TRUNC('YEAR', effective_end_date)
      comment: "Year the agreement is scheduled to expire, used for renewal pipeline planning."
    - name: "signed_year"
      expr: DATE_TRUNC('YEAR', signed_date)
      comment: "Year the agreement was signed, used for new-deal volume trending."
  measures:
    - name: "active_agreement_count"
      expr: COUNT(CASE WHEN agreement_status = 'Active' THEN agreement_id END)
      comment: "Number of currently active franchise agreements. Core portfolio size KPI for franchise development leadership."
    - name: "total_initial_fee_revenue"
      expr: SUM(CAST(initial_fee_amount AS DOUBLE))
      comment: "Total initial franchise fees collected across all agreements. Measures new-unit revenue contribution from franchise sales."
    - name: "avg_royalty_rate_percent"
      expr: AVG(CAST(royalty_rate_percent AS DOUBLE))
      comment: "Average royalty rate across the agreement portfolio. Tracks pricing consistency and negotiation drift over time."
    - name: "avg_marketing_fee_percent"
      expr: AVG(CAST(marketing_fee_percent AS DOUBLE))
      comment: "Average marketing fund contribution rate across agreements. Informs marketing fund adequacy and franchisee cost burden."
    - name: "total_sales_target"
      expr: SUM(CAST(sales_target_amount AS DOUBLE))
      comment: "Aggregate contractual sales targets across all agreements. Used to benchmark actual performance against committed volumes."
    - name: "avg_average_unit_volume"
      expr: AVG(CAST(average_unit_volume AS DOUBLE))
      comment: "Average unit volume (AUV) embedded in agreements. Key indicator of franchisee economic health and system-wide productivity."
    - name: "total_renewal_fee_revenue"
      expr: SUM(CAST(renewal_fee_amount AS DOUBLE))
      comment: "Total renewal fees across all agreements. Measures recurring revenue from franchise renewals."
    - name: "non_compliant_agreement_count"
      expr: COUNT(CASE WHEN compliance_status != 'Compliant' AND compliance_status IS NOT NULL THEN agreement_id END)
      comment: "Number of agreements with a non-compliant compliance status. Drives legal and operations intervention prioritization."
    - name: "agreements_expiring_within_12_months"
      expr: COUNT(CASE WHEN effective_end_date BETWEEN CURRENT_DATE AND DATE_ADD(CURRENT_DATE, 365) THEN agreement_id END)
      comment: "Count of agreements expiring within the next 12 months. Critical renewal pipeline metric for franchise development planning."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`franchise_franchisee`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Franchisee portfolio health metrics covering financial standing, compliance, unit counts, and royalty economics. Used by franchise operations, finance, and executive leadership to assess the health and scale of the franchisee base."
  source: "`vibe_restaurants_v1`.`franchise`.`franchisee`"
  dimensions:
    - name: "franchisee_status"
      expr: franchisee_status
      comment: "Current operational status of the franchisee (e.g. Active, Terminated, Probation)."
    - name: "franchisee_type"
      expr: franchisee_type
      comment: "Classification of the franchisee (e.g. Single-Unit, Multi-Unit, Area Developer)."
    - name: "compliance_status"
      expr: compliance_status
      comment: "Current compliance posture of the franchisee."
    - name: "country_code"
      expr: country_code
      comment: "Country where the franchisee operates, used for geographic segmentation."
    - name: "state_province"
      expr: state_province
      comment: "State or province of the franchisee, used for regional performance analysis."
    - name: "credit_rating"
      expr: credit_rating
      comment: "Credit rating of the franchisee, used for financial risk segmentation."
    - name: "food_safety_certified"
      expr: food_safety_certified
      comment: "Whether the franchisee holds current food safety certification."
    - name: "ifa_membership_status"
      expr: ifa_membership_status
      comment: "International Franchise Association membership status of the franchisee."
    - name: "industry_segment"
      expr: industry_segment
      comment: "Industry segment classification of the franchisee (e.g. QSR, Fast Casual)."
    - name: "established_year"
      expr: DATE_TRUNC('YEAR', established_date)
      comment: "Year the franchisee was established, used for tenure cohort analysis."
  measures:
    - name: "active_franchisee_count"
      expr: COUNT(CASE WHEN franchisee_status = 'Active' THEN franchisee_id END)
      comment: "Number of active franchisees in the system. Core portfolio size KPI for franchise development and executive reporting."
    - name: "total_annual_revenue"
      expr: SUM(CAST(annual_revenue AS DOUBLE))
      comment: "Total annual revenue across all franchisees. Measures the economic scale of the franchisee network."
    - name: "avg_annual_revenue_per_franchisee"
      expr: AVG(CAST(annual_revenue AS DOUBLE))
      comment: "Average annual revenue per franchisee. Benchmarks franchisee productivity and identifies underperformers."
    - name: "avg_average_unit_volume"
      expr: AVG(CAST(average_unit_volume AS DOUBLE))
      comment: "Average unit volume (AUV) across franchisees. Key system-wide productivity metric used in QBRs and board reporting."
    - name: "total_royalty_fee_revenue"
      expr: SUM(CAST(royalty_fee_amount AS DOUBLE))
      comment: "Total royalty fees owed by franchisees. Measures the royalty revenue stream for the franchisor."
    - name: "avg_royalty_rate"
      expr: AVG(CAST(royalty_rate AS DOUBLE))
      comment: "Average royalty rate across the franchisee base. Tracks pricing consistency and negotiation outcomes."
    - name: "total_franchise_fee_revenue"
      expr: SUM(CAST(franchise_fee_amount AS DOUBLE))
      comment: "Total initial franchise fees across all franchisees. Measures new-unit fee revenue contribution."
    - name: "non_compliant_franchisee_count"
      expr: COUNT(CASE WHEN compliance_status != 'Compliant' AND compliance_status IS NOT NULL THEN franchisee_id END)
      comment: "Number of franchisees with non-compliant status. Drives compliance intervention and risk management decisions."
    - name: "food_safety_certified_rate"
      expr: AVG(CASE WHEN food_safety_certified = TRUE THEN 1.0 ELSE 0.0 END)
      comment: "Proportion of franchisees with current food safety certification. Regulatory compliance KPI for operations and legal teams."
    - name: "franchisees_with_expiring_insurance"
      expr: COUNT(CASE WHEN insurance_expiry_date BETWEEN CURRENT_DATE AND DATE_ADD(CURRENT_DATE, 90) THEN franchisee_id END)
      comment: "Franchisees whose insurance expires within 90 days. Risk management metric to prevent coverage lapses."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`franchise_compliance_audit`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Franchise compliance audit quality and outcome metrics. Used by franchise operations, quality assurance, and executive leadership to monitor brand standards adherence, food safety, and corrective action rates across the franchisee network."
  source: "`vibe_restaurants_v1`.`franchise`.`compliance_audit`"
  dimensions:
    - name: "audit_type"
      expr: audit_type
      comment: "Type of compliance audit conducted (e.g. Announced, Unannounced, Follow-Up)."
    - name: "compliance_audit_status"
      expr: compliance_audit_status
      comment: "Current status of the audit (e.g. Completed, In Progress, Pending)."
    - name: "audit_disposition"
      expr: audit_disposition
      comment: "Outcome disposition of the audit (e.g. Pass, Fail, Conditional Pass)."
    - name: "corrective_action_required"
      expr: corrective_action_required
      comment: "Whether the audit resulted in a corrective action requirement."
    - name: "audit_source_system"
      expr: audit_source_system
      comment: "Source system that originated the audit record, used for data lineage and channel analysis."
    - name: "audit_month"
      expr: DATE_TRUNC('MONTH', audit_timestamp)
      comment: "Month the audit was conducted, used for trend analysis of compliance performance over time."
    - name: "audit_year"
      expr: DATE_TRUNC('YEAR', audit_timestamp)
      comment: "Year the audit was conducted, used for annual compliance reporting."
  measures:
    - name: "total_audits_conducted"
      expr: COUNT(compliance_audit_id)
      comment: "Total number of compliance audits conducted. Measures audit program coverage and activity volume."
    - name: "avg_overall_score"
      expr: AVG(CAST(overall_score AS DOUBLE))
      comment: "Average overall compliance audit score across all audits. Primary brand standards quality KPI for franchise operations leadership."
    - name: "avg_food_safety_score"
      expr: AVG(CAST(food_safety_score AS DOUBLE))
      comment: "Average food safety score across audits. Critical regulatory and brand risk metric monitored at executive level."
    - name: "avg_brand_standards_score"
      expr: AVG(CAST(brand_standards_score AS DOUBLE))
      comment: "Average brand standards score across audits. Measures consistency of brand execution across the franchisee network."
    - name: "avg_cleanliness_score"
      expr: AVG(CAST(cleanliness_score AS DOUBLE))
      comment: "Average cleanliness score across audits. Operational quality metric tied to guest satisfaction and health inspection outcomes."
    - name: "avg_service_score"
      expr: AVG(CAST(service_score AS DOUBLE))
      comment: "Average service score across audits. Guest experience quality metric used in franchisee performance reviews."
    - name: "avg_equipment_score"
      expr: AVG(CAST(equipment_score AS DOUBLE))
      comment: "Average equipment condition score across audits. Drives capital reinvestment and remodel prioritization decisions."
    - name: "corrective_action_rate"
      expr: AVG(CASE WHEN corrective_action_required = TRUE THEN 1.0 ELSE 0.0 END)
      comment: "Proportion of audits requiring corrective action. Key compliance risk indicator; high rates trigger franchise intervention programs."
    - name: "failed_audit_count"
      expr: COUNT(CASE WHEN audit_disposition = 'Fail' THEN compliance_audit_id END)
      comment: "Number of audits with a failing disposition. Drives escalation, corrective action, and potential franchise termination decisions."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`franchise_performance_scorecard`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Franchisee performance scorecard metrics covering sales growth, royalty timeliness, customer satisfaction, and training compliance. Used by franchise operations and executive leadership for quarterly business reviews and franchisee tier management."
  source: "`vibe_restaurants_v1`.`franchise`.`performance_scorecard`"
  dimensions:
    - name: "evaluation_type"
      expr: evaluation_type
      comment: "Type of performance evaluation (e.g. Monthly, Quarterly, Annual)."
    - name: "evaluation_status"
      expr: evaluation_status
      comment: "Current status of the scorecard evaluation (e.g. Draft, Finalized, Under Review)."
    - name: "overall_performance_tier"
      expr: overall_performance_tier
      comment: "Performance tier assigned to the franchisee (e.g. Platinum, Gold, Silver, Bronze). Used for incentive and support allocation."
    - name: "region_code"
      expr: region_code
      comment: "Geographic region of the evaluated unit, used for regional performance benchmarking."
    - name: "evaluation_year"
      expr: evaluation_year
      comment: "Year of the evaluation period, used for year-over-year performance trending."
    - name: "evaluation_month"
      expr: evaluation_month
      comment: "Month of the evaluation period, used for monthly performance tracking."
    - name: "evaluation_period_start_month"
      expr: DATE_TRUNC('MONTH', evaluation_period_start)
      comment: "Start month of the evaluation period, used for time-series alignment."
  measures:
    - name: "avg_same_store_sales_growth_pct"
      expr: AVG(CAST(same_store_sales_growth_pct AS DOUBLE))
      comment: "Average same-store sales growth percentage across franchisees. Premier top-line growth KPI used in board and investor reporting."
    - name: "avg_customer_satisfaction_score"
      expr: AVG(CAST(customer_satisfaction_score AS DOUBLE))
      comment: "Average customer satisfaction score across franchisee scorecards. Measures guest experience quality at the franchisee level."
    - name: "avg_compliance_audit_score"
      expr: AVG(CAST(compliance_audit_average_score AS DOUBLE))
      comment: "Average compliance audit score embedded in performance scorecards. Tracks brand standards adherence at the franchisee level."
    - name: "avg_royalty_payment_timeliness_pct"
      expr: AVG(CAST(royalty_payment_timeliness_pct AS DOUBLE))
      comment: "Average royalty payment timeliness rate across franchisees. Financial discipline KPI; low rates signal cash flow or relationship issues."
    - name: "avg_training_completion_rate_pct"
      expr: AVG(CAST(training_completion_rate_pct AS DOUBLE))
      comment: "Average training completion rate across franchisees. Operational readiness metric tied to food safety and brand standards outcomes."
    - name: "total_royalty_revenue"
      expr: SUM(CAST(total_royalty_amount AS DOUBLE))
      comment: "Total royalty revenue reported across all scorecards. Core franchisor revenue stream metric for finance and executive reporting."
    - name: "total_sales_revenue"
      expr: SUM(CAST(total_sales_amount AS DOUBLE))
      comment: "Total system-wide sales reported across all franchisee scorecards. Measures the economic scale of the franchise system."
    - name: "avg_average_unit_volume"
      expr: AVG(CAST(average_unit_volume AS DOUBLE))
      comment: "Average unit volume (AUV) across franchisee scorecards. Key productivity benchmark used in franchise development and renewal decisions."
    - name: "avg_food_safety_score"
      expr: AVG(CAST(food_safety_score AS DOUBLE))
      comment: "Average food safety score from performance scorecards. Regulatory compliance and brand risk metric monitored at executive level."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`franchise_sales_report`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Franchisee sales reporting metrics covering gross and net sales, royalty obligations, average check value, and transaction volume. Used by finance, franchise operations, and executive leadership for revenue recognition, royalty billing, and system-wide sales performance monitoring."
  source: "`vibe_restaurants_v1`.`franchise`.`sales_report`"
  dimensions:
    - name: "sales_report_status"
      expr: sales_report_status
      comment: "Current status of the sales report (e.g. Submitted, Validated, Rejected)."
    - name: "reporting_period_type"
      expr: reporting_period_type
      comment: "Granularity of the reporting period (e.g. Weekly, Monthly, Quarterly)."
    - name: "validation_status"
      expr: validation_status
      comment: "Validation outcome of the submitted sales report. Used to identify data quality issues requiring follow-up."
    - name: "variance_flag"
      expr: variance_flag
      comment: "Whether the report contains a material variance from expected sales. Triggers audit and investigation workflows."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which sales are reported, used for multi-currency portfolio analysis."
    - name: "submission_method"
      expr: submission_method
      comment: "Method used to submit the sales report (e.g. Portal, EDI, Manual). Used to track digital adoption."
    - name: "reporting_period_start_month"
      expr: DATE_TRUNC('MONTH', reporting_period_start)
      comment: "Start month of the reporting period, used for monthly sales trend analysis."
    - name: "reporting_period_start_year"
      expr: DATE_TRUNC('YEAR', reporting_period_start)
      comment: "Start year of the reporting period, used for annual sales performance reporting."
  measures:
    - name: "total_gross_sales"
      expr: SUM(CAST(gross_sales_amount AS DOUBLE))
      comment: "Total gross sales reported across all franchise sales reports. Top-line system-wide revenue metric for executive and investor reporting."
    - name: "total_net_sales"
      expr: SUM(CAST(net_sales_amount AS DOUBLE))
      comment: "Total net sales after adjustments across all franchise sales reports. Used for royalty calculation and financial reporting."
    - name: "total_royalty_revenue"
      expr: SUM(CAST(royalty_amount AS DOUBLE))
      comment: "Total royalty revenue collected from franchisees. Core franchisor revenue stream metric for finance and executive reporting."
    - name: "total_franchise_fee_revenue"
      expr: SUM(CAST(franchise_fee AS DOUBLE))
      comment: "Total franchise fees reported across sales reports. Measures fee revenue contribution from the franchisee network."
    - name: "avg_check_value"
      expr: AVG(CAST(average_check_value AS DOUBLE))
      comment: "Average check value across all reported periods. Guest spending productivity metric used in menu pricing and upsell strategy decisions."
    - name: "total_transaction_count"
      expr: SUM(CAST(transaction_count AS BIGINT))
      comment: "Total transaction count across all franchise sales reports. Measures guest traffic volume across the system."
    - name: "total_adjustments"
      expr: SUM(CAST(adjustments_amount AS DOUBLE))
      comment: "Total sales adjustments reported. High adjustment volumes signal data quality issues or franchisee reporting irregularities."
    - name: "total_variance_amount"
      expr: SUM(CAST(variance_amount AS DOUBLE))
      comment: "Total variance between reported and expected sales. Used to identify franchisees with systematic under-reporting or data quality issues."
    - name: "avg_royalty_rate"
      expr: AVG(CAST(royalty_rate AS DOUBLE))
      comment: "Average effective royalty rate across submitted sales reports. Tracks rate consistency and identifies negotiated exceptions."
    - name: "total_same_store_sales"
      expr: SUM(CAST(same_store_sales AS DOUBLE))
      comment: "Total same-store sales across all franchise reports. Comparable-unit growth metric used in system-wide performance benchmarking."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`franchise_nro_pipeline`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "New Restaurant Opening (NRO) pipeline metrics covering capital investment, project status, ROI expectations, and development velocity. Used by franchise development, real estate, and executive leadership to manage the new unit growth pipeline."
  source: "`vibe_restaurants_v1`.`franchise`.`nro_pipeline`"
  dimensions:
    - name: "project_status"
      expr: project_status
      comment: "Current status of the NRO project (e.g. Approved, Under Construction, Opened, Cancelled)."
    - name: "stage"
      expr: stage
      comment: "Current development stage of the NRO project (e.g. Site Selection, Permitting, Construction, Pre-Opening)."
    - name: "development_type"
      expr: development_type
      comment: "Type of development (e.g. Ground-Up, Conversion, Inline, Drive-Thru). Used for capital planning and format strategy."
    - name: "risk_level"
      expr: risk_level
      comment: "Risk classification of the NRO project. Used to prioritize executive attention and contingency planning."
    - name: "compliance_status"
      expr: compliance_status
      comment: "Compliance status of the NRO project, used to flag regulatory or permitting issues."
    - name: "construction_complete_flag"
      expr: construction_complete_flag
      comment: "Whether construction has been completed on the NRO project."
    - name: "permits_obtained_flag"
      expr: permits_obtained_flag
      comment: "Whether all required permits have been obtained for the NRO project."
    - name: "brand"
      expr: brand
      comment: "Brand associated with the NRO project, used for multi-brand portfolio analysis."
    - name: "target_open_year"
      expr: DATE_TRUNC('YEAR', target_open_date)
      comment: "Target opening year, used for annual new unit growth planning and pipeline forecasting."
    - name: "target_open_month"
      expr: DATE_TRUNC('MONTH', target_open_date)
      comment: "Target opening month, used for monthly pipeline velocity tracking."
  measures:
    - name: "total_pipeline_projects"
      expr: COUNT(nro_pipeline_id)
      comment: "Total NRO projects in the pipeline. Measures new unit development activity and growth trajectory."
    - name: "total_budget_capex"
      expr: SUM(CAST(budget_capex AS DOUBLE))
      comment: "Total budgeted capital expenditure across all NRO projects. Core capital allocation metric for finance and development leadership."
    - name: "total_actual_capex_spent"
      expr: SUM(CAST(actual_capex_spent AS DOUBLE))
      comment: "Total actual capital expenditure spent across NRO projects. Used to track capital deployment against budget."
    - name: "total_capex_variance"
      expr: SUM(CAST(actual_capex_spent AS DOUBLE) - CAST(budget_capex AS DOUBLE))
      comment: "Total capital expenditure variance (actual minus budget) across NRO projects. Negative values indicate under-spend; positive values indicate cost overruns."
    - name: "avg_expected_roi"
      expr: AVG(CAST(expected_roi AS DOUBLE))
      comment: "Average expected return on investment across NRO projects. Primary capital allocation quality metric for franchise development and finance."
    - name: "avg_expected_acuv"
      expr: AVG(CAST(expected_acuv AS DOUBLE))
      comment: "Average expected annual comparable unit volume (ACUV) across NRO projects. Used to validate new unit economic assumptions."
    - name: "avg_capital_investment_estimate"
      expr: AVG(CAST(capital_investment_estimate AS DOUBLE))
      comment: "Average capital investment estimate per NRO project. Used for financial modeling and franchisee investment guidance."
    - name: "avg_expected_cogs_percent"
      expr: AVG(CAST(expected_cogs_percent AS DOUBLE))
      comment: "Average expected cost of goods sold percentage across NRO projects. Used to validate unit economics assumptions in development approvals."
    - name: "avg_expected_labor_percent"
      expr: AVG(CAST(expected_labor_percent AS DOUBLE))
      comment: "Average expected labor cost percentage across NRO projects. Used to validate staffing model assumptions in development approvals."
    - name: "projects_with_permits_obtained_rate"
      expr: AVG(CASE WHEN permits_obtained_flag = TRUE THEN 1.0 ELSE 0.0 END)
      comment: "Proportion of NRO projects with all permits obtained. Measures development pipeline readiness and regulatory progress."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`franchise_territory`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Franchise territory metrics covering geographic coverage, economic potential, royalty rates, and assignment status. Used by franchise development and real estate teams to optimize territory allocation and identify expansion opportunities."
  source: "`vibe_restaurants_v1`.`franchise`.`territory`"
  dimensions:
    - name: "territory_status"
      expr: territory_status
      comment: "Current status of the territory (e.g. Assigned, Available, Reserved, Expired)."
    - name: "territory_type"
      expr: territory_type
      comment: "Classification of the territory (e.g. Exclusive, Protected, Open). Drives franchise development strategy."
    - name: "assignment_status"
      expr: assignment_status
      comment: "Whether the territory is currently assigned to a franchisee."
    - name: "compliance_status"
      expr: compliance_status
      comment: "Compliance status of the territory, used to flag regulatory or contractual issues."
    - name: "country_code"
      expr: country_code
      comment: "Country of the territory, used for international portfolio segmentation."
    - name: "region"
      expr: region
      comment: "Regional grouping of the territory, used for regional performance and development planning."
    - name: "trade_area_classification"
      expr: trade_area_classification
      comment: "Trade area classification (e.g. Urban, Suburban, Rural). Used for site selection and market strategy."
    - name: "dma"
      expr: dma
      comment: "Designated Market Area of the territory, used for media and marketing planning alignment."
  measures:
    - name: "total_territories"
      expr: COUNT(territory_id)
      comment: "Total number of territories in the system. Measures the geographic footprint of the franchise network."
    - name: "assigned_territory_count"
      expr: COUNT(CASE WHEN assignment_status = 'Assigned' THEN territory_id END)
      comment: "Number of territories currently assigned to franchisees. Measures territory utilization and development coverage."
    - name: "available_territory_count"
      expr: COUNT(CASE WHEN territory_status = 'Available' THEN territory_id END)
      comment: "Number of territories available for franchise development. Key pipeline metric for franchise sales teams."
    - name: "avg_territory_area_sq_miles"
      expr: AVG(CAST(area_sq_miles AS DOUBLE))
      comment: "Average territory size in square miles. Used to assess territory sizing consistency and market coverage adequacy."
    - name: "total_territory_area_sq_miles"
      expr: SUM(CAST(area_sq_miles AS DOUBLE))
      comment: "Total geographic area covered by all territories. Measures the physical footprint of the franchise system."
    - name: "avg_median_income"
      expr: AVG(CAST(median_income AS DOUBLE))
      comment: "Average median household income across territories. Used to assess the economic quality of the territory portfolio for revenue potential."
    - name: "avg_average_unit_volume"
      expr: AVG(CAST(average_unit_volume AS DOUBLE))
      comment: "Average unit volume (AUV) across territories. Used to benchmark territory economic performance and prioritize development."
    - name: "avg_royalty_rate"
      expr: AVG(CAST(royalty_rate AS DOUBLE))
      comment: "Average royalty rate across territories. Tracks rate consistency and identifies geographic pricing variations."
    - name: "avg_franchise_fee"
      expr: AVG(CAST(franchise_fee AS DOUBLE))
      comment: "Average franchise fee across territories. Used to assess fee structure consistency and competitive positioning."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`franchise_renewal_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Franchise agreement renewal event metrics covering renewal economics, compliance, and pipeline timing. Used by franchise development and legal teams to manage the renewal cycle, protect royalty revenue continuity, and ensure FTC compliance."
  source: "`vibe_restaurants_v1`.`franchise`.`renewal_event`"
  dimensions:
    - name: "renewal_event_status"
      expr: renewal_event_status
      comment: "Current status of the renewal event (e.g. Pending, Executed, Declined, Expired)."
    - name: "compliance_review_flag"
      expr: compliance_review_flag
      comment: "Whether a compliance review was required as part of the renewal process."
    - name: "ftc_compliance_attestation_flag"
      expr: ftc_compliance_attestation_flag
      comment: "Whether FTC compliance was attested during the renewal event."
    - name: "renewal_fee_paid_flag"
      expr: renewal_fee_paid_flag
      comment: "Whether the renewal fee has been paid. Used to track financial completion of the renewal process."
    - name: "renewal_term_years"
      expr: renewal_term_years
      comment: "Term length of the renewed agreement in years. Used to analyze renewal term trends and franchisee commitment levels."
    - name: "renewal_fee_currency"
      expr: renewal_fee_currency
      comment: "Currency of the renewal fee, used for multi-currency financial reporting."
    - name: "effective_from_year"
      expr: DATE_TRUNC('YEAR', effective_from)
      comment: "Year the renewed agreement becomes effective, used for renewal cohort analysis."
  measures:
    - name: "total_renewal_events"
      expr: COUNT(renewal_event_id)
      comment: "Total number of renewal events processed. Measures renewal program activity and pipeline volume."
    - name: "executed_renewal_count"
      expr: COUNT(CASE WHEN renewal_event_status = 'Executed' THEN renewal_event_id END)
      comment: "Number of successfully executed renewals. Measures franchise retention and system continuity."
    - name: "renewal_execution_rate"
      expr: AVG(CASE WHEN renewal_event_status = 'Executed' THEN 1.0 ELSE 0.0 END)
      comment: "Proportion of renewal events that result in executed agreements. Key franchise retention KPI for development and executive leadership."
    - name: "total_renewal_fee_revenue"
      expr: SUM(CAST(renewal_fee_amount AS DOUBLE))
      comment: "Total renewal fees collected across all renewal events. Measures recurring fee revenue from the renewal cycle."
    - name: "avg_renewal_fee_amount"
      expr: AVG(CAST(renewal_fee_amount AS DOUBLE))
      comment: "Average renewal fee per event. Used to benchmark fee levels and identify negotiated exceptions."
    - name: "avg_updated_royalty_rate"
      expr: AVG(CAST(updated_royalty_rate_percent AS DOUBLE))
      comment: "Average royalty rate set at renewal. Tracks rate evolution across the renewal cycle and informs pricing strategy."
    - name: "renewal_fee_paid_rate"
      expr: AVG(CASE WHEN renewal_fee_paid_flag = TRUE THEN 1.0 ELSE 0.0 END)
      comment: "Proportion of renewal events where the fee has been paid. Financial completion metric for the renewal billing cycle."
    - name: "ftc_attestation_compliance_rate"
      expr: AVG(CASE WHEN ftc_compliance_attestation_flag = TRUE THEN 1.0 ELSE 0.0 END)
      comment: "Proportion of renewal events with FTC compliance attestation completed. Regulatory compliance metric for legal and franchise development teams."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`franchise_termination_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Franchise termination event metrics covering termination economics, legal risk, and compliance. Used by franchise operations, legal, and executive leadership to monitor franchise attrition, outstanding obligations, and legal exposure."
  source: "`vibe_restaurants_v1`.`franchise`.`termination_event`"
  dimensions:
    - name: "termination_event_status"
      expr: termination_event_status
      comment: "Current status of the termination event (e.g. Initiated, Effective, Disputed, Withdrawn)."
    - name: "termination_type"
      expr: termination_type
      comment: "Classification of the termination (e.g. Voluntary, Involuntary, Expiration, Mutual Agreement)."
    - name: "termination_reason"
      expr: termination_reason
      comment: "Primary reason for the termination. Used to identify systemic issues driving franchise attrition."
    - name: "compliance_status"
      expr: compliance_status
      comment: "Compliance status at the time of termination."
    - name: "legal_dispute_flag"
      expr: legal_dispute_flag
      comment: "Whether the termination involves a legal dispute. Used to quantify legal risk exposure in the termination portfolio."
    - name: "ftc_compliance_attestation_flag"
      expr: ftc_compliance_attestation_flag
      comment: "Whether FTC compliance was attested during the termination process."
    - name: "termination_notice_method"
      expr: termination_notice_method
      comment: "Method used to deliver termination notice (e.g. Certified Mail, Email, In-Person)."
    - name: "effective_termination_year"
      expr: DATE_TRUNC('YEAR', effective_termination_date)
      comment: "Year the termination became effective, used for annual attrition trend analysis."
  measures:
    - name: "total_termination_events"
      expr: COUNT(termination_event_id)
      comment: "Total number of franchise termination events. Measures franchise attrition volume and system health."
    - name: "total_outstanding_royalty_balance"
      expr: SUM(CAST(outstanding_royalty_balance AS DOUBLE))
      comment: "Total outstanding royalty balances at termination. Measures uncollected royalty revenue exposure from terminated franchisees."
    - name: "avg_outstanding_royalty_balance"
      expr: AVG(CAST(outstanding_royalty_balance AS DOUBLE))
      comment: "Average outstanding royalty balance per termination event. Used to assess typical financial exposure per termination."
    - name: "total_termination_fee_revenue"
      expr: SUM(CAST(termination_fee_amount AS DOUBLE))
      comment: "Total termination fees collected. Measures fee recovery from terminated franchise agreements."
    - name: "legal_dispute_rate"
      expr: AVG(CASE WHEN legal_dispute_flag = TRUE THEN 1.0 ELSE 0.0 END)
      comment: "Proportion of termination events involving a legal dispute. Legal risk KPI monitored by franchise legal and executive teams."
    - name: "disputed_termination_count"
      expr: COUNT(CASE WHEN legal_dispute_flag = TRUE THEN termination_event_id END)
      comment: "Number of terminations with active legal disputes. Drives legal resource allocation and risk reserve decisions."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`franchise_support_visit`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Franchise field support visit metrics covering visit frequency, compliance outcomes, training activity, and expense efficiency. Used by franchise operations leadership to measure field support effectiveness and franchisee engagement."
  source: "`vibe_restaurants_v1`.`franchise`.`support_visit`"
  dimensions:
    - name: "visit_type"
      expr: visit_type
      comment: "Type of support visit (e.g. Operational, Training, Compliance, Follow-Up)."
    - name: "support_visit_status"
      expr: support_visit_status
      comment: "Current status of the support visit (e.g. Scheduled, Completed, Cancelled)."
    - name: "is_training_visit"
      expr: is_training_visit
      comment: "Whether the visit was classified as a training visit."
    - name: "compliance_flag"
      expr: compliance_flag
      comment: "Whether the visit identified a compliance issue."
    - name: "follow_up_required"
      expr: follow_up_required
      comment: "Whether a follow-up visit was required after this support visit."
    - name: "equipment_inspected_flag"
      expr: equipment_inspected_flag
      comment: "Whether equipment was inspected during the visit."
    - name: "country_code"
      expr: country_code
      comment: "Country where the support visit occurred, used for geographic analysis."
    - name: "region"
      expr: region
      comment: "Region where the support visit occurred, used for regional field support coverage analysis."
    - name: "visit_month"
      expr: DATE_TRUNC('MONTH', visit_timestamp)
      comment: "Month the support visit occurred, used for visit frequency trend analysis."
  measures:
    - name: "total_support_visits"
      expr: COUNT(support_visit_id)
      comment: "Total number of field support visits conducted. Measures field support program activity and franchisee engagement coverage."
    - name: "avg_compliance_score"
      expr: AVG(CAST(compliance_score AS DOUBLE))
      comment: "Average compliance score recorded during support visits. Tracks operational standards adherence across the franchisee network."
    - name: "compliance_issue_rate"
      expr: AVG(CASE WHEN compliance_flag = TRUE THEN 1.0 ELSE 0.0 END)
      comment: "Proportion of support visits that identified a compliance issue. Measures the prevalence of operational problems in the field."
    - name: "follow_up_required_rate"
      expr: AVG(CASE WHEN follow_up_required = TRUE THEN 1.0 ELSE 0.0 END)
      comment: "Proportion of support visits requiring a follow-up. High rates indicate persistent operational issues requiring additional intervention."
    - name: "total_visit_expense"
      expr: SUM(CAST(expense_amount AS DOUBLE))
      comment: "Total expense incurred for field support visits. Used to manage field operations budget and cost-per-visit efficiency."
    - name: "avg_visit_expense"
      expr: AVG(CAST(expense_amount AS DOUBLE))
      comment: "Average expense per support visit. Used to benchmark field support cost efficiency across regions and consultants."
    - name: "avg_sales_impact_estimate"
      expr: AVG(CAST(sales_impact_estimate AS DOUBLE))
      comment: "Average estimated sales impact from support visits. Used to quantify the ROI of the field support program."
    - name: "avg_waste_percentage"
      expr: AVG(CAST(waste_percentage AS DOUBLE))
      comment: "Average waste percentage observed during support visits. Operational efficiency metric tied to food cost and profitability."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`franchise_training_enrollment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Franchise training enrollment metrics covering completion rates, certification outcomes, and training hours. Used by franchise operations and HR to ensure franchisee network readiness, brand standards compliance, and regulatory certification currency."
  source: "`vibe_restaurants_v1`.`franchise`.`training_enrollment`"
  dimensions:
    - name: "training_type"
      expr: training_type
      comment: "Type of training program (e.g. Initial, Refresher, Food Safety, Brand Standards)."
    - name: "training_enrollment_status"
      expr: training_enrollment_status
      comment: "Current status of the training enrollment (e.g. Enrolled, In Progress, Completed, Failed)."
    - name: "pass_fail_status"
      expr: pass_fail_status
      comment: "Pass or fail outcome of the training. Used to identify trainees requiring remediation."
    - name: "certification_issued"
      expr: certification_issued
      comment: "Whether a certification was issued upon completion of the training."
    - name: "compliance_flag"
      expr: compliance_flag
      comment: "Whether the enrollment has a compliance issue (e.g. overdue, expired certification)."
    - name: "enrollment_year"
      expr: DATE_TRUNC('YEAR', actual_completion_date)
      comment: "Year of training completion, used for annual training program performance reporting."
    - name: "certification_expiration_year"
      expr: DATE_TRUNC('YEAR', certification_expiration_date)
      comment: "Year certifications expire, used to plan recertification campaigns."
  measures:
    - name: "total_enrollments"
      expr: COUNT(training_enrollment_id)
      comment: "Total number of training enrollments. Measures training program scale and franchisee network investment in capability development."
    - name: "certification_issuance_rate"
      expr: AVG(CASE WHEN certification_issued = TRUE THEN 1.0 ELSE 0.0 END)
      comment: "Proportion of enrollments resulting in certification issuance. Measures training program effectiveness and franchisee qualification rates."
    - name: "pass_rate"
      expr: AVG(CASE WHEN pass_fail_status = 'Pass' THEN 1.0 ELSE 0.0 END)
      comment: "Proportion of training enrollments with a passing outcome. Key training quality metric for franchise operations and HR leadership."
    - name: "avg_training_score"
      expr: AVG(CAST(score AS DOUBLE))
      comment: "Average training assessment score across all enrollments. Measures knowledge acquisition quality across the franchisee network."
    - name: "total_hours_completed"
      expr: SUM(CAST(hours_completed AS DOUBLE))
      comment: "Total training hours completed across all enrollments. Measures the investment in franchisee capability development."
    - name: "avg_hours_completed"
      expr: AVG(CAST(hours_completed AS DOUBLE))
      comment: "Average training hours completed per enrollment. Used to assess training program depth and completion quality."
    - name: "training_hours_completion_rate"
      expr: AVG(CAST(hours_completed AS DOUBLE) / NULLIF(CAST(hours_required AS DOUBLE), 0))
      comment: "Average ratio of hours completed to hours required per enrollment. Measures training program completion depth across the franchisee network."
    - name: "certifications_expiring_within_90_days"
      expr: COUNT(CASE WHEN certification_expiration_date BETWEEN CURRENT_DATE AND DATE_ADD(CURRENT_DATE, 90) THEN training_enrollment_id END)
      comment: "Number of certifications expiring within 90 days. Drives proactive recertification outreach to maintain compliance."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`franchise_prospect`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Franchise prospect pipeline metrics covering application conversion, financial qualification, and pipeline velocity. Used by franchise development and sales leadership to manage the new franchisee acquisition funnel and forecast system growth."
  source: "`vibe_restaurants_v1`.`franchise`.`prospect`"
  dimensions:
    - name: "prospect_status"
      expr: prospect_status
      comment: "Current status of the prospect in the franchise sales process (e.g. Lead, Qualified, Application Submitted, Approved, Declined)."
    - name: "pipeline_stage"
      expr: pipeline_stage
      comment: "Current stage of the prospect in the development pipeline. Used for funnel conversion analysis."
    - name: "application_status"
      expr: application_status
      comment: "Status of the franchise application submitted by the prospect."
    - name: "background_check_status"
      expr: background_check_status
      comment: "Status of the background check for the prospect. Used to track qualification progress."
    - name: "source_channel"
      expr: source_channel
      comment: "Marketing or referral channel that generated the prospect lead. Used for lead source ROI analysis."
    - name: "franchise_type_preference"
      expr: franchise_type_preference
      comment: "Prospect's preferred franchise format (e.g. Single-Unit, Multi-Unit). Used for development pipeline segmentation."
    - name: "country_code"
      expr: country_code
      comment: "Country of the prospect, used for geographic pipeline analysis."
    - name: "fdd_sent_flag"
      expr: fdd_sent_flag
      comment: "Whether the FDD has been sent to the prospect. Tracks regulatory disclosure compliance in the sales process."
    - name: "discovery_day_attended"
      expr: discovery_day_attended
      comment: "Whether the prospect attended a Discovery Day event. Strong predictor of conversion to signed agreement."
    - name: "application_submitted_year"
      expr: DATE_TRUNC('YEAR', application_submitted_date)
      comment: "Year the application was submitted, used for annual franchise sales volume trending."
  measures:
    - name: "total_prospects"
      expr: COUNT(prospect_id)
      comment: "Total number of prospects in the franchise development pipeline. Measures top-of-funnel lead volume for franchise sales."
    - name: "qualified_prospect_count"
      expr: COUNT(CASE WHEN prospect_status = 'Qualified' THEN prospect_id END)
      comment: "Number of prospects that have passed initial qualification. Measures mid-funnel pipeline health for franchise development."
    - name: "application_submitted_count"
      expr: COUNT(CASE WHEN application_status IS NOT NULL AND application_status != '' THEN prospect_id END)
      comment: "Number of prospects who have submitted a franchise application. Measures conversion from lead to formal applicant."
    - name: "discovery_day_attendance_rate"
      expr: AVG(CASE WHEN discovery_day_attended = TRUE THEN 1.0 ELSE 0.0 END)
      comment: "Proportion of prospects who attended a Discovery Day. High attendance rates correlate with higher conversion to signed agreements."
    - name: "fdd_sent_rate"
      expr: AVG(CASE WHEN fdd_sent_flag = TRUE THEN 1.0 ELSE 0.0 END)
      comment: "Proportion of prospects who have received the FDD. Regulatory compliance metric for the franchise sales process."
    - name: "avg_estimated_initial_investment"
      expr: AVG(CAST(estimated_initial_investment AS DOUBLE))
      comment: "Average estimated initial investment across prospects. Used to assess the financial scale of the incoming franchisee cohort."
    - name: "avg_liquid_capital"
      expr: AVG(CAST(liquid_capital_amount AS DOUBLE))
      comment: "Average liquid capital available across prospects. Used to assess financial qualification quality of the prospect pipeline."
    - name: "avg_net_worth"
      expr: AVG(CAST(net_worth_amount AS DOUBLE))
      comment: "Average net worth across prospects. Used to assess the financial strength of the incoming franchisee pipeline."
$$;