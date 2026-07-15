-- Metric views for domain: actuarial | Business: Life Insurance | Version: 1 | Generated on: 2026-05-04 03:35:10

CREATE OR REPLACE VIEW `life_insurance_ecm`.`_metrics`.`actuarial_reserve_calculation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core actuarial reserve metrics tracking reserve balances, movements, and adequacy across valuation runs, cohorts, and reporting periods. Supports GAAP, IFRS17, PBR, and statutory reserve analysis."
  source: "`life_insurance_ecm`.`actuarial`.`reserve_calculation`"
  dimensions:
    - name: "valuation_date"
      expr: valuation_date
      comment: "Date of reserve valuation"
    - name: "valuation_year"
      expr: YEAR(valuation_date)
      comment: "Year of reserve valuation for trend analysis"
    - name: "valuation_quarter"
      expr: CONCAT('Q', QUARTER(valuation_date), '-', YEAR(valuation_date))
      comment: "Quarter of reserve valuation"
    - name: "reporting_basis"
      expr: reporting_basis
      comment: "Accounting standard basis (GAAP, IFRS17, SAP, PBR)"
    - name: "reserve_type"
      expr: reserve_type
      comment: "Type of reserve (e.g., benefit reserve, claim reserve, unearned premium)"
    - name: "calculation_method"
      expr: calculation_method
      comment: "Actuarial calculation method used"
    - name: "calculation_status"
      expr: calculation_status
      comment: "Status of reserve calculation (draft, approved, final)"
    - name: "actuary_name"
      expr: actuary_name
      comment: "Name of responsible actuary"
    - name: "model_version"
      expr: model_version
      comment: "Version of actuarial model used"
    - name: "mortality_assumption_table"
      expr: mortality_assumption_table
      comment: "Mortality table reference used in calculation"
    - name: "pbr_floor_applied"
      expr: CASE WHEN pbr_floor_applied_flag = TRUE THEN 'PBR Floor Applied' ELSE 'No PBR Floor' END
      comment: "Whether Principle-Based Reserves floor was applied"
    - name: "reserve_currency"
      expr: reserve_currency_code
      comment: "Currency of reserve amounts"
  measures:
    - name: "total_reserve_amount"
      expr: SUM(CAST(reserve_amount AS DOUBLE))
      comment: "Total reserve balance across all policies and cohorts"
    - name: "total_boy_reserve"
      expr: SUM(CAST(boy_reserve_amount AS DOUBLE))
      comment: "Total beginning-of-year reserve balance"
    - name: "total_eoy_reserve"
      expr: SUM(CAST(eoy_reserve_amount AS DOUBLE))
      comment: "Total end-of-year reserve balance"
    - name: "total_net_amount_at_risk"
      expr: SUM(CAST(net_amount_at_risk AS DOUBLE))
      comment: "Total net amount at risk (death benefit minus reserve)"
    - name: "total_deterministic_reserve"
      expr: SUM(CAST(deterministic_reserve_amount AS DOUBLE))
      comment: "Total deterministic reserve under PBR"
    - name: "total_stochastic_reserve"
      expr: SUM(CAST(stochastic_reserve_amount AS DOUBLE))
      comment: "Total stochastic reserve under PBR"
    - name: "total_net_premium_reserve"
      expr: SUM(CAST(net_premium_reserve_amount AS DOUBLE))
      comment: "Total net premium reserve (PBR floor)"
    - name: "total_reinsurance_ceded_reserve"
      expr: SUM(CAST(reinsurance_ceded_reserve AS DOUBLE))
      comment: "Total reserve ceded to reinsurers"
    - name: "total_reinsurance_recoverable"
      expr: SUM(CAST(reinsurance_recoverable_amount AS DOUBLE))
      comment: "Total reinsurance recoverable amount"
    - name: "total_assumption_unlock_impact"
      expr: SUM(CAST(assumption_unlock_amount AS DOUBLE))
      comment: "Total impact of assumption unlocks on reserves"
    - name: "total_experience_variance"
      expr: SUM(CAST(experience_variance_amount AS DOUBLE))
      comment: "Total experience variance from expected"
    - name: "total_interest_accretion"
      expr: SUM(CAST(interest_accretion_amount AS DOUBLE))
      comment: "Total interest accretion on reserves"
    - name: "total_new_business_reserve_change"
      expr: SUM(CAST(new_business_reserve_change AS DOUBLE))
      comment: "Total reserve change from new business"
    - name: "total_termination_reserve_change"
      expr: SUM(CAST(termination_reserve_change AS DOUBLE))
      comment: "Total reserve change from policy terminations"
    - name: "avg_discount_rate"
      expr: AVG(CAST(discount_rate AS DOUBLE))
      comment: "Average discount rate used in reserve calculations"
    - name: "avg_lapse_assumption_rate"
      expr: AVG(CAST(lapse_assumption_rate AS DOUBLE))
      comment: "Average lapse rate assumption"
    - name: "avg_cte_level"
      expr: AVG(CAST(cte_level AS DOUBLE))
      comment: "Average Conditional Tail Expectation level for stochastic reserves"
    - name: "reserve_calculation_count"
      expr: COUNT(1)
      comment: "Number of reserve calculation records"
    - name: "distinct_valuation_runs"
      expr: COUNT(DISTINCT valuation_run_id)
      comment: "Number of distinct valuation runs"
    - name: "distinct_cohorts"
      expr: COUNT(DISTINCT cohort_definition_id)
      comment: "Number of distinct cohorts valued"
    - name: "distinct_policies"
      expr: COUNT(DISTINCT in_force_policy_id)
      comment: "Number of distinct policies with reserves"
$$;


CREATE OR REPLACE VIEW `life_insurance_ecm`.`_metrics`.`actuarial_cash_flow_projection`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Actuarial cash flow projection metrics for asset-liability management, capital planning, and IFRS17 measurement. Tracks premium inflows, benefit outflows, investment income, and present values across projection periods and scenarios."
  source: "`life_insurance_ecm`.`actuarial`.`cash_flow_projection`"
  dimensions:
    - name: "projection_date"
      expr: projection_date
      comment: "Date of projected cash flow"
    - name: "projection_year"
      expr: YEAR(projection_date)
      comment: "Year of projected cash flow"
    - name: "projection_period"
      expr: projection_period
      comment: "Projection period identifier (e.g., month 1, year 5)"
    - name: "valuation_date"
      expr: valuation_date
      comment: "Valuation date from which projection originates"
    - name: "scenario_type"
      expr: scenario_type
      comment: "Type of scenario (deterministic, stochastic, stress)"
    - name: "projection_basis"
      expr: projection_basis
      comment: "Basis of projection (best estimate, locked-in, current)"
    - name: "product_segment"
      expr: product_segment_code
      comment: "Product segment code"
    - name: "model_version"
      expr: model_version
      comment: "Version of projection model"
    - name: "mortality_assumption_table"
      expr: mortality_assumption_table
      comment: "Mortality table used in projection"
    - name: "cte_level"
      expr: cte_level
      comment: "Conditional Tail Expectation level for stochastic projections"
  measures:
    - name: "total_premium_inflow"
      expr: SUM(CAST(premium_inflow_amount AS DOUBLE))
      comment: "Total projected premium inflows"
    - name: "total_benefit_outflow"
      expr: SUM(CAST(benefit_outflow_amount AS DOUBLE))
      comment: "Total projected benefit outflows (claims, surrenders, maturities)"
    - name: "total_expense_outflow"
      expr: SUM(CAST(expense_outflow_amount AS DOUBLE))
      comment: "Total projected expense outflows"
    - name: "total_commission_outflow"
      expr: SUM(CAST(commission_outflow_amount AS DOUBLE))
      comment: "Total projected commission outflows"
    - name: "total_investment_income"
      expr: SUM(CAST(investment_income_amount AS DOUBLE))
      comment: "Total projected investment income"
    - name: "total_net_cash_flow"
      expr: SUM(CAST(net_cash_flow_amount AS DOUBLE))
      comment: "Total net cash flow (inflows minus outflows)"
    - name: "total_present_value"
      expr: SUM(CAST(present_value_amount AS DOUBLE))
      comment: "Total present value of projected cash flows"
    - name: "total_reinsurance_ceded_premium"
      expr: SUM(CAST(reinsurance_ceded_premium_amount AS DOUBLE))
      comment: "Total reinsurance premiums ceded"
    - name: "total_reinsurance_recoverable"
      expr: SUM(CAST(reinsurance_recoverable_amount AS DOUBLE))
      comment: "Total reinsurance recoverable amounts"
    - name: "total_csm_balance"
      expr: SUM(CAST(csm_balance_amount AS DOUBLE))
      comment: "Total Contractual Service Margin balance (IFRS17)"
    - name: "total_dac_balance"
      expr: SUM(CAST(dac_balance_amount AS DOUBLE))
      comment: "Total Deferred Acquisition Cost balance"
    - name: "total_risk_adjustment"
      expr: SUM(CAST(risk_adjustment_amount AS DOUBLE))
      comment: "Total risk adjustment for non-financial risk (IFRS17)"
    - name: "total_reserve_amount"
      expr: SUM(CAST(reserve_amount AS DOUBLE))
      comment: "Total reserve amount projected"
    - name: "total_account_value"
      expr: SUM(CAST(account_value AS DOUBLE))
      comment: "Total account value for universal life and annuity products"
    - name: "total_face_amount"
      expr: SUM(CAST(face_amount AS DOUBLE))
      comment: "Total face amount in force"
    - name: "total_nar_amount"
      expr: SUM(CAST(nar_amount AS DOUBLE))
      comment: "Total net amount at risk"
    - name: "avg_interest_rate"
      expr: AVG(CAST(interest_rate AS DOUBLE))
      comment: "Average interest rate assumption"
    - name: "avg_lapse_rate"
      expr: AVG(CAST(lapse_rate AS DOUBLE))
      comment: "Average lapse rate assumption"
    - name: "avg_discount_rate"
      expr: AVG(CAST(discount_rate AS DOUBLE))
      comment: "Average discount rate used for present value"
    - name: "avg_asset_duration"
      expr: AVG(CAST(asset_duration AS DOUBLE))
      comment: "Average asset duration in years"
    - name: "avg_liability_duration"
      expr: AVG(CAST(liability_duration AS DOUBLE))
      comment: "Average liability duration in years"
    - name: "avg_duration_gap"
      expr: AVG(CAST(duration_gap AS DOUBLE))
      comment: "Average duration gap (asset minus liability duration)"
    - name: "avg_convexity"
      expr: AVG(CAST(convexity AS DOUBLE))
      comment: "Average convexity measure"
    - name: "projection_count"
      expr: COUNT(1)
      comment: "Number of cash flow projection records"
    - name: "distinct_scenarios"
      expr: COUNT(DISTINCT stochastic_scenario_id)
      comment: "Number of distinct scenarios projected"
    - name: "distinct_valuation_runs"
      expr: COUNT(DISTINCT valuation_run_id)
      comment: "Number of distinct valuation runs"
$$;


CREATE OR REPLACE VIEW `life_insurance_ecm`.`_metrics`.`actuarial_experience_study`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Experience study metrics tracking actual-to-expected ratios, credibility, and assumption recommendations across mortality, lapse, morbidity, and expense studies. Supports assumption setting and reserve adequacy analysis."
  source: "`life_insurance_ecm`.`actuarial`.`experience_study`"
  dimensions:
    - name: "study_period_start"
      expr: study_period_start_date
      comment: "Start date of experience study period"
    - name: "study_period_end"
      expr: study_period_end_date
      comment: "End date of experience study period"
    - name: "study_year"
      expr: YEAR(study_period_end_date)
      comment: "Year of study completion"
    - name: "valuation_date"
      expr: valuation_date
      comment: "Valuation date for study"
    - name: "study_type"
      expr: study_type
      comment: "Type of experience study (mortality, lapse, morbidity, expense)"
    - name: "study_status"
      expr: study_status
      comment: "Status of study (draft, peer review, approved, published)"
    - name: "study_name"
      expr: study_name
      comment: "Name of experience study"
    - name: "product_segment"
      expr: product_segment
      comment: "Product segment analyzed"
    - name: "regulatory_framework"
      expr: regulatory_framework
      comment: "Regulatory framework context (GAAP, IFRS17, SAP, PBR)"
    - name: "study_methodology"
      expr: study_methodology
      comment: "Methodology used for study"
    - name: "credibility_standard"
      expr: credibility_standard
      comment: "Credibility standard applied"
    - name: "assumption_locked"
      expr: CASE WHEN assumption_locked_flag = TRUE THEN 'Assumption Locked' ELSE 'Assumption Unlocked' END
      comment: "Whether assumption is locked for cohort"
    - name: "materiality_threshold_met"
      expr: CASE WHEN materiality_threshold_met_flag = TRUE THEN 'Material' ELSE 'Not Material' END
      comment: "Whether materiality threshold was met"
    - name: "data_source_system"
      expr: data_source_system
      comment: "Source system for experience data"
  measures:
    - name: "total_actual_events"
      expr: SUM(CAST(actual_events AS DOUBLE))
      comment: "Total actual events observed (deaths, lapses, claims)"
    - name: "total_expected_events"
      expr: SUM(CAST(expected_events AS DOUBLE))
      comment: "Total expected events based on assumptions"
    - name: "total_exposure_amount"
      expr: SUM(CAST(exposure_amount AS DOUBLE))
      comment: "Total exposure amount (face amount, account value, or policy count basis)"
    - name: "total_variance_from_expected"
      expr: SUM(CAST(variance_from_expected AS DOUBLE))
      comment: "Total variance from expected (actual minus expected)"
    - name: "total_policy_count"
      expr: SUM(CAST(policy_count AS DOUBLE))
      comment: "Total policy count in study"
    - name: "total_impact_on_reserves"
      expr: SUM(CAST(impact_on_reserves_amount AS DOUBLE))
      comment: "Total impact on reserves from recommended assumption changes"
    - name: "total_impact_on_capital"
      expr: SUM(CAST(impact_on_capital_amount AS DOUBLE))
      comment: "Total impact on capital from recommended assumption changes"
    - name: "avg_ae_ratio"
      expr: AVG(CAST(ae_ratio AS DOUBLE))
      comment: "Average actual-to-expected ratio across studies"
    - name: "avg_credibility_weight"
      expr: AVG(CAST(credibility_weight AS DOUBLE))
      comment: "Average credibility weight assigned to experience"
    - name: "avg_confidence_level"
      expr: AVG(CAST(confidence_level_pct AS DOUBLE))
      comment: "Average statistical confidence level percentage"
    - name: "avg_recommended_adjustment_factor"
      expr: AVG(CAST(recommended_adjustment_factor AS DOUBLE))
      comment: "Average recommended adjustment factor for assumptions"
    - name: "avg_recommended_assumption_change_pct"
      expr: AVG(CAST(recommended_assumption_change_pct AS DOUBLE))
      comment: "Average recommended assumption change percentage"
    - name: "study_count"
      expr: COUNT(1)
      comment: "Number of experience studies"
    - name: "distinct_actuaries"
      expr: COUNT(DISTINCT employee_id)
      comment: "Number of distinct actuaries conducting studies"
    - name: "distinct_plans"
      expr: COUNT(DISTINCT plan_id)
      comment: "Number of distinct plans analyzed"
$$;


CREATE OR REPLACE VIEW `life_insurance_ecm`.`_metrics`.`actuarial_ifrs17_csm`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "IFRS17 Contractual Service Margin metrics tracking CSM opening/closing balances, accretion, release, and adjustments. Critical for IFRS17 financial reporting and profitability measurement."
  source: "`life_insurance_ecm`.`actuarial`.`ifrs17_csm`"
  dimensions:
    - name: "valuation_date"
      expr: valuation_date
      comment: "Valuation date for CSM measurement"
    - name: "valuation_year"
      expr: YEAR(valuation_date)
      comment: "Year of CSM valuation"
    - name: "valuation_quarter"
      expr: CONCAT('Q', QUARTER(valuation_date), '-', YEAR(valuation_date))
      comment: "Quarter of CSM valuation"
    - name: "initial_recognition_date"
      expr: initial_recognition_date
      comment: "Date of initial recognition of insurance contract group"
    - name: "coverage_period_start"
      expr: coverage_period_start_date
      comment: "Start date of coverage period"
    - name: "coverage_period_end"
      expr: coverage_period_end_date
      comment: "End date of coverage period"
    - name: "measurement_model"
      expr: measurement_model
      comment: "IFRS17 measurement model (GMM, VFA, PAA)"
    - name: "product_line"
      expr: product_line
      comment: "Product line classification"
    - name: "reporting_segment"
      expr: reporting_segment
      comment: "Reporting segment for financial statements"
    - name: "onerous_contract"
      expr: CASE WHEN onerous_contract_flag = TRUE THEN 'Onerous' ELSE 'Not Onerous' END
      comment: "Whether contract group is onerous at initial recognition"
    - name: "reinsurance_flag"
      expr: CASE WHEN reinsurance_flag = TRUE THEN 'Reinsurance' ELSE 'Direct' END
      comment: "Whether this is reinsurance held or direct insurance"
    - name: "transition_approach"
      expr: transition_approach
      comment: "IFRS17 transition approach (FRA, MRA, FVA)"
    - name: "currency"
      expr: currency_code
      comment: "Currency of CSM amounts"
    - name: "record_status"
      expr: record_status
      comment: "Status of CSM record"
  measures:
    - name: "total_csm_opening_balance"
      expr: SUM(CAST(csm_opening_balance AS DOUBLE))
      comment: "Total CSM opening balance at start of period"
    - name: "total_csm_closing_balance"
      expr: SUM(CAST(csm_closing_balance AS DOUBLE))
      comment: "Total CSM closing balance at end of period"
    - name: "total_csm_initial_recognition"
      expr: SUM(CAST(csm_initial_recognition_amount AS DOUBLE))
      comment: "Total CSM recognized at initial recognition of new contracts"
    - name: "total_csm_accretion"
      expr: SUM(CAST(csm_accretion_amount AS DOUBLE))
      comment: "Total CSM accretion (interest unwind) during period"
    - name: "total_csm_release"
      expr: SUM(CAST(csm_release_amount AS DOUBLE))
      comment: "Total CSM released to profit or loss for services provided"
    - name: "total_csm_assumption_change"
      expr: SUM(CAST(csm_assumption_change_adjustment AS DOUBLE))
      comment: "Total CSM adjustment for changes in assumptions"
    - name: "total_csm_experience_adjustment"
      expr: SUM(CAST(csm_experience_adjustment AS DOUBLE))
      comment: "Total CSM adjustment for experience variances"
    - name: "total_csm_fx_adjustment"
      expr: SUM(CAST(csm_fx_adjustment AS DOUBLE))
      comment: "Total CSM adjustment for foreign exchange movements"
    - name: "total_loss_component_opening"
      expr: SUM(CAST(loss_component_opening_balance AS DOUBLE))
      comment: "Total loss component opening balance for onerous contracts"
    - name: "total_loss_component_closing"
      expr: SUM(CAST(loss_component_closing_balance AS DOUBLE))
      comment: "Total loss component closing balance for onerous contracts"
    - name: "total_loss_component_initial_recognition"
      expr: SUM(CAST(loss_component_initial_recognition AS DOUBLE))
      comment: "Total loss component recognized at initial recognition"
    - name: "total_loss_component_reversal"
      expr: SUM(CAST(loss_component_reversal AS DOUBLE))
      comment: "Total loss component reversal during period"
    - name: "total_risk_adjustment_opening"
      expr: SUM(CAST(risk_adjustment_opening_balance AS DOUBLE))
      comment: "Total risk adjustment opening balance"
    - name: "total_risk_adjustment_closing"
      expr: SUM(CAST(risk_adjustment_closing_balance AS DOUBLE))
      comment: "Total risk adjustment closing balance"
    - name: "total_risk_adjustment_change"
      expr: SUM(CAST(risk_adjustment_change AS DOUBLE))
      comment: "Total change in risk adjustment during period"
    - name: "total_fulfilment_cash_flows_pv"
      expr: SUM(CAST(fulfilment_cash_flows_pv AS DOUBLE))
      comment: "Total present value of fulfilment cash flows"
    - name: "total_coverage_units_opening"
      expr: SUM(CAST(coverage_units_opening AS DOUBLE))
      comment: "Total coverage units at opening"
    - name: "total_coverage_units_closing"
      expr: SUM(CAST(coverage_units_closing AS DOUBLE))
      comment: "Total coverage units at closing"
    - name: "total_coverage_units_provided"
      expr: SUM(CAST(coverage_units_provided AS DOUBLE))
      comment: "Total coverage units provided during period"
    - name: "avg_discount_rate_current"
      expr: AVG(CAST(discount_rate_current AS DOUBLE))
      comment: "Average current discount rate"
    - name: "avg_discount_rate_locked_in"
      expr: AVG(CAST(discount_rate_locked_in AS DOUBLE))
      comment: "Average locked-in discount rate for VFA contracts"
    - name: "csm_record_count"
      expr: COUNT(1)
      comment: "Number of CSM records"
    - name: "distinct_cohorts"
      expr: COUNT(DISTINCT cohort_definition_id)
      comment: "Number of distinct cohorts with CSM"
    - name: "distinct_valuation_runs"
      expr: COUNT(DISTINCT valuation_run_id)
      comment: "Number of distinct valuation runs"
$$;


CREATE OR REPLACE VIEW `life_insurance_ecm`.`_metrics`.`actuarial_valuation_run`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Valuation run execution metrics tracking reserve totals, policy counts, run performance, and compliance flags across quarterly and annual actuarial valuations."
  source: "`life_insurance_ecm`.`actuarial`.`valuation_run`"
  dimensions:
    - name: "valuation_date"
      expr: valuation_date
      comment: "Date of actuarial valuation"
    - name: "valuation_year"
      expr: YEAR(valuation_date)
      comment: "Year of valuation"
    - name: "valuation_quarter"
      expr: CONCAT('Q', QUARTER(valuation_date), '-', YEAR(valuation_date))
      comment: "Quarter of valuation"
    - name: "run_name"
      expr: run_name
      comment: "Name of valuation run"
    - name: "run_number"
      expr: run_number
      comment: "Sequential run number"
    - name: "run_type"
      expr: run_type
      comment: "Type of valuation run (quarterly, annual, ad-hoc, restatement)"
    - name: "run_status"
      expr: run_status
      comment: "Status of valuation run (running, completed, failed, approved)"
    - name: "valuation_basis"
      expr: valuation_basis
      comment: "Valuation basis (GAAP, IFRS17, SAP, PBR)"
    - name: "valuation_period_type"
      expr: valuation_period_type
      comment: "Period type (quarterly, annual, interim)"
    - name: "model_version"
      expr: model_version
      comment: "Version of actuarial model used"
    - name: "data_source_system"
      expr: data_source_system
      comment: "Source system for valuation data"
    - name: "mortality_table"
      expr: mortality_table
      comment: "Mortality table reference used"
    - name: "discount_rate_method"
      expr: discount_rate_method
      comment: "Method for determining discount rates"
    - name: "ldti_compliant"
      expr: CASE WHEN ldti_compliant_flag = TRUE THEN 'LDTI Compliant' ELSE 'Not LDTI Compliant' END
      comment: "Whether valuation is LDTI compliant"
    - name: "pbr_compliant"
      expr: CASE WHEN pbr_compliant_flag = TRUE THEN 'PBR Compliant' ELSE 'Not PBR Compliant' END
      comment: "Whether valuation is Principle-Based Reserves compliant"
    - name: "reinsurance_included"
      expr: CASE WHEN reinsurance_included_flag = TRUE THEN 'Reinsurance Included' ELSE 'Direct Only' END
      comment: "Whether reinsurance is included in valuation"
    - name: "reconciliation_status"
      expr: reconciliation_status
      comment: "Status of reconciliation to prior period"
  measures:
    - name: "total_reserve_amount"
      expr: SUM(CAST(total_reserve_amount AS DOUBLE))
      comment: "Total reserve amount across all policies"
    - name: "total_face_amount"
      expr: SUM(CAST(total_face_amount AS DOUBLE))
      comment: "Total face amount in force"
    - name: "total_account_value"
      expr: SUM(CAST(total_account_value AS DOUBLE))
      comment: "Total account value for universal life and annuity products"
    - name: "total_dac_balance"
      expr: SUM(CAST(dac_balance AS DOUBLE))
      comment: "Total Deferred Acquisition Cost balance"
    - name: "total_voba_balance"
      expr: SUM(CAST(voba_balance AS DOUBLE))
      comment: "Total Value of Business Acquired balance"
    - name: "total_variance_from_prior"
      expr: SUM(CAST(variance_from_prior_period AS DOUBLE))
      comment: "Total variance from prior period valuation"
    - name: "total_in_force_policy_count"
      expr: SUM(CAST(in_force_policy_count AS DOUBLE))
      comment: "Total in-force policy count valued"
    - name: "avg_run_duration_minutes"
      expr: AVG(CAST(run_duration_minutes AS DOUBLE))
      comment: "Average run duration in minutes"
    - name: "valuation_run_count"
      expr: COUNT(1)
      comment: "Number of valuation runs"
    - name: "distinct_assumption_sets"
      expr: COUNT(DISTINCT assumption_set_id)
      comment: "Number of distinct assumption sets used"
    - name: "distinct_actuaries"
      expr: COUNT(DISTINCT employee_id)
      comment: "Number of distinct primary actuaries"
$$;


CREATE OR REPLACE VIEW `life_insurance_ecm`.`_metrics`.`actuarial_assumption_set`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Actuarial assumption set metrics tracking assumption basis, credibility, regulatory compliance, and version control for mortality, lapse, expense, and investment return assumptions."
  source: "`life_insurance_ecm`.`actuarial`.`assumption_set`"
  dimensions:
    - name: "effective_date"
      expr: effective_date
      comment: "Effective date of assumption set"
    - name: "effective_year"
      expr: YEAR(effective_date)
      comment: "Year assumption set becomes effective"
    - name: "expiration_date"
      expr: expiration_date
      comment: "Expiration date of assumption set"
    - name: "valuation_date"
      expr: valuation_date
      comment: "Valuation date for assumption set"
    - name: "set_code"
      expr: set_code
      comment: "Unique code for assumption set"
    - name: "set_name"
      expr: set_name
      comment: "Name of assumption set"
    - name: "set_purpose"
      expr: set_purpose
      comment: "Purpose of assumption set (pricing, valuation, forecasting)"
    - name: "assumption_basis"
      expr: assumption_basis
      comment: "Basis of assumptions (best estimate, prudent, locked-in)"
    - name: "assumption_set_status"
      expr: assumption_set_status
      comment: "Status of assumption set (draft, approved, active, superseded)"
    - name: "regulatory_basis"
      expr: regulatory_basis
      comment: "Regulatory basis (GAAP, IFRS17, SAP, PBR)"
    - name: "product_applicability"
      expr: product_applicability
      comment: "Product lines to which assumptions apply"
    - name: "model_platform"
      expr: model_platform
      comment: "Actuarial modeling platform used"
    - name: "mortality_table_reference"
      expr: mortality_table_reference
      comment: "Mortality table reference code"
    - name: "lapse_assumption_reference"
      expr: lapse_assumption_reference
      comment: "Lapse assumption reference code"
    - name: "expense_assumption_reference"
      expr: expense_assumption_reference
      comment: "Expense assumption reference code"
    - name: "interest_rate_scenario"
      expr: interest_rate_scenario
      comment: "Interest rate scenario applied"
    - name: "peer_review_completed"
      expr: CASE WHEN peer_review_completed_flag = TRUE THEN 'Peer Reviewed' ELSE 'Not Peer Reviewed' END
      comment: "Whether peer review was completed"
    - name: "reinsurance_assumption"
      expr: CASE WHEN reinsurance_assumption_flag = TRUE THEN 'Reinsurance Included' ELSE 'Direct Only' END
      comment: "Whether reinsurance assumptions are included"
    - name: "version_number"
      expr: version_number
      comment: "Version number of assumption set"
  measures:
    - name: "avg_credibility_factor"
      expr: AVG(CAST(credibility_factor AS DOUBLE))
      comment: "Average credibility factor applied to company experience"
    - name: "avg_investment_return_assumption_pct"
      expr: AVG(CAST(investment_return_assumption_pct AS DOUBLE))
      comment: "Average investment return assumption percentage"
    - name: "avg_expense_loading_pct"
      expr: AVG(CAST(expense_loading_pct AS DOUBLE))
      comment: "Average expense loading percentage"
    - name: "avg_profit_margin_target_pct"
      expr: AVG(CAST(profit_margin_target_pct AS DOUBLE))
      comment: "Average profit margin target percentage"
    - name: "avg_roi_target_pct"
      expr: AVG(CAST(roi_target_pct AS DOUBLE))
      comment: "Average return on investment target percentage"
    - name: "total_nbv_target"
      expr: SUM(CAST(nbv_target_amount AS DOUBLE))
      comment: "Total new business value target amount"
    - name: "assumption_set_count"
      expr: COUNT(1)
      comment: "Number of assumption sets"
    - name: "distinct_actuaries"
      expr: COUNT(DISTINCT employee_id)
      comment: "Number of distinct primary actuaries"
    - name: "distinct_experience_studies"
      expr: COUNT(DISTINCT experience_study_id)
      comment: "Number of distinct experience studies referenced"
$$;


CREATE OR REPLACE VIEW `life_insurance_ecm`.`_metrics`.`actuarial_alm_position`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Asset-Liability Management position metrics tracking duration gap, convexity gap, hedge effectiveness, and surplus/deficit for interest rate risk management and capital adequacy."
  source: "`life_insurance_ecm`.`actuarial`.`alm_position`"
  dimensions:
    - name: "valuation_date"
      expr: valuation_date
      comment: "Date of ALM position measurement"
    - name: "valuation_year"
      expr: YEAR(valuation_date)
      comment: "Year of ALM position"
    - name: "valuation_quarter"
      expr: CONCAT('Q', QUARTER(valuation_date), '-', YEAR(valuation_date))
      comment: "Quarter of ALM position"
    - name: "calculation_timestamp"
      expr: calculation_timestamp
      comment: "Timestamp of ALM calculation"
    - name: "interest_rate_scenario"
      expr: interest_rate_scenario_code
      comment: "Interest rate scenario code applied"
    - name: "reporting_currency"
      expr: reporting_currency_code
      comment: "Currency of ALM position amounts"
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of ALM position (draft, approved, final)"
    - name: "model_version"
      expr: model_version
      comment: "Version of ALM model used"
  measures:
    - name: "total_asset_market_value"
      expr: SUM(CAST(asset_market_value AS DOUBLE))
      comment: "Total market value of assets"
    - name: "total_liability_market_value"
      expr: SUM(CAST(liability_market_value AS DOUBLE))
      comment: "Total market value of liabilities"
    - name: "total_surplus_deficit"
      expr: SUM(CAST(surplus_deficit_amount AS DOUBLE))
      comment: "Total surplus or deficit (assets minus liabilities)"
    - name: "avg_asset_duration"
      expr: AVG(CAST(asset_duration_years AS DOUBLE))
      comment: "Average asset duration in years"
    - name: "avg_liability_duration"
      expr: AVG(CAST(liability_duration_years AS DOUBLE))
      comment: "Average liability duration in years"
    - name: "avg_duration_gap"
      expr: AVG(CAST(duration_gap_years AS DOUBLE))
      comment: "Average duration gap (asset minus liability duration)"
    - name: "avg_effective_duration"
      expr: AVG(CAST(effective_duration_years AS DOUBLE))
      comment: "Average effective duration accounting for embedded options"
    - name: "avg_asset_convexity"
      expr: AVG(CAST(asset_convexity AS DOUBLE))
      comment: "Average asset convexity"
    - name: "avg_liability_convexity"
      expr: AVG(CAST(liability_convexity AS DOUBLE))
      comment: "Average liability convexity"
    - name: "avg_convexity_gap"
      expr: AVG(CAST(convexity_gap AS DOUBLE))
      comment: "Average convexity gap (asset minus liability convexity)"
    - name: "avg_hedge_ratio"
      expr: AVG(CAST(hedge_ratio AS DOUBLE))
      comment: "Average hedge ratio for interest rate risk"
    - name: "avg_hedge_effectiveness_pct"
      expr: AVG(CAST(hedge_effectiveness_percentage AS DOUBLE))
      comment: "Average hedge effectiveness percentage"
    - name: "avg_key_rate_duration_1yr"
      expr: AVG(CAST(key_rate_duration_1yr AS DOUBLE))
      comment: "Average key rate duration for 1-year point"
    - name: "avg_key_rate_duration_5yr"
      expr: AVG(CAST(key_rate_duration_5yr AS DOUBLE))
      comment: "Average key rate duration for 5-year point"
    - name: "avg_key_rate_duration_10yr"
      expr: AVG(CAST(key_rate_duration_10yr AS DOUBLE))
      comment: "Average key rate duration for 10-year point"
    - name: "avg_key_rate_duration_20yr"
      expr: AVG(CAST(key_rate_duration_20yr AS DOUBLE))
      comment: "Average key rate duration for 20-year point"
    - name: "avg_key_rate_duration_30yr"
      expr: AVG(CAST(key_rate_duration_30yr AS DOUBLE))
      comment: "Average key rate duration for 30-year point"
    - name: "alm_position_count"
      expr: COUNT(1)
      comment: "Number of ALM position records"
    - name: "distinct_portfolios"
      expr: COUNT(DISTINCT portfolio_id)
      comment: "Number of distinct portfolios analyzed"
$$;
