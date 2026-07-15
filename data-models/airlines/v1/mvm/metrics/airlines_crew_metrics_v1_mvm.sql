-- Metric views for domain: crew | Business: Airlines | Version: 1 | Generated on: 2026-05-07 15:08:57

CREATE OR REPLACE VIEW `airlines_ecm`.`_metrics`.`crew_member`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic workforce analytics for the crew member master — headcount composition, seniority, flight-hour capital, and compliance currency. Used by VP Flight Operations and Chief People Officer to steer hiring, training investment, and regulatory readiness."
  source: "`airlines_ecm`.`crew`.`member`"
  dimensions:
    - name: "crew_category"
      expr: crew_category
      comment: "Crew category (e.g. Flight Deck, Cabin Crew) — primary workforce segmentation axis."
    - name: "crew_position"
      expr: crew_position
      comment: "Crew position code (e.g. Captain, First Officer, Purser) — used to analyse grade-level workforce distribution."
    - name: "employment_status"
      expr: employment_status
      comment: "Current employment status (Active, On Leave, Terminated) — filters operational headcount from historical records."
    - name: "operational_status"
      expr: operational_status
      comment: "Operational readiness status (e.g. Line, Reserve, Grounded) — critical for capacity planning."
    - name: "nationality_code"
      expr: nationality_code
      comment: "ISO nationality code — supports diversity reporting and visa/work-permit compliance tracking."
    - name: "union_membership_flag"
      expr: union_membership_flag
      comment: "Boolean indicating union membership — relevant for collective-agreement cost modelling."
    - name: "hire_year"
      expr: YEAR(date_of_hire)
      comment: "Year of hire — enables cohort analysis of workforce tenure and attrition trends."
    - name: "medical_certificate_class"
      expr: medical_certificate_class
      comment: "Medical certificate class held — used to monitor regulatory compliance across the workforce."
  measures:
    - name: "total_active_crew_members"
      expr: COUNT(CASE WHEN employment_status = 'Active' THEN member_id END)
      comment: "Count of currently active crew members. Baseline headcount KPI used in capacity planning and regulatory minimum-crew compliance checks."
    - name: "total_flight_hours_fleet"
      expr: SUM(CAST(total_flight_hours AS DOUBLE))
      comment: "Aggregate flight hours across all crew members. Represents the total experiential capital of the workforce; used to assess fleet readiness and seniority depth."
    - name: "avg_flight_hours_per_crew"
      expr: AVG(CAST(total_flight_hours AS DOUBLE))
      comment: "Average flight hours per crew member. Indicates workforce experience level; a declining average signals dilution from rapid hiring or attrition of senior crew."
    - name: "crew_members_with_expiring_medical"
      expr: COUNT(CASE WHEN medical_certificate_expiry_date BETWEEN CURRENT_DATE() AND DATE_ADD(CURRENT_DATE(), 90) THEN member_id END)
      comment: "Count of crew members whose medical certificate expires within 90 days. Directly drives regulatory grounding risk; triggers proactive scheduling of medical examinations."
    - name: "crew_members_with_expiring_licence"
      expr: COUNT(CASE WHEN license_expiry_date BETWEEN CURRENT_DATE() AND DATE_ADD(CURRENT_DATE(), 90) THEN member_id END)
      comment: "Count of crew members whose licence expires within 90 days. Prevents last-minute operational disruptions from licence lapses; informs training and renewal scheduling."
    - name: "crew_members_overdue_recurrent_training"
      expr: COUNT(CASE WHEN next_recurrent_training_due_date < CURRENT_DATE() THEN member_id END)
      comment: "Count of crew members past their recurrent training due date. A non-zero value represents a direct regulatory compliance breach and grounds-risk exposure."
    - name: "avg_tenure_years"
      expr: AVG(DATEDIFF(CURRENT_DATE(), date_of_hire) / 365.25)
      comment: "Average workforce tenure in years. Declining tenure signals attrition pressure; used in workforce stability and succession planning discussions."
$$;


