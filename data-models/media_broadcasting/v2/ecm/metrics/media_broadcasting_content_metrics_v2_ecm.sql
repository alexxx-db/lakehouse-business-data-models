-- Metric views for domain: content | Business: Media_Broadcasting | Version: 2 | Generated on: 2026-06-30 04:55:25

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`content_acquisition`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Content acquisition economics: license costs, minimum guarantees and royalty rates used to steer content investment decisions."
  source: "`vibe_media_broadcasting_v1`.`content`.`acquisition`"
  dimensions:
    - name: "acquisition_status"
      expr: acquisition_status
      comment: "Lifecycle status of the acquisition deal (e.g. pending, executed, closed)."
    - name: "acquisition_type"
      expr: acquisition_type
      comment: "Type of acquisition (e.g. original, library, output deal)."
    - name: "content_window_type"
      expr: content_window_type
      comment: "Distribution window type the acquired rights apply to."
    - name: "territory_scope"
      expr: territory_scope
      comment: "Geographic territory scope of the acquired rights."
    - name: "cost_currency"
      expr: cost_currency
      comment: "Currency of the acquisition cost."
    - name: "acquisition_month"
      expr: DATE_TRUNC('MONTH', acquisition_date)
      comment: "Month the content was acquired, for trend analysis."
  measures:
    - name: "acquisition_count"
      expr: COUNT(1)
      comment: "Number of content acquisition deals."
    - name: "total_acquisition_cost"
      expr: SUM(CAST(cost_amount AS DOUBLE))
      comment: "Total acquisition spend used to track content investment outlay."
    - name: "avg_acquisition_cost"
      expr: AVG(CAST(cost_amount AS DOUBLE))
      comment: "Average cost per acquisition deal, an indicator of deal scale."
    - name: "total_minimum_guarantee"
      expr: SUM(CAST(minimum_guarantee_amount AS DOUBLE))
      comment: "Total minimum guarantee committed across acquisitions, a key cash exposure metric."
    - name: "avg_royalty_rate_pct"
      expr: AVG(CAST(royalty_rate_percent AS DOUBLE))
      comment: "Average royalty rate negotiated, informing margin on exploited content."
    - name: "exclusive_deal_count"
      expr: SUM(CASE WHEN exclusivity_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of exclusive acquisitions, a competitive-positioning indicator."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`content_billing_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Content licensing revenue lines: revenue recognized per title/territory/window for revenue steering."
  source: "`vibe_media_broadcasting_v1`.`content`.`billing_line`"
  dimensions:
    - name: "line_status"
      expr: line_status
      comment: "Status of the billing line (e.g. open, billed, settled)."
    - name: "license_window_type"
      expr: license_window_type
      comment: "License window the revenue line relates to."
    - name: "territory_code"
      expr: territory_code
      comment: "Territory associated with the billed revenue."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the billed amount."
    - name: "billing_period_month"
      expr: DATE_TRUNC('MONTH', billing_period_start_date)
      comment: "Billing period month for revenue trend analysis."
  measures:
    - name: "billing_line_count"
      expr: COUNT(1)
      comment: "Number of content billing lines."
    - name: "total_billed_amount"
      expr: SUM(CAST(line_amount AS DOUBLE))
      comment: "Total content licensing revenue billed, a core revenue KPI."
    - name: "avg_billed_amount"
      expr: AVG(CAST(line_amount AS DOUBLE))
      comment: "Average revenue per billing line."
    - name: "total_units_consumed"
      expr: SUM(CAST(units_consumed AS DOUBLE))
      comment: "Total billable units consumed, a usage/volume indicator."
    - name: "avg_revenue_share_pct"
      expr: AVG(CAST(revenue_share_percentage AS DOUBLE))
      comment: "Average revenue share percentage applied, informing partner economics."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`content_clearance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Rights clearance throughput and SLA: tracks clearance status, fees and broadcast readiness for compliance and release planning."
  source: "`vibe_media_broadcasting_v1`.`content`.`content_clearance`"
  dimensions:
    - name: "clearance_status"
      expr: clearance_status
      comment: "Current clearance status (e.g. cleared, pending, blocked)."
    - name: "clearance_type"
      expr: clearance_type
      comment: "Type of clearance being processed."
    - name: "intended_platform"
      expr: intended_platform
      comment: "Platform the clearance is intended for."
    - name: "intended_territory"
      expr: intended_territory
      comment: "Territory the clearance is intended for."
    - name: "clearance_month"
      expr: DATE_TRUNC('MONTH', clearance_date)
      comment: "Month of clearance decision for trend tracking."
  measures:
    - name: "clearance_count"
      expr: COUNT(1)
      comment: "Number of clearance requests processed."
    - name: "broadcast_ready_count"
      expr: SUM(CASE WHEN broadcast_ready_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of clearances that are broadcast-ready, indicating release-pipeline health."
    - name: "escalated_count"
      expr: SUM(CASE WHEN escalation_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of escalated clearances, flagging operational bottlenecks."
    - name: "total_clearance_fees"
      expr: SUM(CAST(fee_amount AS DOUBLE))
      comment: "Total clearance fees incurred, a content-cost driver."
    - name: "legal_review_required_count"
      expr: SUM(CASE WHEN legal_review_required_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count requiring legal review, informing legal-resource demand."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`content_episode`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Episode catalog health: accessibility coverage, rights clearance and VOD availability across the episode library."
  source: "`vibe_media_broadcasting_v1`.`content`.`content_episode`"
  dimensions:
    - name: "episode_status"
      expr: episode_status
      comment: "Lifecycle status of the episode."
    - name: "episode_type"
      expr: episode_type
      comment: "Type/classification of the episode."
    - name: "rights_clearance_status"
      expr: rights_clearance_status
      comment: "Rights clearance status of the episode."
    - name: "primary_language"
      expr: primary_language
      comment: "Primary language of the episode."
    - name: "air_date_month"
      expr: DATE_TRUNC('MONTH', original_air_date)
      comment: "Original air month for scheduling and trend analysis."
  measures:
    - name: "episode_count"
      expr: COUNT(1)
      comment: "Number of episodes in the catalog."
    - name: "closed_caption_count"
      expr: SUM(CASE WHEN closed_caption_available = TRUE THEN 1 ELSE 0 END)
      comment: "Episodes with closed captions, a key accessibility-compliance metric."
    - name: "audio_description_count"
      expr: SUM(CASE WHEN audio_description_available = TRUE THEN 1 ELSE 0 END)
      comment: "Episodes with audio description, an accessibility-compliance metric."
    - name: "premiere_count"
      expr: SUM(CASE WHEN premiere_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Premiere episodes, a programming-freshness indicator."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`content_localization`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Localization cost, quality and delivery performance for dubbing/subtitling vendor workflows."
  source: "`vibe_media_broadcasting_v1`.`content`.`localization`"
  dimensions:
    - name: "localization_status"
      expr: localization_status
      comment: "Status of the localization job."
    - name: "localization_type"
      expr: localization_type
      comment: "Type of localization (e.g. dubbing, subtitling)."
    - name: "target_language_code"
      expr: target_language_code
      comment: "Target language of the localization."
    - name: "target_territory_code"
      expr: target_territory_code
      comment: "Target territory of the localization."
    - name: "order_month"
      expr: DATE_TRUNC('MONTH', order_date)
      comment: "Order month for localization-spend trend tracking."
  measures:
    - name: "localization_count"
      expr: COUNT(1)
      comment: "Number of localization jobs."
    - name: "total_localization_cost"
      expr: SUM(CAST(cost_amount AS DOUBLE))
      comment: "Total localization spend, a key cost-management KPI."
    - name: "avg_localization_cost"
      expr: AVG(CAST(cost_amount AS DOUBLE))
      comment: "Average cost per localization job."
    - name: "qc_pass_count"
      expr: SUM(CASE WHEN qc_pass_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Localizations passing QC, a quality KPI for vendor management."
    - name: "total_duration_minutes"
      expr: SUM(CAST(duration_minutes AS DOUBLE))
      comment: "Total localized content duration, a volume/throughput measure."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`content_dubbing_session`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Dubbing session cost and QC outcomes for end-to-end localization quality and cost demos."
  source: "`vibe_media_broadcasting_v1`.`content`.`dubbing_session`"
  dimensions:
    - name: "session_status"
      expr: session_status
      comment: "Status of the dubbing session."
    - name: "dubbing_type"
      expr: dubbing_type
      comment: "Type of dubbing performed."
    - name: "qc_status"
      expr: qc_status
      comment: "QC outcome status of the session."
    - name: "target_language_code"
      expr: target_language_code
      comment: "Target language of the dubbing session."
    - name: "session_month"
      expr: DATE_TRUNC('MONTH', session_date)
      comment: "Session month for cost-trend analysis."
  measures:
    - name: "session_count"
      expr: COUNT(1)
      comment: "Number of dubbing sessions."
    - name: "total_session_cost"
      expr: SUM(CAST(session_cost_amount AS DOUBLE))
      comment: "Total dubbing session spend, a localization cost driver."
    - name: "avg_session_cost"
      expr: AVG(CAST(session_cost_amount AS DOUBLE))
      comment: "Average cost per dubbing session."
    - name: "distinct_title_count"
      expr: COUNT(DISTINCT title_id)
      comment: "Distinct titles dubbed, indicating localization breadth."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`content_compliance_finding`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Content compliance violations: fines, remediation cost and severity to manage regulatory and reputational risk."
  source: "`vibe_media_broadcasting_v1`.`content`.`compliance_finding`"
  dimensions:
    - name: "compliance_type"
      expr: compliance_type
      comment: "Type of compliance finding."
    - name: "severity_level"
      expr: severity_level
      comment: "Severity classification of the finding."
    - name: "resolution_status"
      expr: resolution_status
      comment: "Resolution status of the finding."
    - name: "regulatory_body"
      expr: regulatory_body
      comment: "Regulatory body associated with the finding."
    - name: "finding_month"
      expr: DATE_TRUNC('MONTH', finding_date)
      comment: "Month the finding was raised for risk-trend tracking."
  measures:
    - name: "finding_count"
      expr: COUNT(1)
      comment: "Number of compliance findings, a core risk indicator."
    - name: "total_fine_amount"
      expr: SUM(CAST(fine_amount AS DOUBLE))
      comment: "Total fines incurred, a direct financial-risk KPI."
    - name: "total_remediation_cost"
      expr: SUM(CAST(remediation_cost AS DOUBLE))
      comment: "Total remediation cost, informing compliance-investment decisions."
    - name: "recurrence_count"
      expr: SUM(CASE WHEN recurrence_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Recurring findings, a process-failure indicator."
    - name: "makegoods_required_count"
      expr: SUM(CASE WHEN makegoods_required_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Findings requiring makegoods, a commercial-impact measure."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`content_lifecycle_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Content lifecycle transition throughput and SLA breach tracking for operational pipeline steering."
  source: "`vibe_media_broadcasting_v1`.`content`.`lifecycle_event`"
  dimensions:
    - name: "lifecycle_stage"
      expr: lifecycle_stage
      comment: "Stage of the content lifecycle the event represents."
    - name: "new_status"
      expr: new_status
      comment: "Status the content transitioned to."
    - name: "responsible_team"
      expr: responsible_team
      comment: "Team responsible for the transition."
    - name: "delivery_platform"
      expr: delivery_platform
      comment: "Target delivery platform for the transition."
    - name: "transition_month"
      expr: DATE_TRUNC('MONTH', transition_timestamp)
      comment: "Month of the transition for throughput trends."
  measures:
    - name: "event_count"
      expr: COUNT(1)
      comment: "Number of lifecycle transition events."
    - name: "sla_breach_count"
      expr: SUM(CASE WHEN sla_breach_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Transitions that breached SLA, a key operational-quality KPI."
    - name: "avg_transition_hours"
      expr: AVG(CAST(transition_duration_hours AS DOUBLE))
      comment: "Average transition duration in hours, a pipeline-velocity metric."
    - name: "rollback_count"
      expr: SUM(CASE WHEN rollback_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Rolled-back transitions, indicating rework and process instability."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`content_ingest_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Content ingest throughput and QC outcomes for media-supply-chain operations."
  source: "`vibe_media_broadcasting_v1`.`content`.`ingest_event`"
  dimensions:
    - name: "ingest_status"
      expr: ingest_status
      comment: "Status of the ingest job."
    - name: "ingest_source_type"
      expr: ingest_source_type
      comment: "Source type of the ingested content."
    - name: "automated_qc_result"
      expr: automated_qc_result
      comment: "Automated QC result for the ingest."
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level assigned to the ingest job."
    - name: "ingest_month"
      expr: DATE_TRUNC('MONTH', ingest_timestamp)
      comment: "Month of ingest for throughput trend analysis."
  measures:
    - name: "ingest_count"
      expr: COUNT(1)
      comment: "Number of ingest events, a supply-chain volume KPI."
    - name: "total_source_size_bytes"
      expr: SUM(CAST(source_file_size_bytes AS DOUBLE))
      comment: "Total ingested data volume in bytes, a storage/capacity driver."
    - name: "avg_source_duration_seconds"
      expr: AVG(CAST(source_duration_seconds AS DOUBLE))
      comment: "Average source duration ingested, a content-length indicator."
    - name: "cc_detected_count"
      expr: SUM(CASE WHEN closed_caption_detected_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Ingests with detected closed captions, an accessibility-readiness metric."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`content_package`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Content packaging value and commercial readiness for distribution and sales planning."
  source: "`vibe_media_broadcasting_v1`.`content`.`package`"
  dimensions:
    - name: "package_status"
      expr: package_status
      comment: "Status of the content package."
    - name: "package_type"
      expr: package_type
      comment: "Type of the content package."
    - name: "territory_scope"
      expr: territory_scope
      comment: "Territory scope of the package."
    - name: "language_primary"
      expr: language_primary
      comment: "Primary language of the package."
    - name: "effective_month"
      expr: DATE_TRUNC('MONTH', effective_date)
      comment: "Effective month of the package for availability trends."
  measures:
    - name: "package_count"
      expr: COUNT(1)
      comment: "Number of content packages."
    - name: "total_package_value"
      expr: SUM(CAST(value_usd AS DOUBLE))
      comment: "Total packaged content value, a sales-pipeline KPI."
    - name: "avg_package_value"
      expr: AVG(CAST(value_usd AS DOUBLE))
      comment: "Average package value, informing pricing strategy."
    - name: "exclusive_package_count"
      expr: SUM(CASE WHEN exclusivity_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Exclusive packages, a competitive-differentiation measure."
    - name: "total_runtime_hours"
      expr: SUM(CAST(total_runtime_hours AS DOUBLE))
      comment: "Total runtime hours packaged, a content-volume indicator."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`content_title_rights_grant`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Title rights utilisation: run consumption and clearance to maximise rights exploitation and avoid over-runs."
  source: "`vibe_media_broadcasting_v1`.`content`.`title_rights_grant`"
  dimensions:
    - name: "clearance_status"
      expr: clearance_status
      comment: "Clearance status of the title rights grant."
    - name: "platform_type"
      expr: platform_type
      comment: "Platform type the grant applies to."
    - name: "window_type"
      expr: window_type
      comment: "Window type of the grant."
    - name: "exclusivity_tier"
      expr: exclusivity_tier
      comment: "Exclusivity tier of the grant."
    - name: "grant_effective_month"
      expr: DATE_TRUNC('MONTH', grant_effective_date)
      comment: "Effective month of the grant for trend analysis."
  measures:
    - name: "grant_count"
      expr: COUNT(1)
      comment: "Number of title rights grants."
    - name: "distinct_title_count"
      expr: COUNT(DISTINCT title_id)
      comment: "Distinct titles under grant, a rights-coverage breadth measure."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`content_voice_actor_assignment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Voice-actor assignment cost and dubbing quality for localization vendor performance management."
  source: "`vibe_media_broadcasting_v1`.`content`.`voice_actor_assignment`"
  dimensions:
    - name: "assignment_status"
      expr: assignment_status
      comment: "Status of the voice-actor assignment."
    - name: "role_type"
      expr: role_type
      comment: "Type of role in the dubbing assignment."
    - name: "target_language_code"
      expr: target_language_code
      comment: "Target language of the assignment."
    - name: "approval_month"
      expr: DATE_TRUNC('MONTH', approval_date)
      comment: "Approval month for cost-trend analysis."
  measures:
    - name: "assignment_count"
      expr: COUNT(1)
      comment: "Number of voice-actor assignments."
    - name: "total_compensation"
      expr: SUM(CAST(total_compensation_amount AS DOUBLE))
      comment: "Total voice-actor compensation, a localization cost driver."
    - name: "avg_quality_score"
      expr: AVG(CAST(quality_score AS DOUBLE))
      comment: "Average dubbing quality score, a vendor-quality KPI."
    - name: "avg_lip_sync_accuracy"
      expr: AVG(CAST(lip_sync_accuracy_score AS DOUBLE))
      comment: "Average lip-sync accuracy, a technical-quality KPI for dubbing."
    - name: "approved_count"
      expr: SUM(CASE WHEN approved_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Approved assignments, indicating throughput of acceptable work."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`content_provenance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "AI/C2PA content provenance for 2026 disclosure compliance (EU AI Act, FCC AI ad disclosure)."
  source: "`vibe_media_broadcasting_v1`.`content`.`content_provenance`"
  dimensions:
    - name: "verification_status"
      expr: verification_status
      comment: "Provenance verification status."
    - name: "synthetic_media_type"
      expr: synthetic_media_type
      comment: "Type of synthetic/AI-generated media."
    - name: "eu_ai_act_risk_category"
      expr: eu_ai_act_risk_category
      comment: "EU AI Act risk category of the content."
    - name: "ai_tool_vendor"
      expr: ai_tool_vendor
      comment: "Vendor of the AI tool used."
  measures:
    - name: "provenance_record_count"
      expr: COUNT(1)
      comment: "Number of provenance records tracked."
    - name: "ai_generated_count"
      expr: SUM(CASE WHEN ai_generated_flag = TRUE THEN 1 ELSE 0 END)
      comment: "AI-generated content count, a compliance-disclosure KPI."
    - name: "fcc_disclosure_required_count"
      expr: SUM(CASE WHEN fcc_ai_disclosure_required_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Content requiring FCC AI disclosure, a regulatory-exposure metric."
    - name: "watermark_embedded_count"
      expr: SUM(CASE WHEN watermark_embedded_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Content with embedded watermark, a content-integrity measure."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`content_episode_transmission`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Episode transmission quality and reach: signal quality, blackout/preemption and audience for broadcast operations."
  source: "`vibe_media_broadcasting_v1`.`content`.`episode_transmission`"
  dimensions:
    - name: "transmission_status"
      expr: transmission_status
      comment: "Status of the transmission."
    - name: "transmission_type"
      expr: transmission_type
      comment: "Type of transmission."
    - name: "market_code"
      expr: market_code
      comment: "Market the transmission served."
    - name: "broadcast_network"
      expr: broadcast_network
      comment: "Broadcast network of the transmission."
    - name: "air_date_month"
      expr: DATE_TRUNC('MONTH', air_date)
      comment: "Air month for transmission trend analysis."
  measures:
    - name: "transmission_count"
      expr: COUNT(1)
      comment: "Number of episode transmissions."
    - name: "total_viewer_count"
      expr: SUM(CAST(viewer_count AS DOUBLE))
      comment: "Total viewers reached, a core audience-reach KPI."
    - name: "avg_audience_estimate"
      expr: AVG(CAST(audience_estimate AS DOUBLE))
      comment: "Average estimated audience per transmission."
    - name: "preemption_count"
      expr: SUM(CASE WHEN preemption_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Preempted transmissions, a programming-disruption metric."
    - name: "technical_issue_count"
      expr: SUM(CASE WHEN technical_issues_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Transmissions with technical issues, a broadcast-quality KPI."
    - name: "avg_signal_strength_dbm"
      expr: AVG(CAST(signal_strength_dbm AS DOUBLE))
      comment: "Average signal strength, a transmission-quality indicator."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`content_genre_buy_agreement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Genre-based advertising buy commitments and premiums for content-monetisation steering."
  source: "`vibe_media_broadcasting_v1`.`content`.`genre_buy_agreement`"
  dimensions:
    - name: "agreement_status"
      expr: agreement_status
      comment: "Status of the genre buy agreement."
    - name: "contract_start_month"
      expr: DATE_TRUNC('MONTH', contract_start_date)
      comment: "Contract start month for commitment trends."
  measures:
    - name: "agreement_count"
      expr: COUNT(1)
      comment: "Number of genre buy agreements."
    - name: "total_minimum_spend"
      expr: SUM(CAST(minimum_spend_commitment AS DOUBLE))
      comment: "Total committed ad spend, a content-monetisation KPI."
    - name: "avg_cpm_premium_pct"
      expr: AVG(CAST(genre_cpm_premium_percent AS DOUBLE))
      comment: "Average genre CPM premium, informing genre-pricing power."
    - name: "exclusive_category_count"
      expr: SUM(CASE WHEN category_exclusivity_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Agreements with category exclusivity, a premium-deal indicator."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`content_windowing_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Windowing plan financial KPIs to monitor pricing and guarantee commitments"
  source: "`vibe_media_broadcasting_v1`.`content`.`windowing_plan`"
  dimensions:
    - name: "window_type"
      expr: window_type
      comment: "Type of windowing plan"
    - name: "window_status"
      expr: window_status
      comment: "Current status of the windowing plan"
    - name: "territory_code"
      expr: territory_code
      comment: "Territory code for the window"
    - name: "window_month"
      expr: DATE_TRUNC('month', created_timestamp)
      comment: "Month of windowing plan creation"
  measures:
    - name: "total_price_point"
      expr: SUM(CAST(price_point AS DOUBLE))
      comment: "Sum of price points across windowing plans"
    - name: "average_price_point"
      expr: AVG(CAST(price_point AS DOUBLE))
      comment: "Average price point"
    - name: "total_minimum_guarantee_amount"
      expr: SUM(CAST(minimum_guarantee_amount AS DOUBLE))
      comment: "Total minimum guarantee amount"
    - name: "windowing_plan_count"
      expr: COUNT(1)
      comment: "Number of windowing plan records"
$$;