-- Metric views for domain: contract | Business: Waste Management | Version: 1 | Generated on: 2026-05-07 19:57:14

CREATE OR REPLACE VIEW `waste_management_ecm`.`_metrics`.`contract`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core contract performance metrics tracking contract value, lifecycle, and compliance across all agreement types"
  source: "`waste_management_ecm`.`contract`.`contract`"
  dimensions:
    - name: "contract_status"
      expr: contract_status
      comment: "Current status of the contract (active, expired, terminated, etc.)"
    - name: "contract_year"
      expr: YEAR(effective_date)
      comment: "Year the contract became effective"
    - name: "contract_month"
      expr: DATE_TRUNC('MONTH', effective_date)
      comment: "Month the contract became effective"
    - name: "auto_renewal_flag"
      expr: auto_renewal_flag
      comment: "Whether the contract is eligible for automatic renewal"
    - name: "performance_bond_required_flag"
      expr: performance_bond_required_flag
      comment: "Whether a performance bond is required for this contract"
    - name: "governing_jurisdiction"
      expr: governing_jurisdiction
      comment: "Legal jurisdiction governing the contract"
    - name: "billing_frequency"
      expr: billing_frequency
      comment: "Frequency of billing for the contract"
    - name: "term_length_bucket"
      expr: CASE WHEN CAST(term_months AS INT) <= 12 THEN '0-12 months' WHEN CAST(term_months AS INT) <= 24 THEN '13-24 months' WHEN CAST(term_months AS INT) <= 36 THEN '25-36 months' ELSE '37+ months' END
      comment: "Contract term length grouped into buckets"
  measures:
    - name: "total_contract_count"
      expr: COUNT(1)
      comment: "Total number of contracts"
    - name: "total_contract_value"
      expr: SUM(CAST(value_total AS DOUBLE))
      comment: "Total value of all contracts"
    - name: "avg_contract_value"
      expr: AVG(CAST(value_total AS DOUBLE))
      comment: "Average contract value"
    - name: "total_performance_bond_amount"
      expr: SUM(CAST(performance_bond_amount AS DOUBLE))
      comment: "Total performance bond amounts required across contracts"
    - name: "avg_annual_escalation_rate"
      expr: AVG(CAST(annual_escalation_percentage AS DOUBLE))
      comment: "Average annual escalation percentage across contracts"
    - name: "avg_term_months"
      expr: AVG(CAST(term_months AS DOUBLE))
      comment: "Average contract term length in months"
    - name: "total_early_termination_penalty"
      expr: SUM(CAST(early_termination_penalty AS DOUBLE))
      comment: "Total early termination penalty amounts across contracts"
    - name: "avg_late_payment_penalty_rate"
      expr: AVG(CAST(late_payment_penalty_rate AS DOUBLE))
      comment: "Average late payment penalty rate across contracts"
    - name: "total_minimum_tonnage_commitment"
      expr: SUM(CAST(minimum_tonnage_commitment AS DOUBLE))
      comment: "Total minimum tonnage commitments across contracts"
    - name: "total_maximum_tonnage_limit"
      expr: SUM(CAST(maximum_tonnage_limit AS DOUBLE))
      comment: "Total maximum tonnage limits across contracts"
    - name: "distinct_customer_count"
      expr: COUNT(DISTINCT customer_account_id)
      comment: "Number of unique customers with contracts"
$$;


