-- Metric views for domain: order | Business: Healthcare | Version: 2 | Generated on: 2026-07-10 16:17:39

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`order_clinical_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core clinical order metrics tracking order volume, completion rates, CPOE adoption, and order lifecycle performance across order types, statuses, and clinical contexts."
  source: "`vibe_healthcare_v1`.`order`.`clinical_order`"
  dimensions:
    - name: "order_type"
      expr: order_type
      comment: "Type of clinical order (lab, radiology, medication, procedure, etc.)"
    - name: "order_status"
      expr: order_status
      comment: "Current status of the order (ordered, in-progress, completed, cancelled, discontinued)"
    - name: "order_priority"
      expr: order_priority
      comment: "Priority level of the order (STAT, urgent, routine)"
    - name: "order_class"
      expr: order_class
      comment: "Classification of the order (inpatient, outpatient, emergency)"
    - name: "order_mode"
      expr: order_mode
      comment: "Mode of order entry (electronic, verbal, telephone, written)"
    - name: "is_cpoe_entered"
      expr: is_cpoe_entered
      comment: "Whether order was entered via computerized provider order entry system"
    - name: "is_order_set_member"
      expr: is_order_set_member
      comment: "Whether order is part of a standardized order set"
    - name: "is_recurring"
      expr: is_recurring
      comment: "Whether order is recurring or one-time"
    - name: "is_verbal_order"
      expr: is_verbal_order
      comment: "Whether order was placed verbally and requires authentication"
    - name: "order_year"
      expr: YEAR(order_datetime)
      comment: "Year the order was placed"
    - name: "order_month"
      expr: DATE_TRUNC('MONTH', order_datetime)
      comment: "Month the order was placed"
    - name: "order_date"
      expr: DATE(order_datetime)
      comment: "Date the order was placed"
    - name: "cancellation_reason"
      expr: cancellation_reason
      comment: "Reason for order cancellation if applicable"
  measures:
    - name: "total_orders"
      expr: COUNT(clinical_order_id)
      comment: "Total number of clinical orders placed"
    - name: "total_order_quantity"
      expr: SUM(CAST(quantity_ordered AS DOUBLE))
      comment: "Total quantity ordered across all orders"
    - name: "avg_order_quantity"
      expr: AVG(CAST(quantity_ordered AS DOUBLE))
      comment: "Average quantity per order"
    - name: "completed_orders"
      expr: COUNT(CASE WHEN completed_datetime IS NOT NULL THEN clinical_order_id END)
      comment: "Number of orders that have been completed"
    - name: "cancelled_orders"
      expr: COUNT(CASE WHEN cancelled_datetime IS NOT NULL THEN clinical_order_id END)
      comment: "Number of orders that were cancelled"
    - name: "cpoe_orders"
      expr: COUNT(CASE WHEN is_cpoe_entered = TRUE THEN clinical_order_id END)
      comment: "Number of orders entered via CPOE system"
    - name: "verbal_orders"
      expr: COUNT(CASE WHEN is_verbal_order = TRUE THEN clinical_order_id END)
      comment: "Number of verbal orders requiring authentication"
    - name: "order_set_orders"
      expr: COUNT(CASE WHEN is_order_set_member = TRUE THEN clinical_order_id END)
      comment: "Number of orders placed as part of standardized order sets"
    - name: "stat_orders"
      expr: COUNT(CASE WHEN order_priority = 'STAT' THEN clinical_order_id END)
      comment: "Number of STAT priority orders requiring immediate action"
    - name: "recurring_orders"
      expr: COUNT(CASE WHEN is_recurring = TRUE THEN clinical_order_id END)
      comment: "Number of recurring orders"
    - name: "unique_patients"
      expr: COUNT(DISTINCT mpi_record_id)
      comment: "Number of unique patients with orders"
    - name: "unique_ordering_providers"
      expr: COUNT(DISTINCT clinician_id)
      comment: "Number of unique providers placing orders"
$$;


CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`order_fulfillment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Order fulfillment metrics tracking completion rates, turnaround times, charge capture, quality, and operational efficiency of order execution."
  source: "`vibe_healthcare_v1`.`order`.`fulfillment`"
  dimensions:
    - name: "fulfillment_status"
      expr: fulfillment_status
      comment: "Status of order fulfillment (completed, in-progress, pending, cancelled)"
    - name: "order_type"
      expr: order_type
      comment: "Type of order being fulfilled"
    - name: "method"
      expr: method
      comment: "Method used to fulfill the order"
    - name: "priority_code"
      expr: priority_code
      comment: "Priority level of the fulfillment"
    - name: "charge_capture_flag"
      expr: charge_capture_flag
      comment: "Whether charges were successfully captured for billing"
    - name: "partial_fulfillment_flag"
      expr: partial_fulfillment_flag
      comment: "Whether order was partially fulfilled"
    - name: "quality_flag"
      expr: quality_flag
      comment: "Quality indicator flag for fulfillment"
    - name: "performing_department_code"
      expr: performing_department_code
      comment: "Department code that performed the fulfillment"
    - name: "fulfillment_year"
      expr: YEAR(datetime)
      comment: "Year the fulfillment occurred"
    - name: "fulfillment_month"
      expr: DATE_TRUNC('MONTH', datetime)
      comment: "Month the fulfillment occurred"
    - name: "fulfillment_date"
      expr: DATE(datetime)
      comment: "Date the fulfillment occurred"
    - name: "exception_reason_code"
      expr: exception_reason_code
      comment: "Code for fulfillment exception if applicable"
  measures:
    - name: "total_fulfillments"
      expr: COUNT(fulfillment_id)
      comment: "Total number of order fulfillments"
    - name: "total_charge_amount"
      expr: SUM(CAST(charge_amount AS DOUBLE))
      comment: "Total charge amount captured from fulfillments"
    - name: "avg_charge_amount"
      expr: AVG(CAST(charge_amount AS DOUBLE))
      comment: "Average charge amount per fulfillment"
    - name: "total_fulfilled_quantity"
      expr: SUM(CAST(fulfilled_quantity AS DOUBLE))
      comment: "Total quantity fulfilled across all orders"
    - name: "total_ordered_quantity"
      expr: SUM(CAST(ordered_quantity AS DOUBLE))
      comment: "Total quantity originally ordered"
    - name: "avg_fulfilled_quantity"
      expr: AVG(CAST(fulfilled_quantity AS DOUBLE))
      comment: "Average quantity fulfilled per order"
    - name: "completed_fulfillments"
      expr: COUNT(CASE WHEN fulfillment_status = 'completed' THEN fulfillment_id END)
      comment: "Number of completed fulfillments"
    - name: "partial_fulfillments"
      expr: COUNT(CASE WHEN partial_fulfillment_flag = TRUE THEN fulfillment_id END)
      comment: "Number of partial fulfillments"
    - name: "charge_captured_fulfillments"
      expr: COUNT(CASE WHEN charge_capture_flag = TRUE THEN fulfillment_id END)
      comment: "Number of fulfillments with successful charge capture"
    - name: "quality_flagged_fulfillments"
      expr: COUNT(CASE WHEN quality_flag = TRUE THEN fulfillment_id END)
      comment: "Number of fulfillments flagged for quality review"
    - name: "fulfillments_with_exceptions"
      expr: COUNT(CASE WHEN exception_reason_code IS NOT NULL THEN fulfillment_id END)
      comment: "Number of fulfillments with documented exceptions"
    - name: "unique_orders_fulfilled"
      expr: COUNT(DISTINCT clinical_order_id)
      comment: "Number of unique orders fulfilled"
    - name: "unique_patients_served"
      expr: COUNT(DISTINCT demographics_id)
      comment: "Number of unique patients served through fulfillments"
    - name: "unique_performing_providers"
      expr: COUNT(DISTINCT org_provider_id)
      comment: "Number of unique provider organizations performing fulfillments"
