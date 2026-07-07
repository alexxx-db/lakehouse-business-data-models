-- Metric views for domain: customer | Business: Manufacturing | Version: 2 | Generated on: 2026-07-03 05:35:52

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`customer_account`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPIs over the customer account master — tracks portfolio health, revenue potential, credit exposure, and account lifecycle for executive steering."
  source: "`vibe_manufacturing_v1`.`customer`.`customer_account`"
  dimensions:
    - name: "account_type"
      expr: account_type
      comment: "Type of customer account (e.g. Direct, Distributor, OEM) for portfolio segmentation."
    - name: "account_status"
      expr: account_status
      comment: "Current lifecycle status of the account (Active, Inactive, Suspended) for health monitoring."
    - name: "sla_tier"
      expr: sla_tier
      comment: "SLA tier assigned to the account, used to segment service commitment levels."
    - name: "industry_naics_code"
      expr: industry_naics_code
      comment: "NAICS industry classification for vertical market analysis."
    - name: "sales_organization_code"
      expr: sales_organization_code
      comment: "Sales org responsible for the account, enabling regional and org-level performance views."
    - name: "distribution_channel_code"
      expr: distribution_channel_code
      comment: "Channel through which the customer is served (Direct, Indirect, eCommerce)."
    - name: "is_strategic_account"
      expr: is_strategic_account
      comment: "Flag indicating whether the account is classified as strategic, for executive focus."
    - name: "is_global_account"
      expr: is_global_account
      comment: "Flag indicating global account status, relevant for global account management programs."
    - name: "account_source"
      expr: account_source
      comment: "Origin of the account record (CRM, ERP, Manual) for data quality and channel attribution."
    - name: "open_date_month"
      expr: DATE_TRUNC('MONTH', open_date)
      comment: "Month the account was opened, for cohort and acquisition trend analysis."
    - name: "close_date_month"
      expr: DATE_TRUNC('MONTH', close_date)
      comment: "Month the account was closed, for churn trend analysis."
  measures:
    - name: "total_active_accounts"
      expr: COUNT(DISTINCT CASE WHEN account_status = 'Active' THEN customer_account_id END)
      comment: "Count of distinct active customer accounts — primary portfolio size KPI for executive dashboards."
    - name: "total_accounts"
      expr: COUNT(DISTINCT customer_account_id)
      comment: "Total count of all customer accounts regardless of status, for portfolio breadth tracking."
    - name: "total_annual_revenue"
      expr: SUM(CAST(annual_revenue AS DOUBLE))
      comment: "Sum of annual revenue across all customer accounts — top-line revenue potential indicator."
    - name: "avg_annual_revenue_per_account"
      expr: AVG(CAST(annual_revenue AS DOUBLE))
      comment: "Average annual revenue per customer account — used to assess account value and prioritize coverage."
    - name: "total_credit_limit_exposure"
      expr: SUM(CAST(credit_limit AS DOUBLE))
      comment: "Total credit limit extended across all accounts — key risk management metric for CFO and credit teams."
    - name: "avg_credit_limit_per_account"
      expr: AVG(CAST(credit_limit AS DOUBLE))
      comment: "Average credit limit per account — benchmarks credit policy consistency across the portfolio."
    - name: "strategic_account_count"
      expr: COUNT(DISTINCT CASE WHEN is_strategic_account = TRUE THEN customer_account_id END)
      comment: "Number of accounts flagged as strategic — used to track strategic account program coverage."
    - name: "global_account_count"
      expr: COUNT(DISTINCT CASE WHEN is_global_account = TRUE THEN customer_account_id END)
      comment: "Number of global accounts — supports global account management program sizing and investment decisions."
    - name: "avg_data_quality_score"
      expr: AVG(CAST(data_quality_score AS DOUBLE))
      comment: "Average MDM data quality score across accounts — drives data governance investment and CRM hygiene programs."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`customer_credit_profile`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Credit risk and collections performance KPIs derived from customer credit profiles — supports CFO, credit managers, and AR teams in managing financial exposure."
  source: "`vibe_manufacturing_v1`.`customer`.`credit_profile`"
  dimensions:
    - name: "risk_category"
      expr: risk_category
      comment: "Credit risk category (Low, Medium, High) for portfolio risk segmentation."
    - name: "dunning_level"
      expr: dunning_level
      comment: "Current dunning level indicating collections escalation stage."
    - name: "credit_hold_flag"
      expr: credit_hold_flag
      comment: "Whether the account is currently on credit hold — critical operational flag for order management."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the credit profile for multi-currency portfolio analysis."
    - name: "effective_date_month"
      expr: DATE_TRUNC('MONTH', effective_date)
      comment: "Month the credit profile became effective, for trend analysis of credit policy changes."
    - name: "last_credit_review_date_month"
      expr: DATE_TRUNC('MONTH', last_credit_review_date)
      comment: "Month of last credit review, for identifying stale credit assessments."
  measures:
    - name: "total_credit_limit"
      expr: SUM(CAST(credit_limit AS DOUBLE))
      comment: "Total credit limit extended across all credit profiles — aggregate financial exposure for risk management."
    - name: "total_outstanding_balance"
      expr: SUM(CAST(outstanding_balance AS DOUBLE))
      comment: "Total outstanding balance across all accounts — key AR and collections performance indicator."
    - name: "total_overdue_amount"
      expr: SUM(CAST(overdue_amount AS DOUBLE))
      comment: "Total overdue amount across the portfolio — primary collections risk metric for CFO and credit teams."
    - name: "avg_credit_utilization_pct"
      expr: AVG(CAST(credit_utilization_pct AS DOUBLE))
      comment: "Average credit utilization percentage — indicates how much of the extended credit is being used; high utilization signals risk."
    - name: "avg_dso_days"
      expr: AVG(CAST(dso_days AS DOUBLE))
      comment: "Average Days Sales Outstanding across the portfolio — core AR efficiency KPI tracked at board level."
    - name: "avg_payment_behavior_score"
      expr: AVG(CAST(payment_behavior_score AS DOUBLE))
      comment: "Average payment behavior score — predictive indicator of future payment risk used in credit decisioning."
    - name: "accounts_on_credit_hold"
      expr: COUNT(DISTINCT CASE WHEN credit_hold_flag = TRUE THEN credit_profile_id END)
      comment: "Number of accounts currently on credit hold — operational risk indicator that directly impacts order fulfillment."
    - name: "total_bad_debt_provision"
      expr: SUM(CAST(bad_debt_provision_amount AS DOUBLE))
      comment: "Total bad debt provision amount — financial reserve metric reported in P&L and balance sheet reviews."
    - name: "total_credit_insurance_coverage"
      expr: SUM(CAST(credit_insurance_coverage_limit AS DOUBLE))
      comment: "Total credit insurance coverage limit — measures the portion of credit risk that is externally hedged."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`customer_lead`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Lead pipeline and conversion KPIs for the customer domain — tracks lead volume, quality, and conversion performance to support sales and marketing investment decisions."
  source: "`vibe_manufacturing_v1`.`customer`.`customer_lead`"
  dimensions:
    - name: "lead_status"
      expr: lead_status
      comment: "Current status of the lead (New, Working, Converted, Disqualified) for pipeline stage analysis."
    - name: "lead_source"
      expr: lead_source
      comment: "Origin channel of the lead (Web, Event, Referral, etc.) for marketing attribution."
    - name: "lead_type"
      expr: lead_type
      comment: "Classification of the lead type for segmentation and routing analysis."
    - name: "grade"
      expr: grade
      comment: "Lead quality grade assigned by scoring model — used to prioritize sales follow-up."
    - name: "company_industry"
      expr: company_industry
      comment: "Industry of the lead's company for vertical market pipeline analysis."
    - name: "sales_region"
      expr: sales_region
      comment: "Sales region associated with the lead for regional pipeline performance tracking."
    - name: "is_converted"
      expr: is_converted
      comment: "Whether the lead has been converted to an account/opportunity — primary conversion flag."
    - name: "created_month"
      expr: DATE_TRUNC('MONTH', created_timestamp)
      comment: "Month the lead was created, for lead volume trend and cohort analysis."
    - name: "conversion_month"
      expr: DATE_TRUNC('MONTH', conversion_date)
      comment: "Month the lead was converted, for conversion velocity and funnel timing analysis."
    - name: "buying_stage"
      expr: buying_stage
      comment: "Buyer journey stage of the lead for demand generation funnel analysis."
  measures:
    - name: "total_leads"
      expr: COUNT(DISTINCT customer_lead_id)
      comment: "Total number of leads in the pipeline — primary demand generation volume KPI."
    - name: "converted_leads"
      expr: COUNT(DISTINCT CASE WHEN is_converted = TRUE THEN customer_lead_id END)
      comment: "Number of leads successfully converted to accounts or opportunities — core sales effectiveness metric."
    - name: "total_estimated_deal_value"
      expr: SUM(CAST(estimated_deal_value AS DOUBLE))
      comment: "Sum of estimated deal values across all leads — pipeline value indicator for revenue forecasting."
    - name: "avg_estimated_deal_value"
      expr: AVG(CAST(estimated_deal_value AS DOUBLE))
      comment: "Average estimated deal value per lead — used to assess lead quality and prioritize sales effort."
    - name: "total_estimated_annual_revenue"
      expr: SUM(CAST(estimated_annual_revenue AS DOUBLE))
      comment: "Total estimated annual revenue potential from all leads — strategic pipeline sizing metric."
    - name: "avg_annual_energy_consumption_mwh"
      expr: AVG(CAST(annual_energy_consumption_mwh AS DOUBLE))
      comment: "Average annual energy consumption (MWh) of lead companies — relevant for industrial/manufacturing solution sizing and targeting."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`customer_sla_agreement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "SLA portfolio and financial KPIs — tracks SLA coverage, contract value, service commitments, and renewal risk to support service operations and customer success leadership."
  source: "`vibe_manufacturing_v1`.`customer`.`sla_agreement`"
  dimensions:
    - name: "agreement_status"
      expr: agreement_status
      comment: "Current status of the SLA agreement (Active, Expired, Pending Renewal) for portfolio health monitoring."
    - name: "sla_type"
      expr: sla_type
      comment: "Type of SLA (Response, Resolution, Uptime) for service commitment categorization."
    - name: "service_tier"
      expr: service_tier
      comment: "Service tier level (Gold, Silver, Bronze) for tiered service performance analysis."
    - name: "billing_frequency"
      expr: billing_frequency
      comment: "Billing frequency of the SLA agreement for revenue recognition and cash flow planning."
    - name: "auto_renewal"
      expr: auto_renewal
      comment: "Whether the agreement auto-renews — critical for revenue retention forecasting."
    - name: "field_service_included"
      expr: field_service_included
      comment: "Whether field service is included in the SLA — used to plan field service resource capacity."
    - name: "preventive_maintenance_included"
      expr: preventive_maintenance_included
      comment: "Whether preventive maintenance is included — drives maintenance scheduling and resource planning."
    - name: "effective_date_month"
      expr: DATE_TRUNC('MONTH', effective_date)
      comment: "Month the SLA became effective, for contract inception trend analysis."
    - name: "expiry_date_month"
      expr: DATE_TRUNC('MONTH', expiry_date)
      comment: "Month the SLA expires, for renewal pipeline and at-risk contract identification."
    - name: "service_region"
      expr: service_region
      comment: "Geographic region covered by the SLA for regional service capacity planning."
  measures:
    - name: "total_active_sla_agreements"
      expr: COUNT(DISTINCT CASE WHEN agreement_status = 'Active' THEN sla_agreement_id END)
      comment: "Number of active SLA agreements — primary service contract portfolio size metric."
    - name: "total_contract_value"
      expr: SUM(CAST(contract_value AS DOUBLE))
      comment: "Total contracted value across all SLA agreements — top-line service revenue metric for executive reporting."
    - name: "total_annual_fee"
      expr: SUM(CAST(annual_fee AS DOUBLE))
      comment: "Total annual fee revenue from SLA agreements — recurring revenue baseline for service business P&L."
    - name: "avg_annual_fee"
      expr: AVG(CAST(annual_fee AS DOUBLE))
      comment: "Average annual fee per SLA agreement — benchmarks contract value and pricing consistency."
    - name: "avg_uptime_target_pct"
      expr: AVG(CAST(uptime_target_pct AS DOUBLE))
      comment: "Average uptime commitment across SLA agreements — indicates overall service obligation level and risk exposure."
    - name: "avg_initial_response_time_hours"
      expr: AVG(CAST(initial_response_time_hours AS DOUBLE))
      comment: "Average initial response time commitment (hours) — key service quality benchmark for customer satisfaction."
    - name: "avg_resolution_time_hours"
      expr: AVG(CAST(resolution_time_hours AS DOUBLE))
      comment: "Average resolution time commitment (hours) — measures stringency of service obligations across the portfolio."
    - name: "auto_renewal_agreement_count"
      expr: COUNT(DISTINCT CASE WHEN auto_renewal = TRUE THEN sla_agreement_id END)
      comment: "Number of SLA agreements set to auto-renew — measures revenue retention risk and renewal pipeline certainty."
    - name: "avg_on_time_delivery_target_pct"
      expr: AVG(CAST(on_time_delivery_target_pct AS DOUBLE))
      comment: "Average on-time delivery target percentage committed in SLAs — links service contracts to supply chain performance obligations."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`customer_entitlement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Entitlement utilization and value KPIs — tracks how customers consume contracted entitlements, enabling service operations to identify under-utilized or over-consumed entitlements and manage renewal risk."
  source: "`vibe_manufacturing_v1`.`customer`.`customer_entitlement`"
  dimensions:
    - name: "entitlement_type"
      expr: entitlement_type
      comment: "Type of entitlement (Warranty, Service Hours, Parts Credit, etc.) for utilization analysis by category."
    - name: "customer_entitlement_status"
      expr: customer_entitlement_status
      comment: "Current status of the entitlement (Active, Expired, Consumed) for portfolio health monitoring."
    - name: "coverage_type"
      expr: coverage_type
      comment: "Coverage type of the entitlement for service scope analysis."
    - name: "sla_tier"
      expr: sla_tier
      comment: "SLA tier associated with the entitlement for tiered service analysis."
    - name: "is_active"
      expr: is_active
      comment: "Whether the entitlement is currently active — primary filter for operational entitlement management."
    - name: "is_perpetual"
      expr: is_perpetual
      comment: "Whether the entitlement is perpetual (no expiry) — relevant for revenue recognition and renewal forecasting."
    - name: "auto_renew"
      expr: auto_renew
      comment: "Whether the entitlement auto-renews — critical for recurring revenue retention planning."
    - name: "start_date_month"
      expr: DATE_TRUNC('MONTH', start_date)
      comment: "Month the entitlement started, for cohort-based utilization analysis."
    - name: "end_date_month"
      expr: DATE_TRUNC('MONTH', end_date)
      comment: "Month the entitlement ends, for renewal pipeline and at-risk entitlement identification."
    - name: "geography_region"
      expr: geography_region
      comment: "Geographic region of the entitlement for regional service capacity planning."
  measures:
    - name: "total_active_entitlements"
      expr: COUNT(DISTINCT CASE WHEN is_active = TRUE THEN customer_entitlement_id END)
      comment: "Number of active customer entitlements — primary service coverage portfolio size metric."
    - name: "total_contracted_value"
      expr: SUM(CAST(contracted_value AS DOUBLE))
      comment: "Total contracted value across all entitlements — service revenue backlog metric for executive reporting."
    - name: "total_consumed_quantity"
      expr: SUM(CAST(consumed_quantity AS DOUBLE))
      comment: "Total quantity consumed across all entitlements — measures actual service utilization against contracted capacity."
    - name: "total_remaining_quantity"
      expr: SUM(CAST(remaining_quantity AS DOUBLE))
      comment: "Total remaining entitlement quantity — indicates unused service capacity and renewal upsell opportunity."
    - name: "total_service_hours_allocation"
      expr: SUM(CAST(service_hours_allocation AS DOUBLE))
      comment: "Total service hours allocated across all entitlements — capacity planning metric for service operations."
    - name: "total_service_hours_consumed"
      expr: SUM(CAST(service_hours_consumed AS DOUBLE))
      comment: "Total service hours consumed — measures actual service delivery against contracted hours for margin analysis."
    - name: "avg_response_time_hours"
      expr: AVG(CAST(response_time_hours AS DOUBLE))
      comment: "Average contracted response time (hours) across entitlements — benchmarks service obligation stringency."
    - name: "total_spare_parts_credit_limit"
      expr: SUM(CAST(spare_parts_credit_limit AS DOUBLE))
      comment: "Total spare parts credit limit across entitlements — measures parts inventory and financial exposure for service operations."
    - name: "total_quantity"
      expr: SUM(CAST(total_quantity AS DOUBLE))
      comment: "Total contracted quantity across all entitlements — baseline for utilization rate calculation."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`customer_onboarding`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Customer onboarding efficiency and quality KPIs — tracks onboarding cycle time, completion rates, and SLA compliance to drive process improvement and reduce time-to-revenue."
  source: "`vibe_manufacturing_v1`.`customer`.`customer_onboarding`"
  dimensions:
    - name: "onboarding_status"
      expr: onboarding_status
      comment: "Current status of the onboarding process (In Progress, Completed, Blocked, Cancelled) for pipeline visibility."
    - name: "stage"
      expr: stage
      comment: "Current onboarding stage for funnel analysis and bottleneck identification."
    - name: "account_type"
      expr: account_type
      comment: "Type of customer account being onboarded for segmented process performance analysis."
    - name: "account_segment"
      expr: account_segment
      comment: "Customer segment for onboarding resource allocation and SLA tier analysis."
    - name: "assigned_sales_region"
      expr: assigned_sales_region
      comment: "Sales region responsible for the onboarding for regional performance benchmarking."
    - name: "sla_breach_flag"
      expr: sla_breach_flag
      comment: "Whether the onboarding SLA has been breached — critical quality flag for process governance."
    - name: "escalation_flag"
      expr: escalation_flag
      comment: "Whether the onboarding has been escalated — indicates at-risk onboardings requiring management attention."
    - name: "erp_account_created_flag"
      expr: erp_account_created_flag
      comment: "Whether the ERP account has been created — milestone flag for system readiness tracking."
    - name: "initiated_month"
      expr: DATE_TRUNC('MONTH', initiated_timestamp)
      comment: "Month onboarding was initiated, for volume trend and cohort analysis."
    - name: "blocker_category"
      expr: blocker_category
      comment: "Category of blocker causing onboarding delay — used to identify systemic process issues."
  measures:
    - name: "total_onboardings"
      expr: COUNT(DISTINCT customer_onboarding_id)
      comment: "Total number of customer onboarding records — primary volume metric for onboarding program capacity planning."
    - name: "completed_onboardings"
      expr: COUNT(DISTINCT CASE WHEN onboarding_status = 'Completed' THEN customer_onboarding_id END)
      comment: "Number of successfully completed onboardings — measures onboarding throughput and program effectiveness."
    - name: "sla_breached_onboardings"
      expr: COUNT(DISTINCT CASE WHEN sla_breach_flag = TRUE THEN customer_onboarding_id END)
      comment: "Number of onboardings that breached SLA — key quality metric for onboarding process governance and customer experience."
    - name: "escalated_onboardings"
      expr: COUNT(DISTINCT CASE WHEN escalation_flag = TRUE THEN customer_onboarding_id END)
      comment: "Number of escalated onboardings — operational risk indicator requiring management intervention."
    - name: "avg_checklist_completion_pct"
      expr: AVG(CAST(checklist_completion_pct AS DOUBLE))
      comment: "Average checklist completion percentage across all onboardings — measures process thoroughness and readiness for first order."
    - name: "total_credit_limit_approved"
      expr: SUM(CAST(credit_limit_approved AS DOUBLE))
      comment: "Total credit limit approved during onboarding — financial exposure metric for credit risk management."
    - name: "avg_total_checklist_items"
      expr: AVG(CAST(total_checklist_items AS DOUBLE))
      comment: "Average number of checklist items per onboarding — used to assess process complexity and standardization."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`customer_interaction`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Customer interaction volume, quality, and engagement KPIs — tracks touchpoint frequency, sentiment, and follow-up compliance to support customer success and relationship health management."
  source: "`vibe_manufacturing_v1`.`customer`.`interaction`"
  dimensions:
    - name: "interaction_type"
      expr: interaction_type
      comment: "Type of customer interaction (Call, Meeting, Email, Demo, etc.) for channel mix analysis."
    - name: "channel"
      expr: channel
      comment: "Communication channel used for the interaction for omnichannel engagement analysis."
    - name: "interaction_status"
      expr: interaction_status
      comment: "Status of the interaction (Completed, Planned, Cancelled) for activity pipeline management."
    - name: "sentiment_category"
      expr: sentiment_category
      comment: "Sentiment classification of the interaction (Positive, Neutral, Negative) for relationship health monitoring."
    - name: "outcome"
      expr: outcome
      comment: "Outcome of the interaction for sales and service effectiveness analysis."
    - name: "is_customer_complaint"
      expr: is_customer_complaint
      comment: "Whether the interaction was a customer complaint — critical flag for quality and customer satisfaction tracking."
    - name: "follow_up_required"
      expr: follow_up_required
      comment: "Whether a follow-up action is required — operational flag for sales and service team task management."
    - name: "priority"
      expr: priority
      comment: "Priority level of the interaction for workload and escalation management."
    - name: "interaction_date_month"
      expr: DATE_TRUNC('MONTH', interaction_date)
      comment: "Month of the interaction for engagement trend and seasonality analysis."
    - name: "country_code"
      expr: country_code
      comment: "Country where the interaction occurred for geographic engagement analysis."
  measures:
    - name: "total_interactions"
      expr: COUNT(DISTINCT interaction_id)
      comment: "Total number of customer interactions — primary engagement volume metric for customer success programs."
    - name: "complaint_interactions"
      expr: COUNT(DISTINCT CASE WHEN is_customer_complaint = TRUE THEN interaction_id END)
      comment: "Number of interactions classified as customer complaints — key customer satisfaction and quality risk indicator."
    - name: "avg_duration_minutes"
      expr: AVG(CAST(duration_minutes AS DOUBLE))
      comment: "Average interaction duration in minutes — measures engagement depth and resource consumption per touchpoint."
    - name: "total_duration_minutes"
      expr: SUM(CAST(duration_minutes AS DOUBLE))
      comment: "Total interaction time in minutes — measures overall customer engagement investment and resource utilization."
    - name: "follow_up_required_count"
      expr: COUNT(DISTINCT CASE WHEN follow_up_required = TRUE THEN interaction_id END)
      comment: "Number of interactions requiring follow-up — operational backlog metric for sales and service team management."
    - name: "executive_sponsor_interactions"
      expr: COUNT(DISTINCT CASE WHEN is_executive_sponsor_involved = TRUE THEN interaction_id END)
      comment: "Number of interactions involving executive sponsors — measures executive engagement in strategic accounts."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`customer_certification`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Customer certification portfolio KPIs — tracks certification coverage, compliance status, and renewal risk to support quality, regulatory, and supplier qualification programs."
  source: "`vibe_manufacturing_v1`.`customer`.`customer_certification`"
  dimensions:
    - name: "certification_type"
      expr: certification_type
      comment: "Type of certification (ISO, CE, UL, etc.) for compliance portfolio categorization."
    - name: "certification_status"
      expr: certification_status
      comment: "Current status of the certification (Active, Expired, Suspended) for compliance risk monitoring."
    - name: "renewal_status"
      expr: renewal_status
      comment: "Renewal status of the certification for proactive renewal pipeline management."
    - name: "standard"
      expr: standard
      comment: "Certification standard (e.g. ISO 9001, IATF 16949) for standards compliance analysis."
    - name: "country"
      expr: country
      comment: "Country of the certification for geographic compliance coverage analysis."
    - name: "capa_required"
      expr: capa_required
      comment: "Whether a CAPA is required for this certification — quality risk flag for compliance management."
    - name: "is_primary_certification"
      expr: is_primary_certification
      comment: "Whether this is the primary certification for the customer — used to prioritize renewal and audit activities."
    - name: "expiry_date_month"
      expr: DATE_TRUNC('MONTH', expiry_date)
      comment: "Month the certification expires — critical for renewal pipeline and at-risk compliance identification."
    - name: "issue_date_month"
      expr: DATE_TRUNC('MONTH', issue_date)
      comment: "Month the certification was issued for certification acquisition trend analysis."
  measures:
    - name: "total_certifications"
      expr: COUNT(DISTINCT customer_certification_id)
      comment: "Total number of customer certifications — measures breadth of compliance coverage across the customer base."
    - name: "active_certifications"
      expr: COUNT(DISTINCT CASE WHEN certification_status = 'Active' THEN customer_certification_id END)
      comment: "Number of currently active certifications — primary compliance portfolio health metric."
    - name: "certifications_requiring_capa"
      expr: COUNT(DISTINCT CASE WHEN capa_required = TRUE THEN customer_certification_id END)
      comment: "Number of certifications requiring corrective action — quality risk indicator for compliance management teams."
    - name: "certified_customers"
      expr: COUNT(DISTINCT customer_account_id)
      comment: "Number of distinct customers holding at least one certification — measures certification program reach."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`customer_account_hierarchy`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Account hierarchy structure and financial rollup KPIs — supports global account management, credit consolidation, and revenue aggregation across parent-child account relationships."
  source: "`vibe_manufacturing_v1`.`customer`.`account_hierarchy`"
  dimensions:
    - name: "hierarchy_status"
      expr: hierarchy_status
      comment: "Status of the hierarchy record (Active, Inactive) for portfolio governance."
    - name: "hierarchy_level"
      expr: hierarchy_level
      comment: "Level within the account hierarchy for structural analysis (Global, Regional, Local)."
    - name: "hierarchy_category"
      expr: hierarchy_category
      comment: "Category of the hierarchy (Corporate, Divisional, etc.) for organizational structure analysis."
    - name: "account_tier"
      expr: account_tier
      comment: "Tier of the account within the hierarchy for strategic account prioritization."
    - name: "geographic_scope"
      expr: geographic_scope
      comment: "Geographic scope of the hierarchy (Global, Regional, National) for coverage analysis."
    - name: "industry_segment"
      expr: industry_segment
      comment: "Industry segment of the hierarchy for vertical market analysis."
    - name: "relationship_type"
      expr: relationship_type
      comment: "Type of relationship in the hierarchy (Parent-Child, Affiliate, etc.) for structure classification."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the hierarchy record for governance and MDM quality control."
    - name: "effective_from_month"
      expr: DATE_TRUNC('MONTH', effective_from)
      comment: "Month the hierarchy relationship became effective for temporal analysis."
  measures:
    - name: "total_hierarchy_relationships"
      expr: COUNT(DISTINCT account_hierarchy_id)
      comment: "Total number of account hierarchy relationships — measures complexity and breadth of the account structure."
    - name: "total_ownership_percentage"
      expr: SUM(CAST(ownership_percentage AS DOUBLE))
      comment: "Sum of ownership percentages across hierarchy records — used in consolidation and revenue attribution analysis."
    - name: "avg_ownership_percentage"
      expr: AVG(CAST(ownership_percentage AS DOUBLE))
      comment: "Average ownership percentage across hierarchy relationships — benchmarks ownership concentration in the portfolio."
    - name: "avg_data_quality_score"
      expr: AVG(CAST(data_quality_score AS DOUBLE))
      comment: "Average data quality score of hierarchy records — MDM governance metric for hierarchy data integrity."
    - name: "total_credit_rollup_eligible"
      expr: SUM(CAST(credit_rollup_eligible AS DOUBLE))
      comment: "Total credit rollup eligible amount across hierarchy — measures consolidated credit exposure for group-level risk management."
    - name: "total_revenue_rollup_eligible"
      expr: SUM(CAST(revenue_rollup_eligible AS DOUBLE))
      comment: "Total revenue rollup eligible amount — supports consolidated revenue reporting across account groups."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`customer_segment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Customer segment portfolio and financial target KPIs — tracks segment health, revenue targets, and discount policies to support go-to-market strategy and pricing governance."
  source: "`vibe_manufacturing_v1`.`customer`.`segment`"
  dimensions:
    - name: "segment_status"
      expr: segment_status
      comment: "Current status of the segment (Active, Inactive, Under Review) for portfolio governance."
    - name: "segment_type"
      expr: segment_type
      comment: "Type of segment (Industry, Geographic, Behavioral, etc.) for segmentation strategy analysis."
    - name: "industry_vertical"
      expr: industry_vertical
      comment: "Industry vertical of the segment for vertical market strategy alignment."
    - name: "geographic_region"
      expr: geographic_region
      comment: "Geographic region of the segment for regional go-to-market planning."
    - name: "channel_type"
      expr: channel_type
      comment: "Channel type associated with the segment for channel strategy analysis."
    - name: "sla_tier_code"
      expr: sla_tier_code
      comment: "SLA tier code for the segment — links segment strategy to service commitment levels."
    - name: "strategic_account_flag"
      expr: strategic_account_flag
      comment: "Whether the segment contains strategic accounts — used to prioritize investment and coverage."
    - name: "rebate_eligible"
      expr: rebate_eligible
      comment: "Whether accounts in this segment are eligible for rebates — pricing governance flag."
    - name: "effective_from_date_month"
      expr: DATE_TRUNC('MONTH', effective_from_date)
      comment: "Month the segment became effective for temporal strategy analysis."
  measures:
    - name: "total_segments"
      expr: COUNT(DISTINCT segment_id)
      comment: "Total number of customer segments — measures go-to-market segmentation breadth."
    - name: "total_target_revenue_usd"
      expr: SUM(CAST(target_revenue_usd AS DOUBLE))
      comment: "Total revenue target across all segments — top-line revenue planning metric for sales leadership."
    - name: "avg_target_gross_margin_pct"
      expr: AVG(CAST(target_gross_margin_pct AS DOUBLE))
      comment: "Average target gross margin percentage across segments — profitability planning metric for pricing and commercial teams."
    - name: "avg_discount_rate_pct"
      expr: AVG(CAST(discount_rate_pct AS DOUBLE))
      comment: "Average discount rate across segments — pricing governance metric to monitor margin erosion risk."
    - name: "total_credit_limit_usd"
      expr: SUM(CAST(credit_limit_usd AS DOUBLE))
      comment: "Total credit limit allocated across segments — aggregate financial exposure metric for credit risk management."
    - name: "avg_revenue_band_max"
      expr: AVG(CAST(revenue_band_max AS DOUBLE))
      comment: "Average upper revenue band across segments — used to assess segment sizing and revenue potential calibration."
$$;