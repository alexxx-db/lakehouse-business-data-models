-- Metric views for domain: asset | Business: Shipping_Ports | Version: 2 | Generated on: 2026-07-13 07:51:56

CREATE OR REPLACE VIEW `vibe_shipping_ports_v1`.`_metrics`.`asset_port_asset`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPI view over the port asset registry. Tracks asset fleet composition, book value, utilization readiness, and maintenance health across all port equipment and infrastructure assets. Used by asset managers and CFOs to steer capital allocation, maintenance investment, and fleet renewal decisions."
  source: "`vibe_shipping_ports_v1`.`asset`.`port_asset`"
  dimensions:
    - name: "asset_category"
      expr: asset_category
      comment: "High-level asset category (e.g., crane, RTG, reach stacker, vessel, infrastructure) for fleet segmentation."
    - name: "asset_status"
      expr: asset_status
      comment: "Current operational status of the asset (Active, Inactive, Under Maintenance, Decommissioned) for availability analysis."
    - name: "criticality_rating"
      expr: criticality_rating
      comment: "Asset criticality classification (Critical, High, Medium, Low) used to prioritize maintenance and capital investment."
    - name: "depreciation_method"
      expr: depreciation_method
      comment: "Depreciation method applied (Straight-Line, Declining Balance, Units of Production) for financial reporting segmentation."
    - name: "capex_classification"
      expr: capex_classification
      comment: "CAPEX classification of the asset (New, Replacement, Expansion, Compliance) for capital planning."
    - name: "maintenance_strategy"
      expr: maintenance_strategy
      comment: "Maintenance strategy applied to the asset (Preventive, Predictive, Corrective, Condition-Based) for M&R strategy analysis."
    - name: "commissioning_year"
      expr: YEAR(commissioning_date)
      comment: "Year the asset was commissioned, used for fleet age cohort analysis."
    - name: "environmental_compliance_flag"
      expr: environmental_compliance_flag
      comment: "Indicates whether the asset meets current environmental compliance standards (True/False)."
  measures:
    - name: "total_assets"
      expr: COUNT(1)
      comment: "Total number of registered port assets. Baseline fleet size KPI used in capacity and capital planning."
    - name: "total_acquisition_cost"
      expr: SUM(CAST(acquisition_cost AS DOUBLE))
      comment: "Total acquisition cost of all port assets in the registry. Represents gross capital deployed in the asset fleet."
    - name: "total_current_book_value"
      expr: SUM(CAST(current_book_value AS DOUBLE))
      comment: "Total net book value of all port assets. Key balance sheet metric for asset-intensive port operations."
    - name: "total_residual_value"
      expr: SUM(CAST(residual_value AS DOUBLE))
      comment: "Total estimated residual value of the asset fleet at end of useful life. Used in depreciation planning and disposal strategy."
    - name: "avg_mean_time_between_failures_hours"
      expr: AVG(CAST(mean_time_between_failures AS DOUBLE))
      comment: "Average MTBF across the asset fleet in hours. A rising MTBF indicates improving reliability; a falling MTBF signals deteriorating fleet health requiring intervention."
    - name: "avg_mean_time_to_repair_hours"
      expr: AVG(CAST(mean_time_to_repair AS DOUBLE))
      comment: "Average MTTR across the asset fleet in hours. Lower MTTR indicates faster recovery from failures, directly impacting terminal throughput."
    - name: "avg_operating_hours"
      expr: AVG(CAST(operating_hours AS DOUBLE))
      comment: "Average cumulative operating hours per asset. Used to assess asset age-in-service and schedule major overhauls."
    - name: "total_swl_rating_tonnes"
      expr: SUM(CAST(swl_rating AS DOUBLE))
      comment: "Total Safe Working Load capacity across the asset fleet in tonnes. Indicates aggregate lifting and handling capacity of the port."
    - name: "assets_due_inspection_count"
      expr: COUNT(CASE WHEN next_inspection_due_date <= CURRENT_DATE() THEN 1 END)
      comment: "Number of assets with an overdue or due-today inspection. A critical safety and compliance KPI — assets past inspection due date must be grounded until re-certified."
    - name: "book_value_to_acquisition_cost_ratio"
      expr: ROUND(100.0 * SUM(CAST(current_book_value AS DOUBLE)) / NULLIF(SUM(CAST(acquisition_cost AS DOUBLE)), 0), 2)
      comment: "Ratio of current net book value to original acquisition cost as a percentage. Indicates average remaining economic life of the fleet; a declining ratio signals fleet aging and upcoming replacement capex."
    - name: "non_compliant_assets_count"
      expr: COUNT(CASE WHEN environmental_compliance_flag = FALSE THEN 1 END)
      comment: "Number of assets not meeting environmental compliance standards. Drives regulatory risk exposure and remediation investment decisions."
$$;

