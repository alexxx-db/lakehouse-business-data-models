-- Metric views for domain: aftersales | Business: Automotive | Version: 2 | Generated on: 2026-07-14 01:46:32

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`aftersales_repair_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core aftersales service repair order KPIs tracking revenue, labor efficiency, warranty coverage, and customer satisfaction across service centers and technicians"
  source: "`vibe_automotive_v1`.`aftersales`.`aftersales_repair_order`"
  dimensions:
    - name: "service_type"
      expr: service_type
      comment: "Type of service performed (maintenance, repair, recall, warranty, etc.)"
    - name: "service_priority"
      expr: service_priority
      comment: "Priority level of the repair order (urgent, standard, low)"
    - name: "repair_order_status"
      expr: aftersales_repair_order_status
      comment: "Current status of the repair order (open, in-progress, completed, closed)"
    - name: "warranty_flag"
      expr: warranty_flag
      comment: "Whether the repair is covered under warranty"
    - name: "warranty_type"
      expr: warranty_type
      comment: "Type of warranty coverage (manufacturer, extended, powertrain, etc.)"
    - name: "payment_status"
      expr: payment_status
      comment: "Payment status of the repair order (paid, pending, disputed)"
    - name: "service_center_region"
      expr: service_center_region
      comment: "Geographic region of the service center"
    - name: "open_month"
      expr: DATE_TRUNC('MONTH', open_timestamp)
      comment: "Month when the repair order was opened"
    - name: "close_month"
      expr: DATE_TRUNC('MONTH', close_timestamp)
      comment: "Month when the repair order was closed"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency code for financial amounts"
  measures:
    - name: "total_repair_orders"
      expr: COUNT(1)
      comment: "Total number of repair orders"
    - name: "total_revenue"
      expr: SUM(CAST(total_amount AS DOUBLE))
      comment: "Total revenue from all repair orders including parts, labor, and tax"
    - name: "total_labor_revenue"
      expr: SUM(CAST(labor_total_cost AS DOUBLE))
      comment: "Total revenue from labor charges"
    - name: "total_parts_revenue"
      expr: SUM(CAST(parts_total_cost AS DOUBLE))
      comment: "Total revenue from parts sales"
    - name: "total_labor_hours"
      expr: SUM(CAST(labor_total_hours AS DOUBLE))
      comment: "Total labor hours billed across all repair orders"
    - name: "avg_labor_hours_per_ro"
      expr: AVG(CAST(labor_total_hours AS DOUBLE))
      comment: "Average labor hours per repair order"
    - name: "avg_revenue_per_ro"
      expr: AVG(CAST(total_amount AS DOUBLE))
      comment: "Average revenue per repair order (average ticket value)"
    - name: "avg_labor_rate"
      expr: AVG(CAST(labor_rate_per_hour AS DOUBLE))
      comment: "Average labor rate per hour charged across repair orders"
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discounts applied to repair orders"
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax collected on repair orders"
    - name: "warranty_ro_count"
      expr: SUM(CAST(CASE WHEN warranty_flag = TRUE THEN 1 ELSE 0 END AS INT))
      comment: "Count of repair orders covered under warranty"
    - name: "customer_pay_ro_count"
      expr: SUM(CAST(CASE WHEN warranty_flag = FALSE THEN 1 ELSE 0 END AS INT))
      comment: "Count of customer-pay (non-warranty) repair orders"
    - name: "distinct_vins_serviced"
      expr: COUNT(DISTINCT vin_registry_id)
      comment: "Number of unique vehicles serviced"
    - name: "distinct_customers"
      expr: COUNT(DISTINCT party_id)
      comment: "Number of unique customers served"
    - name: "distinct_service_centers"
      expr: COUNT(DISTINCT service_center_id)
      comment: "Number of unique service centers processing repair orders"
    - name: "distinct_technicians"
      expr: COUNT(DISTINCT technician_id)
      comment: "Number of unique technicians working on repair orders"
$$;


CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`aftersales_warranty_claim`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Warranty claim financial and operational KPIs tracking claim amounts, approval rates, labor/parts costs, and claim cycle times for warranty cost management"
  source: "`vibe_automotive_v1`.`aftersales`.`aftersales_warranty_claim`"
  dimensions:
    - name: "claim_status"
      expr: claim_status
      comment: "Current status of the warranty claim (submitted, approved, rejected, paid)"
    - name: "claim_category"
      expr: claim_category
      comment: "Category of warranty claim (powertrain, electrical, body, etc.)"
    - name: "warranty_type"
      expr: warranty_type
      comment: "Type of warranty (new vehicle, powertrain, extended, certified pre-owned)"
    - name: "goodwill_flag"
      expr: goodwill_flag
      comment: "Whether the claim is a goodwill adjustment outside warranty terms"
    - name: "claim_adjusted_flag"
      expr: claim_adjusted_flag
      comment: "Whether the claim amount was adjusted from original submission"
    - name: "rejection_reason_code"
      expr: rejection_reason_code
      comment: "Code indicating reason for claim rejection"
    - name: "adjudication_outcome"
      expr: adjudication_outcome
      comment: "Final outcome of claim adjudication process"
    - name: "submission_month"
      expr: DATE_TRUNC('MONTH', claim_submission_timestamp)
      comment: "Month when the warranty claim was submitted"
    - name: "failure_month"
      expr: DATE_TRUNC('MONTH', failure_date)
      comment: "Month when the failure occurred"
    - name: "repair_month"
      expr: DATE_TRUNC('MONTH', repair_date)
      comment: "Month when the repair was performed"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency code for claim amounts"
  measures:
    - name: "total_warranty_claims"
      expr: COUNT(1)
      comment: "Total number of warranty claims submitted"
    - name: "total_claim_amount"
      expr: SUM(CAST(total_claim_amount AS DOUBLE))
      comment: "Total amount claimed across all warranty claims"
    - name: "total_approved_labor_cost"
      expr: SUM(CAST(approved_labor_cost AS DOUBLE))
      comment: "Total approved labor cost for warranty claims"
    - name: "total_approved_parts_cost"
      expr: SUM(CAST(approved_parts_cost AS DOUBLE))
      comment: "Total approved parts cost for warranty claims"
    - name: "total_adjusted_amount"
      expr: SUM(CAST(adjusted_amount AS DOUBLE))
      comment: "Total adjusted claim amount after adjudication"
    - name: "total_approved_labor_hours"
      expr: SUM(CAST(approved_labor_hours AS DOUBLE))
      comment: "Total approved labor hours for warranty work"
    - name: "avg_claim_amount"
      expr: AVG(CAST(total_claim_amount AS DOUBLE))
      comment: "Average warranty claim amount"
    - name: "avg_approved_labor_cost"
      expr: AVG(CAST(approved_labor_cost AS DOUBLE))
      comment: "Average approved labor cost per claim"
    - name: "avg_approved_parts_cost"
      expr: AVG(CAST(approved_parts_cost AS DOUBLE))
      comment: "Average approved parts cost per claim"
    - name: "avg_labor_rate"
      expr: AVG(CAST(labor_rate_per_hour AS DOUBLE))
      comment: "Average labor rate per hour for warranty claims"
    - name: "approved_claims_count"
      expr: SUM(CAST(CASE WHEN claim_status = 'approved' THEN 1 ELSE 0 END AS INT))
      comment: "Count of approved warranty claims"
    - name: "rejected_claims_count"
      expr: SUM(CAST(CASE WHEN claim_status = 'rejected' THEN 1 ELSE 0 END AS INT))
      comment: "Count of rejected warranty claims"
    - name: "adjusted_claims_count"
      expr: SUM(CAST(CASE WHEN claim_adjusted_flag = TRUE THEN 1 ELSE 0 END AS INT))
      comment: "Count of claims that were adjusted from original submission"
    - name: "goodwill_claims_count"
      expr: SUM(CAST(CASE WHEN goodwill_flag = TRUE THEN 1 ELSE 0 END AS INT))
      comment: "Count of goodwill claims outside warranty terms"
    - name: "distinct_vins_claimed"
      expr: COUNT(DISTINCT vin_registry_id)
      comment: "Number of unique vehicles with warranty claims"
    - name: "distinct_service_centers"
      expr: COUNT(DISTINCT service_center_id)
      comment: "Number of unique service centers submitting warranty claims"
    - name: "distinct_customers"
      expr: COUNT(DISTINCT party_id)
      comment: "Number of unique customers with warranty claims"
$$;


CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`aftersales_service_campaign`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Service campaign and recall program KPIs tracking campaign costs, affected vehicle populations, completion rates, and regulatory compliance for recall management"
  source: "`vibe_automotive_v1`.`aftersales`.`service_campaign`"
  dimensions:
    - name: "campaign_status"
      expr: campaign_status
      comment: "Current status of the service campaign (active, completed, suspended)"
    - name: "campaign_type"
      expr: campaign_type
      comment: "Type of campaign (safety recall, service action, technical service bulletin)"
    - name: "campaign_priority"
      expr: campaign_priority
      comment: "Priority level of the campaign (critical, high, medium, low)"
    - name: "safety_recall_flag"
      expr: safety_recall_flag
      comment: "Whether the campaign is a safety recall"
    - name: "emissions_recall_flag"
      expr: emissions_recall_flag
      comment: "Whether the campaign is an emissions-related recall"
    - name: "technical_service_bulletin_flag"
      expr: technical_service_bulletin_flag
      comment: "Whether the campaign is a technical service bulletin"
    - name: "nhtsa_compliance_flag"
      expr: nhtsa_compliance_flag
      comment: "Whether the campaign requires NHTSA compliance reporting"
    - name: "unece_compliance_flag"
      expr: unece_compliance_flag
      comment: "Whether the campaign requires UNECE compliance reporting"
    - name: "warranty_impact_flag"
      expr: warranty_impact_flag
      comment: "Whether the campaign impacts warranty coverage"
    - name: "customer_satisfaction_flag"
      expr: customer_satisfaction_flag
      comment: "Whether the campaign is driven by customer satisfaction concerns"
    - name: "compliance_status"
      expr: compliance_status
      comment: "Regulatory compliance status of the campaign"
    - name: "regulatory_reporting_status"
      expr: regulatory_reporting_status
      comment: "Status of regulatory reporting requirements"
    - name: "campaign_region"
      expr: campaign_region
      comment: "Geographic region where the campaign applies"
    - name: "effective_start_month"
      expr: DATE_TRUNC('MONTH', effective_start_date)
      comment: "Month when the campaign became effective"
    - name: "effective_end_month"
      expr: DATE_TRUNC('MONTH', effective_end_date)
      comment: "Month when the campaign ends"
    - name: "regulatory_reporting_month"
      expr: DATE_TRUNC('MONTH', regulatory_reporting_date)
      comment: "Month of regulatory reporting deadline"
  measures:
    - name: "total_campaigns"
      expr: COUNT(1)
      comment: "Total number of service campaigns"
    - name: "total_affected_vehicles"
      expr: SUM(CAST(affected_vin_population AS DOUBLE))
      comment: "Total number of vehicles affected across all campaigns"
    - name: "avg_affected_vehicles_per_campaign"
      expr: AVG(CAST(affected_vin_population AS DOUBLE))
      comment: "Average number of vehicles affected per campaign"
    - name: "total_campaign_cost_estimate"
      expr: SUM(CAST(campaign_cost_estimate AS DOUBLE))
      comment: "Total estimated cost of all campaigns"
    - name: "total_parts_cost_estimate"
      expr: SUM(CAST(parts_cost_estimate AS DOUBLE))
      comment: "Total estimated parts cost across all campaigns"
    - name: "avg_campaign_cost"
      expr: AVG(CAST(campaign_cost_estimate AS DOUBLE))
      comment: "Average estimated cost per campaign"
    - name: "avg_parts_cost"
      expr: AVG(CAST(parts_cost_estimate AS DOUBLE))
      comment: "Average estimated parts cost per campaign"
    - name: "safety_recall_count"
      expr: SUM(CAST(CASE WHEN safety_recall_flag = TRUE THEN 1 ELSE 0 END AS INT))
      comment: "Count of safety recall campaigns"
    - name: "emissions_recall_count"
      expr: SUM(CAST(CASE WHEN emissions_recall_flag = TRUE THEN 1 ELSE 0 END AS INT))
      comment: "Count of emissions-related recall campaigns"
    - name: "tsb_count"
      expr: SUM(CAST(CASE WHEN technical_service_bulletin_flag = TRUE THEN 1 ELSE 0 END AS INT))
      comment: "Count of technical service bulletin campaigns"
    - name: "nhtsa_compliance_count"
      expr: SUM(CAST(CASE WHEN nhtsa_compliance_flag = TRUE THEN 1 ELSE 0 END AS INT))
      comment: "Count of campaigns requiring NHTSA compliance"
    - name: "warranty_impact_count"
      expr: SUM(CAST(CASE WHEN warranty_impact_flag = TRUE THEN 1 ELSE 0 END AS INT))
      comment: "Count of campaigns impacting warranty coverage"
    - name: "distinct_vehicle_programs"
      expr: COUNT(DISTINCT vehicle_program_id)
      comment: "Number of unique vehicle programs affected by campaigns"
    - name: "distinct_nameplates"
      expr: COUNT(DISTINCT aftersales_nameplate_id)
      comment: "Number of unique nameplates affected by campaigns"
$$;


CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`aftersales_service_center`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Service center operational capacity and performance KPIs tracking bay count, technician headcount, service volume, authorization levels, and certification status for network management"
  source: "`vibe_automotive_v1`.`aftersales`.`service_center`"
  dimensions:
    - name: "service_center_type"
      expr: service_center_type
      comment: "Type of service center (dealer, independent, mobile, fleet)"
    - name: "network_status"
      expr: network_status
      comment: "Status in the service network (active, inactive, pending)"
    - name: "authorization_level"
      expr: authorization_level
      comment: "Authorization level for service operations"
    - name: "warranty_authorized"
      expr: warranty_authorized
      comment: "Whether the center is authorized for warranty work"
    - name: "recall_authorized"
      expr: recall_authorized
      comment: "Whether the center is authorized for recall work"
    - name: "collision_authorized"
      expr: collision_authorized
      comment: "Whether the center is authorized for collision repair"
    - name: "ev_certified"
      expr: ev_certified
      comment: "Whether the center is certified for electric vehicle service"
    - name: "adas_calibration_authorized"
      expr: adas_calibration_authorized
      comment: "Whether the center is authorized for ADAS calibration"
    - name: "iatf_certified"
      expr: iatf_certified
      comment: "Whether the center is IATF 16949 certified"
    - name: "iso9001_certified"
      expr: iso9001_certified
      comment: "Whether the center is ISO 9001 certified"
    - name: "is_primary_center"
      expr: is_primary_center
      comment: "Whether this is a primary/flagship service center"
    - name: "region"
      expr: region
      comment: "Geographic region of the service center"
    - name: "market"
      expr: market
      comment: "Market where the service center operates"
    - name: "country"
      expr: country
      comment: "Country where the service center is located"
    - name: "state"
      expr: state
      comment: "State/province where the service center is located"
    - name: "regulatory_status"
      expr: regulatory_status
      comment: "Regulatory compliance status of the service center"
  measures:
    - name: "total_service_centers"
      expr: COUNT(1)
      comment: "Total number of service centers in the network"
    - name: "total_service_bays"
      expr: SUM(CAST(service_bay_count AS DOUBLE))
      comment: "Total number of service bays across all centers"
    - name: "total_technicians"
      expr: SUM(CAST(technician_headcount AS DOUBLE))
      comment: "Total technician headcount across all service centers"
    - name: "total_loaner_fleet"
      expr: SUM(CAST(loaner_fleet_size AS DOUBLE))
      comment: "Total loaner vehicle fleet size across all centers"
    - name: "total_service_orders_processed"
      expr: SUM(CAST(service_orders_processed AS DOUBLE))
      comment: "Total service orders processed across all centers"
    - name: "total_warranty_claims_processed"
      expr: SUM(CAST(warranty_claims_processed AS DOUBLE))
      comment: "Total warranty claims processed across all centers"
    - name: "avg_service_bays_per_center"
      expr: AVG(CAST(service_bay_count AS DOUBLE))
      comment: "Average number of service bays per center"
    - name: "avg_technicians_per_center"
      expr: AVG(CAST(technician_headcount AS DOUBLE))
      comment: "Average technician headcount per center"
    - name: "avg_loaner_fleet_per_center"
      expr: AVG(CAST(loaner_fleet_size AS DOUBLE))
      comment: "Average loaner fleet size per center"
    - name: "avg_service_time_minutes"
      expr: AVG(CAST(average_service_time_minutes AS DOUBLE))
      comment: "Average service time in minutes across centers"
    - name: "warranty_authorized_count"
      expr: SUM(CAST(CASE WHEN warranty_authorized = TRUE THEN 1 ELSE 0 END AS INT))
      comment: "Count of warranty-authorized service centers"
    - name: "recall_authorized_count"
      expr: SUM(CAST(CASE WHEN recall_authorized = TRUE THEN 1 ELSE 0 END AS INT))
      comment: "Count of recall-authorized service centers"
    - name: "ev_certified_count"
      expr: SUM(CAST(CASE WHEN ev_certified = TRUE THEN 1 ELSE 0 END AS INT))
      comment: "Count of EV-certified service centers"
    - name: "adas_authorized_count"
      expr: SUM(CAST(CASE WHEN adas_calibration_authorized = TRUE THEN 1 ELSE 0 END AS INT))
      comment: "Count of ADAS calibration-authorized service centers"
    - name: "collision_authorized_count"
      expr: SUM(CAST(CASE WHEN collision_authorized = TRUE THEN 1 ELSE 0 END AS INT))
      comment: "Count of collision-authorized service centers"
    - name: "iatf_certified_count"
      expr: SUM(CAST(CASE WHEN iatf_certified = TRUE THEN 1 ELSE 0 END AS INT))
      comment: "Count of IATF 16949 certified service centers"
    - name: "distinct_dealerships"
      expr: COUNT(DISTINCT dealership_id)
      comment: "Number of unique dealerships operating service centers"
$$;


CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`aftersales_parts_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Aftersales parts order financial and fulfillment KPIs tracking order value, freight costs, backorder rates, and fulfillment performance for parts supply chain management"
  source: "`vibe_automotive_v1`.`aftersales`.`aftersales_parts_order`"
  dimensions:
    - name: "order_status"
      expr: order_status
      comment: "Current status of the parts order (open, shipped, delivered, cancelled)"
    - name: "order_type"
      expr: order_type
      comment: "Type of parts order (stock, emergency, warranty, recall)"
    - name: "backorder_flag"
      expr: backorder_flag
      comment: "Whether the order has backordered items"
    - name: "priority_flag"
      expr: priority_flag
      comment: "Whether the order is marked as priority"
    - name: "shipping_method"
      expr: shipping_method
      comment: "Shipping method used for the order (ground, air, expedited)"
    - name: "freight_terms"
      expr: freight_terms
      comment: "Freight terms (prepaid, collect, third-party)"
    - name: "payment_terms"
      expr: payment_terms
      comment: "Payment terms for the order"
    - name: "fulfillment_location_code"
      expr: fulfillment_location_code
      comment: "Code of the fulfillment location/warehouse"
    - name: "order_month"
      expr: DATE_TRUNC('MONTH', order_timestamp)
      comment: "Month when the order was placed"
    - name: "requested_delivery_month"
      expr: DATE_TRUNC('MONTH', requested_delivery_date)
      comment: "Month of requested delivery date"
    - name: "actual_delivery_month"
      expr: DATE_TRUNC('MONTH', actual_delivery_date)
      comment: "Month of actual delivery date"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency code for order amounts"
  measures:
    - name: "total_parts_orders"
      expr: COUNT(1)
      comment: "Total number of parts orders"
    - name: "total_order_value"
      expr: SUM(CAST(total_order_value AS DOUBLE))
      comment: "Total value of all parts orders"
    - name: "total_net_amount"
      expr: SUM(CAST(net_total AS DOUBLE))
      comment: "Total net amount (before tax) of all parts orders"
    - name: "total_freight_cost"
      expr: SUM(CAST(freight_cost AS DOUBLE))
      comment: "Total freight cost across all parts orders"
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discounts applied to parts orders"
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount on parts orders"
    - name: "avg_order_value"
      expr: AVG(CAST(total_order_value AS DOUBLE))
      comment: "Average value per parts order"
    - name: "avg_freight_cost"
      expr: AVG(CAST(freight_cost AS DOUBLE))
      comment: "Average freight cost per parts order"
    - name: "backorder_count"
      expr: SUM(CAST(CASE WHEN backorder_flag = TRUE THEN 1 ELSE 0 END AS INT))
      comment: "Count of parts orders with backorders"
    - name: "priority_order_count"
      expr: SUM(CAST(CASE WHEN priority_flag = TRUE THEN 1 ELSE 0 END AS INT))
      comment: "Count of priority parts orders"
    - name: "distinct_dealerships"
      expr: COUNT(DISTINCT dealership_id)
      comment: "Number of unique dealerships placing parts orders"
    - name: "distinct_fulfillment_locations"
      expr: COUNT(DISTINCT fulfillment_location_code)
      comment: "Number of unique fulfillment locations serving orders"
