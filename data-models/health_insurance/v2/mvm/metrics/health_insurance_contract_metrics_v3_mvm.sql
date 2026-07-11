-- Metric views for domain: contract | Business: Health_Insurance | Version: 3 | Generated on: 2026-07-10 22:41:45

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`contract_provider_contract`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core provider contract performance metrics tracking contract volume, capitation rates, and contract lifecycle distribution across payment methodologies and contract types."
  source: "`vibe_health_insurance_v1`.`contract`.`provider_contract`"
  dimensions:
    - name: "contract_status"
      expr: contract_status
      comment: "Current status of the provider contract (active, terminated, pending, etc.)"
    - name: "contract_type"
      expr: contract_type
      comment: "Type of provider contract (fee-for-service, capitation, bundled payment, etc.)"
    - name: "payment_methodology"
      expr: payment_methodology
      comment: "Payment methodology used in the contract (FFS, capitation, per diem, case rate, etc.)"
    - name: "provider_type"
      expr: provider_type
      comment: "Type of provider (hospital, physician group, ancillary, etc.)"
    - name: "contract_tier"
      expr: contract_tier
      comment: "Network tier of the contract (tier 1, tier 2, tier 3, etc.)"
    - name: "lob_applicability"
      expr: lob_applicability
      comment: "Line of business applicability (commercial, Medicare Advantage, Medicaid, etc.)"
    - name: "risk_sharing_model"
      expr: risk_sharing_model
      comment: "Risk sharing arrangement type (upside only, downside, two-sided, etc.)"
    - name: "effective_year"
      expr: YEAR(effective_date)
      comment: "Year the contract became effective"
    - name: "effective_quarter"
      expr: CONCAT('Q', QUARTER(effective_date), '-', YEAR(effective_date))
      comment: "Quarter and year the contract became effective"
    - name: "vbc_flag"
      expr: vbc_flag
      comment: "Indicates whether the contract includes value-based care arrangements"
    - name: "capitation_eligible"
      expr: CASE WHEN capitation_rate_pmpm > 0 THEN 'Yes' ELSE 'No' END
      comment: "Indicates whether the contract has capitation rates defined"
    - name: "auto_renewal_flag"
      expr: auto_renewal_flag
      comment: "Indicates whether the contract automatically renews"
  measures:
    - name: "total_contracts"
      expr: COUNT(DISTINCT provider_contract_id)
      comment: "Total number of distinct provider contracts"
    - name: "total_capitation_pmpm"
      expr: SUM(CAST(capitation_rate_pmpm AS DOUBLE))
      comment: "Total capitation rate per member per month across all contracts"
    - name: "avg_capitation_pmpm"
      expr: AVG(CAST(capitation_rate_pmpm AS DOUBLE))
      comment: "Average capitation rate per member per month across contracts"
    - name: "contracts_with_vbc"
      expr: COUNT(DISTINCT CASE WHEN vbc_flag = TRUE THEN provider_contract_id END)
      comment: "Number of contracts with value-based care arrangements"
    - name: "vbc_penetration_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN vbc_flag = TRUE THEN provider_contract_id END) / NULLIF(COUNT(DISTINCT provider_contract_id), 0), 2)
      comment: "Percentage of contracts that include value-based care arrangements"
    - name: "contracts_with_capitation"
      expr: COUNT(DISTINCT CASE WHEN capitation_rate_pmpm > 0 THEN provider_contract_id END)
      comment: "Number of contracts with capitation payment methodology"
    - name: "unique_providers"
      expr: COUNT(DISTINCT provider_id)
      comment: "Number of unique providers under contract"
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`contract_capitation_payment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Capitation payment financial performance metrics tracking gross and net payments, risk adjustments, quality withhold, and payment efficiency across payment periods and provider arrangements."
  source: "`vibe_health_insurance_v1`.`contract`.`capitation_payment`"
  dimensions:
    - name: "payment_status"
      expr: payment_status
      comment: "Status of the capitation payment (paid, pending, voided, etc.)"
    - name: "payment_type"
      expr: payment_type
      comment: "Type of capitation payment (regular, adjustment, supplemental, etc.)"
    - name: "payment_method"
      expr: payment_method
      comment: "Method of payment (check, EFT, ACH, wire, etc.)"
    - name: "line_of_business"
      expr: line_of_business
      comment: "Line of business for the capitation payment"
    - name: "capitation_rate_tier"
      expr: capitation_rate_tier
      comment: "Rate tier for the capitation payment (age/gender bands, risk tiers, etc.)"
    - name: "payment_year"
      expr: YEAR(payment_date)
      comment: "Year the payment was made"
    - name: "payment_month"
      expr: DATE_TRUNC('MONTH', payment_date)
      comment: "Month the payment was made"
    - name: "payment_period_month"
      expr: DATE_TRUNC('MONTH', payment_period_start_date)
      comment: "Month of the payment period being paid"
    - name: "prior_period_adjustment_flag"
      expr: prior_period_adjustment_flag
      comment: "Indicates whether the payment includes prior period adjustments"
    - name: "vbc_contract_flag"
      expr: vbc_contract_flag
      comment: "Indicates whether the payment is associated with a value-based care contract"
  measures:
    - name: "total_payments"
      expr: COUNT(DISTINCT capitation_payment_id)
      comment: "Total number of capitation payments processed"
    - name: "total_gross_payment_amount"
      expr: SUM(CAST(gross_payment_amount AS DOUBLE))
      comment: "Total gross capitation payment amount before withhold and adjustments"
    - name: "total_net_payment_amount"
      expr: SUM(CAST(net_payment_amount AS DOUBLE))
      comment: "Total net capitation payment amount after all adjustments and withholds"
    - name: "total_quality_withhold"
      expr: SUM(CAST(quality_withhold_amount AS DOUBLE))
      comment: "Total amount withheld for quality performance incentives"
    - name: "total_risk_pool_withhold"
      expr: SUM(CAST(risk_pool_withhold_amount AS DOUBLE))
      comment: "Total amount withheld for risk pool participation"
    - name: "total_enrollment_adjustment"
      expr: SUM(CAST(enrollment_adjustment_amount AS DOUBLE))
      comment: "Total enrollment adjustment amount (positive or negative)"
    - name: "total_stop_loss_recovery"
      expr: SUM(CAST(stop_loss_recovery_amount AS DOUBLE))
      comment: "Total stop loss recovery amount received"
    - name: "avg_pmpm_rate"
      expr: AVG(CAST(pmpm_rate AS DOUBLE))
      comment: "Average per member per month capitation rate"
    - name: "avg_risk_adjusted_pmpm"
      expr: AVG(CAST(risk_adjusted_pmpm_rate AS DOUBLE))
      comment: "Average risk-adjusted per member per month rate"
    - name: "avg_risk_score"
      expr: AVG(CAST(risk_score AS DOUBLE))
      comment: "Average member risk score across capitation payments"
    - name: "quality_withhold_rate"
      expr: ROUND(100.0 * SUM(CAST(quality_withhold_amount AS DOUBLE)) / NULLIF(SUM(CAST(gross_payment_amount AS DOUBLE)), 0), 2)
      comment: "Quality withhold as a percentage of gross payment amount"
    - name: "net_payment_yield"
      expr: ROUND(100.0 * SUM(CAST(net_payment_amount AS DOUBLE)) / NULLIF(SUM(CAST(gross_payment_amount AS DOUBLE)), 0), 2)
      comment: "Net payment as a percentage of gross payment (payment efficiency)"
    - name: "payments_with_adjustments"
      expr: COUNT(DISTINCT CASE WHEN prior_period_adjustment_flag = TRUE THEN capitation_payment_id END)
      comment: "Number of payments that include prior period adjustments"
    - name: "unique_providers_paid"
      expr: COUNT(DISTINCT provider_id)
      comment: "Number of unique providers receiving capitation payments"
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`contract_vbc_contract`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Value-based care contract performance metrics tracking shared savings, risk arrangement performance, quality gate achievement, and financial reconciliation outcomes across VBC models and performance periods."
  source: "`vibe_health_insurance_v1`.`contract`.`vbc_contract`"
  dimensions:
    - name: "vbc_model_type"
      expr: vbc_model_type
      comment: "Type of value-based care model (ACO, bundled payment, episode-based, shared savings, etc.)"
    - name: "risk_arrangement_type"
      expr: risk_arrangement_type
      comment: "Type of risk arrangement (upside only, downside risk, two-sided risk, etc.)"
    - name: "reconciliation_status"
      expr: reconciliation_status
      comment: "Status of financial reconciliation (pending, in progress, completed, disputed, etc.)"
    - name: "line_of_business"
      expr: line_of_business
      comment: "Line of business for the VBC contract"
    - name: "cms_program_track"
      expr: cms_program_track
      comment: "CMS program track for ACO contracts (Track 1, Track 2, Track 3, etc.)"
    - name: "performance_year"
      expr: performance_year
      comment: "Performance year for the VBC contract"
    - name: "quality_gate_met"
      expr: quality_gate_met
      comment: "Indicates whether the quality gate threshold was met to earn shared savings"
    - name: "episode_type"
      expr: episode_type
      comment: "Type of episode for episode-based payment models"
    - name: "attribution_methodology"
      expr: attribution_methodology
      comment: "Methodology used to attribute members to the VBC arrangement"
    - name: "reconciliation_methodology"
      expr: reconciliation_methodology
      comment: "Methodology used for financial reconciliation"
    - name: "performance_period_year"
      expr: YEAR(performance_period_start)
      comment: "Year of the performance period start date"
  measures:
    - name: "total_vbc_contracts"
      expr: COUNT(DISTINCT vbc_contract_id)
      comment: "Total number of value-based care contracts"
    - name: "total_benchmark_target"
      expr: SUM(CAST(benchmark_expenditure_target AS DOUBLE))
      comment: "Total benchmark expenditure target across all VBC contracts"
    - name: "total_actual_expenditure"
      expr: SUM(CAST(actual_expenditure AS DOUBLE))
      comment: "Total actual expenditure across all VBC contracts"
    - name: "total_shared_savings"
      expr: SUM(CAST(shared_savings_amount AS DOUBLE))
      comment: "Total shared savings amount earned across all VBC contracts"
    - name: "total_episode_target_price"
      expr: SUM(CAST(episode_target_price AS DOUBLE))
      comment: "Total episode target price for episode-based payment models"
    - name: "avg_quality_score"
      expr: AVG(CAST(quality_score AS DOUBLE))
      comment: "Average quality score across VBC contracts"
    - name: "avg_savings_sharing_rate"
      expr: AVG(CAST(savings_sharing_rate AS DOUBLE))
      comment: "Average savings sharing rate percentage"
    - name: "avg_max_shared_savings_rate"
      expr: AVG(CAST(max_shared_savings_rate AS DOUBLE))
      comment: "Average maximum shared savings rate percentage"
    - name: "avg_max_shared_loss_rate"
      expr: AVG(CAST(max_shared_loss_rate AS DOUBLE))
      comment: "Average maximum shared loss rate percentage for downside risk arrangements"
    - name: "contracts_meeting_quality_gate"
      expr: COUNT(DISTINCT CASE WHEN quality_gate_met = TRUE THEN vbc_contract_id END)
      comment: "Number of VBC contracts that met the quality gate threshold"
    - name: "quality_gate_achievement_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN quality_gate_met = TRUE THEN vbc_contract_id END) / NULLIF(COUNT(DISTINCT vbc_contract_id), 0), 2)
      comment: "Percentage of VBC contracts that achieved the quality gate threshold"
    - name: "savings_realization_rate"
      expr: ROUND(100.0 * SUM(CAST(shared_savings_amount AS DOUBLE)) / NULLIF(SUM(CAST(benchmark_expenditure_target AS DOUBLE)), 0), 2)
      comment: "Shared savings as a percentage of benchmark target (savings yield)"
    - name: "expenditure_performance_index"
      expr: ROUND(100.0 * SUM(CAST(actual_expenditure AS DOUBLE)) / NULLIF(SUM(CAST(benchmark_expenditure_target AS DOUBLE)), 0), 2)
      comment: "Actual expenditure as a percentage of benchmark target (lower is better)"
    - name: "avg_stop_loss_threshold"
      expr: AVG(CAST(stop_loss_threshold AS DOUBLE))
      comment: "Average stop loss threshold amount for risk protection"
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`contract_fee_schedule_rate`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Fee schedule rate metrics tracking allowed amounts, payment methodology distribution, and rate variance across procedure codes, service categories, and network tiers."
  source: "`vibe_health_insurance_v1`.`contract`.`fee_schedule_rate`"
  dimensions:
    - name: "procedure_code_type"
      expr: procedure_code_type
      comment: "Type of procedure code (CPT, HCPCS, ICD-10-PCS, DRG, revenue code, etc.)"
    - name: "payment_methodology"
      expr: payment_methodology
      comment: "Payment methodology for the rate (fee schedule, percent of billed, per diem, case rate, etc.)"
    - name: "service_category"
      expr: service_category
      comment: "Category of service (inpatient, outpatient, professional, ancillary, etc.)"
    - name: "network_tier"
      expr: network_tier
      comment: "Network tier for the rate (tier 1, tier 2, tier 3, out-of-network, etc.)"
    - name: "line_of_business"
      expr: line_of_business
      comment: "Line of business applicability for the rate"
    - name: "place_of_service_code"
      expr: place_of_service_code
      comment: "Place of service code where the rate applies"
    - name: "provider_type"
      expr: provider_type
      comment: "Type of provider for which the rate applies"
    - name: "rate_status"
      expr: rate_status
      comment: "Status of the fee schedule rate (active, inactive, pending, superseded, etc.)"
    - name: "rate_derivation_method"
      expr: rate_derivation_method
      comment: "Method used to derive the rate (negotiated, Medicare-based, market-based, etc.)"
    - name: "geographic_region"
      expr: geographic_region
      comment: "Geographic region or locality for the rate"
    - name: "effective_year"
      expr: YEAR(effective_date)
      comment: "Year the rate became effective"
    - name: "ncci_edit_indicator"
      expr: ncci_edit_indicator
      comment: "Indicates whether NCCI edits apply to this rate"
  measures:
    - name: "total_rates"
      expr: COUNT(DISTINCT fee_schedule_rate_id)
      comment: "Total number of fee schedule rates"
    - name: "total_allowed_amount"
      expr: SUM(CAST(allowed_amount AS DOUBLE))
      comment: "Total allowed amount across all fee schedule rates"
    - name: "avg_allowed_amount"
      expr: AVG(CAST(allowed_amount AS DOUBLE))
      comment: "Average allowed amount per fee schedule rate"
    - name: "total_bundled_payment_amount"
      expr: SUM(CAST(bundled_payment_amount AS DOUBLE))
      comment: "Total bundled payment amount for bundled payment rates"
    - name: "avg_per_diem_rate"
      expr: AVG(CAST(per_diem_rate AS DOUBLE))
      comment: "Average per diem rate for per diem payment methodology"
    - name: "avg_rate_percent_of_billed"
      expr: AVG(CAST(rate_percent_of_billed AS DOUBLE))
      comment: "Average rate as a percentage of billed charges"
    - name: "avg_medicare_fee_schedule_pct"
      expr: AVG(CAST(medicare_fee_schedule_pct AS DOUBLE))
      comment: "Average rate as a percentage of Medicare fee schedule"
    - name: "unique_procedure_codes"
      expr: COUNT(DISTINCT procedure_code)
      comment: "Number of unique procedure codes with rates defined"
    - name: "unique_drg_codes"
      expr: COUNT(DISTINCT drg_code)
      comment: "Number of unique DRG codes with rates defined"
    - name: "rates_with_ncci_edits"
      expr: COUNT(DISTINCT CASE WHEN ncci_edit_indicator = TRUE THEN fee_schedule_rate_id END)
      comment: "Number of rates with NCCI edit indicators"
    - name: "avg_capitation_rate_pmpm"
      expr: AVG(CAST(capitation_rate_pmpm AS DOUBLE))
      comment: "Average capitation rate per member per month for capitation-based rates"
    - name: "total_mac_amount"
      expr: SUM(CAST(mac_amount AS DOUBLE))
      comment: "Total maximum allowable cost amount for pharmacy rates"
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`contract_capitation_arrangement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Capitation arrangement strategic metrics tracking PMPM rates, risk adjustment factors, withhold percentages, and value-based care penetration across arrangement types and service categories."
  source: "`vibe_health_insurance_v1`.`contract`.`capitation_arrangement`"
  dimensions:
    - name: "arrangement_type"
      expr: arrangement_type
      comment: "Type of capitation arrangement (full risk, partial risk, specialty capitation, etc.)"
    - name: "arrangement_status"
      expr: arrangement_status
      comment: "Status of the capitation arrangement (active, pending, terminated, etc.)"
    - name: "payment_methodology"
      expr: payment_methodology
      comment: "Payment methodology for the capitation arrangement"
    - name: "service_category_scope"
      expr: service_category_scope
      comment: "Scope of services covered by the capitation arrangement"
    - name: "lob_code"
      expr: lob_code
      comment: "Line of business code for the arrangement"
    - name: "network_tier"
      expr: network_tier
      comment: "Network tier for the capitation arrangement"
    - name: "attribution_method"
      expr: attribution_method
      comment: "Method used to attribute members to the capitation arrangement"
    - name: "payment_frequency"
      expr: payment_frequency
      comment: "Frequency of capitation payments (monthly, quarterly, etc.)"
    - name: "vbc_arrangement_flag"
      expr: vbc_arrangement_flag
      comment: "Indicates whether the arrangement includes value-based care components"
    - name: "risk_adjustment_applicable"
      expr: risk_adjustment_applicable
      comment: "Indicates whether risk adjustment applies to the arrangement"
    - name: "risk_pool_participant"
      expr: risk_pool_participant
      comment: "Indicates whether the arrangement participates in a risk pool"
    - name: "aco_arrangement_flag"
      expr: aco_arrangement_flag
      comment: "Indicates whether the arrangement is part of an ACO"
    - name: "effective_year"
      expr: YEAR(effective_date)
      comment: "Year the arrangement became effective"
  measures:
    - name: "total_arrangements"
      expr: COUNT(DISTINCT capitation_arrangement_id)
      comment: "Total number of capitation arrangements"
    - name: "total_pmpm_rate"
      expr: SUM(CAST(pmpm_rate AS DOUBLE))
      comment: "Total per member per month capitation rate across all arrangements"
    - name: "avg_pmpm_rate"
      expr: AVG(CAST(pmpm_rate AS DOUBLE))
      comment: "Average per member per month capitation rate"
    - name: "avg_withhold_percentage"
      expr: AVG(CAST(withhold_percentage AS DOUBLE))
      comment: "Average withhold percentage for quality or risk pool participation"
    - name: "avg_risk_share_percentage"
      expr: AVG(CAST(risk_share_percentage AS DOUBLE))
      comment: "Average risk share percentage for risk-sharing arrangements"
    - name: "avg_raf_adjustment_factor"
      expr: AVG(CAST(raf_adjustment_factor AS DOUBLE))
      comment: "Average risk adjustment factor applied to capitation rates"
    - name: "avg_annual_rate_escalator"
      expr: AVG(CAST(annual_rate_escalator AS DOUBLE))
      comment: "Average annual rate escalator percentage for multi-year arrangements"
    - name: "avg_individual_stop_loss_threshold"
      expr: AVG(CAST(individual_stop_loss_threshold AS DOUBLE))
      comment: "Average individual stop loss threshold amount"
    - name: "avg_aggregate_stop_loss_threshold"
      expr: AVG(CAST(aggregate_stop_loss_threshold AS DOUBLE))
      comment: "Average aggregate stop loss threshold amount"
    - name: "arrangements_with_vbc"
      expr: COUNT(DISTINCT CASE WHEN vbc_arrangement_flag = TRUE THEN capitation_arrangement_id END)
      comment: "Number of capitation arrangements with value-based care components"
    - name: "vbc_arrangement_penetration"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN vbc_arrangement_flag = TRUE THEN capitation_arrangement_id END) / NULLIF(COUNT(DISTINCT capitation_arrangement_id), 0), 2)
      comment: "Percentage of capitation arrangements that include value-based care components"
    - name: "arrangements_with_risk_adjustment"
      expr: COUNT(DISTINCT CASE WHEN risk_adjustment_applicable = TRUE THEN capitation_arrangement_id END)
      comment: "Number of arrangements with risk adjustment applied"
    - name: "arrangements_in_risk_pool"
      expr: COUNT(DISTINCT CASE WHEN risk_pool_participant = TRUE THEN capitation_arrangement_id END)
      comment: "Number of arrangements participating in a risk pool"
    - name: "aco_arrangements"
      expr: COUNT(DISTINCT CASE WHEN aco_arrangement_flag = TRUE THEN capitation_arrangement_id END)
      comment: "Number of capitation arrangements that are part of an ACO"
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`contract_reimbursement_policy`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Reimbursement policy governance metrics tracking policy distribution, reduction rates, override patterns, and regulatory compliance across payment methodologies and service categories."
  source: "`vibe_health_insurance_v1`.`contract`.`reimbursement_policy`"
  dimensions:
    - name: "policy_type"
      expr: policy_type
      comment: "Type of reimbursement policy (bundling, NCCI edit, global surgery, multiple procedure, etc.)"
    - name: "policy_status"
      expr: policy_status
      comment: "Status of the reimbursement policy (active, inactive, pending, superseded, etc.)"
    - name: "payment_methodology"
      expr: payment_methodology
      comment: "Payment methodology the policy applies to"
    - name: "lob"
      expr: lob
      comment: "Line of business the policy applies to"
    - name: "network_tier"
      expr: network_tier
      comment: "Network tier the policy applies to"
    - name: "policy_source"
      expr: policy_source
      comment: "Source of the reimbursement policy (CMS, internal, industry standard, etc.)"
    - name: "ncci_edit_type"
      expr: ncci_edit_type
      comment: "Type of NCCI edit (column 1/column 2 edit, mutually exclusive edit, etc.)"
    - name: "applies_to_facility"
      expr: applies_to_facility
      comment: "Indicates whether the policy applies to facility claims"
    - name: "applies_to_professional"
      expr: applies_to_professional
      comment: "Indicates whether the policy applies to professional claims"
    - name: "override_allowed"
      expr: override_allowed
      comment: "Indicates whether the policy can be overridden"
    - name: "regulatory_mandate_flag"
      expr: regulatory_mandate_flag
      comment: "Indicates whether the policy is mandated by regulation"
    - name: "effective_year"
      expr: YEAR(effective_date)
      comment: "Year the policy became effective"
  measures:
    - name: "total_policies"
      expr: COUNT(DISTINCT reimbursement_policy_id)
      comment: "Total number of reimbursement policies"
    - name: "avg_reduction_pct"
      expr: AVG(CAST(reduction_pct AS DOUBLE))
      comment: "Average reduction percentage applied by reimbursement policies"
    - name: "policies_with_override_allowed"
      expr: COUNT(DISTINCT CASE WHEN override_allowed = TRUE THEN reimbursement_policy_id END)
      comment: "Number of policies that allow overrides"
    - name: "override_flexibility_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN override_allowed = TRUE THEN reimbursement_policy_id END) / NULLIF(COUNT(DISTINCT reimbursement_policy_id), 0), 2)
      comment: "Percentage of policies that allow overrides (policy flexibility indicator)"
    - name: "regulatory_mandated_policies"
      expr: COUNT(DISTINCT CASE WHEN regulatory_mandate_flag = TRUE THEN reimbursement_policy_id END)
      comment: "Number of policies mandated by regulation"
    - name: "regulatory_compliance_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN regulatory_mandate_flag = TRUE THEN reimbursement_policy_id END) / NULLIF(COUNT(DISTINCT reimbursement_policy_id), 0), 2)
      comment: "Percentage of policies that are regulatory mandates (compliance coverage)"
    - name: "policies_requiring_diagnosis"
      expr: COUNT(DISTINCT CASE WHEN diagnosis_code_required = TRUE THEN reimbursement_policy_id END)
      comment: "Number of policies that require diagnosis codes"
    - name: "policies_with_retroactive_adjustment"
      expr: COUNT(DISTINCT CASE WHEN retroactive_adjustment_allowed = TRUE THEN reimbursement_policy_id END)
      comment: "Number of policies that allow retroactive adjustments"
    - name: "facility_applicable_policies"
      expr: COUNT(DISTINCT CASE WHEN applies_to_facility = TRUE THEN reimbursement_policy_id END)
      comment: "Number of policies applicable to facility claims"
    - name: "professional_applicable_policies"
      expr: COUNT(DISTINCT CASE WHEN applies_to_professional = TRUE THEN reimbursement_policy_id END)
      comment: "Number of policies applicable to professional claims"
$$;