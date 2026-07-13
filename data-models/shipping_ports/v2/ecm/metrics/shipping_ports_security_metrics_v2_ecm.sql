-- Metric views for domain: security | Business: Shipping_Ports | Version: 2 | Generated on: 2026-07-13 07:51:56

CREATE OR REPLACE VIEW `vibe_shipping_ports_v1`.`_metrics`.`security_incident`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Operational KPIs for port security incidents — severity distribution, financial impact, response timeliness, and MARSEC-level correlation. Used by PFSO and Port Security Director to steer incident response posture and resource allocation."
  source: "`vibe_shipping_ports_v1`.`security`.`security_incident`"
  dimensions:
    - name: "incident_type"
      expr: incident_type
      comment: "Category of security incident (theft, trespass, piracy threat, etc.) for trend analysis by type."
    - name: "severity_level"
      expr: severity_level
      comment: "Severity classification (Critical/High/Medium/Low) enabling prioritisation of response resources."
    - name: "marsec_level"
      expr: marsec_level
      comment: "MARSEC level in effect at time of incident — correlates threat environment with incident frequency."
    - name: "incident_status"
      expr: incident_status
      comment: "Current lifecycle status (Open/Under Investigation/Closed) for workload and backlog tracking."
    - name: "incident_subtype"
      expr: subtype
      comment: "Granular sub-classification of the incident type for detailed root-cause analysis."
    - name: "law_enforcement_notified"
      expr: law_enforcement_notified_flag
      comment: "Whether law enforcement was notified — used to measure escalation rate to external authorities."
    - name: "cargo_involved"
      expr: cargo_involved_flag
      comment: "Flag indicating cargo was involved — used to correlate security incidents with cargo loss/damage claims."
    - name: "incident_month"
      expr: DATE_TRUNC('MONTH', datetime)
      comment: "Month of incident occurrence for time-series trend analysis."
    - name: "incident_year"
      expr: DATE_TRUNC('YEAR', datetime)
      comment: "Year of incident occurrence for annual performance benchmarking."
  measures:
    - name: "total_incidents"
      expr: COUNT(1)
      comment: "Total number of security incidents recorded. Baseline KPI for incident volume tracking and year-over-year comparison."
    - name: "total_estimated_financial_impact"
      expr: SUM(CAST(estimated_financial_impact AS DOUBLE))
      comment: "Aggregate estimated financial impact (USD) of all security incidents. Directly informs insurance provisioning and security investment decisions."
    - name: "avg_estimated_financial_impact_per_incident"
      expr: AVG(CAST(estimated_financial_impact AS DOUBLE))
      comment: "Average financial impact per incident. Tracks cost severity trend and helps prioritise mitigation investment."
    - name: "critical_high_incident_count"
      expr: COUNT(CASE WHEN severity_level IN ('Critical','High') THEN 1 END)
      comment: "Count of Critical and High severity incidents. Executive KPI for assessing whether the port faces an elevated threat environment."
    - name: "law_enforcement_escalation_count"
      expr: COUNT(CASE WHEN law_enforcement_notified_flag = TRUE THEN 1 END)
      comment: "Number of incidents escalated to law enforcement. Measures severity of incidents requiring external authority involvement."
    - name: "open_incident_count"
      expr: COUNT(CASE WHEN incident_status NOT IN ('Closed','Resolved') THEN 1 END)
      comment: "Count of currently open/unresolved incidents. Operational backlog KPI for PFSO workload management."
    - name: "cargo_related_incident_count"
      expr: COUNT(CASE WHEN cargo_involved_flag = TRUE THEN 1 END)
      comment: "Incidents involving cargo — key for trade compliance and cargo security risk reporting to port authority."
    - name: "national_authority_escalation_count"
      expr: COUNT(CASE WHEN national_authority_escalated_flag = TRUE THEN 1 END)
      comment: "Incidents escalated to national maritime authority — highest-severity escalation metric for regulatory reporting."
$$;

CREATE OR REPLACE VIEW `vibe_shipping_ports_v1`.`_metrics`.`security_access_credential`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs for port access credential lifecycle management — expiry risk, biometric enrolment coverage, revocation rates, and MARSEC access alignment. Used by Security Manager and Compliance Officer to ensure only authorised personnel hold valid credentials."
  source: "`vibe_shipping_ports_v1`.`security`.`access_credential`"
  dimensions:
    - name: "credential_type"
      expr: credential_type
      comment: "Type of credential (TWIC, Port ID, Visitor Pass, etc.) for segmented lifecycle analysis."
    - name: "credential_status"
      expr: credential_status
      comment: "Current status (Active/Expired/Revoked/Suspended) — primary dimension for access risk dashboards."
    - name: "holder_type"
      expr: holder_type
      comment: "Category of credential holder (Employee, Contractor, Visitor, Driver) for population segmentation."
    - name: "marsec_level_access"
      expr: marsec_level_access
      comment: "MARSEC level for which the credential grants access — used to audit access rights vs. current threat level."
    - name: "biometric_enrolled"
      expr: biometric_enrolled
      comment: "Whether the holder has completed biometric enrolment — measures biometric coverage of the credentialed population."
    - name: "escort_required"
      expr: escort_required
      comment: "Whether the credential requires escort — used to plan escort officer resource requirements."
    - name: "issuing_authority"
      expr: issuing_authority
      comment: "Authority that issued the credential — for audit trail and regulatory compliance verification."
    - name: "background_check_status"
      expr: background_check_status
      comment: "Status of background check (Passed/Pending/Failed) — critical for security vetting compliance."
    - name: "issue_year"
      expr: DATE_TRUNC('YEAR', issue_date)
      comment: "Year credential was issued — for cohort analysis of credential populations."
  measures:
    - name: "total_active_credentials"
      expr: COUNT(CASE WHEN credential_status = 'Active' THEN 1 END)
      comment: "Total active credentials in circulation. Baseline headcount KPI for access population management."
    - name: "expired_credential_count"
      expr: COUNT(CASE WHEN credential_status = 'Expired' THEN 1 END)
      comment: "Count of expired credentials. Elevated count signals compliance risk — expired credentials must be deactivated promptly."
    - name: "revoked_credential_count"
      expr: COUNT(CASE WHEN credential_status = 'Revoked' THEN 1 END)
      comment: "Count of revoked credentials. Tracks security enforcement actions and potential insider threat responses."
    - name: "biometric_enrolled_count"
      expr: COUNT(CASE WHEN biometric_enrolled = TRUE THEN 1 END)
      comment: "Number of credentials with biometric enrolment completed. Numerator for biometric coverage rate calculation."
    - name: "total_credentials"
      expr: COUNT(1)
      comment: "Total credential records. Denominator for coverage and compliance rate calculations."
    - name: "escort_required_count"
      expr: COUNT(CASE WHEN escort_required = TRUE THEN 1 END)
      comment: "Number of credentials requiring escort. Drives escort officer staffing requirements planning."
    - name: "background_check_pending_count"
      expr: COUNT(CASE WHEN background_check_status = 'Pending' THEN 1 END)
      comment: "Credentials with background checks still pending. Compliance risk indicator — pending checks on active credentials is a regulatory gap."
    - name: "failed_access_attempt_total"
      expr: COUNT(CASE WHEN failed_access_count IS NOT NULL AND failed_access_count != '0' THEN 1 END)
      comment: "Count of credentials that have recorded at least one failed access attempt. Proxy for tailgating/credential misuse risk."