CREATE OR REPLACE VIEW `waste_management_ecm`.`_metrics`.`contract_franchise_agreement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Franchise agreement performance metrics tracking municipal partnerships, service commitments, and environmental compliance targets"
  source: "`waste_management_ecm`.`contract`.`franchise_agreement`"
  dimensions:
    - name: "agreement_status"
      expr: agreement_status
      comment: "Current status of the franchise agreement"
    - name: "effective_year"
      expr: YEAR(effective_start_date)
      comment: "Year the franchise agreement became effective"
    - name: "effective_month"
      expr: DATE_TRUNC('MONTH', effective_start_date)
      comment: "Month the franchise agreement became effective"
    - name: "exclusivity_type"
      expr: exclusivity_type
      comment: "Type of exclusivity granted in the franchise agreement"
    - name: "franchise_fee_type"
      expr: franchise_fee_type
      comment: "Type of franchise fee structure (fixed, percentage, per-ton)"
    - name: "performance_bond_required"
      expr: performance_bond_required
      comment: "Whether a performance bond is required for this franchise"
    - name: "termination_for_cause_allowed"
      expr: termination_for_cause_allowed
      comment: "Whether termination for cause is allowed"
    - name: "swis_reporting_required"
      expr: swis_reporting_required
      comment: "Whether SWIS (Solid Waste Information System) reporting is required"
  measures:
    - name: "total_franchise_count"
      expr: COUNT(1)
      comment: "Total number of franchise agreements"
    - name: "total_performance_bond_amount"
      expr: SUM(CAST(performance_bond_amount AS DOUBLE))
      comment: "Total performance bond amounts required across franchise agreements"
    - name: "avg_performance_bond_amount"
      expr: AVG(CAST(performance_bond_amount AS DOUBLE))
      comment: "Average performance bond amount per franchise agreement"
    - name: "total_franchise_fee_fixed"
      expr: SUM(CAST(franchise_fee_fixed_amount AS DOUBLE))
      comment: "Total fixed franchise fees across agreements"
    - name: "avg_franchise_fee_percentage"
      expr: AVG(CAST(franchise_fee_percentage AS DOUBLE))
      comment: "Average franchise fee percentage across agreements"
    - name: "avg_franchise_fee_per_ton"
      expr: AVG(CAST(franchise_fee_per_ton_rate AS DOUBLE))
      comment: "Average franchise fee per ton rate"
    - name: "avg_diversion_rate_requirement"
      expr: AVG(CAST(diversion_rate_requirement AS DOUBLE))
      comment: "Average diversion rate requirement across franchise agreements"
    - name: "avg_ghg_reduction_target"
      expr: AVG(CAST(ghg_reduction_target_percentage AS DOUBLE))
      comment: "Average greenhouse gas reduction target percentage"
    - name: "avg_annual_rate_escalation"
      expr: AVG(CAST(annual_rate_escalation_percentage AS DOUBLE))
      comment: "Average annual rate escalation percentage across franchise agreements"
    - name: "avg_initial_term_years"
      expr: AVG(CAST(initial_term_years AS DOUBLE))
      comment: "Average initial term length in years"
    - name: "distinct_municipality_count"
      expr: COUNT(DISTINCT municipality_id)
      comment: "Number of unique municipalities with franchise agreements"
$$;


CREATE OR REPLACE VIEW `waste_management_ecm`.`_metrics`.`contract_disposal_agreement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Disposal agreement metrics tracking tipping fees, tonnage commitments, and landfill capacity utilization"
  source: "`waste_management_ecm`.`contract`.`disposal_agreement`"
  dimensions:
    - name: "agreement_status"
      expr: agreement_status
      comment: "Current status of the disposal agreement"
    - name: "effective_year"
      expr: YEAR(effective_start_date)
      comment: "Year the disposal agreement became effective"
    - name: "effective_month"
      expr: DATE_TRUNC('MONTH', effective_start_date)
      comment: "Month the disposal agreement became effective"
    - name: "auto_renewal_flag"
      expr: auto_renewal_flag
      comment: "Whether the disposal agreement is eligible for automatic renewal"
    - name: "manifest_required"
      expr: manifest_required
      comment: "Whether waste manifest documentation is required"
    - name: "rcra_compliance_required"
      expr: rcra_compliance_required
      comment: "Whether RCRA (Resource Conservation and Recovery Act) compliance is required"
    - name: "insurance_required"
      expr: insurance_required
      comment: "Whether insurance coverage is required"
    - name: "billing_frequency"
      expr: billing_frequency
      comment: "Frequency of billing for disposal services"
    - name: "facility_operator"
      expr: facility_operator
      comment: "Name of the facility operator"
  measures:
    - name: "total_disposal_agreement_count"
      expr: COUNT(1)
      comment: "Total number of disposal agreements"
    - name: "total_contracted_annual_tonnage"
      expr: SUM(CAST(contracted_annual_tonnage AS DOUBLE))
      comment: "Total contracted annual tonnage across all disposal agreements"
    - name: "avg_contracted_annual_tonnage"
      expr: AVG(CAST(contracted_annual_tonnage AS DOUBLE))
      comment: "Average contracted annual tonnage per disposal agreement"
    - name: "total_minimum_tonnage_guarantee"
      expr: SUM(CAST(minimum_tonnage_guarantee AS DOUBLE))
      comment: "Total minimum tonnage guarantees across agreements"
    - name: "total_maximum_tonnage_limit"
      expr: SUM(CAST(maximum_tonnage_limit AS DOUBLE))
      comment: "Total maximum tonnage limits across agreements"
    - name: "avg_base_tipping_fee_rate"
      expr: AVG(CAST(base_tipping_fee_rate AS DOUBLE))
      comment: "Average base tipping fee rate per ton"
    - name: "avg_escalation_percentage"
      expr: AVG(CAST(escalation_percentage AS DOUBLE))
      comment: "Average escalation percentage for tipping fees"
    - name: "total_tpd_capacity"
      expr: SUM(CAST(tpd_capacity AS DOUBLE))
      comment: "Total tons per day capacity across disposal agreements"
    - name: "avg_tpd_capacity"
      expr: AVG(CAST(tpd_capacity AS DOUBLE))
      comment: "Average tons per day capacity per disposal agreement"
    - name: "total_insurance_coverage_amount"
      expr: SUM(CAST(insurance_coverage_amount AS DOUBLE))
      comment: "Total insurance coverage amounts required across agreements"
    - name: "distinct_facility_count"
      expr: COUNT(DISTINCT facility_id)
      comment: "Number of unique facilities with disposal agreements"
