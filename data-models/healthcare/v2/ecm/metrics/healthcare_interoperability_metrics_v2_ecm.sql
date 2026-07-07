-- Metric views for domain: interoperability | Business: Healthcare | Version: 2 | Generated on: 2026-07-02 07:21:53

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`interoperability_message_log`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Interface message throughput, latency, and SLA compliance KPIs for HL7/FHIR message exchange operations. Steers integration engine reliability and interface performance."
  source: "`vibe_healthcare_v1`.`interoperability`.`message_log`"
  dimensions:
    - name: "message_type"
      expr: message_type
      comment: "Type of interface message (e.g. ADT, ORM, ORU) for throughput segmentation."
    - name: "message_standard"
      expr: message_standard
      comment: "Messaging standard (HL7v2, FHIR, etc.) for standard-level analysis."
    - name: "processing_status"
      expr: processing_status
      comment: "Processing outcome status of the message."
    - name: "business_event_type"
      expr: business_event_type
      comment: "Business event that triggered the message."
    - name: "message_month"
      expr: DATE_TRUNC('MONTH', message_timestamp)
      comment: "Month bucket of message timestamp for trend analysis."
  measures:
    - name: "Total Messages"
      expr: COUNT(1)
      comment: "Total count of interface messages processed — baseline throughput volume."
    - name: "Avg Processing Latency Ms"
      expr: AVG(CAST(processing_latency_ms AS DOUBLE))
      comment: "Average end-to-end message processing latency in milliseconds — key interface performance KPI."
    - name: "Total Payload Bytes"
      expr: SUM(CAST(payload_size_bytes AS DOUBLE))
      comment: "Total payload volume transmitted in bytes — capacity planning input."
    - name: "SLA Met Count"
      expr: COUNT(CASE WHEN sla_met = TRUE THEN 1 END)
      comment: "Count of messages meeting SLA latency threshold — numerator for SLA compliance rate."
    - name: "SLA Compliance Rate Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN sla_met = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of messages meeting SLA — critical interface reliability KPI for steering meetings."
    - name: "Duplicate Message Rate Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_duplicate = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of messages flagged as duplicates — data integrity indicator."
    - name: "Error Message Rate Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN processing_status = 'ERROR' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of messages ending in error — interface health/quality KPI."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`interoperability_message_error`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Interface message error resolution and SLA-breach KPIs. Steers integration support operations and escalation management."
  source: "`vibe_healthcare_v1`.`interoperability`.`message_error`"
  dimensions:
    - name: "error_category"
      expr: error_category
      comment: "Category of the message error for root-cause grouping."
    - name: "error_severity"
      expr: error_severity
      comment: "Severity level of the error."
    - name: "resolution_status"
      expr: resolution_status
      comment: "Current resolution status of the error."
    - name: "root_cause_category"
      expr: root_cause_category
      comment: "Root cause category assigned to the error."
    - name: "error_month"
      expr: DATE_TRUNC('MONTH', error_timestamp)
      comment: "Month bucket of error occurrence for trend analysis."
  measures:
    - name: "Total Errors"
      expr: COUNT(1)
      comment: "Total interface errors logged — baseline error volume."
    - name: "SLA Breach Count"
      expr: COUNT(CASE WHEN sla_breach_flag = TRUE THEN 1 END)
      comment: "Count of errors that breached resolution SLA — escalation trigger."
    - name: "SLA Breach Rate Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN sla_breach_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of errors breaching resolution SLA — operational support KPI."
    - name: "Escalation Rate Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN escalation_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of errors escalated — severity/staffing indicator."
    - name: "Avg Resolution Minutes"
      expr: AVG(CAST(actual_resolution_minutes AS DOUBLE))
      comment: "Average actual resolution time in minutes — support efficiency KPI."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`interoperability_interface_downtime`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Interface downtime, uptime, and message-loss KPIs. Steers integration availability and SLA management."
  source: "`vibe_healthcare_v1`.`interoperability`.`interface_downtime`"
  dimensions:
    - name: "downtime_type"
      expr: downtime_type
      comment: "Type of downtime event (planned/unplanned)."
    - name: "impact_severity"
      expr: impact_severity
      comment: "Severity of business impact of the downtime."
    - name: "root_cause_category"
      expr: root_cause_category
      comment: "Root cause category of the downtime event."
    - name: "downtime_month"
      expr: DATE_TRUNC('MONTH', downtime_start_timestamp)
      comment: "Month bucket of downtime start for trend analysis."
  measures:
    - name: "Total Downtime Events"
      expr: COUNT(1)
      comment: "Total downtime events — baseline reliability volume."
    - name: "Total Downtime Minutes"
      expr: SUM(CAST(downtime_duration_minutes AS DOUBLE))
      comment: "Total accumulated downtime minutes — availability impact KPI."
    - name: "Avg Downtime Minutes"
      expr: AVG(CAST(downtime_duration_minutes AS DOUBLE))
      comment: "Average duration per downtime event — incident severity indicator."
    - name: "Avg Actual Uptime Pct"
      expr: AVG(CAST(actual_uptime_percentage AS DOUBLE))
      comment: "Average actual uptime percentage — headline availability KPI."
    - name: "Total Messages Lost"
      expr: SUM(CAST(messages_lost_count AS DOUBLE))
      comment: "Total messages lost during downtime — data continuity risk KPI."
    - name: "SLA Breach Rate Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN sla_breach_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of downtime events that breached uptime SLA — contract-risk KPI."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`interoperability_hie_query`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Health Information Exchange query performance, patient-match confidence, and consent-compliance KPIs. Steers HIE participation value and query reliability."
  source: "`vibe_healthcare_v1`.`interoperability`.`hie_query`"
  dimensions:
    - name: "query_type"
      expr: query_type
      comment: "Type of HIE query issued."
    - name: "query_status"
      expr: query_status
      comment: "Outcome status of the HIE query."
    - name: "query_priority"
      expr: query_priority
      comment: "Priority of the query."
    - name: "data_sensitivity_level"
      expr: data_sensitivity_level
      comment: "Sensitivity level of data requested — compliance segmentation."
    - name: "query_month"
      expr: DATE_TRUNC('MONTH', query_timestamp)
      comment: "Month bucket of query timestamp for trend analysis."
  measures:
    - name: "Total Queries"
      expr: COUNT(1)
      comment: "Total HIE queries issued — baseline exchange volume."
    - name: "Avg Query Response Seconds"
      expr: AVG(CAST(query_response_time_seconds AS DOUBLE))
      comment: "Average query response time in seconds — HIE performance KPI."
    - name: "Avg Match Confidence Score"
      expr: AVG(CAST(match_confidence_score AS DOUBLE))
      comment: "Average patient-identity match confidence — data quality KPI."
    - name: "Consent Verified Rate Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN consent_verified = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of queries with verified consent — HIPAA/consent compliance KPI."
    - name: "Total Documents Returned"
      expr: SUM(CAST(documents_returned_count AS DOUBLE))
      comment: "Total documents returned across queries — exchange yield KPI."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`interoperability_fhir_endpoint`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "FHIR endpoint availability, request volume, and regulatory API compliance KPIs. Steers CMS Interoperability Rule and ONC compliance posture."
  source: "`vibe_healthcare_v1`.`interoperability`.`fhir_endpoint`"
  dimensions:
    - name: "endpoint_type"
      expr: endpoint_type
      comment: "Type of FHIR endpoint."
    - name: "fhir_version"
      expr: fhir_version
      comment: "FHIR specification version supported."
    - name: "operational_status"
      expr: operational_status
      comment: "Operational status of the endpoint."
    - name: "environment"
      expr: environment
      comment: "Deployment environment (prod/test)."
  measures:
    - name: "Total Endpoints"
      expr: COUNT(1)
      comment: "Total FHIR endpoints registered — baseline inventory."
    - name: "Avg Uptime Pct"
      expr: AVG(CAST(uptime_percentage AS DOUBLE))
      comment: "Average endpoint uptime percentage — availability KPI."
    - name: "Avg Response Time Ms"
      expr: AVG(CAST(average_response_time_ms AS DOUBLE))
      comment: "Average endpoint response time in ms — performance KPI."
    - name: "Total Requests 30d"
      expr: SUM(CAST(total_requests_last_30_days AS DOUBLE))
      comment: "Total requests over last 30 days — API utilization KPI."
    - name: "CMS Compliance Rate Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN cms_compliance_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of endpoints CMS-compliant — regulatory compliance KPI."
    - name: "ONC Certified Rate Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN onc_certification_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of endpoints ONC-certified — certification posture KPI."
    - name: "Patient Access API Rate Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN patient_access_api_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of endpoints exposing Patient Access API — CMS mandate coverage KPI."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`interoperability_care_transition_notification`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "CMS ADT event notification delivery, acknowledgment, and compliance KPIs. Steers Condition of Participation compliance for event notifications."
  source: "`vibe_healthcare_v1`.`interoperability`.`care_transition_notification`"
  dimensions:
    - name: "event_type"
      expr: event_type
      comment: "ADT event type (admission/discharge/transfer)."
    - name: "notification_type"
      expr: notification_type
      comment: "Type of care transition notification."
    - name: "delivery_status"
      expr: delivery_status
      comment: "Delivery status of the notification."
    - name: "notification_status"
      expr: notification_status
      comment: "Overall notification status."
    - name: "event_month"
      expr: DATE_TRUNC('MONTH', event_timestamp)
      comment: "Month bucket of the ADT event for trend analysis."
  measures:
    - name: "Total Notifications"
      expr: COUNT(1)
      comment: "Total care transition notifications — baseline volume."
    - name: "Acknowledgment Rate Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN acknowledgment_received = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of notifications acknowledged by receiver — delivery reliability KPI."
    - name: "CMS ADT Compliance Rate Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN cms_adt_notification_compliant = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of notifications compliant with CMS ADT notification requirements — CoP compliance KPI."
    - name: "PCP Notified Rate Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN pcp_notified_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of transitions where PCP was notified — care coordination KPI."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`interoperability_cda_validation_result`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "C-CDA document validation quality and remediation KPIs. Steers document exchange conformance and regulatory submission readiness."
  source: "`vibe_healthcare_v1`.`interoperability`.`cda_validation_result`"
  dimensions:
    - name: "document_type"
      expr: document_type
      comment: "Type of CDA document validated."
    - name: "validation_status"
      expr: validation_status
      comment: "Overall validation status."
    - name: "conformance_profile"
      expr: conformance_profile
      comment: "Conformance profile evaluated."
    - name: "regulatory_submission_type"
      expr: regulatory_submission_type
      comment: "Regulatory submission context for the document."
  measures:
    - name: "Total Validations"
      expr: COUNT(1)
      comment: "Total CDA validation runs — baseline volume."
    - name: "Avg Total Errors"
      expr: AVG(CAST(total_error_count AS DOUBLE))
      comment: "Average total error count per document — document quality KPI."
    - name: "Schema Pass Rate Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN schema_validation_passed = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of documents passing schema validation — conformance KPI."
    - name: "Submission Ready Rate Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN submission_readiness_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of documents ready for regulatory submission — readiness KPI."
    - name: "Remediation Required Rate Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN remediation_required_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of documents requiring remediation — quality-gap KPI."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`interoperability_direct_message`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Direct secure messaging delivery, encryption, and Meaningful Use KPIs. Steers secure clinical communication reliability."
  source: "`vibe_healthcare_v1`.`interoperability`.`direct_message`"
  dimensions:
    - name: "message_type"
      expr: message_type
      comment: "Type of Direct message."
    - name: "delivery_status"
      expr: delivery_status
      comment: "Delivery status of the message."
    - name: "message_priority"
      expr: message_priority
      comment: "Priority of the message."
    - name: "send_month"
      expr: DATE_TRUNC('MONTH', send_timestamp)
      comment: "Month bucket of send timestamp for trend analysis."
  measures:
    - name: "Total Direct Messages"
      expr: COUNT(1)
      comment: "Total Direct messages sent — baseline volume."
    - name: "Total Message Bytes"
      expr: SUM(CAST(message_size_bytes AS DOUBLE))
      comment: "Total message payload volume in bytes — capacity KPI."
    - name: "HIPAA Compliant Rate Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN hipaa_compliant = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of messages HIPAA-compliant — compliance KPI."
    - name: "Meaningful Use Eligible Rate Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN meaningful_use_eligible = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of messages eligible for Meaningful Use credit — incentive KPI."
    - name: "Read Receipt Rate Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN read_receipt_received = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of messages with read receipts — engagement/reliability KPI."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`interoperability_promoting_interoperability`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "CMS Promoting Interoperability program measure performance and attestation KPIs. Steers incentive-program compliance and reimbursement."
  source: "`vibe_healthcare_v1`.`interoperability`.`promoting_interoperability`"
  dimensions:
    - name: "measure_set"
      expr: measure_set
      comment: "Measure set within the PI program."
    - name: "attestation_status"
      expr: attestation_status
      comment: "Attestation status of the measure."
    - name: "submission_status"
      expr: submission_status
      comment: "Submission status to CMS."
    - name: "program_year"
      expr: program_year
      comment: "Program reporting year."
  measures:
    - name: "Total Measures"
      expr: COUNT(1)
      comment: "Total PI measure records — baseline volume."
    - name: "Avg Performance Rate"
      expr: AVG(CAST(performance_rate AS DOUBLE))
      comment: "Average measure performance rate — program performance KPI."
    - name: "Avg Measure Score"
      expr: AVG(CAST(measure_score AS DOUBLE))
      comment: "Average measure score — incentive scoring KPI."
    - name: "Total Numerator"
      expr: SUM(CAST(numerator_value AS DOUBLE))
      comment: "Total numerator events — measure numerator input."
    - name: "Total Denominator"
      expr: SUM(CAST(denominator_value AS DOUBLE))
      comment: "Total denominator population — measure denominator input."
    - name: "Exclusion Rate Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN exclusion_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of measures claiming exclusion — measure integrity KPI."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`interoperability_public_health_report`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Public health reporting submission and acknowledgment KPIs. Steers electronic case/syndromic/registry reporting compliance."
  source: "`vibe_healthcare_v1`.`interoperability`.`public_health_report`"
  dimensions:
    - name: "report_type"
      expr: report_type
      comment: "Type of public health report."
    - name: "report_category"
      expr: report_category
      comment: "Category of the report."
    - name: "submission_status"
      expr: submission_status
      comment: "Submission status of the report."
    - name: "reporting_jurisdiction"
      expr: reporting_jurisdiction
      comment: "Jurisdiction the report is submitted to."
    - name: "report_month"
      expr: DATE_TRUNC('MONTH', report_date)
      comment: "Month bucket of report date for trend analysis."
  measures:
    - name: "Total Reports"
      expr: COUNT(1)
      comment: "Total public health reports submitted — baseline volume."
    - name: "Acknowledgment Rate Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN acknowledgment_received = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of reports acknowledged by receiving agency — submission reliability KPI."
    - name: "Error Rate Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN error_code IS NOT NULL THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of reports with errors — reporting quality KPI."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`interoperability_hie_transaction`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "HIE transaction volume, cost, and performance KPIs. Steers HIE exchange economics and reliability."
  source: "`vibe_healthcare_v1`.`interoperability`.`hie_transaction`"
  dimensions:
    - name: "transaction_type"
      expr: transaction_type
      comment: "Type of HIE transaction."
    - name: "transaction_direction"
      expr: transaction_direction
      comment: "Direction of the transaction (inbound/outbound)."
    - name: "transaction_status"
      expr: transaction_status
      comment: "Status of the transaction."
    - name: "transaction_month"
      expr: DATE_TRUNC('MONTH', transaction_timestamp)
      comment: "Month bucket of transaction timestamp for trend analysis."
  measures:
    - name: "Total Transactions"
      expr: COUNT(1)
      comment: "Total HIE transactions — baseline exchange volume."
    - name: "Total Transaction Fees"
      expr: SUM(CAST(transaction_fee AS DOUBLE))
      comment: "Total transaction fees incurred — HIE cost KPI."
    - name: "Total Payload Bytes"
      expr: SUM(CAST(payload_size_bytes AS DOUBLE))
      comment: "Total payload volume exchanged in bytes — capacity KPI."
    - name: "Consent Verified Rate Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN consent_verified_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of transactions with verified consent — compliance KPI."
    - name: "Total Documents Exchanged"
      expr: SUM(CAST(document_count AS DOUBLE))
      comment: "Total documents exchanged — exchange yield KPI."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`interoperability_patient_identity_match`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Patient identity matching quality, manual-review, and duplicate KPIs. Steers EMPI data quality and patient safety."
  source: "`vibe_healthcare_v1`.`interoperability`.`patient_identity_match`"
  dimensions:
    - name: "match_status"
      expr: match_status
      comment: "Overall match status."
    - name: "match_confidence_level"
      expr: match_confidence_level
      comment: "Confidence level classification of the match."
    - name: "match_method"
      expr: match_method
      comment: "Method used for matching (deterministic/probabilistic)."
    - name: "transaction_type"
      expr: transaction_type
      comment: "Type of match transaction."
  measures:
    - name: "Total Match Requests"
      expr: COUNT(1)
      comment: "Total identity match requests — baseline volume."
    - name: "Avg Match Score"
      expr: AVG(CAST(match_score AS DOUBLE))
      comment: "Average match score — EMPI quality KPI."
    - name: "Duplicate Rate Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN duplicate_record_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of matches flagged as duplicates — data integrity/patient-safety KPI."
    - name: "Manual Review Rate Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN manual_review_required_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of matches requiring manual review — automation efficiency KPI."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`interoperability_conformance_test`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Interoperability conformance/certification test pass rates. Steers certification readiness and interface quality assurance."
  source: "`vibe_healthcare_v1`.`interoperability`.`conformance_test`"
  dimensions:
    - name: "test_category"
      expr: test_category
      comment: "Category of the conformance test."
    - name: "test_type"
      expr: test_type
      comment: "Type of test executed."
    - name: "pass_fail_status"
      expr: pass_fail_status
      comment: "Pass/fail outcome of the test."
    - name: "certification_program"
      expr: certification_program
      comment: "Certification program the test supports."
    - name: "test_month"
      expr: DATE_TRUNC('MONTH', test_date)
      comment: "Month bucket of test date for trend analysis."
  measures:
    - name: "Total Tests"
      expr: COUNT(1)
      comment: "Total conformance tests executed — baseline volume."
    - name: "Pass Rate Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN pass_fail_status = 'PASS' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of tests passing — certification readiness KPI."
    - name: "Certification Relevant Rate Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN certification_relevant_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of tests relevant to certification — compliance-scope KPI."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`interoperability_onboarding_project`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Trading-partner and interface onboarding project delivery KPIs. Steers integration program throughput and budget."
  source: "`vibe_healthcare_v1`.`interoperability`.`onboarding_project`"
  dimensions:
    - name: "project_status"
      expr: project_status
      comment: "Current status of the onboarding project."
    - name: "project_phase"
      expr: project_phase
      comment: "Current phase of the project."
    - name: "interface_type"
      expr: interface_type
      comment: "Type of interface being onboarded."
    - name: "priority"
      expr: priority
      comment: "Project priority."
  measures:
    - name: "Total Projects"
      expr: COUNT(1)
      comment: "Total onboarding projects — baseline portfolio volume."
    - name: "Avg Percent Complete"
      expr: AVG(CAST(percent_complete AS DOUBLE))
      comment: "Average project completion percentage — delivery-progress KPI."
    - name: "Total Actual Cost"
      expr: SUM(CAST(actual_cost AS DOUBLE))
      comment: "Total actual onboarding cost — program spend KPI."
    - name: "Total Budget"
      expr: SUM(CAST(budget_amount AS DOUBLE))
      comment: "Total budgeted amount — budget baseline for variance analysis."
    - name: "Certification Required Rate Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN certification_required_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of projects requiring certification — compliance-scope KPI."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`interoperability_terminology_mapping`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Terminology mapping coverage, confidence, and governance KPIs. Steers semantic interoperability data quality."
  source: "`vibe_healthcare_v1`.`interoperability`.`terminology_mapping`"
  dimensions:
    - name: "mapping_method"
      expr: mapping_method
      comment: "Method used to create the mapping."
    - name: "mapping_status"
      expr: mapping_status
      comment: "Status of the terminology mapping."
    - name: "equivalence_type"
      expr: equivalence_type
      comment: "Equivalence relationship type of the mapping."
    - name: "governance_approval_status"
      expr: governance_approval_status
      comment: "Governance approval status."
    - name: "use_case_category"
      expr: use_case_category
      comment: "Use case category the mapping supports."
  measures:
    - name: "Total Mappings"
      expr: COUNT(1)
      comment: "Total terminology mappings — baseline coverage volume."
    - name: "Avg Mapping Confidence Score"
      expr: AVG(CAST(mapping_confidence_score AS DOUBLE))
      comment: "Average mapping confidence score — semantic quality KPI."
    - name: "Total Usage Count"
      expr: SUM(CAST(usage_count AS DOUBLE))
      comment: "Total times mappings were used — mapping value/utilization KPI."
    - name: "Total Error Count"
      expr: SUM(CAST(error_count AS DOUBLE))
      comment: "Total mapping errors — data quality risk KPI."
    - name: "Deprecated Rate Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_deprecated = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of mappings deprecated — maintenance/currency KPI."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`interoperability_subscription_notification`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "FHIR Subscription notification delivery KPIs. Steers event-driven interoperability reliability."
  source: "`vibe_healthcare_v1`.`interoperability`.`subscription_notification`"
  dimensions:
    - name: "notification_type"
      expr: notification_type
      comment: "Type of subscription notification."
    - name: "delivery_status"
      expr: delivery_status
      comment: "Delivery status of the notification."
    - name: "notification_channel"
      expr: notification_channel
      comment: "Channel used for the notification (rest-hook, etc.)."
    - name: "resource_type"
      expr: resource_type
      comment: "FHIR resource type triggering the notification."
    - name: "notification_month"
      expr: DATE_TRUNC('MONTH', notification_timestamp)
      comment: "Month bucket of notification timestamp for trend analysis."
  measures:
    - name: "Total Notifications"
      expr: COUNT(1)
      comment: "Total subscription notifications — baseline event volume."
    - name: "Total Payload Bytes"
      expr: SUM(CAST(payload_size_bytes AS DOUBLE))
      comment: "Total notification payload volume in bytes — capacity KPI."
    - name: "Delivery Failure Rate Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN delivery_status = 'FAILED' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of notifications that failed delivery — event reliability KPI."
    - name: "Retry Notification Count"
      expr: COUNT(CASE WHEN retry_count IS NOT NULL AND retry_count <> '0' THEN 1 END)
      comment: "Count of notifications that required retries — delivery robustness KPI."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`interoperability_fhir_resource_log`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "FHIR API access, authorization decision, and Cures Act information-blocking KPIs. Steers API governance and regulatory compliance."
  source: "`vibe_healthcare_v1`.`interoperability`.`fhir_resource_log`"
  dimensions:
    - name: "fhir_resource_type"
      expr: fhir_resource_type
      comment: "FHIR resource type accessed."
    - name: "operation_type"
      expr: operation_type
      comment: "Type of operation performed."
    - name: "access_decision"
      expr: access_decision
      comment: "Access control decision (allow/deny)."
    - name: "request_month"
      expr: DATE_TRUNC('MONTH', request_timestamp)
      comment: "Month bucket of request timestamp for trend analysis."
  measures:
    - name: "Total API Requests"
      expr: COUNT(1)
      comment: "Total FHIR API requests logged — baseline API volume."
    - name: "Denial Rate Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN access_decision = 'DENY' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of API requests denied — access-governance / information-blocking risk KPI."
    - name: "Cures Act Exception Rate Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN cures_act_exception_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of requests invoking a Cures Act information-blocking exception — regulatory compliance KPI."
    - name: "Data Segmentation Rate Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN data_segmentation_applied = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of requests with data segmentation applied — sensitive-data protection KPI."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`interoperability_cda_document`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "CDA document processing and compliance metrics."
  source: "`vibe_healthcare_v1`.`interoperability`.`cda_document`"
  dimensions:
    - name: "document_status"
      expr: document_status
      comment: "Current status of the CDA document."
    - name: "document_type_name"
      expr: document_type_name
      comment: "Document type name."
    - name: "created_date"
      expr: DATE_TRUNC('day', created_timestamp)
      comment: "Date document was created."
    - name: "validation_status"
      expr: validation_status
      comment: "Validation status of the document."
  measures:
    - name: "total_documents"
      expr: COUNT(1)
      comment: "Total number of CDA documents."
    - name: "total_document_size_bytes"
      expr: SUM(CAST(document_size_bytes AS DOUBLE))
      comment: "Sum of document sizes in bytes."
    - name: "validated_documents"
      expr: SUM(CASE WHEN validation_status = 'VALID' THEN 1 ELSE 0 END)
      comment: "Count of documents with validation status VALID."
    - name: "hipaa_compliant_documents"
      expr: SUM(CASE WHEN hipaa_compliant_flag THEN 1 ELSE 0 END)
      comment: "Count of documents marked HIPAA compliant."
$$;