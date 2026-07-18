-- Metric views for domain: finance | Business: Grocery | Version: 1 | Generated on: 2026-05-04 18:32:13

CREATE OR REPLACE VIEW `grocery_ecm`.`_metrics`.`finance_ap_invoice`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core payable invoice financial KPIs for executive and operational review"
  source: "`grocery_ecm`.`finance`.`ap_invoice`"
  dimensions:
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the invoice"
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period of the invoice"
    - name: "company_code"
      expr: company_code
      comment: "Company code associated with the invoice"
    - name: "supplier_id"
      expr: supplier_id
      comment: "Supplier identifier"
    - name: "payment_method"
      expr: payment_method
      comment: "Method used for payment"
    - name: "invoice_status"
      expr: invoice_status
      comment: "Current status of the invoice"
    - name: "invoice_month"
      expr: DATE_TRUNC('month', invoice_date)
      comment: "Invoice month for time‑series analysis"
  measures:
    - name: "invoice_count"
      expr: COUNT(1)
      comment: "Number of AP invoices"
    - name: "total_gross_amount"
      expr: SUM(CAST(gross_amount AS DOUBLE))
      comment: "Total gross amount of AP invoices"
    - name: "total_net_amount"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Total net amount after discounts"
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discount taken on AP invoices"
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount on AP invoices"
    - name: "average_gross_amount"
      expr: AVG(CAST(gross_amount AS DOUBLE))
      comment: "Average gross amount per AP invoice"
$$;

CREATE OR REPLACE VIEW `grocery_ecm`.`_metrics`.`finance_ar_invoice`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Revenue and receivables KPIs for AR invoices, supporting cash‑flow and credit risk monitoring"
  source: "`grocery_ecm`.`finance`.`ar_invoice`"
  dimensions:
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the AR invoice"
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period of the AR invoice"
    - name: "invoice_status"
      expr: invoice_status
      comment: "Current status of the AR invoice"
    - name: "payment_method"
      expr: payment_method
      comment: "Method used for payment"
    - name: "aging_bucket"
      expr: aging_bucket
      comment: "Aging bucket for overdue analysis"
    - name: "due_month"
      expr: DATE_TRUNC('month', due_date)
      comment: "Month of invoice due date"
  measures:
    - name: "ar_invoice_count"
      expr: COUNT(1)
      comment: "Number of AR invoices"
    - name: "total_gross_amount"
      expr: SUM(CAST(gross_amount AS DOUBLE))
      comment: "Total gross amount of AR invoices"
    - name: "total_net_amount"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Total net amount after discounts"
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount on AR invoices"
    - name: "total_outstanding_balance"
      expr: SUM(CAST(outstanding_balance AS DOUBLE))
      comment: "Total outstanding balance across AR invoices"
    - name: "distinct_sales_orders"
      expr: COUNT(DISTINCT sales_order_number)
      comment: "Count of distinct sales orders represented in AR invoices"
$$;

CREATE OR REPLACE VIEW `grocery_ecm`.`_metrics`.`finance_payment_run`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "High‑level payment run financial metrics for treasury and cash‑management oversight"
  source: "`grocery_ecm`.`finance`.`payment_run`"
  dimensions:
    - name: "status"
      expr: payment_run_status
      comment: "Current status of the payment run"
    - name: "payment_method"
      expr: payment_method
      comment: "Payment method used in the run"
    - name: "run_type"
      expr: run_type
      comment: "Type of payment run (e.g., scheduled, ad‑hoc)"
    - name: "supplier_id"
      expr: supplier_id
      comment: "Supplier associated with the payment run"
  measures:
    - name: "payment_run_count"
      expr: COUNT(1)
      comment: "Number of payment runs executed"
    - name: "total_gross_amount"
      expr: SUM(CAST(total_gross_amount AS DOUBLE))
      comment: "Total gross amount processed in payment runs"
    - name: "total_net_amount"
      expr: SUM(CAST(total_net_amount AS DOUBLE))
      comment: "Total net amount processed in payment runs"
    - name: "total_fees_amount"
      expr: SUM(CAST(total_fees_amount AS DOUBLE))
      comment: "Total fees incurred across payment runs"
    - name: "total_tax_amount"
      expr: SUM(CAST(total_tax_amount AS DOUBLE))
      comment: "Total tax amount across payment runs"
$$;

CREATE OR REPLACE VIEW `grocery_ecm`.`_metrics`.`finance_fixed_asset`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Asset management KPIs for capital planning and depreciation tracking"
  source: "`grocery_ecm`.`finance`.`fixed_asset`"
  dimensions:
    - name: "asset_class"
      expr: asset_class
      comment: "Classification of the asset (e.g., equipment, building)"
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year associated with the asset record"
    - name: "location_code"
      expr: location_code
      comment: "Physical location code of the asset"
  measures:
    - name: "asset_count"
      expr: COUNT(1)
      comment: "Number of fixed assets"
    - name: "total_acquisition_cost"
      expr: SUM(CAST(acquisition_cost AS DOUBLE))
      comment: "Total acquisition cost of fixed assets"
    - name: "total_accumulated_depreciation"
      expr: SUM(CAST(accumulated_depreciation AS DOUBLE))
      comment: "Total accumulated depreciation across assets"
    - name: "total_net_book_value"
      expr: SUM(CAST(net_book_value AS DOUBLE))
      comment: "Total net book value of fixed assets"
$$;