$$;


CREATE OR REPLACE VIEW `waste_management_ecm`.`_metrics`.`contract_hauling_agreement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Hauling agreement metrics tracking transportation rates, volume commitments, and carrier performance"
  source: "`waste_management_ecm`.`contract`.`hauling_agreement`"
  dimensions:
    - name: "agreement_status"
      expr: agreement_status
      comment: "Current status of the hauling agreement"
    - name: "effective_year"
      expr: YEAR(effective_start_date)
      comment: "Year the hauling agreement became effective"
    - name: "effective_month"
      expr: DATE_TRUNC('MONTH', effective_start_date)
      comment: "Month the hauling agreement became effective"
    - name: "rate_structure_type"
      expr: rate_structure_type
      comment: "Type of rate structure (per ton, per mile, flat rate, etc.)"
    - name: "fuel_surcharge_applicable_flag"
      expr: fuel_surcharge_applicable_flag
      comment: "Whether fuel surcharge is applicable"
    - name: "manifest_requirement_flag"
      expr: manifest_requirement_flag
      comment: "Whether waste manifest is required for hauling"
    - name: "bol_requirement_flag"
      expr: bol_requirement_flag
      comment: "Whether bill of lading is required"
    - name: "safety_rating"
      expr: safety_rating
      comment: "Safety rating of the hauler"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency code for contracted rates"
  measures:
    - name: "total_hauling_agreement_count"
      expr: COUNT(1)
      comment: "Total number of hauling agreements"
    - name: "avg_contracted_rate"
      expr: AVG(CAST(contracted_rate AS DOUBLE))
      comment: "Average contracted hauling rate"
    - name: "total_minimum_volume_commitment"
      expr: SUM(CAST(minimum_volume_commitment_tons AS DOUBLE))
      comment: "Total minimum volume commitments in tons across hauling agreements"
    - name: "total_maximum_volume_capacity"
      expr: SUM(CAST(maximum_volume_capacity_tons AS DOUBLE))
      comment: "Total maximum volume capacity in tons across hauling agreements"
    - name: "avg_minimum_volume_commitment"
      expr: AVG(CAST(minimum_volume_commitment_tons AS DOUBLE))
      comment: "Average minimum volume commitment per hauling agreement"
    - name: "avg_performance_sla_on_time_pct"
      expr: AVG(CAST(performance_sla_on_time_pct AS DOUBLE))
      comment: "Average on-time performance SLA percentage"
    - name: "total_insurance_coverage_amount"
      expr: SUM(CAST(insurance_coverage_amount AS DOUBLE))
      comment: "Total insurance coverage amounts required across hauling agreements"
    - name: "avg_insurance_coverage_amount"
      expr: AVG(CAST(insurance_coverage_amount AS DOUBLE))
      comment: "Average insurance coverage amount per hauling agreement"
    - name: "distinct_hauler_count"
      expr: COUNT(DISTINCT vendor_id)
      comment: "Number of unique hauler vendors with agreements"
    - name: "distinct_origin_facility_count"
      expr: COUNT(DISTINCT origin_facility_id)
      comment: "Number of unique origin facilities"
    - name: "distinct_destination_facility_count"
      expr: COUNT(DISTINCT facility_id)
      comment: "Number of unique destination facilities"
$$;


CREATE OR REPLACE VIEW `waste_management_ecm`.`_metrics`.`contract_termination`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Contract termination metrics tracking churn, lost value, and termination reasons to inform retention strategy"
  source: "`waste_management_ecm`.`contract`.`termination`"
  dimensions:
    - name: "termination_status"
      expr: termination_status
      comment: "Current status of the termination"
    - name: "termination_year"
      expr: YEAR(effective_termination_date)
      comment: "Year the termination became effective"
    - name: "termination_month"
      expr: DATE_TRUNC('MONTH', effective_termination_date)
      comment: "Month the termination became effective"
    - name: "termination_type"
      expr: termination_type
      comment: "Type of termination (voluntary, involuntary, etc.)"
    - name: "reason_code"
      expr: reason_code
      comment: "Reason code for termination"
    - name: "churn_classification"
      expr: churn_classification
      comment: "Classification of churn (voluntary, involuntary, competitive, etc.)"
    - name: "early_termination_flag"
      expr: early_termination_flag
      comment: "Whether the termination occurred before contract end date"
    - name: "penalty_waived_flag"
      expr: penalty_waived_flag
      comment: "Whether early termination penalty was waived"
    - name: "exit_interview_completed_flag"
      expr: exit_interview_completed_flag
      comment: "Whether an exit interview was completed"
    - name: "win_back_eligible_flag"
      expr: win_back_eligible_flag
      comment: "Whether the customer is eligible for win-back campaigns"
    - name: "initiated_by"
      expr: initiated_by
      comment: "Party that initiated the termination"
  measures:
    - name: "total_termination_count"
      expr: COUNT(1)
      comment: "Total number of contract terminations"
    - name: "total_contract_value_lost"
      expr: SUM(CAST(contract_value_lost AS DOUBLE))
      comment: "Total contract value lost due to terminations"
    - name: "avg_contract_value_lost"
      expr: AVG(CAST(contract_value_lost AS DOUBLE))
      comment: "Average contract value lost per termination"
    - name: "total_early_termination_penalty"
      expr: SUM(CAST(early_termination_penalty_amount AS DOUBLE))
      comment: "Total early termination penalty amounts assessed"
    - name: "avg_early_termination_penalty"
      expr: AVG(CAST(early_termination_penalty_amount AS DOUBLE))
      comment: "Average early termination penalty amount"
    - name: "total_outstanding_balance"
      expr: SUM(CAST(outstanding_balance_amount AS DOUBLE))
      comment: "Total outstanding balance amounts at termination"
    - name: "total_final_invoice_amount"
      expr: SUM(CAST(final_invoice_amount AS DOUBLE))
      comment: "Total final invoice amounts for terminated contracts"
    - name: "distinct_customer_count"
      expr: COUNT(DISTINCT customer_account_id)
      comment: "Number of unique customers with terminations"
    - name: "distinct_contract_count"
      expr: COUNT(DISTINCT contract_id)
      comment: "Number of unique contracts terminated"
$$;


CREATE OR REPLACE VIEW `waste_management_ecm`.`_metrics`.`contract_renewal`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Contract renewal metrics tracking retention rates, value growth, and renewal effectiveness"
  source: "`waste_management_ecm`.`contract`.`renewal`"
  dimensions:
    - name: "renewal_status"
      expr: renewal_status
      comment: "Current status of the renewal"
    - name: "renewal_year"
      expr: YEAR(effective_date)
      comment: "Year the renewal became effective"
    - name: "renewal_month"
      expr: DATE_TRUNC('MONTH', effective_date)
      comment: "Month the renewal became effective"
    - name: "renewal_type"
      expr: renewal_type
      comment: "Type of renewal (automatic, negotiated, etc.)"
    - name: "outcome"
      expr: outcome
      comment: "Outcome of the renewal process"
    - name: "auto_renewal_eligible_flag"
      expr: auto_renewal_eligible_flag
      comment: "Whether the contract was eligible for automatic renewal"
    - name: "rate_escalation_clause_applied"
      expr: rate_escalation_clause_applied
      comment: "Whether rate escalation clause was applied"
    - name: "service_level_change_flag"
      expr: service_level_change_flag
      comment: "Whether service level changed during renewal"
    - name: "competitor_threat_flag"
      expr: competitor_threat_flag
      comment: "Whether there was a competitive threat during renewal"
    - name: "opt_out_received_flag"
      expr: opt_out_received_flag
      comment: "Whether customer opted out of renewal"
  measures:
    - name: "total_renewal_count"
      expr: COUNT(1)
      comment: "Total number of contract renewals"
    - name: "total_renewed_annual_value"
      expr: SUM(CAST(renewed_annual_value AS DOUBLE))
      comment: "Total annual value of renewed contracts"
    - name: "total_previous_annual_value"
      expr: SUM(CAST(previous_annual_value AS DOUBLE))
      comment: "Total previous annual value before renewal"
    - name: "avg_renewed_annual_value"
      expr: AVG(CAST(renewed_annual_value AS DOUBLE))
      comment: "Average annual value of renewed contracts"
    - name: "avg_rate_change_percentage"
      expr: AVG(CAST(rate_change_percentage AS DOUBLE))
      comment: "Average rate change percentage during renewal"
    - name: "avg_churn_risk_score"
      expr: AVG(CAST(churn_risk_score AS DOUBLE))
      comment: "Average churn risk score at renewal time"
    - name: "distinct_customer_count"
      expr: COUNT(DISTINCT customer_account_id)
      comment: "Number of unique customers with renewals"
    - name: "distinct_contract_count"
      expr: COUNT(DISTINCT contract_id)
      comment: "Number of unique contracts renewed"
$$;


CREATE OR REPLACE VIEW `waste_management_ecm`.`_metrics`.`contract_volume_commitment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Volume commitment metrics tracking tonnage performance against contractual minimums and maximums"
  source: "`waste_management_ecm`.`contract`.`volume_commitment`"
  dimensions:
    - name: "commitment_status"
      expr: commitment_status
      comment: "Current status of the volume commitment"
    - name: "commitment_type"
      expr: commitment_type
      comment: "Type of volume commitment (minimum, maximum, target)"
    - name: "commitment_direction"
      expr: commitment_direction
      comment: "Direction of commitment (inbound, outbound)"
    - name: "effective_year"
      expr: YEAR(effective_start_date)
      comment: "Year the volume commitment became effective"
    - name: "effective_month"
      expr: DATE_TRUNC('MONTH', effective_start_date)
      comment: "Month the volume commitment became effective"
    - name: "measurement_period"
      expr: measurement_period
      comment: "Period over which volume is measured (monthly, quarterly, annually)"
    - name: "unit_of_measure"
      expr: unit_of_measure
      comment: "Unit of measure for volume (tons, cubic yards, etc.)"
    - name: "auto_renewal_flag"
      expr: auto_renewal_flag
      comment: "Whether the volume commitment auto-renews"
    - name: "force_majeure_applicable"
      expr: force_majeure_applicable
      comment: "Whether force majeure provisions apply"
  measures:
    - name: "total_commitment_count"
      expr: COUNT(1)
      comment: "Total number of volume commitments"
    - name: "total_committed_quantity"
      expr: SUM(CAST(committed_quantity AS DOUBLE))
      comment: "Total committed quantity across all volume commitments"
    - name: "total_actual_volume_to_date"
      expr: SUM(CAST(actual_volume_to_date AS DOUBLE))
      comment: "Total actual volume delivered to date"
    - name: "avg_committed_quantity"
      expr: AVG(CAST(committed_quantity AS DOUBLE))
      comment: "Average committed quantity per volume commitment"
    - name: "avg_actual_volume_to_date"
      expr: AVG(CAST(actual_volume_to_date AS DOUBLE))
      comment: "Average actual volume to date per commitment"
    - name: "total_variance_quantity"
      expr: SUM(CAST(variance_quantity AS DOUBLE))
      comment: "Total variance between committed and actual volume"
    - name: "avg_variance_percentage"
      expr: AVG(CAST(variance_percentage AS DOUBLE))
      comment: "Average variance percentage between committed and actual volume"
    - name: "avg_excess_tonnage_rate"
      expr: AVG(CAST(excess_tonnage_rate AS DOUBLE))
      comment: "Average rate charged for excess tonnage above commitment"
    - name: "avg_shortfall_penalty_rate"
      expr: AVG(CAST(shortfall_penalty_rate AS DOUBLE))
      comment: "Average penalty rate for shortfall below minimum commitment"
    - name: "total_last_true_up_amount"
      expr: SUM(CAST(last_true_up_amount AS DOUBLE))
      comment: "Total true-up amounts from last reconciliation"
    - name: "distinct_contract_count"
      expr: COUNT(DISTINCT contract_id)
      comment: "Number of unique contracts with volume commitments"
