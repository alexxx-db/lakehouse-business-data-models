-- Metric views for domain: order | Business: Healthcare | Version: 2 | Generated on: 2026-07-02 09:11:47

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`order_clinical_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core clinical order metrics tracking order volume, completion rates, CPOE adoption, and turnaround times across order types, statuses, and clinical contexts."
  source: "`vibe_healthcare_v1`.`order`.`clinical_order`"
  dimensions:
    - name: "order_type"
      expr: order_type
      comment: "Type of clinical order (lab, imaging, medication, procedure, etc.)"
    - name: "order_status"
      expr: order_status
      comment: "Current status of the order in its lifecycle"
    - name: "clinical_order_status"
      expr: clinical_order_status
      comment: "Clinical-specific order status (may differ from general order_status)"
    - name: "order_priority"
      expr: order_priority
      comment: "Priority level of the order (STAT, urgent, routine, etc.)"
    - name: "order_class"
      expr: order_class
      comment: "Classification of the order (inpatient, outpatient, emergency, etc.)"
    - name: "order_mode"
      expr: order_mode
      comment: "Mode of order entry (CPOE, verbal, telephone, written, etc.)"
    - name: "is_cpoe_entered"
      expr: is_cpoe_entered
      comment: "Boolean flag indicating if order was entered via computerized provider order entry"
    - name: "is_verbal_order"
      expr: is_verbal_order
      comment: "Boolean flag indicating if order was given verbally"
    - name: "is_order_set_member"
      expr: is_order_set_member
      comment: "Boolean flag indicating if order is part of an order set"
    - name: "is_recurring"
      expr: is_recurring
      comment: "Boolean flag indicating if order is recurring/standing"
    - name: "frequency_code"
      expr: frequency_code
      comment: "Frequency code for recurring orders (QD, BID, TID, etc.)"
    - name: "order_date"
      expr: DATE(order_datetime)
      comment: "Date the order was placed"
    - name: "order_year_month"
      expr: DATE_TRUNC('MONTH', order_datetime)
      comment: "Year-month of order placement for trending"
    - name: "completed_date"
      expr: DATE(completed_datetime)
      comment: "Date the order was completed"
    - name: "cancellation_reason"
      expr: cancellation_reason
      comment: "Reason for order cancellation if applicable"
  measures:
    - name: "total_orders"
      expr: COUNT(clinical_order_id)
      comment: "Total number of clinical orders placed"
    - name: "unique_patients"
      expr: COUNT(DISTINCT mpi_record_id)
      comment: "Distinct count of patients with clinical orders"
    - name: "cpoe_orders"
      expr: COUNT(CASE WHEN is_cpoe_entered = TRUE THEN clinical_order_id END)
      comment: "Count of orders entered via CPOE system"
    - name: "cpoe_adoption_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_cpoe_entered = TRUE THEN clinical_order_id END) / NULLIF(COUNT(clinical_order_id), 0), 2)
      comment: "Percentage of orders entered via CPOE (key quality and safety metric)"
    - name: "verbal_orders"
      expr: COUNT(CASE WHEN is_verbal_order = TRUE THEN clinical_order_id END)
      comment: "Count of verbal orders (higher risk, should be minimized)"
    - name: "verbal_order_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_verbal_order = TRUE THEN clinical_order_id END) / NULLIF(COUNT(clinical_order_id), 0), 2)
      comment: "Percentage of orders given verbally (quality and safety indicator)"
    - name: "completed_orders"
      expr: COUNT(CASE WHEN completed_datetime IS NOT NULL THEN clinical_order_id END)
      comment: "Count of orders that have been completed"
    - name: "completion_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN completed_datetime IS NOT NULL THEN clinical_order_id END) / NULLIF(COUNT(clinical_order_id), 0), 2)
      comment: "Percentage of orders completed (operational efficiency metric)"
    - name: "cancelled_orders"
      expr: COUNT(CASE WHEN cancelled_datetime IS NOT NULL THEN clinical_order_id END)
      comment: "Count of orders that were cancelled"
    - name: "cancellation_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN cancelled_datetime IS NOT NULL THEN clinical_order_id END) / NULLIF(COUNT(clinical_order_id), 0), 2)
      comment: "Percentage of orders cancelled (quality indicator - high rates may indicate ordering issues)"
    - name: "stat_orders"
      expr: COUNT(CASE WHEN order_priority = 'STAT' THEN clinical_order_id END)
      comment: "Count of STAT priority orders requiring immediate attention"
    - name: "stat_order_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN order_priority = 'STAT' THEN clinical_order_id END) / NULLIF(COUNT(clinical_order_id), 0), 2)
      comment: "Percentage of orders marked STAT (resource utilization and appropriateness metric)"
    - name: "order_set_orders"
      expr: COUNT(CASE WHEN is_order_set_member = TRUE THEN clinical_order_id END)
      comment: "Count of orders placed as part of order sets"
    - name: "order_set_utilization_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_order_set_member = TRUE THEN clinical_order_id END) / NULLIF(COUNT(clinical_order_id), 0), 2)
      comment: "Percentage of orders from order sets (standardization and efficiency metric)"
    - name: "avg_order_to_completion_hours"
      expr: AVG(CAST((UNIX_TIMESTAMP(completed_datetime) - UNIX_TIMESTAMP(order_datetime)) / 3600.0 AS DOUBLE))
      comment: "Average hours from order placement to completion (turnaround time efficiency)"
    - name: "total_quantity_ordered"
      expr: SUM(CAST(quantity_ordered AS DOUBLE))
      comment: "Total quantity ordered across all orders"
    - name: "avg_quantity_per_order"
      expr: AVG(CAST(quantity_ordered AS DOUBLE))
      comment: "Average quantity per order"
    - name: "orders_requiring_cosign"
      expr: COUNT(CASE WHEN cosign_due_datetime IS NOT NULL THEN clinical_order_id END)
      comment: "Count of orders requiring co-signature (supervision and training metric)"
    - name: "cosign_completion_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN cosign_completed_datetime IS NOT NULL THEN clinical_order_id END) / NULLIF(COUNT(CASE WHEN cosign_due_datetime IS NOT NULL THEN clinical_order_id END), 0), 2)
      comment: "Percentage of required co-signatures completed (compliance metric)"
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`order_fulfillment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Order fulfillment metrics tracking completion rates, turnaround times, charge capture, quality flags, and operational efficiency of order execution."
  source: "`vibe_healthcare_v1`.`order`.`fulfillment`"
  dimensions:
    - name: "fulfillment_status"
      expr: fulfillment_status
      comment: "Current status of the fulfillment (completed, in-progress, cancelled, etc.)"
    - name: "order_type"
      expr: order_type
      comment: "Type of order being fulfilled"
    - name: "method"
      expr: method
      comment: "Method used to fulfill the order"
    - name: "priority_code"
      expr: priority_code
      comment: "Priority level of the fulfillment"
    - name: "performing_department_code"
      expr: performing_department_code
      comment: "Department code performing the fulfillment"
    - name: "charge_capture_flag"
      expr: charge_capture_flag
      comment: "Boolean indicating if charges were captured for this fulfillment"
    - name: "partial_fulfillment_flag"
      expr: partial_fulfillment_flag
      comment: "Boolean indicating if this is a partial fulfillment"
    - name: "quality_flag"
      expr: quality_flag
      comment: "Boolean quality indicator flag for fulfillment"
    - name: "exception_reason_code"
      expr: exception_reason_code
      comment: "Code for any exception that occurred during fulfillment"
    - name: "fulfillment_date"
      expr: DATE(datetime)
      comment: "Date the fulfillment occurred"
    - name: "fulfillment_year_month"
      expr: DATE_TRUNC('MONTH', datetime)
      comment: "Year-month of fulfillment for trending"
  measures:
    - name: "total_fulfillments"
      expr: COUNT(fulfillment_id)
      comment: "Total number of order fulfillments"
    - name: "unique_orders_fulfilled"
      expr: COUNT(DISTINCT clinical_order_id)
      comment: "Distinct count of clinical orders that have fulfillments"
    - name: "unique_patients_served"
      expr: COUNT(DISTINCT demographics_id)
      comment: "Distinct count of patients receiving fulfilled orders"
    - name: "completed_fulfillments"
      expr: COUNT(CASE WHEN fulfillment_status = 'completed' THEN fulfillment_id END)
      comment: "Count of fulfillments with completed status"
    - name: "fulfillment_completion_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN fulfillment_status = 'completed' THEN fulfillment_id END) / NULLIF(COUNT(fulfillment_id), 0), 2)
      comment: "Percentage of fulfillments completed successfully (operational efficiency metric)"
    - name: "partial_fulfillments"
      expr: COUNT(CASE WHEN partial_fulfillment_flag = TRUE THEN fulfillment_id END)
      comment: "Count of partial fulfillments"
    - name: "partial_fulfillment_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN partial_fulfillment_flag = TRUE THEN fulfillment_id END) / NULLIF(COUNT(fulfillment_id), 0), 2)
      comment: "Percentage of fulfillments that are partial (supply chain and inventory metric)"
    - name: "fulfillments_with_exceptions"
      expr: COUNT(CASE WHEN exception_reason_code IS NOT NULL THEN fulfillment_id END)
      comment: "Count of fulfillments with exceptions"
    - name: "exception_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN exception_reason_code IS NOT NULL THEN fulfillment_id END) / NULLIF(COUNT(fulfillment_id), 0), 2)
      comment: "Percentage of fulfillments with exceptions (quality and process improvement metric)"
    - name: "quality_flagged_fulfillments"
      expr: COUNT(CASE WHEN quality_flag = TRUE THEN fulfillment_id END)
      comment: "Count of fulfillments flagged for quality review"
    - name: "quality_flag_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN quality_flag = TRUE THEN fulfillment_id END) / NULLIF(COUNT(fulfillment_id), 0), 2)
      comment: "Percentage of fulfillments flagged for quality issues (quality assurance metric)"
    - name: "charge_captured_fulfillments"
      expr: COUNT(CASE WHEN charge_capture_flag = TRUE THEN fulfillment_id END)
      comment: "Count of fulfillments with charges captured"
    - name: "charge_capture_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN charge_capture_flag = TRUE THEN fulfillment_id END) / NULLIF(COUNT(fulfillment_id), 0), 2)
      comment: "Percentage of fulfillments with charges captured (revenue cycle efficiency metric)"
    - name: "total_charge_amount"
      expr: SUM(CAST(charge_amount AS DOUBLE))
      comment: "Total charge amount for all fulfillments (revenue metric)"
    - name: "avg_charge_per_fulfillment"
      expr: AVG(CAST(charge_amount AS DOUBLE))
      comment: "Average charge amount per fulfillment"
    - name: "total_ordered_quantity"
      expr: SUM(CAST(ordered_quantity AS DOUBLE))
      comment: "Total quantity ordered across all fulfillments"
    - name: "total_fulfilled_quantity"
      expr: SUM(CAST(fulfilled_quantity AS DOUBLE))
      comment: "Total quantity actually fulfilled"
    - name: "fulfillment_yield_rate"
      expr: ROUND(100.0 * SUM(CAST(fulfilled_quantity AS DOUBLE)) / NULLIF(SUM(CAST(ordered_quantity AS DOUBLE)), 0), 2)
      comment: "Percentage of ordered quantity actually fulfilled (supply chain efficiency metric)"
    - name: "avg_turnaround_time_minutes"
      expr: AVG(CAST((UNIX_TIMESTAMP(result_availability_datetime) - UNIX_TIMESTAMP(created_datetime)) / 60.0 AS DOUBLE))
      comment: "Average minutes from fulfillment creation to result availability (operational efficiency)"
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`order_referral_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Referral order metrics tracking referral volume, authorization rates, loop closure, disposition outcomes, and care coordination effectiveness."
  source: "`vibe_healthcare_v1`.`order`.`referral_order`"
  dimensions:
    - name: "referral_type"
      expr: referral_type
      comment: "Type of referral (specialist, facility, service, etc.)"
    - name: "referral_status"
      expr: referral_status
      comment: "Current status of the referral"
    - name: "order_status"
      expr: order_status
      comment: "Order-level status of the referral"
    - name: "referral_disposition"
      expr: referral_disposition
      comment: "Final disposition of the referral (completed, declined, no-show, etc.)"
    - name: "referral_source"
      expr: referral_source
      comment: "Source of the referral"
    - name: "urgency_level"
      expr: urgency_level
      comment: "Urgency level of the referral"
    - name: "is_stat_order"
      expr: is_stat_order
      comment: "Boolean flag indicating if referral is STAT priority"
    - name: "authorization_required"
      expr: authorization_required
      comment: "Boolean flag indicating if prior authorization is required"
    - name: "referral_loop_closed"
      expr: referral_loop_closed
      comment: "Boolean flag indicating if referral loop has been closed (care coordination metric)"
    - name: "order_placed_year_month"
      expr: DATE_TRUNC('MONTH', order_placed_timestamp)
      comment: "Year-month of referral order placement for trending"
    - name: "effective_date"
      expr: effective_date
      comment: "Date the referral becomes effective"
    - name: "disposition_date"
      expr: disposition_date
      comment: "Date the referral was dispositioned"
  measures:
    - name: "total_referrals"
      expr: COUNT(referral_order_id)
      comment: "Total number of referral orders placed"
    - name: "unique_patients_referred"
      expr: COUNT(DISTINCT demographics_id)
      comment: "Distinct count of patients with referrals"
    - name: "unique_receiving_providers"
      expr: COUNT(DISTINCT receiving_provider_clinician_id)
      comment: "Distinct count of providers receiving referrals"
    - name: "referrals_requiring_auth"
      expr: COUNT(CASE WHEN authorization_required = TRUE THEN referral_order_id END)
      comment: "Count of referrals requiring prior authorization"
    - name: "authorization_requirement_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN authorization_required = TRUE THEN referral_order_id END) / NULLIF(COUNT(referral_order_id), 0), 2)
      comment: "Percentage of referrals requiring prior authorization (administrative burden metric)"
    - name: "stat_referrals"
      expr: COUNT(CASE WHEN is_stat_order = TRUE THEN referral_order_id END)
      comment: "Count of STAT priority referrals"
    - name: "stat_referral_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_stat_order = TRUE THEN referral_order_id END) / NULLIF(COUNT(referral_order_id), 0), 2)
      comment: "Percentage of referrals marked STAT (urgency and appropriateness metric)"
    - name: "referrals_with_loop_closed"
      expr: COUNT(CASE WHEN referral_loop_closed = TRUE THEN referral_order_id END)
      comment: "Count of referrals with closed loop (care coordination completed)"
    - name: "loop_closure_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN referral_loop_closed = TRUE THEN referral_order_id END) / NULLIF(COUNT(referral_order_id), 0), 2)
      comment: "Percentage of referrals with closed loop (critical care coordination quality metric)"
    - name: "referrals_with_scheduled_appointment"
      expr: COUNT(CASE WHEN scheduled_appointment_date IS NOT NULL THEN referral_order_id END)
      comment: "Count of referrals with scheduled appointments"
    - name: "appointment_scheduling_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN scheduled_appointment_date IS NOT NULL THEN referral_order_id END) / NULLIF(COUNT(referral_order_id), 0), 2)
      comment: "Percentage of referrals with appointments scheduled (access and coordination metric)"
    - name: "referrals_with_disposition"
      expr: COUNT(CASE WHEN disposition_date IS NOT NULL THEN referral_order_id END)
      comment: "Count of referrals with final disposition recorded"
    - name: "disposition_completion_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN disposition_date IS NOT NULL THEN referral_order_id END) / NULLIF(COUNT(referral_order_id), 0), 2)
      comment: "Percentage of referrals with disposition recorded (process completion metric)"
    - name: "avg_referral_to_appointment_days"
      expr: AVG(CAST(DATEDIFF(scheduled_appointment_date, effective_date) AS DOUBLE))
      comment: "Average days from referral effective date to scheduled appointment (access timeliness metric)"
    - name: "avg_referral_to_disposition_days"
      expr: AVG(CAST(DATEDIFF(disposition_date, effective_date) AS DOUBLE))
      comment: "Average days from referral effective date to disposition (cycle time metric)"
    - name: "avg_referral_to_loop_closure_days"
      expr: AVG(CAST(DATEDIFF(loop_closed_date, effective_date) AS DOUBLE))
      comment: "Average days from referral effective date to loop closure (care coordination efficiency)"
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`order_diet_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Diet order metrics tracking NPO status, diet type distribution, nutritional targets, and dietary order management for inpatient nutrition care."
  source: "`vibe_healthcare_v1`.`order`.`diet_order`"
  dimensions:
    - name: "diet_type"
      expr: diet_type
      comment: "Type of diet ordered (regular, cardiac, diabetic, renal, etc.)"
    - name: "diet_type_code"
      expr: diet_type_code
      comment: "Standardized code for diet type"
    - name: "diet_order_status"
      expr: diet_order_status
      comment: "Current status of the diet order"
    - name: "npo_status"
      expr: npo_status
      comment: "Boolean indicating if patient is NPO (nothing by mouth)"
    - name: "npo_reason"
      expr: npo_reason
      comment: "Reason for NPO status if applicable"
    - name: "feeding_route"
      expr: feeding_route
      comment: "Route of feeding (oral, enteral, parenteral, etc.)"
    - name: "texture_modification"
      expr: texture_modification
      comment: "Texture modification for dysphagia management (pureed, mechanical soft, etc.)"
    - name: "fluid_consistency"
      expr: fluid_consistency
      comment: "Fluid consistency modification (thin, nectar, honey, pudding)"
    - name: "meal_schedule"
      expr: meal_schedule
      comment: "Meal schedule for the patient"
    - name: "supplement_name"
      expr: supplement_name
      comment: "Name of nutritional supplement if ordered"
  measures:
    - name: "total_diet_orders"
      expr: COUNT(diet_order_id)
      comment: "Total number of diet orders placed"
    - name: "unique_patients_with_diet_orders"
      expr: COUNT(DISTINCT demographics_id)
      comment: "Distinct count of patients with diet orders"
    - name: "npo_orders"
      expr: COUNT(CASE WHEN npo_status = TRUE THEN diet_order_id END)
      comment: "Count of NPO (nothing by mouth) orders"
    - name: "npo_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN npo_status = TRUE THEN diet_order_id END) / NULLIF(COUNT(diet_order_id), 0), 2)
      comment: "Percentage of diet orders with NPO status (clinical indicator)"
    - name: "orders_with_texture_modification"
      expr: COUNT(CASE WHEN texture_modification IS NOT NULL THEN diet_order_id END)
      comment: "Count of diet orders with texture modifications for dysphagia"
    - name: "texture_modification_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN texture_modification IS NOT NULL THEN diet_order_id END) / NULLIF(COUNT(diet_order_id), 0), 2)
      comment: "Percentage of diet orders with texture modifications (dysphagia prevalence indicator)"
    - name: "orders_with_fluid_restriction"
      expr: COUNT(CASE WHEN fluid_restriction_ml IS NOT NULL THEN diet_order_id END)
      comment: "Count of diet orders with fluid restrictions"
    - name: "fluid_restriction_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN fluid_restriction_ml IS NOT NULL THEN diet_order_id END) / NULLIF(COUNT(diet_order_id), 0), 2)
      comment: "Percentage of diet orders with fluid restrictions (renal/cardiac care indicator)"
    - name: "avg_fluid_restriction_ml"
      expr: AVG(CAST(fluid_restriction_ml AS DOUBLE))
      comment: "Average fluid restriction in milliliters when restricted"
    - name: "orders_with_protein_target"
      expr: COUNT(CASE WHEN protein_target_grams IS NOT NULL THEN diet_order_id END)
      comment: "Count of diet orders with specific protein targets"
    - name: "avg_protein_target_grams"
      expr: AVG(CAST(protein_target_grams AS DOUBLE))
      comment: "Average protein target in grams for orders with protein goals"
    - name: "orders_with_supplements"
      expr: COUNT(CASE WHEN supplement_name IS NOT NULL THEN diet_order_id END)
      comment: "Count of diet orders including nutritional supplements"
    - name: "supplement_utilization_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN supplement_name IS NOT NULL THEN diet_order_id END) / NULLIF(COUNT(diet_order_id), 0), 2)
      comment: "Percentage of diet orders with nutritional supplements (malnutrition intervention metric)"
    - name: "orders_with_allergen_exclusions"
      expr: COUNT(CASE WHEN allergen_exclusions IS NOT NULL THEN diet_order_id END)
      comment: "Count of diet orders with allergen exclusions documented"
    - name: "allergen_exclusion_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN allergen_exclusions IS NOT NULL THEN diet_order_id END) / NULLIF(COUNT(diet_order_id), 0), 2)
      comment: "Percentage of diet orders with allergen exclusions (patient safety metric)"
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`order_set`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Order set metrics tracking standardization, utilization, version control, and clinical protocol adoption across care settings and specialties."
  source: "`vibe_healthcare_v1`.`order`.`set`"
  dimensions:
    - name: "set_type"
      expr: set_type
      comment: "Type of order set (admission, procedure, protocol, pathway, etc.)"
    - name: "set_status"
      expr: set_status
      comment: "Current status of the order set (active, retired, draft, etc.)"
    - name: "care_setting"
      expr: care_setting
      comment: "Care setting where order set is applicable (inpatient, outpatient, ED, etc.)"
    - name: "clinical_domain"
      expr: clinical_domain
      comment: "Clinical domain of the order set (cardiology, oncology, surgery, etc.)"
    - name: "clinical_indication"
      expr: clinical_indication
      comment: "Clinical indication or condition the order set addresses"
    - name: "is_default"
      expr: is_default
      comment: "Boolean indicating if this is a default order set for its indication"
    - name: "requires_cosign"
      expr: requires_cosign
      comment: "Boolean indicating if order set requires co-signature"
    - name: "default_priority"
      expr: default_priority
      comment: "Default priority level for orders in this set"
    - name: "evidence_source"
      expr: evidence_source
      comment: "Source of evidence supporting the order set (guideline, protocol, etc.)"
  measures:
    - name: "total_order_sets"
      expr: COUNT(set_id)
      comment: "Total number of order sets in the catalog"
    - name: "active_order_sets"
      expr: COUNT(CASE WHEN set_status = 'active' THEN set_id END)
      comment: "Count of active order sets available for use"
    - name: "order_sets_requiring_cosign"
      expr: COUNT(CASE WHEN requires_cosign = TRUE THEN set_id END)
      comment: "Count of order sets requiring co-signature"
    - name: "cosign_requirement_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN requires_cosign = TRUE THEN set_id END) / NULLIF(COUNT(set_id), 0), 2)
      comment: "Percentage of order sets requiring co-signature (supervision and training indicator)"
    - name: "evidence_based_order_sets"
      expr: COUNT(CASE WHEN evidence_source IS NOT NULL THEN set_id END)
      comment: "Count of order sets with documented evidence base"
    - name: "evidence_based_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN evidence_source IS NOT NULL THEN set_id END) / NULLIF(COUNT(set_id), 0), 2)
      comment: "Percentage of order sets with evidence-based documentation (quality metric)"
    - name: "order_sets_past_review_date"
      expr: COUNT(CASE WHEN next_review_date < CURRENT_DATE THEN set_id END)
      comment: "Count of order sets past their scheduled review date"
    - name: "overdue_review_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN next_review_date < CURRENT_DATE THEN set_id END) / NULLIF(COUNT(set_id), 0), 2)
      comment: "Percentage of order sets overdue for review (governance and currency metric)"
    - name: "avg_days_since_last_review"
      expr: AVG(CAST(DATEDIFF(CURRENT_DATE, last_review_date) AS DOUBLE))
      comment: "Average days since last review of order sets (currency indicator)"
$$;