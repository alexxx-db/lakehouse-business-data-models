-- Metric views for domain: billing | Business: Healthcare | Version: 2 | Generated on: 2026-07-02 09:11:47

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`billing_charge`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core billing charge metrics tracking revenue, volume, and operational efficiency for healthcare services rendered"
  source: "`vibe_healthcare_v1`.`billing`.`charge`"
  dimensions:
    - name: "charge_status"
      expr: charge_status
      comment: "Current status of the charge (e.g., posted, held, released, voided)"
    - name: "charge_type"
      expr: charge_type
      comment: "Type classification of the charge"
    - name: "service_year"
      expr: YEAR(service_date)
      comment: "Year when the service was provided"
    - name: "service_month"
      expr: DATE_TRUNC('MONTH', service_date)
      comment: "Month when the service was provided"
    - name: "posting_year"
      expr: YEAR(posting_date)
      comment: "Year when the charge was posted to the billing system"
    - name: "posting_month"
      expr: DATE_TRUNC('MONTH', posting_date)
      comment: "Month when the charge was posted to the billing system"
    - name: "place_of_service_code"
      expr: place_of_service_code
      comment: "CMS place of service code indicating where the service was rendered"
    - name: "revenue_code"
      expr: revenue_code
      comment: "UB-04 revenue code for hospital billing classification"
    - name: "is_billable"
      expr: is_billable
      comment: "Flag indicating whether the charge is billable to payer or patient"
    - name: "is_voided"
      expr: is_voided
      comment: "Flag indicating whether the charge has been voided"
    - name: "is_corrected"
      expr: is_corrected
      comment: "Flag indicating whether the charge has been corrected"
    - name: "implant_flag"
      expr: implant_flag
      comment: "Flag indicating whether the charge is for an implantable device"
  measures:
    - name: "total_gross_charge_amount"
      expr: SUM(CAST(gross_charge_amount AS DOUBLE))
      comment: "Total gross charges before adjustments, contractual allowances, or write-offs - primary revenue metric"
    - name: "total_expected_reimbursement_amount"
      expr: SUM(CAST(expected_reimbursement_amount AS DOUBLE))
      comment: "Total expected reimbursement after contractual adjustments - net revenue forecast"
    - name: "total_charge_quantity"
      expr: SUM(CAST(quantity AS DOUBLE))
      comment: "Total quantity of services or units charged across all charge lines"
    - name: "avg_unit_price"
      expr: AVG(CAST(unit_price AS DOUBLE))
      comment: "Average unit price per charge line - pricing benchmark metric"
    - name: "charge_count"
      expr: COUNT(1)
      comment: "Total number of charge transactions - volume metric for billing operations"
    - name: "distinct_patient_count"
      expr: COUNT(DISTINCT mpi_record_id)
      comment: "Unique patient count with charges - patient volume metric"
    - name: "distinct_visit_count"
      expr: COUNT(DISTINCT visit_id)
      comment: "Unique visit/encounter count with charges - encounter volume metric"
    - name: "contractual_adjustment_rate"
      expr: ROUND(100.0 * (SUM(CAST(gross_charge_amount AS DOUBLE)) - SUM(CAST(expected_reimbursement_amount AS DOUBLE))) / NULLIF(SUM(CAST(gross_charge_amount AS DOUBLE)), 0), 2)
      comment: "Percentage difference between gross charges and expected reimbursement - measures payer contract impact on revenue"
    - name: "avg_charge_per_visit"
      expr: SUM(CAST(gross_charge_amount AS DOUBLE)) / NULLIF(COUNT(DISTINCT visit_id), 0)
      comment: "Average gross charge amount per unique visit - case mix and intensity indicator"
    - name: "voided_charge_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN is_voided = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of charges that have been voided - billing quality and error rate metric"
    - name: "corrected_charge_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN is_corrected = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of charges that required correction - billing accuracy metric"
    - name: "billable_charge_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN is_billable = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of charges that are billable - revenue capture efficiency metric"
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`billing_invoice`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Invoice-level metrics tracking billing cycle performance and accounts receivable management"
  source: "`vibe_healthcare_v1`.`billing`.`invoice`"
  dimensions:
    - name: "invoice_status"
      expr: invoice_status
      comment: "Current status of the invoice in the billing workflow"
    - name: "created_year"
      expr: YEAR(created_timestamp)
      comment: "Year when the invoice was created"
    - name: "created_month"
      expr: DATE_TRUNC('MONTH', created_timestamp)
      comment: "Month when the invoice was created"
    - name: "created_date"
      expr: DATE(created_timestamp)
      comment: "Date when the invoice was created"
  measures:
    - name: "invoice_count"
      expr: COUNT(1)
      comment: "Total number of invoices generated - billing cycle volume metric"
    - name: "distinct_patient_account_count"
      expr: COUNT(DISTINCT patient_account_id)
      comment: "Unique patient accounts with invoices - accounts receivable breadth metric"
    - name: "distinct_visit_count"
      expr: COUNT(DISTINCT visit_id)
      comment: "Unique visits invoiced - encounter billing completion metric"
    - name: "distinct_payer_count"
      expr: COUNT(DISTINCT payer_id)
      comment: "Unique payers invoiced - payer mix diversity metric"
    - name: "avg_invoices_per_patient_account"
      expr: COUNT(1) / NULLIF(COUNT(DISTINCT patient_account_id), 0)
      comment: "Average number of invoices per patient account - billing fragmentation indicator"
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`billing_payment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Payment transaction metrics tracking cash collection and accounts receivable performance"
  source: "`vibe_healthcare_v1`.`billing`.`payment`"
  dimensions:
    - name: "payment_status"
      expr: payment_status
      comment: "Current status of the payment transaction"
    - name: "created_year"
      expr: YEAR(created_timestamp)
      comment: "Year when the payment was recorded"
    - name: "created_month"
      expr: DATE_TRUNC('MONTH', created_timestamp)
      comment: "Month when the payment was recorded"
    - name: "created_date"
      expr: DATE(created_timestamp)
      comment: "Date when the payment was recorded"
  measures:
    - name: "payment_count"
      expr: COUNT(1)
      comment: "Total number of payment transactions - cash collection activity volume"
    - name: "distinct_invoice_count"
      expr: COUNT(DISTINCT invoice_id)
      comment: "Unique invoices with payments - collection coverage metric"
    - name: "distinct_payer_count"
      expr: COUNT(DISTINCT payer_id)
      comment: "Unique payers remitting payments - payer engagement metric"
    - name: "avg_payments_per_invoice"
      expr: COUNT(1) / NULLIF(COUNT(DISTINCT invoice_id), 0)
      comment: "Average number of payments per invoice - payment plan complexity and partial payment indicator"
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`billing_adjustment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Billing adjustment metrics tracking revenue cycle corrections, denials, and contractual allowances"
  source: "`vibe_healthcare_v1`.`billing`.`adjustment`"
  dimensions:
    - name: "adjustment_status"
      expr: adjustment_status
      comment: "Current status of the adjustment transaction"
    - name: "created_year"
      expr: YEAR(created_timestamp)
      comment: "Year when the adjustment was created"
    - name: "created_month"
      expr: DATE_TRUNC('MONTH', created_timestamp)
      comment: "Month when the adjustment was created"
    - name: "created_date"
      expr: DATE(created_timestamp)
      comment: "Date when the adjustment was created"
  measures:
    - name: "adjustment_count"
      expr: COUNT(1)
      comment: "Total number of billing adjustments - revenue cycle correction volume and denial activity"
    - name: "distinct_charge_count"
      expr: COUNT(DISTINCT charge_id)
      comment: "Unique charges with adjustments - adjustment breadth metric"
    - name: "distinct_invoice_count"
      expr: COUNT(DISTINCT invoice_id)
      comment: "Unique invoices with adjustments - invoice correction rate indicator"
    - name: "distinct_payer_count"
      expr: COUNT(DISTINCT payer_id)
      comment: "Unique payers associated with adjustments - payer-specific denial and adjustment pattern metric"
    - name: "distinct_denial_count"
      expr: COUNT(DISTINCT denial_id)
      comment: "Unique denials driving adjustments - denial volume metric for revenue cycle management"
    - name: "avg_adjustments_per_charge"
      expr: COUNT(1) / NULLIF(COUNT(DISTINCT charge_id), 0)
      comment: "Average number of adjustments per charge - billing complexity and rework indicator"
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`billing_cdm_entry`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Chargemaster metrics tracking pricing strategy, cost recovery, and charge capture configuration"
  source: "`vibe_healthcare_v1`.`billing`.`cdm_entry`"
  dimensions:
    - name: "cdm_entry_status"
      expr: cdm_entry_status
      comment: "Current status of the chargemaster entry (active, inactive, pending)"
    - name: "item_type"
      expr: item_type
      comment: "Type of chargeable item (procedure, supply, drug, service)"
    - name: "charge_category"
      expr: charge_category
      comment: "Business category of the charge item"
    - name: "revenue_code"
      expr: revenue_code
      comment: "UB-04 revenue code for hospital billing classification"
    - name: "active_flag"
      expr: active_flag
      comment: "Flag indicating whether the CDM entry is currently active for charge capture"
    - name: "requires_authorization_flag"
      expr: requires_authorization_flag
      comment: "Flag indicating whether the service requires prior authorization"
    - name: "price_transparency_flag"
      expr: price_transparency_flag
      comment: "Flag indicating whether the item is subject to price transparency reporting requirements"
    - name: "effective_year"
      expr: YEAR(effective_date)
      comment: "Year when the CDM entry became effective"
    - name: "effective_month"
      expr: DATE_TRUNC('MONTH', effective_date)
      comment: "Month when the CDM entry became effective"
  measures:
    - name: "cdm_entry_count"
      expr: COUNT(1)
      comment: "Total number of chargemaster entries - pricing catalog size metric"
    - name: "active_cdm_entry_count"
      expr: SUM(CASE WHEN active_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of active chargemaster entries available for charge capture"
    - name: "avg_charge_amount"
      expr: AVG(CAST(charge_amount AS DOUBLE))
      comment: "Average charge amount across all CDM entries - pricing level benchmark"
    - name: "avg_cost_amount"
      expr: AVG(CAST(cost_amount AS DOUBLE))
      comment: "Average cost amount across all CDM entries - cost structure benchmark"
    - name: "total_charge_amount"
      expr: SUM(CAST(charge_amount AS DOUBLE))
      comment: "Total charge amount across all CDM entries - aggregate pricing metric"
    - name: "total_cost_amount"
      expr: SUM(CAST(cost_amount AS DOUBLE))
      comment: "Total cost amount across all CDM entries - aggregate cost metric"
    - name: "avg_markup_ratio"
      expr: AVG(CAST(charge_amount AS DOUBLE) / NULLIF(CAST(cost_amount AS DOUBLE), 0))
      comment: "Average charge-to-cost ratio across CDM entries - pricing strategy and cost recovery metric"
    - name: "prior_auth_requirement_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN requires_authorization_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of CDM entries requiring prior authorization - administrative burden indicator"
    - name: "price_transparency_coverage_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN price_transparency_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of CDM entries subject to price transparency requirements - regulatory compliance metric"
    - name: "avg_total_rvu"
      expr: AVG(CAST(rvu_work AS DOUBLE) + CAST(rvu_practice_expense AS DOUBLE) + CAST(rvu_malpractice AS DOUBLE))
      comment: "Average total relative value units (work + practice expense + malpractice) - physician service intensity metric"
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`billing_patient_account`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Patient account metrics tracking accounts receivable portfolio and patient financial engagement"
  source: "`vibe_healthcare_v1`.`billing`.`patient_account`"
  dimensions:
    - name: "patient_account_status"
      expr: patient_account_status
      comment: "Current status of the patient account (active, closed, collections, etc.)"
    - name: "created_year"
      expr: YEAR(created_timestamp)
      comment: "Year when the patient account was created"
    - name: "created_month"
      expr: DATE_TRUNC('MONTH', created_timestamp)
      comment: "Month when the patient account was created"
  measures:
    - name: "patient_account_count"
      expr: COUNT(1)
      comment: "Total number of patient accounts - accounts receivable portfolio size"
    - name: "distinct_patient_count"
      expr: COUNT(DISTINCT mpi_record_id)
      comment: "Unique patients with billing accounts - patient financial engagement breadth"
    - name: "distinct_guarantor_count"
      expr: COUNT(DISTINCT guarantor_id)
      comment: "Unique guarantors responsible for patient accounts - financial responsibility diversity"
    - name: "avg_accounts_per_patient"
      expr: COUNT(1) / NULLIF(COUNT(DISTINCT mpi_record_id), 0)
      comment: "Average number of accounts per patient - account fragmentation and complexity indicator"
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`billing_payment_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Payment plan metrics tracking patient financial assistance and installment payment arrangements"
  source: "`vibe_healthcare_v1`.`billing`.`payment_plan`"
  dimensions:
    - name: "payment_plan_status"
      expr: payment_plan_status
      comment: "Current status of the payment plan (active, completed, defaulted, etc.)"
    - name: "created_year"
      expr: YEAR(created_timestamp)
      comment: "Year when the payment plan was created"
    - name: "created_month"
      expr: DATE_TRUNC('MONTH', created_timestamp)
      comment: "Month when the payment plan was created"
  measures:
    - name: "payment_plan_count"
      expr: COUNT(1)
      comment: "Total number of payment plans - patient financial assistance volume and affordability indicator"
    - name: "distinct_patient_account_count"
      expr: COUNT(DISTINCT patient_account_id)
      comment: "Unique patient accounts with payment plans - financial hardship breadth metric"
    - name: "distinct_invoice_count"
      expr: COUNT(DISTINCT invoice_id)
      comment: "Unique invoices covered by payment plans - payment plan coverage metric"
    - name: "avg_payment_plans_per_account"
      expr: COUNT(1) / NULLIF(COUNT(DISTINCT patient_account_id), 0)
      comment: "Average number of payment plans per patient account - financial complexity and renegotiation indicator"
$$;