$$;

CREATE OR REPLACE VIEW `vibe_shipping_ports_v1`.`_metrics`.`security_access_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Real-time and historical KPIs for physical access control events at port gates and restricted zones. Used by Security Operations Centre (SOC) to monitor access throughput, denial rates, alarm triggers, and anti-passback violations."
  source: "`vibe_shipping_ports_v1`.`security`.`access_event`"
  dimensions:
    - name: "access_decision"
      expr: access_decision
      comment: "Outcome of the access attempt (Granted/Denied/Override) — primary dimension for access control effectiveness."
    - name: "event_type"
      expr: event_type
      comment: "Type of access event (Entry/Exit/Alarm/Override) for operational categorisation."
    - name: "access_point_type"
      expr: access_point_type
      comment: "Type of access point (Gate/Turnstile/Vehicle Lane/Waterside) for location-based analysis."
    - name: "marsec_level"
      expr: marsec_level
      comment: "MARSEC level at time of event — correlates access patterns with threat environment."
    - name: "zone_classification"
      expr: zone_classification
      comment: "Security classification of the zone accessed (Restricted/Public/Sterile) for risk-weighted analysis."
    - name: "credential_type"
      expr: credential_type
      comment: "Type of credential used — identifies which credential categories generate the most denials or alarms."
    - name: "visitor_flag"
      expr: visitor_flag
      comment: "Whether the access event was by a visitor — used to separate visitor vs. staff access patterns."
    - name: "event_hour"
      expr: DATE_TRUNC('HOUR', event_timestamp)
      comment: "Hour of access event — for intraday throughput and anomaly detection analysis."
    - name: "event_date"
      expr: DATE_TRUNC('DAY', event_timestamp)
      comment: "Date of access event — for daily trend and shift-pattern analysis."
  measures:
    - name: "total_access_events"
      expr: COUNT(1)
      comment: "Total access events processed. Baseline throughput KPI for gate and access point capacity planning."
    - name: "access_denied_count"
      expr: COUNT(CASE WHEN access_decision = 'Denied' THEN 1 END)
      comment: "Total access denial events. High denial rates indicate credential issues, tailgating attempts, or misconfigured access rules."
    - name: "alarm_triggered_count"
      expr: COUNT(CASE WHEN alarm_triggered_flag = TRUE THEN 1 END)
      comment: "Number of access events that triggered a security alarm. Critical SOC KPI for real-time threat detection."
    - name: "anti_passback_violation_count"
      expr: COUNT(CASE WHEN anti_passback_violation_flag = TRUE THEN 1 END)
      comment: "Anti-passback violations detected. Indicates credential sharing or tailgating — a key ISPS compliance metric."
    - name: "override_event_count"
      expr: COUNT(CASE WHEN access_decision = 'Override' THEN 1 END)
      comment: "Access events granted via manual override. Elevated overrides signal process bypass risk requiring audit."
    - name: "avg_biometric_match_score"
      expr: AVG(CAST(biometric_match_score AS DOUBLE))
      comment: "Average biometric match score across all biometric-verified access events. Low scores indicate equipment degradation or enrolment quality issues."
    - name: "time_zone_violation_count"
      expr: COUNT(CASE WHEN time_zone_restriction_violated_flag = TRUE THEN 1 END)
      comment: "Access events outside permitted time windows. Measures after-hours access risk and credential misconfiguration."
    - name: "unique_credentials_used"
      expr: COUNT(DISTINCT access_credential_id)
      comment: "Count of distinct credentials used in access events. Measures active credential utilisation vs. total issued."
$$;

CREATE OR REPLACE VIEW `vibe_shipping_ports_v1`.`_metrics`.`security_screening_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs for port security screening operations — detection rates, prohibited item finds, watchlist matches, and radiation alerts. Used by PFSO and Port Authority to measure screening effectiveness and ISPS compliance."
  source: "`vibe_shipping_ports_v1`.`security`.`screening_record`"
  dimensions:
    - name: "screening_method"
      expr: screening_method
      comment: "Primary screening method used (X-Ray/Manual/Biometric/Document Check) for method effectiveness comparison."
    - name: "subject_type"
      expr: subject_type
      comment: "Type of subject screened (Person/Vehicle/Cargo/Vessel) for segmented screening analysis."
    - name: "screening_outcome"
      expr: screening_outcome
      comment: "Result of screening (Clear/Alert/Detained/Referred) — primary KPI dimension for detection effectiveness."
    - name: "marsec_level"
      expr: marsec_level
      comment: "MARSEC level at time of screening — measures how screening intensity changes with threat level."
    - name: "screening_status"
      expr: screening_status
      comment: "Processing status of the screening record (Completed/Pending/Escalated)."
    - name: "watchlist_match_flag"
      expr: watchlist_match_flag
      comment: "Whether the subject matched a watchlist entry — critical security intelligence dimension."
    - name: "screening_date"
      expr: DATE_TRUNC('DAY', screening_timestamp)
      comment: "Date of screening for daily throughput and detection trend analysis."
    - name: "screening_month"
      expr: DATE_TRUNC('MONTH', screening_timestamp)
      comment: "Month of screening for monthly performance reporting."
  measures:
    - name: "total_screenings"
      expr: COUNT(1)
      comment: "Total screening events conducted. Baseline throughput KPI for screening resource planning and ISPS compliance reporting."
    - name: "prohibited_item_detection_count"
      expr: COUNT(CASE WHEN prohibited_item_detected_flag = TRUE THEN 1 END)
      comment: "Number of screenings where prohibited items were detected. Core security effectiveness KPI — directly measures threat interdiction."
    - name: "watchlist_match_count"
      expr: COUNT(CASE WHEN watchlist_match_flag = TRUE THEN 1 END)
      comment: "Screenings resulting in a watchlist match. Critical intelligence KPI — each match requires immediate security response."
    - name: "radiation_threshold_exceeded_count"
      expr: COUNT(CASE WHEN radiation_threshold_exceeded_flag = TRUE THEN 1 END)
      comment: "Screenings where radiation readings exceeded safe thresholds. CBRN threat detection KPI for port authority reporting."
    - name: "alert_triggered_count"
      expr: COUNT(CASE WHEN alert_triggered_flag = TRUE THEN 1 END)
      comment: "Total screening alerts triggered across all methods. Aggregate threat signal volume for SOC workload management."
    - name: "secondary_screening_count"
      expr: COUNT(CASE WHEN secondary_screening_method IS NOT NULL THEN 1 END)
      comment: "Screenings requiring secondary screening. Measures escalation rate from primary to secondary screening — high rates may indicate primary method inadequacy."
    - name: "avg_biometric_match_score"
      expr: AVG(CAST(biometric_match_score AS DOUBLE))
      comment: "Average biometric verification score for biometrically screened subjects. Tracks biometric system accuracy and equipment health."
    - name: "avg_radiation_reading"
      expr: AVG(CAST(radiation_reading AS DOUBLE))
      comment: "Average radiation reading across all screened subjects/cargo. Baseline for anomaly detection and threshold calibration."
    - name: "pfso_notified_count"
      expr: COUNT(CASE WHEN pfso_notified_flag = TRUE THEN 1 END)
      comment: "Screenings that required PFSO notification. Measures high-severity screening event frequency for PFSO workload planning."
