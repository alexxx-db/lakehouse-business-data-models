-- Metric views for domain: athlete | Business: Sports Entertainment | Version: 1 | Generated on: 2026-05-09 01:35:39

CREATE OR REPLACE VIEW `sports_entertainment_ecm`.`_metrics`.`athlete_contract`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Contract value, cap impact, and guaranteed compensation metrics for athlete contracts"
  source: "`sports_entertainment_ecm`.`athlete`.`athlete_contract`"
  dimensions:
    - name: "contract_status"
      expr: contract_status
      comment: "Current status of the athlete contract"
    - name: "contract_type"
      expr: contract_type
      comment: "Type of contract (e.g., standard, rookie, veteran)"
    - name: "contract_year"
      expr: YEAR(start_date)
      comment: "Year the contract started"
    - name: "free_agency_class"
      expr: free_agency_class
      comment: "Free agency classification of the contract"
    - name: "roster_status"
      expr: roster_status
      comment: "Roster status associated with the contract"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which contract values are denominated"
    - name: "has_no_trade_clause"
      expr: no_trade_clause
      comment: "Whether contract includes a no-trade clause"
    - name: "has_performance_bonus"
      expr: performance_bonus_eligible
      comment: "Whether contract is eligible for performance bonuses"
  measures:
    - name: "total_contract_count"
      expr: COUNT(1)
      comment: "Total number of athlete contracts"
    - name: "total_contract_value"
      expr: SUM(CAST(total_value AS DOUBLE))
      comment: "Sum of all contract total values"
    - name: "total_guaranteed_amount"
      expr: SUM(CAST(guaranteed_amount AS DOUBLE))
      comment: "Sum of all guaranteed contract amounts"
    - name: "total_cap_hit"
      expr: SUM(CAST(cap_hit AS DOUBLE))
      comment: "Sum of all salary cap hits"
    - name: "total_signing_bonus"
      expr: SUM(CAST(signing_bonus AS DOUBLE))
      comment: "Sum of all signing bonuses paid"
    - name: "total_dead_cap"
      expr: SUM(CAST(dead_cap_amount AS DOUBLE))
      comment: "Sum of all dead cap amounts"
    - name: "avg_contract_value"
      expr: AVG(CAST(total_value AS DOUBLE))
      comment: "Average total contract value"
    - name: "avg_aav"
      expr: AVG(CAST(aav AS DOUBLE))
      comment: "Average annual value across all contracts"
    - name: "guaranteed_pct"
      expr: ROUND(100.0 * SUM(CAST(guaranteed_amount AS DOUBLE)) / NULLIF(SUM(CAST(total_value AS DOUBLE)), 0), 2)
      comment: "Percentage of total contract value that is guaranteed"
    - name: "unique_athletes_contracted"
      expr: COUNT(DISTINCT athlete_profile_id)
      comment: "Number of unique athletes with contracts"
$$;

