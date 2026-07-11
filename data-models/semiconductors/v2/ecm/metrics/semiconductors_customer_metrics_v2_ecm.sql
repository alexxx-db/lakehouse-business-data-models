-- Metric views for domain: customer | Business: Semiconductors | Version: 2 | Generated on: 2026-07-10 11:52:05

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`customer_account`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic account health and portfolio metrics. Tracks account risk, credit exposure, and revenue tier distribution to support executive portfolio reviews and sales strategy decisions."
  source: "`vibe_semiconductors_v1`.`customer`.`account`"
  dimensions:
    - name: "account_status"
      expr: account_status
      comment: "Lifecycle status of the account (Active, Inactive, Suspended, etc.) for portfolio segmentation."
    - name: "account_type"
      expr: account_type
      comment: "Classification of the account (Direct, Distributor, OEM, etc.) to segment revenue and coverage strategy."
    - name: "revenue_tier"
      expr: revenue_tier
      comment: "Revenue tier bucket (Tier 1, Tier 2, etc.) used to prioritize sales and support resources."
    - name: "geographic_region"
      expr: geographic_region
      comment: "Geographic region of the account for regional performance analysis."
    - name: "industry_vertical"
      expr: industry_vertical
      comment: "Industry vertical (Automotive, Consumer, Data Center, etc.) for vertical market analysis."
    - name: "strategic_classification"
      expr: strategic_classification
      comment: "Strategic importance classification (Key Account, Growth, Maintenance) for executive prioritization."
    - name: "credit_rating"
      expr: credit_rating
      comment: "Credit rating of the account for financial risk segmentation."
    - name: "compliance_status"
      expr: compliance_status
      comment: "Compliance status of the account (Compliant, Under Review, Non-Compliant) for risk management."
    - name: "sales_region"
      expr: sales_region
      comment: "Sales region assignment for territory-level performance tracking."
    - name: "tax_exempt_flag"
      expr: tax_exempt_flag
      comment: "Indicates whether the account is tax-exempt, relevant for revenue and billing analysis."
    - name: "creation_year"
      expr: DATE_TRUNC('year', creation_date)
      comment: "Year the account was created, used for cohort and vintage analysis."
    - name: "last_order_year"
      expr: DATE_TRUNC('year', last_order_date)
      comment: "Year of the most recent order, used to identify dormant accounts."
  measures:
    - name: "total_accounts"
      expr: COUNT(DISTINCT account_id)
      comment: "Total number of distinct customer accounts. Baseline KPI for portfolio size tracking."
    - name: "avg_risk_score"
      expr: AVG(CAST(risk_score AS DOUBLE))
      comment: "Average risk score across accounts. Executives use this to monitor portfolio-level credit and compliance risk."
    - name: "max_risk_score"
      expr: MAX(CAST(risk_score AS DOUBLE))
      comment: "Maximum risk score in the portfolio. Flags the highest-risk account for immediate review."
    - name: "high_risk_account_count"
      expr: COUNT(DISTINCT CASE WHEN risk_score >= 75 THEN account_id END)
      comment: "Number of accounts with risk score >= 75. Drives credit risk intervention decisions."
    - name: "tax_exempt_account_count"
      expr: COUNT(DISTINCT CASE WHEN tax_exempt_flag = TRUE THEN account_id END)
      comment: "Number of tax-exempt accounts. Relevant for revenue recognition and billing compliance."
    - name: "active_account_count"
      expr: COUNT(DISTINCT CASE WHEN account_status = 'Active' THEN account_id END)
      comment: "Number of active accounts. Core metric for sales coverage and pipeline health."
    - name: "inactive_account_count"
      expr: COUNT(DISTINCT CASE WHEN account_status = 'Inactive' THEN account_id END)
      comment: "Number of inactive accounts. Drives win-back campaign prioritization."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`customer_credit_profile`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Customer credit risk and exposure metrics. Tracks credit utilization, outstanding balances, overdue amounts, and credit limit adequacy to support finance and risk management decisions."
  source: "`vibe_semiconductors_v1`.`customer`.`credit_profile`"
  dimensions:
    - name: "credit_profile_status"
      expr: credit_profile_status
      comment: "Current status of the credit profile (Active, Suspended, Under Review) for risk segmentation."
    - name: "credit_profile_type"
      expr: credit_profile_type
      comment: "Type of credit profile (Standard, Preferred, Restricted) for policy-based analysis."
    - name: "risk_category"
      expr: risk_category
      comment: "Risk category (Low, Medium, High, Critical) for portfolio risk tiering."
    - name: "credit_rating_internal"
      expr: credit_rating_internal
      comment: "Internal credit rating assigned by the finance team for risk-adjusted pricing decisions."
    - name: "credit_rating_external"
      expr: credit_rating_external
      comment: "External credit rating from a rating agency for benchmarking internal assessments."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the credit profile for multi-currency exposure analysis."
    - name: "credit_hold"
      expr: credit_hold
      comment: "Indicates whether the account is on credit hold, directly impacting order fulfillment."
    - name: "is_preferred_customer"
      expr: is_preferred_customer
      comment: "Flags preferred customers who receive enhanced credit terms and priority service."
    - name: "credit_review_year"
      expr: DATE_TRUNC('year', credit_review_date)
      comment: "Year of the last credit review for review cycle compliance tracking."
  measures:
    - name: "total_credit_limit"
      expr: SUM(CAST(credit_limit_amount AS DOUBLE))
      comment: "Total credit limit extended across all customer accounts. Measures total financial exposure approved by finance."
    - name: "total_outstanding_balance"
      expr: SUM(CAST(outstanding_balance AS DOUBLE))
      comment: "Total outstanding balance across all accounts. Core AR exposure metric for treasury and credit management."
    - name: "total_overdue_amount"
      expr: SUM(CAST(overdue_amount AS DOUBLE))
      comment: "Total overdue amount across all accounts. Drives collections prioritization and bad-debt provisioning."
    - name: "avg_credit_utilization_pct"
      expr: AVG(CAST(credit_utilization_pct AS DOUBLE))
      comment: "Average credit utilization percentage across accounts. High utilization signals elevated default risk."
    - name: "avg_credit_limit"
      expr: AVG(CAST(credit_limit_amount AS DOUBLE))
      comment: "Average credit limit per account. Used to benchmark credit policy adequacy across customer tiers."
    - name: "credit_hold_account_count"
      expr: COUNT(DISTINCT CASE WHEN credit_hold = TRUE THEN credit_profile_id END)
      comment: "Number of accounts currently on credit hold. Directly impacts order fulfillment capacity and revenue."
    - name: "avg_credit_limit_adjustment"
      expr: AVG(CAST(credit_limit_adjustment_amount AS DOUBLE))
      comment: "Average credit limit adjustment amount. Tracks the magnitude of credit policy changes over time."
    - name: "total_credit_limit_adjustment"
      expr: SUM(CAST(credit_limit_adjustment_amount AS DOUBLE))
      comment: "Total net credit limit adjustments. Indicates whether the portfolio is being tightened or expanded."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`customer_design_win`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Design win pipeline and revenue potential metrics. Design wins are the primary leading indicator of future semiconductor revenue and are tracked at every executive review."
  source: "`vibe_semiconductors_v1`.`customer`.`customer_design_win`"
  dimensions:
    - name: "stage"
      expr: stage
      comment: "Pipeline stage of the design win (Registered, Qualified, Production, Lost) for funnel analysis."
    - name: "target_application"
      expr: target_application
      comment: "End application (Automotive, AI/ML, 5G, IoT, etc.) for market segment revenue forecasting."
    - name: "process_node"
      expr: process_node
      comment: "Process technology node (e.g., 7nm, 5nm) for technology roadmap alignment analysis."
    - name: "platform_generation"
      expr: platform_generation
      comment: "Product platform generation for portfolio lifecycle management."
    - name: "package_type"
      expr: package_type
      comment: "Packaging type for supply chain and packaging capacity planning."
    - name: "nre_required_flag"
      expr: nre_required_flag
      comment: "Indicates whether NRE (Non-Recurring Engineering) is required, impacting deal economics."
    - name: "competitive_displacement_flag"
      expr: competitive_displacement_flag
      comment: "Flags wins that displaced a competitor, used to track competitive win rate."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the design win revenue estimate for multi-currency reporting."
    - name: "design_win_source"
      expr: design_win_source
      comment: "Source of the design win (Direct, Channel, FAE-led) for sales motion effectiveness analysis."
    - name: "production_ramp_year"
      expr: DATE_TRUNC('year', production_ramp_date)
      comment: "Year of expected production ramp for revenue timing and capacity planning."
    - name: "tapeout_target_year"
      expr: DATE_TRUNC('year', tapeout_target_date)
      comment: "Year of tapeout target for design pipeline scheduling."
    - name: "registration_year"
      expr: DATE_TRUNC('year', registration_timestamp)
      comment: "Year the design win was registered for cohort and vintage analysis."
  measures:
    - name: "total_design_wins"
      expr: COUNT(DISTINCT customer_design_win_id)
      comment: "Total number of design wins. Primary leading indicator of future revenue volume."
    - name: "total_estimated_annual_revenue_usd"
      expr: SUM(CAST(estimated_annual_revenue_usd AS DOUBLE))
      comment: "Total estimated annual revenue from all design wins. Core pipeline value metric used in executive forecasting."
    - name: "avg_estimated_annual_revenue_usd"
      expr: AVG(CAST(estimated_annual_revenue_usd AS DOUBLE))
      comment: "Average estimated annual revenue per design win. Measures deal size trends and portfolio quality."
    - name: "total_estimated_annual_unit_volume"
      expr: SUM(CAST(estimated_annual_unit_volume AS DOUBLE))
      comment: "Total estimated annual unit volume across all design wins. Drives capacity planning and supply commitments."
    - name: "total_nre_amount_usd"
      expr: SUM(CAST(nre_amount_usd AS DOUBLE))
      comment: "Total NRE revenue from design wins. Tracks engineering services revenue separate from product revenue."
    - name: "competitive_displacement_count"
      expr: COUNT(DISTINCT CASE WHEN competitive_displacement_flag = TRUE THEN customer_design_win_id END)
      comment: "Number of design wins that displaced a competitor. Key metric for competitive strategy effectiveness."
    - name: "avg_annual_units_per_win"
      expr: AVG(CAST(estimated_annual_unit_volume AS DOUBLE))
      comment: "Average annual unit volume per design win. Indicates whether wins are high-volume or niche engagements."
    - name: "nre_required_win_count"
      expr: COUNT(DISTINCT CASE WHEN nre_required_flag = TRUE THEN customer_design_win_id END)
      comment: "Number of design wins requiring NRE investment. Informs R&D resource allocation and deal profitability."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`customer_design_registration`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Design registration pipeline metrics tracking early-stage customer design engagements. Design registrations are the top-of-funnel precursor to design wins and drive NRE and capacity planning."
  source: "`vibe_semiconductors_v1`.`customer`.`customer_design_registration`"
  dimensions:
    - name: "registration_status"
      expr: registration_status
      comment: "Status of the design registration (Pending, Approved, Rejected, Expired) for funnel conversion analysis."
    - name: "qualification_status"
      expr: qualification_status
      comment: "Qualification status of the design (Qualified, In Progress, Not Started) for readiness tracking."
    - name: "target_application"
      expr: target_application
      comment: "Target end application for market segment pipeline analysis."
    - name: "process_node_nm"
      expr: process_node_nm
      comment: "Process node in nanometers for technology roadmap alignment."
    - name: "platform_generation"
      expr: platform_generation
      comment: "Platform generation for product lifecycle and roadmap planning."
    - name: "design_complexity"
      expr: design_complexity
      comment: "Complexity tier of the design (Simple, Medium, Complex) for resource and NRE estimation."
    - name: "package_type"
      expr: package_type
      comment: "Package type for packaging capacity and supply chain planning."
    - name: "nre_budget_currency"
      expr: nre_budget_currency
      comment: "Currency of the NRE budget for multi-currency financial reporting."
    - name: "tapeout_target_year"
      expr: DATE_TRUNC('year', tapeout_target_date)
      comment: "Year of tapeout target for fab capacity scheduling."
    - name: "production_target_year"
      expr: DATE_TRUNC('year', production_target_date)
      comment: "Year of production target for revenue timing and supply planning."
  measures:
    - name: "total_design_registrations"
      expr: COUNT(DISTINCT customer_design_registration_id)
      comment: "Total design registrations. Top-of-funnel pipeline volume metric for sales and FAE coverage planning."
    - name: "total_nre_budget"
      expr: SUM(CAST(nre_budget_amount AS DOUBLE))
      comment: "Total NRE budget committed across all design registrations. Drives R&D and engineering resource allocation."
    - name: "avg_nre_budget"
      expr: AVG(CAST(nre_budget_amount AS DOUBLE))
      comment: "Average NRE budget per design registration. Benchmarks deal size and engineering investment per engagement."
    - name: "avg_expected_yield_percent"
      expr: AVG(CAST(expected_yield_percent AS DOUBLE))
      comment: "Average expected yield percentage across registrations. Informs cost modeling and profitability projections."
    - name: "approved_registration_count"
      expr: COUNT(DISTINCT CASE WHEN registration_status = 'Approved' THEN customer_design_registration_id END)
      comment: "Number of approved design registrations. Measures pipeline conversion from registration to active engagement."
    - name: "total_nre_budget_approved"
      expr: SUM(CAST(CASE WHEN registration_status = 'Approved' THEN nre_budget_amount ELSE 0 END AS DOUBLE))
      comment: "Total NRE budget for approved registrations only. Represents committed engineering investment."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`customer_price_agreement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Customer pricing and discount metrics. Price agreements govern revenue realization and margin. Tracking discount depth, pricing tiers, and agreement coverage is critical for revenue management."
  source: "`vibe_semiconductors_v1`.`customer`.`price_agreement`"
  dimensions:
    - name: "price_agreement_status"
      expr: price_agreement_status
      comment: "Status of the price agreement (Active, Expired, Pending Approval) for coverage and compliance tracking."
    - name: "agreement_type"
      expr: agreement_type
      comment: "Type of price agreement (Volume, Spot, Long-Term Contract) for pricing strategy analysis."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the agreement for governance and audit compliance."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the price agreement for multi-currency revenue analysis."
    - name: "pricing_channel"
      expr: pricing_channel
      comment: "Sales channel (Direct, Distribution, eCommerce) for channel pricing strategy analysis."
    - name: "pricing_region"
      expr: pricing_region
      comment: "Geographic pricing region for regional price competitiveness analysis."
    - name: "volume_tier"
      expr: volume_tier
      comment: "Volume tier of the agreement for tiered pricing effectiveness analysis."
    - name: "is_price_locked"
      expr: is_price_locked
      comment: "Indicates whether the price is locked, relevant for revenue predictability and hedging."
    - name: "effective_from_year"
      expr: DATE_TRUNC('year', effective_from)
      comment: "Year the price agreement became effective for vintage and renewal cycle analysis."
    - name: "effective_until_year"
      expr: DATE_TRUNC('year', effective_until)
      comment: "Year the price agreement expires for renewal pipeline management."
  measures:
    - name: "total_price_agreements"
      expr: COUNT(DISTINCT price_agreement_id)
      comment: "Total number of price agreements. Baseline for pricing coverage and governance tracking."
    - name: "avg_unit_price"
      expr: AVG(CAST(unit_price AS DOUBLE))
      comment: "Average unit price across all agreements. Tracks ASP (Average Selling Price) trends for margin management."
    - name: "avg_discount_percent"
      expr: AVG(CAST(discount_percent AS DOUBLE))
      comment: "Average discount percentage granted. Executives use this to monitor pricing discipline and margin erosion."
    - name: "max_discount_percent"
      expr: MAX(CAST(discount_percent AS DOUBLE))
      comment: "Maximum discount percentage granted. Flags outlier discounting that may require approval review."
    - name: "avg_tier_price"
      expr: AVG(CAST(tier_price AS DOUBLE))
      comment: "Average tier price across volume-tiered agreements. Measures effectiveness of volume incentive pricing."
    - name: "total_minimum_order_quantity"
      expr: SUM(CAST(minimum_order_quantity AS DOUBLE))
      comment: "Total minimum order quantity committed across agreements. Informs demand planning and inventory positioning."
    - name: "active_agreement_count"
      expr: COUNT(DISTINCT CASE WHEN price_agreement_status = 'Active' THEN price_agreement_id END)
      comment: "Number of currently active price agreements. Measures pricing coverage across the customer base."
    - name: "price_locked_agreement_count"
      expr: COUNT(DISTINCT CASE WHEN is_price_locked = TRUE THEN price_agreement_id END)
      comment: "Number of price-locked agreements. Indicates revenue predictability and exposure to spot price volatility."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`customer_engagement_activity`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Customer engagement intensity and quality metrics. Engagement activity drives pipeline conversion and customer retention. Executives track engagement volume, escalation rates, and billable activity to optimize sales and support coverage."
  source: "`vibe_semiconductors_v1`.`customer`.`engagement_activity`"
  dimensions:
    - name: "activity_type"
      expr: activity_type
      comment: "Type of engagement activity (Demo, Technical Review, Executive Briefing, Support Call) for coverage analysis."
    - name: "activity_category"
      expr: activity_category
      comment: "Category of the activity (Pre-Sales, Post-Sales, Technical, Executive) for resource allocation analysis."
    - name: "channel"
      expr: channel
      comment: "Engagement channel (In-Person, Virtual, Email, Phone) for channel effectiveness analysis."
    - name: "outcome"
      expr: outcome
      comment: "Outcome of the engagement (Positive, Neutral, Negative, Follow-Up Required) for pipeline impact assessment."
    - name: "is_escalated"
      expr: is_escalated
      comment: "Flags escalated engagements requiring management attention."
    - name: "is_billable"
      expr: is_billable
      comment: "Indicates whether the engagement is billable, relevant for professional services revenue tracking."
    - name: "region"
      expr: region
      comment: "Geographic region of the engagement for regional coverage and resource deployment analysis."
    - name: "compliance_status"
      expr: compliance_status
      comment: "Compliance status of the engagement for export control and regulatory reporting."
    - name: "risk_flag"
      expr: risk_flag
      comment: "Flags high-risk engagements for compliance or relationship risk review."
    - name: "activity_year"
      expr: DATE_TRUNC('year', activity_timestamp)
      comment: "Year of the engagement activity for trend and YoY comparison."
    - name: "activity_month"
      expr: DATE_TRUNC('month', activity_timestamp)
      comment: "Month of the engagement activity for monthly cadence and seasonality analysis."
  measures:
    - name: "total_engagement_activities"
      expr: COUNT(DISTINCT engagement_activity_id)
      comment: "Total number of engagement activities. Measures sales and FAE coverage intensity across the customer base."
    - name: "total_budget_amount"
      expr: SUM(CAST(budget_amount AS DOUBLE))
      comment: "Total budget allocated to engagement activities. Tracks customer engagement investment for ROI analysis."
    - name: "avg_budget_per_activity"
      expr: AVG(CAST(budget_amount AS DOUBLE))
      comment: "Average budget per engagement activity. Benchmarks cost-per-touch for sales efficiency optimization."
    - name: "escalated_activity_count"
      expr: COUNT(DISTINCT CASE WHEN is_escalated = TRUE THEN engagement_activity_id END)
      comment: "Number of escalated engagement activities. High escalation rates signal customer satisfaction risk."
    - name: "billable_activity_count"
      expr: COUNT(DISTINCT CASE WHEN is_billable = TRUE THEN engagement_activity_id END)
      comment: "Number of billable engagement activities. Tracks professional services revenue-generating touchpoints."
    - name: "risk_flagged_activity_count"
      expr: COUNT(DISTINCT CASE WHEN risk_flag = TRUE THEN engagement_activity_id END)
      comment: "Number of risk-flagged engagements. Drives compliance review and relationship risk mitigation actions."
    - name: "unique_accounts_engaged"
      expr: COUNT(DISTINCT primary_engagement_account_id)
      comment: "Number of distinct accounts with engagement activity. Measures breadth of active customer coverage."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`customer_qualification_status`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Customer qualification and certification metrics. Qualification status tracks AEC-Q, IATF 16949, and PPAP compliance — mandatory for automotive and industrial semiconductor customers. Executives use this to manage qualification pipeline and revenue readiness."
  source: "`vibe_semiconductors_v1`.`customer`.`qualification_status`"
  dimensions:
    - name: "overall_qualification_status"
      expr: overall_qualification_status
      comment: "Overall qualification status (Qualified, In Progress, Failed, Expired) for pipeline readiness tracking."
    - name: "qualification_type"
      expr: qualification_type
      comment: "Type of qualification (AEC-Q100, IATF 16949, PPAP, Customer-Specific) for compliance program management."
    - name: "aec_q_status"
      expr: aec_q_status
      comment: "AEC-Q qualification status for automotive market readiness tracking."
    - name: "iatf_16949_status"
      expr: iatf_16949_status
      comment: "IATF 16949 certification status for automotive quality system compliance."
    - name: "ppap_status"
      expr: ppap_status
      comment: "PPAP (Production Part Approval Process) status for automotive production readiness."
    - name: "lifecycle_status"
      expr: lifecycle_status
      comment: "Lifecycle status of the qualification for renewal and expiry management."
    - name: "qualified_product_families"
      expr: qualified_product_families
      comment: "Product families covered by the qualification for product-level readiness analysis."
    - name: "qualification_start_year"
      expr: DATE_TRUNC('year', qualification_start_date)
      comment: "Year qualification was initiated for cycle time and throughput analysis."
    - name: "qualification_completion_year"
      expr: DATE_TRUNC('year', qualification_completion_date)
      comment: "Year qualification was completed for on-time delivery tracking."
  measures:
    - name: "total_qualifications"
      expr: COUNT(DISTINCT qualification_status_id)
      comment: "Total number of customer qualifications. Baseline for qualification pipeline volume and capacity planning."
    - name: "qualified_count"
      expr: COUNT(DISTINCT CASE WHEN overall_qualification_status = 'Qualified' THEN qualification_status_id END)
      comment: "Number of fully qualified accounts. Directly represents revenue-ready customer base for qualified products."
    - name: "in_progress_count"
      expr: COUNT(DISTINCT CASE WHEN overall_qualification_status = 'In Progress' THEN qualification_status_id END)
      comment: "Number of qualifications in progress. Measures active pipeline for future revenue enablement."
    - name: "avg_qualification_score"
      expr: AVG(CAST(qualification_score AS DOUBLE))
      comment: "Average qualification score. Tracks quality of qualification outcomes and customer readiness."
    - name: "aec_q_qualified_count"
      expr: COUNT(DISTINCT CASE WHEN aec_q_status = 'Qualified' THEN qualification_status_id END)
      comment: "Number of AEC-Q qualified accounts. Critical metric for automotive market revenue readiness."
    - name: "ppap_approved_count"
      expr: COUNT(DISTINCT CASE WHEN ppap_status = 'Approved' THEN qualification_status_id END)
      comment: "Number of PPAP-approved qualifications. Required for automotive production launch authorization."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`customer_distributor_agreement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Distributor channel agreement metrics. Distributor agreements govern channel revenue, MDF entitlements, and stock rotation rights. Executives track agreement coverage, MDF utilization, and discount depth to manage channel profitability."
  source: "`vibe_semiconductors_v1`.`customer`.`distributor_agreement`"
  dimensions:
    - name: "distributor_agreement_status"
      expr: distributor_agreement_status
      comment: "Status of the distributor agreement (Active, Expired, Terminated) for channel coverage analysis."
    - name: "agreement_type"
      expr: agreement_type
      comment: "Type of distributor agreement (Authorized, Exclusive, Value-Added) for channel strategy analysis."
    - name: "tier"
      expr: tier
      comment: "Distributor tier (Gold, Silver, Bronze) for tiered channel program management."
    - name: "territory_country_code"
      expr: territory_country_code
      comment: "Country code of the distribution territory for geographic channel coverage analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the agreement for multi-currency channel revenue reporting."
    - name: "exclusive_distribution"
      expr: exclusive_distribution
      comment: "Indicates exclusive distribution rights, relevant for territory conflict and channel strategy decisions."
    - name: "stock_rotation_rights"
      expr: stock_rotation_rights
      comment: "Indicates whether stock rotation rights are granted, impacting inventory and returns management."
    - name: "effective_start_year"
      expr: DATE_TRUNC('year', effective_start_date)
      comment: "Year the agreement became effective for vintage and renewal cycle analysis."
    - name: "effective_end_year"
      expr: DATE_TRUNC('year', effective_end_date)
      comment: "Year the agreement expires for renewal pipeline management."
  measures:
    - name: "total_distributor_agreements"
      expr: COUNT(DISTINCT distributor_agreement_id)
      comment: "Total number of distributor agreements. Baseline for channel coverage and partner ecosystem size."
    - name: "total_mdf_entitlement"
      expr: SUM(CAST(mdf_entitlement_amount AS DOUBLE))
      comment: "Total Market Development Fund (MDF) entitlement across all distributor agreements. Tracks channel marketing investment."
    - name: "avg_mdf_entitlement"
      expr: AVG(CAST(mdf_entitlement_amount AS DOUBLE))
      comment: "Average MDF entitlement per distributor agreement. Benchmarks channel investment per partner."
    - name: "avg_discount_rate_percent"
      expr: AVG(CAST(discount_rate_percent AS DOUBLE))
      comment: "Average distributor discount rate. Monitors channel margin erosion and pricing discipline."
    - name: "max_discount_rate_percent"
      expr: MAX(CAST(discount_rate_percent AS DOUBLE))
      comment: "Maximum distributor discount rate granted. Flags outlier discounting for approval review."
    - name: "active_agreement_count"
      expr: COUNT(DISTINCT CASE WHEN distributor_agreement_status = 'Active' THEN distributor_agreement_id END)
      comment: "Number of active distributor agreements. Measures current channel coverage and partner engagement."
    - name: "exclusive_agreement_count"
      expr: COUNT(DISTINCT CASE WHEN exclusive_distribution = TRUE THEN distributor_agreement_id END)
      comment: "Number of exclusive distribution agreements. Informs territory conflict management and channel strategy."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`customer_sample_request`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Customer sample request fulfillment and cost metrics. Sample requests are a key pre-sales activity in semiconductors — tracking fulfillment rates, costs, and cycle times directly impacts design win conversion."
  source: "`vibe_semiconductors_v1`.`customer`.`customer_sample_request`"
  dimensions:
    - name: "customer_sample_request_status"
      expr: customer_sample_request_status
      comment: "Status of the sample request (Pending, Approved, Fulfilled, Cancelled) for pipeline tracking."
    - name: "fulfillment_status"
      expr: fulfillment_status
      comment: "Fulfillment status of the sample request for supply chain and logistics performance tracking."
    - name: "sample_purpose"
      expr: sample_purpose
      comment: "Purpose of the sample (Evaluation, Qualification, Prototype) for demand characterization."
    - name: "cost_currency"
      expr: cost_currency
      comment: "Currency of the sample cost for multi-currency cost reporting."
    - name: "request_year"
      expr: DATE_TRUNC('year', request_timestamp)
      comment: "Year the sample was requested for trend and YoY volume analysis."
    - name: "delivery_requested_year"
      expr: DATE_TRUNC('year', delivery_requested_date)
      comment: "Year of requested delivery for lead time and fulfillment cycle analysis."
  measures:
    - name: "total_sample_requests"
      expr: COUNT(DISTINCT customer_sample_request_id)
      comment: "Total number of sample requests. Measures pre-sales pipeline activity and design engagement intensity."
    - name: "total_sample_cost"
      expr: SUM(CAST(cost_amount AS DOUBLE))
      comment: "Total cost of samples provided. Tracks pre-sales investment for ROI and design win conversion analysis."
    - name: "avg_sample_cost"
      expr: AVG(CAST(cost_amount AS DOUBLE))
      comment: "Average cost per sample request. Benchmarks pre-sales cost efficiency."
    - name: "total_net_cost"
      expr: SUM(CAST(cost_net AS DOUBLE))
      comment: "Total net cost of samples after adjustments. Represents actual pre-sales investment."
    - name: "total_cost_adjustment"
      expr: SUM(CAST(cost_adjustment AS DOUBLE))
      comment: "Total cost adjustments applied to sample requests. Tracks pricing exceptions and special approvals."
    - name: "fulfilled_request_count"
      expr: COUNT(DISTINCT CASE WHEN fulfillment_status = 'Fulfilled' THEN customer_sample_request_id END)
      comment: "Number of fulfilled sample requests. Measures supply chain responsiveness to pre-sales demand."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`customer_segment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Customer segment strategic metrics. Segments define revenue targets, market share goals, and pricing strategies. Executives use segment metrics to allocate sales resources and evaluate go-to-market effectiveness."
  source: "`vibe_semiconductors_v1`.`customer`.`segment`"
  dimensions:
    - name: "segment_status"
      expr: segment_status
      comment: "Status of the segment (Active, Inactive, Under Review) for portfolio management."
    - name: "vertical_market"
      expr: vertical_market
      comment: "Vertical market (Automotive, Industrial, Consumer, Data Center) for market segment strategy analysis."
    - name: "sub_vertical"
      expr: sub_vertical
      comment: "Sub-vertical for granular market segment targeting and resource allocation."
    - name: "region"
      expr: region
      comment: "Geographic region of the segment for regional go-to-market planning."
    - name: "strategic_priority_tier"
      expr: strategic_priority_tier
      comment: "Strategic priority tier (Tier 1, Tier 2, Tier 3) for resource prioritization decisions."
    - name: "pricing_strategy"
      expr: pricing_strategy
      comment: "Pricing strategy applied to the segment (Value, Competitive, Cost-Plus) for margin management."
    - name: "sales_motion"
      expr: sales_motion
      comment: "Sales motion (Direct, Channel, Digital) for go-to-market effectiveness analysis."
    - name: "tam_band"
      expr: tam_band
      comment: "Total Addressable Market band for segment sizing and investment prioritization."
    - name: "target_customer_type"
      expr: target_customer_type
      comment: "Target customer type (OEM, ODM, Fabless, System House) for sales coverage planning."
    - name: "effective_from_year"
      expr: DATE_TRUNC('year', effective_from)
      comment: "Year the segment strategy became effective for planning cycle alignment."
  measures:
    - name: "total_segments"
      expr: COUNT(DISTINCT segment_id)
      comment: "Total number of customer segments. Baseline for go-to-market coverage and segmentation complexity."
    - name: "total_revenue_target_usd"
      expr: SUM(CAST(revenue_target_usd AS DOUBLE))
      comment: "Total revenue target across all segments. Core top-line planning metric for executive revenue forecasting."
    - name: "avg_revenue_target_usd"
      expr: AVG(CAST(revenue_target_usd AS DOUBLE))
      comment: "Average revenue target per segment. Benchmarks segment sizing and investment allocation."
    - name: "total_market_share_target_pct"
      expr: AVG(CAST(market_share_target_percent AS DOUBLE))
      comment: "Average market share target across segments. Tracks ambition level of go-to-market strategy."
    - name: "avg_discount_rate"
      expr: AVG(CAST(discount_rate AS DOUBLE))
      comment: "Average discount rate across segments. Monitors pricing discipline and margin management by segment."
    - name: "active_segment_count"
      expr: COUNT(DISTINCT CASE WHEN segment_status = 'Active' THEN segment_id END)
      comment: "Number of active segments. Measures current go-to-market coverage breadth."
$$;