$$;


CREATE OR REPLACE VIEW `waste_management_ecm`.`_metrics`.`contract_compliance_obligation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Compliance obligation metrics tracking regulatory adherence, audit results, and penalty exposure"
  source: "`waste_management_ecm`.`contract`.`compliance_obligation`"
  dimensions:
    - name: "compliance_status"
      expr: compliance_status
      comment: "Current compliance status of the obligation"
    - name: "obligation_type"
      expr: obligation_type
      comment: "Type of compliance obligation"
    - name: "obligation_category"
      expr: obligation_category
      comment: "Category of compliance obligation"
    - name: "effective_year"
      expr: YEAR(effective_start_date)
      comment: "Year the obligation became effective"
    - name: "effective_month"
      expr: DATE_TRUNC('MONTH', effective_start_date)
      comment: "Month the obligation became effective"
    - name: "active_flag"
      expr: active_flag
      comment: "Whether the obligation is currently active"
    - name: "reporting_frequency"
      expr: reporting_frequency
      comment: "Frequency of compliance reporting required"
    - name: "audit_frequency"
      expr: audit_frequency
      comment: "Frequency of compliance audits"
    - name: "last_audit_result"
      expr: last_audit_result
      comment: "Result of the last compliance audit"
    - name: "waiver_granted"
      expr: waiver_granted
      comment: "Whether a waiver has been granted for this obligation"
    - name: "governing_regulation"
      expr: governing_regulation
      comment: "Governing regulation or statute"
  measures:
    - name: "total_obligation_count"
      expr: COUNT(1)
      comment: "Total number of compliance obligations"
    - name: "total_penalty_amount"
      expr: SUM(CAST(penalty_amount AS DOUBLE))
      comment: "Total penalty amounts for non-compliance"
    - name: "avg_penalty_amount"
      expr: AVG(CAST(penalty_amount AS DOUBLE))
      comment: "Average penalty amount per compliance obligation"
    - name: "avg_target_value"
      expr: AVG(CAST(target_value AS DOUBLE))
      comment: "Average target value for compliance metrics"
    - name: "distinct_contract_count"
      expr: COUNT(DISTINCT contract_id)
      comment: "Number of unique contracts with compliance obligations"
    - name: "distinct_regulatory_requirement_count"
      expr: COUNT(DISTINCT regulatory_requirement_id)
      comment: "Number of unique regulatory requirements"
$$;


CREATE OR REPLACE VIEW `waste_management_ecm`.`_metrics`.`contract_amendment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Contract amendment metrics tracking change frequency, financial impact, and amendment approval velocity"
  source: "`waste_management_ecm`.`contract`.`amendment`"
  dimensions:
    - name: "amendment_status"
      expr: amendment_status
      comment: "Current status of the amendment"
    - name: "amendment_type"
      expr: amendment_type
      comment: "Type of amendment (rate change, scope change, term extension, etc.)"
    - name: "effective_year"
      expr: YEAR(effective_date)
      comment: "Year the amendment became effective"
    - name: "effective_month"
      expr: DATE_TRUNC('MONTH', effective_date)
      comment: "Month the amendment became effective"
    - name: "reason_code"
      expr: reason_code
      comment: "Reason code for the amendment"
    - name: "legal_review_required"
      expr: legal_review_required
      comment: "Whether legal review was required"
    - name: "customer_signature_required"
      expr: customer_signature_required
      comment: "Whether customer signature was required"
  measures:
    - name: "total_amendment_count"
      expr: COUNT(1)
      comment: "Total number of contract amendments"
    - name: "total_financial_impact"
      expr: SUM(CAST(financial_impact_amount AS DOUBLE))
      comment: "Total financial impact of all amendments"
    - name: "avg_financial_impact"
      expr: AVG(CAST(financial_impact_amount AS DOUBLE))
      comment: "Average financial impact per amendment"
    - name: "total_rate_change_amount"
      expr: SUM(CAST(rate_change_amount AS DOUBLE))
      comment: "Total rate change amounts across amendments"
    - name: "avg_rate_change_percentage"
      expr: AVG(CAST(rate_change_percentage AS DOUBLE))
      comment: "Average rate change percentage across amendments"
    - name: "distinct_contract_count"
      expr: COUNT(DISTINCT contract_id)
      comment: "Number of unique contracts with amendments"
