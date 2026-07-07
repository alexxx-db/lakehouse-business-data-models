-- Metric views for domain: rights | Business: Media_Broadcasting | Version: 2 | Generated on: 2026-06-30 06:47:57

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`rights_license_agreement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core licensing economics and agreement performance metrics tracking revenue, guarantees, and contract lifecycle"
  source: "`vibe_media_broadcasting_v1`.`rights`.`license_agreement`"
  dimensions:
    - name: "agreement_status"
      expr: agreement_status
      comment: "Current status of the license agreement (active, expired, terminated, etc.)"
    - name: "agreement_type"
      expr: agreement_type
      comment: "Type of license agreement (distribution, syndication, format, etc.)"
    - name: "territory_scope"
      expr: territory_scope
      comment: "Geographic territory covered by the license"
    - name: "exclusivity_flag"
      expr: exclusivity_flag
      comment: "Whether the license grants exclusive rights"
    - name: "effective_year"
      expr: YEAR(effective_date)
      comment: "Year the license agreement became effective"
    - name: "effective_quarter"
      expr: CONCAT('Q', QUARTER(effective_date), '-', YEAR(effective_date))
      comment: "Quarter and year the license agreement became effective"
    - name: "expiry_year"
      expr: YEAR(expiry_date)
      comment: "Year the license agreement expires"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which license fees are denominated"
    - name: "auto_renewal_flag"
      expr: auto_renewal_flag
      comment: "Whether the agreement automatically renews"
    - name: "sublicensing_allowed_flag"
      expr: sublicensing_allowed_flag
      comment: "Whether sublicensing is permitted under this agreement"
  measures:
    - name: "total_license_fee_amount"
      expr: SUM(CAST(total_license_fee AS DOUBLE))
      comment: "Total contracted license fee revenue across all agreements"
    - name: "total_minimum_guarantee_amount"
      expr: SUM(CAST(minimum_guarantee_amount AS DOUBLE))
      comment: "Total minimum guarantee commitments across all agreements"
    - name: "total_advance_payment_amount"
      expr: SUM(CAST(advance_payment_amount AS DOUBLE))
      comment: "Total advance payments received across all agreements"
    - name: "avg_license_fee_per_agreement"
      expr: AVG(CAST(total_license_fee AS DOUBLE))
      comment: "Average license fee per agreement"
    - name: "avg_minimum_guarantee"
      expr: AVG(CAST(minimum_guarantee_amount AS DOUBLE))
      comment: "Average minimum guarantee per agreement"
    - name: "avg_royalty_percentage"
      expr: AVG(CAST(royalty_percentage AS DOUBLE))
      comment: "Average royalty percentage across agreements"
    - name: "agreement_count"
      expr: COUNT(license_agreement_id)
      comment: "Total number of license agreements"
    - name: "exclusive_agreement_count"
      expr: COUNT(CASE WHEN exclusivity_flag = TRUE THEN license_agreement_id END)
      comment: "Number of exclusive license agreements"
    - name: "active_agreement_count"
      expr: COUNT(CASE WHEN agreement_status = 'Active' THEN license_agreement_id END)
      comment: "Number of currently active license agreements"
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`rights_royalty_statement_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Detailed royalty performance and revenue distribution metrics by exploitation type, platform, and content"
  source: "`vibe_media_broadcasting_v1`.`rights`.`royalty_statement_line`"
  dimensions:
    - name: "exploitation_type"
      expr: exploitation_type
      comment: "Type of content exploitation (streaming, broadcast, theatrical, home video, etc.)"
    - name: "platform_name"
      expr: platform_name
      comment: "Platform or channel where content was exploited"
    - name: "window_type"
      expr: window_type
      comment: "Distribution window (theatrical, SVOD, AVOD, TVOD, etc.)"
    - name: "payment_status"
      expr: payment_status
      comment: "Payment status of the royalty line (pending, paid, disputed, etc.)"
    - name: "dispute_status"
      expr: dispute_status
      comment: "Dispute status of the royalty line"
    - name: "holdback_status"
      expr: holdback_status
      comment: "Whether the line is subject to holdback restrictions"
    - name: "residual_type"
      expr: residual_type
      comment: "Type of residual payment (rerun, foreign, new media, etc.)"
    - name: "exploitation_period_year"
      expr: YEAR(exploitation_period_start_date)
      comment: "Year of the exploitation period start"
    - name: "exploitation_period_quarter"
      expr: CONCAT('Q', QUARTER(exploitation_period_start_date), '-', YEAR(exploitation_period_start_date))
      comment: "Quarter and year of the exploitation period start"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which royalty amounts are denominated"
  measures:
    - name: "total_gross_revenue"
      expr: SUM(CAST(gross_revenue_amount AS DOUBLE))
      comment: "Total gross revenue before deductions and recoupment"
    - name: "total_net_revenue"
      expr: SUM(CAST(net_revenue_amount AS DOUBLE))
      comment: "Total net revenue after deductions"
    - name: "total_calculated_royalty"
      expr: SUM(CAST(calculated_royalty_amount AS DOUBLE))
      comment: "Total calculated royalty amount before recoupment"
    - name: "total_net_payable"
      expr: SUM(CAST(net_payable_amount AS DOUBLE))
      comment: "Total net payable amount after all adjustments and recoupment"
    - name: "total_deductions"
      expr: SUM(CAST(deductions_amount AS DOUBLE))
      comment: "Total deductions applied to gross revenue"
    - name: "total_adjustments"
      expr: SUM(CAST(adjustments_amount AS DOUBLE))
      comment: "Total adjustments applied to royalty calculations"
    - name: "total_advance_recoupment"
      expr: SUM(CAST(advance_recoupment_amount AS DOUBLE))
      comment: "Total advance recoupment deducted from royalties"
    - name: "total_units_exploited"
      expr: SUM(CAST(units_exploited AS DOUBLE))
      comment: "Total units exploited (streams, views, broadcasts, units sold, etc.)"
    - name: "avg_royalty_rate"
      expr: AVG(CAST(royalty_rate_percentage AS DOUBLE))
      comment: "Average royalty rate percentage across all lines"
    - name: "royalty_line_count"
      expr: COUNT(royalty_statement_line_id)
      comment: "Total number of royalty statement lines"
    - name: "disputed_line_count"
      expr: COUNT(CASE WHEN dispute_status IS NOT NULL AND dispute_status != '' THEN royalty_statement_line_id END)
      comment: "Number of royalty lines under dispute"
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`rights_residual`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Talent residual payment performance tracking guild compliance, payment velocity, and backend participation"
  source: "`vibe_media_broadcasting_v1`.`rights`.`residual`"
  dimensions:
    - name: "payment_status"
      expr: payment_status
      comment: "Current payment status (pending, paid, disputed, cancelled, etc.)"
    - name: "exploitation_type"
      expr: exploitation_type
      comment: "Type of exploitation triggering the residual (rerun, streaming, foreign, etc.)"
    - name: "guild_union_code"
      expr: guild_union_code
      comment: "Guild or union code (SAG-AFTRA, DGA, WGA, etc.)"
    - name: "formula_type"
      expr: formula_type
      comment: "Residual calculation formula type"
    - name: "payment_method"
      expr: payment_method
      comment: "Method of payment (direct deposit, check, wire, etc.)"
    - name: "currency"
      expr: currency
      comment: "Currency in which residual is paid"
    - name: "calculation_year"
      expr: YEAR(calculation_date)
      comment: "Year the residual was calculated"
    - name: "calculation_quarter"
      expr: CONCAT('Q', QUARTER(calculation_date), '-', YEAR(calculation_date))
      comment: "Quarter and year the residual was calculated"
    - name: "payment_year"
      expr: YEAR(payment_date)
      comment: "Year the residual was paid"
    - name: "guild_report_submitted_flag"
      expr: guild_report_submitted_flag
      comment: "Whether guild report has been submitted for this residual"
    - name: "participation_linked_flag"
      expr: participation_linked_flag
      comment: "Whether residual is linked to backend participation"
  measures:
    - name: "total_calculated_residual"
      expr: SUM(CAST(calculated_residual_amount AS DOUBLE))
      comment: "Total calculated residual amount before withholding"
    - name: "total_net_payment"
      expr: SUM(CAST(net_payment_amount AS DOUBLE))
      comment: "Total net residual payment after withholding"
    - name: "total_withholding_tax"
      expr: SUM(CAST(withholding_tax_amount AS DOUBLE))
      comment: "Total withholding tax deducted from residuals"
    - name: "total_calculation_basis"
      expr: SUM(CAST(calculation_basis_amount AS DOUBLE))
      comment: "Total basis amount used for residual calculations"
    - name: "avg_residual_per_payment"
      expr: AVG(CAST(calculated_residual_amount AS DOUBLE))
      comment: "Average residual amount per payment"
    - name: "avg_percentage_rate"
      expr: AVG(CAST(percentage AS DOUBLE))
      comment: "Average residual percentage rate"
    - name: "residual_payment_count"
      expr: COUNT(residual_id)
      comment: "Total number of residual payments"
    - name: "paid_residual_count"
      expr: COUNT(CASE WHEN payment_status = 'Paid' THEN residual_id END)
      comment: "Number of residuals that have been paid"
    - name: "disputed_residual_count"
      expr: COUNT(CASE WHEN dispute_date IS NOT NULL THEN residual_id END)
      comment: "Number of residuals under dispute"
    - name: "guild_reported_count"
      expr: COUNT(CASE WHEN guild_report_submitted_flag = TRUE THEN residual_id END)
      comment: "Number of residuals for which guild reports have been submitted"
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`rights_clearance_request`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Rights clearance workflow efficiency and compliance metrics tracking SLA performance and blocking issues"
  source: "`vibe_media_broadcasting_v1`.`rights`.`clearance_request`"
  dimensions:
    - name: "clearance_status"
      expr: clearance_status
      comment: "Current status of the clearance request (pending, approved, denied, conditional, etc.)"
    - name: "clearance_decision"
      expr: clearance_decision
      comment: "Final clearance decision"
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level of the clearance request (urgent, high, normal, low)"
    - name: "exploitation_type"
      expr: exploitation_type
      comment: "Type of exploitation requiring clearance"
    - name: "blocking_category"
      expr: blocking_category
      comment: "Category of blocking issue if clearance is blocked"
    - name: "requesting_department"
      expr: requesting_department
      comment: "Department requesting the clearance"
    - name: "sla_met"
      expr: sla_met
      comment: "Whether the clearance request met SLA targets"
    - name: "music_clearance_required"
      expr: music_clearance_required
      comment: "Whether music clearance is required"
    - name: "talent_approval_required"
      expr: talent_approval_required
      comment: "Whether talent approval is required"
    - name: "residuals_triggered"
      expr: residuals_triggered
      comment: "Whether the clearance triggers residual payments"
    - name: "request_year"
      expr: YEAR(request_submitted_timestamp)
      comment: "Year the clearance request was submitted"
    - name: "request_quarter"
      expr: CONCAT('Q', QUARTER(request_submitted_timestamp), '-', YEAR(request_submitted_timestamp))
      comment: "Quarter and year the clearance request was submitted"
  measures:
    - name: "clearance_request_count"
      expr: COUNT(clearance_request_id)
      comment: "Total number of clearance requests"
    - name: "approved_request_count"
      expr: COUNT(CASE WHEN clearance_decision = 'Approved' THEN clearance_request_id END)
      comment: "Number of approved clearance requests"
    - name: "denied_request_count"
      expr: COUNT(CASE WHEN clearance_decision = 'Denied' THEN clearance_request_id END)
      comment: "Number of denied clearance requests"
    - name: "sla_met_count"
      expr: COUNT(CASE WHEN sla_met = TRUE THEN clearance_request_id END)
      comment: "Number of clearance requests that met SLA"
    - name: "blocked_request_count"
      expr: COUNT(CASE WHEN blocking_category IS NOT NULL AND blocking_category != '' THEN clearance_request_id END)
      comment: "Number of clearance requests that are blocked"
    - name: "total_estimated_audience_reach"
      expr: SUM(CAST(estimated_audience_reach AS DOUBLE))
      comment: "Total estimated audience reach across all clearance requests"
    - name: "total_estimated_grp"
      expr: SUM(CAST(estimated_grp AS DOUBLE))
      comment: "Total estimated gross rating points across all clearance requests"
    - name: "total_estimated_residuals"
      expr: SUM(CAST(estimated_residuals_amount AS DOUBLE))
      comment: "Total estimated residuals amount triggered by clearance requests"
    - name: "avg_estimated_residuals"
      expr: AVG(CAST(estimated_residuals_amount AS DOUBLE))
      comment: "Average estimated residuals per clearance request"
    - name: "music_clearance_required_count"
      expr: COUNT(CASE WHEN music_clearance_required = TRUE THEN clearance_request_id END)
      comment: "Number of requests requiring music clearance"
    - name: "talent_approval_required_count"
      expr: COUNT(CASE WHEN talent_approval_required = TRUE THEN clearance_request_id END)
      comment: "Number of requests requiring talent approval"
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`rights_grant`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Rights grant portfolio and windowing strategy metrics tracking exclusivity, holdbacks, and minimum guarantees"
  source: "`vibe_media_broadcasting_v1`.`rights`.`grant`"
  dimensions:
    - name: "grant_status"
      expr: grant_status
      comment: "Current status of the grant (active, expired, pending, terminated, etc.)"
    - name: "right_type"
      expr: right_type
      comment: "Type of right granted (distribution, broadcast, streaming, theatrical, etc.)"
    - name: "media_type"
      expr: media_type
      comment: "Media type covered by the grant (film, TV, digital, etc.)"
    - name: "window_name"
      expr: window_name
      comment: "Distribution window name (theatrical, SVOD, AVOD, etc.)"
    - name: "exclusivity_indicator"
      expr: exclusivity_indicator
      comment: "Whether the grant is exclusive"
    - name: "holdback_applicable"
      expr: holdback_applicable
      comment: "Whether holdback restrictions apply"
    - name: "sublicense_permitted"
      expr: sublicense_permitted
      comment: "Whether sublicensing is permitted"
    - name: "drm_required"
      expr: drm_required
      comment: "Whether DRM is required for this grant"
    - name: "talent_residuals_applicable"
      expr: talent_residuals_applicable
      comment: "Whether talent residuals apply to this grant"
    - name: "start_year"
      expr: YEAR(start_date)
      comment: "Year the grant becomes effective"
    - name: "end_year"
      expr: YEAR(end_date)
      comment: "Year the grant expires"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency for financial terms"
  measures:
    - name: "grant_count"
      expr: COUNT(grant_id)
      comment: "Total number of rights grants"
    - name: "active_grant_count"
      expr: COUNT(CASE WHEN grant_status = 'Active' THEN grant_id END)
      comment: "Number of currently active grants"
    - name: "exclusive_grant_count"
      expr: COUNT(CASE WHEN exclusivity_indicator = TRUE THEN grant_id END)
      comment: "Number of exclusive grants"
    - name: "total_minimum_guarantee"
      expr: SUM(CAST(minimum_guarantee_amount AS DOUBLE))
      comment: "Total minimum guarantee commitments across all grants"
    - name: "avg_minimum_guarantee"
      expr: AVG(CAST(minimum_guarantee_amount AS DOUBLE))
      comment: "Average minimum guarantee per grant"
    - name: "avg_royalty_rate"
      expr: AVG(CAST(royalty_rate_percent AS DOUBLE))
      comment: "Average royalty rate percentage across grants"
    - name: "holdback_applicable_count"
      expr: COUNT(CASE WHEN holdback_applicable = TRUE THEN grant_id END)
      comment: "Number of grants with holdback restrictions"
    - name: "drm_required_count"
      expr: COUNT(CASE WHEN drm_required = TRUE THEN grant_id END)
      comment: "Number of grants requiring DRM"
    - name: "sublicense_permitted_count"
      expr: COUNT(CASE WHEN sublicense_permitted = TRUE THEN grant_id END)
      comment: "Number of grants permitting sublicensing"
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`rights_royalty_statement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Royalty statement processing and payment performance metrics tracking statement accuracy, disputes, and cash flow"
  source: "`vibe_media_broadcasting_v1`.`rights`.`royalty_statement`"
  dimensions:
    - name: "statement_status"
      expr: statement_status
      comment: "Current status of the royalty statement (draft, issued, paid, disputed, etc.)"
    - name: "statement_frequency"
      expr: statement_frequency
      comment: "Frequency of statement issuance (monthly, quarterly, annual, etc.)"
    - name: "payment_method"
      expr: payment_method
      comment: "Method of payment (wire, check, ACH, etc.)"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which royalties are denominated"
    - name: "statement_issue_year"
      expr: YEAR(statement_issue_date)
      comment: "Year the statement was issued"
    - name: "statement_issue_quarter"
      expr: CONCAT('Q', QUARTER(statement_issue_date), '-', YEAR(statement_issue_date))
      comment: "Quarter and year the statement was issued"
    - name: "statement_period_year"
      expr: YEAR(statement_period_start_date)
      comment: "Year of the statement period start"
    - name: "has_dispute"
      expr: CASE WHEN dispute_date IS NOT NULL THEN TRUE ELSE FALSE END
      comment: "Whether the statement has been disputed"
  measures:
    - name: "statement_count"
      expr: COUNT(royalty_statement_id)
      comment: "Total number of royalty statements"
    - name: "total_gross_royalty"
      expr: SUM(CAST(gross_royalty_amount AS DOUBLE))
      comment: "Total gross royalty amount before adjustments"
    - name: "total_net_royalty"
      expr: SUM(CAST(net_royalty_amount AS DOUBLE))
      comment: "Total net royalty amount after all adjustments"
    - name: "total_adjustment"
      expr: SUM(CAST(adjustment_amount AS DOUBLE))
      comment: "Total adjustments applied to royalty statements"
    - name: "total_advance_recoupment"
      expr: SUM(CAST(advance_recoupment_amount AS DOUBLE))
      comment: "Total advance recoupment deducted from royalties"
    - name: "total_withholding_tax"
      expr: SUM(CAST(withholding_tax_amount AS DOUBLE))
      comment: "Total withholding tax deducted from royalty payments"
    - name: "total_mg_shortfall"
      expr: SUM(CAST(minimum_guarantee_shortfall AS DOUBLE))
      comment: "Total minimum guarantee shortfall across statements"
    - name: "avg_gross_royalty"
      expr: AVG(CAST(gross_royalty_amount AS DOUBLE))
      comment: "Average gross royalty per statement"
    - name: "avg_net_royalty"
      expr: AVG(CAST(net_royalty_amount AS DOUBLE))
      comment: "Average net royalty per statement"
    - name: "paid_statement_count"
      expr: COUNT(CASE WHEN statement_status = 'Paid' THEN royalty_statement_id END)
      comment: "Number of statements that have been paid"
    - name: "disputed_statement_count"
      expr: COUNT(CASE WHEN dispute_date IS NOT NULL THEN royalty_statement_id END)
      comment: "Number of statements under dispute"
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`rights_holdback`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Holdback restriction management and windowing compliance metrics tracking enforcement and waiver activity"
  source: "`vibe_media_broadcasting_v1`.`rights`.`holdback`"
  dimensions:
    - name: "restriction_type"
      expr: restriction_type
      comment: "Type of holdback restriction (platform, territory, format, etc.)"
    - name: "enforcement_status"
      expr: enforcement_status
      comment: "Current enforcement status of the holdback"
    - name: "clearance_workflow_status"
      expr: clearance_workflow_status
      comment: "Status in the clearance workflow"
    - name: "exclusivity_scope"
      expr: exclusivity_scope
      comment: "Scope of exclusivity driving the holdback"
    - name: "triggering_window_type"
      expr: triggering_window_type
      comment: "Distribution window type that triggered the holdback"
    - name: "automated_enforcement_flag"
      expr: automated_enforcement_flag
      comment: "Whether enforcement is automated"
    - name: "notification_sent_flag"
      expr: notification_sent_flag
      comment: "Whether notification has been sent for this holdback"
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level of the holdback"
    - name: "start_year"
      expr: YEAR(start_date)
      comment: "Year the holdback period starts"
    - name: "end_year"
      expr: YEAR(end_date)
      comment: "Year the holdback period ends"
    - name: "has_waiver"
      expr: CASE WHEN waiver_approved_date IS NOT NULL THEN TRUE ELSE FALSE END
      comment: "Whether a waiver has been approved for this holdback"
  measures:
    - name: "holdback_count"
      expr: COUNT(holdback_id)
      comment: "Total number of holdback restrictions"
    - name: "active_holdback_count"
      expr: COUNT(CASE WHEN enforcement_status = 'Active' THEN holdback_id END)
      comment: "Number of currently active holdbacks"
    - name: "automated_enforcement_count"
      expr: COUNT(CASE WHEN automated_enforcement_flag = TRUE THEN holdback_id END)
      comment: "Number of holdbacks with automated enforcement"
    - name: "waiver_approved_count"
      expr: COUNT(CASE WHEN waiver_approved_date IS NOT NULL THEN holdback_id END)
      comment: "Number of holdbacks with approved waivers"
    - name: "notification_sent_count"
      expr: COUNT(CASE WHEN notification_sent_flag = TRUE THEN holdback_id END)
      comment: "Number of holdbacks for which notifications have been sent"
$$;