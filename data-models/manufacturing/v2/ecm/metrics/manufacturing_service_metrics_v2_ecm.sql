-- Metric views for domain: service | Business: Manufacturing | Version: 2 | Generated on: 2026-07-03 05:35:52

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`service_field_service_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Operational and financial KPIs for field service orders — tracks cost, labor efficiency, travel burden, and resolution outcomes to steer field service delivery performance."
  source: "`vibe_manufacturing_v1`.`service`.`field_service_order`"
  dimensions:
    - name: "order_type"
      expr: order_type
      comment: "Type of field service order (e.g., installation, repair, preventive maintenance) for segmenting workload mix."
    - name: "order_status"
      expr: order_status
      comment: "Current lifecycle status of the field service order for pipeline and backlog analysis."
    - name: "priority"
      expr: priority
      comment: "Priority level assigned to the order, enabling SLA-risk segmentation."
    - name: "service_category"
      expr: service_category
      comment: "Service category (e.g., electrical, mechanical) for workload distribution analysis."
    - name: "outcome_code"
      expr: outcome_code
      comment: "Resolution outcome code to analyze first-time fix rates and repeat-visit patterns."
    - name: "warranty_flag"
      expr: warranty_flag
      comment: "Indicates whether the order is covered under warranty, enabling warranty cost tracking."
    - name: "scheduled_date_month"
      expr: DATE_TRUNC('MONTH', scheduled_date)
      comment: "Month of scheduled service date for trend analysis of order volume over time."
    - name: "completion_status"
      expr: completion_status
      comment: "Completion status of the order to measure closure rates and open backlog."
  measures:
    - name: "total_field_service_orders"
      expr: COUNT(1)
      comment: "Total number of field service orders — baseline volume KPI for capacity and demand planning."
    - name: "total_labor_cost"
      expr: SUM(CAST(labor_cost AS DOUBLE))
      comment: "Total labor cost across all field service orders — key cost driver for service P&L management."
    - name: "total_parts_cost"
      expr: SUM(CAST(parts_cost AS DOUBLE))
      comment: "Total parts cost consumed in field service — informs spare parts inventory investment decisions."
    - name: "total_travel_cost"
      expr: SUM(CAST(travel_cost AS DOUBLE))
      comment: "Total travel cost incurred — used to evaluate geographic dispatch efficiency and zone optimization."
    - name: "total_service_cost"
      expr: SUM(CAST(total_cost AS DOUBLE))
      comment: "Total end-to-end cost per field service order pool — primary financial KPI for service cost management."
    - name: "avg_labor_hours_per_order"
      expr: AVG(CAST(labor_hours AS DOUBLE))
      comment: "Average labor hours per field service order — measures technician productivity and job complexity."
    - name: "avg_travel_distance_km"
      expr: AVG(CAST(travel_distance_km AS DOUBLE))
      comment: "Average travel distance per order — drives zone design and dispatch optimization decisions."
    - name: "avg_travel_hours_per_order"
      expr: AVG(CAST(travel_hours AS DOUBLE))
      comment: "Average travel time per order — quantifies non-productive time and informs territory restructuring."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax charged on field service orders — required for financial reporting and tax compliance."
    - name: "warranty_order_count"
      expr: COUNT(CASE WHEN warranty_flag = TRUE THEN 1 END)
      comment: "Count of orders executed under warranty coverage — measures warranty liability exposure."
    - name: "avg_total_cost_per_order"
      expr: AVG(CAST(total_cost AS DOUBLE))
      comment: "Average total cost per field service order — benchmark for pricing and profitability analysis."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`service_request`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Customer service request KPIs covering volume, cost, SLA adherence, and resolution quality — core metrics for service operations steering."
  source: "`vibe_manufacturing_v1`.`service`.`request`"
  dimensions:
    - name: "request_type"
      expr: request_type
      comment: "Type of service request (e.g., break-fix, inquiry, complaint) for workload categorization."
    - name: "request_status"
      expr: request_status
      comment: "Current status of the request for pipeline and backlog management."
    - name: "priority"
      expr: priority
      comment: "Priority level of the request for SLA risk and escalation analysis."
    - name: "service_category"
      expr: service_category
      comment: "Service category for demand segmentation and resource allocation."
    - name: "channel"
      expr: channel
      comment: "Intake channel (e.g., phone, email, portal) for channel mix and cost-to-serve analysis."
    - name: "sla_tier"
      expr: sla_tier
      comment: "SLA tier assigned to the request — enables SLA compliance reporting by tier."
    - name: "warranty_flag"
      expr: warranty_flag
      comment: "Whether the request is covered under warranty — separates warranty vs. billable service demand."
    - name: "escalation_level"
      expr: escalation_level
      comment: "Escalation level reached — identifies systemic quality or capacity issues."
    - name: "created_month"
      expr: DATE_TRUNC('MONTH', created_timestamp)
      comment: "Month the request was created for trend and seasonality analysis."
  measures:
    - name: "total_service_requests"
      expr: COUNT(1)
      comment: "Total number of service requests — primary volume KPI for service demand planning."
    - name: "total_actual_cost"
      expr: SUM(CAST(actual_cost AS DOUBLE))
      comment: "Total actual cost incurred to resolve service requests — key cost-of-service metric."
    - name: "total_estimated_cost"
      expr: SUM(CAST(estimated_cost AS DOUBLE))
      comment: "Total estimated cost for open requests — used for budget forecasting and resource planning."
    - name: "total_parts_cost"
      expr: SUM(CAST(parts_cost AS DOUBLE))
      comment: "Total parts cost consumed across service requests — informs spare parts stocking strategy."
    - name: "avg_actual_cost_per_request"
      expr: AVG(CAST(actual_cost AS DOUBLE))
      comment: "Average actual cost per service request — benchmark for pricing and profitability analysis."
    - name: "avg_travel_distance_km"
      expr: AVG(CAST(travel_distance_km AS DOUBLE))
      comment: "Average travel distance per service request — informs zone and dispatch optimization."
    - name: "warranty_request_count"
      expr: COUNT(CASE WHEN warranty_flag = TRUE THEN 1 END)
      comment: "Count of warranty-covered requests — measures warranty liability and product quality signals."
    - name: "escalated_request_count"
      expr: COUNT(CASE WHEN escalation_level IS NOT NULL AND escalation_level != '' THEN 1 END)
      comment: "Count of escalated requests — leading indicator of service quality and capacity issues."
    - name: "unique_customers_served"
      expr: COUNT(DISTINCT customer_account_id)
      comment: "Number of distinct customers with service requests — measures service reach and customer exposure."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`service_contract`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Service contract portfolio KPIs covering contract value, renewal performance, and coverage mix — essential for recurring revenue management and customer retention strategy."
  source: "`vibe_manufacturing_v1`.`service`.`service_contract`"
  dimensions:
    - name: "contract_type"
      expr: contract_type
      comment: "Type of service contract (e.g., full-service, time-and-material) for portfolio mix analysis."
    - name: "contract_status"
      expr: contract_status
      comment: "Current status of the contract for active portfolio and renewal pipeline management."
    - name: "service_tier"
      expr: service_tier
      comment: "Service tier (e.g., gold, silver, bronze) for revenue and margin segmentation."
    - name: "coverage_level"
      expr: coverage_level
      comment: "Coverage level of the contract for entitlement and cost-to-serve analysis."
    - name: "billing_frequency"
      expr: billing_frequency
      comment: "Billing frequency (monthly, annual) for cash flow and revenue recognition planning."
    - name: "auto_renew_flag"
      expr: auto_renew_flag
      comment: "Whether the contract auto-renews — key metric for churn risk identification."
    - name: "warranty_included_flag"
      expr: warranty_included_flag
      comment: "Whether warranty is bundled in the contract — affects margin and cost-to-serve calculations."
    - name: "effective_start_month"
      expr: DATE_TRUNC('MONTH', effective_start_date)
      comment: "Month the contract became effective for cohort and vintage analysis."
  measures:
    - name: "total_active_contracts"
      expr: COUNT(1)
      comment: "Total number of service contracts — baseline portfolio size KPI for recurring revenue management."
    - name: "total_annual_contract_value"
      expr: SUM(CAST(annual_contract_value AS DOUBLE))
      comment: "Total annual contract value (ACV) across the portfolio — primary recurring revenue KPI."
    - name: "total_contract_value"
      expr: SUM(CAST(contract_value AS DOUBLE))
      comment: "Total lifetime contract value across all contracts — measures total committed revenue."
    - name: "total_net_contract_value"
      expr: SUM(CAST(net_contract_value AS DOUBLE))
      comment: "Total net contract value after discounts — true revenue contribution of the service portfolio."
    - name: "avg_annual_contract_value"
      expr: AVG(CAST(annual_contract_value AS DOUBLE))
      comment: "Average ACV per contract — benchmark for upsell opportunity sizing and pricing strategy."
    - name: "avg_discount_rate_percent"
      expr: AVG(CAST(discount_rate_percent AS DOUBLE))
      comment: "Average discount rate applied to contracts — monitors pricing discipline and margin erosion."
    - name: "avg_uptime_guarantee_percent"
      expr: AVG(CAST(uptime_guarantee_percent AS DOUBLE))
      comment: "Average uptime guarantee committed in contracts — measures SLA risk exposure in the portfolio."
    - name: "auto_renew_contract_count"
      expr: COUNT(CASE WHEN auto_renew_flag = TRUE THEN 1 END)
      comment: "Count of contracts set to auto-renew — measures revenue retention stability."
    - name: "unique_customers_under_contract"
      expr: COUNT(DISTINCT customer_account_id)
      comment: "Number of distinct customers with active service contracts — measures contracted customer base."
    - name: "avg_response_time_target_hours"
      expr: AVG(CAST(response_time_target_hours AS DOUBLE))
      comment: "Average contracted response time target — measures SLA stringency across the portfolio."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`service_sla_milestone`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "SLA compliance KPIs tracking breach rates, escalation frequency, and milestone performance — critical for customer satisfaction and contract penalty risk management."
  source: "`vibe_manufacturing_v1`.`service`.`sla_milestone`"
  dimensions:
    - name: "milestone_type"
      expr: milestone_type
      comment: "Type of SLA milestone (e.g., acknowledgment, first response, resolution) for compliance breakdown."
    - name: "milestone_status"
      expr: milestone_status
      comment: "Current status of the milestone for open vs. closed SLA tracking."
    - name: "priority"
      expr: priority
      comment: "Priority of the associated service request — enables SLA breach analysis by priority tier."
    - name: "breach_flag"
      expr: breach_flag
      comment: "Whether the SLA milestone was breached — primary compliance indicator."
    - name: "escalated_flag"
      expr: escalated_flag
      comment: "Whether the milestone triggered an escalation — measures escalation frequency."
    - name: "entitlement_tier"
      expr: entitlement_tier
      comment: "Customer entitlement tier for SLA compliance segmentation by contract tier."
    - name: "created_month"
      expr: DATE_TRUNC('MONTH', created_timestamp)
      comment: "Month the milestone was created for SLA trend analysis over time."
  measures:
    - name: "total_sla_milestones"
      expr: COUNT(1)
      comment: "Total SLA milestones evaluated — baseline for SLA compliance rate calculations."
    - name: "sla_breach_count"
      expr: COUNT(CASE WHEN breach_flag = TRUE THEN 1 END)
      comment: "Number of SLA milestones breached — primary SLA compliance KPI driving penalty and churn risk."
    - name: "sla_escalation_count"
      expr: COUNT(CASE WHEN escalated_flag = TRUE THEN 1 END)
      comment: "Number of escalated SLA milestones — measures severity of SLA failures requiring management attention."
    - name: "sla_breach_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN breach_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of SLA milestones breached — headline SLA compliance KPI for executive reporting."
    - name: "sla_escalation_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN escalated_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of milestones that escalated — measures systemic SLA failure severity."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`service_satisfaction_survey`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Customer satisfaction KPIs measuring CSAT scores, survey response patterns, and overall service quality perception — directly linked to retention and NPS strategy."
  source: "`vibe_manufacturing_v1`.`service`.`satisfaction_survey`"
  dimensions:
    - name: "survey_type"
      expr: survey_type
      comment: "Type of survey (e.g., post-repair, post-installation) for satisfaction segmentation by interaction type."
    - name: "survey_status"
      expr: survey_status
      comment: "Status of the survey (completed, pending) for response rate tracking."
    - name: "survey_channel"
      expr: survey_channel
      comment: "Channel through which the survey was delivered (email, SMS, portal) for channel effectiveness analysis."
    - name: "lifecycle_status"
      expr: lifecycle_status
      comment: "Lifecycle status of the survey record for data quality and completeness monitoring."
    - name: "survey_date_month"
      expr: DATE_TRUNC('MONTH', survey_date)
      comment: "Month of survey completion for CSAT trend analysis over time."
  measures:
    - name: "total_surveys_completed"
      expr: COUNT(1)
      comment: "Total number of satisfaction surveys completed — baseline for response rate and CSAT calculations."
    - name: "avg_csat_score"
      expr: AVG(CAST(csat_score AS DOUBLE))
      comment: "Average CSAT score across all surveys — primary customer satisfaction KPI for executive reporting."
    - name: "avg_overall_score"
      expr: AVG(CAST(overall_score AS DOUBLE))
      comment: "Average overall satisfaction score — composite satisfaction measure for service quality steering."
    - name: "unique_customers_surveyed"
      expr: COUNT(DISTINCT customer_account_id)
      comment: "Number of distinct customers who completed surveys — measures satisfaction program reach."
    - name: "max_csat_score"
      expr: MAX(CAST(csat_score AS DOUBLE))
      comment: "Maximum CSAT score achieved — benchmarks best-in-class service performance."
    - name: "min_csat_score"
      expr: MIN(CAST(csat_score AS DOUBLE))
      comment: "Minimum CSAT score recorded — identifies worst service experiences requiring corrective action."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`service_engineer_assignment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Engineer utilization and scheduling KPIs measuring planned vs. actual hours, assignment efficiency, and workforce deployment — drives field workforce optimization decisions."
  source: "`vibe_manufacturing_v1`.`service`.`engineer_assignment`"
  dimensions:
    - name: "assignment_status"
      expr: assignment_status
      comment: "Current status of the engineer assignment for workload pipeline management."
    - name: "assignment_role"
      expr: assignment_role
      comment: "Role of the engineer on the assignment (lead, support) for skill utilization analysis."
    - name: "is_primary_flag"
      expr: is_primary_flag
      comment: "Whether the engineer is the primary assignee — enables primary vs. support resource analysis."
    - name: "assignment_date_month"
      expr: DATE_TRUNC('MONTH', assignment_date)
      comment: "Month of assignment for workforce utilization trend analysis."
  measures:
    - name: "total_assignments"
      expr: COUNT(1)
      comment: "Total engineer assignments — baseline volume KPI for workforce demand planning."
    - name: "total_planned_hours"
      expr: SUM(CAST(planned_hours AS DOUBLE))
      comment: "Total planned labor hours across all assignments — used for capacity planning and scheduling."
    - name: "total_actual_hours"
      expr: SUM(CAST(actual_hours AS DOUBLE))
      comment: "Total actual hours worked on assignments — measures true labor consumption vs. plan."
    - name: "total_estimated_hours"
      expr: SUM(CAST(estimated_hours AS DOUBLE))
      comment: "Total estimated hours for assignments — baseline for scheduling accuracy measurement."
    - name: "avg_actual_hours_per_assignment"
      expr: AVG(CAST(actual_hours AS DOUBLE))
      comment: "Average actual hours per assignment — measures job complexity and engineer productivity."
    - name: "avg_allocated_hours_per_assignment"
      expr: AVG(CAST(allocated_hours AS DOUBLE))
      comment: "Average allocated hours per assignment — measures scheduling efficiency and resource utilization."
    - name: "unique_engineers_assigned"
      expr: COUNT(DISTINCT primary_service_engineer_id)
      comment: "Number of distinct engineers with active assignments — measures workforce deployment breadth."
    - name: "hours_variance"
      expr: SUM(CAST(actual_hours AS DOUBLE) - CAST(planned_hours AS DOUBLE))
      comment: "Total variance between actual and planned hours — measures scheduling accuracy and over/under-run risk."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`service_part_consumption`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Parts consumption KPIs for field service — tracks cost, volume, and fulfillment performance to optimize spare parts inventory and service cost management."
  source: "`vibe_manufacturing_v1`.`service`.`part_consumption`"
  dimensions:
    - name: "source_type"
      expr: source_type
      comment: "Source of the part (warehouse, supplier, consignment) for supply chain optimization."
    - name: "fulfillment_status"
      expr: fulfillment_status
      comment: "Fulfillment status of the part order — measures parts availability and service delay risk."
    - name: "order_urgency"
      expr: order_urgency
      comment: "Urgency level of the parts order — identifies emergency procurement patterns and cost premiums."
    - name: "contract_coverage_flag"
      expr: contract_coverage_flag
      comment: "Whether parts consumption is covered by a service contract — separates billable vs. contract-covered cost."
    - name: "warranty_coverage_flag"
      expr: warranty_coverage_flag
      comment: "Whether parts are covered under warranty — measures warranty parts cost exposure."
    - name: "consumption_month"
      expr: DATE_TRUNC('MONTH', consumption_timestamp)
      comment: "Month of parts consumption for demand trend and seasonality analysis."
  measures:
    - name: "total_parts_consumption_events"
      expr: COUNT(1)
      comment: "Total parts consumption transactions — baseline volume KPI for parts demand planning."
    - name: "total_parts_cost"
      expr: SUM(CAST(total_cost AS DOUBLE))
      comment: "Total cost of parts consumed in field service — primary cost driver for service margin management."
    - name: "total_quantity_consumed"
      expr: SUM(CAST(quantity_consumed AS DOUBLE))
      comment: "Total quantity of parts consumed — drives inventory replenishment and stocking level decisions."
    - name: "total_line_total_amount"
      expr: SUM(CAST(line_total_amount AS DOUBLE))
      comment: "Total line-level parts billing amount — measures billable parts revenue from service activities."
    - name: "avg_unit_cost"
      expr: AVG(CAST(unit_cost AS DOUBLE))
      comment: "Average unit cost of parts consumed — benchmarks parts pricing and supplier cost performance."
    - name: "warranty_covered_cost"
      expr: SUM(CASE WHEN warranty_coverage_flag = TRUE THEN CAST(total_cost AS DOUBLE) ELSE 0 END)
      comment: "Total parts cost covered under warranty — measures warranty liability and product quality cost."
    - name: "unique_field_orders_with_parts"
      expr: COUNT(DISTINCT field_service_order_id)
      comment: "Number of distinct field service orders consuming parts — measures parts-intensive job prevalence."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`service_warranty`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Service warranty portfolio KPIs tracking coverage value, duration, and claim exposure — essential for warranty liability management and product quality investment decisions."
  source: "`vibe_manufacturing_v1`.`service`.`service_warranty`"
  dimensions:
    - name: "warranty_type"
      expr: warranty_type
      comment: "Type of warranty (standard, extended, on-site) for portfolio mix and cost analysis."
    - name: "warranty_status"
      expr: warranty_status
      comment: "Current status of the warranty for active coverage and expiry management."
    - name: "service_level"
      expr: service_level
      comment: "Service level committed under the warranty for SLA exposure analysis."
    - name: "lifecycle_status"
      expr: lifecycle_status
      comment: "Lifecycle status of the warranty record for portfolio health monitoring."
    - name: "renewal_flag"
      expr: renewal_flag
      comment: "Whether the warranty has been renewed — measures warranty renewal rate and revenue retention."
    - name: "transferable_flag"
      expr: transferable_flag
      comment: "Whether the warranty is transferable — affects asset resale value and secondary market strategy."
    - name: "effective_from_month"
      expr: DATE_TRUNC('MONTH', effective_from)
      comment: "Month warranty became effective for cohort and vintage analysis."
  measures:
    - name: "total_warranties"
      expr: COUNT(1)
      comment: "Total number of service warranties in the portfolio — baseline for warranty liability exposure."
    - name: "total_coverage_amount"
      expr: SUM(CAST(coverage_amount AS DOUBLE))
      comment: "Total warranty coverage amount committed — measures maximum financial liability from warranty portfolio."
    - name: "total_claim_limit_amount"
      expr: SUM(CAST(claim_limit_amount AS DOUBLE))
      comment: "Total claim limit across all warranties — caps the financial exposure from warranty claims."
    - name: "avg_duration_months"
      expr: AVG(CAST(duration_months AS DOUBLE))
      comment: "Average warranty duration in months — informs warranty pricing and product reliability benchmarking."
    - name: "avg_coverage_amount"
      expr: AVG(CAST(coverage_amount AS DOUBLE))
      comment: "Average coverage amount per warranty — benchmarks warranty value and pricing adequacy."
    - name: "renewable_warranty_count"
      expr: COUNT(CASE WHEN renewal_flag = TRUE THEN 1 END)
      comment: "Count of warranties eligible for renewal — measures warranty renewal revenue opportunity."
    - name: "unique_customers_with_warranty"
      expr: COUNT(DISTINCT customer_account_id)
      comment: "Number of distinct customers with active warranties — measures warranty program reach."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`service_capa_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Service CAPA (Corrective and Preventive Action) KPIs tracking quality issue resolution, cost of quality, and effectiveness — drives continuous improvement and risk reduction decisions."
  source: "`vibe_manufacturing_v1`.`service`.`service_capa_record`"
  dimensions:
    - name: "capa_type"
      expr: capa_type
      comment: "Type of CAPA (corrective vs. preventive) for quality improvement portfolio analysis."
    - name: "capa_status"
      expr: capa_status
      comment: "Current status of the CAPA record for open action tracking and closure rate measurement."
    - name: "priority"
      expr: priority
      comment: "Priority of the CAPA for risk-weighted quality management."
    - name: "severity"
      expr: severity
      comment: "Severity of the underlying issue — enables risk-stratified CAPA portfolio management."
    - name: "root_cause_category"
      expr: root_cause_category
      comment: "Root cause category for systemic issue identification and prevention investment."
    - name: "product_family"
      expr: product_family
      comment: "Product family affected by the CAPA — links quality issues to product lines for R&D decisions."
    - name: "effectiveness_verified_flag"
      expr: effectiveness_verified_flag
      comment: "Whether the CAPA effectiveness has been verified — measures quality of corrective action closure."
    - name: "created_month"
      expr: DATE_TRUNC('MONTH', created_timestamp)
      comment: "Month CAPA was created for quality trend analysis over time."
  measures:
    - name: "total_capa_records"
      expr: COUNT(1)
      comment: "Total CAPA records — baseline quality issue volume KPI for continuous improvement tracking."
    - name: "total_capa_actual_cost"
      expr: SUM(CAST(cost_actual AS DOUBLE))
      comment: "Total actual cost of CAPA execution — measures cost of quality and corrective action investment."
    - name: "total_capa_estimated_cost"
      expr: SUM(CAST(cost_estimate AS DOUBLE))
      comment: "Total estimated cost of open CAPAs — used for quality budget forecasting."
    - name: "avg_capa_actual_cost"
      expr: AVG(CAST(cost_actual AS DOUBLE))
      comment: "Average cost per CAPA — benchmarks quality issue resolution cost efficiency."
    - name: "verified_capa_count"
      expr: COUNT(CASE WHEN effectiveness_verified_flag = TRUE THEN 1 END)
      comment: "Count of CAPAs with verified effectiveness — measures quality of corrective action closure."
    - name: "verified_effectiveness_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN effectiveness_verified_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of CAPAs with verified effectiveness — headline quality closure quality KPI."
    - name: "closed_capa_count"
      expr: COUNT(CASE WHEN is_closed = TRUE THEN 1 END)
      comment: "Count of closed CAPA records — measures resolution throughput and backlog reduction."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`service_installed_base`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Installed base asset KPIs tracking operational performance, maintenance health, and reliability — foundational for service revenue forecasting and proactive maintenance strategy."
  source: "`vibe_manufacturing_v1`.`service`.`installed_base`"
  dimensions:
    - name: "install_status"
      expr: install_status
      comment: "Installation status of the asset for active base management and service coverage planning."
    - name: "product_category"
      expr: product_category
      comment: "Product category of the installed asset for service demand segmentation."
    - name: "maintenance_type"
      expr: maintenance_type
      comment: "Type of maintenance applied to the asset for maintenance strategy analysis."
    - name: "installation_method"
      expr: installation_method
      comment: "Method used for installation — correlates with reliability and service frequency."
    - name: "country_code"
      expr: country_code
      comment: "Country where the asset is installed for geographic service coverage analysis."
    - name: "commissioning_month"
      expr: DATE_TRUNC('MONTH', commissioning_date)
      comment: "Month of commissioning for installed base cohort and aging analysis."
  measures:
    - name: "total_installed_assets"
      expr: COUNT(1)
      comment: "Total installed base count — primary KPI for service addressable market sizing."
    - name: "total_operating_hours"
      expr: SUM(CAST(operating_hours AS DOUBLE))
      comment: "Total operating hours across the installed base — measures asset utilization and wear exposure."
    - name: "avg_mean_time_between_failures"
      expr: AVG(CAST(mean_time_between_failures_hours AS DOUBLE))
      comment: "Average MTBF across installed assets — key reliability KPI driving maintenance strategy decisions."
    - name: "avg_mean_time_to_repair"
      expr: AVG(CAST(mean_time_to_repair_hours AS DOUBLE))
      comment: "Average MTTR across installed assets — measures service responsiveness and repair efficiency."
    - name: "avg_overall_equipment_effectiveness"
      expr: AVG(CAST(overall_equipment_effectiveness AS DOUBLE))
      comment: "Average OEE across the installed base — composite asset performance KPI for service value demonstration."
    - name: "avg_power_rating_kw"
      expr: AVG(CAST(power_rating_kw AS DOUBLE))
      comment: "Average power rating of installed assets — used for energy and capacity planning."
    - name: "unique_customers_with_installed_assets"
      expr: COUNT(DISTINCT customer_account_id)
      comment: "Number of distinct customers with installed assets — measures service addressable customer base."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`service_remote_diagnostic_session`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Remote diagnostics KPIs measuring session efficiency, resolution rates, and field dispatch avoidance — quantifies the ROI of remote service capabilities vs. costly field dispatch."
  source: "`vibe_manufacturing_v1`.`service`.`remote_diagnostic_session`"
  dimensions:
    - name: "session_type"
      expr: session_type
      comment: "Type of remote diagnostic session for workload categorization and tool effectiveness analysis."
    - name: "session_status"
      expr: session_status
      comment: "Status of the session for completion rate and pipeline management."
    - name: "connection_type"
      expr: connection_type
      comment: "Connection type used (VPN, cloud, direct) for infrastructure performance analysis."
    - name: "diagnostic_result"
      expr: diagnostic_result
      comment: "Outcome of the diagnostic session for resolution effectiveness analysis."
    - name: "field_dispatch_needed"
      expr: field_dispatch_needed
      comment: "Whether a field dispatch was required after the session — primary KPI for remote resolution rate."
    - name: "resolved_flag"
      expr: resolved_flag
      comment: "Whether the issue was resolved remotely — measures remote fix rate and field dispatch avoidance."
    - name: "session_month"
      expr: DATE_TRUNC('MONTH', start_timestamp)
      comment: "Month the session started for remote service adoption trend analysis."
  measures:
    - name: "total_remote_sessions"
      expr: COUNT(1)
      comment: "Total remote diagnostic sessions — baseline volume KPI for remote service program scale."
    - name: "remote_resolution_count"
      expr: COUNT(CASE WHEN resolved_flag = TRUE THEN 1 END)
      comment: "Count of issues resolved remotely without field dispatch — measures remote service effectiveness."
    - name: "remote_resolution_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN resolved_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of remote sessions that resolved the issue without field dispatch — headline ROI KPI for remote service investment."
    - name: "field_dispatch_avoided_count"
      expr: COUNT(CASE WHEN field_dispatch_needed = FALSE THEN 1 END)
      comment: "Count of sessions where field dispatch was avoided — quantifies cost avoidance from remote diagnostics."
    - name: "avg_session_duration_minutes"
      expr: AVG(CAST(duration_minutes AS DOUBLE))
      comment: "Average remote session duration — measures diagnostic efficiency and engineer productivity."
    - name: "avg_bandwidth_mbps"
      expr: AVG(CAST(bandwidth_mbps AS DOUBLE))
      comment: "Average bandwidth used per session — informs infrastructure investment for remote service quality."
    - name: "avg_latency_ms"
      expr: AVG(CAST(latency_ms AS DOUBLE))
      comment: "Average session latency — measures connectivity quality impacting remote diagnostic effectiveness."
    - name: "total_data_volume_mb"
      expr: SUM(CAST(data_volume_mb AS DOUBLE))
      comment: "Total data volume transferred in remote sessions — informs network capacity planning."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`service_entitlement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Service entitlement utilization KPIs tracking SLA breach rates, remaining entitlement units, and coverage health — drives entitlement portfolio management and renewal strategy."
  source: "`vibe_manufacturing_v1`.`service`.`service_entitlement`"
  dimensions:
    - name: "entitlement_type"
      expr: entitlement_type
      comment: "Type of entitlement (e.g., incident-based, time-based) for portfolio mix analysis."
    - name: "entitlement_status"
      expr: entitlement_status
      comment: "Current status of the entitlement for active coverage management."
    - name: "coverage_level"
      expr: coverage_level
      comment: "Coverage level of the entitlement for SLA tier analysis."
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level of the entitlement for risk-weighted SLA management."
    - name: "acknowledgment_breach_flag"
      expr: acknowledgment_breach_flag
      comment: "Whether the acknowledgment SLA was breached — measures first-touch responsiveness."
    - name: "first_response_breach_flag"
      expr: first_response_breach_flag
      comment: "Whether the first response SLA was breached — key customer satisfaction driver."
    - name: "resolution_breach_flag"
      expr: resolution_breach_flag
      comment: "Whether the resolution SLA was breached — primary contract penalty risk indicator."
    - name: "effective_start_month"
      expr: DATE_TRUNC('MONTH', effective_start_date)
      comment: "Month entitlement became effective for cohort analysis."
  measures:
    - name: "total_entitlements"
      expr: COUNT(1)
      comment: "Total service entitlements — baseline for SLA compliance and coverage portfolio management."
    - name: "total_remaining_units"
      expr: SUM(CAST(remaining_units AS DOUBLE))
      comment: "Total remaining entitlement units across the portfolio — measures unused service capacity."
    - name: "total_entitlement_units"
      expr: SUM(CAST(total_units AS DOUBLE))
      comment: "Total entitlement units committed — measures contracted service volume."
    - name: "avg_remaining_units"
      expr: AVG(CAST(remaining_units AS DOUBLE))
      comment: "Average remaining units per entitlement — measures entitlement utilization rate."
    - name: "resolution_breach_count"
      expr: COUNT(CASE WHEN resolution_breach_flag = TRUE THEN 1 END)
      comment: "Count of resolution SLA breaches — primary contract penalty and churn risk KPI."
    - name: "resolution_breach_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN resolution_breach_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of entitlements with resolution SLA breaches — headline SLA compliance KPI."
    - name: "first_response_breach_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN first_response_breach_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of entitlements with first response SLA breaches — measures responsiveness compliance."
    - name: "unique_customers_with_entitlements"
      expr: COUNT(DISTINCT customer_account_id)
      comment: "Number of distinct customers with active entitlements — measures contracted customer base coverage."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`service_rma`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Service RMA (Return Merchandise Authorization) KPIs tracking return volume, credit value, repair costs, and warranty coverage — drives product quality and reverse logistics decisions."
  source: "`vibe_manufacturing_v1`.`service`.`service_rma`"
  dimensions:
    - name: "rma_status"
      expr: rma_status
      comment: "Current status of the RMA for pipeline and resolution tracking."
    - name: "return_reason_code"
      expr: return_reason_code
      comment: "Reason code for the return — identifies systemic product quality or service delivery issues."
    - name: "disposition"
      expr: disposition
      comment: "Disposition of the returned item (repair, replace, scrap) for reverse logistics cost analysis."
    - name: "is_under_warranty"
      expr: is_under_warranty
      comment: "Whether the RMA is covered under warranty — separates warranty vs. billable return costs."
    - name: "is_critical"
      expr: is_critical
      comment: "Whether the RMA is flagged as critical — prioritizes high-impact returns for expedited handling."
    - name: "return_shipment_method"
      expr: return_shipment_method
      comment: "Shipping method used for the return — informs reverse logistics cost optimization."
    - name: "request_month"
      expr: DATE_TRUNC('MONTH', request_timestamp)
      comment: "Month the RMA was requested for return volume trend analysis."
  measures:
    - name: "total_rma_records"
      expr: COUNT(1)
      comment: "Total RMA records — baseline return volume KPI for product quality and reverse logistics management."
    - name: "total_credit_amount"
      expr: SUM(CAST(credit_amount AS DOUBLE))
      comment: "Total credit amount issued for RMAs — measures financial impact of product returns on revenue."
    - name: "total_repair_cost"
      expr: SUM(CAST(repair_cost AS DOUBLE))
      comment: "Total repair cost for returned items — measures cost of quality and warranty liability."
    - name: "total_refund_amount"
      expr: SUM(CAST(refund_amount AS DOUBLE))
      comment: "Total refund amount issued — measures cash outflow from product return settlements."
    - name: "avg_repair_cost_per_rma"
      expr: AVG(CAST(repair_cost AS DOUBLE))
      comment: "Average repair cost per RMA — benchmarks repair efficiency and informs repair vs. replace decisions."
    - name: "warranty_rma_count"
      expr: COUNT(CASE WHEN is_under_warranty = TRUE THEN 1 END)
      comment: "Count of RMAs under warranty coverage — measures warranty claim volume and product reliability."
    - name: "warranty_rma_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_under_warranty = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of RMAs covered under warranty — measures warranty exposure as share of total returns."
    - name: "total_return_quantity"
      expr: SUM(CAST(return_quantity AS DOUBLE))
      comment: "Total quantity of units returned — measures physical return volume for reverse logistics planning."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`service_pm_schedule`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Preventive maintenance schedule KPIs tracking compliance, labor estimates, and schedule health — drives proactive maintenance strategy and asset uptime optimization."
  source: "`vibe_manufacturing_v1`.`service`.`service_pm_schedule`"
  dimensions:
    - name: "schedule_type"
      expr: schedule_type
      comment: "Type of PM schedule (time-based, usage-based) for maintenance strategy analysis."
    - name: "schedule_status"
      expr: schedule_status
      comment: "Current status of the PM schedule for compliance and backlog management."
    - name: "frequency_type"
      expr: frequency_type
      comment: "Frequency type of the schedule (daily, weekly, monthly) for maintenance workload planning."
    - name: "lifecycle_status"
      expr: lifecycle_status
      comment: "Lifecycle status of the PM schedule record for active schedule management."
    - name: "is_mandatory"
      expr: is_mandatory
      comment: "Whether the PM is mandatory — separates regulatory-required from optional maintenance."
    - name: "compliance_status"
      expr: compliance_status
      comment: "Compliance status of the PM schedule — measures regulatory and contractual maintenance adherence."
    - name: "next_due_month"
      expr: DATE_TRUNC('MONTH', next_due_date)
      comment: "Month the next PM is due for workload forecasting and resource planning."
  measures:
    - name: "total_pm_schedules"
      expr: COUNT(1)
      comment: "Total preventive maintenance schedules — baseline for PM program scope and coverage."
    - name: "total_estimated_labor_hours"
      expr: SUM(CAST(estimated_labor_hours AS DOUBLE))
      comment: "Total estimated labor hours for PM schedules — drives workforce capacity planning for maintenance."
    - name: "avg_estimated_duration_hours"
      expr: AVG(CAST(estimated_duration_hours AS DOUBLE))
      comment: "Average estimated duration per PM task — benchmarks job complexity and scheduling efficiency."
    - name: "avg_maintenance_interval"
      expr: AVG(CAST(maintenance_interval AS DOUBLE))
      comment: "Average maintenance interval across schedules — measures PM frequency and asset care intensity."
    - name: "mandatory_pm_count"
      expr: COUNT(CASE WHEN is_mandatory = TRUE THEN 1 END)
      comment: "Count of mandatory PM schedules — measures regulatory and contractual maintenance obligations."
    - name: "unique_equipment_under_pm"
      expr: COUNT(DISTINCT equipment_register_id)
      comment: "Number of distinct equipment assets covered by PM schedules — measures PM program reach."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`service_contract_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Service contract line KPIs tracking billing value, coverage scope, and SLA commitments at the line level — enables granular contract profitability and renewal analysis."
  source: "`vibe_manufacturing_v1`.`service`.`contract_line`"
  dimensions:
    - name: "contract_line_status"
      expr: contract_line_status
      comment: "Status of the contract line for active coverage and renewal pipeline management."
    - name: "coverage_type"
      expr: coverage_type
      comment: "Type of coverage provided (parts, labor, full) for cost-to-serve analysis."
    - name: "coverage_level"
      expr: coverage_level
      comment: "Coverage level tier for revenue and margin segmentation."
    - name: "billing_frequency"
      expr: billing_frequency
      comment: "Billing frequency for cash flow and revenue recognition planning."
    - name: "service_level"
      expr: service_level
      comment: "Service level committed on the contract line for SLA exposure analysis."
    - name: "auto_renew_flag"
      expr: auto_renew_flag
      comment: "Whether the contract line auto-renews — measures revenue retention stability at line level."
    - name: "start_month"
      expr: DATE_TRUNC('MONTH', start_date)
      comment: "Month the contract line started for cohort and vintage revenue analysis."
  measures:
    - name: "total_contract_lines"
      expr: COUNT(1)
      comment: "Total contract lines — baseline for contract portfolio granularity and coverage analysis."
    - name: "total_billing_amount"
      expr: SUM(CAST(billing_amount AS DOUBLE))
      comment: "Total billing amount across contract lines — measures contracted recurring revenue at line level."
    - name: "total_line_amount"
      expr: SUM(CAST(line_amount AS DOUBLE))
      comment: "Total line amount across all contract lines — measures total contracted service value."
    - name: "total_extended_price"
      expr: SUM(CAST(extended_price_amount AS DOUBLE))
      comment: "Total extended price across contract lines — measures full contract line revenue commitment."
    - name: "avg_unit_price"
      expr: AVG(CAST(unit_price AS DOUBLE))
      comment: "Average unit price per contract line — benchmarks pricing consistency and discount discipline."
    - name: "avg_sla_response_hours"
      expr: AVG(CAST(sla_response_hours AS DOUBLE))
      comment: "Average SLA response time committed per contract line — measures SLA stringency across the portfolio."
    - name: "avg_discount_percent"
      expr: AVG(CAST(discount_percent AS DOUBLE))
      comment: "Average discount applied per contract line — monitors pricing discipline and margin erosion."
    - name: "total_entitlement_hours"
      expr: SUM(CAST(entitlement_hours AS DOUBLE))
      comment: "Total entitlement hours committed across contract lines — measures contracted service labor volume."
$$;