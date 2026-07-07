-- Metric views for domain: quality | Business: Manufacturing | Version: 2 | Generated on: 2026-07-03 07:49:38

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`quality_capa`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Capa business metrics"
  source: "`vibe_manufacturing_v1`.`quality`.`capa`"
  dimensions:
    - name: "Action Implementation Date"
      expr: action_implementation_date
    - name: "Actual Closure Date"
      expr: actual_closure_date
    - name: "Affected Process Code"
      expr: affected_process_code
    - name: "Approval Date"
      expr: approval_date
    - name: "Capa Number"
      expr: capa_number
    - name: "Capa Status"
      expr: capa_status
    - name: "Capa Type"
      expr: capa_type
    - name: "Containment Completion Date"
      expr: containment_completion_date
    - name: "Corrective Action Plan"
      expr: corrective_action_plan
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Customer Notification Date"
      expr: customer_notification_date
    - name: "Customer Notification Required"
      expr: customer_notification_required
    - name: "Department Code"
      expr: department_code
    - name: "Effectiveness Verification Date"
      expr: effectiveness_verification_date
    - name: "Effectiveness Verification Method"
      expr: effectiveness_verification_method
    - name: "Effectiveness Verified"
      expr: effectiveness_verified
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Capa"
      expr: COUNT(DISTINCT capa_id)
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`quality_certificate_of_conformance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Certificate Of Conformance business metrics"
  source: "`vibe_manufacturing_v1`.`quality`.`certificate_of_conformance`"
  dimensions:
    - name: "Applicable Standard"
      expr: applicable_standard
    - name: "Authorized Signatory Name"
      expr: authorized_signatory_name
    - name: "Authorized Signatory Title"
      expr: authorized_signatory_title
    - name: "Certificate Language"
      expr: certificate_language
    - name: "Certificate Number"
      expr: certificate_number
    - name: "Certificate Status"
      expr: certificate_status
    - name: "Certificate Type"
      expr: certificate_type
    - name: "Conformance Statement"
      expr: conformance_statement
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Customer Name"
      expr: customer_name
    - name: "Customer Order Number"
      expr: customer_order_number
    - name: "Customer Part Number"
      expr: customer_part_number
    - name: "Customer Specific Requirements"
      expr: customer_specific_requirements
    - name: "Delivery Number"
      expr: delivery_number
    - name: "Digital Signature Reference"
      expr: digital_signature_reference
    - name: "Document Url"
      expr: document_url
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Certificate Of Conformance"
      expr: COUNT(DISTINCT certificate_of_conformance_id)
    - name: "Total Lot Quantity"
      expr: SUM(lot_quantity)
    - name: "Average Lot Quantity"
      expr: AVG(lot_quantity)
    - name: "Total Ppap Level"
      expr: SUM(ppap_level)
    - name: "Average Ppap Level"
      expr: AVG(ppap_level)
    - name: "Total Quantity Certified"
      expr: SUM(quantity_certified)
    - name: "Average Quantity Certified"
      expr: AVG(quantity_certified)
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`quality_control_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Control Plan business metrics"
  source: "`vibe_manufacturing_v1`.`quality`.`control_plan`"
  dimensions:
    - name: "Approved By"
      expr: approved_by
    - name: "Approved Timestamp"
      expr: approved_timestamp
    - name: "Control Method"
      expr: control_method
    - name: "Control Type"
      expr: control_type
    - name: "Cpk Minimum Required"
      expr: cpk_minimum_required
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Effective Date"
      expr: effective_date
    - name: "Error Proofing Method"
      expr: error_proofing_method
    - name: "Expiry Date"
      expr: expiry_date
    - name: "Gauge Type"
      expr: gauge_type
    - name: "Is Ctq"
      expr: is_ctq
    - name: "Is Regulatory Requirement"
      expr: is_regulatory_requirement
    - name: "Is Safety Characteristic"
      expr: is_safety_characteristic
    - name: "Last Updated Timestamp"
      expr: last_updated_timestamp
    - name: "Measurement Method"
      expr: measurement_method
    - name: "Plan Number"
      expr: plan_number
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Control Plan"
      expr: COUNT(DISTINCT control_plan_id)
    - name: "Total Lower Control Limit"
      expr: SUM(lower_control_limit)
    - name: "Average Lower Control Limit"
      expr: AVG(lower_control_limit)
    - name: "Total Lower Spec Limit"
      expr: SUM(lower_spec_limit)
    - name: "Average Lower Spec Limit"
      expr: AVG(lower_spec_limit)
    - name: "Total Nominal Value"
      expr: SUM(nominal_value)
    - name: "Average Nominal Value"
      expr: AVG(nominal_value)
    - name: "Total Upper Control Limit"
      expr: SUM(upper_control_limit)
    - name: "Average Upper Control Limit"
      expr: AVG(upper_control_limit)
    - name: "Total Upper Spec Limit"
      expr: SUM(upper_spec_limit)
    - name: "Average Upper Spec Limit"
      expr: AVG(upper_spec_limit)
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`quality_customer_complaint`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Customer Complaint business metrics"
  source: "`vibe_manufacturing_v1`.`quality`.`customer_complaint`"
  dimensions:
    - name: "Affected Serial Number"
      expr: affected_serial_number
    - name: "Closure Date"
      expr: closure_date
    - name: "Complaint Description"
      expr: complaint_description
    - name: "Complaint Number"
      expr: complaint_number
    - name: "Complaint Source"
      expr: complaint_source
    - name: "Complaint Status"
      expr: complaint_status
    - name: "Complaint Title"
      expr: complaint_title
    - name: "Complaint Type"
      expr: complaint_type
    - name: "Containment Action"
      expr: containment_action
    - name: "Containment Date"
      expr: containment_date
    - name: "Corrective Action Completed Date"
      expr: corrective_action_completed_date
    - name: "Corrective Action Description"
      expr: corrective_action_description
    - name: "Corrective Action Due Date"
      expr: corrective_action_due_date
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Customer Acceptance Status"
      expr: customer_acceptance_status
    - name: "Customer Order Number"
      expr: customer_order_number
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Customer Complaint"
      expr: COUNT(DISTINCT customer_complaint_id)
    - name: "Total Severity Level"
      expr: SUM(severity_level)
    - name: "Average Severity Level"
      expr: AVG(severity_level)
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`quality_fmea`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Fmea business metrics"
  source: "`vibe_manufacturing_v1`.`quality`.`fmea`"
  dimensions:
    - name: "Action Priority"
      expr: action_priority
    - name: "Action Taken"
      expr: action_taken
    - name: "Actual Completion Date"
      expr: actual_completion_date
    - name: "Approved Date"
      expr: approved_date
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Current Detection Controls"
      expr: current_detection_controls
    - name: "Current Prevention Controls"
      expr: current_prevention_controls
    - name: "Detection Rating"
      expr: detection_rating
    - name: "Failure Cause"
      expr: failure_cause
    - name: "Failure Effect"
      expr: failure_effect
    - name: "Failure Mode"
      expr: failure_mode
    - name: "Fmea Number"
      expr: fmea_number
    - name: "Fmea Status"
      expr: fmea_status
    - name: "Fmea Type"
      expr: fmea_type
    - name: "Function Description"
      expr: function_description
    - name: "Initiated Date"
      expr: initiated_date
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Fmea"
      expr: COUNT(DISTINCT fmea_id)
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`quality_inspection_characteristic`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Inspection Characteristic business metrics"
  source: "`vibe_manufacturing_v1`.`quality`.`inspection_characteristic`"
  dimensions:
    - name: "Characteristic Class"
      expr: characteristic_class
    - name: "Characteristic Code"
      expr: characteristic_code
    - name: "Characteristic Name"
      expr: characteristic_name
    - name: "Characteristic Number"
      expr: characteristic_number
    - name: "Characteristic Type"
      expr: characteristic_type
    - name: "Code"
      expr: code
    - name: "Control Indicator"
      expr: control_indicator
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Data Collection System"
      expr: data_collection_system
    - name: "Description"
      expr: description
    - name: "Effective From"
      expr: effective_from
    - name: "Effective Until"
      expr: effective_until
    - name: "Frequency Per Shift"
      expr: frequency_per_shift
    - name: "Inspection Method"
      expr: inspection_method
    - name: "Inspection Method Code"
      expr: inspection_method_code
    - name: "Is Critical"
      expr: is_critical
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Inspection Characteristic"
      expr: COUNT(DISTINCT inspection_characteristic_id)
    - name: "Total Criticality Level"
      expr: SUM(criticality_level)
    - name: "Average Criticality Level"
      expr: AVG(criticality_level)
    - name: "Total Lower Spec Limit"
      expr: SUM(lower_spec_limit)
    - name: "Average Lower Spec Limit"
      expr: AVG(lower_spec_limit)
    - name: "Total Nominal Value"
      expr: SUM(nominal_value)
    - name: "Average Nominal Value"
      expr: AVG(nominal_value)
    - name: "Total Operation Number"
      expr: SUM(operation_number)
    - name: "Average Operation Number"
      expr: AVG(operation_number)
    - name: "Total Target Value"
      expr: SUM(target_value)
    - name: "Average Target Value"
      expr: AVG(target_value)
    - name: "Total Tolerance"
      expr: SUM(tolerance)
    - name: "Average Tolerance"
      expr: AVG(tolerance)
    - name: "Total Tolerance Lower"
      expr: SUM(tolerance_lower)
    - name: "Average Tolerance Lower"
      expr: AVG(tolerance_lower)
    - name: "Total Tolerance Upper"
      expr: SUM(tolerance_upper)
    - name: "Average Tolerance Upper"
      expr: AVG(tolerance_upper)
    - name: "Total Upper Spec Limit"
      expr: SUM(upper_spec_limit)
    - name: "Average Upper Spec Limit"
      expr: AVG(upper_spec_limit)
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`quality_inspection_lot`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Inspection Lot business metrics"
  source: "`vibe_manufacturing_v1`.`quality`.`inspection_lot`"
  dimensions:
    - name: "Certificate Number"
      expr: certificate_number
    - name: "Certificate Of Conformance Required"
      expr: certificate_of_conformance_required
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Defect Count"
      expr: defect_count
    - name: "Disposition By"
      expr: disposition_by
    - name: "Disposition Code"
      expr: disposition_code
    - name: "Disposition Decision"
      expr: disposition_decision
    - name: "Disposition Timestamp"
      expr: disposition_timestamp
    - name: "Dynamic Modification Rule"
      expr: dynamic_modification_rule
    - name: "Inspection End Timestamp"
      expr: inspection_end_timestamp
    - name: "Inspection Method"
      expr: inspection_method
    - name: "Inspection Start Timestamp"
      expr: inspection_start_timestamp
    - name: "Inspection Type Code"
      expr: inspection_type_code
    - name: "Inspection Type Description"
      expr: inspection_type_description
    - name: "Lot Origin Timestamp"
      expr: lot_origin_timestamp
    - name: "Lot Quantity Uom"
      expr: lot_quantity_uom
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Inspection Lot"
      expr: COUNT(DISTINCT inspection_lot_id)
    - name: "Total Inspection Level"
      expr: SUM(inspection_level)
    - name: "Average Inspection Level"
      expr: AVG(inspection_level)
    - name: "Total Lot Quantity"
      expr: SUM(lot_quantity)
    - name: "Average Lot Quantity"
      expr: AVG(lot_quantity)
    - name: "Total Nonconforming Quantity"
      expr: SUM(nonconforming_quantity)
    - name: "Average Nonconforming Quantity"
      expr: AVG(nonconforming_quantity)
    - name: "Total Sample Size"
      expr: SUM(sample_size)
    - name: "Average Sample Size"
      expr: AVG(sample_size)
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`quality_inspection_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Inspection Plan business metrics"
  source: "`vibe_manufacturing_v1`.`quality`.`inspection_plan`"
  dimensions:
    - name: "Approved Timestamp"
      expr: approved_timestamp
    - name: "Apqp Phase"
      expr: apqp_phase
    - name: "Characteristic Count"
      expr: characteristic_count
    - name: "Characteristic Unit"
      expr: characteristic_unit
    - name: "Control Method Code"
      expr: control_method_code
    - name: "Control Plan Reference"
      expr: control_plan_reference
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Customer Specific Requirement"
      expr: customer_specific_requirement
    - name: "Effective From"
      expr: effective_from
    - name: "Effective Until"
      expr: effective_until
    - name: "Equipment Category"
      expr: equipment_category
    - name: "Inspection Method Code"
      expr: inspection_method_code
    - name: "Inspection Scope"
      expr: inspection_scope
    - name: "Inspection Stage"
      expr: inspection_stage
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Long Text Description"
      expr: long_text_description
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Inspection Plan"
      expr: COUNT(DISTINCT inspection_plan_id)
    - name: "Total Aql Level"
      expr: SUM(aql_level)
    - name: "Average Aql Level"
      expr: AVG(aql_level)
    - name: "Total Cpk Minimum"
      expr: SUM(cpk_minimum)
    - name: "Average Cpk Minimum"
      expr: AVG(cpk_minimum)
    - name: "Total Lower Tolerance Limit"
      expr: SUM(lower_tolerance_limit)
    - name: "Average Lower Tolerance Limit"
      expr: AVG(lower_tolerance_limit)
    - name: "Total Operation Number"
      expr: SUM(operation_number)
    - name: "Average Operation Number"
      expr: AVG(operation_number)
    - name: "Total Ppap Level"
      expr: SUM(ppap_level)
    - name: "Average Ppap Level"
      expr: AVG(ppap_level)
    - name: "Total Target Value"
      expr: SUM(target_value)
    - name: "Average Target Value"
      expr: AVG(target_value)
    - name: "Total Upper Tolerance Limit"
      expr: SUM(upper_tolerance_limit)
    - name: "Average Upper Tolerance Limit"
      expr: AVG(upper_tolerance_limit)
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`quality_inspection_result`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Inspection Result business metrics"
  source: "`vibe_manufacturing_v1`.`quality`.`inspection_result`"
  dimensions:
    - name: "Attribute Result"
      expr: attribute_result
    - name: "Calibration Due Date"
      expr: calibration_due_date
    - name: "Characteristic Type"
      expr: characteristic_type
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Defect Code"
      expr: defect_code
    - name: "Defect Count"
      expr: defect_count
    - name: "Defect Description"
      expr: defect_description
    - name: "Inspection Date"
      expr: inspection_date
    - name: "Inspection Method"
      expr: inspection_method
    - name: "Inspection Stage"
      expr: inspection_stage
    - name: "Inspection Timestamp"
      expr: inspection_timestamp
    - name: "Is Out Of Control"
      expr: is_out_of_control
    - name: "Is Out Of Spec"
      expr: is_out_of_spec
    - name: "Plant Code"
      expr: plant_code
    - name: "Remarks"
      expr: remarks
    - name: "Result Status"
      expr: result_status
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Inspection Result"
      expr: COUNT(DISTINCT inspection_result_id)
    - name: "Total Cp Index"
      expr: SUM(cp_index)
    - name: "Average Cp Index"
      expr: AVG(cp_index)
    - name: "Total Cpk Index"
      expr: SUM(cpk_index)
    - name: "Average Cpk Index"
      expr: AVG(cpk_index)
    - name: "Total Lower Control Limit"
      expr: SUM(lower_control_limit)
    - name: "Average Lower Control Limit"
      expr: AVG(lower_control_limit)
    - name: "Total Lower Spec Limit"
      expr: SUM(lower_spec_limit)
    - name: "Average Lower Spec Limit"
      expr: AVG(lower_spec_limit)
    - name: "Total Measured Value"
      expr: SUM(measured_value)
    - name: "Average Measured Value"
      expr: AVG(measured_value)
    - name: "Total Nominal Value"
      expr: SUM(nominal_value)
    - name: "Average Nominal Value"
      expr: AVG(nominal_value)
    - name: "Total Upper Control Limit"
      expr: SUM(upper_control_limit)
    - name: "Average Upper Control Limit"
      expr: AVG(upper_control_limit)
    - name: "Total Upper Spec Limit"
      expr: SUM(upper_spec_limit)
    - name: "Average Upper Spec Limit"
      expr: AVG(upper_spec_limit)
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`quality_ncr`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Ncr business metrics"
  source: "`vibe_manufacturing_v1`.`quality`.`ncr`"
  dimensions:
    - name: "Actual Closure Date"
      expr: actual_closure_date
    - name: "Containment Action"
      expr: containment_action
    - name: "Containment Completed Date"
      expr: containment_completed_date
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Customer Complaint Number"
      expr: customer_complaint_number
    - name: "Customer Notification Required"
      expr: customer_notification_required
    - name: "Defect Code"
      expr: defect_code
    - name: "Defect Location"
      expr: defect_location
    - name: "Detection Source"
      expr: detection_source
    - name: "Detection Timestamp"
      expr: detection_timestamp
    - name: "Disposition"
      expr: disposition
    - name: "Disposition Authority"
      expr: disposition_authority
    - name: "Disposition Timestamp"
      expr: disposition_timestamp
    - name: "Eight D Report Number"
      expr: eight_d_report_number
    - name: "Is 8d Required"
      expr: is_8d_required
    - name: "Material Description"
      expr: material_description
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Ncr"
      expr: COUNT(DISTINCT ncr_id)
    - name: "Total Nonconforming Qty"
      expr: SUM(nonconforming_qty)
    - name: "Average Nonconforming Qty"
      expr: AVG(nonconforming_qty)
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`quality_ppap_submission`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Ppap Submission business metrics"
  source: "`vibe_manufacturing_v1`.`quality`.`ppap_submission`"
  dimensions:
    - name: "Annual Production Volume"
      expr: annual_production_volume
    - name: "Appearance Approval Status"
      expr: appearance_approval_status
    - name: "Apqp Phase"
      expr: apqp_phase
    - name: "Bulk Material Checklist Status"
      expr: bulk_material_checklist_status
    - name: "Checking Aids Status"
      expr: checking_aids_status
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Customer Approval Date"
      expr: customer_approval_date
    - name: "Customer Approver Name"
      expr: customer_approver_name
    - name: "Customer Part Number"
      expr: customer_part_number
    - name: "Customer Specific Requirements Status"
      expr: customer_specific_requirements_status
    - name: "Design Record Number"
      expr: design_record_number
    - name: "Dimensional Results Status"
      expr: dimensional_results_status
    - name: "Imds Submission Reference"
      expr: imds_submission_reference
    - name: "Initial Process Study Number"
      expr: initial_process_study_number
    - name: "Interim Approval Expiry Date"
      expr: interim_approval_expiry_date
    - name: "Is Safety Critical Part"
      expr: is_safety_critical_part
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Ppap Submission"
      expr: COUNT(DISTINCT ppap_submission_id)
    - name: "Total Cpk Minimum"
      expr: SUM(cpk_minimum)
    - name: "Average Cpk Minimum"
      expr: AVG(cpk_minimum)
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`quality_rma_disposition`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Rma Disposition business metrics"
  source: "`vibe_manufacturing_v1`.`quality`.`rma_disposition`"
  dimensions:
    - name: "Batch Number"
      expr: batch_number
    - name: "Capa Required Flag"
      expr: capa_required_flag
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Credit Currency Code"
      expr: credit_currency_code
    - name: "Currency Code"
      expr: currency_code
    - name: "Customer Reference Number"
      expr: customer_reference_number
    - name: "Disposition Code"
      expr: disposition_code
    - name: "Disposition Decision"
      expr: disposition_decision
    - name: "Disposition Notes"
      expr: disposition_notes
    - name: "Disposition Reason"
      expr: disposition_reason
    - name: "Disposition Status"
      expr: disposition_status
    - name: "Disposition Timestamp"
      expr: disposition_timestamp
    - name: "Disposition Type"
      expr: disposition_type
    - name: "Failure Code Confirmed"
      expr: failure_code_confirmed
    - name: "Failure Code Reported"
      expr: failure_code_reported
    - name: "Failure Description Confirmed"
      expr: failure_description_confirmed
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Rma Disposition"
      expr: COUNT(DISTINCT rma_disposition_id)
    - name: "Total Credit Amount"
      expr: SUM(credit_amount)
    - name: "Average Credit Amount"
      expr: AVG(credit_amount)
    - name: "Total Quantity Disposed"
      expr: SUM(quantity_disposed)
    - name: "Average Quantity Disposed"
      expr: AVG(quantity_disposed)
    - name: "Total Quantity Returned"
      expr: SUM(quantity_returned)
    - name: "Average Quantity Returned"
      expr: AVG(quantity_returned)
    - name: "Total Returned Quantity"
      expr: SUM(returned_quantity)
    - name: "Average Returned Quantity"
      expr: AVG(returned_quantity)
$$;