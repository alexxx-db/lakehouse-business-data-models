-- Metric views for domain: asset | Business: Automotive | Version: 2 | Generated on: 2026-07-14 01:46:32

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`asset_equipment_downtime`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Equipment downtime KPIs tracking unplanned stops, OEE impact, and maintenance effectiveness across production assets"
  source: "`vibe_automotive_v1`.`asset`.`equipment_downtime`"
  dimensions:
    - name: "downtime_category"
      expr: downtime_category
      comment: "Category of downtime event (mechanical, electrical, tooling, etc.)"
    - name: "downtime_reason_group"
      expr: downtime_reason_group
      comment: "High-level grouping of downtime reasons for executive reporting"
    - name: "root_cause_code"
      expr: root_cause_code
      comment: "Standardized root cause code for downtime analysis"
    - name: "maintenance_type"
      expr: maintenance_type
      comment: "Type of maintenance required (corrective, preventive, emergency)"
    - name: "is_critical"
      expr: is_critical
      comment: "Flag indicating whether downtime event was critical to production"
    - name: "scheduled_maintenance_flag"
      expr: scheduled_maintenance_flag
      comment: "Indicates whether downtime was planned maintenance vs unplanned failure"
    - name: "shift"
      expr: shift
      comment: "Production shift during which downtime occurred"
    - name: "downtime_month"
      expr: DATE_TRUNC('MONTH', start_timestamp)
      comment: "Month of downtime event for trend analysis"
    - name: "downtime_week"
      expr: DATE_TRUNC('WEEK', start_timestamp)
      comment: "Week of downtime event for operational tracking"
  measures:
    - name: "Total Downtime Events"
      expr: COUNT(1)
      comment: "Total number of equipment downtime events recorded"
    - name: "Total Downtime Minutes"
      expr: SUM(CAST(duration_minutes AS DOUBLE))
      comment: "Total minutes of equipment downtime across all events"
    - name: "Total Downtime Cost"
      expr: SUM(CAST(cost_of_downtime AS DOUBLE))
      comment: "Total financial cost of downtime events in local currency"
    - name: "Total Lost Units"
      expr: SUM(CAST(lost_units AS DOUBLE))
      comment: "Total production units lost due to equipment downtime"
    - name: "Avg Downtime Minutes Per Event"
      expr: AVG(CAST(duration_minutes AS DOUBLE))
      comment: "Average duration of downtime events in minutes"
    - name: "Avg OEE Impact Percent"
      expr: AVG(CAST(oee_impact_percentage AS DOUBLE))
      comment: "Average percentage impact on Overall Equipment Effectiveness per downtime event"
    - name: "Critical Downtime Events"
      expr: SUM(CAST(CASE WHEN is_critical = TRUE THEN 1 ELSE 0 END AS INT))
      comment: "Count of downtime events flagged as critical to production"
    - name: "Unplanned Downtime Events"
      expr: SUM(CAST(CASE WHEN scheduled_maintenance_flag = FALSE THEN 1 ELSE 0 END AS INT))
      comment: "Count of unplanned downtime events (excludes scheduled maintenance)"
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`asset_equipment_reliability`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Equipment reliability and OEE metrics tracking MTBF, MTTR, availability, and overall equipment effectiveness"
  source: "`vibe_automotive_v1`.`asset`.`equipment_reliability`"
  dimensions:
    - name: "reliability_category"
      expr: reliability_category
      comment: "Classification of equipment reliability performance (excellent, good, poor, critical)"
    - name: "reliability_status"
      expr: reliability_status
      comment: "Current reliability status of equipment"
    - name: "plant_location"
      expr: plant_location
      comment: "Manufacturing plant location for site-level reliability comparison"
    - name: "reporting_period_month"
      expr: DATE_TRUNC('MONTH', reporting_period_start)
      comment: "Month of reliability reporting period for trend analysis"
    - name: "reporting_period_quarter"
      expr: DATE_TRUNC('QUARTER', reporting_period_start)
      comment: "Quarter of reliability reporting period for executive review"
  measures:
    - name: "Total Reliability Records"
      expr: COUNT(1)
      comment: "Total number of equipment reliability assessment records"
    - name: "Avg MTBF Hours"
      expr: AVG(CAST(mean_time_between_failures_hours AS DOUBLE))
      comment: "Average mean time between failures in hours across equipment population"
    - name: "Avg MTTR Hours"
      expr: AVG(CAST(mean_time_to_repair_hours AS DOUBLE))
      comment: "Average mean time to repair in hours across equipment population"
    - name: "Avg Availability Percent"
      expr: AVG(CAST(availability_percentage AS DOUBLE))
      comment: "Average equipment availability percentage (uptime / total time)"
    - name: "Avg Overall OEE Percent"
      expr: AVG(CAST(overall_oee_percentage AS DOUBLE))
      comment: "Average Overall Equipment Effectiveness percentage (availability x performance x quality)"
    - name: "Avg OEE Availability Percent"
      expr: AVG(CAST(oee_availability_percentage AS DOUBLE))
      comment: "Average OEE availability component percentage"
    - name: "Avg OEE Performance Percent"
      expr: AVG(CAST(oee_performance_percentage AS DOUBLE))
      comment: "Average OEE performance component percentage"
    - name: "Avg OEE Quality Percent"
      expr: AVG(CAST(oee_quality_percentage AS DOUBLE))
      comment: "Average OEE quality component percentage"
    - name: "Total Failures"
      expr: SUM(CAST(number_of_failures AS DOUBLE))
      comment: "Total number of equipment failures recorded across all reliability assessments"
    - name: "Total Downtime Minutes"
      expr: SUM(CAST(total_downtime_minutes AS DOUBLE))
      comment: "Total equipment downtime in minutes across all reliability records"
    - name: "Total Uptime Minutes"
      expr: SUM(CAST(total_uptime_minutes AS DOUBLE))
      comment: "Total equipment uptime in minutes across all reliability records"
    - name: "Total Maintenance Cost"
      expr: SUM(CAST(maintenance_cost_amount AS DOUBLE))
      comment: "Total maintenance cost across all equipment reliability assessments"
    - name: "Avg Failure Rate Per Hour"
      expr: AVG(CAST(failure_rate_per_hour AS DOUBLE))
      comment: "Average equipment failure rate per operating hour"
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`asset_maintenance_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Maintenance order execution KPIs tracking cost, labor efficiency, schedule adherence, and emergency response"
  source: "`vibe_automotive_v1`.`asset`.`maintenance_order`"
  dimensions:
    - name: "order_type"
      expr: order_type
      comment: "Type of maintenance order (preventive, corrective, breakdown, inspection)"
    - name: "maintenance_order_status"
      expr: maintenance_order_status
      comment: "Current status of maintenance order (planned, in progress, completed, cancelled)"
    - name: "maintenance_strategy"
      expr: maintenance_strategy
      comment: "Maintenance strategy applied (time-based, condition-based, predictive)"
    - name: "priority"
      expr: priority
      comment: "Priority level of maintenance order (critical, high, medium, low)"
    - name: "is_emergency"
      expr: is_emergency
      comment: "Flag indicating whether maintenance order was emergency response"
    - name: "warranty_claim_flag"
      expr: warranty_claim_flag
      comment: "Indicates whether maintenance is covered under warranty claim"
    - name: "safety_flag"
      expr: safety_flag
      comment: "Indicates whether maintenance order involves safety-critical work"
    - name: "compliance_status"
      expr: compliance_status
      comment: "Regulatory compliance status of maintenance work"
    - name: "order_month"
      expr: DATE_TRUNC('MONTH', planned_start_date)
      comment: "Month of planned maintenance start for trend analysis"
    - name: "order_quarter"
      expr: DATE_TRUNC('QUARTER', planned_start_date)
      comment: "Quarter of planned maintenance start for executive reporting"
  measures:
    - name: "Total Maintenance Orders"
      expr: COUNT(1)
      comment: "Total number of maintenance orders issued"
    - name: "Total Maintenance Cost"
      expr: SUM(CAST(total_cost AS DOUBLE))
      comment: "Total cost of all maintenance orders in local currency"
    - name: "Total Labor Cost Actual"
      expr: SUM(CAST(labor_cost_actual AS DOUBLE))
      comment: "Total actual labor cost across all maintenance orders"
    - name: "Total Material Cost Actual"
      expr: SUM(CAST(material_cost_actual AS DOUBLE))
      comment: "Total actual material cost across all maintenance orders"
    - name: "Total Labor Hours Actual"
      expr: SUM(CAST(labor_hours_actual AS DOUBLE))
      comment: "Total actual labor hours consumed across all maintenance orders"
    - name: "Total Downtime Minutes"
      expr: SUM(CAST(downtime_minutes AS DOUBLE))
      comment: "Total equipment downtime in minutes caused by maintenance activities"
    - name: "Avg MTTR Minutes"
      expr: AVG(CAST(mttr_minutes AS DOUBLE))
      comment: "Average mean time to repair in minutes across maintenance orders"
    - name: "Avg Labor Cost Per Order"
      expr: AVG(CAST(labor_cost_actual AS DOUBLE))
      comment: "Average labor cost per maintenance order"
    - name: "Avg Material Cost Per Order"
      expr: AVG(CAST(material_cost_actual AS DOUBLE))
      comment: "Average material cost per maintenance order"
    - name: "Emergency Maintenance Orders"
      expr: SUM(CAST(CASE WHEN is_emergency = TRUE THEN 1 ELSE 0 END AS INT))
      comment: "Count of emergency maintenance orders requiring immediate response"
    - name: "Warranty Claim Orders"
      expr: SUM(CAST(CASE WHEN warranty_claim_flag = TRUE THEN 1 ELSE 0 END AS INT))
      comment: "Count of maintenance orders covered under warranty claim"
    - name: "Safety Critical Orders"
      expr: SUM(CAST(CASE WHEN safety_flag = TRUE THEN 1 ELSE 0 END AS INT))
      comment: "Count of maintenance orders involving safety-critical work"
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`asset_maintenance_cost`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Maintenance cost breakdown KPIs tracking labor, material, spare parts, and external service costs by cost category"
  source: "`vibe_automotive_v1`.`asset`.`maintenance_cost`"
  dimensions:
    - name: "cost_category"
      expr: cost_category
      comment: "Category of maintenance cost (labor, material, spare parts, external service, consumables)"
    - name: "cost_type"
      expr: cost_type
      comment: "Type of cost (planned, unplanned, emergency, warranty)"
    - name: "maintenance_type"
      expr: maintenance_type
      comment: "Type of maintenance activity (preventive, corrective, breakdown, inspection)"
    - name: "maintenance_status"
      expr: maintenance_status
      comment: "Status of maintenance work (in progress, completed, invoiced, settled)"
    - name: "warranty_flag"
      expr: warranty_flag
      comment: "Indicates whether cost is covered under warranty"
    - name: "settlement_status"
      expr: settlement_status
      comment: "Financial settlement status of maintenance cost"
    - name: "cost_month"
      expr: DATE_TRUNC('MONTH', posting_date)
      comment: "Month of cost posting for financial trend analysis"
    - name: "cost_quarter"
      expr: DATE_TRUNC('QUARTER', posting_date)
      comment: "Quarter of cost posting for executive financial reporting"
  measures:
    - name: "Total Maintenance Cost Records"
      expr: COUNT(1)
      comment: "Total number of maintenance cost line items recorded"
    - name: "Total Maintenance Cost"
      expr: SUM(CAST(total_cost AS DOUBLE))
      comment: "Total maintenance cost across all categories and types"
    - name: "Total Labor Cost"
      expr: SUM(CAST(labor_cost AS DOUBLE))
      comment: "Total labor cost for maintenance activities"
    - name: "Total Material Cost"
      expr: SUM(CAST(material_cost AS DOUBLE))
      comment: "Total material cost for maintenance activities"
    - name: "Total Spare Parts Cost"
      expr: SUM(CAST(spare_parts_cost AS DOUBLE))
      comment: "Total spare parts cost for maintenance activities"
    - name: "Total External Service Cost"
      expr: SUM(CAST(external_service_cost AS DOUBLE))
      comment: "Total cost of external service providers for maintenance"
    - name: "Total Consumables Cost"
      expr: SUM(CAST(consumables_cost AS DOUBLE))
      comment: "Total cost of consumable materials used in maintenance"
    - name: "Total Labor Hours"
      expr: SUM(CAST(labor_hours AS DOUBLE))
      comment: "Total labor hours consumed across all maintenance activities"
    - name: "Avg Labor Rate"
      expr: AVG(CAST(labor_rate AS DOUBLE))
      comment: "Average labor rate per hour for maintenance work"
    - name: "Total Tax Amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount on maintenance costs"
    - name: "Total Discount Amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discount amount applied to maintenance costs"
    - name: "Avg MTBF Hours"
      expr: AVG(CAST(mtbf_hours AS DOUBLE))
      comment: "Average mean time between failures for equipment under maintenance"
    - name: "Avg MTTR Hours"
      expr: AVG(CAST(mttr_hours AS DOUBLE))
      comment: "Average mean time to repair for maintenance activities"
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`asset_equipment_registry`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Equipment asset master KPIs tracking installed base, lifecycle status, maintenance readiness, and capital investment"
  source: "`vibe_automotive_v1`.`asset`.`equipment_registry`"
  dimensions:
    - name: "equipment_category"
      expr: equipment_category
      comment: "Category of equipment (production, tooling, test, facility, IT)"
    - name: "equipment_type"
      expr: equipment_type
      comment: "Type of equipment within category"
    - name: "equipment_registry_status"
      expr: equipment_registry_status
      comment: "Current status of equipment (active, idle, maintenance, decommissioned)"
    - name: "lifecycle_phase"
      expr: lifecycle_phase
      comment: "Lifecycle phase of equipment (installation, operation, end-of-life)"
    - name: "asset_condition"
      expr: asset_condition
      comment: "Physical condition assessment of equipment (excellent, good, fair, poor)"
    - name: "maintenance_strategy"
      expr: maintenance_strategy
      comment: "Maintenance strategy applied to equipment (time-based, condition-based, predictive)"
    - name: "calibration_required_flag"
      expr: calibration_required_flag
      comment: "Indicates whether equipment requires periodic calibration"
    - name: "warranty_status"
      expr: warranty_status
      comment: "Current warranty status of equipment (active, expired, extended)"
    - name: "regulatory_compliance_status"
      expr: regulatory_compliance_status
      comment: "Regulatory compliance status of equipment"
    - name: "safety_certification_status"
      expr: safety_certification_status
      comment: "Safety certification status of equipment"
    - name: "manufacturer"
      expr: manufacturer
      comment: "Equipment manufacturer for vendor analysis"
    - name: "depreciation_method"
      expr: depreciation_method
      comment: "Depreciation method applied to equipment asset"
  measures:
    - name: "Total Equipment Assets"
      expr: COUNT(1)
      comment: "Total number of equipment assets in registry"
    - name: "Total Capital Expenditure"
      expr: SUM(CAST(capital_expenditure_amount AS DOUBLE))
      comment: "Total capital expenditure invested in equipment assets"
    - name: "Total Energy Consumption kWh"
      expr: SUM(CAST(energy_consumption_kwh AS DOUBLE))
      comment: "Total energy consumption in kilowatt-hours across equipment population"
    - name: "Total Power Rating kW"
      expr: SUM(CAST(power_rating_kw AS DOUBLE))
      comment: "Total installed power rating in kilowatts across equipment population"
    - name: "Avg MTBF Hours"
      expr: AVG(CAST(mtbf_hours AS DOUBLE))
      comment: "Average mean time between failures in hours across equipment population"
    - name: "Avg MTTR Hours"
      expr: AVG(CAST(mttr_hours AS DOUBLE))
      comment: "Average mean time to repair in hours across equipment population"
    - name: "Avg Operating Cost Per Hour"
      expr: AVG(CAST(operating_cost_per_hour AS DOUBLE))
      comment: "Average operating cost per hour across equipment population"
    - name: "Total Equipment Weight kg"
      expr: SUM(CAST(weight_kg AS DOUBLE))
      comment: "Total weight in kilograms of equipment population"
    - name: "Calibration Required Assets"
      expr: SUM(CAST(CASE WHEN calibration_required_flag = TRUE THEN 1 ELSE 0 END AS INT))
      comment: "Count of equipment assets requiring periodic calibration"
    - name: "Active Warranty Assets"
      expr: SUM(CAST(CASE WHEN warranty_status = 'active' THEN 1 ELSE 0 END AS INT))
      comment: "Count of equipment assets with active warranty coverage"
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`asset_calibration_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Calibration compliance KPIs tracking calibration frequency, pass rates, and measurement uncertainty for quality-critical equipment"
  source: "`vibe_automotive_v1`.`asset`.`calibration_record`"
  dimensions:
    - name: "calibration_type"
      expr: calibration_type
      comment: "Type of calibration performed (dimensional, electrical, pressure, temperature, etc.)"
    - name: "calibration_record_status"
      expr: calibration_record_status
      comment: "Status of calibration record (scheduled, completed, overdue, failed)"
    - name: "result"
      expr: result
      comment: "Result of calibration (pass, fail, conditional pass)"
    - name: "calibration_method"
      expr: calibration_method
      comment: "Method used for calibration (in-house, external lab, on-site)"
    - name: "calibration_standard"
      expr: calibration_standard
      comment: "Calibration standard or reference used (ISO 17025, NIST, etc.)"
    - name: "laboratory_name"
      expr: laboratory_name
      comment: "Name of calibration laboratory for external calibrations"
    - name: "calibration_month"
      expr: DATE_TRUNC('MONTH', calibration_date)
      comment: "Month of calibration for compliance trend analysis"
    - name: "calibration_quarter"
      expr: DATE_TRUNC('QUARTER', calibration_date)
      comment: "Quarter of calibration for executive compliance reporting"
  measures:
    - name: "Total Calibration Records"
      expr: COUNT(1)
      comment: "Total number of calibration records performed"
    - name: "Total Calibration Cost"
      expr: SUM(CAST(calibration_cost AS DOUBLE))
      comment: "Total cost of calibration activities in local currency"
    - name: "Avg Calibration Cost"
      expr: AVG(CAST(calibration_cost AS DOUBLE))
      comment: "Average cost per calibration activity"
    - name: "Avg Measurement Uncertainty"
      expr: AVG(CAST(measurement_uncertainty AS DOUBLE))
      comment: "Average measurement uncertainty across calibration records"
    - name: "Calibration Pass Count"
      expr: SUM(CAST(CASE WHEN result = 'pass' THEN 1 ELSE 0 END AS INT))
      comment: "Count of calibrations that passed acceptance criteria"
    - name: "Calibration Fail Count"
      expr: SUM(CAST(CASE WHEN result = 'fail' THEN 1 ELSE 0 END AS INT))
      comment: "Count of calibrations that failed acceptance criteria"
    - name: "Unique Equipment Calibrated"
      expr: COUNT(DISTINCT equipment_registry_id)
      comment: "Count of unique equipment assets calibrated"
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`asset_inspection`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Equipment inspection KPIs tracking inspection frequency, non-conformance rates, and compliance with safety and quality standards"
  source: "`vibe_automotive_v1`.`asset`.`inspection`"
  dimensions:
    - name: "inspection_type"
      expr: inspection_type
      comment: "Type of inspection (safety, quality, regulatory, preventive, pre-operational)"
    - name: "inspection_status"
      expr: inspection_status
      comment: "Status of inspection (scheduled, in progress, completed, overdue)"
    - name: "risk_level"
      expr: risk_level
      comment: "Risk level identified during inspection (low, medium, high, critical)"
    - name: "non_conformance_flag"
      expr: non_conformance_flag
      comment: "Indicates whether inspection identified non-conformances"
    - name: "downtime_impact_flag"
      expr: downtime_impact_flag
      comment: "Indicates whether inspection caused production downtime"
    - name: "calibration_required"
      expr: calibration_required
      comment: "Indicates whether inspection identified need for calibration"
    - name: "compliance_standard"
      expr: compliance_standard
      comment: "Compliance standard applied during inspection (ISO, OSHA, IATF, etc.)"
    - name: "safety_certification_status"
      expr: safety_certification_status
      comment: "Safety certification status assessed during inspection"
    - name: "inspection_month"
      expr: DATE_TRUNC('MONTH', inspection_timestamp)
      comment: "Month of inspection for compliance trend analysis"
    - name: "inspection_quarter"
      expr: DATE_TRUNC('QUARTER', inspection_timestamp)
      comment: "Quarter of inspection for executive compliance reporting"
  measures:
    - name: "Total Inspections"
      expr: COUNT(1)
      comment: "Total number of equipment inspections performed"
    - name: "Total Non Conformance Count"
      expr: SUM(CAST(non_conformance_count AS DOUBLE))
      comment: "Total number of non-conformances identified across all inspections"
    - name: "Total Downtime Minutes"
      expr: SUM(CAST(downtime_minutes AS DOUBLE))
      comment: "Total downtime in minutes caused by inspection activities"
    - name: "Avg Duration Minutes"
      expr: AVG(CAST(duration_minutes AS DOUBLE))
      comment: "Average duration of inspection activities in minutes"
    - name: "Inspections With Non Conformance"
      expr: SUM(CAST(CASE WHEN non_conformance_flag = TRUE THEN 1 ELSE 0 END AS INT))
      comment: "Count of inspections that identified non-conformances"
    - name: "Inspections Causing Downtime"
      expr: SUM(CAST(CASE WHEN downtime_impact_flag = TRUE THEN 1 ELSE 0 END AS INT))
      comment: "Count of inspections that caused production downtime"
    - name: "Inspections Requiring Calibration"
      expr: SUM(CAST(CASE WHEN calibration_required = TRUE THEN 1 ELSE 0 END AS INT))
      comment: "Count of inspections that identified need for equipment calibration"
    - name: "Unique Equipment Inspected"
      expr: COUNT(DISTINCT inspection_equipment_registry_id)
      comment: "Count of unique equipment assets inspected"
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`asset_warranty_claim_equipment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Equipment warranty claim KPIs tracking claim volume, settlement rates, repair costs, and supplier quality issues"
  source: "`vibe_automotive_v1`.`asset`.`warranty_claim_equipment`"
  dimensions:
    - name: "claim_status"
      expr: claim_status
      comment: "Status of warranty claim (submitted, under review, approved, rejected, settled)"
    - name: "claim_type"
      expr: claim_type
      comment: "Type of warranty claim (parts, labor, full replacement, goodwill)"
    - name: "defect_category"
      expr: defect_category
      comment: "Category of defect covered by warranty claim"
    - name: "root_cause_code"
      expr: root_cause_code
      comment: "Root cause code for warranty claim defect"
    - name: "repair_decision"
      expr: repair_decision
      comment: "Decision on warranty claim (repair, replace, reject, goodwill)"
    - name: "settlement_status"
      expr: settlement_status
      comment: "Financial settlement status of warranty claim"
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level of warranty claim (critical, high, medium, low)"
    - name: "is_critical"
      expr: is_critical
      comment: "Indicates whether warranty claim is critical to production"
    - name: "claim_month"
      expr: DATE_TRUNC('MONTH', claim_created_timestamp)
      comment: "Month of claim creation for trend analysis"
    - name: "claim_quarter"
      expr: DATE_TRUNC('QUARTER', claim_created_timestamp)
      comment: "Quarter of claim creation for executive reporting"
  measures:
    - name: "Total Warranty Claims"
      expr: COUNT(1)
      comment: "Total number of equipment warranty claims submitted"
    - name: "Total Credit Amount"
      expr: SUM(CAST(credit_amount AS DOUBLE))
      comment: "Total credit amount received from warranty claims in local currency"
    - name: "Total Repair Cost"
      expr: SUM(CAST(total_repair_cost AS DOUBLE))
      comment: "Total cost of repairs covered by warranty claims"
    - name: "Total Downtime Hours"
      expr: SUM(CAST(downtime_hours AS DOUBLE))
      comment: "Total equipment downtime in hours due to warranty claim defects"
    - name: "Avg MTTR Hours"
      expr: AVG(CAST(mttr_hours AS DOUBLE))
      comment: "Average mean time to repair for warranty claim defects"
    - name: "Avg Credit Amount Per Claim"
      expr: AVG(CAST(credit_amount AS DOUBLE))
      comment: "Average credit amount per warranty claim"
    - name: "Avg Repair Cost Per Claim"
      expr: AVG(CAST(total_repair_cost AS DOUBLE))
      comment: "Average repair cost per warranty claim"
    - name: "Critical Warranty Claims"
      expr: SUM(CAST(CASE WHEN is_critical = TRUE THEN 1 ELSE 0 END AS INT))
      comment: "Count of warranty claims flagged as critical to production"
    - name: "Approved Warranty Claims"
      expr: SUM(CAST(CASE WHEN claim_status = 'approved' THEN 1 ELSE 0 END AS INT))
      comment: "Count of warranty claims approved for settlement"
    - name: "Rejected Warranty Claims"
      expr: SUM(CAST(CASE WHEN claim_status = 'rejected' THEN 1 ELSE 0 END AS INT))
      comment: "Count of warranty claims rejected by supplier"
    - name: "Unique Equipment With Claims"
      expr: COUNT(DISTINCT warranty_equipment_registry_id)
      comment: "Count of unique equipment assets with warranty claims"
$$;