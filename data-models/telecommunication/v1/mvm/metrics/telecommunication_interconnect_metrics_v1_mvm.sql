-- Metric views for domain: interconnect | Business: Telecommunication | Version: 1 | Generated on: 2026-05-08 08:27:22

CREATE OR REPLACE VIEW `telecommunication_ecm`.`_metrics`.`interconnect_settlement_invoice`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core settlement and billing KPIs for interconnect invoices, tracking revenue, payment performance, and dispute exposure across carrier agreements"
  source: "`telecommunication_ecm`.`interconnect`.`settlement_invoice`"
  dimensions:
    - name: "invoice_status"
      expr: invoice_status
      comment: "Current status of the settlement invoice (e.g., draft, approved, disputed, paid)"
    - name: "invoice_type"
      expr: invoice_type
      comment: "Type of settlement invoice (e.g., roaming, interconnect, peering)"
    - name: "payment_status"
      expr: payment_status
      comment: "Payment status of the invoice (e.g., pending, paid, overdue)"
    - name: "carrier_country"
      expr: carrier_country_code
      comment: "Country code of the carrier being invoiced"
    - name: "traffic_type"
      expr: traffic_type
      comment: "Type of traffic covered by the invoice (e.g., voice, data, SMS)"
    - name: "billing_period_month"
      expr: DATE_TRUNC('MONTH', billing_period_start_date)
      comment: "Month of the billing period start date"
    - name: "invoice_month"
      expr: DATE_TRUNC('MONTH', invoice_date)
      comment: "Month when the invoice was issued"
    - name: "currency"
      expr: currency_code
      comment: "Currency in which the invoice is denominated"
    - name: "netting_flag"
      expr: netting_flag
      comment: "Indicates whether netting was applied to this invoice"
  measures:
    - name: "total_invoice_count"
      expr: COUNT(1)
      comment: "Total number of settlement invoices"
    - name: "total_gross_amount"
      expr: SUM(CAST(gross_amount AS DOUBLE))
      comment: "Total gross amount billed across all invoices before adjustments"
    - name: "total_net_payable"
      expr: SUM(CAST(net_payable_amount AS DOUBLE))
      comment: "Total net payable amount after all adjustments, discounts, and taxes"
    - name: "total_disputed_amount"
      expr: SUM(CAST(disputed_amount AS DOUBLE))
      comment: "Total amount currently under dispute across all invoices"
    - name: "total_paid_amount"
      expr: SUM(CAST(paid_amount AS DOUBLE))
      comment: "Total amount actually paid by carriers"
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount levied across all invoices"
    - name: "avg_invoice_value"
      expr: AVG(CAST(net_payable_amount AS DOUBLE))
      comment: "Average net payable amount per invoice"
    - name: "dispute_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(disputed_amount AS DOUBLE)) / NULLIF(SUM(CAST(gross_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of gross amount that is disputed, indicating settlement quality"
    - name: "collection_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(paid_amount AS DOUBLE)) / NULLIF(SUM(CAST(net_payable_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of net payable amount that has been collected, measuring payment effectiveness"
    - name: "total_usage_minutes"
      expr: SUM(CAST(total_usage_minutes AS DOUBLE))
      comment: "Total voice usage minutes covered by invoices"
    - name: "total_data_volume_mb"
      expr: SUM(CAST(total_data_volume_mb AS DOUBLE))
      comment: "Total data volume in megabytes covered by invoices"
    - name: "total_sms_count"
      expr: SUM(CAST(total_sms_count AS BIGINT))
      comment: "Total SMS message count covered by invoices"
    - name: "total_cdr_count"
      expr: SUM(CAST(total_cdr_count AS BIGINT))
      comment: "Total call detail record count processed across all invoices"
    - name: "avg_revenue_per_minute"
      expr: ROUND(SUM(CAST(net_payable_amount AS DOUBLE)) / NULLIF(SUM(CAST(total_usage_minutes AS DOUBLE)), 0), 4)
      comment: "Average revenue per voice minute, key pricing effectiveness metric"
    - name: "avg_revenue_per_mb"
      expr: ROUND(SUM(CAST(net_payable_amount AS DOUBLE)) / NULLIF(SUM(CAST(total_data_volume_mb AS DOUBLE)), 0), 4)
      comment: "Average revenue per megabyte of data, key data pricing metric"
