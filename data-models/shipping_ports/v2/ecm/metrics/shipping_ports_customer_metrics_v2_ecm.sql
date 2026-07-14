-- Metric views for domain: customer | Business: Shipping_Ports | Version: 2 | Generated on: 2026-07-13 07:51:56

CREATE OR REPLACE VIEW `vibe_shipping_ports_v1`.`_metrics`.`customer_participant_account`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Financial health and portfolio KPIs for customer participant accounts — credit utilisation, outstanding balances, overdue exposure, and account tier distribution. Used by credit risk, commercial, and finance teams to steer credit policy and customer portfolio management."
  source: "`vibe_shipping_ports_v1`.`customer`.`participant_account`"
  dimensions:
    - name: "account_status"
      expr: account_status
      comment: "Current lifecycle status of the account (active, suspended, closed) for portfolio segmentation."
    - name: "account_tier"
      expr: account_tier
      comment: "Commercial tier of the account (e.g., platinum, gold, standard) for tiered analysis."
    - name: "account_type"
      expr: account_type
      comment: "Type of account (shipping line, freight forwarder, customs broker, etc.) for segment-level reporting."
    - name: "currency_code"
      expr: currency_code
      comment: "Billing currency of the account for multi-currency portfolio analysis."
    - name: "payment_terms_code"
      expr: payment_terms_code
      comment: "Payment terms assigned to the account (e.g., NET30, NET60) for cash-flow planning."
    - name: "service_line"
      expr: service_line
      comment: "Port service line the account is associated with (container, bulk, RoRo, etc.)."
    - name: "sla_tier_code"
      expr: sla_tier_code
      comment: "SLA tier assigned to the account for service-level segmentation."
    - name: "credit_rating"
      expr: credit_rating
      comment: "Internal credit rating of the account for risk-band analysis."
    - name: "billing_cycle"
      expr: billing_cycle
      comment: "Billing cycle frequency (monthly, weekly, etc.) for revenue timing analysis."
    - name: "account_open_date_month"
      expr: DATE_TRUNC('MONTH', account_open_date)
      comment: "Month the account was opened, for cohort and vintage analysis."
  measures:
    - name: "total_accounts"
      expr: COUNT(1)
      comment: "Total number of participant accounts. Baseline portfolio size metric used to track growth and churn."
    - name: "active_accounts"
      expr: COUNT(CASE WHEN account_status = 'ACTIVE' THEN 1 END)
      comment: "Number of currently active accounts. Tracks the live revenue-generating customer base."
    - name: "total_credit_limit"
      expr: SUM(CAST(credit_limit AS DOUBLE))
      comment: "Total approved credit extended across all accounts. Measures aggregate credit exposure for risk management."
    - name: "total_outstanding_balance"
      expr: SUM(CAST(outstanding_balance AS DOUBLE))
      comment: "Total outstanding receivables across all accounts. Key AR metric for cash-flow and collections management."
    - name: "total_overdue_amount"
      expr: SUM(CAST(overdue_amount AS DOUBLE))
      comment: "Total overdue receivables across all accounts. Drives collections prioritisation and bad-debt provisioning."
    - name: "avg_credit_utilisation_pct"
      expr: AVG(CAST(credit_utilisation_pct AS DOUBLE))
      comment: "Average credit utilisation percentage across accounts. Signals portfolio-level credit stress when trending upward."
    - name: "avg_discount_rate_pct"
      expr: AVG(CAST(discount_rate_pct AS DOUBLE))
      comment: "Average discount rate granted across accounts. Informs commercial pricing and margin leakage analysis."
    - name: "total_deposit_held"
      expr: SUM(CAST(deposit_amount AS DOUBLE))
      comment: "Total security deposits held from customers. Represents collateral buffer against credit risk."
    - name: "accounts_with_auto_suspension"
      expr: COUNT(CASE WHEN auto_suspension_enabled = TRUE THEN 1 END)
      comment: "Number of accounts with automatic suspension enabled. Indicates risk-managed accounts requiring monitoring."
    - name: "avg_last_payment_amount"
      expr: AVG(CAST(last_payment_amount AS DOUBLE))
      comment: "Average value of the most recent payment per account. Proxy for typical payment behaviour and account activity level."
$$;

