-- Metric views for domain: billing | Business: Chemical Mfg | Version: 1 | Generated on: 2026-05-06 14:33:25

CREATE OR REPLACE VIEW `chemical_mfg_ecm`.`_metrics`.`billing_invoice`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core invoice metrics tracking revenue, payment performance, and billing efficiency across customers, products, and time periods"
  source: "`chemical_mfg_ecm`.`billing`.`invoice`"
  dimensions:
    - name: "invoice_status"
      expr: invoice_status
      comment: "Current status of the invoice (e.g., draft, issued, paid, cancelled)"
    - name: "invoice_type"
      expr: invoice_type
      comment: "Type of invoice (e.g., standard, credit memo, debit memo, proforma)"
    - name: "payment_status"
      expr: payment_status
      comment: "Payment status of the invoice (e.g., unpaid, partially paid, fully paid, overdue)"
    - name: "payment_method"
      expr: payment_method
      comment: "Method used for payment (e.g., wire transfer, check, credit card, ACH)"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which the invoice is denominated"
    - name: "invoice_month"
      expr: DATE_TRUNC('MONTH', invoice_date)
      comment: "Month when the invoice was issued"
    - name: "invoice_quarter"
      expr: DATE_TRUNC('QUARTER', invoice_date)
      comment: "Quarter when the invoice was issued"
    - name: "invoice_year"
      expr: YEAR(invoice_date)
      comment: "Year when the invoice was issued"
    - name: "due_month"
      expr: DATE_TRUNC('MONTH', due_date)
      comment: "Month when payment is due"
    - name: "is_electronic_invoice"
      expr: is_electronic_invoice
      comment: "Flag indicating whether invoice was delivered electronically"
    - name: "is_tax_exempt"
      expr: is_tax_exempt
      comment: "Flag indicating whether the invoice is tax exempt"
    - name: "regulatory_compliance_status"
      expr: regulatory_compliance_status
      comment: "Regulatory compliance status of the invoice"
  measures:
    - name: "total_invoice_count"
      expr: COUNT(1)
      comment: "Total number of invoices"
    - name: "unique_customers"
      expr: COUNT(DISTINCT account_id)
      comment: "Number of unique customer accounts invoiced"
    - name: "total_gross_amount"
      expr: SUM(CAST(gross_amount AS DOUBLE))
      comment: "Total gross invoice amount before discounts and taxes"
    - name: "total_net_amount"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Total net invoice amount after all adjustments"
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount across all invoices"
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discount amount given across all invoices"
    - name: "total_rebate_amount"
      expr: SUM(CAST(rebate_amount AS DOUBLE))
      comment: "Total rebate amount applied across all invoices"
    - name: "avg_invoice_net_amount"
      expr: AVG(CAST(net_amount AS DOUBLE))
      comment: "Average net invoice value per invoice"
    - name: "avg_invoice_gross_amount"
      expr: AVG(CAST(gross_amount AS DOUBLE))
      comment: "Average gross invoice value per invoice"
    - name: "total_invoice_quantity"
      expr: SUM(CAST(total_quantity AS DOUBLE))
      comment: "Total quantity of items invoiced across all invoices"
    - name: "total_weight_kg"
      expr: SUM(CAST(weight_kg AS DOUBLE))
      comment: "Total weight in kilograms of all invoiced goods"
    - name: "total_volume_m3"
      expr: SUM(CAST(volume_m3 AS DOUBLE))
      comment: "Total volume in cubic meters of all invoiced goods"
$$;

