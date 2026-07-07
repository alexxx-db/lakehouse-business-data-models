-- Metric views for domain: workforce | Business: Construction | Version: 2 | Generated on: 2026-06-28 00:14:33

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`workforce_agency_labor_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Agency labor order fulfillment and cost metrics tracking bill rates, fulfillment rates, and order status across projects. Drives agency performance management and contingent labor cost control."
  source: "`vibe_construction_v1`.`workforce`.`agency_labor_order`"
  dimensions:
    - name: "agency_id"
      expr: agency_id
      comment: "Agency identifier for agency-level performance and cost analysis."
    - name: "construction_project_id"
      expr: construction_project_id
      comment: "Project for project-level agency labor cost tracking."
    - name: "order_status"
      expr: order_status
      comment: "Order status (Open, Fulfilled, Cancelled, Partial) for fulfillment pipeline management."
    - name: "skill_trade_id"
      expr: skill_trade_id
      comment: "Skill trade for trade-level agency demand analysis."
    - name: "skill_level"
      expr: skill_level
      comment: "Skill level for workforce qualification tier analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency for multi-currency cost normalization."
    - name: "union_affiliation_required_flag"
      expr: union_affiliation_required_flag
      comment: "Union requirement flag for labor agreement compliance tracking."
    - name: "hse_orientation_required_flag"
      expr: hse_orientation_required_flag
      comment: "HSE orientation requirement flag for safety compliance at order level."
    - name: "cost_code_id"
      expr: cost_code_id
      comment: "Cost code for agency labor cost allocation."
  measures:
    - name: "total_orders"
      expr: COUNT(agency_labor_order_id)
      comment: "Total agency labor orders. Tracks contingent labor demand volume."
    - name: "fulfilled_orders"
      expr: COUNT(CASE WHEN order_status = 'Fulfilled' THEN agency_labor_order_id END)
      comment: "Count of fulfilled orders. Tracks agency delivery performance."
    - name: "open_orders"
      expr: COUNT(CASE WHEN order_status = 'Open' THEN agency_labor_order_id END)
      comment: "Count of open (unfulfilled) orders. Tracks outstanding workforce demand and supply risk."
    - name: "total_bill_rate_commitment"
      expr: SUM(CAST(bill_rate AS DOUBLE))
      comment: "Total bill rate across orders. Tracks agency labor cost commitment for budget management."
    - name: "total_pay_rate_commitment"
      expr: SUM(CAST(pay_rate AS DOUBLE))
      comment: "Total pay rate across orders. Tracks direct labor cost component of agency spend."
    - name: "avg_markup_percentage"
      expr: AVG(CAST(markup_percentage AS DOUBLE))
      comment: "Average agency markup percentage. Benchmarks agency cost efficiency and negotiation outcomes."
    - name: "avg_bill_rate"
      expr: AVG(CAST(bill_rate AS DOUBLE))
      comment: "Average bill rate across orders. Tracks blended agency rate trends for cost forecasting."
    - name: "distinct_agencies_engaged"
      expr: COUNT(DISTINCT agency_id)
      comment: "Count of distinct agencies with orders. Tracks agency supply chain diversification."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`workforce_apprenticeship_progression`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Apprenticeship program compliance and progression metrics tracking DOL compliance, OJT hours accumulation, and journeyman completion rates. Supports workforce development and regulatory reporting."
  source: "`vibe_construction_v1`.`workforce`.`apprenticeship_progression`"
  dimensions:
    - name: "apprenticeship_status"
      expr: apprenticeship_status
      comment: "Apprenticeship status (Active, Completed, Suspended, Cancelled) for program pipeline tracking."
    - name: "apprenticeship_type"
      expr: apprenticeship_type
      comment: "Apprenticeship type for program classification analysis."
    - name: "apprenticeship_level"
      expr: apprenticeship_level
      comment: "Current apprenticeship level for progression tier analysis."
    - name: "wage_progression_step"
      expr: wage_progression_step
      comment: "Wage progression step for compensation advancement tracking."
    - name: "compliance_status"
      expr: compliance_status
      comment: "Compliance status for regulatory audit readiness."
    - name: "dol_compliance_flag"
      expr: dol_compliance_flag
      comment: "DOL compliance flag for federal apprenticeship regulation adherence."
    - name: "state_apprenticeship_compliance_flag"
      expr: state_apprenticeship_compliance_flag
      comment: "State-level apprenticeship compliance flag for multi-jurisdiction reporting."
    - name: "training_provider"
      expr: training_provider
      comment: "Training provider for program quality and provider performance analysis."
    - name: "union_local"
      expr: union_local
      comment: "Union local for JATC-sponsored apprenticeship tracking."
  measures:
    - name: "total_apprenticeships"
      expr: COUNT(apprenticeship_progression_id)
      comment: "Total apprenticeship records. Tracks workforce development program scale."
    - name: "active_apprenticeships"
      expr: COUNT(CASE WHEN apprenticeship_status = 'Active' THEN apprenticeship_progression_id END)
      comment: "Currently active apprenticeships. Tracks live workforce development pipeline."
    - name: "completed_apprenticeships"
      expr: COUNT(CASE WHEN apprenticeship_status = 'Completed' THEN apprenticeship_progression_id END)
      comment: "Completed apprenticeships resulting in journeyman certification. Measures program graduation rate."
    - name: "dol_non_compliant_count"
      expr: COUNT(CASE WHEN dol_compliance_flag = FALSE THEN apprenticeship_progression_id END)
      comment: "Apprenticeships not meeting DOL compliance requirements. Regulatory risk requiring immediate remediation."
    - name: "total_ojt_hours_accumulated"
      expr: SUM(CAST(ojt_hours_accumulated AS DOUBLE))
      comment: "Total on-the-job training hours accumulated. Tracks workforce skills development investment."
    - name: "total_technical_instruction_hours"
      expr: SUM(CAST(technical_instruction_hours AS DOUBLE))
      comment: "Total technical instruction hours completed. Tracks classroom training investment in workforce development."
    - name: "avg_ojt_hours_accumulated"
      expr: AVG(CAST(ojt_hours_accumulated AS DOUBLE))
      comment: "Average OJT hours per apprentice. Benchmarks program progression pace against requirements."
    - name: "certifications_earned_count"
      expr: COUNT(CASE WHEN certification_earned_flag = TRUE THEN apprenticeship_progression_id END)
      comment: "Count of apprenticeships where certification was earned. Measures program effectiveness and ROI."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`workforce_carbon_reduction_participation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Workforce carbon reduction participation metrics tracking carbon savings, incentive spend, and verification status. Supports ESG reporting and sustainability target achievement."
  source: "`vibe_construction_v1`.`workforce`.`carbon_reduction_participation`"
  dimensions:
    - name: "carbon_reduction_initiative_id"
      expr: carbon_reduction_initiative_id
      comment: "Initiative identifier for initiative-level carbon savings analysis."
    - name: "participation_status"
      expr: participation_status
      comment: "Participation status (Active, Completed, Withdrawn) for program pipeline tracking."
    - name: "activity_type"
      expr: activity_type
      comment: "Activity type for carbon reduction method classification."
    - name: "verification_status"
      expr: verification_status
      comment: "Verification status for carbon savings credibility and ESG reporting integrity."
    - name: "initiative_role"
      expr: initiative_role
      comment: "Role of participant in the initiative for contribution analysis."
    - name: "recognition_awarded"
      expr: recognition_awarded
      comment: "Recognition awarded flag for incentive program effectiveness analysis."
    - name: "training_completed"
      expr: training_completed
      comment: "Training completion flag for workforce sustainability education tracking."
  measures:
    - name: "total_carbon_saved_kg"
      expr: SUM(CAST(carbon_saved_kg AS DOUBLE))
      comment: "Total verified carbon savings in kg. Primary ESG KPI for workforce sustainability contribution."
    - name: "total_estimated_carbon_saved_kg"
      expr: SUM(CAST(estimated_carbon_saved_kg AS DOUBLE))
      comment: "Total estimated carbon savings. Tracks projected vs verified savings gap for ESG reporting accuracy."
    - name: "total_hours_contributed"
      expr: SUM(CAST(hours_contributed AS DOUBLE))
      comment: "Total workforce hours contributed to carbon reduction activities. Measures workforce engagement depth."
    - name: "total_incentive_amount"
      expr: SUM(CAST(incentive_amount AS DOUBLE))
      comment: "Total incentive payments for carbon reduction participation. Tracks sustainability incentive program spend."
    - name: "total_participations"
      expr: COUNT(carbon_reduction_participation_id)
      comment: "Total participation records. Tracks workforce engagement breadth in sustainability programs."
    - name: "verified_participations"
      expr: COUNT(CASE WHEN verified_flag = TRUE THEN carbon_reduction_participation_id END)
      comment: "Count of verified participations. Tracks credible carbon savings for external ESG disclosure."
    - name: "distinct_workers_participating"
      expr: COUNT(DISTINCT craft_worker_id)
      comment: "Distinct workers participating in carbon reduction initiatives. Tracks workforce sustainability engagement rate."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`workforce_craft_certification`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Workforce certification compliance metrics tracking expiry, regulatory status, and site access eligibility. Critical for HSE compliance, regulatory audits, and project qualification requirements."
  source: "`vibe_construction_v1`.`workforce`.`craft_certification`"
  dimensions:
    - name: "skill_trade_id"
      expr: skill_trade_id
      comment: "Skill trade for trade-level certification compliance analysis."
    - name: "certification_type"
      expr: certification_type
      comment: "Certification type for compliance category analysis."
    - name: "certification_level"
      expr: certification_level
      comment: "Certification level for workforce qualification tier analysis."
    - name: "issuing_body"
      expr: issuing_body
      comment: "Issuing authority for certification validity and recognition analysis."
    - name: "verification_status"
      expr: verification_status
      comment: "Verification status (Verified, Pending, Rejected) for compliance readiness tracking."
    - name: "regulatory_compliance_flag"
      expr: regulatory_compliance_flag
      comment: "Flag indicating regulatory compliance requirement. Filters safety-critical certifications."
    - name: "site_access_required_flag"
      expr: site_access_required_flag
      comment: "Flag for certifications required for site access. Tracks gate compliance risk."
    - name: "renewal_required_flag"
      expr: renewal_required_flag
      comment: "Flag for certifications requiring renewal. Drives proactive renewal management."
    - name: "issuing_country_code"
      expr: issuing_country_code
      comment: "Country of certification issuance for multi-jurisdiction compliance tracking."
  measures:
    - name: "total_certifications"
      expr: COUNT(craft_certification_id)
      comment: "Total certification records. Baseline for workforce qualification inventory."
    - name: "verified_certifications"
      expr: COUNT(CASE WHEN verification_status = 'Verified' THEN craft_certification_id END)
      comment: "Count of verified certifications. Tracks workforce qualification readiness."
    - name: "expired_certifications"
      expr: COUNT(CASE WHEN expiry_date < CURRENT_DATE() THEN craft_certification_id END)
      comment: "Count of expired certifications. Expired certs are a site access and regulatory compliance risk."
    - name: "expiring_within_30_days"
      expr: COUNT(CASE WHEN expiry_date BETWEEN CURRENT_DATE() AND DATE_ADD(CURRENT_DATE(), 30) THEN craft_certification_id END)
      comment: "Certifications expiring within 30 days. Leading indicator for proactive renewal action."
    - name: "regulatory_non_compliant_count"
      expr: COUNT(CASE WHEN regulatory_compliance_flag = TRUE AND verification_status != 'Verified' THEN craft_certification_id END)
      comment: "Regulatory certifications not yet verified. Represents direct compliance exposure requiring escalation."
    - name: "distinct_certified_workers"
      expr: COUNT(DISTINCT craft_worker_id)
      comment: "Count of distinct workers with at least one certification record. Tracks qualified workforce pool size."
    - name: "avg_training_hours_required"
      expr: AVG(CAST(training_hours_required AS DOUBLE))
      comment: "Average training hours required per certification. Informs training budget and scheduling."
