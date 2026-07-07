-- Metric views for domain: talent | Business: Media_Broadcasting | Version: 2 | Generated on: 2026-06-30 06:47:57

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`talent_contract`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core talent contract KPIs including compensation, participation, and contract lifecycle metrics for strategic talent management and financial planning."
  source: "`vibe_media_broadcasting_v1`.`talent`.`contract`"
  dimensions:
    - name: "contract_status"
      expr: contract_status
      comment: "Current status of the talent contract (active, expired, terminated, etc.)"
    - name: "contract_type"
      expr: contract_type
      comment: "Type of contract (series regular, guest star, producer, director, etc.)"
    - name: "engagement_role"
      expr: engagement_role
      comment: "Role or function the talent is engaged for under this contract"
    - name: "guild_affiliation"
      expr: guild_affiliation
      comment: "Guild or union affiliation (SAG-AFTRA, DGA, WGA, etc.)"
    - name: "backend_participation_type"
      expr: backend_participation_type
      comment: "Type of backend participation (gross, adjusted gross, net)"
    - name: "contract_year"
      expr: YEAR(effective_start_date)
      comment: "Year the contract became effective"
    - name: "contract_month"
      expr: DATE_TRUNC('MONTH', effective_start_date)
      comment: "Month the contract became effective"
    - name: "exclusivity_flag"
      expr: exclusivity_flag
      comment: "Whether the contract includes exclusivity provisions"
    - name: "pay_or_play_flag"
      expr: pay_or_play_flag
      comment: "Whether the contract is pay-or-play (guaranteed compensation)"
    - name: "residual_eligibility_flag"
      expr: residual_eligibility_flag
      comment: "Whether the talent is eligible for residual payments under this contract"
  measures:
    - name: "total_base_compensation"
      expr: SUM(CAST(base_compensation_amount AS DOUBLE))
      comment: "Total base compensation amount across all contracts, critical for talent budget planning and cost management"
    - name: "avg_base_compensation"
      expr: AVG(CAST(base_compensation_amount AS DOUBLE))
      comment: "Average base compensation per contract, used for benchmarking and market rate analysis"
    - name: "total_step_up_value"
      expr: SUM(CAST(step_up_amount AS DOUBLE))
      comment: "Total step-up compensation across contracts, indicating potential cost escalation"
    - name: "avg_backend_participation_pct"
      expr: AVG(CAST(backend_participation_percentage AS DOUBLE))
      comment: "Average backend participation percentage, key for profit-sharing exposure analysis"
    - name: "avg_credit_size_pct"
      expr: AVG(CAST(credit_size_percentage AS DOUBLE))
      comment: "Average credit size percentage, relevant for marketing and talent relations"
    - name: "contract_count"
      expr: COUNT(DISTINCT contract_id)
      comment: "Number of distinct talent contracts, used for portfolio size and complexity tracking"
    - name: "active_contract_count"
      expr: COUNT(DISTINCT CASE WHEN contract_status = 'Active' THEN contract_id END)
      comment: "Number of currently active contracts, critical for operational capacity and cost forecasting"
    - name: "pay_or_play_contract_count"
      expr: COUNT(DISTINCT CASE WHEN pay_or_play_flag = TRUE THEN contract_id END)
      comment: "Number of pay-or-play contracts, indicating guaranteed cost exposure and financial risk"
    - name: "backend_participation_contract_count"
      expr: COUNT(DISTINCT CASE WHEN backend_participation_percentage > 0 THEN contract_id END)
      comment: "Number of contracts with backend participation, indicating profit-sharing obligations"
    - name: "exclusivity_contract_count"
      expr: COUNT(DISTINCT CASE WHEN exclusivity_flag = TRUE THEN contract_id END)
      comment: "Number of contracts with exclusivity clauses, relevant for talent availability and competitive positioning"
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`talent_residual_payment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Residual payment KPIs tracking guild-mandated and contractual residual obligations, critical for cost forecasting and compliance."
  source: "`vibe_media_broadcasting_v1`.`talent`.`residual_payment`"
  dimensions:
    - name: "payment_status"
      expr: payment_status
      comment: "Status of the residual payment (pending, paid, disputed, etc.)"
    - name: "payment_method"
      expr: payment_method
      comment: "Method of payment (check, ACH, wire, etc.)"
    - name: "guild_affiliation"
      expr: guild_affiliation
      comment: "Guild or union affiliation for this residual payment"
    - name: "use_type"
      expr: use_type
      comment: "Type of media use triggering the residual (broadcast, streaming, home video, etc.)"
    - name: "distribution_window"
      expr: distribution_window
      comment: "Distribution window for the residual (initial, first rerun, foreign, etc.)"
    - name: "payment_year"
      expr: YEAR(payment_date)
      comment: "Year the residual payment was made"
    - name: "payment_quarter"
      expr: DATE_TRUNC('QUARTER', payment_date)
      comment: "Quarter the residual payment was made"
    - name: "payment_month"
      expr: DATE_TRUNC('MONTH', payment_date)
      comment: "Month the residual payment was made"
    - name: "audit_report_flag"
      expr: audit_report_flag
      comment: "Whether this payment was subject to audit reporting"
    - name: "remittance_advice_sent_flag"
      expr: remittance_advice_sent_flag
      comment: "Whether remittance advice was sent to the talent"
  measures:
    - name: "total_gross_residual_amount"
      expr: SUM(CAST(gross_residual_amount AS DOUBLE))
      comment: "Total gross residual payments before deductions, primary metric for residual cost exposure"
    - name: "total_net_payment_amount"
      expr: SUM(CAST(net_payment_amount AS DOUBLE))
      comment: "Total net residual payments after all deductions, actual cash outflow for residuals"
    - name: "total_agent_commission"
      expr: SUM(CAST(agent_commission_amount AS DOUBLE))
      comment: "Total agent commissions paid on residuals, relevant for cost allocation and agency relationship management"
    - name: "total_pension_health_amount"
      expr: SUM(CAST(pension_health_amount AS DOUBLE))
      comment: "Total pension and health contributions on residuals, mandatory guild obligation"
    - name: "total_withholding_tax"
      expr: SUM(CAST(withholding_tax_amount AS DOUBLE))
      comment: "Total withholding tax on residual payments, critical for tax compliance and reporting"
    - name: "avg_gross_residual_amount"
      expr: AVG(CAST(gross_residual_amount AS DOUBLE))
      comment: "Average gross residual payment per transaction, used for payment pattern analysis"
    - name: "avg_net_payment_amount"
      expr: AVG(CAST(net_payment_amount AS DOUBLE))
      comment: "Average net residual payment per transaction, used for cash flow forecasting"
    - name: "residual_payment_count"
      expr: COUNT(DISTINCT residual_payment_id)
      comment: "Number of residual payment transactions, indicating volume and administrative burden"
    - name: "unique_talent_paid"
      expr: COUNT(DISTINCT talent_profile_id)
      comment: "Number of unique talent profiles receiving residual payments, indicating breadth of residual obligations"
    - name: "unique_contracts_paid"
      expr: COUNT(DISTINCT contract_id)
      comment: "Number of unique contracts generating residual payments, used for contract portfolio analysis"
    - name: "audit_flagged_payment_count"
      expr: COUNT(DISTINCT CASE WHEN audit_report_flag = TRUE THEN residual_payment_id END)
      comment: "Number of payments flagged for audit, indicating compliance risk and review workload"
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`talent_clearance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Talent clearance KPIs tracking approval status, guild compliance, and usage rights for content production and distribution."
  source: "`vibe_media_broadcasting_v1`.`talent`.`clearance`"
  dimensions:
    - name: "clearance_status"
      expr: clearance_status
      comment: "Current status of the talent clearance (pending, approved, denied, expired)"
    - name: "clearance_type"
      expr: clearance_type
      comment: "Type of clearance (likeness, performance, name, voice, etc.)"
    - name: "usage_category"
      expr: usage_category
      comment: "Category of usage for which clearance is sought (broadcast, streaming, promotional, etc.)"
    - name: "guild_clearance_status"
      expr: guild_clearance_status
      comment: "Status of guild-specific clearance requirements"
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level of the clearance request (urgent, high, normal, low)"
    - name: "blocking_reason"
      expr: blocking_reason
      comment: "Reason clearance is blocked or delayed, if applicable"
    - name: "request_year"
      expr: YEAR(request_date)
      comment: "Year the clearance was requested"
    - name: "request_month"
      expr: DATE_TRUNC('MONTH', request_date)
      comment: "Month the clearance was requested"
    - name: "talent_approval_required_flag"
      expr: talent_approval_required_flag
      comment: "Whether direct talent approval is required for this clearance"
    - name: "guild_clearance_required_flag"
      expr: guild_clearance_required_flag
      comment: "Whether guild clearance is required"
    - name: "reviewed_by_legal_flag"
      expr: reviewed_by_legal_flag
      comment: "Whether the clearance has been reviewed by legal"
    - name: "residual_payment_triggered_flag"
      expr: residual_payment_triggered_flag
      comment: "Whether this clearance triggers residual payment obligations"
  measures:
    - name: "clearance_count"
      expr: COUNT(DISTINCT clearance_id)
      comment: "Total number of clearance requests, indicating volume of rights management activity"
    - name: "approved_clearance_count"
      expr: COUNT(DISTINCT CASE WHEN clearance_status = 'Approved' THEN clearance_id END)
      comment: "Number of approved clearances, critical for production readiness and content availability"
    - name: "pending_clearance_count"
      expr: COUNT(DISTINCT CASE WHEN clearance_status = 'Pending' THEN clearance_id END)
      comment: "Number of pending clearances, indicating bottlenecks and operational risk to production schedules"
    - name: "denied_clearance_count"
      expr: COUNT(DISTINCT CASE WHEN clearance_status = 'Denied' THEN clearance_id END)
      comment: "Number of denied clearances, indicating content usage restrictions and potential revenue impact"
    - name: "guild_clearance_required_count"
      expr: COUNT(DISTINCT CASE WHEN guild_clearance_required_flag = TRUE THEN clearance_id END)
      comment: "Number of clearances requiring guild approval, indicating compliance complexity"
    - name: "talent_approval_required_count"
      expr: COUNT(DISTINCT CASE WHEN talent_approval_required_flag = TRUE THEN clearance_id END)
      comment: "Number of clearances requiring direct talent approval, indicating relationship management workload"
    - name: "residual_triggering_clearance_count"
      expr: COUNT(DISTINCT CASE WHEN residual_payment_triggered_flag = TRUE THEN clearance_id END)
      comment: "Number of clearances triggering residual payments, indicating downstream cost implications"
    - name: "legal_review_required_count"
      expr: COUNT(DISTINCT CASE WHEN reviewed_by_legal_flag = FALSE AND clearance_status = 'Pending' THEN clearance_id END)
      comment: "Number of pending clearances awaiting legal review, indicating legal department workload"
    - name: "unique_talent_cleared"
      expr: COUNT(DISTINCT talent_profile_id)
      comment: "Number of unique talent profiles with clearance activity, indicating breadth of talent rights management"
    - name: "unique_contracts_cleared"
      expr: COUNT(DISTINCT contract_id)
      comment: "Number of unique contracts involved in clearances, used for contract utilization analysis"
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`talent_profile`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Talent profile KPIs tracking talent roster composition, compliance status, and workforce readiness for production planning."
  source: "`vibe_media_broadcasting_v1`.`talent`.`talent_profile`"
  dimensions:
    - name: "profile_status"
      expr: profile_status
      comment: "Current status of the talent profile (active, inactive, suspended, etc.)"
    - name: "talent_type"
      expr: talent_type
      comment: "Type of talent (actor, director, producer, writer, crew, etc.)"
    - name: "talent_tier"
      expr: talent_tier
      comment: "Tier or level of talent (A-list, B-list, emerging, etc.)"
    - name: "union_affiliation"
      expr: union_affiliation
      comment: "Union or guild affiliation (SAG-AFTRA, DGA, WGA, IATSE, etc.)"
    - name: "work_authorization_status"
      expr: work_authorization_status
      comment: "Work authorization status (citizen, permanent resident, work visa, etc.)"
    - name: "clearance_status"
      expr: clearance_status
      comment: "Overall clearance status for the talent profile"
    - name: "gender_identity"
      expr: gender_identity
      comment: "Gender identity of the talent, used for diversity and inclusion reporting"
    - name: "nationality"
      expr: nationality
      comment: "Nationality of the talent"
    - name: "residual_eligibility_flag"
      expr: residual_eligibility_flag
      comment: "Whether the talent is eligible for residual payments"
    - name: "exclusivity_clause_flag"
      expr: exclusivity_clause_flag
      comment: "Whether the talent has exclusivity clauses in effect"
    - name: "insurance_coverage_flag"
      expr: insurance_coverage_flag
      comment: "Whether the talent has insurance coverage on file"
    - name: "gdpr_consent_status"
      expr: gdpr_consent_status
      comment: "GDPR consent status for the talent profile"
  measures:
    - name: "talent_profile_count"
      expr: COUNT(DISTINCT talent_profile_id)
      comment: "Total number of talent profiles, indicating roster size and talent pool breadth"
    - name: "active_talent_count"
      expr: COUNT(DISTINCT CASE WHEN profile_status = 'Active' THEN talent_profile_id END)
      comment: "Number of active talent profiles, critical for production capacity and casting availability"
    - name: "union_talent_count"
      expr: COUNT(DISTINCT CASE WHEN union_affiliation IS NOT NULL THEN talent_profile_id END)
      comment: "Number of union-affiliated talent, indicating guild compliance obligations and cost structure"
    - name: "residual_eligible_talent_count"
      expr: COUNT(DISTINCT CASE WHEN residual_eligibility_flag = TRUE THEN talent_profile_id END)
      comment: "Number of talent eligible for residuals, indicating potential long-term cost exposure"
    - name: "exclusive_talent_count"
      expr: COUNT(DISTINCT CASE WHEN exclusivity_clause_flag = TRUE THEN talent_profile_id END)
      comment: "Number of talent under exclusivity, indicating competitive advantage and availability constraints"
    - name: "insured_talent_count"
      expr: COUNT(DISTINCT CASE WHEN insurance_coverage_flag = TRUE THEN talent_profile_id END)
      comment: "Number of talent with insurance coverage, critical for production risk management"
    - name: "work_authorized_talent_count"
      expr: COUNT(DISTINCT CASE WHEN work_authorization_status IN ('Citizen', 'Permanent Resident', 'Work Visa') THEN talent_profile_id END)
      comment: "Number of work-authorized talent, indicating production-ready workforce"
    - name: "gdpr_compliant_talent_count"
      expr: COUNT(DISTINCT CASE WHEN gdpr_consent_status = 'Consented' THEN talent_profile_id END)
      comment: "Number of GDPR-compliant talent profiles, critical for regulatory compliance in EU markets"
    - name: "a_list_talent_count"
      expr: COUNT(DISTINCT CASE WHEN talent_tier = 'A-List' THEN talent_profile_id END)
      comment: "Number of A-list talent, indicating marquee value and premium cost exposure"
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`talent_role`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Talent role assignment KPIs tracking casting, compensation, and usage rights by role for production cost management and content planning."
  source: "`vibe_media_broadcasting_v1`.`talent`.`role`"
  dimensions:
    - name: "role_status"
      expr: role_status
      comment: "Current status of the role assignment (active, completed, cancelled, etc.)"
    - name: "credit_type"
      expr: credit_type
      comment: "Type of credit (main title, end title, special thanks, etc.)"
    - name: "billing_position"
      expr: billing_position
      comment: "Billing position in credits (first, second, third, etc.)"
    - name: "guild_affiliation"
      expr: guild_affiliation
      comment: "Guild affiliation for this role assignment"
    - name: "compensation_type"
      expr: compensation_type
      comment: "Type of compensation for the role (per episode, per day, flat fee, etc.)"
    - name: "above_the_line_flag"
      expr: above_the_line_flag
      comment: "Whether this is an above-the-line role (principal talent vs. crew)"
    - name: "residual_eligible_flag"
      expr: residual_eligible_flag
      comment: "Whether this role is eligible for residual payments"
    - name: "exclusivity_flag"
      expr: exclusivity_flag
      comment: "Whether this role includes exclusivity provisions"
    - name: "voice_only_flag"
      expr: voice_only_flag
      comment: "Whether this is a voice-only role (animation, ADR, etc.)"
    - name: "stunt_double_flag"
      expr: stunt_double_flag
      comment: "Whether this is a stunt double role"
    - name: "role_year"
      expr: YEAR(start_date)
      comment: "Year the role assignment started"
  measures:
    - name: "total_role_compensation"
      expr: SUM(CAST(compensation_amount AS DOUBLE))
      comment: "Total compensation across all role assignments, primary metric for talent cost by role"
    - name: "avg_role_compensation"
      expr: AVG(CAST(compensation_amount AS DOUBLE))
      comment: "Average compensation per role, used for budgeting and rate benchmarking"
    - name: "total_screen_time_minutes"
      expr: SUM(CAST(screen_time_minutes AS DOUBLE))
      comment: "Total screen time across all roles, relevant for residual calculations and content analysis"
    - name: "avg_screen_time_minutes"
      expr: AVG(CAST(screen_time_minutes AS DOUBLE))
      comment: "Average screen time per role, used for role scope and compensation analysis"
    - name: "role_count"
      expr: COUNT(DISTINCT role_id)
      comment: "Total number of role assignments, indicating casting volume and production scale"
    - name: "active_role_count"
      expr: COUNT(DISTINCT CASE WHEN role_status = 'Active' THEN role_id END)
      comment: "Number of currently active role assignments, critical for production capacity tracking"
    - name: "above_the_line_role_count"
      expr: COUNT(DISTINCT CASE WHEN above_the_line_flag = TRUE THEN role_id END)
      comment: "Number of above-the-line roles, indicating principal talent count and premium cost exposure"
    - name: "residual_eligible_role_count"
      expr: COUNT(DISTINCT CASE WHEN residual_eligible_flag = TRUE THEN role_id END)
      comment: "Number of residual-eligible roles, indicating long-term cost obligations"
    - name: "exclusive_role_count"
      expr: COUNT(DISTINCT CASE WHEN exclusivity_flag = TRUE THEN role_id END)
      comment: "Number of roles with exclusivity, indicating talent availability constraints"
    - name: "unique_talent_cast"
      expr: COUNT(DISTINCT talent_profile_id)
      comment: "Number of unique talent cast across roles, indicating casting diversity and talent pool utilization"
    - name: "unique_contracts_utilized"
      expr: COUNT(DISTINCT contract_id)
      comment: "Number of unique contracts utilized for role assignments, used for contract efficiency analysis"
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`talent_compensation_structure`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Compensation structure KPIs tracking deal terms, participation rates, and payment triggers for talent cost modeling and negotiation benchmarking."
  source: "`vibe_media_broadcasting_v1`.`talent`.`compensation_structure`"
  dimensions:
    - name: "compensation_type"
      expr: compensation_type
      comment: "Type of compensation structure (episodic, weekly, daily, project-based, etc.)"
    - name: "structure_status"
      expr: structure_status
      comment: "Status of the compensation structure (active, superseded, expired, etc.)"
    - name: "guild_affiliation"
      expr: guild_affiliation
      comment: "Guild affiliation governing this compensation structure"
    - name: "participation_definition_type"
      expr: participation_definition_type
      comment: "Type of participation definition (gross, adjusted gross, net, etc.)"
    - name: "residual_eligibility_flag"
      expr: residual_eligibility_flag
      comment: "Whether this compensation structure includes residual eligibility"
    - name: "pay_or_play_flag"
      expr: pay_or_play_flag
      comment: "Whether this is a pay-or-play compensation structure"
    - name: "exclusivity_clause_flag"
      expr: exclusivity_clause_flag
      comment: "Whether this structure includes exclusivity provisions"
    - name: "structure_year"
      expr: YEAR(effective_start_date)
      comment: "Year the compensation structure became effective"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency code for the compensation amounts"
  measures:
    - name: "total_base_episode_fee"
      expr: SUM(CAST(base_episode_fee AS DOUBLE))
      comment: "Total base episode fees across all structures, primary metric for episodic talent cost"
    - name: "avg_base_episode_fee"
      expr: AVG(CAST(base_episode_fee AS DOUBLE))
      comment: "Average base episode fee, used for rate benchmarking and budget modeling"
    - name: "total_daily_rate"
      expr: SUM(CAST(daily_rate AS DOUBLE))
      comment: "Total daily rates across all structures, relevant for daily-hire talent cost"
    - name: "avg_daily_rate"
      expr: AVG(CAST(daily_rate AS DOUBLE))
      comment: "Average daily rate, used for crew and guest talent budgeting"
    - name: "total_weekly_guarantee"
      expr: SUM(CAST(weekly_guarantee AS DOUBLE))
      comment: "Total weekly guarantees, indicating minimum committed compensation"
    - name: "avg_weekly_guarantee"
      expr: AVG(CAST(weekly_guarantee AS DOUBLE))
      comment: "Average weekly guarantee, used for weekly-hire talent planning"
    - name: "total_bonus_amount"
      expr: SUM(CAST(bonus_amount AS DOUBLE))
      comment: "Total bonus amounts across structures, indicating performance-based cost exposure"
    - name: "avg_participation_percentage"
      expr: AVG(CAST(participation_percentage AS DOUBLE))
      comment: "Average participation percentage, critical for profit-sharing exposure analysis"
    - name: "avg_backend_gross_participation_pct"
      expr: AVG(CAST(backend_gross_participation_pct AS DOUBLE))
      comment: "Average backend gross participation percentage, key for backend cost modeling"
    - name: "total_deferred_compensation"
      expr: SUM(CAST(deferred_compensation_amount AS DOUBLE))
      comment: "Total deferred compensation, indicating future payment obligations"
    - name: "avg_pension_health_rate"
      expr: AVG(CAST(pension_health_rate AS DOUBLE))
      comment: "Average pension and health contribution rate, mandatory guild cost component"
    - name: "total_step_up_amount"
      expr: SUM(CAST(step_up_amount AS DOUBLE))
      comment: "Total step-up amounts, indicating potential cost escalation triggers"
    - name: "compensation_structure_count"
      expr: COUNT(DISTINCT compensation_structure_id)
      comment: "Number of compensation structures, indicating deal complexity and variety"
    - name: "active_structure_count"
      expr: COUNT(DISTINCT CASE WHEN structure_status = 'Active' THEN compensation_structure_id END)
      comment: "Number of active compensation structures, used for current cost modeling"
    - name: "pay_or_play_structure_count"
      expr: COUNT(DISTINCT CASE WHEN pay_or_play_flag = TRUE THEN compensation_structure_id END)
      comment: "Number of pay-or-play structures, indicating guaranteed cost exposure"
$$;