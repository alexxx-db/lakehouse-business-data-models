-- Metric views for domain: facility | Business: Healthcare | Version: 2 | Generated on: 2026-07-02 07:21:53

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`facility_bed`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Bed inventory and availability KPIs for capacity management and patient throughput steering."
  source: "`vibe_healthcare_v1`.`facility`.`bed`"
  dimensions:
    - name: "bed_status"
      expr: bed_status
      comment: "Current operational status of the bed (occupied, available, blocked, etc.)."
    - name: "bed_type"
      expr: bed_type
      comment: "Clinical bed type classification."
    - name: "bed_category"
      expr: bed_category
      comment: "Bed category grouping for capacity segmentation."
    - name: "floor_number"
      expr: floor_number
      comment: "Floor number where the bed is located."
    - name: "effective_start_month"
      expr: DATE_TRUNC('MONTH', effective_start_date)
      comment: "Month the bed record became effective, for trend analysis."
  measures:
    - name: "total_beds"
      expr: COUNT(1)
      comment: "Total number of beds in scope; foundational capacity metric."
    - name: "active_beds"
      expr: COUNT(CASE WHEN is_active = TRUE THEN 1 END)
      comment: "Count of active beds available for planning; drives operational capacity."
    - name: "staffed_beds"
      expr: COUNT(CASE WHEN is_staffed = TRUE THEN 1 END)
      comment: "Count of staffed beds; true usable capacity vs licensed capacity."
    - name: "licensed_beds"
      expr: COUNT(CASE WHEN is_licensed = TRUE THEN 1 END)
      comment: "Count of licensed beds; regulatory capacity baseline."
    - name: "isolation_capable_beds"
      expr: COUNT(CASE WHEN is_isolation_capable = TRUE THEN 1 END)
      comment: "Count of isolation-capable beds; critical for infection control surge planning."
    - name: "staffed_bed_ratio_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_staffed = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of beds that are staffed; efficiency indicator for capacity utilization."
    - name: "avg_weight_capacity_lbs"
      expr: AVG(CAST(weight_capacity_lbs AS DOUBLE))
      comment: "Average bed weight capacity; informs bariatric readiness planning."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`facility_capacity_snapshot`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Point-in-time occupancy and surge KPIs for real-time capacity command and ED throughput steering."
  source: "`vibe_healthcare_v1`.`facility`.`capacity_snapshot`"
  dimensions:
    - name: "surge_level"
      expr: surge_level
      comment: "Operational surge level at snapshot time; drives escalation decisions."
    - name: "diversion_status"
      expr: diversion_status
      comment: "Whether the facility is on diversion; critical operational trigger."
    - name: "snapshot_month"
      expr: DATE_TRUNC('MONTH', snapshot_date)
      comment: "Month of the capacity snapshot for trend analysis."
  measures:
    - name: "snapshot_count"
      expr: COUNT(1)
      comment: "Number of capacity snapshots captured; baseline for time-series analysis."
    - name: "avg_occupancy_rate_pct"
      expr: ROUND(AVG(CAST(occupancy_rate AS DOUBLE)), 2)
      comment: "Average occupancy rate; primary capacity-utilization KPI for executives."
    - name: "max_occupancy_rate_pct"
      expr: ROUND(MAX(CAST(occupancy_rate AS DOUBLE)), 2)
      comment: "Peak occupancy rate; identifies capacity stress points requiring intervention."
    - name: "diversion_snapshot_count"
      expr: COUNT(CASE WHEN diversion_status IS NOT NULL AND diversion_status <> 'NONE' THEN 1 END)
      comment: "Number of snapshots in a diversion state; measures access-to-care risk."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`facility_maintenance_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Work order cost, downtime, and throughput KPIs for facilities and biomedical engineering steering."
  source: "`vibe_healthcare_v1`.`facility`.`maintenance_order`"
  dimensions:
    - name: "order_status"
      expr: order_status
      comment: "Status of the maintenance work order."
    - name: "order_type"
      expr: order_type
      comment: "Type of maintenance (preventive, corrective, etc.)."
    - name: "priority_level"
      expr: priority_level
      comment: "Priority of the work order; drives resource allocation."
    - name: "requested_month"
      expr: DATE_TRUNC('MONTH', requested_date)
      comment: "Month the work order was requested for trend analysis."
  measures:
    - name: "work_order_count"
      expr: COUNT(1)
      comment: "Total maintenance work orders; workload baseline."
    - name: "total_maintenance_cost"
      expr: SUM(CAST(total_cost AS DOUBLE))
      comment: "Total maintenance spend; core facilities cost KPI for budget steering."
    - name: "total_labor_cost"
      expr: SUM(CAST(labor_cost AS DOUBLE))
      comment: "Total labor cost across work orders; labor spend management."
    - name: "total_parts_cost"
      expr: SUM(CAST(parts_cost AS DOUBLE))
      comment: "Total parts cost across work orders; supply spend management."
    - name: "total_downtime_hours"
      expr: SUM(CAST(downtime_hours AS DOUBLE))
      comment: "Total equipment downtime hours; operational availability risk indicator."
    - name: "avg_downtime_hours"
      expr: ROUND(AVG(CAST(downtime_hours AS DOUBLE)), 2)
      comment: "Average downtime per work order; efficiency and reliability KPI."
    - name: "avg_cost_per_order"
      expr: ROUND(AVG(CAST(total_cost AS DOUBLE)), 2)
      comment: "Average cost per work order; unit-cost efficiency metric."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`facility_equipment_asset`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Capital equipment valuation and PM-compliance KPIs for asset lifecycle and capital planning steering."
  source: "`vibe_healthcare_v1`.`facility`.`equipment_asset`"
  dimensions:
    - name: "asset_class"
      expr: asset_class
      comment: "Class of the equipment asset."
    - name: "asset_status"
      expr: asset_status
      comment: "Operational status of the asset."
    - name: "risk_category"
      expr: risk_category
      comment: "Risk classification of the asset; drives PM prioritization."
    - name: "manufacturer"
      expr: manufacturer
      comment: "Equipment manufacturer for vendor performance analysis."
  measures:
    - name: "asset_count"
      expr: COUNT(1)
      comment: "Total equipment assets; inventory baseline."
    - name: "total_purchase_cost"
      expr: SUM(CAST(purchase_cost AS DOUBLE))
      comment: "Total capital purchase cost; capital investment KPI."
    - name: "total_book_value"
      expr: SUM(CAST(current_book_value AS DOUBLE))
      comment: "Total current book value; balance-sheet asset valuation."
    - name: "life_support_asset_count"
      expr: COUNT(CASE WHEN is_life_support = TRUE THEN 1 END)
      comment: "Count of life-support assets; high-criticality reliability focus."
    - name: "avg_asset_book_value"
      expr: ROUND(AVG(CAST(current_book_value AS DOUBLE)), 2)
      comment: "Average asset book value; capital efficiency indicator."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`facility_environmental_service_request`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "EVS turnaround and inspection-pass KPIs for bed-turnover throughput and infection-control steering."
  source: "`vibe_healthcare_v1`.`facility`.`environmental_service_request`"
  dimensions:
    - name: "request_status"
      expr: request_status
      comment: "Status of the EVS cleaning request."
    - name: "cleaning_type"
      expr: cleaning_type
      comment: "Type of cleaning performed."
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level of the request; drives turnaround urgency."
    - name: "requested_day"
      expr: DATE_TRUNC('DAY', requested_timestamp)
      comment: "Day the cleaning was requested for throughput trend analysis."
  measures:
    - name: "request_count"
      expr: COUNT(1)
      comment: "Total EVS requests; workload baseline for staffing."
    - name: "avg_turnaround_minutes"
      expr: ROUND(AVG(CAST(turnaround_minutes AS DOUBLE)), 2)
      comment: "Average bed turnaround time; primary throughput KPI impacting patient flow."
    - name: "inspection_passed_count"
      expr: COUNT(CASE WHEN inspection_passed_flag = TRUE THEN 1 END)
      comment: "Count of cleanings passing inspection; infection-control quality metric."
    - name: "inspection_pass_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN inspection_passed_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of cleanings passing inspection; EVS quality-of-service KPI."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`facility_safety_incident`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Safety incident severity and OSHA-recordable KPIs for enterprise risk and regulatory steering."
  source: "`vibe_healthcare_v1`.`facility`.`safety_incident`"
  dimensions:
    - name: "incident_type"
      expr: incident_type
      comment: "Type of safety incident."
    - name: "incident_category"
      expr: incident_category
      comment: "Category grouping of the incident."
    - name: "severity_level"
      expr: severity_level
      comment: "Severity of the incident; drives escalation and prioritization."
    - name: "incident_month"
      expr: DATE_TRUNC('MONTH', incident_date)
      comment: "Month the incident occurred for trend analysis."
  measures:
    - name: "incident_count"
      expr: COUNT(1)
      comment: "Total safety incidents; core enterprise risk KPI."
    - name: "osha_recordable_count"
      expr: COUNT(CASE WHEN osha_recordable_flag = TRUE THEN 1 END)
      comment: "Count of OSHA-recordable incidents; regulatory compliance and worker-safety KPI."
    - name: "regulatory_reportable_count"
      expr: COUNT(CASE WHEN regulatory_reportable_flag = TRUE THEN 1 END)
      comment: "Count of regulatory-reportable incidents; compliance exposure indicator."
    - name: "total_injuries"
      expr: SUM(CAST(injuries_count AS DOUBLE))
      comment: "Total injuries across incidents; harm-severity KPI."
    - name: "osha_recordable_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN osha_recordable_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of incidents that are OSHA-recordable; safety performance trend metric."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`facility_inspection`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Regulatory inspection outcome and findings KPIs for accreditation and compliance readiness steering."
  source: "`vibe_healthcare_v1`.`facility`.`inspection`"
  dimensions:
    - name: "inspection_type"
      expr: inspection_type
      comment: "Type of inspection performed."
    - name: "inspection_category"
      expr: inspection_category
      comment: "Category of the inspection."
    - name: "overall_result"
      expr: overall_result
      comment: "Overall inspection outcome; pass/fail/conditional."
    - name: "performed_month"
      expr: DATE_TRUNC('MONTH', performed_date)
      comment: "Month the inspection was performed for trend analysis."
  measures:
    - name: "inspection_count"
      expr: COUNT(1)
      comment: "Total inspections; compliance activity baseline."
    - name: "total_findings"
      expr: SUM(CAST(findings_count AS DOUBLE))
      comment: "Total findings across inspections; compliance risk exposure."
    - name: "total_critical_findings"
      expr: SUM(CAST(critical_findings_count AS DOUBLE))
      comment: "Total critical findings; highest-priority compliance risk KPI."
    - name: "avg_inspection_score"
      expr: ROUND(AVG(CAST(score AS DOUBLE)), 2)
      comment: "Average inspection score; accreditation readiness performance metric."
    - name: "follow_up_required_count"
      expr: COUNT(CASE WHEN follow_up_required_flag = TRUE THEN 1 END)
      comment: "Count of inspections requiring follow-up; open-risk workload indicator."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`facility_contract`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Vendor contract value and renewal KPIs for procurement and financial commitment steering."
  source: "`vibe_healthcare_v1`.`facility`.`contract`"
  dimensions:
    - name: "contract_type"
      expr: contract_type
      comment: "Type of contract."
    - name: "contract_category"
      expr: contract_category
      comment: "Category grouping of the contract."
    - name: "contract_status"
      expr: contract_status
      comment: "Current status of the contract; active/expired/pending."
    - name: "expiration_month"
      expr: DATE_TRUNC('MONTH', expiration_date)
      comment: "Month the contract expires; renewal-pipeline planning."
  measures:
    - name: "contract_count"
      expr: COUNT(1)
      comment: "Total contracts; commitment portfolio baseline."
    - name: "total_contract_value"
      expr: SUM(CAST(total_value AS DOUBLE))
      comment: "Total contracted value; overall financial commitment KPI."
    - name: "total_annual_value"
      expr: SUM(CAST(annual_value AS DOUBLE))
      comment: "Total annual contract value; recurring spend commitment."
    - name: "auto_renew_count"
      expr: COUNT(CASE WHEN auto_renew_flag = TRUE THEN 1 END)
      comment: "Count of auto-renewing contracts; renewal-risk exposure indicator."
    - name: "avg_contract_value"
      expr: ROUND(AVG(CAST(total_value AS DOUBLE)), 2)
      comment: "Average contract value; procurement sizing metric."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`facility_block_assignment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "OR block-time utilization KPIs for surgical services capacity and revenue steering."
  source: "`vibe_healthcare_v1`.`facility`.`block_assignment`"
  dimensions:
    - name: "block_type"
      expr: block_type
      comment: "Type of OR block allocation."
    - name: "day_of_week"
      expr: day_of_week
      comment: "Day of week the block is scheduled."
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level of the block assignment."
  measures:
    - name: "block_count"
      expr: COUNT(1)
      comment: "Total OR block assignments; scheduling baseline."
    - name: "active_block_count"
      expr: COUNT(CASE WHEN is_active = TRUE THEN 1 END)
      comment: "Count of active blocks; current committed OR capacity."
    - name: "avg_utilization_target_pct"
      expr: ROUND(AVG(CAST(utilization_target_pct AS DOUBLE)), 2)
      comment: "Average block utilization target; surgical throughput and revenue-efficiency KPI."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`facility_pm_schedule`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Preventive maintenance compliance KPIs for equipment reliability and regulatory readiness steering."
  source: "`vibe_healthcare_v1`.`facility`.`pm_schedule`"
  dimensions:
    - name: "schedule_type"
      expr: schedule_type
      comment: "Type of PM schedule."
    - name: "frequency_type"
      expr: frequency_type
      comment: "Frequency basis of the PM schedule."
    - name: "next_due_month"
      expr: DATE_TRUNC('MONTH', next_due_date)
      comment: "Month the next PM is due; compliance planning."
  measures:
    - name: "schedule_count"
      expr: COUNT(1)
      comment: "Total PM schedules; maintenance program baseline."
    - name: "active_schedule_count"
      expr: COUNT(CASE WHEN is_active = TRUE THEN 1 END)
      comment: "Count of active PM schedules; live compliance obligations."
    - name: "regulatory_required_count"
      expr: COUNT(CASE WHEN regulatory_requirement_flag = TRUE THEN 1 END)
      comment: "Count of regulatory-required PM schedules; compliance exposure KPI."
    - name: "avg_estimated_duration_hours"
      expr: ROUND(AVG(CAST(estimated_duration_hours AS DOUBLE)), 2)
      comment: "Average estimated PM duration; labor-planning efficiency metric."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`facility_care_site`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Care site licensure, capacity, and accreditation KPIs for network portfolio steering."
  source: "`vibe_healthcare_v1`.`facility`.`care_site`"
  dimensions:
    - name: "facility_type"
      expr: facility_type
      comment: "Type of care site facility."
    - name: "operational_status"
      expr: operational_status
      comment: "Operational status of the care site."
    - name: "licensure_status"
      expr: licensure_status
      comment: "Licensure status; regulatory standing."
    - name: "trauma_level"
      expr: trauma_level
      comment: "Trauma designation level of the site."
  measures:
    - name: "care_site_count"
      expr: COUNT(1)
      comment: "Total care sites; network footprint baseline."
    - name: "critical_access_count"
      expr: COUNT(CASE WHEN critical_access_hospital = TRUE THEN 1 END)
      comment: "Count of critical access hospitals; reimbursement and rural-access indicator."
    - name: "teaching_site_count"
      expr: COUNT(CASE WHEN teaching_status = TRUE THEN 1 END)
      comment: "Count of teaching sites; academic-mission footprint KPI."
    - name: "emergency_services_site_count"
      expr: COUNT(CASE WHEN emergency_services_available = TRUE THEN 1 END)
      comment: "Count of sites with emergency services; access-to-care coverage metric."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`facility_bed_status_events`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Operational view of bed status changes to monitor utilization and flow"
  source: "`vibe_healthcare_v1`.`facility`.`bed_status_event`"
  dimensions:
    - name: "bed_id"
      expr: bed_id
      comment: "Unique identifier for the bed"
    - name: "care_site_id"
      expr: care_site_id
      comment: "Care site where the bed is located"
    - name: "event_date"
      expr: DATE_TRUNC('day', event_timestamp)
      comment: "Date of the bed status event"
    - name: "new_status_code"
      expr: new_status_code
      comment: "Resulting status code after the event"
  measures:
    - name: "total_status_events"
      expr: COUNT(1)
      comment: "Total number of bed status events recorded"
    - name: "elective_event_count"
      expr: SUM(CASE WHEN is_elective_flag THEN 1 ELSE 0 END)
      comment: "Count of elective bed status events"
    - name: "emergency_event_count"
      expr: SUM(CASE WHEN is_emergency_flag THEN 1 ELSE 0 END)
      comment: "Count of emergency bed status events"
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`facility_bed_occupancy`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tracks bed occupancy trends using periodic capacity snapshots"
  source: "`vibe_healthcare_v1`.`facility`.`capacity_snapshot`"
  dimensions:
    - name: "care_site_id"
      expr: care_site_id
      comment: "Identifier of the care site (hospital/clinic)"
    - name: "snapshot_date"
      expr: DATE_TRUNC('day', snapshot_timestamp)
      comment: "Date of the capacity snapshot"
  measures:
    - name: "snapshot_count"
      expr: COUNT(1)
      comment: "Number of capacity snapshot records"
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`facility_inspection_findings`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Quality and compliance view of inspection findings to drive improvement initiatives"
  source: "`vibe_healthcare_v1`.`facility`.`inspection_finding`"
  dimensions:
    - name: "severity_level"
      expr: severity_level
      comment: "Severity classification of the finding"
    - name: "finding_category"
      expr: finding_category
      comment: "Category of the finding (e.g., safety, clinical)"
  measures:
    - name: "total_findings"
      expr: COUNT(1)
      comment: "Total number of inspection findings recorded"
    - name: "high_severity_findings"
      expr: SUM(CASE WHEN severity_level = 'High' THEN 1 ELSE 0 END)
      comment: "Count of findings classified as high severity"
    - name: "distinct_inspections"
      expr: COUNT(DISTINCT inspection_id)
      comment: "Number of unique inspections that generated findings"
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`facility_maintenance_cost`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Financial view of maintenance activities to support cost control"
  source: "`vibe_healthcare_v1`.`facility`.`maintenance_order`"
  dimensions:
    - name: "care_site_id"
      expr: care_site_id
      comment: "Care site where maintenance was performed"
    - name: "order_month"
      expr: DATE_TRUNC('month', created_timestamp)
      comment: "Month of the maintenance order creation"
    - name: "order_status"
      expr: order_status
      comment: "Current status of the maintenance order"
  measures:
    - name: "total_maintenance_cost"
      expr: SUM(CAST(total_cost AS DOUBLE))
      comment: "Total cost incurred for maintenance orders"
    - name: "avg_maintenance_cost"
      expr: AVG(CAST(total_cost AS DOUBLE))
      comment: "Average cost per maintenance order"
    - name: "maintenance_order_count"
      expr: COUNT(1)
      comment: "Number of maintenance orders"
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`facility_safety_incidents`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Safety performance view to monitor incident trends and financial impact"
  source: "`vibe_healthcare_v1`.`facility`.`safety_incident`"
  dimensions:
    - name: "incident_type"
      expr: incident_type
      comment: "Classification of the safety incident"
    - name: "incident_date"
      expr: DATE_TRUNC('day', incident_date)
      comment: "Date the incident occurred"
    - name: "care_site_id"
      expr: care_site_id
      comment: "Care site where the incident was reported"
  measures:
    - name: "incident_count"
      expr: COUNT(1)
      comment: "Total number of safety incidents reported"
$$;