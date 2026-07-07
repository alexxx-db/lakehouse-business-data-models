-- Metric views for domain: claim | Business: Health Insurance | Version: 2 | Generated on: 2026-06-28 00:14:33

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`claim_accumulator`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Member benefit accumulator metrics tracking deductible and out-of-pocket maximum progress. Essential for benefit administration, ACA compliance, and member financial exposure management."
  source: "`vibe_health_insurance_v1`.`claim`.`accumulator`"
  dimensions:
    - name: "accumulator_type"
      expr: accumulator_type
      comment: "Type of accumulator (deductible, OOP max, copay, coinsurance) for benefit category analysis."
    - name: "accumulator_status"
      expr: accumulator_status
      comment: "Current accumulator status (active, met, reset) for benefit administration."
    - name: "benefit_category"
      expr: benefit_category
      comment: "Benefit category the accumulator applies to for benefit design analysis."
    - name: "network_tier"
      expr: network_tier
      comment: "Network tier (in-network, out-of-network) for tiered accumulator tracking."
    - name: "line_of_business"
      expr: line_of_business
      comment: "Line of business for accumulator segmentation by product."
    - name: "benefit_period_start_month"
      expr: DATE_TRUNC('MONTH', benefit_period_start)
      comment: "Benefit period start month for annual accumulator reset tracking."
    - name: "is_adjustment"
      expr: is_adjustment
      comment: "Flag for accumulator adjustments — tracks retroactive corrections to member cost-sharing."
    - name: "is_reversal"
      expr: is_reversal
      comment: "Flag for accumulator reversals — tracks corrections that reduce accumulated amounts."
    - name: "accumulator_code"
      expr: accumulator_code
      comment: "Specific accumulator code for granular benefit tracking."
  measures:
    - name: "total_accumulated_amount"
      expr: SUM(CAST(accumulated_amount AS DOUBLE))
      comment: "Total amount accumulated toward benefit limits. Tracks member progress toward deductible and OOP maximum."
    - name: "total_remaining_balance"
      expr: SUM(CAST(remaining_balance AS DOUBLE))
      comment: "Total remaining balance before benefit limits are met. Measures member financial exposure and benefit adequacy."
    - name: "total_limit_amount"
      expr: SUM(CAST(limit_amount AS DOUBLE))
      comment: "Total benefit limit amounts across accumulators. Tracks ACA OOP maximum compliance across the member population."
    - name: "distinct_member_count"
      expr: COUNT(DISTINCT member_identity_id)
      comment: "Number of unique members with active accumulators. Used for per-member benefit utilization analysis."
    - name: "accumulator_met_count"
      expr: COUNT(CASE WHEN accumulator_status = 'MET' THEN 1 END)
      comment: "Count of accumulators where the limit has been met. Members who have met their OOP max have 100% plan coverage — tracks high-cost member population."
    - name: "total_accumulator_count"
      expr: COUNT(1)
      comment: "Total accumulator records. Baseline for benefit administration completeness monitoring."
    - name: "avg_accumulated_amount"
      expr: AVG(CAST(accumulated_amount AS DOUBLE))
      comment: "Average accumulated amount per record. Benchmarks member cost-sharing burden and benefit design effectiveness."
    - name: "avg_remaining_balance"
      expr: AVG(CAST(remaining_balance AS DOUBLE))
      comment: "Average remaining balance before limit. Tracks population-level benefit utilization and financial exposure."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`claim_adjudication`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Claim adjudication quality and financial accuracy metrics. Tracks auto-adjudication rates, edit outcomes, COB adjustments, and medical necessity decisions — critical for operational efficiency and payment integrity."
  source: "`vibe_health_insurance_v1`.`claim`.`adjudication`"
  dimensions:
    - name: "adjudication_status"
      expr: adjudication_status
      comment: "Final adjudication status (approved, denied, pended) for pipeline and quality analysis."
    - name: "claim_type"
      expr: claim_type
      comment: "Type of claim being adjudicated for segmented performance analysis."
    - name: "network_status"
      expr: network_status
      comment: "In-network vs. out-of-network status — drives allowed amount methodology and member cost-sharing."
    - name: "auto_adjudication_flag"
      expr: auto_adjudication_flag
      comment: "Whether the claim was auto-adjudicated without human intervention — key operational efficiency indicator."
    - name: "medical_necessity_flag"
      expr: medical_necessity_flag
      comment: "Whether medical necessity was a factor in adjudication — tracks clinical review workload."
    - name: "adjudication_month"
      expr: DATE_TRUNC('MONTH', adjudication_timestamp)
      comment: "Month of adjudication for throughput trending and SLA compliance."
    - name: "service_month"
      expr: DATE_TRUNC('MONTH', service_date)
      comment: "Month of service for lag analysis between service and adjudication."
    - name: "prior_authorization_status"
      expr: prior_authorization_status
      comment: "Prior authorization status at adjudication — identifies PA compliance gaps."
    - name: "allowed_amount_method"
      expr: allowed_amount_method
      comment: "Methodology used to determine allowed amount (fee schedule, UCR, MAC) for contract performance analysis."
    - name: "edit_outcome"
      expr: edit_outcome
      comment: "Outcome of claim edits (passed, failed, bypassed) for payment integrity monitoring."
  measures:
    - name: "total_adjudicated_claims"
      expr: COUNT(1)
      comment: "Total claims adjudicated. Baseline throughput metric for operational capacity planning."
    - name: "total_allowed_amount"
      expr: SUM(CAST(allowed_amount AS DOUBLE))
      comment: "Total allowed amount across adjudicated claims. Core medical cost metric for financial reporting."
    - name: "total_paid_amount"
      expr: SUM(CAST(total_net_amount AS DOUBLE))
      comment: "Total net payment amount after all adjustments. Primary financial output of the adjudication process."
    - name: "total_deductible_applied"
      expr: SUM(CAST(deductible_amount AS DOUBLE))
      comment: "Total deductible amounts applied to members. Tracks member cost-sharing and benefit design effectiveness."
    - name: "total_oop_applied"
      expr: SUM(CAST(oop_amount AS DOUBLE))
      comment: "Total out-of-pocket amounts applied. Monitors member financial exposure and ACA OOP maximum compliance."
    - name: "total_cob_adjusted_amount"
      expr: SUM(CAST(cob_adjusted_amount AS DOUBLE))
      comment: "Total amount adjusted via coordination of benefits. Measures COB recovery effectiveness and secondary payer savings."
    - name: "auto_adjudicated_claim_count"
      expr: COUNT(CASE WHEN auto_adjudication_flag = TRUE THEN 1 END)
      comment: "Count of auto-adjudicated claims. Higher auto-adjudication rates reduce operational cost — key efficiency KPI."
    - name: "edit_override_count"
      expr: COUNT(CASE WHEN edit_override_flag = TRUE THEN 1 END)
      comment: "Count of claims where edit rules were overridden. High override rates signal payment integrity risk and require audit attention."
    - name: "total_charge_amount"
      expr: SUM(CAST(total_charge_amount AS DOUBLE))
      comment: "Total billed charges across adjudicated claims. Used to compute discount-from-billed metrics."
    - name: "total_adjustment_amount"
      expr: SUM(CAST(total_adjustment_amount AS DOUBLE))
      comment: "Total post-adjudication adjustments applied. Tracks retroactive payment corrections and their financial impact."
    - name: "accumulator_deductible_impact_total"
      expr: SUM(CAST(accumulator_deductible_impact AS DOUBLE))
      comment: "Total deductible accumulator impact across adjudicated claims. Feeds benefit accumulator tracking for member cost-sharing compliance."
    - name: "accumulator_oop_impact_total"
      expr: SUM(CAST(accumulator_oop_impact AS DOUBLE))
      comment: "Total OOP accumulator impact. Monitors progress toward ACA OOP maximum limits across the member population."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`claim_adjudication_rate`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Adjudication rate and fee schedule performance metrics. Tracks allowed amounts, rate types, and geographic pricing — essential for contract management, network adequacy, and provider payment accuracy."
  source: "`vibe_health_insurance_v1`.`claim`.`adjudication_rate`"
  dimensions:
    - name: "adjudication_rate_status"
      expr: adjudication_rate_status
      comment: "Status of the adjudication rate (active, expired, pending) for rate lifecycle management."
    - name: "rate_type"
      expr: rate_type
      comment: "Type of rate (fee schedule, UCR, MAC, capitation) for payment methodology analysis."
    - name: "rate_source"
      expr: rate_source
      comment: "Source of the rate (Medicare, commercial, negotiated) for rate benchmarking."
    - name: "network_tier"
      expr: network_tier
      comment: "Network tier for tiered rate analysis and contract performance."
    - name: "provider_type"
      expr: provider_type
      comment: "Provider type for specialty-level rate analysis."
    - name: "provider_specialty_code"
      expr: provider_specialty_code
      comment: "Provider specialty code for specialty-level fee schedule performance."
    - name: "geographic_state"
      expr: geographic_state
      comment: "State for geographic rate variation analysis."
    - name: "place_of_service_code"
      expr: place_of_service_code
      comment: "Place of service for site-of-care rate differentiation."
    - name: "rvu_based_flag"
      expr: rvu_based_flag
      comment: "RVU-based rate flag for payment methodology segmentation."
    - name: "effective_month"
      expr: DATE_TRUNC('MONTH', effective_date)
      comment: "Month the rate became effective for rate change trend analysis."
  measures:
    - name: "total_allowed_amount"
      expr: SUM(CAST(allowed_amount AS DOUBLE))
      comment: "Total allowed amounts across adjudication rates. Measures aggregate contract value and payment liability."
    - name: "avg_allowed_amount"
      expr: AVG(CAST(allowed_amount AS DOUBLE))
      comment: "Average allowed amount per rate record. Benchmarks fee schedule levels against market and Medicare rates."
    - name: "avg_medicare_fee_schedule_percent"
      expr: AVG(CAST(medicare_fee_schedule_percent AS DOUBLE))
      comment: "Average percentage of Medicare fee schedule. Key contract performance metric — tracks how contracted rates compare to Medicare benchmark."
    - name: "avg_awp_percentage"
      expr: AVG(CAST(awp_percentage AS DOUBLE))
      comment: "Average AWP percentage for drug-related rates. Tracks pharmacy pricing relative to Average Wholesale Price."
    - name: "avg_mac_rate"
      expr: AVG(CAST(mac_rate AS DOUBLE))
      comment: "Average Maximum Allowable Cost rate. Tracks generic drug pricing performance under MAC pricing arrangements."
    - name: "active_rate_count"
      expr: COUNT(CASE WHEN adjudication_rate_status = 'ACTIVE' THEN 1 END)
      comment: "Count of active adjudication rates. Tracks fee schedule coverage completeness for network adequacy."
    - name: "total_rate_count"
      expr: COUNT(1)
      comment: "Total adjudication rate records. Baseline for fee schedule completeness and coverage analysis."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`claim_adjustment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Claim adjustment and overpayment recovery metrics. Tracks retroactive payment corrections, fraud indicators, and recovery performance — critical for payment integrity, audit compliance, and financial accuracy."
  source: "`vibe_health_insurance_v1`.`claim`.`adjustment`"
  dimensions:
    - name: "adjustment_type"
      expr: adjustment_type
      comment: "Type of adjustment (overpayment, underpayment, COB, audit) for root cause categorization."
    - name: "adjustment_status"
      expr: adjustment_status
      comment: "Current status of the adjustment (pending, applied, recovered) for pipeline management."
    - name: "reason_code"
      expr: reason_code
      comment: "Adjustment reason code for trend analysis and provider education targeting."
    - name: "overpayment_type"
      expr: overpayment_type
      comment: "Type of overpayment (duplicate, COB, pricing error) for recovery prioritization."
    - name: "recovery_status"
      expr: recovery_status
      comment: "Recovery status of overpayment adjustments — tracks financial recovery pipeline."
    - name: "adjustment_month"
      expr: DATE_TRUNC('MONTH', adjustment_date)
      comment: "Month of adjustment for financial period impact analysis."
    - name: "is_fraud"
      expr: is_fraud
      comment: "Fraud indicator — adjustments flagged as fraudulent require SIU referral and regulatory reporting."
    - name: "is_reversal"
      expr: is_reversal
      comment: "Reversal flag — identifies full payment reversals vs. partial adjustments."
    - name: "audit_type"
      expr: audit_type
      comment: "Type of audit that triggered the adjustment (RAC, internal, external) for audit program ROI analysis."
    - name: "regulatory_reporting_flag"
      expr: regulatory_reporting_flag
      comment: "Flag for adjustments requiring regulatory reporting (60-day rule compliance)."
  measures:
    - name: "total_adjusted_amount"
      expr: SUM(CAST(adjusted_amount AS DOUBLE))
      comment: "Total amount adjusted across all claim adjustments. Measures the financial scale of payment corrections."
    - name: "total_net_adjustment_amount"
      expr: SUM(CAST(net_adjustment_amount AS DOUBLE))
      comment: "Total net adjustment impact after offsets. Represents actual financial correction to the GL."
    - name: "total_original_amount"
      expr: SUM(CAST(original_amount AS DOUBLE))
      comment: "Total original payment amounts subject to adjustment. Baseline for calculating adjustment rate."
    - name: "total_adjustment_count"
      expr: COUNT(1)
      comment: "Total number of claim adjustments. Volume metric for payment integrity program sizing."
    - name: "overpayment_adjustment_count"
      expr: COUNT(CASE WHEN overpayment_indicator = TRUE THEN 1 END)
      comment: "Count of overpayment adjustments. Tracks payment integrity findings requiring recovery action."
    - name: "fraud_adjustment_count"
      expr: COUNT(CASE WHEN is_fraud = TRUE THEN 1 END)
      comment: "Count of fraud-flagged adjustments. Drives SIU referrals and regulatory reporting obligations."
    - name: "reversal_count"
      expr: COUNT(CASE WHEN is_reversal = TRUE THEN 1 END)
      comment: "Count of full payment reversals. High reversal rates indicate systemic adjudication errors."
    - name: "regulatory_reporting_adjustment_count"
      expr: COUNT(CASE WHEN regulatory_reporting_flag = TRUE THEN 1 END)
      comment: "Count of adjustments requiring regulatory reporting under the 60-day overpayment rule. Tracks compliance exposure."
    - name: "avg_net_adjustment_amount"
      expr: AVG(CAST(net_adjustment_amount AS DOUBLE))
      comment: "Average net adjustment per record. Benchmarks adjustment severity and prioritizes recovery efforts."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`claim_cob`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Coordination of Benefits (COB) processing metrics. Tracks COB savings, crossover claims, and MSP compliance — essential for cost avoidance, regulatory compliance, and secondary payer recovery."
  source: "`vibe_health_insurance_v1`.`claim`.`cob`"
  dimensions:
    - name: "cob_status"
      expr: cob_status
      comment: "COB processing status (processed, pending, error) for pipeline management."
    - name: "other_insurance_type"
      expr: other_insurance_type
      comment: "Type of other insurance (employer group, Medicare, Medicaid) for COB source analysis."
    - name: "msp_type"
      expr: msp_type
      comment: "Medicare Secondary Payer type for MSP compliance monitoring and CMS reporting."
    - name: "crossover_claim_flag"
      expr: crossover_claim_flag
      comment: "Crossover claim indicator for Medicaid/Medicare dual-eligible claim routing."
    - name: "msp_indicator"
      expr: msp_indicator
      comment: "Medicare Secondary Payer indicator for MSP compliance tracking."
    - name: "cob_process_month"
      expr: DATE_TRUNC('MONTH', processed_timestamp)
      comment: "Month COB was processed for throughput and lag analysis."
    - name: "medicaid_crossover_indicator"
      expr: medicaid_crossover_indicator
      comment: "Medicaid crossover indicator for dual-eligible population cost analysis."
  measures:
    - name: "total_primary_payer_paid_amount"
      expr: SUM(CAST(primary_payer_paid_amount AS DOUBLE))
      comment: "Total amount paid by the primary payer. Measures primary payer contribution and our secondary liability."
    - name: "total_secondary_payer_paid_amount"
      expr: SUM(CAST(secondary_payer_paid_amount AS DOUBLE))
      comment: "Total amount paid by the secondary payer. Tracks COB recovery from secondary payers."
    - name: "total_net_liability_amount"
      expr: SUM(CAST(net_liability_amount AS DOUBLE))
      comment: "Total net liability after COB coordination. Measures actual plan cost after all payer coordination — key cost avoidance metric."
    - name: "total_adjustment_amount"
      expr: SUM(CAST(adjustment_amount AS DOUBLE))
      comment: "Total COB adjustment amounts applied. Tracks financial impact of COB processing on claim payments."
    - name: "total_cob_cases"
      expr: COUNT(1)
      comment: "Total COB cases processed. Baseline volume metric for COB program capacity."
    - name: "crossover_claim_count"
      expr: COUNT(CASE WHEN crossover_claim_flag = TRUE THEN 1 END)
      comment: "Count of crossover claims. Tracks dual-eligible claim volume requiring special routing and coordination."
    - name: "msp_case_count"
      expr: COUNT(CASE WHEN msp_indicator = TRUE THEN 1 END)
      comment: "Count of Medicare Secondary Payer cases. MSP compliance is a CMS requirement — non-compliance results in significant penalties."
    - name: "total_primary_payer_allowed_amount"
      expr: SUM(CAST(primary_payer_allowed_amount AS DOUBLE))
      comment: "Total primary payer allowed amounts. Used to compute COB savings as the difference between primary allowed and our liability."
    - name: "avg_net_liability_amount"
      expr: AVG(CAST(net_liability_amount AS DOUBLE))
      comment: "Average net liability per COB case. Benchmarks COB effectiveness and secondary payer coordination quality."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`claim_denial`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Claim denial analytics for payment integrity, appeals management, and provider relations. Tracks denial volumes, financial impact, and resolution rates — critical for revenue cycle management and regulatory compliance."
  source: "`vibe_health_insurance_v1`.`claim`.`denial`"
  dimensions:
    - name: "denial_type"
      expr: denial_type
      comment: "Type of denial (clinical, administrative, COB, duplicate) for root cause analysis."
    - name: "denial_status"
      expr: denial_status
      comment: "Current status of the denial (open, appealed, upheld, overturned) for pipeline management."
    - name: "carc_code"
      expr: carc_code
      comment: "Claim Adjustment Reason Code — standardized denial reason for provider communication and trend analysis."
    - name: "denial_month"
      expr: DATE_TRUNC('MONTH', denial_date)
      comment: "Month of denial for trend analysis and regulatory reporting."
    - name: "resolution_status"
      expr: resolution_status
      comment: "Final resolution of the denial (paid, upheld, written-off) for financial impact tracking."
    - name: "medical_necessity_flag"
      expr: medical_necessity_flag
      comment: "Whether denial was based on medical necessity — tracks clinical review workload and UM program effectiveness."
    - name: "appeal_eligibility_flag"
      expr: appeal_eligibility_flag
      comment: "Whether the denial is eligible for appeal — identifies actionable denials for revenue recovery."
    - name: "denial_subtype"
      expr: subtype
      comment: "Denial subtype for granular categorization within denial types."
  measures:
    - name: "total_denial_count"
      expr: COUNT(1)
      comment: "Total number of denials issued. Baseline metric for denial rate calculation and trend monitoring."
    - name: "total_denied_gross_amount"
      expr: SUM(CAST(denied_gross_amount AS DOUBLE))
      comment: "Total gross amount denied. Measures financial exposure from denials and potential recovery opportunity."
    - name: "total_denied_net_amount"
      expr: SUM(CAST(denied_net_amount AS DOUBLE))
      comment: "Total net amount denied after adjustments. Represents actual financial impact of denials on provider payments."
    - name: "total_denied_adjustment_amount"
      expr: SUM(CAST(denied_adjustment_amount AS DOUBLE))
      comment: "Total adjustment amounts associated with denials. Tracks retroactive denial corrections and their financial impact."
    - name: "medical_necessity_denial_count"
      expr: COUNT(CASE WHEN medical_necessity_flag = TRUE THEN 1 END)
      comment: "Count of denials based on medical necessity. High rates indicate UM program gaps or provider education needs."
    - name: "appealable_denial_count"
      expr: COUNT(CASE WHEN appeal_eligibility_flag = TRUE THEN 1 END)
      comment: "Count of denials eligible for appeal. Quantifies the appeals workload pipeline and potential payment reversals."
    - name: "letter_generated_count"
      expr: COUNT(CASE WHEN letter_generated_flag = TRUE THEN 1 END)
      comment: "Count of denials with letters generated. Tracks regulatory compliance with denial notification requirements."
    - name: "avg_denied_net_amount"
      expr: AVG(CAST(denied_net_amount AS DOUBLE))
      comment: "Average net denied amount per denial. Benchmarks denial severity and prioritizes recovery efforts."
    - name: "override_denial_count"
      expr: COUNT(CASE WHEN override_flag = TRUE THEN 1 END)
      comment: "Count of denials that were overridden. High override rates signal inconsistent denial policies or provider escalation patterns."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`claim_diagnosis`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Claim diagnosis coding metrics for risk adjustment, quality measurement, and population health management. Tracks HCC capture rates, chronic condition prevalence, and coding accuracy — critical for RAF score optimization and HEDIS performance."
  source: "`vibe_health_insurance_v1`.`claim`.`diagnosis`"
  dimensions:
    - name: "diagnosis_type"
      expr: diagnosis_type
      comment: "Type of diagnosis (principal, secondary, admitting) for coding completeness analysis."
    - name: "diagnosis_status"
      expr: diagnosis_status
      comment: "Status of the diagnosis code (active, resolved, chronic) for condition management."
    - name: "hcc_category"
      expr: hcc_category
      comment: "HCC category for risk adjustment analysis — tracks which HCC categories are being captured."
    - name: "chronic_condition_flag"
      expr: chronic_condition_flag
      comment: "Chronic condition indicator for population health management and care management targeting."
    - name: "icd_version"
      expr: icd_version
      comment: "ICD version (ICD-10, ICD-9) for coding system compliance monitoring."
    - name: "diagnosis_month"
      expr: DATE_TRUNC('MONTH', diagnosis_date)
      comment: "Month of diagnosis for condition prevalence trending."
    - name: "present_on_admission_indicator"
      expr: present_on_admission_indicator
      comment: "POA indicator for hospital-acquired condition identification and quality reporting."
    - name: "icd10_code"
      expr: icd10_code
      comment: "ICD-10 diagnosis code for condition-level cost and utilization analysis."
  measures:
    - name: "total_diagnosis_count"
      expr: COUNT(1)
      comment: "Total diagnosis codes submitted. Baseline for coding completeness and HCC capture rate analysis."
    - name: "distinct_member_count"
      expr: COUNT(DISTINCT claim_header_id)
      comment: "Count of distinct claims with diagnoses. Used to compute diagnoses-per-claim ratio for coding completeness."
    - name: "total_risk_adjustment_factor"
      expr: SUM(CAST(risk_adjustment_factor AS DOUBLE))
      comment: "Total risk adjustment factor contribution from diagnoses. Directly impacts CMS risk adjustment payments — a key revenue metric for Medicare Advantage plans."
    - name: "avg_risk_adjustment_factor"
      expr: AVG(CAST(risk_adjustment_factor AS DOUBLE))
      comment: "Average RAF contribution per diagnosis. Benchmarks coding specificity and HCC capture completeness."
    - name: "chronic_condition_diagnosis_count"
      expr: COUNT(CASE WHEN chronic_condition_flag = TRUE THEN 1 END)
      comment: "Count of chronic condition diagnoses. Tracks chronic disease burden in the population for care management program targeting."
    - name: "hcc_diagnosis_count"
      expr: COUNT(CASE WHEN hcc_category IS NOT NULL AND hcc_category != '' THEN 1 END)
      comment: "Count of diagnoses mapping to HCC categories. Measures HCC capture completeness — directly impacts risk adjustment revenue."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`claim_drg`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "DRG assignment and inpatient payment metrics. Tracks case mix index, outlier payments, and DRG weight distribution — essential for inpatient cost management, hospital contract performance, and actuarial analysis."
  source: "`vibe_health_insurance_v1`.`claim`.`drg`"
  dimensions:
    - name: "drg_code"
      expr: drg_code
      comment: "DRG code for inpatient case categorization and cost benchmarking."
    - name: "drg_type"
      expr: drg_type
      comment: "DRG type (MS-DRG, APR-DRG) for grouper methodology comparison."
    - name: "major_diagnostic_category"
      expr: major_diagnostic_category
      comment: "MDC for high-level clinical service line cost analysis."
    - name: "cc_mcc_flag"
      expr: cc_mcc_flag
      comment: "Complication/comorbidity flag — CC/MCC presence drives higher DRG weights and payments."
    - name: "assignment_status"
      expr: assignment_status
      comment: "DRG assignment status (final, preliminary, disputed) for coding accuracy monitoring."
    - name: "grouper_method"
      expr: grouper_method
      comment: "Grouper methodology for DRG assignment consistency analysis."
    - name: "grouper_run_month"
      expr: DATE_TRUNC('MONTH', grouper_run_timestamp)
      comment: "Month DRG grouper was run for version and timing analysis."
  measures:
    - name: "total_drg_payment_amount"
      expr: SUM(CAST(payment_amount AS DOUBLE))
      comment: "Total DRG-based payments. Primary inpatient cost metric — DRG payments represent the largest component of medical spend."
    - name: "total_outlier_payment_amount"
      expr: SUM(CAST(outlier_payment_amount AS DOUBLE))
      comment: "Total outlier payments above DRG threshold. High outlier payments indicate catastrophic cases requiring case management intervention."
    - name: "avg_drg_weight"
      expr: AVG(CAST(weight AS DOUBLE))
      comment: "Average DRG weight (case mix index). Measures acuity of inpatient population — higher CMI indicates more complex, costly cases."
    - name: "total_case_mix_index_contribution"
      expr: SUM(CAST(case_mix_index_contribution AS DOUBLE))
      comment: "Total case mix index contribution across all DRG assignments. Tracks overall inpatient acuity and cost complexity."
    - name: "avg_arithmetic_mean_los"
      expr: AVG(CAST(arithmetic_mean_los AS DOUBLE))
      comment: "Average arithmetic mean length of stay. Benchmarks actual LOS against DRG norms — excess LOS drives cost overruns."
    - name: "avg_geometric_mean_los"
      expr: AVG(CAST(geometric_mean_los AS DOUBLE))
      comment: "Average geometric mean length of stay. Standard LOS benchmark used in DRG payment calculations."
    - name: "avg_base_rate_applied"
      expr: AVG(CAST(base_rate_applied AS DOUBLE))
      comment: "Average base rate applied in DRG payment calculation. Tracks contract base rate performance vs. Medicare benchmark."
    - name: "total_drg_count"
      expr: COUNT(1)
      comment: "Total DRG assignments. Baseline inpatient volume metric for utilization management."
    - name: "outlier_case_count"
      expr: COUNT(CASE WHEN outlier_payment_amount > 0 THEN 1 END)
      comment: "Count of inpatient cases qualifying for outlier payments. Tracks catastrophic case volume requiring intensive case management."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`claim_header`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core claim financial performance metrics derived from claim headers. Tracks total claim spend, payment efficiency, denial rates, and adjudication throughput — essential for medical cost management, CFO reporting, and operational steering."
  source: "`vibe_health_insurance_v1`.`claim`.`header`"
  dimensions:
    - name: "claim_type"
      expr: claim_type
      comment: "Type of claim (medical, dental, vision, pharmacy, etc.) for cost segmentation."
    - name: "claim_status"
      expr: claim_status
      comment: "Current processing status of the claim (paid, denied, pending, suspended) for pipeline analysis."
    - name: "line_of_business"
      expr: lob
      comment: "Line of business (Commercial, Medicare, Medicaid) for cost and utilization segmentation."
    - name: "place_of_service"
      expr: place_of_service_code
      comment: "Place of service code (inpatient, outpatient, office, ER) for site-of-care cost analysis."
    - name: "claim_received_month"
      expr: DATE_TRUNC('MONTH', claim_received_date)
      comment: "Month the claim was received, used for trend analysis and SLA monitoring."
    - name: "claim_paid_month"
      expr: DATE_TRUNC('MONTH', claim_paid_date)
      comment: "Month the claim was paid, used for cash flow and payment cycle analysis."
    - name: "service_month"
      expr: DATE_TRUNC('MONTH', effective_start_date)
      comment: "Month of service for incurred cost trending and IBNR analysis."
    - name: "drg_code"
      expr: drg_code
      comment: "Diagnosis-related group code for inpatient cost benchmarking."
    - name: "is_mlr_excluded"
      expr: is_mlr_excluded
      comment: "Flag indicating whether the claim is excluded from MLR calculation (administrative vs. clinical spend)."
    - name: "cob_indicator"
      expr: cob_indicator
      comment: "Coordination of benefits indicator — identifies claims with secondary payer involvement."
    - name: "is_suspended"
      expr: is_suspended
      comment: "Flag for suspended claims requiring manual intervention, used for operational queue management."
    - name: "billing_type"
      expr: billing_type
      comment: "Billing type (institutional, professional) for cost category analysis."
  measures:
    - name: "total_billed_amount"
      expr: SUM(CAST(billed_amount AS DOUBLE))
      comment: "Total charges billed by providers. Baseline for discount and allowed-amount analysis. Executives use this to assess provider pricing pressure."
    - name: "total_allowed_amount"
      expr: SUM(CAST(allowed_amount AS DOUBLE))
      comment: "Total contractually allowed amounts across all claims. Represents the plan's maximum liability before member cost-sharing. Core medical cost KPI."
    - name: "total_paid_amount"
      expr: SUM(CAST(paid_amount AS DOUBLE))
      comment: "Total net amount paid by the plan. Primary medical cost metric used in MLR, budgeting, and actuarial reserving."
    - name: "avg_paid_amount_per_claim"
      expr: AVG(CAST(paid_amount AS DOUBLE))
      comment: "Average plan payment per claim. Tracks unit cost trends and benchmarks against industry norms. Triggers investigation when trending above budget."
    - name: "total_claim_count"
      expr: COUNT(1)
      comment: "Total number of claims submitted. Baseline volume metric for utilization management and capacity planning."
    - name: "distinct_member_count"
      expr: COUNT(DISTINCT member_identity_id)
      comment: "Number of unique members with claims. Used to compute per-member-per-month (PMPM) cost metrics."
    - name: "avg_billed_amount_per_claim"
      expr: AVG(CAST(billed_amount AS DOUBLE))
      comment: "Average billed charge per claim. Monitors provider billing behavior and identifies outlier billing patterns."
    - name: "total_denied_claim_count"
      expr: COUNT(CASE WHEN claim_status = 'DENIED' THEN 1 END)
      comment: "Count of denied claims. High denial rates signal prior auth gaps, coding issues, or network problems — a key quality and revenue integrity metric."
    - name: "total_suspended_claim_count"
      expr: COUNT(CASE WHEN is_suspended = TRUE THEN 1 END)
      comment: "Count of suspended claims pending manual review. Drives operational staffing and SLA compliance decisions."
    - name: "total_cob_claim_count"
      expr: COUNT(CASE WHEN cob_indicator = TRUE THEN 1 END)
      comment: "Count of claims with coordination of benefits. Tracks recovery opportunity and secondary payer coordination efficiency."
    - name: "mlr_included_paid_amount"
      expr: SUM(CASE WHEN is_mlr_excluded = FALSE THEN paid_amount ELSE 0 END)
      comment: "Total paid amount included in MLR numerator. Directly feeds the Medical Loss Ratio regulatory calculation required by ACA."
    - name: "inpatient_claim_count"
      expr: COUNT(CASE WHEN claim_type = 'INPATIENT' THEN 1 END)
      comment: "Count of inpatient claims. Inpatient cost is the largest driver of medical spend — tracked separately for utilization management."
    - name: "avg_allowed_amount_per_claim"
      expr: AVG(CAST(allowed_amount AS DOUBLE))
      comment: "Average allowed amount per claim. Used to benchmark contract performance and fee schedule adequacy."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`claim_ibnr`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Incurred But Not Reported (IBNR) reserve metrics for actuarial and financial management. Tracks reserve adequacy, development factors, and completion factors — essential for financial close, rate setting, and regulatory capital reporting."
  source: "`vibe_health_insurance_v1`.`claim`.`ibnr`"
  dimensions:
    - name: "ibnr_status"
      expr: ibnr_status
      comment: "Status of the IBNR estimate (preliminary, final, revised) for reserve lifecycle management."
    - name: "methodology_code"
      expr: methodology_code
      comment: "Actuarial methodology used (chain-ladder, Bornhuetter-Ferguson) for reserve methodology comparison."
    - name: "lob_code"
      expr: lob_code
      comment: "Line of business code for LOB-level reserve segmentation required by regulators."
    - name: "line_of_business"
      expr: line_of_business
      comment: "Line of business description for reserve reporting and financial segmentation."
    - name: "incurred_month"
      expr: DATE_TRUNC('MONTH', incurred_month)
      comment: "Month claims were incurred — core dimension for development triangle analysis."
    - name: "reserve_run_month"
      expr: DATE_TRUNC('MONTH', reserve_run_date)
      comment: "Month the reserve was calculated — tracks reserve development over time."
    - name: "plan_type"
      expr: plan_type
      comment: "Plan type for reserve segmentation by product line."
    - name: "service_category"
      expr: service_category
      comment: "Service category (inpatient, outpatient, pharmacy) for granular reserve analysis."
  measures:
    - name: "total_estimated_ibnr_amount"
      expr: SUM(CAST(estimated_ibnr_amount AS DOUBLE))
      comment: "Total estimated IBNR reserve. Primary actuarial metric for financial close and regulatory capital adequacy reporting."
    - name: "total_reserve_amount"
      expr: SUM(CAST(reserve_amount AS DOUBLE))
      comment: "Total reserve amount held. Tracks reserve adequacy against incurred claims — critical for solvency monitoring."
    - name: "total_paid_to_date_amount"
      expr: SUM(CAST(paid_to_date_amount AS DOUBLE))
      comment: "Total claims paid to date within the incurred period. Used to compute completion factors and reserve development."
    - name: "total_reserve_change_amount"
      expr: SUM(CAST(reserve_change_amount AS DOUBLE))
      comment: "Total change in reserves period-over-period. Tracks reserve development and actuarial estimate accuracy."
    - name: "total_prior_period_reserve"
      expr: SUM(CAST(prior_period_reserve_amount AS DOUBLE))
      comment: "Total prior period reserve for development comparison. Measures actuarial estimate accuracy over time."
    - name: "total_mlr_numerator_allocation"
      expr: SUM(CAST(mlr_numerator_allocation AS DOUBLE))
      comment: "Total IBNR allocated to the MLR numerator. Required for ACA Medical Loss Ratio regulatory calculation."
    - name: "avg_completion_factor"
      expr: AVG(CAST(completion_factor AS DOUBLE))
      comment: "Average completion factor across IBNR estimates. Measures how complete claims development is — low factors indicate significant unreported claims."
    - name: "avg_lag_factor"
      expr: AVG(CAST(lag_factor AS DOUBLE))
      comment: "Average lag factor across IBNR estimates. Tracks claims reporting lag — high lag factors increase reserve uncertainty."
    - name: "avg_development_factor"
      expr: AVG(CAST(development_factor AS DOUBLE))
      comment: "Average development factor (link ratio) across IBNR estimates. Core actuarial input for chain-ladder reserve development."
    - name: "ibnr_record_count"
      expr: COUNT(1)
      comment: "Total IBNR estimate records. Tracks reserve calculation coverage across LOBs and incurred periods."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`claim_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Claim line-level financial and utilization metrics. Provides granular procedure-level cost analysis, network performance, and service utilization insights essential for medical management and contract performance."
  source: "`vibe_health_insurance_v1`.`claim`.`line`"
  dimensions:
    - name: "procedure_code"
      expr: procedure_code
      comment: "Procedure code (CPT/HCPCS) for service-level cost and utilization analysis."
    - name: "revenue_code"
      expr: revenue_code
      comment: "Revenue code for institutional claim line categorization and cost center analysis."
    - name: "place_of_service_code"
      expr: place_of_service_code
      comment: "Place of service for site-of-care cost comparison and network adequacy analysis."
    - name: "line_status"
      expr: line_status
      comment: "Processing status of the claim line (paid, denied, adjusted) for pipeline monitoring."
    - name: "line_type"
      expr: line_type
      comment: "Type of service line for cost categorization (professional, facility, ancillary)."
    - name: "service_month"
      expr: DATE_TRUNC('MONTH', service_date)
      comment: "Month of service for utilization trending and seasonal pattern analysis."
    - name: "ndc_code"
      expr: ndc_code
      comment: "National Drug Code for pharmacy-on-medical claim drug cost analysis."
    - name: "emergency_indicator"
      expr: emergency_indicator
      comment: "Emergency service flag for ER utilization and avoidable ER visit analysis."
  measures:
    - name: "total_billed_amount"
      expr: SUM(CAST(billed_amount AS DOUBLE))
      comment: "Total billed charges at the line level. Baseline for discount and allowed-amount analysis by procedure."
    - name: "total_allowed_amount"
      expr: SUM(CAST(allowed_amount AS DOUBLE))
      comment: "Total allowed amounts at the line level. Measures contract performance and fee schedule adequacy by procedure code."
    - name: "total_paid_amount"
      expr: SUM(CAST(paid_amount AS DOUBLE))
      comment: "Total plan payments at the line level. Granular medical cost metric for procedure-level cost management."
    - name: "total_patient_responsibility"
      expr: SUM(CAST(patient_responsibility_amount AS DOUBLE))
      comment: "Total member cost-sharing at the line level. Tracks member financial burden and benefit design impact."
    - name: "total_cob_paid_amount"
      expr: SUM(CAST(cob_paid_amount AS DOUBLE))
      comment: "Total COB payments applied at the line level. Measures secondary payer recovery by service type."
    - name: "total_units_of_service"
      expr: SUM(CAST(units_of_service AS DOUBLE))
      comment: "Total units of service billed. Tracks utilization volume by procedure for medical management and fraud detection."
    - name: "total_adjustment_amount"
      expr: SUM(CAST(adjustment_amount AS DOUBLE))
      comment: "Total line-level adjustments. Identifies procedures with high retroactive correction rates — a payment integrity signal."
    - name: "avg_allowed_amount_per_line"
      expr: AVG(CAST(allowed_amount AS DOUBLE))
      comment: "Average allowed amount per service line. Benchmarks procedure-level pricing against fee schedules and market rates."
    - name: "avg_paid_amount_per_line"
      expr: AVG(CAST(paid_amount AS DOUBLE))
      comment: "Average plan payment per service line. Used for procedure-level cost benchmarking and contract negotiation."
    - name: "emergency_line_count"
      expr: COUNT(CASE WHEN emergency_indicator = TRUE THEN 1 END)
      comment: "Count of emergency service lines. Tracks ER utilization volume — high rates signal care management gaps and avoidable cost."
    - name: "denied_line_count"
      expr: COUNT(CASE WHEN line_status = 'DENIED' THEN 1 END)
      comment: "Count of denied claim lines. Procedure-level denial analysis identifies coding issues and medical necessity gaps."
    - name: "total_line_count"
      expr: COUNT(1)
      comment: "Total claim lines processed. Baseline volume metric for operational throughput and provider billing pattern analysis."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`claim_payment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Claim payment execution and reconciliation metrics. Tracks payment volumes, reconciliation status, voids, and returns — essential for treasury management, provider relations, and financial close accuracy."
  source: "`vibe_health_insurance_v1`.`claim`.`payment`"
  dimensions:
    - name: "payment_status"
      expr: payment_status
      comment: "Current status of the payment (issued, cleared, returned, voided) for cash management."
    - name: "payment_type"
      expr: payment_type
      comment: "Type of payment (EFT, check, virtual card) for payment method optimization."
    - name: "payment_method"
      expr: method
      comment: "Payment delivery method for channel mix analysis and cost-per-payment optimization."
    - name: "payee_type"
      expr: payee_type
      comment: "Type of payee (provider, member, vendor) for payment flow analysis."
    - name: "payment_month"
      expr: DATE_TRUNC('MONTH', payment_date)
      comment: "Month of payment for cash flow forecasting and financial close reporting."
    - name: "gl_posting_month"
      expr: DATE_TRUNC('MONTH', gl_posting_date)
      comment: "Month of GL posting for financial period close and accrual analysis."
    - name: "is_reconciled"
      expr: is_reconciled
      comment: "Reconciliation status flag — unreconciled payments represent financial close risk."
    - name: "is_returned"
      expr: is_returned
      comment: "Returned payment flag — tracks payment failures requiring reissuance."
    - name: "is_voided"
      expr: is_voided
      comment: "Voided payment flag — tracks payment cancellations and their financial impact."
    - name: "reconciliation_status"
      expr: reconciliation_status
      comment: "Detailed reconciliation status for treasury and accounts payable management."
  measures:
    - name: "total_gross_payment_amount"
      expr: SUM(CAST(gross_amount AS DOUBLE))
      comment: "Total gross payments issued. Primary cash outflow metric for treasury management and financial reporting."
    - name: "total_net_payment_amount"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Total net payments after adjustments and tax. Actual cash disbursed — core financial close metric."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax withheld on payments. Required for tax compliance reporting and 1099 preparation."
    - name: "total_adjustment_amount"
      expr: SUM(CAST(adjustment_amount AS DOUBLE))
      comment: "Total payment adjustments applied. Tracks retroactive payment corrections and their financial impact."
    - name: "total_payment_count"
      expr: COUNT(1)
      comment: "Total payments issued. Baseline volume metric for payment operations capacity planning."
    - name: "returned_payment_count"
      expr: COUNT(CASE WHEN is_returned = TRUE THEN 1 END)
      comment: "Count of returned payments. High return rates indicate address/banking data quality issues — drives provider data remediation."
    - name: "voided_payment_count"
      expr: COUNT(CASE WHEN is_voided = TRUE THEN 1 END)
      comment: "Count of voided payments. Tracks payment cancellations — high rates signal adjudication errors or fraud."
    - name: "unreconciled_payment_count"
      expr: COUNT(CASE WHEN is_reconciled = FALSE THEN 1 END)
      comment: "Count of unreconciled payments. Unreconciled items represent financial close risk and potential duplicate payment exposure."
    - name: "avg_net_payment_amount"
      expr: AVG(CAST(net_amount AS DOUBLE))
      comment: "Average net payment per transaction. Benchmarks payment size distribution and identifies outlier payments for audit."
    - name: "total_returned_amount"
      expr: SUM(CASE WHEN is_returned = TRUE THEN gross_amount ELSE 0 END)
      comment: "Total dollar value of returned payments. Quantifies cash flow disruption from payment failures."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`claim_subrogation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Subrogation recovery metrics for third-party liability and workers compensation. Tracks demand amounts, recovery rates, and settlement performance — critical for revenue recovery and legal cost management."
  source: "`vibe_health_insurance_v1`.`claim`.`subrogation`"
  dimensions:
    - name: "subrogation_status"
      expr: subrogation_status
      comment: "Current status of the subrogation case (open, settled, closed, litigated) for pipeline management."
    - name: "subrogation_type"
      expr: subrogation_type
      comment: "Type of subrogation (auto, workers comp, liability) for recovery program segmentation."
    - name: "liability_type"
      expr: liability_type
      comment: "Liability type for legal strategy and recovery rate benchmarking."
    - name: "lien_status"
      expr: lien_status
      comment: "Lien status for tracking legal recovery instruments."
    - name: "accident_month"
      expr: DATE_TRUNC('MONTH', accident_date)
      comment: "Month of accident for subrogation case aging analysis."
    - name: "is_recovery_closed"
      expr: is_recovery_closed
      comment: "Recovery closure flag for pipeline vs. closed case analysis."
    - name: "is_settlement_agreed"
      expr: is_settlement_agreed
      comment: "Settlement agreement flag for tracking negotiated vs. litigated recoveries."
    - name: "regulatory_reporting_flag"
      expr: regulatory_reporting_flag
      comment: "Flag for subrogation cases requiring regulatory reporting."
  measures:
    - name: "total_demand_amount"
      expr: SUM(CAST(demand_amount AS DOUBLE))
      comment: "Total demand amounts sent to third parties. Measures the gross recovery opportunity in the subrogation pipeline."
    - name: "total_gross_recovery_amount"
      expr: SUM(CAST(gross_recovery_amount AS DOUBLE))
      comment: "Total gross amounts recovered from third parties. Primary revenue recovery metric for the subrogation program."
    - name: "total_net_recovery_amount"
      expr: SUM(CAST(net_recovery_amount AS DOUBLE))
      comment: "Total net recovery after legal fees. Actual financial benefit of the subrogation program — used for ROI calculation."
    - name: "total_legal_fees_amount"
      expr: SUM(CAST(legal_fees_amount AS DOUBLE))
      comment: "Total legal fees incurred in subrogation. Tracks program cost for ROI analysis and vendor management."
    - name: "total_settlement_amount"
      expr: SUM(CAST(settlement_amount AS DOUBLE))
      comment: "Total settlement amounts agreed. Tracks negotiated recovery vs. demand — measures negotiation effectiveness."
    - name: "total_lien_amount"
      expr: SUM(CAST(lien_amount AS DOUBLE))
      comment: "Total lien amounts filed. Tracks legal recovery instruments in place for pipeline valuation."
    - name: "total_subrogation_cases"
      expr: COUNT(1)
      comment: "Total subrogation cases. Baseline volume metric for program capacity and staffing."
    - name: "settled_case_count"
      expr: COUNT(CASE WHEN is_settlement_agreed = TRUE THEN 1 END)
      comment: "Count of cases with agreed settlements. Tracks settlement rate as a measure of negotiation effectiveness."
    - name: "avg_net_recovery_amount"
      expr: AVG(CAST(net_recovery_amount AS DOUBLE))
      comment: "Average net recovery per subrogation case. Benchmarks case value and prioritizes high-value recovery efforts."
$$;
