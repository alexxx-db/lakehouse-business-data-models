-- Metric views for domain: billing | Business: Healthcare | Version: 2 | Generated on: 2026-07-02 07:21:53

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`billing_adjustment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Adjustment business metrics"
  source: "`vibe_healthcare_v1`.`billing`.`adjustment`"
  dimensions:
    - name: "Billing Domain Marker"
      expr: billing_domain_marker
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Adjustment Status"
      expr: adjustment_status
    - name: "Updated Timestamp"
      expr: updated_timestamp
    - name: "Vibe Mutation Applied"
      expr: vibe_mutation_applied
    - name: "Vibe Mutation Flag"
      expr: vibe_mutation_flag
    - name: "Vibe Mutation Marker"
      expr: vibe_mutation_marker
    - name: "Vibe Structure Marker"
      expr: vibe_structure_marker
    - name: "Created Timestamp Month"
      expr: DATE_TRUNC('MONTH', created_timestamp)
    - name: "Updated Timestamp Month"
      expr: DATE_TRUNC('MONTH', updated_timestamp)
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Adjustment"
      expr: COUNT(DISTINCT adjustment_id)
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`billing_billing_coverage`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Billing Coverage business metrics"
  source: "`vibe_healthcare_v1`.`billing`.`billing_coverage`"
  dimensions:
    - name: "Billing Domain Marker"
      expr: billing_domain_marker
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Ssot Reference"
      expr: ssot_reference
    - name: "Billing Coverage Status"
      expr: billing_coverage_status
    - name: "Updated Timestamp"
      expr: updated_timestamp
    - name: "Vibe Mutation Applied"
      expr: vibe_mutation_applied
    - name: "Vibe Mutation Flag"
      expr: vibe_mutation_flag
    - name: "Vibe Mutation Marker"
      expr: vibe_mutation_marker
    - name: "Vibe Structure Marker"
      expr: vibe_structure_marker
    - name: "Created Timestamp Month"
      expr: DATE_TRUNC('MONTH', created_timestamp)
    - name: "Updated Timestamp Month"
      expr: DATE_TRUNC('MONTH', updated_timestamp)
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Billing Coverage"
      expr: COUNT(DISTINCT billing_coverage_id)
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`billing_billing_network_participation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Billing Network Participation business metrics"
  source: "`vibe_healthcare_v1`.`billing`.`billing_network_participation`"
  dimensions:
    - name: "Billing Domain Marker"
      expr: billing_domain_marker
    - name: "Consolidated Target"
      expr: consolidated_target
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Participant Type"
      expr: participant_type
    - name: "Ssot Canonical Reference"
      expr: ssot_canonical_reference
    - name: "Ssot Consolidation Note"
      expr: ssot_consolidation_note
    - name: "Billing Network Participation Status"
      expr: billing_network_participation_status
    - name: "Updated Timestamp"
      expr: updated_timestamp
    - name: "Vibe Mutation Applied"
      expr: vibe_mutation_applied
    - name: "Vibe Mutation Flag"
      expr: vibe_mutation_flag
    - name: "Vibe Mutation Marker"
      expr: vibe_mutation_marker
    - name: "Vibe Structure Marker"
      expr: vibe_structure_marker
    - name: "Created Timestamp Month"
      expr: DATE_TRUNC('MONTH', created_timestamp)
    - name: "Updated Timestamp Month"
      expr: DATE_TRUNC('MONTH', updated_timestamp)
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Billing Network Participation"
      expr: COUNT(DISTINCT billing_network_participation_id)
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`billing_cdm_entry`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Cdm Entry business metrics"
  source: "`vibe_healthcare_v1`.`billing`.`cdm_entry`"
  dimensions:
    - name: "Active Flag"
      expr: active_flag
    - name: "Apc Code"
      expr: apc_code
    - name: "Billing Domain Marker"
      expr: billing_domain_marker
    - name: "Bundled Payment Flag"
      expr: bundled_payment_flag
    - name: "Cdm Code"
      expr: cdm_code
    - name: "Cdm Description"
      expr: cdm_description
    - name: "Charge Capture Method"
      expr: charge_capture_method
    - name: "Charge Category"
      expr: charge_category
    - name: "Cost Center Code"
      expr: cost_center_code
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Effective Date"
      expr: effective_date
    - name: "Expiration Date"
      expr: expiration_date
    - name: "Gl Account Code"
      expr: gl_account_code
    - name: "Item Type"
      expr: item_type
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Last Price Update Date"
      expr: last_price_update_date
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Cdm Entry"
      expr: COUNT(DISTINCT cdm_entry_id)
    - name: "Total Charge Amount"
      expr: SUM(charge_amount)
    - name: "Average Charge Amount"
      expr: AVG(charge_amount)
    - name: "Total Cost Amount"
      expr: SUM(cost_amount)
    - name: "Average Cost Amount"
      expr: AVG(cost_amount)
    - name: "Total Default Quantity"
      expr: SUM(default_quantity)
    - name: "Average Default Quantity"
      expr: AVG(default_quantity)
    - name: "Total Drg Weight"
      expr: SUM(drg_weight)
    - name: "Average Drg Weight"
      expr: AVG(drg_weight)
    - name: "Total Rvu Malpractice"
      expr: SUM(rvu_malpractice)
    - name: "Average Rvu Malpractice"
      expr: AVG(rvu_malpractice)
    - name: "Total Rvu Practice Expense"
      expr: SUM(rvu_practice_expense)
    - name: "Average Rvu Practice Expense"
      expr: AVG(rvu_practice_expense)
    - name: "Total Rvu Work"
      expr: SUM(rvu_work)
    - name: "Average Rvu Work"
      expr: AVG(rvu_work)
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`billing_charge`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Charge business metrics"
  source: "`vibe_healthcare_v1`.`billing`.`charge`"
  dimensions:
    - name: "Billing Domain Marker"
      expr: billing_domain_marker
    - name: "Charge Category"
      expr: charge_category
    - name: "Charge Number"
      expr: charge_number
    - name: "Charge Status"
      expr: charge_status
    - name: "Charge Type"
      expr: charge_type
    - name: "Charge Code"
      expr: charge_code
    - name: "Correction Reason"
      expr: correction_reason
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Diagnosis Pointer"
      expr: diagnosis_pointer
    - name: "Drug Unit Of Measure"
      expr: drug_unit_of_measure
    - name: "Hold Date"
      expr: hold_date
    - name: "Hold Reason"
      expr: hold_reason
    - name: "Implant Flag"
      expr: implant_flag
    - name: "Is Billable"
      expr: is_billable
    - name: "Is Corrected"
      expr: is_corrected
    - name: "Is Patient Responsible"
      expr: is_patient_responsible
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Charge"
      expr: COUNT(DISTINCT charge_id)
    - name: "Total Expected Reimbursement Amount"
      expr: SUM(expected_reimbursement_amount)
    - name: "Average Expected Reimbursement Amount"
      expr: AVG(expected_reimbursement_amount)
    - name: "Total Gross Charge Amount"
      expr: SUM(gross_charge_amount)
    - name: "Average Gross Charge Amount"
      expr: AVG(gross_charge_amount)
    - name: "Total Quantity"
      expr: SUM(quantity)
    - name: "Average Quantity"
      expr: AVG(quantity)
    - name: "Total Quantity Used"
      expr: SUM(quantity_used)
    - name: "Average Quantity Used"
      expr: AVG(quantity_used)
    - name: "Total Unit Price"
      expr: SUM(unit_price)
    - name: "Average Unit Price"
      expr: AVG(unit_price)
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`billing_charity_care_application`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Charity Care Application business metrics"
  source: "`vibe_healthcare_v1`.`billing`.`charity_care_application`"
  dimensions:
    - name: "Billing Domain Marker"
      expr: billing_domain_marker
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Charity Care Application Status"
      expr: charity_care_application_status
    - name: "Updated Timestamp"
      expr: updated_timestamp
    - name: "Vibe Mutation Applied"
      expr: vibe_mutation_applied
    - name: "Vibe Mutation Flag"
      expr: vibe_mutation_flag
    - name: "Vibe Mutation Marker"
      expr: vibe_mutation_marker
    - name: "Vibe Structure Marker"
      expr: vibe_structure_marker
    - name: "Created Timestamp Month"
      expr: DATE_TRUNC('MONTH', created_timestamp)
    - name: "Updated Timestamp Month"
      expr: DATE_TRUNC('MONTH', updated_timestamp)
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Charity Care Application"
      expr: COUNT(DISTINCT charity_care_application_id)
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`billing_coding_assignment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Coding Assignment business metrics"
  source: "`vibe_healthcare_v1`.`billing`.`coding_assignment`"
  dimensions:
    - name: "Billing Domain Marker"
      expr: billing_domain_marker
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Coding Assignment Status"
      expr: coding_assignment_status
    - name: "Updated Timestamp"
      expr: updated_timestamp
    - name: "Vibe Mutation Applied"
      expr: vibe_mutation_applied
    - name: "Vibe Mutation Flag"
      expr: vibe_mutation_flag
    - name: "Vibe Mutation Marker"
      expr: vibe_mutation_marker
    - name: "Vibe Structure Marker"
      expr: vibe_structure_marker
    - name: "Created Timestamp Month"
      expr: DATE_TRUNC('MONTH', created_timestamp)
    - name: "Updated Timestamp Month"
      expr: DATE_TRUNC('MONTH', updated_timestamp)
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Coding Assignment"
      expr: COUNT(DISTINCT coding_assignment_id)
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`billing_collection_account`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Collection Account business metrics"
  source: "`vibe_healthcare_v1`.`billing`.`collection_account`"
  dimensions:
    - name: "Billing Domain Marker"
      expr: billing_domain_marker
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Collection Account Status"
      expr: collection_account_status
    - name: "Updated Timestamp"
      expr: updated_timestamp
    - name: "Vibe Mutation Applied"
      expr: vibe_mutation_applied
    - name: "Vibe Mutation Flag"
      expr: vibe_mutation_flag
    - name: "Vibe Mutation Marker"
      expr: vibe_mutation_marker
    - name: "Vibe Structure Marker"
      expr: vibe_structure_marker
    - name: "Created Timestamp Month"
      expr: DATE_TRUNC('MONTH', created_timestamp)
    - name: "Updated Timestamp Month"
      expr: DATE_TRUNC('MONTH', updated_timestamp)
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Collection Account"
      expr: COUNT(DISTINCT collection_account_id)
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`billing_invoice`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Invoice business metrics"
  source: "`vibe_healthcare_v1`.`billing`.`invoice`"
  dimensions:
    - name: "Billing Domain Marker"
      expr: billing_domain_marker
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Invoice Status"
      expr: invoice_status
    - name: "Updated Timestamp"
      expr: updated_timestamp
    - name: "Vibe Mutation Applied"
      expr: vibe_mutation_applied
    - name: "Vibe Mutation Flag"
      expr: vibe_mutation_flag
    - name: "Vibe Mutation Marker"
      expr: vibe_mutation_marker
    - name: "Vibe Structure Marker"
      expr: vibe_structure_marker
    - name: "Created Timestamp Month"
      expr: DATE_TRUNC('MONTH', created_timestamp)
    - name: "Updated Timestamp Month"
      expr: DATE_TRUNC('MONTH', updated_timestamp)
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Invoice"
      expr: COUNT(DISTINCT invoice_id)
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`billing_invoice_coverage_billing`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Invoice Coverage Billing business metrics"
  source: "`vibe_healthcare_v1`.`billing`.`invoice_coverage_billing`"
  dimensions:
    - name: "Billing Domain Marker"
      expr: billing_domain_marker
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Invoice Coverage Billing Status"
      expr: invoice_coverage_billing_status
    - name: "Updated Timestamp"
      expr: updated_timestamp
    - name: "Vibe Mutation Applied"
      expr: vibe_mutation_applied
    - name: "Vibe Mutation Flag"
      expr: vibe_mutation_flag
    - name: "Vibe Mutation Marker"
      expr: vibe_mutation_marker
    - name: "Vibe Structure Marker"
      expr: vibe_structure_marker
    - name: "Created Timestamp Month"
      expr: DATE_TRUNC('MONTH', created_timestamp)
    - name: "Updated Timestamp Month"
      expr: DATE_TRUNC('MONTH', updated_timestamp)
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Invoice Coverage Billing"
      expr: COUNT(DISTINCT invoice_coverage_billing_id)
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`billing_invoice_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Invoice Line business metrics"
  source: "`vibe_healthcare_v1`.`billing`.`invoice_line`"
  dimensions:
    - name: "Billing Domain Marker"
      expr: billing_domain_marker
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Invoice Line Status"
      expr: invoice_line_status
    - name: "Updated Timestamp"
      expr: updated_timestamp
    - name: "Vibe Mutation Applied"
      expr: vibe_mutation_applied
    - name: "Vibe Mutation Flag"
      expr: vibe_mutation_flag
    - name: "Vibe Mutation Marker"
      expr: vibe_mutation_marker
    - name: "Vibe Structure Marker"
      expr: vibe_structure_marker
    - name: "Created Timestamp Month"
      expr: DATE_TRUNC('MONTH', created_timestamp)
    - name: "Updated Timestamp Month"
      expr: DATE_TRUNC('MONTH', updated_timestamp)
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Invoice Line"
      expr: COUNT(DISTINCT invoice_line_id)
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`billing_invoice_line_item`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Invoice Line Item business metrics"
  source: "`vibe_healthcare_v1`.`billing`.`invoice_line_item`"
  dimensions:
    - name: "Billing Domain Marker"
      expr: billing_domain_marker
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Invoice Line Item Status"
      expr: invoice_line_item_status
    - name: "Updated Timestamp"
      expr: updated_timestamp
    - name: "Vibe Mutation Applied"
      expr: vibe_mutation_applied
    - name: "Vibe Mutation Flag"
      expr: vibe_mutation_flag
    - name: "Vibe Mutation Marker"
      expr: vibe_mutation_marker
    - name: "Vibe Structure Marker"
      expr: vibe_structure_marker
    - name: "Created Timestamp Month"
      expr: DATE_TRUNC('MONTH', created_timestamp)
    - name: "Updated Timestamp Month"
      expr: DATE_TRUNC('MONTH', updated_timestamp)
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Invoice Line Item"
      expr: COUNT(DISTINCT invoice_line_item_id)
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`billing_patient_account`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Patient Account business metrics"
  source: "`vibe_healthcare_v1`.`billing`.`patient_account`"
  dimensions:
    - name: "Billing Domain Marker"
      expr: billing_domain_marker
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Patient Account Status"
      expr: patient_account_status
    - name: "Updated Timestamp"
      expr: updated_timestamp
    - name: "Vibe Mutation Applied"
      expr: vibe_mutation_applied
    - name: "Vibe Mutation Flag"
      expr: vibe_mutation_flag
    - name: "Vibe Mutation Marker"
      expr: vibe_mutation_marker
    - name: "Vibe Structure Marker"
      expr: vibe_structure_marker
    - name: "Created Timestamp Month"
      expr: DATE_TRUNC('MONTH', created_timestamp)
    - name: "Updated Timestamp Month"
      expr: DATE_TRUNC('MONTH', updated_timestamp)
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Patient Account"
      expr: COUNT(DISTINCT patient_account_id)
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`billing_payment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Payment business metrics"
  source: "`vibe_healthcare_v1`.`billing`.`payment`"
  dimensions:
    - name: "Billing Domain Marker"
      expr: billing_domain_marker
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Payment Status"
      expr: payment_status
    - name: "Updated Timestamp"
      expr: updated_timestamp
    - name: "Vibe Mutation Applied"
      expr: vibe_mutation_applied
    - name: "Vibe Mutation Flag"
      expr: vibe_mutation_flag
    - name: "Vibe Mutation Marker"
      expr: vibe_mutation_marker
    - name: "Vibe Structure Marker"
      expr: vibe_structure_marker
    - name: "Created Timestamp Month"
      expr: DATE_TRUNC('MONTH', created_timestamp)
    - name: "Updated Timestamp Month"
      expr: DATE_TRUNC('MONTH', updated_timestamp)
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Payment"
      expr: COUNT(DISTINCT payment_id)
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`billing_payment_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Payment Plan business metrics"
  source: "`vibe_healthcare_v1`.`billing`.`payment_plan`"
  dimensions:
    - name: "Billing Domain Marker"
      expr: billing_domain_marker
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Payment Plan Status"
      expr: payment_plan_status
    - name: "Updated Timestamp"
      expr: updated_timestamp
    - name: "Vibe Mutation Applied"
      expr: vibe_mutation_applied
    - name: "Vibe Mutation Flag"
      expr: vibe_mutation_flag
    - name: "Vibe Mutation Marker"
      expr: vibe_mutation_marker
    - name: "Vibe Structure Marker"
      expr: vibe_structure_marker
    - name: "Created Timestamp Month"
      expr: DATE_TRUNC('MONTH', created_timestamp)
    - name: "Updated Timestamp Month"
      expr: DATE_TRUNC('MONTH', updated_timestamp)
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Payment Plan"
      expr: COUNT(DISTINCT payment_plan_id)
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`billing_rac_audit`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Rac Audit business metrics"
  source: "`vibe_healthcare_v1`.`billing`.`rac_audit`"
  dimensions:
    - name: "Billing Domain Marker"
      expr: billing_domain_marker
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Rac Audit Status"
      expr: rac_audit_status
    - name: "Updated Timestamp"
      expr: updated_timestamp
    - name: "Vibe Mutation Applied"
      expr: vibe_mutation_applied
    - name: "Vibe Mutation Flag"
      expr: vibe_mutation_flag
    - name: "Vibe Mutation Marker"
      expr: vibe_mutation_marker
    - name: "Vibe Structure Marker"
      expr: vibe_structure_marker
    - name: "Created Timestamp Month"
      expr: DATE_TRUNC('MONTH', created_timestamp)
    - name: "Updated Timestamp Month"
      expr: DATE_TRUNC('MONTH', updated_timestamp)
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Rac Audit"
      expr: COUNT(DISTINCT rac_audit_id)
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`billing_refund`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Refund business metrics"
  source: "`vibe_healthcare_v1`.`billing`.`refund`"
  dimensions:
    - name: "Billing Domain Marker"
      expr: billing_domain_marker
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Refund Status"
      expr: refund_status
    - name: "Updated Timestamp"
      expr: updated_timestamp
    - name: "Vibe Mutation Applied"
      expr: vibe_mutation_applied
    - name: "Vibe Mutation Flag"
      expr: vibe_mutation_flag
    - name: "Vibe Mutation Marker"
      expr: vibe_mutation_marker
    - name: "Vibe Structure Marker"
      expr: vibe_structure_marker
    - name: "Created Timestamp Month"
      expr: DATE_TRUNC('MONTH', created_timestamp)
    - name: "Updated Timestamp Month"
      expr: DATE_TRUNC('MONTH', updated_timestamp)
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Refund"
      expr: COUNT(DISTINCT refund_id)
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`billing_site_cdm_pricing`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Site Cdm Pricing business metrics"
  source: "`vibe_healthcare_v1`.`billing`.`site_cdm_pricing`"
  dimensions:
    - name: "Active Flag"
      expr: active_flag
    - name: "Approval Date"
      expr: approval_date
    - name: "Approval Required Flag"
      expr: approval_required_flag
    - name: "Approval Status"
      expr: approval_status
    - name: "Approved By"
      expr: approved_by
    - name: "Billing Domain Marker"
      expr: billing_domain_marker
    - name: "Cms Price Transparency Code"
      expr: cms_price_transparency_code
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "De Identified Price Flag"
      expr: de_identified_price_flag
    - name: "Effective Date"
      expr: effective_date
    - name: "Expiration Date"
      expr: expiration_date
    - name: "Extra Attr 1"
      expr: extra_attr_1
    - name: "Extra Attr 2"
      expr: extra_attr_2
    - name: "Extra Attr 3"
      expr: extra_attr_3
    - name: "Extra Attr 4"
      expr: extra_attr_4
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Site Cdm Pricing"
      expr: COUNT(DISTINCT site_cdm_pricing_id)
    - name: "Total Contract Price"
      expr: SUM(contract_price)
    - name: "Average Contract Price"
      expr: AVG(contract_price)
    - name: "Total Discount Percentage"
      expr: SUM(discount_percentage)
    - name: "Average Discount Percentage"
      expr: AVG(discount_percentage)
    - name: "Total Gross Charge Amount"
      expr: SUM(gross_charge_amount)
    - name: "Average Gross Charge Amount"
      expr: AVG(gross_charge_amount)
    - name: "Total List Price"
      expr: SUM(list_price)
    - name: "Average List Price"
      expr: AVG(list_price)
    - name: "Total Markup Percentage"
      expr: SUM(markup_percentage)
    - name: "Average Markup Percentage"
      expr: AVG(markup_percentage)
    - name: "Total Maximum Charge Amount"
      expr: SUM(maximum_charge_amount)
    - name: "Average Maximum Charge Amount"
      expr: AVG(maximum_charge_amount)
    - name: "Total Maximum Price"
      expr: SUM(maximum_price)
    - name: "Average Maximum Price"
      expr: AVG(maximum_price)
    - name: "Total Medicaid Price"
      expr: SUM(medicaid_price)
    - name: "Average Medicaid Price"
      expr: AVG(medicaid_price)
    - name: "Total Medicare Price"
      expr: SUM(medicare_price)
    - name: "Average Medicare Price"
      expr: AVG(medicare_price)
    - name: "Total Minimum Charge Amount"
      expr: SUM(minimum_charge_amount)
    - name: "Average Minimum Charge Amount"
      expr: AVG(minimum_charge_amount)
    - name: "Total Minimum Price"
      expr: SUM(minimum_price)
    - name: "Average Minimum Price"
      expr: AVG(minimum_price)
    - name: "Total Negotiated Rate Amount"
      expr: SUM(negotiated_rate_amount)
    - name: "Average Negotiated Rate Amount"
      expr: AVG(negotiated_rate_amount)
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`billing_statement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Statement business metrics"
  source: "`vibe_healthcare_v1`.`billing`.`statement`"
  dimensions:
    - name: "Billing Domain Marker"
      expr: billing_domain_marker
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Statement Status"
      expr: statement_status
    - name: "Updated Timestamp"
      expr: updated_timestamp
    - name: "Vibe Mutation Applied"
      expr: vibe_mutation_applied
    - name: "Vibe Mutation Flag"
      expr: vibe_mutation_flag
    - name: "Vibe Mutation Marker"
      expr: vibe_mutation_marker
    - name: "Vibe Structure Marker"
      expr: vibe_structure_marker
    - name: "Created Timestamp Month"
      expr: DATE_TRUNC('MONTH', created_timestamp)
    - name: "Updated Timestamp Month"
      expr: DATE_TRUNC('MONTH', updated_timestamp)
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Statement"
      expr: COUNT(DISTINCT statement_id)
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`billing_study_service_coverage`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Study Service Coverage business metrics"
  source: "`vibe_healthcare_v1`.`billing`.`study_service_coverage`"
  dimensions:
    - name: "Billing Domain Marker"
      expr: billing_domain_marker
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Study Service Coverage Status"
      expr: study_service_coverage_status
    - name: "Updated Timestamp"
      expr: updated_timestamp
    - name: "Vibe Mutation Applied"
      expr: vibe_mutation_applied
    - name: "Vibe Mutation Flag"
      expr: vibe_mutation_flag
    - name: "Vibe Mutation Marker"
      expr: vibe_mutation_marker
    - name: "Vibe Structure Marker"
      expr: vibe_structure_marker
    - name: "Created Timestamp Month"
      expr: DATE_TRUNC('MONTH', created_timestamp)
    - name: "Updated Timestamp Month"
      expr: DATE_TRUNC('MONTH', updated_timestamp)
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Study Service Coverage"
      expr: COUNT(DISTINCT study_service_coverage_id)
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`billing_write_off`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Write Off business metrics"
  source: "`vibe_healthcare_v1`.`billing`.`write_off`"
  dimensions:
    - name: "Billing Domain Marker"
      expr: billing_domain_marker
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Write Off Status"
      expr: write_off_status
    - name: "Updated Timestamp"
      expr: updated_timestamp
    - name: "Vibe Mutation Applied"
      expr: vibe_mutation_applied
    - name: "Vibe Mutation Flag"
      expr: vibe_mutation_flag
    - name: "Vibe Mutation Marker"
      expr: vibe_mutation_marker
    - name: "Vibe Structure Marker"
      expr: vibe_structure_marker
    - name: "Created Timestamp Month"
      expr: DATE_TRUNC('MONTH', created_timestamp)
    - name: "Updated Timestamp Month"
      expr: DATE_TRUNC('MONTH', updated_timestamp)
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Write Off"
      expr: COUNT(DISTINCT write_off_id)
$$;