CREATE OR REPLACE VIEW `sports_entertainment_ecm`.`_metrics`.`athlete_nil_agreement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Name, Image, and Likeness (NIL) deal value and compliance metrics"
  source: "`sports_entertainment_ecm`.`athlete`.`nil_agreement`"
  dimensions:
    - name: "agreement_status"
      expr: agreement_status
      comment: "Current status of the NIL agreement"
    - name: "deal_category"
      expr: deal_category
      comment: "Category of the NIL deal"
    - name: "product_category"
      expr: product_category
      comment: "Product category associated with the NIL deal"
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the NIL agreement"
    - name: "cba_compliance_status"
      expr: cba_compliance_status
      comment: "Collective bargaining agreement compliance status"
    - name: "disclosure_status"
      expr: disclosure_status
      comment: "Public disclosure status of the NIL agreement"
    - name: "agreement_year"
      expr: YEAR(effective_date)
      comment: "Year the NIL agreement became effective"
    - name: "has_auto_renewal"
      expr: auto_renewal_flag
      comment: "Whether the agreement includes auto-renewal"
    - name: "has_exclusivity"
      expr: CASE WHEN exclusivity_scope IS NOT NULL THEN TRUE ELSE FALSE END
      comment: "Whether the agreement includes exclusivity terms"
  measures:
    - name: "total_nil_agreements"
      expr: COUNT(1)
      comment: "Total number of NIL agreements"
    - name: "total_nil_deal_value"
      expr: SUM(CAST(deal_value_amount AS DOUBLE))
      comment: "Sum of all NIL deal values"
    - name: "total_nil_annual_value"
      expr: SUM(CAST(annual_value_amount AS DOUBLE))
      comment: "Sum of all NIL annual values"
    - name: "total_nil_incentive_value"
      expr: SUM(CAST(incentive_value_amount AS DOUBLE))
      comment: "Sum of all NIL incentive values"
    - name: "avg_nil_deal_value"
      expr: AVG(CAST(deal_value_amount AS DOUBLE))
      comment: "Average NIL deal value per agreement"
    - name: "unique_athletes_with_nil"
      expr: COUNT(DISTINCT athlete_profile_id)
      comment: "Number of unique athletes with NIL agreements"
    - name: "unique_brand_partners"
      expr: COUNT(DISTINCT brand_partner_sponsor_id)
      comment: "Number of unique brand partners in NIL deals"
$$;

CREATE OR REPLACE VIEW `sports_entertainment_ecm`.`_metrics`.`athlete_injury_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Injury frequency, severity, recovery time, and cost impact metrics"
  source: "`sports_entertainment_ecm`.`athlete`.`injury_record`"
  dimensions:
    - name: "injury_status"
      expr: injury_status
      comment: "Current status of the injury"
    - name: "injury_type"
      expr: injury_type
      comment: "Type of injury sustained"
    - name: "body_part"
      expr: body_part
      comment: "Body part affected by the injury"
    - name: "severity_grade"
      expr: severity_grade
      comment: "Severity grade of the injury"
    - name: "injury_year"
      expr: YEAR(injury_date)
      comment: "Year the injury occurred"
    - name: "injury_month"
      expr: MONTH(injury_date)
      comment: "Month the injury occurred"
    - name: "surgery_required"
      expr: surgery_required
      comment: "Whether surgery was required for the injury"
    - name: "is_recurrence"
      expr: is_recurrence
      comment: "Whether the injury is a recurrence of a prior injury"
    - name: "concussion_protocol"
      expr: concussion_protocol_triggered
      comment: "Whether concussion protocol was triggered"
  measures:
    - name: "total_injuries"
      expr: COUNT(1)
      comment: "Total number of injury records"
    - name: "total_days_lost"
      expr: SUM(CAST(days_lost_actual AS DOUBLE))
      comment: "Sum of all actual days lost to injury"
    - name: "avg_days_lost"
      expr: AVG(CAST(days_lost_actual AS DOUBLE))
      comment: "Average days lost per injury"
    - name: "total_insurance_reserve"
      expr: SUM(CAST(insurance_reserve_amount AS DOUBLE))
      comment: "Sum of all insurance reserve amounts for injuries"
    - name: "avg_recovery_time"
      expr: AVG(CAST(days_lost_estimated AS DOUBLE))
      comment: "Average estimated recovery time in days"
    - name: "unique_injured_athletes"
      expr: COUNT(DISTINCT athlete_profile_id)
      comment: "Number of unique athletes with injury records"
    - name: "surgery_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN surgery_required = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of injuries requiring surgery"
    - name: "recurrence_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN is_recurrence = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of injuries that are recurrences"
$$;