CREATE OR REPLACE VIEW `airlines_ecm`.`_metrics`.`crew_pairing`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Pairing efficiency and cost analytics — the primary lens for evaluating crew scheduling quality, fatigue risk, and cost-per-pairing. Used by Director of Crew Planning and CFO to optimise scheduling economics and regulatory compliance."
  source: "`airlines_ecm`.`crew`.`pairing`"
  dimensions:
    - name: "pairing_status"
      expr: pairing_status
      comment: "Current status of the pairing (e.g. Published, Draft, Cancelled) — filters operational pairings from planning artefacts."
    - name: "pairing_type"
      expr: pairing_type
      comment: "Type of pairing (e.g. Standard, Reserve, Training) — enables cost and efficiency benchmarking by pairing category."
    - name: "crew_position"
      expr: crew_position
      comment: "Crew position the pairing is built for (Captain, First Officer, etc.) — supports grade-level cost analysis."
    - name: "international_flag"
      expr: international_flag
      comment: "Boolean indicating whether the pairing crosses international borders — international pairings carry higher per-diem and hotel costs."
    - name: "red_eye_flag"
      expr: red_eye_flag
      comment: "Boolean indicating a red-eye (overnight) pairing — red-eye pairings have elevated fatigue risk and may attract premium pay."
    - name: "premium_pay_flag"
      expr: premium_pay_flag
      comment: "Boolean indicating premium pay applies — used to isolate premium-cost pairings for cost-reduction analysis."
    - name: "legality_status"
      expr: legality_status
      comment: "FTL/FAR legality status of the pairing — non-compliant pairings represent regulatory risk and must be tracked at executive level."
    - name: "cost_currency_code"
      expr: cost_currency_code
      comment: "Currency of pairing cost — required for multi-currency cost consolidation."
    - name: "effective_start_month"
      expr: DATE_TRUNC('MONTH', effective_start_date)
      comment: "Month the pairing becomes effective — enables trend analysis of scheduling costs and efficiency over time."
  measures:
    - name: "total_pairings"
      expr: COUNT(1)
      comment: "Total number of pairings. Baseline volume metric for scheduling throughput and workload assessment."
    - name: "total_pairing_cost"
      expr: SUM(CAST(cost AS DOUBLE))
      comment: "Total direct cost of all pairings. Primary crew cost KPI used in budget vs. actuals reporting and cost-per-ASK calculations."
    - name: "total_hotel_cost"
      expr: SUM(CAST(hotel_cost AS DOUBLE))
      comment: "Total hotel/layover accommodation cost across pairings. A controllable cost lever; benchmarked against preferred-hotel contract savings."
    - name: "total_per_diem_cost"
      expr: SUM(CAST(per_diem_amount AS DOUBLE))
      comment: "Total per-diem allowances paid across pairings. Tracks allowance spend against budget; elevated by international and long-haul pairings."
    - name: "avg_pairing_cost"
      expr: AVG(CAST(cost AS DOUBLE))
      comment: "Average cost per pairing. Benchmarks scheduling efficiency; rising average cost signals suboptimal pairing construction or increased deadhead usage."
    - name: "avg_block_hours_per_pairing"
      expr: AVG(CAST(total_block_hours AS DOUBLE))
      comment: "Average productive block hours per pairing. Higher values indicate better crew utilisation; low values signal inefficient pairings with excessive ground time."
    - name: "avg_time_away_from_base_hours"
      expr: AVG(CAST(time_away_from_base_hours AS DOUBLE))
      comment: "Average time away from base (TAFB) per pairing. Directly drives per-diem and hotel costs; a key lever in pairing optimisation."
    - name: "avg_fatigue_risk_score"
      expr: AVG(CAST(fatigue_risk_score AS DOUBLE))
      comment: "Average fatigue risk score across pairings. Elevated scores indicate systemic scheduling patterns that increase safety risk and regulatory exposure."
    - name: "total_credit_hours"
      expr: SUM(CAST(total_credit_hours AS DOUBLE))
      comment: "Total credited hours across all pairings. Credit hours drive crew pay; comparing credit hours to block hours reveals pay-productivity efficiency."
    - name: "total_block_hours"
      expr: SUM(CAST(total_block_hours AS DOUBLE))
      comment: "Total block hours across all pairings. Represents productive flying time; used to compute cost-per-block-hour and crew utilisation rate."
    - name: "non_compliant_pairings"
      expr: COUNT(CASE WHEN legality_status != 'Compliant' THEN pairing_id END)
      comment: "Count of pairings with a non-compliant legality status. Any non-zero value represents a regulatory breach requiring immediate corrective action."
