-- Metric views for domain: valuation | Business: Real Estate | Version: 1 | Generated on: 2026-05-02 01:37:58

CREATE OR REPLACE VIEW `real_estate_ecm`.`_metrics`.`valuation_appraisal`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core appraisal engagement metrics tracking valuation activity, turnaround, fees, and concluded values across property types and methodologies"
  source: "`real_estate_ecm`.`valuation`.`appraisal`"
  dimensions:
    - name: "appraisal_status"
      expr: appraisal_status
      comment: "Current status of the appraisal engagement (e.g., ordered, in-progress, completed, reviewed)"
    - name: "appraisal_type"
      expr: appraisal_type
      comment: "Type of appraisal engagement (e.g., full appraisal, restricted appraisal, desktop review)"
    - name: "methodology"
      expr: methodology
      comment: "Primary valuation methodology applied (e.g., income approach, sales comparison, cost approach)"
    - name: "purpose"
      expr: purpose
      comment: "Business purpose of the appraisal (e.g., acquisition, financing, portfolio valuation, compliance)"
    - name: "value_type"
      expr: value_type
      comment: "Type of value concluded (e.g., market value, fair value, investment value)"
    - name: "report_type"
      expr: report_type
      comment: "Format and detail level of the appraisal report delivered"
    - name: "uspap_compliant"
      expr: uspap_compliant
      comment: "Whether the appraisal meets USPAP (Uniform Standards of Professional Appraisal Practice) standards"
    - name: "ivsc_compliant"
      expr: ivsc_compliant
      comment: "Whether the appraisal meets IVSC (International Valuation Standards Council) standards"
    - name: "engagement_year"
      expr: YEAR(engagement_date)
      comment: "Year the appraisal engagement was initiated"
    - name: "engagement_quarter"
      expr: CONCAT('Q', QUARTER(engagement_date), '-', YEAR(engagement_date))
      comment: "Quarter and year of appraisal engagement"
    - name: "value_date_year"
      expr: YEAR(value_date)
      comment: "Year of the effective valuation date"
  measures:
    - name: "total_appraisals"
      expr: COUNT(1)
      comment: "Total number of appraisal engagements"
    - name: "total_concluded_market_value"
      expr: SUM(CAST(concluded_market_value AS DOUBLE))
      comment: "Sum of all concluded market values across appraisals"
    - name: "avg_concluded_market_value"
      expr: AVG(CAST(concluded_market_value AS DOUBLE))
      comment: "Average concluded market value per appraisal"
    - name: "total_engagement_fees"
      expr: SUM(CAST(engagement_fee AS DOUBLE))
      comment: "Total fees collected for appraisal engagements"
    - name: "avg_engagement_fee"
      expr: AVG(CAST(engagement_fee AS DOUBLE))
      comment: "Average fee per appraisal engagement"
    - name: "avg_cap_rate"
      expr: AVG(CAST(cap_rate AS DOUBLE))
      comment: "Average capitalization rate applied across appraisals"
    - name: "avg_discount_rate"
      expr: AVG(CAST(discount_rate AS DOUBLE))
      comment: "Average discount rate used in DCF valuations"
    - name: "avg_irr"
      expr: AVG(CAST(irr AS DOUBLE))
      comment: "Average internal rate of return across appraisals"
    - name: "avg_noi"
      expr: AVG(CAST(noi AS DOUBLE))
      comment: "Average net operating income used in valuations"
    - name: "fee_to_value_ratio"
      expr: ROUND(100.0 * SUM(CAST(engagement_fee AS DOUBLE)) / NULLIF(SUM(CAST(concluded_market_value AS DOUBLE)), 0), 4)
      comment: "Engagement fees as a percentage of total concluded market value (basis points)"
    - name: "distinct_appraisers"
      expr: COUNT(DISTINCT appraiser_id)
      comment: "Number of unique appraisers engaged"
    - name: "distinct_assets_appraised"
      expr: COUNT(DISTINCT asset_id)
      comment: "Number of unique assets appraised"