$$;

CREATE OR REPLACE VIEW `vibe_shipping_ports_v1`.`_metrics`.`security_cyber_incident`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Cybersecurity incident KPIs aligned with IMO MSC-FAL.1/Circ.3 and ISPS Code cyber risk requirements. Used by CISO and Port Security Director to track cyber threat exposure, data breach risk, and operational disruption from cyber events."
  source: "`vibe_shipping_ports_v1`.`security`.`cyber_incident`"
  dimensions:
    - name: "incident_type"
      expr: incident_type
      comment: "Cyber incident category (Ransomware/Phishing/Intrusion/DDoS/Insider Threat) for threat landscape analysis."
    - name: "severity_level"
      expr: severity_level
      comment: "Severity classification of the cyber incident — drives escalation and response resource allocation."
    - name: "incident_status"
      expr: incident_status
      comment: "Current status (Open/Contained/Resolved/Under Review) for backlog and resolution tracking."
    - name: "attack_vector"
      expr: attack_vector
      comment: "Attack vector (Email/Network/Physical/Supply Chain) — informs defensive investment priorities."
    - name: "data_breach_flag"
      expr: data_breach_flag
      comment: "Whether the incident involved a data breach — triggers GDPR/regulatory notification obligations."
    - name: "operational_disruption_flag"
      expr: operational_disruption_flag
      comment: "Whether the incident caused operational disruption to port systems — links cyber risk to operational resilience."
    - name: "maritime_authority_notified"
      expr: maritime_authority_notification_flag
      comment: "Whether maritime authority was notified per IMO MSC-FAL.1/Circ.3 requirements."
    - name: "incident_month"
      expr: DATE_TRUNC('MONTH', occurrence_timestamp)
      comment: "Month of cyber incident occurrence for trend analysis."
    - name: "threat_actor_type"
      expr: threat_actor_type
      comment: "Classification of threat actor (Nation-State/Criminal/Insider/Hacktivist) for threat intelligence reporting."
  measures:
    - name: "total_cyber_incidents"
      expr: COUNT(1)
      comment: "Total cyber incidents recorded. Baseline KPI for cyber threat volume tracking and year-over-year benchmarking."
    - name: "data_breach_incident_count"
      expr: COUNT(CASE WHEN data_breach_flag = TRUE THEN 1 END)
      comment: "Incidents involving confirmed data breaches. Regulatory reporting KPI — each breach may trigger GDPR/NIS2 notification obligations."
    - name: "operational_disruption_incident_count"
      expr: COUNT(CASE WHEN operational_disruption_flag = TRUE THEN 1 END)
      comment: "Cyber incidents causing operational disruption. Directly links cybersecurity posture to port throughput and revenue risk."
    - name: "total_estimated_financial_impact"
      expr: SUM(CAST(estimated_financial_impact AS DOUBLE))
      comment: "Total estimated financial impact of all cyber incidents. Drives cyber insurance provisioning and security investment justification."
    - name: "avg_estimated_financial_impact"
      expr: AVG(CAST(estimated_financial_impact AS DOUBLE))
      comment: "Average financial impact per cyber incident. Tracks cost severity trend for budget planning."
    - name: "total_downtime_minutes"
      expr: COUNT(CASE WHEN downtime_duration_minutes IS NOT NULL AND downtime_duration_minutes != '0' THEN 1 END)
      comment: "Count of incidents with recorded system downtime. Proxy for operational resilience impact — actual downtime minutes are stored as STRING and cannot be summed directly."
    - name: "pii_exposed_incident_count"
      expr: COUNT(CASE WHEN pii_exposed_flag = TRUE THEN 1 END)
      comment: "Incidents where PII was exposed. Critical privacy compliance KPI triggering data protection authority notifications."
    - name: "unresolved_incident_count"
      expr: COUNT(CASE WHEN incident_status NOT IN ('Resolved','Closed') THEN 1 END)
      comment: "Open/unresolved cyber incidents. Backlog KPI for CISO to track remediation velocity and residual exposure."
    - name: "maritime_authority_notification_count"
      expr: COUNT(CASE WHEN maritime_authority_notification_flag = TRUE THEN 1 END)
      comment: "Incidents reported to maritime authority per IMO cyber risk management requirements. Regulatory compliance KPI."