CREATE OR REPLACE VIEW `sports_entertainment_ecm`.`_metrics`.`athlete_performance_stat`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Athlete performance statistics and key performance indicators across games and seasons"
  source: "`sports_entertainment_ecm`.`athlete`.`performance_stat`"
  dimensions:
    - name: "stat_type"
      expr: stat_type
      comment: "Type of performance statistic"
    - name: "stat_status"
      expr: stat_status
      comment: "Status of the statistic record"
    - name: "position_played"
      expr: position_played
      comment: "Position played during the performance"
    - name: "sport_discipline"
      expr: sport_discipline
      comment: "Sport discipline for the performance"
    - name: "stat_year"
      expr: YEAR(stat_date)
      comment: "Year of the performance statistic"
    - name: "stat_month"
      expr: MONTH(stat_date)
      comment: "Month of the performance statistic"
    - name: "is_home_game"
      expr: is_home_game
      comment: "Whether the performance was in a home game"
  measures:
    - name: "total_performances"
      expr: COUNT(1)
      comment: "Total number of performance records"
    - name: "total_games_played"
      expr: SUM(CAST(games_played AS DOUBLE))
      comment: "Sum of all games played"
    - name: "total_points_scored"
      expr: SUM(CAST(points_scored AS DOUBLE))
      comment: "Sum of all points scored"
    - name: "total_goals"
      expr: SUM(CAST(goals AS DOUBLE))
      comment: "Sum of all goals scored"
    - name: "total_assists"
      expr: SUM(CAST(assists AS DOUBLE))
      comment: "Sum of all assists"
    - name: "total_minutes_played"
      expr: SUM(CAST(minutes_played AS DOUBLE))
      comment: "Sum of all minutes played"
    - name: "avg_points_per_game"
      expr: AVG(CAST(points_scored AS DOUBLE))
      comment: "Average points scored per performance record"
    - name: "avg_field_goal_pct"
      expr: AVG(CAST(field_goal_percentage AS DOUBLE))
      comment: "Average field goal percentage"
    - name: "avg_batting_average"
      expr: AVG(CAST(batting_average AS DOUBLE))
      comment: "Average batting average across performances"
    - name: "unique_athletes_performing"
      expr: COUNT(DISTINCT athlete_profile_id)
      comment: "Number of unique athletes with performance records"
$$;

CREATE OR REPLACE VIEW `sports_entertainment_ecm`.`_metrics`.`athlete_salary_cap_entry`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Salary cap utilization, cap hit, and dead cap metrics for roster management"
  source: "`sports_entertainment_ecm`.`athlete`.`salary_cap_entry`"
  dimensions:
    - name: "entry_status"
      expr: entry_status
      comment: "Status of the salary cap entry"
    - name: "entry_type"
      expr: entry_type
      comment: "Type of salary cap entry"
    - name: "cap_year"
      expr: cap_year
      comment: "Salary cap year"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the salary cap entry"
    - name: "is_dead_cap"
      expr: is_dead_cap
      comment: "Whether the entry is dead cap"
    - name: "is_cap_hold"
      expr: is_cap_hold
      comment: "Whether the entry is a cap hold"
    - name: "is_restructured"
      expr: is_restructured
      comment: "Whether the contract was restructured"
    - name: "void_year_flag"
      expr: void_year_flag
      comment: "Whether the entry is a void year"
  measures:
    - name: "total_cap_entries"
      expr: COUNT(1)
      comment: "Total number of salary cap entries"
    - name: "total_cap_hit"
      expr: SUM(CAST(cap_hit AS DOUBLE))
      comment: "Sum of all salary cap hits"
    - name: "total_base_salary"
      expr: SUM(CAST(base_salary AS DOUBLE))
      comment: "Sum of all base salaries"
    - name: "total_dead_cap_value"
      expr: SUM(CAST(dead_cap_value AS DOUBLE))
      comment: "Sum of all dead cap values"
    - name: "total_cap_hold_amount"
      expr: SUM(CAST(cap_hold_amount AS DOUBLE))
      comment: "Sum of all cap hold amounts"
    - name: "total_signing_bonus_prorated"
      expr: SUM(CAST(signing_bonus_prorated AS DOUBLE))
      comment: "Sum of all prorated signing bonuses"
    - name: "total_likely_incentives"
      expr: SUM(CAST(likely_incentive_amount AS DOUBLE))
      comment: "Sum of all likely incentive amounts"
    - name: "avg_cap_hit"
      expr: AVG(CAST(cap_hit AS DOUBLE))
      comment: "Average salary cap hit per entry"
    - name: "dead_cap_pct"
      expr: ROUND(100.0 * SUM(CAST(dead_cap_value AS DOUBLE)) / NULLIF(SUM(CAST(cap_hit AS DOUBLE)), 0), 2)
      comment: "Percentage of cap hit that is dead cap"
    - name: "unique_athletes_on_cap"
      expr: COUNT(DISTINCT athlete_profile_id)
      comment: "Number of unique athletes with salary cap entries"