$$;


CREATE OR REPLACE VIEW `telecommunication_ecm`.`_metrics`.`interconnect_tap_file`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "TAP file processing and quality KPIs, tracking file exchange performance, validation success, and reconciliation status for roaming data interchange"
  source: "`telecommunication_ecm`.`interconnect`.`tap_file`"
  dimensions:
    - name: "file_status"
      expr: file_status
      comment: "Current processing status of the TAP file"
    - name: "file_type"
      expr: file_type
      comment: "Type of TAP file (e.g., TAP3, RAP)"
    - name: "roaming_direction"
      expr: roaming_direction
      comment: "Direction of roaming traffic (inbound or outbound)"
    - name: "processing_outcome"
      expr: processing_outcome
      comment: "Outcome of file processing (e.g., success, failed, partial)"
    - name: "reconciliation_status"
      expr: reconciliation_status
      comment: "Reconciliation status with settlement invoices"
    - name: "network_type"
      expr: network_type
      comment: "Network technology type (e.g., 4G, 5G)"
    - name: "tap_version"
      expr: tap_version
      comment: "TAP specification version used"
    - name: "is_test_file"
      expr: is_test_file
      comment: "Indicates whether this is a test file"
    - name: "file_creation_month"
      expr: DATE_TRUNC('MONTH', file_creation_timestamp)
      comment: "Month when the TAP file was created"
    - name: "receipt_month"
      expr: DATE_TRUNC('MONTH', receipt_timestamp)
      comment: "Month when the TAP file was received"
  measures:
    - name: "total_tap_files"
      expr: COUNT(1)
      comment: "Total number of TAP files processed"
    - name: "total_file_size_gb"
      expr: ROUND(SUM(CAST(file_size_bytes AS DOUBLE)) / 1073741824.0, 2)
      comment: "Total size of all TAP files in gigabytes"
    - name: "total_charge_amount"
      expr: SUM(CAST(total_charge_amount AS DOUBLE))
      comment: "Total charge amount across all TAP files"
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount across all TAP files"
    - name: "avg_file_size_mb"
      expr: ROUND(AVG(CAST(file_size_bytes AS DOUBLE)) / 1048576.0, 2)
      comment: "Average TAP file size in megabytes"
    - name: "avg_charge_per_file"
      expr: AVG(CAST(total_charge_amount AS DOUBLE))
      comment: "Average charge amount per TAP file"
    - name: "file_success_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN processing_outcome = 'success' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of TAP files successfully processed, key quality metric"
    - name: "reconciliation_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN reconciliation_status = 'reconciled' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of TAP files successfully reconciled with invoices"
    - name: "avg_processing_time_hours"
      expr: ROUND(AVG(CAST((UNIX_TIMESTAMP(acknowledgement_timestamp) - UNIX_TIMESTAMP(receipt_timestamp)) AS DOUBLE)) / 3600.0, 2)
      comment: "Average time in hours from receipt to acknowledgement, measuring processing efficiency"
    - name: "distinct_sender_carriers"
      expr: COUNT(DISTINCT carrier_id)
      comment: "Number of unique carrier partners sending TAP files"
$$;


