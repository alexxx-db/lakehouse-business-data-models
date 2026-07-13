-- Metric views for domain: compliance | Business: Retail | Version: 2 | Generated on: 2026-07-12 14:06:09

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`compliance_audit_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Operational KPIs for audit execution quality, coverage, and findings severity across locations, vendors, and org units. Drives audit program effectiveness reviews and resource allocation decisions."
  source: "`vibe_retail_v1`.`compliance`.`audit_event`"
  dimensions:
    - name: "audit_type"
      expr: audit_type
      comment: "Category of audit (e.g. internal, external, regulatory) for segmenting audit performance by program type."
    - name: "audit_method"
      expr: audit_method
      comment: "Execution method (e.g. on-site, remote, hybrid) used to analyze efficiency and cost trade-offs."
    - name: "audit_result"
      expr: audit_result
      comment: "Overall outcome of the audit (e.g. pass, fail, conditional) for pass-rate trending."
    - name: "audit_status"
      expr: audit_status
      comment: "Current lifecycle status of the audit record (e.g. scheduled, in-progress, completed, cancelled)."
    - name: "regulatory_framework"
      expr: regulatory_framework
      comment: "Regulatory standard or framework under which the audit was conducted (e.g. ISO 9001, FSMA)."
    - name: "audit_date_month"
      expr: DATE_TRUNC('MONTH', audit_date)
      comment: "Calendar month of the audit date for time-series trending of audit volume and scores."
    - name: "corrective_action_plan_required"
      expr: corrective_action_plan_required_flag
      comment: "Indicates whether a corrective action plan was mandated, enabling CAP rate analysis."
    - name: "follow_up_required"
      expr: follow_up_required_flag
      comment: "Indicates whether a follow-up audit was required, a proxy for first-time pass rate."
  measures:
    - name: "total_audits_conducted"
      expr: COUNT(1)
      comment: "Total number of audit events executed. Baseline volume metric for audit program coverage reporting."
    - name: "avg_audit_score"
      expr: AVG(CAST(audit_score AS DOUBLE))
      comment: "Average audit score across all completed audits. A declining trend signals systemic compliance deterioration requiring executive intervention."
    - name: "avg_audit_duration_hours"
      expr: AVG(CAST(audit_duration_hours AS DOUBLE))
      comment: "Average time spent per audit in hours. Used to benchmark auditor efficiency and plan resource capacity."
    - name: "total_audit_duration_hours"
      expr: SUM(CAST(audit_duration_hours AS DOUBLE))
      comment: "Total auditor hours consumed across all audit events. Drives budget and staffing decisions for the audit function."
    - name: "audits_requiring_corrective_action_plan"
      expr: COUNT(CASE WHEN corrective_action_plan_required_flag = TRUE THEN 1 END)
      comment: "Number of audits that mandated a corrective action plan. High values indicate systemic compliance gaps requiring leadership attention."
    - name: "corrective_action_plan_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN corrective_action_plan_required_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of audits resulting in a mandatory corrective action plan. A key compliance health KPI tracked at QBRs."
    - name: "follow_up_audit_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN follow_up_required_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of audits requiring a follow-up, inversely related to first-time compliance pass rate. Drives audit program quality improvement."
    - name: "regulatory_notification_required_count"
      expr: COUNT(CASE WHEN regulatory_notification_required_flag = TRUE THEN 1 END)
      comment: "Number of audits triggering mandatory regulatory notification. Elevated counts signal material compliance risk exposure."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`compliance_audit_finding`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs measuring the severity, financial impact, and resolution velocity of audit findings. Directly informs risk prioritization and corrective action investment decisions."
  source: "`vibe_retail_v1`.`compliance`.`audit_finding`"
  dimensions:
    - name: "audit_finding_category"
      expr: audit_finding_category
      comment: "Classification of the finding (e.g. safety, financial, operational) for category-level risk analysis."
    - name: "audit_finding_status"
      expr: audit_finding_status
      comment: "Current resolution status (e.g. open, in-remediation, closed) for pipeline and aging analysis."
    - name: "regulatory_standard"
      expr: regulatory_standard
      comment: "Regulatory standard associated with the finding for framework-level compliance gap reporting."
    - name: "recurrence_flag"
      expr: recurrence_flag
      comment: "Indicates whether the finding is a repeat occurrence, a critical signal for systemic control failures."
    - name: "corrective_action_required"
      expr: corrective_action_required_flag
      comment: "Whether a corrective action was mandated for this finding."
    - name: "regulatory_reporting_required"
      expr: regulatory_reporting_required_flag
      comment: "Whether the finding must be reported to a regulatory body, indicating material compliance exposure."
    - name: "identified_date_month"
      expr: DATE_TRUNC('MONTH', identified_date)
      comment: "Month the finding was identified, enabling trend analysis of finding discovery rates."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which financial impact is denominated, required for multi-currency financial impact aggregation."
  measures:
    - name: "total_findings"
      expr: COUNT(1)
      comment: "Total number of audit findings recorded. Baseline volume metric for compliance gap tracking."
    - name: "total_financial_impact"
      expr: SUM(CAST(financial_impact_amount AS DOUBLE))
      comment: "Total estimated financial exposure from audit findings. A primary metric for quantifying compliance risk in monetary terms for executive reporting."
    - name: "avg_financial_impact_per_finding"
      expr: AVG(CAST(financial_impact_amount AS DOUBLE))
      comment: "Average financial impact per finding. Used to prioritize remediation investment toward highest-value risk reduction."
    - name: "open_findings_count"
      expr: COUNT(CASE WHEN audit_finding_status NOT IN ('closed', 'resolved') THEN 1 END)
      comment: "Number of findings not yet resolved. A leading indicator of unmitigated compliance risk in the portfolio."
    - name: "recurrent_findings_count"
      expr: COUNT(CASE WHEN recurrence_flag = TRUE THEN 1 END)
      comment: "Number of findings that are repeat occurrences. High recurrence signals root-cause remediation failures requiring escalation."
    - name: "recurrence_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN recurrence_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of findings that are recurrent. A critical quality metric for the corrective action program effectiveness."
    - name: "regulatory_reportable_findings_count"
      expr: COUNT(CASE WHEN regulatory_reporting_required_flag = TRUE THEN 1 END)
      comment: "Number of findings requiring regulatory disclosure. Directly tied to legal and reputational risk exposure."
    - name: "avg_days_to_close"
      expr: AVG(DATEDIFF(closed_date, identified_date))
      comment: "Average calendar days from finding identification to closure. Measures remediation velocity; slow closure increases regulatory and financial risk."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`compliance_corrective_action`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs tracking corrective action plan execution, cost, timeliness, and effectiveness. Enables leadership to assess whether compliance gaps are being closed efficiently and sustainably."
  source: "`vibe_retail_v1`.`compliance`.`corrective_action`"
  dimensions:
    - name: "action_type"
      expr: action_type
      comment: "Type of corrective action (e.g. process change, training, equipment fix) for categorizing remediation strategies."
    - name: "corrective_action_status"
      expr: corrective_action_status
      comment: "Current lifecycle status (e.g. open, in-progress, verified, closed) for pipeline management."
    - name: "compliance_category"
      expr: compliance_category
      comment: "Compliance domain the action addresses (e.g. food safety, PCI, OSHA) for category-level remediation tracking."
    - name: "priority"
      expr: priority
      comment: "Priority level assigned to the corrective action for workload and escalation management."
    - name: "effectiveness_rating"
      expr: effectiveness_rating
      comment: "Post-closure rating of how effective the action was in preventing recurrence. Drives program quality improvement."
    - name: "escalation_required"
      expr: escalation_required
      comment: "Whether the action required escalation, indicating systemic or high-severity issues."
    - name: "target_completion_month"
      expr: DATE_TRUNC('MONTH', target_completion_date)
      comment: "Month the corrective action was targeted for completion, enabling on-time delivery trend analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency for cost amounts, required for multi-currency cost aggregation."
  measures:
    - name: "total_corrective_actions"
      expr: COUNT(1)
      comment: "Total corrective actions initiated. Baseline volume metric for remediation program workload."
    - name: "total_actual_remediation_cost"
      expr: SUM(CAST(actual_cost AS DOUBLE))
      comment: "Total actual cost incurred to execute corrective actions. A direct input to compliance program ROI and budget planning."
    - name: "total_estimated_remediation_cost"
      expr: SUM(CAST(estimated_cost AS DOUBLE))
      comment: "Total estimated cost of corrective actions. Used for budget forecasting and compliance investment planning."
    - name: "cost_variance"
      expr: SUM((CAST(actual_cost AS DOUBLE)) - (CAST(estimated_cost AS DOUBLE)))
      comment: "Aggregate cost overrun or underrun versus estimates. Negative variance signals budget discipline; positive signals underestimation risk."
    - name: "avg_days_to_close"
      expr: AVG(DATEDIFF(closure_date, created_timestamp))
      comment: "Average calendar days from corrective action creation to closure. Measures remediation velocity and operational responsiveness."
    - name: "overdue_actions_count"
      expr: COUNT(CASE WHEN corrective_action_status NOT IN ('closed', 'verified') AND target_completion_date < CURRENT_DATE() THEN 1 END)
      comment: "Number of corrective actions past their target completion date and still open. A leading risk indicator requiring executive escalation."
    - name: "on_time_closure_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN actual_completion_date <= target_completion_date THEN 1 END) / NULLIF(COUNT(CASE WHEN actual_completion_date IS NOT NULL THEN 1 END), 0), 2)
      comment: "Percentage of closed corrective actions completed on or before the target date. A key operational KPI for compliance program discipline."
    - name: "escalated_actions_count"
      expr: COUNT(CASE WHEN escalation_required = TRUE THEN 1 END)
      comment: "Number of corrective actions requiring escalation. High counts signal systemic issues or resource constraints in the compliance function."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`compliance_violation_notice`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs quantifying regulatory violation exposure, penalty costs, and resolution outcomes. A primary executive dashboard for legal and regulatory risk management."
  source: "`vibe_retail_v1`.`compliance`.`violation_notice`"
  dimensions:
    - name: "violation_type"
      expr: violation_type
      comment: "Category of violation (e.g. safety, environmental, labor) for risk portfolio analysis."
    - name: "violation_status"
      expr: violation_status
      comment: "Current resolution status (e.g. open, appealed, settled, closed) for active risk tracking."
    - name: "severity_level"
      expr: severity_level
      comment: "Severity classification of the violation for prioritizing legal and operational response."
    - name: "regulatory_standard_violated"
      expr: regulatory_standard_violated
      comment: "Specific regulatory standard breached, enabling framework-level compliance gap analysis."
    - name: "recurrence_flag"
      expr: recurrence_flag
      comment: "Whether this is a repeat violation, a critical signal for systemic non-compliance."
    - name: "appeal_filed_flag"
      expr: appeal_filed_flag
      comment: "Whether an appeal was filed, indicating contested violations and potential penalty reduction."
    - name: "settlement_negotiated_flag"
      expr: settlement_negotiated_flag
      comment: "Whether a settlement was negotiated, relevant for legal cost and penalty management analysis."
    - name: "violation_date_month"
      expr: DATE_TRUNC('MONTH', violation_date)
      comment: "Month of violation occurrence for trend analysis of regulatory exposure over time."
    - name: "penalty_currency_code"
      expr: penalty_currency_code
      comment: "Currency of the penalty amount for multi-currency financial exposure reporting."
  measures:
    - name: "total_violation_notices"
      expr: COUNT(1)
      comment: "Total number of regulatory violation notices received. Baseline metric for regulatory exposure volume."
    - name: "total_penalty_amount"
      expr: SUM(CAST(penalty_amount AS DOUBLE))
      comment: "Total monetary penalties assessed across all violation notices. A direct measure of regulatory financial liability for executive and board reporting."
    - name: "total_settlement_amount"
      expr: SUM(CAST(settlement_amount AS DOUBLE))
      comment: "Total settlement amounts paid to resolve violations. Compared against original penalties to measure negotiation effectiveness."
    - name: "avg_penalty_per_violation"
      expr: AVG(CAST(penalty_amount AS DOUBLE))
      comment: "Average penalty amount per violation notice. Tracks severity trend of regulatory enforcement actions over time."
    - name: "recurrent_violation_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN recurrence_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of violations that are repeat offenses. High recurrence rates signal systemic compliance program failures requiring board-level attention."
    - name: "open_violations_count"
      expr: COUNT(CASE WHEN violation_status NOT IN ('closed', 'settled', 'dismissed') THEN 1 END)
      comment: "Number of unresolved violation notices. Represents active regulatory risk exposure in the compliance portfolio."
    - name: "penalty_settlement_ratio"
      expr: ROUND(SUM(CAST(settlement_amount AS DOUBLE)) / NULLIF(SUM(CAST(penalty_amount AS DOUBLE)), 0), 4)
      comment: "Ratio of total settlement paid to total penalty assessed. Values below 1.0 indicate successful penalty negotiation; used to evaluate legal strategy effectiveness."
    - name: "corrective_action_required_count"
      expr: COUNT(CASE WHEN corrective_action_required_flag = TRUE THEN 1 END)
      comment: "Number of violations mandating corrective action. Drives remediation workload planning and compliance investment prioritization."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`compliance_training_completion`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs measuring workforce compliance training effectiveness, pass rates, cost efficiency, and certification currency. Directly informs regulatory readiness and workforce development investment decisions."
  source: "`vibe_retail_v1`.`compliance`.`training_completion`"
  dimensions:
    - name: "compliance_status"
      expr: compliance_status
      comment: "Compliance outcome of the training completion (e.g. compliant, non-compliant, waived) for regulatory readiness reporting."
    - name: "pass_fail_result"
      expr: pass_fail_result
      comment: "Assessment outcome (pass/fail) for training effectiveness analysis."
    - name: "delivery_method"
      expr: delivery_method
      comment: "Training delivery channel (e.g. e-learning, classroom, on-the-job) for cost and effectiveness benchmarking."
    - name: "job_role_category"
      expr: job_role_category
      comment: "Job role category of the trainee for targeted compliance gap analysis by workforce segment."
    - name: "mandatory_flag"
      expr: mandatory_flag
      comment: "Whether the training was mandatory, enabling mandatory vs. voluntary completion rate comparison."
    - name: "regulatory_framework"
      expr: regulatory_framework
      comment: "Regulatory framework the training supports (e.g. OSHA, FSMA, PCI-DSS) for framework-level compliance coverage."
    - name: "completion_date_month"
      expr: DATE_TRUNC('MONTH', completion_date)
      comment: "Month of training completion for time-series trending of compliance training throughput."
    - name: "cost_currency_code"
      expr: cost_currency_code
      comment: "Currency of training cost for multi-currency cost aggregation."
  measures:
    - name: "total_training_completions"
      expr: COUNT(1)
      comment: "Total training completion records. Baseline metric for compliance training program throughput."
    - name: "pass_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN pass_fail_result = 'pass' THEN 1 END) / NULLIF(COUNT(CASE WHEN pass_fail_result IS NOT NULL THEN 1 END), 0), 2)
      comment: "Percentage of assessed training completions that resulted in a pass. A primary indicator of training program quality and workforce compliance readiness."
    - name: "avg_assessment_score"
      expr: AVG(CAST(assessment_score AS DOUBLE))
      comment: "Average assessment score across all training completions. Tracks knowledge retention quality and training content effectiveness."
    - name: "total_training_cost"
      expr: SUM(CAST(cost_amount AS DOUBLE))
      comment: "Total cost incurred for compliance training. A direct input to compliance program budget management and cost-per-compliant-associate analysis."
    - name: "avg_cost_per_completion"
      expr: AVG(CAST(cost_amount AS DOUBLE))
      comment: "Average training cost per completion record. Used to benchmark delivery method efficiency and vendor cost-effectiveness."
    - name: "total_training_hours_delivered"
      expr: SUM(CAST(training_duration_hours AS DOUBLE))
      comment: "Total compliance training hours delivered across the workforce. Measures training investment scale and regulatory coverage depth."
    - name: "mandatory_compliance_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN mandatory_flag = TRUE AND pass_fail_result = 'pass' THEN 1 END) / NULLIF(COUNT(CASE WHEN mandatory_flag = TRUE THEN 1 END), 0), 2)
      comment: "Pass rate specifically for mandatory compliance training. A regulatory readiness KPI — low rates signal material compliance risk and potential regulatory exposure."
    - name: "distinct_associates_trained"
      expr: COUNT(DISTINCT training_associate_id)
      comment: "Number of unique associates who completed at least one training. Measures breadth of compliance training coverage across the workforce."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`compliance_osha_incident`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs for workplace safety incident tracking, severity analysis, and regulatory reporting compliance. A mandatory executive dashboard for OSHA recordkeeping obligations and safety culture investment decisions."
  source: "`vibe_retail_v1`.`compliance`.`osha_incident`"
  dimensions:
    - name: "incident_type"
      expr: incident_type
      comment: "Type of workplace incident (e.g. injury, illness, near-miss) for safety program categorization."
    - name: "injury_type"
      expr: injury_type
      comment: "Nature of injury or illness for root-cause and prevention program targeting."
    - name: "severity_level"
      expr: severity_level
      comment: "Severity classification of the incident for risk prioritization and regulatory reporting thresholds."
    - name: "osha_incident_status"
      expr: osha_incident_status
      comment: "Current investigation and case status (e.g. open, under investigation, closed) for active case management."
    - name: "osha_recordable_flag"
      expr: osha_recordable_flag
      comment: "Whether the incident meets OSHA recordability criteria, directly tied to regulatory reporting obligations."
    - name: "osha_301_reportable_flag"
      expr: osha_301_reportable_flag
      comment: "Whether the incident requires OSHA 301 form submission, indicating severe injury or illness."
    - name: "recurrence_flag"
      expr: recurrence_flag
      comment: "Whether this is a repeat incident type, signaling systemic safety control failures."
    - name: "incident_date_month"
      expr: DATE_TRUNC('MONTH', incident_date)
      comment: "Month of incident occurrence for time-series safety trend analysis and seasonal pattern detection."
    - name: "work_activity"
      expr: work_activity
      comment: "Work activity being performed at time of incident for targeted safety intervention design."
  measures:
    - name: "total_incidents"
      expr: COUNT(1)
      comment: "Total OSHA incidents recorded. Baseline safety volume metric for incident rate calculations."
    - name: "osha_recordable_incidents"
      expr: COUNT(CASE WHEN osha_recordable_flag = TRUE THEN 1 END)
      comment: "Number of OSHA-recordable incidents. The primary regulatory compliance metric for OSHA 300 log obligations."
    - name: "total_estimated_incident_cost"
      expr: SUM(CAST(estimated_cost_amount AS DOUBLE))
      comment: "Total estimated financial cost of workplace incidents including medical, lost productivity, and remediation. Quantifies safety program ROI for executive investment decisions."
    - name: "avg_incident_cost"
      expr: AVG(CAST(estimated_cost_amount AS DOUBLE))
      comment: "Average cost per incident. Used to benchmark safety investment against incident cost avoidance."
    - name: "recurrent_incident_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN recurrence_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of incidents that are repeat occurrences. High rates indicate root-cause remediation failures in the safety program."
    - name: "regulatory_reporting_required_count"
      expr: COUNT(CASE WHEN regulatory_reporting_required_flag = TRUE THEN 1 END)
      comment: "Number of incidents requiring mandatory regulatory notification. Tracks regulatory exposure and reporting obligation workload."
    - name: "open_investigations_count"
      expr: COUNT(CASE WHEN osha_incident_status NOT IN ('closed', 'case_closed') THEN 1 END)
      comment: "Number of incidents with open or in-progress investigations. Measures investigation backlog and response capacity."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`compliance_environmental_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs for environmental compliance event tracking, remediation cost, and regulatory reporting. Supports ESG reporting, environmental liability management, and regulatory penalty avoidance."
  source: "`vibe_retail_v1`.`compliance`.`environmental_event`"
  dimensions:
    - name: "event_type"
      expr: event_type
      comment: "Type of environmental event (e.g. spill, emission, waste disposal) for categorized risk analysis."
    - name: "event_status"
      expr: event_status
      comment: "Current status of the environmental event (e.g. open, remediated, closed) for active liability tracking."
    - name: "material_type"
      expr: material_type
      comment: "Type of material involved in the event for hazard classification and regulatory reporting."
    - name: "hazmat_class"
      expr: hazmat_class
      comment: "Hazardous material classification for regulatory framework alignment and response protocol selection."
    - name: "regulatory_framework"
      expr: regulatory_framework
      comment: "Environmental regulatory framework applicable to the event (e.g. RCRA, CERCLA, Clean Water Act)."
    - name: "penalty_assessed"
      expr: penalty_assessed
      comment: "Whether a regulatory penalty was assessed, indicating enforcement action severity."
    - name: "regulatory_reporting_required"
      expr: regulatory_reporting_required
      comment: "Whether the event required regulatory disclosure, tracking mandatory reporting obligations."
    - name: "event_date_month"
      expr: DATE_TRUNC('MONTH', event_date)
      comment: "Month of event occurrence for ESG trend reporting and seasonal environmental risk analysis."
  measures:
    - name: "total_environmental_events"
      expr: COUNT(1)
      comment: "Total environmental compliance events recorded. Baseline metric for environmental risk portfolio sizing."
    - name: "total_remediation_cost"
      expr: SUM(CAST(remediation_cost AS DOUBLE))
      comment: "Total cost of environmental remediation activities. A primary ESG financial liability metric for executive and board reporting."
    - name: "total_penalty_amount"
      expr: SUM(CAST(penalty_amount AS DOUBLE))
      comment: "Total regulatory penalties assessed for environmental violations. Directly quantifies environmental compliance financial exposure."
    - name: "avg_remediation_cost_per_event"
      expr: AVG(CAST(remediation_cost AS DOUBLE))
      comment: "Average remediation cost per environmental event. Used to benchmark prevention investment against remediation cost avoidance."
    - name: "penalized_event_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN penalty_assessed = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of environmental events resulting in regulatory penalties. A key environmental compliance health KPI."
    - name: "total_spill_volume"
      expr: SUM(CAST(spill_volume AS DOUBLE))
      comment: "Total volume of spills recorded across all environmental events. An ESG impact metric for environmental footprint reporting."
    - name: "regulatory_reportable_events_count"
      expr: COUNT(CASE WHEN regulatory_reporting_required = TRUE THEN 1 END)
      comment: "Number of events requiring mandatory regulatory reporting. Tracks environmental disclosure obligations and associated compliance workload."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`compliance_pci_assessment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs for PCI-DSS compliance assessment status, findings severity, and remediation progress. Critical for payment security governance, merchant level management, and cardholder data environment risk oversight."
  source: "`vibe_retail_v1`.`compliance`.`pci_assessment`"
  dimensions:
    - name: "assessment_type"
      expr: assessment_type
      comment: "Type of PCI assessment (e.g. QSA, SAQ, internal) for compliance program coverage analysis."
    - name: "compliance_status"
      expr: compliance_status
      comment: "Overall PCI compliance status (e.g. compliant, non-compliant, in-remediation) for payment security posture reporting."
    - name: "merchant_level"
      expr: merchant_level
      comment: "PCI merchant level (1-4) determining assessment requirements and regulatory obligations."
    - name: "pci_dss_version"
      expr: pci_dss_version
      comment: "PCI-DSS version under which the assessment was conducted, tracking version migration progress."
    - name: "penetration_test_pass_flag"
      expr: penetration_test_pass_flag
      comment: "Whether the penetration test passed, a mandatory PCI-DSS control validation indicator."
    - name: "vulnerability_scan_pass_flag"
      expr: vulnerability_scan_pass_flag
      comment: "Whether the vulnerability scan passed, a mandatory quarterly PCI-DSS requirement."
    - name: "remediation_plan_required_flag"
      expr: remediation_plan_required_flag
      comment: "Whether a remediation plan was required, indicating non-compliant assessment outcomes."
    - name: "assessment_date_month"
      expr: DATE_TRUNC('MONTH', assessment_date)
      comment: "Month of assessment for compliance posture trend analysis over time."
  measures:
    - name: "total_assessments"
      expr: COUNT(1)
      comment: "Total PCI assessments conducted. Baseline metric for payment security program coverage."
    - name: "compliant_assessments_count"
      expr: COUNT(CASE WHEN compliance_status = 'compliant' THEN 1 END)
      comment: "Number of assessments achieving full PCI compliance. Tracks payment security program effectiveness."
    - name: "compliance_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN compliance_status = 'compliant' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of PCI assessments achieving compliant status. A board-level payment security KPI with direct regulatory and reputational implications."
    - name: "total_annual_transaction_volume"
      expr: SUM(CAST(annual_transaction_volume AS DOUBLE))
      comment: "Total annual transaction volume across assessed environments. Contextualizes PCI scope and merchant level obligations."
    - name: "avg_annual_transaction_volume"
      expr: AVG(CAST(annual_transaction_volume AS DOUBLE))
      comment: "Average annual transaction volume per assessment scope. Used to benchmark PCI investment against transaction risk exposure."
    - name: "assessments_requiring_remediation"
      expr: COUNT(CASE WHEN remediation_plan_required_flag = TRUE THEN 1 END)
      comment: "Number of assessments requiring a formal remediation plan. Tracks active payment security risk requiring investment."
    - name: "pen_test_pass_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN penetration_test_pass_flag = TRUE THEN 1 END) / NULLIF(COUNT(CASE WHEN penetration_test_pass_flag IS NOT NULL THEN 1 END), 0), 2)
      comment: "Percentage of assessments where penetration testing passed. A mandatory PCI-DSS control effectiveness metric."
    - name: "vulnerability_scan_pass_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN vulnerability_scan_pass_flag = TRUE THEN 1 END) / NULLIF(COUNT(CASE WHEN vulnerability_scan_pass_flag IS NOT NULL THEN 1 END), 0), 2)
      comment: "Percentage of assessments where vulnerability scanning passed. Tracks quarterly PCI-DSS scanning compliance across the cardholder data environment."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`compliance_certification`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs for compliance certification portfolio management including expiration risk, renewal velocity, and cost. Enables proactive certification renewal management to avoid lapses that trigger regulatory penalties."
  source: "`vibe_retail_v1`.`compliance`.`certification`"
  dimensions:
    - name: "certification_type"
      expr: certification_type
      comment: "Type of certification (e.g. ISO 22000, GFSI, organic) for portfolio categorization and renewal planning."
    - name: "certification_status"
      expr: certification_status
      comment: "Current status (e.g. active, expired, suspended, withdrawn) for active portfolio management."
    - name: "regulatory_framework"
      expr: regulatory_framework
      comment: "Regulatory or industry framework the certification supports for compliance coverage mapping."
    - name: "coverage_level"
      expr: coverage_level
      comment: "Scope of certification coverage (e.g. facility, product line, enterprise) for risk exposure assessment."
    - name: "renewal_workflow_status"
      expr: renewal_workflow_status
      comment: "Status of the renewal process for certifications approaching expiration, enabling proactive management."
    - name: "public_disclosure_flag"
      expr: public_disclosure_flag
      comment: "Whether the certification is publicly disclosed, relevant for brand and regulatory transparency reporting."
    - name: "expiration_date_month"
      expr: DATE_TRUNC('MONTH', expiration_date)
      comment: "Month of certification expiration for renewal pipeline planning and lapse risk management."
    - name: "cost_currency_code"
      expr: cost_currency_code
      comment: "Currency of certification cost for multi-currency cost aggregation."
  measures:
    - name: "total_certifications"
      expr: COUNT(1)
      comment: "Total certifications in the portfolio. Baseline metric for compliance certification coverage breadth."
    - name: "active_certifications_count"
      expr: COUNT(CASE WHEN certification_status = 'active' THEN 1 END)
      comment: "Number of currently active certifications. Tracks the live compliance certification posture of the organization."
    - name: "expiring_within_90_days_count"
      expr: COUNT(CASE WHEN certification_status = 'active' AND expiration_date BETWEEN CURRENT_DATE() AND DATE_ADD(CURRENT_DATE(), 90) THEN 1 END)
      comment: "Number of active certifications expiring within 90 days. A critical leading indicator for renewal risk management and regulatory lapse prevention."
    - name: "expired_certifications_count"
      expr: COUNT(CASE WHEN certification_status = 'expired' THEN 1 END)
      comment: "Number of lapsed certifications. Expired certifications represent active regulatory and operational risk requiring immediate remediation."
    - name: "total_certification_cost"
      expr: SUM(CAST(cost_amount AS DOUBLE))
      comment: "Total cost of maintaining the certification portfolio. Drives compliance budget planning and cost optimization decisions."
    - name: "avg_certification_cost"
      expr: AVG(CAST(cost_amount AS DOUBLE))
      comment: "Average cost per certification. Used to benchmark certification investment and identify cost reduction opportunities."
    - name: "certification_lapse_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN certification_status = 'expired' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of certifications that have lapsed. A compliance program health KPI — high lapse rates signal renewal process failures."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`compliance_risk_register`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs for compliance risk portfolio management including financial exposure, risk distribution by category, and mitigation progress. Enables risk-based resource allocation and executive risk appetite decisions."
  source: "`vibe_retail_v1`.`compliance`.`risk_register`"
  dimensions:
    - name: "risk_category"
      expr: risk_category
      comment: "High-level risk category (e.g. regulatory, operational, financial, reputational) for portfolio-level risk analysis."
    - name: "risk_subcategory"
      expr: risk_subcategory
      comment: "Detailed risk subcategory for granular risk segmentation and targeted mitigation planning."
    - name: "risk_register_status"
      expr: risk_register_status
      comment: "Current status of the risk item (e.g. open, mitigated, accepted, closed) for active risk portfolio management."
    - name: "impact_rating"
      expr: impact_rating
      comment: "Assessed impact level (e.g. low, medium, high, critical) for risk prioritization."
    - name: "likelihood_rating"
      expr: likelihood_rating
      comment: "Assessed likelihood of risk materialization for risk scoring and prioritization."
    - name: "risk_response_type"
      expr: risk_response_type
      comment: "Risk response strategy (e.g. mitigate, accept, transfer, avoid) for strategy mix analysis."
    - name: "escalation_required"
      expr: escalation_required
      comment: "Whether the risk requires executive escalation, filtering for board-level risk items."
    - name: "identified_date_month"
      expr: DATE_TRUNC('MONTH', identified_date)
      comment: "Month risk was identified for trend analysis of emerging compliance risk patterns."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency for financial impact estimates, required for multi-currency risk exposure aggregation."
  measures:
    - name: "total_risks"
      expr: COUNT(1)
      comment: "Total risks in the compliance risk register. Baseline metric for risk portfolio size and program scope."
    - name: "open_risks_count"
      expr: COUNT(CASE WHEN risk_register_status NOT IN ('closed', 'accepted', 'mitigated') THEN 1 END)
      comment: "Number of unresolved open risks. Tracks active compliance risk exposure requiring management attention."
    - name: "total_financial_impact_estimate"
      expr: SUM(CAST(financial_impact_estimate AS DOUBLE))
      comment: "Total estimated financial exposure across all compliance risks. A primary metric for quantifying aggregate compliance liability for executive and board reporting."
    - name: "avg_financial_impact_per_risk"
      expr: AVG(CAST(financial_impact_estimate AS DOUBLE))
      comment: "Average financial impact estimate per risk item. Used to prioritize risk mitigation investment toward highest-value exposure reduction."
    - name: "escalated_risks_count"
      expr: COUNT(CASE WHEN escalation_required = TRUE THEN 1 END)
      comment: "Number of risks requiring executive escalation. Tracks the volume of material risks demanding leadership attention."
    - name: "regulatory_reporting_required_count"
      expr: COUNT(CASE WHEN regulatory_reporting_required = TRUE THEN 1 END)
      comment: "Number of risks with mandatory regulatory disclosure requirements. Tracks external reporting obligations arising from the risk portfolio."
    - name: "avg_days_open"
      expr: AVG(DATEDIFF(COALESCE(actual_closure_date, CURRENT_DATE()), identified_date))
      comment: "Average age of risks in the register in calendar days. Long-aged open risks signal stalled mitigation programs requiring executive intervention."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`compliance_safety_inspection`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs for workplace safety inspection program performance including compliance scores, violation rates, and follow-up requirements. Drives safety investment decisions and regulatory readiness assessments."
  source: "`vibe_retail_v1`.`compliance`.`safety_inspection`"
  dimensions:
    - name: "inspection_type"
      expr: inspection_type
      comment: "Type of safety inspection (e.g. routine, regulatory, follow-up) for program coverage analysis."
    - name: "inspection_status"
      expr: inspection_status
      comment: "Current status of the inspection (e.g. scheduled, completed, cancelled) for pipeline management."
    - name: "overall_result"
      expr: overall_result
      comment: "Overall inspection outcome (e.g. pass, fail, conditional pass) for compliance rate trending."
    - name: "corrective_action_required"
      expr: corrective_action_required
      comment: "Whether corrective action was mandated, enabling CAP rate analysis for safety inspections."
    - name: "followup_inspection_required"
      expr: followup_inspection_required
      comment: "Whether a follow-up inspection was required, inversely related to first-time pass rate."
    - name: "fire_safety_compliant"
      expr: fire_safety_compliant
      comment: "Fire safety compliance status for targeted safety domain analysis."
    - name: "hazmat_storage_compliant"
      expr: hazmat_storage_compliant
      comment: "Hazardous materials storage compliance status for environmental and safety risk analysis."
    - name: "inspection_date_month"
      expr: DATE_TRUNC('MONTH', inspection_date)
      comment: "Month of inspection for time-series safety compliance trend analysis."
  measures:
    - name: "total_inspections"
      expr: COUNT(1)
      comment: "Total safety inspections conducted. Baseline metric for safety program coverage and inspection cadence."
    - name: "avg_compliance_score"
      expr: AVG(CAST(compliance_score AS DOUBLE))
      comment: "Average safety compliance score across all inspections. A primary safety program health KPI tracked at operational steering reviews."
    - name: "pass_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN overall_result = 'pass' THEN 1 END) / NULLIF(COUNT(CASE WHEN overall_result IS NOT NULL THEN 1 END), 0), 2)
      comment: "Percentage of safety inspections achieving a passing result. Tracks safety compliance posture across locations and facilities."
    - name: "corrective_action_required_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN corrective_action_required = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of inspections mandating corrective action. High rates signal systemic safety compliance gaps requiring investment."
    - name: "followup_required_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN followup_inspection_required = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of inspections requiring a follow-up visit. Inversely measures first-time compliance pass rate for safety programs."
    - name: "fire_safety_non_compliance_count"
      expr: COUNT(CASE WHEN fire_safety_compliant = FALSE THEN 1 END)
      comment: "Number of inspections with fire safety non-compliance findings. A high-priority safety risk metric with direct life-safety and regulatory implications."
    - name: "hazmat_non_compliance_count"
      expr: COUNT(CASE WHEN hazmat_storage_compliant = FALSE THEN 1 END)
      comment: "Number of inspections with hazardous materials storage non-compliance. Tracks environmental and safety regulatory exposure."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`compliance_regulatory_filing`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs for regulatory filing timeliness, cost, and status management. Enables compliance operations teams and executives to track filing obligations, avoid penalties from late submissions, and manage regulatory relationships."
  source: "`vibe_retail_v1`.`compliance`.`regulatory_filing`"
  dimensions:
    - name: "filing_type"
      expr: filing_type
      comment: "Type of regulatory filing (e.g. annual report, license renewal, incident report) for obligation categorization."
    - name: "filing_status"
      expr: filing_status
      comment: "Current status of the filing (e.g. pending, submitted, accepted, rejected) for pipeline management."
    - name: "filing_jurisdiction"
      expr: filing_jurisdiction
      comment: "Jurisdiction in which the filing was made for geographic compliance coverage analysis."
    - name: "submission_method"
      expr: submission_method
      comment: "Method used to submit the filing (e.g. electronic, paper, portal) for process efficiency analysis."
    - name: "resubmission_required_flag"
      expr: resubmission_required_flag
      comment: "Whether the filing was rejected and requires resubmission, indicating quality issues in the filing process."
    - name: "filing_date_month"
      expr: DATE_TRUNC('MONTH', filing_date)
      comment: "Month of filing submission for workload and compliance calendar management."
    - name: "filing_fee_currency_code"
      expr: filing_fee_currency_code
      comment: "Currency of filing fees for multi-currency cost aggregation."
  measures:
    - name: "total_filings"
      expr: COUNT(1)
      comment: "Total regulatory filings submitted. Baseline metric for regulatory obligation fulfillment volume."
    - name: "accepted_filings_count"
      expr: COUNT(CASE WHEN filing_status = 'accepted' THEN 1 END)
      comment: "Number of filings accepted by regulatory authorities. Tracks successful regulatory obligation fulfillment."
    - name: "rejected_filings_count"
      expr: COUNT(CASE WHEN filing_status = 'rejected' THEN 1 END)
      comment: "Number of filings rejected by regulatory authorities. Rejected filings create resubmission costs and potential penalty exposure."
    - name: "rejection_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN filing_status = 'rejected' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of filings rejected by regulators. A quality metric for the regulatory filing process — high rates signal documentation or process failures."
    - name: "total_filing_fees"
      expr: SUM(CAST(filing_fee_amount AS DOUBLE))
      comment: "Total regulatory filing fees paid. A direct compliance program cost metric for budget management."
    - name: "avg_days_to_acceptance"
      expr: AVG(DATEDIFF(acceptance_date, filing_date))
      comment: "Average calendar days from filing submission to regulatory acceptance. Measures regulatory processing efficiency and informs filing lead-time planning."
    - name: "overdue_filings_count"
      expr: COUNT(CASE WHEN filing_status NOT IN ('accepted', 'submitted') AND next_filing_due_date < CURRENT_DATE() THEN 1 END)
      comment: "Number of filings past their due date and not yet accepted. Represents active regulatory penalty risk from late submissions."
$$;