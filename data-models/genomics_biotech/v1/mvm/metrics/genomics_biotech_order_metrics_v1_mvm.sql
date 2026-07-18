-- Metric views for domain: order | Business: Genomics Biotech | Version: 1 | Generated on: 2026-05-06 15:25:46

CREATE OR REPLACE VIEW `genomics_biotech_ecm`.`_metrics`.`order_header`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core order-level KPIs tracking order volume, value, fulfillment performance, and regulatory compliance across sales channels and customer segments"
  source: "`genomics_biotech_ecm`.`order`.`header`"
  dimensions:
    - name: "order_status"
      expr: order_status
      comment: "Current status of the order (e.g., pending, confirmed, shipped, delivered, cancelled)"
    - name: "order_type"
      expr: order_type
      comment: "Type of order (e.g., standard, rush, research, clinical)"
    - name: "order_source_channel"
      expr: order_source_channel
      comment: "Channel through which the order was placed (e.g., web, direct sales, partner)"
    - name: "sales_organization"
      expr: sales_organization
      comment: "Sales organization responsible for the order"
    - name: "distribution_channel"
      expr: distribution_channel
      comment: "Distribution channel used for order fulfillment"
    - name: "division"
      expr: division
      comment: "Business division (e.g., sequencing, arrays, gene editing)"
    - name: "product_classification"
      expr: product_classification
      comment: "High-level product classification for the order"
    - name: "sla_tier"
      expr: sla_tier
      comment: "Service level agreement tier (e.g., standard, premium, enterprise)"
    - name: "order_year"
      expr: YEAR(order_date)
      comment: "Year the order was placed"
    - name: "order_month"
      expr: DATE_TRUNC('MONTH', order_date)
      comment: "Month the order was placed"
    - name: "order_quarter"
      expr: DATE_TRUNC('QUARTER', order_date)
      comment: "Quarter the order was placed"
    - name: "gxp_relevant_flag"
      expr: gxp_relevant_flag
      comment: "Whether the order is subject to GxP regulatory requirements"
    - name: "export_control_flag"
      expr: export_control_flag
      comment: "Whether the order is subject to export control regulations"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which the order is denominated"
  measures:
    - name: "total_order_count"
      expr: COUNT(1)
      comment: "Total number of orders placed"
    - name: "total_order_value"
      expr: SUM(CAST(total_order_value AS DOUBLE))
      comment: "Total gross merchandise value (GMV) of all orders"
    - name: "total_net_value"
      expr: SUM(CAST(total_net_value AS DOUBLE))
      comment: "Total net value of orders after discounts and adjustments"
    - name: "total_tax_amount"
      expr: SUM(CAST(total_tax_amount AS DOUBLE))
      comment: "Total tax collected on orders"
    - name: "avg_order_value"
      expr: AVG(CAST(total_order_value AS DOUBLE))
      comment: "Average order value (AOV) - key metric for customer spend behavior"
    - name: "distinct_customer_count"
      expr: COUNT(DISTINCT header_customer_account_id)
      comment: "Number of unique customers who placed orders"
    - name: "cancelled_order_count"
      expr: SUM(CASE WHEN order_status = 'Cancelled' THEN 1 ELSE 0 END)
      comment: "Number of orders that were cancelled"
    - name: "gxp_order_count"
      expr: SUM(CASE WHEN gxp_relevant_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of orders subject to GxP regulatory requirements"
    - name: "export_controlled_order_count"
      expr: SUM(CASE WHEN export_control_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of orders subject to export control regulations"
$$;


CREATE OR REPLACE VIEW `genomics_biotech_ecm`.`_metrics`.`order_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Line-item level KPIs for revenue analysis, product mix, fulfillment efficiency, and margin optimization"
  source: "`genomics_biotech_ecm`.`order`.`line`"
  dimensions:
    - name: "line_status"
      expr: line_status
      comment: "Current status of the order line (e.g., open, confirmed, shipped, delivered, cancelled)"
    - name: "item_category"
      expr: item_category
      comment: "Category of the line item (e.g., instrument, reagent, consumable, service)"
    - name: "regulatory_designation"
      expr: regulatory_designation
      comment: "Regulatory classification (e.g., RUO, IVD, CE-marked)"
    - name: "sequencing_service_type"
      expr: sequencing_service_type
      comment: "Type of sequencing service if applicable (e.g., WGS, RNA-Seq, targeted panel)"
    - name: "delivery_priority"
      expr: delivery_priority
      comment: "Priority level for delivery (e.g., standard, expedited, urgent)"
    - name: "hazmat_classification"
      expr: hazmat_classification
      comment: "Hazardous materials classification if applicable"
    - name: "temperature_requirement"
      expr: temperature_requirement
      comment: "Temperature storage/shipping requirement (e.g., ambient, refrigerated, frozen)"
    - name: "order_year"
      expr: YEAR(actual_ship_date)
      comment: "Year the line item was shipped"
    - name: "order_month"
      expr: DATE_TRUNC('MONTH', actual_ship_date)
      comment: "Month the line item was shipped"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which the line is priced"
  measures:
    - name: "total_line_count"
      expr: COUNT(1)
      comment: "Total number of order line items"
    - name: "total_line_value"
      expr: SUM(CAST(total_value AS DOUBLE))
      comment: "Total revenue from all order lines"
    - name: "total_net_value"
      expr: SUM(CAST(net_value AS DOUBLE))
      comment: "Total net value after discounts"
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discount amount given across all lines"
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax collected on order lines"
    - name: "avg_line_value"
      expr: AVG(CAST(total_value AS DOUBLE))
      comment: "Average value per order line"
    - name: "avg_discount_percentage"
      expr: AVG(CAST(discount_percentage AS DOUBLE))
      comment: "Average discount percentage applied to lines"
    - name: "total_ordered_quantity"
      expr: SUM(CAST(ordered_quantity AS DOUBLE))
      comment: "Total quantity of items ordered"
    - name: "total_delivered_quantity"
      expr: SUM(CAST(delivered_quantity AS DOUBLE))
      comment: "Total quantity of items delivered"
    - name: "total_open_quantity"
      expr: SUM(CAST(open_quantity AS DOUBLE))
      comment: "Total quantity still open/unfulfilled"
    - name: "cancelled_line_count"
      expr: SUM(CASE WHEN line_status = 'Cancelled' THEN 1 ELSE 0 END)
      comment: "Number of cancelled order lines"
    - name: "distinct_sku_count"
      expr: COUNT(DISTINCT sku_id)
      comment: "Number of unique SKUs ordered"
$$;


CREATE OR REPLACE VIEW `genomics_biotech_ecm`.`_metrics`.`order_delivery`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Delivery performance KPIs tracking on-time delivery, cold chain compliance, and logistics efficiency"
  source: "`genomics_biotech_ecm`.`order`.`delivery`"
  dimensions:
    - name: "delivery_status"
      expr: delivery_status
      comment: "Current status of the delivery (e.g., planned, in transit, delivered, failed)"
    - name: "delivery_type"
      expr: delivery_type
      comment: "Type of delivery (e.g., standard, express, cold chain)"
    - name: "shipment_method"
      expr: shipment_method
      comment: "Method of shipment (e.g., ground, air, courier)"
    - name: "carrier_name"
      expr: carrier_name
      comment: "Name of the shipping carrier"
    - name: "goods_issue_status"
      expr: goods_issue_status
      comment: "Status of goods issue from warehouse"
    - name: "cold_chain_required_flag"
      expr: cold_chain_required_flag
      comment: "Whether cold chain handling is required"
    - name: "dangerous_goods_flag"
      expr: dangerous_goods_flag
      comment: "Whether the delivery contains dangerous goods"
    - name: "packaging_type"
      expr: packaging_type
      comment: "Type of packaging used"
    - name: "delivery_year"
      expr: YEAR(actual_delivery_date)
      comment: "Year of actual delivery"
    - name: "delivery_month"
      expr: DATE_TRUNC('MONTH', actual_delivery_date)
      comment: "Month of actual delivery"
  measures:
    - name: "total_delivery_count"
      expr: COUNT(1)
      comment: "Total number of deliveries"
    - name: "completed_delivery_count"
      expr: SUM(CASE WHEN delivery_status = 'Delivered' THEN 1 ELSE 0 END)
      comment: "Number of successfully completed deliveries"
    - name: "failed_delivery_count"
      expr: SUM(CASE WHEN delivery_status = 'Failed' THEN 1 ELSE 0 END)
      comment: "Number of failed deliveries requiring investigation"
    - name: "cold_chain_delivery_count"
      expr: SUM(CASE WHEN cold_chain_required_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of deliveries requiring cold chain handling"
    - name: "dangerous_goods_delivery_count"
      expr: SUM(CASE WHEN dangerous_goods_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of deliveries containing dangerous goods"
    - name: "total_gross_weight_kg"
      expr: SUM(CAST(total_gross_weight_kg AS DOUBLE))
      comment: "Total gross weight shipped in kilograms"
    - name: "total_net_weight_kg"
      expr: SUM(CAST(total_net_weight_kg AS DOUBLE))
      comment: "Total net weight shipped in kilograms"
    - name: "avg_gross_weight_kg"
      expr: AVG(CAST(total_gross_weight_kg AS DOUBLE))
      comment: "Average gross weight per delivery"
    - name: "distinct_carrier_count"
      expr: COUNT(DISTINCT carrier_name)
      comment: "Number of unique carriers used"
$$;


CREATE OR REPLACE VIEW `genomics_biotech_ecm`.`_metrics`.`order_quotation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Quotation and sales pipeline KPIs tracking quote-to-order conversion, win rates, and pricing effectiveness"
  source: "`genomics_biotech_ecm`.`order`.`quotation`"
  dimensions:
    - name: "quotation_status"
      expr: quotation_status
      comment: "Current status of the quotation (e.g., draft, submitted, approved, rejected, converted)"
    - name: "quotation_type"
      expr: quotation_type
      comment: "Type of quotation (e.g., standard, custom, volume discount)"
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status for special pricing or terms"
    - name: "converted_to_order_flag"
      expr: converted_to_order_flag
      comment: "Whether the quotation was converted to an order"
    - name: "product_category"
      expr: product_category
      comment: "Product category being quoted"
    - name: "regulatory_classification"
      expr: regulatory_classification
      comment: "Regulatory classification of quoted products"
    - name: "discount_tier"
      expr: discount_tier
      comment: "Discount tier applied (e.g., standard, volume, strategic)"
    - name: "sales_organization_code"
      expr: sales_organization_code
      comment: "Sales organization responsible for the quote"
    - name: "distribution_channel_code"
      expr: distribution_channel_code
      comment: "Distribution channel for the quote"
    - name: "quotation_year"
      expr: YEAR(quotation_date)
      comment: "Year the quotation was created"
    - name: "quotation_month"
      expr: DATE_TRUNC('MONTH', quotation_date)
      comment: "Month the quotation was created"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which the quotation is denominated"
  measures:
    - name: "total_quotation_count"
      expr: COUNT(1)
      comment: "Total number of quotations issued"
    - name: "converted_quotation_count"
      expr: SUM(CASE WHEN converted_to_order_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of quotations converted to orders"
    - name: "total_quoted_value"
      expr: SUM(CAST(total_quoted_value AS DOUBLE))
      comment: "Total value of all quotations issued"
    - name: "total_net_quoted_value"
      expr: SUM(CAST(net_quoted_value AS DOUBLE))
      comment: "Total net quoted value after discounts"
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discount amount offered in quotations"
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax on quotations"
    - name: "avg_quotation_value"
      expr: AVG(CAST(total_quoted_value AS DOUBLE))
      comment: "Average value per quotation"
    - name: "distinct_customer_count"
      expr: COUNT(DISTINCT account_id)
      comment: "Number of unique customers receiving quotations"
    - name: "rejected_quotation_count"
      expr: SUM(CASE WHEN quotation_status = 'Rejected' THEN 1 ELSE 0 END)
      comment: "Number of quotations rejected by customers"
    - name: "approval_required_count"
      expr: SUM(CASE WHEN approval_required_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of quotations requiring special approval"
$$;


CREATE OR REPLACE VIEW `genomics_biotech_ecm`.`_metrics`.`order_return_authorization`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Product return and quality KPIs tracking return rates, root causes, and financial impact of returns"
  source: "`genomics_biotech_ecm`.`order`.`return_authorization`"
  dimensions:
    - name: "return_status"
      expr: return_status
      comment: "Current status of the return authorization (e.g., requested, approved, received, credited)"
    - name: "return_reason_code"
      expr: return_reason_code
      comment: "Coded reason for the return"
    - name: "return_reason_description"
      expr: return_reason_description
      comment: "Detailed description of return reason"
    - name: "root_cause_category"
      expr: root_cause_category
      comment: "Root cause category (e.g., manufacturing defect, shipping damage, customer error)"
    - name: "disposition_code"
      expr: disposition_code
      comment: "Disposition of returned goods (e.g., scrap, rework, resale)"
    - name: "capa_required_flag"
      expr: capa_required_flag
      comment: "Whether corrective and preventive action (CAPA) is required"
    - name: "gmp_deviation_flag"
      expr: gmp_deviation_flag
      comment: "Whether the return involves a GMP deviation"
    - name: "temperature_excursion_flag"
      expr: temperature_excursion_flag
      comment: "Whether a temperature excursion occurred"
    - name: "return_year"
      expr: YEAR(return_requested_date)
      comment: "Year the return was requested"
    - name: "return_month"
      expr: DATE_TRUNC('MONTH', return_requested_date)
      comment: "Month the return was requested"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency for return value"
  measures:
    - name: "total_return_count"
      expr: COUNT(1)
      comment: "Total number of return authorizations"
    - name: "total_return_value"
      expr: SUM(CAST(return_value_amount AS DOUBLE))
      comment: "Total financial value of returns"
    - name: "total_return_quantity"
      expr: SUM(CAST(return_quantity AS DOUBLE))
      comment: "Total quantity of items returned"
    - name: "total_restocking_fee"
      expr: SUM(CAST(restocking_fee_amount AS DOUBLE))
      comment: "Total restocking fees collected"
    - name: "total_return_shipping_cost"
      expr: SUM(CAST(return_shipping_cost AS DOUBLE))
      comment: "Total cost of return shipping"
    - name: "avg_return_value"
      expr: AVG(CAST(return_value_amount AS DOUBLE))
      comment: "Average value per return"
    - name: "capa_required_count"
      expr: SUM(CASE WHEN capa_required_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of returns requiring CAPA"
    - name: "gmp_deviation_count"
      expr: SUM(CASE WHEN gmp_deviation_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of returns involving GMP deviations"
    - name: "temperature_excursion_count"
      expr: SUM(CASE WHEN temperature_excursion_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of returns due to temperature excursions"
    - name: "distinct_customer_count"
      expr: COUNT(DISTINCT account_id)
      comment: "Number of unique customers with returns"
$$;


CREATE OR REPLACE VIEW `genomics_biotech_ecm`.`_metrics`.`order_credit_memo`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Credit memo and revenue reversal KPIs tracking refunds, adjustments, and financial impact of credits"
  source: "`genomics_biotech_ecm`.`order`.`credit_memo`"
  dimensions:
    - name: "credit_memo_type"
      expr: credit_memo_type
      comment: "Type of credit memo (e.g., return, price adjustment, goodwill)"
    - name: "credit_reason_code"
      expr: credit_reason_code
      comment: "Coded reason for the credit"
    - name: "credit_reason_description"
      expr: credit_reason_description
      comment: "Detailed description of credit reason"
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the credit memo"
    - name: "refund_status"
      expr: refund_status
      comment: "Status of refund processing"
    - name: "revenue_reversal_flag"
      expr: revenue_reversal_flag
      comment: "Whether the credit results in revenue reversal"
    - name: "payment_method"
      expr: payment_method
      comment: "Method of refund payment"
    - name: "sales_organization"
      expr: sales_organization
      comment: "Sales organization issuing the credit"
    - name: "distribution_channel"
      expr: distribution_channel
      comment: "Distribution channel for the credit"
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the credit memo"
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period of the credit memo"
    - name: "issue_year"
      expr: YEAR(issue_date)
      comment: "Year the credit memo was issued"
    - name: "issue_month"
      expr: DATE_TRUNC('MONTH', issue_date)
      comment: "Month the credit memo was issued"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the credit memo"
  measures:
    - name: "total_credit_memo_count"
      expr: COUNT(1)
      comment: "Total number of credit memos issued"
    - name: "total_credit_amount"
      expr: SUM(CAST(total_credit_amount AS DOUBLE))
      comment: "Total value of all credits issued"
    - name: "total_credit_base_amount"
      expr: SUM(CAST(credit_amount AS DOUBLE))
      comment: "Total base credit amount before tax"
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount on credits"
    - name: "avg_credit_amount"
      expr: AVG(CAST(total_credit_amount AS DOUBLE))
      comment: "Average credit amount per memo"
    - name: "revenue_reversal_count"
      expr: SUM(CASE WHEN revenue_reversal_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of credits resulting in revenue reversal"
    - name: "distinct_customer_count"
      expr: COUNT(DISTINCT account_id)
      comment: "Number of unique customers receiving credits"
$$;


CREATE OR REPLACE VIEW `genomics_biotech_ecm`.`_metrics`.`order_shipment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Shipment performance KPIs tracking carrier SLA compliance, cold chain integrity, and logistics costs"
  source: "`genomics_biotech_ecm`.`order`.`shipment`"
  dimensions:
    - name: "shipment_status"
      expr: shipment_status
      comment: "Current status of the shipment (e.g., pending, in transit, delivered, exception)"
    - name: "shipment_method"
      expr: shipment_method
      comment: "Method of shipment (e.g., ground, air, express)"
    - name: "carrier_name"
      expr: carrier_name
      comment: "Name of the shipping carrier"
    - name: "tat_compliance_status"
      expr: tat_compliance_status
      comment: "Turnaround time compliance status (e.g., on time, late, early)"
    - name: "carrier_sla_breach_flag"
      expr: carrier_sla_breach_flag
      comment: "Whether the carrier breached SLA"
    - name: "cold_chain_required_flag"
      expr: cold_chain_required_flag
      comment: "Whether cold chain handling is required"
    - name: "temperature_excursion_flag"
      expr: temperature_excursion_flag
      comment: "Whether a temperature excursion occurred during shipment"
    - name: "hazmat_flag"
      expr: hazmat_flag
      comment: "Whether the shipment contains hazardous materials"
    - name: "hazmat_class"
      expr: hazmat_class
      comment: "Hazmat classification if applicable"
    - name: "ship_year"
      expr: YEAR(ship_date)
      comment: "Year the shipment was dispatched"
    - name: "ship_month"
      expr: DATE_TRUNC('MONTH', ship_date)
      comment: "Month the shipment was dispatched"
    - name: "freight_cost_currency_code"
      expr: freight_cost_currency_code
      comment: "Currency for freight costs"
  measures:
    - name: "total_shipment_count"
      expr: COUNT(1)
      comment: "Total number of shipments"
    - name: "delivered_shipment_count"
      expr: SUM(CASE WHEN shipment_status = 'Delivered' THEN 1 ELSE 0 END)
      comment: "Number of successfully delivered shipments"
    - name: "sla_breach_count"
      expr: SUM(CASE WHEN carrier_sla_breach_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of shipments with carrier SLA breaches"
    - name: "temperature_excursion_count"
      expr: SUM(CASE WHEN temperature_excursion_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of shipments with temperature excursions"
    - name: "cold_chain_shipment_count"
      expr: SUM(CASE WHEN cold_chain_required_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of shipments requiring cold chain"
    - name: "hazmat_shipment_count"
      expr: SUM(CASE WHEN hazmat_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of shipments containing hazardous materials"
    - name: "total_freight_cost"
      expr: SUM(CAST(freight_cost_amount AS DOUBLE))
      comment: "Total freight cost across all shipments"
    - name: "total_insurance_value"
      expr: SUM(CAST(insurance_value_amount AS DOUBLE))
      comment: "Total insurance value of shipments"
    - name: "total_weight_kg"
      expr: SUM(CAST(total_weight_kg AS DOUBLE))
      comment: "Total weight shipped in kilograms"
    - name: "total_volume_cubic_meters"
      expr: SUM(CAST(total_volume_cubic_meters AS DOUBLE))
      comment: "Total volume shipped in cubic meters"
    - name: "avg_freight_cost"
      expr: AVG(CAST(freight_cost_amount AS DOUBLE))
      comment: "Average freight cost per shipment"
    - name: "distinct_carrier_count"
      expr: COUNT(DISTINCT carrier_name)
      comment: "Number of unique carriers used"
$$;


CREATE OR REPLACE VIEW `genomics_biotech_ecm`.`_metrics`.`order_status_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Order lifecycle event KPIs tracking status transitions, SLA compliance, and operational bottlenecks"
  source: "`genomics_biotech_ecm`.`order`.`status_event`"
  dimensions:
    - name: "new_status"
      expr: new_status
      comment: "New status after the event"
    - name: "previous_status"
      expr: previous_status
      comment: "Previous status before the event"
    - name: "status_change_reason_code"
      expr: status_change_reason_code
      comment: "Coded reason for the status change"
    - name: "order_type"
      expr: order_type
      comment: "Type of order"
    - name: "order_priority"
      expr: order_priority
      comment: "Priority level of the order"
    - name: "sla_breach_flag"
      expr: sla_breach_flag
      comment: "Whether the event represents an SLA breach"
    - name: "sla_breach_severity"
      expr: sla_breach_severity
      comment: "Severity of SLA breach if applicable"
    - name: "sla_milestone_flag"
      expr: sla_milestone_flag
      comment: "Whether the event is an SLA milestone"
    - name: "sla_milestone_name"
      expr: sla_milestone_name
      comment: "Name of the SLA milestone"
    - name: "is_reversal_flag"
      expr: is_reversal_flag
      comment: "Whether the event is a reversal/correction"
    - name: "notification_sent_flag"
      expr: notification_sent_flag
      comment: "Whether customer notification was sent"
    - name: "sales_organization"
      expr: sales_organization
      comment: "Sales organization"
    - name: "distribution_channel"
      expr: distribution_channel
      comment: "Distribution channel"
    - name: "event_year"
      expr: YEAR(event_timestamp)
      comment: "Year of the status event"
    - name: "event_month"
      expr: DATE_TRUNC('MONTH', event_timestamp)
      comment: "Month of the status event"
  measures:
    - name: "total_event_count"
      expr: COUNT(1)
      comment: "Total number of status change events"
    - name: "sla_breach_count"
      expr: SUM(CASE WHEN sla_breach_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of events representing SLA breaches"
    - name: "sla_milestone_count"
      expr: SUM(CASE WHEN sla_milestone_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of SLA milestone events"
    - name: "reversal_event_count"
      expr: SUM(CASE WHEN is_reversal_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of reversal/correction events"
    - name: "notification_sent_count"
      expr: SUM(CASE WHEN notification_sent_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of events with customer notifications sent"
    - name: "avg_tat_elapsed_hours"
      expr: AVG(CAST(tat_elapsed_hours AS DOUBLE))
      comment: "Average turnaround time elapsed in hours"
    - name: "avg_tat_target_hours"
      expr: AVG(CAST(tat_target_hours AS DOUBLE))
      comment: "Average target turnaround time in hours"
    - name: "total_tat_elapsed_hours"
      expr: SUM(CAST(tat_elapsed_hours AS DOUBLE))
      comment: "Total turnaround time elapsed across all events"
    - name: "distinct_order_count"
      expr: COUNT(DISTINCT header_id)
      comment: "Number of unique orders with status events"
$$;