$$;


CREATE OR REPLACE VIEW `airlines_ecm`.`_metrics`.`crew_duty_period`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Duty period compliance and fatigue analytics — the operational heartbeat of FTL/FAR regulatory monitoring. Used by Safety and Compliance teams and VP Operations to detect systemic fatigue patterns and legality violations before they become incidents."
  source: "`airlines_ecm`.`crew`.`duty_period`"
  dimensions:
    - name: "duty_type"
      expr: duty_type
      comment: "Type of duty period (e.g. Flight Duty, Positioning, Standby) — segments compliance analysis by duty category."
    - name: "legality_status"
      expr: legality_status
      comment: "FTL/FAR legality status of the duty period — the primary compliance dimension for regulatory reporting."
    - name: "fatigue_risk_level"
      expr: fatigue_risk_level
      comment: "Categorical fatigue risk band (Low/Medium/High/Critical) — enables rapid identification of high-risk duty patterns."
    - name: "easa_ftl_compliant_flag"
      expr: easa_ftl_compliant_flag
      comment: "Boolean indicating EASA FTL compliance — mandatory for European operations regulatory reporting."
    - name: "far_117_compliant_flag"
      expr: far_117_compliant_flag
      comment: "Boolean indicating FAR Part 117 compliance — mandatory for US operations regulatory reporting."
    - name: "augmented_crew_flag"
      expr: augmented_crew_flag
      comment: "Boolean indicating augmented crew was used — augmented operations extend FDP limits and affect fatigue modelling."
    - name: "split_duty_flag"
      expr: split_duty_flag
      comment: "Boolean indicating a split duty period — split duties have different rest and FDP limit calculations."
    - name: "actual_flag"
      expr: actual_flag
      comment: "Boolean distinguishing actual vs. scheduled duty periods — filters to actuals for compliance reporting."
    - name: "fdp_start_month"
      expr: DATE_TRUNC('MONTH', fdp_start_time)
      comment: "Month of flight duty period start — enables trend analysis of compliance and fatigue risk over time."
  measures:
    - name: "total_duty_periods"
      expr: COUNT(1)
      comment: "Total number of duty periods. Baseline operational volume metric for workload and scheduling throughput."
    - name: "avg_fatigue_risk_score"
      expr: AVG(CAST(fatigue_risk_score AS DOUBLE))
      comment: "Average fatigue risk score across duty periods. A rising average is a leading safety indicator requiring scheduling intervention."
    - name: "max_fatigue_risk_score"
      expr: MAX(fatigue_risk_score)
      comment: "Maximum fatigue risk score observed. Identifies worst-case duty periods for targeted safety review."
    - name: "non_compliant_duty_periods"
      expr: COUNT(CASE WHEN legality_status != 'Compliant' THEN duty_period_id END)
      comment: "Count of duty periods with legality violations. Directly measures regulatory breach exposure; any non-zero value triggers mandatory reporting to the aviation authority."
    - name: "easa_non_compliant_duty_periods"
      expr: COUNT(CASE WHEN easa_ftl_compliant_flag = FALSE THEN duty_period_id END)
      comment: "Count of duty periods failing EASA FTL compliance. Tracks European regulatory exposure; feeds mandatory authority reporting."
    - name: "far117_non_compliant_duty_periods"
      expr: COUNT(CASE WHEN far_117_compliant_flag = FALSE THEN duty_period_id END)
      comment: "Count of duty periods failing FAR Part 117 compliance. Tracks US regulatory exposure; feeds DOT/FAA mandatory reporting."
    - name: "high_fatigue_risk_duty_periods"
      expr: COUNT(CASE WHEN fatigue_risk_level IN ('High', 'Critical') THEN duty_period_id END)
      comment: "Count of duty periods with High or Critical fatigue risk. A key safety leading indicator; elevated counts require immediate scheduling review."
    - name: "legality_violation_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN legality_status != 'Compliant' THEN duty_period_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of duty periods with legality violations. Normalised compliance rate used in regulatory scorecards and safety management system (SMS) reporting."
$$;