CREATE OR REPLACE VIEW `vibe_shipping_ports_v1`.`_metrics`.`asset_work_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Operational KPI view over maintenance work orders. Tracks M&R execution efficiency, cost performance, downtime impact, and SLA adherence. Used by maintenance managers, operations directors, and CFOs to steer maintenance strategy, contractor performance, and asset reliability investment."
  source: "`vibe_shipping_ports_v1`.`asset`.`work_order`"
  dimensions:
    - name: "work_order_type"
      expr: work_order_type
      comment: "Type of work order (Preventive, Corrective, Emergency, Inspection, Overhaul) for maintenance strategy analysis."
    - name: "work_order_status"
      expr: work_order_status
      comment: "Current status of the work order (Open, In Progress, Completed, Cancelled, On Hold) for pipeline management."
    - name: "priority_level"
      expr: priority_level
      comment: "Work order priority (Critical, High, Medium, Low) for resource allocation and escalation tracking."
    - name: "planned_start_month"
      expr: DATE_TRUNC('MONTH', planned_start_datetime)
      comment: "Month the work order was planned to start, used for maintenance workload trend analysis."
    - name: "warranty_claim_flag"
      expr: warranty_claim_flag
      comment: "Indicates whether the work order has an associated warranty claim (True/False). Used to track warranty recovery value."
    - name: "equipment_shutdown_required_flag"
      expr: equipment_shutdown_required_flag
      comment: "Indicates whether the work order required equipment shutdown (True/False). Used to assess operational impact of maintenance activities."
    - name: "root_cause_code"
      expr: root_cause_code
      comment: "Root cause classification of the maintenance event for failure pattern analysis and preventive action targeting."
  measures:
    - name: "total_work_orders"
      expr: COUNT(1)
      comment: "Total number of work orders. Baseline maintenance activity volume KPI."
    - name: "total_work_order_cost"
      expr: SUM(CAST(total_work_order_cost AS DOUBLE))
      comment: "Total actual cost of all work orders (labour + materials + contractor). Primary M&R expenditure KPI for budget control."
    - name: "total_actual_labour_hours"
      expr: SUM(CAST(actual_labour_hours AS DOUBLE))
      comment: "Total actual labour hours consumed across all work orders. Used to assess workforce utilisation in maintenance operations."
    - name: "total_estimated_labour_hours"
      expr: SUM(CAST(estimated_labour_hours AS DOUBLE))
      comment: "Total planned labour hours for all work orders. Used as the denominator for labour estimation accuracy analysis."
    - name: "total_actual_material_cost"
      expr: SUM(CAST(actual_material_cost AS DOUBLE))
      comment: "Total actual material/spare parts cost across all work orders. Drives spare parts inventory and procurement strategy."
    - name: "total_actual_contractor_cost"
      expr: SUM(CAST(actual_contractor_cost AS DOUBLE))
      comment: "Total actual contractor cost across all work orders. Used to evaluate make-vs-buy decisions for maintenance services."
    - name: "total_downtime_hours"
      expr: SUM(CAST(downtime_hours AS DOUBLE))
      comment: "Total asset downtime hours attributable to maintenance work orders. Directly linked to terminal throughput loss and revenue impact."
    - name: "avg_work_order_cost"
      expr: AVG(CAST(total_work_order_cost AS DOUBLE))
      comment: "Average cost per work order. Benchmarking KPI for maintenance cost efficiency across asset types and contractors."
    - name: "avg_actual_labour_hours_per_wo"
      expr: AVG(CAST(actual_labour_hours AS DOUBLE))
      comment: "Average actual labour hours per work order. Used to assess task complexity and crew sizing accuracy."
    - name: "labour_hours_variance_ratio"
      expr: ROUND(100.0 * SUM(CAST(actual_labour_hours AS DOUBLE)) / NULLIF(SUM(CAST(estimated_labour_hours AS DOUBLE)), 0), 2)
      comment: "Ratio of actual to estimated labour hours as a percentage. Values above 100% indicate systematic under-estimation; used to improve planning accuracy and reduce cost overruns."
    - name: "cost_overrun_ratio"
      expr: ROUND(100.0 * SUM(CAST(actual_material_cost AS DOUBLE) + CAST(actual_contractor_cost AS DOUBLE)) / NULLIF(SUM(CAST(estimated_material_cost AS DOUBLE) + CAST(estimated_contractor_cost AS DOUBLE)), 0), 2)
      comment: "Ratio of actual total cost (materials + contractor) to estimated cost as a percentage. A key contractor and procurement performance KPI — values above 110% trigger contract review."
    - name: "warranty_claim_work_orders"
      expr: COUNT(CASE WHEN warranty_claim_flag = TRUE THEN 1 END)
      comment: "Number of work orders with active warranty claims. Tracks warranty recovery opportunities and supplier accountability."
    - name: "emergency_work_order_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN work_order_type = 'Emergency' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of work orders classified as emergency. A high emergency rate signals reactive maintenance culture and poor asset health — target is below 15% for world-class port operations."
$$;

CREATE OR REPLACE VIEW `vibe_shipping_ports_v1`.`_metrics`.`asset_downtime_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Asset reliability and availability KPI view over downtime records. Tracks equipment downtime duration, causes, operational impact, and SLA breaches. Used by operations directors, terminal managers, and reliability engineers to steer maintenance prioritisation, SLA management, and throughput recovery."
  source: "`vibe_shipping_ports_v1`.`asset`.`downtime_record`"
  dimensions:
    - name: "downtime_category"
      expr: downtime_category
      comment: "Category of downtime event (Mechanical, Electrical, Operational, Weather, External) for root cause trend analysis."
    - name: "downtime_reason_code"
      expr: downtime_reason_code
      comment: "Specific reason code for the downtime event. Used for Pareto analysis of top failure causes."
    - name: "root_cause_category"
      expr: root_cause_category
      comment: "Root cause category of the downtime (Design Defect, Wear, Operator Error, External) for systemic improvement targeting."
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level assigned to the downtime event for escalation and response management."
    - name: "downtime_status"
      expr: downtime_status
      comment: "Current status of the downtime record (Open, Resolved, Under Investigation) for pipeline tracking."
    - name: "is_safety_related"
      expr: is_safety_related
      comment: "Indicates whether the downtime event was safety-related (True/False). Safety-related downtime requires mandatory HSE reporting."
    - name: "sla_breach_flag"
      expr: sla_breach_flag
      comment: "Indicates whether the downtime event breached the SLA response/resolution time (True/False). Drives SLA penalty and contract review actions."
    - name: "downtime_start_month"
      expr: DATE_TRUNC('MONTH', downtime_start_timestamp)
      comment: "Month the downtime event started, used for monthly reliability trend analysis."
    - name: "weather_condition"
      expr: weather_condition
      comment: "Weather conditions at time of downtime. Used to separate weather-induced downtime from mechanical/operational failures."
  measures:
    - name: "total_downtime_events"
      expr: COUNT(1)
      comment: "Total number of downtime events recorded. Baseline reliability event frequency KPI."
    - name: "total_downtime_hours"
      expr: SUM(CAST(downtime_duration_hours AS DOUBLE))
      comment: "Total asset downtime hours across all events. The primary availability loss KPI — directly linked to terminal throughput capacity and revenue impact."
    - name: "avg_downtime_duration_hours"
      expr: AVG(CAST(downtime_duration_hours AS DOUBLE))
      comment: "Average duration per downtime event in hours. Equivalent to MTTR at the event level — a key reliability benchmark for world-class terminal operations."
    - name: "total_maintenance_cost"
      expr: SUM(CAST(maintenance_cost_amount AS DOUBLE))
      comment: "Total maintenance cost associated with downtime events. Used to quantify the financial impact of asset failures and justify preventive maintenance investment."
    - name: "sla_breach_count"
      expr: COUNT(CASE WHEN sla_breach_flag = TRUE THEN 1 END)
      comment: "Number of downtime events that breached SLA response or resolution time. Drives SLA penalty calculations and contractor performance reviews."
    - name: "sla_breach_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN sla_breach_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of downtime events that breached SLA. A critical KPI for maintenance contract governance — target below 5% for tier-1 port operators."
    - name: "safety_related_downtime_hours"
      expr: SUM(CAST(CASE WHEN is_safety_related = TRUE THEN downtime_duration_hours ELSE 0 END AS INT))
      comment: "Total downtime hours attributable to safety-related events. Mandatory HSE reporting metric and input to safety risk assessments."
    - name: "safety_related_downtime_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_safety_related = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of downtime events that are safety-related. Elevated rates trigger HSE investigations and regulatory notifications under SOLAS/MARPOL frameworks."
    - name: "regulatory_reportable_downtime_count"
      expr: COUNT(CASE WHEN is_regulatory_reportable = TRUE THEN 1 END)
      comment: "Number of downtime events requiring regulatory reporting. Tracks compliance exposure and mandatory notification obligations to port authorities."
    - name: "avg_maintenance_cost_per_event"
      expr: AVG(CAST(maintenance_cost_amount AS DOUBLE))
      comment: "Average maintenance cost per downtime event. Used to benchmark repair cost efficiency and identify high-cost failure modes for targeted investment."