$$;

CREATE OR REPLACE VIEW `construction_ecm`.`_metrics`.`workforce_craft_worker_headcount`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Headcount and compensation metrics for craft workers."
  source: "`construction_ecm`.`workforce`.`craft_worker`"
  dimensions:
    - name: "skill_trade_id"
      expr: skill_trade_id
      comment: "Skill trade identifier"
    - name: "craft_code"
      expr: craft_code
      comment: "Craft code"
    - name: "union_affiliation_flag"
      expr: union_affiliation_flag
      comment: "Union affiliation flag"
    - name: "supervisory_role_flag"
      expr: supervisory_role_flag
      comment: "Whether worker holds supervisory role"
  measures:
    - name: "craft_worker_count"
      expr: COUNT(1)
      comment: "Number of craft workers"
    - name: "average_hourly_base_rate"
      expr: AVG(CAST(hourly_base_rate AS DOUBLE))
      comment: "Average hourly base rate"
    - name: "average_overtime_rate_multiplier"
      expr: AVG(CAST(overtime_rate_multiplier AS DOUBLE))
      comment: "Average overtime rate multiplier"
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`workforce_crew`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Crew composition, productivity, and safety metrics for operational workforce management. Enables crew performance benchmarking, union vs non-union analysis, and mobilization status tracking."
  source: "`vibe_construction_v1`.`workforce`.`crew`"
  dimensions:
    - name: "construction_project_id"
      expr: construction_project_id
      comment: "Project for project-level crew deployment analysis."
    - name: "crew_type"
      expr: crew_type
      comment: "Crew type classification for trade-mix and crew composition analysis."
    - name: "crew_status"
      expr: crew_status
      comment: "Current crew status (Active, Demobilized, Standby) for workforce availability tracking."
    - name: "shift_type"
      expr: shift_type
      comment: "Shift type for day vs night crew performance comparison."
    - name: "is_union_crew"
      expr: is_union_crew
      comment: "Union vs non-union flag for labor agreement compliance and cost comparison."
    - name: "union_affiliation"
      expr: union_affiliation
      comment: "Union affiliation for jurisdictional labor analysis."
    - name: "cost_code_id"
      expr: cost_code_id
      comment: "Cost code for crew cost allocation."
    - name: "cost_center_id"
      expr: cost_center_id
      comment: "Cost center for financial reporting of crew costs."
  measures:
    - name: "total_active_crews"
      expr: COUNT(CASE WHEN crew_status = 'Active' THEN crew_id END)
      comment: "Count of currently active crews. Tracks deployed workforce capacity."
    - name: "avg_crew_productivity_rate"
      expr: AVG(CAST(productivity_rate AS DOUBLE))
      comment: "Average productivity rate across crews. Benchmarks crew output for performance management."
    - name: "avg_crew_hourly_rate"
      expr: AVG(CAST(average_hourly_rate AS DOUBLE))
      comment: "Average blended hourly rate across crews. Tracks labor cost trends and rate escalation."
    - name: "total_crew_count"
      expr: COUNT(crew_id)
      comment: "Total number of crew records. Baseline headcount metric for workforce planning."
    - name: "union_crew_count"
      expr: COUNT(CASE WHEN is_union_crew = TRUE THEN crew_id END)
      comment: "Count of union crews. Tracks union labor compliance and agreement coverage."
    - name: "crews_with_recent_safety_incident"
      expr: COUNT(CASE WHEN last_safety_incident_date IS NOT NULL THEN crew_id END)
      comment: "Count of crews with a recorded safety incident. Drives safety intervention prioritization."