CREATE OR REPLACE VIEW `vibe_shipping_ports_v1`.`_metrics`.`customer_credit_assessment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Credit risk KPIs derived from formal credit assessments — approved limits, credit scores, risk categories, and assessment pipeline throughput. Used by credit risk officers and finance leadership to manage customer credit exposure and approval workflows."
  source: "`vibe_shipping_ports_v1`.`customer`.`credit_assessment`"
  dimensions:
    - name: "assessment_status"
      expr: assessment_status
      comment: "Current status of the credit assessment (pending, approved, rejected, under review)."
    - name: "assessment_type"
      expr: assessment_type
      comment: "Type of assessment (new, renewal, limit increase, periodic review) for pipeline analysis."
    - name: "risk_category"
      expr: risk_category
      comment: "Risk band assigned to the customer (low, medium, high, very high) for portfolio risk segmentation."
    - name: "credit_rating"
      expr: credit_rating
      comment: "Credit rating assigned during assessment for rating-band analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which the credit limit is denominated."
    - name: "payment_terms_code"
      expr: payment_terms_code
      comment: "Payment terms recommended or assigned as part of the assessment."
    - name: "assessment_date_month"
      expr: DATE_TRUNC('MONTH', assessment_date)
      comment: "Month of assessment for trend and throughput analysis."
    - name: "approval_level"
      expr: approval_level
      comment: "Approval authority level required (e.g., manager, director, CFO) for governance reporting."
    - name: "is_watch_list"
      expr: is_watch_list
      comment: "Flag indicating whether the customer is on the credit watch list."
  measures:
    - name: "total_assessments"
      expr: COUNT(1)
      comment: "Total number of credit assessments conducted. Measures credit team workload and pipeline volume."
    - name: "approved_assessments"
      expr: COUNT(CASE WHEN assessment_status = 'APPROVED' THEN 1 END)
      comment: "Number of assessments resulting in approval. Used to compute approval rate and track credit policy outcomes."
    - name: "rejected_assessments"
      expr: COUNT(CASE WHEN assessment_status = 'REJECTED' THEN 1 END)
      comment: "Number of assessments rejected. Tracks rejection rate and informs onboarding quality."
    - name: "watch_list_accounts"
      expr: COUNT(CASE WHEN is_watch_list = TRUE THEN 1 END)
      comment: "Number of customers currently on the credit watch list. Key risk management indicator for proactive intervention."
    - name: "total_approved_credit_limit"
      expr: SUM(CAST(approved_credit_limit AS DOUBLE))
      comment: "Total credit limit approved across all assessments. Measures aggregate credit exposure authorised by the business."
    - name: "avg_approved_credit_limit"
      expr: AVG(CAST(approved_credit_limit AS DOUBLE))
      comment: "Average approved credit limit per assessment. Benchmarks credit generosity and informs limit-setting policy."
    - name: "avg_credit_score"
      expr: AVG(CAST(credit_score AS DOUBLE))
      comment: "Average credit score across assessed customers. Portfolio-level credit quality indicator."
    - name: "total_security_deposit_required"
      expr: SUM(CAST(security_deposit_amount AS DOUBLE))
      comment: "Total security deposits required across assessments. Measures collateral demanded to mitigate credit risk."
    - name: "avg_outstanding_balance_at_assessment"
      expr: AVG(CAST(outstanding_balance AS DOUBLE))
      comment: "Average outstanding balance at time of assessment. Indicates typical exposure level when credit is reviewed."
    - name: "total_requested_credit_limit"
      expr: SUM(CAST(requested_credit_limit AS DOUBLE))
      comment: "Total credit limit requested by customers. Compared against approved limits to measure credit policy conservatism."
$$;

CREATE OR REPLACE VIEW `vibe_shipping_ports_v1`.`_metrics`.`customer_service_request`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Customer service operations KPIs — request volumes, SLA breach rates, escalation rates, resolution performance, and dispute exposure. Used by customer service management and operations leadership to drive service quality and SLA compliance."
  source: "`vibe_shipping_ports_v1`.`customer`.`service_request`"
  dimensions:
    - name: "request_status"
      expr: request_status
      comment: "Current status of the service request (open, in progress, resolved, closed) for pipeline management."
    - name: "request_type"
      expr: request_type
      comment: "Type of service request (billing dispute, documentation, vessel query, etc.) for category analysis."
    - name: "service_request_category"
      expr: service_request_category
      comment: "Business category of the request for operational routing and reporting."
    - name: "priority"
      expr: priority
      comment: "Priority level of the request (critical, high, medium, low) for workload management."
    - name: "channel"
      expr: channel
      comment: "Channel through which the request was submitted (portal, email, phone, EDI) for channel effectiveness analysis."
    - name: "escalation_flag"
      expr: escalation_flag
      comment: "Whether the request has been escalated, for escalation rate tracking."
    - name: "sla_response_breached"
      expr: sla_response_breached
      comment: "Whether the SLA response target was breached, for SLA compliance reporting."
    - name: "sla_resolution_breached"
      expr: sla_resolution_breached
      comment: "Whether the SLA resolution target was breached, for resolution SLA compliance reporting."
    - name: "imdg_related"
      expr: imdg_related
      comment: "Whether the request relates to dangerous goods (IMDG), for safety-critical request tracking."
    - name: "isps_related"
      expr: isps_related
      comment: "Whether the request relates to ISPS security matters, for security-sensitive request tracking."
    - name: "created_month"
      expr: DATE_TRUNC('MONTH', created_timestamp)
      comment: "Month the request was created for trend and volume analysis."
  measures:
    - name: "total_service_requests"
      expr: COUNT(1)
      comment: "Total number of service requests. Baseline volume metric for customer service capacity planning."
    - name: "open_service_requests"
      expr: COUNT(CASE WHEN request_status NOT IN ('CLOSED', 'RESOLVED') THEN 1 END)
      comment: "Number of currently open/in-progress requests. Measures backlog and team workload."
    - name: "escalated_requests"
      expr: COUNT(CASE WHEN escalation_flag = TRUE THEN 1 END)
      comment: "Number of escalated service requests. High escalation rates signal systemic service quality issues."
    - name: "sla_response_breaches"
      expr: COUNT(CASE WHEN sla_response_breached = TRUE THEN 1 END)
      comment: "Number of requests where the SLA response target was breached. Directly measures response SLA compliance."
    - name: "sla_resolution_breaches"
      expr: COUNT(CASE WHEN sla_resolution_breached = TRUE THEN 1 END)
      comment: "Number of requests where the SLA resolution target was breached. Measures resolution SLA compliance."
    - name: "total_dispute_amount"
      expr: SUM(CAST(dispute_amount AS DOUBLE))
      comment: "Total financial value of disputes raised via service requests. Measures financial exposure from customer disputes."
    - name: "avg_dispute_amount"
      expr: AVG(CAST(dispute_amount AS DOUBLE))
      comment: "Average dispute amount per service request. Benchmarks typical dispute size for provisioning and resolution prioritisation."
    - name: "unique_customers_with_requests"
      expr: COUNT(DISTINCT port_community_participant_id)
      comment: "Number of distinct customers who raised service requests. Measures breadth of service issues across the customer base."
    - name: "imdg_related_requests"
      expr: COUNT(CASE WHEN imdg_related = TRUE THEN 1 END)
      comment: "Number of service requests related to dangerous goods. Safety-critical volume requiring priority handling under IMDG regulations."
    - name: "isps_related_requests"
      expr: COUNT(CASE WHEN isps_related = TRUE THEN 1 END)
      comment: "Number of service requests related to ISPS security matters. Tracks security-sensitive customer interactions."
$$;

CREATE OR REPLACE VIEW `vibe_shipping_ports_v1`.`_metrics`.`customer_sla_performance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "SLA performance measurement KPIs — breach rates, penalty exposure, variance from target, and remediation status. Used by operations directors and commercial teams to manage contractual service commitments and penalty liability."
  source: "`vibe_shipping_ports_v1`.`customer`.`sla_performance`"
  dimensions:
    - name: "metric_name"
      expr: metric_name
      comment: "Name of the SLA metric being measured (e.g., vessel turnaround time, gate processing time) for KPI-level drill-down."
    - name: "metric_category"
      expr: metric_category
      comment: "Category of the SLA metric (operational, commercial, safety) for portfolio-level analysis."
    - name: "service_type"
      expr: service_type
      comment: "Type of port service the SLA applies to (container handling, vessel services, gate operations, etc.)."
    - name: "breach_flag"
      expr: breach_flag
      comment: "Whether the SLA was breached in this measurement period."
    - name: "breach_severity"
      expr: breach_severity
      comment: "Severity of the breach (minor, major, critical) for prioritised remediation."
    - name: "breach_direction"
      expr: breach_direction
      comment: "Direction of breach (above/below target) to distinguish over-performance from under-performance."
    - name: "penalty_applicable_flag"
      expr: penalty_applicable_flag
      comment: "Whether a financial penalty applies to this SLA breach."
    - name: "measurement_period_type"
      expr: measurement_period_type
      comment: "Granularity of the measurement period (daily, weekly, monthly) for time-series analysis."
    - name: "customer_segment"
      expr: customer_segment
      comment: "Customer segment associated with the SLA measurement for segment-level performance comparison."
    - name: "remediation_status"
      expr: remediation_status
      comment: "Status of remediation actions taken following a breach."
    - name: "measurement_period_start_month"
      expr: DATE_TRUNC('MONTH', measurement_period_start)
      comment: "Month of the measurement period start for trend analysis."
  measures:
    - name: "total_sla_measurements"
      expr: COUNT(1)
      comment: "Total number of SLA measurement records. Baseline for computing breach rates and coverage."
    - name: "total_sla_breaches"
      expr: COUNT(CASE WHEN breach_flag = TRUE THEN 1 END)
      comment: "Total number of SLA breaches. Primary SLA compliance KPI used in customer reviews and contract management."
    - name: "total_penalty_amount"
      expr: SUM(CAST(penalty_amount AS DOUBLE))
      comment: "Total financial penalties incurred from SLA breaches. Measures contractual liability exposure and P&L impact."
    - name: "avg_variance_percentage"
      expr: AVG(CAST(variance_percentage AS DOUBLE))
      comment: "Average percentage variance from SLA target. Measures how far performance deviates from contractual commitments on average."
    - name: "avg_actual_value"
      expr: AVG(CAST(actual_value AS DOUBLE))
      comment: "Average actual measured value across SLA metrics. Compared against target to assess overall service delivery level."
    - name: "avg_target_value"
      expr: AVG(CAST(target_value AS DOUBLE))
      comment: "Average SLA target value across measurements. Provides the benchmark baseline for performance comparison."
    - name: "penalty_applicable_breaches"
      expr: COUNT(CASE WHEN penalty_applicable_flag = TRUE AND breach_flag = TRUE THEN 1 END)
      comment: "Number of breaches that trigger financial penalties. Directly measures contractual penalty exposure count."
    - name: "unique_customers_with_breaches"
      expr: COUNT(DISTINCT CASE WHEN breach_flag = TRUE THEN port_community_participant_id END)
      comment: "Number of distinct customers experiencing SLA breaches. Measures breadth of service quality issues across the customer portfolio."
    - name: "avg_variance_value"
      expr: AVG(CAST(variance_value AS DOUBLE))
      comment: "Average absolute variance from SLA target. Quantifies the typical magnitude of performance deviation."
    - name: "waived_breaches"
      expr: COUNT(CASE WHEN waiver_flag = TRUE THEN 1 END)
      comment: "Number of SLA breaches where penalties were waived. Tracks commercial concessions and their frequency."
