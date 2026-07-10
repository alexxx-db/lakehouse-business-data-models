-- Metric views for domain: customer | Business: Manufacturing | Version: 2 | Generated on: 2026-07-10 14:39:56

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`customer_account`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic customer account performance metrics including revenue, credit utilization, and account health indicators for executive decision-making."
  source: "`vibe_manufacturing_v1`.`customer`.`customer_account`"
  dimensions:
    - name: "account_status"
      expr: account_status
      comment: "Current status of the customer account (active, inactive, suspended, etc.)"
    - name: "account_type"
      expr: account_type
      comment: "Classification of account type (direct, distributor, OEM, etc.)"
    - name: "is_strategic_account"
      expr: is_strategic_account
      comment: "Flag indicating whether this is a strategic/key account requiring executive attention"
    - name: "is_global_account"
      expr: is_global_account
      comment: "Flag indicating whether this is a global account with multi-region operations"
    - name: "sla_tier"
      expr: sla_tier
      comment: "Service level agreement tier (platinum, gold, silver, bronze) determining priority and response times"
    - name: "credit_rating"
      expr: credit_rating
      comment: "Credit rating classification for risk assessment and credit policy decisions"
    - name: "industry_naics_code"
      expr: industry_naics_code
      comment: "NAICS industry classification code for vertical market analysis"
    - name: "sales_organization_code"
      expr: sales_organization_code
      comment: "Sales organization responsible for the account"
    - name: "distribution_channel_code"
      expr: distribution_channel_code
      comment: "Distribution channel through which the account is served"
    - name: "account_open_year"
      expr: YEAR(open_date)
      comment: "Year the account was opened for cohort analysis"
    - name: "account_open_month"
      expr: DATE_TRUNC('MONTH', open_date)
      comment: "Month the account was opened for time-series cohort tracking"
  measures:
    - name: "total_customer_accounts"
      expr: COUNT(DISTINCT customer_account_id)
      comment: "Total number of unique customer accounts for market penetration and growth tracking"
    - name: "total_annual_revenue"
      expr: SUM(CAST(annual_revenue AS DOUBLE))
      comment: "Total annual revenue across all customer accounts for portfolio value assessment"
    - name: "avg_annual_revenue_per_account"
      expr: AVG(CAST(annual_revenue AS DOUBLE))
      comment: "Average annual revenue per customer account for account quality and segmentation decisions"
    - name: "total_credit_limit"
      expr: SUM(CAST(credit_limit AS DOUBLE))
      comment: "Total credit limit extended across all accounts for risk exposure management"
    - name: "avg_credit_limit_per_account"
      expr: AVG(CAST(credit_limit AS DOUBLE))
      comment: "Average credit limit per account for credit policy calibration"
    - name: "strategic_account_count"
      expr: COUNT(DISTINCT CASE WHEN is_strategic_account = TRUE THEN customer_account_id END)
      comment: "Number of strategic accounts requiring dedicated resources and executive engagement"
    - name: "global_account_count"
      expr: COUNT(DISTINCT CASE WHEN is_global_account = TRUE THEN customer_account_id END)
      comment: "Number of global accounts for international expansion and coordination planning"
    - name: "strategic_account_penetration_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN is_strategic_account = TRUE THEN customer_account_id END) / NULLIF(COUNT(DISTINCT customer_account_id), 0), 2)
      comment: "Percentage of accounts classified as strategic for portfolio mix optimization"
    - name: "avg_data_quality_score"
      expr: AVG(CAST(data_quality_score AS DOUBLE))
      comment: "Average data quality score across accounts for MDM investment prioritization"
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`customer_credit_profile`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Credit risk and payment performance metrics for treasury, credit management, and CFO decision-making on working capital and bad debt exposure."
  source: "`vibe_manufacturing_v1`.`customer`.`credit_profile`"
  dimensions:
    - name: "credit_status"
      expr: credit_status
      comment: "Current credit status (approved, on hold, under review, suspended)"
    - name: "credit_rating"
      expr: credit_rating
      comment: "Credit rating classification for risk segmentation"
    - name: "credit_hold_flag"
      expr: credit_hold_flag
      comment: "Flag indicating whether account is currently on credit hold"
    - name: "risk_category"
      expr: risk_category
      comment: "Risk category classification (low, medium, high) for portfolio risk management"
    - name: "payment_terms_code"
      expr: payment_terms_code
      comment: "Payment terms code for cash flow forecasting and working capital analysis"
    - name: "credit_segment"
      expr: credit_segment
      comment: "Credit segment classification for differentiated credit policy application"
    - name: "dunning_level"
      expr: dunning_level
      comment: "Current dunning level for collections intensity and resource allocation"
    - name: "credit_rating_agency"
      expr: credit_rating_agency
      comment: "Credit rating agency providing the rating for validation and benchmarking"
    - name: "credit_review_year"
      expr: YEAR(last_credit_review_date)
      comment: "Year of last credit review for review cycle compliance tracking"
  measures:
    - name: "total_credit_profiles"
      expr: COUNT(DISTINCT credit_profile_id)
      comment: "Total number of credit profiles for credit management workload sizing"
    - name: "total_credit_limit"
      expr: SUM(CAST(credit_limit AS DOUBLE))
      comment: "Total credit limit extended for maximum credit exposure and capital allocation decisions"
    - name: "total_outstanding_balance"
      expr: SUM(CAST(outstanding_balance AS DOUBLE))
      comment: "Total outstanding balance across all accounts for working capital and liquidity management"
    - name: "total_overdue_amount"
      expr: SUM(CAST(overdue_amount AS DOUBLE))
      comment: "Total overdue amount for collections prioritization and bad debt provisioning"
    - name: "total_bad_debt_provision"
      expr: SUM(CAST(bad_debt_provision_amount AS DOUBLE))
      comment: "Total bad debt provision for financial reporting and reserve adequacy assessment"
    - name: "avg_credit_utilization_pct"
      expr: AVG(CAST(credit_utilization_pct AS DOUBLE))
      comment: "Average credit utilization percentage for credit policy effectiveness and limit adequacy"
    - name: "avg_dso_days"
      expr: AVG(CAST(dso_days AS DOUBLE))
      comment: "Average days sales outstanding for cash conversion cycle optimization and working capital efficiency"
    - name: "avg_payment_behavior_score"
      expr: AVG(CAST(payment_behavior_score AS DOUBLE))
      comment: "Average payment behavior score for credit policy calibration and customer segmentation"
    - name: "credit_hold_count"
      expr: COUNT(DISTINCT CASE WHEN credit_hold_flag = TRUE THEN credit_profile_id END)
      comment: "Number of accounts on credit hold for collections workload and revenue impact assessment"
    - name: "credit_hold_rate_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN credit_hold_flag = TRUE THEN credit_profile_id END) / NULLIF(COUNT(DISTINCT credit_profile_id), 0), 2)
      comment: "Percentage of accounts on credit hold for credit policy effectiveness and risk appetite calibration"
    - name: "avg_credit_insurance_coverage"
      expr: AVG(CAST(credit_insurance_coverage_limit AS DOUBLE))
      comment: "Average credit insurance coverage limit for risk transfer strategy and insurance spend optimization"
    - name: "overdue_to_outstanding_ratio"
      expr: ROUND(SUM(CAST(overdue_amount AS DOUBLE)) / NULLIF(SUM(CAST(outstanding_balance AS DOUBLE)), 0), 4)
      comment: "Ratio of overdue to outstanding balance for portfolio health and collections effectiveness"
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`customer_account_site`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Manufacturing site operational metrics for capacity planning, service delivery, and field operations resource allocation decisions."
  source: "`vibe_manufacturing_v1`.`customer`.`account_site`"
  dimensions:
    - name: "site_status"
      expr: site_status
      comment: "Current operational status of the site (active, inactive, decommissioned)"
    - name: "site_type"
      expr: site_type
      comment: "Type of site (manufacturing plant, warehouse, service center, etc.)"
    - name: "industry_segment"
      expr: industry_segment
      comment: "Industry segment of the site for vertical market analysis"
    - name: "sla_tier"
      expr: sla_tier
      comment: "Service level agreement tier for service delivery prioritization"
    - name: "site_criticality_rating"
      expr: site_criticality_rating
      comment: "Criticality rating for risk management and service prioritization"
    - name: "safety_classification"
      expr: safety_classification
      comment: "Safety classification for compliance and resource planning"
    - name: "environmental_classification"
      expr: environmental_classification
      comment: "Environmental classification for regulatory compliance and audit planning"
    - name: "operates_24x7"
      expr: operates_24x7
      comment: "Flag indicating 24x7 operation for service coverage and support planning"
    - name: "scada_system_present"
      expr: scada_system_present
      comment: "Flag indicating SCADA system presence for remote monitoring and IoT strategy"
    - name: "mes_system_present"
      expr: mes_system_present
      comment: "Flag indicating MES system presence for digital integration and Industry 4.0 readiness"
    - name: "is_headquarters"
      expr: is_headquarters
      comment: "Flag indicating headquarters location for account management and executive engagement"
    - name: "commissioning_year"
      expr: YEAR(commissioning_date)
      comment: "Year site was commissioned for age-based analysis and lifecycle planning"
  measures:
    - name: "total_active_sites"
      expr: COUNT(DISTINCT account_site_id)
      comment: "Total number of active customer sites for field service capacity planning and market coverage"
    - name: "total_plant_floor_area_sqm"
      expr: SUM(CAST(plant_floor_area_sqm AS DOUBLE))
      comment: "Total plant floor area across all sites for market size and equipment opportunity assessment"
    - name: "avg_plant_floor_area_sqm"
      expr: AVG(CAST(plant_floor_area_sqm AS DOUBLE))
      comment: "Average plant floor area per site for site segmentation and solution sizing"
    - name: "sites_operating_24x7"
      expr: COUNT(DISTINCT CASE WHEN operates_24x7 = TRUE THEN account_site_id END)
      comment: "Number of sites operating 24x7 for premium service demand and support staffing decisions"
    - name: "pct_sites_24x7"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN operates_24x7 = TRUE THEN account_site_id END) / NULLIF(COUNT(DISTINCT account_site_id), 0), 2)
      comment: "Percentage of sites operating 24x7 for service model design and pricing strategy"
    - name: "sites_with_scada"
      expr: COUNT(DISTINCT CASE WHEN scada_system_present = TRUE THEN account_site_id END)
      comment: "Number of sites with SCADA systems for remote monitoring opportunity and IoT product targeting"
    - name: "scada_penetration_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN scada_system_present = TRUE THEN account_site_id END) / NULLIF(COUNT(DISTINCT account_site_id), 0), 2)
      comment: "Percentage of sites with SCADA for digital transformation readiness and IoT market sizing"
    - name: "sites_with_mes"
      expr: COUNT(DISTINCT CASE WHEN mes_system_present = TRUE THEN account_site_id END)
      comment: "Number of sites with MES systems for Industry 4.0 solution targeting and integration planning"
    - name: "mes_penetration_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN mes_system_present = TRUE THEN account_site_id END) / NULLIF(COUNT(DISTINCT account_site_id), 0), 2)
      comment: "Percentage of sites with MES for digital maturity assessment and solution roadmap planning"
    - name: "high_criticality_site_count"
      expr: COUNT(DISTINCT CASE WHEN site_criticality_rating = 'High' THEN account_site_id END)
      comment: "Number of high-criticality sites for risk management and premium service allocation"
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`customer_sla_agreement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Service level agreement performance and contract value metrics for service operations, contract management, and recurring revenue optimization."
  source: "`vibe_manufacturing_v1`.`customer`.`sla_agreement`"
  dimensions:
    - name: "agreement_status"
      expr: agreement_status
      comment: "Current status of the SLA agreement (active, expired, pending renewal, terminated)"
    - name: "sla_type"
      expr: sla_type
      comment: "Type of SLA (standard, premium, custom) for service delivery model segmentation"
    - name: "service_tier"
      expr: service_tier
      comment: "Service tier level for resource allocation and response prioritization"
    - name: "auto_renewal"
      expr: auto_renewal
      comment: "Flag indicating automatic renewal for churn risk and renewal pipeline forecasting"
    - name: "field_service_included"
      expr: field_service_included
      comment: "Flag indicating field service inclusion for service delivery cost modeling"
    - name: "preventive_maintenance_included"
      expr: preventive_maintenance_included
      comment: "Flag indicating preventive maintenance inclusion for service scope and resource planning"
    - name: "remote_monitoring_included"
      expr: remote_monitoring_included
      comment: "Flag indicating remote monitoring inclusion for IoT service adoption and value realization"
    - name: "penalty_clause_applicable"
      expr: penalty_clause_applicable
      comment: "Flag indicating penalty clause presence for performance risk and margin protection"
    - name: "billing_frequency"
      expr: billing_frequency
      comment: "Billing frequency (monthly, quarterly, annual) for cash flow forecasting"
    - name: "service_region"
      expr: service_region
      comment: "Service region for geographic service delivery planning and capacity allocation"
    - name: "effective_year"
      expr: YEAR(effective_date)
      comment: "Year agreement became effective for cohort analysis and vintage performance"
    - name: "expiry_year"
      expr: YEAR(expiry_date)
      comment: "Year agreement expires for renewal pipeline and churn forecasting"
  measures:
    - name: "total_active_sla_agreements"
      expr: COUNT(DISTINCT sla_agreement_id)
      comment: "Total number of active SLA agreements for service operations workload and capacity planning"
    - name: "total_contract_value"
      expr: SUM(CAST(contract_value AS DOUBLE))
      comment: "Total contract value across all SLAs for recurring revenue and service business valuation"
    - name: "total_annual_fee"
      expr: SUM(CAST(annual_fee AS DOUBLE))
      comment: "Total annual fees for recurring revenue forecasting and service business performance"
    - name: "avg_contract_value"
      expr: AVG(CAST(contract_value AS DOUBLE))
      comment: "Average contract value per SLA for pricing strategy and deal size optimization"
    - name: "avg_annual_fee"
      expr: AVG(CAST(annual_fee AS DOUBLE))
      comment: "Average annual fee per SLA for pricing benchmarking and customer value analysis"
    - name: "avg_uptime_target_pct"
      expr: AVG(CAST(uptime_target_pct AS DOUBLE))
      comment: "Average uptime target percentage for service delivery capability and resource requirement planning"
    - name: "avg_initial_response_time_hours"
      expr: AVG(CAST(initial_response_time_hours AS DOUBLE))
      comment: "Average initial response time commitment for service staffing and shift planning"
    - name: "avg_resolution_time_hours"
      expr: AVG(CAST(resolution_time_hours AS DOUBLE))
      comment: "Average resolution time commitment for service capability and parts inventory planning"
    - name: "avg_on_time_delivery_target_pct"
      expr: AVG(CAST(on_time_delivery_target_pct AS DOUBLE))
      comment: "Average on-time delivery target for logistics and supply chain performance requirements"
    - name: "slas_with_auto_renewal"
      expr: COUNT(DISTINCT CASE WHEN auto_renewal = TRUE THEN sla_agreement_id END)
      comment: "Number of SLAs with auto-renewal for churn risk assessment and renewal effort forecasting"
    - name: "auto_renewal_rate_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN auto_renewal = TRUE THEN sla_agreement_id END) / NULLIF(COUNT(DISTINCT sla_agreement_id), 0), 2)
      comment: "Percentage of SLAs with auto-renewal for revenue predictability and customer retention strategy"
    - name: "slas_with_penalty_clauses"
      expr: COUNT(DISTINCT CASE WHEN penalty_clause_applicable = TRUE THEN sla_agreement_id END)
      comment: "Number of SLAs with penalty clauses for performance risk exposure and margin protection planning"
    - name: "penalty_clause_rate_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN penalty_clause_applicable = TRUE THEN sla_agreement_id END) / NULLIF(COUNT(DISTINCT sla_agreement_id), 0), 2)
      comment: "Percentage of SLAs with penalty clauses for contract risk assessment and pricing strategy"
    - name: "remote_monitoring_adoption_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN remote_monitoring_included = TRUE THEN sla_agreement_id END) / NULLIF(COUNT(DISTINCT sla_agreement_id), 0), 2)
      comment: "Percentage of SLAs including remote monitoring for IoT service adoption and digital transformation progress"
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`customer_interaction`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Customer interaction and engagement metrics for customer success, sales effectiveness, and relationship health monitoring."
  source: "`vibe_manufacturing_v1`.`customer`.`interaction`"
  dimensions:
    - name: "interaction_type"
      expr: interaction_type
      comment: "Type of interaction (meeting, call, email, site visit, etc.) for engagement pattern analysis"
    - name: "interaction_status"
      expr: interaction_status
      comment: "Status of the interaction (completed, scheduled, cancelled) for activity tracking"
    - name: "channel"
      expr: channel
      comment: "Communication channel used for omnichannel strategy and channel effectiveness"
    - name: "outcome"
      expr: outcome
      comment: "Outcome of the interaction for effectiveness measurement and process improvement"
    - name: "sentiment_category"
      expr: sentiment_category
      comment: "Sentiment category (positive, neutral, negative) for relationship health and risk detection"
    - name: "priority"
      expr: priority
      comment: "Priority level of the interaction for resource allocation and escalation management"
    - name: "is_customer_complaint"
      expr: is_customer_complaint
      comment: "Flag indicating customer complaint for quality issues and customer satisfaction management"
    - name: "is_executive_sponsor_involved"
      expr: is_executive_sponsor_involved
      comment: "Flag indicating executive sponsor involvement for strategic account management"
    - name: "follow_up_required"
      expr: follow_up_required
      comment: "Flag indicating follow-up required for workload planning and customer commitment tracking"
    - name: "interaction_year"
      expr: YEAR(interaction_date)
      comment: "Year of interaction for time-series engagement analysis"
    - name: "interaction_month"
      expr: DATE_TRUNC('MONTH', interaction_date)
      comment: "Month of interaction for engagement trend and seasonality analysis"
  measures:
    - name: "total_interactions"
      expr: COUNT(DISTINCT interaction_id)
      comment: "Total number of customer interactions for engagement volume and resource utilization tracking"
    - name: "total_customer_complaints"
      expr: COUNT(DISTINCT CASE WHEN is_customer_complaint = TRUE THEN interaction_id END)
      comment: "Total number of customer complaints for quality management and customer satisfaction intervention"
    - name: "complaint_rate_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN is_customer_complaint = TRUE THEN interaction_id END) / NULLIF(COUNT(DISTINCT interaction_id), 0), 2)
      comment: "Percentage of interactions that are complaints for customer satisfaction health and quality issue detection"
    - name: "interactions_requiring_followup"
      expr: COUNT(DISTINCT CASE WHEN follow_up_required = TRUE THEN interaction_id END)
      comment: "Number of interactions requiring follow-up for workload planning and commitment tracking"
    - name: "followup_rate_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN follow_up_required = TRUE THEN interaction_id END) / NULLIF(COUNT(DISTINCT interaction_id), 0), 2)
      comment: "Percentage of interactions requiring follow-up for process efficiency and customer service quality"
    - name: "executive_engagement_count"
      expr: COUNT(DISTINCT CASE WHEN is_executive_sponsor_involved = TRUE THEN interaction_id END)
      comment: "Number of interactions with executive involvement for strategic account management and escalation tracking"
    - name: "executive_engagement_rate_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN is_executive_sponsor_involved = TRUE THEN interaction_id END) / NULLIF(COUNT(DISTINCT interaction_id), 0), 2)
      comment: "Percentage of interactions with executive involvement for strategic account intensity and resource allocation"
    - name: "avg_relationship_health_score"
      expr: AVG(CAST(relationship_health_score AS DOUBLE))
      comment: "Average relationship health score for customer retention risk and account management prioritization"
    - name: "unique_customers_engaged"
      expr: COUNT(DISTINCT customer_account_id)
      comment: "Number of unique customers with interactions for engagement coverage and account penetration"
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`customer_contact`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Contact engagement and data quality metrics for sales effectiveness, marketing campaign targeting, and CRM data governance."
  source: "`vibe_manufacturing_v1`.`customer`.`contact`"
  dimensions:
    - name: "contact_type"
      expr: contact_type
      comment: "Type of contact (buyer, technical, executive, etc.) for persona-based engagement strategy"
    - name: "customer_contact_status"
      expr: customer_contact_status
      comment: "Status of the contact (active, inactive, bounced) for database hygiene and outreach planning"
    - name: "job_title"
      expr: job_title
      comment: "Job title for role-based targeting and buying center analysis"
    - name: "is_decision_maker"
      expr: is_decision_maker
      comment: "Flag indicating decision-making authority for sales prioritization and deal velocity"
    - name: "is_primary_contact"
      expr: is_primary_contact
      comment: "Flag indicating primary contact for account management and communication routing"
    - name: "technical_contact_flag"
      expr: technical_contact_flag
      comment: "Flag indicating technical contact for solution design and technical sales engagement"
    - name: "marketing_opt_in"
      expr: marketing_opt_in
      comment: "Flag indicating marketing opt-in for campaign targeting and compliance"
    - name: "email_opt_out"
      expr: email_opt_out
      comment: "Flag indicating email opt-out for communication compliance and channel strategy"
    - name: "do_not_call"
      expr: do_not_call
      comment: "Flag indicating do-not-call status for compliance and outreach channel selection"
    - name: "preferred_communication_channel"
      expr: preferred_communication_channel
      comment: "Preferred communication channel for personalized engagement and response rate optimization"
    - name: "persona"
      expr: persona
      comment: "Persona classification for targeted messaging and content strategy"
    - name: "sla_tier"
      expr: sla_tier
      comment: "SLA tier for response prioritization and service level management"
  measures:
    - name: "total_contacts"
      expr: COUNT(DISTINCT contact_id)
      comment: "Total number of contacts for database size and market reach assessment"
    - name: "decision_maker_count"
      expr: COUNT(DISTINCT CASE WHEN is_decision_maker = TRUE THEN contact_id END)
      comment: "Number of decision-maker contacts for sales targeting and deal closure capability"
    - name: "decision_maker_coverage_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN is_decision_maker = TRUE THEN contact_id END) / NULLIF(COUNT(DISTINCT contact_id), 0), 2)
      comment: "Percentage of contacts who are decision-makers for buying center penetration and sales effectiveness"
    - name: "marketing_opt_in_count"
      expr: COUNT(DISTINCT CASE WHEN marketing_opt_in = TRUE THEN contact_id END)
      comment: "Number of contacts opted in to marketing for campaign reach and lead generation capacity"
    - name: "marketing_opt_in_rate_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN marketing_opt_in = TRUE THEN contact_id END) / NULLIF(COUNT(DISTINCT contact_id), 0), 2)
      comment: "Percentage of contacts opted in to marketing for campaign targeting effectiveness and consent management"
    - name: "email_opt_out_count"
      expr: COUNT(DISTINCT CASE WHEN email_opt_out = TRUE THEN contact_id END)
      comment: "Number of contacts opted out of email for compliance risk and channel strategy adjustment"
    - name: "email_opt_out_rate_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN email_opt_out = TRUE THEN contact_id END) / NULLIF(COUNT(DISTINCT contact_id), 0), 2)
      comment: "Percentage of contacts opted out of email for campaign fatigue and content relevance assessment"
    - name: "avg_data_quality_score"
      expr: AVG(CAST(data_quality_score AS DOUBLE))
      comment: "Average data quality score for CRM data governance and database hygiene investment prioritization"
    - name: "technical_contact_count"
      expr: COUNT(DISTINCT CASE WHEN technical_contact_flag = TRUE THEN contact_id END)
      comment: "Number of technical contacts for solution design engagement and technical sales coverage"
    - name: "technical_contact_coverage_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN technical_contact_flag = TRUE THEN contact_id END) / NULLIF(COUNT(DISTINCT contact_id), 0), 2)
      comment: "Percentage of contacts who are technical for technical sales capability and solution adoption readiness"
    - name: "unique_customer_accounts"
      expr: COUNT(DISTINCT customer_account_id)
      comment: "Number of unique customer accounts with contacts for account coverage and relationship breadth"
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`customer_segment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Customer segment definition and performance metrics for segmentation strategy, pricing policy, and go-to-market resource allocation."
  source: "`vibe_manufacturing_v1`.`customer`.`segment`"
  dimensions:
    - name: "segment_status"
      expr: segment_status
      comment: "Status of the segment (active, inactive, under review) for segment lifecycle management"
    - name: "segment_type"
      expr: segment_type
      comment: "Type of segment (industry, size, behavior, etc.) for segmentation strategy evaluation"
    - name: "customer_account_type"
      expr: customer_account_type
      comment: "Account type classification for segment definition and targeting"
    - name: "channel_type"
      expr: channel_type
      comment: "Channel type for segment-specific go-to-market strategy"
    - name: "industry_vertical"
      expr: industry_vertical
      comment: "Industry vertical for vertical market strategy and solution positioning"
    - name: "geographic_region"
      expr: geographic_region
      comment: "Geographic region for regional strategy and resource allocation"
    - name: "strategic_account_flag"
      expr: strategic_account_flag
      comment: "Flag indicating strategic account segment for premium resource allocation"
    - name: "dedicated_account_manager_required"
      expr: dedicated_account_manager_required
      comment: "Flag indicating dedicated account manager requirement for sales resource planning"
    - name: "contract_required"
      expr: contract_required
      comment: "Flag indicating contract requirement for sales process and legal resource planning"
    - name: "nda_required"
      expr: nda_required
      comment: "Flag indicating NDA requirement for compliance and legal process design"
    - name: "rebate_eligible"
      expr: rebate_eligible
      comment: "Flag indicating rebate eligibility for pricing strategy and margin management"
  measures:
    - name: "total_segments"
      expr: COUNT(DISTINCT segment_id)
      comment: "Total number of customer segments for segmentation complexity and management overhead assessment"
    - name: "total_target_revenue_usd"
      expr: SUM(CAST(target_revenue_usd AS DOUBLE))
      comment: "Total target revenue across all segments for revenue planning and quota allocation"
    - name: "avg_target_revenue_per_segment"
      expr: AVG(CAST(target_revenue_usd AS DOUBLE))
      comment: "Average target revenue per segment for segment sizing and resource allocation decisions"
    - name: "avg_target_gross_margin_pct"
      expr: AVG(CAST(target_gross_margin_pct AS DOUBLE))
      comment: "Average target gross margin percentage for pricing strategy and profitability management"
    - name: "avg_discount_rate_pct"
      expr: AVG(CAST(discount_rate_pct AS DOUBLE))
      comment: "Average discount rate percentage for pricing policy and margin protection strategy"
    - name: "total_credit_limit_usd"
      expr: SUM(CAST(credit_limit_usd AS DOUBLE))
      comment: "Total credit limit across all segments for credit policy and risk exposure management"
    - name: "avg_credit_limit_per_segment"
      expr: AVG(CAST(credit_limit_usd AS DOUBLE))
      comment: "Average credit limit per segment for segment-based credit policy calibration"
    - name: "segments_requiring_dedicated_am"
      expr: COUNT(DISTINCT CASE WHEN dedicated_account_manager_required = TRUE THEN segment_id END)
      comment: "Number of segments requiring dedicated account managers for sales resource planning and hiring decisions"
    - name: "strategic_segment_count"
      expr: COUNT(DISTINCT CASE WHEN strategic_account_flag = TRUE THEN segment_id END)
      comment: "Number of strategic segments for premium resource allocation and executive engagement planning"
    - name: "rebate_eligible_segment_count"
      expr: COUNT(DISTINCT CASE WHEN rebate_eligible = TRUE THEN segment_id END)
      comment: "Number of rebate-eligible segments for rebate program cost forecasting and margin impact analysis"
$$;