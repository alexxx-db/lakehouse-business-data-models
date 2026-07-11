-- Metric views for domain: housekeeping | Business: Travel_Hospitality | Version: 2 | Generated on: 2026-07-10 20:27:16

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`housekeeping_attendant`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Attendant business metrics"
  source: "`vibe_travel_hospitality_v1`.`housekeeping`.`attendant`"
  dimensions:
    - name: "Active Flag"
      expr: active_flag
    - name: "Ada Accommodation Flag"
      expr: ada_accommodation_flag
    - name: "Attendance Points"
      expr: attendance_points
    - name: "Attendant Code"
      expr: attendant_code
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Emergency Contact Name"
      expr: emergency_contact_name
    - name: "Emergency Contact Phone"
      expr: emergency_contact_phone
    - name: "Employment Status"
      expr: employment_status
    - name: "Hire Date"
      expr: hire_date
    - name: "Language Skills"
      expr: language_skills
    - name: "Last Performance Review Date"
      expr: last_performance_review_date
    - name: "Last Updated Timestamp"
      expr: last_updated_timestamp
    - name: "Locker Number"
      expr: locker_number
    - name: "Mobile Device Code"
      expr: mobile_device_code
    - name: "Notes"
      expr: notes
    - name: "Performance Rating"
      expr: performance_rating
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Attendant"
      expr: COUNT(DISTINCT attendant_id)
    - name: "Total Average Credits Per Shift"
      expr: SUM(average_credits_per_shift)
    - name: "Average Average Credits Per Shift"
      expr: AVG(average_credits_per_shift)
    - name: "Total Target Credits Per Shift"
      expr: SUM(target_credits_per_shift)
    - name: "Average Target Credits Per Shift"
      expr: AVG(target_credits_per_shift)
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`housekeeping_cleaning_standard`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Cleaning Standard business metrics"
  source: "`vibe_travel_hospitality_v1`.`housekeeping`.`cleaning_standard`"
  dimensions:
    - name: "Amenity Items List"
      expr: amenity_items_list
    - name: "Amenity Placement Instructions"
      expr: amenity_placement_instructions
    - name: "Approval Date"
      expr: approval_date
    - name: "Approved By"
      expr: approved_by
    - name: "Brand Compliance Required Flag"
      expr: brand_compliance_required_flag
    - name: "Brand Tier"
      expr: brand_tier
    - name: "Certification Required Flag"
      expr: certification_required_flag
    - name: "Chemical Product Specifications"
      expr: chemical_product_specifications
    - name: "Cleaning Standard Status"
      expr: cleaning_standard_status
    - name: "Cleaning Type"
      expr: cleaning_type
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Effective Date"
      expr: effective_date
    - name: "Equipment Required"
      expr: equipment_required
    - name: "Expiration Date"
      expr: expiration_date
    - name: "Guest Segment"
      expr: guest_segment
    - name: "Last Review Date"
      expr: last_review_date
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Cleaning Standard"
      expr: COUNT(DISTINCT cleaning_standard_id)
    - name: "Total Cost Per Execution Estimate"
      expr: SUM(cost_per_execution_estimate)
    - name: "Average Cost Per Execution Estimate"
      expr: AVG(cost_per_execution_estimate)
    - name: "Total Inspection Pass Threshold Score"
      expr: SUM(inspection_pass_threshold_score)
    - name: "Average Inspection Pass Threshold Score"
      expr: AVG(inspection_pass_threshold_score)
    - name: "Total Labor Cost Estimate"
      expr: SUM(labor_cost_estimate)
    - name: "Average Labor Cost Estimate"
      expr: AVG(labor_cost_estimate)
    - name: "Total Supply Cost Estimate"
      expr: SUM(supply_cost_estimate)
    - name: "Average Supply Cost Estimate"
      expr: AVG(supply_cost_estimate)
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`housekeeping_cleaning_task`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Cleaning Task business metrics"
  source: "`vibe_travel_hospitality_v1`.`housekeeping`.`cleaning_task`"
  dimensions:
    - name: "Actual End Time"
      expr: actual_end_time
    - name: "Actual Start Time"
      expr: actual_start_time
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Duration Minutes"
      expr: duration_minutes
    - name: "Exception Flag"
      expr: exception_flag
    - name: "Exception Notes"
      expr: exception_notes
    - name: "Guest Present"
      expr: guest_present
    - name: "Guest Request Flag"
      expr: guest_request_flag
    - name: "Inspection Required"
      expr: inspection_required
    - name: "Inspection Timestamp"
      expr: inspection_timestamp
    - name: "Is Mandatory"
      expr: is_mandatory
    - name: "Is Quality Checkpoint"
      expr: is_quality_checkpoint
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Maintenance Request Generated"
      expr: maintenance_request_generated
    - name: "Quality Score"
      expr: quality_score
    - name: "Room Type Code"
      expr: room_type_code
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Cleaning Task"
      expr: COUNT(DISTINCT cleaning_task_id)
    - name: "Total Credit Weight"
      expr: SUM(credit_weight)
    - name: "Average Credit Weight"
      expr: AVG(credit_weight)
    - name: "Total Supply Quantity Used"
      expr: SUM(supply_quantity_used)
    - name: "Average Supply Quantity Used"
      expr: AVG(supply_quantity_used)
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`housekeeping_deep_clean_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Deep Clean Plan business metrics"
  source: "`vibe_travel_hospitality_v1`.`housekeeping`.`deep_clean_plan`"
  dimensions:
    - name: "Actual End Time"
      expr: actual_end_time
    - name: "Actual Start Time"
      expr: actual_start_time
    - name: "Area Name"
      expr: area_name
    - name: "Area Type"
      expr: area_type
    - name: "Cancellation Reason"
      expr: cancellation_reason
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Deep Clean Plan Status"
      expr: deep_clean_plan_status
    - name: "Ffe Inspection Performed"
      expr: ffe_inspection_performed
    - name: "Inspection Date"
      expr: inspection_date
    - name: "Inspection Notes"
      expr: inspection_notes
    - name: "Inspection Status"
      expr: inspection_status
    - name: "Last Modified By"
      expr: last_modified_by
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Maintenance Issues Identified"
      expr: maintenance_issues_identified
    - name: "Notes"
      expr: notes
    - name: "Pip Compliance Flag"
      expr: pip_compliance_flag
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Deep Clean Plan"
      expr: COUNT(DISTINCT deep_clean_plan_id)
    - name: "Total Actual Labor Hours"
      expr: SUM(actual_labor_hours)
    - name: "Average Actual Labor Hours"
      expr: AVG(actual_labor_hours)
    - name: "Total Completion Percentage"
      expr: SUM(completion_percentage)
    - name: "Average Completion Percentage"
      expr: AVG(completion_percentage)
    - name: "Total Estimated Labor Hours"
      expr: SUM(estimated_labor_hours)
    - name: "Average Estimated Labor Hours"
      expr: AVG(estimated_labor_hours)
    - name: "Total Labor Cost"
      expr: SUM(labor_cost)
    - name: "Average Labor Cost"
      expr: AVG(labor_cost)
    - name: "Total Supply Cost"
      expr: SUM(supply_cost)
    - name: "Average Supply Cost"
      expr: AVG(supply_cost)
    - name: "Total Total Cost"
      expr: SUM(total_cost)
    - name: "Average Total Cost"
      expr: AVG(total_cost)
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`housekeeping_hk_assignment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Hk Assignment business metrics"
  source: "`vibe_travel_hospitality_v1`.`housekeeping`.`hk_assignment`"
  dimensions:
    - name: "Actual End Time"
      expr: actual_end_time
    - name: "Actual Start Time"
      expr: actual_start_time
    - name: "Allergy Flags"
      expr: allergy_flags
    - name: "Amenity Replenishment Flag"
      expr: amenity_replenishment_flag
    - name: "Assignment Date"
      expr: assignment_date
    - name: "Assignment Number"
      expr: assignment_number
    - name: "Assignment Type"
      expr: assignment_type
    - name: "Cancellation Reason"
      expr: cancellation_reason
    - name: "Completion Status"
      expr: completion_status
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Dnd Flag"
      expr: dnd_flag
    - name: "Estimated End Time"
      expr: estimated_end_time
    - name: "Estimated Start Time"
      expr: estimated_start_time
    - name: "Guest Preference Instructions"
      expr: guest_preference_instructions
    - name: "Inspection Notes"
      expr: inspection_notes
    - name: "Inspection Required Flag"
      expr: inspection_required_flag
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Hk Assignment"
      expr: COUNT(DISTINCT hk_assignment_id)
    - name: "Total Room Credits"
      expr: SUM(room_credits)
    - name: "Average Room Credits"
      expr: AVG(room_credits)
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`housekeeping_hk_schedule`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Hk Schedule business metrics"
  source: "`vibe_travel_hospitality_v1`.`housekeeping`.`hk_schedule`"
  dimensions:
    - name: "Assignment Method"
      expr: assignment_method
    - name: "Break Duration Minutes"
      expr: break_duration_minutes
    - name: "Break Start Time"
      expr: break_start_time
    - name: "Consecutive Days Worked"
      expr: consecutive_days_worked
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Modified Timestamp"
      expr: modified_timestamp
    - name: "Notes"
      expr: notes
    - name: "Occupancy Forecast Tier"
      expr: occupancy_forecast_tier
    - name: "Pip Compliance Flag"
      expr: pip_compliance_flag
    - name: "Planned Headcount"
      expr: planned_headcount
    - name: "Published Timestamp"
      expr: published_timestamp
    - name: "Schedule Date"
      expr: schedule_date
    - name: "Schedule Status"
      expr: schedule_status
    - name: "Section Code"
      expr: section_code
    - name: "Section Room Count"
      expr: section_room_count
    - name: "Shift End Time"
      expr: shift_end_time
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Hk Schedule"
      expr: COUNT(DISTINCT hk_schedule_id)
    - name: "Total Cpor Target"
      expr: SUM(cpor_target)
    - name: "Average Cpor Target"
      expr: AVG(cpor_target)
    - name: "Total Labor Budget Amount"
      expr: SUM(labor_budget_amount)
    - name: "Average Labor Budget Amount"
      expr: AVG(labor_budget_amount)
    - name: "Total Overtime Threshold Hours"
      expr: SUM(overtime_threshold_hours)
    - name: "Average Overtime Threshold Hours"
      expr: AVG(overtime_threshold_hours)
    - name: "Total Section Credit Value"
      expr: SUM(section_credit_value)
    - name: "Average Section Credit Value"
      expr: AVG(section_credit_value)
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`housekeeping_housekeeping_training_completion`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Housekeeping Training Completion business metrics"
  source: "`vibe_travel_hospitality_v1`.`housekeeping`.`housekeeping_training_completion`"
  dimensions:
    - name: "Attempt Number"
      expr: attempt_number
    - name: "Bloodborne Pathogen Certification Date"
      expr: bloodborne_pathogen_certification_date
    - name: "Bloodborne Pathogen Certified Flag"
      expr: bloodborne_pathogen_certified_flag
    - name: "Certificate Issued Flag"
      expr: certificate_issued_flag
    - name: "Certificate Number"
      expr: certificate_number
    - name: "Certification Expiry Date"
      expr: certification_expiry_date
    - name: "Chemical Handling Certification Date"
      expr: chemical_handling_certification_date
    - name: "Chemical Handling Certified Flag"
      expr: chemical_handling_certified_flag
    - name: "Completion Date"
      expr: completion_date
    - name: "Completion Status"
      expr: completion_status
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Enrollment Date"
      expr: enrollment_date
    - name: "Last Updated Timestamp"
      expr: last_updated_timestamp
    - name: "Suite Qualified Flag"
      expr: suite_qualified_flag
    - name: "Vip Certified Flag"
      expr: vip_certified_flag
    - name: "Bloodborne Pathogen Certification Date Month"
      expr: DATE_TRUNC('MONTH', bloodborne_pathogen_certification_date)
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Housekeeping Training Completion"
      expr: COUNT(DISTINCT housekeeping_training_completion_id)
    - name: "Total Score"
      expr: SUM(score)
    - name: "Average Score"
      expr: AVG(score)
    - name: "Total Training Hours Completed"
      expr: SUM(training_hours_completed)
    - name: "Average Training Hours Completed"
      expr: AVG(training_hours_completed)
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`housekeeping_inspection`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Inspection business metrics"
  source: "`vibe_travel_hospitality_v1`.`housekeeping`.`inspection`"
  dimensions:
    - name: "Amenity Check Flag"
      expr: amenity_check_flag
    - name: "Bathroom Quality Flag"
      expr: bathroom_quality_flag
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Critical Deficiency Count"
      expr: critical_deficiency_count
    - name: "Deficiency Count"
      expr: deficiency_count
    - name: "Deficiency Description"
      expr: deficiency_description
    - name: "Duration Minutes"
      expr: duration_minutes
    - name: "End Timestamp"
      expr: end_timestamp
    - name: "Guest Arrival Date"
      expr: guest_arrival_date
    - name: "Inspection Number"
      expr: inspection_number
    - name: "Inspection Status"
      expr: inspection_status
    - name: "Inspection Type"
      expr: inspection_type
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Linen Quality Flag"
      expr: linen_quality_flag
    - name: "Maintenance Issue Flag"
      expr: maintenance_issue_flag
    - name: "Notes"
      expr: notes
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Inspection"
      expr: COUNT(DISTINCT inspection_id)
    - name: "Total Cleanliness Score"
      expr: SUM(cleanliness_score)
    - name: "Average Cleanliness Score"
      expr: AVG(cleanliness_score)
    - name: "Total Quality Score"
      expr: SUM(quality_score)
    - name: "Average Quality Score"
      expr: AVG(quality_score)
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`housekeeping_inspection_deficiency`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Inspection Deficiency business metrics"
  source: "`vibe_travel_hospitality_v1`.`housekeeping`.`inspection_deficiency`"
  dimensions:
    - name: "Actual Resolution Time Minutes"
      expr: actual_resolution_time_minutes
    - name: "Assigned Timestamp"
      expr: assigned_timestamp
    - name: "Blocks Room Sale Flag"
      expr: blocks_room_sale_flag
    - name: "Closed Timestamp"
      expr: closed_timestamp
    - name: "Corrective Action Required"
      expr: corrective_action_required
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Deficiency Category"
      expr: deficiency_category
    - name: "Deficiency Description"
      expr: deficiency_description
    - name: "Deficiency Sequence"
      expr: deficiency_sequence
    - name: "Deficiency Subcategory"
      expr: deficiency_subcategory
    - name: "Escalation Flag"
      expr: escalation_flag
    - name: "Escalation Reason"
      expr: escalation_reason
    - name: "Estimated Resolution Time Minutes"
      expr: estimated_resolution_time_minutes
    - name: "Guest Impacting Flag"
      expr: guest_impacting_flag
    - name: "Identified Timestamp"
      expr: identified_timestamp
    - name: "Inspector Notes"
      expr: inspector_notes
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Inspection Deficiency"
      expr: COUNT(DISTINCT inspection_deficiency_id)
    - name: "Total Resolution Cost Amount"
      expr: SUM(resolution_cost_amount)
    - name: "Average Resolution Cost Amount"
      expr: AVG(resolution_cost_amount)
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`housekeeping_laundry_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Laundry Order business metrics"
  source: "`vibe_travel_hospitality_v1`.`housekeeping`.`laundry_order`"
  dimensions:
    - name: "Actual Return Timestamp"
      expr: actual_return_timestamp
    - name: "Cancellation Reason"
      expr: cancellation_reason
    - name: "Cancelled Timestamp"
      expr: cancelled_timestamp
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Expected Return Timestamp"
      expr: expected_return_timestamp
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Order Number"
      expr: order_number
    - name: "Order Status"
      expr: order_status
    - name: "Order Type"
      expr: order_type
    - name: "Payment Status"
      expr: payment_status
    - name: "Pricing Method"
      expr: pricing_method
    - name: "Priority Level"
      expr: priority_level
    - name: "Processing Location"
      expr: processing_location
    - name: "Quality Inspection Notes"
      expr: quality_inspection_notes
    - name: "Quality Inspection Status"
      expr: quality_inspection_status
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Laundry Order"
      expr: COUNT(DISTINCT laundry_order_id)
    - name: "Total Cost Per Item"
      expr: SUM(cost_per_item)
    - name: "Average Cost Per Item"
      expr: AVG(cost_per_item)
    - name: "Total Cost Per Pound"
      expr: SUM(cost_per_pound)
    - name: "Average Cost Per Pound"
      expr: AVG(cost_per_pound)
    - name: "Total Total Cost"
      expr: SUM(total_cost)
    - name: "Average Total Cost"
      expr: AVG(total_cost)
    - name: "Total Total Weight Lbs"
      expr: SUM(total_weight_lbs)
    - name: "Average Total Weight Lbs"
      expr: AVG(total_weight_lbs)
    - name: "Total Turnaround Time Hours"
      expr: SUM(turnaround_time_hours)
    - name: "Average Turnaround Time Hours"
      expr: AVG(turnaround_time_hours)
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`housekeeping_linen_management`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Linen Management business metrics"
  source: "`vibe_travel_hospitality_v1`.`housekeeping`.`linen_management`"
  dimensions:
    - name: "Approval Status"
      expr: approval_status
    - name: "Approved Timestamp"
      expr: approved_timestamp
    - name: "Batch Number"
      expr: batch_number
    - name: "Condition Grade"
      expr: condition_grade
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Destination Location"
      expr: destination_location
    - name: "Discard Reason"
      expr: discard_reason
    - name: "Floor Number"
      expr: floor_number
    - name: "Is Voided"
      expr: is_voided
    - name: "Item Code"
      expr: item_code
    - name: "Item Description"
      expr: item_description
    - name: "Item Type"
      expr: item_type
    - name: "Last Updated Timestamp"
      expr: last_updated_timestamp
    - name: "Notes"
      expr: notes
    - name: "Par Level After"
      expr: par_level_after
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Linen Management"
      expr: COUNT(DISTINCT linen_management_id)
    - name: "Total Approved By"
      expr: SUM(approved_by)
    - name: "Average Approved By"
      expr: AVG(approved_by)
    - name: "Total Total Cost"
      expr: SUM(total_cost)
    - name: "Average Total Cost"
      expr: AVG(total_cost)
    - name: "Total Unit Cost"
      expr: SUM(unit_cost)
    - name: "Average Unit Cost"
      expr: AVG(unit_cost)
    - name: "Total Voided By"
      expr: SUM(voided_by)
    - name: "Average Voided By"
      expr: AVG(voided_by)
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`housekeeping_lost_and_found`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Lost And Found business metrics"
  source: "`vibe_travel_hospitality_v1`.`housekeeping`.`lost_and_found`"
  dimensions:
    - name: "Claim Date"
      expr: claim_date
    - name: "Claim Status"
      expr: claim_status
    - name: "Claimant Identification Number"
      expr: claimant_identification_number
    - name: "Claimant Identification Type"
      expr: claimant_identification_type
    - name: "Claimant Name"
      expr: claimant_name
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Discovery Date"
      expr: discovery_date
    - name: "Discovery Location Detail"
      expr: discovery_location_detail
    - name: "Discovery Location Type"
      expr: discovery_location_type
    - name: "Discovery Timestamp"
      expr: discovery_timestamp
    - name: "Disposition Date"
      expr: disposition_date
    - name: "Disposition Notes"
      expr: disposition_notes
    - name: "Disposition Type"
      expr: disposition_type
    - name: "Guest Notification Date"
      expr: guest_notification_date
    - name: "Guest Notification Method"
      expr: guest_notification_method
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Lost And Found"
      expr: COUNT(DISTINCT lost_and_found_id)
    - name: "Total Estimated Value Amount"
      expr: SUM(estimated_value_amount)
    - name: "Average Estimated Value Amount"
      expr: AVG(estimated_value_amount)
    - name: "Total Shipping Cost Amount"
      expr: SUM(shipping_cost_amount)
    - name: "Average Shipping Cost Amount"
      expr: AVG(shipping_cost_amount)
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`housekeeping_maintenance_handoff`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Maintenance Handoff business metrics"
  source: "`vibe_travel_hospitality_v1`.`housekeeping`.`maintenance_handoff`"
  dimensions:
    - name: "Acknowledged Timestamp"
      expr: acknowledged_timestamp
    - name: "Ada Compliance Issue"
      expr: ada_compliance_issue
    - name: "Assigned Timestamp"
      expr: assigned_timestamp
    - name: "Compensation Offered"
      expr: compensation_offered
    - name: "Completed Timestamp"
      expr: completed_timestamp
    - name: "Cost Currency Code"
      expr: cost_currency_code
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Defect Description"
      expr: defect_description
    - name: "Defect Type"
      expr: defect_type
    - name: "Estimated Completion Date"
      expr: estimated_completion_date
    - name: "Ffe Category"
      expr: ffe_category
    - name: "Follow Up Date"
      expr: follow_up_date
    - name: "Follow Up Required"
      expr: follow_up_required
    - name: "Guest Impacted"
      expr: guest_impacted
    - name: "Guest Notified"
      expr: guest_notified
    - name: "Handoff Status"
      expr: handoff_status
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Maintenance Handoff"
      expr: COUNT(DISTINCT maintenance_handoff_id)
    - name: "Total Actual Cost"
      expr: SUM(actual_cost)
    - name: "Average Actual Cost"
      expr: AVG(actual_cost)
    - name: "Total Estimated Cost"
      expr: SUM(estimated_cost)
    - name: "Average Estimated Cost"
      expr: AVG(estimated_cost)
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`housekeeping_maintenance_request`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Maintenance Request business metrics"
  source: "`vibe_travel_hospitality_v1`.`housekeeping`.`maintenance_request`"
  dimensions:
    - name: "Acknowledged Timestamp"
      expr: acknowledged_timestamp
    - name: "Actual Duration Minutes"
      expr: actual_duration_minutes
    - name: "Actual Start Timestamp"
      expr: actual_start_timestamp
    - name: "Assigned Timestamp"
      expr: assigned_timestamp
    - name: "Maintenance Request Category"
      expr: maintenance_request_category
    - name: "Closed Timestamp"
      expr: closed_timestamp
    - name: "Completed Timestamp"
      expr: completed_timestamp
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Estimated Duration Minutes"
      expr: estimated_duration_minutes
    - name: "Guest Impact Flag"
      expr: guest_impact_flag
    - name: "Inspection Completed Timestamp"
      expr: inspection_completed_timestamp
    - name: "Inspection Notes"
      expr: inspection_notes
    - name: "Inspection Passed Flag"
      expr: inspection_passed_flag
    - name: "Inspection Required Flag"
      expr: inspection_required_flag
    - name: "Issue Description"
      expr: issue_description
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Maintenance Request"
      expr: COUNT(DISTINCT maintenance_request_id)
    - name: "Total Actual Cost Amount"
      expr: SUM(actual_cost_amount)
    - name: "Average Actual Cost Amount"
      expr: AVG(actual_cost_amount)
    - name: "Total Estimated Cost Amount"
      expr: SUM(estimated_cost_amount)
    - name: "Average Estimated Cost Amount"
      expr: AVG(estimated_cost_amount)
    - name: "Total Labor Cost Amount"
      expr: SUM(labor_cost_amount)
    - name: "Average Labor Cost Amount"
      expr: AVG(labor_cost_amount)
    - name: "Total Materials Cost Amount"
      expr: SUM(materials_cost_amount)
    - name: "Average Materials Cost Amount"
      expr: AVG(materials_cost_amount)
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`housekeeping_public_area`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Public Area business metrics"
  source: "`vibe_travel_hospitality_v1`.`housekeeping`.`public_area`"
  dimensions:
    - name: "Active Flag"
      expr: active_flag
    - name: "Ada Compliant Flag"
      expr: ada_compliant_flag
    - name: "Area Code"
      expr: area_code
    - name: "Area Name"
      expr: area_name
    - name: "Area Type"
      expr: area_type
    - name: "Building Section"
      expr: building_section
    - name: "Chemical Products Approved"
      expr: chemical_products_approved
    - name: "Cleaning Frequency Times Per Day"
      expr: cleaning_frequency_times_per_day
    - name: "Cleaning Frequency Type"
      expr: cleaning_frequency_type
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Deep Clean Rotation Cycle Days"
      expr: deep_clean_rotation_cycle_days
    - name: "Effective Date"
      expr: effective_date
    - name: "Expiration Date"
      expr: expiration_date
    - name: "Floor Level"
      expr: floor_level
    - name: "Guest Facing Flag"
      expr: guest_facing_flag
    - name: "High Traffic Flag"
      expr: high_traffic_flag
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Public Area"
      expr: COUNT(DISTINCT public_area_id)
    - name: "Total Credit Value"
      expr: SUM(credit_value)
    - name: "Average Credit Value"
      expr: AVG(credit_value)
    - name: "Total Estimated Monthly Labor Hours"
      expr: SUM(estimated_monthly_labor_hours)
    - name: "Average Estimated Monthly Labor Hours"
      expr: AVG(estimated_monthly_labor_hours)
    - name: "Total Estimated Monthly Supply Cost"
      expr: SUM(estimated_monthly_supply_cost)
    - name: "Average Estimated Monthly Supply Cost"
      expr: AVG(estimated_monthly_supply_cost)
    - name: "Total Last Inspection Score"
      expr: SUM(last_inspection_score)
    - name: "Average Last Inspection Score"
      expr: AVG(last_inspection_score)
    - name: "Total Quality Score Target"
      expr: SUM(quality_score_target)
    - name: "Average Quality Score Target"
      expr: AVG(quality_score_target)
    - name: "Total Square Footage"
      expr: SUM(square_footage)
    - name: "Average Square Footage"
      expr: AVG(square_footage)
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`housekeeping_supply_consumption`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Supply Consumption business metrics"
  source: "`vibe_travel_hospitality_v1`.`housekeeping`.`supply_consumption`"
  dimensions:
    - name: "Amenity Type"
      expr: amenity_type
    - name: "Batch Number"
      expr: batch_number
    - name: "Consumption Date"
      expr: consumption_date
    - name: "Consumption Reason"
      expr: consumption_reason
    - name: "Consumption Timestamp"
      expr: consumption_timestamp
    - name: "Cost Center Code"
      expr: cost_center_code
    - name: "Currency Code"
      expr: currency_code
    - name: "Expiry Date"
      expr: expiry_date
    - name: "Gl Account Code"
      expr: gl_account_code
    - name: "Guest Charged Indicator"
      expr: guest_charged_indicator
    - name: "Guest Segment"
      expr: guest_segment
    - name: "Notes"
      expr: notes
    - name: "Occupancy Status"
      expr: occupancy_status
    - name: "Quality Grade"
      expr: quality_grade
    - name: "Record Created Timestamp"
      expr: record_created_timestamp
    - name: "Record Updated Timestamp"
      expr: record_updated_timestamp
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Supply Consumption"
      expr: COUNT(DISTINCT supply_consumption_id)
    - name: "Total Charge Amount"
      expr: SUM(charge_amount)
    - name: "Average Charge Amount"
      expr: AVG(charge_amount)
    - name: "Total Par Level"
      expr: SUM(par_level)
    - name: "Average Par Level"
      expr: AVG(par_level)
    - name: "Total Quantity Consumed"
      expr: SUM(quantity_consumed)
    - name: "Average Quantity Consumed"
      expr: AVG(quantity_consumed)
    - name: "Total Replenishment Quantity"
      expr: SUM(replenishment_quantity)
    - name: "Average Replenishment Quantity"
      expr: AVG(replenishment_quantity)
    - name: "Total Total Cost"
      expr: SUM(total_cost)
    - name: "Average Total Cost"
      expr: AVG(total_cost)
    - name: "Total Unit Cost"
      expr: SUM(unit_cost)
    - name: "Average Unit Cost"
      expr: AVG(unit_cost)
    - name: "Total Variance From Par"
      expr: SUM(variance_from_par)
    - name: "Average Variance From Par"
      expr: AVG(variance_from_par)
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`housekeeping_team`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Team business metrics"
  source: "`vibe_travel_hospitality_v1`.`housekeeping`.`team`"
  dimensions:
    - name: "Break Duration Minutes"
      expr: break_duration_minutes
    - name: "Building Section"
      expr: building_section
    - name: "Certification Level"
      expr: certification_level
    - name: "Team Code"
      expr: team_code
    - name: "Contact Email"
      expr: contact_email
    - name: "Contact Phone"
      expr: contact_phone
    - name: "Cost Center Code"
      expr: cost_center_code
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Effective From Date"
      expr: effective_from_date
    - name: "Effective To Date"
      expr: effective_to_date
    - name: "End Time"
      expr: end_time
    - name: "Equipment Cart Ids"
      expr: equipment_cart_ids
    - name: "Floor Assignment"
      expr: floor_assignment
    - name: "Is Seasonal"
      expr: is_seasonal
    - name: "Language Capabilities"
      expr: language_capabilities
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Team"
      expr: COUNT(DISTINCT team_id)
    - name: "Total Average Rooms Per Attendant"
      expr: SUM(average_rooms_per_attendant)
    - name: "Average Average Rooms Per Attendant"
      expr: AVG(average_rooms_per_attendant)
    - name: "Total Budget Labor Hours Per Month"
      expr: SUM(budget_labor_hours_per_month)
    - name: "Average Budget Labor Hours Per Month"
      expr: AVG(budget_labor_hours_per_month)
    - name: "Total Guest Satisfaction Score"
      expr: SUM(guest_satisfaction_score)
    - name: "Average Guest Satisfaction Score"
      expr: AVG(guest_satisfaction_score)
    - name: "Total Quality Score Average"
      expr: SUM(quality_score_average)
    - name: "Average Quality Score Average"
      expr: AVG(quality_score_average)
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`housekeeping_work_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Work Order business metrics"
  source: "`vibe_travel_hospitality_v1`.`housekeeping`.`work_order`"
  dimensions:
    - name: "Actual Completion Time"
      expr: actual_completion_time
    - name: "Actual Start Time"
      expr: actual_start_time
    - name: "Amenity Replenishment Required"
      expr: amenity_replenishment_required
    - name: "Cancellation Reason"
      expr: cancellation_reason
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Guest Request Notes"
      expr: guest_request_notes
    - name: "Inspection Result"
      expr: inspection_result
    - name: "Inspection Time"
      expr: inspection_time
    - name: "Linen Change Required"
      expr: linen_change_required
    - name: "Maintenance Handoff Required"
      expr: maintenance_handoff_required
    - name: "Modified Timestamp"
      expr: modified_timestamp
    - name: "Priority"
      expr: priority
    - name: "Room Status After"
      expr: room_status_after
    - name: "Room Status Before"
      expr: room_status_before
    - name: "Scheduled Completion Time"
      expr: scheduled_completion_time
    - name: "Scheduled Start Date"
      expr: scheduled_start_date
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Work Order"
      expr: COUNT(DISTINCT work_order_id)
    - name: "Total Inspection Score"
      expr: SUM(inspection_score)
    - name: "Average Inspection Score"
      expr: AVG(inspection_score)
    - name: "Total Labor Cost Amount"
      expr: SUM(labor_cost_amount)
    - name: "Average Labor Cost Amount"
      expr: AVG(labor_cost_amount)
    - name: "Total Supply Cost Amount"
      expr: SUM(supply_cost_amount)
    - name: "Average Supply Cost Amount"
      expr: AVG(supply_cost_amount)
$$;