$$;


CREATE OR REPLACE VIEW `real_estate_ecm`.`_metrics`.`valuation_appraisal_review`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Appraisal quality control metrics tracking review outcomes, deficiencies, value variances, and compliance with professional standards"
  source: "`real_estate_ecm`.`valuation`.`appraisal_review`"
  dimensions:
    - name: "review_status"
      expr: review_status
      comment: "Current status of the appraisal review process"
    - name: "review_type"
      expr: review_type
      comment: "Type of review conducted (e.g., desk review, field review, compliance review)"
    - name: "review_conclusion"
      expr: review_conclusion
      comment: "Overall conclusion of the review (e.g., accepted, accepted with conditions, rejected)"
    - name: "final_disposition"
      expr: final_disposition
      comment: "Final disposition of the reviewed appraisal"
    - name: "uspap_standard3_compliant"
      expr: uspap_standard3_compliant
      comment: "Whether the review meets USPAP Standard 3 (Appraisal Review) requirements"
    - name: "ivsc_methodology_compliant"
      expr: ivsc_methodology_compliant
      comment: "Whether the original appraisal methodology complies with IVSC standards"
    - name: "comparable_adequacy_flag"
      expr: comparable_adequacy_flag
      comment: "Whether the comparables used in the original appraisal were deemed adequate"
    - name: "market_conditions_adequate"
      expr: market_conditions_adequate
      comment: "Whether market conditions analysis in the original appraisal was adequate"
    - name: "is_rush_order"
      expr: is_rush_order
      comment: "Whether the review was expedited"
    - name: "review_year"
      expr: YEAR(review_date)
      comment: "Year the review was completed"
    - name: "review_quarter"
      expr: CONCAT('Q', QUARTER(review_date), '-', YEAR(review_date))
      comment: "Quarter and year of review completion"
  measures:
    - name: "total_reviews"
      expr: COUNT(1)
      comment: "Total number of appraisal reviews conducted"
    - name: "total_review_fees"
      expr: SUM(CAST(review_fee AS DOUBLE))
      comment: "Total fees collected for appraisal review services"
    - name: "avg_review_fee"
      expr: AVG(CAST(review_fee AS DOUBLE))
      comment: "Average fee per appraisal review"
    - name: "avg_value_variance_pct"
      expr: AVG(CAST(value_variance_pct AS DOUBLE))
      comment: "Average percentage variance between reviewer opinion and original appraised value"
    - name: "total_original_appraised_value"
      expr: SUM(CAST(original_appraised_value AS DOUBLE))
      comment: "Sum of all original appraised values under review"
    - name: "total_reviewer_value_opinion"
      expr: SUM(CAST(reviewer_value_opinion AS DOUBLE))
      comment: "Sum of all reviewer value opinions"
    - name: "avg_deficiency_count"
      expr: AVG(CAST(deficiency_count AS DOUBLE))
      comment: "Average number of deficiencies identified per review"
    - name: "reviews_with_deficiencies"
      expr: COUNT(CASE WHEN CAST(deficiency_count AS INT) > 0 THEN 1 END)
      comment: "Number of reviews that identified one or more deficiencies"
    - name: "deficiency_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN CAST(deficiency_count AS INT) > 0 THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of reviews that identified deficiencies"
    - name: "distinct_appraisals_reviewed"
      expr: COUNT(DISTINCT appraisal_id)
      comment: "Number of unique appraisals reviewed"
    - name: "distinct_reviewers"
      expr: COUNT(DISTINCT appraiser_id)
      comment: "Number of unique reviewers conducting reviews"
$$;


