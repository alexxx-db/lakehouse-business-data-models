-- Metric views for domain: technology | Business: Media_Broadcasting | Version: 2 | Generated on: 2026-06-30 04:55:25

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`technology_outage_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Operational reliability KPIs for broadcast/network outages: duration, viewer impact, revenue impact, SLA breaches, and regulatory exposure. Used by NOC leadership and operations VPs to steer reliability investment."
  source: "`vibe_media_broadcasting_v1`.`technology`.`outage_record`"
  dimensions:
    - name: "outage_status"
      expr: outage_status
      comment: "Lifecycle status of the outage (open, resolved, etc.) for steering open-incident backlog."
    - name: "outage_type"
      expr: outage_type
      comment: "Category of outage for root-cause trend analysis."
    - name: "impact_severity"
      expr: impact_severity
      comment: "Severity classification to prioritise high-impact outages."
    - name: "affected_service_type"
      expr: affected_service_type
      comment: "Type of service affected (linear, OTT, etc.) for service-level reporting."
    - name: "root_cause_category"
      expr: root_cause_category
      comment: "Root-cause grouping for systemic problem identification."
    - name: "affected_geographic_region"
      expr: affected_geographic_region
      comment: "Geographic region impacted for regional reliability comparison."
    - name: "outage_start_month"
      expr: DATE_TRUNC('MONTH', outage_start_timestamp)
      comment: "Month bucket of outage start for trend lines."
  measures:
    - name: "Outage Count"
      expr: COUNT(1)
      comment: "Number of outage records — baseline reliability volume."
    - name: "Total Outage Downtime Minutes"
      expr: SUM(CAST(outage_duration_minutes AS DOUBLE))
      comment: "Cumulative downtime in minutes — drives availability and MTTR posture."
    - name: "Avg Outage Duration Minutes"
      expr: AVG(CAST(outage_duration_minutes AS DOUBLE))
      comment: "Average outage duration — operational responsiveness indicator."
    - name: "Total Estimated Revenue Impact"
      expr: SUM(CAST(estimated_revenue_impact_amount AS DOUBLE))
      comment: "Total estimated revenue lost to outages — financial steering metric."
    - name: "Total Affected Viewers"
      expr: SUM(CAST(affected_viewer_count_estimate AS DOUBLE))
      comment: "Aggregate estimated viewers impacted — customer-impact severity."
    - name: "SLA Breach Count"
      expr: SUM(CASE WHEN sla_breach_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of outages breaching SLA — contractual risk exposure."
    - name: "SLA Breach Rate Pct"
      expr: ROUND(100.0 * SUM(CASE WHEN sla_breach_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of outages that breached SLA — reliability quality KPI."
    - name: "Regulatory Reportable Outage Count"
      expr: SUM(CASE WHEN regulatory_reporting_required_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Outages requiring regulatory reporting — compliance exposure."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`technology_sla_performance_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "SLA attainment KPIs: measured vs target availability, MTTR, breach severity, and service-credit exposure. Used in vendor/service governance reviews."
  source: "`vibe_media_broadcasting_v1`.`technology`.`sla_performance_record`"
  dimensions:
    - name: "compliance_status"
      expr: compliance_status
      comment: "Compliance status of the SLA period for attainment reporting."
    - name: "breach_severity"
      expr: breach_severity
      comment: "Severity of the breach for prioritisation."
    - name: "breach_root_cause_category"
      expr: breach_root_cause_category
      comment: "Breach root-cause grouping for systemic remediation."
    - name: "remediation_status"
      expr: remediation_status
      comment: "Status of remediation work tied to breaches."
    - name: "measurement_period_month"
      expr: DATE_TRUNC('MONTH', measurement_period_start)
      comment: "Month bucket of measurement period for trend analysis."
  measures:
    - name: "SLA Record Count"
      expr: COUNT(1)
      comment: "Number of SLA measurement records — baseline coverage."
    - name: "Avg Measured Availability Pct"
      expr: AVG(CAST(measured_availability_percentage AS DOUBLE))
      comment: "Average measured availability — core reliability attainment."
    - name: "Avg Target Availability Pct"
      expr: AVG(CAST(target_availability_percentage AS DOUBLE))
      comment: "Average target availability for variance comparison."
    - name: "Avg Actual MTTR Minutes"
      expr: AVG(CAST(actual_mttr_minutes AS DOUBLE))
      comment: "Average mean-time-to-restore — operational efficiency KPI."
    - name: "Avg Target MTTR Minutes"
      expr: AVG(CAST(target_mttr_minutes AS DOUBLE))
      comment: "Average target MTTR for benchmarking against actuals."
    - name: "Breach Count"
      expr: SUM(CASE WHEN breach_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of SLA breaches — contractual risk volume."
    - name: "Breach Rate Pct"
      expr: ROUND(100.0 * SUM(CASE WHEN breach_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of periods in breach — service quality KPI."
    - name: "Total Service Credit Amount"
      expr: SUM(CAST(service_credit_amount AS DOUBLE))
      comment: "Total service credits owed due to breaches — financial penalty exposure."
    - name: "Total Downtime Minutes"
      expr: SUM(CAST(total_downtime_minutes AS DOUBLE))
      comment: "Aggregate downtime across SLA periods."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`technology_maintenance_work_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Maintenance execution KPIs: labor/parts/total cost, downtime, SLA compliance and safety incidents. Used to steer maintenance spend and field-ops efficiency."
  source: "`vibe_media_broadcasting_v1`.`technology`.`maintenance_work_order`"
  dimensions:
    - name: "work_order_status"
      expr: maintenance_work_order_status
      comment: "Status of the work order for backlog and completion tracking."
    - name: "work_order_type"
      expr: work_order_type
      comment: "Type of maintenance work (preventive, corrective) for mix analysis."
    - name: "priority"
      expr: priority
      comment: "Priority of the work order for SLA prioritisation."
    - name: "root_cause"
      expr: root_cause
      comment: "Root cause for recurring-failure analysis."
    - name: "scheduled_start_month"
      expr: DATE_TRUNC('MONTH', scheduled_start_datetime)
      comment: "Month bucket of scheduled start for trend reporting."
  measures:
    - name: "Work Order Count"
      expr: COUNT(1)
      comment: "Number of maintenance work orders — workload volume."
    - name: "Total Maintenance Cost"
      expr: SUM(CAST(total_cost_amount AS DOUBLE))
      comment: "Total maintenance cost — budget steering KPI."
    - name: "Total Labor Cost"
      expr: SUM(CAST(labor_cost_amount AS DOUBLE))
      comment: "Total labor cost component of maintenance spend."
    - name: "Total Parts Cost"
      expr: SUM(CAST(parts_cost_amount AS DOUBLE))
      comment: "Total parts cost component of maintenance spend."
    - name: "Total Labor Hours"
      expr: SUM(CAST(labor_hours AS DOUBLE))
      comment: "Total labor hours — resource capacity consumption."
    - name: "Total Downtime Minutes"
      expr: SUM(CAST(downtime_duration_minutes AS DOUBLE))
      comment: "Total equipment downtime caused by maintenance."
    - name: "SLA Compliant Count"
      expr: SUM(CASE WHEN sla_compliance_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Work orders meeting SLA — execution quality."
    - name: "SLA Compliance Rate Pct"
      expr: ROUND(100.0 * SUM(CASE WHEN sla_compliance_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of work orders meeting SLA — field-ops quality KPI."
    - name: "Safety Incident Count"
      expr: SUM(CASE WHEN safety_incident_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Maintenance work orders with safety incidents — risk indicator."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`technology_tech_incident`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Technology incident management KPIs: volume, severity mix, SLA breaches and post-incident-review coverage. Used by ITSM/NOC governance."
  source: "`vibe_media_broadcasting_v1`.`technology`.`tech_incident`"
  dimensions:
    - name: "incident_status"
      expr: tech_incident_status
      comment: "Incident lifecycle status for open-backlog steering."
    - name: "severity"
      expr: severity
      comment: "Incident severity classification for prioritisation."
    - name: "priority"
      expr: priority
      comment: "Incident priority for SLA management."
    - name: "incident_category"
      expr: incident_category
      comment: "Incident category for trend and pattern analysis."
    - name: "root_cause_category"
      expr: root_cause_category
      comment: "Root-cause grouping for problem management."
    - name: "reported_month"
      expr: DATE_TRUNC('MONTH', reported_timestamp)
      comment: "Month bucket of report time for trend reporting."
  measures:
    - name: "Incident Count"
      expr: COUNT(1)
      comment: "Number of technology incidents — operational health volume."
    - name: "SLA Breach Count"
      expr: SUM(CASE WHEN sla_breach_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Incidents breaching SLA — service quality risk."
    - name: "SLA Breach Rate Pct"
      expr: ROUND(100.0 * SUM(CASE WHEN sla_breach_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of incidents breaching SLA — quality KPI."
    - name: "PIR Required Count"
      expr: SUM(CASE WHEN post_incident_review_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Incidents requiring post-incident review — governance coverage."
    - name: "Workaround Applied Count"
      expr: SUM(CASE WHEN workaround_applied = TRUE THEN 1 ELSE 0 END)
      comment: "Incidents resolved via workaround — temporary-fix indicator."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`technology_vendor_contract`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Technology vendor contract portfolio KPIs: annual value, uptime/SLA commitments and auto-renewal exposure. Used by procurement and tech finance governance."
  source: "`vibe_media_broadcasting_v1`.`technology`.`vendor_contract`"
  dimensions:
    - name: "contract_status"
      expr: contract_status
      comment: "Contract status for active-portfolio steering."
    - name: "contract_type"
      expr: contract_type
      comment: "Type of contract for spend categorisation."
    - name: "sla_tier"
      expr: sla_tier
      comment: "SLA tier of the vendor contract for service-criticality analysis."
    - name: "procurement_method"
      expr: procurement_method
      comment: "Procurement method for sourcing governance."
    - name: "end_month"
      expr: DATE_TRUNC('MONTH', end_date)
      comment: "Month bucket of contract end for renewal-pipeline planning."
  measures:
    - name: "Contract Count"
      expr: COUNT(1)
      comment: "Number of vendor contracts — portfolio size."
    - name: "Total Annual Contract Value"
      expr: SUM(CAST(annual_value AS DOUBLE))
      comment: "Aggregate annual contracted spend — budget steering KPI."
    - name: "Avg Annual Contract Value"
      expr: AVG(CAST(annual_value AS DOUBLE))
      comment: "Average annual contract value — concentration indicator."
    - name: "Avg Uptime Guarantee Pct"
      expr: AVG(CAST(uptime_guarantee_percent AS DOUBLE))
      comment: "Average guaranteed uptime across contracts — service-level posture."
    - name: "Avg Escalation Rate Pct"
      expr: AVG(CAST(escalation_rate_percent AS DOUBLE))
      comment: "Average annual price escalation — cost-inflation exposure."
    - name: "Auto Renewal Count"
      expr: SUM(CASE WHEN auto_renewal_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Contracts set to auto-renew — renewal-leakage risk."
    - name: "Auto Renewal Rate Pct"
      expr: ROUND(100.0 * SUM(CASE WHEN auto_renewal_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of contracts auto-renewing — governance risk KPI."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`technology_tech_project`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Technology project portfolio KPIs: budget, spend, capex/opex split, variance and health. Used in PMO/CIO portfolio reviews."
  source: "`vibe_media_broadcasting_v1`.`technology`.`tech_project`"
  dimensions:
    - name: "project_status"
      expr: project_status
      comment: "Project status for portfolio health steering."
    - name: "project_type"
      expr: project_type
      comment: "Type of tech project for investment-mix analysis."
    - name: "project_phase"
      expr: project_phase
      comment: "Current phase for delivery-pipeline tracking."
    - name: "health_indicator"
      expr: health_indicator
      comment: "RAG health indicator for at-risk project triage."
    - name: "priority_level"
      expr: priority_level
      comment: "Project priority for resource prioritisation."
    - name: "planned_start_month"
      expr: DATE_TRUNC('MONTH', planned_start_date)
      comment: "Month bucket of planned start for pipeline timing."
  measures:
    - name: "Project Count"
      expr: COUNT(1)
      comment: "Number of technology projects — portfolio size."
    - name: "Total Budget"
      expr: SUM(CAST(total_budget_usd AS DOUBLE))
      comment: "Total budgeted investment across the portfolio."
    - name: "Total Spend To Date"
      expr: SUM(CAST(spend_to_date_usd AS DOUBLE))
      comment: "Total spend incurred — burn tracking."
    - name: "Total Capex"
      expr: SUM(CAST(capital_expenditure_usd AS DOUBLE))
      comment: "Total capital expenditure — capitalisation steering."
    - name: "Total Opex"
      expr: SUM(CAST(operational_expenditure_usd AS DOUBLE))
      comment: "Total operating expenditure — opex steering."
    - name: "Total Budget Variance"
      expr: SUM(CAST(budget_variance_usd AS DOUBLE))
      comment: "Aggregate budget variance — overrun/underrun signal."
    - name: "At Risk Project Count"
      expr: SUM(CASE WHEN risk_status IN ('High','Critical','Red') THEN 1 ELSE 0 END)
      comment: "Projects flagged at elevated risk — portfolio intervention trigger."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`technology_equipment_procurement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Equipment procurement spend and fulfilment KPIs: total cost, tax/shipping, and goods-receipt completion. Used by procurement and tech finance."
  source: "`vibe_media_broadcasting_v1`.`technology`.`equipment_procurement`"
  dimensions:
    - name: "procurement_status"
      expr: procurement_status
      comment: "Procurement order status for fulfilment tracking."
    - name: "procurement_type"
      expr: procurement_type
      comment: "Type of procurement for spend categorisation."
    - name: "equipment_category"
      expr: equipment_category
      comment: "Equipment category for spend-mix analysis."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval state for governance reporting."
    - name: "order_month"
      expr: DATE_TRUNC('MONTH', order_date)
      comment: "Month bucket of order date for spend trends."
  measures:
    - name: "Procurement Count"
      expr: COUNT(1)
      comment: "Number of procurement orders — volume."
    - name: "Total Procurement Amount"
      expr: SUM(CAST(total_amount AS DOUBLE))
      comment: "Total procurement spend — capital outlay steering."
    - name: "Total Shipping Cost"
      expr: SUM(CAST(shipping_cost AS DOUBLE))
      comment: "Total shipping cost component of procurement spend."
    - name: "Total Tax Amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax on procurement — fully-loaded cost view."
    - name: "Avg Unit Cost"
      expr: AVG(CAST(unit_cost AS DOUBLE))
      comment: "Average unit cost — price-trend monitoring."
    - name: "Goods Received Count"
      expr: SUM(CASE WHEN goods_receipt_confirmed = TRUE THEN 1 ELSE 0 END)
      comment: "Orders with confirmed goods receipt — fulfilment completion."
    - name: "Goods Receipt Rate Pct"
      expr: ROUND(100.0 * SUM(CASE WHEN goods_receipt_confirmed = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of orders received — supply-chain reliability KPI."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`technology_noc_alert`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "NOC alerting KPIs: alert volume, severity mix, auto-resolution rate and SLA breaches. Used for monitoring-efficiency and alert-fatigue steering."
  source: "`vibe_media_broadcasting_v1`.`technology`.`noc_alert`"
  dimensions:
    - name: "alert_status"
      expr: alert_status
      comment: "Alert status for open-alert backlog tracking."
    - name: "alert_severity"
      expr: alert_severity
      comment: "Alert severity for prioritisation."
    - name: "alert_type"
      expr: alert_type
      comment: "Type of alert for source-pattern analysis."
    - name: "root_cause_category"
      expr: root_cause_category
      comment: "Root-cause grouping for systemic alert reduction."
    - name: "alert_month"
      expr: DATE_TRUNC('MONTH', alert_timestamp)
      comment: "Month bucket of alert time for trend monitoring."
  measures:
    - name: "Alert Count"
      expr: COUNT(1)
      comment: "Number of NOC alerts — monitoring load volume."
    - name: "Auto Resolved Count"
      expr: SUM(CASE WHEN auto_resolution_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Alerts auto-resolved — automation effectiveness."
    - name: "Auto Resolution Rate Pct"
      expr: ROUND(100.0 * SUM(CASE WHEN auto_resolution_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of alerts auto-resolved — automation efficiency KPI."
    - name: "SLA Breach Count"
      expr: SUM(CASE WHEN sla_breach_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Alerts breaching response SLA — escalation risk."
    - name: "SLA Breach Rate Pct"
      expr: ROUND(100.0 * SUM(CASE WHEN sla_breach_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of alerts breaching SLA — NOC responsiveness KPI."
    - name: "Notification Sent Count"
      expr: SUM(CASE WHEN notification_sent_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Alerts that triggered notifications — escalation activity."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`technology_software_license`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Software license portfolio KPIs: license/maintenance cost, compliance status and auto-renewal exposure. Used for SAM (software asset management) governance."
  source: "`vibe_media_broadcasting_v1`.`technology`.`software_license`"
  dimensions:
    - name: "license_status"
      expr: license_status
      comment: "License status for active-portfolio steering."
    - name: "license_type"
      expr: license_type
      comment: "Type of license for cost-model analysis."
    - name: "compliance_status"
      expr: compliance_status
      comment: "Compliance status for audit-risk reporting."
    - name: "primary_usage_category"
      expr: primary_usage_category
      comment: "Primary usage category for spend categorisation."
    - name: "expiry_month"
      expr: DATE_TRUNC('MONTH', expiry_date)
      comment: "Month bucket of expiry for renewal planning."
  measures:
    - name: "License Count"
      expr: COUNT(1)
      comment: "Number of software licenses — portfolio size."
    - name: "Total License Cost"
      expr: SUM(CAST(license_cost_usd AS DOUBLE))
      comment: "Total license acquisition cost — spend steering."
    - name: "Total Annual Maintenance Cost"
      expr: SUM(CAST(annual_maintenance_cost_usd AS DOUBLE))
      comment: "Total annual maintenance cost — recurring-spend exposure."
    - name: "Avg License Cost"
      expr: AVG(CAST(license_cost_usd AS DOUBLE))
      comment: "Average license cost — unit-economics view."
    - name: "Auto Renewal Count"
      expr: SUM(CASE WHEN auto_renewal_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Licenses set to auto-renew — renewal-leakage risk."
    - name: "Non Compliant Count"
      expr: SUM(CASE WHEN compliance_status IN ('Non-Compliant','NonCompliant','At Risk') THEN 1 ELSE 0 END)
      comment: "Licenses flagged non-compliant — true-up/audit exposure."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`technology_transmission_equipment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Transmission equipment fleet KPIs: acquisition value, operational status mix and maintenance-due posture. Used for capital-asset and broadcast-readiness steering."
  source: "`vibe_media_broadcasting_v1`.`technology`.`transmission_equipment`"
  dimensions:
    - name: "equipment_type"
      expr: equipment_type
      comment: "Type of transmission equipment for fleet composition."
    - name: "operational_status"
      expr: operational_status
      comment: "Operational status for broadcast-readiness reporting."
    - name: "manufacturer"
      expr: manufacturer
      comment: "Manufacturer for vendor-concentration analysis."
    - name: "frequency_band"
      expr: frequency_band
      comment: "Frequency band for spectrum/asset analysis."
    - name: "redundancy_role"
      expr: redundancy_role
      comment: "Primary/backup role for resilience analysis."
  measures:
    - name: "Equipment Count"
      expr: COUNT(1)
      comment: "Number of transmission equipment units — fleet size."
    - name: "Total Acquisition Cost"
      expr: SUM(CAST(acquisition_cost AS DOUBLE))
      comment: "Total fleet acquisition value — capital-asset base."
    - name: "Avg Acquisition Cost"
      expr: AVG(CAST(acquisition_cost AS DOUBLE))
      comment: "Average unit acquisition cost — fleet value benchmark."
    - name: "Total Power Output KW"
      expr: SUM(CAST(power_output_kw AS DOUBLE))
      comment: "Aggregate transmission power capacity — broadcast capability."
    - name: "Operational Equipment Count"
      expr: SUM(CASE WHEN operational_status IN ('Operational','Active','In Service') THEN 1 ELSE 0 END)
      comment: "Units currently operational — readiness indicator."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`technology_broadcast_facility`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Key capacity and location metrics for broadcast facilities."
  source: "`vibe_media_broadcasting_v1`.`technology`.`broadcast_facility`"
  dimensions:
    - name: "facility_type"
      expr: facility_type
      comment: "Type of broadcast facility (e.g., TV, radio, satellite)."
    - name: "operational_status"
      expr: operational_status
      comment: "Current operational status of the facility."
    - name: "country_code"
      expr: country_code
      comment: "Country where the facility is located."
    - name: "city"
      expr: city
      comment: "City where the facility is located."
    - name: "month_created"
      expr: DATE_TRUNC('month', created_timestamp)
      comment: "Month the facility record was created."
  measures:
    - name: "total_facilities"
      expr: COUNT(1)
      comment: "Total number of broadcast facilities."
    - name: "avg_power_capacity_kva"
      expr: AVG(CAST(power_capacity_kva AS DOUBLE))
      comment: "Average power capacity (kVA) across facilities."
    - name: "total_floor_area_sqm"
      expr: SUM(CAST(total_floor_area_sqm AS DOUBLE))
      comment: "Total floor area (sqm) of all facilities."
    - name: "avg_antenna_height_meters"
      expr: AVG(CAST(antenna_height_meters AS DOUBLE))
      comment: "Average antenna height in meters."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`technology_capacity_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Capacity planning efficiency and financial exposure."
  source: "`vibe_media_broadcasting_v1`.`technology`.`capacity_plan`"
  dimensions:
    - name: "plan_name"
      expr: plan_name
      comment: "Name of the capacity plan."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the capacity plan."
    - name: "planning_start_month"
      expr: DATE_TRUNC('month', planning_start_date)
      comment: "Month when planning started."
    - name: "planning_end_month"
      expr: DATE_TRUNC('month', planning_end_date)
      comment: "Month when planning ended."
  measures:
    - name: "avg_current_utilization_pct"
      expr: AVG(CAST(current_utilization_percentage AS DOUBLE))
      comment: "Average current utilization percentage across capacity plans."
    - name: "max_current_utilization_pct"
      expr: MAX(current_utilization_percentage)
      comment: "Maximum current utilization percentage observed."
    - name: "total_estimated_capex_usd"
      expr: SUM(CAST(estimated_capex_amount AS DOUBLE))
      comment: "Total estimated capital expenditure (USD) for capacity plans."
    - name: "plans_exceeding_threshold"
      expr: SUM(CASE WHEN capacity_threshold_percentage > 80 THEN 1 ELSE 0 END)
      comment: "Count of capacity plans where the threshold percentage exceeds 80%."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`technology_network_circuit`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Network circuit performance and cost metrics."
  source: "`vibe_media_broadcasting_v1`.`technology`.`network_circuit`"
  dimensions:
    - name: "circuit_type"
      expr: circuit_type
      comment: "Type of network circuit (e.g., fiber, microwave)."
    - name: "operational_status"
      expr: operational_status
      comment: "Current operational status of the circuit."
    - name: "sla_tier"
      expr: sla_tier
      comment: "SLA tier associated with the circuit."
    - name: "month_created"
      expr: DATE_TRUNC('month', created_timestamp)
      comment: "Month the circuit record was created."
  measures:
    - name: "avg_bandwidth_mbps"
      expr: AVG(CAST(bandwidth_mbps AS DOUBLE))
      comment: "Average bandwidth (Mbps) of network circuits."
    - name: "total_monthly_cost_usd"
      expr: SUM(CAST(monthly_recurring_cost AS DOUBLE))
      comment: "Total monthly recurring cost (USD) across circuits."
    - name: "max_utilization_percent"
      expr: MAX(average_utilization_percent)
      comment: "Maximum average utilization percent observed among circuits."
    - name: "circuits_exceeding_90_util"
      expr: SUM(CASE WHEN average_utilization_percent > 90 THEN 1 ELSE 0 END)
      comment: "Number of circuits with average utilization > 90%."
$$;