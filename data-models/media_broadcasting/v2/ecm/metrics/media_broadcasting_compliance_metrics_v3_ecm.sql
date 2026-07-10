-- Metric views for domain: compliance | Business: Media_Broadcasting | Version: 3 | Generated on: 2026-07-10 19:06:42

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`compliance_incident`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Operational KPIs for compliance incidents — tracks severity distribution, financial exposure, corrective action timeliness, and regulatory notification compliance. Used by Chief Compliance Officer and Legal to steer remediation priorities and assess regulatory risk."
  source: "`vibe_media_broadcasting_v1`.`compliance`.`incident`"
  dimensions:
    - name: "incident_type"
      expr: incident_type
      comment: "Category of compliance incident (e.g., EAS failure, closed captioning, political ad) for segmenting risk exposure."
    - name: "severity_level"
      expr: severity_level
      comment: "Severity classification of the incident (Critical, High, Medium, Low) for prioritization dashboards."
    - name: "incident_status"
      expr: incident_status
      comment: "Current lifecycle status of the incident (Open, In Remediation, Closed) for operational tracking."
    - name: "regulatory_body"
      expr: regulatory_body
      comment: "Regulatory authority associated with the incident (e.g., FCC, FTC) for jurisdiction-level reporting."
    - name: "corrective_action_status"
      expr: corrective_action_status
      comment: "Status of the corrective action plan to monitor remediation progress."
    - name: "incident_date_month"
      expr: DATE_TRUNC('MONTH', incident_date)
      comment: "Month of incident occurrence for trend analysis over time."
    - name: "escalation_status"
      expr: escalation_status
      comment: "Whether the incident has been escalated, for governance oversight."
    - name: "regulatory_notification_required"
      expr: regulatory_notification_required
      comment: "Flag indicating whether regulatory notification is mandated, for compliance obligation tracking."
  measures:
    - name: "total_incidents"
      expr: COUNT(1)
      comment: "Total number of compliance incidents. Baseline KPI for incident volume trending and capacity planning."
    - name: "total_financial_impact"
      expr: SUM(CAST(financial_impact_amount AS DOUBLE))
      comment: "Total financial exposure from compliance incidents. Directly informs risk reserve and insurance decisions at the CFO level."
    - name: "avg_financial_impact_per_incident"
      expr: AVG(CAST(financial_impact_amount AS DOUBLE))
      comment: "Average financial impact per incident. Used to benchmark incident cost and prioritize high-cost incident types."
    - name: "open_incidents"
      expr: COUNT(CASE WHEN incident_status = 'Open' THEN 1 END)
      comment: "Count of currently open incidents. A rising open count signals remediation backlog requiring executive intervention."
    - name: "critical_incidents"
      expr: COUNT(CASE WHEN severity_level = 'Critical' THEN 1 END)
      comment: "Count of critical-severity incidents. Directly triggers board-level escalation and regulatory response protocols."
    - name: "regulatory_notification_compliance_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN regulatory_notification_required = TRUE AND regulatory_notification_date IS NOT NULL THEN 1 END) / NULLIF(COUNT(CASE WHEN regulatory_notification_required = TRUE THEN 1 END), 0), 2)
      comment: "Percentage of required regulatory notifications that were actually filed. A drop below threshold triggers FCC enforcement risk."
    - name: "overdue_corrective_actions"
      expr: COUNT(CASE WHEN corrective_action_status NOT IN ('Completed', 'Closed') AND corrective_action_due_date < CURRENT_DATE() THEN 1 END)
      comment: "Count of corrective actions past their due date. Directly measures remediation discipline and regulatory exposure."
    - name: "recurrence_risk_incidents"
      expr: COUNT(CASE WHEN recurrence_risk_level IN ('High', 'Critical') THEN 1 END)
      comment: "Count of incidents with high or critical recurrence risk. Informs systemic process improvement investment decisions."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`compliance_audit_finding`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs for audit findings — tracks finding severity, remediation velocity, recurrence, and financial penalty exposure. Used by Internal Audit, Compliance, and CFO to assess control environment health and prioritize remediation investment."
  source: "`vibe_media_broadcasting_v1`.`compliance`.`audit_finding`"
  dimensions:
    - name: "finding_category"
      expr: finding_category
      comment: "Category of the audit finding (e.g., Technical, Financial, Operational) for thematic analysis."
    - name: "severity"
      expr: severity
      comment: "Severity level of the finding (Critical, High, Medium, Low) for risk prioritization."
    - name: "finding_status"
      expr: finding_status
      comment: "Current status of the finding (Open, In Remediation, Verified, Closed) for lifecycle tracking."
    - name: "audit_type"
      expr: audit_type
      comment: "Type of audit that generated the finding (Internal, External, Regulatory) for governance segmentation."
    - name: "regulatory_domain"
      expr: regulatory_domain
      comment: "Regulatory domain associated with the finding (e.g., FCC, SOX, COPPA) for compliance program reporting."
    - name: "verification_status"
      expr: verification_status
      comment: "Whether the remediation has been independently verified, for audit closure quality control."
    - name: "identified_date_month"
      expr: DATE_TRUNC('MONTH', identified_date)
      comment: "Month the finding was identified for trend analysis."
    - name: "risk_rating"
      expr: risk_rating
      comment: "Risk rating assigned to the finding for enterprise risk management reporting."
  measures:
    - name: "total_findings"
      expr: COUNT(1)
      comment: "Total audit findings. Baseline volume metric for audit program effectiveness and control environment health."
    - name: "critical_findings"
      expr: COUNT(CASE WHEN severity = 'Critical' THEN 1 END)
      comment: "Count of critical-severity findings. Directly triggers board audit committee escalation."
    - name: "open_findings"
      expr: COUNT(CASE WHEN finding_status = 'Open' THEN 1 END)
      comment: "Count of unresolved open findings. A growing backlog signals control environment deterioration."
    - name: "total_potential_penalty_exposure"
      expr: SUM(CAST(potential_penalty_amount AS DOUBLE))
      comment: "Total potential financial penalty exposure from open findings. Directly informs legal reserve and risk management decisions."
    - name: "avg_potential_penalty_per_finding"
      expr: AVG(CAST(potential_penalty_amount AS DOUBLE))
      comment: "Average penalty exposure per finding. Used to benchmark finding cost and prioritize high-risk remediation."
    - name: "recurrent_findings"
      expr: COUNT(CASE WHEN recurrence_indicator = TRUE THEN 1 END)
      comment: "Count of findings that are recurrences of prior issues. High recurrence signals systemic control failures requiring structural investment."
    - name: "overdue_findings"
      expr: COUNT(CASE WHEN finding_status NOT IN ('Closed', 'Verified') AND target_resolution_date < CURRENT_DATE() THEN 1 END)
      comment: "Count of findings past their target resolution date. Measures remediation discipline and regulatory exposure."
    - name: "verified_remediation_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN verification_status = 'Verified' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of findings with independently verified remediation. A key audit quality KPI for the audit committee."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`compliance_regulatory_filing`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs for regulatory filings — tracks on-time filing rates, fee exposure, amendment rates, and filing status distribution. Used by Regulatory Affairs and Legal to ensure FCC and other regulatory deadlines are met and penalties avoided."
  source: "`vibe_media_broadcasting_v1`.`compliance`.`regulatory_filing`"
  dimensions:
    - name: "filing_type"
      expr: filing_type
      comment: "Type of regulatory filing (e.g., License Renewal, Annual Report, Political File) for program-level tracking."
    - name: "filing_status"
      expr: filing_status
      comment: "Current status of the filing (Pending, Submitted, Approved, Rejected) for operational monitoring."
    - name: "regulatory_body"
      expr: regulatory_body
      comment: "Regulatory authority receiving the filing (e.g., FCC, FTC) for jurisdiction-level compliance reporting."
    - name: "compliance_category"
      expr: compliance_category
      comment: "Compliance category of the filing for thematic analysis across the compliance program."
    - name: "submission_method"
      expr: submission_method
      comment: "How the filing was submitted (Electronic, Paper, Portal) for process efficiency analysis."
    - name: "filing_date_month"
      expr: DATE_TRUNC('MONTH', filing_date)
      comment: "Month of filing for trend and seasonality analysis."
    - name: "amendment_flag"
      expr: amendment_flag
      comment: "Whether the filing is an amendment to a prior submission, for amendment rate tracking."
    - name: "sox_applicable"
      expr: sox_applicable
      comment: "Whether SOX requirements apply to this filing, for SOX compliance program scoping."
  measures:
    - name: "total_filings"
      expr: COUNT(1)
      comment: "Total regulatory filings submitted. Baseline volume metric for regulatory affairs workload and program coverage."
    - name: "on_time_filing_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN filing_date <= due_date THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of filings submitted on or before the regulatory deadline. A drop below 100% directly triggers penalty risk and FCC enforcement."
    - name: "late_filings"
      expr: COUNT(CASE WHEN filing_date > due_date THEN 1 END)
      comment: "Count of filings submitted after the regulatory deadline. Each late filing represents direct regulatory penalty exposure."
    - name: "total_filing_fees"
      expr: SUM(CAST(filing_fee_amount AS DOUBLE))
      comment: "Total regulatory filing fees paid. Informs compliance budget planning and cost allocation."
    - name: "avg_filing_fee"
      expr: AVG(CAST(filing_fee_amount AS DOUBLE))
      comment: "Average filing fee per submission. Used for per-filing cost benchmarking and budget forecasting."
    - name: "rejected_filings"
      expr: COUNT(CASE WHEN filing_status = 'Rejected' THEN 1 END)
      comment: "Count of rejected filings. Rejections require resubmission and may trigger late penalties — a key quality metric."
    - name: "amendment_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN amendment_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of filings that are amendments. High amendment rates signal data quality or process issues in initial submissions."
    - name: "pending_filings"
      expr: COUNT(CASE WHEN filing_status = 'Pending' THEN 1 END)
      comment: "Count of filings not yet submitted. Tracks outstanding regulatory obligations requiring immediate action."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`compliance_broadcast_license`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs for broadcast license portfolio health — tracks license status, renewal pipeline, EAS and closed captioning obligations, and fee exposure. Used by Regulatory Affairs and Station Management to ensure continuous broadcast authorization."
  source: "`vibe_media_broadcasting_v1`.`compliance`.`broadcast_license`"
  dimensions:
    - name: "broadcast_license_status"
      expr: broadcast_license_status
      comment: "Current status of the broadcast license (Active, Expired, Pending Renewal, Revoked) for portfolio health monitoring."
    - name: "license_type"
      expr: license_type
      comment: "Type of broadcast license (Full Power, Low Power, Translator, etc.) for regulatory category analysis."
    - name: "service_type"
      expr: service_type
      comment: "Broadcast service type (AM, FM, TV, Digital) for spectrum and service portfolio analysis."
    - name: "jurisdiction_country_code"
      expr: jurisdiction_country_code
      comment: "Country jurisdiction of the license for multi-market regulatory reporting."
    - name: "renewal_status"
      expr: renewal_status
      comment: "Status of the license renewal process for pipeline management and deadline tracking."
    - name: "frequency_band"
      expr: frequency_band
      comment: "Frequency band of the license for spectrum management analysis."
    - name: "license_class"
      expr: license_class
      comment: "License class for regulatory tier analysis."
    - name: "expiration_date_month"
      expr: DATE_TRUNC('MONTH', expiration_date)
      comment: "Month of license expiration for renewal pipeline planning."
  measures:
    - name: "total_licenses"
      expr: COUNT(1)
      comment: "Total broadcast licenses in the portfolio. Baseline for license portfolio management and regulatory coverage."
    - name: "active_licenses"
      expr: COUNT(CASE WHEN broadcast_license_status = 'Active' THEN 1 END)
      comment: "Count of currently active broadcast licenses. A drop signals immediate broadcast authorization risk."
    - name: "expiring_within_90_days"
      expr: COUNT(CASE WHEN expiration_date BETWEEN CURRENT_DATE() AND DATE_ADD(CURRENT_DATE(), 90) THEN 1 END)
      comment: "Licenses expiring within 90 days. Critical pipeline metric for renewal prioritization — missed renewals result in broadcast shutdown."
    - name: "total_annual_license_fees"
      expr: SUM(CAST(annual_fee_amount AS DOUBLE))
      comment: "Total annual regulatory fees across the license portfolio. Informs compliance budget and cost allocation decisions."
    - name: "avg_annual_license_fee"
      expr: AVG(CAST(annual_fee_amount AS DOUBLE))
      comment: "Average annual fee per license. Used for per-license cost benchmarking and portfolio cost analysis."
    - name: "eas_participation_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN eas_participation_required = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of licenses with EAS participation requirements. Informs EAS compliance program scope and resource allocation."
    - name: "closed_captioning_obligation_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN closed_captioning_required = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of licenses with closed captioning requirements. Scopes the accessibility compliance program."
    - name: "licenses_pending_renewal"
      expr: COUNT(CASE WHEN renewal_status IN ('Pending', 'In Progress', 'Filed') THEN 1 END)
      comment: "Count of licenses currently in the renewal process. Tracks renewal pipeline workload for Regulatory Affairs staffing."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`compliance_eas_log`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs for Emergency Alert System (EAS) compliance — tracks transmission success rates, test compliance, alert type distribution, and failure patterns. Used by Engineering and Compliance to ensure FCC-mandated EAS obligations are met."
  source: "`vibe_media_broadcasting_v1`.`compliance`.`eas_log`"
  dimensions:
    - name: "alert_type"
      expr: alert_type
      comment: "Type of EAS alert (National, State, Local, Test) for compliance obligation segmentation."
    - name: "transmission_status"
      expr: transmission_status
      comment: "Whether the EAS alert was successfully transmitted, for compliance rate calculation."
    - name: "compliance_status"
      expr: compliance_status
      comment: "Compliance determination for the EAS event (Compliant, Non-Compliant, Pending Review)."
    - name: "test_compliance_type"
      expr: test_compliance_type
      comment: "Type of EAS test (Weekly, Monthly, National Periodic Test) for test-specific compliance tracking."
    - name: "event_code"
      expr: event_code
      comment: "EAS event code for alert category analysis and regulatory reporting."
    - name: "alert_timestamp_month"
      expr: DATE_TRUNC('MONTH', alert_timestamp)
      comment: "Month of the EAS alert for trend analysis and periodic test compliance reporting."
    - name: "originator_code"
      expr: originator_code
      comment: "EAS originator code for source analysis and relay chain compliance."
  measures:
    - name: "total_eas_events"
      expr: COUNT(1)
      comment: "Total EAS events logged. Baseline for EAS activity volume and test schedule compliance."
    - name: "eas_transmission_compliance_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN compliance_status = 'Compliant' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of EAS events that were fully compliant. The primary FCC EAS compliance KPI — non-compliance triggers enforcement action."
    - name: "failed_transmissions"
      expr: COUNT(CASE WHEN transmission_status = 'Failed' THEN 1 END)
      comment: "Count of EAS transmission failures. Each failure is a potential FCC violation requiring immediate investigation."
    - name: "attention_signal_compliance_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN attention_signal_transmitted = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of EAS events where the required attention signal was transmitted. FCC-mandated component of EAS compliance."
    - name: "audio_message_compliance_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN audio_message_transmitted = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of EAS events where the audio message was transmitted. FCC-mandated component of EAS compliance."
    - name: "end_of_message_compliance_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN end_of_message_transmitted = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of EAS events where the end-of-message signal was transmitted. Required for full EAS protocol compliance."
    - name: "non_compliant_eas_events"
      expr: COUNT(CASE WHEN compliance_status = 'Non-Compliant' THEN 1 END)
      comment: "Count of non-compliant EAS events. Directly maps to FCC violation exposure and potential fines."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`compliance_closed_caption_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs for closed captioning compliance — tracks caption accuracy, synchronization compliance, remediation rates, and complaint volumes. Used by Accessibility Compliance and Operations to meet FCC closed captioning mandates."
  source: "`vibe_media_broadcasting_v1`.`compliance`.`closed_caption_record`"
  dimensions:
    - name: "compliance_status"
      expr: compliance_status
      comment: "Closed captioning compliance determination (Compliant, Non-Compliant, Exempt) for program-level reporting."
    - name: "caption_type"
      expr: caption_type
      comment: "Type of captioning (Live, Pre-recorded, Real-time) for quality benchmarking by production method."
    - name: "language_code"
      expr: language_code
      comment: "Language of the captions for multi-language compliance program tracking."
    - name: "remediation_status"
      expr: remediation_status
      comment: "Status of remediation for non-compliant records for operational tracking."
    - name: "exemption_category"
      expr: exemption_category
      comment: "Category of FCC exemption claimed, for exemption utilization analysis."
    - name: "air_date_month"
      expr: DATE_TRUNC('MONTH', air_date)
      comment: "Month of air date for trend analysis and quarterly FCC reporting periods."
    - name: "daypart"
      expr: daypart
      comment: "Broadcast daypart for compliance analysis by time-of-day programming segment."
  measures:
    - name: "total_caption_records"
      expr: COUNT(1)
      comment: "Total closed captioning records. Baseline for captioning program coverage and FCC reporting."
    - name: "avg_caption_accuracy_score"
      expr: AVG(CAST(caption_accuracy_score AS DOUBLE))
      comment: "Average caption accuracy score across all records. The primary quality KPI for FCC closed captioning compliance — below 98% triggers regulatory scrutiny."
    - name: "avg_caption_completeness_pct"
      expr: AVG(CAST(caption_completeness_percentage AS DOUBLE))
      comment: "Average caption completeness percentage. Measures whether full program content is captioned as required by FCC rules."
    - name: "synchronization_compliance_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN caption_synchronization_compliance = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of records meeting caption synchronization requirements. FCC-mandated quality standard for accessibility compliance."
    - name: "placement_compliance_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN caption_placement_compliance = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of records meeting caption placement requirements. FCC-mandated quality standard."
    - name: "complaint_volume"
      expr: COUNT(CASE WHEN complaint_reference_number IS NOT NULL THEN 1 END)
      comment: "Count of records with associated viewer complaints. Complaint volume is a leading indicator of FCC enforcement risk."
    - name: "avg_caption_latency_seconds"
      expr: AVG(CAST(caption_latency_seconds AS DOUBLE))
      comment: "Average caption latency in seconds. High latency indicates synchronization issues that violate FCC real-time captioning standards."
    - name: "non_compliant_records"
      expr: COUNT(CASE WHEN compliance_status = 'Non-Compliant' THEN 1 END)
      comment: "Count of non-compliant captioning records. Each non-compliant record represents FCC violation exposure."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`compliance_sox_control`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs for SOX internal control effectiveness — tracks control testing results, deficiency rates, key control coverage, and remediation status. Used by Internal Audit, CFO, and Audit Committee to assess SOX compliance posture."
  source: "`vibe_media_broadcasting_v1`.`compliance`.`sox_control`"
  dimensions:
    - name: "control_status"
      expr: control_status
      comment: "Current status of the SOX control (Active, Retired, Under Review) for portfolio management."
    - name: "control_type"
      expr: control_type
      comment: "Type of control (Preventive, Detective, Corrective) for control environment design analysis."
    - name: "process_area"
      expr: process_area
      comment: "Business process area covered by the control (e.g., Revenue, Payroll, Procurement) for SOX scoping."
    - name: "deficiency_classification"
      expr: deficiency_classification
      comment: "Classification of control deficiency (Material Weakness, Significant Deficiency, Control Deficiency) for SEC reporting."
    - name: "test_result"
      expr: test_result
      comment: "Most recent test result (Effective, Ineffective, Not Tested) for control effectiveness reporting."
    - name: "control_frequency"
      expr: control_frequency
      comment: "How often the control operates (Daily, Weekly, Monthly, Quarterly) for coverage analysis."
    - name: "automated_flag"
      expr: automated_flag
      comment: "Whether the control is automated or manual, for automation rate analysis and efficiency planning."
    - name: "key_control_flag"
      expr: key_control_flag
      comment: "Whether this is a key control for SOX purposes, for scoping and prioritization."
  measures:
    - name: "total_controls"
      expr: COUNT(1)
      comment: "Total SOX controls in scope. Baseline for SOX program coverage and audit scope management."
    - name: "effective_controls"
      expr: COUNT(CASE WHEN test_result = 'Effective' THEN 1 END)
      comment: "Count of controls tested as effective. The primary SOX health KPI — directly impacts external auditor opinion."
    - name: "control_effectiveness_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN test_result = 'Effective' THEN 1 END) / NULLIF(COUNT(CASE WHEN test_result IS NOT NULL THEN 1 END), 0), 2)
      comment: "Percentage of tested controls that are effective. Below 95% signals material weakness risk requiring CFO and Audit Committee action."
    - name: "material_weaknesses"
      expr: COUNT(CASE WHEN deficiency_classification = 'Material Weakness' THEN 1 END)
      comment: "Count of material weaknesses. Any material weakness requires public disclosure in SEC filings — the highest-severity SOX KPI."
    - name: "significant_deficiencies"
      expr: COUNT(CASE WHEN deficiency_classification = 'Significant Deficiency' THEN 1 END)
      comment: "Count of significant deficiencies. Significant deficiencies must be reported to the Audit Committee and may escalate to material weaknesses."
    - name: "automation_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN automated_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of controls that are automated. Higher automation rates reduce manual error risk and testing cost."
    - name: "key_controls_effective_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN key_control_flag = TRUE AND test_result = 'Effective' THEN 1 END) / NULLIF(COUNT(CASE WHEN key_control_flag = TRUE THEN 1 END), 0), 2)
      comment: "Effectiveness rate for key controls only. Key control failures have the highest SOX impact and directly affect the external audit opinion."
    - name: "overdue_remediation_controls"
      expr: COUNT(CASE WHEN remediation_status NOT IN ('Completed', 'Closed') AND remediation_target_date < CURRENT_DATE() THEN 1 END)
      comment: "Count of controls with overdue remediation plans. Overdue remediations escalate deficiency risk ahead of year-end audit."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`compliance_political_ad_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs for political advertising compliance — tracks public file disclosure rates, equal opportunities compliance, LUC rate adherence, and affidavit issuance. Used by Compliance and Station Management to meet FCC political broadcasting obligations."
  source: "`vibe_media_broadcasting_v1`.`compliance`.`political_ad_record`"
  dimensions:
    - name: "compliance_status"
      expr: compliance_status
      comment: "Compliance determination for the political ad record (Compliant, Non-Compliant, Pending) for FCC reporting."
    - name: "advertiser_type"
      expr: advertiser_type
      comment: "Type of political advertiser (Candidate, PAC, Issue Advocacy) for FCC political file categorization."
    - name: "election_type"
      expr: election_type
      comment: "Type of election (Federal, State, Local) for jurisdiction-level political ad compliance reporting."
    - name: "jurisdiction_level"
      expr: jurisdiction_level
      comment: "Jurisdiction level of the political ad for regulatory scoping."
    - name: "daypart"
      expr: daypart
      comment: "Broadcast daypart of the political ad for reasonable access and equal opportunities analysis."
    - name: "air_date_month"
      expr: DATE_TRUNC('MONTH', air_date)
      comment: "Month of air date for election cycle trend analysis and FCC reporting periods."
    - name: "luc_period_flag"
      expr: luc_period_flag
      comment: "Whether the ad aired during the Lowest Unit Charge period, for LUC compliance monitoring."
  measures:
    - name: "total_political_ad_records"
      expr: COUNT(1)
      comment: "Total political ad records. Baseline for political advertising volume and FCC public file completeness."
    - name: "public_file_disclosure_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN public_file_disclosure_date IS NOT NULL THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of political ad records with completed public file disclosure. FCC requires disclosure within 2 business days — non-compliance triggers enforcement."
    - name: "affidavit_issuance_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN affidavit_issued_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of political ad records with affidavits issued. Affidavit issuance is a key FCC political broadcasting compliance requirement."
    - name: "total_luc_revenue"
      expr: SUM(CAST(luc_rate AS DOUBLE))
      comment: "Total revenue from LUC-period political ads. Informs political advertising revenue reporting and rate compliance audits."
    - name: "avg_rate_charged"
      expr: AVG(CAST(rate_charged AS DOUBLE))
      comment: "Average rate charged for political ads. Used to verify LUC compliance — rates above LUC during qualifying periods are FCC violations."
    - name: "equal_opportunities_requests"
      expr: COUNT(CASE WHEN equal_opportunities_request_flag = TRUE THEN 1 END)
      comment: "Count of equal opportunities requests received. Stations must respond to equal opportunities requests within FCC deadlines."
    - name: "reasonable_access_requests"
      expr: COUNT(CASE WHEN reasonable_access_request_flag = TRUE THEN 1 END)
      comment: "Count of reasonable access requests from federal candidates. FCC requires stations to provide reasonable access — tracking volume informs compliance risk."
    - name: "non_compliant_records"
      expr: COUNT(CASE WHEN compliance_status = 'Non-Compliant' THEN 1 END)
      comment: "Count of non-compliant political ad records. Each non-compliant record represents direct FCC enforcement exposure."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`compliance_regulatory_obligation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs for regulatory obligation portfolio management — tracks obligation coverage, compliance rates, overdue reviews, and penalty exposure. Used by Chief Compliance Officer to manage the regulatory obligation inventory and prioritize compliance investments."
  source: "`vibe_media_broadcasting_v1`.`compliance`.`regulatory_obligation`"
  dimensions:
    - name: "obligation_type"
      expr: obligation_type
      comment: "Type of regulatory obligation (Reporting, Technical, Operational, Financial) for program segmentation."
    - name: "compliance_status"
      expr: compliance_status
      comment: "Current compliance status of the obligation (Compliant, Non-Compliant, Partially Compliant) for portfolio health monitoring."
    - name: "regulatory_body"
      expr: regulatory_body
      comment: "Regulatory authority imposing the obligation (FCC, FTC, SEC, etc.) for jurisdiction-level compliance reporting."
    - name: "jurisdiction"
      expr: jurisdiction
      comment: "Geographic jurisdiction of the obligation for multi-market compliance management."
    - name: "risk_level"
      expr: risk_level
      comment: "Risk level of the obligation (Critical, High, Medium, Low) for prioritization."
    - name: "compliance_frequency"
      expr: compliance_frequency
      comment: "How often compliance must be demonstrated (Annual, Quarterly, Monthly, Continuous) for scheduling."
    - name: "is_active"
      expr: is_active
      comment: "Whether the obligation is currently active, for active portfolio scoping."
  measures:
    - name: "total_obligations"
      expr: COUNT(1)
      comment: "Total regulatory obligations in the inventory. Baseline for compliance program scope and resource planning."
    - name: "compliant_obligations"
      expr: COUNT(CASE WHEN compliance_status = 'Compliant' THEN 1 END)
      comment: "Count of obligations currently in compliance. The primary portfolio health KPI for the CCO."
    - name: "overall_compliance_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN compliance_status = 'Compliant' THEN 1 END) / NULLIF(COUNT(CASE WHEN is_active = TRUE THEN 1 END), 0), 2)
      comment: "Percentage of active obligations in compliance. The headline compliance program KPI for board and executive reporting."
    - name: "total_maximum_penalty_exposure"
      expr: SUM(CAST(maximum_penalty_amount AS DOUBLE))
      comment: "Total maximum penalty exposure across all non-compliant obligations. Directly informs legal reserve and risk management decisions."
    - name: "avg_maximum_penalty_per_obligation"
      expr: AVG(CAST(maximum_penalty_amount AS DOUBLE))
      comment: "Average maximum penalty per obligation. Used to prioritize high-risk obligations for compliance investment."
    - name: "overdue_compliance_reviews"
      expr: COUNT(CASE WHEN next_compliance_review_date < CURRENT_DATE() AND is_active = TRUE THEN 1 END)
      comment: "Count of active obligations with overdue compliance reviews. Overdue reviews create undetected compliance gaps and regulatory risk."
    - name: "high_risk_non_compliant_obligations"
      expr: COUNT(CASE WHEN risk_level IN ('Critical', 'High') AND compliance_status = 'Non-Compliant' THEN 1 END)
      comment: "Count of high or critical risk obligations that are non-compliant. The highest-priority KPI for CCO intervention and resource reallocation."
    - name: "external_reporting_obligations"
      expr: COUNT(CASE WHEN external_reporting_required = TRUE AND is_active = TRUE THEN 1 END)
      comment: "Count of active obligations requiring external regulatory reporting. Scopes the external reporting workload for Regulatory Affairs."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`compliance_ad_standards_clearance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs for advertising standards clearance — tracks clearance approval rates, rejection patterns, political ad compliance, and review cycle times. Used by Ad Standards and Compliance to ensure all aired advertising meets regulatory and network standards."
  source: "`vibe_media_broadcasting_v1`.`compliance`.`ad_standards_clearance`"
  dimensions:
    - name: "review_outcome"
      expr: review_outcome
      comment: "Outcome of the ad standards review (Approved, Rejected, Approved with Conditions) for clearance rate analysis."
    - name: "clearance_type"
      expr: clearance_type
      comment: "Type of clearance review (Initial, Re-review, Appeal) for process stage analysis."
    - name: "product_category"
      expr: product_category
      comment: "Product category of the advertised content for category-level compliance risk analysis."
    - name: "rejection_category"
      expr: rejection_category
      comment: "Category of rejection reason for root cause analysis and standards policy improvement."
    - name: "political_ad_flag"
      expr: political_ad_flag
      comment: "Whether the ad is a political advertisement, for political ad compliance program segmentation."
    - name: "standards_body"
      expr: standards_body
      comment: "Standards body whose rules govern the clearance (NAB, FCC, Network Standards) for regulatory program tracking."
    - name: "clearance_date_month"
      expr: DATE_TRUNC('MONTH', clearance_date)
      comment: "Month of clearance decision for trend analysis and workload planning."
    - name: "children_directed_flag"
      expr: children_directed_flag
      comment: "Whether the ad is directed at children, for COPPA and CARU compliance program segmentation."
  measures:
    - name: "total_clearance_reviews"
      expr: COUNT(1)
      comment: "Total ad standards clearance reviews. Baseline for review volume and Ad Standards team capacity planning."
    - name: "clearance_approval_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN review_outcome = 'Approved' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of ads approved on first review. Low approval rates signal advertiser quality issues or overly restrictive standards application."
    - name: "rejection_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN review_outcome = 'Rejected' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of ads rejected. High rejection rates by category identify systemic advertiser compliance issues."
    - name: "appeal_filed_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN appeal_filed_flag = TRUE THEN 1 END) / NULLIF(COUNT(CASE WHEN review_outcome = 'Rejected' THEN 1 END), 0), 2)
      comment: "Percentage of rejections that result in an appeal. High appeal rates may indicate inconsistent standards application."
    - name: "political_ad_clearances"
      expr: COUNT(CASE WHEN political_ad_flag = TRUE THEN 1 END)
      comment: "Count of political ad clearance reviews. Political ads require heightened compliance scrutiny and public file documentation."
    - name: "children_directed_clearances"
      expr: COUNT(CASE WHEN children_directed_flag = TRUE THEN 1 END)
      comment: "Count of clearance reviews for children-directed advertising. COPPA and CARU compliance requirements apply — volume informs compliance program scope."
    - name: "substantiation_required_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN substantiation_required_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of ads requiring substantiation documentation. High rates indicate advertiser claim risk and FTC compliance exposure."
    - name: "substantiation_compliance_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN substantiation_required_flag = TRUE AND substantiation_provided_flag = TRUE THEN 1 END) / NULLIF(COUNT(CASE WHEN substantiation_required_flag = TRUE THEN 1 END), 0), 2)
      comment: "Percentage of ads requiring substantiation where substantiation was actually provided. Gaps represent FTC enforcement risk."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`compliance_privacy_request`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs for privacy request management — tracks response timeliness, fulfillment rates, regulatory deadline compliance, and request type distribution. Used by Privacy and Legal to meet GDPR, CCPA, and other data subject rights obligations."
  source: "`vibe_media_broadcasting_v1`.`compliance`.`privacy_request`"
  dimensions:
    - name: "request_type"
      expr: request_type
      comment: "Type of privacy request (Access, Deletion, Portability, Opt-Out) for obligation-specific compliance tracking."
    - name: "request_status"
      expr: request_status
      comment: "Current status of the privacy request (Pending, In Progress, Completed, Rejected) for operational monitoring."
    - name: "regulatory_framework"
      expr: regulatory_framework
      comment: "Regulatory framework governing the request (GDPR, CCPA, COPPA) for jurisdiction-level compliance reporting."
    - name: "fulfillment_status"
      expr: fulfillment_status
      comment: "Whether the request was fulfilled, partially fulfilled, or denied for compliance rate analysis."
    - name: "requestor_jurisdiction"
      expr: requestor_jurisdiction
      comment: "Jurisdiction of the requestor for geographic compliance program analysis."
    - name: "submission_channel"
      expr: submission_channel
      comment: "Channel through which the request was submitted (Web, Email, Phone) for process efficiency analysis."
    - name: "submission_timestamp_month"
      expr: DATE_TRUNC('MONTH', submission_timestamp)
      comment: "Month of request submission for volume trend analysis and regulatory reporting periods."
    - name: "extension_granted"
      expr: extension_granted
      comment: "Whether a deadline extension was granted, for extension utilization and compliance risk analysis."
  measures:
    - name: "total_privacy_requests"
      expr: COUNT(1)
      comment: "Total privacy requests received. Baseline for privacy program workload and regulatory obligation volume."
    - name: "on_time_response_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN response_date <= regulatory_deadline THEN 1 END) / NULLIF(COUNT(CASE WHEN response_date IS NOT NULL THEN 1 END), 0), 2)
      comment: "Percentage of privacy requests responded to within the regulatory deadline. GDPR requires 30-day response — non-compliance triggers supervisory authority fines."
    - name: "overdue_requests"
      expr: COUNT(CASE WHEN request_status NOT IN ('Completed', 'Closed', 'Rejected') AND regulatory_deadline < CURRENT_DATE() THEN 1 END)
      comment: "Count of privacy requests past their regulatory deadline. Each overdue request represents direct regulatory fine exposure."
    - name: "avg_processing_time_hours"
      expr: AVG(CAST(processing_time_hours AS DOUBLE))
      comment: "Average processing time in hours per privacy request. Informs staffing and automation investment decisions for the privacy team."
    - name: "total_data_volume_processed"
      expr: SUM(CAST(data_volume_processed AS DOUBLE))
      comment: "Total volume of data processed across privacy requests. Informs data minimization strategy and privacy-by-design investment."
    - name: "fulfillment_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN fulfillment_status = 'Fulfilled' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of privacy requests successfully fulfilled. Low fulfillment rates may indicate systemic data access or deletion capability gaps."
    - name: "extension_utilization_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN extension_granted = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of requests requiring deadline extensions. High extension rates signal insufficient privacy team capacity or process inefficiency."
$$;