$$;

CREATE OR REPLACE VIEW `vibe_shipping_ports_v1`.`_metrics`.`security_audit`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "ISPS security audit performance KPIs — non-conformance rates, audit cost, corrective action compliance, and audit cycle adherence. Used by Port Security Director and Compliance Officer for ISPS certification maintenance and regulatory reporting."
  source: "`vibe_shipping_ports_v1`.`security`.`security_audit`"
  dimensions:
    - name: "audit_type"
      expr: audit_type
      comment: "Type of security audit (Internal/External/Flag State/Port State Control) for segmented compliance analysis."
    - name: "audit_status"
      expr: audit_status
      comment: "Current audit status (Planned/In Progress/Completed/Overdue) for audit programme management."
    - name: "isps_code_compliance_level"
      expr: isps_code_compliance_level
      comment: "ISPS Code compliance rating from the audit — primary output KPI for regulatory standing."
    - name: "closure_status"
      expr: closure_status
      comment: "Whether all findings have been closed — measures corrective action completion rate."
    - name: "corrective_action_plan_required"
      expr: corrective_action_plan_required
      comment: "Whether a corrective action plan was required — indicates audit severity."
    - name: "follow_up_audit_required"
      expr: follow_up_audit_required
      comment: "Whether a follow-up audit was mandated — signals significant non-conformances requiring re-inspection."
    - name: "regulatory_framework"
      expr: regulatory_framework
      comment: "Regulatory framework audited against (ISPS/SOLAS/ISO 28000) for multi-framework compliance tracking."
    - name: "audit_year"
      expr: DATE_TRUNC('YEAR', audit_date)
      comment: "Year of audit for annual compliance programme performance review."
  measures:
    - name: "total_audits"
      expr: COUNT(1)
      comment: "Total security audits conducted. Baseline KPI for audit programme completeness and ISPS cycle adherence."
    - name: "total_non_conformances"
      expr: SUM(CAST(non_conformances_count AS BIGINT))
      comment: "Total non-conformances identified across all audits. Primary ISPS compliance health KPI — rising trend signals systemic security gaps."
    - name: "total_major_non_conformances"
      expr: SUM(CAST(major_non_conformances_count AS BIGINT))
      comment: "Total major non-conformances — these can trigger ISPS certificate suspension and require immediate executive attention."
    - name: "total_minor_non_conformances"
      expr: SUM(CAST(minor_non_conformances_count AS BIGINT))
      comment: "Total minor non-conformances — tracked separately to distinguish systemic issues from isolated findings."
    - name: "total_audit_cost"
      expr: SUM(CAST(cost AS DOUBLE))
      comment: "Total expenditure on security audits. Informs security compliance budget planning and cost-per-audit benchmarking."
    - name: "avg_audit_cost"
      expr: AVG(CAST(cost AS DOUBLE))
      comment: "Average cost per security audit. Benchmarking KPI for audit programme efficiency."
    - name: "audits_requiring_corrective_action_plan"
      expr: COUNT(CASE WHEN corrective_action_plan_required = TRUE THEN 1 END)
      comment: "Audits that required a formal corrective action plan. Measures the proportion of audits with significant findings."
    - name: "follow_up_audit_count"
      expr: COUNT(CASE WHEN follow_up_audit_required = TRUE THEN 1 END)
      comment: "Audits mandating a follow-up inspection. Elevated count signals persistent non-compliance requiring escalation."
    - name: "total_observations"
      expr: SUM(CAST(observations_count AS BIGINT))
      comment: "Total audit observations (improvement opportunities). Leading indicator of emerging compliance risks before they become non-conformances."
$$;

