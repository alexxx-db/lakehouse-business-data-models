-- Metric views for domain: rights | Business: Media_Broadcasting | Version: 3 | Generated on: 2026-07-10 19:06:42

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`rights_royalty_statement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Financial performance metrics for royalty statements — tracks gross and net royalty obligations, advance recoupment progress, and dispute exposure across rights holders and license agreements. Core KPI layer for rights finance and royalty operations teams."
  source: "`vibe_media_broadcasting_v1`.`rights`.`royalty_statement`"
  dimensions:
    - name: "statement_status"
      expr: statement_status
      comment: "Current lifecycle status of the royalty statement (e.g., Draft, Issued, Paid, Disputed) — primary filter for operational dashboards."
    - name: "statement_frequency"
      expr: statement_frequency
      comment: "Cadence at which statements are issued (Monthly, Quarterly, Annual) — used to segment royalty obligation timelines."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which the royalty statement is denominated — essential for multi-currency financial reporting."
    - name: "payment_method"
      expr: payment_method
      comment: "Method of royalty payment (Wire, ACH, Check) — used for treasury and cash-flow analysis."
    - name: "statement_period_start_date"
      expr: DATE_TRUNC('month', statement_period_start_date)
      comment: "Month bucket of the statement period start — enables trending of royalty obligations over time."
    - name: "statement_period_end_date"
      expr: DATE_TRUNC('month', statement_period_end_date)
      comment: "Month bucket of the statement period end — used alongside start date for period-over-period comparisons."
    - name: "statement_issue_date_month"
      expr: DATE_TRUNC('month', statement_issue_date)
      comment: "Month the statement was issued — used to track issuance timeliness and aging."
  measures:
    - name: "total_gross_royalty_amount"
      expr: SUM(CAST(gross_royalty_amount AS DOUBLE))
      comment: "Total gross royalty obligations across all statements in scope. Drives rights holder payment forecasting and budget planning."
    - name: "total_net_royalty_amount"
      expr: SUM(CAST(net_royalty_amount AS DOUBLE))
      comment: "Total net royalty payable after adjustments and advance recoupment. The primary cash-out metric for rights finance."
    - name: "total_advance_recoupment_amount"
      expr: SUM(CAST(advance_recoupment_amount AS DOUBLE))
      comment: "Total advance amounts recouped across statements. Tracks recovery of minimum guarantee advances against earned royalties."
    - name: "total_adjustment_amount"
      expr: SUM(CAST(adjustment_amount AS DOUBLE))
      comment: "Total adjustments applied to royalty statements. Large adjustment totals signal data quality or contract interpretation issues."
    - name: "total_withholding_tax_amount"
      expr: SUM(CAST(withholding_tax_amount AS DOUBLE))
      comment: "Total withholding tax deducted across royalty statements. Critical for cross-border tax compliance and treaty reporting."
    - name: "total_minimum_guarantee_shortfall"
      expr: SUM(CAST(minimum_guarantee_shortfall AS DOUBLE))
      comment: "Total shortfall between minimum guarantee commitments and earned royalties. Signals under-exploitation of licensed content."
    - name: "avg_net_royalty_per_statement"
      expr: AVG(CAST(net_royalty_amount AS DOUBLE))
      comment: "Average net royalty per statement. Benchmarks typical royalty obligation size and flags outlier statements."
    - name: "disputed_statement_count"
      expr: COUNT(CASE WHEN dispute_reason IS NOT NULL AND dispute_reason <> '' THEN royalty_statement_id END)
      comment: "Number of royalty statements currently under dispute. High dispute counts indicate contract ambiguity or data reconciliation failures."
    - name: "total_statements"
      expr: COUNT(1)
      comment: "Total number of royalty statements in scope. Baseline volume metric for operational throughput tracking."
    - name: "dispute_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN dispute_reason IS NOT NULL AND dispute_reason <> '' THEN royalty_statement_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of royalty statements under dispute. A rising dispute rate signals systemic issues in royalty calculation or rights data quality."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`rights_royalty_statement_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Line-level royalty economics — provides granular visibility into exploitation type, platform, territory, and content-level royalty performance. Enables rights holders and finance teams to audit royalty calculations at the most detailed level."
  source: "`vibe_media_broadcasting_v1`.`rights`.`royalty_statement_line`"
  dimensions:
    - name: "exploitation_type"
      expr: exploitation_type
      comment: "Type of content exploitation generating the royalty (Broadcast, Streaming, VOD, Syndication) — primary segmentation for royalty analysis."
    - name: "platform_name"
      expr: platform_name
      comment: "Distribution platform generating the royalty line — used to compare royalty yield across streaming, broadcast, and OTT platforms."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the royalty line — required for multi-currency consolidation."
    - name: "payment_status"
      expr: payment_status
      comment: "Payment status of the royalty line (Pending, Paid, Overdue) — used for cash-flow and aging analysis."
    - name: "dispute_status"
      expr: dispute_status
      comment: "Dispute status of the royalty line — identifies lines under challenge for resolution prioritization."
    - name: "window_type"
      expr: window_type
      comment: "Rights window type (Theatrical, Home Video, SVOD, AVOD) — segments royalty economics by distribution window."
    - name: "exploitation_period_start_month"
      expr: DATE_TRUNC('month', exploitation_period_start_date)
      comment: "Month bucket of exploitation period start — enables trending of royalty-generating activity over time."
    - name: "residual_type"
      expr: residual_type
      comment: "Type of residual obligation (SAG, WGA, DGA) — used for guild reporting and compliance tracking."
  measures:
    - name: "total_gross_revenue"
      expr: SUM(CAST(gross_revenue_amount AS DOUBLE))
      comment: "Total gross revenue base across royalty statement lines. The top-line input to royalty calculations."
    - name: "total_net_revenue"
      expr: SUM(CAST(net_revenue_amount AS DOUBLE))
      comment: "Total net revenue after allowable deductions. The basis for royalty rate application."
    - name: "total_calculated_royalty"
      expr: SUM(CAST(calculated_royalty_amount AS DOUBLE))
      comment: "Total royalties calculated across all lines. Core financial obligation metric for rights holders."
    - name: "total_net_payable"
      expr: SUM(CAST(net_payable_amount AS DOUBLE))
      comment: "Total net payable amount after deductions and advance recoupment. The actual cash obligation to rights holders."
    - name: "total_deductions"
      expr: SUM(CAST(deductions_amount AS DOUBLE))
      comment: "Total deductions applied to royalty lines. Monitors contractual deduction usage and potential over-deduction risk."
    - name: "total_advance_recoupment"
      expr: SUM(CAST(advance_recoupment_amount AS DOUBLE))
      comment: "Total advance recoupment applied at line level. Tracks minimum guarantee recovery progress by exploitation type and platform."
    - name: "total_units_exploited"
      expr: SUM(CAST(units_exploited AS DOUBLE))
      comment: "Total units of content exploited (streams, broadcasts, downloads). Volume metric for exploitation intensity analysis."
    - name: "avg_royalty_rate_pct"
      expr: AVG(CAST(royalty_rate_percentage AS DOUBLE))
      comment: "Average effective royalty rate across statement lines. Benchmarks rate consistency and flags anomalous rates."
    - name: "effective_royalty_yield_pct"
      expr: ROUND(100.0 * SUM(CAST(calculated_royalty_amount AS DOUBLE)) / NULLIF(SUM(CAST(gross_revenue_amount AS DOUBLE)), 0), 2)
      comment: "Effective royalty yield as a percentage of gross revenue. Measures actual royalty burden relative to revenue generated — key for profitability analysis."
    - name: "disputed_line_count"
      expr: COUNT(CASE WHEN dispute_status IS NOT NULL AND dispute_status <> '' AND dispute_status <> 'Resolved' THEN royalty_statement_line_id END)
      comment: "Number of royalty lines currently under dispute. Operational metric for rights dispute resolution teams."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`rights_license_agreement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "License agreement portfolio metrics — tracks deal value, financial commitments, royalty economics, and agreement lifecycle across the rights licensing portfolio. Primary KPI layer for rights executives and deal management teams."
  source: "`vibe_media_broadcasting_v1`.`rights`.`license_agreement`"
  dimensions:
    - name: "agreement_status"
      expr: agreement_status
      comment: "Lifecycle status of the license agreement (Active, Expired, Terminated, Pending) — primary filter for portfolio health dashboards."
    - name: "agreement_type"
      expr: agreement_type
      comment: "Type of license agreement (Exclusive, Non-Exclusive, Syndication, Co-Production) — segments deal portfolio by structure."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the license agreement — required for multi-currency deal value consolidation."
    - name: "exclusivity_flag"
      expr: exclusivity_flag
      comment: "Whether the agreement grants exclusive rights — used to segment premium vs. non-exclusive deal economics."
    - name: "auto_renewal_flag"
      expr: auto_renewal_flag
      comment: "Whether the agreement auto-renews — used to forecast future committed deal value."
    - name: "payment_schedule_type"
      expr: payment_schedule_type
      comment: "Payment schedule structure (Upfront, Installment, Per-Episode) — used for cash-flow forecasting."
    - name: "effective_date_month"
      expr: DATE_TRUNC('month', effective_date)
      comment: "Month the agreement became effective — enables deal vintage analysis and cohort comparisons."
    - name: "expiry_date_month"
      expr: DATE_TRUNC('month', expiry_date)
      comment: "Month the agreement expires — critical for renewal pipeline and revenue cliff analysis."
    - name: "governing_law_jurisdiction"
      expr: governing_law_jurisdiction
      comment: "Legal jurisdiction governing the agreement — used for legal risk and compliance segmentation."
  measures:
    - name: "total_license_fee_value"
      expr: SUM(CAST(total_license_fee AS DOUBLE))
      comment: "Total contracted license fee value across agreements. Top-line deal value metric for rights portfolio valuation."
    - name: "total_minimum_guarantee_committed"
      expr: SUM(CAST(minimum_guarantee_amount AS DOUBLE))
      comment: "Total minimum guarantee commitments across active agreements. Measures floor-level financial exposure to rights holders."
    - name: "total_advance_payment_committed"
      expr: SUM(CAST(advance_payment_amount AS DOUBLE))
      comment: "Total advance payments committed across agreements. Tracks upfront cash outflow obligations for rights acquisition."
    - name: "total_per_episode_fee_committed"
      expr: SUM(CAST(per_episode_fee AS DOUBLE))
      comment: "Total per-episode fee commitments. Used to project content cost as episode counts are confirmed."
    - name: "avg_royalty_percentage"
      expr: AVG(CAST(royalty_percentage AS DOUBLE))
      comment: "Average royalty rate across license agreements. Benchmarks deal terms and identifies outlier agreements."
    - name: "active_agreement_count"
      expr: COUNT(CASE WHEN agreement_status = 'Active' THEN license_agreement_id END)
      comment: "Number of currently active license agreements. Core portfolio size metric for rights management."
    - name: "expiring_within_90_days_count"
      expr: COUNT(CASE WHEN expiry_date BETWEEN CURRENT_DATE AND DATE_ADD(CURRENT_DATE, 90) THEN license_agreement_id END)
      comment: "Number of agreements expiring within 90 days. Renewal pipeline urgency metric for rights executives."
    - name: "exclusive_deal_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN exclusivity_flag = TRUE THEN license_agreement_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of agreements that are exclusive. Measures premium content lock-up rate in the rights portfolio."
    - name: "avg_license_fee_per_agreement"
      expr: AVG(CAST(total_license_fee AS DOUBLE))
      comment: "Average license fee per agreement. Benchmarks deal size and tracks changes in deal economics over time."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`rights_clearance_request`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Rights clearance operational metrics — tracks clearance request volume, SLA compliance, escalation rates, and financial exposure. Enables clearance operations teams and rights executives to manage throughput and risk."
  source: "`vibe_media_broadcasting_v1`.`rights`.`clearance_request`"
  dimensions:
    - name: "clearance_status"
      expr: clearance_status
      comment: "Current status of the clearance request (Pending, Approved, Rejected, Escalated) — primary operational filter."
    - name: "clearance_decision"
      expr: clearance_decision
      comment: "Final clearance decision outcome — used to analyze approval rates and rejection patterns."
    - name: "exploitation_type"
      expr: exploitation_type
      comment: "Type of exploitation being cleared (Broadcast, Streaming, Theatrical) — segments clearance workload by use case."
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level of the clearance request — used to ensure high-priority requests meet SLA targets."
    - name: "requesting_department"
      expr: requesting_department
      comment: "Department submitting the clearance request — identifies demand sources and workload distribution."
    - name: "platform_channel"
      expr: platform_channel
      comment: "Platform or channel for which clearance is requested — segments clearance activity by distribution channel."
    - name: "sla_met"
      expr: sla_met
      comment: "Whether the clearance request met its SLA target — primary SLA compliance dimension."
    - name: "requested_air_date_month"
      expr: DATE_TRUNC('month', requested_air_date)
      comment: "Month of the requested air date — used to forecast clearance demand and plan staffing."
    - name: "music_clearance_required"
      expr: music_clearance_required
      comment: "Whether music sync clearance is required — segments requests with additional complexity."
    - name: "talent_approval_required"
      expr: talent_approval_required
      comment: "Whether talent approval is required — identifies requests with additional stakeholder dependencies."
  measures:
    - name: "total_clearance_requests"
      expr: COUNT(1)
      comment: "Total number of clearance requests. Baseline throughput metric for clearance operations capacity planning."
    - name: "sla_compliance_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN sla_met = TRUE THEN clearance_request_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of clearance requests meeting SLA targets. Core operational KPI — declining SLA compliance signals staffing or process issues."
    - name: "escalation_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN escalation_reason IS NOT NULL AND escalation_reason <> '' THEN clearance_request_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of clearance requests that required escalation. High escalation rates indicate complex rights situations or process bottlenecks."
    - name: "total_estimated_residuals_exposure"
      expr: SUM(CAST(estimated_residuals_amount AS DOUBLE))
      comment: "Total estimated residuals financial exposure across clearance requests. Informs talent cost forecasting and budget reserves."
    - name: "avg_estimated_grp"
      expr: AVG(CAST(estimated_grp AS DOUBLE))
      comment: "Average estimated GRP (Gross Rating Points) for clearance requests. Measures audience reach associated with content being cleared."
    - name: "total_estimated_audience_reach"
      expr: SUM(CAST(estimated_audience_reach AS BIGINT))
      comment: "Total estimated audience reach across clearance requests. Quantifies the audience exposure value of content in the clearance pipeline."
    - name: "residuals_triggered_count"
      expr: COUNT(CASE WHEN residuals_triggered = TRUE THEN clearance_request_id END)
      comment: "Number of clearance requests that triggered residual obligations. Drives talent payment forecasting and guild reporting."
    - name: "music_clearance_required_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN music_clearance_required = TRUE THEN clearance_request_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of clearance requests requiring music sync clearance. Measures music licensing complexity in the content pipeline."
    - name: "approval_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN clearance_decision = 'Approved' THEN clearance_request_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of clearance requests approved. A declining approval rate signals increasing rights complexity or stricter holder requirements."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`rights_conflict`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Rights conflict detection and resolution metrics — tracks conflict volume, financial impact, resolution velocity, and severity distribution. Enables rights operations and legal teams to manage conflict exposure and resolution SLAs."
  source: "`vibe_media_broadcasting_v1`.`rights`.`conflict`"
  dimensions:
    - name: "conflict_type"
      expr: conflict_type
      comment: "Type of rights conflict (Territorial Overlap, Platform Conflict, Exclusivity Breach) — primary segmentation for conflict analysis."
    - name: "resolution_status"
      expr: resolution_status
      comment: "Current resolution status of the conflict (Open, In Review, Resolved, Escalated) — operational filter for conflict management."
    - name: "severity"
      expr: severity
      comment: "Severity level of the conflict (Critical, High, Medium, Low) — used to prioritize resolution resources."
    - name: "platform_type"
      expr: platform_type
      comment: "Platform type where the conflict was detected — identifies which distribution channels generate the most conflicts."
    - name: "detection_method"
      expr: detection_method
      comment: "How the conflict was detected (Automated, Manual Review, Partner Report) — measures effectiveness of detection systems."
    - name: "legal_review_required_flag"
      expr: legal_review_required_flag
      comment: "Whether legal review is required — segments conflicts by legal complexity and resource demand."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the financial impact — required for multi-currency conflict exposure reporting."
    - name: "detected_month"
      expr: DATE_TRUNC('month', detected_timestamp)
      comment: "Month the conflict was detected — enables trending of conflict discovery rates over time."
    - name: "window_type"
      expr: window_type
      comment: "Rights window type associated with the conflict — identifies which window types generate the most conflicts."
  measures:
    - name: "total_conflicts"
      expr: COUNT(1)
      comment: "Total number of rights conflicts. Baseline volume metric for conflict management operations."
    - name: "total_financial_impact"
      expr: SUM(CAST(financial_impact_amount AS DOUBLE))
      comment: "Total financial impact of rights conflicts. Primary risk exposure metric — drives legal and rights management investment decisions."
    - name: "avg_financial_impact_per_conflict"
      expr: AVG(CAST(financial_impact_amount AS DOUBLE))
      comment: "Average financial impact per conflict. Benchmarks typical conflict cost and identifies high-impact outliers."
    - name: "open_conflict_count"
      expr: COUNT(CASE WHEN resolution_status <> 'Resolved' THEN conflict_id END)
      comment: "Number of currently unresolved conflicts. Operational backlog metric for rights conflict resolution teams."
    - name: "critical_conflict_count"
      expr: COUNT(CASE WHEN severity = 'Critical' THEN conflict_id END)
      comment: "Number of critical severity conflicts. Escalation trigger metric — high critical counts require immediate executive attention."
    - name: "legal_review_required_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN legal_review_required_flag = TRUE THEN conflict_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of conflicts requiring legal review. Measures legal resource demand from rights conflict activity."
    - name: "resolution_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN resolution_status = 'Resolved' THEN conflict_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of conflicts successfully resolved. Core operational efficiency metric for rights conflict management."
    - name: "notification_sent_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN notification_sent_flag = TRUE THEN conflict_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of conflicts where stakeholder notifications were sent. Measures communication compliance in conflict management workflows."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`rights_exploitation_report`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Content exploitation financial reporting metrics — tracks revenue generated from licensed content across exploitation types, platforms, and territories. Core KPI layer for rights revenue recognition, royalty obligation calculation, and exploitation compliance."
  source: "`vibe_media_broadcasting_v1`.`rights`.`exploitation_report`"
  dimensions:
    - name: "exploitation_type"
      expr: exploitation_type
      comment: "Type of content exploitation (Broadcast, Streaming, Theatrical, Home Video) — primary revenue segmentation dimension."
    - name: "report_status"
      expr: report_status
      comment: "Status of the exploitation report (Draft, Submitted, Accepted, Disputed) — used to filter confirmed vs. provisional revenue."
    - name: "report_type"
      expr: report_type
      comment: "Type of exploitation report (Monthly, Quarterly, Annual, Ad Hoc) — segments reporting cadence."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the exploitation report — required for multi-currency revenue consolidation."
    - name: "reporting_period_start_month"
      expr: DATE_TRUNC('month', reporting_period_start_date)
      comment: "Month bucket of the reporting period start — enables revenue trending over time."
    - name: "data_source_system"
      expr: data_source_system
      comment: "Source system providing exploitation data — used to assess data quality and completeness by system."
    - name: "report_format_version"
      expr: report_format_version
      comment: "Version of the report format — used to track format migration and compatibility."
  measures:
    - name: "total_gross_revenue"
      expr: SUM(CAST(gross_revenue_amount AS DOUBLE))
      comment: "Total gross revenue reported across exploitation reports. Top-line revenue metric for rights exploitation performance."
    - name: "total_net_revenue"
      expr: SUM(CAST(net_revenue_amount AS DOUBLE))
      comment: "Total net revenue after deductions. The basis for royalty obligation calculation and rights holder payments."
    - name: "total_viewing_hours"
      expr: SUM(CAST(total_viewing_hours AS DOUBLE))
      comment: "Total viewing hours reported across exploitation reports. Audience engagement volume metric for content performance."
    - name: "total_unique_viewers"
      expr: SUM(CAST(unique_viewers AS BIGINT))
      comment: "Total unique viewers across exploitation reports. Reach metric for licensed content performance."
    - name: "total_streams"
      expr: SUM(CAST(total_streams AS BIGINT))
      comment: "Total stream count across exploitation reports. Volume metric for digital exploitation intensity."
    - name: "net_revenue_margin_pct"
      expr: ROUND(100.0 * SUM(CAST(net_revenue_amount AS DOUBLE)) / NULLIF(SUM(CAST(gross_revenue_amount AS DOUBLE)), 0), 2)
      comment: "Net revenue as a percentage of gross revenue. Measures the effective deduction rate applied to exploitation revenue — declining margins signal increasing cost burdens."
    - name: "disputed_report_count"
      expr: COUNT(CASE WHEN dispute_reason IS NOT NULL AND dispute_reason <> '' THEN exploitation_report_id END)
      comment: "Number of exploitation reports under dispute. High dispute counts signal data quality or contractual interpretation issues."
    - name: "avg_revenue_per_viewing_hour"
      expr: ROUND(SUM(CAST(gross_revenue_amount AS DOUBLE)) / NULLIF(SUM(CAST(total_viewing_hours AS DOUBLE)), 0), 4)
      comment: "Average gross revenue generated per viewing hour. Yield efficiency metric for content monetization — higher values indicate more valuable content."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`rights_audit_session`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Rights audit session performance metrics — tracks audit coverage, compliance scores, financial discrepancy discovery, and remediation status. Enables rights compliance and governance teams to assess audit program effectiveness."
  source: "`vibe_media_broadcasting_v1`.`rights`.`rights_audit_session`"
  dimensions:
    - name: "rights_audit_session_status"
      expr: rights_audit_session_status
      comment: "Current status of the audit session (Planned, In Progress, Completed, Remediation) — primary operational filter."
    - name: "audit_type"
      expr: audit_type
      comment: "Type of rights audit (Royalty Compliance, License Verification, Exploitation Audit) — segments audit program by objective."
    - name: "audit_methodology"
      expr: audit_methodology
      comment: "Methodology used for the audit — used to compare effectiveness across audit approaches."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the audit session findings — tracks governance sign-off on audit results."
    - name: "remediation_required_flag"
      expr: remediation_required_flag
      comment: "Whether remediation is required based on audit findings — primary filter for remediation pipeline management."
    - name: "scheduled_start_month"
      expr: DATE_TRUNC('month', scheduled_start_date)
      comment: "Month the audit session was scheduled to start — enables audit program cadence analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of financial discrepancy amounts — required for multi-currency audit exposure reporting."
  measures:
    - name: "total_audit_sessions"
      expr: COUNT(1)
      comment: "Total number of rights audit sessions. Baseline metric for audit program coverage and activity."
    - name: "avg_compliance_score"
      expr: AVG(CAST(compliance_score AS DOUBLE))
      comment: "Average compliance score across audit sessions. Primary audit quality KPI — declining scores signal systemic rights management issues."
    - name: "total_financial_discrepancy"
      expr: SUM(CAST(financial_discrepancy_amount AS DOUBLE))
      comment: "Total financial discrepancies discovered across audit sessions. Measures the monetary value of rights management errors and under-reporting."
    - name: "avg_financial_discrepancy_per_session"
      expr: AVG(CAST(financial_discrepancy_amount AS DOUBLE))
      comment: "Average financial discrepancy per audit session. Benchmarks typical audit finding size and identifies high-risk audit areas."
    - name: "total_records_reviewed"
      expr: SUM(CAST(total_records_reviewed AS BIGINT))
      comment: "Total rights records reviewed across audit sessions. Measures audit program coverage and thoroughness."
    - name: "remediation_required_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN remediation_required_flag = TRUE THEN rights_audit_session_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of audit sessions requiring remediation. High rates indicate systemic compliance gaps in rights management."
    - name: "sessions_with_critical_findings"
      expr: COUNT(CASE WHEN critical_findings_count IS NOT NULL AND critical_findings_count <> '0' THEN rights_audit_session_id END)
      comment: "Number of audit sessions with critical findings. Escalation metric for rights compliance governance."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`rights_residual`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Talent residual obligation metrics — tracks residual payment amounts, payment status, guild reporting compliance, and exploitation-driven residual triggers. Core KPI layer for talent relations, legal, and finance teams managing guild obligations."
  source: "`vibe_media_broadcasting_v1`.`rights`.`residual`"
  dimensions:
    - name: "payment_status"
      expr: payment_status
      comment: "Payment status of the residual (Pending, Paid, Overdue, Disputed) — primary operational filter for residual management."
    - name: "exploitation_type"
      expr: exploitation_type
      comment: "Type of exploitation triggering the residual (Broadcast, Streaming, Home Video) — segments residual obligations by exploitation channel."
    - name: "guild_union_code"
      expr: guild_union_code
      comment: "Guild or union code (SAG-AFTRA, WGA, DGA) — segments residual obligations by talent guild for compliance reporting."
    - name: "formula_type"
      expr: formula_type
      comment: "Residual calculation formula type — used to audit calculation consistency and identify formula anomalies."
    - name: "currency"
      expr: currency
      comment: "Currency of the residual payment — required for multi-currency residual obligation reporting."
    - name: "guild_report_submitted_flag"
      expr: guild_report_submitted_flag
      comment: "Whether the guild report has been submitted — tracks compliance with guild reporting obligations."
    - name: "exploitation_start_month"
      expr: DATE_TRUNC('month', exploitation_start_date)
      comment: "Month exploitation began — enables trending of residual obligation accrual over time."
    - name: "payment_method"
      expr: payment_method
      comment: "Method of residual payment — used for treasury and disbursement analysis."
  measures:
    - name: "total_calculated_residual_amount"
      expr: SUM(CAST(calculated_residual_amount AS DOUBLE))
      comment: "Total calculated residual obligations. Primary financial liability metric for talent cost management."
    - name: "total_net_payment_amount"
      expr: SUM(CAST(net_payment_amount AS DOUBLE))
      comment: "Total net residual payments made or due. Actual cash outflow metric for talent residual obligations."
    - name: "total_withholding_tax"
      expr: SUM(CAST(withholding_tax_amount AS DOUBLE))
      comment: "Total withholding tax on residual payments. Tax compliance metric for cross-border talent payments."
    - name: "avg_residual_rate_pct"
      expr: AVG(CAST(percentage AS DOUBLE))
      comment: "Average residual rate percentage across obligations. Benchmarks effective residual burden and identifies rate anomalies."
    - name: "overdue_residual_count"
      expr: COUNT(CASE WHEN payment_status = 'Overdue' THEN residual_id END)
      comment: "Number of overdue residual payments. Compliance risk metric — overdue guild payments can trigger penalties and disputes."
    - name: "guild_report_submission_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN guild_report_submitted_flag = TRUE THEN residual_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of residuals with guild reports submitted. Guild compliance rate — below 100% indicates reporting obligation gaps."
    - name: "disputed_residual_count"
      expr: COUNT(CASE WHEN dispute_reason IS NOT NULL AND dispute_reason <> '' THEN residual_id END)
      comment: "Number of residuals under dispute. Talent relations risk metric — high dispute counts signal calculation or contract interpretation issues."
    - name: "avg_calculation_basis_amount"
      expr: AVG(CAST(calculation_basis_amount AS DOUBLE))
      comment: "Average calculation basis amount for residuals. Benchmarks the revenue base used for residual calculations across exploitation types."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`rights_availability_window`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Rights availability window portfolio metrics — tracks window status, platform coverage, exclusivity, and financial terms across the content availability schedule. Enables rights scheduling and distribution teams to optimize window strategy."
  source: "`vibe_media_broadcasting_v1`.`rights`.`rights_availability_window`"
  dimensions:
    - name: "window_status"
      expr: window_status
      comment: "Current status of the availability window (Open, Closed, Holdback, Expired) — primary filter for active window management."
    - name: "platform_type"
      expr: platform_type
      comment: "Platform type for the availability window (Linear, SVOD, AVOD, TVOD) — segments window portfolio by distribution model."
    - name: "exclusivity_flag"
      expr: exclusivity_flag
      comment: "Whether the window is exclusive — used to segment premium vs. non-exclusive availability."
    - name: "blackout_indicator"
      expr: blackout_indicator
      comment: "Whether the window has an active blackout — identifies restricted availability periods."
    - name: "dai_enabled"
      expr: dai_enabled
      comment: "Whether dynamic ad insertion is enabled for this window — segments ad-monetizable availability windows."
    - name: "advertising_allowed"
      expr: advertising_allowed
      comment: "Whether advertising is permitted in this window — used to assess ad revenue potential of the availability portfolio."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of window financial terms — required for multi-currency availability portfolio analysis."
    - name: "availability_start_month"
      expr: DATE_TRUNC('month', availability_start_date)
      comment: "Month the availability window opens — enables scheduling and content release calendar analysis."
  measures:
    - name: "total_availability_windows"
      expr: COUNT(1)
      comment: "Total number of rights availability windows. Portfolio size metric for content scheduling and rights management."
    - name: "active_window_count"
      expr: COUNT(CASE WHEN window_status = 'Open' THEN rights_availability_window_id END)
      comment: "Number of currently open availability windows. Measures active content availability across the distribution portfolio."
    - name: "blackout_window_count"
      expr: COUNT(CASE WHEN blackout_indicator = TRUE THEN rights_availability_window_id END)
      comment: "Number of windows with active blackouts. Measures content restriction exposure across the availability portfolio."
    - name: "exclusive_window_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN exclusivity_flag = TRUE THEN rights_availability_window_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of availability windows that are exclusive. Measures premium content lock-up rate in the distribution portfolio."
    - name: "dai_enabled_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN dai_enabled = TRUE THEN rights_availability_window_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of availability windows with DAI enabled. Measures ad monetization readiness of the content availability portfolio."
    - name: "total_minimum_guarantee_committed"
      expr: SUM(CAST(minimum_guarantee_amount AS DOUBLE))
      comment: "Total minimum guarantee commitments across availability windows. Financial floor exposure metric for rights scheduling decisions."
    - name: "avg_royalty_rate_pct"
      expr: AVG(CAST(royalty_rate_percent AS DOUBLE))
      comment: "Average royalty rate across availability windows. Benchmarks royalty economics by platform and window type."
    - name: "expiration_notification_pending_count"
      expr: COUNT(CASE WHEN expiration_notification_sent = FALSE THEN rights_availability_window_id END)
      comment: "Number of windows where expiration notification has not been sent. Operational compliance metric for rights expiry management."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`rights_license_fee_schedule`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "License fee payment schedule metrics — tracks payment amounts, status, late fee exposure, and withholding tax obligations across all license fee installments. Core KPI layer for rights finance and accounts payable teams."
  source: "`vibe_media_broadcasting_v1`.`rights`.`license_fee_schedule`"
  dimensions:
    - name: "payment_status"
      expr: payment_status
      comment: "Current payment status (Scheduled, Paid, Overdue, Waived) — primary filter for payment management dashboards."
    - name: "payment_type"
      expr: payment_type
      comment: "Type of license fee payment (Advance, Installment, Milestone, Final) — segments payment schedule by structure."
    - name: "payment_method"
      expr: payment_method
      comment: "Method of payment (Wire, ACH, Check) — used for treasury and cash management analysis."
    - name: "payment_approval_status"
      expr: payment_approval_status
      comment: "Approval status of the payment (Pending, Approved, Rejected) — tracks payment authorization workflow."
    - name: "late_fee_applicable"
      expr: late_fee_applicable
      comment: "Whether a late fee applies to this payment — identifies overdue payment exposure."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the payment — required for multi-currency payment obligation reporting."
    - name: "scheduled_payment_month"
      expr: DATE_TRUNC('month', scheduled_payment_date)
      comment: "Month the payment is scheduled — enables cash-flow forecasting for license fee obligations."
  measures:
    - name: "total_payment_amount_scheduled"
      expr: SUM(CAST(payment_amount AS DOUBLE))
      comment: "Total scheduled license fee payment amounts. Primary cash-flow planning metric for rights finance."
    - name: "total_net_payment_amount"
      expr: SUM(CAST(net_payment_amount AS DOUBLE))
      comment: "Total net payment amounts after withholding tax. Actual cash outflow metric for license fee obligations."
    - name: "total_withholding_tax"
      expr: SUM(CAST(withholding_tax_amount AS DOUBLE))
      comment: "Total withholding tax across license fee payments. Tax compliance and treaty reporting metric."
    - name: "overdue_payment_count"
      expr: COUNT(CASE WHEN payment_status = 'Overdue' THEN license_fee_schedule_id END)
      comment: "Number of overdue license fee payments. Compliance risk metric — overdue payments can trigger contract penalties."
    - name: "late_fee_exposure_count"
      expr: COUNT(CASE WHEN late_fee_applicable = TRUE THEN license_fee_schedule_id END)
      comment: "Number of payments with late fee exposure. Financial risk metric for rights payment management."
    - name: "avg_late_fee_percentage"
      expr: AVG(CASE WHEN late_fee_applicable = TRUE THEN CAST(late_fee_percentage AS DOUBLE) END)
      comment: "Average late fee percentage on applicable payments. Benchmarks penalty exposure for overdue license fee payments."
    - name: "payment_on_time_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN payment_status = 'Paid' AND late_fee_applicable = FALSE THEN license_fee_schedule_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of license fee payments made on time without late fees. Core payment compliance KPI for rights finance operations."
    - name: "avg_withholding_tax_rate"
      expr: AVG(CAST(withholding_tax_rate AS DOUBLE))
      comment: "Average withholding tax rate across license fee payments. Used to benchmark effective tax burden and validate treaty application."
$$;