$$;

CREATE OR REPLACE VIEW `vibe_shipping_ports_v1`.`_metrics`.`asset_depreciation_schedule`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Financial KPI view over asset depreciation schedules. Tracks net book value, accumulated depreciation, impairment, and revaluation across the asset fleet. Used by CFOs, finance controllers, and asset managers for IFRS-compliant financial reporting, impairment testing, and capital replacement planning."
  source: "`vibe_shipping_ports_v1`.`asset`.`depreciation_schedule`"
  dimensions:
    - name: "depreciation_method"
      expr: depreciation_method
      comment: "Depreciation method applied (Straight-Line, Declining Balance, Units of Production) for financial reporting segmentation."
    - name: "depreciation_status"
      expr: depreciation_status
      comment: "Current status of the depreciation schedule (Active, Completed, Suspended) for portfolio management."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the depreciation run for annual financial reporting and budget comparison."
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period (month) of the depreciation run for period-end close and management reporting."
    - name: "valuation_type"
      expr: valuation_type
      comment: "Valuation type applied (Historical Cost, Fair Value, Revalued Amount) for IFRS disclosure segmentation."
    - name: "impairment_indicator"
      expr: impairment_indicator
      comment: "Indicates whether an impairment indicator has been triggered for the asset (True/False). Drives mandatory impairment testing under IAS 36."
    - name: "depreciation_area"
      expr: depreciation_area
      comment: "Depreciation area (Book, Tax, IFRS) for multi-ledger financial reporting."
  measures:
    - name: "total_net_book_value"
      expr: SUM(CAST(net_book_value AS DOUBLE))
      comment: "Total net book value of all assets on depreciation schedules. Primary balance sheet asset value KPI for financial reporting."
    - name: "total_accumulated_depreciation"
      expr: SUM(CAST(accumulated_depreciation AS DOUBLE))
      comment: "Total accumulated depreciation across the asset fleet. Indicates the degree of fleet aging and remaining economic life."
    - name: "total_period_depreciation"
      expr: SUM(CAST(period_depreciation_amount AS DOUBLE))
      comment: "Total depreciation charge for the current period. P&L impact metric used in period-end financial close and budget variance analysis."
    - name: "total_annual_depreciation"
      expr: SUM(CAST(annual_depreciation_amount AS DOUBLE))
      comment: "Total annual depreciation charge across the fleet. Used in annual budget planning and CAPEX replacement forecasting."
    - name: "total_impairment_loss"
      expr: SUM(CAST(impairment_loss AS DOUBLE))
      comment: "Total impairment losses recognised across the asset fleet. A critical IFRS (IAS 36) disclosure metric — material impairments require board-level approval and external audit scrutiny."
    - name: "total_revaluation_surplus"
      expr: SUM(CAST(revaluation_surplus AS DOUBLE))
      comment: "Total revaluation surplus recognised in other comprehensive income. Tracks the upward revaluation of port infrastructure assets under the revaluation model."
    - name: "avg_net_book_value"
      expr: AVG(CAST(net_book_value AS DOUBLE))
      comment: "Average net book value per asset schedule. Used to benchmark asset value retention across equipment classes."
    - name: "depreciation_coverage_ratio"
      expr: ROUND(100.0 * SUM(CAST(accumulated_depreciation AS DOUBLE)) / NULLIF(SUM(CAST(acquisition_cost AS DOUBLE)), 0), 2)
      comment: "Ratio of accumulated depreciation to original acquisition cost as a percentage. Indicates average fleet age-in-depreciation — values above 70% signal imminent fleet replacement need and capital planning urgency."
    - name: "impaired_assets_count"
      expr: COUNT(CASE WHEN impairment_indicator = TRUE THEN 1 END)
      comment: "Number of assets with an active impairment indicator. Drives mandatory IAS 36 impairment testing and potential write-down disclosures."
    - name: "total_asset_retirement_obligation"
      expr: SUM(CAST(asset_retirement_obligation AS DOUBLE))
      comment: "Total asset retirement obligation (ARO) provisioned across the fleet. Required IFRS disclosure for decommissioning liabilities on port infrastructure and equipment."