CREATE OR REPLACE VIEW `real_estate_ecm`.`_metrics`.`valuation_appraiser`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Appraiser panel performance and compliance metrics tracking credentials, quality ratings, engagement activity, and professional standards adherence"
  source: "`real_estate_ecm`.`valuation`.`appraiser`"
  dimensions:
    - name: "appraiser_type"
      expr: appraiser_type
      comment: "Type or classification of appraiser (e.g., staff, panel, independent)"
    - name: "engagement_status"
      expr: engagement_status
      comment: "Current engagement status with the organization (e.g., active, inactive, suspended)"
    - name: "panel_tier"
      expr: panel_tier
      comment: "Tier or ranking within the appraiser panel based on quality and performance"
    - name: "quality_rating"
      expr: quality_rating
      comment: "Quality rating assigned to the appraiser"
    - name: "specialization"
      expr: specialization
      comment: "Primary property type or valuation specialization"
    - name: "license_state"
      expr: license_state
      comment: "State where the appraiser holds their primary license"
    - name: "license_type"
      expr: license_type
      comment: "Type of appraisal license held"
    - name: "uspap_compliant_flag"
      expr: uspap_compliant_flag
      comment: "Whether the appraiser is USPAP compliant"
    - name: "ivsc_member_flag"
      expr: ivsc_member_flag
      comment: "Whether the appraiser is an IVSC member"
    - name: "independence_confirmed_flag"
      expr: independence_confirmed_flag
      comment: "Whether appraiser independence has been confirmed"
    - name: "ai_designation"
      expr: ai_designation
      comment: "Appraisal Institute designation held (e.g., MAI, SRA)"
  measures:
    - name: "total_appraisers"
      expr: COUNT(1)
      comment: "Total number of appraisers in the panel"
    - name: "active_appraisers"
      expr: COUNT(CASE WHEN engagement_status = 'active' THEN 1 END)
      comment: "Number of appraisers with active engagement status"
    - name: "avg_turnaround_days"
      expr: AVG(CAST(average_turnaround_days AS DOUBLE))
      comment: "Average turnaround time in days across all appraisers"
    - name: "avg_preferred_fee"
      expr: AVG(CAST(preferred_fee_usd AS DOUBLE))
      comment: "Average preferred fee across appraisers"
    - name: "avg_eo_coverage_amount"
      expr: AVG(CAST(eo_coverage_amount AS DOUBLE))
      comment: "Average errors and omissions insurance coverage amount"
    - name: "avg_total_engagements"
      expr: AVG(CAST(total_engagements AS DOUBLE))
      comment: "Average number of total engagements per appraiser"
    - name: "avg_continuing_education_hours"
      expr: AVG(CAST(continuing_education_hours AS DOUBLE))
      comment: "Average continuing education hours completed"
    - name: "appraisers_with_expired_eo"
      expr: COUNT(CASE WHEN eo_expiry_date < CURRENT_DATE THEN 1 END)
      comment: "Number of appraisers with expired errors and omissions insurance"
    - name: "appraisers_with_expired_license"
      expr: COUNT(CASE WHEN license_expiry_date < CURRENT_DATE THEN 1 END)
      comment: "Number of appraisers with expired licenses"
    - name: "uspap_compliance_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN uspap_compliant_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of appraisers who are USPAP compliant"
    - name: "ivsc_membership_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN ivsc_member_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of appraisers who are IVSC members"
$$;


