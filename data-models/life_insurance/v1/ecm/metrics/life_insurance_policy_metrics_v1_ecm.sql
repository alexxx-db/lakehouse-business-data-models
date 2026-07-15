-- Metric views for domain: policy | Business: Life Insurance | Version: 1 | Generated on: 2026-05-04 03:35:10

CREATE OR REPLACE VIEW `life_insurance_ecm`.`_metrics`.`policy_in_force_policy`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core policy portfolio metrics tracking active policies, face amounts, account values, and policy loan exposure"
  source: "`life_insurance_ecm`.`policy`.`in_force_policy`"
  dimensions:
    - name: "policy_status"
      expr: policy_status
      comment: "Current status of the policy (Active, Lapsed, Terminated, etc.)"
    - name: "product_type"
      expr: product_type
      comment: "Type of life insurance product (Term, Whole Life, Universal Life, Variable, etc.)"
    - name: "death_benefit_option"
      expr: death_benefit_option
      comment: "Death benefit option elected (Level, Increasing, Return of Premium, etc.)"
    - name: "underwriting_class"
      expr: underwriting_class
      comment: "Underwriting risk class assigned at issue (Preferred, Standard, Substandard, etc.)"
    - name: "jurisdiction_state"
      expr: jurisdiction_state
      comment: "State jurisdiction governing the policy"
    - name: "premium_mode"
      expr: premium_mode
      comment: "Frequency of premium payments (Annual, Semi-Annual, Quarterly, Monthly)"
    - name: "issue_year"
      expr: YEAR(issue_date)
      comment: "Calendar year the policy was issued"
    - name: "issue_month"
      expr: DATE_TRUNC('MONTH', issue_date)
      comment: "Month the policy was issued, truncated to first day of month"
    - name: "mec_status"
      expr: CASE WHEN mec_status_flag = TRUE THEN 'MEC' ELSE 'Non-MEC' END
      comment: "Modified Endowment Contract status indicator"
    - name: "reinsurance_cession_status"
      expr: CASE WHEN reinsurance_cession_flag = TRUE THEN 'Ceded' ELSE 'Retained' END
      comment: "Whether policy risk is ceded to reinsurer"
    - name: "policy_age_band"
      expr: CASE WHEN DATEDIFF(CURRENT_DATE(), issue_date) <= 365 THEN '0-1 Years' WHEN DATEDIFF(CURRENT_DATE(), issue_date) <= 1095 THEN '1-3 Years' WHEN DATEDIFF(CURRENT_DATE(), issue_date) <= 1825 THEN '3-5 Years' WHEN DATEDIFF(CURRENT_DATE(), issue_date) <= 3650 THEN '5-10 Years' ELSE '10+ Years' END
      comment: "Age band of policy since issue date"
  measures:
    - name: "policy_count"
      expr: COUNT(DISTINCT in_force_policy_id)
      comment: "Distinct count of in-force policies"
    - name: "total_face_amount"
      expr: SUM(CAST(face_amount AS DOUBLE))
      comment: "Total face amount (death benefit coverage) across all policies"
    - name: "total_account_value"
      expr: SUM(CAST(account_value AS DOUBLE))
      comment: "Total account value (cash accumulation) across all policies"
    - name: "total_csv_amount"
      expr: SUM(CAST(csv_amount AS DOUBLE))
      comment: "Total cash surrender value available to policyholders"
    - name: "total_death_benefit_amount"
      expr: SUM(CAST(death_benefit_amount AS DOUBLE))
      comment: "Total death benefit amount in force (actual benefit payable at death)"
    - name: "total_policy_loan_balance"
      expr: SUM(CAST(policy_loan_balance AS DOUBLE))
      comment: "Total outstanding policy loan balances across portfolio"
    - name: "total_modal_premium"
      expr: SUM(CAST(modal_premium AS DOUBLE))
      comment: "Total modal premium (premium per payment frequency) across all policies"
    - name: "avg_face_amount"
      expr: AVG(CAST(face_amount AS DOUBLE))
      comment: "Average face amount per policy"
    - name: "avg_account_value"
      expr: AVG(CAST(account_value AS DOUBLE))
      comment: "Average account value per policy"
    - name: "avg_modal_premium"
      expr: AVG(CAST(modal_premium AS DOUBLE))
      comment: "Average modal premium per policy"
    - name: "policy_loan_penetration_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN policy_loan_balance > 0 THEN in_force_policy_id END) / NULLIF(COUNT(DISTINCT in_force_policy_id), 0), 2)
      comment: "Percentage of policies with outstanding policy loans (loan utilization rate)"
    - name: "mec_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN mec_status_flag = TRUE THEN in_force_policy_id END) / NULLIF(COUNT(DISTINCT in_force_policy_id), 0), 2)
      comment: "Percentage of policies classified as Modified Endowment Contracts"
    - name: "reinsurance_cession_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN reinsurance_cession_flag = TRUE THEN in_force_policy_id END) / NULLIF(COUNT(DISTINCT in_force_policy_id), 0), 2)
      comment: "Percentage of policies with risk ceded to reinsurers"