$$;

CREATE OR REPLACE VIEW `vibe_shipping_ports_v1`.`_metrics`.`customer_onboarding_application`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Customer onboarding pipeline KPIs — application volumes, approval rates, ISPS screening outcomes, sanctions screening results, and SLA compliance. Used by commercial onboarding teams and compliance officers to manage new customer acquisition and regulatory gate-keeping."
  source: "`vibe_shipping_ports_v1`.`customer`.`onboarding_application`"
  dimensions:
    - name: "application_status"
      expr: application_status
      comment: "Current status of the onboarding application (submitted, under review, approved, rejected, activated)."
    - name: "participant_type"
      expr: participant_type
      comment: "Type of participant being onboarded (shipping line, freight forwarder, customs broker, trucker, etc.)."
    - name: "application_channel"
      expr: application_channel
      comment: "Channel through which the application was submitted (online portal, agent, direct) for channel effectiveness analysis."
    - name: "workflow_stage"
      expr: workflow_stage
      comment: "Current workflow stage of the application for pipeline funnel analysis."
    - name: "isps_screening_status"
      expr: isps_screening_status
      comment: "ISPS security screening outcome for the applicant. Critical compliance gate for port access."
    - name: "sanctions_screening_outcome"
      expr: sanctions_screening_outcome
      comment: "Sanctions screening result (clear, flagged, blocked) for compliance and risk management."
    - name: "background_check_status"
      expr: background_check_status
      comment: "Background check status for the applicant for due diligence tracking."
    - name: "is_resubmission"
      expr: is_resubmission
      comment: "Whether this is a resubmission of a previously rejected application."
    - name: "rejection_category"
      expr: rejection_category
      comment: "Category of rejection reason for root-cause analysis of onboarding failures."
    - name: "submission_month"
      expr: DATE_TRUNC('MONTH', submission_timestamp)
      comment: "Month of application submission for pipeline trend analysis."
  measures:
    - name: "total_applications"
      expr: COUNT(1)
      comment: "Total number of onboarding applications received. Measures new customer acquisition pipeline volume."
    - name: "approved_applications"
      expr: COUNT(CASE WHEN application_status = 'APPROVED' THEN 1 END)
      comment: "Number of applications approved. Used to compute approval rate and track commercial onboarding success."
    - name: "rejected_applications"
      expr: COUNT(CASE WHEN application_status = 'REJECTED' THEN 1 END)
      comment: "Number of applications rejected. Tracks rejection rate and informs process quality and compliance gate effectiveness."
    - name: "sanctions_flagged_applications"
      expr: COUNT(CASE WHEN sanctions_screening_outcome IN ('FLAGGED', 'BLOCKED') THEN 1 END)
      comment: "Number of applications flagged or blocked by sanctions screening. Critical compliance KPI for regulatory risk management."
    - name: "isps_screening_failed_applications"
      expr: COUNT(CASE WHEN isps_screening_status = 'FAILED' THEN 1 END)
      comment: "Number of applications that failed ISPS security screening. Measures security gate effectiveness at port access control."
    - name: "resubmission_applications"
      expr: COUNT(CASE WHEN is_resubmission = TRUE THEN 1 END)
      comment: "Number of resubmitted applications. High resubmission rates indicate process friction or documentation quality issues."
    - name: "total_proposed_credit_limit"
      expr: SUM(CAST(proposed_credit_limit AS DOUBLE))
      comment: "Total proposed credit limit across all applications. Measures the credit pipeline value being evaluated."
    - name: "avg_proposed_credit_limit"
      expr: AVG(CAST(proposed_credit_limit AS DOUBLE))
      comment: "Average proposed credit limit per application. Benchmarks the typical credit ask from new customers."
    - name: "activated_participants"
      expr: COUNT(CASE WHEN application_status = 'ACTIVATED' THEN 1 END)
      comment: "Number of applications that reached full activation. Measures successful end-to-end onboarding completions."