CREATE OR REPLACE VIEW `telecommunication_ecm`.`_metrics`.`interconnect_settlement_dispute`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Settlement dispute management KPIs, tracking dispute volume, resolution performance, and financial exposure across carrier relationships"
  source: "`telecommunication_ecm`.`interconnect`.`settlement_dispute`"
  dimensions:
    - name: "dispute_status"
      expr: dispute_status
      comment: "Current status of the dispute (e.g., open, resolved, escalated)"
    - name: "dispute_type"
      expr: dispute_type
      comment: "Type of dispute (e.g., rating, volume, fraud)"
    - name: "dispute_category"
      expr: dispute_category
      comment: "Category of the dispute for classification"
    - name: "dispute_direction"
      expr: dispute_direction
      comment: "Direction of dispute (raised by us or by carrier)"
    - name: "resolution_type"
      expr: resolution_type
      comment: "Type of resolution applied (e.g., credit note, adjustment, rejected)"
    - name: "priority"
      expr: priority
      comment: "Priority level of the dispute"
    - name: "is_sla_breached"
      expr: is_sla_breached
      comment: "Indicates whether SLA for dispute resolution was breached"
    - name: "traffic_type"
      expr: traffic_type
      comment: "Type of traffic involved in the dispute"
    - name: "raised_month"
      expr: DATE_TRUNC('MONTH', raised_date)
      comment: "Month when the dispute was raised"
    - name: "resolution_month"
      expr: DATE_TRUNC('MONTH', resolution_date)
      comment: "Month when the dispute was resolved"
  measures:
    - name: "total_disputes"
      expr: COUNT(1)
      comment: "Total number of settlement disputes"
    - name: "total_disputed_amount"
      expr: SUM(CAST(disputed_amount AS DOUBLE))
      comment: "Total amount under dispute across all cases"
    - name: "total_invoiced_amount"
      expr: SUM(CAST(invoiced_amount AS DOUBLE))
      comment: "Total originally invoiced amount for disputed items"
    - name: "total_accepted_amount"
      expr: SUM(CAST(accepted_amount AS DOUBLE))
      comment: "Total amount accepted after dispute resolution"
    - name: "total_resolution_amount"
      expr: SUM(CAST(resolution_amount AS DOUBLE))
      comment: "Total final resolution amount after all adjustments"
    - name: "avg_disputed_amount"
      expr: AVG(CAST(disputed_amount AS DOUBLE))
      comment: "Average disputed amount per case"
    - name: "dispute_resolution_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN dispute_status = 'resolved' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of disputes that have been resolved, measuring dispute management effectiveness"
    - name: "sla_breach_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_sla_breached = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of disputes that breached SLA, indicating process quality"
    - name: "dispute_win_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(accepted_amount AS DOUBLE)) / NULLIF(SUM(CAST(disputed_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of disputed amount that was accepted, measuring dispute success rate"
    - name: "avg_resolution_time_days"
      expr: ROUND(AVG(CAST(DATEDIFF(resolution_date, raised_date) AS DOUBLE)), 1)
      comment: "Average number of days to resolve a dispute, key efficiency metric"
    - name: "dispute_rate_vs_invoice_pct"
      expr: ROUND(100.0 * SUM(CAST(disputed_amount AS DOUBLE)) / NULLIF(SUM(CAST(invoiced_amount AS DOUBLE)), 0), 2)
      comment: "Disputed amount as percentage of invoiced amount, measuring billing quality"
    - name: "distinct_disputed_carriers"
      expr: COUNT(DISTINCT carrier_id)
      comment: "Number of unique carriers involved in disputes"
$$;