CREATE OR REPLACE VIEW `airlines_ecm`.`_metrics`.`crew_ftl_legality_check`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "FTL legality check outcomes and fatigue limit utilisation analytics. Used by Safety, Compliance, and Crew Control to monitor how close operations run to regulatory limits and to detect systemic fatigue risk patterns."
  source: "`airlines_ecm`.`crew`.`ftl_legality_check`"
  dimensions:
    - name: "fitness_result"
      expr: fitness_result
      comment: "Outcome of the fitness-for-duty assessment (Fit, Unfit, Conditional) — primary compliance outcome dimension."
    - name: "rest_compliance_status"
      expr: rest_compliance_status
      comment: "Rest period compliance status — identifies whether minimum rest requirements were met."
    - name: "fatigue_risk_band"
      expr: fatigue_risk_band
      comment: "Categorical fatigue risk band from the check — enables distribution analysis of risk levels across the operation."
    - name: "check_trigger"
      expr: check_trigger
      comment: "What triggered the legality check (e.g. Scheduled, Ad-hoc, IROP) — distinguishes routine from exception-driven checks."
    - name: "assessment_method"
      expr: assessment_method
      comment: "Method used for the assessment (e.g. Algorithmic, Manual, FRMS) — tracks automation vs. manual override rates."
    - name: "mitigation_applied"
      expr: mitigation_applied
      comment: "Fatigue mitigation measure applied (e.g. Additional Rest, Augmented Crew) — tracks how often mitigations are needed."
    - name: "check_month"
      expr: DATE_TRUNC('MONTH', check_timestamp)
      comment: "Month the legality check was performed — enables trend analysis of compliance outcomes over time."
  measures:
    - name: "total_legality_checks"
      expr: COUNT(1)
      comment: "Total number of FTL legality checks performed. Baseline volume metric for compliance programme activity."
    - name: "unfit_for_duty_count"
      expr: COUNT(CASE WHEN fitness_result = 'Unfit' THEN ftl_legality_check_id END)
      comment: "Count of checks resulting in an Unfit-for-duty determination. Each instance represents a grounded crew member and potential operational disruption."
    - name: "rest_non_compliance_count"
      expr: COUNT(CASE WHEN rest_compliance_status != 'Compliant' THEN ftl_legality_check_id END)
      comment: "Count of checks where rest period requirements were not met. Directly measures rest-rule breach frequency; a key regulatory audit metric."
    - name: "avg_fatigue_score"
      expr: AVG(CAST(fatigue_score AS DOUBLE))
      comment: "Average fatigue score at time of check. Tracks systemic fatigue levels across the operation; rising averages indicate scheduling patterns that need redesign."
    - name: "avg_fdp_utilisation_pct"
      expr: ROUND(100.0 * AVG(fdp_actual_hours / NULLIF(fdp_limit_hours, 0)), 2)
      comment: "Average FDP utilisation as a percentage of the regulatory limit. Values approaching 100% indicate the operation is running at the edge of legal limits, increasing safety risk."
    - name: "avg_rest_period_actual_hours"
      expr: AVG(CAST(rest_period_actual_hours AS DOUBLE))
      comment: "Average actual rest period in hours. Compared against the required minimum to assess systemic rest adequacy across the crew base."
    - name: "avg_rest_period_required_hours"
      expr: AVG(CAST(rest_period_required_hours AS DOUBLE))
      comment: "Average required rest period in hours. Baseline for computing rest compliance gap; used alongside actual rest hours in regulatory reporting."
    - name: "avg_flight_time_28_day"
      expr: AVG(CAST(flight_time_28_day AS DOUBLE))
      comment: "Average 28-day cumulative flight time at point of check. Monitors rolling flight-time limit utilisation; approaching the regulatory cap triggers proactive rostering adjustments."
    - name: "avg_flight_time_365_day"
      expr: AVG(CAST(flight_time_365_day AS DOUBLE))
      comment: "Average 365-day cumulative flight time at point of check. Annual limit utilisation metric; critical for year-end capacity planning and crew augmentation decisions."
    - name: "mitigation_application_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN mitigation_applied IS NOT NULL AND mitigation_applied != '' THEN ftl_legality_check_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of legality checks where a fatigue mitigation was applied. High rates indicate the schedule is structurally non-compliant and relying on mitigations as a crutch."
$$;