$$;

CREATE OR REPLACE VIEW `vibe_shipping_ports_v1`.`_metrics`.`customer_port_community_participant`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Port community participant master KPIs — active participant counts, credit exposure, ISPS accreditation status, sanctions screening currency, and dangerous goods approvals. Used by commercial, compliance, and port authority teams to manage the port community ecosystem."
  source: "`vibe_shipping_ports_v1`.`customer`.`port_community_participant`"
  dimensions:
    - name: "participant_type"
      expr: participant_type
      comment: "Type of port community participant (shipping line, freight forwarder, customs broker, trucker, terminal operator, etc.)."
    - name: "operational_status"
      expr: operational_status
      comment: "Operational status of the participant (active, suspended, deactivated) for portfolio health monitoring."
    - name: "customer_tier"
      expr: customer_tier
      comment: "Commercial tier of the participant for tiered service and pricing analysis."
    - name: "isps_accreditation_status"
      expr: isps_accreditation_status
      comment: "ISPS accreditation status of the participant. Critical for port security compliance under ISPS Code."
    - name: "sanctions_screening_status"
      expr: sanctions_screening_status
      comment: "Current sanctions screening status (clear, flagged, pending) for compliance monitoring."
    - name: "dangerous_goods_approved"
      expr: dangerous_goods_approved
      comment: "Whether the participant is approved to handle dangerous goods (IMDG). Safety and compliance segmentation."
    - name: "vessel_operator_flag"
      expr: vessel_operator_flag
      comment: "Whether the participant is a vessel operator, for shipping line vs. non-vessel operator analysis."
    - name: "payment_terms_code"
      expr: payment_terms_code
      comment: "Payment terms assigned to the participant for cash-flow and credit management."
    - name: "sla_tier_code"
      expr: sla_tier_code
      comment: "SLA tier assigned to the participant for service-level segmentation."
    - name: "onboarding_date_month"
      expr: DATE_TRUNC('MONTH', onboarding_date)
      comment: "Month of participant onboarding for cohort and acquisition trend analysis."
  measures:
    - name: "total_participants"
      expr: COUNT(1)
      comment: "Total number of port community participants. Measures the size of the port's commercial ecosystem."
    - name: "active_participants"
      expr: COUNT(CASE WHEN operational_status = 'ACTIVE' THEN 1 END)
      comment: "Number of currently active participants. Tracks the live port community size for capacity and revenue planning."
    - name: "isps_accredited_participants"
      expr: COUNT(CASE WHEN isps_accreditation_status = 'ACCREDITED' THEN 1 END)
      comment: "Number of participants with valid ISPS accreditation. Measures port security compliance coverage across the community."
    - name: "sanctions_flagged_participants"
      expr: COUNT(CASE WHEN sanctions_screening_status = 'FLAGGED' THEN 1 END)
      comment: "Number of participants currently flagged by sanctions screening. Critical compliance risk indicator requiring immediate action."
    - name: "dangerous_goods_approved_participants"
      expr: COUNT(CASE WHEN dangerous_goods_approved = TRUE THEN 1 END)
      comment: "Number of participants approved for dangerous goods handling. Measures DG-capable community capacity under IMDG requirements."
    - name: "total_credit_limit_portfolio"
      expr: SUM(CAST(credit_limit AS DOUBLE))
      comment: "Total credit limit extended across all port community participants. Measures aggregate credit exposure at the port level."
    - name: "avg_credit_limit"
      expr: AVG(CAST(credit_limit AS DOUBLE))
      comment: "Average credit limit per participant. Benchmarks typical credit exposure per customer for policy calibration."
    - name: "vessel_operator_participants"
      expr: COUNT(CASE WHEN vessel_operator_flag = TRUE THEN 1 END)
      comment: "Number of participants who are vessel operators (shipping lines). Measures the shipping line community size at the port."
    - name: "participants_with_overdue_isps"
      expr: COUNT(CASE WHEN isps_accreditation_expiry_date < CURRENT_DATE() THEN 1 END)
      comment: "Number of participants with expired ISPS accreditation. Identifies compliance gaps requiring urgent renewal action."
