-- Metric views for domain: returns | Business: Retail | Version: 2 | Generated on: 2026-07-12 14:06:09

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`returns_rma`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core return merchandise authorization metrics tracking return volume, financial exposure, fraud risk, and resolution efficiency across all return channels and types."
  source: "`vibe_retail_v1`.`returns`.`rma`"
  dimensions:
    - name: "return_channel"
      expr: return_channel
      comment: "Channel through which the return was initiated (e.g. in-store, online, mobile), used to analyze return patterns by originating channel."
    - name: "return_type"
      expr: return_type
      comment: "Classification of the return (e.g. standard, exchange, warranty), enabling segmentation of return volume by type."
    - name: "return_reason_code"
      expr: return_reason_code
      comment: "Standardized reason code for the return, used to identify top return drivers and inform product quality or merchandising decisions."
    - name: "rma_status"
      expr: rma_status
      comment: "Current lifecycle status of the RMA (e.g. open, closed, pending inspection), used to monitor pipeline health and SLA compliance."
    - name: "refund_method"
      expr: refund_method
      comment: "Method by which the refund was issued (e.g. original payment, store credit, gift card), used to analyze refund liability by method."
    - name: "disposition_code"
      expr: disposition_code
      comment: "Outcome assigned to the returned item (e.g. restock, liquidate, destroy), used to track recovery strategy distribution."
    - name: "priority_level"
      expr: priority_level
      comment: "Priority assigned to the RMA for processing, used to assess workload distribution and SLA adherence by priority tier."
    - name: "authorization_date"
      expr: DATE_TRUNC('month', authorization_date)
      comment: "Month of RMA authorization, used for trend analysis of return volumes over time."
    - name: "is_fraudulent"
      expr: is_fraudulent
      comment: "Flag indicating whether the RMA was identified as fraudulent, used to segment legitimate vs. fraudulent return activity."
    - name: "inspection_status"
      expr: inspection_status
      comment: "Status of the physical inspection of returned goods, used to monitor inspection throughput and backlog."
  measures:
    - name: "total_rma_count"
      expr: COUNT(1)
      comment: "Total number of RMAs created. Baseline volume metric used to track return rate trends and operational workload."
    - name: "total_refund_amount"
      expr: SUM(CAST(refund_amount AS DOUBLE))
      comment: "Total monetary value of refunds issued across all RMAs. Directly impacts gross margin and cash flow; a key financial exposure metric."
    - name: "avg_refund_amount"
      expr: AVG(CAST(refund_amount AS DOUBLE))
      comment: "Average refund value per RMA. Used to benchmark refund size and detect anomalies indicating policy abuse or fraud."
    - name: "total_restocking_fee_collected"
      expr: SUM(CAST(restocking_fee_amount AS DOUBLE))
      comment: "Total restocking fees collected across all RMAs. Measures cost recovery from returns and effectiveness of restocking fee policy."
    - name: "total_return_shipping_cost"
      expr: SUM(CAST(return_shipping_cost AS DOUBLE))
      comment: "Total cost of return shipping borne by the retailer. A direct operational cost driver for the returns program."
    - name: "total_store_credit_issued"
      expr: SUM(CAST(store_credit_issued_amount AS DOUBLE))
      comment: "Total store credit issued in lieu of cash refunds. Tracks liability on the balance sheet and customer retention via credit issuance."
    - name: "avg_fraud_score"
      expr: AVG(CAST(fraud_score AS DOUBLE))
      comment: "Average fraud risk score across RMAs. Elevated averages signal systemic return fraud risk requiring investigation or policy tightening."
    - name: "fraudulent_rma_count"
      expr: COUNT(CASE WHEN is_fraudulent = TRUE THEN 1 END)
      comment: "Number of RMAs flagged as fraudulent. Directly informs loss prevention strategy and fraud detection model performance."
    - name: "total_expected_return_value"
      expr: SUM(CAST(expected_return_value_amount AS DOUBLE))
      comment: "Total expected recovery value from all open and closed RMAs. Used to forecast returns-related financial exposure."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`returns_refund`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Financial metrics for customer refunds, covering refund volume, amounts, fraud exposure, and settlement efficiency to support P&L management and fraud control."
  source: "`vibe_retail_v1`.`returns`.`refund`"
  dimensions:
    - name: "refund_status"
      expr: refund_status
      comment: "Current processing status of the refund (e.g. pending, completed, failed), used to monitor refund pipeline and identify settlement delays."
    - name: "refund_type"
      expr: refund_type
      comment: "Classification of the refund (e.g. full, partial, exchange differential), used to analyze refund composition and financial impact."
    - name: "method"
      expr: method
      comment: "Payment method used for the refund (e.g. original tender, store credit), used to assess refund liability by tender type."
    - name: "channel"
      expr: channel
      comment: "Channel through which the refund was processed (e.g. in-store, online), used to attribute refund costs to originating channels."
    - name: "reason_code"
      expr: reason_code
      comment: "Standardized reason code for the refund, used to identify top refund drivers and inform root-cause analysis."
    - name: "is_fraudulent"
      expr: is_fraudulent
      comment: "Flag indicating whether the refund was identified as fraudulent, used to segment legitimate vs. fraudulent refund activity."
    - name: "created_month"
      expr: DATE_TRUNC('month', created_timestamp)
      comment: "Month the refund record was created, used for trend analysis of refund volumes and amounts over time."
    - name: "actual_settlement_date"
      expr: DATE_TRUNC('month', actual_settlement_date)
      comment: "Month of actual refund settlement, used to analyze settlement cycle times and cash outflow timing."
  measures:
    - name: "total_refund_count"
      expr: COUNT(1)
      comment: "Total number of refund transactions processed. Baseline volume metric for returns financial operations."
    - name: "total_refund_amount"
      expr: SUM(CAST(total_refund_amount AS DOUBLE))
      comment: "Total gross refund value issued to customers. Primary financial exposure metric for the returns program; directly impacts net revenue."
    - name: "total_merchandise_refund_amount"
      expr: SUM(CAST(merchandise_amount AS DOUBLE))
      comment: "Total merchandise component of refunds. Used to separate product cost recovery from shipping and tax components in P&L analysis."
    - name: "total_tax_refunded"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount refunded to customers. Required for tax liability reconciliation and regulatory reporting."
    - name: "total_shipping_refunded"
      expr: SUM(CAST(shipping_amount AS DOUBLE))
      comment: "Total shipping costs refunded to customers. Measures the cost of free-return policies on operational margins."
    - name: "total_restocking_fee_collected"
      expr: SUM(CAST(restocking_fee AS DOUBLE))
      comment: "Total restocking fees collected, partially offsetting refund costs. Measures effectiveness of cost-recovery policies."
    - name: "total_adjustment_amount"
      expr: SUM(CAST(adjustment_amount AS DOUBLE))
      comment: "Total post-refund adjustments applied. Tracks correction activity and potential reconciliation issues in the refund process."
    - name: "avg_fraud_score"
      expr: AVG(CAST(fraud_score AS DOUBLE))
      comment: "Average fraud risk score across refund transactions. Rising averages indicate increased systemic fraud risk requiring intervention."
    - name: "fraudulent_refund_count"
      expr: COUNT(CASE WHEN is_fraudulent = TRUE THEN 1 END)
      comment: "Number of refunds flagged as fraudulent. Core loss prevention KPI used to quantify fraud exposure and measure detection effectiveness."
    - name: "fraudulent_refund_amount"
      expr: SUM(CASE WHEN is_fraudulent = TRUE THEN CAST(total_refund_amount AS DOUBLE) ELSE 0 END)
      comment: "Total monetary value of fraudulent refunds. Quantifies financial loss from return fraud, informing investment in fraud prevention."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`returns_disposition`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Metrics tracking the financial recovery and operational outcomes of returned item dispositions, including recovery rates, restocking fees, and hazmat handling."
  source: "`vibe_retail_v1`.`returns`.`disposition`"
  dimensions:
    - name: "disposition_type"
      expr: disposition_type
      comment: "Type of disposition applied to the returned item (e.g. restock, liquidate, destroy, donate), used to analyze recovery strategy mix."
    - name: "disposition_status"
      expr: disposition_status
      comment: "Current status of the disposition process, used to monitor pipeline throughput and identify bottlenecks."
    - name: "condition_grade"
      expr: condition_grade
      comment: "Condition grade assigned to the returned item (e.g. A, B, C), used to correlate item condition with recovery value and disposition type."
    - name: "reason_code"
      expr: reason_code
      comment: "Return reason code associated with the disposition, used to link recovery outcomes back to return root causes."
    - name: "defect_code"
      expr: defect_code
      comment: "Defect classification code for the returned item, used to identify product quality issues driving disposition decisions."
    - name: "is_hazmat"
      expr: is_hazmat
      comment: "Flag indicating whether the item requires hazardous materials handling, used to track compliance costs and volumes."
    - name: "decision_date"
      expr: DATE_TRUNC('month', decision_date)
      comment: "Month the disposition decision was made, used for trend analysis of disposition volumes and recovery values over time."
    - name: "restocking_fee_applied"
      expr: restocking_fee_applied
      comment: "Flag indicating whether a restocking fee was applied, used to measure policy adherence and fee collection rates."
  measures:
    - name: "total_disposition_count"
      expr: COUNT(1)
      comment: "Total number of disposition decisions made. Baseline operational throughput metric for the returns processing function."
    - name: "total_actual_recovery_value"
      expr: SUM(CAST(actual_recovery_value AS DOUBLE))
      comment: "Total actual monetary value recovered from disposed items. Primary financial outcome metric for the disposition process."
    - name: "total_estimated_recovery_value"
      expr: SUM(CAST(estimated_recovery_value AS DOUBLE))
      comment: "Total estimated recovery value at time of disposition decision. Used to benchmark forecast accuracy against actual recovery."
    - name: "total_restocking_fee_amount"
      expr: SUM(CAST(restocking_fee_amount AS DOUBLE))
      comment: "Total restocking fees collected during disposition. Measures cost recovery contribution from the restocking fee policy."
    - name: "avg_actual_recovery_value"
      expr: AVG(CAST(actual_recovery_value AS DOUBLE))
      comment: "Average recovery value per disposed item. Used to benchmark disposition efficiency and compare recovery across condition grades."
    - name: "recovery_variance"
      expr: SUM(CAST(actual_recovery_value AS DOUBLE) - CAST(estimated_recovery_value AS DOUBLE))
      comment: "Total variance between actual and estimated recovery values. Negative variance indicates systematic over-estimation of recovery, impacting financial planning accuracy."
    - name: "hazmat_disposition_count"
      expr: COUNT(CASE WHEN is_hazmat = TRUE THEN 1 END)
      comment: "Number of dispositions involving hazardous materials. Tracks compliance exposure and associated handling costs."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`returns_liquidation_batch`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Metrics for liquidation batch performance, measuring recovery rates, net proceeds, and operational efficiency of bulk liquidation activities."
  source: "`vibe_retail_v1`.`returns`.`liquidation_batch`"
  dimensions:
    - name: "batch_status"
      expr: batch_status
      comment: "Current status of the liquidation batch (e.g. pending, sold, settled, cancelled), used to monitor pipeline and settlement timing."
    - name: "liquidation_channel"
      expr: liquidation_channel
      comment: "Channel through which the batch was liquidated (e.g. auction, wholesale, online marketplace), used to compare recovery rates by channel."
    - name: "is_hazmat"
      expr: is_hazmat
      comment: "Flag indicating whether the batch contains hazardous materials, used to track compliance costs and channel restrictions."
    - name: "requires_data_destruction"
      expr: requires_data_destruction
      comment: "Flag indicating whether items in the batch require data destruction (e.g. electronics), used to track compliance handling costs."
    - name: "sale_date"
      expr: DATE_TRUNC('month', sale_date)
      comment: "Month of liquidation sale, used for trend analysis of liquidation volumes and recovery rates over time."
    - name: "batch_creation_date"
      expr: DATE_TRUNC('month', batch_creation_date)
      comment: "Month the liquidation batch was created, used to analyze batch aging and time-to-sale cycle times."
  measures:
    - name: "total_batch_count"
      expr: COUNT(1)
      comment: "Total number of liquidation batches processed. Baseline volume metric for liquidation program activity."
    - name: "total_net_recovery_amount"
      expr: SUM(CAST(net_recovery_amount AS DOUBLE))
      comment: "Total net proceeds from liquidation after fees and costs. Primary financial outcome metric for the liquidation program."
    - name: "total_final_sale_price"
      expr: SUM(CAST(final_sale_price AS DOUBLE))
      comment: "Total gross sale price achieved across all liquidation batches. Used to measure gross liquidation revenue before deducting fees."
    - name: "total_cost_value"
      expr: SUM(CAST(total_cost_value AS DOUBLE))
      comment: "Total book cost value of items liquidated. Used as the denominator for recovery rate calculations and write-off analysis."
    - name: "total_liquidation_fees"
      expr: SUM(CAST(liquidation_fees AS DOUBLE))
      comment: "Total fees paid to liquidation partners. Measures the cost of the liquidation channel and informs partner contract negotiations."
    - name: "total_transportation_cost"
      expr: SUM(CAST(transportation_cost AS DOUBLE))
      comment: "Total transportation costs incurred for liquidation shipments. A direct operational cost component of the liquidation program."
    - name: "total_tax_write_off_amount"
      expr: SUM(CAST(tax_write_off_amount AS DOUBLE))
      comment: "Total tax write-off value from liquidated inventory. Tracks the tax benefit realized from inventory disposition decisions."
    - name: "avg_recovery_rate_percent"
      expr: AVG(CAST(recovery_rate_percent AS DOUBLE))
      comment: "Average recovery rate (as % of cost) across liquidation batches. Key efficiency KPI for the liquidation program; benchmarks channel and partner performance."
    - name: "total_reserve_price"
      expr: SUM(CAST(reserve_price AS DOUBLE))
      comment: "Total reserve price set across all batches. Used to compare reserve pricing strategy against actual sale prices achieved."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`returns_liquidation_item`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Item-level liquidation metrics measuring recovery value, loss amounts, and recovery rates by SKU, condition grade, and category to optimize liquidation strategy."
  source: "`vibe_retail_v1`.`returns`.`liquidation_item`"
  dimensions:
    - name: "condition_grade"
      expr: condition_grade
      comment: "Condition grade of the liquidated item (e.g. A, B, C), used to analyze how item condition drives recovery value and channel selection."
    - name: "liquidation_channel"
      expr: liquidation_channel
      comment: "Channel through which the item was liquidated, used to compare per-unit recovery rates across liquidation channels."
    - name: "category_code"
      expr: category_code
      comment: "Product category of the liquidated item, used to identify categories with highest liquidation losses and inform buying decisions."
    - name: "return_reason_code"
      expr: return_reason_code
      comment: "Return reason code for the item, used to link liquidation losses back to specific return causes."
    - name: "disposition_code"
      expr: disposition_code
      comment: "Disposition outcome code for the item, used to analyze recovery value by disposition type at item level."
    - name: "created_month"
      expr: DATE_TRUNC('month', created_timestamp)
      comment: "Month the liquidation item record was created, used for trend analysis of item-level liquidation activity."
  measures:
    - name: "total_item_count"
      expr: COUNT(1)
      comment: "Total number of liquidation item lines processed. Baseline volume metric for item-level liquidation activity."
    - name: "total_actual_recovery_value"
      expr: SUM(CAST(actual_total_recovery_value AS DOUBLE))
      comment: "Total actual recovery value achieved across all liquidation items. Primary financial outcome metric at item level."
    - name: "total_estimated_recovery_value"
      expr: SUM(CAST(estimated_total_recovery_value AS DOUBLE))
      comment: "Total estimated recovery value for liquidation items. Used to measure forecast accuracy and identify systematic valuation biases."
    - name: "total_loss_amount"
      expr: SUM(CAST(loss_amount AS DOUBLE))
      comment: "Total financial loss from liquidation items (cost minus recovery). Quantifies the P&L impact of the liquidation program."
    - name: "avg_recovery_rate_percent"
      expr: AVG(CAST(recovery_rate_percent AS DOUBLE))
      comment: "Average recovery rate per item as a percentage of cost. Used to benchmark item-level liquidation efficiency by category and condition."
    - name: "avg_actual_recovery_per_unit"
      expr: AVG(CAST(actual_recovery_value_per_unit AS DOUBLE))
      comment: "Average actual recovery value per unit. Used to set pricing benchmarks and evaluate liquidation partner performance at unit level."
    - name: "recovery_value_variance"
      expr: SUM(CAST(actual_total_recovery_value AS DOUBLE) - CAST(estimated_total_recovery_value AS DOUBLE))
      comment: "Total variance between actual and estimated recovery values at item level. Negative variance signals over-optimistic valuation models."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`returns_return_request`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Metrics for customer return requests covering request volumes, approval rates, fraud risk, and estimated refund exposure to manage return policy effectiveness."
  source: "`vibe_retail_v1`.`returns`.`return_request`"
  dimensions:
    - name: "request_status"
      expr: request_status
      comment: "Current status of the return request (e.g. pending, approved, denied, cancelled), used to monitor approval pipeline and denial rates."
    - name: "request_channel"
      expr: request_channel
      comment: "Channel through which the return request was submitted (e.g. in-store, online, call center), used to analyze return initiation patterns."
    - name: "return_reason_code"
      expr: return_reason_code
      comment: "Standardized reason code for the return request, used to identify top return drivers and inform product quality decisions."
    - name: "preferred_resolution_type"
      expr: preferred_resolution_type
      comment: "Customer's preferred resolution (e.g. refund, exchange, store credit), used to align resolution capacity with customer demand."
    - name: "return_method"
      expr: return_method
      comment: "Method by which the customer intends to return the item (e.g. mail, in-store drop-off), used to plan logistics capacity."
    - name: "priority_level"
      expr: priority_level
      comment: "Priority assigned to the return request, used to assess SLA compliance by priority tier."
    - name: "fraud_flag"
      expr: fraud_flag
      comment: "Flag indicating whether the return request was flagged for potential fraud, used to segment high-risk requests for review."
    - name: "is_within_return_window"
      expr: is_within_return_window
      comment: "Flag indicating whether the request was submitted within the eligible return window, used to measure policy compliance rates."
    - name: "request_month"
      expr: DATE_TRUNC('month', request_timestamp)
      comment: "Month the return request was submitted, used for trend analysis of return request volumes over time."
  measures:
    - name: "total_request_count"
      expr: COUNT(1)
      comment: "Total number of return requests submitted. Baseline volume metric for return demand and policy utilization."
    - name: "approved_request_count"
      expr: COUNT(CASE WHEN request_status = 'approved' THEN 1 END)
      comment: "Number of return requests approved. Used with total count to calculate approval rate and assess policy stringency."
    - name: "denied_request_count"
      expr: COUNT(CASE WHEN request_status = 'denied' THEN 1 END)
      comment: "Number of return requests denied. Tracks denial rate and informs policy calibration to balance customer experience with loss prevention."
    - name: "fraud_flagged_request_count"
      expr: COUNT(CASE WHEN fraud_flag = TRUE THEN 1 END)
      comment: "Number of return requests flagged for potential fraud. Key loss prevention metric for monitoring fraud detection model performance."
    - name: "total_estimated_refund_amount"
      expr: SUM(CAST(estimated_refund_amount AS DOUBLE))
      comment: "Total estimated refund value across all return requests. Used to forecast refund liability and cash flow impact."
    - name: "avg_fraud_risk_score"
      expr: AVG(CAST(fraud_risk_score AS DOUBLE))
      comment: "Average fraud risk score across return requests. Elevated averages signal increased systemic fraud risk requiring policy or detection model adjustments."
    - name: "out_of_window_request_count"
      expr: COUNT(CASE WHEN is_within_return_window = FALSE THEN 1 END)
      comment: "Number of return requests submitted outside the eligible return window. Tracks policy exception volume and associated financial exposure."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`returns_return_fraud_case`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Metrics for return fraud investigation cases, measuring fraud exposure, recovery rates, and investigation outcomes to support loss prevention strategy."
  source: "`vibe_retail_v1`.`returns`.`return_fraud_case`"
  dimensions:
    - name: "case_status"
      expr: case_status
      comment: "Current status of the fraud case (e.g. open, closed, escalated), used to monitor investigation pipeline and resolution rates."
    - name: "fraud_typology"
      expr: fraud_typology
      comment: "Classification of the fraud type (e.g. receipt fraud, wardrobing, organized retail crime), used to identify dominant fraud patterns."
    - name: "detection_method"
      expr: detection_method
      comment: "Method by which the fraud was detected (e.g. system alert, associate observation, third-party service), used to evaluate detection channel effectiveness."
    - name: "investigation_outcome"
      expr: investigation_outcome
      comment: "Outcome of the fraud investigation (e.g. confirmed, unsubstantiated, referred to law enforcement), used to measure investigation quality."
    - name: "investigation_priority"
      expr: investigation_priority
      comment: "Priority level assigned to the fraud investigation, used to assess resource allocation and SLA compliance by priority."
    - name: "recovery_status"
      expr: recovery_status
      comment: "Status of financial recovery efforts for the fraud case, used to track civil recovery program effectiveness."
    - name: "case_opened_month"
      expr: DATE_TRUNC('month', case_opened_timestamp)
      comment: "Month the fraud case was opened, used for trend analysis of fraud case volumes over time."
  measures:
    - name: "total_fraud_case_count"
      expr: COUNT(1)
      comment: "Total number of return fraud cases opened. Baseline metric for fraud program activity and loss prevention workload."
    - name: "total_estimated_fraud_value"
      expr: SUM(CAST(estimated_fraud_value_amount AS DOUBLE))
      comment: "Total estimated financial value of fraud across all cases. Primary metric for quantifying return fraud exposure and informing investment in prevention."
    - name: "total_civil_recovery_amount"
      expr: SUM(CAST(civil_recovery_amount AS DOUBLE))
      comment: "Total amount recovered through civil recovery actions. Measures the financial effectiveness of the civil recovery program."
    - name: "avg_fraud_score"
      expr: AVG(CAST(fraud_score AS DOUBLE))
      comment: "Average fraud risk score across fraud cases. Used to calibrate fraud detection thresholds and benchmark case severity."
    - name: "avg_customer_return_value_90d"
      expr: AVG(CAST(customer_return_value_90d AS DOUBLE))
      comment: "Average 90-day return value for customers involved in fraud cases. Used to identify high-value serial returners and inform customer-level risk policies."
    - name: "management_review_required_count"
      expr: COUNT(CASE WHEN management_review_required_flag = TRUE THEN 1 END)
      comment: "Number of fraud cases requiring management review. Tracks escalation volume and management oversight burden in the fraud program."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`returns_restock_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Metrics for returned item restocking operations, measuring restocked value, markdown impact, and inspection compliance to optimize inventory recovery from returns."
  source: "`vibe_retail_v1`.`returns`.`restock_event`"
  dimensions:
    - name: "condition_grade"
      expr: condition_grade
      comment: "Condition grade of the restocked item, used to analyze restocked value and markdown rates by item condition."
    - name: "restock_location_type"
      expr: restock_location_type
      comment: "Type of location where the item was restocked (e.g. store floor, back stock, DC), used to analyze restocking destination mix."
    - name: "restock_reason_code"
      expr: restock_reason_code
      comment: "Reason code for the restock event, used to categorize restocking activity by return type and condition."
    - name: "inventory_status"
      expr: inventory_status
      comment: "Inventory status assigned to the restocked item (e.g. sellable, damaged, quarantine), used to track sellable vs. non-sellable restock volumes."
    - name: "inspection_completed"
      expr: inspection_completed
      comment: "Flag indicating whether inspection was completed before restocking, used to monitor inspection compliance rates."
    - name: "restock_month"
      expr: DATE_TRUNC('month', restock_timestamp)
      comment: "Month of the restock event, used for trend analysis of restocking volumes and recovered value over time."
  measures:
    - name: "total_restock_event_count"
      expr: COUNT(1)
      comment: "Total number of restock events. Baseline operational throughput metric for the returns restocking function."
    - name: "total_quantity_restocked"
      expr: SUM(CAST(quantity_restocked AS DOUBLE))
      comment: "Total units restocked from returns. Measures the volume of inventory recovered and returned to sellable status."
    - name: "total_restocked_value"
      expr: SUM(CAST(restocked_value AS DOUBLE))
      comment: "Total value of inventory restocked from returns. Quantifies the financial recovery achieved through restocking vs. liquidation."
    - name: "total_markdown_amount"
      expr: SUM(CAST(markdown_amount AS DOUBLE))
      comment: "Total markdown value applied to restocked items. Measures the margin impact of condition-based markdowns on returned inventory."
    - name: "avg_markdown_percentage"
      expr: AVG(CAST(markdown_percentage AS DOUBLE))
      comment: "Average markdown percentage applied to restocked items. Used to benchmark markdown depth by condition grade and inform pricing policy."
    - name: "total_original_cost"
      expr: SUM(CAST(original_cost AS DOUBLE))
      comment: "Total original cost of restocked items. Used as the basis for calculating restocking recovery rate vs. original cost."
    - name: "inspection_pending_count"
      expr: COUNT(CASE WHEN inspection_required = TRUE AND inspection_completed = FALSE THEN 1 END)
      comment: "Number of restock events where inspection was required but not yet completed. Tracks inspection backlog and compliance risk."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`returns_vendor_credit`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Metrics for vendor credit management, tracking credit amounts, variances, and dispute activity to optimize supplier recovery from return-to-vendor programs."
  source: "`vibe_retail_v1`.`returns`.`vendor_credit`"
  dimensions:
    - name: "credit_status"
      expr: credit_status
      comment: "Current status of the vendor credit (e.g. pending, received, disputed, applied), used to monitor credit pipeline and aging."
    - name: "credit_type"
      expr: credit_type
      comment: "Classification of the vendor credit (e.g. RTV, chargeback, defective allowance), used to analyze credit composition by type."
    - name: "dispute_reason_code"
      expr: dispute_reason_code
      comment: "Reason code for credit disputes, used to identify systemic vendor credit discrepancy patterns and inform supplier negotiations."
    - name: "credit_date"
      expr: DATE_TRUNC('month', credit_date)
      comment: "Month the vendor credit was issued, used for trend analysis of vendor credit volumes and amounts over time."
    - name: "credit_applied_date"
      expr: DATE_TRUNC('month', credit_applied_date)
      comment: "Month the vendor credit was applied to AP, used to analyze credit application cycle times and cash flow timing."
  measures:
    - name: "total_vendor_credit_count"
      expr: COUNT(1)
      comment: "Total number of vendor credit records. Baseline volume metric for the vendor credit and RTV recovery program."
    - name: "total_credit_amount"
      expr: SUM(CAST(credit_amount AS DOUBLE))
      comment: "Total vendor credit amount received. Primary financial recovery metric for the return-to-vendor program; directly offsets cost of goods."
    - name: "total_expected_credit_amount"
      expr: SUM(CAST(expected_credit_amount AS DOUBLE))
      comment: "Total expected vendor credit amount. Used to measure credit recovery rate and identify under-recovery from vendor agreements."
    - name: "total_credit_variance_amount"
      expr: SUM(CAST(credit_variance_amount AS DOUBLE))
      comment: "Total variance between expected and actual vendor credits. Negative variance indicates systematic under-payment by vendors, requiring dispute resolution."
    - name: "total_restocking_fee_amount"
      expr: SUM(CAST(restocking_fee_amount AS DOUBLE))
      comment: "Total restocking fees charged by vendors on returned goods. Measures the cost impact of vendor restocking policies on RTV economics."
    - name: "disputed_credit_count"
      expr: COUNT(CASE WHEN credit_status = 'disputed' THEN 1 END)
      comment: "Number of vendor credits in dispute status. Tracks dispute volume and associated recovery risk in the vendor credit program."
    - name: "avg_credit_amount"
      expr: AVG(CAST(credit_amount AS DOUBLE))
      comment: "Average vendor credit amount per record. Used to benchmark credit size by vendor and credit type for contract negotiations."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`returns_store_credit`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Metrics for store credit liability management, tracking issued amounts, redemption balances, and escheatment exposure to manage the store credit program."
  source: "`vibe_retail_v1`.`returns`.`store_credit`"
  dimensions:
    - name: "store_credit_status"
      expr: store_credit_status
      comment: "Current status of the store credit (e.g. active, redeemed, expired, voided), used to monitor credit lifecycle and liability aging."
    - name: "credit_type"
      expr: credit_type
      comment: "Type of store credit (e.g. return credit, promotional credit, goodwill), used to analyze credit issuance composition."
    - name: "issuing_channel"
      expr: issuing_channel
      comment: "Channel through which the store credit was issued (e.g. in-store, online), used to attribute credit liability to originating channels."
    - name: "escheatment_eligible_flag"
      expr: escheatment_eligible_flag
      comment: "Flag indicating whether the store credit is eligible for escheatment (unclaimed property), used to track regulatory compliance exposure."
    - name: "issue_date"
      expr: DATE_TRUNC('month', issue_date)
      comment: "Month the store credit was issued, used for trend analysis of credit issuance volumes and liability over time."
    - name: "expiration_date"
      expr: DATE_TRUNC('month', expiration_date)
      comment: "Month the store credit expires, used to forecast breakage income and manage expiring credit communications."
  measures:
    - name: "total_store_credit_count"
      expr: COUNT(1)
      comment: "Total number of store credits issued. Baseline volume metric for the store credit program."
    - name: "total_issued_amount"
      expr: SUM(CAST(issued_amount AS DOUBLE))
      comment: "Total store credit value issued. Represents the gross liability created by the store credit program; a key balance sheet metric."
    - name: "total_remaining_balance"
      expr: SUM(CAST(remaining_balance AS DOUBLE))
      comment: "Total outstanding store credit balance. Represents current unredeemed liability on the balance sheet; critical for financial reporting."
    - name: "avg_issued_amount"
      expr: AVG(CAST(issued_amount AS DOUBLE))
      comment: "Average store credit amount issued per transaction. Used to benchmark credit size and detect anomalies in issuance patterns."
    - name: "escheatment_eligible_count"
      expr: COUNT(CASE WHEN escheatment_eligible_flag = TRUE THEN 1 END)
      comment: "Number of store credits eligible for escheatment. Tracks unclaimed property compliance exposure and required state remittance obligations."
    - name: "escheatment_eligible_balance"
      expr: SUM(CASE WHEN escheatment_eligible_flag = TRUE THEN CAST(remaining_balance AS DOUBLE) ELSE 0 END)
      comment: "Total remaining balance on escheatment-eligible store credits. Quantifies the financial exposure from unclaimed property obligations."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`returns_rma_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Line-level RMA metrics measuring return quantities, refund amounts, restocking eligibility, and vendor credit recovery at the individual item level."
  source: "`vibe_retail_v1`.`returns`.`rma_line`"
  dimensions:
    - name: "line_status"
      expr: line_status
      comment: "Current status of the RMA line (e.g. pending, received, inspected, closed), used to monitor line-level processing throughput."
    - name: "return_reason_code"
      expr: return_reason_code
      comment: "Return reason code at line level, used to identify top return drivers by SKU and category."
    - name: "condition_code"
      expr: condition_code
      comment: "Condition code assigned to the returned item at line level, used to analyze condition distribution and recovery options."
    - name: "disposition_code"
      expr: disposition_code
      comment: "Disposition outcome assigned to the RMA line, used to track recovery strategy at item level."
    - name: "restocking_eligible_flag"
      expr: restocking_eligible_flag
      comment: "Flag indicating whether the returned item is eligible for restocking, used to measure restockable return rates."
    - name: "inspection_date"
      expr: DATE_TRUNC('month', inspection_date)
      comment: "Month of item inspection, used for trend analysis of inspection volumes and outcomes over time."
  measures:
    - name: "total_rma_line_count"
      expr: COUNT(1)
      comment: "Total number of RMA line items. Baseline volume metric for item-level return activity."
    - name: "total_refund_amount"
      expr: SUM(CAST(refund_amount AS DOUBLE))
      comment: "Total refund value at line level. Used to attribute refund costs to specific SKUs and return reasons for margin impact analysis."
    - name: "total_extended_retail_amount"
      expr: SUM(CAST(extended_retail_amount AS DOUBLE))
      comment: "Total retail value of returned items at line level. Used to calculate return rate as a percentage of sales and measure revenue impact."
    - name: "total_extended_cost_amount"
      expr: SUM(CAST(extended_cost_amount AS DOUBLE))
      comment: "Total cost value of returned items at line level. Used to measure gross margin impact of returns by SKU and category."
    - name: "total_vendor_credit_amount"
      expr: SUM(CAST(vendor_credit_amount AS DOUBLE))
      comment: "Total vendor credit recovered at line level. Measures supplier cost recovery from defective or non-conforming returned goods."
    - name: "total_restocking_fee_amount"
      expr: SUM(CAST(restocking_fee_amount AS DOUBLE))
      comment: "Total restocking fees collected at line level. Measures cost recovery from restocking fee policy at item granularity."
    - name: "total_liquidation_sale_amount"
      expr: SUM(CAST(liquidation_sale_amount AS DOUBLE))
      comment: "Total liquidation sale proceeds at line level. Used to measure item-level recovery from liquidation disposition decisions."
    - name: "restockable_line_count"
      expr: COUNT(CASE WHEN restocking_eligible_flag = TRUE THEN 1 END)
      comment: "Number of RMA lines eligible for restocking. Used to calculate restockable return rate and measure inventory recovery potential."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`returns_rtv_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Return-to-vendor line metrics measuring vendor credit recovery, chargeback activity, and credit variance to optimize supplier return program economics."
  source: "`vibe_retail_v1`.`returns`.`rtv_line`"
  dimensions:
    - name: "line_status"
      expr: line_status
      comment: "Current status of the RTV line (e.g. pending, shipped, credited, disputed), used to monitor RTV pipeline and credit receipt timing."
    - name: "return_reason_code"
      expr: return_reason_code
      comment: "Reason code for the vendor return, used to identify top drivers of RTV activity and inform vendor quality discussions."
    - name: "condition_code"
      expr: condition_code
      comment: "Condition code of the returned item, used to analyze RTV activity by item condition and vendor acceptance criteria."
    - name: "chargeback_reason_code"
      expr: chargeback_reason_code
      comment: "Reason code for chargebacks applied to the vendor, used to identify systemic vendor compliance issues."
    - name: "shipped_date"
      expr: DATE_TRUNC('month', shipped_date)
      comment: "Month the RTV shipment was sent to the vendor, used for trend analysis of RTV volumes and credit recovery timing."
    - name: "credit_issued_date"
      expr: DATE_TRUNC('month', credit_issued_date)
      comment: "Month the vendor credit was issued, used to analyze credit receipt cycle times and cash flow impact."
  measures:
    - name: "total_rtv_line_count"
      expr: COUNT(1)
      comment: "Total number of RTV line items. Baseline volume metric for the return-to-vendor program."
    - name: "total_return_quantity"
      expr: SUM(CAST(return_quantity AS DOUBLE))
      comment: "Total units returned to vendors. Measures the volume of inventory returned to suppliers for credit or replacement."
    - name: "total_vendor_credit_expected"
      expr: SUM(CAST(vendor_credit_expected_total AS DOUBLE))
      comment: "Total expected vendor credit value across all RTV lines. Used to forecast supplier recovery and measure credit receipt rate."
    - name: "total_vendor_credit_actual"
      expr: SUM(CAST(vendor_credit_actual_total AS DOUBLE))
      comment: "Total actual vendor credit received across all RTV lines. Primary financial recovery metric for the RTV program."
    - name: "total_credit_variance"
      expr: SUM(CAST(credit_variance_amount AS DOUBLE))
      comment: "Total variance between expected and actual vendor credits. Negative variance indicates systematic vendor under-payment requiring dispute escalation."
    - name: "total_chargeback_amount"
      expr: SUM(CAST(chargeback_amount AS DOUBLE))
      comment: "Total chargeback amounts applied to vendors. Measures the financial recovery from vendor compliance violations and non-conforming goods."
    - name: "total_extended_cost"
      expr: SUM(CAST(extended_cost AS DOUBLE))
      comment: "Total cost value of items returned to vendors. Used as the basis for calculating vendor credit recovery rate vs. cost."
$$;