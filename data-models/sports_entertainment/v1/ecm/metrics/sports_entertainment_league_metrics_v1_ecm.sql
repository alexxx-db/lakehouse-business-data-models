-- Metric views for domain: league | Business: Sports Entertainment | Version: 1 | Generated on: 2026-05-09 01:35:39

CREATE OR REPLACE VIEW `sports_entertainment_ecm`.`_metrics`.`league_salary_cap`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Salary cap compliance and financial health metrics for franchises, tracking cap space, luxury tax exposure, and payroll efficiency"
  source: "`sports_entertainment_ecm`.`league`.`salary_cap`"
  dimensions:
    - name: "cap_year"
      expr: cap_year
      comment: "Salary cap year for temporal analysis"
    - name: "cap_type"
      expr: cap_type
      comment: "Type of salary cap (hard, soft, luxury tax)"
    - name: "compliance_status"
      expr: compliance_status
      comment: "Current compliance status (compliant, warning, violation)"
    - name: "luxury_tax_repeater_flag"
      expr: luxury_tax_repeater_flag
      comment: "Whether franchise is a repeat luxury tax payer"
    - name: "record_type"
      expr: record_type
      comment: "Type of salary cap record (snapshot, final, projection)"
    - name: "snapshot_month"
      expr: DATE_TRUNC('MONTH', snapshot_timestamp)
      comment: "Month of salary cap snapshot for trend analysis"
  measures:
    - name: "total_hard_cap_amount"
      expr: SUM(CAST(hard_cap_amount AS DOUBLE))
      comment: "Total hard salary cap ceiling across all franchises"
    - name: "total_active_payroll"
      expr: SUM(CAST(active_payroll_amount AS DOUBLE))
      comment: "Total active player payroll across franchises"
    - name: "total_cap_space_remaining"
      expr: SUM(CAST(cap_space_remaining AS DOUBLE))
      comment: "Total remaining salary cap space available for signings"
    - name: "total_luxury_tax_liability"
      expr: SUM(CAST(luxury_tax_liability AS DOUBLE))
      comment: "Total luxury tax liability owed by franchises"
    - name: "avg_cap_utilization_pct"
      expr: AVG(CAST(active_payroll_amount AS DOUBLE) / NULLIF(CAST(hard_cap_amount AS DOUBLE), 0) * 100.0)
      comment: "Average percentage of salary cap utilized by franchises"
    - name: "total_dead_cap_amount"
      expr: SUM(CAST(dead_cap_amount AS DOUBLE))
      comment: "Total dead cap charges from released or traded players"
    - name: "franchise_count"
      expr: COUNT(DISTINCT franchise_id)
      comment: "Number of unique franchises in salary cap records"
    - name: "luxury_tax_payer_count"
      expr: COUNT(DISTINCT CASE WHEN luxury_tax_liability > 0 THEN franchise_id END)
      comment: "Number of franchises paying luxury tax"
    - name: "avg_luxury_tax_per_payer"
      expr: AVG(CASE WHEN luxury_tax_liability > 0 THEN CAST(luxury_tax_liability AS DOUBLE) END)
      comment: "Average luxury tax liability among franchises that owe tax"
$$;


