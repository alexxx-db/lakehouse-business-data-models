-- Metric views for domain: claim | Business: Transport Shipping | Version: 1 | Generated on: 2026-05-08 22:31:03

CREATE OR REPLACE VIEW `transport_shipping_ecm`.`_metrics`.`claim_cargo_claim`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core cargo claim financial and operational KPIs tracking claim amounts, settlement performance, liability exposure, and subrogation recovery across transport modes and claim types"
  source: "`transport_shipping_ecm`.`claim`.`cargo_claim`"
  dimensions:
    - name: "claim_status"
      expr: claim_status
      comment: "Current status of the cargo claim (e.g., Open, Under Review, Approved, Settled, Rejected)"
    - name: "claim_type"
      expr: claim_type
      comment: "Type of claim (e.g., Damage, Loss, Shortage, Delay)"
    - name: "transport_mode"
      expr: transport_mode
      comment: "Mode of transport where incident occurred (Air, Ocean, Road, Rail, Intermodal)"
    - name: "liability_determination"
      expr: liability_determination
      comment: "Determination of liability party (Carrier, Shipper, Consignee, Third Party, Shared)"
    - name: "liability_convention"
      expr: liability_convention
      comment: "Legal convention governing liability (Montreal, Warsaw, CMR, Hague-Visby, etc.)"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which claim amounts are denominated"
    - name: "origin_country_code"
      expr: origin_country_code
      comment: "Country code of shipment origin"
    - name: "destination_country_code"
      expr: destination_country_code
      comment: "Country code of shipment destination"
    - name: "incident_country_code"
      expr: incident_country_code
      comment: "Country code where incident occurred"
    - name: "subrogation_status"
      expr: subrogation_status
      comment: "Status of subrogation recovery process"
    - name: "is_dangerous_goods"
      expr: is_dangerous_goods
      comment: "Flag indicating whether claim involves dangerous goods"
    - name: "incident_year"
      expr: YEAR(incident_date)
      comment: "Year when incident occurred"
    - name: "incident_month"
      expr: DATE_TRUNC('MONTH', incident_date)
      comment: "Month when incident occurred"
    - name: "settlement_year"
      expr: YEAR(settlement_date)
      comment: "Year when claim was settled"
    - name: "settlement_month"
      expr: DATE_TRUNC('MONTH', settlement_date)
      comment: "Month when claim was settled"
    - name: "registration_year"
      expr: YEAR(registration_timestamp)
      comment: "Year when claim was registered"
    - name: "registration_month"
      expr: DATE_TRUNC('MONTH', registration_timestamp)
      comment: "Month when claim was registered"
  measures:
    - name: "total_claims"
      expr: COUNT(1)
      comment: "Total number of cargo claims"
    - name: "total_claimed_amount"
      expr: SUM(CAST(claimed_amount AS DOUBLE))
      comment: "Total amount claimed across all claims"
    - name: "total_approved_amount"
      expr: SUM(CAST(approved_amount AS DOUBLE))
      comment: "Total amount approved for payment"
    - name: "total_settlement_amount"
      expr: SUM(CAST(settlement_amount AS DOUBLE))
      comment: "Total amount actually settled and paid out"
    - name: "total_deductible_amount"
      expr: SUM(CAST(deductible_amount AS DOUBLE))
      comment: "Total deductible amounts applied across claims"
    - name: "total_finance_reserve_amount"
      expr: SUM(CAST(finance_reserve_amount AS DOUBLE))
      comment: "Total financial reserves held for claims"
    - name: "total_subrogation_recovery_amount"
      expr: SUM(CAST(subrogation_recovery_amount AS DOUBLE))
      comment: "Total amount recovered through subrogation from liable third parties"
    - name: "total_liability_limit_amount"
      expr: SUM(CAST(liability_limit_amount AS DOUBLE))
      comment: "Total liability limit amounts applicable to claims"
    - name: "avg_claimed_amount"
      expr: AVG(CAST(claimed_amount AS DOUBLE))
      comment: "Average amount claimed per claim"
    - name: "avg_settlement_amount"
      expr: AVG(CAST(settlement_amount AS DOUBLE))
      comment: "Average settlement amount per claim"
    - name: "avg_claimed_weight_kg"
      expr: AVG(CAST(claimed_weight_kg AS DOUBLE))
      comment: "Average weight of claimed cargo in kilograms"
    - name: "distinct_claimants"
      expr: COUNT(DISTINCT claimant_id)
      comment: "Number of unique claimants filing claims"
    - name: "distinct_carriers"
      expr: COUNT(DISTINCT carrier_id)
      comment: "Number of unique carriers involved in claims"
    - name: "distinct_customers"
      expr: COUNT(DISTINCT customer_account_id)
      comment: "Number of unique customer accounts with claims"
    - name: "claims_with_subrogation"
      expr: COUNT(CASE WHEN subrogation_recovery_amount > 0 THEN 1 END)
      comment: "Number of claims with successful subrogation recovery"
    - name: "claims_involving_dangerous_goods"
      expr: COUNT(CASE WHEN is_dangerous_goods = TRUE THEN 1 END)
      comment: "Number of claims involving dangerous goods shipments"
