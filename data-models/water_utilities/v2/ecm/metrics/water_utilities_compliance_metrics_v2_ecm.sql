-- Metric views for domain: compliance | Business: Water_Utilities | Version: 2 | Generated on: 2026-07-02 04:05:05

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`compliance_ccr`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Key compliance reporting metrics derived from CCR records"
  source: "`vibe_water_utilities_v1`.`compliance`.`ccr`"
  dimensions:
    - name: "report_year"
      expr: report_year
      comment: "Reporting year of the CCR"
    - name: "source_water_type"
      expr: source_water_type
      comment: "Type of source water reported"
    - name: "compliance_status"
      expr: compliance_status
      comment: "Overall compliance status of the report"
    - name: "disinfection_byproduct_monitoring_flag"
      expr: disinfection_byproduct_monitoring_flag
      comment: "Flag indicating if DBP monitoring was performed"
    - name: "lead_copper_monitoring_flag"
      expr: lead_copper_monitoring_flag
      comment: "Flag indicating if lead/copper monitoring was performed"
    - name: "mcl_exceedance_flag"
      expr: mcl_exceedance_flag
      comment: "Flag for MCL exceedance"
    - name: "violation_included_flag"
      expr: violation_included_flag
      comment: "Flag indicating if a violation is included"
  measures:
    - name: "total_reports"
      expr: COUNT(1)
      comment: "Total number of CCR reports submitted"
    - name: "avg_lead_90th_ppb"
      expr: AVG(CAST(lead_90th_percentile_ppb AS DOUBLE))
      comment: "Average 90th percentile lead concentration (ppb) across reports"
    - name: "avg_copper_90th_ppm"
      expr: AVG(CAST(copper_90th_percentile_ppm AS DOUBLE))
      comment: "Average 90th percentile copper concentration (ppm) across reports"
    - name: "count_mcl_exceedances"
      expr: SUM(CASE WHEN mcl_exceedance_flag THEN 1 ELSE 0 END)
      comment: "Number of reports where MCL exceedance flag is true"
    - name: "count_violations"
      expr: SUM(CASE WHEN violation_included_flag THEN 1 ELSE 0 END)
      comment: "Number of reports that include a violation"
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`compliance_schedule`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Progress and status metrics for compliance schedules"
  source: "`vibe_water_utilities_v1`.`compliance`.`compliance_schedule`"
  dimensions:
    - name: "schedule_status"
      expr: schedule_status
      comment: "Current status of the schedule"
    - name: "schedule_type"
      expr: schedule_type
      comment: "Type/category of the schedule"
    - name: "responsible_department"
      expr: responsible_department
      comment: "Department responsible for the schedule"
    - name: "final_compliance_deadline"
      expr: final_compliance_deadline
      comment: "Final deadline date for compliance"
  measures:
    - name: "total_schedules"
      expr: COUNT(1)
      comment: "Total number of compliance schedules"
    - name: "avg_completion_percentage"
      expr: AVG(CAST(overall_completion_percentage AS DOUBLE))
      comment: "Average overall completion percentage across schedules"
    - name: "on_schedule_count"
      expr: SUM(CASE WHEN on_schedule_flag THEN 1 ELSE 0 END)
      comment: "Number of schedules currently on schedule"
    - name: "overdue_count"
      expr: SUM(CASE WHEN schedule_status = 'Overdue' THEN 1 ELSE 0 END)
      comment: "Number of schedules marked as overdue"
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`compliance_dmr_result`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Discharge Monitoring Report (DMR) result analytics"
  source: "`vibe_water_utilities_v1`.`compliance`.`dmr_result`"
  dimensions:
    - name: "parameter_name"
      expr: parameter_name
      comment: "Analyte or parameter measured"
    - name: "monitoring_location_code"
      expr: monitoring_location_code
      comment: "Code of the monitoring location"
    - name: "compliance_status"
      expr: compliance_status
      comment: "Compliance status for the sample"
    - name: "reporting_period_month"
      expr: DATE_TRUNC('month', reporting_period_start_date)
      comment: "Reporting period month"
  measures:
    - name: "total_samples"
      expr: COUNT(1)
      comment: "Total number of DMR result samples"
    - name: "avg_measurement_value"
      expr: AVG(CAST(measurement_value AS DOUBLE))
      comment: "Average measurement value across samples"
    - name: "exceedance_count"
      expr: SUM(CASE WHEN exceedance_flag THEN 1 ELSE 0 END)
      comment: "Count of samples that exceeded permit limits"
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`compliance_enforcement_action`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Enforcement action KPIs for regulatory compliance"
  source: "`vibe_water_utilities_v1`.`compliance`.`enforcement_action`"
  dimensions:
    - name: "action_type"
      expr: action_type
      comment: "Type/category of enforcement action"
    - name: "action_status"
      expr: action_status
      comment: "Current status of the action"
    - name: "regulatory_citation"
      expr: regulatory_citation
      comment: "Regulatory citation associated with the action"
    - name: "issuing_agency"
      expr: issuing_agency
      comment: "Agency that issued the enforcement action"
    - name: "public_notice_required_flag"
      expr: public_notice_required_flag
      comment: "Flag indicating if a public notice is required"
  measures:
    - name: "total_actions"
      expr: COUNT(1)
      comment: "Total number of enforcement actions recorded"
    - name: "total_civil_penalty_amount"
      expr: SUM(CAST(civil_penalty_amount AS DOUBLE))
      comment: "Sum of civil penalty amounts assessed"
    - name: "avg_penalty_amount"
      expr: AVG(CAST(civil_penalty_amount AS DOUBLE))
      comment: "Average civil penalty amount per action"
    - name: "count_public_notices"
      expr: SUM(CASE WHEN public_notice_required_flag THEN 1 ELSE 0 END)
      comment: "Number of actions that required a public notice"
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`compliance_mor`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Water quality performance metrics from Monthly Operational Reports (MOR)"
  source: "`vibe_water_utilities_v1`.`compliance`.`mor`"
  dimensions:
    - name: "reporting_year"
      expr: reporting_year
      comment: "Reporting year of the MOR"
    - name: "source_water_type"
      expr: source_water_type
      comment: "Type of source water"
    - name: "disinfectant_type"
      expr: disinfectant_type
      comment: "Disinfectant type used"
    - name: "ct_compliance_status"
      expr: ct_compliance_status
      comment: "Chlorine residual compliance status"
    - name: "turbidity_compliance_status"
      expr: turbidity_compliance_status
      comment: "Turbidity compliance status"
  measures:
    - name: "avg_total_water_produced_mgd"
      expr: AVG(CAST(total_water_produced_mgd AS DOUBLE))
      comment: "Average total water produced (MGD) per MOR record"
    - name: "avg_ph"
      expr: AVG(CAST(ph_avg AS DOUBLE))
      comment: "Average pH across MOR records"
    - name: "avg_turbidity"
      expr: AVG(CAST(finished_water_turbidity_avg_ntu AS DOUBLE))
      comment: "Average finished water turbidity (NTU)"
    - name: "count_non_compliant"
      expr: SUM(CASE WHEN ct_compliance_status != 'Compliant' THEN 1 ELSE 0 END)
      comment: "Number of MOR records where CT compliance status is not compliant"
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`compliance_obligation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Financial and priority metrics for compliance obligations"
  source: "`vibe_water_utilities_v1`.`compliance`.`obligation`"
  dimensions:
    - name: "obligation_status"
      expr: obligation_status
      comment: "Current status of the obligation"
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level assigned to the obligation"
    - name: "regulatory_authority"
      expr: regulatory_authority
      comment: "Regulatory authority overseeing the obligation"
    - name: "due_date"
      expr: due_date
      comment: "Due date for the obligation"
  measures:
    - name: "total_obligations"
      expr: COUNT(1)
      comment: "Total number of compliance obligations"
    - name: "total_actual_cost"
      expr: SUM(CAST(actual_cost AS DOUBLE))
      comment: "Sum of actual costs incurred for obligations"
    - name: "avg_actual_cost"
      expr: AVG(CAST(actual_cost AS DOUBLE))
      comment: "Average actual cost per obligation"
    - name: "total_estimated_cost"
      expr: SUM(CAST(estimated_cost AS DOUBLE))
      comment: "Sum of estimated costs for obligations"
    - name: "avg_estimated_cost"
      expr: AVG(CAST(estimated_cost AS DOUBLE))
      comment: "Average estimated cost per obligation"
    - name: "count_critical_path"
      expr: SUM(CASE WHEN is_critical_path THEN 1 ELSE 0 END)
      comment: "Number of obligations flagged as critical path"
$$;