CREATE OR REPLACE VIEW `sports_entertainment_ecm`.`_metrics`.`league_game_result`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Game outcome and attendance metrics for competitive analysis, venue performance, and fan engagement"
  source: "`sports_entertainment_ecm`.`league`.`game_result`"
  dimensions:
    - name: "game_date"
      expr: game_date
      comment: "Date of game for temporal analysis"
    - name: "game_month"
      expr: DATE_TRUNC('MONTH', game_date)
      comment: "Month of game for seasonal trend analysis"
    - name: "competition_phase"
      expr: competition_phase
      comment: "Phase of competition (regular season, playoffs, finals)"
    - name: "result_type"
      expr: result_type
      comment: "Type of result (regulation, overtime, shootout)"
    - name: "is_neutral_site"
      expr: is_neutral_site
      comment: "Whether game was played at neutral venue"
    - name: "is_draw"
      expr: is_draw
      comment: "Whether game ended in a draw"
    - name: "weather_condition"
      expr: weather_condition
      comment: "Weather conditions during game"
    - name: "competitive_integrity_flag"
      expr: competitive_integrity_flag
      comment: "Flag indicating competitive integrity concerns"
  measures:
    - name: "total_games"
      expr: COUNT(1)
      comment: "Total number of games played"
    - name: "total_attendance"
      expr: SUM(CAST(official_attendance AS BIGINT))
      comment: "Total fan attendance across all games"
    - name: "avg_attendance_per_game"
      expr: AVG(CAST(official_attendance AS BIGINT))
      comment: "Average attendance per game"
    - name: "avg_venue_capacity_utilization_pct"
      expr: AVG(CAST(official_attendance AS DOUBLE) / NULLIF(CAST(venue_capacity AS DOUBLE), 0) * 100.0)
      comment: "Average percentage of venue capacity filled"
    - name: "overtime_game_count"
      expr: COUNT(CASE WHEN overtime_periods_played > 0 THEN 1 END)
      comment: "Number of games that went to overtime"
    - name: "overtime_rate_pct"
      expr: COUNT(CASE WHEN overtime_periods_played > 0 THEN 1 END) * 100.0 / NULLIF(COUNT(1), 0)
      comment: "Percentage of games requiring overtime"
    - name: "competitive_integrity_incident_count"
      expr: COUNT(CASE WHEN competitive_integrity_flag = TRUE THEN 1 END)
      comment: "Number of games with competitive integrity concerns"
    - name: "unique_venues"
      expr: COUNT(DISTINCT venue_id)
      comment: "Number of unique venues hosting games"
$$;


CREATE OR REPLACE VIEW `sports_entertainment_ecm`.`_metrics`.`league_trade_transaction`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Trade activity and financial impact metrics for franchise strategy analysis and competitive balance monitoring"
  source: "`sports_entertainment_ecm`.`league`.`trade_transaction`"
  dimensions:
    - name: "transaction_date"
      expr: transaction_date
      comment: "Date of trade transaction"
    - name: "transaction_month"
      expr: DATE_TRUNC('MONTH', transaction_date)
      comment: "Month of trade for temporal trend analysis"
    - name: "season_year"
      expr: season_year
      comment: "Season year of trade"
    - name: "transaction_type"
      expr: transaction_type
      comment: "Type of transaction (trade, waiver, free agent)"
    - name: "transaction_status"
      expr: transaction_status
      comment: "Status of transaction (pending, approved, rejected, voided)"
    - name: "cba_compliance_status"
      expr: cba_compliance_status
      comment: "CBA compliance status of transaction"
    - name: "competitive_integrity_review_flag"
      expr: competitive_integrity_review_flag
      comment: "Whether transaction required competitive integrity review"
    - name: "trade_deadline_exception_flag"
      expr: trade_deadline_exception_flag
      comment: "Whether transaction was granted trade deadline exception"
  measures:
    - name: "total_trades"
      expr: COUNT(1)
      comment: "Total number of trade transactions"
    - name: "total_cash_consideration"
      expr: SUM(CAST(cash_consideration_amount AS DOUBLE))
      comment: "Total cash consideration exchanged in trades"
    - name: "avg_cash_per_trade"
      expr: AVG(CAST(cash_consideration_amount AS DOUBLE))
      comment: "Average cash consideration per trade"
    - name: "total_salary_obligation_transferred"
      expr: SUM(CAST(salary_obligation_transferred_amount AS DOUBLE))
      comment: "Total salary obligations transferred in trades"
    - name: "avg_salary_cap_impact_acquiring"
      expr: AVG(CAST(salary_cap_impact_acquiring AS DOUBLE))
      comment: "Average salary cap impact for acquiring franchises"
    - name: "trades_with_cash_count"
      expr: COUNT(CASE WHEN cash_consideration_amount > 0 THEN 1 END)
      comment: "Number of trades involving cash consideration"
    - name: "trades_with_cash_pct"
      expr: COUNT(CASE WHEN cash_consideration_amount > 0 THEN 1 END) * 100.0 / NULLIF(COUNT(1), 0)
      comment: "Percentage of trades involving cash"
    - name: "rejected_trade_count"
      expr: COUNT(CASE WHEN transaction_status = 'rejected' THEN 1 END)
      comment: "Number of rejected trade transactions"
    - name: "voided_trade_count"
      expr: COUNT(CASE WHEN transaction_status = 'voided' THEN 1 END)
      comment: "Number of voided trade transactions"
    - name: "unique_acquiring_franchises"
      expr: COUNT(DISTINCT franchise_id)
      comment: "Number of unique franchises acquiring assets"