$$;

CREATE OR REPLACE VIEW `vibe_shipping_ports_v1`.`_metrics`.`customer_sla_profile`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "SLA profile configuration and performance KPIs — penalty exposure, breach counts, target vs actual performance, and remediation status by SLA tier and metric type. Used by commercial and operations teams to design and review SLA frameworks."
  source: "`vibe_shipping_ports_v1`.`customer`.`sla_profile`"
  dimensions:
    - name: "profile_status"
      expr: profile_status
      comment: "Status of the SLA profile (active, expired, draft) for lifecycle management."
    - name: "profile_type"
      expr: profile_type
      comment: "Type of SLA profile (standard, premium, custom) for tier-based analysis."
    - name: "sla_tier"
      expr: sla_tier
      comment: "SLA tier level for service-level segmentation and comparison."
    - name: "metric_type"
      expr: metric_type
      comment: "Type of metric the SLA profile governs (turnaround time, gate processing, vessel waiting, etc.)."
    - name: "breach_flag"
      expr: breach_flag
      comment: "Whether the SLA profile has recorded a breach in the current measurement period."
    - name: "breach_severity"
      expr: breach_severity
      comment: "Severity of the breach for prioritised remediation and escalation."
    - name: "penalty_type"
      expr: penalty_type
      comment: "Type of penalty applicable (credit note, cash rebate, service credit) for financial impact analysis."
    - name: "remediation_status"
      expr: remediation_status
      comment: "Status of remediation actions for breach resolution tracking."
    - name: "force_majeure_applicable"
      expr: force_majeure_applicable
      comment: "Whether force majeure applies to the SLA profile, for excused breach analysis."
    - name: "effective_start_month"
      expr: DATE_TRUNC('MONTH', effective_start_date)
      comment: "Month the SLA profile became effective for cohort and vintage analysis."
  measures:
    - name: "total_sla_profiles"
      expr: COUNT(1)
      comment: "Total number of SLA profiles configured. Measures the breadth of SLA framework coverage across the customer base."
    - name: "active_sla_profiles"
      expr: COUNT(CASE WHEN profile_status = 'ACTIVE' THEN 1 END)
      comment: "Number of currently active SLA profiles. Tracks live contractual SLA commitments in force."
    - name: "total_penalty_amount_applied"
      expr: SUM(CAST(penalty_amount_applied AS DOUBLE))
      comment: "Total penalty amounts applied across all SLA profiles. Measures actual financial liability realised from SLA breaches."
    - name: "avg_penalty_value"
      expr: AVG(CAST(penalty_value AS DOUBLE))
      comment: "Average penalty value per SLA profile. Benchmarks typical penalty exposure for commercial risk assessment."
    - name: "avg_variance_from_target"
      expr: AVG(CAST(variance_from_target AS DOUBLE))
      comment: "Average variance from SLA target across profiles. Measures typical performance gap against contractual commitments."
    - name: "total_teu_volume_under_sla"
      expr: SUM(CAST(teu_volume AS DOUBLE))
      comment: "Total TEU volume covered under SLA profiles. Measures the cargo volume subject to contractual service commitments."
    - name: "avg_actual_value"
      expr: AVG(CAST(actual_value AS DOUBLE))
      comment: "Average actual performance value across SLA profiles. Compared against target to assess overall SLA delivery."
    - name: "avg_target_value"
      expr: AVG(CAST(target_value AS DOUBLE))
      comment: "Average SLA target value across profiles. Provides the contractual benchmark baseline for performance comparison."
    - name: "profiles_with_breach"
      expr: COUNT(CASE WHEN breach_flag = TRUE THEN 1 END)
      comment: "Number of SLA profiles currently recording a breach. Measures the scale of active SLA non-compliance."
    - name: "avg_credit_cap_value"
      expr: AVG(CAST(credit_cap_value AS DOUBLE))
      comment: "Average credit cap value per SLA profile. Measures the maximum financial liability cap per profile for risk budgeting."
