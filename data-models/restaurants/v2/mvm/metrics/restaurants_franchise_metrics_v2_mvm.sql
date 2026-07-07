-- Metric views for domain: franchise | Business: Restaurants | Version: 2 | Generated on: 2026-07-01 14:04:56

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`franchise_agreement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Franchise agreement performance metrics tracking contract value, compliance, and renewal activity"
  source: "`vibe_restaurants_v1`.`franchise`.`agreement`"
  dimensions:
    - name: "agreement_status"
      expr: agreement_status
      comment: "Current status of the franchise agreement (active, expired, terminated, etc.)"
    - name: "agreement_type"
      expr: agreement_type
      comment: "Type of franchise agreement (new, renewal, transfer, etc.)"
    - name: "compliance_status"
      expr: compliance_status
      comment: "Current compliance status of the agreement"
    - name: "ftc_compliance_attestation"
      expr: ftc_compliance_attestation_flag
      comment: "Whether FTC compliance attestation has been completed"
    - name: "agreement_year"
      expr: YEAR(effective_start_date)
      comment: "Year the agreement became effective"
    - name: "agreement_quarter"
      expr: CONCAT('Q', QUARTER(effective_start_date), '-', YEAR(effective_start_date))
      comment: "Quarter and year the agreement became effective"
    - name: "renewal_term_years"
      expr: renewal_term_years
      comment: "Length of renewal term in years"
  measures:
    - name: "total_agreements"
      expr: COUNT(1)
      comment: "Total number of franchise agreements"
    - name: "total_initial_fees"
      expr: SUM(CAST(initial_fee_amount AS DOUBLE))
      comment: "Total initial franchise fees collected across all agreements"
    - name: "total_renewal_fees"
      expr: SUM(CAST(renewal_fee_amount AS DOUBLE))
      comment: "Total renewal fees collected across all agreements"
    - name: "avg_royalty_rate"
      expr: AVG(CAST(royalty_rate_percent AS DOUBLE))
      comment: "Average royalty rate percentage across agreements"
    - name: "avg_marketing_fee_rate"
      expr: AVG(CAST(marketing_fee_percent AS DOUBLE))
      comment: "Average marketing fee percentage across agreements"
    - name: "total_sales_target"
      expr: SUM(CAST(sales_target_amount AS DOUBLE))
      comment: "Total sales target amount across all agreements"
    - name: "avg_unit_volume"
      expr: AVG(CAST(average_unit_volume AS DOUBLE))
      comment: "Average unit volume per agreement"
    - name: "distinct_franchisees"
      expr: COUNT(DISTINCT franchisee_id)
      comment: "Number of unique franchisees with agreements"
    - name: "distinct_territories"
      expr: COUNT(DISTINCT territory_id)
      comment: "Number of unique territories covered by agreements"
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`franchise_billing`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Franchise billing and payment performance metrics tracking revenue, collections, and payment timeliness"
  source: "`vibe_restaurants_v1`.`franchise`.`billing`"
  dimensions:
    - name: "billing_status"
      expr: billing_status
      comment: "Current status of the billing record (paid, pending, overdue, etc.)"
    - name: "billing_type"
      expr: billing_type
      comment: "Type of billing (royalty, marketing fee, technology fee, etc.)"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency code for the billing transaction"
    - name: "billing_month"
      expr: DATE_TRUNC('MONTH', billing_date)
      comment: "Month of the billing date"
    - name: "billing_quarter"
      expr: CONCAT('Q', QUARTER(billing_date), '-', YEAR(billing_date))
      comment: "Quarter and year of the billing date"
    - name: "billing_year"
      expr: YEAR(billing_date)
      comment: "Year of the billing date"
    - name: "period"
      expr: period
      comment: "Billing period identifier"
  measures:
    - name: "total_billings"
      expr: COUNT(1)
      comment: "Total number of billing records"
    - name: "total_billed_amount"
      expr: SUM(CAST(total_amount AS DOUBLE))
      comment: "Total amount billed across all billing records"
    - name: "total_amount_paid"
      expr: SUM(CAST(amount_paid AS DOUBLE))
      comment: "Total amount paid by franchisees"
    - name: "total_balance_outstanding"
      expr: SUM(CAST(balance_amount AS DOUBLE))
      comment: "Total outstanding balance across all billing records"
    - name: "total_royalty_revenue"
      expr: SUM(CAST(royalty_amount AS DOUBLE))
      comment: "Total royalty revenue collected"
    - name: "total_marketing_fee_revenue"
      expr: SUM(CAST(marketing_fee_amount AS DOUBLE))
      comment: "Total marketing fee revenue collected"
    - name: "total_technology_fee_revenue"
      expr: SUM(CAST(technology_fee_amount AS DOUBLE))
      comment: "Total technology fee revenue collected"
    - name: "total_late_fees"
      expr: SUM(CAST(late_fee_amount AS DOUBLE))
      comment: "Total late fees assessed across all billing records"
    - name: "total_gross_sales"
      expr: SUM(CAST(gross_sales_amount AS DOUBLE))
      comment: "Total gross sales reported by franchisees"
    - name: "avg_royalty_rate"
      expr: AVG(CAST(royalty_rate AS DOUBLE))
      comment: "Average royalty rate percentage applied to billings"
    - name: "collection_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(amount_paid AS DOUBLE)) / NULLIF(SUM(CAST(total_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of billed amount that has been collected"
    - name: "distinct_franchisees_billed"
      expr: COUNT(DISTINCT franchisee_id)
      comment: "Number of unique franchisees billed in the period"
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`franchise_compliance_audit`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Franchise compliance audit metrics tracking quality, safety, and brand standards adherence"
  source: "`vibe_restaurants_v1`.`franchise`.`compliance_audit`"
  dimensions:
    - name: "audit_type"
      expr: audit_type
      comment: "Type of compliance audit conducted"
    - name: "compliance_audit_status"
      expr: compliance_audit_status
      comment: "Current status of the compliance audit"
    - name: "audit_disposition"
      expr: audit_disposition
      comment: "Final disposition or outcome of the audit"
    - name: "corrective_action_required"
      expr: corrective_action_required
      comment: "Whether corrective action is required based on audit findings"
    - name: "audit_month"
      expr: DATE_TRUNC('MONTH', CAST(audit_timestamp AS DATE))
      comment: "Month when the audit was conducted"
    - name: "audit_quarter"
      expr: CONCAT('Q', QUARTER(CAST(audit_timestamp AS DATE)), '-', YEAR(CAST(audit_timestamp AS DATE)))
      comment: "Quarter and year when the audit was conducted"
    - name: "audit_year"
      expr: YEAR(CAST(audit_timestamp AS DATE))
      comment: "Year when the audit was conducted"
  measures:
    - name: "total_audits"
      expr: COUNT(1)
      comment: "Total number of compliance audits conducted"
    - name: "avg_overall_score"
      expr: AVG(CAST(overall_score AS DOUBLE))
      comment: "Average overall compliance audit score"
    - name: "avg_food_safety_score"
      expr: AVG(CAST(food_safety_score AS DOUBLE))
      comment: "Average food safety score across audits"
    - name: "avg_brand_standards_score"
      expr: AVG(CAST(brand_standards_score AS DOUBLE))
      comment: "Average brand standards compliance score"
    - name: "avg_cleanliness_score"
      expr: AVG(CAST(cleanliness_score AS DOUBLE))
      comment: "Average cleanliness score across audits"
    - name: "avg_service_score"
      expr: AVG(CAST(service_score AS DOUBLE))
      comment: "Average service quality score"
    - name: "avg_equipment_score"
      expr: AVG(CAST(equipment_score AS DOUBLE))
      comment: "Average equipment maintenance and condition score"
    - name: "audits_requiring_corrective_action"
      expr: SUM(CASE WHEN corrective_action_required = true THEN 1 ELSE 0 END)
      comment: "Number of audits that require corrective action"
    - name: "corrective_action_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN corrective_action_required = true THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of audits requiring corrective action"
    - name: "distinct_units_audited"
      expr: COUNT(DISTINCT audited_unit_id)
      comment: "Number of unique restaurant units audited"
    - name: "distinct_territories_audited"
      expr: COUNT(DISTINCT territory_id)
      comment: "Number of unique territories audited"
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`franchise_franchisee`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Franchisee portfolio metrics tracking franchisee performance, compliance, and financial health"
  source: "`vibe_restaurants_v1`.`franchise`.`franchisee`"
  dimensions:
    - name: "franchisee_status"
      expr: franchisee_status
      comment: "Current status of the franchisee (active, inactive, terminated, etc.)"
    - name: "franchisee_type"
      expr: franchisee_type
      comment: "Type or classification of franchisee"
    - name: "compliance_status"
      expr: compliance_status
      comment: "Current compliance status of the franchisee"
    - name: "credit_rating"
      expr: credit_rating
      comment: "Credit rating of the franchisee"
    - name: "food_safety_certified"
      expr: food_safety_certified
      comment: "Whether the franchisee holds food safety certification"
    - name: "ifa_membership_status"
      expr: ifa_membership_status
      comment: "International Franchise Association membership status"
    - name: "country_code"
      expr: country_code
      comment: "Country where the franchisee operates"
    - name: "state_province"
      expr: state_province
      comment: "State or province where the franchisee operates"
    - name: "established_year"
      expr: YEAR(established_date)
      comment: "Year the franchisee was established"
  measures:
    - name: "total_franchisees"
      expr: COUNT(1)
      comment: "Total number of franchisees"
    - name: "total_annual_revenue"
      expr: SUM(CAST(annual_revenue AS DOUBLE))
      comment: "Total annual revenue across all franchisees"
    - name: "avg_annual_revenue"
      expr: AVG(CAST(annual_revenue AS DOUBLE))
      comment: "Average annual revenue per franchisee"
    - name: "total_franchise_fees"
      expr: SUM(CAST(franchise_fee_amount AS DOUBLE))
      comment: "Total franchise fees paid by all franchisees"
    - name: "total_royalty_fees"
      expr: SUM(CAST(royalty_fee_amount AS DOUBLE))
      comment: "Total royalty fees paid by all franchisees"
    - name: "avg_royalty_rate"
      expr: AVG(CAST(royalty_rate AS DOUBLE))
      comment: "Average royalty rate across franchisees"
    - name: "avg_unit_volume"
      expr: AVG(CAST(average_unit_volume AS DOUBLE))
      comment: "Average unit volume per franchisee"
    - name: "food_safety_certification_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN food_safety_certified = true THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of franchisees with food safety certification"
    - name: "distinct_territories"
      expr: COUNT(DISTINCT territory_id)
      comment: "Number of unique territories covered by franchisees"
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`franchise_performance_scorecard`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Franchisee performance scorecard metrics tracking operational excellence, customer satisfaction, and financial performance"
  source: "`vibe_restaurants_v1`.`franchise`.`performance_scorecard`"
  dimensions:
    - name: "evaluation_status"
      expr: evaluation_status
      comment: "Current status of the performance evaluation"
    - name: "evaluation_type"
      expr: evaluation_type
      comment: "Type of performance evaluation conducted"
    - name: "overall_performance_tier"
      expr: overall_performance_tier
      comment: "Overall performance tier or classification (e.g., platinum, gold, silver, bronze)"
    - name: "region_code"
      expr: region_code
      comment: "Geographic region code for the evaluation"
    - name: "evaluation_year"
      expr: evaluation_year
      comment: "Year of the performance evaluation"
    - name: "evaluation_month"
      expr: evaluation_month
      comment: "Month of the performance evaluation"
    - name: "evaluation_quarter"
      expr: CONCAT('Q', QUARTER(evaluation_period_start), '-', YEAR(evaluation_period_start))
      comment: "Quarter and year of the evaluation period start"
  measures:
    - name: "total_evaluations"
      expr: COUNT(1)
      comment: "Total number of performance evaluations conducted"
    - name: "total_sales"
      expr: SUM(CAST(total_sales_amount AS DOUBLE))
      comment: "Total sales amount across all evaluated franchisees"
    - name: "total_royalty_collected"
      expr: SUM(CAST(total_royalty_amount AS DOUBLE))
      comment: "Total royalty amount collected from evaluated franchisees"
    - name: "avg_unit_volume"
      expr: AVG(CAST(average_unit_volume AS DOUBLE))
      comment: "Average unit volume across evaluated franchisees"
    - name: "avg_customer_satisfaction_score"
      expr: AVG(CAST(customer_satisfaction_score AS DOUBLE))
      comment: "Average customer satisfaction score across evaluations"
    - name: "avg_compliance_audit_score"
      expr: AVG(CAST(compliance_audit_average_score AS DOUBLE))
      comment: "Average compliance audit score across evaluations"
    - name: "avg_same_store_sales_growth_pct"
      expr: AVG(CAST(same_store_sales_growth_pct AS DOUBLE))
      comment: "Average same-store sales growth percentage"
    - name: "avg_royalty_payment_timeliness_pct"
      expr: AVG(CAST(royalty_payment_timeliness_pct AS DOUBLE))
      comment: "Average royalty payment timeliness percentage"
    - name: "avg_training_completion_rate_pct"
      expr: AVG(CAST(training_completion_rate_pct AS DOUBLE))
      comment: "Average training completion rate percentage"
    - name: "royalty_yield_pct"
      expr: ROUND(100.0 * SUM(CAST(total_royalty_amount AS DOUBLE)) / NULLIF(SUM(CAST(total_sales_amount AS DOUBLE)), 0), 2)
      comment: "Royalty amount as a percentage of total sales"
    - name: "distinct_franchisees_evaluated"
      expr: COUNT(DISTINCT franchisee_id)
      comment: "Number of unique franchisees evaluated"
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`franchise_sales_report`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Franchise sales reporting metrics tracking revenue, transaction volume, and reporting compliance"
  source: "`vibe_restaurants_v1`.`franchise`.`sales_report`"
  dimensions:
    - name: "sales_report_status"
      expr: sales_report_status
      comment: "Current status of the sales report (submitted, pending, approved, rejected)"
    - name: "reporting_period_type"
      expr: reporting_period_type
      comment: "Type of reporting period (weekly, monthly, quarterly, annual)"
    - name: "validation_status"
      expr: validation_status
      comment: "Validation status of the sales report"
    - name: "submission_method"
      expr: submission_method
      comment: "Method used to submit the sales report"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency code for the sales report"
    - name: "variance_flag"
      expr: variance_flag
      comment: "Flag indicating whether there is a variance requiring investigation"
    - name: "reporting_month"
      expr: DATE_TRUNC('MONTH', reporting_period_start)
      comment: "Month of the reporting period start"
    - name: "reporting_quarter"
      expr: CONCAT('Q', QUARTER(reporting_period_start), '-', YEAR(reporting_period_start))
      comment: "Quarter and year of the reporting period start"
    - name: "reporting_year"
      expr: YEAR(reporting_period_start)
      comment: "Year of the reporting period start"
  measures:
    - name: "total_reports"
      expr: COUNT(1)
      comment: "Total number of sales reports submitted"
    - name: "total_gross_sales"
      expr: SUM(CAST(gross_sales_amount AS DOUBLE))
      comment: "Total gross sales reported by franchisees"
    - name: "total_net_sales"
      expr: SUM(CAST(net_sales_amount AS DOUBLE))
      comment: "Total net sales after adjustments"
    - name: "total_royalty_due"
      expr: SUM(CAST(royalty_amount AS DOUBLE))
      comment: "Total royalty amount due based on reported sales"
    - name: "total_transactions"
      expr: SUM(CAST(transaction_count AS DOUBLE))
      comment: "Total number of transactions across all reports"
    - name: "total_adjustments"
      expr: SUM(CAST(adjustments_amount AS DOUBLE))
      comment: "Total adjustments applied to sales reports"
    - name: "total_variance"
      expr: SUM(CAST(variance_amount AS DOUBLE))
      comment: "Total variance amount across all sales reports"
    - name: "total_same_store_sales"
      expr: SUM(CAST(same_store_sales AS DOUBLE))
      comment: "Total same-store sales across all reports"
    - name: "avg_check_value"
      expr: AVG(CAST(average_check_value AS DOUBLE))
      comment: "Average check value across all reported transactions"
    - name: "avg_royalty_rate"
      expr: AVG(CAST(royalty_rate AS DOUBLE))
      comment: "Average royalty rate applied to sales reports"
    - name: "net_sales_margin_pct"
      expr: ROUND(100.0 * SUM(CAST(net_sales_amount AS DOUBLE)) / NULLIF(SUM(CAST(gross_sales_amount AS DOUBLE)), 0), 2)
      comment: "Net sales as a percentage of gross sales"
    - name: "reports_with_variance"
      expr: SUM(CASE WHEN variance_flag = true THEN 1 ELSE 0 END)
      comment: "Number of sales reports flagged with variance"
    - name: "variance_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN variance_flag = true THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of sales reports with variance flags"
    - name: "distinct_franchisees_reporting"
      expr: COUNT(DISTINCT franchisee_id)
      comment: "Number of unique franchisees who submitted sales reports"
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`franchise_territory`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Franchise territory metrics tracking geographic coverage, market potential, and territory performance"
  source: "`vibe_restaurants_v1`.`franchise`.`territory`"
  dimensions:
    - name: "territory_status"
      expr: territory_status
      comment: "Current status of the territory (available, assigned, developed, etc.)"
    - name: "territory_type"
      expr: territory_type
      comment: "Type or classification of territory"
    - name: "assignment_status"
      expr: assignment_status
      comment: "Assignment status of the territory"
    - name: "compliance_status"
      expr: compliance_status
      comment: "Compliance status of the territory"
    - name: "trade_area_classification"
      expr: trade_area_classification
      comment: "Classification of the trade area (urban, suburban, rural, etc.)"
    - name: "region"
      expr: region
      comment: "Geographic region of the territory"
    - name: "country_code"
      expr: country_code
      comment: "Country code for the territory"
    - name: "dma"
      expr: dma
      comment: "Designated Market Area for the territory"
  measures:
    - name: "total_territories"
      expr: COUNT(1)
      comment: "Total number of franchise territories"
    - name: "total_territory_area_sq_miles"
      expr: SUM(CAST(area_sq_miles AS DOUBLE))
      comment: "Total geographic area covered by territories in square miles"
    - name: "avg_territory_area_sq_miles"
      expr: AVG(CAST(area_sq_miles AS DOUBLE))
      comment: "Average territory size in square miles"
    - name: "total_population"
      expr: SUM(CAST(population AS DOUBLE))
      comment: "Total population across all territories"
    - name: "avg_population"
      expr: AVG(CAST(population AS DOUBLE))
      comment: "Average population per territory"
    - name: "avg_median_income"
      expr: AVG(CAST(median_income AS DOUBLE))
      comment: "Average median income across territories"
    - name: "total_franchise_fees"
      expr: SUM(CAST(franchise_fee AS DOUBLE))
      comment: "Total franchise fees associated with territories"
    - name: "avg_royalty_rate"
      expr: AVG(CAST(royalty_rate AS DOUBLE))
      comment: "Average royalty rate across territories"
    - name: "avg_unit_volume"
      expr: AVG(CAST(average_unit_volume AS DOUBLE))
      comment: "Average unit volume per territory"
    - name: "total_unit_volume"
      expr: SUM(CAST(average_unit_volume AS DOUBLE))
      comment: "Total unit volume across all territories"
    - name: "population_density_per_sq_mile"
      expr: ROUND(SUM(CAST(population AS DOUBLE)) / NULLIF(SUM(CAST(area_sq_miles AS DOUBLE)), 0), 2)
      comment: "Average population density per square mile across territories"
$$;