$$;


CREATE OR REPLACE VIEW `waste_management_ecm`.`_metrics`.`contract_performance_obligation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Performance obligation metrics tracking revenue recognition, service delivery progress, and ASC 606 compliance"
  source: "`waste_management_ecm`.`contract`.`performance_obligation`"
  dimensions:
    - name: "obligation_status"
      expr: obligation_status
      comment: "Current status of the performance obligation"
    - name: "satisfaction_method"
      expr: satisfaction_method
      comment: "Method of satisfying the performance obligation (over time, point in time)"
    - name: "revenue_recognition_pattern"
      expr: revenue_recognition_pattern
      comment: "Pattern of revenue recognition (straight-line, usage-based, milestone)"
    - name: "effective_year"
      expr: YEAR(effective_start_date)
      comment: "Year the performance obligation became effective"
    - name: "effective_month"
      expr: DATE_TRUNC('MONTH', effective_start_date)
      comment: "Month the performance obligation became effective"
    - name: "is_distinct"
      expr: is_distinct
      comment: "Whether the performance obligation is distinct"
    - name: "is_variable_consideration"
      expr: is_variable_consideration
      comment: "Whether the obligation includes variable consideration"
    - name: "contract_asset_liability_indicator"
      expr: contract_asset_liability_indicator
      comment: "Whether this creates a contract asset or liability"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency code for transaction price"
  measures:
    - name: "total_obligation_count"
      expr: COUNT(1)
      comment: "Total number of performance obligations"
    - name: "total_allocated_transaction_price"
      expr: SUM(CAST(allocated_transaction_price AS DOUBLE))
      comment: "Total transaction price allocated to performance obligations"
    - name: "total_revenue_recognized_to_date"
      expr: SUM(CAST(revenue_recognized_to_date AS DOUBLE))
      comment: "Total revenue recognized to date across all obligations"
    - name: "total_remaining_revenue"
      expr: SUM(CAST(remaining_revenue AS DOUBLE))
      comment: "Total remaining revenue to be recognized"
    - name: "avg_percentage_complete"
      expr: AVG(CAST(percentage_complete AS DOUBLE))
      comment: "Average percentage complete across performance obligations"
    - name: "total_standalone_selling_price"
      expr: SUM(CAST(standalone_selling_price AS DOUBLE))
      comment: "Total standalone selling price across obligations"
    - name: "total_variable_consideration_estimate"
      expr: SUM(CAST(variable_consideration_estimate AS DOUBLE))
      comment: "Total estimated variable consideration"
    - name: "total_cost_of_service"
      expr: SUM(CAST(cost_of_service AS DOUBLE))
      comment: "Total cost of service for performance obligations"
    - name: "total_service_quantity"
      expr: SUM(CAST(service_quantity AS DOUBLE))
      comment: "Total service quantity across obligations"
    - name: "distinct_contract_count"
      expr: COUNT(DISTINCT contract_id)
      comment: "Number of unique contracts with performance obligations"
$$;
