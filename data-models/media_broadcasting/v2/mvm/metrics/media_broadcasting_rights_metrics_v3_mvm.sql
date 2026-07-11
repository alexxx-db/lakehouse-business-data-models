-- Metric views for domain: rights | Business: Media_Broadcasting | Version: 3 | Generated on: 2026-07-10 21:12:10

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`rights_availability_window`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Availability Window business metrics"
  source: "`vibe_media_broadcasting_v1`.`rights`.`availability_window`"
  dimensions:
    - name: "Advertising Allowed"
      expr: advertising_allowed
    - name: "Availability End Date"
      expr: availability_end_date
    - name: "Availability Start Date"
      expr: availability_start_date
    - name: "Blackout Indicator"
      expr: blackout_indicator
    - name: "Carriage Fee Applicable"
      expr: carriage_fee_applicable
    - name: "Clearance Status"
      expr: clearance_status
    - name: "Computed Timestamp"
      expr: computed_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Dai Enabled"
      expr: dai_enabled
    - name: "Download To Own Allowed"
      expr: download_to_own_allowed
    - name: "Drm Requirement"
      expr: drm_requirement
    - name: "Effective Timestamp"
      expr: effective_timestamp
    - name: "Exclusivity Flag"
      expr: exclusivity_flag
    - name: "Expiration Notification Sent"
      expr: expiration_notification_sent
    - name: "Holdback Period Days"
      expr: holdback_period_days
    - name: "Language Code"
      expr: language_code
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Availability Window"
      expr: COUNT(DISTINCT availability_window_id)
    - name: "Total Minimum Guarantee Amount"
      expr: SUM(minimum_guarantee_amount)
    - name: "Average Minimum Guarantee Amount"
      expr: AVG(minimum_guarantee_amount)
    - name: "Total Royalty Rate Percent"
      expr: SUM(royalty_rate_percent)
    - name: "Average Royalty Rate Percent"
      expr: AVG(royalty_rate_percent)
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`rights_clearance_request`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Clearance Request business metrics"
  source: "`vibe_media_broadcasting_v1`.`rights`.`clearance_request`"
  dimensions:
    - name: "Analyst Notes"
      expr: analyst_notes
    - name: "Blocking Category"
      expr: blocking_category
    - name: "Blocking Reason"
      expr: blocking_reason
    - name: "Clearance Decision"
      expr: clearance_decision
    - name: "Clearance Status"
      expr: clearance_status
    - name: "Conditional Requirements"
      expr: conditional_requirements
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Escalation Reason"
      expr: escalation_reason
    - name: "Escalation Timestamp"
      expr: escalation_timestamp
    - name: "Exploitation Type"
      expr: exploitation_type
    - name: "Integration Status"
      expr: integration_status
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Music Clearance Required"
      expr: music_clearance_required
    - name: "Platform Channel"
      expr: platform_channel
    - name: "Priority Level"
      expr: priority_level
    - name: "Request Number"
      expr: request_number
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Clearance Request"
      expr: COUNT(DISTINCT clearance_request_id)
    - name: "Total Estimated Audience Reach"
      expr: SUM(estimated_audience_reach)
    - name: "Average Estimated Audience Reach"
      expr: AVG(estimated_audience_reach)
    - name: "Total Estimated Grp"
      expr: SUM(estimated_grp)
    - name: "Average Estimated Grp"
      expr: AVG(estimated_grp)
    - name: "Total Estimated Residuals Amount"
      expr: SUM(estimated_residuals_amount)
    - name: "Average Estimated Residuals Amount"
      expr: AVG(estimated_residuals_amount)
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`rights_content_window`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Content Window business metrics"
  source: "`vibe_media_broadcasting_v1`.`rights`.`content_window`"
  dimensions:
    - name: "Active Flag"
      expr: active_flag
    - name: "Availability Status"
      expr: availability_status
    - name: "Blackout Flag"
      expr: blackout_flag
    - name: "Blackout Reason"
      expr: blackout_reason
    - name: "Clearance Notes"
      expr: clearance_notes
    - name: "Clearance Status"
      expr: clearance_status
    - name: "Created By User"
      expr: created_by_user
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Drm Requirement"
      expr: drm_requirement
    - name: "Exclusivity Tier"
      expr: exclusivity_tier
    - name: "Geo Blocking Required Flag"
      expr: geo_blocking_required_flag
    - name: "Holdback End Date"
      expr: holdback_end_date
    - name: "Holdback Start Date"
      expr: holdback_start_date
    - name: "Last Availability Refresh Timestamp"
      expr: last_availability_refresh_timestamp
    - name: "License Fee Currency"
      expr: license_fee_currency
    - name: "Modified By User"
      expr: modified_by_user
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Content Window"
      expr: COUNT(DISTINCT content_window_id)
    - name: "Total License Fee Amount"
      expr: SUM(license_fee_amount)
    - name: "Average License Fee Amount"
      expr: AVG(license_fee_amount)
    - name: "Total Minimum Guarantee Amount"
      expr: SUM(minimum_guarantee_amount)
    - name: "Average Minimum Guarantee Amount"
      expr: AVG(minimum_guarantee_amount)
    - name: "Total Revenue Share Percent"
      expr: SUM(revenue_share_percent)
    - name: "Average Revenue Share Percent"
      expr: AVG(revenue_share_percent)
    - name: "Total Royalty Rate Percent"
      expr: SUM(royalty_rate_percent)
    - name: "Average Royalty Rate Percent"
      expr: AVG(royalty_rate_percent)
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`rights_grant`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Grant business metrics"
  source: "`vibe_media_broadcasting_v1`.`rights`.`grant`"
  dimensions:
    - name: "Blackout Applicable"
      expr: blackout_applicable
    - name: "Carriage Fee Applicable"
      expr: carriage_fee_applicable
    - name: "Clearance Status"
      expr: clearance_status
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Drm Required"
      expr: drm_required
    - name: "End Date"
      expr: end_date
    - name: "Exclusivity Indicator"
      expr: exclusivity_indicator
    - name: "Grant Number"
      expr: grant_number
    - name: "Grant Status"
      expr: grant_status
    - name: "Holdback Applicable"
      expr: holdback_applicable
    - name: "Holdback End Date"
      expr: holdback_end_date
    - name: "Holdback Start Date"
      expr: holdback_start_date
    - name: "Language Version"
      expr: language_version
    - name: "Media Type"
      expr: media_type
    - name: "Modified Timestamp"
      expr: modified_timestamp
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Grant"
      expr: COUNT(DISTINCT grant_id)
    - name: "Total Minimum Guarantee Amount"
      expr: SUM(minimum_guarantee_amount)
    - name: "Average Minimum Guarantee Amount"
      expr: AVG(minimum_guarantee_amount)
    - name: "Total Royalty Rate Percent"
      expr: SUM(royalty_rate_percent)
    - name: "Average Royalty Rate Percent"
      expr: AVG(royalty_rate_percent)
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`rights_holdback`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Holdback business metrics"
  source: "`vibe_media_broadcasting_v1`.`rights`.`holdback`"
  dimensions:
    - name: "Automated Enforcement Flag"
      expr: automated_enforcement_flag
    - name: "Carriage Negotiation Reference"
      expr: carriage_negotiation_reference
    - name: "Clearance Workflow Status"
      expr: clearance_workflow_status
    - name: "Code"
      expr: code
    - name: "Conflict Resolution Notes"
      expr: conflict_resolution_notes
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Duration Days"
      expr: duration_days
    - name: "End Date"
      expr: end_date
    - name: "Enforcement Status"
      expr: enforcement_status
    - name: "Exclusivity Scope"
      expr: exclusivity_scope
    - name: "Last Modified By"
      expr: last_modified_by
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Notification Sent Flag"
      expr: notification_sent_flag
    - name: "Priority Level"
      expr: priority_level
    - name: "Restricted Channel"
      expr: restricted_channel
    - name: "Restricted Format"
      expr: restricted_format
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Holdback"
      expr: COUNT(DISTINCT holdback_id)
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`rights_holder`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Holder business metrics"
  source: "`vibe_media_broadcasting_v1`.`rights`.`holder`"
  dimensions:
    - name: "Audit Rights Flag"
      expr: audit_rights_flag
    - name: "Bank Account Name"
      expr: bank_account_name
    - name: "Bank Account Number"
      expr: bank_account_number
    - name: "Bank Routing Number"
      expr: bank_routing_number
    - name: "Clearance Priority Level"
      expr: clearance_priority_level
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Entity Type"
      expr: entity_type
    - name: "Exclusivity Preference"
      expr: exclusivity_preference
    - name: "Guild Affiliation"
      expr: guild_affiliation
    - name: "Last Modified By"
      expr: last_modified_by
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Most Favored Nations Flag"
      expr: most_favored_nations_flag
    - name: "Notes"
      expr: notes
    - name: "Payment Method"
      expr: payment_method
    - name: "Payment Terms Days"
      expr: payment_terms_days
    - name: "Preferred Currency"
      expr: preferred_currency
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Holder"
      expr: COUNT(DISTINCT holder_id)
    - name: "Total Credit Limit Amount"
      expr: SUM(credit_limit_amount)
    - name: "Average Credit Limit Amount"
      expr: AVG(credit_limit_amount)
    - name: "Total Default Royalty Rate"
      expr: SUM(default_royalty_rate)
    - name: "Average Default Royalty Rate"
      expr: AVG(default_royalty_rate)
    - name: "Total Minimum Guarantee Threshold"
      expr: SUM(minimum_guarantee_threshold)
    - name: "Average Minimum Guarantee Threshold"
      expr: AVG(minimum_guarantee_threshold)
    - name: "Total Tax Withholding Rate"
      expr: SUM(tax_withholding_rate)
    - name: "Average Tax Withholding Rate"
      expr: AVG(tax_withholding_rate)
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`rights_license_agreement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "License Agreement business metrics"
  source: "`vibe_media_broadcasting_v1`.`rights`.`license_agreement`"
  dimensions:
    - name: "Agreement Number"
      expr: agreement_number
    - name: "Agreement Status"
      expr: agreement_status
    - name: "Agreement Type"
      expr: agreement_type
    - name: "Auto Renewal Flag"
      expr: auto_renewal_flag
    - name: "Blackout Restrictions"
      expr: blackout_restrictions
    - name: "Clearance Required Flag"
      expr: clearance_required_flag
    - name: "Content Rating Restriction"
      expr: content_rating_restriction
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Effective Date"
      expr: effective_date
    - name: "Exclusivity Flag"
      expr: exclusivity_flag
    - name: "Expiry Date"
      expr: expiry_date
    - name: "Governing Law Jurisdiction"
      expr: governing_law_jurisdiction
    - name: "Holdback Period Days"
      expr: holdback_period_days
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Media Rights Granted"
      expr: media_rights_granted
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct License Agreement"
      expr: COUNT(DISTINCT license_agreement_id)
    - name: "Total Advance Payment Amount"
      expr: SUM(advance_payment_amount)
    - name: "Average Advance Payment Amount"
      expr: AVG(advance_payment_amount)
    - name: "Total Minimum Guarantee Amount"
      expr: SUM(minimum_guarantee_amount)
    - name: "Average Minimum Guarantee Amount"
      expr: AVG(minimum_guarantee_amount)
    - name: "Total Per Episode Fee"
      expr: SUM(per_episode_fee)
    - name: "Average Per Episode Fee"
      expr: AVG(per_episode_fee)
    - name: "Total Royalty Percentage"
      expr: SUM(royalty_percentage)
    - name: "Average Royalty Percentage"
      expr: AVG(royalty_percentage)
    - name: "Total Total License Fee"
      expr: SUM(total_license_fee)
    - name: "Average Total License Fee"
      expr: AVG(total_license_fee)
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`rights_royalty_rule`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Royalty Rule business metrics"
  source: "`vibe_media_broadcasting_v1`.`rights`.`royalty_rule`"
  dimensions:
    - name: "Approval Status"
      expr: approval_status
    - name: "Approved By"
      expr: approved_by
    - name: "Approved Date"
      expr: approved_date
    - name: "Audit Rights Flag"
      expr: audit_rights_flag
    - name: "Calculation Basis"
      expr: calculation_basis
    - name: "Content Type"
      expr: content_type
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Deduction Allowed Flag"
      expr: deduction_allowed_flag
    - name: "Effective End Date"
      expr: effective_end_date
    - name: "Effective Start Date"
      expr: effective_start_date
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Notes"
      expr: notes
    - name: "Payment Frequency"
      expr: payment_frequency
    - name: "Payment Timing"
      expr: payment_timing
    - name: "Platform Type"
      expr: platform_type
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Royalty Rule"
      expr: COUNT(DISTINCT royalty_rule_id)
    - name: "Total Deduction Percentage"
      expr: SUM(deduction_percentage)
    - name: "Average Deduction Percentage"
      expr: AVG(deduction_percentage)
    - name: "Total Maximum Cap Amount"
      expr: SUM(maximum_cap_amount)
    - name: "Average Maximum Cap Amount"
      expr: AVG(maximum_cap_amount)
    - name: "Total Minimum Guarantee Amount"
      expr: SUM(minimum_guarantee_amount)
    - name: "Average Minimum Guarantee Amount"
      expr: AVG(minimum_guarantee_amount)
    - name: "Total Rate Value"
      expr: SUM(rate_value)
    - name: "Average Rate Value"
      expr: AVG(rate_value)
    - name: "Total Recoupment Threshold"
      expr: SUM(recoupment_threshold)
    - name: "Average Recoupment Threshold"
      expr: AVG(recoupment_threshold)
    - name: "Total Threshold Value"
      expr: SUM(threshold_value)
    - name: "Average Threshold Value"
      expr: AVG(threshold_value)
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`rights_royalty_statement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Royalty Statement business metrics"
  source: "`vibe_media_broadcasting_v1`.`rights`.`royalty_statement`"
  dimensions:
    - name: "Approved By"
      expr: approved_by
    - name: "Approved Timestamp"
      expr: approved_timestamp
    - name: "Content Title Breakdown"
      expr: content_title_breakdown
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Dispute Date"
      expr: dispute_date
    - name: "Dispute Reason"
      expr: dispute_reason
    - name: "Exploitation Type Breakdown"
      expr: exploitation_type_breakdown
    - name: "Modified Timestamp"
      expr: modified_timestamp
    - name: "Paid Timestamp"
      expr: paid_timestamp
    - name: "Payment Method"
      expr: payment_method
    - name: "Payment Reference Number"
      expr: payment_reference_number
    - name: "Resolution Date"
      expr: resolution_date
    - name: "Statement Due Date"
      expr: statement_due_date
    - name: "Statement Frequency"
      expr: statement_frequency
    - name: "Statement Issue Date"
      expr: statement_issue_date
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Royalty Statement"
      expr: COUNT(DISTINCT royalty_statement_id)
    - name: "Total Adjustment Amount"
      expr: SUM(adjustment_amount)
    - name: "Average Adjustment Amount"
      expr: AVG(adjustment_amount)
    - name: "Total Advance Recoupment Amount"
      expr: SUM(advance_recoupment_amount)
    - name: "Average Advance Recoupment Amount"
      expr: AVG(advance_recoupment_amount)
    - name: "Total Exchange Rate"
      expr: SUM(exchange_rate)
    - name: "Average Exchange Rate"
      expr: AVG(exchange_rate)
    - name: "Total Gross Royalty Amount"
      expr: SUM(gross_royalty_amount)
    - name: "Average Gross Royalty Amount"
      expr: AVG(gross_royalty_amount)
    - name: "Total Minimum Guarantee Shortfall"
      expr: SUM(minimum_guarantee_shortfall)
    - name: "Average Minimum Guarantee Shortfall"
      expr: AVG(minimum_guarantee_shortfall)
    - name: "Total Net Royalty Amount"
      expr: SUM(net_royalty_amount)
    - name: "Average Net Royalty Amount"
      expr: AVG(net_royalty_amount)
    - name: "Total Withholding Tax Amount"
      expr: SUM(withholding_tax_amount)
    - name: "Average Withholding Tax Amount"
      expr: AVG(withholding_tax_amount)
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`rights_royalty_statement_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Royalty Statement Line business metrics"
  source: "`vibe_media_broadcasting_v1`.`rights`.`royalty_statement_line`"
  dimensions:
    - name: "Audit Trail Reference"
      expr: audit_trail_reference
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Dispute Status"
      expr: dispute_status
    - name: "Eidr Identifier"
      expr: eidr_identifier
    - name: "Exploitation Period End Date"
      expr: exploitation_period_end_date
    - name: "Exploitation Period Start Date"
      expr: exploitation_period_start_date
    - name: "Exploitation Type"
      expr: exploitation_type
    - name: "Holdback Status"
      expr: holdback_status
    - name: "Line Number"
      expr: line_number
    - name: "Notes"
      expr: notes
    - name: "Payment Date"
      expr: payment_date
    - name: "Payment Status"
      expr: payment_status
    - name: "Platform Name"
      expr: platform_name
    - name: "Residual Type"
      expr: residual_type
    - name: "Rights Holder Name"
      expr: rights_holder_name
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Royalty Statement Line"
      expr: COUNT(DISTINCT royalty_statement_line_id)
    - name: "Total Adjustments Amount"
      expr: SUM(adjustments_amount)
    - name: "Average Adjustments Amount"
      expr: AVG(adjustments_amount)
    - name: "Total Advance Recoupment Amount"
      expr: SUM(advance_recoupment_amount)
    - name: "Average Advance Recoupment Amount"
      expr: AVG(advance_recoupment_amount)
    - name: "Total Calculated Royalty Amount"
      expr: SUM(calculated_royalty_amount)
    - name: "Average Calculated Royalty Amount"
      expr: AVG(calculated_royalty_amount)
    - name: "Total Deductions Amount"
      expr: SUM(deductions_amount)
    - name: "Average Deductions Amount"
      expr: AVG(deductions_amount)
    - name: "Total Gross Revenue Amount"
      expr: SUM(gross_revenue_amount)
    - name: "Average Gross Revenue Amount"
      expr: AVG(gross_revenue_amount)
    - name: "Total Net Payable Amount"
      expr: SUM(net_payable_amount)
    - name: "Average Net Payable Amount"
      expr: AVG(net_payable_amount)
    - name: "Total Net Revenue Amount"
      expr: SUM(net_revenue_amount)
    - name: "Average Net Revenue Amount"
      expr: AVG(net_revenue_amount)
    - name: "Total Royalty Rate Percentage"
      expr: SUM(royalty_rate_percentage)
    - name: "Average Royalty Rate Percentage"
      expr: AVG(royalty_rate_percentage)
    - name: "Total Units Exploited"
      expr: SUM(units_exploited)
    - name: "Average Units Exploited"
      expr: AVG(units_exploited)
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`rights_territory`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Territory business metrics"
  source: "`vibe_media_broadcasting_v1`.`rights`.`territory`"
  dimensions:
    - name: "Blackout Restricted Flag"
      expr: blackout_restricted_flag
    - name: "Broadcast Standard"
      expr: broadcast_standard
    - name: "Code"
      expr: code
    - name: "Content Rating System"
      expr: content_rating_system
    - name: "Coppa Applicable Flag"
      expr: coppa_applicable_flag
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Effective Date"
      expr: effective_date
    - name: "Expiration Date"
      expr: expiration_date
    - name: "Gdpr Applicable Flag"
      expr: gdpr_applicable_flag
    - name: "Holdback Eligible Flag"
      expr: holdback_eligible_flag
    - name: "Iso Alpha 2 Code"
      expr: iso_alpha_2_code
    - name: "Iso Alpha 3 Code"
      expr: iso_alpha_3_code
    - name: "Iso Numeric Code"
      expr: iso_numeric_code
    - name: "Language Primary"
      expr: language_primary
    - name: "Language Secondary"
      expr: language_secondary
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Territory"
      expr: COUNT(DISTINCT territory_id)
    - name: "Total Internet Penetration Percent"
      expr: SUM(internet_penetration_percent)
    - name: "Average Internet Penetration Percent"
      expr: AVG(internet_penetration_percent)
    - name: "Total Population"
      expr: SUM(population)
    - name: "Average Population"
      expr: AVG(population)
    - name: "Total Quota Percentage"
      expr: SUM(quota_percentage)
    - name: "Average Quota Percentage"
      expr: AVG(quota_percentage)
    - name: "Total Vat Rate Percent"
      expr: SUM(vat_rate_percent)
    - name: "Average Vat Rate Percent"
      expr: AVG(vat_rate_percent)
    - name: "Total Withholding Tax Rate Percent"
      expr: SUM(withholding_tax_rate_percent)
    - name: "Average Withholding Tax Rate Percent"
      expr: AVG(withholding_tax_rate_percent)
$$;