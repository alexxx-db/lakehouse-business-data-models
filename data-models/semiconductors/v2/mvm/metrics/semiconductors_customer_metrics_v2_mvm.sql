-- Metric views for domain: customer | Business: Semiconductors | Version: 2 | Generated on: 2026-06-27 11:25:39

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`customer_account`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core customer account metrics tracking account counts, risk exposure, and strategic segmentation for executive decision-making on customer portfolio health and resource allocation."
  source: "`vibe_semiconductors_v1`.`customer`.`account`"
  dimensions:
    - name: "account_status"
      expr: account_status
      comment: "Current operational status of the account (active, inactive, suspended, closed) for cohort analysis and churn tracking."
    - name: "account_type"
      expr: account_type
      comment: "Classification of account type (direct, distributor, OEM, contract manufacturer) for channel strategy and pricing decisions."
    - name: "strategic_classification"
      expr: strategic_classification
      comment: "Strategic tier assignment (strategic, key, standard, emerging) for resource prioritization and executive account planning."
    - name: "revenue_tier"
      expr: revenue_tier
      comment: "Revenue band classification for segmentation and tiered service model decisions."
    - name: "geographic_region"
      expr: geographic_region
      comment: "Geographic region for regional performance analysis and market expansion planning."
    - name: "industry_vertical"
      expr: industry_vertical
      comment: "Target industry vertical (automotive, consumer electronics, industrial, telecom) for vertical-specific go-to-market strategy."
    - name: "credit_rating"
      expr: credit_rating
      comment: "Credit rating classification for risk management and credit policy decisions."
    - name: "compliance_status"
      expr: compliance_status
      comment: "Compliance verification status for regulatory risk assessment and audit readiness."
    - name: "creation_year"
      expr: YEAR(creation_date)
      comment: "Year account was created for cohort vintage analysis and customer lifetime value tracking."
    - name: "creation_quarter"
      expr: DATE_TRUNC('quarter', creation_date)
      comment: "Quarter account was created for new customer acquisition trend analysis."
  measures:
    - name: "total_accounts"
      expr: COUNT(DISTINCT account_id)
      comment: "Total unique customer accounts for portfolio size tracking and market penetration analysis."
    - name: "avg_risk_score"
      expr: AVG(CAST(risk_score AS DOUBLE))
      comment: "Average risk score across accounts for portfolio risk assessment and credit policy calibration."
    - name: "total_risk_exposure"
      expr: SUM(CAST(risk_score AS DOUBLE))
      comment: "Aggregate risk exposure across customer base for enterprise risk management and capital allocation decisions."
    - name: "high_risk_account_count"
      expr: COUNT(DISTINCT CASE WHEN CAST(risk_score AS DOUBLE) > 70 THEN account_id END)
      comment: "Count of accounts with risk score above 70 for proactive risk mitigation and credit hold decisions."
    - name: "strategic_account_count"
      expr: COUNT(DISTINCT CASE WHEN strategic_classification = 'strategic' THEN account_id END)
      comment: "Count of strategic-tier accounts for executive relationship management resource planning."
    - name: "tax_exempt_account_count"
      expr: COUNT(DISTINCT CASE WHEN tax_exempt_flag = TRUE THEN account_id END)
      comment: "Count of tax-exempt accounts for tax compliance reporting and pricing strategy."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`customer_design_win`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Design win pipeline and conversion metrics for strategic product adoption tracking, revenue forecasting, and competitive displacement analysis critical to semiconductor business development."
  source: "`vibe_semiconductors_v1`.`customer`.`design_win`"
  dimensions:
    - name: "design_win_status"
      expr: design_win_status
      comment: "Current status of design win (registered, qualified, won, lost, on-hold) for pipeline health and conversion funnel analysis."
    - name: "stage"
      expr: stage
      comment: "Design win stage in the qualification process for stage-gate progression tracking and resource allocation."
    - name: "design_phase"
      expr: design_phase
      comment: "Current design phase (concept, prototype, validation, production) for engineering resource planning and time-to-revenue forecasting."
    - name: "application_segment"
      expr: application_segment
      comment: "Target application segment (automotive, IoT, mobile, data center) for segment-specific win rate analysis and product roadmap prioritization."
    - name: "end_application"
      expr: end_application
      comment: "Specific end application for detailed market penetration tracking and competitive intelligence."
    - name: "competitive_displacement_flag"
      expr: competitive_displacement_flag
      comment: "Indicates whether design win displaced a competitor for market share gain analysis and competitive strategy effectiveness."
    - name: "competitor_displaced"
      expr: competitor_displaced
      comment: "Name of competitor displaced for competitive win tracking and battlecard effectiveness measurement."
    - name: "win_year"
      expr: YEAR(win_date)
      comment: "Year design win was secured for annual win rate trending and sales effectiveness analysis."
    - name: "win_quarter"
      expr: DATE_TRUNC('quarter', win_date)
      comment: "Quarter design win was secured for quarterly pipeline conversion tracking and forecast accuracy."
    - name: "production_ramp_year"
      expr: YEAR(production_ramp_date)
      comment: "Year production is expected to ramp for revenue timing forecasts and capacity planning."
  measures:
    - name: "total_design_wins"
      expr: COUNT(DISTINCT design_win_id)
      comment: "Total unique design wins for pipeline size tracking and business development productivity measurement."
    - name: "total_estimated_annual_revenue_usd"
      expr: SUM(CAST(estimated_annual_revenue_usd AS DOUBLE))
      comment: "Total estimated annual revenue from all design wins for revenue pipeline forecasting and target attainment tracking."
    - name: "avg_estimated_annual_revenue_usd"
      expr: AVG(CAST(estimated_annual_revenue_usd AS DOUBLE))
      comment: "Average estimated annual revenue per design win for deal size benchmarking and account prioritization."
    - name: "total_estimated_annual_volume"
      expr: SUM(CAST(estimated_annual_unit_volume AS BIGINT))
      comment: "Total estimated annual unit volume across design wins for manufacturing capacity planning and supply chain forecasting."
    - name: "avg_win_probability_percent"
      expr: AVG(CAST(win_probability_percent AS DOUBLE))
      comment: "Average win probability across pipeline for risk-adjusted revenue forecasting and pipeline quality assessment."
    - name: "total_nre_amount_usd"
      expr: SUM(CAST(nre_amount_usd AS DOUBLE))
      comment: "Total non-recurring engineering investment required across design wins for engineering resource budgeting and ROI analysis."
    - name: "competitive_displacement_count"
      expr: COUNT(DISTINCT CASE WHEN competitive_displacement_flag = TRUE THEN design_win_id END)
      comment: "Count of design wins that displaced competitors for market share capture tracking and competitive strategy effectiveness."
    - name: "nre_required_count"
      expr: COUNT(DISTINCT CASE WHEN nre_required_flag = TRUE THEN design_win_id END)
      comment: "Count of design wins requiring NRE investment for engineering capacity planning and custom design resource allocation."
    - name: "weighted_pipeline_value_usd"
      expr: SUM(CAST(estimated_annual_revenue_usd AS DOUBLE) * CAST(win_probability_percent AS DOUBLE) / 100.0)
      comment: "Probability-weighted pipeline value for risk-adjusted revenue forecasting and executive pipeline reviews."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`customer_credit_profile`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Customer credit and financial risk metrics for credit policy decisions, collections prioritization, and working capital optimization critical to semiconductor industry extended payment terms."
  source: "`vibe_semiconductors_v1`.`customer`.`credit_profile`"
  dimensions:
    - name: "credit_profile_status"
      expr: credit_profile_status
      comment: "Current status of credit profile (active, under review, suspended, closed) for credit operations workflow management."
    - name: "credit_rating_internal"
      expr: credit_rating_internal
      comment: "Internal credit rating classification for credit limit assignment and approval workflow routing."
    - name: "credit_rating_external"
      expr: credit_rating_external
      comment: "External credit rating from rating agency for third-party risk validation and credit insurance decisions."
    - name: "credit_hold_flag"
      expr: credit_hold_flag
      comment: "Indicates whether account is on credit hold for order release blocking and collections escalation."
    - name: "credit_hold_reason"
      expr: credit_hold_reason
      comment: "Reason for credit hold (overdue, limit exceeded, compliance) for root cause analysis and process improvement."
    - name: "risk_category"
      expr: risk_category
      comment: "Risk category classification (low, medium, high, critical) for tiered credit management and monitoring frequency."
    - name: "is_preferred_customer"
      expr: is_preferred_customer
      comment: "Indicates preferred customer status for expedited credit approval and enhanced payment terms eligibility."
    - name: "payment_terms"
      expr: payment_terms
      comment: "Standard payment terms for the customer for DSO forecasting and working capital impact analysis."
    - name: "credit_review_year"
      expr: YEAR(credit_review_date)
      comment: "Year of last credit review for review cycle compliance tracking and stale profile identification."
  measures:
    - name: "total_credit_profiles"
      expr: COUNT(DISTINCT credit_profile_id)
      comment: "Total unique credit profiles for credit operations workload sizing and system capacity planning."
    - name: "total_credit_limit_usd"
      expr: SUM(CAST(credit_limit_usd AS DOUBLE))
      comment: "Total credit limit extended across customer base for credit exposure reporting and capital adequacy assessment."
    - name: "total_outstanding_balance_usd"
      expr: SUM(CAST(outstanding_balance_usd AS DOUBLE))
      comment: "Total outstanding receivables balance for working capital management and liquidity forecasting."
    - name: "total_available_credit_usd"
      expr: SUM(CAST(available_credit_usd AS DOUBLE))
      comment: "Total available credit capacity across customer base for order acceptance capacity and revenue constraint analysis."
    - name: "total_overdue_amount"
      expr: SUM(CAST(overdue_amount AS DOUBLE))
      comment: "Total overdue receivables for collections prioritization and bad debt reserve estimation."
    - name: "avg_credit_utilization_pct"
      expr: AVG(CAST(credit_utilization_pct AS DOUBLE))
      comment: "Average credit utilization percentage for credit limit adequacy assessment and proactive limit increase decisions."
    - name: "credit_hold_count"
      expr: COUNT(DISTINCT CASE WHEN credit_hold_flag = TRUE THEN credit_profile_id END)
      comment: "Count of accounts on credit hold for collections workload sizing and order fulfillment constraint tracking."
    - name: "high_risk_profile_count"
      expr: COUNT(DISTINCT CASE WHEN risk_category = 'high' OR risk_category = 'critical' THEN credit_profile_id END)
      comment: "Count of high-risk credit profiles for enhanced monitoring resource allocation and credit insurance coverage decisions."
    - name: "preferred_customer_count"
      expr: COUNT(DISTINCT CASE WHEN is_preferred_customer = TRUE THEN credit_profile_id END)
      comment: "Count of preferred customers for VIP service program sizing and relationship management resource planning."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`customer_price_agreement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Pricing agreement and discount metrics for pricing strategy effectiveness, margin management, and contract compliance tracking essential to semiconductor volume pricing models."
  source: "`vibe_semiconductors_v1`.`customer`.`price_agreement`"
  dimensions:
    - name: "agreement_status"
      expr: agreement_status
      comment: "Current status of price agreement (active, pending, expired, terminated) for contract lifecycle management and renewal pipeline tracking."
    - name: "agreement_type"
      expr: agreement_type
      comment: "Type of pricing agreement (volume, strategic, promotional, standard) for pricing strategy segmentation and discount policy compliance."
    - name: "pricing_type"
      expr: pricing_type
      comment: "Pricing model type (tiered, flat, cost-plus, market-based) for pricing strategy analysis and margin optimization."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval workflow status for pricing governance compliance and approval bottleneck identification."
    - name: "volume_tier"
      expr: volume_tier
      comment: "Volume tier classification for tiered pricing effectiveness analysis and volume incentive program design."
    - name: "pricing_channel"
      expr: pricing_channel
      comment: "Sales channel for the pricing agreement for channel-specific pricing strategy and margin analysis."
    - name: "is_price_locked"
      expr: is_price_locked
      comment: "Indicates whether price is locked for contract period for price stability commitment tracking and margin risk assessment."
    - name: "effective_year"
      expr: YEAR(effective_date)
      comment: "Year agreement became effective for pricing vintage analysis and contract renewal forecasting."
    - name: "effective_quarter"
      expr: DATE_TRUNC('quarter', effective_date)
      comment: "Quarter agreement became effective for quarterly pricing action tracking and competitive response timing."
  measures:
    - name: "total_price_agreements"
      expr: COUNT(DISTINCT price_agreement_id)
      comment: "Total unique price agreements for contract portfolio size tracking and pricing operations workload measurement."
    - name: "avg_discount_percent"
      expr: AVG(CAST(discount_pct AS DOUBLE))
      comment: "Average discount percentage across agreements for pricing strategy effectiveness and margin erosion tracking."
    - name: "avg_unit_price_usd"
      expr: AVG(CAST(unit_price_usd AS DOUBLE))
      comment: "Average unit price across agreements for pricing level benchmarking and competitive positioning analysis."
    - name: "total_minimum_order_quantity"
      expr: SUM(CAST(minimum_order_quantity AS BIGINT))
      comment: "Total minimum order quantity commitments for demand visibility and production planning baseline."
    - name: "price_locked_agreement_count"
      expr: COUNT(DISTINCT CASE WHEN is_price_locked = TRUE THEN price_agreement_id END)
      comment: "Count of price-locked agreements for margin risk exposure tracking and pricing flexibility constraint analysis."
    - name: "active_agreement_count"
      expr: COUNT(DISTINCT CASE WHEN agreement_status = 'active' THEN price_agreement_id END)
      comment: "Count of currently active agreements for contract coverage tracking and renewal pipeline sizing."
    - name: "pending_approval_count"
      expr: COUNT(DISTINCT CASE WHEN approval_status = 'pending' THEN price_agreement_id END)
      comment: "Count of agreements pending approval for approval workflow bottleneck identification and cycle time improvement."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`customer_nda_agreement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "NDA agreement coverage and compliance metrics for legal risk management, IP protection tracking, and customer engagement readiness essential to semiconductor design collaboration."
  source: "`vibe_semiconductors_v1`.`customer`.`nda_agreement`"
  dimensions:
    - name: "nda_status"
      expr: nda_status
      comment: "Current status of NDA (active, expired, pending, terminated) for legal coverage tracking and engagement risk assessment."
    - name: "nda_type"
      expr: nda_type
      comment: "Type of NDA (mutual, unilateral, multilateral) for agreement structure analysis and negotiation strategy."
    - name: "confidentiality_level"
      expr: confidentiality_level
      comment: "Level of confidentiality protection (standard, high, critical) for IP risk classification and disclosure control."
    - name: "agreement_status"
      expr: agreement_status
      comment: "Workflow status of agreement (draft, executed, expired) for legal operations workflow management and bottleneck identification."
    - name: "mutual_flag"
      expr: mutual_flag
      comment: "Indicates whether NDA is mutual for reciprocal protection tracking and negotiation leverage analysis."
    - name: "auto_renew_flag"
      expr: auto_renew_flag
      comment: "Indicates whether NDA auto-renews for renewal workload forecasting and coverage continuity risk."
    - name: "governing_law"
      expr: governing_law
      comment: "Governing law jurisdiction for legal risk assessment and dispute resolution strategy."
    - name: "execution_year"
      expr: YEAR(execution_date)
      comment: "Year NDA was executed for agreement vintage analysis and renewal pipeline forecasting."
    - name: "expiry_year"
      expr: YEAR(expiry_date)
      comment: "Year NDA expires for proactive renewal planning and coverage gap risk management."
  measures:
    - name: "total_nda_agreements"
      expr: COUNT(DISTINCT nda_agreement_id)
      comment: "Total unique NDA agreements for legal coverage portfolio size and legal operations workload measurement."
    - name: "active_nda_count"
      expr: COUNT(DISTINCT CASE WHEN nda_status = 'active' THEN nda_agreement_id END)
      comment: "Count of active NDAs for current legal coverage tracking and customer engagement readiness."
    - name: "expired_nda_count"
      expr: COUNT(DISTINCT CASE WHEN nda_status = 'expired' THEN nda_agreement_id END)
      comment: "Count of expired NDAs for coverage gap identification and renewal prioritization."
    - name: "mutual_nda_count"
      expr: COUNT(DISTINCT CASE WHEN mutual_flag = TRUE THEN nda_agreement_id END)
      comment: "Count of mutual NDAs for reciprocal protection coverage and negotiation outcome tracking."
    - name: "auto_renew_nda_count"
      expr: COUNT(DISTINCT CASE WHEN auto_renew_flag = TRUE THEN nda_agreement_id END)
      comment: "Count of auto-renewing NDAs for administrative workload forecasting and coverage continuity assurance."
    - name: "high_confidentiality_count"
      expr: COUNT(DISTINCT CASE WHEN confidentiality_level = 'high' OR confidentiality_level = 'critical' THEN nda_agreement_id END)
      comment: "Count of high-confidentiality NDAs for IP risk exposure tracking and enhanced monitoring resource allocation."
$$;