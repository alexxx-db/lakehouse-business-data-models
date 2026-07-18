-- Metric views for domain: owner | Business: Real Estate | Version: 1 | Generated on: 2026-05-02 01:37:58

CREATE OR REPLACE VIEW `real_estate_ecm`.`_metrics`.`owner`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core owner entity metrics tracking investor/owner base composition, accreditation status, and onboarding lifecycle"
  source: "`real_estate_ecm`.`owner`.`owner`"
  dimensions:
    - name: "entity_type"
      expr: entity_type
      comment: "Legal entity classification of the owner (individual, trust, corporation, partnership, etc.)"
    - name: "owner_class"
      expr: owner_class
      comment: "Owner classification tier or category"
    - name: "investor_category"
      expr: CASE WHEN accredited_investor_flag = TRUE AND qualified_purchaser_flag = TRUE THEN 'Qualified Purchaser' WHEN accredited_investor_flag = TRUE THEN 'Accredited Investor' ELSE 'Non-Accredited' END
      comment: "Investor accreditation category based on regulatory qualification flags"
    - name: "kyc_status"
      expr: kyc_status
      comment: "Current Know Your Customer verification status"
    - name: "onboarding_status"
      expr: onboarding_status
      comment: "Current onboarding lifecycle status"
    - name: "risk_tolerance"
      expr: risk_tolerance
      comment: "Owner's stated risk tolerance level"
    - name: "aum_tier"
      expr: aum_tier
      comment: "Assets under management tier classification"
    - name: "domicile_state"
      expr: domicile_state
      comment: "State of domicile for the owner"
    - name: "onboarding_year"
      expr: YEAR(onboarding_date)
      comment: "Year the owner was onboarded"
    - name: "onboarding_quarter"
      expr: DATE_TRUNC('quarter', onboarding_date)
      comment: "Quarter the owner was onboarded"
    - name: "kyc_verified_year"
      expr: YEAR(kyc_verified_date)
      comment: "Year KYC verification was completed"
    - name: "is_accredited"
      expr: accredited_investor_flag
      comment: "Boolean flag indicating accredited investor status"
    - name: "is_qualified_purchaser"
      expr: qualified_purchaser_flag
      comment: "Boolean flag indicating qualified purchaser status"
    - name: "is_tax_exempt"
      expr: tax_exempt_flag
      comment: "Boolean flag indicating tax-exempt status"
    - name: "is_politically_exposed"
      expr: politically_exposed_flag
      comment: "Boolean flag indicating politically exposed person status"
    - name: "has_esg_mandate"
      expr: esg_mandate_flag
      comment: "Boolean flag indicating ESG investment mandate"
  measures:
    - name: "total_owners"
      expr: COUNT(DISTINCT owner_id)
      comment: "Total unique owners in the portfolio"
    - name: "accredited_investor_count"
      expr: COUNT(DISTINCT CASE WHEN accredited_investor_flag = TRUE THEN owner_id END)
      comment: "Count of accredited investors"
    - name: "qualified_purchaser_count"
      expr: COUNT(DISTINCT CASE WHEN qualified_purchaser_flag = TRUE THEN owner_id END)
      comment: "Count of qualified purchasers"
    - name: "accreditation_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN accredited_investor_flag = TRUE THEN owner_id END) / NULLIF(COUNT(DISTINCT owner_id), 0), 2)
      comment: "Percentage of owners who are accredited investors"
    - name: "kyc_verified_count"
      expr: COUNT(DISTINCT CASE WHEN kyc_status = 'Verified' THEN owner_id END)
      comment: "Count of owners with verified KYC status"
    - name: "kyc_verification_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN kyc_status = 'Verified' THEN owner_id END) / NULLIF(COUNT(DISTINCT owner_id), 0), 2)
      comment: "Percentage of owners with completed KYC verification"
    - name: "avg_target_irr_pct"
      expr: AVG(CAST(target_irr_pct AS DOUBLE))
      comment: "Average target internal rate of return across owners"
    - name: "avg_target_cap_rate_pct"
      expr: AVG(CAST(target_cap_rate_pct AS DOUBLE))
      comment: "Average target capitalization rate across owners"
    - name: "pep_count"
      expr: COUNT(DISTINCT CASE WHEN politically_exposed_flag = TRUE THEN owner_id END)
      comment: "Count of politically exposed persons requiring enhanced due diligence"
    - name: "esg_mandate_count"
      expr: COUNT(DISTINCT CASE WHEN esg_mandate_flag = TRUE THEN owner_id END)
      comment: "Count of owners with ESG investment mandates"
    - name: "tax_exempt_count"
      expr: COUNT(DISTINCT CASE WHEN tax_exempt_flag = TRUE THEN owner_id END)
      comment: "Count of tax-exempt owners"
