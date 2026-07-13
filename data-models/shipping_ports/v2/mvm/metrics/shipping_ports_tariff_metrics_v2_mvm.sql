-- Metric views for domain: tariff | Business: Shipping_Ports | Version: 2 | Generated on: 2026-07-13 10:23:14

CREATE OR REPLACE VIEW `vibe_shipping_ports_v1`.`_metrics`.`tariff_discount_scheme`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Discount Scheme business metrics"
  source: "`vibe_shipping_ports_v1`.`tariff`.`discount_scheme`"
  dimensions:
    - name: "Applicable Charge Codes"
      expr: applicable_charge_codes
    - name: "Approval Authority"
      expr: approval_authority
    - name: "Approval Date"
      expr: approval_date
    - name: "Approval Reference"
      expr: approval_reference
    - name: "Auto Apply Flag"
      expr: auto_apply_flag
    - name: "Billing System Code"
      expr: billing_system_code
    - name: "Cargo Type Restriction"
      expr: cargo_type_restriction
    - name: "Combinable With Other Discounts"
      expr: combinable_with_other_discounts
    - name: "Contract Reference"
      expr: contract_reference
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Customer Tier Eligibility"
      expr: customer_tier_eligibility
    - name: "Customer Type Eligibility"
      expr: customer_type_eligibility
    - name: "Discount Category"
      expr: discount_category
    - name: "Discount Currency Code"
      expr: discount_currency_code
    - name: "Discount Type"
      expr: discount_type
    - name: "Effective From Date"
      expr: effective_from_date
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Discount Scheme"
      expr: COUNT(DISTINCT discount_scheme_id)
    - name: "Total Discount Value"
      expr: SUM(discount_value)
    - name: "Average Discount Value"
      expr: AVG(discount_value)
    - name: "Total Maximum Discount Cap"
      expr: SUM(maximum_discount_cap)
    - name: "Average Maximum Discount Cap"
      expr: AVG(maximum_discount_cap)
    - name: "Total Minimum Charge Threshold"
      expr: SUM(minimum_charge_threshold)
    - name: "Average Minimum Charge Threshold"
      expr: AVG(minimum_charge_threshold)
    - name: "Total Threshold Value"
      expr: SUM(threshold_value)
    - name: "Average Threshold Value"
      expr: AVG(threshold_value)
$$;