$$;


CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`aftersales_service_appointment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Service appointment scheduling and customer experience KPIs tracking appointment volume, no-show rates, estimated vs actual amounts, and customer satisfaction for service operations"
  source: "`vibe_automotive_v1`.`aftersales`.`aftersales_service_appointment`"
  dimensions:
    - name: "appointment_status"
      expr: aftersales_service_appointment_status
      comment: "Current status of the service appointment (scheduled, confirmed, in-progress, completed, cancelled)"
    - name: "service_type"
      expr: service_type
      comment: "Type of service scheduled (maintenance, repair, inspection, recall)"
    - name: "service_category"
      expr: service_category
      comment: "Category of service (routine, diagnostic, warranty, etc.)"
    - name: "service_priority"
      expr: service_priority
      comment: "Priority level of the service appointment"
    - name: "appointment_source"
      expr: appointment_source
      comment: "Source of the appointment (phone, online, mobile app, walk-in)"
    - name: "confirmation_status"
      expr: confirmation_status
      comment: "Confirmation status of the appointment"
    - name: "no_show_flag"
      expr: no_show_flag
      comment: "Whether the customer did not show up for the appointment"
    - name: "warranty_flag"
      expr: warranty_flag
      comment: "Whether the service is covered under warranty"
    - name: "recall_flag"
      expr: recall_flag
      comment: "Whether the appointment is for a recall"
    - name: "is_first_time_customer"
      expr: is_first_time_customer
      comment: "Whether this is the customer's first service appointment"
    - name: "is_repeat_service"
      expr: is_repeat_service
      comment: "Whether this is a repeat service for the same issue"
    - name: "required_parts_flag"
      expr: required_parts_flag
      comment: "Whether parts are required for the service"
    - name: "transportation_option"
      expr: transportation_option
      comment: "Transportation option provided (loaner, shuttle, wait, none)"
    - name: "scheduled_month"
      expr: DATE_TRUNC('MONTH', scheduled_timestamp)
      comment: "Month when the appointment was scheduled"
    - name: "check_in_month"
      expr: DATE_TRUNC('MONTH', check_in_timestamp)
      comment: "Month when the customer checked in"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency code for appointment amounts"
  measures:
    - name: "total_appointments"
      expr: COUNT(1)
      comment: "Total number of service appointments"
    - name: "total_estimated_gross_amount"
      expr: SUM(CAST(estimated_gross_amount AS DOUBLE))
      comment: "Total estimated gross amount for all appointments"
    - name: "total_estimated_net_amount"
      expr: SUM(CAST(estimated_net_amount AS DOUBLE))
      comment: "Total estimated net amount for all appointments"
    - name: "total_actual_amount"
      expr: SUM(CAST(total_actual_amount AS DOUBLE))
      comment: "Total actual amount billed for completed appointments"
    - name: "total_estimated_tax"
      expr: SUM(CAST(estimated_tax_amount AS DOUBLE))
      comment: "Total estimated tax amount for appointments"
    - name: "total_parts_actual_amount"
      expr: SUM(CAST(parts_actual_amount AS DOUBLE))
      comment: "Total actual parts amount for completed appointments"
    - name: "avg_estimated_gross_amount"
      expr: AVG(CAST(estimated_gross_amount AS DOUBLE))
      comment: "Average estimated gross amount per appointment"
    - name: "avg_actual_amount"
      expr: AVG(CAST(total_actual_amount AS DOUBLE))
      comment: "Average actual amount per completed appointment"
    - name: "avg_vehicle_mileage"
      expr: AVG(CAST(vehicle_mileage AS DOUBLE))
      comment: "Average vehicle mileage at service appointment"
    - name: "no_show_count"
      expr: SUM(CAST(CASE WHEN no_show_flag = TRUE THEN 1 ELSE 0 END AS INT))
      comment: "Count of no-show appointments"
    - name: "warranty_appointment_count"
      expr: SUM(CAST(CASE WHEN warranty_flag = TRUE THEN 1 ELSE 0 END AS INT))
      comment: "Count of warranty service appointments"
    - name: "recall_appointment_count"
      expr: SUM(CAST(CASE WHEN recall_flag = TRUE THEN 1 ELSE 0 END AS INT))
      comment: "Count of recall service appointments"
    - name: "first_time_customer_count"
      expr: SUM(CAST(CASE WHEN is_first_time_customer = TRUE THEN 1 ELSE 0 END AS INT))
      comment: "Count of first-time customer appointments"
    - name: "repeat_service_count"
      expr: SUM(CAST(CASE WHEN is_repeat_service = TRUE THEN 1 ELSE 0 END AS INT))
      comment: "Count of repeat service appointments for same issue"
    - name: "distinct_customers"
      expr: COUNT(DISTINCT party_id)
      comment: "Number of unique customers with service appointments"
    - name: "distinct_vins"
      expr: COUNT(DISTINCT vin_registry_id)
      comment: "Number of unique vehicles with service appointments"
    - name: "distinct_dealerships"
      expr: COUNT(DISTINCT aftersales_dealership_id)
      comment: "Number of unique dealerships with service appointments"
$$;


CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`aftersales_customer_satisfaction_survey`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Customer satisfaction and Net Promoter Score (NPS) KPIs tracking survey responses, satisfaction scores, and service quality ratings for customer experience management"
  source: "`vibe_automotive_v1`.`aftersales`.`customer_satisfaction_survey`"
  dimensions:
    - name: "survey_status"
      expr: customer_satisfaction_survey_status
      comment: "Status of the customer satisfaction survey (sent, completed, expired)"
    - name: "service_type"
      expr: service_type
      comment: "Type of service that was surveyed"
    - name: "survey_method"
      expr: survey_method
      comment: "Method used to conduct the survey (email, SMS, phone, in-person)"
    - name: "survey_channel"
      expr: survey_channel
      comment: "Channel through which the survey was delivered"
    - name: "response_source"
      expr: response_source
      comment: "Source of the survey response (web, mobile, IVR, paper)"
    - name: "respondent_type"
      expr: respondent_type
      comment: "Type of respondent (owner, driver, fleet manager)"
    - name: "warranty_flag"
      expr: warranty_flag
      comment: "Whether the surveyed service was warranty work"
    - name: "follow_up_action_flag"
      expr: follow_up_action_flag
      comment: "Whether follow-up action was required based on survey response"
    - name: "language_code"
      expr: language_code
      comment: "Language in which the survey was conducted"
    - name: "survey_month"
      expr: DATE_TRUNC('MONTH', survey_date)
      comment: "Month when the survey was conducted"
    - name: "response_month"
      expr: DATE_TRUNC('MONTH', response_timestamp)
      comment: "Month when the survey response was received"
  measures:
    - name: "total_surveys"
      expr: COUNT(1)
      comment: "Total number of customer satisfaction surveys"
    - name: "completed_surveys"
      expr: SUM(CAST(CASE WHEN customer_satisfaction_survey_status = 'completed' THEN 1 ELSE 0 END AS INT))
      comment: "Count of completed surveys"
    - name: "avg_overall_score"
      expr: AVG(CAST(overall_score AS DOUBLE))
      comment: "Average overall satisfaction score across all surveys"
    - name: "avg_nps_score"
      expr: AVG(CAST(nps_score AS DOUBLE))
      comment: "Average Net Promoter Score (NPS) across all surveys"
    - name: "avg_service_advisor_score"
      expr: AVG(CAST(service_advisor_score AS DOUBLE))
      comment: "Average service advisor satisfaction score"
    - name: "avg_technician_quality_score"
      expr: AVG(CAST(technician_quality_score AS DOUBLE))
      comment: "Average technician quality satisfaction score"
    - name: "avg_facility_score"
      expr: AVG(CAST(facility_score AS DOUBLE))
      comment: "Average facility satisfaction score"
    - name: "follow_up_required_count"
      expr: SUM(CAST(CASE WHEN follow_up_action_flag = TRUE THEN 1 ELSE 0 END AS INT))
      comment: "Count of surveys requiring follow-up action"
    - name: "warranty_service_survey_count"
      expr: SUM(CAST(CASE WHEN warranty_flag = TRUE THEN 1 ELSE 0 END AS INT))
      comment: "Count of surveys for warranty service"
    - name: "distinct_customers"
      expr: COUNT(DISTINCT party_id)
      comment: "Number of unique customers who completed surveys"
    - name: "distinct_service_centers"
      expr: COUNT(DISTINCT service_center_id)
      comment: "Number of unique service centers surveyed"
    - name: "distinct_repair_orders"
      expr: COUNT(DISTINCT aftersales_repair_order_id)
      comment: "Number of unique repair orders associated with surveys"
$$;


CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`aftersales_technician`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Technician workforce capacity and productivity KPIs tracking headcount, certification levels, efficiency ratings, and active workload for technician resource management"
  source: "`vibe_automotive_v1`.`aftersales`.`technician`"
  dimensions:
    - name: "technician_status"
      expr: technician_status
      comment: "Current employment status of the technician (active, inactive, on-leave)"
    - name: "availability_status"
      expr: availability_status
      comment: "Current availability status (available, busy, off-duty)"
    - name: "skill_level"
      expr: skill_level
      comment: "Skill level of the technician (apprentice, journeyman, master)"
    - name: "certification_level"
      expr: certification_level
      comment: "Certification level (ASE, manufacturer-specific, etc.)"
    - name: "certification_type"
      expr: certification_type
      comment: "Type of certification held"
    - name: "specialization"
      expr: specialization
      comment: "Area of specialization (engine, transmission, electrical, ADAS, EV)"
    - name: "shift_type"
      expr: shift_type
      comment: "Shift type (day, evening, night, rotating)"
    - name: "overtime_eligible"
      expr: overtime_eligible
      comment: "Whether the technician is eligible for overtime"
    - name: "hire_month"
      expr: DATE_TRUNC('MONTH', hire_date)
      comment: "Month when the technician was hired"
    - name: "certification_expiry_month"
      expr: DATE_TRUNC('MONTH', certification_expiry_date)
      comment: "Month when certification expires"
    - name: "last_training_month"
      expr: DATE_TRUNC('MONTH', last_training_date)
      comment: "Month of last training completed"
  measures:
    - name: "total_technicians"
      expr: COUNT(1)
      comment: "Total number of technicians"
    - name: "active_technicians"
      expr: SUM(CAST(CASE WHEN technician_status = 'active' THEN 1 ELSE 0 END AS INT))
      comment: "Count of active technicians"
    - name: "available_technicians"
      expr: SUM(CAST(CASE WHEN availability_status = 'available' THEN 1 ELSE 0 END AS INT))
      comment: "Count of currently available technicians"
    - name: "total_active_ro_count"
      expr: SUM(CAST(current_active_ro_count AS DOUBLE))
      comment: "Total number of active repair orders across all technicians"
    - name: "avg_active_ro_per_technician"
      expr: AVG(CAST(current_active_ro_count AS DOUBLE))
      comment: "Average number of active repair orders per technician"
    - name: "avg_flat_rate_efficiency"
      expr: AVG(CAST(flat_rate_efficiency_rating AS DOUBLE))
      comment: "Average flat-rate efficiency rating across technicians"
    - name: "avg_years_experience"
      expr: AVG(CAST(years_of_experience AS DOUBLE))
      comment: "Average years of experience across technicians"
    - name: "avg_training_hours"
      expr: AVG(CAST(training_hours_completed AS DOUBLE))
      comment: "Average training hours completed per technician"
    - name: "avg_overtime_rate_multiplier"
      expr: AVG(CAST(overtime_rate_multiplier AS DOUBLE))
      comment: "Average overtime rate multiplier"
    - name: "overtime_eligible_count"
      expr: SUM(CAST(CASE WHEN overtime_eligible = TRUE THEN 1 ELSE 0 END AS INT))
      comment: "Count of overtime-eligible technicians"
    - name: "master_technician_count"
      expr: SUM(CAST(CASE WHEN skill_level = 'master' THEN 1 ELSE 0 END AS INT))
      comment: "Count of master-level technicians"
    - name: "distinct_service_centers"
      expr: COUNT(DISTINCT service_center_id)
      comment: "Number of unique service centers employing technicians"
    - name: "distinct_specializations"
      expr: COUNT(DISTINCT specialization)
      comment: "Number of unique specialization areas covered"
$$;


CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`aftersales_loaner_vehicle`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Loaner vehicle fleet utilization and asset management KPIs tracking fleet size, utilization rates, odometer readings, and depreciation for loaner fleet optimization"
  source: "`vibe_automotive_v1`.`aftersales`.`loaner_vehicle`"
  dimensions:
    - name: "loaner_vehicle_status"
      expr: loaner_vehicle_status
      comment: "Current status of the loaner vehicle (available, loaned, maintenance, retired)"
    - name: "vehicle_type"
      expr: vehicle_type
      comment: "Type of loaner vehicle (sedan, SUV, truck, EV)"
    - name: "pool_type"
      expr: pool_type
      comment: "Pool type (standard, premium, commercial)"
    - name: "fuel_type"
      expr: fuel_type
      comment: "Fuel type of the loaner vehicle"
    - name: "powertrain_type"
      expr: powertrain_type
      comment: "Powertrain type (ICE, hybrid, electric)"
    - name: "make"
      expr: make
      comment: "Make/brand of the loaner vehicle"
    - name: "model"
      expr: model
      comment: "Model of the loaner vehicle"
    - name: "model_year"
      expr: model_year
      comment: "Model year of the loaner vehicle"
    - name: "current_location"
      expr: current_location
      comment: "Current location of the loaner vehicle"
    - name: "registration_state"
      expr: registration_state
      comment: "State where the loaner vehicle is registered"
    - name: "acquisition_month"
      expr: DATE_TRUNC('MONTH', acquisition_date)
      comment: "Month when the loaner vehicle was acquired"
    - name: "last_maintenance_month"
      expr: DATE_TRUNC('MONTH', last_maintenance_date)
      comment: "Month of last maintenance"
    - name: "insurance_expiry_month"
      expr: DATE_TRUNC('MONTH', insurance_expiry_date)
      comment: "Month when insurance expires"
    - name: "warranty_expiry_month"
      expr: DATE_TRUNC('MONTH', warranty_expiry_date)
      comment: "Month when warranty expires"
  measures:
    - name: "total_loaner_vehicles"
      expr: COUNT(1)
      comment: "Total number of loaner vehicles in the fleet"
    - name: "available_loaner_count"
      expr: SUM(CAST(CASE WHEN loaner_vehicle_status = 'available' THEN 1 ELSE 0 END AS INT))
      comment: "Count of available loaner vehicles"
    - name: "loaned_out_count"
      expr: SUM(CAST(CASE WHEN loaner_vehicle_status = 'loaned' THEN 1 ELSE 0 END AS INT))
      comment: "Count of loaner vehicles currently loaned out"
    - name: "total_loan_out_count"
      expr: SUM(CAST(total_loan_out_count AS DOUBLE))
      comment: "Total number of times loaner vehicles have been loaned out"
    - name: "avg_loan_out_count_per_vehicle"
      expr: AVG(CAST(total_loan_out_count AS DOUBLE))
      comment: "Average number of loan-outs per loaner vehicle"
    - name: "total_purchase_price"
      expr: SUM(CAST(purchase_price AS DOUBLE))
      comment: "Total purchase price of all loaner vehicles (fleet acquisition cost)"
    - name: "total_depreciation_value"
      expr: SUM(CAST(depreciation_value AS DOUBLE))
      comment: "Total depreciation value across all loaner vehicles"
    - name: "avg_purchase_price"
      expr: AVG(CAST(purchase_price AS DOUBLE))
      comment: "Average purchase price per loaner vehicle"
    - name: "avg_depreciation_value"
      expr: AVG(CAST(depreciation_value AS DOUBLE))
      comment: "Average depreciation value per loaner vehicle"
    - name: "avg_current_odometer"
      expr: AVG(CAST(current_odometer AS DOUBLE))
      comment: "Average current odometer reading across loaner fleet"
    - name: "avg_mileage_at_acquisition"
      expr: AVG(CAST(mileage_at_acquisition AS DOUBLE))
      comment: "Average mileage at acquisition across loaner fleet"
    - name: "distinct_service_centers"
      expr: COUNT(DISTINCT service_center_id)
      comment: "Number of unique service centers with loaner vehicles"
    - name: "distinct_makes"
      expr: COUNT(DISTINCT make)
      comment: "Number of unique makes in the loaner fleet"
    - name: "distinct_models"
      expr: COUNT(DISTINCT model)
      comment: "Number of unique models in the loaner fleet"
$$;