$$;

CREATE OR REPLACE VIEW `vibe_shipping_ports_v1`.`_metrics`.`customer_accreditation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Customer accreditation compliance KPIs — accreditation coverage, expiry pipeline, revocation rates, and insurance coverage. Used by compliance officers and port security teams to maintain regulatory and ISPS accreditation standards across the port community."
  source: "`vibe_shipping_ports_v1`.`customer`.`accreditation`"
  dimensions:
    - name: "accreditation_type"
      expr: accreditation_type
      comment: "Type of accreditation (ISPS, dangerous goods, vehicle operator, customs broker, etc.) for category analysis."
    - name: "accreditation_status"
      expr: accreditation_status
      comment: "Current status of the accreditation (active, expired, suspended, revoked) for compliance monitoring."
    - name: "accreditation_category"
      expr: accreditation_category
      comment: "Category of accreditation for grouping and reporting."
    - name: "is_mandatory"
      expr: is_mandatory
      comment: "Whether the accreditation is mandatory for port access or operations."
    - name: "is_revoked"
      expr: is_revoked
      comment: "Whether the accreditation has been revoked, for compliance breach tracking."
    - name: "verification_status"
      expr: verification_status
      comment: "Verification status of the accreditation documents for document compliance tracking."
    - name: "renewal_status"
      expr: renewal_status
      comment: "Renewal status of the accreditation for expiry pipeline management."
    - name: "issuing_authority_country"
      expr: issuing_authority_country
      comment: "Country of the issuing authority for jurisdictional analysis."
    - name: "expiry_date_month"
      expr: DATE_TRUNC('MONTH', expiry_date)
      comment: "Month of accreditation expiry for renewal pipeline planning."
  measures:
    - name: "total_accreditations"
      expr: COUNT(1)
      comment: "Total number of accreditations on record. Baseline compliance coverage metric."
    - name: "active_accreditations"
      expr: COUNT(CASE WHEN accreditation_status = 'ACTIVE' THEN 1 END)
      comment: "Number of currently active accreditations. Measures live compliance coverage across the port community."
    - name: "revoked_accreditations"
      expr: COUNT(CASE WHEN is_revoked = TRUE THEN 1 END)
      comment: "Number of revoked accreditations. Tracks compliance failures and security incidents requiring access removal."
    - name: "expiring_within_30_days"
      expr: COUNT(CASE WHEN expiry_date BETWEEN CURRENT_DATE() AND DATE_ADD(CURRENT_DATE(), 30) THEN 1 END)
      comment: "Number of accreditations expiring within 30 days. Drives proactive renewal management to avoid compliance gaps."
    - name: "mandatory_accreditations_expired"
      expr: COUNT(CASE WHEN is_mandatory = TRUE AND accreditation_status = 'EXPIRED' THEN 1 END)
      comment: "Number of mandatory accreditations that have expired. Critical compliance risk — expired mandatory accreditations block port access."
    - name: "total_insurance_coverage_amount"
      expr: SUM(CAST(insurance_coverage_amount AS DOUBLE))
      comment: "Total insurance coverage amount across all accreditations. Measures aggregate insurance protection held by port community participants."
    - name: "avg_insurance_coverage_amount"
      expr: AVG(CAST(insurance_coverage_amount AS DOUBLE))
      comment: "Average insurance coverage amount per accreditation. Benchmarks typical insurance protection level for risk adequacy assessment."
    - name: "unique_accredited_participants"
      expr: COUNT(DISTINCT port_community_participant_id)
      comment: "Number of distinct participants holding at least one accreditation. Measures accreditation coverage breadth across the port community."
$$;

CREATE OR REPLACE VIEW `vibe_shipping_ports_v1`.`_metrics`.`customer_relationship_manager`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Relationship management performance KPIs — revenue targets, TEU volume targets, churn risk, and strategic account coverage. Used by commercial leadership to manage key account performance and relationship manager effectiveness."
  source: "`vibe_shipping_ports_v1`.`customer`.`relationship_manager`"
  dimensions:
    - name: "assignment_status"
      expr: assignment_status
      comment: "Current status of the relationship manager assignment (active, ended, on hold)."
    - name: "assignment_type"
      expr: assignment_type
      comment: "Type of assignment (primary, secondary, interim) for coverage analysis."
    - name: "customer_segment"
      expr: customer_segment
      comment: "Customer segment managed (strategic, key account, standard) for portfolio segmentation."
    - name: "role_type"
      expr: role_type
      comment: "Role type of the relationship manager (account manager, commercial director, etc.)."
    - name: "sla_tier"
      expr: sla_tier
      comment: "SLA tier of the managed customer for service-level context."
    - name: "churn_risk_flag"
      expr: churn_risk_flag
      comment: "Whether the managed customer is flagged as a churn risk. Critical for retention intervention."
    - name: "strategic_account_flag"
      expr: strategic_account_flag
      comment: "Whether the account is classified as strategic. Drives executive attention and resource allocation."
    - name: "is_primary"
      expr: is_primary
      comment: "Whether this is the primary relationship manager assignment for the customer."
    - name: "assignment_start_month"
      expr: DATE_TRUNC('MONTH', assignment_start_date)
      comment: "Month the assignment started for tenure and coverage trend analysis."
  measures:
    - name: "total_assignments"
      expr: COUNT(1)
      comment: "Total number of relationship manager assignments. Measures RM coverage across the customer portfolio."
    - name: "active_assignments"
      expr: COUNT(CASE WHEN assignment_status = 'ACTIVE' THEN 1 END)
      comment: "Number of currently active RM assignments. Tracks live customer coverage."
    - name: "churn_risk_accounts"
      expr: COUNT(CASE WHEN churn_risk_flag = TRUE THEN 1 END)
      comment: "Number of accounts flagged as churn risk. Drives retention prioritisation and intervention planning."
    - name: "strategic_accounts_managed"
      expr: COUNT(CASE WHEN strategic_account_flag = TRUE THEN 1 END)
      comment: "Number of strategic accounts under active RM management. Measures coverage of the highest-value customer segment."
    - name: "total_annual_revenue_target"
      expr: SUM(CAST(annual_revenue_target AS DOUBLE))
      comment: "Total annual revenue target across all RM assignments. Measures the aggregate commercial target the RM team is accountable for."
    - name: "total_annual_teu_volume_target"
      expr: SUM(CAST(annual_teu_volume_target AS DOUBLE))
      comment: "Total annual TEU volume target across all RM assignments. Measures the aggregate throughput target managed by the RM team."
    - name: "avg_response_time_target_hours"
      expr: AVG(CAST(response_time_target_hours AS DOUBLE))
      comment: "Average response time target (hours) across RM assignments. Benchmarks the service responsiveness commitment to customers."
    - name: "unique_customers_managed"
      expr: COUNT(DISTINCT port_community_participant_id)
      comment: "Number of distinct customers under RM management. Measures the breadth of the managed customer portfolio."
$$;