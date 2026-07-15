-- Metric views for domain: interconnect | Business: Telecommunication | Version: 1 | Generated on: 2026-05-08 05:01:11

CREATE OR REPLACE VIEW `telecommunication_ecm`.`_metrics`.`interconnect_settlement_invoice`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Financial performance of settlement invoices"
  source: "`telecommunication_ecm`.`interconnect`.`settlement_invoice`"
  dimensions:
    - name: "carrier_id"
      expr: carrier_id
      comment: "Carrier associated with the invoice"
    - name: "carrier_agreement_id"
      expr: carrier_agreement_id
      comment: "Carrier agreement linked to the invoice"
    - name: "invoice_status"
      expr: invoice_status
      comment: "Current status of the invoice (e.g., Paid, Pending)"
    - name: "invoice_type"
      expr: invoice_type
      comment: "Classification of the invoice (e.g., Regular, Adjustment)"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which the invoice is issued"
    - name: "invoice_date"
      expr: invoice_date
      comment: "Date the invoice was generated"
  measures:
    - name: "invoice_count"
      expr: COUNT(1)
      comment: "Total number of settlement invoices"
    - name: "total_gross_amount"
      expr: SUM(CAST(gross_amount AS DOUBLE))
      comment: "Sum of gross invoice amounts"
    - name: "total_net_payable_amount"
      expr: SUM(CAST(net_payable_amount AS DOUBLE))
      comment: "Sum of net payable amounts across invoices"
    - name: "total_paid_amount"
      expr: SUM(CAST(paid_amount AS DOUBLE))
      comment: "Sum of amounts that have been paid"
    - name: "average_gross_amount"
      expr: AVG(CAST(gross_amount AS DOUBLE))
      comment: "Average gross amount per invoice"
    - name: "average_days_past_due"
      expr: AVG(DATEDIFF(current_date(), due_date))
      comment: "Average number of days invoices are past their due date"
$$;


CREATE OR REPLACE VIEW `telecommunication_ecm`.`_metrics`.`interconnect_carrier_agreement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Key contract‑level KPIs for carrier agreements"
  source: "`telecommunication_ecm`.`interconnect`.`carrier_agreement`"
  dimensions:
    - name: "partner_id"
      expr: partner_id
      comment: "Partner involved in the agreement"
    - name: "agreement_status"
      expr: agreement_status
      comment: "Current status of the agreement (e.g., Active, Terminated)"
    - name: "agreement_type"
      expr: agreement_type
      comment: "Type of agreement (e.g., Fixed, Variable)"
    - name: "effective_from_date"
      expr: effective_from_date
      comment: "Date the agreement becomes effective"
    - name: "effective_until_date"
      expr: effective_until_date
      comment: "Date the agreement expires"
    - name: "settlement_currency_code"
      expr: settlement_currency_code
      comment: "Currency used for settlement"
  measures:
    - name: "agreement_count"
      expr: COUNT(1)
      comment: "Total number of carrier agreements"
    - name: "average_discount_percentage"
      expr: AVG(CAST(discount_percentage AS DOUBLE))
      comment: "Average discount percentage across agreements"
    - name: "average_revenue_share_percentage"
      expr: AVG(CAST(revenue_share_percentage AS DOUBLE))
      comment: "Average revenue‑share percentage across agreements"
    - name: "total_min_volume_commitment"
      expr: SUM(CAST(min_volume_commitment_units AS DOUBLE))
      comment: "Total minimum volume commitment units"
$$;


CREATE OR REPLACE VIEW `telecommunication_ecm`.`_metrics`.`interconnect_tap_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core usage and revenue metrics derived from TAP records"
  source: "`telecommunication_ecm`.`interconnect`.`tap_record`"
  dimensions:
    - name: "carrier_agreement_id"
      expr: carrier_agreement_id
      comment: "Carrier agreement linked to the TAP record"
    - name: "tap_file_id"
      expr: tap_file_id
      comment: "Identifier of the source TAP file"
    - name: "carrier_id"
      expr: carrier_id
      comment: "Carrier that was visited during the event"
    - name: "call_event_type"
      expr: call_event_type
      comment: "Type of call event (e.g., Voice, SMS)"
    - name: "service_code"
      expr: service_code
      comment: "Service code associated with the record"
  measures:
    - name: "tap_record_count"
      expr: COUNT(1)
      comment: "Total number of TAP records processed"
    - name: "total_charged_amount"
      expr: SUM(CAST(charged_amount AS DOUBLE))
      comment: "Sum of charged amounts across all TAP records"
    - name: "total_data_downlink_kb"
      expr: SUM(CAST(data_volume_downlink_kb AS DOUBLE))
      comment: "Total downlink data volume in kilobytes"
    - name: "total_data_uplink_kb"
      expr: SUM(CAST(data_volume_uplink_kb AS DOUBLE))
      comment: "Total uplink data volume in kilobytes"
    - name: "average_charged_amount"
      expr: AVG(CAST(charged_amount AS DOUBLE))
      comment: "Average charge per TAP record"
    - name: "distinct_subscriber_count"
      expr: COUNT(DISTINCT msisdn)
      comment: "Number of unique subscribers (MSISDN) in the TAP data"
