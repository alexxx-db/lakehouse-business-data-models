-- Metric views for domain: technology | Business: Media_Broadcasting | Version: 3 | Generated on: 2026-07-10 19:06:42

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`technology_outage_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Operational KPIs for broadcast outage events — tracks outage frequency, duration, revenue impact, and SLA compliance to steer infrastructure reliability investments and incident response prioritization."
  source: "`vibe_media_broadcasting_v1`.`technology`.`outage_record`"
  dimensions:
    - name: "outage_type"
      expr: outage_type
      comment: "Category of outage (e.g., planned, unplanned, partial) for segmenting reliability analysis."
    - name: "impact_severity"
      expr: impact_severity
      comment: "Severity classification of the outage to prioritize response and track high-impact events."
    - name: "outage_status"
      expr: outage_status
      comment: "Current lifecycle status of the outage record (open, resolved, under review)."
    - name: "root_cause_category"
      expr: root_cause_category
      comment: "Root cause classification enabling trend analysis to drive preventive investment."
    - name: "affected_service_type"
      expr: affected_service_type
      comment: "Type of broadcast service affected, used to prioritize infrastructure hardening by service tier."
    - name: "sla_breach_flag"
      expr: sla_breach_flag
      comment: "Indicates whether the outage breached the SLA target uptime, critical for vendor and operational accountability."
    - name: "regulatory_reporting_required_flag"
      expr: regulatory_reporting_required_flag
      comment: "Flags outages requiring regulatory submission, ensuring compliance obligations are tracked."
    - name: "outage_month"
      expr: DATE_TRUNC('MONTH', outage_start_timestamp)
      comment: "Month of outage start for trend analysis and monthly reliability reporting."
  measures:
    - name: "total_outage_events"
      expr: COUNT(1)
      comment: "Total number of outage events recorded. Baseline volume metric for reliability trend analysis."
    - name: "total_outage_duration_minutes"
      expr: SUM(CAST(outage_duration_minutes AS DOUBLE))
      comment: "Aggregate minutes of broadcast downtime. Directly tied to SLA compliance and viewer impact — a primary infrastructure reliability KPI."
    - name: "avg_outage_duration_minutes"
      expr: AVG(CAST(outage_duration_minutes AS DOUBLE))
      comment: "Average duration per outage event. Tracks mean-time-to-restore trends and informs SLA target-setting."
    - name: "total_estimated_revenue_impact"
      expr: SUM(CAST(estimated_revenue_impact_amount AS DOUBLE))
      comment: "Total estimated revenue lost due to outages. Directly informs capital investment decisions for redundancy and resilience."
    - name: "avg_estimated_revenue_impact_per_outage"
      expr: AVG(CAST(estimated_revenue_impact_amount AS DOUBLE))
      comment: "Average revenue impact per outage event. Used to prioritize which outage types warrant the highest mitigation investment."
    - name: "total_affected_viewers"
      expr: SUM(CAST(affected_viewer_count_estimate AS DOUBLE))
      comment: "Total estimated viewers impacted across all outage events. Key subscriber experience and regulatory reporting metric."
    - name: "sla_breach_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN sla_breach_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of outage events that breached SLA targets. Core operational KPI for infrastructure governance and vendor accountability."
    - name: "regulatory_reportable_outage_count"
      expr: SUM(CASE WHEN regulatory_reporting_required_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of outages requiring regulatory reporting. Tracks compliance exposure and submission workload for the regulatory affairs team."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`technology_sla_performance_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "SLA attainment and breach analytics for technology services — measures availability performance against targets, breach frequency, and remediation effectiveness to drive service quality governance."
  source: "`vibe_media_broadcasting_v1`.`technology`.`sla_performance_record`"
  dimensions:
    - name: "compliance_status"
      expr: compliance_status
      comment: "Whether the SLA measurement period was compliant or in breach, for executive SLA health dashboards."
    - name: "breach_flag"
      expr: breach_flag
      comment: "Boolean indicator of SLA breach in the measurement period, used to filter and count breach events."
    - name: "breach_severity"
      expr: breach_severity
      comment: "Severity of the SLA breach to prioritize remediation and escalation actions."
    - name: "breach_root_cause_category"
      expr: breach_root_cause_category
      comment: "Root cause category of SLA breaches to identify systemic infrastructure weaknesses."
    - name: "remediation_status"
      expr: remediation_status
      comment: "Current status of remediation actions following a breach, for operational follow-through tracking."
    - name: "regulatory_reporting_required"
      expr: regulatory_reporting_required
      comment: "Flags measurement periods requiring regulatory submission for compliance tracking."
    - name: "measurement_period_month"
      expr: DATE_TRUNC('MONTH', measurement_period_start)
      comment: "Month of the SLA measurement period for trend analysis and monthly governance reporting."
  measures:
    - name: "total_measurement_periods"
      expr: COUNT(1)
      comment: "Total SLA measurement periods evaluated. Baseline for calculating breach rates and compliance percentages."
    - name: "avg_measured_availability_pct"
      expr: AVG(CAST(measured_availability_percentage AS DOUBLE))
      comment: "Average measured availability percentage across all SLA periods. Primary KPI for infrastructure uptime governance and board-level reporting."
    - name: "avg_target_availability_pct"
      expr: AVG(CAST(target_availability_percentage AS DOUBLE))
      comment: "Average SLA target availability percentage. Provides the benchmark against which measured availability is evaluated."
    - name: "total_downtime_minutes"
      expr: SUM(CAST(total_downtime_minutes AS DOUBLE))
      comment: "Aggregate downtime minutes across all SLA measurement periods. Directly tied to service credit exposure and regulatory reporting."
    - name: "avg_actual_mttr_minutes"
      expr: AVG(CAST(actual_mttr_minutes AS DOUBLE))
      comment: "Average mean-time-to-restore across measurement periods. Tracks incident response efficiency and informs staffing and tooling investments."
    - name: "avg_target_mttr_minutes"
      expr: AVG(CAST(target_mttr_minutes AS DOUBLE))
      comment: "Average MTTR target across SLA definitions. Used alongside actual MTTR to compute performance gap."
    - name: "sla_breach_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN breach_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of measurement periods with an SLA breach. Core governance KPI for technology leadership and vendor management."
    - name: "total_service_credit_amount"
      expr: SUM(CAST(service_credit_amount AS DOUBLE))
      comment: "Total service credits issued due to SLA breaches. Quantifies financial exposure from underperforming infrastructure or vendors."
    - name: "total_breach_duration_minutes"
      expr: SUM(CAST(breach_duration_minutes AS DOUBLE))
      comment: "Total minutes of SLA breach across all periods. Measures cumulative service degradation for contract and regulatory review."
    - name: "availability_gap_avg_pct"
      expr: ROUND(AVG(CAST(target_availability_percentage AS DOUBLE) - CAST(measured_availability_percentage AS DOUBLE)), 4)
      comment: "Average gap between target and measured availability. Negative values indicate over-performance; positive values signal systemic underdelivery requiring executive action."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`technology_maintenance_work_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Maintenance execution KPIs for broadcast and IT infrastructure — tracks work order volume, cost, labor efficiency, SLA compliance, and downtime impact to optimize maintenance operations and vendor performance."
  source: "`vibe_media_broadcasting_v1`.`technology`.`maintenance_work_order`"
  dimensions:
    - name: "work_order_type"
      expr: work_order_type
      comment: "Type of maintenance work order (preventive, corrective, emergency) for cost and efficiency segmentation."
    - name: "maintenance_work_order_status"
      expr: maintenance_work_order_status
      comment: "Current status of the work order lifecycle for operational pipeline visibility."
    - name: "priority"
      expr: priority
      comment: "Priority level of the work order to analyze response time compliance by urgency tier."
    - name: "sla_compliance_flag"
      expr: sla_compliance_flag
      comment: "Whether the work order was completed within SLA targets, for vendor and team accountability."
    - name: "outage_required_flag"
      expr: outage_required_flag
      comment: "Indicates whether the maintenance required a service outage, used to quantify planned downtime impact."
    - name: "safety_incident_flag"
      expr: safety_incident_flag
      comment: "Flags work orders associated with safety incidents for HSE reporting and risk management."
    - name: "warranty_claim_flag"
      expr: warranty_claim_flag
      comment: "Indicates warranty claims filed, used to track vendor warranty utilization and cost recovery."
    - name: "scheduled_month"
      expr: DATE_TRUNC('MONTH', scheduled_start_datetime)
      comment: "Month of scheduled maintenance start for capacity planning and trend analysis."
  measures:
    - name: "total_work_orders"
      expr: COUNT(1)
      comment: "Total maintenance work orders. Baseline volume metric for maintenance capacity planning."
    - name: "total_maintenance_cost"
      expr: SUM(CAST(total_cost_amount AS DOUBLE))
      comment: "Total cost of all maintenance work orders. Primary financial KPI for maintenance budget management and vendor spend control."
    - name: "avg_maintenance_cost_per_order"
      expr: AVG(CAST(total_cost_amount AS DOUBLE))
      comment: "Average cost per maintenance work order. Benchmarks efficiency and identifies cost outliers by type or vendor."
    - name: "total_labor_cost"
      expr: SUM(CAST(labor_cost_amount AS DOUBLE))
      comment: "Total labor cost across all work orders. Informs workforce planning and labor vs. parts cost ratio analysis."
    - name: "total_parts_cost"
      expr: SUM(CAST(parts_cost_amount AS DOUBLE))
      comment: "Total parts and materials cost. Tracks supply chain spend and informs procurement strategy for spare parts inventory."
    - name: "total_labor_hours"
      expr: SUM(CAST(labor_hours AS DOUBLE))
      comment: "Total labor hours expended on maintenance. Measures workforce utilization and informs staffing level decisions."
    - name: "avg_downtime_duration_minutes"
      expr: AVG(CAST(downtime_duration_minutes AS DOUBLE))
      comment: "Average service downtime per work order. Tracks maintenance-induced disruption and informs scheduling optimization."
    - name: "sla_compliance_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN sla_compliance_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of work orders completed within SLA targets. Core KPI for maintenance team and vendor performance governance."
    - name: "safety_incident_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN safety_incident_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of work orders with associated safety incidents. Critical HSE metric for regulatory compliance and risk management."
    - name: "warranty_claim_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN warranty_claim_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of work orders resulting in warranty claims. Measures vendor equipment reliability and cost recovery effectiveness."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`technology_tech_incident`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Technology incident management KPIs — tracks incident volume, severity distribution, resolution speed, SLA compliance, and post-incident review completion to drive service reliability and ITSM process maturity."
  source: "`vibe_media_broadcasting_v1`.`technology`.`tech_incident`"
  dimensions:
    - name: "tech_incident_status"
      expr: tech_incident_status
      comment: "Current lifecycle status of the incident (open, in-progress, resolved, closed) for pipeline visibility."
    - name: "severity"
      expr: severity
      comment: "Incident severity level for prioritization and executive escalation tracking."
    - name: "incident_category"
      expr: incident_category
      comment: "Category of the incident to identify systemic problem areas requiring investment."
    - name: "root_cause_category"
      expr: root_cause_category
      comment: "Root cause classification to drive preventive action and reduce repeat incidents."
    - name: "sla_breach_flag"
      expr: sla_breach_flag
      comment: "Indicates SLA breach for the incident, used to measure response and resolution compliance."
    - name: "post_incident_review_flag"
      expr: post_incident_review_flag
      comment: "Whether a post-incident review was conducted, tracking process maturity and learning culture."
    - name: "workaround_applied"
      expr: workaround_applied
      comment: "Indicates a workaround was used rather than a permanent fix, flagging technical debt and recurring risk."
    - name: "reported_month"
      expr: DATE_TRUNC('MONTH', reported_timestamp)
      comment: "Month the incident was reported for trend analysis and monthly operational reviews."
  measures:
    - name: "total_incidents"
      expr: COUNT(1)
      comment: "Total technology incidents recorded. Baseline volume metric for reliability trend analysis and capacity planning."
    - name: "sla_breach_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN sla_breach_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of incidents that breached SLA response or resolution targets. Primary ITSM governance KPI for technology leadership."
    - name: "post_incident_review_completion_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN post_incident_review_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of incidents with a completed post-incident review. Measures process maturity and organizational learning effectiveness."
    - name: "workaround_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN workaround_applied = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of incidents resolved via workaround rather than permanent fix. High rates signal technical debt accumulation requiring investment."
    - name: "critical_incident_count"
      expr: SUM(CASE WHEN severity = 'Critical' THEN 1 ELSE 0 END)
      comment: "Count of critical severity incidents. Tracks the most impactful events for executive escalation and board-level risk reporting."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`technology_tech_change_request`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Change management KPIs for technology infrastructure — tracks change volume, approval rates, implementation outcomes, risk levels, and effort accuracy to govern change velocity and reduce change-induced incidents."
  source: "`vibe_media_broadcasting_v1`.`technology`.`tech_change_request`"
  dimensions:
    - name: "change_type"
      expr: change_type
      comment: "Type of change (standard, normal, emergency) for risk and velocity segmentation."
    - name: "change_status"
      expr: change_status
      comment: "Current lifecycle status of the change request for pipeline and backlog management."
    - name: "change_category"
      expr: change_category
      comment: "Business category of the change to identify which domains drive the most change activity."
    - name: "risk_level"
      expr: risk_level
      comment: "Risk classification of the change for CAB prioritization and governance oversight."
    - name: "cab_approval_status"
      expr: cab_approval_status
      comment: "Change Advisory Board approval status to track governance compliance and approval cycle times."
    - name: "implementation_outcome"
      expr: implementation_outcome
      comment: "Outcome of the change implementation (successful, failed, rolled back) for quality measurement."
    - name: "downtime_required"
      expr: downtime_required
      comment: "Whether the change required service downtime, used to quantify planned disruption from change activity."
    - name: "submitted_month"
      expr: DATE_TRUNC('MONTH', submitted_timestamp)
      comment: "Month the change request was submitted for trend analysis and change velocity reporting."
  measures:
    - name: "total_change_requests"
      expr: COUNT(1)
      comment: "Total change requests submitted. Baseline metric for change velocity and capacity planning."
    - name: "cab_approval_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN cab_approval_status = 'Approved' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of change requests approved by the CAB. Tracks governance throughput and identifies bottlenecks in the approval process."
    - name: "change_success_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN implementation_outcome = 'Successful' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of implemented changes with a successful outcome. Primary change quality KPI — low rates indicate process or testing gaps."
    - name: "change_rollback_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN implementation_outcome = 'Rolled Back' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of changes that required rollback. High rollback rates signal inadequate testing or risk assessment, driving investment in change quality controls."
    - name: "total_actual_effort_hours"
      expr: SUM(CAST(actual_effort_hours AS DOUBLE))
      comment: "Total actual effort hours expended on change implementation. Informs workforce capacity planning for technology operations."
    - name: "total_estimated_effort_hours"
      expr: SUM(CAST(estimated_effort_hours AS DOUBLE))
      comment: "Total estimated effort hours for change requests. Used alongside actual hours to compute estimation accuracy."
    - name: "effort_estimation_accuracy_pct"
      expr: ROUND(100.0 * SUM(CAST(actual_effort_hours AS DOUBLE)) / NULLIF(SUM(CAST(estimated_effort_hours AS DOUBLE)), 0), 2)
      comment: "Ratio of actual to estimated effort hours as a percentage. Values above 100% indicate systematic underestimation, informing planning process improvements."
    - name: "high_risk_change_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN risk_level = 'High' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of change requests classified as high risk. Tracks risk exposure in the change portfolio for executive governance."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`technology_vendor_contract`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Technology vendor contract portfolio KPIs — tracks contract value, renewal risk, SLA tier distribution, and auto-renewal exposure to optimize vendor spend and reduce contract lapse risk."
  source: "`vibe_media_broadcasting_v1`.`technology`.`vendor_contract`"
  dimensions:
    - name: "contract_type"
      expr: contract_type
      comment: "Type of vendor contract (maintenance, SaaS, professional services) for spend category analysis."
    - name: "contract_status"
      expr: contract_status
      comment: "Current status of the contract (active, expired, pending renewal) for portfolio health monitoring."
    - name: "sla_tier"
      expr: sla_tier
      comment: "SLA tier of the vendor contract to analyze service quality commitments by spend level."
    - name: "auto_renewal_flag"
      expr: auto_renewal_flag
      comment: "Whether the contract auto-renews, used to identify contracts requiring proactive review before renewal."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the contract for multi-currency spend normalization and reporting."
    - name: "contract_end_year"
      expr: DATE_TRUNC('YEAR', end_date)
      comment: "Year the contract expires for renewal pipeline planning and budget forecasting."
  measures:
    - name: "total_active_contracts"
      expr: COUNT(1)
      comment: "Total vendor contracts in the portfolio. Baseline for vendor relationship management and procurement governance."
    - name: "total_annual_contract_value"
      expr: SUM(CAST(annual_value AS DOUBLE))
      comment: "Total annualized value of all vendor contracts. Primary spend KPI for technology procurement governance and budget planning."
    - name: "avg_annual_contract_value"
      expr: AVG(CAST(annual_value AS DOUBLE))
      comment: "Average annual value per vendor contract. Benchmarks contract size and identifies outliers for renegotiation."
    - name: "avg_uptime_guarantee_pct"
      expr: AVG(CAST(uptime_guarantee_percent AS DOUBLE))
      comment: "Average uptime guarantee across vendor contracts. Tracks the contractual reliability baseline committed by technology vendors."
    - name: "auto_renewal_contract_count"
      expr: SUM(CASE WHEN auto_renewal_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of contracts set to auto-renew. Identifies contracts requiring proactive review to avoid unintended spend commitments."
    - name: "auto_renewal_value_at_risk"
      expr: SUM(CASE WHEN auto_renewal_flag = TRUE THEN annual_value ELSE 0 END)
      comment: "Total annual value of auto-renewing contracts. Quantifies spend at risk of automatic commitment without active renegotiation."
    - name: "avg_response_time_hours"
      expr: AVG(CAST(response_time_hours AS DOUBLE))
      comment: "Average contractual vendor response time in hours. Tracks service responsiveness commitments across the vendor portfolio."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`technology_capacity_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Infrastructure capacity planning KPIs — tracks utilization rates, projected growth, capital investment requirements, and threshold breach risk to drive proactive infrastructure scaling decisions."
  source: "`vibe_media_broadcasting_v1`.`technology`.`capacity_plan`"
  dimensions:
    - name: "infrastructure_domain"
      expr: infrastructure_domain
      comment: "Infrastructure domain (compute, storage, network, etc.) for capacity analysis by technology layer."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the capacity plan for governance pipeline tracking."
    - name: "implementation_priority"
      expr: implementation_priority
      comment: "Priority of the capacity plan implementation for resource allocation and scheduling."
    - name: "planning_period_type"
      expr: planning_period_type
      comment: "Type of planning period (annual, quarterly, rolling) for temporal segmentation of capacity analysis."
    - name: "recommended_action"
      expr: recommended_action
      comment: "Recommended capacity action (expand, optimize, decommission) for investment decision support."
    - name: "technology_platform"
      expr: technology_platform
      comment: "Technology platform covered by the capacity plan for platform-level investment analysis."
    - name: "planning_start_year"
      expr: DATE_TRUNC('YEAR', planning_start_date)
      comment: "Year the planning period begins for multi-year capacity roadmap analysis."
  measures:
    - name: "total_capacity_plans"
      expr: COUNT(1)
      comment: "Total capacity plans in the portfolio. Baseline for planning coverage and governance completeness."
    - name: "avg_current_utilization_pct"
      expr: AVG(CAST(current_utilization_percentage AS DOUBLE))
      comment: "Average current infrastructure utilization percentage. Primary capacity health KPI — high values signal imminent scaling requirements."
    - name: "avg_projected_growth_rate_pct"
      expr: AVG(CAST(projected_growth_rate_percentage AS DOUBLE))
      comment: "Average projected demand growth rate. Informs multi-year capital planning and procurement lead time decisions."
    - name: "total_estimated_capex"
      expr: SUM(CAST(estimated_capex_amount AS DOUBLE))
      comment: "Total estimated capital expenditure across all capacity plans. Primary financial input for technology capital budget requests."
    - name: "total_estimated_annual_opex"
      expr: SUM(CAST(estimated_opex_annual_amount AS DOUBLE))
      comment: "Total estimated annual operating expenditure from capacity plans. Informs operational budget forecasting for technology leadership."
    - name: "avg_capacity_threshold_pct"
      expr: AVG(CAST(capacity_threshold_percentage AS DOUBLE))
      comment: "Average capacity threshold percentage at which action is triggered. Tracks how conservatively infrastructure thresholds are set across the portfolio."
    - name: "plans_above_threshold_count"
      expr: SUM(CASE WHEN current_utilization_percentage >= capacity_threshold_percentage THEN 1 ELSE 0 END)
      comment: "Number of capacity plans where current utilization has breached the defined threshold. Immediate action indicator for infrastructure scaling decisions."
    - name: "total_recommended_capacity_addition"
      expr: SUM(CAST(recommended_capacity_addition AS DOUBLE))
      comment: "Total recommended capacity additions across all plans. Quantifies the scale of infrastructure investment required to meet projected demand."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`technology_equipment_procurement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Technology equipment procurement KPIs — tracks spend, delivery performance, approval cycle efficiency, and procurement pipeline health to optimize capital equipment acquisition and vendor management."
  source: "`vibe_media_broadcasting_v1`.`technology`.`equipment_procurement`"
  dimensions:
    - name: "procurement_status"
      expr: procurement_status
      comment: "Current status of the procurement (pending, approved, delivered, cancelled) for pipeline visibility."
    - name: "procurement_type"
      expr: procurement_type
      comment: "Type of procurement (purchase, lease, rental) for spend category and financial treatment analysis."
    - name: "equipment_category"
      expr: equipment_category
      comment: "Category of equipment procured for spend analysis by technology asset class."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the procurement request for governance and cycle time analysis."
    - name: "goods_receipt_confirmed"
      expr: goods_receipt_confirmed
      comment: "Whether goods receipt has been confirmed, used to track delivery completion and trigger payment."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the procurement for multi-currency spend normalization."
    - name: "order_month"
      expr: DATE_TRUNC('MONTH', order_date)
      comment: "Month the procurement order was placed for spend trend analysis and budget cycle reporting."
  measures:
    - name: "total_procurement_orders"
      expr: COUNT(1)
      comment: "Total equipment procurement orders. Baseline volume metric for procurement pipeline management."
    - name: "total_procurement_spend"
      expr: SUM(CAST(total_amount AS DOUBLE))
      comment: "Total procurement spend across all orders. Primary capital expenditure KPI for technology asset investment governance."
    - name: "avg_unit_cost"
      expr: AVG(CAST(unit_cost AS DOUBLE))
      comment: "Average unit cost of procured equipment. Benchmarks pricing and identifies opportunities for volume discount negotiation."
    - name: "total_shipping_cost"
      expr: SUM(CAST(shipping_cost AS DOUBLE))
      comment: "Total shipping and logistics cost. Tracks ancillary procurement costs for total cost of ownership analysis."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax paid on equipment procurement. Required for financial reporting and tax planning."
    - name: "goods_receipt_confirmation_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN goods_receipt_confirmed = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of procurement orders with confirmed goods receipt. Tracks delivery completion rate and identifies outstanding deliveries requiring follow-up."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`technology_noc_alert`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Network Operations Center alert KPIs — tracks alert volume, severity distribution, resolution speed, SLA compliance, and auto-resolution rates to optimize NOC operations and infrastructure monitoring effectiveness."
  source: "`vibe_media_broadcasting_v1`.`technology`.`noc_alert`"
  dimensions:
    - name: "alert_type"
      expr: alert_type
      comment: "Type of NOC alert (signal loss, equipment failure, network degradation) for root cause pattern analysis."
    - name: "alert_severity"
      expr: alert_severity
      comment: "Severity of the alert for prioritization and escalation tracking."
    - name: "alert_status"
      expr: alert_status
      comment: "Current status of the alert (open, acknowledged, resolved) for operational pipeline visibility."
    - name: "escalation_level"
      expr: escalation_level
      comment: "Escalation tier reached by the alert, indicating severity of operational response required."
    - name: "sla_breach_flag"
      expr: sla_breach_flag
      comment: "Whether the alert breached its SLA resolution target, for NOC performance governance."
    - name: "auto_resolution_flag"
      expr: auto_resolution_flag
      comment: "Whether the alert was resolved automatically, tracking automation effectiveness in NOC operations."
    - name: "root_cause_category"
      expr: root_cause_category
      comment: "Root cause category of the alert to identify systemic infrastructure weaknesses."
    - name: "alert_month"
      expr: DATE_TRUNC('MONTH', alert_timestamp)
      comment: "Month the alert was triggered for trend analysis and monthly NOC performance reporting."
  measures:
    - name: "total_alerts"
      expr: COUNT(1)
      comment: "Total NOC alerts generated. Baseline volume metric for infrastructure health trending and NOC workload planning."
    - name: "sla_breach_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN sla_breach_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of NOC alerts that breached SLA resolution targets. Core NOC performance KPI for operations leadership."
    - name: "auto_resolution_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN auto_resolution_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of alerts resolved automatically without human intervention. Measures NOC automation maturity and efficiency gains."
    - name: "notification_sent_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN notification_sent_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of alerts for which stakeholder notifications were sent. Tracks communication compliance for high-impact events."
    - name: "critical_alert_count"
      expr: SUM(CASE WHEN alert_severity = 'Critical' THEN 1 ELSE 0 END)
      comment: "Count of critical severity NOC alerts. Tracks the most impactful infrastructure events for executive and regulatory reporting."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`technology_software_license`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Software license portfolio KPIs — tracks license spend, compliance status, renewal risk, and auto-renewal exposure to optimize software asset management and reduce compliance and financial risk."
  source: "`vibe_media_broadcasting_v1`.`technology`.`software_license`"
  dimensions:
    - name: "license_type"
      expr: license_type
      comment: "Type of software license (perpetual, subscription, concurrent) for cost model and compliance analysis."
    - name: "license_status"
      expr: license_status
      comment: "Current status of the license (active, expired, pending renewal) for portfolio health monitoring."
    - name: "compliance_status"
      expr: compliance_status
      comment: "Compliance status of the license (compliant, over-deployed, under-utilized) for audit risk management."
    - name: "auto_renewal_flag"
      expr: auto_renewal_flag
      comment: "Whether the license auto-renews, identifying contracts requiring proactive review."
    - name: "primary_usage_category"
      expr: primary_usage_category
      comment: "Primary business use category of the software for spend allocation and rationalization analysis."
    - name: "maintenance_included_flag"
      expr: maintenance_included_flag
      comment: "Whether maintenance and support is included in the license cost for total cost of ownership analysis."
    - name: "expiry_year"
      expr: DATE_TRUNC('YEAR', expiry_date)
      comment: "Year the license expires for renewal pipeline planning and budget forecasting."
  measures:
    - name: "total_licenses"
      expr: COUNT(1)
      comment: "Total software licenses in the portfolio. Baseline for software asset management governance."
    - name: "total_license_cost"
      expr: SUM(CAST(license_cost_usd AS DOUBLE))
      comment: "Total software license acquisition cost. Primary spend KPI for software asset management and IT budget governance."
    - name: "total_annual_maintenance_cost"
      expr: SUM(CAST(annual_maintenance_cost_usd AS DOUBLE))
      comment: "Total annual maintenance and support cost across all licenses. Tracks recurring software spend for operational budget planning."
    - name: "avg_license_cost"
      expr: AVG(CAST(license_cost_usd AS DOUBLE))
      comment: "Average license acquisition cost. Benchmarks software spend and identifies high-cost licenses for rationalization review."
    - name: "non_compliant_license_count"
      expr: SUM(CASE WHEN compliance_status != 'Compliant' THEN 1 ELSE 0 END)
      comment: "Count of licenses not in compliance status. Tracks audit risk exposure and drives remediation prioritization."
    - name: "auto_renewal_annual_cost_at_risk"
      expr: SUM(CASE WHEN auto_renewal_flag = TRUE THEN annual_maintenance_cost_usd ELSE 0 END)
      comment: "Total annual maintenance cost of auto-renewing licenses. Quantifies spend committed without active renegotiation, informing procurement review priorities."
$$;