CREATE OR REPLACE VIEW `vibe_shipping_ports_v1`.`_metrics`.`tariff_item`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Item business metrics"
  source: "`vibe_shipping_ports_v1`.`tariff`.`item`"
  dimensions:
    - name: "Approval Status"
      expr: approval_status
    - name: "Approved By"
      expr: approved_by
    - name: "Approved Timestamp"
      expr: approved_timestamp
    - name: "Charge Basis"
      expr: charge_basis
    - name: "Charge Category"
      expr: charge_category
    - name: "Charge Code"
      expr: charge_code
    - name: "Charge Description"
      expr: charge_description
    - name: "Charge Name"
      expr: charge_name
    - name: "Container Size Applicability"
      expr: container_size_applicability
    - name: "Container Type Applicability"
      expr: container_type_applicability
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Dangerous Goods Flag"
      expr: dangerous_goods_flag
    - name: "Effective From Date"
      expr: effective_from_date
    - name: "Effective To Date"
      expr: effective_to_date
    - name: "Escalation Tier 1 Days"
      expr: escalation_tier_1_days
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Item"
      expr: COUNT(DISTINCT item_id)
    - name: "Total Escalation Tier 1 Rate"
      expr: SUM(escalation_tier_1_rate)
    - name: "Average Escalation Tier 1 Rate"
      expr: AVG(escalation_tier_1_rate)
    - name: "Total Escalation Tier 2 Rate"
      expr: SUM(escalation_tier_2_rate)
    - name: "Average Escalation Tier 2 Rate"
      expr: AVG(escalation_tier_2_rate)
    - name: "Total Escalation Tier 3 Rate"
      expr: SUM(escalation_tier_3_rate)
    - name: "Average Escalation Tier 3 Rate"
      expr: AVG(escalation_tier_3_rate)
    - name: "Total Maximum Charge"
      expr: SUM(maximum_charge)
    - name: "Average Maximum Charge"
      expr: AVG(maximum_charge)
    - name: "Total Minimum Charge"
      expr: SUM(minimum_charge)
    - name: "Average Minimum Charge"
      expr: AVG(minimum_charge)
    - name: "Total Rate Amount"
      expr: SUM(rate_amount)
    - name: "Average Rate Amount"
      expr: AVG(rate_amount)
    - name: "Total Rate Band Amount 1"
      expr: SUM(rate_band_amount_1)
    - name: "Average Rate Band Amount 1"
      expr: AVG(rate_band_amount_1)
    - name: "Total Rate Band Amount 2"
      expr: SUM(rate_band_amount_2)
    - name: "Average Rate Band Amount 2"
      expr: AVG(rate_band_amount_2)
    - name: "Total Rate Band Amount 3"
      expr: SUM(rate_band_amount_3)
    - name: "Average Rate Band Amount 3"
      expr: AVG(rate_band_amount_3)
    - name: "Total Rate Band Threshold 1"
      expr: SUM(rate_band_threshold_1)
    - name: "Average Rate Band Threshold 1"
      expr: AVG(rate_band_threshold_1)
    - name: "Total Rate Band Threshold 2"
      expr: SUM(rate_band_threshold_2)
    - name: "Average Rate Band Threshold 2"
      expr: AVG(rate_band_threshold_2)
    - name: "Total Rate Band Threshold 3"
      expr: SUM(rate_band_threshold_3)
    - name: "Average Rate Band Threshold 3"
      expr: AVG(rate_band_threshold_3)
$$;

CREATE OR REPLACE VIEW `vibe_shipping_ports_v1`.`_metrics`.`tariff_item_surcharge_applicability`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Item Surcharge Applicability business metrics"
  source: "`vibe_shipping_ports_v1`.`tariff`.`item_surcharge_applicability`"
  dimensions:
    - name: "Applicability Conditions"
      expr: applicability_conditions
    - name: "Approved By"
      expr: approved_by
    - name: "Approved Timestamp"
      expr: approved_timestamp
    - name: "Calculation Priority"
      expr: calculation_priority
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Effective From Date"
      expr: effective_from_date
    - name: "Effective To Date"
      expr: effective_to_date
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Override Flag"
      expr: override_flag
    - name: "Approved Timestamp Month"
      expr: DATE_TRUNC('MONTH', approved_timestamp)
    - name: "Created Timestamp Month"
      expr: DATE_TRUNC('MONTH', created_timestamp)
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Item Surcharge Applicability"
      expr: COUNT(DISTINCT item_surcharge_applicability_id)
$$;

