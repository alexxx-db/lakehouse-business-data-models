-- Metric views for domain: sales | Business: Consumer_Goods | Version: 2 | Generated on: 2026-07-10 13:28:51

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`sales_trade_account`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core customer account metrics including account value, credit exposure, and operational performance indicators"
  source: "`vibe_consumer_goods_v1`.`sales`.`trade_account`"
  dimensions:
    - name: "account_status"
      expr: account_status
      comment: "Current operational status of the trade account"
    - name: "account_tier"
      expr: account_tier
      comment: "Strategic tier classification of the account"
    - name: "account_type"
      expr: account_type
      comment: "Type classification of the trade account"
    - name: "trade_channel"
      expr: trade_channel
      comment: "Primary trade channel for the account"
    - name: "country_code"
      expr: headquarters_country_code
      comment: "Country code of account headquarters"
    - name: "state_province"
      expr: headquarters_state_province
      comment: "State or province of account headquarters"
    - name: "credit_rating"
      expr: credit_rating
      comment: "Credit rating classification of the account"
    - name: "vmi_enabled_flag"
      expr: vmi_enabled_flag
      comment: "Whether vendor-managed inventory is enabled for this account"
    - name: "edi_capable_flag"
      expr: edi_capable_flag
      comment: "Whether the account has EDI capability"
    - name: "dsd_delivery_flag"
      expr: dsd_delivery_flag
      comment: "Whether direct store delivery is enabled"
    - name: "account_open_year"
      expr: YEAR(account_open_date)
      comment: "Year the account was opened"
  measures:
    - name: "total_accounts"
      expr: COUNT(DISTINCT trade_account_id)
      comment: "Total number of unique trade accounts"
    - name: "total_acv"
      expr: SUM(CAST(acv_total AS DOUBLE))
      comment: "Total annual customer value across all accounts"
    - name: "avg_acv_per_account"
      expr: AVG(CAST(acv_total AS DOUBLE))
      comment: "Average annual customer value per account"
    - name: "total_credit_limit"
      expr: SUM(CAST(credit_limit_amount AS DOUBLE))
      comment: "Total credit limit extended across all accounts"
    - name: "avg_credit_limit"
      expr: AVG(CAST(credit_limit_amount AS DOUBLE))
      comment: "Average credit limit per account"
    - name: "total_tdp_count"
      expr: SUM(CAST(tdp_count AS DOUBLE))
      comment: "Total trade distribution points across all accounts"
    - name: "avg_otif_sla_target"
      expr: AVG(CAST(otif_sla_target_percent AS DOUBLE))
      comment: "Average on-time-in-full SLA target percentage across accounts"
    - name: "vmi_enabled_account_count"
      expr: COUNT(DISTINCT CASE WHEN vmi_enabled_flag = TRUE THEN trade_account_id END)
      comment: "Number of accounts with VMI enabled"
    - name: "edi_capable_account_count"
      expr: COUNT(DISTINCT CASE WHEN edi_capable_flag = TRUE THEN trade_account_id END)
      comment: "Number of accounts with EDI capability"
    - name: "dsd_enabled_account_count"
      expr: COUNT(DISTINCT CASE WHEN dsd_delivery_flag = TRUE THEN trade_account_id END)
      comment: "Number of accounts with direct store delivery enabled"
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`sales_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Sales order performance metrics including revenue, margin, fulfillment, and OTIF compliance"
  source: "`vibe_consumer_goods_v1`.`sales`.`order`"
  dimensions:
    - name: "order_status"
      expr: order_status
      comment: "Current status of the sales order"
    - name: "order_type"
      expr: order_type
      comment: "Type classification of the order"
    - name: "channel_type"
      expr: channel_type
      comment: "Sales channel through which the order was placed"
    - name: "distribution_channel"
      expr: distribution_channel
      comment: "Distribution channel for the order"
    - name: "sales_organization"
      expr: sales_organization
      comment: "Sales organization responsible for the order"
    - name: "division"
      expr: division
      comment: "Business division for the order"
    - name: "otif_status"
      expr: otif_status
      comment: "On-time-in-full delivery status"
    - name: "order_year"
      expr: YEAR(order_date)
      comment: "Year the order was placed"
    - name: "order_month"
      expr: DATE_TRUNC('MONTH', order_date)
      comment: "Month the order was placed"
    - name: "order_quarter"
      expr: CONCAT('Q', QUARTER(order_date), '-', YEAR(order_date))
      comment: "Fiscal quarter of the order"
    - name: "incoterm"
      expr: incoterm
      comment: "International commercial terms for the order"
    - name: "payment_terms"
      expr: payment_terms
      comment: "Payment terms for the order"
  measures:
    - name: "total_orders"
      expr: COUNT(DISTINCT order_id)
      comment: "Total number of unique sales orders"
    - name: "total_order_value"
      expr: SUM(CAST(total_amount AS DOUBLE))
      comment: "Total revenue from all orders"
    - name: "avg_order_value"
      expr: AVG(CAST(total_amount AS DOUBLE))
      comment: "Average order value per order"
    - name: "total_gross_margin"
      expr: SUM(CAST(gross_margin_amount AS DOUBLE))
      comment: "Total gross margin across all orders"
    - name: "avg_gross_margin"
      expr: AVG(CAST(gross_margin_amount AS DOUBLE))
      comment: "Average gross margin per order"
    - name: "gross_margin_rate"
      expr: ROUND(100.0 * SUM(CAST(gross_margin_amount AS DOUBLE)) / NULLIF(SUM(CAST(total_amount AS DOUBLE)), 0), 2)
      comment: "Gross margin as a percentage of total order value"
    - name: "total_cogs"
      expr: SUM(CAST(cogs_amount AS DOUBLE))
      comment: "Total cost of goods sold across all orders"
    - name: "total_freight"
      expr: SUM(CAST(freight_amount AS DOUBLE))
      comment: "Total freight charges across all orders"
    - name: "total_discount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discount amount across all orders"
    - name: "total_tax"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount across all orders"
    - name: "otif_compliant_orders"
      expr: COUNT(DISTINCT CASE WHEN otif_status = 'Compliant' THEN order_id END)
      comment: "Number of orders meeting on-time-in-full criteria"
    - name: "cancelled_orders"
      expr: COUNT(DISTINCT CASE WHEN order_status = 'Cancelled' THEN order_id END)
      comment: "Number of cancelled orders"
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`sales_invoice`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Invoice and accounts receivable metrics including billing, collections, DSO, and payment performance"
  source: "`vibe_consumer_goods_v1`.`sales`.`invoice`"
  dimensions:
    - name: "invoice_status"
      expr: invoice_status
      comment: "Current status of the invoice"
    - name: "payment_status"
      expr: payment_status
      comment: "Payment status of the invoice"
    - name: "billing_type"
      expr: billing_type
      comment: "Type of billing for the invoice"
    - name: "payment_method"
      expr: payment_method
      comment: "Method of payment for the invoice"
    - name: "distribution_channel_code"
      expr: distribution_channel_code
      comment: "Distribution channel code for the invoice"
    - name: "sales_organization_code"
      expr: sales_organization_code
      comment: "Sales organization code for the invoice"
    - name: "division_code"
      expr: division_code
      comment: "Division code for the invoice"
    - name: "dispute_flag"
      expr: dispute_flag
      comment: "Whether the invoice is under dispute"
    - name: "invoice_year"
      expr: YEAR(invoice_date)
      comment: "Year the invoice was issued"
    - name: "invoice_month"
      expr: DATE_TRUNC('MONTH', invoice_date)
      comment: "Month the invoice was issued"
    - name: "due_year_month"
      expr: DATE_TRUNC('MONTH', due_date)
      comment: "Month the invoice is due"
  measures:
    - name: "total_invoices"
      expr: COUNT(DISTINCT invoice_id)
      comment: "Total number of unique invoices"
    - name: "total_gross_amount"
      expr: SUM(CAST(gross_amount AS DOUBLE))
      comment: "Total gross invoice amount before discounts and adjustments"
    - name: "total_net_amount"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Total net invoice amount after discounts"
    - name: "total_outstanding_amount"
      expr: SUM(CAST(outstanding_amount AS DOUBLE))
      comment: "Total outstanding receivables amount"
    - name: "total_paid_amount"
      expr: SUM(CAST(paid_amount AS DOUBLE))
      comment: "Total amount paid across all invoices"
    - name: "collection_rate"
      expr: ROUND(100.0 * SUM(CAST(paid_amount AS DOUBLE)) / NULLIF(SUM(CAST(net_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of invoiced amount that has been collected"
    - name: "total_trade_discount"
      expr: SUM(CAST(trade_discount_amount AS DOUBLE))
      comment: "Total trade discount amount across all invoices"
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount across all invoices"
    - name: "total_freight_charge"
      expr: SUM(CAST(freight_charge_amount AS DOUBLE))
      comment: "Total freight charges across all invoices"
    - name: "total_cogs"
      expr: SUM(CAST(cost_of_goods_sold_amount AS DOUBLE))
      comment: "Total cost of goods sold across all invoices"
    - name: "total_gross_margin"
      expr: SUM(CAST(gross_margin_amount AS DOUBLE))
      comment: "Total gross margin across all invoices"
    - name: "avg_dso"
      expr: AVG(CAST(days_sales_outstanding AS DOUBLE))
      comment: "Average days sales outstanding across invoices"
    - name: "disputed_invoices"
      expr: COUNT(DISTINCT CASE WHEN dispute_flag = TRUE THEN invoice_id END)
      comment: "Number of invoices currently under dispute"
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`sales_opportunity`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Sales pipeline and opportunity metrics including win rates, forecast accuracy, and revenue potential"
  source: "`vibe_consumer_goods_v1`.`sales`.`opportunity`"
  dimensions:
    - name: "stage"
      expr: stage
      comment: "Current stage of the sales opportunity"
    - name: "opportunity_type"
      expr: opportunity_type
      comment: "Type classification of the opportunity"
    - name: "channel_type"
      expr: channel_type
      comment: "Sales channel for the opportunity"
    - name: "forecast_category"
      expr: forecast_category
      comment: "Forecast category classification"
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the opportunity"
    - name: "fiscal_quarter"
      expr: fiscal_quarter
      comment: "Fiscal quarter of the opportunity"
    - name: "lead_source"
      expr: lead_source
      comment: "Source of the sales lead"
    - name: "product_category_focus"
      expr: product_category_focus
      comment: "Primary product category focus of the opportunity"
    - name: "jbp_alignment_flag"
      expr: jbp_alignment_flag
      comment: "Whether the opportunity aligns with joint business plan"
    - name: "win_reason"
      expr: win_reason
      comment: "Reason for winning the opportunity"
    - name: "loss_reason"
      expr: loss_reason
      comment: "Reason for losing the opportunity"
  measures:
    - name: "total_opportunities"
      expr: COUNT(DISTINCT opportunity_id)
      comment: "Total number of unique sales opportunities"
    - name: "total_estimated_revenue"
      expr: SUM(CAST(estimated_annual_revenue AS DOUBLE))
      comment: "Total estimated annual revenue from all opportunities"
    - name: "weighted_pipeline_value"
      expr: SUM(CAST(estimated_annual_revenue AS DOUBLE) * CAST(probability_percentage AS DOUBLE) / 100.0)
      comment: "Probability-weighted pipeline value"
    - name: "total_estimated_acv_gain"
      expr: SUM(CAST(estimated_acv_gain AS DOUBLE))
      comment: "Total estimated annual customer value gain from opportunities"
    - name: "avg_opportunity_value"
      expr: AVG(CAST(estimated_annual_revenue AS DOUBLE))
      comment: "Average estimated revenue per opportunity"
    - name: "avg_probability"
      expr: AVG(CAST(probability_percentage AS DOUBLE))
      comment: "Average win probability across all opportunities"
    - name: "won_opportunities"
      expr: COUNT(DISTINCT CASE WHEN stage = 'Closed Won' THEN opportunity_id END)
      comment: "Number of opportunities closed as won"
    - name: "lost_opportunities"
      expr: COUNT(DISTINCT CASE WHEN stage = 'Closed Lost' THEN opportunity_id END)
      comment: "Number of opportunities closed as lost"
    - name: "total_estimated_tdp_gain"
      expr: SUM(CAST(estimated_tdp_gain AS DOUBLE))
      comment: "Total estimated trade distribution point gain from opportunities"
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`sales_pos_transaction`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Point-of-sale transaction metrics including retail sales, promotional lift, and out-of-stock tracking"
  source: "`vibe_consumer_goods_v1`.`sales`.`pos_transaction`"
  dimensions:
    - name: "channel_type"
      expr: channel_type
      comment: "Retail channel type for the transaction"
    - name: "store_format"
      expr: store_format
      comment: "Format of the retail store"
    - name: "market_name"
      expr: market_name
      comment: "Market name for the transaction"
    - name: "store_country_code"
      expr: store_country_code
      comment: "Country code of the store"
    - name: "store_state_province"
      expr: store_state_province
      comment: "State or province of the store"
    - name: "promotional_flag"
      expr: promotional_flag
      comment: "Whether the transaction was promotional"
    - name: "promotion_type"
      expr: promotion_type
      comment: "Type of promotion applied"
    - name: "acv_flag"
      expr: acv_flag
      comment: "Whether the transaction counts toward ACV"
    - name: "baseline_sales_flag"
      expr: baseline_sales_flag
      comment: "Whether the transaction is baseline sales"
    - name: "out_of_stock_flag"
      expr: out_of_stock_flag
      comment: "Whether an out-of-stock condition was recorded"
    - name: "transaction_year"
      expr: YEAR(transaction_date)
      comment: "Year of the transaction"
    - name: "transaction_month"
      expr: DATE_TRUNC('MONTH', transaction_date)
      comment: "Month of the transaction"
    - name: "week_ending_date"
      expr: week_ending_date
      comment: "Week ending date for the transaction"
  measures:
    - name: "total_transactions"
      expr: COUNT(DISTINCT pos_transaction_id)
      comment: "Total number of unique POS transactions"
    - name: "total_units_sold"
      expr: SUM(CAST(units_sold AS DOUBLE))
      comment: "Total units sold across all transactions"
    - name: "total_retail_value"
      expr: SUM(CAST(extended_retail_value AS DOUBLE))
      comment: "Total retail sales value"
    - name: "avg_retail_selling_price"
      expr: AVG(CAST(retail_selling_price AS DOUBLE))
      comment: "Average retail selling price per transaction"
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discount amount across all transactions"
    - name: "promotional_transactions"
      expr: COUNT(DISTINCT CASE WHEN promotional_flag = TRUE THEN pos_transaction_id END)
      comment: "Number of promotional transactions"
    - name: "baseline_transactions"
      expr: COUNT(DISTINCT CASE WHEN baseline_sales_flag = TRUE THEN pos_transaction_id END)
      comment: "Number of baseline sales transactions"
    - name: "oos_incidents"
      expr: COUNT(DISTINCT CASE WHEN out_of_stock_flag = TRUE THEN pos_transaction_id END)
      comment: "Number of out-of-stock incidents recorded"
    - name: "avg_units_per_transaction"
      expr: AVG(CAST(units_sold AS DOUBLE))
      comment: "Average units sold per transaction"
    - name: "avg_data_quality_score"
      expr: AVG(CAST(data_quality_score AS DOUBLE))
      comment: "Average data quality score across transactions"
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`sales_account_credit_profile`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Customer credit and risk metrics including credit utilization, exposure, and payment performance"
  source: "`vibe_consumer_goods_v1`.`sales`.`account_credit_profile`"
  dimensions:
    - name: "profile_status"
      expr: profile_status
      comment: "Current status of the credit profile"
    - name: "credit_hold_status"
      expr: credit_hold_status
      comment: "Credit hold status for the account"
    - name: "internal_credit_rating"
      expr: internal_credit_rating
      comment: "Internal credit rating classification"
    - name: "external_credit_rating"
      expr: external_credit_rating
      comment: "External credit rating from credit bureau"
    - name: "risk_category"
      expr: risk_category
      comment: "Risk category classification"
    - name: "payment_terms_code"
      expr: payment_terms_code
      comment: "Payment terms code for the account"
    - name: "dunning_level"
      expr: dunning_level
      comment: "Current dunning level for collections"
    - name: "bankruptcy_flag"
      expr: bankruptcy_flag
      comment: "Whether the account has filed for bankruptcy"
    - name: "credit_insurance_coverage_flag"
      expr: credit_insurance_coverage_flag
      comment: "Whether credit insurance coverage is in place"
    - name: "credit_limit_override_flag"
      expr: credit_limit_override_flag
      comment: "Whether credit limit has been overridden"
  measures:
    - name: "total_credit_profiles"
      expr: COUNT(DISTINCT account_credit_profile_id)
      comment: "Total number of unique credit profiles"
    - name: "total_credit_limit"
      expr: SUM(CAST(credit_limit_amount AS DOUBLE))
      comment: "Total credit limit extended across all accounts"
    - name: "total_current_exposure"
      expr: SUM(CAST(current_exposure_amount AS DOUBLE))
      comment: "Total current credit exposure across all accounts"
    - name: "total_available_credit"
      expr: SUM(CAST(available_credit_amount AS DOUBLE))
      comment: "Total available credit across all accounts"
    - name: "credit_utilization_rate"
      expr: ROUND(100.0 * SUM(CAST(current_exposure_amount AS DOUBLE)) / NULLIF(SUM(CAST(credit_limit_amount AS DOUBLE)), 0), 2)
      comment: "Credit utilization as a percentage of total credit limit"
    - name: "avg_credit_limit"
      expr: AVG(CAST(credit_limit_amount AS DOUBLE))
      comment: "Average credit limit per account"
    - name: "avg_current_exposure"
      expr: AVG(CAST(current_exposure_amount AS DOUBLE))
      comment: "Average current exposure per account"
    - name: "avg_dso_actual"
      expr: AVG(CAST(dso_actual_days AS DOUBLE))
      comment: "Average actual days sales outstanding"
    - name: "total_credit_insurance_coverage"
      expr: SUM(CAST(credit_insurance_coverage_amount AS DOUBLE))
      comment: "Total credit insurance coverage amount"
    - name: "accounts_on_credit_hold"
      expr: COUNT(DISTINCT CASE WHEN credit_hold_status = 'On Hold' THEN account_credit_profile_id END)
      comment: "Number of accounts currently on credit hold"
    - name: "bankruptcy_accounts"
      expr: COUNT(DISTINCT CASE WHEN bankruptcy_flag = TRUE THEN account_credit_profile_id END)
      comment: "Number of accounts with bankruptcy filing"
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`sales_quota`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Sales quota and target metrics including quota attainment, stretch targets, and commission tracking"
  source: "`vibe_consumer_goods_v1`.`sales`.`quota`"
  dimensions:
    - name: "quota_status"
      expr: quota_status
      comment: "Current status of the quota"
    - name: "quota_type"
      expr: quota_type
      comment: "Type classification of the quota"
    - name: "period_type"
      expr: period_type
      comment: "Period type for the quota (monthly, quarterly, annual)"
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year for the quota"
    - name: "fiscal_quarter"
      expr: fiscal_quarter
      comment: "Fiscal quarter for the quota"
    - name: "fiscal_month"
      expr: fiscal_month
      comment: "Fiscal month for the quota"
    - name: "channel_type"
      expr: channel_type
      comment: "Sales channel for the quota"
    - name: "distribution_channel"
      expr: distribution_channel
      comment: "Distribution channel for the quota"
    - name: "sales_organization"
      expr: sales_organization
      comment: "Sales organization for the quota"
    - name: "division"
      expr: division
      comment: "Business division for the quota"
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the quota"
  measures:
    - name: "total_quotas"
      expr: COUNT(DISTINCT quota_id)
      comment: "Total number of unique quotas"
    - name: "total_quota_value"
      expr: SUM(CAST(value AS DOUBLE))
      comment: "Total quota value across all quotas"
    - name: "total_stretch_target"
      expr: SUM(CAST(stretch_target AS DOUBLE))
      comment: "Total stretch target value across all quotas"
    - name: "avg_quota_value"
      expr: AVG(CAST(value AS DOUBLE))
      comment: "Average quota value per quota"
    - name: "avg_stretch_target"
      expr: AVG(CAST(stretch_target AS DOUBLE))
      comment: "Average stretch target per quota"
    - name: "avg_commission_rate"
      expr: AVG(CAST(commission_rate AS DOUBLE))
      comment: "Average commission rate across quotas"
    - name: "avg_accelerator_rate"
      expr: AVG(CAST(accelerator_rate AS DOUBLE))
      comment: "Average accelerator rate for over-quota performance"
    - name: "total_minimum_threshold"
      expr: SUM(CAST(minimum_threshold AS DOUBLE))
      comment: "Total minimum threshold value across quotas"
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`sales_return_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Product return metrics including return rates, reasons, credit processing, and quality disposition"
  source: "`vibe_consumer_goods_v1`.`sales`.`order`"
  dimensions:
    - name: "distribution_channel"
      expr: distribution_channel
      comment: "Distribution channel for the return"
    - name: "sales_organization"
      expr: sales_organization
      comment: "Sales organization for the return"
    - name: "division"
      expr: division
      comment: "Business division for the return"
  measures:
    - name: "Row Count"
      expr: COUNT(1)
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`sales_deduction`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Trade deduction and dispute metrics including claim validation, resolution rates, and root cause analysis"
  source: "`vibe_consumer_goods_v1`.`sales`.`sales_deduction`"
  dimensions:
    - name: "deduction_status"
      expr: deduction_status
      comment: "Current status of the deduction"
    - name: "deduction_type"
      expr: deduction_type
      comment: "Type classification of the deduction"
    - name: "valid_claim_flag"
      expr: valid_claim_flag
      comment: "Whether the deduction claim is valid"
    - name: "escalation_flag"
      expr: escalation_flag
      comment: "Whether the deduction has been escalated"
    - name: "root_cause"
      expr: root_cause
      comment: "Root cause of the deduction"
    - name: "distribution_channel"
      expr: distribution_channel
      comment: "Distribution channel for the deduction"
    - name: "sales_organization"
      expr: sales_organization
      comment: "Sales organization for the deduction"
    - name: "division"
      expr: division
      comment: "Business division for the deduction"
    - name: "deduction_year"
      expr: YEAR(deduction_date)
      comment: "Year the deduction was recorded"
    - name: "deduction_month"
      expr: DATE_TRUNC('MONTH', deduction_date)
      comment: "Month the deduction was recorded"
  measures:
    - name: "total_deductions"
      expr: COUNT(DISTINCT sales_deduction_id)
      comment: "Total number of unique deductions"
    - name: "total_claimed_amount"
      expr: SUM(CAST(claimed_amount AS DOUBLE))
      comment: "Total amount claimed in deductions"
    - name: "total_approved_amount"
      expr: SUM(CAST(approved_amount AS DOUBLE))
      comment: "Total amount approved for deductions"
    - name: "total_disputed_amount"
      expr: SUM(CAST(disputed_amount AS DOUBLE))
      comment: "Total amount under dispute"
    - name: "deduction_approval_rate"
      expr: ROUND(100.0 * SUM(CAST(approved_amount AS DOUBLE)) / NULLIF(SUM(CAST(claimed_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of claimed amount that was approved"
    - name: "avg_claimed_amount"
      expr: AVG(CAST(claimed_amount AS DOUBLE))
      comment: "Average claimed amount per deduction"
    - name: "avg_approved_amount"
      expr: AVG(CAST(approved_amount AS DOUBLE))
      comment: "Average approved amount per deduction"
    - name: "valid_claims"
      expr: COUNT(DISTINCT CASE WHEN valid_claim_flag = TRUE THEN sales_deduction_id END)
      comment: "Number of deductions with valid claims"
    - name: "escalated_deductions"
      expr: COUNT(DISTINCT CASE WHEN escalation_flag = TRUE THEN sales_deduction_id END)
      comment: "Number of deductions that have been escalated"
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`sales_retail_store`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Retail store performance metrics including store count, coverage, format mix, and operational readiness"
  source: "`vibe_consumer_goods_v1`.`sales`.`retail_store`"
  dimensions:
    - name: "store_status"
      expr: store_status
      comment: "Current operational status of the store"
    - name: "store_format"
      expr: store_format
      comment: "Format classification of the store"
    - name: "store_tier"
      expr: store_tier
      comment: "Tier classification of the store"
    - name: "banner_name"
      expr: banner_name
      comment: "Banner name of the retail chain"
    - name: "country_code"
      expr: country_code
      comment: "Country code of the store location"
    - name: "state_province"
      expr: state_province
      comment: "State or province of the store location"
    - name: "city"
      expr: city
      comment: "City of the store location"
    - name: "trading_area"
      expr: trading_area
      comment: "Trading area classification"
    - name: "planogram_zone"
      expr: planogram_zone
      comment: "Planogram zone for the store"
    - name: "pos_system_type"
      expr: pos_system_type
      comment: "Point-of-sale system type"
    - name: "vmi_enabled_flag"
      expr: vmi_enabled_flag
      comment: "Whether vendor-managed inventory is enabled"
    - name: "open_year"
      expr: YEAR(open_date)
      comment: "Year the store opened"
  measures:
    - name: "total_stores"
      expr: COUNT(DISTINCT retail_store_id)
      comment: "Total number of unique retail stores"
    - name: "total_acv_weight"
      expr: SUM(CAST(acv_weight AS DOUBLE))
      comment: "Total ACV weight across all stores"
    - name: "total_tdp_weight"
      expr: SUM(CAST(tdp_weight AS DOUBLE))
      comment: "Total TDP weight across all stores"
    - name: "avg_acv_weight"
      expr: AVG(CAST(acv_weight AS DOUBLE))
      comment: "Average ACV weight per store"
    - name: "avg_tdp_weight"
      expr: AVG(CAST(tdp_weight AS DOUBLE))
      comment: "Average TDP weight per store"
    - name: "avg_osa_target"
      expr: AVG(CAST(osa_target_pct AS DOUBLE))
      comment: "Average on-shelf availability target percentage"
    - name: "avg_otif_sla_target"
      expr: AVG(CAST(otif_sla_target_pct AS DOUBLE))
      comment: "Average on-time-in-full SLA target percentage"
    - name: "vmi_enabled_stores"
      expr: COUNT(DISTINCT CASE WHEN vmi_enabled_flag = TRUE THEN retail_store_id END)
      comment: "Number of stores with VMI enabled"
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`sales_account_segment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Customer segmentation metrics including segment distribution, strategic priority, and channel mix"
  source: "`vibe_consumer_goods_v1`.`sales`.`account_segment`"
  dimensions:
    - name: "segment_code"
      expr: segment_code
      comment: "Segment code classification"
    - name: "segment_name"
      expr: segment_name
      comment: "Segment name classification"
    - name: "customer_tier"
      expr: customer_tier
      comment: "Customer tier classification"
    - name: "acv_tier"
      expr: acv_tier
      comment: "Annual customer value tier"
    - name: "channel_tier"
      expr: channel_tier
      comment: "Channel tier classification"
    - name: "primary_channel_code"
      expr: primary_channel_code
      comment: "Primary channel code"
    - name: "primary_channel_name"
      expr: primary_channel_name
      comment: "Primary channel name"
    - name: "strategic_priority_flag"
      expr: strategic_priority_flag
      comment: "Whether the account is a strategic priority"
    - name: "vmi_eligible_flag"
      expr: vmi_eligible_flag
      comment: "Whether the account is eligible for VMI"
    - name: "dsd_eligible_flag"
      expr: dsd_eligible_flag
      comment: "Whether the account is eligible for direct store delivery"
    - name: "edi_trading_partner_flag"
      expr: edi_trading_partner_flag
      comment: "Whether the account is an EDI trading partner"
    - name: "pricing_strategy"
      expr: pricing_strategy
      comment: "Pricing strategy for the segment"
  measures:
    - name: "total_account_segments"
      expr: COUNT(DISTINCT account_segment_id)
      comment: "Total number of unique account segment assignments"
    - name: "unique_accounts"
      expr: COUNT(DISTINCT trade_account_id)
      comment: "Total number of unique accounts with segment assignments"
    - name: "avg_otif_sla_target"
      expr: AVG(CAST(otif_sla_target_pct AS DOUBLE))
      comment: "Average on-time-in-full SLA target across segments"
    - name: "strategic_priority_accounts"
      expr: COUNT(DISTINCT CASE WHEN strategic_priority_flag = TRUE THEN account_segment_id END)
      comment: "Number of accounts flagged as strategic priority"
    - name: "vmi_eligible_accounts"
      expr: COUNT(DISTINCT CASE WHEN vmi_eligible_flag = TRUE THEN account_segment_id END)
      comment: "Number of accounts eligible for VMI"
    - name: "dsd_eligible_accounts"
      expr: COUNT(DISTINCT CASE WHEN dsd_eligible_flag = TRUE THEN account_segment_id END)
      comment: "Number of accounts eligible for direct store delivery"
    - name: "edi_trading_partner_accounts"
      expr: COUNT(DISTINCT CASE WHEN edi_trading_partner_flag = TRUE THEN account_segment_id END)
      comment: "Number of accounts that are EDI trading partners"
$$;