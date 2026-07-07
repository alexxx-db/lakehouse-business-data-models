-- Metric views for domain: realestate | Business: Restaurants | Version: 2 | Generated on: 2026-07-02 03:10:25

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`realestate_lease_portfolio`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic lease portfolio metrics covering occupancy cost, financial exposure, and lease term management. Used by Real Estate VPs and CFOs to manage portfolio risk and cost."
  source: "`vibe_restaurants_v1`.`realestate`.`lease`"
  dimensions:
    - name: "lease_type"
      expr: lease_type
      comment: "Type of lease (e.g., ground lease, building lease, sublease) for portfolio segmentation."
    - name: "lease_status"
      expr: lease_status
      comment: "Current status of the lease (active, expired, terminated, pending renewal) for lifecycle tracking."
    - name: "accounting_classification"
      expr: accounting_classification
      comment: "IFRS 16 / ASC 842 accounting classification (operating vs. finance lease) for financial reporting."
    - name: "rent_escalation_type"
      expr: rent_escalation_type
      comment: "Type of rent escalation clause (fixed, CPI, percentage) to assess future cost exposure."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the lease for multi-currency portfolio analysis."
    - name: "commencement_year"
      expr: YEAR(commencement_date)
      comment: "Year the lease commenced, used for vintage cohort analysis."
  measures:
    - name: "total_active_leases"
      expr: COUNT(1)
      comment: "Total number of lease records. Baseline portfolio size metric for Real Estate leadership."
    - name: "total_annual_base_rent"
      expr: SUM(CAST(base_rent_amount AS DOUBLE))
      comment: "Sum of all base rent amounts across the portfolio. Core occupancy cost KPI for CFO and Real Estate VP."
    - name: "avg_base_rent_per_lease"
      expr: AVG(CAST(base_rent_amount AS DOUBLE))
      comment: "Average base rent per lease. Benchmarks individual lease cost against portfolio average."
    - name: "total_annual_cam_charges"
      expr: SUM(CAST(cam_charges_annual AS DOUBLE))
      comment: "Total annual CAM (Common Area Maintenance) charges across all leases. Significant occupancy cost component."
    - name: "total_security_deposits"
      expr: SUM(CAST(security_deposit_amount AS DOUBLE))
      comment: "Total security deposits held across the portfolio. Represents locked capital that could be redeployed."
    - name: "total_rou_asset_value"
      expr: SUM(CAST(rou_asset_value AS DOUBLE))
      comment: "Total Right-of-Use asset value across all leases. Critical IFRS 16 / ASC 842 balance sheet metric."
    - name: "total_lease_liability_value"
      expr: SUM(CAST(liability_value AS DOUBLE))
      comment: "Total lease liability value across the portfolio. Key balance sheet exposure metric for CFO and auditors."
    - name: "avg_rent_escalation_rate"
      expr: AVG(CAST(rent_escalation_rate AS DOUBLE))
      comment: "Average rent escalation rate across leases. Forecasts future rent cost growth trajectory."
    - name: "total_termination_penalty_exposure"
      expr: SUM(CAST(termination_penalty_amount AS DOUBLE))
      comment: "Total potential termination penalty exposure across the portfolio. Risk metric for lease exit strategy decisions."
    - name: "leases_with_termination_clause"
      expr: COUNT(CASE WHEN termination_clause_flag = TRUE THEN 1 END)
      comment: "Number of leases with termination clauses. Measures portfolio flexibility for strategic exit options."
    - name: "leases_with_co_tenancy_clause"
      expr: COUNT(CASE WHEN co_tenancy_clause_flag = TRUE THEN 1 END)
      comment: "Number of leases with co-tenancy clauses. Identifies leases at risk if anchor tenants depart."
    - name: "avg_percentage_rent_rate"
      expr: AVG(CAST(percentage_rent_rate AS DOUBLE))
      comment: "Average percentage rent rate across leases. Informs revenue-linked rent exposure in high-sales locations."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`realestate_rent_payment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Rent payment performance and cash flow metrics. Used by Finance and Real Estate teams to monitor payment compliance, late fees, and occupancy cost actuals."
  source: "`vibe_restaurants_v1`.`realestate`.`rent_payment`"
  dimensions:
    - name: "payment_status"
      expr: payment_status
      comment: "Status of the rent payment (paid, pending, overdue, disputed) for cash flow monitoring."
    - name: "payment_method"
      expr: payment_method
      comment: "Method used for payment (ACH, wire, check) for treasury operations analysis."
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period of the payment for period-over-period financial reporting."
    - name: "reconciliation_status"
      expr: reconciliation_status
      comment: "Reconciliation status of the payment for accounting close process tracking."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the payment for multi-currency cash flow analysis."
    - name: "payment_month"
      expr: DATE_TRUNC('MONTH', payment_date)
      comment: "Month of payment for trend analysis of rent cash outflows."
    - name: "dispute_flag"
      expr: dispute_flag
      comment: "Whether the payment is under dispute. Segments disputed vs. clean payments for risk monitoring."
  measures:
    - name: "total_rent_payments"
      expr: COUNT(1)
      comment: "Total number of rent payment transactions. Baseline volume metric."
    - name: "total_payment_amount"
      expr: SUM(CAST(total_payment_amount AS DOUBLE))
      comment: "Total actual rent paid across all payments. Primary occupancy cash outflow KPI for CFO."
    - name: "total_base_rent_paid"
      expr: SUM(CAST(base_rent_amount AS DOUBLE))
      comment: "Total base rent component of all payments. Isolates core rent cost from ancillary charges."
    - name: "total_cam_paid"
      expr: SUM(CAST(cam_amount AS DOUBLE))
      comment: "Total CAM charges paid. Tracks operating expense pass-through costs."
    - name: "total_late_fees_incurred"
      expr: SUM(CAST(late_fee_amount AS DOUBLE))
      comment: "Total late fees paid. Measures payment discipline and avoidable cost leakage."
    - name: "total_property_tax_paid"
      expr: SUM(CAST(property_tax_amount AS DOUBLE))
      comment: "Total property tax component paid. Tracks tax pass-through occupancy cost."
    - name: "total_payment_variance"
      expr: SUM(CAST(payment_variance_amount AS DOUBLE))
      comment: "Total variance between scheduled and actual payment amounts. Flags systematic over/under-payment patterns."
    - name: "late_payment_count"
      expr: COUNT(CASE WHEN late_fee_applied_flag = TRUE THEN 1 END)
      comment: "Number of payments where a late fee was applied. Measures payment compliance rate."
    - name: "disputed_payment_count"
      expr: COUNT(CASE WHEN dispute_flag = TRUE THEN 1 END)
      comment: "Number of payments under dispute. Tracks landlord relationship friction and financial risk."
    - name: "avg_payment_amount"
      expr: AVG(CAST(total_payment_amount AS DOUBLE))
      comment: "Average rent payment amount. Benchmarks individual payments against portfolio norms."
    - name: "total_insurance_paid"
      expr: SUM(CAST(insurance_amount AS DOUBLE))
      comment: "Total insurance charges paid as part of rent. Tracks insurance cost component of occupancy."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`realestate_site_portfolio`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Site portfolio performance and investment metrics. Used by Real Estate and Development teams to evaluate site quality, investment levels, and growth pipeline."
  source: "`vibe_restaurants_v1`.`realestate`.`site`"
  dimensions:
    - name: "site_type"
      expr: site_type
      comment: "Type of site (freestanding, inline, end-cap, drive-thru) for format-based portfolio analysis."
    - name: "ownership_status"
      expr: ownership_status
      comment: "Whether the site is owned or leased. Critical for balance sheet and capital allocation decisions."
    - name: "lifecycle_stage"
      expr: lifecycle_stage
      comment: "Current lifecycle stage of the site (prospecting, development, operating, closed) for pipeline management."
    - name: "market_classification"
      expr: market_classification
      comment: "Market tier classification (urban, suburban, rural) for market-level performance benchmarking."
    - name: "city"
      expr: city
      comment: "City where the site is located for geographic performance analysis."
    - name: "state_province"
      expr: state_province
      comment: "State or province for regional portfolio analysis."
    - name: "country_code"
      expr: country_code
      comment: "Country code for international portfolio segmentation."
    - name: "drive_thru_capable"
      expr: drive_thru_capable
      comment: "Whether the site has drive-thru capability. Key format differentiator for revenue and throughput analysis."
    - name: "zoning_classification"
      expr: zoning_classification
      comment: "Zoning classification of the site for development feasibility and compliance tracking."
    - name: "opening_year"
      expr: YEAR(opening_date)
      comment: "Year the site opened for vintage cohort analysis of site performance."
  measures:
    - name: "total_sites"
      expr: COUNT(1)
      comment: "Total number of sites in the portfolio. Baseline footprint metric for Real Estate leadership."
    - name: "total_capex_investment"
      expr: SUM(CAST(total_capex_investment AS DOUBLE))
      comment: "Total capital invested across all sites. Core capital allocation KPI for CFO and Real Estate VP."
    - name: "avg_capex_per_site"
      expr: AVG(CAST(total_capex_investment AS DOUBLE))
      comment: "Average capital investment per site. Benchmarks development cost efficiency across the portfolio."
    - name: "total_projected_auv"
      expr: SUM(CAST(projected_auv AS DOUBLE))
      comment: "Total projected Annual Unit Volume across the pipeline. Forecasts revenue potential of the development pipeline."
    - name: "avg_projected_auv"
      expr: AVG(CAST(projected_auv AS DOUBLE))
      comment: "Average projected AUV per site. Benchmarks expected revenue productivity of new sites."
    - name: "total_monthly_base_rent"
      expr: SUM(CAST(monthly_base_rent AS DOUBLE))
      comment: "Total monthly base rent obligation across all leased sites. Key recurring occupancy cost metric."
    - name: "avg_monthly_cam_charges"
      expr: AVG(CAST(monthly_cam_charges AS DOUBLE))
      comment: "Average monthly CAM charges per site. Benchmarks operating cost pass-throughs across the portfolio."
    - name: "avg_accessibility_score"
      expr: AVG(CAST(accessibility_score AS DOUBLE))
      comment: "Average site accessibility score. Measures portfolio-wide site quality for customer convenience."
    - name: "avg_visibility_score"
      expr: AVG(CAST(visibility_score AS DOUBLE))
      comment: "Average site visibility score. Tracks marketing and brand exposure quality across the portfolio."
    - name: "drive_thru_site_count"
      expr: COUNT(CASE WHEN drive_thru_capable = TRUE THEN 1 END)
      comment: "Number of drive-thru capable sites. Tracks format mix for throughput and revenue strategy."
    - name: "avg_percentage_rent_rate"
      expr: AVG(CAST(percentage_rent_rate AS DOUBLE))
      comment: "Average percentage rent rate across sites. Informs revenue-linked rent exposure in high-sales locations."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`realestate_cam_reconciliation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "CAM reconciliation financial metrics. Used by Real Estate Finance teams to manage landlord billing disputes, overpayments, and annual reconciliation outcomes."
  source: "`vibe_restaurants_v1`.`realestate`.`cam_reconciliation`"
  dimensions:
    - name: "cam_reconciliation_status"
      expr: cam_reconciliation_status
      comment: "Status of the CAM reconciliation (in-progress, complete, disputed) for workflow management."
    - name: "reconciliation_type"
      expr: reconciliation_type
      comment: "Type of reconciliation (annual, interim, final) for process categorization."
    - name: "dispute_flag"
      expr: dispute_flag
      comment: "Whether the reconciliation is under dispute. Segments disputed reconciliations for risk tracking."
    - name: "dispute_status"
      expr: dispute_status
      comment: "Current status of any dispute (open, resolved, escalated) for dispute resolution management."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the reconciliation for multi-currency financial reporting."
    - name: "cam_itemization_flag"
      expr: cam_itemization_flag
      comment: "Whether the landlord provided itemized CAM charges. Tracks transparency and audit readiness."
    - name: "reconciliation_year"
      expr: YEAR(period_start_date)
      comment: "Year of the reconciliation period for annual trend analysis."
  measures:
    - name: "total_reconciliations"
      expr: COUNT(1)
      comment: "Total number of CAM reconciliations processed. Baseline workload metric for Real Estate Finance."
    - name: "total_cam_billed"
      expr: SUM(CAST(cam_billed_amount AS DOUBLE))
      comment: "Total CAM amount billed by landlords. Measures gross CAM cost exposure before reconciliation."
    - name: "total_cam_final"
      expr: SUM(CAST(cam_final_amount AS DOUBLE))
      comment: "Total final CAM amount after reconciliation. Represents actual CAM cost obligation."
    - name: "total_cam_adjustments"
      expr: SUM(CAST(cam_adjustments_amount AS DOUBLE))
      comment: "Total CAM adjustments identified during reconciliation. Measures value recovered through audit."
    - name: "total_overpayment_credits"
      expr: SUM(CAST(overpayment_credit_amount AS DOUBLE))
      comment: "Total overpayment credits recovered from landlords. Tracks cash recovery from CAM audits."
    - name: "total_underpayment_due"
      expr: SUM(CAST(underpayment_due_amount AS DOUBLE))
      comment: "Total underpayment amounts owed to landlords. Tracks additional liability from reconciliation."
    - name: "total_cam_exclusions"
      expr: SUM(CAST(cam_exclusions_amount AS DOUBLE))
      comment: "Total CAM charges successfully excluded via lease protections. Measures value of lease negotiation."
    - name: "disputed_reconciliation_count"
      expr: COUNT(CASE WHEN dispute_flag = TRUE THEN 1 END)
      comment: "Number of reconciliations under dispute. Tracks landlord relationship friction and financial risk."
    - name: "avg_cam_adjustment_per_reconciliation"
      expr: AVG(CAST(cam_adjustments_amount AS DOUBLE))
      comment: "Average CAM adjustment per reconciliation. Benchmarks audit effectiveness across the portfolio."
    - name: "total_cam_cap_amount"
      expr: SUM(CAST(cam_cap_amount AS DOUBLE))
      comment: "Total CAM cap amounts across reconciliations. Measures value of negotiated CAM caps in leases."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`realestate_nro_project`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "New Restaurant Opening (NRO) project pipeline and capital metrics. Used by Development and Finance leadership to track opening timelines, capex performance, and pipeline health."
  source: "`vibe_restaurants_v1`.`realestate`.`nro_project`"
  dimensions:
    - name: "nro_project_status"
      expr: nro_project_status
      comment: "Current status of the NRO project (planning, permitting, construction, opened) for pipeline stage tracking."
    - name: "project_type"
      expr: project_type
      comment: "Type of NRO project (new build, conversion, relocation) for development strategy analysis."
    - name: "project_phase"
      expr: project_phase
      comment: "Current phase of the project for granular pipeline management."
    - name: "permitting_status"
      expr: permitting_status
      comment: "Status of permitting process. Tracks regulatory bottlenecks in the development pipeline."
    - name: "compliance_status"
      expr: compliance_status
      comment: "Compliance status of the NRO project for regulatory risk monitoring."
    - name: "risk_level"
      expr: risk_level
      comment: "Risk level assigned to the project (low, medium, high) for portfolio risk management."
    - name: "lease_type"
      expr: lease_type
      comment: "Type of lease associated with the NRO for financial structure analysis."
    - name: "target_opening_year"
      expr: YEAR(target_opening_date)
      comment: "Target opening year for pipeline timing and development cadence analysis."
  measures:
    - name: "total_nro_projects"
      expr: COUNT(1)
      comment: "Total NRO projects in the pipeline. Baseline development activity metric for leadership."
    - name: "total_capex_budget"
      expr: SUM(CAST(capex_budget_amount AS DOUBLE))
      comment: "Total budgeted capital for NRO projects. Core capital planning metric for CFO and Development VP."
    - name: "total_capex_actual"
      expr: SUM(CAST(capex_actual_amount AS DOUBLE))
      comment: "Total actual capital spent on NRO projects. Tracks capital deployment against budget."
    - name: "total_capex_committed"
      expr: SUM(CAST(capex_committed_amount AS DOUBLE))
      comment: "Total committed capital for NRO projects. Measures forward capital obligation in the pipeline."
    - name: "avg_capex_budget_per_project"
      expr: AVG(CAST(capex_budget_amount AS DOUBLE))
      comment: "Average budgeted capex per NRO project. Benchmarks development cost efficiency."
    - name: "capex_variance_total"
      expr: SUM(CAST(capex_actual_amount AS DOUBLE) - CAST(capex_budget_amount AS DOUBLE))
      comment: "Total capex variance (actual minus budget) across all NRO projects. Measures budget discipline in development."
    - name: "high_risk_project_count"
      expr: COUNT(CASE WHEN risk_level = 'high' THEN 1 END)
      comment: "Number of NRO projects classified as high risk. Flags pipeline concentration risk for leadership review."
    - name: "projects_with_certificate_of_occupancy"
      expr: COUNT(CASE WHEN certificate_of_occupancy_date IS NOT NULL THEN 1 END)
      comment: "Number of NRO projects that have received certificate of occupancy. Tracks construction completion rate."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`realestate_maintenance_work_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Facility maintenance cost and performance metrics. Used by Facilities and Operations teams to manage maintenance spend, response times, and vendor performance."
  source: "`vibe_restaurants_v1`.`realestate`.`maintenance_work_order`"
  dimensions:
    - name: "maintenance_work_order_status"
      expr: maintenance_work_order_status
      comment: "Status of the work order (open, in-progress, completed, cancelled) for workload management."
    - name: "issue_category"
      expr: issue_category
      comment: "Category of the maintenance issue (HVAC, plumbing, electrical, equipment) for cost-by-category analysis."
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level of the work order (critical, high, medium, low) for resource allocation decisions."
    - name: "warranty_claim_flag"
      expr: warranty_claim_flag
      comment: "Whether the work order is a warranty claim. Tracks warranty recovery to reduce net maintenance cost."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the work order costs for multi-currency reporting."
    - name: "work_order_month"
      expr: DATE_TRUNC('MONTH', reported_timestamp)
      comment: "Month the work order was reported for trend analysis of maintenance activity."
  measures:
    - name: "total_work_orders"
      expr: COUNT(1)
      comment: "Total number of maintenance work orders. Baseline facility maintenance activity metric."
    - name: "total_maintenance_cost"
      expr: SUM(CAST(total_cost AS DOUBLE))
      comment: "Total maintenance spend across all work orders. Primary facility cost KPI for Operations and Finance."
    - name: "total_labor_cost"
      expr: SUM(CAST(labor_cost AS DOUBLE))
      comment: "Total labor cost component of maintenance. Tracks workforce cost in facility operations."
    - name: "total_parts_cost"
      expr: SUM(CAST(parts_cost AS DOUBLE))
      comment: "Total parts and materials cost. Tracks supply chain cost in facility maintenance."
    - name: "avg_cost_per_work_order"
      expr: AVG(CAST(total_cost AS DOUBLE))
      comment: "Average cost per work order. Benchmarks maintenance efficiency and vendor pricing."
    - name: "total_labor_hours"
      expr: SUM(CAST(labor_hours AS DOUBLE))
      comment: "Total labor hours expended on maintenance. Tracks workforce utilization in facility operations."
    - name: "warranty_claim_count"
      expr: COUNT(CASE WHEN warranty_claim_flag = TRUE THEN 1 END)
      comment: "Number of work orders filed as warranty claims. Measures warranty recovery opportunity."
    - name: "critical_work_order_count"
      expr: COUNT(CASE WHEN priority_level = 'critical' THEN 1 END)
      comment: "Number of critical priority work orders. Tracks urgent facility issues that risk operations."
    - name: "avg_labor_hours_per_order"
      expr: AVG(CAST(labor_hours AS DOUBLE))
      comment: "Average labor hours per work order. Benchmarks maintenance complexity and technician efficiency."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`realestate_site_selection`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Site selection evaluation and pipeline metrics. Used by Real Estate and Development teams to assess site quality, investment returns, and pipeline conversion rates."
  source: "`vibe_restaurants_v1`.`realestate`.`site_selection`"
  dimensions:
    - name: "site_selection_status"
      expr: site_selection_status
      comment: "Status of the site evaluation (under review, approved, rejected, on-hold) for pipeline management."
    - name: "evaluation_stage"
      expr: evaluation_stage
      comment: "Stage of the evaluation process (initial screening, feasibility, final approval) for funnel analysis."
    - name: "lease_type"
      expr: lease_type
      comment: "Proposed lease type for the site for financial structure planning."
    - name: "risk_level"
      expr: risk_level
      comment: "Risk level assigned to the site evaluation for portfolio risk management."
    - name: "rejection_reason_code"
      expr: rejection_reason_code
      comment: "Reason code for site rejection. Identifies systemic barriers in the development pipeline."
    - name: "decision_year"
      expr: YEAR(decision_date)
      comment: "Year of the site decision for pipeline velocity trend analysis."
  measures:
    - name: "total_sites_evaluated"
      expr: COUNT(1)
      comment: "Total number of sites evaluated. Measures development pipeline activity and prospecting velocity."
    - name: "total_projected_annual_sales"
      expr: SUM(CAST(projected_annual_sales AS DOUBLE))
      comment: "Total projected annual sales across evaluated sites. Measures revenue potential in the development pipeline."
    - name: "avg_projected_roi"
      expr: AVG(CAST(projected_roi_percent AS DOUBLE))
      comment: "Average projected ROI across site evaluations. Key investment quality metric for Development and Finance leadership."
    - name: "avg_overall_site_score"
      expr: AVG(CAST(overall_site_score AS DOUBLE))
      comment: "Average overall site quality score. Benchmarks pipeline quality against historical approvals."
    - name: "total_projected_capex"
      expr: SUM(CAST(projected_capex_amount AS DOUBLE))
      comment: "Total projected capital investment for evaluated sites. Forecasts capital requirements from the pipeline."
    - name: "avg_auv_projection"
      expr: AVG(CAST(auv_projection AS DOUBLE))
      comment: "Average Annual Unit Volume projection across evaluated sites. Benchmarks expected revenue productivity."
    - name: "avg_traffic_score"
      expr: AVG(CAST(traffic_score AS DOUBLE))
      comment: "Average traffic score across evaluated sites. Measures customer accessibility quality of the pipeline."
    - name: "avg_cannibalization_risk_score"
      expr: AVG(CAST(cannibalization_risk_score AS DOUBLE))
      comment: "Average cannibalization risk score. Tracks portfolio self-competition risk in the development pipeline."
    - name: "avg_demographic_score"
      expr: AVG(CAST(demographic_score AS DOUBLE))
      comment: "Average demographic score across evaluated sites. Measures target customer density quality of the pipeline."
    - name: "avg_market_share_estimate"
      expr: AVG(CAST(market_share_estimate_percent AS DOUBLE))
      comment: "Average estimated market share for evaluated sites. Informs competitive positioning in new markets."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`realestate_capex_budget`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Capital expenditure budget tracking and variance metrics. Used by Finance and Real Estate leadership to manage capital allocation, budget revisions, and cost category performance."
  source: "`vibe_restaurants_v1`.`realestate`.`capex_budget`"
  dimensions:
    - name: "capex_budget_status"
      expr: capex_budget_status
      comment: "Status of the capex budget (draft, approved, active, closed) for budget lifecycle management."
    - name: "budget_type"
      expr: budget_type
      comment: "Type of capex budget (new build, remodel, maintenance) for capital allocation analysis."
    - name: "budget_phase"
      expr: budget_phase
      comment: "Phase of the budget (initial, revised, final) for amendment tracking."
    - name: "funding_source"
      expr: funding_source
      comment: "Source of capital funding (corporate, franchise, debt) for capital structure analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the budget for multi-currency capital reporting."
    - name: "budget_year"
      expr: YEAR(start_date)
      comment: "Year the budget period starts for annual capital planning analysis."
  measures:
    - name: "total_capex_budgets"
      expr: COUNT(1)
      comment: "Total number of capex budget records. Baseline capital project count metric."
    - name: "total_budget_amount"
      expr: SUM(CAST(total_budget_amount AS DOUBLE))
      comment: "Total approved capital budget amount. Primary capital allocation KPI for CFO and Real Estate VP."
    - name: "total_budget_revisions"
      expr: SUM(CAST(budget_revision_amount AS DOUBLE))
      comment: "Total budget revision amounts. Measures scope creep and budget discipline across capital projects."
    - name: "total_land_cost"
      expr: SUM(CAST(land_cost AS DOUBLE))
      comment: "Total land cost component across all capex budgets. Tracks real estate acquisition cost in capital plans."
    - name: "total_building_shell_cost"
      expr: SUM(CAST(building_shell_cost AS DOUBLE))
      comment: "Total building shell construction cost. Tracks core construction spend in capital plans."
    - name: "total_ffe_cost"
      expr: SUM(CAST(ffe_cost AS DOUBLE))
      comment: "Total Furniture, Fixtures and Equipment cost. Tracks FF&E investment across the capital portfolio."
    - name: "total_technology_cost"
      expr: SUM(CAST(technology_cost AS DOUBLE))
      comment: "Total technology investment in capex budgets. Tracks digital and tech infrastructure spend."
    - name: "total_soft_costs"
      expr: SUM(CAST(soft_costs AS DOUBLE))
      comment: "Total soft costs (architecture, permits, legal) in capex budgets. Tracks non-construction overhead."
    - name: "avg_budget_per_project"
      expr: AVG(CAST(total_budget_amount AS DOUBLE))
      comment: "Average capex budget per project. Benchmarks investment size across the capital portfolio."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`realestate_trade_area`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Trade area demographic and competitive metrics. Used by Real Estate and Marketing teams to evaluate market quality, competitive density, and revenue potential of site trade areas."
  source: "`vibe_restaurants_v1`.`realestate`.`trade_area`"
  dimensions:
    - name: "trade_area_status"
      expr: trade_area_status
      comment: "Status of the trade area analysis (active, archived, under review) for data currency management."
    - name: "geographic_region"
      expr: geographic_region
      comment: "Geographic region of the trade area for regional market analysis."
    - name: "city"
      expr: city
      comment: "City of the trade area for local market benchmarking."
    - name: "state"
      expr: state
      comment: "State of the trade area for state-level market analysis."
    - name: "methodology"
      expr: methodology
      comment: "Methodology used to define the trade area (drive-time, radius, custom) for analytical consistency."
    - name: "data_vintage_year"
      expr: YEAR(data_vintage_date)
      comment: "Year of the demographic data vintage for data freshness assessment."
  measures:
    - name: "total_trade_areas"
      expr: COUNT(1)
      comment: "Total number of trade areas analyzed. Baseline market coverage metric."
    - name: "avg_median_household_income"
      expr: AVG(CAST(median_household_income AS DOUBLE))
      comment: "Average median household income across trade areas. Key demographic quality metric for site selection."
    - name: "avg_population_density"
      expr: AVG(CAST(population_density_per_sq_mile AS DOUBLE))
      comment: "Average population density per square mile. Measures customer base density for revenue potential assessment."
    - name: "avg_projected_auv"
      expr: AVG(CAST(projected_auv AS DOUBLE))
      comment: "Average projected Annual Unit Volume across trade areas. Benchmarks revenue potential of market areas."
    - name: "avg_cannibalization_risk_score"
      expr: AVG(CAST(cannibalization_risk_score AS DOUBLE))
      comment: "Average cannibalization risk score across trade areas. Tracks self-competition risk in the portfolio."
    - name: "avg_market_share_score"
      expr: AVG(CAST(market_share_score AS DOUBLE))
      comment: "Average market share score across trade areas. Measures competitive positioning in each market."
    - name: "avg_income_per_capita"
      expr: AVG(CAST(average_income_per_capita AS DOUBLE))
      comment: "Average per capita income across trade areas. Informs pricing strategy and menu mix decisions."
    - name: "avg_primary_drive_time_minutes"
      expr: AVG(CAST(primary_boundary_drive_time_minutes AS DOUBLE))
      comment: "Average primary trade area drive time in minutes. Measures customer convenience and catchment area size."
    - name: "avg_employment_rate"
      expr: AVG(CAST(employment_rate_percent AS DOUBLE))
      comment: "Average employment rate across trade areas. Tracks economic health of markets for demand forecasting."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`realestate_rent_schedule`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Rent schedule and occupancy cost metrics. Used by Real Estate Finance teams to manage scheduled rent obligations, escalation tracking, and IFRS 16 lease accounting."
  source: "`vibe_restaurants_v1`.`realestate`.`rent_schedule`"
  dimensions:
    - name: "payment_status"
      expr: payment_status
      comment: "Payment status of the scheduled rent (paid, pending, overdue) for cash flow management."
    - name: "lease_accounting_classification"
      expr: lease_accounting_classification
      comment: "IFRS 16 / ASC 842 classification (operating vs. finance) for lease accounting compliance."
    - name: "escalation_type"
      expr: escalation_type
      comment: "Type of rent escalation (fixed, CPI, percentage) for future cost forecasting."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the rent schedule for multi-currency financial reporting."
    - name: "sales_reporting_required_flag"
      expr: sales_reporting_required_flag
      comment: "Whether sales reporting is required for percentage rent calculation. Tracks compliance obligations."
    - name: "billing_period_month"
      expr: DATE_TRUNC('MONTH', billing_period_start_date)
      comment: "Billing period month for trend analysis of scheduled rent obligations."
  measures:
    - name: "total_scheduled_rent_records"
      expr: COUNT(1)
      comment: "Total number of rent schedule records. Baseline obligation tracking metric."
    - name: "total_base_rent_scheduled"
      expr: SUM(CAST(base_rent_amount AS DOUBLE))
      comment: "Total base rent scheduled across all periods. Core occupancy cost obligation metric for Finance."
    - name: "total_occupancy_cost"
      expr: SUM(CAST(total_occupancy_cost AS DOUBLE))
      comment: "Total all-in occupancy cost (rent + CAM + tax + insurance). Primary occupancy cost KPI for CFO."
    - name: "total_cam_scheduled"
      expr: SUM(CAST(cam_amount AS DOUBLE))
      comment: "Total CAM charges scheduled. Tracks operating expense pass-through obligations."
    - name: "total_percentage_rent"
      expr: SUM(CAST(percentage_rent_amount AS DOUBLE))
      comment: "Total percentage rent obligations. Tracks revenue-linked rent exposure across the portfolio."
    - name: "total_rou_asset_depreciation"
      expr: SUM(CAST(right_of_use_asset_depreciation AS DOUBLE))
      comment: "Total ROU asset depreciation scheduled. Key IFRS 16 income statement metric for Finance."
    - name: "total_lease_liability_reduction"
      expr: SUM(CAST(lease_liability_reduction AS DOUBLE))
      comment: "Total lease liability principal reduction scheduled. Tracks balance sheet deleveraging from lease payments."
    - name: "avg_occupancy_cost_percentage"
      expr: AVG(CAST(occupancy_cost_percentage AS DOUBLE))
      comment: "Average occupancy cost as a percentage of sales. Critical efficiency ratio for restaurant profitability."
    - name: "avg_rent_per_square_foot"
      expr: AVG(CAST(rent_per_square_foot AS DOUBLE))
      comment: "Average rent per square foot. Benchmarks space cost efficiency across the portfolio."
    - name: "total_real_estate_tax"
      expr: SUM(CAST(real_estate_tax_amount AS DOUBLE))
      comment: "Total real estate tax obligations scheduled. Tracks tax pass-through cost component."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`realestate_facility`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Operational and financial overview of facilities"
  source: "`vibe_restaurants_v1`.`realestate`.`facility`"
  dimensions:
    - name: "facility_type"
      expr: facility_type
      comment: "Type of facility (e.g., restaurant, office)"
    - name: "ownership_type"
      expr: ownership_type
      comment: "Ownership classification"
    - name: "year_built"
      expr: year_built
      comment: "Year the facility was built"
    - name: "site_id"
      expr: site_id
      comment: "Site identifier for the facility"
    - name: "facility_status"
      expr: facility_status
      comment: "Current operational status"
  measures:
    - name: "total_square_footage"
      expr: SUM(CAST(square_footage AS DOUBLE))
      comment: "Aggregate square footage of facilities"
    - name: "average_condition_score"
      expr: AVG(CAST(condition_score AS DOUBLE))
      comment: "Average condition score across facilities"
    - name: "average_yield_percentage"
      expr: AVG(CAST(yield_percentage AS DOUBLE))
      comment: "Average yield percentage"
    - name: "total_cam_charges"
      expr: SUM(CAST(cam_charges AS DOUBLE))
      comment: "Total CAM charges incurred by facilities"
    - name: "total_capex_spent"
      expr: SUM(CAST(capex_spent AS DOUBLE))
      comment: "Total capital expenditures spent on facilities"
    - name: "facility_count"
      expr: COUNT(1)
      comment: "Number of facility records"
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`realestate_lease`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Key financial and term metrics for leases"
  source: "`vibe_restaurants_v1`.`realestate`.`lease`"
  dimensions:
    - name: "lease_status"
      expr: lease_status
      comment: "Current status of the lease"
    - name: "lease_type"
      expr: lease_type
      comment: "Classification of lease (e.g., gross, net)"
    - name: "landlord_id"
      expr: landlord_id
      comment: "Identifier of the landlord"
    - name: "site_id"
      expr: site_id
      comment: "Site where the lease is located"
  measures:
    - name: "total_base_rent_amount"
      expr: SUM(CAST(base_rent_amount AS DOUBLE))
      comment: "Total annual base rent across all leases"
    - name: "average_base_rent_amount"
      expr: AVG(CAST(base_rent_amount AS DOUBLE))
      comment: "Average base rent per lease"
    - name: "total_cam_charges_annual"
      expr: SUM(CAST(cam_charges_annual AS DOUBLE))
      comment: "Total annual CAM charges across leases"
    - name: "average_cam_charges_annual"
      expr: AVG(CAST(cam_charges_annual AS DOUBLE))
      comment: "Average annual CAM charge per lease"
    - name: "average_rent_escalation_rate"
      expr: AVG(CAST(rent_escalation_rate AS DOUBLE))
      comment: "Average rent escalation rate applied to leases"
    - name: "lease_count"
      expr: COUNT(1)
      comment: "Number of lease records"
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`realestate_site`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core financial and performance indicators for real estate sites"
  source: "`vibe_restaurants_v1`.`realestate`.`site`"
  dimensions:
    - name: "site_type"
      expr: site_type
      comment: "Classification of site (e.g., restaurant, drive-thru)"
    - name: "ownership_status"
      expr: ownership_status
      comment: "Ownership arrangement of the site"
    - name: "city"
      expr: city
      comment: "City where the site is located"
    - name: "state_province"
      expr: state_province
      comment: "State or province of the site"
    - name: "country_code"
      expr: country_code
      comment: "Country code of the site"
    - name: "lifecycle_stage"
      expr: lifecycle_stage
      comment: "Current lifecycle stage (e.g., development, operational)"
    - name: "site_open_year"
      expr: DATE_TRUNC('year', opening_date)
      comment: "Year the site opened"
  measures:
    - name: "total_monthly_base_rent"
      expr: SUM(CAST(monthly_base_rent AS DOUBLE))
      comment: "Aggregate monthly base rent across sites"
    - name: "total_monthly_cam_charges"
      expr: SUM(CAST(monthly_cam_charges AS DOUBLE))
      comment: "Aggregate monthly CAM charges"
    - name: "total_projected_auv"
      expr: SUM(CAST(projected_auv AS DOUBLE))
      comment: "Total projected average unit volume"
    - name: "total_total_capex_investment"
      expr: SUM(CAST(total_capex_investment AS DOUBLE))
      comment: "Total capital investment across sites"
    - name: "average_visibility_score"
      expr: AVG(CAST(visibility_score AS DOUBLE))
      comment: "Average visibility score of sites"
    - name: "site_count"
      expr: COUNT(1)
      comment: "Number of site records"
$$;