$$;


CREATE OR REPLACE VIEW `life_insurance_ecm`.`_metrics`.`policy_loan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Policy loan portfolio metrics tracking loan origination, outstanding balances, interest accrual, and repayment activity"
  source: "`life_insurance_ecm`.`policy`.`loan`"
  dimensions:
    - name: "loan_status"
      expr: loan_status
      comment: "Current status of the policy loan (Active, Closed, Defaulted, etc.)"
    - name: "loan_type"
      expr: loan_type
      comment: "Type of policy loan (Standard, Automatic Premium Loan, etc.)"
    - name: "interest_rate_type"
      expr: interest_rate_type
      comment: "Interest rate structure (Fixed, Variable, Indexed, etc.)"
    - name: "disbursement_method"
      expr: disbursement_method
      comment: "Method used to disburse loan proceeds (Check, ACH, Wire, etc.)"
    - name: "origination_year"
      expr: YEAR(origination_date)
      comment: "Calendar year the loan was originated"
    - name: "origination_month"
      expr: DATE_TRUNC('MONTH', origination_date)
      comment: "Month the loan was originated, truncated to first day of month"
    - name: "mec_impact_flag"
      expr: CASE WHEN mec_impact_flag = TRUE THEN 'MEC Impact' ELSE 'No MEC Impact' END
      comment: "Whether the loan triggered Modified Endowment Contract status"
    - name: "apl_trigger_flag"
      expr: CASE WHEN apl_trigger_flag = TRUE THEN 'APL Triggered' ELSE 'No APL' END
      comment: "Whether Automatic Premium Loan provision was triggered"
  measures:
    - name: "loan_count"
      expr: COUNT(DISTINCT loan_id)
      comment: "Distinct count of policy loans"
    - name: "total_original_loan_amount"
      expr: SUM(CAST(original_loan_amount AS DOUBLE))
      comment: "Total original loan amounts disbursed"
    - name: "total_outstanding_principal"
      expr: SUM(CAST(outstanding_principal_balance AS DOUBLE))
      comment: "Total outstanding principal balance across all loans"
    - name: "total_accrued_interest"
      expr: SUM(CAST(accrued_interest_balance AS DOUBLE))
      comment: "Total accrued interest balance across all loans"
    - name: "total_outstanding_balance"
      expr: SUM(CAST(total_outstanding_balance AS DOUBLE))
      comment: "Total outstanding balance (principal plus interest) across all loans"
    - name: "total_repayments_to_date"
      expr: SUM(CAST(total_repayments_to_date AS DOUBLE))
      comment: "Total loan repayments received to date"
    - name: "avg_original_loan_amount"
      expr: AVG(CAST(original_loan_amount AS DOUBLE))
      comment: "Average original loan amount per loan"
    - name: "avg_outstanding_balance"
      expr: AVG(CAST(total_outstanding_balance AS DOUBLE))
      comment: "Average outstanding balance per loan"
    - name: "avg_interest_rate"
      expr: AVG(CAST(interest_rate AS DOUBLE))
      comment: "Average interest rate across all loans"
    - name: "loan_to_csv_ratio"
      expr: AVG(CAST(to_csv_ratio AS DOUBLE))
      comment: "Average loan-to-cash-surrender-value ratio (loan utilization against available collateral)"
$$;


CREATE OR REPLACE VIEW `life_insurance_ecm`.`_metrics`.`policy_surrender`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Policy surrender and lapse metrics tracking voluntary terminations, surrender charges, tax implications, and cash value distributions"
  source: "`life_insurance_ecm`.`policy`.`surrender`"
  dimensions:
    - name: "transaction_status"
      expr: transaction_status
      comment: "Status of the surrender transaction (Pending, Approved, Completed, Rejected, etc.)"
    - name: "transaction_type"
      expr: transaction_type
      comment: "Type of surrender transaction (Full Surrender, Partial Withdrawal, 1035 Exchange, etc.)"
    - name: "reason_code"
      expr: reason_code
      comment: "Reason code for surrender (Financial Need, Better Product, Dissatisfaction, etc.)"
    - name: "disbursement_method"
      expr: disbursement_method
      comment: "Method used to disburse surrender proceeds (Check, ACH, Wire, Rollover, etc.)"
    - name: "nonforfeiture_option_type"
      expr: nonforfeiture_option_type
      comment: "Nonforfeiture option elected (Cash Surrender, Reduced Paid-Up, Extended Term, etc.)"
    - name: "effective_year"
      expr: YEAR(effective_date)
      comment: "Calendar year the surrender became effective"
    - name: "effective_month"
      expr: DATE_TRUNC('MONTH', effective_date)
      comment: "Month the surrender became effective, truncated to first day of month"
    - name: "form_1099r_indicator"
      expr: CASE WHEN form_1099r_indicator = TRUE THEN 'Reportable' ELSE 'Not Reportable' END
      comment: "Whether surrender is reportable on IRS Form 1099-R"
  measures:
    - name: "surrender_count"
      expr: COUNT(DISTINCT surrender_id)
      comment: "Distinct count of surrender transactions"
    - name: "total_gross_amount"
      expr: SUM(CAST(gross_amount AS DOUBLE))
      comment: "Total gross surrender amount before charges and withholding"
    - name: "total_surrender_charge"
      expr: SUM(CAST(charge_amount AS DOUBLE))
      comment: "Total surrender charges assessed"
    - name: "total_net_proceeds"
      expr: SUM(CAST(net_proceeds AS DOUBLE))
      comment: "Total net proceeds disbursed to policyholders after all charges and withholding"
    - name: "total_taxable_gain"
      expr: SUM(CAST(taxable_gain_amount AS DOUBLE))
      comment: "Total taxable gain recognized on surrenders"
    - name: "total_tax_withholding"
      expr: SUM(CAST(tax_withholding_amount AS DOUBLE))
      comment: "Total tax withholding on surrender proceeds"
    - name: "total_outstanding_loan_offset"
      expr: SUM(CAST(outstanding_loan_amount AS DOUBLE))
      comment: "Total outstanding loan amounts offset at surrender"
    - name: "total_csv_used"
      expr: SUM(CAST(csv_amount_used AS DOUBLE))
      comment: "Total cash surrender value utilized in surrender transactions"
    - name: "avg_gross_amount"
      expr: AVG(CAST(gross_amount AS DOUBLE))
      comment: "Average gross surrender amount per transaction"
    - name: "avg_net_proceeds"
      expr: AVG(CAST(net_proceeds AS DOUBLE))
      comment: "Average net proceeds per surrender transaction"
    - name: "surrender_charge_rate"
      expr: ROUND(100.0 * SUM(CAST(charge_amount AS DOUBLE)) / NULLIF(SUM(CAST(gross_amount AS DOUBLE)), 0), 2)
      comment: "Surrender charge as percentage of gross amount (effective surrender charge rate)"
    - name: "taxable_gain_rate"
      expr: ROUND(100.0 * SUM(CAST(taxable_gain_amount AS DOUBLE)) / NULLIF(SUM(CAST(gross_amount AS DOUBLE)), 0), 2)
      comment: "Taxable gain as percentage of gross amount (tax efficiency indicator)"
$$;


CREATE OR REPLACE VIEW `life_insurance_ecm`.`_metrics`.`policy_dividend`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Participating policy dividend metrics tracking dividend declarations, option elections, accumulations, and paid-up additions"
  source: "`life_insurance_ecm`.`policy`.`dividend`"
  dimensions:
    - name: "dividend_status"
      expr: dividend_status
      comment: "Status of the dividend (Declared, Paid, Pending, Reversed, etc.)"
    - name: "option_code"
      expr: option_code
      comment: "Dividend option elected by policyholder (Cash, Premium Reduction, Accumulation, PUA, OYT, Loan Repayment, etc.)"
    - name: "declaration_year"
      expr: YEAR(declaration_date)
      comment: "Calendar year the dividend was declared"
    - name: "declaration_month"
      expr: DATE_TRUNC('MONTH', declaration_date)
      comment: "Month the dividend was declared, truncated to first day of month"
    - name: "special_dividend_flag"
      expr: CASE WHEN special_dividend_flag = TRUE THEN 'Special Dividend' ELSE 'Regular Dividend' END
      comment: "Whether dividend is a special (non-recurring) dividend"
    - name: "terminal_dividend_flag"
      expr: CASE WHEN terminal_dividend_flag = TRUE THEN 'Terminal Dividend' ELSE 'Annual Dividend' END
      comment: "Whether dividend is a terminal dividend paid at policy maturity or death"
  measures:
    - name: "dividend_count"
      expr: COUNT(DISTINCT dividend_id)
      comment: "Distinct count of dividend transactions"
    - name: "total_declared_amount"
      expr: SUM(CAST(declared_amount AS DOUBLE))
      comment: "Total dividend amount declared to policyholders"
    - name: "total_cash_payment"
      expr: SUM(CAST(cash_payment_amount AS DOUBLE))
      comment: "Total dividends paid in cash"
    - name: "total_premium_reduction"
      expr: SUM(CAST(premium_reduction_amount AS DOUBLE))
      comment: "Total dividends applied to reduce premiums"
    - name: "total_loan_reduction"
      expr: SUM(CAST(loan_reduction_amount AS DOUBLE))
      comment: "Total dividends applied to reduce policy loan balances"
    - name: "total_pua_face_amount"
      expr: SUM(CAST(pua_face_amount AS DOUBLE))
      comment: "Total face amount of paid-up additions purchased with dividends"
    - name: "total_pua_cash_value"
      expr: SUM(CAST(pua_cash_value AS DOUBLE))
      comment: "Total cash value of paid-up additions"
    - name: "total_accumulated_balance"
      expr: SUM(CAST(accumulated_balance AS DOUBLE))
      comment: "Total dividend accumulation balance (dividends left on deposit)"
    - name: "total_accumulated_interest_ytd"
      expr: SUM(CAST(accumulated_interest_ytd AS DOUBLE))
      comment: "Total interest credited year-to-date on accumulated dividends"
    - name: "avg_declared_amount"
      expr: AVG(CAST(declared_amount AS DOUBLE))
      comment: "Average dividend amount declared per policy"
    - name: "avg_accumulated_interest_rate"
      expr: AVG(CAST(accumulated_interest_rate AS DOUBLE))
      comment: "Average interest rate credited on accumulated dividends"
$$;


CREATE OR REPLACE VIEW `life_insurance_ecm`.`_metrics`.`policy_conversion`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Policy conversion metrics tracking term-to-permanent conversions, conversion privilege utilization, and underwriting outcomes"
  source: "`life_insurance_ecm`.`policy`.`conversion`"
  dimensions:
    - name: "conversion_status"
      expr: conversion_status
      comment: "Status of the conversion (Pending, Approved, Completed, Rejected, etc.)"
    - name: "conversion_type"
      expr: conversion_type
      comment: "Type of conversion (Attained Age, Original Age, Evidence-Based, etc.)"
    - name: "original_product_type"
      expr: original_product_type
      comment: "Product type of the original policy being converted"
    - name: "new_product_type"
      expr: new_product_type
      comment: "Product type of the new converted policy"
    - name: "request_year"
      expr: YEAR(request_date)
      comment: "Calendar year the conversion was requested"
    - name: "request_month"
      expr: DATE_TRUNC('MONTH', request_date)
      comment: "Month the conversion was requested, truncated to first day of month"
    - name: "evidence_of_insurability_required"
      expr: CASE WHEN evidence_of_insurability_required_flag = TRUE THEN 'Evidence Required' ELSE 'No Evidence Required' END
      comment: "Whether medical evidence of insurability was required for conversion"
    - name: "nigo_flag"
      expr: CASE WHEN nigo_flag = TRUE THEN 'NIGO' ELSE 'Good Order' END
      comment: "Whether conversion application was Not In Good Order (NIGO)"
  measures:
    - name: "conversion_count"
      expr: COUNT(DISTINCT conversion_id)
      comment: "Distinct count of conversion transactions"
    - name: "total_original_face_amount"
      expr: SUM(CAST(original_face_amount AS DOUBLE))
      comment: "Total face amount of original policies being converted"
    - name: "total_new_face_amount"
      expr: SUM(CAST(new_face_amount AS DOUBLE))
      comment: "Total face amount of new converted policies"
    - name: "total_credit_amount"
      expr: SUM(CAST(credit_amount AS DOUBLE))
      comment: "Total conversion credits applied (e.g., original age credit)"
    - name: "avg_original_face_amount"
      expr: AVG(CAST(original_face_amount AS DOUBLE))
      comment: "Average face amount of original policies being converted"
    - name: "avg_new_face_amount"
      expr: AVG(CAST(new_face_amount AS DOUBLE))
      comment: "Average face amount of new converted policies"
    - name: "conversion_approval_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN conversion_status IN ('Approved', 'Completed') THEN conversion_id END) / NULLIF(COUNT(DISTINCT conversion_id), 0), 2)
      comment: "Percentage of conversion requests approved (conversion success rate)"
    - name: "nigo_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN nigo_flag = TRUE THEN conversion_id END) / NULLIF(COUNT(DISTINCT conversion_id), 0), 2)
      comment: "Percentage of conversion applications Not In Good Order (application quality indicator)"
    - name: "evidence_waiver_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN evidence_of_insurability_waived_flag = TRUE THEN conversion_id END) / NULLIF(COUNT(DISTINCT conversion_id), 0), 2)
      comment: "Percentage of conversions where evidence of insurability was waived"
$$;


CREATE OR REPLACE VIEW `life_insurance_ecm`.`_metrics`.`policy_reinstatement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Policy reinstatement metrics tracking lapsed policy recovery, reinstatement success rates, and back premium collection"
  source: "`life_insurance_ecm`.`policy`.`policy_reinstatement`"
  dimensions:
    - name: "reinstatement_status"
      expr: reinstatement_status
      comment: "Status of the reinstatement (Pending, Approved, Completed, Denied, etc.)"
    - name: "reinstatement_type"
      expr: reinstatement_type
      comment: "Type of reinstatement (Standard, Simplified, Guaranteed, etc.)"
    - name: "underwriting_decision"
      expr: underwriting_decision
      comment: "Underwriting decision on reinstatement application (Approved, Declined, Postponed, etc.)"
    - name: "application_year"
      expr: YEAR(application_date)
      comment: "Calendar year the reinstatement application was submitted"
    - name: "application_month"
      expr: DATE_TRUNC('MONTH', application_date)
      comment: "Month the reinstatement application was submitted, truncated to first day of month"
    - name: "evidence_of_insurability_required"
      expr: CASE WHEN evidence_of_insurability_required_flag = TRUE THEN 'Evidence Required' ELSE 'No Evidence Required' END
      comment: "Whether medical evidence of insurability was required for reinstatement"
    - name: "nigo_flag"
      expr: CASE WHEN nigo_flag = TRUE THEN 'NIGO' ELSE 'Good Order' END
      comment: "Whether reinstatement application was Not In Good Order (NIGO)"
  measures:
    - name: "reinstatement_count"
      expr: COUNT(DISTINCT policy_reinstatement_id)
      comment: "Distinct count of reinstatement applications"
    - name: "total_back_premium"
      expr: SUM(CAST(back_premium_amount AS DOUBLE))
      comment: "Total back premiums collected for reinstatements"
    - name: "total_back_premium_interest"
      expr: SUM(CAST(back_premium_interest_amount AS DOUBLE))
      comment: "Total interest charged on back premiums"
    - name: "total_reinstatement_fee"
      expr: SUM(CAST(fee_amount AS DOUBLE))
      comment: "Total reinstatement fees collected"
    - name: "total_amount_collected"
      expr: SUM(CAST(amount_collected AS DOUBLE))
      comment: "Total amount collected for reinstatements (premiums, interest, fees)"
    - name: "avg_back_premium"
      expr: AVG(CAST(back_premium_amount AS DOUBLE))
      comment: "Average back premium amount per reinstatement"
    - name: "avg_amount_collected"
      expr: AVG(CAST(amount_collected AS DOUBLE))
      comment: "Average total amount collected per reinstatement"
    - name: "reinstatement_approval_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN reinstatement_status IN ('Approved', 'Completed') THEN policy_reinstatement_id END) / NULLIF(COUNT(DISTINCT policy_reinstatement_id), 0), 2)
      comment: "Percentage of reinstatement applications approved (reinstatement success rate)"
    - name: "nigo_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN nigo_flag = TRUE THEN policy_reinstatement_id END) / NULLIF(COUNT(DISTINCT policy_reinstatement_id), 0), 2)
      comment: "Percentage of reinstatement applications Not In Good Order (application quality indicator)"