CREATE OR REPLACE VIEW `vibe_shipping_ports_v1`.`_metrics`.`security_patrol`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Security patrol operational KPIs — coverage compliance, anomaly detection rates, and patrol execution quality. Used by Security Operations Manager to ensure ISPS-mandated patrol frequencies are met and perimeter integrity is maintained."
  source: "`vibe_shipping_ports_v1`.`security`.`patrol`"
  dimensions:
    - name: "patrol_type"
      expr: patrol_type
      comment: "Type of patrol (Foot/Vehicle/Marine/Waterside) for resource allocation and coverage analysis."
    - name: "patrol_status"
      expr: patrol_status
      comment: "Execution status (Completed/Incomplete/Cancelled/In Progress) for compliance rate calculation."
    - name: "marsec_level"
      expr: marsec_level
      comment: "MARSEC level during patrol — measures how patrol intensity scales with threat level."
    - name: "incident_reported_flag"
      expr: incident_reported_flag
      comment: "Whether the patrol resulted in an incident report — measures patrol detection effectiveness."
    - name: "compliance_flag"
      expr: compliance_flag
      comment: "Whether the patrol met all compliance requirements — primary ISPS patrol compliance KPI."
    - name: "perimeter_integrity_flag"
      expr: perimeter_integrity_flag
      comment: "Whether perimeter integrity was confirmed during patrol — critical physical security KPI."
    - name: "patrol_date"
      expr: DATE_TRUNC('DAY', actual_start_time)
      comment: "Date patrol was conducted for daily coverage analysis."
    - name: "patrol_month"
      expr: DATE_TRUNC('MONTH', actual_start_time)
      comment: "Month of patrol for monthly compliance reporting."
  measures:
    - name: "total_patrols"
      expr: COUNT(1)
      comment: "Total patrols conducted. Baseline KPI for patrol programme volume and ISPS frequency compliance."
    - name: "compliant_patrol_count"
      expr: COUNT(CASE WHEN compliance_flag = TRUE THEN 1 END)
      comment: "Patrols meeting all ISPS compliance requirements. Numerator for patrol compliance rate — directly measures ISPS adherence."
    - name: "incident_detected_patrol_count"
      expr: COUNT(CASE WHEN incident_reported_flag = TRUE THEN 1 END)
      comment: "Patrols that detected and reported a security incident. Measures patrol effectiveness as a detection mechanism."
    - name: "perimeter_breach_detected_count"
      expr: COUNT(CASE WHEN perimeter_integrity_flag = FALSE THEN 1 END)
      comment: "Patrols where perimeter integrity was NOT confirmed. Critical physical security KPI — each breach requires immediate investigation."
    - name: "total_distance_covered_km"
      expr: SUM(CAST(distance_covered_km AS DOUBLE))
      comment: "Total patrol distance covered in kilometres. Measures physical coverage of port perimeter and restricted areas."
    - name: "avg_distance_covered_km"
      expr: AVG(CAST(distance_covered_km AS DOUBLE))
      comment: "Average patrol distance per patrol. Benchmarks patrol thoroughness and identifies under-coverage patterns."
    - name: "incomplete_patrol_count"
      expr: COUNT(CASE WHEN patrol_status IN ('Incomplete','Cancelled') THEN 1 END)
      comment: "Patrols not completed as scheduled. Elevated count signals staffing gaps or operational disruptions affecting security coverage."
    - name: "anomaly_detected_patrol_count"
      expr: COUNT(CASE WHEN anomalies_detected IS NOT NULL AND anomalies_detected != '' THEN 1 END)
      comment: "Patrols where anomalies were detected and recorded. Measures patrol sensitivity and officer vigilance."
$$;

CREATE OR REPLACE VIEW `vibe_shipping_ports_v1`.`_metrics`.`security_drill`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "ISPS security drill programme KPIs — drill completion rates, deficiency identification, and compliance status. Used by PFSO to demonstrate ISPS-mandated drill frequency compliance to port state control and flag state inspectors."
  source: "`vibe_shipping_ports_v1`.`security`.`drill`"
  dimensions:
    - name: "drill_type"
      expr: drill_type
      comment: "Type of security drill (Evacuation/Bomb Threat/Piracy/Cyber/Access Control) for programme coverage analysis."
    - name: "drill_status"
      expr: drill_status
      comment: "Execution status (Completed/Planned/Cancelled/Overdue) for programme compliance tracking."
    - name: "compliance_status"
      expr: compliance_status
      comment: "ISPS compliance outcome of the drill (Compliant/Non-Compliant/Partial) — primary regulatory KPI."
    - name: "security_level_during_drill"
      expr: security_level_during_drill
      comment: "Security/MARSEC level at time of drill — validates drills are conducted across all required security levels."
    - name: "drill_month"
      expr: DATE_TRUNC('MONTH', scheduled_date)
      comment: "Month drill was scheduled — for frequency compliance analysis against ISPS quarterly requirements."
    - name: "drill_year"
      expr: DATE_TRUNC('YEAR', scheduled_date)
      comment: "Year of drill for annual programme completeness review."
  measures:
    - name: "total_drills"
      expr: COUNT(1)
      comment: "Total security drills conducted. Baseline KPI for ISPS drill programme completeness."
    - name: "compliant_drill_count"
      expr: COUNT(CASE WHEN compliance_status = 'Compliant' THEN 1 END)
      comment: "Drills achieving full ISPS compliance. Numerator for drill compliance rate — reported to port state control."
    - name: "drills_with_deficiencies"
      expr: COUNT(CASE WHEN deficiencies_identified IS NOT NULL AND deficiencies_identified != '' THEN 1 END)
      comment: "Drills where deficiencies were identified. Measures security preparedness gaps requiring corrective action."
    - name: "cancelled_drill_count"
      expr: COUNT(CASE WHEN drill_status = 'Cancelled' THEN 1 END)
      comment: "Drills cancelled without completion. Cancelled drills may constitute ISPS non-compliance if not rescheduled within the required period."
    - name: "total_participants"
      expr: SUM(CAST(participant_count AS BIGINT))
      comment: "Total personnel participating across all drills. Measures breadth of security preparedness training across the workforce."
    - name: "avg_participants_per_drill"
      expr: AVG(CAST(participant_count AS BIGINT))
      comment: "Average number of participants per drill. Low averages may indicate insufficient staff engagement in security preparedness."
