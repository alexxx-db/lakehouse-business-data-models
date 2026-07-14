-- Metric views for domain: returns | Business: Retail | Version: 2 | Generated on: 2026-07-12 15:23:39

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`returns_rma`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Return Merchandise Authorization (RMA) strategic KPIs tracking return authorization performance, refund efficiency, fraud exposure, and customer resolution outcomes"
  source: "`vibe_retail_v1`.`returns`.`rma`"
  dimensions:
    - name: "rma_status"
      expr: rma_status
      comment: "Current status of the RMA (e.g., pending, approved, closed) for tracking lifecycle stage"
    - name: "return_reason_code"
      expr: return_reason_code
      comment: "Standardized code indicating why the return was initiated (e.g., defect, wrong item, customer preference)"
    - name: "return_channel"
      expr: return_channel
      comment: "Channel through which the return was initiated (e.g., online, in-store, call center)"
    - name: "return_type"
      expr: return_type
      comment: "Type of return (e.g., refund, exchange, store credit)"
    - name: "refund_method"
      expr: refund_method
      comment: "Method used to process the refund (e.g., original payment, store credit, gift card)"
    - name: "is_fraudulent"
      expr: is_fraudulent
      comment: "Boolean flag indicating whether the RMA was flagged as fraudulent"
    - name: "authorization_month"
      expr: DATE_TRUNC('MONTH', authorization_date)
      comment: "Month when the RMA was authorized, for time-series analysis"
    - name: "authorization_quarter"
      expr: DATE_TRUNC('QUARTER', authorization_date)
      comment: "Quarter when the RMA was authorized, for quarterly business reviews"
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level assigned to the RMA (e.g., standard, expedited, urgent)"
    - name: "inspection_status"
      expr: inspection_status
      comment: "Status of the inspection process (e.g., pending, completed, failed)"
  measures:
    - name: "total_rma_count"
      expr: COUNT(1)
      comment: "Total number of RMAs processed, baseline volume metric for return activity"
    - name: "total_refund_amount"
      expr: SUM(CAST(refund_amount AS DOUBLE))
      comment: "Total dollar value of refunds issued, key financial impact metric"
    - name: "total_expected_return_value"
      expr: SUM(CAST(expected_return_value_amount AS DOUBLE))
      comment: "Total expected value of returned merchandise, for inventory and financial planning"
    - name: "total_restocking_fee_collected"
      expr: SUM(CAST(restocking_fee_amount AS DOUBLE))
      comment: "Total restocking fees collected, revenue recovery metric"
    - name: "total_return_shipping_cost"
      expr: SUM(CAST(return_shipping_cost AS DOUBLE))
      comment: "Total cost of return shipping, operational cost metric"
    - name: "total_store_credit_issued"
      expr: SUM(CAST(store_credit_issued_amount AS DOUBLE))
      comment: "Total store credit issued in lieu of refunds, customer retention metric"
    - name: "avg_refund_amount"
      expr: AVG(CAST(refund_amount AS DOUBLE))
      comment: "Average refund amount per RMA, unit economics metric"
    - name: "avg_fraud_score"
      expr: AVG(CAST(fraud_score AS DOUBLE))
      comment: "Average fraud risk score across RMAs, risk exposure metric"
    - name: "fraudulent_rma_count"
      expr: COUNT(CASE WHEN is_fraudulent = TRUE THEN 1 END)
      comment: "Count of RMAs flagged as fraudulent, fraud detection effectiveness metric"
    - name: "fraud_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_fraudulent = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of RMAs flagged as fraudulent, key risk KPI for steering fraud prevention investment"
    - name: "avg_restocking_fee_amount"
      expr: AVG(CAST(restocking_fee_amount AS DOUBLE))
      comment: "Average restocking fee per RMA, fee policy effectiveness metric"
    - name: "store_credit_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN store_credit_issued_amount > 0 THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of RMAs resolved with store credit, customer retention strategy metric"
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`returns_refund`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Refund transaction KPIs tracking refund processing efficiency, payment method mix, fraud exposure, and financial settlement performance"
  source: "`vibe_retail_v1`.`returns`.`refund`"
  dimensions:
    - name: "refund_status"
      expr: refund_status
      comment: "Current status of the refund (e.g., pending, approved, completed, failed)"
    - name: "refund_type"
      expr: refund_type
      comment: "Type of refund (e.g., full, partial, restocking-adjusted)"
    - name: "method"
      expr: method
      comment: "Refund method (e.g., original payment, store credit, check)"
    - name: "channel"
      expr: channel
      comment: "Channel through which the refund was processed (e.g., online, in-store, call center)"
    - name: "reason_code"
      expr: reason_code
      comment: "Reason code for the refund (e.g., defective product, customer dissatisfaction)"
    - name: "payment_processor"
      expr: payment_processor
      comment: "Payment processor handling the refund (e.g., Stripe, PayPal, internal)"
    - name: "is_fraudulent"
      expr: is_fraudulent
      comment: "Boolean flag indicating whether the refund was flagged as fraudulent"
    - name: "initiated_month"
      expr: DATE_TRUNC('MONTH', initiated_timestamp)
      comment: "Month when the refund was initiated, for time-series analysis"
    - name: "completed_month"
      expr: DATE_TRUNC('MONTH', completed_timestamp)
      comment: "Month when the refund was completed, for settlement analysis"
  measures:
    - name: "total_refund_count"
      expr: COUNT(1)
      comment: "Total number of refund transactions, baseline volume metric"
    - name: "total_refund_amount"
      expr: SUM(CAST(total_refund_amount AS DOUBLE))
      comment: "Total dollar value of all refunds, key financial impact metric"
    - name: "total_merchandise_amount"
      expr: SUM(CAST(merchandise_amount AS DOUBLE))
      comment: "Total merchandise value refunded, product return cost metric"
    - name: "total_tax_refunded"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount refunded, tax liability metric"
    - name: "total_shipping_refunded"
      expr: SUM(CAST(shipping_amount AS DOUBLE))
      comment: "Total shipping cost refunded, logistics cost recovery metric"
    - name: "total_restocking_fee_collected"
      expr: SUM(CAST(restocking_fee AS DOUBLE))
      comment: "Total restocking fees collected, revenue recovery metric"
    - name: "total_adjustment_amount"
      expr: SUM(CAST(adjustment_amount AS DOUBLE))
      comment: "Total adjustment amount applied to refunds, pricing correction metric"
    - name: "avg_refund_amount"
      expr: AVG(CAST(total_refund_amount AS DOUBLE))
      comment: "Average refund amount per transaction, unit economics metric"
    - name: "avg_fraud_score"
      expr: AVG(CAST(fraud_score AS DOUBLE))
      comment: "Average fraud risk score across refunds, risk exposure metric"
    - name: "fraudulent_refund_count"
      expr: COUNT(CASE WHEN is_fraudulent = TRUE THEN 1 END)
      comment: "Count of refunds flagged as fraudulent, fraud detection effectiveness metric"
    - name: "fraud_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_fraudulent = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of refunds flagged as fraudulent, key risk KPI for steering fraud prevention investment"
    - name: "completed_refund_count"
      expr: COUNT(CASE WHEN refund_status = 'completed' THEN 1 END)
      comment: "Count of successfully completed refunds, processing success metric"
    - name: "completion_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN refund_status = 'completed' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of refunds successfully completed, operational efficiency KPI"
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`returns_rma_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "RMA line-item KPIs tracking SKU-level return performance, disposition outcomes, vendor credit recovery, and restocking efficiency"
  source: "`vibe_retail_v1`.`returns`.`rma_line`"
  dimensions:
    - name: "line_status"
      expr: line_status
      comment: "Status of the RMA line item (e.g., pending, received, disposed)"
    - name: "disposition_code"
      expr: disposition_code
      comment: "Disposition decision for the returned item (e.g., restock, liquidate, scrap, RTV)"
    - name: "condition_code"
      expr: condition_code
      comment: "Condition assessment of the returned item (e.g., new, damaged, defective)"
    - name: "return_reason_code"
      expr: return_reason_code
      comment: "Reason code for the return at line level (e.g., defect, wrong item, customer preference)"
    - name: "restocking_eligible_flag"
      expr: restocking_eligible_flag
      comment: "Boolean flag indicating whether the item is eligible for restocking"
    - name: "inspection_month"
      expr: DATE_TRUNC('MONTH', inspection_date)
      comment: "Month when the item was inspected, for time-series analysis"
  measures:
    - name: "total_line_count"
      expr: COUNT(1)
      comment: "Total number of RMA line items, baseline volume metric"
    - name: "total_extended_cost"
      expr: SUM(CAST(extended_cost_amount AS DOUBLE))
      comment: "Total cost value of returned items, inventory cost impact metric"
    - name: "total_extended_retail"
      expr: SUM(CAST(extended_retail_amount AS DOUBLE))
      comment: "Total retail value of returned items, revenue impact metric"
    - name: "total_refund_amount"
      expr: SUM(CAST(refund_amount AS DOUBLE))
      comment: "Total refund amount at line level, financial impact metric"
    - name: "total_vendor_credit"
      expr: SUM(CAST(vendor_credit_amount AS DOUBLE))
      comment: "Total vendor credit recovered, supplier cost recovery metric"
    - name: "total_liquidation_sale_amount"
      expr: SUM(CAST(liquidation_sale_amount AS DOUBLE))
      comment: "Total revenue from liquidation sales, secondary market recovery metric"
    - name: "total_restocking_fee_collected"
      expr: SUM(CAST(restocking_fee_amount AS DOUBLE))
      comment: "Total restocking fees collected at line level, revenue recovery metric"
    - name: "avg_unit_cost"
      expr: AVG(CAST(unit_cost AS DOUBLE))
      comment: "Average unit cost of returned items, cost per return metric"
    - name: "restocking_eligible_count"
      expr: COUNT(CASE WHEN restocking_eligible_flag = TRUE THEN 1 END)
      comment: "Count of items eligible for restocking, inventory recovery potential metric"
    - name: "restocking_eligible_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN restocking_eligible_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of returned items eligible for restocking, inventory recovery efficiency KPI"
    - name: "vendor_credit_recovery_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(vendor_credit_amount AS DOUBLE)) / NULLIF(SUM(CAST(extended_cost_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of cost recovered through vendor credits, supplier accountability KPI"
    - name: "liquidation_recovery_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(liquidation_sale_amount AS DOUBLE)) / NULLIF(SUM(CAST(extended_retail_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of retail value recovered through liquidation, secondary market efficiency KPI"
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`returns_disposition`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Disposition decision KPIs tracking returned inventory outcomes, recovery value realization, restocking efficiency, and liquidation performance"
  source: "`vibe_retail_v1`.`returns`.`disposition`"
  dimensions:
    - name: "disposition_type"
      expr: disposition_type
      comment: "Type of disposition decision (e.g., restock, liquidate, scrap, RTV, donate)"
    - name: "disposition_status"
      expr: disposition_status
      comment: "Current status of the disposition (e.g., pending, in-progress, completed)"
    - name: "condition_grade"
      expr: condition_grade
      comment: "Condition grade assigned to the returned item (e.g., A, B, C, D)"
    - name: "defect_code"
      expr: defect_code
      comment: "Code identifying the defect or issue with the returned item"
    - name: "reason_code"
      expr: reason_code
      comment: "Reason code for the disposition decision"
    - name: "restocking_fee_applied"
      expr: restocking_fee_applied
      comment: "Boolean flag indicating whether a restocking fee was applied"
    - name: "is_hazmat"
      expr: is_hazmat
      comment: "Boolean flag indicating whether the item is hazardous material"
    - name: "decision_month"
      expr: DATE_TRUNC('MONTH', decision_date)
      comment: "Month when the disposition decision was made, for time-series analysis"
    - name: "completion_month"
      expr: DATE_TRUNC('MONTH', completion_date)
      comment: "Month when the disposition was completed, for cycle time analysis"
  measures:
    - name: "total_disposition_count"
      expr: COUNT(1)
      comment: "Total number of disposition decisions, baseline volume metric"
    - name: "total_estimated_recovery_value"
      expr: SUM(CAST(estimated_recovery_value AS DOUBLE))
      comment: "Total estimated recovery value of disposed items, planning metric"
    - name: "total_actual_recovery_value"
      expr: SUM(CAST(actual_recovery_value AS DOUBLE))
      comment: "Total actual recovery value realized, financial performance metric"
    - name: "total_restocking_fee_collected"
      expr: SUM(CAST(restocking_fee_amount AS DOUBLE))
      comment: "Total restocking fees collected, revenue recovery metric"
    - name: "avg_estimated_recovery_value"
      expr: AVG(CAST(estimated_recovery_value AS DOUBLE))
      comment: "Average estimated recovery value per item, unit economics metric"
    - name: "avg_actual_recovery_value"
      expr: AVG(CAST(actual_recovery_value AS DOUBLE))
      comment: "Average actual recovery value per item, realized unit economics metric"
    - name: "recovery_realization_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(actual_recovery_value AS DOUBLE)) / NULLIF(SUM(CAST(estimated_recovery_value AS DOUBLE)), 0), 2)
      comment: "Percentage of estimated recovery value actually realized, disposition accuracy and execution KPI"
    - name: "restocking_fee_applied_count"
      expr: COUNT(CASE WHEN restocking_fee_applied = TRUE THEN 1 END)
      comment: "Count of dispositions where restocking fee was applied, fee policy application metric"
    - name: "restocking_fee_application_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN restocking_fee_applied = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of dispositions with restocking fee applied, fee policy effectiveness KPI"
    - name: "hazmat_disposition_count"
      expr: COUNT(CASE WHEN is_hazmat = TRUE THEN 1 END)
      comment: "Count of hazardous material dispositions, compliance and safety metric"
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`returns_return_request`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Return request KPIs tracking customer return initiation, approval rates, fraud risk, SLA compliance, and resolution type mix"
  source: "`vibe_retail_v1`.`returns`.`return_request`"
  dimensions:
    - name: "request_status"
      expr: request_status
      comment: "Current status of the return request (e.g., pending, approved, denied, expired)"
    - name: "return_reason_code"
      expr: return_reason_code
      comment: "Reason code for the return request (e.g., defect, wrong item, customer preference)"
    - name: "request_channel"
      expr: request_channel
      comment: "Channel through which the return request was submitted (e.g., web, mobile, call center)"
    - name: "return_method"
      expr: return_method
      comment: "Method for returning the item (e.g., ship, drop-off, pickup)"
    - name: "preferred_resolution_type"
      expr: preferred_resolution_type
      comment: "Customer's preferred resolution (e.g., refund, exchange, store credit)"
    - name: "fraud_flag"
      expr: fraud_flag
      comment: "Boolean flag indicating whether the request was flagged for fraud"
    - name: "is_within_return_window"
      expr: is_within_return_window
      comment: "Boolean flag indicating whether the request was made within the return policy window"
    - name: "pickup_requested_flag"
      expr: pickup_requested_flag
      comment: "Boolean flag indicating whether customer requested pickup service"
    - name: "request_month"
      expr: DATE_TRUNC('MONTH', request_timestamp)
      comment: "Month when the return request was submitted, for time-series analysis"
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level assigned to the return request (e.g., standard, expedited, urgent)"
  measures:
    - name: "total_request_count"
      expr: COUNT(1)
      comment: "Total number of return requests, baseline volume metric"
    - name: "total_estimated_refund_amount"
      expr: SUM(CAST(estimated_refund_amount AS DOUBLE))
      comment: "Total estimated refund amount for all requests, financial exposure metric"
    - name: "avg_estimated_refund_amount"
      expr: AVG(CAST(estimated_refund_amount AS DOUBLE))
      comment: "Average estimated refund amount per request, unit economics metric"
    - name: "avg_fraud_risk_score"
      expr: AVG(CAST(fraud_risk_score AS DOUBLE))
      comment: "Average fraud risk score across requests, risk exposure metric"
    - name: "approved_request_count"
      expr: COUNT(CASE WHEN request_status = 'approved' THEN 1 END)
      comment: "Count of approved return requests, approval volume metric"
    - name: "denied_request_count"
      expr: COUNT(CASE WHEN request_status = 'denied' THEN 1 END)
      comment: "Count of denied return requests, denial volume metric"
    - name: "approval_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN request_status = 'approved' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of return requests approved, customer service policy effectiveness KPI"
    - name: "fraud_flagged_count"
      expr: COUNT(CASE WHEN fraud_flag = TRUE THEN 1 END)
      comment: "Count of requests flagged for fraud, fraud detection volume metric"
    - name: "fraud_flag_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN fraud_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of requests flagged for fraud, fraud risk exposure KPI"
    - name: "within_window_count"
      expr: COUNT(CASE WHEN is_within_return_window = TRUE THEN 1 END)
      comment: "Count of requests made within return policy window, policy compliance metric"
    - name: "within_window_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_within_return_window = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of requests within return window, policy compliance KPI"
    - name: "pickup_requested_count"
      expr: COUNT(CASE WHEN pickup_requested_flag = TRUE THEN 1 END)
      comment: "Count of requests with pickup service requested, logistics demand metric"
    - name: "pickup_request_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN pickup_requested_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of requests with pickup service, customer convenience preference KPI"
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`returns_store_credit`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Store credit KPIs tracking credit issuance, redemption, expiration, and customer retention value"
  source: "`vibe_retail_v1`.`returns`.`store_credit`"
  dimensions:
    - name: "store_credit_status"
      expr: store_credit_status
      comment: "Current status of the store credit (e.g., active, redeemed, expired, voided)"
    - name: "credit_type"
      expr: credit_type
      comment: "Type of store credit (e.g., return credit, promotional credit, compensation)"
    - name: "issuing_channel"
      expr: issuing_channel
      comment: "Channel through which the store credit was issued (e.g., online, in-store, call center)"
    - name: "transferable_flag"
      expr: transferable_flag
      comment: "Boolean flag indicating whether the store credit is transferable"
    - name: "combinable_with_promotions_flag"
      expr: combinable_with_promotions_flag
      comment: "Boolean flag indicating whether the credit can be combined with promotions"
    - name: "escheatment_eligible_flag"
      expr: escheatment_eligible_flag
      comment: "Boolean flag indicating whether the credit is eligible for escheatment"
    - name: "issue_month"
      expr: DATE_TRUNC('MONTH', issue_date)
      comment: "Month when the store credit was issued, for time-series analysis"
    - name: "expiration_month"
      expr: DATE_TRUNC('MONTH', expiration_date)
      comment: "Month when the store credit expires, for liability forecasting"
  measures:
    - name: "total_credit_count"
      expr: COUNT(1)
      comment: "Total number of store credits issued, baseline volume metric"
    - name: "total_issued_amount"
      expr: SUM(CAST(issued_amount AS DOUBLE))
      comment: "Total dollar value of store credits issued, financial liability metric"
    - name: "total_remaining_balance"
      expr: SUM(CAST(remaining_balance AS DOUBLE))
      comment: "Total outstanding store credit balance, current liability metric"
    - name: "total_redeemed_amount"
      expr: SUM((CAST(issued_amount AS DOUBLE)) - (CAST(remaining_balance AS DOUBLE)))
      comment: "Total store credit value redeemed, customer retention value realized metric"
    - name: "avg_issued_amount"
      expr: AVG(CAST(issued_amount AS DOUBLE))
      comment: "Average store credit amount issued, unit economics metric"
    - name: "avg_remaining_balance"
      expr: AVG(CAST(remaining_balance AS DOUBLE))
      comment: "Average outstanding balance per credit, breakage potential metric"
    - name: "active_credit_count"
      expr: COUNT(CASE WHEN store_credit_status = 'active' THEN 1 END)
      comment: "Count of active store credits, current liability volume metric"
    - name: "redeemed_credit_count"
      expr: COUNT(CASE WHEN store_credit_status = 'redeemed' THEN 1 END)
      comment: "Count of fully redeemed store credits, customer retention success metric"
    - name: "expired_credit_count"
      expr: COUNT(CASE WHEN store_credit_status = 'expired' THEN 1 END)
      comment: "Count of expired store credits, breakage realization metric"
    - name: "redemption_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN store_credit_status = 'redeemed' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of store credits fully redeemed, customer retention effectiveness KPI"
    - name: "expiration_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN store_credit_status = 'expired' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of store credits expired, breakage rate KPI for financial planning"
    - name: "utilization_rate_pct"
      expr: ROUND(100.0 * (SUM(CAST(issued_amount AS DOUBLE)) - SUM(CAST(remaining_balance AS DOUBLE))) / NULLIF(SUM(CAST(issued_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of issued store credit value redeemed, overall utilization and customer engagement KPI"
$$;