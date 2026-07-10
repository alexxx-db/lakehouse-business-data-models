-- Metric views for domain: pharmacy | Business: Healthcare | Version: 2 | Generated on: 2026-07-10 16:21:22

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`pharmacy_adverse_drug_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Adverse Drug Event business metrics"
  source: "`vibe_healthcare_v1`.`pharmacy`.`adverse_drug_event`"
  dimensions:
    - name: "Adverse Drug Event Status"
      expr: adverse_drug_event_status
    - name: "Causative Drug Ndc"
      expr: causative_drug_ndc
    - name: "Contributing Factors"
      expr: contributing_factors
    - name: "Corrective Actions"
      expr: corrective_actions
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Detection Method"
      expr: detection_method
    - name: "Event Date"
      expr: event_date
    - name: "Event Description"
      expr: event_description
    - name: "Event Number"
      expr: event_number
    - name: "Event Timestamp"
      expr: event_timestamp
    - name: "Event Type"
      expr: event_type
    - name: "Fda Report Number"
      expr: fda_report_number
    - name: "Harm Category"
      expr: harm_category
    - name: "Intervention Description"
      expr: intervention_description
    - name: "Intervention Required"
      expr: intervention_required
    - name: "Ismp Report Number"
      expr: ismp_report_number
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Adverse Drug Event"
      expr: COUNT(DISTINCT adverse_drug_event_id)
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`pharmacy_controlled_substance_log`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Controlled Substance Log business metrics"
  source: "`vibe_healthcare_v1`.`pharmacy`.`controlled_substance_log`"
  dimensions:
    - name: "Adc Device Code"
      expr: adc_device_code
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Dea Form 222 Number"
      expr: dea_form_222_number
    - name: "Dea Schedule"
      expr: dea_schedule
    - name: "Department Code"
      expr: department_code
    - name: "Discrepancy Flag"
      expr: discrepancy_flag
    - name: "Discrepancy Reason"
      expr: discrepancy_reason
    - name: "Drug Ndc"
      expr: drug_ndc
    - name: "Expiration Date"
      expr: expiration_date
    - name: "Lot Number"
      expr: lot_number
    - name: "Modified Timestamp"
      expr: modified_timestamp
    - name: "Notes"
      expr: notes
    - name: "Override Flag"
      expr: override_flag
    - name: "Override Reason"
      expr: override_reason
    - name: "Patient Mrn"
      expr: patient_mrn
    - name: "Pdmp Reported Flag"
      expr: pdmp_reported_flag
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Controlled Substance Log"
      expr: COUNT(DISTINCT controlled_substance_log_id)
    - name: "Total Quantity"
      expr: SUM(quantity)
    - name: "Average Quantity"
      expr: AVG(quantity)
    - name: "Total Running Balance"
      expr: SUM(running_balance)
    - name: "Average Running Balance"
      expr: AVG(running_balance)
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`pharmacy_dispense_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Dispense Event business metrics"
  source: "`vibe_healthcare_v1`.`pharmacy`.`dispense_event`"
  dimensions:
    - name: "Controlled Substance Tracking Number"
      expr: controlled_substance_tracking_number
    - name: "Currency Code"
      expr: currency_code
    - name: "Days Supply"
      expr: days_supply
    - name: "Dea Schedule"
      expr: dea_schedule
    - name: "Dispense Status"
      expr: dispense_status
    - name: "Dispense Timestamp"
      expr: dispense_timestamp
    - name: "Dispense Type"
      expr: dispense_type
    - name: "Dispensing Location Name"
      expr: dispensing_location_name
    - name: "Expiration Date"
      expr: expiration_date
    - name: "Fill Number"
      expr: fill_number
    - name: "Lot Number"
      expr: lot_number
    - name: "Ndc Code"
      expr: ndc_code
    - name: "Patient Counseling Completed Flag"
      expr: patient_counseling_completed_flag
    - name: "Patient Counseling Declined Flag"
      expr: patient_counseling_declined_flag
    - name: "Prescriber Dea Number"
      expr: prescriber_dea_number
    - name: "Prescriber Npi"
      expr: prescriber_npi
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Dispense Event"
      expr: COUNT(DISTINCT dispense_event_id)
    - name: "Total Dispensed Quantity"
      expr: SUM(dispensed_quantity)
    - name: "Average Dispensed Quantity"
      expr: AVG(dispensed_quantity)
    - name: "Total Dispensing Fee Amount"
      expr: SUM(dispensing_fee_amount)
    - name: "Average Dispensing Fee Amount"
      expr: AVG(dispensing_fee_amount)
    - name: "Total Insurance Paid Amount"
      expr: SUM(insurance_paid_amount)
    - name: "Average Insurance Paid Amount"
      expr: AVG(insurance_paid_amount)
    - name: "Total Medication Cost Amount"
      expr: SUM(medication_cost_amount)
    - name: "Average Medication Cost Amount"
      expr: AVG(medication_cost_amount)
    - name: "Total Patient Pay Amount"
      expr: SUM(patient_pay_amount)
    - name: "Average Patient Pay Amount"
      expr: AVG(patient_pay_amount)
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`pharmacy_drug_master`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Drug Master business metrics"
  source: "`vibe_healthcare_v1`.`pharmacy`.`drug_master`"
  dimensions:
    - name: "Active Status"
      expr: active_status
    - name: "Atc Code"
      expr: atc_code
    - name: "Beyond Use Date Hours"
      expr: beyond_use_date_hours
    - name: "Black Box Warning Flag"
      expr: black_box_warning_flag
    - name: "Brand Name"
      expr: brand_name
    - name: "Controlled Substance Indicator"
      expr: controlled_substance_indicator
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Dea Schedule"
      expr: dea_schedule
    - name: "Discontinuation Date"
      expr: discontinuation_date
    - name: "Discontinuation Reason"
      expr: discontinuation_reason
    - name: "Dosage Form"
      expr: dosage_form
    - name: "Drug Class"
      expr: drug_class
    - name: "Fda Application Number"
      expr: fda_application_number
    - name: "Fda Approval Date"
      expr: fda_approval_date
    - name: "Formulary Status"
      expr: formulary_status
    - name: "Generic Name"
      expr: generic_name
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Drug Master"
      expr: COUNT(DISTINCT drug_master_id)
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`pharmacy_formulary`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Formulary business metrics"
  source: "`vibe_healthcare_v1`.`pharmacy`.`formulary`"
  dimensions:
    - name: "Age Restriction Max"
      expr: age_restriction_max
    - name: "Age Restriction Min"
      expr: age_restriction_min
    - name: "Approval Date"
      expr: approval_date
    - name: "Approved By"
      expr: approved_by
    - name: "Clinical Review Required"
      expr: clinical_review_required
    - name: "Controlled Substance Schedule"
      expr: controlled_substance_schedule
    - name: "Coverage Status"
      expr: coverage_status
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Days Supply Limit"
      expr: days_supply_limit
    - name: "Diagnosis Restriction"
      expr: diagnosis_restriction
    - name: "Effective Date"
      expr: effective_date
    - name: "Expiration Date"
      expr: expiration_date
    - name: "Formulary Status"
      expr: formulary_status
    - name: "Formulary Type"
      expr: formulary_type
    - name: "Gender Restriction"
      expr: gender_restriction
    - name: "Generic Substitution Allowed"
      expr: generic_substitution_allowed
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Formulary"
      expr: COUNT(DISTINCT formulary_id)
    - name: "Total Quantity Limit"
      expr: SUM(quantity_limit)
    - name: "Average Quantity Limit"
      expr: AVG(quantity_limit)
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`pharmacy_inventory`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Inventory business metrics"
  source: "`vibe_healthcare_v1`.`pharmacy`.`inventory`"
  dimensions:
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Days Supply On Hand"
      expr: days_supply_on_hand
    - name: "Dea Schedule"
      expr: dea_schedule
    - name: "Expiration Date"
      expr: expiration_date
    - name: "Formulary Status"
      expr: formulary_status
    - name: "High Alert Medication"
      expr: high_alert_medication
    - name: "Inventory Status"
      expr: inventory_status
    - name: "Last Cycle Count Date"
      expr: last_cycle_count_date
    - name: "Last Dispensed Date"
      expr: last_dispensed_date
    - name: "Last Receipt Date"
      expr: last_receipt_date
    - name: "Last Updated Timestamp"
      expr: last_updated_timestamp
    - name: "Lot Number"
      expr: lot_number
    - name: "Ndc"
      expr: ndc
    - name: "Quarantine Reason"
      expr: quarantine_reason
    - name: "Recall Number"
      expr: recall_number
    - name: "Shortage Indicator"
      expr: shortage_indicator
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Inventory"
      expr: COUNT(DISTINCT inventory_id)
    - name: "Total Average Daily Usage"
      expr: SUM(average_daily_usage)
    - name: "Average Average Daily Usage"
      expr: AVG(average_daily_usage)
    - name: "Total Cycle Count Variance"
      expr: SUM(cycle_count_variance)
    - name: "Average Cycle Count Variance"
      expr: AVG(cycle_count_variance)
    - name: "Total Par Level"
      expr: SUM(par_level)
    - name: "Average Par Level"
      expr: AVG(par_level)
    - name: "Total Quantity On Hand"
      expr: SUM(quantity_on_hand)
    - name: "Average Quantity On Hand"
      expr: AVG(quantity_on_hand)
    - name: "Total Reorder Point"
      expr: SUM(reorder_point)
    - name: "Average Reorder Point"
      expr: AVG(reorder_point)
    - name: "Total Total Value"
      expr: SUM(total_value)
    - name: "Average Total Value"
      expr: AVG(total_value)
    - name: "Total Unit Cost"
      expr: SUM(unit_cost)
    - name: "Average Unit Cost"
      expr: AVG(unit_cost)
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`pharmacy_mar_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Mar Record business metrics"
  source: "`vibe_healthcare_v1`.`pharmacy`.`mar_record`"
  dimensions:
    - name: "Actual Administration Timestamp"
      expr: actual_administration_timestamp
    - name: "Administration Method"
      expr: administration_method
    - name: "Administration Site"
      expr: administration_site
    - name: "Administration Status"
      expr: administration_status
    - name: "Administration Status Reason"
      expr: administration_status_reason
    - name: "Barcode Scan Timestamp"
      expr: barcode_scan_timestamp
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Dea Schedule"
      expr: dea_schedule
    - name: "Documentation Timestamp"
      expr: documentation_timestamp
    - name: "Dose Unit"
      expr: dose_unit
    - name: "Expiration Date"
      expr: expiration_date
    - name: "Infusion Duration Minutes"
      expr: infusion_duration_minutes
    - name: "Infusion Rate Unit"
      expr: infusion_rate_unit
    - name: "Is First Dose"
      expr: is_first_dose
    - name: "Is Stat Order"
      expr: is_stat_order
    - name: "Last Updated Timestamp"
      expr: last_updated_timestamp
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Mar Record"
      expr: COUNT(DISTINCT mar_record_id)
    - name: "Total Dose Given"
      expr: SUM(dose_given)
    - name: "Average Dose Given"
      expr: AVG(dose_given)
    - name: "Total Infusion Rate"
      expr: SUM(infusion_rate)
    - name: "Average Infusion Rate"
      expr: AVG(infusion_rate)
    - name: "Total Waste Amount"
      expr: SUM(waste_amount)
    - name: "Average Waste Amount"
      expr: AVG(waste_amount)
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`pharmacy_prescription`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Prescription business metrics"
  source: "`vibe_healthcare_v1`.`pharmacy`.`prescription`"
  dimensions:
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Daw Code"
      expr: daw_code
    - name: "Days Supply"
      expr: days_supply
    - name: "Dea Schedule"
      expr: dea_schedule
    - name: "Discontinuation Date"
      expr: discontinuation_date
    - name: "Discontinuation Reason"
      expr: discontinuation_reason
    - name: "Dosage Form"
      expr: dosage_form
    - name: "Drug Strength"
      expr: drug_strength
    - name: "Effective Date"
      expr: effective_date
    - name: "Epcs Flag"
      expr: epcs_flag
    - name: "Erx Transmission Status"
      expr: erx_transmission_status
    - name: "Erx Transmission Timestamp"
      expr: erx_transmission_timestamp
    - name: "Expiration Date"
      expr: expiration_date
    - name: "Formulary Status"
      expr: formulary_status
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Number"
      expr: number
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Prescription"
      expr: COUNT(DISTINCT prescription_id)
    - name: "Total Quantity Prescribed"
      expr: SUM(quantity_prescribed)
    - name: "Average Quantity Prescribed"
      expr: AVG(quantity_prescribed)
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`pharmacy_rx_claim`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Rx Claim business metrics"
  source: "`vibe_healthcare_v1`.`pharmacy`.`rx_claim`"
  dimensions:
    - name: "Adjudication Date"
      expr: adjudication_date
    - name: "Bin Number"
      expr: bin_number
    - name: "Claim Date"
      expr: claim_date
    - name: "Claim Number"
      expr: claim_number
    - name: "Claim Status"
      expr: claim_status
    - name: "Cob Indicator"
      expr: cob_indicator
    - name: "Compound Indicator"
      expr: compound_indicator
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Daw Code"
      expr: daw_code
    - name: "Days Supply"
      expr: days_supply
    - name: "Dispensing Pharmacy Ncpdp Number"
      expr: dispensing_pharmacy_ncpdp_number
    - name: "Dosage Form"
      expr: dosage_form
    - name: "Drug Name"
      expr: drug_name
    - name: "Drug Strength"
      expr: drug_strength
    - name: "Fill Date"
      expr: fill_date
    - name: "Group Number"
      expr: group_number
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Rx Claim"
      expr: COUNT(DISTINCT rx_claim_id)
    - name: "Total Dispensing Fee"
      expr: SUM(dispensing_fee)
    - name: "Average Dispensing Fee"
      expr: AVG(dispensing_fee)
    - name: "Total Ingredient Cost"
      expr: SUM(ingredient_cost)
    - name: "Average Ingredient Cost"
      expr: AVG(ingredient_cost)
    - name: "Total Patient Copay"
      expr: SUM(patient_copay)
    - name: "Average Patient Copay"
      expr: AVG(patient_copay)
    - name: "Total Plan Paid Amount"
      expr: SUM(plan_paid_amount)
    - name: "Average Plan Paid Amount"
      expr: AVG(plan_paid_amount)
    - name: "Total Primary Payer Paid Amount"
      expr: SUM(primary_payer_paid_amount)
    - name: "Average Primary Payer Paid Amount"
      expr: AVG(primary_payer_paid_amount)
    - name: "Total Quantity Dispensed"
      expr: SUM(quantity_dispensed)
    - name: "Average Quantity Dispensed"
      expr: AVG(quantity_dispensed)
    - name: "Total Sales Tax"
      expr: SUM(sales_tax)
    - name: "Average Sales Tax"
      expr: AVG(sales_tax)
    - name: "Total Total Amount Paid"
      expr: SUM(total_amount_paid)
    - name: "Average Total Amount Paid"
      expr: AVG(total_amount_paid)
    - name: "Total Usual And Customary Price"
      expr: SUM(usual_and_customary_price)
    - name: "Average Usual And Customary Price"
      expr: AVG(usual_and_customary_price)
$$;