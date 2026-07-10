-- Metric views for domain: interoperability | Business: Healthcare | Version: 2 | Generated on: 2026-07-10 14:53:25

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`interoperability_hie_transaction`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs on HIE message exchange throughput, reliability, and transformation for health information exchange operations."
  source: "`vibe_healthcare_v1`.`interoperability`.`hie_transaction`"
  dimensions:
    - name: "direction"
      expr: direction
      comment: "Inbound vs outbound transaction direction for exchange flow analysis."
    - name: "transaction_type"
      expr: transaction_type
      comment: "Type of HIE transaction for categorizing exchange traffic."
    - name: "transaction_status"
      expr: hie_transaction_status
      comment: "Processing status of the transaction (success, error, pending)."
    - name: "message_standard"
      expr: message_standard
      comment: "Messaging standard used (HL7v2, FHIR, CDA) for standards-adoption tracking."
    - name: "priority"
      expr: priority
      comment: "Transaction priority for SLA prioritization analysis."
    - name: "transaction_month"
      expr: DATE_TRUNC('MONTH', transaction_timestamp)
      comment: "Transaction month bucket for trend analysis."
  measures:
    - name: "total_transactions"
      expr: COUNT(1)
      comment: "Total HIE transactions exchanged — core exchange volume KPI."
    - name: "distinct_hie_organizations"
      expr: COUNT(DISTINCT hie_organization_id)
      comment: "Distinct HIE organizations exchanged with — network reach indicator."
    - name: "transformed_transaction_count"
      expr: COUNT(CASE WHEN transformation_applied = TRUE THEN 1 END)
      comment: "Transactions requiring transformation — interoperability friction indicator."
    - name: "avg_processing_duration_ms"
      expr: AVG(CAST(processing_duration_ms AS DOUBLE))
      comment: "Average processing latency in ms — exchange performance KPI."
    - name: "error_transaction_count"
      expr: COUNT(CASE WHEN error_code IS NOT NULL THEN 1 END)
      comment: "Transactions with an error code — reliability failure count."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`interoperability_message_log`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Interface message processing KPIs measuring throughput, latency, SLA adherence, and data quality across integration channels."
  source: "`vibe_healthcare_v1`.`interoperability`.`message_log`"
  dimensions:
    - name: "message_type"
      expr: message_type
      comment: "Type of message processed for traffic-mix analysis."
    - name: "processing_status"
      expr: processing_status
      comment: "Processing outcome status of the message."
    - name: "validation_status"
      expr: validation_status
      comment: "Validation outcome for data-quality analysis."
    - name: "message_standard"
      expr: message_standard
      comment: "Messaging standard used for standards tracking."
    - name: "received_month"
      expr: DATE_TRUNC('MONTH', received_timestamp)
      comment: "Month of message receipt for volume trend analysis."
  measures:
    - name: "total_messages"
      expr: COUNT(1)
      comment: "Total messages processed — integration throughput KPI."
    - name: "avg_processing_latency_ms"
      expr: AVG(CAST(processing_latency_ms AS DOUBLE))
      comment: "Average processing latency in ms — interface performance KPI."
    - name: "sla_met_count"
      expr: COUNT(CASE WHEN sla_met = TRUE THEN 1 END)
      comment: "Messages meeting SLA — SLA adherence numerator."
    - name: "duplicate_message_count"
      expr: COUNT(CASE WHEN is_duplicate = TRUE THEN 1 END)
      comment: "Duplicate messages detected — data-quality issue indicator."
    - name: "error_message_count"
      expr: COUNT(CASE WHEN error_code IS NOT NULL THEN 1 END)
      comment: "Messages with errors — reliability failure count."
    - name: "total_payload_bytes"
      expr: SUM(CAST(payload_size_bytes AS DOUBLE))
      comment: "Total payload volume in bytes — data transfer volume KPI."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`interoperability_message_error`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Interface error management KPIs measuring error volume, severity, resolution timeliness, and SLA breaches."
  source: "`vibe_healthcare_v1`.`interoperability`.`message_error`"
  dimensions:
    - name: "error_category"
      expr: error_category
      comment: "Category of the interface error for root-cause grouping."
    - name: "error_severity"
      expr: error_severity
      comment: "Severity of the error for triage prioritization."
    - name: "resolution_status"
      expr: resolution_status
      comment: "Current resolution status of the error."
    - name: "root_cause_category"
      expr: root_cause_category
      comment: "Root-cause category for systemic issue analysis."
    - name: "error_month"
      expr: DATE_TRUNC('MONTH', error_timestamp)
      comment: "Month the error occurred for trend analysis."
  measures:
    - name: "total_errors"
      expr: COUNT(1)
      comment: "Total interface errors — operational reliability KPI."
    - name: "escalated_error_count"
      expr: COUNT(CASE WHEN escalation_flag = TRUE THEN 1 END)
      comment: "Errors escalated — severity/backlog indicator."
    - name: "sla_breach_count"
      expr: COUNT(CASE WHEN sla_breach_flag = TRUE THEN 1 END)
      comment: "Errors breaching resolution SLA — service quality failure count."
    - name: "avg_resolution_minutes"
      expr: AVG(CAST(actual_resolution_minutes AS DOUBLE))
      comment: "Average error resolution time in minutes — responsiveness KPI."
    - name: "retry_eligible_count"
      expr: COUNT(CASE WHEN retry_eligible_flag = TRUE THEN 1 END)
      comment: "Errors eligible for retry — recoverability indicator."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`interoperability_interface_downtime`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Interface availability KPIs measuring downtime duration, message loss, SLA breaches, and incident impact."
  source: "`vibe_healthcare_v1`.`interoperability`.`interface_downtime`"
  dimensions:
    - name: "downtime_type"
      expr: downtime_type
      comment: "Type of downtime (planned, unplanned) for availability analysis."
    - name: "downtime_status"
      expr: downtime_status
      comment: "Current status of the downtime event."
    - name: "impact_severity"
      expr: impact_severity
      comment: "Severity of business impact for prioritization."
    - name: "root_cause_category"
      expr: root_cause_category
      comment: "Root-cause category for reliability improvement."
    - name: "downtime_month"
      expr: DATE_TRUNC('MONTH', downtime_start_timestamp)
      comment: "Month of downtime start for trend analysis."
  measures:
    - name: "total_downtime_events"
      expr: COUNT(1)
      comment: "Total downtime incidents — availability risk KPI."
    - name: "total_downtime_minutes"
      expr: SUM(CAST(downtime_duration_minutes AS DOUBLE))
      comment: "Total downtime minutes — cumulative unavailability KPI."
    - name: "avg_downtime_minutes"
      expr: AVG(CAST(downtime_duration_minutes AS DOUBLE))
      comment: "Average incident duration in minutes — mean time to recovery indicator."
    - name: "total_messages_lost"
      expr: SUM(CAST(messages_lost_count AS DOUBLE))
      comment: "Total messages lost during downtime — data-loss impact KPI."
    - name: "sla_breach_count"
      expr: COUNT(CASE WHEN sla_breach_flag = TRUE THEN 1 END)
      comment: "Downtime events breaching uptime SLA — SLA violation count."
    - name: "avg_actual_uptime_pct"
      expr: AVG(CAST(actual_uptime_percentage AS DOUBLE))
      comment: "Average actual uptime percentage — availability performance KPI."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`interoperability_care_transition_notification`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Care transition notification KPIs measuring delivery success, SLA adherence, and CMS interoperability compliance for ADT event notifications."
  source: "`vibe_healthcare_v1`.`interoperability`.`care_transition_notification`"
  dimensions:
    - name: "event_type"
      expr: event_type
      comment: "ADT event type triggering the notification."
    - name: "delivery_status"
      expr: delivery_status
      comment: "Delivery status of the notification."
    - name: "notification_priority"
      expr: notification_priority
      comment: "Priority of the notification for SLA analysis."
    - name: "receiving_party_type"
      expr: receiving_party_type
      comment: "Type of receiving party for routing analysis."
    - name: "event_month"
      expr: DATE_TRUNC('MONTH', event_timestamp)
      comment: "Month of the triggering event for trend analysis."
  measures:
    - name: "total_notifications"
      expr: COUNT(1)
      comment: "Total care transition notifications sent — care coordination volume KPI."
    - name: "acknowledged_count"
      expr: COUNT(CASE WHEN acknowledgment_received_flag = TRUE THEN 1 END)
      comment: "Notifications acknowledged by recipients — closed-loop indicator."
    - name: "sla_breach_count"
      expr: COUNT(CASE WHEN sla_breach_flag = TRUE THEN 1 END)
      comment: "Notifications breaching delivery SLA — timeliness failure count."
    - name: "cms_compliant_count"
      expr: COUNT(CASE WHEN cms_interoperability_compliant_flag = TRUE THEN 1 END)
      comment: "CMS interoperability compliant notifications — regulatory compliance KPI."
    - name: "distinct_patients"
      expr: COUNT(DISTINCT demographics_id)
      comment: "Distinct patients with care transition notifications — reach KPI."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`interoperability_fhir_resource_log`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "FHIR API access KPIs measuring request volume, access decisions, denials, and performance for patient/provider access API operations."
  source: "`vibe_healthcare_v1`.`interoperability`.`fhir_resource_log`"
  dimensions:
    - name: "fhir_resource_type"
      expr: fhir_resource_type
      comment: "FHIR resource type accessed for API usage analysis."
    - name: "operation_type"
      expr: operation_type
      comment: "FHIR operation type (read, write, search)."
    - name: "access_decision"
      expr: access_decision
      comment: "Access control decision (granted/denied) for governance analysis."
    - name: "request_method"
      expr: request_method
      comment: "HTTP request method for traffic analysis."
    - name: "request_month"
      expr: DATE_TRUNC('MONTH', request_timestamp)
      comment: "Month of request for API adoption trend analysis."
  measures:
    - name: "total_requests"
      expr: COUNT(1)
      comment: "Total FHIR API requests — interoperability API adoption KPI."
    - name: "denied_request_count"
      expr: COUNT(CASE WHEN access_decision = 'DENIED' THEN 1 END)
      comment: "Denied access requests — access-control friction indicator."
    - name: "cures_exception_count"
      expr: COUNT(CASE WHEN cures_act_exception_flag = TRUE THEN 1 END)
      comment: "Requests invoking Cures Act information-blocking exception — regulatory tracking KPI."
    - name: "avg_response_time_ms"
      expr: AVG(CAST(response_time_ms AS DOUBLE))
      comment: "Average API response time in ms — API performance KPI."
    - name: "distinct_patients_accessed"
      expr: COUNT(DISTINCT demographics_id)
      comment: "Distinct patients whose FHIR data was accessed — access breadth indicator."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`interoperability_patient_identity_match`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Patient identity matching (EMPI) KPIs measuring match confidence, manual review burden, and duplicate detection critical to identity integrity."
  source: "`vibe_healthcare_v1`.`interoperability`.`patient_identity_match`"
  dimensions:
    - name: "match_result_status"
      expr: match_result_status
      comment: "Outcome status of the identity match."
    - name: "match_confidence_level"
      expr: match_confidence_level
      comment: "Confidence level of the match for quality analysis."
    - name: "match_method"
      expr: match_method
      comment: "Matching method used (deterministic, probabilistic)."
    - name: "match_month"
      expr: DATE_TRUNC('MONTH', match_request_timestamp)
      comment: "Month of match request for trend analysis."
  measures:
    - name: "total_match_requests"
      expr: COUNT(1)
      comment: "Total identity match requests — EMPI throughput KPI."
    - name: "avg_match_score"
      expr: AVG(CAST(match_score AS DOUBLE))
      comment: "Average match confidence score — matching quality KPI."
    - name: "manual_review_count"
      expr: COUNT(CASE WHEN manual_review_required_flag = TRUE THEN 1 END)
      comment: "Matches requiring manual review — operational burden indicator."
    - name: "duplicate_record_count"
      expr: COUNT(CASE WHEN duplicate_record_flag = TRUE THEN 1 END)
      comment: "Duplicate records identified — data integrity KPI."
    - name: "consent_override_count"
      expr: COUNT(CASE WHEN consent_override_flag = TRUE THEN 1 END)
      comment: "Matches with consent override — compliance risk indicator."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`interoperability_hie_query`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "HIE patient query KPIs measuring query volume, response performance, consent verification, and match confidence for document retrieval."
  source: "`vibe_healthcare_v1`.`interoperability`.`hie_query`"
  dimensions:
    - name: "query_type"
      expr: query_type
      comment: "Type of HIE query for usage analysis."
    - name: "query_status"
      expr: query_status
      comment: "Outcome status of the query."
    - name: "query_priority"
      expr: query_priority
      comment: "Priority of the query for SLA analysis."
    - name: "data_sensitivity_level"
      expr: data_sensitivity_level
      comment: "Sensitivity level of queried data for privacy governance."
    - name: "query_month"
      expr: DATE_TRUNC('MONTH', query_timestamp)
      comment: "Month of query for adoption trend analysis."
  measures:
    - name: "total_queries"
      expr: COUNT(1)
      comment: "Total HIE queries executed — network utilization KPI."
    - name: "avg_response_time_seconds"
      expr: AVG(CAST(query_response_time_seconds AS DOUBLE))
      comment: "Average query response time in seconds — network performance KPI."
    - name: "avg_match_confidence_score"
      expr: AVG(CAST(match_confidence_score AS DOUBLE))
      comment: "Average patient match confidence score for query resolution quality."
    - name: "consent_verified_count"
      expr: COUNT(CASE WHEN consent_verified = TRUE THEN 1 END)
      comment: "Queries with verified consent — compliance KPI."
    - name: "error_query_count"
      expr: COUNT(CASE WHEN error_code IS NOT NULL THEN 1 END)
      comment: "Queries returning errors — reliability failure count."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`interoperability_conformance_test`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Interoperability conformance testing KPIs measuring pass rates, certification readiness, and remediation for trading-partner onboarding."
  source: "`vibe_healthcare_v1`.`interoperability`.`conformance_test`"
  dimensions:
    - name: "conformance_status"
      expr: conformance_status
      comment: "Conformance outcome status of the test."
    - name: "test_result"
      expr: test_result
      comment: "Overall result of the conformance test."
    - name: "go_live_readiness_status"
      expr: go_live_readiness_status
      comment: "Go-live readiness status for onboarding gating."
    - name: "test_scope"
      expr: test_scope
      comment: "Scope of the conformance test."
    - name: "test_month"
      expr: DATE_TRUNC('MONTH', test_execution_timestamp)
      comment: "Month of test execution for onboarding progress tracking."
  measures:
    - name: "total_tests"
      expr: COUNT(1)
      comment: "Total conformance tests executed — certification pipeline KPI."
    - name: "avg_pass_percentage"
      expr: AVG(CAST(pass_percentage AS DOUBLE))
      comment: "Average test pass percentage — certification quality KPI."
    - name: "remediation_required_count"
      expr: COUNT(CASE WHEN remediation_required_flag = TRUE THEN 1 END)
      comment: "Tests requiring remediation — onboarding blocker indicator."
    - name: "retest_required_count"
      expr: COUNT(CASE WHEN retest_required_flag = TRUE THEN 1 END)
      comment: "Tests requiring retest — rework indicator."
    - name: "distinct_partners_tested"
      expr: COUNT(DISTINCT trading_partner_id)
      comment: "Distinct trading partners under conformance testing — onboarding breadth KPI."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`interoperability_fhir_endpoint`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "FHIR endpoint reliability and compliance KPIs measuring uptime, request load, and regulatory API enablement."
  source: "`vibe_healthcare_v1`.`interoperability`.`fhir_endpoint`"
  dimensions:
    - name: "endpoint_type"
      expr: endpoint_type
      comment: "Type of FHIR endpoint for portfolio analysis."
    - name: "operational_status"
      expr: operational_status
      comment: "Operational status of the endpoint."
    - name: "fhir_version"
      expr: fhir_version
      comment: "FHIR version supported by the endpoint."
    - name: "environment"
      expr: environment
      comment: "Deployment environment (prod, test) for scope analysis."
  measures:
    - name: "total_endpoints"
      expr: COUNT(1)
      comment: "Total FHIR endpoints registered — API surface KPI."
    - name: "avg_uptime_percentage"
      expr: AVG(CAST(uptime_percentage AS DOUBLE))
      comment: "Average endpoint uptime percentage — reliability KPI."
    - name: "avg_response_time_ms"
      expr: AVG(CAST(average_response_time_ms AS DOUBLE))
      comment: "Average endpoint response time in ms — performance KPI."
    - name: "total_requests_30d"
      expr: SUM(CAST(total_requests_last_30_days AS DOUBLE))
      comment: "Total requests over last 30 days — API demand KPI."
    - name: "patient_access_api_count"
      expr: COUNT(CASE WHEN patient_access_api_flag = TRUE THEN 1 END)
      comment: "Endpoints enabled for CMS Patient Access API — regulatory compliance KPI."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`interoperability_public_health_report`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Public health reporting KPIs measuring submission volume, acknowledgment success, and PHI handling for mandatory reporting compliance."
  source: "`vibe_healthcare_v1`.`interoperability`.`public_health_report`"
  dimensions:
    - name: "report_type"
      expr: report_type
      comment: "Type of public health report for category analysis."
    - name: "submission_status"
      expr: submission_status
      comment: "Submission status of the report."
    - name: "jurisdiction_code"
      expr: jurisdiction_code
      comment: "Reporting jurisdiction for regulatory coverage analysis."
    - name: "submission_month"
      expr: DATE_TRUNC('MONTH', submission_timestamp)
      comment: "Month of submission for reporting cadence analysis."
  measures:
    - name: "total_reports"
      expr: COUNT(1)
      comment: "Total public health reports submitted — mandatory reporting volume KPI."
    - name: "acknowledged_count"
      expr: COUNT(CASE WHEN acknowledgment_code IS NOT NULL THEN 1 END)
      comment: "Reports acknowledged by agencies — closed-loop reporting indicator."
    - name: "attestation_eligible_count"
      expr: COUNT(CASE WHEN attestation_eligible_flag = TRUE THEN 1 END)
      comment: "Reports eligible for Promoting Interoperability attestation — incentive KPI."
    - name: "distinct_patients"
      expr: COUNT(DISTINCT mpi_record_id)
      comment: "Distinct patients in public health reports — case reach indicator."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`interoperability_promoting_interoperability`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "CMS Promoting Interoperability performance KPIs measuring attestation, performance rates, and payment adjustments for MIPS/APM programs."
  source: "`vibe_healthcare_v1`.`interoperability`.`promoting_interoperability`"
  dimensions:
    - name: "measure_category"
      expr: measure_category
      comment: "PI measure category for scorecard grouping."
    - name: "attestation_status"
      expr: attestation_status
      comment: "Attestation status for program compliance."
    - name: "cms_program_year"
      expr: cms_program_year
      comment: "CMS program year for period comparison."
    - name: "reporting_entity_type"
      expr: reporting_entity_type
      comment: "Reporting entity type (individual, group) for reporting analysis."
  measures:
    - name: "total_measures"
      expr: COUNT(1)
      comment: "Total PI measure submissions — program participation KPI."
    - name: "avg_performance_rate"
      expr: AVG(CAST(performance_rate AS DOUBLE))
      comment: "Average performance rate across measures — PI scorecard KPI."
    - name: "performance_met_count"
      expr: COUNT(CASE WHEN performance_met_flag = TRUE THEN 1 END)
      comment: "Measures meeting performance threshold — incentive-earning indicator."
    - name: "avg_payment_adjustment_pct"
      expr: AVG(CAST(payment_adjustment_percentage AS DOUBLE))
      comment: "Average payment adjustment percentage — financial impact KPI."
    - name: "avg_data_completeness_pct"
      expr: AVG(CAST(data_completeness_percentage AS DOUBLE))
      comment: "Average data completeness percentage — reporting quality KPI."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`interoperability_onboarding_project`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Interface onboarding project KPIs measuring budget variance, delivery status, and go-live progress for trading-partner integration."
  source: "`vibe_healthcare_v1`.`interoperability`.`onboarding_project`"
  dimensions:
    - name: "project_status"
      expr: project_status
      comment: "Status of the onboarding project."
    - name: "project_phase"
      expr: project_phase
      comment: "Current phase of the onboarding project."
    - name: "risk_level"
      expr: risk_level
      comment: "Assessed risk level for portfolio risk management."
    - name: "interface_type"
      expr: interface_type
      comment: "Type of interface being onboarded."
  measures:
    - name: "total_projects"
      expr: COUNT(1)
      comment: "Total onboarding projects — integration pipeline KPI."
    - name: "total_budget_amount"
      expr: SUM(CAST(budget_amount AS DOUBLE))
      comment: "Total budgeted cost across projects — investment KPI."
    - name: "total_actual_cost"
      expr: SUM(CAST(actual_cost AS DOUBLE))
      comment: "Total actual cost across projects — spend KPI for budget variance."
    - name: "certification_required_count"
      expr: COUNT(CASE WHEN certification_required_flag = TRUE THEN 1 END)
      comment: "Projects requiring certification — compliance workload indicator."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`interoperability_subscription_notification`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "FHIR subscription notification delivery KPIs measuring delivery success, latency, and SLA breaches for event-driven interoperability."
  source: "`vibe_healthcare_v1`.`interoperability`.`subscription_notification`"
  dimensions:
    - name: "delivery_status"
      expr: delivery_status
      comment: "Delivery status of the notification."
    - name: "triggering_event_type"
      expr: triggering_event_type
      comment: "Event type triggering the notification."
    - name: "failure_reason_category"
      expr: failure_reason_category
      comment: "Category of delivery failure for root-cause analysis."
    - name: "priority"
      expr: priority
      comment: "Notification priority for SLA analysis."
    - name: "notification_month"
      expr: DATE_TRUNC('MONTH', notification_timestamp)
      comment: "Month of notification for trend analysis."
  measures:
    - name: "total_notifications"
      expr: COUNT(1)
      comment: "Total subscription notifications delivered — event-driven volume KPI."
    - name: "acknowledged_count"
      expr: COUNT(CASE WHEN acknowledgment_received_flag = TRUE THEN 1 END)
      comment: "Notifications acknowledged — delivery confirmation indicator."
    - name: "sla_breach_count"
      expr: COUNT(CASE WHEN sla_breach_flag = TRUE THEN 1 END)
      comment: "Notifications breaching delivery SLA — timeliness failure count."
    - name: "avg_delivery_latency_ms"
      expr: AVG(CAST(delivery_latency_milliseconds AS DOUBLE))
      comment: "Average delivery latency in ms — notification performance KPI."
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