CREATE OR REPLACE VIEW `vibe_shipping_ports_v1`.`_metrics`.`tariff_port_dues_schedule`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Port Dues Schedule business metrics"
  source: "`vibe_shipping_ports_v1`.`tariff`.`port_dues_schedule`"
  dimensions:
    - name: "Approval Date"
      expr: approval_date
    - name: "Call Frequency Tier"
      expr: call_frequency_tier
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Dues Type"
      expr: dues_type
    - name: "Effective From Date"
      expr: effective_from_date
    - name: "Effective To Date"
      expr: effective_to_date
    - name: "Exemption Criteria"
      expr: exemption_criteria
    - name: "Exemption Flag"
      expr: exemption_flag
    - name: "Measurement Period Days"
      expr: measurement_period_days
    - name: "Minimum Calls Per Period"
      expr: minimum_calls_per_period
    - name: "Modified Timestamp"
      expr: modified_timestamp
    - name: "Notes"
      expr: notes
    - name: "Payment Terms Days"
      expr: payment_terms_days
    - name: "Port Dues Schedule Status"
      expr: port_dues_schedule_status
    - name: "Publication Date"
      expr: publication_date
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Port Dues Schedule"
      expr: COUNT(DISTINCT port_dues_schedule_id)
    - name: "Total Base Rate Amount"
      expr: SUM(base_rate_amount)
    - name: "Average Base Rate Amount"
      expr: AVG(base_rate_amount)
    - name: "Total Call Frequency Discount Percentage"
      expr: SUM(call_frequency_discount_percentage)
    - name: "Average Call Frequency Discount Percentage"
      expr: AVG(call_frequency_discount_percentage)
    - name: "Total Dangerous Goods Surcharge Percentage"
      expr: SUM(dangerous_goods_surcharge_percentage)
    - name: "Average Dangerous Goods Surcharge Percentage"
      expr: AVG(dangerous_goods_surcharge_percentage)
    - name: "Total Environmental Levy Percentage"
      expr: SUM(environmental_levy_percentage)
    - name: "Average Environmental Levy Percentage"
      expr: AVG(environmental_levy_percentage)
    - name: "Total Grt Band Max"
      expr: SUM(grt_band_max)
    - name: "Average Grt Band Max"
      expr: AVG(grt_band_max)
    - name: "Total Grt Band Min"
      expr: SUM(grt_band_min)
    - name: "Average Grt Band Min"
      expr: AVG(grt_band_min)
    - name: "Total Late Payment Penalty Percentage"
      expr: SUM(late_payment_penalty_percentage)
    - name: "Average Late Payment Penalty Percentage"
      expr: AVG(late_payment_penalty_percentage)
    - name: "Total Loa Band Max Meters"
      expr: SUM(loa_band_max_meters)
    - name: "Average Loa Band Max Meters"
      expr: AVG(loa_band_max_meters)
    - name: "Total Loa Band Min Meters"
      expr: SUM(loa_band_min_meters)
    - name: "Average Loa Band Min Meters"
      expr: AVG(loa_band_min_meters)
    - name: "Total Maximum Charge Amount"
      expr: SUM(maximum_charge_amount)
    - name: "Average Maximum Charge Amount"
      expr: AVG(maximum_charge_amount)
    - name: "Total Minimum Charge Amount"
      expr: SUM(minimum_charge_amount)
    - name: "Average Minimum Charge Amount"
      expr: AVG(minimum_charge_amount)
    - name: "Total Nrt Band Max"
      expr: SUM(nrt_band_max)
    - name: "Average Nrt Band Max"
      expr: AVG(nrt_band_max)
$$;

CREATE OR REPLACE VIEW `vibe_shipping_ports_v1`.`_metrics`.`tariff_port_tariff`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Port Tariff business metrics"
  source: "`vibe_shipping_ports_v1`.`tariff`.`port_tariff`"
  dimensions:
    - name: "Applicable Cargo Types"
      expr: applicable_cargo_types
    - name: "Applicable Container Types"
      expr: applicable_container_types
    - name: "Applicable Movement Types"
      expr: applicable_movement_types
    - name: "Applicable Terminal Zones"
      expr: applicable_terminal_zones
    - name: "Applicable Trade Lanes"
      expr: applicable_trade_lanes
    - name: "Applicable Vessel Categories"
      expr: applicable_vessel_categories
    - name: "Approval Authority"
      expr: approval_authority
    - name: "Approval Date"
      expr: approval_date
    - name: "Approval Reference Number"
      expr: approval_reference_number
    - name: "Charge Type"
      expr: charge_type
    - name: "Created By User"
      expr: created_by_user
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Discount Eligible Flag"
      expr: discount_eligible_flag
    - name: "Effective From Date"
      expr: effective_from_date
    - name: "Effective To Date"
      expr: effective_to_date
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Port Tariff"
      expr: COUNT(DISTINCT port_tariff_id)
    - name: "Total Base Rate Amount"
      expr: SUM(base_rate_amount)
    - name: "Average Base Rate Amount"
      expr: AVG(base_rate_amount)
    - name: "Total Dwt Band Max"
      expr: SUM(dwt_band_max)
    - name: "Average Dwt Band Max"
      expr: AVG(dwt_band_max)
    - name: "Total Dwt Band Min"
      expr: SUM(dwt_band_min)
    - name: "Average Dwt Band Min"
      expr: AVG(dwt_band_min)
    - name: "Total Grt Band Max"
      expr: SUM(grt_band_max)
    - name: "Average Grt Band Max"
      expr: AVG(grt_band_max)
    - name: "Total Grt Band Min"
      expr: SUM(grt_band_min)
    - name: "Average Grt Band Min"
      expr: AVG(grt_band_min)
    - name: "Total Loa Band Max Meters"
      expr: SUM(loa_band_max_meters)
    - name: "Average Loa Band Max Meters"
      expr: AVG(loa_band_max_meters)
    - name: "Total Loa Band Min Meters"
      expr: SUM(loa_band_min_meters)
    - name: "Average Loa Band Min Meters"
      expr: AVG(loa_band_min_meters)
    - name: "Total Maximum Charge Amount"
      expr: SUM(maximum_charge_amount)
    - name: "Average Maximum Charge Amount"
      expr: AVG(maximum_charge_amount)
    - name: "Total Minimum Charge Amount"
      expr: SUM(minimum_charge_amount)
    - name: "Average Minimum Charge Amount"
      expr: AVG(minimum_charge_amount)
