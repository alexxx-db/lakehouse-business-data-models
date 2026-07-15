-- Metric views for domain: talent | Business: Media_Broadcasting | Version: 3 | Generated on: 2026-07-10 21:10:12

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`talent_contract`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core talent contract metrics tracking deal value, option exercise rates, and contract lifecycle performance for production and engagement agreements."
  source: "`vibe_media_broadcasting_v1`.`talent`.`contract`"
  dimensions:
    - name: "contract_type"
      expr: contract_type
      comment: "Type of talent contract (e.g., series regular, guest star, producer deal)"
    - name: "contract_status"
      expr: contract_status
      comment: "Current status of the contract (active, expired, terminated, option pending)"
    - name: "guild_affiliation"
      expr: guild_affiliation
      comment: "Guild or union affiliation governing the contract (SAG-AFTRA, DGA, WGA, etc.)"
    - name: "engagement_role"
      expr: engagement_role
      comment: "Primary role or position for this engagement"
    - name: "backend_participation_type"
      expr: backend_participation_type
      comment: "Type of backend participation (gross, net, adjusted gross)"
    - name: "exclusivity_flag"
      expr: exclusivity_flag
      comment: "Whether the contract includes exclusivity provisions"
    - name: "pay_or_play_flag"
      expr: pay_or_play_flag
      comment: "Whether the contract is pay-or-play (guaranteed compensation regardless of production)"
    - name: "residual_eligibility_flag"
      expr: residual_eligibility_flag
      comment: "Whether the talent is eligible for residual payments under this contract"
    - name: "option_exercise_status"
      expr: option_exercise_status
      comment: "Status of option exercise (exercised, pending, declined, expired)"
    - name: "contract_year"
      expr: YEAR(effective_start_date)
      comment: "Year the contract became effective"
    - name: "contract_month"
      expr: DATE_TRUNC('MONTH', effective_start_date)
      comment: "Month the contract became effective"
  measures:
    - name: "total_contract_count"
      expr: COUNT(1)
      comment: "Total number of talent contracts"
    - name: "total_base_compensation"
      expr: SUM(CAST(base_compensation_amount AS DOUBLE))
      comment: "Total base compensation amount across all contracts"
    - name: "avg_base_compensation"
      expr: AVG(CAST(base_compensation_amount AS DOUBLE))
      comment: "Average base compensation per contract"
    - name: "total_backend_participation_value"
      expr: SUM(CAST(backend_participation_percentage AS DOUBLE))
      comment: "Sum of backend participation percentages across contracts (for portfolio analysis)"
    - name: "avg_backend_participation_pct"
      expr: AVG(CAST(backend_participation_percentage AS DOUBLE))
      comment: "Average backend participation percentage across contracts"
    - name: "total_step_up_value"
      expr: SUM(CAST(step_up_amount AS DOUBLE))
      comment: "Total step-up compensation value across all contracts"
    - name: "avg_credit_size_pct"
      expr: AVG(CAST(credit_size_percentage AS DOUBLE))
      comment: "Average credit size percentage negotiated in contracts"
    - name: "distinct_talent_count"
      expr: COUNT(DISTINCT talent_profile_id)
      comment: "Number of unique talent profiles under contract"
    - name: "distinct_production_count"
      expr: COUNT(DISTINCT project_id)
      comment: "Number of unique production projects with talent contracts"
    - name: "pay_or_play_contract_count"
      expr: SUM(CASE WHEN pay_or_play_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of pay-or-play contracts (guaranteed compensation)"
    - name: "exclusivity_contract_count"
      expr: SUM(CASE WHEN exclusivity_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of contracts with exclusivity clauses"
    - name: "residual_eligible_contract_count"
      expr: SUM(CASE WHEN residual_eligibility_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of contracts eligible for residual payments"
    - name: "option_exercised_count"
      expr: SUM(CASE WHEN option_exercise_status = 'exercised' THEN 1 ELSE 0 END)
      comment: "Number of contracts where options have been exercised"
    - name: "terminated_contract_count"
      expr: SUM(CASE WHEN contract_status = 'terminated' THEN 1 ELSE 0 END)
      comment: "Number of terminated contracts"
$$;


CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`talent_residual_payment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Residual payment metrics tracking royalty flows, agent commissions, withholding, and payment velocity for talent compensation in secondary markets and reruns."
  source: "`vibe_media_broadcasting_v1`.`talent`.`residual_payment`"
  dimensions:
    - name: "payment_status"
      expr: payment_status
      comment: "Status of the residual payment (pending, paid, disputed, cancelled)"
    - name: "payment_method"
      expr: payment_method
      comment: "Method of payment (ACH, wire, check)"
    - name: "use_type"
      expr: use_type
      comment: "Type of content use triggering the residual (rerun, streaming, syndication, foreign)"
    - name: "payment_currency_code"
      expr: payment_currency_code
      comment: "Currency code for the residual payment"
    - name: "audit_report_flag"
      expr: audit_report_flag
      comment: "Whether this payment was subject to audit reporting"
    - name: "remittance_advice_sent_flag"
      expr: remittance_advice_sent_flag
      comment: "Whether remittance advice was sent to talent"
    - name: "payment_year"
      expr: YEAR(payment_date)
      comment: "Year the residual payment was made"
    - name: "payment_month"
      expr: DATE_TRUNC('MONTH', payment_date)
      comment: "Month the residual payment was made"
    - name: "payment_quarter"
      expr: DATE_TRUNC('QUARTER', payment_date)
      comment: "Quarter the residual payment was made"
  measures:
    - name: "total_residual_payment_count"
      expr: COUNT(1)
      comment: "Total number of residual payment transactions"
    - name: "total_gross_residual_amount"
      expr: SUM(CAST(gross_residual_amount AS DOUBLE))
      comment: "Total gross residual amount before deductions"
    - name: "total_net_payment_amount"
      expr: SUM(CAST(net_payment_amount AS DOUBLE))
      comment: "Total net residual payment amount after all deductions"
    - name: "total_agent_commission"
      expr: SUM(CAST(agent_commission_amount AS DOUBLE))
      comment: "Total agent commission deducted from residual payments"
    - name: "total_pension_health_contribution"
      expr: SUM(CAST(pension_health_amount AS DOUBLE))
      comment: "Total pension and health contributions deducted from residuals"
    - name: "total_withholding_tax"
      expr: SUM(CAST(withholding_tax_amount AS DOUBLE))
      comment: "Total withholding tax deducted from residual payments"
    - name: "avg_gross_residual_amount"
      expr: AVG(CAST(gross_residual_amount AS DOUBLE))
      comment: "Average gross residual amount per payment"
    - name: "avg_net_payment_amount"
      expr: AVG(CAST(net_payment_amount AS DOUBLE))
      comment: "Average net residual payment per transaction"
    - name: "distinct_talent_paid_count"
      expr: COUNT(DISTINCT talent_profile_id)
      comment: "Number of unique talent profiles receiving residual payments"
    - name: "distinct_title_count"
      expr: COUNT(DISTINCT title_id)
      comment: "Number of unique titles generating residual payments"
    - name: "distinct_contract_count"
      expr: COUNT(DISTINCT contract_id)
      comment: "Number of unique contracts generating residual payments"
    - name: "paid_residual_count"
      expr: SUM(CASE WHEN payment_status = 'paid' THEN 1 ELSE 0 END)
      comment: "Number of residual payments successfully completed"
    - name: "audited_payment_count"
      expr: SUM(CASE WHEN audit_report_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of residual payments subject to audit"
$$;


CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`talent_appearance_schedule`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Talent appearance scheduling metrics tracking booking efficiency, cancellation rates, duration variance, and guild compliance for on-air and production appearances."
  source: "`vibe_media_broadcasting_v1`.`talent`.`appearance_schedule`"
  dimensions:
    - name: "appearance_type"
      expr: appearance_type
      comment: "Type of talent appearance (on-air, voice-over, promotional, production)"
    - name: "confirmation_status"
      expr: confirmation_status
      comment: "Confirmation status of the appearance (confirmed, tentative, cancelled, completed)"
    - name: "hold_level"
      expr: hold_level
      comment: "Hold level for the appearance booking (first hold, second hold, confirmed)"
    - name: "cancellation_reason"
      expr: cancellation_reason
      comment: "Reason for appearance cancellation if applicable"
    - name: "exclusivity_conflict_flag"
      expr: exclusivity_conflict_flag
      comment: "Whether the appearance has an exclusivity conflict"
    - name: "guild_notification_required"
      expr: guild_notification_required
      comment: "Whether guild notification is required for this appearance"
    - name: "playout_system_sync_status"
      expr: playout_system_sync_status
      comment: "Sync status with playout/broadcast systems"
    - name: "release_tracking_status"
      expr: release_tracking_status
      comment: "Status of release tracking for the appearance"
    - name: "daypart"
      expr: daypart
      comment: "Daypart of the scheduled appearance (morning, daytime, primetime, late night)"
    - name: "call_year"
      expr: YEAR(call_date)
      comment: "Year of the talent call date"
    - name: "call_month"
      expr: DATE_TRUNC('MONTH', call_date)
      comment: "Month of the talent call date"
  measures:
    - name: "total_appearance_count"
      expr: COUNT(1)
      comment: "Total number of talent appearance bookings"
    - name: "total_estimated_duration_hours"
      expr: SUM(CAST(estimated_duration_hours AS DOUBLE))
      comment: "Total estimated duration hours for all appearances"
    - name: "total_actual_duration_hours"
      expr: SUM(CAST(actual_duration_hours AS DOUBLE))
      comment: "Total actual duration hours for completed appearances"
    - name: "avg_estimated_duration_hours"
      expr: AVG(CAST(estimated_duration_hours AS DOUBLE))
      comment: "Average estimated duration per appearance in hours"
    - name: "avg_actual_duration_hours"
      expr: AVG(CAST(actual_duration_hours AS DOUBLE))
      comment: "Average actual duration per appearance in hours"
    - name: "distinct_talent_count"
      expr: COUNT(DISTINCT talent_profile_id)
      comment: "Number of unique talent profiles scheduled for appearances"
    - name: "distinct_channel_count"
      expr: COUNT(DISTINCT channel_id)
      comment: "Number of unique channels with talent appearances"
    - name: "distinct_title_count"
      expr: COUNT(DISTINCT title_id)
      comment: "Number of unique titles with talent appearances"
    - name: "confirmed_appearance_count"
      expr: SUM(CASE WHEN confirmation_status = 'confirmed' THEN 1 ELSE 0 END)
      comment: "Number of confirmed talent appearances"
    - name: "cancelled_appearance_count"
      expr: SUM(CASE WHEN confirmation_status = 'cancelled' THEN 1 ELSE 0 END)
      comment: "Number of cancelled talent appearances"
    - name: "completed_appearance_count"
      expr: SUM(CASE WHEN confirmation_status = 'completed' THEN 1 ELSE 0 END)
      comment: "Number of completed talent appearances"
    - name: "exclusivity_conflict_count"
      expr: SUM(CASE WHEN exclusivity_conflict_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of appearances with exclusivity conflicts"
    - name: "guild_notification_required_count"
      expr: SUM(CASE WHEN guild_notification_required = TRUE THEN 1 ELSE 0 END)
      comment: "Number of appearances requiring guild notification"
$$;


CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`talent_compensation_structure`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Talent compensation structure metrics tracking base rates, residual eligibility, backend participation, and step-up triggers for guild-compliant compensation models."
  source: "`vibe_media_broadcasting_v1`.`talent`.`compensation_structure`"
  dimensions:
    - name: "compensation_type"
      expr: compensation_type
      comment: "Type of compensation structure (episodic, weekly, daily, project-based)"
    - name: "structure_status"
      expr: structure_status
      comment: "Status of the compensation structure (active, expired, superseded)"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency code for compensation amounts"
    - name: "residual_eligibility_flag"
      expr: residual_eligibility_flag
      comment: "Whether this compensation structure includes residual eligibility"
    - name: "exclusivity_clause_flag"
      expr: exclusivity_clause_flag
      comment: "Whether this compensation structure includes exclusivity provisions"
    - name: "pay_or_play_flag"
      expr: pay_or_play_flag
      comment: "Whether this is a pay-or-play compensation structure"
    - name: "usage_rights_scope"
      expr: usage_rights_scope
      comment: "Scope of usage rights covered by this compensation (all media, theatrical, streaming, etc.)"
    - name: "structure_year"
      expr: YEAR(effective_start_date)
      comment: "Year the compensation structure became effective"
  measures:
    - name: "total_compensation_structure_count"
      expr: COUNT(1)
      comment: "Total number of compensation structures"
    - name: "total_base_episode_fee"
      expr: SUM(CAST(base_episode_fee AS DOUBLE))
      comment: "Total base episode fees across all compensation structures"
    - name: "avg_base_episode_fee"
      expr: AVG(CAST(base_episode_fee AS DOUBLE))
      comment: "Average base episode fee per compensation structure"
    - name: "total_daily_rate"
      expr: SUM(CAST(daily_rate AS DOUBLE))
      comment: "Total daily rates across all compensation structures"
    - name: "avg_daily_rate"
      expr: AVG(CAST(daily_rate AS DOUBLE))
      comment: "Average daily rate per compensation structure"
    - name: "total_weekly_guarantee"
      expr: SUM(CAST(weekly_guarantee AS DOUBLE))
      comment: "Total weekly guarantee amounts across all structures"
    - name: "avg_weekly_guarantee"
      expr: AVG(CAST(weekly_guarantee AS DOUBLE))
      comment: "Average weekly guarantee per compensation structure"
    - name: "total_bonus_amount"
      expr: SUM(CAST(bonus_amount AS DOUBLE))
      comment: "Total bonus amounts across all compensation structures"
    - name: "total_step_up_amount"
      expr: SUM(CAST(step_up_amount AS DOUBLE))
      comment: "Total step-up amounts across all compensation structures"
    - name: "total_deferred_compensation"
      expr: SUM(CAST(deferred_compensation_amount AS DOUBLE))
      comment: "Total deferred compensation amounts across all structures"
    - name: "avg_backend_gross_participation_pct"
      expr: AVG(CAST(backend_gross_participation_pct AS DOUBLE))
      comment: "Average backend gross participation percentage"
    - name: "avg_pension_health_rate"
      expr: AVG(CAST(pension_health_rate AS DOUBLE))
      comment: "Average pension and health contribution rate"
    - name: "avg_overtime_multiplier"
      expr: AVG(CAST(overtime_multiplier AS DOUBLE))
      comment: "Average overtime multiplier across compensation structures"
    - name: "residual_eligible_structure_count"
      expr: SUM(CASE WHEN residual_eligibility_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of compensation structures with residual eligibility"
    - name: "pay_or_play_structure_count"
      expr: SUM(CASE WHEN pay_or_play_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of pay-or-play compensation structures"
    - name: "distinct_contract_count"
      expr: COUNT(DISTINCT contract_id)
      comment: "Number of unique contracts with defined compensation structures"
$$;


CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`talent_profile`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Talent profile metrics tracking workforce composition, clearance status, union coverage, and regulatory compliance for talent roster management."
  source: "`vibe_media_broadcasting_v1`.`talent`.`talent_profile`"
  dimensions:
    - name: "talent_type"
      expr: talent_type
      comment: "Type of talent (actor, director, writer, producer, crew, host)"
    - name: "talent_tier"
      expr: talent_tier
      comment: "Tier classification of talent (A-list, B-list, emerging, supporting)"
    - name: "profile_status"
      expr: profile_status
      comment: "Status of the talent profile (active, inactive, suspended, archived)"
    - name: "clearance_status"
      expr: clearance_status
      comment: "Clearance status for the talent (cleared, pending, expired, denied)"
    - name: "union_affiliation"
      expr: union_affiliation
      comment: "Union or guild affiliation of the talent"
    - name: "work_authorization_status"
      expr: work_authorization_status
      comment: "Work authorization status (authorized, visa required, pending, expired)"
    - name: "gender_identity"
      expr: gender_identity
      comment: "Gender identity of the talent"
    - name: "nationality"
      expr: nationality
      comment: "Nationality of the talent"
    - name: "primary_language"
      expr: primary_language
      comment: "Primary language of the talent"
    - name: "exclusivity_clause_flag"
      expr: exclusivity_clause_flag
      comment: "Whether the talent has active exclusivity clauses"
    - name: "residual_eligibility_flag"
      expr: residual_eligibility_flag
      comment: "Whether the talent is eligible for residual payments"
    - name: "insurance_coverage_flag"
      expr: insurance_coverage_flag
      comment: "Whether the talent has active insurance coverage"
    - name: "gdpr_consent_status"
      expr: gdpr_consent_status
      comment: "GDPR consent status for the talent profile"
    - name: "ccpa_opt_out_flag"
      expr: ccpa_opt_out_flag
      comment: "Whether the talent has opted out under CCPA"
    - name: "biometric_consent_flag"
      expr: biometric_consent_flag
      comment: "Whether the talent has consented to biometric data use"
  measures:
    - name: "total_talent_profile_count"
      expr: COUNT(1)
      comment: "Total number of talent profiles in the system"
    - name: "active_talent_count"
      expr: SUM(CASE WHEN profile_status = 'active' THEN 1 ELSE 0 END)
      comment: "Number of active talent profiles"
    - name: "cleared_talent_count"
      expr: SUM(CASE WHEN clearance_status = 'cleared' THEN 1 ELSE 0 END)
      comment: "Number of talent profiles with current clearance"
    - name: "clearance_expired_count"
      expr: SUM(CASE WHEN clearance_status = 'expired' THEN 1 ELSE 0 END)
      comment: "Number of talent profiles with expired clearance"
    - name: "union_affiliated_count"
      expr: SUM(CASE WHEN union_affiliation IS NOT NULL THEN 1 ELSE 0 END)
      comment: "Number of talent profiles with union affiliation"
    - name: "work_authorized_count"
      expr: SUM(CASE WHEN work_authorization_status = 'authorized' THEN 1 ELSE 0 END)
      comment: "Number of talent profiles with valid work authorization"
    - name: "exclusivity_clause_count"
      expr: SUM(CASE WHEN exclusivity_clause_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of talent profiles with active exclusivity clauses"
    - name: "residual_eligible_talent_count"
      expr: SUM(CASE WHEN residual_eligibility_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of talent profiles eligible for residual payments"
    - name: "insured_talent_count"
      expr: SUM(CASE WHEN insurance_coverage_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of talent profiles with active insurance coverage"
    - name: "gdpr_consented_count"
      expr: SUM(CASE WHEN gdpr_consent_status = 'consented' THEN 1 ELSE 0 END)
      comment: "Number of talent profiles with GDPR consent"
    - name: "ccpa_opt_out_count"
      expr: SUM(CASE WHEN ccpa_opt_out_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of talent profiles opted out under CCPA"
    - name: "biometric_consent_count"
      expr: SUM(CASE WHEN biometric_consent_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of talent profiles with biometric consent"
    - name: "distinct_agency_count"
      expr: COUNT(DISTINCT talent_agency_id)
      comment: "Number of unique talent agencies representing talent in the system"
$$;


CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`talent_role`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Talent role metrics tracking character assignments, screen time, compensation per role, and usage rights for production and campaign engagements."
  source: "`vibe_media_broadcasting_v1`.`talent`.`role`"
  dimensions:
    - name: "category"
      expr: category
      comment: "Category of the role (lead, supporting, guest, background, stunt)"
    - name: "role_status"
      expr: role_status
      comment: "Status of the role (active, completed, cancelled, on hold)"
    - name: "credit_type"
      expr: credit_type
      comment: "Type of credit for the role (starring, guest starring, co-starring, featuring)"
    - name: "compensation_type"
      expr: compensation_type
      comment: "Type of compensation for the role (episodic, weekly, daily, flat fee)"
    - name: "guild_affiliation"
      expr: guild_affiliation
      comment: "Guild affiliation governing the role"
    - name: "above_the_line_flag"
      expr: above_the_line_flag
      comment: "Whether the role is above-the-line (principal talent)"
    - name: "exclusivity_flag"
      expr: exclusivity_flag
      comment: "Whether the role includes exclusivity provisions"
    - name: "residual_eligible_flag"
      expr: residual_eligible_flag
      comment: "Whether the role is eligible for residual payments"
    - name: "stunt_double_flag"
      expr: stunt_double_flag
      comment: "Whether the role is a stunt double"
    - name: "voice_only_flag"
      expr: voice_only_flag
      comment: "Whether the role is voice-only (no on-screen appearance)"
    - name: "usage_rights_media"
      expr: usage_rights_media
      comment: "Media usage rights for the role (all media, theatrical, streaming, broadcast)"
    - name: "usage_rights_territory"
      expr: usage_rights_territory
      comment: "Territory usage rights for the role (worldwide, domestic, specific regions)"
    - name: "role_start_year"
      expr: YEAR(start_date)
      comment: "Year the role engagement started"
  measures:
    - name: "total_role_count"
      expr: COUNT(1)
      comment: "Total number of talent roles"
    - name: "total_compensation_amount"
      expr: SUM(CAST(compensation_amount AS DOUBLE))
      comment: "Total compensation amount across all roles"
    - name: "avg_compensation_amount"
      expr: AVG(CAST(compensation_amount AS DOUBLE))
      comment: "Average compensation per role"
    - name: "total_screen_time_minutes"
      expr: SUM(CAST(screen_time_minutes AS DOUBLE))
      comment: "Total screen time in minutes across all roles"
    - name: "avg_screen_time_minutes"
      expr: AVG(CAST(screen_time_minutes AS DOUBLE))
      comment: "Average screen time per role in minutes"
    - name: "distinct_talent_count"
      expr: COUNT(DISTINCT talent_profile_id)
      comment: "Number of unique talent profiles assigned to roles"
    - name: "distinct_episode_count"
      expr: COUNT(DISTINCT content_episode_id)
      comment: "Number of unique episodes with talent roles"
    - name: "distinct_contract_count"
      expr: COUNT(DISTINCT contract_id)
      comment: "Number of unique contracts associated with roles"
    - name: "above_the_line_role_count"
      expr: SUM(CASE WHEN above_the_line_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of above-the-line (principal) roles"
    - name: "residual_eligible_role_count"
      expr: SUM(CASE WHEN residual_eligible_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of roles eligible for residual payments"
    - name: "exclusivity_role_count"
      expr: SUM(CASE WHEN exclusivity_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of roles with exclusivity provisions"
    - name: "stunt_double_role_count"
      expr: SUM(CASE WHEN stunt_double_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of stunt double roles"
    - name: "voice_only_role_count"
      expr: SUM(CASE WHEN voice_only_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of voice-only roles"
    - name: "completed_role_count"
      expr: SUM(CASE WHEN role_status = 'completed' THEN 1 ELSE 0 END)
      comment: "Number of completed roles"
$$;
