-- Metric views for domain: compliance | Business: Media_Broadcasting | Version: 2 | Generated on: 2026-06-30 04:55:25

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`compliance_audit_finding`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs for audit finding management, remediation tracking, and regulatory risk exposure — used in compliance steering reviews and board risk dashboards."
  source: "`vibe_media_broadcasting_v1`.`compliance`.`audit_finding`"
  dimensions:
    - name: "finding_category"
      expr: finding_category
      comment: "Category of the audit finding for grouping risk areas."
    - name: "severity"
      expr: severity
      comment: "Severity of the finding (critical/high/medium/low)."
    - name: "risk_rating"
      expr: risk_rating
      comment: "Assessed risk rating of the finding."
    - name: "finding_status"
      expr: finding_status
      comment: "Current remediation/lifecycle status of the finding."
    - name: "regulatory_domain"
      expr: regulatory_domain
      comment: "Regulatory domain the finding pertains to."
    - name: "identified_month"
      expr: DATE_TRUNC('MONTH', identified_date)
      comment: "Month the finding was identified for trend analysis."
  measures:
    - name: "Total Findings"
      expr: COUNT(1)
      comment: "Total number of audit findings — baseline volume."
    - name: "Open Findings"
      expr: COUNT(CASE WHEN finding_status NOT IN ('Closed','Resolved','Verified') THEN 1 END)
      comment: "Count of findings not yet closed — open compliance risk backlog."
    - name: "Critical Findings"
      expr: COUNT(CASE WHEN severity = 'Critical' THEN 1 END)
      comment: "Count of critical-severity findings requiring escalation."
    - name: "Recurring Findings"
      expr: COUNT(CASE WHEN recurrence_indicator = TRUE THEN 1 END)
      comment: "Findings flagged as recurring — signals systemic control failure."
    - name: "Total Potential Penalty Exposure"
      expr: SUM(CAST(potential_penalty_amount AS DOUBLE))
      comment: "Aggregate potential financial penalty across findings — risk quantification."
    - name: "Avg Potential Penalty"
      expr: AVG(CAST(potential_penalty_amount AS DOUBLE))
      comment: "Average potential penalty per finding."
    - name: "Distinct Audits With Findings"
      expr: COUNT(DISTINCT audit_id)
      comment: "Number of distinct audits that generated findings."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`compliance_incident`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Compliance incident KPIs covering volume, severity, financial impact, and regulatory notification — core to enterprise risk steering."
  source: "`vibe_media_broadcasting_v1`.`compliance`.`incident`"
  dimensions:
    - name: "incident_type"
      expr: incident_type
      comment: "Type/classification of compliance incident."
    - name: "severity_level"
      expr: severity_level
      comment: "Severity level of the incident."
    - name: "incident_status"
      expr: incident_status
      comment: "Current status of the incident."
    - name: "regulatory_body"
      expr: regulatory_body
      comment: "Regulatory body associated with the incident."
    - name: "recurrence_risk_level"
      expr: recurrence_risk_level
      comment: "Assessed risk of recurrence."
    - name: "incident_month"
      expr: DATE_TRUNC('MONTH', incident_date)
      comment: "Month the incident occurred for trend analysis."
  measures:
    - name: "Total Incidents"
      expr: COUNT(1)
      comment: "Total compliance incidents — baseline volume."
    - name: "Open Incidents"
      expr: COUNT(CASE WHEN incident_status NOT IN ('Closed','Resolved') THEN 1 END)
      comment: "Incidents not yet closed — active risk exposure."
    - name: "Regulatory Notifiable Incidents"
      expr: COUNT(CASE WHEN regulatory_notification_required = TRUE THEN 1 END)
      comment: "Incidents requiring regulatory notification — escalation tracking."
    - name: "Total Financial Impact"
      expr: SUM(CAST(financial_impact_amount AS DOUBLE))
      comment: "Aggregate financial impact of incidents — cost-of-non-compliance quantification."
    - name: "Avg Financial Impact"
      expr: AVG(CAST(financial_impact_amount AS DOUBLE))
      comment: "Average financial impact per incident."
    - name: "Distinct Affected Regulations"
      expr: COUNT(DISTINCT affected_regulation)
      comment: "Breadth of regulations impacted by incidents."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`compliance_broadcast_license`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Broadcast license portfolio KPIs — renewal risk, fee burden, and license status for regulatory compliance steering."
  source: "`vibe_media_broadcasting_v1`.`compliance`.`broadcast_license`"
  dimensions:
    - name: "license_status"
      expr: broadcast_license_status
      comment: "Current status of the broadcast license."
    - name: "license_type"
      expr: license_type
      comment: "Type of broadcast license."
    - name: "license_class"
      expr: license_class
      comment: "License class designation."
    - name: "service_type"
      expr: service_type
      comment: "Broadcast service type."
    - name: "regulatory_authority"
      expr: regulatory_authority
      comment: "Issuing regulatory authority."
    - name: "renewal_status"
      expr: renewal_status
      comment: "Status of the license renewal process."
    - name: "expiration_month"
      expr: DATE_TRUNC('MONTH', expiration_date)
      comment: "Month of license expiration for renewal planning."
  measures:
    - name: "Total Licenses"
      expr: COUNT(1)
      comment: "Total broadcast licenses held — portfolio size."
    - name: "Total Annual Fee Burden"
      expr: SUM(CAST(annual_fee_amount AS DOUBLE))
      comment: "Aggregate annual license fee cost — regulatory cost base."
    - name: "Avg Annual Fee"
      expr: AVG(CAST(annual_fee_amount AS DOUBLE))
      comment: "Average annual fee per license."
    - name: "Licenses Pending Renewal"
      expr: COUNT(CASE WHEN renewal_status = 'Pending' THEN 1 END)
      comment: "Licenses currently in renewal — operational risk if missed."
    - name: "Distinct Communities of License"
      expr: COUNT(DISTINCT community_of_license)
      comment: "Number of distinct communities served — market footprint."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`compliance_accessibility_obligation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Accessibility (captioning/ADA) obligation compliance KPIs — tracks attainment against targets and cost of compliance."
  source: "`vibe_media_broadcasting_v1`.`compliance`.`accessibility_obligation`"
  dimensions:
    - name: "obligation_type"
      expr: obligation_type
      comment: "Type of accessibility obligation."
    - name: "compliance_status"
      expr: compliance_status
      comment: "Current compliance status."
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level of the obligation."
    - name: "geographic_jurisdiction"
      expr: geographic_jurisdiction
      comment: "Jurisdiction governing the obligation."
    - name: "compliance_deadline_month"
      expr: DATE_TRUNC('MONTH', compliance_deadline)
      comment: "Month of compliance deadline for planning."
  measures:
    - name: "Total Obligations"
      expr: COUNT(1)
      comment: "Total accessibility obligations tracked."
    - name: "Avg Compliance Percentage"
      expr: AVG(CAST(compliance_percentage AS DOUBLE))
      comment: "Average attained compliance percentage — accessibility KPI."
    - name: "Avg Target Compliance Percentage"
      expr: AVG(CAST(target_compliance_percentage AS DOUBLE))
      comment: "Average target compliance percentage to benchmark against."
    - name: "Total Estimated Compliance Cost"
      expr: SUM(CAST(estimated_compliance_cost AS DOUBLE))
      comment: "Aggregate estimated cost of meeting obligations."
    - name: "Non Compliant Obligations"
      expr: COUNT(CASE WHEN compliance_status = 'Non-Compliant' THEN 1 END)
      comment: "Obligations not meeting compliance — remediation focus."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`compliance_privacy_request`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Data subject / privacy request (GDPR/CCPA) KPIs — fulfilment SLA performance and processing efficiency for privacy program steering."
  source: "`vibe_media_broadcasting_v1`.`compliance`.`privacy_request`"
  dimensions:
    - name: "request_type"
      expr: request_type
      comment: "Type of privacy request (access/delete/portability)."
    - name: "request_status"
      expr: request_status
      comment: "Current status of the request."
    - name: "fulfillment_status"
      expr: fulfillment_status
      comment: "Fulfilment outcome status."
    - name: "regulatory_framework"
      expr: regulatory_framework
      comment: "Governing privacy framework (GDPR/CCPA)."
    - name: "requestor_jurisdiction"
      expr: requestor_jurisdiction
      comment: "Jurisdiction of the requestor."
    - name: "submission_month"
      expr: DATE_TRUNC('MONTH', submission_timestamp)
      comment: "Month of submission for volume trend analysis."
  measures:
    - name: "Total Privacy Requests"
      expr: COUNT(1)
      comment: "Total privacy requests received."
    - name: "Avg Processing Time Hours"
      expr: AVG(CAST(processing_time_hours AS DOUBLE))
      comment: "Average request processing time — SLA efficiency KPI."
    - name: "Extensions Granted"
      expr: COUNT(CASE WHEN extension_granted = TRUE THEN 1 END)
      comment: "Requests requiring deadline extension — SLA strain indicator."
    - name: "Rejected Requests"
      expr: COUNT(CASE WHEN request_status = 'Rejected' THEN 1 END)
      comment: "Rejected privacy requests — potential complaint/regulatory risk."
    - name: "Total Data Volume Processed"
      expr: SUM(CAST(data_volume_processed AS DOUBLE))
      comment: "Aggregate data volume processed across requests."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`compliance_regulatory_filing`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Regulatory filing KPIs — on-time filing performance, fee burden, and filing volume for compliance operations steering."
  source: "`vibe_media_broadcasting_v1`.`compliance`.`regulatory_filing`"
  dimensions:
    - name: "filing_type"
      expr: filing_type
      comment: "Type of regulatory filing."
    - name: "filing_status"
      expr: filing_status
      comment: "Current status of the filing."
    - name: "compliance_category"
      expr: compliance_category
      comment: "Compliance category of the filing."
    - name: "regulatory_body"
      expr: regulatory_body
      comment: "Regulatory body the filing was submitted to."
    - name: "filing_month"
      expr: DATE_TRUNC('MONTH', filing_date)
      comment: "Month the filing was made for trend analysis."
  measures:
    - name: "Total Filings"
      expr: COUNT(1)
      comment: "Total regulatory filings — operational volume."
    - name: "Total Filing Fees"
      expr: SUM(CAST(filing_fee_amount AS DOUBLE))
      comment: "Aggregate filing fees paid — regulatory cost base."
    - name: "Amendment Filings"
      expr: COUNT(CASE WHEN amendment_flag = TRUE THEN 1 END)
      comment: "Filings that are amendments — rework/quality indicator."
    - name: "Public Inspection Required Filings"
      expr: COUNT(CASE WHEN public_inspection_required = TRUE THEN 1 END)
      comment: "Filings requiring public inspection posting — disclosure obligation tracking."
    - name: "Distinct Regulatory Bodies"
      expr: COUNT(DISTINCT regulatory_body)
      comment: "Breadth of regulatory bodies engaged."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`compliance_closed_caption_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Closed captioning quality and compliance KPIs — caption accuracy, completeness, and complaint tracking for accessibility compliance."
  source: "`vibe_media_broadcasting_v1`.`compliance`.`closed_caption_record`"
  dimensions:
    - name: "caption_type"
      expr: caption_type
      comment: "Type of caption (live/offline/etc)."
    - name: "compliance_status"
      expr: compliance_status
      comment: "Caption compliance status."
    - name: "language_code"
      expr: language_code
      comment: "Language of the captions."
    - name: "remediation_status"
      expr: remediation_status
      comment: "Status of remediation for caption defects."
    - name: "air_month"
      expr: DATE_TRUNC('MONTH', air_date)
      comment: "Month the captioned content aired."
  measures:
    - name: "Total Caption Records"
      expr: COUNT(1)
      comment: "Total caption records — coverage volume."
    - name: "Avg Caption Accuracy Score"
      expr: AVG(CAST(caption_accuracy_score AS DOUBLE))
      comment: "Average caption accuracy — quality KPI tied to FCC compliance."
    - name: "Avg Caption Completeness Pct"
      expr: AVG(CAST(caption_completeness_percentage AS DOUBLE))
      comment: "Average caption completeness percentage."
    - name: "Avg Caption Latency Seconds"
      expr: AVG(CAST(caption_latency_seconds AS DOUBLE))
      comment: "Average caption latency — live captioning quality indicator."
    - name: "Complaints Received"
      expr: COUNT(CASE WHEN complaint_received_date IS NOT NULL THEN 1 END)
      comment: "Records with associated complaints — accessibility risk signal."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`compliance_anti_piracy_takedown`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Anti-piracy takedown KPIs — revenue-loss exposure, takedown effectiveness, and infringement volume for content protection steering."
  source: "`vibe_media_broadcasting_v1`.`compliance`.`anti_piracy_takedown`"
  dimensions:
    - name: "takedown_status"
      expr: takedown_status
      comment: "Status of the takedown request."
    - name: "takedown_type"
      expr: takedown_type
      comment: "Type of takedown action."
    - name: "detection_method"
      expr: detection_method
      comment: "Method by which infringement was detected."
    - name: "infringing_platform"
      expr: infringing_platform
      comment: "Platform hosting the infringing content."
    - name: "request_month"
      expr: DATE_TRUNC('MONTH', takedown_request_date)
      comment: "Month the takedown was requested."
  measures:
    - name: "Total Takedowns"
      expr: COUNT(1)
      comment: "Total takedown actions — anti-piracy activity volume."
    - name: "Total Estimated Revenue Loss"
      expr: SUM(CAST(estimated_revenue_loss_amount AS DOUBLE))
      comment: "Aggregate estimated revenue loss from piracy — financial risk quantification."
    - name: "Total Estimated Pirated Views"
      expr: SUM(CAST(estimated_views AS DOUBLE))
      comment: "Aggregate estimated pirated views — exposure scale."
    - name: "Counter Notices Received"
      expr: COUNT(CASE WHEN counter_notice_received_flag = TRUE THEN 1 END)
      comment: "Takedowns met with counter-notice — legal escalation signal."
    - name: "Legal Action Required Count"
      expr: COUNT(CASE WHEN legal_action_required_flag = TRUE THEN 1 END)
      comment: "Cases escalated to legal action."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`compliance_facility_compliance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Facility-level compliance KPIs — compliance scoring, violation tracking, and fine exposure across broadcast facilities."
  source: "`vibe_media_broadcasting_v1`.`compliance`.`facility_compliance`"
  dimensions:
    - name: "compliance_category"
      expr: compliance_category
      comment: "Category of facility compliance."
    - name: "compliance_status"
      expr: compliance_status
      comment: "Current compliance status of the facility."
    - name: "compliance_type"
      expr: compliance_type
      comment: "Type of compliance assessed."
    - name: "inspection_result"
      expr: inspection_result
      comment: "Result of the most recent inspection."
    - name: "next_audit_month"
      expr: DATE_TRUNC('MONTH', next_audit_date)
      comment: "Month of next scheduled audit for planning."
  measures:
    - name: "Total Facility Compliance Records"
      expr: COUNT(1)
      comment: "Total facility compliance assessments."
    - name: "Avg Compliance Score"
      expr: AVG(CAST(compliance_score AS DOUBLE))
      comment: "Average facility compliance score — overall health KPI."
    - name: "Total Fine Exposure"
      expr: SUM(CAST(fine_amount AS DOUBLE))
      comment: "Aggregate fines levied — cost of non-compliance."
    - name: "Corrective Actions Required"
      expr: COUNT(CASE WHEN corrective_action_required = TRUE THEN 1 END)
      comment: "Facilities requiring corrective action — remediation backlog."
    - name: "Distinct Facilities"
      expr: COUNT(DISTINCT broadcast_facility_id)
      comment: "Number of distinct facilities under compliance review."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`compliance_sox_control`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "SOX control effectiveness KPIs — control testing outcomes, deficiency tracking, and key-control coverage for financial compliance."
  source: "`vibe_media_broadcasting_v1`.`compliance`.`sox_control`"
  dimensions:
    - name: "control_type"
      expr: control_type
      comment: "Type of SOX control (preventive/detective)."
    - name: "control_status"
      expr: control_status
      comment: "Operational status of the control."
    - name: "test_result"
      expr: test_result
      comment: "Most recent test result for the control."
    - name: "risk_rating"
      expr: risk_rating
      comment: "Risk rating associated with the control."
    - name: "process_area"
      expr: process_area
      comment: "Business process area the control governs."
    - name: "last_test_month"
      expr: DATE_TRUNC('MONTH', last_test_date)
      comment: "Month the control was last tested."
  measures:
    - name: "Total Controls"
      expr: COUNT(1)
      comment: "Total SOX controls in scope."
    - name: "Key Controls"
      expr: COUNT(CASE WHEN key_control_flag = TRUE THEN 1 END)
      comment: "Count of key controls — focus of audit attention."
    - name: "Automated Controls"
      expr: COUNT(CASE WHEN automated_flag = TRUE THEN 1 END)
      comment: "Automated controls — efficiency/reliability indicator."
    - name: "Failed Test Controls"
      expr: COUNT(CASE WHEN test_result = 'Fail' THEN 1 END)
      comment: "Controls failing testing — material weakness risk."
    - name: "Controls With Deficiency"
      expr: COUNT(CASE WHEN deficiency_classification IS NOT NULL THEN 1 END)
      comment: "Controls with identified deficiencies — remediation focus."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`compliance_audit`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Compliance audit program KPIs — audit volume, cost, and outcomes for the internal/external audit function."
  source: "`vibe_media_broadcasting_v1`.`compliance`.`audit`"
  dimensions:
    - name: "audit_type"
      expr: audit_type
      comment: "Type of audit performed."
    - name: "audit_status"
      expr: audit_status
      comment: "Current status of the audit."
    - name: "compliance_rating"
      expr: compliance_rating
      comment: "Overall compliance rating assigned by the audit."
    - name: "regulatory_framework"
      expr: regulatory_framework
      comment: "Regulatory framework the audit assesses against."
    - name: "remediation_status"
      expr: remediation_status
      comment: "Status of remediation arising from the audit."
    - name: "scheduled_start_month"
      expr: DATE_TRUNC('MONTH', scheduled_start_date)
      comment: "Month the audit was scheduled to start."
  measures:
    - name: "Total Audits"
      expr: COUNT(1)
      comment: "Total audits conducted — audit program volume."
    - name: "Total Audit Cost"
      expr: SUM(CAST(cost AS DOUBLE))
      comment: "Aggregate audit cost — audit program spend."
    - name: "Avg Audit Cost"
      expr: AVG(CAST(cost AS DOUBLE))
      comment: "Average cost per audit."
    - name: "Audits Requiring Follow Up"
      expr: COUNT(CASE WHEN follow_up_audit_required = TRUE THEN 1 END)
      comment: "Audits requiring follow-up — unresolved risk indicator."
    - name: "Distinct Auditor Organizations"
      expr: COUNT(DISTINCT auditor_organization)
      comment: "Number of distinct auditing organizations engaged."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`compliance_license_renewal`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Broadcast license renewal KPIs — renewal outcomes, fee burden, and petition risk for license portfolio steering."
  source: "`vibe_media_broadcasting_v1`.`compliance`.`license_renewal`"
  dimensions:
    - name: "renewal_status"
      expr: renewal_status
      comment: "Status of the renewal application."
    - name: "license_type"
      expr: license_type
      comment: "Type of license being renewed."
    - name: "regulatory_body"
      expr: regulatory_body
      comment: "Regulatory body handling the renewal."
    - name: "final_disposition"
      expr: final_disposition
      comment: "Final disposition of the renewal."
    - name: "filing_deadline_month"
      expr: DATE_TRUNC('MONTH', filing_deadline)
      comment: "Month of the renewal filing deadline."
  measures:
    - name: "Total Renewals"
      expr: COUNT(1)
      comment: "Total license renewal cases."
    - name: "Total Renewal Fees"
      expr: SUM(CAST(renewal_fee_amount AS DOUBLE))
      comment: "Aggregate renewal fees — renewal cost base."
    - name: "Renewals With Petitions To Deny"
      expr: COUNT(CASE WHEN petition_to_deny_filed = TRUE THEN 1 END)
      comment: "Renewals facing petitions to deny — regulatory risk signal."
    - name: "Denied Renewals"
      expr: COUNT(CASE WHEN denial_date IS NOT NULL THEN 1 END)
      comment: "Renewals denied — license-loss risk."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`compliance_political_ad_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Political advertising compliance KPIs — rate charged, equal-opportunity, and public-file disclosure tracking for FCC political ad rules."
  source: "`vibe_media_broadcasting_v1`.`compliance`.`political_ad_record`"
  dimensions:
    - name: "advertiser_type"
      expr: advertiser_type
      comment: "Type of political advertiser."
    - name: "election_type"
      expr: election_type
      comment: "Type of election the ad relates to."
    - name: "jurisdiction_level"
      expr: jurisdiction_level
      comment: "Jurisdiction level (federal/state/local)."
    - name: "compliance_status"
      expr: compliance_status
      comment: "Compliance status of the political ad record."
    - name: "air_month"
      expr: DATE_TRUNC('MONTH', air_date)
      comment: "Month the political ad aired."
  measures:
    - name: "Total Political Ad Records"
      expr: COUNT(1)
      comment: "Total political ad compliance records."
    - name: "Total Rate Charged"
      expr: SUM(CAST(rate_charged AS DOUBLE))
      comment: "Aggregate rate charged for political ads — LUC compliance revenue tracking."
    - name: "Avg LUC Rate"
      expr: AVG(CAST(luc_rate AS DOUBLE))
      comment: "Average lowest-unit-charge rate — political ad pricing compliance KPI."
    - name: "Equal Opportunity Requests"
      expr: COUNT(CASE WHEN equal_opportunities_request_flag = TRUE THEN 1 END)
      comment: "Records with equal-opportunity requests — FCC obligation tracking."
    - name: "Preempted Spots"
      expr: COUNT(CASE WHEN preemption_flag = TRUE THEN 1 END)
      comment: "Political spots preempted — makegood/compliance risk."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`compliance_eas_log`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Emergency Alert System KPIs — alert transmission compliance and failure tracking for EAS regulatory obligations."
  source: "`vibe_media_broadcasting_v1`.`compliance`.`eas_log`"
  dimensions:
    - name: "alert_type"
      expr: alert_type
      comment: "Type of EAS alert."
    - name: "compliance_status"
      expr: compliance_status
      comment: "Compliance status of the alert handling."
    - name: "transmission_status"
      expr: transmission_status
      comment: "Transmission status of the alert."
    - name: "test_compliance_type"
      expr: test_compliance_type
      comment: "Type of test compliance (RWT/RMT)."
    - name: "alert_month"
      expr: DATE_TRUNC('MONTH', alert_timestamp)
      comment: "Month of the alert for trend analysis."
  measures:
    - name: "Total EAS Events"
      expr: COUNT(1)
      comment: "Total EAS log events — activity volume."
    - name: "Failed Transmissions"
      expr: COUNT(CASE WHEN transmission_status = 'Failed' THEN 1 END)
      comment: "Failed alert transmissions — compliance failure risk."
    - name: "CAP Messages Received"
      expr: COUNT(CASE WHEN cap_message_received = TRUE THEN 1 END)
      comment: "Alerts received via CAP — IPAWS compliance indicator."
    - name: "Public File Entries"
      expr: COUNT(CASE WHEN public_inspection_file_entry = TRUE THEN 1 END)
      comment: "Events logged to public inspection file — disclosure compliance."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`compliance_content_rating`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Content rating compliance KPIs — rating fees, COPPA compliance, and rating outcomes for content classification governance."
  source: "`vibe_media_broadcasting_v1`.`compliance`.`content_rating`"
  dimensions:
    - name: "rating_system"
      expr: rating_system
      comment: "Rating system used (TV/MPAA/ESRB)."
    - name: "rating_status"
      expr: rating_status
      comment: "Status of the rating."
    - name: "rating_authority"
      expr: rating_authority
      comment: "Authority that issued the rating."
    - name: "territory_code"
      expr: territory_code
      comment: "Territory the rating applies to."
    - name: "rating_month"
      expr: DATE_TRUNC('MONTH', rating_date)
      comment: "Month the rating was assigned."
  measures:
    - name: "Total Ratings"
      expr: COUNT(1)
      comment: "Total content ratings issued."
    - name: "Total Rating Fees"
      expr: SUM(CAST(rating_fee_amount AS DOUBLE))
      comment: "Aggregate rating fees — classification cost base."
    - name: "COPPA Compliant Ratings"
      expr: COUNT(CASE WHEN coppa_compliant = TRUE THEN 1 END)
      comment: "Ratings flagged COPPA-compliant — child-protection compliance tracking."
    - name: "Ratings Under Appeal"
      expr: COUNT(CASE WHEN appeal_status = 'Pending' THEN 1 END)
      comment: "Ratings under appeal — classification dispute indicator."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`compliance_audit_costs`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Cost and volume metrics for compliance audits"
  source: "`vibe_media_broadcasting_v1`.`compliance`.`audit`"
  dimensions:
    - name: "audit_type"
      expr: audit_type
      comment: "Classification of audit (e.g., internal, external)"
    - name: "audit_status"
      expr: audit_status
      comment: "Current status of the audit"
    - name: "audit_year"
      expr: DATE_TRUNC('year', created_timestamp)
      comment: "Year the audit was created"
  measures:
    - name: "audit_count"
      expr: COUNT(1)
      comment: "Number of audit records"
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`compliance_audit_finding_penalties`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Financial risk exposure from audit findings"
  source: "`vibe_media_broadcasting_v1`.`compliance`.`audit_finding`"
  dimensions:
    - name: "severity"
      expr: severity
      comment: "Severity level of the finding"
    - name: "risk_rating"
      expr: risk_rating
      comment: "Risk rating assigned to the finding"
    - name: "finding_status"
      expr: finding_status
      comment: "Current status of the finding"
    - name: "audit_type"
      expr: audit_type
      comment: "Audit type associated with the finding"
    - name: "finding_year"
      expr: DATE_TRUNC('year', created_timestamp)
      comment: "Year the finding was recorded"
  measures:
    - name: "total_potential_penalty"
      expr: SUM(CAST(potential_penalty_amount AS DOUBLE))
      comment: "Sum of potential penalties across audit findings"
    - name: "avg_potential_penalty"
      expr: AVG(CAST(potential_penalty_amount AS DOUBLE))
      comment: "Average potential penalty per finding"
    - name: "finding_count"
      expr: COUNT(1)
      comment: "Number of audit findings"
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`compliance_broadcast_license_fee`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Financial and technical metrics for broadcast licenses"
  source: "`vibe_media_broadcasting_v1`.`compliance`.`broadcast_license`"
  dimensions:
    - name: "license_status"
      expr: broadcast_license_status
      comment: "Current status of the license"
    - name: "jurisdiction_country_code"
      expr: jurisdiction_country_code
      comment: "Country code of the licensing jurisdiction"
    - name: "service_type"
      expr: service_type
      comment: "Type of broadcast service provided"
    - name: "effective_year"
      expr: DATE_TRUNC('year', effective_date)
      comment: "Year the license became effective"
  measures:
    - name: "total_annual_fee"
      expr: SUM(CAST(annual_fee_amount AS DOUBLE))
      comment: "Total annual fees across broadcast licenses"
    - name: "avg_power_output"
      expr: AVG(CAST(power_output_erp_watts AS DOUBLE))
      comment: "Average ERP power output (watts) of broadcast facilities"
    - name: "license_count"
      expr: COUNT(1)
      comment: "Number of broadcast licenses"
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`compliance_incident_financial_impact`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Financial impact assessment of compliance incidents"
  source: "`vibe_media_broadcasting_v1`.`compliance`.`incident`"
  dimensions:
    - name: "severity_level"
      expr: severity_level
      comment: "Severity level of the incident"
    - name: "incident_type"
      expr: incident_type
      comment: "Classification of the incident"
    - name: "regulatory_body"
      expr: regulatory_body
      comment: "Regulatory authority involved"
    - name: "incident_year"
      expr: DATE_TRUNC('year', incident_date)
      comment: "Year the incident occurred"
  measures:
    - name: "total_financial_impact"
      expr: SUM(CAST(financial_impact_amount AS DOUBLE))
      comment: "Total financial impact from compliance incidents"
    - name: "incident_count"
      expr: COUNT(1)
      comment: "Number of compliance incidents recorded"
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`compliance_license_renewal_fees`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Financial metrics for broadcast license renewals"
  source: "`vibe_media_broadcasting_v1`.`compliance`.`license_renewal`"
  dimensions:
    - name: "renewal_status"
      expr: renewal_status
      comment: "Current status of the renewal process"
    - name: "regulatory_body"
      expr: regulatory_body
      comment: "Regulatory authority overseeing the renewal"
    - name: "renewal_year"
      expr: DATE_TRUNC('year', renewal_cycle_start_date)
      comment: "Year the renewal cycle started"
  measures:
    - name: "total_renewal_fee"
      expr: SUM(CAST(renewal_fee_amount AS DOUBLE))
      comment: "Total renewal fees paid for broadcast licenses"
    - name: "avg_renewal_fee"
      expr: AVG(CAST(renewal_fee_amount AS DOUBLE))
      comment: "Average renewal fee per license"
    - name: "renewal_count"
      expr: COUNT(1)
      comment: "Number of license renewal records"
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`compliance_privacy_requests_volume`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Operational metrics for privacy request handling"
  source: "`vibe_media_broadcasting_v1`.`compliance`.`privacy_request`"
  dimensions:
    - name: "request_type"
      expr: request_type
      comment: "Type of privacy request (e.g., access, deletion)"
    - name: "request_status"
      expr: request_status
      comment: "Current status of the request"
    - name: "regulatory_framework"
      expr: regulatory_framework
      comment: "Regulatory framework governing the request (e.g., GDPR, CCPA)"
    - name: "request_year"
      expr: DATE_TRUNC('year', created_timestamp)
      comment: "Year the request was created"
  measures:
    - name: "total_requests"
      expr: COUNT(1)
      comment: "Total number of privacy requests received"
    - name: "total_data_volume_gb"
      expr: SUM(CAST(data_volume_processed AS DOUBLE))
      comment: "Total data volume processed for privacy requests (GB)"
    - name: "avg_processing_time_hours"
      expr: AVG(CAST(processing_time_hours AS DOUBLE))
      comment: "Average processing time per request (hours)"
$$;