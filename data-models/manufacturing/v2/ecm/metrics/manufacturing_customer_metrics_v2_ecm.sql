-- Metric views for domain: customer | Business: Manufacturing | Version: 2 | Generated on: 2026-07-10 11:52:40

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`customer_account`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPIs over the customer account master — tracks portfolio health, credit exposure, revenue potential, and account lifecycle for executive and sales leadership decision-making."
  source: "`vibe_manufacturing_v1`.`customer`.`customer_account`"
  dimensions:
    - name: "account_status"
      expr: account_status
      comment: "Current lifecycle status of the customer account (Active, Inactive, Suspended, etc.) — primary segmentation axis for portfolio health reporting."
    - name: "account_type"
      expr: account_type
      comment: "Classification of the account (Direct, Distributor, OEM, etc.) — used to segment revenue and credit exposure by go-to-market channel."
    - name: "sla_tier"
      expr: sla_tier
      comment: "Service level tier assigned to the account — drives prioritisation in operational and executive dashboards."
    - name: "industry_naics_code"
      expr: industry_naics_code
      comment: "NAICS industry classification of the customer — enables vertical-market analysis of account concentration and revenue."
    - name: "credit_rating"
      expr: credit_rating
      comment: "External or internal credit rating of the account — used to segment credit risk exposure across the portfolio."
    - name: "is_strategic_account"
      expr: is_strategic_account
      comment: "Flag indicating whether the account is designated as strategic — used to separate strategic vs. standard account KPIs."
    - name: "is_global_account"
      expr: is_global_account
      comment: "Flag indicating a global account requiring multi-region coordination — used to track global account programme performance."
    - name: "sales_organization_code"
      expr: sales_organization_code
      comment: "Sales organisation responsible for the account — enables regional and organisational performance breakdowns."
    - name: "distribution_channel_code"
      expr: distribution_channel_code
      comment: "Distribution channel through which the account is served — used for channel mix and margin analysis."
    - name: "preferred_language_code"
      expr: preferred_language_code
      comment: "Preferred language of the customer — used for localisation and customer experience reporting."
  measures:
    - name: "total_active_accounts"
      expr: COUNT(CASE WHEN account_status = 'Active' THEN customer_account_id END)
      comment: "Count of active customer accounts — baseline portfolio size KPI used in executive dashboards and QBRs to track customer base growth or attrition."
    - name: "total_accounts"
      expr: COUNT(1)
      comment: "Total count of all customer account records regardless of status — used as the denominator for active-rate and conversion calculations."
    - name: "total_credit_limit"
      expr: SUM(CAST(credit_limit AS DOUBLE))
      comment: "Sum of approved credit limits across all accounts — measures total credit exposure extended to the customer base; a key risk management KPI for CFO and credit teams."
    - name: "avg_credit_limit"
      expr: AVG(CAST(credit_limit AS DOUBLE))
      comment: "Average credit limit per customer account — used to benchmark credit policy and identify outliers requiring review."
    - name: "total_annual_revenue"
      expr: SUM(CAST(annual_revenue AS DOUBLE))
      comment: "Sum of reported annual revenue across all customer accounts — proxy for total addressable wallet and strategic account value; used in portfolio prioritisation."
    - name: "avg_annual_revenue"
      expr: AVG(CAST(annual_revenue AS DOUBLE))
      comment: "Average annual revenue per customer account — used to benchmark account value and identify under-penetrated segments."
    - name: "strategic_account_count"
      expr: COUNT(CASE WHEN is_strategic_account = TRUE THEN customer_account_id END)
      comment: "Count of accounts flagged as strategic — tracks the size of the strategic account programme; used by sales leadership to allocate dedicated resources."
    - name: "global_account_count"
      expr: COUNT(CASE WHEN is_global_account = TRUE THEN customer_account_id END)
      comment: "Count of global accounts — measures the scale of the global account programme and informs international sales resource planning."
    - name: "data_quality_score_avg"
      expr: AVG(CAST(data_quality_score AS DOUBLE))
      comment: "Average MDM data quality score across customer accounts — a governance KPI that signals CRM/ERP data hygiene; low scores indicate risk of incorrect billing, shipping, or compliance failures."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`customer_credit_profile`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Credit risk and collections performance KPIs derived from customer credit profiles — used by CFO, credit managers, and AR teams to monitor exposure, overdue balances, and payment behaviour."
  source: "`vibe_manufacturing_v1`.`customer`.`credit_profile`"
  dimensions:
    - name: "credit_status"
      expr: credit_status
      comment: "Current credit status of the profile (Active, On Hold, Suspended, etc.) — primary axis for credit risk segmentation."
    - name: "credit_rating"
      expr: credit_rating
      comment: "Credit rating assigned to the customer — used to bucket accounts by risk tier for exposure reporting."
    - name: "credit_rating_agency"
      expr: credit_rating_agency
      comment: "Agency that issued the credit rating — used to compare internal vs. external rating sources."
    - name: "risk_category"
      expr: risk_category
      comment: "Internal risk category (Low, Medium, High, etc.) — used to prioritise collections and credit review actions."
    - name: "credit_hold_flag"
      expr: credit_hold_flag
      comment: "Boolean flag indicating the account is on credit hold — used to count and monitor accounts blocked from ordering."
    - name: "payment_method"
      expr: payment_method
      comment: "Preferred payment method of the customer — used to analyse payment behaviour patterns by method."
    - name: "payment_terms_code"
      expr: payment_terms_code
      comment: "Payment terms code (Net30, Net60, etc.) — used to segment DSO and overdue analysis by terms bucket."
    - name: "dunning_level"
      expr: dunning_level
      comment: "Current dunning escalation level — used to track collections escalation distribution across the portfolio."
    - name: "credit_segment"
      expr: credit_segment
      comment: "Credit segment classification — used to group accounts for targeted credit policy application."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the credit profile — used to segment exposure reporting by currency for FX risk management."
  measures:
    - name: "total_credit_limit"
      expr: SUM(CAST(credit_limit AS DOUBLE))
      comment: "Total approved credit limit across all credit profiles — measures aggregate credit exposure; a primary CFO and credit committee KPI."
    - name: "total_outstanding_balance"
      expr: SUM(CAST(outstanding_balance AS DOUBLE))
      comment: "Total outstanding AR balance across all customer credit profiles — measures how much of the credit portfolio is currently drawn; drives cash flow forecasting."
    - name: "total_overdue_amount"
      expr: SUM(CAST(overdue_amount AS DOUBLE))
      comment: "Total overdue AR amount across all profiles — a critical collections KPI; rising overdue signals deteriorating payment behaviour and cash flow risk."
    - name: "total_bad_debt_provision"
      expr: SUM(CAST(bad_debt_provision_amount AS DOUBLE))
      comment: "Total bad debt provision held against customer accounts — a key financial risk KPI reported to CFO and auditors; indicates expected credit losses."
    - name: "avg_dso_days"
      expr: AVG(CAST(dso_days AS DOUBLE))
      comment: "Average Days Sales Outstanding across all credit profiles — a primary working capital efficiency KPI; higher DSO signals slower collections and cash conversion risk."
    - name: "avg_credit_utilization_pct"
      expr: AVG(CAST(credit_utilization_pct AS DOUBLE))
      comment: "Average credit utilisation percentage across profiles — measures how much of approved credit is in use; high utilisation signals concentration risk and potential credit limit review need."
    - name: "accounts_on_credit_hold"
      expr: COUNT(CASE WHEN credit_hold_flag = TRUE THEN credit_profile_id END)
      comment: "Count of customer accounts currently on credit hold — an operational KPI for order management; high counts indicate revenue at risk from blocked orders."
    - name: "avg_payment_behavior_score"
      expr: AVG(CAST(payment_behavior_score AS DOUBLE))
      comment: "Average payment behaviour score across the portfolio — a predictive risk KPI; declining scores are an early warning of future overdue and bad debt."
    - name: "total_credit_insurance_coverage"
      expr: SUM(CAST(credit_insurance_coverage_limit AS DOUBLE))
      comment: "Total credit insurance coverage limit across all profiles — measures how much of the credit exposure is insured; used by risk and treasury teams to assess net uninsured exposure."
    - name: "avg_early_payment_discount_pct"
      expr: AVG(CAST(early_payment_discount_pct AS DOUBLE))
      comment: "Average early payment discount percentage offered — used by finance to evaluate the cost of early payment incentives vs. DSO improvement benefit."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`customer_lead`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Lead pipeline and conversion KPIs for the customer domain — used by sales leadership and marketing to track pipeline health, conversion rates, and deal value by segment and source."
  source: "`vibe_manufacturing_v1`.`customer`.`customer_lead`"
  dimensions:
    - name: "lead_status"
      expr: lead_status
      comment: "Current status of the lead (New, Working, Converted, Disqualified, etc.) — primary axis for pipeline stage analysis."
    - name: "lead_source"
      expr: lead_source
      comment: "Origin channel of the lead (Web, Event, Referral, etc.) — used to measure marketing channel effectiveness and ROI."
    - name: "lead_type"
      expr: lead_type
      comment: "Type classification of the lead — used to segment pipeline by lead category for targeted follow-up strategies."
    - name: "is_converted"
      expr: is_converted
      comment: "Boolean flag indicating whether the lead was converted to an account/opportunity — the primary conversion outcome dimension."
    - name: "sales_region"
      expr: sales_region
      comment: "Sales region associated with the lead — used to compare pipeline performance across geographic territories."
    - name: "company_industry"
      expr: company_industry
      comment: "Industry of the lead company — used to analyse lead quality and conversion rates by vertical market."
    - name: "company_size"
      expr: company_size
      comment: "Size band of the lead company (SMB, Mid-Market, Enterprise) — used to segment pipeline value and conversion rates by company size."
    - name: "grade"
      expr: grade
      comment: "Lead quality grade assigned by scoring model — used to prioritise sales follow-up and measure scoring model effectiveness."
    - name: "buying_stage"
      expr: buying_stage
      comment: "Stage in the buyer journey — used to align sales and marketing actions to where the prospect is in their decision process."
    - name: "product_interest_area"
      expr: product_interest_area
      comment: "Product area the lead has expressed interest in — used to route leads to the correct product sales team and measure product-level demand signals."
  measures:
    - name: "total_leads"
      expr: COUNT(1)
      comment: "Total count of leads in the pipeline — baseline volume KPI for marketing and sales pipeline reporting; used to track top-of-funnel health."
    - name: "converted_leads"
      expr: COUNT(CASE WHEN is_converted = TRUE THEN customer_lead_id END)
      comment: "Count of leads successfully converted to accounts or opportunities — numerator for lead conversion rate; a primary marketing effectiveness KPI."
    - name: "total_estimated_deal_value"
      expr: SUM(CAST(estimated_deal_value AS DOUBLE))
      comment: "Sum of estimated deal values across all leads — measures total pipeline value at the top of funnel; used by sales leadership for revenue forecasting and resource allocation."
    - name: "avg_estimated_deal_value"
      expr: AVG(CAST(estimated_deal_value AS DOUBLE))
      comment: "Average estimated deal value per lead — used to benchmark deal size by segment, region, or source and identify high-value lead cohorts."
    - name: "total_estimated_annual_revenue"
      expr: SUM(CAST(estimated_annual_revenue AS DOUBLE))
      comment: "Sum of estimated annual revenue from all leads — measures the total revenue potential in the lead pool; used for strategic market sizing and territory planning."
    - name: "avg_annual_energy_consumption_mwh"
      expr: AVG(CAST(annual_energy_consumption_mwh AS DOUBLE))
      comment: "Average annual energy consumption (MWh) of lead companies — a manufacturing-specific KPI used to qualify leads for energy-intensive automation and industrial solutions."
    - name: "disqualified_leads"
      expr: COUNT(CASE WHEN lead_status = 'Disqualified' THEN customer_lead_id END)
      comment: "Count of disqualified leads — used to measure pipeline quality and identify sources or segments generating low-quality leads requiring marketing strategy adjustment."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`customer_entitlement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Entitlement utilisation and coverage KPIs — used by service, sales, and customer success leadership to track contracted service consumption, renewal risk, and entitlement coverage gaps."
  source: "`vibe_manufacturing_v1`.`customer`.`customer_entitlement`"
  dimensions:
    - name: "customer_entitlement_status"
      expr: customer_entitlement_status
      comment: "Current status of the entitlement (Active, Expired, Pending Renewal, etc.) — primary axis for entitlement portfolio health reporting."
    - name: "entitlement_type"
      expr: entitlement_type
      comment: "Type of entitlement (Warranty, Service Contract, Software Subscription, etc.) — used to segment utilisation and renewal KPIs by entitlement category."
    - name: "coverage_type"
      expr: coverage_type
      comment: "Coverage type of the entitlement (Parts, Labour, Full Coverage, etc.) — used to analyse coverage mix and upsell opportunities."
    - name: "sla_tier"
      expr: sla_tier
      comment: "SLA tier associated with the entitlement — used to segment service performance and renewal rates by tier."
    - name: "is_active"
      expr: is_active
      comment: "Boolean flag indicating whether the entitlement is currently active — used to filter active vs. lapsed entitlement KPIs."
    - name: "is_perpetual"
      expr: is_perpetual
      comment: "Boolean flag indicating a perpetual (non-expiring) entitlement — used to separate recurring renewal revenue from perpetual entitlements in forecasting."
    - name: "auto_renew"
      expr: auto_renew
      comment: "Boolean flag indicating automatic renewal — used to segment renewal risk between auto-renew and manual-renew entitlements."
    - name: "country_code"
      expr: country_code
      comment: "Country associated with the entitlement — used for geographic analysis of entitlement coverage and renewal performance."
    - name: "business_unit"
      expr: business_unit
      comment: "Business unit responsible for the entitlement — used to allocate service revenue and utilisation KPIs to organisational units."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the entitlement value — used for multi-currency contracted value reporting."
  measures:
    - name: "total_active_entitlements"
      expr: COUNT(CASE WHEN is_active = TRUE THEN customer_entitlement_id END)
      comment: "Count of currently active entitlements — baseline KPI for the installed base under contract; used by service leadership to track coverage breadth."
    - name: "total_contracted_value"
      expr: SUM(CAST(contracted_value AS DOUBLE))
      comment: "Total contracted value across all entitlements — measures the total service revenue under contract; a primary KPI for service P&L and renewal forecasting."
    - name: "avg_contracted_value"
      expr: AVG(CAST(contracted_value AS DOUBLE))
      comment: "Average contracted value per entitlement — used to benchmark entitlement deal size and identify upsell opportunities in below-average accounts."
    - name: "total_consumed_quantity"
      expr: SUM(CAST(consumed_quantity AS DOUBLE))
      comment: "Total quantity consumed across all entitlements — measures aggregate service consumption; used to assess capacity planning and over/under-utilisation."
    - name: "total_remaining_quantity"
      expr: SUM(CAST(remaining_quantity AS DOUBLE))
      comment: "Total remaining entitlement quantity across all active entitlements — measures unused contracted capacity; high remaining quantity signals under-utilisation and renewal risk."
    - name: "total_service_hours_allocation"
      expr: SUM(CAST(service_hours_allocation AS DOUBLE))
      comment: "Total service hours allocated across all entitlements — used by field service operations to plan engineer capacity against contracted commitments."
    - name: "total_service_hours_consumed"
      expr: SUM(CAST(service_hours_consumed AS DOUBLE))
      comment: "Total service hours consumed across all entitlements — paired with allocation to compute utilisation rate; low consumption signals renewal risk."
    - name: "avg_response_time_hours"
      expr: AVG(CAST(response_time_hours AS DOUBLE))
      comment: "Average contracted response time (hours) across entitlements — used to benchmark SLA commitments and assess service tier distribution."
    - name: "avg_resolution_time_hours"
      expr: AVG(CAST(resolution_time_hours AS DOUBLE))
      comment: "Average contracted resolution time (hours) across entitlements — used alongside actual resolution times to measure SLA compliance and service quality."
    - name: "total_spare_parts_credit_limit"
      expr: SUM(CAST(spare_parts_credit_limit AS DOUBLE))
      comment: "Total spare parts credit limit across all entitlements — measures the aggregate parts budget committed to customers; used by supply chain and service parts planning."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`customer_sla_agreement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "SLA agreement portfolio KPIs — used by service leadership and customer success to track contracted SLA commitments, annual fee revenue, and agreement health across the customer base."
  source: "`vibe_manufacturing_v1`.`customer`.`sla_agreement`"
  dimensions:
    - name: "agreement_status"
      expr: agreement_status
      comment: "Current status of the SLA agreement (Active, Expired, Pending, etc.) — primary axis for agreement portfolio health reporting."
    - name: "sla_type"
      expr: sla_type
      comment: "Type of SLA agreement (Response, Resolution, Uptime, etc.) — used to segment KPIs by commitment type."
    - name: "service_tier"
      expr: service_tier
      comment: "Service tier of the agreement (Gold, Silver, Bronze, etc.) — used to analyse revenue and performance by tier."
    - name: "auto_renewal"
      expr: auto_renewal
      comment: "Boolean flag indicating automatic renewal — used to segment renewal risk between auto and manual renewal agreements."
    - name: "billing_frequency"
      expr: billing_frequency
      comment: "Billing frequency of the agreement (Monthly, Quarterly, Annual) — used for revenue recognition and cash flow forecasting."
    - name: "service_region"
      expr: service_region
      comment: "Geographic service region covered by the agreement — used to analyse SLA portfolio distribution and service capacity by region."
    - name: "field_service_included"
      expr: field_service_included
      comment: "Boolean flag indicating whether field service is included — used to segment agreements by service scope and plan field engineer capacity."
    - name: "preventive_maintenance_included"
      expr: preventive_maintenance_included
      comment: "Boolean flag indicating whether preventive maintenance is included — used to plan PM visit capacity and track PM coverage rates."
    - name: "penalty_clause_applicable"
      expr: penalty_clause_applicable
      comment: "Boolean flag indicating whether a penalty clause applies — used to identify high-risk agreements where SLA breaches have financial consequences."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the SLA agreement — used for multi-currency revenue reporting and FX exposure analysis."
  measures:
    - name: "total_active_agreements"
      expr: COUNT(CASE WHEN agreement_status = 'Active' THEN sla_agreement_id END)
      comment: "Count of active SLA agreements — baseline KPI for the contracted service portfolio; used by service leadership to track coverage breadth and renewal pipeline."
    - name: "total_annual_fee_revenue"
      expr: SUM(CAST(annual_fee AS DOUBLE))
      comment: "Total annual fee revenue across all SLA agreements — a primary service P&L KPI; used by CFO and service leadership for revenue forecasting and budget planning."
    - name: "avg_annual_fee"
      expr: AVG(CAST(annual_fee AS DOUBLE))
      comment: "Average annual fee per SLA agreement — used to benchmark agreement value by tier and identify pricing optimisation opportunities."
    - name: "total_contract_value"
      expr: SUM(CAST(contract_value AS DOUBLE))
      comment: "Total contract value across all SLA agreements — measures total committed service revenue; used for backlog reporting and long-range financial planning."
    - name: "avg_uptime_target_pct"
      expr: AVG(CAST(uptime_target_pct AS DOUBLE))
      comment: "Average contracted uptime target percentage — used to benchmark the stringency of SLA commitments and assess operational risk from high-uptime agreements."
    - name: "avg_initial_response_time_hours"
      expr: AVG(CAST(initial_response_time_hours AS DOUBLE))
      comment: "Average contracted initial response time (hours) — used to benchmark SLA commitment levels and plan service desk staffing."
    - name: "avg_resolution_time_hours"
      expr: AVG(CAST(resolution_time_hours AS DOUBLE))
      comment: "Average contracted resolution time (hours) — used to assess the operational burden of resolution commitments and plan field service capacity."
    - name: "agreements_with_penalty_clause"
      expr: COUNT(CASE WHEN penalty_clause_applicable = TRUE THEN sla_agreement_id END)
      comment: "Count of agreements with active penalty clauses — measures financial risk exposure from SLA breach penalties; used by service operations to prioritise high-risk accounts."
    - name: "avg_on_time_delivery_target_pct"
      expr: AVG(CAST(on_time_delivery_target_pct AS DOUBLE))
      comment: "Average on-time delivery target percentage across SLA agreements — used to benchmark delivery commitments and align supply chain planning to contractual obligations."
    - name: "avg_penalty_credit_pct"
      expr: AVG(CAST(penalty_credit_pct AS DOUBLE))
      comment: "Average penalty credit percentage across agreements with penalty clauses — used to estimate the financial exposure per SLA breach event for risk provisioning."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`customer_onboarding`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Customer onboarding efficiency and completion KPIs — used by sales operations and customer success leadership to track onboarding cycle times, completion rates, and blockers that delay first-order readiness."
  source: "`vibe_manufacturing_v1`.`customer`.`customer_onboarding`"
  dimensions:
    - name: "onboarding_status"
      expr: onboarding_status
      comment: "Current status of the onboarding process (In Progress, Completed, Blocked, Cancelled) — primary axis for onboarding pipeline health reporting."
    - name: "stage"
      expr: stage
      comment: "Current stage in the onboarding workflow — used to identify where onboardings are stalling and measure stage-level throughput."
    - name: "account_type"
      expr: account_type
      comment: "Type of customer account being onboarded — used to segment onboarding KPIs by account category."
    - name: "account_segment"
      expr: account_segment
      comment: "Customer segment of the account being onboarded — used to compare onboarding performance across strategic, commercial, and SMB segments."
    - name: "assigned_sales_region"
      expr: assigned_sales_region
      comment: "Sales region responsible for the onboarding — used to identify regional performance gaps in onboarding execution."
    - name: "industry_vertical"
      expr: industry_vertical
      comment: "Industry vertical of the customer being onboarded — used to analyse onboarding complexity and duration by industry."
    - name: "sla_breach_flag"
      expr: sla_breach_flag
      comment: "Boolean flag indicating the onboarding breached its SLA target — used to measure onboarding SLA compliance and identify systemic delays."
    - name: "escalation_flag"
      expr: escalation_flag
      comment: "Boolean flag indicating the onboarding was escalated — used to track escalation rates and identify process bottlenecks."
    - name: "first_order_readiness_flag"
      expr: first_order_readiness_flag
      comment: "Boolean flag indicating the customer is ready to place their first order — the primary completion milestone KPI for onboarding."
    - name: "blocker_category"
      expr: blocker_category
      comment: "Category of the blocker delaying onboarding (Credit, Legal, IT, etc.) — used to identify and resolve systemic onboarding impediments."
  measures:
    - name: "total_onboardings"
      expr: COUNT(1)
      comment: "Total count of customer onboarding records — baseline volume KPI for onboarding pipeline capacity and throughput reporting."
    - name: "completed_onboardings"
      expr: COUNT(CASE WHEN onboarding_status = 'Completed' THEN customer_onboarding_id END)
      comment: "Count of successfully completed onboardings — numerator for onboarding completion rate; a primary customer success KPI."
    - name: "sla_breached_onboardings"
      expr: COUNT(CASE WHEN sla_breach_flag = TRUE THEN customer_onboarding_id END)
      comment: "Count of onboardings that breached their SLA target — measures onboarding process quality; high counts signal resource or process issues delaying revenue realisation."
    - name: "escalated_onboardings"
      expr: COUNT(CASE WHEN escalation_flag = TRUE THEN customer_onboarding_id END)
      comment: "Count of onboardings requiring escalation — measures onboarding complexity and exception handling load; used to identify accounts needing additional support resources."
    - name: "first_order_ready_count"
      expr: COUNT(CASE WHEN first_order_readiness_flag = TRUE THEN customer_onboarding_id END)
      comment: "Count of onboardings where the customer has reached first-order readiness — the primary milestone KPI for onboarding success; directly linked to revenue activation."
    - name: "avg_checklist_completion_pct"
      expr: AVG(CAST(checklist_completion_pct AS DOUBLE))
      comment: "Average checklist completion percentage across all active onboardings — measures overall onboarding progress; used to identify cohorts at risk of stalling before completion."
    - name: "avg_credit_limit_approved"
      expr: AVG(CAST(credit_limit_approved AS DOUBLE))
      comment: "Average credit limit approved during onboarding — used to benchmark credit decisions by segment and region; informs credit policy calibration for new customer acquisition."
    - name: "total_credit_limit_approved"
      expr: SUM(CAST(credit_limit_approved AS DOUBLE))
      comment: "Total credit limit approved across all onboarded customers — measures aggregate new credit exposure created through onboarding; a key risk management KPI for the credit committee."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`customer_interaction`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Customer interaction and engagement KPIs — used by customer success, sales, and service leadership to track engagement frequency, satisfaction, and follow-up compliance across the customer base."
  source: "`vibe_manufacturing_v1`.`customer`.`interaction`"
  dimensions:
    - name: "interaction_type"
      expr: interaction_type
      comment: "Type of customer interaction (Call, Meeting, Email, Site Visit, etc.) — used to analyse engagement channel mix and effectiveness."
    - name: "interaction_status"
      expr: interaction_status
      comment: "Status of the interaction (Completed, Scheduled, Cancelled, etc.) — used to track interaction pipeline and completion rates."
    - name: "channel"
      expr: channel
      comment: "Communication channel used for the interaction — used to measure channel preference and effectiveness across the customer base."
    - name: "outcome"
      expr: outcome
      comment: "Business outcome of the interaction (Positive, Neutral, Negative, Escalated) — used to measure interaction quality and identify at-risk accounts."
    - name: "sentiment_category"
      expr: sentiment_category
      comment: "Sentiment classification of the interaction — used to track customer health trends and identify accounts requiring proactive intervention."
    - name: "is_customer_complaint"
      expr: is_customer_complaint
      comment: "Boolean flag indicating the interaction was a customer complaint — used to track complaint volume and escalation rates."
    - name: "follow_up_required"
      expr: follow_up_required
      comment: "Boolean flag indicating a follow-up action is required — used to measure open follow-up backlog and compliance with follow-up commitments."
    - name: "priority"
      expr: priority
      comment: "Priority level of the interaction — used to segment high-priority interactions for executive attention and SLA tracking."
    - name: "country_code"
      expr: country_code
      comment: "Country where the interaction occurred — used for geographic analysis of customer engagement patterns."
    - name: "product_line"
      expr: product_line
      comment: "Product line discussed in the interaction — used to identify product-specific engagement trends and support demand signals."
  measures:
    - name: "total_interactions"
      expr: COUNT(1)
      comment: "Total count of customer interactions — baseline engagement volume KPI; used to track customer touchpoint frequency and sales/service activity levels."
    - name: "complaint_interactions"
      expr: COUNT(CASE WHEN is_customer_complaint = TRUE THEN interaction_id END)
      comment: "Count of interactions flagged as customer complaints — a primary customer satisfaction KPI; rising complaint counts signal product, service, or relationship issues requiring executive action."
    - name: "open_follow_up_count"
      expr: COUNT(CASE WHEN follow_up_required = TRUE THEN interaction_id END)
      comment: "Count of interactions with open follow-up actions required — measures the backlog of unresolved customer commitments; high counts indicate risk of customer dissatisfaction."
    - name: "unique_customers_engaged"
      expr: COUNT(DISTINCT customer_account_id)
      comment: "Count of distinct customer accounts with at least one interaction — measures breadth of customer engagement; used to identify accounts with no recent touchpoints (at-risk accounts)."
    - name: "executive_sponsor_interactions"
      expr: COUNT(CASE WHEN is_executive_sponsor_involved = TRUE THEN interaction_id END)
      comment: "Count of interactions involving an executive sponsor — measures executive engagement investment in strategic accounts; used to track executive relationship programme activity."
    - name: "avg_satisfaction_rating"
      expr: AVG(CAST(satisfaction_rating AS DOUBLE))
      comment: "Average customer satisfaction rating across all rated interactions — a primary customer experience KPI; declining scores are an early warning of churn risk and require leadership intervention."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`customer_account_hierarchy`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Customer account hierarchy and consolidation KPIs — used by global account management, finance, and sales leadership to understand account structure, ownership concentration, and rollup eligibility."
  source: "`vibe_manufacturing_v1`.`customer`.`account_hierarchy`"
  dimensions:
    - name: "hierarchy_status"
      expr: hierarchy_status
      comment: "Current status of the hierarchy record (Active, Inactive, Pending) — used to filter active hierarchy structures for consolidation reporting."
    - name: "hierarchy_category"
      expr: hierarchy_category
      comment: "Category of the hierarchy (Legal, Commercial, Operational) — used to segment hierarchy KPIs by structural purpose."
    - name: "hierarchy_level"
      expr: hierarchy_level
      comment: "Level within the hierarchy tree — used to analyse account concentration at each tier of the corporate structure."
    - name: "account_tier"
      expr: account_tier
      comment: "Tier classification of the account within the hierarchy — used to segment strategic vs. standard accounts in consolidation reporting."
    - name: "geographic_scope"
      expr: geographic_scope
      comment: "Geographic scope of the hierarchy (Global, Regional, Local) — used to segment global vs. regional account structures."
    - name: "industry_segment"
      expr: industry_segment
      comment: "Industry segment of the hierarchy — used to analyse account concentration by vertical market."
    - name: "revenue_rollup_eligible"
      expr: revenue_rollup_eligible
      comment: "Boolean flag indicating whether revenue rolls up through this hierarchy node — used to identify accounts included in consolidated revenue reporting."
    - name: "credit_rollup_eligible"
      expr: credit_rollup_eligible
      comment: "Boolean flag indicating whether credit rolls up through this hierarchy node — used to manage group-level credit exposure."
    - name: "relationship_type"
      expr: relationship_type
      comment: "Type of relationship in the hierarchy (Parent-Child, Affiliate, etc.) — used to classify hierarchy structures for legal and commercial analysis."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the hierarchy record — used to track pending vs. approved hierarchy changes for governance reporting."
  measures:
    - name: "total_hierarchy_nodes"
      expr: COUNT(1)
      comment: "Total count of account hierarchy nodes — measures the complexity and breadth of the customer account structure; used by global account management to assess portfolio organisation."
    - name: "avg_ownership_percentage"
      expr: AVG(CAST(ownership_percentage AS DOUBLE))
      comment: "Average ownership percentage across hierarchy relationships — used to assess controlling interest concentration and identify majority-owned vs. minority-owned account relationships."
    - name: "revenue_rollup_eligible_nodes"
      expr: COUNT(CASE WHEN revenue_rollup_eligible = TRUE THEN account_hierarchy_id END)
      comment: "Count of hierarchy nodes eligible for revenue rollup — measures the scope of consolidated revenue reporting; used by finance to validate group revenue consolidation coverage."
    - name: "credit_rollup_eligible_nodes"
      expr: COUNT(CASE WHEN credit_rollup_eligible = TRUE THEN account_hierarchy_id END)
      comment: "Count of hierarchy nodes eligible for credit rollup — measures the scope of group-level credit exposure management; used by credit teams to ensure consolidated credit limits are applied."
    - name: "avg_data_quality_score"
      expr: AVG(CAST(data_quality_score AS DOUBLE))
      comment: "Average data quality score across hierarchy records — a governance KPI measuring the reliability of the account hierarchy for consolidation; low scores indicate MDM issues that could distort group reporting."
    - name: "controlling_interest_nodes"
      expr: COUNT(CASE WHEN controlling_interest = TRUE THEN account_hierarchy_id END)
      comment: "Count of hierarchy nodes where controlling interest is held — used by legal and finance to identify entities requiring full consolidation under accounting standards."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`customer_certification`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Customer certification compliance KPIs — used by quality, compliance, and sales leadership to track certification coverage, expiry risk, and audit findings across the customer base."
  source: "`vibe_manufacturing_v1`.`customer`.`customer_certification`"
  dimensions:
    - name: "certification_status"
      expr: certification_status
      comment: "Current status of the certification (Active, Expired, Suspended, Pending Renewal) — primary axis for certification portfolio health reporting."
    - name: "certification_type"
      expr: certification_type
      comment: "Type of certification (ISO 9001, ISO 14001, IATF 16949, etc.) — used to analyse certification coverage by standard."
    - name: "standard"
      expr: standard
      comment: "Specific standard the certification is issued against — used to track compliance coverage by regulatory or industry standard."
    - name: "country"
      expr: country
      comment: "Country where the certification was issued — used for geographic compliance coverage analysis."
    - name: "capa_required"
      expr: capa_required
      comment: "Boolean flag indicating a corrective action is required — used to track the volume of certifications with open CAPA obligations."
    - name: "is_primary_certification"
      expr: is_primary_certification
      comment: "Boolean flag indicating this is the primary certification for the customer — used to focus KPIs on the most critical certification per account."
    - name: "renewal_status"
      expr: renewal_status
      comment: "Renewal status of the certification — used to track the renewal pipeline and identify certifications at risk of lapsing."
    - name: "is_multi_site"
      expr: is_multi_site
      comment: "Boolean flag indicating the certification covers multiple sites — used to assess the scope of multi-site certifications in the portfolio."
  measures:
    - name: "total_certifications"
      expr: COUNT(1)
      comment: "Total count of customer certifications — baseline KPI for certification portfolio coverage; used by quality and compliance teams to track the breadth of certified customers."
    - name: "active_certifications"
      expr: COUNT(CASE WHEN certification_status = 'Active' THEN customer_certification_id END)
      comment: "Count of currently active certifications — measures the proportion of the customer base with valid certifications; used to assess compliance risk in the supply and sales base."
    - name: "certifications_requiring_capa"
      expr: COUNT(CASE WHEN capa_required = TRUE THEN customer_certification_id END)
      comment: "Count of certifications with open CAPA requirements — measures the volume of compliance remediation actions outstanding; used by quality leadership to prioritise audit follow-up."
    - name: "unique_certified_customers"
      expr: COUNT(DISTINCT customer_account_id)
      comment: "Count of distinct customer accounts with at least one certification — measures the breadth of certified customer coverage; used to track qualification programme reach."
$$;