$$;


CREATE OR REPLACE VIEW `real_estate_ecm`.`_metrics`.`owner_capital_contribution`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Capital contribution metrics tracking equity funding, capital calls, and investor funding performance"
  source: "`real_estate_ecm`.`owner`.`capital_contribution`"
  dimensions:
    - name: "contribution_type"
      expr: contribution_type
      comment: "Type of capital contribution (initial, follow-on, capital call, etc.)"
    - name: "contribution_status"
      expr: contribution_status
      comment: "Current status of the contribution (committed, funded, defaulted, etc.)"
    - name: "equity_tier"
      expr: equity_tier
      comment: "Equity tier classification (Class A, Class B, preferred, common, etc.)"
    - name: "funding_source_type"
      expr: funding_source_type
      comment: "Source type of the funding (wire, check, rollover, etc.)"
    - name: "investor_entity_type"
      expr: investor_entity_type
      comment: "Legal entity type of the investor contributing capital"
    - name: "use_of_proceeds"
      expr: use_of_proceeds
      comment: "Intended use of the contributed capital"
    - name: "capex_category"
      expr: capex_category
      comment: "Capital expenditure category if contribution is for capex"
    - name: "contribution_year"
      expr: YEAR(contribution_date)
      comment: "Year the contribution was made"
    - name: "contribution_quarter"
      expr: DATE_TRUNC('quarter', contribution_date)
      comment: "Quarter the contribution was made"
    - name: "contribution_month"
      expr: DATE_TRUNC('month', contribution_date)
      comment: "Month the contribution was made"
    - name: "is_late_funding"
      expr: is_late_funding
      comment: "Boolean flag indicating if funding was received after due date"
    - name: "kyc_verified"
      expr: kyc_verified
      comment: "Boolean flag indicating if KYC was verified at time of contribution"
  measures:
    - name: "total_contributions"
      expr: COUNT(DISTINCT capital_contribution_id)
      comment: "Total number of capital contribution transactions"
    - name: "total_contribution_amount_usd"
      expr: SUM(CAST(contribution_amount_usd AS DOUBLE))
      comment: "Total capital contributed in USD across all contributions"
    - name: "total_called_amount"
      expr: SUM(CAST(called_amount AS DOUBLE))
      comment: "Total capital called from investors"
    - name: "total_net_contribution_amount"
      expr: SUM(CAST(net_contribution_amount AS DOUBLE))
      comment: "Total net capital contribution after fees and withholdings"
    - name: "total_tax_withholding_amount"
      expr: SUM(CAST(tax_withholding_amount AS DOUBLE))
      comment: "Total tax withholding on capital contributions"
    - name: "total_default_interest_amount"
      expr: SUM(CAST(default_interest_amount AS DOUBLE))
      comment: "Total default interest charged on late contributions"
    - name: "avg_contribution_amount_usd"
      expr: AVG(CAST(contribution_amount_usd AS DOUBLE))
      comment: "Average capital contribution amount in USD"
    - name: "capital_call_fulfillment_rate"
      expr: ROUND(100.0 * SUM(CAST(contribution_amount_usd AS DOUBLE)) / NULLIF(SUM(CAST(called_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of called capital that was actually contributed"
    - name: "late_funding_count"
      expr: COUNT(DISTINCT CASE WHEN is_late_funding = TRUE THEN capital_contribution_id END)
      comment: "Count of contributions received after due date"
    - name: "late_funding_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN is_late_funding = TRUE THEN capital_contribution_id END) / NULLIF(COUNT(DISTINCT capital_contribution_id), 0), 2)
      comment: "Percentage of contributions that were late"
    - name: "avg_preferred_return_rate"
      expr: AVG(CAST(preferred_return_rate AS DOUBLE))
      comment: "Average preferred return rate across contributions"
    - name: "unique_contributing_owners"
      expr: COUNT(DISTINCT owner_id)
      comment: "Count of unique owners who made contributions"
$$;


CREATE OR REPLACE VIEW `real_estate_ecm`.`_metrics`.`owner_distribution`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Owner distribution metrics tracking cash distributions, returns, and disbursement performance to investors"
  source: "`real_estate_ecm`.`owner`.`owner_distribution`"
  dimensions:
    - name: "distribution_type"
      expr: distribution_type
      comment: "Type of distribution (operating cash flow, capital event, preferred return, etc.)"
    - name: "distribution_status"
      expr: distribution_status
      comment: "Current status of the distribution (pending, approved, disbursed, reversed, etc.)"
    - name: "approval_status"
      expr: approval_status
      comment: "Approval workflow status"
    - name: "payment_method"
      expr: payment_method
      comment: "Method of payment (wire, ACH, check, etc.)"
    - name: "frequency"
      expr: frequency
      comment: "Distribution frequency (monthly, quarterly, annual, ad-hoc, etc.)"
    - name: "distribution_year"
      expr: YEAR(distribution_date)
      comment: "Year the distribution was made"
    - name: "distribution_quarter"
      expr: DATE_TRUNC('quarter', distribution_date)
      comment: "Quarter the distribution was made"
    - name: "distribution_month"
      expr: DATE_TRUNC('month', distribution_date)
      comment: "Month the distribution was made"
    - name: "calculation_period_year"
      expr: YEAR(calculation_period_end_date)
      comment: "Year of the calculation period end date"
    - name: "is_foreign_owner"
      expr: is_foreign_owner
      comment: "Boolean flag indicating if owner is foreign (subject to withholding)"
    - name: "bank_account_verification_status"
      expr: bank_account_verification_status
      comment: "Verification status of the disbursement bank account"
  measures:
    - name: "total_distributions"
      expr: COUNT(DISTINCT owner_distribution_id)
      comment: "Total number of distribution transactions"
    - name: "total_gross_distribution_amount"
      expr: SUM(CAST(gross_distribution_amount AS DOUBLE))
      comment: "Total gross distribution amount before withholdings"
    - name: "total_net_disbursement_amount"
      expr: SUM(CAST(net_disbursement_amount AS DOUBLE))
      comment: "Total net cash disbursed to owners after withholdings"
    - name: "total_withholding_tax_amount"
      expr: SUM(CAST(withholding_tax_amount AS DOUBLE))
      comment: "Total withholding tax on distributions"
    - name: "total_distributable_noi_amount"
      expr: SUM(CAST(distributable_noi_amount AS DOUBLE))
      comment: "Total distributable net operating income"
    - name: "avg_gross_distribution_amount"
      expr: AVG(CAST(gross_distribution_amount AS DOUBLE))
      comment: "Average gross distribution amount per transaction"
    - name: "avg_withholding_tax_rate"
      expr: AVG(CAST(withholding_tax_rate AS DOUBLE))
      comment: "Average withholding tax rate applied to distributions"
    - name: "distribution_to_noi_ratio"
      expr: ROUND(100.0 * SUM(CAST(gross_distribution_amount AS DOUBLE)) / NULLIF(SUM(CAST(distributable_noi_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of distributable NOI that was distributed to owners"
    - name: "withholding_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(withholding_tax_amount AS DOUBLE)) / NULLIF(SUM(CAST(gross_distribution_amount AS DOUBLE)), 0), 2)
      comment: "Effective withholding tax rate as percentage of gross distributions"
    - name: "unique_receiving_owners"
      expr: COUNT(DISTINCT owner_id)
      comment: "Count of unique owners who received distributions"
    - name: "foreign_owner_distribution_count"
      expr: COUNT(DISTINCT CASE WHEN is_foreign_owner = TRUE THEN owner_distribution_id END)
      comment: "Count of distributions to foreign owners"
    - name: "approved_distribution_count"
      expr: COUNT(DISTINCT CASE WHEN approval_status = 'Approved' THEN owner_distribution_id END)
      comment: "Count of approved distributions"
    - name: "disbursed_distribution_count"
      expr: COUNT(DISTINCT CASE WHEN distribution_status = 'Disbursed' THEN owner_distribution_id END)
      comment: "Count of distributions that have been disbursed"
$$;


CREATE OR REPLACE VIEW `real_estate_ecm`.`_metrics`.`owner_ownership_interest`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Ownership interest metrics tracking equity stakes, ownership concentration, and investment positions"
  source: "`real_estate_ecm`.`owner`.`owner_ownership_interest`"
  dimensions:
    - name: "interest_type"
      expr: interest_type
      comment: "Type of ownership interest (equity, debt, preferred, common, etc.)"
    - name: "owner_ownership_interest_status"
      expr: owner_ownership_interest_status
      comment: "Current status of the ownership interest"
    - name: "encumbrance_type"
      expr: encumbrance_type
      comment: "Type of encumbrance on the ownership interest if any"
    - name: "vesting_type"
      expr: vesting_type
      comment: "Vesting schedule type for the ownership interest"
    - name: "kyc_status"
      expr: kyc_status
      comment: "KYC verification status for the ownership interest"
    - name: "acquisition_year"
      expr: YEAR(acquisition_date)
      comment: "Year the ownership interest was acquired"
    - name: "acquisition_quarter"
      expr: DATE_TRUNC('quarter', acquisition_date)
      comment: "Quarter the ownership interest was acquired"
    - name: "disposition_year"
      expr: YEAR(disposition_date)
      comment: "Year the ownership interest was disposed"
    - name: "is_beneficial_owner"
      expr: beneficial_owner_flag
      comment: "Boolean flag indicating beneficial ownership"
    - name: "is_controlling_interest"
      expr: controlling_interest_flag
      comment: "Boolean flag indicating controlling interest"
    - name: "is_co_ownership"
      expr: co_ownership_flag
      comment: "Boolean flag indicating co-ownership structure"
    - name: "is_jv_structure"
      expr: jv_structure_flag
      comment: "Boolean flag indicating joint venture structure"
    - name: "has_vesting_schedule"
      expr: vesting_schedule_flag
      comment: "Boolean flag indicating if vesting schedule applies"
  measures:
    - name: "total_ownership_interests"
      expr: COUNT(DISTINCT owner_ownership_interest_id)
      comment: "Total number of ownership interest positions"
    - name: "total_cost_basis_amount"
      expr: SUM(CAST(cost_basis_amount AS DOUBLE))
      comment: "Total cost basis of all ownership interests"
    - name: "total_equity_value_amount"
      expr: SUM(CAST(equity_value_amount AS DOUBLE))
      comment: "Total current equity value of all ownership interests"
    - name: "total_encumbrance_amount"
      expr: SUM(CAST(encumbrance_amount AS DOUBLE))
      comment: "Total encumbrance amount on ownership interests"
    - name: "avg_ownership_percentage"
      expr: AVG(CAST(ownership_percentage AS DOUBLE))
      comment: "Average ownership percentage across all interests"
    - name: "total_ownership_percentage"
      expr: SUM(CAST(ownership_percentage AS DOUBLE))
      comment: "Sum of ownership percentages (useful for concentration analysis)"
    - name: "avg_cost_basis_amount"
      expr: AVG(CAST(cost_basis_amount AS DOUBLE))
      comment: "Average cost basis per ownership interest"
    - name: "avg_equity_value_amount"
      expr: AVG(CAST(equity_value_amount AS DOUBLE))
      comment: "Average equity value per ownership interest"
    - name: "controlling_interest_count"
      expr: COUNT(DISTINCT CASE WHEN controlling_interest_flag = TRUE THEN owner_ownership_interest_id END)
      comment: "Count of ownership interests that represent controlling stakes"
    - name: "beneficial_owner_count"
      expr: COUNT(DISTINCT CASE WHEN beneficial_owner_flag = TRUE THEN owner_ownership_interest_id END)
      comment: "Count of beneficial ownership interests"
    - name: "jv_structure_count"
      expr: COUNT(DISTINCT CASE WHEN jv_structure_flag = TRUE THEN owner_ownership_interest_id END)
      comment: "Count of joint venture ownership structures"
    - name: "encumbered_interest_count"
      expr: COUNT(DISTINCT CASE WHEN encumbrance_amount > 0 THEN owner_ownership_interest_id END)
      comment: "Count of ownership interests with encumbrances"
    - name: "unique_owners_with_interests"
      expr: COUNT(DISTINCT owner_id)
      comment: "Count of unique owners holding ownership interests"
$$;


CREATE OR REPLACE VIEW `real_estate_ecm`.`_metrics`.`owner_ownership_transfer`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Ownership transfer metrics tracking equity transactions, secondary sales, and ownership change events"
  source: "`real_estate_ecm`.`owner`.`ownership_transfer`"
  dimensions:
    - name: "transfer_status"
      expr: transfer_status
      comment: "Current status of the ownership transfer"
    - name: "ownership_structure_type"
      expr: ownership_structure_type
      comment: "Type of ownership structure involved in the transfer"
    - name: "kyc_verification_status"
      expr: kyc_verification_status
      comment: "KYC verification status for the transfer"
    - name: "transfer_year"
      expr: YEAR(transfer_date)
      comment: "Year the ownership transfer occurred"
    - name: "transfer_quarter"
      expr: DATE_TRUNC('quarter', transfer_date)
      comment: "Quarter the ownership transfer occurred"
    - name: "transfer_month"
      expr: DATE_TRUNC('month', transfer_date)
      comment: "Month the ownership transfer occurred"
    - name: "recording_year"
      expr: YEAR(recording_date)
      comment: "Year the transfer was recorded"
    - name: "is_beneficial_owner_disclosed"
      expr: beneficial_owner_disclosed
      comment: "Boolean flag indicating if beneficial owner was disclosed"
    - name: "is_capital_gains"
      expr: capital_gains_flag
      comment: "Boolean flag indicating if transfer triggered capital gains"
  measures:
    - name: "total_ownership_transfers"
      expr: COUNT(DISTINCT ownership_transfer_id)
      comment: "Total number of ownership transfer transactions"
    - name: "total_consideration_amount"
      expr: SUM(CAST(consideration_amount AS DOUBLE))
      comment: "Total consideration paid for ownership transfers"
    - name: "total_allocated_property_value"
      expr: SUM(CAST(allocated_property_value AS DOUBLE))
      comment: "Total allocated property value in ownership transfers"
    - name: "total_transfer_costs_amount"
      expr: SUM(CAST(transfer_costs_amount AS DOUBLE))
      comment: "Total transaction costs for ownership transfers"
    - name: "total_transfer_tax_amount"
      expr: SUM(CAST(transfer_tax_amount AS DOUBLE))
      comment: "Total transfer tax paid on ownership transfers"
    - name: "total_loan_amount"
      expr: SUM(CAST(loan_amount AS DOUBLE))
      comment: "Total loan amount associated with ownership transfers"
    - name: "total_tax_basis_amount"
      expr: SUM(CAST(tax_basis_amount AS DOUBLE))
      comment: "Total tax basis of transferred ownership interests"
    - name: "avg_consideration_amount"
      expr: AVG(CAST(consideration_amount AS DOUBLE))
      comment: "Average consideration per ownership transfer"
    - name: "avg_ltv_ratio"
      expr: AVG(CAST(ltv_ratio AS DOUBLE))
      comment: "Average loan-to-value ratio on ownership transfers"
    - name: "avg_transfer_percentage"
      expr: AVG(CAST(transfer_percentage AS DOUBLE))
      comment: "Average percentage of ownership transferred per transaction"
    - name: "transfer_cost_ratio"
      expr: ROUND(100.0 * SUM(CAST(transfer_costs_amount AS DOUBLE)) / NULLIF(SUM(CAST(consideration_amount AS DOUBLE)), 0), 2)
      comment: "Transfer costs as percentage of consideration"
    - name: "transfer_tax_rate"
      expr: ROUND(100.0 * SUM(CAST(transfer_tax_amount AS DOUBLE)) / NULLIF(SUM(CAST(consideration_amount AS DOUBLE)), 0), 2)
      comment: "Effective transfer tax rate as percentage of consideration"
    - name: "capital_gains_transfer_count"
      expr: COUNT(DISTINCT CASE WHEN capital_gains_flag = TRUE THEN ownership_transfer_id END)
      comment: "Count of transfers that triggered capital gains"
    - name: "unique_transferor_owners"
      expr: COUNT(DISTINCT owner_id)
      comment: "Count of unique owners who transferred ownership"
$$;


CREATE OR REPLACE VIEW `real_estate_ecm`.`_metrics`.`owner_kyc_profile`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KYC and compliance profile metrics tracking investor verification, risk ratings, and regulatory screening status"
  source: "`real_estate_ecm`.`owner`.`kyc_profile`"
  dimensions:
    - name: "kyc_status"
      expr: kyc_status
      comment: "Current KYC verification status"
    - name: "entity_type"
      expr: entity_type
      comment: "Legal entity type of the owner"
    - name: "risk_rating"
      expr: risk_rating
      comment: "Risk rating assigned to the owner (low, medium, high)"
    - name: "aml_screening_status"
      expr: aml_screening_status
      comment: "Anti-money laundering screening status"
    - name: "sanctions_screening_status"
      expr: sanctions_screening_status
      comment: "Sanctions screening status"
    - name: "identity_verification_status"
      expr: identity_verification_status
      comment: "Identity verification status"
    - name: "fatca_status"
      expr: fatca_status
      comment: "FATCA compliance status"
    - name: "crs_status"
      expr: crs_status
      comment: "Common Reporting Standard status"
    - name: "pep_classification"
      expr: pep_classification
      comment: "Politically exposed person classification"
    - name: "accredited_investor_basis"
      expr: accredited_investor_basis
      comment: "Basis for accredited investor status"
    - name: "document_collection_status"
      expr: document_collection_status
      comment: "Status of required document collection"
    - name: "last_review_outcome"
      expr: last_review_outcome
      comment: "Outcome of the most recent KYC review"
    - name: "onboarding_year"
      expr: YEAR(onboarding_date)
      comment: "Year the owner was onboarded"
    - name: "kyc_approval_year"
      expr: YEAR(kyc_approval_date)
      comment: "Year KYC was approved"
    - name: "is_accredited_investor"
      expr: is_accredited_investor
      comment: "Boolean flag indicating accredited investor status"
    - name: "is_pep"
      expr: is_pep
      comment: "Boolean flag indicating politically exposed person status"
    - name: "enhanced_due_diligence_required"
      expr: enhanced_due_diligence_required
      comment: "Boolean flag indicating if enhanced due diligence is required"
    - name: "beneficial_ownership_verified"
      expr: beneficial_ownership_verified
      comment: "Boolean flag indicating if beneficial ownership has been verified"
    - name: "source_of_funds_verified"
      expr: source_of_funds_verified
      comment: "Boolean flag indicating if source of funds has been verified"
    - name: "source_of_wealth_verified"
      expr: source_of_wealth_verified
      comment: "Boolean flag indicating if source of wealth has been verified"
  measures:
    - name: "total_kyc_profiles"
      expr: COUNT(DISTINCT kyc_profile_id)
      comment: "Total number of KYC profiles"
    - name: "verified_kyc_count"
      expr: COUNT(DISTINCT CASE WHEN kyc_status = 'Verified' THEN kyc_profile_id END)
      comment: "Count of verified KYC profiles"
    - name: "kyc_verification_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN kyc_status = 'Verified' THEN kyc_profile_id END) / NULLIF(COUNT(DISTINCT kyc_profile_id), 0), 2)
      comment: "Percentage of KYC profiles that are verified"
    - name: "high_risk_profile_count"
      expr: COUNT(DISTINCT CASE WHEN risk_rating = 'High' THEN kyc_profile_id END)
      comment: "Count of high-risk KYC profiles"
    - name: "pep_profile_count"
      expr: COUNT(DISTINCT CASE WHEN is_pep = TRUE THEN kyc_profile_id END)
      comment: "Count of politically exposed person profiles"
    - name: "edd_required_count"
      expr: COUNT(DISTINCT CASE WHEN enhanced_due_diligence_required = TRUE THEN kyc_profile_id END)
      comment: "Count of profiles requiring enhanced due diligence"
    - name: "aml_cleared_count"
      expr: COUNT(DISTINCT CASE WHEN aml_screening_status = 'Cleared' THEN kyc_profile_id END)
      comment: "Count of profiles cleared by AML screening"
    - name: "sanctions_cleared_count"
      expr: COUNT(DISTINCT CASE WHEN sanctions_screening_status = 'Cleared' THEN kyc_profile_id END)
      comment: "Count of profiles cleared by sanctions screening"
    - name: "beneficial_ownership_verified_count"
      expr: COUNT(DISTINCT CASE WHEN beneficial_ownership_verified = TRUE THEN kyc_profile_id END)
      comment: "Count of profiles with verified beneficial ownership"
    - name: "source_of_funds_verified_count"
      expr: COUNT(DISTINCT CASE WHEN source_of_funds_verified = TRUE THEN kyc_profile_id END)
      comment: "Count of profiles with verified source of funds"
    - name: "source_of_wealth_verified_count"
      expr: COUNT(DISTINCT CASE WHEN source_of_wealth_verified = TRUE THEN kyc_profile_id END)
      comment: "Count of profiles with verified source of wealth"
    - name: "accredited_investor_count"
      expr: COUNT(DISTINCT CASE WHEN is_accredited_investor = TRUE THEN kyc_profile_id END)
      comment: "Count of accredited investor profiles"
    - name: "unique_owners_with_kyc"
      expr: COUNT(DISTINCT owner_id)
      comment: "Count of unique owners with KYC profiles"
$$;


CREATE OR REPLACE VIEW `real_estate_ecm`.`_metrics`.`owner_tax_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tax record metrics tracking tax obligations, withholdings, K-1 allocations, and tax compliance for owners"
  source: "`real_estate_ecm`.`owner`.`tax_record`"
  dimensions:
    - name: "tax_type"
      expr: tax_type
      comment: "Type of tax (income, property, withholding, capital gains, etc.)"
    - name: "filing_status"
      expr: filing_status
      comment: "Tax filing status"
    - name: "tax_exempt_status"
      expr: tax_exempt_status
      comment: "Tax-exempt status classification"
    - name: "appeal_status"
      expr: appeal_status
      comment: "Status of any tax appeal"
    - name: "tin_type"
      expr: tin_type
      comment: "Type of tax identification number (SSN, EIN, ITIN, etc.)"
    - name: "tax_year"
      expr: tax_year
      comment: "Tax year for the record"
    - name: "tax_period_year"
      expr: YEAR(tax_period_end_date)
      comment: "Year of the tax period end date"
    - name: "filing_year"
      expr: YEAR(filing_date)
      comment: "Year the tax filing was submitted"
    - name: "tax_payment_year"
      expr: YEAR(tax_payment_date)
      comment: "Year the tax payment was made"
    - name: "is_foreign_owner"
      expr: is_foreign_owner
      comment: "Boolean flag indicating if owner is foreign (subject to FIRPTA/withholding)"
    - name: "jurisdiction_county_district"
      expr: jurisdiction_county_district
      comment: "County or district jurisdiction for the tax"
  measures:
    - name: "total_tax_records"
      expr: COUNT(DISTINCT tax_record_id)
      comment: "Total number of tax records"
    - name: "total_assessed_tax_amount"
      expr: SUM(CAST(assessed_tax_amount AS DOUBLE))
      comment: "Total assessed tax amount across all records"
    - name: "total_tax_paid_amount"
      expr: SUM(CAST(tax_paid_amount AS DOUBLE))
      comment: "Total tax paid amount"
    - name: "total_interest_amount"
      expr: SUM(CAST(interest_amount AS DOUBLE))
      comment: "Total interest charged on tax obligations"
    - name: "total_penalty_amount"
      expr: SUM(CAST(penalty_amount AS DOUBLE))
      comment: "Total penalties assessed on tax obligations"
    - name: "total_tax_abatement_amount"
      expr: SUM(CAST(tax_abatement_amount AS DOUBLE))
      comment: "Total tax abatement amount received"
    - name: "total_k1_ordinary_income_amount"
      expr: SUM(CAST(k1_ordinary_income_amount AS DOUBLE))
      comment: "Total K-1 ordinary income allocated to owners"
    - name: "total_k1_capital_gain_amount"
      expr: SUM(CAST(k1_capital_gain_amount AS DOUBLE))
      comment: "Total K-1 capital gain allocated to owners"
    - name: "total_k1_depreciation_amount"
      expr: SUM(CAST(k1_depreciation_amount AS DOUBLE))
      comment: "Total K-1 depreciation allocated to owners"
    - name: "avg_tax_rate"
      expr: AVG(CAST(tax_rate AS DOUBLE))
      comment: "Average tax rate across tax records"
    - name: "avg_firpta_withholding_rate"
      expr: AVG(CAST(firpta_withholding_rate AS DOUBLE))
      comment: "Average FIRPTA withholding rate for foreign owners"
    - name: "tax_payment_rate"
      expr: ROUND(100.0 * SUM(CAST(tax_paid_amount AS DOUBLE)) / NULLIF(SUM(CAST(assessed_tax_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of assessed tax that has been paid"
    - name: "foreign_owner_tax_record_count"
      expr: COUNT(DISTINCT CASE WHEN is_foreign_owner = TRUE THEN tax_record_id END)
      comment: "Count of tax records for foreign owners"
    - name: "tax_appeal_count"
      expr: COUNT(DISTINCT CASE WHEN appeal_status IS NOT NULL THEN tax_record_id END)
      comment: "Count of tax records with appeals filed"
    - name: "unique_owners_with_tax_records"
      expr: COUNT(DISTINCT owner_id)
      comment: "Count of unique owners with tax records"
$$;
