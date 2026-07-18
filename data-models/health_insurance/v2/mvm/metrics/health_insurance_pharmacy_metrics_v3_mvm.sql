-- Metric views for domain: pharmacy | Business: Health_Insurance | Version: 3 | Generated on: 2026-07-10 22:43:25

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`pharmacy_claim_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Claim Line business metrics"
  source: "`vibe_health_insurance_v1`.`pharmacy`.`claim_line`"
  dimensions:
    - name: "Adjudication Timestamp"
      expr: adjudication_timestamp
    - name: "Basis Of Cost Determination"
      expr: basis_of_cost_determination
    - name: "Catastrophic Coverage Indicator"
      expr: catastrophic_coverage_indicator
    - name: "Cob Sequence"
      expr: cob_sequence
    - name: "Compound Indicator"
      expr: compound_indicator
    - name: "Coverage Gap Indicator"
      expr: coverage_gap_indicator
    - name: "Days Supply"
      expr: days_supply
    - name: "Dispense As Written Code"
      expr: dispense_as_written_code
    - name: "Dispensed Date"
      expr: dispensed_date
    - name: "Drug Coverage Status"
      expr: drug_coverage_status
    - name: "Dur Conflict Code"
      expr: dur_conflict_code
    - name: "Dur Outcome Code"
      expr: dur_outcome_code
    - name: "Fill Number"
      expr: fill_number
    - name: "Generic Indicator"
      expr: generic_indicator
    - name: "Line Sequence Number"
      expr: line_sequence_number
    - name: "Line Status"
      expr: line_status
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Claim Line"
      expr: COUNT(DISTINCT claim_line_id)
    - name: "Total Dispensing Fee Amount"
      expr: SUM(dispensing_fee_amount)
    - name: "Average Dispensing Fee Amount"
      expr: AVG(dispensing_fee_amount)
    - name: "Total Gross Drug Cost Amount"
      expr: SUM(gross_drug_cost_amount)
    - name: "Average Gross Drug Cost Amount"
      expr: AVG(gross_drug_cost_amount)
    - name: "Total Incentive Amount"
      expr: SUM(incentive_amount)
    - name: "Average Incentive Amount"
      expr: AVG(incentive_amount)
    - name: "Total Ingredient Cost Amount"
      expr: SUM(ingredient_cost_amount)
    - name: "Average Ingredient Cost Amount"
      expr: AVG(ingredient_cost_amount)
    - name: "Total Manufacturer Discount Amount"
      expr: SUM(manufacturer_discount_amount)
    - name: "Average Manufacturer Discount Amount"
      expr: AVG(manufacturer_discount_amount)
    - name: "Total Patient Pay Amount"
      expr: SUM(patient_pay_amount)
    - name: "Average Patient Pay Amount"
      expr: AVG(patient_pay_amount)
    - name: "Total Plan Paid Amount"
      expr: SUM(plan_paid_amount)
    - name: "Average Plan Paid Amount"
      expr: AVG(plan_paid_amount)
    - name: "Total Quantity Dispensed"
      expr: SUM(quantity_dispensed)
    - name: "Average Quantity Dispensed"
      expr: AVG(quantity_dispensed)
    - name: "Total Sales Tax Amount"
      expr: SUM(sales_tax_amount)
    - name: "Average Sales Tax Amount"
      expr: AVG(sales_tax_amount)
    - name: "Total True Oop Amount"
      expr: SUM(true_oop_amount)
    - name: "Average True Oop Amount"
      expr: AVG(true_oop_amount)
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`pharmacy_dispensing_pharmacy`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Dispensing Pharmacy business metrics"
  source: "`vibe_health_insurance_v1`.`pharmacy`.`dispensing_pharmacy`"
  dimensions:
    - name: "Accepts Electronic Prescriptions"
      expr: accepts_electronic_prescriptions
    - name: "Address Line1"
      expr: address_line1
    - name: "Address Line2"
      expr: address_line2
    - name: "Chain Independent Flag"
      expr: chain_independent_flag
    - name: "Chain Organization Name"
      expr: chain_organization_name
    - name: "City"
      expr: city
    - name: "Cold Chain Certified"
      expr: cold_chain_certified
    - name: "Contract Effective Date"
      expr: contract_effective_date
    - name: "Contract Termination Date"
      expr: contract_termination_date
    - name: "Contract Type"
      expr: contract_type
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Dispensing State Code"
      expr: dispensing_state_code
    - name: "Doing Business As Name"
      expr: doing_business_as_name
    - name: "Fax Number"
      expr: fax_number
    - name: "Ingredient Cost Basis"
      expr: ingredient_cost_basis
    - name: "Line Of Business"
      expr: line_of_business
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Dispensing Pharmacy"
      expr: COUNT(DISTINCT dispensing_pharmacy_id)
    - name: "Total Awp Discount Percent"
      expr: SUM(awp_discount_percent)
    - name: "Average Awp Discount Percent"
      expr: AVG(awp_discount_percent)
    - name: "Total Dispensing Fee Amount"
      expr: SUM(dispensing_fee_amount)
    - name: "Average Dispensing Fee Amount"
      expr: AVG(dispensing_fee_amount)
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`pharmacy_drug_master`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Drug Master business metrics"
  source: "`vibe_health_insurance_v1`.`pharmacy`.`drug_master`"
  dimensions:
    - name: "Atc Code"
      expr: atc_code
    - name: "Awp Effective Date"
      expr: awp_effective_date
    - name: "Brand Name"
      expr: brand_name
    - name: "Controlled Substance Schedule"
      expr: controlled_substance_schedule
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Dea Number Required"
      expr: dea_number_required
    - name: "Dosage Form"
      expr: dosage_form
    - name: "Drug Class Code"
      expr: drug_class_code
    - name: "Drug Class Name"
      expr: drug_class_name
    - name: "Drug Name"
      expr: drug_name
    - name: "Drug Status"
      expr: drug_status
    - name: "Drug Type"
      expr: drug_type
    - name: "Effective Date"
      expr: effective_date
    - name: "Fda Approval Status"
      expr: fda_approval_status
    - name: "Generic Name"
      expr: generic_name
    - name: "Gpi Code"
      expr: gpi_code
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Drug Master"
      expr: COUNT(DISTINCT drug_master_id)
    - name: "Total Awp Unit Price"
      expr: SUM(awp_unit_price)
    - name: "Average Awp Unit Price"
      expr: AVG(awp_unit_price)
    - name: "Total Package Size"
      expr: SUM(package_size)
    - name: "Average Package Size"
      expr: AVG(package_size)
    - name: "Total Wac Unit Price"
      expr: SUM(wac_unit_price)
    - name: "Average Wac Unit Price"
      expr: AVG(wac_unit_price)
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`pharmacy_drug_pricing`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Drug Pricing business metrics"
  source: "`vibe_health_insurance_v1`.`pharmacy`.`drug_pricing`"
  dimensions:
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Days Supply"
      expr: days_supply
    - name: "Dea Schedule"
      expr: dea_schedule
    - name: "Dispensing Channel"
      expr: dispensing_channel
    - name: "Effective Date"
      expr: effective_date
    - name: "Expiration Date"
      expr: expiration_date
    - name: "Formulary Tier"
      expr: formulary_tier
    - name: "Mac List Version"
      expr: mac_list_version
    - name: "Mac Methodology"
      expr: mac_methodology
    - name: "Multi Source Code"
      expr: multi_source_code
    - name: "Package Size Uom"
      expr: package_size_uom
    - name: "Price Type"
      expr: price_type
    - name: "Pricing File Date"
      expr: pricing_file_date
    - name: "Pricing File Name"
      expr: pricing_file_name
    - name: "Pricing Source"
      expr: pricing_source
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Drug Pricing"
      expr: COUNT(DISTINCT drug_pricing_id)
    - name: "Total Awp Discount Pct"
      expr: SUM(awp_discount_pct)
    - name: "Average Awp Discount Pct"
      expr: AVG(awp_discount_pct)
    - name: "Total Awp Price"
      expr: SUM(awp_price)
    - name: "Average Awp Price"
      expr: AVG(awp_price)
    - name: "Total Dispensing Fee"
      expr: SUM(dispensing_fee)
    - name: "Average Dispensing Fee"
      expr: AVG(dispensing_fee)
    - name: "Total Mac Price"
      expr: SUM(mac_price)
    - name: "Average Mac Price"
      expr: AVG(mac_price)
    - name: "Total Package Size"
      expr: SUM(package_size)
    - name: "Average Package Size"
      expr: AVG(package_size)
    - name: "Total Price Change Pct"
      expr: SUM(price_change_pct)
    - name: "Average Price Change Pct"
      expr: AVG(price_change_pct)
    - name: "Total Prior Unit Price"
      expr: SUM(prior_unit_price)
    - name: "Average Prior Unit Price"
      expr: AVG(prior_unit_price)
    - name: "Total Rbp Price"
      expr: SUM(rbp_price)
    - name: "Average Rbp Price"
      expr: AVG(rbp_price)
    - name: "Total Unit Price"
      expr: SUM(unit_price)
    - name: "Average Unit Price"
      expr: AVG(unit_price)
    - name: "Total Wac Price"
      expr: SUM(wac_price)
    - name: "Average Wac Price"
      expr: AVG(wac_price)
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`pharmacy_formulary`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Formulary business metrics"
  source: "`vibe_health_insurance_v1`.`pharmacy`.`formulary`"
  dimensions:
    - name: "Category"
      expr: formulary_category
    - name: "Change Notification Date"
      expr: change_notification_date
    - name: "Cms Formulary Code"
      expr: cms_formulary_code
    - name: "Code"
      expr: code
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Description"
      expr: description
    - name: "Drug Count"
      expr: drug_count
    - name: "Drug Utilization Review Ind"
      expr: drug_utilization_review_ind
    - name: "Effective Date"
      expr: effective_date
    - name: "Formulary Status"
      expr: formulary_status
    - name: "Formulary Type"
      expr: formulary_type
    - name: "Generic Substitution Policy"
      expr: generic_substitution_policy
    - name: "Is Aca Compliant"
      expr: is_aca_compliant
    - name: "Is Cms Part D"
      expr: is_cms_part_d
    - name: "Last Review Date"
      expr: last_review_date
    - name: "Lob Code"
      expr: lob_code
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Formulary"
      expr: COUNT(DISTINCT formulary_id)
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`pharmacy_formulary_drug_tier`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Formulary Drug Tier business metrics"
  source: "`vibe_health_insurance_v1`.`pharmacy`.`formulary_drug_tier`"
  dimensions:
    - name: "Benefit Year"
      expr: benefit_year
    - name: "Coverage Status"
      expr: coverage_status
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Deductible Applies"
      expr: deductible_applies
    - name: "Dispensing Channel"
      expr: dispensing_channel
    - name: "Drug Tier Change Reason"
      expr: drug_tier_change_reason
    - name: "Dur Alert Type"
      expr: dur_alert_type
    - name: "Effective Date"
      expr: effective_date
    - name: "Formulary Status Code"
      expr: formulary_status_code
    - name: "Lob Code"
      expr: lob_code
    - name: "Mac Pricing Applicable"
      expr: mac_pricing_applicable
    - name: "Ndc Code"
      expr: ndc_code
    - name: "Pa Type"
      expr: pa_type
    - name: "Pbm Formulary Code"
      expr: pbm_formulary_code
    - name: "Prior Auth Required"
      expr: prior_auth_required
    - name: "Ql Clinical Basis"
      expr: ql_clinical_basis
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Formulary Drug Tier"
      expr: COUNT(DISTINCT formulary_drug_tier_id)
    - name: "Total Coinsurance Rate"
      expr: SUM(coinsurance_rate)
    - name: "Average Coinsurance Rate"
      expr: AVG(coinsurance_rate)
    - name: "Total Copay Mail Order"
      expr: SUM(copay_mail_order)
    - name: "Average Copay Mail Order"
      expr: AVG(copay_mail_order)
    - name: "Total Copay Retail 30"
      expr: SUM(copay_retail_30)
    - name: "Average Copay Retail 30"
      expr: AVG(copay_retail_30)
    - name: "Total Copay Retail 90"
      expr: SUM(copay_retail_90)
    - name: "Average Copay Retail 90"
      expr: AVG(copay_retail_90)
    - name: "Total Ql Max Quantity"
      expr: SUM(ql_max_quantity)
    - name: "Average Ql Max Quantity"
      expr: AVG(ql_max_quantity)
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`pharmacy_formulary_exception`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Formulary Exception business metrics"
  source: "`vibe_health_insurance_v1`.`pharmacy`.`formulary_exception`"
  dimensions:
    - name: "Appeal Rights Notification Date"
      expr: appeal_rights_notification_date
    - name: "Appeal Rights Notified"
      expr: appeal_rights_notified
    - name: "Clinical Justification"
      expr: clinical_justification
    - name: "Cms Coverage Determination Type"
      expr: cms_coverage_determination_type
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Current Drug Tier"
      expr: current_drug_tier
    - name: "Days Supply Requested"
      expr: days_supply_requested
    - name: "Decision Date"
      expr: decision_date
    - name: "Decision Timestamp"
      expr: decision_timestamp
    - name: "Denial Reason Code"
      expr: denial_reason_code
    - name: "Denial Reason Description"
      expr: denial_reason_description
    - name: "Effective End Date"
      expr: effective_end_date
    - name: "Effective Start Date"
      expr: effective_start_date
    - name: "Exception Request Number"
      expr: exception_request_number
    - name: "Exception Status"
      expr: exception_status
    - name: "Exception Type"
      expr: exception_type
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Formulary Exception"
      expr: COUNT(DISTINCT formulary_exception_id)
    - name: "Total Quantity Requested"
      expr: SUM(quantity_requested)
    - name: "Average Quantity Requested"
      expr: AVG(quantity_requested)
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`pharmacy_pbm_contract`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Pbm Contract business metrics"
  source: "`vibe_health_insurance_v1`.`pharmacy`.`pbm_contract`"
  dimensions:
    - name: "Amendment Date"
      expr: amendment_date
    - name: "Audit Frequency"
      expr: audit_frequency
    - name: "Audit Rights Flag"
      expr: audit_rights_flag
    - name: "Auto Renewal Flag"
      expr: auto_renewal_flag
    - name: "Cms Contract Number"
      expr: cms_contract_number
    - name: "Contract Name"
      expr: contract_name
    - name: "Contract Number"
      expr: contract_number
    - name: "Contract Owner Name"
      expr: contract_owner_name
    - name: "Contract Status"
      expr: contract_status
    - name: "Contract Type"
      expr: contract_type
    - name: "Contract Version"
      expr: contract_version
    - name: "Dur Program Flag"
      expr: dur_program_flag
    - name: "Effective Date"
      expr: effective_date
    - name: "Governing State Code"
      expr: governing_state_code
    - name: "Ingredient Cost Basis"
      expr: ingredient_cost_basis
    - name: "Lob Scope"
      expr: lob_scope
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Pbm Contract"
      expr: COUNT(DISTINCT pbm_contract_id)
    - name: "Total Awp Discount Mail Pct"
      expr: SUM(awp_discount_mail_pct)
    - name: "Average Awp Discount Mail Pct"
      expr: AVG(awp_discount_mail_pct)
    - name: "Total Awp Discount Retail Pct"
      expr: SUM(awp_discount_retail_pct)
    - name: "Average Awp Discount Retail Pct"
      expr: AVG(awp_discount_retail_pct)
    - name: "Total Dispensing Fee Mail Order"
      expr: SUM(dispensing_fee_mail_order)
    - name: "Average Dispensing Fee Mail Order"
      expr: AVG(dispensing_fee_mail_order)
    - name: "Total Dispensing Fee Retail"
      expr: SUM(dispensing_fee_retail)
    - name: "Average Dispensing Fee Retail"
      expr: AVG(dispensing_fee_retail)
    - name: "Total Dispensing Fee Specialty"
      expr: SUM(dispensing_fee_specialty)
    - name: "Average Dispensing Fee Specialty"
      expr: AVG(dispensing_fee_specialty)
    - name: "Total Generic Dispensing Rate Guarantee"
      expr: SUM(generic_dispensing_rate_guarantee)
    - name: "Average Generic Dispensing Rate Guarantee"
      expr: AVG(generic_dispensing_rate_guarantee)
    - name: "Total Mail Order Penetration Guarantee"
      expr: SUM(mail_order_penetration_guarantee)
    - name: "Average Mail Order Penetration Guarantee"
      expr: AVG(mail_order_penetration_guarantee)
    - name: "Total Rebate Guarantee Pmpm"
      expr: SUM(rebate_guarantee_pmpm)
    - name: "Average Rebate Guarantee Pmpm"
      expr: AVG(rebate_guarantee_pmpm)
    - name: "Total Rebate Pass Through Pct"
      expr: SUM(rebate_pass_through_pct)
    - name: "Average Rebate Pass Through Pct"
      expr: AVG(rebate_pass_through_pct)
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`pharmacy_pharmacy_claim`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Pharmacy Claim business metrics"
  source: "`vibe_health_insurance_v1`.`pharmacy`.`pharmacy_claim`"
  dimensions:
    - name: "Adjudication Timestamp"
      expr: adjudication_timestamp
    - name: "Basis Of Cost Determination"
      expr: basis_of_cost_determination
    - name: "Claim Number"
      expr: claim_number
    - name: "Claim Status"
      expr: claim_status
    - name: "Cob Indicator"
      expr: cob_indicator
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Daw Code"
      expr: daw_code
    - name: "Days Supply"
      expr: days_supply
    - name: "Dispensing Pharmacy Npi"
      expr: dispensing_pharmacy_npi
    - name: "Dur Outcome Code"
      expr: dur_outcome_code
    - name: "Fill Date"
      expr: fill_date
    - name: "Is 340b Claim"
      expr: is_340b_claim
    - name: "Is Compound Claim"
      expr: is_compound_claim
    - name: "Line Of Business"
      expr: line_of_business
    - name: "Ndc"
      expr: ndc
    - name: "Original Claim Number"
      expr: original_claim_number
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Pharmacy Claim"
      expr: COUNT(DISTINCT pharmacy_claim_id)
    - name: "Total Deductible Applied"
      expr: SUM(deductible_applied)
    - name: "Average Deductible Applied"
      expr: AVG(deductible_applied)
    - name: "Total Dispensing Fee"
      expr: SUM(dispensing_fee)
    - name: "Average Dispensing Fee"
      expr: AVG(dispensing_fee)
    - name: "Total Ingredient Cost"
      expr: SUM(ingredient_cost)
    - name: "Average Ingredient Cost"
      expr: AVG(ingredient_cost)
    - name: "Total Member Coinsurance"
      expr: SUM(member_coinsurance)
    - name: "Average Member Coinsurance"
      expr: AVG(member_coinsurance)
    - name: "Total Member Copay"
      expr: SUM(member_copay)
    - name: "Average Member Copay"
      expr: AVG(member_copay)
    - name: "Total Plan Paid Amount"
      expr: SUM(plan_paid_amount)
    - name: "Average Plan Paid Amount"
      expr: AVG(plan_paid_amount)
    - name: "Total Quantity Dispensed"
      expr: SUM(quantity_dispensed)
    - name: "Average Quantity Dispensed"
      expr: AVG(quantity_dispensed)
    - name: "Total Sales Tax"
      expr: SUM(sales_tax)
    - name: "Average Sales Tax"
      expr: AVG(sales_tax)
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`pharmacy_prior_authorization`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Prior Authorization business metrics"
  source: "`vibe_health_insurance_v1`.`pharmacy`.`prior_authorization`"
  dimensions:
    - name: "Appeal Indicator"
      expr: appeal_indicator
    - name: "Approved Days Supply"
      expr: approved_days_supply
    - name: "Approved Refills"
      expr: approved_refills
    - name: "Clinical Criteria Version"
      expr: clinical_criteria_version
    - name: "Cms Part D Reportable"
      expr: cms_part_d_reportable
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Criteria Met"
      expr: criteria_met
    - name: "Decision Timestamp"
      expr: decision_timestamp
    - name: "Denial Reason Code"
      expr: denial_reason_code
    - name: "Denial Reason Description"
      expr: denial_reason_description
    - name: "Dispensing Channel"
      expr: dispensing_channel
    - name: "Drug Tier"
      expr: drug_tier
    - name: "Dur Outcome Code"
      expr: dur_outcome_code
    - name: "Effective End Date"
      expr: effective_end_date
    - name: "Effective Start Date"
      expr: effective_start_date
    - name: "Lob"
      expr: lob
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Prior Authorization"
      expr: COUNT(DISTINCT prior_authorization_id)
    - name: "Total Approved Quantity"
      expr: SUM(approved_quantity)
    - name: "Average Approved Quantity"
      expr: AVG(approved_quantity)
$$;
