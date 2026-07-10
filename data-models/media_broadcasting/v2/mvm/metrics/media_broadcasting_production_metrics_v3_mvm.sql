-- Metric views for domain: production | Business: Media_Broadcasting | Version: 3 | Generated on: 2026-07-10 21:10:12

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`production_budget`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Budget performance and variance metrics for production projects, tracking approved vs actual spend, forecast accuracy, and cost control effectiveness."
  source: "`vibe_media_broadcasting_v1`.`production`.`budget`"
  dimensions:
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the budget period for year-over-year analysis"
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period (month/quarter) for trend analysis"
    - name: "production_phase"
      expr: production_phase
      comment: "Production phase (pre-production, principal photography, post-production) for phase-based cost analysis"
    - name: "cost_category_name"
      expr: cost_category_name
      comment: "Cost category for spend breakdown analysis"
    - name: "approval_status"
      expr: approval_status
      comment: "Budget approval status for tracking approval pipeline"
    - name: "currency_code"
      expr: currency_code
      comment: "Original currency code for multi-currency analysis"
    - name: "is_greenlight_budget"
      expr: is_greenlight_budget
      comment: "Flag indicating greenlight budget for strategic project tracking"
    - name: "budget_year"
      expr: YEAR(period_start_date)
      comment: "Calendar year extracted from budget period start date"
    - name: "budget_quarter"
      expr: CONCAT('Q', QUARTER(period_start_date))
      comment: "Calendar quarter for quarterly budget analysis"
  measures:
    - name: "total_approved_amount"
      expr: SUM(CAST(approved_amount AS DOUBLE))
      comment: "Total approved budget amount across all budget lines"
    - name: "total_actual_cost"
      expr: SUM(CAST(actual_cost_amount AS DOUBLE))
      comment: "Total actual cost incurred to date"
    - name: "total_forecast_amount"
      expr: SUM(CAST(forecast_amount AS DOUBLE))
      comment: "Total forecasted spend for budget planning"
    - name: "total_variance_amount"
      expr: SUM(CAST(variance_amount AS DOUBLE))
      comment: "Total variance between approved and actual spend (positive = under budget, negative = over budget)"
    - name: "total_committed_amount"
      expr: SUM(CAST(committed_amount AS DOUBLE))
      comment: "Total committed spend (contractually obligated but not yet paid)"
    - name: "total_contingency_amount"
      expr: SUM(CAST(contingency_amount AS DOUBLE))
      comment: "Total contingency reserves held for risk mitigation"
    - name: "avg_contingency_percentage"
      expr: AVG(CAST(contingency_percentage AS DOUBLE))
      comment: "Average contingency percentage across budgets for risk planning benchmarks"
    - name: "budget_utilization_rate"
      expr: ROUND(100.0 * SUM(CAST(actual_cost_amount AS DOUBLE)) / NULLIF(SUM(CAST(approved_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of approved budget actually spent (key efficiency and control metric)"
    - name: "forecast_accuracy_rate"
      expr: ROUND(100.0 * (1.0 - ABS(SUM(CAST(forecast_amount AS DOUBLE)) - SUM(CAST(actual_cost_amount AS DOUBLE))) / NULLIF(SUM(CAST(forecast_amount AS DOUBLE)), 0)), 2)
      comment: "Forecast accuracy percentage (100% = perfect forecast, lower = greater deviation)"
    - name: "budget_count"
      expr: COUNT(DISTINCT budget_id)
      comment: "Number of distinct budget records for volume tracking"
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`production_cost_transaction`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Production cost transaction metrics tracking spend velocity, payment efficiency, and cost category performance for financial control and cash flow management."
  source: "`vibe_media_broadcasting_v1`.`production`.`cost_transaction`"
  dimensions:
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year for annual financial reporting"
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period for monthly/quarterly financial analysis"
    - name: "transaction_type"
      expr: transaction_type
      comment: "Type of cost transaction (invoice, payment, accrual, etc.)"
    - name: "cost_category_name"
      expr: cost_category_name
      comment: "Cost category for spend analysis by type"
    - name: "production_phase"
      expr: production_phase
      comment: "Production phase when cost was incurred"
    - name: "payment_status"
      expr: payment_status
      comment: "Payment status (pending, paid, overdue) for cash flow management"
    - name: "payment_method"
      expr: payment_method
      comment: "Payment method for payment operations analysis"
    - name: "currency_code"
      expr: currency_code
      comment: "Transaction currency for multi-currency tracking"
    - name: "transaction_month"
      expr: DATE_TRUNC('MONTH', transaction_date)
      comment: "Transaction month for monthly spend trending"
    - name: "invoice_month"
      expr: DATE_TRUNC('MONTH', invoice_date)
      comment: "Invoice month for invoice aging analysis"
  measures:
    - name: "total_transaction_amount"
      expr: SUM(CAST(transaction_amount AS DOUBLE))
      comment: "Total transaction amount in original currency"
    - name: "total_net_amount"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Total net amount (excluding tax) for cost analysis"
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount for tax liability tracking"
    - name: "total_reporting_currency_amount"
      expr: SUM(CAST(reporting_currency_amount AS DOUBLE))
      comment: "Total amount in reporting currency for consolidated financial reporting"
    - name: "avg_transaction_amount"
      expr: AVG(CAST(transaction_amount AS DOUBLE))
      comment: "Average transaction size for spend pattern analysis"
    - name: "transaction_count"
      expr: COUNT(DISTINCT cost_transaction_id)
      comment: "Number of cost transactions for volume tracking"
    - name: "unique_payee_count"
      expr: COUNT(DISTINCT payee_name)
      comment: "Number of unique payees for vendor concentration analysis"
    - name: "avg_tax_rate"
      expr: ROUND(100.0 * SUM(CAST(tax_amount AS DOUBLE)) / NULLIF(SUM(CAST(net_amount AS DOUBLE)), 0), 2)
      comment: "Average effective tax rate across transactions for tax planning"
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`production_episode`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Episode production performance metrics tracking budget efficiency, schedule adherence, and delivery quality for episodic content production management."
  source: "`vibe_media_broadcasting_v1`.`production`.`production_episode`"
  dimensions:
    - name: "production_status"
      expr: production_status
      comment: "Current production status for pipeline tracking"
    - name: "content_type"
      expr: content_type
      comment: "Content type (drama, comedy, documentary, etc.) for genre analysis"
    - name: "content_rating"
      expr: content_rating
      comment: "Content rating (TV-PG, TV-14, etc.) for audience targeting"
    - name: "production_company"
      expr: production_company
      comment: "Production company for vendor performance analysis"
    - name: "director_name"
      expr: director_name
      comment: "Director name for creative talent analysis"
    - name: "shoot_country_code"
      expr: shoot_country_code
      comment: "Shooting location country for geographic production analysis"
    - name: "audio_language_code"
      expr: audio_language_code
      comment: "Primary audio language for language market analysis"
    - name: "closed_captioning_compliant"
      expr: closed_captioning_compliant
      comment: "Closed captioning compliance flag for accessibility tracking"
    - name: "greenlight_year"
      expr: YEAR(greenlight_date)
      comment: "Year episode was greenlit for development pipeline analysis"
    - name: "first_air_month"
      expr: DATE_TRUNC('MONTH', first_air_date)
      comment: "Month of first air date for release calendar analysis"
  measures:
    - name: "total_approved_budget"
      expr: SUM(CAST(approved_budget_usd AS DOUBLE))
      comment: "Total approved budget in USD for financial planning"
    - name: "total_actual_cost"
      expr: SUM(CAST(actual_cost_usd AS DOUBLE))
      comment: "Total actual cost in USD for cost control"
    - name: "avg_cost_per_episode"
      expr: AVG(CAST(actual_cost_usd AS DOUBLE))
      comment: "Average production cost per episode for benchmarking"
    - name: "budget_variance_total"
      expr: SUM(CAST(approved_budget_usd AS DOUBLE) - CAST(actual_cost_usd AS DOUBLE))
      comment: "Total budget variance (positive = under budget, negative = over budget)"
    - name: "budget_efficiency_rate"
      expr: ROUND(100.0 * SUM(CAST(actual_cost_usd AS DOUBLE)) / NULLIF(SUM(CAST(approved_budget_usd AS DOUBLE)), 0), 2)
      comment: "Budget efficiency percentage (actual vs approved) - key production efficiency KPI"
    - name: "episode_count"
      expr: COUNT(DISTINCT production_episode_id)
      comment: "Number of production episodes for volume tracking"
    - name: "on_time_delivery_count"
      expr: SUM(CASE WHEN actual_delivery_date <= delivery_date THEN 1 ELSE 0 END)
      comment: "Count of episodes delivered on or before scheduled delivery date"
    - name: "on_time_delivery_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN actual_delivery_date <= delivery_date THEN 1 ELSE 0 END) / NULLIF(COUNT(DISTINCT production_episode_id), 0), 2)
      comment: "Percentage of episodes delivered on time - critical schedule adherence KPI"
    - name: "closed_caption_compliance_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN closed_captioning_compliant = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(DISTINCT production_episode_id), 0), 2)
      comment: "Percentage of episodes meeting closed captioning compliance for regulatory adherence"
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`production_project`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Production project portfolio metrics tracking greenlight decisions, budget performance, and production throughput for strategic content investment management."
  source: "`vibe_media_broadcasting_v1`.`production`.`project`"
  dimensions:
    - name: "project_type"
      expr: project_type
      comment: "Project type (series, film, special, etc.) for portfolio mix analysis"
    - name: "production_phase"
      expr: production_phase
      comment: "Current production phase for pipeline stage analysis"
    - name: "greenlight_status"
      expr: greenlight_status
      comment: "Greenlight status (approved, pending, rejected) for investment decision tracking"
    - name: "content_genre"
      expr: content_genre
      comment: "Content genre for genre portfolio analysis"
    - name: "content_rating"
      expr: content_rating
      comment: "Content rating for audience targeting strategy"
    - name: "production_country"
      expr: production_country
      comment: "Production country for geographic production strategy"
    - name: "production_format"
      expr: production_format
      comment: "Production format (4K, HD, etc.) for technical standards tracking"
    - name: "co_production_flag"
      expr: co_production_flag
      comment: "Co-production flag for partnership model analysis"
    - name: "original_ip_flag"
      expr: original_ip_flag
      comment: "Original IP flag for IP strategy analysis"
    - name: "greenlight_year"
      expr: YEAR(greenlight_date)
      comment: "Year project was greenlit for development cohort analysis"
    - name: "target_delivery_year"
      expr: YEAR(target_delivery_date)
      comment: "Target delivery year for release planning"
  measures:
    - name: "total_approved_budget"
      expr: SUM(CAST(approved_budget_usd AS DOUBLE))
      comment: "Total approved budget across all projects for capital allocation"
    - name: "total_actual_spend"
      expr: SUM(CAST(actual_spend_usd AS DOUBLE))
      comment: "Total actual spend to date for financial control"
    - name: "avg_project_budget"
      expr: AVG(CAST(approved_budget_usd AS DOUBLE))
      comment: "Average project budget for investment sizing benchmarks"
    - name: "project_count"
      expr: COUNT(DISTINCT project_id)
      comment: "Number of production projects for portfolio volume tracking"
    - name: "greenlit_project_count"
      expr: SUM(CASE WHEN greenlight_status = 'approved' THEN 1 ELSE 0 END)
      comment: "Count of greenlit projects for investment decision tracking"
    - name: "greenlight_approval_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN greenlight_status = 'approved' THEN 1 ELSE 0 END) / NULLIF(COUNT(DISTINCT project_id), 0), 2)
      comment: "Percentage of projects approved for greenlight - key investment selectivity metric"
    - name: "budget_utilization_rate"
      expr: ROUND(100.0 * SUM(CAST(actual_spend_usd AS DOUBLE)) / NULLIF(SUM(CAST(approved_budget_usd AS DOUBLE)), 0), 2)
      comment: "Portfolio-wide budget utilization rate for capital efficiency tracking"
    - name: "on_time_delivery_count"
      expr: SUM(CASE WHEN actual_delivery_date <= target_delivery_date THEN 1 ELSE 0 END)
      comment: "Count of projects delivered on or before target date"
    - name: "on_time_delivery_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN actual_delivery_date <= target_delivery_date THEN 1 ELSE 0 END) / NULLIF(COUNT(DISTINCT project_id), 0), 2)
      comment: "Percentage of projects delivered on schedule - critical portfolio execution KPI"
    - name: "co_production_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN co_production_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(DISTINCT project_id), 0), 2)
      comment: "Percentage of projects structured as co-productions for partnership strategy analysis"
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`production_qc_review`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Quality control review metrics tracking defect rates, compliance pass rates, and remediation efficiency for content quality assurance and regulatory compliance."
  source: "`vibe_media_broadcasting_v1`.`production`.`qc_review`"
  dimensions:
    - name: "qc_result"
      expr: qc_result
      comment: "QC result (pass, fail, conditional pass) for quality outcome tracking"
    - name: "qc_type"
      expr: qc_type
      comment: "QC type (technical, compliance, creative) for QC process analysis"
    - name: "review_status"
      expr: review_status
      comment: "Review status for QC workflow tracking"
    - name: "final_approval_status"
      expr: final_approval_status
      comment: "Final approval status for release readiness tracking"
    - name: "qc_platform"
      expr: qc_platform
      comment: "QC platform/tool used for operational efficiency analysis"
    - name: "closed_caption_compliance_flag"
      expr: closed_caption_compliance_flag
      comment: "Closed caption compliance flag for accessibility compliance tracking"
    - name: "audio_description_compliance_flag"
      expr: audio_description_compliance_flag
      comment: "Audio description compliance flag for accessibility compliance tracking"
    - name: "loudness_compliance_flag"
      expr: loudness_compliance_flag
      comment: "Loudness compliance flag for broadcast standards compliance"
    - name: "remediation_required_flag"
      expr: remediation_required_flag
      comment: "Remediation required flag for rework tracking"
    - name: "review_month"
      expr: DATE_TRUNC('MONTH', review_date)
      comment: "Review month for monthly QC trending"
  measures:
    - name: "qc_review_count"
      expr: COUNT(DISTINCT qc_review_id)
      comment: "Number of QC reviews performed for volume tracking"
    - name: "qc_pass_count"
      expr: SUM(CASE WHEN qc_result = 'pass' THEN 1 ELSE 0 END)
      comment: "Count of QC reviews that passed on first attempt"
    - name: "qc_pass_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN qc_result = 'pass' THEN 1 ELSE 0 END) / NULLIF(COUNT(DISTINCT qc_review_id), 0), 2)
      comment: "First-pass QC success rate - key quality efficiency metric"
    - name: "closed_caption_compliance_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN closed_caption_compliance_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(DISTINCT qc_review_id), 0), 2)
      comment: "Closed caption compliance rate for regulatory adherence tracking"
    - name: "audio_description_compliance_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN audio_description_compliance_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(DISTINCT qc_review_id), 0), 2)
      comment: "Audio description compliance rate for accessibility compliance tracking"
    - name: "loudness_compliance_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN loudness_compliance_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(DISTINCT qc_review_id), 0), 2)
      comment: "Loudness compliance rate for broadcast standards adherence"
    - name: "remediation_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN remediation_required_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(DISTINCT qc_review_id), 0), 2)
      comment: "Percentage of reviews requiring remediation - key rework efficiency metric"
    - name: "avg_review_duration_minutes"
      expr: AVG(CAST(review_duration_minutes AS DOUBLE))
      comment: "Average QC review duration for operational efficiency benchmarking"
    - name: "avg_p1_critical_errors"
      expr: AVG(CAST(p1_critical_error_count AS DOUBLE))
      comment: "Average P1 critical errors per review for quality severity tracking"
    - name: "avg_total_errors"
      expr: AVG(CAST(total_error_count AS DOUBLE))
      comment: "Average total errors per review for overall quality tracking"
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`production_crew_assignment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Crew assignment and labor cost metrics tracking crew utilization, union compliance, and labor rate efficiency for production workforce management."
  source: "`vibe_media_broadcasting_v1`.`production`.`crew_assignment`"
  dimensions:
    - name: "assignment_status"
      expr: assignment_status
      comment: "Assignment status (active, completed, cancelled) for crew availability tracking"
    - name: "department"
      expr: department
      comment: "Production department for departmental labor analysis"
    - name: "role_title"
      expr: role_title
      comment: "Crew role/title for role-based labor analysis"
    - name: "union_guild_affiliation"
      expr: union_guild_affiliation
      comment: "Union/guild affiliation for labor relations and compliance tracking"
    - name: "deal_type"
      expr: deal_type
      comment: "Deal type (daily, weekly, flat) for compensation structure analysis"
    - name: "filming_location_country"
      expr: filming_location_country
      comment: "Filming location country for geographic labor cost analysis"
    - name: "overtime_eligible"
      expr: overtime_eligible
      comment: "Overtime eligibility flag for labor cost planning"
    - name: "residuals_eligible"
      expr: residuals_eligible
      comment: "Residuals eligibility flag for long-term cost liability tracking"
    - name: "work_permit_required"
      expr: work_permit_required
      comment: "Work permit requirement flag for immigration compliance tracking"
    - name: "assignment_year"
      expr: YEAR(start_date)
      comment: "Year of assignment start for annual labor planning"
  measures:
    - name: "crew_assignment_count"
      expr: COUNT(DISTINCT crew_assignment_id)
      comment: "Number of crew assignments for workforce volume tracking"
    - name: "unique_talent_count"
      expr: COUNT(DISTINCT talent_profile_id)
      comment: "Number of unique crew members for talent pool size tracking"
    - name: "total_contracted_rate"
      expr: SUM(CAST(contracted_rate AS DOUBLE))
      comment: "Total contracted labor rates for labor cost planning"
    - name: "avg_contracted_rate"
      expr: AVG(CAST(contracted_rate AS DOUBLE))
      comment: "Average contracted rate per assignment for labor cost benchmarking"
    - name: "total_per_diem"
      expr: SUM(CAST(per_diem_rate AS DOUBLE))
      comment: "Total per diem allowances for travel cost tracking"
    - name: "total_box_rental"
      expr: SUM(CAST(box_rental_rate AS DOUBLE))
      comment: "Total box rental fees for equipment rental cost tracking"
    - name: "avg_overtime_multiplier"
      expr: AVG(CAST(overtime_rate_multiplier AS DOUBLE))
      comment: "Average overtime rate multiplier for overtime cost modeling"
    - name: "union_crew_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN union_guild_affiliation IS NOT NULL THEN crew_assignment_id END) / NULLIF(COUNT(DISTINCT crew_assignment_id), 0), 2)
      comment: "Percentage of crew with union affiliation for labor relations planning"
    - name: "work_permit_compliance_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN work_permit_required = FALSE OR work_permit_number IS NOT NULL THEN crew_assignment_id END) / NULLIF(COUNT(DISTINCT crew_assignment_id), 0), 2)
      comment: "Percentage of assignments with valid work permits where required for immigration compliance"
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`production_deliverable`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Content deliverable metrics tracking delivery performance, compliance certification, and QC pass rates for distribution readiness and contractual fulfillment."
  source: "`vibe_media_broadcasting_v1`.`production`.`deliverable`"
  dimensions:
    - name: "deliverable_type"
      expr: deliverable_type
      comment: "Deliverable type (master, proxy, trailer, etc.) for deliverable mix analysis"
    - name: "delivery_status"
      expr: delivery_status
      comment: "Delivery status (pending, delivered, rejected) for fulfillment tracking"
    - name: "delivery_method"
      expr: delivery_method
      comment: "Delivery method (physical, digital, satellite) for logistics analysis"
    - name: "aspect_ratio"
      expr: aspect_ratio
      comment: "Aspect ratio for technical specification tracking"
    - name: "language_code"
      expr: language_code
      comment: "Primary language for language market analysis"
    - name: "content_rating"
      expr: content_rating
      comment: "Content rating for compliance tracking"
    - name: "closed_caption_flag"
      expr: closed_caption_flag
      comment: "Closed caption flag for accessibility compliance"
    - name: "audio_description_flag"
      expr: audio_description_flag
      comment: "Audio description flag for accessibility compliance"
    - name: "qc_pass_flag"
      expr: qc_pass_flag
      comment: "QC pass flag for quality assurance tracking"
    - name: "compliance_certificate_flag"
      expr: compliance_certificate_flag
      comment: "Compliance certificate flag for regulatory fulfillment"
    - name: "due_month"
      expr: DATE_TRUNC('MONTH', due_date)
      comment: "Due month for delivery schedule planning"
  measures:
    - name: "deliverable_count"
      expr: COUNT(DISTINCT deliverable_id)
      comment: "Number of deliverables for volume tracking"
    - name: "total_cost"
      expr: SUM(CAST(cost_amount AS DOUBLE))
      comment: "Total deliverable production cost for cost tracking"
    - name: "avg_cost_per_deliverable"
      expr: AVG(CAST(cost_amount AS DOUBLE))
      comment: "Average cost per deliverable for cost benchmarking"
    - name: "total_file_size_gb"
      expr: SUM(CAST(file_size_bytes AS DOUBLE)) / 1073741824.0
      comment: "Total file size in gigabytes for storage and bandwidth planning"
    - name: "avg_duration_minutes"
      expr: AVG(CAST(duration_seconds AS DOUBLE)) / 60.0
      comment: "Average deliverable duration in minutes for content length analysis"
    - name: "on_time_delivery_count"
      expr: SUM(CASE WHEN actual_delivery_timestamp <= scheduled_delivery_timestamp THEN 1 ELSE 0 END)
      comment: "Count of deliverables delivered on or before scheduled time"
    - name: "on_time_delivery_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN actual_delivery_timestamp <= scheduled_delivery_timestamp THEN 1 ELSE 0 END) / NULLIF(COUNT(DISTINCT deliverable_id), 0), 2)
      comment: "Percentage of deliverables delivered on time - key fulfillment KPI"
    - name: "qc_pass_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN qc_pass_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(DISTINCT deliverable_id), 0), 2)
      comment: "QC pass rate for quality assurance performance"
    - name: "closed_caption_compliance_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN closed_caption_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(DISTINCT deliverable_id), 0), 2)
      comment: "Closed caption compliance rate for accessibility adherence"
    - name: "compliance_certificate_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN compliance_certificate_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(DISTINCT deliverable_id), 0), 2)
      comment: "Percentage of deliverables with compliance certificates for regulatory fulfillment"
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`production_milestone`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Production milestone tracking metrics measuring schedule adherence, critical path performance, and risk mitigation effectiveness for project management and delivery assurance."
  source: "`vibe_media_broadcasting_v1`.`production`.`milestone`"
  dimensions:
    - name: "milestone_type"
      expr: milestone_type
      comment: "Milestone type (greenlight, script lock, picture lock, delivery, etc.) for phase tracking"
    - name: "milestone_status"
      expr: milestone_status
      comment: "Milestone status (pending, achieved, missed, at risk) for progress tracking"
    - name: "critical_path_flag"
      expr: critical_path_flag
      comment: "Critical path flag for schedule risk identification"
    - name: "approval_required_flag"
      expr: approval_required_flag
      comment: "Approval required flag for governance tracking"
    - name: "risk_level"
      expr: risk_level
      comment: "Risk level (low, medium, high, critical) for risk management"
    - name: "responsible_department"
      expr: responsible_department
      comment: "Responsible department for accountability tracking"
    - name: "stakeholder_notification_flag"
      expr: stakeholder_notification_flag
      comment: "Stakeholder notification flag for communication tracking"
    - name: "planned_year"
      expr: YEAR(planned_date)
      comment: "Planned year for annual planning analysis"
    - name: "planned_quarter"
      expr: CONCAT('Q', QUARTER(planned_date))
      comment: "Planned quarter for quarterly planning"
  measures:
    - name: "milestone_count"
      expr: COUNT(DISTINCT milestone_id)
      comment: "Number of milestones for project complexity tracking"
    - name: "critical_path_milestone_count"
      expr: SUM(CASE WHEN critical_path_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of critical path milestones for schedule risk assessment"
    - name: "on_time_milestone_count"
      expr: SUM(CASE WHEN actual_date <= planned_date THEN 1 ELSE 0 END)
      comment: "Count of milestones achieved on or before planned date"
    - name: "on_time_achievement_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN actual_date <= planned_date THEN 1 ELSE 0 END) / NULLIF(COUNT(DISTINCT milestone_id), 0), 2)
      comment: "Percentage of milestones achieved on time - key schedule adherence KPI"
    - name: "critical_path_on_time_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN critical_path_flag = TRUE AND actual_date <= planned_date THEN 1 ELSE 0 END) / NULLIF(SUM(CASE WHEN critical_path_flag = TRUE THEN 1 ELSE 0 END), 0), 2)
      comment: "On-time rate for critical path milestones - critical schedule risk metric"
    - name: "high_risk_milestone_count"
      expr: SUM(CASE WHEN risk_level IN ('high', 'critical') THEN 1 ELSE 0 END)
      comment: "Count of high or critical risk milestones for risk management focus"
    - name: "high_risk_milestone_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN risk_level IN ('high', 'critical') THEN 1 ELSE 0 END) / NULLIF(COUNT(DISTINCT milestone_id), 0), 2)
      comment: "Percentage of milestones at high or critical risk for risk exposure tracking"
    - name: "total_budget_impact"
      expr: SUM(CAST(budget_impact_usd AS DOUBLE))
      comment: "Total budget impact of milestones for financial risk assessment"
    - name: "avg_budget_impact"
      expr: AVG(CAST(budget_impact_usd AS DOUBLE))
      comment: "Average budget impact per milestone for financial risk sizing"
$$;