$$;

CREATE OR REPLACE VIEW `vibe_shipping_ports_v1`.`_metrics`.`tariff_rate_card`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Rate Card business metrics"
  source: "`vibe_shipping_ports_v1`.`tariff`.`rate_card`"
  dimensions:
    - name: "Approval Status"
      expr: approval_status
    - name: "Approved By"
      expr: approved_by
    - name: "Approved Timestamp"
      expr: approved_timestamp
    - name: "Auto Renewal Flag"
      expr: auto_renewal_flag
    - name: "Billing Frequency"
      expr: billing_frequency
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Customer Segment"
      expr: customer_segment
    - name: "Effective Date"
      expr: effective_date
    - name: "Escalation Clause"
      expr: escalation_clause
    - name: "Expiry Date"
      expr: expiry_date
    - name: "Measurement Period"
      expr: measurement_period
    - name: "Modified By"
      expr: modified_by
    - name: "Modified Timestamp"
      expr: modified_timestamp
    - name: "Name"
      expr: name
    - name: "Notes"
      expr: notes
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Rate Card"
      expr: COUNT(DISTINCT rate_card_id)
    - name: "Total Committed Volume Teu"
      expr: SUM(committed_volume_teu)
    - name: "Average Committed Volume Teu"
      expr: AVG(committed_volume_teu)
    - name: "Total Crane Productivity Target Moves Per Hour"
      expr: SUM(crane_productivity_target_moves_per_hour)
    - name: "Average Crane Productivity Target Moves Per Hour"
      expr: AVG(crane_productivity_target_moves_per_hour)
    - name: "Total Discount Percentage"
      expr: SUM(discount_percentage)
    - name: "Average Discount Percentage"
      expr: AVG(discount_percentage)
    - name: "Total Gate Processing Time Target Minutes"
      expr: SUM(gate_processing_time_target_minutes)
    - name: "Average Gate Processing Time Target Minutes"
      expr: AVG(gate_processing_time_target_minutes)
    - name: "Total Minimum Commitment Amount"
      expr: SUM(minimum_commitment_amount)
    - name: "Average Minimum Commitment Amount"
      expr: AVG(minimum_commitment_amount)
    - name: "Total Premium Percentage"
      expr: SUM(premium_percentage)
    - name: "Average Premium Percentage"
      expr: AVG(premium_percentage)
    - name: "Total Vessel Turnaround Time Target Hours"
      expr: SUM(vessel_turnaround_time_target_hours)
    - name: "Average Vessel Turnaround Time Target Hours"
      expr: AVG(vessel_turnaround_time_target_hours)
$$;