$$;

CREATE OR REPLACE VIEW `sports_entertainment_ecm`.`_metrics`.`athlete_draft_selection`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Draft pick value, signing efficiency, and talent acquisition metrics"
  source: "`sports_entertainment_ecm`.`athlete`.`draft_selection`"
  dimensions:
    - name: "selection_status"
      expr: selection_status
      comment: "Status of the draft selection"
    - name: "pick_type"
      expr: pick_type
      comment: "Type of draft pick"
    - name: "draft_year"
      expr: draft_year
      comment: "Year of the draft"
    - name: "round_number"
      expr: round_number
      comment: "Round number of the draft pick"
    - name: "athlete_position"
      expr: athlete_position
      comment: "Position of the drafted athlete"
    - name: "is_compensatory_pick"
      expr: is_compensatory_pick
      comment: "Whether the pick is a compensatory pick"
    - name: "is_traded_pick"
      expr: is_traded_pick
      comment: "Whether the pick was traded"
    - name: "medical_clearance_status"
      expr: medical_clearance_status
      comment: "Medical clearance status of the drafted athlete"
  measures:
    - name: "total_draft_selections"
      expr: COUNT(1)
      comment: "Total number of draft selections"
    - name: "total_signing_slot_value"
      expr: SUM(CAST(signing_slot_value AS DOUBLE))
      comment: "Sum of all signing slot values"
    - name: "total_actual_signing_bonus"
      expr: SUM(CAST(actual_signing_bonus AS DOUBLE))
      comment: "Sum of all actual signing bonuses paid"
    - name: "avg_signing_slot_value"
      expr: AVG(CAST(signing_slot_value AS DOUBLE))
      comment: "Average signing slot value per draft pick"
    - name: "avg_pre_draft_grade"
      expr: AVG(CAST(pre_draft_grade AS DOUBLE))
      comment: "Average pre-draft grade of selected athletes"
    - name: "signing_efficiency_pct"
      expr: ROUND(100.0 * SUM(CAST(actual_signing_bonus AS DOUBLE)) / NULLIF(SUM(CAST(signing_slot_value AS DOUBLE)), 0), 2)
      comment: "Percentage of slot value actually paid in signing bonuses"
    - name: "unique_drafted_athletes"
      expr: COUNT(DISTINCT athlete_profile_id)
      comment: "Number of unique athletes drafted"
    - name: "unique_drafting_franchises"
      expr: COUNT(DISTINCT franchise_id)
      comment: "Number of unique franchises making draft selections"
$$;