CREATE OR REPLACE VIEW `real_estate_ecm`.`_metrics`.`valuation_dcf_model`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Investment underwriting and DCF analysis metrics tracking returns, leverage, hold periods, and valuation assumptions for acquisition and portfolio decisions"
  source: "`real_estate_ecm`.`valuation`.`dcf_model`"
  dimensions:
    - name: "model_status"
      expr: model_status
      comment: "Current status of the DCF model (e.g., draft, approved, archived)"
    - name: "model_purpose"
      expr: model_purpose
      comment: "Business purpose of the DCF model (e.g., acquisition, refinancing, portfolio valuation)"
    - name: "methodology_standard"
      expr: methodology_standard
      comment: "Valuation methodology standard applied (e.g., IVSC, RICS, internal)"
    - name: "is_levered"
      expr: is_levered
      comment: "Whether the DCF model includes debt financing (levered) or is equity-only (unlevered)"
    - name: "hold_period_years"
      expr: hold_period_years
      comment: "Investment hold period in years"
    - name: "valuation_year"
      expr: YEAR(valuation_date)
      comment: "Year of the valuation date"
    - name: "approval_year"
      expr: YEAR(approval_date)
      comment: "Year the DCF model was approved"
  measures:
    - name: "total_dcf_models"
      expr: COUNT(1)
      comment: "Total number of DCF models created"
    - name: "total_acquisition_price"
      expr: SUM(CAST(acquisition_price AS DOUBLE))
      comment: "Sum of all acquisition prices modeled"
    - name: "avg_acquisition_price"
      expr: AVG(CAST(acquisition_price AS DOUBLE))
      comment: "Average acquisition price per DCF model"
    - name: "total_equity_investment"
      expr: SUM(CAST(equity_investment AS DOUBLE))
      comment: "Total equity investment across all DCF models"
    - name: "total_debt_amount"
      expr: SUM(CAST(debt_amount AS DOUBLE))
      comment: "Total debt financing across all DCF models"
    - name: "avg_levered_irr"
      expr: AVG(CAST(levered_irr AS DOUBLE))
      comment: "Average levered internal rate of return across models"
    - name: "avg_unlevered_irr"
      expr: AVG(CAST(unlevered_irr AS DOUBLE))
      comment: "Average unlevered internal rate of return across models"
    - name: "avg_equity_multiple"
      expr: AVG(CAST(equity_multiple AS DOUBLE))
      comment: "Average equity multiple (total return / equity invested) across models"
    - name: "avg_ltv_ratio"
      expr: AVG(CAST(ltv_ratio AS DOUBLE))
      comment: "Average loan-to-value ratio across levered models"
    - name: "avg_going_in_cap_rate"
      expr: AVG(CAST(going_in_cap_rate AS DOUBLE))
      comment: "Average going-in capitalization rate at acquisition"
    - name: "avg_terminal_cap_rate"
      expr: AVG(CAST(terminal_cap_rate AS DOUBLE))
      comment: "Average terminal capitalization rate at exit"
    - name: "avg_discount_rate"
      expr: AVG(CAST(discount_rate AS DOUBLE))
      comment: "Average discount rate used in NPV calculations"
    - name: "avg_stabilized_noi"
      expr: AVG(CAST(stabilized_noi AS DOUBLE))
      comment: "Average stabilized net operating income"
    - name: "total_reversion_value"
      expr: SUM(CAST(reversion_value AS DOUBLE))
      comment: "Total reversion (exit) value across all models"
    - name: "avg_dscr"
      expr: AVG(CAST(avg_dscr AS DOUBLE))
      comment: "Average debt service coverage ratio across models"
    - name: "distinct_assets_modeled"
      expr: COUNT(DISTINCT asset_id)
      comment: "Number of unique assets with DCF models"
$$;