$$;

CREATE OR REPLACE VIEW `construction_ecm`.`_metrics`.`workforce_crew_productivity`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Crew-level productivity and cost metrics."
  source: "`construction_ecm`.`workforce`.`crew`"
  dimensions:
    - name: "crew_type"
      expr: crew_type
      comment: "Type of crew (e.g., trade, subcontract)"
    - name: "crew_status"
      expr: crew_status
      comment: "Current status of the crew"
    - name: "is_union_crew"
      expr: is_union_crew
      comment: "Whether the crew is unionized"
  measures:
    - name: "crew_count"
      expr: COUNT(1)
      comment: "Number of crew records"
    - name: "average_hourly_rate"
      expr: AVG(CAST(average_hourly_rate AS DOUBLE))
      comment: "Average hourly rate across crews"
    - name: "average_productivity_rate"
      expr: AVG(CAST(productivity_rate AS DOUBLE))
      comment: "Average productivity rate"
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`workforce_crew_assignment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Crew and worker assignment metrics tracking mobilization, HSE orientation compliance, and assignment utilization across projects and WBS elements."
  source: "`vibe_construction_v1`.`workforce`.`crew_assignment`"
  dimensions:
    - name: "construction_project_id"
      expr: construction_project_id
      comment: "Project for cross-project assignment analysis."
    - name: "wbs_element_id"
      expr: wbs_element_id
      comment: "WBS element for hierarchical assignment tracking."
    - name: "activity_id"
      expr: activity_id
      comment: "Schedule activity for resource-to-activity assignment analysis."
    - name: "assignment_status"
      expr: assignment_status
      comment: "Assignment status (Active, Completed, Cancelled) for workforce utilization tracking."
    - name: "assignment_type"
      expr: assignment_type
      comment: "Assignment type for workforce deployment pattern analysis."
    - name: "craft_type"
      expr: craft_type
      comment: "Craft type for trade-mix analysis on assignments."
    - name: "shift_type"
      expr: shift_type
      comment: "Shift type for shift-based assignment analysis."
    - name: "billable_flag"
      expr: billable_flag
      comment: "Billable flag for client billing coverage analysis."
    - name: "union_affiliation"
      expr: union_affiliation
      comment: "Union affiliation for labor agreement compliance tracking."
    - name: "cost_code_id"
      expr: cost_code_id
      comment: "Cost code for assignment cost allocation."
  measures:
    - name: "total_assignments"
      expr: COUNT(crew_assignment_id)
      comment: "Total crew/worker assignments. Baseline metric for workforce deployment volume."
    - name: "active_assignments"
      expr: COUNT(CASE WHEN assignment_status = 'Active' THEN crew_assignment_id END)
      comment: "Currently active assignments. Tracks live workforce deployment on projects."
    - name: "hse_orientation_compliance_count"
      expr: COUNT(CASE WHEN hse_orientation_completed_flag = TRUE THEN crew_assignment_id END)
      comment: "Assignments with completed HSE orientation. Tracks safety induction compliance — a regulatory requirement."
    - name: "hse_orientation_non_compliant_count"
      expr: COUNT(CASE WHEN hse_orientation_completed_flag = FALSE THEN crew_assignment_id END)
      comment: "Assignments without completed HSE orientation. High count is a safety compliance risk requiring immediate action."
    - name: "ppe_issued_count"
      expr: COUNT(CASE WHEN ppe_issued_flag = TRUE THEN crew_assignment_id END)
      comment: "Assignments where PPE has been issued. Tracks PPE distribution compliance."
    - name: "avg_labor_rate"
      expr: AVG(CAST(labor_rate AS DOUBLE))
      comment: "Average labor rate across assignments. Monitors blended rate trends for cost forecasting."
    - name: "total_labor_cost_estimate"
      expr: SUM(CAST(labor_rate AS DOUBLE))
      comment: "Sum of labor rates as a proxy for total assignment labor cost commitment. Supports budget commitment tracking."
    - name: "billable_assignment_count"
      expr: COUNT(CASE WHEN billable_flag = TRUE THEN crew_assignment_id END)
      comment: "Count of billable assignments. Drives revenue recovery and billing efficiency analysis."
    - name: "distinct_workers_assigned"
      expr: COUNT(DISTINCT craft_worker_id)
      comment: "Distinct workers with active assignments. Tracks unique headcount deployed across projects."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`workforce_labor_mobilization`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Labor mobilization cost and logistics metrics tracking mobilization spend, per diem eligibility, and HSE orientation compliance across project deployments."
  source: "`vibe_construction_v1`.`workforce`.`labor_mobilization`"
  dimensions:
    - name: "destination_construction_project_id"
      expr: destination_construction_project_id
      comment: "Destination project for mobilization cost allocation."
    - name: "mobilization_status"
      expr: mobilization_status
      comment: "Mobilization status (Planned, In Progress, Completed, Cancelled) for deployment pipeline tracking."
    - name: "mobilization_type"
      expr: mobilization_type
      comment: "Mobilization type (Initial, Transfer, Demobilization) for workforce flow analysis."
    - name: "travel_mode"
      expr: travel_mode
      comment: "Travel mode for logistics cost benchmarking."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency for multi-currency cost normalization."
    - name: "per_diem_eligible_flag"
      expr: per_diem_eligible_flag
      comment: "Per diem eligibility flag for accommodation cost planning."
    - name: "hse_orientation_completed_flag"
      expr: hse_orientation_completed_flag
      comment: "HSE orientation completion flag for safety compliance tracking at mobilization."
    - name: "accommodation_required_flag"
      expr: accommodation_required_flag
      comment: "Accommodation requirement flag for logistics planning."
  measures:
    - name: "total_mobilization_cost"
      expr: SUM(CAST(total_mobilization_cost AS DOUBLE))
      comment: "Total mobilization cost across all records. Key input for project indirect cost budgeting."
    - name: "total_travel_cost_estimate"
      expr: SUM(CAST(travel_cost_estimate AS DOUBLE))
      comment: "Total estimated travel cost. Tracks logistics spend against mobilization budget."
    - name: "total_accommodation_cost_estimate"
      expr: SUM(CAST(accommodation_cost_estimate AS DOUBLE))
      comment: "Total estimated accommodation cost. Tracks camp and lodging spend for remote projects."
    - name: "total_per_diem_cost"
      expr: SUM(CAST(per_diem_rate AS DOUBLE))
      comment: "Total per diem rate commitment. Tracks subsistence cost exposure for mobilized workforce."
    - name: "avg_mobilization_cost"
      expr: AVG(CAST(total_mobilization_cost AS DOUBLE))
      comment: "Average mobilization cost per record. Benchmarks mobilization efficiency across projects."
    - name: "total_mobilizations"
      expr: COUNT(labor_mobilization_id)
      comment: "Total mobilization events. Tracks workforce deployment volume and logistics complexity."
    - name: "hse_orientation_compliant_mobilizations"
      expr: COUNT(CASE WHEN hse_orientation_completed_flag = TRUE THEN labor_mobilization_id END)
      comment: "Mobilizations with completed HSE orientation. Tracks safety induction compliance at point of deployment."
    - name: "hse_orientation_non_compliant_mobilizations"
      expr: COUNT(CASE WHEN hse_orientation_completed_flag = FALSE THEN labor_mobilization_id END)
      comment: "Mobilizations without HSE orientation. Non-compliant mobilizations are a safety and regulatory risk."
    - name: "site_badge_issued_count"
      expr: COUNT(CASE WHEN site_access_badge_issued_flag = TRUE THEN labor_mobilization_id END)
      comment: "Mobilizations with site access badge issued. Tracks access provisioning completeness."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`workforce_labor_rate`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Labor rate structure and cost burden metrics for project cost estimation, bid preparation, and payroll compliance. Tracks loaded rates, fringe benefits, and prevailing wage compliance."
  source: "`vibe_construction_v1`.`workforce`.`labor_rate`"
  dimensions:
    - name: "construction_project_id"
      expr: construction_project_id
      comment: "Project for project-specific rate analysis."
    - name: "rate_type"
      expr: rate_type
      comment: "Rate type (Prevailing Wage, Union, Open Shop) for labor cost structure analysis."
    - name: "rate_status"
      expr: rate_status
      comment: "Rate status (Active, Expired, Pending) for rate schedule governance."
    - name: "skill_level"
      expr: skill_level
      comment: "Skill level for rate tier analysis."
    - name: "trade_classification"
      expr: trade_classification
      comment: "Trade classification for cross-trade rate benchmarking."
    - name: "jurisdiction"
      expr: jurisdiction
      comment: "Jurisdiction for prevailing wage and multi-state compliance analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency for multi-currency rate normalization."
    - name: "certified_payroll_required_flag"
      expr: certified_payroll_required_flag
      comment: "Certified payroll requirement flag for Davis-Bacon and prevailing wage compliance tracking."
    - name: "union_local"
      expr: union_local
      comment: "Union local for CBA rate schedule analysis."
  measures:
    - name: "avg_base_hourly_rate"
      expr: AVG(CAST(base_hourly_rate AS DOUBLE))
      comment: "Average base hourly rate across rate records. Benchmarks labor cost baseline for estimating."
    - name: "avg_total_loaded_hourly_rate"
      expr: AVG(CAST(total_loaded_hourly_rate AS DOUBLE))
      comment: "Average fully loaded hourly rate including burden. Primary input for project cost estimation and bid pricing."
    - name: "avg_overtime_hourly_rate"
      expr: AVG(CAST(overtime_hourly_rate AS DOUBLE))
      comment: "Average overtime hourly rate. Tracks premium pay cost exposure for schedule risk analysis."
    - name: "avg_fringe_benefit_rate"
      expr: AVG(CAST(fringe_benefit_rate AS DOUBLE))
      comment: "Average fringe benefit rate. Tracks benefits cost burden for total compensation analysis."
    - name: "avg_payroll_burden_percentage"
      expr: AVG(CAST(payroll_burden_percentage AS DOUBLE))
      comment: "Average payroll burden percentage. Benchmarks indirect labor cost loading across projects and jurisdictions."
    - name: "avg_overhead_percentage"
      expr: AVG(CAST(overhead_percentage AS DOUBLE))
      comment: "Average overhead percentage applied to labor. Tracks indirect cost loading for bid and budget accuracy."
    - name: "total_active_rate_records"
      expr: COUNT(CASE WHEN rate_status = 'Active' THEN labor_rate_id END)
      comment: "Count of active labor rate records. Tracks rate schedule completeness for project coverage."
    - name: "certified_payroll_required_count"
      expr: COUNT(CASE WHEN certified_payroll_required_flag = TRUE THEN labor_rate_id END)
      comment: "Count of rate records requiring certified payroll. Tracks prevailing wage compliance scope."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`workforce_production_rate`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Field productivity and production rate metrics comparing planned vs actual output. Drives earned value analysis, crew efficiency benchmarking, and schedule performance management."
  source: "`vibe_construction_v1`.`workforce`.`production_rate`"
  dimensions:
    - name: "construction_project_id"
      expr: construction_project_id
      comment: "Project for cross-project productivity benchmarking."
    - name: "cost_code_id"
      expr: cost_code_id
      comment: "Cost code for activity-level productivity tracking."
    - name: "wbs_element_id"
      expr: wbs_element_id
      comment: "WBS element for hierarchical productivity roll-up."
    - name: "crew_id"
      expr: crew_id
      comment: "Crew identifier for crew-level performance comparison."
    - name: "work_date"
      expr: work_date
      comment: "Date of production record for daily trend analysis."
    - name: "trade_category"
      expr: trade_category
      comment: "Trade category for cross-trade productivity benchmarking."
    - name: "unit_of_measure"
      expr: unit_of_measure
      comment: "Unit of measure for production quantity normalization."
    - name: "shift"
      expr: shift
      comment: "Shift for day vs night productivity comparison."
    - name: "weather_condition"
      expr: weather_condition
      comment: "Weather condition to correlate environmental factors with productivity loss."
    - name: "site_condition"
      expr: site_condition
      comment: "Site condition for productivity impact analysis."
    - name: "rework_flag"
      expr: rework_flag
      comment: "Rework flag to isolate productive vs rework output."
    - name: "safety_incident_flag"
      expr: safety_incident_flag
      comment: "Safety incident flag to correlate incidents with productivity impact."
  measures:
    - name: "total_actual_quantity"
      expr: SUM(CAST(actual_quantity AS DOUBLE))
      comment: "Total actual units produced. Primary output measure for earned value and schedule performance."
    - name: "total_planned_quantity"
      expr: SUM(CAST(planned_quantity AS DOUBLE))
      comment: "Total planned units of production. Denominator for quantity performance index."
    - name: "total_earned_hours"
      expr: SUM(CAST(earned_hours AS DOUBLE))
      comment: "Total earned hours based on actual production. Core earned value metric (BCWP hours)."
    - name: "total_expended_hours"
      expr: SUM(CAST(expended_hours AS DOUBLE))
      comment: "Total actual hours expended. Denominator for labor efficiency ratio."
    - name: "total_variance_quantity"
      expr: SUM(CAST(variance_quantity AS DOUBLE))
      comment: "Total quantity variance (actual minus planned). Negative values indicate production shortfall."
    - name: "total_variance_hours"
      expr: SUM(CAST(variance_hours AS DOUBLE))
      comment: "Total hours variance. Positive variance means over-expenditure vs earned hours."
    - name: "avg_actual_production_rate"
      expr: AVG(CAST(actual_production_rate AS DOUBLE))
      comment: "Average actual production rate across records. Benchmarks crew output against planned rates."
    - name: "avg_planned_production_rate"
      expr: AVG(CAST(planned_production_rate AS DOUBLE))
      comment: "Average planned production rate. Baseline for productivity performance index calculation."
    - name: "avg_productivity_factor"
      expr: AVG(CAST(productivity_factor AS DOUBLE))
      comment: "Average productivity factor (actual/planned ratio). Values below 1.0 indicate underperformance requiring intervention."
    - name: "records_with_safety_incident"
      expr: COUNT(CASE WHEN safety_incident_flag = TRUE THEN production_rate_id END)
      comment: "Count of production records with associated safety incidents. Tracks safety-productivity correlation."
    - name: "records_with_rework"
      expr: COUNT(CASE WHEN rework_flag = TRUE THEN production_rate_id END)
      comment: "Count of production records flagged as rework. Quantifies quality-driven productivity loss."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`workforce_site_access_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Site access and workforce gate compliance metrics tracking PPE compliance, health screening, and access denial rates. Drives HSE compliance monitoring and site security management."
  source: "`vibe_construction_v1`.`workforce`.`site_access_record`"
  dimensions:
    - name: "construction_project_id"
      expr: construction_project_id
      comment: "Project for site-level access compliance analysis."
    - name: "access_direction"
      expr: access_direction
      comment: "Access direction (Entry, Exit) for site occupancy tracking."
    - name: "access_zone"
      expr: access_zone
      comment: "Access zone for zone-level occupancy and compliance analysis."
    - name: "authorization_status"
      expr: authorization_status
      comment: "Authorization status (Authorized, Denied, Pending) for access control effectiveness."
    - name: "ppe_compliance_status"
      expr: ppe_compliance_status
      comment: "PPE compliance status at gate for safety compliance tracking."
    - name: "health_screening_status"
      expr: health_screening_status
      comment: "Health screening status for workforce health compliance monitoring."
    - name: "induction_status"
      expr: induction_status
      comment: "Site induction status for safety orientation compliance."
    - name: "worker_classification"
      expr: worker_classification
      comment: "Worker classification (Direct, Subcontractor, Visitor) for access population analysis."
    - name: "access_method"
      expr: access_method
      comment: "Access method (Badge, Biometric, Manual) for access control technology analysis."
  measures:
    - name: "total_access_events"
      expr: COUNT(site_access_record_id)
      comment: "Total site access events. Tracks gate throughput and site occupancy volume."
    - name: "denied_access_count"
      expr: COUNT(CASE WHEN authorization_status = 'Denied' THEN site_access_record_id END)
      comment: "Count of denied access events. High denial rate signals compliance gaps or unauthorized personnel."
    - name: "ppe_non_compliant_count"
      expr: COUNT(CASE WHEN ppe_compliance_status != 'Compliant' THEN site_access_record_id END)
      comment: "Access events with PPE non-compliance. Direct safety KPI requiring immediate corrective action."
    - name: "health_screening_failed_count"
      expr: COUNT(CASE WHEN health_screening_status = 'Failed' THEN site_access_record_id END)
      comment: "Access events with failed health screening. Tracks workforce health risk at site entry."
    - name: "induction_non_compliant_count"
      expr: COUNT(CASE WHEN induction_status != 'Completed' THEN site_access_record_id END)
      comment: "Access events where site induction is not completed. Regulatory compliance risk for HSE audits."
    - name: "distinct_workers_on_site"
      expr: COUNT(DISTINCT primary_site_craft_worker_id)
      comment: "Distinct workers accessing site. Tracks unique workforce headcount for site occupancy management."
    - name: "avg_duration_on_site_minutes"
      expr: AVG(CAST(duration_on_site_minutes AS DOUBLE))
      comment: "Average time workers spend on site per access event. Tracks workforce utilization and shift adherence."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`workforce_staffing_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Workforce staffing plan metrics comparing planned vs actual headcount and labor hours. Drives workforce capacity planning, ramp-up/ramp-down management, and sourcing strategy decisions."
  source: "`vibe_construction_v1`.`workforce`.`staffing_plan`"
  dimensions:
    - name: "construction_project_id"
      expr: construction_project_id
      comment: "Project for cross-project staffing plan comparison."
    - name: "skill_trade_id"
      expr: skill_trade_id
      comment: "Skill trade for trade-level staffing demand analysis."
    - name: "plan_status"
      expr: plan_status
      comment: "Plan status (Draft, Approved, Active, Closed) for plan lifecycle tracking."
    - name: "plan_type"
      expr: plan_type
      comment: "Plan type for staffing strategy classification."
    - name: "sourcing_strategy"
      expr: sourcing_strategy
      comment: "Sourcing strategy (Direct Hire, Agency, Subcontract) for workforce supply chain analysis."
    - name: "cost_center_id"
      expr: cost_center_id
      comment: "Cost center for staffing cost allocation."
    - name: "wbs_element_id"
      expr: wbs_element_id
      comment: "WBS element for hierarchical staffing plan roll-up."
    - name: "baseline_flag"
      expr: baseline_flag
      comment: "Baseline flag to distinguish approved baseline plans from revisions."
  measures:
    - name: "total_planned_labor_hours"
      expr: SUM(CAST(total_planned_labor_hours AS DOUBLE))
      comment: "Total planned labor hours across staffing plans. Primary input for project labor budget."
    - name: "total_actual_labor_hours"
      expr: SUM(CAST(actual_labor_hours AS DOUBLE))
      comment: "Total actual labor hours recorded against staffing plans. Drives plan vs actual variance analysis."
    - name: "labor_hours_variance"
      expr: SUM(CAST(labor_hours_variance AS DOUBLE))
      comment: "Total labor hours variance (actual minus planned). Negative variance indicates under-staffing risk."
    - name: "avg_peak_headcount"
      expr: AVG(CAST(peak_headcount AS DOUBLE))
      comment: "Average peak headcount across staffing plans. Benchmarks workforce surge capacity requirements."
    - name: "total_plans"
      expr: COUNT(staffing_plan_id)
      comment: "Total staffing plan records. Tracks planning activity volume across projects."
    - name: "approved_plans"
      expr: COUNT(CASE WHEN plan_status = 'Approved' THEN staffing_plan_id END)
      comment: "Count of approved staffing plans. Tracks planning governance and approval cycle completion."
    - name: "plans_with_accommodation_requirement"
      expr: COUNT(CASE WHEN accommodation_required_flag = TRUE THEN staffing_plan_id END)
      comment: "Plans requiring accommodation. Drives camp capacity and logistics planning for remote projects."
    - name: "plans_requiring_transport"
      expr: COUNT(CASE WHEN transportation_required_flag = TRUE THEN staffing_plan_id END)
      comment: "Plans requiring transportation. Tracks logistics complexity and associated indirect cost."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`workforce_timesheet`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core labor cost and hours metrics derived from approved timesheets. Drives payroll cost control, overtime management, and billable utilization analysis across projects and cost codes."
  source: "`vibe_construction_v1`.`workforce`.`timesheet`"
  dimensions:
    - name: "work_date"
      expr: work_date
      comment: "Calendar date of work performed, used for daily and weekly trend analysis."
    - name: "construction_project_id"
      expr: construction_project_id
      comment: "Project identifier for cross-project labor cost comparison."
    - name: "cost_code_id"
      expr: cost_code_id
      comment: "Cost code for budget vs actual labor cost tracking."
    - name: "craft_classification"
      expr: craft_classification
      comment: "Craft or trade classification of the worker for trade-mix analysis."
    - name: "approval_status"
      expr: approval_status
      comment: "Timesheet approval status (Approved, Pending, Rejected) for payroll readiness monitoring."
    - name: "shift_type"
      expr: shift_type
      comment: "Shift type (Day, Night, Swing) for shift-based productivity analysis."
    - name: "pay_type"
      expr: pay_type
      comment: "Pay type classification (Regular, Overtime, Double-time) for compensation analysis."
    - name: "is_billable"
      expr: is_billable
      comment: "Flag indicating whether hours are billable to the client, used for revenue recovery analysis."
    - name: "payroll_period"
      expr: payroll_period
      comment: "Payroll period identifier for period-over-period labor cost comparison."
    - name: "union_local"
      expr: union_local
      comment: "Union local affiliation for union vs non-union labor cost analysis."
    - name: "work_classification"
      expr: work_classification
      comment: "Work classification category for labor cost allocation."
  measures:
    - name: "total_regular_hours"
      expr: SUM(CAST(regular_hours AS DOUBLE))
      comment: "Total straight-time hours worked. Core input for payroll cost and productivity benchmarking."
    - name: "total_overtime_hours"
      expr: SUM(CAST(overtime_hours AS DOUBLE))
      comment: "Total overtime hours worked. Elevated overtime signals schedule pressure or under-staffing."
    - name: "total_double_time_hours"
      expr: SUM(CAST(double_time_hours AS DOUBLE))
      comment: "Total double-time hours worked. High double-time is a leading cost overrun indicator."
    - name: "total_hours_worked"
      expr: SUM(CAST(total_hours AS DOUBLE))
      comment: "Total hours across all pay types. Primary denominator for productivity and cost-per-hour KPIs."
    - name: "total_labor_cost"
      expr: SUM(CAST(labor_cost_amount AS DOUBLE))
      comment: "Total labor cost charged to projects. Key input for earned value and budget variance analysis."
    - name: "avg_labor_cost_per_hour"
      expr: AVG(labor_cost_amount / NULLIF(total_hours, 0))
      comment: "Average loaded labor cost per hour. Tracks blended rate trends and cost escalation."
    - name: "overtime_hours_ratio_numerator"
      expr: SUM(CAST(overtime_hours AS DOUBLE))
      comment: "Numerator for overtime ratio: total overtime hours. Combine with total_hours_worked to compute overtime intensity."
    - name: "billable_hours"
      expr: SUM(CASE WHEN is_billable = TRUE THEN total_hours ELSE 0 END)
      comment: "Hours flagged as billable to the client. Drives revenue recognition and billing efficiency."
    - name: "non_billable_hours"
      expr: SUM(CASE WHEN is_billable = FALSE THEN total_hours ELSE 0 END)
      comment: "Non-billable hours representing internal overhead or rework cost."
    - name: "total_production_quantity"
      expr: SUM(CAST(production_quantity AS DOUBLE))
      comment: "Total units of work produced as recorded on timesheets. Used to compute field productivity rates."
    - name: "approved_timesheet_count"
      expr: COUNT(CASE WHEN approval_status = 'Approved' THEN timesheet_id END)
      comment: "Count of approved timesheets. Tracks payroll processing readiness and approval cycle efficiency."
    - name: "pending_timesheet_count"
      expr: COUNT(CASE WHEN approval_status = 'Pending' THEN timesheet_id END)
      comment: "Count of timesheets awaiting approval. High pending count risks payroll delays and cost accrual gaps."
    - name: "distinct_workers_on_timesheets"
      expr: COUNT(DISTINCT craft_worker_id)
      comment: "Count of distinct craft workers with timesheet entries. Tracks active workforce size per period."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`workforce_timesheet_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Granular labor cost and hours metrics at the timesheet line level, enabling cost-code-level productivity, rework detection, and payroll posting status tracking."
  source: "`vibe_construction_v1`.`workforce`.`timesheet_line`"
  dimensions:
    - name: "work_date"
      expr: work_date
      comment: "Date of work for daily granularity analysis."
    - name: "construction_project_id"
      expr: construction_project_id
      comment: "Project for cross-project labor cost allocation."
    - name: "cost_code_id"
      expr: cost_code_id
      comment: "Cost code for budget vs actual variance at the WBS level."
    - name: "wbs_element_id"
      expr: wbs_element_id
      comment: "WBS element for hierarchical cost roll-up."
    - name: "activity_id"
      expr: activity_id
      comment: "Schedule activity for earned value and productivity analysis."
    - name: "craft_code"
      expr: craft_code
      comment: "Craft code for trade-level labor cost breakdown."
    - name: "approval_status"
      expr: approval_status
      comment: "Line-level approval status for payroll readiness."
    - name: "is_billable"
      expr: is_billable
      comment: "Billable flag for client billing reconciliation."
    - name: "is_rework"
      expr: is_rework
      comment: "Rework flag to isolate non-productive labor cost."
    - name: "posted_to_job_cost_flag"
      expr: posted_to_job_cost_flag
      comment: "Indicates whether the line has been posted to job cost, critical for cost accrual completeness."
    - name: "posted_to_payroll_flag"
      expr: posted_to_payroll_flag
      comment: "Indicates payroll posting status for payroll reconciliation."
    - name: "shift_code"
      expr: shift_code
      comment: "Shift code for shift-based cost analysis."
  measures:
    - name: "total_regular_hours"
      expr: SUM(CAST(regular_hours AS DOUBLE))
      comment: "Total regular hours at line level for granular cost-code productivity analysis."
    - name: "total_overtime_hours"
      expr: SUM(CAST(overtime_hours AS DOUBLE))
      comment: "Total overtime hours at line level. Identifies cost-code-level overtime concentration."
    - name: "total_double_time_hours"
      expr: SUM(CAST(double_time_hours AS DOUBLE))
      comment: "Total double-time hours at line level for premium pay cost tracking."
    - name: "total_hours"
      expr: SUM(CAST(total_hours AS DOUBLE))
      comment: "Total hours across all pay types at line level. Primary productivity denominator."
    - name: "total_labor_cost"
      expr: SUM(CAST(labor_cost_amount AS DOUBLE))
      comment: "Total labor cost at line level. Enables cost-code-level budget variance analysis."
    - name: "rework_hours"
      expr: SUM(CASE WHEN is_rework = TRUE THEN total_hours ELSE 0 END)
      comment: "Hours spent on rework. High rework hours signal quality issues and drive cost overruns."
    - name: "rework_labor_cost"
      expr: SUM(CASE WHEN is_rework = TRUE THEN labor_cost_amount ELSE 0 END)
      comment: "Labor cost attributable to rework. Direct measure of quality-driven cost waste."
    - name: "unposted_hours_to_job_cost"
      expr: SUM(CASE WHEN posted_to_job_cost_flag = FALSE THEN total_hours ELSE 0 END)
      comment: "Hours not yet posted to job cost. Tracks accrual completeness risk for period-end close."
    - name: "total_production_quantity"
      expr: SUM(CAST(production_quantity AS DOUBLE))
      comment: "Total production units at line level for unit-rate productivity benchmarking."
    - name: "distinct_workers"
      expr: COUNT(DISTINCT craft_worker_id)
      comment: "Distinct workers with line entries. Tracks active headcount at cost-code granularity."
$$;