$$;


CREATE OR REPLACE VIEW `telecommunication_ecm`.`_metrics`.`interconnect_transit_traffic_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Financial and volume KPIs for inter‑carrier transit traffic"
  source: "`telecommunication_ecm`.`interconnect`.`transit_traffic_record`"
  dimensions:
    - name: "carrier_agreement_id"
      expr: carrier_agreement_id
      comment: "Carrier agreement governing the transit"
    - name: "carrier_id"
      expr: carrier_id
      comment: "Carrier that originated the traffic"
    - name: "traffic_type"
      expr: traffic_type
      comment: "Classification of traffic (e.g., Voice, Data)"
    - name: "billing_period"
      expr: billing_period
      comment: "Billing period identifier"
  measures:
    - name: "transit_record_count"
      expr: COUNT(1)
      comment: "Total number of transit traffic records"
    - name: "total_gross_billed_amount"
      expr: SUM(CAST(gross_billed_amount AS DOUBLE))
      comment: "Sum of gross billed amounts for transit traffic"
    - name: "total_net_settlement_amount"
      expr: SUM(CAST(net_settlement_amount AS DOUBLE))
      comment: "Sum of net settlement amounts"
    - name: "total_data_volume_kb"
      expr: SUM(CAST(data_volume_kb AS DOUBLE))
      comment: "Total data volume in kilobytes for transit traffic"
    - name: "average_gross_billed_amount"
      expr: AVG(CAST(gross_billed_amount AS DOUBLE))
      comment: "Average gross billed amount per transit record"
$$;


CREATE OR REPLACE VIEW `telecommunication_ecm`.`_metrics`.`interconnect_peering_arrangement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Performance and capacity KPIs for peering arrangements"
  source: "`telecommunication_ecm`.`interconnect`.`peering_arrangement`"
  dimensions:
    - name: "carrier_id"
      expr: carrier_id
      comment: "Carrier on the opposite side of the peering"
    - name: "location_site_id"
      expr: location_site_id
      comment: "Site where the peering is located"
    - name: "peering_type"
      expr: peering_type
      comment: "Type of peering (e.g., Public, Private)"
    - name: "ip_version"
      expr: ip_version
      comment: "IP version used (IPv4/IPv6)"
    - name: "traffic_direction"
      expr: traffic_direction
      comment: "Direction of traffic (Inbound/Outbound)"
  measures:
    - name: "peering_arrangement_count"
      expr: COUNT(1)
      comment: "Total number of peering arrangements"
    - name: "total_committed_bandwidth_mbps"
      expr: SUM(CAST(committed_bandwidth_mbps AS DOUBLE))
      comment: "Sum of committed bandwidth across all peering arrangements"
    - name: "average_latency_target_ms"
      expr: AVG(CAST(latency_target_ms AS DOUBLE))
      comment: "Average latency target in milliseconds"
    - name: "average_availability_target_pct"
      expr: AVG(CAST(availability_target_pct AS DOUBLE))
      comment: "Average availability target percentage"
    - name: "average_packet_loss_target_pct"
      expr: AVG(CAST(packet_loss_target_pct AS DOUBLE))
      comment: "Average packet‑loss target percentage"
$$;