CREATE OR REPLACE VIEW `airlines_ecm`.`_metrics`.`crew_absence`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Crew absence analytics — tracks absence frequency, replacement demand, and return-to-duty compliance. Used by VP People, Crew Control, and Finance to manage operational disruption, replacement costs, and workforce availability."
  source: "`airlines_ecm`.`crew`.`absence`"
  dimensions:
    - name: "absence_type"
      expr: absence_type
      comment: "Type of absence (e.g. Sick, Injury, Maternity, Compassionate) — primary segmentation for absence root-cause analysis."
    - name: "absence_status"
      expr: absence_status
      comment: "Current status of the absence record (Open, Closed, Pending Clearance) — filters active from historical absences."
    - name: "crew_position"
      expr: crew_position
      comment: "Crew position of the absent member — identifies which crew grades drive the most operational disruption."
    - name: "pay_status"
      expr: pay_status
      comment: "Pay status during absence (Full Pay, Half Pay, Unpaid) — used in absence cost modelling."
    - name: "replacement_required_flag"
      expr: replacement_required_flag
      comment: "Boolean indicating whether a replacement crew member was required — directly links absence to operational cost."
    - name: "recurrence_flag"
      expr: recurrence_flag
      comment: "Boolean indicating a recurring absence pattern — recurring absences may indicate underlying health issues requiring HR intervention."
    - name: "return_to_duty_clearance_flag"
      expr: return_to_duty_clearance_flag
      comment: "Boolean indicating medical clearance was obtained before return to duty — a regulatory compliance requirement."
    - name: "notification_method"
      expr: notification_method
      comment: "How the absence was notified (e.g. Phone, App, Email) — used to assess compliance with notification procedures."
    - name: "absence_start_month"
      expr: DATE_TRUNC('MONTH', start_date)
      comment: "Month the absence started — enables seasonal and trend analysis of absence rates."
  measures:
    - name: "total_absences"
      expr: COUNT(1)
      comment: "Total number of absence records. Baseline volume metric for absence frequency tracking and benchmarking."
    - name: "absences_requiring_replacement"
      expr: COUNT(CASE WHEN replacement_required_flag = TRUE THEN absence_id END)
      comment: "Count of absences that required a replacement crew member. Each instance drives additional scheduling cost and operational complexity."
    - name: "recurring_absences"
      expr: COUNT(CASE WHEN recurrence_flag = TRUE THEN absence_id END)
      comment: "Count of absences flagged as recurring. High recurring absence counts signal workforce health issues requiring targeted HR and occupational health intervention."
    - name: "absences_without_return_clearance"
      expr: COUNT(CASE WHEN return_to_duty_clearance_flag = FALSE AND absence_status = 'Closed' THEN absence_id END)
      comment: "Count of closed absences where return-to-duty medical clearance was not obtained. Represents a regulatory compliance gap that must be remediated."
    - name: "replacement_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN replacement_required_flag = TRUE THEN absence_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of absences requiring crew replacement. High rates indicate insufficient reserve pool depth and drive up irregular operations costs."
    - name: "distinct_absent_crew_members"
      expr: COUNT(DISTINCT member_id)
      comment: "Count of distinct crew members with at least one absence. Measures breadth of absence impact across the workforce; used to compute absence prevalence rate."
$$;