$$;

CREATE OR REPLACE VIEW `vibe_shipping_ports_v1`.`_metrics`.`security_stowaway_case`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Stowaway case management KPIs aligned with IMO FAL Convention and ISPS Code requirements. Used by Port Security Director and Shipping Line Liaison to track stowaway detection, repatriation costs, and security breach patterns."
  source: "`vibe_shipping_ports_v1`.`security`.`stowaway_case`"
  dimensions:
    - name: "case_status"
      expr: case_status
      comment: "Current case status (Open/Under Investigation/Repatriated/Closed) for caseload management."
    - name: "detection_location_type"
      expr: detection_location_type
      comment: "Where the stowaway was detected (Vessel/Terminal/Gate/Yard) — identifies security perimeter weaknesses."
    - name: "detection_method"
      expr: detection_method
      comment: "How the stowaway was detected (Patrol/Screening/Crew Report/K9) — measures detection method effectiveness."
    - name: "security_breach_flag"
      expr: security_breach_flag
      comment: "Whether the case constituted a security breach — triggers ISPS incident reporting obligations."
    - name: "repatriation_status"
      expr: repatriation_status
      comment: "Status of repatriation process — tracks resolution of cases and associated cost liability."
    - name: "detention_status"
      expr: detention_status
      comment: "Current detention status of the stowaway — for humanitarian compliance and immigration authority coordination."
    - name: "detection_month"
      expr: DATE_TRUNC('MONTH', detection_timestamp)
      comment: "Month of stowaway detection for trend analysis and seasonal pattern identification."
  measures:
    - name: "total_stowaway_cases"
      expr: COUNT(1)
      comment: "Total stowaway cases recorded. Baseline KPI for port security perimeter effectiveness — rising trend signals systemic access control failure."
    - name: "security_breach_case_count"
      expr: COUNT(CASE WHEN security_breach_flag = TRUE THEN 1 END)
      comment: "Stowaway cases classified as security breaches. Triggers mandatory ISPS incident reporting and corrective action requirements."
    - name: "total_repatriation_cost"
      expr: SUM(CAST(repatriation_cost_amount AS DOUBLE))
      comment: "Total repatriation costs incurred. Financial liability KPI — costs are typically recoverable from the shipping line under IMO FAL Convention."
    - name: "avg_repatriation_cost_per_case"
      expr: AVG(CAST(repatriation_cost_amount AS DOUBLE))
      comment: "Average repatriation cost per stowaway case. Benchmarks cost recovery claims against shipping lines."
    - name: "open_case_count"
      expr: COUNT(CASE WHEN case_status NOT IN ('Closed','Repatriated') THEN 1 END)
      comment: "Currently open stowaway cases. Operational backlog KPI for immigration authority coordination and resource planning."
    - name: "corrective_action_required_count"
      expr: COUNT(CASE WHEN corrective_action_required_flag = TRUE THEN 1 END)
      comment: "Cases requiring security corrective action. Measures how many stowaway incidents expose systemic security vulnerabilities."
$$;

CREATE OR REPLACE VIEW `vibe_shipping_ports_v1`.`_metrics`.`security_cyber_risk_register`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Cyber risk posture KPIs aligned with IMO MSC-FAL.1/Circ.3 and ISO 27001. Used by CISO and Port Security Director to monitor residual risk exposure, treatment progress, and regulatory compliance of the port's cyber risk register."
  source: "`vibe_shipping_ports_v1`.`security`.`cyber_risk_register`"
  dimensions:
    - name: "risk_category"
      expr: risk_category
      comment: "Cyber risk category (OT/IT/Physical/Supply Chain) for risk portfolio segmentation."
    - name: "inherent_risk_level"
      expr: inherent_risk_level
      comment: "Inherent risk level before controls (Critical/High/Medium/Low) — measures gross exposure."
    - name: "residual_risk_level"
      expr: residual_risk_level
      comment: "Residual risk level after controls — primary KPI for control effectiveness assessment."
    - name: "treatment_status"
      expr: treatment_status
      comment: "Status of risk treatment (In Progress/Completed/Accepted/Not Started) for remediation tracking."
    - name: "imo_msc_428_compliance_flag"
      expr: imo_msc_428_compliance_flag
      comment: "Whether the risk is addressed per IMO MSC-428(98) cyber risk management resolution."
    - name: "iso_27001_alignment_flag"
      expr: iso_27001_alignment_flag
      comment: "Whether the risk treatment aligns with ISO 27001 controls."
    - name: "risk_acceptance_flag"
      expr: risk_acceptance_flag
      comment: "Whether the risk has been formally accepted — accepted high risks require board-level sign-off."
    - name: "cyber_risk_register_status"
      expr: cyber_risk_register_status
      comment: "Overall register entry status (Active/Closed/Under Review) for register hygiene management."
  measures:
    - name: "total_risk_entries"
      expr: COUNT(1)
      comment: "Total cyber risk register entries. Baseline KPI for risk register completeness and coverage."
    - name: "critical_high_residual_risk_count"
      expr: COUNT(CASE WHEN residual_risk_level IN ('Critical','High') THEN 1 END)
      comment: "Risks with Critical or High residual exposure after controls. Executive KPI — each unmitigated high risk represents a potential operational or regulatory liability."
    - name: "accepted_risk_count"
      expr: COUNT(CASE WHEN risk_acceptance_flag = TRUE THEN 1 END)
      comment: "Risks formally accepted rather than mitigated. Elevated count signals risk appetite may be too permissive — requires board visibility."
    - name: "total_financial_impact_estimate"
      expr: SUM(CAST(financial_impact_estimate AS DOUBLE))
      comment: "Total estimated financial impact of all registered cyber risks. Drives cyber insurance coverage and security investment decisions."
    - name: "avg_financial_impact_estimate"
      expr: AVG(CAST(financial_impact_estimate AS DOUBLE))
      comment: "Average financial impact estimate per risk entry. Benchmarks risk severity for prioritisation of treatment investment."
    - name: "overdue_treatment_count"
      expr: COUNT(CASE WHEN treatment_status NOT IN ('Completed','Closed') AND treatment_due_date < CURRENT_DATE THEN 1 END)
      comment: "Risks where treatment is overdue. Critical governance KPI — overdue treatments on high-severity risks may constitute regulatory non-compliance."
    - name: "imo_msc_428_compliant_count"
      expr: COUNT(CASE WHEN imo_msc_428_compliance_flag = TRUE THEN 1 END)
      comment: "Risk entries addressed per IMO MSC-428(98) requirements. Numerator for IMO cyber compliance coverage rate."
    - name: "regulatory_impact_risk_count"
      expr: COUNT(CASE WHEN regulatory_impact_flag = TRUE THEN 1 END)
      comment: "Risks with direct regulatory impact. These require priority treatment and must be reported to maritime authority."
