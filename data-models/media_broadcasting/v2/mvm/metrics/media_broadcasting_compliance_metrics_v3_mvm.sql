-- Metric views for domain: compliance | Business: Media_Broadcasting | Version: 3 | Generated on: 2026-07-10 21:10:12

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`compliance_broadcast_license`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core broadcast license metrics tracking license portfolio health, renewal status, and regulatory compliance obligations across jurisdictions."
  source: "`vibe_media_broadcasting_v1`.`compliance`.`broadcast_license`"
  dimensions:
    - name: "license_type"
      expr: license_type
      comment: "Type of broadcast license (e.g., AM, FM, TV, digital)"
    - name: "license_class"
      expr: license_class
      comment: "FCC license class designation"
    - name: "broadcast_license_status"
      expr: broadcast_license_status
      comment: "Current status of the broadcast license (active, expired, pending renewal)"
    - name: "service_type"
      expr: service_type
      comment: "Type of broadcast service provided"
    - name: "jurisdiction_country_code"
      expr: jurisdiction_country_code
      comment: "Country jurisdiction for the license"
    - name: "regulatory_authority"
      expr: regulatory_authority
      comment: "Regulatory body governing the license (e.g., FCC, CRTC)"
    - name: "renewal_status"
      expr: renewal_status
      comment: "Status of license renewal process"
    - name: "licensee_type"
      expr: licensee_type
      comment: "Type of licensee entity"
    - name: "grant_year"
      expr: YEAR(grant_date)
      comment: "Year the license was originally granted"
    - name: "expiration_year"
      expr: YEAR(expiration_date)
      comment: "Year the license expires"
  measures:
    - name: "total_licenses"
      expr: COUNT(1)
      comment: "Total number of broadcast licenses in portfolio"
    - name: "total_annual_fees"
      expr: SUM(CAST(annual_fee_amount AS DOUBLE))
      comment: "Total annual regulatory fees across all licenses"
    - name: "avg_annual_fee"
      expr: AVG(CAST(annual_fee_amount AS DOUBLE))
      comment: "Average annual fee per license"
    - name: "total_broadcast_power_watts"
      expr: SUM(CAST(power_output_erp_watts AS DOUBLE))
      comment: "Total effective radiated power across all licenses in watts"
    - name: "avg_antenna_height_meters"
      expr: AVG(CAST(antenna_height_meters AS DOUBLE))
      comment: "Average antenna height across licensed facilities"
    - name: "licenses_requiring_closed_captioning"
      expr: COUNT(CASE WHEN closed_captioning_required = TRUE THEN 1 END)
      comment: "Count of licenses with closed captioning obligations"
    - name: "licenses_requiring_eas_participation"
      expr: COUNT(CASE WHEN eas_participation_required = TRUE THEN 1 END)
      comment: "Count of licenses requiring Emergency Alert System participation"
    - name: "pct_licenses_with_closed_captioning"
      expr: ROUND(100.0 * COUNT(CASE WHEN closed_captioning_required = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of licenses requiring closed captioning compliance"
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`compliance_regulatory_obligation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic regulatory obligation metrics tracking compliance risk, penalty exposure, and obligation lifecycle across jurisdictions and regulatory bodies."
  source: "`vibe_media_broadcasting_v1`.`compliance`.`regulatory_obligation`"
  dimensions:
    - name: "obligation_type"
      expr: obligation_type
      comment: "Category of regulatory obligation"
    - name: "regulatory_body"
      expr: regulatory_body
      comment: "Regulatory authority imposing the obligation"
    - name: "jurisdiction"
      expr: jurisdiction
      comment: "Geographic or legal jurisdiction"
    - name: "compliance_status"
      expr: compliance_status
      comment: "Current compliance status (compliant, at-risk, non-compliant)"
    - name: "risk_level"
      expr: risk_level
      comment: "Risk level associated with the obligation (high, medium, low)"
    - name: "compliance_frequency"
      expr: compliance_frequency
      comment: "How often compliance must be demonstrated (annual, quarterly, monthly)"
    - name: "is_active"
      expr: is_active
      comment: "Whether the obligation is currently active"
    - name: "external_reporting_required"
      expr: external_reporting_required
      comment: "Whether external regulatory reporting is required"
    - name: "public_disclosure_required"
      expr: public_disclosure_required
      comment: "Whether public disclosure is mandated"
    - name: "responsible_department"
      expr: responsible_department
      comment: "Internal department responsible for compliance"
  measures:
    - name: "total_obligations"
      expr: COUNT(1)
      comment: "Total number of regulatory obligations"
    - name: "active_obligations"
      expr: COUNT(CASE WHEN is_active = TRUE THEN 1 END)
      comment: "Count of currently active regulatory obligations"
    - name: "total_maximum_penalty_exposure"
      expr: SUM(CAST(maximum_penalty_amount AS DOUBLE))
      comment: "Total maximum penalty exposure across all obligations"
    - name: "avg_maximum_penalty"
      expr: AVG(CAST(maximum_penalty_amount AS DOUBLE))
      comment: "Average maximum penalty per obligation"
    - name: "high_risk_obligations"
      expr: COUNT(CASE WHEN risk_level = 'high' THEN 1 END)
      comment: "Count of high-risk regulatory obligations"
    - name: "obligations_requiring_external_reporting"
      expr: COUNT(CASE WHEN external_reporting_required = TRUE THEN 1 END)
      comment: "Count of obligations requiring external regulatory reporting"
    - name: "obligations_requiring_public_disclosure"
      expr: COUNT(CASE WHEN public_disclosure_required = TRUE THEN 1 END)
      comment: "Count of obligations requiring public disclosure"
    - name: "pct_high_risk_obligations"
      expr: ROUND(100.0 * COUNT(CASE WHEN risk_level = 'high' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of obligations classified as high risk"
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`compliance_regulatory_filing`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Regulatory filing performance metrics tracking submission timeliness, approval rates, fee burden, and filing lifecycle efficiency."
  source: "`vibe_media_broadcasting_v1`.`compliance`.`regulatory_filing`"
  dimensions:
    - name: "filing_type"
      expr: filing_type
      comment: "Type of regulatory filing"
    - name: "filing_status"
      expr: filing_status
      comment: "Current status of the filing (submitted, approved, rejected, pending)"
    - name: "regulatory_body"
      expr: regulatory_body
      comment: "Regulatory authority receiving the filing"
    - name: "compliance_category"
      expr: compliance_category
      comment: "Category of compliance the filing addresses"
    - name: "submission_method"
      expr: submission_method
      comment: "Method used to submit the filing (electronic, paper, portal)"
    - name: "amendment_flag"
      expr: amendment_flag
      comment: "Whether this filing is an amendment to a previous filing"
    - name: "public_inspection_required"
      expr: public_inspection_required
      comment: "Whether the filing must be available for public inspection"
    - name: "filing_year"
      expr: YEAR(filing_date)
      comment: "Year the filing was submitted"
    - name: "filing_quarter"
      expr: CONCAT('Q', CAST(QUARTER(filing_date) AS STRING))
      comment: "Quarter the filing was submitted"
  measures:
    - name: "total_filings"
      expr: COUNT(1)
      comment: "Total number of regulatory filings"
    - name: "approved_filings"
      expr: COUNT(CASE WHEN filing_status = 'approved' THEN 1 END)
      comment: "Count of approved filings"
    - name: "rejected_filings"
      expr: COUNT(CASE WHEN filing_status = 'rejected' THEN 1 END)
      comment: "Count of rejected filings"
    - name: "total_filing_fees"
      expr: SUM(CAST(filing_fee_amount AS DOUBLE))
      comment: "Total filing fees paid across all filings"
    - name: "avg_filing_fee"
      expr: AVG(CAST(filing_fee_amount AS DOUBLE))
      comment: "Average filing fee per submission"
    - name: "amendment_filings"
      expr: COUNT(CASE WHEN amendment_flag = TRUE THEN 1 END)
      comment: "Count of filings that are amendments"
    - name: "filings_requiring_public_inspection"
      expr: COUNT(CASE WHEN public_inspection_required = TRUE THEN 1 END)
      comment: "Count of filings requiring public inspection file placement"
    - name: "filing_approval_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN filing_status = 'approved' THEN 1 END) / NULLIF(COUNT(CASE WHEN filing_status IN ('approved', 'rejected') THEN 1 END), 0), 2)
      comment: "Percentage of filings approved (excludes pending/in-progress)"
    - name: "pct_amendment_filings"
      expr: ROUND(100.0 * COUNT(CASE WHEN amendment_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of filings that are amendments (indicator of initial filing quality)"
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`compliance_political_ad_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Political advertising compliance metrics tracking ad volume, revenue, equal opportunities requests, and lowest unit charge compliance during election cycles."
  source: "`vibe_media_broadcasting_v1`.`compliance`.`political_ad_record`"
  dimensions:
    - name: "advertiser_type"
      expr: advertiser_type
      comment: "Type of political advertiser (candidate, PAC, party committee)"
    - name: "election_type"
      expr: election_type
      comment: "Type of election (primary, general, special)"
    - name: "jurisdiction_level"
      expr: jurisdiction_level
      comment: "Level of election jurisdiction (federal, state, local)"
    - name: "office_sought"
      expr: office_sought
      comment: "Political office being sought"
    - name: "compliance_status"
      expr: compliance_status
      comment: "Compliance status of the ad record"
    - name: "luc_period_flag"
      expr: luc_period_flag
      comment: "Whether ad aired during lowest unit charge period"
    - name: "equal_opportunities_request_flag"
      expr: equal_opportunities_request_flag
      comment: "Whether equal opportunities were requested"
    - name: "reasonable_access_request_flag"
      expr: reasonable_access_request_flag
      comment: "Whether reasonable access was requested"
    - name: "preemption_flag"
      expr: preemption_flag
      comment: "Whether the ad was preempted"
    - name: "daypart"
      expr: daypart
      comment: "Daypart when the ad aired"
    - name: "election_year"
      expr: YEAR(election_date)
      comment: "Year of the election"
  measures:
    - name: "total_political_ads"
      expr: COUNT(1)
      comment: "Total number of political ad records"
    - name: "total_political_ad_revenue"
      expr: SUM(CAST(rate_charged AS DOUBLE))
      comment: "Total revenue from political advertising"
    - name: "avg_political_ad_rate"
      expr: AVG(CAST(rate_charged AS DOUBLE))
      comment: "Average rate charged per political ad"
    - name: "luc_period_ads"
      expr: COUNT(CASE WHEN luc_period_flag = TRUE THEN 1 END)
      comment: "Count of ads aired during lowest unit charge period"
    - name: "total_luc_revenue"
      expr: SUM(CASE WHEN luc_period_flag = TRUE THEN CAST(rate_charged AS DOUBLE) ELSE 0 END)
      comment: "Total revenue from ads during lowest unit charge period"
    - name: "avg_luc_rate"
      expr: AVG(CASE WHEN luc_period_flag = TRUE THEN CAST(luc_rate AS DOUBLE) END)
      comment: "Average lowest unit charge rate during LUC period"
    - name: "equal_opportunities_requests"
      expr: COUNT(CASE WHEN equal_opportunities_request_flag = TRUE THEN 1 END)
      comment: "Count of ads with equal opportunities requests"
    - name: "reasonable_access_requests"
      expr: COUNT(CASE WHEN reasonable_access_request_flag = TRUE THEN 1 END)
      comment: "Count of ads with reasonable access requests"
    - name: "preempted_ads"
      expr: COUNT(CASE WHEN preemption_flag = TRUE THEN 1 END)
      comment: "Count of political ads that were preempted"
    - name: "pct_luc_period_ads"
      expr: ROUND(100.0 * COUNT(CASE WHEN luc_period_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of political ads aired during lowest unit charge period"
    - name: "preemption_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN preemption_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of political ads preempted (compliance risk indicator)"
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`compliance_closed_caption_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Closed captioning compliance metrics tracking caption quality, completeness, technical compliance, and remediation effectiveness for accessibility obligations."
  source: "`vibe_media_broadcasting_v1`.`compliance`.`closed_caption_record`"
  dimensions:
    - name: "caption_type"
      expr: caption_type
      comment: "Type of closed captioning (live, pre-recorded, real-time)"
    - name: "compliance_status"
      expr: compliance_status
      comment: "Compliance status of the caption record"
    - name: "language_code"
      expr: language_code
      comment: "Language of the closed captions"
    - name: "caption_file_format"
      expr: caption_file_format
      comment: "File format of the caption file"
    - name: "exemption_category"
      expr: exemption_category
      comment: "Category of exemption if applicable"
    - name: "remediation_status"
      expr: remediation_status
      comment: "Status of remediation for non-compliant captions"
    - name: "complaint_type"
      expr: complaint_type
      comment: "Type of complaint received if any"
    - name: "daypart"
      expr: daypart
      comment: "Daypart when the captioned content aired"
    - name: "caption_placement_compliance"
      expr: caption_placement_compliance
      comment: "Whether caption placement meets compliance standards"
    - name: "caption_synchronization_compliance"
      expr: caption_synchronization_compliance
      comment: "Whether caption synchronization meets compliance standards"
  measures:
    - name: "total_caption_records"
      expr: COUNT(1)
      comment: "Total number of closed caption records"
    - name: "avg_caption_accuracy_score"
      expr: AVG(CAST(caption_accuracy_score AS DOUBLE))
      comment: "Average caption accuracy score across all records"
    - name: "avg_caption_completeness_pct"
      expr: AVG(CAST(caption_completeness_percentage AS DOUBLE))
      comment: "Average caption completeness percentage"
    - name: "avg_caption_latency_seconds"
      expr: AVG(CAST(caption_latency_seconds AS DOUBLE))
      comment: "Average caption latency in seconds (live captioning performance)"
    - name: "compliant_caption_records"
      expr: COUNT(CASE WHEN compliance_status = 'compliant' THEN 1 END)
      comment: "Count of fully compliant caption records"
    - name: "non_compliant_caption_records"
      expr: COUNT(CASE WHEN compliance_status = 'non-compliant' THEN 1 END)
      comment: "Count of non-compliant caption records"
    - name: "caption_complaints_received"
      expr: COUNT(CASE WHEN complaint_reference_number IS NOT NULL THEN 1 END)
      comment: "Count of caption records with complaints received"
    - name: "remediation_completed"
      expr: COUNT(CASE WHEN remediation_status = 'completed' THEN 1 END)
      comment: "Count of caption issues successfully remediated"
    - name: "caption_compliance_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN compliance_status = 'compliant' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of caption records meeting compliance standards"
    - name: "caption_placement_compliance_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN caption_placement_compliance = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of records with compliant caption placement"
    - name: "caption_sync_compliance_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN caption_synchronization_compliance = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of records with compliant caption synchronization"
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`compliance_eas_log`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Emergency Alert System compliance metrics tracking alert transmission success, test compliance, and system reliability for public safety obligations."
  source: "`vibe_media_broadcasting_v1`.`compliance`.`eas_log`"
  dimensions:
    - name: "alert_type"
      expr: alert_type
      comment: "Type of EAS alert (test, actual emergency, required monthly test)"
    - name: "event_code"
      expr: event_code
      comment: "EAS event code"
    - name: "originator_code"
      expr: originator_code
      comment: "Code identifying the alert originator"
    - name: "transmission_status"
      expr: transmission_status
      comment: "Status of alert transmission (success, failure, partial)"
    - name: "compliance_status"
      expr: compliance_status
      comment: "Compliance status of the EAS event"
    - name: "test_compliance_type"
      expr: test_compliance_type
      comment: "Type of compliance test (required monthly test, required weekly test)"
    - name: "attention_signal_transmitted"
      expr: attention_signal_transmitted
      comment: "Whether attention signal was transmitted"
    - name: "audio_message_transmitted"
      expr: audio_message_transmitted
      comment: "Whether audio message was transmitted"
    - name: "end_of_message_transmitted"
      expr: end_of_message_transmitted
      comment: "Whether end-of-message signal was transmitted"
    - name: "cap_message_received"
      expr: cap_message_received
      comment: "Whether CAP (Common Alerting Protocol) message was received"
  measures:
    - name: "total_eas_events"
      expr: COUNT(1)
      comment: "Total number of EAS events logged"
    - name: "successful_transmissions"
      expr: COUNT(CASE WHEN transmission_status = 'success' THEN 1 END)
      comment: "Count of successful EAS transmissions"
    - name: "failed_transmissions"
      expr: COUNT(CASE WHEN transmission_status = 'failure' THEN 1 END)
      comment: "Count of failed EAS transmissions"
    - name: "compliant_eas_events"
      expr: COUNT(CASE WHEN compliance_status = 'compliant' THEN 1 END)
      comment: "Count of EAS events meeting compliance requirements"
    - name: "required_tests_conducted"
      expr: COUNT(CASE WHEN test_compliance_type IS NOT NULL THEN 1 END)
      comment: "Count of required EAS tests conducted"
    - name: "attention_signal_success"
      expr: COUNT(CASE WHEN attention_signal_transmitted = TRUE THEN 1 END)
      comment: "Count of events with successful attention signal transmission"
    - name: "audio_message_success"
      expr: COUNT(CASE WHEN audio_message_transmitted = TRUE THEN 1 END)
      comment: "Count of events with successful audio message transmission"
    - name: "eom_signal_success"
      expr: COUNT(CASE WHEN end_of_message_transmitted = TRUE THEN 1 END)
      comment: "Count of events with successful end-of-message signal transmission"
    - name: "eas_transmission_success_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN transmission_status = 'success' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of EAS transmissions that succeeded (system reliability indicator)"
    - name: "eas_compliance_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN compliance_status = 'compliant' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of EAS events meeting compliance standards"
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`compliance_license_renewal`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "License renewal lifecycle metrics tracking renewal timeliness, approval rates, fee burden, and petition activity for broadcast license portfolio management."
  source: "`vibe_media_broadcasting_v1`.`compliance`.`license_renewal`"
  dimensions:
    - name: "license_type"
      expr: license_type
      comment: "Type of license being renewed"
    - name: "renewal_status"
      expr: renewal_status
      comment: "Current status of the renewal process"
    - name: "final_disposition"
      expr: final_disposition
      comment: "Final outcome of the renewal (approved, denied, conditional)"
    - name: "regulatory_body"
      expr: regulatory_body
      comment: "Regulatory authority processing the renewal"
    - name: "fee_payment_status"
      expr: fee_payment_status
      comment: "Status of renewal fee payment"
    - name: "petition_to_deny_filed"
      expr: petition_to_deny_filed
      comment: "Whether a petition to deny was filed against the renewal"
    - name: "compliance_certification_submitted"
      expr: compliance_certification_submitted
      comment: "Whether compliance certification was submitted"
    - name: "public_inspection_file_updated"
      expr: public_inspection_file_updated
      comment: "Whether public inspection file was updated as required"
    - name: "renewal_year"
      expr: YEAR(filing_deadline)
      comment: "Year of the renewal filing deadline"
  measures:
    - name: "total_renewals"
      expr: COUNT(1)
      comment: "Total number of license renewal applications"
    - name: "approved_renewals"
      expr: COUNT(CASE WHEN final_disposition = 'approved' THEN 1 END)
      comment: "Count of approved license renewals"
    - name: "denied_renewals"
      expr: COUNT(CASE WHEN final_disposition = 'denied' THEN 1 END)
      comment: "Count of denied license renewals"
    - name: "total_renewal_fees"
      expr: SUM(CAST(renewal_fee_amount AS DOUBLE))
      comment: "Total renewal fees paid across all renewals"
    - name: "avg_renewal_fee"
      expr: AVG(CAST(renewal_fee_amount AS DOUBLE))
      comment: "Average renewal fee per license"
    - name: "renewals_with_petitions"
      expr: COUNT(CASE WHEN petition_to_deny_filed = TRUE THEN 1 END)
      comment: "Count of renewals with petitions to deny filed"
    - name: "renewals_with_compliance_cert"
      expr: COUNT(CASE WHEN compliance_certification_submitted = TRUE THEN 1 END)
      comment: "Count of renewals with compliance certification submitted"
    - name: "renewals_with_pif_updated"
      expr: COUNT(CASE WHEN public_inspection_file_updated = TRUE THEN 1 END)
      comment: "Count of renewals with public inspection file updated"
    - name: "renewal_approval_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN final_disposition = 'approved' THEN 1 END) / NULLIF(COUNT(CASE WHEN final_disposition IN ('approved', 'denied') THEN 1 END), 0), 2)
      comment: "Percentage of renewal applications approved (excludes pending)"
    - name: "petition_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN petition_to_deny_filed = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of renewals facing petitions to deny (stakeholder opposition indicator)"
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`compliance_accessibility_obligation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Accessibility obligation performance metrics tracking compliance progress, cost burden, and deadline adherence for disability access requirements."
  source: "`vibe_media_broadcasting_v1`.`compliance`.`accessibility_obligation`"
  dimensions:
    - name: "obligation_type"
      expr: obligation_type
      comment: "Type of accessibility obligation"
    - name: "compliance_status"
      expr: compliance_status
      comment: "Current compliance status"
    - name: "content_type_applicability"
      expr: content_type_applicability
      comment: "Type of content to which the obligation applies"
    - name: "geographic_jurisdiction"
      expr: geographic_jurisdiction
      comment: "Geographic jurisdiction of the obligation"
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level of the obligation"
    - name: "technical_standard"
      expr: technical_standard
      comment: "Technical standard that must be met"
    - name: "measurement_methodology"
      expr: measurement_methodology
      comment: "Methodology used to measure compliance"
    - name: "reporting_frequency"
      expr: reporting_frequency
      comment: "Frequency of compliance reporting required"
    - name: "responsible_team"
      expr: responsible_team
      comment: "Team responsible for compliance"
    - name: "exemption_reason"
      expr: exemption_reason
      comment: "Reason for exemption if applicable"
  measures:
    - name: "total_accessibility_obligations"
      expr: COUNT(1)
      comment: "Total number of accessibility obligations"
    - name: "avg_compliance_percentage"
      expr: AVG(CAST(compliance_percentage AS DOUBLE))
      comment: "Average compliance percentage across all obligations"
    - name: "avg_target_compliance_percentage"
      expr: AVG(CAST(target_compliance_percentage AS DOUBLE))
      comment: "Average target compliance percentage"
    - name: "total_estimated_compliance_cost"
      expr: SUM(CAST(estimated_compliance_cost AS DOUBLE))
      comment: "Total estimated cost to achieve compliance across all obligations"
    - name: "avg_estimated_compliance_cost"
      expr: AVG(CAST(estimated_compliance_cost AS DOUBLE))
      comment: "Average estimated compliance cost per obligation"
    - name: "fully_compliant_obligations"
      expr: COUNT(CASE WHEN compliance_status = 'compliant' THEN 1 END)
      comment: "Count of fully compliant accessibility obligations"
    - name: "at_risk_obligations"
      expr: COUNT(CASE WHEN compliance_status = 'at-risk' THEN 1 END)
      comment: "Count of at-risk accessibility obligations"
    - name: "high_priority_obligations"
      expr: COUNT(CASE WHEN priority_level = 'high' THEN 1 END)
      comment: "Count of high-priority accessibility obligations"
    - name: "accessibility_compliance_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN compliance_status = 'compliant' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of accessibility obligations in full compliance"
    - name: "compliance_gap_pct"
      expr: ROUND(AVG(CAST(target_compliance_percentage AS DOUBLE)) - AVG(CAST(compliance_percentage AS DOUBLE)), 2)
      comment: "Average gap between target and actual compliance percentage (performance shortfall)"
$$;