CREATE OR REPLACE VIEW `chemical_mfg_ecm`.`_metrics`.`billing_invoice_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Detailed line-level invoice metrics for product mix analysis, pricing performance, and revenue attribution by product, plant, and cost center"
  source: "`chemical_mfg_ecm`.`billing`.`invoice_line`"
  dimensions:
    - name: "line_status"
      expr: line_status
      comment: "Status of the invoice line item"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the line item"
    - name: "plant"
      expr: plant
      comment: "Manufacturing plant or facility code"
    - name: "manufacturing_site"
      expr: manufacturing_site
      comment: "Manufacturing site where product was produced"
    - name: "uom"
      expr: uom
      comment: "Unit of measure for the line item quantity"
    - name: "hazardous_material_flag"
      expr: hazardous_material_flag
      comment: "Flag indicating whether the line item contains hazardous materials"
    - name: "intercompany_flag"
      expr: intercompany_flag
      comment: "Flag indicating whether this is an intercompany transaction"
    - name: "tax_exempt_flag"
      expr: tax_exempt_flag
      comment: "Flag indicating whether the line item is tax exempt"
    - name: "rebate_flag"
      expr: rebate_flag
      comment: "Flag indicating whether a rebate applies to this line"
    - name: "price_override_flag"
      expr: price_override_flag
      comment: "Flag indicating whether the price was manually overridden"
    - name: "settlement_status"
      expr: settlement_status
      comment: "Settlement status of the line item"
    - name: "tax_code"
      expr: tax_code
      comment: "Tax code applied to the line item"
    - name: "regulatory_compliance_code"
      expr: regulatory_compliance_code
      comment: "Regulatory compliance code for the product"
    - name: "accounting_month"
      expr: DATE_TRUNC('MONTH', accounting_date)
      comment: "Accounting month for revenue recognition"
    - name: "revenue_recognition_month"
      expr: DATE_TRUNC('MONTH', revenue_recognition_date)
      comment: "Month when revenue is recognized"
  measures:
    - name: "total_line_count"
      expr: COUNT(1)
      comment: "Total number of invoice line items"
    - name: "unique_invoices"
      expr: COUNT(DISTINCT invoice_id)
      comment: "Number of unique invoices represented"
    - name: "unique_products"
      expr: COUNT(DISTINCT chemical_product_id)
      comment: "Number of unique chemical products invoiced"
    - name: "unique_skus"
      expr: COUNT(DISTINCT sku_id)
      comment: "Number of unique SKUs invoiced"
    - name: "total_line_amount"
      expr: SUM(CAST(line_amount AS DOUBLE))
      comment: "Total line amount before adjustments"
    - name: "total_net_amount"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Total net amount after all adjustments"
    - name: "total_quantity"
      expr: SUM(CAST(quantity AS DOUBLE))
      comment: "Total quantity of items invoiced"
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount on invoice lines"
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discount amount applied to invoice lines"
    - name: "total_rebate_amount"
      expr: SUM(CAST(rebate_amount AS DOUBLE))
      comment: "Total rebate amount applied to invoice lines"
    - name: "avg_unit_price"
      expr: AVG(CAST(unit_price AS DOUBLE))
      comment: "Average unit price across all invoice lines"
    - name: "avg_line_amount"
      expr: AVG(CAST(line_amount AS DOUBLE))
      comment: "Average line amount per invoice line"
$$;

CREATE OR REPLACE VIEW `chemical_mfg_ecm`.`_metrics`.`billing_ar_open_item`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Accounts receivable aging and collection metrics tracking outstanding balances, overdue amounts, and collection effectiveness"
  source: "`chemical_mfg_ecm`.`billing`.`ar_open_item`"
  dimensions:
    - name: "aging_bucket"
      expr: aging_bucket
      comment: "Aging bucket classification (e.g., current, 1-30 days, 31-60 days, 61-90 days, 90+ days)"
    - name: "collection_status"
      expr: collection_status
      comment: "Current collection status of the open item"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the receivable"
    - name: "overdue_days"
      expr: overdue_days
      comment: "Number of days the item is overdue"
    - name: "dunning_level"
      expr: dunning_level
      comment: "Dunning level for collection escalation"
    - name: "reconciliation_status"
      expr: reconciliation_status
      comment: "Reconciliation status of the AR item"
    - name: "credit_memo_flag"
      expr: credit_memo_flag
      comment: "Flag indicating whether this is a credit memo"
    - name: "partial_payment_flag"
      expr: partial_payment_flag
      comment: "Flag indicating whether partial payment has been received"
    - name: "write_off_flag"
      expr: write_off_flag
      comment: "Flag indicating whether the item has been written off"
    - name: "posting_month"
      expr: DATE_TRUNC('MONTH', posting_date)
      comment: "Month when the AR item was posted"
    - name: "due_month"
      expr: DATE_TRUNC('MONTH', due_date)
      comment: "Month when payment is due"
  measures:
    - name: "total_ar_items"
      expr: COUNT(1)
      comment: "Total number of open AR items"
    - name: "unique_customers"
      expr: COUNT(DISTINCT account_id)
      comment: "Number of unique customer accounts with open AR"
    - name: "unique_invoices"
      expr: COUNT(DISTINCT invoice_id)
      comment: "Number of unique invoices with open items"
    - name: "total_amount_outstanding"
      expr: SUM(CAST(amount_outstanding AS DOUBLE))
      comment: "Total outstanding receivable amount across all open items"
    - name: "total_amount_original"
      expr: SUM(CAST(amount_original AS DOUBLE))
      comment: "Total original amount of all open AR items"
    - name: "total_paid_amount"
      expr: SUM(CAST(total_paid_amount AS DOUBLE))
      comment: "Total amount already paid on open items"
    - name: "total_gross_amount"
      expr: SUM(CAST(gross_amount AS DOUBLE))
      comment: "Total gross amount of open AR items"
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount on open AR items"
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discount amount available on open items"
    - name: "total_credit_memo_amount"
      expr: SUM(CAST(credit_memo_amount AS DOUBLE))
      comment: "Total credit memo amount applied to open items"
    - name: "total_write_off_amount"
      expr: SUM(CAST(write_off_amount AS DOUBLE))
      comment: "Total amount written off"
    - name: "avg_outstanding_amount"
      expr: AVG(CAST(amount_outstanding AS DOUBLE))
      comment: "Average outstanding amount per AR item"
$$;

CREATE OR REPLACE VIEW `chemical_mfg_ecm`.`_metrics`.`billing_payment_receipt`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Payment collection metrics tracking cash receipts, payment methods, reconciliation status, and collection efficiency"
  source: "`chemical_mfg_ecm`.`billing`.`payment_receipt`"
  dimensions:
    - name: "payment_status"
      expr: payment_status
      comment: "Status of the payment receipt (e.g., pending, cleared, bounced, reconciled)"
    - name: "payment_method"
      expr: payment_method
      comment: "Method of payment (e.g., wire transfer, check, credit card, ACH)"
    - name: "payment_channel"
      expr: payment_channel
      comment: "Channel through which payment was received"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the payment"
    - name: "reconciliation_status"
      expr: reconciliation_status
      comment: "Reconciliation status of the payment"
    - name: "is_advance_payment"
      expr: is_advance_payment
      comment: "Flag indicating whether this is an advance payment"
    - name: "is_refund"
      expr: is_refund
      comment: "Flag indicating whether this is a refund"
    - name: "payment_month"
      expr: DATE_TRUNC('MONTH', payment_timestamp)
      comment: "Month when payment was received"
    - name: "payment_quarter"
      expr: DATE_TRUNC('QUARTER', payment_timestamp)
      comment: "Quarter when payment was received"
    - name: "payment_year"
      expr: YEAR(payment_timestamp)
      comment: "Year when payment was received"
    - name: "source_system"
      expr: source_system
      comment: "Source system from which payment was recorded"
  measures:
    - name: "total_payment_count"
      expr: COUNT(1)
      comment: "Total number of payment receipts"
    - name: "unique_customers"
      expr: COUNT(DISTINCT account_id)
      comment: "Number of unique customers making payments"
    - name: "unique_invoices_paid"
      expr: COUNT(DISTINCT invoice_id)
      comment: "Number of unique invoices receiving payment"
    - name: "total_amount_gross"
      expr: SUM(CAST(amount_gross AS DOUBLE))
      comment: "Total gross payment amount received"
    - name: "total_amount_net"
      expr: SUM(CAST(amount_net AS DOUBLE))
      comment: "Total net payment amount after adjustments"
    - name: "total_amount_tax"
      expr: SUM(CAST(amount_tax AS DOUBLE))
      comment: "Total tax amount included in payments"
    - name: "total_amount_discount"
      expr: SUM(CAST(amount_discount AS DOUBLE))
      comment: "Total discount amount taken on payments"
    - name: "total_foreign_currency_amount"
      expr: SUM(CAST(foreign_currency_amount AS DOUBLE))
      comment: "Total payment amount in foreign currency"
    - name: "avg_payment_amount_net"
      expr: AVG(CAST(amount_net AS DOUBLE))
      comment: "Average net payment amount per receipt"
    - name: "avg_exchange_rate"
      expr: AVG(CAST(exchange_rate AS DOUBLE))
      comment: "Average exchange rate applied to foreign currency payments"
$$;

CREATE OR REPLACE VIEW `chemical_mfg_ecm`.`_metrics`.`billing_revenue_recognition_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Revenue recognition metrics tracking recognized revenue, deferred revenue, and compliance with ASC 606 and IFRS 15 standards"
  source: "`chemical_mfg_ecm`.`billing`.`revenue_recognition_event`"
  dimensions:
    - name: "revenue_recognition_event_status"
      expr: revenue_recognition_event_status
      comment: "Status of the revenue recognition event"
    - name: "recognition_type"
      expr: recognition_type
      comment: "Type of revenue recognition (e.g., point-in-time, over-time, milestone-based)"
    - name: "revenue_recognition_method"
      expr: revenue_recognition_method
      comment: "Method used for revenue recognition"
    - name: "revenue_category"
      expr: revenue_category
      comment: "Category of revenue (e.g., product sales, services, licensing)"
    - name: "revenue_line_type"
      expr: revenue_line_type
      comment: "Type of revenue line item"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the revenue"
    - name: "compliance_flag_asc606"
      expr: compliance_flag_asc606
      comment: "Flag indicating compliance with ASC 606 revenue recognition standard"
    - name: "compliance_flag_ifrs15"
      expr: compliance_flag_ifrs15
      comment: "Flag indicating compliance with IFRS 15 revenue recognition standard"
    - name: "intercompany_flag"
      expr: intercompany_flag
      comment: "Flag indicating whether this is intercompany revenue"
    - name: "is_estimated"
      expr: is_estimated
      comment: "Flag indicating whether revenue amount is estimated"
    - name: "is_reversal"
      expr: is_reversal
      comment: "Flag indicating whether this is a reversal event"
    - name: "posting_month"
      expr: DATE_TRUNC('MONTH', posting_date)
      comment: "Month when revenue was posted"
    - name: "posting_quarter"
      expr: DATE_TRUNC('QUARTER', posting_date)
      comment: "Quarter when revenue was posted"
    - name: "recognition_start_month"
      expr: DATE_TRUNC('MONTH', recognition_start_date)
      comment: "Month when revenue recognition period starts"
  measures:
    - name: "total_recognition_events"
      expr: COUNT(1)
      comment: "Total number of revenue recognition events"
    - name: "unique_invoices"
      expr: COUNT(DISTINCT invoice_id)
      comment: "Number of unique invoices with revenue recognition events"
    - name: "unique_orders"
      expr: COUNT(DISTINCT order_id)
      comment: "Number of unique orders with revenue recognition"
    - name: "total_recognized_revenue"
      expr: SUM(CAST(recognized_revenue_amount AS DOUBLE))
      comment: "Total revenue recognized across all events"
    - name: "total_deferred_revenue"
      expr: SUM(CAST(deferred_revenue_amount AS DOUBLE))
      comment: "Total revenue deferred for future recognition"
    - name: "total_revenue_local"
      expr: SUM(CAST(revenue_amount_local AS DOUBLE))
      comment: "Total revenue in local currency"
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discount amount applied to revenue"
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount on recognized revenue"
    - name: "avg_recognized_revenue"
      expr: AVG(CAST(recognized_revenue_amount AS DOUBLE))
      comment: "Average revenue recognized per event"
    - name: "avg_exchange_rate"
      expr: AVG(CAST(exchange_rate AS DOUBLE))
      comment: "Average exchange rate applied to revenue recognition"