CREATE OR REPLACE VIEW `airlines_ecm`.`_metrics`.`crew_training_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Training programme effectiveness, cost, and compliance analytics. Used by Director of Training, VP Safety, and CFO to manage training investment, regulatory currency, and pass-rate quality across the crew base."
  source: "`airlines_ecm`.`crew`.`training_event`"
  dimensions:
    - name: "training_type_code"
      expr: training_type_code
      comment: "Training type code (e.g. OPC, LPC, CRM, SEP) — primary segmentation for training programme analysis."
    - name: "training_category"
      expr: training_category
      comment: "Training category (e.g. Recurrent, Initial, Upgrade) — distinguishes mandatory recurrent from developmental training."
    - name: "training_method"
      expr: training_method
      comment: "Delivery method (e.g. Simulator, Classroom, Line Training) — used to analyse cost and effectiveness by modality."
    - name: "training_status"
      expr: training_status
      comment: "Current status of the training event (Scheduled, Completed, Failed, Cancelled) — filters completed from pending events."
    - name: "training_result_code"
      expr: training_result_code
      comment: "Outcome code of the training event (Pass, Fail, Incomplete) — primary quality metric dimension."
    - name: "is_regulatory_required"
      expr: is_regulatory_required
      comment: "Boolean indicating whether the training is mandated by a regulatory authority — regulatory training failures carry direct compliance consequences."
    - name: "crew_position_code"
      expr: crew_position_code
      comment: "Crew position the training applies to — enables grade-level training compliance and cost analysis."
    - name: "training_cost_currency_code"
      expr: training_cost_currency_code
      comment: "Currency of training cost — required for multi-currency cost consolidation."
    - name: "training_month"
      expr: DATE_TRUNC('MONTH', training_date)
      comment: "Month of training — enables trend analysis of training throughput, cost, and pass rates over time."
  measures:
    - name: "total_training_events"
      expr: COUNT(1)
      comment: "Total number of training events. Baseline throughput metric for training programme capacity and scheduling."
    - name: "total_training_cost"
      expr: SUM(CAST(training_cost_amount AS DOUBLE))
      comment: "Total training expenditure. Primary training cost KPI used in budget vs. actuals reporting and cost-per-trained-crew calculations."
    - name: "avg_training_cost_per_event"
      expr: AVG(CAST(training_cost_amount AS DOUBLE))
      comment: "Average cost per training event. Benchmarks training efficiency; rising averages may indicate simulator over-reliance or external vendor cost inflation."
    - name: "total_training_hours"
      expr: SUM(CAST(training_duration_hours AS DOUBLE))
      comment: "Total training hours delivered. Measures training programme scale; used to compute cost-per-training-hour and instructor utilisation."
    - name: "avg_training_score"
      expr: AVG(CAST(training_score AS DOUBLE))
      comment: "Average training assessment score. Tracks crew competency levels; declining averages signal training quality or crew readiness issues."
    - name: "training_pass_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN training_result_code = 'Pass' THEN training_event_id END) / NULLIF(COUNT(CASE WHEN training_result_code IN ('Pass', 'Fail') THEN training_event_id END), 0), 2)
      comment: "Percentage of completed training events resulting in a pass. The primary training quality KPI; a declining pass rate triggers curriculum review and targeted remedial training."
    - name: "regulatory_training_fail_count"
      expr: COUNT(CASE WHEN is_regulatory_required = TRUE AND training_result_code = 'Fail' THEN training_event_id END)
      comment: "Count of failed regulatory-mandatory training events. Each failure represents a compliance breach requiring immediate remedial action and authority notification."
    - name: "distinct_crew_trained"
      expr: COUNT(DISTINCT member_id)
      comment: "Count of distinct crew members who received training. Measures training programme reach; used to compute training coverage rate against total active headcount."
$$;


CREATE OR REPLACE VIEW `airlines_ecm`.`_metrics`.`crew_qualification`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Crew qualification currency and type-rating analytics. Used by Director of Training, VP Flight Operations, and Compliance to ensure the workforce maintains valid qualifications for all operated aircraft types and regulatory requirements."
  source: "`airlines_ecm`.`crew`.`qualification`"
  dimensions:
    - name: "qualification_status"
      expr: qualification_status
      comment: "Current status of the qualification (Valid, Expired, Suspended, Pending) — primary compliance dimension."
    - name: "qualification_category"
      expr: qualification_category
      comment: "Category of qualification (e.g. Type Rating, Line Check, Instrument Rating) — segments the qualification portfolio."
    - name: "recency_status"
      expr: recency_status
      comment: "Recency status (Current, Lapsed) — indicates whether the crew member has met recent experience requirements."
    - name: "position_code"
      expr: position_code
      comment: "Position the qualification applies to (e.g. PIC, SIC) — enables grade-level qualification coverage analysis."
    - name: "is_pic_qualified"
      expr: is_pic_qualified
      comment: "Boolean indicating Pilot-in-Command qualification — critical for legal minimum crew composition on each aircraft type."
    - name: "check_type"
      expr: check_type
      comment: "Type of proficiency check associated with the qualification — used to track check programme compliance."
    - name: "expiry_year"
      expr: YEAR(expiry_date)
      comment: "Year the qualification expires — enables forward-looking expiry pipeline analysis for training scheduling."
  measures:
    - name: "total_qualifications"
      expr: COUNT(1)
      comment: "Total number of qualification records. Baseline metric for qualification portfolio size and coverage."
    - name: "expired_qualifications"
      expr: COUNT(CASE WHEN qualification_status = 'Expired' THEN qualification_id END)
      comment: "Count of expired qualifications. Any expired qualification means the crew member cannot legally operate in that role — a direct operational and regulatory risk."
    - name: "qualifications_expiring_90_days"
      expr: COUNT(CASE WHEN expiry_date BETWEEN CURRENT_DATE() AND DATE_ADD(CURRENT_DATE(), 90) THEN qualification_id END)
      comment: "Count of qualifications expiring within 90 days. Forward-looking pipeline metric that drives training scheduling to prevent operational grounding."
    - name: "lapsed_recency_qualifications"
      expr: COUNT(CASE WHEN recency_status = 'Lapsed' THEN qualification_id END)
      comment: "Count of qualifications where recency requirements have lapsed. Lapsed recency prevents legal operation; requires immediate line flying or simulator recency restoration."
    - name: "avg_flight_hours_at_qualification"
      expr: AVG(CAST(flight_hours AS DOUBLE))
      comment: "Average flight hours held at the time of qualification. Indicates the experience level at which crew achieve qualifications; used in training pathway benchmarking."
    - name: "avg_simulator_hours_at_qualification"
      expr: AVG(CAST(simulator_hours AS DOUBLE))
      comment: "Average simulator hours at qualification. Tracks simulator investment per qualification; used to optimise simulator-to-line training ratios."
    - name: "qualification_validity_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN qualification_status = 'Valid' THEN qualification_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of qualifications currently valid. The headline qualification compliance rate; below-target values indicate systemic training programme gaps."
    - name: "distinct_qualified_crew"
      expr: COUNT(DISTINCT member_id)
      comment: "Count of distinct crew members holding at least one qualification record. Used to compute qualification coverage across the active crew base."
$$;


CREATE OR REPLACE VIEW `airlines_ecm`.`_metrics`.`crew_roster`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Roster quality, compliance, and utilisation analytics. Used by Crew Planning, VP Operations, and Union Relations to evaluate scheduling efficiency, fatigue risk, and collective-agreement compliance across published rosters."
  source: "`airlines_ecm`.`crew`.`roster`"
  dimensions:
    - name: "roster_status"
      expr: roster_status
      comment: "Current status of the roster (Draft, Published, Locked, Revised) — filters operational rosters from planning drafts."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the roster — unapproved rosters cannot be operationally executed."
    - name: "legality_check_status"
      expr: legality_check_status
      comment: "FTL/FAR legality check outcome for the roster — non-compliant rosters must be revised before publication."
    - name: "crew_position"
      expr: crew_position
      comment: "Crew position the roster covers — enables grade-level utilisation and compliance analysis."
    - name: "union_compliance_flag"
      expr: union_compliance_flag
      comment: "Boolean indicating collective-agreement compliance — non-compliant rosters expose the airline to grievance and arbitration risk."
    - name: "roster_source"
      expr: roster_source
      comment: "Source system or method that generated the roster (e.g. PBS, Manual, IROP) — used to compare automated vs. manual scheduling quality."
    - name: "bid_period_month"
      expr: bid_period_month
      comment: "Bid period month — enables month-over-month roster quality trend analysis."
    - name: "bid_period_year"
      expr: bid_period_year
      comment: "Bid period year — supports year-over-year scheduling efficiency benchmarking."
  measures:
    - name: "total_rosters"
      expr: COUNT(1)
      comment: "Total number of roster records. Baseline volume metric for scheduling programme scale."
    - name: "total_credited_block_hours"
      expr: SUM(CAST(total_credited_block_hours AS DOUBLE))
      comment: "Total credited block hours across all rosters. Represents the productive flying time scheduled; used to compute crew utilisation rate against contractual maximums."
    - name: "total_duty_hours"
      expr: SUM(CAST(total_duty_hours AS DOUBLE))
      comment: "Total duty hours across all rosters. Measures total crew time commitment; compared against FTL limits to assess systemic compliance risk."
    - name: "avg_credited_block_hours_per_roster"
      expr: AVG(CAST(total_credited_block_hours AS DOUBLE))
      comment: "Average credited block hours per roster. Benchmarks crew utilisation efficiency; low averages indicate under-scheduling or excessive reserve allocation."
    - name: "avg_fatigue_risk_score"
      expr: AVG(CAST(fatigue_risk_score AS DOUBLE))
      comment: "Average fatigue risk score across rosters. Tracks systemic fatigue risk in the published schedule; a key input to the Safety Management System."
    - name: "non_compliant_rosters"
      expr: COUNT(CASE WHEN legality_check_status != 'Compliant' THEN roster_id END)
      comment: "Count of rosters failing the legality check. Non-compliant rosters cannot be published without revision; tracks scheduling quality and FTL adherence."
    - name: "union_non_compliant_rosters"
      expr: COUNT(CASE WHEN union_compliance_flag = FALSE THEN roster_id END)
      comment: "Count of rosters not compliant with collective-agreement rules. Each instance is a potential grievance; used by Labour Relations to prioritise remediation."
    - name: "roster_compliance_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN legality_check_status = 'Compliant' THEN roster_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of rosters passing the legality check. Headline scheduling compliance KPI reported to the VP Operations and regulatory authority."
$$;


CREATE OR REPLACE VIEW `airlines_ecm`.`_metrics`.`crew_medical_certificate`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Medical certificate currency and compliance analytics. Used by Chief Medical Officer, VP Flight Operations, and Compliance to ensure all crew hold valid medical certificates and to proactively manage renewal pipelines."
  source: "`airlines_ecm`.`crew`.`medical_certificate`"
  dimensions:
    - name: "certificate_class"
      expr: certificate_class
      comment: "Medical certificate class (Class 1, Class 2, Class 3) — determines which crew roles the certificate authorises."
    - name: "certificate_type"
      expr: certificate_type
      comment: "Type of medical certificate — used to segment the certificate portfolio by regulatory category."
    - name: "validity_status"
      expr: validity_status
      comment: "Current validity status (Valid, Expired, Suspended, Revoked) — primary compliance dimension."
    - name: "verification_status"
      expr: verification_status
      comment: "Verification status of the certificate — unverified certificates represent a compliance gap."
    - name: "issuing_country_code"
      expr: issuing_country_code
      comment: "Country that issued the medical certificate — relevant for bilateral recognition agreements and regulatory jurisdiction."
    - name: "special_issuance_flag"
      expr: special_issuance_flag
      comment: "Boolean indicating a special issuance certificate — special issuances require additional monitoring and may have operational restrictions."
    - name: "expiry_month"
      expr: DATE_TRUNC('MONTH', expiry_date)
      comment: "Month the certificate expires — enables forward-looking renewal pipeline management."
  measures:
    - name: "total_medical_certificates"
      expr: COUNT(1)
      comment: "Total number of medical certificate records. Baseline portfolio size metric."
    - name: "valid_medical_certificates"
      expr: COUNT(CASE WHEN validity_status = 'Valid' THEN medical_certificate_id END)
      comment: "Count of currently valid medical certificates. Directly measures the medically-cleared crew pool available for operations."
    - name: "expired_medical_certificates"
      expr: COUNT(CASE WHEN validity_status = 'Expired' THEN medical_certificate_id END)
      comment: "Count of expired medical certificates. Any expired certificate means the crew member is legally grounded — a direct operational risk."
    - name: "certificates_expiring_60_days"
      expr: COUNT(CASE WHEN expiry_date BETWEEN CURRENT_DATE() AND DATE_ADD(CURRENT_DATE(), 60) THEN medical_certificate_id END)
      comment: "Count of medical certificates expiring within 60 days. Proactive pipeline metric that drives examination scheduling to prevent operational grounding."
    - name: "special_issuance_certificates"
      expr: COUNT(CASE WHEN special_issuance_flag = TRUE THEN medical_certificate_id END)
      comment: "Count of special-issuance medical certificates. Special issuances require enhanced monitoring; a growing count may indicate workforce health trends requiring occupational health review."
    - name: "unverified_certificates"
      expr: COUNT(CASE WHEN verification_status != 'Verified' THEN medical_certificate_id END)
      comment: "Count of medical certificates not yet verified. Unverified certificates represent a compliance gap; must be resolved before the crew member operates."
    - name: "medical_validity_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN validity_status = 'Valid' THEN medical_certificate_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of medical certificates currently valid. Headline medical compliance rate reported to the aviation authority and used in AOC renewal assessments."
$$;