CREATE OR REPLACE VIEW `telecommunication_ecm`.`_metrics`.`interconnect_mnp_transaction`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Mobile Number Portability transaction KPIs, tracking porting volume, success rates, and operational efficiency for number portability operations"
  source: "`telecommunication_ecm`.`interconnect`.`mnp_transaction`"
  dimensions:
    - name: "port_status"
      expr: port_status
      comment: "Current status of the porting transaction"
    - name: "port_type"
      expr: port_type
      comment: "Type of port (e.g., port-in, port-out)"
    - name: "service_type"
      expr: service_type
      comment: "Type of service being ported"
    - name: "network_generation"
      expr: network_generation
      comment: "Network generation (e.g., 4G, 5G)"
    - name: "fraud_check_status"
      expr: fraud_check_status
      comment: "Status of fraud verification check"
    - name: "hlr_update_status"
      expr: hlr_hss_update_status
      comment: "Status of HLR/HSS update"
    - name: "routing_update_status"
      expr: routing_number_update_status
      comment: "Status of routing number update"
    - name: "sla_breach_flag"
      expr: sla_breach_flag
      comment: "Indicates whether porting SLA was breached"
    - name: "subscriber_consent_verified"
      expr: subscriber_consent_verified
      comment: "Indicates whether subscriber consent was verified"
    - name: "country"
      expr: country_code
      comment: "Country where the port occurred"
    - name: "request_month"
      expr: DATE_TRUNC('MONTH', request_timestamp)
      comment: "Month when the port was requested"
    - name: "completion_month"
      expr: DATE_TRUNC('MONTH', completion_timestamp)
      comment: "Month when the port was completed"
  measures:
    - name: "total_port_transactions"
      expr: COUNT(1)
      comment: "Total number of MNP transactions"
    - name: "total_settlement_amount"
      expr: SUM(CAST(settlement_amount AS DOUBLE))
      comment: "Total settlement amount paid or received for porting"
    - name: "avg_settlement_per_port"
      expr: AVG(CAST(settlement_amount AS DOUBLE))
      comment: "Average settlement amount per port transaction"
    - name: "port_success_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN port_status = 'completed' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of ports successfully completed, key operational quality metric"
    - name: "sla_compliance_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN sla_breach_flag = FALSE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of ports completed within SLA, measuring service quality"
    - name: "avg_porting_duration_hours"
      expr: AVG(CAST(porting_duration_hours AS DOUBLE))
      comment: "Average time in hours to complete a port, key efficiency metric"
    - name: "fraud_detection_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN fraud_check_status = 'flagged' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of ports flagged for fraud, indicating fraud risk exposure"
    - name: "consent_verification_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN subscriber_consent_verified = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of ports with verified subscriber consent, measuring compliance"
    - name: "hlr_update_success_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN hlr_hss_update_status = 'success' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of successful HLR/HSS updates, measuring technical execution quality"
    - name: "distinct_donor_carriers"
      expr: COUNT(DISTINCT carrier_id)
      comment: "Number of unique donor carriers involved in porting"
    - name: "distinct_subscribers"
      expr: COUNT(DISTINCT subscriber_id)
      comment: "Number of unique subscribers who ported"
$$;


CREATE OR REPLACE VIEW `telecommunication_ecm`.`_metrics`.`interconnect_carrier`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Carrier partner profile and capability KPIs, tracking partner ecosystem composition, roaming capabilities, and relationship health"
  source: "`telecommunication_ecm`.`interconnect`.`carrier`"
  dimensions:
    - name: "carrier_status"
      expr: carrier_status
      comment: "Current operational status of the carrier"
    - name: "carrier_type"
      expr: carrier_type
      comment: "Type of carrier (e.g., MNO, MVNO, aggregator)"
    - name: "region"
      expr: region
      comment: "Geographic region of the carrier"
    - name: "country"
      expr: country_code
      comment: "Country code of the carrier"
    - name: "interconnect_agreement_type"
      expr: interconnect_agreement_type
      comment: "Type of interconnect agreement in place"
    - name: "roaming_agreement_type"
      expr: roaming_agreement_type
      comment: "Type of roaming agreement"
    - name: "fraud_risk_level"
      expr: fraud_risk_level
      comment: "Assessed fraud risk level of the carrier"
    - name: "sla_tier"
      expr: sla_tier
      comment: "SLA tier assigned to the carrier"
    - name: "settlement_currency"
      expr: settlement_currency
      comment: "Currency used for settlement with this carrier"
    - name: "lte_roaming_enabled"
      expr: lte_roaming_enabled
      comment: "Indicates whether LTE roaming is enabled"
    - name: "five_g_roaming_enabled"
      expr: five_g_roaming_enabled
      comment: "Indicates whether 5G roaming is enabled"
    - name: "volte_roaming_enabled"
      expr: volte_roaming_enabled
      comment: "Indicates whether VoLTE roaming is enabled"
    - name: "voice_interconnect_enabled"
      expr: voice_interconnect_enabled
      comment: "Indicates whether voice interconnect is enabled"
    - name: "sms_interconnect_enabled"
      expr: sms_interconnect_enabled
      comment: "Indicates whether SMS interconnect is enabled"
    - name: "data_roaming_enabled"
      expr: data_roaming_enabled
      comment: "Indicates whether data roaming is enabled"
    - name: "nrtrde_enabled"
      expr: nrtrde_enabled
      comment: "Indicates whether Near Real-Time Roaming Data Exchange is enabled"
  measures:
    - name: "total_carriers"
      expr: COUNT(1)
      comment: "Total number of carrier partners"
    - name: "active_carriers"
      expr: COUNT(CASE WHEN carrier_status = 'active' THEN 1 END)
      comment: "Number of active carrier partners"
    - name: "total_credit_limit"
      expr: SUM(CAST(credit_limit_amount AS DOUBLE))
      comment: "Total credit limit extended to all carriers"
    - name: "avg_credit_limit"
      expr: AVG(CAST(credit_limit_amount AS DOUBLE))
      comment: "Average credit limit per carrier"
    - name: "five_g_enabled_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN five_g_roaming_enabled = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of carriers with 5G roaming enabled, measuring network modernization"
    - name: "lte_enabled_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN lte_roaming_enabled = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of carriers with LTE roaming enabled"
    - name: "volte_enabled_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN volte_roaming_enabled = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of carriers with VoLTE roaming enabled"
    - name: "nrtrde_adoption_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN nrtrde_enabled = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of carriers with NRTRDE enabled, measuring real-time capability adoption"
    - name: "high_fraud_risk_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN fraud_risk_level = 'high' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of carriers assessed as high fraud risk, indicating portfolio risk exposure"
    - name: "distinct_countries"
      expr: COUNT(DISTINCT country_code)
      comment: "Number of unique countries represented in carrier portfolio"
    - name: "distinct_regions"
      expr: COUNT(DISTINCT region)
      comment: "Number of unique regions covered by carrier partnerships"