$$;

CREATE OR REPLACE VIEW `chemical_mfg_ecm`.`_metrics`.`billing_dispute`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Billing dispute metrics tracking dispute volume, resolution effectiveness, and financial impact of customer billing disputes"
  source: "`chemical_mfg_ecm`.`billing`.`dispute`"
  dimensions:
    - name: "dispute_status"
      expr: dispute_status
      comment: "Current status of the dispute (e.g., open, under review, resolved, closed)"
    - name: "reason"
      expr: reason
      comment: "Reason code or category for the dispute"
    - name: "priority"
      expr: priority
      comment: "Priority level of the dispute"
    - name: "escalation_flag"
      expr: escalation_flag
      comment: "Flag indicating whether the dispute has been escalated"
    - name: "escalated_to_department"
      expr: escalated_to_department
      comment: "Department to which the dispute was escalated"
    - name: "resolution_action"
      expr: resolution_action
      comment: "Action taken to resolve the dispute"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the disputed amount"
    - name: "created_month"
      expr: DATE_TRUNC('MONTH', created_timestamp)
      comment: "Month when the dispute was created"
    - name: "resolution_month"
      expr: DATE_TRUNC('MONTH', resolution_date)
      comment: "Month when the dispute was resolved"
  measures:
    - name: "total_disputes"
      expr: COUNT(1)
      comment: "Total number of billing disputes"
    - name: "unique_customers"
      expr: COUNT(DISTINCT account_id)
      comment: "Number of unique customers with disputes"
    - name: "unique_invoices_disputed"
      expr: COUNT(DISTINCT invoice_id)
      comment: "Number of unique invoices under dispute"
    - name: "total_disputed_amount"
      expr: SUM(CAST(disputed_amount AS DOUBLE))
      comment: "Total amount under dispute"
    - name: "total_disputed_invoice_amount"
      expr: SUM(CAST(disputed_invoice_amount AS DOUBLE))
      comment: "Total invoice amount associated with disputes"
    - name: "total_adjustment_amount"
      expr: SUM(CAST(adjustment_amount AS DOUBLE))
      comment: "Total adjustment amount resulting from dispute resolution"
    - name: "total_net_amount"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Total net amount after dispute adjustments"
    - name: "avg_disputed_amount"
      expr: AVG(CAST(disputed_amount AS DOUBLE))
      comment: "Average disputed amount per dispute"