$$;

CREATE OR REPLACE VIEW `vibe_shipping_ports_v1`.`_metrics`.`asset_failure_report`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Asset reliability and failure analysis KPI view. Tracks failure frequency, severity, root causes, repair costs, and warranty recovery. Used by reliability engineers, maintenance managers, and operations directors to drive predictive maintenance investment, OEM warranty claims, and fleet reliability improvement programmes."
  source: "`vibe_shipping_ports_v1`.`asset`.`failure_report`"
  dimensions:
    - name: "failure_class"
      expr: failure_class
      comment: "Classification of the failure (Mechanical, Electrical, Structural, Hydraulic, Software) for failure mode analysis."
    - name: "failure_mode"
      expr: failure_mode
      comment: "Specific failure mode (Wear, Fatigue, Corrosion, Overload, Human Error) for root cause and FMEA analysis."
    - name: "failure_severity"
      expr: failure_severity
      comment: "Severity of the failure (Critical, Major, Minor) for risk prioritisation and escalation management."
    - name: "root_cause"
      expr: root_cause
      comment: "Root cause of the failure for systemic improvement targeting and preventive action planning."
    - name: "report_status"
      expr: report_status
      comment: "Current status of the failure report (Open, Under Investigation, Closed, Warranty Claimed) for pipeline management."
    - name: "failure_recurrence_flag"
      expr: failure_recurrence_flag
      comment: "Indicates whether this is a recurring failure on the same asset (True/False). Recurring failures signal systemic issues requiring design or process changes."
    - name: "warranty_claim_eligible_flag"
      expr: warranty_claim_eligible_flag
      comment: "Indicates whether the failure is eligible for a warranty claim (True/False). Drives OEM warranty recovery actions."
    - name: "failure_month"
      expr: DATE_TRUNC('MONTH', failure_datetime)
      comment: "Month of the failure event for trend analysis and seasonal reliability pattern identification."
  measures:
    - name: "total_failure_reports"
      expr: COUNT(1)
      comment: "Total number of failure reports. Baseline failure frequency KPI for fleet reliability benchmarking."
    - name: "total_downtime_hours"
      expr: SUM(CAST(downtime_hours AS DOUBLE))
      comment: "Total downtime hours caused by reported failures. Directly quantifies the throughput and revenue impact of asset failures."
    - name: "total_estimated_repair_cost"
      expr: SUM(CAST(estimated_repair_cost AS DOUBLE))
      comment: "Total estimated repair cost across all failure reports. Used for maintenance budget forecasting and insurance claim sizing."
    - name: "avg_downtime_per_failure_hours"
      expr: AVG(CAST(downtime_hours AS DOUBLE))
      comment: "Average downtime hours per failure event. Equivalent to MTTR at the failure level — a key reliability benchmark for world-class terminal operations."
    - name: "avg_operating_hours_at_failure"
      expr: AVG(CAST(operating_hours_at_failure AS DOUBLE))
      comment: "Average cumulative operating hours at time of failure. Used to calibrate preventive maintenance intervals and predict remaining useful life."
    - name: "recurring_failure_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN failure_recurrence_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of failures that are recurrences on the same asset. A high recurrence rate signals inadequate root cause resolution — target below 10% for world-class reliability programmes."
    - name: "warranty_eligible_failure_count"
      expr: COUNT(CASE WHEN warranty_claim_eligible_flag = TRUE THEN 1 END)
      comment: "Number of failures eligible for warranty claims. Tracks warranty recovery opportunity value and OEM accountability."
    - name: "safety_incident_failure_count"
      expr: COUNT(CASE WHEN safety_incident_flag = TRUE THEN 1 END)
      comment: "Number of failures that resulted in a safety incident. Mandatory HSE KPI — safety-related failures trigger RIDDOR/SOLAS reporting obligations."
    - name: "swl_exceeded_failure_count"
      expr: COUNT(CASE WHEN swl_exceeded_flag = TRUE THEN 1 END)
      comment: "Number of failures where the Safe Working Load was exceeded at time of failure. Critical safety compliance KPI — SWL exceedances require immediate regulatory notification and equipment grounding."
    - name: "avg_load_at_failure_tonnes"
      expr: AVG(CAST(load_at_failure_tonnes AS DOUBLE))
      comment: "Average load on the asset at time of failure in tonnes. Used to assess whether assets are being operated within design parameters."
