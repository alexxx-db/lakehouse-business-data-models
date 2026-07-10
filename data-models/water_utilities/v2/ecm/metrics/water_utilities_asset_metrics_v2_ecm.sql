-- Metric views for domain: asset | Business: Water_Utilities | Version: 2 | Generated on: 2026-07-10 19:05:00

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`asset_registry`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core asset portfolio health and lifecycle metrics derived from the asset registry. Used by asset managers, capital planning teams, and executives to monitor fleet condition, replacement risk, and investment priorities."
  source: "`vibe_water_utilities_v1`.`asset`.`registry`"
  dimensions:
    - name: "asset_category"
      expr: asset_category
      comment: "High-level asset category (e.g., pipe, pump, valve) for portfolio segmentation."
    - name: "asset_type"
      expr: asset_type
      comment: "Specific asset type within a category for granular analysis."
    - name: "operational_status"
      expr: operational_status
      comment: "Current operational status of the asset (Active, Inactive, Decommissioned) for fleet availability analysis."
    - name: "condition_grade"
      expr: condition_grade
      comment: "Latest condition grade assigned to the asset, used to prioritize rehabilitation and replacement."
    - name: "criticality_rating"
      expr: criticality_rating
      comment: "Asset criticality tier for risk-based maintenance prioritization."
    - name: "maintenance_strategy"
      expr: maintenance_strategy
      comment: "Maintenance strategy applied (Preventive, Corrective, Predictive) for strategy mix analysis."
    - name: "pipe_material"
      expr: pipe_material
      comment: "Pipe material type (e.g., Cast Iron, PVC, Ductile Iron) for material risk and replacement planning."
    - name: "pressure_zone"
      expr: pressure_zone
      comment: "Pressure zone the asset belongs to for hydraulic and operational segmentation."
    - name: "is_lead_service_line"
      expr: is_lead_service_line
      comment: "Flag indicating whether the asset is a lead service line, critical for LCRR compliance tracking."
    - name: "installation_year"
      expr: YEAR(installation_date)
      comment: "Year the asset was installed, used for age cohort analysis and replacement wave planning."
  measures:
    - name: "total_active_assets"
      expr: COUNT(CASE WHEN operational_status = 'Active' THEN 1 END)
      comment: "Total number of active assets in the registry. Baseline fleet size metric used in capacity and risk planning."
    - name: "total_acquisition_cost"
      expr: SUM(CAST(acquisition_cost AS DOUBLE))
      comment: "Total acquisition cost of all registered assets. Represents the gross asset base for capital planning and rate-setting."
    - name: "avg_acquisition_cost"
      expr: AVG(CAST(acquisition_cost AS DOUBLE))
      comment: "Average acquisition cost per asset. Used to benchmark unit replacement costs across asset categories."
    - name: "total_replacement_cost"
      expr: SUM(CAST(replacement_cost AS DOUBLE))
      comment: "Total current replacement cost of the asset portfolio. Key input for rate cases, insurance valuation, and CIP budgeting."
    - name: "avg_replacement_cost"
      expr: AVG(CAST(replacement_cost AS DOUBLE))
      comment: "Average replacement cost per asset. Used to estimate per-unit renewal investment requirements."
    - name: "lead_service_line_count"
      expr: COUNT(CASE WHEN is_lead_service_line = TRUE THEN 1 END)
      comment: "Total count of lead service lines in the registry. Critical LCRR compliance metric tracked by regulators and executives."
    - name: "lead_service_line_replacement_cost"
      expr: SUM(CASE WHEN is_lead_service_line = TRUE THEN replacement_cost ELSE 0 END)
      comment: "Total estimated replacement cost for all lead service lines. Drives LCRR capital program sizing and grant applications."
    - name: "avg_asset_age_years"
      expr: AVG(DATEDIFF(CURRENT_DATE(), installation_date) / 365.25)
      comment: "Average age of assets in years. Aging infrastructure is a primary driver of failure risk and capital investment decisions."
    - name: "assets_past_useful_life_count"
      expr: COUNT(CASE WHEN DATEDIFF(CURRENT_DATE(), installation_date) / 365.25 > CAST(expected_useful_life_years AS DOUBLE) THEN 1 END)
      comment: "Number of assets that have exceeded their expected useful life. Directly informs renewal prioritization and risk exposure."
    - name: "poor_condition_asset_count"
      expr: COUNT(CASE WHEN condition_grade IN ('Poor', 'Very Poor', 'Critical', 'D', 'E', 'F') THEN 1 END)
      comment: "Count of assets in poor or critical condition. Drives immediate rehabilitation and replacement investment decisions."
    - name: "poor_condition_replacement_cost"
      expr: SUM(CASE WHEN condition_grade IN ('Poor', 'Very Poor', 'Critical', 'D', 'E', 'F') THEN replacement_cost ELSE 0 END)
      comment: "Total replacement cost of assets in poor or critical condition. Quantifies the capital exposure from deteriorated infrastructure."
    - name: "decommissioned_asset_count"
      expr: COUNT(CASE WHEN operational_status = 'Decommissioned' THEN 1 END)
      comment: "Count of decommissioned assets. Tracks fleet retirement rate and informs asset lifecycle management strategy."
    - name: "scada_monitored_asset_count"
      expr: COUNT(CASE WHEN scada_tag IS NOT NULL THEN 1 END)
      comment: "Number of assets with active SCADA monitoring. Indicates real-time operational visibility and smart infrastructure coverage."
    - name: "assets_due_for_maintenance"
      expr: COUNT(CASE WHEN next_maintenance_date <= CURRENT_DATE() THEN 1 END)
      comment: "Count of assets with overdue or due maintenance. Operational KPI for maintenance backlog management."
    - name: "total_rated_capacity"
      expr: SUM(CAST(rated_capacity AS DOUBLE))
      comment: "Total rated capacity across all assets. Used for system capacity planning and regulatory reporting."
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`asset_condition_assessment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Asset condition and risk metrics derived from condition assessments. Used by asset managers and engineers to track infrastructure health, prioritize rehabilitation, and manage risk exposure across the asset portfolio."
  source: "`vibe_water_utilities_v1`.`asset`.`condition_assessment`"
  dimensions:
    - name: "assessment_type"
      expr: assessment_type
      comment: "Type of condition assessment performed (e.g., Visual, CCTV, Structural) for methodology analysis."
    - name: "assessment_status"
      expr: assessment_status
      comment: "Current status of the assessment (Completed, Pending, In Progress) for workflow tracking."
    - name: "condition_grade"
      expr: condition_grade
      comment: "Condition grade assigned during assessment, the primary output used for rehabilitation prioritization."
    - name: "criticality_rating"
      expr: criticality_rating
      comment: "Criticality rating of the assessed asset for risk-weighted analysis."
    - name: "recommended_action"
      expr: recommended_action
      comment: "Recommended action from the assessment (Repair, Replace, Monitor) for capital program planning."
    - name: "recommended_action_priority"
      expr: recommended_action_priority
      comment: "Priority level of the recommended action for investment sequencing."
    - name: "assessment_year"
      expr: YEAR(assessment_date)
      comment: "Year the assessment was conducted for trend analysis."
    - name: "regulatory_compliance_flag"
      expr: regulatory_compliance_flag
      comment: "Whether the assessment was triggered by a regulatory compliance requirement."
  measures:
    - name: "total_assessments_completed"
      expr: COUNT(CASE WHEN assessment_status = 'Completed' THEN 1 END)
      comment: "Total number of completed condition assessments. Baseline productivity metric for the asset inspection program."
    - name: "avg_condition_performance_score"
      expr: AVG(CAST(performance_score AS DOUBLE))
      comment: "Average performance score across all assessed assets. Portfolio-level health indicator used in executive dashboards."
    - name: "avg_risk_score"
      expr: AVG(CAST(risk_score AS DOUBLE))
      comment: "Average risk score across assessed assets. Drives risk-based maintenance prioritization and capital investment decisions."
    - name: "avg_structural_integrity_score"
      expr: AVG(CAST(structural_integrity_score AS DOUBLE))
      comment: "Average structural integrity score. Key indicator of infrastructure safety and regulatory compliance posture."
    - name: "total_estimated_repair_cost"
      expr: SUM(CAST(estimated_repair_cost AS DOUBLE))
      comment: "Total estimated repair cost across all assessments. Quantifies the near-term capital requirement for rehabilitation."
    - name: "total_estimated_replacement_cost"
      expr: SUM(CAST(estimated_replacement_cost AS DOUBLE))
      comment: "Total estimated replacement cost from condition assessments. Informs long-term CIP budgeting and rate case filings."
    - name: "avg_remaining_useful_life_years"
      expr: AVG(CAST(remaining_useful_life_years AS DOUBLE))
      comment: "Average remaining useful life across assessed assets. Critical input for renewal wave forecasting and financial planning."
    - name: "avg_failure_probability"
      expr: AVG(CAST(failure_probability AS DOUBLE))
      comment: "Average probability of failure across assessed assets. Used in risk-based asset management to prioritize interventions."
    - name: "high_risk_asset_count"
      expr: COUNT(CASE WHEN risk_score >= 7.0 THEN 1 END)
      comment: "Count of assets with high risk scores (>=7). Directly drives capital prioritization and emergency preparedness planning."
    - name: "critical_defect_assessments"
      expr: COUNT(CASE WHEN critical_defect_count > '0' THEN 1 END)
      comment: "Number of assessments identifying critical defects. Triggers immediate corrective action and regulatory notification workflows."
    - name: "avg_defect_count"
      expr: AVG(CAST(defect_count AS DOUBLE))
      comment: "Average number of defects identified per assessment. Tracks infrastructure deterioration trends over time."
    - name: "regulatory_non_compliant_count"
      expr: COUNT(CASE WHEN regulatory_compliance_flag = FALSE THEN 1 END)
      comment: "Count of assessments where regulatory compliance was not met. Critical compliance risk metric for executive and regulatory reporting."
    - name: "repair_vs_replace_ratio"
      expr: ROUND(SUM(CAST(estimated_repair_cost AS DOUBLE)) / NULLIF(SUM(CAST(estimated_replacement_cost AS DOUBLE)), 0), 4)
      comment: "Ratio of estimated repair cost to replacement cost. Values approaching 1.0 indicate replacement is more economical than repair."
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`asset_work_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Work order performance and cost metrics for the asset maintenance program. Used by operations managers, finance, and executives to track maintenance efficiency, cost control, and regulatory compliance of field work."
  source: "`vibe_water_utilities_v1`.`asset`.`work_order`"
  dimensions:
    - name: "work_order_type"
      expr: work_order_type
      comment: "Type of work order (Preventive, Corrective, Emergency, Inspection) for maintenance strategy analysis."
    - name: "work_order_status"
      expr: work_order_status
      comment: "Current status of the work order (Open, In Progress, Closed, Cancelled) for backlog management."
    - name: "priority"
      expr: priority
      comment: "Work order priority level for resource allocation and SLA compliance analysis."
    - name: "cause_code"
      expr: cause_code
      comment: "Root cause code for the work order, used to identify systemic failure patterns."
    - name: "failure_code"
      expr: failure_code
      comment: "Failure mode code for corrective work orders, used in reliability-centered maintenance analysis."
    - name: "regulatory_compliance_flag"
      expr: regulatory_compliance_flag
      comment: "Whether the work order is tied to a regulatory compliance requirement."
    - name: "reported_year"
      expr: YEAR(reported_date)
      comment: "Year the work order was reported for trend and seasonality analysis."
    - name: "scheduled_start_month"
      expr: DATE_TRUNC('MONTH', scheduled_start_date)
      comment: "Month the work order was scheduled to start for workload planning."
  measures:
    - name: "total_work_orders"
      expr: COUNT(1)
      comment: "Total number of work orders. Baseline volume metric for maintenance program sizing and resource planning."
    - name: "open_work_order_count"
      expr: COUNT(CASE WHEN work_order_status NOT IN ('Closed', 'Cancelled') THEN 1 END)
      comment: "Count of open/active work orders. Tracks maintenance backlog, a key operational health indicator."
    - name: "emergency_work_order_count"
      expr: COUNT(CASE WHEN work_order_type = 'Emergency' THEN 1 END)
      comment: "Count of emergency work orders. High emergency rates signal reactive maintenance posture and infrastructure risk."
    - name: "total_actual_cost"
      expr: SUM(CAST(actual_cost AS DOUBLE))
      comment: "Total actual cost of all work orders. Primary maintenance expenditure metric for budget management and rate cases."
    - name: "total_estimated_cost"
      expr: SUM(CAST(estimated_cost AS DOUBLE))
      comment: "Total estimated cost of work orders. Used for budget forecasting and cost variance analysis."
    - name: "cost_variance"
      expr: SUM(CAST(actual_cost AS DOUBLE) - CAST(estimated_cost AS DOUBLE))
      comment: "Total cost variance (actual minus estimated) across all work orders. Negative variance indicates under-budget performance."
    - name: "avg_actual_cost_per_work_order"
      expr: AVG(CAST(actual_cost AS DOUBLE))
      comment: "Average actual cost per work order. Benchmarks maintenance unit cost efficiency across work types and asset classes."
    - name: "total_actual_labor_hours"
      expr: SUM(CAST(actual_labor_hours AS DOUBLE))
      comment: "Total actual labor hours expended on work orders. Drives workforce capacity planning and productivity analysis."
    - name: "avg_labor_hours_per_work_order"
      expr: AVG(CAST(actual_labor_hours AS DOUBLE))
      comment: "Average labor hours per work order. Used to benchmark crew productivity and estimate future resource requirements."
    - name: "total_downtime_hours"
      expr: SUM(CAST(downtime_duration_hours AS DOUBLE))
      comment: "Total asset downtime hours from work orders. Directly impacts service reliability and customer satisfaction metrics."
    - name: "avg_downtime_hours_per_work_order"
      expr: AVG(CAST(downtime_duration_hours AS DOUBLE))
      comment: "Average downtime per work order. Used to assess maintenance efficiency and service disruption impact."
    - name: "cost_overrun_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN actual_cost > estimated_cost THEN 1 END) / NULLIF(COUNT(CASE WHEN estimated_cost > 0 THEN 1 END), 0), 2)
      comment: "Percentage of work orders where actual cost exceeded estimate. Indicates estimating accuracy and cost control effectiveness."
    - name: "regulatory_work_order_count"
      expr: COUNT(CASE WHEN regulatory_compliance_flag = TRUE THEN 1 END)
      comment: "Count of work orders tied to regulatory compliance requirements. Tracks compliance-driven maintenance obligations."
    - name: "warranty_claim_count"
      expr: COUNT(CASE WHEN warranty_claim = TRUE THEN 1 END)
      comment: "Count of work orders with warranty claims filed. Tracks warranty recovery opportunities and vendor performance."
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`asset_failure_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Asset failure analysis and reliability metrics. Used by asset managers, operations, and executives to understand failure patterns, quantify service impacts, and drive reliability-centered maintenance investments."
  source: "`vibe_water_utilities_v1`.`asset`.`failure_record`"
  dimensions:
    - name: "failure_mode"
      expr: failure_mode
      comment: "Mode of failure (e.g., Corrosion, Mechanical, Structural) for root cause pattern analysis."
    - name: "failure_cause"
      expr: failure_cause
      comment: "Root cause of the failure for systemic issue identification and prevention planning."
    - name: "failure_severity"
      expr: failure_severity
      comment: "Severity classification of the failure for risk prioritization."
    - name: "failure_status"
      expr: failure_status
      comment: "Current resolution status of the failure record."
    - name: "affected_system"
      expr: affected_system
      comment: "Water system component affected by the failure for system-level reliability analysis."
    - name: "failure_year"
      expr: YEAR(failure_date)
      comment: "Year of failure occurrence for trend analysis and MTBF calculations."
    - name: "service_interruption_flag"
      expr: service_interruption_flag
      comment: "Whether the failure caused a customer service interruption, linking asset reliability to customer experience."
    - name: "regulatory_notification_required_flag"
      expr: regulatory_notification_required_flag
      comment: "Whether the failure required regulatory notification, indicating compliance-critical events."
  measures:
    - name: "total_failure_events"
      expr: COUNT(1)
      comment: "Total number of recorded asset failures. Baseline reliability metric for the asset portfolio."
    - name: "service_interruption_count"
      expr: COUNT(CASE WHEN service_interruption_flag = TRUE THEN 1 END)
      comment: "Number of failures that caused customer service interruptions. Directly measures reliability impact on customers."
    - name: "service_interruption_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN service_interruption_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of failures causing service interruptions. Key customer reliability KPI for executive and regulatory reporting."
    - name: "total_actual_repair_cost"
      expr: SUM(CAST(actual_repair_cost AS DOUBLE))
      comment: "Total actual cost to repair failed assets. Quantifies the financial impact of asset failures on O&M budget."
    - name: "avg_repair_cost_per_failure"
      expr: AVG(CAST(actual_repair_cost AS DOUBLE))
      comment: "Average repair cost per failure event. Used to benchmark failure cost by asset type and failure mode."
    - name: "total_downtime_hours"
      expr: SUM(CAST(downtime_duration_hours AS DOUBLE))
      comment: "Total downtime hours resulting from asset failures. Measures operational impact and drives reliability investment decisions."
    - name: "avg_mttr_hours"
      expr: AVG(CAST(mttr_hours AS DOUBLE))
      comment: "Average mean time to repair across all failure events. Core reliability KPI used to assess maintenance responsiveness."
    - name: "total_overflow_volume_gallons"
      expr: SUM(CAST(overflow_volume_gallons AS DOUBLE))
      comment: "Total overflow volume in gallons from failure events. Critical environmental and regulatory compliance metric."
    - name: "cso_event_count"
      expr: COUNT(CASE WHEN cso_event_flag = TRUE THEN 1 END)
      comment: "Count of failures resulting in combined sewer overflow events. Regulatory compliance metric with direct permit implications."
    - name: "sso_event_count"
      expr: COUNT(CASE WHEN sso_event_flag = TRUE THEN 1 END)
      comment: "Count of failures resulting in sanitary sewer overflow events. High-priority regulatory and public health metric."
    - name: "regulatory_notification_count"
      expr: COUNT(CASE WHEN regulatory_notification_required_flag = TRUE THEN 1 END)
      comment: "Count of failures requiring regulatory notification. Tracks compliance exposure and notification obligation fulfillment."
    - name: "root_cause_analysis_completion_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN root_cause_analysis_completed_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of failures with completed root cause analysis. Measures quality of the reliability engineering program."
    - name: "warranty_claim_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN warranty_claim_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of failures resulting in warranty claims. Tracks warranty recovery effectiveness and vendor accountability."
    - name: "avg_production_loss_mgd"
      expr: AVG(CAST(production_loss_mgd AS DOUBLE))
      comment: "Average production loss in million gallons per day from failure events. Quantifies supply reliability impact of asset failures."
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`asset_depreciation_schedule`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Asset depreciation and financial lifecycle metrics. Used by finance, asset management, and rate case teams to track accumulated depreciation, net book value, and remaining useful life for capital planning and GASB compliance."
  source: "`vibe_water_utilities_v1`.`asset`.`depreciation_schedule`"
  dimensions:
    - name: "depreciation_method"
      expr: depreciation_method
      comment: "Depreciation method applied (Straight-Line, Declining Balance, Units of Production) for financial reporting segmentation."
    - name: "asset_class_code"
      expr: asset_class_code
      comment: "Asset class code for portfolio-level depreciation analysis by infrastructure category."
    - name: "schedule_status"
      expr: schedule_status
      comment: "Status of the depreciation schedule (Active, Closed, Suspended) for financial reporting accuracy."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year for period-based depreciation reporting and budget reconciliation."
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period for monthly depreciation tracking and GL reconciliation."
    - name: "company_code"
      expr: company_code
      comment: "Company or fund code for multi-entity financial reporting."
    - name: "capitalization_year"
      expr: YEAR(capitalization_date)
      comment: "Year of asset capitalization for vintage cohort analysis."
  measures:
    - name: "total_acquisition_cost"
      expr: SUM(CAST(acquisition_cost AS DOUBLE))
      comment: "Total gross acquisition cost of all capitalized assets. Represents the gross plant in service for rate base calculations."
    - name: "total_accumulated_depreciation"
      expr: SUM(CAST(accumulated_depreciation AS DOUBLE))
      comment: "Total accumulated depreciation across the asset portfolio. Key metric for rate base and regulatory asset value calculations."
    - name: "total_net_book_value"
      expr: SUM(CAST(net_book_value AS DOUBLE))
      comment: "Total net book value (acquisition cost minus accumulated depreciation). Core financial metric for balance sheet and rate case filings."
    - name: "total_annual_depreciation"
      expr: SUM(CAST(annual_depreciation_amount AS DOUBLE))
      comment: "Total annual depreciation expense. Drives operating cost recovery in rate cases and GASB financial statements."
    - name: "total_period_depreciation"
      expr: SUM(CAST(period_depreciation_amount AS DOUBLE))
      comment: "Total depreciation expense for the current period. Used for monthly financial close and GL reconciliation."
    - name: "total_depreciable_base"
      expr: SUM(CAST(depreciable_base AS DOUBLE))
      comment: "Total depreciable base (acquisition cost minus salvage value). Determines the total depreciation to be recognized over asset lives."
    - name: "total_salvage_value"
      expr: SUM(CAST(salvage_value AS DOUBLE))
      comment: "Total estimated salvage value of the asset portfolio. Reduces depreciable base and impacts long-term financial planning."
    - name: "avg_remaining_useful_life_years"
      expr: AVG(CAST(remaining_useful_life_years AS DOUBLE))
      comment: "Average remaining useful life across all active assets. Critical input for renewal wave forecasting and rate case testimony."
    - name: "total_impairment_loss"
      expr: SUM(CAST(impairment_loss AS DOUBLE))
      comment: "Total impairment losses recognized. Signals significant asset value write-downs requiring executive and board attention."
    - name: "depreciation_coverage_ratio"
      expr: ROUND(SUM(CAST(accumulated_depreciation AS DOUBLE)) / NULLIF(SUM(CAST(acquisition_cost AS DOUBLE)), 0), 4)
      comment: "Ratio of accumulated depreciation to acquisition cost. Values approaching 1.0 indicate an aging fleet requiring near-term replacement investment."
    - name: "total_disposal_proceeds"
      expr: SUM(CAST(disposal_proceeds AS DOUBLE))
      comment: "Total proceeds received from asset disposals. Tracks asset retirement revenue and informs salvage value assumptions."
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`asset_pm_schedule`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Preventive maintenance program metrics. Used by maintenance managers and operations leadership to track PM program coverage, compliance, and cost efficiency across the asset portfolio."
  source: "`vibe_water_utilities_v1`.`asset`.`pm_schedule`"
  dimensions:
    - name: "schedule_status"
      expr: schedule_status
      comment: "Status of the PM schedule (Active, Inactive, Suspended) for program coverage analysis."
    - name: "trigger_type"
      expr: trigger_type
      comment: "PM trigger type (Calendar, Meter-Based, Condition-Based) for maintenance strategy mix analysis."
    - name: "work_order_type"
      expr: work_order_type
      comment: "Type of work order generated by the PM schedule for resource planning."
    - name: "priority"
      expr: priority
      comment: "Priority level of the PM schedule for resource allocation."
    - name: "regulatory_compliance_flag"
      expr: regulatory_compliance_flag
      comment: "Whether the PM schedule is driven by a regulatory compliance requirement."
    - name: "seasonal_schedule_flag"
      expr: seasonal_schedule_flag
      comment: "Whether the PM schedule is seasonal, for workload distribution planning."
    - name: "frequency_unit"
      expr: frequency_unit
      comment: "Unit of PM frequency (Days, Weeks, Months) for schedule density analysis."
  measures:
    - name: "total_active_pm_schedules"
      expr: COUNT(CASE WHEN schedule_status = 'Active' THEN 1 END)
      comment: "Total number of active PM schedules. Measures the breadth of the preventive maintenance program."
    - name: "pm_schedules_overdue"
      expr: COUNT(CASE WHEN next_due_date < CURRENT_DATE() AND schedule_status = 'Active' THEN 1 END)
      comment: "Count of PM schedules past their next due date. Tracks PM compliance backlog and regulatory risk exposure."
    - name: "pm_overdue_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN next_due_date < CURRENT_DATE() AND schedule_status = 'Active' THEN 1 END) / NULLIF(COUNT(CASE WHEN schedule_status = 'Active' THEN 1 END), 0), 2)
      comment: "Percentage of active PM schedules that are overdue. Key PM compliance KPI for operations and regulatory reporting."
    - name: "total_estimated_labor_cost"
      expr: SUM(CAST(estimated_labor_cost AS DOUBLE))
      comment: "Total estimated labor cost across all PM schedules. Drives annual O&M budget planning for the maintenance program."
    - name: "total_estimated_material_cost"
      expr: SUM(CAST(estimated_material_cost AS DOUBLE))
      comment: "Total estimated material cost across all PM schedules. Informs materials procurement planning and inventory management."
    - name: "total_estimated_labor_hours"
      expr: SUM(CAST(estimated_labor_hours AS DOUBLE))
      comment: "Total estimated labor hours for all PM schedules. Used for workforce capacity planning and crew scheduling."
    - name: "avg_estimated_downtime_hours"
      expr: AVG(CAST(estimated_downtime_hours AS DOUBLE))
      comment: "Average estimated downtime per PM event. Used to plan service interruptions and minimize customer impact."
    - name: "regulatory_pm_schedule_count"
      expr: COUNT(CASE WHEN regulatory_compliance_flag = TRUE THEN 1 END)
      comment: "Count of PM schedules driven by regulatory requirements. Tracks compliance-mandated maintenance obligations."
    - name: "auto_generate_wo_count"
      expr: COUNT(CASE WHEN auto_generate_work_order_flag = TRUE THEN 1 END)
      comment: "Count of PM schedules configured for automatic work order generation. Measures automation maturity of the maintenance program."
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`asset_criticality_rating`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Asset criticality and risk metrics derived from formal criticality assessments. Used by asset managers, capital planners, and executives to prioritize investments based on consequence of failure, likelihood of failure, and overall risk scores."
  source: "`vibe_water_utilities_v1`.`asset`.`criticality_rating`"
  dimensions:
    - name: "criticality_tier"
      expr: criticality_tier
      comment: "Criticality tier (Critical, High, Medium, Low) for portfolio risk segmentation."
    - name: "rating_status"
      expr: rating_status
      comment: "Status of the criticality rating (Current, Expired, Under Review) for data quality management."
    - name: "cip_eligibility_flag"
      expr: cip_eligibility_flag
      comment: "Whether the asset is eligible for capital improvement program funding based on criticality."
    - name: "public_health_impact_flag"
      expr: public_health_impact_flag
      comment: "Whether failure of this asset has public health consequences, for regulatory prioritization."
    - name: "environmental_impact_flag"
      expr: environmental_impact_flag
      comment: "Whether failure has environmental impact, for environmental risk management."
    - name: "redundancy_available_flag"
      expr: redundancy_available_flag
      comment: "Whether redundant capacity exists, affecting risk mitigation strategy."
    - name: "assessment_year"
      expr: YEAR(assessment_date)
      comment: "Year of criticality assessment for trend analysis."
  measures:
    - name: "total_assets_rated"
      expr: COUNT(1)
      comment: "Total number of assets with criticality ratings. Measures coverage of the risk assessment program."
    - name: "critical_tier_asset_count"
      expr: COUNT(CASE WHEN criticality_tier IN ('Critical', 'High') THEN 1 END)
      comment: "Count of assets in critical or high criticality tiers. Drives capital prioritization and emergency preparedness planning."
    - name: "avg_overall_risk_score"
      expr: AVG(CAST(overall_risk_score AS DOUBLE))
      comment: "Average overall risk score across the asset portfolio. Portfolio-level risk indicator for executive reporting."
    - name: "avg_consequence_of_failure_score"
      expr: AVG(CAST(consequence_of_failure_score AS DOUBLE))
      comment: "Average consequence of failure score. Measures the potential impact severity of asset failures across the portfolio."
    - name: "avg_likelihood_of_failure_score"
      expr: AVG(CAST(likelihood_of_failure_score AS DOUBLE))
      comment: "Average likelihood of failure score. Measures the probability of failure across the asset portfolio."
    - name: "total_financial_impact_amount"
      expr: SUM(CAST(financial_impact_amount AS DOUBLE))
      comment: "Total estimated financial impact of asset failures. Quantifies the financial risk exposure of the asset portfolio."
    - name: "avg_service_disruption_duration_hours"
      expr: AVG(CAST(service_disruption_duration_hours AS DOUBLE))
      comment: "Average expected service disruption duration from asset failure. Measures customer impact risk across the portfolio."
    - name: "public_health_risk_asset_count"
      expr: COUNT(CASE WHEN public_health_impact_flag = TRUE THEN 1 END)
      comment: "Count of assets whose failure would have public health consequences. Critical metric for regulatory compliance and public safety planning."
    - name: "no_redundancy_critical_count"
      expr: COUNT(CASE WHEN redundancy_available_flag = FALSE AND criticality_tier IN ('Critical', 'High') THEN 1 END)
      comment: "Count of critical/high assets with no redundancy. Represents the highest-risk single-point-of-failure assets requiring immediate investment."
    - name: "cip_eligible_asset_count"
      expr: COUNT(CASE WHEN cip_eligibility_flag = TRUE THEN 1 END)
      comment: "Count of assets eligible for CIP funding based on criticality. Informs capital program scope and budget requests."
    - name: "ratings_expiring_within_year"
      expr: COUNT(CASE WHEN next_review_date <= DATE_ADD(CURRENT_DATE(), 365) AND rating_status = 'Current' THEN 1 END)
      comment: "Count of criticality ratings due for review within the next year. Ensures the risk assessment program remains current and defensible."
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`asset_acquisition`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Capital asset acquisition metrics for investment tracking and program management. Used by finance, asset management, and capital planning teams to monitor acquisition spend, capitalization rates, and procurement performance."
  source: "`vibe_water_utilities_v1`.`asset`.`acquisition`"
  dimensions:
    - name: "acquisition_type"
      expr: acquisition_type
      comment: "Type of acquisition (Purchase, Construction, Donation, Transfer) for investment category analysis."
    - name: "acquisition_status"
      expr: acquisition_status
      comment: "Current status of the acquisition (Pending, Approved, Completed, Cancelled) for pipeline tracking."
    - name: "asset_category"
      expr: asset_category
      comment: "Asset category for acquisition spend analysis by infrastructure type."
    - name: "asset_class"
      expr: asset_class
      comment: "Asset class for granular acquisition analysis."
    - name: "depreciation_method"
      expr: depreciation_method
      comment: "Depreciation method assigned at acquisition for financial planning."
    - name: "capitalization_threshold_met_flag"
      expr: capitalization_threshold_met_flag
      comment: "Whether the acquisition met the capitalization threshold, determining if it is expensed or capitalized."
    - name: "acquisition_year"
      expr: YEAR(acquisition_date)
      comment: "Year of acquisition for capital investment trend analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the acquisition for multi-currency financial reporting."
  measures:
    - name: "total_acquisition_cost"
      expr: SUM(CAST(cost AS DOUBLE))
      comment: "Total capital expenditure on asset acquisitions. Primary CIP spend metric for executive and board reporting."
    - name: "avg_acquisition_cost"
      expr: AVG(CAST(cost AS DOUBLE))
      comment: "Average cost per acquisition. Used to benchmark unit acquisition costs and validate budget estimates."
    - name: "total_capitalized_cost"
      expr: SUM(CASE WHEN capitalization_threshold_met_flag = TRUE THEN cost ELSE 0 END)
      comment: "Total cost of acquisitions that met the capitalization threshold. Represents additions to the rate base."
    - name: "capitalization_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN capitalization_threshold_met_flag = TRUE THEN cost ELSE 0 END) / NULLIF(SUM(CAST(cost AS DOUBLE)), 0), 2)
      comment: "Percentage of acquisition spend that was capitalized vs expensed. Impacts rate base growth and depreciation expense."
    - name: "total_salvage_value"
      expr: SUM(CAST(salvage_value AS DOUBLE))
      comment: "Total estimated salvage value of acquired assets. Reduces depreciable base and impacts long-term financial planning."
    - name: "grant_funded_acquisition_count"
      expr: COUNT(CASE WHEN grant_award_num IS NOT NULL THEN 1 END)
      comment: "Count of acquisitions funded by grants. Tracks grant utilization and reduces ratepayer-funded capital requirements."
    - name: "total_acquisitions_completed"
      expr: COUNT(CASE WHEN acquisition_status = 'Completed' THEN 1 END)
      comment: "Total number of completed asset acquisitions. Measures capital program delivery performance."
    - name: "avg_useful_life_years"
      expr: AVG(CAST(useful_life_years AS DOUBLE))
      comment: "Average useful life assigned to acquired assets. Drives depreciation expense forecasting and long-term renewal planning."
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`asset_inspection_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Asset inspection program performance metrics. Used by operations managers, compliance officers, and executives to track inspection completion rates, deficiency identification, and regulatory compliance of the inspection program."
  source: "`vibe_water_utilities_v1`.`asset`.`inspection_event`"
  dimensions:
    - name: "inspection_type"
      expr: inspection_type
      comment: "Type of inspection (Routine, Regulatory, Emergency, Pre-Commissioning) for program analysis."
    - name: "inspection_status"
      expr: inspection_status
      comment: "Current status of the inspection (Scheduled, In Progress, Completed, Cancelled) for program tracking."
    - name: "pass_fail_outcome"
      expr: pass_fail_outcome
      comment: "Pass/fail outcome of the inspection for compliance rate analysis."
    - name: "regulatory_inspection_flag"
      expr: regulatory_inspection_flag
      comment: "Whether the inspection was required by regulation for compliance program tracking."
    - name: "corrective_action_required_flag"
      expr: corrective_action_required_flag
      comment: "Whether the inspection identified issues requiring corrective action."
    - name: "critical_deficiency_flag"
      expr: critical_deficiency_flag
      comment: "Whether the inspection found critical deficiencies requiring immediate action."
    - name: "inspection_year"
      expr: YEAR(inspection_date)
      comment: "Year of inspection for trend and compliance rate analysis."
  measures:
    - name: "total_inspections_completed"
      expr: COUNT(CASE WHEN inspection_status = 'Completed' THEN 1 END)
      comment: "Total completed inspections. Baseline metric for inspection program productivity and coverage."
    - name: "inspection_pass_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN pass_fail_outcome = 'Pass' THEN 1 END) / NULLIF(COUNT(CASE WHEN inspection_status = 'Completed' THEN 1 END), 0), 2)
      comment: "Percentage of completed inspections that passed. Key infrastructure quality and compliance metric."
    - name: "critical_deficiency_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN critical_deficiency_flag = TRUE THEN 1 END) / NULLIF(COUNT(CASE WHEN inspection_status = 'Completed' THEN 1 END), 0), 2)
      comment: "Percentage of inspections identifying critical deficiencies. Drives immediate corrective action and capital prioritization."
    - name: "total_deficiencies_identified"
      expr: SUM(CAST(deficiencies_identified_count AS DOUBLE))
      comment: "Total number of deficiencies identified across all inspections. Measures overall infrastructure condition and inspection program effectiveness."
    - name: "avg_deficiencies_per_inspection"
      expr: AVG(CAST(deficiencies_identified_count AS DOUBLE))
      comment: "Average deficiencies found per inspection. Tracks infrastructure deterioration trends over time."
    - name: "regulatory_inspection_compliance_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN regulatory_inspection_flag = TRUE AND report_submitted_flag = TRUE THEN 1 END) / NULLIF(COUNT(CASE WHEN regulatory_inspection_flag = TRUE THEN 1 END), 0), 2)
      comment: "Percentage of regulatory inspections with submitted reports. Measures regulatory reporting compliance."
    - name: "avg_inspection_duration_minutes"
      expr: AVG(CAST(duration_minutes AS DOUBLE))
      comment: "Average inspection duration in minutes. Used for workforce planning and inspection program efficiency analysis."
    - name: "overdue_inspection_count"
      expr: COUNT(CASE WHEN next_inspection_due_date < CURRENT_DATE() AND inspection_status != 'Completed' THEN 1 END)
      comment: "Count of inspections past their due date. Tracks inspection backlog and regulatory compliance risk."
    - name: "corrective_action_required_count"
      expr: COUNT(CASE WHEN corrective_action_required_flag = TRUE THEN 1 END)
      comment: "Count of inspections requiring corrective action. Drives work order generation and capital program inputs."
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`asset_warranty`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Asset warranty portfolio and claims metrics. Used by asset managers and procurement teams to track warranty coverage, claims recovery, and vendor accountability across the asset portfolio."
  source: "`vibe_water_utilities_v1`.`asset`.`warranty`"
  dimensions:
    - name: "warranty_type"
      expr: warranty_type
      comment: "Type of warranty (Parts, Labor, Performance, Extended) for coverage analysis."
    - name: "warranty_status"
      expr: warranty_status
      comment: "Current warranty status (Active, Expired, Claimed, Voided) for portfolio management."
    - name: "renewal_option"
      expr: renewal_option
      comment: "Whether the warranty has a renewal option, for proactive warranty management."
    - name: "requires_oem_service"
      expr: requires_oem_service
      comment: "Whether OEM service is required to maintain warranty validity, impacting maintenance contracting decisions."
    - name: "transferable"
      expr: transferable
      comment: "Whether the warranty is transferable, relevant for asset disposals and transfers."
    - name: "coverage_start_year"
      expr: YEAR(coverage_start_date)
      comment: "Year warranty coverage began for cohort analysis."
  measures:
    - name: "total_active_warranties"
      expr: COUNT(CASE WHEN warranty_status = 'Active' THEN 1 END)
      comment: "Total number of active warranties. Measures warranty coverage across the asset portfolio."
    - name: "warranties_expiring_within_90_days"
      expr: COUNT(CASE WHEN coverage_end_date BETWEEN CURRENT_DATE() AND DATE_ADD(CURRENT_DATE(), 90) AND warranty_status = 'Active' THEN 1 END)
      comment: "Count of warranties expiring within 90 days. Drives proactive warranty renewal and inspection scheduling."
    - name: "total_claimed_amount"
      expr: SUM(CAST(claimed_amount_to_date AS DOUBLE))
      comment: "Total warranty claims amount recovered to date. Measures warranty recovery value and reduces net maintenance costs."
    - name: "avg_claimed_amount_per_warranty"
      expr: AVG(CAST(claimed_amount_to_date AS DOUBLE))
      comment: "Average warranty claim amount per warranty. Benchmarks warranty utilization and vendor accountability."
    - name: "total_max_claim_value"
      expr: SUM(CAST(max_claim_value AS DOUBLE))
      comment: "Total maximum claimable value across all active warranties. Quantifies the warranty protection value in the asset portfolio."
    - name: "warranty_utilization_rate"
      expr: ROUND(100.0 * SUM(CAST(claimed_amount_to_date AS DOUBLE)) / NULLIF(SUM(CAST(max_claim_value AS DOUBLE)), 0), 2)
      comment: "Percentage of maximum warranty value that has been claimed. Measures how effectively the organization recovers warranty value."
    - name: "total_extended_warranty_cost"
      expr: SUM(CAST(extended_warranty_cost AS DOUBLE))
      comment: "Total cost of extended warranties purchased. Tracks extended warranty investment for cost-benefit analysis."
    - name: "performance_guarantee_warranty_count"
      expr: COUNT(CASE WHEN performance_guarantee_threshold > 0 THEN 1 END)
      comment: "Count of warranties with performance guarantees. Tracks vendor performance accountability mechanisms."
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`asset_acquisition_financials`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Aggregated acquisition cost to monitor CAPEX spend against budget"
  source: "`vibe_water_utilities_v1`.`asset`.`acquisition`"
  dimensions:
    - name: "acquisition_status"
      expr: acquisition_status
      comment: "Current status of the acquisition process"
  measures:
    - name: "total_acquisition_cost"
      expr: SUM(CAST(cost AS DOUBLE))
      comment: "Total capital outlay for acquired assets"
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`asset_depreciation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Financial health of asset portfolio via depreciation tracking"
  source: "`vibe_water_utilities_v1`.`asset`.`depreciation_schedule`"
  dimensions:
    - name: "depreciation_method"
      expr: depreciation_method
      comment: "Method used for depreciation (e.g., straight-line)"
  measures:
    - name: "total_accumulated_depreciation"
      expr: SUM(CAST(accumulated_depreciation AS DOUBLE))
      comment: "Cumulative depreciation recorded for assets"
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`asset_depreciation_yearly`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Yearly depreciation expense to support budgeting and financial reporting"
  source: "`vibe_water_utilities_v1`.`asset`.`depreciation_schedule`"
  dimensions:
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the depreciation schedule"
  measures:
    - name: "total_annual_depreciation"
      expr: SUM(CAST(annual_depreciation_amount AS DOUBLE))
      comment: "Annual depreciation expense for the fiscal year"
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`asset_failure`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Operational reliability metrics for asset failures"
  source: "`vibe_water_utilities_v1`.`asset`.`failure_record`"
  dimensions:
    - name: "failure_cause"
      expr: failure_cause
      comment: "Root cause of the failure"
  measures:
    - name: "total_failures"
      expr: COUNT(1)
      comment: "Number of recorded asset failures"
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`asset_failure_impact`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Impact of failures on service continuity"
  source: "`vibe_water_utilities_v1`.`asset`.`failure_record`"
  dimensions:
    - name: "failure_severity"
      expr: failure_severity
      comment: "Severity level of the failure"
  measures:
    - name: "total_downtime_hours"
      expr: SUM(CAST(downtime_duration_hours AS DOUBLE))
      comment: "Aggregate downtime caused by asset failures"
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`asset_work_order_duration`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Turnaround time metric for maintenance execution"
  source: "`vibe_water_utilities_v1`.`asset`.`work_order`"
  dimensions:
    - name: "work_order_status"
      expr: work_order_status
      comment: "Current status of the work order"
  measures:
    - name: "average_work_order_duration_hours"
      expr: AVG((unix_timestamp(actual_finish_timestamp) - unix_timestamp(actual_start_timestamp)) / 3600.0)
      comment: "Average time to complete a work order in hours"
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`asset_work_order_performance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Labor utilization and cost efficiency for maintenance activities"
  source: "`vibe_water_utilities_v1`.`asset`.`work_order`"
  dimensions:
    - name: "priority"
      expr: priority
      comment: "Priority level assigned to the work order"
  measures:
    - name: "total_labor_hours"
      expr: SUM(CAST(actual_labor_hours AS DOUBLE))
      comment: "Total labor hours spent on work orders"
$$;