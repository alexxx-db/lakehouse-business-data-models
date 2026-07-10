-- Metric views for domain: talent | Business: Media_Broadcasting | Version: 3 | Generated on: 2026-07-10 19:06:42

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`talent_profile`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPIs for the talent roster — profile status distribution, PII/compliance posture, exclusivity exposure, and union coverage. Used by Talent Operations and Business Affairs to manage roster health and contractual risk."
  source: "`vibe_media_broadcasting_v1`.`talent`.`talent_profile`"
  dimensions:
    - name: "talent_type"
      expr: talent_type
      comment: "Category of talent (e.g. actor, host, voice talent) for roster segmentation."
    - name: "talent_tier"
      expr: talent_tier
      comment: "Commercial tier of the talent (e.g. A-list, mid-tier) for prioritization and resource allocation."
    - name: "profile_status"
      expr: profile_status
      comment: "Current lifecycle status of the talent profile (active, inactive, suspended) for roster management."
    - name: "union_affiliation"
      expr: union_affiliation
      comment: "Guild or union the talent belongs to (SAG-AFTRA, DGA, WGA, etc.) for CBA compliance tracking."
    - name: "nationality"
      expr: nationality
      comment: "Talent nationality for work authorization and international production planning."
    - name: "primary_language"
      expr: primary_language
      comment: "Primary language of the talent for casting and localization decisions."
    - name: "work_authorization_status"
      expr: work_authorization_status
      comment: "Work authorization status for compliance and production scheduling."
    - name: "clearance_status"
      expr: clearance_status
      comment: "Current facility/security clearance status of the talent profile."
    - name: "gdpr_consent_status"
      expr: gdpr_consent_status
      comment: "GDPR consent status for data privacy compliance reporting."
  measures:
    - name: "total_talent_profiles"
      expr: COUNT(1)
      comment: "Total number of talent profiles on the roster. Baseline headcount KPI for talent operations."
    - name: "active_talent_profiles"
      expr: COUNT(CASE WHEN profile_status = 'active' THEN 1 END)
      comment: "Number of currently active talent profiles. Drives capacity planning and booking availability."
    - name: "exclusivity_clause_coverage_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN exclusivity_clause_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of talent profiles with an active exclusivity clause. High rates indicate competitive protection; low rates signal exposure to competitor bookings."
    - name: "residual_eligible_talent_count"
      expr: COUNT(CASE WHEN residual_eligibility_flag = TRUE THEN 1 END)
      comment: "Number of talent profiles eligible for residual payments. Drives residual liability forecasting and guild compliance obligations."
    - name: "residual_eligible_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN residual_eligibility_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of talent profiles carrying residual payment obligations. Key financial risk indicator for Business Affairs."
    - name: "insured_talent_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN insurance_coverage_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of talent profiles with verified insurance coverage. Uninsured talent on active productions creates liability exposure."
    - name: "work_visa_expiring_within_90_days"
      expr: COUNT(CASE WHEN work_visa_expiration_date BETWEEN CURRENT_DATE AND DATE_ADD(CURRENT_DATE, 90) THEN 1 END)
      comment: "Number of talent profiles with work visas expiring within 90 days. Operational alert metric for production scheduling and legal compliance."
    - name: "clearance_expiring_within_90_days"
      expr: COUNT(CASE WHEN clearance_expiration_date BETWEEN CURRENT_DATE AND DATE_ADD(CURRENT_DATE, 90) THEN 1 END)
      comment: "Number of talent profiles with facility clearances expiring within 90 days. Prevents production delays from lapsed clearances."
    - name: "ccpa_opt_out_count"
      expr: COUNT(CASE WHEN ccpa_opt_out_flag = TRUE THEN 1 END)
      comment: "Number of talent profiles with CCPA opt-out active. Compliance KPI for California privacy law adherence."
    - name: "biometric_consent_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN biometric_consent_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of talent profiles with biometric consent on file. Required for productions using biometric data; non-compliance creates legal risk."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`talent_contract`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Financial and risk KPIs for talent contracts — compensation exposure, pay-or-play liability, residual obligations, and option pipeline. Used by Business Affairs, Finance, and Legal to manage contractual commitments."
  source: "`vibe_media_broadcasting_v1`.`talent`.`contract`"
  dimensions:
    - name: "contract_type"
      expr: contract_type
      comment: "Type of talent contract (series regular, recurring guest, pilot, etc.) for portfolio segmentation."
    - name: "contract_status"
      expr: contract_status
      comment: "Current lifecycle status of the contract (active, expired, terminated, pending) for pipeline management."
    - name: "engagement_role"
      expr: engagement_role
      comment: "Role the talent is engaged for under this contract (lead, supporting, host, etc.)."
    - name: "guild_affiliation"
      expr: guild_affiliation
      comment: "Guild or union governing this contract for CBA compliance segmentation."
    - name: "compensation_currency"
      expr: compensation_currency
      comment: "Currency of the base compensation for multi-currency financial reporting."
    - name: "backend_participation_type"
      expr: backend_participation_type
      comment: "Type of backend participation (gross, net, adjusted gross) for profit participation analysis."
    - name: "option_exercise_status"
      expr: option_exercise_status
      comment: "Status of option exercise (pending, exercised, lapsed) for talent pipeline forecasting."
    - name: "exclusivity_flag"
      expr: exclusivity_flag
      comment: "Whether the contract includes an exclusivity clause for competitive risk assessment."
    - name: "pay_or_play_flag"
      expr: pay_or_play_flag
      comment: "Whether the contract has pay-or-play provisions, indicating guaranteed payment regardless of production."
  measures:
    - name: "total_contracts"
      expr: COUNT(1)
      comment: "Total number of talent contracts. Baseline volume KPI for Business Affairs workload and portfolio size."
    - name: "active_contracts"
      expr: COUNT(CASE WHEN contract_status = 'active' THEN 1 END)
      comment: "Number of currently active talent contracts. Drives resource planning and financial obligation tracking."
    - name: "total_base_compensation"
      expr: SUM(CAST(base_compensation_amount AS DOUBLE))
      comment: "Total base compensation committed across all talent contracts. Core financial exposure metric for Finance and Business Affairs."
    - name: "avg_base_compensation"
      expr: AVG(CAST(base_compensation_amount AS DOUBLE))
      comment: "Average base compensation per talent contract. Benchmarking KPI for rate negotiations and budget planning."
    - name: "pay_or_play_liability_total"
      expr: SUM(CASE WHEN pay_or_play_flag = TRUE THEN CAST(base_compensation_amount AS DOUBLE) ELSE 0 END)
      comment: "Total compensation committed under pay-or-play contracts. Represents guaranteed financial liability even if production is cancelled — critical for budget risk management."
    - name: "pay_or_play_contract_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN pay_or_play_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of contracts with pay-or-play provisions. High rates indicate elevated financial risk if productions are cancelled or delayed."
    - name: "total_backend_participation_pct_avg"
      expr: AVG(CAST(backend_participation_percentage AS DOUBLE))
      comment: "Average backend participation percentage across contracts. Informs profit participation liability forecasting for successful productions."
    - name: "total_step_up_exposure"
      expr: SUM(CAST(step_up_amount AS DOUBLE))
      comment: "Total step-up compensation exposure across all contracts. Represents incremental cost when option periods or performance triggers are met."
    - name: "residual_eligible_contracts"
      expr: COUNT(CASE WHEN residual_eligibility_flag = TRUE THEN 1 END)
      comment: "Number of contracts with residual payment eligibility. Drives residual liability forecasting and guild remittance planning."
    - name: "exclusivity_contract_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN exclusivity_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of contracts with exclusivity clauses. Measures competitive protection coverage across the talent portfolio."
    - name: "contracts_expiring_within_90_days"
      expr: COUNT(CASE WHEN effective_end_date BETWEEN CURRENT_DATE AND DATE_ADD(CURRENT_DATE, 90) THEN 1 END)
      comment: "Number of contracts expiring within 90 days. Operational alert for renewal pipeline management and talent retention risk."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`talent_residual_payment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Financial KPIs for talent residual payments — payment volumes, guild remittance compliance, withholding tax, and agent commission costs. Used by Finance, Business Affairs, and Guild Relations to manage residual obligations."
  source: "`vibe_media_broadcasting_v1`.`talent`.`residual_payment`"
  dimensions:
    - name: "payment_status"
      expr: payment_status
      comment: "Current status of the residual payment (pending, paid, disputed, cancelled) for cash flow management."
    - name: "payment_method"
      expr: payment_method
      comment: "Method of payment (ACH, wire, check) for treasury operations analysis."
    - name: "guild_affiliation"
      expr: guild_affiliation
      comment: "Guild or union associated with the residual payment for guild-level remittance reporting."
    - name: "use_type"
      expr: use_type
      comment: "Type of use triggering the residual (rerun, streaming, foreign, etc.) for rights exploitation analysis."
    - name: "distribution_window"
      expr: distribution_window
      comment: "Distribution window (theatrical, home video, streaming, broadcast) for residual liability segmentation."
    - name: "payment_currency_code"
      expr: payment_currency_code
      comment: "Currency of the residual payment for multi-currency financial reporting."
    - name: "remittance_advice_sent_flag"
      expr: remittance_advice_sent_flag
      comment: "Whether remittance advice has been sent to the talent/guild for compliance tracking."
  measures:
    - name: "total_residual_payments"
      expr: COUNT(1)
      comment: "Total number of residual payment transactions. Baseline volume KPI for guild remittance operations."
    - name: "total_gross_residual_amount"
      expr: SUM(CAST(gross_residual_amount AS DOUBLE))
      comment: "Total gross residual amount across all payments. Primary financial obligation metric for Business Affairs and Finance."
    - name: "total_net_payment_amount"
      expr: SUM(CAST(net_payment_amount AS DOUBLE))
      comment: "Total net amount paid to talent after deductions. Actual cash outflow metric for treasury management."
    - name: "total_withholding_tax"
      expr: SUM(CAST(withholding_tax_amount AS DOUBLE))
      comment: "Total withholding tax deducted from residual payments. Tax compliance and remittance reporting KPI."
    - name: "total_agent_commission"
      expr: SUM(CAST(agent_commission_amount AS DOUBLE))
      comment: "Total agent commission paid out of residuals. Measures agency cost burden on residual obligations."
    - name: "total_pension_health_contribution"
      expr: SUM(CAST(pension_health_amount AS DOUBLE))
      comment: "Total pension and health contributions embedded in residual payments. Guild compliance and benefits cost KPI."
    - name: "avg_net_payment_amount"
      expr: AVG(CAST(net_payment_amount AS DOUBLE))
      comment: "Average net residual payment per transaction. Benchmarking KPI for payment size trends and anomaly detection."
    - name: "remittance_advice_sent_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN remittance_advice_sent_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of residual payments with remittance advice sent. Guild compliance KPI — low rates indicate process failures that can trigger guild audits."
    - name: "audit_flagged_payment_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN audit_report_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of residual payments flagged for audit review. Risk management KPI for identifying payment accuracy issues."
    - name: "pending_payment_total"
      expr: SUM(CASE WHEN payment_status = 'pending' THEN CAST(net_payment_amount AS DOUBLE) ELSE 0 END)
      comment: "Total net amount of residual payments still pending. Cash flow and guild obligation backlog metric."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`talent_compensation_structure`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs for talent compensation structures — rate benchmarking, bonus exposure, deferred compensation liability, and guild contribution rates. Used by Business Affairs and Finance for compensation strategy and budget planning."
  source: "`vibe_media_broadcasting_v1`.`talent`.`compensation_structure`"
  dimensions:
    - name: "compensation_type"
      expr: compensation_type
      comment: "Type of compensation structure (flat fee, weekly guarantee, daily rate, etc.) for rate analysis."
    - name: "structure_status"
      expr: structure_status
      comment: "Current status of the compensation structure (active, superseded, expired) for portfolio management."
    - name: "guild_affiliation"
      expr: guild_affiliation
      comment: "Guild or union governing this compensation structure for CBA compliance segmentation."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the compensation structure for multi-currency financial reporting."
    - name: "exclusivity_clause_flag"
      expr: exclusivity_clause_flag
      comment: "Whether this compensation structure includes an exclusivity clause for competitive risk assessment."
    - name: "pay_or_play_flag"
      expr: pay_or_play_flag
      comment: "Whether this structure has pay-or-play provisions for guaranteed payment liability tracking."
    - name: "residual_eligibility_flag"
      expr: residual_eligibility_flag
      comment: "Whether this compensation structure carries residual payment eligibility."
  measures:
    - name: "total_compensation_structures"
      expr: COUNT(1)
      comment: "Total number of compensation structures. Baseline volume for Business Affairs portfolio management."
    - name: "avg_base_episode_fee"
      expr: AVG(CAST(base_episode_fee AS DOUBLE))
      comment: "Average base episode fee across compensation structures. Benchmarking KPI for rate negotiations and budget planning."
    - name: "avg_weekly_guarantee"
      expr: AVG(CAST(weekly_guarantee AS DOUBLE))
      comment: "Average weekly guarantee across compensation structures. Key rate benchmark for talent negotiations."
    - name: "total_bonus_exposure"
      expr: SUM(CAST(bonus_amount AS DOUBLE))
      comment: "Total bonus amount committed across all compensation structures. Measures variable compensation liability for budget planning."
    - name: "total_deferred_compensation"
      expr: SUM(CAST(deferred_compensation_amount AS DOUBLE))
      comment: "Total deferred compensation committed across structures. Long-term financial liability metric for Finance and treasury planning."
    - name: "avg_overtime_multiplier"
      expr: AVG(CAST(overtime_multiplier AS DOUBLE))
      comment: "Average overtime multiplier across compensation structures. Informs production scheduling cost risk when overtime is incurred."
    - name: "avg_pension_health_rate"
      expr: AVG(CAST(pension_health_rate AS DOUBLE))
      comment: "Average pension and health contribution rate across structures. Guild compliance cost benchmarking KPI."
    - name: "total_step_up_exposure"
      expr: SUM(CAST(step_up_amount AS DOUBLE))
      comment: "Total step-up compensation exposure across all structures. Incremental cost risk when performance triggers or option periods are activated."
    - name: "pay_or_play_structure_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN pay_or_play_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of compensation structures with pay-or-play provisions. Elevated rates signal high guaranteed payment risk if productions are cancelled."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`talent_appearance_schedule`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Operational KPIs for talent appearance scheduling — booking confirmation rates, cancellation rates, exclusivity conflicts, and guild notification compliance. Used by Production Operations and Talent Scheduling to manage on-set efficiency."
  source: "`vibe_media_broadcasting_v1`.`talent`.`appearance_schedule`"
  dimensions:
    - name: "appearance_type"
      expr: appearance_type
      comment: "Type of appearance (principal photography, promotional, interview, etc.) for scheduling analysis."
    - name: "confirmation_status"
      expr: confirmation_status
      comment: "Booking confirmation status for pipeline and capacity management."
    - name: "daypart"
      expr: daypart
      comment: "Daypart of the scheduled appearance for production scheduling optimization."
    - name: "hold_level"
      expr: hold_level
      comment: "Hold level placed on the talent for this appearance (first hold, second hold, etc.) for booking priority management."
    - name: "release_tracking_status"
      expr: release_tracking_status
      comment: "Status of talent release tracking for post-production and distribution workflows."
    - name: "exclusivity_conflict_flag"
      expr: exclusivity_conflict_flag
      comment: "Whether an exclusivity conflict exists for this appearance, requiring Business Affairs resolution."
    - name: "guild_notification_required"
      expr: guild_notification_required
      comment: "Whether guild notification is required for this appearance for CBA compliance tracking."
    - name: "playout_system_sync_status"
      expr: playout_system_sync_status
      comment: "Sync status with the playout system for operational readiness monitoring."
  measures:
    - name: "total_appearances_scheduled"
      expr: COUNT(1)
      comment: "Total number of talent appearances scheduled. Baseline production activity volume KPI."
    - name: "confirmed_appearance_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN confirmation_status = 'confirmed' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of scheduled appearances with confirmed bookings. Low rates indicate scheduling pipeline risk and potential production delays."
    - name: "cancellation_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN cancellation_reason IS NOT NULL THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of scheduled appearances that were cancelled. High rates signal talent availability issues or production instability."
    - name: "avg_actual_duration_hours"
      expr: AVG(CAST(actual_duration_hours AS DOUBLE))
      comment: "Average actual appearance duration in hours. Compared against estimated duration to identify scheduling accuracy and overtime risk."
    - name: "avg_estimated_duration_hours"
      expr: AVG(CAST(estimated_duration_hours AS DOUBLE))
      comment: "Average estimated appearance duration in hours. Baseline for scheduling efficiency and cost estimation."
    - name: "duration_overrun_avg"
      expr: AVG(CAST(actual_duration_hours AS DOUBLE) - CAST(estimated_duration_hours AS DOUBLE))
      comment: "Average overrun in hours (actual minus estimated duration). Positive values indicate systematic underestimation driving overtime costs."
    - name: "exclusivity_conflict_count"
      expr: COUNT(CASE WHEN exclusivity_conflict_flag = TRUE THEN 1 END)
      comment: "Number of appearances with active exclusivity conflicts. Each conflict requires Business Affairs intervention and may delay production."
    - name: "guild_notification_compliance_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN guild_notification_required = TRUE AND guild_notification_sent_timestamp IS NOT NULL THEN 1 END) / NULLIF(COUNT(CASE WHEN guild_notification_required = TRUE THEN 1 END), 0), 2)
      comment: "Percentage of required guild notifications that have been sent. Non-compliance triggers guild grievances and financial penalties."
    - name: "rescheduled_appearance_count"
      expr: COUNT(CASE WHEN rescheduled_from_appearance_schedule_id IS NOT NULL THEN 1 END)
      comment: "Number of appearances that were rescheduled from a prior booking. High counts indicate scheduling instability and incremental production costs."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`talent_guild_affiliation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Compliance and financial KPIs for talent guild affiliations — membership status, dues compliance, pension and health eligibility, and residual coverage. Used by Guild Relations and Legal to manage CBA obligations."
  source: "`vibe_media_broadcasting_v1`.`talent`.`guild_affiliation`"
  dimensions:
    - name: "guild_name"
      expr: guild_name
      comment: "Name of the guild or union for guild-level compliance reporting."
    - name: "guild_code"
      expr: guild_code
      comment: "Standardized guild code for system integration and CBA reference."
    - name: "membership_status"
      expr: membership_status
      comment: "Current membership status (active, suspended, terminated) for compliance monitoring."
    - name: "membership_tier"
      expr: membership_tier
      comment: "Tier of guild membership for benefit eligibility and rate determination."
    - name: "jurisdiction"
      expr: jurisdiction
      comment: "Geographic jurisdiction of the guild affiliation for multi-market compliance reporting."
    - name: "local_chapter"
      expr: local_chapter
      comment: "Local chapter of the guild for granular compliance and remittance tracking."
    - name: "dues_payment_status"
      expr: dues_payment_status
      comment: "Current dues payment status for financial compliance monitoring."
    - name: "health_benefits_eligible_flag"
      expr: health_benefits_eligible_flag
      comment: "Whether the talent is eligible for guild health benefits for benefits cost planning."
    - name: "pension_eligible_flag"
      expr: pension_eligible_flag
      comment: "Whether the talent is eligible for guild pension contributions for pension liability planning."
  measures:
    - name: "total_guild_affiliations"
      expr: COUNT(1)
      comment: "Total number of guild affiliation records. Baseline CBA compliance portfolio size."
    - name: "active_guild_memberships"
      expr: COUNT(CASE WHEN membership_status = 'active' THEN 1 END)
      comment: "Number of currently active guild memberships. Drives CBA obligation scope and remittance volume."
    - name: "dues_current_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN dues_payment_status = 'current' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of guild affiliations with dues payments current. Non-current dues can result in talent being ineligible to work under CBA."
    - name: "pension_eligible_count"
      expr: COUNT(CASE WHEN pension_eligible_flag = TRUE THEN 1 END)
      comment: "Number of talent with pension eligibility. Drives pension contribution liability forecasting."
    - name: "health_benefits_eligible_count"
      expr: COUNT(CASE WHEN health_benefits_eligible_flag = TRUE THEN 1 END)
      comment: "Number of talent eligible for guild health benefits. Drives health contribution cost planning."
    - name: "residual_eligible_affiliation_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN residual_eligibility_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of guild affiliations with residual payment eligibility. Informs residual liability scope by guild."
    - name: "cba_expiring_within_90_days"
      expr: COUNT(CASE WHEN cba_expiration_date BETWEEN CURRENT_DATE AND DATE_ADD(CURRENT_DATE, 90) THEN 1 END)
      comment: "Number of CBA agreements expiring within 90 days. Operational alert for renegotiation planning and production risk management."
    - name: "distinct_guilds_represented"
      expr: COUNT(DISTINCT guild_code)
      comment: "Number of distinct guilds represented in the talent roster. Measures CBA complexity and compliance management scope."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`talent_pension_health_contribution`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Financial KPIs for pension and health contributions to talent guilds — contribution volumes, late payment penalties, reconciliation status, and employer vs employee cost split. Used by Finance and Guild Relations for remittance compliance."
  source: "`vibe_media_broadcasting_v1`.`talent`.`pension_health_contribution`"
  dimensions:
    - name: "contribution_type"
      expr: contribution_type
      comment: "Type of contribution (pension, health, combined) for benefit cost segmentation."
    - name: "reconciliation_status"
      expr: reconciliation_status
      comment: "Reconciliation status of the contribution for financial close and audit readiness."
    - name: "guild_fund_name"
      expr: guild_fund_name
      comment: "Name of the guild fund receiving the contribution for fund-level remittance reporting."
    - name: "guild_fund_code"
      expr: guild_fund_code
      comment: "Standardized guild fund code for system integration and remittance tracking."
    - name: "payment_method"
      expr: payment_method
      comment: "Method of contribution payment (ACH, wire, check) for treasury operations."
    - name: "work_type"
      expr: work_type
      comment: "Type of work generating the contribution (principal, residual, etc.) for CBA compliance segmentation."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the contribution for multi-currency financial reporting."
    - name: "compliance_flag"
      expr: compliance_flag
      comment: "Whether the contribution is flagged for compliance review."
  measures:
    - name: "total_contributions"
      expr: COUNT(1)
      comment: "Total number of pension and health contribution transactions. Baseline remittance volume KPI."
    - name: "total_contribution_amount"
      expr: SUM(CAST(total_contribution_amount AS DOUBLE))
      comment: "Total pension and health contributions remitted. Primary guild financial obligation metric for Finance and Business Affairs."
    - name: "total_employer_contribution"
      expr: SUM(CAST(employer_contribution_amount AS DOUBLE))
      comment: "Total employer-side pension and health contributions. Direct production cost metric for budget management."
    - name: "total_employee_contribution"
      expr: SUM(CAST(employee_contribution_amount AS DOUBLE))
      comment: "Total employee-side pension and health contributions withheld. Payroll compliance metric."
    - name: "total_late_payment_penalties"
      expr: SUM(CAST(late_payment_penalty_amount AS DOUBLE))
      comment: "Total late payment penalties incurred on guild contributions. Avoidable cost KPI — high values indicate process failures in remittance scheduling."
    - name: "avg_employer_contribution_rate"
      expr: AVG(CAST(employer_contribution_rate AS DOUBLE))
      comment: "Average employer contribution rate across all transactions. Benchmarking KPI for CBA rate compliance."
    - name: "total_gross_compensation_base"
      expr: SUM(CAST(gross_compensation_base AS DOUBLE))
      comment: "Total gross compensation base used for contribution calculations. Validates contribution amounts against compensation records."
    - name: "reconciliation_completion_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN reconciliation_status = 'reconciled' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of contributions fully reconciled. Financial close readiness and audit compliance KPI."
    - name: "compliance_flagged_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN compliance_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of contributions flagged for compliance review. Risk indicator for guild audit exposure."
    - name: "total_adjustment_amount"
      expr: SUM(CAST(adjustment_amount AS DOUBLE))
      comment: "Total adjustment amounts applied to contributions. High values indicate systematic calculation errors requiring process improvement."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`talent_grievance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Risk and compliance KPIs for talent grievances — filing volumes, financial exposure, resolution rates, and arbitration escalation. Used by Legal, HR, and Guild Relations to manage labor relations risk."
  source: "`vibe_media_broadcasting_v1`.`talent`.`talent_grievance`"
  dimensions:
    - name: "grievance_type"
      expr: grievance_type
      comment: "Type of grievance (compensation, working conditions, credit, etc.) for root cause analysis."
    - name: "resolution_status"
      expr: resolution_status
      comment: "Current resolution status (open, resolved, escalated, arbitration) for case management."
    - name: "resolution_method"
      expr: resolution_method
      comment: "Method of resolution (negotiation, mediation, arbitration) for process effectiveness analysis."
    - name: "filing_party_type"
      expr: filing_party_type
      comment: "Type of filing party (talent, guild, production company) for grievance origin analysis."
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level of the grievance for case management and resource allocation."
    - name: "confidentiality_flag"
      expr: confidentiality_flag
      comment: "Whether the grievance is confidential for access control and reporting segmentation."
    - name: "appeal_filed_flag"
      expr: appeal_filed_flag
      comment: "Whether an appeal has been filed, indicating escalation beyond initial resolution."
    - name: "disputed_currency_code"
      expr: disputed_currency_code
      comment: "Currency of the disputed amount for multi-currency financial exposure reporting."
  measures:
    - name: "total_grievances"
      expr: COUNT(1)
      comment: "Total number of talent grievances filed. Baseline labor relations risk volume KPI."
    - name: "open_grievances"
      expr: COUNT(CASE WHEN resolution_status = 'open' THEN 1 END)
      comment: "Number of currently open grievances. Active legal and financial liability exposure metric."
    - name: "total_disputed_amount"
      expr: SUM(CAST(disputed_amount AS DOUBLE))
      comment: "Total financial amount in dispute across all grievances. Aggregate legal liability metric for Finance and Legal."
    - name: "total_settlement_amount"
      expr: SUM(CAST(settlement_amount AS DOUBLE))
      comment: "Total settlement amounts paid to resolve grievances. Actual cost of labor disputes for budget impact analysis."
    - name: "avg_settlement_amount"
      expr: AVG(CAST(settlement_amount AS DOUBLE))
      comment: "Average settlement amount per resolved grievance. Benchmarking KPI for settlement negotiation strategy."
    - name: "resolution_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN resolution_status = 'resolved' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of grievances resolved. Low rates indicate systemic labor relations issues requiring management intervention."
    - name: "arbitration_escalation_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN arbitration_reference_number IS NOT NULL THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of grievances escalated to arbitration. High rates signal failure of internal resolution processes and elevated legal costs."
    - name: "appeal_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN appeal_filed_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of grievances with appeals filed. Indicates dissatisfaction with initial resolution outcomes."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`talent_cba_rate_card`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs for CBA rate cards — rate benchmarking, overtime and penalty multipliers, pension contribution rates, and rate card lifecycle. Used by Business Affairs and Finance for CBA compliance and compensation budgeting."
  source: "`vibe_media_broadcasting_v1`.`talent`.`cba_rate_card`"
  dimensions:
    - name: "guild_code"
      expr: guild_code
      comment: "Guild code for CBA rate card segmentation by union."
    - name: "performer_category"
      expr: performer_category
      comment: "Category of performer (principal, day player, extra, etc.) for rate tier analysis."
    - name: "job_classification"
      expr: job_classification
      comment: "Job classification under the CBA for rate compliance verification."
    - name: "production_type"
      expr: production_type
      comment: "Type of production (scripted, unscripted, commercial, etc.) for rate applicability segmentation."
    - name: "rate_type"
      expr: rate_type
      comment: "Type of rate (daily, weekly, episodic) for compensation structure analysis."
    - name: "rate_status"
      expr: rate_status
      comment: "Current status of the rate card (active, superseded, expired) for compliance management."
    - name: "jurisdiction"
      expr: jurisdiction
      comment: "Geographic jurisdiction of the CBA rate card for multi-market compliance reporting."
    - name: "residual_eligibility_flag"
      expr: residual_eligibility_flag
      comment: "Whether this rate card category carries residual payment eligibility."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the rate card for multi-currency financial reporting."
  measures:
    - name: "total_rate_cards"
      expr: COUNT(1)
      comment: "Total number of CBA rate cards. Baseline CBA compliance portfolio size."
    - name: "active_rate_cards"
      expr: COUNT(CASE WHEN rate_status = 'active' THEN 1 END)
      comment: "Number of currently active CBA rate cards. Drives applicable rate determination for production budgeting."
    - name: "avg_minimum_scale_rate"
      expr: AVG(CAST(minimum_scale_rate AS DOUBLE))
      comment: "Average minimum scale rate across active CBA rate cards. Benchmarking KPI for compensation compliance and budget planning."
    - name: "avg_overtime_multiplier"
      expr: AVG(CAST(overtime_multiplier AS DOUBLE))
      comment: "Average overtime multiplier across rate cards. Informs production scheduling cost risk when overtime is incurred."
    - name: "avg_golden_time_multiplier"
      expr: AVG(CAST(golden_time_multiplier AS DOUBLE))
      comment: "Average golden time multiplier across rate cards. Extreme overtime cost risk indicator for production scheduling."
    - name: "avg_pension_health_contribution_rate"
      expr: AVG(CAST(pension_health_contribution_rate AS DOUBLE))
      comment: "Average pension and health contribution rate across CBA rate cards. Guild compliance cost benchmarking KPI."
    - name: "avg_meal_penalty_amount"
      expr: AVG(CAST(meal_penalty_amount AS DOUBLE))
      comment: "Average meal penalty amount across rate cards. Production scheduling compliance cost indicator."
    - name: "rate_cards_expiring_within_90_days"
      expr: COUNT(CASE WHEN expiration_date BETWEEN CURRENT_DATE AND DATE_ADD(CURRENT_DATE, 90) THEN 1 END)
      comment: "Number of CBA rate cards expiring within 90 days. Operational alert for renegotiation planning and production rate compliance risk."
    - name: "residual_eligible_rate_card_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN residual_eligibility_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of CBA rate cards with residual eligibility. Informs residual liability scope by guild and performer category."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`talent_endorsement_deal`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Revenue and risk KPIs for talent endorsement deals — deal value, commission rates, exclusivity exposure, and renewal pipeline. Used by Business Affairs and Finance to manage commercial talent partnerships."
  source: "`vibe_media_broadcasting_v1`.`talent`.`endorsement_deal`"
  dimensions:
    - name: "deal_status"
      expr: deal_status
      comment: "Current status of the endorsement deal (active, expired, terminated, pending) for portfolio management."
    - name: "deal_currency_code"
      expr: deal_currency_code
      comment: "Currency of the endorsement deal for multi-currency financial reporting."
    - name: "exclusivity_scope"
      expr: exclusivity_scope
      comment: "Scope of exclusivity in the endorsement deal for competitive conflict analysis."
    - name: "usage_territory"
      expr: usage_territory
      comment: "Geographic territory for usage rights in the endorsement deal."
    - name: "usage_media_types"
      expr: usage_media_types
      comment: "Media types covered by the endorsement deal for rights exploitation analysis."
    - name: "morals_clause_flag"
      expr: morals_clause_flag
      comment: "Whether the deal includes a morals clause for brand protection risk assessment."
    - name: "renewal_option_flag"
      expr: renewal_option_flag
      comment: "Whether the deal has a renewal option for pipeline forecasting."
  measures:
    - name: "total_endorsement_deals"
      expr: COUNT(1)
      comment: "Total number of endorsement deals. Baseline commercial talent partnership volume KPI."
    - name: "total_deal_value"
      expr: SUM(CAST(deal_value_amount AS DOUBLE))
      comment: "Total value of all endorsement deals. Primary revenue and commercial partnership metric for Business Affairs."
    - name: "avg_deal_value"
      expr: AVG(CAST(deal_value_amount AS DOUBLE))
      comment: "Average endorsement deal value. Benchmarking KPI for deal negotiation strategy and talent commercial value assessment."
    - name: "avg_commission_rate"
      expr: AVG(CAST(commission_rate AS DOUBLE))
      comment: "Average commission rate across endorsement deals. Agency cost benchmarking KPI for deal structuring."
    - name: "deals_expiring_within_90_days"
      expr: COUNT(CASE WHEN contract_end_date BETWEEN CURRENT_DATE AND DATE_ADD(CURRENT_DATE, 90) THEN 1 END)
      comment: "Number of endorsement deals expiring within 90 days. Renewal pipeline management and revenue retention KPI."
    - name: "exclusivity_period_active_count"
      expr: COUNT(CASE WHEN exclusivity_period_start <= CURRENT_DATE AND exclusivity_period_end >= CURRENT_DATE THEN 1 END)
      comment: "Number of deals with currently active exclusivity periods. Measures competitive conflict exposure across the talent roster."
    - name: "renewal_option_coverage_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN renewal_option_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of endorsement deals with renewal options. Higher rates indicate stronger long-term commercial partnership pipeline."
    - name: "morals_clause_coverage_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN morals_clause_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of endorsement deals with morals clauses. Brand protection risk management KPI — low rates expose the organization to reputational risk."
$$;