-- Metric views for domain: asset | Business: Water_Utilities | Version: 2 | Generated on: 2026-07-10 20:21:36

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`asset_registry`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPIs over the asset registry — the master inventory of all physical water utility assets. Supports capital planning, replacement prioritisation, and condition-based investment decisions."
  source: "`vibe_water_utilities_v1`.`asset`.`registry`"
  dimensions:
    - name: "asset_category"
      expr: asset_category
      comment: "High-level asset category (e.g. Pipe, Pump, Meter) used to segment capital investment and replacement planning."
    - name: "asset_type"
      expr: asset_type
      comment: "Specific asset type within a category, enabling granular operational and financial analysis."
    - name: "operational_status"
      expr: operational_status
      comment: "Current operational status of the asset (Active, Inactive, Decommissioned) — critical for fleet availability reporting."
    - name: "criticality_rating"
      expr: criticality_rating
      comment: "Criticality tier assigned to the asset, used to prioritise maintenance spend and capital renewal."
    - name: "condition_grade"
      expr: condition_grade
      comment: "Latest condition grade from assessment, used to identify assets approaching end-of-life."
    - name: "pipe_material"
      expr: pipe_material
      comment: "Pipe material classification (e.g. Cast Iron, PVC, Ductile Iron) — key for lead service line compliance and renewal strategy."
    - name: "pressure_zone"
      expr: pressure_zone
      comment: "Hydraulic pressure zone the asset belongs to, enabling zone-level performance and risk analysis."
    - name: "maintenance_strategy"
      expr: maintenance_strategy
      comment: "Assigned maintenance strategy (Preventive, Corrective, Predictive) for operational efficiency benchmarking."
    - name: "is_lead_service_line"
      expr: is_lead_service_line
      comment: "Flag indicating whether the asset is a lead service line — directly tied to LCRR regulatory compliance obligations."
    - name: "installation_year"
      expr: YEAR(installation_date)
      comment: "Year the asset was installed, used for age-cohort analysis and replacement wave planning."
    - name: "condition_assessment_year"
      expr: YEAR(condition_assessment_date)
      comment: "Year of the most recent condition assessment, used to identify assets with stale assessments."
  measures:
    - name: "total_asset_count"
      expr: COUNT(1)
      comment: "Total number of registered assets. Baseline fleet size metric used in capital planning and regulatory asset inventory reporting."
    - name: "total_acquisition_cost"
      expr: SUM(CAST(acquisition_cost AS DOUBLE))
      comment: "Total original acquisition cost of all registered assets. Represents the gross asset base for rate-case and capital investment analysis."
    - name: "total_replacement_cost"
      expr: SUM(CAST(replacement_cost AS DOUBLE))
      comment: "Total current replacement cost of the asset fleet. Core input to capital improvement programme (CIP) budgeting and insurance valuation."
    - name: "avg_replacement_cost_per_asset"
      expr: AVG(CAST(replacement_cost AS DOUBLE))
      comment: "Average replacement cost per asset. Used to benchmark unit renewal costs across asset classes and pressure zones."
    - name: "total_rated_capacity"
      expr: SUM(CAST(rated_capacity AS DOUBLE))
      comment: "Sum of rated capacity across assets (in capacity_unit). Indicates total system throughput capacity for infrastructure planning."
    - name: "avg_diameter_mm"
      expr: AVG(CAST(diameter_mm AS DOUBLE))
      comment: "Average pipe diameter in millimetres. Used in hydraulic modelling and renewal prioritisation for undersized infrastructure."
    - name: "lead_service_line_count"
      expr: COUNT(CASE WHEN is_lead_service_line = TRUE THEN 1 END)
      comment: "Count of assets identified as lead service lines. Directly tracks LCRR compliance obligation and replacement programme progress."
    - name: "assets_past_useful_life_count"
      expr: COUNT(CASE WHEN YEAR(CURRENT_DATE()) - YEAR(installation_date) > CAST(expected_useful_life_years AS INT) AND installation_date IS NOT NULL AND expected_useful_life_years IS NOT NULL THEN 1 END)
      comment: "Number of assets that have exceeded their expected useful life. Key risk indicator for proactive renewal investment decisions."
    - name: "avg_asset_age_years"
      expr: AVG(CAST(YEAR(CURRENT_DATE()) - YEAR(installation_date) AS DOUBLE))
      comment: "Average age of assets in years since installation. Drives renewal wave forecasting and long-range capital planning."
    - name: "assets_due_for_maintenance_count"
      expr: COUNT(CASE WHEN next_maintenance_date <= CURRENT_DATE() AND next_maintenance_date IS NOT NULL THEN 1 END)
      comment: "Number of assets whose next scheduled maintenance date is overdue. Operational KPI for maintenance backlog management."
    - name: "total_power_rating_kw"
      expr: SUM(CAST(power_rating_kw AS DOUBLE))
      comment: "Total installed power rating in kilowatts across the asset fleet. Used for energy cost modelling and sustainability reporting."
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`asset_work_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Operational and financial KPIs over work orders — the primary record of maintenance, repair, and capital activity. Supports cost control, workforce efficiency, and regulatory compliance tracking."
  source: "`vibe_water_utilities_v1`.`asset`.`work_order`"
  dimensions:
    - name: "work_order_type"
      expr: work_order_type
      comment: "Type of work order (Preventive, Corrective, Emergency, Capital) — fundamental dimension for maintenance strategy analysis."
    - name: "work_order_status"
      expr: work_order_status
      comment: "Current status of the work order (Open, In Progress, Closed, Cancelled) — used for backlog and throughput reporting."
    - name: "priority"
      expr: priority
      comment: "Work order priority level (Critical, High, Medium, Low) — used to assess response time compliance and resource allocation."
    - name: "source"
      expr: source
      comment: "Origin of the work order (e.g. SCADA, Customer Complaint, Inspection, PM Schedule) — identifies demand drivers."
    - name: "regulatory_compliance_flag"
      expr: regulatory_compliance_flag
      comment: "Indicates whether the work order is tied to a regulatory compliance requirement — critical for audit and reporting."
    - name: "warranty_claim"
      expr: warranty_claim
      comment: "Flag indicating whether the work order involves a warranty claim — used to track warranty recovery and vendor performance."
    - name: "reported_year"
      expr: YEAR(reported_date)
      comment: "Year the work order was reported, used for year-over-year trend analysis of maintenance demand."
    - name: "reported_month"
      expr: DATE_TRUNC('MONTH', reported_date)
      comment: "Month the work order was reported, used for monthly operational performance dashboards."
    - name: "cause_code"
      expr: cause_code
      comment: "Root cause code assigned to the work order — used for failure pattern analysis and preventive maintenance optimisation."
    - name: "assigned_to"
      expr: assigned_to
      comment: "Technician or crew assigned to the work order — used for workforce productivity and workload balancing."
  measures:
    - name: "total_work_orders"
      expr: COUNT(1)
      comment: "Total number of work orders. Baseline volume metric for maintenance demand and operational throughput reporting."
    - name: "total_actual_cost"
      expr: SUM(CAST(actual_cost AS DOUBLE))
      comment: "Total actual cost incurred across all work orders. Primary O&M expenditure KPI for budget variance and cost control."
    - name: "total_estimated_cost"
      expr: SUM(CAST(estimated_cost AS DOUBLE))
      comment: "Total estimated cost across work orders. Used alongside actual cost to measure estimating accuracy and budget adherence."
    - name: "avg_actual_cost_per_work_order"
      expr: AVG(CAST(actual_cost AS DOUBLE))
      comment: "Average actual cost per work order. Benchmarks unit maintenance cost and identifies cost outliers by type or priority."
    - name: "total_actual_labor_hours"
      expr: SUM(CAST(actual_labor_hours AS DOUBLE))
      comment: "Total actual labour hours expended. Core workforce productivity and capacity planning metric."
    - name: "avg_labor_hours_per_work_order"
      expr: AVG(CAST(actual_labor_hours AS DOUBLE))
      comment: "Average labour hours per work order. Used to benchmark crew efficiency and identify work types with excessive labour consumption."
    - name: "total_downtime_hours"
      expr: SUM(CAST(downtime_duration_hours AS DOUBLE))
      comment: "Total asset downtime hours resulting from work orders. Directly measures service reliability impact of maintenance activities."
    - name: "avg_downtime_hours_per_work_order"
      expr: AVG(CAST(downtime_duration_hours AS DOUBLE))
      comment: "Average downtime per work order. Used to assess mean time to restore service and prioritise rapid-response improvements."
    - name: "cost_overrun_work_order_count"
      expr: COUNT(CASE WHEN actual_cost > estimated_cost AND estimated_cost > 0 THEN 1 END)
      comment: "Number of work orders where actual cost exceeded estimate. Identifies systemic estimating gaps and scope creep patterns."
    - name: "regulatory_compliance_work_order_count"
      expr: COUNT(CASE WHEN regulatory_compliance_flag = TRUE THEN 1 END)
      comment: "Count of work orders tied to regulatory compliance requirements. Tracks the volume of compliance-driven maintenance activity."
    - name: "warranty_claim_work_order_count"
      expr: COUNT(CASE WHEN warranty_claim = TRUE THEN 1 END)
      comment: "Number of work orders with active warranty claims. Measures warranty recovery opportunity and vendor accountability."
    - name: "distinct_assets_maintained"
      expr: COUNT(DISTINCT location_id)
      comment: "Count of distinct locations (proxy for assets) that received work orders. Measures maintenance coverage breadth across the network."
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`asset_condition_assessment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Asset health and risk KPIs derived from condition assessments. Supports infrastructure investment prioritisation, risk-based maintenance planning, and regulatory compliance reporting."
  source: "`vibe_water_utilities_v1`.`asset`.`condition_assessment`"
  dimensions:
    - name: "condition_grade"
      expr: condition_grade
      comment: "Condition grade assigned during assessment (e.g. 1-5 scale) — primary dimension for asset health segmentation."
    - name: "assessment_type"
      expr: assessment_type
      comment: "Type of condition assessment performed (e.g. Visual, CCTV, Acoustic) — used to evaluate assessment programme coverage."
    - name: "assessment_method"
      expr: assessment_method
      comment: "Specific method used for the assessment — supports quality assurance and methodology standardisation analysis."
    - name: "assessment_status"
      expr: assessment_status
      comment: "Current status of the assessment record (Draft, Approved, Closed) — used for workflow and data quality monitoring."
    - name: "recommended_action"
      expr: recommended_action
      comment: "Recommended remediation action from the assessment (e.g. Repair, Replace, Monitor) — drives capital programme prioritisation."
    - name: "recommended_action_priority"
      expr: recommended_action_priority
      comment: "Priority level of the recommended action — used to triage the capital renewal backlog."
    - name: "regulatory_compliance_flag"
      expr: regulatory_compliance_flag
      comment: "Indicates whether the assessment is linked to a regulatory compliance requirement."
    - name: "criticality_rating"
      expr: criticality_rating
      comment: "Criticality rating of the assessed asset — enables risk-weighted prioritisation of remediation spend."
    - name: "assessment_year"
      expr: YEAR(assessment_date)
      comment: "Year the assessment was conducted — used for programme cadence and trend analysis."
    - name: "assessment_month"
      expr: DATE_TRUNC('MONTH', assessment_date)
      comment: "Month the assessment was conducted — used for monthly programme throughput reporting."
  measures:
    - name: "total_assessments"
      expr: COUNT(1)
      comment: "Total number of condition assessments completed. Baseline metric for assessment programme throughput and coverage."
    - name: "total_estimated_repair_cost"
      expr: SUM(CAST(estimated_repair_cost AS DOUBLE))
      comment: "Total estimated repair cost across all assessed assets. Quantifies the near-term capital repair liability for budget planning."
    - name: "total_estimated_replacement_cost"
      expr: SUM(CAST(estimated_replacement_cost AS DOUBLE))
      comment: "Total estimated replacement cost across assessed assets. Represents the long-term capital renewal liability for CIP planning."
    - name: "avg_risk_score"
      expr: AVG(CAST(risk_score AS DOUBLE))
      comment: "Average risk score across assessments. Executive-level indicator of overall network risk profile — triggers investment prioritisation reviews."
    - name: "avg_remaining_useful_life_years"
      expr: AVG(CAST(remaining_useful_life_years AS DOUBLE))
      comment: "Average remaining useful life in years across assessed assets. Drives long-range renewal wave forecasting and rate-case justification."
    - name: "avg_failure_probability"
      expr: AVG(CAST(failure_probability AS DOUBLE))
      comment: "Average probability of failure across assessed assets. Key risk management KPI — elevated values trigger proactive renewal investment."
    - name: "avg_structural_integrity_score"
      expr: AVG(CAST(structural_integrity_score AS DOUBLE))
      comment: "Average structural integrity score across assessments. Measures overall physical health of the asset fleet."
    - name: "avg_performance_score"
      expr: AVG(CAST(performance_score AS DOUBLE))
      comment: "Average performance score across assessed assets. Tracks functional performance trends to inform maintenance strategy adjustments."
    - name: "critical_defect_assets_count"
      expr: COUNT(CASE WHEN CAST(critical_defect_count AS INT) > 0 THEN 1 END)
      comment: "Number of assessments identifying at least one critical defect. Directly informs emergency repair prioritisation and regulatory risk exposure."
    - name: "assets_overdue_reassessment_count"
      expr: COUNT(CASE WHEN next_assessment_due_date < CURRENT_DATE() AND next_assessment_due_date IS NOT NULL THEN 1 END)
      comment: "Number of assets whose next assessment due date has passed without a new assessment. Tracks compliance with assessment programme schedules."
    - name: "high_risk_assessment_count"
      expr: COUNT(CASE WHEN CAST(risk_score AS DOUBLE) >= 7.0 THEN 1 END)
      comment: "Count of assessments with a risk score of 7 or above (high-risk threshold). Used to size the high-priority renewal backlog."
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`asset_failure_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Asset failure and reliability KPIs. Supports root cause analysis, regulatory notification tracking, service reliability reporting, and O&M cost management."
  source: "`vibe_water_utilities_v1`.`asset`.`failure_record`"
  dimensions:
    - name: "failure_mode"
      expr: failure_mode
      comment: "Mode of failure (e.g. Corrosion, Mechanical, Structural) — primary dimension for root cause and renewal strategy analysis."
    - name: "failure_cause"
      expr: failure_cause
      comment: "Root cause of the failure — used to identify systemic issues driving repeated failures."
    - name: "failure_severity"
      expr: failure_severity
      comment: "Severity classification of the failure (Critical, Major, Minor) — used to prioritise response and track risk exposure."
    - name: "failure_status"
      expr: failure_status
      comment: "Current resolution status of the failure record — used for open failure backlog management."
    - name: "affected_system"
      expr: affected_system
      comment: "Water system component affected (e.g. Distribution, Treatment, Collection) — enables system-level reliability benchmarking."
    - name: "service_interruption_flag"
      expr: service_interruption_flag
      comment: "Indicates whether the failure caused a customer service interruption — directly linked to service reliability KPIs."
    - name: "regulatory_notification_required_flag"
      expr: regulatory_notification_required_flag
      comment: "Indicates whether regulatory notification was required — tracks compliance obligations arising from failures."
    - name: "cso_event_flag"
      expr: cso_event_flag
      comment: "Combined Sewer Overflow event flag — critical environmental compliance and regulatory reporting dimension."
    - name: "sso_event_flag"
      expr: sso_event_flag
      comment: "Sanitary Sewer Overflow event flag — critical environmental compliance and regulatory reporting dimension."
    - name: "failure_year"
      expr: YEAR(failure_date)
      comment: "Year the failure occurred — used for year-over-year reliability trend analysis."
    - name: "failure_month"
      expr: DATE_TRUNC('MONTH', failure_date)
      comment: "Month the failure occurred — used for seasonal failure pattern analysis."
  measures:
    - name: "total_failure_events"
      expr: COUNT(1)
      comment: "Total number of recorded failure events. Baseline reliability metric — rising trend triggers infrastructure investment review."
    - name: "total_actual_repair_cost"
      expr: SUM(CAST(actual_repair_cost AS DOUBLE))
      comment: "Total actual repair cost across all failure events. Measures the financial impact of asset failures on O&M budget."
    - name: "avg_repair_cost_per_failure"
      expr: AVG(CAST(actual_repair_cost AS DOUBLE))
      comment: "Average repair cost per failure event. Benchmarks unit failure cost and identifies high-cost failure modes for targeted investment."
    - name: "total_downtime_hours"
      expr: SUM(CAST(downtime_duration_hours AS DOUBLE))
      comment: "Total downtime hours resulting from failures. Measures aggregate service reliability impact across the network."
    - name: "avg_mttr_hours"
      expr: AVG(CAST(mttr_hours AS DOUBLE))
      comment: "Average Mean Time to Repair in hours. Core reliability KPI — directly measures maintenance responsiveness and crew efficiency."
    - name: "total_overflow_volume_gallons"
      expr: SUM(CAST(overflow_volume_gallons AS DOUBLE))
      comment: "Total overflow volume in gallons from CSO/SSO events. Critical environmental compliance metric reported to regulators."
    - name: "total_production_loss_mgd"
      expr: SUM(CAST(production_loss_mgd AS DOUBLE))
      comment: "Total production loss in million gallons per day due to failures. Quantifies supply reliability impact for operational and regulatory reporting."
    - name: "service_interruption_event_count"
      expr: COUNT(CASE WHEN service_interruption_flag = TRUE THEN 1 END)
      comment: "Number of failures that caused customer service interruptions. Key service reliability KPI tied to customer satisfaction and regulatory standards."
    - name: "regulatory_notification_event_count"
      expr: COUNT(CASE WHEN regulatory_notification_required_flag = TRUE THEN 1 END)
      comment: "Number of failures requiring regulatory notification. Tracks compliance exposure and notification obligation fulfilment."
    - name: "root_cause_analysis_completion_rate"
      expr: COUNT(CASE WHEN root_cause_analysis_completed_flag = TRUE THEN 1 END)
      comment: "Count of failures where root cause analysis was completed. Measures quality of failure investigation programme — low values indicate systemic gaps."
    - name: "cso_sso_event_count"
      expr: COUNT(CASE WHEN cso_event_flag = TRUE OR sso_event_flag = TRUE THEN 1 END)
      comment: "Total count of Combined or Sanitary Sewer Overflow events. Critical environmental compliance KPI with direct regulatory reporting obligations."
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`asset_inspection_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Inspection programme performance and compliance KPIs. Tracks inspection throughput, deficiency rates, regulatory compliance, and corrective action follow-through."
  source: "`vibe_water_utilities_v1`.`asset`.`inspection_event`"
  dimensions:
    - name: "inspection_type"
      expr: inspection_type
      comment: "Type of inspection performed (e.g. Routine, Regulatory, Emergency) — primary dimension for programme analysis."
    - name: "inspection_status"
      expr: inspection_status
      comment: "Current status of the inspection event (Scheduled, In Progress, Completed, Cancelled) — used for programme throughput monitoring."
    - name: "pass_fail_outcome"
      expr: pass_fail_outcome
      comment: "Pass/Fail outcome of the inspection — key quality and compliance indicator."
    - name: "regulatory_inspection_flag"
      expr: regulatory_inspection_flag
      comment: "Indicates whether the inspection was mandated by a regulatory requirement — used to track regulatory programme compliance."
    - name: "critical_deficiency_flag"
      expr: critical_deficiency_flag
      comment: "Indicates whether a critical deficiency was identified — triggers immediate corrective action and executive escalation."
    - name: "corrective_action_required_flag"
      expr: corrective_action_required_flag
      comment: "Indicates whether a corrective action was required following the inspection — used to track remediation backlog."
    - name: "report_submitted_flag"
      expr: report_submitted_flag
      comment: "Indicates whether the inspection report was submitted — tracks regulatory reporting compliance."
    - name: "inspection_year"
      expr: YEAR(inspection_date)
      comment: "Year the inspection was conducted — used for annual programme performance reporting."
    - name: "inspection_month"
      expr: DATE_TRUNC('MONTH', inspection_date)
      comment: "Month the inspection was conducted — used for monthly throughput and scheduling compliance analysis."
    - name: "inspector_name"
      expr: inspector_name
      comment: "Name of the inspector — used for individual performance and workload analysis."
  measures:
    - name: "total_inspections"
      expr: COUNT(1)
      comment: "Total number of inspection events. Baseline metric for inspection programme throughput and regulatory coverage."
    - name: "inspections_with_critical_deficiency_count"
      expr: COUNT(CASE WHEN critical_deficiency_flag = TRUE THEN 1 END)
      comment: "Number of inspections that identified a critical deficiency. Directly measures network safety risk and drives emergency remediation decisions."
    - name: "inspections_requiring_corrective_action_count"
      expr: COUNT(CASE WHEN corrective_action_required_flag = TRUE THEN 1 END)
      comment: "Number of inspections requiring corrective action. Quantifies the remediation backlog arising from the inspection programme."
    - name: "regulatory_inspections_count"
      expr: COUNT(CASE WHEN regulatory_inspection_flag = TRUE THEN 1 END)
      comment: "Count of regulatory-mandated inspections completed. Tracks fulfilment of regulatory inspection obligations."
    - name: "report_submission_compliance_count"
      expr: COUNT(CASE WHEN report_submitted_flag = TRUE THEN 1 END)
      comment: "Number of inspections for which reports were submitted. Measures regulatory reporting compliance — gaps expose the utility to enforcement risk."
    - name: "inspections_overdue_corrective_action_count"
      expr: COUNT(CASE WHEN corrective_action_required_flag = TRUE AND corrective_action_due_date < CURRENT_DATE() AND corrective_action_due_date IS NOT NULL THEN 1 END)
      comment: "Number of inspections with overdue corrective actions. Tracks remediation backlog age — a key regulatory compliance and risk management KPI."
    - name: "avg_deficiencies_per_inspection"
      expr: AVG(CAST(deficiencies_identified_count AS DOUBLE))
      comment: "Average number of deficiencies identified per inspection. Tracks network condition trends and inspection programme effectiveness over time."
    - name: "distinct_facilities_inspected"
      expr: COUNT(DISTINCT facility_id)
      comment: "Number of distinct facilities that received at least one inspection. Measures inspection programme coverage across the facility portfolio."
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`asset_pm_schedule`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Preventive maintenance programme KPIs. Tracks PM schedule coverage, cost planning, compliance, and schedule adherence to support proactive asset management strategy."
  source: "`vibe_water_utilities_v1`.`asset`.`pm_schedule`"
  dimensions:
    - name: "schedule_status"
      expr: schedule_status
      comment: "Current status of the PM schedule (Active, Inactive, Suspended) — used to assess programme coverage and gaps."
    - name: "work_order_type"
      expr: work_order_type
      comment: "Type of work order generated by the PM schedule — used to classify maintenance activity by type."
    - name: "trigger_type"
      expr: trigger_type
      comment: "PM trigger type (Calendar, Meter, Condition) — used to analyse the balance of time-based vs. condition-based maintenance."
    - name: "frequency_unit"
      expr: frequency_unit
      comment: "Unit of PM frequency (Days, Weeks, Months) — used for schedule density and resource demand analysis."
    - name: "priority"
      expr: priority
      comment: "Priority of the PM schedule — used to ensure high-priority assets receive adequate maintenance attention."
    - name: "regulatory_compliance_flag"
      expr: regulatory_compliance_flag
      comment: "Indicates whether the PM schedule is tied to a regulatory compliance requirement — critical for audit readiness."
    - name: "seasonal_schedule_flag"
      expr: seasonal_schedule_flag
      comment: "Indicates whether the PM schedule is seasonal — used for resource demand forecasting across seasons."
    - name: "auto_generate_work_order_flag"
      expr: auto_generate_work_order_flag
      comment: "Indicates whether work orders are auto-generated — measures automation coverage of the PM programme."
    - name: "asset_criticality_rating"
      expr: asset_criticality_rating
      comment: "Criticality rating of the asset covered by the PM schedule — used to validate that critical assets have adequate PM coverage."
    - name: "effective_start_year"
      expr: YEAR(effective_start_date)
      comment: "Year the PM schedule became effective — used for programme vintage analysis."
  measures:
    - name: "total_pm_schedules"
      expr: COUNT(1)
      comment: "Total number of active PM schedules. Baseline metric for preventive maintenance programme coverage."
    - name: "total_estimated_labor_cost"
      expr: SUM(CAST(estimated_labor_cost AS DOUBLE))
      comment: "Total estimated labour cost across all PM schedules. Core input to annual O&M budget planning for preventive maintenance."
    - name: "total_estimated_material_cost"
      expr: SUM(CAST(estimated_material_cost AS DOUBLE))
      comment: "Total estimated material cost across all PM schedules. Used for procurement planning and materials budget forecasting."
    - name: "total_estimated_labor_hours"
      expr: SUM(CAST(estimated_labor_hours AS DOUBLE))
      comment: "Total estimated labour hours across all PM schedules. Used for workforce capacity planning and crew scheduling."
    - name: "avg_estimated_downtime_hours"
      expr: AVG(CAST(estimated_downtime_hours AS DOUBLE))
      comment: "Average estimated downtime per PM schedule. Used to plan maintenance windows and minimise service disruption."
    - name: "pm_schedules_overdue_count"
      expr: COUNT(CASE WHEN next_due_date < CURRENT_DATE() AND next_due_date IS NOT NULL AND schedule_status = 'Active' THEN 1 END)
      comment: "Number of active PM schedules where the next due date has passed. Measures PM backlog — a leading indicator of deferred maintenance risk."
    - name: "regulatory_pm_schedule_count"
      expr: COUNT(CASE WHEN regulatory_compliance_flag = TRUE THEN 1 END)
      comment: "Count of PM schedules tied to regulatory compliance requirements. Tracks the volume of compliance-driven preventive maintenance obligations."
    - name: "auto_generated_pm_schedule_count"
      expr: COUNT(CASE WHEN auto_generate_work_order_flag = TRUE THEN 1 END)
      comment: "Number of PM schedules configured for automatic work order generation. Measures automation maturity of the PM programme."
    - name: "distinct_assets_with_pm_coverage"
      expr: COUNT(DISTINCT registry_id)
      comment: "Number of distinct assets covered by at least one PM schedule. Measures PM programme coverage breadth across the asset fleet."
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`asset_acquisition`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Capital acquisition KPIs tracking asset procurement spend, grant funding, warranty coverage, and capitalisation compliance. Supports CIP financial reporting and regulatory rate-case submissions."
  source: "`vibe_water_utilities_v1`.`asset`.`acquisition`"
  dimensions:
    - name: "acquisition_type"
      expr: acquisition_type
      comment: "Type of acquisition (Purchase, Construction, Donation, Transfer) — used to classify capital spend by procurement method."
    - name: "acquisition_status"
      expr: acquisition_status
      comment: "Current status of the acquisition (Pending, Approved, Completed, Cancelled) — used for CIP pipeline and spend tracking."
    - name: "asset_category"
      expr: asset_category
      comment: "Asset category of the acquired asset — used to analyse capital spend distribution across infrastructure categories."
    - name: "funding_source"
      expr: funding_source
      comment: "Source of funding for the acquisition (Rate Revenue, Grant, Bond, Developer Contribution) — critical for financial reporting and grant compliance."
    - name: "depreciation_method"
      expr: depreciation_method
      comment: "Depreciation method applied to the acquired asset — used for financial reporting and rate-case asset valuation."
    - name: "capitalization_threshold_met_flag"
      expr: capitalization_threshold_met_flag
      comment: "Indicates whether the acquisition met the capitalisation threshold — used to validate proper CAPEX vs. OPEX classification."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the acquisition cost — used for multi-currency financial consolidation."
    - name: "grant_program_name"
      expr: grant_program_name
      comment: "Name of the grant programme funding the acquisition — used for grant compliance reporting and drawdown tracking."
    - name: "acquisition_year"
      expr: YEAR(acquisition_date)
      comment: "Year of acquisition — used for capital spend trend analysis and CIP vintage reporting."
    - name: "commissioning_year"
      expr: YEAR(commissioning_date)
      comment: "Year the acquired asset was commissioned — used to track time-to-service for capital projects."
  measures:
    - name: "total_acquisition_cost"
      expr: SUM(CAST(cost AS DOUBLE))
      comment: "Total capital acquisition cost. Primary CIP expenditure KPI for rate-case submissions and capital programme financial reporting."
    - name: "avg_acquisition_cost"
      expr: AVG(CAST(cost AS DOUBLE))
      comment: "Average acquisition cost per asset. Used to benchmark unit capital costs across asset categories and procurement methods."
    - name: "total_salvage_value"
      expr: SUM(CAST(salvage_value AS DOUBLE))
      comment: "Total estimated salvage value of acquired assets. Used in depreciation calculations and asset disposal financial planning."
    - name: "total_acquisitions"
      expr: COUNT(1)
      comment: "Total number of asset acquisitions. Tracks capital programme activity volume for CIP progress reporting."
    - name: "capitalised_acquisition_count"
      expr: COUNT(CASE WHEN capitalization_threshold_met_flag = TRUE THEN 1 END)
      comment: "Number of acquisitions that met the capitalisation threshold. Validates proper CAPEX classification and supports rate base calculations."
    - name: "grant_funded_acquisition_count"
      expr: COUNT(CASE WHEN grant_program_name IS NOT NULL AND grant_program_name <> '' THEN 1 END)
      comment: "Number of acquisitions funded through grant programmes. Tracks grant utilisation and compliance with grant-funded capital obligations."
    - name: "warranty_active_acquisition_count"
      expr: COUNT(CASE WHEN warranty_expiry_date >= CURRENT_DATE() AND warranty_expiry_date IS NOT NULL THEN 1 END)
      comment: "Number of acquired assets currently under warranty. Tracks warranty coverage to ensure warranty claims are pursued before expiry."
    - name: "avg_useful_life_years"
      expr: AVG(CAST(useful_life_years AS DOUBLE))
      comment: "Average expected useful life in years of acquired assets. Used in depreciation scheduling and long-range capital renewal forecasting."
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`asset_criticality_rating`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Asset risk and criticality KPIs derived from formal criticality assessments. Supports risk-based capital prioritisation, maintenance strategy optimisation, and regulatory consequence-of-failure reporting."
  source: "`vibe_water_utilities_v1`.`asset`.`criticality_rating`"
  dimensions:
    - name: "criticality_tier"
      expr: criticality_tier
      comment: "Criticality tier assigned to the asset (e.g. Tier 1 Critical, Tier 2 High, Tier 3 Medium) — primary dimension for risk-based prioritisation."
    - name: "rating_status"
      expr: rating_status
      comment: "Current status of the criticality rating (Active, Expired, Under Review) — used to ensure ratings are current and valid."
    - name: "cip_eligibility_flag"
      expr: cip_eligibility_flag
      comment: "Indicates whether the asset is eligible for Capital Improvement Programme funding based on its criticality — drives CIP prioritisation."
    - name: "environmental_impact_flag"
      expr: environmental_impact_flag
      comment: "Indicates whether failure of this asset would have an environmental impact — used for environmental risk reporting."
    - name: "public_health_impact_flag"
      expr: public_health_impact_flag
      comment: "Indicates whether failure would impact public health — highest-priority risk dimension for water utilities."
    - name: "safety_impact_flag"
      expr: safety_impact_flag
      comment: "Indicates whether failure poses a safety risk — used for safety-critical asset identification and prioritisation."
    - name: "regulatory_consequence_flag"
      expr: regulatory_consequence_flag
      comment: "Indicates whether failure would trigger a regulatory consequence — used to identify assets with compliance-critical status."
    - name: "redundancy_available_flag"
      expr: redundancy_available_flag
      comment: "Indicates whether redundancy is available for this asset — used to assess resilience and single-point-of-failure risk."
    - name: "assessment_year"
      expr: YEAR(assessment_date)
      comment: "Year the criticality assessment was performed — used to track assessment programme currency."
    - name: "methodology_version"
      expr: methodology_version
      comment: "Version of the criticality assessment methodology used — ensures comparability of scores across assessment cycles."
  measures:
    - name: "total_criticality_assessments"
      expr: COUNT(1)
      comment: "Total number of criticality assessments on record. Baseline metric for criticality programme coverage."
    - name: "avg_overall_risk_score"
      expr: AVG(CAST(overall_risk_score AS DOUBLE))
      comment: "Average overall risk score across all assessed assets. Executive-level portfolio risk indicator — drives strategic investment prioritisation."
    - name: "avg_consequence_of_failure_score"
      expr: AVG(CAST(consequence_of_failure_score AS DOUBLE))
      comment: "Average consequence-of-failure score. Measures the potential impact severity across the asset portfolio — informs risk mitigation investment."
    - name: "avg_likelihood_of_failure_score"
      expr: AVG(CAST(likelihood_of_failure_score AS DOUBLE))
      comment: "Average likelihood-of-failure score. Tracks the probability dimension of asset risk — rising values signal deteriorating asset health."
    - name: "total_financial_impact_amount"
      expr: SUM(CAST(financial_impact_amount AS DOUBLE))
      comment: "Total estimated financial impact of failure across all assessed assets. Quantifies the financial risk exposure of the asset portfolio."
    - name: "avg_service_disruption_duration_hours"
      expr: AVG(CAST(service_disruption_duration_hours AS DOUBLE))
      comment: "Average estimated service disruption duration in hours upon failure. Measures customer impact risk and informs service reliability investment decisions."
    - name: "cip_eligible_asset_count"
      expr: COUNT(CASE WHEN cip_eligibility_flag = TRUE THEN 1 END)
      comment: "Number of assets eligible for CIP funding based on criticality. Sizes the CIP-eligible renewal backlog for capital programme planning."
    - name: "public_health_risk_asset_count"
      expr: COUNT(CASE WHEN public_health_impact_flag = TRUE THEN 1 END)
      comment: "Number of assets whose failure would impact public health. Highest-priority risk metric for water utility executives and regulators."
    - name: "no_redundancy_critical_asset_count"
      expr: COUNT(CASE WHEN redundancy_available_flag = FALSE AND criticality_tier IS NOT NULL THEN 1 END)
      comment: "Number of assets with no redundancy available. Identifies single-point-of-failure risks requiring urgent resilience investment."
    - name: "ratings_expiring_within_90_days_count"
      expr: COUNT(CASE WHEN rating_expiration_date BETWEEN CURRENT_DATE() AND DATE_ADD(CURRENT_DATE(), 90) THEN 1 END)
      comment: "Number of criticality ratings expiring within the next 90 days. Ensures the criticality programme remains current and defensible for regulatory audits."
$$;