$$;


CREATE OR REPLACE VIEW `life_insurance_ecm`.`_metrics`.`policy_value`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Policy valuation metrics tracking account values, reserves, charges, credits, and compliance with tax qualification tests"
  source: "`life_insurance_ecm`.`policy`.`value`"
  dimensions:
    - name: "valuation_basis_code"
      expr: valuation_basis_code
      comment: "Valuation basis used (Statutory, GAAP, Tax, Economic, etc.)"
    - name: "valuation_year"
      expr: YEAR(valuation_date)
      comment: "Calendar year of the valuation"
    - name: "valuation_month"
      expr: DATE_TRUNC('MONTH', valuation_date)
      comment: "Month of the valuation, truncated to first day of month"
    - name: "mec_status"
      expr: CASE WHEN mec_status_flag = TRUE THEN 'MEC' ELSE 'Non-MEC' END
      comment: "Modified Endowment Contract status at valuation date"
    - name: "cvat_compliance"
      expr: CASE WHEN cvat_compliance_flag = TRUE THEN 'CVAT Compliant' ELSE 'CVAT Non-Compliant' END
      comment: "Cash Value Accumulation Test compliance status"
    - name: "gpt_compliance"
      expr: CASE WHEN gpt_compliance_flag = TRUE THEN 'GPT Compliant' ELSE 'GPT Non-Compliant' END
      comment: "Guideline Premium Test compliance status"
  measures:
    - name: "valuation_count"
      expr: COUNT(DISTINCT value_id)
      comment: "Distinct count of policy valuations"
    - name: "total_account_value"
      expr: SUM(CAST(av_amount AS DOUBLE))
      comment: "Total account value across all policies"
    - name: "total_csv_amount"
      expr: SUM(CAST(csv_amount AS DOUBLE))
      comment: "Total cash surrender value across all policies"
    - name: "total_death_benefit"
      expr: SUM(CAST(death_benefit_amount AS DOUBLE))
      comment: "Total death benefit amount in force"
    - name: "total_reserve_amount"
      expr: SUM(CAST(reserve_amount AS DOUBLE))
      comment: "Total policy reserves held"
    - name: "total_nar_amount"
      expr: SUM(CAST(nar_amount AS DOUBLE))
      comment: "Total Net Amount at Risk (death benefit minus account value)"
    - name: "total_loan_balance"
      expr: SUM(CAST(loan_balance_amount AS DOUBLE))
      comment: "Total outstanding policy loan balances"
    - name: "total_coi_charges"
      expr: SUM(CAST(coi_charge_amount AS DOUBLE))
      comment: "Total cost of insurance charges assessed"
    - name: "total_admin_fees"
      expr: SUM(CAST(admin_fee_amount AS DOUBLE))
      comment: "Total administrative fees charged"
    - name: "total_interest_credited"
      expr: SUM(CAST(interest_credited_amount AS DOUBLE))
      comment: "Total interest credited to policy accounts"
    - name: "total_premium_ytd"
      expr: SUM(CAST(premium_ytd_amount AS DOUBLE))
      comment: "Total premiums received year-to-date"
    - name: "total_withdrawal_ytd"
      expr: SUM(CAST(withdrawal_ytd_amount AS DOUBLE))
      comment: "Total withdrawals processed year-to-date"
    - name: "avg_account_value"
      expr: AVG(CAST(av_amount AS DOUBLE))
      comment: "Average account value per policy"
    - name: "avg_death_benefit"
      expr: AVG(CAST(death_benefit_amount AS DOUBLE))
      comment: "Average death benefit per policy"
