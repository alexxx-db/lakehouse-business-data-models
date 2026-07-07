-- Metric views for domain: asset | Business: Water_Utilities | Version: 2 | Generated on: 2026-07-02 04:56:40

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`asset_registry`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPI layer over the asset registry. Tracks portfolio value, condition, criticality, and lifecycle health across all registered infrastructure assets. Used by asset management executives and capital planning teams to steer renewal investment, prioritise maintenance, and manage regulatory risk."
  source: "`vibe_water_utilities_v1`.`asset`.`registry`"
  dimensions:
    - name: "asset_category"
      expr: asset_category
      comment: "High-level asset category (e.g. pipe, pump, meter) used to segment portfolio analysis."
    - name: "asset_type"
      expr: asset_type
      comment: "Specific asset type within a category, enabling granular drill-down in portfolio reporting."
    - name: "operational_status"
      expr: operational_status
      comment: "Current operational status of the asset (e.g. In Service, Decommissioned, Standby) — key filter for active-fleet analysis."
    - name: "criticality_rating"
      expr: criticality_rating
      comment: "Asset criticality tier (e.g. High, Medium, Low) used to prioritise capital and maintenance spend."
    - name: "condition_grade"
      expr: condition_grade
      comment: "Latest condition grade assigned to the asset, driving renewal and rehabilitation decisions."
    - name: "pressure_zone"
      expr: pressure_zone
      comment: "Hydraulic pressure zone where the asset resides — supports zone-level infrastructure planning."
    - name: "maintenance_strategy"
      expr: maintenance_strategy
      comment: "Maintenance approach applied to the asset (e.g. Preventive, Corrective, Predictive)."
    - name: "pipe_material"
      expr: pipe_material
      comment: "Pipe material classification (e.g. Cast Iron, PVC, Ductile Iron) — critical for lead service line compliance and renewal planning."
    - name: "is_lead_service_line"
      expr: is_lead_service_line
      comment: "Boolean flag indicating whether the asset is a lead service line, required for LCRR regulatory reporting."
    - name: "installation_year"
      expr: YEAR(installation_date)
      comment: "Year the asset was installed, used for age-cohort analysis and renewal forecasting."
    - name: "condition_assessment_year"
      expr: YEAR(condition_assessment_date)
      comment: "Year of the most recent condition assessment, used to identify assets with stale assessments."
  measures:
    - name: "total_assets"
      expr: COUNT(1)
      comment: "Total number of registered assets. Baseline measure for portfolio sizing and density analysis."
    - name: "total_acquisition_cost_usd"
      expr: SUM(CAST(acquisition_cost AS DOUBLE))
      comment: "Total acquisition cost of all assets in USD. Represents the historical capital investment in the asset portfolio — used in capital planning and depreciation modelling."
    - name: "total_replacement_cost_usd"
      expr: SUM(CAST(replacement_cost AS DOUBLE))
      comment: "Total current replacement cost of all assets in USD. Core input to capital improvement programme (CIP) budgeting and insurance valuation."
    - name: "avg_replacement_cost_usd"
      expr: AVG(CAST(replacement_cost AS DOUBLE))
      comment: "Average replacement cost per asset. Helps benchmark unit renewal costs across asset classes and pressure zones."
    - name: "total_rated_capacity"
      expr: SUM(CAST(rated_capacity AS DOUBLE))
      comment: "Sum of rated capacity across assets (in the asset's native capacity unit). Tracks total system capacity for demand planning."
    - name: "avg_diameter_mm"
      expr: AVG(CAST(diameter_mm AS DOUBLE))
      comment: "Average pipe diameter in millimetres across the asset portfolio. Used in hydraulic modelling and renewal prioritisation."
    - name: "lead_service_line_count"
      expr: COUNT(CASE WHEN is_lead_service_line = TRUE THEN 1 END)
      comment: "Count of assets identified as lead service lines. Critical KPI for LCRR compliance tracking and lead service line replacement programme management."
    - name: "assets_past_warranty"
      expr: COUNT(CASE WHEN warranty_expiry_date < CURRENT_DATE() THEN 1 END)
      comment: "Number of assets whose warranty has expired. Drives decisions on extended maintenance coverage and risk exposure."
    - name: "assets_decommissioned"
      expr: COUNT(CASE WHEN decommission_date IS NOT NULL THEN 1 END)
      comment: "Count of assets that have been formally decommissioned. Tracks portfolio retirement rate and supports asset lifecycle reporting."
    - name: "avg_power_rating_kw"
      expr: AVG(CAST(power_rating_kw AS DOUBLE))
      comment: "Average power rating in kilowatts across powered assets. Supports energy consumption benchmarking and efficiency programmes."
    - name: "total_power_rating_kw"
      expr: SUM(CAST(power_rating_kw AS DOUBLE))
      comment: "Total installed power capacity in kilowatts across the asset fleet. Used in energy management and sustainability reporting."
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`asset_work_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Operational and financial KPI layer over work orders. Tracks maintenance cost, labour efficiency, schedule adherence, and regulatory compliance for all work executed against water utility assets. Used by operations managers, finance, and compliance teams."
  source: "`vibe_water_utilities_v1`.`asset`.`work_order`"
  dimensions:
    - name: "work_order_type"
      expr: work_order_type
      comment: "Type of work order (e.g. Preventive, Corrective, Emergency) — primary dimension for maintenance strategy analysis."
    - name: "work_order_status"
      expr: work_order_status
      comment: "Current status of the work order (e.g. Open, In Progress, Closed) — used to track backlog and completion rates."
    - name: "priority"
      expr: priority
      comment: "Work order priority level (e.g. Critical, High, Medium, Low) — drives resource allocation and SLA compliance analysis."
    - name: "regulatory_compliance_flag"
      expr: regulatory_compliance_flag
      comment: "Indicates whether the work order is linked to a regulatory compliance requirement — essential for audit and enforcement reporting."
    - name: "permit_required"
      expr: permit_required
      comment: "Flag indicating whether a permit is required for the work — used to track permitting compliance and delays."
    - name: "warranty_claim"
      expr: warranty_claim
      comment: "Flag indicating whether the work order is associated with a warranty claim — used to track warranty recovery value."
    - name: "reported_year"
      expr: YEAR(reported_date)
      comment: "Year the work order was reported, used for year-over-year trend analysis of maintenance activity."
    - name: "reported_month"
      expr: DATE_TRUNC('MONTH', reported_date)
      comment: "Month the work order was reported, used for monthly operational cadence reporting."
    - name: "scheduled_start_year"
      expr: YEAR(scheduled_start_date)
      comment: "Year the work order was scheduled to start — used in schedule adherence and backlog ageing analysis."
    - name: "source"
      expr: source
      comment: "Origin system or channel that generated the work order (e.g. SCADA, Customer, Inspection) — used to analyse demand drivers."
  measures:
    - name: "total_work_orders"
      expr: COUNT(1)
      comment: "Total number of work orders. Baseline measure for maintenance volume and workload analysis."
    - name: "total_actual_cost_usd"
      expr: SUM(CAST(actual_cost AS DOUBLE))
      comment: "Total actual cost incurred across all work orders in USD. Primary financial KPI for maintenance expenditure tracking and budget variance analysis."
    - name: "total_estimated_cost_usd"
      expr: SUM(CAST(estimated_cost AS DOUBLE))
      comment: "Total estimated cost across all work orders in USD. Used alongside actual cost to compute cost variance and improve estimating accuracy."
    - name: "avg_actual_cost_usd"
      expr: AVG(CAST(actual_cost AS DOUBLE))
      comment: "Average actual cost per work order in USD. Benchmarks unit maintenance cost across work types, priorities, and asset classes."
    - name: "total_actual_labor_hours"
      expr: SUM(CAST(actual_labor_hours AS DOUBLE))
      comment: "Total actual labour hours consumed across all work orders. Core input to workforce capacity planning and productivity analysis."
    - name: "total_estimated_labor_hours"
      expr: SUM(CAST(estimated_labor_hours AS DOUBLE))
      comment: "Total estimated labour hours across all work orders. Used to assess planning accuracy and resource scheduling efficiency."
    - name: "avg_actual_labor_hours"
      expr: AVG(CAST(actual_labor_hours AS DOUBLE))
      comment: "Average actual labour hours per work order. Identifies labour-intensive work types and supports crew sizing decisions."
    - name: "total_downtime_hours"
      expr: SUM(CAST(downtime_duration_hours AS DOUBLE))
      comment: "Total asset downtime hours attributable to work orders. Directly linked to service reliability and customer impact — a key operational resilience KPI."
    - name: "avg_downtime_hours"
      expr: AVG(CAST(downtime_duration_hours AS DOUBLE))
      comment: "Average downtime hours per work order. Used to benchmark repair speed and identify systemic delays by work type or asset class."
    - name: "regulatory_compliance_work_orders"
      expr: COUNT(CASE WHEN regulatory_compliance_flag = TRUE THEN 1 END)
      comment: "Count of work orders flagged as regulatory compliance requirements. Tracks the volume of compliance-driven maintenance activity for audit and reporting."
    - name: "warranty_claim_work_orders"
      expr: COUNT(CASE WHEN warranty_claim = TRUE THEN 1 END)
      comment: "Count of work orders associated with warranty claims. Quantifies warranty recovery opportunities and vendor accountability."
    - name: "open_work_orders"
      expr: COUNT(CASE WHEN work_order_status NOT IN ('Closed', 'Cancelled') THEN 1 END)
      comment: "Count of work orders that are currently open or in progress. Tracks maintenance backlog — a leading indicator of operational risk."
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`asset_condition_assessment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Asset health and risk KPI layer over condition assessments. Tracks condition grades, risk scores, remaining useful life, and repair cost estimates across the asset portfolio. Used by asset managers, engineers, and capital planners to prioritise rehabilitation and renewal investment."
  source: "`vibe_water_utilities_v1`.`asset`.`condition_assessment`"
  dimensions:
    - name: "assessment_type"
      expr: assessment_type
      comment: "Type of condition assessment performed (e.g. Visual, CCTV, Acoustic) — used to segment assessment quality and coverage."
    - name: "assessment_status"
      expr: assessment_status
      comment: "Current status of the assessment record (e.g. Pending Review, Approved, Rejected) — used to track assessment workflow completion."
    - name: "condition_grade"
      expr: condition_grade
      comment: "Condition grade assigned during the assessment (e.g. 1-5 scale) — primary dimension for asset health segmentation."
    - name: "criticality_rating"
      expr: criticality_rating
      comment: "Criticality rating of the assessed asset — used to weight condition findings by consequence of failure."
    - name: "recommended_action"
      expr: recommended_action
      comment: "Recommended remediation action (e.g. Repair, Replace, Monitor) — drives capital programme prioritisation."
    - name: "recommended_action_priority"
      expr: recommended_action_priority
      comment: "Priority assigned to the recommended action — used to triage the rehabilitation backlog."
    - name: "regulatory_compliance_flag"
      expr: regulatory_compliance_flag
      comment: "Indicates whether the assessment was conducted to satisfy a regulatory requirement."
    - name: "assessment_year"
      expr: YEAR(assessment_date)
      comment: "Year the condition assessment was conducted — used for annual assessment programme tracking and trend analysis."
    - name: "assessment_month"
      expr: DATE_TRUNC('MONTH', assessment_date)
      comment: "Month the assessment was conducted — used for monthly programme cadence reporting."
    - name: "assessment_method"
      expr: assessment_method
      comment: "Inspection method used (e.g. CCTV, Acoustic, Physical) — used to analyse coverage and method effectiveness."
  measures:
    - name: "total_assessments"
      expr: COUNT(1)
      comment: "Total number of condition assessments conducted. Baseline measure for assessment programme coverage and throughput."
    - name: "avg_condition_performance_score"
      expr: AVG(CAST(performance_score AS DOUBLE))
      comment: "Average performance score across assessed assets. Tracks overall asset health trend — a leading indicator for capital renewal needs."
    - name: "avg_risk_score"
      expr: AVG(CAST(risk_score AS DOUBLE))
      comment: "Average risk score across assessed assets. Combines probability and consequence of failure — used to prioritise risk-based maintenance investment."
    - name: "avg_structural_integrity_score"
      expr: AVG(CAST(structural_integrity_score AS DOUBLE))
      comment: "Average structural integrity score. Tracks the physical condition of infrastructure assets and informs rehabilitation urgency."
    - name: "avg_remaining_useful_life_years"
      expr: AVG(CAST(remaining_useful_life_years AS DOUBLE))
      comment: "Average remaining useful life in years across assessed assets. Core input to long-range capital planning and asset renewal forecasting."
    - name: "total_estimated_repair_cost_usd"
      expr: SUM(CAST(estimated_repair_cost AS DOUBLE))
      comment: "Total estimated repair cost across all assessed assets in USD. Quantifies the deferred maintenance liability and informs O&M budget requirements."
    - name: "total_estimated_replacement_cost_usd"
      expr: SUM(CAST(estimated_replacement_cost AS DOUBLE))
      comment: "Total estimated replacement cost across all assessed assets in USD. Represents the capital renewal liability — a critical input to CIP and rate-setting."
    - name: "avg_failure_probability"
      expr: AVG(CAST(failure_probability AS DOUBLE))
      comment: "Average probability of failure across assessed assets. Used in risk-based asset management frameworks to prioritise intervention."
    - name: "assets_with_critical_defects"
      expr: COUNT(CASE WHEN CAST(critical_defect_count AS INT) > 0 THEN 1 END)
      comment: "Count of assessments identifying at least one critical defect. Tracks the volume of assets requiring urgent remediation — a key safety and reliability KPI."
    - name: "regulatory_compliance_assessments"
      expr: COUNT(CASE WHEN regulatory_compliance_flag = TRUE THEN 1 END)
      comment: "Count of assessments conducted to satisfy regulatory requirements. Tracks compliance programme coverage for audit and reporting."
    - name: "assessments_overdue"
      expr: COUNT(CASE WHEN next_assessment_due_date < CURRENT_DATE() THEN 1 END)
      comment: "Count of assets whose next assessment due date has passed without a new assessment. Tracks assessment programme compliance and regulatory exposure."
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`asset_failure_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Asset reliability and failure KPI layer over failure records. Tracks failure frequency, downtime, repair costs, environmental impact, and regulatory notifications. Used by operations, engineering, and compliance teams to improve asset reliability and manage regulatory risk."
  source: "`vibe_water_utilities_v1`.`asset`.`failure_record`"
  dimensions:
    - name: "failure_mode"
      expr: failure_mode
      comment: "Classification of how the asset failed (e.g. Corrosion, Mechanical, Structural) — primary dimension for root cause and reliability analysis."
    - name: "failure_cause"
      expr: failure_cause
      comment: "Root cause of the failure — used to identify systemic issues and drive preventive maintenance improvements."
    - name: "failure_severity"
      expr: failure_severity
      comment: "Severity classification of the failure (e.g. Critical, Major, Minor) — used to prioritise response and track high-impact events."
    - name: "failure_status"
      expr: failure_status
      comment: "Current status of the failure record (e.g. Open, Resolved, Under Investigation) — tracks resolution progress."
    - name: "affected_system"
      expr: affected_system
      comment: "Water system component affected by the failure (e.g. Distribution, Treatment, Collection) — used for system-level reliability reporting."
    - name: "service_interruption_flag"
      expr: service_interruption_flag
      comment: "Indicates whether the failure caused a customer service interruption — key dimension for customer impact analysis."
    - name: "cso_event_flag"
      expr: cso_event_flag
      comment: "Indicates whether the failure resulted in a Combined Sewer Overflow event — critical for environmental compliance reporting."
    - name: "sso_event_flag"
      expr: sso_event_flag
      comment: "Indicates whether the failure resulted in a Sanitary Sewer Overflow event — critical for regulatory notification and compliance tracking."
    - name: "regulatory_notification_required_flag"
      expr: regulatory_notification_required_flag
      comment: "Indicates whether the failure requires regulatory notification — used to track compliance obligations and notification timeliness."
    - name: "failure_year"
      expr: YEAR(failure_date)
      comment: "Year the failure occurred — used for year-over-year reliability trend analysis."
    - name: "failure_month"
      expr: DATE_TRUNC('MONTH', failure_date)
      comment: "Month the failure occurred — used for seasonal failure pattern analysis."
    - name: "detection_method"
      expr: detection_method
      comment: "How the failure was detected (e.g. SCADA Alert, Customer Report, Inspection) — used to evaluate detection programme effectiveness."
  measures:
    - name: "total_failures"
      expr: COUNT(1)
      comment: "Total number of failure events recorded. Baseline reliability KPI — tracks failure frequency across the asset portfolio."
    - name: "total_actual_repair_cost_usd"
      expr: SUM(CAST(actual_repair_cost AS DOUBLE))
      comment: "Total actual repair cost across all failure events in USD. Quantifies the financial impact of asset failures on the O&M budget."
    - name: "avg_actual_repair_cost_usd"
      expr: AVG(CAST(actual_repair_cost AS DOUBLE))
      comment: "Average repair cost per failure event in USD. Benchmarks unit failure cost across asset types and failure modes."
    - name: "total_downtime_hours"
      expr: SUM(CAST(downtime_duration_hours AS DOUBLE))
      comment: "Total downtime hours caused by failures. Directly measures service reliability impact — a core KPI for operational resilience."
    - name: "avg_mttr_hours"
      expr: AVG(CAST(mttr_hours AS DOUBLE))
      comment: "Average Mean Time to Repair in hours. Industry-standard reliability metric — measures maintenance responsiveness and repair efficiency."
    - name: "total_overflow_volume_gallons"
      expr: SUM(CAST(overflow_volume_gallons AS DOUBLE))
      comment: "Total volume of overflow in gallons across all failure events. Critical environmental compliance KPI for CSO/SSO regulatory reporting."
    - name: "total_production_loss_mgd"
      expr: SUM(CAST(production_loss_mgd AS DOUBLE))
      comment: "Total production loss in million gallons per day attributable to failures. Quantifies the supply impact of asset failures — used in reliability and capacity planning."
    - name: "service_interruption_events"
      expr: COUNT(CASE WHEN service_interruption_flag = TRUE THEN 1 END)
      comment: "Count of failures that caused customer service interruptions. Tracks customer impact frequency — a key service quality and regulatory KPI."
    - name: "cso_sso_events"
      expr: COUNT(CASE WHEN cso_event_flag = TRUE OR sso_event_flag = TRUE THEN 1 END)
      comment: "Count of failures resulting in CSO or SSO events. Tracks environmental compliance violations — a critical regulatory reporting KPI."
    - name: "regulatory_notifications_required"
      expr: COUNT(CASE WHEN regulatory_notification_required_flag = TRUE THEN 1 END)
      comment: "Count of failures requiring regulatory notification. Tracks compliance obligation volume and supports timely notification management."
    - name: "root_cause_analysis_completed"
      expr: COUNT(CASE WHEN root_cause_analysis_completed_flag = TRUE THEN 1 END)
      comment: "Count of failures where root cause analysis has been completed. Tracks the quality of the failure investigation programme and drives continuous improvement."
    - name: "avg_pressure_drop_psi"
      expr: AVG(CAST(pressure_drop_psi AS DOUBLE))
      comment: "Average pressure drop in PSI recorded during failure events. Hydraulic impact indicator used in distribution system reliability analysis."
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`asset_inspection_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Inspection programme KPI layer over inspection events. Tracks inspection coverage, compliance, deficiency rates, and corrective action follow-through. Used by operations, compliance, and regulatory teams to manage inspection programme performance and regulatory obligations."
  source: "`vibe_water_utilities_v1`.`asset`.`inspection_event`"
  dimensions:
    - name: "inspection_type"
      expr: inspection_type
      comment: "Type of inspection performed (e.g. Routine, Regulatory, Emergency) — primary dimension for inspection programme analysis."
    - name: "inspection_status"
      expr: inspection_status
      comment: "Current status of the inspection event (e.g. Scheduled, Completed, Overdue) — used to track programme completion rates."
    - name: "pass_fail_outcome"
      expr: pass_fail_outcome
      comment: "Pass/Fail outcome of the inspection — primary quality KPI dimension for compliance and asset condition reporting."
    - name: "regulatory_inspection_flag"
      expr: regulatory_inspection_flag
      comment: "Indicates whether the inspection was conducted to satisfy a regulatory requirement — used to segment compliance-driven activity."
    - name: "corrective_action_required_flag"
      expr: corrective_action_required_flag
      comment: "Indicates whether the inspection identified deficiencies requiring corrective action — tracks remediation demand."
    - name: "critical_deficiency_flag"
      expr: critical_deficiency_flag
      comment: "Indicates whether a critical deficiency was identified — used to prioritise urgent remediation and escalation."
    - name: "environmental_impact_flag"
      expr: environmental_impact_flag
      comment: "Indicates whether the inspection identified an environmental impact — used for environmental compliance tracking."
    - name: "safety_incident_flag"
      expr: safety_incident_flag
      comment: "Indicates whether a safety incident occurred during the inspection — used for safety programme monitoring."
    - name: "inspection_year"
      expr: YEAR(inspection_date)
      comment: "Year the inspection was conducted — used for annual programme coverage and trend analysis."
    - name: "inspection_month"
      expr: DATE_TRUNC('MONTH', inspection_date)
      comment: "Month the inspection was conducted — used for monthly programme cadence and seasonal pattern analysis."
    - name: "report_submitted_flag"
      expr: report_submitted_flag
      comment: "Indicates whether the inspection report has been formally submitted — tracks reporting compliance."
  measures:
    - name: "total_inspections"
      expr: COUNT(1)
      comment: "Total number of inspection events conducted. Baseline measure for inspection programme coverage and throughput."
    - name: "failed_inspections"
      expr: COUNT(CASE WHEN pass_fail_outcome = 'Fail' THEN 1 END)
      comment: "Count of inspections with a Fail outcome. Tracks asset non-compliance rate — a key quality and regulatory KPI."
    - name: "critical_deficiency_inspections"
      expr: COUNT(CASE WHEN critical_deficiency_flag = TRUE THEN 1 END)
      comment: "Count of inspections identifying critical deficiencies. Tracks the volume of high-urgency remediation requirements across the asset portfolio."
    - name: "corrective_action_required_count"
      expr: COUNT(CASE WHEN corrective_action_required_flag = TRUE THEN 1 END)
      comment: "Count of inspections requiring corrective action. Quantifies the remediation backlog generated by the inspection programme."
    - name: "regulatory_inspections"
      expr: COUNT(CASE WHEN regulatory_inspection_flag = TRUE THEN 1 END)
      comment: "Count of inspections conducted to satisfy regulatory requirements. Tracks compliance programme coverage for audit and regulatory reporting."
    - name: "reports_not_submitted"
      expr: COUNT(CASE WHEN report_submitted_flag = FALSE AND inspection_status = 'Completed' THEN 1 END)
      comment: "Count of completed inspections where the report has not yet been submitted. Tracks reporting compliance gaps that could result in regulatory penalties."
    - name: "inspections_overdue"
      expr: COUNT(CASE WHEN next_inspection_due_date < CURRENT_DATE() THEN 1 END)
      comment: "Count of assets whose next inspection due date has passed. Tracks inspection programme compliance and regulatory exposure."
    - name: "safety_incidents_during_inspection"
      expr: COUNT(CASE WHEN safety_incident_flag = TRUE THEN 1 END)
      comment: "Count of inspections during which a safety incident occurred. Tracks field safety performance — a critical workforce safety KPI."
    - name: "environmental_impact_inspections"
      expr: COUNT(CASE WHEN environmental_impact_flag = TRUE THEN 1 END)
      comment: "Count of inspections identifying an environmental impact. Tracks environmental compliance risk exposure across the asset portfolio."
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`asset_pm_schedule`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Preventive maintenance programme KPI layer over PM schedules. Tracks planned maintenance cost, labour, schedule compliance, and regulatory alignment. Used by maintenance managers and asset planners to optimise PM programme efficiency and ensure regulatory compliance."
  source: "`vibe_water_utilities_v1`.`asset`.`pm_schedule`"
  dimensions:
    - name: "schedule_status"
      expr: schedule_status
      comment: "Current status of the PM schedule (e.g. Active, Inactive, Suspended) — used to track active programme coverage."
    - name: "work_order_type"
      expr: work_order_type
      comment: "Type of work order generated by the PM schedule (e.g. Preventive, Inspection) — used to segment planned maintenance activity."
    - name: "trigger_type"
      expr: trigger_type
      comment: "Trigger mechanism for the PM schedule (e.g. Calendar, Meter, Condition) — used to analyse maintenance strategy mix."
    - name: "frequency_unit"
      expr: frequency_unit
      comment: "Unit of the PM frequency interval (e.g. Days, Weeks, Months) — used to segment schedules by maintenance cadence."
    - name: "asset_criticality_rating"
      expr: asset_criticality_rating
      comment: "Criticality rating of the asset covered by the PM schedule — used to ensure high-criticality assets have adequate PM coverage."
    - name: "regulatory_compliance_flag"
      expr: regulatory_compliance_flag
      comment: "Indicates whether the PM schedule is required for regulatory compliance — used to track compliance-driven maintenance coverage."
    - name: "seasonal_schedule_flag"
      expr: seasonal_schedule_flag
      comment: "Indicates whether the PM schedule is seasonal — used to plan resource requirements for seasonal maintenance peaks."
    - name: "auto_generate_work_order_flag"
      expr: auto_generate_work_order_flag
      comment: "Indicates whether work orders are automatically generated from this schedule — used to assess automation coverage of the PM programme."
    - name: "downtime_required_flag"
      expr: downtime_required_flag
      comment: "Indicates whether the PM task requires asset downtime — used to plan outage windows and minimise service disruption."
    - name: "effective_start_year"
      expr: YEAR(effective_start_date)
      comment: "Year the PM schedule became effective — used for programme vintage analysis."
  measures:
    - name: "total_pm_schedules"
      expr: COUNT(1)
      comment: "Total number of active and inactive PM schedules. Baseline measure for PM programme scope and coverage."
    - name: "total_estimated_labor_cost_usd"
      expr: SUM(CAST(estimated_labor_cost AS DOUBLE))
      comment: "Total estimated labour cost across all PM schedules in USD. Quantifies the planned labour investment in the preventive maintenance programme."
    - name: "total_estimated_material_cost_usd"
      expr: SUM(CAST(estimated_material_cost AS DOUBLE))
      comment: "Total estimated material cost across all PM schedules in USD. Quantifies the planned material spend for the PM programme — used in O&M budget planning."
    - name: "total_estimated_labor_hours"
      expr: SUM(CAST(estimated_labor_hours AS DOUBLE))
      comment: "Total estimated labour hours across all PM schedules. Used for workforce capacity planning and resource allocation."
    - name: "avg_estimated_downtime_hours"
      expr: AVG(CAST(estimated_downtime_hours AS DOUBLE))
      comment: "Average estimated downtime hours per PM task. Used to plan outage windows and minimise service disruption during preventive maintenance."
    - name: "total_estimated_downtime_hours"
      expr: SUM(CAST(estimated_downtime_hours AS DOUBLE))
      comment: "Total estimated downtime hours across all PM schedules. Quantifies the planned service impact of the PM programme — used in reliability and outage planning."
    - name: "regulatory_compliance_schedules"
      expr: COUNT(CASE WHEN regulatory_compliance_flag = TRUE THEN 1 END)
      comment: "Count of PM schedules required for regulatory compliance. Tracks the volume of compliance-driven maintenance obligations."
    - name: "schedules_overdue"
      expr: COUNT(CASE WHEN next_due_date < CURRENT_DATE() AND schedule_status = 'Active' THEN 1 END)
      comment: "Count of active PM schedules where the next due date has passed without completion. Tracks PM backlog and schedule compliance — a leading indicator of deferred maintenance risk."
    - name: "auto_generated_schedules"
      expr: COUNT(CASE WHEN auto_generate_work_order_flag = TRUE THEN 1 END)
      comment: "Count of PM schedules configured for automatic work order generation. Tracks automation coverage of the PM programme — higher automation reduces manual scheduling overhead."
$$;