$$;


CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`order_referral_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Referral order metrics tracking referral volume, authorization rates, loop closure, disposition outcomes, and care coordination effectiveness."
  source: "`vibe_healthcare_v1`.`order`.`referral_order`"
  dimensions:
    - name: "order_status"
      expr: order_status
      comment: "Current status of the referral order"
    - name: "referral_type"
      expr: referral_type
      comment: "Type of referral (specialist, diagnostic, therapeutic, etc.)"
    - name: "referral_source"
      expr: referral_source
      comment: "Source of the referral"
    - name: "referral_disposition"
      expr: referral_disposition
      comment: "Disposition outcome of the referral"
    - name: "urgency_level"
      expr: urgency_level
      comment: "Urgency level of the referral"
    - name: "authorization_required"
      expr: authorization_required
      comment: "Whether insurance authorization is required"
    - name: "is_stat_order"
      expr: is_stat_order
      comment: "Whether referral is STAT priority"
    - name: "referral_loop_closed"
      expr: referral_loop_closed
      comment: "Whether referral loop has been closed with feedback to referring provider"
    - name: "plan_type"
      expr: plan_type
      comment: "Insurance plan type for the referral"
    - name: "order_year"
      expr: YEAR(order_placed_timestamp)
      comment: "Year the referral order was placed"
    - name: "order_month"
      expr: DATE_TRUNC('MONTH', order_placed_timestamp)
      comment: "Month the referral order was placed"
    - name: "effective_year"
      expr: YEAR(effective_date)
      comment: "Year the referral becomes effective"
    - name: "cancellation_reason"
      expr: cancellation_reason
      comment: "Reason for referral cancellation if applicable"
  measures:
    - name: "total_referrals"
      expr: COUNT(referral_order_id)
      comment: "Total number of referral orders placed"
    - name: "referrals_requiring_authorization"
      expr: COUNT(CASE WHEN authorization_required = TRUE THEN referral_order_id END)
      comment: "Number of referrals requiring insurance authorization"
    - name: "stat_referrals"
      expr: COUNT(CASE WHEN is_stat_order = TRUE THEN referral_order_id END)
      comment: "Number of STAT priority referrals"
    - name: "closed_loop_referrals"
      expr: COUNT(CASE WHEN referral_loop_closed = TRUE THEN referral_order_id END)
      comment: "Number of referrals with closed communication loop"
    - name: "cancelled_referrals"
      expr: COUNT(CASE WHEN cancellation_reason IS NOT NULL THEN referral_order_id END)
      comment: "Number of cancelled referrals"
    - name: "referrals_with_disposition"
      expr: COUNT(CASE WHEN referral_disposition IS NOT NULL THEN referral_order_id END)
      comment: "Number of referrals with documented disposition outcome"
    - name: "scheduled_referrals"
      expr: COUNT(CASE WHEN scheduled_appointment_date IS NOT NULL THEN referral_order_id END)
      comment: "Number of referrals with scheduled appointments"
    - name: "unique_patients_referred"
      expr: COUNT(DISTINCT mpi_record_id)
      comment: "Number of unique patients with referral orders"
    - name: "unique_referring_providers"
      expr: COUNT(DISTINCT clinician_id)
      comment: "Number of unique providers placing referrals"
    - name: "unique_receiving_providers"
      expr: COUNT(DISTINCT receiving_provider_clinician_id)
      comment: "Number of unique providers receiving referrals"
    - name: "unique_receiving_organizations"
      expr: COUNT(DISTINCT org_provider_id)
      comment: "Number of unique organizations receiving referrals"
$$;


CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`order_set`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Order set metrics tracking standardized order set adoption, compliance rates, evidence-based guideline usage, and clinical protocol effectiveness."
  source: "`vibe_healthcare_v1`.`order`.`set`"
  dimensions:
    - name: "order_set_type"
      expr: order_set_type
      comment: "Type of order set (admission, discharge, protocol, pathway)"
    - name: "care_setting"
      expr: care_setting
      comment: "Care setting where order set is used (inpatient, outpatient, ED, ICU)"
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the order set"
    - name: "is_active"
      expr: is_active
      comment: "Whether order set is currently active"
    - name: "governance_level"
      expr: governance_level
      comment: "Governance level of the order set (institutional, departmental, specialty)"
    - name: "evidence_level"
      expr: evidence_level
      comment: "Level of evidence supporting the order set"
    - name: "is_cms_core_measure"
      expr: is_cms_core_measure
      comment: "Whether order set supports CMS core measure compliance"
    - name: "includes_lab_orders"
      expr: includes_lab_orders
      comment: "Whether order set includes laboratory orders"
    - name: "includes_pharmacy_orders"
      expr: includes_pharmacy_orders
      comment: "Whether order set includes pharmacy orders"
    - name: "includes_radiology_orders"
      expr: includes_radiology_orders
      comment: "Whether order set includes radiology orders"
    - name: "population_age_group"
      expr: population_age_group
      comment: "Target age group for the order set"
    - name: "approval_year"
      expr: YEAR(approval_date)
      comment: "Year the order set was approved"
    - name: "effective_year"
      expr: YEAR(effective_date)
      comment: "Year the order set became effective"
  measures:
    - name: "total_order_sets"
      expr: COUNT(set_id)
      comment: "Total number of order sets"
    - name: "active_order_sets"
      expr: COUNT(CASE WHEN is_active = TRUE THEN set_id END)
      comment: "Number of active order sets available for use"
    - name: "cms_core_measure_sets"
      expr: COUNT(CASE WHEN is_cms_core_measure = TRUE THEN set_id END)
      comment: "Number of order sets supporting CMS core measures"
    - name: "evidence_based_sets"
      expr: COUNT(CASE WHEN evidence_level IS NOT NULL THEN set_id END)
      comment: "Number of order sets with documented evidence level"
    - name: "avg_compliance_rate"
      expr: AVG(CAST(compliance_rate_pct AS DOUBLE))
      comment: "Average compliance rate percentage across order sets"
    - name: "sets_with_lab_orders"
      expr: COUNT(CASE WHEN includes_lab_orders = TRUE THEN set_id END)
      comment: "Number of order sets including laboratory orders"
    - name: "sets_with_pharmacy_orders"
      expr: COUNT(CASE WHEN includes_pharmacy_orders = TRUE THEN set_id END)
      comment: "Number of order sets including pharmacy orders"
    - name: "sets_with_radiology_orders"
      expr: COUNT(CASE WHEN includes_radiology_orders = TRUE THEN set_id END)
      comment: "Number of order sets including radiology orders"
    - name: "unique_specialties"
      expr: COUNT(DISTINCT specialty_id)
      comment: "Number of unique specialties with order sets"
    - name: "unique_organizations"
      expr: COUNT(DISTINCT org_provider_id)
      comment: "Number of unique organizations with order sets"
$$;


CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`order_standing_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Standing order metrics tracking protocol-based order authorization, usage patterns, renewal compliance, and evidence-based guideline adherence."
  source: "`vibe_healthcare_v1`.`order`.`standing_order`"
  dimensions:
    - name: "order_type"
      expr: order_type
      comment: "Type of standing order (medication, lab, imaging, procedure)"
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the standing order"
    - name: "priority"
      expr: priority
      comment: "Priority level of the standing order"
    - name: "notification_required_flag"
      expr: notification_required_flag
      comment: "Whether notification is required when standing order is used"
    - name: "renewal_required_flag"
      expr: renewal_required_flag
      comment: "Whether periodic renewal is required"
    - name: "imaging_modality"
      expr: imaging_modality
      comment: "Imaging modality for imaging standing orders"
    - name: "medication_route"
      expr: medication_route
      comment: "Route of administration for medication standing orders"
    - name: "authorized_role"
      expr: authorized_role
      comment: "Role authorized to execute the standing order"
    - name: "approval_year"
      expr: YEAR(approval_date)
      comment: "Year the standing order was approved"
    - name: "effective_start_year"
      expr: YEAR(effective_start_date)
      comment: "Year the standing order became effective"
  measures:
    - name: "total_standing_orders"
      expr: COUNT(standing_order_id)
      comment: "Total number of standing orders"
    - name: "approved_standing_orders"
      expr: COUNT(CASE WHEN approval_status = 'approved' THEN standing_order_id END)
      comment: "Number of approved standing orders"
    - name: "standing_orders_requiring_notification"
      expr: COUNT(CASE WHEN notification_required_flag = TRUE THEN standing_order_id END)
      comment: "Number of standing orders requiring notification when used"
    - name: "standing_orders_requiring_renewal"
      expr: COUNT(CASE WHEN renewal_required_flag = TRUE THEN standing_order_id END)
      comment: "Number of standing orders requiring periodic renewal"
    - name: "evidence_based_standing_orders"
      expr: COUNT(CASE WHEN evidence_based_guideline_reference IS NOT NULL THEN standing_order_id END)
      comment: "Number of standing orders with documented evidence-based guideline reference"
    - name: "unique_specialties"
      expr: COUNT(DISTINCT specialty_id)
      comment: "Number of unique specialties with standing orders"
    - name: "unique_organizations"
      expr: COUNT(DISTINCT org_provider_id)
      comment: "Number of unique organizations with standing orders"
    - name: "unique_clinicians"
      expr: COUNT(DISTINCT clinician_id)
      comment: "Number of unique clinicians associated with standing orders"
