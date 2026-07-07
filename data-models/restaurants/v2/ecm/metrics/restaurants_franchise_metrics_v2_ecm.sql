-- Metric views for domain: franchise | Business: Restaurants | Version: 2 | Generated on: 2026-07-02 03:10:25

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`franchise_billing`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Franchise billing and fee collection metrics — tracks royalty revenue, marketing fund contributions, technology fees, outstanding balances, and payment compliance across franchisees and billing periods."
  source: "`vibe_restaurants_v1`.`franchise`.`billing`"
  dimensions:
    - name: "billing_type"
      expr: billing_type
      comment: "Type of billing record (royalty, marketing fee, technology fee, etc.) for fee-category analysis."
    - name: "billing_status"
      expr: billing_status
      comment: "Current status of the billing record (open, paid, overdue) for AR aging analysis."
    - name: "payment_status"
      expr: payment_status
      comment: "Payment status of the billing record to identify delinquent franchisees."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the billing record for multi-currency franchise networks."
    - name: "billing_period"
      expr: period
      comment: "Reporting period (e.g., 2024-Q1) for trend analysis of fee collections."
    - name: "billing_period_start"
      expr: DATE_TRUNC('month', period_start)
      comment: "Month bucket of the billing period start date for time-series trending."
    - name: "is_paid"
      expr: is_paid
      comment: "Boolean flag indicating whether the billing record has been fully paid."
  measures:
    - name: "total_royalty_billed"
      expr: SUM(CAST(royalty_amount AS DOUBLE))
      comment: "Total royalty fees billed across all franchisees — primary revenue line for the franchisor P&L."
    - name: "total_marketing_fee_billed"
      expr: SUM(CAST(marketing_fee_amount AS DOUBLE))
      comment: "Total marketing fund contributions billed — funds brand advertising and promotional programs."
    - name: "total_technology_fee_billed"
      expr: SUM(CAST(technology_fee_amount AS DOUBLE))
      comment: "Total technology fees billed — covers POS, digital, and platform infrastructure costs."
    - name: "total_amount_billed"
      expr: SUM(CAST(total_amount AS DOUBLE))
      comment: "Total gross amount billed across all fee types — top-line franchise revenue indicator."
    - name: "total_amount_collected"
      expr: SUM(CAST(amount_paid AS DOUBLE))
      comment: "Total amount actually collected from franchisees — cash-in measure for treasury management."
    - name: "total_outstanding_balance"
      expr: SUM(CAST(balance_outstanding AS DOUBLE))
      comment: "Total unpaid balance outstanding across all franchisees — AR exposure and collection risk indicator."
    - name: "billing_record_count"
      expr: COUNT(1)
      comment: "Number of billing records in the period — volume indicator for billing operations."
    - name: "paid_billing_count"
      expr: COUNT(CASE WHEN is_paid = TRUE THEN 1 END)
      comment: "Number of billing records that have been fully paid — payment compliance numerator."
    - name: "payment_compliance_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_paid = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of billing records paid on time — key franchisee financial health and compliance KPI."
    - name: "avg_outstanding_balance_per_record"
      expr: AVG(CAST(balance_outstanding AS DOUBLE))
      comment: "Average outstanding balance per billing record — signals systemic collection issues when elevated."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`franchise_sales_report`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Franchisee sales performance metrics — tracks gross and net sales, royalty obligations, transaction volumes, and same-store sales growth across reporting periods and units."
  source: "`vibe_restaurants_v1`.`franchise`.`sales_report`"
  dimensions:
    - name: "reporting_period_type"
      expr: reporting_period_type
      comment: "Granularity of the sales report (daily, weekly, monthly) for period-over-period analysis."
    - name: "sales_report_status"
      expr: sales_report_status
      comment: "Status of the sales report (submitted, validated, rejected) for data quality monitoring."
    - name: "validation_status"
      expr: validation_status
      comment: "Validation outcome of the submitted sales report — flags discrepancies requiring follow-up."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the sales report for multi-currency franchise network analysis."
    - name: "submission_method"
      expr: submission_method
      comment: "How the report was submitted (portal, EDI, manual) for process compliance tracking."
    - name: "reporting_period_start_month"
      expr: DATE_TRUNC('month', reporting_period_start)
      comment: "Month bucket of the reporting period start for time-series sales trending."
    - name: "variance_flag"
      expr: variance_flag
      comment: "Boolean flag indicating a material variance between reported and expected sales."
  measures:
    - name: "total_gross_sales"
      expr: SUM(CAST(gross_sales_amount AS DOUBLE))
      comment: "Total gross sales across all franchisee reports — top-line system-wide revenue indicator."
    - name: "total_net_sales"
      expr: SUM(CAST(net_sales_amount AS DOUBLE))
      comment: "Total net sales after adjustments — basis for royalty and marketing fee calculations."
    - name: "total_royalty_earned"
      expr: SUM(CAST(royalty_amount AS DOUBLE))
      comment: "Total royalty fees earned by the franchisor based on reported sales — P&L revenue line."
    - name: "total_transaction_count"
      expr: SUM(CAST(transaction_count AS DOUBLE))
      comment: "Total guest transactions across all franchisee reports — traffic volume indicator."
    - name: "avg_check_value"
      expr: AVG(CAST(average_check_value AS DOUBLE))
      comment: "Average check value per sales report — proxy for per-visit spend and menu mix effectiveness."
    - name: "total_sales_adjustments"
      expr: SUM(CAST(adjustments_amount AS DOUBLE))
      comment: "Total sales adjustments applied — large values signal reporting disputes or corrections."
    - name: "total_variance_amount"
      expr: SUM(CAST(variance_amount AS DOUBLE))
      comment: "Total variance between reported and expected sales — audit risk and data integrity indicator."
    - name: "avg_same_store_sales"
      expr: AVG(CAST(same_store_sales AS DOUBLE))
      comment: "Average same-store sales across reporting units — core comparable-sales growth KPI."
    - name: "report_count"
      expr: COUNT(1)
      comment: "Number of sales reports submitted — reporting compliance volume indicator."
    - name: "variance_report_count"
      expr: COUNT(CASE WHEN variance_flag = TRUE THEN 1 END)
      comment: "Number of reports with material variances flagged — audit and compliance risk signal."
    - name: "variance_report_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN variance_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of sales reports with material variances — data quality and franchisee compliance KPI."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`franchise_compliance_audit`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Franchise compliance audit performance metrics — tracks audit scores across brand standards, food safety, cleanliness, and service dimensions to identify at-risk franchisees and systemic compliance gaps."
  source: "`vibe_restaurants_v1`.`franchise`.`compliance_audit`"
  dimensions:
    - name: "audit_type"
      expr: audit_type
      comment: "Type of compliance audit (announced, unannounced, follow-up) for audit program analysis."
    - name: "compliance_audit_status"
      expr: compliance_audit_status
      comment: "Current status of the audit (open, closed, pending review) for workflow management."
    - name: "audit_disposition"
      expr: audit_disposition
      comment: "Final disposition of the audit (pass, fail, conditional pass) — primary compliance outcome."
    - name: "corrective_action_required"
      expr: corrective_action_required
      comment: "Boolean flag indicating whether a corrective action plan was required — risk escalation indicator."
    - name: "audit_month"
      expr: DATE_TRUNC('month', audit_timestamp)
      comment: "Month of the audit for trend analysis of compliance scores over time."
    - name: "audit_location_code"
      expr: audit_location_code
      comment: "Location code of the audited unit for geographic compliance analysis."
  measures:
    - name: "avg_overall_score"
      expr: AVG(CAST(overall_score AS DOUBLE))
      comment: "Average overall compliance audit score — primary KPI for franchise system health and brand protection."
    - name: "avg_food_safety_score"
      expr: AVG(CAST(food_safety_score AS DOUBLE))
      comment: "Average food safety score across audits — critical risk metric tied to regulatory and liability exposure."
    - name: "avg_brand_standards_score"
      expr: AVG(CAST(brand_standards_score AS DOUBLE))
      comment: "Average brand standards score — measures franchisee adherence to brand identity and guest experience requirements."
    - name: "avg_cleanliness_score"
      expr: AVG(CAST(cleanliness_score AS DOUBLE))
      comment: "Average cleanliness score — directly linked to guest satisfaction and health inspection outcomes."
    - name: "avg_service_score"
      expr: AVG(CAST(service_score AS DOUBLE))
      comment: "Average service score — measures franchisee team performance against guest experience standards."
    - name: "avg_equipment_score"
      expr: AVG(CAST(equipment_score AS DOUBLE))
      comment: "Average equipment score — signals capital investment needs and operational readiness."
    - name: "audit_count"
      expr: COUNT(1)
      comment: "Total number of compliance audits conducted — audit program coverage indicator."
    - name: "corrective_action_required_count"
      expr: COUNT(CASE WHEN corrective_action_required = TRUE THEN 1 END)
      comment: "Number of audits requiring corrective action — franchise risk portfolio size."
    - name: "corrective_action_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN corrective_action_required = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of audits resulting in corrective action requirements — system-wide compliance risk rate."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`franchise_performance_scorecard`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Franchisee performance scorecard metrics — aggregates multi-dimensional KPIs including sales growth, royalty timeliness, food safety, customer satisfaction, and training completion to rank and tier franchisees."
  source: "`vibe_restaurants_v1`.`franchise`.`performance_scorecard`"
  dimensions:
    - name: "evaluation_type"
      expr: evaluation_type
      comment: "Type of evaluation (quarterly, annual, ad-hoc) for period-appropriate benchmarking."
    - name: "evaluation_status"
      expr: evaluation_status
      comment: "Status of the scorecard evaluation (draft, finalized, disputed) for data completeness filtering."
    - name: "overall_performance_tier"
      expr: overall_performance_tier
      comment: "Performance tier assigned to the franchisee (Gold, Silver, Bronze, At-Risk) — primary franchisee ranking dimension."
    - name: "region_code"
      expr: region_code
      comment: "Geographic region of the franchisee for regional performance benchmarking."
    - name: "evaluation_period_start_month"
      expr: DATE_TRUNC('month', evaluation_period_start)
      comment: "Month bucket of the evaluation period start for longitudinal performance trending."
    - name: "evaluation_year"
      expr: evaluation_year
      comment: "Year of the evaluation for annual performance cycle analysis."
  measures:
    - name: "avg_same_store_sales_growth_pct"
      expr: AVG(CAST(same_store_sales_growth_pct AS DOUBLE))
      comment: "Average same-store sales growth percentage — primary top-line growth KPI for franchise system health."
    - name: "avg_royalty_payment_timeliness_pct"
      expr: AVG(CAST(royalty_payment_timeliness_pct AS DOUBLE))
      comment: "Average royalty payment timeliness percentage — measures franchisee financial discipline and cash flow reliability."
    - name: "avg_customer_satisfaction_score"
      expr: AVG(CAST(customer_satisfaction_score AS DOUBLE))
      comment: "Average customer satisfaction score across franchisees — guest experience quality indicator."
    - name: "avg_food_safety_score"
      expr: AVG(CAST(food_safety_score AS DOUBLE))
      comment: "Average food safety score from scorecards — regulatory compliance and brand risk indicator."
    - name: "avg_training_completion_rate_pct"
      expr: AVG(CAST(training_completion_rate_pct AS DOUBLE))
      comment: "Average training completion rate — workforce readiness and brand standards adherence indicator."
    - name: "avg_net_promoter_score"
      expr: AVG(CAST(net_promoter_score AS DOUBLE))
      comment: "Average Net Promoter Score across franchisees — guest loyalty and brand advocacy measure."
    - name: "avg_compliance_audit_score"
      expr: AVG(CAST(compliance_audit_average_score AS DOUBLE))
      comment: "Average compliance audit score from scorecards — brand standards and regulatory adherence KPI."
    - name: "total_royalty_collected"
      expr: SUM(CAST(total_royalty_amount AS DOUBLE))
      comment: "Total royalty amounts collected as reported in scorecards — franchisor revenue confirmation."
    - name: "total_system_sales"
      expr: SUM(CAST(total_sales_amount AS DOUBLE))
      comment: "Total system-wide sales across all evaluated franchisees — system AUV and scale indicator."
    - name: "avg_average_unit_volume"
      expr: AVG(CAST(average_unit_volume AS DOUBLE))
      comment: "Average unit volume (AUV) across franchisees — benchmark for franchisee economic viability."
    - name: "franchisee_scorecard_count"
      expr: COUNT(1)
      comment: "Number of franchisee scorecards evaluated — coverage of the performance management program."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`franchise_agreement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Franchise agreement portfolio metrics — tracks agreement status, royalty rates, marketing fees, renewal timelines, and compliance attestations to manage the franchise contract lifecycle."
  source: "`vibe_restaurants_v1`.`franchise`.`agreement`"
  dimensions:
    - name: "agreement_status"
      expr: agreement_status
      comment: "Current status of the franchise agreement (active, expired, terminated, pending renewal)."
    - name: "agreement_type"
      expr: agreement_type
      comment: "Type of franchise agreement (single-unit, multi-unit, area development) for portfolio segmentation."
    - name: "compliance_status"
      expr: compliance_status
      comment: "Compliance status of the agreement — identifies agreements with outstanding compliance obligations."
    - name: "ftc_compliance_attestation_flag"
      expr: ftc_compliance_attestation_flag
      comment: "Boolean flag indicating FTC compliance attestation has been received — regulatory risk indicator."
    - name: "transfer_rights_flag"
      expr: transfer_rights_flag
      comment: "Boolean flag indicating whether the agreement includes transfer rights — portfolio flexibility indicator."
    - name: "effective_start_year"
      expr: DATE_TRUNC('year', effective_start_date)
      comment: "Year the agreement became effective for cohort analysis of franchise vintages."
    - name: "contract_version"
      expr: contract_version
      comment: "Version of the franchise contract — tracks modernization of agreement terms across the portfolio."
  measures:
    - name: "active_agreement_count"
      expr: COUNT(CASE WHEN agreement_status = 'active' THEN 1 END)
      comment: "Number of currently active franchise agreements — size of the active franchise portfolio."
    - name: "total_agreement_count"
      expr: COUNT(1)
      comment: "Total number of franchise agreements across all statuses — portfolio size indicator."
    - name: "avg_royalty_rate_percent"
      expr: AVG(CAST(royalty_rate_percent AS DOUBLE))
      comment: "Average royalty rate across agreements — benchmark for fee structure competitiveness and revenue yield."
    - name: "avg_marketing_fee_percent"
      expr: AVG(CAST(marketing_fee_percent AS DOUBLE))
      comment: "Average marketing fee percentage across agreements — marketing fund contribution rate benchmark."
    - name: "total_initial_fees"
      expr: SUM(CAST(initial_fee_amount AS DOUBLE))
      comment: "Total initial franchise fees collected — new unit development revenue indicator."
    - name: "total_renewal_fees"
      expr: SUM(CAST(renewal_fee_amount AS DOUBLE))
      comment: "Total renewal fees collected — franchise system retention and renewal revenue."
    - name: "avg_sales_target"
      expr: AVG(CAST(sales_target_amount AS DOUBLE))
      comment: "Average sales target set in agreements — benchmark for franchisee performance expectations."
    - name: "avg_average_unit_volume"
      expr: AVG(CAST(average_unit_volume AS DOUBLE))
      comment: "Average unit volume embedded in agreements — economic viability benchmark for the franchise system."
    - name: "ftc_compliant_agreement_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN ftc_compliance_attestation_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of agreements with FTC compliance attestation — regulatory risk management KPI."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`franchise_fee_schedule`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Franchise fee schedule metrics — analyzes fee structures, rates, and amounts across fee types to ensure competitive positioning and consistent application of royalty, marketing, and technology fees."
  source: "`vibe_restaurants_v1`.`franchise`.`fee_schedule`"
  dimensions:
    - name: "fee_type"
      expr: fee_type
      comment: "Type of fee (royalty, marketing, technology, initial, renewal) for fee structure analysis."
    - name: "fee_name"
      expr: fee_name
      comment: "Name of the specific fee for granular fee schedule reporting."
    - name: "calculation_method"
      expr: calculation_method
      comment: "Method used to calculate the fee (percentage of sales, flat rate, tiered) for structure analysis."
    - name: "frequency"
      expr: frequency
      comment: "Billing frequency of the fee (weekly, monthly, annual) for cash flow planning."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the fee schedule for multi-currency franchise network analysis."
    - name: "is_active"
      expr: is_active
      comment: "Boolean flag indicating whether the fee schedule is currently active."
    - name: "effective_start_month"
      expr: DATE_TRUNC('month', effective_start_date)
      comment: "Month the fee schedule became effective for tracking fee structure changes over time."
  measures:
    - name: "avg_royalty_rate_pct"
      expr: AVG(CAST(royalty_rate_pct AS DOUBLE))
      comment: "Average royalty rate percentage across fee schedules — benchmark for system-wide royalty burden."
    - name: "avg_marketing_fee_rate_pct"
      expr: AVG(CAST(marketing_fee_rate_pct AS DOUBLE))
      comment: "Average marketing fee rate percentage — marketing fund contribution rate benchmark."
    - name: "avg_fee_amount"
      expr: AVG(CAST(fee_amount AS DOUBLE))
      comment: "Average fee amount across all fee schedule records — fee level benchmarking."
    - name: "avg_minimum_fee_amount"
      expr: AVG(CAST(minimum_fee_amount AS DOUBLE))
      comment: "Average minimum fee floor — ensures franchisees meet minimum contribution thresholds."
    - name: "avg_technology_fee_amount"
      expr: AVG(CAST(technology_fee_amount AS DOUBLE))
      comment: "Average technology fee amount — tracks technology cost recovery across the franchise system."
    - name: "active_fee_schedule_count"
      expr: COUNT(CASE WHEN is_active = TRUE THEN 1 END)
      comment: "Number of currently active fee schedules — portfolio of active fee structures."
    - name: "total_fee_schedule_count"
      expr: COUNT(1)
      comment: "Total number of fee schedule records — fee structure complexity indicator."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`franchise_corrective_action`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Franchise corrective action metrics — tracks resolution rates, severity distribution, and cycle times for compliance corrective actions to manage franchisee risk and brand protection."
  source: "`vibe_restaurants_v1`.`franchise`.`franchise_corrective_action`"
  dimensions:
    - name: "franchise_corrective_action_status"
      expr: franchise_corrective_action_status
      comment: "Current status of the corrective action (open, in-progress, closed, overdue) for workflow management."
    - name: "severity"
      expr: severity
      comment: "Severity level of the corrective action (critical, major, minor) for risk prioritization."
    - name: "issue_category"
      expr: issue_category
      comment: "Category of the compliance issue (food safety, brand standards, financial) for root cause analysis."
    - name: "is_resolved"
      expr: is_resolved
      comment: "Boolean flag indicating whether the corrective action has been resolved."
    - name: "is_closed"
      expr: is_closed
      comment: "Boolean flag indicating whether the corrective action has been formally closed."
    - name: "issued_month"
      expr: DATE_TRUNC('month', issued_date)
      comment: "Month the corrective action was issued for trend analysis of compliance incidents."
    - name: "responsible_party"
      expr: responsible_party
      comment: "Party responsible for resolving the corrective action for accountability tracking."
  measures:
    - name: "total_corrective_action_count"
      expr: COUNT(1)
      comment: "Total number of corrective actions issued — franchise compliance risk volume indicator."
    - name: "open_corrective_action_count"
      expr: COUNT(CASE WHEN is_closed = FALSE OR is_closed IS NULL THEN 1 END)
      comment: "Number of open corrective actions — active compliance risk exposure for the franchise system."
    - name: "resolved_corrective_action_count"
      expr: COUNT(CASE WHEN is_resolved = TRUE THEN 1 END)
      comment: "Number of resolved corrective actions — remediation effectiveness indicator."
    - name: "resolution_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_resolved = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of corrective actions resolved — franchise compliance remediation effectiveness KPI."
    - name: "critical_corrective_action_count"
      expr: COUNT(CASE WHEN severity = 'critical' THEN 1 END)
      comment: "Number of critical-severity corrective actions — highest-risk compliance issues requiring immediate escalation."
    - name: "critical_corrective_action_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN severity = 'critical' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of corrective actions classified as critical severity — franchise risk concentration indicator."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`franchise_nro_pipeline`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "New restaurant opening (NRO) pipeline metrics — tracks development progress, capital investment, milestone completion, and opening timelines to manage franchise system growth."
  source: "`vibe_restaurants_v1`.`franchise`.`nro_pipeline`"
  dimensions:
    - name: "project_status"
      expr: project_status
      comment: "Current status of the NRO project (site selection, construction, training, open) for pipeline stage analysis."
    - name: "stage"
      expr: stage
      comment: "Development stage of the NRO project for funnel conversion analysis."
    - name: "development_type"
      expr: development_type
      comment: "Type of development (new build, conversion, relocation) for capital planning."
    - name: "risk_level"
      expr: risk_level
      comment: "Risk level assigned to the NRO project (low, medium, high) for portfolio risk management."
    - name: "compliance_status"
      expr: compliance_status
      comment: "Compliance status of the NRO project for regulatory and brand standard readiness."
    - name: "target_open_year"
      expr: DATE_TRUNC('year', target_open_date)
      comment: "Year of the target opening date for annual development pipeline planning."
    - name: "construction_complete_flag"
      expr: construction_complete_flag
      comment: "Boolean flag indicating construction completion — milestone tracking for opening readiness."
    - name: "training_complete_flag"
      expr: training_complete_flag
      comment: "Boolean flag indicating training completion — workforce readiness for opening."
  measures:
    - name: "total_nro_projects"
      expr: COUNT(1)
      comment: "Total NRO projects in the pipeline — system growth pipeline size indicator."
    - name: "total_budget_capex"
      expr: SUM(CAST(budget_capex AS DOUBLE))
      comment: "Total budgeted capital expenditure across NRO pipeline — capital commitment for growth planning."
    - name: "total_actual_capex_spent"
      expr: SUM(CAST(actual_capex_spent AS DOUBLE))
      comment: "Total actual capital expenditure spent on NRO projects — capital deployment tracking."
    - name: "avg_expected_roi"
      expr: AVG(CAST(expected_roi AS DOUBLE))
      comment: "Average expected ROI across NRO projects — investment quality and return expectation benchmark."
    - name: "avg_expected_acuv"
      expr: AVG(CAST(expected_acuv AS DOUBLE))
      comment: "Average expected annual comparable unit volume for NRO projects — revenue potential of pipeline."
    - name: "avg_health_inspection_score"
      expr: AVG(CAST(health_inspection_score AS DOUBLE))
      comment: "Average health inspection score at opening — food safety readiness of new units."
    - name: "capex_variance"
      expr: SUM((CAST(actual_capex_spent AS DOUBLE)) - (CAST(budget_capex AS DOUBLE)))
      comment: "Total capital expenditure variance (actual minus budget) across NRO projects — budget discipline indicator."
    - name: "opened_project_count"
      expr: COUNT(CASE WHEN actual_open_date IS NOT NULL THEN 1 END)
      comment: "Number of NRO projects that have successfully opened — actual system growth delivered."
    - name: "opening_conversion_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN actual_open_date IS NOT NULL THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of pipeline projects that have successfully opened — development execution effectiveness KPI."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`franchise_marketing_fund_contribution`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Marketing fund contribution metrics — tracks franchisee contributions to the brand marketing fund, collection rates, and gross sales basis to ensure adequate funding for brand advertising programs."
  source: "`vibe_restaurants_v1`.`franchise`.`marketing_fund_contribution`"
  dimensions:
    - name: "marketing_fund_contribution_status"
      expr: marketing_fund_contribution_status
      comment: "Status of the contribution record (pending, paid, overdue) for collection management."
    - name: "payment_status"
      expr: payment_status
      comment: "Payment status of the marketing fund contribution for AR tracking."
    - name: "is_paid"
      expr: is_paid
      comment: "Boolean flag indicating whether the contribution has been paid."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the contribution for multi-currency franchise network analysis."
    - name: "contribution_period"
      expr: contribution_period
      comment: "Reporting period of the contribution for trend analysis of fund inflows."
    - name: "contribution_period_start_month"
      expr: DATE_TRUNC('month', contribution_period_start)
      comment: "Month bucket of the contribution period start for time-series fund contribution trending."
  measures:
    - name: "total_contribution_amount"
      expr: SUM(CAST(contribution_amount AS DOUBLE))
      comment: "Total marketing fund contributions collected — primary marketing fund revenue indicator."
    - name: "total_gross_sales_basis"
      expr: SUM(CAST(gross_sales_basis_amount AS DOUBLE))
      comment: "Total gross sales basis used for contribution calculations — validates contribution rate application."
    - name: "avg_contribution_rate_pct"
      expr: AVG(CAST(contribution_rate_pct AS DOUBLE))
      comment: "Average contribution rate percentage — benchmark for marketing fund levy consistency."
    - name: "paid_contribution_count"
      expr: COUNT(CASE WHEN is_paid = TRUE THEN 1 END)
      comment: "Number of contributions that have been paid — collection compliance numerator."
    - name: "total_contribution_count"
      expr: COUNT(1)
      comment: "Total number of contribution records — billing volume for the marketing fund."
    - name: "contribution_payment_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_paid = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of marketing fund contributions paid — fund collection compliance KPI."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`franchise_remodel_project`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Franchise remodel project metrics — tracks budget adherence, completion rates, and cost performance for restaurant remodel projects to manage brand refresh investment and franchisee capital compliance."
  source: "`vibe_restaurants_v1`.`franchise`.`franchise_remodel_project`"
  dimensions:
    - name: "project_status"
      expr: project_status
      comment: "Current status of the remodel project (planning, in-progress, complete, on-hold) for portfolio management."
    - name: "franchise_remodel_project_status"
      expr: franchise_remodel_project_status
      comment: "Detailed status of the franchise remodel project for workflow tracking."
    - name: "remodel_type"
      expr: remodel_type
      comment: "Type of remodel (full refresh, partial, equipment-only) for capital investment categorization."
    - name: "is_complete"
      expr: is_complete
      comment: "Boolean flag indicating whether the remodel project has been completed."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the project costs for multi-currency franchise network analysis."
    - name: "planned_start_year"
      expr: DATE_TRUNC('year', planned_start_date)
      comment: "Year of the planned project start for annual remodel pipeline planning."
  measures:
    - name: "total_budget_amount"
      expr: SUM(CAST(budget_amount AS DOUBLE))
      comment: "Total budgeted cost across all remodel projects — capital commitment for brand refresh program."
    - name: "total_actual_cost"
      expr: SUM(CAST(actual_cost AS DOUBLE))
      comment: "Total actual cost incurred across remodel projects — capital deployment tracking."
    - name: "total_estimated_cost"
      expr: SUM(CAST(estimated_cost AS DOUBLE))
      comment: "Total estimated cost across remodel projects — pre-approval capital planning indicator."
    - name: "avg_percent_complete"
      expr: AVG(CAST(percent_complete AS DOUBLE))
      comment: "Average completion percentage across active remodel projects — portfolio progress indicator."
    - name: "completed_project_count"
      expr: COUNT(CASE WHEN is_complete = TRUE THEN 1 END)
      comment: "Number of completed remodel projects — brand refresh delivery indicator."
    - name: "total_project_count"
      expr: COUNT(1)
      comment: "Total number of remodel projects — brand refresh program scale."
    - name: "project_completion_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_complete = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of remodel projects completed — brand refresh execution effectiveness KPI."
    - name: "cost_overrun_amount"
      expr: SUM((CAST(actual_cost AS DOUBLE)) - (CAST(budget_amount AS DOUBLE)))
      comment: "Total cost overrun (actual minus budget) across remodel projects — capital discipline and contractor management KPI."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`franchise_training_enrollment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Franchise training enrollment metrics — tracks training completion rates, certification outcomes, and hours delivered to ensure franchisee workforce readiness and brand standards compliance."
  source: "`vibe_restaurants_v1`.`franchise`.`training_enrollment`"
  dimensions:
    - name: "training_enrollment_status"
      expr: training_enrollment_status
      comment: "Current status of the training enrollment (enrolled, in-progress, completed, failed) for program management."
    - name: "training_type"
      expr: training_type
      comment: "Type of training (initial, refresher, certification, food safety) for program mix analysis."
    - name: "pass_fail_status"
      expr: pass_fail_status
      comment: "Pass/fail outcome of the training — workforce competency indicator."
    - name: "certification_issued"
      expr: certification_issued
      comment: "Boolean flag indicating whether a certification was issued upon completion."
    - name: "compliance_flag"
      expr: compliance_flag
      comment: "Boolean flag indicating whether the enrollment meets compliance requirements."
    - name: "enrollment_month"
      expr: DATE_TRUNC('month', scheduled_completion_date)
      comment: "Month of the scheduled completion date for training pipeline planning."
  measures:
    - name: "total_enrollments"
      expr: COUNT(1)
      comment: "Total training enrollments — training program scale and workforce development investment indicator."
    - name: "completed_enrollment_count"
      expr: COUNT(CASE WHEN training_enrollment_status = 'completed' THEN 1 END)
      comment: "Number of completed training enrollments — workforce readiness delivery indicator."
    - name: "training_completion_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN training_enrollment_status = 'completed' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of training enrollments completed — franchise workforce readiness KPI."
    - name: "certification_issuance_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN certification_issued = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of enrollments resulting in certification issuance — credentialing effectiveness KPI."
    - name: "pass_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN pass_fail_status = 'pass' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of training enrollments with a passing outcome — training program quality indicator."
    - name: "avg_score"
      expr: AVG(CAST(score AS DOUBLE))
      comment: "Average training assessment score — measures depth of knowledge acquisition across the franchise workforce."
    - name: "total_hours_completed"
      expr: SUM(CAST(hours_completed AS DOUBLE))
      comment: "Total training hours completed across all enrollments — workforce development investment measure."
    - name: "avg_hours_completed"
      expr: AVG(CAST(hours_completed AS DOUBLE))
      comment: "Average training hours completed per enrollment — training depth and engagement indicator."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`franchise_support_visit`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Franchise support visit metrics — tracks field support activity, compliance scores, follow-up rates, and visit outcomes to measure the effectiveness of the franchisor support program."
  source: "`vibe_restaurants_v1`.`franchise`.`support_visit`"
  dimensions:
    - name: "visit_type"
      expr: visit_type
      comment: "Type of support visit (operational, training, compliance, financial) for program mix analysis."
    - name: "support_visit_status"
      expr: support_visit_status
      comment: "Status of the support visit (scheduled, completed, cancelled) for visit program management."
    - name: "follow_up_required"
      expr: follow_up_required
      comment: "Boolean flag indicating whether a follow-up visit is required — franchisee support intensity indicator."
    - name: "compliance_flag"
      expr: compliance_flag
      comment: "Boolean flag indicating compliance issues were identified during the visit."
    - name: "is_training_visit"
      expr: is_training_visit
      comment: "Boolean flag indicating whether the visit included a training component."
    - name: "region"
      expr: region
      comment: "Geographic region of the support visit for regional support coverage analysis."
    - name: "visit_month"
      expr: DATE_TRUNC('month', visit_timestamp)
      comment: "Month of the support visit for trend analysis of field support activity."
  measures:
    - name: "total_support_visits"
      expr: COUNT(1)
      comment: "Total number of support visits conducted — field support program activity level."
    - name: "avg_compliance_score"
      expr: AVG(CAST(compliance_score AS DOUBLE))
      comment: "Average compliance score from support visits — franchisee operational standards adherence indicator."
    - name: "avg_visit_duration_minutes"
      expr: AVG(CAST(visit_duration_minutes AS DOUBLE))
      comment: "Average duration of support visits in minutes — support depth and resource utilization indicator."
    - name: "follow_up_required_count"
      expr: COUNT(CASE WHEN follow_up_required = TRUE THEN 1 END)
      comment: "Number of visits requiring follow-up — franchisee support intensity and risk indicator."
    - name: "follow_up_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN follow_up_required = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of support visits requiring follow-up — franchisee health and support effectiveness KPI."
    - name: "total_visit_expense"
      expr: SUM(CAST(expense_amount AS DOUBLE))
      comment: "Total expense incurred for support visits — field support program cost management indicator."
    - name: "avg_sales_impact_estimate"
      expr: AVG(CAST(sales_impact_estimate AS DOUBLE))
      comment: "Average estimated sales impact from support visits — ROI of the field support program."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`franchise_franchisee`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Financial health and volume metrics for franchisee master records"
  source: "`vibe_restaurants_v1`.`franchise`.`franchisee`"
  dimensions:
    - name: "territory_id"
      expr: territory_id
      comment: "Territory identifier for the franchisee"
    - name: "franchisee_status"
      expr: franchisee_status
      comment: "Current operational status of the franchisee"
    - name: "franchisee_type"
      expr: franchisee_type
      comment: "Type classification of the franchisee"
    - name: "country_code"
      expr: country_code
      comment: "Country code of the franchisee location"
    - name: "state_province"
      expr: state_province
      comment: "State or province of the franchisee"
  measures:
    - name: "total_franchisees"
      expr: COUNT(1)
      comment: "Count of franchisee records"
    - name: "total_annual_revenue"
      expr: SUM(CAST(annual_revenue AS DOUBLE))
      comment: "Sum of annual revenue across franchisees"
    - name: "average_annual_revenue"
      expr: AVG(CAST(annual_revenue AS DOUBLE))
      comment: "Average annual revenue per franchisee"
    - name: "average_unit_volume"
      expr: AVG(CAST(average_unit_volume AS DOUBLE))
      comment: "Average unit volume across franchisees"
    - name: "total_royalty_fee_amount"
      expr: SUM(CAST(royalty_fee_amount AS DOUBLE))
      comment: "Total royalty fee amount across franchisees"
    - name: "average_royalty_rate"
      expr: AVG(CAST(royalty_rate AS DOUBLE))
      comment: "Average royalty rate across franchisees"
$$;