$$;


CREATE OR REPLACE VIEW `transport_shipping_ecm`.`_metrics`.`claim_settlement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Settlement performance and financial KPIs tracking settlement efficiency, payment accuracy, reserve adequacy, and subrogation effectiveness"
  source: "`transport_shipping_ecm`.`claim`.`settlement`"
  dimensions:
    - name: "settlement_status"
      expr: settlement_status
      comment: "Current status of settlement (Pending, Approved, Paid, Rejected, Disputed)"
    - name: "settlement_type"
      expr: settlement_type
      comment: "Type of settlement (Full, Partial, Ex-Gratia, Negotiated)"
    - name: "claim_type"
      expr: claim_type
      comment: "Type of underlying claim being settled"
    - name: "acceptance_status"
      expr: acceptance_status
      comment: "Status of claimant acceptance of settlement offer"
    - name: "payment_method"
      expr: payment_method
      comment: "Method used for settlement payment (Wire, Check, Credit Note, etc.)"
    - name: "currency"
      expr: currency
      comment: "Currency of settlement payment"
    - name: "transport_mode"
      expr: transport_mode
      comment: "Transport mode of underlying claim"
    - name: "subrogation_initiated_flag"
      expr: subrogation_initiated_flag
      comment: "Flag indicating whether subrogation process has been initiated"
    - name: "dangerous_goods_flag"
      expr: dangerous_goods_flag
      comment: "Flag indicating whether settlement involves dangerous goods"
    - name: "settlement_year"
      expr: YEAR(settlement_date)
      comment: "Year when settlement was finalized"
    - name: "settlement_month"
      expr: DATE_TRUNC('MONTH', settlement_date)
      comment: "Month when settlement was finalized"
    - name: "payment_year"
      expr: YEAR(payment_date)
      comment: "Year when payment was made"
    - name: "payment_month"
      expr: DATE_TRUNC('MONTH', payment_date)
      comment: "Month when payment was made"
    - name: "approval_year"
      expr: YEAR(approval_date)
      comment: "Year when settlement was approved"
  measures:
    - name: "total_settlements"
      expr: COUNT(1)
      comment: "Total number of settlements processed"
    - name: "total_settlement_amount"
      expr: SUM(CAST(amount AS DOUBLE))
      comment: "Total settlement amount paid out"
    - name: "total_claimed_amount"
      expr: SUM(CAST(claimed_amount AS DOUBLE))
      comment: "Total amount originally claimed"
    - name: "total_net_settlement_amount"
      expr: SUM(CAST(net_settlement_amount AS DOUBLE))
      comment: "Total net settlement amount after deductions"
    - name: "total_deductible_amount"
      expr: SUM(CAST(deductible_amount AS DOUBLE))
      comment: "Total deductible amounts applied"
    - name: "total_reserve_amount"
      expr: SUM(CAST(reserve_amount AS DOUBLE))
      comment: "Total reserve amounts held for settlements"
    - name: "total_reserve_release_amount"
      expr: SUM(CAST(reserve_release_amount AS DOUBLE))
      comment: "Total reserve amounts released after settlement"
    - name: "total_subrogation_amount"
      expr: SUM(CAST(subrogation_amount AS DOUBLE))
      comment: "Total subrogation recovery amounts"
    - name: "total_insurer_recovery_amount"
      expr: SUM(CAST(insurer_recovery_amount AS DOUBLE))
      comment: "Total amounts recovered from insurers"
    - name: "total_functional_currency_amount"
      expr: SUM(CAST(functional_currency_amount AS DOUBLE))
      comment: "Total settlement amounts in functional currency"
    - name: "avg_settlement_amount"
      expr: AVG(CAST(amount AS DOUBLE))
      comment: "Average settlement amount per claim"
    - name: "avg_settlement_days"
      expr: AVG(CAST(actual_settlement_days AS DOUBLE))
      comment: "Average number of days to settle a claim"
    - name: "distinct_claims"
      expr: COUNT(DISTINCT cargo_claim_id)
      comment: "Number of unique claims settled"
    - name: "distinct_carriers"
      expr: COUNT(DISTINCT carrier_id)
      comment: "Number of unique carriers involved in settlements"
    - name: "distinct_customers"
      expr: COUNT(DISTINCT customer_account_id)
      comment: "Number of unique customers receiving settlements"
    - name: "settlements_with_subrogation"
      expr: COUNT(CASE WHEN subrogation_initiated_flag = TRUE THEN 1 END)
      comment: "Number of settlements with subrogation initiated"
    - name: "settlements_involving_dangerous_goods"
      expr: COUNT(CASE WHEN dangerous_goods_flag = TRUE THEN 1 END)
      comment: "Number of settlements involving dangerous goods"
$$;


CREATE OR REPLACE VIEW `transport_shipping_ecm`.`_metrics`.`claim_reserve`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Financial reserve management KPIs tracking reserve adequacy, adjustment patterns, release timing, and subrogation potential"
  source: "`transport_shipping_ecm`.`claim`.`reserve`"
  dimensions:
    - name: "reserve_status"
      expr: reserve_status
      comment: "Current status of reserve (Open, Adjusted, Released, Closed)"
    - name: "reserve_type"
      expr: reserve_type
      comment: "Type of reserve (Initial, Supplementary, IBNR, Case Reserve)"
    - name: "claim_type"
      expr: claim_type
      comment: "Type of underlying claim"
    - name: "currency"
      expr: currency
      comment: "Currency in which reserve is denominated"
    - name: "functional_currency_code"
      expr: functional_currency_code
      comment: "Functional currency for reporting"
    - name: "transport_mode"
      expr: transport_mode
      comment: "Transport mode of underlying claim"
    - name: "liability_convention"
      expr: liability_convention
      comment: "Legal convention governing liability"
    - name: "insurer_notified"
      expr: insurer_notified
      comment: "Flag indicating whether insurer has been notified"
    - name: "subrogation_potential"
      expr: subrogation_potential
      comment: "Flag indicating potential for subrogation recovery"
    - name: "dangerous_goods_flag"
      expr: dangerous_goods_flag
      comment: "Flag indicating whether reserve involves dangerous goods"
    - name: "establishment_year"
      expr: YEAR(establishment_date)
      comment: "Year when reserve was established"
    - name: "establishment_month"
      expr: DATE_TRUNC('MONTH', establishment_date)
      comment: "Month when reserve was established"
    - name: "release_year"
      expr: YEAR(release_date)
      comment: "Year when reserve was released"
    - name: "release_month"
      expr: DATE_TRUNC('MONTH', release_date)
      comment: "Month when reserve was released"
    - name: "last_adjustment_reason_code"
      expr: last_adjustment_reason_code
      comment: "Reason code for most recent reserve adjustment"
  measures:
    - name: "total_reserves"
      expr: COUNT(1)
      comment: "Total number of reserves established"
    - name: "total_initial_reserve_amount"
      expr: SUM(CAST(initial_reserve_amount AS DOUBLE))
      comment: "Total initial reserve amounts established"
    - name: "total_current_reserve_amount"
      expr: SUM(CAST(current_reserve_amount AS DOUBLE))
      comment: "Total current reserve amounts held"
    - name: "total_release_amount"
      expr: SUM(CAST(release_amount AS DOUBLE))
      comment: "Total reserve amounts released"
    - name: "total_adjustments_amount"
      expr: SUM(CAST(total_adjustments_amount AS DOUBLE))
      comment: "Total cumulative adjustment amounts across all reserves"
    - name: "total_last_adjustment_amount"
      expr: SUM(CAST(last_adjustment_amount AS DOUBLE))
      comment: "Total of most recent adjustment amounts"
    - name: "total_functional_currency_amount"
      expr: SUM(CAST(functional_currency_amount AS DOUBLE))
      comment: "Total reserve amounts in functional currency"
    - name: "total_liability_limit_amount"
      expr: SUM(CAST(liability_limit_amount AS DOUBLE))
      comment: "Total liability limit amounts applicable to reserves"
    - name: "total_subrogation_recovery_amount"
      expr: SUM(CAST(subrogation_recovery_amount AS DOUBLE))
      comment: "Total subrogation recovery amounts realized"
    - name: "avg_initial_reserve_amount"
      expr: AVG(CAST(initial_reserve_amount AS DOUBLE))
      comment: "Average initial reserve amount per claim"
    - name: "avg_current_reserve_amount"
      expr: AVG(CAST(current_reserve_amount AS DOUBLE))
      comment: "Average current reserve amount per claim"
    - name: "avg_exchange_rate"
      expr: AVG(CAST(exchange_rate AS DOUBLE))
      comment: "Average exchange rate applied to reserves"
    - name: "distinct_claims"
      expr: COUNT(DISTINCT cargo_claim_id)
      comment: "Number of unique claims with reserves"
    - name: "distinct_carriers"
      expr: COUNT(DISTINCT carrier_id)
      comment: "Number of unique carriers with reserves held"
    - name: "distinct_customers"
      expr: COUNT(DISTINCT customer_account_id)
      comment: "Number of unique customers with reserves"
    - name: "reserves_with_subrogation_potential"
      expr: COUNT(CASE WHEN subrogation_potential = TRUE THEN 1 END)
      comment: "Number of reserves with identified subrogation potential"
    - name: "reserves_insurer_notified"
      expr: COUNT(CASE WHEN insurer_notified = TRUE THEN 1 END)
      comment: "Number of reserves where insurer has been notified"
    - name: "reserves_involving_dangerous_goods"
      expr: COUNT(CASE WHEN dangerous_goods_flag = TRUE THEN 1 END)
      comment: "Number of reserves involving dangerous goods"
$$;


CREATE OR REPLACE VIEW `transport_shipping_ecm`.`_metrics`.`claim_cargo_survey`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Cargo survey and damage assessment KPIs tracking survey completion, loss valuation, liability attribution, and salvage recovery"
  source: "`transport_shipping_ecm`.`claim`.`cargo_survey`"
  dimensions:
    - name: "survey_status"
      expr: survey_status
      comment: "Current status of cargo survey (Commissioned, In Progress, Completed, Cancelled)"
    - name: "survey_type"
      expr: survey_type
      comment: "Type of survey conducted (Pre-shipment, On-arrival, Damage, Loss, Joint)"
    - name: "survey_methodology"
      expr: survey_methodology
      comment: "Methodology used for survey (Physical Inspection, Documentary, Remote, Sampling)"
    - name: "transport_mode"
      expr: transport_mode
      comment: "Transport mode of surveyed cargo"
    - name: "damage_cause_code"
      expr: damage_cause_code
      comment: "Coded cause of damage identified in survey"
    - name: "liability_attribution"
      expr: liability_attribution
      comment: "Party attributed with liability based on survey findings"
    - name: "liability_convention"
      expr: liability_convention
      comment: "Legal convention applicable to liability determination"
    - name: "survey_location_country_code"
      expr: survey_location_country_code
      comment: "Country code where survey was conducted"
    - name: "survey_currency_code"
      expr: survey_currency_code
      comment: "Currency used for survey valuations"
    - name: "is_dangerous_goods"
      expr: is_dangerous_goods
      comment: "Flag indicating whether surveyed cargo is dangerous goods"
    - name: "joint_survey_indicator"
      expr: joint_survey_indicator
      comment: "Flag indicating whether survey was conducted jointly with multiple parties"
    - name: "photographic_evidence_indicator"
      expr: photographic_evidence_indicator
      comment: "Flag indicating whether photographic evidence was collected"
    - name: "subrogation_applicable"
      expr: subrogation_applicable
      comment: "Flag indicating whether subrogation is applicable based on survey findings"
    - name: "survey_year"
      expr: YEAR(survey_date)
      comment: "Year when survey was conducted"
    - name: "survey_month"
      expr: DATE_TRUNC('MONTH', survey_date)
      comment: "Month when survey was conducted"
    - name: "commissioned_year"
      expr: YEAR(commissioned_timestamp)
      comment: "Year when survey was commissioned"
    - name: "completed_year"
      expr: YEAR(completed_timestamp)
      comment: "Year when survey was completed"
  measures:
    - name: "total_surveys"
      expr: COUNT(1)
      comment: "Total number of cargo surveys conducted"
    - name: "total_estimated_loss_value"
      expr: SUM(CAST(estimated_loss_value AS DOUBLE))
      comment: "Total estimated loss value across all surveys"
    - name: "total_declared_cargo_value"
      expr: SUM(CAST(declared_cargo_value AS DOUBLE))
      comment: "Total declared cargo value for surveyed shipments"
    - name: "total_salvage_value"
      expr: SUM(CAST(salvage_value AS DOUBLE))
      comment: "Total salvage value recovered from damaged cargo"
    - name: "total_cargo_weight_kg"
      expr: SUM(CAST(cargo_weight_kg AS DOUBLE))
      comment: "Total weight of surveyed cargo in kilograms"
    - name: "total_cargo_volume_cbm"
      expr: SUM(CAST(cargo_volume_cbm AS DOUBLE))
      comment: "Total volume of surveyed cargo in cubic meters"
    - name: "total_liability_limit_sdr"
      expr: SUM(CAST(liability_limit_sdr AS DOUBLE))
      comment: "Total liability limits in Special Drawing Rights (SDR)"
    - name: "avg_estimated_loss_value"
      expr: AVG(CAST(estimated_loss_value AS DOUBLE))
      comment: "Average estimated loss value per survey"
    - name: "avg_declared_cargo_value"
      expr: AVG(CAST(declared_cargo_value AS DOUBLE))
      comment: "Average declared cargo value per survey"
    - name: "avg_salvage_value"
      expr: AVG(CAST(salvage_value AS DOUBLE))
      comment: "Average salvage value per survey"
    - name: "avg_cargo_weight_kg"
      expr: AVG(CAST(cargo_weight_kg AS DOUBLE))
      comment: "Average cargo weight per survey in kilograms"
    - name: "avg_cargo_volume_cbm"
      expr: AVG(CAST(cargo_volume_cbm AS DOUBLE))
      comment: "Average cargo volume per survey in cubic meters"
    - name: "distinct_claims"
      expr: COUNT(DISTINCT cargo_claim_id)
      comment: "Number of unique claims with surveys conducted"
    - name: "distinct_survey_agents"
      expr: COUNT(DISTINCT agent_id)
      comment: "Number of unique survey agents engaged"
    - name: "distinct_customers"
      expr: COUNT(DISTINCT customer_account_id)
      comment: "Number of unique customers with surveyed cargo"
    - name: "surveys_with_photographic_evidence"
      expr: COUNT(CASE WHEN photographic_evidence_indicator = TRUE THEN 1 END)
      comment: "Number of surveys with photographic evidence collected"
    - name: "joint_surveys"
      expr: COUNT(CASE WHEN joint_survey_indicator = TRUE THEN 1 END)
      comment: "Number of surveys conducted jointly with multiple parties"
    - name: "surveys_with_subrogation_applicable"
      expr: COUNT(CASE WHEN subrogation_applicable = TRUE THEN 1 END)
      comment: "Number of surveys where subrogation is applicable"
    - name: "surveys_involving_dangerous_goods"
      expr: COUNT(CASE WHEN is_dangerous_goods = TRUE THEN 1 END)
      comment: "Number of surveys involving dangerous goods"
$$;


CREATE OR REPLACE VIEW `transport_shipping_ecm`.`_metrics`.`claim_liability_determination`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Liability determination and legal framework KPIs tracking liability attribution, convention compliance, limitation periods, and settlement recommendations"
  source: "`transport_shipping_ecm`.`claim`.`liability_determination`"
  dimensions:
    - name: "determination_status"
      expr: determination_status
      comment: "Current status of liability determination (Draft, Under Review, Approved, Disputed, Final)"
    - name: "liability_basis"
      expr: liability_basis
      comment: "Legal basis for liability determination (Contractual, Statutory, Tort, Strict Liability)"
    - name: "liability_convention"
      expr: liability_convention
      comment: "International convention governing liability (Montreal, Warsaw, CMR, Hague-Visby, etc.)"
    - name: "claim_type"
      expr: claim_type
      comment: "Type of claim being determined"
    - name: "transport_mode"
      expr: transport_mode
      comment: "Transport mode of underlying shipment"
    - name: "liability_exclusion_type"
      expr: liability_exclusion_type
      comment: "Type of liability exclusion applied (Act of God, Force Majeure, Inherent Vice, etc.)"
    - name: "incoterms_code"
      expr: incoterms_code
      comment: "Incoterms code governing risk transfer"
    - name: "contributory_negligence_flag"
      expr: contributory_negligence_flag
      comment: "Flag indicating whether contributory negligence was found"
    - name: "dangerous_goods_flag"
      expr: dangerous_goods_flag
      comment: "Flag indicating whether determination involves dangerous goods"
    - name: "subrogation_flag"
      expr: subrogation_flag
      comment: "Flag indicating whether subrogation is applicable"
    - name: "cargo_declared_value_currency"
      expr: cargo_declared_value_currency
      comment: "Currency of declared cargo value"
    - name: "liability_limit_currency"
      expr: liability_limit_currency
      comment: "Currency of liability limit"
    - name: "determination_year"
      expr: YEAR(determination_date)
      comment: "Year when liability determination was made"
    - name: "determination_month"
      expr: DATE_TRUNC('MONTH', determination_date)
      comment: "Month when liability determination was made"
    - name: "approved_year"
      expr: YEAR(approved_timestamp)
      comment: "Year when determination was approved"
  measures:
    - name: "total_determinations"
      expr: COUNT(1)
      comment: "Total number of liability determinations made"
    - name: "total_cargo_declared_value"
      expr: SUM(CAST(cargo_declared_value AS DOUBLE))
      comment: "Total declared value of cargo across determinations"
    - name: "total_maximum_liability_amount"
      expr: SUM(CAST(maximum_liability_amount AS DOUBLE))
      comment: "Total maximum liability amounts determined"
    - name: "total_liability_limit_per_unit"
      expr: SUM(CAST(liability_limit_per_unit AS DOUBLE))
      comment: "Total liability limits per unit across determinations"
    - name: "total_reserve_amount"
      expr: SUM(CAST(reserve_amount AS DOUBLE))
      comment: "Total reserve amounts recommended"
    - name: "total_settlement_recommendation_amount"
      expr: SUM(CAST(settlement_recommendation_amount AS DOUBLE))
      comment: "Total settlement amounts recommended"
    - name: "total_subrogation_amount"
      expr: SUM(CAST(subrogation_amount AS DOUBLE))
      comment: "Total subrogation amounts identified"
    - name: "total_cargo_weight_kg"
      expr: SUM(CAST(cargo_weight_kg AS DOUBLE))
      comment: "Total cargo weight in kilograms across determinations"
    - name: "total_delay_hours"
      expr: SUM(CAST(delay_hours AS DOUBLE))
      comment: "Total delay hours across delay-related determinations"
    - name: "avg_carrier_liability_pct"
      expr: AVG(CAST(carrier_liability_pct AS DOUBLE))
      comment: "Average carrier liability percentage across determinations"
    - name: "avg_shipper_liability_pct"
      expr: AVG(CAST(shipper_liability_pct AS DOUBLE))
      comment: "Average shipper liability percentage across determinations"
    - name: "avg_consignee_liability_pct"
      expr: AVG(CAST(consignee_liability_pct AS DOUBLE))
      comment: "Average consignee liability percentage across determinations"
    - name: "avg_maximum_liability_amount"
      expr: AVG(CAST(maximum_liability_amount AS DOUBLE))
      comment: "Average maximum liability amount per determination"
    - name: "avg_settlement_recommendation_amount"
      expr: AVG(CAST(settlement_recommendation_amount AS DOUBLE))
      comment: "Average settlement recommendation amount per determination"
    - name: "distinct_claims"
      expr: COUNT(DISTINCT cargo_claim_id)
      comment: "Number of unique claims with liability determinations"
    - name: "distinct_carriers"
      expr: COUNT(DISTINCT carrier_id)
      comment: "Number of unique carriers involved in determinations"
    - name: "distinct_customers"
      expr: COUNT(DISTINCT customer_account_id)
      comment: "Number of unique customers with liability determinations"
    - name: "determinations_with_contributory_negligence"
      expr: COUNT(CASE WHEN contributory_negligence_flag = TRUE THEN 1 END)
      comment: "Number of determinations finding contributory negligence"
    - name: "determinations_with_subrogation"
      expr: COUNT(CASE WHEN subrogation_flag = TRUE THEN 1 END)
      comment: "Number of determinations with subrogation applicable"
    - name: "determinations_involving_dangerous_goods"
      expr: COUNT(CASE WHEN dangerous_goods_flag = TRUE THEN 1 END)
      comment: "Number of determinations involving dangerous goods"
$$;


CREATE OR REPLACE VIEW `transport_shipping_ecm`.`_metrics`.`claim_policy`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Insurance policy coverage and premium KPIs tracking policy limits, premium costs, coverage scope, and policy utilization"
  source: "`transport_shipping_ecm`.`claim`.`policy`"
  dimensions:
    - name: "policy_status"
      expr: policy_status
      comment: "Current status of insurance policy (Active, Expired, Cancelled, Suspended)"
    - name: "policy_type"
      expr: policy_type
      comment: "Type of insurance policy (All Risk, Named Perils, Liability, Open Cover)"
    - name: "liability_basis"
      expr: liability_basis
      comment: "Basis for liability coverage (Replacement Cost, Actual Cash Value, Agreed Value)"
    - name: "deductible_type"
      expr: deductible_type
      comment: "Type of deductible (Fixed Amount, Percentage, Franchise)"
    - name: "coverage_limit_currency"
      expr: coverage_limit_currency
      comment: "Currency of coverage limits"
    - name: "covered_transport_modes"
      expr: covered_transport_modes
      comment: "Transport modes covered by policy"
    - name: "geographic_scope"
      expr: geographic_scope
      comment: "Geographic scope of coverage (Worldwide, Regional, Specific Routes)"
    - name: "cargo_category"
      expr: cargo_category
      comment: "Category of cargo covered (General, Perishable, Hazardous, High Value)"
    - name: "dangerous_goods_covered"
      expr: dangerous_goods_covered
      comment: "Flag indicating whether dangerous goods are covered"
    - name: "open_cover_flag"
      expr: open_cover_flag
      comment: "Flag indicating whether policy is open cover (automatic coverage)"
    - name: "declaration_required_flag"
      expr: declaration_required_flag
      comment: "Flag indicating whether shipment declarations are required"
    - name: "auto_renewal_flag"
      expr: auto_renewal_flag
      comment: "Flag indicating whether policy auto-renews"
    - name: "co_insurance_flag"
      expr: co_insurance_flag
      comment: "Flag indicating whether policy involves co-insurance"
    - name: "reinsurance_flag"
      expr: reinsurance_flag
      comment: "Flag indicating whether policy is reinsured"
    - name: "subrogation_rights"
      expr: subrogation_rights
      comment: "Flag indicating whether insurer has subrogation rights"
    - name: "premium_payment_frequency"
      expr: premium_payment_frequency
      comment: "Frequency of premium payments (Annual, Quarterly, Monthly, Per Shipment)"
    - name: "effective_year"
      expr: YEAR(effective_date)
      comment: "Year when policy became effective"
    - name: "expiry_year"
      expr: YEAR(expiry_date)
      comment: "Year when policy expires"
  measures:
    - name: "total_policies"
      expr: COUNT(1)
      comment: "Total number of insurance policies"
    - name: "total_coverage_limit_amount"
      expr: SUM(CAST(coverage_limit_amount AS DOUBLE))
      comment: "Total coverage limit amounts across all policies"
    - name: "total_per_shipment_limit_amount"
      expr: SUM(CAST(per_shipment_limit_amount AS DOUBLE))
      comment: "Total per-shipment limit amounts"
    - name: "total_aggregate_annual_limit_amount"
      expr: SUM(CAST(aggregate_annual_limit_amount AS DOUBLE))
      comment: "Total aggregate annual limit amounts"
    - name: "total_premium_amount"
      expr: SUM(CAST(premium_amount AS DOUBLE))
      comment: "Total premium amounts paid across all policies"
    - name: "total_deductible_amount"
      expr: SUM(CAST(deductible_amount AS DOUBLE))
      comment: "Total deductible amounts across policies"
    - name: "total_survey_required_threshold_amount"
      expr: SUM(CAST(survey_required_threshold_amount AS DOUBLE))
      comment: "Total survey-required threshold amounts"
    - name: "avg_coverage_limit_amount"
      expr: AVG(CAST(coverage_limit_amount AS DOUBLE))
      comment: "Average coverage limit per policy"
    - name: "avg_premium_amount"
      expr: AVG(CAST(premium_amount AS DOUBLE))
      comment: "Average premium amount per policy"
    - name: "avg_deductible_amount"
      expr: AVG(CAST(deductible_amount AS DOUBLE))
      comment: "Average deductible amount per policy"
    - name: "avg_co_insurance_share_pct"
      expr: AVG(CAST(co_insurance_share_pct AS DOUBLE))
      comment: "Average co-insurance share percentage"
    - name: "distinct_customers"
      expr: COUNT(DISTINCT customer_account_id)
      comment: "Number of unique customers with policies"
    - name: "distinct_carriers"
      expr: COUNT(DISTINCT carrier_id)
      comment: "Number of unique carriers with policies"
    - name: "policies_covering_dangerous_goods"
      expr: COUNT(CASE WHEN dangerous_goods_covered = TRUE THEN 1 END)
      comment: "Number of policies covering dangerous goods"
    - name: "open_cover_policies"
      expr: COUNT(CASE WHEN open_cover_flag = TRUE THEN 1 END)
      comment: "Number of open cover policies"
    - name: "policies_with_auto_renewal"
      expr: COUNT(CASE WHEN auto_renewal_flag = TRUE THEN 1 END)
      comment: "Number of policies with auto-renewal"
    - name: "policies_with_co_insurance"
      expr: COUNT(CASE WHEN co_insurance_flag = TRUE THEN 1 END)
      comment: "Number of policies with co-insurance arrangements"
    - name: "policies_with_reinsurance"
      expr: COUNT(CASE WHEN reinsurance_flag = TRUE THEN 1 END)
      comment: "Number of policies with reinsurance"
    - name: "policies_with_subrogation_rights"
      expr: COUNT(CASE WHEN subrogation_rights = TRUE THEN 1 END)
      comment: "Number of policies with subrogation rights"
$$;