CREATE OR REPLACE VIEW `real_estate_ecm`.`_metrics`.`valuation_nav_calculation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Fund-level net asset value metrics tracking portfolio valuation, leverage, returns, and fair value hierarchy for investor reporting and regulatory compliance"
  source: "`real_estate_ecm`.`valuation`.`nav_calculation`"
  dimensions:
    - name: "calculation_status"
      expr: calculation_status
      comment: "Current status of the NAV calculation (e.g., draft, approved, published)"
    - name: "valuation_methodology"
      expr: valuation_methodology
      comment: "Primary valuation methodology used for NAV calculation"
    - name: "fair_value_hierarchy_level"
      expr: fair_value_hierarchy_level
      comment: "ASC 820 fair value hierarchy level (Level 1, 2, or 3)"
    - name: "is_audited"
      expr: is_audited
      comment: "Whether the NAV calculation has been audited"
    - name: "is_published"
      expr: is_published
      comment: "Whether the NAV has been published to investors"
    - name: "reporting_year"
      expr: reporting_year
      comment: "Reporting year for the NAV calculation"
    - name: "reporting_period"
      expr: reporting_period
      comment: "Reporting period (e.g., Q1, Q2, annual)"
    - name: "calculation_year"
      expr: YEAR(calculation_date)
      comment: "Year the NAV calculation was performed"
    - name: "calculation_quarter"
      expr: CONCAT('Q', QUARTER(calculation_date), '-', YEAR(calculation_date))
      comment: "Quarter and year of NAV calculation"
  measures:
    - name: "total_nav_calculations"
      expr: COUNT(1)
      comment: "Total number of NAV calculations performed"
    - name: "total_net_asset_value"
      expr: SUM(CAST(net_asset_value AS DOUBLE))
      comment: "Sum of net asset values across all calculations"
    - name: "avg_net_asset_value"
      expr: AVG(CAST(net_asset_value AS DOUBLE))
      comment: "Average net asset value per calculation"
    - name: "total_gross_asset_value"
      expr: SUM(CAST(gross_asset_value AS DOUBLE))
      comment: "Sum of gross asset values (before liabilities)"
    - name: "total_aum"
      expr: SUM(CAST(aum AS DOUBLE))
      comment: "Total assets under management"
    - name: "avg_nav_per_unit"
      expr: AVG(CAST(nav_per_unit AS DOUBLE))
      comment: "Average NAV per unit across calculations"
    - name: "total_debt_outstanding"
      expr: SUM(CAST(total_debt_outstanding AS DOUBLE))
      comment: "Total debt outstanding across all NAV calculations"
    - name: "avg_ltv_ratio"
      expr: AVG(CAST(ltv_ratio AS DOUBLE))
      comment: "Average loan-to-value ratio at portfolio level"
    - name: "avg_weighted_cap_rate"
      expr: AVG(CAST(weighted_avg_cap_rate AS DOUBLE))
      comment: "Average weighted capitalization rate across portfolio"
    - name: "total_noi"
      expr: SUM(CAST(noi_total AS DOUBLE))
      comment: "Total net operating income across portfolio"
    - name: "total_ffo"
      expr: SUM(CAST(ffo AS DOUBLE))
      comment: "Total funds from operations"
    - name: "total_affo"
      expr: SUM(CAST(affo AS DOUBLE))
      comment: "Total adjusted funds from operations"
    - name: "avg_appraisal_coverage_pct"
      expr: AVG(CAST(appraisal_coverage_pct AS DOUBLE))
      comment: "Average percentage of portfolio covered by third-party appraisals"
    - name: "avg_nav_change"
      expr: AVG(CAST(nav_change AS DOUBLE))
      comment: "Average change in NAV from prior period"
    - name: "avg_discount_rate"
      expr: AVG(CAST(discount_rate AS DOUBLE))
      comment: "Average discount rate used in portfolio valuation"
    - name: "distinct_funds"
      expr: COUNT(DISTINCT fund_id)
      comment: "Number of unique funds with NAV calculations"
    - name: "distinct_portfolios"
      expr: COUNT(DISTINCT portfolio_id)
      comment: "Number of unique portfolios valued"
$$;


CREATE OR REPLACE VIEW `real_estate_ecm`.`_metrics`.`valuation_tax_appeal`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Property tax appeal performance metrics tracking outcomes, savings, costs, and ROI for tax mitigation strategy and budget planning"
  source: "`real_estate_ecm`.`valuation`.`tax_appeal`"
  dimensions:
    - name: "appeal_status"
      expr: appeal_status
      comment: "Current status of the tax appeal (e.g., filed, pending hearing, settled, closed)"
    - name: "appeal_type"
      expr: appeal_type
      comment: "Type of tax appeal (e.g., informal, formal, litigation)"
    - name: "appeal_outcome"
      expr: appeal_outcome
      comment: "Final outcome of the appeal (e.g., reduction granted, no change, withdrawn)"
    - name: "appeal_grounds"
      expr: appeal_grounds
      comment: "Primary grounds for the appeal (e.g., overvaluation, unequal assessment, incorrect classification)"
    - name: "valuation_methodology"
      expr: valuation_methodology
      comment: "Valuation methodology used to support the appeal"
    - name: "is_multi_year_appeal"
      expr: is_multi_year_appeal
      comment: "Whether the appeal covers multiple tax years"
    - name: "tax_year"
      expr: tax_year
      comment: "Tax year being appealed"
    - name: "filing_year"
      expr: YEAR(filing_date)
      comment: "Year the appeal was filed"
    - name: "resolution_year"
      expr: YEAR(resolution_date)
      comment: "Year the appeal was resolved"
  measures:
    - name: "total_appeals"
      expr: COUNT(1)
      comment: "Total number of tax appeals filed"
    - name: "total_original_assessed_value"
      expr: SUM(CAST(original_assessed_value AS DOUBLE))
      comment: "Sum of original assessed values before appeal"
    - name: "total_appealed_value"
      expr: SUM(CAST(appealed_value AS DOUBLE))
      comment: "Sum of values argued for in appeals"
    - name: "total_settled_value"
      expr: SUM(CAST(settled_value AS DOUBLE))
      comment: "Sum of final settled assessed values"
    - name: "total_estimated_tax_savings"
      expr: SUM(CAST(estimated_tax_savings AS DOUBLE))
      comment: "Total estimated annual tax savings from appeals"
    - name: "total_actual_tax_savings"
      expr: SUM(CAST(actual_tax_savings AS DOUBLE))
      comment: "Total actual annual tax savings realized"
    - name: "total_appraisal_fees"
      expr: SUM(CAST(appraisal_fee AS DOUBLE))
      comment: "Total appraisal fees incurred for appeals"
    - name: "total_legal_fees"
      expr: SUM(CAST(legal_fees_incurred AS DOUBLE))
      comment: "Total legal fees incurred for appeals"
    - name: "total_refund_amount"
      expr: SUM(CAST(refund_amount AS DOUBLE))
      comment: "Total refunds received from successful appeals"
    - name: "avg_opinion_of_value"
      expr: AVG(CAST(opinion_of_value AS DOUBLE))
      comment: "Average appraiser opinion of value supporting appeals"
    - name: "avg_cap_rate_used"
      expr: AVG(CAST(cap_rate_used AS DOUBLE))
      comment: "Average capitalization rate used in appeal valuations"
    - name: "avg_noi_used"
      expr: AVG(CAST(noi_used AS DOUBLE))
      comment: "Average net operating income used in appeal valuations"
    - name: "successful_appeals"
      expr: COUNT(CASE WHEN appeal_outcome IN ('reduction granted', 'settled') THEN 1 END)
      comment: "Number of appeals that resulted in assessment reduction"
    - name: "appeal_success_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN appeal_outcome IN ('reduction granted', 'settled') THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of appeals that achieved assessment reduction"
    - name: "distinct_assets_appealed"
      expr: COUNT(DISTINCT asset_id)
      comment: "Number of unique assets with tax appeals"
    - name: "distinct_appraisers_engaged"
      expr: COUNT(DISTINCT appraiser_id)
      comment: "Number of unique appraisers engaged for appeals"
$$;


CREATE OR REPLACE VIEW `real_estate_ecm`.`_metrics`.`valuation_value_history`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Longitudinal valuation tracking metrics for portfolio performance monitoring, fair value reporting, and investment return analysis across time"
  source: "`real_estate_ecm`.`valuation`.`value_history`"
  dimensions:
    - name: "valuation_status"
      expr: valuation_status
      comment: "Current status of the valuation record"
    - name: "valuation_method"
      expr: valuation_method
      comment: "Valuation method applied (e.g., appraisal, DCF, BPO, tax assessment)"
    - name: "valuation_source"
      expr: valuation_source
      comment: "Source of the valuation (e.g., third-party appraisal, internal model, broker opinion)"
    - name: "value_type"
      expr: value_type
      comment: "Type of value recorded (e.g., market value, fair value, investment value)"
    - name: "intended_use"
      expr: intended_use
      comment: "Intended use of the valuation (e.g., financial reporting, acquisition, financing)"
    - name: "asc820_level"
      expr: asc820_level
      comment: "ASC 820 fair value hierarchy level (Level 1, 2, or 3)"
    - name: "confidence_level"
      expr: confidence_level
      comment: "Confidence level in the valuation (e.g., high, medium, low)"
    - name: "property_condition"
      expr: property_condition
      comment: "Physical condition of the property at valuation date"
    - name: "valuation_year"
      expr: YEAR(valuation_date)
      comment: "Year of the valuation date"
    - name: "valuation_quarter"
      expr: CONCAT('Q', QUARTER(valuation_date), '-', YEAR(valuation_date))
      comment: "Quarter and year of valuation"
  measures:
    - name: "total_valuations"
      expr: COUNT(1)
      comment: "Total number of valuation records"
    - name: "total_concluded_value"
      expr: SUM(CAST(concluded_value AS DOUBLE))
      comment: "Sum of all concluded values"
    - name: "avg_concluded_value"
      expr: AVG(CAST(concluded_value AS DOUBLE))
      comment: "Average concluded value per valuation"
    - name: "total_gav"
      expr: SUM(CAST(gav AS DOUBLE))
      comment: "Total gross asset value across valuations"
    - name: "total_nav_contribution"
      expr: SUM(CAST(nav_contribution AS DOUBLE))
      comment: "Total contribution to net asset value"
    - name: "avg_value_psf"
      expr: AVG(CAST(value_psf AS DOUBLE))
      comment: "Average value per square foot"
    - name: "avg_cap_rate"
      expr: AVG(CAST(cap_rate AS DOUBLE))
      comment: "Average capitalization rate across valuations"
    - name: "avg_discount_rate"
      expr: AVG(CAST(discount_rate AS DOUBLE))
      comment: "Average discount rate used in valuations"
    - name: "avg_irr"
      expr: AVG(CAST(irr AS DOUBLE))
      comment: "Average internal rate of return"
    - name: "avg_noi"
      expr: AVG(CAST(noi AS DOUBLE))
      comment: "Average net operating income"
    - name: "avg_occupancy_rate"
      expr: AVG(CAST(occupancy_rate AS DOUBLE))
      comment: "Average occupancy rate at valuation date"
    - name: "avg_value_change_pct"
      expr: AVG(CAST(value_change_pct AS DOUBLE))
      comment: "Average percentage change in value from prior valuation"
    - name: "total_prior_concluded_value"
      expr: SUM(CAST(prior_concluded_value AS DOUBLE))
      comment: "Sum of prior concluded values for comparison"
    - name: "valuations_with_increase"
      expr: COUNT(CASE WHEN CAST(value_change_pct AS DOUBLE) > 0 THEN 1 END)
      comment: "Number of valuations showing value increase from prior period"
    - name: "valuations_with_decrease"
      expr: COUNT(CASE WHEN CAST(value_change_pct AS DOUBLE) < 0 THEN 1 END)
      comment: "Number of valuations showing value decrease from prior period"
    - name: "distinct_assets_valued"
      expr: COUNT(DISTINCT asset_id)
      comment: "Number of unique assets with valuation history"
    - name: "distinct_appraisers"
      expr: COUNT(DISTINCT appraiser_id)
      comment: "Number of unique appraisers contributing valuations"
$$;
