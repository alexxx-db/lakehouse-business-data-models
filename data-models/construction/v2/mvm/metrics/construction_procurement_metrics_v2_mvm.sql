-- Metric views for domain: procurement | Business: Construction | Version: 2 | Generated on: 2026-06-27 01:50:09

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`procurement_purchase_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPIs for purchase order portfolio management — tracks committed spend, amendment activity, retention exposure, and approval cycle performance to steer procurement governance and cost control."
  source: "`vibe_construction_v1`.`procurement`.`purchase_order`"
  dimensions:
    - name: "po_status"
      expr: po_status
      comment: "Current lifecycle status of the purchase order (e.g. Open, Closed, Cancelled) — primary filter for active spend analysis."
    - name: "po_type"
      expr: po_type
      comment: "Classification of the purchase order type (e.g. Standard, Framework, Blanket) — drives procurement strategy segmentation."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval workflow status of the PO — used to identify bottlenecks in the approval pipeline."
    - name: "currency_code"
      expr: currency_code
      comment: "Transaction currency of the purchase order — required for multi-currency spend reporting."
    - name: "buyer_name"
      expr: buyer_name
      comment: "Name of the buyer responsible for the PO — enables buyer-level performance and workload analysis."
    - name: "incoterms"
      expr: incoterms
      comment: "Delivery terms (e.g. DDP, EXW, CIF) — affects landed cost and logistics risk allocation."
    - name: "payment_terms"
      expr: payment_terms
      comment: "Agreed payment terms with the vendor — key input for cash flow forecasting."
    - name: "gmp_flag"
      expr: gmp_flag
      comment: "Indicates whether the PO is subject to a Guaranteed Maximum Price — flags cost-ceiling contracts for risk monitoring."
    - name: "issued_date_month"
      expr: DATE_TRUNC('MONTH', issued_date)
      comment: "Month the PO was issued — enables trend analysis of procurement activity over time."
    - name: "approval_date_month"
      expr: DATE_TRUNC('MONTH', approval_date)
      comment: "Month the PO was approved — used to measure approval cycle time trends."
    - name: "last_amendment_type"
      expr: last_amendment_type
      comment: "Type of the most recent amendment (e.g. Scope Change, Price Adjustment) — identifies drivers of PO value changes."
    - name: "delivery_country_code"
      expr: delivery_country_code
      comment: "Country of the delivery address — supports geographic spend distribution analysis."
  measures:
    - name: "total_po_count"
      expr: COUNT(1)
      comment: "Total number of purchase orders — baseline volume metric for procurement throughput and workload assessment."
    - name: "total_committed_spend"
      expr: SUM(CAST(total_po_value AS DOUBLE))
      comment: "Total committed procurement spend across all POs — primary financial exposure metric for budget vs. commitment tracking."
    - name: "total_original_po_value"
      expr: SUM(CAST(original_po_value AS DOUBLE))
      comment: "Sum of original PO values before amendments — baseline for measuring scope and cost growth."
    - name: "total_cumulative_amendment_value"
      expr: SUM(CAST(cumulative_amendment_value AS DOUBLE))
      comment: "Total value of all amendments across the PO portfolio — quantifies scope creep and change order exposure."
    - name: "avg_po_value"
      expr: AVG(CAST(total_po_value AS DOUBLE))
      comment: "Average purchase order value — benchmarks typical transaction size and flags outliers requiring executive review."
    - name: "total_retention_amount"
      expr: SUM(CAST(retention_amount AS DOUBLE))
      comment: "Total retention withheld across all POs — tracks cash flow impact of contractual retention obligations."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax liability across the PO portfolio — required for tax reporting and cost-inclusive budget management."
    - name: "total_gmp_amount"
      expr: SUM(CAST(gmp_amount AS DOUBLE))
      comment: "Total Guaranteed Maximum Price exposure — critical for risk-capped contract portfolio monitoring."
    - name: "avg_retention_percentage"
      expr: AVG(CAST(retention_percentage AS DOUBLE))
      comment: "Average retention percentage across POs — indicates typical contractual retention burden on vendors."
    - name: "amended_po_count"
      expr: COUNT(CASE WHEN cumulative_amendment_value > 0 THEN purchase_order_id END)
      comment: "Number of POs that have been amended — measures change order frequency as a procurement governance KPI."
    - name: "gmp_po_count"
      expr: COUNT(CASE WHEN gmp_flag = TRUE THEN purchase_order_id END)
      comment: "Number of POs under a Guaranteed Maximum Price — tracks the proportion of cost-capped contracts in the portfolio."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`procurement_po_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Line-level procurement KPIs tracking ordered vs. invoiced vs. outstanding quantities and values — enables granular spend control, delivery performance, and over/under-delivery tolerance management."
  source: "`vibe_construction_v1`.`procurement`.`po_line`"
  dimensions:
    - name: "line_status"
      expr: line_status
      comment: "Current status of the PO line (e.g. Open, Closed, Partially Delivered) — primary filter for outstanding commitment analysis."
    - name: "item_category"
      expr: item_category
      comment: "Category of the line item (e.g. Material, Service, Subcontract) — drives procurement category spend analysis."
    - name: "material_group"
      expr: material_group
      comment: "Material group classification — enables commodity-level spend aggregation and sourcing strategy review."
    - name: "currency_code"
      expr: currency_code
      comment: "Transaction currency for the PO line — required for multi-currency spend reporting."
    - name: "buyer_name"
      expr: buyer_name
      comment: "Buyer responsible for the line — supports buyer performance and workload analysis."
    - name: "plant_code"
      expr: plant_code
      comment: "Plant or site code for the delivery — enables site-level procurement spend breakdown."
    - name: "tax_code"
      expr: tax_code
      comment: "Tax code applied to the line — required for tax liability reporting by category."
    - name: "account_assignment_category"
      expr: account_assignment_category
      comment: "Account assignment category (e.g. Cost Center, Project, Asset) — links procurement spend to financial controlling objects."
    - name: "delivery_date_month"
      expr: DATE_TRUNC('MONTH', delivery_date)
      comment: "Month of the scheduled delivery date — used for delivery schedule and backlog trend analysis."
    - name: "deletion_indicator"
      expr: deletion_indicator
      comment: "Flags lines marked for deletion — used to exclude cancelled lines from active commitment reporting."
    - name: "goods_receipt_indicator"
      expr: goods_receipt_indicator
      comment: "Indicates whether goods receipt is required for this line — distinguishes GR-based from non-GR procurement."
    - name: "invoice_receipt_indicator"
      expr: invoice_receipt_indicator
      comment: "Indicates whether invoice receipt is required — used to identify lines pending three-way match."
  measures:
    - name: "total_net_value"
      expr: SUM(CAST(net_value AS DOUBLE))
      comment: "Total net value of all PO lines — primary measure of committed line-level procurement spend."
    - name: "total_ordered_quantity"
      expr: SUM(CAST(ordered_quantity AS DOUBLE))
      comment: "Total quantity ordered across all PO lines — baseline for delivery fulfillment tracking."
    - name: "total_goods_receipt_quantity"
      expr: SUM(CAST(goods_receipt_quantity AS DOUBLE))
      comment: "Total quantity received against PO lines — measures physical delivery progress."
    - name: "total_invoiced_quantity"
      expr: SUM(CAST(invoiced_quantity AS DOUBLE))
      comment: "Total quantity invoiced against PO lines — tracks billing progress relative to delivery."
    - name: "total_outstanding_quantity"
      expr: SUM(CAST(outstanding_quantity AS DOUBLE))
      comment: "Total quantity still outstanding for delivery — key backlog and open commitment metric."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount across PO lines — required for tax liability and cost-inclusive budget reporting."
    - name: "avg_unit_price"
      expr: AVG(CAST(unit_price AS DOUBLE))
      comment: "Average unit price across PO lines — benchmarks pricing and supports vendor price comparison."
    - name: "avg_over_delivery_tolerance_pct"
      expr: AVG(CAST(over_delivery_tolerance_percent AS DOUBLE))
      comment: "Average over-delivery tolerance percentage — indicates flexibility built into PO lines for quantity overruns."
    - name: "avg_under_delivery_tolerance_pct"
      expr: AVG(CAST(under_delivery_tolerance_percent AS DOUBLE))
      comment: "Average under-delivery tolerance percentage — measures acceptable shortfall thresholds across the PO portfolio."
    - name: "active_line_count"
      expr: COUNT(CASE WHEN deletion_indicator = FALSE THEN po_line_id END)
      comment: "Count of active (non-deleted) PO lines — baseline for open commitment and workload reporting."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`procurement_goods_receipt`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Goods receipt KPIs measuring delivery performance, quantity variances, rejection rates, and receipt quality — directly informs vendor performance management and inventory accuracy."
  source: "`vibe_construction_v1`.`procurement`.`goods_receipt`"
  dimensions:
    - name: "inspection_status"
      expr: inspection_status
      comment: "Quality inspection outcome for the receipt (e.g. Passed, Failed, Pending) — primary dimension for quality-based receipt analysis."
    - name: "invoice_verification_status"
      expr: invoice_verification_status
      comment: "Status of invoice verification for the receipt — tracks three-way match completion."
    - name: "movement_type"
      expr: movement_type
      comment: "SAP movement type for the goods receipt — distinguishes standard receipts, returns, and reversals."
    - name: "receipt_condition"
      expr: receipt_condition
      comment: "Physical condition of goods at receipt (e.g. Good, Damaged, Partial) — key quality and claims management dimension."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the receipt valuation — required for multi-currency spend reporting."
    - name: "transportation_mode"
      expr: transportation_mode
      comment: "Mode of transport used for delivery — enables logistics cost and performance analysis by transport type."
    - name: "delivery_completed_flag"
      expr: delivery_completed_flag
      comment: "Indicates whether the delivery is fully complete — used to filter open vs. completed receipts."
    - name: "reversal_flag"
      expr: reversal_flag
      comment: "Indicates whether the goods receipt has been reversed — flags cancelled receipts for exclusion from active inventory."
    - name: "valuation_type"
      expr: valuation_type
      comment: "Valuation method applied to the receipt (e.g. Moving Average, Standard Cost) — affects inventory valuation reporting."
    - name: "receipt_date_month"
      expr: DATE_TRUNC('MONTH', receipt_date)
      comment: "Month of goods receipt — enables trend analysis of delivery volumes and values over time."
    - name: "posting_date_month"
      expr: DATE_TRUNC('MONTH', posting_date)
      comment: "Month the receipt was posted to the ledger — used for period-based financial reporting."
    - name: "unit_of_measure"
      expr: unit_of_measure
      comment: "Unit of measure for the received goods — required for quantity-based analysis across material types."
  measures:
    - name: "total_received_quantity"
      expr: SUM(CAST(received_quantity AS DOUBLE))
      comment: "Total quantity of goods received — primary volume metric for delivery fulfillment tracking."
    - name: "total_ordered_quantity"
      expr: SUM(CAST(ordered_quantity AS DOUBLE))
      comment: "Total quantity ordered per receipt document — denominator for receipt fulfillment rate calculation."
    - name: "total_rejected_quantity"
      expr: SUM(CAST(rejected_quantity AS DOUBLE))
      comment: "Total quantity rejected at goods receipt — key quality KPI driving vendor performance management."
    - name: "total_receipt_value"
      expr: SUM(CAST(total_value AS DOUBLE))
      comment: "Total monetary value of goods received — primary financial measure for goods receipt reporting and accruals."
    - name: "avg_unit_price"
      expr: AVG(CAST(unit_price AS DOUBLE))
      comment: "Average unit price at receipt — used to benchmark actual receipt prices against PO prices."
    - name: "total_receipt_count"
      expr: COUNT(1)
      comment: "Total number of goods receipt documents — measures inbound delivery activity volume."
    - name: "reversed_receipt_count"
      expr: COUNT(CASE WHEN reversal_flag = TRUE THEN goods_receipt_id END)
      comment: "Number of reversed goods receipts — tracks cancellation and correction activity as a data quality and process health KPI."
    - name: "completed_delivery_count"
      expr: COUNT(CASE WHEN delivery_completed_flag = TRUE THEN goods_receipt_id END)
      comment: "Number of fully completed deliveries — measures delivery completion rate for vendor performance scoring."
    - name: "failed_inspection_count"
      expr: COUNT(CASE WHEN inspection_status = 'Failed' THEN goods_receipt_id END)
      comment: "Number of receipts that failed quality inspection — critical quality KPI for vendor qualification and corrective action."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`procurement_vendor_invoice`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Accounts payable and invoice processing KPIs — tracks invoice values, payment performance, dispute rates, retention, and three-way match compliance to manage cash flow and vendor relationships."
  source: "`vibe_construction_v1`.`procurement`.`vendor_invoice`"
  dimensions:
    - name: "invoice_status"
      expr: invoice_status
      comment: "Current processing status of the invoice (e.g. Posted, Blocked, Paid) — primary filter for AP workload and aging analysis."
    - name: "invoice_type"
      expr: invoice_type
      comment: "Type of invoice (e.g. Standard, Credit Memo, Debit Memo) — required for accurate AP balance and liability reporting."
    - name: "three_way_match_status"
      expr: three_way_match_status
      comment: "Status of the three-way match (PO / GR / Invoice) — key compliance KPI for payment authorization."
    - name: "verification_status"
      expr: verification_status
      comment: "Invoice verification status — tracks completion of the invoice verification workflow."
    - name: "dispute_flag"
      expr: dispute_flag
      comment: "Indicates whether the invoice is under dispute — flags invoices requiring resolution before payment."
    - name: "currency_code"
      expr: currency_code
      comment: "Invoice currency — required for multi-currency AP reporting and FX exposure analysis."
    - name: "payment_method"
      expr: payment_method
      comment: "Payment method used (e.g. Wire, ACH, Check) — supports payment channel analysis and treasury optimization."
    - name: "payment_terms"
      expr: payment_terms
      comment: "Agreed payment terms on the invoice — key input for cash flow forecasting and early payment discount analysis."
    - name: "tax_code"
      expr: tax_code
      comment: "Tax code applied to the invoice — required for tax liability reporting."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the invoice — enables year-over-year AP spend comparison."
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period of the invoice — supports period-close AP accrual and reporting."
    - name: "invoice_date_month"
      expr: DATE_TRUNC('MONTH', invoice_date)
      comment: "Month of the invoice date — enables monthly AP spend trend analysis."
    - name: "payment_due_date_month"
      expr: DATE_TRUNC('MONTH', payment_due_date)
      comment: "Month payment is due — used for cash flow forecasting and payment scheduling."
  measures:
    - name: "total_invoice_gross_amount"
      expr: SUM(CAST(invoice_gross_amount AS DOUBLE))
      comment: "Total gross invoice amount — primary AP liability metric for financial reporting and cash flow management."
    - name: "total_invoice_net_amount"
      expr: SUM(CAST(invoice_net_amount AS DOUBLE))
      comment: "Total net invoice amount after discounts — actual payment obligation metric for treasury and AP management."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount across all invoices — required for tax liability reporting and compliance."
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total early payment or trade discounts captured — measures savings from discount optimization programs."
    - name: "total_retention_amount"
      expr: SUM(CAST(retention_amount AS DOUBLE))
      comment: "Total retention withheld on invoices — tracks cash flow impact of contractual retention obligations."
    - name: "total_withholding_tax_amount"
      expr: SUM(CAST(withholding_tax_amount AS DOUBLE))
      comment: "Total withholding tax deducted — required for tax compliance and vendor payment reconciliation."
    - name: "total_invoice_count"
      expr: COUNT(1)
      comment: "Total number of vendor invoices — baseline AP volume metric for workload and process efficiency analysis."
    - name: "disputed_invoice_count"
      expr: COUNT(CASE WHEN dispute_flag = TRUE THEN vendor_invoice_id END)
      comment: "Number of invoices under dispute — measures AP dispute rate as a vendor relationship and process quality KPI."
    - name: "avg_invoice_net_amount"
      expr: AVG(CAST(invoice_net_amount AS DOUBLE))
      comment: "Average net invoice amount — benchmarks typical invoice size and identifies outliers for review."
    - name: "avg_retention_percentage"
      expr: AVG(CAST(retention_percentage AS DOUBLE))
      comment: "Average retention percentage across invoices — indicates typical contractual retention burden in the AP portfolio."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`procurement_vendor`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Vendor master KPIs for supply base management — tracks vendor portfolio composition, financial health, prequalification scores, bonding capacity, and insurance compliance to steer vendor risk and diversity strategy."
  source: "`vibe_construction_v1`.`procurement`.`vendor`"
  dimensions:
    - name: "vendor_status"
      expr: vendor_status
      comment: "Current status of the vendor (e.g. Active, Suspended, Blocked) — primary filter for active supply base analysis."
    - name: "classification"
      expr: classification
      comment: "Vendor classification (e.g. Subcontractor, Supplier, Consultant) — enables spend and risk analysis by vendor type."
    - name: "diversity_classification"
      expr: diversity_classification
      comment: "Diversity classification (e.g. MBE, WBE, SBE) — tracks compliance with diversity spend targets and reporting requirements."
    - name: "country_code"
      expr: country_code
      comment: "Country of the vendor — supports geographic supply chain risk and local content analysis."
    - name: "preferred_vendor_flag"
      expr: preferred_vendor_flag
      comment: "Indicates whether the vendor is on the preferred vendor list — used to measure preferred vendor utilization rate."
    - name: "credit_rating"
      expr: credit_rating
      comment: "Credit rating of the vendor — key financial risk dimension for supply chain resilience analysis."
    - name: "payment_terms_code"
      expr: payment_terms_code
      comment: "Standard payment terms code for the vendor — supports cash flow and working capital analysis."
    - name: "geographic_coverage"
      expr: geographic_coverage
      comment: "Geographic coverage of the vendor — used for regional sourcing strategy and supply chain resilience planning."
    - name: "registration_date_year"
      expr: DATE_TRUNC('YEAR', registration_date)
      comment: "Year the vendor was registered — enables cohort analysis of vendor base growth and tenure."
    - name: "quality_certification"
      expr: quality_certification
      comment: "Quality certification held by the vendor (e.g. ISO 9001) — used to filter and segment certified vs. non-certified vendors."
  measures:
    - name: "total_vendor_count"
      expr: COUNT(1)
      comment: "Total number of vendors in the master data — baseline supply base size metric for sourcing strategy."
    - name: "active_vendor_count"
      expr: COUNT(CASE WHEN vendor_status = 'Active' THEN vendor_id END)
      comment: "Number of active vendors — measures the size of the usable supply base for procurement operations."
    - name: "preferred_vendor_count"
      expr: COUNT(CASE WHEN preferred_vendor_flag = TRUE THEN vendor_id END)
      comment: "Number of preferred vendors — tracks the size of the strategic vendor tier for preferred sourcing compliance."
    - name: "avg_prequalification_score"
      expr: AVG(CAST(prequalification_score AS DOUBLE))
      comment: "Average vendor prequalification score — measures overall supply base quality and readiness for award."
    - name: "total_bonding_capacity"
      expr: SUM(CAST(bonding_capacity_amount AS DOUBLE))
      comment: "Total bonding capacity across the vendor base — measures aggregate financial surety available for project risk coverage."
    - name: "avg_bonding_capacity"
      expr: AVG(CAST(bonding_capacity_amount AS DOUBLE))
      comment: "Average bonding capacity per vendor — benchmarks typical vendor financial strength for contract award decisions."
    - name: "total_annual_revenue"
      expr: SUM(CAST(annual_revenue_amount AS DOUBLE))
      comment: "Total annual revenue across the vendor base — measures aggregate financial scale of the supply chain."
    - name: "suspended_vendor_count"
      expr: COUNT(CASE WHEN suspension_start_date IS NOT NULL AND (suspension_end_date IS NULL OR suspension_end_date > CURRENT_DATE()) THEN vendor_id END)
      comment: "Number of currently suspended vendors — tracks supply base disruption risk from vendor suspensions."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`procurement_vendor_qualification`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Vendor qualification and HSE compliance KPIs — tracks qualification scores, safety performance rates, insurance coverage, ISO certification status, and on-time delivery rates to govern vendor eligibility and risk."
  source: "`vibe_construction_v1`.`procurement`.`vendor_qualification`"
  dimensions:
    - name: "qualification_status"
      expr: qualification_status
      comment: "Current qualification status (e.g. Approved, Pending, Expired, Suspended) — primary filter for eligible vendor pool analysis."
    - name: "qualification_type"
      expr: qualification_type
      comment: "Type of qualification (e.g. Financial, Technical, HSE) — enables analysis by qualification category."
    - name: "qualification_category"
      expr: qualification_category
      comment: "Business category for which the vendor is qualified — supports category-level supply base adequacy analysis."
    - name: "hse_performance_rating"
      expr: hse_performance_rating
      comment: "HSE performance rating of the vendor — key safety governance dimension for contractor prequalification."
    - name: "iso_9001_certified"
      expr: iso_9001_certified
      comment: "Indicates ISO 9001 quality management certification — used to segment certified vs. non-certified vendors."
    - name: "iso_14001_certified"
      expr: iso_14001_certified
      comment: "Indicates ISO 14001 environmental management certification — tracks environmental compliance in the supply base."
    - name: "iso_45001_certified"
      expr: iso_45001_certified
      comment: "Indicates ISO 45001 occupational health and safety certification — critical for HSE-governed procurement."
    - name: "insurance_workers_comp_verified"
      expr: insurance_workers_comp_verified
      comment: "Indicates whether workers compensation insurance has been verified — mandatory compliance check for contractor onboarding."
    - name: "qualification_expiry_date_month"
      expr: DATE_TRUNC('MONTH', qualification_expiry_date)
      comment: "Month the qualification expires — used to identify upcoming expirations requiring renewal action."
    - name: "geographic_coverage"
      expr: geographic_coverage
      comment: "Geographic coverage of the qualified vendor — supports regional supply base adequacy planning."
  measures:
    - name: "total_qualification_count"
      expr: COUNT(1)
      comment: "Total number of vendor qualification records — baseline metric for qualification portfolio size."
    - name: "approved_qualification_count"
      expr: COUNT(CASE WHEN qualification_status = 'Approved' THEN vendor_qualification_id END)
      comment: "Number of currently approved vendor qualifications — measures the size of the eligible, pre-approved supply base."
    - name: "avg_technical_capability_score"
      expr: AVG(CAST(technical_capability_score AS DOUBLE))
      comment: "Average technical capability score across qualified vendors — measures overall technical competency of the supply base."
    - name: "avg_financial_health_score"
      expr: AVG(CAST(financial_health_score AS DOUBLE))
      comment: "Average financial health score — tracks aggregate financial stability of the qualified vendor pool."
    - name: "avg_past_performance_score"
      expr: AVG(CAST(past_performance_score AS DOUBLE))
      comment: "Average past performance score — key vendor scorecard metric for award decisions and supply base rationalization."
    - name: "avg_on_time_delivery_rate"
      expr: AVG(CAST(on_time_delivery_rate AS DOUBLE))
      comment: "Average on-time delivery rate across qualified vendors — primary delivery performance KPI for vendor management."
    - name: "avg_quality_defect_rate"
      expr: AVG(CAST(quality_defect_rate AS DOUBLE))
      comment: "Average quality defect rate — measures supply base quality performance and drives corrective action decisions."
    - name: "avg_trir_rate"
      expr: AVG(CAST(trir_rate AS DOUBLE))
      comment: "Average Total Recordable Incident Rate (TRIR) — critical HSE KPI for contractor safety performance benchmarking."
    - name: "avg_lti_frequency_rate"
      expr: AVG(CAST(lti_frequency_rate AS DOUBLE))
      comment: "Average Lost Time Injury Frequency Rate — key safety metric for contractor HSE governance and prequalification decisions."
    - name: "total_bonding_capacity"
      expr: SUM(CAST(bonding_capacity_limit AS DOUBLE))
      comment: "Total bonding capacity limit across qualified vendors — measures aggregate surety coverage available for project awards."
    - name: "expiring_qualification_count"
      expr: COUNT(CASE WHEN qualification_expiry_date BETWEEN CURRENT_DATE() AND DATE_ADD(CURRENT_DATE(), 90) THEN vendor_qualification_id END)
      comment: "Number of qualifications expiring within 90 days — proactive risk KPI to prevent supply base gaps from expired qualifications."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`procurement_rfq`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "RFQ (Request for Quotation) process KPIs — tracks competitive bidding activity, award values, bid bond exposure, vendor response rates, and procurement lead times to optimize sourcing strategy and cycle efficiency."
  source: "`vibe_construction_v1`.`procurement`.`rfq`"
  dimensions:
    - name: "rfq_status"
      expr: rfq_status
      comment: "Current status of the RFQ (e.g. Open, Closed, Awarded, Cancelled) — primary filter for active sourcing pipeline analysis."
    - name: "rfq_type"
      expr: rfq_type
      comment: "Type of RFQ (e.g. Open, Selective, Single Source) — drives competitive bidding strategy analysis."
    - name: "contract_type"
      expr: contract_type
      comment: "Contract type associated with the RFQ (e.g. Lump Sum, Unit Rate, Cost Plus) — key dimension for risk and commercial strategy analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the RFQ — required for multi-currency award value reporting."
    - name: "issuing_department"
      expr: issuing_department
      comment: "Department that issued the RFQ — enables departmental procurement activity and spend analysis."
    - name: "incoterms"
      expr: incoterms
      comment: "Delivery terms specified in the RFQ — affects landed cost and logistics risk allocation."
    - name: "vendor_prequalification_required"
      expr: vendor_prequalification_required
      comment: "Indicates whether vendor prequalification is required — used to segment competitive vs. open market RFQs."
    - name: "bid_bond_required"
      expr: bid_bond_required
      comment: "Indicates whether a bid bond is required — tracks financial security requirements in the bidding process."
    - name: "issue_date_month"
      expr: DATE_TRUNC('MONTH', issue_date)
      comment: "Month the RFQ was issued — enables trend analysis of sourcing activity over time."
    - name: "award_date_month"
      expr: DATE_TRUNC('MONTH', award_date)
      comment: "Month the RFQ was awarded — used to measure award cycle time and sourcing throughput."
  measures:
    - name: "total_rfq_count"
      expr: COUNT(1)
      comment: "Total number of RFQs issued — baseline metric for sourcing activity volume and procurement pipeline size."
    - name: "total_awarded_amount"
      expr: SUM(CAST(awarded_amount AS DOUBLE))
      comment: "Total value awarded through RFQ processes — primary measure of sourcing-driven spend commitment."
    - name: "avg_awarded_amount"
      expr: AVG(CAST(awarded_amount AS DOUBLE))
      comment: "Average award value per RFQ — benchmarks typical contract size and supports budget planning."
    - name: "total_bid_bond_amount"
      expr: SUM(CAST(bid_bond_amount AS DOUBLE))
      comment: "Total bid bond value across RFQs — measures aggregate financial security held during the bidding process."
    - name: "total_retention_percentage_avg"
      expr: AVG(CAST(retention_percentage AS DOUBLE))
      comment: "Average retention percentage specified in RFQs — indicates typical contractual retention terms being offered to market."
    - name: "awarded_rfq_count"
      expr: COUNT(CASE WHEN rfq_status = 'Awarded' THEN rfq_id END)
      comment: "Number of RFQs that have been awarded — measures sourcing conversion rate and procurement pipeline throughput."
    - name: "cancelled_rfq_count"
      expr: COUNT(CASE WHEN rfq_status = 'Cancelled' THEN rfq_id END)
      comment: "Number of cancelled RFQs — tracks procurement process waste and identifies sourcing strategy issues."
    - name: "bid_bond_required_count"
      expr: COUNT(CASE WHEN bid_bond_required = TRUE THEN rfq_id END)
      comment: "Number of RFQs requiring a bid bond — measures the proportion of high-value or high-risk competitive bids."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`procurement_vendor_quotation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Vendor quotation evaluation KPIs — tracks quoted prices, evaluation scores, freight costs, discount rates, and technical compliance to support competitive bid analysis and award decisions."
  source: "`vibe_construction_v1`.`procurement`.`vendor_quotation`"
  dimensions:
    - name: "quotation_status"
      expr: quotation_status
      comment: "Current status of the vendor quotation (e.g. Submitted, Evaluated, Awarded, Rejected) — primary filter for active bid analysis."
    - name: "technical_compliance_status"
      expr: technical_compliance_status
      comment: "Technical compliance outcome (e.g. Compliant, Non-Compliant, Conditional) — gates commercial evaluation and award eligibility."
    - name: "award_recommendation"
      expr: award_recommendation
      comment: "Award recommendation for the quotation — tracks evaluator recommendations for governance and audit trail."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the quotation — required for multi-currency bid comparison and normalization."
    - name: "delivery_terms"
      expr: delivery_terms
      comment: "Delivery terms quoted by the vendor — affects total landed cost comparison across bids."
    - name: "country_of_origin"
      expr: country_of_origin
      comment: "Country of origin for the quoted materials — relevant for import duty, local content, and supply chain risk analysis."
    - name: "submission_date_month"
      expr: DATE_TRUNC('MONTH', submission_timestamp)
      comment: "Month the quotation was submitted — used for bid activity trend analysis."
    - name: "evaluation_date_month"
      expr: DATE_TRUNC('MONTH', evaluation_date)
      comment: "Month the quotation was evaluated — measures evaluation cycle time trends."
  measures:
    - name: "total_quoted_value"
      expr: SUM(CAST(total_price AS DOUBLE))
      comment: "Total value of all vendor quotations received — measures the aggregate commercial response to RFQs."
    - name: "avg_unit_price"
      expr: AVG(CAST(unit_price AS DOUBLE))
      comment: "Average quoted unit price — primary benchmark for price competitiveness analysis across vendors."
    - name: "total_freight_cost"
      expr: SUM(CAST(freight_cost AS DOUBLE))
      comment: "Total freight cost quoted — measures logistics cost component of bids for total landed cost analysis."
    - name: "avg_evaluation_score"
      expr: AVG(CAST(evaluation_score AS DOUBLE))
      comment: "Average evaluation score across quotations — measures overall bid quality and competitiveness of the vendor response pool."
    - name: "avg_discount_percentage"
      expr: AVG(CAST(discount_percentage AS DOUBLE))
      comment: "Average discount percentage offered by vendors — measures commercial competitiveness and negotiation leverage."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount across all quotations — required for tax-inclusive cost comparison and budget planning."
    - name: "total_quotation_count"
      expr: COUNT(1)
      comment: "Total number of vendor quotations received — measures market response rate and competitive tension in sourcing events."
    - name: "technically_compliant_count"
      expr: COUNT(CASE WHEN technical_compliance_status = 'Compliant' THEN vendor_quotation_id END)
      comment: "Number of technically compliant quotations — measures the proportion of bids eligible for commercial evaluation."
    - name: "avg_quoted_quantity"
      expr: AVG(CAST(quoted_quantity AS DOUBLE))
      comment: "Average quantity quoted per bid — used to identify vendors quoting partial vs. full scope and assess supply capacity."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`procurement_purchase_requisition`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Purchase requisition pipeline KPIs — tracks requisition volumes, estimated costs, budget availability, approval cycle performance, and conversion to PO to manage procurement demand and budget compliance."
  source: "`vibe_construction_v1`.`procurement`.`purchase_requisition`"
  dimensions:
    - name: "pr_status"
      expr: pr_status
      comment: "Current status of the purchase requisition (e.g. Draft, Pending Approval, Approved, Converted) — primary filter for pipeline and backlog analysis."
    - name: "pr_type"
      expr: pr_type
      comment: "Type of purchase requisition (e.g. Standard, Emergency, Framework) — drives procurement strategy and urgency analysis."
    - name: "conversion_status"
      expr: conversion_status
      comment: "Status of PR-to-PO conversion — measures procurement pipeline conversion efficiency."
    - name: "urgency_classification"
      expr: urgency_classification
      comment: "Urgency level of the requisition (e.g. Routine, Urgent, Emergency) — used to prioritize procurement actions and measure emergency spend."
    - name: "requesting_department"
      expr: requesting_department
      comment: "Department that raised the requisition — enables departmental demand and spend analysis."
    - name: "material_group"
      expr: material_group
      comment: "Material group of the requisitioned item — supports category-level demand planning and sourcing strategy."
    - name: "procurement_strategy"
      expr: procurement_strategy
      comment: "Procurement strategy applied (e.g. Competitive Bid, Single Source, Framework) — tracks strategic sourcing compliance."
    - name: "budget_available_flag"
      expr: budget_available_flag
      comment: "Indicates whether budget is available for the requisition — flags unfunded demand for budget management action."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the requisition — required for multi-currency demand and budget reporting."
    - name: "requisition_date_month"
      expr: DATE_TRUNC('MONTH', requisition_date)
      comment: "Month the requisition was raised — enables trend analysis of procurement demand over time."
    - name: "required_delivery_date_month"
      expr: DATE_TRUNC('MONTH', required_delivery_date)
      comment: "Month the delivery is required — used for demand forecasting and procurement scheduling."
    - name: "technical_specification_attached"
      expr: technical_specification_attached
      comment: "Indicates whether a technical specification is attached — measures requisition quality and readiness for sourcing."
  measures:
    - name: "total_pr_count"
      expr: COUNT(1)
      comment: "Total number of purchase requisitions — baseline metric for procurement demand volume."
    - name: "total_estimated_cost"
      expr: SUM(CAST(estimated_total_cost AS DOUBLE))
      comment: "Total estimated cost of all requisitions — primary demand-side spend forecast metric for budget management."
    - name: "avg_estimated_unit_cost"
      expr: AVG(CAST(estimated_unit_cost AS DOUBLE))
      comment: "Average estimated unit cost across requisitions — benchmarks typical unit pricing for budget planning and vendor negotiation."
    - name: "total_budget_variance_amount"
      expr: SUM(CAST(budget_variance_amount AS DOUBLE))
      comment: "Total budget variance across requisitions — measures aggregate over/under-budget demand for financial control."
    - name: "total_quantity_requested"
      expr: SUM(CAST(quantity AS DOUBLE))
      comment: "Total quantity requested across all requisitions — measures aggregate material demand for supply planning."
    - name: "converted_pr_count"
      expr: COUNT(CASE WHEN conversion_status = 'Converted' THEN purchase_requisition_id END)
      comment: "Number of requisitions converted to purchase orders — measures PR-to-PO conversion rate as a procurement efficiency KPI."
    - name: "unfunded_pr_count"
      expr: COUNT(CASE WHEN budget_available_flag = FALSE THEN purchase_requisition_id END)
      comment: "Number of requisitions without available budget — flags unfunded demand requiring budget reallocation or deferral decisions."
    - name: "emergency_pr_count"
      expr: COUNT(CASE WHEN urgency_classification = 'Emergency' THEN purchase_requisition_id END)
      comment: "Number of emergency purchase requisitions — measures unplanned procurement demand as a planning maturity KPI."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`procurement_purchasing_info_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Purchasing info record KPIs for vendor-material pricing intelligence — tracks current pricing, lead times, minimum order quantities, and preferred vendor coverage to support strategic sourcing and price benchmarking."
  source: "`vibe_construction_v1`.`procurement`.`purchasing_info_record`"
  dimensions:
    - name: "purchasing_info_record_status"
      expr: purchasing_info_record_status
      comment: "Status of the purchasing info record (e.g. Active, Expired, Blocked) — primary filter for valid pricing data."
    - name: "preferred_vendor_flag"
      expr: preferred_vendor_flag
      comment: "Indicates whether the vendor is preferred for this material — used to measure preferred vendor pricing coverage."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the pricing record — required for multi-currency price benchmarking."
    - name: "effective_date_month"
      expr: DATE_TRUNC('MONTH', effective_date)
      comment: "Month the pricing record became effective — enables price trend analysis over time."
    - name: "expiry_date_month"
      expr: DATE_TRUNC('MONTH', expiry_date)
      comment: "Month the pricing record expires — used to identify records requiring renewal to maintain sourcing continuity."
  measures:
    - name: "total_info_record_count"
      expr: COUNT(1)
      comment: "Total number of purchasing info records — measures the breadth of vendor-material pricing coverage in the system."
    - name: "avg_unit_price"
      expr: AVG(CAST(unit_price AS DOUBLE))
      comment: "Average unit price across all active info records — primary price benchmarking metric for category management."
    - name: "avg_lead_time_days"
      expr: AVG(CAST(lead_time_days AS DOUBLE))
      comment: "Average vendor lead time in days — key supply chain planning metric for procurement scheduling and safety stock decisions."
    - name: "avg_minimum_order_quantity"
      expr: AVG(CAST(minimum_order_quantity AS DOUBLE))
      comment: "Average minimum order quantity — informs procurement lot sizing and inventory optimization decisions."
    - name: "preferred_vendor_record_count"
      expr: COUNT(CASE WHEN preferred_vendor_flag = TRUE THEN purchasing_info_record_id END)
      comment: "Number of info records for preferred vendors — measures preferred vendor pricing coverage across the material catalog."
    - name: "expiring_record_count"
      expr: COUNT(CASE WHEN expiry_date BETWEEN CURRENT_DATE() AND DATE_ADD(CURRENT_DATE(), 90) THEN purchasing_info_record_id END)
      comment: "Number of pricing records expiring within 90 days — proactive KPI to prevent sourcing gaps from expired price agreements."
$$;