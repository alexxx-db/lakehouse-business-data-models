-- Metric views for domain: talent | Business: Media_Broadcasting | Version: 2 | Generated on: 2026-06-30 04:55:25

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`talent_contract`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Talent contract portfolio KPIs covering compensation commitment, participation exposure and contract lifecycle status. Used by Business Affairs and Finance to steer talent cost and risk."
  source: "`vibe_media_broadcasting_v1`.`talent`.`contract`"
  dimensions:
    - name: "contract_status"
      expr: contract_status
      comment: "Lifecycle state of the contract (active, expired, terminated) for portfolio segmentation."
    - name: "contract_type"
      expr: contract_type
      comment: "Type of talent contract (series regular, guest, overall deal) for cost mix analysis."
    - name: "engagement_role"
      expr: engagement_role
      comment: "Engagement role of the talent under contract for above/below-the-line analysis."
    - name: "guild_affiliation"
      expr: guild_affiliation
      comment: "Guild governing the contract (SAG-AFTRA, WGA, DGA) for compliance and rate analysis."
    - name: "compensation_currency"
      expr: compensation_currency
      comment: "Currency of contract compensation for FX-aware roll-ups."
    - name: "effective_start_month"
      expr: DATE_TRUNC('MONTH', effective_start_date)
      comment: "Month the contract becomes effective for cohort trend analysis."
  measures:
    - name: "contract_count"
      expr: COUNT(1)
      comment: "Number of talent contracts — baseline volume for portfolio sizing."
    - name: "active_talent_count"
      expr: COUNT(DISTINCT talent_profile_id)
      comment: "Distinct talent under contract — headcount of contracted talent for capacity planning."
    - name: "total_base_compensation"
      expr: SUM(CAST(base_compensation_amount AS DOUBLE))
      comment: "Total contracted base compensation — committed talent spend driving budget decisions."
    - name: "avg_base_compensation"
      expr: AVG(CAST(base_compensation_amount AS DOUBLE))
      comment: "Average base compensation per contract — benchmark for deal-making."
    - name: "avg_backend_participation_pct"
      expr: AVG(CAST(backend_participation_percentage AS DOUBLE))
      comment: "Average backend participation percentage — measures profit-sharing exposure."
    - name: "total_step_up_exposure"
      expr: SUM(CAST(step_up_amount AS DOUBLE))
      comment: "Total step-up amounts — future escalation cost exposure across the portfolio."
    - name: "pay_or_play_count"
      expr: COUNT(CASE WHEN pay_or_play_flag = true THEN 1 END)
      comment: "Count of pay-or-play contracts — guaranteed-pay liability requiring reserve planning."
    - name: "gross_participation_count"
      expr: COUNT(CASE WHEN gross_participation_flag = true THEN 1 END)
      comment: "Contracts carrying gross participation — highest-risk backend exposure for Finance."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`talent_participation_statement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Participation accounting KPIs tracking gross receipts, deductions and amounts owed to talent. Critical for residual/participation liability and dispute management."
  source: "`vibe_media_broadcasting_v1`.`talent`.`participation_statement`"
  dimensions:
    - name: "statement_status"
      expr: statement_status
      comment: "Status of the participation statement (issued, paid, disputed) for liability tracking."
    - name: "currency_code"
      expr: currency_code
      comment: "Statement currency for FX-aware financial roll-ups."
    - name: "statement_month"
      expr: DATE_TRUNC('MONTH', statement_date)
      comment: "Statement issue month for participation accrual trend analysis."
  measures:
    - name: "statement_count"
      expr: COUNT(1)
      comment: "Number of participation statements issued — baseline accounting volume."
    - name: "total_gross_receipts"
      expr: SUM(CAST(gross_receipts_amount AS DOUBLE))
      comment: "Total gross receipts reported — top-line basis for participation calculations."
    - name: "total_participation_amount"
      expr: SUM(CAST(participation_amount AS DOUBLE))
      comment: "Total participation owed to talent — direct profit-share liability."
    - name: "total_deductions"
      expr: SUM(CAST(total_deductions AS DOUBLE))
      comment: "Total deductions applied — measures cost recoupment against gross receipts."
    - name: "total_current_payment_due"
      expr: SUM(CAST(current_payment_due_amount AS DOUBLE))
      comment: "Current payment due across statements — near-term cash obligation."
    - name: "disputed_statement_count"
      expr: COUNT(CASE WHEN dispute_flag = true THEN 1 END)
      comment: "Count of disputed statements — flags audit/litigation risk for Business Affairs."
    - name: "avg_participation_amount"
      expr: AVG(CAST(participation_amount AS DOUBLE))
      comment: "Average participation per statement — benchmark for participant payout sizing."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`talent_residual_payment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Residual payment KPIs covering gross residual liability, withholdings and net payouts to guild talent. Used for residual reserve and guild compliance."
  source: "`vibe_media_broadcasting_v1`.`talent`.`residual_payment`"
  dimensions:
    - name: "payment_status"
      expr: payment_status
      comment: "Status of the residual payment (pending, paid, void) for liability tracking."
    - name: "guild_affiliation"
      expr: guild_affiliation
      comment: "Guild associated with the residual for guild-level reporting."
    - name: "use_type"
      expr: use_type
      comment: "Exhibition use type (theatrical, SVOD, broadcast) driving residual formula."
    - name: "payment_currency_code"
      expr: payment_currency_code
      comment: "Currency of the residual payment for FX-aware roll-ups."
    - name: "payment_month"
      expr: DATE_TRUNC('MONTH', payment_date)
      comment: "Month of residual payment for cash-flow trend analysis."
  measures:
    - name: "residual_payment_count"
      expr: COUNT(1)
      comment: "Number of residual payments — baseline processing volume."
    - name: "total_gross_residual"
      expr: SUM(CAST(gross_residual_amount AS DOUBLE))
      comment: "Total gross residual liability — full residual obligation before deductions."
    - name: "total_net_payment"
      expr: SUM(CAST(net_payment_amount AS DOUBLE))
      comment: "Total net residual payout to talent — actual cash disbursed."
    - name: "total_withholding_tax"
      expr: SUM(CAST(withholding_tax_amount AS DOUBLE))
      comment: "Total tax withheld — compliance and remittance tracking."
    - name: "total_pension_health"
      expr: SUM(CAST(pension_health_amount AS DOUBLE))
      comment: "Total pension & health contributions on residuals — guild fund obligation."
    - name: "talent_paid_count"
      expr: COUNT(DISTINCT talent_profile_id)
      comment: "Distinct talent receiving residuals — breadth of residual obligations."
    - name: "avg_net_payment"
      expr: AVG(CAST(net_payment_amount AS DOUBLE))
      comment: "Average net residual per payment — benchmark for payout sizing."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`talent_deferred_compensation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Deferred compensation KPIs tracking outstanding deferred liabilities, accrued interest and remaining balances. Used by Finance for long-term obligation forecasting."
  source: "`vibe_media_broadcasting_v1`.`talent`.`deferred_compensation`"
  dimensions:
    - name: "payment_status"
      expr: payment_status
      comment: "Payment status of deferred comp (accruing, paying, settled) for liability staging."
    - name: "deferral_type"
      expr: deferral_type
      comment: "Type of deferral arrangement for liability classification."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the deferral for FX-aware roll-ups."
    - name: "scheduled_payment_month"
      expr: DATE_TRUNC('MONTH', scheduled_payment_date)
      comment: "Scheduled payout month for cash-flow forecasting."
  measures:
    - name: "deferral_count"
      expr: COUNT(1)
      comment: "Number of deferred compensation arrangements — baseline volume."
    - name: "total_deferred_amount"
      expr: SUM(CAST(deferred_amount AS DOUBLE))
      comment: "Total deferred compensation committed — long-term liability exposure."
    - name: "total_amount_remaining"
      expr: SUM(CAST(amount_remaining AS DOUBLE))
      comment: "Total deferred balance outstanding — unpaid obligation requiring reserve."
    - name: "total_accrued_interest"
      expr: SUM(CAST(accrued_interest_amount AS DOUBLE))
      comment: "Total accrued interest on deferrals — incremental carrying cost."
    - name: "total_amount_paid"
      expr: SUM(CAST(amount_paid AS DOUBLE))
      comment: "Total deferred comp paid to date — settlement progress."
    - name: "triggered_count"
      expr: COUNT(CASE WHEN trigger_met_flag = true THEN 1 END)
      comment: "Deferrals whose payment trigger has been met — imminent payout obligation."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`talent_bonus_trigger`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Performance bonus KPIs tracking contingent bonus exposure and trigger achievement (box-office, viewership, awards). Used to forecast contingent talent cost."
  source: "`vibe_media_broadcasting_v1`.`talent`.`bonus_trigger`"
  dimensions:
    - name: "trigger_type"
      expr: trigger_type
      comment: "Type of bonus trigger (box-office, viewership, award) for exposure segmentation."
    - name: "payment_status"
      expr: payment_status
      comment: "Payment status of the bonus for liability staging."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the bonus amount for FX-aware roll-ups."
    - name: "trigger_metric"
      expr: trigger_metric
      comment: "Metric driving the trigger for performance-condition analysis."
  measures:
    - name: "bonus_trigger_count"
      expr: COUNT(1)
      comment: "Number of bonus triggers defined — baseline contingent obligation volume."
    - name: "total_bonus_exposure"
      expr: SUM(CAST(bonus_amount AS DOUBLE))
      comment: "Total potential bonus payout — maximum contingent cost exposure."
    - name: "triggered_bonus_count"
      expr: COUNT(CASE WHEN is_triggered_flag = true THEN 1 END)
      comment: "Number of bonuses whose threshold has been met — realized contingent liability."
    - name: "avg_threshold_value"
      expr: AVG(CAST(threshold_value AS DOUBLE))
      comment: "Average performance threshold — benchmark for trigger calibration."
    - name: "avg_bonus_percentage"
      expr: AVG(CAST(bonus_percentage AS DOUBLE))
      comment: "Average bonus rate — typical bonus-to-base ratio for deal structuring."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`talent_grievance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Talent grievance & dispute KPIs tracking volume, disputed amounts and settlement cost. Used by Labor Relations and Legal to manage guild risk."
  source: "`vibe_media_broadcasting_v1`.`talent`.`talent_grievance`"
  dimensions:
    - name: "grievance_type"
      expr: grievance_type
      comment: "Type of grievance (residual, credit, working-conditions) for risk categorization."
    - name: "resolution_status"
      expr: resolution_status
      comment: "Resolution status of the grievance for pipeline management."
    - name: "resolution_method"
      expr: resolution_method
      comment: "How the grievance was resolved (arbitration, settlement) for process analysis."
    - name: "filing_month"
      expr: DATE_TRUNC('MONTH', filing_date)
      comment: "Month the grievance was filed for trend monitoring."
  measures:
    - name: "grievance_count"
      expr: COUNT(1)
      comment: "Number of grievances filed — labor-risk volume indicator."
    - name: "total_disputed_amount"
      expr: SUM(CAST(disputed_amount AS DOUBLE))
      comment: "Total amount in dispute — financial exposure from grievances."
    - name: "total_settlement_amount"
      expr: SUM(CAST(settlement_amount AS DOUBLE))
      comment: "Total settlements paid — realized cost of grievance resolution."
    - name: "appeal_count"
      expr: COUNT(CASE WHEN appeal_filed_flag = true THEN 1 END)
      comment: "Grievances that were appealed — escalation/complexity indicator."
    - name: "avg_settlement_amount"
      expr: AVG(CAST(settlement_amount AS DOUBLE))
      comment: "Average settlement value — benchmark for reserve estimation."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`talent_pension_health_contribution`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Guild pension & health contribution KPIs tracking employer/employee contributions, remittance timeliness and reconciliation. Critical for guild fund compliance."
  source: "`vibe_media_broadcasting_v1`.`talent`.`pension_health_contribution`"
  dimensions:
    - name: "contribution_type"
      expr: contribution_type
      comment: "Type of contribution (pension, health) for fund-level reporting."
    - name: "reconciliation_status"
      expr: reconciliation_status
      comment: "Reconciliation status for compliance tracking."
    - name: "guild_fund_name"
      expr: guild_fund_name
      comment: "Guild fund receiving the contribution for remittance reporting."
    - name: "remittance_month"
      expr: DATE_TRUNC('MONTH', remittance_date)
      comment: "Remittance month for contribution trend analysis."
  measures:
    - name: "contribution_count"
      expr: COUNT(1)
      comment: "Number of contribution records — baseline remittance volume."
    - name: "total_contribution"
      expr: SUM(CAST(total_contribution_amount AS DOUBLE))
      comment: "Total pension & health contributions — full guild fund obligation."
    - name: "total_employer_contribution"
      expr: SUM(CAST(employer_contribution_amount AS DOUBLE))
      comment: "Employer-funded contributions — direct company labor cost."
    - name: "total_late_penalty"
      expr: SUM(CAST(late_payment_penalty_amount AS DOUBLE))
      comment: "Late payment penalties incurred — compliance-failure cost indicator."
    - name: "avg_employer_contribution_rate"
      expr: AVG(CAST(employer_contribution_rate AS DOUBLE))
      comment: "Average employer contribution rate — benchmark for cost modeling."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`talent_clearance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Talent rights clearance KPIs tracking clearance throughput, blocking and guild approval status. Used to manage usage-rights risk for content exploitation."
  source: "`vibe_media_broadcasting_v1`.`talent`.`talent_clearance`"
  dimensions:
    - name: "clearance_status"
      expr: clearance_status
      comment: "Status of the clearance (granted, pending, blocked) for pipeline management."
    - name: "clearance_type"
      expr: clearance_type
      comment: "Type of clearance (name, likeness, performance) for rights analysis."
    - name: "priority_level"
      expr: priority_level
      comment: "Priority of the clearance request for SLA management."
    - name: "request_month"
      expr: DATE_TRUNC('MONTH', request_date)
      comment: "Month of clearance request for throughput trend analysis."
  measures:
    - name: "clearance_count"
      expr: COUNT(1)
      comment: "Number of clearance requests — baseline workload volume."
    - name: "blocked_clearance_count"
      expr: COUNT(CASE WHEN blocking_reason IS NOT NULL THEN 1 END)
      comment: "Clearances with a blocking reason — exploitation-risk indicator."
    - name: "exclusivity_conflict_count"
      expr: COUNT(CASE WHEN exclusivity_conflict_flag = true THEN 1 END)
      comment: "Clearances flagged for exclusivity conflict — deal-conflict risk."
    - name: "guild_clearance_required_count"
      expr: COUNT(CASE WHEN guild_clearance_required_flag = true THEN 1 END)
      comment: "Clearances requiring guild sign-off — compliance workload indicator."
    - name: "residual_triggering_count"
      expr: COUNT(CASE WHEN residual_payment_triggered_flag = true THEN 1 END)
      comment: "Clearances that trigger residual payments — downstream cost driver."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`talent_endorsement_deal`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Talent endorsement deal KPIs tracking deal value, commission and exclusivity. Used by commercial teams to steer talent monetization."
  source: "`vibe_media_broadcasting_v1`.`talent`.`endorsement_deal`"
  dimensions:
    - name: "deal_status"
      expr: deal_status
      comment: "Status of the endorsement deal for pipeline management."
    - name: "deal_currency_code"
      expr: deal_currency_code
      comment: "Currency of the deal value for FX-aware roll-ups."
    - name: "usage_territory"
      expr: usage_territory
      comment: "Territory scope of the endorsement for geographic analysis."
    - name: "contract_start_month"
      expr: DATE_TRUNC('MONTH', contract_start_date)
      comment: "Deal start month for revenue cohort analysis."
  measures:
    - name: "endorsement_deal_count"
      expr: COUNT(1)
      comment: "Number of endorsement deals — baseline commercial volume."
    - name: "total_deal_value"
      expr: SUM(CAST(deal_value_amount AS DOUBLE))
      comment: "Total endorsement deal value — talent monetization revenue."
    - name: "avg_deal_value"
      expr: AVG(CAST(deal_value_amount AS DOUBLE))
      comment: "Average endorsement deal size — benchmark for deal-making."
    - name: "avg_commission_rate"
      expr: AVG(CAST(commission_rate AS DOUBLE))
      comment: "Average commission rate — agency/intermediary cost benchmark."
    - name: "renewable_deal_count"
      expr: COUNT(CASE WHEN renewal_option_flag = true THEN 1 END)
      comment: "Deals with renewal options — future revenue continuity pipeline."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`talent_contract_option`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Contract option KPIs tracking option exercise rates, fees and step-up exposure. Used by Business Affairs to manage talent retention and cost escalation."
  source: "`vibe_media_broadcasting_v1`.`talent`.`contract_option`"
  dimensions:
    - name: "exercise_status"
      expr: exercise_status
      comment: "Status of the option (exercised, lapsed, pending) for decision tracking."
    - name: "option_type"
      expr: option_type
      comment: "Type of option for portfolio classification."
    - name: "option_fee_currency"
      expr: option_fee_currency
      comment: "Currency of the option fee for FX-aware roll-ups."
    - name: "window_end_month"
      expr: DATE_TRUNC('MONTH', option_window_end_date)
      comment: "Option window close month for exercise-deadline monitoring."
  measures:
    - name: "option_count"
      expr: COUNT(1)
      comment: "Number of contract options — baseline portfolio volume."
    - name: "total_exercise_compensation"
      expr: SUM(CAST(exercise_compensation_amount AS DOUBLE))
      comment: "Total compensation triggered by exercising options — cost-of-retention exposure."
    - name: "total_option_fees"
      expr: SUM(CAST(option_fee_amount AS DOUBLE))
      comment: "Total option fees — cost of holding talent rights."
    - name: "avg_step_up_percentage"
      expr: AVG(CAST(compensation_step_up_percentage AS DOUBLE))
      comment: "Average compensation step-up on exercise — escalation benchmark."
    - name: "performance_triggered_count"
      expr: COUNT(CASE WHEN performance_trigger_met_flag = true THEN 1 END)
      comment: "Options with performance triggers met — likely exercise candidates."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`talent_appearance_schedule`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Key operational KPIs for talent appearance scheduling: volume, time commitment, and exclusivity conflicts"
  source: "`vibe_media_broadcasting_v1`.`talent`.`appearance_schedule`"
  dimensions:
    - name: "appearance_type"
      expr: appearance_type
      comment: "Category of appearance (e.g., interview, performance, cameo)"
    - name: "daypart"
      expr: daypart
      comment: "Daypart of the scheduled appearance (e.g., prime, daytime, late night)"
    - name: "call_date_month"
      expr: DATE_TRUNC('month', call_date)
      comment: "Month of the call date for time‑based trend analysis"
  measures:
    - name: "total_estimated_hours"
      expr: SUM(CAST(estimated_duration_hours AS DOUBLE))
      comment: "Sum of all estimated duration hours for scheduled talent appearances"
    - name: "total_actual_hours"
      expr: SUM(CAST(actual_duration_hours AS DOUBLE))
      comment: "Sum of all actual duration hours recorded for talent appearances"
    - name: "appearance_count"
      expr: COUNT(1)
      comment: "Number of appearance schedule records (i.e., total scheduled appearances)"
    - name: "exclusivity_conflict_appearances"
      expr: SUM(CASE WHEN exclusivity_conflict_flag THEN 1 ELSE 0 END)
      comment: "Count of appearances that triggered an exclusivity conflict"
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`talent_role`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Performance and cost view of talent roles and credits"
  source: "`vibe_media_broadcasting_v1`.`talent`.`role`"
  dimensions:
    - name: "role_name"
      expr: role_name
      comment: "Descriptive name of the role (e.g., Lead Actor, Supporting)"
    - name: "credit_type"
      expr: credit_type
      comment: "Type of credit (e.g., On‑Screen, End‑Credit)"
  measures:
    - name: "total_role_compensation"
      expr: SUM(CAST(compensation_amount AS DOUBLE))
      comment: "Total compensation paid for talent roles/credits"
    - name: "total_screen_time_minutes"
      expr: SUM(CAST(screen_time_minutes AS DOUBLE))
      comment: "Aggregate screen time across all role records"
    - name: "average_compensation_per_role"
      expr: AVG(CAST(compensation_amount AS DOUBLE))
      comment: "Average compensation per role instance"
$$;