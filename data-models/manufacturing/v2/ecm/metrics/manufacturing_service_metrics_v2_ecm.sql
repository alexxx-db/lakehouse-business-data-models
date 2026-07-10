-- Metric views for domain: service | Business: Manufacturing | Version: 2 | Generated on: 2026-07-10 11:52:40

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`service_field_service_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Operational and financial KPIs for field service orders — covers cost efficiency, SLA adherence, revenue, and workforce utilisation across service categories and geographies."
  source: "`vibe_manufacturing_v1`.`service`.`field_service_order`"
  dimensions:
    - name: "service_category"
      expr: service_category
      comment: "Service category (e.g. installation, repair, preventive maintenance) for segmenting field service performance."
    - name: "order_type"
      expr: order_type
      comment: "Type of field service order used to distinguish break-fix, planned, and warranty work."
    - name: "priority"
      expr: priority
      comment: "Order priority level (critical, high, medium, low) for SLA and resource allocation analysis."
    - name: "completion_status"
      expr: completion_status
      comment: "Final completion status of the order — drives on-time completion rate calculations."
    - name: "lifecycle_status"
      expr: lifecycle_status
      comment: "Current lifecycle state of the order for pipeline and backlog reporting."
    - name: "warranty_flag"
      expr: warranty_flag
      comment: "Indicates whether the order is covered under warranty — used to split billable vs warranty cost."
    - name: "outcome_code"
      expr: outcome_code
      comment: "Resolution outcome code for first-time fix and repeat-visit analysis."
    - name: "root_cause_code"
      expr: root_cause_code
      comment: "Root cause classification for failure pattern and reliability analysis."
    - name: "service_level_agreement_code"
      expr: service_level_agreement_code
      comment: "SLA tier applied to the order — essential for SLA breach rate segmentation."
    - name: "country"
      expr: country
      comment: "Country where the field service was performed for geographic performance analysis."
    - name: "scheduled_start_month"
      expr: DATE_TRUNC('MONTH', scheduled_start_timestamp)
      comment: "Month the order was scheduled to start — used for trend and capacity planning."
    - name: "actual_start_month"
      expr: DATE_TRUNC('MONTH', actual_start_timestamp)
      comment: "Month the order actually started — compared against scheduled for delay analysis."
  measures:
    - name: "total_field_service_orders"
      expr: COUNT(1)
      comment: "Total number of field service orders — baseline volume KPI for capacity and demand planning."
    - name: "total_labor_cost"
      expr: SUM(CAST(labor_cost AS DOUBLE))
      comment: "Total labor cost across all field service orders — key cost driver for service P&L."
    - name: "total_parts_cost"
      expr: SUM(CAST(parts_cost AS DOUBLE))
      comment: "Total parts cost consumed in field service — drives spare parts inventory investment decisions."
    - name: "total_travel_cost"
      expr: SUM(CAST(travel_cost AS DOUBLE))
      comment: "Total travel cost for field service — used to evaluate zone optimisation and dispatch efficiency."
    - name: "total_gross_revenue"
      expr: SUM(CAST(total_gross_amount AS DOUBLE))
      comment: "Total gross revenue billed for field service orders — top-line service revenue KPI."
    - name: "total_net_revenue"
      expr: SUM(CAST(total_net_amount AS DOUBLE))
      comment: "Total net revenue after discounts — used for service margin and profitability analysis."
    - name: "total_discount_amount"
      expr: SUM(CAST(total_discount_amount AS DOUBLE))
      comment: "Total discounts granted on field service orders — monitors discount leakage and pricing discipline."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax collected on field service orders — required for tax compliance reporting."
    - name: "total_labor_hours"
      expr: SUM(CAST(labor_hours AS DOUBLE))
      comment: "Total labor hours consumed — used for workforce utilisation and capacity planning."
    - name: "avg_labor_hours_per_order"
      expr: AVG(CAST(labor_hours AS DOUBLE))
      comment: "Average labor hours per field service order — benchmark for engineer productivity and job complexity."
    - name: "total_travel_hours"
      expr: SUM(CAST(travel_hours AS DOUBLE))
      comment: "Total travel hours across all orders — used to assess dispatch zone efficiency and engineer utilisation."
    - name: "avg_travel_distance_km"
      expr: AVG(CAST(travel_distance_km AS DOUBLE))
      comment: "Average travel distance per order — drives zone redesign and cost reduction initiatives."
    - name: "avg_net_revenue_per_order"
      expr: AVG(CAST(total_net_amount AS DOUBLE))
      comment: "Average net revenue per field service order — used to benchmark order value and pricing strategy."
    - name: "warranty_order_count"
      expr: COUNT(CASE WHEN warranty_flag = TRUE THEN 1 END)
      comment: "Number of orders covered under warranty — used to quantify warranty cost exposure and product quality impact."
    - name: "distinct_customers_served"
      expr: COUNT(DISTINCT customer_account_id)
      comment: "Number of distinct customers served — measures service reach and customer engagement breadth."
    - name: "distinct_equipment_serviced"
      expr: COUNT(DISTINCT equipment_register_id)
      comment: "Number of distinct equipment assets serviced — used for installed base coverage and asset health tracking."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`service_request`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Customer service request KPIs covering volume, cost, SLA performance, and resolution quality — the primary operational dashboard for service desk and support leadership."
  source: "`vibe_manufacturing_v1`.`service`.`request`"
  dimensions:
    - name: "request_type"
      expr: request_type
      comment: "Type of service request (incident, change, problem, warranty) for workload segmentation."
    - name: "request_status"
      expr: request_status
      comment: "Current status of the request — used for open/closed pipeline and backlog reporting."
    - name: "priority"
      expr: priority
      comment: "Request priority level — critical for SLA breach analysis and escalation management."
    - name: "service_category"
      expr: service_category
      comment: "Service category for the request — used to route workload and measure category-level performance."
    - name: "sla_tier"
      expr: sla_tier
      comment: "SLA tier assigned to the request — essential for SLA compliance segmentation."
    - name: "escalation_level"
      expr: escalation_level
      comment: "Current escalation level — used to monitor escalation rates and management intervention triggers."
    - name: "channel"
      expr: channel
      comment: "Intake channel (phone, email, portal, chat) — used for channel mix and cost-per-channel analysis."
    - name: "warranty_flag"
      expr: warranty_flag
      comment: "Indicates warranty-covered requests — used to split billable vs warranty service cost."
    - name: "site_country"
      expr: site_country
      comment: "Country of the service site — for geographic performance and SLA compliance analysis."
    - name: "created_month"
      expr: DATE_TRUNC('MONTH', created_timestamp)
      comment: "Month the request was created — used for volume trend and seasonality analysis."
    - name: "closed_month"
      expr: DATE_TRUNC('MONTH', closed_timestamp)
      comment: "Month the request was closed — used for resolution throughput and backlog burn-down analysis."
  measures:
    - name: "total_service_requests"
      expr: COUNT(1)
      comment: "Total number of service requests — baseline volume KPI for support capacity and demand planning."
    - name: "total_actual_cost"
      expr: SUM(CAST(actual_cost AS DOUBLE))
      comment: "Total actual cost incurred to resolve service requests — key cost-to-serve metric for service P&L."
    - name: "total_estimated_cost"
      expr: SUM(CAST(estimated_cost AS DOUBLE))
      comment: "Total estimated cost for open and closed requests — used for budget forecasting and cost variance analysis."
    - name: "total_parts_cost"
      expr: SUM(CAST(parts_cost AS DOUBLE))
      comment: "Total parts cost consumed in service requests — drives spare parts demand and inventory investment."
    - name: "avg_actual_cost_per_request"
      expr: AVG(CAST(actual_cost AS DOUBLE))
      comment: "Average actual cost per service request — benchmark for cost-to-serve efficiency and pricing of support contracts."
    - name: "total_travel_distance_km"
      expr: SUM(CAST(travel_distance_km AS DOUBLE))
      comment: "Total travel distance for on-site service requests — used to evaluate dispatch zone efficiency."
    - name: "warranty_request_count"
      expr: COUNT(CASE WHEN warranty_flag = TRUE THEN 1 END)
      comment: "Number of warranty-covered service requests — quantifies warranty cost exposure and product quality impact."
    - name: "escalated_request_count"
      expr: COUNT(CASE WHEN escalation_level IS NOT NULL AND escalation_level <> '' THEN 1 END)
      comment: "Number of escalated service requests — high escalation rates signal SLA or quality issues requiring leadership action."
    - name: "distinct_customers_with_requests"
      expr: COUNT(DISTINCT customer_account_id)
      comment: "Number of distinct customers who raised service requests — measures support demand breadth and customer health risk."
    - name: "open_request_count"
      expr: COUNT(CASE WHEN request_status NOT IN ('Closed', 'Resolved', 'Cancelled') THEN 1 END)
      comment: "Number of currently open service requests — primary backlog KPI for support capacity management."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`service_contract`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Service contract portfolio KPIs covering contract value, renewal performance, SLA commitments, and revenue recognition — used by service sales and operations leadership."
  source: "`vibe_manufacturing_v1`.`service`.`service_contract`"
  dimensions:
    - name: "contract_type"
      expr: contract_type
      comment: "Type of service contract (full-service, time-and-material, SLA-only) for portfolio segmentation."
    - name: "contract_category"
      expr: contract_category
      comment: "Contract category for grouping and reporting by service offering type."
    - name: "service_tier"
      expr: service_tier
      comment: "Service tier (gold, silver, bronze) — used to analyse revenue and margin by commitment level."
    - name: "service_contract_status"
      expr: service_contract_status
      comment: "Current contract status (active, expired, pending renewal) — drives renewal pipeline management."
    - name: "billing_frequency"
      expr: billing_frequency
      comment: "Billing frequency (monthly, quarterly, annual) — used for cash flow and revenue recognition analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Contract currency for multi-currency revenue reporting and FX exposure analysis."
    - name: "auto_renewal_flag"
      expr: auto_renewal_flag
      comment: "Indicates auto-renewal contracts — used to forecast recurring revenue and churn risk."
    - name: "warranty_included_flag"
      expr: warranty_included_flag
      comment: "Indicates whether warranty is bundled — used to assess warranty cost embedded in contract pricing."
    - name: "effective_start_year"
      expr: YEAR(effective_start_date)
      comment: "Year the contract became effective — used for cohort and vintage analysis of contract portfolio."
    - name: "effective_end_year"
      expr: YEAR(effective_end_date)
      comment: "Year the contract expires — used for renewal pipeline and revenue cliff analysis."
  measures:
    - name: "total_active_contracts"
      expr: COUNT(1)
      comment: "Total number of service contracts — baseline portfolio size KPI for service sales leadership."
    - name: "total_contract_value"
      expr: SUM(CAST(contract_value AS DOUBLE))
      comment: "Total contract value (TCV) across the portfolio — primary revenue KPI for service business planning."
    - name: "total_net_contract_value"
      expr: SUM(CAST(net_contract_value AS DOUBLE))
      comment: "Total net contract value after discounts — used for margin and profitability analysis."
    - name: "avg_contract_value"
      expr: AVG(CAST(contract_value AS DOUBLE))
      comment: "Average contract value — benchmark for deal size trends and upsell opportunity identification."
    - name: "avg_discount_rate_pct"
      expr: AVG(CAST(discount_rate_percent AS DOUBLE))
      comment: "Average discount rate across contracts — monitors pricing discipline and discount leakage."
    - name: "avg_uptime_guarantee_pct"
      expr: AVG(CAST(uptime_guarantee_percent AS DOUBLE))
      comment: "Average uptime guarantee committed in contracts — used to assess SLA risk exposure and delivery capability."
    - name: "avg_response_time_target_hours"
      expr: AVG(CAST(response_time_target_hours AS DOUBLE))
      comment: "Average response time target committed across contracts — used to benchmark SLA stringency and resource requirements."
    - name: "avg_resolution_time_target_hours"
      expr: AVG(CAST(resolution_time_target_hours AS DOUBLE))
      comment: "Average resolution time target committed — used to assess SLA delivery risk and engineer capacity needs."
    - name: "auto_renewal_contract_count"
      expr: COUNT(CASE WHEN auto_renewal_flag = TRUE THEN 1 END)
      comment: "Number of auto-renewing contracts — quantifies predictable recurring revenue base."
    - name: "warranty_included_contract_count"
      expr: COUNT(CASE WHEN warranty_included_flag = TRUE THEN 1 END)
      comment: "Number of contracts with bundled warranty — used to quantify embedded warranty cost exposure."
    - name: "distinct_customers_under_contract"
      expr: COUNT(DISTINCT customer_account_id)
      comment: "Number of distinct customers with active service contracts — measures contracted customer base and retention."
    - name: "avg_tax_rate_pct"
      expr: AVG(CAST(tax_rate_percent AS DOUBLE))
      comment: "Average tax rate applied to service contracts — used for tax provision and pricing compliance review."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`service_sla_milestone`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "SLA milestone compliance KPIs — measures breach rates, escalation frequency, and elapsed time performance against committed service levels. Core dashboard for service operations and customer success leadership."
  source: "`vibe_manufacturing_v1`.`service`.`sla_milestone`"
  dimensions:
    - name: "milestone_name"
      expr: milestone_name
      comment: "Name of the SLA milestone (acknowledgement, first response, resolution) for granular compliance tracking."
    - name: "sla_milestone_status"
      expr: sla_milestone_status
      comment: "Current status of the milestone — used to identify open, breached, and met milestones."
    - name: "priority"
      expr: priority
      comment: "Priority of the associated service request — used to analyse SLA compliance by urgency tier."
    - name: "entitlement_tier"
      expr: entitlement_tier
      comment: "Customer entitlement tier — used to segment SLA performance by contract commitment level."
    - name: "breach_flag"
      expr: breach_flag
      comment: "Indicates whether the SLA milestone was breached — primary dimension for compliance reporting."
    - name: "escalated_flag"
      expr: escalated_flag
      comment: "Indicates whether the milestone triggered an escalation — used to measure escalation rate by tier and priority."
    - name: "assigned_team"
      expr: assigned_team
      comment: "Team responsible for the milestone — used for team-level SLA accountability reporting."
    - name: "milestone_month"
      expr: DATE_TRUNC('MONTH', target_timestamp)
      comment: "Month of the SLA target timestamp — used for monthly SLA compliance trend analysis."
  measures:
    - name: "total_sla_milestones"
      expr: COUNT(1)
      comment: "Total SLA milestones evaluated — baseline volume for SLA compliance rate calculations."
    - name: "breached_milestone_count"
      expr: COUNT(CASE WHEN breach_flag = TRUE THEN 1 END)
      comment: "Number of SLA milestones breached — primary SLA compliance KPI; high breach counts trigger contract penalty and churn risk."
    - name: "escalated_milestone_count"
      expr: COUNT(CASE WHEN escalated_flag = TRUE THEN 1 END)
      comment: "Number of milestones that triggered escalation — measures escalation rate and management intervention frequency."
    - name: "distinct_service_requests_with_breach"
      expr: COUNT(DISTINCT CASE WHEN breach_flag = TRUE THEN service_request_id END)
      comment: "Number of distinct service requests with at least one SLA breach — used to measure customer impact of SLA failures."
    - name: "distinct_service_contracts_with_breach"
      expr: COUNT(DISTINCT CASE WHEN breach_flag = TRUE THEN service_contract_id END)
      comment: "Number of distinct service contracts with SLA breaches — used to identify at-risk contracts and penalty exposure."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`service_satisfaction_survey`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Customer satisfaction and NPS KPIs derived from post-service surveys — used by service leadership to track customer experience quality, engineer performance, and contract satisfaction."
  source: "`vibe_manufacturing_v1`.`service`.`satisfaction_survey`"
  dimensions:
    - name: "survey_type"
      expr: survey_type
      comment: "Type of satisfaction survey (post-repair, post-installation, contract renewal) for segmented CSAT analysis."
    - name: "survey_channel"
      expr: survey_channel
      comment: "Channel through which the survey was collected (email, SMS, portal) — used for response rate and channel bias analysis."
    - name: "lifecycle_status"
      expr: lifecycle_status
      comment: "Survey lifecycle status (sent, responded, expired) — used to track response rates and survey completion."
    - name: "language"
      expr: language
      comment: "Language of the survey response — used for regional and demographic satisfaction segmentation."
    - name: "response_month"
      expr: DATE_TRUNC('MONTH', response_timestamp)
      comment: "Month the survey response was received — used for satisfaction trend analysis over time."
  measures:
    - name: "total_surveys_collected"
      expr: COUNT(1)
      comment: "Total number of satisfaction surveys collected — baseline for response rate and CSAT coverage analysis."
    - name: "avg_overall_satisfaction_score"
      expr: AVG(CAST(overall_score AS DOUBLE))
      comment: "Average overall customer satisfaction score — primary CSAT KPI used in executive dashboards and QBRs."
    - name: "total_overall_satisfaction_score"
      expr: SUM(CAST(overall_score AS DOUBLE))
      comment: "Sum of overall satisfaction scores — used as numerator for weighted CSAT calculations in BI tools."
    - name: "distinct_customers_surveyed"
      expr: COUNT(DISTINCT customer_account_id)
      comment: "Number of distinct customers who responded to surveys — measures CSAT coverage across the customer base."
    - name: "distinct_engineers_rated"
      expr: COUNT(DISTINCT engineer_id)
      comment: "Number of distinct engineers rated in surveys — used for engineer performance management and coaching."
    - name: "distinct_contracts_surveyed"
      expr: COUNT(DISTINCT service_contract_id)
      comment: "Number of distinct service contracts with survey responses — used to assess contract satisfaction coverage."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`service_warranty`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Service warranty portfolio KPIs covering coverage value, renewal rates, and claims eligibility — used by service operations and finance to manage warranty liability and revenue."
  source: "`vibe_manufacturing_v1`.`service`.`service_warranty`"
  dimensions:
    - name: "warranty_type"
      expr: warranty_type
      comment: "Type of warranty (standard, extended, on-site) for portfolio segmentation and liability analysis."
    - name: "lifecycle_status"
      expr: lifecycle_status
      comment: "Current warranty lifecycle status (active, expired, pending) — used for active warranty base reporting."
    - name: "registration_status"
      expr: registration_status
      comment: "Warranty registration status — used to track unregistered warranties and activation campaigns."
    - name: "service_level"
      expr: service_level
      comment: "Service level committed under the warranty — used to segment warranty cost and delivery obligations."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the warranty coverage amount — used for multi-currency liability reporting."
    - name: "renewal_flag"
      expr: renewal_flag
      comment: "Indicates whether the warranty is eligible for renewal — used to forecast renewal revenue pipeline."
    - name: "claims_allowed_flag"
      expr: claims_allowed_flag
      comment: "Indicates whether claims are currently allowed — used to identify active claimable warranty exposure."
    - name: "transferability_flag"
      expr: transferability_flag
      comment: "Indicates whether the warranty is transferable — used for secondary market and asset resale analysis."
    - name: "effective_from_year"
      expr: YEAR(effective_from)
      comment: "Year the warranty became effective — used for vintage cohort analysis of warranty portfolio."
    - name: "effective_until_year"
      expr: YEAR(effective_until)
      comment: "Year the warranty expires — used for expiry cliff and renewal pipeline analysis."
  measures:
    - name: "total_warranties"
      expr: COUNT(1)
      comment: "Total number of service warranties in the portfolio — baseline for warranty coverage and liability reporting."
    - name: "total_coverage_amount"
      expr: SUM(CAST(coverage_amount AS DOUBLE))
      comment: "Total warranty coverage amount — primary liability KPI for finance and risk management."
    - name: "avg_coverage_amount"
      expr: AVG(CAST(coverage_amount AS DOUBLE))
      comment: "Average warranty coverage amount per warranty — used to benchmark warranty value and pricing adequacy."
    - name: "renewable_warranty_count"
      expr: COUNT(CASE WHEN renewal_flag = TRUE THEN 1 END)
      comment: "Number of warranties eligible for renewal — quantifies the renewal revenue pipeline."
    - name: "active_claimable_warranty_count"
      expr: COUNT(CASE WHEN claims_allowed_flag = TRUE THEN 1 END)
      comment: "Number of warranties with active claims eligibility — measures current warranty liability exposure."
    - name: "distinct_customers_with_warranty"
      expr: COUNT(DISTINCT customer_account_id)
      comment: "Number of distinct customers with active warranties — measures warranty coverage breadth across the customer base."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`service_rma`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Return merchandise authorisation (RMA) KPIs covering return volume, refund cost, repair cost, and warranty coverage — used by service operations and quality leadership to manage product returns and cost."
  source: "`vibe_manufacturing_v1`.`service`.`service_rma`"
  dimensions:
    - name: "service_rma_status"
      expr: service_rma_status
      comment: "Current RMA status (open, in-process, closed) — used for RMA pipeline and backlog management."
    - name: "return_reason_code"
      expr: return_reason_code
      comment: "Reason code for the return — used to identify top return drivers and product quality issues."
    - name: "disposition"
      expr: disposition
      comment: "Disposition decision (repair, replace, scrap, credit) — used to analyse return handling cost and policy."
    - name: "is_under_warranty"
      expr: is_under_warranty
      comment: "Indicates warranty-covered returns — used to split warranty vs billable return cost."
    - name: "is_critical"
      expr: is_critical
      comment: "Indicates critical RMAs requiring priority handling — used for escalation and resource prioritisation."
    - name: "compliance_status"
      expr: compliance_status
      comment: "Regulatory compliance status of the RMA — used for compliance reporting and audit readiness."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the RMA financial amounts — used for multi-currency cost reporting."
    - name: "return_shipment_method"
      expr: return_shipment_method
      comment: "Shipping method used for the return — used to analyse logistics cost and lead time by carrier type."
    - name: "request_month"
      expr: DATE_TRUNC('MONTH', request_timestamp)
      comment: "Month the RMA was requested — used for return volume trend and seasonality analysis."
  measures:
    - name: "total_rma_cases"
      expr: COUNT(1)
      comment: "Total number of RMA cases — baseline volume KPI for return rate and quality management."
    - name: "total_refund_amount"
      expr: SUM(CAST(refund_amount AS DOUBLE))
      comment: "Total refund amount issued for RMAs — primary financial liability KPI for service and finance leadership."
    - name: "total_repair_cost"
      expr: SUM(CAST(repair_cost AS DOUBLE))
      comment: "Total repair cost incurred for returned units — used to assess repair vs replace economics and cost-to-serve."
    - name: "avg_refund_amount"
      expr: AVG(CAST(refund_amount AS DOUBLE))
      comment: "Average refund amount per RMA — used to benchmark refund policy and identify outlier cases."
    - name: "avg_repair_cost"
      expr: AVG(CAST(repair_cost AS DOUBLE))
      comment: "Average repair cost per RMA — used to evaluate repair programme efficiency and make repair vs replace decisions."
    - name: "warranty_rma_count"
      expr: COUNT(CASE WHEN is_under_warranty = TRUE THEN 1 END)
      comment: "Number of warranty-covered RMAs — quantifies warranty claims volume and product reliability impact."
    - name: "critical_rma_count"
      expr: COUNT(CASE WHEN is_critical = TRUE THEN 1 END)
      comment: "Number of critical RMA cases — used to prioritise resolution resources and escalate to product engineering."
    - name: "distinct_customers_with_rma"
      expr: COUNT(DISTINCT customer_account_id)
      comment: "Number of distinct customers with RMA cases — measures return issue breadth and customer satisfaction risk."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`service_installed_base`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Installed base asset KPIs covering equipment health, maintenance frequency, reliability (MTBF/MTTR), and OEE — used by service and asset management leadership to drive proactive maintenance and upsell strategies."
  source: "`vibe_manufacturing_v1`.`service`.`installed_base`"
  dimensions:
    - name: "operational_status"
      expr: operational_status
      comment: "Current operational status of the installed asset (active, inactive, decommissioned) — used for active base reporting."
    - name: "product_category"
      expr: product_category
      comment: "Product category of the installed asset — used for category-level reliability and service demand analysis."
    - name: "product_name"
      expr: product_name
      comment: "Product name of the installed asset — used for product-level performance and service demand segmentation."
    - name: "maintenance_type"
      expr: maintenance_type
      comment: "Type of maintenance applied (preventive, corrective, predictive) — used to analyse maintenance strategy effectiveness."
    - name: "installation_method"
      expr: installation_method
      comment: "Method used for installation — used to correlate installation quality with subsequent service demand."
    - name: "country_code"
      expr: country_code
      comment: "Country where the asset is installed — used for geographic installed base and service demand analysis."
    - name: "installation_year"
      expr: YEAR(installation_date)
      comment: "Year the asset was installed — used for asset age cohort analysis and lifecycle management."
    - name: "last_service_year"
      expr: YEAR(last_service_date)
      comment: "Year of the last service event — used to identify assets overdue for maintenance."
  measures:
    - name: "total_installed_assets"
      expr: COUNT(1)
      comment: "Total number of installed base assets — baseline for installed base coverage and service addressable market."
    - name: "avg_overall_equipment_effectiveness"
      expr: AVG(CAST(overall_equipment_effectiveness AS DOUBLE))
      comment: "Average OEE across installed assets — primary equipment performance KPI used in operational steering meetings."
    - name: "avg_mean_time_between_failures_hours"
      expr: AVG(CAST(mean_time_between_failures_hours AS DOUBLE))
      comment: "Average MTBF across installed assets — key reliability KPI; declining MTBF signals product quality or maintenance issues."
    - name: "avg_mean_time_to_repair_hours"
      expr: AVG(CAST(mean_time_to_repair_hours AS DOUBLE))
      comment: "Average MTTR across installed assets — measures service responsiveness and repair efficiency."
    - name: "total_capacity_kw"
      expr: SUM(CAST(capacity_kw AS DOUBLE))
      comment: "Total installed capacity in kilowatts — used for energy management and capacity planning."
    - name: "avg_power_rating_kw"
      expr: AVG(CAST(power_rating_kw AS DOUBLE))
      comment: "Average power rating of installed assets — used for energy consumption benchmarking and infrastructure planning."
    - name: "distinct_customers_with_installed_base"
      expr: COUNT(DISTINCT customer_account_id)
      comment: "Number of distinct customers with installed assets — measures installed base customer coverage and upsell opportunity."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`service_capa_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Corrective and preventive action (CAPA) KPIs for the service domain — tracks CAPA volume, cost, closure rates, and risk levels to drive quality improvement and compliance."
  source: "`vibe_manufacturing_v1`.`service`.`service_capa_record`"
  dimensions:
    - name: "service_capa_record_status"
      expr: service_capa_record_status
      comment: "Current CAPA status (open, in-progress, closed, verified) — used for CAPA pipeline and closure rate reporting."
    - name: "priority"
      expr: priority
      comment: "CAPA priority level — used to ensure high-priority quality issues receive timely resolution."
    - name: "severity"
      expr: severity
      comment: "Severity of the quality issue — used to segment CAPA cost and effort by impact level."
    - name: "risk_level"
      expr: risk_level
      comment: "Risk level associated with the CAPA — used for risk-based prioritisation and regulatory reporting."
    - name: "root_cause_category"
      expr: root_cause_category
      comment: "Root cause category — used to identify systemic quality issues and drive preventive action programmes."
    - name: "compliance_status"
      expr: compliance_status
      comment: "Regulatory compliance status of the CAPA — used for audit readiness and regulatory submission tracking."
    - name: "product_family"
      expr: product_family
      comment: "Product family affected by the CAPA — used to identify product lines with recurring quality issues."
    - name: "source"
      expr: source
      comment: "Source that triggered the CAPA (customer complaint, audit, NCR) — used to analyse quality signal origins."
    - name: "is_closed"
      expr: is_closed
      comment: "Indicates whether the CAPA is closed — used for open vs closed CAPA ratio reporting."
    - name: "created_month"
      expr: DATE_TRUNC('MONTH', created_timestamp)
      comment: "Month the CAPA was created — used for CAPA volume trend and quality event frequency analysis."
  measures:
    - name: "total_capa_records"
      expr: COUNT(1)
      comment: "Total number of CAPA records — baseline quality management KPI for compliance and operational excellence."
    - name: "total_actual_cost"
      expr: SUM(CAST(cost_actual AS DOUBLE))
      comment: "Total actual cost of CAPA resolution — used to quantify quality failure cost and justify prevention investment."
    - name: "total_estimated_cost"
      expr: SUM(CAST(cost_estimate AS DOUBLE))
      comment: "Total estimated CAPA cost — used for quality budget planning and cost variance analysis."
    - name: "avg_actual_cost_per_capa"
      expr: AVG(CAST(cost_actual AS DOUBLE))
      comment: "Average actual cost per CAPA — benchmarks quality resolution efficiency and identifies high-cost failure modes."
    - name: "open_capa_count"
      expr: COUNT(CASE WHEN is_closed = FALSE THEN 1 END)
      comment: "Number of open CAPA records — primary backlog KPI for quality management and regulatory compliance."
    - name: "closed_capa_count"
      expr: COUNT(CASE WHEN is_closed = TRUE THEN 1 END)
      comment: "Number of closed CAPA records — used to calculate closure rate and demonstrate quality programme effectiveness."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`service_part_consumption`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Service parts consumption KPIs covering spend, unit economics, and fulfillment performance — used by service operations and supply chain leadership to manage spare parts cost and availability."
  source: "`vibe_manufacturing_v1`.`service`.`part_consumption`"
  dimensions:
    - name: "fulfillment_status"
      expr: fulfillment_status
      comment: "Fulfillment status of the parts order (fulfilled, backordered, cancelled) — used for parts availability and service delivery risk analysis."
    - name: "order_urgency"
      expr: order_urgency
      comment: "Urgency level of the parts order — used to analyse emergency vs planned parts consumption and cost premium."
    - name: "source_type"
      expr: source_type
      comment: "Source of the part (stock, direct procurement, supplier) — used for supply chain strategy and cost analysis."
    - name: "contract_coverage_flag"
      expr: contract_coverage_flag
      comment: "Indicates whether the part consumption is covered by a service contract — used to split billable vs contract-covered parts cost."
    - name: "warranty_coverage_flag"
      expr: warranty_coverage_flag
      comment: "Indicates whether the part is covered under warranty — used to quantify warranty parts cost exposure."
    - name: "unit_of_measure"
      expr: unit_of_measure
      comment: "Unit of measure for the consumed part — used for volume normalisation in consumption analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the parts transaction — used for multi-currency spend reporting."
    - name: "consumption_month"
      expr: DATE_TRUNC('MONTH', consumption_timestamp)
      comment: "Month of parts consumption — used for consumption trend and demand forecasting analysis."
  measures:
    - name: "total_parts_consumption_events"
      expr: COUNT(1)
      comment: "Total number of parts consumption events — baseline for parts demand volume and service activity analysis."
    - name: "total_parts_spend"
      expr: SUM(CAST(line_total_amount AS DOUBLE))
      comment: "Total parts spend across all consumption events — primary cost KPI for service parts management and budget control."
    - name: "avg_unit_price"
      expr: AVG(CAST(unit_price AS DOUBLE))
      comment: "Average unit price of consumed parts — used to monitor parts pricing trends and supplier cost management."
    - name: "avg_line_total_amount"
      expr: AVG(CAST(line_total_amount AS DOUBLE))
      comment: "Average line total per consumption event — used to benchmark parts order value and identify high-cost consumption patterns."
    - name: "warranty_covered_consumption_count"
      expr: COUNT(CASE WHEN warranty_coverage_flag = TRUE THEN 1 END)
      comment: "Number of warranty-covered parts consumption events — quantifies warranty parts liability and product quality cost."
    - name: "contract_covered_consumption_count"
      expr: COUNT(CASE WHEN contract_coverage_flag = TRUE THEN 1 END)
      comment: "Number of contract-covered parts consumption events — used to validate contract parts entitlement utilisation."
    - name: "distinct_spare_parts_consumed"
      expr: COUNT(DISTINCT spare_part_id)
      comment: "Number of distinct spare parts consumed — used for parts catalogue rationalisation and stocking strategy."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`service_pm_schedule`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Preventive maintenance schedule KPIs covering schedule adherence, labor estimates, and compliance — used by service operations to ensure proactive maintenance execution and SLA compliance."
  source: "`vibe_manufacturing_v1`.`service`.`service_pm_schedule`"
  dimensions:
    - name: "schedule_type"
      expr: schedule_type
      comment: "Type of PM schedule (time-based, usage-based, condition-based) — used to analyse maintenance strategy mix."
    - name: "lifecycle_status"
      expr: lifecycle_status
      comment: "Current lifecycle status of the PM schedule — used for active schedule portfolio management."
    - name: "schedule_status"
      expr: schedule_status
      comment: "Execution status of the schedule (on-track, overdue, completed) — primary adherence KPI dimension."
    - name: "compliance_status"
      expr: compliance_status
      comment: "Regulatory compliance status of the PM schedule — used for audit and certification readiness."
    - name: "priority"
      expr: priority
      comment: "Priority of the PM schedule — used to ensure critical maintenance is executed on time."
    - name: "is_mandatory"
      expr: is_mandatory
      comment: "Indicates mandatory PM schedules — used to track compliance with mandatory maintenance obligations."
    - name: "interval_unit"
      expr: interval_unit
      comment: "Unit of the maintenance interval (days, hours, cycles) — used for schedule normalisation and comparison."
    - name: "next_due_year"
      expr: YEAR(next_due_date)
      comment: "Year the next PM is due — used for maintenance workload forecasting and resource planning."
  measures:
    - name: "total_pm_schedules"
      expr: COUNT(1)
      comment: "Total number of PM schedules — baseline for maintenance programme coverage and workload planning."
    - name: "total_estimated_labor_hours"
      expr: SUM(CAST(estimated_labor_hours AS DOUBLE))
      comment: "Total estimated labor hours for all PM schedules — used for maintenance workforce capacity planning."
    - name: "avg_estimated_labor_hours"
      expr: AVG(CAST(estimated_labor_hours AS DOUBLE))
      comment: "Average estimated labor hours per PM schedule — used to benchmark maintenance job complexity and resource requirements."
    - name: "avg_maintenance_interval"
      expr: AVG(CAST(maintenance_interval AS DOUBLE))
      comment: "Average maintenance interval across schedules — used to assess maintenance frequency and asset care intensity."
    - name: "mandatory_schedule_count"
      expr: COUNT(CASE WHEN is_mandatory = TRUE THEN 1 END)
      comment: "Number of mandatory PM schedules — used to track compliance obligations and regulatory maintenance requirements."
    - name: "overdue_schedule_count"
      expr: COUNT(CASE WHEN next_due_date < CURRENT_DATE() AND schedule_status NOT IN ('Completed', 'Cancelled') THEN 1 END)
      comment: "Number of PM schedules past their due date — critical operational KPI for maintenance backlog and compliance risk management."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`service_engineer`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Field engineer workforce KPIs covering capacity, skill coverage, labor rates, and availability — used by service operations and HR leadership for workforce planning and deployment optimisation."
  source: "`vibe_manufacturing_v1`.`service`.`engineer`"
  dimensions:
    - name: "lifecycle_status"
      expr: lifecycle_status
      comment: "Engineer lifecycle status (active, on-leave, terminated) — used for active headcount and availability reporting."
    - name: "employment_type"
      expr: employment_type
      comment: "Employment type (full-time, part-time, contractor) — used for workforce mix and cost analysis."
    - name: "service_region"
      expr: service_region
      comment: "Geographic service region assigned to the engineer — used for regional capacity and coverage analysis."
    - name: "dispatch_zone"
      expr: dispatch_zone
      comment: "Dispatch zone of the engineer — used for zone-level capacity planning and SLA coverage analysis."
    - name: "labor_classification"
      expr: labor_classification
      comment: "Labor classification (technician, specialist, senior engineer) — used for skill tier and cost analysis."
    - name: "overtime_eligible"
      expr: overtime_eligible
      comment: "Indicates overtime eligibility — used for capacity surge planning and cost modelling."
    - name: "travel_eligibility"
      expr: travel_eligibility
      comment: "Indicates whether the engineer can travel — used for deployment planning and zone coverage."
    - name: "union_member_flag"
      expr: union_member_flag
      comment: "Indicates union membership — used for labor agreement compliance and workforce cost modelling."
    - name: "hire_year"
      expr: YEAR(hire_date)
      comment: "Year the engineer was hired — used for tenure cohort analysis and attrition risk assessment."
  measures:
    - name: "total_engineers"
      expr: COUNT(1)
      comment: "Total number of engineers in the workforce — baseline headcount KPI for service capacity planning."
    - name: "total_labor_rate_hourly"
      expr: SUM(CAST(labor_rate_hourly AS DOUBLE))
      comment: "Sum of hourly labor rates across all engineers — used as input for total workforce cost modelling."
    - name: "avg_labor_rate_hourly"
      expr: AVG(CAST(labor_rate_hourly AS DOUBLE))
      comment: "Average hourly labor rate — used to benchmark engineer cost and inform service pricing decisions."
    - name: "travel_eligible_engineer_count"
      expr: COUNT(CASE WHEN travel_eligibility = TRUE THEN 1 END)
      comment: "Number of travel-eligible engineers — used to assess deployable capacity for remote and multi-site service."
    - name: "overtime_eligible_engineer_count"
      expr: COUNT(CASE WHEN overtime_eligible = TRUE THEN 1 END)
      comment: "Number of overtime-eligible engineers — used for surge capacity planning and SLA breach risk mitigation."
    - name: "skill_plc_certified_count"
      expr: COUNT(CASE WHEN skill_plc_certified = TRUE THEN 1 END)
      comment: "Number of PLC-certified engineers — used to ensure sufficient specialist capacity for automation service demand."
    - name: "skill_robotics_certified_count"
      expr: COUNT(CASE WHEN skill_robotics_certified = TRUE THEN 1 END)
      comment: "Number of robotics-certified engineers — used for robotics service capacity planning and skill gap analysis."
    - name: "skill_scada_certified_count"
      expr: COUNT(CASE WHEN skill_scada_certified = TRUE THEN 1 END)
      comment: "Number of SCADA-certified engineers — used to ensure SCADA service coverage across regions and zones."
$$;