CREATE OR REPLACE VIEW `sports_entertainment_ecm`.`_metrics`.`athlete_suspension_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Suspension frequency, duration, financial penalty, and compliance violation metrics"
  source: "`sports_entertainment_ecm`.`athlete`.`suspension_record`"
  dimensions:
    - name: "suspension_status"
      expr: suspension_status
      comment: "Current status of the suspension"
    - name: "suspension_type"
      expr: suspension_type
      comment: "Type of suspension"
    - name: "violation_category"
      expr: violation_category
      comment: "Category of the violation leading to suspension"
    - name: "appeal_status"
      expr: appeal_status
      comment: "Status of any appeal filed"
    - name: "issuing_authority"
      expr: issuing_authority
      comment: "Authority that issued the suspension"
    - name: "suspension_year"
      expr: YEAR(issued_date)
      comment: "Year the suspension was issued"
    - name: "is_indefinite"
      expr: is_indefinite
      comment: "Whether the suspension is indefinite"
    - name: "is_lifetime_ban"
      expr: is_lifetime_ban
      comment: "Whether the suspension is a lifetime ban"
  measures:
    - name: "total_suspensions"
      expr: COUNT(1)
      comment: "Total number of suspension records"
    - name: "total_suspension_days"
      expr: SUM(CAST(suspension_length_days AS DOUBLE))
      comment: "Sum of all suspension lengths in days"
    - name: "total_suspension_games"
      expr: SUM(CAST(suspension_length_games AS DOUBLE))
      comment: "Sum of all suspension lengths in games"
    - name: "total_financial_penalty"
      expr: SUM(CAST(financial_penalty_amount AS DOUBLE))
      comment: "Sum of all financial penalties assessed"
    - name: "total_salary_withheld"
      expr: SUM(CAST(salary_withheld_amount AS DOUBLE))
      comment: "Sum of all salary amounts withheld due to suspension"
    - name: "avg_suspension_days"
      expr: AVG(CAST(suspension_length_days AS DOUBLE))
      comment: "Average suspension length in days"
    - name: "avg_financial_penalty"
      expr: AVG(CAST(financial_penalty_amount AS DOUBLE))
      comment: "Average financial penalty per suspension"
    - name: "unique_suspended_athletes"
      expr: COUNT(DISTINCT athlete_profile_id)
      comment: "Number of unique athletes with suspension records"
    - name: "appeal_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN appeal_filed_date IS NOT NULL THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of suspensions that were appealed"
$$;

CREATE OR REPLACE VIEW `sports_entertainment_ecm`.`_metrics`.`athlete_agency`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Agency revenue, client portfolio, and certification compliance metrics"
  source: "`sports_entertainment_ecm`.`athlete`.`agency`"
  dimensions:
    - name: "agency_type"
      expr: agency_type
      comment: "Type of agency"
    - name: "status"
      expr: agency_status
      comment: "Current status of the agency"
    - name: "certification_status"
      expr: certification_status
      comment: "Certification status of the agency"
    - name: "headquarters_country_code"
      expr: headquarters_country_code
      comment: "Country code of agency headquarters"
    - name: "specialization_sports"
      expr: specialization_sports
      comment: "Sports the agency specializes in"
    - name: "international_operations_flag"
      expr: international_operations_flag
      comment: "Whether the agency operates internationally"
    - name: "nil_services_offered_flag"
      expr: nil_services_offered_flag
      comment: "Whether the agency offers NIL services"
  measures:
    - name: "total_agencies"
      expr: COUNT(1)
      comment: "Total number of agencies"
    - name: "total_annual_revenue"
      expr: SUM(CAST(annual_revenue_usd AS DOUBLE))
      comment: "Sum of all agency annual revenues in USD"
    - name: "total_active_clients"
      expr: SUM(CAST(total_active_clients AS DOUBLE))
      comment: "Sum of all active clients across agencies"
    - name: "total_certified_agents"
      expr: SUM(CAST(certified_agent_count AS DOUBLE))
      comment: "Sum of all certified agents across agencies"
    - name: "total_insurance_coverage"
      expr: SUM(CAST(insurance_coverage_amount AS DOUBLE))
      comment: "Sum of all insurance coverage amounts"
    - name: "avg_annual_revenue"
      expr: AVG(CAST(annual_revenue_usd AS DOUBLE))
      comment: "Average annual revenue per agency in USD"
    - name: "avg_commission_rate"
      expr: AVG(CAST(commission_rate_percentage AS DOUBLE))
      comment: "Average commission rate percentage across agencies"
    - name: "avg_clients_per_agency"
      expr: AVG(CAST(total_active_clients AS DOUBLE))
      comment: "Average number of active clients per agency"
$$;

CREATE OR REPLACE VIEW `sports_entertainment_ecm`.`_metrics`.`athlete_roster`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Roster composition, cap allocation, and player availability metrics"
  source: "`sports_entertainment_ecm`.`athlete`.`roster`"
  dimensions:
    - name: "roster_status"
      expr: roster_status
      comment: "Current roster status of the athlete"
    - name: "position_code"
      expr: position_code
      comment: "Position code of the athlete on the roster"
    - name: "transaction_type"
      expr: transaction_type
      comment: "Type of roster transaction"
    - name: "slot_type"
      expr: slot_type
      comment: "Type of roster slot"
    - name: "nationality_code"
      expr: nationality_code
      comment: "Nationality code of the athlete"
    - name: "is_captain"
      expr: is_captain
      comment: "Whether the athlete is a team captain"
    - name: "international_slot_flag"
      expr: international_slot_flag
      comment: "Whether the roster spot uses an international slot"
    - name: "wada_clearance_status"
      expr: wada_clearance_status
      comment: "WADA clearance status of the athlete"
  measures:
    - name: "total_roster_spots"
      expr: COUNT(1)
      comment: "Total number of roster spots"
    - name: "total_salary_cap_hit"
      expr: SUM(CAST(salary_cap_hit AS DOUBLE))
      comment: "Sum of all salary cap hits on the roster"
    - name: "avg_salary_cap_hit"
      expr: AVG(CAST(salary_cap_hit AS DOUBLE))
      comment: "Average salary cap hit per roster spot"
    - name: "avg_service_years"
      expr: AVG(CAST(service_years AS DOUBLE))
      comment: "Average years of service across roster"
    - name: "unique_athletes_on_roster"
      expr: COUNT(DISTINCT athlete_profile_id)
      comment: "Number of unique athletes on the roster"
    - name: "unique_franchises"
      expr: COUNT(DISTINCT franchise_id)
      comment: "Number of unique franchises with roster records"
    - name: "captain_count"
      expr: SUM(CASE WHEN is_captain = TRUE THEN 1 ELSE 0 END)
      comment: "Number of team captains on roster"
    - name: "international_slot_usage"
      expr: SUM(CASE WHEN international_slot_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of international roster slots in use"
$$;

CREATE OR REPLACE VIEW `sports_entertainment_ecm`.`_metrics`.`athlete_free_agency_status`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Free agency market dynamics, cap holds, and signing activity metrics"
  source: "`sports_entertainment_ecm`.`athlete`.`free_agency_status`"
  dimensions:
    - name: "fa_type"
      expr: fa_type
      comment: "Type of free agency"
    - name: "negotiation_status"
      expr: negotiation_status
      comment: "Current negotiation status"
    - name: "compensation_tier"
      expr: compensation_tier
      comment: "Compensation tier of the free agent"
    - name: "arbitration_eligible_flag"
      expr: arbitration_eligible_flag
      comment: "Whether the athlete is arbitration eligible"
    - name: "right_of_first_refusal_flag"
      expr: right_of_first_refusal_flag
      comment: "Whether right of first refusal applies"
    - name: "player_option_flag"
      expr: player_option_flag
      comment: "Whether the athlete has a player option"
    - name: "wada_clearance_status"
      expr: wada_clearance_status
      comment: "WADA clearance status of the free agent"
  measures:
    - name: "total_free_agents"
      expr: COUNT(1)
      comment: "Total number of free agency status records"
    - name: "total_cap_hold_amount"
      expr: SUM(CAST(cap_hold_amount AS DOUBLE))
      comment: "Sum of all cap hold amounts"
    - name: "total_qualifying_offer_amount"
      expr: SUM(CAST(qualifying_offer_amount AS DOUBLE))
      comment: "Sum of all qualifying offer amounts"
    - name: "total_tender_amount"
      expr: SUM(CAST(tender_amount AS DOUBLE))
      comment: "Sum of all tender amounts"
    - name: "total_franchise_tag_amount"
      expr: SUM(CAST(franchise_tag_amount AS DOUBLE))
      comment: "Sum of all franchise tag amounts"
    - name: "avg_years_of_service"
      expr: AVG(CAST(years_of_service AS DOUBLE))
      comment: "Average years of service for free agents"
    - name: "avg_cap_hold"
      expr: AVG(CAST(cap_hold_amount AS DOUBLE))
      comment: "Average cap hold amount per free agent"
    - name: "unique_free_agent_athletes"
      expr: COUNT(DISTINCT athlete_profile_id)
      comment: "Number of unique athletes in free agency"
    - name: "signing_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN signing_date IS NOT NULL THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of free agents who have signed"
$$;