$$;


CREATE OR REPLACE VIEW `life_insurance_ecm`.`_metrics`.`policy_rider`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Policy rider metrics tracking rider attachment, face amounts, premiums, and rider-specific benefits across the portfolio"
  source: "`life_insurance_ecm`.`policy`.`policy_rider`"
  dimensions:
    - name: "rider_status"
      expr: rider_status
      comment: "Current status of the rider (Active, Terminated, Suspended, etc.)"
    - name: "premium_mode"
      expr: premium_mode
      comment: "Frequency of rider premium payments (Annual, Semi-Annual, Quarterly, Monthly, Single)"
    - name: "underwriting_class"
      expr: underwriting_class
      comment: "Underwriting risk class assigned to the rider"
    - name: "effective_year"
      expr: YEAR(effective_date)
      comment: "Calendar year the rider became effective"
    - name: "effective_month"
      expr: DATE_TRUNC('MONTH', effective_date)
      comment: "Month the rider became effective, truncated to first day of month"
    - name: "reinsurance_ceded"
      expr: CASE WHEN reinsurance_ceded_flag = TRUE THEN 'Ceded' ELSE 'Retained' END
      comment: "Whether rider risk is ceded to reinsurer"
    - name: "waiver_of_premium"
      expr: CASE WHEN waiver_of_premium_flag = TRUE THEN 'Waiver Active' ELSE 'No Waiver' END
      comment: "Whether waiver of premium benefit is active on the rider"
  measures:
    - name: "rider_count"
      expr: COUNT(DISTINCT policy_rider_id)
      comment: "Distinct count of policy riders"
    - name: "total_rider_face_amount"
      expr: SUM(CAST(face_amount AS DOUBLE))
      comment: "Total face amount (benefit coverage) across all riders"
    - name: "total_rider_premium"
      expr: SUM(CAST(premium_amount AS DOUBLE))
      comment: "Total rider premium amount across all riders"
    - name: "total_rider_cash_value"
      expr: SUM(CAST(cash_value AS DOUBLE))
      comment: "Total cash value accumulated in riders (where applicable)"
    - name: "total_rider_loan_outstanding"
      expr: SUM(CAST(loan_outstanding_amount AS DOUBLE))
      comment: "Total outstanding loan amounts against riders"
    - name: "total_surrender_charge"
      expr: SUM(CAST(surrender_charge AS DOUBLE))
      comment: "Total surrender charges applicable to riders"
    - name: "avg_rider_face_amount"
      expr: AVG(CAST(face_amount AS DOUBLE))
      comment: "Average face amount per rider"
    - name: "avg_rider_premium"
      expr: AVG(CAST(premium_amount AS DOUBLE))
      comment: "Average premium amount per rider"
    - name: "rider_attachment_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT policy_rider_id) / NULLIF(COUNT(DISTINCT in_force_policy_id), 0), 2)
      comment: "Average number of riders per base policy (rider penetration rate)"
$$;