$$;


CREATE OR REPLACE VIEW `sports_entertainment_ecm`.`_metrics`.`league_disciplinary_action`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Disciplinary enforcement and compliance metrics for league integrity monitoring and financial impact analysis"
  source: "`sports_entertainment_ecm`.`league`.`disciplinary_action`"
  dimensions:
    - name: "incident_date"
      expr: incident_date
      comment: "Date of disciplinary incident"
    - name: "incident_month"
      expr: DATE_TRUNC('MONTH', incident_date)
      comment: "Month of incident for trend analysis"
    - name: "infraction_type"
      expr: infraction_type
      comment: "Type of infraction committed"
    - name: "infraction_category"
      expr: infraction_category
      comment: "Category of infraction (conduct, performance, integrity)"
    - name: "action_status"
      expr: action_status
      comment: "Status of disciplinary action (pending, upheld, overturned)"
    - name: "appeal_status"
      expr: appeal_status
      comment: "Status of appeal process"
    - name: "is_ped_related"
      expr: is_ped_related
      comment: "Whether infraction is performance-enhancing drug related"
    - name: "is_game_integrity_related"
      expr: is_game_integrity_related
      comment: "Whether infraction relates to game integrity"
    - name: "repeat_offender"
      expr: repeat_offender
      comment: "Whether subject is a repeat offender"
  measures:
    - name: "total_disciplinary_actions"
      expr: COUNT(1)
      comment: "Total number of disciplinary actions taken"
    - name: "total_fine_amount"
      expr: SUM(CAST(fine_amount AS DOUBLE))
      comment: "Total fines levied across all actions"
    - name: "avg_fine_amount"
      expr: AVG(CAST(fine_amount AS DOUBLE))
      comment: "Average fine amount per disciplinary action"
    - name: "total_fine_paid"
      expr: SUM(CAST(fine_paid_amount AS DOUBLE))
      comment: "Total fines actually paid"
    - name: "fine_collection_rate_pct"
      expr: SUM(CAST(fine_paid_amount AS DOUBLE)) * 100.0 / NULLIF(SUM(CAST(fine_amount AS DOUBLE)), 0)
      comment: "Percentage of fines collected vs levied"
    - name: "total_suspension_games"
      expr: SUM(CAST(suspension_games AS BIGINT))
      comment: "Total games suspended across all actions"
    - name: "avg_suspension_games"
      expr: AVG(CAST(suspension_games AS BIGINT))
      comment: "Average suspension length in games"
    - name: "ped_violation_count"
      expr: COUNT(CASE WHEN is_ped_related = TRUE THEN 1 END)
      comment: "Number of performance-enhancing drug violations"
    - name: "game_integrity_violation_count"
      expr: COUNT(CASE WHEN is_game_integrity_related = TRUE THEN 1 END)
      comment: "Number of game integrity violations"
    - name: "repeat_offender_count"
      expr: COUNT(CASE WHEN repeat_offender = TRUE THEN 1 END)
      comment: "Number of actions against repeat offenders"
    - name: "appeal_filed_count"
      expr: COUNT(CASE WHEN appeal_filed_date IS NOT NULL THEN 1 END)
      comment: "Number of disciplinary actions appealed"
    - name: "appeal_rate_pct"
      expr: COUNT(CASE WHEN appeal_filed_date IS NOT NULL THEN 1 END) * 100.0 / NULLIF(COUNT(1), 0)
      comment: "Percentage of actions that were appealed"
$$;