$$;

CREATE OR REPLACE VIEW `chemical_mfg_ecm`.`_metrics`.`billing_settlement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Settlement metrics tracking payment settlements, reconciliation, and financial close activities across billing parties and legal entities"
  source: "`chemical_mfg_ecm`.`billing`.`settlement`"
  dimensions:
    - name: "settlement_status"
      expr: settlement_status
      comment: "Current status of the settlement"
    - name: "settlement_type"
      expr: settlement_type
      comment: "Type of settlement (e.g., invoice settlement, rebate settlement, dispute settlement)"
    - name: "method"
      expr: method
      comment: "Settlement method used"
    - name: "channel"
      expr: channel
      comment: "Channel through which settlement was processed"
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the settlement"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the settlement"
    - name: "is_manual"
      expr: is_manual
      comment: "Flag indicating whether settlement was processed manually"
    - name: "country"
      expr: country
      comment: "Country where settlement occurred"
    - name: "region"
      expr: region
      comment: "Region where settlement occurred"
    - name: "event_month"
      expr: DATE_TRUNC('MONTH', event_timestamp)
      comment: "Month when settlement event occurred"
    - name: "due_month"
      expr: DATE_TRUNC('MONTH', due_date)
      comment: "Month when settlement is due"
  measures:
    - name: "total_settlements"
      expr: COUNT(1)
      comment: "Total number of settlements"
    - name: "unique_billing_parties"
      expr: COUNT(DISTINCT billing_party_id)
      comment: "Number of unique billing parties involved in settlements"
    - name: "unique_invoices_settled"
      expr: COUNT(DISTINCT invoice_id)
      comment: "Number of unique invoices settled"
    - name: "total_gross_amount"
      expr: SUM(CAST(gross_amount AS DOUBLE))
      comment: "Total gross settlement amount"
    - name: "total_net_amount"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Total net settlement amount after adjustments"
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount in settlements"
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discount amount applied in settlements"
    - name: "avg_settlement_net_amount"
      expr: AVG(CAST(net_amount AS DOUBLE))
      comment: "Average net settlement amount per settlement"
    - name: "avg_exchange_rate"
      expr: AVG(CAST(exchange_rate AS DOUBLE))
      comment: "Average exchange rate applied to settlements"
$$;