$$;


CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`order_therapy_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Therapy order metrics tracking therapy service utilization, session completion rates, authorization compliance, and treatment goal achievement."
  source: "`vibe_healthcare_v1`.`order`.`therapy_order`"
  dimensions:
    - name: "therapy_type"
      expr: therapy_type
      comment: "Type of therapy (physical, occupational, speech, respiratory, etc.)"
    - name: "order_status"
      expr: order_status
      comment: "Current status of the therapy order"
    - name: "priority"
      expr: priority
      comment: "Priority level of the therapy order"
    - name: "order_mode"
      expr: order_mode
      comment: "Mode of order entry"
    - name: "authorization_required_flag"
      expr: authorization_required_flag
      comment: "Whether insurance authorization is required"
    - name: "is_recurring"
      expr: is_recurring
      comment: "Whether therapy order is recurring"
    - name: "body_site"
      expr: body_site
      comment: "Body site targeted by therapy"
    - name: "laterality"
      expr: laterality
      comment: "Laterality of therapy (left, right, bilateral)"
    - name: "frequency_code"
      expr: frequency_code
      comment: "Frequency code for therapy sessions"
    - name: "duration_unit"
      expr: duration_unit
      comment: "Unit of duration for therapy sessions"
    - name: "order_year"
      expr: YEAR(order_datetime)
      comment: "Year the therapy order was placed"
    - name: "order_month"
      expr: DATE_TRUNC('MONTH', order_datetime)
      comment: "Month the therapy order was placed"
    - name: "cancellation_reason"
      expr: cancellation_reason
      comment: "Reason for therapy order cancellation if applicable"
  measures:
    - name: "total_therapy_orders"
      expr: COUNT(therapy_order_id)
      comment: "Total number of therapy orders placed"
    - name: "completed_therapy_orders"
      expr: COUNT(CASE WHEN completed_datetime IS NOT NULL THEN therapy_order_id END)
      comment: "Number of completed therapy orders"
    - name: "cancelled_therapy_orders"
      expr: COUNT(CASE WHEN cancelled_datetime IS NOT NULL THEN therapy_order_id END)
      comment: "Number of cancelled therapy orders"
    - name: "recurring_therapy_orders"
      expr: COUNT(CASE WHEN is_recurring = TRUE THEN therapy_order_id END)
      comment: "Number of recurring therapy orders"
    - name: "therapy_orders_requiring_authorization"
      expr: COUNT(CASE WHEN authorization_required_flag = TRUE THEN therapy_order_id END)
      comment: "Number of therapy orders requiring insurance authorization"
    - name: "unique_patients_with_therapy"
      expr: COUNT(DISTINCT mpi_record_id)
      comment: "Number of unique patients with therapy orders"
    - name: "unique_therapy_providers"
      expr: COUNT(DISTINCT clinician_id)
      comment: "Number of unique therapy providers"
    - name: "unique_performing_organizations"
      expr: COUNT(DISTINCT org_provider_id)
      comment: "Number of unique organizations performing therapy services"
$$;


CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`order_diet_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Diet order metrics tracking nutritional intervention volume, NPO compliance, dietary restriction adherence, and clinical nutrition service utilization."
  source: "`vibe_healthcare_v1`.`order`.`diet_order`"
  dimensions:
    - name: "diet_type"
      expr: diet_type
      comment: "Type of diet ordered (regular, cardiac, diabetic, renal, etc.)"
    - name: "diet_type_code"
      expr: diet_type_code
      comment: "Standardized code for diet type"
    - name: "feeding_route"
      expr: feeding_route
      comment: "Route of feeding (oral, enteral, parenteral)"
    - name: "npo_status"
      expr: npo_status
      comment: "Whether patient is NPO (nothing by mouth)"
    - name: "npo_reason"
      expr: npo_reason
      comment: "Reason for NPO status if applicable"
    - name: "texture_modification"
      expr: texture_modification
      comment: "Texture modification for diet (pureed, mechanical soft, etc.)"
    - name: "fluid_consistency"
      expr: fluid_consistency
      comment: "Consistency of fluids (thin, nectar, honey, pudding)"
    - name: "meal_schedule"
      expr: meal_schedule
      comment: "Meal schedule for the patient"
    - name: "supplement_name"
      expr: supplement_name
      comment: "Name of nutritional supplement if ordered"
    - name: "order_year"
      expr: YEAR(created_timestamp)
      comment: "Year the diet order was created"
    - name: "order_month"
      expr: DATE_TRUNC('MONTH', created_timestamp)
      comment: "Month the diet order was created"
  measures:
    - name: "total_diet_orders"
      expr: COUNT(diet_order_id)
      comment: "Total number of diet orders placed"
    - name: "npo_orders"
      expr: COUNT(CASE WHEN npo_status = TRUE THEN diet_order_id END)
      comment: "Number of NPO (nothing by mouth) orders"
    - name: "orders_with_texture_modification"
      expr: COUNT(CASE WHEN texture_modification IS NOT NULL THEN diet_order_id END)
      comment: "Number of diet orders with texture modifications"
    - name: "orders_with_fluid_restriction"
      expr: COUNT(CASE WHEN fluid_restriction_ml IS NOT NULL THEN diet_order_id END)
      comment: "Number of diet orders with fluid restrictions"
    - name: "avg_fluid_restriction_ml"
      expr: AVG(CAST(fluid_restriction_ml AS DOUBLE))
      comment: "Average fluid restriction in milliliters"
    - name: "total_fluid_restriction_ml"
      expr: SUM(CAST(fluid_restriction_ml AS DOUBLE))
      comment: "Total fluid restriction volume in milliliters"
    - name: "avg_protein_target_grams"
      expr: AVG(CAST(protein_target_grams AS DOUBLE))
      comment: "Average protein target in grams"
    - name: "orders_with_supplements"
      expr: COUNT(CASE WHEN supplement_name IS NOT NULL THEN diet_order_id END)
      comment: "Number of diet orders including nutritional supplements"
    - name: "orders_with_allergen_exclusions"
      expr: COUNT(CASE WHEN allergen_exclusions IS NOT NULL THEN diet_order_id END)
      comment: "Number of diet orders with documented allergen exclusions"
    - name: "unique_patients_with_diet_orders"
      expr: COUNT(DISTINCT demographics_id)
      comment: "Number of unique patients with diet orders"
    - name: "unique_diet_providers"
      expr: COUNT(DISTINCT clinician_id)
      comment: "Number of unique providers placing diet orders"
$$;