CREATE OR REPLACE VIEW `sports_entertainment_ecm`.`_metrics`.`league_draft`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Draft event execution and talent acquisition metrics for league operations and franchise strategy"
  source: "`sports_entertainment_ecm`.`league`.`draft`"
  dimensions:
    - name: "draft_date"
      expr: draft_date
      comment: "Date of draft event"
    - name: "draft_year"
      expr: year
      comment: "Year of draft"
    - name: "draft_status"
      expr: draft_status
      comment: "Status of draft (scheduled, in progress, completed)"
    - name: "sport"
      expr: sport
      comment: "Sport type for draft"
    - name: "format"
      expr: format
      comment: "Draft format (snake, linear, lottery)"
    - name: "lottery_conducted"
      expr: lottery_conducted
      comment: "Whether draft lottery was conducted"
    - name: "fan_attendance_allowed"
      expr: fan_attendance_allowed
      comment: "Whether fans were allowed to attend"
    - name: "supplemental_draft"
      expr: supplemental_draft
      comment: "Whether this is a supplemental draft"
  measures:
    - name: "total_drafts"
      expr: COUNT(1)
      comment: "Total number of draft events"
    - name: "total_picks_completed"
      expr: SUM(CAST(picks_completed AS BIGINT))
      comment: "Total draft picks completed across all drafts"
    - name: "avg_picks_per_draft"
      expr: AVG(CAST(picks_completed AS BIGINT))
      comment: "Average number of picks per draft"
    - name: "total_trades_executed"
      expr: SUM(CAST(trades_executed AS BIGINT))
      comment: "Total trades executed during drafts"
    - name: "avg_trades_per_draft"
      expr: AVG(CAST(trades_executed AS BIGINT))
      comment: "Average trades per draft event"
    - name: "total_attendance"
      expr: SUM(CAST(actual_attendance AS BIGINT))
      comment: "Total fan attendance across all drafts"
    - name: "avg_attendance_per_draft"
      expr: AVG(CAST(actual_attendance AS BIGINT))
      comment: "Average fan attendance per draft"
    - name: "drafts_with_lottery_count"
      expr: COUNT(CASE WHEN lottery_conducted = TRUE THEN 1 END)
      comment: "Number of drafts with lottery conducted"
    - name: "unique_leagues"
      expr: COUNT(DISTINCT league_id)
      comment: "Number of unique leagues conducting drafts"
$$;


CREATE OR REPLACE VIEW `sports_entertainment_ecm`.`_metrics`.`league_standing`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Competitive standings and performance metrics for franchise evaluation and playoff qualification tracking"
  source: "`sports_entertainment_ecm`.`league`.`standing`"
  dimensions:
    - name: "snapshot_date"
      expr: snapshot_date
      comment: "Date of standings snapshot"
    - name: "standings_type"
      expr: standings_type
      comment: "Type of standings (regular season, playoff, overall)"
    - name: "standing_status"
      expr: standing_status
      comment: "Status of standing record (active, final, historical)"
    - name: "clinch_indicator"
      expr: clinch_indicator
      comment: "Playoff clinch status (x=clinched, e=eliminated)"
    - name: "current_streak_type"
      expr: current_streak_type
      comment: "Type of current streak (W=winning, L=losing)"
  measures:
    - name: "total_games_played"
      expr: SUM(CAST(games_played AS BIGINT))
      comment: "Total games played across all franchises"
    - name: "total_wins"
      expr: SUM(CAST(wins AS BIGINT))
      comment: "Total wins across all franchises"
    - name: "total_losses"
      expr: SUM(CAST(losses AS BIGINT))
      comment: "Total losses across all franchises"
    - name: "avg_win_pct"
      expr: AVG(CAST(win_pct AS DOUBLE))
      comment: "Average winning percentage across franchises"
    - name: "total_runs_scored"
      expr: SUM(CAST(runs_scored AS BIGINT))
      comment: "Total runs/points scored across all franchises"
    - name: "total_runs_allowed"
      expr: SUM(CAST(runs_allowed AS BIGINT))
      comment: "Total runs/points allowed across all franchises"
    - name: "avg_run_differential"
      expr: AVG(CAST(run_differential AS BIGINT))
      comment: "Average run/point differential per franchise"
    - name: "avg_home_win_pct"
      expr: AVG(CAST(home_wins AS DOUBLE) / NULLIF(CAST(home_wins AS DOUBLE) + CAST(home_losses AS DOUBLE), 0))
      comment: "Average home winning percentage"
    - name: "avg_away_win_pct"
      expr: AVG(CAST(away_wins AS DOUBLE) / NULLIF(CAST(away_wins AS DOUBLE) + CAST(away_losses AS DOUBLE), 0))
      comment: "Average away winning percentage"
    - name: "franchises_in_standings"
      expr: COUNT(DISTINCT franchise_id)
      comment: "Number of franchises in standings"
$$;