$$;

CREATE OR REPLACE VIEW `vibe_shipping_ports_v1`.`_metrics`.`security_visitor_log`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Visitor access management KPIs for port security — visit volume, screening compliance, restricted area access, and security incident correlation. Used by Security Manager to ensure visitor management meets ISPS access control requirements."
  source: "`vibe_shipping_ports_v1`.`security`.`visitor_log`"
  dimensions:
    - name: "visit_purpose_category"
      expr: visit_purpose_category
      comment: "Category of visit purpose (Maintenance/Inspection/Delivery/Official/Commercial) for access pattern analysis."
    - name: "organization_type"
      expr: organization_type
      comment: "Type of visitor organisation (Government/Contractor/Shipping Line/Vendor) for visitor population segmentation."
    - name: "visit_status"
      expr: visit_status
      comment: "Current visit status (Active/Completed/Overstay/Denied) — overstays are a key security risk indicator."
    - name: "restricted_area_access_flag"
      expr: restricted_area_access_flag
      comment: "Whether the visitor accessed restricted areas — requires enhanced scrutiny and PFSO approval."
    - name: "security_incident_flag"
      expr: security_incident_flag
      comment: "Whether the visit was associated with a security incident — measures visitor-related security risk."
    - name: "escort_required_flag"
      expr: escort_required_flag
      comment: "Whether escort was required for the visit — drives escort officer resource planning."
    - name: "vehicle_entry_flag"
      expr: vehicle_entry_flag
      comment: "Whether the visit involved vehicle entry — used for vehicle access control analysis."
    - name: "visit_date"
      expr: DATE_TRUNC('DAY', entry_timestamp)
      comment: "Date of visitor entry for daily throughput and pattern analysis."
    - name: "visit_month"
      expr: DATE_TRUNC('MONTH', entry_timestamp)
      comment: "Month of visitor entry for monthly trend reporting."
  measures:
    - name: "total_visits"
      expr: COUNT(1)
      comment: "Total visitor log entries. Baseline KPI for visitor access volume and gate throughput planning."
    - name: "security_screening_completed_count"
      expr: COUNT(CASE WHEN security_screening_completed_flag = TRUE THEN 1 END)
      comment: "Visits where security screening was completed. Numerator for visitor screening compliance rate — ISPS requirement."
    - name: "restricted_area_access_count"
      expr: COUNT(CASE WHEN restricted_area_access_flag = TRUE THEN 1 END)
      comment: "Visits involving restricted area access. Elevated count requires review of access authorisation controls."
    - name: "security_incident_associated_count"
      expr: COUNT(CASE WHEN security_incident_flag = TRUE THEN 1 END)
      comment: "Visits associated with a security incident. Measures visitor-related security risk and informs visitor vetting policy."
    - name: "pfso_approval_required_count"
      expr: COUNT(CASE WHEN pfso_approval_required_flag = TRUE THEN 1 END)
      comment: "Visits requiring PFSO approval — measures high-sensitivity access request volume for PFSO workload planning."
    - name: "watchlist_flagged_count"
      expr: COUNT(CASE WHEN watchlist_check_status IN ('Match','Alert') THEN 1 END)
      comment: "Visitors flagged against watchlist during check. Critical security intelligence KPI — each match requires immediate security response."
    - name: "biometric_captured_count"
      expr: COUNT(CASE WHEN biometric_capture_flag = TRUE THEN 1 END)
      comment: "Visits where biometric data was captured. Measures biometric visitor management coverage for enhanced security verification."
$$;