$$;


CREATE OR REPLACE VIEW `telecommunication_ecm`.`_metrics`.`interconnect_carrier_agreement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Carrier agreement lifecycle and commercial KPIs, tracking agreement portfolio health, renewal risk, and commercial terms effectiveness"
  source: "`telecommunication_ecm`.`interconnect`.`carrier_agreement`"
  dimensions:
    - name: "agreement_status"
      expr: agreement_status
      comment: "Current status of the carrier agreement"
    - name: "agreement_type"
      expr: agreement_type
      comment: "Type of carrier agreement"
    - name: "roaming_direction"
      expr: roaming_direction
      comment: "Direction of roaming covered (inbound, outbound, bilateral)"
    - name: "network_generation"
      expr: network_generation
      comment: "Network generation covered by agreement"
    - name: "settlement_cycle"
      expr: settlement_cycle
      comment: "Settlement cycle frequency"
    - name: "discount_type"
      expr: discount_type
      comment: "Type of discount applied"
    - name: "auto_renewal_flag"
      expr: auto_renewal_flag
      comment: "Indicates whether agreement auto-renews"
    - name: "nrtrde_flag"
      expr: nrtrde_flag
      comment: "Indicates whether NRTRDE is enabled in agreement"
    - name: "tap_file_exchange_flag"
      expr: tap_file_exchange_flag
      comment: "Indicates whether TAP file exchange is enabled"
    - name: "fraud_prevention_flag"
      expr: fraud_prevention_flag
      comment: "Indicates whether fraud prevention clauses are included"
    - name: "effective_month"
      expr: DATE_TRUNC('MONTH', effective_from_date)
      comment: "Month when agreement became effective"
    - name: "expiry_month"
      expr: DATE_TRUNC('MONTH', effective_until_date)
      comment: "Month when agreement expires"
  measures:
    - name: "total_agreements"
      expr: COUNT(1)
      comment: "Total number of carrier agreements"
    - name: "active_agreements"
      expr: COUNT(CASE WHEN agreement_status = 'active' THEN 1 END)
      comment: "Number of active carrier agreements"
    - name: "avg_discount_percentage"
      expr: AVG(CAST(discount_percentage AS DOUBLE))
      comment: "Average discount percentage across agreements"
    - name: "avg_revenue_share_percentage"
      expr: AVG(CAST(revenue_share_percentage AS DOUBLE))
      comment: "Average revenue share percentage"
    - name: "total_min_volume_commitment"
      expr: SUM(CAST(min_volume_commitment_units AS DOUBLE))
      comment: "Total minimum volume commitment across all agreements"
    - name: "auto_renewal_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN auto_renewal_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of agreements with auto-renewal, measuring contract stability"
    - name: "nrtrde_adoption_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN nrtrde_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of agreements with NRTRDE enabled, measuring technology adoption"
    - name: "fraud_protection_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN fraud_prevention_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of agreements with fraud prevention clauses, measuring risk mitigation"
    - name: "avg_agreement_duration_months"
      expr: ROUND(AVG(CAST(DATEDIFF(effective_until_date, effective_from_date) AS DOUBLE)) / 30.0, 1)
      comment: "Average agreement duration in months"
    - name: "distinct_counterparty_carriers"
      expr: COUNT(DISTINCT carrier_id)
      comment: "Number of unique counterparty carriers under agreement"
$$;


CREATE OR REPLACE VIEW `telecommunication_ecm`.`_metrics`.`interconnect_rate`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Interconnect rate and pricing KPIs, tracking rate portfolio composition, pricing trends, and regulatory compliance for interconnect services"
  source: "`telecommunication_ecm`.`interconnect`.`rate`"
  dimensions:
    - name: "rate_status"
      expr: rate_status
      comment: "Current status of the rate (active, expired, pending)"
    - name: "rate_type"
      expr: rate_type
      comment: "Type of rate (e.g., termination, origination, transit)"
    - name: "service_type"
      expr: service_type
      comment: "Service type covered by the rate"
    - name: "traffic_direction"
      expr: traffic_direction
      comment: "Direction of traffic (inbound, outbound)"
    - name: "network_generation"
      expr: network_generation
      comment: "Network generation (2G, 3G, 4G, 5G)"
    - name: "destination_country"
      expr: destination_country_code
      comment: "Destination country code for the rate"
    - name: "originating_country"
      expr: originating_country_code
      comment: "Originating country code"
    - name: "currency"
      expr: currency_code
      comment: "Currency in which the rate is denominated"
    - name: "basis"
      expr: basis
      comment: "Basis for rate calculation (per minute, per MB, per SMS)"
    - name: "nrtrde_applicable"
      expr: nrtrde_applicable_flag
      comment: "Indicates whether NRTRDE applies to this rate"
    - name: "effective_month"
      expr: DATE_TRUNC('MONTH', effective_from_date)
      comment: "Month when rate became effective"
  measures:
    - name: "total_rates"
      expr: COUNT(1)
      comment: "Total number of interconnect rates"
    - name: "active_rates"
      expr: COUNT(CASE WHEN rate_status = 'active' THEN 1 END)
      comment: "Number of active rates"
    - name: "avg_peak_rate"
      expr: AVG(CAST(peak_rate AS DOUBLE))
      comment: "Average peak rate across all rates"
    - name: "avg_off_peak_rate"
      expr: AVG(CAST(off_peak_rate AS DOUBLE))
      comment: "Average off-peak rate"
    - name: "avg_weekend_rate"
      expr: AVG(CAST(weekend_rate AS DOUBLE))
      comment: "Average weekend rate"
    - name: "avg_regulatory_cap_rate"
      expr: AVG(CAST(regulatory_cap_rate AS DOUBLE))
      comment: "Average regulatory cap rate, measuring compliance constraints"
    - name: "peak_to_offpeak_ratio"
      expr: ROUND(AVG(CAST(peak_rate AS DOUBLE)) / NULLIF(AVG(CAST(off_peak_rate AS DOUBLE)), 0), 2)
      comment: "Ratio of peak to off-peak rates, measuring pricing strategy effectiveness"
    - name: "distinct_destination_countries"
      expr: COUNT(DISTINCT destination_country_code)
      comment: "Number of unique destination countries covered by rates"
    - name: "distinct_currencies"
      expr: COUNT(DISTINCT currency_code)
      comment: "Number of unique currencies used in rate portfolio"
    - name: "nrtrde_coverage_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN nrtrde_applicable_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of rates with NRTRDE applicability, measuring real-time pricing coverage"
$$;
