-- Metric views for domain: aftersales | Business: Automotive | Version: 2 | Generated on: 2026-07-14 04:28:06

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`aftersales_repair_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core repair order KPIs tracking service revenue, labor efficiency, warranty mix, and customer satisfaction across dealership aftersales operations"
  source: "`vibe_automotive_v1`.`aftersales`.`aftersales_repair_order`"
  dimensions:
    - name: "aftersales_repair_order_status"
      expr: aftersales_repair_order_status
      comment: "Current status of the repair order (open, in-progress, completed, closed)"
    - name: "service_type"
      expr: service_type
      comment: "Type of service performed (maintenance, repair, recall, diagnostic)"
    - name: "warranty_flag"
      expr: warranty_flag
      comment: "Indicates whether the repair order is covered under warranty"
    - name: "payment_status"
      expr: payment_status
      comment: "Payment status of the repair order (paid, pending, partial)"
    - name: "service_priority"
      expr: service_priority
      comment: "Priority level assigned to the service (urgent, high, normal, low)"
    - name: "service_center_region"
      expr: service_center_region
      comment: "Geographic region of the service center performing the repair"
    - name: "customer_feedback_score"
      expr: customer_feedback_score
      comment: "Customer satisfaction score for the repair order"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which the repair order was transacted"
    - name: "repair_order_year"
      expr: YEAR(created_timestamp)
      comment: "Year the repair order was created"
    - name: "repair_order_month"
      expr: DATE_TRUNC('MONTH', created_timestamp)
      comment: "Month the repair order was created"
    - name: "completion_year_month"
      expr: DATE_TRUNC('MONTH', actual_completion_time)
      comment: "Month the repair order was completed"
  measures:
    - name: "total_repair_orders"
      expr: COUNT(1)
      comment: "Total number of repair orders"
    - name: "total_repair_revenue"
      expr: SUM(CAST(total_amount AS DOUBLE))
      comment: "Total revenue from all repair orders including parts, labor, and tax"
    - name: "total_labor_revenue"
      expr: SUM(CAST(labor_total_cost AS DOUBLE))
      comment: "Total revenue from labor charges across all repair orders"
    - name: "total_parts_revenue"
      expr: SUM(CAST(parts_total_cost AS DOUBLE))
      comment: "Total revenue from parts sales across all repair orders"
    - name: "total_labor_hours"
      expr: SUM(CAST(labor_total_hours AS DOUBLE))
      comment: "Total labor hours billed across all repair orders"
    - name: "avg_labor_hours_per_ro"
      expr: AVG(CAST(labor_total_hours AS DOUBLE))
      comment: "Average labor hours per repair order, indicating service complexity"
    - name: "avg_repair_order_value"
      expr: AVG(CAST(total_amount AS DOUBLE))
      comment: "Average total value per repair order, key metric for service revenue per transaction"
    - name: "labor_revenue_per_hour"
      expr: SUM(CAST(labor_total_cost AS DOUBLE)) / NULLIF(SUM(CAST(labor_total_hours AS DOUBLE)), 0)
      comment: "Effective labor rate realized per hour, measuring labor pricing efficiency"
    - name: "parts_to_labor_ratio"
      expr: SUM(CAST(parts_total_cost AS DOUBLE)) / NULLIF(SUM(CAST(labor_total_cost AS DOUBLE)), 0)
      comment: "Ratio of parts revenue to labor revenue, indicating service mix and upsell effectiveness"
    - name: "warranty_repair_order_count"
      expr: SUM(CAST(CASE WHEN warranty_flag = TRUE THEN 1 ELSE 0 END AS INT))
      comment: "Count of repair orders covered under warranty"
    - name: "warranty_penetration_rate"
      expr: SUM(CAST(CASE WHEN warranty_flag = TRUE THEN 1 ELSE 0 END AS INT)) / NULLIF(COUNT(1), 0)
      comment: "Percentage of repair orders covered by warranty, indicating warranty claim volume"
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discounts applied across all repair orders"
    - name: "discount_rate"
      expr: SUM(CAST(discount_amount AS DOUBLE)) / NULLIF(SUM(CAST(total_amount AS DOUBLE)) + SUM(CAST(discount_amount AS DOUBLE)), 0)
      comment: "Percentage of gross revenue given as discounts, measuring pricing discipline"
    - name: "completed_repair_orders"
      expr: SUM(CASE WHEN aftersales_repair_order_status IN ('completed', 'closed') THEN 1 ELSE 0 END)
      comment: "Count of repair orders that have been completed or closed"
    - name: "unique_vehicles_serviced"
      expr: COUNT(DISTINCT vin_registry_id)
      comment: "Number of unique vehicles serviced, indicating customer base breadth"
    - name: "unique_customers_serviced"
      expr: COUNT(DISTINCT primary_aftersales_customer_party_id)
      comment: "Number of unique customers served, measuring customer reach"
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`aftersales_service_appointment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Service appointment KPIs tracking scheduling efficiency, customer experience, no-show rates, and appointment-to-revenue conversion"
  source: "`vibe_automotive_v1`.`aftersales`.`aftersales_service_appointment`"
  dimensions:
    - name: "aftersales_service_appointment_status"
      expr: aftersales_service_appointment_status
      comment: "Current status of the service appointment (scheduled, confirmed, in-progress, completed, cancelled)"
    - name: "service_type"
      expr: service_type
      comment: "Type of service scheduled (maintenance, repair, inspection, recall)"
    - name: "appointment_source"
      expr: appointment_source
      comment: "Channel through which the appointment was booked (online, phone, walk-in, mobile app)"
    - name: "service_priority"
      expr: service_priority
      comment: "Priority level of the service appointment"
    - name: "confirmation_status"
      expr: confirmation_status
      comment: "Whether the appointment has been confirmed by the customer"
    - name: "no_show_flag"
      expr: no_show_flag
      comment: "Indicates whether the customer failed to show up for the appointment"
    - name: "is_first_time_customer"
      expr: is_first_time_customer
      comment: "Indicates whether this is the customer's first service appointment"
    - name: "warranty_flag"
      expr: warranty_flag
      comment: "Indicates whether the service is covered under warranty"
    - name: "recall_flag"
      expr: recall_flag
      comment: "Indicates whether the appointment is for a recall service"
    - name: "appointment_year_month"
      expr: DATE_TRUNC('MONTH', scheduled_timestamp)
      comment: "Month the appointment was scheduled for"
    - name: "created_year_month"
      expr: DATE_TRUNC('MONTH', created_timestamp)
      comment: "Month the appointment was created"
  measures:
    - name: "total_appointments"
      expr: COUNT(1)
      comment: "Total number of service appointments scheduled"
    - name: "completed_appointments"
      expr: SUM(CAST(CASE WHEN aftersales_service_appointment_status = 'completed' THEN 1 ELSE 0 END AS INT))
      comment: "Number of appointments that were completed"
    - name: "appointment_completion_rate"
      expr: SUM(CAST(CASE WHEN aftersales_service_appointment_status = 'completed' THEN 1 ELSE 0 END AS INT)) / NULLIF(COUNT(1), 0)
      comment: "Percentage of appointments that were completed, measuring service delivery effectiveness"
    - name: "no_show_count"
      expr: SUM(CAST(CASE WHEN no_show_flag = TRUE THEN 1 ELSE 0 END AS INT))
      comment: "Number of appointments where the customer did not show up"
    - name: "no_show_rate"
      expr: SUM(CAST(CASE WHEN no_show_flag = TRUE THEN 1 ELSE 0 END AS INT)) / NULLIF(COUNT(1), 0)
      comment: "Percentage of appointments resulting in no-shows, critical for capacity planning and customer engagement"
    - name: "first_time_customer_count"
      expr: SUM(CAST(CASE WHEN is_first_time_customer = TRUE THEN 1 ELSE 0 END AS INT))
      comment: "Number of appointments from first-time customers"
    - name: "first_time_customer_rate"
      expr: SUM(CAST(CASE WHEN is_first_time_customer = TRUE THEN 1 ELSE 0 END AS INT)) / NULLIF(COUNT(1), 0)
      comment: "Percentage of appointments from first-time customers, indicating new customer acquisition"
    - name: "total_appointment_revenue"
      expr: SUM(CAST(total_actual_amount AS DOUBLE))
      comment: "Total actual revenue generated from completed appointments"
    - name: "avg_appointment_revenue"
      expr: AVG(CAST(total_actual_amount AS DOUBLE))
      comment: "Average revenue per appointment, key metric for service value per visit"
    - name: "total_estimated_revenue"
      expr: SUM(CAST(estimated_gross_amount AS DOUBLE))
      comment: "Total estimated revenue from all appointments at time of booking"
    - name: "revenue_realization_rate"
      expr: SUM(CAST(total_actual_amount AS DOUBLE)) / NULLIF(SUM(CAST(estimated_gross_amount AS DOUBLE)), 0)
      comment: "Ratio of actual to estimated revenue, measuring estimation accuracy and upsell effectiveness"
    - name: "avg_vehicle_mileage"
      expr: AVG(CAST(vehicle_mileage AS DOUBLE))
      comment: "Average vehicle mileage at time of service, indicating fleet age and service needs"
    - name: "recall_appointment_count"
      expr: SUM(CAST(CASE WHEN recall_flag = TRUE THEN 1 ELSE 0 END AS INT))
      comment: "Number of appointments for recall services"
    - name: "recall_appointment_rate"
      expr: SUM(CAST(CASE WHEN recall_flag = TRUE THEN 1 ELSE 0 END AS INT)) / NULLIF(COUNT(1), 0)
      comment: "Percentage of appointments related to recalls, measuring recall campaign effectiveness"
    - name: "warranty_appointment_count"
      expr: SUM(CAST(CASE WHEN warranty_flag = TRUE THEN 1 ELSE 0 END AS INT))
      comment: "Number of appointments covered under warranty"
    - name: "unique_customers"
      expr: COUNT(DISTINCT primary_aftersales_customer_party_id)
      comment: "Number of unique customers with service appointments"
    - name: "unique_vehicles"
      expr: COUNT(DISTINCT vin_registry_id)
      comment: "Number of unique vehicles scheduled for service"
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`aftersales_repair_order_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Repair order line-level KPIs tracking labor efficiency, technician productivity, warranty line mix, and parts utilization"
  source: "`vibe_automotive_v1`.`aftersales`.`repair_order_line`"
  dimensions:
    - name: "line_status"
      expr: line_status
      comment: "Status of the individual repair order line item"
    - name: "labor_category"
      expr: labor_category
      comment: "Category of labor performed (mechanical, electrical, body, diagnostic)"
    - name: "labor_skill_level"
      expr: labor_skill_level
      comment: "Skill level required for the labor (apprentice, journeyman, master)"
    - name: "warranty_flag"
      expr: warranty_flag
      comment: "Indicates whether this line item is covered under warranty"
    - name: "parts_used_flag"
      expr: parts_used_flag
      comment: "Indicates whether parts were used in this line item"
    - name: "sublet_flag"
      expr: sublet_flag
      comment: "Indicates whether this work was sublet to an external provider"
    - name: "overtime_flag"
      expr: overtime_flag
      comment: "Indicates whether overtime labor was used"
    - name: "operation_code"
      expr: operation_code
      comment: "Standardized operation code for the service performed"
    - name: "service_year_month"
      expr: DATE_TRUNC('MONTH', service_date)
      comment: "Month the service was performed"
  measures:
    - name: "total_repair_lines"
      expr: COUNT(1)
      comment: "Total number of repair order line items"
    - name: "total_line_revenue"
      expr: SUM(CAST(line_total AS DOUBLE))
      comment: "Total revenue from all repair order line items"
    - name: "avg_line_revenue"
      expr: AVG(CAST(line_total AS DOUBLE))
      comment: "Average revenue per repair order line item"
    - name: "total_labor_hours_actual"
      expr: SUM(CAST(actual_technician_hours AS DOUBLE))
      comment: "Total actual technician hours worked across all line items"
    - name: "total_labor_hours_standard"
      expr: SUM(CAST(labor_time_standard AS DOUBLE))
      comment: "Total standard labor hours based on operation codes"
    - name: "labor_efficiency_ratio"
      expr: SUM(CAST(labor_time_standard AS DOUBLE)) / NULLIF(SUM(CAST(actual_technician_hours AS DOUBLE)), 0)
      comment: "Ratio of standard to actual labor hours, measuring technician productivity and efficiency"
    - name: "avg_labor_rate"
      expr: AVG(CAST(labor_rate AS DOUBLE))
      comment: "Average labor rate per hour charged"
    - name: "total_parts_cost"
      expr: SUM(CAST(part_price AS DOUBLE) * CAST(part_quantity AS DOUBLE))
      comment: "Total cost of parts used across all line items"
    - name: "total_parts_quantity"
      expr: SUM(CAST(part_quantity AS DOUBLE))
      comment: "Total quantity of parts used"
    - name: "warranty_line_count"
      expr: SUM(CAST(CASE WHEN warranty_flag = TRUE THEN 1 ELSE 0 END AS INT))
      comment: "Number of line items covered under warranty"
    - name: "warranty_line_rate"
      expr: SUM(CAST(CASE WHEN warranty_flag = TRUE THEN 1 ELSE 0 END AS INT)) / NULLIF(COUNT(1), 0)
      comment: "Percentage of line items covered by warranty, indicating warranty work volume"
    - name: "sublet_line_count"
      expr: SUM(CAST(CASE WHEN sublet_flag = TRUE THEN 1 ELSE 0 END AS INT))
      comment: "Number of line items sublet to external providers"
    - name: "total_sublet_cost"
      expr: SUM(CAST(sublet_cost AS DOUBLE))
      comment: "Total cost of sublet work"
    - name: "sublet_rate"
      expr: SUM(CAST(CASE WHEN sublet_flag = TRUE THEN 1 ELSE 0 END AS INT)) / NULLIF(COUNT(1), 0)
      comment: "Percentage of line items requiring sublet work, indicating in-house capability gaps"
    - name: "overtime_line_count"
      expr: SUM(CAST(CASE WHEN overtime_flag = TRUE THEN 1 ELSE 0 END AS INT))
      comment: "Number of line items requiring overtime labor"
    - name: "overtime_rate"
      expr: SUM(CAST(CASE WHEN overtime_flag = TRUE THEN 1 ELSE 0 END AS INT)) / NULLIF(COUNT(1), 0)
      comment: "Percentage of line items requiring overtime, indicating capacity constraints"
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discounts applied at line level"
    - name: "unique_repair_orders"
      expr: COUNT(DISTINCT aftersales_repair_order_id)
      comment: "Number of unique repair orders represented in the line items"
    - name: "unique_technicians"
      expr: COUNT(DISTINCT technician_id)
      comment: "Number of unique technicians who performed work"
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`aftersales_warranty_claim`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Warranty claim KPIs tracking claim volume, approval rates, cost recovery, and quality feedback for manufacturing and supplier accountability"
  source: "`vibe_automotive_v1`.`aftersales`.`warranty_claim`"
  dimensions:
    - name: "claim_status"
      expr: claim_status
      comment: "Current status of the warranty claim (submitted, approved, rejected, pending)"
    - name: "claim_category"
      expr: claim_category
      comment: "Category of the warranty claim (powertrain, electrical, body, other)"
    - name: "warranty_type"
      expr: warranty_type
      comment: "Type of warranty under which the claim is filed (basic, powertrain, extended)"
    - name: "adjudication_outcome"
      expr: adjudication_outcome
      comment: "Final outcome of the claim adjudication process"
    - name: "goodwill_flag"
      expr: goodwill_flag
      comment: "Indicates whether the claim was approved as a goodwill gesture outside warranty terms"
    - name: "claim_adjusted_flag"
      expr: claim_adjusted_flag
      comment: "Indicates whether the claim amount was adjusted during adjudication"
    - name: "rejection_reason_code"
      expr: rejection_reason_code
      comment: "Standardized code for why the claim was rejected"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which the claim was filed"
    - name: "claim_submission_year_month"
      expr: DATE_TRUNC('MONTH', claim_submission_timestamp)
      comment: "Month the claim was submitted"
    - name: "repair_year_month"
      expr: DATE_TRUNC('MONTH', repair_date)
      comment: "Month the repair was performed"
  measures:
    - name: "total_warranty_claims"
      expr: COUNT(1)
      comment: "Total number of warranty claims filed"
    - name: "total_claim_amount"
      expr: SUM(CAST(total_claim_amount AS DOUBLE))
      comment: "Total amount claimed across all warranty claims"
    - name: "total_approved_amount"
      expr: SUM(CAST(adjusted_amount AS DOUBLE))
      comment: "Total amount approved and paid out for warranty claims"
    - name: "avg_claim_amount"
      expr: AVG(CAST(total_claim_amount AS DOUBLE))
      comment: "Average amount per warranty claim filed"
    - name: "claim_approval_rate"
      expr: SUM(CAST(CASE WHEN claim_status = 'approved' THEN 1 ELSE 0 END AS INT)) / NULLIF(COUNT(1), 0)
      comment: "Percentage of warranty claims that are approved, measuring claim quality and policy adherence"
    - name: "claim_adjustment_rate"
      expr: SUM(CAST(CASE WHEN claim_adjusted_flag = TRUE THEN 1 ELSE 0 END AS INT)) / NULLIF(COUNT(1), 0)
      comment: "Percentage of claims that required adjustment, indicating claim accuracy issues"
    - name: "claim_recovery_rate"
      expr: SUM(CAST(adjusted_amount AS DOUBLE)) / NULLIF(SUM(CAST(total_claim_amount AS DOUBLE)), 0)
      comment: "Ratio of approved to claimed amounts, measuring cost recovery effectiveness"
    - name: "total_labor_cost_approved"
      expr: SUM(CAST(approved_labor_cost AS DOUBLE))
      comment: "Total labor cost approved across all warranty claims"
    - name: "total_parts_cost_approved"
      expr: SUM(CAST(approved_parts_cost AS DOUBLE))
      comment: "Total parts cost approved across all warranty claims"
    - name: "total_labor_hours_approved"
      expr: SUM(CAST(approved_labor_hours AS DOUBLE))
      comment: "Total labor hours approved for warranty work"
    - name: "avg_labor_rate_approved"
      expr: SUM(CAST(approved_labor_cost AS DOUBLE)) / NULLIF(SUM(CAST(approved_labor_hours AS DOUBLE)), 0)
      comment: "Average approved labor rate per hour for warranty claims"
    - name: "goodwill_claim_count"
      expr: SUM(CAST(CASE WHEN goodwill_flag = TRUE THEN 1 ELSE 0 END AS INT))
      comment: "Number of claims approved as goodwill outside warranty terms"
    - name: "goodwill_claim_rate"
      expr: SUM(CAST(CASE WHEN goodwill_flag = TRUE THEN 1 ELSE 0 END AS INT)) / NULLIF(COUNT(1), 0)
      comment: "Percentage of claims approved as goodwill, indicating customer satisfaction investment"
    - name: "rejected_claim_count"
      expr: SUM(CAST(CASE WHEN claim_status = 'rejected' THEN 1 ELSE 0 END AS INT))
      comment: "Number of warranty claims that were rejected"
    - name: "rejection_rate"
      expr: SUM(CAST(CASE WHEN claim_status = 'rejected' THEN 1 ELSE 0 END AS INT)) / NULLIF(COUNT(1), 0)
      comment: "Percentage of claims rejected, indicating claim quality or policy enforcement"
    - name: "unique_vehicles_claimed"
      expr: COUNT(DISTINCT vin_registry_id)
      comment: "Number of unique vehicles with warranty claims, indicating quality issues breadth"
    - name: "unique_service_centers"
      expr: COUNT(DISTINCT service_center_id)
      comment: "Number of unique service centers filing warranty claims"
    - name: "unique_suppliers_implicated"
      expr: COUNT(DISTINCT responsible_procurement_supplier_id)
      comment: "Number of unique suppliers implicated in warranty claims, for supplier quality accountability"
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`aftersales_service_campaign`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Service campaign and recall KPIs tracking campaign execution, cost, compliance, and affected vehicle population for regulatory and quality management"
  source: "`vibe_automotive_v1`.`aftersales`.`service_campaign`"
  dimensions:
    - name: "campaign_status"
      expr: campaign_status
      comment: "Current status of the service campaign (active, completed, pending, cancelled)"
    - name: "campaign_type"
      expr: campaign_type
      comment: "Type of campaign (recall, technical service bulletin, field action, customer satisfaction)"
    - name: "campaign_priority"
      expr: campaign_priority
      comment: "Priority level of the campaign (critical, high, medium, low)"
    - name: "safety_recall_flag"
      expr: safety_recall_flag
      comment: "Indicates whether the campaign is a safety recall"
    - name: "emissions_recall_flag"
      expr: emissions_recall_flag
      comment: "Indicates whether the campaign is an emissions-related recall"
    - name: "technical_service_bulletin_flag"
      expr: technical_service_bulletin_flag
      comment: "Indicates whether the campaign is a technical service bulletin"
    - name: "compliance_status"
      expr: compliance_status
      comment: "Regulatory compliance status of the campaign"
    - name: "regulatory_reporting_status"
      expr: regulatory_reporting_status
      comment: "Status of regulatory reporting for the campaign"
    - name: "nhtsa_compliance_flag"
      expr: nhtsa_compliance_flag
      comment: "Indicates NHTSA compliance for US market campaigns"
    - name: "campaign_region"
      expr: campaign_region
      comment: "Geographic region affected by the campaign"
    - name: "effective_start_year_month"
      expr: DATE_TRUNC('MONTH', effective_start_date)
      comment: "Month the campaign became effective"
  measures:
    - name: "total_campaigns"
      expr: COUNT(1)
      comment: "Total number of service campaigns"
    - name: "active_campaigns"
      expr: SUM(CAST(CASE WHEN campaign_status = 'active' THEN 1 ELSE 0 END AS INT))
      comment: "Number of currently active service campaigns"
    - name: "safety_recall_count"
      expr: SUM(CAST(CASE WHEN safety_recall_flag = TRUE THEN 1 ELSE 0 END AS INT))
      comment: "Number of safety recall campaigns, critical for regulatory compliance and brand reputation"
    - name: "emissions_recall_count"
      expr: SUM(CAST(CASE WHEN emissions_recall_flag = TRUE THEN 1 ELSE 0 END AS INT))
      comment: "Number of emissions recall campaigns, critical for environmental compliance"
    - name: "total_affected_vehicles"
      expr: SUM(CAST(affected_vin_population AS DOUBLE))
      comment: "Total number of vehicles affected across all campaigns"
    - name: "avg_affected_vehicles_per_campaign"
      expr: AVG(CAST(affected_vin_population AS DOUBLE))
      comment: "Average number of vehicles affected per campaign, indicating campaign scope"
    - name: "total_campaign_cost_estimate"
      expr: SUM(CAST(campaign_cost_estimate AS DOUBLE))
      comment: "Total estimated cost of all service campaigns"
    - name: "avg_campaign_cost"
      expr: AVG(CAST(campaign_cost_estimate AS DOUBLE))
      comment: "Average estimated cost per campaign"
    - name: "total_parts_cost_estimate"
      expr: SUM(CAST(parts_cost_estimate AS DOUBLE))
      comment: "Total estimated parts cost across all campaigns"
    - name: "cost_per_affected_vehicle"
      expr: SUM(CAST(campaign_cost_estimate AS DOUBLE)) / NULLIF(SUM(CAST(affected_vin_population AS DOUBLE)), 0)
      comment: "Average campaign cost per affected vehicle, measuring campaign efficiency"
    - name: "warranty_impact_campaign_count"
      expr: SUM(CAST(CASE WHEN warranty_impact_flag = TRUE THEN 1 ELSE 0 END AS INT))
      comment: "Number of campaigns with warranty cost impact"
    - name: "customer_satisfaction_campaign_count"
      expr: SUM(CAST(CASE WHEN customer_satisfaction_flag = TRUE THEN 1 ELSE 0 END AS INT))
      comment: "Number of campaigns aimed at improving customer satisfaction"
    - name: "nhtsa_compliant_campaign_count"
      expr: SUM(CAST(CASE WHEN nhtsa_compliance_flag = TRUE THEN 1 ELSE 0 END AS INT))
      comment: "Number of campaigns compliant with NHTSA regulations"
    - name: "unique_models_affected"
      expr: COUNT(DISTINCT model_id)
      comment: "Number of unique vehicle models affected by campaigns, indicating quality issue breadth"
    - name: "unique_suppliers_responsible"
      expr: COUNT(DISTINCT responsible_procurement_supplier_id)
      comment: "Number of unique suppliers responsible for campaign issues, for supplier quality management"
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`aftersales_parts_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Parts order KPIs tracking parts procurement efficiency, backorder rates, fulfillment speed, and inventory investment for service operations"
  source: "`vibe_automotive_v1`.`aftersales`.`parts_order`"
  dimensions:
    - name: "order_status"
      expr: order_status
      comment: "Current status of the parts order (pending, confirmed, shipped, delivered, cancelled)"
    - name: "order_type"
      expr: order_type
      comment: "Type of parts order (stock, emergency, special order, warranty)"
    - name: "backorder_flag"
      expr: backorder_flag
      comment: "Indicates whether the order contains backordered items"
    - name: "priority_flag"
      expr: priority_flag
      comment: "Indicates whether the order is marked as priority"
    - name: "shipping_method"
      expr: shipping_method
      comment: "Method used to ship the parts (ground, air, courier, pickup)"
    - name: "payment_terms"
      expr: payment_terms
      comment: "Payment terms for the parts order"
    - name: "freight_terms"
      expr: freight_terms
      comment: "Freight terms for the parts order (FOB, CIF, etc.)"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which the order was placed"
    - name: "order_year_month"
      expr: DATE_TRUNC('MONTH', order_timestamp)
      comment: "Month the parts order was placed"
    - name: "requested_delivery_year_month"
      expr: DATE_TRUNC('MONTH', requested_delivery_date)
      comment: "Month the parts were requested to be delivered"
  measures:
    - name: "total_parts_orders"
      expr: COUNT(1)
      comment: "Total number of parts orders placed"
    - name: "total_parts_order_value"
      expr: SUM(CAST(total_order_value AS DOUBLE))
      comment: "Total value of all parts orders, measuring parts procurement investment"
    - name: "avg_parts_order_value"
      expr: AVG(CAST(total_order_value AS DOUBLE))
      comment: "Average value per parts order"
    - name: "total_freight_cost"
      expr: SUM(CAST(freight_cost AS DOUBLE))
      comment: "Total freight cost across all parts orders"
    - name: "freight_cost_rate"
      expr: SUM(CAST(freight_cost AS DOUBLE)) / NULLIF(SUM(CAST(total_order_value AS DOUBLE)), 0)
      comment: "Freight cost as percentage of order value, measuring logistics efficiency"
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discounts received on parts orders"
    - name: "discount_rate"
      expr: SUM(CAST(discount_amount AS DOUBLE)) / NULLIF(SUM(CAST(total_order_value AS DOUBLE)) + SUM(CAST(discount_amount AS DOUBLE)), 0)
      comment: "Percentage discount received on parts orders, measuring procurement negotiation effectiveness"
    - name: "backorder_count"
      expr: SUM(CAST(CASE WHEN backorder_flag = TRUE THEN 1 ELSE 0 END AS INT))
      comment: "Number of parts orders with backordered items"
    - name: "backorder_rate"
      expr: SUM(CAST(CASE WHEN backorder_flag = TRUE THEN 1 ELSE 0 END AS INT)) / NULLIF(COUNT(1), 0)
      comment: "Percentage of orders with backorders, critical for service readiness and customer satisfaction"
    - name: "priority_order_count"
      expr: SUM(CAST(CASE WHEN priority_flag = TRUE THEN 1 ELSE 0 END AS INT))
      comment: "Number of priority parts orders"
    - name: "priority_order_rate"
      expr: SUM(CAST(CASE WHEN priority_flag = TRUE THEN 1 ELSE 0 END AS INT)) / NULLIF(COUNT(1), 0)
      comment: "Percentage of orders marked as priority, indicating urgency and planning effectiveness"
    - name: "delivered_order_count"
      expr: SUM(CAST(CASE WHEN order_status = 'delivered' THEN 1 ELSE 0 END AS INT))
      comment: "Number of parts orders successfully delivered"
    - name: "order_fulfillment_rate"
      expr: SUM(CAST(CASE WHEN order_status = 'delivered' THEN 1 ELSE 0 END AS INT)) / NULLIF(COUNT(1), 0)
      comment: "Percentage of orders successfully delivered, measuring supply chain reliability"
    - name: "unique_service_centers_ordering"
      expr: COUNT(DISTINCT service_center_id)
      comment: "Number of unique service centers placing parts orders"
    - name: "unique_fulfillment_warehouses"
      expr: COUNT(DISTINCT fulfillment_warehouse_id)
      comment: "Number of unique warehouses fulfilling parts orders"
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`aftersales_vehicle_warranty`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Vehicle warranty KPIs tracking warranty coverage, claims activity, transfer rates, and extended warranty penetration for revenue and risk management"
  source: "`vibe_automotive_v1`.`aftersales`.`vehicle_warranty`"
  dimensions:
    - name: "vehicle_warranty_status"
      expr: vehicle_warranty_status
      comment: "Current status of the vehicle warranty (active, expired, cancelled, transferred)"
    - name: "warranty_type"
      expr: warranty_type
      comment: "Type of warranty (basic, powertrain, extended, certified pre-owned)"
    - name: "program_category"
      expr: program_category
      comment: "Category of the warranty program"
    - name: "extended_warranty_flag"
      expr: extended_warranty_flag
      comment: "Indicates whether this is an extended warranty beyond the basic coverage"
    - name: "cpo_warranty_flag"
      expr: cpo_warranty_flag
      comment: "Indicates whether this is a certified pre-owned warranty"
    - name: "transfer_allowed"
      expr: transfer_allowed
      comment: "Indicates whether the warranty can be transferred to a new owner"
    - name: "renewal_flag"
      expr: renewal_flag
      comment: "Indicates whether the warranty is eligible for renewal"
    - name: "eligible_for_recall"
      expr: eligible_for_recall
      comment: "Indicates whether the vehicle is eligible for recall campaigns"
    - name: "coverage_area"
      expr: coverage_area
      comment: "Geographic area where the warranty is valid"
    - name: "start_year_month"
      expr: DATE_TRUNC('MONTH', start_date)
      comment: "Month the warranty coverage started"
    - name: "end_year_month"
      expr: DATE_TRUNC('MONTH', end_date)
      comment: "Month the warranty coverage ends"
  measures:
    - name: "total_warranties"
      expr: COUNT(1)
      comment: "Total number of vehicle warranties"
    - name: "active_warranties"
      expr: SUM(CAST(CASE WHEN vehicle_warranty_status = 'active' THEN 1 ELSE 0 END AS INT))
      comment: "Number of currently active vehicle warranties"
    - name: "extended_warranty_count"
      expr: SUM(CAST(CASE WHEN extended_warranty_flag = TRUE THEN 1 ELSE 0 END AS INT))
      comment: "Number of extended warranties sold"
    - name: "extended_warranty_penetration"
      expr: SUM(CAST(CASE WHEN extended_warranty_flag = TRUE THEN 1 ELSE 0 END AS INT)) / NULLIF(COUNT(1), 0)
      comment: "Percentage of vehicles with extended warranty, key revenue and customer retention metric"
    - name: "cpo_warranty_count"
      expr: SUM(CAST(CASE WHEN cpo_warranty_flag = TRUE THEN 1 ELSE 0 END AS INT))
      comment: "Number of certified pre-owned warranties"
    - name: "total_warranty_claims_amount"
      expr: SUM(CAST(warranty_claims_amount AS DOUBLE))
      comment: "Total amount paid out in warranty claims across all warranties"
    - name: "avg_warranty_claims_amount"
      expr: AVG(CAST(warranty_claims_amount AS DOUBLE))
      comment: "Average warranty claims amount per vehicle, measuring warranty cost exposure"
    - name: "total_transfer_fees"
      expr: SUM(CAST(transfer_fee AS DOUBLE))
      comment: "Total fees collected from warranty transfers"
    - name: "transferred_warranty_count"
      expr: SUM(CASE WHEN CAST(transfer_count AS INT) > 0 THEN 1 ELSE 0 END)
      comment: "Number of warranties that have been transferred to new owners"
    - name: "warranty_transfer_rate"
      expr: SUM(CASE WHEN CAST(transfer_count AS INT) > 0 THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0)
      comment: "Percentage of warranties transferred, indicating secondary market activity"
    - name: "renewable_warranty_count"
      expr: SUM(CAST(CASE WHEN renewal_flag = TRUE THEN 1 ELSE 0 END AS INT))
      comment: "Number of warranties eligible for renewal"
    - name: "recall_eligible_vehicle_count"
      expr: SUM(CAST(CASE WHEN eligible_for_recall = TRUE THEN 1 ELSE 0 END AS INT))
      comment: "Number of vehicles eligible for recall campaigns under warranty"
    - name: "unique_vehicles_under_warranty"
      expr: COUNT(DISTINCT vin_registry_id)
      comment: "Number of unique vehicles covered by warranty"
    - name: "unique_warranty_holders"
      expr: COUNT(DISTINCT party_id)
      comment: "Number of unique customers holding warranties"
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`aftersales_technician`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Technician workforce KPIs tracking headcount, certification levels, efficiency ratings, and capacity utilization for service operations planning"
  source: "`vibe_automotive_v1`.`aftersales`.`technician`"
  dimensions:
    - name: "technician_status"
      expr: technician_status
      comment: "Current employment status of the technician (active, inactive, on leave, terminated)"
    - name: "skill_level"
      expr: skill_level
      comment: "Skill level of the technician (apprentice, journeyman, master, senior master)"
    - name: "specialization"
      expr: specialization
      comment: "Technical specialization area (engine, transmission, electrical, ADAS, EV)"
    - name: "certification_level"
      expr: certification_level
      comment: "Certification level achieved by the technician"
    - name: "certification_type"
      expr: certification_type
      comment: "Type of certification held (ASE, manufacturer, EV, ADAS)"
    - name: "shift_type"
      expr: shift_type
      comment: "Shift type worked by the technician (day, evening, night, rotating)"
    - name: "overtime_eligible"
      expr: overtime_eligible
      comment: "Indicates whether the technician is eligible for overtime pay"
    - name: "availability_status"
      expr: availability_status
      comment: "Current availability status of the technician"
    - name: "hire_year"
      expr: YEAR(hire_date)
      comment: "Year the technician was hired"
  measures:
    - name: "total_technicians"
      expr: COUNT(1)
      comment: "Total number of technicians in the workforce"
    - name: "active_technicians"
      expr: SUM(CAST(CASE WHEN technician_status = 'active' THEN 1 ELSE 0 END AS INT))
      comment: "Number of currently active technicians, key capacity metric"
    - name: "avg_flat_rate_efficiency"
      expr: AVG(CAST(flat_rate_efficiency_rating AS DOUBLE))
      comment: "Average flat-rate efficiency rating across all technicians, measuring productivity"
    - name: "master_technician_count"
      expr: SUM(CASE WHEN skill_level IN ('master', 'senior master') THEN 1 ELSE 0 END)
      comment: "Number of master-level technicians"
    - name: "master_technician_rate"
      expr: SUM(CASE WHEN skill_level IN ('master', 'senior master') THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0)
      comment: "Percentage of technicians at master level, indicating workforce skill maturity"
    - name: "certified_technician_count"
      expr: SUM(CAST(CASE WHEN certification_level IS NOT NULL THEN 1 ELSE 0 END AS INT))
      comment: "Number of technicians with active certifications"
    - name: "certification_rate"
      expr: SUM(CAST(CASE WHEN certification_level IS NOT NULL THEN 1 ELSE 0 END AS INT)) / NULLIF(COUNT(1), 0)
      comment: "Percentage of technicians with certifications, measuring workforce quality"
    - name: "overtime_eligible_count"
      expr: SUM(CAST(CASE WHEN overtime_eligible = TRUE THEN 1 ELSE 0 END AS INT))
      comment: "Number of technicians eligible for overtime"
    - name: "avg_overtime_multiplier"
      expr: AVG(CAST(overtime_rate_multiplier AS DOUBLE))
      comment: "Average overtime rate multiplier across technicians"
    - name: "unique_service_centers"
      expr: COUNT(DISTINCT service_center_id)
      comment: "Number of unique service centers employing technicians"
    - name: "unique_dealerships"
      expr: COUNT(DISTINCT dealership_id)
      comment: "Number of unique dealerships employing technicians"
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`aftersales_service_center`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Service center facility KPIs tracking capacity, authorization levels, certification status, and operational throughput for network planning"
  source: "`vibe_automotive_v1`.`aftersales`.`service_center`"
  dimensions:
    - name: "service_center_type"
      expr: service_center_type
      comment: "Type of service center (dealership, independent, mobile, collision)"
    - name: "network_status"
      expr: network_status
      comment: "Status within the service network (active, inactive, pending, suspended)"
    - name: "authorization_level"
      expr: authorization_level
      comment: "Authorization level for service operations (basic, advanced, full)"
    - name: "warranty_authorized"
      expr: warranty_authorized
      comment: "Indicates whether the center is authorized to perform warranty work"
    - name: "recall_authorized"
      expr: recall_authorized
      comment: "Indicates whether the center is authorized to perform recall work"
    - name: "ev_certified"
      expr: ev_certified
      comment: "Indicates whether the center is certified for electric vehicle service"
    - name: "adas_calibration_authorized"
      expr: adas_calibration_authorized
      comment: "Indicates whether the center is authorized for ADAS calibration"
    - name: "collision_authorized"
      expr: collision_authorized
      comment: "Indicates whether the center is authorized for collision repair"
    - name: "iso9001_certified"
      expr: iso9001_certified
      comment: "Indicates whether the center holds ISO 9001 quality certification"
    - name: "iatf_certified"
      expr: iatf_certified
      comment: "Indicates whether the center holds IATF 16949 automotive quality certification"
    - name: "regulatory_status"
      expr: regulatory_status
      comment: "Regulatory compliance status of the service center"
    - name: "region"
      expr: region
      comment: "Geographic region where the service center is located"
    - name: "market"
      expr: market
      comment: "Market segment served by the service center"
    - name: "country"
      expr: country
      comment: "Country where the service center is located"
  measures:
    - name: "total_service_centers"
      expr: COUNT(1)
      comment: "Total number of service centers in the network"
    - name: "active_service_centers"
      expr: SUM(CAST(CASE WHEN network_status = 'active' THEN 1 ELSE 0 END AS INT))
      comment: "Number of active service centers, key network capacity metric"
    - name: "total_service_orders_processed"
      expr: SUM(CAST(service_orders_processed AS DOUBLE))
      comment: "Total service orders processed across all centers"
    - name: "avg_service_orders_per_center"
      expr: AVG(CAST(service_orders_processed AS DOUBLE))
      comment: "Average service orders processed per center, measuring throughput"
    - name: "total_warranty_claims_processed"
      expr: SUM(CAST(warranty_claims_processed AS DOUBLE))
      comment: "Total warranty claims processed across all centers"
    - name: "avg_warranty_claims_per_center"
      expr: AVG(CAST(warranty_claims_processed AS DOUBLE))
      comment: "Average warranty claims per center"
    - name: "avg_service_time_minutes"
      expr: AVG(CAST(average_service_time_minutes AS DOUBLE))
      comment: "Average service time in minutes across all centers, measuring operational efficiency"
    - name: "warranty_authorized_center_count"
      expr: SUM(CAST(CASE WHEN warranty_authorized = TRUE THEN 1 ELSE 0 END AS INT))
      comment: "Number of centers authorized for warranty work"
    - name: "warranty_authorization_rate"
      expr: SUM(CAST(CASE WHEN warranty_authorized = TRUE THEN 1 ELSE 0 END AS INT)) / NULLIF(COUNT(1), 0)
      comment: "Percentage of centers authorized for warranty work, measuring network capability"
    - name: "ev_certified_center_count"
      expr: SUM(CAST(CASE WHEN ev_certified = TRUE THEN 1 ELSE 0 END AS INT))
      comment: "Number of centers certified for electric vehicle service"
    - name: "ev_certification_rate"
      expr: SUM(CAST(CASE WHEN ev_certified = TRUE THEN 1 ELSE 0 END AS INT)) / NULLIF(COUNT(1), 0)
      comment: "Percentage of centers certified for EV service, critical for electrification strategy"
    - name: "adas_authorized_center_count"
      expr: SUM(CAST(CASE WHEN adas_calibration_authorized = TRUE THEN 1 ELSE 0 END AS INT))
      comment: "Number of centers authorized for ADAS calibration"
    - name: "adas_authorization_rate"
      expr: SUM(CAST(CASE WHEN adas_calibration_authorized = TRUE THEN 1 ELSE 0 END AS INT)) / NULLIF(COUNT(1), 0)
      comment: "Percentage of centers authorized for ADAS work, critical for advanced safety features"
    - name: "iso9001_certified_center_count"
      expr: SUM(CAST(CASE WHEN iso9001_certified = TRUE THEN 1 ELSE 0 END AS INT))
      comment: "Number of centers with ISO 9001 quality certification"
    - name: "iso9001_certification_rate"
      expr: SUM(CAST(CASE WHEN iso9001_certified = TRUE THEN 1 ELSE 0 END AS INT)) / NULLIF(COUNT(1), 0)
      comment: "Percentage of centers with ISO 9001 certification, measuring quality standards adherence"
    - name: "recall_authorized_center_count"
      expr: SUM(CAST(CASE WHEN recall_authorized = TRUE THEN 1 ELSE 0 END AS INT))
      comment: "Number of centers authorized for recall work"
    - name: "unique_dealerships"
      expr: COUNT(DISTINCT dealership_id)
      comment: "Number of unique dealerships operating service centers"
$$;