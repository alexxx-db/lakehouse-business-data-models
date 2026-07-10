-- Metric views for domain: facility | Business: Healthcare | Version: 2 | Generated on: 2026-07-10 14:53:25

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`facility_bed`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Bed inventory and status KPIs used by capacity management and patient flow leadership to steer staffing, throughput, and utilization decisions."
  source: "`vibe_healthcare_v1`.`facility`.`bed`"
  dimensions:
    - name: "care_site_id"
      expr: care_site_id
      comment: "Care site the bed belongs to, for site-level capacity rollups."
    - name: "unit_id"
      expr: unit_id
      comment: "Nursing unit the bed is located in, for unit-level flow analysis."
    - name: "bed_status"
      expr: bed_status
      comment: "Operational status of the bed (available, occupied, cleaning, etc.)."
    - name: "bed_type"
      expr: bed_type
      comment: "Type/classification of bed used for capacity segmentation."
    - name: "bed_category"
      expr: bed_category
      comment: "Bed category grouping for licensed vs. staffed capacity analysis."
    - name: "is_active"
      expr: is_active
      comment: "Whether the bed is currently active in inventory."
    - name: "assignment_month"
      expr: DATE_TRUNC('MONTH', assignment_timestamp)
      comment: "Month bucket of the most recent bed assignment for trend analysis."
  measures:
    - name: "Bed Count"
      expr: COUNT(1)
      comment: "Total number of beds in inventory."
    - name: "Distinct Beds"
      expr: COUNT(DISTINCT bed_id)
      comment: "Distinct beds, used as denominator for occupancy and availability rates."
    - name: "Staffed Bed Count"
      expr: COUNT(CASE WHEN is_staffed = TRUE THEN 1 END)
      comment: "Count of beds currently staffed, driving safe capacity."
    - name: "Licensed Bed Count"
      expr: COUNT(CASE WHEN is_licensed = TRUE THEN 1 END)
      comment: "Count of licensed beds for regulatory capacity reporting."
    - name: "Occupied Bed Count"
      expr: COUNT(CASE WHEN bed_status = 'occupied' THEN 1 END)
      comment: "Beds currently occupied, numerator for occupancy rate."
    - name: "Isolation Capable Bed Count"
      expr: COUNT(CASE WHEN is_isolation_capable = TRUE THEN 1 END)
      comment: "Beds capable of isolation, key for infection control surge planning."
    - name: "Staffed Bed Rate Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_staffed = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of beds that are staffed; steers staffing investment and safe occupancy limits."
    - name: "Occupancy Rate Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN bed_status = 'occupied' THEN 1 END) / NULLIF(COUNT(CASE WHEN is_staffed = TRUE THEN 1 END), 0), 2)
      comment: "Occupied beds as a percent of staffed beds; core throughput and diversion decision metric."
    - name: "Avg Weight Capacity Lbs"
      expr: ROUND(AVG(CAST(weight_capacity_lbs AS DOUBLE)), 2)
      comment: "Average bed weight capacity, informing bariatric capability planning."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`facility_bed_status_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Bed turnover and ADT event KPIs used by patient flow and environmental services leadership to reduce discharge-to-clean cycle time and improve throughput."
  source: "`vibe_healthcare_v1`.`facility`.`bed_status_event`"
  dimensions:
    - name: "care_site_id"
      expr: care_site_id
      comment: "Care site where the bed event occurred."
    - name: "adt_event_type"
      expr: adt_event_type
      comment: "ADT event type (admit, discharge, transfer) for flow segmentation."
    - name: "new_status_code"
      expr: new_status_code
      comment: "Resulting bed status code after the event."
    - name: "acuity_level"
      expr: acuity_level
      comment: "Acuity level associated with the event for case-mix analysis."
    - name: "event_month"
      expr: DATE_TRUNC('MONTH', event_timestamp)
      comment: "Month bucket of the event for trend analysis."
  measures:
    - name: "Event Count"
      expr: COUNT(1)
      comment: "Total bed status events, baseline volume of bed turnover activity."
    - name: "Emergency Event Count"
      expr: COUNT(CASE WHEN is_emergency_flag = TRUE THEN 1 END)
      comment: "Emergency-flagged events, indicating unplanned demand pressure."
    - name: "Elective Event Count"
      expr: COUNT(CASE WHEN is_elective_flag = TRUE THEN 1 END)
      comment: "Elective-flagged events for scheduled demand planning."
    - name: "Emergency Event Rate Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_emergency_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Share of events that are emergencies; steers surge staffing and diversion decisions."
    - name: "Priority Event Count"
      expr: COUNT(CASE WHEN priority_flag = TRUE THEN 1 END)
      comment: "High-priority bed events requiring expedited turnaround."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`facility_environmental_service_request`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Environmental services (bed cleaning) performance KPIs used by EVS and patient flow leadership to reduce turnaround time and protect infection prevention outcomes."
  source: "`vibe_healthcare_v1`.`facility`.`environmental_service_request`"
  dimensions:
    - name: "care_site_id"
      expr: care_site_id
      comment: "Care site where the cleaning request originated."
    - name: "unit_id"
      expr: unit_id
      comment: "Unit associated with the cleaning request."
    - name: "request_status"
      expr: request_status
      comment: "Status of the environmental service request."
    - name: "request_type"
      expr: request_type
      comment: "Type of cleaning request for workload segmentation."
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level of the request for SLA analysis."
    - name: "isolation_precaution_type"
      expr: isolation_precaution_type
      comment: "Isolation precaution type driving specialized cleaning protocols."
    - name: "request_month"
      expr: DATE_TRUNC('MONTH', request_timestamp)
      comment: "Month bucket of the request for trend analysis."
  measures:
    - name: "Request Count"
      expr: COUNT(1)
      comment: "Total environmental service requests, baseline EVS workload."
    - name: "Avg Discharge To Clean Minutes"
      expr: ROUND(AVG(CAST(discharge_to_clean_cycle_time_minutes AS DOUBLE)), 2)
      comment: "Average discharge-to-clean cycle time; a primary patient flow throughput lever."
    - name: "Avg Request To Start Minutes"
      expr: ROUND(AVG(CAST(request_to_start_time_minutes AS DOUBLE)), 2)
      comment: "Average time from request to cleaning start; indicates EVS responsiveness."
    - name: "Avg Work Duration Minutes"
      expr: ROUND(AVG(CAST(work_duration_minutes AS DOUBLE)), 2)
      comment: "Average cleaning duration, informing labor standards and staffing."
    - name: "Infection Prevention Alert Count"
      expr: COUNT(CASE WHEN infection_prevention_alert_flag = TRUE THEN 1 END)
      comment: "Cleanings flagged for infection prevention, a quality/safety risk signal."
    - name: "Quality Inspection Pass Rate Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN quality_inspection_result = 'pass' THEN 1 END) / NULLIF(COUNT(CASE WHEN quality_inspection_performed_flag = TRUE THEN 1 END), 0), 2)
      comment: "Share of inspected cleanings passing quality inspection; steers EVS quality programs."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`facility_maintenance_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Facilities maintenance cost and downtime KPIs used by facilities and biomedical engineering leadership to control cost, reduce equipment downtime, and manage vendor performance."
  source: "`vibe_healthcare_v1`.`facility`.`maintenance_order`"
  dimensions:
    - name: "care_site_id"
      expr: care_site_id
      comment: "Care site where the maintenance work occurred."
    - name: "order_status"
      expr: order_status
      comment: "Status of the maintenance order (open, completed, etc.)."
    - name: "order_type"
      expr: order_type
      comment: "Type of maintenance order (corrective, preventive, etc.)."
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level of the maintenance order for SLA analysis."
    - name: "trade_type"
      expr: trade_type
      comment: "Trade/skill category performing the work."
    - name: "request_month"
      expr: DATE_TRUNC('MONTH', request_datetime)
      comment: "Month bucket of the request for cost/volume trending."
  measures:
    - name: "Order Count"
      expr: COUNT(1)
      comment: "Total maintenance orders, baseline maintenance workload."
    - name: "Total Maintenance Cost"
      expr: ROUND(SUM(CAST(total_cost AS DOUBLE)), 2)
      comment: "Total maintenance spend, a directly steerable facilities cost line."
    - name: "Total Labor Cost"
      expr: ROUND(SUM(CAST(labor_cost AS DOUBLE)), 2)
      comment: "Total labor cost component of maintenance."
    - name: "Total Parts Cost"
      expr: ROUND(SUM(CAST(parts_cost AS DOUBLE)), 2)
      comment: "Total parts cost component of maintenance."
    - name: "Avg Cost Per Order"
      expr: ROUND(AVG(CAST(total_cost AS DOUBLE)), 2)
      comment: "Average cost per maintenance order, monitoring cost efficiency."
    - name: "Total Labor Hours"
      expr: ROUND(SUM(CAST(labor_hours AS DOUBLE)), 2)
      comment: "Total labor hours consumed, informing staffing and outsourcing decisions."
    - name: "Safety Incident Order Count"
      expr: COUNT(CASE WHEN safety_incident_flag = TRUE THEN 1 END)
      comment: "Maintenance orders tied to safety incidents; a risk-driven escalation signal."
    - name: "Vendor Service Rate Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN vendor_service_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Share of orders serviced by external vendors; steers insourcing vs outsourcing strategy."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`facility_inspection`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Regulatory inspection and accreditation KPIs used by compliance and quality leadership to manage survey readiness, findings remediation, and accreditation risk."
  source: "`vibe_healthcare_v1`.`facility`.`facility_inspection`"
  dimensions:
    - name: "care_site_id"
      expr: care_site_id
      comment: "Care site inspected."
    - name: "inspection_type"
      expr: inspection_type
      comment: "Type of inspection (accreditation, licensure, complaint, etc.)."
    - name: "inspection_status"
      expr: inspection_status
      comment: "Status of the inspection."
    - name: "overall_disposition"
      expr: overall_disposition
      comment: "Overall disposition/outcome of the inspection."
    - name: "regulatory_authority"
      expr: regulatory_authority
      comment: "Regulatory authority conducting the inspection."
    - name: "inspection_month"
      expr: DATE_TRUNC('MONTH', inspection_date)
      comment: "Month bucket of the inspection for trend analysis."
  measures:
    - name: "Inspection Count"
      expr: COUNT(1)
      comment: "Total inspections, baseline regulatory activity volume."
    - name: "Total Inspection Cost"
      expr: ROUND(SUM(CAST(cost AS DOUBLE)), 2)
      comment: "Total cost of inspections and surveys."
    - name: "Complaint Based Inspection Count"
      expr: COUNT(CASE WHEN complaint_based_flag = TRUE THEN 1 END)
      comment: "Complaint-driven inspections, a reputational and quality risk signal."
    - name: "Follow Up Required Count"
      expr: COUNT(CASE WHEN follow_up_survey_required_flag = TRUE THEN 1 END)
      comment: "Inspections requiring follow-up surveys, driving remediation workload."
    - name: "Follow Up Required Rate Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN follow_up_survey_required_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Share of inspections needing follow-up; a key survey-readiness KPI."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`facility_inspection_finding`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Inspection findings remediation KPIs used by compliance leadership to track corrective actions, financial penalties, and patient safety risk exposure."
  source: "`vibe_healthcare_v1`.`facility`.`inspection_finding`"
  dimensions:
    - name: "finding_category"
      expr: finding_category
      comment: "Category of the inspection finding."
    - name: "severity_level"
      expr: severity_level
      comment: "Severity level of the finding for risk prioritization."
    - name: "resolution_status"
      expr: resolution_status
      comment: "Resolution status of the finding."
    - name: "regulatory_body"
      expr: regulatory_body
      comment: "Regulatory body associated with the finding."
    - name: "finding_month"
      expr: DATE_TRUNC('MONTH', finding_date)
      comment: "Month bucket of the finding for trend analysis."
  measures:
    - name: "Finding Count"
      expr: COUNT(1)
      comment: "Total inspection findings, baseline remediation workload."
    - name: "Total Financial Penalty"
      expr: ROUND(SUM(CAST(financial_penalty_amount AS DOUBLE)), 2)
      comment: "Total financial penalties from findings, a direct cost/risk exposure."
    - name: "Patient Safety Impact Count"
      expr: COUNT(CASE WHEN patient_safety_impact_flag = TRUE THEN 1 END)
      comment: "Findings impacting patient safety, a high-priority escalation signal."
    - name: "Recurrence Count"
      expr: COUNT(CASE WHEN recurrence_flag = TRUE THEN 1 END)
      comment: "Recurring findings indicating ineffective prior corrective action."
    - name: "Recurrence Rate Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN recurrence_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Share of findings that recur; measures corrective-action effectiveness."
    - name: "Accreditation Impact Count"
      expr: COUNT(CASE WHEN accreditation_impact_flag = TRUE THEN 1 END)
      comment: "Findings affecting accreditation status, a strategic risk metric."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`facility_capacity_snapshot`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Point-in-time hospital capacity and occupancy KPIs used by patient flow command centers to manage diversion, surge, and throughput in near real time."
  source: "`vibe_healthcare_v1`.`facility`.`capacity_snapshot`"
  dimensions:
    - name: "care_site_id"
      expr: care_site_id
      comment: "Care site of the capacity snapshot."
    - name: "unit_id"
      expr: unit_id
      comment: "Unit associated with the snapshot."
    - name: "ambulance_diversion_status"
      expr: ambulance_diversion_status
      comment: "Ambulance diversion status at snapshot time."
    - name: "ed_bypass_status"
      expr: ed_bypass_status
      comment: "ED bypass status at snapshot time."
    - name: "snapshot_hour"
      expr: DATE_TRUNC('HOUR', snapshot_timestamp)
      comment: "Hour bucket of the snapshot for intraday capacity trending."
  measures:
    - name: "Snapshot Count"
      expr: COUNT(1)
      comment: "Number of capacity snapshots, baseline for time-window analysis."
    - name: "Avg Occupancy Pct"
      expr: ROUND(AVG(CAST(occupancy_percentage AS DOUBLE)), 2)
      comment: "Average occupancy percentage; the core capacity-steering metric for diversion decisions."
    - name: "Avg OR Utilization Pct"
      expr: ROUND(AVG(CAST(or_utilization_percentage AS DOUBLE)), 2)
      comment: "Average operating room utilization; drives perioperative scheduling decisions."
    - name: "Diversion Snapshot Count"
      expr: COUNT(CASE WHEN ambulance_diversion_status = 'on' THEN 1 END)
      comment: "Snapshots where the facility was on ambulance diversion, a revenue and access risk indicator."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`facility_equipment_asset`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Medical equipment asset KPIs used by biomedical engineering and finance leadership to manage capital value, preventive maintenance compliance, and recall risk."
  source: "`vibe_healthcare_v1`.`facility`.`equipment_asset`"
  dimensions:
    - name: "equipment_category"
      expr: equipment_category
      comment: "Equipment category for portfolio segmentation."
    - name: "operational_status"
      expr: operational_status
      comment: "Operational status of the asset."
    - name: "pm_compliance_status"
      expr: pm_compliance_status
      comment: "Preventive maintenance compliance status."
    - name: "recall_status"
      expr: recall_status
      comment: "Recall status of the asset for risk tracking."
    - name: "risk_category"
      expr: risk_category
      comment: "Clinical risk category of the equipment."
  measures:
    - name: "Asset Count"
      expr: COUNT(1)
      comment: "Total equipment assets in the portfolio."
    - name: "Total Acquisition Cost"
      expr: ROUND(SUM(CAST(acquisition_cost AS DOUBLE)), 2)
      comment: "Total capital acquisition value of the equipment portfolio."
    - name: "Avg Acquisition Cost"
      expr: ROUND(AVG(CAST(acquisition_cost AS DOUBLE)), 2)
      comment: "Average asset acquisition cost for capital planning."
    - name: "PM Compliant Count"
      expr: COUNT(CASE WHEN pm_compliance_status = 'compliant' THEN 1 END)
      comment: "Assets compliant with preventive maintenance schedules."
    - name: "PM Compliance Rate Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN pm_compliance_status = 'compliant' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Share of assets meeting PM compliance; a regulatory and safety KPI."
    - name: "Open Recall Count"
      expr: COUNT(CASE WHEN recall_status = 'open' THEN 1 END)
      comment: "Assets with open recalls, a patient safety escalation signal."
    - name: "Calibration Required Count"
      expr: COUNT(CASE WHEN calibration_required_flag = TRUE THEN 1 END)
      comment: "Assets requiring calibration, informing biomed workload."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`facility_safety_incident`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Facility safety incident KPIs used by safety and risk leadership to manage OSHA exposure, property damage, and immediate-jeopardy risk."
  source: "`vibe_healthcare_v1`.`facility`.`safety_incident`"
  dimensions:
    - name: "care_site_id"
      expr: care_site_id
      comment: "Care site where the incident occurred."
    - name: "unit_id"
      expr: unit_id
      comment: "Unit where the incident occurred."
    - name: "incident_type"
      expr: incident_type
      comment: "Type of safety incident."
    - name: "incident_status"
      expr: incident_status
      comment: "Status of the incident investigation."
    - name: "injury_severity"
      expr: injury_severity
      comment: "Severity of any resulting injury for risk prioritization."
    - name: "incident_month"
      expr: DATE_TRUNC('MONTH', incident_date)
      comment: "Month bucket of the incident for trend analysis."
  measures:
    - name: "Incident Count"
      expr: COUNT(1)
      comment: "Total safety incidents, baseline safety volume."
    - name: "Injury Incident Count"
      expr: COUNT(CASE WHEN injuries_sustained_flag = TRUE THEN 1 END)
      comment: "Incidents resulting in injuries, the key harm metric."
    - name: "Total Property Damage Amount"
      expr: ROUND(SUM(CAST(property_damage_amount AS DOUBLE)), 2)
      comment: "Total property damage cost from incidents."
    - name: "Immediate Jeopardy Count"
      expr: COUNT(CASE WHEN cms_immediate_jeopardy_flag = TRUE THEN 1 END)
      comment: "Incidents flagged as CMS immediate jeopardy, a top-tier regulatory risk."
    - name: "OSHA Recordable Count"
      expr: COUNT(CASE WHEN osha_300_log_required_flag = TRUE THEN 1 END)
      comment: "OSHA 300-log recordable incidents for regulatory reporting."
    - name: "Injury Rate Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN injuries_sustained_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Share of incidents causing injury; steers safety program investment."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`facility_contract`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Facility vendor contract KPIs used by facilities and finance leadership to manage contract spend, SLA performance, and renewal risk."
  source: "`vibe_healthcare_v1`.`facility`.`facility_contract`"
  dimensions:
    - name: "care_site_id"
      expr: care_site_id
      comment: "Care site associated with the contract."
    - name: "contract_status"
      expr: contract_status
      comment: "Status of the facility contract."
    - name: "service_type"
      expr: service_type
      comment: "Type of service the contract covers."
    - name: "auto_renewal_flag"
      expr: auto_renewal_flag
      comment: "Whether the contract auto-renews, informing renewal review workload."
    - name: "start_month"
      expr: DATE_TRUNC('MONTH', start_date)
      comment: "Month bucket of the contract start for trend analysis."
  measures:
    - name: "Contract Count"
      expr: COUNT(1)
      comment: "Total facility contracts under management."
    - name: "Total Annual Spend"
      expr: ROUND(SUM(CAST(annual_spend_amount AS DOUBLE)), 2)
      comment: "Total annual contracted spend, a directly steerable cost line."
    - name: "Total Contract Value"
      expr: ROUND(SUM(CAST(value_amount AS DOUBLE)), 2)
      comment: "Total lifetime value of contracts for spend governance."
    - name: "Avg SLA Uptime Pct"
      expr: ROUND(AVG(CAST(sla_uptime_percentage AS DOUBLE)), 2)
      comment: "Average SLA uptime commitment across contracts; vendor performance benchmark."
    - name: "Auto Renewal Rate Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN auto_renewal_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Share of contracts on auto-renewal; a renewal-governance risk KPI."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`facility_space_allocation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Space utilization and cost KPIs used by real estate and finance leadership to optimize occupancy, cost per square foot, and space allocation decisions."
  source: "`vibe_healthcare_v1`.`facility`.`space_allocation`"
  dimensions:
    - name: "care_site_id"
      expr: care_site_id
      comment: "Care site of the space allocation."
    - name: "space_type"
      expr: space_type
      comment: "Type of space allocated."
    - name: "allocation_status"
      expr: allocation_status
      comment: "Status of the space allocation."
    - name: "service_line"
      expr: service_line
      comment: "Service line the space is allocated to."
    - name: "shared_space_flag"
      expr: shared_space_flag
      comment: "Whether the space is shared, informing utilization efficiency."
  measures:
    - name: "Allocation Count"
      expr: COUNT(1)
      comment: "Total space allocations under management."
    - name: "Total Allocated Square Footage"
      expr: ROUND(SUM(CAST(allocated_square_footage AS DOUBLE)), 2)
      comment: "Total allocated square footage, the base of space utilization analysis."
    - name: "Total Annual Space Cost"
      expr: ROUND(SUM(CAST(annual_space_cost AS DOUBLE)), 2)
      comment: "Total annual space cost, a directly steerable occupancy expense."
    - name: "Avg Cost Per Square Foot"
      expr: ROUND(AVG(CAST(cost_per_square_foot AS DOUBLE)), 2)
      comment: "Average cost per square foot for benchmarking space efficiency."
    - name: "Avg Occupancy Pct"
      expr: ROUND(AVG(CAST(occupancy_percentage AS DOUBLE)), 2)
      comment: "Average space occupancy percentage; drives consolidation and reallocation decisions."
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
    - name: "building_id"
      expr: building_id
      comment: "Identifier of the building containing the care site"
    - name: "snapshot_date"
      expr: DATE_TRUNC('day', snapshot_timestamp)
      comment: "Date of the capacity snapshot"
  measures:
    - name: "avg_occupancy_pct"
      expr: AVG(CAST(occupancy_percentage AS DOUBLE))
      comment: "Average occupancy percentage across snapshots for the selected period"
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
    - name: "finding_date"
      expr: DATE_TRUNC('day', finding_date)
      comment: "Date the finding was recorded"
  measures:
    - name: "total_findings"
      expr: COUNT(1)
      comment: "Total number of inspection findings recorded"
    - name: "high_severity_findings"
      expr: SUM(CASE WHEN severity_level = 'High' THEN 1 ELSE 0 END)
      comment: "Count of findings classified as high severity"
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
    - name: "injury_incident_count"
      expr: SUM(CASE WHEN injuries_sustained_flag THEN 1 ELSE 0 END)
      comment: "Count of incidents where injuries were sustained"
    - name: "property_damage_total"
      expr: SUM(CAST(property_damage_amount AS DOUBLE))
      comment: "Aggregate monetary value of property damage from incidents"
$$;