CREATE OR REPLACE VIEW `vibe_shipping_ports_v1`.`_metrics`.`security_marsec_level_change`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "MARSEC level change event KPIs for port security posture management. Used by Port Security Director and PFSO to track threat escalation frequency, response timeliness, and ISPS compliance with MARSEC level change protocols."
  source: "`vibe_shipping_ports_v1`.`security`.`marsec_level_change`"
  dimensions:
    - name: "new_marsec_level"
      expr: new_marsec_level
      comment: "The MARSEC level declared (1/2/3) — primary dimension for threat escalation analysis."
    - name: "previous_marsec_level"
      expr: previous_marsec_level
      comment: "Prior MARSEC level — used to identify escalation vs. de-escalation events."
    - name: "change_reason_code"
      expr: change_reason_code
      comment: "Coded reason for the MARSEC level change — identifies threat drivers (intelligence/incident/exercise)."
    - name: "marsec_level_change_status"
      expr: marsec_level_change_status
      comment: "Status of the change event (Active/Superseded/Expired) for current posture tracking."
    - name: "duration_type"
      expr: duration_type
      comment: "Whether the change is temporary or permanent — informs resource planning for elevated security measures."
    - name: "drill_exercise_flag"
      expr: drill_exercise_flag
      comment: "Whether the change was for a drill/exercise vs. a real threat — separates operational from training events."
    - name: "pfso_acknowledged_flag"
      expr: pfso_acknowledged_flag
      comment: "Whether PFSO acknowledged the change — measures ISPS notification compliance."
    - name: "change_month"
      expr: DATE_TRUNC('MONTH', effective_timestamp)
      comment: "Month the MARSEC change took effect for trend analysis of threat environment."
  measures:
    - name: "total_marsec_changes"
      expr: COUNT(1)
      comment: "Total MARSEC level change events. Baseline KPI for threat environment volatility — high frequency signals elevated regional security risk."
    - name: "marsec_level_2_escalation_count"
      expr: COUNT(CASE WHEN new_marsec_level = '2' THEN 1 END)
      comment: "Escalations to MARSEC Level 2. Each Level 2 declaration triggers enhanced security measures and increased operational costs."
    - name: "marsec_level_3_escalation_count"
      expr: COUNT(CASE WHEN new_marsec_level = '3' THEN 1 END)
      comment: "Escalations to MARSEC Level 3 — the highest threat level. Rare but critical events requiring immediate executive and regulatory notification."
    - name: "real_threat_change_count"
      expr: COUNT(CASE WHEN drill_exercise_flag = FALSE THEN 1 END)
      comment: "MARSEC changes triggered by real threats (not drills). Measures actual threat escalation frequency for security investment justification."
    - name: "pfso_unacknowledged_count"
      expr: COUNT(CASE WHEN pfso_acknowledged_flag = FALSE THEN 1 END)
      comment: "MARSEC changes not yet acknowledged by PFSO. ISPS compliance gap — unacknowledged changes indicate notification protocol failures."
    - name: "active_marsec_change_count"
      expr: COUNT(CASE WHEN marsec_level_change_status = 'Active' THEN 1 END)
      comment: "Currently active MARSEC level changes. Operational KPI for current security posture — should typically be 1 (the current level)."
$$;

CREATE OR REPLACE VIEW `vibe_shipping_ports_v1`.`_metrics`.`security_corrective_action`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Security corrective action tracking KPIs — overdue rates, cost of remediation, and closure effectiveness. Used by PFSO and Security Manager to ensure findings from audits, incidents, and drills are resolved within required timeframes."
  source: "`vibe_shipping_ports_v1`.`security`.`security_corrective_action`"
  dimensions:
    - name: "action_category"
      expr: action_category
      comment: "Category of corrective action (Physical/Procedural/Training/Technical) for remediation type analysis."
    - name: "action_priority"
      expr: action_priority
      comment: "Priority level (Critical/High/Medium/Low) for workload prioritisation and SLA compliance."
    - name: "action_status"
      expr: action_status
      comment: "Current status (Open/In Progress/Completed/Overdue/Cancelled) for backlog management."
    - name: "source_type"
      expr: source_type
      comment: "Source of the corrective action (Audit/Incident/Drill/Threat Assessment) — identifies which security processes generate the most remediation work."
    - name: "overdue_flag"
      expr: overdue_flag
      comment: "Whether the action is past its target completion date — primary SLA compliance KPI."
    - name: "isps_compliance_impact"
      expr: isps_compliance_impact
      comment: "Whether the action has ISPS compliance implications — prioritises actions affecting certification status."
    - name: "security_plan_amendment_required_flag"
      expr: security_plan_amendment_required_flag
      comment: "Whether the action requires a security plan amendment — triggers formal ISPS plan revision process."
    - name: "identified_year"
      expr: DATE_TRUNC('YEAR', identified_date)
      comment: "Year the corrective action was identified for annual remediation performance review."
  measures:
    - name: "total_corrective_actions"
      expr: COUNT(1)
      comment: "Total corrective actions raised. Baseline KPI for security remediation workload volume."
    - name: "overdue_action_count"
      expr: COUNT(CASE WHEN overdue_flag = TRUE THEN 1 END)
      comment: "Corrective actions past their target completion date. Critical governance KPI — overdue ISPS-related actions may trigger certificate suspension."
    - name: "completed_action_count"
      expr: COUNT(CASE WHEN action_status = 'Completed' THEN 1 END)
      comment: "Corrective actions successfully completed. Numerator for closure rate — measures remediation velocity."
    - name: "total_actual_cost"
      expr: SUM(CAST(actual_cost AS DOUBLE))
      comment: "Total actual cost of security corrective actions. Informs security remediation budget and cost-of-non-compliance analysis."
    - name: "total_estimated_cost"
      expr: SUM(CAST(estimated_cost AS DOUBLE))
      comment: "Total estimated cost of all corrective actions. Used for budget forecasting of security remediation programme."
    - name: "avg_actual_cost_per_action"
      expr: AVG(CAST(actual_cost AS DOUBLE))
      comment: "Average actual cost per corrective action. Benchmarks remediation efficiency and identifies cost overrun patterns."
    - name: "security_plan_amendment_required_count"
      expr: COUNT(CASE WHEN security_plan_amendment_required_flag = TRUE THEN 1 END)
      comment: "Actions requiring formal security plan amendment. Each amendment triggers ISPS re-approval process — high count signals plan inadequacy."
    - name: "preventive_action_count"
      expr: COUNT(CASE WHEN preventive_action_flag = TRUE THEN 1 END)
      comment: "Actions classified as preventive (vs. reactive). Higher preventive ratio indicates a mature, proactive security management culture."
$$;