$$;

CREATE OR REPLACE VIEW `vibe_shipping_ports_v1`.`_metrics`.`asset_inspection_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Asset inspection compliance and quality KPI view. Tracks inspection outcomes, defect rates, compliance status, and certification health across all port assets. Used by HSE managers, compliance officers, and port authority liaisons to ensure regulatory compliance, manage certification risk, and drive corrective action closure."
  source: "`vibe_shipping_ports_v1`.`asset`.`inspection_record`"
  dimensions:
    - name: "inspection_type"
      expr: inspection_type
      comment: "Type of inspection (Statutory, Preventive, Condition Survey, Load Test, ISPS) for compliance category analysis."
    - name: "inspection_outcome"
      expr: inspection_outcome
      comment: "Outcome of the inspection (Pass, Fail, Conditional Pass, Deferred) for compliance status tracking."
    - name: "inspection_status"
      expr: inspection_status
      comment: "Current status of the inspection record (Scheduled, In Progress, Completed, Overdue) for pipeline management."
    - name: "compliance_status"
      expr: compliance_status
      comment: "Compliance status resulting from the inspection (Compliant, Non-Compliant, Partially Compliant) for regulatory reporting."
    - name: "defect_severity_highest"
      expr: defect_severity_highest
      comment: "Highest severity defect identified during the inspection (Critical, Major, Minor, None) for risk prioritisation."
    - name: "inspection_month"
      expr: DATE_TRUNC('MONTH', inspection_date)
      comment: "Month of the inspection for trend analysis and compliance calendar management."
    - name: "load_test_performed"
      expr: load_test_performed
      comment: "Indicates whether a load test was performed during the inspection (True/False). Load tests are mandatory for SWL certification renewals."
  measures:
    - name: "total_inspections"
      expr: COUNT(1)
      comment: "Total number of inspection records. Baseline inspection activity volume KPI for compliance programme management."
    - name: "total_inspection_cost"
      expr: SUM(CAST(inspection_cost AS DOUBLE))
      comment: "Total cost of all inspections. Used to manage inspection programme budget and benchmark against industry norms."
    - name: "avg_inspection_cost"
      expr: AVG(CAST(inspection_cost AS DOUBLE))
      comment: "Average cost per inspection. Used to benchmark inspection efficiency and evaluate third-party inspector value."
    - name: "pass_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN inspection_outcome = 'Pass' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of inspections resulting in a pass outcome. Primary asset compliance health KPI — a declining pass rate signals deteriorating fleet condition requiring urgent maintenance investment."
    - name: "non_compliant_inspection_count"
      expr: COUNT(CASE WHEN compliance_status = 'Non-Compliant' THEN 1 END)
      comment: "Number of inspections resulting in a non-compliant finding. Drives regulatory notification, corrective action plans, and potential asset grounding decisions."
    - name: "avg_defects_per_inspection"
      expr: AVG(CAST(defects_identified_count AS DOUBLE))
      comment: "Average number of defects identified per inspection. A rising trend indicates fleet condition deterioration and signals need for increased maintenance frequency."
    - name: "avg_critical_defects_per_inspection"
      expr: AVG(CAST(critical_defects_count AS DOUBLE))
      comment: "Average number of critical defects per inspection. Critical defects require immediate corrective action and may trigger asset grounding under port authority regulations."
    - name: "overdue_corrective_action_count"
      expr: COUNT(CASE WHEN corrective_action_deadline < CURRENT_DATE() AND corrective_actions_required IS NOT NULL THEN 1 END)
      comment: "Number of inspections with overdue corrective actions. A critical compliance KPI — overdue corrective actions expose the port to regulatory sanctions and liability."
    - name: "avg_swl_rating_verified_tonnes"
      expr: AVG(CAST(swl_rating_verified AS DOUBLE))
      comment: "Average verified Safe Working Load rating across inspected assets in tonnes. Used to confirm fleet SWL compliance and identify assets requiring SWL downgrade."
$$;

CREATE OR REPLACE VIEW `vibe_shipping_ports_v1`.`_metrics`.`asset_swl_certificate`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Safe Working Load (SWL) certification compliance KPI view. Tracks certificate validity, expiry risk, and test outcomes across all lifting and handling equipment. Used by HSE managers, port authority liaisons, and operations directors to ensure zero-tolerance SWL compliance — expired SWL certificates ground equipment and halt terminal operations."
  source: "`vibe_shipping_ports_v1`.`asset`.`swl_certificate`"
  dimensions:
    - name: "certificate_status"
      expr: certificate_status
      comment: "Current status of the SWL certificate (Valid, Expired, Suspended, Revoked) for compliance portfolio management."
    - name: "equipment_type"
      expr: equipment_type
      comment: "Type of equipment covered by the SWL certificate (Crane, Spreader, Sling, Shackle, RTG) for equipment-class compliance analysis."
    - name: "issuing_authority"
      expr: issuing_authority
      comment: "Authority that issued the SWL certificate (Classification Society, Port Authority, Notified Body) for regulatory source tracking."
    - name: "applicable_standard"
      expr: applicable_standard
      comment: "Standard under which the SWL certificate was issued (BS EN 13001, LOLER, ASME B30) for regulatory framework analysis."
    - name: "compliance_flag"
      expr: compliance_flag
      comment: "Indicates whether the asset is currently SWL-compliant (True/False). Non-compliant assets must be immediately grounded."
    - name: "expiry_year"
      expr: YEAR(expiry_date)
      comment: "Year the SWL certificate expires, used for renewal planning and budget forecasting."
  measures:
    - name: "total_swl_certificates"
      expr: COUNT(1)
      comment: "Total number of SWL certificates in the registry. Baseline compliance portfolio size KPI."
    - name: "expired_certificates_count"
      expr: COUNT(CASE WHEN expiry_date < CURRENT_DATE() THEN 1 END)
      comment: "Number of SWL certificates that have expired. Zero-tolerance KPI — any expired SWL certificate requires immediate equipment grounding and regulatory notification."
    - name: "expiring_within_30_days_count"
      expr: COUNT(CASE WHEN expiry_date BETWEEN CURRENT_DATE() AND DATE_ADD(CURRENT_DATE(), 30) THEN 1 END)
      comment: "Number of SWL certificates expiring within the next 30 days. Proactive compliance KPI driving renewal scheduling and inspection booking."
    - name: "non_compliant_certificate_count"
      expr: COUNT(CASE WHEN compliance_flag = FALSE THEN 1 END)
      comment: "Number of assets with a non-compliant SWL certificate status. Drives immediate corrective action and regulatory reporting obligations."
    - name: "compliance_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN compliance_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of SWL certificates currently compliant. Target is 100% — any value below 100% represents an active safety and regulatory risk requiring immediate escalation."
    - name: "avg_swl_rating_tonnes"
      expr: AVG(CAST(swl_rating_tonnes AS DOUBLE))
      comment: "Average certified Safe Working Load rating across all certificated equipment in tonnes. Used to assess fleet lifting capacity and identify capacity gaps."
    - name: "avg_test_load_tonnes"
      expr: AVG(CAST(test_load_tonnes AS DOUBLE))
      comment: "Average proof load applied during SWL testing in tonnes. Used to verify that test loads meet the required 1.25x SWL proof load standard."
    - name: "total_swl_capacity_tonnes"
      expr: SUM(CAST(swl_rating_tonnes AS DOUBLE))
      comment: "Total certified SWL capacity across all compliant equipment in tonnes. Represents the aggregate safe lifting capacity of the port fleet."
$$;

CREATE OR REPLACE VIEW `vibe_shipping_ports_v1`.`_metrics`.`asset_spare_part`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Spare parts inventory and supply chain KPI view. Tracks stock levels, reorder risk, inventory value, and obsolescence across the maintenance spare parts pool. Used by maintenance planners, procurement managers, and supply chain directors to prevent stockouts on critical parts, optimise inventory investment, and manage obsolescence risk."
  source: "`vibe_shipping_ports_v1`.`asset`.`spare_part`"
  dimensions:
    - name: "part_category"
      expr: part_category
      comment: "Category of spare part (Mechanical, Electrical, Hydraulic, Structural, Consumable) for inventory segmentation."
    - name: "abc_classification"
      expr: abc_classification
      comment: "ABC inventory classification (A=high value/critical, B=medium, C=low) for inventory management prioritisation."
    - name: "criticality_classification"
      expr: criticality_classification
      comment: "Criticality classification of the spare part (Critical, Essential, Desirable) for stockout risk management."
    - name: "obsolescence_status"
      expr: obsolescence_status
      comment: "Obsolescence status of the spare part (Active, Obsolete, Phase-Out, Superseded) for inventory rationalisation."
    - name: "spare_part_status"
      expr: spare_part_status
      comment: "Current stock status of the spare part (In Stock, Out of Stock, On Order, Reserved) for availability management."
    - name: "hazardous_material_flag"
      expr: hazardous_material_flag
      comment: "Indicates whether the spare part is a hazardous material (True/False). Hazardous parts require IMDG-compliant storage and handling."
  measures:
    - name: "total_spare_parts"
      expr: COUNT(1)
      comment: "Total number of distinct spare part records in the inventory. Baseline inventory portfolio size KPI."
    - name: "total_stock_value"
      expr: SUM(CAST(total_stock_value AS DOUBLE))
      comment: "Total value of spare parts inventory on hand. Primary working capital KPI for maintenance inventory — used to optimise inventory investment and reduce carrying costs."
    - name: "total_quantity_on_hand"
      expr: SUM(CAST(quantity_on_hand AS DOUBLE))
      comment: "Total quantity of spare parts currently in stock across all part numbers. Used for inventory coverage analysis."
    - name: "total_quantity_on_order"
      expr: SUM(CAST(quantity_on_order AS DOUBLE))
      comment: "Total quantity of spare parts currently on order from suppliers. Used to assess replenishment pipeline and expected stock recovery."
    - name: "total_quantity_reserved"
      expr: SUM(CAST(quantity_reserved AS DOUBLE))
      comment: "Total quantity of spare parts reserved for planned work orders. Used to assess available-to-promise stock for unplanned maintenance."
    - name: "below_reorder_point_count"
      expr: COUNT(CASE WHEN quantity_on_hand <= reorder_point THEN 1 END)
      comment: "Number of spare parts at or below their reorder point. Critical supply chain KPI — parts below reorder point risk stockout on critical equipment, potentially halting terminal operations."
    - name: "stockout_count"
      expr: COUNT(CASE WHEN quantity_on_hand = 0 THEN 1 END)
      comment: "Number of spare parts with zero stock on hand. Zero-tolerance KPI for critical parts — stockouts on A-class critical parts can ground equipment and halt terminal throughput."
    - name: "avg_unit_cost"
      expr: AVG(CAST(unit_cost AS DOUBLE))
      comment: "Average unit cost per spare part. Used to benchmark procurement pricing and identify cost reduction opportunities."
    - name: "obsolete_parts_count"
      expr: COUNT(CASE WHEN obsolescence_status = 'Obsolete' THEN 1 END)
      comment: "Number of spare parts classified as obsolete. Drives inventory write-off decisions and procurement of modern replacements."
    - name: "inventory_turnover_rate"
      expr: ROUND(SUM(CAST(annual_usage_quantity AS DOUBLE)) / NULLIF(SUM(CAST(quantity_on_hand AS DOUBLE)), 0), 2)
      comment: "Ratio of annual usage quantity to current stock on hand. Measures how efficiently spare parts inventory is consumed — low turnover on non-critical parts indicates over-stocking and excess working capital tied up."
$$;

CREATE OR REPLACE VIEW `vibe_shipping_ports_v1`.`_metrics`.`asset_acquisition`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Capital acquisition and CAPEX KPI view. Tracks asset acquisition costs, commissioning timelines, warranty coverage, and SWL certification for newly acquired port assets. Used by CFOs, asset managers, and procurement directors to govern CAPEX spend, monitor commissioning milestones, and ensure new assets enter service compliant and on budget."
  source: "`vibe_shipping_ports_v1`.`asset`.`acquisition`"
  dimensions:
    - name: "asset_class_code"
      expr: asset_class_code
      comment: "Asset class of the acquired asset (Crane, RTG, Tractor, Infrastructure) for CAPEX portfolio segmentation."
    - name: "depreciation_method"
      expr: depreciation_method
      comment: "Depreciation method assigned at acquisition for financial reporting classification."
    - name: "funding_source"
      expr: funding_source
      comment: "Source of funding for the acquisition (Own Funds, Loan, Lease, Grant) for capital structure analysis."
    - name: "handover_acceptance_status"
      expr: handover_acceptance_status
      comment: "Status of the handover acceptance process (Accepted, Pending, Rejected, Conditional) for commissioning pipeline management."
    - name: "acquisition_year"
      expr: YEAR(acquisition_date)
      comment: "Year of asset acquisition for CAPEX trend analysis and fleet renewal planning."
  measures:
    - name: "total_acquisitions"
      expr: COUNT(1)
      comment: "Total number of asset acquisitions. Baseline CAPEX activity volume KPI."
    - name: "total_acquisition_cost"
      expr: SUM(CAST(cost AS DOUBLE))
      comment: "Total CAPEX spend on asset acquisitions. Primary capital investment KPI for board-level CAPEX governance and budget control."
    - name: "total_insurance_coverage"
      expr: SUM(CAST(insurance_coverage_amount AS DOUBLE))
      comment: "Total insurance coverage value across all acquired assets. Used to assess insurance adequacy relative to fleet replacement value."
    - name: "total_residual_value"
      expr: SUM(CAST(residual_value AS DOUBLE))
      comment: "Total estimated residual value of acquired assets at end of useful life. Used in depreciation planning and disposal strategy."
    - name: "avg_acquisition_cost"
      expr: AVG(CAST(cost AS DOUBLE))
      comment: "Average acquisition cost per asset. Used to benchmark procurement pricing and evaluate vendor competitiveness."
    - name: "avg_swl_rating_tonnes"
      expr: AVG(CAST(swl_rating_tonnes AS DOUBLE))
      comment: "Average Safe Working Load rating of newly acquired assets in tonnes. Used to assess whether new acquisitions meet operational capacity requirements."
    - name: "pending_handover_count"
      expr: COUNT(CASE WHEN handover_acceptance_status = 'Pending' THEN 1 END)
      comment: "Number of acquisitions with pending handover acceptance. Tracks commissioning pipeline risk — delayed handovers defer asset availability and impact terminal capacity plans."
    - name: "warranty_active_count"
      expr: COUNT(CASE WHEN warranty_end_date >= CURRENT_DATE() THEN 1 END)
      comment: "Number of acquired assets currently under active warranty. Tracks warranty coverage portfolio — assets under warranty should have repair costs recovered from vendors rather than expensed."
$$;

CREATE OR REPLACE VIEW `vibe_shipping_ports_v1`.`_metrics`.`asset_maintenance_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Preventive maintenance planning KPI view. Tracks maintenance plan coverage, cost estimates, schedule adherence, and compliance requirements across the asset fleet. Used by maintenance managers and operations directors to ensure preventive maintenance programmes are adequately resourced, scheduled, and compliant with regulatory requirements."
  source: "`vibe_shipping_ports_v1`.`asset`.`maintenance_plan`"
  dimensions:
    - name: "plan_type"
      expr: plan_type
      comment: "Type of maintenance plan (Preventive, Predictive, Condition-Based, Statutory) for maintenance strategy analysis."
    - name: "plan_status"
      expr: plan_status
      comment: "Current status of the maintenance plan (Active, Inactive, Draft, Expired) for plan portfolio management."
    - name: "priority"
      expr: priority
      comment: "Priority of the maintenance plan (Critical, High, Medium, Low) for resource allocation."
    - name: "maintenance_frequency_unit"
      expr: maintenance_frequency_unit
      comment: "Unit of maintenance frequency (Days, Hours, Cycles, Months) for schedule analysis."
    - name: "responsible_department"
      expr: responsible_department
      comment: "Department responsible for executing the maintenance plan for workload distribution analysis."
    - name: "auto_generate_work_order"
      expr: auto_generate_work_order
      comment: "Indicates whether work orders are automatically generated from this plan (True/False). Tracks automation coverage of the preventive maintenance programme."
    - name: "compliance_certificate_required"
      expr: compliance_certificate_required
      comment: "Indicates whether a compliance certificate is required upon plan completion (True/False). Tracks regulatory maintenance obligations."
  measures:
    - name: "total_maintenance_plans"
      expr: COUNT(1)
      comment: "Total number of active maintenance plans. Baseline preventive maintenance programme coverage KPI."
    - name: "total_estimated_cost"
      expr: SUM(CAST(estimated_cost AS DOUBLE))
      comment: "Total estimated cost of all maintenance plans. Primary preventive maintenance budget KPI for annual planning and resource allocation."
    - name: "total_estimated_labour_hours"
      expr: SUM(CAST(estimated_labor_hours AS DOUBLE))
      comment: "Total estimated labour hours across all maintenance plans. Used for workforce capacity planning in maintenance operations."
    - name: "total_estimated_downtime_hours"
      expr: SUM(CAST(estimated_downtime_hours AS DOUBLE))
      comment: "Total estimated downtime hours from planned maintenance. Used to schedule maintenance windows and minimise operational impact on terminal throughput."
    - name: "avg_estimated_cost_per_plan"
      expr: AVG(CAST(estimated_cost AS DOUBLE))
      comment: "Average estimated cost per maintenance plan. Used to benchmark maintenance plan complexity and cost efficiency."
    - name: "overdue_plans_count"
      expr: COUNT(CASE WHEN next_due_date < CURRENT_DATE() AND plan_status = 'Active' THEN 1 END)
      comment: "Number of active maintenance plans past their next due date. A critical compliance and reliability KPI — overdue preventive maintenance increases failure risk and may breach regulatory requirements."
    - name: "compliance_required_plans_count"
      expr: COUNT(CASE WHEN compliance_certificate_required = TRUE THEN 1 END)
      comment: "Number of maintenance plans requiring a compliance certificate upon completion. Tracks the regulatory maintenance obligation portfolio for the asset fleet."
    - name: "automated_plan_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN auto_generate_work_order = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of maintenance plans with automatic work order generation enabled. Higher automation rates reduce manual scheduling effort and improve PM schedule adherence."
$$;