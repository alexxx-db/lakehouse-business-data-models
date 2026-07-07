-- Metric views for domain: production | Business: Media_Broadcasting | Version: 2 | Generated on: 2026-06-30 06:47:57

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`production_budget`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Budget business metrics"
  source: "`vibe_media_broadcasting_v1`.`production`.`budget`"
  dimensions:
    - name: "Approval Status"
      expr: approval_status
    - name: "Approved Timestamp"
      expr: approved_timestamp
    - name: "Change Reason"
      expr: change_reason
    - name: "Change Request Reference"
      expr: change_request_reference
    - name: "Cost Category Code"
      expr: cost_category_code
    - name: "Cost Category Name"
      expr: cost_category_name
    - name: "Cost Line Type"
      expr: cost_line_type
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Fiscal Period"
      expr: fiscal_period
    - name: "Fiscal Year"
      expr: fiscal_year
    - name: "Is Greenlight Budget"
      expr: is_greenlight_budget
    - name: "Is Locked"
      expr: is_locked
    - name: "Notes"
      expr: notes
    - name: "Period End Date"
      expr: period_end_date
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Budget"
      expr: COUNT(DISTINCT budget_id)
    - name: "Total Actual Cost Amount"
      expr: SUM(actual_cost_amount)
    - name: "Average Actual Cost Amount"
      expr: AVG(actual_cost_amount)
    - name: "Total Approved Amount"
      expr: SUM(approved_amount)
    - name: "Average Approved Amount"
      expr: AVG(approved_amount)
    - name: "Total Committed Amount"
      expr: SUM(committed_amount)
    - name: "Average Committed Amount"
      expr: AVG(committed_amount)
    - name: "Total Contingency Amount"
      expr: SUM(contingency_amount)
    - name: "Average Contingency Amount"
      expr: AVG(contingency_amount)
    - name: "Total Contingency Percentage"
      expr: SUM(contingency_percentage)
    - name: "Average Contingency Percentage"
      expr: AVG(contingency_percentage)
    - name: "Total Exchange Rate"
      expr: SUM(exchange_rate)
    - name: "Average Exchange Rate"
      expr: AVG(exchange_rate)
    - name: "Total Forecast Amount"
      expr: SUM(forecast_amount)
    - name: "Average Forecast Amount"
      expr: AVG(forecast_amount)
    - name: "Total Revised Amount"
      expr: SUM(revised_amount)
    - name: "Average Revised Amount"
      expr: AVG(revised_amount)
    - name: "Total Source Code"
      expr: SUM(source_code)
    - name: "Average Source Code"
      expr: AVG(source_code)
    - name: "Total Variance Amount"
      expr: SUM(variance_amount)
    - name: "Average Variance Amount"
      expr: AVG(variance_amount)
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`production_budget_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Budget Line business metrics"
  source: "`vibe_media_broadcasting_v1`.`production`.`budget_line`"
  dimensions:
    - name: "Account Code"
      expr: account_code
    - name: "Approved Timestamp"
      expr: approved_timestamp
    - name: "Cost Category"
      expr: cost_category
    - name: "Cost Sub Category"
      expr: cost_sub_category
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Gl Account Code"
      expr: gl_account_code
    - name: "Is Above The Line"
      expr: is_above_the_line
    - name: "Is Union Labor"
      expr: is_union_labor
    - name: "Line Description"
      expr: line_description
    - name: "Line Number"
      expr: line_number
    - name: "Line Status"
      expr: line_status
    - name: "Notes"
      expr: notes
    - name: "Production Phase"
      expr: production_phase
    - name: "Purchase Order Number"
      expr: purchase_order_number
    - name: "Shoot Date End"
      expr: shoot_date_end
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Budget Line"
      expr: COUNT(DISTINCT budget_line_id)
    - name: "Total Accrued Amount"
      expr: SUM(accrued_amount)
    - name: "Average Accrued Amount"
      expr: AVG(accrued_amount)
    - name: "Total Actual Amount"
      expr: SUM(actual_amount)
    - name: "Average Actual Amount"
      expr: AVG(actual_amount)
    - name: "Total Budgeted Amount"
      expr: SUM(budgeted_amount)
    - name: "Average Budgeted Amount"
      expr: AVG(budgeted_amount)
    - name: "Total Committed Amount"
      expr: SUM(committed_amount)
    - name: "Average Committed Amount"
      expr: AVG(committed_amount)
    - name: "Total Contingency Pct"
      expr: SUM(contingency_pct)
    - name: "Average Contingency Pct"
      expr: AVG(contingency_pct)
    - name: "Total Forecast Amount"
      expr: SUM(forecast_amount)
    - name: "Average Forecast Amount"
      expr: AVG(forecast_amount)
    - name: "Total Fringe Rate Pct"
      expr: SUM(fringe_rate_pct)
    - name: "Average Fringe Rate Pct"
      expr: AVG(fringe_rate_pct)
    - name: "Total Quantity"
      expr: SUM(quantity)
    - name: "Average Quantity"
      expr: AVG(quantity)
    - name: "Total Revised Budgeted Amount"
      expr: SUM(revised_budgeted_amount)
    - name: "Average Revised Budgeted Amount"
      expr: AVG(revised_budgeted_amount)
    - name: "Total Source Code"
      expr: SUM(source_code)
    - name: "Average Source Code"
      expr: AVG(source_code)
    - name: "Total Unit Rate"
      expr: SUM(unit_rate)
    - name: "Average Unit Rate"
      expr: AVG(unit_rate)
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`production_cost_transaction`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Cost Transaction business metrics"
  source: "`vibe_media_broadcasting_v1`.`production`.`cost_transaction`"
  dimensions:
    - name: "Approval Date"
      expr: approval_date
    - name: "Cost Category Code"
      expr: cost_category_code
    - name: "Cost Category Name"
      expr: cost_category_name
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Fiscal Period"
      expr: fiscal_period
    - name: "Fiscal Year"
      expr: fiscal_year
    - name: "Invoice Date"
      expr: invoice_date
    - name: "Invoice Number"
      expr: invoice_number
    - name: "Notes"
      expr: notes
    - name: "Payee Name"
      expr: payee_name
    - name: "Payment Date"
      expr: payment_date
    - name: "Payment Method"
      expr: payment_method
    - name: "Payment Status"
      expr: payment_status
    - name: "Posting Date"
      expr: posting_date
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Cost Transaction"
      expr: COUNT(DISTINCT cost_transaction_id)
    - name: "Total Exchange Rate"
      expr: SUM(exchange_rate)
    - name: "Average Exchange Rate"
      expr: AVG(exchange_rate)
    - name: "Total Net Amount"
      expr: SUM(net_amount)
    - name: "Average Net Amount"
      expr: AVG(net_amount)
    - name: "Total Reporting Currency Amount"
      expr: SUM(reporting_currency_amount)
    - name: "Average Reporting Currency Amount"
      expr: AVG(reporting_currency_amount)
    - name: "Total Source Code"
      expr: SUM(source_code)
    - name: "Average Source Code"
      expr: AVG(source_code)
    - name: "Total Tax Amount"
      expr: SUM(tax_amount)
    - name: "Average Tax Amount"
      expr: AVG(tax_amount)
    - name: "Total Transaction Amount"
      expr: SUM(transaction_amount)
    - name: "Average Transaction Amount"
      expr: AVG(transaction_amount)
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`production_crew_assignment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Crew Assignment business metrics"
  source: "`vibe_media_broadcasting_v1`.`production`.`crew_assignment`"
  dimensions:
    - name: "Assignment Number"
      expr: assignment_number
    - name: "Assignment Status"
      expr: assignment_status
    - name: "Background Check Status"
      expr: background_check_status
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Credit Name"
      expr: credit_name
    - name: "Credit Position"
      expr: credit_position
    - name: "Currency Code"
      expr: currency_code
    - name: "Dalet Workflow Reference"
      expr: dalet_workflow_reference
    - name: "Deal Type"
      expr: deal_type
    - name: "Department"
      expr: department
    - name: "End Date"
      expr: end_date
    - name: "Filming Location Country"
      expr: filming_location_country
    - name: "Guaranteed Days"
      expr: guaranteed_days
    - name: "Last Updated Timestamp"
      expr: last_updated_timestamp
    - name: "Meal Penalty Eligible"
      expr: meal_penalty_eligible
    - name: "Overtime Eligible"
      expr: overtime_eligible
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Crew Assignment"
      expr: COUNT(DISTINCT crew_assignment_id)
    - name: "Total Box Rental Rate"
      expr: SUM(box_rental_rate)
    - name: "Average Box Rental Rate"
      expr: AVG(box_rental_rate)
    - name: "Total Contracted Rate"
      expr: SUM(contracted_rate)
    - name: "Average Contracted Rate"
      expr: AVG(contracted_rate)
    - name: "Total Kit Rental Rate"
      expr: SUM(kit_rental_rate)
    - name: "Average Kit Rental Rate"
      expr: AVG(kit_rental_rate)
    - name: "Total Overtime Rate Multiplier"
      expr: SUM(overtime_rate_multiplier)
    - name: "Average Overtime Rate Multiplier"
      expr: AVG(overtime_rate_multiplier)
    - name: "Total Per Diem Rate"
      expr: SUM(per_diem_rate)
    - name: "Average Per Diem Rate"
      expr: AVG(per_diem_rate)
    - name: "Total Source Code"
      expr: SUM(source_code)
    - name: "Average Source Code"
      expr: AVG(source_code)
    - name: "Total Travel Allowance"
      expr: SUM(travel_allowance)
    - name: "Average Travel Allowance"
      expr: AVG(travel_allowance)
    - name: "Total Turnaround Hours"
      expr: SUM(turnaround_hours)
    - name: "Average Turnaround Hours"
      expr: AVG(turnaround_hours)
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`production_deliverable`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Deliverable business metrics"
  source: "`vibe_media_broadcasting_v1`.`production`.`deliverable`"
  dimensions:
    - name: "Actual Delivery Timestamp"
      expr: actual_delivery_timestamp
    - name: "Aspect Ratio"
      expr: aspect_ratio
    - name: "Audio Channels"
      expr: audio_channels
    - name: "Audio Description Flag"
      expr: audio_description_flag
    - name: "Checksum Md5"
      expr: checksum_md5
    - name: "Closed Caption Flag"
      expr: closed_caption_flag
    - name: "Compliance Certificate Flag"
      expr: compliance_certificate_flag
    - name: "Content Rating"
      expr: content_rating
    - name: "Contract Reference"
      expr: contract_reference
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Deliverable Type"
      expr: deliverable_type
    - name: "Delivery Location"
      expr: delivery_location
    - name: "Delivery Method"
      expr: delivery_method
    - name: "Delivery Status"
      expr: delivery_status
    - name: "Due Date"
      expr: due_date
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Deliverable"
      expr: COUNT(DISTINCT deliverable_id)
    - name: "Total Cost Amount"
      expr: SUM(cost_amount)
    - name: "Average Cost Amount"
      expr: AVG(cost_amount)
    - name: "Total Duration Seconds"
      expr: SUM(duration_seconds)
    - name: "Average Duration Seconds"
      expr: AVG(duration_seconds)
    - name: "Total File Size Bytes"
      expr: SUM(file_size_bytes)
    - name: "Average File Size Bytes"
      expr: AVG(file_size_bytes)
    - name: "Total Source Code"
      expr: SUM(source_code)
    - name: "Average Source Code"
      expr: AVG(source_code)
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`production_production_episode`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Production Episode business metrics"
  source: "`vibe_media_broadcasting_v1`.`production`.`production_episode`"
  dimensions:
    - name: "Actual Delivery Date"
      expr: actual_delivery_date
    - name: "Actual Running Time Sec"
      expr: actual_running_time_sec
    - name: "Audio Language Code"
      expr: audio_language_code
    - name: "Audio Mix Completion Date"
      expr: audio_mix_completion_date
    - name: "Closed Captioning Compliant"
      expr: closed_captioning_compliant
    - name: "Color Grade Completion Date"
      expr: color_grade_completion_date
    - name: "Content Rating"
      expr: content_rating
    - name: "Content Type"
      expr: content_type
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Delivery Date"
      expr: delivery_date
    - name: "Director Name"
      expr: director_name
    - name: "Eidr Code"
      expr: eidr_code
    - name: "Episode Code"
      expr: episode_code
    - name: "Episode Number"
      expr: episode_number
    - name: "First Air Date"
      expr: first_air_date
    - name: "Greenlight Date"
      expr: greenlight_date
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Production Episode"
      expr: COUNT(DISTINCT production_episode_id)
    - name: "Total Actual Cost Usd"
      expr: SUM(actual_cost_usd)
    - name: "Average Actual Cost Usd"
      expr: AVG(actual_cost_usd)
    - name: "Total Approved Budget Usd"
      expr: SUM(approved_budget_usd)
    - name: "Average Approved Budget Usd"
      expr: AVG(approved_budget_usd)
    - name: "Total Source Code"
      expr: SUM(source_code)
    - name: "Average Source Code"
      expr: AVG(source_code)
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`production_project`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Project business metrics"
  source: "`vibe_media_broadcasting_v1`.`production`.`project`"
  dimensions:
    - name: "Actual Delivery Date"
      expr: actual_delivery_date
    - name: "Co Production Flag"
      expr: co_production_flag
    - name: "Content Genre"
      expr: content_genre
    - name: "Content Rating"
      expr: content_rating
    - name: "Coppa Applicable"
      expr: coppa_applicable
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Dalet Workflow Reference"
      expr: dalet_workflow_reference
    - name: "Drm Required"
      expr: drm_required
    - name: "Eidr"
      expr: eidr
    - name: "Episode Count"
      expr: episode_count
    - name: "Fcc License Required"
      expr: fcc_license_required
    - name: "Greenlight Date"
      expr: greenlight_date
    - name: "Greenlight Status"
      expr: greenlight_status
    - name: "Isan"
      expr: isan
    - name: "Original Ip Flag"
      expr: original_ip_flag
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Project"
      expr: COUNT(DISTINCT project_id)
    - name: "Total Actual Spend Usd"
      expr: SUM(actual_spend_usd)
    - name: "Average Actual Spend Usd"
      expr: AVG(actual_spend_usd)
    - name: "Total Approved Budget Usd"
      expr: SUM(approved_budget_usd)
    - name: "Average Approved Budget Usd"
      expr: AVG(approved_budget_usd)
    - name: "Total Source Code"
      expr: SUM(source_code)
    - name: "Average Source Code"
      expr: AVG(source_code)
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`production_qc_review`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Qc Review business metrics"
  source: "`vibe_media_broadcasting_v1`.`production`.`qc_review`"
  dimensions:
    - name: "Audio Channel Configuration"
      expr: audio_channel_configuration
    - name: "Audio Codec"
      expr: audio_codec
    - name: "Audio Description Compliance Flag"
      expr: audio_description_compliance_flag
    - name: "Closed Caption Compliance Flag"
      expr: closed_caption_compliance_flag
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Dalet Workflow Reference"
      expr: dalet_workflow_reference
    - name: "Error Codes"
      expr: error_codes
    - name: "Final Approval Date"
      expr: final_approval_date
    - name: "Final Approval Status"
      expr: final_approval_status
    - name: "Loudness Compliance Flag"
      expr: loudness_compliance_flag
    - name: "P1 Critical Error Count"
      expr: p1_critical_error_count
    - name: "P2 Major Error Count"
      expr: p2_major_error_count
    - name: "P3 Minor Error Count"
      expr: p3_minor_error_count
    - name: "Qc Notes"
      expr: qc_notes
    - name: "Qc Platform"
      expr: qc_platform
    - name: "Qc Result"
      expr: qc_result
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Qc Review"
      expr: COUNT(DISTINCT qc_review_id)
    - name: "Total Loudness Lufs"
      expr: SUM(loudness_lufs)
    - name: "Average Loudness Lufs"
      expr: AVG(loudness_lufs)
    - name: "Total Review Duration Minutes"
      expr: SUM(review_duration_minutes)
    - name: "Average Review Duration Minutes"
      expr: AVG(review_duration_minutes)
    - name: "Total Source Code"
      expr: SUM(source_code)
    - name: "Average Source Code"
      expr: AVG(source_code)
    - name: "Total Video Frame Rate"
      expr: SUM(video_frame_rate)
    - name: "Average Video Frame Rate"
      expr: AVG(video_frame_rate)
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`production_script`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Script business metrics"
  source: "`vibe_media_broadcasting_v1`.`production`.`script`"
  dimensions:
    - name: "Approval Date"
      expr: approval_date
    - name: "Approved By"
      expr: approved_by
    - name: "Confidentiality Level"
      expr: confidentiality_level
    - name: "Copyright Holder"
      expr: copyright_holder
    - name: "Copyright Year"
      expr: copyright_year
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Dalet Document Reference"
      expr: dalet_document_reference
    - name: "Distribution Restriction"
      expr: distribution_restriction
    - name: "Draft Type"
      expr: draft_type
    - name: "Estimated Runtime Minutes"
      expr: estimated_runtime_minutes
    - name: "File Format"
      expr: file_format
    - name: "Format"
      expr: format
    - name: "Genre"
      expr: genre
    - name: "Language"
      expr: language
    - name: "Lock Date"
      expr: lock_date
    - name: "Lock Status"
      expr: lock_status
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Script"
      expr: COUNT(DISTINCT script_id)
    - name: "Total File Size Mb"
      expr: SUM(file_size_mb)
    - name: "Average File Size Mb"
      expr: AVG(file_size_mb)
    - name: "Total Source Code"
      expr: SUM(source_code)
    - name: "Average Source Code"
      expr: AVG(source_code)
$$;