-- Metric views for domain: customer | Business: Semiconductors | Version: 2 | Generated on: 2026-07-10 14:15:10

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`customer_account`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core customer account metrics tracking account base, revenue tiers, credit risk, and account health for strategic customer management and risk assessment."
  source: "`vibe_semiconductors_v1`.`customer`.`account`"
  dimensions:
    - name: "account_status"
      expr: account_status
      comment: "Current operational status of the customer account (active, inactive, suspended, etc.)"
    - name: "account_type"
      expr: account_type
      comment: "Classification of account type (direct, distributor, OEM, etc.)"
    - name: "revenue_tier"
      expr: revenue_tier
      comment: "Strategic revenue tier classification for account segmentation and prioritization"
    - name: "credit_rating"
      expr: credit_rating
      comment: "Credit rating assigned to the account for risk management"
    - name: "geographic_region"
      expr: geographic_region
      comment: "Geographic region where the account operates for regional performance analysis"
    - name: "sales_region"
      expr: sales_region
      comment: "Sales territory or region assignment for sales performance tracking"
    - name: "industry_vertical"
      expr: industry_vertical
      comment: "Industry vertical or sector of the customer for market segment analysis"
    - name: "strategic_classification"
      expr: strategic_classification
      comment: "Strategic importance classification (key account, strategic partner, standard, etc.)"
    - name: "compliance_status"
      expr: compliance_status
      comment: "Compliance verification status for regulatory and export control requirements"
    - name: "creation_year"
      expr: YEAR(creation_date)
      comment: "Year the account was created for cohort and vintage analysis"
    - name: "creation_quarter"
      expr: CONCAT(CAST(YEAR(creation_date) AS STRING), '-Q', CAST(QUARTER(creation_date) AS STRING))
      comment: "Quarter the account was created for cohort tracking"
  measures:
    - name: "total_accounts"
      expr: COUNT(DISTINCT account_id)
      comment: "Total number of unique customer accounts for account base tracking"
    - name: "avg_risk_score"
      expr: AVG(CAST(risk_score AS DOUBLE))
      comment: "Average risk score across accounts for portfolio risk assessment"
    - name: "high_risk_accounts"
      expr: COUNT(DISTINCT CASE WHEN CAST(risk_score AS DOUBLE) > 70 THEN account_id END)
      comment: "Count of accounts with high risk scores (>70) requiring enhanced monitoring"
    - name: "tax_exempt_accounts"
      expr: COUNT(DISTINCT CASE WHEN tax_exempt_flag = TRUE THEN account_id END)
      comment: "Count of tax-exempt accounts for tax reporting and compliance"
    - name: "active_accounts"
      expr: COUNT(DISTINCT CASE WHEN account_status = 'Active' THEN account_id END)
      comment: "Count of currently active accounts for active customer base measurement"
    - name: "accounts_with_recent_activity"
      expr: COUNT(DISTINCT CASE WHEN DATEDIFF(CURRENT_DATE(), last_activity_date) <= 90 THEN account_id END)
      comment: "Accounts with activity in last 90 days for engagement tracking"
    - name: "dormant_accounts"
      expr: COUNT(DISTINCT CASE WHEN DATEDIFF(CURRENT_DATE(), last_activity_date) > 180 THEN account_id END)
      comment: "Accounts with no activity in 180+ days for reactivation campaigns"
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`customer_design_win`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic design win metrics tracking pipeline value, conversion, and revenue potential from customer design engagements - critical for semiconductor business development and revenue forecasting."
  source: "`vibe_semiconductors_v1`.`customer`.`design_win`"
  dimensions:
    - name: "stage"
      expr: stage
      comment: "Current stage of the design win (prospect, engaged, won, production, etc.) for pipeline management"
    - name: "target_application"
      expr: target_application
      comment: "Target application or use case for the design (automotive, mobile, IoT, etc.)"
    - name: "process_node"
      expr: process_node
      comment: "Semiconductor process node technology (7nm, 5nm, etc.) for technology trend analysis"
    - name: "package_type"
      expr: package_type
      comment: "Package type specification for product mix analysis"
    - name: "platform_generation"
      expr: platform_generation
      comment: "Platform or product generation for roadmap alignment tracking"
    - name: "competitive_displacement"
      expr: CASE WHEN competitive_displacement_flag = TRUE THEN 'Yes' ELSE 'No' END
      comment: "Whether this design win displaced a competitor for competitive intelligence"
    - name: "nre_required"
      expr: CASE WHEN nre_required_flag = TRUE THEN 'Yes' ELSE 'No' END
      comment: "Whether non-recurring engineering investment is required"
    - name: "registration_year"
      expr: YEAR(registration_timestamp)
      comment: "Year the design win was registered for vintage analysis"
    - name: "registration_quarter"
      expr: CONCAT(CAST(YEAR(registration_timestamp) AS STRING), '-Q', CAST(QUARTER(registration_timestamp) AS STRING))
      comment: "Quarter the design win was registered for pipeline trending"
    - name: "production_ramp_year"
      expr: YEAR(production_ramp_date)
      comment: "Year production is expected to ramp for revenue timing forecasts"
  measures:
    - name: "total_design_wins"
      expr: COUNT(DISTINCT design_win_id)
      comment: "Total number of design wins for pipeline volume tracking"
    - name: "total_estimated_annual_revenue"
      expr: SUM(CAST(estimated_annual_revenue_usd AS DOUBLE))
      comment: "Total estimated annual revenue across all design wins for revenue pipeline valuation"
    - name: "avg_estimated_annual_revenue"
      expr: AVG(CAST(estimated_annual_revenue_usd AS DOUBLE))
      comment: "Average estimated annual revenue per design win for deal size benchmarking"
    - name: "total_estimated_unit_volume"
      expr: SUM(CAST(estimated_annual_unit_volume AS DOUBLE))
      comment: "Total estimated annual unit volume across design wins for capacity planning"
    - name: "avg_estimated_unit_volume"
      expr: AVG(CAST(estimated_annual_unit_volume AS DOUBLE))
      comment: "Average estimated annual unit volume per design win for volume profile analysis"
    - name: "total_nre_investment"
      expr: SUM(CAST(nre_amount_usd AS DOUBLE))
      comment: "Total non-recurring engineering investment required across design wins for R&D budgeting"
    - name: "competitive_displacement_wins"
      expr: COUNT(DISTINCT CASE WHEN competitive_displacement_flag = TRUE THEN design_win_id END)
      comment: "Count of design wins that displaced competitors for competitive performance tracking"
    - name: "competitive_displacement_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN competitive_displacement_flag = TRUE THEN design_win_id END) / NULLIF(COUNT(DISTINCT design_win_id), 0), 2)
      comment: "Percentage of design wins that displaced competitors for competitive effectiveness measurement"
    - name: "nre_required_wins"
      expr: COUNT(DISTINCT CASE WHEN nre_required_flag = TRUE THEN design_win_id END)
      comment: "Count of design wins requiring NRE investment for investment planning"
    - name: "avg_nre_per_win"
      expr: AVG(CAST(nre_amount_usd AS DOUBLE))
      comment: "Average NRE investment per design win for cost benchmarking"
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`customer_credit_profile`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Customer credit and financial risk metrics for credit management, collections optimization, and financial exposure monitoring - essential for working capital management and bad debt prevention."
  source: "`vibe_semiconductors_v1`.`customer`.`credit_profile`"
  dimensions:
    - name: "credit_profile_status"
      expr: credit_profile_status
      comment: "Current status of the credit profile (active, under review, suspended, etc.)"
    - name: "credit_rating_internal"
      expr: credit_rating_internal
      comment: "Internal credit rating assigned by credit team for risk segmentation"
    - name: "credit_rating_external"
      expr: credit_rating_external
      comment: "External credit rating from rating agencies for third-party risk validation"
    - name: "risk_category"
      expr: risk_category
      comment: "Risk category classification (low, medium, high, critical) for risk-based decisioning"
    - name: "credit_hold_status"
      expr: CASE WHEN credit_hold = TRUE THEN 'On Hold' ELSE 'Active' END
      comment: "Whether account is on credit hold for collections and order management"
    - name: "preferred_customer_status"
      expr: CASE WHEN is_preferred_customer = TRUE THEN 'Preferred' ELSE 'Standard' END
      comment: "Preferred customer designation for special terms and priority handling"
    - name: "payment_terms"
      expr: payment_terms
      comment: "Payment terms granted to the customer for DSO and cash flow analysis"
    - name: "credit_limit_currency"
      expr: credit_limit_currency
      comment: "Currency of the credit limit for multi-currency exposure management"
    - name: "credit_review_year"
      expr: YEAR(credit_review_date)
      comment: "Year of last credit review for review cycle tracking"
  measures:
    - name: "total_credit_profiles"
      expr: COUNT(DISTINCT credit_profile_id)
      comment: "Total number of credit profiles for credit portfolio size tracking"
    - name: "total_credit_limit"
      expr: SUM(CAST(credit_limit_amount AS DOUBLE))
      comment: "Total credit limit extended across all customers for credit exposure measurement"
    - name: "avg_credit_limit"
      expr: AVG(CAST(credit_limit_amount AS DOUBLE))
      comment: "Average credit limit per customer for credit policy benchmarking"
    - name: "total_outstanding_balance"
      expr: SUM(CAST(outstanding_balance AS DOUBLE))
      comment: "Total outstanding receivables balance for working capital and DSO tracking"
    - name: "total_overdue_amount"
      expr: SUM(CAST(overdue_amount AS DOUBLE))
      comment: "Total overdue receivables for collections prioritization and bad debt risk"
    - name: "avg_credit_utilization"
      expr: AVG(CAST(credit_utilization_pct AS DOUBLE))
      comment: "Average credit utilization percentage for credit capacity planning"
    - name: "accounts_on_credit_hold"
      expr: COUNT(DISTINCT CASE WHEN credit_hold = TRUE THEN credit_profile_id END)
      comment: "Count of accounts on credit hold for collections workload and revenue impact"
    - name: "credit_hold_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN credit_hold = TRUE THEN credit_profile_id END) / NULLIF(COUNT(DISTINCT credit_profile_id), 0), 2)
      comment: "Percentage of accounts on credit hold for credit quality monitoring"
    - name: "high_utilization_accounts"
      expr: COUNT(DISTINCT CASE WHEN CAST(credit_utilization_pct AS DOUBLE) > 80 THEN credit_profile_id END)
      comment: "Count of accounts with >80% credit utilization for proactive credit management"
    - name: "preferred_customers"
      expr: COUNT(DISTINCT CASE WHEN is_preferred_customer = TRUE THEN credit_profile_id END)
      comment: "Count of preferred customers for strategic account tracking"
    - name: "total_credit_limit_adjustments"
      expr: SUM(CAST(credit_limit_adjustment_amount AS DOUBLE))
      comment: "Total credit limit adjustments (increases and decreases) for credit policy effectiveness"
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`customer_price_agreement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Pricing and contract metrics tracking negotiated pricing, discounts, volume tiers, and pricing effectiveness - critical for margin management and pricing strategy optimization."
  source: "`vibe_semiconductors_v1`.`customer`.`price_agreement`"
  dimensions:
    - name: "price_agreement_status"
      expr: price_agreement_status
      comment: "Current status of the price agreement (active, expired, pending, etc.)"
    - name: "agreement_type"
      expr: agreement_type
      comment: "Type of pricing agreement (volume-based, contract, spot, promotional, etc.)"
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the pricing agreement for governance tracking"
    - name: "pricing_channel"
      expr: pricing_channel
      comment: "Sales channel for the pricing (direct, distribution, OEM, etc.)"
    - name: "pricing_region"
      expr: pricing_region
      comment: "Geographic region for the pricing for regional pricing strategy analysis"
    - name: "volume_tier"
      expr: volume_tier
      comment: "Volume tier classification for tiered pricing analysis"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the pricing for multi-currency pricing management"
    - name: "price_locked"
      expr: CASE WHEN is_price_locked = TRUE THEN 'Locked' ELSE 'Flexible' END
      comment: "Whether pricing is locked or subject to change for pricing stability tracking"
    - name: "effective_year"
      expr: YEAR(effective_from)
      comment: "Year the pricing became effective for pricing vintage analysis"
    - name: "effective_quarter"
      expr: CONCAT(CAST(YEAR(effective_from) AS STRING), '-Q', CAST(QUARTER(effective_from) AS STRING))
      comment: "Quarter the pricing became effective for pricing trend analysis"
  measures:
    - name: "total_price_agreements"
      expr: COUNT(DISTINCT price_agreement_id)
      comment: "Total number of price agreements for pricing complexity and coverage tracking"
    - name: "avg_unit_price"
      expr: AVG(CAST(unit_price AS DOUBLE))
      comment: "Average unit price across agreements for pricing level benchmarking"
    - name: "avg_discount_percent"
      expr: AVG(CAST(discount_percent AS DOUBLE))
      comment: "Average discount percentage granted for discount policy effectiveness"
    - name: "avg_tier_price"
      expr: AVG(CAST(tier_price AS DOUBLE))
      comment: "Average tier price for volume-based pricing analysis"
    - name: "total_minimum_order_quantity"
      expr: SUM(CAST(minimum_order_quantity AS DOUBLE))
      comment: "Total minimum order quantities across agreements for demand commitment tracking"
    - name: "avg_minimum_order_quantity"
      expr: AVG(CAST(minimum_order_quantity AS DOUBLE))
      comment: "Average minimum order quantity per agreement for MOQ policy benchmarking"
    - name: "price_locked_agreements"
      expr: COUNT(DISTINCT CASE WHEN is_price_locked = TRUE THEN price_agreement_id END)
      comment: "Count of price-locked agreements for pricing flexibility and risk assessment"
    - name: "price_locked_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN is_price_locked = TRUE THEN price_agreement_id END) / NULLIF(COUNT(DISTINCT price_agreement_id), 0), 2)
      comment: "Percentage of agreements with locked pricing for pricing risk exposure"
    - name: "active_agreements"
      expr: COUNT(DISTINCT CASE WHEN price_agreement_status = 'Active' THEN price_agreement_id END)
      comment: "Count of currently active price agreements for active pricing coverage"
    - name: "high_discount_agreements"
      expr: COUNT(DISTINCT CASE WHEN CAST(discount_percent AS DOUBLE) > 20 THEN price_agreement_id END)
      comment: "Count of agreements with >20% discount for margin risk and pricing discipline tracking"
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`customer_design_registration`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Design registration and qualification metrics tracking customer design projects, qualification status, and NRE budgets - essential for engineering resource planning and design-in pipeline management."
  source: "`vibe_semiconductors_v1`.`customer`.`design_registration`"
  dimensions:
    - name: "registration_status"
      expr: registration_status
      comment: "Current status of the design registration (active, pending, approved, etc.)"
    - name: "qualification_status"
      expr: qualification_status
      comment: "Qualification status of the design (in progress, qualified, failed, etc.)"
    - name: "design_complexity"
      expr: design_complexity
      comment: "Complexity level of the design project (simple, moderate, complex, advanced)"
    - name: "target_application"
      expr: target_application
      comment: "Target application for the design for market segment tracking"
    - name: "package_type"
      expr: package_type
      comment: "Package type for the design for technology mix analysis"
    - name: "platform_generation"
      expr: platform_generation
      comment: "Platform generation for roadmap alignment"
    - name: "registration_year"
      expr: YEAR(created_timestamp)
      comment: "Year the design was registered for registration trend analysis"
    - name: "registration_quarter"
      expr: CONCAT(CAST(YEAR(created_timestamp) AS STRING), '-Q', CAST(QUARTER(created_timestamp) AS STRING))
      comment: "Quarter the design was registered for quarterly pipeline tracking"
    - name: "design_start_year"
      expr: YEAR(design_start_date)
      comment: "Year the design project started for project vintage analysis"
    - name: "tapeout_target_year"
      expr: YEAR(tapeout_target_date)
      comment: "Year of target tapeout for production readiness forecasting"
  measures:
    - name: "total_design_registrations"
      expr: COUNT(DISTINCT design_registration_id)
      comment: "Total number of design registrations for design-in pipeline volume tracking"
    - name: "total_nre_budget"
      expr: SUM(CAST(nre_budget_amount AS DOUBLE))
      comment: "Total NRE budget across all design registrations for engineering investment planning"
    - name: "avg_nre_budget"
      expr: AVG(CAST(nre_budget_amount AS DOUBLE))
      comment: "Average NRE budget per design registration for project cost benchmarking"
    - name: "avg_expected_yield"
      expr: AVG(CAST(expected_yield_percent AS DOUBLE))
      comment: "Average expected yield percentage across designs for yield planning and quality forecasting"
    - name: "qualified_designs"
      expr: COUNT(DISTINCT CASE WHEN qualification_status = 'Qualified' THEN design_registration_id END)
      comment: "Count of qualified designs for production readiness tracking"
    - name: "qualification_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN qualification_status = 'Qualified' THEN design_registration_id END) / NULLIF(COUNT(DISTINCT design_registration_id), 0), 2)
      comment: "Percentage of designs that achieved qualification for design success rate measurement"
    - name: "complex_designs"
      expr: COUNT(DISTINCT CASE WHEN design_complexity IN ('Complex', 'Advanced') THEN design_registration_id END)
      comment: "Count of complex or advanced designs for resource allocation and risk assessment"
    - name: "active_registrations"
      expr: COUNT(DISTINCT CASE WHEN registration_status = 'Active' THEN design_registration_id END)
      comment: "Count of currently active design registrations for active pipeline tracking"
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`customer_contact`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Customer contact and engagement metrics tracking contact base, key contacts, engagement recency, and consent status - essential for relationship management and marketing compliance."
  source: "`vibe_semiconductors_v1`.`customer`.`contact`"
  dimensions:
    - name: "contact_status"
      expr: contact_status
      comment: "Current status of the contact (active, inactive, bounced, etc.)"
    - name: "role_type"
      expr: role_type
      comment: "Role or function of the contact (engineer, buyer, executive, etc.)"
    - name: "department"
      expr: department
      comment: "Department of the contact for organizational mapping"
    - name: "key_contact"
      expr: CASE WHEN is_key_contact = TRUE THEN 'Key Contact' ELSE 'Standard' END
      comment: "Whether this is a key decision-maker or influencer"
    - name: "marketing_opt_in"
      expr: CASE WHEN marketing_opt_in = TRUE THEN 'Opted In' ELSE 'Opted Out' END
      comment: "Marketing opt-in status for campaign targeting and compliance"
    - name: "gdpr_consent_status"
      expr: gdpr_consent_status
      comment: "GDPR consent status for privacy compliance"
    - name: "preferred_communication_channel"
      expr: preferred_communication_channel
      comment: "Preferred communication channel (email, phone, etc.) for engagement optimization"
    - name: "language_preference"
      expr: language_preference
      comment: "Language preference for localized communications"
    - name: "is_employee"
      expr: CASE WHEN is_employee = TRUE THEN 'Employee' ELSE 'External' END
      comment: "Whether contact is an internal employee for contact segmentation"
  measures:
    - name: "total_contacts"
      expr: COUNT(DISTINCT contact_id)
      comment: "Total number of customer contacts for contact base size tracking"
    - name: "key_contacts"
      expr: COUNT(DISTINCT CASE WHEN is_key_contact = TRUE THEN contact_id END)
      comment: "Count of key decision-maker contacts for relationship coverage assessment"
    - name: "key_contact_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN is_key_contact = TRUE THEN contact_id END) / NULLIF(COUNT(DISTINCT contact_id), 0), 2)
      comment: "Percentage of contacts that are key decision-makers for relationship quality measurement"
    - name: "marketing_opted_in_contacts"
      expr: COUNT(DISTINCT CASE WHEN marketing_opt_in = TRUE THEN contact_id END)
      comment: "Count of contacts opted in to marketing for campaign reach potential"
    - name: "marketing_opt_in_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN marketing_opt_in = TRUE THEN contact_id END) / NULLIF(COUNT(DISTINCT contact_id), 0), 2)
      comment: "Percentage of contacts opted in to marketing for marketing effectiveness measurement"
    - name: "active_contacts"
      expr: COUNT(DISTINCT CASE WHEN contact_status = 'Active' THEN contact_id END)
      comment: "Count of active contacts for reachable contact base tracking"
    - name: "recently_engaged_contacts"
      expr: COUNT(DISTINCT CASE WHEN DATEDIFF(CURRENT_DATE(), last_interaction_date) <= 90 THEN contact_id END)
      comment: "Contacts with interaction in last 90 days for engagement health tracking"
    - name: "dormant_contacts"
      expr: COUNT(DISTINCT CASE WHEN DATEDIFF(CURRENT_DATE(), last_interaction_date) > 180 THEN contact_id END)
      comment: "Contacts with no interaction in 180+ days for re-engagement campaigns"
    - name: "gdpr_compliant_contacts"
      expr: COUNT(DISTINCT CASE WHEN gdpr_consent_status = 'Consented' THEN contact_id END)
      comment: "Count of contacts with valid GDPR consent for compliance tracking"
$$;