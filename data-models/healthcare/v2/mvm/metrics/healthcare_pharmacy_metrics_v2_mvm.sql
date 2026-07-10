-- Metric views for domain: pharmacy | Business: Healthcare | Version: 2 | Generated on: 2026-07-02 09:11:47

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`pharmacy_prescription`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core prescription metrics tracking volume, controlled substance prescribing patterns, electronic prescribing adoption, and prior authorization requirements"
  source: "`vibe_healthcare_v1`.`pharmacy`.`prescription`"
  dimensions:
    - name: "prescription_status"
      expr: prescription_status
      comment: "Current status of the prescription (active, discontinued, expired, etc.)"
    - name: "prescription_type"
      expr: prescription_type
      comment: "Type of prescription (new, refill, transfer, etc.)"
    - name: "dea_schedule"
      expr: dea_schedule
      comment: "DEA controlled substance schedule classification (II, III, IV, V)"
    - name: "prescription_year"
      expr: YEAR(prescription_date)
      comment: "Year the prescription was written"
    - name: "prescription_month"
      expr: DATE_TRUNC('MONTH', prescription_date)
      comment: "Month the prescription was written"
    - name: "epcs_flag"
      expr: epcs_flag
      comment: "Whether prescription was electronically prescribed for controlled substances"
    - name: "prior_authorization_required_flag"
      expr: prior_authorization_required_flag
      comment: "Whether prior authorization is required for this prescription"
    - name: "substitution_allowed_flag"
      expr: substitution_allowed_flag
      comment: "Whether generic substitution is allowed"
    - name: "discontinuation_reason"
      expr: discontinuation_reason
      comment: "Reason for prescription discontinuation if applicable"
    - name: "dosage_form"
      expr: dosage_form
      comment: "Form of medication (tablet, capsule, liquid, etc.)"
    - name: "route_of_administration"
      expr: route_of_administration
      comment: "Route by which medication is administered"
  measures:
    - name: "total_prescriptions"
      expr: COUNT(1)
      comment: "Total number of prescriptions written"
    - name: "controlled_substance_prescriptions"
      expr: COUNT(CASE WHEN dea_schedule IS NOT NULL THEN 1 END)
      comment: "Number of controlled substance prescriptions requiring DEA tracking"
    - name: "epcs_prescriptions"
      expr: COUNT(CASE WHEN epcs_flag = TRUE THEN 1 END)
      comment: "Number of prescriptions electronically prescribed for controlled substances"
    - name: "prior_auth_required_prescriptions"
      expr: COUNT(CASE WHEN prior_authorization_required_flag = TRUE THEN 1 END)
      comment: "Number of prescriptions requiring prior authorization"
    - name: "discontinued_prescriptions"
      expr: COUNT(CASE WHEN discontinuation_date IS NOT NULL THEN 1 END)
      comment: "Number of prescriptions that have been discontinued"
    - name: "total_quantity_prescribed"
      expr: SUM(CAST(quantity_prescribed AS DOUBLE))
      comment: "Total quantity of medication prescribed across all prescriptions"
    - name: "avg_quantity_per_prescription"
      expr: AVG(CAST(quantity_prescribed AS DOUBLE))
      comment: "Average quantity prescribed per prescription"
    - name: "epcs_adoption_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN epcs_flag = TRUE THEN 1 END) / NULLIF(COUNT(CASE WHEN dea_schedule IS NOT NULL THEN 1 END), 0), 2)
      comment: "Percentage of controlled substance prescriptions using electronic prescribing (regulatory compliance metric)"
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`pharmacy_dispense_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Pharmacy dispensing metrics tracking fill rates, revenue, patient cost burden, and medication access"
  source: "`vibe_healthcare_v1`.`pharmacy`.`dispense_event`"
  dimensions:
    - name: "dispense_status"
      expr: dispense_status
      comment: "Status of the dispense event (completed, cancelled, pending, etc.)"
    - name: "dispense_type"
      expr: dispense_type
      comment: "Type of dispense (new, refill, partial fill, etc.)"
    - name: "dea_schedule"
      expr: dea_schedule
      comment: "DEA controlled substance schedule for dispensed medication"
    - name: "dispense_year"
      expr: YEAR(dispense_timestamp)
      comment: "Year medication was dispensed"
    - name: "dispense_month"
      expr: DATE_TRUNC('MONTH', dispense_timestamp)
      comment: "Month medication was dispensed"
    - name: "substitution_made_flag"
      expr: substitution_made_flag
      comment: "Whether a generic substitution was made"
    - name: "patient_counseling_completed_flag"
      expr: patient_counseling_completed_flag
      comment: "Whether patient counseling was completed"
    - name: "patient_counseling_declined_flag"
      expr: patient_counseling_declined_flag
      comment: "Whether patient declined counseling"
    - name: "substitution_reason"
      expr: substitution_reason
      comment: "Reason for medication substitution"
  measures:
    - name: "total_dispense_events"
      expr: COUNT(1)
      comment: "Total number of medication dispense events"
    - name: "unique_patients_served"
      expr: COUNT(DISTINCT mpi_record_id)
      comment: "Number of unique patients receiving dispensed medications"
    - name: "total_quantity_dispensed"
      expr: SUM(CAST(quantity_dispensed AS DOUBLE))
      comment: "Total quantity of medication units dispensed"
    - name: "total_medication_cost"
      expr: SUM(CAST(medication_cost_amount AS DOUBLE))
      comment: "Total cost of medications dispensed"
    - name: "total_dispensing_fees"
      expr: SUM(CAST(dispensing_fee_amount AS DOUBLE))
      comment: "Total dispensing fees charged"
    - name: "total_insurance_paid"
      expr: SUM(CAST(insurance_paid_amount AS DOUBLE))
      comment: "Total amount paid by insurance for dispensed medications"
    - name: "total_patient_pay"
      expr: SUM(CAST(patient_pay_amount AS DOUBLE))
      comment: "Total out-of-pocket amount paid by patients"
    - name: "avg_patient_pay_per_dispense"
      expr: AVG(CAST(patient_pay_amount AS DOUBLE))
      comment: "Average patient out-of-pocket cost per dispense event"
    - name: "generic_substitution_events"
      expr: COUNT(CASE WHEN substitution_made_flag = TRUE THEN 1 END)
      comment: "Number of dispense events where generic substitution occurred"
    - name: "counseling_completed_events"
      expr: COUNT(CASE WHEN patient_counseling_completed_flag = TRUE THEN 1 END)
      comment: "Number of dispense events where patient counseling was completed"
    - name: "patient_cost_burden_ratio_pct"
      expr: ROUND(100.0 * SUM(CAST(patient_pay_amount AS DOUBLE)) / NULLIF(SUM(CAST(medication_cost_amount AS DOUBLE)) + SUM(CAST(dispensing_fee_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of total medication and dispensing costs paid out-of-pocket by patients (affordability metric)"
    - name: "generic_substitution_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN substitution_made_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of dispense events utilizing generic substitution (cost efficiency metric)"
    - name: "counseling_completion_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN patient_counseling_completed_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of dispense events where patient counseling was completed (quality and compliance metric)"
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`pharmacy_mar_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Medication administration metrics tracking adherence, timeliness, waste, and administration safety"
  source: "`vibe_healthcare_v1`.`pharmacy`.`mar_record`"
  dimensions:
    - name: "administration_status"
      expr: administration_status
      comment: "Status of medication administration (given, held, refused, missed, etc.)"
    - name: "administration_status_reason"
      expr: administration_status_reason
      comment: "Reason for administration status (e.g., patient refused, NPO, medication unavailable)"
    - name: "administration_method"
      expr: administration_method
      comment: "Method of medication administration"
    - name: "administration_site"
      expr: administration_site
      comment: "Body site where medication was administered"
    - name: "route"
      expr: route
      comment: "Route of medication administration"
    - name: "dea_schedule"
      expr: dea_schedule
      comment: "DEA schedule for controlled substance administrations"
    - name: "is_stat_order"
      expr: is_stat_order
      comment: "Whether this was a STAT (urgent) medication order"
    - name: "is_first_dose"
      expr: is_first_dose
      comment: "Whether this was the first dose of the medication"
    - name: "administration_year"
      expr: YEAR(actual_administration_timestamp)
      comment: "Year medication was administered"
    - name: "administration_month"
      expr: DATE_TRUNC('MONTH', actual_administration_timestamp)
      comment: "Month medication was administered"
  measures:
    - name: "total_administration_records"
      expr: COUNT(1)
      comment: "Total number of medication administration records"
    - name: "unique_patients_administered"
      expr: COUNT(DISTINCT mpi_record_id)
      comment: "Number of unique patients receiving medication administrations"
    - name: "administered_doses"
      expr: COUNT(CASE WHEN administration_status = 'given' THEN 1 END)
      comment: "Number of doses successfully administered"
    - name: "missed_doses"
      expr: COUNT(CASE WHEN administration_status = 'missed' THEN 1 END)
      comment: "Number of scheduled doses that were missed"
    - name: "refused_doses"
      expr: COUNT(CASE WHEN administration_status = 'refused' THEN 1 END)
      comment: "Number of doses refused by patients"
    - name: "held_doses"
      expr: COUNT(CASE WHEN administration_status = 'held' THEN 1 END)
      comment: "Number of doses held by clinical decision"
    - name: "stat_administrations"
      expr: COUNT(CASE WHEN is_stat_order = TRUE THEN 1 END)
      comment: "Number of STAT (urgent) medication administrations"
    - name: "total_dose_given"
      expr: SUM(CAST(dose_given AS DOUBLE))
      comment: "Total dose amount administered across all records"
    - name: "total_waste_amount"
      expr: SUM(CAST(waste_amount AS DOUBLE))
      comment: "Total amount of medication wasted"
    - name: "avg_dose_per_administration"
      expr: AVG(CAST(dose_given AS DOUBLE))
      comment: "Average dose amount per administration event"
    - name: "administration_adherence_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN administration_status = 'given' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of scheduled medication administrations that were successfully given (quality and safety metric)"
    - name: "patient_refusal_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN administration_status = 'refused' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of medication administrations refused by patients (patient engagement and education metric)"
    - name: "medication_waste_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(waste_amount AS DOUBLE)) / NULLIF(SUM(CAST(dose_given AS DOUBLE)) + SUM(CAST(waste_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of total medication that was wasted (cost efficiency and process improvement metric)"
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`pharmacy_adverse_drug_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Adverse drug event metrics tracking patient safety, severity, preventability, and regulatory reporting compliance"
  source: "`vibe_healthcare_v1`.`pharmacy`.`adverse_drug_event`"
  dimensions:
    - name: "adverse_drug_event_status"
      expr: adverse_drug_event_status
      comment: "Current status of the adverse drug event report"
    - name: "event_type"
      expr: event_type
      comment: "Type of adverse drug event"
    - name: "severity"
      expr: severity
      comment: "Clinical severity classification of the adverse event"
    - name: "severity_level"
      expr: severity_level
      comment: "Severity level categorization"
    - name: "harm_category"
      expr: harm_category
      comment: "Category of harm caused by the adverse event"
    - name: "outcome"
      expr: outcome
      comment: "Patient outcome resulting from the adverse event"
    - name: "detection_method"
      expr: detection_method
      comment: "Method by which the adverse event was detected"
    - name: "preventability_assessment"
      expr: preventability_assessment
      comment: "Assessment of whether the event was preventable"
    - name: "intervention_required"
      expr: intervention_required
      comment: "Whether clinical intervention was required"
    - name: "reported_to_fda"
      expr: reported_to_fda
      comment: "Whether event was reported to FDA"
    - name: "reported_to_ismp"
      expr: reported_to_ismp
      comment: "Whether event was reported to Institute for Safe Medication Practices"
    - name: "root_cause_analysis_performed"
      expr: root_cause_analysis_performed
      comment: "Whether root cause analysis was performed"
    - name: "event_year"
      expr: YEAR(event_date)
      comment: "Year the adverse event occurred"
    - name: "event_month"
      expr: DATE_TRUNC('MONTH', event_date)
      comment: "Month the adverse event occurred"
  measures:
    - name: "total_adverse_events"
      expr: COUNT(1)
      comment: "Total number of adverse drug events reported"
    - name: "unique_patients_affected"
      expr: COUNT(DISTINCT mpi_record_id)
      comment: "Number of unique patients experiencing adverse drug events"
    - name: "severe_adverse_events"
      expr: COUNT(CASE WHEN severity IN ('severe', 'life-threatening', 'fatal') THEN 1 END)
      comment: "Number of severe, life-threatening, or fatal adverse drug events"
    - name: "preventable_adverse_events"
      expr: COUNT(CASE WHEN preventability_assessment = 'preventable' THEN 1 END)
      comment: "Number of adverse events assessed as preventable"
    - name: "events_requiring_intervention"
      expr: COUNT(CASE WHEN intervention_required = TRUE THEN 1 END)
      comment: "Number of adverse events requiring clinical intervention"
    - name: "fda_reported_events"
      expr: COUNT(CASE WHEN reported_to_fda = TRUE THEN 1 END)
      comment: "Number of adverse events reported to FDA"
    - name: "ismp_reported_events"
      expr: COUNT(CASE WHEN reported_to_ismp = TRUE THEN 1 END)
      comment: "Number of adverse events reported to ISMP"
    - name: "root_cause_analyses_performed"
      expr: COUNT(CASE WHEN root_cause_analysis_performed = TRUE THEN 1 END)
      comment: "Number of adverse events with completed root cause analysis"
    - name: "preventable_event_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN preventability_assessment = 'preventable' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of adverse drug events that were preventable (patient safety and quality improvement metric)"
    - name: "severe_event_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN severity IN ('severe', 'life-threatening', 'fatal') THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of adverse events classified as severe or worse (patient safety risk metric)"
    - name: "fda_reporting_compliance_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN reported_to_fda = TRUE THEN 1 END) / NULLIF(COUNT(CASE WHEN severity IN ('severe', 'life-threatening', 'fatal') THEN 1 END), 0), 2)
      comment: "Percentage of severe adverse events reported to FDA (regulatory compliance metric)"
    - name: "root_cause_analysis_completion_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN root_cause_analysis_performed = TRUE THEN 1 END) / NULLIF(COUNT(CASE WHEN severity IN ('severe', 'life-threatening', 'fatal') THEN 1 END), 0), 2)
      comment: "Percentage of severe adverse events with completed root cause analysis (quality improvement metric)"
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`pharmacy_controlled_substance_log`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Controlled substance tracking metrics for regulatory compliance, diversion prevention, and inventory reconciliation"
  source: "`vibe_healthcare_v1`.`pharmacy`.`controlled_substance_log`"
  dimensions:
    - name: "transaction_type"
      expr: transaction_type
      comment: "Type of controlled substance transaction (dispense, waste, return, transfer, etc.)"
    - name: "dea_schedule"
      expr: dea_schedule
      comment: "DEA schedule classification of the controlled substance"
    - name: "discrepancy_flag"
      expr: discrepancy_flag
      comment: "Whether a discrepancy was identified in the transaction"
    - name: "discrepancy_reason"
      expr: discrepancy_reason
      comment: "Reason for inventory discrepancy"
    - name: "witnessed_flag"
      expr: witnessed_flag
      comment: "Whether the transaction was witnessed by another provider"
    - name: "waste_reason"
      expr: waste_reason
      comment: "Reason for controlled substance waste"
    - name: "pdmp_reported_flag"
      expr: pdmp_reported_flag
      comment: "Whether transaction was reported to Prescription Drug Monitoring Program"
    - name: "override_flag"
      expr: override_flag
      comment: "Whether a system override was used for the transaction"
    - name: "transaction_year"
      expr: YEAR(transaction_timestamp)
      comment: "Year of the controlled substance transaction"
    - name: "transaction_month"
      expr: DATE_TRUNC('MONTH', transaction_timestamp)
      comment: "Month of the controlled substance transaction"
  measures:
    - name: "total_transactions"
      expr: COUNT(1)
      comment: "Total number of controlled substance transactions logged"
    - name: "unique_controlled_substances"
      expr: COUNT(DISTINCT drug_master_id)
      comment: "Number of unique controlled substances transacted"
    - name: "total_quantity_transacted"
      expr: SUM(CAST(quantity AS DOUBLE))
      comment: "Total quantity of controlled substances transacted"
    - name: "discrepancy_transactions"
      expr: COUNT(CASE WHEN discrepancy_flag = TRUE THEN 1 END)
      comment: "Number of transactions with inventory discrepancies"
    - name: "witnessed_transactions"
      expr: COUNT(CASE WHEN witnessed_flag = TRUE THEN 1 END)
      comment: "Number of transactions that were witnessed"
    - name: "waste_transactions"
      expr: COUNT(CASE WHEN transaction_type = 'waste' THEN 1 END)
      comment: "Number of controlled substance waste transactions"
    - name: "pdmp_reported_transactions"
      expr: COUNT(CASE WHEN pdmp_reported_flag = TRUE THEN 1 END)
      comment: "Number of transactions reported to PDMP"
    - name: "override_transactions"
      expr: COUNT(CASE WHEN override_flag = TRUE THEN 1 END)
      comment: "Number of transactions requiring system override"
    - name: "discrepancy_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN discrepancy_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of controlled substance transactions with discrepancies (diversion risk and inventory control metric)"
    - name: "witness_compliance_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN witnessed_flag = TRUE THEN 1 END) / NULLIF(COUNT(CASE WHEN transaction_type IN ('waste', 'return') THEN 1 END), 0), 2)
      comment: "Percentage of waste and return transactions that were properly witnessed (regulatory compliance metric)"
    - name: "pdmp_reporting_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN pdmp_reported_flag = TRUE THEN 1 END) / NULLIF(COUNT(CASE WHEN transaction_type = 'dispense' THEN 1 END), 0), 2)
      comment: "Percentage of dispense transactions reported to PDMP (state regulatory compliance metric)"
    - name: "override_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN override_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of transactions requiring system override (process compliance and audit risk metric)"
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`pharmacy_inventory`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Pharmacy inventory metrics tracking stock levels, turnover, expiration risk, and supply chain efficiency"
  source: "`vibe_healthcare_v1`.`pharmacy`.`inventory`"
  dimensions:
    - name: "inventory_status"
      expr: inventory_status
      comment: "Current status of inventory item (active, expired, quarantined, recalled, etc.)"
    - name: "dea_schedule"
      expr: dea_schedule
      comment: "DEA schedule for controlled substance inventory"
    - name: "formulary_status"
      expr: formulary_status
      comment: "Formulary status of the medication"
    - name: "high_alert_medication"
      expr: high_alert_medication
      comment: "Whether medication is classified as high-alert"
    - name: "shortage_indicator"
      expr: shortage_indicator
      comment: "Whether medication is currently in shortage"
    - name: "quarantine_reason"
      expr: quarantine_reason
      comment: "Reason for inventory quarantine"
    - name: "storage_requirements"
      expr: storage_requirements
      comment: "Special storage requirements for the medication"
    - name: "snapshot_year"
      expr: YEAR(snapshot_timestamp)
      comment: "Year of inventory snapshot"
    - name: "snapshot_month"
      expr: DATE_TRUNC('MONTH', snapshot_timestamp)
      comment: "Month of inventory snapshot"
  measures:
    - name: "total_inventory_items"
      expr: COUNT(1)
      comment: "Total number of distinct inventory line items"
    - name: "unique_medications_stocked"
      expr: COUNT(DISTINCT drug_master_id)
      comment: "Number of unique medications in inventory"
    - name: "total_quantity_on_hand"
      expr: SUM(CAST(quantity_on_hand AS DOUBLE))
      comment: "Total quantity of medication units in inventory"
    - name: "total_inventory_value"
      expr: SUM(CAST(total_value AS DOUBLE))
      comment: "Total dollar value of inventory on hand"
    - name: "avg_unit_cost"
      expr: AVG(CAST(unit_cost AS DOUBLE))
      comment: "Average unit cost across all inventory items"
    - name: "total_par_level"
      expr: SUM(CAST(par_level AS DOUBLE))
      comment: "Total par level quantity across all inventory items"
    - name: "total_reorder_point"
      expr: SUM(CAST(reorder_point AS DOUBLE))
      comment: "Total reorder point quantity across all inventory items"
    - name: "items_below_reorder_point"
      expr: COUNT(CASE WHEN quantity_on_hand < reorder_point THEN 1 END)
      comment: "Number of inventory items below reorder point"
    - name: "items_in_shortage"
      expr: COUNT(CASE WHEN shortage_indicator = TRUE THEN 1 END)
      comment: "Number of medications currently in shortage"
    - name: "high_alert_items"
      expr: COUNT(CASE WHEN high_alert_medication = TRUE THEN 1 END)
      comment: "Number of high-alert medications in inventory"
    - name: "quarantined_items"
      expr: COUNT(CASE WHEN inventory_status = 'quarantined' THEN 1 END)
      comment: "Number of inventory items in quarantine"
    - name: "avg_days_supply_on_hand"
      expr: AVG(CAST(days_supply_on_hand AS DOUBLE))
      comment: "Average days of supply on hand across inventory"
    - name: "avg_cycle_count_variance"
      expr: AVG(CAST(cycle_count_variance AS DOUBLE))
      comment: "Average variance between physical count and system inventory"
    - name: "stockout_risk_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN quantity_on_hand < reorder_point THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of inventory items below reorder point (supply chain risk metric)"
    - name: "inventory_turnover_ratio"
      expr: ROUND(AVG(CAST(average_daily_usage AS DOUBLE)) * 365 / NULLIF(AVG(CAST(quantity_on_hand AS DOUBLE)), 0), 2)
      comment: "Estimated annual inventory turnover ratio (working capital efficiency metric)"
    - name: "shortage_prevalence_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN shortage_indicator = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of inventory items currently in shortage (supply chain resilience metric)"
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`pharmacy_drug_master`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Drug master catalog metrics tracking formulary composition, high-risk medications, and regulatory compliance attributes"
  source: "`vibe_healthcare_v1`.`pharmacy`.`drug_master`"
  dimensions:
    - name: "active_status"
      expr: active_status
      comment: "Whether drug is currently active in the formulary"
    - name: "formulary_status"
      expr: formulary_status
      comment: "Formulary status of the drug"
    - name: "dea_schedule"
      expr: dea_schedule
      comment: "DEA controlled substance schedule"
    - name: "drug_class"
      expr: drug_class
      comment: "Pharmacological class of the drug"
    - name: "therapeutic_category"
      expr: therapeutic_category
      comment: "Therapeutic category classification"
    - name: "dosage_form"
      expr: dosage_form
      comment: "Dosage form of the medication"
    - name: "route_of_administration"
      expr: route_of_administration
      comment: "Route of administration"
    - name: "controlled_substance_indicator"
      expr: controlled_substance_indicator
      comment: "Whether drug is a controlled substance"
    - name: "is_high_alert"
      expr: is_high_alert
      comment: "Whether drug is classified as high-alert"
    - name: "ismp_high_alert_flag"
      expr: ismp_high_alert_flag
      comment: "Whether drug is on ISMP high-alert medication list"
    - name: "black_box_warning_flag"
      expr: black_box_warning_flag
      comment: "Whether drug has FDA black box warning"
    - name: "rems_required_flag"
      expr: rems_required_flag
      comment: "Whether drug requires Risk Evaluation and Mitigation Strategy"
    - name: "lasa_indicator"
      expr: lasa_indicator
      comment: "Whether drug is a look-alike sound-alike medication"
    - name: "hazardous_drug_flag"
      expr: hazardous_drug_flag
      comment: "Whether drug is classified as hazardous"
    - name: "pregnancy_category"
      expr: pregnancy_category
      comment: "FDA pregnancy risk category"
    - name: "lactation_risk_category"
      expr: lactation_risk_category
      comment: "Lactation risk category"
  measures:
    - name: "total_drugs_in_catalog"
      expr: COUNT(1)
      comment: "Total number of drugs in the drug master catalog"
    - name: "active_drugs"
      expr: COUNT(CASE WHEN active_status = 'active' THEN 1 END)
      comment: "Number of active drugs in the catalog"
    - name: "controlled_substances"
      expr: COUNT(CASE WHEN controlled_substance_indicator = TRUE THEN 1 END)
      comment: "Number of controlled substances in catalog"
    - name: "high_alert_medications"
      expr: COUNT(CASE WHEN is_high_alert = TRUE OR ismp_high_alert_flag = TRUE THEN 1 END)
      comment: "Number of high-alert medications requiring special handling"
    - name: "black_box_warning_drugs"
      expr: COUNT(CASE WHEN black_box_warning_flag = TRUE THEN 1 END)
      comment: "Number of drugs with FDA black box warnings"
    - name: "rems_required_drugs"
      expr: COUNT(CASE WHEN rems_required_flag = TRUE THEN 1 END)
      comment: "Number of drugs requiring REMS programs"
    - name: "lasa_medications"
      expr: COUNT(CASE WHEN lasa_indicator = TRUE THEN 1 END)
      comment: "Number of look-alike sound-alike medications"
    - name: "hazardous_drugs"
      expr: COUNT(CASE WHEN hazardous_drug_flag = TRUE THEN 1 END)
      comment: "Number of hazardous drugs requiring special handling"
    - name: "renal_adjustment_drugs"
      expr: COUNT(CASE WHEN renal_dosing_adjustment_flag = TRUE THEN 1 END)
      comment: "Number of drugs requiring renal dosing adjustment"
    - name: "hepatic_adjustment_drugs"
      expr: COUNT(CASE WHEN hepatic_dosing_adjustment_flag = TRUE THEN 1 END)
      comment: "Number of drugs requiring hepatic dosing adjustment"
    - name: "pediatric_approved_drugs"
      expr: COUNT(CASE WHEN pediatric_approved_flag = TRUE THEN 1 END)
      comment: "Number of drugs approved for pediatric use"
    - name: "high_alert_prevalence_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_high_alert = TRUE OR ismp_high_alert_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of catalog that are high-alert medications (patient safety risk profile metric)"
    - name: "controlled_substance_prevalence_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN controlled_substance_indicator = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of catalog that are controlled substances (regulatory oversight scope metric)"
    - name: "rems_program_burden_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN rems_required_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of catalog requiring REMS programs (operational complexity and compliance burden metric)"
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`pharmacy_formulary`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Formulary management metrics tracking coverage policies, restrictions, prior authorization requirements, and access barriers"
  source: "`vibe_healthcare_v1`.`pharmacy`.`formulary`"
  dimensions:
    - name: "formulary_status"
      expr: formulary_status
      comment: "Status of drug on formulary (preferred, non-preferred, excluded, etc.)"
    - name: "formulary_tier"
      expr: formulary_tier
      comment: "Formulary tier assignment affecting patient cost-sharing"
    - name: "formulary_type"
      expr: formulary_type
      comment: "Type of formulary (open, closed, restricted, etc.)"
    - name: "coverage_status"
      expr: coverage_status
      comment: "Coverage status of the drug"
    - name: "prior_authorization_required"
      expr: prior_authorization_required
      comment: "Whether prior authorization is required"
    - name: "step_therapy_required"
      expr: step_therapy_required
      comment: "Whether step therapy protocol is required"
    - name: "clinical_review_required"
      expr: clinical_review_required
      comment: "Whether clinical review is required for coverage"
    - name: "generic_substitution_allowed"
      expr: generic_substitution_allowed
      comment: "Whether generic substitution is allowed"
    - name: "specialty_drug_indicator"
      expr: specialty_drug_indicator
      comment: "Whether drug is classified as specialty"
    - name: "mail_order_eligible"
      expr: mail_order_eligible
      comment: "Whether drug is eligible for mail order"
    - name: "therapeutic_alternative_available"
      expr: therapeutic_alternative_available
      comment: "Whether therapeutic alternatives are available"
  measures:
    - name: "total_formulary_entries"
      expr: COUNT(1)
      comment: "Total number of formulary entries"
    - name: "unique_drugs_on_formulary"
      expr: COUNT(DISTINCT drug_master_id)
      comment: "Number of unique drugs covered by formulary"
    - name: "prior_auth_required_drugs"
      expr: COUNT(CASE WHEN prior_authorization_required = TRUE THEN 1 END)
      comment: "Number of drugs requiring prior authorization"
    - name: "step_therapy_required_drugs"
      expr: COUNT(CASE WHEN step_therapy_required = TRUE THEN 1 END)
      comment: "Number of drugs requiring step therapy"
    - name: "clinical_review_required_drugs"
      expr: COUNT(CASE WHEN clinical_review_required = TRUE THEN 1 END)
      comment: "Number of drugs requiring clinical review"
    - name: "specialty_drugs"
      expr: COUNT(CASE WHEN specialty_drug_indicator = TRUE THEN 1 END)
      comment: "Number of specialty drugs on formulary"
    - name: "mail_order_eligible_drugs"
      expr: COUNT(CASE WHEN mail_order_eligible = TRUE THEN 1 END)
      comment: "Number of drugs eligible for mail order"
    - name: "generic_substitution_allowed_drugs"
      expr: COUNT(CASE WHEN generic_substitution_allowed = TRUE THEN 1 END)
      comment: "Number of drugs allowing generic substitution"
    - name: "avg_quantity_limit"
      expr: AVG(CAST(quantity_limit AS DOUBLE))
      comment: "Average quantity limit across formulary entries with limits"
    - name: "prior_auth_burden_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN prior_authorization_required = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of formulary requiring prior authorization (access barrier and administrative burden metric)"
    - name: "step_therapy_burden_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN step_therapy_required = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of formulary requiring step therapy (treatment delay risk metric)"
    - name: "specialty_drug_prevalence_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN specialty_drug_indicator = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of formulary classified as specialty drugs (high-cost medication exposure metric)"
    - name: "mail_order_accessibility_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN mail_order_eligible = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of formulary eligible for mail order (patient convenience and adherence support metric)"
    - name: "generic_substitution_opportunity_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN generic_substitution_allowed = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of formulary allowing generic substitution (cost savings opportunity metric)"
$$;