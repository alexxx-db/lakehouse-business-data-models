-- Metric views for domain: rights | Business: Media_Broadcasting | Version: 2 | Generated on: 2026-06-30 04:55:25

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`rights_license_agreement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Licensing portfolio KPIs: total contracted license value, advances, guarantees, and active-agreement coverage for rights monetization steering."
  source: "`vibe_media_broadcasting_v1`.`rights`.`license_agreement`"
  dimensions:
    - name: "agreement_status"
      expr: agreement_status
      comment: "Lifecycle status of the license agreement (active, expired, terminated)."
    - name: "agreement_type"
      expr: agreement_type
      comment: "Type of licensing agreement for portfolio segmentation."
    - name: "territory_scope"
      expr: territory_scope
      comment: "Territorial scope of the rights granted."
    - name: "currency_code"
      expr: currency_code
      comment: "Settlement currency of the agreement."
    - name: "payment_schedule_type"
      expr: payment_schedule_type
      comment: "Payment cadence structure (flat, installment, per-episode)."
    - name: "effective_year"
      expr: YEAR(effective_date)
      comment: "Year the agreement became effective for cohort analysis."
    - name: "exclusivity_flag"
      expr: exclusivity_flag
      comment: "Whether the agreement grants exclusive rights."
    - name: "auto_renewal_flag"
      expr: auto_renewal_flag
      comment: "Whether the agreement auto-renews."
  measures:
    - name: "agreement_count"
      expr: COUNT(1)
      comment: "Number of license agreements — base counting measure for the rights portfolio."
    - name: "total_license_fee_value"
      expr: SUM(CAST(total_license_fee AS DOUBLE))
      comment: "Total contracted license fee value — headline rights monetization KPI."
    - name: "total_minimum_guarantee"
      expr: SUM(CAST(minimum_guarantee_amount AS DOUBLE))
      comment: "Total minimum guarantee exposure across agreements — financial commitment risk."
    - name: "total_advance_payments"
      expr: SUM(CAST(advance_payment_amount AS DOUBLE))
      comment: "Total advance payments — recoupment liability tracking."
    - name: "avg_royalty_percentage"
      expr: AVG(CAST(royalty_percentage AS DOUBLE))
      comment: "Average royalty rate across agreements — margin/cost lever."
    - name: "exclusive_agreement_count"
      expr: SUM(CASE WHEN exclusivity_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of exclusive agreements — premium-rights positioning."
    - name: "auto_renewal_count"
      expr: SUM(CASE WHEN auto_renewal_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of auto-renewing agreements — renewal pipeline exposure."
    - name: "avg_total_license_fee"
      expr: AVG(CAST(total_license_fee AS DOUBLE))
      comment: "Average deal size — used to evaluate deal quality trends."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`rights_clearance_request`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Rights clearance operations KPIs: SLA compliance, throughput, and residual/audience exposure for clearance workflow steering."
  source: "`vibe_media_broadcasting_v1`.`rights`.`clearance_request`"
  dimensions:
    - name: "clearance_status"
      expr: clearance_status
      comment: "Current status of the clearance request."
    - name: "clearance_decision"
      expr: clearance_decision
      comment: "Final decision outcome of the clearance request."
    - name: "priority_level"
      expr: priority_level
      comment: "Business priority of the clearance request."
    - name: "blocking_category"
      expr: blocking_category
      comment: "Category of blocking issue if clearance is held."
    - name: "exploitation_type"
      expr: exploitation_type
      comment: "Exploitation type the clearance covers."
    - name: "requesting_department"
      expr: requesting_department
      comment: "Originating department of the request."
    - name: "requested_air_month"
      expr: DATE_TRUNC('MONTH', requested_air_date)
      comment: "Month of requested air date for clearance demand trending."
  measures:
    - name: "clearance_request_count"
      expr: COUNT(1)
      comment: "Total clearance requests — clearance workload base measure."
    - name: "sla_met_count"
      expr: SUM(CASE WHEN sla_met = TRUE THEN 1 ELSE 0 END)
      comment: "Clearance requests that met SLA — operational quality KPI."
    - name: "sla_breached_count"
      expr: SUM(CASE WHEN sla_met = FALSE THEN 1 ELSE 0 END)
      comment: "Clearance requests that breached SLA — escalation/intervention trigger."
    - name: "music_clearance_required_count"
      expr: SUM(CASE WHEN music_clearance_required = TRUE THEN 1 ELSE 0 END)
      comment: "Requests needing music clearance — downstream sync-license workload driver."
    - name: "residuals_triggered_count"
      expr: SUM(CASE WHEN residuals_triggered = TRUE THEN 1 ELSE 0 END)
      comment: "Requests that triggered residuals — talent-cost exposure indicator."
    - name: "total_estimated_residuals"
      expr: SUM(CAST(estimated_residuals_amount AS DOUBLE))
      comment: "Total estimated residual cost in the clearance pipeline — financial planning KPI."
    - name: "total_estimated_audience_reach"
      expr: SUM(CAST(estimated_audience_reach AS DOUBLE))
      comment: "Total estimated audience reach across requests — exploitation value sizing."
    - name: "avg_estimated_grp"
      expr: AVG(CAST(estimated_grp AS DOUBLE))
      comment: "Average estimated gross rating points — campaign value indicator."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`rights_conflict`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Rights conflict management KPIs: conflict volume, financial impact, resolution status, and legal-review burden for risk steering."
  source: "`vibe_media_broadcasting_v1`.`rights`.`conflict`"
  dimensions:
    - name: "conflict_type"
      expr: conflict_type
      comment: "Type of rights conflict detected."
    - name: "severity"
      expr: severity
      comment: "Severity classification of the conflict."
    - name: "resolution_status"
      expr: resolution_status
      comment: "Resolution status of the conflict."
    - name: "business_priority"
      expr: business_priority
      comment: "Business priority assigned to the conflict."
    - name: "detection_method"
      expr: detection_method
      comment: "How the conflict was detected."
    - name: "detected_month"
      expr: DATE_TRUNC('MONTH', detected_timestamp)
      comment: "Month the conflict was detected for trend analysis."
  measures:
    - name: "conflict_count"
      expr: COUNT(1)
      comment: "Total rights conflicts — risk workload base measure."
    - name: "total_financial_impact"
      expr: SUM(CAST(financial_impact_amount AS DOUBLE))
      comment: "Total financial impact of conflicts — exposure quantification KPI."
    - name: "avg_financial_impact"
      expr: AVG(CAST(financial_impact_amount AS DOUBLE))
      comment: "Average financial impact per conflict — severity sizing."
    - name: "unresolved_conflict_count"
      expr: SUM(CASE WHEN resolution_status NOT IN ('resolved','closed') THEN 1 ELSE 0 END)
      comment: "Open/unresolved conflicts — active risk backlog requiring action."
    - name: "legal_review_required_count"
      expr: SUM(CASE WHEN legal_review_required_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Conflicts needing legal review — legal-resource demand driver."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`rights_royalty_statement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Royalty payout KPIs: gross/net royalties, guarantee shortfalls, advance recoupment, and dispute exposure for rights-holder settlement steering."
  source: "`vibe_media_broadcasting_v1`.`rights`.`royalty_statement`"
  dimensions:
    - name: "statement_status"
      expr: statement_status
      comment: "Status of the royalty statement."
    - name: "statement_frequency"
      expr: statement_frequency
      comment: "Reporting frequency of the statement."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the royalty statement."
    - name: "payment_method"
      expr: payment_method
      comment: "Method used to settle the royalty payment."
    - name: "period_end_month"
      expr: DATE_TRUNC('MONTH', statement_period_end_date)
      comment: "Statement period end month for payout trending."
  measures:
    - name: "statement_count"
      expr: COUNT(1)
      comment: "Number of royalty statements — settlement volume base measure."
    - name: "total_gross_royalty"
      expr: SUM(CAST(gross_royalty_amount AS DOUBLE))
      comment: "Total gross royalties — headline rights-holder payout obligation."
    - name: "total_net_royalty"
      expr: SUM(CAST(net_royalty_amount AS DOUBLE))
      comment: "Total net royalties payable after adjustments — cash-out KPI."
    - name: "total_guarantee_shortfall"
      expr: SUM(CAST(minimum_guarantee_shortfall AS DOUBLE))
      comment: "Total minimum-guarantee shortfall — under-recoupment risk."
    - name: "total_advance_recoupment"
      expr: SUM(CAST(advance_recoupment_amount AS DOUBLE))
      comment: "Total advances recouped against royalties — recoupment progress KPI."
    - name: "total_withholding_tax"
      expr: SUM(CAST(withholding_tax_amount AS DOUBLE))
      comment: "Total withholding tax on royalties — tax compliance tracking."
    - name: "disputed_statement_count"
      expr: SUM(CASE WHEN dispute_reason IS NOT NULL THEN 1 ELSE 0 END)
      comment: "Statements with disputes — settlement risk / intervention trigger."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`rights_royalty_statement_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Royalty line-level KPIs: revenue vs payable royalty, deductions, and exploitation-level breakdown for granular royalty performance."
  source: "`vibe_media_broadcasting_v1`.`rights`.`royalty_statement_line`"
  dimensions:
    - name: "exploitation_type"
      expr: exploitation_type
      comment: "Exploitation type generating the royalty line."
    - name: "platform_name"
      expr: platform_name
      comment: "Distribution platform of the exploitation."
    - name: "payment_status"
      expr: payment_status
      comment: "Payment status of the royalty line."
    - name: "residual_type"
      expr: residual_type
      comment: "Residual type associated with the line."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the royalty line."
    - name: "exploitation_period_end_month"
      expr: DATE_TRUNC('MONTH', exploitation_period_end_date)
      comment: "Exploitation period end month for revenue trending."
  measures:
    - name: "line_count"
      expr: COUNT(1)
      comment: "Number of royalty statement lines — granular volume base measure."
    - name: "total_gross_revenue"
      expr: SUM(CAST(gross_revenue_amount AS DOUBLE))
      comment: "Total gross revenue underlying royalty lines — exploitation revenue KPI."
    - name: "total_net_revenue"
      expr: SUM(CAST(net_revenue_amount AS DOUBLE))
      comment: "Total net revenue after deductions — royalty calculation base."
    - name: "total_calculated_royalty"
      expr: SUM(CAST(calculated_royalty_amount AS DOUBLE))
      comment: "Total calculated royalty across lines — payout obligation KPI."
    - name: "total_net_payable"
      expr: SUM(CAST(net_payable_amount AS DOUBLE))
      comment: "Total net payable royalty — final cash obligation."
    - name: "total_deductions"
      expr: SUM(CAST(deductions_amount AS DOUBLE))
      comment: "Total deductions applied to royalty lines — margin/cost lever."
    - name: "avg_royalty_rate"
      expr: AVG(CAST(royalty_rate_percentage AS DOUBLE))
      comment: "Average effective royalty rate — pricing/cost benchmark."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`rights_residual`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Talent residual KPIs: calculated residual liability, net payments, guild-reporting compliance, and dispute exposure for talent-cost steering."
  source: "`vibe_media_broadcasting_v1`.`rights`.`residual`"
  dimensions:
    - name: "payment_status"
      expr: payment_status
      comment: "Payment status of the residual."
    - name: "exploitation_type"
      expr: exploitation_type
      comment: "Exploitation type triggering the residual."
    - name: "guild_union_code"
      expr: guild_union_code
      comment: "Guild/union governing the residual."
    - name: "formula_type"
      expr: formula_type
      comment: "Residual calculation formula type."
    - name: "currency"
      expr: currency
      comment: "Currency of the residual amount."
    - name: "calculation_month"
      expr: DATE_TRUNC('MONTH', calculation_date)
      comment: "Month the residual was calculated for trending."
  measures:
    - name: "residual_count"
      expr: COUNT(1)
      comment: "Number of residual records — talent obligation base measure."
    - name: "total_calculated_residual"
      expr: SUM(CAST(calculated_residual_amount AS DOUBLE))
      comment: "Total calculated residual liability — headline talent-cost KPI."
    - name: "total_net_payment"
      expr: SUM(CAST(net_payment_amount AS DOUBLE))
      comment: "Total net residual payments — cash-out KPI."
    - name: "total_withholding_tax"
      expr: SUM(CAST(withholding_tax_amount AS DOUBLE))
      comment: "Total withholding tax on residuals — tax compliance tracking."
    - name: "guild_reported_count"
      expr: SUM(CASE WHEN guild_report_submitted_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Residuals reported to guild — compliance KPI."
    - name: "disputed_residual_count"
      expr: SUM(CASE WHEN dispute_reason IS NOT NULL THEN 1 ELSE 0 END)
      comment: "Residuals in dispute — settlement risk / intervention trigger."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`rights_availability_window`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Rights availability KPIs: open vs blacked-out windows, exclusivity, and guarantee exposure for content-availability planning."
  source: "`vibe_media_broadcasting_v1`.`rights`.`rights_availability_window`"
  dimensions:
    - name: "window_status"
      expr: window_status
      comment: "Status of the availability window."
    - name: "clearance_status"
      expr: clearance_status
      comment: "Clearance status of the window."
    - name: "platform_type"
      expr: platform_type
      comment: "Platform type the window applies to."
    - name: "drm_requirement"
      expr: drm_requirement
      comment: "DRM requirement for the window."
    - name: "availability_start_month"
      expr: DATE_TRUNC('MONTH', availability_start_date)
      comment: "Availability start month for windowing trend analysis."
  measures:
    - name: "window_count"
      expr: COUNT(1)
      comment: "Number of availability windows — content availability base measure."
    - name: "blackout_window_count"
      expr: SUM(CASE WHEN blackout_indicator = TRUE THEN 1 ELSE 0 END)
      comment: "Windows under blackout — distribution restriction exposure."
    - name: "exclusive_window_count"
      expr: SUM(CASE WHEN exclusivity_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Exclusive windows — premium positioning indicator."
    - name: "dai_enabled_count"
      expr: SUM(CASE WHEN dai_enabled = TRUE THEN 1 ELSE 0 END)
      comment: "Windows with dynamic ad insertion enabled — monetization readiness."
    - name: "total_minimum_guarantee"
      expr: SUM(CAST(minimum_guarantee_amount AS DOUBLE))
      comment: "Total minimum-guarantee exposure across windows — financial commitment."
    - name: "avg_royalty_rate"
      expr: AVG(CAST(royalty_rate_percent AS DOUBLE))
      comment: "Average royalty rate across windows — cost benchmark."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`rights_syndication_deal`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Syndication deal KPIs: deal value, guarantees, run utilization, and revenue-share economics for syndication portfolio steering."
  source: "`vibe_media_broadcasting_v1`.`rights`.`rights_syndication_deal`"
  dimensions:
    - name: "deal_status"
      expr: deal_status
      comment: "Status of the syndication deal."
    - name: "syndication_type"
      expr: syndication_type
      comment: "Type of syndication arrangement."
    - name: "fee_structure_type"
      expr: fee_structure_type
      comment: "Fee structure of the deal."
    - name: "licensee_type"
      expr: licensee_type
      comment: "Type of licensee (broadcaster, OTT, etc.)."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the deal."
    - name: "deal_start_year"
      expr: YEAR(deal_start_date)
      comment: "Year the deal started for cohort analysis."
  measures:
    - name: "deal_count"
      expr: COUNT(1)
      comment: "Number of syndication deals — portfolio base measure."
    - name: "total_flat_fee"
      expr: SUM(CAST(flat_fee_amount AS DOUBLE))
      comment: "Total flat-fee value across syndication deals — revenue KPI."
    - name: "total_minimum_guarantee"
      expr: SUM(CAST(minimum_guarantee_amount AS DOUBLE))
      comment: "Total minimum guarantees in syndication deals — committed-revenue floor."
    - name: "avg_revenue_share_percent"
      expr: AVG(CAST(revenue_share_percent AS DOUBLE))
      comment: "Average revenue-share percentage — deal economics benchmark."
    - name: "exclusive_deal_count"
      expr: SUM(CASE WHEN exclusivity_indicator = TRUE THEN 1 ELSE 0 END)
      comment: "Exclusive syndication deals — premium positioning indicator."
    - name: "avg_per_episode_fee"
      expr: AVG(CAST(per_episode_fee_amount AS DOUBLE))
      comment: "Average per-episode fee — pricing benchmark."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`rights_exploitation_report`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Content exploitation KPIs: gross/net revenue, streaming volume, viewing hours, and unique reach for exploitation performance steering."
  source: "`vibe_media_broadcasting_v1`.`rights`.`exploitation_report`"
  dimensions:
    - name: "exploitation_type"
      expr: exploitation_type
      comment: "Type of exploitation reported."
    - name: "report_status"
      expr: report_status
      comment: "Status of the exploitation report."
    - name: "report_type"
      expr: report_type
      comment: "Type/category of report."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of reported revenue."
    - name: "reporting_period_end_month"
      expr: DATE_TRUNC('MONTH', reporting_period_end_date)
      comment: "Reporting period end month for exploitation trending."
  measures:
    - name: "report_count"
      expr: COUNT(1)
      comment: "Number of exploitation reports — reporting volume base measure."
    - name: "total_gross_revenue"
      expr: SUM(CAST(gross_revenue_amount AS DOUBLE))
      comment: "Total gross exploitation revenue — headline monetization KPI."
    - name: "total_net_revenue"
      expr: SUM(CAST(net_revenue_amount AS DOUBLE))
      comment: "Total net exploitation revenue — margin KPI."
    - name: "total_streams"
      expr: SUM(CAST(total_streams AS DOUBLE))
      comment: "Total streams across reports — consumption volume KPI."
    - name: "total_viewing_hours"
      expr: SUM(CAST(total_viewing_hours AS DOUBLE))
      comment: "Total viewing hours — engagement KPI tied to royalty bases."
    - name: "total_unique_viewers"
      expr: SUM(CAST(unique_viewers AS DOUBLE))
      comment: "Total unique viewers reached — exploitation reach KPI."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`rights_music_sync_license`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Music sync licensing KPIs: license fee spend, clearance status, exclusivity, and guarantee exposure for music-rights cost steering."
  source: "`vibe_media_broadcasting_v1`.`rights`.`music_sync_license`"
  dimensions:
    - name: "clearance_status"
      expr: clearance_status
      comment: "Clearance status of the sync license."
    - name: "license_type"
      expr: license_type
      comment: "Type of music sync license."
    - name: "usage_type"
      expr: usage_type
      comment: "Usage type for the music."
    - name: "license_fee_currency"
      expr: license_fee_currency
      comment: "Currency of the license fee."
    - name: "license_start_month"
      expr: DATE_TRUNC('MONTH', license_start_date)
      comment: "License start month for music-rights trending."
  measures:
    - name: "license_count"
      expr: COUNT(1)
      comment: "Number of music sync licenses — music-rights volume base measure."
    - name: "total_license_fee"
      expr: SUM(CAST(license_fee_amount AS DOUBLE))
      comment: "Total music sync license spend — cost KPI."
    - name: "total_minimum_guarantee"
      expr: SUM(CAST(minimum_guarantee_amount AS DOUBLE))
      comment: "Total minimum guarantees on music licenses — committed cost floor."
    - name: "avg_royalty_rate"
      expr: AVG(CAST(royalty_rate_percent AS DOUBLE))
      comment: "Average royalty rate on sync licenses — cost benchmark."
    - name: "exclusive_license_count"
      expr: SUM(CASE WHEN exclusivity_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Exclusive music licenses — premium-cost indicator."
    - name: "cue_sheet_required_count"
      expr: SUM(CASE WHEN cue_sheet_required_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Licenses requiring cue sheets — compliance workload driver."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`rights_mechanical_royalty_report`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Mechanical royalty KPIs (MLC/DSP flows): gross/net royalties, streaming counts, and unmatched-usage exposure for music publishing settlement."
  source: "`vibe_media_broadcasting_v1`.`rights`.`mechanical_royalty_report`"
  dimensions:
    - name: "report_status"
      expr: report_status
      comment: "Status of the mechanical royalty report."
    - name: "dsp_name"
      expr: dsp_name
      comment: "Digital service provider reporting usage."
    - name: "territory_code"
      expr: territory_code
      comment: "Territory of the royalty report."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the royalties."
    - name: "report_period_end_month"
      expr: DATE_TRUNC('MONTH', report_period_end_date)
      comment: "Report period end month for mechanical-royalty trending."
  measures:
    - name: "report_count"
      expr: COUNT(1)
      comment: "Number of mechanical royalty reports — base measure."
    - name: "total_gross_royalty"
      expr: SUM(CAST(gross_royalty_amount AS DOUBLE))
      comment: "Total gross mechanical royalties — payout obligation KPI."
    - name: "total_net_royalty"
      expr: SUM(CAST(net_royalty_amount AS DOUBLE))
      comment: "Total net mechanical royalties payable — cash-out KPI."
    - name: "total_admin_fee"
      expr: SUM(CAST(admin_fee_amount AS DOUBLE))
      comment: "Total administration fees — cost lever."
    - name: "total_interactive_streams"
      expr: SUM(CAST(interactive_streams AS DOUBLE))
      comment: "Total interactive streams — consumption KPI driving royalties."
    - name: "total_streams"
      expr: SUM(CAST(total_streams AS DOUBLE))
      comment: "Total streams across reports — overall consumption KPI."
    - name: "unmatched_usage_count"
      expr: SUM(CASE WHEN unmatched_usage_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Reports with unmatched usage — royalty leakage / matching-quality risk."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`rights_audit_session`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Rights audit KPIs: compliance scores, financial discrepancies, and remediation burden for rights-governance steering."
  source: "`vibe_media_broadcasting_v1`.`rights`.`rights_audit_session`"
  dimensions:
    - name: "audit_type"
      expr: audit_type
      comment: "Type of rights audit conducted."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the audit session."
    - name: "audit_session_status"
      expr: rights_audit_session_status
      comment: "Current status of the audit session."
    - name: "territory_scope"
      expr: territory_scope
      comment: "Territorial scope of the audit."
    - name: "audit_period_end_month"
      expr: DATE_TRUNC('MONTH', audit_period_end_date)
      comment: "Audit period end month for governance trending."
  measures:
    - name: "audit_session_count"
      expr: COUNT(1)
      comment: "Number of rights audit sessions — governance activity base measure."
    - name: "avg_compliance_score"
      expr: AVG(CAST(compliance_score AS DOUBLE))
      comment: "Average compliance score — rights-governance quality KPI."
    - name: "total_financial_discrepancy"
      expr: SUM(CAST(financial_discrepancy_amount AS DOUBLE))
      comment: "Total financial discrepancies found — recovery / risk exposure."
    - name: "total_records_reviewed"
      expr: SUM(CAST(total_records_reviewed AS DOUBLE))
      comment: "Total records reviewed — audit coverage KPI."
    - name: "remediation_required_count"
      expr: SUM(CASE WHEN remediation_required_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Sessions requiring remediation — corrective-action backlog."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`rights_grant`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Key financial and exclusivity metrics for rights grants"
  source: "`vibe_media_broadcasting_v1`.`rights`.`grant`"
  dimensions:
    - name: "grant_status"
      expr: grant_status
      comment: "Current status of the grant (e.g., active, expired)"
    - name: "grant_media_type"
      expr: media_type
      comment: "Media type associated with the grant (e.g., TV, digital)"
    - name: "grant_start_month"
      expr: DATE_TRUNC('month', start_date)
      comment: "Month of grant start date"
    - name: "grant_territory_id"
      expr: rights_territory_id
      comment: "Territory identifier for the grant"
  measures:
    - name: "total_minimum_guarantee_amount"
      expr: SUM(CAST(minimum_guarantee_amount AS DOUBLE))
      comment: "Total minimum guarantee amount across all grants"
    - name: "average_royalty_rate_percent"
      expr: AVG(CAST(royalty_rate_percent AS DOUBLE))
      comment: "Average royalty rate percent across grants"
    - name: "exclusive_grant_count"
      expr: SUM(CASE WHEN exclusivity_indicator THEN 1 ELSE 0 END)
      comment: "Number of grants marked as exclusive"
$$;