CREATE OR REPLACE VIEW `vibe_shipping_ports_v1`.`_metrics`.`tariff_rate_card_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Rate Card Line business metrics"
  source: "`vibe_shipping_ports_v1`.`tariff`.`rate_card_line`"
  dimensions:
    - name: "Approval Timestamp"
      expr: approval_timestamp
    - name: "Baf Applicable Flag"
      expr: baf_applicable_flag
    - name: "Billing Frequency"
      expr: billing_frequency
    - name: "Caf Applicable Flag"
      expr: caf_applicable_flag
    - name: "Cargo Type"
      expr: cargo_type
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Effective From Date"
      expr: effective_from_date
    - name: "Effective To Date"
      expr: effective_to_date
    - name: "Free Time Days"
      expr: free_time_days
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Line Sequence Number"
      expr: line_sequence_number
    - name: "Line Status"
      expr: line_status
    - name: "Notes"
      expr: notes
    - name: "Override Reason Code"
      expr: override_reason_code
    - name: "Override Reason Description"
      expr: override_reason_description
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Rate Card Line"
      expr: COUNT(DISTINCT rate_card_line_id)
    - name: "Total Discount Percentage"
      expr: SUM(discount_percentage)
    - name: "Average Discount Percentage"
      expr: AVG(discount_percentage)
    - name: "Total Maximum Quantity"
      expr: SUM(maximum_quantity)
    - name: "Average Maximum Quantity"
      expr: AVG(maximum_quantity)
    - name: "Total Minimum Quantity"
      expr: SUM(minimum_quantity)
    - name: "Average Minimum Quantity"
      expr: AVG(minimum_quantity)
    - name: "Total Penalty Rate"
      expr: SUM(penalty_rate)
    - name: "Average Penalty Rate"
      expr: AVG(penalty_rate)
    - name: "Total Sla Target Hours"
      expr: SUM(sla_target_hours)
    - name: "Average Sla Target Hours"
      expr: AVG(sla_target_hours)
    - name: "Total Tax Rate Percentage"
      expr: SUM(tax_rate_percentage)
    - name: "Average Tax Rate Percentage"
      expr: AVG(tax_rate_percentage)
    - name: "Total Tier Threshold Lower"
      expr: SUM(tier_threshold_lower)
    - name: "Average Tier Threshold Lower"
      expr: AVG(tier_threshold_lower)
    - name: "Total Tier Threshold Upper"
      expr: SUM(tier_threshold_upper)
    - name: "Average Tier Threshold Upper"
      expr: AVG(tier_threshold_upper)
    - name: "Total Unit Rate"
      expr: SUM(unit_rate)
    - name: "Average Unit Rate"
      expr: AVG(unit_rate)
$$;

CREATE OR REPLACE VIEW `vibe_shipping_ports_v1`.`_metrics`.`tariff_storage_tariff`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Storage Tariff business metrics"
  source: "`vibe_shipping_ports_v1`.`tariff`.`storage_tariff`"
  dimensions:
    - name: "Approval Date"
      expr: approval_date
    - name: "Approved By"
      expr: approved_by
    - name: "Billing Frequency"
      expr: billing_frequency
    - name: "Cargo Type"
      expr: cargo_type
    - name: "Container Status"
      expr: container_status
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Customer Tier"
      expr: customer_tier
    - name: "Demurrage Conversion Day"
      expr: demurrage_conversion_day
    - name: "Demurrage Linkage Flag"
      expr: demurrage_linkage_flag
    - name: "Effective From Date"
      expr: effective_from_date
    - name: "Effective To Date"
      expr: effective_to_date
    - name: "Free Storage Days"
      expr: free_storage_days
    - name: "Grace Period Hours"
      expr: grace_period_hours
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Notes"
      expr: notes
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Storage Tariff"
      expr: COUNT(DISTINCT storage_tariff_id)
    - name: "Total Maximum Charge Amount"
      expr: SUM(maximum_charge_amount)
    - name: "Average Maximum Charge Amount"
      expr: AVG(maximum_charge_amount)
    - name: "Total Minimum Charge Amount"
      expr: SUM(minimum_charge_amount)
    - name: "Average Minimum Charge Amount"
      expr: AVG(minimum_charge_amount)
    - name: "Total Rate Band 1 Daily Rate"
      expr: SUM(rate_band_1_daily_rate)
    - name: "Average Rate Band 1 Daily Rate"
      expr: AVG(rate_band_1_daily_rate)
    - name: "Total Rate Band 2 Daily Rate"
      expr: SUM(rate_band_2_daily_rate)
    - name: "Average Rate Band 2 Daily Rate"
      expr: AVG(rate_band_2_daily_rate)
    - name: "Total Rate Band 3 Daily Rate"
      expr: SUM(rate_band_3_daily_rate)
    - name: "Average Rate Band 3 Daily Rate"
      expr: AVG(rate_band_3_daily_rate)
$$;

CREATE OR REPLACE VIEW `vibe_shipping_ports_v1`.`_metrics`.`tariff_surcharge_rule`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Surcharge Rule business metrics"
  source: "`vibe_shipping_ports_v1`.`tariff`.`surcharge_rule`"
  dimensions:
    - name: "Applicability Conditions"
      expr: applicability_conditions
    - name: "Approval Status"
      expr: approval_status
    - name: "Approved By"
      expr: approved_by
    - name: "Approved Timestamp"
      expr: approved_timestamp
    - name: "Billing Frequency"
      expr: billing_frequency
    - name: "Calculation Base"
      expr: calculation_base
    - name: "Calculation Method"
      expr: calculation_method
    - name: "Calculation Priority"
      expr: calculation_priority
    - name: "Cargo Type Applicability"
      expr: cargo_type_applicability
    - name: "Compounding Allowed"
      expr: compounding_allowed
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Currency Pair"
      expr: currency_pair
    - name: "Effective From Date"
      expr: effective_from_date
    - name: "Effective To Date"
      expr: effective_to_date
    - name: "Exemption Criteria"
      expr: exemption_criteria
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Surcharge Rule"
      expr: COUNT(DISTINCT surcharge_rule_id)
    - name: "Total Maximum Charge"
      expr: SUM(maximum_charge)
    - name: "Average Maximum Charge"
      expr: AVG(maximum_charge)
    - name: "Total Minimum Charge"
      expr: SUM(minimum_charge)
    - name: "Average Minimum Charge"
      expr: AVG(minimum_charge)
    - name: "Total Rate Amount"
      expr: SUM(rate_amount)
    - name: "Average Rate Amount"
      expr: AVG(rate_amount)
    - name: "Total Rate Percentage"
      expr: SUM(rate_percentage)
    - name: "Average Rate Percentage"
      expr: AVG(rate_percentage)
$$;

CREATE OR REPLACE VIEW `vibe_shipping_ports_v1`.`_metrics`.`tariff_thc_schedule`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Thc Schedule business metrics"
  source: "`vibe_shipping_ports_v1`.`tariff`.`thc_schedule`"
  dimensions:
    - name: "Approval Status"
      expr: approval_status
    - name: "Approved By"
      expr: approved_by
    - name: "Approved Timestamp"
      expr: approved_timestamp
    - name: "Cargo Category"
      expr: cargo_category
    - name: "Contract Reference"
      expr: contract_reference
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Customer Segment"
      expr: customer_segment
    - name: "Discount Eligible Flag"
      expr: discount_eligible_flag
    - name: "Effective From Date"
      expr: effective_from_date
    - name: "Effective To Date"
      expr: effective_to_date
    - name: "Filing Date"
      expr: filing_date
    - name: "Modified By"
      expr: modified_by
    - name: "Modified Timestamp"
      expr: modified_timestamp
    - name: "Movement Type"
      expr: movement_type
    - name: "Notes"
      expr: notes
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Thc Schedule"
      expr: COUNT(DISTINCT thc_schedule_id)
    - name: "Total Base Rate Amount"
      expr: SUM(base_rate_amount)
    - name: "Average Base Rate Amount"
      expr: AVG(base_rate_amount)
    - name: "Total Container Size Teu"
      expr: SUM(container_size_teu)
    - name: "Average Container Size Teu"
      expr: AVG(container_size_teu)
    - name: "Total Dangerous Goods Surcharge"
      expr: SUM(dangerous_goods_surcharge)
    - name: "Average Dangerous Goods Surcharge"
      expr: AVG(dangerous_goods_surcharge)
    - name: "Total Maximum Charge Amount"
      expr: SUM(maximum_charge_amount)
    - name: "Average Maximum Charge Amount"
      expr: AVG(maximum_charge_amount)
    - name: "Total Minimum Charge Amount"
      expr: SUM(minimum_charge_amount)
    - name: "Average Minimum Charge Amount"
      expr: AVG(minimum_charge_amount)
    - name: "Total Oversize Surcharge"
      expr: SUM(oversize_surcharge)
    - name: "Average Oversize Surcharge"
      expr: AVG(oversize_surcharge)
    - name: "Total Peak Season Surcharge"
      expr: SUM(peak_season_surcharge)
    - name: "Average Peak Season Surcharge"
      expr: AVG(peak_season_surcharge)
    - name: "Total Reefer Surcharge"
      expr: SUM(reefer_surcharge)
    - name: "Average Reefer Surcharge"
      expr: AVG(reefer_surcharge)
$$;

CREATE OR REPLACE VIEW `vibe_shipping_ports_v1`.`_metrics`.`tariff_wharfage_schedule`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Wharfage Schedule business metrics"
  source: "`vibe_shipping_ports_v1`.`tariff`.`wharfage_schedule`"
  dimensions:
    - name: "Approval Authority"
      expr: approval_authority
    - name: "Approval Date"
      expr: approval_date
    - name: "Approval Reference Number"
      expr: approval_reference_number
    - name: "Baf Applicable Flag"
      expr: baf_applicable_flag
    - name: "Caf Applicable Flag"
      expr: caf_applicable_flag
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Dangerous Goods Flag"
      expr: dangerous_goods_flag
    - name: "Effective From Date"
      expr: effective_from_date
    - name: "Effective To Date"
      expr: effective_to_date
    - name: "Exemption Condition"
      expr: exemption_condition
    - name: "Exemption Flag"
      expr: exemption_flag
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Notes"
      expr: notes
    - name: "Oversized Cargo Flag"
      expr: oversized_cargo_flag
    - name: "Publication Date"
      expr: publication_date
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Wharfage Schedule"
      expr: COUNT(DISTINCT wharfage_schedule_id)
    - name: "Total Discount Percentage"
      expr: SUM(discount_percentage)
    - name: "Average Discount Percentage"
      expr: AVG(discount_percentage)
    - name: "Total Minimum Charge"
      expr: SUM(minimum_charge)
    - name: "Average Minimum Charge"
      expr: AVG(minimum_charge)
    - name: "Total Rate Per Unit"
      expr: SUM(rate_per_unit)
    - name: "Average Rate Per Unit"
      expr: AVG(rate_per_unit)
    - name: "Total Surcharge Percentage"
      expr: SUM(surcharge_percentage)
    - name: "Average Surcharge Percentage"
      expr: AVG(surcharge_percentage)
    - name: "Total Volume Break Lower Limit"
      expr: SUM(volume_break_lower_limit)
    - name: "Average Volume Break Lower Limit"
      expr: AVG(volume_break_lower_limit)
    - name: "Total Volume Break Upper Limit"
      expr: SUM(volume_break_upper_limit)
    - name: "Average Volume Break Upper Limit"
      expr: AVG(volume_break_upper_limit)
    - name: "Total Weight Break Lower Limit"
      expr: SUM(weight_break_lower_limit)
    - name: "Average Weight Break Lower Limit"
      expr: AVG(weight_break_lower_limit)
    - name: "Total Weight Break Upper Limit"
      expr: SUM(weight_break_upper_limit)
    - name: "Average Weight Break Upper Limit"
      expr: AVG(weight_break_upper_limit)
$$;